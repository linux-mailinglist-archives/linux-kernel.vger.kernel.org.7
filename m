Return-Path: <linux-kernel+bounces-772406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF4B29241
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820A41B23261
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187721CC79;
	Sun, 17 Aug 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHQ7wThX"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B4219300
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419589; cv=none; b=ZhFY1sCKjCR0Tlr+FGhOodoyKVfOaBhLeH5HpgZLQOPc2uNsVYC+malJNT9Qw8w2mtXf3RAt2aif7d4V5wS40Kl8mZmCgdmIePyR1Xem3nnO8t290/J0fbdjlZ3tSpdfgBANr3PlVX5pzUzcxokrbJCC+5VH36RYKC06RX0GiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419589; c=relaxed/simple;
	bh=9F4kZCt6EM418SfE71rTAkC9O6+5xOXqnezhdzokRY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0exXywj0yL3JQVmRl1+tQTlqU0SPP/XIjpsDhi9qrK8nEkBSPL+hc2QXDsSktJUIG9gM6ACHNK0p6EJCjQ0yD2Dh4YwsUfkKOqs2frdMmYFDW0qbDih9gypYoaiYGdJVByzfsoxktHeTZBI+LXVe/Mj7PfytNhMhcr16UBXbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHQ7wThX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3056607f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755419585; x=1756024385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTwTOtGwt6cJGY41AEmiyutI55TEpKyzi4qJ2ueIWhw=;
        b=tHQ7wThX9HOw62audCRFxL49D6LCANf72ifESGU30yOkHmIZz/ZS16DPwJ3JFHBe0v
         Xi5NDy3BSnH8QPEsA/57LoH0w3T+r2+74XxQynJQ8gpN7ivK5jCmNO2HP1Ggp+a9WKc+
         pis3pdetw7I2THUeZe0k3k0dtcsR2FfSDt4vJ2ZqsXw0Weu/8R6uKsMIZfnzqbC4r7Ft
         9r7vlyWFWD8R7sysk/8nwT8cHNR1VOrOdpyjQdxZ/4F3AmznRGmBQ9do2lIeeKA7f0f1
         sTqbc3WDz73brb4OlNT9TVyfDeAF2euMjbHCLDchKVeo6o2682OWstbvpayNFFi9OFhr
         8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755419585; x=1756024385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTwTOtGwt6cJGY41AEmiyutI55TEpKyzi4qJ2ueIWhw=;
        b=mgMSHCAlBb5v3jr+5ohVLENT8y2W4m5ZzMTCsiUG7vOKFPVteR+bwbBosuHQk79vKR
         pd2j+M5xbATKKpjNNF5HXTuNxPbXF9GCqQgGem3ceGKffiAiuFTWJo7j0oXSGU8EQu6b
         H7pMU5r5jb5L1ZwQuKn0SZ0Pn5+fhEb3B9zApy4MVAI0LqKBKKSXLSCu3A6iulK35vA+
         FO5w5A+LsEdDwF3fkdLwgwcH0CbYEV/UzV805LTgjpED/6zEfTRXAgNAKNach09+Pijn
         q9JaGUC7XjWyG5mr3hb3W6zTPRK3GcrHvyXeIZ4iPyDBEFxRaQ/Jcupd0ch2D5ft+IMJ
         5BAg==
X-Forwarded-Encrypted: i=1; AJvYcCUT1MYbFIh1q8DUJ0cUhTsMMFqq495FRC2c24ljnkAW2cm3sRFST+3tLUimBslEeLWM1T1nwBjOUXo/GIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWLgwc9Sd+qfNww1pkFI27WzQDFh2oqKQ6Xj8RuHtSKpxsScM0
	ik3f4FqJL5tg653XIXUuB0n3caXyl1gkdSNoUvlkKnyauO3lvZGFuTmOpA4PhxjC/Y2wRAG//rY
	eMw4J7HJtgvmiRqL12A8b8rjoIsz92jY0mtAUn4bs
X-Gm-Gg: ASbGncuIp1RIl6AFj4KlSIHtyjQQMwj8AmsqeKkgBsau+MP50XuK1GcGnmeSlYzkwxd
	aWAGaIVVjmDdRVtfRpKiHkTWYjwJk6wuQpe1Ov9tJZK4Djo0sD97RyzVJyGm9T5UexdOMNUoX+d
	WIhUeFZtu24/ZU5Acb9ZG9P1rusOfS0r1xgyfvweQTyDFeW4fLpSoDwK57heBK6ODahIrTz6a1i
	XTLvAZp3Rpgfc320+iYnsKIk0yOIPq/p8ts
X-Google-Smtp-Source: AGHT+IGoRb1xdrYrj6kHKejvqdDcCa7iTaEaP7TOTbmewwBY/XYltNC5+vB1zPlq8+D3PhMalwZdmY0KcTb1ScHU0tU=
X-Received: by 2002:a05:6000:430b:b0:3b7:9589:1fd1 with SMTP id
 ffacd0b85a97d-3bb68fdc587mr6365788f8f.44.1755419585362; Sun, 17 Aug 2025
 01:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816210214.2729269-1-ojeda@kernel.org>
In-Reply-To: <20250816210214.2729269-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 17 Aug 2025 10:32:53 +0200
X-Gm-Features: Ac12FXzhd2iFnnKjyXBfrCIdB6O_r4X05qYMnlTOhhEd7NQgiE9g9rzOlA9OUao
Message-ID: <CAH5fLggYHJg+PmLD=Fg2a=pO7JRmM+AqppwBqOBpp6+179YcVg@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: fix missing import needed for `rusttest`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2025 at 11:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> There is a missing import of `NumaNode` that is used in the `rusttest`
> target:
>
>     error[E0412]: cannot find type `NumaNode` in this scope
>       --> rust/kernel/alloc/allocator_test.rs:43:15
>        |
>     43 |         _nid: NumaNode,
>        |               ^^^^^^^^ not found in this scope
>        |
>     help: consider importing this struct
>        |
>     12 + use crate::alloc::NumaNode;
>        |
>
> Thus fix it by adding it.
>
> Fixes: 8405eafa6e94 ("rust: add support for NUMA ids in allocations")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>

