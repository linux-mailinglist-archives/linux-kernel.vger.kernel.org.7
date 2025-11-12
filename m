Return-Path: <linux-kernel+bounces-897018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCCFC51D17
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EFC14EAB74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A759301473;
	Wed, 12 Nov 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED27z4KD"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5723ABAA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944909; cv=none; b=J8TUqMoi4ahqYMygUeMwNaxwhOz1j1W/X9r+Dm05sWRXK3w7FfGQP+27OfJ3NvZy30u/yL+t+RAsUhNyaMoUCi5/S4NiNG2mzfsN4woLUtY2BdjZcYKZLMXmeUntXVrQFxM0KhgyTHJHmb38E+cx7U7ETrC3dHW8iE0CMTQc+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944909; c=relaxed/simple;
	bh=82sfAS4BKz1KNiaLNqx18bHdwdUYK8X02FBvH6vmN1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGyIVVOo/eU075kl4h1WUGn1IxYRsxK+PRjCSKvZeMIx38MmkYU4D8bQrYN8ZAvblfyOSLSz6sh6FgXkqVrcZaincVkcyHnrwCthmjja/Eq3HM7Bci/9NIGtpGa0LPbW31TDQ4AVOmf7MgKz3hVbjcccdcJvaeo+O9MuR+u2194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED27z4KD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29806bd4776so738905ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762944907; x=1763549707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQJWtPZk17V4l48RMFU2vUfDUBcuLAHxhxXOZo4IqCg=;
        b=ED27z4KDla66atEkRYysJmuTML+lQHJxLuAp3jhRIY1+XlSwW+hrhyNhdm0TrxwI41
         iBlsA13sWRigSXpGnp9wOKsIhOi79fY+8GWGAg/2xPPHITEM4I6Ao+gB/jOUHJUFTVVj
         TQkwS0vY2dv8SKDri2fAeJe9ThGageatQMLTcaIm9jKEdqvsQDKdC+OQqWvXN8ctirmd
         GQH0gOU5QuNuhBkqkdeYagovW+jnqwiJEQ4adTMDi9LqLpJ23QSrIfb6Pu1pkK5N18RB
         5IRMoTMy1qE45ThKmUaMd/5hReGtC2MaBdD6k7Eci97Cb79IDn8lQZiN/kHZ6r1geQ/x
         lQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944907; x=1763549707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQJWtPZk17V4l48RMFU2vUfDUBcuLAHxhxXOZo4IqCg=;
        b=TubuATAK8bs1uSWip176AqIBkSZFGAuaIjCns2ZbQg9JiCUVsZCpEMAldKpmUTJkFl
         juKtkJwOsyC1+nRdxiikqqBE8nwK6DCth8Pxj4q4c1xnJZq7UWwdF0gon75yBXsFISuf
         RwaN2t2n4ggCgfPq2nmhI1djuxkHjFmc/FI2yjyVu/LZ5D/2EQuvgS3E5iGmKd1UbXin
         svXgWmQtYbTMQvIUaS1yQ5Cn6T1zjCOORGZ4Oxar5aRhyIWAm+W3dC1kfwwin65O7kkE
         3KnNc/AccnFRGglyxn2FiGPJJSRZ5Tez+a0blrC95V63X2F4jSmZJqeBreJCfVYisqdJ
         Dimw==
X-Forwarded-Encrypted: i=1; AJvYcCUZtY7Seu61yMbG3Og8p1R1ZkVOqAU6eKAWBkFOdbN/hjZoy9SbO+QClIswwYaIxoN+1DL84ttozJEpiMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsU1nvsWy1eOkQw1LXcGV9e51m96bG2j9FElw5repBgif1L28h
	R+hdaOEon0fsuBbgqnTjQt0t8SUWg49AnAiRqkeqSuePX0CO4z9WGH0U28uJNDL+TSKwUN9cbz/
	wh+EExWOALzwbz+Vkqvp9Umw0zMeeEVk=
X-Gm-Gg: ASbGnctxwwiI3lobMbNGa2DW8yza5qp7nMiWirNs7xdfjTkBCqx+5KWXQMA0CANb2YZ
	F4RAq8QoqPOTfLHsa2bSuEynzD7Cv9vWwvyEC8ORNEOPoHb5b07F6Wt6uZvvurs3GM1Bi94u/An
	f6MCmNmPizXUIJDQn+ZL9uYQg5U7zflRhhuE9MPGlkbjudwJs5f6GBHrkij/PisccFGsgFcifJj
	3jy4lfyWuq20neR44tlY3BS2IBOUQP7d361PhKrebDcOtADUXHdmqJ3mHpQH0vly2SrFAsz2HAe
	rkaDGydBSNUaQVYAuBaxlJs/W2cMXj7Wctv2IceasNJWzLmwYYHxHcZj/tEPvX/ETPEx3oDVRhq
	fixE=
X-Google-Smtp-Source: AGHT+IFsTy6OYScG+CerWDpgPGJvvrpZZa2slmzCw2p2FhMd++qGQwfMjY8XkE5BZNsi8aZK27qX30hA8hzulfn8Qac=
X-Received: by 2002:a17:903:2282:b0:297:df7c:ed32 with SMTP id
 d9443c01a7336-2984ec8fb37mr19636225ad.0.1762944907518; Wed, 12 Nov 2025
 02:55:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
 <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
 <aRRgbZ67cuW4ZoBN@google.com> <aRRkzrUw1iYNt8KJ@google.com>
In-Reply-To: <aRRkzrUw1iYNt8KJ@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:54:55 +0100
X-Gm-Features: AWmQ_blEy9lDgXUuRaA9PFmJsOL5mkEF1Q6ty6i4iYdlOSuG0l-50NngYkbjG7o
Message-ID: <CANiq72kEYWbQ_yqJKHoa=ffereCun4A6rMudrcU+qBK_Npks8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:43=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On the other hand, I think that the first patch qualifies as an actual
> fix.

Yes -- for that one we should add a Fixes instead:

    Fixes: 493fc33ec252 ("rust: io: add resource abstraction")

Which means it may go to 6.17 as well and the "# for 6.18" part is not
needed in the other tag.

Cheers,
Miguel

