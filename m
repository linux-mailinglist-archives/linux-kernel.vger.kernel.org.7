Return-Path: <linux-kernel+bounces-869610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4BAC08505
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D081AA140C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0E303CB7;
	Fri, 24 Oct 2025 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1GxVMyE"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9E1E25E3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348754; cv=none; b=GQGlYJjOziaFINSVNK5fOF+aBMsyxqOIpT5FDOGuPqt5YzlT3MatTEqMhcWDs6BrqH1ZTHc7h2xs3R4qsshCpj7UhQ3V60R3OgXpoUgLCFcODcQ8qi6kWcV0vguss4qJapyyGjI+mYsRHhAOepQzprV2jpnWv7wVwFWJxlnr+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348754; c=relaxed/simple;
	bh=o4r08lbVsQE0OD3LGzE40m+9+CVVkVezP7P3sn2U2T8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JCYT0VnlasHHKH2K2xNWJKWm1sncO5nHn56TJ97B2dpN4sSn1PzjGfLbkU55g5ojjAhW91F/RXga4SPt/uH1IHPJh2glRBJoWoE0Zw0HMi1gHfoo1Yg8Nt0X2Ly/TFxoZeN7vhCbD/FAyNMmONdE6DbEyg7rbgLeBwWznK+/PtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1GxVMyE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4278c82dce6so1462363f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761348751; x=1761953551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4r08lbVsQE0OD3LGzE40m+9+CVVkVezP7P3sn2U2T8=;
        b=u1GxVMyE0ZillYXs1yfpucQl+M0LEPiJQIcNhKcWNs+5yoClYFHeftYWI1M2C/VZSU
         XzBUT8bBr//ux/BWXEgwqFmSuTMV5gZyByLweitV3lzOft4R69cvh/RdxttQwgm4pjO1
         KiuakZFTYjX/y0EVttqkS336YAg6/p35hsAkKFjfXs87ODkLOHdmGR6DjPaKYGT/zKsw
         K58gU+JkYSmnWPCs6p9XZvmLNu81KZlnD9auBHyizoHXSjWHH3rKa6ZQwMagyu/l/qVi
         z8mIyKXqFOGw300U07G5nhNDcc26a5O+U+EDAqMaiOJR3uhdvwBikNs6Oe6JSJDu6TEW
         D+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761348751; x=1761953551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4r08lbVsQE0OD3LGzE40m+9+CVVkVezP7P3sn2U2T8=;
        b=tfLUupiivY4DHbZ2mndA3lcdmpjAQ9DPYFSWDX5+aP6XT1KhGCsX7Yzi1nGnaZHaJt
         TklmFR5D5GCgo851VAEmzG990XZH5Orvl6vDub1Sd2z8b9qTlDjPbxwkZyJ7/QdE/pZK
         FTuzF9LyP1WAuTOMflzRg19hGSX3ZnVrAba8okig9P450f14Tqr28M+irefwhEm8qcjJ
         Imy28ngdKVYF5+5jpWaAc8lcxijVg7Ld58VsJ+g1gtad1F8WzJlKEPP89E+KI4t+2Wrj
         7KzlwYoFrzGCNtZ7rpTSW6PY9R+gie+L5G2fELDI1JpIGkJZ9sIMdwvsfRHENNdx7McI
         9Pfg==
X-Forwarded-Encrypted: i=1; AJvYcCWayQSm02mjh2H9q7jhr3WN4VY4+cLbMoX9dOeOo8D5W2KkF3IhJa6Vh/0Zb1xVOfQvVQkNbWZkSB3LXAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVBQH1vpAEZi5S5pJ7YFSaydx4fVvRgpm/jylR95diws4vZgzp
	UUtzemhxwElRC26dnVBnj7B56XuarRlQoX4phzcW7S9PHfgDyban0xzgDBd/NAwxhQekO9ZqsdA
	vYx7Inj6rWwsuqA==
X-Google-Smtp-Source: AGHT+IGuDi8Lro6+irFVET2GS2b/HrG9TBMx5UeNAi9r+zStVMAINrU4nwULyXj+erM6/d4+A0kxh3I7rKXgfg==
X-Received: from wmwr28.prod.google.com ([2002:a05:600d:839c:b0:475:db8d:717c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a088:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-471178a6733mr190680415e9.14.1761348750964;
 Fri, 24 Oct 2025 16:32:30 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:32:30 +0000
In-Reply-To: <20251024223746.GTaPv_uiyc0wd1fPjV@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-1-2d861768041f@google.com> <20251024223746.GTaPv_uiyc0wd1fPjV@fat_crate.local>
X-Mailer: aerc 0.21.0
Message-ID: <DDQY0TEKY4MU.2MMSAEB8QQZ4S@google.com>
Subject: Re: [PATCH 01/21] x86/mm/asi: Add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
From: Brendan Jackman <jackmanb@google.com>
To: Borislav Petkov <bp@alien8.de>, Brendan Jackman <jackmanb@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, <peterz@infradead.org>, 
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>, 
	<akpm@linux-foundation.org>, <david@redhat.com>, <derkling@google.com>, 
	<junaids@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<reijiw@google.com>, <rientjes@google.com>, <rppt@kernel.org>, 
	<vbabka@suse.cz>, <x86@kernel.org>, <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri Oct 24, 2025 at 10:37 PM UTC, Borislav Petkov wrote:
> On Wed, Sep 24, 2025 at 02:59:36PM +0000, Brendan Jackman wrote:
>> This long awkward name is for consistency with
>> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.
>
> But why?
>
> I bet you someone will get confused and mean
> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION when she means
> CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION or vice versa due to the
> conglomerate of similar words.
>
> Now compare that to CONFIG_ASI! Wonderfully short and clear.
>
> Especially when the namespace already is "asi_" ...
>
> The only problem with ASI is it doesn't tell you what it is but you can look
> it up with simple grepping...
>
> I'd say.

Sure, CONFIG_ASI sounds great to me, if it sounds good to you :)

And yeah if someone doesn't know what ASI is, they probably don't know
what ADDRESS_SPACE_ISOLATION is either to be honest. The Kconfig file
has a nice place to document it.

