Return-Path: <linux-kernel+bounces-662437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AB6AC3AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314CF3A2836
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 07:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6F1DF269;
	Mon, 26 May 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="sFUC4G+L"
Received: from mail114.out.titan.email (mail114.out.titan.email [3.95.73.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566216D9BF
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.95.73.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244686; cv=none; b=WVsWKJ8J8FK8Jq/jSQrde5obZhHe+kOiowltub6E34xD1jvKhnjsX8Cr+0U/4lbeyAi0I4FMOKKcgGpj2oW6VvlXqs2ecUzj4sKsVrmm8N1ADSPkIBgFlnZJb8f+cW7Z7SygQ6P/pOFM6dERzZ8RyzxgytROtG+ArDoVaqpi9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244686; c=relaxed/simple;
	bh=FFFdDWj8mLgY4uEqi9QgJrKx2QBapAPeBkd4Uv87nZw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Nl1YpKZvbKErHo7MDeD2OWffuCic2vD6x7DpJAjaCtbDOL3sVACoKeuxErGOugFTePC1PO3d40MuWfmRgae64aeYXQISGPyxA+yZUGaeMrDdZEfM/v6kgEE9LO2wNcHoqzo62w4Nuy7XUaF4iKPmL2yqro5VhaEo/zVpsMKNEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=sFUC4G+L; arc=none smtp.client-ip=3.95.73.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 753A560244;
	Mon, 26 May 2025 07:31:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=FFFdDWj8mLgY4uEqi9QgJrKx2QBapAPeBkd4Uv87nZw=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=subject:from:message-id:in-reply-to:date:cc:mime-version:references:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1748244677; v=1;
	b=sFUC4G+LFOtT89SwhzMvfFHGbUA2A8Xxl1zQmcSqtPhxP13bGkuMMw7gcg3DIJz1jEvcWP0j
	AzRNhKWP3TYimbfM8Rd7wK2Qm/zHSxvTOAnH1FVbBoZnvBEheUkvHSYTFasKYYvBMokJdlBVBB/
	KwZxA4zJgTa0mFnXd82WTDGE=
Received: from smtpclient.apple (n218103205009.netvigator.com [218.103.205.9])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id EBDA16002F;
	Mon, 26 May 2025 07:31:14 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] bcache: add the deferred_flush IO processing path in
 the writeback mode
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
X-Priority: 3
In-Reply-To: <tencent_2272EC35532EE12E3CCD543A@qq.com>
Date: Mon, 26 May 2025 15:31:01 +0800
Cc: Coly Li <colyli@kernel.org>,
 =?utf-8?B?6YKT5pe65rOi?= <dengwangbo@kylinos.com.cn>,
 "kent.overstreet" <kent.overstreet@linux.dev>,
 linux-bcache <linux-bcache@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 =?utf-8?B?5aSP5Y2O?= <xiahua@kylinos.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C16766D1-0FDE-40C7-822B-96927F6A683A@coly.li>
References: <ug3sqyn42af4bjsp3l5d5ymiabtc767oaoud3ddzv6jnw2eh27@4gcxqaq5tatf>
 <20250428073445.24108-1-zhoujifeng@kylinos.com.cn>
 <tencent_2272EC35532EE12E3CCD543A@qq.com>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1748244677286226798.5242.8978058951272872136@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=J9BQ7BnS c=1 sm=1 tr=0 ts=683418c5
	a=eJNHGpZBYRW47XJYT+WeIA==:117 a=eJNHGpZBYRW47XJYT+WeIA==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8 a=2g-bObx1AAAA:8
	a=2GDuiO8kdObpEpikk8sA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
	a=2vxvtA42U9rPmyYw9DsL:22

Hi Jifeng,

> 2025=E5=B9=B45=E6=9C=8826=E6=97=A5 14:41=EF=BC=8CZhou Jifeng =
<zhoujifeng@kylinos.com.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 28 Apr 2025 at 15:36, Zhou Jifeng <zhoujifeng@kylinos.com.cn> =
wrote:
> .....
>> v1->v2: Version v2 mainly addresses the issue of low efficiency in
>> writing back dirty data in version v1. When writing back dirty data,
>> it no longer uses the FUA method but instead writes back no more than
>> 500 dirty bkeys and then uniformly sends a PREFLUSH instruction once.
>> I will supplement more test data later.
> .....
>=20
> Comparison test data::
> =
https://github.com/jifengzhou/file/blob/main/bcache-deferred-patch-correla=
tion-data.pdf
>=20

Can I access the raw data to have a look?=20

And the three different testings, which parameters of bcache are =
modified from default?

Thank.


Coly Li=

