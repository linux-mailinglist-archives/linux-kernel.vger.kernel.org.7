Return-Path: <linux-kernel+bounces-594753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44306A815FF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 21:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A4C882CF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CD241124;
	Tue,  8 Apr 2025 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieI20o2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B742C9A;
	Tue,  8 Apr 2025 19:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141620; cv=none; b=X+YcB0gZAOJKUPDRLlSHuAcUqql2MMVIHCUGsx+5+jQITGj8XopG6whoRNQAUGNZdGvyK5wF+yupVKL0MINW/4M+FDLU5/0kYrwTiTF1zBjHGFsX9KQlqAAB9BSVBqp8BbPH256J5YtMf3Y3e+lubV9TF8zHW/jLZOsUOwIdBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141620; c=relaxed/simple;
	bh=ykljCqn6FF0Yab/J+sQBV/c6rKO+79JVLrOtQ1WmWVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLjXvOQMelYB7E6S2BzJ+1IX8HD4l37wUfsb7dcBgTPJ4+yZcTZlr3Gt6HaeOyBnPNWoVWhtgE7rY8qmFhxynUVf7oe1ZbBa71JycOlpoomI1TiLM22ME+rl46ygaO0ePHTc+TDI4ZJyucrC04BH0wrFxlDM0yUKCf4jzvtVqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieI20o2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83463C4CEE5;
	Tue,  8 Apr 2025 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744141619;
	bh=ykljCqn6FF0Yab/J+sQBV/c6rKO+79JVLrOtQ1WmWVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ieI20o2XC9sqVx27k6M5ZLvXJv0oeJ39/VH12q8QeJbsqqVjn1W3JdiLb0PT+k+7J
	 lNDqH/WAwk30m/tnWBHpDUjPbPH16UXtdSht1dBefLhcVUFcIa4r1KJaxI3EXDO4Fl
	 znOWAuTSZXCjzgpXSRe9YpghtSGVJ5BtdlkDEYHm5c/rJkZFBYpxRP5lpi8RyOwnJ6
	 3AMZOfQVCe9N9gbuhvn57hfOj2Pp7J70MrTWjq4lLZTzeomxOliPEYoHvFrRMbyWDF
	 KnhZoNE8DFphYErc2ef9/tFza3vCMaGg4Nwp/9OOD+24p2ie03vT3C70Ovxows3hVO
	 7Nhj3lq8rd+Sw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Benno Lossin" <benno.lossin@proton.me>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <ojeda@kernel.org>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Daniel Almeida" <daniel.almeida@collabora.com>,
  "Robin Murphy" <robin.murphy@arm.com>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "open
 list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]"
 <rust-for-linux@vger.kernel.org>,  "Marek Szyprowski"
 <m.szyprowski@samsung.com>,  "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>,  "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
In-Reply-To: <CANiq72mahS0jiOHv-7RE8QWQunYo0bJqeGo-FAVoUL7v42RsoQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Tue, 08 Apr 2025 15:34:12 +0200")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<20250326201230.3193329-3-abdiel.janulgue@gmail.com>
	<nujfDI6IKBsjlQtGWaMrhjZSQYYeQYckCyOUs9jIzgZGsP1WTalJE0sSg6tp_WMACWo9mzuDfpdzsIlmkKnL8w==@protonmail.internalid>
	<D8REH728BFP1.2BGE9DTRP2IPU@proton.me> <87ldsahlxr.fsf@kernel.org>
	<NBhs6N93VPsKCxDOdnggZCiQWIxBfcYJU49nl2DmkqlTDaZet_q7V-_LjkS_uZPtkb8u2yW_oRh0TVjV3cLdkQ==@protonmail.internalid>
	<CANiq72mahS0jiOHv-7RE8QWQunYo0bJqeGo-FAVoUL7v42RsoQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 08 Apr 2025 21:46:47 +0200
Message-ID: <87a58qh1w8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Apr 8, 2025 at 2:40=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>>
>> But the `assert_eq!` would panic anyway if comparison fails, right?
>
> Previously the `?` generated by the macro would return out of the
> closure written by the sample, and thus it wouldn't reach the
> `assert_eq!`.

Right, I see. So the question is whether we want to have the assert
panic here or not, of we get an Err. I vote yes.


Best regards,
Andreas Hindborg




