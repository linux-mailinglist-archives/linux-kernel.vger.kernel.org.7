Return-Path: <linux-kernel+bounces-851248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E508BD5E90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF43B4E5BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995F25F78F;
	Mon, 13 Oct 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Uf+l401+"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2428D2D323D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383043; cv=none; b=E0OZJHlZd5S13EzdAyDk6qsPNwbRa9lziL+YhMy/9mSV0vzT7TRR7FVagjef49OfNn4N5KKz5Bb4c14JRnbBDjZt1ReBS3PH4FJDM4SE70dvIqY/me+7yDM2NdOxqqPyy2FOiM8f4sKCsrVYS6kGVi/kWh0CjZ5VAjt0D1nADsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383043; c=relaxed/simple;
	bh=vWhjl6PoCPVfQAMi5cZ/kt5Eb+dD2jHQQZjo1Kl9UbU=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=njKdzhYcIZSo6CU9z4YXZ52fMRs+x5GYGM9o58qorFSC4QDC+Y0Vwo12e8BnjXdcy+j/eHhkDObfn5FoywINkNZesqNDMFFCSpMEBqp97Y8/o5VMf+cYMPrz/GcvkAvQs0rwQ4Jgph9q/02ONzLrpAMnLTPW5ztZUkA7VJCW+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Uf+l401+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7f7835f4478so43868706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760383041; x=1760987841; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHhNPd89uW0OatizWwm8WuvlRYH5Pj8OUfvUqnc+kcA=;
        b=Uf+l401+WfuDDl9nmCdATjsPuSX+yBzEJn1ZPe0g2o2qvZgwmvXNw4IeEhXlHvaNMy
         URC/z8nPxU9TofrAXe3XqRauzu/1BfRBV8Qkw3RA/WJZ2NQ7rPI4Yc54+r3nsx9lzpxd
         i/JLWSPjWiW+BwHQcoBHrP0UoV6VWxUZfix1Op9JKl+la+Xv+HwPhRd5ILHfwTECACuZ
         oE6n25/dZekuKEOUH7DOYPROcF0TlVInhDT75liL+X0DM7qVk5sCS/SDtQHn7RxpbBQ/
         6zFjJrZ6UKIUWkGJNSiUgD+HnCHLwSTdxkSchZbLCn/VITXHAzWNQrr78P9wIKQHCTHK
         vpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760383041; x=1760987841;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CHhNPd89uW0OatizWwm8WuvlRYH5Pj8OUfvUqnc+kcA=;
        b=jTEn2fmgBVh751RzCNB6wZVVaFkOrOSDgRSfuVN+LrshusgBbRzTjMBeh0FVc+Ej/N
         FYW5Qi1T05wR3/z1t9mcQWvXdhmp2A3zstEqWclbBS4VBfZ7EsK2SLvm7zMcB+UcN1N0
         I0x0JkF04TSl1MQJXb38WYNxJS9+bPlXl/3S4i77c4LaePpf9hJTIs5vn1fHJkHv7P/V
         dHQXuVeeh2tE2LJRsRl2wMwuKNaVugiK2BqFUnQz2iF3FjNIH5K04aTQV2KoUFpz8TBz
         ItWpCjS0N5TSuphQzY8t6VNFZgtvm1VXA6HC2NiIkDFxjVm8JQcsV6pvO0KllWNDwsW1
         sHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYARdRe8anOzeoT9rqL03DXO3uqXty7p7AD/B6/QqW4+p55VGy/KCsC1RzXyElbCC8qz0rp6I7FbHbUTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRzkCdKT0zU++ixAYs/s0djqIKs/zmw3bm9FZbe55D3G7JNvW
	QeeHJ9ToAk4lFNvRsFyNfpQhdnWv+dQ8h4PqTYglq4Ti0HEn+ZNLRQL1InGzu7CWB1RDBcAf0i0
	4BWmFSQ==
X-Gm-Gg: ASbGncvSB0h6E2GgsxNxyZRpIvEVsMH2D0ALDbX8Vc1hQ7N1nzt8Vk9WUx4bhvT+2Nk
	Rbpd/VP9RqTphDhjPCqn/MAe9Ft4Jh4s4mPKV+Q5T1OCI0l2y6pbacpBFzFhy4meDs7wK2F/HuU
	kFB1lCJniBQSotYsg6u9QaLRSjR8B9ssplvwzIN66YgAwjHnK6xCnXLjOUS43UYe2PVg2jv9oLQ
	yE9rPPNBkIH7T8vNFBf7HB0r7SNCL/sq3rr81MG9AoGzJTc4/2uoWiuo3M0enCnqrK6CuEqQdY3
	wDrKkjmrmVO12N02s+DUNTVX/avJT+S4ClPFOxnP7mvkSoMiWxavogkVLHIVH8B2GyyJIMeR0KF
	vuEnfQE7kjy12B2cUDNLBjuaWWR0Nvq55ED/h8/gIRb8KZp/QzgRsvvwd/ffDuL+iPBAKIlGKeO
	6MQixhuDpX+n4=
X-Google-Smtp-Source: AGHT+IH4qPOBpyMQ+sZuD5z+/Hd39mQO7gOWoRYkJohE8XZt/wm19XtyyinMMi7AtpQgte5JWrNyZA==
X-Received: by 2002:a05:6214:21cd:b0:7ab:da21:bab1 with SMTP id 6a1803df08f44-87b20feda9fmr263925356d6.6.1760383040912;
        Mon, 13 Oct 2025 12:17:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc3592352sm76601646d6.44.2025.10.13.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:17:20 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:17:19 -0400
