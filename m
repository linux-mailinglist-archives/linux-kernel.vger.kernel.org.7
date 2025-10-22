Return-Path: <linux-kernel+bounces-864690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC0BFB591
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2D2188AFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952203161A0;
	Wed, 22 Oct 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joxKS2I/"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6752C31A071
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128057; cv=none; b=OT4gf55G/5Q5n3ZXjk6XlHew2ifj2wNtwFSAZ1zlXOM2MoRtSrEQ2gx5ozWzrfz2cXydO93T9GRN0+O4QkfuhI+r14HG9QiYC3i0kwQMmhmYb/J34p31mm4xSgmgLJw2PXzNU6e7woGtH2YO20MfZCaaouqMR3fPM0doSi476YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128057; c=relaxed/simple;
	bh=H0yQL7Yj3xAfGiqMxWIRkW/8b2njG9FZnAqlG1ULYSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnZDwYkpBcnkFwkpGYZS5/alrroo4prvagQ1XwDlnmd8IeB8btCN0ZK1yMe81TrE3i0yznU44zCGxNHG5O+ITHRxgJejeYdfOxjI82S1iiClWZMNLFWHOFbFGuNV4O7YxUnDTka4deKpNuGV732IHYC6MA0+ZMF/oqG5mtM0hdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joxKS2I/; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-64fdca63b41so3085057eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761128054; x=1761732854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0yQL7Yj3xAfGiqMxWIRkW/8b2njG9FZnAqlG1ULYSs=;
        b=joxKS2I/+CgMBOQI0vZLyl89GWZa9/BI6zE5Ji2Ul7QjSXh61ZNSiYuYPqqmi6EjKJ
         trCJq1bMhYCQLjzXN/39FS9RBieArrgiEmrB6T/MK4kUn/olO13CYAJKSow/ao9kL05a
         7zbWMY93z4hmMhByPfewchwNnCVdeqh0FYYOw7ckeCJSNJCQwLAq68pIqWR04JBI/1p/
         i69vjZ39YH/5M76f/aChBuhqm0YZLTSOuvy8crfw0KIbO9+sEFcpGtbtXQceWUHvsI9h
         eGUGYTxfr8ntfJPhPLm5nv8r3tX7XYfHz5RNsKYXstWNKdetnyW5njFOYfIolWNAiR7S
         xJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761128054; x=1761732854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0yQL7Yj3xAfGiqMxWIRkW/8b2njG9FZnAqlG1ULYSs=;
        b=pHRn54cH5uFtXwNDjJUqra5OyXzn2AjStYTFRvJ6SAzI9DES+R5+FRZ/YdDXLgX+Pg
         JZfkejbBEwQNtO0jzZqpShU7s4lzpyHvXKrDmjlVMKMGHm276VBGtLaP9Aj4KnD1T/x2
         aAlAWU8byH9/21PnW6JxAugBChZq3zrbkW6yylbQxZYNGo1AS2HNHc17BZKNoQK+kGG/
         IXYj1J6enEsgg4WnUBPXuyFNLYrECcS64vaEEaghvNUzC+HZRP/Y6/tnx2bBD12Utmxt
         F2NNZyOyMD364/2FsnT+UgcqszF/5hKVu0Q2a2bGkxv1u542BY/fs9kt1Afg4KqKLqpZ
         M/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8158gLOFcFe9Ibb1A5LK2oWpUUuEnUtKFeDgAwDjwUZS83dkEvM6EyOIf/Zwq51LYn68WBUkVrkWVR6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zhJSzrb0Mtq02YKk1HQa9tLpHXHkVWAR8Ta78mlyMR+w1ZiL
	9xApe4wGkgZEj96MEL1PXJxMhXrqoLgCJ8T8Tek/BcNO+8udv5vSnyMAzKeIpztlSsvEf6dZnYH
	Gr1Raj74H0jxLypiAv35bW9mPdyQ3i5ieFjbhxNgM
X-Gm-Gg: ASbGncshYU81BraqhOHszGSxd1SehNZ9pjZ9+V+iFnq5X9FCLLO2A/RXUJD7z+yQ9ut
	ZUTVoNb9gCZGWTr9hwAyh/q5fL377OnbQjjtDxYVpEPuNMP5qzaOgJAvjRRxsu75HWoV92iWriO
	56nRORF7CGCNCM/Mujz03F+j0OOnWpkN2hAw4eJqmcbW2ZRKj+iPwZ/PwtGUBXeqKRPLSBmTa9F
	UhSnuaHsfzjQ/UmTEWJvT7xDo6FzksKH0bQ2DbhqYW4gJvDUT17iwfSFyqduMj/NkByZvh2BOtK
	lSMCoSMyNmjyVGs=
X-Google-Smtp-Source: AGHT+IG601XlVSePErRgku2vXHiQm4srVDoYwTdc69NkfT5xbwE/K6snIHcykqpn0TdBm6kNBfvWxtGffkFM8Xw38bo=
X-Received: by 2002:a05:6870:f70d:b0:335:b4a:8631 with SMTP id
 586e51a60fabf-3c98d0e3b92mr9539118fac.24.1761128054251; Wed, 22 Oct 2025
 03:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com> <20251021-binder-bitmap-v2-5-e652d172c62b@google.com>
In-Reply-To: <20251021-binder-bitmap-v2-5-e652d172c62b@google.com>
From: Burak Emir <bqe@google.com>
Date: Wed, 22 Oct 2025 12:14:02 +0200
X-Gm-Features: AS18NWDBQzTe7S67kufVQReN9fAPakA17zOF1cXXOxHSQAtU4piUaSjZjQNyA2U
Message-ID: <CACQBu=XFP03+9EKhvX_6rEA_aYRxyMmfGOV8hE4_NRwDue96Xw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust_binder: use bitmap for allocation of handles
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> To find an unused Binder handle, Rust Binder currently iterates the
> red/black tree from the beginning until it finds a gap in the keys. This
> is extremely slow.
>
> To improve the performance, add a bitmap that keeps track of which
> indices are actually in use. This allows us to quickly find an unused
> key in the red/black tree.
>
> This logic matches the approach used by C Binder. It was chosen
> partially because it's the most memory efficient solution.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <bqe@google.com>

