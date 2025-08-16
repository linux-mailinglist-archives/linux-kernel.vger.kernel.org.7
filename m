Return-Path: <linux-kernel+bounces-771871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D7FB28C6E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AB217AB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7592623E350;
	Sat, 16 Aug 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="EHEXEp3i"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054423F405;
	Sat, 16 Aug 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336769; cv=pass; b=S6glbreR/B42UnWjJQvG0G2HNyW6AXRVnXizkyBz+8JwBNhfGm+v6m6gpYIov5JJqen1i+idZnvNahFiTOiU7sSNRK/PnxBolF8JWvhUG1JCjApXTGuqgd6Bz2JH0oE8xXp9uGUBA9kGxNA5V2Iu+eRrEKSE5mKBpGeS3czRM0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336769; c=relaxed/simple;
	bh=CWHtEce/yr3uPOD+6AVGFAlsqZ88YZaQNGYteNv1TVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WoxaMOuyoKAJnEgh9/FrmutV1miWJjC5mIpfqrVk4JvEUNWAI4z2g273vBO6To22YGl7Vmbznrtwuaegxzr1oo2Fl7qj1YmuQQm0LpsuH/xSTwNKKL7XbxZrANbERiRJjWAy4Y/5qeXdy/3m9K02c5ZfC+WaoMlKGjoVIIsBafM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=EHEXEp3i; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755336755; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hewtz6LRweMPpZFHEAJP/tEqHn0sAQziqNoT8du7kQGY+poMzW9i2QJgIpV2zBgaPy0OueEzM4v95KGB5TJUiEsWUnw9bDS1DARYPveccY9snDfsx/WMpzIqml2VwYlG3Wsk+xvsDIWwNCgfMy9QAaTLTJDo+90ATZ7obWRkKw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755336755; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zrHlz9L+NaX+oGK/4oFn53TVd7SQqKQSMIgtqxp8PB8=; 
	b=aCHKR0CQopsc33DEi+P8FiBx0OfioCahNIPRbM11+P67UpgbStoVqhiZvX3SW3+VKTl+xGEQs3Xfk/gROMxRaiTgtpzPrWsVwV13dDCcLpxAJNi4sLguYz9hoCd4MLGuByYO36V3wGGRT5YFu/Lg96qtpZrW7eMl3R6I+vZQRjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755336754;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zrHlz9L+NaX+oGK/4oFn53TVd7SQqKQSMIgtqxp8PB8=;
	b=EHEXEp3imfuV/cD8wK8FKcjsxn90XjsEnxKMUyhJ11mdM6Yo2bZStSr2nqzWDPNR
	gZVCVJrugcjsNp4gSrLBiCx87HJOttxWozWJVKAkcO9aSjhnZWc27+bXBEww4wMFFJN
	1xY9p3aLZI9tonVXReFCFc2TjJVP/QTMMywwOKrycKFoxRoS/S7C4MTXJPPyQIsjKph
	eM+iTizC/aLKh5GVqz3eqU0mwsf22jr1yy1rJaeVXugEr9tU5SUuMnlOIWAPNPnNAop
	19bTbPfAzH0TXVO8JWU0dPoFhuNCCPLnoOxmhEudteABFrf3aToXfVRkJWSbfJ0JwIe
	3hvEJiau/g==
Received: by mx.zohomail.com with SMTPS id 1755336753451925.3420275013336;
	Sat, 16 Aug 2025 02:32:33 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 0/3] Initial thermal management for Lichee Pi 4A board
Date: Sat, 16 Aug 2025 17:32:06 +0800
Message-ID: <20250816093209.2600355-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The SoM+Dock design of Lichee Pi 4A is quite bad at dissipating heat, so
active cooling is quite important for it.

This patchset tries to do some initial active cooling for it, by
utilizing software PWM to drive the fan.

Ths 1st patch adds PVT temperature coefficients, as seen in the SoC
manual and BSP 6.6 kernel device trees.

The 2nd patch adds thermal zone information for the 2 thermal sensors in
the PVT block.

The 3rd patch adds soft PWM + PWM fan, and makes the fan an active
cooling device of the CPU thermal zone. 

Icenowy Zheng (3):
  riscv: dts: thead: th1520: add coefficients to the PVT node
  riscv: dts: thead: th1520: add initial thermal zones
  riscv: dts: thead: th1520: add soft PWM fan for Lichee Pi 4A

 .../boot/dts/thead/th1520-lichee-pi-4a.dts    | 53 +++++++++++++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi         | 29 ++++++++++
 2 files changed, 82 insertions(+)

-- 
2.50.1


