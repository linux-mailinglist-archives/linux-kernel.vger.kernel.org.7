Return-Path: <linux-kernel+bounces-751439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651CB169A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DBD546E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A01FD299;
	Thu, 31 Jul 2025 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="Ilmo+jhp"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576021DFDE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921820; cv=none; b=LlXJ5I8uNxn88F8BUjqyFvDQgpq+W4e+k5wLtWN1KOvsWRenBSsscnAramxyyGKjQhJiBZeCof5LOamVT2BUezkO7wnvSfvAtOVaUA1r/PGtCj8f/OAWUpDwamxf4OyebUNjzb73TlSXkkjmazOeHymNb+NmQdwoj73dwoPR5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921820; c=relaxed/simple;
	bh=tuoz+OXbDdR6NDKNwks+RBMGI83o73KIAZ+0xiZ1bhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVAGpOV7JbNpDQtwHqhLLFRpbXKGXAmQN0Zy3b8zhTD0c/8uN+o2xRBoAIpy+Vw5Dwhxh+p7JkPOche41FXhTynXCfYwbsURui7Hbzptiaj3cRlaAxdq2xQhZMlhMMCqp+9cHRvpvI7+pPBOeG28nigUeu8GLFbS0RtKY69ofBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=Ilmo+jhp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23ffdea3575so3233225ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1753921816; x=1754526616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqlqAYoCoh7FMQXAdWtQKoN6nIZ6XcS2iWJgw8aVhBg=;
        b=Ilmo+jhpqWOZh2IRLlE2Ii142YUteLHNdEA9LlseKssehNjw8NEEIpaxrXYZ5lak7y
         sy8y8EXM9ia1H5MV+c3P677Pp3OcucU4l32CLQ5GOxwM83SWKHhhIwjVe1tXGRZg3+nv
         6pEL5Ast9mwsCRe/xud2hQgVfAzR8sEyfEQfYfeuYpGSMuw7AapmjNaZq1lvodwQpJH3
         FOHI0DAqEndtEzrzyWU/kI+/i5Uno/NAZ5OWefJ9rWMMWj51e5d16y7tZMsgoRZgXEfX
         E5Uzh8d34k3IswmaUmW119e31Mi5N4BiBQIwdiwM6fVqtAFySfmmb3rUhY+eijQRhowE
         DjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753921816; x=1754526616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqlqAYoCoh7FMQXAdWtQKoN6nIZ6XcS2iWJgw8aVhBg=;
        b=BZdkCSmgi/ho2N4jBtbN+bejVxV7UhOdjckOWAN/UBj+abHmvH8NZpdCMo5Sos53Ko
         Fy742QjMpdul9nROeKsoxP8jrsYD9KJC/ZL5pwh4d0td2odSaU1AX/0GRR5FFyhycxAY
         D71YCL3/DRxpWduR+jiHYvPt5uXLXPHX06lbVJqIuskbgel01cm6BdtC5BQqIaDVtw84
         7T492ECUSF46X4vL06eRWthImJWvMhC3Jg6tcvOU8rYJNx4qmup/1SL2u/pnMNP1qRHb
         2EzmBOS2+BwyDXWAJlRAJkHbIIEIHAT8GMwIsvSKvytuOkyt040/di8OKMUZluzN/Fht
         9ZUA==
X-Forwarded-Encrypted: i=1; AJvYcCXAasHLtZ+ROZ8Ly5Zl//J34Zrip9iBMdbpREydELPwYXG7oGeoQGkuIW+Ehv67mbw+MS3SfRbaWPpcZT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkGjse02VaO6MjmK8dBhbxuvFjX2rIE0ngKdzcgbBl8Gc8Rxp
	CzIOPzx7RFRHaFWvaQbkqDKkZ1yetxV/BUMNNHZil0ItVr0VfgPNlte2AiYuMCMXlegr
