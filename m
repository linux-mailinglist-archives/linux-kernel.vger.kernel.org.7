Return-Path: <linux-kernel+bounces-894779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EAFC4C141
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67ABF4F79FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA1281341;
	Tue, 11 Nov 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZxdSYwEi"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1269834CFDF;
	Tue, 11 Nov 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845134; cv=fail; b=dweGsRQbA10G0uyPAugovmrKYyzSclzaBz9qnx+Hh2Sb69C2bH8quI1KS0GRk41Pj0l9V2GH7DfQfVWTM3VvponRgppNE/RMu/zXTU3G/U3XcWL/7XKkSB9njrKF5LnA8hKcXFQxvjSw1Cbt74qnY3+60XIxVfQyYeE1na86ef4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845134; c=relaxed/simple;
	bh=f8fnIcTApk6TOAABxcN5okzUPe+LexZw1G1GgBcYLUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBStKOaeT6z3/SSVGNA5foZrwpLQVnQ9CbpxDYosXuxZ8UjIQVHX3fPflPtaUAstldTajiSkiejwuP/yy1kyFo3yQEAuHGCoYhe+b5JMbTdPRVgxyNlSh0f2wN1VEeXYN4IdsuA1qxVMAGqbcVTSTQneqXP2ICmegqUZZyWBmw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZxdSYwEi; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhdzJHqhyGWLfz1MTUBfOiKvx1HaCLTfio7HopznqgE0YuHBE7O2sc6jjhlm9ll8k95FJxbr5RSSqRLsUM7slNiCnjZ9n+RVEhbbHY2Vn1+q459lfGsaZDmXEhIncUbwKAIxrWMzlxTQe8SwGxYeyWE0dmoIzm1Q+B5KFPjg3tSF75ZT+VGVN2cFuGw24bt4zFc4HL4xkTcY+9afrXzORTGX15mPAfsRihB6zOIrOvNS9kZYDqF7DmyROnyRCYsYdZ1H197qkazx8EgIfy5z2JzbLJmnIYDjBrSg7DhLtW7bd4Y2P6rK2zipwjOOsscSsrv6W+cnegn61VmIO9lTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8fnIcTApk6TOAABxcN5okzUPe+LexZw1G1GgBcYLUw=;
 b=rBaZNcQy3l5gageAhK/v/RezjI2oMCeAFwfLwNN7UdLhUzHK+YiRjLRAY6S3k3dpqW2SDrPULoZ7rQVntRQEdOwTrtnNfq0JEmHZnY8+E2Mgt1ngTQAzafpHlbCY8gEH16rTkHm87eDlLM8k+UxGmqLp7JHt0454jS1RlPS8pWe8gGr8EW9nwHrYeSwcZS6JS4GQo6DBDSNL02OggfOzRCtiL9/gf4DaZByzyKB6rR0gVD/jb/wul5QcfkCqs2jBFO8AxI0Gfd54qWX66Bu3GCbrHMpcGfKQCyP4qQH+G8lLB++vYNzM9OLqALALrWJRfWqFc9N7fYWlA0INPC/Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8fnIcTApk6TOAABxcN5okzUPe+LexZw1G1GgBcYLUw=;
 b=ZxdSYwEiysH9UG8duOG3Bpw4qNykBIJrfdpUDSw9nNjHTJoiIO6VUleJaOJnrfbjFw+6NVhPwX9fWZTdWcBChFi6xlhu2XE1RRTBmjY289u6XCsN+yXPi5zMpEV1/RcEdaF3HW3AQocpkWjBL5gvmkWUD7QsNeiGlQ/8Rt10fAE=
