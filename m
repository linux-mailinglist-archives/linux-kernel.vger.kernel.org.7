Return-Path: <linux-kernel+bounces-754673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42848B19ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C07BB7AAFFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D01E521D;
	Mon,  4 Aug 2025 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="WM8baUsU"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EA1BF58
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281555; cv=none; b=LPzMAD82qZv6tSxo3wwE1sm58jMZGviLy48qOo/Q9actOwJFXzP70+J7V33JR5rDbcibmqe4vemFuzIC2Je4poJEAABzCbBbRrpKTD+mSI/HjJnuJQDOtyH/lwx1BfqR0Lz0vbn5191WE9kH1Zy8wa4V7Mb5xJm3RV0UYHwIxGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281555; c=relaxed/simple;
	bh=lHO1QHMwDdLyEkZA7Py8Nfc5ucdGI+K9h8OZa/st/uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnGMi7ztfl6xPDqCoPmiNYi5U1RyX9lKklegys9cM6VWOFq7MxNXvb52gBtpYPO5YK0LSZx3k1OUJ6ghBXfw1XaAe1r3uM8vNpI0aS9bSKMxk52BRp2RNlbY7/TtMMDqv3CKlSr046C9Nl0+rz35T/0pa1YhCrAJMg0glLxGpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=WM8baUsU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23636167afeso22875735ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1754281552; x=1754886352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b7FC0z4+8Uo6vDMaQBh/UGQ0IhjHxWsDjE1cUO8DRhI=;
        b=WM8baUsULAjxpZtzqLLvETkkcPLgU0jtTew1Mg6cFTRxPox4YzryDlEyzZUgXO/nap
         eJVs5F7aLmTPunheeZ8XbG89QYBcxrjZhHTgd2gmyny0ROSbnQIew6eT0HSPvF+6+c7h
         uMALsBR7je734u5TLaqhaIVaLUuXBLRjxHQqS8VMLaeElwJalY6lhB+jLNLx+ZU2NJp+
         e9Wdo6XFbk/FHjFvORjBpEvgRTXwY1TM7WXLbVdnHwBR6Q7fDCr2fC9TkQusrHK7Cruq
         BD+8zmzIsDGAT2yVf8C5fh00lcPGCECpMtEwW6Xmzm6ke8LJtMGY0/poXMSBBoZSX+Ac
         Xp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754281552; x=1754886352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7FC0z4+8Uo6vDMaQBh/UGQ0IhjHxWsDjE1cUO8DRhI=;
        b=EdmONUdJZW7gyC9CofddNMr+XWE72lsLM5oK8Q9yxTLCa0CHT/yBzfm3cwdXI2zX8z
         yhAU5e1tahPgBPtFIyCiuGb2RKWj/vakIodzdAkDSRZ45AF9LsY0ll7fXCpyulLVmFQM
         Ajd9kyWs/5vqwXTfBLcxmHCBPr0ADhWzoelbgdXmQyxzKWakcKXQMa3F4QNHjfU7VKfJ
         DlRj2wNCDLAr37Jjsb7/DA//YSyNYm9Wh3eqXQA4AtrQ6DDRckzhftT2bxQdTaq88zTg
         o+9I+KqqXZlZTgMv0xwAdo2BwRt0R4v53lh2vGOxB6sohLhOpHz5MbFiC8dSyDJFNi+R
         j+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUcqtEkgfiBvGcc4z7rCw4fl9hZB90ZVZkvP4fI65ok4rtAXGI946TxX7WqVgQsovUZ5y134Mi6UXuEdt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGkqWuyqzTMHuquoalxlMfWyQMSJKytlhG2zuE+6ZwXc6eyno
	cwQLSFoY0/GFbr6IRNn/wB8iMz8xvPmM3a9AIa54Pe1HmXfVNQN+fhjjV0GuFdDLYWvh
