Return-Path: <linux-kernel+bounces-826688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68103B8F1E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BAB189DFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19226298CD5;
	Mon, 22 Sep 2025 06:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FxYfeYpH"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0E256C83
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522123; cv=none; b=PcAwVY20NR7ABCVU1d760nNI0ZiKKdN98gJp/1bwHip7E543ssy2WnJNko5fQej4CkIAdl5NHIOjJCjXOWkVd0/+MvSB7dGkGTRCpJ/3of+I3oYFsaFMgFQMgZG+7H6mBvZ8OjuL4ihGQ3t3kgqzi5fGxFQ23AlSJFBrl4AjNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522123; c=relaxed/simple;
	bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
	h=Mime-Version:In-Reply-To:From:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL8gGXTlgBhW+zMFsDiccHUiSYL2HQmT+1kl+m0zgVVGftJFq+VXn2LrjP9bseOYchdn/bXwmnuSl1CfkgMnISio0hg1zXz3fKWQgtIwyJhbUGSiTNmqAUhF9l2zv9QHEUESvJhZqi7d+nepx0aD4EJiRYPKhksmFY+62C0mRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FxYfeYpH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5b96d2488so2844509276.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758522121; x=1759126921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:references:from
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
        b=FxYfeYpHaKHeup202awRg2FDFKafLZoHcKLbZ9avm2jZbJSdN6Z5Xobxaa8O/ABZmB
         wPcQC5bUkEWE4vs5EiK18PY9UCR3V/sx8MdnVw+uTqMayS88+7cN1xukGY04w2jXqzB9
         E8I+xLhAwH+51YB7aS17j2tix2BRK7rRKik8gV688kjk6JLajUNqWdpqhiqQ+/sMqvyG
         YjLaPo2iigxaRdxwGWpLdLbx02p1dXDqghJ0hcM+S8h9bsCNHZdi5y49Fm/gZItBjOIj
         JN1HUI+a+TOCldjDU8qkVb5EhqxmspPoEZNBOPBV/rwqu04wIuGIjIXahpoqGeOKB16f
         pqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522121; x=1759126921;
        h=cc:to:subject:message-id:date:user-agent:references:from
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJCL5BEPcUDkaY186ZiSz1N6maZ/1QO2mHIcYWEJb5g=;
        b=IXesV+OAg6+EMWWKTWy+M2YaHGzdyl+MJEkdjJRgfjmEv/uDWseq6raQ45zCulbDZ9
         r5pnXMiN4pKqvMhP6XpqzS6+XiDYx6IIJFf0OAiPy3lfS6QZunwdSoXaLDKRi1OXf8mK
         Yxk7sH8dhj02lHi3dPMmrxWsW+dFbBeaAcuk/8Xh2aY/KJTKdzZ6bIZjBOusZwRDYcgq
         TiPjZNMGQ2xXVn1TUKoWlZ0RLz4pZjWl/R9tzLfHqD5lLMyuPae04EPaEGAyWDn6s6Cp
         e613FF6DbAv52/gvakFdlMbgGQ8OdXuybeFrikGjogaxm5pmNvDmmh4hE1RDM5EpujuR
         dj+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/gj8s9zCMUys/BqKn7EReA8X7QInq2B2qc4IytlMGZ5cVNJ7HjTMe+naZbmveRp7TBVCp4aVMMh7pAEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR67B8lh5iUdEgURrE0G0DCHR0DnukIGaTdGr26hGt3v4X4vRE
	KFJl42uwc9rOhGaGKy4uUQLDc0ubO4dToBp4uTRNUdffi0NOt4phs5g+tJZ+R+m1Q0WRpZRp89U
	P6HV+hj4VJNNR/xiRQMD5VFZEdf9BqyTrYU7Hx/EZ4Q==
X-Gm-Gg: ASbGncuDv+88/0UXYXzLVeO/NqajKw84dY4aHoRFYzL/IanSD+z/Ntc7xmAQrD7mVpc
	djmX3NECXx8kDFizsEWPA2YXlB+oKaR5Hee/BvLZd4ysbjO2/ZbTQCNtsVoOgumxo9NZhaSKzFy
	wm/LKEo1LOSFUznDaKqoOb1a38/bTgiFDHCY6/7lK7jrOZhKWk61Z5momu5phBHjXs/J/hOpadp
	gN8VBVuXw==
X-Google-Smtp-Source: AGHT+IHhXNBQkZKHusfqahAqxM1ALfuXESEXOtvpI4K6U0wS4nO9F3zMYGz5W6IsEBxhXvfLKW+/GTAzoL105VPYcCU=
X-Received: by 2002:a05:690e:2505:20b0:630:8fd5:4cd9 with SMTP id
 956f58d0204a3-6347f5d0343mr7947322d50.36.1758522120671; Sun, 21 Sep 2025
 23:22:00 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 21 Sep 2025 23:22:00 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 21 Sep 2025 23:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <SA1PR11MB7130D0C4D54EBAD854CB18B68911A@SA1PR11MB7130.namprd11.prod.outlook.com>
From: Rui Qi <qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
References: <20250918121704.45116-1-qirui.001@bytedance.com> <SA1PR11MB7130D0C4D54EBAD854CB18B68911A@SA1PR11MB7130.namprd11.prod.outlook.com>
User-Agent: Mozilla Thunderbird
Date: Sun, 21 Sep 2025 23:22:00 -0700
X-Gm-Features: AS18NWC7ydSo-Pbyk19l4vC7zCVBkL-thS0EJngVcF_Vzt340CAkOsiiQC93ouE
Message-ID: <CALU4DmqEF4qbWdz5E6wo_XrWXKpYNfCzTrENCj2jH=DaZOzftQ@mail.gmail.com>
Subject: Re: [External] RE: [PATCH] EDAC/skx_common: Fix allocation check when
 adxl_component_count is 0
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>, 
	"bp@alien8.de" <bp@alien8.de>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"james.morse@arm.com" <james.morse@arm.com>, "rric@kernel.org" <rric@kernel.org>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On 9/19/25 8:56 PM, Zhuo, Qiuxu wrote:
> Hi Rui Qi,
>
> Thanks for looking at the code.
>
>> From: Rui Qi <qirui.001@bytedance.com>
>> [...]
>> Subject: [PATCH] EDAC/skx_common: Fix allocation check when
>> adxl_component_count is 0
>>
>> From: Rui Qi <qirui.001@bytedance.com>
>>
>> Use ZERO_OR_NULL_PTR instead of simple NULL check to properly handle the
>> case where adxl_component_count is 0, which would result in kcalloc
>> returning ZERO_SIZE_PTR rather than NULL.
>>
>> This ensures correct error handling when no ADXL components are present
>> and prevents potential issues with zero-sized allocations.
>
> If the ADXL component names are empty, skx_adxl_get() will immediately jump to error handling.
> So, the adxl_component_count value is guaranteed to be non-zero when passed to kcalloc().
>

Well, I've rechecked the code, and your statement is correct. So my
modification is indeed unnecessary.

>>
>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>> [...]

