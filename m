Return-Path: <linux-kernel+bounces-792487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B26FB3C4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3703EA27687
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C94027AC34;
	Fri, 29 Aug 2025 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="q6Kt/6PN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F067275AEB;
	Fri, 29 Aug 2025 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505450; cv=none; b=mRwb4/Qf22+CUAHDpNyNJoJYNlba1KLwniPlzPrh5b3p2988/bge+q0TjMM33rdMonmbiaZrIsZA8vng2vVAkTDzG+PgtAcuku4M22PZhByJCT7741f3iqJedRfXWO4tJVSrldJoqq/QivCriWwzdjwCXOG17qDQtZe3B4EHCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505450; c=relaxed/simple;
	bh=DbxUCZn90ValR/0kTDQU69mGFA7CMvBrB55ZYs28ZGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ll71XkCpEjO8gVrRpZgBdW/yEGwqxTIjZgOj1UhcsObuMNCqka+A53F91hxZnS+g1E47yb5YqyW373DhY04IjiHB3Hjh03EPQeWjZ+LSzrgB7FJ6cwUNNKdo1goyP8OsJUotU19IFxyDIjhYLslxPu6mly5Kl0yzxS1A28EDISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=q6Kt/6PN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B63DE40AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756505447; bh=vgfvAKuMTp/6LaiiLVgXU8anY4ehJFvnmnglGF4x2T4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q6Kt/6PNChObYVwTfwKkL1FHrFhJzLeMGLJgX4O0sfub7GBY+Q4npCFRTDABgdsGY
	 h0V4EXUJHrZ3eTHfJz9rJh6EzFbCIBqhSwyI3URAyuQt/BRUUdnfKGKp38ml23z3dt
	 qfFMojgrYZk/IdeHv8GclapSf2AqHKG9ZTFhMuNDQU3pmuxVMscuYrNvyf4eFFdJtg
	 HTp91tcmpVYeqfFBatgaMiAg+ITEGB/LIw1SejP6P25aJH+DKskR26U0bR6W9dpSYF
	 aqfHLc1I6fCNdLS0O+dtzLsQMxzaR7b9qkI7HD3k+aQx4ng9gxirdhL4cvakRst32F
	 pKYfgS0MsquwQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B63DE40AE2;
	Fri, 29 Aug 2025 22:10:47 +0000 (UTC)
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
In-Reply-To: <878qj14wcw.fsf@trenco.lwn.net>
References: <20250823193516.19485-2-ysk@kzalloc.com>
 <878qj14wcw.fsf@trenco.lwn.net>
Date: Fri, 29 Aug 2025 16:10:46 -0600
Message-ID: <871pot4w49.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Corbet <corbet@lwn.net> writes:

> Yunseong Kim <ysk@kzalloc.com> writes:
>
>> Understanding the Linux kernel's CVE handling process is becoming
>> increasingly critical. This is especially important for Korean companies
>> exporting products to regions like Europe, as they must comply with
>> regulations such as the Cyber Resilience Act (CRA).
>>
>> This translation aims to raise awareness among Korean kernel developers =
and
>> companies, helping them better understand and adhere to the kernel
>> community's security practices.
>>
>> The translation is based on the contributor's direct experience with the
>> Linux kernel security bug process and obtaining CVEs. Furthermore,
>> completion of the security training program provided by the Linux
>> Foundation ensures the necessary accuracy for this documentation.
>>
>> I have refined the context that was present in v6. The review comments f=
rom
>> Seongjae have been incorporated.
>>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> Reviewed-by: SeongJae Park <sj@kernel.org>
>> ---
>>  Documentation/translations/ko_KR/index.rst    |   1 +
>>  .../translations/ko_KR/process/cve.rst        | 125 ++++++++++++++++++
>>  2 files changed, 126 insertions(+)
>>  create mode 100644 Documentation/translations/ko_KR/process/cve.rst
>
> Applied, thanks.

Actually, I have undone that; did you not actually build the docs with
this new file?

> Sphinx parallel build error:
> docutils.utils.SystemMessage: Documentation/translations/ko_KR/process/cv=
e.rst:15: (SEVERE/4) Missing matching underline for section title overline.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =EC=9D=B4 =EB=AC=B8=EC=84=9C=EB=8A=94
> Documentation/process/cve.rst

Please make sure that your translation builds properly, then resend.

jon

