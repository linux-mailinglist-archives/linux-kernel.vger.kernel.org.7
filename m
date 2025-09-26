Return-Path: <linux-kernel+bounces-834213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3209BA432F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9A5628D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765881C7009;
	Fri, 26 Sep 2025 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b="1gMhlcD1"
Received: from mx07-007fc201.pphosted.com (mx07-007fc201.pphosted.com [185.132.181.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CC1A3A80;
	Fri, 26 Sep 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896768; cv=none; b=W+COthqoFRqMnqB7a81Xey95xsmLqwfXbym6ks6xqd7xC5FtHS47QleHgBIt/tHBzOxnp8brcsRkB2TAW2qgpeS69U40bU4WzZF7Wp5Gd4BlGJtY8lquvI0aTqUS7meiX5oXVtB+pZURBa7endiBL8U+UxCKyMmCUITi0gVb06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896768; c=relaxed/simple;
	bh=3k/F3p+Fk/c/cylKUBM1I1qdwFpDIs0egd5HDA0AjmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fWM+9FJheOK8GbhIIYXpSEkRdtMiQlGwAigucCFHtF9zUaOTDaDkbIydXFdsbSYUbndv3H/Zg5lyCcN40WnmKvd0kL72zq+Qhl7szgJJzYIqJovnUnnWw4XiNWNH9OS4ymM01pP//fgC7jqkNtljJEZjLVEDH1giTDl2R2ooNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de; spf=pass smtp.mailfrom=cab.de; dkim=pass (2048-bit key) header.d=cab.de header.i=@cab.de header.b=1gMhlcD1; arc=none smtp.client-ip=185.132.181.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cab.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cab.de
Received: from pps.filterd (m0456228.ppops.net [127.0.0.1])
	by mx07-007fc201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58QEPv9r2214265;
	Fri, 26 Sep 2025 16:25:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cab.de; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp-2025; bh=beKuMb7Rktap9GjfcpKEIdWM9E62yT/fpNMmyIxhXeA=; b=1gMh
	lcD1elFuH6Aeob8J8JM+IzAIHuliTADDLAfVOyDfSCs8uqtbAsIePHmfNa5c4fAM
	K4UCuNghbUIVIosopoXbllpFbqvhwbPENtHUFIMIfwqolFKZu6YQ+kTInw9tuxkI
	g+lRcq5FbKfzyP6okunYKAQ/JSjixKt5VSDSgUM6epBHo4LBEOQ3xIq7VSumq2FA
	H5ti1xMzfHSlmxdK1YVDtzVa/kr4uytbMJIgWq9/vOMVgqghKOx8h0vFx18hF7vk
	4qba/hY+BYgmTakjI6ZNclm/Ar+jKPLF/qDd5MO+sCipQfGSBxnuHeuhFFDBMK5w
	ejCc8K+ujwKL+wVTlw==
Received: from adranos.cab.de (adranos.cab.de [46.232.229.107])
	by mx07-007fc201.pphosted.com (PPS) with ESMTPS id 49dbt3ga09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:25:57 +0200 (MEST)
Received: from Adranos.cab.de (10.10.1.54) by Adranos.cab.de (10.10.1.54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 26 Sep
 2025 16:26:13 +0200
Received: from Adranos.cab.de ([fe80::9298:8fc8:395c:3859]) by Adranos.cab.de
 ([fe80::9298:8fc8:395c:3859%7]) with mapi id 15.02.1748.036; Fri, 26 Sep 2025
 16:26:13 +0200
From: Markus Heidelberg <M.Heidelberg@cab.de>
To: Jonathan Corbet <corbet@lwn.net>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
Thread-Topic: [PATCH] Documentation: fix spelling, typos, grammar, duplicated
 words
Thread-Index: AQHcLstyktyjxwWy7UeU9d2/LWnMJrSlRDwAgAAfloA=
Date: Fri, 26 Sep 2025 14:26:13 +0000
Message-ID: <aNaic_817_R_SRd6@KAN23-025>
References: <20250926095312.206231-1-m.heidelberg@cab.de>
 <875xd52y2z.fsf@trenco.lwn.net>
In-Reply-To: <875xd52y2z.fsf@trenco.lwn.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA08934B269BC940AE4344BAA3475AAE@cab.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Authority-Analysis: v=2.4 cv=fOA0HJae c=1 sm=1 tr=0 ts=68d6a275 cx=c_pps
 a=LmW7qmVeM6tFdl5svFU9Cg==:117 a=LmW7qmVeM6tFdl5svFU9Cg==:17
 a=xqWC_Br6kY4A:10 a=kldc_9v1VKEA:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10
 a=MAe1x8XT1DE-PPL54jUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Ux3e1-HluQHfBqzkmrd2aFa4kW2WRxHo
X-Proofpoint-ORIG-GUID: Ux3e1-HluQHfBqzkmrd2aFa4kW2WRxHo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEzMiBTYWx0ZWRfX75iRlmundBZC
 peS1x0j+5Um7TGTwp/hSQqVajmP8ZSf3vVQ5j/h6+t4pOQleDt1U8LimOF9XjTCggxYnDmM/qNw
 zBc+3KgGB+TRzQoj7UaDhMMvgTrcmOkPx5gLBY2N4Kle/b+CreEJ5kLu+CFTSMb0svPL1n8/p2f
 du+FuWApe4ShgPyfByTbs34VTVVvewLVJYhPmo2IwJr8BtgFjMvKDpi2+kj4RubVo+PlcVouZvm
 TSd7UvHCg9xgiOXUM8XdqcpeWE3RmsQ6pfrEmbuFgwFwREawJe+7Em1OJQAT3h9zp5HDjHK4cpe
 /gXlOzm22MY2uAna8cVYaW/uuETDxbP63bQ1N4gW39Sd8z2e2ivGq91TnVZI44JKT4G1eq1BscJ
 /bAhCIDt7Y1RFBTRhVLKlzIZopUo7w==

On Fri, Sep 26, 2025 at 06:32:52AM -0600, Jonathan Corbet wrote:
> Markus Heidelberg <m.heidelberg@cab.de> writes:
>
> > diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/k=
ernel-hacking/hacking.rst
> > index 0042776a9e17..b3d352d2ffcc 100644
> > --- a/Documentation/kernel-hacking/hacking.rst
> > +++ b/Documentation/kernel-hacking/hacking.rst
> > @@ -259,7 +259,7 @@ overruns. Make sure that will be enough.
> >  .. note::
> > =20
> >      You will know when you are a real kernel hacker when you start
> > -    typoing printf as printk in your user programs :)
> > +    typing printf as printk in your user programs :)
>
> This one, at least, is as intended and does not need to be "fixed".

Oh, I got that joke now :)

> For a future version, it would be better to split the patches apart and
> send them to the relevant maintainers.

I've scratched my head about the best approach a long time, looked at
typo git commits, followed mailing list discussion from Link: tags.
Found documentation patches like this across different subsystems and
also a reply about undesired one-liner typo patches.
So I thought, if not touching the technical content, using one combined
documentation patch might be a proper way.

Will have a look at splitting the patch up if not resulting in
one-liners only.

Markus=

