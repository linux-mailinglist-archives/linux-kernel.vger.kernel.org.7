Return-Path: <linux-kernel+bounces-836590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34695BAA1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52031C5CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B712F9DBF;
	Mon, 29 Sep 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtU1xdUl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7E211706
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165974; cv=none; b=Lut8a3y6XWIvN0yDPlw+RT1pA4nouMUxJ7dDC3rzK9M+9JD1LzLXI0q2klXIYO9EYVv0InWeM/PPNZZVYMABe36HC5CSY3wtwfcHtbAcVwCWlnP/BAjIq5gmsAEt5rBPR2F0J90MRcCjpNGHCsu95Ymmg1TJ7V+K+wYzyIm29n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165974; c=relaxed/simple;
	bh=RxzJ3V59Wq07N2UF1FootK0iy/AYJKV6am0zJXLq4y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5TWy/NuhhFGmzra5SACxLX7qu6CC3Y9QVBynFOiYowg4LccRAUTH5YoZM2MHdlw2o7BAiRUH8bycsncOhQHWG3kDe2AIqgVzaFNDWMstgXxE/C9DjY3tl8CiGwrZ1TK++YtsLvUxUZvfUZAq+fWDZFJmWdEhRAtvp7IUocngo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtU1xdUl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so4905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759165970; x=1759770770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxzJ3V59Wq07N2UF1FootK0iy/AYJKV6am0zJXLq4y4=;
        b=dtU1xdUltyL7pGD4bKGs56FN4f4h4h3MnkFXdsGFEtZIO5PhL1mhMQneU9iDInO4+Q
         MnH82suSoIi8iYcau/70gLprx3FYLt9gYrIf8VK6ZmxnwaYk79DB/F2vl9iwLUfNXeMw
         OjjB5LpOEERmgNc/vOXzsVtWQkrO8r5dkkSdHnrCCg10x56TVOSiOgYivBbTNu+wXuD6
         kvzHCJeBbCXD9JphahS45cmOpcXAaTFspYRF7D6ivw5CzkfYGmvjA1jaNZFDZqIHDmKc
         4M3L18cnM0A2IsREKCtrUyRVXRQZN0KOXVXIUWa/rFwPuQnwqT6X0OVpPeLlXSbg6/fs
         f4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759165970; x=1759770770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxzJ3V59Wq07N2UF1FootK0iy/AYJKV6am0zJXLq4y4=;
        b=gx54Bkv8JBeKJW/iQPfMG2969MG4MrwfAIpuUzixLrcTUUFjM75XwRHlWnrfCTvUFf
         usha0NY1Jz80ZPKsR+Rj2fkV+ZhqXofZt6yfPYZHQZwu9u7LUjfqa7+Xp78qBc+ufcrA
         kR6C6nQMjFMc2tlnILhwv7ZS6EbinL22F/xcjYimfLsuYdn2VZ0OVTKaHLrqPJRLbFzF
         JR7AtOFaj9BCSngLvmfsHXf8Zf4EcSaczcaWJmtkkigR2ElKdxCLIr9d5RMx7VT88EU+
         us4ZmAeP/9V8LZL2PWtBnoCjsS2PEWQR/mP18pE6HBRyzWC6/pg02Shyk4lLR6zMzJgK
         OkSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/rkJCbuTD5C+H9ZjXIzMn80ckXotXXlpGQtpWHrLhcUePfdKDnKzXsUFz80rSvaynCmemTCg2apSHX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYm/2xLXbFug4dRIUldqo0nSa00K05hiJs2VZR42IKVE7Nqdvy
	M2hX0f9pp5diHC9yZCKJBH5VX2SovHTIqSszHuZePYDmoAf3oyfGUV6PummFlyTJX6eTQaPXhR4
	8UQ/YX2/XdHDWDw1bHK8fRyKcI8375ujAcl5RJZUl
X-Gm-Gg: ASbGncvSDUKzoyTcogmZrDbjmqlF+RfcQE99jlCRP9/MDTndUB5OvUQZ/tNCc87MHI4
	USm8p8cthOirCocCaeQl64wLYWw7BqHgWJxBK7AAYbPSl1pkWX4QTr9lnphP72mJlmJdWYJcUhR
	2L4qVn189uXf/06mECc/rH4WiW+MCjktQc8KPha2xWhFU4+lqhIx2IwGcOKdVY1EXAgX0thj2bA
	3wcYqtS+O6bEbb7JFp5OqEbUoxWO5R2XIp7ZJhFcxkCGZsnlCFQw/k=
X-Google-Smtp-Source: AGHT+IHuXk7tF9uyvP66Y90iG/J00lH10kBj+6dab2+LuAQqHLajcGPj7GtkYecbTtF2P7ExU+uwVoqwqJXRsCKEXnM=
X-Received: by 2002:a05:600c:b96:b0:45f:2db6:5202 with SMTP id
 5b1f17b1804b1-46e59d575abmr127225e9.3.1759165970340; Mon, 29 Sep 2025
 10:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818071304.1717183-1-elena.reshetova@intel.com>
 <287a2652-bce6-4084-b9b5-c8feb24a2940@intel.com> <CAGtprH8rPg30gsrhJ9=44uaePqf-Ay=R+O_+D8isH8TzM4uQXQ@mail.gmail.com>
 <DM8PR11MB5750C11091D7D90B60FE7853E71BA@DM8PR11MB5750.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB5750C11091D7D90B60FE7853E71BA@DM8PR11MB5750.namprd11.prod.outlook.com>
From: Nataliia Bondarevska <bondarn@google.com>
Date: Mon, 29 Sep 2025 10:12:38 -0700
X-Gm-Features: AS18NWCPRPmMCeBb-Zmpa-uN-Xth9-St2ynSE-WMaV_w5mb5bSlDTu7VsGJHWDI
Message-ID: <CAFbLv2dbF4=vEvuqKFweRR5P6qtm+E7U29=f2ByM552j6fd9Vw@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] Enable automatic SVN updates for SGX enclaves
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Annapurve, Vishal" <vannapurve@google.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"jarkko@kernel.org" <jarkko@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "mingo@kernel.org" <mingo@kernel.org>, 
	"linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"Mallick, Asit K" <asit.k.mallick@intel.com>, 
	"Scarlata, Vincent R" <vincent.r.scarlata@intel.com>, "Cai, Chong" <chongc@google.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "Raynor, Scott" <scott.raynor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Nataliia Bondarevska <bondarn@google.com>

On Mon, Sep 29, 2025 at 12:18=E2=80=AFAM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>
> > On Fri, Sep 5, 2025 at 12:37=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 8/18/25 00:11, Elena Reshetova wrote:
> > > > Testing
> > > > -------
> > > >
> > > > Tested on EMR machine using kernel 6.17.0_rc1 & sgx selftests.
> > > > Also tested on a Kaby Lake machine without EUPDATESVN support.
> > > > If Google folks in CC can test on their side, it would be greatly
> > > > appreciated.
> > >
> > > Yeah, lots of @google.com addresses on Cc, but there's a dearth of ta=
gs
> > > from those addresses.
> >
> > Apologies for the delay on this one, Elena. We will get back on this
> > early next week.
>
> Hi Vishal,
>
> Do you have an update on this?
>
> Best Regards,
> Elena.

