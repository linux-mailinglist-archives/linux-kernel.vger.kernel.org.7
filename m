Return-Path: <linux-kernel+bounces-593113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5BA7F558
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 08:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E22E3B6744
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C4625FA1D;
	Tue,  8 Apr 2025 06:54:53 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA925FA14;
	Tue,  8 Apr 2025 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095293; cv=none; b=lkrvFAj+i4+ukm7iqTfy7YTFVPsiPFPELrQDDBgzCAQ/jCZm6E6q+OdvMN2Czxsoql1+6H0QGEApm5SXOTH14ntM81w/t20DtDyggfzKQgDlKsSkw4cZ9rX2hEV7A7f2wOmG8Mxfj7Irq7yN9Gmx7kbYp5ZC3iuxtlLzRhvgdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095293; c=relaxed/simple;
	bh=IcEyZClMGD4C/NJt3DeJJ3OwwaNadWRTAclqaNX1ruQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPRvoM+N/1UeJrl2gdiuElyrlEfSMs6VDTtD9L5zrcOvUDKPOdaNwCwL+FI2IW+9YEd9YXehthdzQIH55WHU6yXYTF0Rjk8tasfNJQumeqn29uhBLqvBZv8eTh50cUZ50A/B0DJWAgAka4Cq7PWluCAkdozAImc2ZTlYVDTsKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 53864Z7Y046352;
	Tue, 8 Apr 2025 15:04:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 53864YBH046349
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 8 Apr 2025 15:04:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <77b1b228-3799-43e3-ab30-5aec1d633816@I-love.SAKURA.ne.jp>
Date: Tue, 8 Apr 2025 15:04:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] gfs2: replace sd_aspace with sd_inode
To: Andreas Gruenbacher <agruenba@redhat.com>, cgroups@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Rafael Aquini <aquini@redhat.com>,
        gfs2@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407182104.716631-1-agruenba@redhat.com>
 <20250407182104.716631-2-agruenba@redhat.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250407182104.716631-2-agruenba@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav401.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/04/08 3:21, Andreas Gruenbacher wrote:
> @@ -1156,6 +1146,18 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NOSEC;
>  	sb->s_magic = GFS2_MAGIC;
>  	sb->s_op = &gfs2_super_ops;
> +
> +	/* Set up an address space for metadata writes */
> +	sdp->sd_inode = new_inode(sb);
> +	if (!sdp->sd_inode)
> +		goto fail_free;
> +	sdp->sd_inode->i_ino = GFS2_BAD_INO;
> +	sdp->sd_inode->i_size = OFFSET_MAX;
> +
> +	mapping = gfs2_aspace(sdp);
> +	mapping->a_ops = &gfs2_rgrp_aops;
> +	mapping_set_gfp_mask(mapping, GFP_NOFS);
> +
>  	sb->s_d_op = &gfs2_dops;
>  	sb->s_export_op = &gfs2_export_ops;
>  	sb->s_qcop = &gfs2_quotactl_ops;

This will be an inode leak when hitting e.g.

	error = init_names(sdp, silent);
	if (error)
		goto fail_free;

path, for what free_sbd() in

fail_free:
	free_sbd(sdp);
	sb->s_fs_info = NULL;
	return error;

path does is nothing but free_percpu() and kfree().


