Return-Path: <linux-kernel+bounces-848798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB0EBCE96B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A70C1355B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94E2F25EC;
	Fri, 10 Oct 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DXrscqDn"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD0EEC0
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130842; cv=fail; b=YACxYgGsmM9RxT07AEIVc3HZzrU1DJxRDuihwn1Kof8b1lE0G/+oXGpkulRPilZGXwmbI0+uGvJVHKnWBGNYEuAC7cLwL6ZPDqQ/wU3iVnbhcYw30m6yPWrYuATrsI056WFntaE1Gs7dKhX5A5UHzlmhX5/rqMgR+HLp2NOkrRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130842; c=relaxed/simple;
	bh=+tdflgMHMoGzj8xNTfCIOI9D59fv+xOJZnxO0zTUj4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XoJ2DiyvvD7UR76I6i+gfpKWtzazFNG/KtuvC7QgP+/uLofili/7OyVwn3p1+efFRj7dU0OqykOVTS8J43A0jQWYe4oNP2x0PyY/JpKwEwbPKzmIIWZIs2LFjqpTmFE89/9hPS/eE2FQR4cTm1rpgz0On36O//tqnF3Mzld48Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DXrscqDn; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJNWg8eYbLj1IgjLbu+/t3imcwp8uTMlqV+XHGlJPoItddO2xPcoBsEcaJ+saAhehvOFXvmVxUA9Vj8FKKeRPL7+/bJUKDeQ44oZiVdwcbyfqosxeLlPMo4TL/YFcr4V9VIHgF3OArDvdd+r8COAKI0XvpRqRJhXkD0IGQ57eyb5eiGs06Wc+Yqe1GQKxBTKysTBaVeDJXXs5EQJffuBADT2dwFQWPmP6OvfbIhz/rkvqNonQi0hV0kFnuPHFMKiG84JzXtTyGM7bwM1IceN1mn4tawokbkimId+w1tdu1iaEuJEOCW6T4+UexxxoivBQU7TPF5ZedxFezZe5mCYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0xOE3RSsXMpuIQP4CFKg03DknFtRyzSdIrBCxdWHu0=;
 b=kLsCfPv3F58iYD2Vp2LnetB13mSBVZHGvF4Cq4V6nIboJV4Kq1J0i6fxCVfEs6qLpOaukvw79aSqH6qbf8jkGyipYMw9BgQ/oX//FL7RrduEVLy/oeAKbbo+2ug9Vz836laEjwPRWxoDqyyOXmF5kx61oLivttcXD3fqWLHAhYRagn0nXITdzO29YkttBeNJ/9ll4E02slWdUL5OPcel39L1xOGuyQ0gt6Fxa7n1pnBHN5GEPK+3dccHmd1gP3B/QVX4cvo3dlfPovqTpvrUYhM3P64LK07pWgSZLqiwm9U4RvDfbpiGHhXCZFwn8w8NLvXPAx9NuTet9+eUgPeOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0xOE3RSsXMpuIQP4CFKg03DknFtRyzSdIrBCxdWHu0=;
 b=DXrscqDneE6rushcorNs0KAdx55u71eTEltbpV6aNmrRUkSNbNfQunUXeWCxOcJDAcbiQt5gckmMtPd7lmDxlncb5jo8xOmF9272NYABcXOXrf0ywlsUc52HZGKemvuFG32mpyuagXUOD6ayrCnoKstXgSx0qY4xYod7HrYvwWw=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 21:13:57 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:13:57 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Topic: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Thread-Index:
 AQHcNsLPYAWj0urMzky4n4OHi8ST+rS1I8EwgAADDACAAdp8gIAAQCGAgAAPnICAABJ7gIAB630AgAFI4QCAASc+gIAACOIAgAABDICAABe3AIAAA8KA
Date: Fri, 10 Oct 2025 21:13:56 +0000
Message-ID:
 <LV3PR12MB92652219EEB4C090230E33D794EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
 <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
 <LV3PR12MB9265E186460C170527D1D6B594EFA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <4bjplxwz3ixsrdh3tvaz4danwrku26fbt5mr6yqhmzv5i34v5r@kyggtyietezp>
