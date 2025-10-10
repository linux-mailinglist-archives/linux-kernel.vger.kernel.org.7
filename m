Return-Path: <linux-kernel+bounces-847753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC0BCB93F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 05:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25001424C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4C26E17A;
	Fri, 10 Oct 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLvHs5ra"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D73D76
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067895; cv=none; b=UhIziPF7y+8LagDVYaxs1zpIe/oFLFw5tQPh1ypfM4ftU1tJTKppHVzisCHQp6AaM9M8HcT4328oFAwnkcBlAB+oame3Uf8H+6PU6/BuMNVxJ7/92i6kR8ny7ZJGqLgjOCJJwsKNLaovaS0phHePk6KX0MZI9XucLi09EioVko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067895; c=relaxed/simple;
	bh=S7+6GIs0RSZ7bzh1yD9c7aD9LHnVVBZrFp5djE0onFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob0JKEnbD7CJiiO57n/FS6PGjMx15MWSwNekRxfq+nX3k9F0fwMyFq70Bz6nUQtv/ZAhst700TSwfVWuid5l37YfdriklgoVDzONuIBwRViU/5Ii6tvWL/fHeDpYSvDq1OIyUSRg8lfswGf3OQ2jk9Z1EPs4pGjrKwjNA+AOeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLvHs5ra; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f15d58576so16236576d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 20:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760067892; x=1760672692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrCDic28MJQLcI4hxPoUYdgbfh8YLLZbssre5IwVfkk=;
        b=RLvHs5ra3Ty263y1ywt4fN349rmOuIJgRpgKqiTTlDNtetX/nztc8Mnnn5FIeK+K8z
         Iw735Q39lmnWZOk2GrRmyMPfT3ZYEH+3I993Z2YyxYYy8n51q+x5xlnHaBKF0GIyfvup
         YB2vRKa7GkKz5dbKavqh/pobCgEm8ebBE6bO7o/35igY7LLINvv4QHxfv1yGxdpscYTX
         1VYH6/F/2+Nqzi5xgvdyoBtuiA7jRaWZdxUeqtIcOtg3Ax6JiigWI1+q4SeRzjdjOgWI
         edM9NmTkZSIn0dBP7x90iiOS8Z7ItiGJxRqXvknPrBFVLYTgJ7DnU2rsCC00umU39pZw
         Rong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760067892; x=1760672692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrCDic28MJQLcI4hxPoUYdgbfh8YLLZbssre5IwVfkk=;
        b=cR0HTfSCGaX9suineDlv+nqMkBAq/jtGT855V0RJkLrdDTiENJMZTc4xu5y8pHigEg
         4XgH5eDwDKKwQiqZ6RlHnpUG5FWBJUt+5qn1uhJM73q8J9IG7MlZ441FJiOsdOxqSWhL
         fJhPAID7a6DRiwKCQfj8zlPhHVWQ3G9dsB3pVWYfPwjEpyX7O1Foc9yqe65+giKF/qjn
         5PzxVG4eFW02EPCymxJB9lgeBrChtFU98iPtAe3/U9uFB/XIvSQnfHNgAiN1yH1RjEln
         vu0JWptjkStwxKPuHvQsTX4Dnih0nLiI/xeg1AZZWwoNhVZXDY8HfG82U8VEECGOxOag
         zPtA==
X-Forwarded-Encrypted: i=1; AJvYcCXEQigMAhT2yVFdOohUYh2UDXIPu81s3OMpIaAzA77iGXzJr0skWffNYaoJuMFNtq/J2xydbe5czf6tdM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztVXlbWojTfO1+1hnBe3elj+mDO1ptHhKCC9kxuKcI5NMJV27G
	7Lx+gWItmagkCcFwTjU8L9ZzkrwOv6ZkJ6CYPxQc0RHr+lob5+VXRwnDbsZTISo/Zk+1wms+qyZ
	a/QlYabfgglNb8grL27cHZwpzFgehwf8=
