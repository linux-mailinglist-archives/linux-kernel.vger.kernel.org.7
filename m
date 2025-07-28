Return-Path: <linux-kernel+bounces-747425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE13B133B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE81518964E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455532116E7;
	Mon, 28 Jul 2025 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en5Pk3sj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D11C36
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676897; cv=none; b=oPir7doWGLKlUIdeSJOjgOeq8hlHjeoebPqUdfq9YY1G0F8RBwUjoReZcldDpeEXvqAG6D2Rn9lFAej4VcXUfw5ilt+GxNddry6QumiVa3fcigbPKu0pOxXED/H9DTj8nBdpDgSCwyVsFeQ3Ta9/ljrcQ8Ta+X47z735+45phLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676897; c=relaxed/simple;
	bh=m8oiC7Mrz6GAByvmmIlVxp/E0MJPqq/e0q5suAHiGcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjLvfeuz/Sm4obNyb1NSBaKdjBoCFT5VhAeNBROQgio66f8gJWx70F6lIUPQKyqMTH31Bd7n/MFd0xBL+luYoK0/6XPxd4n79WFVWxi4/f1O6AgoDWoPe8ct60Cb1V97SSf3XRjXWTgw3ZIX0HkEcmk0ZAZxikcHBgEs/ggEr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en5Pk3sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D47C4CEE7;
	Mon, 28 Jul 2025 04:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753676896;
	bh=m8oiC7Mrz6GAByvmmIlVxp/E0MJPqq/e0q5suAHiGcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=en5Pk3sjoSuUfTQVVh764FsQPWiO8FkVMHQrQIFZgeUnBRCIkaFCXfG8fqleArcW5
	 5fToafMbaewqHreZl+Odz/Vwj730z4IU0GzXepl4rDiGatwsBmFpcJYGxySIVcM0AV
	 R6IlkY23lQ4/rBlvcGOncpTGo3lk6SMrHFb20ipA=
Date: Mon, 28 Jul 2025 06:28:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Justin He <Justin.He@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node
 mapping to  reduce max_distance
Message-ID: <2025072834-getaway-fling-0d66@gregkh>
References: <20250722041418.2024870-1-justin.he@arm.com>
 <2025072202-june-cable-d658@gregkh>
 <AS2PR08MB978689001CDED54ABD33FAF7F75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS2PR08MB978689001CDED54ABD33FAF7F75AA@AS2PR08MB9786.eurprd08.prod.outlook.com>

On Mon, Jul 28, 2025 at 02:54:42AM +0000, Justin He wrote:
> Hi Greg
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Tuesday, July 22, 2025 1:45 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Danilo Krummrich
> > <dakr@kernel.org>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] mm: percpu: Introduce normalized CPU-to-NUMA node

Odd quoting, please fix your email client :(

> > > In this configuration, pcpu_embed_first_chunk() computes a large
> > > max_distance:
> > > percpu: max_distance=0x5fffbfac0000 too large for vmalloc space
> > > 0x7bff70000000
> > >
> > > As a result, the allocator falls back to pcpu_page_first_chunk(),
> > > which uses page-by-page allocation with nr_groups = 1, leading to
> > > degraded performance.
> > 
> > But that's intentional, you don't want to go across the nodes, right?
> My intention is to 

Did something get dropped?

> > > This patch introduces a normalized CPU-to-NUMA node mapping to
> > > mitigate the issue. Distances of 10 and 16 are treated as local
> > > (LOCAL_DISTANCE),
> > 
> > Why?  What is this going to now break on those systems that assumed that
> > those were NOT local?
> The normalization only affects percpu allocations - possibly only dynamic ones. 

"possibly" doesn't instill much confidence here...

> Other mechanisms, such as cpu_to_node_map, remain unaffected and continue
> to function as before in those contexts.

percpu allocations are the "hottest" path we have, so without testing
this on systems that were working well before your change, I don't think
we could ever accept this, right?

> > What did you test this on?
> > 
> This was conducted on an Arm64 N2 server with 256 CPUs and 64 GB of memory.
>  (Apologies, but I am not authorized to disclose the exact hardware specifications.)

That's fine, but why didn't you test this on older systems that this
code was originally written for?  You don't want to have regressions on
them, right?

thanks,

greg k-h

