Return-Path: <linux-kernel+bounces-869064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC5C06DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 838F05088E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE533132117;
	Fri, 24 Oct 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UYSCSl9B"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF631DE2A0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318168; cv=fail; b=llTRv+cLOAAnwHwC2jbfnROmGpvW+BqrAoLqo/GNK2nRTIwagAaS8e4q/RpJ+CfvVWBe8t/y7grINFInFYrBEGrWVBS18vWzwmPChJLPfll/uQivsaD6stu4DuJQZ5y0vpKZwitRaCRzyVY1Xz4+pcW7dWjC4Awuv2d23esbui4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318168; c=relaxed/simple;
	bh=MqkSF65sAMlrFWV6c1ua/gHhIAujVdC+hyYamN51oNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCwwO0+E6LfSIYbwT/HTASbOqoKxkruS6qQQlxLLn5fJ6popet1Wo0CRrWA7cWMsuaIGPzbczcZ4PEysgsFknYmhX3f/VOlOTwG69PYaNp34eqR6JSbyH+A09vXGc85viWHEa6Gb0F9F4W5wfOhffVIsvn1ScAW2XlSuM2xV330=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UYSCSl9B; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBRryJWfvS/0YRp7FCLmQpXDZ0KfyNu2nBubqajxVddPfZU2/NLXsSoJ40qnGkJ3OIp7v9KX6yLFsuQ3GRsRdUu2y1vyvELiQK6mbH3qMDybtSkwx0WtwhGqCQQd9o3rbu52yqT48y2JuS9esM1kx6mni7dmitltMgtiEU8GFBzXaaa/R7/zd4lsR1KaJSUGabTkj2cPDHZgJ3ec8chEHxJaWK3VYRYuUi+i8kgmXKBKiD4LrILrHLejkHQqNEhcyA4TSCyWjlHajMW+4Yu9b0T7eSRKmJpwLao7GhCUQdfXo+NO3IMSjKA1HilDcsdEZMbx22M2a8lnt85fYTkRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGYqhBbf3qhx9uU6jfSqyfq3R3ZZffcr4OZaXZEszz8=;
 b=mMKVx5mCB530iqs4oTn0NJptsMU9Y5G12K71E33NTrF+aQv4ufkApVhpkkJZqyWLInyS1XuF0FAYbiqPb5uqu5LHJnmXWX5Ue0Eib+xNQD5Dg6Y+8+RtOZJNnL+xJalhcCMBTXGoRLgZOdTHp9dgRFnt2i3PRRA9FtAPw4TiDaNKXBn7hfyALfYunwHVW9cPXZAaYF0OQReRKjR4mO8Eq1yLpGssnUeblODXjXfXJM6w0uDs+r/kI9uMb7pG2b5vurKDseoUuzowO4PthLflzJ1PH9bXd0v3AGNJ1sS3d9pVtBVbXUui8e6jzhsU+1Vi3SYzES4q4lsqwhXIO9Kf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGYqhBbf3qhx9uU6jfSqyfq3R3ZZffcr4OZaXZEszz8=;
 b=UYSCSl9BZQ7XNazl2lEL+lcUmhe01mMYFJGq6VXUY8MD5/n3KSGi0bsXNIQJqwAMdn24+hzRVazF2nG8nBqztTYJwd0zqECrl/ECCOYCHlvLCPKoIr7h6HENv0gKwt2bRumai4O9L/CLPf2KY4wvtLqIV/iPFAa8mPTIK+S6Iq8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by BN3PR12MB9569.namprd12.prod.outlook.com (2603:10b6:408:2ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:02:42 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:02:42 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 15/56] x86/bugs: Reset BHI mitigations
