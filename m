Return-Path: <linux-kernel+bounces-846777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA26BC902D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3A2188F46E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC832DCF61;
	Thu,  9 Oct 2025 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAqYBPV4"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482912E2DDD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012962; cv=none; b=uv3+wWcezHhL9AKrdf7CY7rinbnJBWY5oQuDDYCIJCPAa/spH5jcaMTEPDPKrM3iHx0aSTQXItdGLaGIgoCBue0nnTwVMUm7nDz7P/Yswu/YD8EAv22tpvSKUsUFhMCgFFRI6howgzYVc5Vs0TX4/cJxLKMiiYnsPLfNVksCCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012962; c=relaxed/simple;
	bh=VzdC46ij9og/QMv5wDDGRQOuoWac6/8T3RkbIGb96os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3D8uqHZMs6BO74bKdPGHZbx364JAQ5Yqup9T6oAMlEyYvuYPXGNI91kWuuM0zNZnQ048LCyxnOJ64g1ayqCeLt3IU1sQ4thXNdY6dx3zZZsgds1WGNEw3hNUDYIRnLv+tXS++Jhg5Q4sll3kkXZ5MIfRrDuf5oqVByUaQEs/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAqYBPV4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso1869121a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012958; x=1760617758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyW/MRHSFiY33jmW9b/P7thbCXCFOf6rw+BoiTwW0Y8=;
        b=mAqYBPV4K+Vi0JlCaGrcNj07pW7Q5UXJvCzqVKqHBzag/tEGXxVK04Tsc+aN4UqC4Z
         4rWVfJBmkkZWd0uBnHjPW3FVgeUcOEigl9GWyOrHRdS/TYOVX7SzC/KxwpjcUrXw7hTX
         7/bROlBQHry0+vQk6ZbxZdaJHAuVJvjGdkw05ikiH3Pk/tSCAvQoqOKrtKgK6NkRSlMK
         oLvlZs6Q0Fph1pS9NE7ci1j4Dyz4VPwywKmoF3IUr6Vay9FYqLvg1Il1PGWejyDKjbb1
         5EBqi0hbfBFXH3gpOTY/AVbQoIIFXgyCwwaTiPxTw7w+MZZXuQ2uWfMOJlm6AyETKwVe
         Uhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012958; x=1760617758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyW/MRHSFiY33jmW9b/P7thbCXCFOf6rw+BoiTwW0Y8=;
        b=IBCQApcreb0OkILsRsEX0yzSMQa74XC5otSUEUHzneASpg4heLofNh0mqS+F0Jq3sF
         YCWV3RSb19csZZPvSwaJEp2GCFSir3FzzN6c4A6LxV5AX7yflMTM2zD6pRwwH0RcEMw+
         uo9bc6uig2Kj1DAy3NGw5Tb4ImtuWKgr+pqTZ0RoBS6mBXyEJf6YrhY+/GXK/JlDtxAA
         fy5O7nY0kXOogJmrcxDZrywKgkXXjADhLGFbr/tIOfJI/ismrtQ7WUOOWevDCshrdHhn
         KAAxUYgViUFx4YXWqdXx0fLrLg6ljajAP5xNYIHSOCRMuPpHo1ftI97kvpHHN0upWF37
         LfXw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMVT1TumIkbTdpv2VGqhlaGn/LNxpGr22a5LCobXP6fpRcky4FreaHyx1wv3Upv96NGOFEbuh7DysgsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTxLNK+ELhY6R8NuRKLhUeS6kJAz3UwfEHFhnNF9dWp8hm/z5y
	OQpqDJnj1jvrcrSgL7F/Ivh8ScJGd9bklvCumWrl8EdKkJjKdBwNNUr1
X-Gm-Gg: ASbGncuRe/dMVC0XPq7NjlIYeFHypj5od7F2/QFUaTQm3ruIjDH73ojOxXxLPtC+c5e
	VhTDzADLSQU2OAvHSX2b8qNUkrhNrFdUA03SedmEWCGGKzrpFs3P4y6kL7ximvhwowj4sKJv8XG
	FeRu33YiI0ZOSivP8TA6qjOkGUoBxtx0CDpzvjf79cuXZlbhP8v9Tx0VRK0dAtGwgQCg4qJdyk1
	IJavv1qHZJqlRN5PivuBpFDjfxvviAlHRQ+8mkp0130vU8XW9k4qmkvunR2ZKl7fp1imtSKrzWN
	xaqeEbMaGLtetrSa9x7Cs1gN70Tha88HWIGYqtFVMRVFsu5YqcaTGRipGoihCrHinHGWf+GAxbB
	ajAQ6qsu2P4rpWIKZ7+kpDVEvNuudWOgGkWnGaZjuATMH+nexslL/V63y0wZdvGj2IFz08g==
