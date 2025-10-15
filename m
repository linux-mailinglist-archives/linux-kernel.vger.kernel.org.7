Return-Path: <linux-kernel+bounces-854672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 379EDBDF0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7644FD41D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA023B611;
	Wed, 15 Oct 2025 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAcJdVMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0B29A33E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538684; cv=none; b=LsrMEjeLomRKJN1oTj99QV78SetvI9LXD37tx+kFLLlvC/PUDyu825ZntVZwYRNIyGCDF6kVkXq3FZKCVib42+aChC5cwql1L1FWkNOEL4cgm5cBPFGMX0MaI9QKLOdX25mABo4cg8BbQeEcHhVlLAOfzr9O5PGBUOzWWypkxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538684; c=relaxed/simple;
	bh=7nF+zX1/zT0vgaP6R4vsmssJvlMwk6TNzjt/SjKQqOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bz856s9G/I4Vkl9GYw3Ks0/UgnAvvoZqmVr9SQspGkXcjwjw5zWMtZpT+Gj0gRBDu7rXyRj2xsTnLH5WNNqltm2CKMKXvZmGq8ZnmMv7/aCexNCE101E7gWd95uZJSiTfm5vudAPKesudCFKI4cEqZ3oKSrkqAiyOwUoxFqEBIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAcJdVMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
	b=eAcJdVMeZMy97AT+pFHJvpB90sWntuneftkxM52U9C/rnXzNsLtAS1kr9zJLWgqZNEB++u
	wUTivSrzjKodv8ZkfaiQnDJfXwluBN1jUEYe4Bt144iNJmgFVE9eksxeNO7Hgrz85bT3l6
	QabAOghEJ+Xag/eBj24WM/71cgFaU6M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-6ytFQPUhNz6A6fqiPjjTow-1; Wed, 15 Oct 2025 10:31:20 -0400
X-MC-Unique: 6ytFQPUhNz6A6fqiPjjTow-1
X-Mimecast-MFC-AGG-ID: 6ytFQPUhNz6A6fqiPjjTow_1760538678
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso17988035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538678; x=1761143478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSXzVZNzjEJV0QCm7fFsQIpGaaXg5MfSXavQS0cQlLY=;
        b=KezziawIwway9okpGtidCzkBXt0WqwXYfA3oA3B8bbF2xXH3FE7ega+H/3sHA+7reF
         d2oOWMTHnYN5JzthOW6QiOkivXBjg8tWduEAtpgcfcbCh79ECfLhIKiQ9c2dWTXVaVbN
         TQdlb20ccp31zixzZ8zwbiKwpoyfoO/6MeKWlA2XQ5Q0cAG5I0TBzilmHXZDzIimoP01
         kHy6n9WyOKEmhdEakfMEybJkAbHstcak4Okn+DYBeD4+qpn8WYHlBW4NuDEuLYTjwlUE
         8ND3HwFvHT297wTGVl2NHGgRI8f3STDt1WikMzREHJMZjNhNBYQnzrbZlV8RmTxd1N+L
         J3Mg==
X-Gm-Message-State: AOJu0Yx6/de+WJu0VHddsCTnRwg3/koMGl25wHajdvVeuvoLXBHzd9Vj
	v9tc7yy3kOqiASTRFoOSwtgPzaaMNoKb8+6YJQKuYQ8V6nOA0uYhPI2fAtzEbY5An6rEnTNzQPh
	IIz2akGi7NTEXY6mc9Y6gdbzrgOy2dBOaP58ROcrlwoAEq7F6uU6LYyS/hf3uHM/aPUAABW8FpU
	+7mR/Ac/8pwydsOVddH3IhWXq2xLSaTtGKcPhe/B4Wi9/aJFYLEF3F
X-Gm-Gg: ASbGncsE3aQZpI/pz2FeUXE1RUN2i9ZW+AnGP3X73OUDVkhRjdIfxA5HG2bWA7OK+mj
	Z+CeBoosDEAoYOkpbyA4Z17C/gTAqRjAqvCUBCZdlWynZWlXu2ZLovaomrhIwrWRm9yyZaUs6Y2
	tXcQ+LoUCOb5kBMkfc5JbvuGt2XutEjkMjapLYe2y2MAGzaefzwyUsF3LvsghVhzvrPDgYMm9Tq
	H9AdkyqYsbFUN4gM96KpUEccUE0i/XccGk486p4dTFCRo9qECdDcJRZcvnvzsusKlWmH1OZewQq
	hfv0GU90LlAnk4Ocg7UgYq6LYCbk4JpTn4RyckOjydoV8DNqfc+ZrBQ=
X-Received: by 2002:a05:600d:11:b0:46f:b43a:aedf with SMTP id 5b1f17b1804b1-46fb43aaf25mr108180925e9.38.1760538678080;
        Wed, 15 Oct 2025 07:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG683Uu0GDZc9bo630j+NWQaTw6T0Q6n9Za7jgl4kwN5Wnz8kfYe9OZzC9Ddj1aZld04KGuRA==
X-Received: by 2002:a05:600d:11:b0:46f:b43a:aedf with SMTP id 5b1f17b1804b1-46fb43aaf25mr108180605e9.38.1760538677489;
        Wed, 15 Oct 2025 07:31:17 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c02377sm32617005e9.6.2025.10.15.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:31:17 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v4 2/3] dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
Date: Wed, 15 Oct 2025 15:31:06 +0100
Message-ID: <20251015143108.441291-3-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015143108.441291-1-lzampier@redhat.com>
References: <20251015143108.441291-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add compatible strings for the PLIC found in UltraRISC DP1000 SoC.

The PLIC is part of the UR-CP100 core and has a hardware bug requiring
a workaround.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc24301..34591d64cca3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -74,6 +74,9 @@ properties:
               - sophgo,sg2044-plic
               - thead,th1520-plic
           - const: thead,c900-plic
+      - items:
+          - const: ultrarisc,dp1000-plic
+          - const: ultrarisc,cp100-plic
       - items:
           - const: sifive,plic-1.0.0
           - const: riscv,plic0
-- 
2.51.0


