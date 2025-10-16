Return-Path: <linux-kernel+bounces-856483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142BBE4432
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05151346172
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C6339B5C;
	Thu, 16 Oct 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i8Eny+LB"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB0343D9E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628861; cv=fail; b=qvpMoynMRgct3Ap2boyh23ahZ/pSmgUvQMA4AS9+AzPo9GI5zQuQ2TlawQ6zQRJv5sQKxbyr4marGrOmC1OcfK1oUwbp62FOk9fVIeqiSGfA0+jwQ8U/Tzn3OOVp38n4GKtK/490TL13K3vCX2maBu551VsoVH27d+LWGLWpkPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628861; c=relaxed/simple;
	bh=99rCaoyA5vqGsYZVHhyMHr65rUkfJqnlU8vzpjaHMss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flxMaCAjusYIwBl1Slj25DGrWfSHX41sLDgTRTT6B8yhoP6I3oQE0TAzsdJQ3J9ozlNnWtBaI5OdBPyQZtZsDSsrFJblT8WTLXRAqqTiVqdifTCC4YCaGGolXOMl4bCJyZbG80X1ZSOcpQW9la9swgToXye1nUutVP/MZhK5050=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i8Eny+LB; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOaVhPS2TuEXzUb4Rb1oAijpJn69ervGow4yAcbKmvdfApWgWYn7+8j1zQKOVndSXUW0ff2l8RnmNafAZlleALV+S1n2TcheFg48h8riE388bNnJJtJ0j9ih7mwlA64Bdc3ToTeRGIko4qMTeql3bj/4qHSnk+0IYSKpSup8wXRp3kG9Gosv9ldeWgK3IqDt/IgwwHu1rzn6GISs4VQW2zY3jN/yy8GLokVgpwFWA3apQp31ulNKFLUPy5Smdq2LxX9XiUCDEL4xEYkaQkKWHfkHWOgCrP0342ghL9IidAzKF4GeXMwoZFy+5SVPiwSwLbgRU/D0APwZoHrL5R7+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EOQv17WLeaeLFhVvDO3cG18Aj4QECFIPak04AqKVs4=;
 b=Suy66OaqwYCC8xWMsyGgGoOR6CpSHWf0Hvaj0ksSSe976fqAwdCSv9+jwS725FZ8gupYQCD5FDt0cMufvflnsDX0dEXx/E0srcEAY3oGIZO7NIT2wOywmGz0q7cktJOLbLNMbtuCJmLnAZj79JIWTdk4yn6zRGMJO3YQSUXfNwaKtL6ebsYLUcRwywUxBeXB67ebdzPAsMpYizgcSrd3bIhX5AGIOwIsAxEgnJtTJgljIgAWE5L0D3YSdvBVvXPMehBTculiaxNwreuuu2Hcxig4uNQxgMrH+/kpDNUt/n4XX62BVK+Aj7UH2bh+RXKP9YToO3/sj53v2A1xYjaU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EOQv17WLeaeLFhVvDO3cG18Aj4QECFIPak04AqKVs4=;
 b=i8Eny+LBImNsTUlNNal66FX0y8HmObXqM1Y8/RYgOeeLcjrJYupDCI5Vk6AwPqsdjzV+AsDzj/qbqoupk8oKqVXpN6tmnhplj0Q0F/rrloj5WCoxtnw2gMTdC3HynSkJUiJPsgNF/1rgdUjd2lGnM1Zz14S/UaouaF794B0Lmo0=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:34:15 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 15:34:15 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Thread-Topic: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Thread-Index: AQHcPoiqsoexywdJOE6yXtrK5ZRlk7TE1yEAgAADZgCAAAuVcA==
