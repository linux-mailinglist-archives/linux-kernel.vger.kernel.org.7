Return-Path: <linux-kernel+bounces-748591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC2B14367
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250C016D2FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C6279915;
	Mon, 28 Jul 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSajxShd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80522798F5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734886; cv=none; b=X2JJqjtUgQfi3JFZr6jTF1+yjpHiKFNuV3/NHSSrodbO/U4GC5Kk8vdwKDSXX5ZuWP3Ivdip+lTZtw5ljhZ1U9TYS9BfPxgps6wB/FqCZWWtO2OhjHHapAsL+OZkEBWF6fY8hej76beO/cKjatXkyc6z966gKqvQbgADcqhabb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734886; c=relaxed/simple;
	bh=ZV232Dxo6P1lXxwl/8XNtSFqtMaix+T+IL0Z7bfuL8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE0k12I5oOVtb0MJW9gOey3uIVgMKWWoGW0xGxsTNTJMK8B6Z6YrTPzgYSiaF5kPPYuPteed0xl/54Fmiq7OnqnW8nPOyRJUvhTC2f6/82ThzvIV7ju+8YZc+0OvcdyP/PkE0ewJkYvJNw+KppQIR6BFrEGfkN8RGp16+0rhqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSajxShd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6154c7b3ee7so3608a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734883; x=1754339683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cIuEYX17XiPrfyxPlwLzcOeQJGvPzMkyLjuQxbOTNU=;
        b=KSajxShdG5yVJdFBlcGQgjV0xUzqxDtEezygy0iwGpLivmS4oDZn7SszGJmASwPgFg
         4tFlebsyL9c7mGvxsfTB96rpcJITlrJDQgCogJMMomQdXTj08QJ7VIKyDd+caw2vfVVz
         /SQyUB+R14dkK01wAR1+FEOr/DXuFX2RwhUY9IUpcrOJVGJgGQ+q6trXtoIxhRXhjajZ
         dkIgRDIq+p+mLTBOBcmi21K7sAk6GasXo+zWXPwacMBG1H7f+W3P0oorI2djA4DRcZ3B
         EltYGRsuaG9fTUbtbTIkqBl9azVCyaQWib7Qy4YjXKyWq8YmtWYWKFKqokicVaFqkAFn
         K4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734883; x=1754339683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cIuEYX17XiPrfyxPlwLzcOeQJGvPzMkyLjuQxbOTNU=;
        b=UnAsNBdam/njrxc59n+MOX3x7dBr3Wl9dZudo8wngbiiGydsZGA7uMNVkkKAdKaZDv
         5qdWCB10600a5IogKDBxJ8+/V4aiyO8ph84M5BK8UGvCIpawBCSKTFCQ7/haJgn1TVTr
         V8Zm2JB8URWV41UxRmXfoZo4+JCUp30HRwG4yJdgWwjNPwwjDXFyAInr8Umhm1I1XX+0
         fKrdFFtD/oBS5EWSlrCcs7d6T16dPbmDnY7i5yPU3C729xeah1wLdAL78unzv44t3q5L
         nmpzSBDJodg5zqgC3ijZrCWo/umOAbZP87Iivwwh/X0vHiRL/TucAqaARUMGjSQf26zz
         F8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcmY+mZZpK9IL1KP2WjuARAtsxLg6JUqq+K2VAbCDTRttUnBYeXtWuVSqKO4teWtjUiDPFqg5PtGCwVh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLBya0YpK4jtxJd3YU7vM/gXqEAWirAVu1K9BgTmdOBoXXWpv
	+EYvG1Pl2VOxHAEJqv1ufNvgV0Agq2mlAfUKy69z1ZecWJOYVPUTR5pSmbpAc8VfQxU+wP+ndXk
	baJ1vIxbDPCg3Pnzf8riSU6MKFNvOIAG3H8DAUa7j
X-Gm-Gg: ASbGncsVJh+hHPSNWPy5bA8Dto+NscS647kppo9esZ06i0z5Rpmg2f6Qy8LxQ5ihJBQ
	KWR6sgoyqckzu3jbxFF9OAGlYls5T7BQPX3+83Z7g6uwBHplZhPcikcE7BG467Rh+Polfx5XzZT
	NxhCg8VuOa0lbnxnhkk6XhRhF8RS9exlvozBenZzFBvnpSJRZvmzO/iqB/g9X5jYals1R2A8iYr
	zQzAM+WBbReCNGSVMRhjuXYgnE0YYoiaQ==
