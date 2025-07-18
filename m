Return-Path: <linux-kernel+bounces-736393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD0B09C54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E45A4080
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5921A436;
	Fri, 18 Jul 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3zVH280"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55041DEFD2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823549; cv=none; b=RFWZwDe2CzigT02Gy9EY9PDHhk20hN1v+9Vz0Jbwjjm0WQFB1ciqRDRzjBCWxc5Jg85vOh8UGLR7PT+9WTwOZXZprL8gNZdpMPs+OCp1lZmqtEKXv7HD9zQMER/YTcLfrylgNasJScwABszo+R8NbADSHyvthFtSdC0OO17dCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823549; c=relaxed/simple;
	bh=cnrhQ++7CMMItxFL5hZ5wxrQ1WQUOiCTN2n85VEJNIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XaqzL9IDR/oSrrVc9ROwrk66+Yz3jtwU2os/MC2PBizrPx0fF0FMb4eu6zZ9GF19RvrBuBNrhiq10I79Fq0xzU6tq1bufR+mNq3SuNcCrCgNCFFG6hhhh1MdyH0l91pqBNoti1VIPyjfFksGKYcohRcz6y8GJ+wi1UGzCT0eNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3zVH280; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kFXoy9kzFlqwCymBjKPHfJn9o0uwlDNldK3hIukHAHY=;
	b=P3zVH280t7q64pylh8Fw/xGrCUnBHYENLLFMEIfQcFUHj6D0CgmdjPfzSkq89XevN61pbw
	J3LWdQysbMGdat/52+K7fD0nxtJbghtdjmetEkMo3km/I308UXA0SzMbWexkOHcjA3PN82
	T8ZLwTtysgGHl5eozKHi1TpPbZozIbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-QGc2lMYWN_WPjwlPHQId2Q-1; Fri, 18 Jul 2025 03:25:45 -0400
X-MC-Unique: QGc2lMYWN_WPjwlPHQId2Q-1
X-Mimecast-MFC-AGG-ID: QGc2lMYWN_WPjwlPHQId2Q_1752823544
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45626532e27so11314675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823544; x=1753428344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFXoy9kzFlqwCymBjKPHfJn9o0uwlDNldK3hIukHAHY=;
        b=EZf/as5OWZsthPz7Ww+5zaWSgKzBm3gUSllra//qg551rTfpgW1I5GBi6HcWImp4uD
         IN8FLYWle331d6a1+ln/mG4KmFDrWisvl/A5JyMR+6eznKitTyW9pTDfe+wt6f9irY20
         nCpcoFYhkRejhiGbkxGict/ImsGksI2LyF2gQMJDtf0Bcs6AYsD/t9vMyrcPATbK8Wet
         pxHGW3AJVXcJmxqZ7ZuvqIm60hJHl3bJcivQuKzd2SZPMgtPOp+9/Jno4DkuZ2k+dg94
         YNBL+fosu+nlT8ol8necZde8bSTBqdsXyfScwju0m9gNPyk153ijO6gTfekcvPi46PMn
         NGiA==
X-Gm-Message-State: AOJu0YxOY5GY0/Z4DYiTCk5n+oDDvHIz1dWml0qQuvqI4o8wRrdDgA9m
	u8BrvZ3vAr0sS+fBF4oRIdQdxJQnwjvNJI2Bbwza8kJuGFzoCCZ1dHKkHgmJb/yMUdmwCaIad4w
	x61Gbcses2gnvUKEVc71umqEhwH+xBZMPIAHrg5GOb5aq5+j+fNwwUqNIiDnl6pGMD2EQRsrR71
	UGo9vzFUJbk2eahCxOKAUfqm9Jor8zVhGa1maCByK23eZHKkWnbnA=
X-Gm-Gg: ASbGncvjtBCnuDJKmFLoIF/oASE+xFSrRZ24rQj6QioidSGJPhp2LaNfID6gY+2oc5o
	ZIVnduSAgHuLUBWYN2wFyRS6MbMUo7VL1GGT43EmeITFdmSmSFtaVcjDfVfw2Ka+4mYFkeBLcb3
	jAEmVKPPYvBgrGdosI+LBRu33WSdZMx/xXF2NGTiDIRBmMOJVGTIVtalS1mj5d7Eeszce6bVhJ+
	4agiu3p4oGezHwq7qui5PUx+YTU8r25jf0mxDDCxuWITTteVgS37AJz6FUDGI7HEPeSZgitOa4U
	9uvtW5qspTXp2zbVSU8+mARxuZqB+9Dk
X-Received: by 2002:a05:600c:8209:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-4563253d35emr77989045e9.15.1752823543663;
        Fri, 18 Jul 2025 00:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsmSHWnpWSP474DVny4lRudPIL5Icor8N8CONMsUxyvG0gl5+BmAJlggp4ddRUlauz3pM0kA==
X-Received: by 2002:a05:600c:8209:b0:456:eb9:5236 with SMTP id 5b1f17b1804b1-4563253d35emr77988655e9.15.1752823543133;
        Fri, 18 Jul 2025 00:25:43 -0700 (PDT)
Received: from localhost ([89.128.88.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740c51sm11782085e9.19.2025.07.18.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:25:42 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	kernel test robot <lkp@intel.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/sitronix/st7571-i2c: Make st7571_panel_data to be static variables
Date: Fri, 18 Jul 2025 09:25:28 +0200
Message-ID: <20250718072541.686759-1-javierm@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel test robot reported that sparse gives the following warnings:

make C=2 M=drivers/gpu/drm/sitronix/
  CC [M]  st7571-i2c.o
  CHECK   st7571-i2c.c
st7571-i2c.c:1027:26: warning: symbol 'st7567_config' was not declared. Should it be static?
st7571-i2c.c:1039:26: warning: symbol 'st7571_config' was not declared. Should it be static?
  MODPOST Module.symvers
  LD [M]  st7571-i2c.ko

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507180503.nfyD9uRv-lkp@intel.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/sitronix/st7571-i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 453eb7e045e5..7fe5b69e6f2f 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -1024,7 +1024,7 @@ static void st7571_remove(struct i2c_client *client)
 	drm_dev_unplug(&st7571->dev);
 }
 
-struct st7571_panel_data st7567_config = {
+static struct st7571_panel_data st7567_config = {
 	.init = st7567_lcd_init,
 	.parse_dt = st7567_parse_dt,
 	.constraints = {
@@ -1036,7 +1036,7 @@ struct st7571_panel_data st7567_config = {
 	},
 };
 
-struct st7571_panel_data st7571_config = {
+static struct st7571_panel_data st7571_config = {
 	.init = st7571_lcd_init,
 	.parse_dt = st7571_parse_dt,
 	.constraints = {
-- 
2.49.0

base-commit: a55863ba4c9ea9febe81ecf7dba36e7989a37b7e
branch: drm-misc-next


