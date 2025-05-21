Return-Path: <linux-kernel+bounces-656586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D54ABE852
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219C98A1130
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116A25F7AC;
	Tue, 20 May 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GafnV7As"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A641AE875;
	Tue, 20 May 2025 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747785026; cv=none; b=U3VC/3NnqLlfWu9vQbyEu2zzEfNUk3kI7CvgbzoxZ3XzCi0osjW5mDZh66cJB/ly/UKDE6z3SJQ/Z3ifJFtsqFWzMZ5Wt7pOTv6jd+kVHTzwlgiKisd7sjwbTLQN2/3i3nLV1x0FLvHtJFdNwP/z3m1WPdXkVHxaDSdV+h9iEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747785026; c=relaxed/simple;
	bh=koTvcyk+VigeoLPok7Z9vbPPIgvSeVJ5IdC6IuI1RiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxaAW57+NRJKFsK1TeG8fF+hiPk34UbyRUVmNLxt1zUOcGqIB5/CaLArJM7qO7fb3GROFHiVi9GLkGRGHzNEFublvtl+TSUXrwHFp5i7QSoVRUtVct/thVnbDhq+2DyMF0cnxSWZmVB6RZ6DfpScFq7uk9AHRwEO5iDlIRQ1jIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GafnV7As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A973BC4CEE9;
	Tue, 20 May 2025 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747785026;
	bh=koTvcyk+VigeoLPok7Z9vbPPIgvSeVJ5IdC6IuI1RiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GafnV7AsJYDm+IfoazKC7tBtX1OZp2WdwzrpG/BLpKs5ONNW0pCzW9b/LstFxTX5w
	 XwqV5DRRSNaUZPQBE62gffASuRv52lkfutJQ2MW6BRpFm11oSaqZiU7uh5D70UNchM
	 ccrFypRDOcmailn1+43PWdjXxZodksY3Srbr2QEdxLaeMd8uDryCGzturZQsNvJkSN
	 RLlY7R2oCGRD6gOI969XSn8TN5/KvkGtGn5tTRq091ngM1vToQTRAnJBkmNJYqYoVq
	 BAtpnRbsWj32Y+CbkxUQlilBS+/UNvKA72mCQcrhuOuTnhhJGqZYwHnFrNDbc3eB+V
	 Poc/pU6HUPPmQ==
Date: Tue, 20 May 2025 16:50:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, Subbaraya
 Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [net-next] octeontx2-pf: ethtool: Display "Autoneg" and "Port"
 fields
Message-ID: <20250520165019.6d075176@kernel.org>
In-Reply-To: <20250519112333.1044645-1-hkelam@marvell.com>
References: <20250519112333.1044645-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 16:53:33 +0530 Hariprasad Kelam wrote:
> The Octeontx2/CN10k netdev drivers access a shared firmware structure
> to obtain link configuration details, such as supported and advertised
> link modes.
> 
> This patch updates the shared firmware data to include additional
> fields like 'Autonegotiation' and 'Port type'.
> 
> example output:
>   ethtool ethx
> 	 Advertised auto-negotiation: Yes
> 	 Port: Twisted Pair

Can you add the real output without trimming please?

> +	cmd->base.port = rsp->fwdata.port;

Do you validate somewhere this value is within the legitimate values
from kernel uAPI?
-- 
pw-bot: cr

