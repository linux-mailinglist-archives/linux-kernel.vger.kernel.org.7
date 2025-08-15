Return-Path: <linux-kernel+bounces-771215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A74B2843A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73B13AFD59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDD310798;
	Fri, 15 Aug 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZSegJ9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FA30E0C9;
	Fri, 15 Aug 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276328; cv=none; b=uZc8z87BE8LfWiMI5zpnTwWwAHfJ1UIygolkzkcfmAhHiLWGzAcYZPVSN8ubtS8f8D/Qbg57rDPDc+g5SycWf+DBq19HZxxixVlXxx+Yy2c/dh8aS10eSzoolBYSn/jpIJ2D+YulIX6uUp5YFjrEnWQdcyIELA1bMGjPjuP6kBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276328; c=relaxed/simple;
	bh=WF2QYFUO9jba47tJ+t4Jyic/JqPDgTw2qJmqktEND/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxML3aK4Lbb6HMk0abVYL7fOiUWMVlacuBAYZ8+YpGdBj6MxKmdlkGFV8cwRRjvFAqtUtLqrpmWpXeUL63kcvYiDb1d4GQTtV2Qs3kHDPQA1pfj6VNNAU7/++jyh5x0D3qrX2vTPXvhLeYBnZhdgj5RbhCQJVAneQrI483pTBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZSegJ9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F42C4CEEB;
	Fri, 15 Aug 2025 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276327;
	bh=WF2QYFUO9jba47tJ+t4Jyic/JqPDgTw2qJmqktEND/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XZSegJ9dctJhF2K7y1rpPXh/BoV+TnLIKHx7w4d4SElFFgj0R4CEzwLVF+YzbdYZc
	 pcnCbnSbWf10MD2D9FHZic2rh5FdHpgujjwTaw9QsyTLlMLUNxtNL+hswtpiuojeRP
	 nrNjF1Y9SWMkrN/zLiohHza3YI9rzrhN+WkKOsiVuMT3VBoekOBPIUpxoU14WgCGIB
	 cEtX24yJDQcQBvFwON2F2xftj0F53W6QQvWFEtwhoja5mur+g6PydibDqqyYkC+9Zl
	 qKwkRdLErIlOiOJPqkyPnjdQN6689y67E4g9CUNigRHt9HsNNvvYo3xBMRBs83armL
	 oCkkbXGcg5kVw==
Date: Fri, 15 Aug 2025 09:45:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Peter Seiderer
 <ps.report@gmx.net>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: pktgen: Use min() to simplify
 pktgen_finalize_skb()
Message-ID: <20250815094526.46ec0fe2@kernel.org>
In-Reply-To: <9CDBDFFA-DFE3-42B6-8C5C-7F4E2AFEDB9B@linux.dev>
References: <20250814172242.231633-2-thorsten.blum@linux.dev>
	<202508151939.AA9PxPv1-lkp@intel.com>
	<9CDBDFFA-DFE3-42B6-8C5C-7F4E2AFEDB9B@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 13:46:57 +0200 Thorsten Blum wrote:
> On 15. Aug 2025, at 13:31, kernel test robot wrote:
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on net-next/main]  
> 
> I thought I compile-tested it, but I must have forgotten to enable
> CONFIG_NET_PKTGEN. Sorry about that.

FTR I don't think the min()/clamp() conversions are particularly
useful. I'll TAL at v2, but I'd appreciate if you stop sending
such patches to code under net/ and drivers/net/

