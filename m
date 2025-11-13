Return-Path: <linux-kernel+bounces-898319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A66C54DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D57F4E02D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DFA10F2;
	Thu, 13 Nov 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="GCeY45My"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33121EED8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762992219; cv=fail; b=qW8lw6Ycs0WMocTIgvKoZeGnYq3GYXCV+L1oS7XMOVwMK5ef5v+9jjDsp3OKK7AehiZ/Ft7nttcSFcIDfQ7FJ1GP+HUW6Tekgbn2xEOYZqiUztFGUUbZIrIvacOz/CMe0n7GcMoHYqNLawq2RPtoyF7vcLzptDvELD/ZF5/hEmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762992219; c=relaxed/simple;
	bh=KRBWjeKBgql1lFJraL7qh+ryhjOtQY9iqzsVh67lPro=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nsnpMOrsw6gqL/YlsKail6BWM/obeeE/Tk6enNUF4X0Ay2Fhrst/CXevwdWEwMzcLDNQh35oz0HVHpF6qqgXKZ/k31aAcTy5wETHxwRwLu8VkTB2BigK4yAbgU2qLNo9OfNUxF6xdoqRQaxvnNZ9RZD7klD+3ze0G3vVNzSTIa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amperecomputing.com; spf=pass smtp.mailfrom=amperecomputing.com; dkim=pass (2048-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b=GCeY45My; arc=fail smtp.client-ip=52.101.56.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izFu9i4anQBmTKC9F27++JcgCnC+JCMUKru2RZQ6APjqX968pBF+Mew+UhkpJUBDBITeLzdILAaIm+7EIpEk2PSPEOsA3YM7fzeBK7fw+cXfgc8kMb4BA9dpqh+5P8YVtz5uJlAgJrTew1k0EZbgncxHxcF/XthjuA9fCJ9rgOnzuMVUvHnYNk01Qlyz18US/3YgOU9iAqJXFZEYKxvM0ldH/UXGcPzS7VhX9zWtQ9kTuyBkTPW5Ehhc/6qszKg2EIHztbOd+EBS2S54+rJwQ79IcNB5A4jy9y7ZhgBWWnyo4Z7xZj6rBM6muXkjOGAat5sKLElaPZ7w1XECPjiGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hb8jZtoQoJ6b3NSXh5AV5mWmRsD/zCCoQQMNyC5A+o=;
 b=OXPsOQMoZiT5GEskmMGWPKyVUbrtdpm1JHny1xH0dcmhDy8wlnim1WGNuo0sMIb4lM510eh1ewgbh4OtR5xd6F2ZbeSQ++TFDVupX7Gq7XIQAtsFBb5Mme/MvxFSG/pQvXyotqqaEjVjcb+wmbDdk8fGXnuRCNghvHQjevnnq/jnZO5el3dpG1svl0sutWRdAdNMY5qY1USXhXZ45VDxKWpuM+aeySqdUPCBXto4Ob7w9wYp1iB29MkMNxTfLhkl+yGs4f9/GM+MIm8TCxERwsN49NV/1AL7g0LmMwHm3SlwWA9bf6dNIq7x5bCn/mBrKrig/EKcH21IItAWa6HiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amperecomputing.com; dmarc=pass action=none
 header.from=amperecomputing.com; dkim=pass header.d=amperecomputing.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hb8jZtoQoJ6b3NSXh5AV5mWmRsD/zCCoQQMNyC5A+o=;
 b=GCeY45My9vFAJnh++g0Txx6gmiGDoNkOJw6djnnziZrnBGkW/Qlzb/Ur0damdRzmqs6Oa0feiiqIXOB3mTCjHkIp3s515yp0o1dwCTwVWO2u0otzOCwzfKdQfzzZbu+feTOSVL2HBQoXM7xzhlspmwf6VlRXTU6Mt/mkFmb5hkzX0CsGCIIzB7B7gZdbkNtTlrKRFl4EZbY8SQJEcfSBa4gpAUEh/87LJ8osUvJimV0/dW07yFkzIECKup7DmGYwCFSGD3OQshteTCADjUQjsatM1yji3dgVBlDabkimQnaUHqm83AkW+lW1tgw1HhEMND1c4nEE/Wf+p14sv9JFyw==
Received: from BL1PR01MB7649.prod.exchangelabs.com (2603:10b6:208:394::22) by
 PH0PR01MB6745.prod.exchangelabs.com (2603:10b6:510:96::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 00:03:34 +0000
Received: from BL1PR01MB7649.prod.exchangelabs.com
 ([fe80::951b:7575:6352:6da7]) by BL1PR01MB7649.prod.exchangelabs.com
 ([fe80::951b:7575:6352:6da7%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 00:03:33 +0000
From: Shubhang Kaushik Prasanna Kumar <shkaushik@amperecomputing.com>
To: "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
CC: Shijie Huang <Shijie.Huang@amperecomputing.com>, Adam Li
	<adam.li@amperecomputing.com>, "bsegall@google.com" <bsegall@google.com>,
	"cl@gentwo.org" <cl@gentwo.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mgorman@suse.de" <mgorman@suse.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "sh@gentwo.org" <sh@gentwo.org>, Shubhang Kaushik OS
	<shubhang@os.amperecomputing.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	Frank Wang <zwang@amperecomputing.com>
Subject: Re: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Topic: [PATCH v2] sched/fair: Prefer cache locality for EAS wakeup
Thread-Index: AQHcVDDzmupVROYIpU2x0wzZ7FuPuA==
Date: Thu, 13 Nov 2025 00:03:33 +0000
Message-ID: <548ADCD4-7726-460C-A645-8BF74ADBCB06@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR01MB7649:EE_|PH0PR01MB6745:EE_
x-ms-office365-filtering-correlation-id: 65b3fb70-2324-4ec1-4077-08de22481634
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UY+UXkSHq111yomXYRbqK9rWVHRkRKcNpTZPl4gUSiOci81SM1K4SK9QdmJR?=
 =?us-ascii?Q?mvVWPYMHUTojaxWXHiurW+Oj7LqB0cDWA45q3zPUBmmEgrb8P3TKCMZ2UIUX?=
 =?us-ascii?Q?tnIX+9Tuwi9Qg+EcgEv7BWCDiHqVnCG0UivymmJDjDRO2yEyCdmyQ5vscyM+?=
 =?us-ascii?Q?bGGsvS9kNi2nVBSJXTlDUM5jgVcjQHQ2pwN9I8cCCeAY1S+1b7+l9t5tCzwH?=
 =?us-ascii?Q?JL6DmCan/8sx/UVV+WUowYHVHclLbWqCKgf860yXUd4DLCFyeVYqTeqRaTjX?=
 =?us-ascii?Q?Nk2cYB4ED4Pv4QWFWxDa+vSOa/AUZVoRNRoeMmLXUYg5lCIIIXRi0E/R7K0p?=
 =?us-ascii?Q?J0CaP5NRaC8YEC75BVzeM+GAsswQtPE5oX1f1NX49BxNbJ7Max1o1ZCmOQ/j?=
 =?us-ascii?Q?xsKBEzb+SAwlMxwjM6IrxHzQcPTJzs8t1dozLMw6havEIyO1465lsncBSLgj?=
 =?us-ascii?Q?Gg5uKxP1Ht5KsQ52Cg35VQdhUZGibXzQ+GQruv5GeDt49DmLfrzFyPZ0vvVa?=
 =?us-ascii?Q?D65yIlAFoO6DuoEOaAQz4xRnn1meTv9Dto4QpVHr0XL214PG11vCSKVxh9aq?=
 =?us-ascii?Q?Xuvn+V5/uCX19pZDSdUxhNRuiXbALiFbq1Mm9QZhHYSm3DiSAmiv69Od+JII?=
 =?us-ascii?Q?cC7sph/1TtwsIWo57EnXZocwdl+t2vQZbC+0NZBFfMoZNqeStalOQeQA6Vra?=
 =?us-ascii?Q?8WTUlqs/W99CGI6ASXgfZFkaGsiiMz2djwZUvRhZX87lXhfH8SK542Kk4roq?=
 =?us-ascii?Q?5P0xfb0WL0CRIkALK+6iruyiMuvSuLPyCU5Vzk6cRNFLJp2sDVkO06XmpQVN?=
 =?us-ascii?Q?7+VrwSSN774MAmwVO7oKynUGc47HCr/SjMrMFHjk0dsWtV5qMYb2OvfHkh9U?=
 =?us-ascii?Q?gmPIWFTR6tja8HK0hK7TPpP7B+RB4KGlMCJ3Vm2NzeAUiFp7ntKH5W/1zQnF?=
 =?us-ascii?Q?5su9W9ehjy2JJkmK2MUAv8UtOP13mXgpf1AP3TrAU21l5qYRREaZCpL54DXO?=
 =?us-ascii?Q?I23Gvs01aRSE8/p9yFTazvL+n4T50OclXsd6+NHo7+j48yzsXh74pSR+wd+Z?=
 =?us-ascii?Q?swuiMOfie9R8kgVLLinrhBhY0kJEf1QMGx02kkSp6VLaa3Eb1hk6wCIMIqph?=
 =?us-ascii?Q?MxxDYFBbldFwiTCddJkVCg467Jrh5EGlFiod9921yqNsLoqVW3Q3z00LsuN7?=
 =?us-ascii?Q?aEqE1Tk4rKiyVsA1pnaE1gS6+kWMBHEBhIbrUM3zmkgFeZw+SFatdtXFl31r?=
 =?us-ascii?Q?NqKsKNHDit0BqIhbKyaO705Gvh7aJLNeoBGq2yO7G9XVRCe7pqd+PIONaFdk?=
 =?us-ascii?Q?4kJyv7vy7LY04xuNkXNdtvlsirbsa97Tra7Nah54qXnB0QSGW96bKoeD42Qt?=
 =?us-ascii?Q?GcPmxdjZdAlhh0gPuCXYLIdf5K+UF3rxbcXCjUikp2ccAoMK0ZfVbMAM7jq6?=
 =?us-ascii?Q?R8ZdvBcGMHdbF8bGp5RvxTSZSrjwz7SUkcJyxXjpz7yku7lu/X+vOqrf7w1e?=
 =?us-ascii?Q?OQ0+03OXz5ERYPKtVW2Q2MNTq1rO6u/ZpbUX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR01MB7649.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZP7IHa1lgTRRC+P7GMqG9EqQEzB8rLKg/8B/4gC66161MheFY1apy9W6SYHZ?=
 =?us-ascii?Q?Ujev8URw7zBbCyree7A2KYVuEy8IoXUvY7coqGeqFkJB96slQ1yd6dS6iXN9?=
 =?us-ascii?Q?xdY9CLOVwMK4Np1G1i6WKv8H12ZPDHARW7y+RquQzkcomw8MLAXCDXf5D8b1?=
 =?us-ascii?Q?ypZ0pwFOjKz5FkeeuujRTTCdN1tlpXPAqbP6TIhLQdm65061W+tAvA3eJ3Wb?=
 =?us-ascii?Q?iUzFC5jgnc7Lj/iv8+ntQG/83LQLMGgAkucddQYf0XdcNHtARzJwBC+sGzOj?=
 =?us-ascii?Q?2uTd/Ldq6fze+XZs+3f76O5np+9CCvIDZFyfygycCQBg+UlKPmXqs/2UMgMm?=
 =?us-ascii?Q?bDuXlYST/qDVr6NxMmjSRe9SXdNDHSQ9zZTOQOa8cqa6rLlzMP/haYu4TBdC?=
 =?us-ascii?Q?KQMRcW9Cjk7lOXnIDc8BNzbvxXpF16QUOnp85tpJW1jVuwA2LgvFIlk2AOJc?=
 =?us-ascii?Q?UTQ4QiTmNFuxmD69s1h8zd6mi07HPtTMoZzSrfMq+y3dXVrXSnibMVJTJgsf?=
 =?us-ascii?Q?7n/Xlgfwn5/5U+8sadIr4Z+ydI+8MAcv5+ksGslJxGjXnRLZleG5R9mblYck?=
 =?us-ascii?Q?YkqKHPJv+w4Z0TzpWZDZCsy6UxRvy/3jzBlR8BfIxwCgRXgEJDoGqm+EvmC5?=
 =?us-ascii?Q?KbhoKJ2P/kHwIRJYry3OS9BRPQK4dJ4h0uPMpvq2qdLqHuEYkxoVD/8wDj9e?=
 =?us-ascii?Q?4rngYyzD6b+bgbUAe1xNcJ59sE20tu96xucmnOCfJVOYhPi0aUNbbCnbgnSm?=
 =?us-ascii?Q?MlEjeGjV5FGG7o4Tfj97CckW/FcxfsxJkBX8KUZ1dLpIvcYaPMV9FU/GDmNS?=
 =?us-ascii?Q?SObNkDLMsRVYsdKh5uZHu9TzKyy1ZjjgMwrWo8EZ/5icpJBEms7rAJCjO8fy?=
 =?us-ascii?Q?a4zlh5N6y1tB0vgZCFnOHPWrM6enmxx3ItCrgqhnUPL77GLVNNGFEawOxEUr?=
 =?us-ascii?Q?0GvEBtC3fW2D2qQlgDlAGH3z7UC2Dv8EIPwwU2D1o8PA3tO5qgNXUKxP+gYQ?=
 =?us-ascii?Q?x7qtiNihL4Otizn+4jFqBVzQDmd3kXo2KvXD/+FEyCTp9qw638gg9bDNGg7D?=
 =?us-ascii?Q?a2WgznnTZy7kl0AAUAH4SpeQ7Gb709GnJMOP+mBFp+CD1RExFXn2hd+SkWNJ?=
 =?us-ascii?Q?9PvnLL2Afw48Vn18urPbyak7jTVxuxIv3Gz+st89v1EiNsPTRaxVqktALNVf?=
 =?us-ascii?Q?al71pO6nO28o2CWURgZhLn3wBXdpTK28K09Y7Ib50BudK3Tu6RuoqwfUg1u3?=
 =?us-ascii?Q?e3AgOAx15pzDCVlZAZeS57R4NgY9oTsiXGh/NNYD4aAKeL+MqA2UHuq1lxba?=
 =?us-ascii?Q?bMlfOJVuOchZWr5423PVMjnzPLc5PoEVT2o9HyOUbp4dhogPZaQ3SYmauYJE?=
 =?us-ascii?Q?RQGkG5IAIIJWHiewD/OxDQZZyYKtFTSbhkdCF3Y3n7LmBL66nFHnwWnTVNgb?=
 =?us-ascii?Q?A/MPaJ2KWrBDGeeOMit/jND/TkCR6E/qU8tL32b9IrkReAgPOzNZkuE5342y?=
 =?us-ascii?Q?dwTqoqTGRs4+w3E+rnMxfGAKV0ZaNz+8DmyV7Zl16z7QGBqfG83Io9aPVIVG?=
 =?us-ascii?Q?DBsLoNG7/CNbGyBA8j92fLN7DngKJG2SbD72YK5BaeRDg7HGlW7OyCv74Lwi?=
 =?us-ascii?Q?ex2uu9mz7HCeiMFe6pkz3vE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80D24023C6BE19499428828E95D888AB@prod.exchangelabs.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b3fb70-2324-4ec1-4077-08de22481634
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 00:03:33.8580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvSWPXspPiy1WCOHvZvvBcz3Awq0aqX4jG2Or+cszwUF5jkWWXnPgF0olKOEq1YFDNbhteWqPN9l1ZKp2GGS7qMEl7NL1422YWbE56VN+zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6745

Hi Vineeth,

	> Is cache locality prioritized even over idle CPU availability?

I had assumed that the fast path prioritizes cache locality over idle CPU s=
election. However, our performance measurements indicate that, in this spec=
ific scenario, the trade-off is not worthwhile.
The data shows that prioritizing the busy, `cache-hot` core leads to perfor=
mance regressions and an overload on wakeup. Which  means an overhead of st=
aying on the busy core outweighs the cost of migrating to an idle core.
In development, I am trying an alternative approach to benefit from cache l=
ocality in this path.

Regards,
Shubhang Kaushik=

