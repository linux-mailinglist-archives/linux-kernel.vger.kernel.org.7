Return-Path: <linux-kernel+bounces-879578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59FC23810
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13B504E4E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB52326D70;
	Fri, 31 Oct 2025 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LdhKy/wb"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932D126F0A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894670; cv=none; b=RxC6hSbTfWnLnKEJrbNzVWXZQqAJ8MRxrnSKk/iNjQfgVOjDkDIqoQoMzVPRDYR6mPeHMLW8za6v9fjvuWL8GPfVJkYS7VH93cnrdhl+NLLx2js3Yf2+dBgvBYmYxsvvEh5vtHGE6TkVk8nOqUCHqMlFVCS47wzevs7M0Kx0srY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894670; c=relaxed/simple;
	bh=kn5IlNskVWiWEIxTKucMN0laetjolyyoeeDjidy5ioA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klK4ANaMP8uGct8dOXCghKpIZRN9vgFuW3r+76+sorEvUHbSu2dAi2ZnptaAhjiKTQQll8Gi4UdBE6TD9sTegllqg10qhNEjSVJiI3NHgUd85TezVAKGyH3PGCSDxPtSdWC/Ht7OKsLRqtQ0h6T6EVYiC2ID8VE4BbM1FTm9kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LdhKy/wb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42855f80f01so287036f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761894663; x=1762499463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8osoMKeQmvxx6gG177xOJBtkaCzMSiR723YzVsYSSQ=;
        b=LdhKy/wbsyb1+UNhY7xBNKl3h9yYfvZ+XpZEr1O/+dduxO6HsUSw0Mp6cewkmYbuL6
         KrG0TJ7u4l7gh8ViNOEWe4gXVKiuimfHNH2ZhjcbEGfD62lSTJTQ/nBKBLZ0j7iKL1km
         Lyou3OfkGXwnNs9OFdFDLciXqvb3jl5kjLz/IjMndMrHLan9+G85n6we1ur60ZrMy/Pn
         eqcXPCN14b9ITDWv5w95n9SB5WF7svaVcTkdGpQ8xLfes+JdPZ0rzzy9AwXsDXAHFX3B
         Z4vg2vITg0u8y+4I6n+py3g7P4dTgDPcB/7lDofmK93fnAp6bg8PQV8jGkbUB+BdNoD5
         lvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894663; x=1762499463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8osoMKeQmvxx6gG177xOJBtkaCzMSiR723YzVsYSSQ=;
        b=r6QOjuhEI5Qfk0bP+zufuScR4XB/0RJ0XfSYKlh8+GWDP+St9xf05TOTf+jd1GLYug
         ThqQ/ks9j3RAJQo+VNj5F4spzArNu9zE1sMr+MPtOHq6BEMG5xWYqZjs32vVAahPb3SR
         01lTXijoXdNWTWDd+ci1tADBHqQnoJ2MEAFuk9AKwvjbyFpCsbl+GgOvgXITwUoCxIAz
         8IKDH2fUv9OeICTmtdagz//yqXjLzOboXUfDBmNKePCSU0frvZOE2nGKj1Boob+zOHBs
         oMfZTevbVmUA3d3P/OYYboTVlFHxrbVay40/TMpW+CeDGK3iXKOO1iXHLTLXQCvRNSQq
         8WIg==
X-Forwarded-Encrypted: i=1; AJvYcCX59xSAFNS/Notw8f+TJZSM0Q28q/as7xM+RcO/dhkIlnbYXQr1X0bBpgsxUsYWpQCtt5vYZQ+8YnAF9wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QsrAwnd0p7EAXgGwYU9uwTWEdla7jBB0lBNTPkaW7j89Mm3O
	CaztmNiHVF3yrsQv8EOJzN0+JvrFlS0aNWrbhJM33xqdYxf3j4zDL1Cecsarxpb6FtI=
