Return-Path: <linux-kernel+bounces-792485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44EB3C49E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A371CC2A79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F72741B0;
	Fri, 29 Aug 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EB8Y92mw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D733F9;
	Fri, 29 Aug 2025 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505138; cv=none; b=uwtj21+G+3bQtyPVoYfSqGMEvK6zpI+4PlrQ72zIQwNPUbIk8f++9ZEQBjh3OFWH5wTwROOQeeBuDvy0aU4FIBSqp2Ao6G02VJNfpEq1lyoueuIvGbMew902hHGGp2gq7P3yvNy3n4NRQHPnbD6HNwSltGIbmu5oUA3l6pEroFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505138; c=relaxed/simple;
	bh=JvutaXq+PKl//UG4IHQEgbu/fkcYYQmusgbtPr95/Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uBn81C70eYoJDiVptBxoAWpNT01I7+uHRGsHzcqeT4RTZW2S8umz3H7xHQvMTcAvGHXv0EBs3PZA1ZJ2caMNXSJTSYeGuIT5hG96IIpQ+0ZaA+/kx8jUyGxCupf7ukzUbf4qUiSucuyYpTDPoTB2tzHCQf6oHCwBy4YsU6Xb+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EB8Y92mw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 30E2740AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756505136; bh=VdeBwtdAlWOMOczg93todwnbqhhZcuyB7FOugEXYEvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EB8Y92mw327RV4Jpk9JoruZ5ZuAIvg2Sdt/FKoIwAlYsKuXMtWrkEH/wFJ7FUgEV1
	 Q4Z1mz5EwetjFSpkPpMARv+ZvS7YNvAZ08dSojr4IWN07HDO+ReNVCBU1JmTiz2Vi1
	 kXCMzyWFodhlSASpRqYmFD7HZj5m8S73Qtg9zjHDCluuy/DtKvIHYBGlwrOkMDfK6n
	 28SPU4PnWhP4wwdcARFHUsJRWkONxjNhGcTGtMhai3ynVC65bdXcYWHlld0Kr3IFPG
	 0UZvre+JcllSPvWPcw25L1N/6MFU9gnPpsJOHK72/ay6fevkmeYKb4YulLTwVdUZiQ
	 K+MrpwpEeJbCw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 30E2740AE2;
	Fri, 29 Aug 2025 22:05:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Hyunchul
 Lee <cheol.lee@lge.com>, Namjae Jeon <linkinjeon@kernel.org>, Chanwoo Choi
 <cw00.choi@samsung.com>, Jaegeuk Kim <jaegeuk@kernel.org>, SeongJae Park
 <sj@kernel.org>, Minwoo Im <minwoo.im@samsung.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanho Min
 <chanho.min@lge.com>, Taehee Yoo <ap420073@gmail.com>, Harry Yoo
 <harry.yoo@oracle.com>, gwan-gyeong.mun@intel.com, yeoreum.yun@arm.com,
 Mingi Cho <mgcho.minic@gmail.com>, Hyunwoo Kim <imv4bel@gmail.com>,
 austindh.kim@gmail.com, pmnxis@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [PATCH v7] Documentation: cve Korean translation
In-Reply-To: <20250823193516.19485-2-ysk@kzalloc.com>
References: <20250823193516.19485-2-ysk@kzalloc.com>
Date: Fri, 29 Aug 2025 16:05:35 -0600
Message-ID: <878qj14wcw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunseong Kim <ysk@kzalloc.com> writes:

> Understanding the Linux kernel's CVE handling process is becoming
> increasingly critical. This is especially important for Korean companies
> exporting products to regions like Europe, as they must comply with
> regulations such as the Cyber Resilience Act (CRA).
>
> This translation aims to raise awareness among Korean kernel developers and
> companies, helping them better understand and adhere to the kernel
> community's security practices.
>
> The translation is based on the contributor's direct experience with the
> Linux kernel security bug process and obtaining CVEs. Furthermore,
> completion of the security training program provided by the Linux
> Foundation ensures the necessary accuracy for this documentation.
>
> I have refined the context that was present in v6. The review comments from
> Seongjae have been incorporated.
>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/translations/ko_KR/index.rst    |   1 +
>  .../translations/ko_KR/process/cve.rst        | 125 ++++++++++++++++++
>  2 files changed, 126 insertions(+)
>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst

Applied, thanks.

jon

