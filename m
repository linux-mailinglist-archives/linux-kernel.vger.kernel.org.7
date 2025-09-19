Return-Path: <linux-kernel+bounces-825258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB88B8B6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136745A4369
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717C22BE7AA;
	Fri, 19 Sep 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlq7bJGo"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96186342
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319361; cv=none; b=OxGIw3nNsgqWW8FZxgffUBhv1MqylgB/hufNMudf7AqkB94CaE80HLGhetW7oK2pmWrpYk7cuy1dCBJKhEruS4VDEz7DlaQMomrxwzQqaavlqEsoYr8sW7hJnNkt80BAkYWrmh2e319h/lS54M6oHB8GOJkWuScfFPRhBBRBqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319361; c=relaxed/simple;
	bh=x5Id5wGB7dpkhFEI940l2CmgD/skMZmYSZKfxQIBh98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmszpnRGp4as17x2Y5WhT1uqtVgORBcnJOpI7lBprUMobb25Ri9KzuWMrAwAdIkdS0hfjju8q3zV0egLDk9EuDz0SRMxd5UOCdkEwxjk4xERiIIVLlQF//omd/6DRfhrs+e7JScRIRJHNMWfnlEesX6XhrErrL/injhuk8GW7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlq7bJGo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4248a13fbe9so3464275ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758319359; x=1758924159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5Id5wGB7dpkhFEI940l2CmgD/skMZmYSZKfxQIBh98=;
        b=Mlq7bJGo09XqzCuWw2tD8j9jxV46ZQ1NNaYV0dP9D0LKpVXNp/SXyuosHqNjUtoEwY
         cdIZK0zJ1RcadhTvzpcJbLqARtnS+Ckm0GiUeUhOn00Xp+rY1PYTydOfEUWFSkgrHfn9
         j5L3qftsoBApD/Ht93mD1mqxZz2a1kKXDaOymIRHp/lMbr49OmBziRypyAG9ZSzQM4lX
         MMhwugFeujWvsBSt4DNaLVBwzlVTL5/+UTNfA6KxVLhANawQbuGs5mQhIKaesC+O+9B4
         dAL2zpPOBePe0MRRqqyRO2PZ+DfxxIf8mhfWNz2q8OcUuQbOUdphotPSiJUjbD1+hra9
         1AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319359; x=1758924159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5Id5wGB7dpkhFEI940l2CmgD/skMZmYSZKfxQIBh98=;
        b=HlOx5fDYE6EA++vuzEK5AaLHIRjbghXkiRyW/9ETaGxQa3d1xfYXdyDQsveLNZTQOl
         3Minhy9kL/qpBwJkk01dVrZdoHq8CbvixciCSNsadi7Mf+BcZKm3qi9BuODOO80cygSO
         rlrsAA4g1EOVN7wZjZj6xxzjDCTAGQQO5nCK6tBzzzWZFtKocH9smgnJltXsdoB7E1S+
         Z69hEkTotxvWp/2+mU5PWntbAGJij44CLeggs8BoPE1CYTGS29hRHvcAjbjmGLIBkGX6
         uO2CqKUcDbjOwpaTCtSNYnd17ZEVCe0u2UNKxan90IzGyiozY7EWsQrKyG9jrjstL1FI
         b5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV+6v5F6uYyD6K0BCGLsTQS5Ok1NfdjTl0zI/t99/Sj83uh4gFJVokW60nvmkZtZqVfmC4aKAXBUlbcivY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6EhwdvfEadjm3sYZhI+gI3wF7x6eas1SUrhrFieGaT0WKkta
	IZnvlufcq4oe9x++ydDKTCTPSMWetTvBUN6cWFpzgfBSZ42SvKCfjz6hwemBZdA1s5IrgzvxGV0
	Qc6fKJDycPk3UIATXUXmbYWGsGemyGUg=
X-Gm-Gg: ASbGncvADcwKGcbo61Iizu4rrly/dPUu5LIr5r1Dg1N+EEFDnrs1J1Q5JJVDZRxnvS3
	fmFKv2oVPp9IvifpgtTi0+8Vp8eBZ/MA2mHQ9cSDtVHxDs+oVD+adSW/kXSVHvpfcUpI1zY3wA2
	cwfJrGJTPQj0Fn65Zr+QWHUO3ieO5zDmhw9650jzVwMlQFKIMWNUk/e6iGPLX/W5vG4UB/WL9dr
	zB8SAoDJJjXVIdIAw==
X-Google-Smtp-Source: AGHT+IFM5GLBoUwaZWoQawNHl1XfRp1pfGc4zEljqu3MNF6RpQambzopKw5XcNw4vl8NYisjSrCRP7nZVEoIyXM443g=
X-Received: by 2002:a05:6e02:2284:b0:3f6:618f:6b2b with SMTP id
 e9e14a558f8ab-424819a5b2emr69998805ab.28.1758319359279; Fri, 19 Sep 2025
 15:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-7-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-7-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 19 Sep 2025 15:02:28 -0700
X-Gm-Features: AS18NWATtLtk3Udf6AWX0hA3ISCJsnaM5uh9xfLOx1-KkSR03NT3XlEQmdbBzJg
Message-ID: <CAKEwX=Nnj63_VsNDtqAWuxQC-GHPQNbhSMbWk9za+PR-dhZkHA@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] mm, swap: rename and move some swap cluster
 definition and helpers
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

On Tue, Sep 16, 2025 at 9:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> No feature change, move cluster related definitions and helpers to
> mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unlock
> helpers, so they can be used outside of swap files. And while at it, add
> kerneldoc.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: Chris Li <chrisl@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Nhat Pham <nphamcs@gmail.com>

