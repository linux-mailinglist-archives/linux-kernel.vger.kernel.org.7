Return-Path: <linux-kernel+bounces-768946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F3B26839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E6A16A675
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9970F3002BE;
	Thu, 14 Aug 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9cKsb1D"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB14A4CC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179523; cv=fail; b=Kjdn8AwjIIp1hLl51JzvcXj7nbx2qY5TodZJq+Uikjw8VIqhD54cXVDeNbLRcKTg9qGTLZvY5g7ztPn2zXPoQuDG+TwVfJ0oYY+rCkiTDxKWvfgT3LW/AzSlNDaHI5+eqhx9umCqhmBO+D8tpUWQj8aeCt47k7FHKRqwUgRXpWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179523; c=relaxed/simple;
	bh=Vu+hNAlEtlbza8SXxctdm42U3WfgNFfzpQT3Wp/wYA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a4jy7EHMJAM/c0udxYSCijXt0yzSP9kQsT/buS2iBgScJYD57JweNnQpc27lIe5reiGKSjIE/yyq2C20YtLoOaLYZyBkNf5HtaZtan/bS+Civ4vagd/jgqwx42u/SrHuIQOXkinPY+fRhCuP7lm2/k2+/+VPkXlc8IMn/0NhmzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9cKsb1D; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEQA4ZvmO4H8M1AqOG7vNNrDB7RAFKqLw8r6io7AtGn6Ua10wl1I1oE58wDBjq+t8dX8LbskxUWp1ngXUSUAczPz2HKKdmh07QKnQmGwyW2X3gsQpes74Zbzcuu/ytgladxp/iy/3GqAVADOrIBcSm+TBYkLoUcOz8Gtmjg5n9/w4x4YRHLRVLPq+Kg9BjOYe7jlrju0U0mxIbF5sUarhIppyj2GjRVzBb8KF1SByel5YIMdELx9YKN8+Q6f2/CQ+/nUypuRaRXcnbr8/hgCw/3VaR89dIsO3hk/EGdolPYS6eOmaaOrVf5rVDTgr85dYa7m36tGATyoLgrHNB6sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL0fkdZZxGKO8sg/ZiwVhzDJaEHCJ8SO2tumeg146Ek=;
 b=rdCItjUg8rFElXGUHFf5oqVQYW8YMjQNv35KUI2qdur+/pRRF414/48JH6Z46ckcyfAQ7jK994m9t9jJWRYPDJL0drzQ9s/rTcM4qUMZfRAcPBnzLX3ZQ6c2ukxCNKBDIP5gIUiqM1FynpLFKuUCCahfp6pKtFNqcqCZtSpuz6CJX+bazGOLK5akvCvGXTwRE6AC360OOsELqhqbmu4z9R+jN5q2myLa/KpgWAtqxNuhWREHoL/uhgoPJCGNDJog8divaCTOcOgXwcroeNpczdE3iOg4NESMTn9CMXO/FH3epF26UlNH6/19PMxUei2+gSmBCKAFnVpc38/F1v/D0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL0fkdZZxGKO8sg/ZiwVhzDJaEHCJ8SO2tumeg146Ek=;
 b=a9cKsb1DrDJpthwt3JlE9ojFkqdWLzk8aS64wmBUOGY+5M4g/J+gFARWh609cDUUwMnb6dW9HLWTM0mAS7xdGtza5rCSVX3B3Gaho77Xvlf/qRTiywa4BV0H5m8HJIk50AwO6APGRE+A5ITXx6Y9gaMt37zYO+RCcSF6xwp7hyg=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Thu, 14 Aug
 2025 13:51:57 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:51:57 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] x86/bugs: Use early_param for spectre_v2_user
Thread-Topic: [PATCH 1/3] x86/bugs: Use early_param for spectre_v2_user
Thread-Index: AQHcDMpLefgsjy6apEGOsGw9aRcAB7RiKWyg
Date: Thu, 14 Aug 2025 13:51:57 +0000
Message-ID:
 <LV3PR12MB9265D5129F8090B003C807BB9435A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-2-david.kaplan@amd.com>
 <20250814031939.wkkmztyurgtnhjx6@desk>
