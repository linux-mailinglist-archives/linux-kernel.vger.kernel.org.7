Return-Path: <linux-kernel+bounces-585583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A371FA79507
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73333B0082
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE11C84C0;
	Wed,  2 Apr 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ByZ52DlG"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421E19E826
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618340; cv=none; b=UVPab5JfPemxaBpJrM+wXgaAKNyGxmM/cRwG4fl7rXUnZKLuY1inw4kB9T8fJrjeBd4P0MQxIk0OAdqU0AT0Wph3CIRcJONmw6Na0WsvmtgIdkBO051utM/pz5eSJHAL348lKRh3AOEMZSOMEevEFEmfAiCplCMy83ImNCIO5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618340; c=relaxed/simple;
	bh=X7WlFzryVQmI0vtGPEi7XUfnO0FDI6kyZPLHkYzGV2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ds1I06//A6oCWUpe2y7/UzURjlmXoYBe2yyNdBGnY+imjVus40NiKMbJOPL5eQYyaOdpS0LrkqXziPeEcRR9nLQSpiOyZHVNB2TkE8EVvy7ERqXmPp5BPgnpsfqJ+B6vHTNostR/nO7DSgE/sJ2EmK1uJYRtIPywc+pUlgGfPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ByZ52DlG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 14:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743618325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umVlCwIMG6EvWqLUfbeLQGTAGSB4/4JNIoTa5JSviAI=;
	b=ByZ52DlG0bwUZZ7bTjHlxG69b+piu/f4vay6AOejLZfyiqQ37qOUQXSIZ0RiSJBVgWBF5a
	oJ+0oaNbX0HvF3qnarmJaNMAIqgpeU7gJCkaZ1NAdGjhlY9ltVVQ/d6pD/AbFoVE7Etq5K
	allMhOrn2eU+gcgVq0aRqpdwOzMxjco=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH bcachefs-testing] bcachefs: use nonblocking variant of
 print_string_as_lines in error path
Message-ID: <nlp6womaeq5tgt4wfae6mq5fl5w3sg7bqkyu2ctsaunxuaemqg@os4cz7r3tbyz>
References: <20250402181556.81529-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402181556.81529-1-bharadwaj.raju777@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 11:45:53PM +0530, Bharadwaj Raju wrote:
> The inconsistency error path calls print_string_as_lines, which calls
> console_lock, which is a potentially-sleeping function and so can't be
> called in an atomic context.
> 
> Replace calls to it with the nonblocking variant which is safe to call.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

Looks good, applying.

> ---
>  fs/bcachefs/error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
> index b885bd92834c..baf5dfb32298 100644
> --- a/fs/bcachefs/error.c
> +++ b/fs/bcachefs/error.c
> @@ -34,7 +34,7 @@ bool __bch2_inconsistent_error(struct bch_fs *c, struct printbuf *out)
>  				   journal_cur_seq(&c->journal));
>  		return true;
>  	case BCH_ON_ERROR_panic:
> -		bch2_print_string_as_lines(KERN_ERR, out->buf);
> +		bch2_print_string_as_lines_nonblocking(KERN_ERR, out->buf);
>  		panic(bch2_fmt(c, "panic after error"));
>  		return true;
>  	default:
> @@ -71,7 +71,7 @@ static bool bch2_fs_trans_inconsistent(struct bch_fs *c, struct btree_trans *tra
>  	if (trans)
>  		bch2_trans_updates_to_text(&buf, trans);
>  	bool ret = __bch2_inconsistent_error(c, &buf);
> -	bch2_print_string_as_lines(KERN_ERR, buf.buf);
> +	bch2_print_string_as_lines_nonblocking(KERN_ERR, buf.buf);
>  
>  	printbuf_exit(&buf);
>  	return ret;
> -- 
> 2.49.0
> 

