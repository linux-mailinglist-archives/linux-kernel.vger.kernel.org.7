Return-Path: <linux-kernel+bounces-740694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA0B0D7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1083B185A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3D2BEFFD;
	Tue, 22 Jul 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXnZFerp"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136C220F4B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182892; cv=none; b=iTuRbgrZXCKfnHrC9qVtRY6ctwruCZ7g0LxOJllh/Pi2kzt5R6RGCZQqCAE2o7YITB8ACvSIVOe18eAU2UM2N+lFuATfa1O8gWUePdiMD4CgPt44Cger1OTRadSLC9W8mPATYnxibX7s0ymrBfUFJYEzfd/SyfToTQ5siXf/6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182892; c=relaxed/simple;
	bh=QBIPGfp7FbHcutWBJlKogTk2ZO/hQ8ASWIk1T3iyCj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdDVmeRW6itko1P9gqkCjg8uFn0yFqHR1hjNQvN3V8u+5RCR6kIggODIwnGzSq+UgmffZfPwtJGhlEboiMzMdoyG0VsDOQfrPnaY2fi2Y46/nF+tj2mjVTR4tfJHy/Se8j+pwmEuzstPLvPEro/ZWHYynmwhPMhGdSQCXJVPJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXnZFerp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a510432236so3201440f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753182889; x=1753787689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBIPGfp7FbHcutWBJlKogTk2ZO/hQ8ASWIk1T3iyCj8=;
        b=DXnZFerphmfSE+7kwlMJY+TQ8WuEbKAuLbgTAvnAHnFoPXCz/lPLJNF3umiNlOTjRG
         UCiQp0P/gYJ4qwPvjwWxmSSgkw9wSFZ2tgaFgJRz7uZcJcL5/g/8SKdhy+kJN5KtMQZD
         zIwybzlNtotOwWQtsI4DxQOZR+jEsyUc7slrf/DPZEHahExtt18IgX9me3Sz9pVPxQ5V
         tortYk1bOKds+BA10repo4ZvnQm21zaQ8XkezhxoO0AnrmoOO3S0CFCWNY8qd8ZzEDos
         UQP9F2QiJOZ1neUKKuoSCFmXvPExBEAIWu6Jl4S3FltZVN25bWKNmduF6w6LU/hg4k7m
         EmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182889; x=1753787689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBIPGfp7FbHcutWBJlKogTk2ZO/hQ8ASWIk1T3iyCj8=;
        b=DvPdys6atzLjQ3EdoGVra1xPT0VRe0xESp51YOaIs8+9EruGOuiZ2dufWdU519D//U
         pcXor5rZA+4kjGAWR87Qz6wBhhPr1kEbUeiC9bs60MfjWSYDlpU8Z2pjKFWRBSKvDyWx
         B6XB7zmL3TtwnLCT+cJGF1A9gHbemqVj+tepn+tqZWsQb/1r9f2Lqg1M76MdNOGIUUqs
         S5ypHA18GRwhlGYdQ2aZ/IPCMzY6TSWGc6Qy4hl+FsDFCXtzXgj/FZs9G7cudFemsOei
         G4EYqWFuUFzcLAzdzn2iX9Ub4NokH0CS6+z3M/rgQf5pbiGTiNug3DNQGkmDBtCuE0Ck
         SkUw==
X-Forwarded-Encrypted: i=1; AJvYcCVhZGzS95BgbCuyUGcdCscWF7ee0FO8GgM1j4ZSGXRdPVRZP2jW6QuwMu/++d4nIDUJaCH3xYduY11yK/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLPTlJ+2iaYTh2lmXyka6XJBZxfRDGnovW1AVOJOuFciL39M/
	l9rEjiVuQsWKWLQK/9tpDu4X1WVYBVLrbiaXyVK1ak27bWJTqUra3m2+vTKcu0UKX9gn69Jk8W9
	o+v6+7m77y3WkpzBSCNHm3WAcZkpoKaXhju/dMWMz
X-Gm-Gg: ASbGnctg2gu4rje8fh6UbTzbxDw5Pzk/rUkBjwIR/sPtyy6RmgPoWKv9YF8o8v+Lc5o
	V/1AJ0tC6bMbh+R1jkWYDV6kHu9sXL8FLACudwQaQ4Xkj9Jv4TPGtZnNFJnhBYSIQgM0oTzJlZm
	TwlyPL2jKQDdcSHZlQNE4xm0fRv9lY8pI4JHegQ1j0/b4u7OK8CMI5lK8Eqyqr/A3LvTV7loI0N
	UbDRmzAZ5nDFdRkOHi1basazXbkwofcl5qUPg==
X-Google-Smtp-Source: AGHT+IG0P22eL8IvvgAefH6rcYYlSNuAa0jhSmm/EquOzDBvVg3gWRNH+xJaIxfbUYM6P7L2iT7JbnpLNl2gPS0x2fU=
X-Received: by 2002:a05:6000:25e2:b0:3a3:5ae4:6e81 with SMTP id
 ffacd0b85a97d-3b60e4c99eamr17188449f8f.8.1753182889107; Tue, 22 Jul 2025
 04:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520231714.323931-1-lossin@kernel.org>
In-Reply-To: <20250520231714.323931-1-lossin@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Jul 2025 13:14:36 +0200
X-Gm-Features: Ac12FXwQP7uxv8WKaNMJbn_lWW_pabgA98OacNeTtJb-K59fB0YUB3u899Vcq1Y
Message-ID: <CAH5fLghkiZ1AH7Uy2Rh=J252+TSOXrFJ3NDRUta6s9R_7O6U7Q@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Mitchell Levy <levymitchell0@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:17=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> The safety comment mentions lockdep -- which from a Rust perspective
> isn't important -- and doesn't mention the real reason for why it's
> sound to create `LockClassKey` as uninitialized memory.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

