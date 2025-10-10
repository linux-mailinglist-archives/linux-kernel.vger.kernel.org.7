Return-Path: <linux-kernel+bounces-848707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B095CBCE629
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3580E5449DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EF2FD1C2;
	Fri, 10 Oct 2025 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="grkPkEun"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4A1DDC33
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124451; cv=fail; b=fZa+/hy2cIoJlx+LCe3M1HQoi4BcpMtmfitp5SOMFeozmXGpalkIYq9GhsW+4bz4Ax69jVzNT8ZD7/gEC4E/3o24y24t08oIw5LQ8nhpboMPjOD4gfgrw9fhNuHdDaptumqOC/KCyuhqYKTfbTnjBEL28zOrdf+SCy0VBPIPrmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124451; c=relaxed/simple;
	bh=LBuJhuge5sIU62gXtWn9Yru5DPhXOhPBiQ2JiLwTIds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M+GR/mIX9aMaAAHlRma856vci3RUIdjPu8IQCyzuvZfv/4p9Ya6R7GyDCGaZPkSMiuvulmuMj0pjzMY53Whf9yh6gWUQLlUXanXp+45GM/6puHfeD4sIke1TEV41Y2v+Ya6455Rh/8o+3/JgcCACbInUlvPdX6KkM8Fu+yJZlWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=grkPkEun; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjT3I1etS0jAv4FvtBBsVko74EmemigA++qHe5HjooJxH+Plh9cV1ybJPgdXs973E3WlszfbP81wmQ8k3vhxzagyomKHGwYYqRg2m5jLYW1k+LHk65afaKCjK7Mj+qasIqwff5l19KhyT76Heap0iP6Cy7qBJ9BL+SLGUAtLfZelrNlvNsX8F6UKkw0qGg9r7nKe4fIGeV+6bZ2UZfSkbvNZg012pKwooV9fogePpEMy0Nq9+/NiQ8uRygsJdNGolosnXWQoMPZ4Xz+jwCFbK9VrekN+mtd0JfCCGGB/u1Lfz4AIc3ZfRj0H0OMoPEvZDy4xCHtKOdUPBVtCM+ffbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnraT2kOe+n+FOESPLf9O/LVphwuemEV3E8zm8ReXCE=;
 b=BytEoLY8luCQAr6B3bLWwzSIBpcuoTzNVXp1vcSmkK/6uafuxMgojQ6Av+BNJW1FSHEpdrbwlhMZfb2hvtkUsm6HIOtChdsDMfzg5GVPCsCHTgGNyO18jSwZAtmtSnJrLo7tAx1jPrHoSwka3B06Vm6tFIKHm2bDib12X0JdSxSH2VsO8TuaZA7o0rXL1BoeX7oSLxhIUzAgutRV7XH28Jiih1k88gh0agwOcjA+uHz+aawcrdyv9D1ux+o+Ny3A5iCiduzdGOTNsIMMQMj4/yqtwCvgK8ENnpmtxar5IbkJCQ6T3LFpagiHGkDEGj6UHmKMqCHMDU/mH4UEVARC0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnraT2kOe+n+FOESPLf9O/LVphwuemEV3E8zm8ReXCE=;
 b=grkPkEunR7DnAjup70K4ykBaBwVMQbBBKPWGqaocdUXAenGgX06OmFV3i4ahKE/LPIpwdfmV+yaj8hge1eHQLhZKM58SFAmzeJNNsvO/hKGG61Ak3iMRNeB4+a7HYAT+25cUVCt3qNU2pYfowMRyVcwdvxjIxXzEAsSFPnNIz8A=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:27:22 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:27:22 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Topic: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Index:
 AQHcNsLPYAWj0urMzky4n4OHi8ST+rS1I8EwgAADDACAAdp8gIAAQCGAgAAPnICAABJ7gIAB630AgAFI4QCAASc+gIAACOIAgAABDIA=
