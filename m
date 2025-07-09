Return-Path: <linux-kernel+bounces-723712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6EAFEA36
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3044C645916
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB42E4264;
	Wed,  9 Jul 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTlApoUm"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57C2DFA21
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067595; cv=none; b=koK9QgqVo9ZZLZJXGmABDiDYcpnYw2K7UCsX8b3wjkibGhCaxSQesGFBwDf5/yyuxusPQrhLFnE+VT5yNPMidt0qLI/ChyY3scp6L5zh7hSEHQFBwB7hUfZq2G+NUxkjxKkN/o87IsBLH141eJk7Ia2oSpW7uAz70StYM25M/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067595; c=relaxed/simple;
	bh=Mwk7EQIGinazovFKy6rm1e4ck2Eb4n2+egCG14FKWyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FpiYbR9UueDn9uVAHHWnJBjZlMoYjcOsFAne8rkw63EcqSkJm1QJdFd9sn0oO1qxCCKunGNK+OdKQ/8Ksz5/zyp7xkk9vnc6C84cvcgZI+sfwZvyxXXhbyeXuhIxR2sJTgAYnDpp/QZbMT0svoaTlr5IR3xlzSFxTL7+Lp22fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTlApoUm; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so6044469a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752067592; x=1752672392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+AWzaFX7X0IoBwJtsGal3/qiXcwEGzW/IG/WeYHir0=;
        b=CTlApoUmOKxj0bnZRcmHuqd9PXPCyOvRc1Cdd4WlPCnpAbYxXhEAmTylbHbRKFRBlC
         PziBAEioJlRmuudj9E27szrRL2r3jM0ktGUMEDBBcxoCkM2uACLV37v7++A2q1R1pWFw
         XUcyEqkKO/0MoDbAyq4uGUn2aMq6uoulrqRq30HqwlhCGOw2BLt2dlycxhS3Vrj7HZRY
         jZQsJMFnqz+FBO7jyPByP4xPO60pgS/UXnFH3VVBlhU9+CYTGbQ1Rm9MOC9Vmfrhobdm
         HXQgFqI7D3ejfO1qxooNu2Uv1SIhpE28s34sT4tu6VS5szpniPrXldhEQ/N/n13FIkvu
         f4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067592; x=1752672392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+AWzaFX7X0IoBwJtsGal3/qiXcwEGzW/IG/WeYHir0=;
        b=jiZBNoqyQ1OcNQtUFZwpIPpB7cDHeF0lxE3l2lS2Uw96SGXsEIGULr+QOdShl5BRH/
         K3lgjXxB7CfrM2quefxpHigIhjumDbXsvFbUAxF5JqjhOV4C72JgkFNUJVrRgwad51T6
         uNbyX8fS1M3BAt+oRvHIcJfzN71fHKIGaAFfCOTEQOYeI3J4uNrrsxNz2QtF5vn08eIv
         jqgC05UfHtstAjYrSvNI9Cu54X4Pq3lelRBrqWJD0tszP1CoH0d6GQpr0UkEMU9lWHk8
         JOXCIRF+ubXcX9+pkFlpM8mT2p5V6pSeYZjBy7Pm9ownXOkwY0UTB07LvxEGI23ZK2oQ
         2QGg==
X-Forwarded-Encrypted: i=1; AJvYcCVAEOba1xCGfL5ymYj9DMW0vck58ZnH/Y9Yx0g6dFvqwYEfwvyjK4yDLv4pQJUJZlrsXtEnjgLwNpYe+iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OTS7bugmJZKHY69mmvgQREgrO9w1dg0zdiGpQZcp1Obqwb6l
	mPaPZorN7d3TynUHBOCDRbdS0xYW7EOlObPGpwmY4n3zGZ//CO+/Temr65+lnD1/XmVsfmIo6Dl
	+XTGmiBERLCqdA1Cptg==
X-Google-Smtp-Source: AGHT+IFaIoO2aQ/ITtjF6XALcWJVnX8Rw7wLdSLQbLPowQYEildPkBPfx8TmVXR/yD9aSmB3fybHDe1guOBaPfE=
X-Received: from edbeg18.prod.google.com ([2002:a05:6402:2892:b0:60e:7792:da2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:34d5:b0:60c:3f77:3f4e with SMTP id 4fb4d7f45d1cf-611a6e36b64mr2162510a12.22.1752067592574;
 Wed, 09 Jul 2025 06:26:32 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:26:31 +0000
In-Reply-To: <20250708-rnull-up-v6-16-v2-1-ab93c0ff429b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250708-rnull-up-v6-16-v2-0-ab93c0ff429b@kernel.org> <20250708-rnull-up-v6-16-v2-1-ab93c0ff429b@kernel.org>
Message-ID: <aG5uB2mK5b_WaI3B@google.com>
Subject: Re: [PATCH v2 01/14] rust: str: normalize imports in `str.rs`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Jul 08, 2025 at 09:44:56PM +0200, Andreas Hindborg wrote:
> Clean up imports in `str.rs`. This makes future code manipulation more
> manageable.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

