Return-Path: <linux-kernel+bounces-840810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1E1BB5787
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E03A7F15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0F1B043C;
	Thu,  2 Oct 2025 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GD+vG+Ha"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778453BB44
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440694; cv=none; b=kp6phKUIku0Ql1taXVIvCfRUydRqUCJVpQqs1XpyU63f5L3vGm3NXkV0zg+WznPIr/0Oy9h9Kqnxe/Pa9uD00PjfU3bKDFHaUfPKVE3ijJMW0R+/Jrnrm2o+orhazL+0zAXWATUuvzUKw3dV5eZKqap78Z9gzeTyJkuI0vcAwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440694; c=relaxed/simple;
	bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pglxhhU2zlFUtkZctPB8qmQ2bOp/5mJqE7PzfQBxVM48s71MRnkUJefxpcMgbBVnXKkgkV1cYTgZuHtW7yV2jTOttOd9TuQuBkHoN9Mh7llWzeaoeDkKk7a0rd3TBiFkispWJs0y0bZ7mWcskSr6xZAn1kbZGiZa3heSdh/gEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GD+vG+Ha; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dffec0f15aso19755261cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759440691; x=1760045491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
        b=GD+vG+Ha6KxHEJVqXSK/nIlHxQ9rZcgH9Sjc1sllNINvuHKE16dAagBajcbEIP0k2k
         SJ+LB6EMPgOEc9s79KYQyl4w84hfTPo/AVimunYRBt5aMmI/YVHBz5xoXvFP/D/djvk6
         LLaMqzFlfFj8THa8ncAGncaNqrEu1CHuwcFPQ5hKJ0FwM4oY8IV9TLHTUmQvKU1TfVjb
         WJjdLe1I/B/pLaZR60KHmlnW1PGtkvXAl4eQANtnttYLug9mUzAci8EcS+JYj3n8uTBP
         HgO3clz06Of1Mewt0biBFzlh3elbJQ/ov7gCeMTuRP8J8Hb1Rzmpi9EmndvV2EbrJdfB
         wKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440691; x=1760045491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADVKA72uibgUp8chHhCTUoKhB8iWg6QqufDfTX9xhfg=;
        b=D1VqLH8P3UcZ/nHkiEw9UzN9SPm7HnweCQ0oW2hANrFO5WS2AFd84bV9oOfFExzAje
         FgFo4Hh30vTpFOXcZ8wbKhxeznXCxsSulcC/t4Rd3yIM2KrmA4m2EWSG+GUPP3cOpCP9
         cyOWlDLVIx+aP2p1brVp+UUybvArso+A97e44sTnykZA+bvhlvWomwDQ3KPaMj2/sef0
         o+yZ26xgpPgULx1VrLPjM0qAw1SBQR0a1VAS7DyLaXG6EAiUE59H6aviqEx5mCc0bIgR
         ia9uu4RxidJm5nhT6lxwnRO1voOwDRRFXtzhVEouQ+0S1fnNmuE+umYPogUrpii7DuHo
         TyOg==
X-Forwarded-Encrypted: i=1; AJvYcCVrs5GJ7v8J6INSslTypsEEPUL5QXr37XlbUrN9qdy1W71eE4oZl/nYhMVNP0ScX1C0oHtYZlF1kis05qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpsSwwdE/64DFyPM+B/51+wVl+yZtTx1ImSllA1ext7CHe5hQ
	i680clf3tYSfBUMz0Kudm802Ura37vYJpjiRcduZRM+SEl3Gtkyf7zWQiQWh5UwxcDDd5YAiHxx
	BGFJ7GRW98Qf59U1fTkGzHblSyCQ/JvTHFYoqLoCR2w==
X-Gm-Gg: ASbGncvvYY/Yl56RXj8Z9nQs/ancMmpdIlVP7gyd0Bad9Hs9faxhrZfT1cmu7IHyfCR
	JhaHDR6a+gpoKvf/ROqj5I9PghvqRECxxCsUisOYJu5zLY4b5N+dHjolWE9wW/IghBMHvNU2/L/
	ZvRiAuj28MA0F0+GrepttuC4sYV0jpC/hmVlo2xly309NtWx8oFXcm7Ftii5wsweYRQDy0LJZsn
	Ekq1nOEfI2sVoKSFrib9fW/nODa
X-Google-Smtp-Source: AGHT+IH/16s1by7ClONo0CJZp6FuEYc35ekFOWh9F2qUqnyBNSe6GVvhTvy0I7DJrBfu1/4oG5whYxgQGdE0sVEdVNU=
X-Received: by 2002:a05:622a:4c84:b0:4da:c4cb:c824 with SMTP id
 d75a77b69052e-4e576aaab42mr13472301cf.48.1759440690935; Thu, 02 Oct 2025
 14:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca> <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
In-Reply-To: <20251002211217.GI3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 17:30:53 -0400
X-Gm-Features: AS18NWAU1FKYkrHqSIxGFn313yno9EcdIcVYoO9fXd9wYXzV-AO6SzBS_A-_2S0
Message-ID: <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

> Maybe finish is too broad grained? What if each session had a finish?
> All the objects in the session are cleaned up, invoke the session
> finish and the memfd's in the session unfreeze?

All sessions have their own finish:
https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@soleen.com
LIVEUPDATE_SESSION_SET_EVENT

Each session can go into a "finished" state independently. However, I
am still thinking about whether a dependency graph is needed. I feel
that if we require FDs to be added to a session in a specific order
(i.e., dependencies must be added first), and every subsequent FD
checks that all prerequisites are already in the session via the
existing can_preserve() callback, we should be okay, as long as we
finish() them in reverse order.

There are two issues:
1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
We can simply remove this IOCTL all together. Stuff can be unpreserved
by simply closing session FD.

2. Remembering this order on the way back, and since we are using the
token as an iterator, that is not going to work, unless the graph is
also preserved. However, now that we have sessions and the token
values are independent for each session, I am thinking we can go back
to the model where the kernel issues tokens when FDs are preserved, as
each session will always start from token=0. This way FD preservation
order and token order will always match.

Pasha

