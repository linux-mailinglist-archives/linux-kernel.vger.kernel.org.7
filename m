Return-Path: <linux-kernel+bounces-727834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D7B0205F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3287B7AD3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBD2E92AD;
	Fri, 11 Jul 2025 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZAgNAfA"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05418E750
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247522; cv=fail; b=KWuEVfNui0yC/zH4PeC78XFYW6GfdWEs2MxWLaRFbpZoiRhAHVJZJPxYEd9KIRnj/8yfa6GUCghf3uoGtKUOxMeSN0eLyVbsoY7n6Ii/+1TQ+03vh4I/B3bsfrmA/xwH2RTBgGmq0fEF4pK4j23aqXfqUHmD+vUnhLd0EeVD+Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247522; c=relaxed/simple;
	bh=ttHqLFlqZgda3lTmDqr9sVoR6vlvocKjRLaKLiwcdb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sI0TVLfhPNNtCug91yr4taJlGJHNDvooKckd+jnbhP4P0muU5DC3e8QnjqDKmuCU24qP5Iy1sk0QMJj77Z7cnEYVG4YKVJWcnUsvzwma0rDgxBVZqCekHK20dh14EJeKO92sbsRO9HICqQO30eJ4W/OOEqvWfcleOL3jX9LxNwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bZAgNAfA; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7Q9DUVd8mV+330vi9cPNGOkQ6n8RjKOjoMvM0F6AtYp96ylPA5Vf46fWbq8M5kMR6Jszyp1jWvmA2rRRibTd6ot6Z/9Gh2ErVe4Jr7I8hqxGiBkdogON9qgcDK0gqP4FdZix0t10CQH7Ct1px0Fm7rqwowEUYqFxLVCZ9jdm+R2xraRVoFerDLweabtPpDiFERdToXIpSFHjZONxyqEdN+/d16hxUNvxDr4luXJSgO1UEyvrW3IK7evwIRV6FsmJDX518orWktcdbomDDIa2Q4c5ij+DGExLPPU2EkZzWicN5iPNuHGrmR8wx7gS6ObsuU3yENKrJfK5m0vkFP6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSk6NIgT4dpem2s5gEZZe8WShdhfTUV8coBJI7Q6IEU=;
 b=X08whCALFbOcTaXI4zHVWckZ/lPfUb7XR4PdzAUa6I0fsRYSnFx4rjzaOD+rIJf7HZ3VVyvwVAsMkxjklT+DOx4BJbEr0ancyhHPpJ3m27+8I2bz+vTh8Bw6lsK/1yFvNivRpMNhvnQ86vWEkaf3uOpkDSH+3wdglrQ/CBLq2aEsOKZSwsqtohIDrJR4qywD1gGjuswCmo+lzIcqO0RRnFIHRUthz8Y+pOf6UhJUyS7/A2+KTpjYi3rPqsuB/JiJhUiZO1MM688wVyMnsErnmlMFych6pMOYS+f56C21ZRsnfzapOPEYNbR6ChKdTU8xvc6rNasg+iLmredB0Bmumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSk6NIgT4dpem2s5gEZZe8WShdhfTUV8coBJI7Q6IEU=;
 b=bZAgNAfAoINbzUB3Sj4f2Xny4tOlyPeJnO9esX99OIZwlUWSS8L1LOeiyc1hgS2IaHJFOClsKtEqgpHCnDQKUUAUxLH2GehS89Qc9Iu0U7a1DF0IWRjCrLKbalR3S2YhgqQ786q5E0HQYnx4Ho3y/jJs/DxAlhW6wedugfasCAVKKcazPeaL8AHZIiqtK58Yo9Olm7KEA1uZuvzg0GGop7MM7JLn0X7ugANx4+MXFyIY6cFwkxnJ5FDI/TzWJB+59ok1kmnnP9dn1VO+96JZ8ZxLHXFio925hrWHoSEGJ8X9IYb/+PGyIlh8oUgGf1Ra3/Jvb472DX5XR+7Z+qKQ/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Fri, 11 Jul 2025 15:25:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 15:25:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, willy@infradead.org, muchun.song@linux.dev,
 osalvador@suse.de, vbabka@suse.cz
Subject: Re: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason() to
 folios
