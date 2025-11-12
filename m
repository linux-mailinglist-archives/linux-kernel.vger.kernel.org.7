Return-Path: <linux-kernel+bounces-896948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6EC5198F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B1A189D355
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228430102B;
	Wed, 12 Nov 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MifdhvqJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5235CBDA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942368; cv=none; b=pOce2FOCmxmit8iqjp8+H6VQ1RmTkdFcg0ksL64q0ixFqlSwj5O6WPh44cIQjfAKkL7RrPd2DUZFDLwuQjJyOT4fVn74gErZJQN2eU5udS/RpH2FUJABoOhLfaePoHEeaqif95edZKWAuxW+/eSNVeAus0AInVmwfuYJioWyCaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942368; c=relaxed/simple;
	bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2f00hf1IXIFnm3Q9IsL/+NUPGsLP0I+3AI6qQInHkdrgJ8XFuTL6YFQOnlTeY8gAJ8rlqchbx5jYd1ikGOQHdTDv4bM1zVnd+HRhIAHnXYZM9O3Mu7AyJ74m8hTykNUpt8Yg8+G33U8300bgP1sblGb5hMxkYf39A71KDvTLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MifdhvqJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ea936b39so972455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942366; x=1763547166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
        b=MifdhvqJ+tTPb55l+09TG6kR/bkYSEOysHx75WWgnuHLm0nKpxlmKNZYN9Oq3HqHof
         Idi9LIjy5A9ZujCthgUEbopWG/mIh1Bg8ur8A6Wij+heyR9UfjrRwugBBV2QOtelo0E5
         GlhmWycrrB1e8aLcGEBEPG7CbBGy6uILwpr/WhATx0ju1FnOYeWOGSo9wJcXNWz9vHcb
         mjpn7xh2OWnL6FEwNBIKNC8W6aeS+UlE9z0Fx0ugkb3NP8V+1pQrU8psLiXmBMaBZSka
         cNlu4WiJ4Z6gOxQCpSkVQE9a/NCjZoasTw5SLrICRNrdvU0MmU748ygdwxycCsaQKWuj
         +I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942366; x=1763547166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
        b=tuUVy9YeQ1u9YgRAx9ccOfcjY1dEge7n4E2KNFQCLBC+Os5bPz86TLtM9Zan3daFib
         516Px6C6ZYyk+cfk0eJzZMztW7Mxmp3Tw7/GqheO+a4H2JCq/15+yocgRsqgGpBU8OU3
         PA9ZWV4ktaFDKX3eKSWjM/zulpNq0yfjZfvf8xDpHI32xuEySChe36h0hhK+DkgyROY+
         Y5DC5XWW7l0UdMeWrryUCDJHe2iZAGAWX18NzM5PYMfN8CbWLS7Z8e5PWUDUYhxCz6PY
         t/9AbYE01eKV1cowgaPuOxWGb11v7pObVLkpQqIaGO1/vZidLPrWSOZoMQ0rY88cWe8T
         xkqw==
X-Forwarded-Encrypted: i=1; AJvYcCWNPm/Ylfv2gOe1wP7uUOYwKOXDKS/fCkR8hzB1+fqexBa3AXgEebDD0AFZUNruGxPamo7YBkSYPLwObqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzhd1uOCixUK4zxK5LafXbF0Pvs3qssh6ZWl9aawoSHOiZJ00T
	4LJP3DlE/3+dDG+L+IU0BP6yfRWL5uChJ9+yqCL8x9W1OZrrTCA/cmM9dqR+WhEdeHY/en9Wppp
	uBhjE5YKPT5t+Il2Fvv4tv4QmfVgdg57HAiDS
X-Gm-Gg: ASbGncsZ4XbzWh1IyO6c7QZeq9WhXmXcGaWQsmRhYElrmQcGjHNwjrZgoXpj7S/5ui8
	xytVuDRJTBj10l8V6Ub1WIKVm9+VWtTUAm97QOyjMhfU3hJfs7vOuw9nKYQ9RVkaCjz5s+22As+
	145Vk1Dh5Eb3/HxYgsIz8UIscxLLkyB+v3sXFWPfQ/DJ4dKWwhFYquyUwE3EnKzb9h8WliNNyfM
	CfXISH0GXUQtSSwALQXYRHKYS7wHjFU2p1hmYnkxbC7vKh+VQv/3iu9DTCrIGQXETAOSfZ1eLa9
	omWrDtnpzCEv29PzieRM3VYrO7qz0pZRxuoD/46w5Ok1U2p5jWVnm7hjYGRiOUyq3i0nrgMyYU4
	KWTY=
X-Google-Smtp-Source: AGHT+IETQ3SzNJP38qICCbEJ6T16t3JXamoGxAtaT33VsTBIiPh7Ibrz13eIJsuaIOpzM+bZ1DzCCfzs16H1v/5wS4c=
X-Received: by 2002:a17:902:d507:b0:295:3f35:a31b with SMTP id
 d9443c01a7336-2984ec8c0d5mr19845645ad.0.1762942366026; Wed, 12 Nov 2025
 02:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:12:32 +0100
X-Gm-Features: AWmQ_bnuNlJCsmBmrjk8c_BTNLULhTvw28twSuVwPkKbxpTmlUU6XbLfIppmVjY
Message-ID: <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This changes ResourceSize to use the resource_size_t typedef (currently
> ResourceSize is defined as phys_addr_t), and moves ResourceSize to
> kernel::io and defines PhysAddr next to it. Any usage of ResourceSize or
> bindings::phys_addr_t that references a physical address is updated to
> use the new PhysAddr typedef.

Should we have these as actual types instead of aliases? i.e. same
discussion as for `Offset`.

If there is a change of these getting mixed up, then I think we should
just pay that price (not necessarily now, of course).

> I included some cc stable annotations because I think it is useful to
> backport this to v6.18. This is to make backporting drivers to the 6.18
> LTS easier as we will not have to worry about changing imports when
> backporting.

For context, will those drivers be backported upstream too?

i.e. we have sometimes backported bits to simplify further backporting
elsewhere, which is fine and up to the stable team of course, but I am
not sure if using Option 1 (i.e. the Cc tag) may be a bit confusing in
the log, i.e. Option 2 or 3 offer a better chance to give a reason.

Thanks!

Cheers,
Miguel

