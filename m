Return-Path: <linux-kernel+bounces-739823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44FB0CB87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A466D5445F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E485239E9A;
	Mon, 21 Jul 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="Gty0/gO0"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C519E7E2;
	Mon, 21 Jul 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128992; cv=none; b=PYhS79lqKmm7Qg/5WCMKo+jgZFfZPLZNb+IGBy50XJxLY7tmwD2XrbU0Cm/u7CZR2pY1E9UCevzJmDvDzlIWcX65pevpknjE70h09/68kIKBpDVxBY6P1FWlXhZtWgtIhwe3EJTqeP83UPvNGRxkuSEqrT0sF6z9BaVrWE/BrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128992; c=relaxed/simple;
	bh=igbX+jfJh90M1KH040iOHlCfFeYBaYR0WrJ2E+mayYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6FkSgQ6IksHSwLu+mFLPqJtuhzGb1w5kIf9EdBvjqdkpD2aM4wxqQzYgIXiUYY48hagY2tEzXSqYY6ZA+fIIEqTXzb5oHGOKU6ZLMoCl9TKrwoGB/5bwqCDZ5WNu6+dILZaRhKi3ukTd0Vi9OJipqrWqSF8mJFutRtZpVchh9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=fail (0-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=Gty0/gO0 reason="key not found in DNS"; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753128990;
	bh=igbX+jfJh90M1KH040iOHlCfFeYBaYR0WrJ2E+mayYE=;
	h=From:To:Cc:Subject:Date:From;
	b=Gty0/gO0efdIOfplME1yfrZW31GrUlB5KZSoZISKdNQ2M/50JhCoM9gYNSMXFvIVy
	 /TZyxvlRcYA7mgyPvRBK8iXsJVg5/55PkDMBaVJ55KqXfKmDocIwZNcJ1zEohAaRXO
	 9oDi1OucqjOqgK0S2H1stzeTWny5jofy7jp7GQ9CZSLLhadSWWVfEvn4VNvT9oeoRa
	 mC3IK/PdDVPfVovc9k1xL/A2j8j+e6OkIttqh0N8DE73e/DIT4wOYIss4e5C4kGJU0
	 EHlSFHoJXyoCl2gLHjIbUIJcrcYr1/OTVf1La2wl5E1Ef2B3H9WhEGhYLQFDb7XKrW
	 zjNDwYa+oEO+Q==
Received: from localhost (unknown [IPv6:2600:4040:50b7:b604:da10:58b0:4f02:7df4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 2FC7827E472;
	Mon, 21 Jul 2025 20:16:30 +0000 (UTC)
From: Erik Beck <xunil@tahomasoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Erik Beck <xunil@tahomasoft.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2 v2a]: New board support,LinkStar-H68k-1432v1 (RK3568)
Date: Mon, 21 Jul 2025 16:16:21 -0400
Message-ID: <20250721201625.233750-1-xunil@tahomasoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

** Resending with proper patch sequence numbers **
-- version 2a
-- Apologies 

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



