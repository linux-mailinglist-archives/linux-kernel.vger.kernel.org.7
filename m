Return-Path: <linux-kernel+bounces-856295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25568BE3C47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F705883BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7A33A03B;
	Thu, 16 Oct 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1cBlGufx"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64112339B5A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622171; cv=fail; b=SdYSylor0X9Y3ObyMaR9GXdz5HaLp+3cj3R7VkDQdznTmkL0YTJm7GowXZpisadKCYWPZTpBJwK3dnBlxTALc4RnkKU/fvyEQwFfDXrd76nw7xOC6zGmrePo1V0IB5g9Xuv8HS35wF+Rj2Bs/qJaMpaGJKZWS2JRpItG9Tuqetc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622171; c=relaxed/simple;
	bh=AS8E/OV7q9Wm4JGm/Rg8//4ZHj3g9X/I3BG8CL3d04A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fA8fGzD2nOy1kzjvprtV4HPT9i64JEmIeFj8U+vFO6US0z93tUXdPQ1oKwwkxkkaeniXZiEdmJuVd6TIqARrQweHgSvWduLdAhceK5pw/QUgOqbDxEfL7U3Fc5dxsddo7AQfv53K+DUbpt5O/RmLPOF/Drsaf1C5cpitOXzJzMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1cBlGufx; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1+/Wc8u6fkNwsVTjq1OLiDnGv+7M8+UmHYOauGAtahm26QpVVqgQyFZkDHGjQr1umncDPbS3qjqoc0WzXoYMmRAijDeH9oVQ7Xw66AWPIDvxreg5/GWNsiPOD7L2cP9Of8AZzhBnARfFbAGkXmE8SGeTGcs2EeJiU1GGOp2rKVJkLqHnIV7bcYeopA0ys4gl8PptsZvy+fTC7ronjXwCi495w2DdC+foneF5QJfT5OT33TxCHCc+zGz4Pj7xmwgXhZQLAJVkg8ArdAuhkP+D0/a1flu2nmWOvcJHthaZ8oj7opSUYskxF5sK810uGWjb1VjfJhNWGCf84YTT6zW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhzsp90D1erkCzE3XVku8i9HsN5hCrb/yFL+5/ao328=;
 b=FDE4dOatnmDHKtcRHZ3Y1s+hgJj+cPNYjpgYFEAT3Y+TdGE4oFHOG8Q0ZrJmBrSlJIPuaov2FJntllkxJEUoEP48gQ9Gxv6D/6Hg7JuBrzlGvt9Wz9XwmrPMfN0OmxIut0xPUXMil+6U+bwMO9qHOsZXIIUB91kPz34BOaN4jVnlegnvr5c7Qn/p8KJz6kwhdnwj+weHIOWQZ5/X2QQjCpkmP9kKoStArfiqDb2LVGHtY/hVrWFVJviZ9tchh57aIGhHB2HcGFtMCBteUjUMm3ElVvTWWz48TeSVIvTlwrm6U6FNKdOXr+yLhGx9dL0uH44VuQG6VJEMElSX3K/SrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hhzsp90D1erkCzE3XVku8i9HsN5hCrb/yFL+5/ao328=;
 b=1cBlGufxZZdPR8EXydyQdyYqSt2gqWHd6+RfwF9RlyTTF5Elay0O+KY24CvzMYfGWptqjbxFIZz8P6I+Hk/5Net9FRe2GmPVJMAf6kdjIYUWi5lF6+8vdGB7i+xuoF+JrIubtPRPadjjOGphICq73ruWpR5VP5V2fIXoMCvEgi4=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:42:43 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 13:42:43 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
CC: Josh Poimboeuf <jpoimboe@kernel.org>, Aaron Rainbolt
	<arraybolt3@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov
	<bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiujianfeng <xiujianfeng@huawei.com>,
	"xiujianfeng@huaweicloud.com" <xiujianfeng@huaweicloud.com>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index:
 AQHcPYmqb7qd0BZyXkK7jo/Wse1167TDOpgwgAAfIoCAAACCsIAABNuAgAABaACAASvFAIAAPD3A
Date: Thu, 16 Oct 2025 13:42:43 +0000
Message-ID:
 <DS0PR12MB9273B5438371E67441C042AA94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
 <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <lpv2uouli7b4zi4up5434mfdjngbvwbnn72vgyz47b76h2ac7b@uqlaa6mh7dfa>
