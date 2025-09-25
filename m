Return-Path: <linux-kernel+bounces-833004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29776BA0F56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5563A1C254F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5830F937;
	Thu, 25 Sep 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0AWV+MI"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF61DE3DC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822884; cv=none; b=dfjcP8BuXDnLf1xq3TGWC7bQYNvD0rGqun7i5m/RRAE9sQagKBC4tI1M383yj4kEiPbQ9q0qpWhjBHuxeV/DEMI9lTVbquIBj3gJ+bTlRFCNU9/Sr+cYQpHPCcDk3tE23/HcxfRFVqQBtc3jD70yyZqEzsmzVInDIPGrxlhfy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822884; c=relaxed/simple;
	bh=lIUtbjbIbsfK1r4Xju185bI0WV+9cWBrGEyQD1jmbPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Z1t2E3rKNVma0SVj9SxDEOx+tAQk1JEcDo3V9AJvIYpRGhC+C7Zj88lhjYDyV1Ajl1tFk16PijtXhqFPZyb71SDFbWRqpLFco35TOCFFj3euFKJewwRvcdY1vz12IIkSgyIDqRelg+q+I423UxwVtUprrB5KcctY2qgiJFej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0AWV+MI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1203606f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758822881; x=1759427681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz/FU9gMOI1RQz/pPYAELxAXstJ4fI13ftJQ5KfyUQI=;
        b=T0AWV+MIzGZycvSFPOBnEkGhRISCcZGDIE1M2v7rVwqC+P0bAY1lqFh2DSluBRUr0e
         EtALEq6DcqhOraMrH4uJiPUWd7cMZOagYSfnQaUI/kZM5Nbxd/YPx37mI4TbIIR3gxfe
         Wj5EjNupkGKf7VglGpgRjhpqVHLGGE6JACkbQh/2fFYD3AaiLZ1ZWG0KVL1F61eX6BQt
         YhUUSWXs2ssrMRKKCeenwPsVKB1iYM1WzZxaMghI/yQRfzrOcmI9GABvMHtf4LgzX/Dc
         Q/hZshE2WmPcHPwtvH9ypRRyEIoXnQ0jjQhQaxFkX5JIHsIUFLrWkald4m2L2H8duHFM
         q7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758822881; x=1759427681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz/FU9gMOI1RQz/pPYAELxAXstJ4fI13ftJQ5KfyUQI=;
        b=op7umjs0p0ftAyJKUy+CW0L6OK6Snxknp4C5/oALdhJsLEGQTMCwecTDKkRQGcfLEk
         vyyzzIrT3riJN/YHpBGsSfucDOsEtDIS0z0ACVgD4MGLVNUKkkofVLOjmNlY8ksmwM+a
         aemz6FYQNAiMobv3+iI1JIbqdSXB3o3Io1RDtnreXSBQQzGb8Ails8H1QuaLUhT9rb8V
         DkeGuujeJ3US7aqOiwcASYgFsjYEOjMHRtvtxtPojPt92E3OJv9wvOs5pif3HMywDG5Y
         qxwHRqPsATA7vxTzGzI9sjbREX2cH94SBk+J490u5ku3mu+t3kvDci/6bwHjXhbW4rVq
         BWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUMKZZQTUjOafFMOf95Mgetyo4IxRJAEtUf3XgfjHoEyDXnF5C5Cn378X8yuoBykNW72VNSn1jOgktP+eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoa3s/YVZTYuZer4UeLpYGU4wVeB0uOHbMzjF9Fw0Tb5qKKim
	VQSPXmkNVLUIz6tzzmOYdgJFv9agct7FtQQKvmPifOoWe1NjF9eGkyjvuHxa1pKkgjruza1xRgb
	Nt8RxuUG56fIbZlYQubfynMX9hy+CzEJjn7mBdPGk
X-Gm-Gg: ASbGnctQODZLt9MeK8Ww2JGnCf3gGyntJjc4pO6ioo758GTYJbdARLBSK+H1QPxPxFN
	TY58+4f6UnjbTwW9XXRhogc9X4tlOUtXnaU4XYcoMhDM8sM9/N2LKDCtJx4o1n7+QBK5FsSKQNF
	hNeGx6E27M7OzPP3NWS86mTpcgdsLJIM7GPy/QmAemLD0Ragd1VPCcu6TMYdfKSGkdoHRmjw4qX
	0Rs0Y7SErpr58qqsaEfbYBFqw==
X-Google-Smtp-Source: AGHT+IFzhjepmcnkySqZnqtGL/digFIArYndMvrBK8eZnF0PUW11M75uUihTaOx6kNBLQ87MKzuyVbx9HY7bWhwTHhk=
X-Received: by 2002:a05:6000:22c7:b0:3fd:bf1d:15ac with SMTP id
 ffacd0b85a97d-40e43b08da3mr4411702f8f.20.1758822880702; Thu, 25 Sep 2025
 10:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924193643.4001-1-git@elijahs.space> <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
In-Reply-To: <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Sep 2025 19:54:27 +0200
X-Gm-Features: AS18NWBiws6t4fAdWzQ-PgXG_fzqdadithN1M-LZqvce_KX7s1jnm83BsVbdFZg
Message-ID: <CAH5fLgiRFMyXkcx-CngRQOdYuJMkoTdXTOjGsdTYizvApArrmw@mail.gmail.com>
Subject: Re: [PATCH] rust: slab: add basic slab module
To: Danilo Krummrich <dakr@kernel.org>
Cc: Elijah Wright <git@elijahs.space>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 11:54=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>   (3) Implement a macro to generate a custom KmemCache Allocator trait
>       implementation for every KmemCache instance with a static lifetime.
>
>       This makes KmemCache technically equivalent to the other allocators=
, such
>       as Kmalloc, etc. but obviously has the downside that the KmemCache =
might
>       live much longer than required.
>
>       Technically, most KmemCache instances live for the whole module lif=
etime,
>       so it might be fine though.
>
>       (This is what I think Alice proposed.)

Yes, this is what I proposed. Most kmemcaches live for the duration of
the module, so it's no issue if they are global.

Alice

