Return-Path: <linux-kernel+bounces-864034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18749BF9C51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB4420113
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF71217733;
	Wed, 22 Oct 2025 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUjimvD7"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956720298D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101479; cv=none; b=lCP6S4af5uQK4n7JUqVoiY/KqViJ7gJNbm/79VeN01UdWt5WQc01RNOO188LJZ11uHX8m/a/FhQzxD83/6dRjKkcPCyoiAsLLc1p3kJ9FGUKawSZyVLO0AD7YSVW/6A0c3VsxfuUuOib7sDFWAban3S7NzsHB8NLiyQ1WX3hsCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101479; c=relaxed/simple;
	bh=DN2zzjuR1XBFiecBiRFeq+IT9NsiVCtgBLl23iLlhjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFyYfhT/46qC8duAKwL7mPoIeSWmuYFb3bN0KUxNkig3zkrJHCSmawcjBqeiC5PCpecoiaNEx3kYbXUOvqrNHhQzCfGQa91UH3JSadlhEgDTq7VYZvKU471Pp3JaYV5ehIaDzk7GVkQlxRQl+SWF67yklTa0MXneEFWU64x5l5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUjimvD7; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f79ae58f0so899836585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101477; x=1761706277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyhW697pM1Zdwkt3dzJURt6zsYm6OZUy7a/3856PR+s=;
        b=iUjimvD7u6MSMKejIaVDE/L0eo+gPeNWv3PPnY1iqpi+p37zO2oaIdybs/pQkVm5Wr
         A9GZc+BKC3XOcNTknH+6B35fEDjiCSdYzl20aORAYQH2LHbg3qPLfnzkXH1Sa/nkq0jf
         QiNHLOdU/hx8+o872gwQq38WA0IA9HaZaupslEAnbPR6qxfoBfYa+VinwiJM1PUdWo1x
         aUcfyssYMdns2xZbH53sgrI1ICZxtJ3J64JM3Yzn8DxYEOhjvsz8iT9MorGacJS0PdTU
         NfimfTkJkUBo5ORm9vSg4j5TzLsOXWVGBKJhO8e2sYGDOJwM6KvyekkyijzfuBt3Lid7
         FYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101477; x=1761706277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyhW697pM1Zdwkt3dzJURt6zsYm6OZUy7a/3856PR+s=;
        b=nGu1IEuuXK2sKCUiIIyIKaACWresKRh/7T+Lt/suRRC3zGLzeJ9+b+vNnWAH+ieRRv
         cMJ69qMA0gvk6uJ4H7GDLCXzH+negQJ68wlc2iLKZcmLz8uldGXQGcXTvZFx3MPogKrQ
         UBB36LUQfU6KdQRAW/+8YSMJvwIxvKC9NPtYQW7bwFxK9HAOoZeiAYrgtrFqbaWFAMER
         kUBBqUrnY9Q7QkvLAGhLE9PuLEJJ3N79pEIHYp7+bM+O10LqxadfK8B/xR/WgSPK0+76
         YeeroP8++9tkb9y//hmTXU3wMvDptTFZQNRoX2RrIRavQ59F+yr8399w6ozSv9hsGJ6r
         GLWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBomDVHmRll9TADPPIG5T4zVmwAbycMTFFvsIv1rB6W1b7XZCLa/9vmAE9bqkg0iiRccZ//a3CWoU++ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRu0Bm3DBGLJGp/hkOPRLwaaciaKNAsRac6URmZQNmr1JRaEkU
	muWE///gt6sbWt39gxkbN/uV+Ie2C92mLJvSzPkjLfD6TWX0iCllFXxU
X-Gm-Gg: ASbGncsM6GOlXkbtQjtziG/372d0Hs6WgHDHwTULIfCEMBMueGgocN5Ny4Mfosb5XzU
	/+Wbn0n1ZlOyZbwbpKetB4OIDBPPhKI0eE9obKyAOqEgG0wLaGm6ITLmTX3K6bkrLLeXSTHql3w
	Bbugmo9WC54OBz/bbyxjGZrBxBXR+CPcJBViT4EHthPQ8sp+pS4DDb/9N3yKuc8x017UUs1cTDm
	Cr+niyXxXRTa32BDYhdFTD/2CICYHjVCIvwUchzAx6PhZe1xU/o4JYWFOTxUuTib30Q8RMJXjXI
	Fk2bt6lTil3ViyOxLGQjGGttDM89qWb5BRDP9bTXjB/G9Dgofgi7vkd2zvEqs7I3d8Oj0FFzHTd
	jTq3qpleNhWkkBx9krSU9dhaXfMZdCRokeizfzsDftZrT6L4NIVA3iLt9A7jlKnxmaWb1G6iPZF
	m6p7wICekObFdEj7+LAC3dufstRq3kvooSfNueGDY7vs6PVvrv+DCGSyBfilYYUyur/fMdysy9a
	Son
