Return-Path: <linux-kernel+bounces-881582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED195C287EC
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D1D3A756B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F8C258CDF;
	Sat,  1 Nov 2025 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b="jDDGh7W7"
Received: from mail-108-mta236.mxroute.com (mail-108-mta236.mxroute.com [136.175.108.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F938FB9
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762031255; cv=none; b=CsbsXBwFSUD2jA+NEfWpHZ/NzA4b0xAbSNHGZydg/B5nZOlbcUP4vlOCNv6GrQOtsIMIFG4oizlvU1GYRVg+4bTa9iCuCuB0pZkftzuYIdU+msxrILPF4MOlja6fKGvyUVivXL7UzGr0AiYd+m+PSFGs18QyahsdIlNBsxozv8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762031255; c=relaxed/simple;
	bh=TWfNV6cHjoSfFmcClSN8Sf+H1+Oh9VuEExsfzR2VCoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH/ZCX/MDQtAJczcPIPh2OPH0Uak72sX4QSk3W3BHETnHm57HXQe4qI0LeqMzAqAss2QsVysb5tkk4x0GIEcFdsYXE44Q+hc7SmQk5Giwkt3XuqmaLDuVZfT0PD0aa+OaPa/W3jmLSBHgn/lTMMZ1WURx4ANmaXNciJq1dANQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol; spf=pass smtp.mailfrom=josie.lol; dkim=pass (2048-bit key) header.d=josie.lol header.i=@josie.lol header.b=jDDGh7W7; arc=none smtp.client-ip=136.175.108.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=josie.lol
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=josie.lol
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta236.mxroute.com (ZoneMTA) with ESMTPSA id 19a413a6dea000c217.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 01 Nov 2025 21:02:19 +0000
X-Zone-Loop: bc87042e6510e67eb23a868c7a16241f9e90beb851e7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=josie.lol;
	s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=TWfNV6cHjoSfFmcClSN8Sf+H1+Oh9VuEExsfzR2VCoo=; b=jDDGh7
	W7WX4GjdueniBZ09tJd9QA8D78LBo/tMa9z8Q8Kn0+HlT1+PQ2LtMbt0AChmIgZop4MiyOqkqQGPf
	Bbm3Cr70nVS+eipkdvOo7S/+qKuhn8B1Xq7pOW8mcGBtEWGFLD1dw0mvY3ytkJPbPwA/Vv0f5aBPX
	8k8qWyBos93Z06k+v4EgmsfgygqK3xvdf7ewYVraVbUmjilIqs8HjnRfCcx8gVpZaakYbL0CsOZlr
	HOwF9KMMWuAZIuP3U+ztHSv6VlVD6sL4eGCFrWT5x5/7dVZ6sgsNv5BXQGCSQF2x72UqNrAwIUIGU
	D0ApWXeYAT4repSJg76teV5DVxFQ==;
From: Josephine Pfeiffer <hi@josie.lol>
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: ptdump: use seq_puts() in pt_dump_seq_puts() macro
Date: Sat,  1 Nov 2025 22:02:01 +0100
Message-ID: <20251101210201.43210-1-hi@josie.lol>
In-Reply-To: <aQNyaoXKsMdkIDrc@willie-the-truck>
References: <20251018170416.3355249-1-hi@josie.lol> <aQNyaoXKsMdkIDrc@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: hi@josie.lol

Hi Will,

Thank you for reviewing! This is part of a 4-patch series that fixes the same issue across multiple architectures. The other three patches are:

[PATCH 2/4] ARM: ptdump: use seq_puts() in pt_dump_seq_puts() macro
https://lore.kernel.org/all/20251018170442.3355403-1-hi@josie.lol/

[PATCH 3/4] riscv: ptdump: use seq_puts() in pt_dump_seq_puts() macro
https://lore.kernel.org/all/20251018170451.3355496-1-hi@josie.lol/

[PATCH 4/4] s390: ptdump: use seq_puts() in pt_dump_seq_puts() macro
https://lore.kernel.org/all/20251018170521.3355738-1-hi@josie.lol/

Each patch was sent to the respective architecture maintainers.

Best,
Josie

