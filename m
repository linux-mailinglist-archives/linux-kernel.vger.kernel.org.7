Return-Path: <linux-kernel+bounces-780257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD50B2FF93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE2B1BA187E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5022E1F1B;
	Thu, 21 Aug 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmjJNJmv"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592A9275B0D;
	Thu, 21 Aug 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791844; cv=none; b=YItlyHo9orhIVLr26W93cAbshuDmQX5hUjx0YS6afl+OasAzK6Fk69cCWg+B1zXchDW8Y8H3pLAQ2mLk9FyI6QQ1bD/7Fav9DjgPvhDfBEHXrepfvxA48i30tvVSnvB/D/HtAB3DG/xAyYMhd687JU9TISiHu3O58j/U6fnvK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791844; c=relaxed/simple;
	bh=aT4t5F2y67HWgbmENf4vzAFYl2ef4GaofSdzJe/3ZlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGY8J4mzlgcw+6N51SMVMLF14+lS83463zSrgfakSeRK4UUxjyCoBZXazSp4iJ7Isps5uhR/MUC3LVB41kt0YoEY/j+xlfIHnZjxUNAuS61N0awaGi9whvEAnN5YTKJCe54FNvWhCo3U+VoIrzB6I8aKF1ZvfBsGLrZlC3A2Ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmjJNJmv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so1747731a91.1;
        Thu, 21 Aug 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791843; x=1756396643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=hmjJNJmvaY3f3f00j/nlRicgkt+bk1+yqT92l3rxFC2ZV2rPoL6P9QplKW+cBE5XXd
         BgYXoX025gZE0FUGv82LIV7XrMBwqGN3JswrOcK5xMGhSAwpKeRsp9QTwQsxHQsnmAQ6
         iWaZGw2ib/q2geqehjMmH706wvSABJxqTgee30PTn/ETb16LJNx/nh+6svZRz9iq5mg+
         EnEQP5bC5NdjDlmSt16kRqZQ9El4fqr3RLYvPA4T7b1ofcALQ5VsIH3N/glfZAmwShQU
         P7Gsio1O7EG8P5lJK4acWvR5XwuAHm+2M0NEpmsw//Lo7MsOlLMHwUfC3LVV07mfik8v
         nPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791843; x=1756396643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=dgtAoS04YGKKDV9caC3478P9zAEf8EGVyGusluLysUHUrnFDSD2liPOB/MwIl7ZBZl
         7rULrz2oCh13KKs/vGhb6ubzjEH8I2uuJqeWgQFT63DWucX3I5e1kHR7wHLTMeNGWZAN
         JIq0YUgbdO6IxcGCqh0INE2Zr55B0VVoirevqeHFVmHFD9ymjteqLkOdpqIrXZa5epCx
         VFJvfM6hckBtPRMYerK+m8ggF4hVbge13jeKQugSHxQOx8UIugR3QILXS111wll6+wo9
         vJo01yBovPJ1Cnu9L5Ystz+e/wsoL8lXaUNkXs4sYnKut30jnVRVNd1J5A/p4ChEQmSn
         HPDg==
X-Forwarded-Encrypted: i=1; AJvYcCWu6F+LCZkRrCEJUnlx6HmMNKPcSDLpj13PGKSLj03IFCTXpxDMvyZFq/uQ8ljtzTpsdJSmF/PMXu2wlqBD@vger.kernel.org, AJvYcCX3SuCVKHmzzPWA7YOxykSuE4a4+5kmOsHAFgo/NZqVcvlTgwbqMWj702fVomTvK9QkbGfSRdv1XElz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2OUmAR0pW5ByzmpZVG5IqkSUokLw3L2dv6lAJIQfKTvEq7qk
	hBgGO0zAVGwGFOarfJeAAwMi4MePPM4qULlekOtMER9K+XljQmafpRCa
