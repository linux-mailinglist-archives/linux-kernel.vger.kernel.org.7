Return-Path: <linux-kernel+bounces-820148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289EB7D07E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD434166793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D0301705;
	Wed, 17 Sep 2025 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o1rL2aLG"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADB204583;
	Wed, 17 Sep 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094111; cv=fail; b=X7dacrfe3tnzMnKRpxHZ46mMjwEebXdKnVkKVAFCabNQFIP5yc6hlpC147TYBFCBRjLtBhhdWfZKBO+fKnv95Kmiyzt02nv29dzTEynJ2rFaWqfwA3mWlVdE+/KKgr9oOz3PRb1rsgy+SCtn3cNX95eeesI1rjnVI3qr1w40iS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094111; c=relaxed/simple;
	bh=6lgsfpMIKqPtHq4G4JNY2CuVfvfTorZB+VThVm/HvcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRQ2L1hSYE38OETK7ifQFC+a7UlCllziPgw7454j67DqrKzYNrB900H5dwxpaPLqFmRqXELx4Cuae7lJ4mIGmiLZAUXOkKL4ikR1Wztxsb3mneJ929vf4o//OnBtdgJlmnJyRcFPxZwV4iqAy/Q6BjR1bxIQSptTAe4KyZWdSx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o1rL2aLG; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geyAfOwFNbRVjruS4uFdOpIjED02zj2swWQChgLRds6ls8KoLPhdQtCjELMmUFzel+ZD7LLiP25NOMD3amshz4GvLUUj2ckxcpJZO28LXIRuro89/9mdry0HxJSlsoNDyw+vJBoVLLMY7KxkYoymxZiFM9Lq9E8pRM1teWfDseBuZ7THmPsErOrwY3vjVRJkdvG3Bxxz9mAz+z1WlxWuWM2Sdtq0p89XqHMpk/schWKztLlYYWt9dIMDct6Hy0rfzCHreuUr3EMAahOkFEtgWIhWaxm1m3jSClVzgTS2rgn3SbM1rhn9G5f06C2LWsHaknYQYhjcCc1wIhROUt9PZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4O76WIx4kpECgikEE0BPkww9C1tgcdZeYbwGxPlbdNA=;
 b=smaJUh0nR6sx8OABslsqb2JNIrxfaTmDvH/YzfJLXBySX4b2OvbnbAA+zICXW/6N2ypMSw95cxPxiJXStDao+fhT5ORJ/GvQd8kd61VEw3Lwfgnt4CyLLVvktl4CyzcahS6iLo2TgKVaMFiXmW1jMO8gkVIn+sONBI25ELh4+7DQQRvmuxM01izmkipwsAwgUzFI+7r0tEbtAymPPUEO2YQPX0/i8nx9p7Y0r9bGNyXVHKDosNOEjKcDrOTjLdBIs25fdQdY+GoCsSpQ5gq229u508IYQjECRDlm61qzumSUHuvvMr0WnvGWkWCaLVdxZLl+4n8jc7RpJc3AY3+9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4O76WIx4kpECgikEE0BPkww9C1tgcdZeYbwGxPlbdNA=;
 b=o1rL2aLGopoE972gCsmUU1B2Pi+j9cVbo5PlCsVulSQ7u1UYvh1014XEFbZk22aR2pxs76+xKZUH99Jw92gv9YSlXUgJQO4h+DD4jc7JFqhG/XJC79Yw92iKxj89OyOtT/NHWoSHxh006ksQSsXtwkfRrwgvRg6zlCh/7HfokFU=
