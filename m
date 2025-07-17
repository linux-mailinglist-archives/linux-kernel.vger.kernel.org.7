Return-Path: <linux-kernel+bounces-734500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4CB0827E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7939D1A63936
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D858F1DFDA1;
	Thu, 17 Jul 2025 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxxRZTSX"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2182F509
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716297; cv=none; b=YQ4p79dnOpUfyPjq3qqD9kTBUlNThPy1ozvYlomkpv7oTbWhBlB7FyTfdhw0YLovOwxtmUnZYAdpHnIpic2P3ykGX+arcUbAqx+6fn7ie9q+PGYFw+Ui6kyw0Ksluakusk6KQ4SDLz3tr3Nq2ANelMDAc/n+YlmViQEKcKRJvnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716297; c=relaxed/simple;
	bh=XEl9xWdkm001s4BWnfLogzuaUUgUnWcQGefbm9+v6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwlaZ8XmumP3xojlDeONinb8cgIG+icdx1ou7jGmhO8+eRqRt5lGioqIOICNQVC8yPp2xcK5/sSaHCHW0hqN/rzpPysA2urw7EcxnfhdhD/Yhl4IwM/7AOINlwVO3YT2cb7XuqZVlZg1NYpnb9txX/G5sz6DjgGbRwnaT19T1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxxRZTSX; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso145961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752716295; x=1753321095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=OxxRZTSXtTD9FlCZefwGZvtN6zgTd/mAAiQ9U9Mo/GrseOIKTaNUvUz8B0epqcT0iB
         QzmkABZYq33cQD3Psg9WEmpue9OKSgCv6zkuSsv3+1HFIxJ228ZUvuuqWCe5gCsHGI3n
         hrKYRiD8GDocH6Ivg/ge/qeKQnVkETWEcKqqSVWyoyGeiNzeDrRpu4/AmLBfvAE0RUTT
         S4yNB2zd6Fafe0q7I9Bu/jqW81nOZzXqQLaLoA9OrkhKJ1GPgIBaLlXyiWR/300MhtxX
         wOBWdEzAX9m4DcqUwniHM0LkSwm1XXsUpFQt/oqIUSaVMf+12uyghXdG2Fd6opuF9vlw
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716295; x=1753321095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=BlketgRQ0lb7mGuXiHNu49nhmTcryDTczxX63X9x86digrcbbvbLuXwL5h/f5eN9Dp
         uAhtDPkeYqtMR+q7wnFikQmzasC/dmFrRABScYp/RyYb9mwEBGzMp76DeVjitutxUtdN
         F4lyR4MgPQGNaU/9YV30Tz7/L+tEOzpuw7ID3hDDvTWh9dLMZzCTwfPCvlGOmMaPmIDC
         KbDpxwJ1IZ1vW+ZDYiwcEyng8vgGXjZkE+J6rtRWRyJK2ofgMDtdUDu4bug9kKOsxkbj
         q875Z8zebrqGv6kW8p0xLwyW69FaE+TRq8Yudt4TqtVBCWz2+0RU/ywbHSBfnIHdWRf2
         6OTw==
X-Forwarded-Encrypted: i=1; AJvYcCWsK+o9G7xisY+yiZqdjumwU7K+8OqnJMqB+JG+FL2l7ZlrJzfSHrnJCLFBc8tsecoVAawF9zORzFKV+XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOu6EGz97MT47URiqdUqPeqNuLH1JnUohW2igErJ1hyoQ/wZL
	TDvnFyzls44cB9VD68uiXCYOxZ/Fd6f8MrrKX58kZ90KAEkBPvSUbhKq05c2alPR37CM3YV81u9
	Cd6v/SnIIjdF3fevR0Dl2RPqmMmdm8eXXsnPkpcrX
X-Gm-Gg: ASbGncvIkqIAMAcnbmsJd90/4yFT5q9r4DKiLUbWwQvccri1I5KXM+WHNBuZPSnf007
	uAZVpgrb+5WRbLK632xSw/XLGLkpLt9tXom1G9EWv0h5dNVPS13Dh/P9gF7Q/p0OA4kjtlZXIgJ
	xAo2s76ngBJgfvmVyV1G6hrFa6XOxM0lj00y7u27YqQDaX1DcGDCcuHwKzQUCqURiE/bseBwEEz
	AuGXNQlPSzC9ZEw
X-Google-Smtp-Source: AGHT+IFhiaeqzK2nQ8VSVgEqrMotFK2LCspw+YJrQhNSUfoYY0N+Vy0kgJUtxif7ZxBwweEETtv622z4tIyINzqhXvw=
X-Received: by 2002:a05:622a:a492:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aba2bcfa11mr1814001cf.10.1752716294281; Wed, 16 Jul 2025
 18:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
In-Reply-To: <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 18:38:03 -0700
X-Gm-Features: Ac12FXxcylNiHfdNrzrYc5xn0C76o-sRxtUR8Ak1vbrrsG08KbBBjpmWceaRzxY
Message-ID: <CAJuCfpE7TAZmk+y-BC9WAYMTH31Ao1PNd9H8h=0GCLEyXygUdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 15 Jul 2025 20:05:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > This patchset switches from holding mmap_lock while reading /proc/pid/m=
aps
> > to taking per-vma locks as we walk the vma tree.
>
> Thanks, I added this v7 series to mm-new.  Which I usually push out
> mid-evening California time.

Thanks! There are some comments on the last version as well, so
unfortunately I'll have to respin and bother you again once that's
addressed but this update should at least remove the syzbot noise.

