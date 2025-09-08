Return-Path: <linux-kernel+bounces-805406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C38B4882C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55CFC7A765F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE012F066A;
	Mon,  8 Sep 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkNbTAYU"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861792EB5B3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323320; cv=none; b=B7M6lIIsz+bIV1e3pNLGYppUEw+1MPgP0POVe+LKWg3Mjiv6XHQTMTDI279QqO45/YydZk+0ZAKjPTej2/+JA1M02pX4oqCj3hH2ekXV7MvVLA91YkK+sOFpw3EnRn/sRTne5KfyjOGjzHJ9k48P7t5glpUGlQ3qSulFjOkowH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323320; c=relaxed/simple;
	bh=0z9cVa3ZGgTnVbrzNiNgVXxUbYuBbQzrkmglVvtJ/tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibglgfO3+BHqCz5yYeqJODN94mlpCHYKla6/Fwjou1ubTOjo5Pen9Ly8N/EXYV05zb1ocSKlYHM5crA0lvYOROKpGJpiW0d8d94dcH1M4FX1HQoJ4CGtYVZnGLlN0B1bQe2pxHMx6NuZpO06XdXrD/kGnaqvHclp8c9U7N9DlEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkNbTAYU; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ba5163454so302125a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323318; x=1757928118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mM62qRsSc5srCBf88+qBlrN86qJjbrYRmx8A4Z656g=;
        b=jkNbTAYUa7f34v+VjKDlaWlDjQsZYdhWjz6Nfekrei2YGdaT9sl3COEsmoT5YrCzIb
         vg4/w4bzYkBW8IhwAbwtRGhbjjDuRh8tJ6qNtRXFfpb11i6Q4yQg255Fv7ycei4nJeG7
         LmPsehkCj32aAZt1sNRH336U4WYNBmZtSQjx8SVgB2YRqbMGb4izZ3BhFH4UWWY0lr1k
         Ua4HT4WUaWtlE1wLRo41cJwQoXbSZm4V7ZsrsO11sWgOAaPSIztWGEXtPnUYihZLvGxG
         uqOrlHM38NLaFvhIaNQk9v5J0FCOoino0JynUQ3Df3Y8YqeZqNd3C2qCQLxCrSYN9CcQ
         rjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323318; x=1757928118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mM62qRsSc5srCBf88+qBlrN86qJjbrYRmx8A4Z656g=;
        b=NqX/Sp/whfMHN3aSzQPaa1uWo9VCQqe8HdJLjxzJcrOWz6jPqawHQtQflyXa7yEIO+
         M9d9xKv2J/d2oF4tIeBBJO4iCBeNDt1f0i7LJ7G8ptSk7yy8FNHwJ7bUOK5qHxw4QYk1
         funvswtf7ZItD36X+90umWx4oqHkvPPgQWcy7OKAYWZxy5JS68xCkEaszUdEETEHZRf2
         iWfx76ED3TMwR8p1aFO//iV4ph4gZaRqnbcE9jSyYcoDO4oMDeTL3VH2vw6OTSFNHX+H
         GVJWpg6Jwd16wGsiM563kSW5FvfnZ1PrqnqWAZyoW5m+8zgTt1TVeKz/SKdshVWK52it
         iJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLYfkkzFtgflVguoLCrtwrseXuOU8ajXQCC80ncCa3JN6cYAMKY4A0WXUPZVXIf2/9kr48xJ0F7/9UdHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/DTTQdrpPy+LnRX//X1lJUyMKKL4+pxWmsJtrVFweLyIAfzp
	mJ7KzK4Ydg2Cgv07W9IJEOhQ9/14wsFH2ZBVPeay2dEfG+1JKr/oSH06GoD+7m224BVOyo7JH5D
	ibrKhJio/NqlFkGJYCet5X5PblAOMBaOGkGoXi3k=
X-Gm-Gg: ASbGncvTGNZDJgW4U8mcV/31DSjhyaQDnGjRG8N+UcTryV4kzHdZ5OmE1XNbM0H6pib
	Sx0uPD3tV/+B2MYg28vVD4ZtcRrrHGusz3XKdYTzr5ZLAiEMMj3gY7hpIJ3OCun/yzMvZ+Ztzs8
	oo6Q0LTNDHOFj9xMkV+VWlW7HdAXC/XB33m5BoQ4wLr9ahPGA/nqfU+Z5sHpHraNH3ttgV/vtPE
	8J01y7uDfsRC1sh32muXjq1ggDHihbJatU1owtJ4PFUnFkuzQo6zhGEyWMzsBbi2nhyN0RnxoOY
	bY0PzCFT4rkYY8E2/p2KdUN+cA==
X-Google-Smtp-Source: AGHT+IGXMK7+cZAAVpFpxTkK8NFJ5GpIlWb3XdV/jm/+BDHICZ9Yyh9LpQ6Wkf3wWPTEU0K3zgMbkSUzOVNF9o1lOeA=
X-Received: by 2002:a17:90b:38d0:b0:32b:6d04:e78d with SMTP id
 98e67ed59e1d1-32d43fc8366mr5580461a91.6.1757323317561; Mon, 08 Sep 2025
 02:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906140256.3059395-1-vitaly.wool@konsulko.se>
 <aL6YHkF96ICqqbBZ@google.com> <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
In-Reply-To: <94252007-f389-41d0-b5a0-ed948225543a@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 11:21:44 +0200
X-Gm-Features: AS18NWC-N0hKvyAGOqDrWbVgpUjoIL90qVqsO4etfYvbVKtZnYoC9DEfXs_94Dc
Message-ID: <CANiq72k6OXcvjzKimfzKAAw8QPzDoVxUx_smFA8KU6gEwJ3yeQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: rbtree: add immutable cursor
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:06=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Why not use &raw? Consistency with the rest of the file?

I guess -- it is a good thing, but since we are actively trying to
move to the operator, it would minimize work to avoid adding new ones:

    https://github.com/Rust-for-Linux/linux/issues/1148

Cheers,
Miguel

