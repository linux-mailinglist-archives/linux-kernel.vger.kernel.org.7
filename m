Return-Path: <linux-kernel+bounces-893019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BCFC465BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9520C4E9B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02229309EE2;
	Mon, 10 Nov 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DddieZtr"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4462E9EB1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775235; cv=none; b=qO5vHabg1+rWtsptBsExaEbBp+apU6Zi4mDGO0WOiMrAvFy6R/qhX2akxKrRKPfmn6CvvZKnbFELn9tmjyTHnw+hTytfSJLOiLTvS9bS/+4DrXeEPQm+n3llsyRIHpM2P+OX5og8SJ/YKNLA+HjB06nJlxs9aqVrTxRNiG6x18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775235; c=relaxed/simple;
	bh=UHsZ8mNOG8p7kZWeRQbdvDX87iavcoicnA0ph7mCQpM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1sChejIWzk5MgqQrZxt7xMKF4aKYuoDvrW8wmVFkl0XoB1MaTbvkeoHmTboX+vE+iTqO7/s8lfsroay7AqnMUiFKJ6SVV3H2zj6R9IRyn7aYkCdRLT0rKlrXda4LsCu2oGgl63R1LuK8sRVgg04DrY/W7Gt4grtCDCXdBNq/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DddieZtr; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-640bae7d83aso3049808a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762775232; x=1763380032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCZuS6iBZ+Cb2EbxYt/LbW22Q1kNekqfCyN5WYEYrk=;
        b=DddieZtr+YcRU6AGymXQ6+qbjn4EqfaO1LTBmOwgNdwd2GljS7zyb1RqN14kryvqia
         N4CCnwoDamx2Y13a+sxDntiCwG14T10uI1J2PP2gs/++M8u8KmFDWeVPTkhGVJkd7MnX
         /oPPoPxWLKuq2A52BHO8bifmzBZtHc3liXMbi/+mGONJAWn7rZvdMPNGtvI33lz2xU6u
         ysPgqzNiiCIF6TMslrx6yVp6I+MC/7t7lzsZtPs0OPXVU7TcmmQeLvkTdztdQx04qOp3
         vFq+6Tapi87i1kL1hJdKBMxmoC7UO9aI5evD46DVTYrG6830K8SRDB/frUImVwp3+4NW
         P3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775232; x=1763380032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUCZuS6iBZ+Cb2EbxYt/LbW22Q1kNekqfCyN5WYEYrk=;
        b=ZajAUpTZEdJUJEGFzCRTy1tgQfrE+6Ig+/N0WcarulZLqk5jSEIE7syj5CkV8zC/C9
         WRGuoiOptBiZwLqrOgiAVfGi0bre5GFQ6WCV04hBlTbn5ozCxRXBMXFMNQ1fsOti9Ked
         rbeukIA5JijbxT6AbQ6uTJlK+UWrpB7jsYhvgga3XSwxSXW8GqN7/0o5oue9r+k5ZmKd
         6B+j4kv43gpvz/++YUWHVdmdXyjYO/KuSptTWUcGYWUnUiJq/Zzd+Bg0y4rVbUJ1DJZA
         bfIk9qdH9edV2xYbkVtNfs2d8b9TwPXcsxZJZ0k7SBI2Aa6llrviIaEA03i5kSSqHjtQ
         pUog==
X-Forwarded-Encrypted: i=1; AJvYcCVRPj1Cv6sJzIJjx2rWJdc4y/YAQAarNX8+C53JeHArce9uCwCgOSYIWXuAlw6CQ0iVcVQV1HBFlf8Yb3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYVWlJ9LcbeDax6YpDVzA0xiC2uYWu+r+ggghzWo3dWbvL5YZ
	Ci0n22ooauFi/tJkaOgm4KngV1nvamH8ghDESdzxWCi1TNqrzESNe6QV/sR8P1StacXZuo7S6yM
	QMF72eS84Pjtf+QxSlA==
X-Google-Smtp-Source: AGHT+IHn/ARWRXnaz/QbEvpiXa66T27fjTbhbGtpITormFJQJJtBcOuO5FmSZ0Htawn8t+iKKDuDiXxfGYOF77I=
X-Received: from edbin4.prod.google.com ([2002:a05:6402:2084:b0:641:8e3a:1196])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2106:b0:640:ef03:82c9 with SMTP id 4fb4d7f45d1cf-6415dc11781mr6885792a12.11.1762775232291;
 Mon, 10 Nov 2025 03:47:12 -0800 (PST)
Date: Mon, 10 Nov 2025 11:47:11 +0000
In-Reply-To: <20251110095025.1475896-17-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-17-ojeda@kernel.org>
Message-ID: <aRHQv14husHrYpl_@google.com>
Subject: Re: [PATCH 16/18] rust: syn: remove `unicode-ident` dependency
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Mon, Nov 10, 2025 at 10:50:21AM +0100, Miguel Ojeda wrote:
> The `syn` crate depends on the `unicode-ident` crate to determine whether
> characters have the XID_Start or XID_Continue properties according to
> Unicode Standard Annex #31.
> 
> However, we only need ASCII identifiers in the kernel, thus we can
> simplify the check and remove completely that dependency.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

