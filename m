Return-Path: <linux-kernel+bounces-753310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91505B18162
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA361C25392
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24063230272;
	Fri,  1 Aug 2025 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ME442LoW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ME442LoW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627262248A5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049608; cv=fail; b=BqFIEQ/6qygSMMYKwXTf0l4tGgY1cOWrqWi8fKbv/QbTCleo5UYGvd/8N507VKTg/+7A91WxhigqaUxTf/nz9NBvumEteHLp78+6Hm8t0Hhe2jfVdgIRfiftdM2/8FDc6ACof7BPrIVmVYJwNtHUol7m27lxGeEJ7komFdL1EEw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049608; c=relaxed/simple;
	bh=L2KNLub4dwscOtMVP43flF73Fs9+UlcgksX4eQT47zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFIF05TzODmKX0R8KgfhQqoYTronAzPjeJBo7oztxzisssjO2UyNKKapU+H1z3TTFGL+BUTI02kQYUnpPBZnn/83Eop/tLbjMSOKCx0wseMNSWJvKhiPDXG7qm39GMhMQXsvBUqIbuZTWl/CYN2vKNYQ+whElysAAu+XS9mBLO8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ME442LoW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ME442LoW; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Xdw6EV/mbziOMFRa1fz2CTpj/CHkf7GKCdlIpfwCkijk2kNZ3JFsD74K5EAyHrU3I28/ovLnYBGj5bvQloE/PRlDtbY+nRiimicdMrEmc/f47U9uSYRNiu09Cvu4G+EShbQoNV2/BHHs1yIBfAALpHEzeHTD0kJrx9tXwfFPntKFaI6LhwHN/7+dCzKUfpZQi/K7m/U+j6nDswpYjxESzy6sNWA4gX57554zLGSva7kFLz1t+ULmXStVoBR5nsjPeqx2j/3CABi+UuJpxQxmgeTLOh+LHzSRi936tAhNyznhzkf94W+lj28lKIFQCBmOsAEUmeezwXtcGbAFPvVaZw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GerBoo9YYMKztWZljHsS0T5qv6yaH9BQiprdhoSYt/8=;
 b=pItG4+qj8DFxexGFkJV6oDPLG2noLKgZRVChS259NzShIFrTnzsqoRuf0foLWYplyUyU6XHkwjcqRsohL9XRDxxFA7TiooFLFoMhL3uVeAQQR94VLVxn0Bks4HUpRhgIgMjCYBwstdDc4ELG7A6H9gWTdopgyXT3HqzQ2KtTFNUvM+0PEaTEmU9q0rosbn4msF1i6KRK2B8/O7iHvSWK/ZGE+5z02eofqWUMcaXtBTWmtBqKyU44Hp/TPJ8zwB3l/dfA059/cP8F5kw4kKB+ywYx2PDE0J8JoHHR6chPG5pmlF66NvpHg1U0lBgyyJXV7LbTHAvINCnc0k0wVKCSfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GerBoo9YYMKztWZljHsS0T5qv6yaH9BQiprdhoSYt/8=;
 b=ME442LoWTDyYkI1xghSzIW2QZtcooU/c1bDj4egwEw56uogamv7gI66qOCjdaHJZZJDh83bYNgQoDPlTvsqc1Dg9QRAtf95aIFRhJNlqBQRyhD3WPWVp7HwaW2y2RlCedA3yeXs/KsswdDKSfresElhIfdteMfvWHxm/P51yP44=
