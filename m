Return-Path: <linux-kernel+bounces-769465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89CB26F10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B45AA6266
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7831B230BD2;
	Thu, 14 Aug 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BChA44yp"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C1731984B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196781; cv=fail; b=hjrX1GUV0adfhTf2AtX9pElgbY5XbQ8MqiGinwchHL8wnG3E+0HxiT9p41RNEzMPEu/htbhWp+UC1JK0wXdb3bcls98KmDk2MCBAF+doWJZiQvUQHH5eVcdYQKWwmmFsKpHw/yWPwrn3AUXTxAeF2AIKtpLGFCx/p0vyltbS5Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196781; c=relaxed/simple;
	bh=4JL3118Kgi1Jl+4R0TzFUnGdv7wm6+5DmOyRyeWQWLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u5xRfHpaA/yu3Mx9JLiiTTLLOm4FZT+udD5RS6WYmhGV6RVOBOB0s5YAUYXK5S0pWKfIpBZhQk4SNFd1yO9yxp2IpONwcU05iWrUjLY1jhQM5iH7tYYTlyIDtSYiCZYHU5mt3TpzeGuygWhJycnvk1FSsOwHPvumpc1j7H/ZqOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BChA44yp; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WX/95k81xgEtkLzCOBzyOIVg8+A4qpPmljNDdxdFVm7Yz2iv+9RI9UGWmv/5AkdANNsT3nfffTRG3Ek6ZkLaTWfo1cFpYC7IU80rU2vvgs96KcaqUinBxeNfsb1IxusOABU6giNhaobVwrsFMPEoNO5ccTQ9DFUYxt6xHHdry2F/13ALCH8l+aHerwgu8h3DvCSB2kLjkh8oQ9pTlPYu9bQGgi7lqWjbGAvpJCzjAuQePdvL7wGNS7lTCq+PFYSNN5OlP6FfFLG/JW/+/3yfgDaQyWFQLppmbJ3aWm5pKaMkEJ6C2VUZF/24ZkhCJmJLBpQYyCpLQFH47rmG/FnxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnMPRiCX1m2VOgTKE5N5PTR7cGZgIx7XI8guHXSKlbg=;
 b=GWZ9k+pBpROENcyLI0jsupOn1XwQKQB1p+9lParTqXTox2+EmFBvTB/G41y8B7u9+sEaj+SrDqfmVmP1h4Rv+p+vOZs6n6VJdwasbNBOgdROECCMT4KpGg4MT64t6Z5cs2E4wusnhi7UL+wTuhWqsVft9c+aMCwc12JzIt2p4ZiblbPrKQlAvArgkDgmkbiuX95AVNsomRb4dA6q/hfs2C7spbE1qvwftO7Y+BNmOekm01PwxjBcR1EJBvIgpcWLJhdQxLtZdbKx0bMdxG3yz2KgPNmdUa3vnEoM+spWvn2nSlLJl6Z6lqBiG9/08bv3eT3ZV5YO/qIgYnrWuSXiVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnMPRiCX1m2VOgTKE5N5PTR7cGZgIx7XI8guHXSKlbg=;
 b=BChA44yp7sqKma1aj3vyhmqxIdJJRgZ1P4lSTOkfn0U4mvioj60lUz5KPmo6Y4qwGgU279ARV4I3AwGyfO0tK0vPsfKsW1I+L6mYVVmLu1ToKhJnEpxntwj8np3FXCR8FAPepcKMsH9PevdM08gcrAlwuqO8ebNEYPjHrFzE3pw=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 18:39:34 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:39:34 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] x86/bugs: Use early_param for spectre_v2
Thread-Topic: [PATCH 2/3] x86/bugs: Use early_param for spectre_v2
Thread-Index: AQHcDTw2POk1cqJVAU2l53Dj4/QspbRieubw
Date: Thu, 14 Aug 2025 18:39:34 +0000
Message-ID:
 <LV3PR12MB926534BA78B6888767E446CC9435A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-3-david.kaplan@amd.com>
 <20250814165459.uhrxpcybihzddbgt@desk>
