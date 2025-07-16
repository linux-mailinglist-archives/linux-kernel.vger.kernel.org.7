Return-Path: <linux-kernel+bounces-734366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAFB080A8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ED2564A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6EA2EE967;
	Wed, 16 Jul 2025 22:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLYWiPcc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FF291C21;
	Wed, 16 Jul 2025 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706147; cv=none; b=Ko8LGBhE2blUXvLNOaqTAQA+sI83nndZQpsTQ9QWK8ShpjqBdeTSq+tjA50WmSfL/EcnLryHDsn60V99D00GqYs5IbBb6FmdKfms5GN0Qq52LQmozZ/LzpwwItVItI5Dhy9Gke4KjF+h4TEHKkxQ8tOtZHyB1isDNGRLFlSFzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706147; c=relaxed/simple;
	bh=ym2CfWU3RSFwN8T3+muM+b6qKNFd97WR+uQjtqjXidI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdzWTDR9Z9Vq/MkGuLplCGXROkMoh7tIkg1WiGcEps36RBR+JluB0kJhgz/WqWTWTC2oV6uzEKkoAqETzj+o220cds4/r6+wnuRnlLHkte7niIe/pS+nsDP1FztJeEV2VS6VeKb5ChJ6wNTFM4ejEx8JGKxzesQGU16eg1XFGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLYWiPcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7364DC4CEE7;
	Wed, 16 Jul 2025 22:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706146;
	bh=ym2CfWU3RSFwN8T3+muM+b6qKNFd97WR+uQjtqjXidI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=LLYWiPccl54EOtnJDz8pOjXkMELSF5v9JsTNhXE3B+jvUsjiK/LK5gtgR60yymJ+V
	 yrqgjgyh01+tVcWIKsRaCW3AOcHTjyJVQpxA9c86vr8Sq+PqjfxYnyoNMJBGNIODuZ
	 GqbFUiyNeNbeOvh8prQeZ7flhpqrnWaGE+I2Dh0tixQgcDi+VZ1iSspdXgffScf1h/
	 9XQc4BSx6l66QAT7h7jWELXcFvB6YMA4T9rMS1E26acZNNo56PsLTH/buIpIGXhvkB
	 cWQrzWfTB0lRiyRrNT5BJZ+XS6DzW9cMhJ87r269l0oBObIl2IhCTh+K66nBPPLMPP
	 K1Ea9IBhMYh/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15694CE09C2; Wed, 16 Jul 2025 15:49:06 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:49:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, pmladek@suse.com, rostedt@goodmis.org,
	john.ogness@linutronix.de, senozhatsky@chromium.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kernel: Clarify printk_ratelimit_burst reset
 behavior
Message-ID: <a8549ecf-5cad-415d-81a3-21ffc39e6c4b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250714-docs_ratelimit-v1-1-51a6d9071f1a@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-docs_ratelimit-v1-1-51a6d9071f1a@debian.org>

On Mon, Jul 14, 2025 at 05:06:27AM -0700, Breno Leitao wrote:
> Add clarification that the printk_ratelimit_burst window resets after
> printk_ratelimit seconds have elapsed, allowing another burst of
> messages to be sent. This helps users understand that the rate limiting
> is not permanent but operates in periodic windows.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a43b78b4b6464..6f8d3935147da 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1099,7 +1099,8 @@ printk_ratelimit_burst
>  While long term we enforce one message per `printk_ratelimit`_
>  seconds, we do allow a burst of messages to pass through.
>  ``printk_ratelimit_burst`` specifies the number of messages we can
> -send before ratelimiting kicks in.
> +send before ratelimiting kicks in.  After `printk_ratelimit`_ seconds
> +have elapsed, another burst of messages may be sent.
>  
>  The default value is 10 messages.
>  
> 
> ---
> base-commit: 0907e7fb35756464aa34c35d6abb02998418164b
> change-id: 20250714-docs_ratelimit-8f4a30f29908
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

