Return-Path: <linux-kernel+bounces-852502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A86BD925B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 071434FD928
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB41310779;
	Tue, 14 Oct 2025 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac0wAHH2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0B30FF23;
	Tue, 14 Oct 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442912; cv=none; b=cQkjaVKss0kkTOqW79mJ7mj2nkcntqYOlqY0y6q7SQ+zO2jKPjyn0Tamm1TK5bZMml5WHyyUsGr4uhTX96R00UrVXjZxylHXnwk7SfawXs6srF8G7HXNTGgjvu/rQFRrbM7v1XehKsd35SlE+sD2Dy6mgHNJar5/+y1xJatRLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442912; c=relaxed/simple;
	bh=5QysjArlLvVj9vb89PbOImCsPn/7ZhWrnV4+464hrmE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o+fgyZwwAfXF9tb4zoq2te9SNnhvI0T6x+ioFLAEIMZVozAoGhFdLMtmRdAVb22R3js6j8/4lgpw352nfY0hghrytY6hd59ACa0hGspCWXIcOK7+yaLJAJw0vtSKwwQhscec+F8/ZvAv8qqDro61Si10C8Uy8DuKGN2RzST3Fc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac0wAHH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A51FC116C6;
	Tue, 14 Oct 2025 11:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442912;
	bh=5QysjArlLvVj9vb89PbOImCsPn/7ZhWrnV4+464hrmE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ac0wAHH2aFmFtmfTHPJZ6KesAwUtuRXczDE5adklRM2lyxGcHuqUcZW+UytrprKYc
	 Sh6dCAR6olS5UnDjX1afigGkUxTA2MQZIlqXcOGH29FL8Rr3gPhc0Qjq3zDWhdl7CQ
	 V9OwgbTjtYlX007qVigAP23lJaNX1lhUvz6SuNcoEvgJKsn5y8mxHQS1RqPkzLP9in
	 Fb9Wba7CtyHA+iasVQHzfr46uKaK7z1w+cjR5QsPiAo7znJ757XsYswa9WUMMQRKnb
	 MCCKfilHpynJyQq8LeucgqewJM0z5qrQkr6uTOA97BCdy3h3dLe8Cqwz5XOfdKqh/X
	 dAhbEsYAF3TwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7816CCD18E;
	Tue, 14 Oct 2025 11:55:11 +0000 (UTC)
From: Xiangxu Yin via B4 Relay <devnull+xiangxu.yin.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/3] Add DisplayPort support to QCS615 devicetree
Date: Tue, 14 Oct 2025 19:54:53 +0800
Message-Id: <20251014-add-displayport-support-to-qcs615-devicetree-v3-0-74ec96ba8144@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABI67mgC/53RQWrDMBAF0KsYrasgjW05DqXkHqULWRo3AttyJ
 MU0hNy9Y5uUlqbQdiVmFv8xXxcWMTiMbJddWMDJRecHGvKHjJmDHl6RO0szAwGlFLLg2lpuXRw
 7fR59SDyexuVNnh9NVLLklmIMpoDI0WhtFVRatJpR5BiwdW8L9/xC88HF5MN50Sc5b2eokCDF3
 6BJcsEFtNtC12CKotkfT864wWyM79lMTXCL/8cdE1C8BFHbtipsIcXex7g5nnRH8f1qXNf7ApI
 cXVqPZD3GqJcWd9njjIta5J/xD7j14SbTPtHY82lLblVX0ojSSlDwzX2aa72DSLUiIzd+SMF3H
 YYvVOxJEnzKueTWKoFNY6kY/LUA6scO755S0SnWlGi1NspAcx9qdEQ+b1zaZSU0ulI50KdaKvj
 6DinT/4yuAgAA
X-Change-ID: 20251014-add-displayport-support-to-qcs615-devicetree-ecaad627a0fa
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com, 
 yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com, 
 Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760442909; l=3363;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=5QysjArlLvVj9vb89PbOImCsPn/7ZhWrnV4+464hrmE=;
 b=wbbBrLhaT6QyslhYkCjUI2mN5i8ELMJLggyOoZlHW8kIDq0z7x+VHPMBLQtOkF3LhDqjIGFUk
 k5yKtzyOoUIAnlTuFwIXhvfsSl9vlACtsWNgjq4gDcHFxWC6Nr/rTBv
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Endpoint-Received: by B4 Relay for xiangxu.yin@oss.qualcomm.com/20241125
 with auth_id=542
