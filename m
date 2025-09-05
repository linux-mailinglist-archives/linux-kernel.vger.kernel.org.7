Return-Path: <linux-kernel+bounces-802001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED3B44CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14D51C80499
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1031239594;
	Fri,  5 Sep 2025 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yvNHDBHe"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A318B12;
	Fri,  5 Sep 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045782; cv=none; b=OZisFAxQUBRzMoDosRZUb8bw7rHOuCQk7m2TC0ZsugpfwKPLrdYmRNa8HP4ZBZQ38MPzweU1WEqGZMklkSaPI34B9jmQobc73/YVQwuNhYvRYIn3Rlengh8UPU7iHEvrvkq6gp7tIoTH+cZof77BOFm0Mrn7PCZ8S9FiXjuRoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045782; c=relaxed/simple;
	bh=ud7JbkiHOCmI6mqhWepWfvvmpT1R+N/RUvTs7iar6HY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a0Ac9HPtAncvzC1Z1lQLQGOqZQm82jH2vZAJAvQaElkk/LSMxIcd//4MDyb6DY6XQ7eB590S66ogs8NTgXCSuzgaeu47Rc+hM8kDPvdVVrhr/d9C8HObdwOuCTt8H8xU7FUOWuwPykOfwT63ULrj3blaRi1zZPCnJ9/R8MGTKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yvNHDBHe; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5854Flm43627524;
	Thu, 4 Sep 2025 23:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757045747;
	bh=ud7JbkiHOCmI6mqhWepWfvvmpT1R+N/RUvTs7iar6HY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=yvNHDBHeQN8D64rb4EC6U2OgdKFZghuqRyPQSidhtzSBVvukbFUUHDl7EQ/GV8EA9
	 UfcZLNxIn+6pOolcu8jjJu0W5f8JAksOp9CkgaqgwMHB2oTZNNREF7BPuFjM+HxO2I
	 dZNkiIvfDuYanMGDiKvop1QAKmeQ1LM/o8J2sm9U=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5854FkZ11367942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 23:15:46 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 23:15:45 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.055; Thu, 4 Sep 2025 23:15:45 -0500
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
Thread-Index: AQHcGXV+g3xOktIe00qAtAz2a1355LSBruqAgAJSFIw=
Date: Fri, 5 Sep 2025 04:15:45 +0000
Message-ID: <12aa63e694c94213aeb6b48959d02b45@ti.com>
References: <20250830061459.24371-1-baojun.xu@ti.com>,<993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
In-Reply-To: <993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
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

>=20
> ________________________________________
> From: Mark Brown <broonie@kernel.org>
> Sent: 03 September 2025 19:36
> To: Xu, Baojun
> Cc: tiwai@suse.de; andriy.shevchenko@linux.intel.com; 13916275206@139.com=
; alsa-devel@alsa-project.org; Ding, Shenghao; linux-sound@vger.kernel.org;=
 linux-kernel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+d=
t@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo,=
 Henry; Chen, Robin; Ji, Jesse; Wang, Will; jim.shil@goertek.com; toastchen=
g@google.com; chinkaiting@google.com
> Subject: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118, tas2x2=
0, tas5825 support
>=20
> On Sat, Aug 30, 2025 at 02:14:58PM +0800, Baojun Xu wrote:
> > Add tas2020, tas2118, tas2120, tas2320, tas2570, tas2572, tas5825
> > tas5827 support in tas2781 driver.
> > Tas2118, tas2x20, tas257x have no on-chip DSP, tas582x have on-chip
> > DSP but have no calibration required stereo smart amplifier.
>=20
> This doesn't apply against current code, please check and resend.
>=20

Hi, do you mean I need a re-patch for the newest (next/linux-next.git) code=
?
Or need to create patches on tree broonie/linux.git?

Best Regards
Jim=