In-Reply-To: <20250814031939.wkkmztyurgtnhjx6@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-14T13:44:05.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB8480:EE_
x-ms-office365-filtering-correlation-id: fcf14c23-03fd-4286-f76e-08dddb39bc1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CDW4uvmOgm0HpQjbUCO/LjCDm1RyEopYnoeJ3EEVvEPgYVWZXFisVy/mYi7h?=
 =?us-ascii?Q?hCkLBw3MTwGiXAyTeukyZEWLjoS7B9C39PMpafOSqsuA9ckDvIWurwgqzyYX?=
 =?us-ascii?Q?Iw7bZm36sN/6rU2ORukco8NXI9aqqFyPI0++EOMvU8g9EaOZWTpxcKIHsJvD?=
 =?us-ascii?Q?qgWjtw3ef0crlIYFaMbN2lMuXJ+Phfugl9swVJKfDgWcmn0NFYol/SZhS6nc?=
 =?us-ascii?Q?as5l69Amx4eTwuYy/wWIJQIxLUVANoe8K9hHZsFiro0I4gnC54UP5Od0gY6A?=
 =?us-ascii?Q?9bGmg+Tcr+meKKizTkDBTwsY3HXvIUhgwhW+XPTjkXBHhsn7POAKxdLFKCio?=
 =?us-ascii?Q?Y+uIJv0ylPHMkEbrop4rQQv4jrbwm1SfXVfx42ymRB/61bfx+4HAVKKN+B+v?=
 =?us-ascii?Q?hoTUVMOPloBC5V8ByJ4kj7V1U1J8WGz+13qqgCeEr1Lc/95kitmI1iLossFO?=
 =?us-ascii?Q?QVv+y/EmDWxG6vquLGnWkQYet/zVGKqN5rLE6iajeeJMYNdUo89vvKV4IFan?=
 =?us-ascii?Q?lt2U6gvSRDLveUJGSzHcVCNVfgFs0uS8BN4HbuSBva+hhdsaj6/I4rtmik6J?=
 =?us-ascii?Q?+i53dNI8OI1/Sss+1tnYKGF9flRGh02ewKTOLfsptxL4ssAd0TP+xRunzjJr?=
 =?us-ascii?Q?YvijBZ9Ve+sES8X1X02kd9IQJv6fukiagwwnkKxBisPD3NJql/lTVD5rnrMk?=
 =?us-ascii?Q?Al0ndhOu6slLo2jsHz7Yd5neO93mApkVUNJBmTOoZcue2o/IQU5WjTTx8MzY?=
 =?us-ascii?Q?CW3tzJk33S2wS8jXObzLPAeDHaVliGzv6J1QrxtCXvmAMSxcxTwtOJUkggnD?=
 =?us-ascii?Q?fk3FuNF/F5tNIPf6bsXTaGgr2e3+n6CuEUBgNoAGQSdAqHcEiWBlE0UgPM8H?=
 =?us-ascii?Q?DQ6Apbzv/xCTh7cwMQAH5zsL1btYOwkKiKZw1dy18PNnHXLQ7b1X056VFqlu?=
 =?us-ascii?Q?hRK9bZK4xq/cJ75qlfjrfpsUXblWbr6W+Wm/GBhW+c9amfmrx8JeWC9anit2?=
 =?us-ascii?Q?+axniYYf1miIvNq5X0kF5f/Hw0au2lmGzsSMJLyJpOe6xWzFa9L6ACSpRWoU?=
 =?us-ascii?Q?EkpfCSFzFqpiCzrUZyZsyoLxRExIwWQSK4o2h1SiU4730B2Q4br8aitnvGjQ?=
 =?us-ascii?Q?jTpi7LklqdHJULrqBA1p9sIWlcvWEWxb1vYCiXMiilYL7RgqWMnCpwjO1kL6?=
 =?us-ascii?Q?69raNLEUQP7p7yk8otNArt5RVc7DCe+QtHIJtSuID6bmnv15fP5vsGNZF6ZT?=
 =?us-ascii?Q?HGZbCAtTE8KamjkltDTwsx4r7lIboJJM8oyWzRu0UdGmIr5GTpkY1/Tryqf+?=
 =?us-ascii?Q?uPxpNQpLHsUiWA3iAKVxS+pwQWb4ve9VNHDJ5O8hCLESEe0DkCydsAeBkY4K?=
 =?us-ascii?Q?CASyh6TR6xwR1Pd35qk18PhU/WIW+9b6sKQvS4Ris6iy6ySRtu4ZVXz/Y/Sk?=
 =?us-ascii?Q?9NjudzpcLQNfPV6jVkdJEUhegy8kpSR08PvBNzkpOhbSeQhYFOJmAHg3FSrv?=
 =?us-ascii?Q?nKjU9WGHFo+Rhho=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+Kyn9H0o9Uimhx6MmY8HDZND1vbAUHa57H8Uw0gHmRurxo2gPbDo2QEu15Lz?=
 =?us-ascii?Q?yR2hvnzdmF+13uO9fgTfPka8Xr4p9iFXapNpqwqWfCwD5ORmWlRttg4FykmF?=
 =?us-ascii?Q?NtCw3c7/y17EB2uYKRzJmFsWY7z0TcQGZDzevseQOH+UDfmnXSScZFkj95gC?=
 =?us-ascii?Q?ZySjg38lbjSmXJU2sVij32moGkQh35hJ/uLExpsMwwLI3UOPnpn1mDFrgvwA?=
 =?us-ascii?Q?H5mBfbt7WChN48Cr1PIdnNcaWbvOxYopLM1H6rpMMbq/s0ulwjEveDmrqPxt?=
 =?us-ascii?Q?Vamx5s2CUgkrjy9aIZ4WLzpthwIc+HFgvCJ2GtPxNbja4WG9h7kvDX6tsjFi?=
 =?us-ascii?Q?XIaEYx9KPu/LVQkVqrxD9WyUol5MaLa8aSwc9fxlShyncqMlZeK2bxCTITb8?=
 =?us-ascii?Q?V3xtMG7BTG2xBSXBxJQKA7pLN+5KwNR3bIgiOpGZIGnOUM3R7PI/YNga7t4P?=
 =?us-ascii?Q?6JnzgrjmSpahL6vHwaDyhCyCYongkZPVTQIC2i1Fe4gbeBg4Gll8SXCH7pQn?=
 =?us-ascii?Q?URWIvLlGzaYac6S7jP40lC9q1xoO7HCb2LATULHItiPPudF4uB8x03Jkl27V?=
 =?us-ascii?Q?/03ojcCaAfVtobvdoX8Em+5mWpSdsjS2RSPAJt26mn5sEP8t2TGtKJHXWk+T?=
 =?us-ascii?Q?VvRrLkfyhtQJiM1/Bgn7KRP1U8mnpnjtGtrcvi9T6+aDYuw3y5Vlm/TJsNoR?=
 =?us-ascii?Q?MCiRCJC4EljnE1YsYOwqP0Pvqp502YgrTfZ4HSmQ/CQk99wp3rKn+6hpZm7c?=
 =?us-ascii?Q?h8xuB8MnI06reP591G/X+/aoj0mMdEalk5XebHK+3n3HyyKEcRYfugdwkTsm?=
 =?us-ascii?Q?UEuhBD7wo1/zQZU9suKfUeLslI3A7P51i54/kwfxO53cdBYa+LCiz9o559fl?=
 =?us-ascii?Q?tHuiV05vn0TOq+R2Hltr/L24PZ1D9U+rZRVpdPfIcH0qhmnTO1rOE/gZasmC?=
 =?us-ascii?Q?RjfC6/d+WinLdPotUUj1YEcbHaE5rbSmp0WXtTJrjVFWh2+mAntOVcXoQrb0?=
 =?us-ascii?Q?JnRq1OSFcNaVONhOWyizsO0AHsd7Sm/KKHQranVNOEVjn/4ZkUqpRF/QR5OC?=
 =?us-ascii?Q?pujh5sj3N/AMcbLCs3SO9FZsdKqDCgPHHh4m3saGXdUD/Aw4oczAJ5fqUYqF?=
 =?us-ascii?Q?oqCMj1FV5/nAn4AAaCjvKuXAv13gLn1az8PIp1GlaL3rDYgu4q4c3dWzsADJ?=
 =?us-ascii?Q?BpjcNOIbmVkPKvWhhhSvQ5grEGfIdEBgAUlh8I7fmMB7ZHbxUiVW3AoWax0f?=
 =?us-ascii?Q?eUMXmpZQiRG8w5gBY0GwWHjktBQ+Pt/xbLsrPfPWtfrx6YzvnP90GIEdBTEO?=
 =?us-ascii?Q?M0SeJgxz6C85c2uwi/PJdbxgp3jpQb7GO7TM0dkMk+Ax8Xte3XbCo0bBF/7X?=
 =?us-ascii?Q?BFJmJROn9vteB9naR3e+CE7d/tvPW7awFOdkeCAM1rUiHoQW+iErcByRNbpl?=
 =?us-ascii?Q?QxXxqpM5CsN0NA1w7zD98E9nIKf0wlPal6bxrtpQvoSkA6+Uh9MfbuoxSU8L?=
 =?us-ascii?Q?97x3BLDJ814mPqIhOpF5MYTpGUPt7lvzOiapm6n/M74MxK3sBlYCNnFi6QRw?=
 =?us-ascii?Q?q78V667iyfhSjC4kSEQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf14c23-03fd-4286-f76e-08dddb39bc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 13:51:57.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DizktGy/rAUAMUUgNu0rdgXAwFMvsqj/UqG6VlT16055dwPRa8ZRxPNqn98aDaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Wednesday, August 13, 2025 10:20 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH 1/3] x86/bugs: Use early_param for spectre_v2_user
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Aug 11, 2025 at 09:26:57AM -0500, David Kaplan wrote:
> > Most of the mitigations in bugs.c use early_param to parse their comman=
d
> > line options.  Modify spectre_v2_user to use early_param for consistenc=
y.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 62 ++++++++++++++++++--------------------
> >  1 file changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index b74bf937cd9f..6bfe199b9f3e 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1829,7 +1829,7 @@ enum spectre_v2_mitigation_cmd {
> >
> >  static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
=3D
> SPECTRE_V2_CMD_AUTO;
> >
> > -enum spectre_v2_user_cmd {
> > +enum spectre_v2_user_mitigation_cmd {
> >       SPECTRE_V2_USER_CMD_NONE,
> >       SPECTRE_V2_USER_CMD_AUTO,
> >       SPECTRE_V2_USER_CMD_FORCE,
> > @@ -1839,6 +1839,9 @@ enum spectre_v2_user_cmd {
> >       SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
> >  };
> >
> > +static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd
> __ro_after_init =3D
> > +     SPECTRE_V2_USER_CMD_AUTO;
> > +
> >  static const char * const spectre_v2_user_strings[] =3D {
> >       [SPECTRE_V2_USER_NONE]                  =3D "User space: Vulnerab=
le",
> >       [SPECTRE_V2_USER_STRICT]                =3D "User space: Mitigati=
on: STIBP
> protection",
> > @@ -1847,50 +1850,45 @@ static const char * const spectre_v2_user_strin=
gs[]
> =3D {
> >       [SPECTRE_V2_USER_SECCOMP]               =3D "User space: Mitigati=
on:
> STIBP via seccomp and prctl",
> >  };
> >
> > -static const struct {
> > -     const char                      *option;
> > -     enum spectre_v2_user_cmd        cmd;
> > -     bool                            secure;
> > -} v2_user_options[] __initconst =3D {
> > -     { "auto",               SPECTRE_V2_USER_CMD_AUTO,               f=
alse },
> > -     { "off",                SPECTRE_V2_USER_CMD_NONE,               f=
alse },
> > -     { "on",                 SPECTRE_V2_USER_CMD_FORCE,              t=
rue  },
> > -     { "prctl",              SPECTRE_V2_USER_CMD_PRCTL,              f=
alse },
> > -     { "prctl,ibpb",         SPECTRE_V2_USER_CMD_PRCTL_IBPB,         f=
alse },
> > -     { "seccomp",            SPECTRE_V2_USER_CMD_SECCOMP,            f=
alse },
> > -     { "seccomp,ibpb",       SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
> false },
> > -};
> > -
> >  static void __init spec_v2_user_print_cond(const char *reason, bool se=
cure)
> >  {
> >       if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) !=3D secure)
> >               pr_info("spectre_v2_user=3D%s forced on command line.\n",=
 reason);
> >  }
> >
> > -static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(v=
oid)
> > +static int __init spectre_v2_parse_user_cmdline(char *str)
> >  {
> > -     char arg[20];
> > -     int ret, i;
> > +     if (!str)
> > +             return -EINVAL;
> >
> >       if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
> >               return SPECTRE_V2_USER_CMD_NONE;
> >
> > -     ret =3D cmdline_find_option(boot_command_line, "spectre_v2_user",
> > -                               arg, sizeof(arg));
> > -     if (ret < 0)
> > -             return SPECTRE_V2_USER_CMD_AUTO;
> > +     if (!strcmp(str, "auto"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_AUTO;
> > +     else if (!strcmp(str, "off"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_NONE;
> > +     else if (!strcmp(str, "on"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_FORCE;
> > +     else if (!strcmp(str, "prctl"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_PRCTL;
> > +     else if (!strcmp(str, "prctl,ibpb"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_PRCTL_IBPB;
> > +     else if (!strcmp(str, "seccomp"))
> > +             spectre_v2_user_cmd =3D SPECTRE_V2_USER_CMD_SECCOMP;
> > +     else if (!strcmp(str, "seccomp,ibpb"))
> > +             spectre_v2_user_cmd =3D
> SPECTRE_V2_USER_CMD_SECCOMP_IBPB;
> > +     else
> > +             pr_err("Ignoring unknown spectre_v2_user option (%s).", s=
tr);
>
> Should return from here? Otherwise, spec_v2_user_print_cond() will print
> the unknown option as forced:

Yes, good point.

>
>         pr_info("spectre_v2_user=3D%s forced on command line.\n", reason)=
;
>
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(v2_user_options); i++) {
> > -             if (match_option(arg, ret, v2_user_options[i].option)) {
> > -                     spec_v2_user_print_cond(v2_user_options[i].option=
,
> > -                                             v2_user_options[i].secure=
);
> > -                     return v2_user_options[i].cmd;
> > -             }
> > -     }
> > +     if (spectre_v2_user_cmd =3D=3D SPECTRE_V2_USER_CMD_FORCE)
> > +             spec_v2_user_print_cond(str, true);
> > +     else
> > +             spec_v2_user_print_cond(str, false);
>
> I don't see the need for spec_v2_user_print_cond(), should it be zapped?
>
> And then just do:
>
>         if (spectre_v2_user_cmd !=3D SPECTRE_V2_USER_CMD_FORCE)
>                 pr_info("spectre_v2_user=3D%s forced on command line.\n",=
 str);
>
> I also feel that the original print is a bit confusing (code-wise), becau=
se
> it prints "forced" when the user opts for anything other than
> "on"(CMD_FORCE). I think the intent was to inform the user that a partial=
ly
> secure option is chosen.
>

I found that function confusing as well.  None of the other bugs print a me=
ssage just because you selected some command line option.  Nor do they even=
 print a message if you force a bug on (like indirect_target_selection=3Dfo=
rce) explicitly.

The fact is that we already print the selected mitigation at the end of upd=
ate_mitigation function (like we do for all the bugs).  I'm not sure why in=
forming the user about the cmdline option they picked is of any value.

So I also would prefer to just eliminate the function entirely unless there=
 are objections.

--David Kaplan

