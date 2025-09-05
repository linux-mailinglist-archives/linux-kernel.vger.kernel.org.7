Return-Path: <linux-kernel+bounces-803924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17509B46758
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 01:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F317A06163
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39D129E10D;
	Fri,  5 Sep 2025 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/2tIAu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D429D27A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116697; cv=none; b=ef0TOPOR8SW9KFqpwOAjaRGaMf9Cw9tmjzj6PAu+5ViFdxnL6NT79drNXyeEL0zM2RjWOizdQQR4DXbSKgefk+4S8FYKOFwvIKtuPhaHHp53BI1i1oHyQbagHUHCWebLTpCJVKE8vrk6u3wxBYra/L2Yjgym4QMR2VJRR1QJ7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116697; c=relaxed/simple;
	bh=xB5ldmJy/DKXYeTMwYcDhf1eR32/RPQBu7v5T1o/n7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6olpYy/rDr9x75gshgW9SETkz7Dmxqhs3e2vweWujBANC8oG97IgvV5+wRFzeLqDVqivzp6CPRSlb5Zc5ozu/9lWcLM7g1MtyZD02cdbpmnyIGOYwXx9CgD58LsfNjgj1NWeigSOwamNZT2xNmESCOp4L8bC4MR7lisJ3K/Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/2tIAu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB0C4CEF5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 23:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757116694;
	bh=xB5ldmJy/DKXYeTMwYcDhf1eR32/RPQBu7v5T1o/n7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m/2tIAu6bl0xHutiFPSbyYbcwRX5gXZlX1sh2+38LVJVYW6P6a+4JuRYz6227h9b3
	 BAMEJjX3r5Wh8e69KKyxt2GFO9GfR4XriwhuEiqPyd8f17I30YKJfSUQWR8CztT4ZK
	 h6PDG/SLY/Db1cxC1kFix7Kp/m7bOuJjuaweddSG9o3L3gKCicA/cTAPu7R4tYBaXg
	 M7fYegu5aorXe0vzygwBHlownqHf6Or4ue5vTusiJAIrOKttr6gQtyvfIUjY6gGD8e
	 a8UduOfutdoZd7ngvECIhSW0tqL8W+chvAeljUQdoS9EZSpfoOSvSh3xplQhcZ6NY5
	 ml6isXoJHs82Q==
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so12895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:58:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXgu9x5X3xpxVo0LkY2CFYmdnPRO+NHZe0dQdglDL3e5FHmL0LwyyNvWhCJf66LNXIC5NJH/ml7t+DPC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHbzLAFwfN2mH9eGu0hNZJs8vfcrtffxWWbuoS4fzpraSKsm8
	Avi2mCGVvJ9lImuzxVn3wZqemmOSyeh2cn0A97wC1pp1Dn5nvthdPkFhoD0HcmDX1kaaIn91Zvn
	fOT9L/tBvlXkE1vwqH4XsC+crSsXhjduypN8hODjz
X-Google-Smtp-Source: AGHT+IHCcH4kCuVMxmKbBqGME1oVT80rXJRAfI0UrcAzfpUu4NxvH2ftBru08vDxTQGrCxVYHM9hISQJY85M2TQRNns=
X-Received: by 2002:a05:600c:a408:b0:45b:7d8f:4bd4 with SMTP id
 5b1f17b1804b1-45dddad7944mr480225e9.4.1757116693112; Fri, 05 Sep 2025
 16:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-2-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-2-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 16:58:00 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMsGGtOuPpDwFKq0sNhX7HKbQWWK31uWpqeqW-RGTo-0A@mail.gmail.com>
X-Gm-Features: Ac12FXzUSSTKBB1nYWslF_7FFwdhOBxjZwGBNQCXiV0WHLUStmYdDSFHfZgnMRw
Message-ID: <CAF8kJuMsGGtOuPpDwFKq0sNhX7HKbQWWK31uWpqeqW-RGTo-0A@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> From: Chris Li <chrisl@kernel.org>
>
> Swap table is the new swap cache.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |  1 +
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/mm/swap-table.rst
>
> diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-tabl=
e.rst
> new file mode 100644
> index 000000000000..929cd91aa984
> --- /dev/null
> +++ b/Documentation/mm/swap-table.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Swap Table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Swap table implements swap cache as a per-cluster swap cache value array=
.
> +
> +Swap Entry
> +----------
> +
> +A swap entry contains the information required to serve the anonymous pa=
ge
> +fault.
> +
> +Swap entry is encoded as two parts: swap type and swap offset.
> +
> +The swap type indicates which swap device to use.
> +The swap offset is the offset of the swap file to read the page data fro=
m.
> +
> +Swap Cache
> +----------
> +
> +Swap cache is a map to look up folios using swap entry as the key. The r=
esult
> +value can have three possible types depending on which stage of this swa=
p entry
> +was in.
> +
> +1. NULL: This swap entry is not used.
> +
> +2. folio: A folio has been allocated and bound to this swap entry. This =
is
> +   the transient state of swap out or swap in. The folio data can be in
> +   the folio or swap file, or both.
> +
> +3. shadow: The shadow contains the working set information of the swap

I just noticed a typo here, should be "swapped out page"

> +   outed folio. This is the normal state for a swap outed page.

Same here. "swap outed page" -> "swapped out page"

Chris

