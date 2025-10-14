Return-Path: <linux-kernel+bounces-853325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A4BDB4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C49423C95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F5306D36;
	Tue, 14 Oct 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS3UfEh/"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E9274B58
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474571; cv=none; b=izXluq+4rJ/sGjQpBIPCYsGjKNAMqJnkdMr+HCE7kQNDnHDt0E5sv1jHE0KLUI0XnU9y2nMZZymI4VEDj8tefL5dPHTSFHb4msW5dR85ALBn0z0PX/Ycj5wtJTy3wJfSVbnE8cJoSg9QbBTKREHZqCWmKLBoPId7NOk8qKoNrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474571; c=relaxed/simple;
	bh=X5Wkc3y5XxtvExrMi62ryXeDIWnD8jimxbR2ahS/QXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0hQyVM1q+KoB1FcSI+U9DfalkH2i/LJ2tIcbjLQmTGZ/u/eTD4oTnbxIrafdQnjawIWu8tM+9xXO6J3rSNf+q4vEqQ2ZRv8jvPqT7wagPKy88oT/A84FQhgeUQj4959KuGjI8BakUC9/NOwgLmU1Yncc49uFsrGxhxaQdQ3wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS3UfEh/; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a3511312d6so3028939137.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474569; x=1761079369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uockn1DmFA8ZAnlkgMjydfkJvdgnzoAnn5KXsE8LaOc=;
        b=LS3UfEh/IXL+QNpzFA/vbBJN7AiGYtMTk/HrMRPAb+DLvF0e7bzNJ41wpo7ULHql5Q
         g+eU/4egfAPwVoh6+pyrM2v3F3zAy4BNUuVLKizwpzOwTdJbENZhQWmuP3auRUwbqEvk
         XWAUP/pzuyKzg3MpnzWu26hcbY3kZy/ih0gGZYdJ0pAUh2ZQA0KGn1u5OEFBmADd0oKz
         QbjnjhpP5oQaF/LmNkpFvbzvQcABo23c01zv09vWAz4WJzofqfL+dJipQjWzV7NT+vF3
         1nLXbijPnEHCzfSF8VfCGBcRaEdvJ3xByZUwIPoeQKZ5cJezZ9HNVoDo2494cOcn9u6D
         zDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474569; x=1761079369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uockn1DmFA8ZAnlkgMjydfkJvdgnzoAnn5KXsE8LaOc=;
        b=luQs3I9nSAAv7t/NsNmIKgLDNWvWRuuiY3Rt0r79GrsapDTwnD3tSWhn1VPK1vQkou
         XgY1JEZGOoeHApDDm3K3bQ56iHSP3cQGtLsb2AZj11KCjLL+zbAnxHciKEY/DWJ7MJnE
         xC/9HKo6hIHxCuutK0aNnN6GhN3XShJxwxHmmsQz0sFOXsvv9iWDHpMz5iQyBbctKdbS
         LW8FiI68LgvkJOmIUWS1HjoqhLISwKMvqvSbmbDNBfBC0Oelz4+ZQuGvbumEoyhazFyg
         pzMzLh0DCpVvlZ/6fW/MhPFhaSXjHBbeRkrm+8jcW2XZuQEjUUYNBmPGBtGawgA5ixGW
         d+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUPo6b68T6I1yr0+DXlUpmhrasFkYkp7heUlZKk+cp0sHkLip7zQw3uqGUIVlMZHa3MXrp6FjcDY6FCbPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZPK+2mqpcFiT5i+iA8UOjsLqrgD+WC5V1Pym2ewxtmN4ajya
	6vlkeRJGr1FHkkUg6/mLqBkSBw6E3lSTjWeecxNRps8XoC6ItCJyzYUv5Pfofvp2/sGWViiPwRw
	H9Q64P9z30NeLl3RsqqQfVb2U7OE0G0s=
X-Gm-Gg: ASbGncvwOAhTx7OfP9roPxfrT9OXH2uQdgV+xyfHR5xFJl1Fx512PjoclT+B1tm47Kr
	sSEc1y4TR3dUjyRKPHR8PSQd3sUcJzcopFd1B1BSe/zYMeIZRFnh51jVv9EvvpnQrGs7B7XduVy
	P9tO/rSYLliuG9TGvFAp+8HFt0j13EnE5MfBxXJCAcprOnNY6R6CAhpxYKFMHA0Uv6pfXYuM/ci
	xmboD1FSHQTRhGWrgBGWYItRP38aOa6cqZ5boNsHoGByasnefOSSZQ9al2gQ+V4MG5Z
X-Google-Smtp-Source: AGHT+IEnsr51HAAycnl5TJWtojVCtdeDbTLi5HrOIWN/EM0aj7tT4qSjlzWUR1EkpvLjmCuZMzthdHU4KSmPdfVDcS0=
X-Received: by 2002:a05:6102:1516:b0:5d5:f6ae:38d5 with SMTP id
 ada2fe7eead31-5d5f6ae3b8bmr6904190137.42.1760474568697; Tue, 14 Oct 2025
 13:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com> <fe38e328-5e64-44b2-9e62-f764c4b307bd@vivo.com>
In-Reply-To: <fe38e328-5e64-44b2-9e62-f764c4b307bd@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 04:42:36 +0800
X-Gm-Features: AS18NWDkw8474qAcz1fNrydjfJ00yxfFAbDaJ_VQwKfXsjjmOArAdgWL5vP-vUY
Message-ID: <CAGsJ_4xdvGjZ9YZnc0mk3bDfPCwxdpF_5bhcbca09j=-KBM9Mg@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Kairui Song <ryncsn@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi Barry
>
> Thank you for your question. Here is the issue we are encountering:
>
> Flame graph of time distribution for douyin process exit (~400MB swapped)=
:
> do_notify_resume         3.89%
> get_signal               3.89%
> do_signal_exit           3.88%
> do_exit                  3.88%
> mmput                    3.22%
> exit_mmap                3.22%
> unmap_vmas               3.08%
> unmap_page_range         3.07%
> free_swap_and_cache_nr   1.31%****
> swap_entry_range_free    1.17%****
> zram_slot_free_notify    1.11%****

If 1.11/1.31, or 85% of free_swap_and_cache_nr, comes from zram_free,
it=E2=80=99s clear that the swap/mm core is not the right place for this op=
timization.

As it involves too much complexity=E2=80=94for example, synchronization bet=
ween
swapoff and your new threads.

> zram_free_hw_entry_dc    0.43%
> free_zspage[zsmalloc]    0.09%

Thanks
Barry

