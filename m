Return-Path: <linux-kernel+bounces-732449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194F1B066B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE91C20B68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCA298984;
	Tue, 15 Jul 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="H23tgQaj"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2101.outbound.protection.outlook.com [40.107.93.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3A212B0A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606892; cv=fail; b=H7HJn8EqGdj+ZNcbcUlwqha0sSKzsJXShqo4k+nANEW3G4q8Od51PwRHt7XAJnlDq289YUhNttHmlak4pamGKuwb53RIeKnIScCSYI8XggTIdVFB5/diqPa0ypZTjcYYZMdBAxgpF2gvnDAtUmII8zBm6FMczXACw9KNFocOmTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606892; c=relaxed/simple;
	bh=mTjXJkleFqBd2kUL7sgfH13xOBGAZi32S8dW9yfdUAY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GyGuxgGkb7HXoZq1qlfTREHj4uEtqgjXnvGyVg3l8f0QD+ebYHruFaZp9g3mOKzTy6wstpM2cKJhemYQrwN8481G4qF4ypSsgCuRszp8fqfIH9EPMBCHArSihUQhoWUS6dzfjJG6ZFaPElrmaA0oGWCxwJFsmdjPGWuS0o53g+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amperecomputing.com; spf=pass smtp.mailfrom=amperecomputing.com; dkim=pass (2048-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b=H23tgQaj; arc=fail smtp.client-ip=40.107.93.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDt5hFTboHwwoYwfjjhZqpKwKjrVY3AtezjYlrDVi+IeAfjwfLFsfN7xPJOCpYDNQk/jsPMxPJ8JaAOJHcct2Zum06c+bUGykHkA0Kbpy34YkRjBORCIyOEpsWCBu5XNUMXr1VC0Yfj7pQ12KBEeRlR9QibJH7LKCyei6IKgEHO247DcL1P0NSy8JmaR3a9hV8g8LWG8U83xyEaPCQMbTeZsACjKO9ntgeWQLqyF/ZyeY5mnBKIXX0lhxGEoghaIG95peduKMcBUJXnnLGd6PVMlUuLq+0AW9NeGglOWJE3/0qD5PWSrPD7f/NYp6IMVp7xsivi4lhKScSfQQxTCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTjXJkleFqBd2kUL7sgfH13xOBGAZi32S8dW9yfdUAY=;
 b=tN2UyXREvH60+4WyRcnn/JGMaH+HvQZkh4sHverZcvLmglje8xnwgm9NW6IX4dSv00auQ4MBP8gurGa3L4mVVf5B2jDIp3Lc9PLiS7gBaA8M1jYuTYq2H4304PlfWjBRBgnPCOS6u2mLSCiJ4EoDMb970X0s6gMa00hBVxlk6y13Ob2m6Xln8OoP105g7JAcvHEWKiZ+68E+gE7K4iXSPfRdyEt3lteIsGcWlTns5zi269F4lA60Q/SkLjq+dUKfbClbasdfR+Drg3UKsPa4ekJy4skXxYDXNxiUrmFyY1PeYaaNPCUpZ5hpJ9bvWfbOr8gcKofZUKENcobnwzhhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amperecomputing.com; dmarc=pass action=none
 header.from=amperecomputing.com; dkim=pass header.d=amperecomputing.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTjXJkleFqBd2kUL7sgfH13xOBGAZi32S8dW9yfdUAY=;
 b=H23tgQajphaXJWgdsfoYsD6KQZI28emoTTdt/eYpLDEZ/Iz5e2QHQxAmuPAFTMO6k9XcrHucqTuUQK2xQhFVy7cinaGolL+9oVIhkMoVeXxzZW2xHxUQqJyDg/5kYYefDGdwmapvX4GkLjscLLZDn+pqjRZnEiENArZI497wkuDXhtPzXeHRi8y4eoEkIbf+l+afygM1ucy6ZnvlZkS+sSCLPXwCFSz2lhUrBXKIErCwBYdzjQPoqXo5ErqiUA1y6UsT1IigNRw7U9Sa+0vcgU7D8eeWecCLQw1akT2hWJMd/z5+a1tR5Ock27zI7foqc/aeWXpti5D7ZRWv3UFc3w==
Received: from BL1PR01MB7649.prod.exchangelabs.com (2603:10b6:208:394::22) by
 SA0PR01MB6188.prod.exchangelabs.com (2603:10b6:806:da::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Tue, 15 Jul 2025 19:14:46 +0000
Received: from BL1PR01MB7649.prod.exchangelabs.com
 ([fe80::951b:7575:6352:6da7]) by BL1PR01MB7649.prod.exchangelabs.com
 ([fe80::951b:7575:6352:6da7%4]) with mapi id 15.20.8901.033; Tue, 15 Jul 2025
 19:14:46 +0000
From: Shubhang Kaushik Prasanna Kumar <shkaushik@amperecomputing.com>
To: Adam Li OS <adamli@os.amperecomputing.com>
CC: "bsegall@google.com" <bsegall@google.com>, "cl@linux.com" <cl@linux.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mgorman@suse.de" <mgorman@suse.de>, "mingo@redhat.com" <mingo@redhat.com>,
	Open Source Submission <patches@amperecomputing.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>
Subject: Re: [PATCH 0/2] Fix imbalance issue when balancing fork
Thread-Topic: [PATCH 0/2] Fix imbalance issue when balancing fork
Thread-Index: AQHb9by62vLZBKKUTU2VIG628n+GUw==
Date: Tue, 15 Jul 2025 19:14:46 +0000
Message-ID: <D25EB7EA-41C7-488A-989D-D7EA9BD6F5EA@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR01MB7649:EE_|SA0PR01MB6188:EE_
x-ms-office365-filtering-correlation-id: 048bbc53-5374-4201-10ea-08ddc3d3dc9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LLQaVUflKrdE22hcTnrq7GxIyoedIBE3eLgvJ9L01rExXRvcSdRRLdHr79fn?=
 =?us-ascii?Q?uV8shC7dRNmJq7Wa9nX2enBehmez4hHbjc0TlqIWat0vUE+F9F4jvLbc1s+I?=
 =?us-ascii?Q?BCYB1gT75iquH/NRvz36UuG3Kj7YCpE7vbMNeBm9q85HVVEep5BAqH4wNXy9?=
 =?us-ascii?Q?OaOhc4iKK1p4KGjJUg7FIufHVt0V0tuCQ2SpisnCiXY7OToGoM+onh0zBDQH?=
 =?us-ascii?Q?DGUqFntxamnA/vpsfuiKbqVNkJNzg0YVeTWm6y71+lnFYtUgmYUZwKjVWjz/?=
 =?us-ascii?Q?JnNYDYvfle5DI4E0Np8hXPul+wboXeIK3o2TlT1jJcRJ5DCK6iYN9jj9tfSQ?=
 =?us-ascii?Q?espW2EjtQ2SyyLCeZbriZR9RZbc6XzP0Z5tTiAF4KZXWpqAMBO9Wf45ouKRh?=
 =?us-ascii?Q?ZXZ35jnDUGELqnHT3gNFT/s/62SBk3S9buuMFO8wv5g1rhizBrKobSwhgdmO?=
 =?us-ascii?Q?SZU7dLpNq2V3eMEMgO+pXczs8pQmNQ9QoEVpDLpX6AsxURMAfqiGefCJElUB?=
 =?us-ascii?Q?wTfNhIUPfshPcC7JRkrwTtPmpgyXkC2iutzbYmjAP8Utz/Wfm+/JIxCMlNE7?=
 =?us-ascii?Q?aQ1ueJAVdL/YjbB8tc1QP22gdph9dKyXbMi5k4SHiqol0pj8fs3MVCpUS5Um?=
 =?us-ascii?Q?i1O3ZMwaPR4QB9yYcqteNCb5zT6mT/zabKiPIaYxmw0HDg4KE92vjn7HV9u6?=
 =?us-ascii?Q?Dwel84Zco4Ta4hrrRTpH/3O9HNVF8ctmCWaFb1giVEh6kMnSeoBVpouEcQTJ?=
 =?us-ascii?Q?vN8exysac9o3h8f6DwWtqqknCvMhe+A6OsFYNGeYCWqtDBLXaPX57rIjl4Me?=
 =?us-ascii?Q?L4vygc7vLEFcc5tmHT3SgXB6d+ajuHxk27sDgenHE6Fdm19Jpb8dvHhpA2vw?=
 =?us-ascii?Q?Egx0AKZvAIOYAUmSlHG3S7G0O7Ql6j7WyFwBrLPIvs8F+acZwKn/7beozQxS?=
 =?us-ascii?Q?ohtvEpDkP3XY9WFjCp+sdzlDbBArm6Zi+4HQdPOgwYKLfrbe0zob285BAG50?=
 =?us-ascii?Q?wbP27Ba0cI09zp5PNuw9T08BtSJTkN4pVDKusVU8jhT3Tc6lKGOA6WShXnxj?=
 =?us-ascii?Q?+Kq8wr2HaWBmWp1/Rr9AotWQ6IEGySp4lDLwwBFHaRRdA9G3Mbgky+tlwnjt?=
 =?us-ascii?Q?HOPavpJNf+VsZYco5npvm6LxrcMRg5ErMZybY3Pnz2GwUm/bwUXuRzE/85f7?=
 =?us-ascii?Q?0YVQnjx9noLdP5QWUUr70UdEGpoIqrkOc6ETJMu/TK4dbbGDyYTF4/uFWYI5?=
 =?us-ascii?Q?faMPWLzXWqss05WFaaxZLy12f39i3AIgET91iw+n2Zg7jGfXJZeAyfafw6u1?=
 =?us-ascii?Q?VBrMoAG268cBhZJG0VFZaMtzViKFIhw2oziVQRpp7XxewmTUlzykXOstmC7b?=
 =?us-ascii?Q?D9c1peeZcJInzp0yrQ0SdrARiKPFyZUamFOCSy3B1yVD/t3w5F6uUMEDrICZ?=
 =?us-ascii?Q?C9+uYN3nPbeRPEbjDy19nX9wnAbW8TUrm/pWZEv+06ijtsOmjhVf3g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7649.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8o4+53XOGl4Lwph5PXZaQTuSxOrSvcClPgP9z+HUpUx27ZCktJ8mySzF9zAK?=
 =?us-ascii?Q?8uuMInFYLRp78NgAOYsp+/T5U5sFmKrlQMJMTwEsS/OQ/ryhfhJX8RfpQJGU?=
 =?us-ascii?Q?Oq/gOuk2C3XqnpDJXhSplf1l0ab0M4aPnaqYuFR/gcbLyxNp5mHqdPaq8Vi1?=
 =?us-ascii?Q?DXF7EhIEb8uNFVy/3vd1u2XwpfXEyTr+9oLU7xXC9CsBwZqGDPnNwKL13buZ?=
 =?us-ascii?Q?tVG9FV5bvJH9+DELJcMpKRbQqMlUGCdnvvyJow2G/oLhGz4MjPZYwIEf91zL?=
 =?us-ascii?Q?hBx2WPVpUdnSLnKHSgXdIIiZbN6Pr/G5WaxDQ21h8FyZp5kMR+N1UIFeXejv?=
 =?us-ascii?Q?+RbuFM70uUPJ3FCteoECekc5GkESXQTK/6mqbwiugQR2RndxUeN656rFQQHb?=
 =?us-ascii?Q?UCwjfrLEPYb2ts6QqkuSOviYpL75q5PuqbX6gfKKiaBDlQ52tL+dOb/tItOR?=
 =?us-ascii?Q?rU29hb/uKJIxhdtAUpciBDjCdsRo1gVmDmZQTI2brvYWWUBozWSImf/TQ5sc?=
 =?us-ascii?Q?f7Qjt5jEsJYva357lWAybUrUEV337xRkTnDuzS4CibEknZLxSxMtgAsP6bRt?=
 =?us-ascii?Q?GmzR8k+DP2W+g8DMDraTI2DnuQxX1zGXtES+4l0wv2bs3fFaN8qs7plIeAVI?=
 =?us-ascii?Q?F3PIN//p8POkrlxoaHL58o+sPfGki0jyuwkVJ5BlamlczOZYnuOqmbb1zqOx?=
 =?us-ascii?Q?HbTHcbomzm2XDvszKnHrr6YfSXS53PQeP/Zc0Xbp1LUwnWIgwpOr0ekV+eB0?=
 =?us-ascii?Q?AapWhJkpmd8GIYkw/hYCjIHnvvk9bvbnbhlblRmhP+Ab970w69iSju661NiG?=
 =?us-ascii?Q?LfqceCzOyBjCLN2xyq4YIBL9S12MEuVmjbu2PN2zbVkUNxjbh/vFQFPu4kCH?=
 =?us-ascii?Q?unLDskwQNAlcJOn3NLmuzx/SoH2W+sXYhhD4qCotP5FGjuhP0z3rRK2b3zbI?=
 =?us-ascii?Q?z7F1ISDhqyJsgLiaOJbvwhOaO62YOnzNR6TT+L50lQDIO+gtXuq84txAwTYT?=
 =?us-ascii?Q?CCVgM1iIVH5MKPspvY5kkqI0mgkQww1V8a9n19QS/YUvfADHsYkAlHD08hXc?=
 =?us-ascii?Q?J03+0TwR0rMSlHbypVhDIvIWIgXMKs42Jw1Uo5k+6XLUHYVXkKjvkgCdhg7f?=
 =?us-ascii?Q?WxKUiP6wfezDsIq5SYDBj4eJusX6HJvM2eMTta17UQSBAQ1KBzI7AHU0+m4p?=
 =?us-ascii?Q?SuYK5A0pNAHvIERc0UQJs/IU5lIm5XVTk1Kc307iV7hFuo9rLd6icFU4sMmu?=
 =?us-ascii?Q?aJLkpav84sWn8F514Fv9q6ajmmB5peE88JQRRCF7YMvY8KTvu4yaAwrfO+l3?=
 =?us-ascii?Q?aiJkISND9FRlIE3RWvv/EzjFCT3HhHJ1BXRzzmI20ms05CJC+yn5AqB5Mk+B?=
 =?us-ascii?Q?JXXW2o7wV+7g9c/eXll896Nm0TrlfJjEiGDtCn8Wmhv8FsD7ho7CTxg/eHVY?=
 =?us-ascii?Q?YRjoIeiacUjc667KqjdoGh2cTs1hH9rFo2b3Ayght27vlmMWx+yw2dfmU76U?=
 =?us-ascii?Q?sgX/0i3cvLJYXybws8os0ZVl6gVnpIt4huKJBBAdWCbPOHj5NjiUtEtxUGTE?=
 =?us-ascii?Q?z0pckUbuKWMZoFTpBJhrFPGEWF5Q6//cnJeYgzMx7nuZkAnL0uAZjxL6hnQz?=
 =?us-ascii?Q?9gPCJWGteCR1tiY9tRrLbpw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5847AA4CB0906E4C9C029576C8B6D279@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR01MB7649.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048bbc53-5374-4201-10ea-08ddc3d3dc9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 19:14:46.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9q8gkIRnMf7541viDeUwkdKa0MECqAYmgoXBixB7bDuW8MeYRGZlIKHYhtnJmdzCMsp5xKnQmkWBf+KhCHBfOOfySGgehUqbFEymHZqa4Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6188

This patch-set tackles a significant task placement imbalance encountered u=
nder restricted CPU affinity, particularly on Ampere Altra systems. Our per=
formance tests reveal that the first patch demonstrably improves task place=
ment by 20-30% in scenarios where the number of threads increasingly outnum=
bers the available cores. However, the second patch unexpectedly introduces=
 regressions when tested against higher thread count scenarios, requiring f=
urther investigation.

In light of these findings and the potential regression, the following ques=
tions arise:
 Q. Has the regression been investigated to determine if it is specific to =
two-level scheduling domains or manifests more broadly?
 Q. Were function-level latencies profiled to pinpoint the exact source of =
the regression within the code path introduced by the second patch?
 Q. How do these patches influence performance and task placement on system=
s with linear topologies, and do they exhibit more consistent behavior in t=
hose configurations?

- Shubhang=

