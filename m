Return-Path: <linux-kernel+bounces-852934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA9BDA49C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519253A738B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90C2DEA7A;
	Tue, 14 Oct 2025 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T0p9r5jB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEE29A9C8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454613; cv=none; b=jzYwNQxloRiwccYYVahnzE+VC3u8CxBmR/30QbAsxWom8Za6WK7wGQZP1RfEwMMpbziOxH16OvHGscEiBpClkvdCX+XKuHWssDDqQujZSjjFdt/8ubJkBHjkug4twWjUZ4u7Y/8Yzptk+ETyB3KfYY2KnNZwYrywKjw+cOprn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454613; c=relaxed/simple;
	bh=+9sQqZFGj6pjO2HmOLKtnRlFSVSp+ASbakb0jxv6v+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqqwnnSJ16s/048l6eNYpxikZOg+uFO6o79mHYvItOWgoavwoMWRcg2RUneBD72DX7RbcwHrFE1fuBsLMtZgo44spvD9H3qRqA0AMR/2Uu0JyuKhS88yAl0e6O/oAjl92AB3/kDy1nSwsS3znBWjmvomVx1PaEySKO/O+zFn8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T0p9r5jB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e34c691a8so9485085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760454610; x=1761059410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9sQqZFGj6pjO2HmOLKtnRlFSVSp+ASbakb0jxv6v+E=;
        b=T0p9r5jBQg5JXq08Q+XBRrtiI/r2VoweFjuZsy73GRkwFH5Ouzm2qK3t/9bV5A93g5
         XlkljYlPrDtgMk+CwpK+9DXgorSbaA8QE16rIHIz5zrtZCx2etQcCum9T+boiJKrmv4H
         qe4+55uzRQeaFraZP3rP2dC6Q+03bRKBj+Fj0iIe6anEtOItOWi8BBfnee3vQKucUBoD
         jBsLlkMtdHpzDcivNOzVdf+jNkv9xF9gZqemJLWoZ665zYrZoMj7U1PRp7M0nhexeGJD
         8gWL5FYaUjKp0XsrdLu+CC3RRzApd3cZ4iV8FDZHZOf9jx0pGXeGojLFEtCIwvKiYAIV
         yDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454610; x=1761059410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9sQqZFGj6pjO2HmOLKtnRlFSVSp+ASbakb0jxv6v+E=;
        b=l5hklqCrJReUt1MkUyyLrZh3AXb7AX8/SZfWvCUTHikyWHEMNRwJ/Er5DzX+AlkJog
         9UmsgG9SAQWhjeWe3MvzL8DRA8sisKuNZXY0gRJRS7WQvDN6dZl64BKmm89VkYnuindc
         qQGcIw1rY/1b74TRIDhm/fO40Z0MPyFu6aKQQ9ViOZ3Am+4ZUBjHHExGGnwyjRNByak8
         uWhuo4rnrpEsXRo+0d5rqHX4V5G4lwmx2hXWOY/3sF7taoB0zFeUzLdQB5XnXzcu3ebo
         qUXec/HacyNAkUysX0ay8dlypj3Pc7wyzlT7RdLIai4eUaujhNkn4jcBUpbz8U74p4jp
         hJOw==
X-Forwarded-Encrypted: i=1; AJvYcCWkQBg6I/KZoO1Kbx7AgApu1vSTwus9l10aKYYlv+CMOhOCY36JvgcKh4S3LKyIDM1W5kmNt4x9QAFWN3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz29FcbXh2S1l2QUSCEo/bTNC2HtNxkDiY5crHbUro3WJmN4Ik
	IZ3citl2Uo8nUij/S9qo7G3GkJeO2KcwBMqy0BpTWeE0RUb15Cvao1GrSvPIKby95cU=
