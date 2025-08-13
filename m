Return-Path: <linux-kernel+bounces-766605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5FB248E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0246F627167
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042F2FABE0;
	Wed, 13 Aug 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="Imlp1NHF"
Received: from mail-m19731108.qiye.163.com (mail-m19731108.qiye.163.com [220.197.31.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832642F83A4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086188; cv=none; b=HOt/gjLOKfc3/fBANEVQTXZtDZQ0NJuqS8y4lCL5cXpKuLewZpLe+9748b9wnx87k+BZoXWYC4tF7Hhp2O54eLMWCJ6glau+6YrF/Glv5XxnN0BQr9AEKeirV7B3MPIKiyEs55CYf1jAg1lB2ok7YH7s/7mQGWK6hEDogXYC44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086188; c=relaxed/simple;
	bh=f1cRAJe0CxUVqAqDKj9DnA6hGyWzBbsykTcnAehrRdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0G7FvInTCYQYWkwFUWGUvhTUkLf6RQgj8t98Ejn4Kx0SV7XlR+Fd9dtMw16xLoQdGECLoyvAzH5aLX9oU99GJJBPuJ7EWPnvovfY5WZ9dcmOmYhfT+z/i/3Mri76YSupxtYKnK3kqDGFJgMpdCs++MMI6toAAaDR8Vjt63ZDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=Imlp1NHF; arc=none smtp.client-ip=220.197.31.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f43d5da5;
	Wed, 13 Aug 2025 19:56:21 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: will@kernel.org,
	adrian.hunter@intel.com,
	catalin.marinas@arm.com,
	arnd@arndb.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] arm64: defconfig: enable BST platform and SDHCI controller support
Date: Wed, 13 Aug 2025 19:56:21 +0800
Message-ID: <20250813115621.2396944-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3dc96186-a314-477b-8d2a-a2ffcb2e482c@kernel.org>
References: <3dc96186-a314-477b-8d2a-a2ffcb2e482c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98a349d4ec09cckunm0b9ac1c0a1693c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQx0fVkIZHhpJGU8dS0sYGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Imlp1NHFgbTmnv0P8tYVBoDQMYGg53wt9sfi+MKW6znw3nE0bujbDsf3HceS9/Xcdnl7rCOqBQBM/Im0zW/FpNgdyQaVOc6K3fs6rknxRKV9CNzz7euOwUWWkidtgXbMiee/iUHNX7O7J5u/VECDLrQXa+rAtC4/QoCE6CtVPBA=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=f1cRAJe0CxUVqAqDKj9DnA6hGyWzBbsykTcnAehrRdI=;
	h=date:mime-version:subject:message-id:from;

On Tue, Aug 12, 2025 at 03:38:08PM +0200, Krzysztof Kozlowski wrote:
> On 12/08/2025 14:31, Albert Yang wrote:
> >
> > - CONFIG_ARCH_BST: Enable BST SoC platform support
> > - CONFIG_MMC_SDHCI_BST: Enable BST C1200 DWCMSHC SDHCI controller driver
>
> Either this paragraph...
>
> >
> > This enables eMMC/SD card access on Black Sesame Technologies C1200 series
> > SoCs. The SDHCI driver provides hardware-specific implementation for the
> > Synopsys DesignWare Mobile Storage Host Controller integrated in BST SoCs.
>
> Or this. Don't say twice the same. Second paragraph is more relevant, so:
> "Enable BST SoC and MMC drivers for BST 1200 board".
>
>
Thank you for your review. I will refine the commit messages based on your
suggestions.

Best regards,
Albert

