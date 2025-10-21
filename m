Return-Path: <linux-kernel+bounces-863460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD4BF7E43
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C796A50739A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690C3321DE;
	Tue, 21 Oct 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHsPEzhv"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993035581C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067527; cv=none; b=QC0GbZXLhB3qoa2P0qERvqHrKeVkk566fzJpqg7Ix0MZv63WFMajRf/2sDbHhY7f67eeN0rtB/A0cVR+2VJPxxjdfAEmyROqFlj/SH1PV3ByrdGyQRy1sONAXfQSBaENsgb5SwSfv38rttuoVTLU/za3m5gkHGT6Ct/Y1kjEsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067527; c=relaxed/simple;
	bh=Ibl9ipy62JVcPBrthO993ocd5vWDT0JLzxK8s7HQuv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjKtWy5L5kQG8W80an3DKDOuEeLf9wwHRnusa5e7fLDR5P6hJa3pe/ZtNXtmYRaWTi+WCyT8m+zGM4P5Vtg6acQpjfKrsmJC56GjvAX36yvMCpsOcywkWz3IihpNcUJ4m/v1ignLOY2DlZIRHfG6URdDfrPoukMt0k6f7WAAxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHsPEzhv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b631a684a9fso440122a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067524; x=1761672324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAf3KsXjFc/zQP1AJm1wtfxbLUgTjyr2ky6pgjmz4cM=;
        b=KHsPEzhv9PnazcsMOs4hlJE2Vl9HIhNLf8vHqExNLD0kAG1qxJEsv27tm22+J8O8wj
         RkjkRjC/jDM/qFsoL5b5t362+AobWncAZnCeVwaPk+z6D74+1OfKyHGiG1lLTtCOF+30
         jkcBWIFuthLXPY770OFpr5VmMA0DTW4cMgsyHD2UmA2HTzWZHoZ89+rLE7PbKC4OiUs6
         bnlYvxhe42RjZDMGBxVS6aSPaNqB/Q5AJzInEN3O7O2fCdz2GHHptArB/6xxFK6+Y/FE
         r5r+EpJxRTudLOLlO+RH9mlwbUlm/Pzn+TU0W05YFHE11RqSDAMx2EBogC8hBBn3Lps7
         9dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067524; x=1761672324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAf3KsXjFc/zQP1AJm1wtfxbLUgTjyr2ky6pgjmz4cM=;
        b=NQDPxNQKOVNHMkMWVH1bb5aRkqOOIFDc+MWui/jFYLyf2nPza7qXE9eZPeYSGskdSd
         yw5cXaN55CMgMy+2TENZ89TbGQGJv5GddkeRsjr0q/UfDdwrZxhEBLQiCSDSsZ58rr8b
         YtkqJqHubZ/MSg6dZzpgsyot1fTfb82gYJk1RU18B1t6V3Gx4bAdv+BE9ZCvDo4Npb1w
         zJ+caLLN2phpfhgXcr3RO2TwLaou+DcR0RWoo5Dl+EIVyDsXnbGE3aiEAjOZt9+khv/Z
         Zurb+dHnVdHIPrefu+2896y11k+MDk7IfdGFB4WciSrIQwvYXSQamqMqiW1+Nt4CYLMl
         Y6yw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8XZNfZtWTRNPajTp1gzV+Po7kyoEGI2yAMBV2oyNB4Lb4VCpVfpXRAGWJgugz79KQQAL09i5Rly8rag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhVMGBbDb0jShtwvh7oNME04Z58LFEFlr7BJlCDYQdS3wqj60
	HNyBRUvjf1JAHrjmL9X4Y5+7AyEm8/WrHzwu5TB+DTlCn5PKVLwwYzYdlXHN43k4Ys/AAYK+UwR
	ykjjhPo5nBrGolsbCJWnXkN1l8jhQyIY=
X-Gm-Gg: ASbGncu+/vzEhVeprIIkSFd6mTnYuRV4TfQOwF170Gy2FbeQORuwCxIxwdgHN7El6MZ
	5VHUfGz9zk5mg9tB0mXr/TdW4sUcgRhVXT8LfLKWbR5MBYsYmK0ftewkI2ZHRBSSD1pc/kYjag3
	vJS9/fDSJpvBr3SdkvMnVnSe81fGUBrYSKYnqwvtCNSPbT4HFtIjLL2CsYvvZFu2TkpzrwRmLAW
	da2emx8ksEDmbnO26117moWuWum7PhEhLCV3CdXkbYt7gMjmtKCRhif1opZG+Yr/Btmssxpp3P1
	YKwklPxyJI0HLGgvWvAbULu+iBUhRSJ5fXADoV1KzVPy9F5YHNQWpM2BUZv2FnozAzcORt+gH1w
	R8KSphVCEWPCHpg==
X-Google-Smtp-Source: AGHT+IEWfCg0E0bwVttDNG0lql3yRpvV7id4seM/oa5UH+1sTXW5x3SO7M6tk+NNwv6wlch2bqa+yfg2OXtAPVMMHAk=
X-Received: by 2002:a17:902:dace:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-292d3fbc72cmr30865725ad.6.1761067523987; Tue, 21 Oct 2025
 10:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020020714.2511718-1-ojeda@kernel.org> <20251020105154.GR3419281@noisy.programming.kicks-ass.net>
In-Reply-To: <20251020105154.GR3419281@noisy.programming.kicks-ass.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 21 Oct 2025 19:25:11 +0200
X-Gm-Features: AS18NWCYSZSyVH4h_NBns8SoCWBqHms6Y7SdEmcHUYKM5xtVUbbF7ERZLvXjKs4
Message-ID: <CANiq72n_AnCJYw6R2XecapW9wZqs_Saa4t8BNgrPub2u9=9_xA@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Peter Zijlstra <peterz@infradead.org>, Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> I'll go stick it in tip/objtool/core; but I gotta ask, where are we with
> the toolchain support for noreturn?

Thanks Peter!

We discussed it with upstream Rust, and they understood the need, so
we may get something like `--emit=3Dnoreturn` or similar, but it is
still open (and not too high in the priority list since we can survive
with this for now and we have other things that we really need them to
get stabilized etc. But if you feel it should be prioritized more,
please let me know).

I have the status under "Export (somehow) a list of all noreturn symbols." =
at:

    https://github.com/Rust-for-Linux/linux/issues/355

In particular, Gary proposed an alternative during those discussions:

    "Gary proposed reading DWARF instead and wrote a quick Rust script
for it via object and gimli, though DWARF would need to be available
or generated on the fly just for that (and we cannot commit a fixed
list since the kernel config may change and we support several Rust
versions and so on):
https://gist.github.com/nbdd0121/449692570622c2f46a29ad9f47c3379a."

Cheers,
Miguel