X-Gm-Gg: ASbGnctofwbhimUHxnLt46ewP+TQtk5AGdf185dh0dvpIF4K6J9Iw7uk04dXJVGUHP8
	q3P0qAU+ybQWXmPAGioTTlMPbnxRWtnliCBngj6jv2vrBDC5K7uqL00grjaItO1BciQm4OMaWrd
	ZjlbJfOtySg6SD3yFvIuAll3vckrP+g+9cGkuzinvw3UhdYXYneMujFVjET/n+wRsjYA4FCsFlL
	4Sybm+U592CN1MdMBIRRoRj+FUVmjtIdDWBDXRh+IsGzQVrOIoSQH2PeXXDfzOouomHV5IxUUMN
	wKAK8IO3E5F1UzwwbNrAU/GgkN5iHUhBx2IflcGVUGbYjieUSyG17WpDE5TlzObWlSNQ4gdRw4l
	1crdJwrzEA5KXkbQ6Mzep2IxLW3Xe3wjxRXo=
X-Google-Smtp-Source: AGHT+IFCQdFesqYg/E890MPUSvg8LVheqTLGRGBjnn6RzsDgCf7X0+rpd9lFJ746yqVmCFw2lOOE0g==
X-Received: by 2002:a17:902:d4c7:b0:240:99da:f0b1 with SMTP id d9443c01a7336-242470143bemr106943655ad.36.1754281552273;
        Sun, 03 Aug 2025 21:25:52 -0700 (PDT)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6825sm98009455ad.30.2025.08.03.21.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 21:25:51 -0700 (PDT)
Date: Sun, 3 Aug 2025 21:25:47 -0700
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
Message-ID: <aJA2S0EY7HhVSSzc@sultan-box>
References: <aIVXVpg_9XxRXUAH@sultan-box>
 <b02d0749-6ecb-4e69-818a-6268f894464d@amd.com>
 <aIh7WB0TGNU15Zm1@sultan-box>
 <aIh8JPTv9Z5lphRQ@sultan-box>
 <751e9265-889f-4fbf-acf8-7374311a6b6f@amd.com>
 <aImvvC9JEgQ2xBki@sultan-box>
 <a3272335-1813-4706-813e-a79a9cabc659@amd.com>
 <aIq5EyQ_uuO63dJb@sultan-box>
 <1a9a4beb-97ab-4853-8201-bf08f1a030ab@amd.com>
 <d8c99b00-e8f2-49bb-8c72-ebc4e783e51d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8c99b00-e8f2-49bb-8c72-ebc4e783e51d@amd.com>

