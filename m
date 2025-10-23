Return-Path: <linux-kernel+bounces-866855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B96C00CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0D04357F49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6830E0CE;
	Thu, 23 Oct 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="OW+yz1PE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794330101A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219616; cv=none; b=SF5s078PJMyWz7u/+NnHv1Q9c6eZJJ6f3vynfLwfJIsse8of8Tv6Nmh0ft7fyy9/y9KieEBzNE6V8jbXlzVd16Y/WcfO0LBWcKiybEAl/3eZvtJsWW6Y9utY2NA+z+QCyrZ/wXpAU06EICLO7IWUCo1DQgIe5LTyP8zYkReTXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219616; c=relaxed/simple;
	bh=IT3WjTH4d0Z0+FkVbzYKvEpira6rnSrbJlwlbnTsXWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bwn7+QyCMiUGhbP3gYPcppAg3mc76Xn6qzh1h3E/SqXlZDsAfOP0ttNgy+aiTx0+PtRUO5Bs1qifaSHGvPGXpX+7QcCpm3x6m0Y2enAW5vGuLVm6jDvhJAQErYYdBmOdgrQT3+7Xo7VbgPYxH1kt6CaqAxUB5GrNAfHygmmCnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=OW+yz1PE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4c89df6145so126212266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219611; x=1761824411; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIorowqdv3EZF1HaFOt/PUP64NhVkRO5V6vLFAzu03Q=;
        b=OW+yz1PEas8GRNl7GSRRl0vFdpJDyVabSYOPsruazN7DxMxJ1TIBBoFBN8Djteq+GK
         k+x1HESydeLY+UIU34Az69leYeU6TWB1F7U4T2F94GCmBFuU6TDTrjA3XMuPVlJy6TqV
         G94W9u249zT4H2OEw8qhF103G6wuLOjrFNyVsn0XUzIuqIm94GydsKnpgQEFWm45iYRk
         0YTDCfH7xV8q3cu7LEdXMZsqGauF6wwjSR08z6RZrNkneuNTd4U3Sowv0BaStOIzpfla
         1UxiM1COLlr6JuewhZa1QqKk8/tqv2xuKM42F4Y/gViKatKqE4BeQta7+QvQXfGE7Pmd
         gv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219611; x=1761824411;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIorowqdv3EZF1HaFOt/PUP64NhVkRO5V6vLFAzu03Q=;
        b=iKUJPoADJE/6CuHkIpYcTezsZ5HtoPnv6bYU0m4842549RPMnSZiZkmXtD7Exm0JsK
         HR58U6gz5vrEEDzpaFFNwEU5pd4dIcD3LsmwEKytliNhSxBIIL3r4lcoAUY2E9Z36GLY
         Vczj7aaspCGKWrPz5yEdAU6MJFtCQbJVmA9TC+C8KLSm7Bkakh4S5ZFl3OfD+z0D7w7t
         NXHOXbxT7xkfxJ6lSK6F2hQou+OycwIPLAexn1tpdKGVttcnX7AUqIOawXhJ25pWLHIl
         zq0U93++bDLXxagwwK0b0XyzN/gNbouLgjbLaPpSGSQpkp/ATZQcx1bkmcQPbXnW0oQj
         hQMw==
X-Forwarded-Encrypted: i=1; AJvYcCUH4V4Q5YSJcwD1YtUVAIKNDQEir8S2LPEqLUHwvoHtI+ZfQHjQfE2KSYXufQfZ7o/9cXTmUHdVZHKi8nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEzeIFYi5t1qJKyR4D9VxdmptdJrIbR6VxmnbImfX/M5XnOs6
	KPe6pmbE/5ARj6uoo4en5MSVIRMoZ0tIbL7JEfLgtR2/qmZNx/nwJKK1ShBwW1AfWPg=
