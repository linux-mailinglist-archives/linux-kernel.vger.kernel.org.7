Return-Path: <linux-kernel+bounces-739813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6330CB0CB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CBA1AA4E02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F98239E8F;
	Mon, 21 Jul 2025 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="lZ/3l5cq"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F22AD0F;
	Mon, 21 Jul 2025 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128715; cv=none; b=tsTlAMplOHCK04jtibsyTSFXhoP8ezz82K1B4R5oVtXnosnJrXTr+z1ZEHBiqJ7vVc5dkPdrN0PIuCD6+ou3v+aeboDd7RZsXQzopfQ2UyDOgBRLHXCgd+W+RMrf2fgER2v1+ygbrtiWqMOLq2bb0toqe8qmQ/sLFET5wj+mfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128715; c=relaxed/simple;
	bh=bY4kKbIiOBgmi7jD1TrZFrE7zKbhsZ8NY4YXz0Y1NyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=derBN40YfUWP8iLWZ3XB+9kMHkgk542BHT41jZHxc3S1E+Dcg8/QdiJspD61II7U4Y2vV+JQNWd8YoD00UzHNQZi9cHXehwJPALzsrdNT150cuAfmGKX5Z9qPhj5CxmaBT7SpxomxzVHJ3l0wJmbaJk4mbs3tp+cF8JrG5hyn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=lZ/3l5cq reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753128706;
	bh=bY4kKbIiOBgmi7jD1TrZFrE7zKbhsZ8NY4YXz0Y1NyM=;
	h=From:To:Cc:Subject:Date:From;
	b=lZ/3l5cqhD+kjK9cCrgg/C4pL7g7MIuyHGi8RwlgvK7/otINOdZwzyBoC3VVrFOr5
	 dtsz+b8i8N05h+w7Fw881aO+DCTfmTrpEa+wuBr+BQ/0Z5H0PF41euQ6d6eHVCVwN+
	 2vKnp0nYl4Ps4ij1yB+AbWjhc58zTb9q41z9dMlIvJghQkh+DBOXqG06vrnQbBD8w8
	 +5dTnFCc0uuPb5J/xN5miXgBhaajq5xfSODhfI5LBR1SRn2/FpTUr39cJQGy8Hu5V1
	 tHNM+6Zg6R6I37GImbXB9L3ELcA3hkEdvMDkPmc4D00GF9tvxfGKROh5L6cge7QSuG
	 utSlxERvx4atQ==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:da10:58b0:4f02:7df4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 2AE2027E472;
	Mon, 21 Jul 2025 20:11:46 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Erik Beck <xunil@tahomasoft.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v2]: New board support,LinkStar-H68k-1432v1 (RK3568)
Date: Mon, 21 Jul 2025 16:11:34 -0400
Message-ID: <20250721201137.233166-1-xunil@tahomasoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Erik Beck <xunil@tahomasoft.com>

This patch series, revision two, provides initial support for the
Seeed LinkStar H68K 1432v1 board, featuring a Rockchip rk3568 SoC.

Changes were made relative to patch set version one to address
comments provided by Heiko Stuebner <heiko@sntech.de> (Fri, 18 Jul
2025 15:13:22 +0200).

Those changes are:

* Splits the single commit into two, one for the yaml binding, and the
  other for the board devicetree plus Makefile addition;

* Adds other recipients needed from get_maintainer.pl --nol and --nom;
* Uses git send-email to send the patches, to avoid adding line breaks
  from the MUA;

* Changes comment style to conform with style guide;
* Removes several unneeded comments from the devicetree;
* Changes LED naming scheme with more standard nomenclature;
* Changes naming of regulators, prepending 'regulator', such as:
    - from: vcc12v_dcin: vcc12v-dcin {}
    - to:   vcc12v_dcin: regulator-vcc12v-dcin {}

* Removes unneeded tx_delay/rx_delay from rgmii-id


Thank you for your time and effort reviewing these proposed patches.

Regards,

Erik

Patch File Summary:

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../dts/rockchip/rk3568-linkstar-h68k-1432v1.dts   | 740 +++++++++++++++++++++
 3 files changed, 746 insertions(+)



