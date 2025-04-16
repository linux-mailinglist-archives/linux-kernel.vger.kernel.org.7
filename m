Return-Path: <linux-kernel+bounces-604502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3AA89542
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC73A6A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4A27990F;
	Tue, 15 Apr 2025 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTmjPEEQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E68275112
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702652; cv=none; b=JrjBN0dMO71hHq6c+sNXG/7c8CUWuCoET33ZpEnF7Ef4v5ltdvAwdyB75nyZHM3Pcv/PM9/8/cRAayfzHvD8P6WrgCfTXTqdkHfA/aVxcX9biu0Y+5PR4T4rDC2jQ1YR5gRe6+oGX8sI4NKF7JeAv7m9hTooxK00JD9h7+gXuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702652; c=relaxed/simple;
	bh=ADDQjSNZrMUYfNo3JcSB4Y6gU66cQoi2s58lZfjsQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEff7AEg6DAar2Y/8HA2PearhZKdmLTE5LqsL1Rnlz2iOqFQhb45Ll3oM1Dwo9p1wf01YyqZsFEANdCDyXQ9qOOgYBCJ4obXxWxykLU5L+sHx5l14E9HZzSEyHUDtNlqY3F1ddJgC3gjICpNSmD0+PF1VZto+oqGnI6I6k/ywGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTmjPEEQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so53480575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744702650; x=1745307450; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDo+1ovq35fsREK4xW2iMU0s3LeNEpGFrQXnNr7tsWY=;
        b=LTmjPEEQ14PVsl7LzxiN3KWjSd8cdJ2Vgt9AKT11Xdk/aGyDC6dK+x/zMUH/1KVgb/
         VRWI51OyJvK5mBHSP56RYCM0nyJbidly8GTkpr+4Dhg807gKTrMN8/zUcQeydmT0F8to
         0ZHyOPCpB6LCs9LIr2IUfMiZCZi1726pxcckgcTNl7QeVFL8xeTAYOjoP2K8+1ZUg8MX
         kOfDGmYYFOzvXWIonlzqASfNMHoMnYg9Gkg7TCG6opjep2VFvriS2i+r7nQqcX4DBfI4
         SqtR/avfCfsNAZPoxFvLyv69WZaQIaWTebnluJpH3/DLlfZcMAdi7jX92LHRWn94cGzu
         6W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702650; x=1745307450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDo+1ovq35fsREK4xW2iMU0s3LeNEpGFrQXnNr7tsWY=;
        b=XV925YmkdGay6e0ANQ/QOkSXEPCrq4aR5p+sseJ4AJ5xdh3mQamXDzsO6tExDzDaQW
         oc/nkqIfmGN7f0vgw+oDid20H2hP3fZrovgauj3xZFAdCUuORDuzJQw6r+OcFNv7avoG
         8dir3qpXwLy4q06tNU/eyw0nfhkCdmVx/fJSvoKLQNfKJwsmf5KX5FqoT34HPEbOfnx9
         RXdOb+vrvVsKcxhAg1mFWWqlfd1e9KIyTEGb38K7QOzLPpbs+vecgkwPDHhi02M+yHoI
         w1nMqRPwB1zCIWo9zzhnLjIVbOHbor8foTYI/fv8gJfzmVvkquTCRhWSBsFpdPlfDC6g
         vnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuRLmx9MD2medwpHNlBdCZPGJ3Wpu1KeJj2J9968aQWh59dbABLalZkUckQ/CqJpazKVruXen2nJKIzsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sj60IOl5A+7frru464Qp26Ho2LJu/cdQ0zq3KEdMX42wOlHg
	TD0KLzp+tfdqh/mYe9xvI5o/j7RW605WptWAdqMqwE/zwEFqVcBr2NNyP4Zj/w==
X-Gm-Gg: ASbGnctXAT7DELBexE/9BSc33dWFjaI5i+xvI9ary9iPgUMd/2OB/ZLoDl1z4sRH43p
	+5iTOIKXnOtTXnljQDcIsKJk7B+A6NjRnlFMEEWjyav5xZGXh3kbGMlIDKdRmDCmiVt1sA2qQ75
	zd7xYpMid91rUhL46Rzh3StF6Rl36tl7B7fIM8imdwn322+hZ+O2wEFqjAYyjhq5W3og/VsDYod
	Uj9PbD7YoG+TZEA/yik33hbk5z/XxWwKeS1ZZ/hNzc01inhRg+p8mHVyk97AKxPcpJ20N7Yzl9S
	2CDctfM7eXRMojIs2xaB7Tq7SxUzdoasjeuVEC8KRg/19Y6LyA==
X-Google-Smtp-Source: AGHT+IH01tCvqQyBttKOk5hZJJOIuUKEuEjjzWxtM8xTK8g6f9wear268faSQH9NM/buDV5yVj/opw==
X-Received: by 2002:a17:902:cec9:b0:227:e980:9190 with SMTP id d9443c01a7336-22bea4fcad1mr230050615ad.44.1744702650063;
        Tue, 15 Apr 2025 00:37:30 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e31dsm8053401b3a.141.2025.04.15.00.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:37:29 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:07:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_mrana@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com, quic_vpernami@quicinc.com
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback
Message-ID: <lv47zu5dcbsweqkcbj5t67klgkfxmioganbk5jy4722bhvhnyn@ewhulcqkmcpd>
References: <20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com>
 <Z-0xJpBrO4wN9UzN@ryzen>
 <798f9a15-f3de-18fa-1b8f-2c9973e8be61@oss.qualcomm.com>
 <Z-4-A29UddizBUPz@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-4-A29UddizBUPz@ryzen>

