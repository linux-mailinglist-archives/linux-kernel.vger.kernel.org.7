Return-Path: <linux-kernel+bounces-856355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61769BE3F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 552DD4EB8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648DE33EAFD;
	Thu, 16 Oct 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xPeJyTu6"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C760DCF
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625656; cv=fail; b=XFN2FKkRMbD+VZrbswhmTPX7Tndnw4wrsNoGGfnBzmHI/fhl39l4BB3Jg8/vMkbH+CjPIiu+RDCniDGlMf6/pmxjUCJFdOtznXe2vrXjhaVGhflTjRBwtO0Riv+/srdr5na6XUt5DiZFH1bq6+a31LtCoR365bF9W2MYgiLRCjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625656; c=relaxed/simple;
	bh=wfiBBoa0ex0qh5DonrZ+JwpcoNdWWG+U9uy705/tsSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPJCsY/NRwjXowt6hQJbrrahkZzLif8OM/DSHj+axZMiHRJKw09CrhpjsMghR9WEbItfNXnOJdVe5JrHrHuXoO176BvppQQKz7jo0985dNgBFb1cpS4irawOQ9jUezwk5j7ufuyeDd6aWJ9XqDxTyPltSC8Yc8+cwp9zqlu4TwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xPeJyTu6; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqbJqPPrAnXyoP+vDfVVavx321Dg+44OnH6FwgBH5dUqjKojqw9kK2zutQ1rX1qIm2kNNoQo7VqpuOhShD6awryGXz1hkBzlvZSBlhI8kBeo+GsbTkNxyhUZYK0HPGwNpU20YDYisPVyE/FU01r7pp3VMCw+srTAZdni6MUIeidzlrr/a7kXaPpoUEvX4l71NbkNenNvfAlv+AmewkIqUhYMBS7qq3EG+95gDFF1olZE52blTZ+fTsbOQdzAtDCMBJ5y59skfAn7MzHRUox1hx+6noPMWqdyEfaDFzu/h8xbbAhkaVXVunS8by0boVPz6Xd8GcaVbEMxLhHvL1nruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pw+mpV+V9cixGgkXGX1HenxHPJTbyfrbtU0nqiZ+jA=;
 b=g8MtuSd1WgwW3q79mo/40HFbM3iBxlxaU1PuFXolvjxh+PYdXb/VxGHUwsVwBDi1IXYEE6thuUYC1yHStRZY1HnQmfXFCDK3+S4tROjDgvAlXl0DHYsoFGjTFHIJYcn/615S1UMirAdbV+hfX4ElOwTkIpbp1o6ysj8NXGZpharCz2xXKrrc+UmPCFj1h+3n0ivUqEpvddtMAwC9YJUcJwkmR7LpRPL8Zzaen3F0U+zuR/EI4tULhjFzPOepQxFMXyLBnfhiu8sscxGHUnUmULfcvz5NEwLGnPIhGXLfG/nu29zJxe2CUcEfnBAr94gF8bRyxxRDvcBdobtftNTugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pw+mpV+V9cixGgkXGX1HenxHPJTbyfrbtU0nqiZ+jA=;
 b=xPeJyTu68tdZfoFzuSLtNmxcsoK3M+a/ec1deAcRvn262nfB0fsyl0lfiwA/r4tnnZ3t4ApgxcYwPV+ZQS229n//w6ElQ4IGMPzC2qSdO5VzKugH2+fskeS6hncshPmovqeho+HbLhkOdBlZybL3VrJ/UoQOkrRUwME47aoRFt8=
