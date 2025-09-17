Return-Path: <linux-kernel+bounces-821500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70EB816AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603311C27704
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC3288C14;
	Wed, 17 Sep 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bs9evD62"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020132.outbound.protection.outlook.com [52.101.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FCB2FFDE2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135853; cv=fail; b=rI3kbS9n+pcBqnJ57gzvheftWzYtSrLyD3cVp7vw6jl11h+xzpD+wmvUy4mEGFHzt+PponxQcim8yiBPabgzIPLE+3mseb6U98mCRZLKXNsl+xgl4HXgvhiz2H1W69YHi8IfynZyy28cnbk/2R++9iirvmdkbB9G1iRWJ9NvEp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135853; c=relaxed/simple;
	bh=A2Ad8Abkv8HInwrwDcmqge951mXdINyBnvmB1zUZ2xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8X1WCZvxYqA0uFah7fNgKOJxlw5/O/uFA8bUEmDQ6mc9PE6D7rAEX90NvJTb+Fw0gMAqQfXqJ0l2zgwC6QZtxEaieFNN7MK/TKR5aL2TXGD7iBKMSxxHdXQnQCKWyOjpUF7fnhSa8YcVgVThz5ESoUeT8zlkt36hkf0h9+QA9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bs9evD62; arc=fail smtp.client-ip=52.101.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5A4hEpYcbTuYpW3zEJJTj/AjMVSCNp0tDDTtlC1cN0DkWo7CMxLYyOUEdOH2OnaGsobBQUsztHq7dhbL11T6SSQGpSixFO1TqWuBc560I+CCw+6aoSVItFkyssOafDd8b6MB10kiOftJ50bNnxlPCALdsuABoyapwdAOIAmqtXrqgdTf+7YciHFPpitcwfzpQuKr1PmUVEeHP74PUlFTkHbhbAA6ubUhLn5KooVLrieFgFCEzDkBSg8zbqP4RdVv5ZoZhHZ1C7rIXW/2c05RIRQFar3UIyC7rWPo/pP2Jesu6giP7cFD0cpQmcD6pWiJq6Wh3EHaratT5YaLsbfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXh54Be3gTyU1t/hTfMqRaGfJ/Y/mGCpnRBAH1QuTC0=;
 b=NMeWIMEC9tamfuMNOh/shSgSiJCTQ/E5vBDXpzP0hNWu8Gf6aVrQXbWOOWxm9NlUZGD9dlY4xyjc56MF6H7YVE56G5p+HyEL1l+uJFobFwsb54GXzfKkp5JAbeCNM0jEAMZuB21g+BoKbkFWuF+NmzSMJ792uVcV66/lt+YMlURPIzxd+hdBKQZKmI6jklLo8ebn376ncG9AeEDPq24o4xtLtUZx8ExAwB8QtY9yaV2KFCCgLhr6AMQQ3n2GtznENP4K8FAVF2K7WOsodg/8X8CsxAKE8Q8Pk8Cth6Ux63hkE+s8clQyos78IY5Hulh8ZUGLHuRISqwTbTBlAd4KqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXh54Be3gTyU1t/hTfMqRaGfJ/Y/mGCpnRBAH1QuTC0=;
 b=bs9evD62m0zIFjApwQ+7uNMAc0YphtUesjVfD2DE1j7s+wyjBAffW2Y5OtzRRlHy5JpvzG7c/PgPWkrm4vvhBnO7fDzEUH8rSbKWq5gyqjdj8bAFRmAT3pNUem8tIu7vtk2nRU0DklEsHlQgZ9z2Kc+EBo93CiTGDyrD+CX+L6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV8PR01MB8429.prod.exchangelabs.com (2603:10b6:408:189::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Wed, 17 Sep 2025 19:04:09 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 19:04:09 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v8 2/5] arm64: cpufeature: add AmpereOne to BBML2 allow list
