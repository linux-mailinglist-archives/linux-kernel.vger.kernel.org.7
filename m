Return-Path: <linux-kernel+bounces-764862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4DB2280A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95209681225
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED24267B02;
	Tue, 12 Aug 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Q60uJaTs"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BC13A3ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004155; cv=none; b=AkTw2UXAwRrIQGY955brT0KoFaAj88w3IqroQdGJB1Pb/QauOOfQC6STCGVZaWCpll7+afMUUOmrbKV/sRFgrP4yzoyZeM3fjD9X43ydM9gWT9UbNMLIlW0rxaM9/xcx7XQcgxaIwIwV5Uw7W9eX6J6UWQOYuo/LJ68IFTKJNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004155; c=relaxed/simple;
	bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sMrTDgr55RYfxauiDEBSe4/7hKwRLq8aOgGnREuC1De65afyMrSVduS6wvfJZagDTNiXKkLM9l2QGR6uk+y4L2a9h1B3EjoMpubL1PczVBz0UQ9ihzmnp+0lQf6lk8Mu+t8EwR6HzHrKWQyxISjegmGADbYqK+4DFZDEeSmvwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Q60uJaTs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9139aa446so34234f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755004150; x=1755608950; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
        b=Q60uJaTsOOF5ebIfW/00Rg/iFfp/UJrgpzi7fKjwp6OTaKkDLybCBw0oecXEA//Rp+
         OEhGcYLbgYkbIM3Jqdd4mWxKCBxkFpCG1laSD0Ws++cxWdon7EBiOWhUdlOpynHq+MJw
         FW1Xadq1WVL9LjDYEeJdAftoZBH5to/rZTxpgeifgSEqvdaOJC/yjeZpGUk48lB4IVbR
         BAEEnH7+gqXVnBBjJ4kOMSk4X34BVW79dYiOzTs+TxWDT5PeiZUfU8nDacTUFgmgsTta
         getoB0iBHzEY7ytHu6DFxcWuzzNNpccBdWZyeffW5MZEt4YlhZG3RpisIgbexcViP4oo
         lLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004150; x=1755608950;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MAomTme2JM325tkXeqcrCAovhqZxr09aQ6wqQb8gykQ=;
        b=nTguaVhlI2g2Q2fLTiRNk64SRGpf3Hfmdq+mZ88TMyzQXrrKh/p5pZrPr5TLlWWWBM
         sO65sHnW7mMRPDUANfiw6OOpYZV2WzCHGtPjQroFS/YvdI21x9x4Q+MsNX6hEGKRrbZ9
         iBq1KNr2v2AQdATZQ2d4G/4tcfUwZPSvietDNYomSsxLjBbPj1XDL8x7Qo982vxSlplE
         dRHWbo6UexcunLp0RY15yyMvQziF/KLDXczc6Gz/0IZujm+7LrBycGoFrrgD+uiropjt
         Hgurd6AkVne/wXRQUR0/tgC8jFUF8Km2RQBCUhM7EZ5i3vgg9RHeij1b284DPFc9g69V
         yDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBujhEI8uI4c8aWO8Rs7f5NErkNzSOpfCqXi6xjPtTotmiobX3elfwV+vNcZXwwPLZsQve1R7AhjAmvw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9gxGR/IuPHJQccgt8XcXtyEOchVv8gGbVkIS8g2z0t66hg2f
	+BvUhTvloqvG6ISqbmpupHOdFP4mSpy1CyaaUX6bw2uvL/yr2vFlU8ysG+1ypa9BDa0=
X-Gm-Gg: ASbGncsBf5KAc2rjqsUwAGnNBF3/IkcMiRVWx5jHdfwCUhR/PV2br4HmcfWAydkIIrG
	zFUq7yuRwgCbAw5KmuC1XA0Vt78rtpfGANxTd5eRM5uZkmW9wtALu6pMomkI/GVCJ8iqqap2nm7
	p0gsuE9l/Pwb9G4+i6+NOCnRp5OoaMe6FTNlklmrrr7Dil+4YG7KOWjYuQdFpKfgVuYb2Ebgt17
	AyNm4eGIBC5gjXGuNB7O/7c9upniBGbgQ9+a4oEk7VxiY/JgYBCj28DV+T9uUe00wPfc0K/pA8B
	n/7aCNLwHn2Xyw7Gv2cOy9oSKm6cfQxDPDZqqQv0mdzcv9bjDVEARDNy941DnTEzg3kuPr/n9Ff
	TZCUIvzHHZc7qO8jy1awBuoaxFZ7UPA==
X-Google-Smtp-Source: AGHT+IFCL0S2fG+7EvsWvlnJgkjJOc9wFOS6dc1oCWSwvbA7urqknr0ZeJjmy9NTqLN0RG30vSqL/A==
X-Received: by 2002:a05:6000:1785:b0:3b7:948a:137b with SMTP id ffacd0b85a97d-3b9147c2a32mr526638f8f.11.1755004150288;
        Tue, 12 Aug 2025 06:09:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c338c7dsm44458535f8f.0.2025.08.12.06.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 15:09:09 +0200
Message-Id: <DC0H1RZKZ3QR.82P8JXIL5NBJ@ventanamicro.com>
Subject: Re: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Ghiti" <alex@ghiti.fr>, <bpf@vger.kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
 <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>
In-Reply-To: <1fdaa939-d26c-454a-a722-7d0a590557b7@ghiti.fr>

2025-08-12T13:37:16+02:00, Alexandre Ghiti <alex@ghiti.fr>:
> @Radim: This is the third similar bug, did you check all assembly code=20
> (and bpf) to make sure we don't have anymore left or should I?

I looked at load/store instructions, including bpf, and focussed on
patterns where we access non-xlen sized data through an offset.

(Nothing else popped up, but I mostly used grep and cscope as I don't
 know of any semantic tool, so my confidence levels are low.)

