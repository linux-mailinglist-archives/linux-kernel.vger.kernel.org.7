Return-Path: <linux-kernel+bounces-790617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30246B3AAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5854632EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486326CE2E;
	Thu, 28 Aug 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL1kNv8G"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03870273F9;
	Thu, 28 Aug 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756409503; cv=none; b=V+2YUzniYsZCU1iGFxsFAL+Uu4Q6PgzCVQpAkR7lfzVlvLnwfF22WO24en5T1WWH5IXIP0NMO8Pb7ulQC76He2btDr90WmyADzAiRsvc7ysIOtrm7rHpayJSpW4wMvlRy4Ydof0jnL/NNHoWDfNIvoJqSO49o1gLQFq+a+B21Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756409503; c=relaxed/simple;
	bh=20L/t/dQg856UitOCMDzjeFNPY/n61oJgouq8+c/wpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZkN2T+/GZ5476xRunNsAF64vGAcBVlfCtE6zBxeAqk7YmdToXtD/xhIlkZhc/ttBQVuHXHVRX/mZkiOL3EVj/VPctvTTyBoozS0DFpdp1oJCexu8Xsl91Gd++psajUrvs2104CAwf5TQP64QFSIEkv4lcM+cWwi5Tm1FI06ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL1kNv8G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248887257e0so2962055ad.2;
        Thu, 28 Aug 2025 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756409501; x=1757014301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20L/t/dQg856UitOCMDzjeFNPY/n61oJgouq8+c/wpg=;
        b=NL1kNv8G/+grOD/M4kjl3uEmJ34zicYMUs718OW2rijo+P7UD110yohPgieGu4ov10
         8Bx2P1953GCvdci7I4463nK4cz+e/Q9wWh0OwlRJA/K8udf2fx8cOyzkfQHe4EaEGG4g
         5Xi3f0lIR3SvOcGKSsHDmyEUgGRLo9lFN6miylFRmO7YUajpLDb5EDsIV8ZupXf3nLms
         Qb0Fn0sXsQWDOYESNQW2QblPF6S0PQdXJBSfSDn6gtqCFei4XaVIm/zodckfUY+HFQLl
         s1m2r57MQzyxgFkM9QlifxXbEwMOYjP1Wj46F1rxjWink41ugdZg9aZDTbQtK6KWAPxa
         TU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756409501; x=1757014301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20L/t/dQg856UitOCMDzjeFNPY/n61oJgouq8+c/wpg=;
        b=oNJcxg1h391zIxCfjHaAELMYHlNAffbSE0cOV0VwS/V8GTluq8QYyweiNyDBtsYOhw
         6LjWh8/7+8Ly12IsvirxpiZstBC2vJpGb+HzS7mBUgl1KRjbvLNBoXSfwBhyvQnDh8F3
         oBLqV/NUz/Wj99wAjFM/6gSzZxizOSuCHrCNfHGEuzMfChSsgotbt5/eQcVQc02DZDAi
         WTO6w7/oW4wUVkgQn8KSNbHo9SS1jLQbi3q3FnYNF0AnKWBvZenXl2PjGt3kaxXJiazr
         xpVsPef6+twzbGeh1HPavLAT5OGHMg/BSlpG7MgdoCdDnb7qjtgI/2DcY1AXppr/nuqU
         QcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEUJrUICJw33PCY8gCKVVp3XU5rMamxFgKJlJsd9VUvGnxIlBbjyjTBta+noP4FpCR5d7DnU/ElDZos3xPtmE=@vger.kernel.org, AJvYcCXQQb+1ClZ50jc+PYQfixWxR2TqWIHf6JOUaMxshHABChNe36Yq8pfZJQcIEFfoSGL7Ivh5OrEXvqeDnHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6vV/hhHGx6KhOQ6cOWTPEFZv+5QVWnZ9uGt1fs1KxjdSPbd4
	SKwhPrvVl2swDJB55yXmhZNbuVzr+pKiABOFT/Y+PoID6OVAFl1xvS7Oo1qCishwxL4J1Ocb89c
	Bqa4LaD+KHB43exkTr4YtXXFW5TUT5akL4CYo
X-Gm-Gg: ASbGncuuegFf7i6FxYJvZZwquB4+8qGDF75EY3OlIu+dsXXylorms/Vkft/EmUJFlIb
	JKAUTAY9p+j7adOj0VDm+WsZq8rZjsuPp4d60gmocI+yGvZ6TSkatgztWk9Xa+jt4aqVCWIEwWU
	dDTkPrFb0kMUfYysgQAIWpqeUkVK04mdaE7mfBBnm9u9H0AYxFS1K8p2lzQUiFyMT47/4roXdlU
	i6EANXAg8SBxvjc5O8cm/I0p1/rEj2AiJSGyYjtSg/5Pl/tGnGI4kfyvOhk6B7s6fZ0U/6LVTFa
	azo+CEH9LX8Aw7fIosrPt+K7t1BXiXTL2qP2
X-Google-Smtp-Source: AGHT+IFWdw6UhPiyKJrbHE7IDTwFisR1W8SRBwQA99k5or2f4Qr+eBc4mB2thKEKcqtoV9bQyWk8o9eMXoEOsRDv48Q=
X-Received: by 2002:a17:902:d50d:b0:240:25f3:5be9 with SMTP id
 d9443c01a7336-2462ef6f3fbmr183406685ad.10.1756409501161; Thu, 28 Aug 2025
 12:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828160247.37492-1-ojeda@kernel.org> <b680c343-ba97-4eb4-b426-56e318dce492@kernel.org>
 <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org>
In-Reply-To: <DCEB1J2P3MZS.3IGXEYP0MAC5H@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 21:31:28 +0200
X-Gm-Features: Ac12FXwvQbB3YxWRKL103qR7GEVPMjkX_VgeadkNh7YUOWF4Fhw5ZECkLfkRVzk
Message-ID: <CANiq72mkPqFnb4ztiCokE6+ntVSmgOTgERshg-4SMmLboFOqNg@mail.gmail.com>
Subject: Re: gpu: nova-core: arm32 build errors
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:24=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Maybe I spoke too soon, it's actually pretty painful to keep 32-bit
> compatibility, even though it would be nice for testing purposes.
>
> I'll paste the diff to fix it below, I think that makes it obvious why I =
say
> that.
>
> Instead, we should really just depend on CONFIG_64BIT (which implies
> ARCH_DMA_ADDR_T_64BIT).

Yeah, it isn't great.

If it were just that, maybe it it is worth it (and a `DmaAddress`
newtype, not just a typedef, could perhaps be nice anyway?), but if
you think it will become increasingly painful later, then it may be
best to focus on what matters.

It is unlikely there is going to be actual users on a 32-bit platform, righ=
t?

Cheers,
Miguel

