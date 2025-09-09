Return-Path: <linux-kernel+bounces-808023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E20B4AC3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8673A46A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBC31CA54;
	Tue,  9 Sep 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H76I+Ppg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4202C1780;
	Tue,  9 Sep 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417759; cv=fail; b=CeGKduE+UThT9zGMeWGD6FulKHlDAAwby+/PUSCLI4ELl16kFybQp6U18k9JQFX7TWMYIFBsf6+q1l69fC6yEjGOxetucBSMn1IbaIEIvneVCxu/iKRkxh73ip2xIatBne9XboEzMEExmSRNEkTcd8I/geIZIIffnVDaiZOO4Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417759; c=relaxed/simple;
	bh=vmhKZVJy8H+OqbXpD3EMSIgiC7EpPe+LL88h5B5dEDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vt4FpKyLfEEjSh6R7RpEx24inilzLc1QCt3w+03VvUQS6zjujy89Vn4Ygof6MXc8g7KxGxIJTFaNBP8FBb1oylRyBbwTVZxXud/ym5IisSrBVFOtpCHK5jKN1iE7k0btX3/bSofel33Sby1CFxEq4i9RhzKD04EX2op+KsFeYGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H76I+Ppg reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxVeyoxS/Vy3/CfkUcm7FD6JjPiQi9nHNV4GSPHkDXdyalqVU1wrfQvwhfKhINxCEr2L3gqDSbYyLPWsd13iMDol63p4v97SkELfUS/SnRwSeJV1NtwFyEOvkqDs+XieurCnAxYsYP0uemTL/ka4bzwJ60BeJFxHYcLiXbIinX72GiWK+CifF8R64KfqKyM8Pp3dbTSIB3HvNzCBkBIyZjJ0h6iiAYR03GC8dJgJD3cV+jzKcgU7HTlqxHBfwDn6O7lxfgonwe8bLx2lNWnoiq4hoN/rSk+37zJc4L91+NlpxaCfzFbAn3sPPpfJ4fxMvMOoPm3aL5dly8gQonOWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfJATkdj7epRV76/R8f6k/kklgojMqh3ZPQkFmYbgEs=;
 b=a1S66qQBmo185dXIIjEXydPgf39liIje0M1lSnAe4BrGkJ3ETTEahbG4UQ2W8JfTQ5o/tGmHAkMaDNliTmNzzr7LeHpjaQZYlEGDwWkxQGaXb9iz0GRHl8owUQLLCiXQSVLM4R0Pcanwogz46/ZSn2+0ZBDJAcW6N0KLmplEpxG6Ttq/ipDWGawOLNXlU2uF7BLmlQ75qpKB+DAcBeY7TdWQs5cc8ez8F6NvfMAMfccBjv8s9gqkvArm/hRbPwH5L4+DwG/0M30ThC7mg8arbfR60QdiMgLwJxkIX8lpeJQ/s8XRMRVV+Kgt8RNL3Sziu8HmDwSFwC4koKZQzpeeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfJATkdj7epRV76/R8f6k/kklgojMqh3ZPQkFmYbgEs=;
 b=H76I+PpgeaO4YkdH/3DWdkc8uYLw5t1SvxPni8QQp7vBOBQJDqslx7y96yfEUOyh2xU9dVyfGccWYld782Q6Ktfgrsi/HurxPSaILKcnmHFZzbiwFkMaXeFXrifd7op9G0WoPeJ/tk+w6n7IqEBDIajEVdsr+Aks0nVTXhKyB9GFMRxWGSffnnpvpeGij3fP36zkNOSCZOEc0NDjSZuURM/yQFSNsyROHQ8W0jrafDJHcFLj9uODhpuy6hMcPOXdXTmtDcGJ1aYFHrY5SM9jxXpNQysORAWtpAGmkWGtYe0akFAMdD+BsUn7fh39oZPkYGNn0extcVZtchcqCwSipQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7510.eurprd04.prod.outlook.com (2603:10a6:20b:294::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Tue, 9 Sep
 2025 11:35:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 11:35:47 +0000
Date: Tue, 9 Sep 2025 14:35:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250909113543.q7zazfy5slrgnhtc@skbuf>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
 <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
 <20250908153746.7mfobudenttdi4qd@skbuf>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
X-ClientProxiedBy: BE1P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::11) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: d57899d2-ebf1-4711-7e8e-08ddef95050f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?CmRu7pByFhUu1xKK5SeVIW5lhEcDGpI46ZYIzJcJM9YiaA3gke+ovSLv8D?=
 =?iso-8859-1?Q?oRufSHbI7sDPEjAORGdt7UJhqro3zTxYLP6NkCeQkUmqYdBUkyObbk9L/z?=
 =?iso-8859-1?Q?GUlAXc+qJ6DnFi3BXlP9d3OU68j6Ni7FiivHjgkof5bx0uKSbrP4VAZXcL?=
 =?iso-8859-1?Q?o90yokcJ+x4OYw7E3eOzAYHSKGd+1Q7zt825NzT8kQPfg+DSgfMtGkBSLM?=
 =?iso-8859-1?Q?odyP9SdBN4ahY1THuQXRN3fHIbMN/el+FLbXJzkla+adbkE3Og4bQwRFTA?=
 =?iso-8859-1?Q?Pns8f3FeoNJWbCoevrrK9++4RmPe6YMiQPXAdwv88zyzyR9U2Er4HTvzI6?=
 =?iso-8859-1?Q?ps2Z55SJclwwuEo4ZPfOFUe+2uBnN4E9pRUUxUPjlYgjIrTZiEafoXhqzg?=
 =?iso-8859-1?Q?iBrmhr1iqAupAUkmWLyD7kt1zolVTlmcHELYpiPUB9B446fPKzyY/3VYVP?=
 =?iso-8859-1?Q?Sbg24+OPaRLQRAk4qR3AHGITQqpPYRQDRnqNoPLX/f/SyiR/KVemWjPmsr?=
 =?iso-8859-1?Q?NX7htQFTO6PSHhgz4IxbidQKSLLkI4H2036Yj2jV8NWtHFUnCHDYMynlM0?=
 =?iso-8859-1?Q?nmixfzL+qkcyCq+b4asbJMLWUrsLe1lzoEjY8rzHARKhMVqugNay3cpbWc?=
 =?iso-8859-1?Q?86meo7KrUIsuU2zzDA8KA672Bz9S4vXWHeIyjguO2QbcvMWC8jLUHFRT4/?=
 =?iso-8859-1?Q?kw3jRVtwRr9bpim7eVdzVhRyQDWCLq6VjrHnm/N3xZILjyOlx1zRJQrOR4?=
 =?iso-8859-1?Q?pvESnpRdVo9zoquSzyZY+jrfyoquP5TUD4o5RymioClYRzYRzGfzM4pI2Q?=
 =?iso-8859-1?Q?7tSzaUkaGVph24bjwVYbtm3P/8mbIBl6vjHMy//L4XYtaRIULvi81wOP2o?=
 =?iso-8859-1?Q?m39qPrFIir2xqKMbhlxx4sZ7Hh4K4V3L0U14UYnSrcpfM0SEZ+8MPd6UlJ?=
 =?iso-8859-1?Q?TL928s+hNuvRZcBviTIck7igMGB+4gGduMFAChONgVl9+QQEk+ooIyFe05?=
 =?iso-8859-1?Q?gLR9ojO0kX9vJD0h2YTDHxo9DtqI03lsv94ugDqCwxii32OtT1BCPHiYHu?=
 =?iso-8859-1?Q?mVmmt7vlgGWwoNjYRW+C1XjVLqtB5nhF+jPz5J0vYY7dGrN4ikp6/d+/fQ?=
 =?iso-8859-1?Q?e9usIlWnrNGLKlKhZgXaR+vHZhBxB2p+uQf5Do85xTOj8t74o5UbSz45R0?=
 =?iso-8859-1?Q?ep2TWPZBVGz6wNMfJnrSXHvy8slj6Jv9cJccgb7aT+3nYFV+FUg+fz5+X2?=
 =?iso-8859-1?Q?nDJCNoz6hW7QxVQLjqmsW8+uWULKLcKkld4nBb5UeYaQZZLZCmpvkP58nG?=
 =?iso-8859-1?Q?6WCUB82HwosNSJPvbwY58KB8iteYyT3fBvwfkufLzaO9N8XA+5rtjN+QzG?=
 =?iso-8859-1?Q?ASk1dkElBo3lrJzo8kSg7ceN21vLEXLijqaleHOtQIEUg0K6K4VbWxJaTL?=
 =?iso-8859-1?Q?h9YAGvypZQ3oeHRVCs/Sg6dL4wujRyKNWu16UV6LkFDt1udSyCPCzjlcUB?=
 =?iso-8859-1?Q?0Wr8/YXTRf0aIQ4u6uqtB+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kpZU1W9hRpE0NV9akpNXN6XI+D7nafTkWRRGV32Il/BdekPO3qjuG6xwNI?=
 =?iso-8859-1?Q?2mjaoICO+UYie9UB4RY/Ub2yPDld4l8tiUDv5jUy1YiJ0UMGr2C5gQkWK2?=
 =?iso-8859-1?Q?ir+Eq2ZEGJYTpcHZxuLUspwUaANLmPlsmD053KRsee46fHO2KirB7u43L+?=
 =?iso-8859-1?Q?Ru+SeqKqudtifdwjGbvhqLq0qxVd3zjWK5ZcoT3XdFp81RUzge1V+MIxqu?=
 =?iso-8859-1?Q?tTS15JSQU8TnOmLolScoCv1V1xyo/3msVK345D8NLLqFAqG70PEm4yernA?=
 =?iso-8859-1?Q?0rFxUuKKSPvRjY4NPkjF2GOCeMa5mZvi2vqbQVm+2OhSVQ6BX7V4XfXxyx?=
 =?iso-8859-1?Q?/lrwm5CEkCOhfpad1RWdIeQxu2p4H8rwCLI83Hfx3NLe+ne5LI1FSzAbI/?=
 =?iso-8859-1?Q?lOxp6w0db3lYkBEEvwZPEqJ4KkYz205K0s1MHk8+VQQotbVzqew/PLpec5?=
 =?iso-8859-1?Q?bK5pykQIASFCr+0354qFWsx5T/dGIi/K6Mc1l+A46VxjFlo8KA+PzgRmDQ?=
 =?iso-8859-1?Q?6dhwSsTb1hdwEM7sVAUHmkad6x81kodSSj9UgCBpYw9fhNjQ9qskr+y3jk?=
 =?iso-8859-1?Q?7Ofa/8rYnDIwvMPftg2V6+41JVkWKB9JZO4MjO5lRjVnoksKH1FXm/NKCl?=
 =?iso-8859-1?Q?JyUM4g0m6yhCANz5q22/vUy4hHTzMFi5MiTa1K9uq8ZEuT7qK6DF9wQQ/s?=
 =?iso-8859-1?Q?524vnECwSrrKD4Xip84filM0JNDYf+0AMpgFXVSJdeT0K8ihOnZR5Iq4Ee?=
 =?iso-8859-1?Q?mq6sGJqczw5YBrXNQ9MjPwts4dcMjP41dxdgRixv9LcIhtW7qF7GWR93A3?=
 =?iso-8859-1?Q?JRqH4Ged93xg98tQI0dIRiPSHhELI8iKeuOH5rQKkStjDHplh2f1qUzTf1?=
 =?iso-8859-1?Q?Dw5m32as0WjHT2xM7QTLiPLqIvQMjM32XvWhecH12I3FvXA6aDX6XQBVpl?=
 =?iso-8859-1?Q?56mtuuAsGYciDRINEkJW66EpemXea75/806O2pIzsjKs+rnbdVPAMU4wQ7?=
 =?iso-8859-1?Q?tsBnOzuZGaRG2c8ckhL6AM9JeHc2iEf9f5I/ohn69l7N3Af+o+QOTsBIcX?=
 =?iso-8859-1?Q?cihdDTa5Tm2VRcKOo6Af8ZSsL8ybxHQ7bPfTB2cOBmCaXKZlGSBNiRn1Z1?=
 =?iso-8859-1?Q?0zIK++5MRj91o8HH75if560P8i2zcnt37tGqQGN0kjXu8DGeVvyQFxG3AP?=
 =?iso-8859-1?Q?NzzXm48HQLcdo9YigNO4jGAE9gHYmLLiTBPJOTrcsZCeGQ8xwv0Jhye7ot?=
 =?iso-8859-1?Q?5wq+tf5rF7CL8x2dAgMmIl2Ul903cdD3ViTL2RTe0HC2KVuB12jZ3xQ9Nz?=
 =?iso-8859-1?Q?hUV2nZyK/78U+z+KesR5Qgc2MWa7NHu5wnBbu6r8PYyrW+YnBJodN/EJUj?=
 =?iso-8859-1?Q?DLxS0kKVxj2ulLfwLDNzOgTZGx31DGyZ8mFY9NWl8/PZb4g0toei8yo5VL?=
 =?iso-8859-1?Q?8POj/BdAybhPevfdQuwRO81fX69O2bVVJbyRWWrynsulhSKI6bBDJRJ0jF?=
 =?iso-8859-1?Q?ACZcLP0o431QmlhM4jWkfdZZJaGNmNZUmzIXO7gyJ2z7pbjunCnEw1447h?=
 =?iso-8859-1?Q?Xgs8d7t5p1voi/rixsTDbTIJI7eBpDvCvhN4KmWwvSIi9tNoFQjsW0zsKe?=
 =?iso-8859-1?Q?S8EH35J/C5XR2WMC1sXMvvwfCJ9+Gfxo2UceLZcHu6w+csZKLEcmkeQxZW?=
 =?iso-8859-1?Q?1rqx4S8s+mm7ZjyK5cODMc4Zyr2Msd/FneZio553FoAgB3tzHpX0EyPIlk?=
 =?iso-8859-1?Q?y/5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57899d2-ebf1-4711-7e8e-08ddef95050f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 11:35:47.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha3TCYq6EP/6fDTGr1fBHbDlLiGVmjPUPyjIIOZYBWVLBANAhtI0DyXG2YIRRu3gkf0KJeuVyc5WfRMDMtzGig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7510

