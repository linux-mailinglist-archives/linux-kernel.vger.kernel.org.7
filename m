Return-Path: <linux-kernel+bounces-899156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DDDC56F04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9F104E5491
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67F330306;
	Thu, 13 Nov 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UL05eQ9E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4q6hYguq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1taCFmCQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t7hhpjaW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D12DCF44
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030417; cv=none; b=SdAW9tmcekGzHoDJ9Uv5LAB+Tz9vG1aIXz6LvoybmotI3wDDT6wgPwNnrGyVhP2uSC6Hd6U7MaYSn9RaaE+AtzHzFe2iFT44cGEUYs5flEh86pHKlZGYhVJuOf2ShBKB7MvHVxTP9Z9sgCmVrPM/pw7+rgg0bJP5cvYS8V0XSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030417; c=relaxed/simple;
	bh=oFtM/RJA2vjK64aLsgV5PYLE7ZBcFCsApCcF0fgunP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei8/e17trWcjYGWb3uQOfwmdGDbV3+2ww7kTlvFksy2O8FT5/CY0aLcl6RUX6X/HNYszMzxeZWViD6SnTYb9uf68TmeTWniMkbZw63BO6rc+xWaVYdhjcFwmG/oLsEx+0kr5UdyUuzuy+VsoQYATpd5qYxuKtCz3GWApmlM4NHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UL05eQ9E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4q6hYguq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1taCFmCQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t7hhpjaW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A06B8211B8;
	Thu, 13 Nov 2025 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763030414;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHCs8WTEXFDFe8GAtmQ3U0Hf0UabZt31Y55rbpHvvfo=;
	b=UL05eQ9EEVgLj5EAKL9Hi2hwJfEahc3idwOLjqzukRfj20izvB3eMi4MGkS0jYN0aLf1+x
	EfoVctK2+Tw5A8+2wbKjKNOHjvb+FTGe6boiXY96tj64ho+T3sfaHkECjCm32CCzcwX/Lk
	ZWs/onWNhASV/u4kki0gDVU+JeY3vYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763030414;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHCs8WTEXFDFe8GAtmQ3U0Hf0UabZt31Y55rbpHvvfo=;
	b=4q6hYguqXDiD9IrmP6BMrwhU0GgfwdOVbtTvMD5Etm60GnH1U4hShspEet3DABDXWLEoz2
	cs9yU0KZ2Z9miwDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763030413;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHCs8WTEXFDFe8GAtmQ3U0Hf0UabZt31Y55rbpHvvfo=;
	b=1taCFmCQumxFBYiIGZkpC/Ca2fU2djQouv+bj53YDRgxuHQ+7CW1bVlG6ul3tDYTJ+bIbu
	7qlyv90sYFU+N84xmzLEc4eiiQTWXzmQl5s1EKE6y5KrK1oDZ4Qti+TorQHuljjNsso6Ht
	jiwX+CE+r4+GzBOSAgx/KOXqaY0O6hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763030413;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lHCs8WTEXFDFe8GAtmQ3U0Hf0UabZt31Y55rbpHvvfo=;
	b=t7hhpjaW4KbQe5gTfWL/vhZcuL31xTxmteU/aWVbuAgbDFJjUqhuaTVGmRxiY/Qqp1EN+h
	MGgesPoCUu+80nBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8897E3EA61;
	Thu, 13 Nov 2025 10:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /9YyIY21FWnCOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 10:40:13 +0000
Date: Thu, 13 Nov 2025 11:40:08 +0100
From: David Sterba <dsterba@suse.cz>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@kernel.org>
Subject: Re: CVE-2025-40128: btrfs: fix symbolic link reading when bs > ps
Message-ID: <20251113104008.GM13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2025111253-CVE-2025-40128-2dd9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025111253-CVE-2025-40128-2dd9@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Nov 12, 2025 at 07:24:04PM +0900, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@kernel.org>
> 
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> btrfs: fix symbolic link reading when bs > ps
> 
> [BUG DURING BS > PS TEST]
> When running the following script on a btrfs whose block size is larger
> than page size, e.g. 8K block size and 4K page size, it will trigger a
> kernel BUG:
> 
>   # mkfs.btrfs -s 8k $dev
>   # mount $dev $mnt
>   # mkdir $mnt/dir
>   # ln -s dir $mnt/link
>   # ls $mnt/link

Please drop the CVE status from this patch, the bs > ps (block size
bigger than page size) feature requires CONFIG_BTRFS_EXPERIMENTAL and is
unfinished and possibly unstable in other use cases. It does not make
sense to improve security where none should be expected.

