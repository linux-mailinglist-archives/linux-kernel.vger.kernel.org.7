Return-Path: <linux-kernel+bounces-803629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A463B4632A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41D11C24B52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35362773DD;
	Fri,  5 Sep 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VtF8SfpM"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD32315D54
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099203; cv=none; b=WivPUcLSMdACWTwg1jPoDHMOtuQNK/iKtdwVzwgt/Zexw80sfyoMGsEOnwT6NX6winFksspuXt9ntBwQ4sm1P0v9HYV1fhXbFh/ziIYhbJe/JuI/m2e32H4PBNh81QAL6VAfVl5aZswUYAxhUxrvim1TAt6oDPuEDamao/vcNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099203; c=relaxed/simple;
	bh=YkFDAa1kiBe9S2yKXCo0voxJkQpMcscBEwWTxdQxd/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZHcEEwZAB6Ldbl9W8YVtN+2ASb90h57EweHnV0U0yD1z4X5q8c1aQ0AcTFg9rXAnapZbB4Y7l3OUP1LxQHsb7OeyOoRte50X43+FI8QDWlVSxzvcfgbbPo9S1Bua3wgzAgeHRB/UCC7sDjwhmOHVeHwLd83s/s/b1tZdz56n8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VtF8SfpM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381df387fso1067084a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099201; x=1757704001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVMIiLNJ5vtp6HeM6PFEATb9XnfRGTl6cTB2C98rxTI=;
        b=VtF8SfpMHGnQhUeDNwaNWrlAkG9v0hjRoJgUGYheC8Tbi4LKdT/ZDddG2r5OEDnqMA
         Ygk5fr7kgik9z23efVahT3XYUnWXItSgdCib/1SfB0gePjqZj4mMb8rZ/QIIofw7k1j/
         DrXnezD5UKxc+KgeDe8HuMKITqq0WJx0AErS/7h7IHGIuFqEDGqjBCAGFpdSwWUGG4Q/
         CusBRi9QRyWMMQd35ntkWCOqFi/J7zP1vog9BE+1lJKI4Wtl2pdjICGOBQAFmUyhxlNk
         tP1ZDXv9obsf3adK8VWJuPgBJhzf5mzYXYWK2G4k0J2TtV6B2OnK2oD0JxSRdl264s56
         0PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099201; x=1757704001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVMIiLNJ5vtp6HeM6PFEATb9XnfRGTl6cTB2C98rxTI=;
        b=GCd9OIcZBf16bOGCH5jdaas3NapUJt8yCHhjDjoTKgMu92Q6t36S1BHWm/w6vZO+cD
         phTyobImg30TmN2XvfIns+RQCkr1EALQhYSLvg0K5NUImDrfXFW0JubW0fNq2ohnCSRh
         YukTu0Le7klTClRtzDEm1ugyDzEiYMJgMTR2nKHJriXshgjjUl2ptxUNE9iAa3Ao4TXe
         tAIYwPvNq8fduO7ZBNsU1lo7lV34NEiavZCjpFRm8dv1+4KbKETEuSGQ3OJAS3QX2Vkr
         M9ZWUGJZE/M2s3tVjXIjDTSxxwI7ZW1Z7lcqnuLyfNsGTLImZFaN21bm/RnHtXl/Exe0
         gchQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiqiFvdfoFKWTacKQgmCbHakJyi8uPU+poMybsQ/e3NIK6ZD82LK9XgXPh0VVHFYUiyJulz8APGYngfL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjfaTsqgxfPf13eIc/sC7NRWdaQE6qy1iHud1IC6zGItThY55F
	Al5CTAb7yAR1DRHf7ivG/TCXxjawqwzsuzReOYxG8GSYBAg3y2RjTo9cEwGfI8Ky7vE=
X-Gm-Gg: ASbGncufkMaM8RVdI9tS7A6TeiYPCtPPP9f71j4JqMXY64BJ++mrAoS70WMBTMl/cIU
	mTKZacoUXF3C3f03w16i/U+xFigPI26HEWgLZzbocw7lrP0YEQ1IexCN+j4E7jxuyRmHmZtR4Xu
	qK2kY+rh2ySn/HhLVjtDxdSwiKGdFng9ZFGnTKpP4NE1t/stCBLJ8EVbzZIG8q1x2fPMJG3Su6L
	n2tiTuwGEWBohzMQ1UM6F3r70EcSpoMAch+OQR7tciA4heb0TY+9zkJmU/4UdVyR/O71Fa521uX
	RAnETLHv40qcgUWw5hwhptWnkDzYTGym8h0W2kgoRmuhBLfZpUP9eQIdY8bgdaP4PfkyrKPbAZW
	SxZJzSaBbLo5NysGItKLr6j9FIXBcZwDxykcYmQ==
X-Google-Smtp-Source: AGHT+IF1WP6aoV8esdwbNLTM2czjaaGddNLYmj4pnX6CXJVv6PYpp0AHqrdDwL58bRybS0eHaazyTw==
X-Received: by 2002:a05:6830:67da:b0:741:aa58:d500 with SMTP id 46e09a7af769-74569d796ccmr14482572a34.3.1757099201093;
        Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4474018a34.39.2025.09.05.12.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:06:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 14:06:19 -0500
Subject: [PATCH 1/2] media: pci: mg4b: use aligned_s64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-1-55996f077a02@baylibre.com>
References: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
In-Reply-To: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=YkFDAa1kiBe9S2yKXCo0voxJkQpMcscBEwWTxdQxd/s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouzSzZDLRcMMLn0uSCyH1phOl29gO+fLwCKUOF
 vySaiUuMMGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLs0swAKCRDCzCAB/wGP
 wGy3B/97KeWiEl61Dj8yEVWkQat1W0IGWYLqSBrxxU2FCPmG/jmRf4vaLyf8ixBOWrghYlSRrRh
 Bwkk/lGUxQZxTXnmweS/JJtDf3++JmqaQcTfsxxENxlZk/DqxlTFm0HkPAe6vM2bPWLFJdTmBy6
 qaMqZc55pop2L0tWPJ+fZGEwGQeFdtmbq+RrdFz/NYQWoOz/+bL6KZX2mvi7lh4quBkXMrDpnzv
 QHYbeIavtm4z9a4fse16EpdcseR8gmsWhN0Kocup8rR4WesJWFrD2n0GnBMDjWitWf1Nkqu3g4S
 CERtFidnY0Op1FgfkuvyiE5/KCbujn10msTQCeGkY/2huW9s
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use aligned_s64 for IIO timestamp field instead of explicit __align().
This is the convention used throughout the IIO subsystem. No functional
change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index d7dddc5c8728e81c6249b03a4cbf692da15a4ced..bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -17,6 +17,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/pci.h>
 #include <linux/dma/amd_xdma.h>
+#include <linux/types.h>
 #include "mgb4_core.h"
 #include "mgb4_trigger.h"
 
@@ -90,7 +91,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
 	struct trigger_data *st = iio_priv(indio_dev);
 	struct {
 		u32 data;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan = { };
 
 	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);

-- 
2.43.0


