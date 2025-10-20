Return-Path: <linux-kernel+bounces-860570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3653BF06DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CB71889C14
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E12F6919;
	Mon, 20 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2zzLq786"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F92EC0BB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954884; cv=none; b=APAJierpMyNs9fT4fCd9krpdNlajGeNNUs0jNNCaELIpPbbujYUMUJY4/aPDyw9NQOvdjo2EP5plrSCbLsqzY1OIEUhXJGrqZV9JGVGaNxJVxMeOsYe8f62H1jq67FZUcmAJEVVQFmxNyKA7rdFniEM/qCDgykSmat216AYqY6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954884; c=relaxed/simple;
	bh=h+Sk0DH8BP2TMNyreexwYmG03jbitHQWS9SGAHETI2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pALN1FGSI8TMH5Y5HdMGMEuvOCgkRKMNbfoKLdQiEArCLhFZoGmn7gRntbVR1e4s0inyZaxF4c3y1NwEcj6aV4KAfURWyIjObryXLGWv9SfY08KEvxW3t1+Z9wipsjZfCIF8hRs8AvpT144WCNd3pgQbkYuycWDoHFAsgLOMlj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2zzLq786; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=WjROErYKhqP1tAcIgogbcXDGMXU77l41sCaQUXRHT58=; b=2zzLq786MPGYz/ygrrkx47jIO2
	hX7u7VHjOEWgnFQACkEzIvGdUPTnuh41mbdg41CpHLyP1yGjq2yHEfvckxLi+9Mt3ZiltGwUe25uf
	wQgIIGujIgoZoqWDObXFivGSEhsaAj5JAqZENtJIQzZ3P9F+BzwO7oOJgEEXI+cz5TlEZnzqYzTVA
	GAn4tddo1LsHlaF3+1EbG15Fjjbrk0R2faePJ40QDls9nVUj47zkZtM665ERs0v/fNV+RjjHES3e4
	QvDco66F+q1d02kNWhCgBNVUU4cYMdTwsuV7+/Is3gwGJNk5c4WPUz3JmtzQSNoxT2ZEuRbzoFaFt
	IH5s0muQ==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAmo3-00083f-Qb; Mon, 20 Oct 2025 12:07:59 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Move RK3368 Lion ethernet phy to a mdio subnode
Date: Mon, 20 Oct 2025 12:07:54 +0200
Message-ID: <20251020100757.3669681-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use deprecated snps properties to describe the phy reset,
but instead add the mdio bus subnode to the gmac and correctly
describe the phy there.

This will also help us later to handle a lion-specific oddity where
the phy needs to enable its clock output for the needed mac clock.


Heiko Stuebner (3):
  arm64: dts: rockchip: add gmac reset property to rk3368
  arm64: dts: rockchip: add mdio subnode to gmac on rk3368
  arm64: dts: rockchip: Correctly describe the ethernet phy on
    rk3368-lion

 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi | 22 ++++++++++++++++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi      |  8 +++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.47.2