On Thu, Apr 03, 2025 at 09:51:31AM +0200, Niklas Cassel wrote:
> Hello Krishna,
> 
> On Thu, Apr 03, 2025 at 09:26:08AM +0530, Krishna Chaitanya Chundru wrote:
> > On 4/2/2025 6:14 PM, Niklas Cassel wrote:
> > > 
> > > Out of curiosity, I tried something similar to on pcie-dw-rockchip.c
> > > 
> > > Simply having a ->shutdown() callback that only calls dw_pcie_host_deinit()
> > > was enough for me to produce:
> > > 
> > > [   40.209887] r8169 0004:41:00.0 eth0: Link is Down
> > > [   40.216572] ------------[ cut here ]------------
> > > [   40.216986] called from state HALTED
> > > [   40.217317] WARNING: CPU: 7 PID: 265 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0
> > > [   40.218024] Modules linked in: rk805_pwrkey hantro_vpu v4l2_jpeg v4l2_vp9 v4l2_h264 v4l2_mem2mem videobuf2_v4l2 videobuf2_dma_contig videobuf2_memops videobuf2_common vidf
> > > [   40.220267] CPU: 7 UID: 0 PID: 265 Comm: init Not tainted 6.14.0+ #134 PREEMPT
> > > [   40.220908] Hardware name: Radxa ROCK 5B (DT)
> > > [   40.221289] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > [   40.221899] pc : phy_stop+0x134/0x1a0
> > > [   40.222222] lr : phy_stop+0x134/0x1a0
> > > [   40.222546] sp : ffff800082213820
> > > [   40.222836] x29: ffff800082213820 x28: ffff45ec84b30000 x27: 0000000000000000
> > > [   40.223463] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbe8df7fde030
> > > [   40.224088] x23: ffff800082213990 x22: 0000000000000001 x21: ffff45ec80e10000
> > > [   40.224714] x20: ffff45ec82cb40c8 x19: ffff45ec82ccc000 x18: 0000000000000006
> > > [   40.225340] x17: 000000040044ffff x16: 005000f2b5503510 x15: 0720072007200720
> > > [   40.225966] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
> > > [   40.226592] x11: 0000000000000058 x10: 0000000000000018 x9 : ffffbe8df556469c
> > > [   40.227217] x8 : 0000000000000268 x7 : ffffbe8df7a48648 x6 : ffffbe8df7a48648
> > > [   40.227842] x5 : 0000000000017fe8 x4 : 0000000000000000 x3 : 0000000000000000
> > > [   40.228468] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff45ec84b30000
> > > [   40.229093] Call trace:
> > > [   40.229308]  phy_stop+0x134/0x1a0 (P)
> > > [   40.229634]  rtl8169_down+0x34/0x280
> > > [   40.229952]  rtl8169_close+0x64/0x100
> > > [   40.230275]  __dev_close_many+0xbc/0x1f0
> > > [   40.230621]  dev_close_many+0x94/0x160
> > > [   40.230951]  unregister_netdevice_many_notify+0x14c/0x9c0
> > > [   40.231426]  unregister_netdevice_queue+0xe4/0x100
> > > [   40.231848]  unregister_netdev+0x2c/0x60
> > > [   40.232193]  rtl_remove_one+0xa0/0xe0
> > > [   40.232517]  pci_device_remove+0x4c/0xf8
> > > [   40.232864]  device_remove+0x54/0x90
> > > [   40.233182]  device_release_driver_internal+0x1d4/0x238
> > > [   40.233643]  device_release_driver+0x20/0x38
> > > [   40.234019]  pci_stop_bus_device+0x84/0xe0
> > > [   40.234381]  pci_stop_bus_device+0x40/0xe0
> > > [   40.234741]  pci_stop_root_bus+0x48/0x80
> > > [   40.235087]  dw_pcie_host_deinit+0x34/0xe0
> > > [   40.235452]  rockchip_pcie_shutdown+0x24/0x48
> > > [   40.235839]  platform_shutdown+0x2c/0x48
> > > [   40.236187]  device_shutdown+0x150/0x278
> > > [   40.236533]  kernel_restart+0x4c/0xb8
> > > [   40.236859]  __do_sys_reboot+0x178/0x280
> > > [   40.237206]  __arm64_sys_reboot+0x2c/0x40
> > > [   40.237561]  invoke_syscall+0x50/0x120
> > > [   40.237891]  el0_svc_common.constprop.0+0x48/0xf0
> > > [   40.238305]  do_el0_svc+0x24/0x38
> > > [   40.238597]  el0_svc+0x30/0xd0
> > > [   40.238868]  el0t_64_sync_handler+0x10c/0x138
> > > [   40.239251]  el0t_64_sync+0x198/0x1a0
> > > [   40.239575] ---[ end trace 0000000000000000 ]---
> > > 
> > Hi Niklas,
> > 
> > The issue which you are seeing with specific to the RealTek ethernet
> > driver and should be fixed by RealTek driver nothing to do with the host
> > controller.
> 
> The warning comes from:
> drivers/net/phy/phy.c:phy_stop()
> so from the networking phylib.
> 
> Doing a simple:
> $ git grep -p phy_stop
> 
> shows that practially all Ethernet drivers call phy_stop() from the
> .ndo_stop() callback.
> 
> So after your suggested patch, you should see this warning appear with
> any NIC, if connected to your PCIe controller.
> 

I think the issue here is that phy_stop() is called without calling
corresponding phy_start(). This means that either rtl8169_up() is never called
or rtl8169_down() is called twice.

I don't think this issue is applicable to all drivers. It'd be worth
investigating what is going wrong with this r8169 driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

