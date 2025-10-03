Return-Path: <linux-kernel+bounces-840916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F689BB5B48
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11AA54E81CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7831B423C;
	Fri,  3 Oct 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW9ijn0S"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CA22EE5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453828; cv=none; b=VOpFpTHf6f6uY/DOJqvUk5C8KLI1lsoEZIWUxAzd20KVhJnUQiZFPdsj1TC6C+ItI5oHswIb9C6BdcYijzxbdU/zkSrZzMvwXhY20RWOGknLHvOrhxEQWM51eBtvJmyiOtOhLGGgw82qY7WmD8QUzB/zIX0oHng7iPSI7/QPAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453828; c=relaxed/simple;
	bh=CdOqw0jqGhjqvfdvMB++G6ffGqU0OXPp8Sn3Qur54MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfPLsOWJo87U67wJ5EMTfNOjo+HhsahdG/TXKpA4y8qTZEV88cRbqXSgKBKuL+oPuym/rMZidEEtTmv2/Q602/OS3H+jEf0VJVggpY02txrCPRm2av0jAbFaDVLG+t2qrACnXPKXPRwOJdAzd0fzmBta8q/ScM05g3fl6E5FypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW9ijn0S; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-635c9db8a16so1800021d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759453822; x=1760058622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzJCKHPM6QTtA9IBPdOyD8uwo14jSTrua8aQbb7Amgo=;
        b=WW9ijn0SxIa8Sd/OkI9W0DiTYrz3hL64QZ4Yr0UR+1TezMXX7Jr7IcO6siFH6cBlXz
         rgZQSyRHvXhXSuouKrjCzFMSu95yAvs7ZXdlmU6zKeZUj6XXr0Td2gKNZHSC8kTWMQl+
         mlWBwrYHx3Vfnq8dhQDxjHJEVxlykVa6NoJ463fvLSpx8OXUpduC2y8QrHKcGzNec1X6
         OVFV0jfb4iP1o5t4amRKflY/8YbbdbP24Pz+AgMYtdtCDTkolLElAbhA+LRtRYMCjWRG
         Erawl84KRjI0ZF1sgIsMnAesvn6yfWlLuCpT8J1nLZEQXU4j7c06LpmIBIQDMNzK9M/t
         qqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759453822; x=1760058622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzJCKHPM6QTtA9IBPdOyD8uwo14jSTrua8aQbb7Amgo=;
        b=l6hyL+sEqNP2yrFihByxJMNi2QxTteRmECvPZ0DGSeU4cfP2HCqa+F/HN0iwI1heqi
         kcW5Soj1NrtjtLTceUB9M0R1hQK0hZKAKxhThRrmdv1uh87lb+CIeiCZTx702cP+8I3r
         sWwLbHpGT+7pEcN5meuYIhhhXeMhCtDI8O3YhMFPl/h+z3UEY6aO41UagGIqZKHIHxU/
         6rluOj9ylAjOCFAmdkezLH2G12YMUujwTY8pcAIm5tqzVd2tDeBsywFhy+Az2tYKHTcI
         Qczrm2nzWwO5rF72WffJOIJj6dKf8YQkPU1Z1/OjcbotVhH8O3g1OQj0hiVqffoZh1mR
         /Vfw==
X-Forwarded-Encrypted: i=1; AJvYcCUtWFe1eGPVg2pLZjXPzwNvQhXS8cyjHCua62OKTQv58GBaHkiO6usM0XDCXt+NOMDsSrmIi5Y63SqAgiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oWVmP4FEOiHNJ3rTAVjxodXlqyY3UQRQOxzIvz8sljFh2H5+
	y5NKq7li2o5BeNWnBW0PebxxefHEHoriWB0mLLtGmZ0u5bUt/RTHlsHS8RQvKNPxl4nEWJ9AMvy
	TFcKOrU3PBcnbA3of8v00JAQ90eysNJ4=
X-Gm-Gg: ASbGncsR+w6rxwHr2b54MkTPTlKbSZ9rIAuFkreKdonZWPrzf7GwH/1viA5aAqqzD5f
	KmmZvftC/VSDWv56sp5ZLGh7+K1czIivRIBTHk9XOoCwYOvPDcMGMOn+xMNavsE9QYAUNroZzUH
	q1wO0bm3O+u/eVDSmNelxNHAalt5GXerplpmCCitv4Btqf7f4Cm2T9VPWF5KUJZiQ7MDgHPeBJP
	wSbYxhv5XqCjAKBrFP6XLaqxMfTZgs569x7w/icnmhHM/kA7UaceGuvSIBsR3GtH+yDA+4KVUIi
	gjwwvGsmld+w6u0ZOIxi
X-Google-Smtp-Source: AGHT+IGhFyNovFZudWbgyNTJM1cP5VEKsWyKGRAQ2seKmT9PyVKzUrv4X3nbOCtRIp6kxxbhaVatDZ1dKtcI2bVqXDQ=
X-Received: by 2002:a05:690e:1551:20b0:635:4ecf:bdcd with SMTP id
 956f58d0204a3-63b9a10b36cmr1224818d50.47.1759453822040; Thu, 02 Oct 2025
 18:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916200751.3999354-1-olvaffe@gmail.com> <aNUF6IDneKxjTP5t@e129842.arm.com>
