Return-Path: <linux-kernel+bounces-883509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E48C2DA17
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3948189B603
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE372264C8;
	Mon,  3 Nov 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cOd52XJR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B61A9F94
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193916; cv=none; b=iICJhMt/wti5CMC/xWB1WErbLbZPH+AcJd09ObQJ2wGy3QxHS6zWI4+GwNzAU4BMNL2Viqk/cXm/cAi/cc55rRdp3V80l2CUDn/C4/O8EONkQJdAqfrjgfcRpgC63YjuhVhQuztQaP+nCBxl1UtffZAVRvldHr/VfOn28b3hwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193916; c=relaxed/simple;
	bh=URXNs5NVV9mjyIjpTFJ2nbkM6xeZY0uxMOBeg6vFH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWAgLmNo049LJ9w4oFl4ri8VsUB9vb0Uwl/RzB2fMcNOz+KXc+Be5a43bID/479TSk7KrMvo7nD9BAxzQw1AajYY9LMct4gs+9wLZLnOG4g6KcgfsjVQQpB7BWYIAwCO6/6DG/CLhEJRZRwb1G+6THXOLF4/bTeo9EhNJGXn4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cOd52XJR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b4aed12cea3so855186166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762193913; x=1762798713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=cOd52XJRLZb8IO6129H4kd+jNXtLtqXDIfUbNyTnlPT621DrqSW7cJrsRhJOC1JjJ6
         7jRgw+h0rbmu3qfB++z+uE12q0QJeAOScF4U6tibhKHoiNRAyGUH8iMEl1qNXwHH5u4A
         U0eGwkOlgoXxkQDChytZV6mLW5IU5IwP18WLWLXidYJAN9NeF0b05PZkhe/zVVQAHFvP
         eGQxjXhNbhaR5TcrpQA2D6lF3jRerxH2CumgUjl8YgPKY1KIBVnI3pJREGDF8tejk72z
         HzaYuDkn0WLVvVBq8ndNJl5Cd7cGcQDTt1ZR71N4N3gMxTYT/msNy4ZEGIdsbrVcNyOj
         Jr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193913; x=1762798713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=OCG+UXioIH8pCyJHIZeWtQsAQ/Zo3oUGyNw8q51e6+S6NEGpcnVu+lGNqwsqmYAugT
         4yMHDrN/GtwdB1NQo13TYtrw5sfgz0RKjsyO9F7HA13utUv0AAZSsOoeZvCnvjwVU7GF
         BYG/M/nWB2RE/Ind5wHBgaDQF6aeAJJCsmSQCJjM0k/DP2X8JdjajtTFaIV4k6iTKmTc
         wbmQC4MWtiPqmkfZdkNbz3JjY9VpKT8Cl799ig700012ZP6Y3ks685qjpy/Cb2lM/Nk/
         qwMPmdSo6j6le+U8513S+mqLt0My2JRShXxA8DkGq+Tbh1NjVMMFznh5GcYK+wuKpQay
         FxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX8WgAQ7s84iS9zrFRss4lCLahwGa4vn3H98JLfg/2UUmQbF9q0a7c77Evd+CElODs6G2n5EUiItNx1EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvjO+aewvyBYZ1GhI/orQmbzHdBvP5TPZLNqmIXNf2u+dv++QZ
	o1Pjgr2t1TGsLo+8C0k/URG8T78kCyRk7DbFnWgBhPdY5z2Lt5XOf5D7xVUgZBZ43i9W9IglNQ0
	NjGv1OSQ=
X-Gm-Gg: ASbGncvxpQI74UUvw/DUvblwXKVs8xze7hdRNTH8SOi2R1kKcMa53wPv1B84UsH57u5
	7ZQBJgwgACg7oqof/Znp3o4N5S/zE59LV7QB4nZumheRaADu9ktJeZAFqY3bxw8LQ08jWrwdCYx
	ruWyMG6RFFdjnskzkasA7oI1a2RzkYVqe5Z7AnNx0wes4v3AI9mmZlZXh4NdszITdzQtiTJnDpq
	L+ik9rT5GWQqF4q1pz99+uSpLvPRi9NsrSa18X515N9t4fdPIj2l1evO/juM8UB0D/NCfN6Hynl
	7p5oy+urqUHDyqRNvN6x+2o4Rx5dkYlv8phZW01oMtI9kcy99AIgw2G9UaodaFeToUziBXIiIQn
	1OtbAODRXnG0vowriEE3kp0LL10KxEGt8RW+gwnqusAzCZao1WpdexSRpc0Xhbq9fzAb+vMz7p3
	iUVS/LmsHB2b/odA==
X-Google-Smtp-Source: AGHT+IE2daxTlMOHk/CGF2RugDrn4nke6v1czkbTOpjMgsbAikWRjv6WYKeA3oTiX78nZbbiTawnTw==
X-Received: by 2002:a17:906:6a21:b0:b6d:7d27:258b with SMTP id a640c23a62f3a-b70700d34b3mr1435687266b.12.1762193912944;
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm1093828666b.65.2025.11.03.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Date: Mon, 3 Nov 2025 19:18:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Message-ID: <aQjx91L6IlG-qtjX@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <aQSB-BgjKmSkrSO7@tiehlicka>
 <87ldkonoke.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkonoke.fsf@linux.dev>

On Sun 02-11-25 12:53:53, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> >> The second part is related to the fundamental question on when to
> >> declare the OOM event. It's a trade-off between the risk of
> >> unnecessary OOM kills and associated work losses and the risk of
> >> infinite trashing and effective soft lockups.  In the last few years
> >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> >> stalls. In this scenario the userspace daemon was supposed to handle
> >> the majority of OOMs, while the in-kernel OOM killer worked as the
> >> last resort measure to guarantee that the system would never deadlock
> >> on the memory. But this approach creates additional infrastructure
> >> churn: userspace OOM daemon is a separate entity which needs to be
> >> deployed, updated, monitored. A completely different pipeline needs to
> >> be built to monitor both types of OOM events and collect associated
> >> logs. A userspace daemon is more restricted in terms on what data is
> >> available to it. Implementing a daemon which can work reliably under a
> >> heavy memory pressure in the system is also tricky.
> >
> > I do not see this part addressed in the series. Am I just missing
> > something or this will follow up once the initial (plugging to the
> > existing OOM handling) is merged?
> 
> Did you receive patches 11-23?

OK, I found it. Patches 11-23 are threaded separately (patch 11
with Message-ID: <20251027232206.473085-1-roman.gushchin@linux.dev> doesn't
seem to have In-reply-to in header) and I have missed them previously. I
will have a look in upcoming days.


-- 
Michal Hocko
SUSE Labs

