Return-Path: <linux-kernel+bounces-751209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3DB16673
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56B81AA80AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3A2E0405;
	Wed, 30 Jul 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iKy00yqj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B292DFA21
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900963; cv=none; b=P9MMsKqCN5KtFA+iHsRRHlHhuGS1LTlv4FGxF+8bgecFnUH/tjeBsBHx+02LNro37pG01AH6Lc0JYZ8zRKcRebYIqmQv4QUGOo8PuhfbosccYoPZfczPn9aEwxFK9Dm59ZPRIQDbEAhtci/60usSRmljcg+C4TY1SJ+mUs7DUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900963; c=relaxed/simple;
	bh=Yo2DQQIGPajUqfGHx5XY0tjMbqxTiqf501AHB+aiPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff+4JlTdVTPZQH1bJPtcbCesnysgGS6w2sfbe1dmlcOAZ4VhUdTqaDoOkEWsTfM22+0u2PUVDrR9UwjE2zQFi2zEkxB5F1b5fBW4K/jX79EHLo5BvRAzwyCqXcEtaOpkU7iibmAE5pS3Nl7viLikxXXjRjsSURnVzKklt4rDFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iKy00yqj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6155e75a9acso122389a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753900959; x=1754505759; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/8KJCdai8KrtDfwinWM/LaJFRv4FrevPGL+R/XtgR8=;
        b=iKy00yqjNOZDJh3vNfPsgy1fjGNs7kDmfrJLHac6RLn/YIA98asHWXPcj3QguizTJs
         uGRVpeHc18clZ1w0KenPwjZzRkIcDEvjcLW7SpRru1hm4Rp1CyjqJHBAeWoV9NV7xAlH
         u34HR8zoz0sCxyq7V6oT6d3aZa88fJc2ao/ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900959; x=1754505759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/8KJCdai8KrtDfwinWM/LaJFRv4FrevPGL+R/XtgR8=;
        b=rpWKS9XHy9wD9yifeqL4IsTIPa56APEA57Mboa9xx5aKaj7i7EKXEyzkK2wgIrBzmQ
         4u/0Fc8+WE9jJ4ex7OPxxYL7LuiX2JlsieGUPN+ssiPJsHRmPPKpFIkCSetCUZnSLn2w
         hqmUHv+qjtIqmR4SP/2weOuZiGMzu6y+chPqJYLuT+Na2byOgOCwIfbaIdXjt7fFg3nC
         l65rJnEgCuBKZEUBmdRX4KNgZEu6oL9hSxZinvLiApEdrp1e11BaL/VHg2g0HxqztvkG
         wmDrptCg0VqLXtRisPs6GHlfdH+5nuWE8MVuQNT2QMuEypqFsvgtFIqGTrjPTgLve+Py
         cWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiHzNIBLJAgNLIXQv2mUcfKaccq63uUWsn6Z/4JeOi6hMzi744ijin32GbBkAvOafiZ7/V7rashM25rEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn5buD6l+Y0nmMlXreHVRArgeFmtjwPirO2lEcM/doW8nBPybL
	OlPVzY77ZAYOZ/dI7ZSMQsndNwYaeNSu+CLyJ0unwY9OovoYL+pJqJdojgnkfBBmEl2XLmOd9Wb
	ZmPcBPcM=
X-Gm-Gg: ASbGncv2n6x3MqWOJhU4iqpu14bFjsNF56jCbRUYShr/aROtHR2usmF8cc/DE33RT0r
	QwsMu1B9uiruqMhdh4rD8NesL0pggs1t3CyU3l8GdHg4QE4n1tXJkFH9ve2wZwztIdgfor/wLL3
	x0W7GydQEitWQdlji2m5HU8D4fnhFpqfBxP60haFma7u6eKxVtZ828H5aa7K/toPS4UE+26krIS
	0qjNOSut8PxpomPomE6gK5hpEj2o2xXpH8G2KiVAQl8JRQO7a3M02M/ZT8dxELWYtkkTy0wYzWu
	4QVTLE9BSW7upR7CM/lck6dsTKMsup9C9xXH2KnoLlQAGmyCZvXWQqMeVwdEadD7ihKPI+PmZoG
	zh7Gq67/tZ0lAbHSX7IbjZPhJSk2nnJFzVg2nHszMDIlbQE1BAruhsa/rlUxdbxpo8vucp09Ccp
	sy/y617Gc=
X-Google-Smtp-Source: AGHT+IGClUmkl4WxAua0QS/uKkM3IVuEk+yjJu9JABsIGBPEetmMXkyQO/tSAcHzK4xMQLCETUWEzg==
X-Received: by 2002:a17:907:d05:b0:ae4:a17:e6d2 with SMTP id a640c23a62f3a-af8fd736fd6mr535576366b.24.1753900959429;
        Wed, 30 Jul 2025 11:42:39 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a60e68sm781684766b.94.2025.07.30.11.42.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:42:38 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso114933a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:42:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWevS9V3sgZKK4C7tJRYKNvGzybz6LF8C4pNqcPuG8oAmm9oNkuqXtmlzHjjStPqwIFB4JRLEQFvnordtU=@vger.kernel.org
X-Received: by 2002:a50:8745:0:b0:607:5987:5b90 with SMTP id
 4fb4d7f45d1cf-61586f12581mr2997178a12.11.1753900958279; Wed, 30 Jul 2025
 11:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
In-Reply-To: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:42:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
X-Gm-Features: Ac12FXyIEgB8PrPgd0exea9RuFqBlTLaxSkR6vauSlGJKXBn_YJf0vKGTRlMTV0
Message-ID: <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.17
To: Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, 
	David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Pedro Falcato <pfalcato@suse.de>, Bernard Metzler <bernard.metzler@linux.dev>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Jul 2025 at 09:56, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> We've hit a last-minute snag last week when lkp reported [1] the commit
> "mm, slab: use frozen pages for large kmalloc" exposed a pre-existing bug
> in siw_tcp_sendpages(). Pedro has been fixing it [2] so hopefully that will
> result in a PR soon, which you can pull before this one - or perhaps take
> the fix directly. If that gets stuck for some reason and taking the fix
> later would be unacceptable, I can do another PR with my commit taken out.
>
> [1] https://lore.kernel.org/all/202507220801.50a7210-lkp@intel.com/
> [2] https://lore.kernel.org/all/20250723104123.190518-1-pfalcato@suse.de/

Thanks for the heads up.

I've pulled this, although I don't see the rdma fix in the rdma tree
(the pull for which is still pending in my inbox - I've merged a big
chunk already, people have been very good about sending their pulls
early - thanks)

Let's hope that gets handled soonish - but I'm adding Jason explicitly
to the cc just so that he sees this.

I'll take the fix directly in the worst case, but prefer for things to
go through the normal subsystem maintainer if at all possible, and
this one seems fairly straightforward.

             Linus