X-Gm-Gg: ASbGncuzcYLXBoX94NQImU6eWadMiZ4l3JE0aocnnPXfgefrp9DE5t4q1n18DVHdzzc
	pP5vAEdbR7i5PQRbI62RLAenHQZjI7XHPuaRRAcsS414pPyKmUEy24XyKSKLYpsIJBzQr/hoyIj
	YGsz6hKZlzqwC56d1v/u/T5V6nrtEilo4WebmbEiRiGeyPkw+MZp5sXknvsDCCwgIsvkdSSZSEo
	ylxK7KveI5vEC4sSzSMUlT9n3fjNdjOKEuc9cmEyyvZJJaYD0eVIBGawu5n
X-Google-Smtp-Source: AGHT+IFt9dPrNwZtvTc/2n0761h7JBS7U/UywR1UhWegFqqLZQNzDDQzTRrENgTAYeGsX+9n/owRJEuybLV7L5kg/Ak=
X-Received: by 2002:a0c:fbcf:0:b0:87a:6b6:d107 with SMTP id
 6a1803df08f44-87a06b6d175mr116737256d6.17.1760067892162; Thu, 09 Oct 2025
 20:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008032657.72406-1-lance.yang@linux.dev>
In-Reply-To: <20251008032657.72406-1-lance.yang@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 10 Oct 2025 11:44:40 +0800
X-Gm-Features: AS18NWBU91fuBdxwWqHXshtBB35dHf5N-qCYNjdXGhtMxOLtFEEsBf9YCOoHrLY
Message-ID: <CAGsJ_4zp1HSQbSjrt8ftmzdGXxU-ENJX1VfC6Ah+QvhXgzQfVg@mail.gmail.com>
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, baolin.wang@linux.alibaba.com, dev.jain@arm.com, 
	hughd@google.com, ioworker0@gmail.com, kirill@shutemov.name, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com, 
	npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, 
	richard.weiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:56=E2=80=AFAM Lance Yang <lance.yang@linux.dev> wr=
ote:
>
> From: Lance Yang <lance.yang@linux.dev>
>
> Currently, special non-swap entries (like PTE markers) are not caught
> early in hpage_collapse_scan_pmd(), leading to failures deep in the
> swap-in logic.
>
> A function that is called __collapse_huge_page_swapin() and documented
> to "Bring missing pages in from swap" will handle other types as well.
>
> As analyzed by David[1], we could have ended up with the following
> entry types right before do_swap_page():
>
>   (1) Migration entries. We would have waited.
>       -> Maybe worth it to wait, maybe not. We suspect we don't stumble
>          into that frequently such that we don't care. We could always
>          unlock this separately later.
>

On phones, we=E2=80=99ve actually observed user-visible stutters when the
migration process gets preempted and a foreground app is waiting for
do_swap_page() to complete. Anyway, that=E2=80=99s a separate issue we migh=
t
address later.

>   (2) Device-exclusive entries. We would have converted to non-exclusive.
>       -> See make_device_exclusive(), we cannot tolerate PMD entries and
>          have to split them through FOLL_SPLIT_PMD. As popped up during
>          a recent discussion, collapsing here is actually
>          counter-productive, because the next conversion will PTE-map
>          it again.
>       -> Ok to not collapse.
>
>   (3) Device-private entries. We would have migrated to RAM.
>       -> Device-private still does not support THPs, so collapsing right
>          now just means that the next device access would split the
>          folio again.
>       -> Ok to not collapse.
>
>   (4) HWPoison entries
>       -> Cannot collapse
>
>   (5) Markers
>       -> Cannot collapse
>
> First, this patch adds an early check for these non-swap entries. If
> any one is found, the scan is aborted immediately with the
> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> work. While at it, convert pte_swp_uffd_wp_any() to pte_swp_uffd_wp()
> since we are in the swap pte branch.
>
> Second, as Wei pointed out[3], we may have a chance to get a non-swap
> entry, since we will drop and re-acquire the mmap lock before
> __collapse_huge_page_swapin(). To handle this, we also add a
> non_swap_entry() check there.
>
> Note that we can unlock later what we really need, and not account it
> towards max_swap_ptes.
>
> [1] https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e=
@redhat.com
> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd=
@lucifer.local
> [3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@mast=
er
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

