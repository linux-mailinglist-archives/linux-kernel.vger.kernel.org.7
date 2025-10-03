Return-Path: <linux-kernel+bounces-841421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC7CBB7437
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8374919C221F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FB13B7AE;
	Fri,  3 Oct 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnFvok9+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6764A23
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503682; cv=none; b=lZeFLsov4MTKoIl36Oxd2MmszhTCP2s5erEyO8M3ckym4QHDH3CpjeqF3YqIruuFgpM6obp9YtZJAFklj7kZXNg5t6FYLO+lgAZFyzJYqmIlDCgM56Y2dGS74qQ5EU8hVsjIAl0SGtSWjSkGmxAYMerf9OEz0PUJYHmYcj4vHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503682; c=relaxed/simple;
	bh=RK3GiNyWlCQPM7XmWwRghURTtNw/oeDV99lkNumFhs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjJpdUOxMn9Qag4Tj/99AvKMhdyUpOljSjJ9nZQEFg7m7DQ7VDajOjKDhn3IZfc0e1/Dvc2c3RF6xfmdGhCPeG0rgGoBXyCnzMkCEQK/Nh002GnsYRiQundjJfZVmfL303zf5l15JfhquosU2s/K0dxnQeqgyOzKmen420/8vTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnFvok9+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so17653575e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759503679; x=1760108479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvoiyExDSEvJpLVkArK+JF0/gLIg1oSJww/Brn0jTdI=;
        b=UnFvok9+jiBHy6tYW4yohOsGbcoBILgZMAXTkByfVUpZqNSUvqjcL+nPzPfFUQMC+V
         fII7WarMzBVWrwQX6uUy0e+w5wCmmidU3t3OcZJYBbgBUDiHj3jwP43G+ZvXnnZgKpJ8
         dJ5hyYbGRE8Afqe7F/B5XiuegMLGEdey7+4KjrdVgHVOaMdC0Pz7YCDgtoSMwuWIuF25
         V8kizeYbkq0vZQOqGVz3LI2TX4JmBZfqpoTFxKsOjYfgJyKn23SID7kSTSJgriX87IIk
         yF8w0g40eKHmyuYz1I6GkbrphCoNXIc4x0ji6Ql9uqnmFZ7TgnK+nv6yRyYzKfL1+cz5
         FLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503679; x=1760108479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvoiyExDSEvJpLVkArK+JF0/gLIg1oSJww/Brn0jTdI=;
        b=WsR1eQXWwopczVZENZAo9s48abTv1vluY08iyoA6ckKvJ8Zmy71fTvBxP9bJpaVBqO
         WKorh7JSaNuV3R7SOWGIPDGqC+5XFr5Ad+RnL6/iKq5d4cW/jZaCVizslH7dQ5jMLSCN
         WP9JTmAfj46GCiwXqZ+SQTccTu5WHjf8xQMoL3vlz9/hwAJ/z66m6A3OBURfZVLlDas6
         9tgOqsfeypDkEYtsBwV+ccIvODJCPnQga4+yF5b26tawDYu61F/mo5G8ZFm2LzLonFlO
         iS0v+TPsXTxD7eQDAt92vaG76LeXmGyRl0oLi0pc6W+UcC71vTFhNlxr/E7PBbHHaNAz
         jA3A==
X-Forwarded-Encrypted: i=1; AJvYcCVwsbCCxplnTh+g5h7qYLTqDt1o9p13JahPCejqH3vEFqPe8CsPVsw68eQ8VNeQy06cxcH2c9JDyS69Iv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaQjLmo9zSd63d2gtOQB9qixCV2ncz6xdAyf7496ELIv0lU7h
	wJPyUyttvmkzSXpBZ5+vTtrI+DRz4fWmTUaHMytHpuzkKihTBe/eb7b7yT02e3PbTA2a1MA9Msa
	NWhRfR1eP2+2iu9E19HHbjH4eoSsNLnc=
X-Gm-Gg: ASbGncs5wTGlmrMyi4INq0REEgVVqewps+Dd0P9hRLaHRZJXoAjV5AnYSHHTmkgx22f
	DGkJxW4CSKVjNrxICePUUDgmonqq2gFxzTBrRFh17in07tfxoC//9s9uTtTOUuLb5ZcNaHPWuRQ
	bJLhVimynVBO6VVx10IMogm4DYjk3zWMRlO0J/ZtdUi9YgT/ulBLVHumfM/s5/gqkDLSjRibKxN
	gdf1ZtnbEa+JesoucNzYoHVad4fgtZY3f/AvbwYBcS14aCh8+GLAYHJg2+Skvk5FLR6
X-Google-Smtp-Source: AGHT+IGhP1/atGsvKEKDdjwDJhtnkHEnPkwva/8TFkjZbQaj2BQDqokdY2zYTli9XTOnEez1YY3KKjNm1oo6pN9k7fQ=
X-Received: by 2002:a05:600c:19ce:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e7110c3d5mr28401455e9.16.1759503678161; Fri, 03 Oct 2025
 08:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930083402.782927-1-ranxiaokai627@163.com> <f72deca7-4344-4adc-88e3-35a4a1d9a30b@suse.cz>
In-Reply-To: <f72deca7-4344-4adc-88e3-35a4a1d9a30b@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Oct 2025 08:01:07 -0700
X-Gm-Features: AS18NWDeadN5gWCPdehSIc1K0vm29j1_C80YFC-7IO3Xo557HA4mE3AgwK0bSQg
Message-ID: <CAADnVQK0COXqq=R_WZU5stBe1b+472RS0+JJrThnbxXadBgN4Q@mail.gmail.com>
Subject: Re: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
To: Vlastimil Babka <vbabka@suse.cz>
Cc: ranxiaokai627@163.com, Andrew Morton <akpm@linux-foundation.org>, cl@gentwo.org, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:50=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
>
> Disable preemption in defer_free() and also defer_deactivate_slab() to
> make it safe.
>
> [vbabka@suse.cz: disable preemption instead of using raw_cpu_ptr() per
>  the discussion ]
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock()=
.")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Link: https://lore.kernel.org/r/20250930083402.782927-1-ranxiaokai627@163=
.com
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Alexei Starovoitov <ast@kernel.org>

