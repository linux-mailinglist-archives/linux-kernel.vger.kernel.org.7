Return-Path: <linux-kernel+bounces-805114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C31FB48422
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFF017E377
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CA822B8D0;
	Mon,  8 Sep 2025 06:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y17i16PE"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D822A4D5;
	Mon,  8 Sep 2025 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312712; cv=none; b=m5F9vzvs2oVpSriJLaNXZ6b7cy+rTjT/3NEBMNIqqGhMGLldDqdQnlA4hfpGnQDhJaNxvRb3ExcmylbUwn2un1fZtfxiVkASZwGBZAaJmE+nmP5RxOnO8GBwVNE6iK8rmSE7vHZb9rIM+BCkU9fSwoTEvxH1JkA983SVBPjL30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312712; c=relaxed/simple;
	bh=DzAfLw6ioEWpIKGDXdSWJiuIYg7unQ63sL0EFbUxunY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9lIkIvguFsZk3tkgDpnkc6Ex7VXS7D1lk+WfJrPq4bhGZ/KXBubboCFm+b2ktT477jQjQakU7IZNWZpolo2tYyCQNj7V4DxPdfJLO8hsRjidTid8Cdxd2U1Elsdb8pEkhUSigXxKOn9NdxWtwLu1NKKEIqQDtgToIAh6tovCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y17i16PE; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5886MqhL3729044;
	Mon, 8 Sep 2025 01:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757312572;
	bh=kiSruyZ6dIgTNsTur0Rl9zLXhun4FWHa+aZ/mS2ubQY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=Y17i16PEiKMSFGlBGHVIGXfAUcoiMSfYcg099slOmq1wIxo1S7Ev/p/7MrKKOIMOx
	 FG9XN1jkixRbuBdOjAMPf8FH508CE+QvUbuKwSR9DidpTsWS5xZpKGaWUc0UOWi/4F
	 fSGm1rqgVXTk2C/dVQM436XZj/f1tNmqWjxSXR04=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5886Mqe23563612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 01:22:52 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 01:22:51 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.055; Mon, 8 Sep 2025 01:22:51 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: "tiwai@suse.de" <tiwai@suse.de>,
        "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "Ding, Shenghao" <shenghao-ding@ti.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "Yi, Ken" <k-yi@ti.com>, "Lo, Henry"
	<henry.lo@ti.com>,
        "Chen, Robin" <robinchen@ti.com>, "Ji, Jesse"
	<jesse-ji@ti.com>,
        "Wang, Will" <will-wang@ti.com>,
        "jim.shil@goertek.com"
	<jim.shil@goertek.com>,
        "toastcheng@google.com" <toastcheng@google.com>,
        "chinkaiting@google.com" <chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118,
 tas2x20, tas5825 support
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118,
 tas2x20, tas5825 support
Thread-Index: AQHcGXV+g3xOktIe00qAtAz2a1355LSBruqAgAJSFIyAAMMoAIAEAJrf
Date: Mon, 8 Sep 2025 06:22:51 +0000
Message-ID: <67fafc23d16d4790821321643a87385f@ti.com>
References: <20250830061459.24371-1-baojun.xu@ti.com>
 <993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
 <12aa63e694c94213aeb6b48959d02b45@ti.com>,<b70314db-357f-4c39-a9b4-088d8ebed2b0@sirena.org.uk>
In-Reply-To: <b70314db-357f-4c39-a9b4-088d8ebed2b0@sirena.org.uk>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Broonie,

> ________________________________________
> From: Mark Brown <broonie@kernel.org>
> Sent: 05 September 2025 18:41
> To: Xu, Baojun
> Cc: tiwai@suse.de; andriy.shevchenko@linux.intel.com; 13916275206@139.com=
; alsa-devel@alsa-project.org; Ding, Shenghao; linux-sound@vger.kernel.org;=
 linux-kernel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+d=
t@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo,=
 Henry; Chen, Robin; Ji, Jesse; Wang, Will; jim.shil@goertek.com; toastchen=
g@google.com; chinkaiting@google.com
> Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118, ta=
s2x20, tas5825 support
>=20
> On Fri, Sep 05, 2025 at 04:15:45AM +0000, Xu, Baojun wrote:
>=20
> > > This doesn't apply against current code, please check and resend.
>=20
> > Hi, do you mean I need a re-patch for the newest (next/linux-next.git) =
code?
> > Or need to create patches on tree broonie/linux.git?
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6=
.18
>=20
This patch is also relative (shares the same include/sound/tas5825-tlv.h)
with another commit on next/linux-next.git:
https://patch.msgid.link/20250810122358.1575-1-baojun.xu@ti.com (ALSA: hda:=
 Add TAS5825 support)
However, it was not merged into broonie/sound.git yet, should I wait for it=
?

Best Regards
Jim

