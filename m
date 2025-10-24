Return-Path: <linux-kernel+bounces-869588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6062C083F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF37A188D279
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418E2FE595;
	Fri, 24 Oct 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqEiHaIk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA337160
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345149; cv=none; b=KGIrItmxLlR/2CoyCdqpQDzcRTwgOcUC1/iaoFJKtNZamUNUusSBghf/ehwJgKw+UzhIX2ijJ+VWaJInIhVBPSoT4R4WmsCRlFROqA4r6oC4nAqJYudCph5oM9vZ3vyMnO45ZZm4aZQj1/oLy3ctRZvkaTWL71cjFlrx/hqWTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345149; c=relaxed/simple;
	bh=HPGTvP3gKXChLNxuAJRLhDCCzuFV1GUXxkrKedc94G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJxUqoqN+l65jIYT0fSp210OqZsdkXKW+8OrauEvUOKGwbWSKnwe/+vYN2JLOu+S6Wbx9AlElmfsLtej5JxiG6Tgnba+Tfz5xunChWisIjy8WQVe+4h0CXTnX1o43XOoSV6wa5eIQ91L6sNx8yhH+3yCye+BZv5BjgiQ6u31JlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqEiHaIk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42557c5cedcso1818755f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345146; x=1761949946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=RqEiHaIkxFz9Dx8hDR1beXLBZi3UwdD1OJYyVxhZDz9vIru5gwYKv9U9fJBTJyxQ2w
         YGILFxPHHT+dlUOaapUAkra4JzA1coxO+OTExZcSHJHPaG7VKAvf6GttuA1DLQpFs2Ml
         NEFOI62dbzknzrmtW2duAvH7vTKJ/de6M9YDYfAbe6PTMuaxie6vF5PGlTmsj18AlTt5
         Vip+B/xdnXAA39jpd7oPGquJRFr0xDxp9ELyn9uUiH7hOH9Rhlx7USj8n4fo9QTgIk0m
         TndUnZ/3Qgis9gF+EiXqPrLse3HPJcHU9iuIYcUUsioQEVT1c4iUJ4g2FqBxNAmg1M71
         786A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345146; x=1761949946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=djnm3MA/6c3pVr4nCfPA9BBKISlhLxz+sV59kN64qn27iFRnTVa+n2wHCp7ijmbb/j
         a5c4sN11NlRrd74UeAVPqJ5gajoF7IDiTDaDFM8Tij7LCODb1QpMum37OfnnqWiviG+O
         1Ly7pp/+WdDV8HfRPp8gPwe9eF2yh2ZosYx5eCBHm6ZjRQ2kFF0CHpFZz3+7IXJpR8kO
         i7gnUV2hLWQBXE5U8GgBx5ZgO/FpmyLD1bxnF2iEVNhO6w2rIwoOAuua2nNgRQEiU38P
         8ckiJ/cSsJB8b+c+C9FY55iEfFfOvjHgYhCyvQfJAq/wZMCeJnu2YhNbjJJtKIUVrZtc
         zHUw==
X-Forwarded-Encrypted: i=1; AJvYcCURo/DC3Y81RnV3KjCrBsTS8d3SzM7hwAMDKRNDHNSbEqolqCt7zXckyS9LrS8VwINZS9qOB/tgDkg8osY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/i2A933Kse5Tmin/qXTCd8xY1sPFBA2iAPmP7TqpdZNsMCcDM
	KqRaFOIFqEsGshGaC3SODtHmBJkuC/5clRw3lyV2z3Y9k/gq8UYwgZ62IyBPmdvttRGjMcsN670
	4xyqagi2ibTMSXdrH3F8s0l8/2pJInDI=
X-Gm-Gg: ASbGncvzZwblKA4GdHFS4pdk0lI90tEHivhm6M9t9N1XWHODRKaZv40ZCjSAKoiFUcB
	ACihopXzSYAUpENv3kDYwsT96Xv3yMh7b9HV3X2SkOCbOdm/o+Uucw1V3ZL4fqGNDmGdoENtQeG
	ED+7ogm+WW1SsVF8ng2TEWHNJmkYpFkm8TDRjMxgHyl+AG4la25pNC4lHsAPisAD3Ks+iuYobF8
	OEhcgE8eStmOl78ydjcfnllP5BDrSxhNhYDTFB/biWeRMwC5I5jRDthJUfHnUue0iAZ+JVrAggI
	ke9nCHcPyVrJYof5EQ==
X-Google-Smtp-Source: AGHT+IEk6kGBtRPTTE7UK+dCfFed6KOoSdQT4rrIfK18Wcd+iW19phRfPOMaAHllUvSpuZUGkBdwBVCywmTCWEggRpM=
X-Received: by 2002:a05:6000:200c:b0:428:3ef4:9a10 with SMTP id
 ffacd0b85a97d-4283ef49ddamr18538286f8f.54.1761345146453; Fri, 24 Oct 2025
 15:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:32:14 -0700
X-Gm-Features: AWmQ_bmYxy3mKLZGuaPpnI1v7zjS22cZzV3kwSBj_coWNlSrdgc_1YOXiQjgS1Y
Message-ID: <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> @@ -6444,8 +6316,13 @@ void kfree_nolock(const void *object)
>          * since kasan quarantine takes locks and not supported from NMI.
>          */
>         kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> +       /*
> +        * __slab_free() can locklessly cmpxchg16 into a slab, but then i=
t might
> +        * need to take spin_lock for further processing.
> +        * Avoid the complexity and simply add to a deferred list.
> +        */
>         if (!free_to_pcs(s, x, false))
> -               do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +               defer_free(s, x);

That should be rare, right?
free_to_pcs() should have good chances to succeed,
and pcs->spare should be there for kmalloc sheaves?
So trylock failure due to contention in barn_get_empty_sheaf()
and in barn_replace_full_sheaf() should be rare.

But needs to be benchmarked, of course.
The current fast path cmpxchg16 in !RT is very reliable
in my tests. Hopefully this doesn't regress.

