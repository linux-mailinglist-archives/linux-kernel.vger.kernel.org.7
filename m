Return-Path: <linux-kernel+bounces-810686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C83B51DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481BE1C27486
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E34271446;
	Wed, 10 Sep 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIm/Ujgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5025BEE1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522281; cv=none; b=Aq4m4z8Qh/stbEWf7VLBRqF0CsrCQdyENlI7505pFkkQv+fQRvBt/a04RMzaQKKkU4wq+qrzTBOOVi/Dxd0L+b8cndxFCd5KizQkDQVSVTXaYcg80pKc/rwL+ebnrDJzLru1WpRGWp0f7FtE9rXt6LrmHCtaumCnMeecpqKnOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522281; c=relaxed/simple;
	bh=ldXWcdmE13ah6lBxgKqVw4wJH+fE6gBrhvUZKKZw/r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjci8CwZYPxpSRxZNMY8HbI7kOJxYRyHLQSO0Tc3H0I5zslpYdv0OwhDzJYVBeBM+7bV9Y0XxYlqNOqlvY4OsQhDFSAEqMYKFLyfLuzh6N+bXw/DqjdLTARGboQZijqt7k8avz1RbhwZED4bP/CUjFaIcrZdm+xNJQ2Bo7btQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIm/Ujgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76529C4CEFF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757522281;
	bh=ldXWcdmE13ah6lBxgKqVw4wJH+fE6gBrhvUZKKZw/r4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIm/Ujgbf718kx21gbL2DeYQbNbSuzmw0RrnMIzAFC7+nIyV6HXBDDkyi56Pp4YWR
	 TSrinyh/piAyYQCqh2pSE/q/Xz6rYZ0yO5ViM7vVG7pVyVzP0TY4jTUf1N/Pctr1oW
	 0V2elYdB0RTIfb6kF7AxC982txzB3uGmCPcxl6p1Wmd0cZtyQmJNEwIBxe/mIgCjC8
	 SBs6K7PxFs4AmqLCkFhSwiLhtPcnSRRJCtQdGJuG7MCcJHbC6hMdHL01BNBOra0v0r
	 A5H5K6vhIvPUHYnV68FFKNFX20URxA5u3aFuLEZz6bgbihjYb+Vb42jdLCiQjHjYxQ
	 Ds1+cCxSENLeA==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so67065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHI9HU9U8iSWozn4aLZPO/Rt9BhcVl5zsS3QcBADDjwSLMu8XQFszlNTBu09IYl8sAHn+zhHZVwVKsh34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3APzS9GJQ+rk3kiWDndsEdA2RyIbmMxAzFIZ16xs4eGEuR0Bd
	ytmkPLkYOQJKgo1ozhYVnzbAm++9JcD/YIycOCN6jaYNmoaSu4MZ58bmDFlHJMricUMhQItkS5q
	Uj///HuEb0QI6TNACVdJ07Yad+hQiUN22fy/Epn4o
X-Google-Smtp-Source: AGHT+IHIcZSYVf5Ghq8ZCt7fBSe6Jk0JycWud/uY2Ua6Qwb3BTtv2K2VfdajQ80Prrk17CPuEPzgVIj/KEesxMsohO0=
X-Received: by 2002:a05:600c:4614:b0:45b:9a6e:ceaf with SMTP id
 5b1f17b1804b1-45df73f78camr1353545e9.0.1757522280029; Wed, 10 Sep 2025
 09:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-2-ryncsn@gmail.com>
 <CAMgjq7Db_DbZosWrUUAGfObDYA2e34zB=RtUpRZc2u4RJBiSxg@mail.gmail.com>
In-Reply-To: <CAMgjq7Db_DbZosWrUUAGfObDYA2e34zB=RtUpRZc2u4RJBiSxg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 10 Sep 2025 09:37:48 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPd10FosK=CQbrw3ZPF+ckJO7-_1eLKY87_MX8sZ5YYUQ@mail.gmail.com>
X-Gm-Features: AS18NWA9yRquM3BelDzwSg3xc3yiEw69xvVtEIQURHSBoX4G2NvJ0Z9YpOqdPN8
Message-ID: <CAF8kJuPd10FosK=CQbrw3ZPF+ckJO7-_1eLKY87_MX8sZ5YYUQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] docs/mm: add document for swap table
To: Kairui Song <ryncsn@gmail.com>
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

On Wed, Sep 10, 2025 at 9:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Sep 11, 2025 at 12:08=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > From: Chris Li <chrisl@kernel.org>
>
> So sorry about this. I did fix my git config and verified that, but
> sent the email on another machine that still having a broken config :/
>
> Hi Andrew, can you help fix the Author to be Chris here?
>
> BTW I saw the current version in mm-new, the author is already Chris,
> which is correct.

If the mm-new got it right, you have nothing to worry about. I assume
Andrew's tooling already takes care of this common issue.

Chris

