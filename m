Return-Path: <linux-kernel+bounces-838456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE72BAF365
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE47117C436
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D30E2D7DD8;
	Wed,  1 Oct 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC5bF4Wg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411CC24DD17
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299380; cv=none; b=OuKCw7lzMgESZWCzl6edC8lZpJjYDXYMXefOv8IiVXMW2XTxZQW5AqFOuLVJZfxPo21yWjB0Ha+cROmywSFcH+pQOjucPUsBxHAH5lwXMh8HTWiyXmIoAJvGPLGJpl/j5q7xlzImAX8rxaAs/OVZyNmdENTeK4IvNHXosG4tUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299380; c=relaxed/simple;
	bh=zTZvQvz7JG+APZWziums5mPjsnmOIULh8ulG7LVPhkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdED+qR2npMQPJERbglgcqdqhGA3NMoia1swkKkluxmcl3DsljQxskWoXt7cGl8O7xJyi44ZEFy3Xuz6EvE38q6mB0mGtMH9L/+p3VvdjPlGFdbBihtC2ogTzAUgfDd5mZo5207ESEr/adKE7sQGfvfs/CJyuGRhgpIK2M+tKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC5bF4Wg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759299378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gaStWL+ntZFUm4T3e327BEdVCx4LxQqNCCOu6JDj8s=;
	b=GC5bF4Wg17KMnlRvr/oDL+vS5/6HyGJBZnmAf9APvuhtxDUFvtBoHQcsZ0uVc6jiJvgOqe
	vZMbPt8koOP8yIbvdhMwIVHiLS1kxR23i72a8G1vSs4giXXs+FbquAYfEGeD7a3Egg1jm4
	OV48IoFIqZAaliNfERRZ1XOKlsjibUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-JHrLyQX-PV2yD0VaTMRRmw-1; Wed, 01 Oct 2025 02:16:14 -0400
X-MC-Unique: JHrLyQX-PV2yD0VaTMRRmw-1
X-Mimecast-MFC-AGG-ID: JHrLyQX-PV2yD0VaTMRRmw_1759299374
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42558f501adso106637f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299373; x=1759904173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gaStWL+ntZFUm4T3e327BEdVCx4LxQqNCCOu6JDj8s=;
        b=VV/wKzbd0o9XwklGzwdPOcR5p7rYFozP7cHMELpvN/T2F52m/Z3okEjhHoFPPEghVB
         NDXFjo+tVBwC9aKdIetVeVcn2CV87LXs52pOyVVHP5mgKduIPGx7LNEwmGfP7POOvIO3
         E6aPk+z8c2q3A8L1FqqLUb+wqtU+UXUh/G9vaJRwtPGAfobd6miqHeo+q9dR3eD+AZOa
         pNq5NYr1Qtvlim4+kWjqarCj3QmUoMTM3QVWUYC3vmDDpMHnQ5IuegihjUrR6DX+eabH
         EtDSjnaToTF9jwxWbk0ni889tpc9dKc/fvQXRT/90k5vymRYnGiK0eynoNBWhMxrbip3
         gFZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqVBG40lm/CISCNrKgYBOKYYKrGxJbLUMSX8VPkQOFyipIOAxhujR7Pjx6F2qe23c/KQ/SAFgOTlBpX/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOy4o7cQ0z2D0v133XnPZLMxbd5Kh3p9FifSOZOwaPvEkTMa5E
	nQ+PlaMvlvvl+Q/s8VsmN6rRqMpTvsTbTUzLkxfS6T+AfDLIiNB1DfvnUM4ipd2CzRFbUkd0dpI
	JoGIQS2kg5S8w27e71gbSXrg/A+dZK+Y4uRRa/sAMeNgvZvKwYP42l4WtL/Fbwr64CQ==
X-Gm-Gg: ASbGncuEdIoGVR27RWPIx+J242vuZpRculNT9IwgZRY24a+F/iXesg1tv7CsPz1GNrR
	IehOZ+1t4aJyoQBCgBnlCGefy2I3BPsn28DPMNR5GouNCxQDpMTGMBplZ8k28ItVAn68V5zWraZ
	LP4j8rfhCGb0nNLZfRZ+/e8t9Eg0bhNvwgyVCQo322CHV35yurxnVC1UY8/cRf0co+RmEWO7btt
	pjiL+WnO76uEdjq/G5bLtF9J5I3z11RbOJO1+yXiLYpmUJTxupw9EKWxOf+J45lW6c/ZscomN7e
	OIkgRHDBQN/ESzfGp/XlaHmdl72Dd1oKJbzuEADqRAUbLHv8kZ6NErs2MYhRBGtMtAsS1oabfnN
	TL8LmwXknl2m/Ofu8q88=
X-Received: by 2002:a05:6000:2381:b0:3f8:e016:41c0 with SMTP id ffacd0b85a97d-425577ee9a5mr1625963f8f.10.1759299373643;
        Tue, 30 Sep 2025 23:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqt0cbQ3yhlC9NUmKLr9TrwlDXftJyJ8jaxrushSt7Z7NutbNA/tFFVZiy52RJ3xcD/4g9ZA==
X-Received: by 2002:a05:6000:2381:b0:3f8:e016:41c0 with SMTP id ffacd0b85a97d-425577ee9a5mr1625948f8f.10.1759299373270;
        Tue, 30 Sep 2025 23:16:13 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-41f0c467ecasm12794524f8f.38.2025.09.30.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:16:12 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Cc: Peter Senna Tschudin <peter.senna@gmail.com>,
	Ian Ray <ian.ray@ge.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in MEGACHIPS BRIDGES
Date: Wed,  1 Oct 2025 08:16:09 +0200
Message-ID: <20251001061609.513432-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 74459b0dacce ("dt-bindings: display: bridge: convert
megachips-stdpxxxx-ge-b850v3-fw.txt to yaml") renames
megachips-stdpxxxx-ge-b850v3-fw.txt to megachips,stdp2690-ge-b850v3-fw.yaml
as part of this dt-binding conversion, but misses to adjust the file entry
in MEGACHIPS STDPXXXX-GE-B850V3-FW LVDS/DP++ BRIDGES.

Adjust the file entry after the conversion.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 343948543711..250e90f6f0ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15957,7 +15957,7 @@ M:	Peter Senna Tschudin <peter.senna@gmail.com>
 M:	Ian Ray <ian.ray@ge.com>
 M:	Martyn Welch <martyn.welch@collabora.co.uk>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
+F:	Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
 F:	drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
 
 MEGARAID SCSI/SAS DRIVERS
-- 
2.51.0


