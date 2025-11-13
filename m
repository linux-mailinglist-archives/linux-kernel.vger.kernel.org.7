Return-Path: <linux-kernel+bounces-899368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961BC57848
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026644E2863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9C350A12;
	Thu, 13 Nov 2025 13:00:43 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEF2C21E8;
	Thu, 13 Nov 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038843; cv=none; b=hl9O5Ez1FPt+CRngnK/2WNe6Yaaawm06Ba5QnwzCXcCro2hou16ShrS8fyKYkVB0+V9paWgfVteGF2cIziRLsKXb2RwvCssrW4p4EwHaHT7DEDk9uXeQYkuUxLPShTghq7vmbMLyvgygogX2pVgw5B4T/OfwCdx+qHFtV25CVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038843; c=relaxed/simple;
	bh=5/jeS8R2INGgMyMRHYo8PH31xZ8F+hej1l6sBG6zsic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XgtcqeNiEOpJkJxXS4Jvg6HGa4bdsArH1wb3sUsl3uNYO9GzlUsNIPSlF3ucBmJGwi0AxfEsC9XoN2CMd9LNIL+gUHcFA7nXx+Viz+3xQRamKziRnaXVaD9fTRsTFr2f/7vsFmIihITB5S1w9wimwo2lYZGI99Pc4xsjD7yH8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [58.61.140.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 297bea02c;
	Thu, 13 Nov 2025 21:00:35 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: coiaprant@gmail.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: rockchip: Add devicetree for the 9Tripod X3568 v4
Date: Thu, 13 Nov 2025 21:00:21 +0800
Message-Id: <20251113130021.822765-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6F2972A5-047F-48A5-B409-C3F3E71643AD@gmail.com>
References: <6F2972A5-047F-48A5-B409-C3F3E71643AD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7d4db1a103a2kunmc0f785fd12ff7c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQx9JVhpDGk5CQ0lPTEMeGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VNSlVKT0tVSkhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCTUtKVUpLS1VLWQ
	Y+

Hi,

> PCIe and MIC picked from OEM source codes.

I know it comes from BSP code, but it's not correct.
A PCIe 3.3V power supply will not have a 0.1V situation.
Rockchip fixed this in their kernel a long time ago:
https://github.com/rockchip-linux/kernel/commit/17e9559f67d26f3c602e38a24feb5194e51ac782

> Since parts of the OEM source code are not available in mainline,
> I refer to other boards (e.g. RK3568-EVB or RK3568-ROC-PC), but
> I don't have a camera or screen to test, so I mark them as demo.

These things may have been brought by rk3568-evbxxx.dtsi, and may
not actually exist.

