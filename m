Return-Path: <linux-kernel+bounces-894987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98F5C4CA36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E933A3A43
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB002DC35C;
	Tue, 11 Nov 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6McQrtI"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722D2EDD69
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852999; cv=none; b=G9Sd8j5dvoi4SZ5483ZpDGKZqRhUlPaX8CLLIyiZilc/ETIX3VK7qPz56jgARmi5T+4+wYKlspn6RaIG8SBdD8ArhARiZmAY9P2S0r0Pw3IYpv0lGgpBi3asrT2fwAl+z11IyEgdggqAObrKh3pWY4Af0JLraH6dj59SKu+N3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852999; c=relaxed/simple;
	bh=HW+BHIjHuyTX7OAC9AGqEECbSB0U1bNiaGYXhX8ud1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvxBxbuqu6+sUgYTt1txgSASXRshUU7eCdIWa9FCpL8bkz11sfShUUwju2+vPxJLEtldN2ZRnc0RnKXzZfGEp1+FtHNCxbUcEz2qgieU2p3MYa85tLeYYIbuwhhU6IOqIuJUOYA2Y3o5OV4lRWN/j2nuuLOsysOABy4G2fPXkqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6McQrtI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8823e39c581so33186806d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762852995; x=1763457795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HW+BHIjHuyTX7OAC9AGqEECbSB0U1bNiaGYXhX8ud1c=;
        b=G6McQrtIGCYwTv+qtUcpdpxsjOBOcbABhj3mgP1FPSF14qzrygXKRbZTfaBEW1QzXQ
         ptH3Eoj5bvdZcC09088K3MdhmAm625hZkmlu2ZALnmSVy4Nj5f7ioO62gatl2JkW9p+W
         1jXtM3MUjuew7NAMzeHrmR5t6sLAZhIM74qWg8gr8IbF7E187Ihj3yweySyWKcSoozT2
         Qnr99/VkuaRdBbh87x0j6Wx9VgMiDxfw9FmZloB2G/hux46/1UwpN2sZ07OD2gd5aO24
         uCD6TXHOo5Abh9hjV0RZtuvY9Juht4VuhNxS/8hC0bNGMpOc949ynwkIGYpllJ/GiXi7
         +Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852995; x=1763457795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW+BHIjHuyTX7OAC9AGqEECbSB0U1bNiaGYXhX8ud1c=;
        b=pZ/s+xlk1ZLNaQqOi5oZ1nnb6Q6SSbN5Lo3d4S8TrOvU+qqI800IpA+2l9hZNVXxas
         xP7slGifwnEDf6Qb3etj4uiLUB8gr9Nmix+flUrFOqU0x2DNUS9oQj6R6j/KHyiHpVT2
         xawbyqtGksBDZ/VlBXwdTy6OItViabX8IUOiTkiMua7K4soy0kFfEkO6uTh80BcC0OaU
         pqzf+bHI/EuAly/t3F/5i81TsbieKUv4+bBblrw1A6mNIJqIaHX3qPYTm1JH30gtGcpi
         fGhYsBR2wdcKI7Q1OGjlIH9SWNfCWk2z5GGomSx/xW24uCAjIcDs7VLg8lBtFx7CIbSp
         ZGXw==
X-Forwarded-Encrypted: i=1; AJvYcCVzC0K26MUmezOOALpL9ttEVI8kCjFFnPtDiN+5jg/DEnWDDCorUOyBHS9NxjrEPOYsaEohgPRDEjmBv84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTgpPXjuDlSkZO2wKZzE2ghux58UcUI4mTBkfkAIrARKGhTX7T
	cdVWHWVEJY4ocHNY4i1qaSCBGNPcRYDYCgn0XJ1Y9uAGOtsiQpqrhS+wzUgy3am9xPUuGXE2T08
	4efSS64Owk7u3QzcXdIRxXzkeH0lThGq7yDXFuuYO
