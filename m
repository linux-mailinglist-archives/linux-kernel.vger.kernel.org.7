Return-Path: <linux-kernel+bounces-756960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB3EB1BB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A247ABF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C4323908B;
	Tue,  5 Aug 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MG5D93Td"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA82E3719
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427291; cv=fail; b=tCBnSDKwXVddIM/Vp7dABwpmlw3uKyFxgoPUnaZFlth4iE2QO5l2XAIPefEGoBF66drIxeZsPcyzlUreogJYR1eJF5WxkDMsWocvIiJsA5NPGElk5jLdjmYBNBovMUlKqub2p2Zi2T3Y//ZahUnt/i7B/Dxj4zQBIw43KhFadcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427291; c=relaxed/simple;
	bh=FFwmAEVTovyj2Zd4D8uvGPAGlsCEUANXbKb+W+DVbAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OVGYRhWfxrzWtXBZbTJK+D7LRDj2Btmu3s8PA7idKXkOu/sN8VGbnm2UA0DxRXuGJXMjVWa1PWDN+jMJnpC2eFR334/u8mpVdMvP3jqSQwt+1TsUgvNo70xMjzr+zcYv4f1vAFIb/k9jF0LnSAvLH47GghzN48oRDnwUdTXAa+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MG5D93Td; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po5GC0DO6JuhKdURppQgV96vx+cHhGd6NL0m0lilq0KkE6jwuqlGSQ4/Xl/wiJ+cbYCFnPYJ+Pg6QmKWvwmqwPjS34Gcr4yUtLO3P2fWafIpKK9oMaAeyAfuV4wpkxUdd8z095Ej13KIM4W9CNtd6nP5XWAkdjmEIlme1IQTDvX3j9CHHqijymNe5lEW4svKHkZEJgiYsA3mtcQNFByNNPufty9ZbvSAJgt+672WPC8rOfwJknEYoVF37aQ4DylYvv6SgflKna+1fQXl+uMO6NHdAXLLG4CSUHJHIL3Rv+/jMZjknwl4lJdQo6WhsaVUGmnYbTv3cxG4hloFIlh24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQZRJoXAM97wk/Nr+Adr7BpxbKEy8Woy6mD9vxVgr/c=;
 b=OudVC1yQjiKBtjt7LFF2PMVGhMazkLygbsbDUfSTdDwzykJVkNtO7FxUBEyQdxRoJGovxCnomlz+nrlOk13FAlh1KYYeFEZtNW3mPCk+Jtj+ELBAwhbssffPKozLrq5NKeXzrAfJRR/CBswSpWGCUSjH3r1BJ+eENQz+16JfQdVTjG6IClImqmo7jNcLmbdcB/lVV5lW7nhc048esYsaNoGpGL/NgPH2UHzGtCeDkKS1ZBS872Y2sgx33eTQ1r90Xu6CnQvsvtc+2ep15WBs9cBub2PZoKUyiLRaSUigcFCegHU6ZTGt+prZIptqxbjLG6o1aJrJwjocmYvCe6aD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQZRJoXAM97wk/Nr+Adr7BpxbKEy8Woy6mD9vxVgr/c=;
 b=MG5D93TdCFH+90xHSgB6rxHatWqdvd5iq+TlzV+4wZjnok6epVoqZ1pTvD75jgYD7UnyqfWk7XrWaLbNs/L2GVBmwTm3bqn3hVKu7EUE2LgPq+cHTYF+2ujcF3Pp0t1NXA1qVKUhXtxXwY6+33fhoQXUOPBr4hQDhKao6CFK21t3fLoikoVUYX080E9wnrmk+/JEAQSILFyd/wXvQs+evl+Fm0fj6Iu5Uua2HIl05q8V6WWHOq236cunX/vmk/P1Alj1irZsgR492AWeBB0E2MeKyaqoFvFUYgmvsgCcynM9gtRqUyA2HjfZFLKmu94z50Cclw/Uyxxzh53RQsfZDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Tue, 5 Aug 2025 20:54:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 20:54:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Matthew Brost <matthew.brost@intel.com>,
 Rakie Kim <rakie.kim@sk.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mempolicy: Clarify what zone reclaim means
