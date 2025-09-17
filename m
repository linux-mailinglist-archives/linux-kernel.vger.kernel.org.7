Return-Path: <linux-kernel+bounces-821118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AAB8078D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2258466171
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696FE2F3635;
	Wed, 17 Sep 2025 15:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="K1wQ1gNx"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C62C235A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122310; cv=none; b=YreWhEMfNrls8uMsZodlzVrc9EfheNPLM/DbHkBjWpECtY7YM22mMGu3C6Eg6AJwVqdwhvvDRvJYQ+bJ6/vAR6Bu8vhcpyYN2CTL5fx1CypZaImwGfMfLUh9ZoXmdHmFchdZm2d3xQkPDuv5pARv61/AvwPhzKXpN/bywT9FKl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122310; c=relaxed/simple;
	bh=oTm6Kno/A/RV/QvjQ0c4Y28+JRucs4g2C/pMQmU1ytA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ma3oR9dXdFT8SiVGOwZ0BURFXimRK38GZ6sp3cgGqucjVdJ6qdnBn001YWsZyeFUM5o7O0K8Rz92VVKkb955+VGDZJbjvuL5mVofFxDsbVcjXzmraxWVVHeQc5axJHbYEHm0CS+GfK/PGZwVt5X11f560zJCWoLS96IjfBtucdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=K1wQ1gNx; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oTm6Kno/A/RV/QvjQ0c4Y28+JRucs4g2C/pMQmU1ytA=; b=K1wQ1gNxlechhgJrAfzTg8HUHN
	r1nlHrjACWGE4H3a98mR1Uh2qXL0DP8/qzebriJgOrJFR1MkOIL5hOAJLMzy1VwdccGVaJCjf5jUE
	9QkwnMeDyyrIGCTSAFNBN0j8y57ijrbjfPQXKsePh3rkQnlPa82Q3LUuY13Uirh4MqV3FjCqwiccG
	Sbedlel5FqmnhKbTdXQgVXKbB+hTPSQ1sJUJ/ENUOzEnoN0y4/jxScrSc79lhqajn6tc/n3shI1ne
	4nxP6YsroVhaJuVuVkwd9sFAnS+x1+yWUg4Z/kSI9aofmaBr0mMXCPSApad5rpYAcv0qq1caBayEQ
	cIpzzwew==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uytuc-0000000014L-2ZhN;
	Wed, 17 Sep 2025 11:17:38 -0400
Message-ID: <3d5fc5eb4ec225b693c59fb1b888c5161794f869.camel@surriel.com>
Subject: Re: [RFC PATCH 09/12] mm/cma: introduce CMA balancing
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>, akpm@linux-foundation.org, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev
Date: Wed, 17 Sep 2025 11:17:38 -0400
In-Reply-To: <20250915195153.462039-10-fvdl@google.com>
References: <20250915195153.462039-1-fvdl@google.com>
	 <20250915195153.462039-10-fvdl@google.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 19:51 +0000, Frank van der Linden wrote:
> A longstanding problem with having a lot of CMA pageblocks in
> the system (through hugetlb_cma), is that this limits the amount
> of memory that the kernel can use for its allocations. Kernel
> allocations are unmovable and can not come from CMA pageblocks.
>=20
> This can lead to situations where kernel allocations cause OOMs,
> when in fact there might still enough memory available.=20

We are seeing this situation happen even when the
CMA region is relatively small.

When a system has multiple cgroups, and has been
reclaiming the non-CMA memory for a particular cgroup
for long enough, at some point essentially all the
remaining reclaimable memory for that cgroup can be
in CMA, and you get early OOM kills.
>=20

> To counter this issue, introduce interfaces to explicitly
> move pages in to CMA areas. The number of pages moved
> depends on cma_first_limit. It will use that percentage to
> calculate the target number of pages that should be moved.
>=20
I've been working on some code for this situation
as well, but your code seems to handle a lot more
corner cases than the small hack I was working on.

I hope this issue can be fixed upstream soon-ish :)

> A later commit will call one of these interfaces to move pages
> to CMA if needed, after CMA-allocated hugetlb pages have been
> freed.

Is that the right place?

The CMA region will also be used by regular 4kB
pages and 2MB THPs, and we may also need to do
CMA balancing if the cgroup is up against its memory
limit, needs to do a kernel allocation, but its
remaining freeable memory is in movable allocations
in the CMA region.

I have the hook for migrating pages to CMA on the
page reclaim side, when the reclaim code notices
that it is doing direct reclaim on behalf of a
non-movable (kernel) allocation, but it has been
reclaiming a bunch of CMA pages.

Hugetlb is not the only case triggering this issue.

>=20
> Signed-off-by: Frank van der Linden <fvdl@google.com>
>=20

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

