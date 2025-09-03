Return-Path: <linux-kernel+bounces-798024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AAFB41884
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DCB3B6C83
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1A2ECE86;
	Wed,  3 Sep 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhYOLid+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57C2ECD11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888133; cv=none; b=BZTAhr0EM05JIuSMXLhN4KdWF1CDwJcqxJ0h4cbKcpIB6Cm1Mcbt/jyJPfNpa/H3KcS+Lv00k16foJqd0lp2+qaycNqTA3ri+xP/3iVQFC+VAH97v8mnOwxZor9Mb4YA/blHu3+x4CxMxEBec3Fx76bR96DgiVohFIOepkMlM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888133; c=relaxed/simple;
	bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMy3vPXMKdhf3j0Pa60/bimEcB5LGXWOQmKi7QaKChrJMX7iuzQV2+8cArmmevyyky5zELdOUSJ4/ueFIRve7VOn/zGzHDyRFLvtF+vg/Rzcu/Zw4UtvyE7PjCpIMWMuZd5mJRg8ihXSwyT8jT00mNbq5jveqq1FAyY709asgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhYOLid+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756888130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
	b=EhYOLid+EPWJKqvKC82/03tVwUngXRjvK4NaIHKXV6C/1d4SeV6UHO09gqilIboVxeoc/b
	VzheOeRVmbwFd/rNOAdbIq09C76c+NfJrkt8B18TaRn/nQ2q1GKOxZbAL91o9/6KtgydUO
	TT9MPQtkBCLz20avXhqtTbOd0n5cUxA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-g26aGAjBNlGnmCAkY-PrTw-1; Wed, 03 Sep 2025 04:28:49 -0400
X-MC-Unique: g26aGAjBNlGnmCAkY-PrTw-1
X-Mimecast-MFC-AGG-ID: g26aGAjBNlGnmCAkY-PrTw_1756888128
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d60163d68so80950097b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888128; x=1757492928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
        b=cmNqOz4B3SD9EpsLBEMytmp2HxcUy74BkOq3Sp3NS5QXFcORtKAkGbLeiEfAGgWjB9
         JSeRjDfnKt6UnIX1BbFS9uAzhETXNqXOwq2+BQ+kc1n4R/Biw+SgRaDA/FEzyyJe32KU
         2gCMSAv9p1N9blIB2IUkosCewhT/iEDwNYo1WDPpRXkZlMhWTyHiS8Hea2cYuvwBiKx4
         gvdgMgFWS68TROWg52RtvHu/BwAweHDxq7u9hzZH9LFU1ksrZPwtQ9sb7StLLMEveacI
         MciAAMIlrECtmznT6FdukMGB7VO4IEP1YcgeI483u7VIvMNhMkG/6GDg641jHQ2uCKFc
         AKkw==
X-Forwarded-Encrypted: i=1; AJvYcCV2swqgPmWkOZsDO/POZBarM+qq3eg/0O2i4EA1YG80kmd1jrk1wm+TqxtpFCPkKbHOXlYFZ0qzN4xM6A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUqNCMxTn5fSqdOINe0TsoeJIpjVmTrE7V5GBtQYyYwU+3U1z
	tTXOqhuUXQUBcmo47xlpxiXQQqwwi268HbdCClxKcoFMOKyunOfAUzelLjXfIRuiftQSCWLHHtx
	r87EFucAv578erpdUyxndlJM74NWVCVixORUtB36dXPmc7W4WJfhvFsgTv/bxB8D6M7z7wiYyem
	t0jVz7S9ZnzeStkwL/i/ybvB6r0YbOxP2e8UFuDWu2
X-Gm-Gg: ASbGnctqQ23Yw5nnL8kEvoH6tlO5g3dm+IrnllDA/rOVPgSfcmbasmL+JGfFqXeJHu0
	zNrn9rocpgb++vHQTHuusYZu4c1EfMLsan27eb2M21trA48/ffJGzqIhUBNvlTDmMF1b0WiuX3j
	C8ULT4oq3bFJ8SehrZPx1EVhM=
X-Received: by 2002:a05:690c:7244:b0:71f:e538:9d3b with SMTP id 00721157ae682-722764eff7fmr166457647b3.26.1756888128560;
        Wed, 03 Sep 2025 01:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYG1aLTZAojkV67Ys8INIr4fhAsoDsqd/5OIuV3VuDUxLodstA7ei+5D3jLjj9I8dZDMccgIc3EmQHN35EXA=
X-Received: by 2002:a05:690c:7244:b0:71f:e538:9d3b with SMTP id
 00721157ae682-722764eff7fmr166457477b3.26.1756888128234; Wed, 03 Sep 2025
 01:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
 <20250902095250.1319807-1-nogikh@google.com> <20250902154043.7214448ff3a9cb68c8d231d5@linux-foundation.org>
 <20250903090934.4b5479d8@canb.auug.org.au>
In-Reply-To: <20250903090934.4b5479d8@canb.auug.org.au>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 3 Sep 2025 10:28:37 +0200
X-Gm-Features: Ac12FXwfp66OxV2wPvU3kcSifrwN6wBBZVCwf5GBxB_zYjlveqlVWbBCkVqp5nA
Message-ID: <CAOssrKe7CzU3295uZa5OTyfGM4PObvFTL2rm2LBCKSf0LDTtgg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Aleksandr Nogikh <nogikh@google.com>, david@redhat.com, 
	joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, m.szyprowski@samsung.com, 
	willy@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:16=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi Andrew,
>
> On Tue, 2 Sep 2025 15:40:43 -0700 Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> >
> > Perhaps Stephen can directly add it to linux-next for a while?
>
> I will add it to linux-next from today (until Miklos sorts it out).
> Note that the fuse tree was updated since yesterday's linux-next, but
> this patch is still not included.

Sorry, I just didn't realize this was fixing a patch in my tree.

Added now.

Thanks,
Miklos


