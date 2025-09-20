Return-Path: <linux-kernel+bounces-825870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B6B8CFF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1F47C5AF3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E1C2638BA;
	Sat, 20 Sep 2025 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="JH20zbhu"
Received: from outbound.mr.icloud.com (p-west2-cluster1-host1-snip4-3.eps.apple.com [57.103.68.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA5C2288C6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758397939; cv=none; b=eWw9xDyCup2lDZODJB1BHgE0Czbfgvg97YGimDLzEzYwZ7vajcOKw1eARw8oMnDT+vcaxzYALSvu6vQp62KI4QSA84lXpskB4FB/Bf7/U9nXQIA/v1liGolEKoW5INkK1/oLxsuAUk+dxuO9XTjFl/s+h0E4Jv0LyIw1/f3RNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758397939; c=relaxed/simple;
	bh=bhGA8Erf+iarhEezB+Rqs6xiZhY6Y/I0ol2eDl5/hkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXdKJEAXoR52+ZobLnNrZgX81T1eh3ivGgKau+RruVNzHubfQRl7Ej6NV8Q865u6spxakokpVBYUD4pbVNrL/h47tLuXOm6956NyzTY4n6a89x0fFsUMUvAm/Er9T2/2WituZKVcm4mgvcZ3XW0UiGzJR83W+yF+glT3xtvwM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com; spf=pass smtp.mailfrom=bryanhinton.com; dkim=pass (2048-bit key) header.d=bryanhinton.com header.i=@bryanhinton.com header.b=JH20zbhu; arc=none smtp.client-ip=57.103.68.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with UTF8SMTPS id A6B121806677;
	Sat, 20 Sep 2025 19:52:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1; bh=EXH2uzOsYXEb/OZo3TWC/EXROKtOKzc0Az2pObM5tZE=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=JH20zbhuvH3+lZmfx5i5GM42mEK6KZEZhCcJfFVfdLpoIy3uGdod+WIr1lFDNA3aHA3peu7Oet7aIiD3Nptqs1Yd6lhMrvjxQ1pSml8AyjQnfYMh1/SuyM52hnIjjwJqCmliEwLd3HtGas35vYqK9QCQWztgDXSlmKmHO0OKFAXerWYZaUYmluJlYGN9KyHVjxuYrLO4cVdo2hq+ySr17chrcPYwJHqoiflP4FgZuNMlyg9bID15GmStOjXFuqkOrHto3MuxUHMzWXQkyWCBB7J3PRjVZBdlNf22O6A0hkHCIFFwWMFPsKptzhIqeS3YnEH8XLYZZPxv6If6V8Wmgg==
mail-alias-created-date: 1643268037438
Received: from localhost (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with UTF8SMTPSA id B68D918012C8;
	Sat, 20 Sep 2025 19:52:12 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: angelogioacchino.delregno@collabora.com,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	matthias.bgg@gmail.com,
	robh@kernel.org,
	daniel@makrotopia.org,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: [PATCH v2 0/2] arm64: dts: mt7981/openwrt-one: UART labels and console
Date: Sat, 20 Sep 2025 14:50:49 -0500
Message-ID: <20250920195102.2733949-1-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K2aGzzbemrEhCQMLHIN_3CskBEMNjXuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDE5NCBTYWx0ZWRfX/tGkTmd8Pmsw
 Ra/N8lH8kZZf59fRYSssPgX7Q4DwpgGyfV+P7hdpq2ZJsBJosEZBGZai4duDup1Ll7uIj9IKwt4
 v3XwXd6bI5BRHnfhVgSvCn66rOfFZnkvredODjER5Je0X6YT6qdLa+SIFACZ9ku4QrObK0L9lLM
 NfIQA+ioH9zGgIcadv67dMnoazLeGwcN51gV4sGBv+HE3o+9xwy0YBLZ/E/ex7YTLQDD4H/fVy1
 mVhGkkM7U8O+4iEyUWSnuRdspOh0k2WBffSsjQHewPPpDTZmd3mztaa30hfzpgesqPpQau9mY=
X-Proofpoint-ORIG-GUID: K2aGzzbemrEhCQMLHIN_3CskBEMNjXuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_07,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=987
 clxscore=1030 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200194
X-JNJ: AAAAAAABxnfy/qibpBMfdIii5yEhB9Xb/qWgxjXzVzMh2r7UF6jSgDVhRMc1bkaxeXwfMLaW2FsiQdAQ0PWZxLmnyQklXqLG4/Ni1917P7h+iEP10i4RtXRyH4x5dRSFUVHWhnNhuGIAquh/st21QZAwmIP1a1vrA3ji7jqJnlRnqzcuqU6iHZFV5vkYMRqn24i4kpG4Ps5YZJCp+/s7VBjEey9Ehu2ylQpgfwtyVX0uZEAq8Ygt3ddLYbsZn3SqTR4xRNvOM+lloTRMCCg7EpXv5rm62020OqREx84+cx2OLUW6m78k21RXvZ9HOunCNpyNusHwLkYJ9kXgP4MODpEVrbtV3MESGSy04LiujPQppzFIspfGhTrtqUsAp/6RGi8Wv31gtMK8Adqc12M+22EJAFY/HwKV9vu8rbhHM758ZQ8yfchbNfo3Ssy5fx9EV+VHbfnHFKS9jmyUkdAWY23rK/BNoniEeeEMuQD7ie9Ly0oJdRUrbvUCxkRo6+k5Gu/60x9rT1iJqgk9+I1QJrUvwjdw9S/ifKMTsjWILZPCTBcoIYO3egG/FIeKawWhWtZ48sMVcSxqBTXfHe5SDEkCFHMcAC2nHLxNyycrn1WGRKlsZPG094zgIonHJk/5OgcRrZ4GAa8sZ5omhHqJAtofpGUpUtddPmrH7GzubRWDkK9Iv3PMLg3/QJrpuKzSHMG+TO67l69JCCm7CHxb3UBx1/a6sYgtzcmvQo0K0w==

This series makes two small updates for MT7981:

- Patch 1/2: Add stable labels (uart0, uart1, uart2) in the SoC dtsi so
  that board dts files can reference them directly.
- Patch 2/2: Update the OpenWrt One board dts to define serial0 alias,
  configure chosen stdout-path, and set correct UART current-speed.

Both patches were build-tested (dtbs) and boot-tested: 
mainline Image+DTB built and loaded via U-Boot on MT7981 hardware,
with serial console output verified.

Changes in v2:
- Patch 1/2: Unchanged.
- Patch 2/2: Drop redundant hex comment per review feedback.

Thanks,
Bryan

---

Bryan Hinton (2):
  arm64: dts: mediatek: mt7981b: add labels for UART0/1/2 nodes
  arm64: dts: mediatek: mt7981b: OpenWrt One: set console UART to 115200

 .../arm64/boot/dts/mediatek/mt7981b-openwrt-one.dts | 13 +++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi           |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.51.0


