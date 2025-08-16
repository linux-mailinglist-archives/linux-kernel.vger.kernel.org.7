Return-Path: <linux-kernel+bounces-771649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED85B28A0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EF6AE5E15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE81537A7;
	Sat, 16 Aug 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmfAc0Y+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DD8A95E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311003; cv=none; b=dLP80lny4h1OJWju+zLTaWxPsZgUThB+sf3H4E+OEiB0dGMWmGPLGnjN7JQl50Rqa5STguE9WGnhYd693E6Q0HolGftmDl9fs1uOKwnAP1LAzAgqPgBt0XggzkXtJ5AtjapBt6GuWsuQVWiowYgo2Dj4OOuZVcqoHqS2pCW9lwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311003; c=relaxed/simple;
	bh=9nWnSWlyfK1lIcikiEsFL567zZN2chbwv83qacW7LeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgYUGd/KxRtePDIq1OXhqyzWdblj2KTqJCEqIRAJmR44igKd5KfCQe9WIuLqwxgOo95FZiNsyI7uU8H5VY/IVixpojtMOMBXQHeyHGYcI9d+42frwOgm7VrruvOcySc+x1w3khKO9wFKFy9Pvlks/Dd4UZo3v+2wLI2AarkNjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmfAc0Y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A38C4CEF9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 02:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755311002;
	bh=9nWnSWlyfK1lIcikiEsFL567zZN2chbwv83qacW7LeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NmfAc0Y+QMCUz7KdFmIkdgVYxvRFdVm/v0BkztwcY3POTRrQBq5rRfSjKlWMLKIZ7
	 zm8pD0PJ3RF4jYupDMac+j191cthPJJPDFtdKeZgu0C3lrN+E5F8afKF/Fs4JKckRm
	 2QC2rRG5NuqoTQ5ScF09e0KL6ECWcUDnGr93SprjxTx15M+6FLa/aKR0Zz2uqK/8m7
	 iBEwoFSsfWTTyQDZ497n390C0sjH1DVG4O/GnrjOGtw070os6VK+72HrDJw8Gin66i
	 /00jDQRclwlYI/yCt7W0bBFtEFh+y8Cn9z6blUb+XkpG+ViwuGfZvf+GWqWHMafmKq
	 p/SWaoGhzDC7A==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459fc675d11so17375e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:23:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+0WqdYzGw8xobfwLqJWyx0wb/+C8toUx3b36eki9c8Pf5K2sXxL43O60Nu1ze/aT2kG4kFqwur6VWLIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7109OiuFNhfmGwcGgMAIHukPA6TwMait6FLhaaeMKWobRX1v
	SOe4F4WsunI2RsXRtEOxEx93EqRztyubdVqrPyTIs4Hdz/rQUxcplhJD6MoDX3kusSDMP5FM04Y
	QcXCxrn78egxrqPHCEzHayUZLlVdfnAZbgSAwr8Uz
X-Google-Smtp-Source: AGHT+IFGXZTSemj6VU7E9uD/RJcpIkoECmdORfOfRQ3qmLGzAjhfCzIa80d2PEufH8KVTBp0MHuf8ftyJRTdOsasfJM=
X-Received: by 2002:a05:600c:5d6:b0:450:cb25:ead with SMTP id
 5b1f17b1804b1-45a26f11466mr280225e9.7.1755311001612; Fri, 15 Aug 2025
 19:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=Mtu3KyNUv_oWFo9vNiWKkmbzMXmG3t=XgpVtG9C_v2mA@mail.gmail.com>
 <20250816001415.90915-1-sj@kernel.org>
In-Reply-To: <20250816001415.90915-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 19:23:10 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPwfRVHpvNRr=1NT4z_3Pmr-1u4vfRYmkvh_Kh4uNGy9w@mail.gmail.com>
X-Gm-Features: Ac12FXwmB2QVQRyKxq_VZMT607goJfdRhWQV8cWYchU8wxGYBzofcFt8jwVfdNY
Message-ID: <CAF8kJuPwfRVHpvNRr=1NT4z_3Pmr-1u4vfRYmkvh_Kh4uNGy9w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 5:14=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Sounds good.  So in the next version (v4), I will drop compress_fail.  In=
stead,
> I will add two new counters, namely compress_engine_fail and the new atom=
ic
> counter, say, stored_uncompressed_pages.  Please suggest better names or
> correct me if I'm missing some of your points.

Sounds great. As I suggest in my other email, if up to me,

"crypto_compress_fail" and "stored_incompressible_pages"

Thanks!

Chris

