Return-Path: <linux-kernel+bounces-864555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0158BFB10E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3073A54E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F9A3101C0;
	Wed, 22 Oct 2025 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUvJgYKz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0930F54C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123933; cv=none; b=mC24MJrxuc/WhjBnlwUaK6xdEpmQJIRmpcGTQ8p8pJuf1YveUW9Wih5+NXiUkw/F8mZeqQ8ClJuQTFD5fjsel7z0xW+oN5mFVYn7cnQgIA/K7f6y8xCFAQeZ2XtJPN3uJJXIgcLiI7R+WOmjcZionebvbBxBsfGEN3jcfnCjNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123933; c=relaxed/simple;
	bh=Ppm0Y91nSDmeDJ31QXjD3quNlGogG4+WQQdOCI/9yE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4AJ/aqtbryaL2WEaEXyV6SR7QwDcPUuOtIHLodJz1G4zUjnjHDfeisxmU4voij7ZBCUAAyyqtXYm2xfmy0r0ENU4W/g+cHtK9I0A/hxdPDbJ2ljFgdSIcqgAua3JrRj1SuciBR0q9wDvsUPKi3eBk7MiESmvJ+IxmU9HfkcK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUvJgYKz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e542196c7so4329295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761123929; x=1761728729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmjL8hsndzp33pMQljSUlTwswVMwXAh1CpiRMSmeqc=;
        b=UUvJgYKz5ATaK3CpK1dEMa25x+F8uTx4csd7S88r3ArJ5DKRG1mI5EL1Qmd24wVkRj
         rNNjBqSLbXxEfjh33ehw231FjXiVommfYgqXb0YPprULiPEdns9W6ua/LcsuY99jbFs0
         aagzyXAdRNH1E9JlEl54QID/LJ20bDzUGQsDK1xUVQ/MYBNyquIfmupeK5nIgDIJ7mhu
         ex3zKAJFH/cTCWeVhl6QYfUql7axSCiutLk29g0sbgXlux6W2lsdZGQ1JymLB3Pd4E1x
         V2DkJ9XCf7G/SCwYvqc3ojiXMCRlCHPiba3UpAH3I632NgyvXfRoaJoaTZz7BAPrTHwn
         /RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761123929; x=1761728729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmmjL8hsndzp33pMQljSUlTwswVMwXAh1CpiRMSmeqc=;
        b=oi2GavHpIWvj/5lHv9dkVsy1qizdY0tsEDWMbtixQIcrocgHjOHcrG2s+KvcqUVlCm
         4iENwQVjCaMQcVPYYp+C9S6w/iamWgcvSFNn2hBUSyYkSmWhfafuBqEqdGnmoEve2J3j
         sJXmMz5SCA8wpxWm6ZPHdOPD3DCdt2PmhCEhOWWAa3pzekkUCkQKvsfklNTN2GaWF+OU
         3/olbM4PsIY4f7PEVe/tTP7Upxog6zejMNF7P83emcAs3mFA5zjxqPwWaHNPGMykgCq/
         gOugDFtos9zpCSBWBJc99J9G8uFVe+GA4NCpPRapi9fbGVFQSmzkEf5bJysWa9bIvE7F
         nd7Q==
X-Gm-Message-State: AOJu0YyRFZPaCxbjAMgmcUkhzaWp1TW5CZlT2WcgM+Rhm3/31muVBm/N
	m37+MwuDFHUmYAudmvl5SNs9kGAszVehfrytHrO2VvquFMRYW/p/fG4r
X-Gm-Gg: ASbGncvM4jcRi82XxkEJFGcnDC403AZ0yefs27V12hNS6N///IBIMAhvdVyx9t29VsS
	hBckma1HipY9UEBDI01yQRknG7+T0nynlEnglpqVUarvOtgxubDuFQkClQurFG3RlwvU3p1JjkD
	Pck2tIRuV4hpHzeU2kDlG9bwI5NMFi3KnIYr14+5w8K6JQJGjyzG3eSW0Sk5cenDkx6y0a0t2s6
	+TDBqTTv0tsVsCfcTz/98rSUn5Q3WFYmVhzvwE4d8QDn999egn4NeRAX8J6SgjVpBSNBOSwnLGq
	O/2GgbXW/MXyd3kUNtVKJo8i9RNjRbtWBk0G1XuWjm/2btp2GDUXT3lioNHZmYDJUyXgtCiZiei
	yo1+t/IJ3BVA2Froc/hxiV5/Q6cH+UZTLEAyXuQQvu0WTntQ+CceduG28vD/iJS6zsZys8eJEKG
	yAv3RT0ES1xH061KyA+flmyDhX6wpZgxcjsc1medy5O5+z08btttny
X-Google-Smtp-Source: AGHT+IFGs/JUfn6Ap8KARHWzMpIa7KxNZY4wroARkO/ZkM9jA8rir7RQKOT9bNS7PeWpv8fVDHiwgg==
X-Received: by 2002:a05:6000:4210:b0:427:374:d91e with SMTP id ffacd0b85a97d-42853255b67mr2066771f8f.11.1761123929499;
        Wed, 22 Oct 2025 02:05:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm24475658f8f.21.2025.10.22.02.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:05:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:05:28 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set initial length of string to 0 instead of 64
Message-ID: <20251022100528.525644f4@pumpkin>
In-Reply-To: <20251021172159.47314-1-biancaa2210329@ssn.edu.in>
References: <20251021172159.47314-1-biancaa2210329@ssn.edu.in>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 22:51:59 +0530
Biancaa Ramesh <biancaa2210329@ssn.edu.in> wrote:

Nak

> Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
> ---
>  scripts/kconfig/util.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
> index 176ec03bb3f0..f55e3ce496e1 100644
> --- a/scripts/kconfig/util.c
> +++ b/scripts/kconfig/util.c
> @@ -64,13 +64,14 @@ const char *file_lookup(const char *name)
>  struct gstr str_new(void)
>  {
>  	struct gstr gs;
> -	gs.s = xmalloc(sizeof(char) * 64);
> -	gs.len = 64;
> +	gs.s = xmalloc(64);   // allocate buffer

That is 'no-change'.

> +	gs.len = 0;           // string is empty

I'm pretty sure gs.len is the size of the buffer, so should be 64.

>  	gs.max_width = 0;
> -	strscpy(gs.s, "\0");

Where did that strscpy() come from, it is wrong and shouldn't compile.

> +	gs.s[0] = '\0';       // initialize as empty string

Equivalent to the strcpy() in 6.18-rc2.

>  	return gs;
>  }
>  
> +
>  /* Free storage for growable string */
>  void str_free(struct gstr *gs)
>  {


