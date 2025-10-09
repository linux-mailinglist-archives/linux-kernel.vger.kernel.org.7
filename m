Return-Path: <linux-kernel+bounces-846963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8424BC98A8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7616F3ACA45
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404292EBBA8;
	Thu,  9 Oct 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="FWGAsSwJ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B972E7658
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020530; cv=none; b=dlXsZkEidmnCU4xgH3B1h4RTEekp8Jam4iXX8MxdwHoRs72eqpt515+khC10rEOYfEkm08mpzuA+No1wy4osMNx3USCqWk7sn8Jl+iUuXyHN+zbsIt/ys7mRI+rOciW7oebclvkc9a8fii+hkqvCqY5nNMo7F4Ea/TtyLsRkVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020530; c=relaxed/simple;
	bh=Tm5EfTqaC5QMSjBI6EGvo9CBBe5CgOuV/UJUlgWJ3EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmMY3zjyH0I1ivtZn5RYLmHMoLQApx46o/23fNEw5vF+zU1ogdPOOteCxK+KQGrWFn2vy3lDchAj1TGnWGH0UqRXHRAyZGa96+CMvapEVS2VTlRBDaB5B7PPxSLFXp7iePSx/VIdFYL+t+l6aYkFZoV87mKMK19XKPVLpknI3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=FWGAsSwJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso2121689a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760020526; x=1760625326; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DHPPLmhygT7LvJBN57iAEhxLZcu4AGW0vEJ/bXem0w=;
        b=FWGAsSwJ3ha8UBWVQv4NUbw2spgvlyISDgiNnytekBK6x+iRxmEcsZPy6Cca3Igftl
         4Ni6eVw95BhWjN6WASYjUpkzl7cfyGwcizsPV3c98RVkATctQHQqd5HFuxTfAzbBl0OF
         sCIKyKmBi1jkgUXm2JUkEFPyb4bwdIMCWllRQEvrF+6ESzRLKA3yZItBGKlCEH8ZzRj+
         yMoNEH8y3+/xHaKZkKuBcu3qKHgZUp3xNfyeWIu8y5vNjcHUeFQzdngdyRw0K3XemWzJ
         3pvQmhOgV6Nhcy92dZHQcB8tMRtfnUhu7Dn2lWLx8U4um4OKOc7kdK3qSUhDqiOSDVmX
         wv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020526; x=1760625326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DHPPLmhygT7LvJBN57iAEhxLZcu4AGW0vEJ/bXem0w=;
        b=o1gtMNtufYWd94DWv6AAkNh0hUEArIYcc12wRfu+wIV1LBnMHbzNmS0voiVGVoi/Qe
         Rsao5kxwAk6V33dY89yf+Kn3T8eI0HFEhcdw/CIjS1memMkptvWqEkSP/IdroQDbBmlv
         YxR0VdSN9aIICWwdK5Fm7kPh5nWAkxNT/p/jnZK3D0VBnAn5Gdp/7VZoxMXnXMLEDng5
         YlO/KAf9Dupe4GMMFpBQPhZ5t/Gykb7fBVEXfQd0IgfaDP/roHPZKgIu4CpVwDAp6R4N
         d653PwdeiQeZ5hpEiOlgSDXodQ2SCUKDwvF3U78gqVUHNRmTFLXoJF2BRNslsDyO+O0n
         oYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWjR8Ot0jv4GQNZYV0eO2q+1umm4Tcg9MolKR2U1Eq0LeZ4ZRp9HF3yPHU3rNz5q2rPJW4Y/DT58naRzio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOb7VTDDZJPkmVKLCR1lshppmaKnavEAjwac8Q1voulO+N0/W/
	DPSE815drpQcg1HLFTOaER/lmamdrY1NARwKuJ723xAuj0K91htUBxEVrrUOOulFk3g=
X-Gm-Gg: ASbGncvqBI6GS7V2J9BB4HAZqyLhVcexADj2BjPb31lnSEBVLc5XgI3rtr7aTnlszeN
	vZ/qf3Oj4Hg4iS+FmyYlOBFuV0Kw9k47AG73H2egNBOvjsgc98doetyJUn7c/FIAtTCGBpYbssw
	11dXxGbW5fGRl4nfJ/VYREcEhwwlZUsjTeb3tQH1UkUPPBDASFKwpGIVc6sWMnwrjX78g5iD515
	+4SdED50W2eRjbUukmtjobUoV7Jy28jemSgCg5SEtCvSU29q93PpnY8StM4SoEZH0UvM84EfSEm
	XBic28V2fM6SvSLSxWzgFquXDAbxbEbS787SlvbQPq8q+Q9/KNVSUE6LpxawuRhN2nj0IOpCI8X
	j+oiXL7+f29jTvdQMWbNjX/MfwWHZ+jVANQx7uf07GvhR6y9+ppaB2u1H5xqYZQO2S1rC+R/JUR
	qeRR0fdlz5+83wZ5LWXUlC5mTpz1Uy
X-Google-Smtp-Source: AGHT+IGpvCBf/6AFoWh0ryKjV63PoQaWy0iA6WnNNox2AMwgEWvefm4/UWZWVAqH1ctSB2lwwtUAdA==
X-Received: by 2002:a17:907:809:b0:b45:b078:c534 with SMTP id a640c23a62f3a-b50ac5cf768mr908616266b.45.1760020526492;
        Thu, 09 Oct 2025 07:35:26 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606dc84sm1885797166b.45.2025.10.09.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:35:26 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 09 Oct 2025 16:35:09 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable CCI
 pull-up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-dw9800-driver-v2-3-3c33ccd1d741@fairphone.com>
References: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
In-Reply-To: <20251009-dw9800-driver-v2-0-3c33ccd1d741@fairphone.com>
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
 Bryan O'Donoghue <bod@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760020524; l=972;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=Tm5EfTqaC5QMSjBI6EGvo9CBBe5CgOuV/UJUlgWJ3EU=;
 b=MhSWOCpqJXGxUUtwnLCjRnSXLNXuk0uH/IvCO/kBKSyHfHxd6pY7k98vC8oLKyZhywKKumTV/
 Jt2jzAYz2tFBY0G0R+MUbdpyJQCiZtm2ZXzcXrxBIT6qg6CP9LTR11j
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Enable vreg_l6p, which is the voltage source for the pull-up resistor of
the CCI busses.

This ensures that I2C communication works as expected.

Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
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


