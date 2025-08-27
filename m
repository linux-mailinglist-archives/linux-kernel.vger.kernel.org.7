Return-Path: <linux-kernel+bounces-788366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7BB38368
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E11BA69EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF45350D41;
	Wed, 27 Aug 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n2L8TiJF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="n2L8TiJF"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321F31E112;
	Wed, 27 Aug 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300206; cv=fail; b=CzmJ4lXPYNsn2KqsElOwE8Gqxk7ZvJW2KXx8C4jyasGSkJ18kErn1iRZMDp3AzpGN2c9/MXR4oKkHdcs2gYLUYvRuND6V/ZPUl40ogWMvFPCAowxTTppru3mJDS/kpFe2ED4mQLStPAgv58eB9euI3UXSDthEvfgJ9u0nK8/lAg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300206; c=relaxed/simple;
	bh=D3+PuIC2hj+Z79JjrDH0FHlZ91TH9OUwHrcIMtATjIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rf3pEAOlbQpiywRCoTjCZXpfGJOf3Pwr901iEYrQvStnzypTkbRXf7iUSEekqjw+Arka20Sp1e6/OlJnKhZoSaa4oGLQVEfQzIuTtdtVMN+5azen7u4vGZ/lbTBBp1YhsnBbUHxV/eBY2BKDczicel3O4D0YnA4itEAFisWA/i8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n2L8TiJF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=n2L8TiJF; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=w3AHWS22w2yTbFkNQ1XAAZ+XThVWukRnyDXeolZ/xpl9vvHpQpziKB9ROPbh8K8k8aWHtBbLsZd8mRgHpv7RDg+LhEp21olDpH31NAKxH8pke2K5zUpdYTvWm0+Kn8egA5vQV4Ram5l9oijk0lW1G88ngbUqyOl/E8STowaRdXfwM0gJnT1Lhuiw5DLuZvdaEVOdUBlrUwlf/Gv9B8DhD+Ww4Z2kzz2h+/2GYRSPHJff+Z5zhoMxBQ+YRbR5ZSojwkK65JXQcAOWO29C0DIYBUAUkQUQ/ez9zH8J+AZlmUph2pG49uIVIq1lAWbwkEerkcp8UxZHD0L4OKxqrWqesA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duT0L2r7FaIbAZcTRZtdLlCsYnyVOXhLkCrUjVK0CJg=;
 b=B8jdoVeG6dncSXG+RDHJrRtY7dXdor7w+coHlMuxPlsQDKSTLICr75f3eJCffAcz2TUptjNyAZsA45wjx9z8c3cemARic1OGnUlURZVwey7NAtwjBM0jWzO5bimhDaPyN/QbDFfx7a0s5nqK2TDeR8joluaEbXKV7PmuLW4SF5le0uTEBhTVxCoolyqOCx43v5PGJq9MOXqvC2BfjQMwDi7SbLQn0dM8tjHO0tyxhLi5T62K/aleDR3HVGTDgRnNN3Bkj6WVNlmkyDRwFwcHDD6LuqHpRLS8zNsz9KyoHU0AOmqptdQ/OtEFAs+iRNfOEmpOc+oZ/ASfq3KdowRb3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duT0L2r7FaIbAZcTRZtdLlCsYnyVOXhLkCrUjVK0CJg=;
 b=n2L8TiJFW4D91XkWTVM8CCUYI0OJGaP03X0/LhxHEBZxBcR/uEH8Y8Cjpd13ceBF4kS7GTx7l6M5HoIU42jRxgVaLzOgpjyMknPfs2+dkxhrbU3SDHYmX29J2b8YfUS35z+HGK9sz8LpvXwoiTlxilL3CAOCVzHPYR6EIoRLkuM=
