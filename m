Return-Path: <linux-kernel+bounces-894959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED99C4C901
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936421888A91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033C32E14F;
	Tue, 11 Nov 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="kdyibVZh"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761B2F1FD7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762851947; cv=none; b=VcfALQR1ao9wEeuXB5rXp/AYiyBuyEkHaLe/q/7AWjHhUQM7v4crIatz9cPdH93L8JXkdgCgUhjXij0WOajwOjvN97gEuyyVWqHyZHa51SKLZ5JVSlZ6FuTEFNHjEu3Kc9UEhljLrgFT/A7JFXHKA8sCC0uqudMC6IMsFfVpWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762851947; c=relaxed/simple;
	bh=QF6aQ3IdMCUuQqVHJbHPgyORjRtZpqrwMPpiV3AGqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuPfSjNdjPgNgC5WRGKYP7oM7hwqsjEKsoGPBTsrLma+6y6IQybPpzRj7sTzj/GUxKFFSRLe6lFzLiAuznC1f9weyZDSxU8yVVyw4AfDaLpAbGvO9YhNbOfSFj8zblXyeCF/77bWsSJFRGGrATHNILkgNJQnDRUgLEs6eRBaCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=kdyibVZh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7aad4823079so3596822b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762851945; x=1763456745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDlWYzAyw7NsYv6KeXf0OHPO2SF0Gn6MTuOEGND/dGM=;
        b=kdyibVZhwF4wLeu8/y5ChKkcL3iY9wKS25jGeyI/f907qLw8AEExBaixA3Y77Cz0y0
         NVlPUji4zZfRIFR6wi/E9WjnS3C8rPzdDOwf9qwujrE53NoncTs0p41MbDoEJcDmFou+
         ID3d68cqprfjRKExElsb0eDfNVKcUyCIEIxpLH9sqLQ2pvQoG4lSswHT/zoJOr3AUJua
         evIgcu1lOcmg3LfA5rL/FfVb4v0bQXyL1y9irxT7re1TVssiXql6bn8Z7zaKGz2ZSFs3
         cwsIwNHUodxfadgTzy/9HPhMy4l2g59abTLFZfutbfRa3ENuXd5M3Fgl4olJoAVEkU9Q
         d55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762851945; x=1763456745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDlWYzAyw7NsYv6KeXf0OHPO2SF0Gn6MTuOEGND/dGM=;
        b=qar0SBv8W6qvWlmmCOdONFV2pfW43HenZLIsVEpeGqxApMZ3sXJbdoeEMIcK7ulPzi
         l92AYCGoe+BY0BTRv4U+YmpYmR7nuvh1Z6mftXLOlODDCL5lbXetCXt4LqRR8yC/0AQn
         ZZNC5xQ4pewW3g5/GxIyYX7A2rD/Tz462fJTCDN7l/YnQxvhoJYsjpUa1PH28TMboj/1
         Spe4x5UwyfkXLgtGrqKbIDxBjcPpVW2cKLKjjr6Z3gm0Q6e9bsoKaQDYgZ0IwzlQ9uQd
         bUQsS/0l6w7pZQNJGNkGAYfzVAGcBZdJekrp6kZxWV06U2hLvKTXDNxgntWXkWds7Q3A
         uxkA==
X-Forwarded-Encrypted: i=1; AJvYcCXZF2PaDaRSdIYXatl9IMFslydurPdu9LY3sdi+7nTZ2YiXX64r4VRGehGzeDk81hfTf6TEVgTYBCwE3/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NQZCbf2kfqnaBtpyYdeY928wUWbKCm3Mv7N+LLT1GTVHdHr6
	zBgoW9shQPtFIOhDdpzIA0hguLN1oZARJ/ZU405OZ99fuFDVcvgM1iTbVZpRLzJw3ESI
X-Gm-Gg: ASbGncvcKgWWyjIaY5AjgaG/GkIUtTvJ6LmmbTlkSyc24qzqka+Wr594n8IEBf2x4IC
	D7dgecN+ryn++kXEoQyiwsGNRZUnwrJQ2QCwtxKZ8Hx+89ciD2U6KlbqSFdJ00nB9kHJNkV5axJ
	s5OxJN7HeizQ8RAUzMMPIr/uEKtb67sH4E+y8d7VgyEMCoHoEDK39+F/bq3xCmFKIk34X5Km+Su
	HiHl9nLON5k+orl4UJkOYenmtKTSpaBhsLHDRrcQyGY8wr0w8f7NBTEq5nnkKdXmAoezdFzF8te
	fGqwxzCtzLOWtbkUzYjVjszSma6N4m9hgaBLiaCT19yjvAv04NQoPPgSDMeL30n86aF8dVCvJK/
	pWQV0l/2747N8eLMbNwW9T3RNApkoKBuftRNYf0eeUCCoA8VwgHJ5OQbvcZcCs7sFcCm2ozyiYQ
	Dz9mVhrjJQ/vI3pw==