Date: Tue, 05 Aug 2025 16:54:42 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <080369EA-4896-4851-A784-CA60D51AD659@nvidia.com>
In-Reply-To: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
References: <20250805205048.1518453-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:d4::37) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa8b3f0-5039-4d0f-0ac7-08ddd4624e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vvKHPQIVexbhXwR8bjVgzH+jF2NtpDlRBhl0/Gn6vHLjGDs4oTdujzlVaPr+?=
 =?us-ascii?Q?s+L8JAnnJso44LB7/YrSAKUpgSztpYsx6DoWqa8WJaxWIGlP2mAHSgbrf7xL?=
 =?us-ascii?Q?K5vbMqeL5DGBJLssRQZkH2SEu6fVnP0CIcgyk7s4pNnTpOymvnAjC+Bk1W/+?=
 =?us-ascii?Q?CmMI09ovfO0Y9aYaW+c3oC2Gv4dPDvbFojv2rDtnxIidYeg72K/Iqw17ntjV?=
 =?us-ascii?Q?j4C+l5nX76tRFeCyVXv53/AE+SCAN/MxQaeulPKTHjYWM9pRhBlYbIPOH94x?=
 =?us-ascii?Q?ijCtjE+Fg0/oE+mddgkpil187GccU9T8Brul6LuH8cft8JEoi947lKrPax5t?=
 =?us-ascii?Q?sIKHJlWGhQTW6nx/8pA2igkf5xIapVd40JRr3zVBK8iVs83qBJVUyJNsgz+0?=
 =?us-ascii?Q?ctCQh2+nV41Jm9tgEQZZ8T0PT1dYzjm+7fjd9XqxPhK5OXBclJpkUad9Jxb2?=
 =?us-ascii?Q?BmN7Fow3fshhebyqpDBJ3aY5uSbcacV4vKxFnydFsyTDnC/tA4OeOITPPkEE?=
 =?us-ascii?Q?VZOv0kBBeEKAuTjGoTPg3ZXM0oY4fa49KZUPXbscFhxTgKBlu8gwjLYw7K+e?=
 =?us-ascii?Q?v5ZeINje6xXEwDgoaDkwUP8Jz5kxtdGnih3vAUtfu80bYsjDdq9ianbQDloa?=
 =?us-ascii?Q?bB54oVHCF5xFH5Um3X4u3mQbGgUeQusZDRyMKhi62GK66p7K9a4HKTF2qxkI?=
 =?us-ascii?Q?gSwMyzSCfcjfvUntgMNDh817WIUjwZkrLfOHgvbcUoFKa/OoW4gXWRFmIUqP?=
 =?us-ascii?Q?FI5ZahauFybI8wOtqaoYd1M37y8GwAN6G49KSufCZ8zB3IaXb6DaQ0yI4lZ8?=
 =?us-ascii?Q?NG2+N26wibY6SkYBKtvPX2hUi01UFmhXBxDmz+cjd7g0ZE9+KS1/4LQIIZe2?=
 =?us-ascii?Q?FOC1/Thx4gPY4C6VhbXlCHzP1WIKhCFXoerfYwrjeqn4u3b8kcqYKNenNMNe?=
 =?us-ascii?Q?2nAvplaq5WeJS//Bf/pRN/HeauoDuEB/SXuE6c7Tp93nHgRwIt/vesemaEFc?=
 =?us-ascii?Q?xRph4GtEtWnAATLZza4SqHDgdFuSXk/iiOG9Me1EAl/pAabeW22A6ErshIVe?=
 =?us-ascii?Q?puOm3Uev1l54DNCz+vILKGpZ1duWqPCPMdC3tPu1IGFEf4lgd2Z/MFC/Ix0m?=
 =?us-ascii?Q?7rvBugVht1mOPBK/bvSxRci4ytYPjp7L+xXSUQXcUpE58KwJbgnAvI/1te1u?=
 =?us-ascii?Q?jfVNqmYwcA1uo344CR3wh2uEWMM298OV76LS4kJteuvZKLaNs26mMFAVz59V?=
 =?us-ascii?Q?PVonzLFmV71+Uqp2JBuHui1NG4V5rYlVAMonZXACq8sMdPCLQRNv+5zlsr6/?=
 =?us-ascii?Q?h1e+hNTdCI+EwH79qDapCSonFvptCDw5K8O+aGlVHFRlWtozQa18oocdcBD6?=
 =?us-ascii?Q?+DKJv2rGRdY8vTT0ALBaU5tSsHjdvFIMjiE3rb0OFnVIoMKFXj631ervu8+c?=
 =?us-ascii?Q?j4TGa+Q/0zI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YiCbrH0/ZzCTJZVeabxO/xAH1TCDERHQlyv8/JU7u6x1Fv5ym/lgZrTnfWs/?=
 =?us-ascii?Q?31SsNOdFfNd4bgywE9zKMbF6fSt58roOI9mlyFLbvYJM5RzqI590jt58y5Zm?=
 =?us-ascii?Q?bVKglpgGsUyfYDDCmmPBAT+LIeogmFKgpz0AdR2r1xlqzr/QZKjPdRZs3EnM?=
 =?us-ascii?Q?bZLSwDIDd+QixB7g9DVL9SizOfm1QAXVPTtEItpDj17L0uM73/9mpbf2dcLl?=
 =?us-ascii?Q?Vgeigf37pQgNR757RSGGHvxQqXnj1W1oY41NspVET/va+NccgA3qgH5iSU0w?=
 =?us-ascii?Q?4xI/BE1N2TSP/xgtPfr4MjSk7W7lwMnT1rJv+Q4QzlH6Bz6T3K5yNgXJnVKN?=
 =?us-ascii?Q?1tFuVUe+renPQ8bf/eTGIxWhcjXExpi4K9+m9tKbZpDXmvsMyBS2fWVUIbjC?=
 =?us-ascii?Q?TCh5W6LDSsc4/RxctfsqU9nOuhaV+vw0M/SzcS9sq2NeKDNtQUi6af9g4hoA?=
 =?us-ascii?Q?lOKWJqp3APIiKtCqiD3eMbcRxRuL6gpKf0EI/QaBdV871XDSH6NcYX7sOcyT?=
 =?us-ascii?Q?WPFXsMsd84Dwqsav3BDNKU58EAkMwlzL+NgChl24E2XZYlX5utHKivCIgx1j?=
 =?us-ascii?Q?Eoc8vanaigDfgHCWP5C9OrNWFD/PNKU2tt1r7aq1TvpOvETQ6W8YfM5+09Oa?=
 =?us-ascii?Q?TF8TH+0hC0sU39iQdd0IORsMTMWXJQ2/0gAaM6/5u6W4bc7x7LH+AKj4V9rm?=
 =?us-ascii?Q?W8DxkVK+DEZJdB7ErPXFGpXHySZZPQml6qg0qQPt63cmWDPu1t5UAH0y8uyR?=
 =?us-ascii?Q?uqruZpyIABV8tiVC6SpWgi7827pKf2ZGQvaD73yHc4H7xaaViG6HepPRG6IT?=
 =?us-ascii?Q?dwilF2EIIGewP7lu4mn/Fgm12EigK+XQFLIE/eQapM28QjMrQ5mjZxZOIwF+?=
 =?us-ascii?Q?QtHdJHlWYNANLmSGuALqkwXrXTa5Goik6b9ln3IRtvbdL3bM0jK+r1JChUND?=
 =?us-ascii?Q?dMv/efL90wWbWbk/atlYuJ7d9e/FFWZY+pROKQ1Wh8keqSlaRfb0xWG4YWV9?=
 =?us-ascii?Q?SJxNALxfoFf129Ri9AGIcUJd5mrD4uaVxU8pJOyqpjQpV0/aZFLzp2Fa05/6?=
 =?us-ascii?Q?5qorEhBQaYDK5IwFAVLSth9R6ncW7d4QLGn4Q2idQb/jutHxpEaWhhlUg2fn?=
 =?us-ascii?Q?1nLG8SDVfsI97EiMC66V4WQ3y+5gJuVDGKBwGWn5rWbZ9ZdmNu0EbbYRID9c?=
 =?us-ascii?Q?KFq7aT6+KiO3ogw8RISB2wcfK9iXW2JfdGUCtlyP+zYKsTqFGepcoql7VXhA?=
 =?us-ascii?Q?goQpb2mozVZjhwWLdn92icoQKZ7xB6KAjUNyzh6SSbsREa2GTvo4JfJUVCHi?=
 =?us-ascii?Q?kbhiOaY/0rednyMDyl69I2jj2sHXMa+zfxRpkRcD6LsRUVVhHFi9hsn5pgEE?=
 =?us-ascii?Q?nqKkAkQF595h0bDpsOM6kD5utsrDYfDfoBpK4Az/lPXbm26TnusN8Kz468wk?=
 =?us-ascii?Q?7B843rMzF5RR4Q0bhCV8lHaMURMloNH1FDygD7OD+OdgkA3mY5aCXeJxAdNL?=
 =?us-ascii?Q?mGY4+ytZQe/q0l4UAHuvnNkLf0Xs9fdEpPLC4mEiE5ozuafafNMrb1TW9+Yc?=
 =?us-ascii?Q?wBRqfrhVTLB9OUCMKohX2rfOIhn+c0+OPCgYkGVb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa8b3f0-5039-4d0f-0ac7-08ddd4624e70
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 20:54:44.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dXtU5l4yx8qA1Gxp2Yr0rBp63SjopMfAjlJS8Yxug0jQ2Fan/EWq1XYTPdmp+IJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On 5 Aug 2025, at 16:50, Joshua Hahn wrote:

> The zone_reclaim_mode API controls the reclaim behavior when a node run=
s out of
> memory. Contrary to its user-facing name, it is internally referred to =
as
> "node_reclaim_mode".
>
> This can be confusing. But because we cannot change the name of the API=
 since
> it has been in place since at least 2.6, let's try to be more explicit =
about
> what the behavior of this API is.
>
> Change the description to clarify what zone reclaim entails, and be exp=
licit
> about the RECLAIM_ZONE bit, whose purpose has led to some confusion in =
the
> past already [1] [2].
>
> While at it, also soften the warning about changing these bits.
>
> [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-=
alex.shi@linux.alibaba.com/
> [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.i=
ntel.com/
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
> v2 --> v3:
> - Fixed typos
> - Softend wording from "never" --> "should not"
>
>  include/uapi/linux/mempolicy.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

