Return-Path: <linux-kernel+bounces-856916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A0BE5708
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42711A62D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640D2DE6F4;
	Thu, 16 Oct 2025 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4NYKUR/"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B02580FF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647633; cv=none; b=mHpzneldjaRGX4pNOWxnK7c8exHAhpWYFl88ORiFZzmAn4jmRcsEjQSxebvHyARpIz1293fp3ql0SkqAHCambK783uYKh81Cu6vZ1oS8ZKVp/e3hnvcp5mjNhbDQjOlogwuzajVwf+0NaEhEddqHV2icYy9hRSSlJ/zwQHxJki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647633; c=relaxed/simple;
	bh=SZ3VwLpPvbuumhkSyMRDao9a+3CAOTAOynz06g6NFLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWQYYCb3eiFl/UIY2R5iylpFv45ibOJ/hUnkewRf/xGpuqQ9sVmWVkeqGu10jPXtcxO94fLMWs8QD2zQOQjFtRru5V8jM84iyKauQjR9HBLac7GiZz/ogKM7G5X3AYDB+QKmwfaQ7ZJWVkSurOvFuyUQEw8FTZBJmYFItkTTeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4NYKUR/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1133918f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760647629; x=1761252429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BaWBVzmCroQjkChpezmuVIfaDJZO7tG78XkiTqoyPc=;
        b=h4NYKUR/4Q9vWnwuxD+5+w49snMsDRmfn+rZ2Puawcycpgk2nT+8ZB3JzdNovYDvA1
         gveCcNwopuLdkjbfWRPKXg/rUhZRaERBVtUijmV8iDjXpmg5FMPuoiytmZHbpu3uyO9B
         kJ1mwFuQPb/rgFCNMMCNp+UlWDHx+gsleA1PRNbUk7JfC7X+uFqCvRQCB+tNiqMnfIrh
         RwbriaHcdAnJJagdmPxu6knf5BIw3cvlrT7gBY7STOwcMe0f2YOXzCrRnwKTl5KfQAuR
         fv69ePRCeNhqaJT93qrgUCNPFIJ9JTFw9kYzbgRqDceT5BtYLOsl9hLv+sgQ5+jwgSCL
         Io4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647629; x=1761252429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BaWBVzmCroQjkChpezmuVIfaDJZO7tG78XkiTqoyPc=;
        b=WmZ5jx7ON9G4AmJ+6rsnWxqoOyJAgGf9lG2grXsoeuRp+ePkekzyXBNS7bVs0fc+OB
         jOvOEHdVnnSoU63LxzQJBkSlqxU2UGXTXgHdC2zyTC+kvB4tNFvAnxKi16+wfOmeGHgj
         lUSipehpRmE3FJjK7A6Y1zGH7Tq0p1xcK7MAGF52Nz5G+weM6/rSO3Qrfwr1+j9HKPCF
         fjnyOJKJ5Voy2pHpF2dbWBJc921RKW9ciAvkoKQyqWmcFPpTX/3k5OvTnokm+SAI74dN
         G4zVlTeMfgAfeIuOYz4dI/YV2SObVKXtlI+dzqyG7fN5lip1CnauLoVhpLs9NeBTLOUY
         tDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUigIfjDWvFb97/5qewSnJOfb32pYVu/f+8cnQL4qKSe5l9t7rHL8+FiWksweifk5AcCkZeNeKwSO/gvyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdN7uESnKkVQTJON1qH/+SKV+UfKO/GxW4nbzkrZhyxk8SVJu0
	90m7+t3gqlP7IEaTyOmsit5KERd0PacQzmG+fW5cpKPPIYwtyv08gwVI
X-Gm-Gg: ASbGnct0YsQvqsY1dVxQJM9E16edRwryzGOOgXBS2mpSeeJt0zhcvPaA789R8JB2u4Y
	HwPWMaREdhTB37gH279Us/xJF6DRjZUDM3l4x9oX7ucsMzjCYz+QILCCIwrhJZgU2f5WrcPixvu
	n7mp8MmKa9yK2VDdV7OonIzjsU8Rtkor9r8JkDk4/ZZFBG8Qg+EUcI6jIC1PGCxpwEsmMMGw1BW
	PKv7XobAWHP78e7evNBJSRlK5+Hb6euRKkdG4YGNgPwo2S5BvURotNn5s4vKh16X8dhHfFLKfcs
	oZoSAGK0IUWK+WTzgDC+6OYMcz1exNOnxbNYm/coxN21PZ4D+Rt0Wcvgu/hPl6hayx8KffYZP7x
	uNduaTP+gf9uwDkPExZh9S8LpaeDyD6uqyr8K8DI90keLwDaJM4YPtbkZV+/r+P+ssdj/Nsbct2
	T85D93txIM/EhobXp1MF2OUJ+Op8w6aGwS0302iEMGT48uADsusdLbOryFOJt1O2Y=
X-Google-Smtp-Source: AGHT+IGDOna4lVF1hUlbzkP+Y7qxbh38Qj418e9wBhFyw8Fwh1BtEEEnac13VNZybKlLGFbX+xrsaQ==
X-Received: by 2002:a05:6000:25ee:b0:427:697:c2db with SMTP id ffacd0b85a97d-4270697c302mr24980f8f.20.1760647629344;
        Thu, 16 Oct 2025 13:47:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711441f975sm45547375e9.4.2025.10.16.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:47:09 -0700 (PDT)
Date: Thu, 16 Oct 2025 21:47:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kevin Locke <kevin@kevinlocke.name>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: fix == bashism in kernel-chktaint
Message-ID: <20251016214707.5c3d373b@pumpkin>
In-Reply-To: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
References: <1531d0cd452f1870e1703c263b11d718c46b54bb.1760216665.git.kevin@kevinlocke.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 15:04:26 -0600
Kevin Locke <kevin@kevinlocke.name> wrote:

> When /bin/sh is a shell other than bash, invoking kernel-chktaint with
> at least one argument may produce error messages such as the following
> (produced by [dash] with argument 1024):
> 
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
>     ./kernel-chktaint: 22: [: 1024x: unexpected operator
> 
> This occurs because the == operator is not specified for [test in POSIX]
> and is not supported by all shells, as noted by shellcheck [SC3014].
> 
> To fix the issue and avoid the error message, replace == with =.
> 
> [dash]: https://git.kernel.org/pub/scm/utils/dash/dash.git
> [test in POSIX]: https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html
> [SC3014]: https://www.shellcheck.net/wiki/SC3014
> 
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---
>  tools/debugging/kernel-chktaint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index e7da0909d0970..051608a63d9f1 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -19,7 +19,7 @@ EOF
>  }
>  
>  if [ "$1"x != "x" ]; then
> -	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
> +	if  [ "$1"x = "--helpx" ] || [ "$1"x = "-hx" ] ; then

Ugg - one of the reasons for adding an x is to stop the string being treated as
an operator - but you need to to add at the front, not the end.
You don't need one to avoid an empty string - the quotes to that.

Although, IIRC, the posix standard requires the 3-operand expressions
be evaluated 'as expected' even if the first is (say) "-n".
ISTR that the 5-operand [ a = b -o c = d ] is also required to be parsed.
But, in any case, you can do:
	if [ "x$1" = x--help -o "x$1" = x-h ]; then

  David


>  		usage
>  		exit 1
>  	elif  [ $1 -ge 0 ] 2>/dev/null ; then


