Return-Path: <linux-kernel+bounces-753080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5DB17E64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93533A800C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C421772A;
	Fri,  1 Aug 2025 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4Sdodfg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B97360;
	Fri,  1 Aug 2025 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037410; cv=none; b=hoeqy5R207dAvyoGIn8lHqGoQQEjpkuGm4QHKO2uhWsryfPXtX+LIvazWs0oB4TKrx1FuVbM3L9F/HMLWBeh90hdyg010Ll7055z1hMHQV9EBabDsd1z9n1LVijtBmRCJu4YJcQm5wjD00anpnvT0BmldsFc8a/+b8H4IW7AruI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037410; c=relaxed/simple;
	bh=zTczmumPB6Km92g9PvLzCLzv5zMr/38WTwK+e/y3Q+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Z1Ot+dEIj8KSgJ2h0oo0s0sWUOeCyvEuDxgnRZVfi3NWzcYcA2oBKRxAX0Z8rx3PH6Nh66Uv8vD/xykYyj2BUIZk0+zl+2FBG18nTKz2uvnNrNbs0IEdXKmT2PjDpGx0Zv0JGSbYxfgMr9MBj74dJXcDm7wysyEu6mUxqKkkrPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4Sdodfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A42C4CEE7;
	Fri,  1 Aug 2025 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754037409;
	bh=zTczmumPB6Km92g9PvLzCLzv5zMr/38WTwK+e/y3Q+Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=m4SdodfgihiXdK7otoTKUM7W16maOmMO+sfkzm/gWiAV4cQ/7CiFqpa3jIxVvtYXo
	 kbutMWUmSE0L01asjB4RwvdKCCv02NzBoRzuVitwpa3SXH0ypsLzvcXQ/getrcS+uv
	 TedwXzQMY0Bo3LlTR3VXkXTL490Frxz0j2hxsZO+HM0WQn+nt1pLOvOu9XwpDJ1MEa
	 VSpful51sPOBsVGgLf2QJTTrhbr2nu46co5IyrjpcIoIX4ccR40gbUE414XAxd+gI3
	 op/ShN/b8DmlHawEB/qu4TiMPeXmholQP0QEShQj8xXb2LXgnMRFJan+YXbVaqq5tv
	 fy81T+atoFr0Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 10:36:44 +0200
Message-Id: <DBQYD7G5SOZA.2MSKKQWXTPCBB@kernel.org>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
To: "Shankari Anand" <shankari.ak0208@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
 <CAPRMd3n-1nx6BnL=OtrrJqS1gCxYAw2wSaHUQ19174Y=ShqO6g@mail.gmail.com>
 <f958ac81-c092-4958-a61a-d30c8389f431@kernel.org>
 <CAPRMd3kvemvtEM4976+MGRbLJV+4X8Hwvodc0q8+0jtgT_V3Rg@mail.gmail.com>
 <DBQBRYBV9YVN.35REJ1DIA06L7@kernel.org>
 <CAPRMd3nQSyXB+K2Fcs7WJJmtY2F7sm8tFOD1PrkQyHgND=Ju1w@mail.gmail.com>
In-Reply-To: <CAPRMd3nQSyXB+K2Fcs7WJJmtY2F7sm8tFOD1PrkQyHgND=Ju1w@mail.gmail.com>

On Thu Jul 31, 2025 at 7:50 PM CEST, Shankari Anand wrote:
> On Thu Jul 31, 2025 at 14:54 UTC, Danilo Krummrich wrote:
>>
>> Ok, did you send the other ones already? I don't see them anywhere.
>
> The commit 07dad44aa9a9 ("rust: kernel: move ARef and AlwaysRefCounted
> to sync::aref ") refers to the patch where ARef and AlwaysRefCounted
> were moved into a different file. [1]
> To update the call-sites accordingly, I was advised to split the
> changes by subsystem so each patch could be reviewed and acked by the
> respective maintainers. [2]
> These patches are all part of that same effort, although they aren't
> shown as a formal series since the subject lines vary to reflect the
> specific files they touch. [3] [4] [5] [6] [7]
>
>> NIT: Please don't top post. [1]
>
>> [1] https://docs.kernel.org/process/submitting-patches.html#use-trimmed-=
interleaved-replies-in-email-discussions
>
> Apologies, I=E2=80=99ll make sure to follow the interleaved style.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
> [2] https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbg=
N4i=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> [3] https://lore.kernel.org/rust-for-linux/20250716090712.809750-1-shanka=
ri.ak0208@gmail.com/
> [4] https://lore.kernel.org/rust-for-linux/20250716091158.812860-1-shanka=
ri.ak0208@gmail.com/
> [5] https://lore.kernel.org/rust-for-linux/20250716091827.816971-1-shanka=
ri.ak0208@gmail.com/
> [6] https://lore.kernel.org/rust-for-linux/20250717072724.14602-1-shankar=
i.ak0208@gmail.com/
> [7] https://lore.kernel.org/rust-for-linux/20250717073108.14943-1-shankar=
i.ak0208@gmail.com/

Ok, I see what happened. :)

I think you may have misunderstood the suggested of splitting things "by
subsystem". Let's take [7] and [8] for instance.

In [7] you update all the samples, regardless of their subsystem affinity a=
nd
[8] updates everything under rust/kernel/.

However, the idea was to send a separate patch per maintainers entry / tree=
,
such that all patches can be picked in the corresponding tree.

For instance, one patch should be everything that goes through driver-core:
auxiliary, PCI (incl. sample), platform (incl. sample), device, devres.

Then you have another patch for only DMA (incl. sample), etc.

Can you please resend accordingly? Ideally, wait for -rc1 to be out, or bas=
e
your changes on -next.

[8] https://lore.kernel.org/lkml/20250717073450.15090-1-shankari.ak0208@gma=
il.com/