Thread-Topic: [RFC PATCH 15/56] x86/bugs: Reset BHI mitigations
Thread-Index: AQHcRJDSiZRiLd9B6UyxePn5mxOqErTRZK2g
Date: Fri, 24 Oct 2025 15:02:42 +0000
Message-ID:
 <LV3PR12MB9265D95322DCF678CBA398F294F1A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-16-david.kaplan@amd.com>
 <20251024024918.5ytpa7vrcny6tngt@desk>
In-Reply-To: <20251024024918.5ytpa7vrcny6tngt@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T15:00:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|BN3PR12MB9569:EE_
x-ms-office365-filtering-correlation-id: a6ac6566-d1f2-4900-eda4-08de130e61b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IO8saH1U4TxVmf8LgPeKndT1qPkgvDOD61j+1LxfkYOPKAbARgY1F/Is9efz?=
 =?us-ascii?Q?bqkTKMk6jxu1aEzYKGKzSKFC9un3HgZqqe34UcC55fhG83CWCRfl13rggQ2J?=
 =?us-ascii?Q?K4X9cxcn1aSPyLYqGVS2Zrx8riMPft4jZ0APBDLbPnK1ZygpC6qeczb5I6YC?=
 =?us-ascii?Q?swBwqOMu8+hQfvZhi+VsdRUzmwdzYIUuMlkAZYiHgWNAGgKLkeOFK+IogE6e?=
 =?us-ascii?Q?hkKjzPJTTnLWfGwIBt3Y1Ypc7S+SGaYNLCu091kSR3nR1Li5Z8OSkZiUOopr?=
 =?us-ascii?Q?h8MnoqT/qe7peVlXDkK/c4RwOEOB+ycvKULfPsL2uJBDOYsqeeON25Hc8d9D?=
 =?us-ascii?Q?5sWAd7o9MchBAoYqVhMqhfm7a0m6Zp9/qLNzNUaDHdDJPqZjIjW4487DtGMJ?=
 =?us-ascii?Q?xD142G2/hp7C4/rWsKi165oMiZA2edcH9CPmeYdmNakGUVahIIqbiy82hnHj?=
 =?us-ascii?Q?9suPByAh72sMRTVK6czO48yrcMX2gJcyn253B71T4S8ZtAwY369egwOzeqNf?=
 =?us-ascii?Q?QzAaNus6OqNEmwFLWWC5pYF5MGHIppZsXV6fbpmHv0gUqOg2Vb/XQCqi8+P2?=
 =?us-ascii?Q?4Qpf++iJUoDMEaqXjgLjd8wuiXmp0d8CK/bm/k85FacvdPz/UCuuAbB8XzlH?=
 =?us-ascii?Q?DmFem62b69Uehu2eyO/4Umd3se2yQUJxg32FEcFh4j0axBm1V4X8w5sd0rKw?=
 =?us-ascii?Q?X9MzjryoafyutkknC5uWZ5Y9t/8MPK6+aP6q+8Mo7xn4ZuC9qyixazk66r53?=
 =?us-ascii?Q?v1Z6nVS0MJhWx+yB/6cnp8St7ncpQf1cML0IY0G9dDimEBMUfYwpRvsv2ypZ?=
 =?us-ascii?Q?ckoTrmI/GG1e3RAMgMS6BQejo9U3veP9W5/MRx53BwscPM51MFKU5T7vo0xL?=
 =?us-ascii?Q?cifbEUbOXp0j6RExrFrl6BFUjl8iwEebk9tEuZYF7A8+XTrsOJ0Fp8iAITQ3?=
 =?us-ascii?Q?pjU7+HNijoeNF19TfP2qgcYDKHtBK0NyMzGZ7MpMZiPQ8/PJB5/8Vynhx39r?=
 =?us-ascii?Q?k7ktjdTQvSyoecG+xZcircSJWl9ePcBzq/5ntMXsCrg0OUYFwzgFZP0HYj1r?=
 =?us-ascii?Q?7r5FPdOKtjRJaLVR3J1DKXihH0Aw0/+zxNMkyuyN3AuYgKNYlOThCjjc3ZRy?=
 =?us-ascii?Q?O5X6K4XwfA/Rugvtp8CsFaYtpW0C875RB8nMXefcUeN9mA5hEOP4VDjjxkg7?=
 =?us-ascii?Q?E+tYFj0jpGw8+m10BZEM/Zq/OILf7OFQAVqxhgy484iFPl9T7fZVdvh4uR/D?=
 =?us-ascii?Q?Ce9RWooOfkY+BXL5cbB1A9R/hpoPKKPxeOk4ItlJJZfzT3cEED4JXsH6gk3L?=
 =?us-ascii?Q?pG+tD8emW8QCaHuJ5m47KxJ1DKCWeTiJNclzK6USRJPOnLs+7G3ZElfBp7/F?=
 =?us-ascii?Q?MDGbHZZtWVQVqxtIVt3lGFaEaDlSEgpCz/oiKO+690Hy3hCzer81RzU1nU8W?=
 =?us-ascii?Q?39a6sqxCGDlfiQ6hnZIsKN+xE7Ps+KS58Xlgo++uKEsecbJlzm4myqkYdpzu?=
 =?us-ascii?Q?We9hJjMDZoZN1xdm3vve8WIitUolHX8x3/t1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CT8NAig5+F6XBbnQIoLpXVq3itjq/QssxuJJrHqJx1g4kumsODQztkCfpplj?=
 =?us-ascii?Q?D0mlMRiTv2jwHL17kR9ne+d9CCUAHpMdzqEtKaaAnss3oSPehs9h7o1HbFZ7?=
 =?us-ascii?Q?JhgqDIECNb4nuv9Jxv27v+qiMJYE2NMuzX46PDnKb0N0cR+HO36t9aLefyoe?=
 =?us-ascii?Q?9P19ispGj2h1YGRrNApphfhEodlOZhl3qPpksHwB8m+NTpfSsUFMqVGzss64?=
 =?us-ascii?Q?rCGE1ZQwM8tmrHJmi5iiPq3OwC/H4/2WRKKafnZ0dhx1zbuB55DYivqVhsWd?=
 =?us-ascii?Q?oHyCPr2sYT2VFf7vAM3bnggClsqP9x1/x4h/Ue02m7Idfwpe35IGGWBfxybZ?=
 =?us-ascii?Q?77UXKPkr7CKzQz+BO2+VyWbBsk+4RoWpSAJMv+f3a/mPEJD64lBn0KlaXl1i?=
 =?us-ascii?Q?qezQGnQo9Bd+KiJAndTA8ddv5eMQW7XMTts2+UuKOZktg/m4eTpOMj2JCgJW?=
 =?us-ascii?Q?vk9Ey1kSpjRJubxbF9v6hH5H+F7X8IuKCdZOrqUwlXYws2Y3aJlYJJOYntf5?=
 =?us-ascii?Q?wwi1Ui2MIASLmN4EfAX2MW+03MjKgRx8MItCTue9GAg6KQCyqNC9W2/Ngr6f?=
 =?us-ascii?Q?Bz+k9cvHKjzpMnEpf1YTtia8c13dHgUshNm+hdEX9qPrp1tNI2/1kGfK1IxU?=
 =?us-ascii?Q?I5zEbeboPVwhgOsNztQTSwLllNnkRkl/kHj1gTX/rzZ/imgzGsJtl2Saw8NY?=
 =?us-ascii?Q?OdEkW01Gk6p00DL4ZK+wrLPWKmaM+m7BC/X7NIR0hVD+8GUGZw5uWCiHGPSz?=
 =?us-ascii?Q?pAOwo2T8gX+nVpjjUy3Mzmx/FVI5/LZAvcsgquUAYKFbGmtxp1tTkRAgs0/j?=
 =?us-ascii?Q?fpuNTQcPuswLJTuyB6vMu0AyV0r0zNeg4xL7gP4gPY1BMsp28FUQonl60ql5?=
 =?us-ascii?Q?ialo9CykcXxqGyrCPtRUWiTrNFBm5a4S5kZ+87aU89Lb7UJQkKYzq0PjeBYn?=
 =?us-ascii?Q?iH/qWCHat1s/LhBFcnRRsnxeXmBNvIrQySN12gEEd3YwbNMReZzRvoboS3QU?=
 =?us-ascii?Q?GRV1jlALjY2NbKradQOM2ZgVYJznCiwsE9T8fXbQI4tX53X/CriB960JUjXT?=
 =?us-ascii?Q?ItbGQpdBRi2YkOnsL8iNEfahVsQnd9u4ZMU5dA9A6FhIdpRskDIYGAq3i5NL?=
 =?us-ascii?Q?m4QEyuTZOosIXTde9itLnjTiMvNMlblfk/OxfSoKRwN2xOJrIqpdooWXesbt?=
 =?us-ascii?Q?XL1zYSoULEF8G+J7IP0uB4nvreiLlVZ47LD5wExeqDcxz2cIkjXQb3M1wgZE?=
 =?us-ascii?Q?tSXcd/9xjJ0OpLRNJg1Dnn/jutWFrHkl7sjMiRXrFBLhW0+LI5cRJr9TgxH7?=
 =?us-ascii?Q?q9GHi/ik9fqTtMyPnPXK4j6BkajNWfcsSLn27IIDP0M+12Gm4ydlpK2r4Xs4?=
 =?us-ascii?Q?nWsU/HMyb5a7zLupxYPyg4DYn8uIfwI6abmYlz5aGulrZdPNk6bUAtX/KFhe?=
 =?us-ascii?Q?HHmgTakTbSPpXKb/aKrTeJTQm2qDS43153Xw4OPxYBldmVbN/4fR4xDQtm+x?=
 =?us-ascii?Q?C9uhRZ2p7gelJkbGsnikIXqq3gKflSkCZICmT/eLgRV7VEn90sa5tgW5Vr4g?=
 =?us-ascii?Q?Ow67/zflVwd/IlJmFWQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac6566-d1f2-4900-eda4-08de130e61b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 15:02:42.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X23k9dpHhKoPFQ4gB28/5msj+xmKnpmWVNSiP1jqgGM1Z++mLLr7CZCqV7InW2r3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9569

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, October 23, 2025 9:49 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; Alexander Graf
> <graf@amazon.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 15/56] x86/bugs: Reset BHI mitigations
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Oct 13, 2025 at 09:34:03AM -0500, David Kaplan wrote:
> > Add function to reset BHI mitigations back to their boot-time defaults.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index e765ac0b9240..67561e5c2154 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2360,6 +2360,17 @@ static void __init bhi_apply_mitigation(void)
> >       setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
> >  }
> >
> > +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> > +static void bhi_reset_mitigation(void)
> > +{
> > +     /* RRSBA already cleared in spectre_v2_reset_mitigation() */
> > +     setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
> > +     setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
>
> Also needs to reset SPEC_CTRL_BHI_DIS_S in x86_spec_ctrl_base.
>
> An alternative is to add spec_ctrl_reset_mitigation() that resets
> x86_spec_ctrl_base for SPEC_CTRL_MITIGATIONS_MASK. To be consistent with
> reset functions of other mitigations, probably also reset the MSR.

Actually I think it's better if none of the reset functions touch the MSR. =
 That only runs on whatever thread is doing the reset, which is random.  Th=
e __cpu_update_alternatives() function will later update all speculation re=
lated MSRs on all CPUs after new mitigations are selected.  This also avoid=
s a window where the MSR setting might be insecure even though a mitigation=
 is not actually changing.

I will add resetting SPEC_CTRL_BHI_DIS_S though, looks like I missed that o=
ne.

Thanks
--David Kaplan

