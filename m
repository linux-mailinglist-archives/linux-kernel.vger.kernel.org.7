Return-Path: <linux-kernel+bounces-869297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29392C078ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCF454ECD81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F234575E;
	Fri, 24 Oct 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="zUrOfAjA"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F47D515
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327324; cv=none; b=ITAqgAI9D//VBhSnC6YsXp5b/5PlGw77vM6w9sCZ9DwHW14YlbtbX+M9F2anWyQZQBuEWPRzLtUJeKM2zdhhdS2f5p3yxEtIsos0IvsxjuicJdmGLIkVRjPRTFcrEIMpJdEPhiwJfW0YDsl88+ofg91ZRsMoS6Gk9Yo3q79BJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327324; c=relaxed/simple;
	bh=mXbvfEQIbRLg6rG81hv/RTX5vCliwJPhPkv+p8Gh0do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THFJ9kAtQ07lFhC3owiOLJaTG45jkJDrq3yOlHtQBUFkXr97bNZNK1y1Dyj0w+3FH2gvZKMP4V4uH+kc7/HroYOK7RTihwwWYyTdYvosOMp7285HfS/90RdcAaYswMdJJKaUWSVBm9KvZMHswfEJ6IvVPER+lKV9U4nmN/KmgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=zUrOfAjA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso2508721a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761327319; x=1761932119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wXMbYT70NLPu6BzjWG2yQn0RfjMWdVCvvig5iK24b+8=;
        b=zUrOfAjA4gbwpwVBPIWeL/yJ24jwA6Cy+Jn7x5i34KlWaMH7oxDOeahosptwn7JAkB
         By1TeAhEJIOo8wghuoC/58w9xT57DyWDZPwA3naA8z0Jf94dYA3V7PsLxDHMUMMUdEKP
         TLyVvZabXAAZO/g30iGA2NHwB7UK6Pqu/ncNG8htfq8cjTOiEvs1jI2QTBwSVae5zW81
         0GCVMtUcrLDOB4d7sWG+7dTh9kHrTflfU2THsu2AjqrnXPXTzjLvo6hXjyYv8kRUnODP
         TLhweAizn2zTJi5wHKkSGiaU1k4a7ndDp2+SAjSFDJSYZsARKAmFyxQ0qoat87CPi/0o
         LIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327319; x=1761932119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXMbYT70NLPu6BzjWG2yQn0RfjMWdVCvvig5iK24b+8=;
        b=tQ0s+PanoLtUMyTkz3+tRctMcybjXfRZ/EqdtUVzOrQuhb5AUbvKk/pbIIT+mHBLzz
         CCIDKfmjAjs3DMGHGffqa8XDjxjQjz8hwJCnRsmSkZgfGpvwqQV7t+LxeQ9NFChW4u2n
         qjrJWoWmgD6i4WyLDtSkQlvLT9JvUaLm7UC6vzh5s2Bykt31nIPD5O0sDDWK1n5QdXAK
         +aRBy1yc2jf0UyKWc9B1wKb2NggnplN5CUQ6U9BKK1Ol06TKk8MJH/pfo+FYmjLuTh5g
         fB3/mqwZjOywkPGHtVSe2I+mzq3kKFGkhH/ZcvUoNrDDghwFeZvyfXX6qmyS1VCr6Vp4
         3edw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBrh/GVIXd8qUcW1XK0/uUqdumqhsK5mbOWCdWEClQXfUAZyL6a22Hc1Sm6iMR0CeJWXs8AFM3bfGWd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQr4jjJ5483/FI0D5UwZYLHLAyzYQAS7ie//1Zp1QRBfRC6Z4H
	CrrOGCqX9KEJgPNAXGkIF1e9VWQ47/uWqCAwSSCFcaesaHMRhsrwRDLqVGMePjwpDfE=
X-Gm-Gg: ASbGnctz+hJZZBIklFfpt43lQAw9BzBIZBYjovl7nVFxS9pXS1E3/d+64Up7T4gnqH6
	hiPoncnT334enc7GqRAZ5LzzVK26SsiBHi+ZAN/EhQ8txwEb6esnrE22msuKaE2INx4Y0XtAF/0
	Xv360GP5e7VJYgZhOt8+arqiuOirXBCyqYhz1yjKnNkmXNEy7uAVTQ+f4Dj4cVfnVE81ShZyZaR
	grD+BGCB4zpH5pv4uxmM00x+5bBP0nA5RV4TEaAEhqPz3fmjZh2Z2Ikc/i1eCg6Nst0GPdwNX3y
	IzCBHY7U9RYCqMKQjGiyMDzSXflXmLsjwu43UjL0qhbrLiZybvzxs+n42FRbsHyOH3Igq6rwt8h
	aEKhq4QzSz1KvOrqomYqs6/YXWASqB8Burnyn9t7bydOR9C4RW3mjqKmb8nWg19/8R3Uk0liBq0
	jXUc9N1C9JnZ0BU2sSw3awCg==
X-Google-Smtp-Source: AGHT+IHbzB1znYk97aCgMkkEMmeYysmxrGDyagwXbgG0SJG4dkZL522tTgvCl4oWdxBmjUyWPIlk9A==
X-Received: by 2002:a17:90b:2d8b:b0:336:bfcf:c50d with SMTP id 98e67ed59e1d1-33bcf86c98bmr34552973a91.14.1761327319578;
        Fri, 24 Oct 2025 10:35:19 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33e224a2652sm9915918a91.18.2025.10.24.10.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:35:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: isdn@linux-pingi.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in hfcsusb_probe()
Date: Fri, 24 Oct 2025 23:04:55 +0530
Message-ID: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfcsusb_probe(), the memory allocated for ctrl_urb gets leaked when
setup_instance() fails with an error code. Fix that by freeing the urb
before freeing the hw structure.

Fixes: 69f52adb2d53 ("mISDN: Add HFC USB driver")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/isdn/hardware/mISDN/hfcsusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
index e54419a4e731..378d0c92622b 100644
--- a/drivers/isdn/hardware/mISDN/hfcsusb.c
+++ b/drivers/isdn/hardware/mISDN/hfcsusb.c
@@ -1904,7 +1904,6 @@ setup_instance(struct hfcsusb *hw, struct device *parent)
 	mISDN_freebchannel(&hw->bch[1]);
 	mISDN_freebchannel(&hw->bch[0]);
 	mISDN_freedchannel(&hw->dch);
-	kfree(hw);
 	return err;
 }
 
@@ -2109,8 +2108,11 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		hw->name, __func__, driver_info->vend_name,
 		conf_str[small_match], ifnum, alt_used);
 
-	if (setup_instance(hw, dev->dev.parent))
+	if (setup_instance(hw, dev->dev.parent)) {
+		usb_free_urb(hw->ctrl_urb);
+		kfree(hw);
 		return -EIO;
+	}
 
 	hw->intf = intf;
 	usb_set_intfdata(hw->intf, hw);
-- 
2.43.0


