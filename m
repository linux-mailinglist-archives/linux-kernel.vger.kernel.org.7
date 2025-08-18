Return-Path: <linux-kernel+bounces-774201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B4B2AFD0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E187C5611C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CA31065A;
	Mon, 18 Aug 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wv+K6oFS"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234D2773DD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539749; cv=fail; b=jD3cxy+6Vs73+1kt0fOJtsZ/ER+/cCXg0FU4sQoU7oxIAjEFmSkSsU5VbkEi9BsU9H18+AE0Smv3djfoQKc0aG+4xbZnZ5I+hcjWT8yrZ8F6ryvtdeXk4PzXLMQiRLwKxbqZB2fsurothfB1pzosf6Y/tl8nWQwEUWbO3Bqa8bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539749; c=relaxed/simple;
	bh=qP1WZSvOq68sLOM+SwgSFnQAgFBKgCS+1itVex/lIPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=acf44QYH/69JNl524xA3gPkNF83MViYkYdQeW4jaI/u2wyIeH+w+Gptk7ndD1wnwxRNW1gUmjCp4UiQWJiJOAuBURtLP/MgcMZwNNO5hRp2jwlh2sZ2OGWC/0lk04LA1VWUfHz7oCV7J2FPq2nBpj4AWqlQC/HCGAoRBo3n3Wwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wv+K6oFS; arc=fail smtp.client-ip=40.107.96.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpS5p8K3VuSoLWBxHTDi1kZX+qmN7poHZzu0i5qJVY4aQnSbsyAFVT7uSg2M0fVq1fWGv56A/UaN5gn1sqLP6cFr26EUxYgRyWuP6Nz+E3p8RhDrEj+WPlOhn2YrHatpvyb1zZB/O8lmiEyUItGaU8xJyw+UL4wWDg/XA5sH2vo+WDnSVSesgg1PYMgXefBlnku63f/7HqKY2EMuAWnA7ZD5KS3EoEVLj/W1qGaWv1QbG/oxUVQRY+E3Uj/X6vEhnYemjQIfNuH/TKHUEL9h7Z1+Xz0Eg0CMDvd4U6qObkzuM3UsxgG7JmFL0wPRxBO7qJLzruWQ42beEBG7aEdPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T1rI7hpTXU1Dw8+zN/ujNyaPJ+KZdKoGlgrNSC2eIM=;
 b=HAmgtivU2bDs+eEYNRTiZGoJ+z5BETTPsPXros/55Rk2Ohbu1XCmZ7fu2/0IgVwrfveCMlz86LwzEZNIzgB8yEpZXfgjSJH4kb5D5pSCW+4+Q/VBFsChTRAROvIkDN2C1Qg3MY4Jk38lHWDdefqLBB2oWqFNPzszGGGKl22gGuaKaGGVLv9A1it7+Roh/jUhv0Ls3iGFCY7huW+kNbPGIHF+FKk2B6U0Cok0F6qhiuCDByYPvTMwYcfHhcOXEqvvAtUgCp/7uAGzX43hPlv0GpOZC+VGr6pB+IY/Xd0AaZCZizl5p3TA7FtyKEMDio8Sb24z44KZiSVOaUy21sVA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T1rI7hpTXU1Dw8+zN/ujNyaPJ+KZdKoGlgrNSC2eIM=;
 b=Wv+K6oFSLDzpddcaZ+6FN2SZl6qLDDwqW/H5BZf7HPn3kMHyq3mMcmsrDKEiKh+CqY6E30jd6aP5WIK0ynk2p65mvM5Viny1MteeWdBYrOdYCJSooUnDBe/rAd+zS3M35I0KnuQRgMpNut8Knk0tkDU98M18+pWrkCAcxcB2Z/E=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 17:55:36 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 17:55:35 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
Thread-Topic: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
Thread-Index: AQHcEGdrNqZfFq0btkOJfrqM3kwOqbRorlyg
Date: Mon, 18 Aug 2025 17:55:35 +0000
Message-ID:
 <LV3PR12MB92653604B5839C580C4BA1949431A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-4-david.kaplan@amd.com>
 <20250818174157.c6bzy5bgw54fopgi@desk>
