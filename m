Return-Path: <linux-kernel+bounces-856803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE720BE5217
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429F54015A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CC239E8D;
	Thu, 16 Oct 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQjoaxHC"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C21519A6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641007; cv=fail; b=VhKFY6GJhmVEvYd6QA+k6qhUqEUvJseBF03Zt2AjSIiFFZVbJfj55UhlBJoFnJBANhekUkK5W4NEykLq5HLbSuiuOt+K8cmUyPYYffIQj1QSocTpsXNDB9HMPRQc525n6JEVRkThvcqpcJ5hZuHwO+Abav+2Rk3PlQG8mWyoJUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641007; c=relaxed/simple;
	bh=kNk6rTEb01ZiDOWqQC+QCjY821CB811uDyXQCB6lPjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TbiB8ofYnURkOEcjta7o3gm9Pa1JdPMh7zqIEMDSfzxhZv4WqcieI/RBop2P/RYqx/zer6mTRQdXHNUCxDVsu4lWEPCszGFlahg3O0hTmlieVa5U9vqKLA82VM3IREbbah8AEKiciDR3qYND91siagG5qPoGm/egAAnzpFllcYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQjoaxHC; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S310PDqiV2iMkuuB+5a9P5n/VURc7uuc3dGTJzQMKZSDum4fvzuIDULhEVwxy+uy8tvBaxNKbd1OuYivL+zQ1dIr6Ya3ENT811Euszzhtj5VEx89CK8jiZua4+onj22Ti5tu5ltclELirXJFfgNXHQdVEcErmXs6/kR4P1RZ1RYLU8MLWy8bi39xIlp2AU/suj9GiQoPQU0jN+3AQPPA+DPrFFkJ/Wgj9n5VB40b7DI0OaO9ZIyn3AJZRv0o0ms5ANnqa/q/zn+OyWVG1JFG23n6AvlOGduR1K+te5E/oiDCmpy6xeNF4gfTjCsWqNsiKN/CIVon73z+kqBB8RowJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5e6sv1xEYL9dn74qwL7yOwWkad1EfW0JHFQ8R4szXY=;
 b=F3ixTb9ZUFcEMy3tU+CC/qB/52bZSLJqbHh9vutu8LM1e4V//+6qYdtPSZHbCLamw+0Snel2PO0wXijc0Qrqf3ycIU5HCVKoT8Qr8YEeDHYZALtbgf4RP1wFSmIEh+NYLik0dI4lzc1pNz1WlAHkZksC0yK8YjkcqmJIxj0c6+kFMPosFsKKIaR2vWW9wXSBKDL0RbtJ5o687/kZ52cZZcHiCD/2ozwVkIJfUC+hCExs3YZBmAHDRZLsLrqtdZduBKIf/oLn3wwsYGAP1ztD73HLIqAbTzEotL/51W+qOQkgsNyeY2ADZNfF6ZjJVxK4w+HN3OuFPI5uE2QqoFbL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5e6sv1xEYL9dn74qwL7yOwWkad1EfW0JHFQ8R4szXY=;
 b=yQjoaxHCkYiGW71QdKg5QaOm9G6cEAi+hPPzaYrC32UEUgNzB5W+WD/F/12jo3UdpLjThNLq9nhSKvvC+7i/yonwU4T50fBIbJpTFwNGfU35LuvAqgb0kdA7SWxgZ3FGi5Y39b47qBD+F13J0TE7qKwa/WPSDlJJPpfwzoqMtHc=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 18:56:41 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 18:56:41 +0000
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
Thread-Index: AQHcPoiqsoexywdJOE6yXtrK5ZRlk7TE1yEAgAADZgCAAAuVcIAAOOuAgAAAikA=
Date: Thu, 16 Oct 2025 18:56:41 +0000
Message-ID:
 <DS0PR12MB92733EEEF2FDF39045008EEC94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <DS0PR12MB92731E9877D21E36EC3EE4ED94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016185241.GG3289052@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016185241.GG3289052@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T18:54:36.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|IA0PR12MB8837:EE_