Received: from DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 14:40:52 +0000
Received: from DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6]) by DS0PR12MB9273.namprd12.prod.outlook.com
 ([fe80::a3be:28f9:394b:74e6%3]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 14:40:52 +0000
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
Thread-Index: AQHcPoiqsoexywdJOE6yXtrK5ZRlk7TE1yEA
Date: Thu, 16 Oct 2025 14:40:51 +0000
Message-ID:
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
In-Reply-To: <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-16T14:35:20.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB9273:EE_|SA3PR12MB8437:EE_
x-ms-office365-filtering-correlation-id: dd426a2d-3301-4cee-b7cf-08de0cc2015f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P0wy7VxQfjPRZdxVG7fY6YUkZj1keArrQTkcCKPSRgRv4ZZjBsZk3kMqc2RV?=
 =?us-ascii?Q?MbSr94Or0MoiqzP7V7AGtz9A5VOBGTvVpigEMl/ai4yTCZLiJF3e75y1nJjE?=
 =?us-ascii?Q?kMJ+3BKaFTmD75Z3G07m6fktbTBwryDlfdBd5dtyIYEoVJ26k/4UlHhA4cK1?=
 =?us-ascii?Q?eLxhp74/F3h1iurp6qRAUssdjMF0MVimMWv7bl8Gw6kvnNQg8t/+GK+Q9Ty6?=
 =?us-ascii?Q?gSy4izO4cALTq/utGZCRWS7KVfTJSNKCUbauWstn+NEUYX2AnRxDSHFWjwtI?=
 =?us-ascii?Q?R0xDsnZObDNWFh6VCXVWiwpuujOIxgY3CsGIwBqXrZJSVuZD74HSy7W9iJCc?=
 =?us-ascii?Q?tkM9z+Vnf/WYDeM2cI+ELCFkN/eK1Rt1U0y/wi3Q6GACtvO1ZLfcs/PjOgb/?=
 =?us-ascii?Q?KaQ2gzBySRf4bdZ+awAOrqbpRZdHB8p0Sq+alLLWB7elGa8TQy03vUZGtjfY?=
 =?us-ascii?Q?qp9xaDYHtKA8sHSitiNpyY0pmklYs+sbG/zCmvBo/0OiXSHKg0NDDwpsULsC?=
 =?us-ascii?Q?athA0eoCNRdrQ4rBFSc4xEwG5C3DgOdusMzCDHtyAjqgSU7Ih3Tuvh9sEw8u?=
 =?us-ascii?Q?c+/e6VruJTr0ADvQUEhJskq8eUfaf0Ig4qpAGHZpxqZC3kea3pT6DXIndpps?=
 =?us-ascii?Q?ab76w9WHqqdlaJuGpdfr8BMRyyavoA5dveF+u9FMdaGQnx3QqNdZStNO52Bm?=
 =?us-ascii?Q?olPSRniqovwe7aCDdeakMZRX3TojBROhMi4Pm7/fTCios00zDDg+leHaPtPK?=
 =?us-ascii?Q?8dVgK0ZjquRDDBih0PepeUt5igLSRJmE8EQa2fGpIDyUEJUZkNCXzorzfGfN?=
 =?us-ascii?Q?eJ52lLWWKvajwzmjmkySUm29FYtk2oiu7CZ030CFMQABTdBLUwjfbh+PM8hr?=
 =?us-ascii?Q?4TJN1/0cURsWESrHQ93ftTnvNdgOG//kv9h0KFnu/oJ2+fNveeWVzxL954GC?=
 =?us-ascii?Q?NmK4W1chOsAmsK2D/WmWaHguOjBTkL8ULopfse4DyEcIkD0HhQDESCeg6rzu?=
 =?us-ascii?Q?cI3RcsmtLWHd+Wv1gNhYQd7x8uWio3ukK9g0MqJnBTLfEZGpl1/IqIXVd539?=
 =?us-ascii?Q?3/Vt6030Qzc7Qrv66wYJSgasI/cfvkbyILFXE/Osh4YWAUOOAD5yCxkqKCj8?=
 =?us-ascii?Q?mkG7KCEqFBBKQVma1i7etoqfZeIhffNmxu6js2tHxpCfTMGchyWh0j60vkH5?=
 =?us-ascii?Q?s2qGxk5NZXmzyquYkMt21uQ5XI6IqnOMwbPCtsG6XFaTBCKq1xQ3CbdfoaHs?=
 =?us-ascii?Q?9na/nkomIF30sG6Z51G8A9bp3LLX6vBsryECec8KEd1Nq+ntH+ejyfv9Gq4x?=
 =?us-ascii?Q?/u2Nmpgh/8dgOmSNB4niBQAN6izHVhzF7rp+XFH9a4jY8jglIK5Fqh5q7ekv?=
 =?us-ascii?Q?Q04+OnfbuOzb0QTh/p6HReB6BaGFnUEWDm7EOWbaI8IMmG5oUpL13KB3HynG?=
 =?us-ascii?Q?YldzUdd7aDZaXCMV+tfTK+MZDzUL4sR7pmo/RYKBY27AJma3g4hSmsSop8yo?=
 =?us-ascii?Q?lB43EY0Yz8eY0Wq6keU3u5eMARtAwl/qHWG8?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB9273.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jBQglbMliuv9Cyk1wG84jAwiyVNv8R+VsgMqFdUDzSY7RVbmOPtrPbvBcXfy?=
 =?us-ascii?Q?c0Jom/xTfRFUqBYruE6thsEVvNrgTq9W8/6xvjfpFtngj2kqrXXA4pur7Gm2?=
 =?us-ascii?Q?Q8+3938qJKlqzOIgsTbiZJ296L+Mq6I5vBjI0t3DU4lf/XPmDXj4dYFoOc15?=
 =?us-ascii?Q?vIomRNJqBXq6DYrOlC4LqgOdfDZpNtJsu1u+hkXNtgsMD+uEMfZYg6w3maAX?=
 =?us-ascii?Q?iF/K+dEVBT3wXIYAR2eKvfIg6x2LC7TY0xbdd/1jjyBVcWTlbITgSKTyMBBh?=
 =?us-ascii?Q?h8MBaY03VStS/TsrTfZTzi/St14Q/ANEJdC7t6xQRt8Zksv60nOmVhBUyNnj?=
 =?us-ascii?Q?K9E8KI7iZ038QxYqlUsPyFxg8a9lhtHTPbhrc/31nExdcEHpz8r+7+H27r85?=
 =?us-ascii?Q?VYkFBk1A73ycAHRMYo7mkr0BIiP7huUfPoj86uUR6qDuaqVPX0IV0ceB7sPY?=
 =?us-ascii?Q?nmJLmL6PxbvgkGho37rN+Pn//LWCeV50RHH4z3bluKAWVFVkTxvw702Ft2s9?=
 =?us-ascii?Q?2rql6YzqVRAoa/ZACmVPRuWmHr6LZPgVyXkXvheUfIyMIdQhihfw8+/QnpAo?=
 =?us-ascii?Q?IFEdncgoQfwT/Q/cGOAPIYULkt/zbhEwXsfwk/cZ6SKpnTv9Q6A8k+z9flZu?=
 =?us-ascii?Q?oy51lhuiwHcI1ZTPLSvNRus9s9mRatBk0NBRBelWZpF9/FA1L8R/L8yn+xQc?=
 =?us-ascii?Q?BptcsNcSQo8cuDVGWHJdpaUUoevQ23iIHTCixHo8ECmCk6pmcmU9RJa7xXwp?=
 =?us-ascii?Q?F2t6Hew/nBoq0jC+fyIvOHLjmy9Z4RbNzPHH4/+YC4UEd0X8ZMfnmCBbn3fp?=
 =?us-ascii?Q?DcTP4jdINl+w+/sAPfiR/1WWDEZ7XR+3GMhNqiXpZjFa/JUrDn+NGlC39AQ2?=
 =?us-ascii?Q?sdYFmtHb57rozbdNCG08QsXcGIl9hFDq4KF94bh6v2tZGot5zKQbjaFNauZu?=
 =?us-ascii?Q?FP3zPBIhzszaV1LOaaCPtL/gge65ZWbF4fe951FsIFil7DttHLC01xl2SdNu?=
 =?us-ascii?Q?4paljWDyalrumVJO6HqGj57du8AxfZuQC1r7CY+Xd6Yf7mGi52zfA5dFS6e6?=
 =?us-ascii?Q?DUKZG97xpgCJcsiw4l/mYC42KkMpOA5D+DpKyY4YEYXySmq/7fsGFPKcnbIA?=
 =?us-ascii?Q?JooFANvtz3TEIPzdqVgsCQTfx5CINi/MfUU1msvlmQVoYIi1oGsKRD26bXoq?=
 =?us-ascii?Q?KyJVYp8a3godE5Gi3bcVREAWQFcyatlYhncJu2lJlN4ygd+bnrXpVFxC+ESd?=
 =?us-ascii?Q?8BwG/1aysBEhugGP7fAk3QSPsxCSLhOiiWeyFDkfGsn3jX2JgIgIvUYqvWVp?=
 =?us-ascii?Q?dgCf53eoGI9Osk59SRMx7yFzFWPmvQibnRRemJ0zn/muUM1nxwS4LMUIOPqd?=
 =?us-ascii?Q?+EOmFEFEzpx04s5esZkeozyVyareuiezKhCfwu+T9Ms1kLDPbmczUqMC/2XB?=
 =?us-ascii?Q?LltEe4FXtc8lOQ/L21X1tV65FD3e1ia+zDPe/rz9fbJxRHcju6/S/uya0K/k?=
 =?us-ascii?Q?flMv/eYCXjLHKP6AoTxiI1MStTxD+efo2y4slg196Fo/xbZ+gU8dpYRMQSeo?=
 =?us-ascii?Q?nRhJWVYJr37508n+kDI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd426a2d-3301-4cee-b7cf-08de0cc2015f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 14:40:51.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: koGANmugnJ/NAuTF2tOiD9OtnJlGnY7PUK4o5ZVa2Pg+EAXhsGMmI13d8TM2e3wI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: Thursday, October 16, 2025 5:36 AM
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
> On Mon, Oct 13, 2025 at 09:34:28AM -0500, David Kaplan wrote:
> > Re-patching is done under NMI context so the NMI-safe version of
> > sync_core() must be used.
> >
> > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > ---
> >  arch/x86/kernel/alternative.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternativ=
e.c
> > index b67116ae883c..2d48d750d4d9 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -2585,7 +2585,11 @@ void __init_or_module text_poke_early(void *addr=
,
> const void *opcode,
> >       } else {
> >               local_irq_save(flags);
> >               memcpy(addr, opcode, len);
> > -             sync_core();
> > +             /* Re-patching occurs in NMI context so we can't do IRET.=
 */
> > +             if (repatch_in_progress)
> > +                     sync_core_nmi_safe();
> > +             else
> > +                     sync_core();
> >               local_irq_restore(flags);
> >
>
> Can we please keep this in sync_core()? Something like:
>
> static __always_inline void sync_core(void)
> {
>         if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>                 serialize();
>                 return;
>         }
>
> +       if (repatch_in_progress) {
> +               sync_core_nmi_safe();
> +               return;
> +       }
> +
>         iret_to_self();
> }
>
> That way all the modern stuff that has SERIALIZE will still use that.

Hmm, I can't quite do that because sync_core() is used in a number of other=
 places too (unless we make repatch_in_progress a true global).

I wonder though if it'd be ok to have sync_core() check IS_ENABLED(CONFIG_D=
YNAMIC_MITIGATIONS) and then always use the mov-cr2 version?  It might also=
 have to check X86_FEATURE_XENPV and use IRET in that case but otherwise I'=
d think it's safe for machines that could support dynamic mitigations.

--David Kaplan

