Return-Path: <linux-kernel+bounces-762623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9EB20911
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE215175CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866A2D3EC2;
	Mon, 11 Aug 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXkAuN2w"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F42550DD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916207; cv=none; b=LuMTfy8tNhgIP9UEM9C4C+VcPoXOEKu0b+kG+W3MLVydWEPx15gIf8Ma8Q+uRxIDqsBh4WQ5t6vnLig/LZ4yBspTpBlk4bqbXzP8ne3O15mF8uHjeZG3iBxB5cNb7CegvX3jUDpQ8tubZ1dKkpjwuA6cH1/4eHo+VCcF12RQ/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916207; c=relaxed/simple;
	bh=j3KuIhJo0ivrR9GdvJeQEnar7BGsh/Xlz36SAqt6LBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXLRAGt0TCXVo91JMKzHC2q6OocWzqyWewsytDQjfquyUhw05NxyjvBNHFRba9QpfR6av+5npOoHbghhbbdJVk4tAI+hOo3D+xEZWYJn0S8Kp+ecMmynewrg9iFCDTD/BVRRYq/KnQYIoNxGcwsRjOIrZWedGQdIBkPGqoflpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXkAuN2w; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7823559a5so1964120f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754916204; x=1755521004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZQtbM58CuYhzw1MvgZL2tVUq7quGscgzcUmkjWg4xQ=;
        b=QXkAuN2wr4WFac+I4bBDG2gAfJb9+5Kty8ux4yUXpFZZTZ3w301ci7IC0ulAccWKY5
         u0YVdsX/3OZkF1CCvOEd/FVUC2TYPnioRgyXapGEhYtdku+Jnryq2rT4dIsVGWUwpyz+
         4XeiB/EAXOfEQV3N0nQ7Bbbe4vRuHEn0DB39dLBzo8hL0imlvL46DfXzwl5sk4JZ7JV/
         O1v7A4O7geFCxcqnVmWyGdAkVOpdeb5lymae25PuQ1d03arGBlg/vJVvzRhitybNRHnC
         Wy3/Rcqig+31ltu56j8dr18foZnIL1/vJNQJiKKQ4S1SXtOp+Dwnd2G0Wqg0mWIVJacP
         6PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916204; x=1755521004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZQtbM58CuYhzw1MvgZL2tVUq7quGscgzcUmkjWg4xQ=;
        b=eKl5XZGoGqIEP6lb6KgtGsEcS5ek44rsAMkM0BLGgpR6VH14YBefdIVDnV/dzv+Bf4
         yTtFiyjXt2s573vthCysw3Lt+TxpR6lOE04QR6OWdo+fNZpSsWqZD17w9v2JuQPdTib8
         r/hz30ldKXS8a/nNN4KC3kV9NhWmwEvKBaZUePl9L6gdIEw9orf8BFV7sisSUKWDbmdL
         Q2w8xurHbCG5RtHmaDhG9tg2fydwH3ZjOlDOnnmssdu30pk1gcD/40WmbxhB7tQd6ehS
         iJONWD4lnBm+6FANdeKAHGqxgBMaHrFWGQCUhVkCnLJ0GMMkNGjFrPrU1lz6NEfFldlH
         A9dw==
X-Forwarded-Encrypted: i=1; AJvYcCWIBXY9hy7qBKhDQ5ffkcwmFOHygsQcgZIT5E5+47K007tLzJqTgPtIzxlHftQZs0CCxfx613+VCZUcT38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe10+4lI7AA6YEvGrkWLHlgql8lS5/8YO8/OcjoP6QcZxWz8s+
	T863/MltNnmYomV2/qUG64oZBoRC7AhCPSzgmOS+1H8yMB1d4pLajhFSBdHQLnFPS6qGxqpQcFg
	3TQE950m2F4BknRCrCROypsOICmpoFA2NaRkMNspi
X-Gm-Gg: ASbGncu3BZZY/13IYTCeq7KkTvwiq9aNWCtQk4bFAOqQQ+wqOjKxVtuNoGO6l4d3qq6
	kPj2BBFhD0fgWZSJ6tcE2jGZdeaanQg9rEvaoIkd79KG+/69Lq60UGz0mot0lpPrq8KbqgFayqX
	oACIuwQih8RDVonoruyDcsAJ2Glp00hpgGPQaK5LykPFrBgaKt+07eS7DAilbxdmuMj9eYE5XHu
	rmGdqEM
X-Google-Smtp-Source: AGHT+IFbHmiT69GgG6VywhTtWkjpjKn3ClF+vJUww36UOVmWy0SF/jHh//RsS8jPS05Gf6wMhqwnjOEo7UsZLyjUxfk=
X-Received: by 2002:a05:6000:2507:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3b90092cab1mr9287296f8f.11.1754916204089; Mon, 11 Aug 2025
 05:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com> <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
 <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com> <AF48133C-BD57-4EEF-8E4A-ABEECB8A5C49@collabora.com>
In-Reply-To: <AF48133C-BD57-4EEF-8E4A-ABEECB8A5C49@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 14:43:12 +0200
X-Gm-Features: Ac12FXxxIhPmaPtJKy3TMgtU486Km52fgwcFr8qaz3_2m5jCwDhsYNXHNvF34dE
Message-ID: <CAH5fLggOqsrob-h2v8c5hsnMquJZhXJ2euAub2ia2fjj=NY8Vg@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:38=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
> >> Also, I was getting tons of =E2=80=9Cunreachable_pub=E2=80=9D warnings
> >> otherwise, FYI.
> >
> > If you got unreachable_pub warnings, then you are missing re-exports.
> >
> > Alice
>
> The re-exports are as-is in the current patch, did I miss anything? Becau=
se I
> don=E2=80=99t think so.
>
> In particular, should the irq module itself be private?

No, the end-user should be able to write

    use kernel::irq::Flags;

so the irq module needs to be public.

Alice

