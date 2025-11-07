Return-Path: <linux-kernel+bounces-890247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9670C3F9A1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB24EC8BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3531B82E;
	Fri,  7 Nov 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtYwOPwg"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839931BC84
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513068; cv=none; b=eEcI+Af7GKGdKLx2HpughZ5o1dP5RMW3GKAvAYSCgGvpAsonH6sHhp1HTN6qbmSO8B+gdSXwTdLrzfkTxRo4vNcfj/iS3P0ostnkDYD60nniS+9PFz/P1KNz5mVc89dB6YoUmQWKoFaB2JMcEMw8CnRn4tumFK4+dKKvtSZzEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513068; c=relaxed/simple;
	bh=zfksRdzqKJhRlSNkDPTjQcTPNmX+bLOPlYzuDXVDI+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1V71MdcfXMZe1EbQ/CKkibe/+IvkCcOsOEOuGC2oGGL2agA8ivLdXbcWuu+uoVV0nZjvWzFtErsxapwA2B/eizb1OqJmCH57sVOvU4cR1frkM9wKH5Ek9XoiigTQK0gfQYeyKlPnjk65OEVqYZIiskysKl+o1Z5eNJRPSsjHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtYwOPwg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340e525487eso437199a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762513066; x=1763117866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKekkA7djcC5xOnYLDnvST4x7vzTTfMx0HGr2gLWVgw=;
        b=gtYwOPwgpcTJpXmlwgZvT59+fWqIUcGGSvCcW6p6j/QYgqeV0gzNv4JHnxmm7/qitq
         EpHd0GyC0dF+K9v+w0gqIzjAbeLN5j/kKBnWTb/F6NkVUYqvfewbG5DdefjoJtoHYg7u
         /Y4uxcJMkjsE9wXw8vdFgaFRAxehS+egjipcNExUCf0eJm9QD38bopyfNjvQ/Pl9+wpV
         fdUZdwQxmH2q8SP5aUGb2VWZcIK8x9nummbWkjfMo/6YEaAPnUNNp35d30bzOSZQgbmr
         dVdQ2rNUQ4+mI3947GyOvZ+DEfcTPfBz9tFRmn7eB2RUk9/ebtZ+my4P78Ga4ba9bt+u
         v5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762513066; x=1763117866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKekkA7djcC5xOnYLDnvST4x7vzTTfMx0HGr2gLWVgw=;
        b=eHZO6gzCxjfGYhRuyVcpdEjmn6yiDdN4vvgzNzEjmM7LJ19y1kQJ+iq5i7iwGKkJBL
         IgC8/W6JejZXqbMZxUXYezLtBNRmknSakyUpppuH3PcSLL2y3HNEyT67w8Cq/Pe9gYlX
         Z5xuJdVKH++CXjwtPR/R1qcNIbxGKRnv0zaLH16a95ZxvNZXEshOv25S9HGZ3SzRqeNC
         rxjJ1DcT96EU3daGeK2L7D8hYlvqOWJAmoNYJuH4pZsC21ISpEM4eC8zaLoARqiNLmFC
         llKCfPtcfiCOuQjYx58tJlYuDd8I1WOaloibaXlIZoWu9s7z9RAOMRG4RTnsPszWS72i
         IUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXRYrWbWr72Xy9c1UDumK3dk5/AJvDSSJGuSmLpm922Q2HBtX74Bpvv4tA0CsP0Ng9jBqmr0hQLSmO3r2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48RLh34m0Hq++RTTNxbuGQyMJHHVmUS9MJV9dLxyW8AoBsJr9
	5HzJu9NBQKjeJ1mHDKnOdpN7DFsWZL/JN9N7ihi7geLMKMtSw0U5wzpG
X-Gm-Gg: ASbGnctW+h+6FY6zR2BSwvGm1LOJsrxm+svF8HgZufZPxZgBGD5gUe7fxO0FTZ/jwq+
	UOSn7qi3Zl1AwK/gG/J4Y+qSdTbGQqwK+O5hEVrSDPw7v+5wa8edy86db7nOWx//ydJuUOLJtbL
	AGaQV+kPCGI0IZTn4ezioy9g+f48rnIy8qcCzvWi6DjavdCdmSzNgNaqgLLEg9WcuKE7rHKCgwu
	oFtti50Uonrio1SSmt3HcnRyNajpPkWIAGckgF9RgY3CALyHCwGm6Mw8PsUziCmvL7LiAaCEPPG
	EHkvihHCaWVzOXxnxH7wjHwLK8KhC9tcaLjoXbmEhg8TFO4vGBG/Zu3U1WeeGlGqHeb5ZqrIo92
	VOsXMRtrfetseX7zCPcA/ol6yl8HXWNB9m0/AL19DrqdJNVIuP0Gwu33v1kVnRayF1ZDK+3Ao4f
	x+HVB8Ct/DayWMQ9ZLa7UnyXnumCnwWq3FKDa7
X-Google-Smtp-Source: AGHT+IHOk78PY2GqDtWJJ84cSkZC37nrcnYrnsWzuRanAE5JOwBSLoL0Qc/AvnORMx4bE6VO7s7UlA==
X-Received: by 2002:a17:90b:3d91:b0:341:88ba:bdda with SMTP id 98e67ed59e1d1-3434c58521amr3275232a91.31.1762513066448;
        Fri, 07 Nov 2025 02:57:46 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm2276332a91.5.2025.11.07.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:57:46 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
Date: Fri,  7 Nov 2025 16:27:34 +0530
Message-Id: <20251107105735.1491273-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107105735.1491273-1-tessolveupstream@gmail.com>
References: <20251107105735.1491273-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the Qualcomm Technologies, Inc. Talos EVK
SMARC platform based on the QCS615 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f368..a323be3d2ba2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -862,6 +862,7 @@ properties:
       - items:
           - enum:
               - qcom,qcs615-ride
+              - qcom,talos-evk
           - const: qcom,qcs615
           - const: qcom,sm6150
 
-- 
2.34.1


