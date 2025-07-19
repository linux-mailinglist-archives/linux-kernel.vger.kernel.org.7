Return-Path: <linux-kernel+bounces-737782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F8B0B082
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BB1AA80C3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BAA926;
	Sat, 19 Jul 2025 14:35:31 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2C148838;
	Sat, 19 Jul 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935730; cv=none; b=RQlB6yk0zfazrHfHWybIpbVlR1lqjzsaCDKFukNssSNrRXvMPxYAYkihumFg9+bSUDITsP2Citl0zNxbctH1b5va1KbJUOi69GvlvwftbbNn8wUVVbhQ9/rzcdkNypLZEZx0yIYbM4nkel8Sfll7PXAXBGvBPntPcB1RTwEPfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935730; c=relaxed/simple;
	bh=1qXl/txmWEl/CHkCfq4k8N/fK5Ptvhrb+z6hE3Agwig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPw8mU9bGGJg4s2eXbS60Jnexw+r8M3HxbnWpGP6ts1N5Z7AwdFNcerACphUAy45OeyrM+k3n7KzKEe4gVxMqH+CAm/2/fIGjbyvU0gDXFaxCBg3P/WjSHBsP6bLsPN/gKweu5IicoXvMcHJzoQhw3rxlcSOdzLtrVE47zPU8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c936174f;
	Sat, 19 Jul 2025 22:30:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: knaerzche@gmail.com
Cc: amadeus@jmu.edu.cn,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Sat, 19 Jul 2025 22:30:08 +0800
Message-Id: <20250719143008.54288-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <104a501d-b9b2-494e-b073-932ddadd7129@gmail.com>
References: <104a501d-b9b2-494e-b073-932ddadd7129@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a982317b60e03a2kunma5e02ceb86108
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTEMaVhhIGRgaSkxDH0keSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++

Hi,

> The issue I was seeing is that there actually *is* a variant called
> 'RK3528' which at least according to the latest datasheets slightly differs
> from 'RK3528A'. We are doing development based on 'RK3528A' and calling it
> 'rockchip,rk3528' which might make it hard to add the non-A-variant in
> future (unless we call it 'rockchip,the-actual-rk3528').

I think this can be ignored, because rockchip only provides RK3528A chip.
RK3528A should be a revised version of RK3528, which solves some bugs,
so we have never seen the silk screen printed with RK3528.

Thanks,
Chukun

--
2.25.1


