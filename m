Return-Path: <linux-kernel+bounces-819249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7E3B59D49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8247A560D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C38374265;
	Tue, 16 Sep 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id33ZKme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDE31FEE2;
	Tue, 16 Sep 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039505; cv=none; b=BKTKk0yysgDGrJTgPgi9btT4X5wmqbf8s2XFEbDNojC8Rhr4O83EtRQvC7MlmfNUkYdD9a7UY9eECx3mrkXROYcYhudngnQ0DLo/1kAO2iguOczACXVcihW6VMVSmkNe7CVI9kVnVA6zSc6+e+zk10IUxXYc1ilXCNRYIZKoGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039505; c=relaxed/simple;
	bh=WnfZHrSXP+9rPi2fkHLNJGmOr7iF+U0eQb6HgQ7qNOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izzOUhwBSQywbX4l6Ea33xqu0mF67UMTfeuyOxNAlIWlv8WX8emO8kp8QZZJyg2OvEYu2fEc70HTGmnKIBI+dpKR3Px5nKnReGT8ho9IvpKdOzXdHfuUKeGLrA0ztSwNlAHCv7My3yUU3jxKGRZeNHOIn22NbBkObVkABiAuMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id33ZKme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A01C4CEFF;
	Tue, 16 Sep 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039504;
	bh=WnfZHrSXP+9rPi2fkHLNJGmOr7iF+U0eQb6HgQ7qNOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=id33ZKme4J774prN/iFmbwKfM+jk6JxGa0M+x0Z6arjpgHik0uMvU4Ax1HMzosJbV
	 ZWpNVT2R4VlioxJ43h9IMOMpyWr2l7weNirVRKEivd5ZBmGEM9q+oQqzqtOeAEkurl
	 D9DZb2bQcOkmvMXlSvmmtyLjMTfapBxjUt2Souu+sIQipj0eGmFIXOkZgJVVUg0UYx
	 NgsgEtki8ZVofXfR4DZ1shuSVf0uSZnuNUzX+Q+TrZEpU3fce50hWGlI71GYfL+izc
	 eTn7NDRkIOxkQeKkzywCAbwaEbYXtCx5YT4R91An7mKoqUCNZKSqaqFQ5PgHU5arQS
	 8ZAHFHOkavNyw==
Date: Tue, 16 Sep 2025 09:18:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, Lei Yang
 <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <20250916091823.3fc6ef72@kernel.org>
In-Reply-To: <20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
	<20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 03:47:29 -0700 Breno Leitao wrote:
> @@ -1217,7 +1237,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
>  	size_t info_size;
>  	int ret;
>  
> -	if (!ops->get_rxnfc)
> +	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
>  		return -EOPNOTSUPP;

There's inconsistency in how we check for the ops being present.
Here we check for get_rxnfc and the new callback.
But ethtool_set_rxfh() and ethtool_set_rxfh_indir() are only checking
for get_rxnfc. I suppose we can remove the explicit ops checks and
let ethtool_get_rx_ring_count() return EOPNOTSUPP?

