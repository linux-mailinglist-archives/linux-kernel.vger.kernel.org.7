Return-Path: <linux-kernel+bounces-730094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19620B04021
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0D716F571
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A701246767;
	Mon, 14 Jul 2025 13:32:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3023A9BB;
	Mon, 14 Jul 2025 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499959; cv=none; b=bCV3tLh/bHoBKeJmrOGAZHUm4rdXvocJC39yhe31cX1oKwUtpX3kjhgmIfljaeHOfn+X64rEAhBkuiym1AFWzThQn4uKBmvRQ0KqFVtK7pIRi3uvfU0Z0OGrOVugO60VM4d7ETkq9FWqIpoU39F4It5TxYyvpNUiFedV7Zgbj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499959; c=relaxed/simple;
	bh=PXDSULkkQgVIkCgKNzc093ry27izYIHUAhEMiwDWd6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGHXY0TMNuSgM/pOwB3livEs0dw6tB5k92YdT2Lgii4CEPoSid7Cw0mT6DhApPyjxpK+TJBQIKwbtITAGQ5kK7vurX3SmudSD9kOgPUKN3GexfL1fM85FsSVRAQWkEzXkWww2LlfOvaFcRB0YOaF4EwCMRG5FjkG2U2hx7br+rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0551A1BC0;
	Mon, 14 Jul 2025 06:32:27 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE4A93F66E;
	Mon, 14 Jul 2025 06:32:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:32:31 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Koichi Okuno (Fujitsu)" <fj2767dz@fujitsu.com>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
Message-ID: <aHUG78Vv1QU5Aafj@J2N7QTR9R3>
References: <20250617102819.3685543-1-fj2767dz@fujitsu.com>
 <20250617102819.3685543-3-fj2767dz@fujitsu.com>
 <20250617103618.GT1613376@noisy.programming.kicks-ass.net>
 <TYCPR01MB67177BF90FEBAB9E20463012C141A@TYCPR01MB6717.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB67177BF90FEBAB9E20463012C141A@TYCPR01MB6717.jpnprd01.prod.outlook.com>

On Tue, Jul 01, 2025 at 06:13:57AM +0000, Koichi Okuno (Fujitsu) wrote:
> Hi, Peter
> 
> Sorry for the late reply.
> 
> > On Tue, Jun 17, 2025 at 07:27:50PM +0900, Koichi Okuno wrote:
> > > +	pcipmu->pmu = (struct pmu) {
> > > +		.parent		= dev,
> > > +		.task_ctx_nr	= perf_invalid_context,
> > > +
> > > +		.pmu_enable	= fujitsu_pci__pmu_enable,
> > > +		.pmu_disable	= fujitsu_pci__pmu_disable,
> > > +		.event_init	= fujitsu_pci__event_init,
> > > +		.add		= fujitsu_pci__event_add,
> > > +		.del		= fujitsu_pci__event_del,
> > > +		.start		= fujitsu_pci__event_start,
> > > +		.stop		= fujitsu_pci__event_stop,
> > > +		.read		= fujitsu_pci__event_read,
> > > +
> > > > +		.attr_groups	= fujitsu_pci_pmu_attr_grps,
> > > +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> > 
> > Should these drivers not also have PERF_PMU_CAP_NO_INTERRUPT ? Per them
> > being uncore they cannot generate samples.
> 
> Even now, the fujitsu_pci__event_init() function rejects sampling events
> before checking PERF_PMU_CAP_NO_INTERRUPT in core.c.
> However, I think it is correct to have PERF_PMU_CAP_NO_INTERRUPT which
> means not being able to sample, so I will add NO_INTERRUPT in the next
> version.

Sorry to give contradictory feeback, but given that the majority of PMU
drivers under drivers/perf/ don't set PERF_PMU_CAP_NO_INTERRUPT, and
explicitly reject sampling events, I'd prefer to do the same for
consistency.

Peter, are you happy with that for now?

Overall it would be better for PMUs to export a positive "I support
sampling" flag, and maybe rename/replace PERF_PMU_CAP_NO_INTERRUPT
accordingly, which I'd be happy to look at in future.

Mark.

