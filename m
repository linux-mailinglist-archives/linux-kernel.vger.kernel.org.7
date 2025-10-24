Return-Path: <linux-kernel+bounces-868940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC5C068CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7633A9E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF22E06ED;
	Fri, 24 Oct 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xjEz7Jsd"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943F2E1C4E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313306; cv=fail; b=C6NBcXRhbCj0rSqhxXfxWQ9S2h4lGARyV/r/Npo8gIrhyp5nWYdrGEUgW3yzS1oQkRhxwUR5LC5tfM5B1p8cTnSUPAXsWoe8vsI5XfcemG5p/Ys7n2RF0iA/+sbI0OrRvapBm1ILefjHweBwZnpID1ybSZZZSLYYEhvNLaAkdfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313306; c=relaxed/simple;
	bh=Krub+haB3CrSG0J207VzAShRKHxlwjOwHP6Of9WVBg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cE5lj8tiMifvDpkA3U5tZoR3Ury7v2l5patI16pRhtohiNKbxuTymnehn0RiHMYu1hgwZm6eNsHU6FxOH5sXzwwXBU9EKx4h7poBpOQXw0nX0LdZ9RNINAX/S5mUYzoezghD6RWucKKsIgb9tcM9SKlU7IIqhFKW8yicZFWlINI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xjEz7Jsd; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz5fuF343YfWsD1cX/Qf6pT8qnUgJaiUR+agf8a8j/w/UQvSbpqptAJYd7eR6tvoKTjCi75TZEiVHJT9kQFPp4AZXmmNpqz5QxLNQgtmFy9uFwa8HaEBb6rXuiHCXPwxchuWcQZZhEzb5rAfgz8oZE3zGCoCXaUYGnSv+BjMBM3W/463J5tLc9VY5yWU/5pDXuV7H9trS+6VYKbSl+cnOhi4g2X3L+DOiDytmAVA/i8aZ40U5WffLxSfXyIJb9D98y/x9akOq5JLAVLoNVoEn52ULTC8ue44fGoZxSDAPbJ/lMkVKZIY6U1fxyaEBxKIFiNvAPjeshsR3z1dc3qVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9b5TpQcwNCGZy1roaH/+9TtXYmPlImssAxiJpGyK5Y=;
 b=dn7qOCNyPlOsXm/985LCHBG75Cq4kDluttciPTmQb+FnDaRZS19g1cdv8k5GonJiVjO9stGKjlzjO3pTAt1Xck4CnNHogA1ZMd+6L+04IzlR1hdKArmnEP35UhOgqnyww25PWdYMH2N5dJVnZ40s0q3g3Td0Z/kXxSA8V3YiZuUsdri8NYOYo5p+1/YWQ2l9ubippZk1EAPpbZvCKLoSuC2iSz7h/bjc5u8jpsNRoSXRx++QUWmfTfohYpFy9lbY7FRbB/pcPnw1vvWDuNMihgovbMXSLWFc+IAySI483x754I8jLsYoxl/ahUGPCVx1t9pXHEQJoGtdYA0Dl3Wy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9b5TpQcwNCGZy1roaH/+9TtXYmPlImssAxiJpGyK5Y=;
 b=xjEz7Jsdtyz0cWfx6d2eP/O3RaPaNunF3/ADiXBhxc0fM71f0JVr1SPTjlcApCKqlWyl3yaABJQJNHy2SquXicfQeen3XdCw0iLjpltUoFcs8eUX5mV42yLFY/eV98jzP9dg/fKlaCiZO26wYjI56XsoPmPF0MX0l+fbtINLubI=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:41:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:41:40 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index: AQHcRKMvb7qd0BZyXkK7jo/Wse1167TRTE6Q
Date: Fri, 24 Oct 2025 13:41:40 +0000
Message-ID:
 <LV3PR12MB9265BDF285491D93196A17D094F1A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251024050058.stc2nthc2bklhyqv@desk>
