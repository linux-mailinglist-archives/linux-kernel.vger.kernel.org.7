Return-Path: <linux-kernel+bounces-706921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A9AEBDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECA4561147
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42A2EA174;
	Fri, 27 Jun 2025 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MtYBq51o"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525D213245
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042656; cv=none; b=f8wcU3Pzh5+L3Wt6mRUvD0oMiEHijZdbACOZAb0nefXrttW/bFwZhbrl8550P2sZPGR57jY+eyhD1G+PNifnGudF1KZPCHBMxwr7wUmwaiDlTvyBEDuKmGWJYow8keFe7KwdOB4izGILSana3Td6OWwP/7a42IidYergH4NGGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042656; c=relaxed/simple;
	bh=9JuT24Jt1TfzmdzvF1YRe4F12Aw7Jg/Tjq5Advn0a54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgH7ifraIIXcir05ey/bMHPTxJzRIeq6xekr4juF+kMFtg4k3VKkvtH6pzqyjeAKWbzMwq78gWQntz3M/b2tFGKbHyFBriXV1s6YCzRpgERPdJ5P60LcwFVsRx8siEhxOO1zyvK7a/ws8VVFRg+vQ7xO523hqMoR9M39DvRCxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MtYBq51o; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Jun 2025 12:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751042650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkQA0fiVE8x7JmWLoFfANKvXUmImex8cGKIZzt/XthE=;
	b=MtYBq51ov3LaFBViHq8Av23Ya9tGlg7j+ZXO5fr5wyCfJ+O1IY5lDw4L7DCeZ2Lw8g3+tu
	opX4aCjX0JoSlcnbEvD5EdxomcL8tr6xBJh7UN+YFTotNlgTv3PEP2V9VlC6GEPs+jB1CV
	jcTEkt+9uSv2JxC8jsYGKOxtrrcbSN0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+029d1989099aa5ae3e89@syzkaller.appspotmail.com
Subject: Re: [PATCH] bcachefs: mark invalid_btree_id autofix
Message-ID: <yt5mhonz4bx5yimh4hqo34npoj32ijjaze36kz5tpwb7zyfbcg@5ooxumirmduv>
References: <20250627164132.25133-1-bharadwaj.raju777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627164132.25133-1-bharadwaj.raju777@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 27, 2025 at 10:11:29PM +0530, Bharadwaj Raju wrote:
> Checking for invalid IDs was introduced in 9e7cfb35e266 ("bcachefs: Check for invalid btree IDs")
> to prevent an invalid shift later, but since 141526548052 ("bcachefs: Bad btree roots are now autofix")
> which made btree_root_bkey_invalid autofix, the fsck_err_on call didn't
> do anything.
> 
> We can mark this err type (invalid_btree_id) autofix as well, so it gets
> handled.

Thanks, applied

> Reported-by: syzbot+029d1989099aa5ae3e89@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=029d1989099aa5ae3e89
> Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  fs/bcachefs/sb-errors_format.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/sb-errors_format.h b/fs/bcachefs/sb-errors_format.h
> index 0641fb634bd4..d154b7651d28 100644
> --- a/fs/bcachefs/sb-errors_format.h
> +++ b/fs/bcachefs/sb-errors_format.h
> @@ -314,7 +314,7 @@ enum bch_fsck_flags {
>  	x(accounting_mismatch,					272,	FSCK_AUTOFIX)	\
>  	x(accounting_replicas_not_marked,			273,	0)		\
>  	x(accounting_to_invalid_device,				289,	0)		\
> -	x(invalid_btree_id,					274,	0)		\
> +	x(invalid_btree_id,					274,	FSCK_AUTOFIX)		\
>  	x(alloc_key_io_time_bad,				275,	0)		\
>  	x(alloc_key_fragmentation_lru_wrong,			276,	FSCK_AUTOFIX)	\
>  	x(accounting_key_junk_at_end,				277,	FSCK_AUTOFIX)	\
> -- 
> 2.50.0
> 

