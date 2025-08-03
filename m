Return-Path: <linux-kernel+bounces-754386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A88B193C4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0739617534C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7A23C4E3;
	Sun,  3 Aug 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORxnvcfD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419C18FDDB
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219337; cv=none; b=QQ1eZO3xZ9qlOblLHM3SzyugFE8KJfV6qts9Du640p/wot/u2nY4kpII/g/yTmKVvORPPTUiw4/ONr6/takO+gc9Yvdn4fKICXwVtAdKCUBWRo3JJ3y/jG9NlPqNIS9/JxFy5JzLbulqAXATtmJdfH0MlkVDIrh+MtXk/FdOglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219337; c=relaxed/simple;
	bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgBMx3pBs44vdh3VBByl7z7pqReGXZo+KyMxzMhsKCqMMCUo4a3xrOTWeiuv3GQPvFen/LNBSsEve6pZcjZbOtu5SDTNO/VNyquS/cc7Vudk7v+LainYubdsakg6qLP0atm4J7XSlhTRJiClNpTlpoacrNq4ZC2zLOWTEyu5xDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORxnvcfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754219334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
	b=ORxnvcfDkSKfrmYRAgze849n90HKBVQAPMcIFKx6nKoSS+jppOmOpIsbYhO4oAYEs0b2xJ
	HaktMGQznHeu3pxhoqLizlGEdKPugBp7MTXG4V5+kDy48ussK0X10jgrxIObHsmSM/UmrH
	qn9eeIM6muRH9pJbT5tT2VMBXdhvPmw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-zC2wFRM7M3WZzTvOtDKQkw-1; Sun, 03 Aug 2025 07:08:53 -0400
X-MC-Unique: zC2wFRM7M3WZzTvOtDKQkw-1
X-Mimecast-MFC-AGG-ID: zC2wFRM7M3WZzTvOtDKQkw_1754219332
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af911f05997so355158066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219332; x=1754824132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
        b=mn5EEjWZBXw4JcMkbvyTsztc1bfPg7xYTB0QjFnjrTN+nRfb7U3hj+xH+6jvW2+AEI
         GI4HLLuPCXn5t3H3yvAFvWdNP9ZZUlmyJsq2/K9cI+sQcLrYjDOsEeY5qvRF8JwP7uCr
         X6t31ohbTHb3MLmz9RkuGu/ozATch0y++s0AXjiJ0aFO/CEvXQZrFbAJxlbdHqLIV2S6
         nE9MW+C9khMOEXnpjLo3RFHYsN686AOt3shNVFLIlvtAhFU5gkDt5m9Cj6pS1URIFAEV
         XOp2eX0GixquXW1dIQlmDsZcZ8GaVvbvLPmzapYBs7dIfBaL7ZPZu+3rMDUT/tfu1f7Q
         gIzg==
X-Forwarded-Encrypted: i=1; AJvYcCWlwxnOIpF5Bj69x8YoXeflcIiNa6E5aNMCqbBcPhmstAkYLoN+IV8opKKjZzG4ivJ+0qQMsivQfpYwr3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck5xcU43EX5a3m6sZiNufZROFlE8CKibS7G+Dm1NYImsjZ08p
	HRTJiVKwJrQ0rpf/OrqQKUmJDWqMKk72W9t7p/X8I8rnQb5Fnd9IxFpAbAtDY6YD/l3AzKj2GT3
	RNh0LREEXWm7E/NgUWXjl3RQwyKNxGax4VFoDALk1jswhFy4BRuv9UozhaKajaRqyI5wm5bICi4
	rA3BLid2yknmCCpxbOpL9YV0krzSiaEHdcmcghpVbmWFUxaH+NAj4=
X-Gm-Gg: ASbGnct3KOd4ZIkXI2xal7G1VP/TmU+rYeft4i2gUaQMA2RCnPSkl3acHVcIzobqnfV
	Ke+IhYXgCHlkKgT+uLvcA81aHFo6Q9GtvTOCpvxj/G6ZkBLzrjNjPaDM2q80Yi+ULVcGjWXKsrS
	7WUOJBd2OGcumdWp26qRPmFzY3u+kBCrBMPTvZefRLyMwT8Jxwll3+XR4=
X-Received: by 2002:a17:907:2d08:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-af9400097b2mr787294066b.16.1754219331665;
        Sun, 03 Aug 2025 04:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoe45St9oJl/hQdOjEm2D20HS5WNbCe0tPRvD+enwLjtMGO3xb9XsDGGOE9wa+2ShyOKoMeZbDp6sjKrYjJGs=
X-Received: by 2002:a17:907:2d08:b0:ae3:bb0a:1cc6 with SMTP id
 a640c23a62f3a-af9400097b2mr787291666b.16.1754219331241; Sun, 03 Aug 2025
 04:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611135644.219127-1-tglozar@redhat.com> <20250611135644.219127-3-tglozar@redhat.com>
In-Reply-To: <20250611135644.219127-3-tglozar@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sun, 3 Aug 2025 14:08:14 +0300
X-Gm-Features: Ac12FXxmbK-i4e9CuWRaXuohysrCBn-W8fQg2VCfPR9TMziF-wZwNzYbRYZiUN4
Message-ID: <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
Subject: Re: [PATCH 2/8] rtla/timerlat: Add action on threshold feature
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 16:57, Tomas Glozar <tglozar@redhat.com> wrote:
> A new option, -A/--on-threshold, is added, taking an argument

The term "threshold" is ambiguous. The use of the term is inconsistent
across the tools. In osnoise top and hist, it means "the minimum delta
to be considered noise," which conflicts with the semantics of the
`--on-threshold <action>` option. To avoid confusion, I propose
introducing "low" and "high" thresholds and updating the sources and
documentation accordingly.

Thanks
Costa


