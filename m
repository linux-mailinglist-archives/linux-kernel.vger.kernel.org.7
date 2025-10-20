Return-Path: <linux-kernel+bounces-861836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC88CBF3C35
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D738351811
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D692EBB84;
	Mon, 20 Oct 2025 21:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfC0+dAB"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258132D323F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760996049; cv=none; b=o94AN+i6+ggbOIlzazinl1kIANofJWM04+eHvTLo0JKxL2fkoEvY3RW0poRlgJ9v6cz1F0EsTtjTv1h9oO4dOECtt5pGodfyYKplNYWB1Vx5TZjzKfbc8HfDta/tPNvlsMOD2A3pkXZ7/U3xRRgoAt/qIalMxAx5YTFWpndFRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760996049; c=relaxed/simple;
	bh=TIA8kHBtPk6GgWmqAWWXnwTpPlJ3gJjCHeq/XdJy1Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNrIvIcSKWy3RopzNfazbe6RI5Wj45L4RjLY6vI2+mimRwz2FEzPgsy34fOyFosTLI29gQTCvl1ezX0SYN5er10McqmewbPoJ9adH54Vlun6tkKdcD6ZoI/ZotSDVjIOBUOiN8REcfUb2z2u2dmA2FU9k5tM443fil/gi9W1L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfC0+dAB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6a42604093so124998a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760996047; x=1761600847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIA8kHBtPk6GgWmqAWWXnwTpPlJ3gJjCHeq/XdJy1Q8=;
        b=PfC0+dABzi7McEPnvNXL1o/SGhMP6mPPuVFfSs/N4Z/v7KcBkwXhB8C6WEEpTjviEB
         mBTHjyQv5KuUNSCctqXDV40Om8VrnJLYoRZO6Ri1gqA6muV6O6Ec61kQDHTR1q7YFiGQ
         +HQGcXlcemS5sTORHQ9oDXebIBzXM5nSShozdgWlC94FDtuOHMaxeBz1Web5psx158xp
         q6EhJ2KfN4yl3dZl/JgGuKOn1JkpyOi/athv84+iZiZAShJig2ZIBWPV6G/Z4k5+q9ux
         PFEgLpy6Mld+8q7mki7/tizk4SY2j09E2T/fwxQ9cm/9jBJda331/KbZBoCrgxU/u20T
         wLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760996047; x=1761600847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIA8kHBtPk6GgWmqAWWXnwTpPlJ3gJjCHeq/XdJy1Q8=;
        b=ezHz8me8z0h1KD2YmpjGKZ6pV0tt0fw1zbZe3pJZHM6w81FvKZ9W9UggIAGIGeDn85
         sR80vhm5iuerUW3V4Yi4WFk/E9gvemIY63qJyp8QJ6S7XpNttOKHG8MmEjUhBbbby7Eh
         uaBFFTeyH55VzaDxak63zzc0VxhmjseiDy910MaAFFq1CRk2iTPNPDoZgQ2z7wRcepit
         o1GgHCtygh2zg7kO2M9+lN+PePw/A+YjUG7bn8ClU/VLmL5l8uF0YrwwGuf88J33Znuu
         SW5I8KkCH/PLn++WjhOuC/WMwO+zrQF51mc3gN9d6rGhHa3amRK2juO6JKLxKswJXFof
         9Imw==
X-Gm-Message-State: AOJu0YxT3SwyIJvtxeJ1rCQiB7IylHd320L7TzxNquMYuPLs9iyDJvcO
	UkXZZB+rcLA6/A0LXjgN18SvvISUWw2m71LWXqy/KwKg+pMYOUWW+RGh26b/JlbmGWvbEjSp4UH
	se4P3qJiFvkFjquyMOghKhKLmYnDoHm8=
X-Gm-Gg: ASbGnctgUnH3kzTTk+JgUhRAArN0Uksva2gbSaM7r64VhuH0/4YR2ARNm550/P6sFAR
	3F18hOaBPMSC85LZTfQr71sSFG+1fLSO64DJicpPnxOv2Ly463bska88rGRsdc6pXni2Z2z0wpm
	DX02EOeIlQmAvcWWQoiWJ41YUCG5byAPQjPZO/DQFHac8vxmfPPKI81S+YPITJgDN10X8W8ypDk
	LGWO1uzZPzooRupbC0SpOw7oagmnwpdDI0Bi6OyRc24dQEwiatHYG7eY49XAAc7t17A042pCHYI
	0bSz7/SGCQAgwBX0dqlZVckWx0tANJGGVDc5nJzI7COKKWrm0p6MIobLZilMEJxEU4k4F7xYOSL
	MhVXgTVlIfsTnkA==
X-Google-Smtp-Source: AGHT+IENeHKMjyzGTYHHZV28uVbTm7W0v2W0HGYIwZ1YpX54wVhZRXd1wDtmMhBidXjOzxTnYzIEdPK9TNFHSokqIok=
X-Received: by 2002:a17:903:94e:b0:26a:3c75:5241 with SMTP id
 d9443c01a7336-292d3fcce91mr5493965ad.9.1760996047308; Mon, 20 Oct 2025
 14:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020185539.49986-1-joelagnelf@nvidia.com> <20251020185539.49986-2-joelagnelf@nvidia.com>
In-Reply-To: <20251020185539.49986-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 23:33:54 +0200
X-Gm-Features: AS18NWAADgBeA1nYLOcKyihsh6E3dmd5BWRM3ztrLw4uDz1-mBK39vAmoeM9Wwg
Message-ID: <CANiq72nGPeLvrjQB-62Ht8TR7oWPgF9HFO=yPX7TT3faqxnNFg@mail.gmail.com>
Subject: Re: [PATCH 1/7] docs: rust: Fix a few grammatical errors
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:55=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Fix two grammatical errors in the Rust coding guidelines document.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

In general, please submit independent patches like this one
independently, e.g. this should go through the Rust tree.

Thanks!

Cheers,
Miguel

