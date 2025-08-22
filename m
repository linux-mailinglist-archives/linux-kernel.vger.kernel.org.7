Return-Path: <linux-kernel+bounces-782723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB39B3241F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49764A262A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598B338F40;
	Fri, 22 Aug 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp/8NIYX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856C3376AD;
	Fri, 22 Aug 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897760; cv=none; b=eOGUVLEUq7arfxhiE9xU7B5TlaLOm6enqeUiirmkUX5tKyEIDleEq5vEG1grdMFgHWWRw8jbqoDv6WV6uQlg3HwJTnui4yhxmIkt69xHP8vuewfOwJkmAimgpnxK1JLXeairCDjR0xtTDuOAa/r0PvH0aILQP+XAaHvp09BlIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897760; c=relaxed/simple;
	bh=aCSTjYr12dUYeLAkvTB+CfsEAse/ghwdrgANbodpUOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4My3g3FMu06mEFNbaWEMJ1u5SG3Ro6kmIiYG9X/7ZmGTizWpJ3S8VGs4qwml8s5j0QmKp/nkQGEiN00zmE+s7Ym/0MICaQFqd8fZ/VOI/Ha/zYam+/HaVR/OzCtN9tx40MyI1ThdpCP9RRPUHh5WYXZFEg+aW+p/caFBbvuVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp/8NIYX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-246163711caso2893915ad.3;
        Fri, 22 Aug 2025 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755897756; x=1756502556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzhtckg+e3wTvW8hXR7uEUObm+QutKm6afWZX0VLa3w=;
        b=hp/8NIYX0LSm/cPgmotR69L3lNwRvPkspQqKmMULaSCqLlbXSQm5mdmsvPWV+6tqly
         9VBFL+CNEt6wBu5Q8VFsLSHpPYYWXN/XA6w+6k0UNRykDoXbDnDGC97xvUg4XCcPUUu7
         OTZZaiTipzGIO2buHvGS3PoFXM8YwatI266XA5uF8K+luWnZy1apUssClOfSI8OMZuRE
         wMNOYzMhTBNS7PQc4B5sXuxi17CZYH1HZOZMi6t8k6oc9L2GAxp553i6D82CBa0iAmc+
         kxAusA+zqFkD4Zm+C+HkHZ4wUAmxdlHWOb9lKWKYz8w0sMXdf+a+3qH3uWvCZ3AvSB2k
         FUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897756; x=1756502556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yzhtckg+e3wTvW8hXR7uEUObm+QutKm6afWZX0VLa3w=;
        b=OXRsWiE6gSv0P+cB2ioJgDRCu4u4p1LhFp1UdVl2yn9209bIyS9Yh5AIcNzKbdVqJd
         ORfFV/mzPF2Rwb2VN7GdaWVNLO8ag+bRF07EgiJd/iHtsdS9VBGctpOHbTmkU86ELeQf
         aiB4ZMKRAnsqU9+K1hrTqmLzYbyQzQFEm1C0yDkDXy/t06tGVl7fH1rni30GwMCVxBK1
         w/oF5M1oGVob1BqvLEoKWE7oqcZVtG1zGjq7DoWhlWYw2VDfGZr5pHkVlfgeqsSwsO+N
         lCuzsnMfXLD55LZCE4G1v6pZ6JMnzAQKmN9Q79nXFWl3zklHLAqlKf/AcHCP8GXeiSa6
         1alA==
X-Forwarded-Encrypted: i=1; AJvYcCWMHTg7QbRJf5LolcyZFFYEuFU7gHhSdyCiPzXz6gREA1nL9Ld5YWTffOF6oSvDVU+JGoSuC/UD2ofa2yU=@vger.kernel.org, AJvYcCX20D/pr08alVtLt72Q0biLJWOk6/bs7zYtEkhpB/lgLLjh33TeqdfO0NeHuWYCINpbIIHshMAPKrah1s+BuLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQKtGPlL2hpvvyrxIXDUjfk2WetPmTVwVYDYWX/BwG8Z0LNKgz
	1vjLWeX6Oz3nhC9i6VAMQ/zJuIc/tPSEhOTXc0jvA5udiX5uXR9mo+HmZl49FafBeCZZSKn7T/7
	mCJX6sPYlIfio+Y5i3RbbyuU0xKeZZKY=
