Return-Path: <linux-kernel+bounces-771139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6DB28350
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004963A8225
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C30F3090E7;
	Fri, 15 Aug 2025 15:51:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB27308F2B;
	Fri, 15 Aug 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273117; cv=none; b=aAnxortwN/55b3F2vygOkBZDQVLGkLtGojb/WS0Sx9YcMqJ0Qu996P3R0mE0+Qy8rYB1SyRy91HCBptvjjNT4upinDyYMRCAwEbCpNOW3HvxK1upbkUWeg7t+oE3+1P+l89tFeBJ2oF1E5A8bMCsAierRAjeAcO33cJX440WviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273117; c=relaxed/simple;
	bh=0bO6C3bPDqcBN0lGRqXIhg8z/Rx87SNP9KLtOI9K9QE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDHQYgtwgrAn/FPVAf/z7YxqQPEv4ljFrXG+qBUv/a+OFEYNlGnJkxWohL/224ZtBU2E0XBU6uIhOJnuEl7IMnUDfwhSLwedQr1BuwIBAV3NJ9/Ue2zPeEbjlMM9gFM5whU+PQzuMEamGNZGtQz624byP+U2rbztv6sBkjIuEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c3RNw16jZz6L5R0;
	Fri, 15 Aug 2025 23:49:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B3A4C1400CA;
	Fri, 15 Aug 2025 23:51:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 15 Aug
 2025 17:51:50 +0200
Date: Fri, 15 Aug 2025 16:51:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Koichi Okuno <fj2767dz@fujitsu.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin
 Marinas <catalin.marinas@arm.com>, Gowthami Thiagarajan
	<gthiagarajan@marvell.com>, Linu Cherian <lcherian@marvell.com>,
	<linux-arm-kernel@lists.infradead.org>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio
	<konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Arnd
 Bergmann" <arnd@arndb.de>, "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado"
	<nfraprado@collabora.com>, Thomas Gleixner <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
Message-ID: <20250815165149.00004d60@huawei.com>
In-Reply-To: <ea3fda8c-2b7d-4902-9bda-d97d7b090cff@arm.com>
References: <20250815034751.3726963-1-fj2767dz@fujitsu.com>
	<20250815034751.3726963-2-fj2767dz@fujitsu.com>
	<ea3fda8c-2b7d-4902-9bda-d97d7b090cff@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)


> > +static struct attribute *fujitsu_mac_pmu_events[] = {
> > +	MAC_EVENT_ATTR(cycles, MAC_EVENT_CYCLES),
> > +	MAC_EVENT_ATTR(read-count, MAC_EVENT_READ_COUNT),
> > +	MAC_EVENT_ATTR(read-count-request, MAC_EVENT_READ_COUNT_REQUEST),
> > +	MAC_EVENT_ATTR(read-count-return, MAC_EVENT_READ_COUNT_RETURN),
> > +	MAC_EVENT_ATTR(read-count-request-pftgt, MAC_EVENT_READ_COUNT_REQUEST_PFTGT),
> > +	MAC_EVENT_ATTR(read-count-request-normal, MAC_EVENT_READ_COUNT_REQUEST_NORMAL),
> > +	MAC_EVENT_ATTR(read-count-return-pftgt-hit, MAC_EVENT_READ_COUNT_RETURN_PFTGT_HIT),
> > +	MAC_EVENT_ATTR(read-count-return-pftgt-miss, MAC_EVENT_READ_COUNT_RETURN_PFTGT_MISS),
> > +	MAC_EVENT_ATTR(read-wait, MAC_EVENT_READ_WAIT),
> > +	MAC_EVENT_ATTR(write-count, MAC_EVENT_WRITE_COUNT),
> > +	MAC_EVENT_ATTR(write-count-write, MAC_EVENT_WRITE_COUNT_WRITE),
> > +	MAC_EVENT_ATTR(write-count-pwrite, MAC_EVENT_WRITE_COUNT_PWRITE),
> > +	MAC_EVENT_ATTR(memory-read-count, MAC_EVENT_MEMORY_READ_COUNT),
> > +	MAC_EVENT_ATTR(memory-write-count, MAC_EVENT_MEMORY_WRITE_COUNT),
> > +	MAC_EVENT_ATTR(memory-pwrite-count, MAC_EVENT_MEMORY_PWRITE_COUNT),
> > +	MAC_EVENT_ATTR(ea-mac, MAC_EVENT_EA_MAC),
> > +	MAC_EVENT_ATTR(ea-memory, MAC_EVENT_EA_MEMORY),
> > +	MAC_EVENT_ATTR(ea-memory-mac-write, MAC_EVENT_EA_MEMORY_MAC_WRITE),
> > +	MAC_EVENT_ATTR(ea-ha, MAC_EVENT_EA_HA),  
> I firmly maintain my opinion that if this is the only place the event 
> numbers are referenced then the extra layer of macros actually makes it 
> *harder* to read and follow, compared to simply:
> 
> 	MAC_EVENT_ATTR(ea-ha, 0xa0),
> 
> but that is very much just one reviewer's personal opinion :)

I'll second this suggestion!  I failed to notice they were only used here.

Jonathan

