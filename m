Return-Path: <linux-kernel+bounces-767380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6CB25394
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DAB1C28837
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87035303C80;
	Wed, 13 Aug 2025 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQJvvckk"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF5C302CBF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111529; cv=none; b=mMT5H2speIxDcBUxRz4MCzp1S5C1ciR9JyKNPPkZBRYK3uul+uBVjwjvAPBsozazBG/4Xy+66Ov6Rwig7kLjgAZyRjIslrG3QWslD+heKYied9KSvDQIJ1XoRgjOVFQmPWEN9igIq6cb+NpyNict0ThxF070IctE3BV3gJZr8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111529; c=relaxed/simple;
	bh=YZYaje3uTeogrQvDi9KgjjqtvQ01p+kKmBxFAMHAT6c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nf9F8O6QIciB55Q4iaBS+4VapANYLVAMuWwMto9syA7ph9ucRAT+JS4UH5elCuFCatfrKy15xxKTZecc04WCqMiqw/ysCRQr3Y6YjHnd6d1/d2LOrVoF5XvBrwD2Y1hNFfOBR30yztdlmeHcHEGjzcJEsunmbqgrAoceEg5Nv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQJvvckk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603a9cfaso2145987b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755111525; x=1755716325; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ErXJd0vSKv5PIPRtkelRINjdCNBVARkoKSWpOpAGMuo=;
        b=hQJvvckkUKtkJDckOUq76l//V5zwNISueLBzCa0nN8kRlMIadwyqhbY9t9rAnRKeNM
         TRuZZUFaiv9YSCDnts3gI5S2GdeYh4slnIVnCugg9f5qkS9XFwVlRdi2zdCu5mLp5AvL
         ouGac6FQZ2oO5ZpfLy12aj5/CchHMRVrfjB/YayIDftthl+pkQFnNhqL49+JS/uDuYQK
         gxjjJndwip2s5rLV1zOWP6xNqxD9KnjIP95j+P2GCueCHCeQfAqkZEBVNmGlnlvLnZAh
         rBibdMyyMe+J56GquQDyjJmFdPxOmZphjBjTGfUH4/gggDgpp+6Lx6p0UTTxRKOVWREX
         i/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755111525; x=1755716325;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErXJd0vSKv5PIPRtkelRINjdCNBVARkoKSWpOpAGMuo=;
        b=gAzNRizterSUNnhfXR/aIm7rFxwMWx2eOlhuaGz/BYsylp4g09E/3cdGMFhHSFgbKd
         r3JVEDDAbFTZ5MlERgjGyYEMn52jcMM3GIz1GiQnDhZMR9Ovr6RFmGxYYLENJ+qlcn/1
         KoY95sHO+5t564fs7jURDBCRxu06M5abSiZPnzIsyRueICKlsLrGMUF4haSQ42kVGhyb
         e6KoDIngWq/ZcceWtary2fk2VNWNNKbQzfOpSzUNfuJtEAH7AlmgHQeRZzxKf9OBuSOu
         MGabXXPPVWevQCmiRvr+IznAD/fBAggbAwXETxVmlT15sSBlqA4hoiEsZSXJuq82R5fo
         LRww==
X-Forwarded-Encrypted: i=1; AJvYcCXYmJ7LCYyJjTmaavKWOz8BYisCC5cUpv6Wghe1v6RHOVCZHPR9G5oAfgZ6Hn7yI8FrO0AI9ierB5itvQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0YDQCUdGrm79T8SY7123xoNKbunO0Tc09l3GENHLFSVau7od
	eqjXm47dgRvQ1v9HSbal4tU6XBak0DfZZhSxqzn5bjmvI7VXOPrckZpcm5zAXktS7w==
X-Gm-Gg: ASbGnctLRpnTN8KWvsro24lvooobYKIxYCMgFTOJRQPmfCDuBnGOWnKby09mOJFmU5Y
	3o6Tj8XE3H2JGXIlV/FLIukqp1XezwfdjrP1kdyJCrmthMwamzRuE/ZF76innDyiij9hB5soTgb
	wS7CW9AZAtFou132araxuKsFCX1U/Rh31ltz4M6qOOtHH21xJOg+XL3A2CDdo3Ym8fAHjd1DCCP
	ENLKwlegir+2ryAzp+TwPa9fdNV03ibx5TKyrs9rLeZHyC+Vo0XEftd3B0EKWvJamrkG5hCk/Jb
	yKBSs8v2hvxoDihzo4WvtE+HU1Vc9oo8MTH+YY4rijCroN8GcJ4YG7Oe7xRhlCXihWUMxU8vdU3
	jTC0KYCqkVDaiTr3lcgA7/rfTaeS6FLw5cNDN3zP7sZP/NXjHmJa5/ohuCMiok2OxOnuzX80k8a
	gs/wxtVaCbeLqsh9vxSw==
X-Google-Smtp-Source: AGHT+IHmWCKebeCYcagzzC5EU9PLeskZg7d3tFyQeQvq8T7WEqyHz15NqNtOu+rYzodMCmCovveD5g==
X-Received: by 2002:a05:690c:708c:b0:71b:9c07:cfa7 with SMTP id 00721157ae682-71d4e5b2bfamr55195207b3.40.1755111525090;
        Wed, 13 Aug 2025 11:58:45 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d6107d1a0sm812637b3.76.2025.08.13.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:58:44 -0700 (PDT)
Date: Wed, 13 Aug 2025 11:58:32 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Chris Li <chrisl@kernel.org>
cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Chengming Zhou <chengming.zhou@linux.dev>, 
    David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
In-Reply-To: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
Message-ID: <2f75a76c-bdc1-6ca7-4438-21554831ec56@google.com>
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 13 Aug 2025, Chris Li wrote:
> 
> I know Hugh has some idea to store incompressible pages in the swap
> cache as well. Hugh?

No, I don't have any idea or plan to store incompressible pages in the
swap cache myself.  But yes, incompressible pages could well be "stored"
in the swap cache.

Hugh

