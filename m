Return-Path: <linux-kernel+bounces-814550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B3B5556A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0706A17ED98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1330E83D;
	Fri, 12 Sep 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hiy7PndW"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152017BA1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757697483; cv=none; b=uGOIxXX7VnqdoJJwW7H6XjwyfKu6JD9R+4zZWmXTlIM3ncbWkf5sa+8LqMXk8K4vsAYc6XYC724u5JFXHggX+ysiH2/xzOZwnB+HXcsPr6aJGVK8Lkg/K17AIr4tWvg0rcAVamjnwDUIez4U2VUMTWeT5IYlcq10Ca2aOeFSJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757697483; c=relaxed/simple;
	bh=IxoycGrKzRGs9/QL6SDPzKjKtaL7MvzqWWqVeetLLl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdBtcvXFqVJnkIQ465cdSaAObRtvAg/UqILHsJCk+DQfMVKdIezz6awbuWx3oREBY/eqfobQqjVoagngHed/R1x3q3LUXo1ILjPvw8hsQBLxrc7mBahTIUKLGP7KQlT6K9uYLOQy7XBH7aFWxLHcYT1M69J3Ol4TGImn+ppMBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hiy7PndW; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432e27c77so59653139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757697481; x=1758302281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxoycGrKzRGs9/QL6SDPzKjKtaL7MvzqWWqVeetLLl4=;
        b=Hiy7PndWsdwqy9pQOcdxv20J1zT6v+p73l7I78pWtj5HC/AbQDR/U3m4JWT/P0tdAm
         bQube1r249FF+6rETHutmy5AXk3xfeE/gGeRpCy/k+IMHh+kiQLDxmGA6kRA0ogEo97K
         Slgj6GxY07wGbW9RsE/b2BZamG2W7erM521ohyjMo5BHysh6ggXKx14UC0kpXCPtF/wG
         d6vIbqFVS0onLn3OBKmdP0trx2ZMLpjrpRpPO01Ip2ZNDR2+JUIhwpbh9SpEo9BwvyGX
         +ArznBCry9Y6zSWRL/aCJ0tHjoMgY6YEOP3zxUtrKzozODZE2xXLgFmZXT5HUlMMHOfu
         3eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757697481; x=1758302281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxoycGrKzRGs9/QL6SDPzKjKtaL7MvzqWWqVeetLLl4=;
        b=MAAINPJZMoKuXKqUoDRuL/Zs3DfzFTNyKP6IQXzruqXveVkT6QeuYQ2KfGZdvGnx0T
         thlvCiqQoQ0W7m0ab7a8ZInklv1caHVrfFvN3s/58bMHZ/apPG3Oe/KPqjZ/5bFQ7ZOU
         QqrWBdUOQm1By0lAs3lskldwGPy+q2ORauZeUW710uXQRXPLtDG767f2nJYLtyTEEkUK
         i+D8VJLR1sSrXWWdu1iQdJTcMBar1gPvaoCy66no4HOn9HM6khIg4XG5te56GdHHBktk
         yKTbeQKkuA+siGOB4cAZdxduo/xHFVBB4mqPtTbp75E+tOybPK8C54eQA1JYn5y7Pgb6
         owAA==
X-Forwarded-Encrypted: i=1; AJvYcCUGYf6Afxc5fRTtFDULqxtKUAujnWFPr+c91xLwtQJwuSt9BwxyxJAbse0+3uZ6yF6CjFmuLWbSH68acRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuAdMBa8Inj/J7T55oK+C/mbKF9OF9ARJCixdvwXWnuZy3PvD8
	Gi4xIHF/RIovrRNEm5GIjAErXZ3l1z32S7vsxHW9+C8+5FhWYRC4Anerkf6Y4DB9IiU21ZvlmP9
	Yj9NxVnGsYARMt1b2rQrkkjDnbk1K220=
X-Gm-Gg: ASbGncuzJB7S0yxrc/QyUqiHglWiDE9PMyb8wO32zuZaKaQL7mXL5UNkZcbtJ6d6YGi
	novMH9ajy3/13RotjjXbCdw/TmyDWdugi9HdYnUIIyqIIvrEmohlGITp1btmRsGH0Qb8sswdABP
	q9z7lAkbrCbUJbz6Fbb0wg9BnA0Ky0nLICHiTyi1NK4PZFHR1MvvXLlsy2iTJ+8AOWhk/EXlOC0
	G7+
X-Google-Smtp-Source: AGHT+IFK4H9XVovn1wGPxMxrsCcscg/iGtnWP/hW3g0mJvdEjcm1UPwPXUqTSTnpIYzkUqSiE2LIg5N65OMJpLS41cg=
X-Received: by 2002:a05:6e02:188d:b0:3eb:5862:7cef with SMTP id
 e9e14a558f8ab-420a4173bb3mr46512855ab.22.1757697480494; Fri, 12 Sep 2025
 10:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-5-ryncsn@gmail.com>
In-Reply-To: <20250910160833.3464-5-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 12 Sep 2025 10:17:48 -0700
X-Gm-Features: Ac12FXxE3rEVvClbzQKrM7cmqGE6Iqd2PgJQy7xb8lu-dQtSlZcYF-4hgXQEdFk
Message-ID: <CAKEwX=ONB=z3h5VdgoyXj=2PZ1Qpzi9zVzGioGstepHie7i+_A@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] mm, swap: check page poison flag after locking it
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 9:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Instead of checking the poison flag only in the fast swap cache lookup
> path, always check the poison flags after locking a swap cache folio.
>
> There are two reasons to do so.
>
> The folio is unstable and could be removed from the swap cache anytime,
> so it's totally possible that the folio is no longer the backing folio
> of a swap entry, and could be an irrelevant poisoned folio. We might
> mistakenly kill a faulting process.
>
> And it's totally possible or even common for the slow swap in path
> (swapin_readahead) to bring in a cached folio. The cache folio could be
> poisoned, too. Only checking the poison flag in the fast path will miss
> such folios.
>
> The race window is tiny, so it's very unlikely to happen, though.
> While at it, also add a unlikely prefix.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

