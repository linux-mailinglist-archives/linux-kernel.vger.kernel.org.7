Return-Path: <linux-kernel+bounces-759920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC45B1E47B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD47718C315E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCEE262D27;
	Fri,  8 Aug 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eneu5Yj6"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF391A00E7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642228; cv=none; b=h9l3RVoTiooYpU39hc6hNTl2mZ8f2uVyT2nu7UJkUpd9Gwy5+3ctDFj1XblS8QzBlSJgdL46TDkLN5GHIN/2EGwkjJW44T4s711C8vXlXfMgsY10KvcQ71HpdwKp2kL4ogymEJS+QDglnfiyLpLAaynGRv6+ZgueC3D5xwHu8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642228; c=relaxed/simple;
	bh=Fiip62CnTAuOuy/j+2e5UX+Bak/iiPX2VoqRyst4gY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Zb8ERKdQ5TjFK6mnvLmyMGDOI844ZJ3YejcxzrV5QA1vGEHffNXBpZeZ0QuDTp6P1/VVU54ecnm4PNr+37z1/POG+D5XY0NsD1/i0EMa6vpyw1WYNQnM+Oy+ZmaZ9J2tyc/H45KDqBuERTq1b5JOSfqSfuyC/AhCQlc1IsHB5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eneu5Yj6; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7806a620cso909315f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754642225; x=1755247025; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWf5Rs52y8GbqmsWSRM2y/wPZrw81H/2+73aRTZVaPQ=;
        b=Eneu5Yj6TTToXqmgLwRNdddIX44LiNDWQA2jMY8RKbbP5mwUJJY2+PY6C/Wp3o8OIi
         cJXFhgV4poQokAPgi5s5loyAuvMGm886iAszNnA3+o4XAn3gzTXzQ9ZKCLAupwa+N9Us
         AUWwEQiXfzrQli1DGiwe+cVw+OGeapQO81JSOJute7fWh/OTLD08ahT13Gj9V+5POX2x
         yoatgTyJ1vl0RJFTRh5eIbeWltDb29FkUvpBw/aD0yJ0JF05e799hnIpxTBosW8Ft0dC
         Tijzy8psrJFmx/mmbkOa6K7oZ9RXoBNwNCqTAAJyoD5YNRS/HusmVsk1znfUvQ00N6hr
         1BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754642225; x=1755247025;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWf5Rs52y8GbqmsWSRM2y/wPZrw81H/2+73aRTZVaPQ=;
        b=dtpe/TZo/5X6q+uAWtgW/wy4H0EHDe9abIgyp0BmgWKHn+BuHYIZE15yz73KYICIvi
         wsxe1AUv9F/E72TOJsU8BPZ5zGhwIX5k9WhNO1G+L/cTpcBBEI5rFfRS12Fi6j0flQmq
         hdOsMQqdqbp8AupUkLxuiFl3hAlhUvNAcse32f5tVEbjuIztNXQ7JJ74bBMeaBd38RY/
         DfrlEg5lUns1lzz9PdPxGaBqaVUvF7h2ViWV3KOJFxV66ByvYrSbjPe5/Nb4QrGMSfbp
         rVvhJMMOe6SL6IsRf1Q9vhwzt1ivsdgJkWqVWuyijdRROy36L36CAbMI2pA5i65dljfi
         fxIw==
X-Forwarded-Encrypted: i=1; AJvYcCWDj1A5lWoiQHAzbHhBrIvW77yZGmMKRVmZey1OdINYAkCvXoatzg4PGMZt0DyL6Wq/DFeqPNR9su9kXVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOsdeKUfOXk0mYjCByUEOHDMvkrid93CQ6Fg41ofSsqBtGKzQ
	5UY9Jw0YlhPHtkhRYJXQ6/nnXL3S28X8aeebs4Y0PqIoHVEKZLlFWrgvQ+vX0N04PRwLA/xZVEi
	MIpMYyYBjYrfUkuryfQ==
X-Google-Smtp-Source: AGHT+IHeQjxsRMOFdPNpW8//eVd1Z083P34hPSyuC17y0Mc2IqIpwxhiZDy/PEnJRm6n62VtLAtwv9yuCnyvOmU=
X-Received: from wmsd10.prod.google.com ([2002:a05:600c:3aca:b0:459:da33:b20c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:584c:0:b0:3a5:8cdd:c174 with SMTP id ffacd0b85a97d-3b900b36f82mr1932975f8f.26.1754642225158;
 Fri, 08 Aug 2025 01:37:05 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:37:03 +0000
In-Reply-To: <t6lhpij2tv2y3cbps6g3mu6boiic2amy3xx6ppkksrb2625odo@6plivbxstgkm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com> <t6lhpij2tv2y3cbps6g3mu6boiic2amy3xx6ppkksrb2625odo@6plivbxstgkm>
Message-ID: <aJW3L3SEVUl_AVvN@google.com>
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
From: Alice Ryhl <aliceryhl@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Thu, Aug 07, 2025 at 12:12:47PM -0400, Liam R. Howlett wrote:
> * Alice Ryhl <aliceryhl@google.com> [250726 09:23]:
> > The maple tree will be used in the Tyr driver to allocate and keep track
> > of GPU allocations created internally (i.e. not by userspace). It will
> > likely also be used in the Nova driver eventually.
> > 
> > This adds the simplest methods for additional and removal that do not
> > require any special care with respect to concurrency.
> > 
> > This implementation is based on the RFC by Andrew but with significant
> > changes to simplify the implementation.
> > 
> > Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  MAINTAINERS               |   2 +
> >  rust/helpers/helpers.c    |   1 +
> >  rust/helpers/maple_tree.c |  14 +++
> >  rust/kernel/lib.rs        |   1 +
> >  rust/kernel/maple_tree.rs | 286 ++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 304 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dd810da5261b5d664ef9750f66ec022412e8014b..b7e7308ce07c050239c14c4f3a0fd89bdd8e8796 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15956,7 +15956,9 @@ L:	rust-for-linux@vger.kernel.org
> >  S:	Maintained
> >  W:	http://www.linux-mm.org
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	rust/helpers/maple_tree.c
> >  F:	rust/helpers/mm.c
> > +F:	rust/kernel/maple_tree.rs
> >  F:	rust/kernel/mm.rs
> >  F:	rust/kernel/mm/
> 
> We should have another section for the maple tree, since it's not just
> used for mm.  Your stated plan is to use it for GPU allocations and the
> code doesn't live in mm/, wdyt?

Sure, I can add a new section if you prefer that.

Alice