In-Reply-To: <20250818174157.c6bzy5bgw54fopgi@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-18T17:43:19.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA1PR12MB6234:EE_
x-ms-office365-filtering-correlation-id: 42537b01-37cb-4baf-17d6-08ddde806f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?r3rkGPChy3ax0chS7Hlor/VtCHEwVArxCuno77d0NbC8JY78f/f2tkWd3jPB?=
 =?us-ascii?Q?Q6BD5a8FS5af2J1I1ZhAtu3JU2HMIAz4zdCWibk/XOulbincut9t+ngBT8ED?=
 =?us-ascii?Q?4rkm4+vaeBMPtO6yu3OWYBYIq49iSmiC7kmZmkUAptkPdjKarTpDQIJWnl/L?=
 =?us-ascii?Q?9H1CGqT6WR/PZ56uBZ5R2rtK2UPI13hkk5E/TpTeXVFdtJEnlHvZqkR9jPdy?=
 =?us-ascii?Q?2sJpW1VrcTMiVz9dN+0NHXdCmXFhOHOQfuoo9rf0o1mispz15fap1p9/IH2x?=
 =?us-ascii?Q?1IPDyDnq/TiobSnPsrHReSZXTMqAq6dv/z1yQaPSzQr6BvEnoqlT5LnhTxnv?=
 =?us-ascii?Q?jfAPKAoUBGxJs+fB9gCuxLZ8fVojoJH0omLfEspdhNDND1aqtmZ4BM4dPvbb?=
 =?us-ascii?Q?DHN8dZ6mKk/++tsWWFTzkg2dGb3j9dx3W0Lv/4lEomzEqom3iuVgSpsaUCcO?=
 =?us-ascii?Q?lDGx7n8XG9fIas+PdE2fyP0LlWch/T4IH9+LHF8PHv02e0w1GIBUXWbSe1Ib?=
 =?us-ascii?Q?7d3XHJTVT/ASkU4vd4GnQgEXXWVdEOAQfk4pMOx35yOJclGFaGP9/pgH3li/?=
 =?us-ascii?Q?nUDyqbISpOGiyGAY4Gso2+jlenan7SWutmLFvNHTy+sB121KuFQyngMkdzZK?=
 =?us-ascii?Q?aa9HpZbnAT4dDWCn6Qqj+Reo501SEIPdISVGzFOm6b4DB6xSclTNCnv96tsw?=
 =?us-ascii?Q?Jf49SwtH34U/lrtvfG3BsjlkrYuiNxWOTrNHWEX0x26xQEEkEz8utC2/zG7b?=
 =?us-ascii?Q?/WBsgT+rmLkmDFrzmP2uH6YcZffxYd9QpJwfvkc7yYzj6TplAqZrE1yOJXIX?=
 =?us-ascii?Q?a5Y+eE0a3W427Qa73kERJp2jkI6jtKIp/deSZhUdjoqc1wbAUSyQcOO14lbs?=
 =?us-ascii?Q?r/5+LeRS7xjPdMmvCbwC50OCuvSer7Krp8av+QG2AZ+8K+NFdW1XmfU9hTyH?=
 =?us-ascii?Q?SFwfJHNHOfPnW25Uk96Qq2nrt5hUUyGubp/7UvdIiIdc41i9zYY+CH+QoIVu?=
 =?us-ascii?Q?4jFe3zRM9Vf8BUm6pd0SuL4lHYAn114+LPsJnOykbIndZgG5DfZQwVDhNwt+?=
 =?us-ascii?Q?UrR7wm/d/dXOCTQM1DXQ3ehvx/APczddIJYUlolUN6tYc5FrZkmCZtgCRTAM?=
 =?us-ascii?Q?DKub4qwg37/YAmrvEW1e3BZRKO28pYn7fOzZ1Nyf/DY8ZoCwC6A7nZxaJxeS?=
 =?us-ascii?Q?5qiphjclT0XWET3AqYuvyFj373YjbU9binv8wvW9rGndc3Io+TONYMpj/H7l?=
 =?us-ascii?Q?JOAKhjaqQCzSX9aOCWHIb5wyNag0myyMDLTN1nk9uQXgVeyV0hE2CaYVHwMH?=
 =?us-ascii?Q?bv6uVA4cYEe2gbj9cJ6lTiOftVlMI6+65z2sjHC40FC9P0P1lxZItdRC582t?=
 =?us-ascii?Q?dUP4y18DMPXOK7Ntg62Lw2uFuX/GOZ7C8oYZqjE7s7gChfpY7YmgKVDghvEI?=
 =?us-ascii?Q?ZR2DZG6H/fncW4AyludEYPYC0nW9165FkD4cgsJyDWJxVDd8U1k+f5mHKZk0?=
 =?us-ascii?Q?otQTg7fE9QB0KCM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q8tHy2PTLhHKV63dakNtFwEdQmTFRaoIE4Kal1JkChLNVtBQf3m9/R23Nq6X?=
 =?us-ascii?Q?bRMpam425RSEUwvGmYUOn1t+BJl5DepI3eVl+su6v33nzF2xI1YajIy7ilQC?=
 =?us-ascii?Q?882vAKj/JgoOVaYV7CKFW3/zjJFqHuP02RVUnpOWiOBzcUutVaiV23OorVCr?=
 =?us-ascii?Q?/L7kl2SU4YJZ79Rrx3SqYS+aPGI4heixOFXl4LWwBT+C9MHMVKsUtN6+HCWW?=
 =?us-ascii?Q?lC5dcV+TdmMU2SlFGUNop1xDQU6ZcwiVv+vefWDhOHWr8jCpy2x3niWfrnZu?=
 =?us-ascii?Q?vI4orFAK6L8O4cBfTkFhzNTfGDj/kIXPHlDFRJR8GBjTp/upMuWlxxS/14Q8?=
 =?us-ascii?Q?hIiR988PGob1WDWZ50f2GrpvW2zda+KoEg/NCvJ4YhCdWeGsRB0u9Od06thD?=
 =?us-ascii?Q?EwqXlPcdVkFPLr8H7nt74p+DuGJXwPC7EuJUtlaHWwcjA7aiYgln5izgre0B?=
 =?us-ascii?Q?w1d7gHf90U9e73PNAXqqK83ROpbSmWiGW+f5wAdspdtX+tLsev1WoGdUA81i?=
 =?us-ascii?Q?g5t5xqHWLrynZTxPmZqtSpCXszZrSYY8SOTOI87gT3r8nqwstzPh7OwWk3Uc?=
 =?us-ascii?Q?9Ee6x1dbmarwGp704jKuZQAPOo6eNKf4YmAyRfGnBiRFrQ1IgTqwcTdRZ61P?=
 =?us-ascii?Q?h7qCPvvjb/dMd9sQ0iqYe9yxGrp/njr9zyAep/vkkudrucSeJF19PWYsAC6d?=
 =?us-ascii?Q?cmOCDlitcC8jpIJVRB3sxCl2XGBbjNNFWWgKNg+Qg3MgM8oTzUcMP0TkWLFS?=
 =?us-ascii?Q?y/2yiEAgJ8kNZ8Q9hUxhntFHCYomV+ghOyxQpNPl7vPcyHk5SpufdRpgolve?=
 =?us-ascii?Q?0fj+CM1bmAqRNmo0NV+K+ZH8FTV5SpPxpBGhYVQ+Jmnu3NvNLj3SBNknAAju?=
 =?us-ascii?Q?AyrfRqkJAJxzlHDJMtiyznT9DF5ziniLqq773g42CbOcP1dK0zxYelyNkSoI?=
 =?us-ascii?Q?Ivw9KG5h0/JEx8XZGqxdutXxm1B7gfHzoMNb91ZOxaSDPHxhG32nbMB73T7J?=
 =?us-ascii?Q?ygvP1DVlyt8FGgqwaWuAL0MBmzaMUsrnaa+KtJxj7mruvL4xEKFL4VyuXyGX?=
 =?us-ascii?Q?5HDlOMizXfe1kzrBEC+5tV9GB0KcvCG9KPGUUxoLRoxpeNKIDZKmZCj3zVs7?=
 =?us-ascii?Q?z2vud9Sb5/ctObMN+s8ccto1pXSeooEW9rZND3d1OoldEJ0Lls8Pkfy3g4g1?=
 =?us-ascii?Q?SL9umLKTm8+PIy9SsT14uZ8hSDMej0JgJOy2lLfriit/9Y0sQMGyJojrq5ox?=
 =?us-ascii?Q?LTyGQtvX2EZzhXeMqEX6BZDiO4glYLqAZvEakp9f3gDLOB614WEVra57uccn?=
 =?us-ascii?Q?3xReD5JOEHr5tUjOdXp7x7grDVImeRP4Z7eaLMILwVPIRV+XDQHRXCqAp7db?=
 =?us-ascii?Q?k/Sd6WQJ4M7lwospr/SDfSGcrWXlOyh0Jn0S0rmRPH1o2vBQAh+eCI5wmiDo?=
 =?us-ascii?Q?V/KBM4Uq/K5T30jW+OmTF3GUnVaBdNbGCShWx4iHaLg1f5WaotTz+/gD5BZV?=
 =?us-ascii?Q?fbVNSCplbbMkO5CF6V27Sg6OKc90ToLVs37tQiP9B5ItuUjrdVuwfQm2TYK7?=
 =?us-ascii?Q?gHy8nN62YUacx8uk9EA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42537b01-37cb-4baf-17d6-08ddde806f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 17:55:35.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHyzDGPCerx5ESeCz8Yko4P5HQHCjLt8XpCsh1kNFG5/LMdHdHrPhXtWvv05g+2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Monday, August 18, 2025 12:42 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Aug 11, 2025 at 09:26:59AM -0500, David Kaplan wrote:
