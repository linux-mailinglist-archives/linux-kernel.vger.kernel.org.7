Return-Path: <linux-kernel+bounces-892405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05669C4505F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAA424E7C18
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA932E8E10;
	Mon, 10 Nov 2025 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TRIIDzLc"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398C34D382;
	Mon, 10 Nov 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752550; cv=fail; b=Af9gOWaH3/tdtnNHaZN+/EqTd5maZboARWc3mQFxIuMx1zGat/j7ZVyYMCk82vP1UdgKDwhozoPgEqvtPymoK5HFHAczwEod0DwOAjcmrs/8XkRoyyWECaUdy0EYMV4RXfJuSQYsW8Cgk87m77hWpLKa3kvLPO42f41Woker2iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752550; c=relaxed/simple;
	bh=LUvZwXvaMchMVB9diqZqgrxJ7/PoNbJgFBM6Qc0cam0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4qhlF74FqFtwiYhQjgYXe4e3SqNGfd2fceTgiOj1g61PhbVTTUaMEZdAZ1pO7tShihFBpKsquPNNaIBLO93UjMWQZ78ilKKydm7uGUAzWv+tRZ38mC8ooHKsSZY2wt7j1qNUQP8AiDRhtFuWELV/FNiVTNqXQabA6mO7pKE9W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TRIIDzLc; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muBx/xPDgr/BQlKTLelrQHo5yEw8Yr9HFnJlO3OrMQL3U0u9wjmM2oubgfakfXmDvwGlMJ8MiVYqHsJS6A1h8K3uvkWt0zUgSiI60vlZ6nLjMn+R0dGNwkJyuhtVXriIOAmWjvdEycOdJJv+ZX6pK7x1i40Gq66Z0THLQ2ibCMJYXapO/CY5oWmR0Zv+H8GaUdcI01G0iC7hyj4w34q9G4VM8SDgLW1XdVfNNLHLSlbbLy6DgRDluI/BfNzAs3y6Y5bBmBsINaTak1n8G8BzrJDPq+FTTIQwHiK3IRD2/2W9qQW2c/KIU8BYeLfCUkV4oj8gAnrhHDKNyekyz9YC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3IQ//fOYybxZKKPTZcQfYbiMONfX8DnctFVXCEB8UQ=;
 b=EVJPCj9DbdAynGJJSjQilyPj+X4JjdR8oaMoWhKgqwpaTgzNfejEwublVStClVwGOKE4LLUQp5M9TYoiMsl03v7BnlThrN90QcGuK5R3HRi624+tRmX0IC3OrQuAH+w9yvL33uY8iKTnwwXiBxNmZ9PKZdXYD6fDj7Y0N1aulA2vPm3m/UViYE0xoacHAzZor6yEG0jY+pbOEJ6F/oTgna1mt0I0F7UWVMVBeag4ZQEz8dawLTRlqapAId38shCQ9EgRkWBa6c8OVGwQ7FSSct7jNAF4/ULEC54kYBabhMRIORF2GnnjJT11bbx1MVaNxCPpRTJ1yY/DDQNw7FDmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3IQ//fOYybxZKKPTZcQfYbiMONfX8DnctFVXCEB8UQ=;
 b=TRIIDzLcL2KFuYpnNKbQwa8VfJachNCNZh4jgO96B4+919lPRjVAjmTTiFSiElONGrsKpdnzjklbCqiYp7nftN9HRbIWaxza//xQppFSSDtZqN0/wAqzSWQVzoKrerxLUK2do3rxBRaPXMW0me0CLSLIjoq23RR1VqeMZOBSYfQ=
