Return-Path: <linux-kernel+bounces-718943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD915AFA7CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 22:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1B518944DB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jul 2025 20:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF02BDC1B;
	Sun,  6 Jul 2025 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="k4UjhD18"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D282BD024
	for <linux-kernel@vger.kernel.org>; Sun,  6 Jul 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751835538; cv=none; b=s6V6JV6FjztXgFL2HPAwNKMxPguG+ft9f/8WmLYxY1FXqb6KIYqF77XgsVEatdwJyHWWA3hLTIYhmCE+J3Rz1xZX/zUr8J8y7wu3RnklDlv4DrJRD56GZJe2mN78zCRgkVF3DLho5c+IOY7BkXpg7LkA8kqAkGgmksgeeP1+5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751835538; c=relaxed/simple;
	bh=oJe0Jvb+e6o3LdcbttuWCAKKRAx4UqgdZHR+g1QlkL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSNSFzauVWY73lto3lsv4Cq4IpbjadX+8k/ZK3UCm9XBJooP0ZywkJKWht9mwg6r24WV28k5M8JZc0q37SKuX2mzHkpuVaL83YKMhqkY9vtpgm8JZmhhXZfmh9U8pFwIuYQJGdxzrIZJbkjyGLg3VNRLf2hbZVV4ACKaxok7qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=k4UjhD18; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1751835523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q+xpk0bl4k6HE3bnotHGuna2LqDZpkUgnqbHeuK51nQ=;
	b=k4UjhD18vFJB1H+3OgcpK/ctGCu5JpEjuzxS7t33gZs4/GhhR15Qx8p6EN3uxvp5xkUJgQ
	5ey9kDfJPvGrtPyU6HrzieE9Q7gpGE6pIfdglxo+g+056yCdLiXn77xN8ATHghZhbNKLY3
	10/PN4LwZF1+C5xVHlStNfVLZNMJ4x5rnaz14/e3IDajpOsN5NeVyk+VAQRGDYUTKogaRI
	kOGgkN/SR7MtNB+oo01wtYgBMlUimm/5PFKasTxNaO7SdqX/5VPmhG+UA4ULqggGBhyhaf
	j5EBOy9nbjo9fA/REcgw68KbuZBZNHao5yKE6Wp4jkkNg76b0aW3R/Ln9oHWHg==
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
Subject: [PATCH v3 0/5] Add Dell Inspiron 7441 / Latitude 7455 (X1E-80-100)
Date: Sun,  6 Jul 2025 17:50:22 -0300
Message-ID: <20250706205723.9790-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The unified series for Dell Thena laptops.

Changes since v2[1]:

- Fixed From/Co-developed-by on the big patch
- Fixed one remaining "inspirIon"
- Fixed codec/cpu alphabetical order in audio nodes (copy-paste..)
- Made the common dtsi an 'x1-' one in preparation for x1p models

[1]: https://lore.kernel.org/all/20250701231643.568854-1-val@packett.cool/

Bryan O'Donoghue (2):
  dt-bindings: arm: qcom: Add Dell Inspiron 14 Plus 7441
  arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455

Val Packett (3):
  dt-bindings: arm: qcom: Add Dell Latitude 7455
  firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitude
    7455
  drm/panel-edp: Add BOE NE14QDM panel for Dell Latitude 7455

 .../devicetree/bindings/arm/qcom.yaml         |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    4 +
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi   | 1657 +++++++++++++++++
 .../x1e80100-dell-inspiron-14-plus-7441.dts   |   52 +
 .../dts/qcom/x1e80100-dell-latitude-7455.dts  |   53 +
 drivers/firmware/qcom/qcom_scm.c              |    2 +
 drivers/gpu/drm/panel/panel-edp.c             |    1 +
 7 files changed, 1771 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
 create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts

-- 
2.49.0


