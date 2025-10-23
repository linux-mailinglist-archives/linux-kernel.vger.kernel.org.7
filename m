Return-Path: <linux-kernel+bounces-867595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58852C03115
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0CE034E5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11B28504D;
	Thu, 23 Oct 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngI/gtc7"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3033827FB35
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245428; cv=fail; b=LLerpaZjlvRcl0eWKN7NH0ZTL4QCsr59uddZbdlRfapOG9hJWQMjlrj++gTn1GFmBACeWnDVlojSLeb4lhKiDtIrYWUfDjdg60LM4Ztofbnuauy3r4hJ7+ardr0XoRiStrNbMV2DT8ft/0WpPDDyiwavo1jBSYfyXszoJWCSrLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245428; c=relaxed/simple;
	bh=URkFzfOjD/OzITBAO1qaCFHEaBOp11+QGikI0QCaTDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDssnnCG5eTon4OG/W8tBE1qpwPn0w8qafNmkkV9uvhwbC19kUOTconZJO8K2cHV6gOE6Cqs2cBfRGkLHJXElxlW6MnccxKAhzqPQwP5UjFZkt83XfVZhwefzcNAusSbWG0kGHSncvhUleUj1RG1OBJ9oCJLywgGQ0ShnCoIU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngI/gtc7; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODZC5RXFQh9scS78BvrHJ+00bdYVX/ry3h7V74pOMJHFHGp3ASXI0n78EwkT7EE6hmzr9TeTeMQHlkDnLcYTuz/oytMus6ND5wuJc8QoCKtWBbGoOoQI0vummKnzMR8WCYZcczHM4duRSjTkPe/QXQuQ2ZB5PLdzNWnCHoQsDSPkxehBq40gEt61mbCjKXAO+8QplzyXjK4f0156Hxdn5oQwVQ3GUR1ME8FtD5TmfxYF77iUhz6W4KC4x4cMDvyOZthjfDwhQTDy9kHQagNJsRkj0TbeLlxgbbwGUmbnmESTZQ6v7aor34WrFODs2fBXMpCqlOc3n+ciIU680oWQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnQnRFHOSzZbGXFAojfSx9wzJKF40pAkdAuS1hJ8g4s=;
 b=F5W/oVD0qGGTPGrGrr1fgeKPtym54EpTHtNMy20itIlKIOd2JP2VwAMvbya3HnPQowU0Y6QJ343NL3eIsAUS6hu9cQhW6NtyXhjBupxheYg/zDlihGkcJXGoJrn6sREqf821JojCrA6gvae3uIEZm35hW5tE2eZ6K4ITp2T/zHq5lWF2UPIYTkeBYY4fqmi8+c6b30p5f66q1HoPfjoAaqbee0TXU5H5cdcVkw7FZhrYbyRmiUGcMvqBOCpu7HN23fNUUX3f97fLemYGH6QlE4OAHaLds6+HMYssDECLOZ48WarRBUCckjeH1d2W317ONpBB5b2z+pgG/44JoIlSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnQnRFHOSzZbGXFAojfSx9wzJKF40pAkdAuS1hJ8g4s=;
 b=ngI/gtc7PhHa2p4rNSnm4QV7ubx5G2wF/peBCXtUFWloci8qKKEtOLgQX6FyyNE3RCPod2MRwqQWO42GIsepppDQ6giDzFMySGJNkIMK4QiKvW6Tw55LKehT1BMZGsO2PTAQI/ZjonvJ6zqcdFaXFR/EUoY50YM5Nz+4DJniUPg=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:50:20 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:50:19 +0000
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
Thread-Index: AQHcPoiqsoexywdJOE6yXtrK5ZRlk7TE1yEAgAADZgCABkjp0IAABFeAgAT2vHA=
Date: Thu, 23 Oct 2025 18:50:18 +0000
Message-ID:
 <LV3PR12MB9265E84609B74B48DA19EAFA94F0A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
 <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
 <LV3PR12MB9265DFD04F0F17DE7AAF204994F5A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251020150133.GK3245006@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-23T18:49:41.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|PH7PR12MB7018:EE_
