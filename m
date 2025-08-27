Return-Path: <linux-kernel+bounces-788361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A1B3835E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4477B7EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAC350835;
	Wed, 27 Aug 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Tvr0mgAA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED127F015
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300038; cv=none; b=FSaXgUZPaP2h8UTdEGuKbXE6PdBn6clk/Q7rKm7wjf1pkqkBp7Bqmr9+Sq85VWacRwtGQQD5m9D4FXrbGhPNAk0G9NwRNjUsYPbgNhk+6TmnOmnmGG2rFybunJylYWRptzdp8mzzjxXKH0Zw6kNGrj0dmd72Znv08EYrNG2PocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300038; c=relaxed/simple;
	bh=r46sxghsdUJZJ6GLwvQoKgsx8dPdky40SaTysjkFops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYITGUOIoQH9bVWQKhWfXoi9srzHvg/ragFWKFppIWtzH/HJPXO6wnQJe2s+lXxoqwtyt/MWPfbv7AZu+G8zRnSUfsfxKWEtw+xyv99gGfzDYUf4AqG3nR1R1ExBrAbuA1yB61NVxQlMV4A3i6w/YmLIlnVJH0ciXulr7Lnin7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Tvr0mgAA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1abf5466so5938605e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756300034; x=1756904834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dF5o810a7PTnN/8SbUBia77j9hgRZWPVI3vIEvBDyv8=;
        b=Tvr0mgAAOsPnBkFSDunMF0Mv2nZW974WfrdBZjZpk7KsAARyzF5igmsZqaVcboL1pA
         dpqvKZrZI7KSfdyVjSZir97vfyU8+Wi4LsgXQwBX9afwVlAj3Zl+9U94VoB6p3/eLv1t
         /z3IUAt7049ce12gYG01Tyu4QtlY49TRi0LiAR6bWR4Ue+s6eG+Lk2p2QOms+fPvLU1x
         VYr7fnWprmEKCfmk0pzkHwvbslN748dEP2Ucv5lua8HTkj4jQ78tPYPMn7IdiXWPFXzB
         KW4cM/zrP1cRQ7yzQwVmGXQU0nPX2hwP2isXP/mxxmUiww+3YaFfZewDdoRRC5oFR62P
         /cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300034; x=1756904834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF5o810a7PTnN/8SbUBia77j9hgRZWPVI3vIEvBDyv8=;
        b=AnDtt66PhMAV9/ROE15lshN4PUa86pHD4lcX+R8wP8wuMUp740BifGBPCWsoUc6lKT
         RhFKk1bRLITx8U+Ykrc64AhbIIDLZZt0WE9pLSdB3Gn/ExyhGkGa/n+jHXNHfQFH1Vsm
         OSz1DbjhN9BhS7b1zOxpkC/ZOjk4leY9Ha4fmEzTGrJpmImYmmp6UlN7WkeS9caTeJdl
         hMHOgtfM/tCy1z1QS68uAzbg7gOcUSARVCxW7ZCtUPDNyVnquxmyYQOoRguZ+oS9E0Yl
         h2KqhIc3e0G5qgo1ead97/eTwM+7mUVLl0I0zOh9ZtlNHV+Wqx2x3A+4JPxqZkYSn+ah
         9YcA==
X-Forwarded-Encrypted: i=1; AJvYcCXrab9C8C2OvJ3XPsyzEZRo49c1BMvqmuAMEaKzbZPpmZf75b21wENj+cMAmj7oJ6SAelma7jIXbJUw9nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGqETCoVpCUgN2nszRvhA61+4fZ0xivakGvHbJSmarQGODu9I
	DP/xUGTrvlots0hwfMkKtczpGQlrLlHxiDHbpApzXGQW5PK2xTbFSIFWQMoYsOoLSno=