On Mon, Sep 08, 2025 at 04:04:45PM +0000, Josua Mayer wrote:
> Am 08.09.25 um 17:37 schrieb Vladimir Oltean:
> > On Mon, Sep 08, 2025 at 02:02:35PM +0000, Josua Mayer wrote:
> >>> My updated plan is to describe the schema rules for the compatible as
> >>> follows. Is that ok with everyone?
> >>>
> >>> properties:
> >>>   compatible:
> >>>     oneOf:
> >>>       - const: fsl,lynx-28g
> >>>         deprecated: true
> >>>       - items:
> >>>           - const: fsl,lx2160a-serdes1
> >>>           - const: fsl,lynx-28g
> >>>       - enum:
> missed fsl,lx2160a-serdes1

I didn't miss anything. "fsl,lx2160a-serdes1" is deliberately not in
"enum" because there's no point specifying this compatible as
standalone, if for backwards compatibility reasons it will always have
to be "fsl,lx2160a-serdes1", "fsl,lynx-28g" (it was described as
"fsl,lynx-28g" before), which is already covered by "items".

> >>>           - fsl,lx2160a-serdes2
> >>>           - fsl,lx2160a-serdes3
> >>>           - fsl,lx2162a-serdes1
> >>>           - fsl,lx2162a-serdes2
> >> Weak objection, I think this is more complex than it should be.
> >> Perhaps it was discussed before to keep two compatible strings ...:
> >>
> >> properties:
> >>   compatible:
> >>     items:
> >>       - enum:
> >>           - fsl,lx2160a-serdes2
> >>           - fsl,lx2160a-serdes3
> >>           - fsl,lx2162a-serdes1
> >>           - fsl,lx2162a-serdes2
> >>       - const: fsl,lynx-28g
> >>
> >> This will cause the dtbs_check to complain about anyone in the future
> >> using it wrong.
> My proposal requires two compatible strings always, or the schema will fail
> to validate. Examples:
> 
> compatible = "fsl,lynx-28g";
> // fails validation but driver can keep supporting it for backwards compatibility
> 
> compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
> // valid per my proposal, functional with existing driver and future changes.

