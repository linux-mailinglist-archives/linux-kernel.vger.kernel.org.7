Return-Path: <linux-kernel+bounces-746069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF39B122BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD601CC6409
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF882EF9A6;
	Fri, 25 Jul 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9teVUjs"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF52EE975
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463550; cv=none; b=J28mBl7Q89GCUfnxsmf+n6pkx2G84IcRRLEnVtwIVgBBQu17jii+p3q6Et+tg3CRJ7WQ2Sut7YkxgEMjlGZt8LA8iONO6sZrEGakD2sda3uDnMKhC7Cc4TXC5qDhkxFQXOpRWqFWcl55fg4/pyqV1X4yTyvs/u2BGVr4vlk5AJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463550; c=relaxed/simple;
	bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/T8tDL3jDd0NKppd/bVznpF/iSAw8wHSHtstDcm3R6muzHdHRlznFfLuErqCAcmdxc6tmpObA+TGu33a7RnLd1EXem9juZsPfyZwTd0ohaurCtY5+sxR3VCT/ACV8XdPc4JVS+MoVFRSg+Zj/IjH7fC9DFsHu9AeTlvPpWd4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9teVUjs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561b43de62so4715e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753463547; x=1754068347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=E9teVUjspWShKsMgc1oLy+m9iwkIFL+C/fjG0YE/EIYK/XzXXxa23KCQz3naomeZi8
         Y8HxbHREoCTKbCdWMqpi2V+pL5yhNCwb3XjQOpjt6PtPOvZuTlPg7RcJAUwnhXriZhS/
         N99P2J2YKRZFR7pKAsOCoTwBmdLM5Jqj8qGv1XHcn5KjgQJYMYIbDlgWyHFUkRoYQF4y
         1j+lHWwY0JnAJesKI32cLe5FJ6iYckQpFND98nOQLNJL/+FOLyytMGPuyCrCj08wDxmy
         idRL64mD3bs2vITGHRXBzT4/FnvvsbQ94mIFPvde9MQ6j7mvhKRS8sEYdovkMvVIDRUV
         SbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753463547; x=1754068347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR/1fr+927w5gHz+7V9YvJuD7wXmf2oW8T6mJhnxcas=;
        b=V/S6akgeTBUx9WYTOYDMvPwABkc9cpC8tgV/0DSz+AbOldWiSTs+E6yiDFgEtZ51Ty
         pqOItNP3CE4FN2YYz0jtbHuGBOekag8ipHkGHCuL67CUjorKyXbHIVzY5iMtQHRSdTZu
         ikkbFj8SS8dN3eUUr9M021hU5vbcTUzkpOB1pZj2iUVOg89PQ0HoGWsSLKv6xkXYDc/C
         2t7TSkCQo4qNdc7ayUk1TIzXBWxMKeOGiXEzRMl1GKAo+wqOBlfj6no3KDSAtjNHv0z8
         K0xavBqc56Eua3EW+DHWsIHKgYleN+mWbjyw+bzqm7qTPvitILEFGaZRnq65bkMT3H1p
         M2uA==
X-Forwarded-Encrypted: i=1; AJvYcCXx7fNvoiwxTvk3jdUAqJQJ9jMg4mUf7jHfYRUqE5KJeokZn8LqTg0pvJcc/KTMVn7rN/3FNljRm3TP980=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6V/nFW0pWxV2mMrOHjo3qI8T9sI8x/BEKR6Bn6D8I/vymycJ1
	O2PZQ9YlZbyZOGpdks2756lSm4Xc8FLglv5DGbIWR2XFSvv831yRwC7kCm9d98d4Lkr4st70GHw
	0w+2kIiaI52bl0gsaySCgOhF5z41JpW491nq1a2K5
X-Gm-Gg: ASbGncuQByelstT+Q6BRj7osb0oOwYWgGKmYbQBaKb6euwU/JgyUacS338bjB3M3nwe
	L4D4pmFT/z/NeYlpdPT2qSsJI1GRCNrFCcWsP2dP6gR+0x2ECcIanN4PDTGWvMZ10A0SFfdWQZ6
	oy38u7sW+PZBnjYH/Q5bS8uU5Qxjb6Sp8MdzKwYFe7rZwUc8hxSyrYKgAyLhS4ULXRXVjFk+Z/8
	1MN6WV6y7yeM4T7p+zicKLO+RA6gfsH5cB59cKCFLWxbQ==
X-Google-Smtp-Source: AGHT+IFhxhJzavWiG8TnAC5bSyEUCITgigk6eSOkbePzjanT6OdYE8Du+O+akeu9UoPZ+9VboPkoI9eK3HhR7G1bjjE=
X-Received: by 2002:a05:600c:1c86:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45874e2b93cmr1367085e9.3.1753463546532; Fri, 25 Jul 2025
 10:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com> <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <8f41e72b0543953d277e96d5e67a52f287cdbac3.1752232673.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 19:11:49 +0200
X-Gm-Features: Ac12FXz5v7hwHYZVZo-PcQftTdDT8-58CkHFg3QHIWJWk_i7JJUmY1B0j5KtsNs
Message-ID: <CAG48ez0KjHHAWsJo76GuuYYaFCH=3n7axN2ryxy7-Vabp5JA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] mm/mremap: permit mremap() move of multiple VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:38=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Note that any failures encountered will result in a partial move. Since a=
n
> mremap() can fail at any time, this might result in only some of the VMAs
> being moved.
>
> Note that failures are very rare and typically require an out of a memory
> condition or a mapping limit condition to be hit, assuming the VMAs being
> moved are valid.

Hrm. So if userspace tries to move a series of VMAs with mremap(), and
the operation fails, and userspace assumes the old syscall semantics,
userspace could assume that its memory is still at the old address,
when that's actually not true; and if userspace tries to access it
there, userspace UAF happens?

If we were explicitly killing the userspace process on this error
path, that'd be fine; but since we're just returning an error, we're
kind of making userspace believe that the move hasn't happened? (You
might notice that I'm generally in favor of killing userspace
processes when userspace does sufficiently weird things.)

I guess it's not going to happen particularly often since mremap()
with MREMAP_FIXED is a weirdly specific operation in the first place;
normal users of mremap() (like libc's realloc()) wouldn't have a
reason to use it...

