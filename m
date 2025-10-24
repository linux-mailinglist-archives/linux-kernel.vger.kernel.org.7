Return-Path: <linux-kernel+bounces-867932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D547EC03F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92EA119A5105
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA7314386D;
	Fri, 24 Oct 2025 00:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYAGu+dA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65FD9463;
	Fri, 24 Oct 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265994; cv=none; b=KeH6UwQWJQ2LUcHivqTfX3UMuXPHhRwEgZNzxB1j614U5QOpDQk+oK7GbVdtdH/4mkGW0eQHhRtoIJriZxEDcw+vqfAfblqjWzZ6axHEgDOHzGGDXDPpx0594OC6MLzb0+n2nN/LMyXsAmt4JeKiYIGwizD4CfpMDdK9nAe5dmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265994; c=relaxed/simple;
	bh=bcK37DVwLuvaZ9Q6z8E3noWFTUHxp9ci6i+6KG8Qmig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7rGlb1kqbXWNv/oefcjaKkcYB5T0pIRHQUgcFf7xKML9QdY1hhXORkS+ITxsHUXWSNCQnjSBR5BezIi6L+PC/4e2zICqnTwXkOEUImR+HYh2Sq61suUxXgPH/Jedy/ZN4pSJXSiVT+RdiheXFyRD5ujXSvzcDCLmx0bzwIFN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYAGu+dA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DC3C4CEE7;
	Fri, 24 Oct 2025 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761265994;
	bh=bcK37DVwLuvaZ9Q6z8E3noWFTUHxp9ci6i+6KG8Qmig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYAGu+dA3400uyPl8qnPKpsf7Bo0f8FLs3iYE4mBcA6u0+1KaU+fFkq66BCZW0lGB
	 gW4in0B8arQl6Ja01qT6J99dHqYnIOIV95imPZIyayMUBz4zy5CYjMoGhcBzqBSUSc
	 JjsrCvMsUAfJV7T2HfRxqqCAmPAM2V5O0fwko4F1HRqpTw4ttaVT2tmvqZYmDcQUE/
	 0EzRGZZ8ta80hpiUW6pukfWo3YDUEFejwUiowFa7RfIs/XHw+k++2lKOUnttec/Cii
	 OkIPx7nhM1uQ5U1v3Qj6VY3n4v3cpJuZ1y9US4FK+PtlcyXpakf1g01Rjk/jexc14s
	 qxtA+n6ELJHfA==
Date: Thu, 23 Oct 2025 17:33:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 toke@redhat.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, Cong Wang
 <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
Message-ID: <20251023173312.7e0ad8ff@kernel.org>
In-Reply-To: <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com>
	<6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 17:39:09 +0200 Nicolas Dichtel wrote:
> > +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&  
> Maybe parentheses around this first condition?
> 
> The size could be adjusted accordingly in if_nlmsg_size().

Slight preference here for no brackets unless compiler complains 
(or needed for correctness, of course).