> > Simplify the SSB command line parsing by selecting a mitigation directl=
y,
> > as is done in most of the simpler vulnerabilities.  Use early_param ins=
tead
> > of cmdline_find_option for consistency with the other mitigation
> > selections.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 118 ++++++++++++-------------------------
> >  1 file changed, 39 insertions(+), 79 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 19a3891953c3..3766dff9a699 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -2625,16 +2625,8 @@ void cpu_bugs_smt_update(void)
> >  #undef pr_fmt
> >  #define pr_fmt(fmt)  "Speculative Store Bypass: " fmt
> >
> > -static enum ssb_mitigation ssb_mode __ro_after_init =3D
> SPEC_STORE_BYPASS_NONE;
> > -
> > -/* The kernel command line selection */
> > -enum ssb_mitigation_cmd {
> > -     SPEC_STORE_BYPASS_CMD_NONE,
> > -     SPEC_STORE_BYPASS_CMD_AUTO,
> > -     SPEC_STORE_BYPASS_CMD_ON,
> > -     SPEC_STORE_BYPASS_CMD_PRCTL,
> > -     SPEC_STORE_BYPASS_CMD_SECCOMP,
> > -};
> > +static enum ssb_mitigation ssb_mode __ro_after_init =3D
> > +     IS_ENABLED(CONFIG_MITIGATION_SSB) ?
> SPEC_STORE_BYPASS_PRCTL : SPEC_STORE_BYPASS_NONE;
>
> Other mitigations default to "AUTO", but not this one. Isn't that somethi=
ng
> that attack-vector controls rely on?

I hadn't modified SSB in the initial attack vector series because SSB mitig=
ation was never actually turned on (set to SPEC_STORE_BYPASS_DISABLE) by de=
fault.  The default option requires applications to opt-in to mitigation.

However this probably could be done better by saying that ssb defaults to S=
PEC_STORE_BYPASS_PRCTL if the user->user vector is enabled...and otherwise =
it is SPEC_STORE_BYPASS_NONE, since the default ssb mitigation is only for =
applications that want to protect themselves.

I can do that in a separate patch in this series after this clean-up patch =
if that sounds reasonable.

Thanks
--David Kaplan

