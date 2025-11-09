Return-Path: <linux-kernel+bounces-892213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06152C44A23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2953A3F5A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F3B271462;
	Sun,  9 Nov 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="athyOGDd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D24317D
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730586; cv=none; b=YNEt7yvkua+eyF8Lzw/Q0tmRu4UHQ+zFM3lHH6uE48ok+FSxFR1Vwd3I9ccW6umjNwZB5Q6fSu1OtXQeWqdmFtjyw7L8THxrbqVNDq4Pa4ID6RFZOEUggam+tnEMLRQPcUnFJ+4hqjddrEVmeMzfH7TGtsVAROmMOKiCenuQrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730586; c=relaxed/simple;
	bh=yGq8Y0gkoqQHLwZS2dePvCYMobIl4geCER7EzHWgRlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLiB2HCGQrwH0YR02tZ2TSfg0+yUQKI1+Xzuoz2EmfltPTzkRKsXiSobOZv9M81lnDZYv+batryJ+3X/9O12z+Ux6CcNk0K31GZ/UsTfsXGy8ik5rAjyTXUg2Jt3GEAavXAFphSOxn5O7JxOIc2sidSYGU7IY1npU3sw4CHCEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=athyOGDd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so13062655e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762730582; x=1763335382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpRf4SnsIYUEbCuKm8TbCRzkaA9WFZ2/wnfNgOLDP4Y=;
        b=athyOGDdMGznR+7N5FqawKiLI+2NrioU1Cgra8p6YT5G7HdpTV3SG8/UD/E+yjzuPo
         KGt24rZ7bzs9zJ7Z3zdExoPY3cRM5dW6sUc8smxzB9evDTIuVBSSqSYi6PPuhWrzKe8+
         ERf67CcAwJrraQqvBR7H3kS19mYgn1JDb6KYgD0rtQb5/cifpRn+h22O69huDV2ci16N
         lgLyZTbsr1bEnZG3yjhYm4Nl7Uck8woDTJ0QznDLHJu89RBWWrEE3dtzAziwFscezUZd
         4uXoz+efYAsBM503HCTUSyU7YYl8i6l5VrFt2XhpIzVpmwZJN5zJP+9PbwONfn7+ANFH
         vSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730582; x=1763335382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpRf4SnsIYUEbCuKm8TbCRzkaA9WFZ2/wnfNgOLDP4Y=;
        b=GmfRG0YYs0NmDnDeHBOMPizy+cxmymlOG8uZ+b22h/gzefeiCNpOQRfvlw6RhH7m9I
         lzA4HSu0oCp6vT0ZOxWvHy0U1JAZU3vU4vx13pA+bkZWmXBs1i1uZjJXxZGuSPeepOPm
         lUonUrn1X+FZhCIgdiuyzwhiZldlMPOaWibiG+6cFBbeefTmLI/J5vtNjOi9ONTrvozD
         +nofmVuNF8Vpj5LprwLEaRhZ1YbwDS3PumeWEukHkf8K30TNPLj0u+xeM8n1W4oWa78l
         5ZPGGyU4VIzGPhOofG8Ef9YhWtpdqYRVOWWtjyrWBnMsanOjKaXd1TmOygONMwBnTiG2
         9ZBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQAdqUtEJkR+eJnPjoSJiqelbv5JH4hFpt0N0n0ReDNIdOjugeDqkg1KFCUPAuJu6pa9SV4m1g5/Vx/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjvd209Maa/+HZdffeV5UXPfQLY0/Ula1JnsU01qClAxHmzEU
	BbhlVsH8rztSYxNQs7cN7KxpdIQlk9PkX+PNRW4kP+92zEd8giSG76ua
