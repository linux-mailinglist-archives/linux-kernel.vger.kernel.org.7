Return-Path: <linux-kernel+bounces-781752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6DB3163F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DDF5A57BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8532F6184;
	Fri, 22 Aug 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll9lo01E"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE72327A3;
	Fri, 22 Aug 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862001; cv=none; b=R59MBkcjXCstT505qbiCY53XSUKiZVbbdrUOyvHPaqNtTOckUgWxkZrA5Rjz52sQmC3Mp3gMWdGiXYQbOh4t6S1E8o9j9yWnHGAVp/Zfzx3zpxwvd9jjGD4oUqe3/4v2qZq76KW5SrVoFHjXYrDI3YV0BUCaGJ5HxtaL86+fLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862001; c=relaxed/simple;
	bh=IwBGRNdvq5qc2H6uJiBzPwJauMWm+ziyJIotPpOezCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVq+kLU7L8CGXZFopT+lx0TfwYStcdUHxkRg02Qb4dNwreTon3+z7kNwPVef1dEBUTCzmYZfmcBbo+rkSqPT1AhQvmJiZESuzZ4MAFTX2vbmfgv7oBmTvXTvFCJxK4+Rb/OeaZx1M3+H6iuBZyXifVG32iWgd9xDgCHrES79TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll9lo01E; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2462ae29714so1322225ad.0;
        Fri, 22 Aug 2025 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755861999; x=1756466799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4wnIhr7Fp6tVW1RFz7BAgUt4LWPfblWhtXcE7RFhfI=;
        b=Ll9lo01EqD+RX280M1oX6vV86wWSnXTESMQY6oX3awBflIvyRcrycNkD2sC7lWXD9l
         /z7RwJK6o3rsPYSswiK/4nChTb+WRixf/C5b3P4mem6jwjK/1NRxWI4qw5ky1eLvkbUW
         iemU/3xgcjV5YNH041Z6S6TXgVTLyVJEvIbO/Fmkae5+0eixlEH06qAwayVuPCTSqOrJ
         hwlhHl8FW/+c/Nl77rFm3tcfLJwURoVTnpK7XeEcszJfcVKXFm8PF54MS659TB5PGmx/
         NTX78co0Z+/RwYs4vsJhIK9SrCBK2/97gamzZTvdZb9oea4pyj0y55jHL1VhcqcKwdSP
         sJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755861999; x=1756466799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4wnIhr7Fp6tVW1RFz7BAgUt4LWPfblWhtXcE7RFhfI=;
        b=iLvT8QJXzXqiCdU/UAhM5dunn0xHsVILQetV3ww0qXMFeUW0nqE7ggB88l3s+R2x8V
         X7/yVaAE5xi0qIeHrwFVxlFbLADdKm009lsXS4AynTqYN2sI4Fm0rhwUE1rgefJPO/h+
         M0p4z3EQzuyLYf4ylh66HOdxa45TMaJAeuJswwXNXYKTqkvsVEZupHIlsUowaEq0KEhm
         M28sjqZRqBQ8IZ0KGkyfyUKhYw8f4MZNtfczntg1dGjdvihH2QV+6rksSX9PW7P3YPKl
         BMy4spCJYuz152b9fC5+FFlb6CQgYAE4nkPLwlc+y1ryKeDCJjCUGY9OJLAVqWy3Au5R
         dBng==
X-Forwarded-Encrypted: i=1; AJvYcCWLp/QHj/Qa/BJ/XGSiZrqLWXNE3MupIzXVndcwc52ALw9GvuDlqlh0bmCrjxYIyh0KbSwnNejWeEx+PC4Q/so=@vger.kernel.org, AJvYcCXbIhWmNtUAYdtrl1gj2XH/JXZb63Xp+WzYyYWdIioCTBxJ3YE6mmgVWLxxCBpE5G7PWC61GjZZDy8CF40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfZC0eFV006h8gfQSCCOVAsqetyUSXaqH/w/oCZ3txML6K9eS
	4lMegqYSPUAGqyfZqIvO0c6BIVANVvQjjZ/G4p4MEk80I7wcav2WkluIjrXsLFp+6Pmo9ycQtBr
	yujeIVlUKEJRwaQ8SJeKB6jhkmSfBsNvmRguZ2PU=
X-Gm-Gg: ASbGncsgIVSn5fL2IvBljiOgL01u8po/6ALsVirYdlXFyCos3k8r3xTynMvSgs9YTP9
	/eEot4xb9pONVhchVLauasM/csDIymCIDKhK7zueCvuNynNzY6lpidXmpFQHze6Varm3jh2MOCX
	3Au3GuYe4AgiylCnTM5t98f6QbwUw5krRSWi8F6+t2E2V3mj0okalS7rvB4/OsPOoN38WkpHPa7
	0Wp327trHeS5sLugtDFTnaiewJLQHkoPQJlNwG15+Zfs8Em6WlHTq6Id8/kbEoVTdRFSIYk909i
	s1pLyFL4e3++Am/wchw0mlL2QQ==
X-Google-Smtp-Source: AGHT+IG7lTxmuhL62ZlvYH3P/Mu34+dY7fv3Q9ryPId3zBRUb9VRVWQdWMfwHCvijjEssnYIFiSuiqA20Ad2iN5Drgw=
X-Received: by 2002:a17:902:c409:b0:243:589d:148e with SMTP id
 d9443c01a7336-2462eeb1166mr17788305ad.5.1755861999001; Fri, 22 Aug 2025
 04:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com> <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
 <aKRx8xsY8CpzbeEm@google.com> <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com> <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org>
In-Reply-To: <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 13:26:27 +0200
X-Gm-Features: Ac12FXz4tTB0ezj6BOGHpfVwiA6-Ww-CuEgl0dtOx4e2nF3EUki4Y7Epvx3OleQ
Message-ID: <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> We should probably check if we can get a clippy warning in place for this=
.

There is https://rust-lang.github.io/rust-clippy/master/index.html#unwrap_u=
sed,
which covers all cases.

> we could also write
>
>         assert!(tree
>             .insert(100, the_answer, GFP_KERNEL)
>             .is_err_and(|e| e.cause =3D=3D InsertErrorKind::Occupied));

If we want to use the Clippy lint, i.e. go hard on avoiding all kinds
of `unwrap()`s, then that is fine.

But I wouldn't do it just for the sake of avoiding a few
`unwrap_err()`s within `assert!`s -- I don't think there is going to
be a problem of having a lot of people concluding it is OK to panic
the kernel in general just because they see an `unwrap_err()` within
an `assert!` -- the `assert!` itself could be also understood as
panicking, after all, and we really don't want to ban `assert!`s on
examples.

Now, if we do get something else out of it, like enforcing no
`unwrap()`s (still bypassable with `allow` etc. if needed) and thus
removing a class of errors, then that sounds worthier to me.

Thanks!

Cheers,
Miguel

