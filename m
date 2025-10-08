Return-Path: <linux-kernel+bounces-845696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413FBC5E24
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608F74F9E24
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BC2FC029;
	Wed,  8 Oct 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9Ujqrv4"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0942FBDF7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938425; cv=none; b=YdP+S3lRvWBSlnaI4pS0xzodxB8njiFPsyJCbhj6397GfiBwE3XCoqSC5L4V7xx4YvpKOO3LnEt+iFCsIFhyCvmMGmJ1oVfMFNl/TjYlJxU9Mz3rNBVF7K6/qFrbRanlp2kNKWS+7J6HK+n5IFGhYGb+H+ljthZn3xQ4DmuIATI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938425; c=relaxed/simple;
	bh=k8syuwiC9TBuMcRZoPBHu9S4Og/+FuOZrPu9iT+A8Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/XUei0vweiPr7alnjlVSurMeukipAH51ZjeZOIJPua30y9XEEaT6auz67FuI6rocJ1Qp/QuANPwJDi2WdeDR+aUmvSH2WCOpnt+lo4uBemTsdePb+tSlNNqBtBgnpVUGFuBqaVUFCarmcmcmYPW1NgUrJHulE0XV+D0T4plXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9Ujqrv4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42f3acb1744so28265085ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938422; x=1760543222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxsFL0/b1dBODDSo0KlYIamsU6YtxzH589hXt35lu3s=;
        b=c9Ujqrv4Y0PiZkFRboF0FeKzoBh/kR0tO8H1nbJlt3fgifMhjW9FDPGz/S/UTeGdNE
         bTDxRVO4cVjne/Yk8hmS85mwxwr4I/gHQtvhKICNF5W9l2CQkIEOawpM8M4X+POZFwxr
         ml7Xfqe70bXDXyrSfwLBN2c46Sh/w6HYucxUu8kcyPMD38moyb3fK2JWcb+Xmfdfi79g
         UkkUiOYj/p4Ucv81e29dnBZdz+0sYUMR3ZuaOAoHmMh+rVhQ1HkpZWRDwg64bjB/ydRM
         KxZ+4K1qDB/WJJYXnrC0QDSvBYQX6zhzSx8fk0Y/wtnPamMYdUAF/Yir/+keHlAvOplp
         BjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938422; x=1760543222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxsFL0/b1dBODDSo0KlYIamsU6YtxzH589hXt35lu3s=;
        b=Rn/3lKy8sBlf++cIRZZo03OUqizYrB7K9r8rjoqQzk3os6NQ2uGyztHg8uHQlENocF
         m3iM2QyBnkt8dVyKhADYUWUIRr3pG6IpdgcbEnM399ij/QNGQz81ijczy1o4CfPxwRqL
         jzYxYXlk9jHrVLljHPa28Cca7utPozOW28n+2JJ+jL1nsykxtt0kCsJgHdMLMC5bq3Wc
         z4oIwTsWyvsss59N1/Dh/WzoyQVpfvr1NJS+NlBeuVyd/mOpE97jdX5yalrh4pdDqg4b
         w9b1Qc/dWyWel2ZxroLArF1lPJ1LMPdA/jf8fFNGeEeFEji0re9q9JTLS1KAXzptULq1
         /spw==
X-Forwarded-Encrypted: i=1; AJvYcCW3usRuZPfLkFR4zaerfYnizh3FyaofNpN9rXJikrX5DTopAM5dyJotH/0M2yoCyQbzlDLZJowpo7qmNJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TSQEtbTtMY7/JmVFbd2jaFP8jyI+IJ/2GJmNdzU/XSDjbJRT
	vczBaNo7ELK4qyA0ijQ8Yb6e77YtX2cVU7d/Gy5DrEy/HSkGbe5K3gDi6tlGRTyn2iR37eg9Wvr
	gWEVVTv+cOpRZVJ3PJx66kWkb+kTDEbU=
X-Gm-Gg: ASbGncsHa1cbxHd9nHIoJAr9TzHrSgKhdeb/WqR+Hwr2os7gX53HDWnzuMHAqbrlrMv
	6ou3gnrc+oNveXqZcnUHgIhW9Qe2ewXzElCYH6/PvTY3CYxO9XYeXLldEL4R61OVqpvJ+bFHxmd
	5MyRVlX5DqJduR/IQDls4ttWNnrChkFA+f8gXHLPS140SpJAp5wpEJhAZfldMF7Jj5mMYmix1RR
	C5nLZFaawNaPKanTTqqZVXQoaUX
X-Google-Smtp-Source: AGHT+IHb1Dg0MfF3pFxdY7ZFsglgfc5OrAL2Gv7g3bE+aIiwaH7AlIG2STXmJXcSiISZD0UeIXLQCvBdo4xXE1r+ltA=
X-Received: by 2002:a05:6e02:178d:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-42f873fd943mr27365275ab.22.1759938422227; Wed, 08 Oct 2025
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003203851.43128-1-sj@kernel.org> <20251003203851.43128-4-sj@kernel.org>
In-Reply-To: <20251003203851.43128-4-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Oct 2025 08:46:50 -0700
X-Gm-Features: AS18NWBrFZyoKbxvDzZP_ZSGE-EjtBx-9bGfWdZ19UYGb0iBECeC-6jkfKXTjpE
Message-ID: <CAKEwX=N=uvQkF8nL8XVSceE3Y0icF2FuzPuDAUtggfJRJhayLA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/zswap: s/red-black tree/xarray/
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Changes made by commit 796c2c23e14e ("zswap: replace RB tree with
> xarray") is not reflected on a comment.  Update the comment.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Nhat Pham <nphamcs@gmail.com>

