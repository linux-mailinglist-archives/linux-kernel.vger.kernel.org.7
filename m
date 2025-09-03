Return-Path: <linux-kernel+bounces-799459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A72B42C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12C71B2828C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E172EBBA8;
	Wed,  3 Sep 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ADZ9zhmu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713C1A7264;
	Wed,  3 Sep 2025 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935781; cv=none; b=IueJc/a5QNd8tHexJwvzwmymFFiW/Txvu1EM5rZkr/4xQyxMR1i1MGCFlM6QhFQboJ8uhD1SXSpfHj8YPmTMqWD+XJAjhKxKnqBifaVtO2DJwYWHf+TXZRie5ML8HgHiWxieiKJ2YGHCmQ3uKk9oC9cYYC7Lm6Sa7qrlMj/htwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935781; c=relaxed/simple;
	bh=m8b5pczx93+1I4rsxngXl4GWt7JjCqN4a1YwWdekuP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lx5+opvBMxbMJFHOPMeU6WSDo/O99ZC+o2C5TchVzoWcqDL9K9C37lxBzUMj7oxY2TFt2NQg4WH/S9Zol0OPhNOV3Z9vQw/Bkct+xKNgzmyHjXYNyUZyZU5Dsjyq0YheXDuyqf7176jZodXMBXKXoVIo1WtOL1XZklHUtfpl6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ADZ9zhmu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8ED8640AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756935777; bh=LpqyclOcp1+86ePYQWmXHx9pOThPJTWHQMHGcueB14I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ADZ9zhmux/i5hisepWfTeFcH3JgFHq1zWruMXBdMqNrhvdGKMkSNBQ/YoJfpmucvr
	 inAdIdvhufjH4iccK2+0T1Sng1oZaAIuwQOJ28HjvzxOgfp2peG+N3V1QnFQ9HEq6p
	 QrtoOTEtqd97/MOvOI7+qt4TMp2xmZw8zyEyZIXjbzc2PL5UWz9tXNcntLV5tSAEbo
	 t2eVmvJBCVfrYaw3pPhNKUcbck/XxRJlbWLyaqZEqJXWOcnmUPiccnnqo5ETTrxw+s
	 WpGb9rfzWC2r7LCX93jOt7MKAudt9dgxrY5Vff5cqJmfKxXPTFBA0E+jgkl0wfSqFd
	 lrdVlNvA0TTpA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8ED8640AF5;
	Wed,  3 Sep 2025 21:42:57 +0000 (UTC)
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
Subject: Re: [PATCH v8] Documentation: cve Korean translation
In-Reply-To: <20250831161657.1414453-2-ysk@kzalloc.com>
References: <20250831161657.1414453-2-ysk@kzalloc.com>
Date: Wed, 03 Sep 2025 15:42:56 -0600
Message-ID: <87wm6fp5zz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunseong Kim <ysk@kzalloc.com> writes:

> Understanding the Linux kernel's CVE handling process is becoming
> increasingly critical. This is especially important for Korean companies
> exporting products to regions like Europe, as they must comply with
> regulations such as the Cyber Resilience Act (CRA).
>
> This translation aims to raise awareness among Korean kernel developers a=
nd
> companies, helping them better understand and adhere to the kernel
> community's security practices.
>
> The translation is based on the contributor's direct experience with the
> Linux kernel security bug process and obtaining CVEs. Furthermore,
> completion of the security training program provided by the Linux
> Foundation ensures the necessary accuracy for this documentation.

The above is more than is needed, but fine ...

the text below, however, really belongs below the "---" line, otherwise
the maintainer has to edit it out when applying that patch.  Please keep
that in mind for the next version.

> After the v7 patch, Austin Kim requested to be removed from the
> Translation Review list, so I deleted his name and fixed the parts that
> were causing the document build to fail.
>
> Below is a link where the changes to the translation so far can be
> tracked version:
>
> [1] https://lore.kernel.org/lkml/20240511195942.30857-1-yskelg@gmail.com/
> [2] https://lore.kernel.org/lkml/20240527102313.27966-1-yskelg@gmail.com/
> [3] https://lore.kernel.org/lkml/20240527103003.29318-1-yskelg@gmail.com/
> [4] https://lore.kernel.org/lkml/20240603161530.80789-1-yskelg@gmail.com/
> [5] https://lore.kernel.org/lkml/20240605010811.19445-1-yskelg@gmail.com/
> [6] https://lore.kernel.org/lkml/20250822131829.50331-2-ysk@kzalloc.com/
> [7] https://lore.kernel.org/lkml/20250823193516.19485-2-ysk@kzalloc.com/
>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/translations/ko_KR/index.rst    |   1 +
>  .../translations/ko_KR/process/cve.rst        | 137 ++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst

...and there will need to be a next version:

> Documentation/translations/ko_KR/process/cve.rst:52: ERROR: Unknown target
> name: "=EA=B5=AC=EB=8F=85<https://subspace.kernel.org/subscribing.html>".=
 [docutils]

Please do not resubmit this patch until it builds cleanly and correctly.

Thanks,

jon