On Mon, Aug 04, 2025 at 11:32:11AM +0800, Du, Bin wrote:
> On 7/31/2025 6:04 PM, Du, Bin wrote:
> > Thanks Sultan for your test
> > 
> > On 7/31/2025 8:30 AM, Sultan Alsawaf wrote:
> > > On Wed, Jul 30, 2025 at 05:53:58PM +0800, Du, Bin wrote:
> > > > On 7/30/2025 1:38 PM, Sultan Alsawaf wrote:
> > > > > On Tue, Jul 29, 2025 at 06:13:50PM +0800, Du, Bin wrote:
> > > > > > On 7/29/2025 3:45 PM, Sultan Alsawaf wrote:
> > > > > > > On Tue, Jul 29, 2025 at 12:42:16AM -0700, Sultan Alsawaf wrote:
> > > > > > > > On Tue, Jul 29, 2025 at 11:32:23AM +0800, Du, Bin wrote:
> > > > > > > > > Thanks Sultan, please see my comments
> > > > > > > > > 
> > > > > > > > > On 7/27/2025 6:31 AM, Sultan Alsawaf wrote:
> > > > > > > > > > On Fri, Jul 25, 2025 at 06:22:03PM +0800, Du, Bin wrote:
> > > > > > > > > > > > I have the Ryzen AI MAX+ 395 SKU of the HP ZBook Ultra G1a 14.
> > > > > > > > > > > > 
> > > > > > > > > > > > I cannot for the life of me get
> > > > > > > > > > > > the webcam working under Linux.
> > > > > > > > > > > > The webcam works
> > > > > > > > > > > > under Windows so it's not a hardware issue.
> > > > > > > > > > > > 
> > > > > > > > > > > > With this patchset and all of
> > > > > > > > > > > > the patches you link here
> > > > > > > > > > > > applied to 6.15, I get
> > > > > > > > > > > > the following errors:
> > > > > > > > > > > >        [   11.970038]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware: Unknown
> > > > > > > > > > > > Synopsys component type:
> > > > > > > > > > > > 0xffffffff
> > > > > > > > > > > >        [   11.973162]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware: error
> > > > > > > > > > > > -19: i2c_dw_probe failed
> > > > > > > > > > > > 
> > > > > > > > > > > > With the old ispkernel code from
> > > > > > > > > > > > February [1] applied on 6.15,
> > > > > > > > > > > > the webcam
> > > > > > > > > > > > indicator LED lights up but
> > > > > > > > > > > > there's no image. I see these
> > > > > > > > > > > > messages at boot:
> > > > > > > > > > > >        [    9.449005]
> > > > > > > > > > > > amd_isp_capture
> > > > > > > > > > > > amd_isp_capture.1.auto: amdgpu:
> > > > > > > > > > > > AMD ISP v4l2 device registered
> > > > > > > > > > > >        [    9.489005]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware.2.auto:
> > > > > > > > > > > > The OV05 sensor device is added
> > > > > > > > > > > > to the ISP I2C bus
> > > > > > > > > > > >        [    9.529012]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware.2.auto:
> > > > > > > > > > > > timeout while trying to abort
> > > > > > > > > > > > current transfer
> > > > > > > > > > > >        [    9.554046]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware.2.auto:
> > > > > > > > > > > > timeout in disabling adapter
> > > > > > > > > > > >        [    9.554174]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware.2.auto:
> > > > > > > > > > > > timeout while trying to abort
> > > > > > > > > > > > current transfer
> > > > > > > > > > > >        [    9.580022]
> > > > > > > > > > > > amd_isp_i2c_designware
> > > > > > > > > > > > amd_isp_i2c_designware.2.auto:
> > > > > > > > > > > > timeout in disabling adapter
> > > > > > > > > > > > 
> > > > > > > > > > > > And then the kernel crashes due
> > > > > > > > > > > > to the same use-after-free
> > > > > > > > > > > > issues I pointed out
> > > > > > > > > > > > in my other email [2].
> > > > > > > > > > > > 
> > > > > > > > > > > > Any idea what's going on?
> > > > > > > > > > > > 
> > > > > > > > > > > > [1]
> > > > > > > > > > > > https://github.com/amd/Linux_ISP_Kernel/commit/
> > > > > > > > > > > > c6d42584fbd0aa42cc91ecf16dc5c4f3dfea0bb4
> > > > > > > > > > > > [2] https://lore.kernel.org/r/aIEiJL83pOYO8lUJ@sultan-box
> > > > > > > > > > > Hi Sultan,
> > > > > > > > > > > 
> > > > > > > > > > > [1] is for kernel 6.8, believe it
> > > > > > > > > > > can't be applied to 6.15. We didn't
> > > > > > > > > > > verify
> > > > > > > > > > > on 6.15 but we are really glad to
> > > > > > > > > > > help, would you please provide some
> > > > > > > > > > > info,
> > > > > > > > > > > 1. Suppose you are using Ubuntu, right? What's the version?
> > > > > > > > > > > 2. 6.15, do you mean
> > > > > > > > > > > https://github.com/torvalds/linux/tree/
> > > > > > > > > > > v6.15 ?
> > > > > > > > > > > 
> > > > > > > > > > > After your confirmation, we'll see
> > > > > > > > > > > what we can do to enable your camera
> > > > > > > > > > > quickly and easily
> > > > > > > > > > > 
> > > > > > > > > > > Regards,
> > > > > > > > > > > Bin
> > > > > > > > > > 
> > > > > > > > > > Thank you, Bin!
> > > > > > > > > > 
> > > > > > > > > > 1. I'm using Arch Linux with the ISP4-patched libcamera [1].
> > > > > > > > > > 2. Yes, here is my kernel source [2].
> > > > > > > > > > 
> > > > > > > > > > I have some more findings:
> > > > > > > > > > 
> > > > > > > > > > Currently, the first blocking issue is
> > > > > > > > > > that the I2C adapter fails to
> > > > > > > > > > initialize.
> > > > > > > > > > This is because the ISP tile isn't powered on.
> > > > > > > > > > 
> > > > > > > > > > I noticed that in the old version of
> > > > > > > > > > amd_isp_i2c_designware [3], there were
> > > > > > > > > > calls to isp_power_set(), which is
> > > > > > > > > > available in the old ISP4 sources [4].
> > > > > > > > > > Without isp_power_set(), the I2C adapter
> > > > > > > > > > always fails to initialize for me.
> > > > > > > > > > 
> > > > > > > > > > How is the ISP tile supposed to get
> > > > > > > > > > powered on in the current ISP4 code?
> > > > > > > > > > 
> > > > > > > > > You are correct, yes, i believe the I2C
> > > > > > > > > adapter failure is caused by ISP not
> > > > > > > > > being powered up. Currently in latest code,
> > > > > > > > > isp_power_set is no longer
> > > > > > > > > available, instead, we implemented genPD for ISP in amdgpu
> > > > > > > > > https://lore.kernel.org/all/20250618221923.3944751-1-
> > > > > > > > > pratap.nirujogi@amd.com/
> > > > > > > > > Both amd_isp_i2c and amd_isp_capture are in
> > > > > > > > > the power domain and use the
> > > > > > > > > standard runtime PM API to do the power control
> > > > > > > > 
> > > > > > > > Thanks for that link, I found it along with
> > > > > > > > another patch on the list to make
> > > > > > > > the fwnode work ("drm/amd/amdgpu: Initialize
> > > > > > > > swnode for ISP MFD device").
> > > > > > > > 
> > > > > > > > > > Also, I noticed that the driver init
> > > > > > > > > > ordering matters between all of the
> > > > > > > > > > drivers
> > > > > > > > > > needed for the ISP4 camera. In
> > > > > > > > > > particular, amd_isp_i2c_designware and
> > > > > > > > > > amd_isp4
> > > > > > > > > > must be initialized before amd_capture,
> > > > > > > > > > otherwise amd_capture will fail to find
> > > > > > > > > > the fwnode properties for the OV05C10
> > > > > > > > > > device attached to the I2C bus.
> > > > > > > > > > 
> > > > > > > > > > But there is no driver init ordering
> > > > > > > > > > enforced, which also caused some issues
> > > > > > > > > > for
> > > > > > > > > > me until I figured it out. Maybe probe
> > > > > > > > > > deferral (-EPROBE_DEFER) should be used
> > > > > > > > > > to ensure each driver waits for its dependencies to init first?
> > > > > > > > > > 
> > > > > > > > > amd_isp_capture only has dependency on
> > > > > > > > > amd_isp4 which is the ACPI platform
> > > > > > > > > driver, it is init before amd_isp_catpure.
> > > > > > > > > Do you see in your side the amd_capture
> > > > > > > > > probe failure caused by failing to
> > > > > > > > > read fwnode properties? If that's the case
> > > > > > > > > please help to check if amd_isp4
> > > > > > > > > is loaded successfully
> > > > > > > > 
> > > > > > > > I got much further now: there aren't any driver
> > > > > > > > initialization errors, but when
> > > > > > > > I open the camera, there's no image. The camera
> > > > > > > > LED turns on so it's active.
> > > > > > > > 
> > > > > > > > And then shortly afterwards, amdgpu dies and the
> > > > > > > > entire system freezes.
> > > > > > > > 
> > > > > > > > I've attached my full dmesg, please let me know
> > > > > > > > what you think. Thanks!
> > > > > > > 
> > > > > > > I almost forgot, here is my current kernel tree:
> > > > > > > https://github.com/kerneltoast/kernel_x86_laptop/tree/v6.16-
> > > > > > > sultan-isp4
> > > > > > > 
> > > > > > > Sultan
> > > > > > 
> > > > > > Thanks Sultan, yes, seems much close to the final
> > > > > > success. Will have some
> > > > > > internal discussion.
> > > > > 
> > > > > I got the webcam working. The same bug happened when I tried
> > > > > Ubuntu's linux-oem
> > > > > kernel, which made me think that the issue was firmware.
> > > > > 
> > > > > And indeed, the culprit was a firmware update from February. I bisected
> > > > > linux-firmware and found the commit which broke the webcam for me:
> > > > > 
> > > > >     commit 1cc8c1bfa11251ce8bfcc97d1f15e312f7fe4df0 (HEAD)
> > > > >     Author: Pratap Nirujogi <pratap.nirujogi@amd.com>
> > > > >     Date:   Wed Feb 19 12:16:51 2025 -0500
> > > > > 
> > > > >         amdgpu: Update ISP FW for isp v4.1.1
> > > > > 
> > > > >         From internal git commit:
> > > > >         5058202443e08a673b6772ea6339efb50853be28
> > > > > 
> > > > >         Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> > > > > 
> > > > >      amdgpu/isp_4_1_1.bin | Bin 4543184 -> 6083536 bytes
> > > > >      1 file changed, 0 insertions(+), 0 deletions(-)
> > > > > 
> > > > > Downgrading firmware to before that commit fixes the webcam.
> > > > > Any idea why?
> > > > > 
> > > > > Thanks,
> > > > > Sultan
> > > > 
> > > > So, can i say the working firmware binary is this one?
> > > > 
> > > > Commit 8f070131
> > > > amdgpu: Update ISP FW for isp v4.1.1
> > > > 
> > > >  From internal git commit:
> > > > 39b007366cc76ef8c65e3bc6220ccb213f4861fb
> > > > 
> > > > Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> > > 
> > > Correct.
> > > 
> > > > There are too many changes between them, so i can't tell exactly which
> > > > change caused this. So, from my side
> > > > 1. Will try these two firmware to see if we have the same issue.
> > > > 2. It has been quite a long time since last release, will see if need to
> > > > release a latest one.
> > > 
> > > Thanks. It was a quick bisect for me, so I'm happy to help test if a
> > > bisect
> > > between those two internal git commits is needed.
> > > 
> > Really appreciate your test.
> > > In case it makes a difference, I have the laptop with the 2.8K OLED
> > > display. I'm
> > > aware there is one other display variant on other SKUs, which is a
> > > WUXGA IPS.
> > > 
> > Good to know, I believe it won't make any difference for ISP
> > 
> > > Also, with that old firmware, my camera only works with the old isp4
> > > driver from
> > > that Linux_ISP_Kernel repo (which is the same isp4 driver used in
> > > Ubuntu's
> > > linux-oem kernel). Does the new isp4 driver you've submitted here
> > > require newer
> > > firmware than the old driver located in Linux_ISP_Kernel?
> > > 
> > > Sultan
> > 
> > We had a try, yes, both of the old FW can't work on the new ISP4 driver,
> > as you know, for the last months, we did lots of driver modifications
> > for upstream and cause it incompatible with old FW.
> > Now, under internal discussion to upstream a new FW to support the new
> > ISP driver
> > 
> > Regards,
> > Bin
> > 
> > Hi Sultan,
> 
> This is the conclusion of your test,
> Driver: https://github.com/amd/Linux_ISP_Kernel/commit/c6d42584fbd0aa42cc91ecf16dc5c4f3dfea0bb4
> [1] It works on FW      8f070131(ext):39b00736(int)
> [2] It can't work on FW 1cc8c1bf(ext):50582024(int)

Correct.

> Would you please help to check if CONFIG_VIDEO_OV05C is defined not in the
> .config file when building the kernel? Our assumption is to make [1] work,
> CONFIG_VIDEO_OV05C shouldn't be defined. to make [2] work,
> CONFIG_VIDEO_OV05C should be defined.

Yes, it is enabled and I have only tested with it enabled:

    $ rg CONFIG_VIDEO_OV05C linux-oem-6.14/.config 
    CONFIG_VIDEO_OV05C=m

That's the Ubuntu linux-oem-6.14 kernel. You can get the full source and .config
I tested by running the following commands:

    git clone https://git.launchpad.net/ubuntu/+source/linux-oem-6.14 -b applied/6.14.0-1006.6
    cd linux-oem-6.14
    python debian/scripts/misc/annotations -e --arch amd64 > .config
    make olddefconfig

Let me know if that works.

Sultan

