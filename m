Return-Path: <linux-kernel+bounces-867490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F33C02C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E14EDDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B434A76E;
	Thu, 23 Oct 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1rXeHjW"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97634A3DA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241373; cv=none; b=mJH/EwqAGt/ZNT4FBDKaDilqmEVyDJRdfHhgPerU8F7O+mBgk30pz7LWx/kzi0zAlUUB0NCuPKsP+8kOaBNsq1qcdwWwqxxLlvBDxS4xmMhNo/50Esv47J4/zgVMiYeHjpqYOUUlahpD4mRDAaX5oiT7GUOCuNuzXiSM7ylvEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241373; c=relaxed/simple;
	bh=SOi8RTAvsP5fHphida3kvNb3CyaDYKqZqhJ0YfbI+/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJulTngSOyehBIog18BwfjlTxn/JKE5BVlUmrSUaB0MvA1hRyNYlSFf1mhoaImIFa6dXUbcjC9iEfDYO8RkXHuYR1Uh6UCylDiVWQW9UaZQzf0uiGeYVkuscNn4Bok9yJQeLP9xdNrngHpI+u2wG+bdDbOH0mC5fVcdtrKKcgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1rXeHjW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5c18993b73so200453266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241370; x=1761846170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgjwodffJXCXV9bFCxRQxHHnhjnX/ahOR9pMrTqBvoc=;
        b=O1rXeHjWSl+Nw52FXcYJ61T6RoKZowNj42LSaJKMKlfLNKrgp5ByBffGK2eo17Tijg
         q153QGRNeN7LYb5LnEKgSW1kdLvRbfo6HkIG3nnlEpCn4qigkHLzJNtrNqw++LRwDpaf
         sJi+eh9ebDwna/h8UVtfj/U/2g5ACM2Ky9uQpZ8d687LCgFxX75G6JP3jiQOB4LHoR/w
         QXLT9gS8lS1nNq8oMp/ix19CjbuRL/wdBYrhrWPVESIxGwsKftRuflxic9ndFf4SwFDy
         E05iWClNuEs32ev6/C5pLYTdl3FF9XdjkA1sOC53gbQtmEV+TQNogTy95LPXET7LUR94
         TNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241370; x=1761846170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgjwodffJXCXV9bFCxRQxHHnhjnX/ahOR9pMrTqBvoc=;
        b=s7Cb0x3d8zt2bd1vihAXn3FXLEM6+A2FlEEOWUdNnEV6PGvj0AmvBgkkn2Tud4PhIW
         rxQh0h2UgZ9khHOiw8Fmz2ha+TguX2rYWN/JujJHHEe67o1I6fDFkXrofkon+QmVsSFC
         KT/u+JMS95hHjxOW607I/jxKROKW3/WhHQqsQlvwxXy3ArtY6LGwEH+tA0+sFJ9DATlw
         rPX01S/KwJ6aEvw0hQB4t5NZ249ImtWYMuvwJRvh8oeal2lHMQR8h+fwVn5B2buLlV+k
         AATzXDdgOM6gIWSOMJioEfDCgQxZj3P1MzafqOVq33kLJwlygu1SM0SbYbYYoYyXbpaC
         WxnA==
X-Forwarded-Encrypted: i=1; AJvYcCWMej/JNKYmIzcBK+rEaPq0Kw5bqeOQqYXG3GrtUp6+Z4yiktY6rQcwe6pXzvto5AG1q6e5fTBcGRqkyoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2J+K2vRdLQx8mgu93e7IkQHMCofneQ+mpY6lOBGLVtXHui47
	QOtUbuU+Ud5LSJjYCg71skCGjiRk77S8zIDl4hvcHkP2LZdGXMFqyJ2QW/psdxIg0z7bnxWSffU
	vyvgWFKVbU9/vTQH6E/LEoY0Vnx1WznU=
X-Gm-Gg: ASbGncsSD7U2+WN6nkGdPG/kXwk2ygGN+3XIs+MKKH7vbstiEhaG++DNFxvSpeDEK5X
	33D4JXTqTMCzTzoVMgW6ULt3t/kXUFfByysjqIQhu0aN4H2RPgyR7/2z886tXuOzAbilcx3Krv0
	CC+0oFbmbN3aY5ohovef8YKc2kgfYusZh+OoizJ1ZikjqFLP46mwZeBk9hIn1NPRqF7rPZ5hUC3
	nbhN0wMXnpY4nQq3OkAfhqxqBAL82PBEstXWVSneVCHbwu4v04EIrmC08mF+viHPYPDSjSQJA==
X-Google-Smtp-Source: AGHT+IEKQYSOEcrZQfp4cJ7IkzzOuPov5OvT9VKtkMyLr8PjhSdzUuJ0K2NylS1MWdT9Z9LwTFR1Qn2IXWVMA8nvEAc=
X-Received: by 2002:a17:907:2dab:b0:b44:f9fe:913a with SMTP id
 a640c23a62f3a-b6475d04cb3mr2843914766b.65.1761241370295; Thu, 23 Oct 2025
 10:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
In-Reply-To: <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 23 Oct 2025 10:42:37 -0700
X-Gm-Features: AWmQ_bl7HHHe3F5m7s8SKqaEwkR90lx0Ku2nfc1LYSRH2AGyQ13C81borZW52B8
Message-ID: <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:34=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> On Wed, Oct 22, 2025 at 07:28:27PM +0200, David Hildenbrand wrote:
> > "garbage" as in pointing at something without a direct map, something t=
hat's
> > protected differently (MTE? weird CoCo protection?) or even worse MMIO =
with
> > undesired read-effects.
>
> Pedro already points to the problem with missing direct mapping.
> _nofault() copy should help with this.
>
> Can direct mapping ever be converted to MMIO? It can be converted to DMA
> buffer (which is fine), but MMIO? I have not seen it even in virtualized
> environments.
>
> I cannot say for all CoCo protections, but TDX guest shared<->private
> should be fine.
>
> I am not sure about MTE. Is there a way to bypass MTE check for a load?
> And how does it deal with stray reads from load_unaligned_zeropad()?

If I remember correctly, _nofault() copy should skip tag check too.

Thanks,
Yang

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>

