Return-Path: <linux-kernel+bounces-766923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01CB24CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839AB188E4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2492FE598;
	Wed, 13 Aug 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2Xi6Jk3"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A42FE578
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097081; cv=none; b=og5FoIps09vpOsoKX3yNLEOvJxHanFc4QV7p/KXZ04UAjvCIGrKqObQRSDOdYZcyu/3yhVVhNp7TvMAAS1JFYi8H+UEImCfWwZGCZBWXrQDfo8i9JqMqyKP8Srb7V3jq0XTH67zE9bSsj6cinzHhkNkfo/ofNROa/ObOF+37XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097081; c=relaxed/simple;
	bh=C1C6C68HSvqMhSJKPvSTlY3JwFucLAkfJ49Gr2TvVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvj2RrBHkW3aDU3o/g/dLpXAq+GHdnPkcnDsh6WOq06JgqkN4YJEZ7cWipgGu8KGwlcbfKAot4eCRj4tzquQjEhoPN87a+sKvbyS1awen3BAmP6O2mXkqxdESgOzriDqNuB1M1XjCqgxqMvc907fuGnLkAQvvNMnTdAF1hEq26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2Xi6Jk3; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e52146df5cso69255005ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755097078; x=1755701878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1C6C68HSvqMhSJKPvSTlY3JwFucLAkfJ49Gr2TvVhM=;
        b=O2Xi6Jk3UHU94SS1YSZuwGdR+OFeo8objUJx8ONErCYBFf8jPo9mRoqnk6TsAPuRbr
         tV00Z7pBtIA0E6xleFDWax7azwHEzcKuqpADLfVfCrkOOYVOidQ3rjpjp5tJOlQSyZo2
         Oq40Y69IkijhZF0oqhzlvkoPg91Z/nnZyCVwhOsK5S3orIivjwYIowD9vdNTbshAGwB4
         /BVm922cZLlDB0Uvzjt/skdHpa3veX+qkgTdsxDKSvhLvJ7954ehrimNLkxuhbh+Id3G
         1eMNbRfD8zMlBSjaXYW2askAazqvzRgws8idCUQ+gs0IROT/nH92XesnYBsmlRaJHtn+
         TNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097078; x=1755701878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1C6C68HSvqMhSJKPvSTlY3JwFucLAkfJ49Gr2TvVhM=;
        b=WEa4Ruk2S4n0UZQUtlUtAKrCqpNICXKG6EJZ1hAGQXu6yHkWKuNuSO4ehY19AJBeII
         AM/KXP2Z1l3OlKiaDkhU9GueBJoGpJQw5gKfoYt6/eSKyDu1INNoNaJxXNzY2T9teDqD
         6u1VasEKAXSb/pavPVY9G0OYE8mxCJCT3CSkI+5W1Tc1ggyyXQK2V8NHVBzJxpTcSmwJ
         z317Gs1JL5yuqL+x4l/qMkoQrW8z1SmoMshiE98pE2AkBL3BO7I0eLrDQ5G5Ej8OMiyC
         NII9vyClC/uk72OSor5wJD6UwDpqHw1ZdzV9zC5yyS67rE2nvIyGKGvIZ8POtUc//pWN
         d0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMK19ozxWkZgDaJGjYa4rcWDVjmwpFnz1JIaXjJK3fiYWJZrgfGeXh7nVoTsg94ON+c8PpyOrCLC0WsPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpx6CADFfmOkXFeleBVgogGPFp6wKjJV7SllvUmsqWJ7uiWfW
	F5FqgsNAJBNEu6RAF9+WCX9v0J1fxsTH2XlSFTf8Vt9Yb3dI4I7/vJW2owr/Cv+NFnwokzsfA7a
	V+lfSQa2rOZJIbLWyksR54uHO28A9O9w=
X-Gm-Gg: ASbGnctIHovSJkZB0wvZBcTzxs0RU4KIIMCYZ5Uf2ABXyTq1Ktv4QC/qRwvKWwB2g75
	I52pu1/q2Xne4CnSMsfC01CcbfU6IZ+GMQHtJu2dEIT2YQtJVqW6UTTQHokJ0YwfUkN36GXkM3Q
	0VHMUXU/F5mRbqg+bYebUdV16kuyHGQpWune3MSYJTlGYwrPPfDpsE0X3d+/Ei4Q16xPGT5NR3J
	jWI
X-Google-Smtp-Source: AGHT+IECvEcJAuqVNJem8cC/P9L8/n38xX1d+UqWESMmOlqWmSGR4aIX3qh8ME36Q5WCmNIge5FX7QjVdwbrPlUpz8k=
X-Received: by 2002:a05:6e02:3e8e:b0:3e5:261c:bac0 with SMTP id
 e9e14a558f8ab-3e5674de9f9mr44704905ab.22.1755097078469; Wed, 13 Aug 2025
 07:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org> <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 13 Aug 2025 07:57:47 -0700
X-Gm-Features: Ac12FXxiCEZcTx71SB2-7N7mbjmYWUdvD_vXmcG4ydTw8c3TixlbKAnHTrnitkA
Message-ID: <CAKEwX=NLG_MBvwqMuoLwRmD_EBSJoc1w=-u7mj62YpG9BAFbig@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 12:10=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> alloc_swap_scan_list() will scan the whole list or the first cluster.
>
> This reduces the repeat patterns of isolating a cluster then scanning tha=
t
> cluster. As a result, cluster_alloc_swap_entry() is shorter and shallower=
.
>
> No functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>

Code seems more readable now, IMO. Thanks, Chris!

Acked-by: Nhat Pham <nphamcs@gmail.com>

