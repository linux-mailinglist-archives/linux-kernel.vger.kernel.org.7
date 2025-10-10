Return-Path: <linux-kernel+bounces-848626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58983BCE34A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AD8A4E2729
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D652FC039;
	Fri, 10 Oct 2025 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P0NnfzCZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7480604
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120389; cv=none; b=mqOonsMRBoKT01MKGWY6z51PPh0NVaYDvJmUcpovuBJiHBnkA8KCAt96jBnvbeTNN6O2Wg9egEyM/hkzcykyP45PJ9E0oJO1Mlh2Pgk49EyCNEvzacFqr6opyToxJ48oSTujGFyVXOg2z/hzDLMeNxEnqCtEG4ZrFxM1H1FLGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120389; c=relaxed/simple;
	bh=acDx0nyvp+3OykMR96RleXsZwlpne2xtgQWta7PccjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQZiazKQnKiGvBq/FhuwfZ1ZwpAtxyyBem3Bn4yDq6TSor9gKMI0TXKMz4ZzGuxZ/36XWtI13ElhMoaxwjV3pkIBr+7ecOvXnmD9zjwdSFR6PWogwJW1LapInIu7YjLZ576jzkXnpWREd6qYHjQz+rpRjcx5BNdbPlWzyfw3H2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P0NnfzCZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so4791365a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760120384; x=1760725184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtYw9/1ZQ3uipp0Y0zIYoTLP1DMnXdji2DF/XWunzC4=;
        b=P0NnfzCZOdUezKdV//Ed5jgQOuQu7u66L65PIf1QkVIecJyAhD3sJygLcdxIDa3UxF
         NLqYtczhqJf6Vfb7xz57sKQR8gSHpqNpH5aMd+3DBDggKzpZI6EittTOpl6CKqgx+3XW
         hcpWLQ5hYZCV5/xCcLtVDl6tXZbaItmrCyw54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120384; x=1760725184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtYw9/1ZQ3uipp0Y0zIYoTLP1DMnXdji2DF/XWunzC4=;
        b=OFecXxArzhMzSwxA45PNW1h6YXhyYHsYDJEcGnLTGXwS9G6XcCh0LSmX0e0XIg588y
         +yaMfbJrrOVCyuKTAtr+0M7FAtnUguuq83Sfx52minPMTc8s4Y9c+23rm/KfdwFiEVlL
         LdzwvtLYPCTki02kCaM4eUsq5VX87fW+cJWaBLlSBPteqvNOgYHGNM2gitSwwQtRbYvT
         DS27N8O2YGX/jhKC+6iWA8EDHa2nSYQjGhdGac/77qDNddYqlYPH8dSUKED6QHy5IORy
         1NTYRf9flFaGmXxCkLeH5VXC+TmOJbO1zYrw1e1caWk1+HH6OwB/cEn9UGAP881ttEDI
         h0jA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhcBlBg7u9coOIcsBzAx697wt/cLNrYuctVmD5xkS7hLCAvkPOwnO7EAmRF/Sj+msw1Ac5xh/LnIPBGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPzzUalIvVEUjwZ5p0Gx+FpHahB4UXigII0QjdiF1XfmnN7Jf
	wW4ZAhLyA78YmHyjSbp6jYUlmqaxCvHK2LZEXRgJ7ld+hDK8nAQWnpe1YbL3c0TH+wXRPqNRUIo
	QJeP7knI=
X-Gm-Gg: ASbGncs1vYZPR2KvyoWsj9wYD6APeITmRvVSuJwYNZEr+76M2nXPV2G6GwWsk7Gw0Oy
	tL69iz5MphNiXG6NdOIUw492ZxLwuu0Xnjm4ZkwfUYrMlFZyBKCebJsUlqZ22U5XTJ/klsmsG26
	ctaAuJbDGykCrWC5b3Hon+vthIHo/Gq9cCbSsDn/UwIzn/Nni0emAk73kbJsMd8acbkCEU5MtLZ
	rSlDWicKpokILPFioS7V/ZB8p+uA+NFo1SO7Db8kTXe0U9BCd7n9ny4nLzYpeX1Mf9XUfb4LJQH
	AshcT4gxXtNcAApYW+MzxyEMvu4ifveYZNplXDPDw/iGMGqr3ipshFCNqxwPRORrqixLu6vqYEw
	T/mEZWn2a9Vs661F53G2N5sHXoPMVNiIipDN0mSzvnooWnorr1sySisZNw3kOCaJkbE6811H54F
	dttKFDL9IZD0DEWuHnWJgMQe974Q==
