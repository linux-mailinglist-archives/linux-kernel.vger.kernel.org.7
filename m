Return-Path: <linux-kernel+bounces-813361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCACB54425
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E261B2762E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D962D2390;
	Fri, 12 Sep 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf50OEvk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9522D29CA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663214; cv=none; b=VErptTQgcCozQvq1zeDWJihh5Z9kW08h2Ts7UEPRQD1lElDMzn//f8cAeUPHxai/QPkMeguk3LJWzydxvtPCo+FKA6HW5zFLqpUpFYXtxfstqrR/9zUg19PkhGlQmTLDhI/5d7GYJr96iZlTxE4fR3dqVMQwtGfncfSusdRMdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663214; c=relaxed/simple;
	bh=9yoMY6f/O5Kdo0NFe6sZTx5s/b+R/IevS2MD/nCV13s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aD1ULJBqj1MYiEsO1+dqq4636QZADJ49Odxcd5OxIkTDSIPswG/nauhleo/lFuY7nnRS+/XM5jQpjlJ+DArJhW/SFYh7rcoa/kGbv/8z6LI6oxoXi7ON6uuKc7Cie+vbbta4I81BMkpoM+hbfgn5n25Cc+T4KNi37+uirikijSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rf50OEvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757663211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vvaALMZ4+zN7uBMG4oemyZs/dyL2tuTURio8S2qM/9A=;
	b=Rf50OEvk/8W5RSEYbPLpQyEjscY3cz5YXF5maP1BSkSZnCEN4wvPFnjzWTyULX+mdotbPS
	Vx9osAXtcvnGeN8mZZd90U8WKmEuvVYmnzHfYX7ETinpzMSiE/UxOpKvqvFA3RN669SK2A
	I+F5jMp46B8u19lpXLagrjs1wmF/mKE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-9w-viscXPsidKv89_m8xpQ-1; Fri, 12 Sep 2025 03:46:49 -0400
X-MC-Unique: 9w-viscXPsidKv89_m8xpQ-1
X-Mimecast-MFC-AGG-ID: 9w-viscXPsidKv89_m8xpQ_1757663208
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e76376cc75so686105f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663208; x=1758268008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvaALMZ4+zN7uBMG4oemyZs/dyL2tuTURio8S2qM/9A=;
        b=q5heGc30JZx7sJmeshYUsBqs4kWEob+AHkO345sYfXm30ptySX9u3Cm5W5K98Gegll
         yXeCmyRSVhkTCIkerYBzl8M+G9OI9LVDi86RwjAE7CVco9+CfmPnroWydstbmCHwN+mb
         JUBgfCnNmh63oUTzL8Nm1+KfM+4l4ks3CtQcx4LZJI0lr0ARVd43XHtwUCp1flRP2P95
         U9d3YvGHHFAAOXE/PQ2xQtDWlkT1J24NJMPMCmWpc4YN2lbigedKa3hrCQRjrMdTfbPy
         BKkzoqaNav4Y+2ttXvaaFoE5u3EJfj7yxx8iwEuaSfvCHms0AZBTLmfcUDiA9DknRgZs
         EuSA==
X-Forwarded-Encrypted: i=1; AJvYcCXDmkKSZMZ9aXRFg+ggZwNjeU5iyR6bAm1IiD3s++HXnq0d+t6QAXIsq0K1x1StLwdPNNM3AwaBbCztZhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+eQjSDLiYipL1kfm9PDBf9OVmS6tQ3KxoVaUpNQ2f5ifMTGB
	ldp189+kWZSwJFMXXuVyKI0iWQW0SUn0ysLPNUtWdQV7LPxAN5eZDK/iKvkyD0/q8d31CvPssCu
	Lh8yVlQnBrm/HggIu3egMkwxzCtmXVJ510Y09yRoHUz041NvVDOCCKeRZid5GFg1rIQ==
X-Gm-Gg: ASbGncszWRXRYowrtCHBTTTD9pjb7rMPpO4IN5qzJzJIXJu7wdUl1C3qlEDncDad5kN
	f7T0Rl+klV9Puv4iwixQ4RyzXGLWjh72BJFh500gqR/cbhhRmdz31sjh8Hulb8yIiSWEjQ8L78m
	CTbsda5tCYqIaRVAtqvEmuiFCECrpFd3bmWBECSjcgyAN7T8PYI6UPJ8KW2634JQhHLKQW6tN54
	LkpoMZZ3yvBo32aIwizMCcCTC7crZDt6CNlMXx58yLznzCDEQMyJUopB8MX50gxmLaK1J8DvXOe
	QFDnmrlqfy7vkdQ+zT8QSv4pgBoIXhPhArOOP4uTJMu57qpt1drMWICQf8WOHCKzQ26QXdOuafU
	aPF0eG2O70kJL3Q==
X-Received: by 2002:a05:6000:2891:b0:3e7:620e:529e with SMTP id ffacd0b85a97d-3e7659ecaa7mr2028795f8f.43.1757663208173;
        Fri, 12 Sep 2025 00:46:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm21ubE8d+dHPSjquWE3BgW1E1TkX8hsLoEa0HPJgLnT8FY+Bw9Zzo9lF6e6QuFVRZXGNdUA==
X-Received: by 2002:a05:6000:2891:b0:3e7:620e:529e with SMTP id ffacd0b85a97d-3e7659ecaa7mr2028771f8f.43.1757663207787;
        Fri, 12 Sep 2025 00:46:47 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm5362628f8f.36.2025.09.12.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:46:47 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Lee Jones <lee@kernel.org>,
	linux-crypto@vger.kernel.org,
	loongarch@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in LOONGSON SECURITY ENGINE DRIVERS
Date: Fri, 12 Sep 2025 09:46:38 +0200
Message-ID: <20250912074638.109070-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device") adds a
driver at drivers/char/tpm/tpm_loongson.c, and commit 74fddd5fbab8
("MAINTAINERS: Add entry for Loongson Security Engine drivers") adds a new
section LOONGSON SECURITY ENGINE DRIVERS intending to refer to that driver.
It however adds the entry drivers/char/tpm_loongson.c; note that it misses
the tpm subdirectory.

Adjust the entry to refer to the intended file.

Fixes: 74fddd5fbab8 ("MAINTAINERS: Add entry for Loongson Security Engine drivers")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7f80bd7b2f..a1339a8bb705 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14537,7 +14537,7 @@ LOONGSON SECURITY ENGINE DRIVERS
 M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
-F:	drivers/char/tpm_loongson.c
+F:	drivers/char/tpm/tpm_loongson.c
 F:	drivers/crypto/loongson/
 F:	drivers/mfd/loongson-se.c
 F:	include/linux/mfd/loongson-se.h
-- 
2.51.0


