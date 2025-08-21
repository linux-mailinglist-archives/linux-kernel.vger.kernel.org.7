Return-Path: <linux-kernel+bounces-780642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFBEB3073D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0CB060D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F482FC037;
	Thu, 21 Aug 2025 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LKJqbbeo"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D132FC031
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808333; cv=none; b=hzyF4xNJbS/WhwzkWiQobN8cf7crwrDE25IU8hWeu18nD4yWxZA6DmiDH9kDxUur+uVT+vp04RKoE/Ja5G871vzYyN2bgeUiIbzUZgDIxMbHlxBiauOuSMpmQ0Xp/sOBGQXSM7lIlrpa9RBjhJE450/Edrf0otqEzd/Ke5buqW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808333; c=relaxed/simple;
	bh=oA3XFTq+X9InxrtY53OI1FqTpqPTKR+1uoMqvtlA0+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojlUHQmYc3N2tbonXbvg4jn0kxEWgdMuEaKNasgx5SBnz7ow3hIwZDeMmfWtnZvr90dwBSvoQ1b9pbH3XAdzbnDW6r8wpA5Rr38E1GFSkmQJSCAPrdqu7nseqSJ6fpQOSgy+C9ZLx+ldyeqSlU6hynaG7D5aKTM5P1D3MceAbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LKJqbbeo; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e870316b79so165624885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1755808329; x=1756413129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=LKJqbbeoQtwBrO+xHzJccr+L3B4lARt6CqfoPqb0/DYpLR0YaclQi59ALyvCxxVbmj
         HOeeWFchQrJPSO6+sHF9huiMEiwg4U6QhYqu5tNceWFzgxAlw2xDn+ZPWKClKMQaUf8M
         MG9Av3ju3k+f5iNUuaNAtHn0Olv+vnr9tZbMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808329; x=1756413129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6aeG3+zXNcZH2d1Z1/su6zkQOg7Uc4j3Xw+oqie+iPw=;
        b=AIqeeYFTKJVyux0t8Av9DDH2EncTacjJTS6ubW409oXkLO8qaGvxzazCEbgH+ZSpzl
         Igozy0GYc5kDCAbIFXX+xHZ9R7QhpzDfRJueWJkQc8Fc1z72eaCTINsri1NxHEZZLY6Q
         5K94oLC3oOn7AkB5RD/YJTQ0vZrgfJZr4bYsllnadfnUQU4WQLDx9dJA5aQ4lE8C5Dsj
         Tvncw0FhNzC0OFECEUnSgxP7h/NHm2NASlrkP83uyovD45a7XYIUMkEf2wi3v1nqOXnC
         TopAc6kiCVE9051iTw2Wg2G/UzPZ6fmCU940e+NRLrPg0tZmfdbro+BsMpbNNViNexi1
         MfRg==
X-Gm-Message-State: AOJu0YxKaFih+cTs9HqdUDvLm9rScq+ApPo5582N/4kajCGltPhw6SGr
	qYX+4tdtQvYOwPHcu/CrpdPa8a/rqblK6yoTYuqXTDtm1ITr/mKcSlNvz86LufdjteG32SnNRI2
	lFeRm26HbSw==
X-Gm-Gg: ASbGncs6WCXUjNFX08tfuTNlsOR6+UDrdHb2gjXegu/dQGQKZvf7yurAMOA8icnJ1s/
	Kceg63FUlT8O/vq/sikDRaSiKcLulErsj2XErIDx3mxQnN5ei+fk6lhp8aq0gVN4JPAVoxlSwkq
	uVhhLAayEcsmxGWTbOUNt87kixkuzJUOWNND/5VULxk4u0zS1fMaARoSQC8fwJWGqvArkTFZzEP
	TWeq4vjd4PgImOiLhVESq65BXUPYKKdMITSH7orKheZRMKG1aIOnmGpdDtNXRtFTTzob407CCt4
	k7mUbX31GUtO6D6qdAIQKHjD9pz9gAfXJeSCi7X1vrv5JOd56mpHDwEtDVc9zV8ZRorqgXanuUr
	VJFdYDaaZzCv55WOprNrm+96mvrkKbfebYMxJkmNNMLF7w27N1lynIkktZAt376DNAAjb4xeSBY
	isrJLJ9Z0=
X-Google-Smtp-Source: AGHT+IFbNUg68+MpTqReIcGo0wBVHw/M/i78mQbk7XXsM0b9emP0nMsGylj508GikaK5WS+nVpmauA==
X-Received: by 2002:a05:620a:25c9:b0:7e8:4aad:d304 with SMTP id af79cd13be357-7ea10f538f7mr94967185a.2.1755808328801;
        Thu, 21 Aug 2025 13:32:08 -0700 (PDT)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com. [209.85.219.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ea04047482sm275935785a.14.2025.08.21.13.32.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:32:08 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a9f5d4b38so12505346d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:32:08 -0700 (PDT)
X-Received: by 2002:a05:6122:1ad2:b0:53c:896e:2870 with SMTP id
 71dfb90a1353d-53c8a40b923mr212315e0c.12.1755807884664; Thu, 21 Aug 2025
 13:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-32-david@redhat.com>
In-Reply-To: <20250821200701.1329277-32-david@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Aug 2025 16:24:23 -0400
X-Gmail-Original-Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
X-Gm-Features: Ac12FXxaZhwn04a0gbwY6rjh9UGLxnRlGOG0Jy0WjRbVAG0UxLDqNy0Wydj0GQk
Message-ID: <CAHk-=wjGzyGPgqKDNXM6_2Puf7OJ+DQAXMg5NgtSASN8De1roQ@mail.gmail.com>
Subject: Re: [PATCH RFC 31/35] crypto: remove nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Jackman <jackmanb@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	iommu@lists.linux.dev, io-uring@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com, kvm@vger.kernel.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-arm-kernel@axis.com, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, 
	x86@kernel.org, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 16:08, David Hildenbrand <david@redhat.com> wrote:
>
> -       page = nth_page(page, offset >> PAGE_SHIFT);
> +       page += offset / PAGE_SIZE;

Please keep the " >> PAGE_SHIFT" form.

Is "offset" unsigned? Yes it is, But I had to look at the source code
to make sure, because it wasn't locally obvious from the patch. And
I'd rather we keep a pattern that is "safe", in that it doesn't
generate strange code if the value might be a 's64' (eg loff_t) on
32-bit architectures.

Because doing a 64-bit shift on x86-32 is like three cycles. Doing a
64-bit signed division by a simple constant is something like ten
strange instructions even if the end result is only 32-bit.

And again - not the case *here*, but just a general "let's keep to one
pattern", and the shift pattern is simply the better choice.

             Linus

