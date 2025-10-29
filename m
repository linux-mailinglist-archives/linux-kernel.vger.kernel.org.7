Return-Path: <linux-kernel+bounces-876136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA2CC1AA96
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C749A565AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714D2BE032;
	Wed, 29 Oct 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zRq4ZVv3"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CD2BDC3F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743601; cv=none; b=hOiR98c4YF8QOyvxVOiqgVpTe5IUVr77kGhAhZhVCy4qyiSkAw44GPW1ih/52UA7T/3VGBycnkWfYK4oyGP+cWbSMek8ThrNHccD28JjbxE7A1BH7244REA/39v8a01i+bDbLo2X0b55NJojg69LvY5P8z72WCzmvlEhVeVeGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743601; c=relaxed/simple;
	bh=gKP7Hj4PgjLdlCElLMQoEHfgYE8vw4zIpqeIgVCFNzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tWNBAdxM4GbjVgGU4gch4Le+jBhfeupiBtMJ5XVCOpwYvVUFG3u2DgTwHlpviuWSg1XXd31V0ivFqEN68idzSnZkgug9t5+I7lSft4RYQ+dotaITIBYW6hPisjL8hfb1KcNry4l2hVuysc8sBFqJJdk5I4Vnjag/MOA+L/KrDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zRq4ZVv3; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so7277401f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761743597; x=1762348397; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fuIsZJAikyEekZcQ72lnOaH5lxPiOYkA7xu56IYCNWg=;
        b=zRq4ZVv3ZfmNe56SwASuyxsdNsJWgIA2rm0czxuAwnoQ/oa0ozvwewyxCewZ4XySnm
         t0s7+jAMeV3rRuSvvDBkVYO4isGWsoTD4ZU1V/n0T/XJdbQr7DgMpq+DAiSDCpQzD7Bc
         iRIpd1PEzDsY2HP9JwTZROtwOma3levQKCxvrTAyes/0l+Uo6Ogxkj194Ffxn9Fb+0Ie
         knFN/sw2b/21qgWW3wNxbNcPgE8rz12hA2/JdSV9cKbNsp9zCtrjL/9fOkBfWLYUDy6+
         hMZfGe2TDxwQtHRsAKLzZWEHMhLTRDSZvrkhIjCR/J34TBB3VfBtWKnJmhULiDGkRtaZ
         gQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743597; x=1762348397;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuIsZJAikyEekZcQ72lnOaH5lxPiOYkA7xu56IYCNWg=;
        b=r/hf1SWDIgnUIpeArblHxudacdweX5uJ3YjMFp3Ekns8qyYM8CxxWrPhA/2Zo332HB
         +Q6kV0sm1V9uzr8yFwcayeHLH6Fd2U9hDyVMBQ3aEXoD014QNSgOwZ2sac1yOECBharE
         qwOKc9jb+fb+9L+W67Kny4+Ct98602Dzjm/fwzn6cvfQY9Pf723HdE92Yxif8yq3/cGq
         PNqTt8filvjqWlR7S9TKm/YrQSGkYgPhAW0eXu7NeoTU4gad3U0FMGXR6hC/H7mI2fPi
         n8a5yS18v1injxQRUh9D22uGR18q1SuQAnPgWVDfF0iD1QoSGW8HXHKL7pu9Vdj8Bh+G
         9MHA==
X-Forwarded-Encrypted: i=1; AJvYcCXSsB2OuTNFtKfFcBiWP/4C4mi2L+FK4UoaTtbTypEYPgoaCGem/+3SwSsRcjf3uvNu6bSsu2wEO7PPkcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXJswKhG8dHHMqi25aVx6ovAGR52Dsn0hedybKaRtinkU+OQ6
	exM5XGGw9hVSay5ykjBApkPigRm1PknC+Nwq8dGua3q+BptzVZ7mTnpEBI39m9Iopl0=
X-Gm-Gg: ASbGncsHdDNmulsgXNlYmbQhbd29gHe0dviUFCYZEICJvND4p8W3665JWr9mi2oXR5a
	kkh/+KhuoWVfFTpPWHX6kqSjYRtS5Sv5hIOAa6BNX/ps1CNOVT1/JXFWHFbSJvr3aRN0R5QMe6b
	lsPhyDrLppv9+Bn4jLjZCb5YmoqfTrKhYD1CFyE6itZsKWVuifrlN83Wd2InWsLJyAusCGCw3Gi
	tAydN1tI1+tZSargLtHNW7MpwRYazMmpcuxkrVRon/hTYkOIOfsGR7YqvRYrFus8Wn2tBlAGZxj
	N5Fa+Gvq50/Wu9Xk9OWbX1UTDIUjKGwxI55sNLTKl0uMNS0z9wV7MirmqtvHjsMiAyH3Yx6Jqw1
	qweXnakfe2WCM7oQzDRtOMXiKqf/JICsmTdvkgCTweoMUmudSlFGqKZ+OJqlcE4G7PE/B3xFRZO
	PFhp5PqK1Cw7VzBUXo
X-Google-Smtp-Source: AGHT+IHWVrau2m4RaNjTyO72rP9dhKVo76M6sAXBvO9VLZ1VFeKc3lw8F8BaYPpaPHfy3t8Vo31Ixw==
X-Received: by 2002:a05:6000:238a:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-429aef795fcmr2632000f8f.17.1761743597111;
        Wed, 29 Oct 2025 06:13:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952df5c9sm26362401f8f.41.2025.10.29.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:13:16 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:13:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Umang Jain <uajain@igalia.com>, Stefan Wahren <wahrenst@gmx.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: delete unnecessary check
Message-ID: <aQIS6Q73Ss8xyJTD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Both sides of this if else statement print exactly the same thing.
Delete the unnecessary if statement.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index e2cac0898b8f..130be2f58342 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -4001,10 +4001,7 @@ void vchiq_log_dump_mem(struct device *dev, const char *label, u32 addr,
 		}
 		*s++ = '\0';
 
-		if (label && (*label != '\0'))
-			dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
-		else
-			dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
+		dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
 
 		addr += 16;
 		mem += 16;
-- 
2.51.0


