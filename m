Return-Path: <linux-kernel+bounces-726302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C3B00B54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD917AACC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629582EF2BE;
	Thu, 10 Jul 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPB42v4G"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C52F4317
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172008; cv=none; b=mUGethxbnXRc4d09ThJH3ajsa5WkPlc/qOIJsa1IexVt8HP69xoKBSRK905jpXS9w/gjaYv4gWqttzvxOsarOPon9RDr99F0k4kdFKnnne6/UYTzxKjrH/kBaG6DwVSHM8n54/xyOFJ+GTEUvWws20rWkFjQfm9miw8VSbXaudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172008; c=relaxed/simple;
	bh=CO5Opoa/OmSz3i+hnCKFjmnvtISOpAfSUDXaxlY/TL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRSVylZ3JiFv1ouIQhMzNsYv3w1SsoVIVbx6xuv4Q3ZdTzds+cxEc7BgXV8xfkqAQx9AgVVorzFejhBy+3RQff+OeV2NSrx6sfuMAyngChYmmXBq9nLz2MZEK/7r7D9iOqmaeOJ9Oq7i1BmdgcUU4yQJW8aP2qVcz39l8oCSy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPB42v4G; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237f18108d2so29535ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752172006; x=1752776806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLWdG5QIg2mai05rpIRhikJd5Q+5BEB1qd+ciSsX0UM=;
        b=DPB42v4G/IkPbm/RBSbPSHy9muNwCHEq+rU0kjERl62A86e34meAqQtP6kty3RVgPi
         KYgm5VKyiA/KUT1FKQ+nUjX2KtypHJcr2xctMfQjKuzSrht4n9rWf8DS4sUHjSqs4RNs
         p+i2wsxwmEzt9kwZsr7lqNzSx2EdSz8fZtKq1CThJx3q+UjyN/WHIEY4wlmqiCk23kZX
         78rAfUyZtHkuj9hB7OHhPf+mFS6CAiGvqJBBFLLYWULFBO3mkALoTtqtUIJe6WL3fDi9
         OBx7TZhUUcXNkJ15ywmqGsLqWegEYTzQZaZDobic8QUryFRfiprCqMSNBJTUQrTErj5C
         Pu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752172006; x=1752776806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLWdG5QIg2mai05rpIRhikJd5Q+5BEB1qd+ciSsX0UM=;
        b=ItZnW4Gnfedd0b1wHwEd40yPdocWtvlAQbC7EjG5vFNwQeS5fevSMvhrJ8IT7KOj+n
         qeJd+LIiDqnYv7c4WSYx/O2atxj/mAViYTLXuXm3efO96CaOQdkwRuve0xzqujx4UU2Y
         aJQu1+6tDTeNqQGelYpkMNJgY0vipmyDSOtdAVr1OEWd2kj2eRb/tE37ViMWqVQO9ROu
         SAs87fJRfo+5Q8ZfcV7FUKNWMwydBDWr4R9gsX+0+A5ilR/BwOjdeRZH1z+uVQsjhVII
         uF4xjI6iKJlsqka0AvEpyw1vHD+ljtxx68DLwHEag/mjArk+K/XQDMXOn7VNxVh+/RHK
         R7ow==
X-Forwarded-Encrypted: i=1; AJvYcCXM21rBCf2wSgzr+gsNjYFJjQb1wfVtNEz9x1oPh94ntSwPKB9WIFm8fXtmV7cV7wreGcZ8SZtsglU6ACs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jvbc/KslTgMwDsLZx/UpOV+hB8ys6Z9Ge9JEfFIibB4cSREd
	SQ8+zYvIyj1OVCX0swHuYVqJGcLvENiAFyS+FcSw/usmUqhu5kxEDcMRrwuShozdEuI8kOPfc7f
	2Cjy0O935sCTNiNIJHrBJZSeVdCd4JLhfdDBzflqj
X-Gm-Gg: ASbGncuBVZV+gx7jD42u0RA8t976DukzDwQI6DEU5XsDDCaL7DhPu+yPqaWKrOcHu5B
	2D1lKJWb8GqVj8AWjblVJKy7qyrWILP6YXFZGsC80abqhHZcZp/jHPR7b3I+jSk2qkpHGPk1K+R
	3Iucc7hEJtnS/FDcbohDIWIKo5wgCbhjO/HnbyDXomyjEO6PQzdHUnzSiP1+fq1GeUnX0l/Y8=
X-Google-Smtp-Source: AGHT+IEUv11GoDA74MpuU9fS3o9a3eqD1q+cu8l2HYgLYe6uliXPSQxP8a4sDFv/oCh0jr80Pb8TBrI9QM4N3Linmw0=
X-Received: by 2002:a17:903:1ac5:b0:234:a44e:fee8 with SMTP id
 d9443c01a7336-23dee52851emr122665ad.27.1752172006199; Thu, 10 Jul 2025
 11:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-6-byungchul@sk.com>
In-Reply-To: <20250710082807.27402-6-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Jul 2025 11:26:33 -0700
X-Gm-Features: Ac12FXwW7H3G-qeQbel8Nw9wnsgeAnPp62bnkpSCDdADm7fjJ0ddRC2LvQnTlMY
Message-ID: <CAHS8izMCwPOXD02xLe6baM0-m3eq2Y7QGsnj7xht-1sgXLCovg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/8] netmem: introduce a netmem API, virt_to_head_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To eliminate the use of struct page in page pool, the page pool code
> should use netmem descriptor and APIs instead.
>
> As part of the work, introduce a netmem API to convert a virtual address
> to a head netmem allowing the code to use it rather than the existing
> API, virt_to_head_page() for struct page.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/net/netmem.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 283b4a997fbc..b92c7f15166a 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -372,6 +372,13 @@ static inline bool page_pool_page_is_pp(struct page =
*page)
>  }
>  #endif
>
> +static inline netmem_ref virt_to_head_netmem(const void *x)
> +{
> +       netmem_ref netmem =3D virt_to_netmem(x);
> +
> +       return netmem_compound_head(netmem);
> +}
> +

Squash with the first user of this helper please.


--=20
Thanks,
Mina

