Return-Path: <linux-kernel+bounces-727853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19188B020A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5984A66A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8968F2ED142;
	Fri, 11 Jul 2025 15:42:24 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CC2EAB81;
	Fri, 11 Jul 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248544; cv=none; b=CHMDsxAqoKp4+AvvXx1TDg+nVT+UiK//3FMGzDD1JtRYw7aS84NctcYFnqHp5cjK55UJPrsWESYw3ZjchAC+EvD6Wfzq9i0709Vu0hdFTDofim2BxbDDZcdx6gOEf2/m+ke2UYHaTqrfW5kt5SUxlP3YBjadStFjL+IKhE+0Mc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248544; c=relaxed/simple;
	bh=nycwG7GIvMQIk9kBYwsfurRzpNNcp7d6kK9wqfNCeOI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsQprpbXka1bOdMbsylhT6JfP+3Q/hOj7XQl2+QR2pPE3xBt1TsWEVmZocNoI1bq1e/Th9stOhBaK8HiGa3rK1UWBS0pWZAT1z3Z2RXADLJZafCtOASnUi+d5hbRqca5QqOEIFs0diNXLK4oFN1MWSJSaM7ONNtei6xT2Cp72UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdwqT1jQ0z6L56x;
	Fri, 11 Jul 2025 23:39:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A774D140279;
	Fri, 11 Jul 2025 23:42:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 17:42:18 +0200
Date: Fri, 11 Jul 2025 16:42:17 +0100
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
Subject: Re: [PATCH v6 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Message-ID: <20250711164217.00006ea7@huawei.com>
In-Reply-To: <20250711071404.2138816-3-fj2767dz@fujitsu.com>
References: <20250711071404.2138816-1-fj2767dz@fujitsu.com>
	<20250711071404.2138816-3-fj2767dz@fujitsu.com>
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

On Fri, 11 Jul 2025 16:13:40 +0900
Koichi Okuno <fj2767dz@fujitsu.com> wrote:

> This adds two new dynamic PMUs to the Perf Events framework to program
> and control the Uncore PCI PMUs in Fujitsu chips.
> 
> These drivers were created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> These drivers export formatting and event information to sysfs so they can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e pci_iod0_pci0/ea-pci/ ls
> perf stat -e pci_iod0_pci0/event=0x80/ ls
> 
> FUJITSU-MONAKA PMU Events Specification v1.1 URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
Hi.

As much comments would be much the same as on patch 1
I'll wait for v7 to take another look at this one.

In general both are really clean drivers so just minor stuff
to work on for v7.

Thanks,

Jonathan