X-Google-Smtp-Source: AGHT+IGEbfJbmbA8+8wSi/s5UWHmDTg58KEwntFAKebBbBnt7cMwBebamugI89g9CGFu62qAJEzcaw==
X-Received: by 2002:a05:6a20:9145:b0:34f:ec32:6a4b with SMTP id adf61e73a8af0-353a31550d4mr15999459637.32.1762851944823;
        Tue, 11 Nov 2025 01:05:44 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm14608708a12.36.2025.11.11.01.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:05:44 -0800 (PST)
Date: Tue, 11 Nov 2025 01:05:40 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, mario.limonciello@amd.com,
	richard.gong@amd.com, anson.tsao@amd.com
Subject: Re: [PATCH v5 0/7] Add AMD ISP4 driver
Message-ID: <aRL8ZPwXSeKD4Qmn@sultan-box>
References: <20251024090643.271883-1-Bin.Du@amd.com>
 <aQsYJhbGifdXhjCJ@sultan-box>
 <aRGjX1pv0y_lVext@sultan-box>
 <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41df0f5-b2b5-49f1-a49e-8750e55975e1@amd.com>

On Mon, Nov 10, 2025 at 05:46:28PM +0800, Du, Bin wrote:
> Thank you, Sultan, for your time, big effort, and constant support.
> Apologies for my delayed reply for being occupied a little with other
> matters.
> 
> On 11/10/2025 4:33 PM, Sultan Alsawaf wrote:
> > Hi Bin,
> > 
> > On Wed, Nov 05, 2025 at 01:25:58AM -0800, Sultan Alsawaf wrote:
> > > Hi Bin,
> > > 
> > > To expedite review, I've attached a patch containing a bunch of fixes I've made
> > > on top of v5. Most of my changes should be self-explanatory; feel free to ask
> > > further about specific changes if you have any questions.
> > > 
> > > I haven't had a chance to review all of the v4 -> v5 changes yet, but I figured
> > > I should send what I've got so far.
> > > 
> > > FYI, there is a regression in isp4if_dequeue_buffer() where the bufq lock isn't
> > > protecting the list_del() anymore. I also checked the compiler output when using
> > > guard() versus scoped_guard() in that function and there is no difference:
> > > 
> > >    sha1sum:
> > >    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // guard()
> > >    5652a0306da22ea741d80a9e03a787d0f71758a8  isp4_interface.o // scoped_guard()
> > > 
> > > So guard() should be used there again, which I've done in my patch.
> > > 
> > > I also have a few questions:
> > > 
> > > 1. Does ISP FW provide a register interface to disable the IRQ? If so, it is
> > >     faster to use that than using disable_irq_nosync() to disable the IRQ from
> > >     the CPU's side.
> > > 
> > > 2. When the IRQ is re-enabled in isp4sd_fw_resp_func(), is there anything
> > >     beforehand to mask all pending interrupts from the ISP so that there isn't a
> > >     bunch of stale interrupts firing as soon the IRQ is re-enabled?
> > > 
> > > 3. Is there any risk of deadlock due to the stream kthread racing with the ISP
> > >     when the ISP posts a new response _after_ the kthread determines there are no
> > >     more new responses but _before_ the enable_irq() in isp4sd_fw_resp_func()?
> > > 
> > > 4. Why are some lines much longer than before? It seems inconsistent that now
> > >     there is a mix of several lines wrapped to 80 cols and many lines going
> > >     beyond 80 cols. And there are multiple places where code is wrapped before
> > >     reaching 80 cols even with lots of room left, specifically for cases where it
> > >     wouldn't hurt readability to put more characters onto each line.
> > 
> > I've attached a new, complete patch of changes to apply on top of v5. You may
> > ignore the incomplete patch from my previous email and use the new one instead.
> > 
> > I made many changes and also answered questions 1-3 myself.
> > 
> > Please apply this on top of v5 and let me know if you have any questions.
> > 
> 
> Sure, will review, apply and test your patch accordingly. Your contribution
> is greatly appreciated, will let you know if there is any question or
> problem.
> 
> > BTW, I noticed a strange regression in v5 even without any of my changes: every
> > time you use cheese after using it one time, the video will freeze after 30-60
> > seconds with this message printed to dmesg:
> >    [ 2032.716559] amd_isp_capture amd_isp_capture: -><- fail respid unknown respid(0x30002)
> > 
> > And the video never unfreezes. I haven't found the cause for the regression yet;
> > can you try to reproduce it?
> > 
> 
> Really weird, we don't see this issue either in dev or QA test. Is it 100%
> reproducible and any other fail or err in the log?

Yes, it's 100% reproducible. There's no other message in dmesg, only that one.

Sometimes there is a stop stream error when I close cheese after it froze:

  [  656.540307] amd_isp_capture amd_isp_capture: fail to disable stream
  [  657.046633] amd_isp_capture amd_isp_capture: fail to stop steam
  [  657.047224] amd_isp_capture amd_isp_capture: disabling streaming failed (-110)

When I revert to v4 I cannot reproduce it at all. It seems to be something in
v4 -> v5 that is not fixed by any of my changes.

I will try to identify the cause this week.

Sultan

