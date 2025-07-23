Return-Path: <linux-kernel+bounces-742630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91415B0F487
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B91890D87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA852E889F;
	Wed, 23 Jul 2025 13:50:30 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0102E7F06;
	Wed, 23 Jul 2025 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278630; cv=none; b=pQzKUFmm4b4RL6gZGe99HumpcC9WYJbvEqssVSMZ7Z5mN3ybfKs6ITNaj46pozrsyhRuSTsmHvQq5G5ihQV3L0nSeInbMVJ32A2YbwBAuZCy1mcsiOYosrbtS0Q1Jr6/PhEpxwL9FznfwdYLBq1PsEpDS98HhfGCKwbsH7pnlAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278630; c=relaxed/simple;
	bh=gpkcWz41TZmE9YdgRfbzuo/4iOQyH/lamzn9EHQO3j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/qTTM91zZRtIM+GQTzvwKQ2Pu7bRhXrEXBw0aVEeuRNBvbDoz+eUqLTPPgdhVHNj0ygUntygb/CBMdDHJeBqY+jb5K5SDTNetr/ND32C+P8OKHxbqREw5O3UgChztTsqPbFVca+4Q0pX8Hc/NjMZHOjwURASchwd5qbh4dB0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d02843b4;
	Wed, 23 Jul 2025 21:50:16 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: xunil@tahomasoft.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/2 v2a]: New board support,LinkStar-H68k-1432v1 (RK3568)
Date: Wed, 23 Jul 2025 21:50:08 +0800
Message-Id: <20250723135008.1077970-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721201714.233962-1-xunil@tahomasoft.com>
References: <20250721201714.233962-1-xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUwYVhhCHksdTkxKGkweTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
X-HM-Tid: 0a98378c927103a2kunm1bf04eacfc331
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6Mzo*NTEYPjIBDT42GjIN
	L0oKCQJVSlVKTE5ISUxDTUpMS0xNVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFKSEJKNwY+

Hi,

> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-linkstar-h68k-1432v1.dts
> @@ -0,0 +1,740 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2022 AmadeusGhost <amadeus@jmu.edu.cn>

Please do not add my copyright.
I don't know if your board is the same as my HINLINK H68K board.

> +        model = "Seeed LinkStar H68K-1432V1 (RK3568) DDR4 Board";
> +        compatible = "seeed,rk3568-linkstar-h68k-1432v1", "rockchip,rk3568";

Seeed is the name of the agent, not the actual manufacturer.
LinkStar is an alias given by HINLINK. Their versions and names
are quite confusing, like 1432V1 here.

--
2.25.1