X-Gm-Gg: ASbGnctslp02/Knz8crtiwvCt85gD8UpyTQmKHzcwh2gJrJeyhOOdMi2AHRwA32Gyxb
	PSwS6E+gFlhYaZqNYgNNa7BAil2wxCHZQ1c9RqfDWNyjyW6XG307f2E3JLtWjyiPCZntk516Qg6
	jmfw0qbNhmU1EoTl9exgO6Bbn8sTel0iwQ4PiEGMxSJISr68V7Yvci8NEL2ZwNF4Gb3Vf3IyaKB
	czaoiRvvXXJXAfAQzLnlJRASeE9aSFiVz7ezIDP5Davt13zgMcqCR8jSpWqd3smPk63UZFk2rV7
	CDTIFNyybCB4v+1I7hn8NDZz9apeFzDYiW2oePCRmEj4OiMFSMwGHpx5p/YeVUmJx5rM/NSucOy
	EDa2kFdGdr44Ty78=
X-Google-Smtp-Source: AGHT+IHP5mFK9hwcrvF5KKKcJ/uDrEKW0UmrkI7N5sUM5zs07mDFAfytcdN1ohOxsnSGj6LjjgrjMA==
X-Received: by 2002:a05:600c:1ca6:b0:456:2139:456a with SMTP id 5b1f17b1804b1-45b697f4b48mr42946795e9.15.1756300033643;
        Wed, 27 Aug 2025 06:07:13 -0700 (PDT)
Received: from localhost ([2620:10d:c092:600::1:9e53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c70e4ba1eesm21772390f8f.2.2025.08.27.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:07:12 -0700 (PDT)
Date: Wed, 27 Aug 2025 14:07:05 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
Message-ID: <20250827130705.GA7480@cmpxchg.org>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250826124454.GA1502@cmpxchg.org>
 <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CB3E7E9C-2192-4C60-B79A-932AD6CB005A@konsulko.se>

On Tue, Aug 26, 2025 at 04:56:46PM +0200, Vitaly Wool wrote:
> 
> 
> > On Aug 26, 2025, at 2:44 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > On Sat, Aug 23, 2025 at 03:04:19PM +0200, Vitaly Wool wrote:
> >> Zpool is a common frontend for memory storage pool implementations.
> >> These pools are typically used to store compressed memory objects,
> >> e. g. for Zswap, the lightweight compressed cache for swap pages.
> >> 
> >> This patch provides the interface to use Zpool in Rust kernel code,
> >> thus enabling Rust implementations of Zpool allocators for Zswap.
> > 
> > The zpool indirection is on its way out.
> > 
> > When you submitted an alternate allocator backend recently, the
> > resounding feedback from the zswap maintainers was that improvements
> > should happen to zsmalloc incrementally. It is a lot of code and has a
> > lot of features that go beyond allocation strategy. We do not want to
> > fork it and fragment this space again with niche, incomplete backends.
> > 
> > It's frustrating that you not only ignored this, but then went ahead
> > and made other people invest their time and effort into this as well.
> > 
> 
> I don’t think we have a consensus on that.
> 
> And zblock is, after some additional improvements, just better than
> zsmalloc in all meaningful aspects, let alone the simplicity. It is
> fas easier to implement in Rust than zsmalloc, too. Besides, zram is
> a good candidate to be rewritten in Rust as well and after that is
> done, zblock will be even safer and faster. So while not being
> “incomplete", it’s zsmalloc that is becoming a niche backend moving
> forward, and I would argue that it could make more sense to
> eventually obsolete *it* rather than the zpool API.

That's your opinion, and I disagree with all of these claims. I would
also be surprised if you found much alignment on this with the other
folks who develop and use these features on a daily basis.

That being said, by all means, you can propose alternate
allocators. But you don't need the zpool API for that. Just provide
alternate implementations of the "zs_*" API and make it compile-time
selectable.

As it stands, it's hard to justify the almost 700 lines of code to
support *runtime-switching* of zswap backends when there is only one
backend in-tree (and even you suggest there should only be one, albeit
a different one).

