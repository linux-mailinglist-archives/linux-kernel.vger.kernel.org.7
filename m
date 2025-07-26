Return-Path: <linux-kernel+bounces-746912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7DEB12CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 00:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5567217D7F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF8202C45;
	Sat, 26 Jul 2025 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="P25KKNDW"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D0262BE
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569120; cv=none; b=Q5tyXOej+PJOpuYw3PEh9NjbPitM/1i3Rx4IOo36+mD9kKzMwezwke0PbcoBZcJu0cuvRIbZv1i+ssnHzxYdpuiNpF8GkVXpVumFSBRhPJ4fc0BLwxLYAiR1CR9CT4Rjo1ORmPgPaWtx4TkSoXQbezQhde717CzJjdaacB8dVQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569120; c=relaxed/simple;
	bh=Br0igOSWeBgd+8tcin2EbctaTl2MsLwbeeC9XmXtjgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOS7ML96DngVI3eeh4d2WnEXHTbEtwVm/glWVugVFA99UJl1ckk23CWJt51RePTlHXpNwf31RQYhqkpX4tmQBA5vzDLrLd0Bn9iSlqDz70gXVZrV4jbFYDsWWiN2iNky69xedchYLuThe7dHrH6recH8k87OCbQ2JbT3568G3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=P25KKNDW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2219893b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753569118; x=1754173918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=goQUyZCivbdecbzMlPOrKS5rZk5oqTbMCiPefv4GjFo=;
        b=P25KKNDWzt+sxvY0e2H41NVa0sYMlMrdrrr1Q3yRo8qGUIV69tMU6rHQ5t0TGscHQR
         6ucEoXCjq3q47k+hVa10eZhTugEk2DPlLZNVP22mWhgrWAIHwHtRD7VTJ85ugUZOJoUk
         0L2UR7M/IhOlLI6mjOhBYKuaHZtLN58AcDQTc3p9UyT3IGqqmzgdsapP80LmpuEgxS5a
         dV0QVhtS4Z3dly2+/XmH4qhXr6T3cqBY+eWtfMJthIKnrmqOeNpkxf9mQ0SCFwfa3u9G
         1RwcwIkF00+lnHW3BYcvf7YA2cSkXvfWgF/c966J27CuD1tXkvLO/e3b49ZsrBm0i6dH
         A39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753569118; x=1754173918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goQUyZCivbdecbzMlPOrKS5rZk5oqTbMCiPefv4GjFo=;
        b=fI7P8XbjPGZwEEWmfJ/4UbXHnNkEmE2CQmddTStWlhr7u2H0XdGK0Wfnrp1GDXdiNI
         TXOsKOZajGGry1Nzsz41IotKbHioybmlf7pYqmby+FaSoiOHR4EH9PEmaY6bzCNqjEmM
         WggSSNHonwxpKdRxtBI7MaWQd7ulKDaxT1VIY85O6rfmEtKKbjZoQX/cFczt710ZW3Kc
         +P0klTiUzTTDwhGri4NTg8ID/NlJ9GQVdTPFpDOqnm6pFMFaCsIiRrb5y5FlES4cHUJk
         rHyGGBfiZ+rtj2eF0rDsO/YeXiibvcdb7v2nBrSaM9JTlYWN7mP27UhgVIIKrqQysETQ
         mZ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyQDZdJvszTlYAsGbul6q1acyjcXTmE5X8kBHsO0XM/aufzwiaADhJpHjazoRqVRWdfl3Yj5HAouL7MvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+iYpgXGK62njslpE9Zzlu3Y7I7X3kqYjPB7qDvCDEmjbtI5r
	j8T87vfntA2ttIwxKoMYkC9aHfZSKpTpyB6cH1FFC8u/HIhR8q57QFb31JADyicYI8KH
X-Gm-Gg: ASbGnctdYARTFXiwRV6gaHq7/1RjE9UyyNym8pE1P4LzJmX+3pUydGr8qADpIgM3M12
	YBnpeSlg/Sx363L9J91/u1P8K6zex/QnsT4nnoGU5e4jxBljv6yXvxsqjW/yBoT0q586gO092sl
	cmIiJRipPKdM0N07z6WNkpwOohO8/JKIwiOSjk06MeJcxrTX+gbqD9LezUJ6M+DoVwbu60riEtY
	ItlBlx/1ygvx2cDSdV0OX2Qdm/05AIH690lYXOall4NLq3leQ/NL90UgFiy88T6hYTXKOUtaQTx
	SongPJIEoY7yHEnrmb+kXM+8pH8QTX4UICq+x60XaRB83+KZbnzEcn3/GQ2Xv2BTWWz9NFWeiVP
	IpsD+lmIuUvVwLIfdivv5qRsv
