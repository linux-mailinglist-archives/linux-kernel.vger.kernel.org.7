Return-Path: <linux-kernel+bounces-664606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B556BAC5E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 02:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38289E65B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1044C94;
	Wed, 28 May 2025 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah6XU11J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABA31367;
	Wed, 28 May 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391505; cv=none; b=N/87IykWJh4fVk1FZY6CiV5Bf6LYwsX84A6HNz98ArtLZEKSJ0QCZ4hqsI22pZ3FrE4mJMnKZAxPDc9uZYXhLv6v4r8NOv5ce1S5CtVJeWpONXQ8xFsElLZwTzNTI+RqCmeKg392G4gBL1KMt7huD4rFQ2g9lO3VJw6A1mltCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391505; c=relaxed/simple;
	bh=Zs8uQKqxwJbVdtpTXsEg+cPJoFnswCd10V7z0IyIKSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djp3Bb0ZrBZ/G8IrBrzn7h0Kuj4BWG7Boh/vIdBF3+3+Q89QcCk1ZgEqVKvcnoedTSu+TjqQ4Rn8UB79MXoEcNKwTY6SJpynvGZsRoekOErofmOFVNsWubw5hHKDbATRApZyktWamPS0H9kzD6oSPiGiFGEZvP6GaIm6Lz26CLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah6XU11J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E395CC4CEE9;
	Wed, 28 May 2025 00:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391504;
	bh=Zs8uQKqxwJbVdtpTXsEg+cPJoFnswCd10V7z0IyIKSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ah6XU11JTyh6TDuXNTD+goGar9xokzda4C4ytVGtPZ2607zWLZafdRSirvISFAx1H
	 SJGMj/+aTkHwvpn/jIhWk50/x+iefV0zgkAW8bXIEDQDyMSCimvE43e0THvNoWEbHN
	 f9nRjzdsKriTzMSNKN93iYBgq5Zyu+K5GEflc30zBoo7oxmSqNjYcD06pIj+xHeK9n
	 3eYe72GlNmzMDAdmuPQuIVWnQ+q/0dyXKDDQR47joRuuNxlI/ph3AyILnL5X7s3WOQ
	 bXIpovru6BbWBJbZYi39a4ALGgt6RJlUvPwK1mnMA6IR3rjZEhyrBcy8hgJzddiNWn
	 N6ozpiLsXOQZw==
Date: Tue, 27 May 2025 17:18:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [net-next PatchV2] octeontx2-pf: ethtool: Display "Autoneg" and
 "Port" fields
Message-ID: <20250527171822.030f5f75@kernel.org>
In-Reply-To: <20250523112638.1574132-1-hkelam@marvell.com>
References: <20250523112638.1574132-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 16:56:38 +0530 Hariprasad Kelam wrote:
> +	case PORT_TP:
> +	case PORT_AUI:
> +		cmd->base.port = rsp->fwdata.port;
> +		break;

You're running 10g Ethernet over a 15 pin serial port? :/
AFAIU PORT_AUI refers to 30 year old, 10Mbps connectors.
You probably mean PORT_DA (Direct Attached [Copper]) ?

If that's right and the FW gets it wrong just fix it up in the driver?

	case PORT_AUI: /* FW uses the wrong ID for DA */
		cmd->base.port = PORT_DA;
		break;

? Please note that net-next is now closed for 2 weeks of the merge
window.
-- 
pw-bot: cr