No, not valid per your proposal, there is no "fsl,lx2160a-serdes1" in it.
But verbally I got the point. What you propose is only different from
the patch that I submitted in that you're saying let's drop schema
support for the lone "fsl,lynx-28g".

Our proposals are fundamentally different in this aspect: to you,
"fsl,lynx-28g" means the general register layout and programming model.
To me, it specifically means LX2160A SerDes #1. We have to agree which
one is it.

So, generally I do agree that either one of:
- compatible = "fsl,lx2160a-serdes1" or
- compatible = "fsl,lynx-28g" + explicit protocol listing for each lane
are sufficient hardware descriptions, but as a matter of practicality I
prefer to keep only obviously correct information in the device tree,
which is only sufficient for the expert level details to go in the
driver, where they are much easier to fix if wrong.

The current "fsl,lynx-28g" definition and use does _not_ have explicit
protocol listing per lane, so unless it is interpreted as meaning a
synonym for one particular SerDes instance, it becomes even more
meaningless with current device trees.

> // this is how you will know it is SD #1
> 
> compatible = "fsl,lx2160a-serdes2", "fsl,lynx-28g";
> // valid per my proposal, and driver can use it in the future to identify SD #2
> 
> The kernel looks in compatible strings for the *first match*.
> 
> > So just that we stay on track, this is what the submitted patch
> > originally proposed:
> >
> > properties:
> >   compatible:
> >     oneOf:
> >       - items:
> >           - const: fsl,lynx-28g
> >       - items:
> >           - enum:
> >               - fsl,lx2160a-serdes1
> >               - fsl,lx2160a-serdes2
> >               - fsl,lx2160a-serdes3
> >               - fsl,lx2162a-serdes1
> >               - fsl,lx2162a-serdes2
> >           - const: fsl,lynx-28g
> >
> > Your proposal is different in the following ways:
> - always require 2 compatible strings specified in combination,.
>   validation fails when fsl,lynx-28g string specified alone.
> > - Just compatible = "fsl,lynx-28g" will produce a schema validation error, BUT
> >
> > - There is no compatible = "fsl,lx2160a-serdes1". I don't understand how
> >   you propose to describe that SerDes.
> copy-paste failure, I intended to list them all, including sd1.

