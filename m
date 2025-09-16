Return-Path: <linux-kernel+bounces-818513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E2B592BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C6152317F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECB2BE7B1;
	Tue, 16 Sep 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8b7oQg+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B629E109
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016358; cv=none; b=FHVQ36I4KasbdzW5WNtIcXD9TunPrH3JFmUP4YfQaKtIi+k4VgUNq7jaCo6/uRwAleCFeYFE3S0tRnmLRf+a5Iy9yD1JpnvHSV0NwG836UCqQQPm09+6U1zJfamco1dsaz/rN5hQGgfsjZDM3/GRWctIGww8r24VoQgyhl2IfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016358; c=relaxed/simple;
	bh=M9V51AxzPBO5PwhtBLVHE9xHOolKyukF4W20dH50Hk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhYAx2Ss6dvMuZrZedsZsxCtpBWVuOvZO7pNQS+KiAZXw6bz0e7cRQ8bMytMyU52TJKAq54xGSBWeI8mbwgyvZk/auclF4Qed6U1L8+jKmAfMKkr20JN8GKdcq7Bvie/PxaXBovO3eCnVbPBh41h39bQQLM58lz9wzcbKvK7jLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8b7oQg+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54c707374fso1519014a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758016355; x=1758621155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6V/2JKFCs/FeFWLTSODQDr7ffITBUaTSIVuTLike6oc=;
        b=H8b7oQg+0i+beSJ9kOLlOa+OQQES1ULqg896ntTDjZYEIbCJ2VqItDnVuErZr2pEsz
         xmPHVK3pc5CZuEURXZcxGLM2sZN0GdLsz+TvpK0YQdcrUKNLSSf793w8qbsA+/WJBqmf
         L782SVhe9emv8DZENORzOUsyqewCtWb4UHfysgUqEfloC14KHAKx+XTezwqoIrjnpOR7
         +H3zX8f8OPbpM9dO9wun0L3SQpOSgCI6Lw+WwdP3JQtTqioQKpGxCigq+Q8rs/bEYP0V
         gsV7IbZBQhJBVQX3cLsRGd6BuewJp/Tz2/TZKeDFa18nvy0BnC8hH0aPWoRCh0WofJL5
         QBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016355; x=1758621155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6V/2JKFCs/FeFWLTSODQDr7ffITBUaTSIVuTLike6oc=;
        b=A/n1VFk/HfNGdD1y04rKIxlqiPck36RVnYi2d4V5CrQdK5VqUmOYzuyg2XtVDI1xGA
         hCrMUdmLl7C5szlLzzA0u8aourR5+VrAPCUXbzpVaji/oq1vwyV4F+QOQOTecunabZJY
         qW90pAUjRneJQukV+ZWSkR/nRYcCqWFKlRyUeNh1j+ZP2ql4Ba0fg/MKAYH7rjenHVG6
         dih/rQ1JEx3+Nb8A/G866m1REZnHTMCzgGd2CI8CiPUrk01s46JbfJ7I+4kD3EMUAqNT
         GUeqxjgZ26zE7SzQnvIf8a+8Za8d/I7kxqT4M70sKqMr4Wj7fexScMyMEq1Ke9UZbuSi
         Vdxg==
X-Forwarded-Encrypted: i=1; AJvYcCWwRlISL2vRQpuWR9r3tx45Ns6kzwyPusxkJW0UBb/3er/59WQkhcxbQev3eM0kFYGT8jQbQ9p8UAiTKlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOiQcufoMkO70wdAb1z3Ym7/fdvEREDoTkrpm0a2nE/So+cNB
	kPf/oUJWZZZGplRu3zor9bV99FzXy0E6tZYUAA/tgMToh9JL2Od5AMdO
X-Gm-Gg: ASbGncusYaTjzwu7k0qyBc2VGEE5lcyFee8vWiValUtZgNJ86TME7VGNqhZTOrdfVkN
	YQCCcYj1h/N1lVRfkNgUN6/TMEXjjuee544NTQPp+o5psYNqmc1KVfn7gckK+LsVtqg46eeSczO
	YldrJYthW7KDyQ1hEp4y/TB5p5Mp0LI6E0dTPeJzxoXEVv02y2jqSqj5rqloq3yATIFE4++ttOS
	gJgTn60wf+8UjPKnvYXti1Si0K3Uj9XgOPj3bL3vmgsfYoH0Y29miHd0lo1vyLhDeTO96Y0fUyp
	h0wMGCIrDsWNrs6O0mvzcTab+PPO7IzeVA352NX+NzVlRbSUsOONXMQyZIydp6eJCKtwfK+ecl/
	z6udn1y4v3kbY7DzfA4B83f1vX35yC4F0nJKlsmC9oxMi3IazdyAfw3To2DgSlraRyPIMsZlixu
	5qBotLY1uX+I9rI63qaKlJXaM=
X-Google-Smtp-Source: AGHT+IGzMLRxu46ZOAx5UTCfKaKDFqV7qJKe5pWFw2whXOGJeDPlIq5qn0wXezBFeDOYYir7k6rHew==
X-Received: by 2002:a17:902:d504:b0:267:c8d3:21ca with SMTP id d9443c01a7336-267c8d324eamr34843155ad.44.1758016355232;
        Tue, 16 Sep 2025 02:52:35 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2667b4d380csm53935775ad.71.2025.09.16.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:52:34 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH 1/2] dt-bindings: trivial-devices: add mps,mp5998
Date: Tue, 16 Sep 2025 17:50:25 +0800
Message-ID: <20250916095026.800164-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for MPS mp5998 hot-swap controller.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..d86b2b72d1af 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -305,6 +305,8 @@ properties:
           - mps,mp5920
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
           - mps,mp5990
+            # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5998
+          - mps,mp5998
             # Monolithic Power Systems Inc. digital step-down converter mp9941
           - mps,mp9941
             # Temperature sensor with integrated fan control
-- 
2.43.0


