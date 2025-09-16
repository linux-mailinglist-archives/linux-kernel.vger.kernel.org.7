Return-Path: <linux-kernel+bounces-819679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E19B5BD65
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58FC3BEA78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D990126773C;
	Tue, 16 Sep 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucs+ZyB+"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69E4A04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060276; cv=none; b=rDXnOcQHw27hFetUD6fFLknYyflLr6uaKXYTdm/GFgyaUdXlLvNvw+hmB7W5rlZcOeuOeENCCjOL8nTQbhdZQG9Zkr1L88DeMCrFP+yuyH2xWEi04mQ4ZH8j/5N7YCTzgM9dNd/voEI/zBRsjbh1w00mte/GcJm7o9vN7MpP+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060276; c=relaxed/simple;
	bh=8Dz3xveRLNWxE4m+S3m0+eWLQADWkiJx9NmSO4GJqto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiBK3zWRe3oXRAOdMflVWzmzLjvmjO53GHFOgn3hNp2T1hEp8h/lZ35TWpoeRi8YHzyoe9z0amEAnD/6F+JX9y94HerwH3+iKPceY47d7g/mnpPHgZqYyLvIgzzG8XK76dfhh/eqbjKXwVqHDSiNOX5LxoUac/aW+9nig4TrHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucs+ZyB+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b79b0eaac0so20711cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758060273; x=1758665073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO0OExCnC+Sl5h2asp7Gvh1+SINfuTNdIpxLbVzAb3Q=;
        b=ucs+ZyB+Fr8l+/rbNY8twX30sRV1b0lfIjKOqfCTDjLNR8SbDGPApyOKW2TBbdcMsg
         M5GZwHurVvZbiFVHvihp5p02HOuK4EYx9IWK5+ZMFzzu5sz+gIhanaG2jPEclILRD+Me
         ygm0PSL64vG82YXUBh30kkXIprKmZ9HsuzwJcQ3s5y40hVkDN10Ws3QhivUiF3E7KNhb
         yYCc6hPqk81XRC5xxq5p4VT4YEdL5TEGScPl+pGhuhHBcMtOqg87haZrXQGH4u1wRr7b
         C7D+Bw+4bwW6gZ0XiJNsr+JuGTWwy6ctiJNhiQ216Pr7AqKEA0+aC6MEqAMPmVqNeAPw
         Y22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060273; x=1758665073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO0OExCnC+Sl5h2asp7Gvh1+SINfuTNdIpxLbVzAb3Q=;
        b=ZXP9VcrXyg0FYcm/v9hGMsCCeaOxlT4VfxH3O6mCsHbeNOF24rSJ452Bkmk/j5lh2s
         bKp/rxqDAaG7067yc0SoV01n8VxS798Ur2CuaDJ/w5DDOQyDH+AQ162tYR7cq+uB5BwV
         SFUXMrf6lkBPFSkCoOTNgiYzUYAIn6TXQrAtlCbNkXFvz0/kbgS+IgS4zwQUgKsJuTzS
         +qU27xZb1MIYXOf5PK6I91+Thrurs0N5NX9aoOP0OGM9yvotDWMXWqGLdpTQhBEaUtpx
         sJOurTvSL8uUj4OSdHK3avDx4OB8k771hwLNwQMdQHTDnerU5idnqyCpYr2h/7pHk2dT
         WIJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7xt8/fzP/PGJx0YCdxgEaQCKffN2PsKENZ/jVhD9ecLLQwHilVh5nwrFeJa4zKVhXCkVn0eiQZd6r2/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDg3tSS4eR0kMrUIzi3OgXVTLBqgWtMQFMvo4g/v/ApgOjVh5
	yyuL62HvYGEtsNbw2jx93SC8crMPy8uWg59DfrKIvkZSnZDnagBuD33TfuuvL6CwXiZv4Zp/TwV
	Xf1Uqu7EGo8qT/q25BEVXLtRtFXGrUkzg31ertRva
X-Gm-Gg: ASbGncsvqIylglc5xzkbmMFX43WocipCiFr2F4Y0K/mkrE3QAFA+3x5cuqlhuUavY2T
	wvq1te7JVbYXmJTj1riqi648eVb7AFiLFFbhBxQIfHwrGUBO6PJ++f9JfKOnaNXt2hkzzX3YoyA
	ruGQ7yZV81rCTDokylCSjKSIj6OLMOssbNnmKyH5MTTNIecumueJevlld47/zJN2ZeOh7sZ3c85
	TD9l5elSdpR5+c2RGh/MsI04dMiXjPh/0g0vfxV/mc=
X-Google-Smtp-Source: AGHT+IGsKu+cTvUnrE+14NjFE3JwC3AX5wEjcsUr7wNzlgTYrg4z9FFihrHIMkxTd4MhTiMWV/kr4UXdJ0+aCZG77NE=
X-Received: by 2002:a05:622a:512:b0:4b2:febb:fc96 with SMTP id
 d75a77b69052e-4ba2dbd8e7fmr647301cf.9.1758060273178; Tue, 16 Sep 2025
 15:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de>
In-Reply-To: <20250916-mm-rcuwait-v1-1-39a3beea6ec3@linutronix.de>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 15:04:21 -0700
X-Gm-Features: AS18NWAo0S1mrj9xxOmoISz9k1x-YAMjgdLRC_PrTLqqMXhYSeUwuLtYX6ohgmk
Message-ID: <CAJuCfpE-DPBp-0b0908FHvguSo_PqxE2LdUXvBiMLu1UCd5icQ@mail.gmail.com>
Subject: Re: [PATCH] mm: forward declare struct rcuwait together with rcuwait_wake_up()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 6:59=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> At the point of the forward declaration of rcuwait_wake_up()
> in mmap_lock.h 'struct rcuwait' may have not yet been declared,
> leading to compiler errors.
>
> Add an explicit forward declaration for the struct.
>
> Fixes: 75404e07663b ("mm: move mmap/vma locking logic into specific files=
")
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> This doesn't seem to break any in-tree code right now.
> I stumbled upon it while building a series for the next cycle.
> Instead of putting this fix into my series and spamming all the mm
> maintainers with it, maybe this could be part of the last mm bugfix pull
> for this cycle.

`struct rcuwait` is defined inside include/linux/types.h and
mmap_lock.h includes that file. Could you please explain in more
detail what exactly failed when you were building it?

> ---
>  include/linux/mmap_lock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 11a078de9150df1beff4f0bfb16e199333767614..9792dd4fff0ff73829833aae8=
ea3229a31757d61 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_MMAP_LOCK_H
>
>  /* Avoid a dependency loop by declaring here. */
> +struct rcuwait;
>  extern int rcuwait_wake_up(struct rcuwait *w);
>
>  #include <linux/lockdep.h>
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250916-mm-rcuwait-03c5fe95f36d
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>

