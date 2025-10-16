Return-Path: <linux-kernel+bounces-856992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BED84BE598B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6C95435561C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7862E54DB;
	Thu, 16 Oct 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugFm4wIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259462DFA4A;
	Thu, 16 Oct 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651272; cv=none; b=I0H3Ig3edCMB4fCDKB9qA+/qFoUU9Rh9QM4XT58mZ9ncq3kwFpTlxVobmRW+Xw4l5iVPPAtfyqKW6ZKaLVlSDvJSs9Dln1IzeO8ANi/ZJqaDH1CjUf4j2PtBqED9nAA2tJFar/vo8jDWcKaApriD01ntUvzO/6kmCOIE7yYsS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651272; c=relaxed/simple;
	bh=P0ccrz25cVeIv5CP0fVfDA2Q2QwIFMKPR+3K+ugp+i8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IAgiJ73G7GsyRvn4n9uKb/pge8Pzs5G2T79GibLg7XGpjClm0zmYr7e+xFxjecxC7ZihGt3SuN+LjbvMKTYNWmwci/nQWBq9xF1yHLVFZKatWOCWaLCc4mQRp2cPezQ91DytTa6wp1Ay5CxZKAc3y2FGu/dM6nX0SmnQrALRGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugFm4wIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6AC4CEF1;
	Thu, 16 Oct 2025 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651271;
	bh=P0ccrz25cVeIv5CP0fVfDA2Q2QwIFMKPR+3K+ugp+i8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ugFm4wIZxWDU8ANFaXF9AXg2+4cH7EKbq6E2VMNNQI5mtnDTQPRazx055zq+QSfZK
	 JuGodsFfNHuF93SNLji0d8JT4Ztao9zjRC7cv9wNhhj3DtmPNjCpWwxgog821IvzEU
	 Gy2vIrla0ZEPySYhk3ALOiocjZil/XarlVS7Kx+wvn3sUyKdBruSkchmCfb4ghewaX
	 5tCsfO2/ZWNPAPhpYwwPHHACzXApgoafsLC+YKyM+SFtxjwL/IiLvurloyEkGRMUGG
	 DyXBAB14t42bun0msFqSDzsxFVuUoJzKOl9xGX+4SIIkulVXexTALgnCI4mvXwfrdX
	 rLjOIgSGC5M1Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 23:47:47 +0200
Message-Id: <DDK2SA1D77HM.38KOTOTF8FJXI@kernel.org>
Subject: Re: [PATCH 1/2] rust: pin-init: fix broken rust doc link
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 "Alban Kurti" <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20251016211740.653599-1-lossin@kernel.org>
 <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>
In-Reply-To: <CANiq72k8KmpFyKAFZ293GDUWx5=HJtksR02hTU8-H9PX7xsT+g@mail.gmail.com>

On Thu Oct 16, 2025 at 11:24 PM CEST, Miguel Ojeda wrote:
> On Thu, Oct 16, 2025 at 11:17=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> Rust 1.92.0 warns when building the documentation that [`PinnedDrop`] is
>> an invalid reference. This is correct and it's weird that it didn't warn
>> before, so fix the link.
>
> It is because it is hidden -- I have patches to fix this (it is not
> just in pin-init but elsewhere too), but I am waiting for confirmation
> on whether this is actually intentional behavior:
>
>     https://github.com/rust-lang/rust/pull/147153#issuecomment-3395484636
>
> From the early reply I got, it seems it is not, so it may be that it is "=
fixed".
>
> Personally, I think it is useful, so I hope they keep it, even if as a
> new opt-in option or similar.
>
> Of course, we can land this patch since it does not matter either way,
> but please add a note with the above in the commit message if you land
> it.

Thanks a lot for the added context! I will add it when applying. The
`__pinned_drop!` macro will be gone with the syn patches this cycle, so
in this case, we don't care what the resolution will be.

---
Cheers,
Benno

