Return-Path: <linux-kernel+bounces-817882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69CB58808
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1965808E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F7E2C11CA;
	Mon, 15 Sep 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFPOsyER"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724D2853F9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977759; cv=none; b=HNUBvq6RorHiW8rFJSiLyVn+XUkhsA2/fAr4EaW7TsQAFjqsV5Vq42Ft3hVUBt6FCeJAv+BMmysQ5JB+r6TcBanpUDCyHzdOyOAVtcOt7fWSa0F6tn9GqrFPxt+l1RskqcF3nxmsJ6mXTW3AvC9ZS5y5UY2Y4XdHUpr09aqRLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977759; c=relaxed/simple;
	bh=WLbWhAMesv4kKaa+6wyxIVlE3wCdaMoKHTTeB77fRpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t03e8PUTJDBh05uSvAZHBgd5vW+Oy4j09QTcdLrKs7lbYoFGUPrS4NJhAPWMhI6snh41szGy6iljTupPJLuiwTz7Tt9LGNqW8VufGRFviVXG64ZAHVQ2/XzDTPh5NBmlAXsY+LsfZtse5i/b5bSoWhTTng5fAvIXCfEEchc8p2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFPOsyER; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-423fe622487so28190275ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977757; x=1758582557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLbWhAMesv4kKaa+6wyxIVlE3wCdaMoKHTTeB77fRpw=;
        b=JFPOsyERhBXBP8YOQnFXHR7lkuijAZf1dDiew62xZlOfihUVFjiQA0keoytzH5rcy6
         vTaOxEXQBjR8EfwhjNtbZL1MUWlMYoVgYXmUzw/i/kehN/8R81CaMGhV37hWxiAiAR91
         emx2OkDONX8TYUeLt5mEI6aRmcVfYjvKGcaBkNdG4GSxnzKfNO2SA/fiwwU+LNlLBPz7
         3kEId9CEjgt1JR9q6K4yB/c260tD6436LbDsRQyJG32hyRvX4nCuKMGgx6NcOGnfo1We
         AYwbF65HJj+aJS16gUHMqSKKVqh6hqFJaSuK8Je56yPpZ7HibaEpQQGNroVQ4+Zradig
         9ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977757; x=1758582557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLbWhAMesv4kKaa+6wyxIVlE3wCdaMoKHTTeB77fRpw=;
        b=T44+PsMUE7Itxx6gN9KRPwsGJ56C7BYorK8tfyAEX1X34YwnyhNEzgFu96+Kn8TBe3
         sQM5Y1n+CBweL2eSVc61qeDTNQlVxuqItg4gEnBry3b3kN+B/+j1vOr63W2Gpir6fm92
         F0jpM466U7YBb5TdIBtxK5dbFPlAYF7aVS1zv/7J/frXI0D6xhySheqbe0MaywfLb3ua
         zie5PSUs5b0VVWS4kG5WlxQjJHNSWB9cnVvqBfSclOtTB5BAnxF2TfBpOHYlOF+xZ2Yq
         IoVbfMcvw3PtBHR+L97p1ZkLCM9HL7zVX2BLch6PGBfYLnl//RshJ1eIRwGORM9T8kcu
         I64g==
X-Forwarded-Encrypted: i=1; AJvYcCWImn4JpQLVECBoq+pZ7iy0rk8G1o8hWkN7bgkIg0xfIiJGdDLsK1VC/sbp/A4nAz7Mn1Uc6iSfmFNn3OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKL2kXBPYmuuwXS9z/FrK5M3RaiIxr6lo6G+QuxXDCkIhVdBA5
	Ul1F2jzpxsbFOIM91zgWAa48sOt4ZNAPwFQFw/GAUItC2stuPvs5PENFoKheVPwg0y7JFFioGjR
	Oh5+UkqoQJC+l1i4zh5y8EMWmVEEaaaE=
X-Gm-Gg: ASbGncv20XbmYYxgQkwXVvIg54X96Fa0MwhW/Y/fCTI/yfqA4UFq4dJWgldyYLKIWaw
	/YLsTf9m+sH61nZGkSugMqFS5I3ep+cRAbdW+cFkL5XFsElc4R/bODrcnRNl5tstF+hh5zzpmZp
	xgMt6MhZh/qZ0asMuEvrF46XOp5ByTGIXbEUerR6ZYrKytF2Smu15UyVhuertaSkj78fBgXFU/5
	lZ1FL1XWHwC9G7224PVAV4=
X-Google-Smtp-Source: AGHT+IFp3liNs3Z+nFgrEioDQId/p34S3BC+hmkTnRmQ4IrAAwtvqtnLQxqXEVQVeneOsYmUK/aEj62swSXyCr/2+Hs=
X-Received: by 2002:a05:6e02:19ce:b0:416:75eb:265e with SMTP id
 e9e14a558f8ab-420a4ee1eb0mr152917625ab.23.1757977757566; Mon, 15 Sep 2025
 16:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-6-ryncsn@gmail.com>
In-Reply-To: <20250910160833.3464-6-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 15 Sep 2025 16:09:06 -0700
X-Gm-Features: AS18NWAiTIOL-zvLV53DEWjgUqSxzatSBuQJjKN1Ir0R0nY_PrW4ch_NsTyGp2E
Message-ID: <CAKEwX=M6PpOQvqBK3hqfdVubdLE_hdnFHnsBMkxP3RJRmCZ3iw@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] mm, swap: always lock and check the swap cache
 folio before use
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
> Swap cache lookup only increases the reference count of the returned
> folio. That's not enough to ensure a folio is stable in the swap
> cache, so the folio could be removed from the swap cache at any
> time. The caller should always lock and check the folio before using it.
>
> We have just documented this in kerneldoc, now introduce a helper for swa=
p
> cache folio verification with proper sanity checks.
>
> Also, sanitize a few current users to use this convention and the new
> helper for easier debugging. They were not having observable problems
> yet, only trivial issues like wasted CPU cycles on swapoff or
> reclaiming. They would fail in some other way, but it is still better to
> always follow this convention to make things robust and make later
> commits easier to do.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Apologies for the slow response. Swap code is dense, so it takes me
awhile to read each patch :(

Anyway, this LGTM!

Acked-by: Nhat Pham <nphamcs@gmail.com>

