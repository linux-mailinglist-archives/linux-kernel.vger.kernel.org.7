Return-Path: <linux-kernel+bounces-817289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450BB58041
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C5A1893242
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F2228852E;
	Mon, 15 Sep 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhwZwxtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCD30E856
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949198; cv=none; b=o8ivtku428Nn7X9gOfSEquuLdNKbPdh2z+s8Li6hDsvxWsb2ZLZ+xcCS9EBcLDfQIHZgxDrjxP78F6b270NLkFvD68ltZsqN/iUCEkjK/FpAJI9cEbar0cpwZu57Y69ScKivqY1UgJAw5zuPNIGCyRgtjykDBK1ZeimJmfszIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949198; c=relaxed/simple;
	bh=4tqspy+zxghoH9AEqLBR01JK/+sGxvV8Fm2AfYajFYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwIVXw88tI03Uftwc55FiYIdNUcSx8Vb023G7pKx8CPQwhIHNiCcLh+cwh83beohDYv1gx8saeB48phjIn7GMLkU7yiC3KQW0bCKGQZKW0PWvFJQ/WxjFgGi7z2qMLvibPQJThXCIVoSV5OL10iZJAhfNrRrahpsDUlbRWDAHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhwZwxtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28418C4CEFE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757949198;
	bh=4tqspy+zxghoH9AEqLBR01JK/+sGxvV8Fm2AfYajFYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qhwZwxtFG99I4HuOc9/gir08cjNWDb5oWB5n8BfWmHfWXZrzV1vK1SWMQFySAP6s8
	 pMQgsu/XE0yoH6vOiQ0fFdFJQoWAI17kT0etc7lDFCc91ie5QP1UYaMBffcZNkVe6+
	 FGz+ukjaOnXE9q0+QNxmJRt3CVSFk4E4MGJpeYJWeThU/5/0yZj/SEj513qXintgki
	 bCMNszemlohpo0C8SrZBWK08VSkRMLD4N7QjPduKVoMLYBgxdebXEWGFMeYBJaK4fj
	 mYDiqDhAzPlMXpwfF1ydo9RDcidpsFYQbcBVyFOx9hp0CAx7a2l3b9HybiAwgJMm0w
	 zQoz0zDBxf7LQ==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ea3d3ae48fso852252f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXz6pmvXyVzgLBGuc4uwOcBet9KYTkwx1BkI164J7fOhdOI6gsmSMSJrEtek7OojbNfyBWQ7gZtzxuOH6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JMsIrLiRP76F4uwQGTe8h577dlhf1T6Bz2hZpkQwm1m1FikU
	SRTgWgKSi3Si+ZVe9LoCgp37OQot8nMJKUq93HqVlrh68iKeN4cuNvgPBRCNzXwaWzpW+RMNo36
	MOS8AnklAo5eMNUAjn3KlvMBKUiuIp+3NmNa3ltYDhA==
X-Google-Smtp-Source: AGHT+IHqXikrKj3R1unfVF0Oom/4HxX10YUkGmaBfaJ/zLF4kX4I9Q4yKQIYPoL0/4ybR6mCzHug7iWwAVwTcqUPDWw=
X-Received: by 2002:adf:ed4f:0:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-3ebad27a2cdmr1518888f8f.2.1757949196960; Mon, 15 Sep 2025
 08:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-10-ryncsn@gmail.com>
 <0cb2bc82-1957-4efe-8c85-8558743dcf80@linux.alibaba.com> <CAMgjq7Bc6r2=BcAPCeVPcVJ_hP8bXTs_pya2fWg8ZL-vTG9SAg@mail.gmail.com>
In-Reply-To: <CAMgjq7Bc6r2=BcAPCeVPcVJ_hP8bXTs_pya2fWg8ZL-vTG9SAg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Sep 2025 08:13:05 -0700
X-Gmail-Original-Message-ID: <CACePvbVLg_zL+m-w-qd=eAjbEBN+m2nx03SACudMKL1tWTrA6g@mail.gmail.com>
X-Gm-Features: AS18NWBRjhDOA6SChxr0CoCQ6NbdGNNklsW3v3PUACmNf72TDbUOcGxjudg9H_8
Message-ID: <CACePvbVLg_zL+m-w-qd=eAjbEBN+m2nx03SACudMKL1tWTrA6g@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
To: Kairui Song <ryncsn@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 5:37=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> >
> > Again, there are still some issues with the patch split. The swapcache
> > related APIs replacement should be placed in Patch 8, otherwise there
> > will be buidling errors after applying Patch 8.
> >
> > With this issue fixed:
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >
>
> Hi Baolin
>
> Yeah you are right, I need to move these few changes to patch 8.
>
> BTW I also found that the WARN_ON and irq unlock needs following fix,
> the stats update need to be done with irq disabled:

I will skip this patch and wait for your new fixed patch then.

Chris

