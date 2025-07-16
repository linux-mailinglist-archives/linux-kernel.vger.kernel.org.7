Return-Path: <linux-kernel+bounces-732977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AAAB06E61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221F54A584B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCA289346;
	Wed, 16 Jul 2025 07:00:43 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325653BE;
	Wed, 16 Jul 2025 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649243; cv=none; b=OwbdrNG0ipHojm/zN0YyDlyLshvoT2yuX3eiVvZmorvSXADn2CGIr8PJWUgPU9wlTHrb+WhaAyNixxee2kesdHayD1DoysQbIYdfNlE2ekSL7OdAcphYMgcnUvedafJMUwihj0uBclNR/xS11B3+q97Jz43DA+wMbJZMHeMXzQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649243; c=relaxed/simple;
	bh=uBBJOOJQAkKxqQu/HK1yEFouftDahuSZhBNcvDUyMi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTXvim86CvfhlUUI5aHQgcLG1GERP4FL9cwkfI5a692qD6qW8pXqXQaoVI5F/PHZqRcHDgV2uVo0YC3pXH3MYL9FdLaj0aty86Mhb8z8CYJaYYfhKAAsLe72n4VWwSA+lSdB+aY5wGgR0LmpsPVcIYm55aQcglh0BK3JCkuZWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c2e61632;
	Wed, 16 Jul 2025 15:00:32 +0800 (GMT+08:00)
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
Date: Wed, 16 Jul 2025 15:00:25 +0800
Message-Id: <20250716070025.236160-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9050b4fe-ce69-4f93-9093-5461a6aa052f@kwiboo.se>
References: <9050b4fe-ce69-4f93-9093-5461a6aa052f@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRhJVh0aHRlPS0lOTR5MGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVU
	tZBg++
X-HM-Tid: 0a981208f05503a2kunmaae0551a86f5ff
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N1E6TRw5CDE6Sg8tLUJLS0lJ
	ORkKCzZVSlVKTE5JTU9CSUhPT09LVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFKS09DNwY+

Hi,

> It mention 'not used in combination with eMMC or SDIO', yet I see
> multiple boards where disable-wp is currently used with eMMC and SDIO.

This seems to be a DT bug introduced from the bsp kernel.

> Do you have anything else to remark before I send a v4 with this prop
> removed?

No further questions, thanks for your work.

Thanks,
Chukun

--
2.25.1