In-Reply-To: <aNUF6IDneKxjTP5t@e129842.arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 2 Oct 2025 18:10:11 -0700
X-Gm-Features: AS18NWCwW3b0IIzlnAbY5dyiwisgJdl6Z6vOCM3TjRgYksz9Lm0FP6Hc8sMWoLs
Message-ID: <CAPaKu7Qo1N4iw+JAd-Kcq0GdAw6u0F83iwPjH-u1u406yxAQTA@mail.gmail.com>
Subject: Re: [PATCH] drm/panthor: add query for calibrated timstamp info
To: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com, 
	Lukas Zapolskas <lukas.zapolskas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:06=E2=80=AFAM Marcin =C5=9Alusarz <marcin.slusarz=
@arm.com> wrote:
>
> Hi Chia-I,
>
> On Tue, Sep 16, 2025 at 01:07:51PM -0700, Chia-I Wu wrote:
> > DRM_PANTHOR_DEV_QUERY_CALIBRATED_TIMESTAMP_INFO provides a way to query
> > and calibrate CPU and GPU timestamps.
>
> I worked on a similar patch for Panthor, with a plan of submitting
> it upstream soon, but with slightly different requirements, so maybe
> we could merge both efforts in a single patch?
Yeah, that should be the best!

>
> The first requirement was that it should be possible to get both CPU
> and GPU timestamps, with the expectation that they should be taken as
> close as possible (within 50us).
>
> The second requirement was that it should be possible to also get
> the value of GPU_CYCLE_COUNT register.
>
> What I did is extend the existing DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO
> query in backward compatible manner with those new fields and obtaining
> gpu and cpu timestamps with preemption and local irqs disabled (more on
> that later).
>
> Backward compatibility was achieved by adding new fields at the end of
> struct drm_panthor_timestamp_info, and relying on the fact that if user
> space passes smaller object it will be silently truncated.
I chose a new query because userspace does not zero-initialize
drm_panthor_timestamp_info. We will get garbage if we add an input
field to the struct.

But this is a non-issue if we agree to do it this way, and make sure
userspace zero-initialize before it updates the uapi header.

>
> Obtaining all kind of timing information with a single syscall might
> be a bit too much, when user space might be interested only in some
> data and not the complete view, so I'd propose this as a solution:
>
> 1) Extend existing query in backward compatible manner, by adding new
> fields at the end.
> 2) Add flags, cpu timestamp, cycle count, and duration.
> 3) Flags would be:
> DRM_PANTHOR_TIMESTAMP_GPU (1<<0)
> DRM_PANTHOR_TIMESTAMP_CPU (1<<1)
> DRM_PANTHOR_TIMESTAMP_OFFSET (1<<2)
> DRM_PANTHOR_TIMESTAMP_FREQ (1<<3)
> DRM_PANTHOR_TIMESTAMP_DURATION (1<<4)
> DRM_PANTHOR_TIMESTAMP_SAME_TIME (1<<5)
>
> DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC (0<<8)
> DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW (1<<8)
> DRM_PANTHOR_TIMESTAMP_CPU_REALTIME (2<<8)
> DRM_PANTHOR_TIMESTAMP_CPU_BOOTTIME (3<<8)
> DRM_PANTHOR_TIMESTAMP_CPU_TAI (4<<8)
>
> and DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK would be (7<<8).
>
> If flags is 0 it would become
> (DRM_PANTHOR_TIMESTAMP_GPU |
>  DRM_PANTHOR_TIMESTAMP_OFFSET |
>  DRM_PANTHOR_TIMESTAMP_FREQ)
It is more typical to have NO_GPU/NO_OFFSET/NO_FREQ, but I think
handling 0 specially can work too.

>
> For VK_KHR_calibrated_timestamps flags would be set as
> (DRM_PANTHOR_TIMESTAMP_GPU |
>  DRM_PANTHOR_TIMESTAMP_CPU |
>  DRM_PANTHOR_TIMESTAMP_DURATION |
>  DRM_PANTHOR_TIMESTAMP_SAME_TIME |
>  (raw ? DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW : DRM_PANTHOR_TIMESTAMP_C=
PU_MONOTONIC))
>
> 4) The core of the functionality would query all required timing
> information with preemption and irqs disabled iif SAME_TIME flag is set.
> Probably we should exclude OFFSET and FREQ from that.
>
> Why also interrupts disabled?
> Recently we discovered that unrelated devices can raise interrupts for
> so long that the assumption of timestamps being taken at the same time
> completely breaks down (they are hundreds of microseconds apart).
>
> What do you think?
I am happy to use your version. Do you plan to work on the userpsace
change as well? Otherwise, I can update my userspace change to use
your version as well.

