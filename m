Return-Path: <linux-kernel+bounces-892817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D29C45E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518AD3ADD38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6EE305064;
	Mon, 10 Nov 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtgdWewe"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98AF3016E6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769973; cv=none; b=B3kA/RdjxMvBNji3a1dgEtJ7uEYCAzD/8YV/UVDexlghBv/eHJz1nBm7T72EsJV2kPyy8e0sMDh4UCyxZ0Fcg+9kBzdjFNfdWpohhtMYfvXIlrJNE6xCEba757n6fJEysD7n7CVrWB7ErO3IziJI38RBhmfxZVRZKDxV0h+1G3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769973; c=relaxed/simple;
	bh=2GGpzP3+SpGhGrCwsh+gDg6Isv8qPzoSRYTGoMRT1HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbV9elgBzXVCSfG5AowPBkQqW3G9+j8Dl4nnhg8BRFzAsYDFSgwczdgAIL7ypgyryTLngxEdrHIU3eGxL+Ree6exHXlCdn9e8jpSnI3QQaXBEM1IZA/BFjEWJ+H7eBL+5nkr0ieB6TfzlGmVKdE13/OiFq+NgzM4fYAdhGv5kpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtgdWewe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d6c0fe27so1581775ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762769971; x=1763374771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GGpzP3+SpGhGrCwsh+gDg6Isv8qPzoSRYTGoMRT1HM=;
        b=UtgdWeweR9/lv6NVw6Wfskc4r1yK5dmSL88Ilk8tToguCJvbTy3KaX31nBMjnWqBhH
         zP8dPw1PXr4unrBCVUnPtluVN85l5Rk2NmbFukFlGzx7PeX+/ApRK6nfSamoVeayCDfR
         tGanf1ibqQz8KINUU1zYsxsAVSJur1z4NKAxl0QbeOtTAo1c0Wn1iyuUWV0DlwtV1hOo
         Nbbz/2UD2WXXi4x29arHg1iEo3crsCNa0NoTEIsP6JqFljg+tKMEgosDHoaXeqQ9eg+8
         BF/cqDk3dPqtmkCKiheRXKbuZOnmy4yZDQWhSPnlKqeQPRYbKyz477rinG9exoPEskPP
         w2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769971; x=1763374771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2GGpzP3+SpGhGrCwsh+gDg6Isv8qPzoSRYTGoMRT1HM=;
        b=eemCcP4KtJJYqgeiieg7lkyP4FMs8uH1PR+8wb3EnVIw8uMxREvrBwfv3QgTyeco5j
         P8kgCuWgGEt/INXQX+dpEEYNPwuNB3HJ3RK+fu2HxQibmf0kxBB1vwNQKkXheOeKVFlV
         3wOZJ78O9/xHZsxdZ0GKo4zFT8VzrZasGHf2zwq18M1GobQjWesKAfD4irO6KPSm7y7q
         uMO9QNwu6DjWsIuabG2EwJ4OAG9upWxCQ8KU8xSBPxQkjgarHVxs+w1dQFao8AIL4jS1
         V6VWfv3CT9FVJUfGe2o09INJEbbwCwMzwaGKSfhESVZn7MMFNYJx0szvjlMw/GXjN/ni
         qr7w==
X-Forwarded-Encrypted: i=1; AJvYcCX0PUxXWXU+Qcs0n/exCVISr4NWkNwV56CEKHZq78gABYzEHBFYndfnvO1i+2Tvu/3gV4s40YZDwhXYCoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqEoGCk6Hq8jDoMZJGJsgFMmj/AIiap3cgi59zLqzrQLmgOlHK
	kyYcXGnLMdRHOjU3sgcT4XUdPfch/CCBYaVik423E6PTxduF63zLvwZOMNssRWEC5jEGtFqflLF
	xbkbIyKzKGwRAUWMtwz5TyX7Az56fT3U=
X-Gm-Gg: ASbGncv4Yr3qmiwAYKOV6e1hhxB6MFVLpkGzD4t8Wp2tZUnNTznniRJxyNpognfNV2O
	DZxjMw/6+oEoOt6yPX72oTUh82x4I9n+A7ppgCFTbDLiKHRKvgcgmJxjLMsbjgXoekAzhEgF8hI
	P2lWQ19IM21i/b0lpWAdVtUqV1wKik3wkYvJXOLyLFo3jPMeUnNYhlJD3WW5y9K3rQ2OirMO6gC
	PN+1ZmFTOQe9UFjH6dk3hL2F187mBFd6BQi9H2E/z7o2prW68/wjJi9khkcsse172aQP6DElph/
	p10np5royq+w9UsjJLudgt96elO661S7oR/4vs8FgufX1JLpu/I4/tk56xHV4NS1RycC/Kizzm2
	+WlvGWjgg+x/I9Q==
X-Google-Smtp-Source: AGHT+IFdFdVhwPLfh+yTbdERl64DQLjGM0Rh3dpM34UNEX4KxB1YYZB8zJPvvmK5YGpWecjSiRSDrXRu3SuqxEmyZWo=
X-Received: by 2002:a17:902:f683:b0:297:d825:bf22 with SMTP id
 d9443c01a7336-297e56831acmr54002375ad.5.1762769971269; Mon, 10 Nov 2025
 02:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-3-ojeda@kernel.org>
In-Reply-To: <20251110095025.1475896-3-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 11:19:19 +0100
X-Gm-Features: AWmQ_bkb3t3uALt-6fRzPMlQAGQiJXQm8chK-T8Qof8lqrSz2aUgJvRPu8rtcUQ
Message-ID: <CANiq72n2TDN9oa7Yu2otk=HfpJQ7NA_X=up4uGO=JszGvaGspg@mail.gmail.com>
Subject: Re: [PATCH 02/18] rust: kbuild: introduce `core-flags` and `core-skip_flags`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:51=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Thus do so here for `core`, which simplifies a bit the `Makefile`
> (including the next commit) and makes it more consistent.

We may want to eventually use `--cap-lints=3Dallow` here too, but the
skip flags here were already feeling a bit more than needed for the
series.

Cheers,
Miguel

