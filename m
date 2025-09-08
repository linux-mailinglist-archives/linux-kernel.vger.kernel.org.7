Return-Path: <linux-kernel+bounces-806052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 791E2B49159
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A291891B23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B930B52F;
	Mon,  8 Sep 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ/vu18G"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BE227EA7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341660; cv=none; b=pc1WAg7fwW7eC1nNltzkJfZiWKcUbUvx5wCs2hZ4sZD6ZAxlDuDjn21EExD9+KPnafnYOpictsdD9Q4UPzlkS5WsNZoS9HZsZfmKwHaD+lqv1TqxjHdttgqbDs6VX7PbNSC2G1ABdAV9tNOHdHgIh+F8Zdyls1xfJtjgZ9NTJpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341660; c=relaxed/simple;
	bh=ndx57/SqJ7BMGZJUHqAwVIM5I7RGZPiL/gdAXPbMwTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spXt3gzYQyCqdOHgmbUq4sGPpPzevs0+QCw+PMCJ837ocVLsL7kAijsyiIdlL2e8U+gPMXMWlPhNepPpoSi5s1JeP2A8tZE36rcsifylGqa3ab3aanemf213SbSwZPBAQKEOt/6cavzYqFGVFZLkte6G3J524Rs/YaHvUueaBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ/vu18G; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so5831793a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757341657; x=1757946457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndx57/SqJ7BMGZJUHqAwVIM5I7RGZPiL/gdAXPbMwTI=;
        b=eZ/vu18Gw3byvVbi7Wuq5pwrBy2Uq5Ibcy3ovX79raY7t3GF0lJ5rSo7R4ctGtKBIq
         4B3w3HQCaEBErIpfZE/z3AcJguQ8zSOJImzKDnzbvPLSgamcM5NziOq7yvAEDufEGZzk
         2fJnvlxfsTcdkfXBY6U9QOTdqMKMc7KbRHpxCHGdsQ7L74tH0NliOdQpP7UaERgqUeVT
         hdMOBIfCZ7X+ghTjqkVteEz1Azlvr7nUN0Pcc7wZQfFGQTuZYPjf5CM7ZSd80XkqFxJ/
         Jt/gAZUMEg/T6O4VKIWSq2ZHE4oXTDy6TljSj7s50F7PqASl1aC2WNzr+tydoiI/ZQ27
         3nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757341657; x=1757946457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndx57/SqJ7BMGZJUHqAwVIM5I7RGZPiL/gdAXPbMwTI=;
        b=DwncH2Cj3XC2+xSaOENPp7hYZdhvVLrG+AWuLkZ11Da1oI0Vi/VOKUnDk6Vh1wUwhq
         /gXJovm1pp9j5L4uIs+GXPNG8NMQIODiMR1XoZoHYF4el/kvy7qfOvNrR7UlYjw1ZgBL
         N8PaFiBSv403RyVV/YjJpaY06W49tsmirtQlW01pyS/yVmqGWhuP8Bzlg7zqamCiMEO5
         i/xIIVwrTLrv4dEDdxShILuEfhcOP6pWeLA7x8u9WprH851LwPiOmc1WD8mQ6AgCQ0cC
         GwHrgw4iCMWI0g0d0JOO1eHV5ag3Wsso1g3PjjFJ+YrBEHG7xKEZw3dXBxIegL7Ak1NG
         mc6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXikCdQHAqGEH7/uuqVIS19KPyYcsUWQI6vwqVtXcJI2ZMbpx3Z8AH+pPug8ak9BcaH+vLFi+6xgBO6jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/flwp9Ddo9bJiMCDCVp4m068bVuRkkHVq9zBqclwMNSx8lVq
	9u9Xhrno4vdnxKUZOZ7I8PNEXpGuK51BkwDjejm0UTLzUhne3QdX4dg/LL94B9KRQdhfnv1gnm1
	ZZjPLAprxOp0rPhp+he3hL+CRQzcHIt8=
X-Gm-Gg: ASbGnctLLNiwmu5kOWxIdl0W4MayZZTNF0rWcn8z9vYSH8gedT1+QpIdIREkhK+nezZ
	BzTsZ/9EIC0kVqyz65SdifcW0vqru1+TixQ4cwTDT2RD+eeWxtyUMvDdwAgkhoqS/gbZLc1RTHU
	P9z7JX3Y0I6tuxNIaZbSOvMV/rCuTioqWQ8jrxj/DfbTTZuvs2vZjJZPGsm0WO809iOF00xGbzy
	1BDa9zWicmT3ogoj6Ww7g==
X-Google-Smtp-Source: AGHT+IE4KQ2gcrVzi5wsR+T8BGbg6waL5kryFRWhnO4Vu3FuU//s60dXIwjdTnklt1NBkltKEcmBJ2Bfp6AyYIj7SnE=
X-Received: by 2002:a17:907:928e:b0:b04:5a68:8686 with SMTP id
 a640c23a62f3a-b04b13cfb3cmr754555566b.4.1757341657171; Mon, 08 Sep 2025
 07:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-2-ryncsn@gmail.com>
 <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
In-Reply-To: <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 22:27:00 +0800
X-Gm-Features: AS18NWBoClT92y9cdL11cKOWWHnIPRdQjWk5sh5wFMFolKeng8Y8CsOHHjMG3m8
Message-ID: <CAMgjq7Bp-buJfH8TPCxBiV80rn=zrvucwHgSCMFuS2BkUWkrJA@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 8:54=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/06/25 at 03:13am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > From: Chris Li <chrisl@kernel.org>
>
> 'From author <authorkernel.org>' can only be one person, and the co-autho=
r
> should be specified by "Co-developed-by:" and "Signed-off-by:"?
>

Hmm, that's interesting, I'm using git send mail with below setup:

[sendemail]
from =3D Kairui Song <ryncsn@gmail.com>
confirm =3D auto
smtpServer =3D smtp.gmail.com
smtpServerPort =3D 587
smtpEncryption =3D tls
smtpUser =3D ryncsn@gmail.com

So it will add a "From:" automatically when I'm using gmail's SMTP but
the patch author doesn't match the sender. It seems git somehow got
confused by this commit, maybe I used some sending parameters wrongly.

The author of the doc really should be Chris.

