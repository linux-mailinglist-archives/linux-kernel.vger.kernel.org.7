Return-Path: <linux-kernel+bounces-619504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FFBA9BD70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 06:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB8D1BA180C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 04:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DC21578D;
	Fri, 25 Apr 2025 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I3cutXE4"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7347205513
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554333; cv=none; b=BNo6dWOMvZBAkL7AQvvkeV2Mfcf0IxX78AgA0U3nJzCG+7GJHftRvi0qS7p17g92r0yz+YmDYohOmynF1e6Wq7WMS/RRGG6g/M/ZocprzvCpLeggXAGEhOTA/0+ZrWc1hfktSa3ERdR16qN/B5ONhF6n9FSOf62M4qRYjMmxR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554333; c=relaxed/simple;
	bh=cuCg6ijI2TH+LC6Fyid+TCSLZ7DunTJod95bwhKMHbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6J3wYNPD6wrXUuMmecgdElKMcd2fDTzvqRP/C9S8zrTYgcxHczYQlVagEzLaC0Ml8t+e1yETOT8rRtA5S+0ugNQ5PSG9VUfq7l9HUCMPXFNMgJPHy+r+V8H9/vyyEyq8s+B+XhbMlgeLug4hVijhDvVW3UJ+hfU5r1nayhTpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I3cutXE4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVe1jGi6f7S4C+R6vA5Fjdg8G69yylr0Tcv0VNgHIEOKwKLd6GxYIt6GxSmnOImWOvQWPqLeDyNbB6LrAYH@vger.kernel.org, AJvYcCXNQ6gUjMIft9S++QkGsLcSQs3nCz7h0xVIvlfrptr3rUlCln/uH4EJeJI0y+eaHqCVI6+DBjrX@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745554318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuCg6ijI2TH+LC6Fyid+TCSLZ7DunTJod95bwhKMHbk=;
	b=I3cutXE4dFlOgcMFiScUWV9Ej8+RatznMrN3PMznp87iybLkJSTrvyEiGDy3K3mxIDw/EV
	Ph8tVenE4jJfoFXOTV6j/qgf9GFPd2L9Yt9QOXC7AxDvfzKYNmX62qsuX6KuaNGqwyyDdk
	68ed2TdQnNA4h+3xB2wTY7m5M037NGo=
X-Gm-Message-State: AOJu0YySWwFgfmM9Br+BJeEcmDfV0EfodIi8jDvskEx7bbZVpWodPizG
	qPth+lKG2Ap5YcuA6sj2X5lzfFrnpIn4RMvHaw0okAMfFXbWKXx/+CYiuFYMy8YJSK/RdTTqzO8
	Lt1b9uq/HaK0W1NbKGoK/2w2R/Gw=
X-Google-Smtp-Source: AGHT+IE4+ZZw1WQEvPFm/BGNa+LVBegmw46Ez+nFYA+a/+S+oR+yCxUKcymuwnUqgPoJ5PYHrIHZJ8y+iDk/5gGJGUk=
X-Received: by 2002:a05:6102:c01:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4d545845338mr229442137.21.1745554312652; Thu, 24 Apr 2025
 21:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425031935.76411-1-link@vivo.com> <20250425031935.76411-2-link@vivo.com>
In-Reply-To: <20250425031935.76411-2-link@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 24 Apr 2025 21:11:41 -0700
X-Gmail-Original-Message-ID: <CAGj-7pXOCbhzssjRsYP2FFvAE3aYdxbPVH9v=rBfq0aPc4wjQA@mail.gmail.com>
X-Gm-Features: ATxdqUGa33ZQ78AWa3C3GwORVACmk7lh6bfF8AxM79f-ya7keIRx1QdcR1UoWhk
Message-ID: <CAGj-7pXOCbhzssjRsYP2FFvAE3aYdxbPVH9v=rBfq0aPc4wjQA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm/memcg: move mem_cgroup_init() ahead of cgroup_init()
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Francesco Valla <francesco@valla.it>, Raul E Rangel <rrangel@chromium.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Boqun Feng <boqun.feng@gmail.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 24, 2025 at 8:19=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
> When cgroup_init() creates root_mem_cgroup through css_alloc callback,
> some critical resources might not be fully initialized, forcing later
> operations to perform conditional checks for resource availability.
>
> This patch move mem_cgroup_init() to address the init order, it invoke
> before cgroup_init, so, compare to subsys_initcall, it can use to prepare
> some key resources before root_mem_cgroup alloc.
>
> Signed-off-by: Huan Yang <link@vivo.com>
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

