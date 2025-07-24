Return-Path: <linux-kernel+bounces-744170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F6EB108F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0016E2B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D62701A3;
	Thu, 24 Jul 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eGOYrX0S"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1326E714
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355904; cv=none; b=Jj3LocYrvLnkoC+EN0VYE4oGt+t8cpYOgENuPOmzJYIcT3VUzrnL4STR+sKn9K3yXFnz3KKGk1iL6MbyalcIBYEunbg0KkHE7MTL5nrHkmPfLUCpy+hmuQS3gUS1K4DkvZuzHKNml9ljXTEgi+sIrvHJo2pO5V3aGVnvCUmldZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355904; c=relaxed/simple;
	bh=iShq7H6hmF7TANSa+lwj9jP6cRrdLcQpkywH5qX5oJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/acJs6v5h6KW4Er8GKaMiVKTiHhQe8LY4xcyo+C6riSeXkkt23He9RnwVV2G8bETV0xcfwlFnVxe/hEJaReAg7qHxwRwg+HOSBxkNDFBgrgV2pGvDeaQ+aA8PQ1Z2I55BwZjLj00gsQ4aHCMgY/O4i6mPoZyqrJpYNS3UEsm/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eGOYrX0S; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e1f3b95449so197791685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753355901; x=1753960701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2R3FJuPQerw9JV0YLYkAB1Zc/65ATLuHrz68/27P6I=;
        b=eGOYrX0SRK4DU6KnUV82Us0v99d67lprYkRILD91CrbaSBSiU7/o8A1KUyhdS/Bqmo
         CRFLvhU2FMNHemhJ0tkobpZ4WQRwehP8pyP1hLv5hrs4WCncUhx+vGnF69b/jfJ1UnW6
         BLnw8vQB51fQ7v6yoOAygM1+y8H5bcQtvDrBIk20zY+qi0nNXDITgfR2H+hlz3QFy77D
         BbC3b/9nKddIwTtT4mM8LfzvSseCEcTgm3LGH/I9x1nIPm67MhTG0gm/9fxfK7HCdCoo
         pl7BmBbNxOAiK05vfaPsiNZpOQRKcSd05cWDSgBNTdelaTD41l8Bj9NcMLLny/wzmXPv
         bcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355901; x=1753960701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2R3FJuPQerw9JV0YLYkAB1Zc/65ATLuHrz68/27P6I=;
        b=qw96t4PvTNodnHGqRAqmztVjM2Be8RCTEV68oI2Pq79G/uacoLGSKa3CDZE5P6Da5w
         uTzabIicbp7gwDe03vmw89//e6YzLAsqFlxlh+aE+WAeOTHfGc8KnMEywjskPCsPuYUV
         aEozdaRdbFYnE+jHAqOuSTN4czgqtccIVG2mlqh76vN63BccWsVnxQjVt63stT9EO2IH
         I8MdXH7/yBVUDVNTPhuf5LiNA4BhpCpB7TVDs0S68Od0uklwseQrJi842KaX4e9hv9hV
         bYDhbxF5RHfUYVRYTBFTAEYsnxWZe1tthjLfzM3ZXphSgYeV/kJom28WDyYHyWV+0DJW
         gfug==
X-Forwarded-Encrypted: i=1; AJvYcCXxtTs0AcA2DutMmYQt0v+pMttvlQdKQFX/8OgOo2DpARVo5QfGpe08F/LLrW9qZqDgfEemY6AIc9JxsNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMpgvubeIBbT9R5LGVnyePTFaVIrUJhZtujZCUkktBJWLHkmp
	WgpLPXHfefEHmx/7C2mB8Wbf81XVEPA+CscPNE/6iiPNDU5xZYMN0QuqXRRHKgLiafsEznAvds9
	vk0Ck2lqKFYeNwJHi0IaFyM5EBiAz5IlGIecopc8v
X-Gm-Gg: ASbGncsd+MV4qJN+3BLOlCDCkJgZ4CKffNftNgwxUuaGGJ9ByYSGd5fw0fhK0EW4/yx
	1SdxxCe4Hp0fWbQrHEMmrxnT8tsN5ki0q4bCZr27lF8F5mVEH0xnstdeC5m8ggqQ5WnheFAFuQR
	lXeuxcD+Yrjn3rTPJUsBA5Yl/1MKkDpjweQUla37sNBYZ5Qu+mzwXQgOUqDKjJnFlazX/3fsaqV
	2Z1EFE0t8DR//O7wRuY4bwMz9dX
X-Google-Smtp-Source: AGHT+IH/FYbXs3VLoIsIYfS1+jo6yd2h8a90b8HNG6mG2vtEIffIUveiMlLYpjWCV4lqRTwOVJa1szrBkBWENt6UwkA=
X-Received: by 2002:a05:620a:1a85:b0:7e1:aeab:41b6 with SMTP id
 af79cd13be357-7e633e3458bmr168524785a.18.1753355901021; Thu, 24 Jul 2025
 04:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724102907.12159-1-hept.hept.hept@gmail.com>
In-Reply-To: <20250724102907.12159-1-hept.hept.hept@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Jul 2025 04:18:09 -0700
X-Gm-Features: Ac12FXwxLxIZEnI41FmNwqSV0Z8Xhe33I7AFADwGe16L7r2GgnMMRVE98aqn6kM
Message-ID: <CANn89i+vzHO3yferPBi1kBmVkRAd1mu9gD0S8tUPdVaDXapkVw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/core: fix wrong return value in __splice_segment
To: Pengtao He <hept.hept.hept@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Eric Biggers <ebiggers@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:29=E2=80=AFAM Pengtao He <hept.hept.hept@gmail.co=
m> wrote:
>
> Return true immediately when the last segment is processed,
> avoid to walking once more in the frags loop.
>
> Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
> ---
> v2->v1:
> Correct the commit message and target tree.
> v1:
> https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmai=
l.com/
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948..cc3339ab829a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3114,6 +3114,9 @@ static bool __splice_segment(struct page *page, uns=
igned int poff,
>                 *len -=3D flen;
>         } while (*len && plen);
>
> +       if (!*len)
> +               return true;
> +
>         return false;
>  }
>

Condition is evaluated twice. What about this instead ?

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948e0eb121792a400a0455884c92e56..23b776cd98796cf8eb4d19868a0=
506423226914d
100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page,
unsigned int poff,
                poff +=3D flen;
                plen -=3D flen;
                *len -=3D flen;
-       } while (*len && plen);
+               if (!*len)
+                       return true;
+       } while (plen);

        return false;
 }

