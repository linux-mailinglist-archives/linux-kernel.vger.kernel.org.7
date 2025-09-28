Return-Path: <linux-kernel+bounces-835203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405A1BA67E9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F131917AA84
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2A8216E1B;
	Sun, 28 Sep 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3yfAOFC"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F0220F20
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759034771; cv=none; b=p6IH98X099DerNPLnNP5jSAm4QXEqePFxBaD7Wmip8NYmQf+95NFwfSbUD3E/moqM+efhTBEN8v04VIYx5TXVQj+dpHd2Na9r7e1hAuxRDGnn8HTZEeCGQeO6+XzjG24NwMCtrpg40Fj8WpFWw+14bJscn1LV9Y6Xmm0vbY4uno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759034771; c=relaxed/simple;
	bh=zfTq5g1ludAKubu4g9KK7vCWa/JgTFL7So3sYNlLrGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aG1o9luGRjWn2yyca+2ouKtfNXOwS+64W4a/D7RoTXLrsKw/BtvIMGArgD2yjjbebOsMoFwE/V48WJn5Wo8eddwnWXn21cPusw2A0Qm/kiLu3DPIPZ//qEtKX1eNkJZNFyP82e8u21s2OLnakXJbVdIjcpmptd/q15WfILgEnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3yfAOFC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso3333284a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759034769; x=1759639569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Iq+ECzazVF8cvZrw/yaLLDjTg+zMVvRf59rdoyx9e0=;
        b=K3yfAOFCREtzG9mjpmOURVgR6itrACdIZQhC9dfpEIwo+dR2rZ/FOd6CDKTAJ3RoG0
         WeootEoyNhvOjyRkBmb+0AUxo3kTydZkh0BFiJ1kxvqo5LGhOQDFo0JEByELEUBsMT2d
         FExKVO6pTJiNUeBM+mH7wu3mdmHS8HRFshiY8zRCfmzGSP+5Tc6oqBdrwoMHcMEyrLQR
         ZxwxqRXQJlUYaO6kgO1BV9FsepzoW9giu6w7MSDc46Xe4iDdbMpswg1Yj7T0M5RZ1hVK
         IcDcJGPRyYcSW3IkHEVxWT67yYkW70zsCjBcro55Re3yQP2WFnv8/ZywuDj+Dia6h9P4
         l/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759034769; x=1759639569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Iq+ECzazVF8cvZrw/yaLLDjTg+zMVvRf59rdoyx9e0=;
        b=S38hjDiWmqqtqxC5Vum26XOfuvMv9B3uJtg+x8b3vkyNrsdRsrQGJFkxKwc0DcqLsb
         PDHn2I1gWu8lPXAsy1yPMUgaVTtL+/pmJtycNPwkwcVSa9xFp5YJ1Yv37fauCQRPnJJt
         Sv3hMGS/NBUMTtHRokUsTKU4EzahucUcA3V7u8yfhoGmIb4k/DSpwfYK9GRcCrnQmSq+
         q4LyV5mVXdR9weHO2z+fKloJFx0Ai/JVK3J3j4+cu0W4nUAivu/LxTQiOMAV2LaDxLJp
         TW02NlR1Rd2xG1XyIG26fRUKm+CxZkckLqCiAIc7qTOHn9ppL3N4ELks/yd8HSsG9+MQ
         PGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+RciLYZOIcJImijwCok/pcQCDFqvNTReD2TskROczzTFS80aJgOrOjfbmdv46MoX1UXMGJXv4duSnxH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1Sq+Obe6VooF82aMMSpuwf+10rtKu9OX/0Lo1szcGJjRZVBX
	ZjlY4E9RNKQftaaVfIDxLDPdDnlPJ/dE/peb3FYdfvAcnVw+5o3ovv3F
X-Gm-Gg: ASbGncuDFK6NKaULcy2pXmKKDAg2epYJMD2vWOY4S3tosAJz+rz4vUHZWeexK0+m0W/
	bhJc6XC7/EHj9JPisqG6jJOl5Xg8sKcWWPodWllR5DlObazhwE7ETJyZWMzyltXeEiGbuCNQ43W
	TGSk56BayYO2+GDHbdkBeTawfq21x9WIwc/zlIzP9RPESHw7u5AZGkfaP6vbay5YDSXHTZOUiWs
	7upVTSRnBGxwH/2l/NLtclyjzp7d8Fo6ix9i/ZWjN4VdI1ddga5gOvaarf6uLBV4wGWpk8xPxG+
	91sln0ZrbGmjEd5P0zifiJRVbkMzTQkAlnlgTk2yni29oU4W7AZ0UFjBnvdh37TrR3yR1UT4vKC
	hzP8qgPQBqb+9LboIkX0DARnc8LyhEz/u5lXhuIUtLAD26OT6wbk=
X-Google-Smtp-Source: AGHT+IEoaeyJQ5U8TsP5ap0KoAVJ8ly2czmGqC1fBrRX1g9BM6bblQ1XKTqGT2n8r5GFu3V9SPfCSg==
X-Received: by 2002:a17:90a:c2c3:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-3342a346330mr12163227a91.36.1759034769289;
        Sat, 27 Sep 2025 21:46:09 -0700 (PDT)
Received: from archlinux ([179.113.184.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3350256d403sm8621263a91.14.2025.09.27.21.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 21:46:08 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm8250-samsung-common: correct reserved pins
Date: Sun, 28 Sep 2025 04:45:33 +0000
Message-ID: <20250928044533.34798-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The S20 series has additional reserved pins for the fingerprint sensor,
GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.

Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
Changes in v2:
- Fixed the formatting of the <40 4> line
- Added Fixes tag
---
 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
index 96662bf9e527..a87e3d23e3e2 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
@@ -159,7 +159,8 @@ &pon_resin {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
+	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
+					       <40 4>, /* Unused */
 };
 
 &usb_1 {
-- 
2.51.0


