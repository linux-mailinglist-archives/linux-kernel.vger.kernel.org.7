Return-Path: <linux-kernel+bounces-759588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF0DB1DFBA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE1C1AA3C93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0F227B83;
	Thu,  7 Aug 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5UXwq3y"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185A1F8ACA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608067; cv=none; b=KRmus/ADRALoN5aQgSonrj8DzJ2vrGn0gEUZGjaDvwZSF9VA7Rpodi02CjoZspSNRTJ6Nil3V5xA4EU3nw4QWssmqE7cOn5xj2hCnYiShy6imUMWe6HlKBItfkB4hYY8wUkH70XsncnNSgElicXMPSCG/O4DXNi9YczVX02gDWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608067; c=relaxed/simple;
	bh=cEUgAk5LDJci0LnHCq+fl+d2Jx9r3miuWEbzNP5qRrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jbr4YRJIOU/8jft7J4dy3U0L1tPEBa4X0d+NuWF/SfTFvTIB7X/m28PkbZQreIPTv3yQQzldT+kALO6wZ8bb+ZmhH7/HTiCCmNxr6ckAio6YOIQGJHE4vOamagIoQce+fxM+FMChDznUYZoZkyreSs0o0Vzllj/aq2GkONlT5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5UXwq3y; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86a052d7897so104624139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754608065; x=1755212865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhNQ9xJy5xn+DPyyr9WXvCSNgNgK8FMbQ6lL+dFO4IE=;
        b=S5UXwq3ye18SMFUsCKcYjMJFPjp2RjpGRMaCY7ADJXwIYVti8t6Wdk+hBjlFeimJDB
         stOVSCZ7ZM3vclpjtm2BFeW00uOzOW0lftL2rN0bTRsaVGWsb/15lHFYTQdkwSnOeZaA
         883OKJgCARGFYSojq8SUh/TUC6RXq41SH88KmF50lV+mRcwqnCYAeJN/Qm22l8PTjCsu
         wzH9mdTVae9wZtQRbvSFYMuypvB/bvqrlewVpsTlrE0pwjPgkClIgbJaHp8484g9buOT
         OdrW/XYBryuB6WZEwkXjhcL6vKQxIBoggKImhS0Jii9yQ5YYa9HZTgVPYpoKamNsBAGN
         6x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754608065; x=1755212865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhNQ9xJy5xn+DPyyr9WXvCSNgNgK8FMbQ6lL+dFO4IE=;
        b=EBemSspr2In+xNjXHfhKPOaPG2nNGDndVPUUQ63Yi0APQrQVL4/UCVx2b1QWujQWKb
         lHqXxK2NzOxDN1ke62lQs1NqOxKrRyUwNJt/62SR+x/D0b9ZeoA3ulgVTnn44fFEf/P+
         0jRSHU7sZC6ZQb56FnlmtqSFGjhgKKotrPqXWe0kg5L4191vKndREfy9QEdpOIyl6ZlO
         t6uef3+E4XKYoycznrqeynY5TjJDXGfnW6+cqqu0WuHQ6NGk0BE7fL8szUDEKTZnXrm4
         ezgGbdyJIdFY/3xcjn0as9u5tGHifB1AXKD9+3CIZXN1V8p2/hXXHglBIwiYKxsw5/JW
         FjAg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ldAP/zj469TWyMg3idGR6P7dJyzShVvwRrv71rz4phlhQD6hnwP6v86s8z/zTk9H3V7LNhrsqLUfMls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+KeaxQaG/3ii1bxxDokF1OrtFSOMMgH+t+ZKjWjhTr0HyrHc
	sTDjbsNJ8HCqnkxAMr9lIQzRGQUa4+jhJXoyIwHvJVVkVRjAuVpMrFVHSVQZQi5mLaAJoZsf3rK
	BRUa/fQOx/W/n4wHkkDaNbNH1nWr8srI=
X-Gm-Gg: ASbGncuecugSHoHfM7w5dk3CMOijexu/Nn/BjQkQ4EL6im30olShO/ncPG8/bO4D53Y
	bSsJK0NL9zsm4CJKhJzOFEDZkqCP1lsmqgzoHn34xyjgVGMf2U6BmmzrPyZMoQ2TpP/EQ3reeF0
	Hr9uv7+QNKZT8LtoP9RMWbYbnSq3wrQAShp/XsMNbIMQ1D+kFj86H6pKzid1jl+mJRlHTmFD0ZC
	gDpf/k=
X-Google-Smtp-Source: AGHT+IFhT/nELws1H4efWlCkKDQExal3VxPPXLzPIbDMDwCDFzWdcQqpkx7AXapd2/WvXY6jfknx8nFn9aWyZghwTtg=
X-Received: by 2002:a05:6e02:1d8c:b0:3e2:a7a1:8cd8 with SMTP id
 e9e14a558f8ab-3e5330b5f84mr18805355ab.5.1754608064682; Thu, 07 Aug 2025
 16:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807181616.1895-1-sj@kernel.org> <CAKEwX=Nm08xZVR0Zk2fOvXBmeWe5wggvTXN6+hD84S7T9L=eBQ@mail.gmail.com>
In-Reply-To: <CAKEwX=Nm08xZVR0Zk2fOvXBmeWe5wggvTXN6+hD84S7T9L=eBQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 7 Aug 2025 16:07:33 -0700
X-Gm-Features: Ac12FXw6bzCKUP-u_ImjsD4KRhwoSPp6872c06myHjLQv0GtAFsnmys31paNWdA
Message-ID: <CAKEwX=NVBVSFrUcJ8ReN9UqhsN+rr4yMqp1Nu-7rnWK_m+Lt1A@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
>
> if (dlen =3D=3D PAGE_SIZE)
>     kunmap(dst);

should be kunmap_local - apparently it's a thing :)

