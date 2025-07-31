Return-Path: <linux-kernel+bounces-751512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856EB16A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43651AA0B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFE21DA60D;
	Thu, 31 Jul 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALoEcrxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7248F6C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929445; cv=none; b=m8YzaSMCN4XvPZyqzUv/dsT0P6CJpr9Lv4RO/0M23S6+rg7NaHA+i7rHSLZRBFDQqDZagTm8ns6QPBSTkl5SDGy4FYk0lFQzPGrfE5dKoBI/6OB6xwN3xX/gzKXnhIHvU43vmsm9YiEyijhh4OW0+BgmnWUOZQluMEJ1vgBi8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929445; c=relaxed/simple;
	bh=95Q2MQJpejoNqVfRLbKKN1BDQdWqt3GGKYHfRa8niks=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cbr4O4fcvdemmchrgx/kYK/WsdqjTjs4kt3JUAvvZwTjFqrmGNW32DOERTR0huiAmZj3wW73OYJZPXTun/hASgPsI1T4yhIbmBU3dYp8qYXwAy2d+AtbqGpVp6KbEg4DkaVWn+Gn6jz9a1XBtZhW5EV71e6lHRBan71jn9Ozss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALoEcrxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34767C4CEE7;
	Thu, 31 Jul 2025 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753929444;
	bh=95Q2MQJpejoNqVfRLbKKN1BDQdWqt3GGKYHfRa8niks=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ALoEcrxD4fHEKfPUeLT+tI52XqhS2dGCVPl5Oq3VQweLKIhuOKMLI0w0e0l7l7HiD
	 4L1Bg+ou/Xd6N86Ny+MZGuCKJdwu8cUE3qYeHraQXOFd4Qe88wqVhSzwHfMkkKyf/z
	 +9SPnPqFeyxG8In/cVn1ZrnjqhZD4Jw30awjVxcJujCNE3cjvpjdZ6J7AElj1Oh7Yl
	 Su86DA2oKWpy5RyFraVaRwbzD3a9vN/SbAxvDkDYGni+PMi8vL2SGn3oEHNZtt+Rgb
	 oRIPvkcNRII4lgFFGhMHbiLr41xTI4X3ip+1XSCoRI/kq6EA8kbuxZ1gmJBYlG+efF
	 lbHOEd2Fclg1w==
Message-ID: <80904609-92b2-4e91-846d-d0c1c1afb513@kernel.org>
Date: Thu, 31 Jul 2025 10:37:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add error checking in do_write_page()
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250730100633.26292-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250730100633.26292-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 18:06, mason.zhang wrote:
> Otherwise, the filesystem may unaware of potential file corruption.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> ---
>  fs/f2fs/segment.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ae1223ef648f..10aaa32defca 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3936,12 +3936,17 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  	int seg_type = log_type_to_seg_type(type);
>  	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
>  				seg_type == CURSEG_COLD_DATA);
> +	int err;
>  
>  	if (keep_order)
>  		f2fs_down_read(&fio->sbi->io_order_lock);
>  
> -	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> -			&fio->new_blkaddr, sum, type, fio)) {
> +	err = f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> +			&fio->new_blkaddr, sum, type, fio);
> +	if (unlikely(err)) {
> +		f2fs_err_ratelimited(fio->sbi,
> +			"%s Failed to allocate data block, ino:%u, type:%d, err:%d",
> +			__func__, fio->ino, type, err);

Can we print page->index, old_blkaddr, new_blkaddr as well?

Thanks,

>  		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
>  			fscrypt_finalize_bounce_page(&fio->encrypted_page);
>  		folio_end_writeback(folio);