X-Google-Smtp-Source: AGHT+IGSwHNM1lMm6iRvrNhpLZM/44NLBcht7A9ZyhiiFAeshkQMQrkJ5OQp5Ak5DNIjWjjK+SMh7cZBKnKVJBMgOHw=
X-Received: by 2002:a05:6402:2291:b0:615:3301:25c3 with SMTP id
 4fb4d7f45d1cf-61567304ce8mr13512a12.6.1753734883112; Mon, 28 Jul 2025
 13:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753711160.git.lorenzo.stoakes@oracle.com> <386ba8fc99adb7c796d3fc5b867c581d0ad376c7.1753711160.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <386ba8fc99adb7c796d3fc5b867c581d0ad376c7.1753711160.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 22:34:07 +0200
X-Gm-Features: Ac12FXxZWrVG9lHiMIdLtQnur6MhrtrOas81mqHV8KcQZRHD1RU90YYt9ttm5Qw
Message-ID: <CAG48ez2rQfWJwnpAspNr8OtLXgPadG55Re0KoK5ovBKqE3AcbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] man/man2/mremap.2: describe multiple mapping move
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:05=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Document the new behaviour introduced in Linux 6.17 whereby it is now
> possible to move multiple mappings in a single operation, as long as the
> operation is purely a move, that is old_size is equal to new_size and
> MREMAP_FIXED is specified.
>
> To make things clearer, also describe this 'pure move' operation, before
> expanding upon it to describe the newly introduced behaviour.
>
> This change also explains the limitations of of this method and the
> possibility of partial failure.
>
> Finally, we pluralise language where it makes sense to so the documentati=
on
> does not contradict either this new capability nor the pre-existing edge
> case.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  man/man2/mremap.2 | 78 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 67 insertions(+), 11 deletions(-)
>
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..cb3412591 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,18 +25,41 @@ moving it at the same time (controlled by the
>  argument and
>  the available virtual address space).
>  .P
> +Mappings can simply be moved by specifying equal

(Bikeshedding: This "simply" sounds weird to me. If you're trying to
define a "simple move" with this, the rest of this block is not very
specific about what exactly that is supposed to be. In my opinion,
"pure" would also be a nicer word than "simple" if you're looking for
an expression that means "a move that doesn't do other things".)

> +.I old_size
> +and
> +.I new_size
> +and specifying
> +.IR new_address ,
> +see the description of
> +.B MREMAP_FIXED
> +below.
> +Since Linux 6.17,
> +while
> +.I old_address
> +must reside within a mapping,
> +.I old_size
> +may span multiple mappings
> +which do not have to be
> +adjacent to one another.
> +.P
> +If the operation is not a simple move
> +then
> +.I old_size
> +must span only a single mapping.

I'm reading between the lines that "simple move" is supposed to mean
"the size is not changing and MREMAP_DONTUNMAP is not set", which then
implies that in order to actually make anything happen, MREMAP_FIXED
must be specified?

> +.P
>  .I old_address
> -is the old address of the virtual memory block that you
> -want to expand (or shrink).
> +is the old address of the first virtual memory block that you
> +want to expand, shrink, and/or move.
>  Note that
>  .I old_address
>  has to be page aligned.
>  .I old_size
> -is the old size of the
> -virtual memory block.
> +is the size of the range containing
> +virtual memory blocks to be manipulated.
>  .I new_size
>  is the requested size of the
> -virtual memory block after the resize.
> +virtual memory blocks after the resize.
>  An optional fifth argument,
>  .IR new_address ,
>  may be provided; see the description of
> @@ -105,13 +128,43 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.IP
> +Since Linux 6.17,
> +if
> +.I old_size
> +is equal to
> +.I new_size
> +and
> +.B MREMAP_FIXED
> +is specified, then
> +.I old_size
> +may span beyond the mapping in which
> +.I old_address
> +resides.
> +In this case,
> +gaps between mappings in the original range
> +are maintained in the new range.
> +The whole operation is performed atomically
> +unless an error arises,
> +in which case the operation may be partially
> +completed,
> +that is,
> +some mappings may be moved and others not.

This is much clearer to me.

