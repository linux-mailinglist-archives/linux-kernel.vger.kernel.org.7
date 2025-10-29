Return-Path: <linux-kernel+bounces-875640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DA2C197F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 289C7504177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553F2E427B;
	Wed, 29 Oct 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4qmjR+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F32E172D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731293; cv=none; b=HSBpjXufLOnbfDmwTxeHYM+KfV9jNnaCckdS9+JZqDdX/SLGDT2Ztw5gWw37HUUIwn9HVn4T17wbsNxvCd7d/87By+DNIcoVU6M6BwEiDKdvY9cYEG7cAvZ+pE/pQQ5nLCBMni7iZGudW8uL9X+bddu5vjVAU8EAd/L8sX2+bXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731293; c=relaxed/simple;
	bh=XXQMOmDoB7uRQoYEh/4IlSXb0ixVzJ4dV3bcqMlynHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2OuOEwewnI0ALA6oqBAUhuPMLcDeLm+KPqmpCwca8HMKsKELqs3SPt03PWWTmLBm5pG/B6m2yl663jhoBTlBt+Yu9oI401+xEmE+Jy++hwAJJ9Yr9GXnUFQr8OgoTH2hzocM6X0aAh9KuLWU6gMvm2JAXL2dytpPQ2u1BCsCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4qmjR+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE3C4CEF7;
	Wed, 29 Oct 2025 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761731293;
	bh=XXQMOmDoB7uRQoYEh/4IlSXb0ixVzJ4dV3bcqMlynHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4qmjR+Q2B7AZMIjrxYZmfZDEtuDKXHR84Mfnkt3cBEYT1pWEaRYjfHrContgSJzd
	 SZh1ffwwye/iJFJG9DxCuWjGv4wy29SHI4BPKa4+WtkfpLyJw7LYgmV/TYEq5KLsgX
	 gyON03bOA1+IIyeR9GnZ9KjTOubkOPQ3LplmuO6Z1XILg8wihLlEtrNFG108FqG8P9
	 lOlI7rUm9QEm2sHYJS1ZhG/Tfou/R32ilV/Ahn/fHcfDoduOYoDhZ4aNV91ZOEIK8O
	 lDdxYKCtT0M/BcpE38ADt/ZefdL1Gc/yFpRRGA6qciXZK5lLQIFkdHlPl8XCT/j+Wx
	 jdXEwngxhWhBw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE2mw-000000007qy-3Pbc;
	Wed, 29 Oct 2025 10:48:19 +0100
Date: Wed, 29 Oct 2025 10:48:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.de,
	cocci@inria.fr, Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using
 %pe to print PTR_ERR() (fwd)
Message-ID: <aQHi4nUfIlcN1ac6@hovoldconsulting.com>
References: <5f43ff47-70d4-8c53-efd3-6effb2e9afcb@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f43ff47-70d4-8c53-efd3-6effb2e9afcb@inria.fr>

On Tue, Oct 28, 2025 at 05:02:40PM +0100, Julia Lawall wrote:

> ---------- Forwarded message ----------
> Date: Tue, 28 Oct 2025 22:32:58 +0800
> From: kernel test robot <lkp@intel.com>
> To: oe-kbuild@lists.linux.dev
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
> Subject: drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to
>      print PTR_ERR()
> 
> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> CC: linux-kernel@vger.kernel.org
> TO: Johan Hovold <johan@kernel.org>
> CC: Vinod Koul <vkoul@kernel.org>
> CC: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Hi Johan,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fd57572253bc356330dbe5b233c2e1d8426c66fd
> commit: 8209b3f79703b8ff09f84a79c46ead0df7260d9f phy: ti: omap-usb2: enable compile testing
> date:   3 months ago
> :::::: branch date: 21 hours ago
> :::::: commit date: 3 months ago
> config: sparc64-randconfig-r064-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282255.6lFijMzE-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Julia Lawall <julia.lawall@inria.fr>
> | Closes: https://lore.kernel.org/r/202510282255.6lFijMzE-lkp@intel.com/
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/phy/ti/phy-omap-usb2.c:442:4-11: WARNING: Consider using %pe to print PTR_ERR()

Why is this framed as a warning? It's at best a suggestion for a style
change that not everyone agrees with (me included). A driver may want to
use numeric errnos for consistency, and there certainly nothing
"redundant" in calling PTR_ERR() as the cocci script claims.

	https://lore.kernel.org/all/1758192227-701925-2-git-send-email-tariqt@nvidia.com/

Please consider dropping this from the tree or at least from what the
build bots run to avoid the unnecessary noise and churn this causes.

Johan

