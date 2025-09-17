Return-Path: <linux-kernel+bounces-821802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC1B82525
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4238248195F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294F27FB03;
	Wed, 17 Sep 2025 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov1GnA9L"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38C1F462D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758153048; cv=none; b=gTWeHcVTcoxf3tddAkDmTGnR4csJ0GACf/9rubmZnTqR/FSQQAaPnXaNMeUVVowSl7o9HtkFQHz9+iYGTcYLReB7x6KM5QHF2iGu2ImlTF2mlWRAXtnjy/gNXxjt57wcrnf+HU1P2zuBEFHdeIyKkycBMDvWWSk66KvLyN3vOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758153048; c=relaxed/simple;
	bh=H9+O1OqYBXulm61p1ERwP1q/meGeBE4HmC2D5TX8SAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi9sn+7Pn4fqSplhbVpPbMxi9AeepPR2IjeqVxjXVQF87veRMuOCsQdA6IxHLSjr6W97qpdzBS8sSBlveTy0jCCyr5iS2NIGPf2VFn7zZ6FNgTOD8RgHvCY+W9bJbifDps86WCYnP0ZtSpFDVZ3n27JBMN7e8FyEgYCFqnuWTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov1GnA9L; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-807e414bf03so50446385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758153046; x=1758757846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9+O1OqYBXulm61p1ERwP1q/meGeBE4HmC2D5TX8SAc=;
        b=Ov1GnA9LhAMOcrIOfY08drGThj++0cn5qWBLS4hZCVFHeMgvCBKQSyGfYOqhBoXB7g
         f8tobc8x69HEwt+sGx1xLHy2gzJmzv/KFntGiqDJqFlJlJ8dEmVsbcrRFg/knI8zNh/D
         B03y5RodiE4CepttfxKScstl2OkdG5oXLYdNWbFLbXHWYhAH6BDtc4RT7nAMQ5tmEg7c
         Dvvab1IRusUeGuUzW62IXO865v6wroAyUVSid6y+Vb8q/7sAXk9CxbYWYJcLZf7euzZC
         sSYS3UPNQaEqRVWbGy4Tixs9ma0ldtxb/pz3/d35UJBSw6azgq3UlNKiIWSAIB1EqV0f
         jD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758153046; x=1758757846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9+O1OqYBXulm61p1ERwP1q/meGeBE4HmC2D5TX8SAc=;
        b=Z9sAgHgapC4uQCCk+bz5vcftFeAR06PW5LwKqMwaMMr6LJLVmnJaPRd1QcGMbA6DwC
         y4cTLyouNC7fEoqvfosUt35oApW8wEITa0tApS3D3AlSNPQd+CM6CuKQVHByQNOGa3VM
         2T0ZsIIzqtA/B86iGKUcv/jFKzD4V5EiInAjoyssmzoemwG+CHEHEP2ux+fVtt4hBzlC
         aT1KnM1Po0igByAgRcvscWKKaSwsz4rADVG66ACIL36Q3b74S97ee6PXpT8wsftWz4Ik
         DT5U0B97+ss+3Ohtb+TQgg4dxKRTBz3l9PsbYAeZWyj+6rfQGG9riHStH7v1dHpcChSY
         dfww==
X-Forwarded-Encrypted: i=1; AJvYcCXp+32Z7w2Cb3SVAqDRkwyZGUPf25iBP3w8+j0HYkiAwjbWMpeqnDfPvjkqDPwVmc3+IgJ1Bl3FJoubx2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuFvDEiiX1+MDUww7rIiV0s34yK00Z06voKd3Hs6JUiUwM9vX
	L57AEsXDX5LP/RHRSzj6GG+JxjN2bXID5sepIRHLMauuGUSfnkCCkg4ZrtHCqScvhyUsctiSNYV
	Q9zrEPvP76d1KSzVq6xI2xiZBi2OwH1c=
X-Gm-Gg: ASbGncv/sfU/Ixy+VXwt3pHhCwVe1wcBYKB1it5u+8/gHxHF5dwHecvbgblMsl+Oek2
	SSQlrdGlJu+9rEVdzz+H2v9DV245/GM45BSnsLZTw9vvkeX/n+RgZXFFZWnbcBPMTfitTdWJYWP
	sDZFauwhScYjy1LD3uqxdiBcLXAOJFiEhtHhhSVRED9JTJrRKAyA6yvDA4IMYuYTLkEUwOeCwpq
	WFuWeUrmSlOfYcLxX6tNX1LNc6YEN2/wT1lghyYiOLy6rzb7duXZwsmLlBjrkKdME64aZA=
X-Google-Smtp-Source: AGHT+IFJL2CJP3uAzbra1ybzJTukuqDvEDP7eQvl2rLg43pEVlZyTdk5GR3/awpXrLF8fxzamaO6EK4oI+hndM5gC/Q=
X-Received: by 2002:a05:620a:46a4:b0:815:630d:2cbd with SMTP id
 af79cd13be357-831096e9fc5mr440866485a.34.1758153046104; Wed, 17 Sep 2025
 16:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com> <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
In-Reply-To: <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Sep 2025 07:50:34 +0800
X-Gm-Features: AS18NWASEv1_Mi_lbIVC978vKQXdnz7rSZ51ahk117211gXUBICfxJ64AqF1yvM
Message-ID: <CAGsJ_4xTPJo7+kCkkiZhn8b7xjH7yXeJ2XPoXeoJm+XwJB_o9A@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

> Perhaps you could describe the swap table as similar to a PTE page table
> representing the swap cache mapping.
> That is correct for most 32-bit and 64-bit systems,
> but not for every machine.
>
> The only exception is a 32-bit system with a 64-bit physical address
> (Large Physical Address Extension, LPAE), which uses a 4 KB PTE table
> but a 2 KB swap table because the pointer is 32 bit while each page
> table entry is 64 bit.
>
> Maybe we can simply say that the number of entries in the swap table
> is the same as in a PTE page table?

BTW, as Kairui mentioned, you plan to store the PFN instead of a
pointer in phase 2.

I wonder whether we need to switch to atomic64_t on systems where the
physical address is 64 bit but the virtual address is 32 bit :-)

Thanks
Barry

