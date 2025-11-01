Return-Path: <linux-kernel+bounces-881387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2AC281EB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 16:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA59400A2D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2E2FABFF;
	Sat,  1 Nov 2025 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9zGmV4g"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BE25A350
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012454; cv=none; b=gFRytAI2nmFAN5cVQTAXapaYZ8cT1C7tfDvTdsKpILAHZbSpmuTQkO9E9oRp8GzhsmX8grOK5TPTPbl/MifzFhlqIBjurZvp92Ko4ptLA6Jqyz/L6xco/dRKJGzNXdHTSVv4FhmYqxSerSrZIBTc81prmx1yLow6Le/aW+5tXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012454; c=relaxed/simple;
	bh=DZxrvCuj4VcRfVXQNKcqrzWO2/nyvtlkEBnmNGrmT9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1d4B1lKackRaQswtZ8deGOANpLn/uuduVzww+081yvfzkeO/PkWxwJXpYzogLwKchKBjBCeAQyvMG78p7ASVpbg7Ho5/1MMuNogNqec/HvMhUpK5rHdNfWriUnFLpidNiP/3zKFfm4zcmKetbA4hwraghL+D3bFMa2VxypwO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9zGmV4g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29301049db3so3532105ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762012452; x=1762617252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZxrvCuj4VcRfVXQNKcqrzWO2/nyvtlkEBnmNGrmT9M=;
        b=J9zGmV4g5/ijhQUpjiIn1YuahtHv3SrKuxmFFkiSY5Ebje0B/FkNsKYXucYjzbmJ9C
         qvxz1yi/RmVK0qPjTgdmzRZirzqA+ayA7mgQaU2Rh5vse1vkqlInsKLmaYuUbp6Hb9i1
         4xCIPlqftSQZcWDh8yM26oe27ZXQViWfhon+HHnmQTsfqVlg2Xg/ClLtR9bmQ2svqBvl
         dePQxvtskIgHPcEq6/G2E4FEjBNCyaFSxwqkoAGLQNujj9wZYd+qpdvMYzuxW5RlSxVm
         aE9VkHh4t/k4X9GSoOmYr11Z57rrB7DT+73FOqR0uew2O/OVidbh2akTjHaii7JqM3Sz
         O1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762012452; x=1762617252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZxrvCuj4VcRfVXQNKcqrzWO2/nyvtlkEBnmNGrmT9M=;
        b=pLEdCjCMsH5V7zSwno67PrOXg2ANsXr678SPtjbcDXmL4oPj6zLF1QkoyqzedcSUyJ
         UFImVmziZ+IleRfYgjsLemd8Y7us8GtamLSIi8V9By9ie67pFP6h+F57Da4ROmnETw1n
         A1bHvhResDduOJXcIau+L7qekRhK3J7+qF2bceEgrLTYFK3npT4g1KSzui1JYq8i7QQ8
         8/6JiEql+3VloBrXipZf/wO15u9cQhd4yYDMHSlA0Kocwk4FJAaeaZ5FB5Xy2ilosoVJ
         Ux6OjluWDUmItUqVShPcmHE3xGANYdmXpLDU+F6WuVODu4+Q4/tMW0JgZFE9ke/mhUAW
         ORlw==
X-Forwarded-Encrypted: i=1; AJvYcCVyOV/52wGrWB2GS0CRvppVPZ6AuRK3nzvUt87h6+i6zwIdFtTIshryfGQftDgMOMw2jXVTf7EvoTUN+JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/II/Zi8NTUV8ZhtlOUlByPIjgQK+vlfmcXTGEaAM3kN3Glw7
	tj61OM+2jow5dCrcXUTWjEWjkIWaU+JJlZf3XftBbL5HMfWxnG7CnDZHr6CwEl0BoJ7GUknwouz
	uaKNU405E/hEIjdfSiJ9pZmvMx8oNLMc=
X-Gm-Gg: ASbGncvM1sHCS2cSwrzBjo6BhYzFzp9yWHtiu+5+8Aaof0cKTy5dVU+uVRuuQHX7VAE
	IoFQVfo8TjLh+xRBT0DGEnFyNYoxIalW509xJtm1HxoNr9SiBVs5AUjsDmGfpe9mYaVz6FCwYfO
	McB67x/4akpVxpSe6LMj4oBmwzVgU4hS4+YNL0FG1CV9x0Tbo8yqnZocB3mBCLvPE9xL/cHZLxu
	Mq87iR/WIxIziPgCQN9JMgWHptYbep6ek39DLR3NLrLvE1xNKbIik6Es6FjXP7Jo0gGzAHntFLz
	vnK3sPU4VXvaojapkjq/9vHX4wPjUZuB4+7FBLnImXwiJS7K2hInsQDiZqVSkwk+6aUXqc9/Euk
	M8+w=
X-Google-Smtp-Source: AGHT+IH98SKG2dNVCAgDMWAsxf7IghHixGwIwUQXBJWnv1yD4/76UJbZrqEwBLzCN0HeDuDp9PdZmiEDyhXUpHiXB1s=
X-Received: by 2002:a17:902:d505:b0:295:3f35:a31b with SMTP id
 d9443c01a7336-2953f35a4edmr28620535ad.0.1762012452072; Sat, 01 Nov 2025
 08:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101094011.1024534-1-ojeda@kernel.org> <CAH5fLgjC20QmK0s_6ht1edL8wSR3d-yrJ_viuwdOxTCQRpMmgg@mail.gmail.com>
In-Reply-To: <CAH5fLgjC20QmK0s_6ht1edL8wSR3d-yrJ_viuwdOxTCQRpMmgg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Nov 2025 16:53:59 +0100
X-Gm-Features: AWmQ_bmfFv9e45aUeUVbkE-t_FDmtneqkzR5nipR7SAGPuD1TLzugXVWW0zvQak
Message-ID: <CANiq72nBEkTq7vos1Lv5Z1bgdZHt+UQWbauC0nr8xwxhuVBJJg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Huacai Chen <chenhuacai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:15=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Does this need a CC stable too?

Definitely -- I just forgot my usual line:

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is
pinned in older LTSs).

Thanks!

I will apply this when upstream's PR gets merged and send it together
with a couple other fixes.

Cheers,
Miguel

