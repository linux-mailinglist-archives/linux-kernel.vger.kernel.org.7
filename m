Return-Path: <linux-kernel+bounces-770909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E183B2804F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F367567363
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA6F3019C5;
	Fri, 15 Aug 2025 13:02:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D99DDAB;
	Fri, 15 Aug 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262929; cv=none; b=HN/rukJlHLVaH1Fs13vwWB+C26B+cCh7t6m/q0sy0De11VCqK/1uT2SbkZOsmuFd6SgVbBsGOTm3+5vSqGKCU4LDVqWOkTkcwD/p8S6Vns80dlTg+M43p+xrMtUEHovtrc/UD4fFhCfUCaeeLjheW9ABEzMTKPbVVhOJ4auP79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262929; c=relaxed/simple;
	bh=7oJi1kiVoqD18WX1ltF3JE4FFuv8iY+yTb0nDaJeqvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E6WDh40n+/5/Ojuc35Yd051IHOUtSro1JHKXhF9k0QtV/o2M3ro8T78VMM5jXlU4uFYcIOmdMoSRoEBMKIE7HEdt59E/KjyxWUFb+bsNjjF0JPkObUe6t+6kzDLKBAab9P+UUUuQ9NJx/VzmFUr0cQo3J6JhNEbmseb87QtorNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853EE1691;
	Fri, 15 Aug 2025 06:01:58 -0700 (PDT)
Received: from [10.57.1.201] (unknown [10.57.1.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E7183F5A1;
	Fri, 15 Aug 2025 06:00:11 -0700 (PDT)
Message-ID: <995e093f-7b6c-4701-87af-2f4d21b08ada@arm.com>
Date: Fri, 15 Aug 2025 13:59:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
To: Koichi Okuno <fj2767dz@fujitsu.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Gowthami Thiagarajan <gthiagarajan@marvell.com>,
 Linu Cherian <lcherian@marvell.com>, linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
 <20250815034751.3726963-3-fj2767dz@fujitsu.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250815034751.3726963-3-fj2767dz@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-15 4:47 am, Koichi Okuno wrote:
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
> ---
>   .../admin-guide/perf/fujitsu_pci_pmu.rst      |  50 ++
>   Documentation/admin-guide/perf/index.rst      |   1 +
>   drivers/perf/Kconfig                          |   9 +
>   drivers/perf/Makefile                         |   1 +
>   drivers/perf/fujitsu_pci_pmu.c                | 536 ++++++++++++++++++

 From a quick side-by-side skim, this is a copy-paste of the exact same 
driver from patch #1 with s/mac/pci/g applied. Please don't do that. If 
the hardware is functionally the same, then it should just be a single 
driver that can then pick which PMU name and set of event alias 
attributes to use for a given instance based on the ACPI HID match 
(and/or any other ID register info you may have.)

Thanks,
Robin.

