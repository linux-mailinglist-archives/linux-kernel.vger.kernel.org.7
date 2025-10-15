Return-Path: <linux-kernel+bounces-854613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A93BDEDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412CC19C6718
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7C23D294;
	Wed, 15 Oct 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5VMOQuH0"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2D242D91
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536417; cv=fail; b=DBRfFJUP8QhONtSXFdEYd654y6X9Ku27wPRgp3H6u+pFn3qdQkvr552WW0VWWr6ZpjZdGhz+/YQJbXLlOiR+lfDFS3JuWKZ5IswyaIz58/nAxb3DXb1v5snsPYdBYW8FAUUSZtG0K7tFisAuv8vkpiEWTDOmHHors8BIDtC2ljU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536417; c=relaxed/simple;
	bh=ILiVdGwV6c1ac3tN41i3ETkErZFc+s6K5XR+fRMTHJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uPHWOhNNRHkE8w6udwuI7g0xG06glP38VW+W3PaCK/IZ7RiywAUgqeCNbGeeiEOu1hHKMAD/rwHgXgf09URfJs4uJXvOq92dS4zc6xg+EGz4ojBUTU4rY00jxPEohIgW2sHD+xWf5PsohZrxTl/bzVBwXbCYFCBHHGNhoa22vG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5VMOQuH0; arc=fail smtp.client-ip=52.101.52.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRziETGc0NDpBxj/2fGONeIAe241dQv2QCNDlXJcvS6EhIFvBcTV79KaZjtr2vV+ZAHYxfIpvS5fk5n/44xHYU4MIHUnZrXfSL/8ZO5gpw8lu4JIw+LeLszSqOaRmUDaDDQWyoz3vGQgfZ5dCmmKZXTmhF60ndVSAaP7RNNAg8qk1J8KYfKcYF2/GEfyxwBoO9bL/bcLbhAK7jElUlsCGwBSmrUJsPZcUTcHkTTmSvtm4LVMqiAlAatgdcu/MdIoRz244DC5lgnIuzIvFoi6675TMpxSi+00vOPrM36xEKfQ98aBOidrzrt5bo5DFc9GjF6yMTXgQ/17brq49zwfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZgw5PvVZsafdTnwo95TN+M22u8M5DZ36VNv/nA4bAA=;
 b=PDFOskvRK30Iq3su41H/cY+It2cMCZNQDjlFnLAuDcgP9ksbk/nZ+wV9bvNRxrcgk8BaAGLjjw4c2ekgQVFrxzhoZuaQB/dkAin0Qr5q3rTYbV7ebb/G82Bd/YpfAg/QV1AoRtMQe0cdwl/lON1cfhXwziQloR4RzwN9ELxcaTIjskMNfJRj4nqRi/drYZ/LOMpjWYtv1TiEEFpPVCwQB+PbcR8U+Ap5cWXZ5K2ylcupRA0AQEwrm4g5IdY9eAROK2mGC5WF3zAKcKcJdbhfCAe6E3FQ2bgt/JecyFBXB+fpJyLxPr0/rxK4T3sdPka61gM3JHYjXuTlaa1LeJxgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZgw5PvVZsafdTnwo95TN+M22u8M5DZ36VNv/nA4bAA=;
 b=5VMOQuH0aYRvLNYLmXHwBm1JNS5aMlgdy8+raCKOLlUAJyPtsWNa8R0lRlEIrghb4Xs1V6cXqJuGs89RSggHpn0NKnb1hMvlEebf91g78h669eMEM+H74PGM4ZjRywBlOVwPTF1qjgMzxD4+7LrvYSUHhrZGnHAVB2WtoFXzZzA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 13:53:31 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 13:53:31 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Aaron Rainbolt <arraybolt3@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index: AQHcPYmqb7qd0BZyXkK7jo/Wse1167TDOpgw
