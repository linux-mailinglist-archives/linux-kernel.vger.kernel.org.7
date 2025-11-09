Return-Path: <linux-kernel+bounces-892109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A0C44583
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9826F345F26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D7F22D9E9;
	Sun,  9 Nov 2025 19:05:45 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670761CEAC2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715144; cv=none; b=CIzNqrpZKAkRIq7oxtuz9h8oVzkcvpLos3hG8fXFFA+5cCZsiZfoUnyitZS+qBE0XC/wanTZjdfpv14PLxl5KllF0gTrxk4ZBydFQPciv7WrR6YNNX64zzK9EHWXZlonT6iv5RIuQ5ti3pvsz6HrEttTNNkc7omlk9i2mcjkmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715144; c=relaxed/simple;
	bh=ysKCgQI3g7KnwTbvK6zOOtiSeoDyau+B/qpouRxOdkk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sIvheHz254Vu+KLcZ3jimz1cuB4bT76uJyyeXWBSLtFwmNOuzr1vZ1rYv4DbIjzlCzlC+fOhNMCyahccQpFbaCsI8gEqCP+UbT6lCPilM1WoQvfTaIzn8k7UyGOAPvqNQlc7ZakC+czmL5RMnukVwS92iFyeZ+V7zmD78m5A90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4E0CC92009C; Sun,  9 Nov 2025 20:05:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 481C992009B;
	Sun,  9 Nov 2025 19:05:40 +0000 (GMT)
Date: Sun, 9 Nov 2025 19:05:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Alejandro Colomar <alx@kernel.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Kees Cook <kees@kernel.org>, 
    Christopher Bazley <chris.bazley.wg14@gmail.com>, 
    Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
    Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, Alexander Potapenko <glider@google.com>, 
    Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/4] array_size.h: Add ARRAY_END()
In-Reply-To: <2cb4ddff93b3d3037ef8d094de94227982117f87.1762711279.git.alx@kernel.org>
Message-ID: <alpine.DEB.2.21.2511091903580.25436@angie.orcam.me.uk>
References: <cover.1758806023.git.alx@kernel.org> <cover.1762711279.git.alx@kernel.org> <2cb4ddff93b3d3037ef8d094de94227982117f87.1762711279.git.alx@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Nov 2025, Alejandro Colomar wrote:

> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> index 06d7d83196ca..b5775b8f13de 100644
> --- a/include/linux/array_size.h
> +++ b/include/linux/array_size.h
> @@ -10,4 +10,10 @@
>   */
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
> +/**
> + * ARRAY_END - get a pointer to one past the last element in array @a
> + * @a: array
> + */
> +#define ARRAY_END(a)  (&(a)[ARRAY_SIZE(a)])

 Why `a' rather than `arr' as with the other macro?

  Maciej

