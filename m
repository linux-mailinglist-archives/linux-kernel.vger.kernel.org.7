Return-Path: <linux-kernel+bounces-756170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10FB1B0C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE60175C11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8F625D20F;
	Tue,  5 Aug 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="mHJbf5RA"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985D257AEC;
	Tue,  5 Aug 2025 09:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754385349; cv=none; b=KVU5v439gG3ul7Te3PuB+sDax143tyLXejCFgU0ZWvBH4sIR/UOoCFnEU8DMEHDdYJVN7uDeh9D88ILL0PB4GXuq5kKrzDwRUkqZm5oGzRd4eKiTNJo+pOHHXlc/LEXMpHPTuTVL1aNFtHujJ1JNBsQTwaSks3sXw/BeslItigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754385349; c=relaxed/simple;
	bh=aGAWGoCnlSgQmOwSeGPfLuL4gjBegI5e67jfq5U8ylc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeXj27ZKmLh7u5Sc47BGOr5bvlJeVTjSUdwI02aJ8NHukN8qa2/E3rscR9iQrbXpU9ZK7wGvNGhuoj0eBycfOaNOW0NDyrNZpBfGDD5zJ/YoKygmqAkRvNDhy03kPhJ5EVcxOdjvaajyTJv8vwyxEF7mKEYsZ7bJ0CPStBiVxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=mHJbf5RA; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:e8d:0:640:bba7:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 4B88081A59;
	Tue, 05 Aug 2025 12:08:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F8c5BVUpU8c0-GO7I7gnR;
	Tue, 05 Aug 2025 12:08:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1754384900;
	bh=PPtHV1CcZHiPaeg/tV5PXIHzxoWkTlwtb+No67Nl1YI=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=mHJbf5RATew33cYKT4274q6R9/CCdg5u/Kih/XYV+UPnNEKJ13tmaUdip3q5s/H7H
	 t2ECpm9kRWNaOB23S/HVObYWcT+ULrXQls+Aw5aV0QPpF/+dMD0Z34ZnH3s0q9rpbA
	 9TnIQlxFV7JSmOSaVU1+GUPg7LuEfkvuy8Q4ftXA=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 5 Aug 2025 12:08:13 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
Message-ID: <20250805120813.1f8714f5@nimda.home>
In-Reply-To: <E997DCAF-552F-4EF2-BF94-1385ECADF543@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250621184454.8354-3-work@onurozkan.dev>
	<DASY7BECFRCT.332X5ZHZMV2W@kernel.org>
	<aFlQ7K_mYYbrG8Cl@Mac.home>
	<DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org>
	<aFlpFQ4ivKw81d-y@Mac.home>
	<DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
	<20250707163913.5ffc046d@nimda.home>
	<DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
	<20250707210613.2fd5bb55@nimda.home>
	<DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
	<FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>
	<DBRVNP4MM5KO.3IXLMXKGK4XTS@kernel.org>
	<E997DCAF-552F-4EF2-BF94-1385ECADF543@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Aug 2025 11:15:07 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:
 
> Btw, I can also try to implement a proof of concept, so long as
> people agree that this approach makes sense.

It's not necessary to provide a full P.o.C but a small demonstration of
the kind of ww_mutex API you would prefer would be helpful. Seeing a few
sample Rust use-cases (especially in comparison to existing C
implementations) would give a clearer picture for me.

At the moment, the implementation is just a wrapper ([1]) around the C
ww_mutex with no additional functionality, mostly because we don't have
a solid consensus on the API design yet (we had some ideas about Tuple
based approach, but seems like that isn't going to be useful for most
of the ww_mutex users).

[1]: https://github.com/onur-ozkan/linux/commits/673e01a9c309c

> By the way, dri-devel seems to not be on cc? Added them now.

Thanks!

--

Regards,
Onur