X-Gm-Gg: ASbGncu3XFiwzTTg/StYUoNIycvdT9Pd5km2z0uy+OGJ6ISpoJEkRBYJE5EOKOcSTC/
	CMMqkdukz7Rxm9hj4fjIdJSOmf1vCFDJ9KkcCzooYQAcL06UqGX5QYBV01rScGVl1bp/M7UZxaS
	/iueUi9B2qoO750NHBi+quSn3foXdXw93b0ZY6GJWmYq0bWWcrl4pIwRFl6VVmmIjxLfGiQHJPF
	Mw5pilMU2J07SCNlBRGdi4kcqXAcOkMd4DsobW/d5/X19lisw4RTmKtxSkP/gGoW5SbNk/EOfvV
	QgBJEKWLRYl80RtswbsvhQcjdW8I/1OtzgAqaOYhnh95ck1t7Rnqq2bmaCnBB4r+fCwpUaumOVE
	g82124A3RWZYVRowtn3OKWVyrQ2u+1/Jb+SP/0irEqaKQUIBb3dT38fF5QlGhlQXKydyaaRJqPC
	izIkLG2+khplya72wPTnsd
X-Google-Smtp-Source: AGHT+IH/ggqC2kFzF5qNk5oWgmUdprKKn0CIGlZ1KxCeItmWJR8Y3WxA5x1dXDm+hMEnFGS0dEf7YQ==
X-Received: by 2002:a05:600c:468e:b0:46f:ab96:58e9 with SMTP id 5b1f17b1804b1-477302d3684mr10577625e9.0.1761894663096;
        Fri, 31 Oct 2025 00:11:03 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db678f67sm1058382b3a.57.2025.10.31.00.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:11:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:10:59 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [RFC RFT PATCH] ocfs2: Mark inode bad upon validation failure
 during read
Message-ID: <2wxmaoytqyztwxjmeiq5427o572passabvpfndj77rywsrrc6g@5uoztrgzqnor>
References: <20251029225748.11361-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029225748.11361-2-eraykrdg1@gmail.com>

On Thu, Oct 30, 2025 at 01:57:49AM +0300, Ahmet Eray Karadag wrote:
> Potentially triggered by sequences like buffered writes followed by
> open(O_DIRECT), can result in an invalid on-disk inode block 
> (e.g., bad signature). OCFS2 detects this corruption when reading the
> inode block via ocfs2_validate_inode_block(), logs "Invalid dinode",
> and often switches the filesystem to read-only mode.
> 
> Currently, the function reading the inode block (ocfs2_read_inode_block_full())
> fails to call make_bad_inode() upon detecting the validation error.
> Because the in-memory inode is not marked bad, subsequent operations
> (like ftruncate) proceed erroneously. They eventually reach code
> (e.g., ocfs2_truncate_file()) that compares the inconsistent
> in-memory size (38639) against the invalid/stale on-disk size (0), leading
> to kernel crashes via BUG_ON.
> 
> Fix this by calling make_bad_inode(inode) within the error handling path of
> ocfs2_read_inode_block_full() immediately after a block read or validation
> error occurs. This ensures VFS is properly notified about the
> corrupt inode at the point of detection. Marking the inode bad  allows VFS
> to correctly fail subsequent operations targeting this inode early,
> preventing kernel panics caused by operating on known inconsistent inode states.
> 
> [RFC]: While this patch prevents the kernel crash triggered by the reproducer,
> feedback is requested on whether ocfs2_read_inode_block_full() is the most
> appropriate layer to call make_bad_inode(). Should this check perhaps reside
> within the caller or should the error propagation be handled differently?:
> Input on the best practice for handling this specific VFS inconsistency
> within OCFS2 would be appreciated.
> 
> Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>

LGTM.
There are some review comments in this mail thread; anyone who is interested
in them can check them:
https://lore.kernel.org/all/20251029225748.11361-2-eraykrdg1@gmail.com/T/

Reviewed-by: Heming Zhao <heming.zhao@suse.com>
> ---
>  fs/ocfs2/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..415ad29ec758 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1690,6 +1690,8 @@ int ocfs2_read_inode_block_full(struct inode *inode, struct buffer_head **bh,
>  	rc = ocfs2_read_blocks(INODE_CACHE(inode), OCFS2_I(inode)->ip_blkno,
>  			       1, &tmp, flags, ocfs2_validate_inode_block);
>  
> +	if (rc < 0)
> +		make_bad_inode(inode);
>  	/* If ocfs2_read_blocks() got us a new bh, pass it up. */
>  	if (!rc && !*bh)
>  		*bh = tmp;
> -- 
> 2.43.0
> 
> 

