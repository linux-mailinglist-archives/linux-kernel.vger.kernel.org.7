Return-Path: <linux-kernel+bounces-767273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3195B25228
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CBB17F787
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E6276054;
	Wed, 13 Aug 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhEq2FrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEA303C82;
	Wed, 13 Aug 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106244; cv=none; b=r8wUNGVdbVOB6kn74mSmps398nmq+Nxa2i2+tXNhVCpsSXZUfY7RyQ2gX/7PT8aV6WcRFki4hWHnfEHxQ7paCAG9jc06kfGo8Z8JEWmrS1gjG1iNJc9ZvHLq+OBNBsOMOOesYdG4f4IndlFTw3jAncdFDxGH1acSl/adfJFwTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106244; c=relaxed/simple;
	bh=vkLB7a4VicTO+02Fi1mYDkZouCIcofMubKLvSx0CDEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HAZ1FeyY7BOetQRiLnS00Y7VEQtqDvzLO0Bm4y6bZMSEjs6fv/Fi0s+aKTx7CS6qRLzzU2ZeTrpcdZI2rY7jLd1NrcRhKXSkRuFuraLrPeLNkeMZO0Cb7Nso7PvXy16ybMQvb4dToV4T3A+pcsYrEUfgpghEcgrvkU9t5VJC9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhEq2FrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F5C4CEEB;
	Wed, 13 Aug 2025 17:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755106242;
	bh=vkLB7a4VicTO+02Fi1mYDkZouCIcofMubKLvSx0CDEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UhEq2FrVKOmHpp+HrYxeluEC7/pDOEPcfqvj+bQ1JHTlACUpUKTLPBRLTs74MNLSV
	 zyogIUVZHDqzCw+bGalltnInYr76IN7HBaG8niqR4BVQ3CeWMQUJ6gKGYXMIG5zRQ8
	 aI2yxKEXeDx1bKb4lev3bz25n1Ftu7DdpTQebCm/a4I97bvMlICxgruUzUdAQCBSCf
	 7FouKeuJE97cbFZ8gRJnA4dn3C44X1Sr1oHHJoSefOrJDYvafVHDKHcAdwPsC2FsY0
	 lMLR1fn3UuKnUC2PiLzZqg47rZrBebYnOYWpqXVIHnpY+aQcGUC004Damjel5BWc6Z
	 0JF6PPBHgzX0g==
Date: Wed, 13 Aug 2025 12:30:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the devicetree tree
Message-ID: <20250813173041.GA280259@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813121447.4a1d3383@canb.auug.org.au>

On Wed, Aug 13, 2025 at 12:14:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the pci tree as a different commit
> (but the same patch):
> 
>   684339e80a93 ("dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers")
> 
> This is commit
> 
>   ddb81c5c9112 ("dt-bindings: PCI: Add missing "#address-cells" to interrupt controllers")
> 
> in the pci tree.

Dropped from the pci tree, thanks!