X-Google-Smtp-Source: AGHT+IEUFt2opNB1FkGPRiWGkz3n+VBsnJz1zaUezVI3q1ZBqp6vQVbi/Nvy0LOYCR/GmfXBoc7uag==
X-Received: by 2002:a05:6402:51c9:b0:629:e50c:b058 with SMTP id 4fb4d7f45d1cf-639d5c52cdamr7113841a12.28.1760012956991;
        Thu, 09 Oct 2025 05:29:16 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f30fb7dfsm2279630a12.19.2025.10.09.05.29.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Oct 2025 05:29:16 -0700 (PDT)
Date: Thu, 9 Oct 2025 14:29:11 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Arisa Snowbell <arisa.snowbell@gmail.com>, Mathias Nyman
 <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci-pci: Fix USB2-only root hub registration
Message-ID: <20251009142911.6069c164.michal.pecio@gmail.com>
In-Reply-To: <CABpa4MC-pij0Fczh-mH3zc+Ey2ALX70OfxX=cG4om7R6WMdRBg@mail.gmail.com>
References: <CABpa4MA9unucCoKtSdzJyOLjHNVy+Cwgz5AnAxPkKw6vuox1Nw@mail.gmail.com>
	<20251007231709.6c16802e.michal.pecio@gmail.com>
	<CABpa4MCUnLUR_0Vzgd=rTr0+Hot=nxHirKrX6xtJWowDoLhWJw@mail.gmail.com>
	<CABpa4MCg7yixe7O8Pp+YwvpxeC=1JPhMhAap12RjtV6pcxFYgQ@mail.gmail.com>
	<20251008082055.5646dadc.michal.pecio@gmail.com>
	<CABpa4MCm8hQXvtSYqUA+Dh3rCLVM5rTC1p+FsgmFemv+Vyz=RA@mail.gmail.com>
	<20251008130532.49922d58.michal.pecio@gmail.com>
	<CABpa4MAsvK68CyQ7bVdie1j2m2O2YAEuFJHq8D-65uFT3FzKzQ@mail.gmail.com>
	<20251008223406.13f16f19.michal.pecio@gmail.com>
	<CABpa4MBGW=OJi+j34TbL2g=zyTg7-rxqpHYfAW-1DXTPk=g5Fw@mail.gmail.com>
	<CABpa4MBDvgJcgJf3_E7k1dBXs7v1tW-79dmc_sQDVM1bES5YDQ@mail.gmail.com>
	<20251009131444.2c221922.michal.pecio@gmail.com>
	<CABpa4MC-pij0Fczh-mH3zc+Ey2ALX70OfxX=cG4om7R6WMdRBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A recent change to hide USB3 root hubs of USB2-only controllers broke
registration of USB2 root hubs - allow_single_roothub is set too late,
and by this time xhci_run() has already deferred root hub registration
until after the shared HCD is added, which will never happen.

This makes such controllers unusable, but testers didn't notice since
they were only bothered by warnings about empty USB3 root hubs. The bug
caused problems to other people who actually use such HCs and I was
able to confirm it on an ordinary HC by patching to ignore USB3 ports.

Setting allow_single_roothub during early setup fixes things.

Reported-by: Arisa Snowbell <arisa.snowbell@gmail.com>
Closes: https://lore.kernel.org/linux-usb/CABpa4MA9unucCoKtSdzJyOLjHNVy+Cwgz5AnAxPkKw6vuox1Nw@mail.gmail.com/
Fixes: 719de070f764 ("usb: xhci-pci: add support for hosts with zero USB3 ports")
Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---


Arisa, does this version also work?


 drivers/usb/host/xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 13454bef14d3..cb7f5dd34333 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -580,6 +580,7 @@ static int xhci_pci_setup(struct usb_hcd *hcd)
 
 	/* imod_interval is the interrupt moderation value in nanoseconds. */
 	xhci->imod_interval = 40000;
+	xhci->allow_single_roothub = 1;
 
 	retval = xhci_gen_setup(hcd, xhci_pci_quirks);
 	if (retval)
@@ -643,7 +644,6 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	xhci = hcd_to_xhci(hcd);
 	xhci->reset = reset;
 
-	xhci->allow_single_roothub = 1;
 	if (!xhci_has_one_roothub(xhci)) {
 		xhci->shared_hcd = usb_create_shared_hcd(&xhci_pci_hc_driver, &dev->dev,
 							 pci_name(dev), hcd);
-- 
2.48.1

