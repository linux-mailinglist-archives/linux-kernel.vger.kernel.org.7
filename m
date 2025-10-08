Return-Path: <linux-kernel+bounces-845495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8842BC527B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 665B64E3FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527F27B358;
	Wed,  8 Oct 2025 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QLpWyrZT"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3838225397
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929269; cv=none; b=R4He2Mr611Yf+OitfRZ5uXX5VW2HLFULWtHKg9RZVe+kWy1ghuLoKjqvdDGi/Feb53MVIbQk89B1rSqMZYPI7cvKGujKA84cr0N3M0YrBhbBRYue1A2hCKv4F31GWhMj27FpOxB/uEKK+hh7LxPcaq348nqBOFBeylh9sFoqbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929269; c=relaxed/simple;
	bh=PdWVBBkA52sDRjTk2ne2LFVnrggwsvKZ1JT2sYuDyk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UycGvKI1G1PiW/rhgyQlwG4xr5NNeMqHyhwYQZi67CzWlzqdkH1iTddZUWc3MzeuRSwpd8PvXeLmYnCrH9McftNJliU0ng4NPFfAtLlCHPJ+hJg0WAf4a5tSq/KPya0rkxvtg3vBU+LF7XgXkyehKagHGVYCvTTw/u6rMdEKKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QLpWyrZT; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1369015666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929266; x=1760534066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NaY2N0oDvWpK7NE8eBCGe3YYI68gQsJWyCuxusejoXI=;
        b=QLpWyrZTHL5c947snWdjtu3GvvqNZIAC2D3oheBS0vSUh1DhzdAtoLDS0/XrgkLn9M
         vdLh9UTxWnZqeeljjN6AS4woZc4oawFIzWFfzxsIkbW8YayMMpaPWJ9POerruDGLgyi6
         IeZ/RIMJKhCI9LzVPMdS8M1wAXx+RicwtdwxApNyr/VLLv9ObyXH1uN3c9IfCJoeEtan
         aZeVckpwkrcTChyYVvoSB25hgTzAGcAMg9UEI+0Oct5oNtUq8gp1+iBvduXHYvM5mpR0
         v40NhTlnuRSz3KcXRY39HKruoG19uTXMokiKl6s0Kel8bbnoXdEEnAR+WnUL0cL41rBz
         R06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929266; x=1760534066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaY2N0oDvWpK7NE8eBCGe3YYI68gQsJWyCuxusejoXI=;
        b=JYormBKwEpSvIFHL5NCKwj24Mt+F4ha4d2QAYDBs8xg92eD09bJ9GolC4eOBbO0JS/
         VIQOOzYZx367tVLYXejYe52PT9oktqqexPpqiO+vUgR/5j4f0C0yPBJGljUU6rJTIQUa
         UKm/vSoO3v+eek3nUWqbycoqSTZKV10Uh2Ep0iaZ3LzTjPYrZm7nVOemwuRmexj+GqKD
         COPcs0wHiFjF/JtURp8WGIfkLMthJ9agdKFqhJhAjw7/rAuwZ9QhS6PO33HuteJnx+Gj
         uvmXXlP9x5LoGL5rPdOKK+lLKT+CZFQi5iec8E6WaQxzfWEqmCaEA+QHO6nGpXbU5acC
         idzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO3yOmJhBEXRg/LLdcXwdvBxt4/lfKCUHkDxySFiMdMFX4OpsxKXPblqD0RRlupDL542mh4df34QOuEQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CifwXHCWYzyRoYrPT/W9QAar0B9qP68t/nV8q7Te2b7TCfcR
	IL5wfINphc2Krh0TMjqeYxHaB4Iyg3+VPSQ8VMKZKSBAdIIUJm7ZP/is/ilQyNIUrWE=
X-Gm-Gg: ASbGncudnNZIxHAIgfhzSmKbhYKblMoSDaJdALfvo/jURwSegAF5dbG0GE6DXUhzqcY
	IwU2WcHXRlD9h/WHbTYHPwDC6i2Isyi306JWedAJVNxwEtKmWiJdTkWXkZEL6yuu+i5PQR7f19J
	EeJhJYRZiQcmop8gbdGUm3X9s7vNbCt4I035+R+mTPFYYOGXxX6NVUTQc7KsOvCiT2XHZLmIjx7
	jyQpG01sigIPS48odJ9JgTsfkMg4Kn2RGwY7s52EGuvsrdMkStqvGcPg3e1WTO4qUhi/ACwIQ7Z
	poH9ierJDWNlUwnWOKlcvitoAWqd7gOXi3/9GB0nOVWF8XlwE4h//aEvyr1rDlMGm2fIsNTahpi
	r8egd0iK5VMKjPGMkcjmOlKCrEPz1TvGKDrfXpX0xXrb0O4gQkoaySSJ6p5dJCtqZ
X-Google-Smtp-Source: AGHT+IHcDTahBvSA9DjGwetRnV64ZXy70/FjjTjnrQed/ev3/o4UscoPNE9s2/VK++lhFIcpnHrsRw==
X-Received: by 2002:a17:907:7e82:b0:b41:c892:2c6e with SMTP id a640c23a62f3a-b50ac7e6c8emr393155566b.43.1759929266063;
        Wed, 08 Oct 2025 06:14:26 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b315sm1660759166b.64.2025.10.08.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:14:25 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:14:23 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lukas Hruska <lhruska@suse.cz>
Cc: mbenes@suse.cz, jpoimboe@kernel.org, joe.lawrence@redhat.com,
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, mpdesouza@suse.com,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 3/6] kbuild/modpost: integrate klp-convert
Message-ID: <aOZjr7YTSrT-BznV@pathway.suse.cz>
References: <20240827123052.9002-1-lhruska@suse.cz>
 <20240827123052.9002-4-lhruska@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827123052.9002-4-lhruska@suse.cz>

On Tue 2024-08-27 14:30:48, Lukas Hruska wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Call klp-convert for the livepatch modules after the final linking.
> 
> Also update the modpost tool so that it does not warn about unresolved
> symbols matching the expected format which will be then resolved by
> klp-convert.
> 
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1676,10 +1680,18 @@ static void check_exports(struct module *mod)
>  		const char *basename;
>  		exp = find_symbol(s->name);
>  		if (!exp) {
> -			if (!s->weak && nr_unresolved++ < MAX_UNRESOLVED_REPORTS)
> +			if (!s->weak && nr_unresolved++ < MAX_UNRESOLVED_REPORTS) {
> +				/*
> +				 * In case of livepatch module we allow
> +				 * unresolved symbol with a specific format
> +				 */
> +				if (mod->is_livepatch &&
> +				    strncmp(s->name, KLP_SYM_RELA, strlen(KLP_SYM_RELA)) == 0)
> +					break;

Just for record. There must be "continue" instead of "break".
Otherwise, the function does not check the remaining symbols.
It won't copy CRCs of exported symbols. Finally, depmod would
complain about incompatible versions of symbols.


>  				modpost_log(warn_unresolved ? LOG_WARN : LOG_ERROR,
>  					    "\"%s\" [%s.ko] undefined!\n",
>  					    s->name, mod->name);
> +			}
>  			continue;
>  		}
>  		if (exp->module == mod) {

Best Regards,
Petr

PS: I am not sure if this patchset would ever reach upstream.
    But we found this bug when using the tool...