In-Reply-To: <4bjplxwz3ixsrdh3tvaz4danwrku26fbt5mr6yqhmzv5i34v5r@kyggtyietezp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-10T21:01:16.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM3PR12MB9288:EE_
x-ms-office365-filtering-correlation-id: bd467987-84a4-4ad9-5bdc-08de0841eceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GPt2CD6kdvJB5zLoVCnKcs7+p7iA7AmT5SmdIDLm9WIn7qGSQ84hUMlWlhNj?=
 =?us-ascii?Q?S2RH0FEeUa6rKRW+RvWNmx91ZDDQeKCEjcFiwALaJ64nGnyBnSI2U2fFOMfZ?=
 =?us-ascii?Q?Xnyt1P7nA985ORT1WDsFXBhHibq+MN0IBDOvO0aPDMokrDHky7YUvYO2eVsb?=
 =?us-ascii?Q?8RVv7n17BNAqjc0+zULxmR/0awBNqi9LlpsPuq+qxAYiXOtghPGZrDOxgEL9?=
 =?us-ascii?Q?NrAfY1Fekth0jZNYGXzqF4Wx/RX2bT6XFNMlUPETAuY3xQrQfcJrvJ7AZaOd?=
 =?us-ascii?Q?ysiw6viIgqEm2PMtiM3EqKrN+HX/v4RNrI/X3SNF2JmtoXv0gp1N2LlOT9aA?=
 =?us-ascii?Q?q34oLW6AHP7ckl1Io+RujaE2aV2p6Fh03b9Q86M9OKRHQWJJIfAOMuzCEDd8?=
 =?us-ascii?Q?SwAkH60gklHzYvDEVS2epFi8GcLJJI+33bzdyMGXO/UcuvfPMkhzZplUgtye?=
 =?us-ascii?Q?zbOhMFcpoZm7+mD3cFnb36jtk1gTJtaJKW+C/djcsktmFMJyM3Ij+8RFsYnM?=
 =?us-ascii?Q?NxZnVy+YM7sUp6FLHfOL/0vWqyNTQi7fVzg06NPJQNQSJKbwMgw3C0psxVTA?=
 =?us-ascii?Q?LV8zFQdlW6pDS94QWLV54E4VFayTmlji2sEByTB22cKxqKgxqWB0o+kgzj/A?=
 =?us-ascii?Q?AmbDo6oChLErWDlwnd+vqE7BPIlsduutqn1HS0+PEzOVfQ3fQvKpEpli3W7a?=
 =?us-ascii?Q?OXgoD3PghdFfWhB7e2CVDN5h09miGdgl/rLG+wYxf6YRisMHbMnNfPzsmfwd?=
 =?us-ascii?Q?Z7mVbEISSEijITYFLycv25mdN/toNvSscmqFiJWZFwbC6GR7e2v4M0xcR24g?=
 =?us-ascii?Q?LCroZZHz6DanSBS/of7vkBwxMy6Mu5RMRU3UY7hQ1/7EVyfYsbFpTp9a5GXh?=
 =?us-ascii?Q?XYvvoef18aEX84zhyU8DuEYrGJZjOmVWYazjhHHXZX059sR0+St6RlUzgEbm?=
 =?us-ascii?Q?hDoNUYv4NoM0fldl5ruzVOYJ+UnsMsGr7y5vX0liWFzl3kH+87d7ReTInSif?=
 =?us-ascii?Q?BoPqxVtsHx+WGvkCcjR1XzXFSIXZazdRoWnjiKBYi+LUJk+cKeVgn/Uje3kZ?=
 =?us-ascii?Q?tmZH4QmJIB6gLfCk0ZTBkE8+8G/rbkHZSAOU+VzUbrA18XvnjKI0c/o+p5qH?=
 =?us-ascii?Q?EYT60uEBGK1gjI0be/BzxJSjcaX+om1sCcIbifBhnUKKKRYrjpI9YJKa7NJA?=
 =?us-ascii?Q?Jloj7YtQsfsgeIMLgxOeVv7IlxzyMDGYmAeilP+jzBKfyfu4LSB8yyDqscGB?=
 =?us-ascii?Q?iis5mgG4Ay1V5FmadAJc7omOs4w6HLZZ3rpLcEwE9kzoKc9BiPHaFHLNCPQw?=
 =?us-ascii?Q?EcXbEE5Hs+w2NYpeSipZAjtNIqMJgKILTEO1w3gtNQOPWcQ/SnVc9FuFmAg2?=
 =?us-ascii?Q?z6dXDK6Dk7qxgRCOjpbJ8gBsCn4ZYuEZnYIiEQUS0gELC10JGtbmCZTLv7WV?=
 =?us-ascii?Q?xnOCK4/IhbrtDkM31E2mqTes5lyZfgNiFfOkEwI+eaUTK8+O7Mwv0ys8D+2e?=
 =?us-ascii?Q?1CJd6tntlr+vcg008eUEETN07t8zbwqxwkUT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vGP32zN/hWOHWamgqCSslgnIMdhJH0NC6pRLT2BeskfiGZs/SoMsm957gEk9?=
 =?us-ascii?Q?+sIYbChcyR4YLmbki0aCFcuI3+bXkHq98erlLew4Fg6gmWD97wJWMsqprlxV?=
 =?us-ascii?Q?VSmOcvt9pBPAufeb+w1eblHrdZDr2o5ERgqQxzCR4aTu5VqE7R6BQiTBFlD2?=
 =?us-ascii?Q?bto0cFQA5jghVrbCZGz3NSU7mEAg2ADDuEIIzSHbJe2TSVsje2CsGrgo9lX7?=
 =?us-ascii?Q?6cW66kPxU6zRQR3V+Ed0uWt4k2aLmW2whBnRBBxc0DDeUpX2oHj6ypzCApaz?=
 =?us-ascii?Q?SRO8Iaq7pI1AU8OSB8XD4Q7CbVSf9ns6XEqZ5WjZN1OMHziNHbPqvI8Lk5dx?=
 =?us-ascii?Q?QP0gg0f1iDGJFLjRnRN7jd88r5xMhOdSbfOh51zoIxJV/LJakFIJuG7AFQOM?=
 =?us-ascii?Q?MD6WdtDzGlZpOQ3dcsBRdzhGT1pih1cA/VtsScZwhQit13S2PkGMLxt1Onq0?=
 =?us-ascii?Q?5HfpdRVtnu5jqH43uGaLDddKKQUdY6Ey6i8/R+34XZG8VKKNMvRpBm/kntyH?=
 =?us-ascii?Q?WMBIGbDkwdABcl4mYD07JbamRcEeuw/RgVf0DDsh0TX7rbYq4eJH8n2cY5xb?=
 =?us-ascii?Q?7cnYp56crpw3f/kIMjpzAkR2IlG1J0+xYZfuN3OrElvAwQayeKPFstgSmqqI?=
 =?us-ascii?Q?L1FGoJ18Hoi53PoekhhulTJBgxyXc3T00lyWmHDa/nVsw51jTyTA1Ex1NqZi?=
 =?us-ascii?Q?l9iAGpsjXI49dNE7crURsnditeH5iItDsmMcwWgx421yNkvDmDCBlflToMoQ?=
 =?us-ascii?Q?es1Z84TTj7jWG8LjXH7pWCS37NtuhyKPs34j2/ZrHkv3ooLUQpJRLB8h2Fs4?=
 =?us-ascii?Q?eq8dwNhyi6/EtWMnamBgtnMZNRB4uzMBKdbJFMePLKmdMvgUllmxh7fyDRGF?=
 =?us-ascii?Q?isXbACt9gJfYG91VzWsfTWYN85CFmxOHgrw3pgVWk+7g7DBk/FQl/FLjFx2a?=
 =?us-ascii?Q?9n7qQEG5hYsRU2YvIWl7430L2ESaqrx6DHE1vtvnAg0lRBMKlxkkRyVp1fhx?=
 =?us-ascii?Q?gkjPsw9tI0fKTnaqnU+xJwV4BKXrIpzMysunoUhowAugvYxXvVfsvXlf6J1T?=
 =?us-ascii?Q?Q02/Kg9fFk3O5/0LbqZ4SyzwiRago2lCqRrmbrlqkqHarYScasCrICecBHbQ?=
 =?us-ascii?Q?q/KLUa3KjMJECbmCwslRq46cbCRhIF6bqYFRqYSVDobriUSNpXnPMqSMpS+H?=
 =?us-ascii?Q?imf4iMN9usAAW+tyLmRMVnGoMoLTQLX3SQRTT1FxmllWn+JhMtCAOO+LzcVS?=
 =?us-ascii?Q?uy88bVFtwlNHDZDTUp8zXaeLaRWIP+1Vo64/LeYscFic8uZ0wm6bI1itL1gu?=
 =?us-ascii?Q?O6A0PVHBLMpKR25rQ7E6eY+g/ilXEp/feZ5/bX/vOMMsAq5r90eBYFWWg7FH?=
 =?us-ascii?Q?IyDwMbxLMByM0cM8bK9tbRRpo9IcEP9LMBHxBa99ilpwiiqZKo0YAr/lLLy4?=
 =?us-ascii?Q?OgQS7hFkARAzGjDv7uZtq9WU9wMqNoHxWHLJJ7OvtMNNumbwsiqfSFjXJo3N?=
 =?us-ascii?Q?PIJGTQlJv6XRjJqlghu8TblbHHsSMhGKWnWQ3jULorBTPQoxdHyJon8jGuym?=
 =?us-ascii?Q?kQ1U+2J/qNEkp2wQckA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd467987-84a4-4ad9-5bdc-08de0841eceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 21:13:56.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wG87fwXN4ecKg0qddm9bFKE6tL5C1VuY/oECZB05z4+W9xWnmEdDbl2IJXyGbwa/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Sent: Friday, October 10, 2025 3:48 PM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>; Borislav Petkov
