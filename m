Return-Path: <linux-kernel+bounces-838794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AEBB02A0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280537AFBA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26621F462D;
	Wed,  1 Oct 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsDD6oRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779422CBF1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318226; cv=none; b=lBbDc01VgTtOjtn35ESD17zRasWdprZeR8XsANKqKw5vAOayy6q6W9eHephT7kieiE0qHZ6Sft07jPHUZdQy70NxrP9SRXQ1BNO/KKgl5Lcc9+Hnw3kz779Iz6puhyQOKA3QG6TkDh9P39GwSXL67rS4Xi5HzGAjS5O64vnXaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318226; c=relaxed/simple;
	bh=/O7hNSAsIGDyvmS3NbIwiUzg0VS3xLz1rSxyQ8x9G38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGubdwk+CtpmLea0MjwwwaJsuafgsZzgspPgA1Bx6kRo9OqzzUSO6Zmd0UkmLCuOxQJrgXJRL5KYVAGzQFfJdgpf5joeTm71uzxnEBKBEovISpsjGcweGl2XfZ3LgoRrvGOBT6u1Hi/te5XG6AMaQtZ7Y+RobnLJs2+5v9dYtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsDD6oRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BBDC116D0;
	Wed,  1 Oct 2025 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759318225;
	bh=/O7hNSAsIGDyvmS3NbIwiUzg0VS3xLz1rSxyQ8x9G38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsDD6oRbstHikBnhHFxza0IdPZ4pFsgJsoeZ9Cx9LPW3zCIwrd/qvR8X7LYfR+TQm
	 K6dhD4cr5a6rlT4DWhHQLSBQQNIx95HefnUbyNLE6DCNBFpbnkaYDNe6hha6uGpIEN
	 sif6szEFx6xinWa6q7i3326KN7Fqgjfm7aiirdm/FwKBSM4mS6JKiN18AtRnKyZUWN
	 GFh5RIuVirTy6E4lN+C7hT+am73jlLQvXt84k7wTIOBduabZWKIeSQdx9E85QkHYKm
	 I2DVxbpDH0iCFR+EbiUfnH5WtLQGPhNk4rj0hTpseN+a0LtRz5EMaUlOIrNp+wgd2b
	 4CHM23E236Syw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 752ACF40066;
	Wed,  1 Oct 2025 07:30:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 01 Oct 2025 07:30:24 -0400
X-ME-Sender: <xms:0BDdaJ8AAKBpeHFnHKT535YpHuEvXE0WHonVWCPZvwiGT3vdhaUIGA>
    <xme:0BDdaFkozq_uJ4gVNOXBBcB1WI_B30x_QF8SI3OR5hHD3rN7dMgcq51gN1cana-ZR
    _l_IjiIwl2Gpx_bix_X2xuA_7RUFyaJvVXJpLPaHUGi7fh9NBhjN-g>
X-ME-Received: <xmr:0BDdaGaDxiZEPQOD6J3FgW9x8mXmm3RqHQoJGd0ENdpn7dPUeMws6QY8B3axlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhieekteelledugefhffekfffgjedtveevgffgjeeffeegvdekteetudeggefgkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhgrohdrghgrohesihhnthgvlh
    drtghomhdprhgtphhtthhopehlihhnuhigqdgtohgtoheslhhishhtshdrlhhinhhugidr
    uggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegu
    rghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepug
    grnhdrjhdrfihilhhlihgrmhhssehinhhtvghlrdgtohhmpdhrtghpthhtohephihilhhu
    nhdrgihusehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:0BDdaFMe7YZfxW49JDfYRoGKmqLl2b3wU2x0a4dIMcCPOO_0XQUd7g>
    <xmx:0BDdaGe5PkpLZOoMD25G85OnJobxljGzJ8Xu5-f4-Pro9HRYs-YQ2g>
    <xmx:0BDdaLGWN6q5vWjZuacIpd8FNbFl4c7zXkp7DHvPx9GhKP8MJoA5pw>
    <xmx:0BDdaBt7oKVUFdz67r-FhLL3EYyjvUf0Okulij_dlNSUAyZ3BkJSmg>
    <xmx:0BDdaFrq0Wr0p5ZavjqjSukS3oZiCzOlgXzpchYG4S_owGFlQtzO9T_v>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 07:30:23 -0400 (EDT)
Date: Wed, 1 Oct 2025 12:30:21 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 2/2] coco/tdx-host: Expose TDX module version
Message-ID: <oww7wb2ejpaa7v53vp7vhvk7irs2ivccxudjruwk3tepjjf7fd@txbol63ypkkc>
References: <20251001022309.277238-1-chao.gao@intel.com>
 <20251001022309.277238-3-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001022309.277238-3-chao.gao@intel.com>

On Tue, Sep 30, 2025 at 07:22:45PM -0700, Chao Gao wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1ad1294560c..7560dcf8a53d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27333,6 +27333,7 @@ L:	x86@kernel.org
>  L:	linux-coco@lists.linux.dev
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> +F:	Documentation/ABI/testing/sysfs-devices-faux-tdx-host
>  F:	Documentation/ABI/testing/sysfs-devices-virtual-misc-tdx_guest
>  F:	arch/x86/boot/compressed/tdx*
>  F:	arch/x86/coco/tdx/

The entry was updated recently:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/MAINTAINERS?h=x86/tdx#n27325

I think you need to rebase onto current tip tree.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

