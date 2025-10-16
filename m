Return-Path: <linux-kernel+bounces-856321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D32C6BE3DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88AA54EADC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4481FE44B;
	Thu, 16 Oct 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOg7FCTn"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8165D1643B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624172; cv=fail; b=lg3pEXTDibsrCeaB0Qzp3KV9/qNDfFZFTzENU4wW79qyH4ouNRgQhp2eKOLro4msrfJLmZcUMdxzWjLpq3x86x67bW0fEu++TjFXDDQBdWqHLIr7sekVf0m2vcje/ad8wJgJaWtU+KqZq6bHyeYgp2r8t49zcIFxzkeuqHdzK4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624172; c=relaxed/simple;
	bh=RcFyO9C19kOdl/Ml+vDFxcHHTp+6XX2mp7Fh9+crc8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxXOzUG48g2aGsynCWUA6Lf6188Rf7SxJfhD04XlhsWEwIJEvMNy73cwsLKAO7kAytN4f2QjRlAvhW9URcPpKzhYUug5T8AnTYnoCrmqjse1u7TwXq/fubXZLQn4aFQ8DdjOB0PYzbQAWewjfbEttRwJP3LmDLl55a9XRlGQC0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOg7FCTn; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVDySfmUFx8WlY2AkQqL7fltClll0pYFxzfXw138M5WEhdOkyZc5bgc22doQcakW1uTbYidxNLp5+RvqRpLjfyLuU0cj1eZ4+O4EQlnI8V6dIhhPMSreFu6i1G7x1icWqA+8a++E59IUes12t/zJQoOTA0rs1WNZKW9b5VuzkQqyepjaRKK2DaS4uG1AVU+KzC+XaDJyRHF3z4kwRAxZEy6ZkxivbapgUKArVKbh84/moFiRCdE8wykS001GRrA9W1w5Qgzh4jn6JCIAEH/8laq2F2Nuh8tJ92SK60Vuy7JHIT4+akXS5/AnL6YXl/ZUzAFX7Oj5PhyhwQhfG3nPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQBP4LxgLF244x1ioORclu9Ji9+JvA8JrfL8lReCwYQ=;
 b=yeaZM8Y8EQc/OKsrpL1yNXNc+WYnqAHZTSukZPunhE2k6+KlS5QohtyYLwXjuSTRznhos3lR0fk1+4GNJFHZZ3+xQTodVJoTNw6vd7hQsxIW6InITMZ7wX+62Q8d39ZjzTivLgKOJRhRObH9M/Sga9Ek+Pgo74jg6V5IQT5nUXPivYUOQth3wovx359V2ILp8dlp7UY1kQnqOFyu1Kbw4RAvsFgZNEMbXy685LFj/37B/VHpPUXi+o1X+dfRPBJ08HgAPUTv+m5n8Dg1Bn7LBFF0LOmkdv4VFFYzgIXS9NODokGRbqK79Rl/l0eGvpg7FuunP76vcEA3k/nfxM++EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQBP4LxgLF244x1ioORclu9Ji9+JvA8JrfL8lReCwYQ=;
 b=pOg7FCTnsCjYkBYotsduyEbjoFgECJs9orUMd4vM/PPOwEvKEkaWbrzLtN6X/a1pUFmuSzRWQ4wl+nMPh3oh3w/OrN6QseUH3v1+HwUOZq8NNf02DbgsBfic/2Lo4ZN2nF2mbUimddT1iT4wlRe84MGLYf56SIflp9eWge6WxmM=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Thu, 16 Oct
 2025 14:16:04 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 14:16:04 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Thread-Topic: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Thread-Index: AQHcPo0Ir0Tctlr5bEu+zRmeqpsk+LTEoXuAgAAh1bCAAAwCgIAAAe9Q
Date: Thu, 16 Oct 2025 14:16:04 +0000
Message-ID:
 <DS0PR12MB9273D3CAD0EED60F0CC7547994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-32-david.kaplan@amd.com>
 <20251016110717.GE3289052@noisy.programming.kicks-ass.net>
 <20251016112327.GQ1386988@noisy.programming.kicks-ass.net>
 <DS0PR12MB92738D3C38021EE0B693326994E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016140731.GS4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016140731.GS4067720@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T14:14:26.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|IA0PR12MB8745:EE_