Date: Wed, 15 Oct 2025 13:53:31 +0000
Message-ID:
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
In-Reply-To: <20251014231039.6d23008f@kf-m2g5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-15T13:51:41.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS7PR12MB6142:EE_
x-ms-office365-filtering-correlation-id: dc7265d2-4aaf-46f9-f772-08de0bf239d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q3mglT7IwjKB3GGkTemzuiq2j8U2CZpJF0ULFyV1oaXpGw0d1U6/wWcg0XIh?=
 =?us-ascii?Q?L8113QKvqQbOJxqCKf6lof8sMohZ4ceH7jRdh5WwdmPbv/WCcQfMjkQzJomL?=
 =?us-ascii?Q?XFbRkdR+lVG1/RtQuyYpB4tJR/m78fXm6+8laeNvZpw86r1DIxqVAinb10vX?=
 =?us-ascii?Q?fq6gG7It6vEVGxy/xyAKcX48iEI4K4OHBi/tRNosvbvdPqO6Zn6M/gQIyH9N?=
 =?us-ascii?Q?4DsJex9wFxrajIGYLkT86J3m2QXq0evbc5ALqcGvvRWBXUDVdMxoddNSQFzZ?=
 =?us-ascii?Q?ULI7vdLCztobYpoz1YYA/Y0U09X4sHaQnmJJHyco9Jtjet+ow+a4w0VkBPB5?=
 =?us-ascii?Q?a7ZRCwTlxnoZ7PP7R+iUxaQ+6nyBLg2a4kek9OWPMCB7HQJqZHu6HHAmKBwB?=
 =?us-ascii?Q?Q9TOzQX32lTbLTsDl/QuDECoLNx5J/cxniCMNrf9yczgzb8b/IXbcvu3GS03?=
 =?us-ascii?Q?OR/GyIdcuvE08XR7RIBjMtiPf6PKbWmHUHMjPfCQ/90wc9AHErxpl4qB48h3?=
 =?us-ascii?Q?EdjUt7qHtJkddk5su79XyXFFLwyw+0dBQVtEIZuk48e6Dudisaw/gsonB5Pm?=
 =?us-ascii?Q?wDg3LqQE4HKFG/rrlXgy+n/wFwlKTbQLvExlAzIUkGTLsdaoQ0AvaEYl2M90?=
 =?us-ascii?Q?i3hAhrrHjZKpZhxXz9MBf/XTOCk1DHH0WEB2qT2IxW5RDQ8C/eLDZCBZeOn0?=
 =?us-ascii?Q?cSH3E3cxPDr9tnwfGBJ6y2dFwdajzgWswKQ/BPAVOoBV7qFbLtMRq/nXTkUV?=
 =?us-ascii?Q?qENi50BcdW9v1y2j2wP9REhYq1Hh6njWRS7G2OAwIoktiBa39XlOPFfcZIb0?=
 =?us-ascii?Q?spHxhqQBijJAhO7g2ml6XKKWBdqJvoajZY8DSChdJzXfqkTnob2TW8eQCBFk?=
 =?us-ascii?Q?SOx81Rf8B+5dFDSpPzCdd3/83lisyQSHypUx1wdKBexiLKTov+V41poK7lp+?=
 =?us-ascii?Q?eg7kgtmCpxHvM8uAsSPaic5/fKk9NNizDdzdTi4Y9asqQiR6eQZNO4WEUIm/?=
 =?us-ascii?Q?HMf5oeaKQe0XgV0T8SE38aKy0NYCPXaoTazcGb38v3U+4oE8s86YAvtzzseK?=
 =?us-ascii?Q?3FkK/1Q3neKkgrTKhHBn9JJVzJnq8C/NIJc+dsjLj7JAgcNYVkZCPH+VyJ9A?=
 =?us-ascii?Q?inQQ2bA/jNSvIoL60tXQ/iIWa3GxGYuDLyMFn5YqLI/OlWSt2mUKendnN0ta?=
 =?us-ascii?Q?OyK67XzuSjFNEbgJGdArrFWY0oyK2KSgfavNisQasMgJ4PBbqT2Tz0qftu0d?=
 =?us-ascii?Q?YIqLsgNcld28CAaikBQbj8yOtXTQb783sdAd4TjxZGQfOuZvtlFrBeAAthJ4?=
 =?us-ascii?Q?4mFebxk/dthx2k4gmmoCBSH2+YqB1oLmo932K4dnThWthJi3zWz7ZpcTINdR?=
 =?us-ascii?Q?2enzu2Ss4gzCOaxFHtVbs5j8aKqh1Vfclpozo3erLL2VMe2xW1piQiZnffwr?=
 =?us-ascii?Q?cpPNHXB88BZ9wNtPCJyVDVDT+g1AuHx+d9zNYNbSKohEBHRjlDhlolp0VMPz?=
 =?us-ascii?Q?1kcl1YpdRyPAml9lvNNminDMc4RLCedwxz07?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q1+cIAxOdpas9TIX62tGfcLUXUnldAFUMbjvpahB6BXi3514SnX77wfs1UvR?=
 =?us-ascii?Q?T463sfGoqPQNF4lXq1Yd6AecPShow2DmSkP31DNy+rpqHbusSFIODzEu1kXE?=
 =?us-ascii?Q?a5lKuwYT+HmbnFexnQbWX7uST6tVoXRWpOhV1GgMqrLmUk59yFCC5ZWe51hs?=
 =?us-ascii?Q?oQirbRC0hcWPoXQih6+uc9QTyjgyd6xvccs0TQns9QDgvPCWhAcoXsoHf/0g?=
 =?us-ascii?Q?PnFjsOB48SpEesJ2p3eNg7Qz8p/QHslBFg681v2Mv9fM2oJSTV6bPcM63rkA?=
 =?us-ascii?Q?JEb+DTWYjIrwKmSDPQ+nOM/7oPkkTOaOhFQNQzCflsjI5HLjKPxLfanDzdbc?=
 =?us-ascii?Q?pO1xpUuM+ussqc6W3roe/IEM6F+q/j7tAy0ZTKvB2K0rju6oR4y8VnZUSoAP?=
 =?us-ascii?Q?FLVwE08okFFPBsX2/yG4/HTYjWVPaNu+4kuSGA+4QgB1BwFUQsZpq0VGTA7h?=
 =?us-ascii?Q?tN19nnDBa1t8+yK4SGOjxrF8KPAAtBCueWkxVw9yHMh3BDjW09VHczbA4MJe?=
 =?us-ascii?Q?sCI9W8avsez34b0gUBHn1d3H3hlJqHAekZsQRvgVhceetJtMur5VTTaUE2M+?=
 =?us-ascii?Q?yCLirG9TFpKbjN9Rus4jRS3Xo56HPwmwQL3gcqdWixYvzIZn3nSSUK+GN+yC?=
 =?us-ascii?Q?wDuVnam5kld7qzhj3t/w4myw0hVcz5a6fAX58pzk6ZojnhkE8q1gdbHis/+Z?=
 =?us-ascii?Q?drH7Zv9LLrDqdXnfWKDP752AyAVZ65Otkj4PsXlcosXfVK+tCIKAryhLqsBo?=
 =?us-ascii?Q?qqYzzR3x+W6zr+7zVuUbqadFotaxi8uItP6p6SGbYh3A8kXZ1a+7fWigGD1i?=
 =?us-ascii?Q?vv5xJfwoYGCgoCxcLHnCWhh/l3mvNCLjMoQ/jPdJUMOk1q5LAubyuByhIypt?=
 =?us-ascii?Q?LETOFe0+K+hl+u3Yby14r97VUoffPr9bO0uU+tOnIygGR8dx0ZuhfhmfBMht?=
 =?us-ascii?Q?+nTCVFrUpH/kAxrnVekx/Ssu8XtUfxwQ7iCvJa+2YKlynDVd8PyfrVITNJYT?=
 =?us-ascii?Q?G2qsiyTYjYjcLkSz1CY4W5WzrX2/G8lQfhQ5KPgcKI6nj/6xP+QpOYEHQp+7?=
 =?us-ascii?Q?Ly/Ib+p8NbB/ryM4yMroKrugicB0ZR4mEv7W/8uiLF2zkW1Xdfs3xYa//ptf?=
 =?us-ascii?Q?uhmvVtA8ayHC9Z4aSIsiAh5V3cJkIqBXiW44vh+8l8/Fc/ME0jKojcgblIqZ?=
 =?us-ascii?Q?M1zbp4BuQf4YeXss/1EoT6Uai5NSearFUDn2y682dlKAu34c83k1ovxsM30J?=
 =?us-ascii?Q?ryvxKGT0AMsFE0grU6DZBaRcBe4ZABYQqmdoCd6jPN1VBUKA3pzo48tv4upQ?=
 =?us-ascii?Q?t8LlWlmOFTFrch74qSZxW3blAVsgoqy94639jqk/PULC8n3ANvHtg+ALz9Nh?=
 =?us-ascii?Q?RHA7KERh0cc+6CxLB/YkC5EZ8NB/QRaIBIC2GmSqWhGCL81lL8g5IF5SwP4H?=
 =?us-ascii?Q?joapaH1tp8orrXWfMTukzpY9LqIGCLXV/2E9rxVDtoxvLGIetkN6huNE0K7z?=
 =?us-ascii?Q?D6Zh7pwfJjpXlYnXx0SlEATxB1DI7lP41dUrOrh584W5AN7WZKlAt7UhjW8H?=
 =?us-ascii?Q?vb/D6lpFceCF2s7tVD4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7265d2-4aaf-46f9-f772-08de0bf239d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:53:31.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDGgQez49dGFVYngJQKjwv29wf+yk84SolaESlcHPngF1QdldWqQXEX8jPeCUbNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Aaron Rainbolt <arraybolt3@gmail.com>