In-Reply-To: <20250814165459.uhrxpcybihzddbgt@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-14T18:38:53.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|MW4PR12MB6708:EE_
x-ms-office365-filtering-correlation-id: 5af86877-5995-4cbf-f496-08dddb61ea61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gvgoC+8h8AiOGT22gBEk254BmNeDDBI0+4mo0qHZYpipPEqImk7/gdTU86/Q?=
 =?us-ascii?Q?0P8r5vALdpchms84AIXK/AMUGhV2EegNcvVIipU3fEctn4a5OT1dzd5d/CPn?=
 =?us-ascii?Q?5DH7g/9g/+M7pHwXuoZYbcfMa9+M6KLx3HtdsfKew7/ayj3eDPaqiosGet8Z?=
 =?us-ascii?Q?d/mr1rnEoJl0V+ygna7UHExhIUs8ZLDZrpL34C+vOSIOqeqUwD8PfB/OuVyI?=
 =?us-ascii?Q?ME+ATNpSuYUIa1gEwPOGFNVeBykDHpGszNUWitdv1vet4AYIQilLhMLmrujU?=
 =?us-ascii?Q?YLDmp0cSOqnL4qQa7qCfhPtnWj5fsnHCHibaM4EMitutYOSQ8QkS1aYfp+7H?=
 =?us-ascii?Q?5pN5VqIfmQbyl3cNfanGFYggl2DdehOqPiWbxxwCcgDpVCVdpw45ff7Y1Cce?=
 =?us-ascii?Q?SlL8IAxxnp5gCmsXSYROB/u4NC7rLtJ72O4hs2+skJvgyK5lTGbmcvBIkk0t?=
 =?us-ascii?Q?Rqv5J0en9+huv6ubCvC9+GOQ9hnQo+UId0qTHvPAqyKalaHl1ve1IrNaycU5?=
 =?us-ascii?Q?u+yQAycjrjk/P88Y7LEQ9VZtk/sUP6/JlV2O/kaSMAnPP7tvXFc2J9mMSm7C?=
 =?us-ascii?Q?de5nFkbVWHc3zyacBjq7QZP7Izn8y8gvzlPhMBFOoPlXIATnE9z90V/np2MV?=
 =?us-ascii?Q?L4XMgOQHgG0TkXm74URDfBLa7+lgWLEwQNwHmoSMVBM7Pahay3szfPl38tLp?=
 =?us-ascii?Q?2AQZ3RP9ynPfCvpymM9Q57GyzDKlQVHjwN4ggPnFXkd2094NGQ/ZjeLmO8tG?=
 =?us-ascii?Q?BJ14NmVHsw/W9MoU+HiGAaNrOGLVgqV670gIS+vX1OSwa5DoEePSzeA0SLAP?=
 =?us-ascii?Q?3lDLXywTh6VidIKd0Xhgzei05EJFzQgG6xfnZBFoTqm08zVeRWEED0kToOtA?=
 =?us-ascii?Q?KzyzSPoBaYcUwmj2OaKw6laEKIBaUw6aLnhs0R1k2sv+/1IWezB4RbaxKb1f?=
 =?us-ascii?Q?GsFjqyOxE2qtM4F4ChP2NKIBk4YgPCjlS+lg5nBC210vnOchXtSPDSNULzAJ?=
 =?us-ascii?Q?zqBc5BaS4bIhJIT5RM3avVBkMuNONtOCEZxace1bzpp460dvY8vGgqF6yduR?=
 =?us-ascii?Q?P1d7iM2v4lVavoXgHtUeqb3bfZLv/54hLWtrqs0HoS7bnCaGcFYjVcjz5d6P?=
 =?us-ascii?Q?hx6SNScE4WLYhWL7uUYYqzK5cOMy2dBxSTArbl1L6wV+8xArfIGtbh7T5MZN?=
 =?us-ascii?Q?h/eMHkO5ydV2HdNdcyr5v/WcR6hFmWnCKt9RSTmyTkOeffth0lkEG9ZDQxkK?=
 =?us-ascii?Q?ofXVdSszpt961qQKDlXKXWDn2nyeS+rcwhC2Ysvxz11krw5Rugg5K/oI+MaU?=
 =?us-ascii?Q?BWw2yrXrWHY6dHki5pZKmQGXMSyIcwdStgirWlngq3VVq/RjXqckHdf3KO+w?=
 =?us-ascii?Q?0E8LJ0MsvyieYhh38ppDXCMTXgw+/K/LCKKrdcS/QNEwAWIpGrfqEsqcsuSi?=
 =?us-ascii?Q?biMIFSw0Ixm41tTE33Fb2g5A4H0BahD95Fn3RwATaWCKcbURTd4cMCqnXcJg?=
 =?us-ascii?Q?RYbrv+ZhaZFNuy8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bWPn1ORLCVj87IkFT4q5U8hrFrsjzHadtB/huvapah9GUxcxxnnHkpTKeZbR?=
 =?us-ascii?Q?uK4HsKIGF7KrYnckkbx1eaprPxTtnwif4R0l5Ty5zvFhyigq8AoKphLL5TYf?=
 =?us-ascii?Q?LHcnpaxe9pHp6iaE36CGVq4pEQTNUX3lDZs8vQLHSicGl7YGaz+XlIQaojlb?=
 =?us-ascii?Q?gTpUGw+1U/xeM7ujfeQlAuiyCVe/nKogSMTSZul7FRaq3WAezaYBetcT+kYk?=
 =?us-ascii?Q?OZ9jYbLM+bWDd2HbB1cFRgGU1lpt6f7YqDObBseWpaNE5KncC2gYjsKrZ21j?=
 =?us-ascii?Q?3D53qV7K8O1E9OE9VOtfI2w2AHAI0rrW+sv/eJo114B2RSYOQqCpbHpCFQ91?=
 =?us-ascii?Q?sMi5UnwuexZ6zKVysdaBesa1ylZ+36ix/uxtCGMROO5KTBBTXAgHjLTazAdX?=
 =?us-ascii?Q?ogHAYoslZtz/+GmVI4tkyX4Nk3TFql3IGQ2fYe1/iFOaaR6USsEqnREahbIX?=
 =?us-ascii?Q?O1kKTbfvCEVIBI23CFTzQZjEpNq7rVQcxWTclF5l/okm+lts+PjKlAiALdOp?=
 =?us-ascii?Q?P7hmwLlAmP4Ag1nCO7cCDzdCIt3YGecioJ75IlHJodGSGM4pVaeJKyAM3YYV?=
 =?us-ascii?Q?4H5unZjf1RtZWDAInYjSjagit8N11yhFhKyYSH6CO4w6vHc0CSPuMpvAkh1s?=
 =?us-ascii?Q?DpGm8Pgf7wbCDJsowpnmfcRljllz9Ny6alcUpS+tYn0NWXtDAFVg5uMYSlTd?=
 =?us-ascii?Q?D4+j24WtYOM+QDhPXNgK8M6JmQGS2DESSYHBCGuI4sHIhF8/n+AXYvD0Z9VL?=
 =?us-ascii?Q?Q1jqEZLazcWTH/LCloIxApKQLFaoLqqyip4vPWD/M9I+14ucHtLPWtQGyHmm?=
 =?us-ascii?Q?N/Bv+hiZGb/z7XBlNuzVOovRrRwzX+fOvq67qGbXebOIBpR11EPbATlkLTD1?=
 =?us-ascii?Q?CcTeP6fAybtCslm3vjpZXlSP0caO066Hx3qmwPznMT5QgzFi4Iuu0ZDymKxZ?=
 =?us-ascii?Q?pcZlTUwc8wEUvciZubd8UEh08LFaNY2657uvFpyWFCkqMjB4Qc1hD8AtyvdB?=
 =?us-ascii?Q?rMw5/muKQsJBkZhALQ61VILiY/fx7Rj1EBF0Nq2Gp8baryZIBKxz+r1db33f?=
 =?us-ascii?Q?aDpB3CCV/0jjy9QSHLCdtcuCQTj0zHtZ6nEVRN93pVXdnyXFo/RY3I9koNLa?=
 =?us-ascii?Q?HGsRBolhIcNpLEqgBZAb4FtkxiLHpi8/aNlG4pZSvITlMCYZlGzlZIUtdTyO?=
 =?us-ascii?Q?ksSnHIjF3RZ780d412pR6lgCJRNrNc1xIJH3zgFSkcJHJupm/IubEyvoSdbt?=
 =?us-ascii?Q?qVOE2m4czlsChMzriFTG9CWafvFY4sy8BNN3i4GqGV3bt40+MqcZuazJVv6Z?=
 =?us-ascii?Q?/GLlywYyOcE/xEtSs32RAd+tp/WDIDsREVysLdSXdvlMN83BnIOYeLPT6dVX?=
 =?us-ascii?Q?/CVioc+oRZGrz0TYWcs2Z+ySMYI2bebtGd01j6Y7OOW98yZwWtzsUGSp86om?=
 =?us-ascii?Q?knKHzyrNJLoIHUUICo3yQdp4VopeGXg9LCML5LJSJCTkwEb0HgtgHegT3usx?=
 =?us-ascii?Q?rw4yoNkYb1j/G3kZYUWZrHD+b/WO4BgHpHiZGMEdDkG5yoDswpYaiArnB447?=
 =?us-ascii?Q?mfsgtd7TgJcfdLtukGE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af86877-5995-4cbf-f496-08dddb61ea61
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 18:39:34.6988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DknSZ6tK3wI/JhmhPBDeoqLIU+9UXtyhjOwPIPHWVzYI11uLJRxb64/0VyhTbQ5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Thursday, August 14, 2025 11:55 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH 2/3] x86/bugs: Use early_param for spectre_v2
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Aug 11, 2025 at 09:26:58AM -0500, David Kaplan wrote:
> > Most of the mitigations in bugs.c use early_param for command line pars=
ing.
> > Rework the spectre_v2 and nospectre_v2 command line options to be
> > consistent with the others.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/cpu/bugs.c | 151 +++++++++++++++++++------------------
> >  1 file changed, 78 insertions(+), 73 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index 6bfe199b9f3e..19a3891953c3 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -1827,7 +1827,8 @@ enum spectre_v2_mitigation_cmd {
> >       SPECTRE_V2_CMD_IBRS,
> >  };
> >
> > -static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
=3D
> SPECTRE_V2_CMD_AUTO;
> > +static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
=3D
> > +     IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
> SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
> >
> >  enum spectre_v2_user_mitigation_cmd {
> >       SPECTRE_V2_USER_CMD_NONE,
> > @@ -2035,112 +2036,118 @@ static const char * const spectre_v2_strings[=
] =3D {
> >       [SPECTRE_V2_IBRS]                       =3D "Mitigation: IBRS",
> >  };
> >
> > -static const struct {
> > -     const char *option;
> > -     enum spectre_v2_mitigation_cmd cmd;
> > -     bool secure;
> > -} mitigation_options[] __initconst =3D {
> > -     { "off",                SPECTRE_V2_CMD_NONE,              false }=
,
> > -     { "on",                 SPECTRE_V2_CMD_FORCE,             true  }=
,
> > -     { "retpoline",          SPECTRE_V2_CMD_RETPOLINE,         false }=
,
> > -     { "retpoline,amd",      SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false }=
,
> > -     { "retpoline,lfence",   SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false }=
,
> > -     { "retpoline,generic",  SPECTRE_V2_CMD_RETPOLINE_GENERIC, false }=
,
> > -     { "eibrs",              SPECTRE_V2_CMD_EIBRS,             false }=
,
> > -     { "eibrs,lfence",       SPECTRE_V2_CMD_EIBRS_LFENCE,      false }=
,
> > -     { "eibrs,retpoline",    SPECTRE_V2_CMD_EIBRS_RETPOLINE,   false }=
,
> > -     { "auto",               SPECTRE_V2_CMD_AUTO,              false }=
,
> > -     { "ibrs",               SPECTRE_V2_CMD_IBRS,              false }=
,
> > -};
> > -
> >  static void __init spec_v2_print_cond(const char *reason, bool secure)
> >  {
> >       if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) !=3D secure)
> >               pr_info("%s selected on command line.\n", reason);
> >  }
> >
> > -static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(=
void)
> > -{
> > -     enum spectre_v2_mitigation_cmd cmd;
> > -     char arg[20];
> > -     int ret, i;
> > +static bool nospectre_v2 __ro_after_init;
> >
> > -     cmd =3D IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
> SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
> > -     if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
> > -             return SPECTRE_V2_CMD_NONE;
> > +static int __init nospectre_v2_parse_cmdline(char *str)
> > +{
> > +     nospectre_v2 =3D true;
> > +     spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
> > +     return 0;
> > +}
> > +early_param("nospectre_v2", nospectre_v2_parse_cmdline);
> >
> > -     ret =3D cmdline_find_option(boot_command_line, "spectre_v2", arg,=
 sizeof(arg));
> > -     if (ret < 0)
> > -             return cmd;
> > +static int __init spectre_v2_parse_cmdline(char *str)
> > +{
> > +     if (!str)
> > +             return -EINVAL;
> >
> > -     for (i =3D 0; i < ARRAY_SIZE(mitigation_options); i++) {
> > -             if (!match_option(arg, ret, mitigation_options[i].option)=
)
> > -                     continue;
> > -             cmd =3D mitigation_options[i].cmd;
> > -             break;
> > -     }
> > +     if (nospectre_v2)
> > +             return 0;
> >
> > -     if (i >=3D ARRAY_SIZE(mitigation_options)) {
> > -             pr_err("unknown option (%s). Switching to default mode\n"=
, arg);
> > -             return cmd;
> > -     }
> > +     if (!strcmp(str, "off"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_NONE;
> > +     else if (!strcmp(str, "on"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_FORCE;
> > +     else if (!strcmp(str, "retpoline"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE;
> > +     else if (!strcmp(str, "retpoline,amd") ||
> > +              !strcmp(str, "retpoline,lfence"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_LFENCE;
> > +     else if (!strcmp(str, "retpoline,generic"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_RETPOLINE_GENERIC;
> > +     else if (!strcmp(str, "eibrs"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS;
> > +     else if (!strcmp(str, "eibrs,lfence"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_LFENCE;
> > +     else if (!strcmp(str, "eibrs,retpoline"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_EIBRS_RETPOLINE;
> > +     else if (!strcmp(str, "auto"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
> > +     else if (!strcmp(str, "ibrs"))
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_IBRS;
> > +     else
> > +             pr_err("Ignoring unknown spectre_v2 option (%s).", str);
>
> All of the below should go in spectre_v2_select_mitigation() after all
> features are detected because ...
>
> > -     if ((cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> > +     if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> >           !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
> >               pr_err("%s selected but not compiled in. Switching to AUT=
O select\n",
> > -                    mitigation_options[i].option);
> > -             return SPECTRE_V2_CMD_AUTO;
> > +                     str);
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
> >       }
> >
> > -     if ((cmd =3D=3D SPECTRE_V2_CMD_EIBRS ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> > +     if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> >           !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
>
> ... X86_FEATURE_IBRS_ENHANCED is not enumerated yet in early_param
> processing.

Ah, thanks for catching that.

>
> >               pr_err("%s selected but CPU doesn't have Enhanced or Auto=
matic IBRS.
> Switching to AUTO select\n",
> > -                    mitigation_options[i].option);
> > -             return SPECTRE_V2_CMD_AUTO;
> > +                    str);
> > +             spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
> >       }
> >
> > -     if ((cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> > -          cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE) &&
> > +     if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> > +          spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE) &&
> >           !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {
>
> and this. So in essence, spectre_v2_parse_cmdline() should only record wh=
at
> user wanted.

Yeah makes sense, I'll work on fixing that.

--David Kaplan

