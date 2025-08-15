Return-Path: <linux-kernel+bounces-771522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0701B2885F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6971D01A84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABB246798;
	Fri, 15 Aug 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVqF0em7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D40228CB0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297500; cv=none; b=eixCHKxmqjVK7nC/NPX5UlgvCRRunPC7YVLAkkhAA+M8mG8CHtUl1jBd6Xe5/Sajx+5IJq17Fi7oSgUdUxK3yk2gjZ4Hka0dHfow/2PSf2qRpZeYIH0hrl8p67zzN4EomteCquRU1ezRUMjmX+vloW5SkyUvsYNNp7cKfXfm0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297500; c=relaxed/simple;
	bh=c1qsvMQG96pzBwCVQ6DQN2WgwR3ejEwlyfyjNUhq1vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijI7gI3M/lTgmrt6jJAiEe7J4Z3Thjrah6tR0XFTXQdRFYzsP2sEPePY+W6nnypQq3Y2J+SVjEl3uooZxcs/SISszN+a7m7yIV03H/nJDex6N3LarZ4W8see8EVViYE7tZlhfLVA4WAA46DRwd+bjr53ky81B5SDNape63ELK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVqF0em7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3DFC4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755297499;
	bh=c1qsvMQG96pzBwCVQ6DQN2WgwR3ejEwlyfyjNUhq1vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZVqF0em7dKgoDIQDN98KAre5pp776726gARLfwMEUHS/VPlTDAe1JNAf+EVtRfDe+
	 gLP4EnJn5+hwASM146DKl+BpHAzMgXHp5tsNgFe4EIaL7CE0wp3keUweON/j8jOlDu
	 RWOe7Vry9AP4iYnQpHVsMPPLXiG8YWoCdDmxDYGHLLNWWrU/2T3UDsbq0pommEpUFd
	 e8sfw8bmkyIHrgtXFXpREjlhyTMaf/oeeGGt5VwWKLOvs7GGmd/JJCEGrQN71yg+bc
	 TZjptqJb0JUxTUyNv+rfH/KVu0ajuADNsil/Hc2F/+7xTz4fGYW5dDywHt4FdKDU+u
	 WWi6NrYB4p9+Q==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459fc675d11so9355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqDxGzTl3blqcmP1KEECUzhdorNHockSpKptaIN+B+i8j6pWqPEYsXPyg/3zUp8mNNMiUxDtlBHTXgIrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqMCRLim9bcVoqGOeENgFR/5E3V6SAc9S6awPLpGZz8xe7VTN
	XSKLzlTRWUJaZoAAYKGcaFXnGqiQ293I8SskKpz+kRVZA3Ucxrh5G0iaa7fdhHpnBrjE9jvAxp1
	w2FuvGuu3lbDzFD8+HFW6RwvzaDk66oFZjrXCWAEa
X-Google-Smtp-Source: AGHT+IE2tthVbAPeYRpJUIRaQnADPFL/TZXfZagadCXDYlDKYMDA92nIonbGrC6wnNlCfUJKohX+2h24RryranZcrwo=
X-Received: by 2002:a05:600d:c:b0:45a:207a:eb7c with SMTP id
 5b1f17b1804b1-45a26768932mr354405e9.0.1755297497747; Fri, 15 Aug 2025
 15:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <2f75a76c-bdc1-6ca7-4438-21554831ec56@google.com>
In-Reply-To: <2f75a76c-bdc1-6ca7-4438-21554831ec56@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 15:38:06 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNEeQ14p-VpgRvTJ0YiXLHbc4Y8wSrOOMsnug8oP_bOHg@mail.gmail.com>
X-Gm-Features: Ac12FXzIQqOjNJhb-gjOaL6Nux9YI0GUqFop_i3tfHE5EMefJpuCak10WYPZD2g
Message-ID: <CAF8kJuNEeQ14p-VpgRvTJ0YiXLHbc4Y8wSrOOMsnug8oP_bOHg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Hugh Dickins <hughd@google.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 11:58=E2=80=AFAM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Wed, 13 Aug 2025, Chris Li wrote:
> >
> > I know Hugh has some idea to store incompressible pages in the swap
> > cache as well. Hugh?
>
> No, I don't have any idea or plan to store incompressible pages in the
> swap cache myself.  But yes, incompressible pages could well be "stored"
> in the swap cache.

Sorry Hugh, I don't mean to assign you more work. Just brainstorming.
Yes it could. The pros will be no swap fault. The cons is breaking the
zswap LRU ordering.

Chris

