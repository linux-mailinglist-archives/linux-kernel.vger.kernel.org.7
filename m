Return-Path: <linux-kernel+bounces-791751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695BB3BB79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4A67465D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD931985C;
	Fri, 29 Aug 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tk57L5po"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9237B3164B0;
	Fri, 29 Aug 2025 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470950; cv=none; b=DpxZlY4ETDGA4xpElH0R0PLK0wh6IXtgaDXwUV80g9AcxnpjXAUjRvauSZtuQ4PN/AMAue02R5OeSrVATh1rFWeOI81+p5htYi7XXED9ERFXxBRYZe+TxtSMwTXmQ6HDuU0sA0hk0z9V+gnjn3vDR7g35rjaMb+1v0j/3wIM8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470950; c=relaxed/simple;
	bh=gUgQmgM69ezNRy0MhybUfrydozkV44PPK+5UXHb8G9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOfClYoswKrtWEtTMRZkyJHRiX6wXjmWvPpfkitXGdz5BqbI7qLZQWR9wuodQxXgJ2MoYEEhb/51E24SIMQaFDq2A8MCRgA/7I59lHE+0nSfs03cd9SR33o+36omDCeDFnoMNqsTeRTQf8AsCnaMUItW2qbHWK6E8DrVryQmEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tk57L5po; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57TCZfPc2214201;
	Fri, 29 Aug 2025 07:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756470941;
	bh=YMeXDFVGR/9Ki+05emD4cN7qoUvEGzwRqloEtgQvvfA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Tk57L5po0BFIwaihbCd69YgO9O3FHszFUGt8fgCLzBvtXKXzBU1SqdUDz0hUvgmr4
	 yBKhFWIT+CAm/7D1vil0UFQyZRE2JuXKUdgfx8cfviDd4pNyfpLal3pw2LuOsypbnp
	 Go3rdyCDyjA/OLnyGbAL+BHAhMhLBsIDGmbQQMo8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57TCZfGN020241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 07:35:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 07:35:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 07:35:41 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57TCZfx52065041;
	Fri, 29 Aug 2025 07:35:41 -0500
Date: Fri, 29 Aug 2025 07:35:41 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/4] Add support for TI AM6254atl SiP
Message-ID: <20250829123541.332xfrmzgar2dn4y@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250814134531.2743874-1-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250814134531.2743874-1-anshuld@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On August 14, 2025 thus sayeth Anshul Dalal:
> Hi all,
> 
> This patch series adds support for AM6254atl SiP (or AM62x SiP for short)
> to the linux device-tree.
> 
> The OPN (Orderable Part Number) 'AM6254atl' expands as follows[1]:
> 
> AM6254atl
>      ||||
>      |||+-- Feature Lookup (L indicates 512MiB of integrated LPDDR4)
>      ||+--- Device Speed Grade (T indicates 1.25GHz/1.4GHz on the A53 cores)
>      |+---- Silicon PG Revision (A indicates SR 1.0)
>      +----- Core configuration (4 indicates A53's in Quad core config)

It stinks we put the integrated DRAM density so far down in the part 
code. But I guess there isn't much we can do about it now. :/

> 
> AM62x SiP provides the existing AM62x SoC with 512MiB of DDR integrated in a
> single packages.
> 
> This patch set adds the new 'k3-am6254atl' SoC level dtsi alongside the
> 'k3-am6254atl-sk' dts for the EVM (Evaluation Module board). The newly added
> 'k3-am625-sk-common' dtsi includes the common hardware between the existing
> AM62x EVM and the new EVM for AM62x SiP.
> 
> Regards,
> Anshul
> ---
> [1]: https://www.ti.com/lit/ds/symlink/am625sip.pdf Page#21
> Product Page:
>     https://www.ti.com/product/AM625SIP/part-details/AM6254ATLHJAMKR
> ---
> Anshul Dalal (4):
>   arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
>   dt-bindings: arm: ti: Add binding for AM625 SiP
>   arm64: dts: ti: Introduce base support for AM6254atl SiP
>   arm64: dts: ti: Add support for AM6254atl SiP SK

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

