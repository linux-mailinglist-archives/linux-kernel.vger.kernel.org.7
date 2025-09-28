Return-Path: <linux-kernel+bounces-835283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E3ABA6A24
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C22317F849
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167C522D78A;
	Sun, 28 Sep 2025 07:35:46 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6A824BD;
	Sun, 28 Sep 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759044945; cv=none; b=fW9qRFTGGITdSgPOJcsm9OqPiJivkp4JRTVxBke5CnW4G7F8ir7sX14QwquTmgA7wnpnzBMzPWLgTkZC865wquPiUuQa3sDoWyVAAIXXEqJ+MZdq9+GsHDXvwoY6fxGN4cYq8C6rlpN9+nyAGYXx8vXJXvWp7srQZvBtYYv/aCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759044945; c=relaxed/simple;
	bh=IY2AM7lW9609eu5wCP0vjZkmvDxxpLcxxBG8dpZSjRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyCTR1BrCVCENDhsMT2VBMR0EEmRt29Tr9aUSEDZAYa7K6ebrMmUHAeI9Z0RYdqLggPjJMJuMU+SwfbqjER2rA95JkGiG57VD0yYbJ8tntx0nftZjpVshxdk4SJbGK8zyqrbVFZiE/+1XMlSXf/ErWF9MnhuZ+iex50+PPid2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [116.25.94.74])
	by smtp.qiye.163.com (Hmail) with ESMTP id 24516f395;
	Sun, 28 Sep 2025 15:00:12 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: heiko@sntech.de
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	naoki@radxa.com,
	robh@kernel.org
Subject: Re: [PATCH v3 1/3] arm64: dts: rockchip: disable display subsystem for Radxa E52C
Date: Sun, 28 Sep 2025 15:00:08 +0800
Message-Id: <20250928070008.74952-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <10594621.0AQdONaE2F@diego>
References: <10594621.0AQdONaE2F@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a998f1f3aa003a2kunm5258a7bd3278d3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHUkaVhhKTUodT04eQx1MSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSk1VSU5VQk9VTE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

Hi,

> I'm torn on the approach vs. just removing the error line in the driver.
>
> Returning -ENODEV from rockchip_drm_platform_of_probe() is correct,
> but the error log could just be a debug one instead.
>
> Because running a system without active vops is obviously fine.

We have disabled the display subsystem in the device tree for some
rk3328/rk3568 SBC. Not sure if drm allows silencing this log, I'll
try to send a patch.

Thanks,
Chukun

