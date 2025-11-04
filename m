Return-Path: <linux-kernel+bounces-884372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D06C3005D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2094FA6DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250930596F;
	Tue,  4 Nov 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpn7E2Of"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8F3115A6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245591; cv=none; b=YG3OKI5coF/XtyZHnGjTC4GwSuoCy9Ef3dyEUKRYxbSNo+mVdvfV90PAcVUtX+Q51cTO1TwWAJURveUW6hRRO9q0JQhI2tqrTQOSUENSF+Jl6oa4ImdUZ//TKJbmb0Ws05x/NwDo28VtgTz4i7t5JeFD12+otMi9xg85RhMFnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245591; c=relaxed/simple;
	bh=KdtFMVyHKzZo/EDAlzANyTHb/8+wSJvqdNjo7/oA70w=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=XshHz79kSOv4uU48jQ/kHT+E7AEx+CrSkPwpUAMx8vcO5wgVuCMhg75UMBVY4xvmpaFT/1MewZTnzqMImRe0OFKzO+9fRl3M7XPkFp+YPzSA1nQ4fXiQ6kcjQ3lnSQpHTySSe7M3qL4y1/X+zVefypGel+6AaVSUrvjExh7Ve+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpn7E2Of; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762245586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUhkfPH/iDzPYPJB5B9fd+xmNjC6dsjlXnkqvz4zmUI=;
	b=lpn7E2OfkVZHiHatEPiMSgIs1yg5dZmWJqK7Tl9WnOoNWUfIR3vnoj6OHM5Oa36Mqag9R8
	7cMP7Yo36xOQNBPWzhG7u4fmw4EzsXj2ckFGiI4PJYy0qag7vl2CNYqq77Jqj4w7TZ9lKZ
	8Z9tvdY12LxMxVn4CuFH7ZqFnE93GAI=
Date: Tue, 04 Nov 2025 08:39:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <f4a25c9dc3af7365b6ade4cd9a0404530afeaa11@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Muchun Song" <muchun.song@linux.dev>,
 "Oscar Salvador" <osalvador@suse.de>, "David Hildenbrand"
 <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Hui Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <20251104044355.94885-1-sj@kernel.org>
References: <20251104044355.94885-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025=E5=B9=B411=E6=9C=884=E6=97=A5 12:43, "SeongJae Park" <sj@kernel.org =
mailto:sj@kernel.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E >=
 =E5=86=99=E5=88=B0:


>=20
>=20On Mon, 3 Nov 2025 16:22:07 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  The hugetlb.c file has grown significantly and become difficult to
> >  maintain. This patch series extracts the sysfs and sysctl interface
> >  code into separate dedicated files to improve code organization.
> >=20=20
>=20>  The refactoring includes:
> >  - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
> >  - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
> >=20=20
>=20>  No functional changes are introduced in this series. The code is m=
oved
> >  as-is, with only minor formatting adjustments for code style
> >  consistency. This should make future maintenance and enhancements to
> >  the hugetlb subsystem easier.
> >=20=20
>=20>  Testing: The patch series has been compile-tested and maintains th=
e
> >  same functionality as the original code.
> >=20=20
>=20>  Geliang Tang (1):
> >  mm/hugetlb: extract sysfs into hugetlb_sysfs.c
> >=20=20
>=20>  Hui Zhu (1):
> >  mm/hugetlb: extract sysctl into hugetlb_sysctl.c
> >=20=20
>=20>  mm/Makefile | 2 +-
> >  mm/hugetlb.c | 852 +-----------------------------------------
> >  mm/hugetlb_internal.h | 116 ++++++
> >  mm/hugetlb_sysctl.c | 136 +++++++
> >  mm/hugetlb_sysfs.c | 632 +++++++++++++++++++++++++++++++
> >  5 files changed, 894 insertions(+), 844 deletions(-)
> >  create mode 100644 mm/hugetlb_internal.h
> >  create mode 100644 mm/hugetlb_sysctl.c
> >  create mode 100644 mm/hugetlb_sysfs.c
> >=20
>=20I think MAINTAINERS file should also be updated for the newly added f=
iles.
>=20

Updated MAINTAINERS to v3 version according your comments.

Best,
Hui

> Thanks,
> SJ
>=20
>=20[...]
>

