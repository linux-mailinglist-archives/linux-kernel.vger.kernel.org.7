Return-Path: <linux-kernel+bounces-858143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0DBE91F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFE674F5E71
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2216C32C93F;
	Fri, 17 Oct 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+8kQCCW"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4632C930
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710385; cv=none; b=ZHi9MggmzU17zmTJZGAKpvVjilNGtfONm4pJA7QD9JB5gWxPaRkmxvjjn9EQS75vjhCTy4GHCh7562zMDbh9qR0UhWqZDVZ3OwbiPYnRy5Ez6VUlpBW1pyBATITk6TjHBLZZrMtEKLQbbAI5BQlC8syUdaBxFUWdJqRCCLLOYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710385; c=relaxed/simple;
	bh=TA0C2PR9Ws0Po2N0ZdhBqGLpo+VxWuRInWA8sy6kBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmdVm5d7TlN0rZke7Jrjabc+enNPVo2uifiGHLPM41g9eOgFKxnV++zme/ayzO/ZYA2KjU0AjTz4bpSAJV0AozEiGVP7mG1jhLZ1goFJCGewxYsVSl2LfZBbjrHvt5tRAJkz/DKo6ysNI2kVy8jLJJlkyMBlH0d6vpSZvc2w2VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+8kQCCW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so18922615e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760710382; x=1761315182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNOjjSMwzRNogmToDONt5R1UTZKI0pvxUSlzsI4YHAs=;
        b=H+8kQCCWcZ6s7Uq/ZssF/QRCpURq2sYJCnhwsqlElT8pDGDyqpDPjLi25i2ron8SQO
         7VBXUys8FTn99vfocVisM80DTKsaHlm1zefyNcmPWJx8d6ETOxWaKKwdyTd6f1AYnrdA
         tgi9ndLDbwaECA+hOV/huJ+9rXgWCWbigkh/MxhVHf0n4ODIIfMjwK3BXJMhlxtavcup
         rdUrA5/9KaaU7f+pmKPjewQt78z8Dnov3LmR/mmYmFc8ckw4lvQrWeYKr9ctsnKIvuRB
         z32vk2PafTVUK3zkQ8Dzs0F1sWZUj4y/plZpQ358evv9qIzLNHjcuC+PwsSHS3kLswVz
         g7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710382; x=1761315182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNOjjSMwzRNogmToDONt5R1UTZKI0pvxUSlzsI4YHAs=;
        b=RWXSDl+m/rsA5yrXxUFearDBbftiPWBQTlRRCKZH9iWcCU4BCvRl9ZUDxtP3oV9PMC
         lQIj6FJ7rmgj2JqExjGnn98RLL7KwkXVgdY9thzT5Hc01fMEviG8rLoYJxG9RyAizCoX
         3I95kJqokFhFSBLIdm7p89Aa7JyRzNfZ0YApZEdqVoNncYFBANWXoXekbftqZPoehbeP
         bR8nUxzpWGhnfwCiSNqq8wC7RypgWizKlgHKyxvV8VwoGHkLg+BkbJiaVAkfcKHzkT7K
         l+uS8YlNau2qONO6N0yBxhDAzYvnAg+wZPzT5fEwrvB8dT4Q2Q8hsYvkNIb6hLD3Al4W
         DiZw==
X-Forwarded-Encrypted: i=1; AJvYcCVRJn5iNNpOiqAoL4xGEAkvztbnSBAgHavNX6D3Qxm7aj/5zsEdr1JI+WkkfPzlh8wgjikw+U51vEUb9Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyGeAIMqY4uib0i4JYVEVBGswWZsl6MKRiH0NMxrab/amlmBR
	HMyLGEswGqRgP+9gkm2yEPQQc+jfKbalZ4/UzGFT7VGSxzwNFzQ4Ji6u