X-Gm-Gg: ASbGncup7yXvvivS+VTiNvA61weXoUg1HfGc/3ZHjWFtw+A6LOdVoJbKez5CDrWIPjc
	Kpo8vEwIgd3uBo3wDS2l1xsBcGcOmgmxxrxrXLv3jssenMAJDXUZnjzK+2s+Lw1DN8fc5/YCAyf
	NsZT6mNwkrs0lWzdKWK+DKB8spNQCSPJsnaB22bSu4Vt0JHEibw5P5UW69Z+kcJtmuhiQN37zKb
	4eLprN+lYbXlBK3DKe1HaRrvYPVRd8pOArbpSbDcLWQcwgXsIbc8UxXYzNeQ/FxJo82hiea5Uzu
	PJYz7gmUrq7eTqrjKgiMsQlGbn/WR+CimY2ad4nLuCzquOAxPSLF+pxBxGvY6JZIRDjkCR6mswm
	ynhPgXhbfFicEX/Cteb79Ll40
X-Google-Smtp-Source: AGHT+IEGZtVZWVcD0xYAXHsXXCNECe6MWYgn+5VWYxlYpQazkQdaDKtnuysYKiouCRQl0iUoavFYYA==
X-Received: by 2002:a17:902:f705:b0:240:84b:a11a with SMTP id d9443c01a7336-24096a7d498mr74734955ad.17.1753921816219;
        Wed, 30 Jul 2025 17:30:16 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm2575535ad.159.2025.07.30.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 17:30:15 -0700 (PDT)
Date: Wed, 30 Jul 2025 17:30:11 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Du, Bin" <bin.du@amd.com>
Cc: mchehab@kernel.org, hverkuil@xs4all.nl,
	laurent.pinchart+renesas@ideasonboard.com,
	bryan.odonoghue@linaro.org, sakari.ailus@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	pratap.nirujogi@amd.com, benjamin.chan@amd.com, king.li@amd.com,
	gjorgji.rosikopulos@amd.com, Phil.Jawich@amd.com,
	Dominic.Antony@amd.com
Subject: Re: [PATCH v2 0/8] Add AMD ISP4 driver
Message-ID: <aIq5EyQ_uuO63dJb@sultan-box>
References: <20250618091959.68293-1-Bin.Du@amd.com>
 <aIEmJXNpNN0QF233@sultan-box>
 <12fb4d09-6b94-4f54-86b8-8a3ac0949151@amd.com>
 <aIVXVpg_9XxRXUAH@sultan-box>
 <b02d0749-6ecb-4e69-818a-6268f894464d@amd.com>
 <aIh7WB0TGNU15Zm1@sultan-box>
 <aIh8JPTv9Z5lphRQ@sultan-box>
 <751e9265-889f-4fbf-acf8-7374311a6b6f@amd.com>
 <aImvvC9JEgQ2xBki@sultan-box>
 <a3272335-1813-4706-813e-a79a9cabc659@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3272335-1813-4706-813e-a79a9cabc659@amd.com>

