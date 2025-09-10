Return-Path: <linux-kernel+bounces-809773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E6B511E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1013AA104
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002873115BB;
	Wed, 10 Sep 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoUbO+2F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46630F7F1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494607; cv=none; b=tUaQUwqtBjGQrPd8su3D/z7OnXrP+feWmMoQs4pMHzE80nC1QQXo3HNDsRTeHmRzj8ILGQggtTyXSps+XEHxA64+cbjECjW+pVauEmGi68WlCLe2r8kcktUNR0NNtGsDxcQSAvKzWO2fr4PPQhZZyknG+v3csjXQZDy94B93JB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494607; c=relaxed/simple;
	bh=oIER+SSaWj5q2B/7maqY6YrRAc8TAtXtsVduNhMEM+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ4WNflCYMAjxwXWFUaUqDJMWqV3f3UPXUB0M8XHwfgaJ8KdciQFMNSVsmudfcTf4d592//jABVNSKE8k0LsdhEu8qZla0bFVhXZjUpORHhj09VxlTgDdpdRiNVgzz0d+ajqHD7cNhDAeK5WuDeX8Lgm1/G9qg+KepFq9w8+LQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoUbO+2F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757494604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fytt+SdLHUb8ufJubForkl+i4Nu4NalKZH6lY20wByI=;
	b=RoUbO+2F1bQJRifqweBHAlCYDfh0MmlJEEMOcRpwWb80bQ3Wqy+zu81JbbaO07ubvR4mdu
	5x24nFr/gxVNAuHu6asJVhaYeZ1Yb+l6mMuOTrJtKrXkw9RbfSis7dIvjjrVab1EB/LJU7
	xGsKQhGy6jnt60bR4YDxAcDeX/qDlig=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-K74BPi-9PaafE6sbjrpDkw-1; Wed, 10 Sep 2025 04:56:43 -0400
X-MC-Unique: K74BPi-9PaafE6sbjrpDkw-1
X-Mimecast-MFC-AGG-ID: K74BPi-9PaafE6sbjrpDkw_1757494602
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04469a376fso781199766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757494602; x=1758099402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fytt+SdLHUb8ufJubForkl+i4Nu4NalKZH6lY20wByI=;
        b=TBqAqbnGHKQSJ5YRvfDcVA5lrT1hRiJMSKftZMN2FcEhgjBTwwSqc2xP1N3iTPGP+4
         b3s166jm+G6exhdH+d19kYQ9w66cD/E1HP8AUmdtsMmrMfNEMiNLsB64U/4Xu8Kby660
         U8fD8IN0UefVzlk+GCX8N9fVf50SvrZaU0HsJxl8gd+85wh6DeUBTu6sStxDXGvbxpHv
         wccQ8DHRhF/qP/efe0Z+uSa/UWRz7zl73/KSf9KnjmwcKcb+7O8UpyPZJXklz1q7Cxhp
         /KbnwG1q0deSO4oG6K5U0lrQ21d5EDz3HYFnuIRF6gMjC7IxFkauggBiiVHi7RBsZH/c
         GWWg==
X-Forwarded-Encrypted: i=1; AJvYcCXX1trwnWqvzZqz8kpvAi2woBfpV2OKD6pJVzWH+QbMnbhDow+5eNHsUje5PpbtGxchvBj2c/ksFpe6gcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpiIroDgmON74FTXPgmmaNGS3pqC1YZaGMgw8JRtAFanzs4Uf
	oseXDoRLRCQHFzJp8lIGQgr6lpT6TecDbOqCJdSoJj9Qp7kEbyz5S8K3dyJNdrdLZvBnEksYG7V
	linegqcgwFg8skbBOdEZXIpQV7ol+Y8c2D8s9GLDqBInGayj/1hgDBOGEZ7IDNmJp9Q==
X-Gm-Gg: ASbGncuANjMqqK40hWH6el7Eh3nFy4KrTTk5/kQ+gtipaeroWYp/4y/gODbnL9zdiOy
	hEnBp/Se6sXzZkL80hFMxHELGCXvfQoFVXd+IcoKkEGdRISnVh6ckErRCTrZXZ1M9XLf5JzJUsI
	fTG8CmBQviaNbWuQnOSEOvYs6P2xp3B8RJKjVN3eaAMsTxTnc+h+fJlo9/QD0eVjHdGaKqbsB2A
	+652V5Qr8RR4cb1XnJ729uWeTc2fKXq2NF1oKPDvXHtPHR9fCs3p0qclNreA8r4U7J6tk8l8ABu
	KqayOcxdP6L9oVrZ3OrY57LjNP7VU5NdF/5LhGASB9tQQxtNFQdF/ZNyJFCkJA2AwJVaIo74T6j
	hmr++UDRqGs08+w==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id a640c23a62f3a-b04b13c174amr1250436766b.1.1757494602167;
        Wed, 10 Sep 2025 01:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9IF0gMjbTyuyEkGfSe2kM30YiqJRhQOmvcAmj1Ufv8t2CRUzDLcv7hw2HV0ZOafNwmGqrIQ==
X-Received: by 2002:a17:907:7e9f:b0:b04:6bb6:c91d with SMTP id a640c23a62f3a-b04b13c174amr1250435366b.1.1757494601803;
        Wed, 10 Sep 2025 01:56:41 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783046d34sm134309366b.6.2025.09.10.01.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:56:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: Add doc files on real-time support to Real-time Linux
Date: Wed, 10 Sep 2025 10:56:35 +0200
Message-ID: <20250910085635.47724-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit f51fe3b7e48c ("Documentation: Add real-time to core-api") adds new
documentation on real-time support, i.e., PREEMPT_RT. So, add a file entry
for that directory to the corresponding section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7175c38c6d1..e2782810d0e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21403,6 +21403,7 @@ M:	Clark Williams <clrkwllms@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 L:	linux-rt-devel@lists.linux.dev
 S:	Supported
+F:	Documentation/core-api/real-time/
 K:	PREEMPT_RT
 
 REALTEK AUDIO CODECS
-- 
2.51.0


