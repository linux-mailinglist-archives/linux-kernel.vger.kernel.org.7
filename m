Return-Path: <linux-kernel+bounces-832414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4CB9F434
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA09B1B24EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF1418C933;
	Thu, 25 Sep 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txJR+EdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DF45C0B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803423; cv=none; b=Y0PSQcxsNLkc+8MMLR//+WehBk5hqzbykZrpgASZY9Wwy7XxWhRuWLScKO+SMWJEx4ofC7kItK6Pm9gwstiCJdmYJRuDZsZuCPf3o60CscCZYUH4bliPNmYY88KaG9EE03ztee+xPtedHZkpHleRcYihVZHO3yZJR2O6ILNpnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803423; c=relaxed/simple;
	bh=edgozDBXEb8DARj4PXLs/1f80/w2YhHkyt2PJgW2nog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIQ6OhHQhzOP7pYh6HzemTEntcp/SaM4+WnVj1tqwnFsUxqZ/DItIYnfvhweBfMHT9DYm9GvwMZqcpD355Ngi9Y5bcFtU9SRuT4sFhQL9sXibP4CMITEhHwVIsS0BfDaEmoriJ4VfhmC9blO6B499IhSXiHCHxXMDqPJr0Y8puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=txJR+EdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83604C2BCB0;
	Thu, 25 Sep 2025 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758803422;
	bh=edgozDBXEb8DARj4PXLs/1f80/w2YhHkyt2PJgW2nog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txJR+EdJFoCAcQ3O9wxskBhCWpMi+zSwaatxycO2dF0E89Id3gBLLrwXBAEkPu5Ek
	 /g7/APbbW9cDj6ItG3eIyNQKnfRH+pr4j2DotjdjiZqzDqAPFtFJsJwkoLKu7Dc4XA
	 ia4G6m9MIwjLSkiQHHT3ZVi3nU3aSeQRcs8l74Xc=
Date: Thu, 25 Sep 2025 14:30:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn
Subject: Re: [PATCH v2 2/3] uio: Add Kconfig and Makefile support for
 UIO_PCI_GENERIC_SVA
Message-ID: <2025092505-pueblo-dining-d50a@gregkh>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
 <20250925104018.57053-2-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104018.57053-2-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 06:40:17PM +0800, Yaxing Guo wrote:
> Add config symbol and build infrastructure for the UIO PCI generic
> driver with SVA (Shared Virtual Addressing) support.
> 
> This introduces:
> - A new tristate config option 'UIO_PCI_GENERIC_SVA' in Kconfig,
>   dependent on PCI and IOMMU_SVA.
> - Build rule in Makefile to compile uio_pci_generic_sva.o when enabled.
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
> Changes in v2:
>   -- Add help info in Kconfig
> 
>  drivers/uio/Kconfig  | 12 ++++++++++++
>  drivers/uio/Makefile |  1 +
>  2 files changed, 13 insertions(+)

Again, this should be part of the first commit, why make it a
stand-alone one?

