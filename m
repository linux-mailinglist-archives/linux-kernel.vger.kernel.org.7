Return-Path: <linux-kernel+bounces-894894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED4C4C663
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8583AC098
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ADC2EA498;
	Tue, 11 Nov 2025 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g4Q1Tp9J"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C357242D9B;
	Tue, 11 Nov 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849272; cv=fail; b=NFAdDyagewLQESZ3Uxewt/YVBWG4aZ0/2L5tDxIWj//wZ/I3O8voIQJ7MhHWCuMkCnuvoRoPbASaz2VnI8j3RWvrd6TN47yvRH/e3XigAiUW9TT9ZnYqHgvVraoYIoBRWyk2Xpx/ORwSsWCLrLPxCVd1oHqk7GV/vqC/ImI4cXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849272; c=relaxed/simple;
	bh=//ssiR0RbB2w14tjfpAVLm9OtLjrFvHgcRZ4sFNJJPc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sucmYm1qxVL+Dvgam7t2CA06whOFfjWkLpgb6GZxdWU2M8FTmCXvx3hzL1RL14TkIeXmXGrxYUCRi8dzn1ojCN/HimWYuhRFD0hsYOvY3h5j6+vD622tvz+AS0fj2Z7YPuNeetgfr9U7/GEnn5c9gL2cVaGk8loYMxiXgVTxC8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g4Q1Tp9J; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U65GFYixNut3JLrs/UHFxszoYXMuwf7jDq/MUhBNN7kschRv/a4hKxRZvzqC53WGo3AeIqoquhd63/h/fSvrYc1Lkivi+fMo9SDeqc4HjXwW+B2wrgov1y8YsU/VBDqdIYQGWNmjnxVrhIMLpvf0cIll+6/mjhfiIt1yDzEejjYf7u60j4sFvjlVKvhXDwMbvh6jIPy5U29UirZAUJ6Y8zQ9gleZO90P7rNXRFNFfVr/Q5bzNhK1NDZ86VScS4sBiTTzcrwxJzQrxuVq74vG3kRr23bormeqMO5z6F3nK8xB5oAt1O2WMsc1QGRyRQxmH09Ab2zJJigKPyuXj5WUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woIENtHjOIZFg5jeIxNsHzkLD4rZcjgS6VtJOQuuCx8=;
 b=fTR2nphRjUB0R9K39EGisznIY2P1KEow6J1FGLbniJkGL5B32xA02zYRZdip7IZhu90kxK1KAHTn1sCh+fjG0+1Uqwv9cJUY88KuwH9C3BehWJyhCUCOxoKfilrOx8yM8usa+aaH2gGgdVUVvxTepT+RWA4nsd8OCPn6VWfAkRsHPIeiEkVKzmJ+6xWW9mvnfESrIZpcbxh0EZiXnw60ashINQEj1f/dt3G2dlkgzu2jXkBBCyDUGZLj8FGLE76zwADec1N4iB8JYAZThefkhEUb+rtwsbvocxkdIFoOj9Tu667HXXMRgz5/OYimTMhLhYhjm+sSbXaWqwQikglx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woIENtHjOIZFg5jeIxNsHzkLD4rZcjgS6VtJOQuuCx8=;
 b=g4Q1Tp9JJ/yFHmEValbYjPo/BQvPCtUf2mrGHJJ9h/xCIMkrogf5IG+5ePT8jhunaiRDgPJ19cf211arzoeOEGIFK74h3+M7AsJDS4GlCQUeDH3OeZE6tNfCuExlE/wcZZ2vbrme6kg88fQ1g4yjnmipKd67rBQVu0RmiYxV+oU=