Date: Fri, 11 Jul 2025 11:25:15 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <99E9F1C8-0F9A-4BF6-8649-831882D8A0B2@nvidia.com>
In-Reply-To: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
References: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 30cb35ca-145b-40cf-6c64-08ddc08f2471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0G/MIoJGyQ/1OAH/RYZ7GY7InVMV2N6nGp3WkGwgaBcgqMB9Seq/oI2cItnh?=
 =?us-ascii?Q?AutZq0HFtyn/McuVc7wJsADl3OgW1d8rYAwKCtxm2OXTKTwXw6cMlooB3veD?=
 =?us-ascii?Q?81XVXXh77wfRxN7Kc54FMdCcxMl9Jxdw8V/MmQ0qpYTk+RfR+VbuZdtL539K?=
 =?us-ascii?Q?T4kBVKNyZh7QGfBDG4lhw+MgPhrasIJUG5R425MctkEhqmvTTFhoc8OAr82a?=
 =?us-ascii?Q?jk1ZhosjeIaVmqTfniI7GdL4EEa5oOXt/kxB3BsHU9R1hw6VaMzHhUaEsBP8?=
 =?us-ascii?Q?8L0RxsgKtbUeUJNIyUk4RYF2tF6uZf9IIc4cjdo9uHAI3NR1axTalBj+MFgM?=
 =?us-ascii?Q?a/hMYNUm1gxgZFJIOn7uWK9SmVV3lxkLD0yncO1eMlWrn7i8zWH9MMZ+BUrS?=
 =?us-ascii?Q?JYTgXQ5z2b0Ym26gg6Z6YDWqLzAtctAWDzRtvrrMAFLpUcq5HMSo670RC0/U?=
 =?us-ascii?Q?aUENCWOMGdq4sv+Ixm0dJ9946pghNp1oKiD6ar1Hi5Agbt+ZPWPnkiv9FFMt?=
 =?us-ascii?Q?7aFWsNNUbqQnAKbu+2C7CifxeOUUzQzC+il3DdBlJylen/wkOolu3uDSwARW?=
 =?us-ascii?Q?tpdRTlzNqDi4cGUQKTo9k9wfBJzg0WghR9pU5OkMuSUCWwnFFzIO8VZB+MbJ?=
 =?us-ascii?Q?BzLDcutFKyb+I6QRDJVGQDqHShsmlzL+b0dqg0IkyjLOXH1JD82MGsNBW1pl?=
 =?us-ascii?Q?v5zs+RoXBr/lCmJKj7CMFXCVeiif3hrGUvf9+fMNXxAfi49bX30v9K/K02u0?=
 =?us-ascii?Q?JhEnAcz76U9SgSGVV6NEcCg0pCwSSlPmVTH8RO77TDqF2wwemUCefAYhHOeM?=
 =?us-ascii?Q?CfA5l1LcuUoAvcqFGsRcVk58ElmsR0fkPN9LfO97tpWaH35PL1i4tEBI3nBA?=
 =?us-ascii?Q?Rq0C3wzTW/L746K38S7bReYGamq22yR5TMoJnByH0RrhQ18SvCFwQb38UDTR?=
 =?us-ascii?Q?eEGp5Qo46byYaw5k9q63UFRQLVGJEfX7Ln5d93Ks7YYUKwmxlYx1I5VNpAjM?=
 =?us-ascii?Q?6dKmkRGLm6cIqa9TvPexHk1srDvGDiYr6E8fJe6+iDZ9HJXF8jFHRsRgzGJ7?=
 =?us-ascii?Q?N7heQEEICS6pSKmK5zYdSSivscPpI7P09msRyFlkXUJ4shAPtp3sS9yg1vky?=
 =?us-ascii?Q?ruSUUHklLOTCB+6bilVMPwDPqz9zDFdY+VUIiqHefYdAcJGRwyFz5Qv3h8+C?=
 =?us-ascii?Q?Dp6L7hBxAAgwYWlVVd/NiTm/iEkpF/XYG90Uz6uBflx13GBLT3Ehxs5bAYFl?=
 =?us-ascii?Q?YrGMrSRD0wNcELMUkSGvgazPCX+PA+5trq9t/9UYYrGyvVjlQfzjj+FPde3T?=
 =?us-ascii?Q?Y5EJVLS+WMyNhEGX89C7IehwZpgfv4iGEN8o3lsjQKgNeQMBzxZznTqwP6FR?=
 =?us-ascii?Q?R5dkO+KAB2VoMl5wBYndVYMRCknYuNEyF0NfKieD6PsFvhAGpByHlfY487+U?=
 =?us-ascii?Q?dEWIFyv723U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQrBOISS9YbIG+CsknpYeCfoViB/m9Q+ZWZq+UyWThmgMJxXEsdRDbUSFH6m?=
 =?us-ascii?Q?RSdBmP1UY0fybQDDHSh3A0eVYSX0Im5z4yf/d7Z9wZUoMHdgkd6SjlT9kidQ?=
 =?us-ascii?Q?WzUaGZct9ooth+HlA/BCENP2EXYZcQVfE0lasEGDfQfR3UoOwg1kp3or8LeW?=
 =?us-ascii?Q?QwFEosxY1BFq7Ui2Hm7/7hB14oHNitHJUkBMf7bMzQ7rblCJp+TI7VFFXSkL?=
 =?us-ascii?Q?buOuYtPjvg3ZvC6G7S7C0IvFnvT0m+zMLG2KeDa5q6bGaqItFn90J0xoXFyM?=
 =?us-ascii?Q?Ll/dlq85fd6vv5cY5Cf8b3c95+dZeQ/a8bS0el+M+08q0T9Sz+DnzL2NEy+z?=
 =?us-ascii?Q?IFvbwL+PZPUs+4AHgBzqkhdkkAOjvEQ3euCMPBjC8LHJZmT2EjKbb8qaibx6?=
 =?us-ascii?Q?6cSjMsoAZ7CPULKI3hCz0M8yqRkElcm4J0PoW0SUG4Xv/3m6CkG3aWOuqhsV?=
 =?us-ascii?Q?+mSTinE4XlFjvycMTDrnIXnbd9ZruswPPSABwzMWOPxJGQhc4yDlfn4m/e+M?=
 =?us-ascii?Q?PJh3sXgf9aSZ3YYeCS8OURjnANDaO3QYe1kNb9zTOkxP/UGziPoNaNJPcyyl?=
 =?us-ascii?Q?2ot1lwZdVK9PNlck6bVOCSpEsbzbtn6W8zRmQqaJgFK2M54hkioCnPVPwV2f?=
 =?us-ascii?Q?s7K9nu2JJry3z6/WX75f19HR7UZ7lGfqkLO4dOExuehuk0eh3GE4NW9weZz3?=
 =?us-ascii?Q?m1eYTASh24tYhr4PnFlKUiKQGuYgV7BliO6JWdxr/x6mlEO1f7JX9QCjPhuL?=
 =?us-ascii?Q?Nig6JP46RiWdFfvl62lEZ+ohiwN4e7EcRHrgnBRQWQ+AcfbbgPQ8K/i8+qzQ?=
 =?us-ascii?Q?Fh9vxyyvAnCy6r0Ynmcrfx1gsf4OMls+k2P2lnpCdh08JtwBWoJbekLJFJeB?=
 =?us-ascii?Q?I8bhIdKzOgC6LreVt9+pB7ysJcUWBXTzYU7jYznJ+sLyBc6uGJKxyib1afU2?=
 =?us-ascii?Q?QCTfGcihMIypktc7h2pYn2yvr8/YUeTEiHU0kcdA6+rRrBnmkmmb4pZ5W1O4?=
 =?us-ascii?Q?ghOOe4Y8A9M/1g0UkEcLFrKSpQ1/blvJacyRWTmUgoUnrKg70RXSAisk2dYM?=
 =?us-ascii?Q?wuLA4VPMPLTc3XUBijsirAdqYGE2xFeYYLIXLq42kAU1Sus3ZiATKxTp9vIx?=
 =?us-ascii?Q?4zfUeTVuv7AABRbNeBUWYdaVVAPFU3+uqiEBjAqjkYzb5iOhL9X4BgG8vPmC?=
 =?us-ascii?Q?5C+fRbGin8F84Fi9kL4mNMFyQzjjab4V1uPLZyzIEBbCupp8N1wM0LOWRnYi?=
 =?us-ascii?Q?FinXvM+0ovrimewtaTuqpH9UdU+VIc+Pi2rWGoz0X3w7W7lup6S5wn7PzmgU?=
 =?us-ascii?Q?pTY0DvIM4bplBMSqi4Blcq4UW7E8wOey+V8d75/V1Gi2EAFAznnyx7PNm6xj?=
 =?us-ascii?Q?so3RNHPJ2KtzDRWI6eVpaCjji4Hz5DRVL9FYPu2wQq3pO76PIe0YdwilSsoC?=
 =?us-ascii?Q?Y50F+QpbRpINSEo8Bj/hAJ2qX4KstZtPJTz+SHYDWbj6snsFfBW179QHB3W1?=
 =?us-ascii?Q?7TzLZZJ/2WYV0N8adi7xPnUaQqMshO4/lXpRvoowWpuIMqnlbhJMtnD6vcGu?=
 =?us-ascii?Q?oAhaxAu7MqdCdqYuzS/EG1ByrlKeb3idyjxniZIP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cb35ca-145b-40cf-6c64-08ddc08f2471
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:25:18.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AsYvf0WdeUkHlvMUv7KHuM61qUK9E3Vho2BJ0dHPCn+fsS+hJCy04+F1TlNmWHZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

On 11 Jul 2025, at 10:59, Sidhartha Kumar wrote:

> Both callers of set_page_owner_migrate_reason() use folios. Convert the
> function to take a folio directly and move the &folio->page conversion
> inside __set_page_owner_migrate_reason().
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/page_owner.h | 8 ++++----
>  mm/hugetlb.c               | 2 +-
>  mm/migrate.c               | 2 +-
>  mm/page_owner.c            | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