X-Gm-Gg: ASbGnctJL+SJ7FbSwy+NoJh5yU8uw3gioHWOEo1IChaHF0c0RbDcum6duu+plDvJPU3
	GoDuyQkiuvlcD9IidWZ8OckYVk8PtzGdmRb50kAmpLa4BhWiJBE9Om2xN9SN/QFVlKzu1oN+JUm
	Nwd5V2v5kE9cHioq6LDdiMU+Wv8EMiZLHBcg1OSD7z/jd6db3KnoYZnmJqb9ql6OgjJxjYqjaOw
	YP9RniIzMv4iSeQfl9bFJ2s9R4fCKOp/dD1oshdaZz+J1Xr6ve5SkF/p22+KmCyXyWiK7Jov6h7
	cWgq4DD9l95lhO112ZInqKPG4FzIGdvB1vCju3a1tjrF/Wp30xgG1V31pXPb0E6vIc+KXAhQpCU
	zGlapKEOtxNuXs1FDlXZK4Oc=
X-Google-Smtp-Source: AGHT+IGAXLObLFqWvdrlT8jNvhDt4TeOuL5i0Y/T3RwGkmTWxiheZJLoRR4en+J0WUHha4o/PPCBLQ==
X-Received: by 2002:a05:600c:4e93:b0:45f:2919:5e9c with SMTP id 5b1f17b1804b1-46fa9a8ae60mr100424145e9.2.1760454609668;
        Tue, 14 Oct 2025 08:10:09 -0700 (PDT)
Received: from mordecai.tesarici.cz ([213.235.133.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489194dsm244369755e9.12.2025.10.14.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:10:09 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:10:03 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>, "zhaoyang.huang"
 <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>,
 Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH 2/2] driver: dma-buf: use alloc_pages_bulk_list for
 order-0 allocation
Message-ID: <20251014171003.57bbfd63@mordecai.tesarici.cz>
In-Reply-To: <ecba7133-699c-4f3e-927c-bad5bd4c36a3@amd.com>
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
	<20251014083230.1181072-3-zhaoyang.huang@unisoc.com>
	<87953097-a105-4775-88a5-9b3a676ff139@amd.com>
	<CAGWkznGN7W-txq_G+xpZ6DtH_1DNorYc=CxqUjebo7qfB4Sxsw@mail.gmail.com>
	<ecba7133-699c-4f3e-927c-bad5bd4c36a3@amd.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 15:04:14 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 14.10.25 14:44, Zhaoyang Huang wrote:
> > On Tue, Oct 14, 2025 at 7:59=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote: =20
> >>
> >> On 14.10.25 10:32, zhaoyang.huang wrote: =20
> >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>
> >>> The size of once dma-buf allocation could be dozens MB or much more
> >>> which introduce a loop of allocating several thousands of order-0 pag=
es.
> >>> Furthermore, the concurrent allocation could have dma-buf allocation =
enter
> >>> direct-reclaim during the loop. This commit would like to eliminate t=
he
> >>> above two affections by introducing alloc_pages_bulk_list in dma-buf's
> >>> order-0 allocation. This patch is proved to be conditionally helpful
> >>> in 18MB allocation as decreasing the time from 24604us to 6555us and =
no
> >>> harm when bulk allocation can't be done(fallback to single page
> >>> allocation) =20
> >>
> >> Well that sounds like an absolutely horrible idea.
> >>
> >> See the handling of allocating only from specific order is *exactly* t=
here to avoid the behavior of bulk allocation.
> >>
> >> What you seem to do with this patch here is to add on top of the behav=
ior to avoid allocating large chunks from the buddy the behavior to allocat=
e large chunks from the buddy because that is faster. =20
> > emm, this patch doesn't change order-8 and order-4's allocation
> > behaviour but just to replace the loop of order-0 allocations into
> > once bulk allocation in the fallback way. What is your concern about
> > this? =20
>=20
> As far as I know the bulk allocation favors splitting large pages into sm=
aller ones instead of allocating smaller pages first. That's where the perf=
ormance benefit comes from.
>=20
> But that is exactly what we try to avoid here by allocating only certain =
order of pages.

This is a good question, actually. Yes, bulk alloc will split large
pages if there are insufficient pages on the pcp free list. But is
dma-buf indeed trying to avoid it, or is it merely using an inefficient
API? And does it need the extra speed? Even if it leads to increased
fragmentation?

Petr T