Received: from LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:28:26 +0000
Received: from LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a]) by LV8PR12MB9206.namprd12.prod.outlook.com
 ([fe80::5447:387a:c920:8a4a%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 07:28:26 +0000
From: "Jain, Ronak" <ronak.jain@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, "Manne, Nava
 kishore" <nava.kishore.manne@amd.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Topic: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
 pinctrl schema
Thread-Index: AQHbeKKktzakC2pjxUKURYxGjWc/ybNCrZ0AgAJyC8CACw5/gIARD0CwgTcX/WA=
Date: Wed, 17 Sep 2025 07:28:26 +0000
Message-ID:
 <LV8PR12MB92065C249AFD2DF80149003E8617A@LV8PR12MB9206.namprd12.prod.outlook.com>
References: <20250206142244.2553237-1-ronak.jain@amd.com>
 <20250206142244.2553237-3-ronak.jain@amd.com>
 <20250211215354.GA1244436-robh@kernel.org>
 <LV8PR12MB9206BA2BC6BBBA184B3E2FCD86FF2@LV8PR12MB9206.namprd12.prod.outlook.com>
 <LV8PR12MB9206B51A38A82F5A1730DA3486C42@LV8PR12MB9206.namprd12.prod.outlook.com>
 <LV8PR12MB9206C4FBC2C8675274FB1BCB86C82@LV8PR12MB9206.namprd12.prod.outlook.com>
In-Reply-To:
 <LV8PR12MB9206C4FBC2C8675274FB1BCB86C82@LV8PR12MB9206.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T12:05:20.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9206:EE_|DS0PR12MB7727:EE_
x-ms-office365-filtering-correlation-id: 8d8416fa-bff0-4163-7e12-08ddf5bbcae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rXXl9E+YtS97n8g7IeZc7u87xBo2DFEegYYRRia6UNQK0y7clb6b91d8GH8I?=
 =?us-ascii?Q?ir3KReySuJlUUxSk42Nxi8rwe9sfkKNAcqkoUuUUBnNAwVpFaphSirUipNni?=
 =?us-ascii?Q?QeB54HBjSMXd1CT7i1yp+YukSXhjeTWRtrFjUGlqsLH9JFk9gUTXkLm1Ru0+?=
 =?us-ascii?Q?J2U3bOAGyx4JytbciVuWEciS8qjIXu4V3FFIPLb5D3nfnQPa5GiFnhC3UjTk?=
 =?us-ascii?Q?UJAOmdGTEgtPLk1OaBmWVIh31ObyvoBd3kgvThtwX17CegWn2pPIh70dckt2?=
 =?us-ascii?Q?8h1aB1rN4h0R+gOmrNs9vQozohTzciQMxPbe9e142okYT5pkHa1bD8qKsbyl?=
 =?us-ascii?Q?WccqW3ad3zaxnJB16oc8/e57JNA5xYox7lHfrOZ0wrFifaykqXRpJuJH8XHI?=
 =?us-ascii?Q?O50MO5s2k7gXAPH8sF4vIYNMC/SzFsLkilvldOXUTQhPFYTiw3BPjFrGXLf0?=
 =?us-ascii?Q?P9+IKiERlEHjFeGowlL8KDeKOI2AMUD0/yfXlOzcNjz+zoBCSPyB9hFVj4aQ?=
 =?us-ascii?Q?PvWOwxzZ+J2HpExV4EU94aND4EfMMdLtBdbxtmb+UcFvUm6JJorE62xfIHYL?=
 =?us-ascii?Q?9d7mN2OPaa9BIa77GlL2d0jd85qbtugkSJA02orh4zlxCg1epIILjmN6sh0/?=
 =?us-ascii?Q?yTeBn3OQowx3MKewJWege1DNrzHPUx8Z+g3mbJJ1pHH2GQfNZuGFTqIVP18+?=
 =?us-ascii?Q?NNK4SPXyxwfG2oXm99vx4FLpXZLA80SNcGE/AeErIpvgl7SVc1Ah6XYiYPqj?=
 =?us-ascii?Q?8wAsibsOM59yNiONGRsW8/jSyiwO6jH57HaXWCbrHRDyrX5h2ywNgMszecrg?=
 =?us-ascii?Q?khBJXvI6n5FeDgQkXDRFwDQHcm7yujKVPVFNhksZeR4sdckHuFMU2t8D1ucY?=
 =?us-ascii?Q?v8vypWbW+MW2UE8/I7hdw4ylNGXfhPLgy747KWbRTMZjPgt9Ln5EeqPHhQzB?=
 =?us-ascii?Q?0KeTFmBNz4IzY2oAWrzN7QzBvxonl3O46JoZPkMJVzl4TrEuLIaaOyA35R1U?=
 =?us-ascii?Q?p6yATDJzm63XmGgNaiEiDoaicUze4lqcswzhmUnsBd6n+qpDGnq/aG7ge3cK?=
 =?us-ascii?Q?leQvkJzToqsOE9FDLJzSYy+75vP6ArQvB6Tzg01QN6JtCUORayQiBIsylh5a?=
 =?us-ascii?Q?+67B3BceBpXXhTgX5v2TTrGtoZWLafGaqdw0Oqdh6dSDORXp0wWCHMmCc3br?=
 =?us-ascii?Q?lSRNOhj8L3HuK3vcYGag11kRMrmys/fyXaQJLKUaxqNO5LHzTxcVPgxTH2Ur?=
 =?us-ascii?Q?uuWdllcoFMXsMrs4k3nbeQWt6iRuLKMU7yj1DGkA4gGTdL8+C/BVlr8fcXCl?=
 =?us-ascii?Q?WJI/4LRwwGwvwb7k/h8LBbJFS6GcpCtIsltudCqxAi6cd9sw534bAETqA/9k?=
 =?us-ascii?Q?pRrx+UmmDfFmzW2l+yRGRpa1ZSkvFfnW6fwPxC5cPej46r8SbBXuf5942Yet?=
 =?us-ascii?Q?hYd+EVjRDxoY6Fk2S1PLJWhofI0Pmz/DN/gni0hLFRr3Y+UPjf+Xev+wVdfr?=
 =?us-ascii?Q?rC4PK8FchoVyFXM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9206.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vj51s1fAYL3D8338rqNQeAPsOldaOKaQHJE4zxBVwTHGpvFrTOXwc6EiO3/W?=
 =?us-ascii?Q?0XPAC8GsE79RFgFjnFDM7x8VIkm/g4RKJU1emnPlkpTwkBGsdQxMvBwEV6NR?=
 =?us-ascii?Q?D0DG/MlfRUrywe06jMciDZ5SR0qZCjB5Jay6yieA8iycoT6/IxSh+5E11md9?=
 =?us-ascii?Q?0+f3/zodZcb/Wyz8lIPw0p8qiNhLuzaT6WZPAgA2xoTSprZ0K2mS5761/HuL?=
 =?us-ascii?Q?amIgWKT+USUULSmzF7ZbOGRq+kxUP9L1M2uJMQoxl4azEH55H6QzVcpyBY3B?=
 =?us-ascii?Q?8zt0FK51PYNtmWzMIuoMwg7/YphiZc8AC/S68wm6bqeO0QON9+AUnY10uUu4?=
 =?us-ascii?Q?ppzfrDcdHn6WpdkSV2COSq9LNIeJIZa8IV72yhmPwnSjHRvvCxE+n3+YgUIH?=
 =?us-ascii?Q?0O4MwBZgnj6rsJr4wexiAv2zbEUvsbYXTYTkFvCWzPMbGu/q8j9MqWsg1IZf?=
 =?us-ascii?Q?ENaHU2DrLsEA9gnoY/ueyVE0HvFBG7kfFW910/YBLng5/1wa5Fr28ltHgjk+?=
 =?us-ascii?Q?9OGBD83TRAmVIiUCm8rLQFNmjZDgSU/EGtcc+RBbpWq5hSm+ofwpC8BJTXwd?=
 =?us-ascii?Q?SzY1Px76slb/jEodXwvhIvGwHdLEFXXXD81dnrIXj3G7c3yMJ9tW5CfxPJF/?=
 =?us-ascii?Q?0CXt9crl3V96AoA6MYKwvINv9k6c6CyXfNWhl2gYlmmoOhjQSOXytWomK8Io?=
 =?us-ascii?Q?SWo6KGlagu6NtFOcRfez9khw4LHoF2JsPrauVf4KejGyBXv0nol9h7KmhZNm?=
 =?us-ascii?Q?UUYKnhGhZi2KUGFy9le38Hv12VdK1iwxGcAvseQgJUNe7ItbqIS/BTtljPjk?=
 =?us-ascii?Q?v+Q/G+eTPzCNftQqnrmk3IDAXNxHIvbRsOC0fWtb9XDJVIhNp/rP4B1KN9ce?=
 =?us-ascii?Q?VksbRZvH6MeIq0P/MByqe4n9Tp1N/ndu+WMjB8aYEt9/F6b0hnCrYqkuD/fo?=
 =?us-ascii?Q?UG6n+B5yAu9ejIiY4UNeBBu8L8SGfsFp+33BDS8wGxppy6f/QSFxgj92B5EP?=
 =?us-ascii?Q?WC99XtoaEPbpA2BOvArv7BwakSi/xWztNj5huCiLlWfs/+95d0axE540nfBQ?=
 =?us-ascii?Q?WOFfht4NtJKrO0G5nDQTSY/6/v3wOsd6d3YUeO+zvh+hT+YW76hBiX+Icy2k?=
 =?us-ascii?Q?GoANK68gAh4wrtap8zg9ptgQbGuKp35hbUfpyw95YNKu5ly+wO6AWjmESFp2?=
 =?us-ascii?Q?eKCjtEQ/NKAtGpg6dll0yxXbiSPjdVTpXrGgmrGAfJ7MLsZTIViU1Itud7tN?=
 =?us-ascii?Q?UKjF7s13Gvu1A6UHxfFXyEE8FiIS6zX9oH5jIUO8evwBnXlEmy8MqcARZNXp?=
 =?us-ascii?Q?mTfwjSLrX9Bymbl7j66uT29XzrhqczE5z8BP0Mm3t6ckgbW+G6hs3reg1HPy?=
 =?us-ascii?Q?CgTz8/hl8BUHmc+e1zoRxkmml+floibggdO/SRhlaZEu2COXEerN0x7J5/YT?=
 =?us-ascii?Q?dcUrt5dQkjWcBKWJE8+JdXymq+8/gpYi0ZTxBuOlJXNCVC+LcbWA1B//9hJM?=
 =?us-ascii?Q?IKnf1agq3ARHgpKevd7hxmJeENdqdUGIjc+QoaoOqW4S3Usf+aIvd//ubRFS?=
 =?us-ascii?Q?JacBAt2BuToX42z+ekA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9206.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8416fa-bff0-4163-7e12-08ddf5bbcae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 07:28:26.7405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00tDRMl0+DzbbYHUwdbFxDsXdS+XTlkCePRm8ZuVIwHDuav6sZ7m82774nMA3h5g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Rob,

I am following up on this thread as the query from April is still open.  Co=
uld you please take a look at my question in the inline mail below?

Thanks,
Ronak

> -----Original Message-----
> From: Jain, Ronak
> Sent: Tuesday, March 4, 2025 11:46 AM
> To: 'Rob Herring' <robh@kernel.org>
> Cc: 'krzk+dt@kernel.org' <krzk+dt@kernel.org>; 'conor+dt@kernel.org'
> <conor+dt@kernel.org>; Simek, Michal <michal.simek@amd.com>; Manne,
> Nava kishore <nava.kishore.manne@amd.com>; 'devicetree@vger.kernel.org'
> <devicetree@vger.kernel.org>; 'linux-arm-kernel@lists.infradead.org' <lin=
ux-
> arm-kernel@lists.infradead.org>; 'linux-kernel@vger.kernel.org' <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional p=
inctrl
> schema
>
> Hi @Rob Herring,
>
> Did you get a moment to go through the queries I asked for?
>
> Thanks,
> Ronak
>
> > -----Original Message-----
> > From: Jain, Ronak
> > Sent: Thursday, February 20, 2025 5:48 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > <michal.simek@amd.com>; Manne, Nava kishore
> > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditional
> pinctrl
> > schema
> >
> > Hi Rob,
> >
> > > -----Original Message-----
> > > From: Jain, Ronak
> > > Sent: Thursday, February 13, 2025 4:46 PM
> > > To: Rob Herring <robh@kernel.org>
> > > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > > <michal.simek@amd.com>; Manne, Nava kishore
> > > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-
> arm-
> > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH 2/3] dt-bindings: firmware: xilinx: Add condition=
al
> > pinctrl
> > > schema
> > >
> > > Hi Rob,
> > >
> > > > -----Original Message-----
> > > > From: Rob Herring <robh@kernel.org>
> > > > Sent: Wednesday, February 12, 2025 3:24 AM
> > > > To: Jain, Ronak <ronak.jain@amd.com>
> > > > Cc: krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> > > > <michal.simek@amd.com>; Manne, Nava kishore
> > > > <nava.kishore.manne@amd.com>; devicetree@vger.kernel.org; linux-
> > arm-
> > > > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 2/3] dt-bindings: firmware: xilinx: Add conditi=
onal
> > pinctrl
> > > > schema
> > > >
> > > > On Thu, Feb 06, 2025 at 06:22:43AM -0800, Ronak Jain wrote:
> > > > > Updates the Device Tree bindings for Xilinx firmware by introduci=
ng
> > > > > conditional schema references for the pinctrl node.
> > > > >
> > > > > Previously, the pinctrl node directly referenced
> > > > > xlnx,zynqmp-pinctrl.yaml. However, this patch modifies the schema=
 to