X-Gm-Gg: ASbGncu0J3I9AUrhPB+9i43nwmSHBX7fHlUDcnzlYIOBCENq9tTk5AysfXjE/OrXdUz
	/WRd/Rd5nLle1y2mvZIQCiaJq0fSxR44pu/hhY1asiN7/8bSJaYi2uJZx9YkRVzyPIHjOXzLduH
	L95odVnWZQrRpK3OMHTpZ7ZSO1M/fuHT8SAzqrkbTu8LFrLWJ9spm2k1GTWNTdZPnxAjtrilJUP
	JtR7vkRtpR41CrJteb25PfE8E2Ib15Wh+y8iTRZTWkmknd4GsBRUnv9tQ+eNR6ot+YV5OZzPruG
	Nm6UjRc5GKJNTWXtowHJdb8rNl8aWl5Azh27oCKdXBeviAiGjx+oQ5hleHjv4zCBp9kLDfYq7SZ
	s/hipo2+DQdtCGOGGLzduKQKMn6XlM747aUaAKm0qr71X/Hg4NlLJhRIn4i6qVqMTh3apJrIrtp
	DDrdBwLWufpSaBrBAwyS88Oesm9wqCsku6v53lLGpqT6aTkiYlvMm+
X-Google-Smtp-Source: AGHT+IFz1vxR48CXEag6KJXQbAy18k9aCvlsVSMa9pcwt1fGqM2eU/lv7TYBPO8gfrmLkhRdVtQM1A==
X-Received: by 2002:a05:6000:98a:b0:427:7f0:95f0 with SMTP id ffacd0b85a97d-42707f09601mr1840271f8f.37.1760710382021;
        Fri, 17 Oct 2025 07:13:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42704141cc3sm7714594f8f.9.2025.10.17.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:13:01 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:12:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
Message-ID: <20251017151256.111f2669@pumpkin>
In-Reply-To: <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
References: <20251016214707.5c3d373b@pumpkin>
	<a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 17:47:09 -0600
Kevin Locke <kevin@kevinlocke.name> wrote:

> An "x" suffix was appended to test variable expansions, presumably to
> avoid issues with empty strings in some old shells, or perhaps with the
> intention of avoiding issues with dashes or other special characters
> that an "x" prefix might have avoided.  In either case, POSIX ensures
> that such protections are not necessary, and are unlikely to be
> encountered in shells currently in use, as indicated by shellcheck
> SC2268.
> 
> Remove the "x" suffixes which unnecessarily complicate the code.
> 
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> ---
> 
> Thanks David, that's a good point about the x suffixes.  Since
> shellcheck warns about the x prefixes (SC2268) and I'm not aware of any
> shells currently in use which require them,

The problems arise when $1 is (say) "-x", a simple LR parser will treat
[ -x = -x ] as a check for the file "=" being executable and then give
a syntax error for the second -x.
I can't imagine why shellcheck should warn about a leading x (or any other
character) provided field splitting is disabled (eg by "").
The leading x has definitely been needed in the past.

POSIX does require the three argument 'test' look for the middle argument
being an operator - but there might be historic shells that don't so that.
OTOH you are probably looking for code from the early 1980s!
But the POSIX spec (last time I read it) does point out the problems
with arbitrary strings being treated as operators causing complex expressions
be mis-parsed - which a leading x fixes.

> I think they are safe to
> remove to clean up the code a bit.  Here's a patch to do just that,
> which can be applied on top of my previous patch.
> 
> Since -o is an XSI extension to POSIX, I've stuck with ||, but I think
> you are right that x would not be required in that case either.

I'm not sure there are any common shells that don't support -o and -a.
They get used quite a lot.
I'm pretty sure they were supported by the pre-POSIX System-V shells
(or the /bin/[ program they ran).

	David

> 
> Thanks again,
> Kevin
> 
> 
>  tools/debugging/kernel-chktaint | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 051608a63d9f..051ac27b58eb 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -18,8 +18,8 @@ retrieved from /proc/sys/kernel/tainted on another system.
>  EOF
>  }
>  
> -if [ "$1"x != "x" ]; then
> -	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then
> +if [ "$1" != "" ]; then
> +	if  [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
>  		usage
>  		exit 1
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then


