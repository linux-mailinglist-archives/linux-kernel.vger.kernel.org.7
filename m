Return-Path: <linux-kernel+bounces-613477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DAA95D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 06:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88512177C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 04:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE31A5B86;
	Tue, 22 Apr 2025 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="moIJ5rOU"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A098186E40
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296940; cv=none; b=C7VtoyAap+XCKhGnE8V61KdbW5Yixh6itmXp4M8jAyo0L7TRm1lmb3+2R9Nbi8kJpsbIkKpWdQ1zFPzsfllbBqMO2B7q9Ee78KzxRvGijU1kdl+1LBwfdSlA0L10wk7D91SWFySrj7RlhuzW+sI60fFsGhze1FYHJTdzZOSgReg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296940; c=relaxed/simple;
	bh=iyooen8boCSaKbfxukeTPsPg9uQLAeQUCRIfTaXgy+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1AKPziJWnPg6fBzV2kpMEtDuCrKFvN4EsQEo7EeBZIPQQV0TJyvhr/CwHaoODim1t7+NwbnHcBYJvqMfO5ip/YRZ0ms7fz3NQXRGX7ky+z5BHDuPJiwsI/rGOqgS5YXuTWFcvajR/GIxTsPBvXWoMU/x593LiSgVik43K1R4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=moIJ5rOU; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVKRN8g4vfFOZvJCHosuYmF1bjp2RuCiRzHAiGDfiejMvgudTT3+an3onqTBd7IFyQZGhmVSf1d@vger.kernel.org, AJvYcCXJ0rwwhc3YXJnXNIpQSpVHrUlBNGwEaA83Zls9WEFDz+7cdWDYzJpMjK75N+1pzn+1WpuBYKgS9ewG7OpS@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745296924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyooen8boCSaKbfxukeTPsPg9uQLAeQUCRIfTaXgy+4=;
	b=moIJ5rOUWG6mNjk6Dro+ehvATo5SOo1Oqw+3qD6l/06DikIwI11vr1QKlY4pcqNSHq6rmw
	aqygsjLodh5ML5YVUP8Pg+oqIa0o7WLS9ytabtDFZn5JLnC7yr/G8sRq32uwoHb1DJ+kjC
	g80PP2e3Z772K6Xt5h6f3WiZPJ4JG6U=
X-Gm-Message-State: AOJu0YxTZfOiG2zg4ZDRzTsMeEGznsHFTHY5kmu4gJfp5cD79WGfTfKB
	YPPhUpXSx5eILLzl34msisQ3fzIIYeOUl6SNIq2X1Qzow6MX8pNDmzdqDFsIdvDnc3TqONUmBN8
	8yvsZiEQeUo5vUnHvyLynnJeFKlY=
X-Google-Smtp-Source: AGHT+IGNezq9dDwQ4fj0vRAB4kg6+pZkZ+OFNz6cNbpDRMEpb1eYm6qs/qbG3uFRgeTlS5jVDyeW/MxOPOHE6HUWcLY=
X-Received: by 2002:a05:6102:b15:b0:4c3:243:331a with SMTP id
 ada2fe7eead31-4cb7dd64326mr11996815137.6.1745296922129; Mon, 21 Apr 2025
 21:42:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422012616.1883287-1-gourry@gourry.net> <20250422012616.1883287-3-gourry@gourry.net>
In-Reply-To: <20250422012616.1883287-3-gourry@gourry.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Mon, 21 Apr 2025 21:41:51 -0700
X-Gmail-Original-Message-ID: <CAGj-7pUvHY74cg=+KLAMYxUWQY5h1A=hhG1-ybS31FA6=UJNmg@mail.gmail.com>
X-Gm-Features: ATxdqUFF5-_BnhOoHA-DjyvESYNTm8BqEQjiXQmCZxT5eeLxhIdTZoBPeVX9LSg
Message-ID: <CAGj-7pUvHY74cg=+KLAMYxUWQY5h1A=hhG1-ybS31FA6=UJNmg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, longman@redhat.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 21, 2025 at 6:26=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> It is possible for a reclaimer to cause demotions of an lruvec belonging
> to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
> this limitation based on the lruvec's memcg and prevent demotion.
>
> Notably, this may still allow demotion of shared libraries or any memory
> first instantiated in another cgroup. This means cpusets still cannot
> cannot guarantee complete isolation when demotion is enabled, and the
> docs have been updated to reflect this.
>
> This is useful for isolating workloads on a multi-tenant system from
> certain classes of memory more consistently - with the noted exceptions.
>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