> > > > > conditionally apply the correct pinctrl schema based on the
> compatible
> > > > > property. Specifically:
> > > > > - If compatible contains "xlnx,zynqmp-pinctrl", reference
> > > > >   xlnx,zynqmp-pinctrl.yaml.
> > > > > - If compatible contains "xlnx,versal-pinctrl", reference
> > > > >   xlnx,versal-pinctrl.yaml.
> > > > >
> > > > > Additionally, an example entry for "xlnx,versal-pinctrl" has been
> > > > > added under the examples section.
> > > > >
> > > > > Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> > > > > ---
> > > > >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 20
> > ++++++++++++++++++-
> > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > > firmware.yaml
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > > firmware.yaml
> > > > > index 2b72fb9d3c22..d50438b0fca8 100644
> > > > > ---
> a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > > firmware.yaml
> > > > > +++
> b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > > > firmware.yaml
> > > > > @@ -76,7 +76,6 @@ properties:
> > > > >      type: object
> > > > >
> > > > >    pinctrl:
> > > > > -    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > > > >      description: The pinctrl node provides access to pinconfig a=
nd
> > pincontrol
> > > > >        functionality available in firmware.
> > > > >      type: object
> > > > > @@ -106,6 +105,21 @@ properties:
> > > > >      type: object
> > > > >      deprecated: true
> > > > >
> > > > > +allOf:
> > > > > +  - if:
> > > > > +      properties:
> > > > > +        compatible:
> > > > > +          contains:
> > > > > +            const: xlnx,zynqmp-firmware
> > > > > +    then:
> > > > > +      properties:
> > > > > +        pinctrl:
> > > > > +          $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
> > > > > +    else:
> > > > > +      properties:
> > > > > +        pinctrl:
> > > > > +          $ref: /schemas/pinctrl/xlnx,versal-pinctrl.yaml#
> > > >
> > > > The somewhat preferred way to do this would be to do this in the to=
p
> > > > level:
> > > >
> > > > pinctrl:
> > > >   type: object
> > > >   additionalProperties: true
> > > >   properties:
> > > >     compatible:
> > > >       contains:
> > > >         enum:
> > > >           - xlnx,zynqmp-pinctrl
> > > >           - xlnx,versal-pinctrl
> > > >   required:
> > > >     - compatible
> > > >
> > > > Otherwise, the pinctrl schema ends up being applied twice.
> > >
> > > Thanks for the patch review and inputs. I'll update and send the next
> > version.
> > >
> >
> > In your suggested code, the schema allows either xlnx,zynqmp-pinctrl or
> > xlnx,versal-pinctrl on any platform, which is incorrect. This means tha=
t if a
> > user mistakenly assigns xlnx,versal-pinctrl to a ZynqMP platform or
> > xlnx,zynqmp-pinctrl to a Versal platform, the wrong reference will be u=
sed,
> > but no error is reported. The dt-binding check still passes instead of =
flagging
> > this as an issue.
> >
> > By using a conditional schema, we can enforce platform-specific
> compatibility,
> > ensuring that the correct compatible string is used for the correspondi=
ng
> > platform. This would also generate an error if an incorrect compatible =
string
> is
> > provided, preventing misconfigurations.
> >
> > Please let me know your thoughts.
> >
> > Thanks,
> > Ronak
> >
> > > Thanks,
> > > Ronak
> > > >
> > > > > +
> > > > >  required:
> > > > >    - compatible
> > > > >
> > > > > @@ -164,6 +178,10 @@ examples:
> > > > >          compatible =3D "xlnx,versal-fpga";
> > > > >        };
> > > > >
> > > > > +      pinctrl {
> > > > > +        compatible =3D "xlnx,versal-pinctrl";
> > > > > +      };
> > > > > +
> > > > >        xlnx_aes: zynqmp-aes {
> > > > >          compatible =3D "xlnx,zynqmp-aes";
> > > > >        };
> > > > > --
> > > > > 2.34.1
> > > > >

