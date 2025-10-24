Return-Path: <linux-kernel+bounces-869030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F76C06C11
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC51D4E53F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8831A7FB;
	Fri, 24 Oct 2025 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pEWUOB86"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2C2030A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317039; cv=fail; b=upQnYvUoUY8HjV45VUgDfLfpPSTfPnwqaHmpOVFomAOOodu/jQcfth25cyhHXoNKyRRaBSEKu/FYcBNKyyyfrczO/jWcQMV+bGSciQ/Y3MuFQlyjVqhZg7uUcaoO6NkPR61qQeoUu5k2EBYgp6pjOw7d4RehFnqeVEFp1JCjScU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317039; c=relaxed/simple;
	bh=aKNyIdjakDR1UYxutLA+5k2m+cCINC57AGM21Q9dOVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bpS22qKZm1+MbLMZfD1vrEx7nHp+8sDhS6BWZ9Oqm3V1p7zb2+yfbBCD7QTnujx/AlPEhxVEPoJiNBApPWFsSk+8EcAD2w9IB3/XSx1ViQLXPsRFB6arPHMUUKDXAnCLsXd14Wmoa80eQ0Qs/O13/WDve5wcCmiRrLFFTQypHlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pEWUOB86; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1ewfkCAYfkyBPQ1OzresLwbw3DgTlz0WHx5Fr2SV8+gETXNiPP2jvubb8JqkGJM7fJ5YiWaVb1QLCOHey2o3xF4tUkTTjDk+w+OX713w4DVc+/YzibreosydaffUntm8SHBqNx0MZTeYrgxDbhx8TnCFD0Wsdb+JjBeSvfvCo9wAbs6tuP83aoyNtIqhJkvjmD7ml0do42ReLI7dadobT9gYXa3ocvfe8gXGrj4OH+ShgKW4k/wrDmbKDJjRor1eNoAQQKy80pexrU/Ai1CLoBaGbuQTfdJY+Z5LEH+LDIds7ahSxVMlq4fzuDsmBeHqmEFZL3gRebxYZagm0p0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H9A1DpjCNzGIF2HNs5oc3ggN/Suq5TK9OYpzztDwHI=;
 b=j0DrxaVJelJK/VG2BRDvNhUZ/n+Be1aoeYEDH/M1CNwbZWR05b7iV10dhK4wJXJsoktpeADKDGbKclvELCOtwDtK8J9MV4d/ZizxRcOQHDkqf+nNEw3MHDMn2xG/nKcR8C5Jal8uyeHf4o0qOw91N+VW3ryKdXsC6WNUN+n5I5yApKEbgK0+jXmQBRP2q1TVX8YMSvXK5yEa0RUmAjcD8MQpW5ayWjjk+XVXM7TFQYG1uYCR7u4+CTXqHHP2587UioZvCF5sxHKDpi0borvPhndHERpnb+GA3Fw/DJ4h5RP8CxhLv5QlS58E+be6OiAzvaAB9qDYgkQkfd54B9y+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H9A1DpjCNzGIF2HNs5oc3ggN/Suq5TK9OYpzztDwHI=;
 b=pEWUOB86XA7GYJ7eTKacXXTUaA/1eU+Uo97U1I+NdAaepyOHBtezwYAXdnmdLylLGVc65aBkq9e5/o7SvMNdVEZwZXLJ3BYfLqate7hg45K+pMuuFioRz9625TxSOGIePdY6gEoZg4ZtqRD6xTjHeNGRZti+6LcmBK1aJEeW6Vo=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 14:43:54 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:43:54 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 14/56] x86/bugs: Reset GDS mitigations
Thread-Topic: [RFC PATCH 14/56] x86/bugs: Reset GDS mitigations
Thread-Index: AQHcRI+lbt5AybrwakaRw9gxNv2TD7TRXuEA
Date: Fri, 24 Oct 2025 14:43:54 +0000
Message-ID:
 <LV3PR12MB92659AA05023FB02696B7F0894F1A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-15-david.kaplan@amd.com>
 <20251024024054.6gum6dmztyrd6u46@desk>
