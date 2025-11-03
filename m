Return-Path: <linux-kernel+bounces-882292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322E5C2A12D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48BF3A3D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38B253F11;
	Mon,  3 Nov 2025 05:30:16 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD112153D4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147816; cv=none; b=rtXNyCf69ltqpvFlXy5yywBJ4LA6yuT5rDhajkETNolSxPmZEnFTFLBoOJxT4JHFSRW2tlC7ILhXhsWYmJe24HVopGCp4R3PL4XP1hg4mmpI6XcqjQjI+hYfifEZ5NSXIb6tBSNu5wmUzYhyjVH7ErJ9q3eaCShbVDUwETDVp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147816; c=relaxed/simple;
	bh=h0IjBdFvCe6GDPneRMmh+K7UVDEF3+8TDpaNsFUJXv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isPt+p6BXsDnB9N7834EE+IrrifBE1fqUJTmRFwo8fPUmTTW4MXH7QFjUnkb9nRlZhKCNee2Ai7Y9j2VlmfYA/H2n8UaCGB6Xz9ccgxkoEco4V/Uvj+8u6VVdg/U6ijF5EjgnTlVfoxNMdgD+VYW/fhlMF09orn7wwU4FnJwOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-89f07fee490so553168385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147814; x=1762752614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0IjBdFvCe6GDPneRMmh+K7UVDEF3+8TDpaNsFUJXv8=;
        b=c6sGqclmKx/b5lXdso14IPcgpoZgFC+hVvZTcYT/0o6O4gGwyPNpfs1PKVojFatDhW
         fZ8S1L1VO8gObRIg9R5LtNeyC4kCgsslJ7dlkQPBzZ5QP2ujC5Saf5OvHjresbB3Uuj2
         nvTtUpnv8ach6vHHccWZf0gdZZu+a1Ac/7L1UmVAwvFkKgUOqNf4tHNNfbSQUIHyeEa7
         kGwNufXzvVKvWprmqAzlU/2H95pIZVexpnJJOxOXWdoTilR+EvpRWt0wQa/pkgrc4rse
         Fr0IOnXaB9i3bc/HnSbFcSCJc801vZz/5xtacCqhCiic7Cszi00U+iy9GM/SjY0gZD8R
         SGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/asIcw6v1kAxBFfqnHWYMHW6JHGNgxvkvBCaevxu2id4lhV2z0hnPiC/JZNOW3Z3y72rg65JUfzTeygI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLZF4hRuCUkiKf3Vi+AgUynZI4TnpWPP6mWexLA7g5glZv3SK4
	UEXQE9oZlGSqmwPk5KrXCvts4gKCqUlqGBi8UD0OQcBGvv9/6XYjH/WXrAO9Hp+cBd9lL3tdatq
	LQmCHirF2b7Ee1SIAe4R5DZP9r96ujho=
X-Gm-Gg: ASbGnct1/Z3ci/4Zm7YodUn3/6bEVrgmXFuxozbZGNAi5nwJ7Og4HeWeqG6nZ0FOQMR
	IIV0743oHrbDMmiACFmYxSrx6y4g9c8C7VZdScyMkMf2foKSBulLkNryN7csVZ1vQGGAQvcwKI1
	SA6cQ7omBrX/J/CqZgqk7WTJ/bWDbBSfulbqxw2YYw8Ztgs/CAqX9kx0WcjxhpWon8oe+3Xpjui
	5JtWaAt82PGSSXfSHDqtqBhQHhieT+t0vCKbf/4BlT+mlAe+nvEQ57rO4bNQ3w3EgTZHsb4Ipuq
	e6xHO5aRYzQNSVOu
X-Google-Smtp-Source: AGHT+IHOQo9W0aZf3MnjhclhR3nwlrFk6dppnhp5ayWEimO/qCbezZZnv9jMcOotLi2ysrcz68+yI+jPmrE7PBsoXgg=
X-Received: by 2002:a05:620a:1991:b0:7e8:3fbd:4190 with SMTP id
 af79cd13be357-8ab98eba49amr1317486085a.2.1762147813760; Sun, 02 Nov 2025
 21:30:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
In-Reply-To: <20251102-swap-m-v1-1-582f275d5bce@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 3 Nov 2025 13:30:02 +0800
X-Gm-Features: AWmQ_bnMUWkq9T95a6Uuq6ry1hDCnCtzRCM38-pLN__26i5yO5lc68dIeHd6alg
Message-ID: <CAGsJ_4ybtsP=ObDrWHZVN0htoGSWy-RMkRuiWWw6B9+Xaq_4YQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Chris and Kairui as the swap maintainer
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 11:11=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> We have been collaborating on a systematic effort to clean up and improve
> the Linux swap system, and might as well take responsibility for it.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---

This is very welcome! Thanks for all your efforts in improving swap across =
both
architectures and performance.

Acked-by: Barry Song <baohua@kernel.org>

