Return-Path: <linux-kernel+bounces-726324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47837B00BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2AA179739
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA76B2FCFFC;
	Thu, 10 Jul 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM6Scgdc"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523B25760;
	Thu, 10 Jul 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752174401; cv=none; b=fZEnLGLc0lsYg5sJkwGb4aXSkyz1P2lIQlclqPFxZnsRrATlpQz/e0HWWOvShKUOZWP31kBnQpdgXF3BE7E0+4560aBsbuLF21+oU76W53TzNZpgPZWHNt2wcgbkV7XuuRdcj++EzDus7yaEyi1HE7HMJIGbdoG5ZRWW2ozfxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752174401; c=relaxed/simple;
	bh=94AYtTCHcgB+G/hSLDjAbZ7gRATPaUUGIZo3omc7D5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1LEakrWp/0rH7hwhO/SNrje1Ljimh89nxHUREVSsL+BQUBfx297jUuVJFEjlxao8W9L5BQ46A7xnDmwa0o/pwujcQdijC9KMbn9PY2ihxP7FQ+QutAAPOszgqfDCPziKvD0dIzg/dtmV2ylmgAm/1h0cgYs7vAGAZTgI2JAr/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM6Scgdc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e60725fcso254302b3a.3;
        Thu, 10 Jul 2025 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752174399; x=1752779199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68qpC4Y4uSheoQEbmMxx5RKOE+wIAn+KKwc+9lT74pM=;
        b=EM6ScgdcK7FV1BRjt+cspskLfjrBzEXkA0Iu/LxKX7ZFi2ODlxif5iY9XvcEFAwc+p
         E+ii9/AmeQioRfyJ8vPDHkavO6e0mdLlAeZ7Y1hfpsdggS6pAXDD+TlLhEIO9AA4N90y
         kk5WnVsyypNUns5sq86y3K1HsxFwNKvy83CAJtNEJHzaDP8hWQHmkc1DAzRd58EYDhjB
         WnBxn2m0xlZrNaJqVu1RrsbAIz+tA0oXRhwi1CdrDmbYBEVJT/nAPiiiwhPe+5HiHm81
         LE00aaUD1/XkGU5pobaDZcYseAWX9WVTGDa69Tjwq3hNmZNNQuHrB5n3Qr2XgaCCz3JE
         pCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752174399; x=1752779199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68qpC4Y4uSheoQEbmMxx5RKOE+wIAn+KKwc+9lT74pM=;
        b=hrAEUpj9eCbbpwZzeBs13kUrPpXUndFDomxrkXiAcauvgZAwV9R3D+RkiSOD/ElbBj
         FneEwt/mrnCascjgs5sz36nT9CR5PYzfm3ggNAU64W0rxfmoTMcWGLtaNthj83hHBs7I
         dpqoRZrwbgwFdpy91dgCM0QG6Ggla3yUOFy1Ucb0ZcbzMPFQ1+wIlaizCKXi9jvw8R5o
         9ET+PTVbXKUb9dMtHzvAcA54c6qYpEUJNRRGHCh/z4l9P/MeLjQDyuHJJDa9uGVr9WCY
         cHJ++koAbEgmlfPTu72DtqaPr+7OuIFaVeueTxLtOt30OSmOwFBBuO5Rb1eZ+fhFE2V7
         sfbg==
X-Forwarded-Encrypted: i=1; AJvYcCUWH8JtuOwIfBlGKKEydiLyY8eNjn1P6LdTtLPbu2S/sIwO0+BJQHC7s5v8XZeJL475uX5mWzTMr+nGmXYz@vger.kernel.org, AJvYcCWvb7cMBUpYciNrsF5049I6Ahc4dxSO0/LEYhL622XwQOiQoDwEt/4gX42eeQxnysVMdtBuDFhH3Kw=@vger.kernel.org, AJvYcCX0yRjrX3Rk7TFPH8iNLADX0Vha+kx7F2WUaTaEbAWkCDz31PlNvikw410Fp0CPp3ECVu3xSlAcoP8t/Uyao6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hzbE6yRKyFBZUPBQLwhD1rMup6X2kn0ACD5FI8J8NT34h+j5
	4ADRRALB3z5hQaAkcB1nsbU1jeRPjGo5k7MKGJi1pbj0hgsk86LL9OUwPUqb6Ca8LoOelK9qKse
	718nzF3nAd7usB5dFAwK2KHwSIrYgd8M=
X-Gm-Gg: ASbGncuk+kRVHmmJBcDqCUNI5tPOpUDe1B1fQxwOj+mh6auRgIcLJPn65nRKKD6IXuU
	F1DoV+qavGnPxivyXcjZaq42zKXKtjQEecORSOMVBDsERqkLBaBel4zBPfU4IrT2ehaEoK1224A
	8rbI19rL0H53hBOc39K8KE1HZo9hLdDN8VF3f3KZnI
X-Google-Smtp-Source: AGHT+IG0VJqe3uNAcjU3Xxte+v+hYbWn4ghp69RsSsnwscX/+eeuYBtfenFCSddGxjjaiQm1KOImr0VmDgF/3kDaWcw=
X-Received: by 2002:a17:90b:5645:b0:312:1ae9:1537 with SMTP id
 98e67ed59e1d1-31c4c972591mr333377a91.0.1752174399128; Thu, 10 Jul 2025
 12:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-nova-docs-v3-0-f362260813e2@nvidia.com>
 <20250702-nova-docs-v3-2-f362260813e2@nvidia.com> <CANiq72nh71s9to5v1KHJWN79bEFv97zN6jcGJyEQkaJZ5UuJfg@mail.gmail.com>
In-Reply-To: <CANiq72nh71s9to5v1KHJWN79bEFv97zN6jcGJyEQkaJZ5UuJfg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 10 Jul 2025 21:06:25 +0200
X-Gm-Features: Ac12FXw_q-goG-jOjFcf1y4t2ncn8eM_tujmaC9ue0dJR_ud1nXJSMx9bb--WFg
Message-ID: <CANiq72n6759SXO4_8jUryge3s0scp00hiKBnkhnbieObQdqL7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpu: nova-core: Clarify sysmembar operations
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 3:46=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Added the possibility of catching this automatically in e.g. `rustdoc` to=
:
>
>     https://github.com/Rust-for-Linux/linux/issues/350

Filled: https://github.com/rust-lang/rust-clippy/issues/15245 so that
they have it upstream.

Cheers,
Miguel