Date: Fri, 10 Oct 2025 19:27:22 +0000
Message-ID:
 <LV3PR12MB9265E186460C170527D1D6B594EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
 <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
In-Reply-To: <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-10T19:22:56.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB8562:EE_
x-ms-office365-filtering-correlation-id: 496d1b74-11f6-4cb7-df43-08de08330941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/M9i4qI1gXxVrFtL5Sy1ZARg3UyGqdtngBeyBzGlpRKTTmRZbs+uoG/ooq5W?=
 =?us-ascii?Q?/1JHt3DiJl380jne1bI8TQWbBisEs5fQx6UZKXX7VOX89LkIs209vvL26iZ2?=
 =?us-ascii?Q?9nC/2KOPUqOApppwmg7QPaHaaIMmg5easJ+2+5bW0vQ2frC5eQbEQHfD4QnP?=
 =?us-ascii?Q?d76u6gZypfKb1zGGPLRchkCCDy56v5B7agJeg1ENgmQisU/JkP9j3GUBt9Oo?=
 =?us-ascii?Q?25IXjlAcxLl4xaaG/iSsDdpK2PQsiURxvS4fBAXyIz/m4U1t93BHrpDgCQ3I?=
 =?us-ascii?Q?fjZkX2c8zjY+6kepK55Zp7Xv/rZLjvycFG5zY/OKUZ/2hxRXiKWoINb00ftG?=
 =?us-ascii?Q?3geia7tyFEeRWysrV2QRlUlz0jaoppM62lgqyEcFc1AevmhPyo9Yjme33Kwp?=
 =?us-ascii?Q?dfmshE5gu81KDiE16Dtiz9CCKCtVwhjkJOVivLOPidT1knR+lN+rqtbi4yil?=
 =?us-ascii?Q?Ikyalu0Ynglld87k4aYoNQDCRLrjxPYcOqeUW/acNYJS2SmjbJtmrVKdv7N4?=
 =?us-ascii?Q?zeRHUk3/qBbDZLu9Cmxr4oy5hP3IHvNHF+WbJ1pCKMPdl9G7nCCSimGIT9LD?=
 =?us-ascii?Q?v3A+6jhkeggbhxuGA13oOY8JhfGkowPKdZ4SIno8gPJFyerp+B3QzkkkNgOx?=
 =?us-ascii?Q?YGb2A3xg80Om1Ax7JSnncXNPJ3tU2n6e7rqSXx/nmHvdPVJX0/0HGzq4R8F4?=
 =?us-ascii?Q?EmlnACI0n0xkTFV0jUvz489B55XpYBVaDuluzkXqZUsG0DMJSRGvzm8v1nl6?=
 =?us-ascii?Q?Dur0WGF79ArVIolZ+JdsxwreJT1TTlx2NddGJ1ZCcBS2bGza1OIOqL5aGKdR?=
 =?us-ascii?Q?56tunQWIi7d92XvhbLmGTbYkVFodI6Ag7yWz7PZ5HqWtXvsBmA0obe0+G5AI?=
 =?us-ascii?Q?znItTklrBamVU2uXHsgOIQAQ9JhdiRMHtzqJEGNwyhbMnpEcGe+tcxofV3EZ?=
 =?us-ascii?Q?pc8+BxC9LfN8dXgB1AjAtdbBi89lfZdRr8xdNIXw9H4I47gDs/2QDTzlzo/7?=
 =?us-ascii?Q?LuZF7+VrFwGm19d2SFNNUkq+Rg2rV7wNKOjZHZsADREv88vMEFwnGq/kgIdq?=
 =?us-ascii?Q?YKoOYNejqqI5ivkDkOKF/mK6oPwI+u4NH3/GS+OfNywcMkQMmaL/DYhxFeUP?=
 =?us-ascii?Q?ceM6yy3FuLQ4+7PZQYEhCloTDyAcQLMt3Mzpoc7jd4xu9+pXhVgAlyd9ZBjQ?=
 =?us-ascii?Q?GYSFokl3noWALl8aK4aZSGmzmAwWbAjha08opUyBu9w9jScGN5UVKjL+XSPa?=
 =?us-ascii?Q?lWEwDrLPD/U7IsR4poYSlGbSBKNV93lmmSKOEX0h7fVcXicfaw/C+0VJcHg2?=
 =?us-ascii?Q?2FPGSlR10GWxxU+6Nh+w2pqFtqxOel1DXMtGL9VsB8vfpVAhfx9ulfolOhaf?=
 =?us-ascii?Q?FZJK6c20G0lZqIHmcePqCjBL1CZLflPlszt3zvEgn152weUo1LqJJLsLaskL?=
 =?us-ascii?Q?547E06cFZUEKhH5jKZqhqBzrOd4GOM4AHKPozisMl63ocYHfD4k0KlWG8Gz2?=
 =?us-ascii?Q?DLynw+JF9qbUGeFj79Qw6Ua+s1ZQRVt/giWY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZeGS15cQLxk+WR8ZAG1oDxermi2ppcDEB0/OcD93T/Fwi+aX16pbe48SgtSU?=
 =?us-ascii?Q?9hLY1lpyGgjmDWC0ztF4j+PUXV1nUyuzIT49fR2NKA5c7xQSAzLJ07EF/vYM?=
 =?us-ascii?Q?ON/hHwbAT7FMoxF1PLQa8ZksxsIn8KvtpAgdDglLqjF+80T3BnhFKnnXX1sU?=
 =?us-ascii?Q?7v7k7NUjHwMropEfEzXkVgBxbv48OGPZekfRgo6npKALtLP4539a4s93ph5e?=
 =?us-ascii?Q?fhOvcsDtp3m46TL1gqjDmy2GSIdtyXAzsVwLlBOtZYHZm0+oxCHqfnXjHAld?=
 =?us-ascii?Q?K7/b0hJmjOtSyh+HGXnWhwZp2heXquZNJU066evEWrOSRKCKkFXSnOvDF/gf?=
 =?us-ascii?Q?B8jKYLutniYf4P7b3UuVdy5VrA5uzPZGHiOTLdHzDaFgMEwQjPIWGOZlutHc?=
 =?us-ascii?Q?13hVrr3i6Zaco6To08ml+j2XqMJxRkitDLB+y+wPIJ28+gT1mopjA9SLv9Y/?=
 =?us-ascii?Q?MWpD2jW3myzMT5vHVBe/hpfmpO6yN+TpDaAiEv22Feu9ApxBCT/5mzei37sj?=
 =?us-ascii?Q?GUZfXfuoTPZ18vFYFFOLV3rl+w3A/6lXXOflDYJfafljbmmnPaH0Efm2N7z8?=
 =?us-ascii?Q?kRBH0Ilfa12Js6FeFUBG8IjYmOCIjB7/pGIjfU8xBzDSbm7zIKZZQtT6o3Ug?=
 =?us-ascii?Q?i6oVVdq6PASqeQn/Q7dvf/jrfDiYqElM7oe7UjsaTRUlwPPn1+u30AWxPSEi?=
 =?us-ascii?Q?f7H9lXYlxR/GHqvCWsmkjLoJjU5q8YzHdB58t7+iRxJrWhNtLZ7vTRu9QnA5?=
 =?us-ascii?Q?4yAMhNDaQqqiX1RA6rcOTgziTDzoCvtPqfsHdfYYPTTdl5EEjIiuaDzSHznj?=
 =?us-ascii?Q?WDEtZutvScNU+bAKHDPjScZG3rJ5X9zWmdCfbOI3ql1XtCBKl284UErdyDTj?=
 =?us-ascii?Q?9AWoyGPO8Ccqp7nNPu0w6Lv/orYdc8Eu+M7QCvaGmTN/aAh1sql/WYZJRq/b?=
 =?us-ascii?Q?5iJrGkRuaayHRD2xe6i0jDCYbIGzyhSCzVJAjeivEkuZCZBnekibylnUXVek?=
 =?us-ascii?Q?ynaiWjc40w//R4M6xWmccTb8Oagn83uHgZYyrIKpn4RFiELXEdHm0IK8znUu?=
 =?us-ascii?Q?NmrwxcveAz45f1ek+8luogV31Df1EEcLet+UubscRaGdxN7WTQo0VIovRePu?=
 =?us-ascii?Q?/we+2zbBDbGOBlOhRe6drXnxyN940A8YIzlEKSvbrZhBl/73qLSSnBFWARJS?=
 =?us-ascii?Q?nDSuGYHp5jQaeL3gN2KxQVGvIafpdYhAHB6b+RccFlSZ4Fqd7FkN8GlUiD2d?=
 =?us-ascii?Q?oRxjHNV13kQL8v+0ws0/zIz/4pbEYXNQy6CDOTO1ftcv1UD6EBehl6P7JpNT?=
 =?us-ascii?Q?miWSszA1sjbqnQTN51WyAGv1hrglAvdkzQn5g5WEDA9nEWPa7GP/WDLk/ZBc?=
 =?us-ascii?Q?O79J2F8HdSPOry2hIpQwFde1J7xCjJXQeYN0p3GCFhyqgqZFKzNF8TaKnMcu?=
 =?us-ascii?Q?IYrT2/M/WdGpy9+8qH9W4WVR/s1dVADPluz/HN/gxiH9Eoam2Z32ZTU4jhRF?=
 =?us-ascii?Q?lgE8vRB89Oq50aPAG1P3SWjrz7yBfREDWLnS9spIjqFoprXwzIcy8r+4bzMX?=
 =?us-ascii?Q?5ROmPU2mPeRtcQoQSA4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 496d1b74-11f6-4cb7-df43-08de08330941
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 19:27:22.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIAqyEtw6GPe0qd/HgwgN7CXT0zIug0Dxu9ZnmNX/c+VfanhBqZdoJKdaJ7tbvlW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Sent: Friday, October 10, 2025 2:19 PM
> To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Borislav Petkov <bp@alien8.de>; Kaplan, David <David.Kaplan@amd.com>;
> Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.or=
g>; Ingo
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; Klaus Kusche
> <klaus.kusche@computerix.info>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Oct 10, 2025 at 11:47:25AM -0700, Pawan Gupta wrote:
> > > Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which
> then
> > > allows the user to enable retpoline, IBRS on entry, etc, with each
> > > having help text describing what generations of CPUs it would be the
> > > default for, to help guide the user to choose sane defaults depending=
 on
> > > their CPU:
> > >
> > >   * CONFIG_MITIGATION_SPECTRE_V2
> > >     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
> > >       select CONFIG_BUILD_INDIRECT_THUNKS
> > >     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
> > >       select CONFIG_BUILD_IBRS_ENTRY
> >
> > That would be good if a kernel is built for certain specific CPU(s). Th=
is
> > may not be ideal for distro kernels.
>
> Why not?  A distro can just enable everything:
>
>   CONFIG_MITIGATION_SPECTRE_V2=3Dy
>   CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE=3Dy
>   CONFIG_MITIGATION_SPECTRE_V2_IBRS=3Dy
>
> and then if/when some older HW ages out of being supported by the
> distro, they can start disabling things.
>

Is this really improving things?

There's already a lot of CONFIG options related to mitigations that make te=
sting a pain, and this seems to just make it worse by now having even more =
options that may or may not make sense together.

I get the value in building a kernel with all mitigations disabled, althoug=
h frankly I think that only makes sense if it's substantially better than j=
ust 'mitigations=3Doff'.  But is the cost of only building support for IBRS=
 and not retpoline really buying much?

--David Kaplan

