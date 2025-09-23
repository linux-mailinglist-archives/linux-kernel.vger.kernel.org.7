Return-Path: <linux-kernel+bounces-829294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B43B96B71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AB82E53B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD30255F31;
	Tue, 23 Sep 2025 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQzFa4pE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C026A0C5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643427; cv=none; b=HtTFZJ5r2wWJr2ZK4BpVzNEyLKGerDJcDw9t5LVu7ElWambRBgi8EPlsg8Qe6gCMP0i9DnqWTdxpX82bVmtYDgK6ejVAjmEZT0EGTSsgTlnFHM3D8zGPuMTpkKPmz9h/wWPk5ayRA8pyDnXY46sdbuu7+EsfppADXiN4XJ39oWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643427; c=relaxed/simple;
	bh=acYIptEhY/FTS13q/p4Gqp2WqXvXWWwi73HB+X0La/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bao3z/oTu/nMgfwCs2Bmeeb6PA5NxuXxtPH4MLUmJQ3g/4FBg1uknAXoAH2jNe+k2jGIYibffleshXhvgUBM31kcDfSe97c2eWeA7t2CqRpQ56JLVc65tsRSG+JwKNpgvtYRI5QNt38CT4JS6G2aRmKAEKCTu0l/p+wb0H3V5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQzFa4pE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so5042132a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643424; x=1759248224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCjwXZdvlr5TGiQ9Gsc1mgLjFMZKnntp5GpNV0BrGWg=;
        b=WQzFa4pEsPBbVBoCnvylGCDfbdc0npfEQNI6Em5pTR6TO/4ItA3Lz8Jc420/lKoEXT
         jCF+aeypN52vGpGZwNj+aCpH5z8/lDSz/NmV280Kj2XZPS3sB9NFeBQix2y/dPW5RcDm
         ZCz+Pd4CfrM8ma86lIcxFiChB8B2Kr1Y4U65WR9EYkXc42g/DxAqL5E4keEpvGPTi2bL
         /nA4TgAu5dIjNGAQzNqL7EoWmMdh1s3B0HXh4PBcqaX6BOHvq25dBol8/yzGqNgIazyw
         58mqhxLaMKaaQCY72w9WGL1ZhVkVQLCIOBmfP7eH0msaQAnjr9vWa8QLmCvMEstuRsEW
         hKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643424; x=1759248224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCjwXZdvlr5TGiQ9Gsc1mgLjFMZKnntp5GpNV0BrGWg=;
        b=MH3kyySogyZmaWmOMMdTMcyCM+uB6GE5B3S8KadYWxLsrqNwp/OpCd3zsnXX/O2Dmb
         jKRDIUnu2AFIXWFCooezjFG6h1SsrMh2H1ptyC+D6MgCCMevZHFOP8u6y7yGo6xVqrNo
         Aaxte88F9KcUteGeceY2/d85wDYV/ispUEihjvx8OaL0k/I8FZN/S2PVdmproQ9xKkXD
         hsN/TYu5bfGbJsqWBfLBMzZkI6UPssEab8zxj/UVfeAb4h9eyzX+ASzBgHRhVmITc2at
         U2MWHqA4JSqazEpCq3+IaGNRdaRjRIMZFxWngaN+4LCSiOHIpWDHlTM7rfgWKwhi2OtE
         F/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWb4SX6l801di/ruUV4dR8QYPLRwTtB1TA6uV6pcB/HC6L+IrBA2hhurunzFPv8nz3/M39qpwhUBdm9EU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg49A5RT7GfyJEK4nAV56zdpTqmavlTlReCh7aXX/KXP1FeArB
	PBArSKYlxyE7NhZdjoTuDScMjcGSYSc3xwceQvcQHa/nqBLV0nYxLNei
X-Gm-Gg: ASbGncsxwab25xt/FwOzn4x6BdL3G+vx0SOq9ih+ZQVeD6PV4S7mfizXXHk6RZfstqN
	9EIxju+Y/ueGMrLkHbE/A/ygWDsd/yn8LRClvg10DiIDn8XpTR0IvtRO16b+AQ7E0+f3Z1MXa0n
	yT7F/NZWWo+MUHU6Dg/jxStGjRt1gynW1BrEseikUfa8hU2lD+l7P6m6h+6nWJrZzphO067ccg5
	sWd7S9/x98gIcPynnXZCku1z66981qZ17/fodZrzGQawiYQQolwghwWFfpOPf2HLBXzUlE7cx77
	9ArbHmvyRuG9upklFHVc6MG9Tm9LgbZ8A/Ff5UxcnwrKjIrVcLyYYNA4eh8edhgejxWtb7DKO4i
	fq0406efdlL1hIsshLzpcEjzH+riMw+U=
