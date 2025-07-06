Return-Path: <linux-kernel+bounces-715799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CDEAF7E03
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 18:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0918B189B24D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4E6257ACA;
	Thu,  3 Jul 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uoNcvSGR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/gcLuIxC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uoNcvSGR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/gcLuIxC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7D226D02
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560597; cv=none; b=rQpiRfO0THz7aDUtuXXXIPbymh9e5yUFX+x8FpDlFs4o+0Nt0K5lYEQxErSX8+D4Q9Ctbgfx0tZUJ58fwDNY72OfMdQHcJRQCC4ds3ZC9tcwO5LqVfwjtT+mgSNMDio/I9mW5mAppqtkIZYfO7rtl5nflT629ag8CYtmCMaUfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560597; c=relaxed/simple;
	bh=zpkHQu5pf9tXYgwlRfC5iwGBkfyQpnz+ReA1cH5U0tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEcT7pkZAN9XxizyHSTNzvO4IVcBQuwuR56HmaqltB0IHBC3+XK6tTxOXwzVcw1/Jb/GS4Mi6xTcX/pFJZFUUfmJGCsg8XG8X11Qwzy8wdgPr5B1eHLm8/+qI8E0/gJVspObYq692SlUqz7uGz/86Kd1AGuv2CbY5sh1DrBKU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uoNcvSGR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/gcLuIxC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uoNcvSGR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/gcLuIxC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48ADF1F387;
	Thu,  3 Jul 2025 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gha886q83QNHHfaeqtJBn/R0Pt8WcTJFp/jUF+wQ530=;
	b=uoNcvSGRrNEuA+HbaXTFNY8uHSq66BtY/FcmEC9q4UD8ljF2ax3L779f+roLqY+iBOcn8O
	vIJygXnPGV8yGGa4ant1JSfvHe6Ecdw5ClSbJ9jz7EOzdP+g7H3O42/kaOCcTfklf2WN2z
	kkUXbqnOhYbzRQGioLpekzZgK/AhzcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gha886q83QNHHfaeqtJBn/R0Pt8WcTJFp/jUF+wQ530=;
	b=/gcLuIxCFdWe/+zBPApp0vU4KaCeAZy1Lyp0/iIUfI7T+tG2/ItIIAEhcz1VWMc31ad/Wn
	ecfIFxyxmKnRX1DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gha886q83QNHHfaeqtJBn/R0Pt8WcTJFp/jUF+wQ530=;
	b=uoNcvSGRrNEuA+HbaXTFNY8uHSq66BtY/FcmEC9q4UD8ljF2ax3L779f+roLqY+iBOcn8O
	vIJygXnPGV8yGGa4ant1JSfvHe6Ecdw5ClSbJ9jz7EOzdP+g7H3O42/kaOCcTfklf2WN2z
	kkUXbqnOhYbzRQGioLpekzZgK/AhzcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560594;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gha886q83QNHHfaeqtJBn/R0Pt8WcTJFp/jUF+wQ530=;
	b=/gcLuIxCFdWe/+zBPApp0vU4KaCeAZy1Lyp0/iIUfI7T+tG2/ItIIAEhcz1VWMc31ad/Wn
	ecfIFxyxmKnRX1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 375EF1368E;
	Thu,  3 Jul 2025 16:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 30t7DZKxZmg/DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Jul 2025 16:36:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC9D4A0A48; Thu,  3 Jul 2025 18:36:29 +0200 (CEST)
Date: Thu, 3 Jul 2025 18:36:29 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 1/2] ext4: show the default enabled i_version option
Message-ID: <l7xuy7lslsyvig3ji2yktrxpml67nhcawnq5yxccek4kdrp4a2@ntpla25pphqb>
References: <20250703073903.6952-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703073903.6952-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 03-07-25 15:39:02, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Display `i_version` in `/proc/fs/ext4/sdx/options`, even though it's
> default enabled. This aids users managing multi-version scenarios and
> simplifies debugging.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

OK, I guess it makes sense as a backward compatibility glue. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c7d39da7e733..9203518786e4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2975,6 +2975,8 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PRINT("min_batch_time=%u", sbi->s_min_batch_time);
>  	if (nodefs || sbi->s_max_batch_time != EXT4_DEF_MAX_BATCH_TIME)
>  		SEQ_OPTS_PRINT("max_batch_time=%u", sbi->s_max_batch_time);
> +	if (nodefs && sb->s_flags & SB_I_VERSION)
> +		SEQ_OPTS_PUTS("i_version");
>  	if (nodefs || sbi->s_stripe)
>  		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
>  	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

