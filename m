Return-Path: <linux-kernel+bounces-763905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B83B21B68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F748464379
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254E2D97BC;
	Tue, 12 Aug 2025 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkNRuuf8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B04311C17
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968312; cv=none; b=cjRFBy5varTGdLk4+6T9LhPKxBuFJ4QX1+2OQvJfBmwsfFtSBCTLPvJzK6pUVEMpKK2+xnOzSGYSU16UdLmhzGL9ewNFHwlUN4mj26XsvMpJIWYgtEL/2zvfZsP7xSVt4uqkupYIMtKpcoGf+NzCGovpEiQcFtiBFOBRd6fYuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968312; c=relaxed/simple;
	bh=Mj/gF/9fSY0f+IqlOycaY4NkWN1q9QsT0o98LvPFuFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W+JB0N1SR5YM9f1424KsoP1hbOYUqi+zbYMj1HgcQd6m6kaFIwQPVorlGCB/nrORblCFCNUufEgRrC5t52Bej8AFvIeJlmQ8YXVuY3T0GXyGwKlnnLW6VViW0bZEMfhgXtA8klCuAi3RZD5DeI2NhX/g90LyyZV2zSgdXWPtOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YkNRuuf8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGQmmM029604
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BAV/apLO74df1jngYHBqyu
	gvW7f0OfhZGnzLMbl9/qE=; b=YkNRuuf8WmFB7xXuqOHsLC7BXFkIjdhdVTPmGX
	MVVaqNew5Dwv1yehOtLa7dRyKt5v8jam/TJAQl7bcKVQuwmrO2I8fnhxoWCPZEeU
	qde1hSQ2ykvX4YKBbF2/8AYcjGXgfYgCfuae7kTaDxt106XCJfYWxfCqO2Zln15P
	iG3WHR9R6HNOoaZgtWEBFVF0qBCg5qNx6fGb+K7lNNl5CMtC6om9Rk2zlr6xYc5G
	5EbUEgmcC2mLBv/jKEH5ybC/l9Ai0gJ0Zvz/OfwW0OlHYxFVJUvyLVBnZJnkkO1j
	d2A3CzBQkkN9lzFfxmlHYFJHowRiRIAB19XQ8BkCgkcryXqA==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9spqyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:11:50 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-30bbadb3f41so8538201fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754968309; x=1755573109;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAV/apLO74df1jngYHBqyugvW7f0OfhZGnzLMbl9/qE=;
        b=U4Ob/q/KUFNQPWb0snMf5mfRuxKOm6nddFXT/sMBeuevGk4Jm7NH8+3qy5DuQuGmbw
         THGHbjAo6SgI8Glm/vDESZHPywUUKmYGxfS2pGF1m+0q1YEQZx+hQhwSh2mpTf2DvZxe
         9Z5BUG6ybwT1BiQGp8oL5SKIN/30l9CmESPGtQRh3QR0452VWNaCiuJsZHueuJv4Heex
         Lf3PgdiqzoBPAnH9HpJMOGbBJd/629ZhxN35N6wK4SbAYE43vRC9BzDd9+UExTiduAhZ
         hhKBQhK04/1cpTBwXGJqPo8V93kucQE2Z/2UkQ3p0vyjCTRIsTDLFWUNQZfvdf35vN2o
         RGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8lvFQxDOxKzHJM3SDsSQXcGKeiYxTFUGGHGysDkWXVLFo/3hvR7fOsB3TSTGIeoPzlLZgcrJf+5JyYbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx706yf6sAP13YFDfojSwJBrLAK7PWr92uzgI4joRuW1aooFCa1
	ngDNYMOjn0JT8gwlnVJjxMf1D0/QRMgYHy4SUw6tXK5Q4ffzndqxYAmZt1hJAWo9Lz5jWhZSzJY
	Dm3RFqxWKzaDjAsF+unpuciWnzF0s3Xo1qUQePAQrQvWPo4bzEPpPM0+Wike/gIDTFrQ=
X-Gm-Gg: ASbGncuaLoKCOQCfDPB912c43X7r3ArXB0I6FGhstjWYJBMA/G0h5S7aiAdGhaQQE8Y
	JYzuzyL0iwFT1cugUmntVB/wfQfT+NgWILGcb1UyXcGp8RPzl9hHcOQ1+T1XqLAx3W6HX1yy11n
	Ke0n19VExdpl/vVoQVxZsPHVV0UngtmI9gTDIVfnC5be5OzyeE/lmvVVt078CN4VDGfqAfVEsdO
	ky5GNali0bNNVu2HmFslg2FrTz9tshUG0AFhv202OlV01Zn5Ibe92wR+Wxq2bwmU50Scp/jly6l
	XII+VjRBMY9Z5V7LbHpl8XkEaHnX9jfgZS8lv7wxDwftmTwlQcVcxkkDqADTo4ZGcWOR1qczDHA
	I3iL0sS/QZ8eOZqjKA2jChxyeC0OLR6fPg67GJds=
X-Received: by 2002:a05:6871:1d5:b0:30b:86ed:a23d with SMTP id 586e51a60fabf-30c94e807e6mr1136998fac.7.1754968308931;
        Mon, 11 Aug 2025 20:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzNlsbXJxq2ZDPixpYLAWXnmxJmMs7DRwNxWd4nF+aTiZVLDZe8psAbaqwD1L0gMyjxQUVTA==