X-Gm-Gg: ASbGncv/C69cHkDY7UokEC9ZgkpW2/9lZyDxzIRrlaA8NPX5kQenbk48SH5Cpm636i4
	7/Ziw6EGSgBNvP4g/KMeg3Vo7o3JBJhZhFxxC6W45QavxgN50Uk9MHuOz/lpDEKblWQn7DH8Zev
	E4H3ZiqRtY8tUnmgkSw8cs8hjwTw/MiGg0dy7Bqvti70bf0VM9qPvaeXpuICW3WuE1din/lSI5a
	cD/dLOtU5CKn2P46xW9W48GiI8u9Fd/VVQqxFX7vKrbLFRZPeonnUE/WDjOJZSRp1MorLXHnoT5
	jrAF/Twata6gaKRAOuUpqkG2Tw==
X-Google-Smtp-Source: AGHT+IHpTLoLMzrhDTM+fR6j+pavoy2bgPuI5ZiAywuOKGqjCTxDu61UbwRm7ObkpkhJJWbvMkHdh7mew6/Pb/9sLu0=
X-Received: by 2002:a17:902:c402:b0:246:7702:dfd9 with SMTP id
 d9443c01a7336-2467702f08cmr1356055ad.6.1755897756025; Fri, 22 Aug 2025
 14:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com> <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org>
 <aKRx8xsY8CpzbeEm@google.com> <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
 <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org> <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>
 <DC8XIFWZN1SE.ZZP90D2N843X@kernel.org>
In-Reply-To: <DC8XIFWZN1SE.ZZP90D2N843X@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 23:22:24 +0200
X-Gm-Features: Ac12FXzfzYShObxnsby6Cr2atstzxQL8aJjurXwQXu6DbRAE7q9OgPyAk8odYRk
Message-ID: <CANiq72nJiJ4K6jy17x-YRYnJpjqTnohYWvoFrLkYQp0X4tLL=w@mail.gmail.com>
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

On Fri, Aug 22, 2025 at 1:44=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Why not? I mean, the above is cleaner and more idiomatic with or without =
the
> lint enabled. As mentioned, it's even the showcase that has been picked f=
or the
> documentation of Result::is_err_and().

Is it idiomatic, though? The example you mention comes from the method
itself, which is of course the obvious use case for the method, but it
doesn't imply other ways are now not idiomatic anymore or that people
have stopped using `assert_eq!` or `unwrap_err()`.

It has just been 2 years in Rust, after all. And, from a quick grep in
the Rust repo, it doesn't seem they have migrated what they had to the
new one in that time.

Also, do we expect to use that method in normal code, and not just
within asserts? We haven't used it yet

As for being clearer, what we want to assert is that the cause is a
given one, so `assert_eq!` seems like a natural choice (and it isn't a
case like `is_none()` where there is an advantage). Plus it means it
is able to show both sides if it fails. So it is not a clear win-win
in my eyes.

> But especially people new to the kernel starting to write Rust drivers ma=
y not
> even be aware of this fact. If they see some unwrap_err() calls in exampl=
es they
> might not even thing about it a lot before starting to use them, e.g. bec=
ause
> they're used to it from userspace projects anyways.

We still have the issue that they will see the `assert!` anyway and
thus can easily think panics are OK. I understand what you are saying:
you want to minimize those cases anyway.

> I think we should do this; I really think otherwise we gonna see a lot of=
 them
> once we get more drivers. It's just too convinient. :)

A potential middle ground is to apply the lint in normal code, but not
in examples.

Or, even better, we can actually only allow it within `assert!`s,
since it is a custom macro I wrote for KUnit and not the real one,
i.e. enforcing what I suggested above [1].

Another one is a lint that just affects `unwrap()` and not
`unwrap_err()` -- I think the Clippy one doesn't allow it now, but we
could request it. It could be combined with the above so that only
`unwrap_err()` is allowed within `assert!`s.

We could also go the C way, warning in `checkpatch.pl` about it like
it does `BUG_ON`.

What I like about the Clippy approach is that it can be locally `expect`ed.

Cheers,
Miguel

[1]

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd87595d6..86ea37319f7b 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -160,6 +160,7 @@ unsafe impl Sync for UnaryAssert {}
 #[macro_export]
 macro_rules! kunit_assert_eq {
     ($name:literal, $file:literal, $diff:expr, $left:expr,
$right:expr $(,)?) =3D> {{
+        #![allow(clippy::unwrap_used)]
         // For the moment, we just forward to the expression assert
because, for binary asserts,
         // KUnit supports only a few types (e.g. integers).
         $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);