x-ms-office365-filtering-correlation-id: e0f185ba-334b-43cc-69d6-08de0ce5be4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VQ/+yaV8iZqa2EEjfpWEKAs+rc12S+Ce3ov3gvak9Te+60XMbs7aibGt8G7D?=
 =?us-ascii?Q?ROwJl0biboQEUR+0pPgFNRQF4jeI2KWXX9YHTRlP57aw3w4Mi1O7oL3M+XsW?=
 =?us-ascii?Q?W+FLlMQ2t0vUpWOItkAtySXC+ZrwGrkjYzbojMK2oGfGqKISkM00mtI3BvQB?=
 =?us-ascii?Q?L9RSq4A0WaFgQWyxVZh48qef8U17GiW22CI4LPJtAkFZFjLXADP8Ld0qYk+q?=
 =?us-ascii?Q?rYSSBLsiSRV3dbG4jc0PnFtyTC2TAFJzY6BJtE++ge/R2zMRXJzBXLW9tmZN?=
 =?us-ascii?Q?0Z2udyXhvcPFBajAhjsnsdO5ij4XYa/a0nscaD0g8iDoZFqauCRyJ3Sy3new?=
 =?us-ascii?Q?Ksdq5fZHBzxsiYjEdvd0PzcrT+CMJysrvu+xOgV9m2eTndyCRbJh7KM+KC85?=
 =?us-ascii?Q?Hf2rU6yf8ITv/A2tMrowsmbhv5HWxznVmNuPrTbduyolaTaa1NUhbFCmg5bc?=
 =?us-ascii?Q?Af09M3gxC82kUnbbwN9qq0whEXyJlCg3skGj+bj+Kyoih6jwEL+JSrd3ce/h?=
 =?us-ascii?Q?rxJwc2BJqn57taneCy+qSjDONK3k3Vu+RLVFb0kBKW/V1QkQEF8giQRxlg3U?=
 =?us-ascii?Q?wyrcwaf+c3GXRPB8hxXgWjMMzpk2ncqNGeoACzANnnINT1Cbx5GIAxgC3fFq?=
 =?us-ascii?Q?LzubG0IAHNPeJcnDQPr9WyZ3pfad/UAUCLHg7ZRzpg51rUNVunCM/NELoghx?=
 =?us-ascii?Q?WaGw/8BV/8+K1ggvQls4P7SQMTgUNu9H9RMCf5iAERMC6O5AcNRHYlg+KYV8?=
 =?us-ascii?Q?BhqcLC6+rMAounBDZ8n7tD0o62Px/aT2cNgU5UNSCA5hEJjjG2pDMIIlqWr3?=
 =?us-ascii?Q?DoV86u1055z+ILhc9uFdFZWCsVVmcginCUpYdj/HQNUm4FCgiqM5f6hF7ulZ?=
 =?us-ascii?Q?Hc/7zxsEjcdil+p+UzgNcojesY2Ww7UwGK8AU/lAtVf+tuyx2g9OjWyDhlUF?=
 =?us-ascii?Q?orYdEwWq/4wrWLKvgttEX1oO3lBOeyfa7gONoRNL7ZvYR112AnhJrAvg6K4v?=
 =?us-ascii?Q?XYO5d1vtLgUaJ9dmRdgaQd5fGjv6F3wAVZOQLGRj2/bfULIqRukIwb7Lc/Hb?=
 =?us-ascii?Q?8SJuryVqc3PZhh1tZrWxJlHZEEHgxwOMVEJrQ5f7nsf6XnPd3ciO7STSX4M5?=
 =?us-ascii?Q?NzHVeUVQPedE2Uodv8aLyqE41O2cyMirrDb0U8nsz+OKD/RHhyReUh2uGiKm?=
 =?us-ascii?Q?fcb32yfTKYhXGbXN+hlwJsQn9CtM4yofLe0s6W6LJpnWRvhUhALNLvf4/toY?=
 =?us-ascii?Q?ovzQwmdVe3THqblj3ERGR0mOtoxWeoMU8fdhWa1TuwKhLWPHmwal5jGEoAgr?=
 =?us-ascii?Q?QpCaj9QKrjuVHV0e6+jKUYt+WMXkTPulOgxfSnPN/Flbc6aQ+H5RK16dAtrR?=
 =?us-ascii?Q?/pbX+DUHivjzoCpy/x/CQ6eAdth9S3Rs6C7G03RvWOWZy7J93ix0lwfkK5gA?=
 =?us-ascii?Q?oJ/DRvAeUYwTJjuK/LfZqSuWROFdD3zmhB9nk0stS8djh8YFzEO5MFtvJXHh?=
 =?us-ascii?Q?+hwoRnNvluH5+GGaQW0j2AX5tL09TLu7RKDT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ByNid/5efyA0z5UWs2tAFzhugYO4HQx1xSGngadvL4JMx5Ks5JqirUbsvWF8?=
 =?us-ascii?Q?UHbQtSM45bAQarxzGWsWOoMYGl5NwkBkYd6wmcG8amXRfnIC26oQDlEHQxHl?=
 =?us-ascii?Q?H6h8CfJEAccJCpptdJumhcAAUIAzhFrOZALqOEiwgwfC0jwU5BSO4D93J1Td?=
 =?us-ascii?Q?UaefkD8jezxBUQvPrh6Q/yvZC+xIHt+cRp9+Nx3W9id2JRbIZTThcUgsGjTO?=
 =?us-ascii?Q?FGlDL/uX8FCJKutCm/dUZCSs1lOzyiTRVixLVcNekhn0u2lzHJ1LpAqygher?=
 =?us-ascii?Q?/kAEUQ7Ec+3V9oQqAHop9aubTW7m5gsZR5VDTZBRHORFKc/Qb6t74uieyI8B?=
 =?us-ascii?Q?f0OXwQZ5R46VhFNq1eqLOFmPdp2FPSpbkBxrJOvREd/FQ8whcR8ba7WYWKfS?=
 =?us-ascii?Q?5ommywKiAOIGuo0F7mQrzz/rRoe/1xtfImd8f2k39w2Qv+PSr14XzBheFGlz?=
 =?us-ascii?Q?EQm1mWRrf+gkZdbZeYkAyzrcA7cCONPQNQYpjT/WGRXaMTtNmRXD7WHbGpeq?=
 =?us-ascii?Q?/KI9cXqwdCS3t4gKMX/oxX3iYYSnyvzJ5PRYPeprC2GPvjyHWNjS3z68JznJ?=
 =?us-ascii?Q?l1ru7ECojRiKyGmDTB3Yo3BryyoxuJ/4zItkXepVRu01TaA0jPIN9JWZb6wA?=
 =?us-ascii?Q?dhlfqA7EUZ8x9BTSetW+BO+X6Yuq8FjeD84IYIqDWp/9U1f9hh7Ul9r9Zk0J?=
 =?us-ascii?Q?aJ0s5Z9B2VYgA8z0oL1/ui/opDwc7lshGFPR1vGgZFsAtl7ckCIMa3PdAXlX?=
 =?us-ascii?Q?iftUbFThywrlBYPAf+WHPkDZSqUYz4bjxICIQESIHNfDzzy+HzeT8ugUBjJ7?=
 =?us-ascii?Q?2Va/F0GGodqP5V4ZVV0lp39DBQ2yPEvg1jBeeI5WhR6mf5YcpABqlH8hzHsm?=
 =?us-ascii?Q?6rt4BxTVxohgQkiw8BbCOuRN8u1LMDDmug4AmLu6HKG7loG8VOsR9tjMGq+l?=
 =?us-ascii?Q?SfFa6GhS7lyAJ5s5DPpmqlhc4hYMLkrX8+UpBDPoFQ63hlUOYMRZ18rJ78e+?=
 =?us-ascii?Q?TuIOT3VtLAalH3QFDCPkRo3oLgmfuNUVcmztK4b2Fi1eB3qZce1kO9r/pUag?=
 =?us-ascii?Q?Z02j79LusUPdL0oKS0ux9t8dbJ9gpsis+f1vCLCo9JehPqtFyuEPXy9Z8Yk2?=
 =?us-ascii?Q?+hi5YLaRRS1WGSqXdxAwSGg+kjrzAmuVix/obDm3CeEq6dilM1gn0v8ZhcMs?=
 =?us-ascii?Q?51fV1pqxSe2KlWLJjNsH7IdmIAhgkpbOiXnTwa/ruL01mVFW4Xaag6sQSqE9?=
 =?us-ascii?Q?evMrpMk+hOvM9izMN6gqzHSIHUu9K5jCbyuKX6TLBVmSGKR39swnihvy1+EE?=
 =?us-ascii?Q?tbxR+/jBYYkzqPVk5TJUbrx4/pup0fQ8fHyAA79L4ztcH1nbdNJ37Ez9xeeX?=
 =?us-ascii?Q?Fvpe/kJH6/CKi/GqPT+Mewl2KC4hAr4bOXTKXWRMEJoQBmQvLxKZtzWwE6gE?=
 =?us-ascii?Q?SpgDWwbU8RJ96ZuAf+hrm7Ux9BI9qr5T0DfvgckbcpXdeAbdNtDD1er3VB4Y?=
 =?us-ascii?Q?ZbEN3tuRPK4lxJW9oPUhb7cRj+pUyafWagy8QsMmw82TtCXliWF4Mu6V3hGu?=
 =?us-ascii?Q?afpJ28Pv8a4PFcMFLsE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f185ba-334b-43cc-69d6-08de0ce5be4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 18:56:41.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMWN98RBQftK/v9voVQJZxo6o0V2LjRjtIWNNBM5kxA7aH7M4ckGIhYwI+rajaYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, October 16, 2025 1:53 PM
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
> On Thu, Oct 16, 2025 at 03:34:14PM +0000, Kaplan, David wrote:
>
> > I will note that on AMD, MFENCE has the required serializing
> > properties (like SERIALIZE).  On AMD, we could use MFENCE in
> > sync_core() which is probably faster that iret_to_self().  But
> > again...do we really care.
>
> About faster, no. But MFENCE has the benefit of not causing VMEXITs and
> also not being IRET, so I'm not opposed to you using that as an AMD
> version of SERIALIZE for the time being.

Ok.  Btw, how long has Intel supported SERIALIZE?

Do we even need a 'mov-cr2' version of sync_core or could we say that dynam=
ic mitigations requires a CPU capable of either a serializing MFENCE or SER=
IALIZE.

--David Kaplan