Received: from AM0PR10CA0065.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::18)
 by AS2PR08MB9000.eurprd08.prod.outlook.com (2603:10a6:20b:5fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 13:09:58 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::ca) by AM0PR10CA0065.outlook.office365.com
 (2603:10a6:208:15::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 13:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Wed, 27 Aug 2025 13:09:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKVr0FJPeLZMDVJgr2373bcgSSshw14GtZROmalXFMvF6Rz2ciKvhsZPHHfOI/cKzWcxcZRcUZuQwwbkt9OpFRA/ae9CMRqYJeV7fbp0i4q+PBhh7xo8FPeN+jEdHSFkqSsGS9Sxq6dMlcGXz4C0BXrPWdiWcaV8+uxwW2QSYpq8/zwu8N/RHgqfiH/06VwemaGXE55pDtdHUHjMc/DHXkR0EbxZVfNoPVENTNDyl8d6x9TmNEdVctA6a5eMqgpjtHMy3PfxrkEMBf+Xjm0bmeATi2Y0kKufzoxGhhbvFiLIejuOf11Q43K2qEyoGd/dIYvSu+4xY0j6DB1mQiGf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duT0L2r7FaIbAZcTRZtdLlCsYnyVOXhLkCrUjVK0CJg=;
 b=FBIdJnJQ6GQW7xVwHZf7YEPFY/IQzEnEUN0XMXzOAcUt8vL4ngg8tnTgKVh4wvKmssF/t9dSOcJi8+Dsg0vx3pv7izoEqZaJvLHa4TFscKfx7WTEmS4ne3qR4HutcrHZhleEAz9G0ITbfPUf4OW2aglUCDvFseVawLFX9BBAaWrSMl0HfbSibLX93kLyoT9SJhSIXiJv1nHhIUp92rdQrlFHnLEbMOESqgOZeWJKvDw3PncpWBCpxFVDNM4H2lRMnJan/XXkzzKID7q1UzxdNuqBPq/Llh8kCtnpRNVeFZXPq7iUK0koBojD7HESreccOdU12suJBKOzlAi0KrU8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duT0L2r7FaIbAZcTRZtdLlCsYnyVOXhLkCrUjVK0CJg=;
 b=n2L8TiJFW4D91XkWTVM8CCUYI0OJGaP03X0/LhxHEBZxBcR/uEH8Y8Cjpd13ceBF4kS7GTx7l6M5HoIU42jRxgVaLzOgpjyMknPfs2+dkxhrbU3SDHYmX29J2b8YfUS35z+HGK9sz8LpvXwoiTlxilL3CAOCVzHPYR6EIoRLkuM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB6372.eurprd08.prod.outlook.com (2603:10a6:20b:369::5)
 by DU0PR08MB7567.eurprd08.prod.outlook.com (2603:10a6:10:317::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Wed, 27 Aug
 2025 13:09:26 +0000
Received: from AM8PR08MB6372.eurprd08.prod.outlook.com
 ([fe80::bc26:1950:c684:41d3]) by AM8PR08MB6372.eurprd08.prod.outlook.com
 ([fe80::bc26:1950:c684:41d3%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 13:09:26 +0000
Date: Wed, 27 Aug 2025 14:09:24 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, Samuel
 Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: t527: orangepi-4a: Limit eMMC
 clock to 75 MHz
Message-ID: <20250827140924.1340417f@donnerap.manchester.arm.com>
In-Reply-To: <20250821132935.2070398-1-wens@kernel.org>
References: <20250821132935.2070398-1-wens@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::17) To AM8PR08MB6372.eurprd08.prod.outlook.com
 (2603:10a6:20b:369::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM8PR08MB6372:EE_|DU0PR08MB7567:EE_|AM2PEPF0001C70E:EE_|AS2PR08MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a9d58b-ebd2-442f-f737-08dde56b064e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Re8vdMuKEczcfJtw/eJdXLjhZSYUif+eCaYELF2fx/FvEhAFLubR+lNbFwlQ?=
 =?us-ascii?Q?igjtqZmQYM1DutQZk4FMhDaRVfColDbS+BPa+8pt/TUXqNyPsGHrIoWWW+ZY?=
 =?us-ascii?Q?ci+JgP7lguI3ugjEJluhybZInzccIAFW+bjmWb+dwP79Vpo6yzJUOY4kEO/z?=
 =?us-ascii?Q?O85jEpVYNNn4vnTs9ozwSnA5Hc5C6P+dkAOuI26jr9U9RmCCVaataEOercRS?=
 =?us-ascii?Q?LLRO9xPP7VlXiMQUJBhIqeUSz/phlt8Mx1OT/scOQtMGmIwOicbNWrIP3O6W?=
 =?us-ascii?Q?2wfiGdWbYsRDX2NSi1ri5QK/+Vu8izzFlWTcpn4epQRTVelOx9lUjBl3gBHA?=
 =?us-ascii?Q?uhUoAmQ2ISvrXnxtqO41X71J/+qe7iJOUgfjsHdnljG5XF2lGr7NhMNzbcuW?=
 =?us-ascii?Q?TLJiYrX1a06Ae9YMthhGp2F9orcMuxxGXdbbv7HGAUT8iXw1WkAdNOhop9AT?=
 =?us-ascii?Q?oEVUrNhl2TUsUjWRvPcASuMT6pyLtQZ7Oi7+Xmnli8GpNPkspDYNkdcFyzFF?=
 =?us-ascii?Q?koSS1aGf9coSgZQ9XTcxuo709Rwo6+BxId8Lm6sM5hYYA5pKsSyPaIlLUGKW?=
 =?us-ascii?Q?8swUu0u+hvwkNcp/+2449caoP0Q79mKJGzig+MkCXSGn417PYM+Vzwv41s3G?=
 =?us-ascii?Q?SCk6kf3L6Fo+sCX2V9GfV/jxAXSwn3XoKsXwxms21zCtQFX3vDwweCjKWIMb?=
 =?us-ascii?Q?jvsD87sOEFmqTZbTl6g5fmShb2NNQJmaCiaY4ZN+pK/Vi0a9yhceXk2TGvY9?=
 =?us-ascii?Q?7K2fECucy1aRVN09/W3nL593gOAjXzmYdG6KOl5JMB9grKpSRyCTG6jzJ3IF?=
 =?us-ascii?Q?mTd4gT/ILLD8lqFPMXk3qGZqhTGUs2Bc9JgJQOki2OXcDvSkT2jNDzYBrA4q?=
 =?us-ascii?Q?QpDFjfUc1KAJwqEAAJq8d5CrIo+EpnAOBpwLOdoiOilf7cOE0cwkx9FKya2W?=
 =?us-ascii?Q?JIw7kUpvzHmR4mFtEw/YmDZu7MzEo+CMi16l6WfDagxTaI62pgNyk88N3zfV?=
 =?us-ascii?Q?1G5yxAnpNp7DvDCpIOZSZYh5eU+m0g93RHn9XF3RP8318i0sKguUftkdCS8T?=
 =?us-ascii?Q?8bR4yFIXs+LSCa9Dd4bw2Fp7b1H3njHDQIUaeJTRWn2yq28xxgDYCV/6Edq0?=
 =?us-ascii?Q?9EqPxZm0q8lsjoQnwA/G5InyFWOfiiV4dOpOnjaUIId18RUKOVAhtgiIKqIu?=
 =?us-ascii?Q?RYn7omLv0ZwIcLspZWDQ1q9TZHGapL0o3O6fW4wmuVouIIgNh2oxszFXqDvO?=
 =?us-ascii?Q?UlmCcGS4+s5H4sOK4WfZLlwKIg6yFMgD7B8KU40TAe68QR7bUzabIxthWpEb?=
 =?us-ascii?Q?BEg8EW0wQdwfeVVIKpIEcvrvPudVtUREXCAHCsPcI2SdyK+9Ja9PaLdaSBX9?=
 =?us-ascii?Q?fkFt7NiJxXL7VynJRzz2k3LKe31LhJ59vm5T9ZDmHXFQfdMjXNf+au6XKQ5F?=
 =?us-ascii?Q?r10KOyl539c=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR08MB6372.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7567
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d23feea8-6e7c-4938-6a05-08dde56af320
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|376014|36860700013|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PPQL4TylmxYn4Olnlf0HRyWLFHNBgnsOfjsa/63kThzHBNrdDNrdMs+CBx7u?=
 =?us-ascii?Q?yYQajjbQgHJBUtyrKkGMWC5tLW4K2u2m29YguIMOmu7B3BVL5EEkD55eOPbu?=
 =?us-ascii?Q?z6ZHz6xOTL8c4wpKZTa8ic3z2jSLaVfpDfFjSET5YSNrqjL8Df+u10OWLfoV?=
 =?us-ascii?Q?oUA96ZPfxtAd9xZ5DSe8ls5UGIkW8Dv+PVUPWbyXKGW18IDfRxqdAEDTp2Ih?=
 =?us-ascii?Q?yUjIWHyDqHLPUt78JDuNIQxehwbodcbvmtITJdDEkrttMP78DDRTrEnSLO8+?=
 =?us-ascii?Q?5ytigPqxTQ+ZDdLDV8+4yEEfbl/ydOB+91nEgeNZqVlCIMRQqYlwBKz4m27D?=
 =?us-ascii?Q?bM+GgxcLOn+sG5g3fM7kuYtCXsWLOIH0aJ6SlQP3yawqZ/2MLVot5SMztcZU?=
 =?us-ascii?Q?Oc+Vje06TfvjIuV0FAHin0TQziI96QrgazFpqJtJVnuevF/E1thgvVrYPY2i?=
 =?us-ascii?Q?rUuWz+hwNbKTyLH6i7WEMvcLMTGvy0Z+o1TtzYbWMfcC6W/iW/7w6kSOvCIh?=
 =?us-ascii?Q?/WZMFR7rmMUAlwU26dpnLGpj1xy7qB9P1v9E4g28HxOMVpbXbjHdx4DtRjfl?=
 =?us-ascii?Q?gwZX+5RBbjYfv0lCBUGTH4nlOGk4Ni57uOLmrGygfL0xWNkgwN7eWSMjoZGh?=
 =?us-ascii?Q?629b0y63CNEYnuFr1h0hCOEixQcPwLY87tXeym3DM/Ug+tOzVqDaQnlYvhIQ?=
 =?us-ascii?Q?ltBwgNHPGR4geMOFRmTiw4mnL5V4EEGvDT0Fu4VqOCGwXre1YhNUY9WWJFPQ?=
 =?us-ascii?Q?LW4CTSlySOevqnIdjFy3F8P/kRRsNmlkwoB9iuT9q+Ls/pRNDwPL48ey87JF?=
 =?us-ascii?Q?61/7VE65bbXlgajZFkwcCD2E5zw/wQm0puAU34hqEqopmtem07nXDR7JG5Oc?=
 =?us-ascii?Q?nmmRzFEEKDoDJWPFL7h+rjcruNTqRaie3sUpkvV9YI1gvisq8/p7EB4F1Kq1?=
 =?us-ascii?Q?PjnN5R/cu4Y1acryheFbnre1Hf6uDHUgvLTFkSmKJSvhc/OvLswPgiM0+rQt?=
 =?us-ascii?Q?7s8dQBy535ZNt+LZrobWVZiDVcbos+1I5PDLesi2Yf6Q60xSHbmfOxmi3cMn?=
 =?us-ascii?Q?qJ0UlA/WfY0cV3y7SID8lU65vCL0G/7+3h1sVwh1GQdqYAakWzRpOH/rp4N+?=
 =?us-ascii?Q?HVusJU9yvNlWc8IruwZt97qCU7yNehzRTW3VArZX+mEV9DhIdZKuBWHAJChc?=
 =?us-ascii?Q?sW8GXX8Lr+w6dXk8AHQkIm61DrH4NtKiWut1mtT8IY1RRnwl6J0ARKPAMJpU?=
 =?us-ascii?Q?UKqCw97jHYllXDBThwVOUIBhKxYIIV8YUt3Gz/HhbODD8UMkeTrUYiyQBaxF?=
 =?us-ascii?Q?lKclACvxd3sCa8uKThVyXNDkcqQw8iE4yY21EitK9ukbAOSPK2sQ//ILWTD+?=
 =?us-ascii?Q?7NkON+R3/Mahe5Vuze3oVhshZY4/kFO6nyEH5xWLhtJFVyf3fGB3By/uBsPR?=
 =?us-ascii?Q?aViqgvNxHw/iZxyXDLpLf74MgGJdg312cjnJ9j0ascaNT9AQwebpzBEw0wRN?=
 =?us-ascii?Q?W0wxCZhzWudJPnCza3rw9/iXZy0Ef8CsPSM1?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(376014)(36860700013)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:09:58.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a9d58b-ebd2-442f-f737-08dde56b064e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9000

On Thu, 21 Aug 2025 21:29:35 +0800
Chen-Yu Tsai <wens@kernel.org> wrote:

Hi Chen-Yu,

> From: Chen-Yu Tsai <wens@csie.org>
> 
> The eMMC on the Orange Pi 4A doesn't function correctly at full speed
> of 150 MHz under HS200 mode. Either the traces on the board or module
> aren't great, or the SoC's internal delays are incorrect. Tuning the
> pin drive strength did not help.
> 
> After some experimenting, 75 MHz was found to be stable enough. Use this
> as the maximum frequency for now.
> 
> Fixes: de713ccb9934 ("arm64: dts: allwinner: t527: Add OrangePi 4A board")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> index c52d09cf0888..fb5311a46c2e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
> @@ -160,6 +160,7 @@ &mmc2 {
>  	mmc-ddr-1_8v;
>  	mmc-hs200-1_8v;
>  	non-removable;
> +	max-frequency = <75000000>;

I am not a big fan of this change, as it looks like we are papering over
something. I think the BSP runs it as a higher frequency just fine, can
you check that? Traditionally the BSP uses HS400, IIRC, maybe we should
finally bite the bullet and enable that?

Mikhail has some other assorted changes to beat his WalnutPi into
submission, among others a slight increase of the voltage, both I/O (1.9V)
and supply (3.4V). Also he increased the pins driving capability to 40mA,
did you try that?

On my boards I tried to lower the frequency as well, but didn't get
consistent results, though there was *some* improvement (at least probed
the block device and read the partition table). And I needed to go much
lower (40 MHz), so I wonder if this is all related to some bigger
underlying issue.

Cheers,
Andre

>  	vmmc-supply = <&reg_cldo3>;
>  	vqmmc-supply = <&reg_cldo1>;
>  	status = "okay";


