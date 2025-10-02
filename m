Return-Path: <linux-kernel+bounces-839872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAAFBB29E4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466A2422FEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777C28724E;
	Thu,  2 Oct 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/AUu82Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B429A2;
	Thu,  2 Oct 2025 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759386405; cv=none; b=u+Xck5HSyBvcshjUxg9cu/9nty0zk5vVjdHzYJPhmTo7CM4rJuyo1lBwZHNxZKsojB3MvPL3n5y4FO5+rHs0qyh3BEmMj2db9kkkqexKCf7nhn850I0Lsb/CI8kcnc1R7AnKRoblcNBN8XMCc2p0BWHyPsZTKlrhEEYQeGWe1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759386405; c=relaxed/simple;
	bh=IN5Xoo6ynmRa7LHQ4OoMu5qgHy4kkgfiKHhscIHLLGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hURuQ0MzSuoJmiz6LlDXP17Y32jE/iV0GZEZmpV18S2z4pIVPaM/XCXaG9Lb1W/BPwsy6JrqqgVTRnyv/fW6baa6FGVdy9TYaueAe6AAatKPvolR2i2EH6hyJuhlirLrU6qP5uZLiKyYRIsa0JawES4SgQAlziT8K30QVGiNuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/AUu82Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD5C4CEF4;
	Thu,  2 Oct 2025 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759386404;
	bh=IN5Xoo6ynmRa7LHQ4OoMu5qgHy4kkgfiKHhscIHLLGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/AUu82YtjB+tKa0eWLCJZ23oK0HvGv4tnzg6Etc05laTDdawViQrxEzaLmmEuZXS
	 xnl4e+rU9HzXQUaOvMV3muddBxo8wbHY36pm8skkpm1H69s+8iS3SRgS0RFa4kM6aM
	 umt1+XXCVDs0R8Uv3740jkOnL1+37ACDfGdpKa0U=
Date: Thu, 2 Oct 2025 08:26:42 +0200
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
Message-ID: <2025100208-challenge-protrude-d6c3@gregkh>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>

On Thu, Oct 02, 2025 at 11:37:21AM +0530, Anup Patel wrote:
> This series adds initial support for RISC-V trace framework and drivers.
> The RISC-V trace v1.0 specification is already ratified and can be found at:
> https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-ratified
> https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Ratified
> 
> The RISC-V trace framework and drivers are designed to be agnostic to the
> underlying trace protocol hence both RISC-V E-trace and RISC-V N-trace should
> work fine. The discovery of trace protocl parameters are left to user-space
> trace decoder.
> 
> In ther future, there will be subsequent series adding:
> 1) Sysfs support

why does "trace" need sysfs support?  No other cpu platform uses that
today, so why is a new user/kernel api needed?

thanks,

greg k-h

