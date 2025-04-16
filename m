Return-Path: <linux-kernel+bounces-605333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC46AA89FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 15:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A1441EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488A1A2C25;
	Tue, 15 Apr 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9CZwbmD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6416E863;
	Tue, 15 Apr 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724713; cv=none; b=PhBYXyOcmANaxn/M4NLZxMIBKpFw8vlO4B84FVegoM9SwdwlL4t2Tcr9+B2DoD0tKYQHBCSHBDbX7Qp6KX0kRTyf2SXRamtjijTiaswWuLERakSkXKVcNG13TmoKz/jMX1oX7YQE0rdX6e3pNKKra1Sl4Kyd31FNHFSqAdsmDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724713; c=relaxed/simple;
	bh=TPZdExM3KafRJttqPPd/bRsyPyzt9BIDEpMQPj9a+Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKKZUNKiXxrlZtaBtdRIYyd0aVI6xDzf/i0Rl5cgWHxQtMIv2gDeUTbos1IC+nACavr9Ptu0LhkqmO2+2yjwDYI8Wm6xI1DaOkfUZUJgB9r7j+36Lll4RxlCSDKCNHDXc0/RDsajaItTd0cHoxAjYWuAf5fMTqGPbx/E0wm1xq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S9CZwbmD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hAjtOYs2LsurpP/XvgiffQ7gjY9Es3VWzBLYejR8ECE=; b=S9CZwbmDyV9BV3HQInlqKCWyaz
	H4A30Cy1Ku/C0Zjh4nr7JFVaCPaWCYbnpzu2aeO5utnGOkL2bQCig66yQV6U64ftZ/vJIi1adcZjK
	8KYCVQFNhBY53jKP+xSq1xQVBN0uhDWaTiskbnGrzfkAdeF9BEKO0qLG0+6IGgQIuy3CP/T4X5qLz
	RrZbLaqYL+5N6NmUi1bipbJ0RugGfEPVVi96iYsTnai7CNJwrLVgiJ2mMltdZqfIzaSg0WhHktWZB
	so41qFC11dLJdzNbSLX33v1rilukrmx0FW8u3/r5hSZUVOUYHrlvoBlP83PdeKzMgFzQFR8E6IEFC
	HAHuy6LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4gb1-00000009tti-3s4c;
	Tue, 15 Apr 2025 13:45:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 799BC30037D; Tue, 15 Apr 2025 15:45:03 +0200 (CEST)
Date: Tue, 15 Apr 2025 15:45:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 11/22] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250415134503.GA4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-12-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-12-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:17AM +0000, Dapeng Mi wrote:
> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);

You were going to make this go away :-)

