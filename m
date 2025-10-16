Return-Path: <linux-kernel+bounces-856109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A55BE3194
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E219D189F567
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD83326D77;
	Thu, 16 Oct 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="UM9t36tz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A331AF3B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614543; cv=none; b=PskHsb3XluAU94/9MkO2XkhM0P22dW3y+GKzodinQCUU84lHZFWWyUiN8ctRkxyzP1aH/i7Qelib5KbBCOcRq8pp7S7T1kr8/5LJ7k0NDao3suXLTTxebmrVb3SaDdnCm4nH3hxNAOpcWbQZUs05gmepjvMwbhOFs8fKRzTPMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614543; c=relaxed/simple;
	bh=gf8H+ukYIbgROYGzqMkJ3nKfIiaJaTqo98lw8T1hC40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7PAcHRODYkBQISzKPzVwGvrJd5N7bcqOSXiR+o6MzgKc8w6AYwFsyePJ+SqSDg2s+cPmx4UcjHcQ8QrX9ScZx578ndPKAOqLDJ7Vh+ip5pf7Hl3V3fQcGXot41E3FWiVkzlLS6l3nQ8BKKMlnwHSNatOCNKxDJQxHrFLwsjtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=UM9t36tz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so1283240a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760614540; x=1761219340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mff1komaHzKy5qamReWqnHNEDw/jb5nxHAJoK7B9V8M=;
        b=UM9t36tzrlEtsafPLgYDmM2QZbfpizZOI1F4qKwfx4qcBqVYsz9AW9A+gAgvSV1Hzh
         jRUzoOJMyAm9OH/5sFP9sSU5DYtruMRd0ZMwauxAdz01X2/4L5ZvgDgSVA+tq9ADNRYq
         r+oymLBpGVk0srjcHDsE2aNGo+KmamumOXtu+fs+7Tsc6h3WbxBaopQtDEhgEW0LTDCI
         RhI8SALGEI5Cm/JgIkytZaXHGAewOh6JH7tz+2niQYHG8sx40oi8aZgOtEVql0K0WMku
         8nRMQrs3IsEfujkTMIJQTp29MJVgYd9VNME8GsYRfeSsg1i3+NjHM3HmwwW51RGfDfcu
         WLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614540; x=1761219340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mff1komaHzKy5qamReWqnHNEDw/jb5nxHAJoK7B9V8M=;
        b=OdPByiSOTG2eUhcTYjTu/bsYQyDhmW7trqfb3MhjkfWnw0dfFzL0K3A6t6dqZmwXfc
         VuPB/9wnFvJ8d2gRXbEyc0OJxulmNNMHGrlJPZ/G/iH9AcDPluFfmhUe/d48G/xck6t4
         BCg6iboN03iLVUvO++7Y2kf7gTOuh0nkSkbkEEiWX6OXDzJtRCbIBZMZxU+oXMRsVtlC
         fHisUpTFOYBJ4tQpXJ/LJOQYbE3SL/xRYS6UnNjg6T1fRymbiUISzK3bBGz0F6CRn72P
         3IN43UCVBlr14F7P0yybM8PLw0KgNzhFWPyt1hNvVNNFUgMvzU7rbWo6RzihsvdmWUrE
         EMyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJJ53hfArfRn2HZBmqI7ihWB66cuOb651waZw+Sqe9AZGn2qRkZB05c2M0tQ1aGbFS6KKdAa3c/9iMuBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBFnKMmR5tAugopjdeUQDsnfZcHETQpmbw6YfY03clJILIW1/
	Q4JpF0uVfLnilxOjSvpRouYATkIIKiTYa6M9OMZa8fBFkGXM0S88LX1uWTbrHn+P8zA=
X-Gm-Gg: ASbGncst/cY3P7jD7MUEalMvihm5gk8PRHulxM+VWqme1Enm9tqxwSj1TvWfNUDtVv/
	w9SzVHph5nycmbMkFSdUepsrKtSEIJMCNZI70LHJY7Dc+MTy65VQcOS+KBTHPLqfMqkmR/P6USP
	tpReWcCCnghlwYPY4LDoottHcvxQvG0PshwuoOf/Y/sOZj+enh8fuGiVL9h4XxDQN0rSzLt6ZQ+
	FdsVIet8OozPw4qUwoXBxyls4JOfU467TgzLJnvtQpmBMYV91RpKkNOVPAUm+WapSOGxigDCR/K
	ol0EemGJ2WhQK+V6JU/Y5IvxgK2cn8uNxd66umbsAZs8GxSEhZDJ+yT1+8GZpPJ+RctYpniW5r8
	gHNBj2m/O1n5lM1Tg0sAIH4YHPDqWk/rbIBXgvKw9abAp+xbjDKbkZQ32NFzRhjZhhWdjAsojIy
	rn7JMD+XxNC/f0TXJGZTehd/TkRC4AV7fQdECH3YKiUxxhH5OvKLafjb7AOw==
X-Google-Smtp-Source: AGHT+IFt0wcc7vVIDScENVCFhYLkuARX9ObN5Qzs2E7dwGXfe1HoldJOiXObCCcu1OnE67EX8a55JA==
X-Received: by 2002:a05:6402:34d5:b0:63c:eb6:65da with SMTP id 4fb4d7f45d1cf-63c0eb6688dmr1482472a12.34.1760614539709;
        Thu, 16 Oct 2025 04:35:39 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm15849397a12.19.2025.10.16.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:35:39 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 16 Oct 2025 13:35:24 +0200
Subject: [PATCH v3 3/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable CCI
 pull-up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-dw9800-driver-v3-3-d7058f72ead4@fairphone.com>
References: <20251016-dw9800-driver-v3-0-d7058f72ead4@fairphone.com>
In-Reply-To: <20251016-dw9800-driver-v3-0-d7058f72ead4@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
 Bryan O'Donoghue <bod@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760614534; l=1033;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=gf8H+ukYIbgROYGzqMkJ3nKfIiaJaTqo98lw8T1hC40=;
 b=X8KaIXCiujGBnMpRRbzNWlyFPBpu3tG4PttYXtjNEuJe/QimnhfHsEz4b41csRGR/uwHk1LHu
 zE6cviABJz0CvJVuEykDIOw8aLaO+EJOIwjbffq1k9qyj8MN79c1158
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Enable vreg_l6p, which is the voltage source for the pull-up resistor of
the CCI busses.

This ensures that I2C communication works as expected.

Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index e115b6a52b299ef663ccfb614785f8f89091f39d..2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -749,6 +749,8 @@ vreg_l6p: ldo6 {
 				regulator-name = "vreg_l6p";
 				regulator-min-microvolt = <1700000>;
 				regulator-max-microvolt = <1904000>;
+				/* Pull-up for CCI I2C busses */
+				regulator-always-on;
 			};
 
 			vreg_l7p: ldo7 {

-- 
2.43.0


