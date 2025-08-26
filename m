Return-Path: <linux-kernel+bounces-787199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C73B372E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3E374E2A96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A43728BD;
	Tue, 26 Aug 2025 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCOl7j/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013931A54F;
	Tue, 26 Aug 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235639; cv=none; b=HnztPAUpZlt/O/al5Hz5z1iK5SfNHS8E8WmvYNamE1DzwLrA9gBQZn/7yg8zB97IQwMlw6Dgds8YisVVYDsQd7w1rP8ZEWpY0pfDtTrmLW2xmX63ps5hlcCPsHmflrFeP2zq8CyK9qoc6fzfOEPxVCfSkq6SwBtJqDmdKJvRd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235639; c=relaxed/simple;
	bh=qA6LwuRKII829imt/04X4B3VJEzTMIdKTGmjgRf6HmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=FJ12oB00aBF60Pa7Y5jcyUk/RiEzDWqSCqQxRCdVf/UcZrGZzoWCFb0lKIUzqNHgFQeq2E8ea0OOXVbDBZNfil04cT9RQKsXVOQSllXwSGYElMF40hxL5CX2xL7Sc0VstNNAMtU7Yoyxo99suaZnBmm3s/gCA3bIWR7cx7buYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCOl7j/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89692C4CEF1;
	Tue, 26 Aug 2025 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756235638;
	bh=qA6LwuRKII829imt/04X4B3VJEzTMIdKTGmjgRf6HmU=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=hCOl7j/fvuCyyFxN097gNMNU+ipgEqxLSxSiyyENojlKftvdwwjOiLRlT309M2UQX
	 rg/oc157sVW+Md60uDCULmMTsvQplyWvBZLTw/s69Uhq8Zv/lOyDTJ7va9g0d7H+6d
	 /cRCr3Hzv2B+Bvgkt4RLQXe+7K19Xg4G+3PPbKlsMs/kcF2uTSywpJDDoJ2NKbdbAL
	 DIHPZU7uRmMYKURhBsapan/6CB7fOt8hldAOcKTHC4gHuC0nw4fP7lPcQbKM1ysaSS
	 fEbN5mp4uD/nVgkTiRBGUMQl6XFthhepc/+3UEz2jNeuDBFqurHyTpg/JXVcrBVoDT
	 Hp5BLBSS0Pk4Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 21:13:53 +0200
Message-Id: <DCCLKO6HTCM8.YR8VE8PAXQTM@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <6625A8C0-33B2-4AFC-984B-130F8E06113D@collabora.com>
In-Reply-To: <6625A8C0-33B2-4AFC-984B-130F8E06113D@collabora.com>

On Tue Aug 26, 2025 at 7:40 PM CEST, Daniel Almeida wrote:
>> On 25 Aug 2025, at 10:24, Danilo Krummrich <dakr@kernel.org> wrote:
>> +// SAFETY: `SGEntry` can be accessed concurrently.
>> +unsafe impl Sync for SGEntry {}
>
> IMHO all safety comments for Sync must mention how it=E2=80=99s ok to sen=
d &T to
> another thread for a given T.

When we say "`T` can be accessed concurrently." it means that it is valid f=
or
multiple &T to be accessed concurrently from different tasks.

I.e. what we care about in this case is interior mutability, where we can h=
ave
three cases:

  (1) There is no interior mutability, hence the type is Sync.

  (2) There is interior mutability, but there's also internal mechanisms ta=
king
      care of data races, hence the type is Sync.

  (3) There is interior mutability and nothing prevents data races, hence t=
he
      type is not Sync.

I feel like only case (2) really needs justification, because it needs to
explain how those "internal mechanisms" work.

Those abstractions do not have any interior mutability, hence I think what =
we
have is enough. Does that make sense?

