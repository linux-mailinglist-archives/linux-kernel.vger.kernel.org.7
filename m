Return-Path: <linux-kernel+bounces-885695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 292BEC33B53
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AE4F1DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05582217F24;
	Wed,  5 Nov 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="An3z4PlS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E732C187
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307443; cv=none; b=DQ716beBAp0rhWJu5RR+aq/sO41QYo7U2h2s7B4SWJgG3t8Azs74jc/bTjRSNesjQkvh2LZj07oeTvSKeJ7I59l2oFwdULhJXqw3NoDioyQBnZ+ATBvTLKWRTYJCw6fOdteVjfnwrHUaOfl8BQ9mlidzq3+SdI0OazlRDdDoI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307443; c=relaxed/simple;
	bh=Xoo1eWw+oKxOthozh6rdMIwwomqTZAcI7+etlq4bToM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBqRvXRq9ZhWje24+cP0pcNGeGwjHf5XY7zedPw95P1YZFe1uP4kn66rqueOrvwLlpTMZ0th/KSiKLyiY5AY19VR4FrJ4FnqR24oin1gBvDaWikQDuminXIr7Ds5+Drp9EpN76h4guCaC1Phrh6e6GgzygPQGQv0x/7Uhn39QKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=An3z4PlS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7260fc0f1aso153350766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762307439; x=1762912239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9O1EJ71YCT0OI8Q+97FbtiUgmbiyimj36/6bjgq688=;
        b=An3z4PlSXNnEPeiKHzsu04rGrzKB6w+WF/aUuW0GdVvoofBLuJvsyH19Z9/MLg9P+3
         gtJ6uYYVjeonxoO27NvVdNxx3uyGA6bgFguVHI15bga+LCWCcx5QQutppMTIFk6wfpJh
         wSw2MMtHKh9mZxZxoBWObFHdynOlBkizmaT0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307439; x=1762912239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9O1EJ71YCT0OI8Q+97FbtiUgmbiyimj36/6bjgq688=;
        b=feydRo3w21VcFruTvoyHy2ESLLb9brrGnP3RCcUeKw62KgUUuBONEjGo8Bv77PQWQ0
         gYASJxEDdvgzwifz+x5Qb2kuG9VkPWtzLiJSbvmudAbhAkgsJB2V7rVgw3ZSEeEva0vv
         Rw3rIBqpN3JriyVGZjoMpO/jXKCtyEPBFHz3sYpQNx/YiRwzRpGBQDhBSIJ3p9/T8zif
         Dho2QUM03LftcApzSdyG/LgcA5ki9JoHWwaiSH/lnp5Nn/kqHCvVWAGL11USN0+04dab
         UwwFbY/QsnUFtAUTWoUSM2FmFrMqG3+mREVnOmITqDYzLo3b/hpO28yW8DIYt/ymCtr5
         D68Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQKoBQQ4cgmmnDQKITs1uOS77dn2Vqk4+ur1fc2dZx3bpSZgOwKYFEdPo3hTV+gWdw4B+9oeZpqL9fktU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAKqBHGVbqBnoQry3yRyeFZdlMpoyUQa0jAC1BeTnHJA5CVw2
	Jic+hdfil0U+8e47SpmD32Gw8UUFU1RR0DlLBqsJXE25+Ec6RDBfPlhF284Dr+EyVVNijWmhVvs
	B5tV3sIG6gw==
X-Gm-Gg: ASbGncu3UTTjMd5dZaZpz7JBBOtUdwTkB3rhE6Sn65MQRfzyk0bTR2g0NLmYkV5Cqpq
	GQXW2aYbLsT3yjTWAm+1XrkuE3QRtVj2qa8Ytytp6t2ONQJUVxLjmrKCaXyhsAKYWyI/1MUZbVt
	zZMrzsjnTBaki0niVM5x3M1tAOUCvaqL8bIhPmDSI86ppiSPfUCzmo4XIJYnWblnGdQAh5rkOKA
	dVZMd57n9+kghzzoYH0XHNUsyDcrd5q7otrbmHZzk3Bwiz0PmmxruTxUc78jCDrq9hrJ0PZMWoE
	6O07q6d2yCSamNR9UggwX7KONY8CIffHq9Gdb+xV726Z9RxVXwbGhqe/N3wtA7KxSTHx1mZgPIM
	2rUHFqQKSDIjGPPwTNVoERLYW33f/dLM9pOz/AfWS0o69d6PBI4QZD4yTSUFMUGU0ITLE7Ai4jy
	UPlkXJeQeQuXqHydW8wHnGPCERp8xhIH9DAXejHSJnjO/HF1gSyA==
X-Google-Smtp-Source: AGHT+IHsLNs9eHJpqOUBCaEft0/E7GM3WzBOXXpuoRc9kBPftnUfHjqcM3OGhX5xjNzz9c28rS+Y8A==
X-Received: by 2002:a17:907:6d0a:b0:b72:5983:db20 with SMTP id a640c23a62f3a-b72654f55c1mr139134166b.32.1762307439199;
        Tue, 04 Nov 2025 17:50:39 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72406568a2sm356975066b.73.2025.11.04.17.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 17:50:38 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7260fc0f1aso153348866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:50:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgcMI/nmqI7C2yiN6ZFlK5mJXRC5xKYlEaNNJOshgWRW4r8CN+FeuKW4/UXd592yHlCJYYrA6NwyiXpK0=@vger.kernel.org
X-Received: by 2002:a17:907:868f:b0:b70:f2c4:bdf2 with SMTP id
 a640c23a62f3a-b72652ad183mr116255766b.23.1762307438033; Tue, 04 Nov 2025
 17:50:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
In-Reply-To: <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 10:50:21 +0900
X-Gmail-Original-Message-ID: <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>
X-Gm-Features: AWmQ_bmNvTH03i95LkvpehEJva-w_271URCZDbGW1hGWGw5T4Ng3DD_mmRBfixI
Message-ID: <CAHk-=whu7aVmk8zwwhh9+2Okx6aGKFUrY7CKEWK_RLieGizuKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 01:14, Borislav Petkov <bp@alien8.de> wrote:
>
> Did a deeper look, did randbuilds, boots fine on a couple of machines, so all
> good AFAIIC.
>
> I sincerely hope that helps.

I pushed it out with a proper commit message etc. It might not be an
acute bug right now, but I do want it fixed in 6.18, so that when
Thomas' new scoped accessors get merged - and maybe cause the whole
inlining pattern to be much more commonly used - this is all behind
us.

And the patch certainly _looks_ ObviouslyCorrect(tm). Famous last words.

                Linus