On Wed, Jul 30, 2025 at 05:53:58PM +0800, Du, Bin wrote:
> On 7/30/2025 1:38 PM, Sultan Alsawaf wrote:
> > On Tue, Jul 29, 2025 at 06:13:50PM +0800, Du, Bin wrote:
> > > On 7/29/2025 3:45 PM, Sultan Alsawaf wrote:
> > > > On Tue, Jul 29, 2025 at 12:42:16AM -0700, Sultan Alsawaf wrote:
> > > > > On Tue, Jul 29, 2025 at 11:32:23AM +0800, Du, Bin wrote:
> > > > > > Thanks Sultan, please see my comments
> > > > > > 
> > > > > > On 7/27/2025 6:31 AM, Sultan Alsawaf wrote:
> > > > > > > On Fri, Jul 25, 2025 at 06:22:03PM +0800, Du, Bin wrote:
> > > > > > > > > I have the Ryzen AI MAX+ 395 SKU of the HP ZBook Ultra G1a 14.
> > > > > > > > > 
> > > > > > > > > I cannot for the life of me get the webcam working under Linux. The webcam works
> > > > > > > > > under Windows so it's not a hardware issue.
> > > > > > > > > 
> > > > > > > > > With this patchset and all of the patches you link here applied to 6.15, I get
> > > > > > > > > the following errors:
> > > > > > > > >       [   11.970038] amd_isp_i2c_designware amd_isp_i2c_designware: Unknown Synopsys component type: 0xffffffff
> > > > > > > > >       [   11.973162] amd_isp_i2c_designware amd_isp_i2c_designware: error -19: i2c_dw_probe failed
> > > > > > > > > 
> > > > > > > > > With the old ispkernel code from February [1] applied on 6.15, the webcam
> > > > > > > > > indicator LED lights up but there's no image. I see these messages at boot:
> > > > > > > > >       [    9.449005] amd_isp_capture amd_isp_capture.1.auto: amdgpu: AMD ISP v4l2 device registered
> > > > > > > > >       [    9.489005] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: The OV05 sensor device is added to the ISP I2C bus
> > > > > > > > >       [    9.529012] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout while trying to abort current transfer
> > > > > > > > >       [    9.554046] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout in disabling adapter
> > > > > > > > >       [    9.554174] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout while trying to abort current transfer
> > > > > > > > >       [    9.580022] amd_isp_i2c_designware amd_isp_i2c_designware.2.auto: timeout in disabling adapter
> > > > > > > > > 
> > > > > > > > > And then the kernel crashes due to the same use-after-free issues I pointed out
> > > > > > > > > in my other email [2].
> > > > > > > > > 
> > > > > > > > > Any idea what's going on?
> > > > > > > > > 
> > > > > > > > > [1] https://github.com/amd/Linux_ISP_Kernel/commit/c6d42584fbd0aa42cc91ecf16dc5c4f3dfea0bb4
> > > > > > > > > [2] https://lore.kernel.org/r/aIEiJL83pOYO8lUJ@sultan-box
> > > > > > > > Hi Sultan,
> > > > > > > > 
> > > > > > > > [1] is for kernel 6.8, believe it can't be applied to 6.15. We didn't verify
> > > > > > > > on 6.15 but we are really glad to help, would you please provide some info,
> > > > > > > > 1. Suppose you are using Ubuntu, right? What's the version?
> > > > > > > > 2. 6.15, do you mean https://github.com/torvalds/linux/tree/v6.15 ?
> > > > > > > > 
> > > > > > > > After your confirmation, we'll see what we can do to enable your camera
> > > > > > > > quickly and easily
> > > > > > > > 
> > > > > > > > Regards,
> > > > > > > > Bin
> > > > > > > 
> > > > > > > Thank you, Bin!
> > > > > > > 
> > > > > > > 1. I'm using Arch Linux with the ISP4-patched libcamera [1].
> > > > > > > 2. Yes, here is my kernel source [2].
> > > > > > > 
> > > > > > > I have some more findings:
> > > > > > > 
> > > > > > > Currently, the first blocking issue is that the I2C adapter fails to initialize.
> > > > > > > This is because the ISP tile isn't powered on.
> > > > > > > 
> > > > > > > I noticed that in the old version of amd_isp_i2c_designware [3], there were
> > > > > > > calls to isp_power_set(), which is available in the old ISP4 sources [4].
> > > > > > > Without isp_power_set(), the I2C adapter always fails to initialize for me.
> > > > > > > 
> > > > > > > How is the ISP tile supposed to get powered on in the current ISP4 code?
> > > > > > > 
> > > > > > You are correct, yes, i believe the I2C adapter failure is caused by ISP not
> > > > > > being powered up. Currently in latest code, isp_power_set is no longer
> > > > > > available, instead, we implemented genPD for ISP in amdgpu
> > > > > > https://lore.kernel.org/all/20250618221923.3944751-1-pratap.nirujogi@amd.com/
> > > > > > Both amd_isp_i2c and amd_isp_capture are in the power domain and use the
> > > > > > standard runtime PM API to do the power control
> > > > > 
> > > > > Thanks for that link, I found it along with another patch on the list to make
> > > > > the fwnode work ("drm/amd/amdgpu: Initialize swnode for ISP MFD device").
> > > > > 
> > > > > > > Also, I noticed that the driver init ordering matters between all of the drivers
> > > > > > > needed for the ISP4 camera. In particular, amd_isp_i2c_designware and amd_isp4
> > > > > > > must be initialized before amd_capture, otherwise amd_capture will fail to find
> > > > > > > the fwnode properties for the OV05C10 device attached to the I2C bus.
> > > > > > > 
> > > > > > > But there is no driver init ordering enforced, which also caused some issues for
> > > > > > > me until I figured it out. Maybe probe deferral (-EPROBE_DEFER) should be used
> > > > > > > to ensure each driver waits for its dependencies to init first?
> > > > > > > 
> > > > > > amd_isp_capture only has dependency on amd_isp4 which is the ACPI platform
> > > > > > driver, it is init before amd_isp_catpure.
> > > > > > Do you see in your side the amd_capture probe failure caused by failing to
> > > > > > read fwnode properties? If that's the case please help to check if amd_isp4
> > > > > > is loaded successfully
> > > > > 
> > > > > I got much further now: there aren't any driver initialization errors, but when
> > > > > I open the camera, there's no image. The camera LED turns on so it's active.
> > > > > 
> > > > > And then shortly afterwards, amdgpu dies and the entire system freezes.
> > > > > 
> > > > > I've attached my full dmesg, please let me know what you think. Thanks!
> > > > 
> > > > I almost forgot, here is my current kernel tree:
> > > > https://github.com/kerneltoast/kernel_x86_laptop/tree/v6.16-sultan-isp4
> > > > 
> > > > Sultan
> > > 
> > > Thanks Sultan, yes, seems much close to the final success. Will have some
> > > internal discussion.
> > 
> > I got the webcam working. The same bug happened when I tried Ubuntu's linux-oem
> > kernel, which made me think that the issue was firmware.
> > 
> > And indeed, the culprit was a firmware update from February. I bisected
> > linux-firmware and found the commit which broke the webcam for me:
> > 
> > 	commit 1cc8c1bfa11251ce8bfcc97d1f15e312f7fe4df0 (HEAD)
> > 	Author: Pratap Nirujogi <pratap.nirujogi@amd.com>
> > 	Date:   Wed Feb 19 12:16:51 2025 -0500
> > 
> > 	    amdgpu: Update ISP FW for isp v4.1.1
> > 	
> > 	    From internal git commit:
> > 	    5058202443e08a673b6772ea6339efb50853be28
> > 	
> > 	    Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> > 
> > 	 amdgpu/isp_4_1_1.bin | Bin 4543184 -> 6083536 bytes
> > 	 1 file changed, 0 insertions(+), 0 deletions(-)
> > 
> > Downgrading firmware to before that commit fixes the webcam. Any idea why?
> > 
> > Thanks,
> > Sultan
> 
> So, can i say the working firmware binary is this one?
> 
> Commit 8f070131
> amdgpu: Update ISP FW for isp v4.1.1
> 
> From internal git commit:
> 39b007366cc76ef8c65e3bc6220ccb213f4861fb
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>

Correct.

> There are too many changes between them, so i can't tell exactly which
> change caused this. So, from my side
> 1. Will try these two firmware to see if we have the same issue.
> 2. It has been quite a long time since last release, will see if need to
> release a latest one.

Thanks. It was a quick bisect for me, so I'm happy to help test if a bisect
between those two internal git commits is needed.

In case it makes a difference, I have the laptop with the 2.8K OLED display. I'm
aware there is one other display variant on other SKUs, which is a WUXGA IPS.

Also, with that old firmware, my camera only works with the old isp4 driver from
that Linux_ISP_Kernel repo (which is the same isp4 driver used in Ubuntu's
linux-oem kernel). Does the new isp4 driver you've submitted here require newer
firmware than the old driver located in Linux_ISP_Kernel?

Sultan