Received: from DUZPR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::23) by DU0PR08MB8066.eurprd08.prod.outlook.com
 (2603:10a6:10:3e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 11:59:58 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::a9) by DUZPR01CA0117.outlook.office365.com
 (2603:10a6:10:4bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 12:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 1 Aug 2025 11:59:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElQ0sZdnc5UffWF2D9rVmbYzBHhsLj2H+ZAP6cgioaZ4qPOPN23UOueNEtki5Mv+MfDxkFtYU+Yc/EgK7sWSCY6O2+sGKVYuEcsCSnMgkqJT06NgjGr5135eONwHD1OvD9BTr4eLQ+G0WymucuLoEH4ug1CTknZ519ODNBS1cWONmT2XlHWiwgxpOngRbpnHvLm7XJpNA5BxljfO8QrbXGxRsojRJyCgX1t2oish9NWm4YLV+B0iR1rlpLGrbZTe0+trb5slSejoi+y82HEvYCxzZHzDUAIRLEp7t6ww85L1WHen2zNdOivw0vQCQQbZav+dFZ7djeR6+sHhe8n1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GerBoo9YYMKztWZljHsS0T5qv6yaH9BQiprdhoSYt/8=;
 b=xaSA3GAwCYd71a5JGTTSXDOB7n1LKMFnxwMH1zaQIci1UmOYUcDHmo0QO8iJNNzMpXy6mpJS8D+04olF7Y/thQb+V/J+TGD/1Dy3Mh190T48czL4yLEirRkeiq0mreLD/27sVpeiFICKnytUzG88vOidK8FqRRaZ8fJs2/w+raikRYt97ItFoenyTyhDjsAPPRd/XZyvcVe9siPUMCyaBL2dVBiliS3tEXzVAc7Nq6cFt3sO7opcJqNh9eLPJYP9jrneXYiEMfIav0CHcbhZNhSfVafPOsMJiWybGF/AQO4GpcC/o4XHC7p1XJhVLF6p9aUtS177GAdOcHR4TF9KTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GerBoo9YYMKztWZljHsS0T5qv6yaH9BQiprdhoSYt/8=;
 b=ME442LoWTDyYkI1xghSzIW2QZtcooU/c1bDj4egwEw56uogamv7gI66qOCjdaHJZZJDh83bYNgQoDPlTvsqc1Dg9QRAtf95aIFRhJNlqBQRyhD3WPWVp7HwaW2y2RlCedA3yeXs/KsswdDKSfresElhIfdteMfvWHxm/P51yP44=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB10730.eurprd08.prod.outlook.com
 (2603:10a6:150:162::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 1 Aug
 2025 11:59:24 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 11:59:24 +0000
Date: Fri, 1 Aug 2025 12:59:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: thomas.weissschuh@linutronix.de, ryabinin.a.a@gmail.com,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: disable kasan_strings() kunit test when
 CONFIG_FORTIFY_SOURCE enabled
Message-ID: <aIysGSmWKIhQYid+@e129823.arm.com>
References: <20250801092805.2602490-1-yeoreum.yun@arm.com>
 <CA+fCnZdiwXXYmW9a0WVOm3dRGmNBT6J5Xjs8uvRtp7zdTBKPLA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdiwXXYmW9a0WVOm3dRGmNBT6J5Xjs8uvRtp7zdTBKPLA@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB10730:EE_|DB1PEPF000509EB:EE_|DU0PR08MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ff348b-e561-4830-d79c-08ddd0f2f020
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?0lWFv0Ygxr1r67WZutuOZCvalUGmnCNeb2VJAfUKRU0Q4f73QdN3VKX13mxl?=
 =?us-ascii?Q?rh6HINEpiG6Z42JeF6VqXVdsRqFZZRvPld/u7IfhdN3ioNEFdSeQ3avgEUmZ?=
 =?us-ascii?Q?HGJ2luo3F17WXFYAZ5At0ACLqskuF2dfgPOxILJr9OlBMbomSqhrI4sMttiR?=
 =?us-ascii?Q?ojb1PvuDlMpehym95ePxw7Vf4hmDmVpjY96uDPSsRvm+52Dn577DP3XAuceq?=
 =?us-ascii?Q?w/GQceAx31J9uoCXgw0E6wulZMPNGbFmYl5WbwOKbO+H0gZ0WqDtRzMOEY9v?=
 =?us-ascii?Q?dp7xZOUf/c72fb+lu1kmh7LwNqajxR9XWYssZyyV7SEew8d1+x2fwgxF50qW?=
 =?us-ascii?Q?t2Mkl+FrwwnW/4sed9VskosZ8Pc6Fh8MDw8rc9iQYbBorR8YCywEkl0JNNqd?=
 =?us-ascii?Q?7YvjpSdfhf7Z74Blnyt1zj70zZHsvhkKe9YetyA4OlYAGJzz8UjPIUMQEv5l?=
 =?us-ascii?Q?I4MogW9Y4FeBQ470QD+xAeoWzl7JDp6zj8lkzqzzelJqZNknW9bxNSG0jXNT?=
 =?us-ascii?Q?xW5UZzuBdrD0T9j/JL/tWXi+XhU9Ey4Dycad64o2zayegqCPT7n5KzgP155i?=
 =?us-ascii?Q?iuI4KsvSXEyiuV6Rq9vna+Q5dyrPNH+toT0YHJ/Dm4DnKUDWIXhDWUANzNyJ?=
 =?us-ascii?Q?f9z8h1LadCUN68HU35Wsja/i/tF84QX93Qkeafe+eAhlziuV7gK4uU8HSBS5?=
 =?us-ascii?Q?lBxRwh9rhwv5bAafZNK7a3LHPbMxoGkgS3qOMIoLgXZm8XOOzSOieqOndcnN?=
 =?us-ascii?Q?dn/pvCycVpLDIf7IC9hIlIvCVzw7H9sfsF/oht0QoCaz9Y1v0zIP3028nEgE?=
 =?us-ascii?Q?orUu2bjJ9bMtveXpI4NRq285Yfww685CWQJjeuy1IV87Y38zkeOJAGfXgwvP?=
 =?us-ascii?Q?J5TLDqFYmLxiSWQSWWGGeWHXIYDIdsdntH6BCVcgz3Xyx3S8MxS8GPUOvG3a?=
 =?us-ascii?Q?/I52RUKnWuYfXHw40dPzN76umZkDWQjyCJl5imxjRpX1NieEPfZBaFhegR4S?=
 =?us-ascii?Q?uu8Tti90QvwC0EWWvUsDzxnFBmZOotlGTzihGT1hoaMXEfsK3y+8TkOrYOFK?=
 =?us-ascii?Q?zHnXN5lKgA2IioYg3FafrXmrDAl+TEMh3LvPOCq/9/3IMA6XWz78XxmVo1wZ?=
 =?us-ascii?Q?glJtXY+FAiyOcttXRH3hOQHmlqX7vNTyueNOynHCueWdQDRqetuB6+fzZ/WD?=
 =?us-ascii?Q?FW0lBEHQOoMKuU7RCLj2wWG7w1nV4mnQBchdx7tAfU77xo0Zw0E6GYZ0EvAa?=
 =?us-ascii?Q?lXlGksJv4wZuA70/ecdB5QCPs6n0qmboVFE+F5sD64c55wILppzdvTxMj/ep?=
 =?us-ascii?Q?zEsyeiXxUAQpWNcAqQ/1oUwTA1B8yL+orAQC5SNkJlFXc3QnWA8MtmZc9LgR?=
 =?us-ascii?Q?SzFnE2NDt+YjPPXzAx7MRZP1JrMZEVBEfQFKFBoiGhRmMwcY9wSQ9uA5VSpV?=
 =?us-ascii?Q?VQsGDQ8MSQE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10730
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	795b1588-222b-4a8c-e126-08ddd0f2dbb8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FEjbiUe9u0gXS0+kNMo10/XemxWr0Bs9QOX7H/AdwZuKYCdCm0ZsrxA6dgo?=
 =?us-ascii?Q?PgRygpQe77V6TTzt/Vg/AoV5oRW32CFIsY8qjnEeWMFPPjbvm062vo16MTun?=
 =?us-ascii?Q?u9cv0S7GHE90waJys0s3HjuN68kcnir6FAhD1hYY0CB6HcHFd0yUSFBH+8y0?=
 =?us-ascii?Q?zTNiWSO6HHFiRy5tj6q1072b6o9VbSn4pamw7HHAEHHwfFG9d245MovrLm4d?=
 =?us-ascii?Q?GW35R5KjZ3OKVSmxAt7gNGQzpKWhs/SaIIxyvtkU+86CCBGU/kwZGsyYYqdW?=
 =?us-ascii?Q?F2wmp/2s/nYguuFhCCSN5uIrNVUQZfhd8LMUGUiCQGYDpIY0eeQMW8VRIxdt?=
 =?us-ascii?Q?ZevBv62Zdgt7mIZ7oMLO3yIdBlZ9TRRv7vaq/gjaA7gKiu3nh0mItWtWQnWM?=
 =?us-ascii?Q?g6y4EoQ0cySVqVB/5dvAQDZ06R5XcxhvHfltW/HJfNlC4t7BF6X1ESyem2oO?=
 =?us-ascii?Q?nfEYm14rbBf1tct6K0BcYN0pjoZzyCbl75WpjbyVLgskDx9GnztNkJ3k+Hxm?=
 =?us-ascii?Q?p3QMCnnrJEP2Oz8CobdUDBpDLCkggofEW81dbijXiIxt642yC8EdVui6jGn5?=
 =?us-ascii?Q?xL/4n18fS219UOSdE5j4PwQsOoP8A7fK1cL24PIXt31R31gEMFpaGKLDqzpJ?=
 =?us-ascii?Q?PELHzEjQY3v9lVoWI1pcYuyjC3vTc/Xom4exzCTkZFKydopNkTwI2menFPoo?=
 =?us-ascii?Q?URzR4rG8Ncjqw9fFNWaFnmjDpU34Tw1R3SmOBHfTdTUswsmGQhsV313YR7OY?=
 =?us-ascii?Q?Pi8dUFcWfxkcjrso3KZ4k/mwNPpCXjYVVq19OPPFQ3Sd4a/zhsrLjW9Xhjkd?=
 =?us-ascii?Q?6evDtUUgljNiYWT6Y6ACMKDeujHCMdQ3rjYnG7qbPffg0B5iY1mUsdEStzLU?=
 =?us-ascii?Q?iTE+vvBrEs26uUP3SOLrEoMaYmtOgS/vigWtThvKX8/qAVFdDhOJDexe46yj?=
 =?us-ascii?Q?N6sk7T04HdWVs0rugZjNwRh4kuF0TAbG8ALD82FAxaR7LXApSqfLEhTZKFdG?=
 =?us-ascii?Q?WG4XYweshs/Yk3lWw0064SGty2BvCPN7beHklGrBIEZcrEuLlFYKgR/zV2QV?=
 =?us-ascii?Q?Q1u9JpEvk0p/ZicM6qmYBeVjLE7V8IzIDyLDSiLXqKgiRo/6nq65IWUNLaWG?=
 =?us-ascii?Q?abtgikQU4ud3jMWn1nRHJmliqZcJXVP41Fx33YbL7NP9Nw/Fs3LuaWU7KJbX?=
 =?us-ascii?Q?GsE9/tvD9O25Z+CTyw91bm5Pg8Z86EshzPCok0IFCPahiWj6T6u545AfMrEg?=
 =?us-ascii?Q?h6TRV9CPiG1F6AplDHWeIYySpJY5JaS7QB/JqT/XJDarNtF5rOJe3csdlT5p?=
 =?us-ascii?Q?NP5znV7XvCRKX3limZ9GAKcQ820dh1Oty7+WvBvUMuhY4bvEnlwK5aIHq0pH?=
 =?us-ascii?Q?dPJI25XFK0ct40wpA876pmnuq/6aH0nV8o7QtrAA/TYVO2lCTuWxYy/hxYHC?=
 =?us-ascii?Q?npNPFKaLiwLff5iM2hA6gCfNXWOj6pSlIGpyoaK6H031+AfTom7184Z0bNwo?=
 =?us-ascii?Q?jAI1/sg4dORhqUlGwNf2mnE+mtq0qtWN+ULC?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 11:59:58.4728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ff348b-e561-4830-d79c-08ddd0f2f020
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8066

Hi Andrey,

> >
> > When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
> > triggers __fortify_panic() which kills running task.
> >
> > This makes failured of kasan_strings() kunit testcase since the
> > kunit-try-cacth kthread running kasan_string() dies before checking the
> > fault.
> >
> > To address this, add define for __NO_FORTIFY for kasan kunit test.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  mm/kasan/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index dd93ae8a6beb..b70d76c167ca 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -44,6 +44,10 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> >  CFLAGS_KASAN_TEST += -fno-builtin
> >  endif
> >
> > +ifdef CONFIG_FORTIFY_SOURCE
> > +CFLAGS_KASAN_TEST += -D__NO_FORTIFY
> > +endif
>
> We should be able to use OPTIMIZER_HIDE_VAR() to deal with this
> instead; see commits b2325bf860fa and 09c6304e38e4.

Thanks for sharing this!
I'll update the patch!

--
Sincerely,
Yeoreum Yun

