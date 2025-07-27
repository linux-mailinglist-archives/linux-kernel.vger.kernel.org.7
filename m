Return-Path: <linux-kernel+bounces-747066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D69B12F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9E13AFA75
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90320B803;
	Sun, 27 Jul 2025 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCyVfwMD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7986329;
	Sun, 27 Jul 2025 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753614118; cv=none; b=hgtra5HwQHpHVwBwocTqbh4WmmvYW6IL2X5qtNoL8UbIgAuhXIycUtGoxoO90jDtZ7valGKJ3dxgCYvaLprRBSc+HHlZ1mmRO87fvV8bJHwL5R2xPMFqlNYT72migsBCF961cDnkUipLgrrV4VeVokJLgg6WCjVsBaqoHNSYuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753614118; c=relaxed/simple;
	bh=RJW/RMtbYUl9AS02zh6tamJDq2VgGTm+F+qOAYR3U3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mr1K7NlDHDesyEzfN9etvvDBKbYzyzkAz6hBwptdSwjbG1BlokCCptdbcAxEKhQai9DRFB06RtN8nZLsJJ0gZk2T/Rl63DJx1AQh5+aTa2qkKZJjDLZNx54uhy7akSZo5AA3VqU3GGIRHnrIJl/CEpUPEYh0BAEGdjmiXeSP9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCyVfwMD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75b5be236deso2874792b3a.0;
        Sun, 27 Jul 2025 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753614116; x=1754218916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btSB13u4wPFzn9262B7O9imh/oQKy98Sasbk1uFPExU=;
        b=NCyVfwMD+6aToZuVFAxWvteR0gD8orOGykn3eqgWh2ef5TXzBebJl4qfzuI09jESv/
         4qFkysxdy39KZ2Ly+UlkWbX27gKFVLIoL6PoxGEVPvvfBFWAd4oMVNUkHEJxtj3s3wdK
         ouv07gcljRH31PZFXlxa3IPS2sS6KHaPBHwuQgwM9mta89AUIRn+amXm+WV3Iz9KYpGF
         SCDlbt0z8SPU7kTdh7USDQ6HvZCxtGRSVYVINLGQdAoZ+BSIIE0yR0KjO1jJC2oiorNf
         L2/FNW0XvMNQtPuJiAWpp4JojNLj5+qQFhrhdroz7qNzKnCU4wLALHUJuGiBIWDFBNBo
         0Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753614116; x=1754218916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btSB13u4wPFzn9262B7O9imh/oQKy98Sasbk1uFPExU=;
        b=fI7vwHwUPkMpbYjwqyR0PGUglYL2ZBq9Sc5944Z+IycZsJbEyjC6zCT6kzPknvNlMn
         y+UFdwy1Uh6IQLS/qkO4gcWbjf1aAbBKTM3+5qb6oJhy+pTKgnKlBOnrw/QCrN+A5rx1
         ikg+eIbVU/j6yQgrLrk8PdnrWB9O61PFagEJ3MET6BjWmq4p4mZcfrriXRqQcswu4MvD
         TObeSklst1o7/c34qs4vTsklqEcPGTpuG8Jiu5vCEcONQsSSJcqb3QqDiJiWdxQDo2ah
         sn44vIiLDMTD7+ZtHb7e6E8iRZYLnUPcEWSbyupMPl66QQ7cesgz6khHQ/CGLGBmoT56
         /92w==
X-Forwarded-Encrypted: i=1; AJvYcCWizE/gqC90h3+B9GkBduMI274Ak3ucsQoEkv+fpgGpICTqSaMZF77AFAFIPwkwuC4Rw+6xtsZEN0RxnlG7@vger.kernel.org, AJvYcCXFU95TWd5jd+LldXkS6TPjwbH8b1nUCothO1peL5UueIAz6UnnwphJbfeGNeeHNEmmoYx/vgEpNm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGF2cUL3i8qVC1osirya/bf0pmBiAa7uDSbZBgSPNwBpA0h6a
	vvbG4CfFzRahyaKaNsKNfBpvLmBRxhUEKxwpqfd80B5EbBFcT8K8RUlD
X-Gm-Gg: ASbGnctTkzGCE/Kh0751+qNcpMnaCbK7sZzR9sajwL7K4j24ODQOaUMzanJNwaLsrtv
	T8bnCrntXHsn19Wjvp8JDtB/k9SapiajAH08br055H63o8AdjXSq0r+YWBK0fZmilqMo8smnBQz
	xXuc6IcY1NYsWg9LYCHQlca3KURcgs7HnoOXA+dDRmPWycK1tzFg4xamDa7165fTCLcsSiQa9Q+
	/L6wCo4ocXGu2Em6KPwdWPIg13BC8/YsxlhRKQRSKfOY+hgRDl2DrFkdqR3E0eH+PYyP2bMHgig
	j9kxQcHrsoRiOp0dQtUBhbtvuYc4Oemks1HSvXam2Clhs7pVodqsokSG1XgRE9aMgLu+f8F1y+B
	l+8hLIVGRPt/YjzoC2MjrrnEanQGd3uEpXRWgmFsAGw==
X-Google-Smtp-Source: AGHT+IFU0mjBLKNkwAd49L2vpVk4hPTFU1XGvLShkT0HMcIwpxIrGr2cxSoSVuh4Q32firy2PXxxtw==
X-Received: by 2002:a05:6a00:896:b0:748:eedb:902a with SMTP id d2e1a72fcca58-763349b7a21mr10855469b3a.17.1753614116305;
        Sun, 27 Jul 2025 04:01:56 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d021:481c:67c7:4b27:6088:74d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640adfe772sm3291944b3a.72.2025.07.27.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 04:01:55 -0700 (PDT)
From: Vishal Parmar <vishistriker@gmail.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	corbet@lwn.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vishal Parmar <vishistriker@gmail.com>
Subject: [PATCH] docs: powerpc: add htm.rst to toctree
Date: Sun, 27 Jul 2025 16:31:45 +0530
Message-Id: <20250727110145.839906-1-vishistriker@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file Documentation/arch/powerpc/htm.rst is not included in the
index.rst toctree. This results in a warning when building the docs:

  WARNING: document isn't included in any toctree: htm.rst

Add it to the index.rst file so that it is properly included in the
PowerPC documentation TOC.

Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
---
 Documentation/arch/powerpc/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 0560cbae5fa1..173a787b6cc3 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -36,6 +36,7 @@ powerpc
     vas-api
     vcpudispatch_stats
     vmemmap_dedup
+    htm
 
     features
 
-- 
2.39.5


