Return-Path: <linux-kernel+bounces-770815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA846B27F45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D821BC60E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E62882AB;
	Fri, 15 Aug 2025 11:36:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A36286417;
	Fri, 15 Aug 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257783; cv=none; b=G8k4FEUWYedkJ3uUHhH0XrsfYMbRSr9230+uaBJuTqxuGfDu9fBSpVTeydKUgv0kgMmE77Bw5Ywq3DVGd84SFRdDQhx3tvBLUI6zGluEOQE7PrdjtmalRcQPM3SV/oPrHxYZ6ObcHeimyeCfIjvolOROjzZno/Y0db44LhvMuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257783; c=relaxed/simple;
	bh=fuApAH/qgme9GXwAIdBQj2g1z/p0LHPw89a3xgmfeIg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gv+0BVUd1AQGbnm6M0cg0ZQkAarPDsXLW6IoQF5xRDNLN+eMDDNv418nOqzT7+9pS+2DPea+mumDB2jK7Gji82UOkN6eOS+y07sZ7s6zJdjZPV2a5VgygCvr3C3nwEcP0SV4OKPJNoQMdC3eYSlHJgBeQN512poKZJUBMCrlYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3Kkz03THz6M4tN;
	Fri, 15 Aug 2025 19:34:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AAF7714010C;
	Fri, 15 Aug 2025 19:36:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 13:36:18 +0200
Date: Fri, 15 Aug 2025 12:36:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Koichi Okuno <fj2767dz@fujitsu.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>, Linu Cherian
	<lcherian@marvell.com>, Robin Murphy <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "=?ISO-8859-1?Q?N=EDcolas?= \"F. R. A. Prado\""
	<nfraprado@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Message-ID: <20250815123617.0000716c@huawei.com>
In-Reply-To: <20250815034751.3726963-3-fj2767dz@fujitsu.com>
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
	<20250815034751.3726963-3-fj2767dz@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Aug 2025 12:47:29 +0900
Koichi Okuno <fj2767dz@fujitsu.com> wrote:

> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore PCI PMUs in Fujitsu chips.
> 
> This driver was created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e pci_iod0_pci0/ea-pci/ ls
> perf stat -e pci_iod0_pci0/event=0x80/ ls
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
Hi,

Just the same question on irq affinity as in previous patch.
So likewise if resolved

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