X-Google-Smtp-Source: AGHT+IGKcr15nJ0jb/oXnftmwKG6/z8M5xL/SfrCBPaPSOIlTkz9qOHl3j6W0Ka9M8lP0Q4jL/S1Ow==
X-Received: by 2002:a17:907:2d1e:b0:b45:cd43:8a93 with SMTP id a640c23a62f3a-b50acb0e5a8mr1414611266b.62.1760120384501;
        Fri, 10 Oct 2025 11:19:44 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d69d1576sm288659866b.39.2025.10.10.11.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:19:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so4791317a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:19:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsNr7d1iUivAmWvU1XhiZsosureTr6HGoCVBry1Ny4iqjYmtWj4b9sSyvBogEZaUNWTNO+BwEoh7kEw8M=@vger.kernel.org
X-Received: by 2002:a05:6402:254a:b0:627:f3b4:c01a with SMTP id
 4fb4d7f45d1cf-639d5c3eda9mr11420050a12.17.1760120383286; Fri, 10 Oct 2025
 11:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010151116.GA436967@pauld.westford.csb>
In-Reply-To: <20251010151116.GA436967@pauld.westford.csb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 10 Oct 2025 11:19:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
X-Gm-Features: AS18NWCcawuE3ahEJ6Irfhp1eO5-4CLheHCfoCV_5jkFW9PMRtiY05LtiH4EJME
Message-ID: <CAHk-=wg1xK+Br=FJ5QipVhzCvq7uQVPt5Prze6HDhQQ=QD_BcQ@mail.gmail.com>
Subject: Re: Boot fails with 59faa4da7cd4 and 3accabda4da1
To: Phil Auld <pauld@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 08:11, Phil Auld <pauld@redhat.com> wrote:
>
> After several days of failed boots I've gotten it down to these two
> commits.
>
> 59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
> 3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache
>
> The first is such an early failure it's silent. With just 3acca I
> get :
>
> [    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
> [    9.348115] #PF: supervisor read access in kernel mode
> [    9.353264] #PF: error_code(0x0000) - not-present page
> [    9.358413] PGD 0 P4D 0
> [    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
> [    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
> [    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
> [    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
> [    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89

That decodes to

   0:           mov    0x10(%rsi),%rax
   4:           mov    0x8(%rsi),%rsi
   8:           test   %rax,%rax
   b:           je     0x18
   d:           mov    0x18(%rax),%ecx
  10:           test   %ecx,%ecx
  12:           jne    0xfd
  18:           movslq %gs:0x250eee4(%rip),%rax
  20:           mov    0xe0(%r14,%rax,8),%rax
  28:*          mov    0x40(%rax),%r13          <-- trapping instruction
  2c:           mov    %r13,%rdi
  2f:           call   0xffffffffffff81e4
  34:           mov    %rax,%rbp
  37:           test   %rax,%rax
  3a:           je     0x59

which is the code around that barn_replace_empty_sheaf() call.

In particular, the trapping instruction is from get_barn(), it's the "->barn" in

        return get_node(s, numa_mem_id())->barn;

so it looks like 'get_node()' is returning NULL here:

        return s->node[node];

That 0x250eee4(%rip) is from "get_node()" becoming

  18:           movslq  %gs:numa_node(%rip), %rax  # node
  20:           mov    0xe0(%r14,%rax,8),%rax # ->node[node]

instruction, and then that ->barn dereference is the trapping
instruction that tries to read node->barn:

  28:*          mov    0x40(%rax),%r13   # node->barn

but I did *not* look into why s->node[node] would be NULL.

Over to you Vlastimil,

            Linus