Date: Wed, 17 Sep 2025 12:02:08 -0700
Message-ID: <20250917190323.3828347-3-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250917190323.3828347-1-yang@os.amperecomputing.com>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:930:4f::16) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV8PR01MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 588f9dc9-d12d-4a0f-8d33-08ddf61cf8e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/DcPtZetTfQiqrtC2k/HS2Ceuog/Wu9b+VqXQK35siMFYat5lDPZ83qu4VZ3?=
 =?us-ascii?Q?wNYrJmrbd472HmZm59K3e1ioYW30cGpiNuRUiVHApxg2eIHD+DmXhU5b/TRa?=
 =?us-ascii?Q?A250F6IiU59paWsOHGtmXmqqaYaGrdQ+26zLtgsbGYtsMXiryvmOh0+HTBKd?=
 =?us-ascii?Q?dGURHUFHmMpTk7uWnunqpQBVTi/Gt4L+OkhUHxm52fc3wG5NXLZgL0jwOZwE?=
 =?us-ascii?Q?SxG8KlOYi+gFI2BjszVPB35NEKPEqN/vr9t7q+Y4R25OUxu+2rCpLfd5HUyX?=
 =?us-ascii?Q?9A0rX7oyYicUXenybcWrWclKkVM8AKgdmSskeEtJVA+8Ecs4baMDn9WnjX9x?=
 =?us-ascii?Q?kvn7SkYWN3oVa2ecDrMLwZrj/6S4sjbkobOF1KCVt2etP7miUe/cEiyDccS5?=
 =?us-ascii?Q?IzIiNG+ONu7VAsYDQNwuLljbCYPnDMekxW+3lpY2hRmx3YZ6M3tHU3ACunZH?=
 =?us-ascii?Q?z1SJvd7AiBYihPDxO1NfF75BoVgFgGM8/AY+RmyP9rUH+ddxguMOcBwKHqGv?=
 =?us-ascii?Q?+5rj3Ak3J+Sv7OWZ+vGEOdcp5mnXUMVQCJb3R8T7TJRh++amEdh6FD5agwRs?=
 =?us-ascii?Q?2gYuYReegAuYN5TipWnKozauOOnD92RpuDyQkGiC4pZhP3Fpox5npAvb1gKp?=
 =?us-ascii?Q?8pXsl/JJibwvtKDBWZbtSeoSpidTuqmfIKUqsiePgYaXOq2hpUIW4gkfw9l4?=
 =?us-ascii?Q?+QRmDF2tUWV8B6QdNsXCV0Q7HAQGkmo6u8vljppY+Jbc6awlKQ8pWp9oy0NI?=
 =?us-ascii?Q?XRqRBuL/knAo6e8oERnMDhE8qincrg2dn+ssc/IQRwB6Bw1KSx87XhEIppTb?=
 =?us-ascii?Q?EyWXVY3a4i8zroTpyW6l0SWU5aChjXvpUHlGfOES+7CXOZ6i7IKmyNEufaMm?=
 =?us-ascii?Q?OzoCJkhGPPY9dECN8TizLDTmLqjXwifGY9GQFVRwYx0gfg6D/tp6tRB6qQV3?=
 =?us-ascii?Q?Bab3FHBys0VVAFevctkuz4vZ4fvxriqUNK+bY/xOtDxkIhbg+VWefyxmiJ3O?=
 =?us-ascii?Q?JKxpj3ambUWp+BEYzfdcDjyZJLkF52bo//mubtrTu+avPdvNbJbe97hw7Fdw?=
 =?us-ascii?Q?8LpvkA/4Js6mAUdk07qjJqCmUcioHqxI0eq1hPzi1I42cTybOHNVAJkJtX9b?=
 =?us-ascii?Q?Y0waVQgamDtdOJ52tyxknLrhmpc9JArxh7wGeG82+k3H2znNZSX6WGyUUQph?=
 =?us-ascii?Q?s41z616VOYZDMIkglwCgh1TnS3eumgxK6MROdHYSlFFxc64BqIJ6kGF3/FU1?=
 =?us-ascii?Q?WmuDO4GPwlLEs2JuCxNbjBTvFDLoRdyE+En6r97L3BexRHJ/rP7dZ5PHMjqj?=
 =?us-ascii?Q?H9MvI0u1bSpRNzr7itddHGpHr+dumBgGvHpHiH3tXtOoq5B7yLAcflgMaFdL?=
 =?us-ascii?Q?OeMXCwLCv+u8J7ktNnfbpZ0W6yAVH9xaIILpjdwhbL5d2BmcxqyjgmtFvnBS?=
 =?us-ascii?Q?oUwkqHsAd+mnmyDuAmLfKl5RoJqroHCT1L0QFv2cWamfCK4pGGzYyFzOmDAT?=
 =?us-ascii?Q?gpLGfkbZDureSEc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/IM4uC4bX1J50jvU5a883V5Kq0hwSm0sO8Qdrynct9QPGEKeiKx2f+3pu1x+?=
 =?us-ascii?Q?GRVmhOAY+dh5nP2DN467m9gC1UJ4ktu0wtDHFdzS99fPnlFUcT6GIqz88Ebs?=
 =?us-ascii?Q?p+aElCRtW71x8mZv4d5WIpLFY5RGVSktWDjgNWv0xpw/z9woPQRcSnTeFSSj?=
 =?us-ascii?Q?Fkzx+CsGiyvSlVQcU72/WpZEVaLoqyuwdWurrCKjL9uO2cjhjOI7nxRpU7H0?=
 =?us-ascii?Q?MoUpT8OG6tHnt7LcnJmxtnAKIEEqDgL4IkspQ1dQERzkZc5dNTnQkMHuxTdR?=
 =?us-ascii?Q?cHl1chcGjRFVkkz4yTH0LmU66WdMF6yXUcGIqPtlx2wBJ+cKb/l4XDBytgFh?=
 =?us-ascii?Q?xJP4scOnR7yU70YY6NO0imuiSYgor0RTL2G0pp40w5oz6KRacq1IlbyXQU8m?=
 =?us-ascii?Q?+dYnk4jcngOXfrGFznDudAOQtJzq1uFr0jeuRjaIzpPlwgptOIyD4f+mriwJ?=
 =?us-ascii?Q?X/FVe4RijH7Al5qk6Tz+/EYr5wIzbV4UqcxkFuK33g7PWwRNcTeSp8cso3lr?=
 =?us-ascii?Q?Blzcv3naMjnifn3/ebj4j+XkXU2Au3+ZR011qMu0VMBy2R7Kn0Q2V2SdYfC8?=
 =?us-ascii?Q?R02TzbT5iOse/2wAZc+hZ24SVIbDYsclBnYjtFvVUeoQqMFlD1FuC2q8ZKp2?=
 =?us-ascii?Q?p8DAb250dfvBoecsFX5nAZX/FS9Iz/68g9kh+bkEueWBiElFYg9p2GAWG9CS?=
 =?us-ascii?Q?7xLL6B0ROLoC2QvhkH+hk+fkU//cCeNGtmtFf1Usb9HFR8tLalErHFvVQqQn?=
 =?us-ascii?Q?Sx6vu4cyQIir7Qg8ES3BXHAb1JPxoBDT3Ce6hOV7aelL/QU7TR5whPJBCWXJ?=
 =?us-ascii?Q?9toMTspQ8YxslnIf03I7Z7xFWhifPLNJSLAcB1B9FLO3GhHg3pEt6kgFMaZI?=
 =?us-ascii?Q?EL/PokCqivLf5kWag2pviwMd17ERizuMQSBn03gQeFihavJoX5ak1/NVGS+D?=
 =?us-ascii?Q?uFaCbVO1XaHOiuPbhmE2yPi5YM78MjDeLFqWP6NYw7fLWD1ULRJRfvb2My2b?=
 =?us-ascii?Q?O4RNyvrxJGgKrsC+mzImYYmyo+PgJhjlXlmqlqw8+WUqhrBxOgeNREVDHs9M?=
 =?us-ascii?Q?KFVh4Qy4rG9+0SyqlvGuxAp8p2AqGx1oUZMf/pp9301Nh+Jh8xK8yxzigViz?=
 =?us-ascii?Q?jSzWZ8Mf8cAXX84diwp/e9XJOhlZwaM9xTyvDGYlzyTRMoI2eUq+Qxfk/Yey?=
 =?us-ascii?Q?EoDSltGQ3ALJWzHoW1dtWOBjHu36rGNPAMThdPQXF8XwePdcadrcgUfk4J9B?=
 =?us-ascii?Q?0mGaX++9wUHbHLAlbNLIudj1JIe+jMGr90zEGHd3++1C54tSp+DGu3ifKFuz?=
 =?us-ascii?Q?zBmx84AYgmp0HjE1sfFI34jACrayEeKKuHTZ0kGnq1uxxMQvlYLBwAiZQ0Nk?=
 =?us-ascii?Q?i/WPrSD0uZ9OfygaZJFfaMNN+EbJOJveH5E472mKlkQDiXT9ftEyQ3fN32ml?=
 =?us-ascii?Q?YpWB7mObNYjhURa/jsp9liidFo/YJhrWWdJ/DrTGNMkgwOpGGsnD0l/wkPLo?=
 =?us-ascii?Q?NAn+0kb0BGtSUMkfVlz86HXmZQOtedQlDCOp96cUeKkf+1lZGfYiEn86JCjP?=
 =?us-ascii?Q?VZUhrNeiAZxfnS2CWer1CxZMC8fJzkN0Vo5OAJ0YfIgUsi9b6YXtOjhJM2sI?=
 =?us-ascii?Q?TgRM0aKv95SpwK2WS3kjf3o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588f9dc9-d12d-4a0f-8d33-08ddf61cf8e3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:04:09.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6gN9tXXlvBanIQLcbY3WOguwznL9drqS7lKs4R92CRaV35xNhAHnIfUeuuJe8M+BuBAq2RXGN+DzUmhpnu9ujSDu2PG0J0EGia63qG3lbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8429

AmpereOne supports BBML2 without conflict abort, add to the allow list.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/kernel/cpufeature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef269a5a37e1..ba07eeff2a8d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2235,6 +2235,8 @@ static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int sco
 	static const struct midr_range supports_bbml2_noabort_list[] = {
 		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
 		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
+		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
 		{}
 	};
 
-- 
2.47.0