In-Reply-To: <lpv2uouli7b4zi4up5434mfdjngbvwbnn72vgyz47b76h2ac7b@uqlaa6mh7dfa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T13:35:52.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 12b1c005-50d1-4280-2a7e-08de0cb9e234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0MpcoR/7P8IB9cV/BBYtfLRkrln2sz9gPLEojAY/4Pqovbg5MKzGIWWUHl+H?=
 =?us-ascii?Q?FjxQ+ga3DjgIFfUx/pRR/kGGwsF634k5ZYuh02eKiw84XxfM2rspFfMT1tzE?=
 =?us-ascii?Q?t6497T3DtzZfUMZt3znf1qGMkx+KUs+xQZEVyd/orI7SstGNMsLlN/ziB4hB?=
 =?us-ascii?Q?79C9DmMZ+bU1lmXd6shBfZsjqdDaVxFK9qReebQBjJYrIHXfqvV2J6zI5OEe?=
 =?us-ascii?Q?Us/YXATYa2mENZ9XXCpYkLfUppJs9Htq+SqmruihgpD+rstqEuDUm9kQmO6w?=
 =?us-ascii?Q?7h6h4Y3cjHbf8T8RjQfn5OfVarPuNfEfnAqvFMGRlj9DHnbPuXsW5Yj7+TI9?=
 =?us-ascii?Q?DXXKjoxI8RRWfZIZJmQ240dgNBFdI/0iPbJnuECya5ZWdxAh21P7+CBOUd/F?=
 =?us-ascii?Q?U6rNtBS0Ir6jG1qVYdnNKbu4SYcMACkh+SztdRnprtKoQGPpuax4t54fp3jP?=
 =?us-ascii?Q?3Mesm7aBawQTPsp8LyqYgb3Ybj63QSdhwE6oh9GisLGyv94qSnKmE5bdJt2q?=
 =?us-ascii?Q?yme6BUmkG/efbVQrGpLK06JjzBMAmYIxjpl6mu27mNQPXc30hpPtYDk+I7wB?=
 =?us-ascii?Q?oG7H6sPlb80SLQAa5EhBjY4AzwBFu56y3LrRTzyGEyOrf8ZvqNNE/FqWYuqr?=
 =?us-ascii?Q?aVEh/2gnCRi9e7tucT3kJIx/sMOWoCJU+EjSOv4L9K9kzVIO8lxizAaKDV9Y?=
 =?us-ascii?Q?bqxgpCpUHv3B6B71HueDwCuFHRYqauaDRHSAP4ejlF1ojXvBNjifYbUJ42T8?=
 =?us-ascii?Q?PW52ntrEGP6Zm8HwmIU6F5JWDf+GtQyAQB59ybXJgfDSApVP7iuDYGOPDnDI?=
 =?us-ascii?Q?Pf1YAHdvaTGa+4Fuc2hr1mBvfK41DRtd7S4NPOxiJV+L3DatZMKTQozy6OHf?=
 =?us-ascii?Q?vuEU2MspZOAjluAimFr9QEWks3dckJ2ZRuzZo3TpXNGINmXtH/ETgB2TdoiT?=
 =?us-ascii?Q?swaOZ3UlKkVkB5OM+cfqATJAwObk80xW8VBNC3f60s+lGwa4IZOxeg+AQTbp?=
 =?us-ascii?Q?KZmskHS9GmLVLiUwFQFTCTSk49uA6Vzu6g3kDNx8e4AH6gdtbdW1oaCyjvKz?=
 =?us-ascii?Q?HvZPIir5ihbgtpW4wsuKd5w9RaBXIYCHa9l6JOxWuV4NThH94ivN7NPtLKEH?=
 =?us-ascii?Q?28rIxta8i6u44JJgzLoy2QqEUL0cTCKXqyA/8h1i5saUO1Aa4b5XxbQrYfpX?=
 =?us-ascii?Q?z9L+QQLIadnphXqUyrqrD0napJ1OMePEP3ZXOA/enSWjxRIER7jDGG2CGOM8?=
 =?us-ascii?Q?iiRsM0Q45XO9kKkHSaCavn2mCWlHKpetfPbB/mo6uuiWWJSkIAd4v3QSyIJ9?=
 =?us-ascii?Q?MyFOH2s67s6vCgmm7fxqC3DIvQ+hHrHqOYQaALQ6j/7iAm2Kl15scTU4Mx/O?=
 =?us-ascii?Q?d0rIrBxJ93/R/G0PgfnCoA/akkxFG8Y6klJtvnPUD1ii+IazJiCDmpGB8QVy?=
 =?us-ascii?Q?9GAWGs34h1aj17ir4+TXxJW34Ao1qiXoyW6T9iHzAxbOojQ4fzjN8cbduMTQ?=
 =?us-ascii?Q?zCAZbMssOb0zUYn7U39Ds86MA+5kjNWI6kv/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KC4YJNT/YIWjlGEcSNQNM9Jfqkm4SiaM/+ZAaSWPG/x2mEym73JxmKC3n1xz?=
 =?us-ascii?Q?URHwz3P7E9b+eM23BcKuWKpM4hETDjJcTGWJu1Xi17SDffEM7JTRw0/TkQO2?=
 =?us-ascii?Q?NOFM9v/DQ6+eSsyu4RRykJfKAlOHK5pO3NrJjgImYfJUTaMSnzMugMrKKpev?=
 =?us-ascii?Q?9+OnJYqfvMClU43PGV+zB2F/SHAGU+tLKeniyNJ2TodsCnxI7S5P7J0LRqZL?=
 =?us-ascii?Q?vOPuSIKxd5bG0G7TU1AbFpxIdRTGNmp7s9ZJqcXaBPs4DTdr2bGDnTFSOybY?=
 =?us-ascii?Q?vBMMYLjbguV3Bsvf6QEHL/z/nZMiaLTKBYfRu2YJD5vrMVkpNLCxvhPTnKWQ?=
 =?us-ascii?Q?5IHFGC05axW1XirENjbQAJpR8GMEpzS87rB+JrcEpOE8kyUWwyQXpeuIj5ff?=
 =?us-ascii?Q?3wfo+OunswUW322hG+0izBLBh9teqy3EKUUADXRNJ/oAA2DsGsDinYMAq4/3?=
 =?us-ascii?Q?TTXn5N/V0EADEU7MFdTsbBMj4rKIm3t14x/53EEteacqT2YlBw9RrDoCNVmh?=
 =?us-ascii?Q?Oq6O/g5xzC7M791y7CSeO3JcifJQKaUo1nVngurhmUxY+BamG2Il83NpBO/G?=
 =?us-ascii?Q?OBbvMGxtcwarYWQmtuta7FMfpZEXTyIOl6LTfO/9G3ebLO2b0tGAPpfY5VkC?=
 =?us-ascii?Q?ZjVFikjBC6q51akai/P6b+TJDmyg3KZ30PoA9oBRp35dBhI4P6uv3IUjXaxd?=
 =?us-ascii?Q?qKur3r61b6Zc6Dte/r+1y6plQELNBf7G+MQR3PDY5swg6YxCXX1r4eghCOXC?=
 =?us-ascii?Q?LQ9k4percXHYbsHDuS2PxkGyt9dMf8n6pW6CGapf1FUsYWj3940oGs+ZXLJn?=
 =?us-ascii?Q?z94zPqi0poOZt0jRlknK4b6WMw5YQId5ucBbQ2C8JDUiREafvuYQb8z96ZH+?=
 =?us-ascii?Q?sxSRvHPcrjDOWvI8Ug5wP4katVcMXopulDRdce+vbN2LJGuyy2aQ/FmR+CGh?=
 =?us-ascii?Q?/tPOsjkLVGVw2aqKPdV435+rGOuZOPKVrLwv9mt00Px7zeCqc46nK794mY3y?=
 =?us-ascii?Q?Gl3P0RBWj6WUPW+k2xb5hJgi8fJt5CdpKLI2CjKAH5BbXUoRY6HmIkSjeXsX?=
 =?us-ascii?Q?tB7pkOLccaQaU+henz/PTBFRXragMSRl5mNGu9OBnqf3c55oiCTVBGGfeiFj?=
 =?us-ascii?Q?ePSKNQckHvyk/y3u0XJXprYSd2MnpBXVVaZqREPDlWVhA5tE2k0ltFHcTeDd?=
 =?us-ascii?Q?aglzBtFxWDjpB/tTxZNpj4vIeCHZmhpv+R9e6dwPM+333wIz71K9sP6lWBOp?=
 =?us-ascii?Q?BltVJBAYUgDlLqAauOZFzRBwSi6Rw7f/5NEvhQWpUNzWIzCfr416v2J+74Xp?=
 =?us-ascii?Q?3NIBhaNPN4z2v4aefgAA/YfM70fkd6v8WgUzURzDMu54tG006GwJT7D+xhzN?=
 =?us-ascii?Q?VhzWDiRzO/quhcU46RDon3K9z7NLN10HCHbWXSZFNgQDRlFLTPX2d2cWbYqC?=
 =?us-ascii?Q?DE2eJCSqfqnPYdBDf63uddDxoHY4qpchZY38Ba++wN8Hn7MIt9/ji4IouVai?=
 =?us-ascii?Q?Il4fesE/MOFIiCEejuaTtWwmZG582VLAbfVuCc/Gq6hXg6hRZmtP7zEe0yPp?=
 =?us-ascii?Q?uBsKACY1fh05PGvlMK4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b1c005-50d1-4280-2a7e-08de0cb9e234
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 13:42:43.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8XQSZ84De/WopNkwwT3HiQkin8n1GSbJaJkaC4z97zv2H1MuPEch4manWUjcF9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> Sent: Thursday, October 16, 2025 5:00 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Aaron Rainbolt
> <arraybolt3@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Borislav Pe=
tkov
> <bp@alien8.de>; Peter Zijlstra <peterz@infradead.org>; Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Alexander Graf <graf@amazon.com>; Boris Ostrovsky
> <boris.ostrovsky@oracle.com>; linux-kernel@vger.kernel.org; Xiujianfeng
> <xiujianfeng@huawei.com>; xiujianfeng@huaweicloud.com
> Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> Hi David,
>
> > > > > On Wed, Oct 15, 2025 at 01:53:31PM +0000, Kaplan, David wrote:
> > > > > > > If `root` is capable of setting `mitigations=3Doff` via this =
interface,
> > > > > > > doesn't that somewhat defeat the purpose of denying `/proc/kc=
ore`
> > > > > > > access in lockdown confidentiality mode? Assuming one is runn=
ing on a
> > > > > > > CPU with some form of side-channel memory read vulnerability =
(which
> they
> > > > > > > very likely are), they can turn off all mitigations, then rea=
d kernel
> > > > > > > memory via one of those exploits.
> > > > > > >
> > > > > > > There should be a one-way switch to allow denying all further=
 writes to
> > > > > > > this interface, so that once the system's mitigations are set=
 properly,
> > > > > > > any further attempts to change them until the next reboot can=
 be
> > > > > > > prevented.
> > > > > > >
> > > > > >
> > > > > > That's a good idea, there could be a separate mitigation_lock f=
ile
> > > > > > perhaps that once written to 1 denies any further changes.
> > > > >
> > > > > Wouldn't the enablement of lockdown mode effectively function as =
that
> > > > > one way switch?
> > > > >
> > > >
> > > > I'm not too familiar with lockdown mode, but that gets enabled (wit=
h
> > > > right cmdline options) during boot right?  I guess the question is
> > > > would we want to allow any window for userspace to reconfigure thin=
gs
> > > > and then lock things down, or say that if you enable lockdown then
> > > > this interface is completely disabled and you need to specify your
> > > > mitigation options on the cmdline only.
> > >
> > > Yeah, I would say the latter, otherwise it defeats the point of lockd=
own
> > > mode.  Note that lockdown mode can also be enabled at runtime.
> > >
> >
> > Ok.  So that's using the security_locked_down() API presumably.  And wh=
at
> reason would we want to check for?  Should it be LOCKDOWN_DEV_MEM (since
> we're potentially leaking arbitrary memory)?  Or a new lockdown reason?
> >
> > --David Kaplan
>
> LOCKDOWN_DEV_MEM is an integrity reason and should not be used for this
> scenario.
> I'd rather like to add a new Lockdown reason in the confidentiality set,
> maybe LOCKDOWN_CPU_MITIGATION ?
>

Ok, that makes sense.  Just to clarify, would that mean something like the =
below:

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 3f9410dee67c..9b4864f84146 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -691,6 +691,9 @@ ssize_t cpu_write_mitigation_options(struct device *dev=
,
                                struct device_attribute *attr,
                                const char *buf, size_t count)
 {
+       if (security_locked_down(LOCKDOWN_CPU_MITIGATIONS))
+               return -EPERM;
+
        /* Save and filter the provided options. */
        cpu_filter_mitigation_opts(buf);

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..81cb52cf2111 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -153,6 +153,7 @@ enum lockdown_reason {
        LOCKDOWN_TRACEFS,
        LOCKDOWN_XMON_RW,
        LOCKDOWN_XFRM_SECRET,
+       LOCKDOWN_CPU_MITIGATIONS,
        LOCKDOWN_CONFIDENTIALITY_MAX,
 };