X-Gm-Gg: ASbGncuRmi+UcPPvB4Wxr/vTlXxfeF0TqYyioOvQW++ItFkAXJax0x6TJ8uLhrj+Kyf
	CeducPa97PY5sqkxvnwCQ1PkVmeNCSYl1QvjceR14v2Zh61DYz/NCo1rnEFt9wlgpY3I4Tcy076
	jBR1Kt79ot0L7win2va6Bn6Cki1Xdx4jErfoVJqcdZFVCCj8CHhX91RwXDrF6Q1UH6ymB0crFmf
	5NfmHrpjiBeo3fjkzw/BmioAdi+BCVD2TU4+yyEje3vmt+O31Q2mSsl7lsegMTZ/137Cv3wzgLv
	3X+YkfO+TRtYVxuqg8U5Czj7pw==
X-Google-Smtp-Source: AGHT+IE0yzs57LETS85djEZyTYXW5DmddvlcMHLtxP59+D7EFGLVQ5m9xCUc4smiAAZV+t8Cn2za8HGBMs1SjTj1Y9o=
X-Received: by 2002:a05:6214:1310:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-8823873d584mr174202246d6.34.1762852994390; Tue, 11 Nov 2025
 01:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761763681.git.m.wieczorretman@pm.me> <8681ee6683b1c65a1d5d65f21c66e63378806ba0.1761763681.git.m.wieczorretman@pm.me>
In-Reply-To: <8681ee6683b1c65a1d5d65f21c66e63378806ba0.1761763681.git.m.wieczorretman@pm.me>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Nov 2025 10:22:37 +0100
X-Gm-Features: AWmQ_bn-gtNt_PIr26xFMqgMDiPlRCOzgcJVubPfw4RNrG4hXg8UIUOVQ0zkb_Q
Message-ID: <CAG_fn=V46UeEvrPb01VRk+60-wL0DA6Y6ZD5HAfVLzHcgRh+VQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/18] kasan: Fix inline mode for x86 tag-based mode
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: xin@zytor.com, peterz@infradead.org, kaleshsingh@google.com, 
	kbingham@kernel.org, akpm@linux-foundation.org, nathan@kernel.org, 
	ryabinin.a.a@gmail.com, dave.hansen@linux.intel.com, bp@alien8.de, 
	morbo@google.com, jeremy.linton@arm.com, smostafa@google.com, kees@kernel.org, 
	baohua@kernel.org, vbabka@suse.cz, justinstitt@google.com, 
	wangkefeng.wang@huawei.com, leitao@debian.org, jan.kiszka@siemens.com, 
	fujita.tomonori@gmail.com, hpa@zytor.com, urezki@gmail.com, ubizjak@gmail.com, 
	ada.coupriediaz@arm.com, nick.desaulniers+lkml@gmail.com, ojeda@kernel.org, 
	brgerst@gmail.com, elver@google.com, pankaj.gupta@amd.com, 
	mark.rutland@arm.com, trintaeoitogc@gmail.com, jpoimboe@kernel.org, 
	thuth@redhat.com, pasha.tatashin@soleen.com, dvyukov@google.com, 
	jhubbard@nvidia.com, catalin.marinas@arm.com, yeoreum.yun@arm.com, 
	mhocko@suse.com, lorenzo.stoakes@oracle.com, samuel.holland@sifive.com, 
	vincenzo.frascino@arm.com, bigeasy@linutronix.de, surenb@google.com, 
	ardb@kernel.org, Liam.Howlett@oracle.com, nicolas.schier@linux.dev, 
	ziy@nvidia.com, kas@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	broonie@kernel.org, corbet@lwn.net, andreyknvl@gmail.com, 
	maciej.wieczor-retman@intel.com, david@redhat.com, maz@kernel.org, 
	rppt@kernel.org, will@kernel.org, luto@kernel.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-kbuild@vger.kernel.org, linux-mm@kvack.org, 
	llvm@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Explicitly zero out hwasan-instrument-with-calls when enabling inline
> mode in tag-based KASAN.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

