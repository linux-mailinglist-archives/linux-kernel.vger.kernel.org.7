Return-Path: <linux-kernel+bounces-722082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C730AFD50D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D45116A320
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C62E6D27;
	Tue,  8 Jul 2025 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="r/yDgKGT"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D32E62B3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995011; cv=none; b=EPd+ZHGPGPp/BYJvbvqicyQV6PTfgzdLPqseZKSJZky8qemmSUhKQSe5ZySf9fBOTY5NAhJXdoYQVC9mkE6VOwBibfRiTBh6UuDeearBPCHhn8tElZy20XTkK/tsfybzYBD2JU+vsi4y/IRjFkUecgv1wF6VLjc07LjAtiWmvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995011; c=relaxed/simple;
	bh=RT4CQCtYmBJoslVEhDrjrl/fj+/sUXD7RCrZ4P/cGTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNmKB2TfTGRoyLWaMzp2SKd47VRe7CWgXzb+nul3CZ6wsZ2hPOW45bqmXCspdifm7ODVHeUH8rbAUJ4od3OmgF3psAz/NR/i33EwTpt1/FEFTx+322PiWGQZBs737XYgv8mxa3nm5YzvkxeRLi49+CaXSpXFmzD/m/f6I98Vlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=r/yDgKGT; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73a5c41a71aso2493863a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1751995009; x=1752599809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+8r9BFJWIuHw4v0fMNwjGf8h2YGSArWLMNGT0WpB2A=;
        b=r/yDgKGT16DTnev6LXck5+6afR7zvMUCZm3XhgANLVwOEbk8wGfs0lrPV69vWZg+cD
         WLoTVMWYGrx/RISd37ZlEVUWI/pbAg8ZrpxjGfga8GWD6XjL3cqLuxMcwr4L5BlvUQ+P
         Ecu/eP+9F+2mUOakpCBsrrphNzJIVDM4LeMx3qbCTgeEQfZ1u5LFSID8OgeZdp79gU6q
         aJaa8440hHLF3czdmHKmyx31MkOYIvt+mM79muRZKeOIfLwoo+RP4MfGOQpUoX85YaCg
         3yW9km4mCFcZUP8gEJKcZexnxyUVDW9wohUsNK9tlL6QOsKYWg6AwzPyexFuWIyeT7cf
         T7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995009; x=1752599809;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+8r9BFJWIuHw4v0fMNwjGf8h2YGSArWLMNGT0WpB2A=;
        b=LO1RYqeOU4+jlN+rjbEdfp0vcrf2pio5ZEqtBKleWqPWDKWP19aZUQluJijRLsMZmV
         Bpl8PY++dwVkAYoL2fK7J7mUKPjpgpXrAOGBMDNoRs+Wvblu9LRazW4KdA8BZwg33F9U
         koodadEfHPJ1LfK7Ziq9vpk15ujyDW2yAB2AInaGQbbhKZ9SHQmb07S9zWMFYje5UePr
         FDwH5GC0jgFLWZv+TVtCFrrQWe68Yf7NfuD8r1qcQ4JT1A8vbL73VAbmqMnX9hP8h8IV
         QFSa+M0hkf+y0Dmv8HrKztJDnFYPH5gIWaeGNqMEbxIly0xpdS6BKNCR42OvUImtdFMh
         vzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbLHwt6N86fn/xBQWhJU088Ebb71oc0eTJFtGpBdTYa5eJn24pWJkGEznlJgaxIIScMaUUc24tD/6r4do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUfuMbS26L1uM8Rnu0sht1DTL6zOfhTjNxcvPUakhgilDkRGI
	TfZpc9E82yYAOE0JqlMFuionk3RfpNNH/IcNQ6BXTwBkNiBbkFsW21pls8Qfu6hsCps=
X-Gm-Gg: ASbGncth696ZLQyZsxYw6OzNYuZGQfMAuQCixoYULJyCIlrC/umCAS4NzVHPyUyurTz
	Ao5mTtewMA9ZCX23oH/U8noHZtdUPaiadcje9ZQTjvoWS7kvxkFcZHIOx4wpZildN5VJw97Sz7e
	2O1ffOHiiKOrhynVWFXSzlxBEzgMYWCX6M9km8SvzD7T8UuIf4ndec4GSBSLazzVCi8Ryz9oItD
	fneBo8a5rfQbSNsW6fCVkrDntIuIumlde/gkn0NHzI/lpyhOK1KMxshpbiC26HBZXCTjxSedkD/
	P9nwRnV6ZCiTZCcGtC5SbIaM97C+hb5UANZO6qCYbwjBETG7Qf+6Ouc3FCnbtQBuAQ==
X-Google-Smtp-Source: AGHT+IGwzlWScb+PX06qplAqKrbQpL/HWUvLZSqvV8qVhQiQVG8BwS2EAlkGyL9WN55pk7m69XQJeA==
X-Received: by 2002:a9d:578d:0:b0:73b:1efa:5f40 with SMTP id 46e09a7af769-73ce3841a5cmr481695a34.10.1751995009227;
        Tue, 08 Jul 2025 10:16:49 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:ec53:8290:86a1:aa7c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f7352b1sm2058138a34.6.2025.07.08.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:16:48 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:16:44 -0500
From: Corey Minyard <corey@minyard.net>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: openipmi-developer@lists.sourceforge.net,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] char: ipmi: remove redundant variable 'type' and
 check
Message-ID: <aG1SfFoqU2pB2_wo@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250708151805.1893858-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708151805.1893858-1-colin.i.king@gmail.com>

On Tue, Jul 08, 2025 at 04:18:05PM +0100, Colin Ian King wrote:
> The variable 'type' is assigned the value SI_INVALID which is zero
> and later checks of 'type' is non-zero (which is always false). The
> variable is not referenced anywhere else, so it is redundant and
> so is the check, so remove these.

Leftover stuff from previous changes.  It's in my queue, thank you.

-corey

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index bb42dfe1c6a8..8b5524069c15 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -2108,7 +2108,6 @@ static bool __init ipmi_smi_info_same(struct smi_info *e1, struct smi_info *e2)
>  static int __init init_ipmi_si(void)
>  {
>  	struct smi_info *e, *e2;
> -	enum ipmi_addr_src type = SI_INVALID;
>  
>  	if (initialized)
>  		return 0;
> @@ -2190,9 +2189,6 @@ static int __init init_ipmi_si(void)
>  	initialized = true;
>  	mutex_unlock(&smi_infos_lock);
>  
> -	if (type)
> -		return 0;
> -
>  	mutex_lock(&smi_infos_lock);
>  	if (unload_when_empty && list_empty(&smi_infos)) {
>  		mutex_unlock(&smi_infos_lock);
> -- 
> 2.50.0
> 

