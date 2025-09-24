Return-Path: <linux-kernel+bounces-830051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFA6B98915
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD494A3624
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D827D781;
	Wed, 24 Sep 2025 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYsw3XeV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C727BF99;
	Wed, 24 Sep 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699440; cv=none; b=OKYuHlMhStCbJYrMtppTdaSSalXODf3Z8Ar+qbIShPpz0gZQZSNty08LZP90fOHEvTdJS5EnoQtM/BxA2HJ+fIrf4IhW4CKXGJnPfNCIFTja3KZSPwp3SvbASsMKMki/TJrzrBovBFqJohAlQmuN/kzVqDLCvK+35XUSSzyGfcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699440; c=relaxed/simple;
	bh=nj8B5Esd0CpAVmRcebkvj14x2oPtZfpQ+WPkNsAtAYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2ejrkLgT2rAzjmf18QxRQ7cs36wHkJl3FwrF9yHQd4fCQizSFZzXxeTfO34yCYL45UPGg24nEN/kn4NYezgKesPCzkoZ/FsuOfrgE70Bcl9e6V34q/uSgk/TZoyf5jt4VTb1fuM3Oj8eXMp+fqiHktKIBVDhzN462gNUKeGNUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYsw3XeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914C5C4CEE7;
	Wed, 24 Sep 2025 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758699439;
	bh=nj8B5Esd0CpAVmRcebkvj14x2oPtZfpQ+WPkNsAtAYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYsw3XeVta/GTPeQprBFsWxBfgn3EhrCCSIjq9QsTUZcuxmIVK0GwCl5ELDit6LFI
	 /6BMsior8Jdho0Adfb3/gJhbdOxQwCHBGGh0Lf71+k8QlYAJStnnvs1D2l/FJa3jwB
	 3pjrFY/EPJW7fmHg0J+1d8t0ceDD7g0P3VINlN7HP5o0GcJlQp6yAJRhdD+nCH0WP4
	 WfIWssfqgg86185aNG2ZNITOQlHCnEcC37oNykWGLp/z9gudMZ/GdyEpG6mgCytYsx
	 DyO385Aj19feRu/2hRGlYAmf337iouY3EE0pIuOrj7w/ee9x6SbKl3XJAJeoxjIOQL
	 mh04egLVV9pxw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1K3t-000000002D6-11EF;
	Wed, 24 Sep 2025 09:37:13 +0200
Date: Wed, 24 Sep 2025 09:37:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Xiaowei Li <xiaowei.li@simcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add SIMCom 8230C compositions
Message-ID: <aNOfqbokYGtJ2PJK@hovoldconsulting.com>
References: <20250924031650.2785000-1-xiaowei.li@simcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924031650.2785000-1-xiaowei.li@simcom.com>

On Wed, Sep 24, 2025 at 11:16:50AM +0800, Xiaowei Li wrote:
> Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.

> Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
> ---
> Changelog:
> v3:
> - Fixed From and Signed-off-by mismatch.
> - Added introductory sentence in commit message.
> - Added comments for new USB device entries.

Thanks for the update. Now applied.

Johan

