Return-Path: <linux-kernel+bounces-813638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EABB54893
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A9B1700D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23428D8DA;
	Fri, 12 Sep 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/i/tQva"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A72286893
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671229; cv=none; b=Fy2CJ/NO+iNzYsS0K2fD7u2zdKC+A7+JWyPYzuCaOBXQJs1AymdIZqwYo/+KYutNdBmYjdMdkUC5efwfJgRcEdqieLQqrK1Qv8RgjpeQVjF/3ZlxqTNKClBSIrIS/xR05OEPzP0y2kod0uX9iHlfJSvzQ/yjmCsPBh87ImjzJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671229; c=relaxed/simple;
	bh=S/x/ppCYsVKnPqW5lJ3vPbClxwzvq+hWg15z5y1V1lI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G+MW225OG1+g2CF8q+r7URwn2Fd7mkJRnRP4scIDRGJ7uKnpC0uHS2JfbiJxSEOwFME1ssbiBtn8feYsH9COsUUnsxTAH0DGwFPPTJZXdWRa2CZWTxwZWLEpSHsgX54IaLzRjkSpPA6B5mvdyg5YQz008ezcwbo6gRSq1YyOVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/i/tQva; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45cb6d8f42bso19881585e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757671226; x=1758276026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lwTohfVuh5PCFcdhMILG+0i9bjyVI3+AI7hJz72zYt4=;
        b=J/i/tQvamjKLeyiOch0xq77ssiKWCSZaHXE/d/FaghHnry3LQG0zrY/F/HpymfcDzu
         dMowwCPESycQ/9LIYZiWmznAO9Ah5+o0R9MTG3jEH5ck07lXdCRvNA1AAlCYfYVGZi2v
         CJN+VkqJeWHzJysjcs8ckTCHIIxUAZ/0gaAolWYqkiP38Ud0ahpHaPmmmE5avTjBl9Tr
         g+oLFxC2s14XUksw027IVso4spXvu7M1bKeDSiYDElXPBnpd1woD+2FzcQfMuTS8olcH
         pXDNmKHFY6/tyZIYngpYI9nOOGsqRDMJzuy62su5ZL3Cn/pAW+qqSCQ3rXpu8sCV07hl
         E9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671226; x=1758276026;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwTohfVuh5PCFcdhMILG+0i9bjyVI3+AI7hJz72zYt4=;
        b=iYhrKcd/O9trtjJKm02JraFr8M2ENbRo7YV5K6+DaG6I2OM2QI9RGdp29NPsnhIcq5
         7y4CHQVW+N1zdkrJ3DN607RhC61bTe9aV7YGaQRjhv8ahzTdS99J59JtLyBZeieFYvsA
         pWRiVhjXsvCOKNDbb9GZD453trMQibvOSIWRMRCOgz9uRSpaRCnfH5Xlf1aELstZic5K
         tkueuDc2OM+8mAJoBnxcjMJart4+INwXEUl4dTmDrO4jrfAfvvsueIsK6cMl9MJYHehM
         2zD75lRSpNWLVdf5O40mGrTEsD8VaiFUhp4AQ1HsVdTX/ZlqJV1zFrOuWkB/BefRpPje
         YfnA==
X-Forwarded-Encrypted: i=1; AJvYcCWV9pZlaoOttKeDqvNbvPBSmYqfZ3JDpCgfeHfa5btAjiH/eC7+oE+ozcWUgsDhfsEu7u+H6DeNBoZjXnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwphuNYu+x/xiAfzYKnRmBnwp7+HrO8xPYh3a9MBGiT+ADQ48nQ
	q6NlkoAOGsdf8+VxMfNuy8B26okTbF3BZ5TYaFWBl9XcQ9UW25reKYlgVfvMzG4Bs7xl3VvkOa4
	W2vsB8MTazLReXw==
X-Google-Smtp-Source: AGHT+IH1ZphgVBskCHC7cnBOzxeNR0ANeresyUwpGGhDl92WBxqq9bOPNP8hkuW2FGkocQtamiJF3VTVIKItpw==
X-Received: from wmth22.prod.google.com ([2002:a05:600c:8b76:b0:45c:b62f:ca0d])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:c8c3:0:b0:45b:b05a:aeeb with SMTP id 5b1f17b1804b1-45f211ffa3bmr17986815e9.28.1757671226243;
 Fri, 12 Sep 2025 03:00:26 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:00:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912100015.1267643-1-gprocida@google.com>
Subject: [PATCH] system certificates: specify byte alignment
From: Giuliano Procida <gprocida@google.com>
To: dhowells@redhat.com, dwmw2@infradead.org
Cc: gregkh@linuxfoundation.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"

The .align macro is architecture dependent. On arm64 it behaves as
.p2align. The various alignments in this file are all bytes.

So use the .balign macro to avoid unnecessary padding due to
over-alignment.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 certs/system_certificates.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 003e25d4a17e..ea6984b427c9 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -4,7 +4,7 @@
 
 	__INITRODATA
 
-	.align 8
+	.balign 8
 	.globl system_certificate_list
 system_certificate_list:
 __cert_list_start:
@@ -20,14 +20,14 @@ __cert_list_end:
 system_extra_cert:
 	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
 
-	.align 4
+	.balign 4
 	.globl system_extra_cert_used
 system_extra_cert_used:
 	.int 0
 
 #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
 
-	.align 8
+	.balign 8
 	.globl system_certificate_list_size
 system_certificate_list_size:
 #ifdef CONFIG_64BIT
@@ -36,7 +36,7 @@ system_certificate_list_size:
 	.long __cert_list_end - __cert_list_start
 #endif
 
-	.align 8
+	.balign 8
 	.globl module_cert_size
 module_cert_size:
 #ifdef CONFIG_64BIT
-- 
2.51.0.384.g4c02a37b29-goog