ok.

> > The fact that SerDes #2 works on the fsl-lx2162a-clearfog.dts is
> > accidental and doesn't change the fact that describing it as
> > "fsl,lynx-28g" is wrong.
> 
> It works because only the SGMII modes are used on that board.

Yes, which qualifies as "accidental", considering that the SoC dtsi
describes two non-identical blocks as identical.

> You can however use this argument to drop driver support for the
> lone fsl,lynx-28g compatible string.

I'm not going to do that. There is a big difference in the two uses,
which is that "fsl,lynx-28g" is problematic for SerDes #2 but isn't so
for SerDes #1.

Accepting "fsl,lx216*a-serdes2", "fsl,lynx-28g" in the schema would mean
the two are compatible, which they are not.

Keeping driver support for the lone "fsl,lynx-28g" (treating it as
SerDes #1) would mean newer kernels would continue to work on
non-updated fsl-lx2162a-clearfog.dts, but updating the device tree would
require updating the kernel. I think you implicitly gave an ack for that
here:
https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/

|I don't think you need to fix a downstream dtb via the driver.
|If downstream user can update the kernel, they can update the dtb also,
|to resolve their own bugs.

> > (of course, I stand corrected if someone finds
> > a way to determine that 10GbE is unsupported on some lanes based on just
> > the programming model, but I doubt it.)
> >
> > The only 3 ways to find the list of supported protocols, that are known
> > to me to work, are:
> > #1: list them all in the device tree (talking about tens, and the list
> >     is ever-expanding as the driver gets more development). This is by
> >     far the most complex and difficult to maintain solution and my least
> >     preferred.
> > #2: hardcode them in the driver, based on SerDes compatible string (the
> >     current patch, or variations). This is my preferred variant for
> >     keeping the dt-bindings simple and the
> > #3: like #2, but distinguish between two "fsl,lynx-28g" instances based
> >     on the "reg" value. This should work fine, as every SerDes block
> >     index is instatiated at a fixed physical address in every SoC (block
> >     #1: 0x1ea0000, #2: 0x1eb0000, #3: 0x1ec0000). It should directly
> >     address your objection, but:
> >     - it also requires dt-bindings maintainers buy-in.
> >     - this method can distinguish features of SerDes i from j, but not
> >       from SoC A vs B. There is an upcoming Lynx 10G driver where we
> >       need the per-SoC capabilities as well, and it would be good to
> >       have the same overall driver and dt-binding structure for both.
> #4: by listing descriptive phy sub-nodes under the serdes blocks root node.

So in which way is #4 fundamentally different than #1, other than
slightly different organization of information?

Generally I disagree with requiring board device tree authors to
maintain the protocol list - it should rather reside in the SoC dtsi,
because the driver is able to automatically further restrict to the
valid set of each board, through lynx_28g_pll_read_configuration().
So I'm only ever going to consider this if the protocol listing is done
only once, in the SoC dtsi.

> Presence indicates whether or not a lane is available,
> while each node can specify the modes it supports.

You mean "lane is available" as in "LX2162A SerDes #1 only has lanes 4-7
available as an SoC parameterisation option", or as in "this board only
uses SerDes lanes A and B"?

If the former, then yes, maybe. If the latter - I don't think this is
compatible with my idea of describing SerDes lanes in the SoC dtsi.

> Obviously this allows the device-tree author to describe invalid configurations.
> But it avoids describing each combination in the driver.

I see "describing each combination in the driver" as literally the
smallest of problems. It is just a little bit of extra code and a few
tables, located a few tens of lines above the code that implements those
same features in the same driver.

Compare that to listing protocols in the device tree, which may be
distributed through entirely different channels than the kernel, so it
involves an ABI contract to obey.

It's really a matter of humbly admitting that I don't know what I don't
know - I would very much want to avoid the logistical nightmare of
having to update device trees again when new things are discovered.

I've seen your proposal map out on the Lynx 10G SerDes, and it would
look like this:
https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
You can hardly consider it "KISS" when the device tree specifies what
value should be written to what PCCR register for what protocol.

What you seem to want (customize electrical parameters per lane) doesn't
seem to need what you're asking for (listing supported protocols in the
device tree per lane).

This is mostly because we're _not_ going to add "fsl,eq-amp-red",
"fsl,eq-adaptive" etc as you seem to imply here:
https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
- i.e. shoving device tree values into hardware registers. We will
instead define a vendor-agnostic method of specifying equalizer
attenuations in decibels for each tap, and somehow translate that in the
driver into LNaTECR0/ LNaTECR1 register values. See for instance how
Documentation/devicetree/bindings/phy/transmit-amplitude.yaml defines
"tx-p2p-microvolt", and which is a starting point for programming the
AMP_RED field. That property already has "tx-p2p-microvolt-names" per
SerDes protocol (or so it should be - no idea what's with "xgmii"), so
there should be no reason to link this with custom "fsl,lane-protocol"
values or whatever.

It's completely fair to say that currently I have no idea how to
translate standard measurement units into register values, and I'd have
to ask the hardware validation team for formulas. But if you were to
imagine yourself as a user rather than as a developer, I think it's
pretty clear which option you would choose.

Anyway, I don't see why the above can be future extensions, and aren't
my main preoccupation right now. For now we just need to sort out the
lane capability detection per SerDes.

