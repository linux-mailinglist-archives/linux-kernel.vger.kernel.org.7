Return-Path: <linux-kernel+bounces-789365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7792B3947A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEF1611A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BF28C84C;
	Thu, 28 Aug 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGPxJLdR"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29372AD4B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364467; cv=none; b=HjHBTq/UTz/3zjm5qapoIakYg1tPQ8MEOtI+HWZ7F/yJJdTv9pl4wGTpzooL7hjnHMQ+bL/okCjSI3bh0VZ1klw3UI9Crh+MqQWeJfljT+4P2PFGqJKcjxqm5GyZHARsP4ZO1ZCn8XBV3mc7fDXRbpwi+hfFM8+cMGjNeTGhW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364467; c=relaxed/simple;
	bh=TVdDxv6Nhc1b+K9+4Xic0/o6LDHnA/06Fm4sijz9Baw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n2GNjAzTpSLQFP0t027j84z2fPCswHHjmKGoGRF2ZjQdnMYadYHh8ctI6kRsvBddyO3/x8ZZ39WuCwBjwQbAchM+YlF5W1eRIhNr4bYKJha4vDeywiBqN2TUCXozK7xbXQPu/38uVuEUya6JAOK04+8XFDVDe59log2WZw/ff/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGPxJLdR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3276f3ee2c5so421760a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756364465; x=1756969265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aOcVnvWN8g6UfQh+XzURaGBPWpWkDYdfcs5GE0kaLU=;
        b=nGPxJLdR4/qJ677rqwHcmiEwCPvobdlHFHFvtebtrPyQrYMF9nMeplUGU/sfZ28niG
         NcqgmBRxYCRXMJlXgIWRK0s4PgbXXpsRZe0nsBztAAo89g/7DPMyo/+NCpoyR2C/3wxq
         vEQU3GmPWJ17k6PWgkKkcA94pG3muonVnAsfqx5Slnqih/jjBhKolVr7kK8XluygulbZ
         HFqQsugYwbc1h+UPfhNwBedm4w4z+G/u0sKv1x6R2i72hXLAZPPSjinMIROdccogt0mf
         1hOnv1cFPzhC4FpaFbvz/7imy++wMoPJYc8z/dH9tNVliYtzhAbJrKQymRarz2R5boUw
         IKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756364465; x=1756969265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aOcVnvWN8g6UfQh+XzURaGBPWpWkDYdfcs5GE0kaLU=;
        b=WiEsMEHiUtSrLCytobjyj1LC4D3EVZSazJt5pVMxnX97IsW14XLzoj2IM0m06SGIk3
         xOeS/sQHlOPL17LDucnc2Vmc3k85MfVUI9j7J9hV2dmJk4I4D2CiXRTz4yquKSQuw/Aa
         fA1c+bwWYpG3PGbI9fDL2REQWAVIV8CLyjWx7p6DNRW1KdnD8vIQXGW/6KAijEZeOGFw
         cdLuR1tt8KOqHTs6GEyPKnsFHCR9KStyTNSNbBsZ6ZSzeqhVye2awspi5XqpWxM5wlkc
         PhdgY01HW1nzzlJQ2fzGaQ3qxABE33g6PCT509qiacTC2AJyYtHG8tl6NLmD/KC9beXM
         11eA==
X-Forwarded-Encrypted: i=1; AJvYcCWPxAbdOxBaENyYwcgrqoRAfew3jMVOtCpW2zzoc1jGnp92PWSVwN/YBB1YpVZwpZeG/VnEsptrckTXeQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgj5W1JlmcDVnlcp4mzF/mWy3cA9n2u/xgS7I1/1OaK8HoJ6T
	+dhaA8U4UyTxoFgfAu6fVj+7gL61Rds3HDbgbFL3TKDW91fp4E4niJan
X-Gm-Gg: ASbGncsmsOLN8cQZbJWZPmQvA5cU9xE2F5mj7vmOUI2F2rSR/e8hWTPGVnUeXOsTihF
	GUnZRoSmFqT6RZUqV0B+oVyAfhp+uHdAByv6+MG7pB+rgJixcU2OdDz9qKeqV3/uEyMo1YUVOSf
	JyQHqjc1vD5clvCn3UF3yQjWbO/mbP2NqlnolTshSX/Qhj+vwZk0mlK3W3FScJKhscQzZEP+bz8
	hi4L7xhd0iPlUoVVc4W7p1hj+F+fClGhOaYzypSJ1QZGRgH78FZ7MS0XzDD/v3/hkB0uT3s69rP
	IZHZrC7/wzWis/0DhQLsp3Qa0YlSSpOmAav7bwEoJ13ZtN1HMzbeiE6IfQ5eI8zCGlMyspNpBBz
	CKIpepbtORoyEoEgbJI/sSIlbbvoDrXFUHC6z8LTqako1HKatpUBnDBdvlilOkrG5/uZZEXYTEB
	Bwl3DFO+wm4B4=
X-Google-Smtp-Source: AGHT+IFGQQsK30mCIpp68bAN9dNCGp0foY/SytgIaAfNqbLTP9wA1efm42gK0s3lba/qv0EaQY9UEQ==
X-Received: by 2002:a17:90b:3905:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-32518b82606mr32688817a91.37.1756364465327;
        Thu, 28 Aug 2025 00:01:05 -0700 (PDT)
Received: from localhost.localdomain ([112.97.61.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-32787c455b8sm1632608a91.1.2025.08.28.00.00.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 00:01:04 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH v2] um: virtio_uml: Fix use-after-free after put_device in probe
Date: Thu, 28 Aug 2025 15:00:51 +0800
Message-Id: <20250828070052.23606-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When register_virtio_device() fails in virtio_uml_probe(),
the code sets vu_dev->registered = 1 even though
the device was not successfully registered.
This can lead to use-after-free or other issues.

Fixes: 04e5b1fb0183 ("um: virtio: Remove device on disconnect")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- statically 'return 0' in the normal path.
- v1 link: https://lore.kernel.org/all/20250804075944.3612712-1-linmq006@gmail.com/
---
 arch/um/drivers/virtio_uml.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index ad8d78fb1d9a..de7867ae220d 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1250,10 +1250,12 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&vu_dev->vdev.dev, true);
 
 	rc = register_virtio_device(&vu_dev->vdev);
-	if (rc)
+	if (rc) {
 		put_device(&vu_dev->vdev.dev);
+		return rc;
+	}
 	vu_dev->registered = 1;
-	return rc;
+	return 0;
 
 error_init:
 	os_close_file(vu_dev->sock);
-- 
2.39.5 (Apple Git-154)


