Return-Path: <linux-kernel+bounces-781880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3876B31826
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862F2AC3707
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4AF2FC031;
	Fri, 22 Aug 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVrDvw56"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4562FC024
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866632; cv=none; b=BBD9wEJuiU+P2KKYE/ty0EEnkQ5ZK6+oJsMEBUSeXkE5FHkmFXZHTVwwpOxbI9A1GwQuymRwZnIG7s6FftFdq7Cpat7xxbTcXJraQ5VHD7nVTDjdI5kNM3Hx74o4QNsLLEoncwa5Tdu81JYAfzmgNygc3dNzFGnDdz72T+p4+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866632; c=relaxed/simple;
	bh=uWyhkovo9u/RSrY8reiq6+PCibyXix46uqueqrb6UHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPsKB3DOuRhO0NB75mRjNZVN52JXJEgLGm8moF7WI6L3nFCOQ8+Txz7q9ajt646cjSbIiHiTqIXrGJoH0IKthaZv3wSzQWllC+xRPpqjE+J8drsSWN7JqYp7TYRr0jlBWkm2X1TGEt4eDwl40EIvStYJJDwNln24WUSGBd/ovrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVrDvw56; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e87068760bso236092185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755866630; x=1756471430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7esMtEw5QVw4oYW1X3ekJKoKg/sSv7ATs4TS+GU7jZk=;
        b=AVrDvw56Dgx+z9TWas8oxpFjbl0KGo7YVtIT9WFtm12qPuL76/KT8FVmoOGeGpLXIK
         /S9j7iSSF+TUhBYaL1Ckw0yckdLmLLLaUq+kEBG/bOLn84/LY/CauBx7IA/boGdR6Emy
         2cTVfNpyK6l9A5/ZPedE/yc08qJUIYDZWrQ+aLLYBdqLP0Y4vM7cxRxOXXGPa+NlFT8Y
         JQIwckoFpMbOj2o9Ey2lu8NgZ5SWwA47yCJY+iLHwKI9qg4oYCH7oaZXVIbvTk/duSsc
         lmu1BkhDsOfhi5PbIkNypghEpSF60qZlFIw/REVtLN4bERCVIIRFbAQWwZhzcCKXikSI
         Yq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755866630; x=1756471430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7esMtEw5QVw4oYW1X3ekJKoKg/sSv7ATs4TS+GU7jZk=;
        b=LeSgxl15EXhvsgfN31Dh+DAvRMtBrhYCOItiI/vmxEbX3DYBIHiP006VFpTT32bmUO
         wME/864J0w11l+KDMvqcacRqD7o3aKJaXoGOwClA1h0+WlKwuP1+2QjA7EvRQ15MEmut
         2MDCtjyZlz6BRkHv8ljKoZLyTnGOvtW2A0kuonS9LFQPVyDYSJMY2HALw2bw6ecD+F3A
         nyDnzO+XY2oE6pqs/PoQ4d3HwyzT9WW6MnJVAmickwyUSP6ZctsMC8m7cmdiQrnjfKwZ
         6N9MM/FSKuWdM5nAXQUXF0b9qrAAINht8J3zbkp5qj3eWNda5fend/7jLdzbmrznaqdN
         lTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4L7WHIfrA2BbkbE0WjTFXHgqOSQeN67OVO5tnVUXxSx6xibW1Alx+k6mts4viZr+lPHiBFk8O2vZnvYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpf8oGNIymimNB5NyqYoIFuuxDwk163HDscJAAPRy3lrgiwM7q
	FibJJlkctskKGCDpi2YOjgSs/BjtHduyS4wUOtr69BRmO98LEEuamm2f
X-Gm-Gg: ASbGncuDTgHyaKdmp7CkjYdZC1c2vCt9PBdhi+pgJ7zE5gE0x2FoQ1SJDWftGs9BnhH
	mOr97k8dizXE2FaHOvzKmYAkutRQp375oS5RtMQxB4+6tunp3uUsanVg4xuucRe518HjCcnmB0J
	oPPKlSGHCYno0TonKM5Pj4cmQm/zEXEeTm1wWB+4TKlUO728n15wkxqiK0mSS4ubYRWP4AB5Tvm
	WdSg0jADHeD1RqbS3BhNBJdRH7UNSRm0R5Np8hm6V7cJrVLqyM125wM0BTQWTkE9KhJve1K30aT
	cWMEiVZhUtH2P1SFOep+wuJGqpX2n8XSktZobqXOiyfkSuNq8BFPH4cKQ1lDmln7TByTvRb18H6
	1Tn/flFo3B9BoYUPus2qX+kPDKOQkhHxVNi+9K8X/gqx+gx7dgIz5A3FBtjmPi4WpmQRA
X-Google-Smtp-Source: AGHT+IFJvlSZLb/tgAdd91q76LLVRKtl204DpHq7u7KDDoCyrwGkQzx2iwb0ZjfCczYufx70JcLscA==
X-Received: by 2002:a05:6214:4c02:b0:70d:9819:8788 with SMTP id 6a1803df08f44-70d98198c37mr17724006d6.22.1755866630054;
        Fri, 22 Aug 2025 05:43:50 -0700 (PDT)
Received: from cr-x-redhat96-nsd-2.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba90b8dc7sm124756186d6.30.2025.08.22.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:43:49 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs show functions
Date: Fri, 22 Aug 2025 05:43:39 -0700
Message-ID: <20250822124339.1739290-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_emit() instead of snprintf()/sprintf()  when writing
to sysfs buffers, as recommended by the kernel documentation.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v2: 
 - replace sprintf() with sysfs_emit() in modalias_show()
 - change commit msg to include the change for sprintf

 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index c1c0a4759c7e..88fea34a55b9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -176,8 +176,8 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return sprintf(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
-		       mc_dev->obj_desc.type);
+	return sysfs_emit(buf, "fsl-mc:v%08Xd%s\n", mc_dev->obj_desc.vendor,
+			mc_dev->obj_desc.type);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -203,7 +203,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.47.3


