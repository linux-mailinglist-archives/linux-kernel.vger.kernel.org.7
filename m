Return-Path: <linux-kernel+bounces-788087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D982B37F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911111B26D73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3AB30FC1E;
	Wed, 27 Aug 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C6LQ5/wz"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990022E406
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289629; cv=none; b=dtY6YayHGX9RA7jUF+W9wTyONZ+upKUojLCAjT+jcjfPPnK7EOgWO11IT4C8R9xaFOmXwVIx0rrxfJI+LYqczIEV7g0WU/M2otrcQMyCyiacDd+u1bQL91w9+lzm7Wf2F3kQNqeRaPS7kyg5diUIwWk8G/WaDzcMSnFtJNVibx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289629; c=relaxed/simple;
	bh=xvz3uUjRuvVIHh8nICa0VrN9xloppL7sG2j0TF3CVXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRVCawKn63s6AupevAi8XZ7/pAy7WDPoJHVZ3EZyoZ4YLL1CHOQk8085kC66q59Zoop6FdtmqUF8r5gSQMoj48nobj3m2NYBZLxapOGvluH/OavKOoWwh1x/DzbkSkh8VUMZNtRoAh+NUHjhEulFZWv9AWPtEu/LzSmLsqjZ5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C6LQ5/wz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afec5651966so87269266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756289625; x=1756894425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvz3uUjRuvVIHh8nICa0VrN9xloppL7sG2j0TF3CVXY=;
        b=C6LQ5/wz0rEtMbPVqu6z6TaxHKE/1evzObj73XTYTAr3X4ukiKgTgfE9ay054w3cH5
         srDXonfrzLklykFt+CJm7h7iH1uXsBs82Bkn05dpehUc7KSBRZjv0ewtC5jSEnQO3+X6
         31KxNhTLCRMzxlN2n3II8i6wsvkrf5bcjhoM/U8s5v0e9uvHWzfANhKKrfmfYrxWyhDU
         WeITHBrR2pQuJpWbDAXZqZWRHj64i9jz9MVUtCwY5Mzdy/sH9GLLxznC4eOVpGQ6tqEj
         zREL/ywAKgQnG8NlqMomK5cKZRWymF79QNBzH/0eD6W0XgfpwCDyuUc5RxmJFOkNOHS0
         ddxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289625; x=1756894425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvz3uUjRuvVIHh8nICa0VrN9xloppL7sG2j0TF3CVXY=;
        b=G29f8TuKTxKD/m6m61cDLT7HDKl+R70u7UhkobPRggZ2jO7Gnmk7yFj6I70IdC1xEO
         Yk4bYa/tkLaKl9EbnCirP9Yte3zVAAS0yj5SthwALFBqjNTpOWA1S3pceGkVBKSxFl82
         rQ92Q9F24cz+04iBK1CNQkVH74MYfBRn/yL5N0YXtlmv1s0V6UdVkWHQbee17/hYo4q7
         a6XnZyyo/16wZh42Qe7XuofIVtYrw2KYD6w4tyjlV/D4ZI/q3XqspX+lBcTnhtk1l28q
         Ysl4nNhpUtrtDGIrN3fBdozzA2Lyw8LR6BVyI7+uClfmjBvDsqAWsFwU391KJL1E1gc6
         lqlA==
X-Forwarded-Encrypted: i=1; AJvYcCX9b77Np/wh5flW6QaXFrbA6jRYDS+8kwAsT4k/4WnbaQURkqFmEW9refnePG+5xa/Hk9EQOSbRjw05Bow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBsZ1VE7oAPeoPGM8OrMyjEf6PSaZgcqik3trJO2VfG5YFUEXS
	d1h9ac4VSg5edkL1vQsSJ6eC1Xn3CYhZmxNhUsoJ54Mqj2W/1Z7OvCE79j7tZwoy4u5zLNJ/liy
	96TTqx73XNcj/Uz2sbTvSH5VCAg+KGsJk0gnz02lVlA==
X-Gm-Gg: ASbGnctzJBZQFFhUF2jTPyrKpc7DrnjE1XsRx1SoWA67YBMsFYyb61EiM+q0XbJ4J2t
	OzxDdoshOLgYVuYlXWNNACcJ83vzEArlBE9uG6Fcx/hX9CSTEZ6klY3/mPVQkjPvDoDyFUncQxT
	mlveXYgc6anmLyGJut551kROKopv6Qb0X1FUToKS6dgAw2hfnk0rer+72yROiHGRjvY9CdtLMyP
	SeQ09xtdxNbiAN6pNnzTUqXsDEB/AWEQOM=
X-Google-Smtp-Source: AGHT+IGlilblub0beLftAWMWI936Ykgkb7W6amQCxE7/3U6ErRHHtfFsJXaGAy/lTybsJEEc8106tAh730j5a9SzDJ0=
X-Received: by 2002:a17:907:97ca:b0:ade:7c6:498a with SMTP id
 a640c23a62f3a-afe28f767a7mr1748711666b.10.1756289625193; Wed, 27 Aug 2025
 03:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com> <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com>
In-Reply-To: <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 27 Aug 2025 12:13:34 +0200
X-Gm-Features: Ac12FXyu44OsYHZBPwR3H1LV2YZSl9vQxc7lNHNMlVr67uXAXYPJVZpR4sRqqmo
Message-ID: <CAKPOu+_8_gfko=Sh-YKpbgcMy0aJB=m9yrC5JJKEZm=yeYPOgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return false
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:36=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> Why should it be allowed to pass in garbage (folio =3D=3D NULL) into a
> function that operates on valid folios?

This patch isn't about the function parameter but about the global
variable being NULL.
(Don't mix up with my other patch.)

