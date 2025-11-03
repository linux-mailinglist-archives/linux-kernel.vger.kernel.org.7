Return-Path: <linux-kernel+bounces-882540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D42C2AB0B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42113B39EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4842E6CC0;
	Mon,  3 Nov 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTq+Ujc8"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3A2E6CD3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161040; cv=none; b=RdB2BI+FM5hrT9Gg0NjgFMRlD3btK+Cp9cMLUT9J/wprdy+PAa5ZSOyNStTFJo1bnU2cFK4EuIw9JHYTqPuHJu69CPNZ6wuLcBYCqdY5NO/ZuxxQtihVsuz+juzSN9X9SWmYOWrF+xBlclLSEUQ8peQ0R+C6Rtnabecp4WmMEgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161040; c=relaxed/simple;
	bh=QUiZDJyRgD/8ISelZGs9/tsma9n2NV13edtbnKVKZEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fopk9HwRBA2Vg7Ab3tgiv2u66WfMhD/RhT6bBZZ2o9Rfbsw7u4LRsWONusTdP9Ie6kU6zdbqsF4VizhSpfcyjcODC7/MEBYrVohldXeJB+eOeBtXvxLkLjqndOZGg0S/+BJzVXm2LB67dWXoxmsGoVBLbAWf+MdeZRO+lBpix98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTq+Ujc8; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-89ead335959so417829785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762161038; x=1762765838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUiZDJyRgD/8ISelZGs9/tsma9n2NV13edtbnKVKZEE=;
        b=DTq+Ujc8P1aCvGWVFiDBbxyPBRnyYCt48nncyRZWSLp+yvHHMOnG0vStOTaYo4klAU
         Lh969l1lN9DLkiMK5HvHCxqkqJ9kqrdkCULBaFOViEEvuyiB1o68iRNE9qpdTI7PmzZ0
         m9xmjXzkVGjzMKaXU0JgBPCvL+PSajMxhX4gfiWuTl/mBn87GVkQFl7+a+BMzuzgAd0H
         NAXGcuqicXLyRQyrmQU2c3q2zLknG/chiiFD2bWp4fjmKriJ0zwAj5Nl36z03dQi08jm
         R7WslNF+oKUXSglTzPpsSQNMU8A2gXoAS0Zofotn8p9p18wRKywyKIYWoskCaPokmBSK
         Hfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161038; x=1762765838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUiZDJyRgD/8ISelZGs9/tsma9n2NV13edtbnKVKZEE=;
        b=LZ8rA6eL/OjnJSJAgSpNV0AQfqgJWyXWVD04BaqFtlyYPejiBInWQ/RF9YSEWM0B9b
         uOdojOyRb3pyFVeqEsZcKDjoPed3kg3Ksz/1VYVD8CxO6+AzHEBl2ebqUBZxHdEUWfBR
         qGzeWxI9N/mKTlunaikDJMs0oxsReLTMCi8ANPFJIJ0pkKO3u0mox/Tp9xhHE6BedhHX
         3KiQdRAf32gtYaDXjJrwaPnwaBdhHIICEr/ZI6Htrjl+VEv2KUUuqsL3TAQnhNApqD3F
         /o+EXIVi8fQJS21AXa7ME6yRAr0r08emQcI58dyp3gOxKyI+ADBi5eLcSkMouuMloHV1
         eMdw==
X-Forwarded-Encrypted: i=1; AJvYcCV+J9bP96vRn/Ymv7l8d8rAFIEUypbQpSiecWVY2S5HnmYudNVtYLDm6mH7wnsSGyD4dRDIAQAiKy0zSkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+84nKQKzk3f82U6DlVHpYJC+Fni+GGvMuDVk5WRxhCDzQVBW
	iDp3s5io7uFuZh7+ePDmGa0keDgCKJcqCpN5nQ3GqPT+ZbWy5PDpig3fq6z0vvFgEFBuC8w3hrP
	/bVgdJ92XYriUp26jeReCCjeZoYdb3R0=
X-Gm-Gg: ASbGnctZiYN287DqGPvvEw4+Y8snvmwDj7T9KeNVkNX3JMF5i0VJ9dO89EOUQP1w4cH
	u7I6jVeu9hOq58qTfSHjtqGisEg53u0v7Z5DChIhxv2gywoVgw9x6ng/SM5pFPpQHgi4Cv5u+C5
	JKjZpcCNYatrI6hlyHr65qO7Vhg25NHRgj2bSZMc/2AZnoj6TUh4J50u2o0PrHqTRVn5/sGcfuK
	//5QCuCL1kxeBUEwcttbZI2EWEYwK0Rxh8FA0a5SpvJIwagitanHhT7kmjkqYRK+UDxVnW93Rw9
	Ba4HfWN5FQrlU40Xa7wPFU9++jU=
X-Google-Smtp-Source: AGHT+IExkPs8nlbN6h2EtytDA/E26wg/SoLzvVARgJNEMejaCO7Oe83L2OTAOQHjef9AwC5pLrkqUQzXxOhklPtd2tQ=
X-Received: by 2002:a05:620a:4087:b0:8a9:eb9d:512b with SMTP id
 af79cd13be357-8ab988eda3fmr1352526985a.6.1762161037654; Mon, 03 Nov 2025
 01:10:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-1-3d43f3b6ec32@tencent.com> <ufy26fqfvaxqjywneec3hcuky7ozpa2fm63pxcuuberrvicffv@bkblomeix35w>
 <CAGsJ_4x1P0ypm70De7qDcDxqvY93GEPW6X2sBS_xfSUem5_S2w@mail.gmail.com> <CAMgjq7A+OBoH71qo=Vt65BeV7M9uOvkJ+9pQX2eq4-tqcKwVwg@mail.gmail.com>
In-Reply-To: <CAMgjq7A+OBoH71qo=Vt65BeV7M9uOvkJ+9pQX2eq4-tqcKwVwg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 3 Nov 2025 17:10:26 +0800
X-Gm-Features: AWmQ_bkqWGIOm_V1HEduqJo4E0AkHgk0dtjri9662bFQ_YbNVTPpmfTPLZFhKNE
Message-ID: <CAGsJ_4zryZ-FqxZDo8k6VLx4-ijPdjk4i+txVzP41ZS_koNBgQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] mm/swap: rename __read_swap_cache_async to swap_cache_alloc_folio
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > I assume you mean avoiding any mention of swap-out? As for swap-out, we=
=E2=80=99re
> > swapping a folio out from the LRU =E2=80=94 we=E2=80=99re not allocatin=
g a new folio.
> >
> > BTW, this sentence also feels a bit odd to me. I=E2=80=99d prefer remov=
ing
> > =E2=80=9Cswap out=E2=80=9D from
> > =E2=80=9Cdoing IO (swap in or swap out)=E2=80=9D.
>
> How about "doing IO (e.g. swap in or zswap writeback)"? Swap-in is a
> very common user, and zswap writeback can be mentioned explicitly.

Yes, that seems much better. Though Yosry seems to view zswap_writeback as =
a
swap-in from zswap followed by a swap-out to the device, I kind of
agree with him :-)

Mentioning the special case separately seems to be the clearest approach.

Thanks
Barry