X-Google-Smtp-Source: AGHT+IH76FHEmO22At9FXgcUJuu8my/jDBE2unDwsrmXoj8Aexa9wRTIw+yZ5wFWZlv6yISqjZiYrQ==
X-Received: by 2002:a05:622a:7505:b0:4e8:9d50:f751 with SMTP id d75a77b69052e-4e89d50f8b6mr172479011cf.60.1761101476654;
        Tue, 21 Oct 2025 19:51:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d611esm882004585a.11.2025.10.21.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:51:16 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id CE113F40066;
	Tue, 21 Oct 2025 22:51:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 22:51:15 -0400
X-ME-Sender: <xms:o0b4aDOFoTMqlXFTW_4S8zGXQ6pFKR73m_wKUoD91VzSFM7ZklL7CQ>
    <xme:o0b4aJzzptvvKw7KN1KJOuafCmtset7LZ8qFyXjNVSSuoEErFN4yDmh0j9ni90d7p
    Tb68hj6071MdvWQ6ryX3mXUg87t8Z5Na9BYYF2zEceekAHnxODPPw>
X-ME-Received: <xmr:o0b4aNoaFSm4dYbusiPo7dzShRFTIFwa4UIW0b9J3fK7MulSVkAByinDF39tpCILWzskiDAafoJ1QbZ3kkrnbmdI6Tp-2mgaFyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruhdprhgtphhtthhopehtgh
    hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtohepph
    gvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgr
    lhhmvghiuggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    nhgvgihtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhmrghurhgvrh
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:o0b4aBOIwnPC6jKnxdfYeMUHZytZ1Qw8nEOKNb2bL9GyoNCsVoYGGw>
    <xmx:o0b4aJeYI0KEZLf71lOqD8xYCDufDI8BMt_RzMUr1PzhC2uh_5Ro-Q>
    <xmx:o0b4aPVzcuwstMw_Z-hwuP-4XIaD6MCrOqgNfhLNy4cGW6cwJ5iyIw>
    <xmx:o0b4aCCLXqY5vaHc1fcKSck8AwA0p-EBhRmbKRO9dTbA9J8cu9-Ejw>
    <xmx:o0b4aC57KhuNHMyKLI77sYp8NT8r_tmFFBdtVpBm-UwfFz_YX9b3QQAD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 22:51:15 -0400 (EDT)
Date: Tue, 21 Oct 2025 22:51:15 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Matthew Maurer <mmaurer@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <aPhGo5WjbPM1Yu95@tardis-2.local>
References: <20251022114644.4437c2d9@canb.auug.org.au>
 <aPg_EnqRSqmFVdOX@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPg_EnqRSqmFVdOX@tardis-2.local>

On Tue, Oct 21, 2025 at 10:18:58PM -0400, Boqun Feng wrote:
> On Wed, Oct 22, 2025 at 11:46:44AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> 
> Hi Stephen,
> 
> Thanks for reporting this.
> 
> Cc Mathhew and Danilo,
> 

(now really Cc them...)

Regards,
Boqun

> > After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> > failed like this:
> > 
> > error[E0594]: cannot assign to data in dereference of `lock::Guard<'_, T, MutexBackend>`
> >   --> rust/kernel/debugfs/traits.rs:64:9
> >    |
> > 64 |         *self.lock() = val;
> >    |         ^^^^^^^^^^^^ cannot assign
> >    |
> >    = help: trait `DerefMut` is required to modify through a dereference, but it is not implemented for `lock::Guard<'_, T, MutexBackend>`
> > 
> 
> Could we make the `impl Reader` for `Mutex<T>` to bound where `T:
> Unpin`? Since `Mutex<T>` is structurally pinning `T`, you cannot use
> `*self.lock()` to overwrite `T` directly. And that'll fix this.
> 
> Thanks!
> 
> Regards,
> Boqun
> 
> > error: aborting due to 1 previous error
> > 
> > For more information about this error, try `rustc --explain E0594`.
> > 
> > Caused by commit
> > 
> >   da123f0ee40f ("rust: lock: guard: Add T: Unpin bound to DerefMut")
> > 
> > I have used the tip tree from next-20251021 for today.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 

