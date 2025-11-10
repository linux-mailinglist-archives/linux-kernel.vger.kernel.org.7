Return-Path: <linux-kernel+bounces-892844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83349C45EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4815D188EAB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760E30AABC;
	Mon, 10 Nov 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc4DnVVO"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999ED307AE8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770388; cv=none; b=hL23ftDbu77N0LYsA1JxOdUUkB+laIcI+zZRVS2SfbK9KjJwY4Sma01fL7MzP981cmjoMBZ8ikH2sW7OPxpUHvKjSSCpfsO8ssaVUK/XKhzD7BW96mv/jM/FUe5+oYpM1GjgVOEasX6mz9e3x8ud1Tu/LzxET6cbOWDzvzVtrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770388; c=relaxed/simple;
	bh=by8TIrFWHwZKFzoVR4uqzhkqjIaA/Zdl/PpOV94g580=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4ivc55EMxSX4glqAmHjFapQsayyUncv/7R8tft2Zz6FbWTB775OWhAYYNGl0leOR2YKhXlyPilFUmE2zivI1/mttLeuq4ZDqIRq1y7ENJbigQv6sTAmjio87a9AMqIdDTP78pVS5rEyalBvoUC1OL4EF+HAomCjonqNcL6JykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc4DnVVO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dfb8a52dso1578275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770386; x=1763375186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=by8TIrFWHwZKFzoVR4uqzhkqjIaA/Zdl/PpOV94g580=;
        b=gc4DnVVOk/dfuZn1UleCdaHXfRnTBzfLJQEG3n950vZW87rU9m7oAxZ9a2ka494it/
         non9nHrPdU9AuYzGS2fHnhhGXn1Vwc4WRIliZg1oRuNu5pw3Of2hnD8ssKj+AdxMhJqR
         FV6eFQmJ+GkGBa/ggp7yDAZJ6w1SLUAMJeuzwRUowqSs8weoa/4TAfZlsoGw+IBhlbgE
         xrAS0K7hX08X8+TM7OMg9SNn0GYB1WZBkvUh21OvIbmziYfKu0kWhyxNlu73JHDx6TzV
         k1APV1L1MBD36ThfwZVsiZU44NcJiGr3umtzinzo5o4DsTrZivfST34CBOIXLxsPB+um
         F2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770386; x=1763375186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=by8TIrFWHwZKFzoVR4uqzhkqjIaA/Zdl/PpOV94g580=;
        b=j6MXbyaUw1i+pGu6s+iryG1eSFRvORAmjuOEiSK5rNeDrX5hlej2B7bMmllxZseIM1
         BYu3xYem3QivOCcSRm3nEkKdj7cpztVEuHCCmn9iM3xJRy6wN7OIm4gMggs1FM+Xurbp
         /Z7/VY0F/DuhF1MUr5N44yRmoIHuVCbELwIRpO/5Ptrim1zb2d7E3IJhEQWUvnryNSco
         gpBbObRa/Y+DCnbh/41ZaxhqGk4I9vWFvOKJEUAU7gAE17iaSbpLpxvBjWmtX88A7eEr
         +M4/7jboGrFGvnraxNpgYQcm+tRacNHdRdwvZQKDXXh1+CNDyG6hm9BETGSDaIdq8jiZ
         l/IA==
X-Forwarded-Encrypted: i=1; AJvYcCXfDFsVOyz+Y32Xw1vZ1YOhvX9b93py1F45Wm0NQfBPrUerhnIcQ+DRxhFs19EJqRURmnMPsCLHTXsfH5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCM6lEgovCSixNPUdnaw2/nkGNrstls6lzuhV/b/In2Gex12dq
	zwVTihVN9IQQfrTZB0UXsOk1g1OTzu/lPGom2xYdlAuC0iWnqkq38ses4xVwOkHXy5GK0O1IHEG
	d9fQHOrY/WAlu0omgMLsH1GwT0BWFGjw=
X-Gm-Gg: ASbGncuuRe9oWik+4BdjbZNmtQZQoVTFST3XMFVwklRpJGRMCuueZpMLOcx2iB4aMzb
	oasMaNZXjZzvuOGIUFuu/i/a6Fxh13asZ2TdHpduHiae1y2tyZ62xqOM9/CzFQYwvi+z4Kz0edL
	iAw5Es5NN85oyrfaK0fDjvzKglyBJ0umVpLPw5iB3Ut1TzouSzsJ6Mjl0oGFjEDsYN81qwnzsux
	euriJJDByQR3lSRxbFYqb5Eu8FLTd4FSNgzuuleQ+HnQP6Pa5h9bjTuY3CKQB1RniEZ16pHpe2C
	y7Nws6II8zkhQ9Yr77gD+ghHH9XSHfeoPo7hRHSha644mupk8xOIUTgX55Ar9ARkQEZS9k1CZi1
	+vJE=
X-Google-Smtp-Source: AGHT+IHj/Ik6F63wXenE2lPX1U/3plGIyl6aQSJtE99W3m5oMNrVCs+apSxU4qv0V2MoDNiFGSAPl7exsm++cKNsBSE=
X-Received: by 2002:a17:902:d4cd:b0:295:a1a5:baf6 with SMTP id
 d9443c01a7336-297e56d674fmr53416745ad.6.1762770385914; Mon, 10 Nov 2025
 02:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110095025.1475896-1-ojeda@kernel.org> <20251110095025.1475896-15-ojeda@kernel.org>
In-Reply-To: <20251110095025.1475896-15-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Nov 2025 11:26:13 +0100
X-Gm-Features: AWmQ_bmNF1aFkVdyK0tmwwbxBOtgx8yYVE_IklxhPzUh7f2u3k4oJdZwWsz3eYg
Message-ID: <CANiq72m=dacZijsyb82HYRWc_PgzBOQA9YCSJQPOkUT1O-y2gA@mail.gmail.com>
Subject: Re: [PATCH 14/18] rust: syn: import crate
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

On Mon, Nov 10, 2025 at 10:52=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is a subset of the Rust `syn` crate, version 2.0.106 (released
> 2025-08-16), licensed under "Apache-2.0 OR MIT", from:

In case someone is wondering: I didn't use the very latest since it
was quite new (even if the diff was fairly small).

Same for `quote`.

Cheers,
Miguel

