Return-Path: <linux-kernel+bounces-878150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B81BC1FE47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0D334E9223
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173F342170;
	Thu, 30 Oct 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="gPnL0vVa"
Received: from mail-m49244.qiye.163.com (mail-m49244.qiye.163.com [45.254.49.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9546341674;
	Thu, 30 Oct 2025 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825337; cv=none; b=sIrJD7BX1LjdESNFb+JZuRJpqeKzFnP3m7PVabTXKqgTeQbgdd6c4/JGx5fdKNamfsaBW07CsaRPan0NdCr5uL0Sr1r+t1EniJ1YfLXNDxfOM8t16BwU81Vs1e4XbsmaycDLjSco2StZ4j8TnCUBgxqqOwXBLjobirgUdZt9ML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825337; c=relaxed/simple;
	bh=faQlt4wzpzeq/vBlzcvlciv94cb4w4oobEarKxLngy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UixZqqj1UpknDQz90gJ+ibSngUAHlNbH/DAT80wQLlMk40XGtOXj64UY8KyPt75vOMq0wq8t06F/ZlfNqo0PWFbYt0bP0qN7rAZwKAYUyFZy8NmD5t31W6WeguODgCiNxcU5i8Jy5QgC/cwPyxQ9LpNQ1fVMb0xXOFHFFVWqLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=gPnL0vVa; arc=none smtp.client-ip=45.254.49.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27c991459;
	Thu, 30 Oct 2025 19:40:09 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	krzk+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	bst-upstream@bstai.top,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org
Subject: Re: [PATCH v5 0/6] arm64: introduce Black Sesame Technologies C1200 SoC and CDCU1.0 board
Date: Thu, 30 Oct 2025 19:40:07 +0800
Message-ID: <20251030114007.302401-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
References: <20251016120558.2390960-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a34eb076a09cckunmfa5af3e9529ec2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh1LVh9OSUxIQk8dTBhJSFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gPnL0vVagk/5UFB+p/JNDJiKvhJ1wzpnY2+li5CQGpu3IxOchi4ILmP6HFrfxtGcPUFVGo5jn+Yw1c8MBi91Eu9I58aflsvqzcGqDubg4L/XHPJDr0ScMhhjnrXt9mzgaS04BHNzH9DYufY2VDhci19hGulxYzMkSuhHlTu0SDo=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=faQlt4wzpzeq/vBlzcvlciv94cb4w4oobEarKxLngy4=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

Gentle ping on this series. It's been two weeks since v5 was posted.

This version addresses the DTS coding style and property ordering issues
from our previous discussion [1]. Following Arnd's suggestion [2], the MMC
patches have been removed and will be submitted separately.

Patch 2/6 (arm bindings) already has your Reviewed-by. The remaining
patches (Kconfig, DTS, defconfig, and MAINTAINERS) are ready for review
when you have time.

Series: https://lore.kernel.org/lkml/20251016120558.2390960-1-yangzh0906@thundersoft.com/

[1] https://lore.kernel.org/lkml/179f19c0-d9fc-4efb-bc78-8dc1e7505b13@kernel.org/
[2] https://lore.kernel.org/lkml/09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com/

Thanks,
Albert


