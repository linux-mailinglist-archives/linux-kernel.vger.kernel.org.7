Return-Path: <linux-kernel+bounces-824654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819CCB89CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1EE7AFC84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023A93101DE;
	Fri, 19 Sep 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1PN94FP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56433261B95;
	Fri, 19 Sep 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290698; cv=none; b=sGhiNMronsDmyq/Cfqe/RMq5Uz/0J0CmkhT5oo3B1ro+hLh8P0mPPRKd36s/Kr0QhRTwiIWsZa71D8eBy98VqjtUDOaaO7HCnPt6zyznuMLBZ7TNHvNt3chg+EMCQAmNg1qG2XoTGio4a4arhdsS7ppgQxpwf9xDjhOaupJDjIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290698; c=relaxed/simple;
	bh=Mu3X6SDuGph5K1j1mLlp/9JTLqynrqkE/LWUerH70cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikcaWbkOwRHJUHBLHsTUqHi8XHiTRs9fyrovRGmhV4HlQ+vSj5ZqFFOuEVYAJsjYFThmv6m4vweeQ4jQPhI++sDXiPd2WPFRbJ9C0pZ8xaefZ5uVP5EDM9sczLG6GrmwHWMoyEelEMpTFmUmOQ9K/xnZNsWlmPYqQVzOsHlcqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1PN94FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113F9C4CEF1;
	Fri, 19 Sep 2025 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758290697;
	bh=Mu3X6SDuGph5K1j1mLlp/9JTLqynrqkE/LWUerH70cE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H1PN94FPWADk7IHNpGADJDYdabllpgG5tVb4XC6vB6hFw3r/on8d+/kf0hlSjPoLB
	 Eu3KU6vTrqi4SYof5pUXo3DGa7hImHu5/Ehb0RZNB0z8wp2oQb4q9347whCwse8p5U
	 +NV1RG1bv5MB9oppnrE0wD4cce/KZelVxLymQsidhd1kNzj+8qRYGXQHGXhmwDEJM0
	 AIKoq9mcIwKDR2aOUsts1okv79YW1yNbL6oJHQQt4FxVN+IocOz9L1wEBXvbfRptVY
	 HaQW62TQGdgdhJr2kaFbLNNl5k+jLLRItBetJauDatR5a1p++cHHxz9JaYFmYYZpA/
	 M2RsdGjytjHMQ==
Date: Fri, 19 Sep 2025 07:04:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Roger Quadros <rogerq@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Parvathi Pudi <parvathi@couthit.com>, Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Mohan Reddy Putluru
 <pmohan@couthit.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Basharath Hussain Khaja <basharath@couthit.com>,
 "Andrew F. Davis" <afd@ti.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: unwind cleanly in
 probe()
Message-ID: <20250919070456.197f3930@kernel.org>
In-Reply-To: <aMvVagz8aBRxMvFn@stanley.mountain>
References: <aMvVagz8aBRxMvFn@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 12:48:26 +0300 Dan Carpenter wrote:
> This error handling triggers a Smatch warning:
> 
>     drivers/net/ethernet/ti/icssm/icssm_prueth.c:1574 icssm_prueth_probe()
>     warn: 'prueth->pru1' is an error pointer or valid
> 
> The warning is harmless because the pru_rproc_put() function has an
> IS_ERR_OR_NULL() check built in.  However, there is a small bug if
> syscon_regmap_lookup_by_phandle() fails.  In that case we should call
> of_node_put() on eth0_node and eth1_node.
> 
> It's a little bit easier to re-write this code to only free things which
> we know have been allocated successfully.

icssm maintainers - please review

