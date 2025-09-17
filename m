Return-Path: <linux-kernel+bounces-821310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9FAB80EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F1D7ADC33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52BA34BA28;
	Wed, 17 Sep 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NHGDOZ+i"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A534BA27
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125961; cv=none; b=jDcyDn4jA90YU+GFLFJrBnBMDertAlpQ3Kec1dU9CAL4hFxXUvVq6mhsB4mZV1PCSRyoUwM2EHhR1Is3/gb/kjklGCfRb6zFtTS4FJ2i2Q0PportYi6grVq+8+WME+57bDN4yxXliGyNVkpBhxE/4Ed01oAEOCnlw6YgVBUHiq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125961; c=relaxed/simple;
	bh=fv4NXiGEDThBZAu27ctGOKRFZI31MskkS+WI85Qapqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGN9pRJz5/H8NF7naxlezgElSQvaAfRYsXKDo7rIyabJ6pvnQl/TXtxyO76fcREiHMu90H9hybe0YElu/ty1/+EKQbmfbQgCqPJBgAu7tjwIJrTRyFaqFa6PN1ST6b3oCx8IFzUIQVqFRjv3NZqXi4pneeGJ8a73ZXWQX5CRxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=NHGDOZ+i; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b7abed161bso35262221cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758125958; x=1758730758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbkMBeVkd2QsX19NXxvq/zinXbb8IJRh0dyhEXqRclg=;
        b=NHGDOZ+i3FARUc04jONtESFOMeIFO78n16OEcpl4xi/th13rPexz+GSsS4ZrwHMt6J
         Bft5ExP+0RnnUpCr/oodwakuNI8FEZkggeoUJuaXlvjcqS0eRRC4I3yfHcammqYFnG+d
         2a1N2tlv1jK8XlOduyNiosBPRChAgFMn0k5nNhQNqoZWtm8Aa6hqD+3OCETuJXg9ZrwZ
         Zsf42ltck8qJWmikDVXNebAMSdqp6hucji+XPYWlamliIw2HynezI9a60yRpYOKi1WQr
         iQrk5DV2mxKWoKdIvvMJS60S6adh8KWG7Agp1FDbqQCN1T6IoZQsQbpyoW793prRiMy4
         NVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125958; x=1758730758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbkMBeVkd2QsX19NXxvq/zinXbb8IJRh0dyhEXqRclg=;
        b=B/Hk8uDEaN6NGAUhqQLIe6pI/m1l/S3f5v4tJN0qE1+8MBqrCecRrqHHS7lnqsIkvx
         2tStXM8KOcFIIODpsSscgdUvTfOc+z+klBgX5RD+nRf35yhvlErtV2SD4IhlLbLx8SkP
         C6wM488gMjx/VJANH80OXf6AHMOEzF7GCrxySnlYSGUBYZrs/RaFKi31ac7NaTjEShwr
         ci2U9C5Tfg0UUC+5w0WE8bPyEJY/hVIAeERXyot6zctJPFLWUl3/Pm8hETK9EShXJ/zW
         /czE08cfmstNWDotx1/9HZiFiZQiyYDSuTvClVEERAG1iNsa4XzStwSDQLx9E7Jh09mO
         m5oA==
X-Forwarded-Encrypted: i=1; AJvYcCXU8HNvUISVxr+5nUOBi0EKx/91f64UqEf7YfZ8KfdM1DimoCsbprgvSQ57VNVXdj+wAV/zv5P+kl9GsVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNm17UCUOc0eLYpbLI8fubuZznJESE4qr3HgTxnGrF8lGdAWw
	GUzS7Ua8NB+36elIhSxtiJNB1ftzd3W3HQh/5zGL+TNB1kVEH0aPSRphkPJKms+l4b2OhApUKto
	UC1ymApnL5+WyWk6CdWWhuCCJiTuqkAV4S81iomhVUA==
X-Gm-Gg: ASbGnct2hiSunfqwDsitiTdxhq6Xeqhk7tFVMIqyyhV21jdizH7psCl8sIuKm22BRlz
	ivpYSjGpe7thEoTNHe48OxhZ5DSIkqtGEtd1FFHxeocptAMoOg3seIxwNVp5YrQ8UVRAlkOn28R
	g9k3Y06THOsO7sNPiXu9KAR6Y5aXUiC89h5C63MupkAZkXvpS6jAyH+cCInNQoz8SBrxtlWAjh5
	dnw
X-Google-Smtp-Source: AGHT+IGRAvd1PnnWvQJ8F4H+1eu57qvinrMS4TrUKO+pmpvMdhYGbF64WQPsfAaGR7+V69bkpqWp7J6cB8kByry08wM=
X-Received: by 2002:a05:622a:48d:b0:4b7:a44f:5263 with SMTP id
 d75a77b69052e-4ba6cd712ccmr33213531cf.71.1758125958222; Wed, 17 Sep 2025
 09:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917025019.1585041-1-jasonmiu@google.com> <20250917025019.1585041-2-jasonmiu@google.com>
 <20250917122158.GC1086830@nvidia.com>
In-Reply-To: <20250917122158.GC1086830@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Sep 2025 12:18:39 -0400
X-Gm-Features: AS18NWDMazE060QNWHKjDg0IshqlUPi2ez4c84o8JlbYF6kbzA9fUlhLDhAngT8
Message-ID: <CA+CK2bBbSSyCDAAgThDSSwH0WdOeHz-eVgB-1bdiwsDtTSE5pg@mail.gmail.com>
Subject: Re: [RFC v1 1/4] kho: Introduce KHO page table data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Joel Granados <joel.granados@kernel.org>, 
	Marcos Paulo de Souza <mpdesouza@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Steven Chen <chenste@linux.microsoft.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Sep 16, 2025 at 07:50:16PM -0700, Jason Miu wrote:
> > + * kho_order_table
> > + * +-------------------------------+--------------------+
> > + * | 0 order| 1 order| 2 order ... | HUGETLB_PAGE_ORDER |
> > + * ++------------------------------+--------------------+
> > + *  |
> > + *  |
> > + *  v
> > + * ++------+
> > + * |  Lv6  | kho_page_table
> > + * ++------+
>
> I seem to remember suggesting this could be simplified without the
> special case 7h level table table for order.
>
> Encode the phys address as:
>
> (order << 51) | (phys >> (PAGE_SHIFT + order))

Why 51 and not 52, this limits to 63bit address space, is it not?

>
> Then you don't need another table for order, the 64 bits encode
> everything consistently. Order can't be > 52 so it is
> only 6 bits, meaning the result fits into at most 57 bits.
>

Hi Jason,

Nice packing. That's a really clever bit-packing scheme to create a
unified address space.

I like the idea, but I'm trying to find the benefits compared to the
current per-order tree approach.

1. Packing adds a slight performance overhead for higher orders. With
the current approach, preserving higher order pages only requires a
3/4-level page table. With bit-packing proposal we will always have
extra loads during preserve/unpreserve operations.

2. It also adds insignificant memory overhead, as extra levels will
have a couple extra pages.

3. It slightly complicates the logic in the new kernel. Instead of
simply iterating a known tree for a specific order, the boot-time
walker would need to reconstruct the per-order subtrees, and walk
them.

Perhaps I'm missing a key benefit of the unified tree? The current
approach might not be as elegant as having everything packed into the
same page table but it seems to be OK to me, and easy to understand.

Pasha

