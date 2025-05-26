Return-Path: <linux-kernel+bounces-662619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A92AAC3D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 11:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124183A7CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17B1EF36C;
	Mon, 26 May 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="hxQa09JG"
Received: from mail75.out.titan.email (mail75.out.titan.email [3.216.99.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A017A2FA
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253009; cv=none; b=IaUmn/xGKsQ/kN4EMHlCMZbfk4FzPXW7g5Sorz9iBDzXbA4b0uS/PcPTXKRXXtpndLTGIHRlC60m1M0z1RepCc/W3ClXx57QEz0kvUGeVDOKDJn1d37p69dlLo5UrlktsdhmqVo/ru4MmGmtP8R+hr23pAPa3fJRjWNh7Acekw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253009; c=relaxed/simple;
	bh=Fhwk/QJsN5ivsoCoJbgc0ERFelGGKGbpRKXM0aVBQCc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QEgm3ENslo4/ZNy3fBsesL9RyDniqby0eSXYfR2ygxu9rD0u5l3f8DsaPwD2KSLAqPU2PBMx0VYn3pNnS81utX5UsflmF9V4Yzli0m7t5XnU+lgOP18pTJFBV7xlRXGi/LFQOud9b/TBQCOxp2CgDl9eyF6mzZq4otQvl7C8Vac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=hxQa09JG; arc=none smtp.client-ip=3.216.99.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 836ABE0187;
	Mon, 26 May 2025 09:44:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=Fhwk/QJsN5ivsoCoJbgc0ERFelGGKGbpRKXM0aVBQCc=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=cc:message-id:references:subject:mime-version:in-reply-to:date:from:to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1748252687; v=1;
	b=hxQa09JGCNbZJXm5eAhDnaa8xghHHDOJpfdOStUjJ+Y8K1Dkij+l5FV69Sp0wWs1jzsau0KP
	PBczB0gNlzC5+YFzg43EulRiDQgMgJ6h5/EQ5BbiHv4XDSgxraEw5cUp9QmPyiCj7k0f6vBBmgc
	ducsf62AEFbOE/WTcJ40j3zY=
Received: from smtpclient.apple (n218103205009.netvigator.com [218.103.205.9])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id E4991E0461;
	Mon, 26 May 2025 09:44:44 +0000 (UTC)
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
In-Reply-To: <tencent_0AEE08B04C9DDE6C2354F36C@qq.com>
Date: Mon, 26 May 2025 17:44:31 +0800
Cc: Coly Li <colyli@kernel.org>,
 =?utf-8?B?6YKT5pe65rOi?= <dengwangbo@kylinos.com.cn>,
 "kent.overstreet" <kent.overstreet@linux.dev>,
 linux-bcache <linux-bcache@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 =?utf-8?B?5aSP5Y2O?= <xiahua@kylinos.com.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19FD6A47-11AA-4C76-B5B6-98BB84971D16@coly.li>
References: <ug3sqyn42af4bjsp3l5d5ymiabtc767oaoud3ddzv6jnw2eh27@4gcxqaq5tatf>
 <20250428073445.24108-1-zhoujifeng@kylinos.com.cn>
 <tencent_2272EC35532EE12E3CCD543A@qq.com>
 <C16766D1-0FDE-40C7-822B-96927F6A683A@coly.li>
 <tencent_0AEE08B04C9DDE6C2354F36C@qq.com>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1748252687379173531.26132.5852282787715180134@prod-use1-smtp-out1004.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=J9BQ7BnS c=1 sm=1 tr=0 ts=6834380f
	a=eJNHGpZBYRW47XJYT+WeIA==:117 a=eJNHGpZBYRW47XJYT+WeIA==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=NEAV23lmAAAA:8 a=2g-bObx1AAAA:8
	a=9wspj6F5nppUeS8yhG0A:9 a=QEXdDO2ut3YA:10 a=2vxvtA42U9rPmyYw9DsL:22



> 2025=E5=B9=B45=E6=9C=8826=E6=97=A5 17:42=EF=BC=8CZhou Jifeng =
<zhoujifeng@kylinos.com.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 26 May 2025 at 15:42, Coly Li <i@coly.li> wrote:
>>=20
>> Hi Jifeng,
>>=20
>>> 2025=E5=B9=B45=E6=9C=8826=E6=97=A5 14:41=EF=BC=8CZhou Jifeng =
<zhoujifeng@kylinos.com.cn> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Mon, 28 Apr 2025 at 15:36, Zhou Jifeng =
<zhoujifeng@kylinos.com.cn> wrote:
>>> .....
>>>> v1->v2: Version v2 mainly addresses the issue of low efficiency in
>>>> writing back dirty data in version v1. When writing back dirty =
data,
>>>> it no longer uses the FUA method but instead writes back no more =
than
>>>> 500 dirty bkeys and then uniformly sends a PREFLUSH instruction =
once.
>>>> I will supplement more test data later.
>>> .....
>>>=20
>>> Comparison test data::
>>> =
https://github.com/jifengzhou/file/blob/main/bcache-deferred-patch-correla=
tion-data.pdf
>>>=20
>>=20
>> Can I access the raw data to have a look?
>>=20
>> And the three different testings, which parameters of bcache are =
modified from default?
>>=20
>> Thank.
>>=20
>>=20
>> Coly Li
>=20
> Test raw data address:
> https://github.com/jifengzhou/file/tree/main/deferred%20test%20data
>=20
> I have not learned the default values =E2=80=8B=E2=80=8Bof the =
parameters in the configuration file. Generally, they are=20
> configured according to the required characteristics, such as random =
IO, sequential IO, block size, etc.
> The only difference between the first and second test parameters is =
openflags. The difference between=20
> the third test and the first two groups is openflags, xfersize, and =
seekpct. The xfersize parameter is=20
> used to control the access block size, and the seekpct parameter is =
used to control the random ratio. 0=20
> represents complete order and 100 represents 100% random.

Copied. Because the data lines from chats are too closed, I need to read =
them more close.

Thanks.

Coly Li=