X-Gm-Gg: ASbGncv8JVqYRT0QJeFwf6eFG4fgSlMvUaQ6xT47o0V3R/KQhjZSkwuq/hvAufxajMo
	KnXjnrm9VSRifWjON/xTHgRDIxrNGOBTDXYjLAe6lfcTjz2gEas66rp8Dt5LUDCRPnnjd6YofPY
	RsrNw//4h0upo41TwBOCjxbcGfBWfRCdFXwC/0ndX9W3t+UzsnFjWauvjoRhocy+PdtZ7cEFrm0
	xiyUBWP7fyW3yRIHwGRJqywwTULlW3gzyJ5fh6SRGtQOFffe2PTlt13ptP+6dYphgR0zypZTDwp
	pLe/AFXrAXwS52YCMcTPrTTjazbTToQKbj1XqfZ3ZiZAKn7kS7KPsWs9yzpnRLgPST2F2ieE31q
	8GqOTjasB3/WqFl+lOy1UoFocM4GBasXYbJ6sXUcKhvlMpeQ=
X-Google-Smtp-Source: AGHT+IF9e73V5L0GJ4m8c/wyYuFTuRvWMYZBEUvb8sVuZ4sk4ob+Qxwo84ji2NVWtD5/HFf92Hoh8Q==
X-Received: by 2002:a17:90b:3d09:b0:31e:f30f:6d3b with SMTP id 98e67ed59e1d1-324eecf9b08mr3700392a91.2.1755791842544;
        Thu, 21 Aug 2025 08:57:22 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:21 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:38 +0800
Subject: [PATCH v3 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-1-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=aT4t5F2y67HWgbmENf4vzAFYl2ef4GaofSdzJe/3ZlA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUUPbE15NZosT3IEFTJW+24ZWMhyU+JoV2Q
 WVUeBbwX+iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JGkXD/94d1kksoerwXSsMGQTysYOmWY5f/NO8PwqSESSbEBiHoUzVpro88j7yHlZRZPsLcHVgEJ
 fV3x+1Cx+oG8xSCvCMNjXkAog2MeESRudOKu1Ci2lJTAPOpqqDqwwXisGo4z8cyYqUcnrwBEItc
 UBgM+DbloO6ILChq0OLXgqRdrPKNBe79MljNt7/lDE5jOaNAv6O6gXwpisv2Hv1CrosG4DnzqdM
 ojiv21uaEkKAATAOBonffdQ8hCdiAUBNSOZ94s4vq0sewDAYLsNTJKbGvTerIXlZWHXv8wSP98o
 qXoCBS2HVRiUG3K0/oSJSTwGyCZKvQcAgDrmgVi+v6oUuX+7zmzU7CZziPDn6b54EQAR9SlDaCQ
 oZ9U8vQxAFyY6SH1j6siKQlLpONcSCCrwtaDZIS/KGGa1iWforS7wdL8SKUchqx0rN8fhI6xkFS
 2Ja6Z+0X/kwzFk1/1cUHj6hzczTN++6Bj03CUax0Zdu045eHn0o9F+ibkL2zVctLyUyqGYBuse4
 nRizdxC2T4CzG5yi7Pkix+hlXQaJF8qH8E8xcL5r1MLXI7IH0HYaCwrmOaRDmENWk3jNzZ1votX
 gJQT0L8qelm1fG43gboJ6BTIIW+wO0lpILMEWoshhZoeH8VCty0DQ5SJRKDaKUnVCJBZ5+s9E5L
 Twjq02ZQc7UuNog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
mailboxes are used for coprocessors including Secure Enclave Processor
(SEP), the NVMe coprocessor and the system management controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..bdf58f03b84833ecd93a34b91f6262d1706a002d 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,13 @@ properties:
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
+      - description:
+          An older ASC mailbox interface found on T2 and A11 that is also
+          used for the NVMe coprocessor and the system management
+          controller.
+        items:
+          - const: apple,t8015-asc-mailbox
+
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt

-- 
2.50.1


