Return-Path: <linux-kernel+bounces-802180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00FB44E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CC91C27AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763A22DA774;
	Fri,  5 Sep 2025 07:00:23 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790302D4801;
	Fri,  5 Sep 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055623; cv=none; b=gav1AeCQpUE3xU0H6hkFM/8MpLqgtWtZYBYbVm1Ay/R45t1gc3rvj/rRWle7rOLk/YquN5OE189wwVMEfSZgqGgdojWAWLvSczYEJCOxw3DJrKK5OTrGp4ZW2tJB7eNPxExJ+dL03XIrQ5v1ow35T8ZUuzmPDBujZ7tGMIvZ3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055623; c=relaxed/simple;
	bh=qLXprBz6iQnI31xsjzwP1BEli1UTHMA3TxupZiC7/KU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUqWAvQjsFQQMBfUVZ+dIVwuVLuvEX2KeNI4vJB7GJPuSFB58a3H2wM/wCWtzqm7FOj5XKtdo4EuXeMWlhs3UB96OrO1I/K4bksuYscgfIlQt4Z5ZGAcX7Ej90gsbWfUPtl+bUURVGMFGauXq617lTRBbvVaqBDt7PXyxn9BuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.41])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21cc66823;
	Fri, 5 Sep 2025 15:00:08 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: amadeus@jmu.edu.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH v3 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Fri,  5 Sep 2025 15:00:02 +0800
Message-Id: <20250905070002.320775-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250801080025.558935-2-amadeus@jmu.edu.cn>
References: <20250801080025.558935-2-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9918ace5d103a2kunm6ede5b84233df5
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS05LVk5PGE8fQ09ITUJIT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVPSllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG

Hi,

> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
> voltage mapping to the device tree to enable dynamic scaling via cpufreq.
>
> The OPP values come from downstream kernel[1], using a voltage close to
> the actual frequency. Frequencies below 1.2GHz have been removed due to
> the same voltage.

Are there any issues with this patch?

Thanks,
Chukun