x-ms-office365-filtering-correlation-id: addd122f-9cdc-423f-714b-08de12650350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g2oZhNZcla0L/9vC8zLlBRP4wYSkMSwmnHTPO0IP/zqdyDvMwcpcCdfdJXvL?=
 =?us-ascii?Q?T/AJ+gGJLNLf7d/QieOhB5xKki8cft4hpl+GPPoZEkbPiKq+G5OczYmgooc0?=
 =?us-ascii?Q?AqvfuEzz20Fk8e9FDGrcpPF3wnlofyP6Wm7VdzIkFrIDuT/fRRLfa0f8Cn4Q?=
 =?us-ascii?Q?ClZIQnxWXXJ9n4XWtW8wh1ckW+0wZsGMKU9fIPAz0t/ZryuKqggwDzMlrHwA?=
 =?us-ascii?Q?oyp05tnjJJLWlDnBHDlSjDnraS7obcOnSAhZrT9n9xbQIdSBydnaVcHs9oxn?=
 =?us-ascii?Q?Tfggwfuz6xwAvy+iUXADALp9B8B+IPQ+XzR8H6RJFjlvO8c5UTn01oDBGmOP?=
 =?us-ascii?Q?NRJJYp9xFyVoJMO6v2CaHoHPJiAGwXZDE4dOk4H8iWGZ+VWi7LBp6px+3W0f?=
 =?us-ascii?Q?APD2If4CcgGsUJWOtScqlEOII+VUnAXKHocywsTSz4qMVvqyVSvr9nkEwOE1?=
 =?us-ascii?Q?QgTTt8yHhGFTDACmM+2txqg343Oe467cosK1JGOUZ4TJwhpD++C//MokrLSj?=
 =?us-ascii?Q?DUJajd6gpKjGYT/6UiBUbL0U3x2vS5lI+UiB+CBe3xOCAfTAOzn/ZQDoHW5L?=
 =?us-ascii?Q?XWhHdKGvujr+ODcSofOBlmOrlBHy51+sf4I+inx7viMMVEqN4LDNwhRUMI/d?=
 =?us-ascii?Q?rRuq/WEQqeSMDBzrzzJYN4jSYN6LCynyiqbK/vyBO7H2ULDQBUQ1iX4j455U?=
 =?us-ascii?Q?VUKzQ2LbIHBicWRtzTWY3s4zEwtOGzsPrZFgwss1Xj6lyAnbkCk+Y3WYdrL1?=
 =?us-ascii?Q?wiJdNdjUfVLEm44OvTWBFyNYfP4bV+U9UAYFSTsGi2Wu6cIZ72acWdxgEkfB?=
 =?us-ascii?Q?RQkT8E82lJYPUPwZ3HXFx8RrH3wBX5AVuPWgHx9ThW5Qo4AhyiYPMfX5SmQI?=
 =?us-ascii?Q?IdQI5o13cQJsOnTj1TSyScwYjRuH7l0Py9XL5vlnDrqg96aiNpZoQ1fW7Iqb?=
 =?us-ascii?Q?QVTikNzluffLrN6QHI2Qfxczv7pU98kCcQJB1t1vEblotJqgdIi9w4+mX0HH?=
 =?us-ascii?Q?HACORaUC89RWKDHgBi6h9glbCwKOlfmjzQd+3eYYTqDdmEbNmECr8c0P3vEL?=
 =?us-ascii?Q?jU+1/+CLpGNXWXcb94l7rgE/8xtymh/Ho91rYHZ7eEf6Kk8u5RD/2tmQu8MJ?=
 =?us-ascii?Q?t0b4KgxNZ/H8D9659+tazBBitEbomkPWqv2/D5gWPR2CwU3AgEOB6Vv9qZbJ?=
 =?us-ascii?Q?xQcY8/+Ro4savPszOqZ6D5MwgtnFTXwt+kKwu/Rb9RX0pZR2gswsKUoESkFj?=
 =?us-ascii?Q?C1ren4mO0wG+igstwzq+O7n59PHn56HTAJ/+alToLaWS6grd5LSwBtYqp2HQ?=
 =?us-ascii?Q?9vimAA2B9QLx4ZsaQPzBoVO2bVh2B1mEcgVZDFSkYnXoJr+Am4jq3dS7ETLx?=
 =?us-ascii?Q?x2g/KRhnE6Y4S3cP4oV06/EJUrJwyGL8feVApzTvGCandJ7Xw4jxxdsrSo3E?=
 =?us-ascii?Q?KAfRLCoH2b7iJ7jlr4yA2MNiMfgwuOrYrt4ZVyjqovHedS/vzD0DZXw/XKwu?=
 =?us-ascii?Q?4SWvFq3GaXPrnPtV7rYQ2CNlYXBIfIIOaNOc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B1Z7TtI54c74Ewytn4GcDuz9L9yAiTh8B/MaFQvj74LK5AQbsrcMBz4Yl5tf?=
 =?us-ascii?Q?/1Qwb6QRLC6YzNMYfP9ZI+Rth5XLe8RlDA+B3HZILoX0UqcSvPAZEHZvkGlt?=
 =?us-ascii?Q?rHIOGRRM6olKPJuXxOBAcx9BECubTikRcJ+zvlBWxHi+GB1Nqkz2FeRy5Emw?=
 =?us-ascii?Q?mzwMth6y0rFcgmo+fv64VyZb4SOZ/A24+7Fmw/5kr7Gg/N8Vs6LluQQ1nXlo?=
 =?us-ascii?Q?6aWjlhiNMuio0Mtg+x94g6rc7MYVX8CbX3SgIAd8Ej3zVMpMH0qw5bIuFVZJ?=
 =?us-ascii?Q?lcQDpukZH8H0ML4HM3mvJk9aKQkeg+KPu7Uhi8Mkh9YOyvwdRRNamSi1+j7+?=
 =?us-ascii?Q?HJhvRDX5ARHy3iJcxgxqYgVbOUlJvkBZNMNoJJSc4pviafD3p7HrVNTwaefK?=
 =?us-ascii?Q?kipZjwwBoJShV+hCfdjnbgv5uuNoY4EM4tS53RIhjT3170S0SAiFMkNIwkSs?=
 =?us-ascii?Q?D3VzHTHQuJKakuqdw523NtlmTDS7NY4/RKUp8dpqVlnOmBz+rJgDJ2czSs5L?=
 =?us-ascii?Q?qPeZWkG4pC0MCZIIdDBIwyCQgjHF9Et6E9zgKVGlTViI6C2bmHrMByv9IXpY?=
 =?us-ascii?Q?hBpoKBChyOw7q1UTcdiHQ0PCP3KDk/dhITihlvaPT+1QtU/2o1EoHO66we3p?=
 =?us-ascii?Q?j1dC+0PrOVv2ec50IXhws64DAdtPDL7+h4yvijIDARi24CAgiFkPYR9BQ2kL?=
 =?us-ascii?Q?5g4cjqJPkYuhP+JQ1+mXAMXKsKurOmTRC8WZmLFy3yUDIIm2roL3kFtnEKXb?=
 =?us-ascii?Q?vsLoRDlOJbF2NCaUkmcVwagMGZS6z/3bRaE83vbM7lPjgyWGv9zRSqBhqElZ?=
 =?us-ascii?Q?tldbu5ZUwUCGi3MQ+8m89b/ZnGPz5W/uvmuSqMQdO6DiPV8ju3s6sFahlqAL?=
 =?us-ascii?Q?z5eK/vOuFYSeW3pMkbVfK/P4108IEbX95wkLo7b21WNP09x6RpjP3g2lwCnc?=
 =?us-ascii?Q?CQ7gCpbuR2SbjtmRdo02kpcdHqIhbgzOtZGE5DcNRu8rzpLU3FOjyYqQ9HUv?=
 =?us-ascii?Q?b1roV7di2/zaNAmVBs8RSiUj8lV2mKfy22AxSgYulgZNAmS/tiGySO1eJca4?=
 =?us-ascii?Q?j09xnhhyl6zvp+x0VYkwJusbAaJZMGZhmUmFkeXvkvlrslyZV0psUjMOzWTi?=
 =?us-ascii?Q?QpxnK/JN/neHYX4+pcOzATA9tfwmmAsDAoTOTR3k0+8rOy+E35iGZR5H2Lw5?=
 =?us-ascii?Q?wR5bKHKbDO6Bij0AZfSZTikbX/rugZ4zOAiQ05WJRitym4vKVOrSlwfeUURO?=
 =?us-ascii?Q?Axw/7ntFVwVdputdGE3ObhKvAQt33hKTGteLy7ponda0X6TjJ+i1Hc7Iq2/v?=
 =?us-ascii?Q?UqCHlGHWEiBeFHyQSlodHK10T1WAMn1YAtFGCwC1qJHkwqgwTwhjN/PUQ8qq?=
 =?us-ascii?Q?0fOEu+kz72tRJYKXfAGRff2xoX8nI97wv7/ydISh+Yh0t0h4aqaDKVzEUAq7?=
 =?us-ascii?Q?smssnRFa4ycRdWAUrPvVZGbIaPF2mMv0qDqw8qrWk9ZPm83W/I+jWbhSHCRW?=
 =?us-ascii?Q?QB1wQpOpi+L6zkek29LJTBVun3f6JjQ/qqcPko3pBq6ngnLKhrS/WLYatb22?=
 =?us-ascii?Q?qx3SYEEaKTpyR2ovaVg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: addd122f-9cdc-423f-714b-08de12650350
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 18:50:18.9357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olbrCPOASUu3dk8/JJYH802BLRtiNAkPxJE+8nT/aZ1AlICOTq5YlwWLM3sMSsez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Monday, October 20, 2025 10:02 AM
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
> On Mon, Oct 20, 2025 at 02:49:56PM +0000, Kaplan, David wrote:
>
> > Coming back to this, are you thinking we should just create something
> > like 'text_poke_sync_core()' inside alternative.c and that can use:
> >    1. SERIALIZE (if available)
> >    2. MOV-CR2 (if re-patching)
> >    3. Else, IRET
> >
> > And maybe someday we put MFENCE into there too for AMD parts.
> >
> > Right now, of course this is the only logic that would care about an
> > NMI-safe sync_core().  So maybe this makes sense vs creating a generic
> > version that nobody else is using?
>
> I was thinking something fairly straight forward like the below. Yes,
> there are a few more sync_core() callers out there, git tells me:
>
> arch/x86/kernel/alternative.c:          sync_core();
> arch/x86/kernel/alternative.c:noinstr void sync_core(void)
> arch/x86/kernel/alternative.c:  sync_core();
> arch/x86/kernel/cpu/mce/core.c: sync_core();
> arch/x86/kernel/cpu/mce/core.c:         sync_core();
> arch/x86/kernel/static_call.c:  sync_core();
> drivers/misc/sgi-gru/grufault.c:                sync_core();
> drivers/misc/sgi-gru/grufault.c:                sync_core();            /=
* make sure we are
> have current data */
> drivers/misc/sgi-gru/gruhandles.c:      sync_core();
> drivers/misc/sgi-gru/gruhandles.c:      sync_core();
> drivers/misc/sgi-gru/grukservices.c:    sync_core();
>
> But none of that seems like it cares about an extra few cycles, and why
> complicate matters with another sync_core variant and all that.
>
>
> diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync=
_core.h
> index 96bda43538ee..ef4508a03800 100644
> --- a/arch/x86/include/asm/sync_core.h
> +++ b/arch/x86/include/asm/sync_core.h
> @@ -7,86 +7,7 @@
>  #include <asm/cpufeature.h>
>  #include <asm/special_insns.h>
>
> -#ifdef CONFIG_X86_32
> -static __always_inline void iret_to_self(void)
> -{
> -       asm volatile (
> -               "pushfl\n\t"
> -               "pushl %%cs\n\t"
> -               "pushl $1f\n\t"
> -               "iret\n\t"
> -               "1:"
> -               : ASM_CALL_CONSTRAINT : : "memory");
> -}
> -#else
> -static __always_inline void iret_to_self(void)
> -{
> -       unsigned int tmp;
> -
> -       asm volatile (
> -               "mov %%ss, %0\n\t"
> -               "pushq %q0\n\t"
> -               "pushq %%rsp\n\t"
> -               "addq $8, (%%rsp)\n\t"
> -               "pushfq\n\t"
> -               "mov %%cs, %0\n\t"
> -               "pushq %q0\n\t"
> -               "pushq $1f\n\t"
> -               "iretq\n\t"
> -               "1:"
> -               : "=3D&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
> -}
> -#endif /* CONFIG_X86_32 */
> -
> -/*
> - * This function forces the icache and prefetched instruction stream to
> - * catch up with reality in two very specific cases:
> - *
> - *  a) Text was modified using one virtual address and is about to be ex=
ecuted
> - *     from the same physical page at a different virtual address.
> - *
> - *  b) Text was modified on a different CPU, may subsequently be
> - *     executed on this CPU, and you want to make sure the new version
> - *     gets executed.  This generally means you're calling this in an IP=
I.
> - *
> - * If you're calling this for a different reason, you're probably doing
> - * it wrong.
> - *
> - * Like all of Linux's memory ordering operations, this is a
> - * compiler barrier as well.
> - */
> -static __always_inline void sync_core(void)
> -{
> -       /*
> -        * The SERIALIZE instruction is the most straightforward way to
> -        * do this, but it is not universally available.
> -        */
> -       if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> -               serialize();
> -               return;
> -       }
> -
> -       /*
> -        * For all other processors, there are quite a few ways to do thi=
s.
> -        * IRET-to-self is nice because it works on every CPU, at any CPL
> -        * (so it's compatible with paravirtualization), and it never exi=
ts
> -        * to a hypervisor.  The only downsides are that it's a bit slow
> -        * (it seems to be a bit more than 2x slower than the fastest
> -        * options) and that it unmasks NMIs.  The "push %cs" is needed,
> -        * because in paravirtual environments __KERNEL_CS may not be a
> -        * valid CS value when we do IRET directly.
> -        *
> -        * In case NMI unmasking or performance ever becomes a problem,
> -        * the next best option appears to be MOV-to-CR2 and an
> -        * unconditional jump.  That sequence also works on all CPUs,
> -        * but it will fault at CPL3 (i.e. Xen PV).
> -        *
> -        * CPUID is the conventional way, but it's nasty: it doesn't
> -        * exist on some 486-like CPUs, and it usually exits to a
> -        * hypervisor.
> -        */
> -       iret_to_self();
> -}
> +extern void sync_core(void);
>
>  /*
>   * Ensure that a core serializing instruction is issued before returning
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index e377b06e70e3..2a5daae3626b 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -2687,6 +2687,87 @@ void *text_poke_set(void *addr, int c, size_t len)
>         return addr;
>  }
>
> +#ifdef CONFIG_X86_32
> +static __always_inline void iret_to_self(void)
> +{
> +       asm volatile (
> +               "pushfl\n\t"
> +               "pushl %%cs\n\t"
> +               "pushl $1f\n\t"
> +               "iret\n\t"
> +               "1:"
> +               : ASM_CALL_CONSTRAINT : : "memory");
> +}
> +#else
> +static __always_inline void iret_to_self(void)
> +{
> +       unsigned int tmp;
> +
> +       asm volatile (
> +               "mov %%ss, %0\n\t"
> +               "pushq %q0\n\t"
> +               "pushq %%rsp\n\t"
> +               "addq $8, (%%rsp)\n\t"
> +               "pushfq\n\t"
> +               "mov %%cs, %0\n\t"
> +               "pushq %q0\n\t"
> +               "pushq $1f\n\t"
> +               "iretq\n\t"
> +               "1:"
> +               : "=3D&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
> +}
> +#endif /* CONFIG_X86_32 */
> +
> +/*
> + * This function forces the icache and prefetched instruction stream to
> + * catch up with reality in two very specific cases:
> + *
> + *  a) Text was modified using one virtual address and is about to be ex=
ecuted
> + *     from the same physical page at a different virtual address.
> + *
> + *  b) Text was modified on a different CPU, may subsequently be
> + *     executed on this CPU, and you want to make sure the new version
> + *     gets executed.  This generally means you're calling this in an IP=
I.
> + *
> + * If you're calling this for a different reason, you're probably doing
> + * it wrong.
> + *
> + * Like all of Linux's memory ordering operations, this is a
> + * compiler barrier as well.
> + */
> +noinstr void sync_core(void)
> +{
> +       /*
> +        * The SERIALIZE instruction is the most straightforward way to
> +        * do this, but it is not universally available.
> +        */
> +       if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> +               serialize();
> +               return;
> +       }
> +
> +       /*
> +        * For all other processors, there are quite a few ways to do thi=
s.
> +        * IRET-to-self is nice because it works on every CPU, at any CPL
> +        * (so it's compatible with paravirtualization), and it never exi=
ts
> +        * to a hypervisor.  The only downsides are that it's a bit slow
> +        * (it seems to be a bit more than 2x slower than the fastest
> +        * options) and that it unmasks NMIs.  The "push %cs" is needed,
> +        * because in paravirtual environments __KERNEL_CS may not be a
> +        * valid CS value when we do IRET directly.
> +        *
> +        * In case NMI unmasking or performance ever becomes a problem,
> +        * the next best option appears to be MOV-to-CR2 and an
> +        * unconditional jump.  That sequence also works on all CPUs,
> +        * but it will fault at CPL3 (i.e. Xen PV).
> +        *
> +        * CPUID is the conventional way, but it's nasty: it doesn't
> +        * exist on some 486-like CPUs, and it usually exits to a
> +        * hypervisor.
> +        */
> +       iret_to_self();
> +}
> +
>  static void do_sync_core(void *info)
>  {
>         sync_core();

Ah, makes sense.  Thanks for spelling it out :)

--David Kaplan