> Sent: Tuesday, October 14, 2025 11:11 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Pa=
wan
> Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>=
;
> Dave Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvi=
n
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
>
> On Mon, 13 Oct 2025 09:33:48 -0500
> David Kaplan <david.kaplan@amd.com> wrote:
>
> > Dynamic mitigations enables changing the kernel CPU security
> > mitigations at runtime without a reboot/kexec.
> >
> > Previously, mitigation choices had to be made on the kernel cmdline.
> > With this feature an administrator can select new mitigation choices
> > by writing a sysfs file, after which the kernel will re-patch itself
> > based on the new mitigations.
> >
> > As the performance cost of CPU mitigations can be significant,
> > selecting the right set of mitigations is important to achieve the
> > correct balance of performance/security.
> >
> > Use
> > ---
> > As described in the supplied documentation file, new mitigations are
> > selected by writing cmdline options to a new sysfs file.  Only cmdline
> > options related to mitigations are recognized via this interface.  All
> > previous mitigation-related cmdline options are ignored and
> > selections are done based on the new options.
> >
> > Examples:
> >    echo "mitigations=3Doff" > /sys/devices/system/cpu/mitigations
> >    echo "spectre_v2=3Dretpoline tsa=3Doff" >
> > /sys/devices/system/cpu/mitigations
>
> If `root` is capable of setting `mitigations=3Doff` via this interface,
> doesn't that somewhat defeat the purpose of denying `/proc/kcore`
> access in lockdown confidentiality mode? Assuming one is running on a
> CPU with some form of side-channel memory read vulnerability (which they
> very likely are), they can turn off all mitigations, then read kernel
> memory via one of those exploits.
>
> There should be a one-way switch to allow denying all further writes to
> this interface, so that once the system's mitigations are set properly,
> any further attempts to change them until the next reboot can be
> prevented.
>

That's a good idea, there could be a separate mitigation_lock file perhaps =
that once written to 1 denies any further changes.

Thanks --David Kaplan


