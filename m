Return-Path: <linux-kernel+bounces-856310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060DBE3D24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AE4A501A05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB58224AED;
	Thu, 16 Oct 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ljdGFM2U"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6541D5CE8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622971; cv=fail; b=IXAvEQ6TtN16XSafF77P/+1C32fePcc0h1JBufOPQlnb0CFyKs+X6XFEfd3tcfPs1ll83RE+DSfHS/d9OmBuONBL7kRabIxtDvyNSzYuhb2BjOT7Od5JupWSevJGsDJ8IdRESRb1ZXOzqEQxuBSPcBg92Q3mdhuPZ8DWKIcGYD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622971; c=relaxed/simple;
	bh=dULCauS+BxoN44BYHAguF4Z8BN9S43nzFcKktbYVqbM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJBQlgq3XMr9wtWBvW/rWf6KgnFK4TtrLxR/Yk1iTq30NJlvNnDLWduTo3XU+T43u5NhicFmdjNpsTsqPcAOypFShBvv/29DOCtrTpiEgiJBw5Fz4xyldpy7VO4k5jR9GS5SmDxmlDwFCtFbBCKeg+E04YQALkBXti6ulN0KwRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ljdGFM2U; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn6aWMFqu9tTDr0Xhbg8DrvUL0U39oCiczQ2+t6SxdB42p1alEUtzXc7eDxz4sUN8actgasMcG3DfF78/nf5uYsNYhsoDdN49ZlFoR716g2CYv7iiNmaQ5ixpwxeL/irWh56Oc4SYM1mOaW7o2kJ+U154O2BMbNCl8wNP3MwpTElZxDq8zMxQr1SDdDGmwz4d5mBvSAdzM3SbFQpR+K7sZq2xnoxR40Mka71FXOBO5RzrSm0R5lHgsiKHkZq0BTurtAIdaqLhnDuYcFg9mmQl+syL9DRYlk3f8BmsVRivYc1n4VMIHNERk94rEg264U9GFvvNdi7Uee++8FHvgPAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5Tl+Wb5wJ4ppIKVa0f8ulQYz3SoBRWrIjSra/oHVXM=;
 b=e3/Mg5HreKGwPZ4JVShbwolpjUiSmGKBbL9NwFOxTyq6mfNt+rLGZQOM+xx3q598E/o7MaAlhEeEEcTciArYa5S56jpGpj078NsatEdhedoaIQByjWF0b2jBjlCBOYEVgTJoqWlDvtP/Strn0W3Gpp5fBi4/K8DNL9EPEpgqMS8QEvFt7hpa/sG6Wd4KBa0yyu3Lx8XM7+yZAqBIdUyNrIg5o397plEc5DoiTq//cTu+At43TcwUM8F+yzx7Pnv6E0QMtipDo3x0QUo1PfN03bNf/nc6JfVLTmgrJu/ss00svnCTEubEmU53hOnSnEcI9C6or51v5QQnMnJk5v3/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5Tl+Wb5wJ4ppIKVa0f8ulQYz3SoBRWrIjSra/oHVXM=;
 b=ljdGFM2UiMaTcmD6iEhQ2f5HWFL9EOm7oNbZY+fmcjsJNgDrJJvMUycFfJmUzAtctufvUPo05ttblyUoE3JhrBDhUJvlyY/ohLwvSq5Sah3PQ+vPtSgSqM8nIHjfzscMq8aXOUoFUBEnajx49lvoM4DZXkMBL0yP6kGsCXMZ3Us=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:56:04 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 13:56:04 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Aaron Rainbolt
	<arraybolt3@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiujianfeng <xiujianfeng@huawei.com>,
	"xiujianfeng@huaweicloud.com" <xiujianfeng@huaweicloud.com>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index:
 AQHcPYmqb7qd0BZyXkK7jo/Wse1167TDOpgwgAAfIoCAAACCsIAABNuAgAABaACAASvFAIAAPD3AgAAFYACAAAA3oA==