X-Google-Smtp-Source: AGHT+IHV8UrL+m4gTW5oOstx5hy347NvkBbkiGVIXjzUOoId55IP6klYPnDv+SEeKUmZ3w4agAipyw==
X-Received: by 2002:a05:6a20:914c:b0:21f:53e4:1919 with SMTP id adf61e73a8af0-23d6df7ea1dmr10973722637.3.1753569117874;
        Sat, 26 Jul 2025 15:31:57 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6dd053sm2120290a12.68.2025.07.26.15.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 15:31:57 -0700 (PDT)
Date: Sat, 26 Jul 2025 15:31:50 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com, Svetoslav.Stoilov@amd.com
Subject: Re: [PATCH v2 0/8] Add AMD ISP4 driver
Message-ID: <aIVXVpg_9XxRXUAH@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <aIEmJXNpNN0QF233@sultan-box>
 <12fb4d09-6b94-4f54-86b8-8a3ac0949151@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12fb4d09-6b94-4f54-86b8-8a3ac0949151@amd.com>

On Fri, Jul 25, 2025 at 06:22:03PM +0800, Du, Bin wrote:
> > I have the Ryzen AI MAX+ 395 SKU of the HP ZBook Ultra G1a 14.
> > 
> > I cannot for the life of me get the webcam working under Linux. The webcam works
> > under Windows so it's not a hardware issue.
> > 
> > With this patchset and all of the patches you link here applied to 6.15, I get
> > the following errors:
> >    [   11.970038] amd_isp_i2c_designware amd_isp_i2c_designware: Unknown Synopsys component type: 0xffffffff
> >    [   11.973162] amd_isp_i2c_designware amd_isp_i2c_designware: error -19: i2c_dw_probe failed
> > 
> > With the old ispkernel code from February [1] applied on 6.15, the webcam
> > indicator LED lights up but there's no image. I see these messages at boot:
> >    [    9.449005] amd_isp_capture amd_isp_capture.1.auto: amdgpu: AMD ISP v4l2 device registered
> >    [    9.489005] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: The OV05 sensor device is added to the ISP I2C bus
> >    [    9.529012] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout while trying to abort current transfer
> >    [    9.554046] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout in disabling adapter
> >    [    9.554174] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout while trying to abort current transfer
> >    [    9.580022] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout in disabling adapter
> > 
> > And then the kernel crashes due to the same use-after-free issues I pointed out
> > in my other email [2].
> > 
> > Any idea what's going on?
> > 
> > [1] https://github.com/amd/Linux_ISP_Kernel/commit/c6d42584fbd0aa42cc91ecf16dc5c4f3dfea0bb4
> > [2] https://lore.kernel.org/r/aIEiJL83pOYO8lUJ@sultan-box
> Hi Sultan,
> 
> [1] is for kernel 6.8, believe it can't be applied to 6.15. We didn't verify
> on 6.15 but we are really glad to help, would you please provide some info,
> 1. Suppose you are using Ubuntu, right? What's the version?
> 2. 6.15, do you mean https://github.com/torvalds/linux/tree/v6.15 ?
> 
> After your confirmation, we'll see what we can do to enable your camera
> quickly and easily
>
> Regards,
> Bin

Thank you, Bin!

1. I'm using Arch Linux with the ISP4-patched libcamera [1].
2. Yes, here is my kernel source [2].

I have some more findings:

Currently, the first blocking issue is that the I2C adapter fails to initialize.
This is because the ISP tile isn't powered on.

I noticed that in the old version of amd_isp_i2c_designware [3], there were
calls to isp_power_set(), which is available in the old ISP4 sources [4].
Without isp_power_set(), the I2C adapter always fails to initialize for me.

How is the ISP tile supposed to get powered on in the current ISP4 code?

Also, I noticed that the driver init ordering matters between all of the drivers
needed for the ISP4 camera. In particular, amd_isp_i2c_designware and amd_isp4
must be initialized before amd_capture, otherwise amd_capture will fail to find
the fwnode properties for the OV05C10 device attached to the I2C bus.

But there is no driver init ordering enforced, which also caused some issues for
me until I figured it out. Maybe probe deferral (-EPROBE_DEFER) should be used
to ensure each driver waits for its dependencies to init first?

[1] https://github.com/amd/Linux_ISP_libcamera/tree/3.0
[2] https://github.com/kerneltoast/kernel_x86_laptop/tree/v6.15-sultan-isp4
[3] https://lore.kernel.org/all/20250228164519.3453927-1-pratap.nirujogi@amd.com
[4] https://github.com/amd/Linux_ISP_Kernel/blob/c6d42584fbd0aa42cc91ecf16dc5c4f3dfea0bb4/drivers/media/platform/amd/isp4/isp_hwa.c#L378-L385

Sultan