Received: from MN2PR02CA0033.namprd02.prod.outlook.com (2603:10b6:208:fc::46)
 by DM3PPF2867093BF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 08:21:02 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::53) by MN2PR02CA0033.outlook.office365.com
 (2603:10b6:208:fc::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 08:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 08:21:02 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 02:21:01 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 02:21:00 -0600
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.020; Tue, 11 Nov 2025 02:21:00 -0600
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de"
	<tiwai@suse.de>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "13916275206@139.com"
	<13916275206@139.com>, "Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Yi, Ken" <k-yi@ti.com>, "Lo, Henry"
	<henry.lo@ti.com>, "Chen, Robin" <robinchen@ti.com>, "Wang, Will"
	<will-wang@ti.com>, "jim.shil@goertek.com" <jim.shil@goertek.com>,
	"toastcheng@google.com" <toastcheng@google.com>, "chinkaiting@google.com"
	<chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add
 TAS2568/5806M/5806MD/5830 support
Thread-Topic: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add
 TAS2568/5806M/5806MD/5830 support
Thread-Index: AQHcUKAKMWLWoEe5pUGqDO3hVAKe47Tq/KmAgABmATCAAIMYAIABJBdFgABwEQD//6Pa8g==
Date: Tue, 11 Nov 2025 08:21:00 +0000
Message-ID: <7981d64728994bb9bb495af5d4631d61@ti.com>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>
 <20251109-heavenly-observant-quetzal-b1bead@kuoka>
 <ecc69a98a23d406ea1eada62144415fc@ti.com>
 <035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
 <460cd1da65bd42be890e69f26402670b@ti.com>,<d6ba62ec-25b2-4c51-8915-8e69d76b610e@kernel.org>
In-Reply-To: <d6ba62ec-25b2-4c51-8915-8e69d76b610e@kernel.org>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM3PPF2867093BF:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e843ae-1528-491a-debb-08de20fb407c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?289Jdi8im/uimzuO6uauRZwrMDuY1QALc+kZcAOUXsaGtE3QDe7OVPRLVu?=
 =?iso-8859-1?Q?FdENST4dYJXaLX6pPwJ2o2CadmZskk0XgLsOGSZ5rztSlEZQdw+MvR90mo?=
 =?iso-8859-1?Q?V8uo36SKu7sbJJXM7K6RUlpyaxq0NHS2oa/JcWTaapw2Rweya42mnUBXc+?=
 =?iso-8859-1?Q?PfpbgTtTtjRFPkr8RCJLy521fp8MQYl+2a5rlxaBl2xo0DjauzuBFsYAv7?=
 =?iso-8859-1?Q?qedpoHStvXCwFHAVpNyHLlswF/rgeuTjndOJRcWq1aQNmbvklyDPr/2fuK?=
 =?iso-8859-1?Q?+yB6mSurzc5DjYfh9B+JGNnH2AoP9j8eHs7VNP1JnBpG2ZkRtOvDWR45jM?=
 =?iso-8859-1?Q?YJ8gG9uz7I4T5ovSsJCzC1xfhrUqGZM5rsbDA6r4iMI1Ka2YhuJrWOO8n1?=
 =?iso-8859-1?Q?FUtI9FHEvjUTd76efFb4ukx+RzVu1Y7KpEf0IB0af0P2cCzwDcucq96qO1?=
 =?iso-8859-1?Q?wE42t1eIMpfi6B4pLInNN7DG1NlfmGdrOwnLM8DkdRCNSVuUwStfn8NS6N?=
 =?iso-8859-1?Q?905zy1Xva38TdlxhE5GFAaF+ExUklMZiemUhtt0ucLCvmK0ChnXeSMsXaz?=
 =?iso-8859-1?Q?U8t7odnR2i1J61bjQBxj5QAH914Md/LNUmNFU7wRhbXkepPfgayq/wPaEa?=
 =?iso-8859-1?Q?zgDV8Fna3zApMVJUxH5bnkcL+A0SYRrUBLu7D0+l1I2X/XKIsRRX5FvhS5?=
 =?iso-8859-1?Q?GvQEmA3MqGWl8ZjfQpCDhzYwfx8de3onmz+xuoUQEfkOGKh48ImCjKY2I2?=
 =?iso-8859-1?Q?BqmriPsXEiUfjDsaOuFmqDiPKSsWl6VW/xDwWu6QRfGfxIDoWhciD/KEW1?=
 =?iso-8859-1?Q?iJHgBLkkPGckAelm39r3EsGMAa3ac7xDSxQi7YGy6yfq4+gcvEco4PRKR8?=
 =?iso-8859-1?Q?D/igs2MXAnaleFBpWeDFrzDY9FmueuekQiQwV9YlxFpvHbr/Jj5FsSBLi9?=
 =?iso-8859-1?Q?CZ3UT3TO6KwXMI6sJbLCuWrATpsk7AlMwXuNlbvtOzQrUTDZblLREjMaIq?=
 =?iso-8859-1?Q?Ky7M+q7wwpzFlYi7ytshZvog+avELmF35dTeNZZRzAQfFzCvVNGWWajXo8?=
 =?iso-8859-1?Q?72EWKYujtVXxeHgDVXgcer01DWjoZiOLjqVllnwovDAlXMCKPVQmu++ivJ?=
 =?iso-8859-1?Q?mBX7AgfMBGks3zjo+3+7treuOkBiK/6ht4Eu1e3ZUyxor/FPJxnT23OcL2?=
 =?iso-8859-1?Q?sWUZg5REZo31FKgnGoo3qDzno79i1Xh3sdsFxmmNsuZF8w2Q6GfaRLghwb?=
 =?iso-8859-1?Q?RvX9OQ2Ubf2gW5CuxVBRRqSyx+1pifOpwJ8+uEHJPvA9rh1Ur9vfvq2c8/?=
 =?iso-8859-1?Q?KK3i+ld0d5MaAJ/efS4DdvuyL7GuHO7Jn9yYnvHoErITgLwkVdp/D+GsGw?=
 =?iso-8859-1?Q?bGbbpFRGaCAS4+3YMyR3X465y4Glje5k678Kllpjrc4HEqltfOczBE2bJx?=
 =?iso-8859-1?Q?2uFUxgWLHEdR87eUP/Fj6LW89cpNIRzwqMlx5o/h7i4QHyC/ndKDcQDgDA?=
 =?iso-8859-1?Q?BhFvWcDVKdDaBOXvinlGKKAheU1PniYaZVNcoc9IrmR+oVGAa2JwtGpdv8?=
 =?iso-8859-1?Q?dTCDsX+e/6ORn8SMkFetksqI1gEL0GG8btyu6K9Z1O1UN70wCI9GQz8EvM?=
 =?iso-8859-1?Q?2B1+/QSSnumL8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:21:02.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e843ae-1528-491a-debb-08de20fb407c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2867093BF


________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 11 November 2025 15:17
> To: Xu, Baojun
> Cc: broonie@kernel.org; tiwai@suse.de; andriy.shevchenko@linux.intel.com;=
 13916275206@139.com; Ding, Shenghao; linux-sound@vger.kernel.org; linux-ke=
rnel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+dt@kernel.=
org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo, Henry; C=
hen, Robin; Wang, Will; jim.shil@goertek.com; toastcheng@google.com; chinka=
iting@google.com
> Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781:=
 Add TAS2568/5806M/5806MD/5830 support
> >=20
> > Hi Krzysztof,
> >
> > Thanks for your review.
> > Do you mean I need to add an rst file in Documentation\sound\codecs?
>=20
> Where anything like that is explained in the docs I linked? Do you
> understand what patch I commented on and what documented I linked?
>=20
Hi Krzysztof,

Thanks for your review.
From your link, it write:
  5) The Documentation/ portion of the patch should come in the series befo=
re
     the code implementing the binding.

Do you mean I need move compatible to above, like below:

properties:
  compatible:
    - enum:
      - ti,tas2020
      - ti,tas2118
      - ti,tas2120
... ...

> Best regards,
> Krzysztof
>=20
>=20
Best Regards
Jim=