x-ms-office365-filtering-correlation-id: 1832cf80-0a81-411c-61f2-08de0cbe8aa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i5nQK8i+e8FqSecgx+8FDbf7jE2l/N9oBn2z2spygZXwCyHgZ8vt+aCn5Zcp?=
 =?us-ascii?Q?WedTD51KiWKGqMAl7hsh0jGLGFy0gCssUw1PaoylEh4YScN3fRXdZ28ssIcy?=
 =?us-ascii?Q?BfBBxcMX8yyfTPXSNcTAM2CVv3b8oVDU7qRI/2AwSj7Rzl+aSoZ7aSGIDrUg?=
 =?us-ascii?Q?Pbo5MrWSBRehZBDvx2+bGR9Yh7Ba7iP9xxIM+0OWtSUSbxf4990gwg/VoaiZ?=
 =?us-ascii?Q?hOFWrGnhjZnty2QDbJdjV0InCDo6cTPznlRVeTsVPmssl9/tI7M4A+PuMdFH?=
 =?us-ascii?Q?m0egccOB4Tc+W2I+bbTzfvDf6R5jOrS0NQ+CRaawC0/dvycsQjfeKWgb0zBr?=
 =?us-ascii?Q?apY6QZpFA6QIFdaK9n62FwygDOXYU+w3Mtz6zKRxfLcjtIf+FS9cB1S1eqQQ?=
 =?us-ascii?Q?mSYsTQxa+a7osrNDTSU3DX4SmuMLcv+Bcco1Kmog/m8KIk5F/Oh/fWWghUo7?=
 =?us-ascii?Q?VLCVI0i4DOoZiGXGms/Pl5/1XWoA9P48p6mQHIlDv08lkIu8TmTHVIO73xj4?=
 =?us-ascii?Q?WufeFhv91n8Iji/nuGBxkZZIunWHMkfVZ3aL2YfX4QidOZHtR9OOR8b9eCA1?=
 =?us-ascii?Q?C1VvWxogkiSNPVLuUZx+4DLJXo37trbJSsgkafnnSPT9uWKUzj0NA4wE8542?=
 =?us-ascii?Q?250uWWLqulRXiVqj2im8c5J4wk4o8hPe9kuIE7g/kJvBxcHUnPDmsdOk063+?=
 =?us-ascii?Q?7gT9zXvwFrh79EwhC1inQpBS14yfabCPmolcA/EhGluB5op73Inya9a+9ops?=
 =?us-ascii?Q?q4PztC28reUk/K1zauosvKKoQqwDg/m/lnY5KcQtHKsujCsugDOCJI8IB90q?=
 =?us-ascii?Q?IOcUFFUh7Jb/bh/MpKAfinAlZtafW2MTW29w6tHMKVxOWsM8W7j7gkokkcTe?=
 =?us-ascii?Q?F3OL3sjhM/3NoXpnLLQDbpRtuF3AL6PjiV1Q68kJiNcWodikH0BfJ6yx08AE?=
 =?us-ascii?Q?zngib5WhZ2V8Myey5NYicCQ+GGustJ43GPryOFXETVZ2iCijZUNU7k+umFjh?=
 =?us-ascii?Q?5g4yQy70PU3BaHGgu3/PCqjVYYxX+mtvDSuMotLe+ZP/OueeYESL8rsunwIH?=
 =?us-ascii?Q?PPX99HyQczARnC4j6BP1dDsdWCb0j7/IUZRlNiyP1AQwJV3BsVEbSsAYAxTK?=
 =?us-ascii?Q?RQM+Nux8vyRQAWafS49+p1MGrWswdpYDFnPSyS5+InhaGLJiTfvzNdDu9clg?=
 =?us-ascii?Q?uh+QxwQOJYS4yhHEbp4kRbuS1F8fMcqPTPZuvzSeP+m3gG1ZQ8caMlb9gs9f?=
 =?us-ascii?Q?rK3E7TpOmfQAwYjymADPN32cKRqPT+G8v2WEsKpRMRcxoM9MI5hHhcv72LLE?=
 =?us-ascii?Q?FRVn3vYga2cTgSiDoG4hk6BNIs7ooA5td7PRebkLneznLcOaMiADm8mTTHLe?=
 =?us-ascii?Q?Sa/lIj5GIi/CapthcP8bq0Y3/A1/zTTC3ffYFR8x8F/f79q8d3/gbag9pnnG?=
 =?us-ascii?Q?M581GTlHMmpypgltCqAnLJ/yUHSWoszsQqkMu9b6fzJd4YOK14E2AGfIGY3D?=
 =?us-ascii?Q?JvLYF/vuidrBStnWZXGTaksiaZY2n4wUC57P?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H64kucz09jK+7bIP1SUYygJVegrdAxty0m1jSxSv05U5wzhyTpjQ+CuA/9ZF?=
 =?us-ascii?Q?jrcFxXOqdwgCcln4eiI6tOQB0EmOV+laW3xtAp3icOThHjmE6B1Z2Sp3gil9?=
 =?us-ascii?Q?MHPR5vNuywHkwrVkZxsEk663WgIcv7hht5jejjiWFbGpAEI4nXWA/5qcTkbF?=
 =?us-ascii?Q?EPQ6sRo88Cvo1mfTKa+X6RPBRRMI4XGvD6cOd1qNQdi5jlKFz3RQdlFXA0Oi?=
 =?us-ascii?Q?rrlLLKdd03bKFbTZOpwDIMyzvHgyZnjKdOl/4WH1vIvpI1ywD84IlKgLGaTF?=
 =?us-ascii?Q?Qba0ReNf5qjiRPBtqhopNcVf1ShpxGfmFP+2iYE8YoUvD2HVjIVhX6k/XHA6?=
 =?us-ascii?Q?SMsOGbuGt8DSjik9nIFHsq7FNA3XfzSy2PV8mm7EthkIWbzfPMCRTan8Lucf?=
 =?us-ascii?Q?vW4tdco7VeDJNrebuDilG581Sgkn6FUB2iC0kx9wpds6lkpII1QHUxXPT9Fr?=
 =?us-ascii?Q?88QvAwGBt0GJfstdUZzHheqFjMaqS7Yy2ELLjZ7y1YpidPCgR705F8GOIm+7?=
 =?us-ascii?Q?M03EBESAdX4pqoSW0CJnLhtgMeRyqioo0aqWto/+xB0BLTxGh53Ogka4o3lx?=
 =?us-ascii?Q?Nn3OLECVF0Be+Me8bp1Rknw86xcDxcQJwmKUvs0woH8bKOnZnum9jLpUwXMJ?=
 =?us-ascii?Q?oHpJSFhGNzJxW/4cLS99ijihPLtO9qKWybyzsuq/qPcX+q+mAHmxzQCSqK0Y?=
 =?us-ascii?Q?aQQYakipjx6GigE/o3KBkXXc0WQKz7gs6Ra9z88e0u0nVQlz2Ar8wO0eeAFt?=
 =?us-ascii?Q?aVk9lME0CEp1kvKDzWnzt+Yi37DPXHSZf076CNlhQtCCNBGMR55BC5pmiYxc?=
 =?us-ascii?Q?lNYcw0jZKm35zlXZE9xQClTAKJLj3hPsB3mOI5I0pWlbXlYx+Tg34p+J7AsP?=
 =?us-ascii?Q?R46SebEzxqMDr85fAbr9KVxWN+zY6zOBb58hf5xboWu+UNO7C3e7dkJQpC/Z?=
 =?us-ascii?Q?obPRWhSmuil7OAesYDAfQlftVz6vkfnw19aHvigK/0zU++lXWXAdqkW1z/n1?=
 =?us-ascii?Q?kIhXEYYMyVM47nEL+ZVBMs+s1GfeE9af/Ex3bXj/WgpayEOsedyylcwfGQ2m?=
 =?us-ascii?Q?MzwexokNA9McLF22F4UpaZjXfyOhNaE+wSaGJaE5ejXVJCPJarjfCMTMCjIq?=
 =?us-ascii?Q?c3EOtfUZiRf0GIEeBI0vBDdn/AvDKuZjhRj2gBRssRU74vEIhj4ctqi18XhB?=
 =?us-ascii?Q?7r2ZKTHiGJk0aSz5F4Q+TUcIWDDl6uZWeizd4RvznTJWdEHxWskuPmTqovZi?=
 =?us-ascii?Q?dzaC0XMzR1Ujtcnlo/bJtLouva82nrFVB0xzn0kgUU+6KLcF+eDXRKBnd6/U?=
 =?us-ascii?Q?I7cFcoZLTuAwazKL5ToQMEL2xPO9bphdwHYZrA5kpOSoEbmFFV79dRdpOvqH?=
 =?us-ascii?Q?F2U7St3vpyciwjz1/q15vLMt7dJ7MDw5bCuhemzjwaJIKcCHraLEERrb/MZj?=
 =?us-ascii?Q?ctqfs6Sch3v4Omkfa1h8iU8ux1kU/Y3QtOiinPHYsmvVKz+Mnw8OdohjX/Jf?=
 =?us-ascii?Q?rXXrEVlt9ALNJ595QJqhpZygV9zjKK9i6+GkBVS+qDk+0so9TAkSaHdggb0u?=
 =?us-ascii?Q?6lwnOI73ZDsw5lNybvs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1832cf80-0a81-411c-61f2-08de0cbe8aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 14:16:04.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2iNQLt7Hf+/BnmmnL4Qb+y1OXmQthyovKNWad26VfOB2zsb8mMYCH2cEoYXMDU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, October 16, 2025 9:08 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Josh
> Poimboeuf <jpoimboe@kernel.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpoli=
nes
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Thu, Oct 16, 2025 at 01:27:53PM +0000, Kaplan, David wrote:
>
> > > Ah, I found it, you freeze everything, which puts it at safe points.
> >
> > Yes.  In fact, I think you were the one who pointed me in that directio=
n :)
>
> Heh, yeah, I remembered talking to you about this, but had forgotten all
> details. I quickly checked the cover letter, but found insufficient
> detail there, so I went and asked. Then later memory started coming back
> and I went looking for it in later patches.
>
> > Despite the freezer though, this patch is necessary in particular
> > because stop_machine_nmi() uses an indirect branch to run the handler.
> > Which means that while patching is going on, all cores are inside a
> > function which is going to return to after the indirect call site.
> > And so that needs to be the end of the 5 (or 6) byte sequence.
>
> Yeah, makes sense. But I like I wrote, I think prefix stuffing might be
> a better option.

Ok, and that's because we need at most 3 prefixes as Intel uarch's don't ha=
ve significant penalties at 3 prefixes, only at 4+?

I'll need to check on this on the AMD side too.

--David Kaplan