X-Received: by 2002:a05:6871:1d5:b0:30b:86ed:a23d with SMTP id 586e51a60fabf-30c94e807e6mr1136982fac.7.1754968308604;
        Mon, 11 Aug 2025 20:11:48 -0700 (PDT)
Received: from [192.168.86.68] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307a717f0c9sm8174531fac.13.2025.08.11.20.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 20:11:48 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: sc7280: Add the MDSS_CORE reset
Date: Mon, 11 Aug 2025 22:11:32 -0500
Message-Id: <20250811-sc7280-mdss-reset-v1-0-83ceff1d48de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSwmmgC/x3MQQqAIBBA0avErBtQK5SuEi1Mp5pFFk5EEN09a
 fkW/z8glJkE+uqBTBcL76lA1xWE1aeFkGMxGGU65bRGCdY4hVsUwUxCJ3qrmthOzpvQQumOTDP
 f/3MY3/cDmjfWc2MAAAA=
X-Change-ID: 20250811-sc7280-mdss-reset-a703d4b8a2c4
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=Mj/gF/9fSY0f+IqlOycaY4NkWN1q9QsT0o98LvPFuFE=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBomrDtdIUCXra61pec7tBq9aXq9jN1LrBsryBgp
 W0A9dl1g6GJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaJqw7RUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXDrRAAhG+LiUCXoRaMu2d80RM4gpI8EvNXP68APXDoMwq
 X4p6ErAVz3w5vDkHfYhLddVIlleZn6pd8mu8KRk7lAx0/9Xk6f1xS1UbusKW4gmy4w7rkHlFujR
 oRrdUUHh/9M5J7dHnTbgSZrJPG2NlUv/rX21grrbkoz3S0xhN3dvn8xL7YtMNCgVGN7fjQeWAlx
 NjCLQDx9Rd0pENkK8Gsrom0HBhQz0DpMZaI1Qbzp+f6GDKCyKLek+whmx2Y2Q8qaRRSIDzYTmNd
 00/kDMNAo8wtbNJxFB024+oulrLkCIwWHSAoIgjj7S3WTtSNmteEem2G7g4DKSCrtZsycTq2S6h
 P0jU22SFJnRMpEB087pfDfUKKEK9CtcgB+c9EM0MzpSHNpNsFtNhXrPsOth0uW0FAIjtUD2nrWv
 s+pZde3w+EF+WQLrCING7CHyNFINdkB0aePP1eoKQiGVZ0a/tm9CdXD10uZH36/bS6FMiWe86MH
 d6jOfqJFb742acKpoHwKx40bMA1oXMcqlfS2NHoir5Q4G9NSYlerYKopdKtwv4tGn41h7/Nk2dC
 KeUD4BuyoNbQb0zclxOEf8TNBiMLDtAS+zX1XDCmVACdj5+REfohNONFKXqg2i+OrVh/zWZos4h
 ZyB0G0/rkbR1hv1SAHEeUzxvMiusfQfy6jOJOmH22AkQ=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689ab0f6 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=SSnYddtK9NkD3JaiHHAA:9
 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: _if-RuScVz713pQ9vImBS06kUS8eBemo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX6uZ9j/9JnqbV
 EOqLlP5aN9KshSZEOqh4uOa0weB/5UjKoFguftZSvNYz0BsWO1gf1zjPT6dc7EpmJ+wJKfd5p/C
 L/kfvaM2MEeT/jqICHn9sTw00HeJumgTDd/AuBchirQHWx8cJpULGu2lSine6FWrq2miI5d27Tw
 86pRV8yzWHcLrP0vrdqqoOIXsvr9sbMGl5HKnEQiqxA/7prHjhaHY/ejf6vllPPG/x+YI4mKrn/
 SHgLlFC6NVpeii2TYJa4RtmkXXKsiESDDdUjd3qSqnC3/2sFwOFQLlhMPokXi8r+xylvWi0L5uS
 grUjsW6A5T22rdy8vY150fA5NQ61nm+1ig9kD32JNmCuLahKXTTpO+k88AncUK4otDFecG0RUm3
 AaOO7dgh
X-Proofpoint-GUID: _if-RuScVz713pQ9vImBS06kUS8eBemo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

The version of bootloader found e.g. in the Particle Tachyon configures
the display subsystem to the point that Linux isn't recovering the
state (currently hits one or more iommu faults which results in a panic,
still debugging this).

Introduce the MDSS reset, like we've done on other platforms, to allow
the OS to clear the bootloader state.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
Bjorn Andersson (3):
      dt-bindings: clock: dispcc-sc7280: Add display resets
      clk: qcom: dispcc-sc7280: Add dispcc resets
      arm64: dts: qcom: sc7280: Add MDSS_CORE reset to mdss

 arch/arm64/boot/dts/qcom/sc7280.dtsi           | 2 ++
 drivers/clk/qcom/dispcc-sc7280.c               | 8 ++++++++
 include/dt-bindings/clock/qcom,dispcc-sc7280.h | 4 ++++
 3 files changed, 14 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-sc7280-mdss-reset-a703d4b8a2c4

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


