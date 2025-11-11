Return-Path: <linux-kernel+bounces-894519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F9C4B39C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 283CA4E77FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6134887B;
	Tue, 11 Nov 2025 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZKj9v3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA10348463
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828499; cv=none; b=Mt58o5A28UxYusjaRjl+fJAp0qUL+H2b2t3/i2kuIO4iQoNILtqMgGNm/SX0JsSO6fZf4XWnKYaPzYp5K6Rj9A7LfGvl2vgZl/AvQ9hq4ThElnHvmGwspwH11I23g8IEZp3NP2tONzPGJBgMmK7c9DnQ+Sxtv5WUlUgGfNgx8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828499; c=relaxed/simple;
	bh=BiMHxid1jaG9NDvHJhJEExI1o6/kusuFOPTB96uo4CQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JwTUl3ACxxd52+SeigCPFTqgPiibgpEk6UlzhCzpxeKv1pl/Y0dv1+3vx36qhgOnVG5NXAojXGiPGi6orZ5BUc7nc1BjcZzyk3VGtwkPdT7KgeVd7fH6incJMxERS1DN5FBokFVhbJsJU3AWxIRzcqw6NskWWZXtJHi3ZgG4sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZKj9v3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34876C4CEF5;
	Tue, 11 Nov 2025 02:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828498;
	bh=BiMHxid1jaG9NDvHJhJEExI1o6/kusuFOPTB96uo4CQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aZKj9v3zYl/YseT3MnYn+Q0VLJip7AWLZGMCfvo6FUzlcvAmXF47No3x4inLDijNm
	 cv5T+jdIc7J/6ndWBoCBv7NCR8LVf8SxeZ2em/O4pJX2zLc2bLUUwCathMcrNIvKA9
	 X8VHHzS0trO10IkPul0yG8qwNslq8J0zHL5zBzMkQWFB0M5il9RJohtTHwJlWjwc5v
	 vqkEpX5Kgh5V4oq4vR98z/qhpDFJxmPOqsu/e2K+1n1rMrrFGO3rXujF05+u4qgTQQ
	 mJ4F5hFyb63rnP5nb7GfkSA/aXjkc1btn6nXYEZrKLvaN5e4WiMbauIvQNKX24jQEt
	 EY6DKuPJF1ltQ==
Message-ID: <0cc190c7-a069-48da-9847-7ee597616f09@kernel.org>
Date: Tue, 11 Nov 2025 10:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6] f2fs: revert summary entry count from 2048 to 512 in
 16kb block support
To: Daeho Jeong <daeho43@gmail.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20251110153519.2852720-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251110153519.2852720-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Daeho,

As Zhiguo's reminder, I missed that f2fs_update_meta_page() has the same issue as well,
so we need to use f2fs_grab_meta_folio() in f2fs_update_meta_page() as well.

Thanks Zhiguo for code review and reminder.

Let me know if I missed something.

On 11/10/25 23:35, Daeho Jeong wrote:
>  void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
>  					void *src, block_t blk_addr)
>  {

struct folio *folio;

if (SUMS_PER_BLOCK == 1)
	folio = f2fs_grab_meta_folio(sbi, blk_addr);
else
	folio = f2fs_get_meta_folio_retry(sbi, blk_addr);

> -	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
> +	struct folio *folio = f2fs_get_meta_folio_retry(sbi, blk_addr);
> +
> +	if (IS_ERR(folio))
> +		return;
>  
>  	memcpy(folio_address(folio), src, PAGE_SIZE);
>  	folio_mark_dirty(folio);
> @@ -2720,9 +2723,21 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
>  }
>  
>  static void write_sum_page(struct f2fs_sb_info *sbi,
> -			struct f2fs_summary_block *sum_blk, block_t blk_addr)
> +		struct f2fs_summary_block *sum_blk, unsigned int segno)
>  {
> -	f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
> +	struct folio *folio;
> +
> +	if (SUMS_PER_BLOCK == 1)
> +		return f2fs_update_meta_page(sbi, (void *)sum_blk,
> +				GET_SUM_BLOCK(sbi, segno));
> +
> +	folio = f2fs_get_sum_folio(sbi, segno);
> +	if (IS_ERR(folio))
> +		return;
> +
> +	memcpy(SUM_BLK_PAGE_ADDR(folio, segno), sum_blk, sizeof(*sum_blk));
> +	folio_mark_dirty(folio);
> +	f2fs_folio_put(folio, true);
>  }


