Return-Path: <linux-kernel+bounces-896962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810F7C51A6A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CB23B8D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F72F0696;
	Wed, 12 Nov 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irVTe6IW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4662EBBA9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942960; cv=none; b=BvdBL2bXYUO1IQPgxwCHfqBPOYxhvkcwJxqoUIIovI7AhB4Gzu+Ifq155tWGHOt/tq5H7P4aQQb/EfAIC7CX9GswNFQ2euOQhxgX54ER7Npp1l+FjKkrSmvJt1S9OE/kTUL0MdS1cZiJg7tXb83mbNylImc9VvJz0ZQxAEAddn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942960; c=relaxed/simple;
	bh=YPNEHX5E1EAY+3JT9FxU7dtFxSUrM3ua4vlSvyYLYVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyzTVB9q0NsLFE7y8j72PEC0uZjPdVG7gZF/XgXWTC43jhUlCHQgw13KzW3wU5ssjZiznEaQ+vTTF0zObMWPzoR8DL/y9DNz/eCGN9Eiy1Q1L5MTn92apxrn4Xe3yjWxMRG7uzVYleuSjnwRXJEMumHYhN0kdbgrKaT2Q4SkKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irVTe6IW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297ec8a6418so514855ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942958; x=1763547758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0B276sCmGuKPqViJUBQ4DCZOBYFMswfLTqrPr8TLG8=;
        b=irVTe6IWHxqBKPgIas1Zkm+IxkM3V/6e/25RcdG8xk9VoJc4nf0Xy9xsP7/ZxKJNRD
         304wflt3AHsL4xGOLr4SoLkUCCTvIgygy8ma7fh7mWqo4yx0lNaSbNZWlqobsR3rQ9AO
         4Cp9ImIBrmxFXUvuQTLCLeOCRNzNRT+j+bwWdDGiXdw6FqqW7UgGy/ie92pMDjHaMp1H
         6BPLqf+ZeOnOH+dB/ldEMD2TUM8qicoFIFzdwOYyFD3+opy7M59K49FDzZAUqKeDQ734
         0H3SOEljD4Il629Ssk07dxbKi6Wp2fAsA03cjYys0T++Wj+l/YTeEUQAcyxFUBVsbhIi
         7iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942958; x=1763547758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0B276sCmGuKPqViJUBQ4DCZOBYFMswfLTqrPr8TLG8=;
        b=h0Le+wnL/xLIDplNZIF5r7/ys2LeNBYz5uUyEO5S7FvXTUapkubkkM52GbhmnBNIMT
         d2Dtky84QEYrlw4XSZR+5pRe72PRcadlp0CFRhdrGQ8qsr7CjeAPFpUtiXYobvpdOu+v
         312h4/9vnYxzi5STtdfe6Y1mCZ8w9J6euWtAq7Fk1oaPOxOCYx6fkl5Bu0ua6KL6EMVQ
         rho6bjozo33BG1S3e7FFkc3vfTA2sktEHS7XGohitRRuMnOYYUyWgbbH9Rh3Lr1K0Cj0
         9CbQNfCJyOhN4PBjZ+kMp262EGr+Iyc2BQP5p+b0dhbdqJ3A89y0DtXupQay6Enuj9Y+
         6QTw==
X-Forwarded-Encrypted: i=1; AJvYcCUTchSOpQDGn5n0z6qD4ifC4IgqhhK2H/hu9aiw0CaGhO/voFmJmkPqFZq3Kx3oOhvi07s7OUFhmQvGxCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTsCDfG5Z7yRzSsyj+uU/EH/UL5H/ViqOZfTFm3l0fqVfmHmpE
	n9sP/P1QRMwx/mzMe2UcV0vcGn/1amf1/oFRQ3gGXdyLr09c7RZd92bOYFw78fecISAA0u5yjDP
	g+D/R2xDL7hRYdIqS0LDY8KjPrnJOHT0=
X-Gm-Gg: ASbGncuhX52ESSVcSOzZP/XLtkTWDyCRjOvmzD/Fai/b4p8Wzk5HKicUF3kiSZW1Iz9
	2Npf0v9siQKq2QfNzzvrQBa5IXZ/lForyMqHIQKVncLIPTDkyqmZyf7Wj3jdRgrDTwB2K9iT1sm
	gfYRGnR8Itra+GJTuKmzY92yRaVKr+zgTUhsGtTQ0afZvsMZQ6OT/PamqmYufoIOwUzEADgrpfN
	eRCUQX/TEdaO1i9AgIdu6QvKUr1jHSMDBjl63BKXu5X0Fb4LwUIsfksfB06SUqhL/bOyiSLJJIX
	6fmjCumQkoB4Ybk64H92pfmpy+Wp81jV+q7nfj7H8mQuIyM1xCJnnXQ65P63DtHUChp0Nok85u0
	F2kW7LBWZPdELtw==
X-Google-Smtp-Source: AGHT+IEZoSqjm0t6zN10oagsZyaGUA55TrpgWglstnMOybFlUdjZoMdhp86GzVPanaCUu6r0dqbnhK9HIk5xK9dXxsA=
X-Received: by 2002:a17:903:18e:b0:297:fe4e:d368 with SMTP id
 d9443c01a7336-2984ee3ba7dmr18188305ad.11.1762942957656; Wed, 12 Nov 2025
 02:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
In-Reply-To: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:22:25 +0100
X-Gm-Features: AWmQ_blKg4cu-v3P781ZJkYF9Gq3eqlBz7dX5cAIvvyUp8LMI-DCXNtY1gWIHsU
Message-ID: <CANiq72kCxh=Zen_fRrU8dVffGpNtsfNwMO1agC+muHd8ixMTpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rust_binder: fix unsoundness due to combining
 List::remove with mem:take
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 3:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
>       rust_binder: fix race condition on death_list
>       rust_binder: avoid mem::take on delivered_deaths
>       rust: list: add warning to List::remove docs about mem::take

Greg et al.: please let me know if you are not taking the last one
together with the fixes (so that I pick it up). Otherwise, if you do:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

