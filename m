Return-Path: <linux-kernel+bounces-806261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F1B4944E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FFD4426E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE32F3C28;
	Mon,  8 Sep 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr9+jP0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5418872A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346762; cv=none; b=UZSR4N/C6o6C/k2gJTu6NLe+u+LTwY1mzPLNmRFDl4/yzQdxe/69cQm4mbRO8xm2veIjJTho6qps19boKSo5OdZM41eETJj4PgAvLpyz3b0TtH/6KSZ+rjNVzyaLQO5/11E8wnnNuyyqp0HIfHuYIuOtYiMFrsZvmgiKXg5pEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346762; c=relaxed/simple;
	bh=Z6ZSBWyQkeV+NS1WSjTzf1xD/8S+KA+46oz8uElHsjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9SJ0Ct0jYZbUKtGwzysQaaiPI6vNkDta4I84avz8a1y7MBOFgL07SpuMjbeLig3uD+/rm+z1OaXBlqGtv3tTViswP0t+vpVUdZEyMgJHlnTTUwNtzSG56TK10QHXTFex7JomxeaGFd3p1lLPNCq4ansKYBsoFDTF1L4D2NqwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr9+jP0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55C8C116C6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346761;
	bh=Z6ZSBWyQkeV+NS1WSjTzf1xD/8S+KA+46oz8uElHsjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sr9+jP0suanwPGMyItZl9FbFyTsr0mkni1Ik1aZ+ONwRqQFyhdHNwCMxCVdrS8hgs
	 WIsT8tFNIY8uGFRuSPDgUYyrX/FlhPTm4F4jC6kPGGeM8wMhEbxfn7oC9aFk1gA3Bb
	 01/smlvyJUec6fehwtroYKX7jJCyzTncPnE90XvfFNrGw21QgrMxBC11Ow+iOziq/o
	 vEWeUrTvYbFP4T+87NLMjr45V2EvU0kpAqPEJlA2YRUdnpQeewm0V0cFrUOatnDOHd
	 1xpRSUopGdBHamxbiFyfdKZ/YFsXhpPh3Y5vAgAYrWcYjx6Q+UBJf3uauyvLOR+JXH
	 rmuY8waLRzWlA==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-724b9ba77d5so48570047b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:52:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIA53x4I54IDDykwTx41SP72AykO5+eMFqXTPZSd6wc6pL37gk0kinK1l2DS3b3HVEzpmEd3gDnJhbUXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygoSXVsbMjwrVwzTpxmZyLdAsn5IKEv5gyZzTnGYElUym2rvU9
	N/iT9hSbCGzrnSfoo3fuFPca5QFUX/ryo2YkGEADpix71Dlf8uvlNysVzLmVqXhnvnbVu+p/Nfy
	iNOp0lqW2bKj43GjRvcGwY0h4zKdcykHSA4IGmIEkww==
X-Google-Smtp-Source: AGHT+IE+czKcfRqn73StU49ccuZ+KPlPuaehd10MsiijFtK4zhn7X/Pa1jxXn1LmgfTA8Ey3TB9FcE4cxfU/Fscwku8=
X-Received: by 2002:a53:b115:0:b0:5f3:316d:1ced with SMTP id
 956f58d0204a3-610232fec87mr4767627d50.12.1757346761101; Mon, 08 Sep 2025
 08:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-2-ryncsn@gmail.com>
 <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv> <CACePvbXi3Avsic62fMdhLaDfiq4LS_t8-wbm9yQnEkScoxYO-g@mail.gmail.com>
 <aL7xoiTacg0vCLjz@MiWiFi-R3L-srv>
In-Reply-To: <aL7xoiTacg0vCLjz@MiWiFi-R3L-srv>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 8 Sep 2025 08:52:29 -0700
X-Gmail-Original-Message-ID: <CACePvbV1t_mUzKaOa+27hGiK4qn-ARS0jzx5UKWa6GQ9bPxanQ@mail.gmail.com>
X-Gm-Features: Ac12FXxMRmlzF-feQnc7O21Fg-EvAA3SACAP6T4MTNnAZbQbEyXrvO-mPI3sHqc
Message-ID: <CACePvbV1t_mUzKaOa+27hGiK4qn-ARS0jzx5UKWa6GQ9bPxanQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
To: Baoquan He <bhe@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:09=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
> > I think that is all normal and did not violate the kernel rules. When
> > I include Kairui's patch in my swap allocator series. The same thing
> > happened there on Kairui's patch. In the end the git will know enough
> > who is the real author, because those patches are  outputted by git
> > anyway.
>
> Hmm, maybe git doesn't work like that. I applied this patch via git am,
> I got this on my local branch. The 2nd 'From' become part of commit log.
>

In that case, Kairui needs to fix his sendmail config.

Maybe as you suggested, remove his own From: line  in this case. I
don't recall needing such a special git-send-mail config. Maybe
Kairui's smtp server is different.

BTW, I definitely know that Google's smtp server does not work well
with "b4 send --reflect".  Google SMTP is like: "Oh, I see you might
want to CC these people, because you include them in your inner
envelope CC list. let me do a CC for you on the outer envelope as
well". It defeats the purpose of "b4 send --reflect", which is a dry
run. I still recall the horror on my poor colleague's face when I
convinced him to try out "b4 send --reflect", which should be safe,
but the email actually sent out to the full list. I should file a bug
for that.

Chris

> commit 337b3cd6c0ffad355df8851414e8aa5be052f4cb (HEAD -> kasan-v3)
> Author: Kairui Song <kasong@tencent.com>
> Date:   Sat Sep 6 03:13:43 2025 +0800
>
>     docs/mm: add document for swap table
>
>     From: Chris Li <chrisl@kernel.org>
>
>     Swap table is the new swap cache.
>
>     Signed-off-by: Chris Li <chrisl@kernel.org>
>     Signed-off-by: Kairui Song <kasong@tencent.com>
>

