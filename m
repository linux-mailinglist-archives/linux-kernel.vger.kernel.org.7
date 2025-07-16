Return-Path: <linux-kernel+bounces-734134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F1B07D73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A927A3B3AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143729A333;
	Wed, 16 Jul 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jLrR1u/X"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A32857F1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693247; cv=fail; b=uTOADOyrdQj5Vo+GQSUQZQszNXpzJb9d7uIzaqR/r7pMwb8Q9wiziwv4RiELM4q0pPgsd9pFmnJfiR4XTqvgOWqciaoDneQOPSieeWvwvAyaBkbGwk7lQOqvVzRYx/QO741p/AcTCMRAXjYlEHGD/jRLs/k1pThkpl5U9cSUk18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693247; c=relaxed/simple;
	bh=ydpSLIP6eLdYgLLrdzs49/ajsBQmBY3yVHiLO85lvdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UevL7rnsM/lQEEwXJ0y6XWCbGTX7/yfAHsNX+fgjBX/mqQMt2fbLw+0C5Irzz9QjDAOh5BH+YPbXLVWTu5bhxa+UXNv/GWi5GNlWOoPnJz7U4mEktfw+O3kG/VTWAozbhoFpYZl6NO9/9GLgXGJWn1WqMS6JG69Tg6l3NoC4At0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jLrR1u/X; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eo8DeQi9Z+QPVQOsZb43V2ekcZpjsHZDJQrLBdFg1s2iFitQXaefWrC6D4o4EPOkHHPRIxg3wxulcIrK8jKp5uhYsM7f4n7ksBFStOPgC4SuGGYLCPOlN0KHwL+E8eDOO0ZMSY2n/St/OUEEoV7RlFGYITrKmd0cy/YbJHmuMC+Sm6BaD3PPSrKcHpRHq0pSRufmKbcmHfxXH+0DUpWRvqoNMGcPEgxgYADlLmuxr3Edas5J32hrCh69TPHFXibxpJowl8u5Jo/rVknTMaB5zYZ8AdAw0v99ilh4s88mYEh7p+KbhZgC3xDP6FLNRZzmt8tqiMFPu5ZTILjtb45+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydpSLIP6eLdYgLLrdzs49/ajsBQmBY3yVHiLO85lvdc=;
 b=neegwZyuy0Mon0FlTEx2XK3QRgVCCG/1QeFLYuGk+pwIxilv946Lb/jSQmOy37gZP0syYDq97WL0oJXf0uWrvoVUPoEKmgzV1vfUrn7NmXA6y2vXUpPqeuKyzbUbFxzZAaLOB8idFVxfldBGJgn6bloR6d8BHsd/nekhQyewxy5OU9Vw5pkw0/Lsbrp9LpcPkt9xjZEwL+FXCZ0g11biN6Rg9RkdpstelA7ROndZnIraU5Ql7odRkxp+ta3TQfkkPEWbDOJ6D+HiVfKRfzxrDrDSo8nTUwzunRQozH66X7VXwm45/DVqz4A5yo0f5afv/xyzRcMdHpK5r6tKRJvR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydpSLIP6eLdYgLLrdzs49/ajsBQmBY3yVHiLO85lvdc=;
 b=jLrR1u/XUh/u+3+IrG2ItHFvJHnHgQpVE2r693txDMOg0F6emEJ0/ziamRnfDZc35oXO47AV1rSNo/NlSn67XXk1MdW7hmWEVW/zi6pD5bl8jbxIVZM5/9AVlcFauX1JJ7jwkUdk09mcF45MnoJyUfnxsx5baLa4jWcxoCwjGSMIhxvuitYlbSINz0rbWmf7bctIPv4Jxecr5HDdidJl8zhFn4yO/nloK8VjWWsPiCGoHBUIEKqJnDWH2UrPvP38pp0ZyvyK7Lmpq8Ym3LKq1znl3WIeL8lQqvENfqK3Eknf9iX/eHpdSQ98t9zc7H/n00kfiyLkN/GrjlPm5n1Dmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Wed, 16 Jul 2025 19:14:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 19:14:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Wed, 16 Jul 2025 15:13:59 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A676EDD2-55FC-476A-8812-5C294483063F@nvidia.com>