Received: from CH0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:76::8)
 by MN0PR10MB5984.namprd10.prod.outlook.com (2603:10b6:208:3c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:12:06 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::e2) by CH0PR04CA0003.outlook.office365.com
 (2603:10b6:610:76::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 07:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 07:12:06 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 01:12:05 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 01:12:04 -0600
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.020; Tue, 11 Nov 2025 01:12:04 -0600
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
Thread-Index: AQHcUKAKMWLWoEe5pUGqDO3hVAKe47Tq/KmAgABmATCAAIMYAIABJBdF
Date: Tue, 11 Nov 2025 07:12:04 +0000
Message-ID: <460cd1da65bd42be890e69f26402670b@ti.com>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>
 <20251109-heavenly-observant-quetzal-b1bead@kuoka>
 <ecc69a98a23d406ea1eada62144415fc@ti.com>,<035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
In-Reply-To: <035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN0PR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 935e46f4-ef8b-4b87-de05-08de20f19f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?RigImt7ET310PG+tET2OkjmZ0oddKcI/mzCKsTZE7fpb4Kkzoq/gDPKMn9?=
 =?iso-8859-1?Q?mC5sEZ9eMkcBpdVJ1snYUvF2CrKPDO06g79Zw9XbEWXEjPn0FOgtQZ0ai+?=
 =?iso-8859-1?Q?c6sM8RpNp4izNBis5ggtK6aAVlUJJWUtDOD6jmhT2yfKvFQ9lUaJm4NCsP?=
 =?iso-8859-1?Q?sNrBMQhd1WcJEU1tiL5m2cAlLmSDNrQ/l66lW5BWECsaymABQgNhMBbIk3?=
 =?iso-8859-1?Q?f+2RS9m8lx1/OTzd4wIm2bT4SYeD6stHkObN7Yc4pQ+h4A3+sw8+gzWVVw?=
 =?iso-8859-1?Q?iJTyRN/JkAEK6zIqWXhWD8znrOBCMJ/4cOGtF5h0RqtHsTrs9jfldvdqzs?=
 =?iso-8859-1?Q?aTiE2lv1vg+Nc6VPhF69lyidLkO+sEdbVHoXo+RYyDmS9KxgO4rvb/cIeZ?=
 =?iso-8859-1?Q?Y3quNA64DGRojvqEOtKlo4lnULuxUDhuV8tp3AS9Py6GQL7j18cg72pBsu?=
 =?iso-8859-1?Q?jLEvXETuUp8nBcxmp6e14eqYY4qEzYHNM6nX2SdMhPDh6pPabhjDR1bt/J?=
 =?iso-8859-1?Q?8uAxxoSog01fjMAbQ6Rw1/skKzDaJk7JOYB+FhzfNeox6fZSz6MhEysBes?=
 =?iso-8859-1?Q?MQNw7fG9W5dpkkUVDzOk+6t/BrT+MgfEYIDUEWm9ttzWB2JRc/l/YlhqDK?=
 =?iso-8859-1?Q?oIYVCbQCrdLYg3JuMwhYR9Xd2jsu9wiV4Apib77oEpcTeslBxjU5H1KODF?=
 =?iso-8859-1?Q?4f420Raj2+Py/5B1kOxvMM3FSQNbVPth2PzARufQspotnPXTobOwhS4oQF?=
 =?iso-8859-1?Q?NGgN8xBji1OsdpuMwdqHnJ93jb9zv1xacjN6pCuIdGKrOPb2XqCm04l2BD?=
 =?iso-8859-1?Q?L0T9ZxZlCIPghCk5FwUgiOwdmZVAZSAiz95ivZqMyyNMp/b3az6aCEtkGb?=
 =?iso-8859-1?Q?iwFYf00RhDKHi+vfXg2gMwlPQrFtTAlKRkgKhqBJeNOYeYwHRp4/TBFSRF?=
 =?iso-8859-1?Q?ibbTDRHrvv8HX/6TzZi1IQOqkPI+6+/09jvfARRP2O0yZjl7U91H1nLatb?=
 =?iso-8859-1?Q?UmR+cGjP1uu0fXbeUAlCm2VOhbQgXuvzw14PCqlt7Dbq6wZFa1PZhCRjr+?=
 =?iso-8859-1?Q?BHQ72ambeswXKj15cON92KVtw0D9OemzXFwC0sJQ2rFDz6fH33AhTsSFfO?=
 =?iso-8859-1?Q?Qh8pbOLBGlxUZtxN7yMzcwb+jHd4fro76Ed4+Xt04E3eP9456pL1x1xB6C?=
 =?iso-8859-1?Q?PYaYKgWO507cmtdaqOW2DIueBRlmpCjeEu9PxlqubpF2uj7tRqXomN7oMV?=
 =?iso-8859-1?Q?iVe8X9FPKIX+F79TVSPiQRsEXcmLxoQx2A49DWRBBvbJvdUnFJEAVL6UnL?=
 =?iso-8859-1?Q?e0Sqc7tZEw4H1qVzdDDeu7uSyuEwbUYUiwsGWRquVD7TWEhxMQQAvbm8tW?=
 =?iso-8859-1?Q?6EaXU8rEidF8zd2Wm3f7DdMAzrGS3OvIH0nIgo3x3mBJnoLPeu9/mo4oAC?=
 =?iso-8859-1?Q?+J/VcF0qcNJfxY2uLIKoS+DLR4sP7qz6EbrpB9AMRLggKV5rNXlIzmlM67?=
 =?iso-8859-1?Q?eqcZSYekFXInUxCjmSpkxW3onuczciMq4gCu7WmYTc1GzfKmVsT/piU+hy?=
 =?iso-8859-1?Q?ReZYqaYYV0PH6K7SgcPG9GxPNi43JpjgMHayHbZx/7zOXhYw6vXDwHyz87?=
 =?iso-8859-1?Q?fJZtse7GLxXk8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:12:06.2648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935e46f4-ef8b-4b87-de05-08de20f19f32
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5984


> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 10 November 2025 15:11
> To: Xu, Baojun
> Cc: broonie@kernel.org; tiwai@suse.de; andriy.shevchenko@linux.intel.com;=
 13916275206@139.com; Ding, Shenghao; linux-sound@vger.kernel.org; linux-ke=
rnel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+dt@kernel.=
org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo, Henry; C=
hen, Robin; Wang, Will; jim.shil@goertek.com; toastcheng@google.com; chinka=
iting@google.com
> Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781:=
 Add TAS2568/5806M/5806MD/5830 support
>=20
> >
> > Hi Krzysztof,
> >
> > Thanks for your review.
> Do you mean I need to add a text file,
> for example "ti,tas2781.txt", include the required properties,
> and the example of the devicetree node?
> >
>=20
> Did you read the actual resources I pointed you? I don't know how to
> express it clearer.
>=20
Hi Krzysztof,

Thanks for your review.
Do you mean I need to add an rst file in Documentation\sound\codecs?

Best Regards
Jim

>=20
> Best regards,
> Krzysztof
>=20
> =