In-Reply-To: <20251024050058.stc2nthc2bklhyqv@desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-24T13:33:32.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM4PR12MB8572:EE_
x-ms-office365-filtering-correlation-id: 954e40ff-513e-44af-8f8c-08de13030fc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/Bbzk2e6gz4vcEA+5JWgMws54QlAhRlHUxeiRzd9B73q6ryh9Wl7ZBu8iiWp?=
 =?us-ascii?Q?D6L4SkKAILmUdTMjBsv+JDb/NksSmoVk7YVu+JMLWeHLKeUwZ/w8IC1YjfF4?=
 =?us-ascii?Q?OHio7WhAmdXdOQF5UQ0GNVvVnvSqBoC71ly+C5nui8UHQ+0BWnqNSO3FUBHh?=
 =?us-ascii?Q?duTtMP7Bgd22XvrNmszwDEwx/VKLchiT1cI+9qcxtb3oXh6CqlztLNCMDDRr?=
 =?us-ascii?Q?spXfm5a4sqyj3+eTCfxDAeN4RcbmVzGYIq9YzVfapDP34HKj3gH7BGQdg7aA?=
 =?us-ascii?Q?jMSwAj4z+3lCp6N/MWRLs3+dRc0A7cy5qSg750OG/ru8+hO4jw3KISB5Gutk?=
 =?us-ascii?Q?9WVPHebWrlpaKR5O2bmkNnRa1Z+SK8c+1Hw8h8V9+m8SUjsj0LXHJ1ZK1et5?=
 =?us-ascii?Q?VtZtieRUS3FkSS4sOfGnXgGDK2oRgFm/VHEIiRhTjc2Ui1i87EfDWJxU2yk9?=
 =?us-ascii?Q?zlEoRiznFYBvN4oY34oxNNMzkPwG85nrGnRZyCO+XeXSfYSA3DRxx1ybgfom?=
 =?us-ascii?Q?qk/ndXw8psCd4OpczqKdY8Nx3bL9ECqUK7kLyhH9SEaH3xPLIvVVDgSFszCI?=
 =?us-ascii?Q?V7rsRZ7uNdWsSqRdSnERJSL1B9GQhTHkdE5AxFJ64zzLuIcgEgCvUkr1Mbjg?=
 =?us-ascii?Q?YMWTaHIAFw6a9CU7wnQgLiIb+kNhH/61EI/Z/pL5eqsF5r6ddJ4lV4tMbljw?=
 =?us-ascii?Q?e2OEJDGd8CBj30Ho3wJ/L5C8vrqqjLrH467TPjjbZBIzZjCqtYHMoLJbz2xY?=
 =?us-ascii?Q?pVKcVsFdHP7NjacpljKECfp3b1VEXZY22LK64KHDDZmOAzcD+iwJnKEanEyi?=
 =?us-ascii?Q?Mbvtu/o/6Fuvb2SlYHsCunI1zVQIpLXVp/BOike6SXQkVNmY3l1eWrVIzK8T?=
 =?us-ascii?Q?2GZqKSOAJOcwuGklmyx4xyhZt+e5BlzrPwoekCm8kMMg9pHgCIThw5ypQT4e?=
 =?us-ascii?Q?naecU+sGexm+mZo7VABV30hLrWM0wtxcbpvmOQ3SbVgh7+91vgPYR3CGHKvr?=
 =?us-ascii?Q?lbEyMUaYkoIIJwobA4Dv1NxVgCP3me9p0TKs/5bthdu269tII7RdEusMpLZp?=
 =?us-ascii?Q?f/FsxK46RMrixp3qLi0tzHN9DF0YSggkSZybe8TjHtu9uHF6nEvdLgGdow31?=
 =?us-ascii?Q?/2RvHLqVQ3wxlqP1vO3tRyq5chKC9hjGgTydP5FRQvhq3KK5/nCq+dXNpYXs?=
 =?us-ascii?Q?H8y02gktlK36MmAYCRDe1fhyQxKp8S7fdvaPbKGGUgv+arJWkcnF3MPKTQRS?=
 =?us-ascii?Q?RInZPo5gDwaHwEDArYkn0W7JIKmO2OPEQzfxS5qaWl8DjRfkPBu4ea34umBq?=
 =?us-ascii?Q?dKyDN/NnypiHtV+ajWDmhHIyT3wj/q5/B7L2dt8yAJCgCZiocSMnrYFeoVH2?=
 =?us-ascii?Q?c+19/enomukJ4srtazC3jwOM9Umj6zIfBHe5KW7Ad4vktGgshWou5Lll1QBU?=
 =?us-ascii?Q?IXJf98TOyIaxKybAN4c02aCpIEpZIosi8sFhbFDy0spcdbCjMg0z4pwOEBnm?=
 =?us-ascii?Q?4+mMECtqtGK1HPPyDKcLvjHN+8ovxGGTl1j/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MQFGk6JM9cqSaxGubp+LiqypMbxY3r3mrnN3fBSiJmb1SO0t31dkAtWt5CUC?=
 =?us-ascii?Q?oWOzsnH4PSq5GwPXF7Ob4IUXZSkcWzqi4MJvGGUT5GoMk1AIilVZUEXfTFmg?=
 =?us-ascii?Q?MUJufrbtbFtQGg3CmPG8XRIs9sr459Y7QPmC7d4EJdpT1U/dQ91PypeJYkCc?=
 =?us-ascii?Q?j808rD2fT1WWFakfYItU7rzWmxplo+GtzKL+NhGOpamrjzd8W9+dHr80U7Q8?=
 =?us-ascii?Q?wtdlfik0oSQmMnFwD2m6Eh5aYh1spnDEVwH/sw1AUnlsM5G0PwlbuN7VjyNV?=
 =?us-ascii?Q?6RSnOV42T2WHG7+iZjJTV+ueLiRPBnZvFTGzgsFb6w3P8xlAe6HUmOiE2DDP?=
 =?us-ascii?Q?4khybtjup/f/al3KgJ6rNKhvF3AlXQZwTBeMUi8DHw4PwEt5u3olG0TJQIK7?=
 =?us-ascii?Q?Cei/d6WMw/O6l6CHKO3xQOq031AsfzpHQb2cUpaHhiDKvZwTGzAOCaokzWWs?=
 =?us-ascii?Q?Lg/NxKw1YOGRtMr/uhdGEsYBezut1o5WC6uiAl8OtiZG3oELHbetofguK3r6?=
 =?us-ascii?Q?JyxIAMkQpL30HXOAnQPF6MiVFFZ2f13PirniNm1QHtJAZrapjXU5stE+7axC?=
 =?us-ascii?Q?37SDeyAs9SRLcIY6v2n/7IuSw4aupH2/nSHwNRRwjMJju/JrjbdoDteqlFlv?=
 =?us-ascii?Q?ZWFJIvmkMogfvkDJaVHMtL83YHIpD2/avlhSdTXzxQThz9j9O7iRE7FDFeIy?=
 =?us-ascii?Q?FicBFY7TsF5OsmGIGQgIH1P7scd7HZtmqMHUFk5pfdCt+qUB673jv5HQfKXk?=
 =?us-ascii?Q?057L8OARNFDNvOMh0rnOxJBCNY6jzGyCpUheWpZX73Cajmr67bSvyE/OXfnv?=
 =?us-ascii?Q?riyCNImxQg/M+2gA7C4VPlWp2cREqbwWBslbU7XUVDLB72DQOlvMc28R0XKv?=
 =?us-ascii?Q?FUF8qTp3mRJ/K1h+ImZ/FHTKkPoMYQH5eUL9sRVEjjW3Rtbn4SkO9dM2Nn2s?=
 =?us-ascii?Q?AYQeHGkzaQ6H3V4Aef06ihUNzuAmW085zu9HGM65mV3tkRDF8dr1qImT3idA?=
 =?us-ascii?Q?AicmMWaAGnmvms3wSeZnR2quTlPN/uIvWdUUX90znpOeS07e6cyvBFUbrQjO?=
 =?us-ascii?Q?Vkf6ASweSIzODax1eYYSgaaVvhYZ14DoEcyPwhhI686SsLf9KAa5b4q80prR?=
 =?us-ascii?Q?nAICVtrZiB8/0GQaD7QrjvEGhvLn5AByVMMZt6lTGwGOoNw/l5Tl+/FeahFA?=
 =?us-ascii?Q?GCyKOBZ0j8jvUrKWKgqj8xjlABvbue2XhiNv3xrr48OWUCU/hAPnHxj2BWLD?=
 =?us-ascii?Q?CcMnFuS0PPHiRd7W5K0hrykmPsUz5sGi2VtP1M817cle/izZRTW6FEMI9xJG?=
 =?us-ascii?Q?guM5gbgheRotaAA4sJvncM93NlQBWaH4YT4ehX7DaCbiZy2PlK3J27Yy02In?=
 =?us-ascii?Q?xoBtMQJotEnJqhQcYqp+yJ3O0pM4WvJ9jCb6Ob42aBClbiN+g3rymH3IBC+Y?=
 =?us-ascii?Q?Y+F5P7llrLif4wbpc8eQjXn8QBTQA3pN1BanqNGcMu21sADhadLIjsL1fZO1?=
 =?us-ascii?Q?R+yZvHlec9W76TL/swHlhQoR1jlFP5W7sH60p6bDd/NoidjZdXT0X1WfumUp?=
 =?us-ascii?Q?VKzTCEKHCMF25p9tw74=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e40ff-513e-44af-8f8c-08de13030fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 13:41:40.3075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCh4VT10WZ6JrmQfuunO9nzIGjcFopgWZXNkpWWk7z3yjT1ua5YmPHEA/9bknicM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Sent: Friday, October 24, 2025 12:01 AM
> To: Kaplan, David <David.Kaplan@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>;=
 Peter
> Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; In=
go
> Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; Alexander Graf
> <graf@amazon.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
>
> Although it adds some complexity, this adds a very useful feature. Thanks
> for doing this series.
>
> Just curious, for patching indirect branches, was replacing alternatives
> with static_calls considered? I haven't looked at the feasibility, but
> static_calls seems to be more suited for post-boot patching.

Something like that may be doable for indirect branches, but I think I dism=
issed that general direction because I didn't see how it could work for alt=
ernatives in general.  Runtime patching is quite complex, especially with t=
he instruction emulation that happens within the int3 handler.  While that =
can work for branches, I didn't think that could work as a general solution=
.  Given how rare mitigation re-patching was expected to be, making everyth=
ing quiesce seemed safer and significantly less complex.

>
> Thinking out loud, patching in something similar to suspend-to-RAM flow m=
ay
> reduce some corner cases. Barring the BSP, the APs gets reinitialized in
> that case.

Right now, the BSP handles most of the patching.  The AP's spin during the =
patching and then when it's complete, they update their local MSR values fo=
r the speculation related MSRs (similar to on AP startup I think).  But tha=
t should be all they need to do I think.

Thanks
--David Kaplan

