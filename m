Return-Path: <linux-kernel+bounces-729640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56810B0398E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF603A9654
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57F236A9F;
	Mon, 14 Jul 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oga55JME"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15F23505E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481656; cv=none; b=GjUenVfxxc4TtNiZXTu2lkXwQi2m/CUeo2Y5L6rVlziF+nvJ5gJDXdWMWRQlZWQfznF5m4vtvfdQO4K7yn9M5KyB0drWuTazMRTB1+5gXUcj5fzsK5bdjYiusCX1WTWdXuM8b+YMh0Crty9HfZk4sTtWM6jqmcbKoOoG3Ry1/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481656; c=relaxed/simple;
	bh=n0mqlWpY6iYEhUAbDIIII3T1/kHWAg15z9VBXI+5sPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c/ehTmD9XAgPcD3IqztEPMk/ESFV4NPLGLCUtrVL8ZbyjzPtvaiKEaqCBDCj30WjsBuC1WpjcjFro6fLME4l1xUe7pMBU1zYK2AdVmlCP5OYJgkLBu3sPZjmg3/2uu2hG1lC0b5BC5NXPj5bIYzLvlrjhWe6mnRZXzI103ZjFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oga55JME; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45348bff79fso48366265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481653; x=1753086453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XlkOb/BaxgVjTb0HLtso5x03D3EKs4f3mraPX3e6jHY=;
        b=Oga55JMEHlwu7G1zdFJsA5YkkxrngAXEV71aqYcLJ3nRu/6pOhVboGY6H3F6hxW9QV
         D4t5TdjDdi6GBnrW1kGgVvRVaTqjNuLciySClJKV1HvtEI4zTFbFKesJCnj1XMKFbNFX
         yLFnsMOFiihN23iksx/wy+zMX0NdU7JIEa0MOxqgxuGnpIm3R04vIwFd/Y/mzm9Jy2kS
         dAKbtJ++YeYcCORPxxKxDBF7IdBbAsGMO/i6gSeLx+jF01vgBWzb5wytqEbCjOGdWlv6
         H2hvvj+QKOES3sfl+2sSqSoC67YbkhxATQgSxFol4IynQ3dT6ORjOIDg8tjW2hzJnsF0
         fbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481653; x=1753086453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlkOb/BaxgVjTb0HLtso5x03D3EKs4f3mraPX3e6jHY=;
        b=VvO3RGPxONsEq8ffILlgZ0jWn9bLPp6isvNn9wqf6Sc/bhS3kikI8axzv/DuUKGrOb
         x2HkRSDmIJvTiyefsNmz5uHFJwXlvuHCT2aGcvA6kiENVCEzZLsjYclnHvsaVHIqtDXY
         O8oJxaYx3y1OhLJjp3HKCr3Xmr+2m5MeLdlj6x9v08os9PHH2CDnCg98c1DTyFdlOCdK
         vmIQlNbaRRN9aNAzfPPDFdgeJEJXXuJHIDMkV/VpizON/cmbZS54NGxz6m+60tcPq/Da
         cI0/nfc5yGh3ewycrZ5P4qEIMkmMyBFzTSiIoNhNjN5CEolmX9oWu0B83BqsGqdqovJ6
         OGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXbKfWdl1Dc6sMp/a/Yw/Gk8oUZ2NC0O8KVo9jOr7hwdcULgBCdZQA3ohSZQSv6ZBGWG6YDDbHtjccEDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOBDDXPpZClSW1cizZnMc9aN6oZEIMbQGs6gS3znZJJL5n4kH
	XQca1au4V95q9eKYpjJ3OyyhjgRgREO3wqkbqnyNJ9GMnO5Sxmory57S
X-Gm-Gg: ASbGnctEfeEk3Thf3oXPFL6EzOzekSdIhcm7gZ3q3mUlQw0NiSgB2CQz4QjY169Kkmi
	1Np42rZ2inH42AYDfrPdipQJ4z9ufryGWW0ubxmY8sM6oSPjQ6EpPrFB38vsO7hUgKv9IXTAf7z
	2geYeg2iBHznM0byUFYyj6uyhGQhPKxjc2fiFWpc9v5WEb6OwHKmoYeAX8gcxSZs+fmp2Pf/RtR
	O75z+mpruSygs8b4BsgcDIyXgEchVa+cy8VYZ78WSCLBIoQsdXeYfnHCMw51yWW61x4QkrDCVyV
	Z1EDhh3vXFTTZcDbBrC4P0CRE5THMO00brZ0/78Zh/GI/QxToOgLXfMbGc8Z/nsOkX9Fa1FYgab
	w+E1CcsUKgR5Ts4EVkEO5V8X/z8yikgZkvMU=
X-Google-Smtp-Source: AGHT+IG0lsPDDH01uvYhuI1TBgoC6NE04G2xN3b8TeEz3+jzpoFFX9gG3ukSqsPryWZ/+tFmBJkiUw==
X-Received: by 2002:a05:600c:1d9b:b0:456:19be:5cc with SMTP id 5b1f17b1804b1-45619be0cb2mr28701115e9.14.1752481652742;
        Mon, 14 Jul 2025 01:27:32 -0700 (PDT)
Received: from [10.211.145.87] ([170.61.237.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560d019f1esm61252775e9.10.2025.07.14.01.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 01:27:32 -0700 (PDT)
Message-ID: <ba590f40-0ada-44b1-b51d-51cd452066dd@gmail.com>
Date: Mon, 14 Jul 2025 10:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING at drm_gem_object_handle_put_unlocked+0xaa/0xe0
To: Thomas Zimmermann <tzimmermann@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, christian.koenig@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>
References: <04b26880-202e-428d-8aa2-cf83210ae72a@gmail.com>
 <b18cf3cf-eed1-4a30-9d01-3ea3015e126e@gmail.com>
 <05b62107-902f-496a-aa0a-e9c3b38a7552@suse.de>
Content-Language: en-US, pl
From: =?UTF-8?Q?Jacek_=C5=81uczak?= <difrost.kernel@gmail.com>
In-Reply-To: <05b62107-902f-496a-aa0a-e9c3b38a7552@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Thomas,

On 7/14/25 9:08 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.07.25 um 12:05 schrieb Jacek Łuczak:
>> Hi,
>>
>>> While checking on this issue I've found[2] and applied the patch 
>>> posted by Thomes which fixed the issue.
>>>
>> After a longer use I find this is causing some weird graphics behavior 
>> notably an attempt to start Wayland session sometimes timeouts with no 
>> errors in the logs but e.g. reboot fails with attached errors (CC 
>> @Mario).
>>
>> If I'll find some time to bisect the original issue I'll report it back.
> 
> You might be seeing the same epoll error that Linus saw and that is 
> mentioned in the -rc6 announcement.

In meantime I've picked the latest drm set for rc6 and all works fine.

Cheers,
-Jacek


> 
> Best regards
> Thomas
> 
>>
>> Regards,
>> -jacek
> 


