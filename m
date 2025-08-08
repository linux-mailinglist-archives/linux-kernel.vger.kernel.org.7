Return-Path: <linux-kernel+bounces-760573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF7B1ED1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7117260CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C129F28750A;
	Fri,  8 Aug 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnR11wvY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506827FB07
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671303; cv=none; b=Xvw/hfUQYdD4ATYPgM6gjlwCA0RWkItq2OAKYw4qWkIv8zPuzQXi4YLnASNynTy193c+nPmCH1QUu2llujqDlfnZXsljar7sjjsWrmfLGoiyDpo7Bx3b3xFOAOjLv7xDDcq7w4DdnJh9Pi3Zsady3jv8k2KHiQpvPKvKH5zBpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671303; c=relaxed/simple;
	bh=dfdUfMqWlDOmJex++lFk1qO6nnIBP0OFGSpkvrWBx0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kotS4aAcE1poYweyooDNEUZiALk3j1iJtdUEln9HXUkDxpFzJjXZLwIYJLjgH1lNJ/v3CNiZqh89A1roMaVaHkQsSH7SwPW1982f7jqgvp8s4Q7KMolvp2lf+G2k0KRKqqMVKM7gcEbZN05xqwN/cbD1nlqR0DJ8rKB4R3LrdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HnR11wvY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-617ff2c8e5dso190a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754671300; x=1755276100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfdUfMqWlDOmJex++lFk1qO6nnIBP0OFGSpkvrWBx0w=;
        b=HnR11wvY6e5RayQ8PnrBK2z3ioLRS0b45qVxBoXlHm6aWGOoKeQe93gIoC7yYzhcGO
         vJ81mSoZ3cV1WoF7y6AksdcXOwPU/JfOCe2nqTovi3k8L9i0cle+ucgUl3QhJHW4MxkW
         KFY28vu2FgOTXdrju9DmvhjIunz08JnYaRJD+QaXXaoB6Yqr6kHjfVc9MQC+EWmze1ly
         gi188OIy6WKXKtgW+5aNaxb9jwaQXgQNMbYapC8/rl6CEyMoJ/xWBcuANouT0ER+1TYr
         Dx0b+H0UghQOHNAH7jujmBnrUe7XRm5oZc5ETP/MIDLIJqef1Y8Y4ZJrAZZXEPmupsIF
         GE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754671300; x=1755276100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfdUfMqWlDOmJex++lFk1qO6nnIBP0OFGSpkvrWBx0w=;
        b=GnrZ/XsrCE7/YNPFbz1oAVBMKhgkxMypO/3HT4CpRTLlG+m4gA7phsowzvZgcRtYG8
         03GRA6jzoM7NKtt7oNvJCt8pH051rUV9vBzhP4f8Dycegd/QHCGzXVgqf82ktljtaXHm
         MTppJcKJwEkR0DPYbQ//NKp2KE9wbSb29ZZibsDpJN4EANaiFYDiK7adWo2g2uN3eaih
         FbECaxlmh3jwHBODTGGow/C5+4hqTcsWbSlJmlOELc/mnBLhC+cLB9CYc/ouqsjdOROL
         TbHmNCcAkX07o9caBkz4PXNu4gqjh3uxAuF3f/WCU8VbD+uJxnoctf2ajpTAImEIdUoJ
         aKIg==
X-Forwarded-Encrypted: i=1; AJvYcCWHFy4nNC1OK9zWfYy4PopaKsij53rNEQhvnI3XlUPuHm0UU2jEgNfAbZAbb4eg1eNBlEDV2N+I/nNAEvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOoCg9FNRPctNH72EY54HC3d1rEWQ5BxnIv/gUe4EPMW/QEHM
	Hvpht7YiJe5uGmMh0Rz2CEkDuGV+1ONQjPbd77ooygyFbEKsGUVXIivy1nNLotXdxCxurRXnYQD
	pvPAqu+pix3TTP4E85BV4ZngScr1YkdIqxSTRUThH
X-Gm-Gg: ASbGncsytTZ6NiGTxVlsei7mBsCyNzB/l5DSbKaRfG05kNsRV0pF4YJ8HMO3XhzFR6g
	VJKfdIrKVyVa79kA6x9YTtbqEXkYCYKQafD/HaYF1hexQaPHkKdhKUbnChwMni0gkgTH3tEZdar
	BGgZOOmcORBs2qr73vAdQwCbBOMoDZM490dJ63/fmcc4XqM3iVkYiylnXa9HT7F2sFqeufVczEy
	YondlFq8EU8XmlGv3E5KSC6nMTs6mpsdD83SGPFtg==
X-Google-Smtp-Source: AGHT+IGcT1Fa1wAmQd/OSoCSWiqxxrHCCt8PYFL+Ygdztx19r9wleJKk1M6kSna+PxJBsaxfyKbUlyZTlO/6NquFBsE=
X-Received: by 2002:a50:d516:0:b0:617:9274:5bb0 with SMTP id
 4fb4d7f45d1cf-617e48fefe6mr91904a12.3.1754671299708; Fri, 08 Aug 2025
 09:41:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807103902.2242717-1-lokeshgidra@google.com>
 <aJT7qQzEs_p36yfI@x1.local> <20250807155401.683c77b0d0cb5c9ec88089e6@linux-foundation.org>
In-Reply-To: <20250807155401.683c77b0d0cb5c9ec88089e6@linux-foundation.org>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 8 Aug 2025 09:41:26 -0700
X-Gm-Features: Ac12FXyfe3klaRIC0BNFV6P8qrkr_FZHrNFM2dPy8TEb4JRfxMOXo149i-LIVQQ
Message-ID: <CA+EESO4zWAo=AwohgsGdHNmuLOiuPs1C-FOg4FHrtqiUTdY84g@mail.gmail.com>
Subject: Re: [PATCH v3] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 21cnbao@gmail.com, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:54=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 7 Aug 2025 15:16:57 -0400 Peter Xu <peterx@redhat.com> wrote:
>
> > Hi, Lokesh,
> >
> > On Thu, Aug 07, 2025 at 03:39:02AM -0700, Lokesh Gidra wrote:
> > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is require=
d
> > > for moving present pages. Mitigate this cost by opportunistically
> > > batching present contiguous pages for TLB flushing.
> > >
> > > Without batching, in our testing on an arm64 Android device with UFFD=
 GC,
> > > which uses MOVE ioctl for compaction, we observed that out of the tot=
al
> > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), an=
d
> > > ~20% in vm_normal_folio().
> > >
> > > With batching, the proportion of vm_normal_folio() increases to over
> > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> >
> > Do you know why vm_normal_folio() could be expensive? I still see quite
> > some other things this path needs to do.
>
> Maybe as explained here?
> https://lkml.kernel.org/r/20250807185819.199865-1-lorenzo.stoakes@oracle.=
com
>
Thanks for sharing this, Andrew. IMHO, this seems like the most likely
reason to me. There is nothing there other than a cold access to the
page struct.

>