> <bp@alien8.de>; Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra
> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> <hpa@zytor.com>; Klaus Kusche <klaus.kusche@computerix.info>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Oct 10, 2025 at 07:27:22PM +0000, Kaplan, David wrote:
> > > On Fri, Oct 10, 2025 at 11:47:25AM -0700, Pawan Gupta wrote:
> > > > > Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu
> which
> > > then
> > > > > allows the user to enable retpoline, IBRS on entry, etc, with eac=
h
> > > > > having help text describing what generations of CPUs it would be =
the
> > > > > default for, to help guide the user to choose sane defaults depen=
ding on
> > > > > their CPU:
> > > > >
> > > > >   * CONFIG_MITIGATION_SPECTRE_V2
> > > > >     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
> > > > >       select CONFIG_BUILD_INDIRECT_THUNKS
> > > > >     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
> > > > >       select CONFIG_BUILD_IBRS_ENTRY
> > > >
> > > > That would be good if a kernel is built for certain specific CPU(s)=
. This
> > > > may not be ideal for distro kernels.
> > >
> > > Why not?  A distro can just enable everything:
> > >
> > >   CONFIG_MITIGATION_SPECTRE_V2=3Dy
> > >   CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE=3Dy
> > >   CONFIG_MITIGATION_SPECTRE_V2_IBRS=3Dy
> > >
> > > and then if/when some older HW ages out of being supported by the
> > > distro, they can start disabling things.
> > >
> >
> > Is this really improving things?
> >
> > There's already a lot of CONFIG options related to mitigations that
> > make testing a pain, and this seems to just make it worse by now
> > having even more options that may or may not make sense together.
> >
> > I get the value in building a kernel with all mitigations disabled,
> > although frankly I think that only makes sense if it's substantially
> > better than just 'mitigations=3Doff'.  But is the cost of only building
> > support for IBRS and not retpoline really buying much?
>
> I think this would add several improvements.
>
> It makes it clearer *why* retpolines are enabled: to mitigate Spectre v2
> for older hardware.  (Though, frustratingly, retpolines have made a
> comeback thanks to ITS.)

