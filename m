Return-Path: <linux-kernel+bounces-842736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EFBBD6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C610E4E241C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1D264F81;
	Mon,  6 Oct 2025 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="N97ST9CC"
Received: from outbound.qs.icloud.com (p-east3-cluster6-host4-snip4-10.eps.apple.com [57.103.85.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE3264A8E
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742432; cv=none; b=Z4IbtoGIP5E3ep18kE2q3SCJrt3EE14rDmACVFkBaxFlWY6OFSiQViEcDN6V3btJw8JdIMVHnsM+MjgzX/ikMk+WGimGn3nobppvkaiGvT0o2BW/PDkcIgKdUs2g033/1YDBbnJlqusSbA75WuHNzNCFi83FjyHibT75AfHpAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742432; c=relaxed/simple;
	bh=B6W8jYxcdro2yZEywKSg2YdDg5WtTWTuA4FjJ+pXfgc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T/Ojo9GDf5RRYAc74/o5s44NwEwX3ZFE1VgP350V82CwdF85JbH1NBC/HmjBUPAfVbK5k/L6L0skeUnx6eZdTkTsoQ1RBmHATDHOGRcBPlVig8QxP2/k2ItbjX969/rBH+wDQZHgdLBNynKncPQTVxGXRVwZUDjuagJqhLMtfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=pass smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=N97ST9CC; arc=none smtp.client-ip=57.103.85.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ljones.dev
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id F36811800144;
	Mon,  6 Oct 2025 09:20:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; s=sig1; bh=B6W8jYxcdro2yZEywKSg2YdDg5WtTWTuA4FjJ+pXfgc=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=N97ST9CCSiFqOjyUnBG+FM1YFWoWqDvgEbflrkQvX54D5CwQCZW8/s7cdu+LVQwPZ7naphLQyDjcbLIQFUFs0zAQOdIfUSatyJy07eBoVbLzPFofkWOa/5qPt58/ggO8cmPYr7P4aodVUKKfr9zLmtCTcN1C1isnKMdntiHdy+rw1MflNLaJUdwvDtTv2o8QQs6x2NiX7SRGXVCjA+5HfaS0HFv0SqST/pG8584zplC3s82mWymzQBV/127+2ub6lgk/fa8L9vDSGaaXzIFVYJnuP4TFNXGXgNt9/7L9T+DctXt0BDRo7wObQ2jMG819AQIa0SQ5asobkPz1psLtLA==
mail-alias-created-date: 1566896761000
Received: from smtpclient.apple (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id 251811874D14;
	Mon,  6 Oct 2025 09:20:23 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.33\))
Subject: Re: [PATCH] MAINTAINERS: add Denis Benato as maintainer for asus
 notebooks
From: luke@ljones.dev
In-Reply-To: <20251003184949.1083030-1-benato.denis96@gmail.com>
Date: Mon, 6 Oct 2025 11:20:11 +0200
Cc: linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Armin Wolf <W_Armin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5CC41F5-9457-42C6-B5D1-E23D2867CC0D@ljones.dev>
References: <20251003184949.1083030-1-benato.denis96@gmail.com>
To: Denis Benato <benato.denis96@gmail.com>
X-Mailer: Apple Mail (2.3864.200.33)
X-Proofpoint-ORIG-GUID: _4sQyybMyMCvGVOhHbPRKEGPnrmJSlul
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDA3NSBTYWx0ZWRfXzhxwy6ezQJDO
 TiqiHLLBiL7xoHCj+d4mN1n0pDxWKngGnYAZ1rj0NxY35ykdOgKUGtroh1o1Bais+IPpa6Df7Nx
 L7d43a8yX1xSz+JnVquJLqaSp+OSbjLG42rB9LiUQdoujc3JYrNVwIL3B5/zu366aTafHPE2bIx
 u3HbmC0RJZJHmI2XvMgWv2Rt7onb17OTmpqmUsmbk23R9xjytnPTC/k2ZXt9ROFGFETULrVd/9S
 3o8BI/QAQkO0yRiNXgwNLV1lzQYXQTOG3Mxb1IMFm1WUhefL5GQLHEGtgtZ7Y59rPA/2oTm3A=
X-Proofpoint-GUID: _4sQyybMyMCvGVOhHbPRKEGPnrmJSlul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 spamscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510060075



> On 3 Oct 2025, at 20:49, Denis Benato <benato.denis96@gmail.com> =
wrote:
>=20
> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> DRIVERS" as suggested by Hans de Goede and Armin Wolf.
>=20
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Link: =
https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com=

> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 156fa8eefa69..81bcb934748d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3841,6 +3841,7 @@ F: drivers/hwmon/asus-ec-sensors.c
> ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> M: Corentin Chary <corentin.chary@gmail.com>
> M: Luke D. Jones <luke@ljones.dev>
> +M: Denis Benato <benato.denis96@gmail.com>
> L: platform-driver-x86@vger.kernel.org
> S: Maintained
> W: https://asus-linux.org/
> --=20
> 2.51.0
>=20

Acked-by: Luke Jones <luke@ljones.dev>=

