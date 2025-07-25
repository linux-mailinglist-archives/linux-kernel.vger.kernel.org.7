Return-Path: <linux-kernel+bounces-745199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B23B11680
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E773AEA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A5233156;
	Fri, 25 Jul 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttOQypxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF71C84D0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410917; cv=none; b=To1iDnfvPIIx6UCJiU//KPJeI8SFWLFtYEHEd72td16t/0Bky+YXOrti/QFw90vTekuvPFUbbLMW0QzxC7Gtnc/Hau0CocwnRxtNF638XJ3OaTdllWJtPJ0yR1Mh5OyRsGTJi3n24T8B5Jo+e6VMDlpH+Hjn2WUszTE19fInupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410917; c=relaxed/simple;
	bh=nXuW9sDa5fC2gjkR2Eriw7Oer+0cOQXO3yyiZOpDSqE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r9iMlNK65uvr7Qy7U61IJ1FYxRC4NHue0kZgTN37RpnG8Oh+YnxV/G08u9nALYprzEG9u7X61qyjJ/uvzQOavY5Ye83ZX/y9Fp+ezLwA2MnHSQvyBf+NUZmrWx8B2NPMefDbBPBl9rYUnQgWdfJ+fclWSg1ntK6vEgNC7QlEOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttOQypxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD8AC4CEED;
	Fri, 25 Jul 2025 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753410915;
	bh=nXuW9sDa5fC2gjkR2Eriw7Oer+0cOQXO3yyiZOpDSqE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ttOQypxnERjidL92dpoIX/V3exOZqYncnxNEdw07WfdSWS4X30K9fA99Un557DguI
	 LIi27+roBMQ8r5TTalkdyyd+lvsdDcgttNR3D0cg9twhPr+7Gw8MVf4/wfRi8dW+p9
	 b0H8RtR3tAO9SkxYxhdmDQn8jQXv32t+/S0C4FoYOdYM1zfr3mnPs+smFC62S4QFIE
	 hzw7vbx6fMm/8aXS2cx9ok8Xjnz07xmAogX1vT2XFFmw3YdjAujR2lB7fYg162sjPy
	 FuTGbDjiSZrQuygVxmG5469fXkogDWsEpviPkhz1e3yN75vww23EIuOldLycT9Gkul
	 kwiRtiMRhOuig==
Message-ID: <68c1c92b-5c29-49b9-a8af-916e5293c80e@kernel.org>
Date: Fri, 25 Jul 2025 10:35:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: add error checking in do_write_page()
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250724155945.206801-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250724155945.206801-1-masonzhang.linuxer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2025 11:59 PM, mason.zhang wrote:
> Otherwise, the filesystem may unaware of potential file corruption.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> ---
>   fs/f2fs/segment.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ae1223ef648f..ce80ba226aed 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3936,12 +3936,15 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>   	int seg_type = log_type_to_seg_type(type);
>   	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
>   				seg_type == CURSEG_COLD_DATA);
> +	int err;
>   
>   	if (keep_order)
>   		f2fs_down_read(&fio->sbi->io_order_lock);
>   
> -	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> -			&fio->new_blkaddr, sum, type, fio)) {
> +	err = f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> +			&fio->new_blkaddr, sum, type, fio);
> +	if (unlikely(err)) {
> +		f2fs_err(fio->sbi, "Failed to allocate data block(%d)", err);

How about using f2fs_err_ratelimited() to avoid too many logs?

Can you please dump more informations about inode, page, blkaddr...?

Thanks,

>   		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
>   			fscrypt_finalize_bounce_page(&fio->encrypted_page);
>   		folio_end_writeback(folio);


