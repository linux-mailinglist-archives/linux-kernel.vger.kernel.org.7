Return-Path: <linux-kernel+bounces-837456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE8BAC5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77431927BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656B2F6164;
	Tue, 30 Sep 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt8nxaTF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624172F5467
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225499; cv=none; b=AwIPdwp14AxnbcLdpuFQB3Wa+g+kDGKBM7H0HXhy5SNhCgG7jmv3Uk++thgHJoQhK5KeswhX/DBv1E5lm5qSwykr6nzywjEJhujfArVo6/L434fPN+Zc65G/IKIYNQ60/vGl9Ov5Rs0orZ/mVwgR78rau9pjopu9X4GVX9YGbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225499; c=relaxed/simple;
	bh=EOpvFLC0DM+CJsSaiaGKaJte91AVZz5/fq5Fn3S7jSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7E9/TPaldt763Q279GYRncoKpQnl/9YSfdt6nU8/1sJyXMuDpU8ALlQCRQQzjBlGUMMaWa5t5rPbPARr98Fk0xEAD7VzFP9nF7UP3GusDBPO8rRs2WoQcHcBT4EXKe/cTOGML9gTOAnWKPbf5i+Vz54YFA9U9n+KyS6TfbCbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt8nxaTF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-269ba651d06so11299765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759225497; x=1759830297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOpvFLC0DM+CJsSaiaGKaJte91AVZz5/fq5Fn3S7jSA=;
        b=Gt8nxaTF074tFW0h5JNFPey4oRRMLfGERSBWyZRPg+aPXWhHaqD9nuJRQjzK6shPpr
         Y62YOuWCe+br11LvhtrxrNNi3txt600AwTFQNITmJCw6f8rQy/uTTHVPa0v78Xw8fcWV
         8vQrg9KYuGzmt8A16r0nBfoHdftkWC7naUX/2dflseDxxS/n3mPvJjGkf0BDb8lCZUFL
         6vd5rhxUrUGuaZbdN/9BRJnAeMM6wyqHCqBnUCMjla9G/YybF5rbY2wmKj1oOa8CJ4FE
         Va9ZhsZelXXX9FwecomCRDCQ1Zszk/2o7INaZlR6tdVH9n5LNkySSq97ZERiOuPVQiw/
         Ku8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759225497; x=1759830297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOpvFLC0DM+CJsSaiaGKaJte91AVZz5/fq5Fn3S7jSA=;
        b=EEu5rgydkz10iBkL9sxSu8NqmqXE+PjouTPdVbD88u2SH86C9dXcSALeND5/vg8arS
         Ye3ApowhZUA2HBzwQqTGOCQGHtbunN7n5zIpn+m54iJyN2gStFjwDjiHbe7If8shaNRw
         if3KmNtD+pmgwByI61vSA/5cuZ990dwNJAkktq7HTqY/x5fvwYmEj0K6zeHaiBbq3WUW
         DHbwU4ugWz2jNojjYWJXKzxU6L55VlyDFNYiiqUMurU1+hMsG7ZXI9LFBtbe/Y32rl3U
         XnsefH68zBx6TcZZ3MGU1vnONPAj51jALB0hAsgwtZ9s0z7+7cFpvGQFpJO8GdiWDTYi
         p2QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQOBK7mwrshRjANlDYMD5aVZ9/prsQYmrzqbNTHsjmW0GUcdTi7Gnd+eHYW+8b/SMrxH5fEwS4LYZNXNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZDHOH86Jl0Zdgi8TO66SUzcf6p/MjFtC1MUaYBDFvZHbZ9PS
	u3v+BejX3CBljp0dvlm0obqmSVPoVonUR3iPWA/b9N+sTcBVNuCM6bdabo288SYsq1Skz1LvRrH
	/EZ0cJHIZ75qA1SazjRcFuBLgRTx3JHc=
X-Gm-Gg: ASbGnctcoz7ZdlgOfY669P0uPskkHtrkL9YuzBAy48F1eDUKQXw5vi47QKE/EguJUOH
	JOUbgstAxqLVimUCA0E1SVnyXCg1Zi/hf/06hHxdROFxw0L1j1Pm2yyYaplLPUXj0ys41dTvmcW
	s11eV2xQdP8daSbmEF1yg1N+tZ7JPpfmFDl0jE8wczrAih9FKAIDb/hRMGXxkBSspZUqn/nhkzA
	QmW7NN8dbQ4mov2PSQVh3sza5j8ZVlVb6qmXMJN7AaRYNVy916jbQHMekaKZVIUzBFWpcfaZYec
	Fs/K76d1+DJhCHFe7iiamsvyKRb7Vxq/osy8iSsdfyHDVQu59Mriq0RXNPDj
X-Google-Smtp-Source: AGHT+IEEaqHs/3HkDXBnqrL9QSlh9L07a1Lvl4D0CKgF1YiEc7T7bXF4kQ71S21yp9VQu4QZCMUstMX7WeLtxkHU1G4=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr130702225ad.0.1759225497483; Tue, 30 Sep 2025
 02:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930092603.284384-1-djfkvcing117@gmail.com>
In-Reply-To: <20250930092603.284384-1-djfkvcing117@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Sep 2025 11:44:45 +0200
X-Gm-Features: AS18NWBTBbrXx8bhYvQxjR6yhdZAGCwAVpYFbCZHNQGuhnogYHcg3b42SpfZvTs
Message-ID: <CANiq72n+tBB=NasbJr95YJ=HPgSc35uwKALRyHDOyh4nG6xUOA@mail.gmail.com>
Subject: Re: [PATCH] rust: file: add intra-doc link for 'EBADF'
To: djfkvcing117@gmail.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Onur Ozkan <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:27=E2=80=AFAM <djfkvcing117@gmail.com> wrote:
>
> From: Tong Li <djfkvcing117@gmail.com>
>
> Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: Tong Li <djfkvcing117@gmail.com>

Normally commits cannot have an empty message -- this one is trivial,
so it is not a big deal, but maintainers in general may complain. Up
to them, of course.

What you should normally do is explain the "why" of a change, i.e. why
we want to add an intra-doc link, its benefits.

Other than that, it seems like the formatting is good. If you fix the
From: header, then the From: line in the body is not needed and Git
should not add it anymore, but it is not a blocker.

Thanks!

Cheers,
Miguel

