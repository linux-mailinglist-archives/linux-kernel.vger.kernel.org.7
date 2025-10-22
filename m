Return-Path: <linux-kernel+bounces-865785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C334BFE044
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87203A478A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7CB2E0406;
	Wed, 22 Oct 2025 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aWC2Nmak"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C692D6E7A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161004; cv=none; b=YTUdgGYzB/OdF0WwH6F8kZHOPj6gKl7jfEr7qG+ovF5He3WzmbN9d4zx51+ciY5fufScx3e6N5RCtUDmlZaD3Zy1xfz/w5MOkFIvLJlgrJXAAsLWp3sSQfuwC8yk+5RZ9eItiT4E5XIKZ1+MtJB1/GSy37xN3wpj8+2MBCVsNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161004; c=relaxed/simple;
	bh=+zElf0YtiFY1C/1VPVUToEirL7eZmjn6Q/ORZiCx4/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnWw9rqPID2xbR1b8//qdS+sLz7NNGFP7DRJAld8SRnXtTUKCBlEcJcxwPM9rMPjBQXHvLoKG+GLLOE/7ZP6rH/Vk5UGa0JXUcwP1jeI58CuNBTtWe8jrCTXxGnRpVUIGq6bip5eEXLj+nRTWi18amCgkvzdgEOSWAtSg30Zm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aWC2Nmak; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fQpsVIRus3OxUEYz+e6WK9b7X2zf3d+zoUWqTmrgHbA=; b=aWC2Nmak8mX44KF3tUNQvq3jSL
	IqCe/ac5Ch7u9Nj+L46wCGbzevtobfVFoB8tzONjQPZWSWKLCTNtj+lzYv1vT+THljPWOTa3kAWA7
	Q8XW/Q6cmzg3ArSE0D6V00o5OGmxaeAzc15LOpc71FVNo/Md0Vq0tX91ihHYDCI1788HD1EuzQY0q
	ikq5oRdCM9aQVkJ46+sRMO+qdD43tjgoAbrU769Tn2BAv+mR8Lb/xBUpFYoWocKgBZTE6g4k+DrGd
	h+N8+WFoMpY/cFj3WI5zkCcrjH5U0SQohu4CVfwlsznJnekFA9eyKES6qwEmvdiaszTpYRwZugZI9
	CX367Wcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBeQY-000000067PH-2x74;
	Wed, 22 Oct 2025 19:23:18 +0000
Date: Wed, 22 Oct 2025 20:23:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] replace strcpy with strscpy for safe copy
Message-ID: <20251022192318.GI2441659@ZenIV>
References: <20251021143952.37036-1-biancaa2210329@ssn.edu.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021143952.37036-1-biancaa2210329@ssn.edu.in>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 21, 2025 at 08:09:52PM +0530, Biancaa Ramesh wrote:

> diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
> index 0388a1bae326..cffb7863adc5 100644
> --- a/fs/ufs/dir.c
> +++ b/fs/ufs/dir.c
> @@ -557,14 +557,14 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
>  	ufs_set_de_type(sb, de, inode->i_mode);
>  	ufs_set_de_namlen(sb, de, 1);
>  	de->d_reclen = cpu_to_fs16(sb, UFS_DIR_REC_LEN(1));
> -	strcpy (de->d_name, ".");
> +	strscpy(de->d_name, ".", sizeof(de->d_name));
>  	de = (struct ufs_dir_entry *)
>  		((char *)de + fs16_to_cpu(sb, de->d_reclen));
>  	de->d_ino = cpu_to_fs32(sb, dir->i_ino);
>  	ufs_set_de_type(sb, de, dir->i_mode);
>  	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
>  	ufs_set_de_namlen(sb, de, 2);
> -	strcpy (de->d_name, "..");
> +	strscpy(de->d_name, "..", sizeof(de->d_name));
>  	kunmap_local(kaddr);

Hard NAK.  This kind of cargo-culting is completely pointless.

Think for a second.  Really.  We are creating "." and ".." entries in freshly
created directory.  What your change does is "if directory entry name couldn't
hold a 2-character string, we might have trouble".  No shit - we would.  Not of
the "overflow something" variety, actually, but there's not much use for a
filesystem that could only handle single-character filenames, is there?

What's worse, you are papering over a real subtlety here: directory entries on
UFS are variable-length.  There is a fixed-sized header (8 bytes), followed by
NUL-terminated name.  The size of entry is encoded in 16bit field in the header
(offset 4), and name (including NUL) must not be longer than entry length - 8.

struct ufs_dir_entry describes the entry layout, all right, with ->d_name[]
being the last member.  It is declared as
        __u8    d_name[UFS_MAXNAMLEN + 1];      /* file name */
which is to say, the longest we might need (255+1).  So your changes are basically
'check that "." or ".." aren't longer than 255 characters to make sure we are
memory-safe'.  However, that does *NOT* guarantee memory safety - the first
entry is actually only 12 bytes long, while the second one spans the rest of the
block.  What is relevant is "entry size is at least UFS_DIR_REC_LEN(strlen(name))",
which is true for both entries - the first one is explicitly UFS_DIR_REC_LEN(1)
bytes long, the second - block size - UFS_DIR_REC_LEN(1), which is going to be
greater than UFS_DIR_REC_LEN(2).  Block size is going to be over twenty four
bytes, after all...

What we ought to do is turning ->d_name into a flex array:
        __u8    d_name[];      /* file name, no more than UFS_MAXNAMLEN + 1 */
at which point your obfuscation^Wimprovement falls apart.

Note that
	* use of strscpy() here was *not* any safer than strcpy()
	* it _pretended_ to improve safety ("move along, nothing to look
at in this place"), but at the closer look result was a lot more fishy 
than the original; it reads as "we have 256 bytes there", which is simply
false.

This is not an improvement.

