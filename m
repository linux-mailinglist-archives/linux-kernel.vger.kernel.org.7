Return-Path: <linux-kernel+bounces-739262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83CB0C406
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF17A5BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9372D3A72;
	Mon, 21 Jul 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDTBmJzy"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE08176AC8;
	Mon, 21 Jul 2025 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753100737; cv=none; b=um63cnWGVdPbxR2HWhJaYi2N6DZTSPv0dynpsjcwtJ4udrCj3KzbZTkgyczpfj+csdWSBR9jhX4IzM+smYtjL8/1JCq7aEJ3T1Au+qe5bi3phrKps4/+BkJHINDeKjeSLIWzI3u8GVhQccqkckp8wJI6c0TK+pGlZBrpjtPnm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753100737; c=relaxed/simple;
	bh=VvrUUaaaS1A9Plu5aXp5IFelzZbPO4LdzaBYLlZL09w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OikUqlfYd7gR/mZ3gXhoTakiSvkZb1tNc9JJMO1rHAuG32T7ierSTfc34kf+y1EeCB2+N7yXwZg14PHgbEgL7PbCsh8YSV3+73M8y/kALmmDCQz0frnvGMXtX1CtHh4L9KwerzJuKu+cr6FtLwH9XBPsBeuBUSx4Cf2E18ytad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDTBmJzy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-312a806f002so809007a91.3;
        Mon, 21 Jul 2025 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753100735; x=1753705535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvrUUaaaS1A9Plu5aXp5IFelzZbPO4LdzaBYLlZL09w=;
        b=EDTBmJzyPWzis8/znnHk+zCRBsXT/OqOnytPcOBhfXc8Z1snqOSXEGRikkan+WYFxy
         lIlkhFxvwM78Kf6dpiuCscmtYw1J/TN3svFiLuPOB6bTmFEZL0SDIk0cdw0Yfn6RY6sQ
         Er6sWmYm6bhPzdniSBm6+iK7Wg88uitbwOK72mf3NGM1EdJcNMN5ikrZ2QeCj4OLuCvB
         XH9M66DP02EmbHJ3SYTNqfLvKgmyqD5Z9c8ZsL8dar9C5vbdMBaj13LC7FLDCypykZtr
         eNu+jgvdAeLPOy9SbGoag7FXUYiEga4ipGdCqdow4xATv79hvXwltVkOFqvkz8WyB/WQ
         5svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753100735; x=1753705535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvrUUaaaS1A9Plu5aXp5IFelzZbPO4LdzaBYLlZL09w=;
        b=V9qyDxR7JKatG/sYKrF3UU+0b9sLQv/Ryzi2qQYoDOItOzjWmOEjUqz9ZR2RqJsfUQ
         YzjcEfFMIyxEKkwFQ/FSIAWzjb41pLNobJGrC3HlxCcoxt2rhnuDjJ/CZD7rRcBo4CAQ
         oHcBz+EqK6LOiK36JLrc0MwAlgA8KuoYaV2WfH6dBA2R5Y5UvNezevdqJa4+ut0SsZ0Q
         kJPOfj55hUEsSny4WOgyfuzEU5VKSgdocuGCeVNTlG6fWdbyf4BlEEL2tI+pITYe6Ug9
         RJXLDO5GQLN4m4kMSubk1taRs7STuUWy+a5f5KN9f6wChvWYwAS2Ex7V40nvmIFbnLaA
         PcNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/uEUoO8v8/ZySvi/ieRj0XBypuQvKZOzueKDh153+kOcgncQtPPlPmiAzVLmLx+B8r6EC+OVRxZdtKmt5Lb0=@vger.kernel.org, AJvYcCUaSpk/Qea8PXJ3kTq3vpBqTewTg2Zh57lfsiEMDUqLFugCDeTxpPjy30Hhui2QxWF35wuj69B4i5z3wXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPNxd3Dt46nunM1ecI0i4bkEUVRcGz7DhSL3vivqW+exqbYfv
	Fw7k05vffR3DtXPiwysahrNy5rJdhFmOOeWjRJzKt/eB+fSfEi5qvEqih/F6e9BebON1V/dWRb6
	s7Xu1HDR8kp/H5sbxer0qgifbu2uWgzE=
X-Gm-Gg: ASbGncs8LD2aV8Lcq1nDgTUex/IkpmTvl3pvQOLPiY+latq0wL2E2qgTTJ3AuDmc7Y3
	+sCGI2MYo3KGs2qF2By7G/5QMiQoC7XqJNBOzV25J2B3Ir6snGxdxApr+UGS6tNiUZavCzoY6kU
	8Dfty0Qt4vXyY69gzYlkidU1m0eiyuuxcw8x4/c1CzdNu7AYDSMM0DeZoI8riVA+PBGnLyK4oGj
	gLg3FFQ2Z00O5fnd0g=
X-Google-Smtp-Source: AGHT+IFSXYIIli4TSxeo1ZPOpslV4UKNnj88g6IjbRZFu2bB/itpQKCh4nCk0WJXehDaaaH5XASiUY5JiMF59k2GYsc=
X-Received: by 2002:a17:90b:518d:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-31c9e76ae7amr11990299a91.3.1753100735502; Mon, 21 Jul 2025
 05:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
In-Reply-To: <20250720-rust-remove-compiler-builtins-deps-v3-1-0df3a493973f@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 14:25:23 +0200
X-Gm-Features: Ac12FXwfu15JgSSGFDuasNnYbUMz5ZmreXnXxwEyuK0Q9LlY0uyygM1zt7qam9w
Message-ID: <CANiq72m=vYbZZPwF9u9PQJ7Jce0KPR7jPybk3AHV50U9fOmEvQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: remove spurious compiler_builtins dependents
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 7:20=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Remove these dependency edges.

I should have replied in previous versions: this is wrong -- the 3
changes each individually break the build.

I guess that you are not cleaning everything in your tests before
testing the build.

Cheers,
Miguel