Message-ID: <afae09deb55bcbfabe607fc2ee7997bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251013_1430/pstg-lib:20251013_1119/pstg-pwork:20251013_1430
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v1] audit: merge loops in __audit_inode_child()
References: <20250904165919.3362000-1-rrobaina@redhat.com>
In-Reply-To: <20250904165919.3362000-1-rrobaina@redhat.com>

On Sep  4, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> Whenever there's audit context, __audit_inode_child() gets called
> numerous times, which can lead to high latency in scenarios that
> create too many sysfs/debugfs entries at once, for instance, upon
> device_add_disk() invocation.
> 
>    # uname -r
>    6.17.0-rc3+
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m42.753s
>    user 0m0.000s
>    sys  0m42.494s
> 
>    # perf record -a insmod loop max_loop=1000
>    # perf report --stdio |grep __audit_inode_child
>    37.95%  insmod  [kernel.kallsyms]  [k] __audit_inode_child
> 
> __audit_inode_child() searches for both the parent and the child
> in two different loops that iterate over the same list. This
> process can be optimized by merging these into a single loop,
> without changing the function behavior or affecting the code's
> readability.
> 
> This patch merges the two loops that walk through the list
> context->names_list into a single loop. This optimization resulted
> in around 54% performance enhancement for the benchmark.
> 
>    # uname -r
>    6.17.0-rc3+-enhanced
> 
>    # auditctl -a always,exit -F path=/tmp -k foo
>    # time insmod loop max_loop=1000
>    real 0m19.388s
>    user 0m0.000s
>    sys  0m19.149s
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  kernel/auditsc.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)

Thanks Ricardo, that's a nice improvement!  I saw a few additional things
that could help simplify the code and possibly speed things up a bit
more, see my comments below.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index eb98cd6fe91f..7abfb68687fb 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2437,44 +2437,40 @@ void __audit_inode_child(struct inode *parent,
>  	if (inode)
>  		handle_one(inode);
>  
> -	/* look for a parent entry first */
>  	list_for_each_entry(n, &context->names_list, list) {
> -		if (!n->name ||
> -		    (n->type != AUDIT_TYPE_PARENT &&
> -		     n->type != AUDIT_TYPE_UNKNOWN))
> +		/* can only match entries that have a name */
> +		if (!n->name)
>  			continue;
>  
> -		if (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> -		    !audit_compare_dname_path(dname,
> -					      n->name->name, n->name_len)) {
> +		/* look for a parent entry first */
> +		if (!found_parent &&
> +		    (n->type == AUDIT_TYPE_PARENT || n->type == AUDIT_TYPE_UNKNOWN) &&
> +		    (n->ino == parent->i_ino && n->dev == parent->i_sb->s_dev &&
> +		     !audit_compare_dname_path(dname, n->name->name, n->name_len))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = AUDIT_TYPE_PARENT;

We probably don't need to check 'n->type' first, as we want it to always
be set to AUDIT_TYPE_PARENT regardless of it's current value.

>  			found_parent = n;

We can probably 'continue' here since a match can't be both a parent and
a child at the same time.

Similarly, if we add move the 'if (found_parent && found_child)' check
up to here we don't need to run it on every pass through the loop, just
when we find a match.

Taking the two comment above into account, I would imagine something like
this would good:

  found_parent = n;
  if (found_child)
    break;
  continue;

> -			break;
>  		}
> -	}
>  
> -	cond_resched();
> -
> -	/* is there a matching child entry? */
> -	list_for_each_entry(n, &context->names_list, list) {
> -		/* can only match entries that have a name */
> -		if (!n->name ||
> -		    (n->type != type && n->type != AUDIT_TYPE_UNKNOWN))
> -			continue;
> -
> -		if (!strcmp(dname->name, n->name->name) ||
> -		    !audit_compare_dname_path(dname, n->name->name,
> +		/* is there a matching child entry? */
> +		if (!found_child &&
> +		    (n->type == type || n->type == AUDIT_TYPE_UNKNOWN) &&
> +		    (!strcmp(dname->name, n->name->name) ||
> +		     !audit_compare_dname_path(dname, n->name->name,
>  						found_parent ?
>  						found_parent->name_len :
> -						AUDIT_NAME_FULL)) {
> +						AUDIT_NAME_FULL))) {
>  			if (n->type == AUDIT_TYPE_UNKNOWN)
>  				n->type = type;
>  			found_child = n;

Similar to the parent case above, let's check to see if both a parent and
a child have been found.  We can probably skip the 'continue' here are we
are at the end of the loop.

  found_child = n;
  if (found_parent)
    break;

> -			break;
>  		}
> +
> +		if (found_parent && found_child)
> +			break;
>  	}
>  
> +	cond_resched();

The 'cond_resched()' call was located between the two loops to help avoid
a soft lockup caused by running through both loops; since we are now
condensing that into one loop we can probably drop the 'cond_resched()'
call ... which is definitely a good thing as it was a bit of a hack, a
necessary hack, but still a hack :)

>  	if (!found_parent) {
>  		/* create a new, "anonymous" parent record */
>  		n = audit_alloc_name(context, AUDIT_TYPE_PARENT);
> -- 
> 2.51.0

--
paul-moore.com

