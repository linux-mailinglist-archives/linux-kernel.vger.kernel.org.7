Return-Path: <linux-kernel+bounces-788408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265DB383F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C8C6860E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6D1DC1AB;
	Wed, 27 Aug 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idgQI+tl"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD03610D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302377; cv=none; b=sd3uCthUhxeQbwWG7dxfPiTP2gWr9p1yXbir40/VGfmq8XnisP7s+ftY2TUBViXTTJiinDkIolPwJ7h22x/suenEG9E2yG8//lrTdAn5ywV2ge370Na3DJA3efI4/r5IZfFssuTw5jOoF5CpefZC232tC5C90+G45VDBjphTCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302377; c=relaxed/simple;
	bh=yewKANwH1TqaBLAJVvNSpKx18UApxeSjqQuNlX5OpqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/IKH3+F3+fJ/eN7Pq1oByWhB/Admr7bj3GO+rjC8LqL6+vND4InWJpT62ZqzoonsIHOuVAhubgjbSni57QCjXAajysxiyobPjcyUKSyMb0p1n+t5MzoIhc1nZmh+vMRDnD1Q+oLtn7sCqHa/lSG6C6mgTU76KrcZuhyRVZuccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idgQI+tl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f53efe803so1233995e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302374; x=1756907174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFRDMAfXrpTt084bQ+g9mSlAgJeODKNC5KadgSAUjYA=;
        b=idgQI+tllusGXiJEa6DwrFtsJmRZzG4ovmNA1F9sCD6ntLThLwjqJquDRAT0z976vb
         eAOmpEJqmB4CHpoADhSCj4BvIr9I/ekJe43MKe+H6WgUPqdJIhqSLTP86u5AzcckIIxK
         br2jOvoXTRiYbe1KnBAPS2/0K0k3x23W3Oao9j+7yf9RJe758cTIFFoldygr0DFteG8Y
         fsMZpuxr6IOvjmTM/Cw8yNFPGOXAYUJa1+lgXfqzZQKh2dsnaA0wVzDCUgKInFzfj+JA
         hTYTGR3Qe2g2UbqJ5ZJeJJOZUZCyFTIXzRtNejdZVJB+uVnMAXFy5qMsPVRGDjEWkZUM
         5b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302374; x=1756907174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFRDMAfXrpTt084bQ+g9mSlAgJeODKNC5KadgSAUjYA=;
        b=RErNP/k0KX92zS8HIGvyxyLQETihzO9L2/mI+9YvqnJXuTPS4naP3hITjjfDSyza8W
         iL0LK3LFdwgzTynRIzJKISnWIKl3MSe7ILJsVCL2sQ87C81ILE402Y/Wj6COEDwgrLhp
         y4Nc1O6ScWzxGAxlcSb/uzlT69mtFZ6wPJI4uwPYvCu+DvKAXPdVTPmQ/T0N05JzNxMb
         s1VxBUBHUpmGw5KPQOJseh24h7uuBRpkv9JHlb9wIfcihBB9JJ+oAF44ox8yctNi3LRi
         7oB9rQ4SbStYHedFQVzdqU2sJ8Ie1iSOiaKmdk6BPQ7X55xNyceeXVH9XGWNUVnrjxe2
         8ovw==
X-Forwarded-Encrypted: i=1; AJvYcCU1jLY/++M2lmS68T8wg8FMZ1DoOdO/niuetjUm1BMJdECPLk++E3U/8QF/GxDV5+2fEV328whdGUZp4Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTchC3c+7pHAem/N6mNSQQz5tdOEu4GcI5ipAqT+rWdUYS4AMj
	pAoZ6xFKeYy3NW90gMm8qdd+iStqSV9FhR30oWNJvM0ZK734s9Ot7To2mpjfXDQsjScFrsJECsa
	Hi0dDnYlTHXP+sUYi76qTOUNHm5pX1GQ=
X-Gm-Gg: ASbGncvaZ0bAj/wsRZS2PfU+GnQJqy/Yh8+Ku/qxjB5gacAcXRotMlCNMQuTU8NuKI6
	KbqByCqp9UPpAuJGzje4DC8JJb65e2x3l/08pwG6ldWRqA94NCE2BMmXyBI3X6sM7+yNHQh0RfO
	zIqEGtjAv1LYOdMcb9pXE57CWLP/hJR26ka7b+7GquqKgzTAVqnXHUEKj7FfUCmZT53bN4d9G/2
	BidzyE=
X-Google-Smtp-Source: AGHT+IEYHuR6gfJdiLBGSpeEswdu20gBKOMU0JDLMv1I7vqQePEP9QabRFd8h22nJHdGG91tT1kqE5UM8Ml1p9wi64w=
X-Received: by 2002:a05:6512:10c9:b0:55f:4255:36e6 with SMTP id
 2adb3069b0e04-55f425539d7mr4441999e87.38.1756302373904; Wed, 27 Aug 2025
 06:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <CACePvbW_tkBAhj6-kQzyU2Jh-1dDy63Qc4K3RFyyA4=yt-_D5Q@mail.gmail.com>
In-Reply-To: <CACePvbW_tkBAhj6-kQzyU2Jh-1dDy63Qc4K3RFyyA4=yt-_D5Q@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Aug 2025 21:45:37 +0800
X-Gm-Features: Ac12FXzqIeYmGaBF6gJppSKenyNXvWRYwIEsb0FwO90gJWmXpQVNRCnB-I1egIY
Message-ID: <CAMgjq7BYTmJ6rTod2KMHeVYZxJwQ3w7-pkarrGB+_c3a7wu7GQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:59=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi Kairui,
>
> This commit message can use some improvement, I feel the part I am
> interested in, what changed is buried in a lot of detail.
>
> The background is that swap_cache_get_folio() used to do readahead
> update as well. It has VMA as part of the argument. However, the
> hibernation usage does not map swap entry to VMA. It was forced to
> call filemap_get_entry() on swap cache instead, due to no VMA.
>
> So the TL; DR; of what this patch does:
>
> Split the swap readahead outside of swap_cache_get_folio(), so that
> the hibernation non VMA usage can reuse swap_cache_get_folio()  as
> well. No more  calling filemap_get_entry() on swap cache due to lack
> of VMA.
>
> The code itself looks fine. It has gone through some rounds of
> feedback from me already. We can always update the commit message on
> the next iteration.
>
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks for the review and suggestions. Sounds good to me, I'll update
this commit message accordingly in the next version.

