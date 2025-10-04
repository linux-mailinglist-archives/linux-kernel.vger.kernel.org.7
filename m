Return-Path: <linux-kernel+bounces-842108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA39BB8FC9
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310DF189BBCD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FB27EC73;
	Sat,  4 Oct 2025 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w8Z/V12z"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5D23C8AA
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594918; cv=none; b=n9rXAXqQiP624HVZVT8Wf1sySV9eNY5AqXk4+cNZltvaUNqA03I0D+HITpRVEx2qbhBkIwPjgtlBOjBetKyJfev0/lQ7qeTNSH+rIz8uudOCIqKe8F8o3AmUjYkPy1V6LJrFTqQfQmxkVneD/2h1fD/2FmxNjz39xLiPV245zLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594918; c=relaxed/simple;
	bh=uZurdSC0sqjRe3V/HgAi/JYCuQEpRNbx91JHlCTwTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMn3XDZ//Efxc/IjIp4bK81ixM2wZAwS0MxnVu8v1E0DvPN96TKqR5AEXJJyhEzDqkwa9jIElwD4ymgfg127SrUWhYsHGs5Olu4hqyNUKI26U2cqGFfYk+A6DmngPC4GEO22/JYUBZGDduWX7m9+1Nl5tvX4KYE0b88HXArMY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w8Z/V12z; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 4 Oct 2025 12:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759594902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psoPj0yxyJUwCnm4KRKDccQVISxqX4KV4LLtuF1Uggc=;
	b=w8Z/V12zsgJi9JjsPYWf0hTPpTixDhBXgbfyC1umqM40/Tm4rPxKja+T0KUtjJT1VBglAT
	Ul3AU71vCUM5pDJWPbQpG9ffdlt5C4ZZXFCm6bfOc8eTS6ppu8mOhAh47nyFoNcyPEX8ug
	jOCpqHVYCHtXW3hu4djk0YSIxDGhHW4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] bcachefs: fix use-after-free in bch2_dirent_to_text()
Message-ID: <suouhqf3so43qperydsoykxiqglasg45boxjimbsarsz72jqr2@lf47oxtlcand>
References: <20251002231033.23810-1-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002231033.23810-1-nirbhay.lkd@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 04:40:33AM +0530, Nirbhay Sharma wrote:
> Add bounds checking before calculating pointer offsets in dirent name
> accessor functions to prevent out-of-bounds memory access when
> processing corrupted filesytem metadata.
> 
> When d_name_len contains a corrupted value, the pointer calculation
> &d.v->d_cf_name_block.d_names[name_len] results in an offset far
> outside the dirent structure, triggering KASAN use-after-free erors.

We validate d_name_len in bch2_dirent_validate(), so... this looks
entirely bogus.

Did you test any of this?

> 
> While bch2_dirent_validate() detects such corruption,
> bch2_dirent_to_text() may still be called for debug output, so the
> accessor functions must handle invalid data gracefully.
> 
> Fixes: c21f41f6905be4fc5059a10a5bba94105ba87269 ("bcachefs: bch2_dirent_to_text() shows casefolded dirents")
> Reported-by: syzbot+7f176adb30b21606c5fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7f176adb30b21606c5fc
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  fs/bcachefs/dirent.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/bcachefs/dirent.c b/fs/bcachefs/dirent.c
> index d198001838f3..8be31b41c32b 100644
> --- a/fs/bcachefs/dirent.c
> +++ b/fs/bcachefs/dirent.c
> @@ -58,8 +58,16 @@ static unsigned bch2_dirent_name_bytes(struct bkey_s_c_dirent d)
>  
>  struct qstr bch2_dirent_get_name(struct bkey_s_c_dirent d)
>  {
> +	unsigned int name_len, max_len;
> +
>  	if (d.v->d_casefold) {
> -		unsigned name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
> +		name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
> +		max_len = bkey_val_bytes(d.k) -
> +			offsetof(struct bch_dirent, d_cf_name_block.d_names);
> +
> +		if (name_len > max_len)
> +			return (struct qstr) QSTR_INIT(NULL, 0);
> +
>  		return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[0], name_len);
>  	} else {
>  		return (struct qstr) QSTR_INIT(d.v->d_name, bch2_dirent_name_bytes(d));
> @@ -68,13 +76,19 @@ struct qstr bch2_dirent_get_name(struct bkey_s_c_dirent d)
>  
>  static struct qstr bch2_dirent_get_casefold_name(struct bkey_s_c_dirent d)
>  {
> -	if (d.v->d_casefold) {
> -		unsigned name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
> -		unsigned cf_name_len = le16_to_cpu(d.v->d_cf_name_block.d_cf_name_len);
> -		return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[name_len], cf_name_len);
> -	} else {
> +	unsigned int name_len, cf_name_len, max_len;
> +
> +	if (!d.v->d_casefold)
>  		return (struct qstr) QSTR_INIT(NULL, 0);
> -	}
> +
> +	name_len = le16_to_cpu(d.v->d_cf_name_block.d_name_len);
> +	cf_name_len = le16_to_cpu(d.v->d_cf_name_block.d_cf_name_len);
> +	max_len = bkey_val_bytes(d.k) - offsetof(struct bch_dirent, d_cf_name_block.d_names);
> +
> +	if (name_len > max_len || cf_name_len > max_len || name_len + cf_name_len > max_len)
> +		return (struct qstr) QSTR_INIT(NULL, 0);
> +
> +	return (struct qstr) QSTR_INIT(&d.v->d_cf_name_block.d_names[name_len], cf_name_len);
>  }
>  
>  static inline struct qstr bch2_dirent_get_lookup_name(struct bkey_s_c_dirent d)
> @@ -212,11 +226,18 @@ void bch2_dirent_to_text(struct printbuf *out, struct bch_fs *c, struct bkey_s_c
>  	struct bkey_s_c_dirent d = bkey_s_c_to_dirent(k);
>  	struct qstr d_name = bch2_dirent_get_name(d);
>  
> +	if (!d_name.name || !d_name.len) {
> +		prt_str(out, "(invalid)");
> +		return;
> +	}
> +
>  	prt_printf(out, "%.*s", d_name.len, d_name.name);
>  
>  	if (d.v->d_casefold) {
> -		struct qstr d_name = bch2_dirent_get_lookup_name(d);
> -		prt_printf(out, " (casefold %.*s)", d_name.len, d_name.name);
> +		struct qstr d_cf_name = bch2_dirent_get_lookup_name(d);
> +
> +		if (d_cf_name.name && d_cf_name.len)
> +			prt_printf(out, " (casefold %.*s)", d_name.len, d_name.name);
>  	}
>  
>  	prt_str(out, " ->");
> -- 
> 2.51.0
> 