X-Original-From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Reply-To: xiangxu.yin@oss.qualcomm.com

This series enables DisplayPort functionality on QCS615 platforms.
It introduces the required bindings, updates SM6150 dtsi for DP controller
and QMP USB3-DP PHY, and enables DP on the QCS615 Ride board with 
connector and link configuration.

Depends-on:
https://lore.kernel.org/all/20250903-add-display-support-for-qcs615-platform-v8-1-7971c05d1262@oss.qualcomm.com/
https://lore.kernel.org/all/20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com/
https://lore.kernel.org/all/20250926-add-displayport-support-for-qcs615-platform-v7-1-dc5edaac6c2b@oss.qualcomm.com/

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
Changes in v3:
- Move data-lanes from board DTS to SoC DTS [Dmitry]
- Add missing assigned-clock PIXEL1_CLK_SRC [Dmitry]
- Update subject prefix to qcom: qcs615-ride: for DTS patch [Konrad]
- Link to v2: https://lore.kernel.org/r/20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com

Changes in v2:
- Update register padding and ordering [Dmitry]
- Rebase the series on the latest driver
- Link to v1: https://lore.kernel.org/all/20241210-add-displayport-support-to-qcs615-devicetree-v1-0-02f84a92c44b@quicinc.com/

---
Xiangxu Yin (3):
      dt-bindings: display/msm: Add SM6150 DisplayPort controller
      arm64: dts: qcom: Add DisplayPort and QMP USB3DP PHY for SM6150
      arm64: dts: qcom: qcs615-ride: Enable DisplayPort

 .../bindings/display/msm/qcom,sm6150-mdss.yaml     |  11 ++
 arch/arm64/boot/dts/qcom/qcs615-ride.dts           |  30 ++++++
 arch/arm64/boot/dts/qcom/sm6150.dtsi               | 113 ++++++++++++++++++++-
 3 files changed, 152 insertions(+), 2 deletions(-)
---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20251014-add-displayport-support-to-qcs615-devicetree-ecaad627a0fa
prerequisite-message-id: <20250903-add-display-support-for-qcs615-platform-v8-0-7971c05d1262@oss.qualcomm.com>
prerequisite-patch-id: 58be7053007469980bd7cc9fe315b66bbe021c31
prerequisite-patch-id: 3c2120117f72c64f69beff32c0239fbc7f808f36
prerequisite-message-id: <20250916-add-dp-controller-support-for-sm6150-v3-1-dd60ebbd101e@oss.qualcomm.com>
prerequisite-patch-id: eb07ea58347e77ee18fb6dade040affb0ab68954
prerequisite-message-id: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
prerequisite-patch-id: 8c6c905df7ee55a92a4e52362c8fa7cd9742de04
prerequisite-patch-id: 0dba0fafd032bbd6cd117175f61efd1e56ae9228
prerequisite-patch-id: d954b18774cfc0cfdb23de09aab3c56cefb8e1ea
prerequisite-patch-id: 13f2d2efbcee6337001b5f8519a6da9a41d05276
prerequisite-patch-id: 3a7144645ede23ccc7d54420e5a32e5bfa3bb776
prerequisite-patch-id: b3ea55e92953c1526eaf7c5c21d939a5f8502711
prerequisite-patch-id: 977189ef7cecbe7237175a8ef611fffb814193b0
prerequisite-patch-id: 3a12c1b4f00eb1d074e51d586f2dae3a44de0613
prerequisite-patch-id: 7f80e93057c1fd088ac6b4b0652cdfe2ea221cd5
prerequisite-patch-id: 8b29d292717782982e4450a509f4428fe6e895f2
prerequisite-patch-id: 621c3ba6bcf5b5782a5264faed72fdadfd47c630
prerequisite-patch-id: 9c63f2c5bb39527e3031b2d168e3c9419441e8df
prerequisite-patch-id: 364f6a7d8f4e1bc79a8f236b8d5a2425ffd225fe
prerequisite-patch-id: eb09ea48625b5c0d39ffb37babe7d8c32a4b3122

Best regards,
-- 
Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>