X-Google-Smtp-Source: AGHT+IHISW90NLk8XtYPSy5uwi6/z+EnNYEUhS0pqc4r9TqWhWKXchg9EW4j0OUL/iKfwlQcDt+IiQ==
X-Received: by 2002:a17:90b:2787:b0:32e:9daa:7347 with SMTP id 98e67ed59e1d1-332a92c9d80mr3777330a91.7.1758643423923;
        Tue, 23 Sep 2025 09:03:43 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([58.187.66.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm19447325a91.24.2025.09.23.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:03:43 -0700 (PDT)
From: Nam Tran <trannamatk@gmail.com>
To: gregkh@linuxfoundation.org
Cc: lee@kernel.org,
	pavel@kernel.org,
	rdunlap@infradead.org,
	christophe.jaillet@wanadoo.fr,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 0/4] leds: add new LED driver for TI LP5812
Date: Tue, 23 Sep 2025 23:03:36 +0700
Message-Id: <20250923160336.12464-1-trannamatk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025092259-stranger-affecting-1c75@gregkh>
References: <2025092259-stranger-affecting-1c75@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025, Greg KH wrote:

> On Tue, Sep 23, 2025 at 01:13:41AM +0700, Nam Tran wrote:
> > On Thu, 11 Sep 2025, Greg KH wrote:
> > 
> > > On Sun, Sep 07, 2025 at 11:09:40PM +0700, Nam Tran wrote:
> > > > This patch series adds initial support for the TI LP5812,
> > > > a 4x3 matrix RGB LED driver with autonomous engine control.
> > > > This version provides a minimal, clean implementation focused
> > > > on core functionality only. The goal is to upstream a solid
> > > > foundation, with the expectation that additional features can
> > > > be added incrementally in future patches.
> > > > 
> > > > The driver integrates with the LED multicolor framework and
> > > > supports a set of basic sysfs interfaces for LED control and
> > > > chip management.
> > > > 
> > > > Signed-off-by: Nam Tran <trannamatk@gmail.com>
> > > 
> > > The sysfs api is really odd here.  WHy not do the same thing as this
> > > other controller recently submitted does:
> > > 	https://lore.kernel.org/r/20250911-v6-14-topic-ti-lp5860-v3-0-390738ef9d71@pengutronix.de
> > 
> > Thank you for the feedback!
> > I agree that consistency is important, and I've reviewed the patch you referenced.
> > 
> > I also checked the LP5860 datasheet and noticed that its driver exposes sysfs entries
> > for configuring registers like `R_current_set`, `G_current_set`, and `B_current_set`.
> > Similarly, the LP5812 requires register-level configuration for operation.
> > 
> > In my driver, I've implemented the following sysfs attributes:
> > - '/sys/bus/i2c/devices/.../lp5812_chip_setup/dev_config' - Configures drive mode and
> > scan order (Dev_Config_1 and Dev_Config_2 registers).
> > - '/sys/bus/i2c/devices/.../lp5812_chip_setup/sw_reset' - Triggers a software reset of
> > the device (Reset register).
> > - '/sys/bus/i2c/devices/.../lp5812_chip_setup/fault_clear' - Clears fault status
> > (Fault_Clear register).
> > - '/sys/class/leds/led_<id>/activate' - Activate or deactivate the specified LED channel
> > in runtime (led_en_1, led_en_2 registers).
> > - '/sys/class/leds/led_<id>/led_current' - To change DC/PWM current level of each led
> > (Manual_DC_xx and Manual_PWM_xx registers).
> > - '/sys/class/leds/led_<id>/max_current' - To show max current setting (Dev_Config_0 register).
> > - '/sys/class/leds/led_<id>/lod_lsd' - To read lod, lsd status of each LED
> > (LOD_Status_0, LOD_Status_1, LSD_Status_0, LSD_Status_1 registers).
> > 
> > These attributes map directly to LP5812 registers. I’ve kept the interface minimal and
> > focused only on essential functionality needed to operate the device.
> > 
> > If any of these attributes seem unconventional or redundant, I’d appreciate clarification
> > so I can revise accordingly.
> > 
> > > but better yet, why does this need to be a kernel driver at all?  Why
> > > can't you just control this directly from userspace with a program
> > > there?
> > 
> > LP5812 is controlled via I2C, and its register map is non-trivial. Moving control to userspace
> > would require users to manually handle I2C transactions and understand the register layout,
> > which is error-prone and not user-friendly.
> 
> So you write it once in a library, or in a userspace program, and it is
> done.  Don't expose these low-level things in a custom api that could be
> done in userspace instead.
> 
> > Moreover, the driver integrates with the LED multicolor framework, allowing standardized control
> > via existing userspace tools. This abstraction is difficult to achieve reliably from userspace alone.
> 
> But this is a custom api for the leds, not like any other one out there.
> So how would it integrate with anything else?
> 
> > > For USB, we generally do not allow these types of crazy apis to be added
> > > to the kernel when controlling the device can be done from userspace.  I
> > > think the same thing can happen here too, right?
> > 
> > USB devices benefit from standardized descriptors and interfaces, which reduce the need for custom
> > sysfs APIs. In contrast, LP5812 has no such standard interface, and some customization is necessary.
> 
> Many USB devices do not benifit from that at all, you directly control
> them from userspace using vendor-specific apis.  Just like this device,
> nothing different just because it is an i2c device.
> 
> > I’m open to improving the sysfs interface or moving parts to another method if that’s more appropriate.
> > Please let me know which specific changes you’d recommend.
> 
> sysfs really doesn't seem to be the correct api here, you are making a
> custom one just for this one device that is not shared by any other one,
> so userspace has to write custom code to control it.  So why not just
> write one program, in userspace, to handle it all at once, instead of 2?
> 
> > For completeness, I considered these methods:
> > - sysfs: Recommended and standard for LED drivers.
> > - i2c-tools: Not recommended, intended for development/debug only.
> > - ioctl: Not recommended for new LED drivers.
> > - debugfs: For debugging only.
> > - Direct I2C register access: Requires users to know the register map and protocol.
> 
> A library will handle the i2c direct register access.  Again, do not
> make custom sysfs apis if at all possible.

Thank you very much for your valuable feedback.

I understand your suggestions and the overall strategy. I'm currently considering moving
some configurations to the device tree binding, allowing users to manage device settings
more flexibly through it.

For other interfaces, I plan to support them from userspace.
 
If this approach sounds good to you, I'll proceed to update the source code and submit a
new patch accordingly.

Thanks again for your review and support!

Best regards,
Nam Tran

