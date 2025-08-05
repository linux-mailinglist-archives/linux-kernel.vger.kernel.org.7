Return-Path: <linux-kernel+bounces-755778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B555B1ABAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500E4189FFA9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EE72623;
	Tue,  5 Aug 2025 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4ijBTLb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F7A932;
	Tue,  5 Aug 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353256; cv=none; b=kdZsxnP+gVKjIDBZQk1Ni89118Bro4olrJKeLgSwmr7nW6p9NFlDCE4HIZl/WywsqKLp5lO25Ei34cc05/+h3BHzXSIj5GeRuVR9wi7+0B1TREkT0WyQZI5D3mV+aRKoKClt+VKVAzbsL/hQfBFMMyAt0L1d36oPZUYbX+YTbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353256; c=relaxed/simple;
	bh=u340i/CuZfX8PAUKHZEEX2OhmtH6FKVM6LMMSc24FiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7x6xpeHy4cQkxLQLWYy5DiKSaFT94LMxjQI3TZc2SqVLLOP8DCqO7OnG7AmcvsOlnbChfAjssdY1r06weAwa9t+9/OFE/ptHefTwz4I518tsN9OpB3rcnuuvshnvNzDIUorHCHgeV7JDAJNBNFL5FTyKlRUn+/irKOJ0iwxwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4ijBTLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04479C4CEE7;
	Tue,  5 Aug 2025 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353256;
	bh=u340i/CuZfX8PAUKHZEEX2OhmtH6FKVM6LMMSc24FiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4ijBTLbgrAmlrkx+Mzt9NvBUAtNc7JhDO+wDxQBRHnmRS3ZZYtGza3V/4Qi5MK+7
	 DRTkhsCpeF9iMCQa8K3xLHVZS9ssyrNhOBHZcgMnzgkh6NmUBvFN0h3VlbQfP0OC2N
	 sfgsPUpD8jQtLbeTGrbunQ30U6iGxJ7jem4Jis9Cr3fNINw/aMc61q7QMsGqN7VFs0
	 39OArs7q9iv0lgoGhULh6qdiOFVF+IqMnU4m4ZGQdw1GfgkrS/7UTRGcLsFV/a/49B
	 Qv6hU6D+TqCYTRYOAo9vFAK8yFzSjkGwtCH/7dRzlqHvAd2nouHhtBulo0iJmVjdCb
	 j9Wogh3O+fqgg==
Date: Mon, 4 Aug 2025 17:20:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] benet: fix BUG when creating VFs
Message-ID: <20250804172055.0b865696@kernel.org>
In-Reply-To: <20250801101338.72502-1-mschmidt@redhat.com>
References: <20250801101338.72502-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Aug 2025 12:13:37 +0200 Michal Schmidt wrote:
> benet crashes as soon as SRIOV VFs are created:

>  err:
> -	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
>  	spin_unlock_bh(&adapter->mcc_lock);
> +	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
>  	return status;
>  }
>  

Quick grep reveals an identical problem in be_cmd_get_phy_info() ?
Or is this bug size-sensitive ? I don't see the vunmap call..