Received: from PH2PEPF0000385F.namprd17.prod.outlook.com (2603:10b6:518:1::6d)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:29:03 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2a01:111:f403:c801::1) by PH2PEPF0000385F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 05:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 05:29:02 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 23:29:01 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 23:29:01 -0600
Received: from DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe]) by
 DLEE209.ent.ti.com ([fe80::9756:3b42:e53b:3cbe%7]) with mapi id
 15.02.2562.020; Sun, 9 Nov 2025 23:29:01 -0600
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
Thread-Index: AQHcUKAKMWLWoEe5pUGqDO3hVAKe47Tq/KmAgABmATA=
Date: Mon, 10 Nov 2025 05:29:01 +0000
Message-ID: <ecc69a98a23d406ea1eada62144415fc@ti.com>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>,<20251109-heavenly-observant-quetzal-b1bead@kuoka>
In-Reply-To: <20251109-heavenly-observant-quetzal-b1bead@kuoka>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 987d5798-872f-4fc2-daff-08de201a0f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?WgS+ZN3LT1SZ/M24bQXxxdlbgpAkq7vEn6dpsZVCTOwIjLpEOkWw6nFmpX?=
 =?iso-8859-1?Q?ITucNPFkhrK/yYq/QK90CgI7pASG/PJBoi6RpcBPixCCABJ6p89pPWth6e?=
 =?iso-8859-1?Q?PeW0fGHHkuzF4CEHSm3COe/mzkQOQrYRmBVJli/ttHMJ6/TvAfsTNXfLci?=
 =?iso-8859-1?Q?FRADEEjNN7YYfP9tFGoDoxJJDZPXr33TuzTLbus9lWuWygnga/5XhWbqHV?=
 =?iso-8859-1?Q?/BGEWGzs710E8Qk8GuSWmQ91Vsk/PE29y0iO4hsrRIRYi08fVMWlL2gsRx?=
 =?iso-8859-1?Q?LcgSsnARIxlQNvJv3Jebt6wYHB0Ociz+uR80rOainMNtDQzjGZSQCVG6Fh?=
 =?iso-8859-1?Q?+JkQ/QYdSOMJqCPfjokLihWUPbUtOJ/gVdurwHUugZoNBi+DcvoniPGnfK?=
 =?iso-8859-1?Q?b2c9QtvggMxa13lRQujcZNfxH/1Rtj5puaGXq0VOMrTwa0KBWTJkElIgWS?=
 =?iso-8859-1?Q?IjtchfvIIt0TupQnTjEUz2yBWr9hqFWjXfBnyWFCVkcb76PcZGtxwL/B7N?=
 =?iso-8859-1?Q?mz4i44xX4KIUpFz5z2Lv+JAG0ajvBe75P4v62LmSOVppww/SV1t0Uen0lQ?=
 =?iso-8859-1?Q?4iE6SKFdihJU7a6QuX9c+E3GJniPqHi7aXbrxfhPjesiVebzrRTlNuIjAY?=
 =?iso-8859-1?Q?2C/J8h7pQCFdXb7KXJbDvYlkC+ShFeSV2GfRZsQJpwl3w5KEV1auyYv9ka?=
 =?iso-8859-1?Q?ZZsE6LssnT7PdaoWWwzlLq+MwZNw06FLYLurBLfdN//XpvLhfQ2o3dgovk?=
 =?iso-8859-1?Q?5EIwnAtfEHWgsr32TXAFE8VK8E5pesdSR9E0HR9JNLEQmvUq6NNRg9SHUo?=
 =?iso-8859-1?Q?aaAiROYN0iGCc8rKF3NmIqQf9HSNEPk6Ik8BN2FP3bH6XMDdTnrZLAP0TJ?=
 =?iso-8859-1?Q?6Irf3r9IPt79g9JnGUyTtQU5Q/ul7DY1wFXtaeB73QCXf8yL3XrCwOx5al?=
 =?iso-8859-1?Q?I8fYSPmUQWeY7Phal0ajfIgP2UW14ana9Q09lmZsE3YxuXIhGV4HVjqMXK?=
 =?iso-8859-1?Q?DD6qHyrC4CaOTOexwi3vk0JQOvFzEeUZPUv0OB6M/tanoWXYkno4ddH+k/?=
 =?iso-8859-1?Q?lunDZfJ0HRVCSangzHTElLM9dz6ri4fiNop3rc2YdvHCLsgjM1+ykoFXO3?=
 =?iso-8859-1?Q?KnBC5DB610reGHeiOVjlkObmyqLNoSCUhLK4mabAISpk2pJwzXHvx5tCHY?=
 =?iso-8859-1?Q?GwGYnM+OzjiWOCSIMzTsyp/Aq3kGSSyqHtStfPV00Q49D9XWfR/pHFYtIf?=
 =?iso-8859-1?Q?cIZgRo+W7Yh9zQgwKhJAfOZsblk3HiqHeEIiuDSoZvAz6OiJE+6kFZGS94?=
 =?iso-8859-1?Q?fRAtK2pIfbsn+ubNWPmNYxCvDZC5IjXWLqj84JsyPrJ3SgtsElJ2AGczem?=
 =?iso-8859-1?Q?jL9fZ3jFhDycUDbeUGnbtfgg6Nb0ETmzQJXcAfm60M3J8muZYTiPlYOuBg?=
 =?iso-8859-1?Q?uZqU1RSaOxeVReY7i1juoiIge/pWQmCwYCRCFGNqhCccjwTXXl/8CV9Xqt?=
 =?iso-8859-1?Q?vPXSxF1QxzGLfS8F4IUX4TRsTIK2ocYouxCFdBQ20Ph/ETgkax3Ggeffc1?=
 =?iso-8859-1?Q?o5D5/+sy0ddMNqooUYxhyGijN0tS?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 05:29:02.5752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987d5798-872f-4fc2-daff-08de201a0f02
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639

>=20
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 10 November 2025 01:17
> To: Xu, Baojun
> Cc: broonie@kernel.org; tiwai@suse.de; andriy.shevchenko@linux.intel.com;=
 13916275206@139.com; Ding, Shenghao; linux-sound@vger.kernel.org; linux-ke=
rnel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+dt@kernel.=
org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo, Henry; C=
hen, Robin; Ji, Jesse; Wang, Will; jim.shil@goertek.com; toastcheng@google.=
com; chinkaiting@google.com
> Subject: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add=
 TAS2568/5806M/5806MD/5830 support
>=20
> On Sat, Nov 08, 2025 at 07:07:59PM +0800, Baojun Xu wrote:
> > TAS5806M, TAS5806MD and TAS5830 is in same family with TAS58XX.
> > TAS2568 is in family with TAS257X.
> >=20
> > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> > ---
> >  .../devicetree/bindings/sound/ti,tas2781.yaml | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
>=20
> Please organize the patch documenting compatible (DT bindings) before the=
ir user.
> See also: https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6=
.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst*L46=
__;Iw!!G3vK!SQ5aH9VZhZ2QzKdtYIs5BX7OarVmt1XzwB9XxqFgAGN0ONvsEoAjHsuoZWrrmet=
zH_xlxeSfWA$

Hi Krzysztof,

Thanks for your review.
Do you mean I need to add a text file,
for example "ti,tas2781.txt", include the required properties,
and the example of the devicetree node?

>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof
>=20
Best Regards
Jim=

