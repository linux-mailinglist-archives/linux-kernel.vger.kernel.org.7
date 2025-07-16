Return-Path: <linux-kernel+bounces-732676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F13B06A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CA61A65059
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D0136358;
	Wed, 16 Jul 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="Bou0CddU"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B5610D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625922; cv=none; b=g/AsidbHu7h5f3u14Krwwij9onzEZiLaIEtnFDUram5HF1sT5GW/oKXPpTn/ydFP2FpxBjD7LB8+pq2Ut5iOixlc46N9TMcBdxAU5D3XJebv5r3PbqS3oqFyFkRNAQnvr7yEeTGQDuPJfMmkKo4c89sMO8eGEaO63FH6B2zI/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625922; c=relaxed/simple;
	bh=lzKljEu2ic70QPDX+INYtNEy1StpnqB/dy1FAFQ9Ni4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOjzNE4MioTxSXb2Fhzpw1ecceOjsWR3WaC4l7Lf5yeWz40NNJhpxAXf2byPSHyNiL6yD/q5qn/KbloUriufS4kbzdoRCd4k1Blgr9uGvznIBgEfj9+n68RpZxTnQ6w1SIBJOA11vRrL5ytbBHtxMfDWJk2D0+Y4lKgUqb7hhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=Bou0CddU; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1752625917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3pTmCpWa5iASZYnIiU1JPiH3jdsamI1C0nlfWvY6Lk0=;
	b=Bou0CddUckij+K4wjmS1pBWC5guk/w3CMUNzlpRNG23EPVe02+M1MboI/VEnAPlL/J8I3e
	U3bmBQrr6zQ5Yl7yChUheaYUEdeJ3ak6jBsK9x0/rSiBkCoqqi5ApAU/U0AU+AhfexX+zU
	f6U3+ZyaWBgAnb155+a0SHyxYZXl5yQkwN6JX/pOeSnNIfe8msuwjjqmPzeLB3xOGUJWbr
	SokI7/5JBrtRLNBXrtLhbnYfYlTfUNFINdOjpelB6X4vTKROcHddubdrgpSO8MPeYJORjZ
	DTPQ+eOpCamsNrRV0/T0t0kiEU2qG4r2c3K5//MikSE5yikYmw99SEQZFrPcEQ==
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add Dell Inspiron 7441 / Latitude 7455 (X1E-80-100)
Date: Tue, 15 Jul 2025 21:26:56 -0300
Message-ID: <20250716003139.18543-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since v3[1]:

- Applied R-b tags
- Skipping the eDP panel ID patch now since it's been applied
- Fixed the last remaining '-names before -0' order issue
- Changed usb_mp: keep the unused PHYs enabled in the DT
  (to let them go to sleep), like how it is done for the XPS

[1]: https://lore.kernel.org/all/20250706205723.9790-2-val@packett.cool/

Bryan O'Donoghue (2):
  dt-bindings: arm: qcom: Add Dell Inspiron 14 Plus 7441
  arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455

Val Packett (2):
  dt-bindings: arm: qcom: Add Dell Latitude 7455
  firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitude
    7455

 .../devicetree/bindings/arm/qcom.yaml         |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    4 +
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi   | 1666 +++++++++++++++++
 .../x1e80100-dell-inspiron-14-plus-7441.dts   |   52 +
 .../dts/qcom/x1e80100-dell-latitude-7455.dts  |   53 +
 drivers/firmware/qcom/qcom_scm.c              |    2 +
 6 files changed, 1779 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts

-- 
2.49.0