X-Gm-Gg: ASbGncuNdGD4SnI481CVQDznpMoKb9KNN1SICe0wdhtWrloyYeDgGsZgLLzNwnURFZT
	n3HdPhPsWdMSedrKtvjwn6yR33IOI4uHNeg3gjg2eeiqYlUzohGo/aZDrPMcreELcFLo55BAG0O
	hPKFWCRzrvk9m6PDCXJDeqKVYOfVtuXfyRZxBb95PuFlgzTqREj/UtmNBzbtTrFmDI4GL7I+vd7
	Aw8xV7O32TZKXt6ZOUFagYbt81OjwK9YhtnEmjHWLS/9ltr/zUX1n/A3UguAmqiTZ/kDZGqYQ5z
	2CxBJzZZ6NzMQxkTf5CKw/M/bDKrBJzT3OPVb9LoQZbXIDfH1XkU/g1AqcQ3w+2C59ULJBv1g4p
	awt5aIiCsdfGk7H545kdx9yg3hq202snoqqrfj2CRGhAM1k3fSb9d94BKb+izsqirqKXdYG7DbO
	qlKX6UpuVUvVhwypP9w4oQ+zNWBPdQIEwPFg4VLyVP8HExyg==
X-Google-Smtp-Source: AGHT+IF9HVQ0oKyBqFvpuJlw2FMI9pRLVIxFWml173tZ1CwIycKjF8srbTzahjeWY+MF7ZZe1M9wig==
X-Received: by 2002:a17:907:d08:b0:b32:2b60:f0e with SMTP id a640c23a62f3a-b6473243c5dmr3059050066b.17.1761219611013;
        Thu, 23 Oct 2025 04:40:11 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144cfbcsm192518066b.56.2025.10.23.04.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:40:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/3] Fixes/improvements for SM6350 UFS
Date: Thu, 23 Oct 2025 13:39:25 +0200
Message-Id: <20251023-sm6350-ufs-things-v3-0-b68b74e29d35@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO0T+mgC/32PzQ7CIBCEX6Xh7Bp+pLWefA/jodJF9lCqQEmN8
 d1FjR6M8Ti7mW9mrixiIIxsU11ZwEyRRl+EWlTMuM4fEagvmkkuNVdiBXGoleYw2QjJkT9G0Mr
 oHluLRiMrvlNAS/OTudsX7SimMVyeEVk8rv9oWQAHVXOuammMlmZrOwonN3pcmnFgD2KWH4rgU
 v2iyEJp2rbXrWjWjVDflNuraMDzVDanV1t26CJC+Q+UNpXHOcE7ozhud3sCMu8tAQAA
X-Change-ID: 20250314-sm6350-ufs-things-53c5de9fec5e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219609; l=1028;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=IT3WjTH4d0Z0+FkVbzYKvEpira6rnSrbJlwlbnTsXWs=;
 b=we1oHYRq3VFpjv7U2VuhgIidnVWT72Wm3H7lgX23Db76yrigFfFD2OzgQ+7lojxUv6aKyllXK
 xodWGevdr4hDnQUMCHGSTH8VyVe7udUcBV7rMJqw2sPMssvVjgRwuXT
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Fix the order of the freq-table-hz property, then convert to OPP tables
and add interconnect support for UFS for the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Actually pick up tags, sorry about that
- Link to v2: https://lore.kernel.org/r/20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com

Changes in v2:
- Resend, pick up tags
- Link to v1: https://lore.kernel.org/r/20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com

---
Luca Weiss (3):
      arm64: dts: qcom: sm6350: Fix wrong order of freq-table-hz for UFS
      arm64: dts: qcom: sm6350: Add OPP table support to UFSHC
      arm64: dts: qcom: sm6350: Add interconnect support to UFS

 arch/arm64/boot/dts/qcom/sm6350.dtsi | 49 ++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)
---
base-commit: a92c761bcac3d5042559107fa7679470727a4bcb
change-id: 20250314-sm6350-ufs-things-53c5de9fec5e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