In-Reply-To: <bec0d00b-1284-4d45-bd42-f3089898ff3f@mandelbit.com>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <bec0d00b-1284-4d45-bd42-f3089898ff3f@mandelbit.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:208:234::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d063a0d1-926d-4b6b-891a-08ddc49ced14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6T/aqsB5CGkNzVE3NXS0MGDpE+Er3ryG8EcZgljWVVVQcixBFEocB40WrIZb?=
 =?us-ascii?Q?00iXgmcQO8M6r5ztPyF0yEO7A87wnNf6N5tC+kQaObvJoPLMb+uLQuYWMBlG?=
 =?us-ascii?Q?cRzBF0yPGTgqC5z1m4q3JZhi8qdjYLU1+kl7tji2xwtcIIG4lenjms3x/b6i?=
 =?us-ascii?Q?AlXWkwBWB9B6sgVLmvWdDMP1DxCLTMwz/KPZAp2Zut6knPp1/fC8GJz6RrQR?=
 =?us-ascii?Q?md8oGDq8QfKbVcLPuoUwnmS2NYvIhVDfDc9z+LSPBHpSQ25XC8PSM6TAi220?=
 =?us-ascii?Q?u+TMAHyNBGoO4OOe3St31eth988hK7FY9peRKUeTfvpcA/v44b1XiWrEFsr6?=
 =?us-ascii?Q?AreK04pqbDGawefCeZVBM3U+as62+tXh0m//ISQY4A+Ngc1e+ykx5cVmpk09?=
 =?us-ascii?Q?iYbDi7GLiCJzbS6ZVxJpH4/lPBp/nitPJVd5jidfsfxWTrw5gcEWKuM6HstI?=
 =?us-ascii?Q?8Y7T2BBJf4iSjKS2YXQBgPeB3lc0/30wUu5ERNCI7uGLcZqroOqr2vil3pps?=
 =?us-ascii?Q?WvedZckSiIB3AiqcinMjDR4yYzPqVX/wjx0VeDcPtQPz+oB0IHa/OfaOz7bi?=
 =?us-ascii?Q?tPO45VZ5mfEVaj78cBXuJBO0tSnB1GzrJvfgutuMccAcHujxcCb+MBiu6XLf?=
 =?us-ascii?Q?chA0jeIaY3GcJCxdeow6DfTLxqzxMnnz4PnkowHWSHSZnmC8EQHi0iH8cn8F?=
 =?us-ascii?Q?VqxRi18pfFC6NPhRZxANSNfpZged2Gr0s34HYl92g6PBJbaHvn6B2zvusMx1?=
 =?us-ascii?Q?iJ0ItCSkLn2tC+VYRHuSPUrhKH0rNHF1dBJUrOl3fn9U5l1wePWTtPFYWHEF?=
 =?us-ascii?Q?o6qqbBRR2L6fvGc6G04mptbHCpy1x8lt014OWNP6My07WZu9J8zC+DCpLoKw?=
 =?us-ascii?Q?rAqA39xXWvh+HehfRJzoGWOJUJwYBr8o/xOozhGL8Hml1t+EgBRLDJIO+JBY?=
 =?us-ascii?Q?eF+fUcpAC6Hw8qRfYD9+HTllhfnW4ghSxiK4FiZyFpKTkNwzO71eeaqsLWyt?=
 =?us-ascii?Q?rYgOYIM0xfTBymtfqwGzirblJfqjLJYmVnRnMYZA+ySbeH/WEKzX9O0W2XuB?=
 =?us-ascii?Q?3ny1ferFAFR5iOuZy+owLL8Ri6tXUO57qh1qVTlD6QS4MQEh0mzUtuWn3ztO?=
 =?us-ascii?Q?xIo3nI2k2TyEVVAShI9o0lMYbcGr0ESCL/E2bqs4KBZizPHcS9cOfC87CMO9?=
 =?us-ascii?Q?ZVTl+bJPFq90u0NI8jN7JGhiDl1G1lI6mwlRY2+9PBRIJhNFUt7TGen9+fsM?=
 =?us-ascii?Q?OUt0PkNswq+0MeFoOOV9lxZi5e2H6+gDweFgj1I9WXmQoLfkP7qA9vpeQolg?=
 =?us-ascii?Q?lFL07Vng0g503dQS08Mxfv2D5Wbt0bwZ6Q+i/+q4kPnim/YkvpXwekdGABwF?=
 =?us-ascii?Q?a7avCqbpqBCRRueN1vlsha9FpvI4CE/ZKX1oRvatEOzMlwjB3wiXMlpUKZUu?=
 =?us-ascii?Q?/XyGXRTAIIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zhJ1qyzxhJ/jCwGpsIfLsuTuWcGd5+go6BZWNLZkTeYcvOJpVqo0LA39rhNb?=
 =?us-ascii?Q?aZ5T2VksE0xUv7oGpBLgDv0+imQIEMQbbdK9gqpYXYFk/0rXl1wgnoS+HORv?=
 =?us-ascii?Q?uEBLF7zCwx22VgcH2NQ28hoRRoHyAzokTfRvQrETMNvMOqiEUU5BAwsanxFW?=
 =?us-ascii?Q?fwC4E4RzrYrXsKyrM34nZhQrlBKc/Z3Jvds0NpeTS1+D5zaSxasDmb6hsFG7?=
 =?us-ascii?Q?DymvMhsdGuhJtG41IedoJvzRKFoHGxKRx2FQypAOvk2PvrjtK/ASJyA2ZxfP?=
 =?us-ascii?Q?RBwkCx5IKYJqpcDoVx8FA6F6znT7cCOfCbnrZQCs5GNgeXY289JxCqT8dv56?=
 =?us-ascii?Q?M41m7FOhtjUgHxed/DAVdl4Rs2b9voQ8LOrAqYPh3nQuIVAvizmrX5efrNpv?=
 =?us-ascii?Q?wggMwNB7WMQvtI3hGgmwncYLqdBsOFBwg1urAHll6WxNDAKnSc/9UPZJ5gyR?=
 =?us-ascii?Q?yML82uffpX0V/BBMGg0OLvlDVXEO1oNeM5NQsi+DSmF0INM1XEGIfjDCldtg?=
 =?us-ascii?Q?OS9Sy5nwFxUM7uDvEAxKT123/szzARn9mYAIM7yhj43LkPBJnI8z6xNxpp/v?=
 =?us-ascii?Q?rXNaSEXjxrULxsqB+V7ASx5Xe7adZMUYCr9fUQWhkuYWaGgmHZfhm+GmJrCm?=
 =?us-ascii?Q?CcRik/C5d9MJucWP34a/vt9PHjwRH4GoTi2taGdQmVwtd7auHxBet1leLaVO?=
 =?us-ascii?Q?Ivs8pVOhmjsxtJxu7rEMc1e24DNUOOcBddbm6FKRR6sbmEsA+2n/dXBWTA1H?=
 =?us-ascii?Q?Xr+t+aLnXT7bcH6k9dGcULGqjyJxlwEPxphL+np4wEsK4saKLRuP0ZdJ1qx+?=
 =?us-ascii?Q?cqWO7BpTSnvAoWecSP3NahYzB9xnb+NxfEfMsc0KfaxMH1hsBbsXpKckj8K9?=
 =?us-ascii?Q?Pm+6Vr0PeFznTptffWXcYk8uYXDeS5cmWxYU6CJPSH17WZKUo0UR14NBNO7U?=
 =?us-ascii?Q?pROLB+J0WBGjdKc0NMMyMIk+rlqxLMXdEmLGGjOgsetV8XG+VWGT4IbTY91q?=
 =?us-ascii?Q?s/tbhjo3k59W9te/ALVJiHiItcb7a0YdEFDNpQuWAVO50Smp9n1pLZA2NJxN?=
 =?us-ascii?Q?Levy0nQuqob8EVpuDad9jt119R43OCWK4NvtR+AyZmTe0rduIghPK6WIjzyO?=
 =?us-ascii?Q?2T+LDDTqveDa8wLAL3jhUZsjF0YHHhtyv6IeP+FHlWbCpmoOnyBsESThlpnq?=
 =?us-ascii?Q?Esq9J/buZAH9N5/vIJBAam4j6FzajdlQraiibGMYbeoY1xh/KirQC6FEGD9H?=
 =?us-ascii?Q?6CfyI8Z+I8XVcWNSPl36VcOxTfcuFnfHbbdTZXeReI/wMQCPp7upUgARBfcZ?=
 =?us-ascii?Q?1FEPQwUBsDOmP92FNr/tGK3zzkl1zUGLr8tROyILMZIkwJ5b+lTkJGGqznJ2?=
 =?us-ascii?Q?02XdWozeM9LMgXmO6piNblMNhHOL3zbJDyxMqqfexXT6TsU6DuxdXvD48k6w?=
 =?us-ascii?Q?WX81CrrgGktqIkS4Nq8kr0gUnB7ZeE+29F2lAFRw21lTzVIEKCQHUPncrshO?=
 =?us-ascii?Q?Lw4zsJpxiAcrPkynO82CKlo3Z5vzRRCbPhXzBsHBX4qWnH9jpVUHONy1W7S9?=
 =?us-ascii?Q?B7A7dWzpm9LulnHE407v7wte2Cw7BzciGDBUhDkz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d063a0d1-926d-4b6b-891a-08ddc49ced14
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:14:02.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOY116zM0cPMaEgziIH7E1EAPCDrGbrEXclzPUCMsS7pCzxMqj2U+GxbGur9kpzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

On 16 Jul 2025, at 15:01, Antonio Quartulli wrote:

> On 16/07/2025 19:11, Zi Yan wrote:
>> Smatch/coverity checkers report NULL mapping referencing issues[1][2][=
3]
>> every time the code is modified, because they do not understand that
>> mapping cannot be NULL when a folio is in page cache in the code.
>> Refactor the code to make it explicit.
>>
>> No functional change is intended.
>>
>> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f=
4f@stanley.mountain/
>> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb=
642@suswa.mountain/
>> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mand=
elbit.com/
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Much easier to grasp - Thanks a lot!
>
> I am sure Coverity will be happy too at this point, because the ambigui=
ty has been fully removed.
>
> In a previous email you asked me how to prevent Coverity from complaini=
ng about certain code: my thinking is fully aligned with Dan's reply. IMH=
O refactoring the code was the best choice - thanks again.

Sure. Coverity/smatch makes the code better this time. :)


Best Regards,
Yan, Zi