Date: Thu, 16 Oct 2025 15:34:14 +0000
Message-ID:
 <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T15:28:57.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: 50895161-ad61-4094-de4b-08de0cc9769c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VNvcFN2B/EugsQGwVARk9TJ6vgpuFimt8WfbOItf1lMW4IXBS30btXoXxOb8?=
 =?us-ascii?Q?e69aHaqCJzcurk3R/0LFk2vXRk1ggVdN3cne2r2iEuYS3TkarhqhOmolG0rW?=
 =?us-ascii?Q?TBkCoGC8qQLDvE/qGZ2pUZTs2ABNDhpe3CeH8JOvAMn2x7d5Lsdf5gOlQeUU?=
 =?us-ascii?Q?vHYUmHKVHqJwLVRIdUbsogeOPL9M0+iSu3kV6QDh1E50U4PC/4uEd97tePOe?=
 =?us-ascii?Q?NqIBPVThKG3JZSGn3PEvqKn1RxMOZSUyUAELnFRAY1LreSXsqS+gdiGhcJLo?=
 =?us-ascii?Q?+58U8ThC6moaGWLCEqFrNgTEu6zFSvn/5Ua8JbfmIhgeK38gz9RBFtAPuVGn?=
 =?us-ascii?Q?MIG+wcAt44muzFCfNvFZsQmmK8wvUW/m4x1QWkmBeFF77xPxCiC53e5NtVHX?=
 =?us-ascii?Q?L+cvdLKniF1FRwawhb2lhzQ5ChkkIjM3GUd2k1Xk3n5OBO0xEzLQStgUma1V?=
 =?us-ascii?Q?SKejaKkL0gI0rwXPxTzFhLFoLRn10voC7y7l0M6w8g9YWti/s1CUVgcUO7Zv?=
 =?us-ascii?Q?YvjwhaRtDT3ZabF5QRZ365WBkhCGaXMQpZfdbHGbGDEJHJUliQtD+K27MLO6?=
 =?us-ascii?Q?WdHLbDSSVaf8VhrOMmS8MDgFbxZO2NhVLkDNsKcJiH2HwAVlBvqnSRlunZgF?=
 =?us-ascii?Q?twFd7s7KA9dW5Gn7pMa0VBFzbxLJbSSIdVuyONCo7Qf7aykq8KKCSRh0HOy3?=
 =?us-ascii?Q?ky47FFKjMxkcouEX5ExZ7yPD1giyNAf8G0+RyVLebnLvvHp0xpZvhWICy1xB?=
 =?us-ascii?Q?YFJk1zkeEWb6bccwU1O2Co5TbQZDAWB3usMfs1gkDdSQwF4oQxpuR+NOkAg7?=
 =?us-ascii?Q?fvkW4WnroQFXsdGG33hWbkR8MznER9tS18eX+utuLD3m6BjiEgtxLaWHzxJl?=
 =?us-ascii?Q?F6Y1axNdQzXtYxLTvnLhIDQ4hLHjrhsT2rKLT0p7vXjcQQFvogxv1Wxf/uGc?=
 =?us-ascii?Q?+ZzF4Akezed+iGOWoEjnblcTN/E8vR6qyLPYGUunQ+zrDYMaazPZBoHRkTfg?=
 =?us-ascii?Q?4V/d9JmlviPTDegdi4AFUmywDxzmG3PT1aivBFIGKsE7M+CZ+xNCfCf5DUMo?=
 =?us-ascii?Q?y6QLAyEb2n2VNRp/XRlqUfRbjZsV8w7LdbUuDOrW8knmCDaPR+jX5w5KgGqN?=
 =?us-ascii?Q?tMC0pAkmCtVl3AyJU6CdCi0W0idk4mUqsS5HL5gEJZGenVjWvjgVR/2BWDIh?=
 =?us-ascii?Q?mqVIZDaZwrISckcUHv3GeQcrXymM2c1mbHTYutXWrGM7wbgfOeEr1qNsQ6Hc?=
 =?us-ascii?Q?IX7JSbegpwb7eBpAedgEA/9lw2zfngc4Ip1GNTNKTpNJparAs5rNVD6hKY8H?=
 =?us-ascii?Q?aCkedKKw9RlW5fUJzt/aiuMNEISrxsgFYQEjAcOhxO7GGkbbbGqvbe+2/fL3?=
 =?us-ascii?Q?ZEd2qavekZTbSz6J2p3dnWcrPwlx5+fbyc3qA9MUWxgNUMavqtVtdohiY2I1?=
 =?us-ascii?Q?QjhVgc6qJMEl1rOpSjtzexJOZiC2vn9pf1L90J6ytKBvj5e7xhRuXXNGEYCT?=
 =?us-ascii?Q?0owDaWiP4pYHa0w8vEdn0enq8NT/EbosVyu3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gbeYr6J/FMNwylmFqbRml/JdLqcuNryvEcnzHXVSSfUNIutuhuibMQod1eF7?=
 =?us-ascii?Q?SIxFGi+875oocwtSE0Knpi12s3BltTBMYUIAaT656KYo+qXwjqUPGJeE3yWL?=
 =?us-ascii?Q?ajOwH4OsjudHAdNWaMwRsI8tWWUceVPdytoUQUordBjla4cDNHj+7x0kYWSy?=
 =?us-ascii?Q?3MKxmZVH5fFII3mAbmLQF1zIUIwPxtif/+7h5aVG58jSoXXB1leDOUyNRcMh?=
 =?us-ascii?Q?iJKXdskzHayfHRb8X/bBzYfcLPjw00FK9mTGxXuUXUkdvdA0HrpS1KGhGstP?=
 =?us-ascii?Q?6Q8o29VeWDsJKOjzw3ovnFmBiYunC7rNbueXssi6fNDlGjxOr1cS7exmIjU2?=
 =?us-ascii?Q?5RcN0ooLKt9rO1DJGu6mGKMSzAURNtNhcKjUOrThs+nclIp3nsqpg8/ROHeL?=
 =?us-ascii?Q?0YtpkiTplC2pc/Rl1+TJbtCO6o/xdi0LW9IuByam1ZqcvndmmcL1mO68BSTM?=
 =?us-ascii?Q?xq7FDOUEjHXvpaWj0XEbf27qnp1LiQVQ/PsQ3qxqjZXV9hUqwzRG4BwCApOd?=
 =?us-ascii?Q?DYrqG6YFSF8DLiLVSWBfttsuXcORC51ol6aT34skZhKbREeEhx5k9ytfpMPC?=
 =?us-ascii?Q?8d4v+RXA9FOKzqHmF9zJqbHkqQ7SjKA92SSAdIrEnSxoR38AkzA4qkfZbFMr?=
 =?us-ascii?Q?cUFAW6A/uGGkTB5iZnFe/aWfLz2riJXSTyn+Lha6Ww1HnIooP8CLltoWWxlf?=
 =?us-ascii?Q?HR5LVHJZWUJ1c8HQyeMAr91+r4Sis8CLq5oa1BupNE9xp6FlXgVOCCf1fkB8?=
 =?us-ascii?Q?Ic5nds39IikLalswQabbsf2oUoxo3rE9mfpURjx9U1Rs+MyVhnEnhT4j0rQR?=
 =?us-ascii?Q?nacLtPuTk/wxdkDXv2tHsRdG1MTLxxYXTfSSIzA2nLVXLS8mFeXvnxnPDmcg?=
 =?us-ascii?Q?EP8tsQXzeLLvGXHCHEKgjzJ5/1U1hLdxqWHO/lzNiF0poeNiDlYjp7COZnxq?=
 =?us-ascii?Q?xbbsEh1wHvEAonmmJqw/uWvhZEqsdg9Zq77MzfyHYz3mf0FoI7dBNFclDvTY?=
 =?us-ascii?Q?7LvmeVVXN3se2S58F0DvC2/KKyhHfGFT1NC9q/ncPQgtCsfVLehucEBak3PG?=
 =?us-ascii?Q?Sgrv2C6jHyYO/jEAYEoTKSxKWMjsnvcAiR+t/5XspdaXy1WlhWJ0M3D+Nhy+?=
 =?us-ascii?Q?dg7pegaeTsqvUJeoG1y+QwfSYYCd3n9XYTQFM4Y9yCpQYq9JrTzymyiKldqe?=
 =?us-ascii?Q?9ikJL7frO8UzC2aGwsRG3anewVUe0vAOrsMOdsT8zFuT4lcCOvyhTwea/kVG?=
 =?us-ascii?Q?v8Xf9QBP91rrMN7gW1iTzpBRbkbhCKQItwda0t47MgUmholAr5TQ9g3z/xML?=
 =?us-ascii?Q?zAuX4P9dXoYyE0SxndGK4bMkNhu2O7ElCbU7bJBhjpZTBwR8NxYuvz88VEHL?=
 =?us-ascii?Q?dvXfd212ZHjMKfvabZ1tXQxrRBGwX13wnrkG7jdIUoq/Pvd6HwAndMu4dZuZ?=
 =?us-ascii?Q?2dFNgZMtm28IhJsLyf5KWZAxYpoxzOoGrm2WB6Bk+ucs2p4Eda9R+Quz6uo1?=
 =?us-ascii?Q?jjrDGsqVdtaND2QZd6BOyu1N4TyXV5BDnXZzeAVfttZGgiUQ6zsDEhyuFk7T?=
 =?us-ascii?Q?laSDxlZXaE0fM70mYUY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50895161-ad61-4094-de4b-08de0cc9769c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 15:34:15.0724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glN3jBg6MNWs21f5aNrVtkER+0RV3OyxTc+R0xEsOFdgckbyhZGRomGat82WPtCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, October 16, 2025 9:48 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Josh
> Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Oct 16, 2025 at 02:40:51PM +0000, Kaplan, David wrote:
>
> > > Can we please keep this in sync_core()? Something like:
> > >
> > > static __always_inline void sync_core(void)
> > > {
> > >         if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> > >                 serialize();
> > >                 return;
> > >         }
> > >
> > > +       if (repatch_in_progress) {
> > > +               sync_core_nmi_safe();
> > > +               return;
> > > +       }
> > > +
> > >         iret_to_self();
> > > }
> > >
> > > That way all the modern stuff that has SERIALIZE will still use that.
> >
> > Hmm, I can't quite do that because sync_core() is used in a number of
> > other places too (unless we make repatch_in_progress a true global).
>
> We could just out-of-line the thing; nothing using this should care
> about cycles -- all of this is quite expensive.

I guess I could also just add the SERIALIZE check into sync_core_nmi_safe()=
 and prefer that over mov-cr2.  Although as you said, cycles shouldn't matt=
er...

>
> > I wonder though if it'd be ok to have sync_core() check
> > IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS) and then always use the
> mov-cr2
> > version?  It might also have to check X86_FEATURE_XENPV and use IRET
> > in that case but otherwise I'd think it's safe for machines that could
> > support dynamic mitigations.
>
> Yeah, dunno.. I'm not well versed in the virt thing.
>
> BTW, will AMD do that SERIALIZE instruction?

It is not supported on current parts, I can't comment on future ones.

I will note that on AMD, MFENCE has the required serializing properties (li=
ke SERIALIZE).  On AMD, we could use MFENCE in sync_core() which is probabl=
y faster that iret_to_self().  But again...do we really care.

--David Kaplan