Date: Thu, 16 Oct 2025 13:56:03 +0000
Message-ID:
 <DS0PR12MB92732E540B0951324A01B51D94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
 <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <lpv2uouli7b4zi4up5434mfdjngbvwbnn72vgyz47b76h2ac7b@uqlaa6mh7dfa>
 <DS0PR12MB9273B5438371E67441C042AA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <o5decnfriq2nfg5o23uuwptzxnsbwalltm5hjxpwgr6eje5p5s@faehapbq43rd>
In-Reply-To: <o5decnfriq2nfg5o23uuwptzxnsbwalltm5hjxpwgr6eje5p5s@faehapbq43rd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T13:55:52.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CH8PR12MB9743:EE_
x-ms-office365-filtering-correlation-id: 78639fc3-1c28-4eec-aeee-08de0cbbbf20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4b5ML2L56ep2s0PuH7ob2hG2OVMv3k9sY17IUzjvW/yYclBXilfgUDchg8V1?=
 =?us-ascii?Q?gKy6yR7HX8aqp//d18ZJnTrbSZx8QsssLOMVt3sgQR7ZFNojoJ2FImPg0xu7?=
 =?us-ascii?Q?TX92f2gh6FerCPw3TrsQ8qVDCnDOCproev78nGePrOfiHib9DjdOVr7/ftAq?=
 =?us-ascii?Q?Ix59VMBVJUh63rny1KK3FWtqkvwFPGvtaugeWS0m3KkkU4QwLsIDBS6CwiWJ?=
 =?us-ascii?Q?qsBVOKNLx3Rt4kBhpAvOTThHi+lAtfrqkzqIIROOBP4nErL1UzLxSsGLoZAI?=
 =?us-ascii?Q?Ju6LHTT0eA21UVQKLhACstq22tpcxiOPZ1UldqC4jWKLu2YxX1DON1MfTFE+?=
 =?us-ascii?Q?A8b/Ey3q/SHhX9viKFtl6oTcynzo4aWlokn6ZEfomA7GKN5OH/YqjHQYNpq+?=
 =?us-ascii?Q?hX+ZVGrmKxX8NGfitAWkz3cChvcZvLyj830AL2VwqxA0zrAk45Bvm7q3FToZ?=
 =?us-ascii?Q?wQH+8I2KW19r3G7qrY5k3bQ1OF6F9MNmZeQxZb2Rhhzutyd+GE/mWC0a+LVb?=
 =?us-ascii?Q?EJpdzmqtqSqHMgQD0w7gdgfktd7hNjbVfadyO9puU/zBW1c5CLpXjtuqqc9z?=
 =?us-ascii?Q?MdIIpYGMm1IdZpBBbO7zR9Zc2Bcl6fsoCXs0pbLrZM2htVf47Ubkh5ZvVZ3U?=
 =?us-ascii?Q?ryqQLGyWweDmZfMcv7ddIXGF6PBKOd/36gKIQnkmZRWqpOoc1GQgIYlp0NAs?=
 =?us-ascii?Q?XhS65/uOZnmAdXiRsyjuGl55gQDd0uoFtEFXSgZuKJl6EObnaxAet97yxt6A?=
 =?us-ascii?Q?ni0oXNYWXQZ5kdCyM5RiyTM6UU+7tRLc7nZy7jAocaUfsksXBtcV2yUc7y3c?=
 =?us-ascii?Q?LjG7Z2elWkv4K33WNSZqldFajBDNqNXhOtKAoD6sRpKUwNtd28AR65PJUyaj?=
 =?us-ascii?Q?gI26AhqxjiCabXwJeb+/RSAJzzRJNqQFTw0dFWiK3EatnOTpSUxFBpcR+O3m?=
 =?us-ascii?Q?eL+utk9SgVmliHKe0pVBsNwSQzAt/Xj2p/Aeq6dGI7bDGUPX83OreQBOvmOu?=
 =?us-ascii?Q?umBJwBNaVN36mXLXlHROETVYve49YHd3OjR/PQOHNlf5RycvSeMPEgHaTSlV?=
 =?us-ascii?Q?3O7C2VfddOjwIr8JxkshzWAMQ3AESTmJiWm+zvVvotAxVY4oqiEN6URe9dvD?=
 =?us-ascii?Q?zoLclwGLmvCSAQ/II+u4xxaMB3QViGCuZsxtCUMkDpcmEWJTm1BubuYrwNCf?=
 =?us-ascii?Q?jRPbhMR4qkP1291QW2zWtkV9aSn9D+3mZrhpY0z3J8IK7NKnIUhBDgtpclvS?=
 =?us-ascii?Q?yUOv399WNOHtPFKfe291lU3kbq4P6xgSadkYi0whEoFByqoZnftnU+zuCmqf?=
 =?us-ascii?Q?96XYie4Au7GNRm92SwBA++DUj4V8rriN3WY4BbCtGrpKyqSY7TsydXuVs5JQ?=
 =?us-ascii?Q?91KErj8iBZV7zyvWpU5XZ9doxsVng14FgdobU7fwhFcbvph2ZDAuTtOMYrFe?=
 =?us-ascii?Q?Ec9vnrMEgmRoblQnwmHdcKH5LmIeyrvRA2Jx20YANsnS/hajVE+FrSc8+jc3?=
 =?us-ascii?Q?7ngbbyebM0B1PCutxUZ4Y+smCaQkxx8oV/7c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jxlOyAwZn2UABBLzgye/XbkiPA8ulx7BGNd40EQPsf7D9YBHvUMgk4gp78CW?=
 =?us-ascii?Q?o/FjOlCqK3WgDj3mULENpwaJ/ji7gGhmbygl+PrcVFZxvSE9LSgFmjajwJCN?=
 =?us-ascii?Q?JojoNtGHieRr6prN3SGuDL9WvZJNiCMAE/AZvBrjxUrtaY7uaxyYAzgrY4wY?=
 =?us-ascii?Q?+DFKeGi6+ImjsnvlcfHmAI1oxX1TVSY2/X2zUB+RNeNmxhkW5qJvEIMBr6Xl?=
 =?us-ascii?Q?EwqxI53esUrDS10drCaPyhgqTyMp/V9y2D1QwRJTMZ+DTd+Kwk+kGzQ7D9hr?=
 =?us-ascii?Q?8Lz/CY/M5gBB7++Fxu/i1tt2D8th1lW68LjWTjKDcu/VnsRN23EJeGgnpa82?=
 =?us-ascii?Q?phawPjn8UcOR0tCCLMU9GSF+KJXTgv86SIy/I+SkFQPrQ6EAI7xcX0iDE6Uj?=
 =?us-ascii?Q?mJSwV4GaoTiF/VC2e0DGwqJ++XLmZvHXkB61xsFWcNI20MTdAK2sYIGDzQfb?=
 =?us-ascii?Q?sk/g1O21eRcKrhzI0t3PfN1QjmDSmyigVR+XAiEuLRIlORmQIW9LfxSPIAf0?=
 =?us-ascii?Q?YpOMUXjMJDxEgQ1CScAIWVsL2NoLuARrqJ+NzL2XtHuaSlux1C4fj3lUDcbX?=
 =?us-ascii?Q?4JUFBiRS3HtRHMI2Fog7NyrYyBYMdqJ4kQxLXNmaJltK1lV6I9Sy1mW3BrbG?=
 =?us-ascii?Q?0k/VOjk4//mHyx1thSbWKMBBFX50NUP4ys0aLMT/N/FBFfpeOIN5nNJjVF8Q?=
 =?us-ascii?Q?Aiywq2bxKPduZnbFv2bOU5DOyr9+/PpwvcRJyfvAZtA95i6v7hIzbsl8KWeM?=
 =?us-ascii?Q?OQsqbRKYTIcLQ4FfC6lvRFYDQ1y5CXWkT2N1wiegjRPur9NvmH4Khzuo/NY1?=
 =?us-ascii?Q?WhkKyuZSu+tgQ6Cd/8MGXYCI3SXlQpGIX8HVK5YjdWdGKxCgUwchgE0130Sv?=
 =?us-ascii?Q?UCs7VoIUTeZmQeLTrTh1pZTXKw8ENZbqJqUd3gI8fDFK9uDG9yQ1CC00TAIv?=
 =?us-ascii?Q?75Vv6wXfOYuhVKIvgH1NEOwFFzLFuKfl8wnJvskGEZ05pDmhqjxcLw1YYdW4?=
 =?us-ascii?Q?t67BcviiVh1h+lqlICjQWqNmDgfx3RYEv5N+QrREjnM3LpyrwUlu5tDFqGX6?=
 =?us-ascii?Q?EdFOkPNLhz2Rf6FhHkU5eQjArGMnSZlYYrEFCs1dVLE0L4t9XuNx2SJAmf83?=
 =?us-ascii?Q?W7FxHRAy8KSBEFQwtMQw+4rZykbUab1CNZsKbRR6cglpOzUef75TXhSZfZ1R?=
 =?us-ascii?Q?HMbfwO5lpKnhw1u4Fwl9zUGT7afKUewpjUaZeTp5Co0+QSz4Gb1zQC11j42P?=
 =?us-ascii?Q?/toRb/bwkgU1dDYsaOMGIHLQb09KmLeWBaHPqt8UOyzFljk+cY3nApb7hsj7?=
 =?us-ascii?Q?m5bBX4RxDYBNIn9r76a3vye0VMDUz071DeRW4ovNHZU1DHE+Gl5mloRwOMFx?=
 =?us-ascii?Q?u1zCxUcnMrM9exAFYM7Rx4m5kZcWuNqo+x+E2GUNIu/uoxqAS5/QyE5+qr46?=
 =?us-ascii?Q?Q3hb4LAjCuTBucuIGBqKRCd77wXeTb1niikY/4n0XJIyRA12AVizwvjsymkK?=
 =?us-ascii?Q?DNCSP6tI2lCV8Mee69rxBXHCV5FAcc+r5Fyvwom4FOLERVBjpRy9UV1mMUNF?=
 =?us-ascii?Q?aIX9FWt2lcsH9NWaiPg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB9273.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78639fc3-1c28-4eec-aeee-08de0cbbbf20
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 13:56:03.8033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPonqohnlNfPzlA5wFFkpkXuQGwlUjf/9NJ5gbQ/c7++wP47BFKTKN2ZRPQWekHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> Sent: Thursday, October 16, 2025 8:55 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Aaron Rainbolt
> <arraybolt3@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Pe=
tkov
> <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org; Xiujianfeng
> <xiujianfeng@huawei.com>; xiujianfeng@huaweicloud.com
> Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> [snip]
> > > LOCKDOWN_DEV_MEM is an integrity reason and should not be used for th=
is
> > > scenario.
> > > I'd rather like to add a new Lockdown reason in the confidentiality s=
et,
> > > maybe LOCKDOWN_CPU_MITIGATION ?
> > >
> >
> > Ok, that makes sense.  Just to clarify, would that mean something like =
the below:
> >
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index 3f9410dee67c..9b4864f84146 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -691,6 +691,9 @@ ssize_t cpu_write_mitigation_options(struct device =
*dev,
> >                                 struct device_attribute *attr,
> >                                 const char *buf, size_t count)
> >  {
> > +       if (security_locked_down(LOCKDOWN_CPU_MITIGATIONS))
> > +               return -EPERM;
> > +
> >         /* Save and filter the provided options. */
> >         cpu_filter_mitigation_opts(buf);
> >
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 92ac3f27b973..81cb52cf2111 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -153,6 +153,7 @@ enum lockdown_reason {
> >         LOCKDOWN_TRACEFS,
> >         LOCKDOWN_XMON_RW,
> >         LOCKDOWN_XFRM_SECRET,
> > +       LOCKDOWN_CPU_MITIGATIONS,
> >         LOCKDOWN_CONFIDENTIALITY_MAX,
> >  };
>
> You should also add an entry to the lockdown_reasons array in
> `security/security.c` with a description of the reason.
>

Ah right.  Thanks!

--David Kaplan

