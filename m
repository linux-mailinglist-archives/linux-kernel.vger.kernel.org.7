Return-Path: <linux-kernel+bounces-763754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADCB219EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 02:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE04242F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCB2D6612;
	Tue, 12 Aug 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1wYcTcpW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAEEB67F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959801; cv=none; b=cBKWGRYM+HdRBKKw/ShYPo1vU+CI8ppVROJYb4k3GAfW81VJDt/ppgqGgmQIe/OkzmbW6K0CebqPJfWEwLQHJbocKOQmax9Wh4m5qnhKJ5tGARXd1D2bVOZaGnplZ2E4+EvnbRdYZZ90iK+DrTaUmwYcsUyK2EkDXzSSxlkE/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959801; c=relaxed/simple;
	bh=o9AS0MRrqwmpUSHfwTWrmg4HCYMFhYS519OgwmLuzhE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nrHF4r3wqLtmcfq3o4M+6EyAimmDyoFhsz93l3dXh6qThgChM0VV5blyGisdKbmQiVriAS6egGUyv+FBwvoXZrSMUQnRVLxGcwkjg3eHEPjj9j0e4UuYZpPCq0jasdesO077D8LLKKXw/CyhVupCvTOx+R4UxgVyJiRZ08DoceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1wYcTcpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAB6C4CEED;
	Tue, 12 Aug 2025 00:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754959801;
	bh=o9AS0MRrqwmpUSHfwTWrmg4HCYMFhYS519OgwmLuzhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1wYcTcpWl8UUbP5dYyvpvCX8EexItAvoFSrymlUU/kdOuQ0Uauh6CbZxLC4wleKoR
	 j0B6YpUtlnpyjz2xXJmMe7in7Rj641i6MnPSUY8+uzOvB8zdObzHnQi0IZvS1y5bMf
	 unc91r9dWMoNy99LQoFbiTAPmxnTuYCQByq/6zrE=
Date: Mon, 11 Aug 2025 17:50:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Subject: Re: [PATCH] lib/digsig: Remove unnecessary memset
Message-Id: <20250811175000.7f2e5fd3dc903ce5503e0ed8@linux-foundation.org>
In-Reply-To: <20250811082739.378284-1-liaoyuanhong@vivo.com>
References: <20250811082739.378284-1-liaoyuanhong@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 16:27:38 +0800 Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> kzalloc() has already been initialized to full 0 space, there is no need to
> use memset() to initialize again.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  lib/digsig.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/lib/digsig.c b/lib/digsig.c
> index 04b5e55ed95f..2b36f9cc91e9 100644
> --- a/lib/digsig.c
> +++ b/lib/digsig.c
> @@ -159,7 +159,6 @@ static int digsig_verify_rsa(struct key *key,
>  
>  	len = mlen;
>  	head = len - l;
> -	memset(out1, 0, head);
>  	memcpy(out1 + head, p, l);
>  
>  	kfree(p);

It would be a little faster to leave this part as-is and replace the
kzalloc() with kmalloc(), no?  Seems that `mlen' will be small, so any
difference will be unmeasurable..

