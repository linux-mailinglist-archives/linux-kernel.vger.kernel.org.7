Return-Path: <linux-kernel+bounces-858551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF8BEB205
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FBE740EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C832C938;
	Fri, 17 Oct 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYVmBd20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D329B77E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723701; cv=none; b=CPbwCMOzZzW3WLRRTcn2AqAaX0tAC8IryX2mFIFaPhHRlhuwrsloTKqTnA3go5dv+vFsO8VTC5D64Qo4CqUf4/kMleJJ9Lp/Prw9nATb1fM/vgFbTkxhtpCevBo3voySQhKTWfM/9M4FLvwt8mGYjR/b1yV09sSEvrYeD+ab31U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723701; c=relaxed/simple;
	bh=Frj/gTI0fCdTQ+dy0b32qZsRqI5p5lZV7D3sjsfbqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ009tCJgavEpG+NTPDhpKpjYCinice5CMnSvOcEEVdCEOkV7oXIfOlQCpnqBwpftK5GrIRu4LxpmiGl/1xsVQM2Xwme7f7696CX30SOq2vmXeQqawqSfX6tgbbV3BWpgrG/4JKtN1jyLLustyWgyGZF9tSNcu4p9Aw1Rl0Tr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYVmBd20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DF3C4CEE7;
	Fri, 17 Oct 2025 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760723700;
	bh=Frj/gTI0fCdTQ+dy0b32qZsRqI5p5lZV7D3sjsfbqFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYVmBd20kktjdFwCdconvE+tVm0yM+G49jzgQcgB6sfnv6RWkp4bhDnZ+JxlXfQ4R
	 HIVX45WAUzhSiV6CHgz2hlsYp2pAc9yvATEGm8qZ06tBqqLjvkJcfaUfGvvpa9YlEI
	 MpbqL1Jn5PaXkebDXJJbE3UMCb1+OjF0AE47PzvxPvoLvGZvAigmuFgDEqz+CXb/VG
	 NPa4SzzoSLAaM6NlcGdgE+o/80UFibn6HI9u+5pRMWBtqvrUo2Ktv+t5X9ZuDHPMx5
	 UL0e8nXbmX2iSRE3bABxeWiwG8HqqdicEIQcakgs+xmxXO+/LEzT4/dzEXFX93uX6E
	 R9q9Fva8FgUzA==
Date: Fri, 17 Oct 2025 10:54:59 -0700
From: Drew Fustini <fustini@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: officially expand maintainership team
Message-ID: <aPKC8xg+vqB8caEK@x1>
References: <20251017143302.1776953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017143302.1776953-1-arnd@kernel.org>

On Fri, Oct 17, 2025 at 04:32:26PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since Olof moved on from the soc tree maintenance, Arnd has mainly taken
> care of the day-to-day activities around the SoC tree by himself, which
> is generally not a good setup.
> 
> Krzysztof, Linus and Alexandre have volunteered to become co-maintainers
> of the SoC tree, with the plan of taking turns to do merges and reviews
> to spread the workload. In addition, Drew joins as another reviewer.
> 
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Drew Fustini <fustini@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Drew Fustini <fustini@kernel.org>

