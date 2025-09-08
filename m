Return-Path: <linux-kernel+bounces-806368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21143B4958A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037871C2093C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03A30F80A;
	Mon,  8 Sep 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIyg6F2w"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55554205ABA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349144; cv=none; b=lKs1cjc18OVMI074RyquxPSJ8ofsV0XHrQ9FVXBZxD1ZBVz62Ez01+l4Y3AUgdE3FBhDDhU+KxZU/lKVl8YBhmLhyhVkretogf8z075n1d145n8SCA0jfFQXLflaskE2EtBZ+qIn43fgKFpd/Kufg/VTTAESh2OUs297M9TJJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349144; c=relaxed/simple;
	bh=UoSxqZLwvjJ+W5ldROygOM7fdzpSBHyK27BKs+KwPLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIZhYMLlZizkwWv0IcDBwLz0k1Hob/+hhi+cwV/pqvkFL/6IFQYQsUyyyDUiwK5H/vWtrz7TWNqQxEEP2m0QkJwD42zltLfCCNEpgAfnT6W8Q9bsz/8ZSpmeWPtTIdQhaHpjW/j0mdww7tsL0mlZZx9B+cM1ed1OuUs66plHj5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIyg6F2w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24b150fb800so12224115ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757349143; x=1757953943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOHckARAzjSnD5XqHvXfv11mR6xBcj5eLuDkGHpT+0o=;
        b=PIyg6F2wieUaNMvT5l5aGvC//qEas+8IR4huDPzZBOovt3UyXxtl97MmYI+7e7K63K
         b5RNOgSxGxYw8A+oMpsJ4sqQo00tF3OVH2LZ18GN+Gjp4g/dowCjSvgAUZgTVbqBP5AB
         8tXnRrn88fEXNfNvJJvrLrlxTeUsmz9Q653WT5RE436fiqjmJeikndad+tPQUR37b1CQ
         dKgaw+B31Z9xk3romoGBpY3mzQUx7W6t3oVYoMhvzm9eb5MiAcY4U6O4FsMRi4FkEkEk
         VaW70pmTiwz5V8qg1HJt+zxPvhuxdEGcI30JrgVZpCyy2SlBGWZy3UxwUzWlMCiR/pDX
         qV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349143; x=1757953943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOHckARAzjSnD5XqHvXfv11mR6xBcj5eLuDkGHpT+0o=;
        b=gik5hJ2iTEMy+/Lj5Vjvta7NAzI1JqFCbA8h3r2g+i9PPctHiSPRNWgE1SZ/iI/Aex
         SXFJLB9ukuy5JAA5Doq72pNv8d8wwHHIqdpyA3SWwwozfdmRSStHmWHq9RH46+OrIkKW
         E6CSMQyw+wCDzthXNDm1E55OC+Caloa6LCfWtIQy8g4EceKj5dpz3e3YjtIMBvLzzHWu
         hXfpBU3KYE/SXuF8UzdRyUS32Tve1Afm4B/sCUUiJU9uZ6HDBWS6isFOHo48ktgxL/k+
         MveInd+vlVqRGk7/BminY9NlENEaCpLI27eW3t0h1pHnMz9jTkHIhmsa8jeXk7OQlF3i
         iB9g==
X-Gm-Message-State: AOJu0YwEDNln9yngYYQ1AkSUn0QTOUWJJSIyRf3b2yfHfJ7p/DdKSidc
	yZK5DdVAW6/OBgZWZWVRhNpRLtd7h4mMi3s0utfc22wycVPcXQtGnM2mefjzO1LpwE3hBxts3AP
	zfBEQjTLj7CwyNYUF0gf5szcE/XBJuEA=
X-Gm-Gg: ASbGncvNEBL4mDdiSnooEI+DR+g7O6VigQ6RuXkejVKuSw4NZ7isXB0jJEQJVrIysfW
	vhGVybEf5W6HhPV+0FkWhkl0Z0TZgJjkCykixZWEBQCVTp+rVPkOW8nSiXHKZrqWVc5WHda4bCd
	7moerc8W72OymUoHRfpPM9609TfyDSyCHOmFbUIzTVJdCMO/0ppKs4QE+EvZJ1Foy1Gd49DuUvj
	HUPVp6SM50/wAOYIE4qKVI2Y9g4S0evEZ1R4afEWKJwr2cwMZrW75FJuyT6pcgK1OZa/bWB2tUr
	VJxsgFo7sMoOYPI9yhuMDW1nfL8GdK52zYEkkksaKhtgQUg=
X-Google-Smtp-Source: AGHT+IGBMEcsEfLwrnaPqrIwoCQoztMNrnQ+yijjrZW50dqiJSfSpzIPRSqaYzKuBgNmINNfO5ktIrZ02yLJPHrHHx4=
X-Received: by 2002:a17:902:c203:b0:24c:b1f4:88cc with SMTP id
 d9443c01a7336-251757bab71mr46772935ad.9.1757349142637; Mon, 08 Sep 2025
 09:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com>
In-Reply-To: <20250908160224.376634-1-marco.crivellari@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 18:32:09 +0200
X-Gm-Features: AS18NWDjPw_A7bqwfFLpIv9dVxi8NUPCfc_-v0uamw69CRZEIxhIEXxGDVH5PyI
Message-ID: <CANiq72kJxwEncXVVrZoMyjXrtsJUGf+kamz0G+d2we7Fk1Vp6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: replace use of system_unbound_wq and system_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:02=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Below is a summary of a discussion about the Workqueue API and cpu isolat=
ion
> considerations. Details and more information are available here:

If I understand correctly, these two patches are "just" following the
C side, right?

i.e. the summary below comes from that original patch series, but this
one is just adding the `system_{dfl,percpu}_wq`s that were added on
the C side.

In other words, I would have just said that, plus a link to the patch
series or commit that actually added the new wqs.

I would do so similarly in the commit messages.

> =3D=3D=3D Introduced Changes by this series =3D=3D=3D
>
> 1) [P 1-2] Replace use of system_wq and system_unbound_wq
>
>         system_wq is a per-CPU workqueue, but his name is not clear.
>         system_unbound_wq is to be used when locality is not required.
>
>         Because of that, system_wq has been renamed in system_percpu_wq, =
and
>         system_unbound_wq has been renamed in system_dfl_wq.

This is not what the patches are doing? There is no replacement nor rename.

> =3D=3D=3D For Maintainers =3D=3D=3D
>
> There are prerequisites for this series, already merged in the master bra=
nch.
> The commits are:
>
> 128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_w=
q and
> system_dfl_wq")
>
> 930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU f=
lag")

Why are these prerequisites if they are already merged?

Thanks!

Cheers,
Miguel

