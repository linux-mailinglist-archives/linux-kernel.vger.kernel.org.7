Return-Path: <linux-kernel+bounces-839882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9CBB2A49
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18CF320401
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B5298CBB;
	Thu,  2 Oct 2025 06:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UG58CB2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91641339A4;
	Thu,  2 Oct 2025 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387473; cv=none; b=o3BgUNfiZofsAm4uZAeswL70pjNpAJAS9KdWSPnCCjrzERTmQGcxkd5z5rofB460IzZE7ronHEgE6FIG/d0G+TsXxuw9qC/VddsHjptryDXAYW5GouBjfq517Krr3EKXnOALGdDtIExA0DOxiT0rRhRMMktJUJhybwZoAniNQVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387473; c=relaxed/simple;
	bh=JnBN7j5droh3H2pGNS2Yqug4bI9vWf9w2jtC9CcI0Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5zJnvTvpFDLXR2BnX0lHZRdwbYd5Kpioz5HyNslL/y2sYN8YLq5myaHiCPpgk5VlROjH1sY7RVCAPuqP8UuMjZ84tS5+XScsJ0TPzMBFA+nlf4W/zKVMaZKefSPcfWUqab9++r5YffU/raPtqUS7/0JUgDgY2KCA7PkXSuZGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UG58CB2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B2C4CEF4;
	Thu,  2 Oct 2025 06:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759387473;
	bh=JnBN7j5droh3H2pGNS2Yqug4bI9vWf9w2jtC9CcI0Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UG58CB2rWtiMXRchCHwWLofkmsXLn3fKVtWNW04+7L9eNEENg/qRLNowFt/vG/bys
	 3HXtuDxQ1SRoqd+ysPhnEt6fgHCd+OulYKaYQCDquJ7AY+CZngGKkBZ70hzSWs67BA
	 A9dHrIL04xDuCGqWZ5BGnqJ4rryPEuxYsAYKsM6c=
Date: Thu, 2 Oct 2025 08:44:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] Linux RISC-V trace framework and drivers
Message-ID: <2025100255-catcall-drinkable-23f5@gregkh>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <2025100208-challenge-protrude-d6c3@gregkh>
 <CAK9=C2U9FV6crTL1G2X6tUM=RyRnPBm1dPeFc29n3vmrFTcfHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2U9FV6crTL1G2X6tUM=RyRnPBm1dPeFc29n3vmrFTcfHw@mail.gmail.com>

On Thu, Oct 02, 2025 at 12:09:23PM +0530, Anup Patel wrote:
> On Thu, Oct 2, 2025 at 11:56 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 02, 2025 at 11:37:21AM +0530, Anup Patel wrote:
> > > This series adds initial support for RISC-V trace framework and drivers.
> > > The RISC-V trace v1.0 specification is already ratified and can be found at:
> > > https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-ratified
> > > https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Ratified
> > >
> > > The RISC-V trace framework and drivers are designed to be agnostic to the
> > > underlying trace protocol hence both RISC-V E-trace and RISC-V N-trace should
> > > work fine. The discovery of trace protocl parameters are left to user-space
> > > trace decoder.
> > >
> > > In ther future, there will be subsequent series adding:
> > > 1) Sysfs support
> >
> > why does "trace" need sysfs support?  No other cpu platform uses that
> > today, so why is a new user/kernel api needed?
> 
> We saw trace support for other architectures (e.g. ARM coresight) allowing
> trace start/stop through sysfs. If this is an obsolete or not preferred approach
> then we will deprioritize and possibly never add it.

Why is that needed for coresight and other arches do not need it?
Perhaps it should be deleted from that codebase instead?

thanks,

greg k-h

