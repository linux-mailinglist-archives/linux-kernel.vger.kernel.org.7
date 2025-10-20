Return-Path: <linux-kernel+bounces-861152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91517BF1EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F6CD4F16A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070EB1F2B88;
	Mon, 20 Oct 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rN16Pwum"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB2194C86
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971804; cv=fail; b=iTCy9wHkFA98lDUc4uunvd52f9vadOx8dSrMHwbdLnpkC3HTYtZgUWJrxY8nPmM5SQ3UK4FuWR5kP8YlR3qlvmqdG/koHMf55iVip/ChfA6nclqZIekZXedPs0ZopVrN/lioFl9kzOWo5Sod95w07m6h9cJGSByyrjzcTboabRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971804; c=relaxed/simple;
	bh=pcirZ899KdRIZU0GfUNvmX1NVblWeop+Vs/XnvD00Kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kzqz9cunHaJgluUTwKlghEKPF+Zyf0hYHsG9yWlWoDihDKwIv1fDCFeFOVCk+RiWYWzaE8kNlUEuwnSVcWnwWiVVqafgi66xTONd3VklaRLZqFpr/EUB/DLcPAtt6LEgI2+vQremzq2Ec43ck6vvUFXeNAtKQwIvXoqHwkmKQNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rN16Pwum; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNWyyRzZNP6khSGPJhdIk/tWtEuQIWl4hUWZwuekefJhGvvrzZY6GdlulrCd+mo2/930xZzNgA+aL7qy60XwNkllH96ARiH740HWemJ6ubtayA4/vDZR68yTeepkmbpSb8LewNRlfF9OQxT/XV/Gj6lUIEjXRe47TjHHKf49IDkaVQfvxa6T0f3NF3k14HeXV57sfOrQaIXKB6YD9ehNBEkfC6ZkOy1pFlOb8Dv5SMhnZYG2RTByhKUkBaIhpvDutm1WCkUppXum+pblZ1OJU74eKeZGcD/dDz7E4BD8SQ9o55+4i/qbn6/YateksuWCqAayMYkjKGS2jYAgpuqvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xx/Sc8XDKf04Ute86voUlPY1HopcrKNcW0Kt3fwyiI=;
 b=IzKpxnpNFrCWKVY6RPsOWr3cy/RPs15YY8Aak0JAaDHmjJ/iSSc45PxXgpMQ8ZbUeogXgSS8tQgJzKfNe6+w1Usy3ITr6jJGOGcKIUQclgbcXqFxGlPXpbfNlqBn6CkUBWnp5kMkksxmXyIlwVGiJjfW9Hmvneu+t5kMyM7y4vkIRtpwC6OwAVloh7htMhopd+UjeWgg7Y8yWzfNTX2RbC+rNmXIdTmS9mtHhQA4KbvYDIb7KTxv+iRF7AxI9Efgzp/D25aiDzgAC2MN7fK2voLaYmu70AsyPSr6hKRFB49jOXapiSXoMMwGmlsbsh8uCRvJp5st1cnH5ySzo824Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xx/Sc8XDKf04Ute86voUlPY1HopcrKNcW0Kt3fwyiI=;
 b=rN16Pwum/GBcccb70zRgmN4g7SK732ip1B1cSsTgE91GMU8zY+AifXN3BBbPTuQ2x1JA2Ng5k9ZdeF0+55ouzqvYOfbUcOgF6fvNnxg1Wj//lfCpwuw2Cs9tx98vmu5xbhhHh9Egw/TQledW+1CIc2Xr2yVU6NJiA4SNtWxkodY=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 20 Oct
 2025 14:49:57 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:49:57 +0000
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
Thread-Index: AQHcPoiqsoexywdJOE6yXtrK5ZRlk7TE1yEAgAADZgCABkjp0A==
Date: Mon, 20 Oct 2025 14:49:56 +0000
Message-ID:
 <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
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
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-20T14:46:00.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CH1PPFC908D89D1:EE_
x-ms-office365-filtering-correlation-id: efb3eacd-5573-48bb-ed40-08de0fe7eff7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iD83WgqOe7/chhvsnwdbF4yjYmS3wIaTrHE4jXZkrTeesHlPGhn2Ba2Etsqy?=
 =?us-ascii?Q?1AjtbZJml3l1mDbd7OZ87tjjCgaWTFrtCis73dOnMg+6T8lepYK9PuuZKgOO?=
 =?us-ascii?Q?NNSaIsPuxC7UrbhFkGZcPeDtvCc1Eb0a9uLlCG/wVw8vZG4Kq1++pb5TNMAC?=
 =?us-ascii?Q?phDoKr8PueEYfFGQYtdsGR2wFdrb+DRvlhSCSDGoihKXXCoCFrRCUDkIuNW3?=
 =?us-ascii?Q?Kh+/BDGDHuT3wQHIUg75ogrbBtOovxU2Ahs2JTfEPs6QnjqebbJ2XfUyGgIv?=
 =?us-ascii?Q?6FzdBqcS+T+I0fDs13mHnnR+F8YW1+nWNzDohPql9jyf5dpG3zAWY5xuXA9E?=
 =?us-ascii?Q?Rc4XdsdewlDfWSI4U7Fq1nui20yteVzhfCSx+Fi/PPX02e2GUlKVUYtQnKFK?=
 =?us-ascii?Q?YJmGKd1VY/HMUNpbhbFs5GTEhl0NjWlkXu+2xTXAsrQtXtwq8Z5oKtkx5W5+?=
 =?us-ascii?Q?UpXVWaU4IQsU0Vs33XLo0Sxft8AQfzJWozy3u/acHs5o0Eo5fZ6Oqi0iXLdn?=
 =?us-ascii?Q?6p1YiDkq+n7uukLvLHz7EeDiaE1ZqEb49O12OCgFtvWpV/JDC6W3o6Mq8ZLc?=
 =?us-ascii?Q?QudOEWb6EOL3AdALu1mpeMXj01c4mIm0v2q4P9ZK6ZNs4RAnOkvvxw7+OJq2?=
 =?us-ascii?Q?X90RjN2ar6UJPlvJ4GStfZiUdJksgukFE+j6UJW/Ki28e65aaXy0emnDWGEH?=
 =?us-ascii?Q?35prh9+/ZaJlqvZNlmUjzNkxiW60STUlb4C9tYtf8HFUefCbNDzdDa7PiNXm?=
 =?us-ascii?Q?8tcIOnRCe73lgAFD6tzv86CQNRMxZTADa1J+77rHUWjh6Zno1zx6RCJCsziz?=
 =?us-ascii?Q?uEf7JADjH/mF/yw25AZUXP2ZLNlFbV3D481L3cG8dItNGgZwWxlxtJkowp8P?=
 =?us-ascii?Q?29wqBvXfIYm/wBU0IUYS1nDIz2tqvRd+BdnNFO1BdL5Z7pJNPfpy4uxTK3Vu?=
 =?us-ascii?Q?ngWYjZSBPi5/bYuEFp0wSlw4HvYclcrOndlmW0RRZORN16NKfaTFqSuptSPh?=
 =?us-ascii?Q?QIaTSwY0ZMgNJQw79lQ5reIBEy7DXGGWzWNuHnO6hVfWki5EmfLO3hptn9ZK?=
 =?us-ascii?Q?DbNXGR2nWhJTr+nRVR8s0CDyGWGYZI4WVd0kP699oWtgzMk5DgibZxEAtJrr?=
 =?us-ascii?Q?QRgkD6BNf076fr7AuMSWfZEXG3Sksi9YoriYLreXbgK3yEtloDkJLlgird4A?=
 =?us-ascii?Q?Cwpx6BdR5kcZnPF7zaBqmmCYt0I9DN747lgwxswM6j/ZOsF8jtEVlzM95GLF?=
 =?us-ascii?Q?ql459jBXa3MgXdWD7jlhCVB5dHpGKGVf63yQeGvbuoqqL2Bg7ZATJxHuAHCg?=
 =?us-ascii?Q?SQk2bmmJ8EbHlPpdA2QN8J9uPQTvqEIWBBtKyf+h5K+lzTEcbgrJg90Ce1wz?=
 =?us-ascii?Q?rvjReiQgdx/InLZezcLvhWrNWptmW5lfKXVQnT7OG9IYqdv7Nr/qqyYFQtke?=
 =?us-ascii?Q?IFBFmMfVHkTGblm0XFQc11EdoZS+o/Tuww7Hob+vzzDIAWB9mKxNweRT+hxw?=
 =?us-ascii?Q?PCnfW9y5zATTI5MX/lkOyJ+EBe47O9iRosfD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+L2rpZJdMRWah7mb34QKclr4PaW14vlOyS3VBdVOxURXlj9Sjn/oBmLLMMD/?=
 =?us-ascii?Q?I4d5lj6bMFrW6sTY5DdNd0a4F4IVoGma/B9suPVGn+WXxJuHZIUBjFb7hvOm?=
 =?us-ascii?Q?Crsb1laPwRymF0s1ky8qcSH9WFYeSFV/X9jXq6iBD1N68w6GifIT43PhdWAG?=
 =?us-ascii?Q?PKm2SioE87F4SO/9AR6K6vplbsDf8Z+J9jVv+/Flj5ZCLtPFFzUyfdFsA1Ji?=
 =?us-ascii?Q?LG1z3L4CnSqkiVBiWMCKZIXkD9NRR0FAkg2zG1j9QddJ/oBgMYkw5p6OaRQ2?=
 =?us-ascii?Q?0PFgZn7WgJssx2kfPUzi+bmE9R13sjfhRkBkgpoSpah9N/E1ZbjwbWET3ORe?=
 =?us-ascii?Q?OwfWa/ig8e3F+awasQ0pSQTgfmsvAB0QrcSUnaV1fsyMcD0a9S/fsuLzz5pp?=
 =?us-ascii?Q?P5TVxFkmH3iQeOu4tcxSKPJ4t/gHsC0ykrlSHUNaQVhKSoQHf8C75nPjJ3uw?=
 =?us-ascii?Q?0g++QvN9P3UG0sPxH8yPlQK7BVPGJBr7n8WEQ/L6344K7k6aAjYJbEqUPrFh?=
 =?us-ascii?Q?dwQj1qKakkWxE7VJKcFHALMtVHjxnhLRdkCeLp5uNC1P16KpXbZlm5jxVpUU?=
 =?us-ascii?Q?4M7A5WoxR8cNUXjXMvth8yCxDotjNfSmVP6OrpMbIPrdtPIVk/EP5K+nkSjk?=
 =?us-ascii?Q?DwVD+1Gaow+WHpYTtCeEfBx0rfXN1lTeXlogQcKXRO7/38o2ZiQe8Ihm0DFW?=
 =?us-ascii?Q?AC3gYbbiw+PaY4dzWds6rfZHu8M1gSgPvqLlidigCQyKvxZALrpA4lltNfwU?=
 =?us-ascii?Q?q9oGGfAlIMGV0WAMgBHN+usdgCcEeWNIqQ5jRsaLvKVCAWAHIEs1FkOjs3EH?=
 =?us-ascii?Q?Z+59oWReB2WWGOpt3guGRnH0kmpyfJ1De+C4KNYBHkhTyFjCYD+0db8X5x84?=
 =?us-ascii?Q?+IwfzEvfhvfcoXzpKHyDwgkdL6ya7C+aSUKDN975qF5BO1nex93t9bO+VOWA?=
 =?us-ascii?Q?giIdJNPiVjk71K/nQd19a87eivjfVv4cKL7B8jC4qHKC6PkUwoNF1u6hb4fX?=
 =?us-ascii?Q?Bxd9HjteJjl3aY/z080xLxLFkb5ZVClqwRDMRtlFs6rnNhD3bAUlF1vG69qd?=
 =?us-ascii?Q?JoQiiF6ThNB99ez3uR8Sils1YaFLKuRKvOGefkDL1qEuTxdgVOsID+FnhNGG?=
 =?us-ascii?Q?tQ4o99DGt6B8KyXbv4lzLB39zNh8+1lvM5xlKKoAZ47aafJG1/AyfIqlsXew?=
 =?us-ascii?Q?8HbqDSXaY7uETqG2zrgLKwYgy53L4yB9NjYW31BRqzG7GjKTLpN1M3ZVvbUr?=
 =?us-ascii?Q?OBr2G7lhqZUwAx+rpYVYauiWf5BM2qDR0AruYZjHbt8T65oSZQbxVTcr4doK?=
 =?us-ascii?Q?KN2GXDttlmARoSjX0C7uCglFISGsEQ+PzLQRxvqL7m9DWl3vZ83GhB5XINXs?=
 =?us-ascii?Q?f6YUAcHBYhy5TPmTwTQyBs488Ee8gVTvcwzyLgH40pV7PVvmdB+NVAXP4tWr?=
 =?us-ascii?Q?XS9Q6wf3O3ePIckK/fpkjJ/9pbaOtYEOFfO+6puq0xuU63BYbebMYOgVIvEz?=
 =?us-ascii?Q?A4l3QLW3quI3oOQODpjLpNtJWaVVZnFxWY0Cb402bhrAr+eLPKqnlUUvP5S2?=
 =?us-ascii?Q?G+Sy+p66M2a04FlQK8I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efb3eacd-5573-48bb-ed40-08de0fe7eff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 14:49:57.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOutomFUayFHwz0IaJV92yZvolet56PEMwpXld8jCP0VKDjQFhd5zmehjxumY9Ur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

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
>

Coming back to this, are you thinking we should just create something like =
'text_poke_sync_core()' inside alternative.c and that can use:
   1. SERIALIZE (if available)
   2. MOV-CR2 (if re-patching)
   3. Else, IRET

And maybe someday we put MFENCE into there too for AMD parts.

Right now, of course this is the only logic that would care about an NMI-sa=
fe sync_core().  So maybe this makes sense vs creating a generic version th=
at nobody else is using?

--David Kaplan