In-Reply-To: <20251024024054.6gum6dmztyrd6u46@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T14:39:28.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS2PR12MB9591:EE_
x-ms-office365-filtering-correlation-id: 0bb1cdd5-2617-4d2f-01bf-08de130bc188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pWjVMGc+aasYsA4nHrZPCPXNLEQeLFyMiDFjn1a5/AJ3+ZBgkthIoICRYawF?=
 =?us-ascii?Q?+QaZzxiiJ7HS9Y7cgQkrLOb5jj0wqZ026MAQZWdVVGl5Pqx25PgGzVVvoF+d?=
 =?us-ascii?Q?N5hx0ewOZV1e06PE9QcoBTi8yIhzlI5m2KXY+cJyBeK2LF7z02pdP9b5xcOo?=
 =?us-ascii?Q?1t80nv1WP9pKN8YqhA+yvU+aiUhobOiXpxu6b/MWLhVASlwHKodVSHp70cMe?=
 =?us-ascii?Q?2KeNKKnch9ilt9CUxVzdDgVHbT9bbnHiDsbEDpqkwSUdsR/Wx1enIb2oGIkP?=
 =?us-ascii?Q?KVaW6nPXYyCt2Aw1N0vSbTQh2AafN+sHxofcMqYJYweGuNDUCzdvA1uNk52u?=
 =?us-ascii?Q?hMos7yEHBUs7brZ/wk0CFqdWYgpmPD4dj4befe7+CKUPcWHZ6XHKfLbwb5MK?=
 =?us-ascii?Q?jzwYlly8Lfzmj+vDy+7RUExcwOMOOrK5q+p++emJ0KFTCkRbtC7/bMqmYKt4?=
 =?us-ascii?Q?HDklns6xiW7l+KU765CKhTFhAwOF8sZfCIkOeGtQBWhW4azPR451c9uqQWcF?=
 =?us-ascii?Q?x9WjJlBSx5W+PDW8uAFB8ASeRqsMN253/P6kVsXA0iFhIrIDKdpj+Bd/LLAe?=
 =?us-ascii?Q?eNjJ5DLjrwPsv6Zop1fDnEzKEE/oljohbb6mTMX7yg0a6Ksqp0Wqs2Psr85q?=
 =?us-ascii?Q?Xc7g97WHwy45XQ+8Y+AVMtzxNqh/UsVA+unriBoZ0f+MiVI/TTKyfAQvJxVz?=
 =?us-ascii?Q?ou364gve0IADhDNLPvQkz6OlXVVPEtAKFEGdkQll6eV+jp0ZanLOiPYXf46k?=
 =?us-ascii?Q?BCSIuVm/iFKS0wIaQZIYBUDNLnmusbYXR1QwB0AacN9rOSCcPqvMJ4FoAXr8?=
 =?us-ascii?Q?CrZznfPHv39qf18Hr8A/P3LXw2Uf+5UtSg0HL6V5jQZWYj9b3nLbt0iiy+c3?=
 =?us-ascii?Q?y7R1EqSnwI8RK/CS/+Y9zdtlV8TtwBmoas+mcpY3c1h7obUCGQK1moxdokC2?=
 =?us-ascii?Q?IcPw1kp4D6a73gulfSxVxcpsBSx+wSAJRP15QO03k9cxJt8amsKJUPWRpIk2?=
 =?us-ascii?Q?B3eYyDSYax8L/jDsVK0EM6lSgt6E1+rWFnqXon0xiUHHYLK2Wo4+Bu0jol9m?=
 =?us-ascii?Q?yGHSblT0S7TAymlDcIemb7GdeAajx/tzEwn5b7DqDw8OTnSarHBgh+wbn2Ze?=
 =?us-ascii?Q?hWiL/NzEOgt/ReGLebK/820tTWBpagvVVvU4oSfXQuQGsVa8tCv+fQwF9Riv?=
 =?us-ascii?Q?L5+0ZaOrydGD4pVIKD4OB5EvM61iLy/5FsEt+7Nh+JKrhTd58AoZjIRLDs00?=
 =?us-ascii?Q?UZB+qzYwqE+Bk4txhMdhq2CJ4NQ6pLBfywyHcU3SKOa/p7pdSKaupMW0p0tF?=
 =?us-ascii?Q?XHwKZsi66qEnO8PhFknVMNGPSwDHB4/zFgJpGzRDVmh6csd4jrax3BCdvOZk?=
 =?us-ascii?Q?UoRvr5jBF0hRyR+qei3WuqjbEHvzsDCSIGSu3ceiv8LHoWeyUBxnNigmCHX1?=
 =?us-ascii?Q?hUn5nif74Kt4r1RLgBYBbJW5RagknZ0VntMI4TlLBQD6ZXbB0IZSi4tN35U1?=
 =?us-ascii?Q?O1JzgDG3cMtky7RA3Xrij5IC9lFuG8KgDgnf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MlMcAQdZd3BuiJRYmCuB2p9YAENHoS/600dSR4quLnOAwuOIu25WDhSofXGx?=
 =?us-ascii?Q?z5hmfXjnOShVIOlPuix2z2KZE+a82txPpGMNyaZ8hs7XNHApyuRQpeGpUZYa?=
 =?us-ascii?Q?+LvjktGA7EWiPVDR7WmBWT3xsKvhtFIJmper9AN2y1laIJgiM/4BSYTDgLJy?=
 =?us-ascii?Q?bAeoO7viKc/Ys7Gy7rKfBbx8R/EcxTiGF8RiNpJxzf89VIpIcgUd4hqknaXm?=
 =?us-ascii?Q?gn+VIs+WRMFaAlYAwSkr5Y7w5jEk/xHlaBCS/dh6Mf4u65W6zW1LvTSG9MJb?=
 =?us-ascii?Q?5a/7rxX2iyhtJTIs1uzsq95XJ1mQsfOV1MtCjmrEggCHG/g2bmpqz1CEXgoA?=
 =?us-ascii?Q?tGqzJGXDgcdWjGbBhgcYCZ9lbi4Sy3j92q8y/MYKxD8fmf98I/u+70+JbQ96?=
 =?us-ascii?Q?kr8qIuxCHBsVPN3yXd2eMBV0q55JWHwj99X8O4OUujw2tMEmOY6hsFaoyoha?=
 =?us-ascii?Q?H3ltfpYceyDuinaYRrgLahpO+8lR4NuTamnMUBsoPBvs2C6J5JKdyOa56OCq?=
 =?us-ascii?Q?eIO5zEbcaVzdmjuNz9pe4Vmv6lkuj8PcGFQHRl85jeQz3W+kek7WFzK+FHTf?=
 =?us-ascii?Q?2D/31jRVAJc+ShDfjc0X/9pGGE9uKDqC1Jzck1YlOj/siG3ujVBNyA4mz/Mh?=
 =?us-ascii?Q?WQX7tMeli1Jr3wWymm1jOSYU4KhSKMzWeg/dIgX0JbanQU7ZP05JkFyTKnqx?=
 =?us-ascii?Q?OpsuHgn3R63FUEqENVPRgn8Omzxj0NNRHcawGYjGNRpmMOot/bgEDCY2JlgX?=
 =?us-ascii?Q?N7tIUeeKCk2bM6TQZHCKdQ4kc76ukdXdWCPhq2rVAE68ASxbIqmEJRmhyX7v?=
 =?us-ascii?Q?wFz6SourOZJpT67PON48b34CiYI4lULSaTcVEXrAi0ok3t2ouaCs1lspLXq5?=
 =?us-ascii?Q?/EfA4xMg2iXuQACeDoN7U8adFDGI6oaWd4Aq2Vd5KdTRd4splmQ587Dd65XS?=
 =?us-ascii?Q?maFCc8ruHQLhdcwXcTINfuMBAboi+rKz03eLVArLlMxTrUCeU328gFnDORV+?=
 =?us-ascii?Q?XPC4KuBcpVURK5Y/YGkEe9S3AFfKPAv1hQKyNHlajJr3vZMGtKqjRvQWir3g?=
 =?us-ascii?Q?w3YVgEPIQMfQ36QEjx2f8IUKGSuZSJ68ECpF5IyagNti5k2N6y8BZ0Ce2U6+?=
 =?us-ascii?Q?plO6UxDmZXT9pxBgHlkZHFtUtl8fYJP6cTwgBVUs65nm+S2DX1LCv5CiaiXr?=
 =?us-ascii?Q?TxiJ0KZ5qRlULuhnSmr+BuBQ+dX0dB157IgYVUYIovMpq2dKQ8ZAovy78CBk?=
 =?us-ascii?Q?R0qmJOb5OEXk6GuaEJXI+ZBDWO1ob/yK4JLDCAX5EsZUOMmPALOC6LJ6JsQK?=
 =?us-ascii?Q?VFZ9rwlexgJUSv6LsI5aBgMlk74QOOiCKZgAILlv1XBllB9Ba4CITAKXZ48+?=
 =?us-ascii?Q?5gWXcAR/MAny+XkhTNSfhS+AljMwi0AxJGj9OGDO7P5oX8eWvnOH7jlXq8Lw?=
 =?us-ascii?Q?fk01QHzAdcFU5lV9pU7ty2ENHkEOaA3XMJnw+1oGihni5NIM/mjWqsPvMggd?=
 =?us-ascii?Q?UkWLPFFBzlnKBhytWH8psb6zndDYTs4fP307ccFwBFGaXqoGO39EnV50Nv7I?=
 =?us-ascii?Q?7zYDBdayVoPgNO0m+K4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb1cdd5-2617-4d2f-01bf-08de130bc188
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 14:43:54.5644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu9yXMoMxxV3oM6F8BritTrblfRD+REj7TZi+ut4XGcYNUvZOsK1IZ7i6+VsO/y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, October 23, 2025 9:41 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; Alexander Graf
> <graf@amazon.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 14/56] x86/bugs: Reset GDS mitigations
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Oct 13, 2025 at 09:34:02AM -0500, David Kaplan wrote:
> > Add function to reset GDS mitigations back to their boot-time defaults.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 112553058ccc..e765ac0b9240 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1182,6 +1182,18 @@ static void __init gds_apply_mitigation(void)
> >       pr_info("%s\n", gds_strings[gds_mitigation]);
> >  }
> >
> > +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> > +static void gds_reset_mitigation(void)
> > +{
> > +     /* To cause the MSR bit to be cleared. */
> > +     gds_mitigation =3D GDS_MITIGATION_OFF;
> > +     if (x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)
> > +             update_gds_msr();
>
> This also needs to check for GDS_MITIGATION_FULL_LOCKED, otherwise in the
> locked case it would trigger this warning in update_gds_msr():
>
>         WARN_ON_ONCE(mcu_ctrl !=3D mcu_ctrl_after);

Ah, thanks.  I will qualify the call to update_gds_msr() with this.

--David Kaplan