X-Gm-Gg: ASbGnctEAr9QQA7zlcRP113cN4kzpB67mjHL1qnnpp79MKFiYA4RBb6UUXqyOmCm1s9
	LvsPRBD8//O83BGO6MX8su1fA+Tctg7tw/mD77RkoMDeao61N9LdG8IV+hzsh5JRuUWVJZPGlQj
	n6huQafb2jfxT62KU1S1i2BXHMjBFGGms+F2fopTbr8G+SnMVhHR4fRqlM1lzi9wH2daBJLd4fc
	ozHjOy94viCw7JY/OzlPF88ek3D9qrQWadVMvmyHr0TMDINeQz01zrbX8r6UVaAN+xYDzr6fg6H
	Sx7u6YXJICZsJNrsWmW/L5m7ZZeLoMsFWxRGXtb0Kd8HKNqoPA5/rqq2nkXI7GY1nJSb/jAF2vJ
	bDIYe3qO668IK82oeHNCNfrboAygbptPY3HMRSB/3N9kaQWSZxqxuPDczHMsUvui2zLL7CZPiRR
	+QUL/3f5ZyVmFm1UMhtdoYRfUHOfmdmx14aukBsb8jKg==
X-Google-Smtp-Source: AGHT+IFoXhEVWqJyVDZ9zwYm2ygEdPkRnSFCeDmrZnNxSFKzA//nNy4j1tgrOfL9AQTwFGE/KNUbsg==
X-Received: by 2002:a05:600c:4448:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-47773228c21mr56390845e9.7.1762730582162;
        Sun, 09 Nov 2025 15:23:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm98802145e9.6.2025.11.09.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 15:23:01 -0800 (PST)
Date: Sun, 9 Nov 2025 23:23:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: NeilBrown <neil@brown.name>, stable@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Laight <David.Laight@ACULAB.COM>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Linux List Kernel Mailing
 <linux-kernel@vger.kernel.org>, speedcracker@hotmail.com
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Message-ID: <20251109232300.42618f06@pumpkin>
In-Reply-To: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 08:45:35 +1100
NeilBrown <neilb@ownmail.net> wrote:

> From: NeilBrown <neil@brown.name>
> 
> A recent change to clamp_t() in 6.1.y caused fs/nfsd/nfs4state.c to fail
> to compile with gcc-9.
> 
> The code was written with the assumption that when "max < min",
>    clamp(val, min, max)
> would return max.  This assumption is not documented as an API promise
> and the change cause a compile failure if it could be statically
> determined that "max < min".
> 
> The relevant code was no longer present upstream when the clamp() change
> landed there, so there is no upstream change to backport.
> 
> As there is no clear case that the code is functioning incorrectly, the
> patch aims to restore the behaviour to exactly that before the clamp
> change, and to match what compilers other than gcc-9 produce.
> 
> clamp_t(type,v,min,max) is replaced with
>   __clamp((type)v, (type)min, (type)max)
> 
> Some of those type casts are unnecessary but they are included to make
> the code obviously correct.

I beg to differ.
If the values are all positive the casts aren't needed.
If and one the values are ever negative the code is broken.
(I think that is a bug in the old version without the initial check
that sets 'total_avail' to zero.)

> (__clamp() is the same as clamp(), but without the static API usage
> test).

And it is really an internal define that shouldn't be used outside
on minmax.h itself.

Replace the clamp() with the actual comparisons you want:
The code should always have been:
	if (avail < slotsize)
		avail = slotsize;
	else if (avail > total_avail/scale_factor)
		avail = total_avail/scale_factor;
(The compiler will CSE to two divides.)
I think that actually works best if both 'avail' and 'slotsize' are signed.
Then it doesn't matter if 'avail' is negative - and lots of tests above it
can be deleted (as well as the max() later then ensures it isn't zero).

But for bug compatibility swap the order of the tests over:
	if (avail > total_avail/scale_factor)
		avail = total_avail/scale_factor;
	else if (avail < slotsize)
		avail = slotsize;

    David

> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220745#c0
> Fixes: 1519fbc8832b ("minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()")
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs4state.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 08bfc2b29b65..d485a140d36d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1822,8 +1822,9 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
>  	 */
>  	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>  
> -	avail = clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> +	avail = __clamp((unsigned long)avail,
> +			(unsigned long)slotsize,
> +			(unsigned long)(total_avail/scale_factor));
>  	num = min_t(int, num, avail / slotsize);
>  	num = max_t(int, num, 1);
>  	nfsd_drc_mem_used += num * slotsize;