I don't think you mean 'enabled' here, you mean why they're being built int=
o the kernel?  If retpolines are being enabled at runtime, that is reported=
 via sysfs.

>
> If I know I won't be running my kernel on old HW, this would make it
> easy to phase out old mitigations that are no longer needed, that
> otherwise uglify the code and might affect performance even when they're
> disabled at runtime.

To check if I'm understanding right, is the idea that if you have an ALTERN=
ATIVE that is based on some feature flag (like X86_FEATURE_CLEAR_CPU_BUF) b=
ut your kernel is built without any support for those mitigations that need=
 that then that macro would essentially get deleted at compile time so you =
don't have the extra NOPs?  That seems useful.

And if you don't need any retpoline support then you remove retpolines from=
 your compile options?

>
> That would be useful for me personally (I don't want that crap in my
> kernel if I don't need it), but also for distros which phase out support
> for older CPUs.
>
> Yes, it does add some config options, but we can counterbalance that by
> removing all the ones which set the defaults, and instead only allow
> changing defaults at the granularity of attack vectors.

I agree that would simplify things

>
> And these MITIGATION config options wouldn't need to be referenced by
> actual code.  Their purpose would be to select
> CONFIG_BUILD_INDIRECT_THUNKS and friends, as needed, which are in a
> separate namespace (naming bikeshedding welcome).  So overall I think
> there would be a lot less confusion about the purpose of each config
> option.
>
> (Yes, CONFIG_MITIGATION_* could also be used to compile out individual
> mitigations, but I'm not quite convinced that would be worth all the
> ifdeffery)
>
> That's kind of a lot, I can work up some patches to clarify what it all
> would look like.
>

Yeah sounds interesting.

Thanks
--David Kaplan

