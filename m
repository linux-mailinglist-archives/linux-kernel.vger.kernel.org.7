Return-Path: <linux-kernel+bounces-731992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33330B060AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAB5071C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409B1F473C;
	Tue, 15 Jul 2025 14:01:37 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC91D7E5B;
	Tue, 15 Jul 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588097; cv=none; b=lAtISxj4G49rHGJy18CHqES1u4PgrknekDx+K26lMK4mqLDXcMM4mbBDgORo9Kru5F9h/v0Gx3Eoqj9PnnfOzaCRi+by5/kuqtTO9iT7yslf0wNOQny2638VN5ieFNAVPqNrp36xSmiWUMlGxyRvluTML/6KD+Uo+qbpDeORCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588097; c=relaxed/simple;
	bh=UaT/5tbfotpns3fiZwVdxou9arFCEkj/zQROG99z+K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=taxSjI5en5F4O6sQkKGPcDKoAJCD8AwzXZqAcx5f5t65oAqvPIWuljPJ2/25GyOmEh81gXPtQoMZ/9jPiXrAno0Nc5/V5JWsA0vfhb0idaUUFT2n2oEsx5paXvRJiJliN/VO2L5pQiBfBO9llW+W03WLxhqFqz6Mb84mXJ1mdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c1690188;
	Tue, 15 Jul 2025 22:01:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v3 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
Date: Tue, 15 Jul 2025 22:01:15 +0800
Message-Id: <20250715140115.1925358-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712173805.584586-5-jonas@kwiboo.se>
References: <20250712173805.584586-5-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSh5PVk5MH0JLSk0YTkwaGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++
X-HM-Tid: 0a980e63dc5103a2kunm929f6807810238
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PUk6Myo*LTExNwpKIS8xQjhJ
	TR4KCQ9VSlVKTE5JTkNDS0NISktOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFCSkI3Bg++

Hi,

> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
> ...
> +&sdio0 {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cap-sdio-irq;
> +	disable-wp;

I don't think sdio needs disable-wp?

Thanks,
Chukun

--
2.25.1


