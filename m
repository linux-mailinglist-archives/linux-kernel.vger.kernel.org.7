Return-Path: <linux-kernel+bounces-753597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8FB18514
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DA118860C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7932727EA;
	Fri,  1 Aug 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOIP77NF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1418BC3B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062512; cv=none; b=O5bvuJ9GQSNCOR9UhQGhXB7v5aCptvySp8Rt9JDAezv4Psxc3KTKmsvhF5uBQyLjd28kT9sNK3VbiIHecHutV6Gc4ymH8WmxIYdN1uAHMJHzfMWD8T9ks1DsN116Ymfw0xNmLz+WnHD3nk6U9Xs9RGH293MsvDPCu6SJaRzM43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062512; c=relaxed/simple;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgpEDY+Tq9AHUl/TS3enNj3VrjP4k+I+kbZnV0bMc+0yxQKEL3hzP+o72+R1Qu5vluk/mrBNa+e1fdmiQaRZ40YXVz6q+Js5+eKPz8Jobuyu6VSEC5AAEXqsIC/RUj4/DyVpD0aov2mM/f6pA+0VHYV4mt1qA9Hz3ii55Y29/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOIP77NF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754062510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
	b=YOIP77NF7lazTK/RehrrpO2QcQJxkYt687yj3WIwODxSyom4Ig2vTEH/CpFgO/pLWoBR3W
	OXgQupzcxwutznlvlYUhLRwWWKLtHerIv0c/WEt6YdYVskDQNFzhDcvBNc1H2fNa4q5QyC
	LIHkU2k/VpVSe/Z0l0lPeMbQId6rTIY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-VsWbN5TMO6qeVMwESP2PnA-1; Fri, 01 Aug 2025 11:35:04 -0400
X-MC-Unique: VsWbN5TMO6qeVMwESP2PnA-1
X-Mimecast-MFC-AGG-ID: VsWbN5TMO6qeVMwESP2PnA_1754062503
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af911f05997so155847366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062503; x=1754667303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t7pavYnxvZ2zr+sT6EoGPHPeQNdp+X8VdJPWKkQuPc=;
        b=Wd2F2ek6N4tUCyG99b9VqQKNr6mwSZ0L/Mwl5z8EMyAz19KqEKdwkF1WaLvIYnzGWk
         p0cjyN8VNVsSrk4G1trVs1J7cBhkzU4ekG/N+oO4nt1ycG/lUZ354B7cfiSoSxnQFSSw
         R7ZzS7CGlwJLJ6tKmI6bX7Po1edh5AmCQ8jAZmL42GlWf85HBbrf7HiKVOTthLQUuMr/
         5YLhe74nHN/J6wnW8Oas7sSVFj6uA4BCtMm6sRFvkPa1KTgxtI/s7y0PjEn82V90dMf8
         ZPM9u2CtJ7oiJI08294655weLRNwDrL20PbhH4FWyaCwkXsEjFfUhEQ9IYSc8B4gSwQU
         Usvw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QUy602J72055o/Ve8uAjHK5YsDizP52r0hyRp5T4aRxUavSnfM+7Yv/x9iIllh828RdoOSRH0mykNsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXsyEHS129GC+2fpSxEQiQvgCN+g/33MFFPV6Ww7cHEDp5O5ef
	amboXdfhtvLr4inrKs+OA1hohiTzYv2SbruenHmHKVzMnlAw97nA1AOjF4tSmLX/K1/wKSWtoDX
	U9lF4iB3GKOEYECJyOHrQmwyp9hi5AfWQ7yT/SKDuMudTZYBQAnXI/PhY/Nocn7WYOkwZkwuaEN
	ZlA87HdEJw8cs60aKcK8vxjOHPv8zVofN0nn2n3oojfXObqmMO
X-Gm-Gg: ASbGncvSLyHyzpX609b0rPZilI3kES/ostbjx07dovgRTBkLnHUmjs/VFjtEaeiucZd
	bISPmu4nnJ5fEnxzLW0dQDpFclScvMycK0zg3yJF1PkvaxovN1Pg0Z/JidFu7zRkIw2OMtNcRns
	7t/yr405eIKUNqQ66ZM/x5G3rQP22woTMDpqcVGCuYClwSu1IhMbs=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id a640c23a62f3a-af94022bd18mr24177466b.56.1754062502697;
        Fri, 01 Aug 2025 08:35:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffcQ80umUTy89ebwr2s4PAM6/RBBB8AMdwFz4nIXXP4EkDzw5biAznHDWzpfhf0kLY0g1Q4rSu75I/gxLePE=
X-Received: by 2002:a17:907:9455:b0:ae6:dd93:d7d1 with SMTP id
 a640c23a62f3a-af94022bd18mr24173766b.56.1754062502265; Fri, 01 Aug 2025
 08:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
In-Reply-To: <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:34:51 +0200
X-Gm-Features: Ac12FXxzpQTuJoSDpFwJ5S798l7k_pWSubckc5Xl8rkjsWL2kupB9MLIkTqSUgE
Message-ID: <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:29 odes=C3=ADlatel Alexei Starovoitov
<alexei.starovoitov@gmail.com> napsal:
>
> but __free() is imo garbage. It's essence of what's wrong with C++
>

Here, you at least can read the beginning of the function though, and
see that a free will be done at the end, like Go's defer, right?


