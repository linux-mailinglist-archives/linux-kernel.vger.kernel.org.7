Return-Path: <linux-kernel+bounces-795378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D7B3F10D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E136207433
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756B283FE2;
	Mon,  1 Sep 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YI4G4ClR"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88C1E260D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756766315; cv=none; b=pyx+3jXMY88epFGGxkgRLNa997v23pq7d1G0Oo3rI1aKX72V3TTCjDw7BTD+9PDnSso60yNcIWJuKM1fFuFgbZ7Y1r3/u5/tfwrIIlcJ9wDasRkgRNyHZ3J0wqA9jXfP9hIdeF2IkQsoTRJ0MLnxG78T37mVCyrPXL84N7Wv7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756766315; c=relaxed/simple;
	bh=1LRvez7G23oqTs/cGke5PIZ0iR3nPJIjQ908hMTiBgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3ripBKAsUVdBAS7n02bGM9stSsr+lv2yCypRMrNDEqJHYhfJy4rVL4H6CzV0cVAuvw9vijCEuDIbvnnBNlLOEaXl1uLQ2KsZWmlp4NKtoA5ODfhPhAeEjxtrDJ8IwASk0juuH21v8Rteq5OdspIoAHjIPlUd2pJvTGW/NIfNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YI4G4ClR; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Sep 2025 18:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756766309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f8HUpFIh/zYnk5qDXxnDpvmui25C29SBF2HbCeY/aUU=;
	b=YI4G4ClRZlOSVYpa9Y2qlX5diZVzL2WE5Auc7+GOvEQImN8eqvf7giNmKTBMp37Nc/jogL
	dtrthaXXNpOpcWeprPgplaal+SJVBQU7e2Vt90ROMvn/IJeb2qyodK7LbayevwP3Sst6dw
	y+TqGlBSk53iUnmQXAKmhb9IsaU1Ut4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Use int type to store negative error codes
Message-ID: <wzcnnfwnjkrkbg7gj64cnddwxwcc5gw3jkv6356qmedjccitt4@3gsixqytzn2i>
References: <20250830135833.112327-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830135833.112327-1-rongqianfeng@vivo.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 30, 2025 at 09:58:33PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable in __bch2_dev_attach_bdev() from unsigned to
> int, as it needs to store either negative error codes or zero.
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Thanks, applied

> ---
>  fs/bcachefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index 793c16fa8b09..ec20ab0ad84e 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -1769,7 +1769,7 @@ static int bch2_dev_alloc(struct bch_fs *c, unsigned dev_idx)
>  static int __bch2_dev_attach_bdev(struct bch_dev *ca, struct bch_sb_handle *sb,
>  				  struct printbuf *err)
>  {
> -	unsigned ret;
> +	int ret;
>  
>  	if (bch2_dev_is_online(ca)) {
>  		prt_printf(err, "already have device online in slot %u\n",
> -- 
> 2.34.1
> 

