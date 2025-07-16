Return-Path: <linux-kernel+bounces-734135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D3B07D75
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F03B88A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A0293C4E;
	Wed, 16 Jul 2025 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOMIq4iO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA56288C00
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693261; cv=fail; b=lGJRaAyhZlLJETGgz24VwZJ1bdj/ppCE+2wvxzqM7OTTMElwkh7P9Y0uPcE3y2jbJYDoOXoMDtPS+78UF+bVXZRCeR5OI9pLUFuKEwtGE9w1I00oXxZPETQAO3trerhxAysrEf4O1J0SDtp5GOHTc/Q/6mXQjWyNZp1TnHfdpvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693261; c=relaxed/simple;
	bh=EC2QJBq+NslO8RML7v0lADyR65ktXcpLrbkDxaytiNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDcCMVlfG4uj143eMrnbIGeRpN3fyjcKYcO/0i9ZIvfy0Mbn9qfD880XOhCB48TPD7FB4VF/M3d8LrE1T2QnirsSDksgZefA6ysnS7ZC2p+i9IVwkia+5aa8dPJ3DcP+MwyOT+3ypt+jbyCqtbpKG20dPs/VM3LEK9nD9hi7gOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOMIq4iO; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQOcpx7A8UM84Vu2R3LnzMSsfr1kEi4dhNy/omtNLk3kg5tPntlisCQ1c6oVB+HyEExBP9DmEDW14yKRlBer8PqKD6wHGM3krCroPozFyRJLhesuQ0SI0xHSaz8z5JtVi/4TilR5Ygr1zNVDnghv8n5yHer7+VX8tGeBOEUm2LucP+yhhH7sQD+BWumzmJaX/i2QmBDtOmZz7pj3iWZIvF7uqKeF/6dGGAO+Bg0U3MYS0Cb4p/Qf9ZPtlw2tLqhwBRgby4HnS2ht9CU0Ssz71WkLIfP3y3u3mZrwB4oFuWiQjgoiFRJe+iCothM903QfjrXK0dw6LsrPpkw+ab/Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC2QJBq+NslO8RML7v0lADyR65ktXcpLrbkDxaytiNU=;
 b=Zpk7MjtcWanrnP3qrIM0163sAln/PiTpVpd5J36SwIlWqJUQd4Kq/VAaXdj7r2JYSPl88Pm8BlsBEBy3fvmRwbDF3ibJXfNp2YIfeLYFDfXEUtUbvV0xTFTH6PQ8+XJ3btbS/M3KA+Lmgv4GVE9PI7A6QCQc+N3jZu3BgbjOl5uXPC3lS76Zg7hi6YnKYJVj0bRkyAhP1AaAn6KEJqHnz3ox7k9/lkz0gBmfxLrYb1HeD2ftjp9k/AWwmeAXAQ/xINJZxJ+Vq8s0Dwq+3lEAPOcSSV9M0B+7fYNj3jI0iVD6+mS+T9zyGpb70Cr7ujmUW+NZlaUIkqjAiqLCHCFJHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC2QJBq+NslO8RML7v0lADyR65ktXcpLrbkDxaytiNU=;
 b=FOMIq4iO4tvV0bH+Wx5B/g97Oaa4X9YvvFq2JVpMxeaVo9t2NmNBYpw4ijUCYz+8pt+EA56G1dpMEmLxlQA14i94hv9kj99aab03Tsf7gOOlTiV2mE0o5eb6+9SoirDOJdiCtVy6AbmfWzs0psKQMw1CARk+7uQBN2ixrEb2cAObwbiGcGNK4NnTbGMrPaSvqPofC9fov0ogsx5rBazbsXtQ4mGKzxnyXIDGrukecHoA98mKS7dvy3HqTX+rxoQRY2+7U/DMh2K45swVRTngmdaNViDKQVXAvcd76u0aoMA3BnlMQLnFqB0PHSnX+B4ZqQwyCJi2SFSkR8jHBR11iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Wed, 16 Jul 2025 19:14:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 19:14:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Wed, 16 Jul 2025 15:14:14 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B1B03A58-8247-4A1B-9385-666710587C19@nvidia.com>
In-Reply-To: <76d80492-e85a-4948-8c25-3885be23ca7f@redhat.com>
References: <20250716171112.3666150-1-ziy@nvidia.com>
 <76d80492-e85a-4948-8c25-3885be23ca7f@redhat.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b0b24b2-73e9-4a64-842e-08ddc49cf4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfB4EnpeS9IWTmI4kbp3UrEjnl0GArTfUro9DDOwgxOtw5iSjU4By7pKgSNi?=
 =?us-ascii?Q?mD0BayDWq+zrJvlS3G88qCLr6IqP2p4bRwW+F42dB9AgDyQmH49gEzVrz0y0?=
 =?us-ascii?Q?Fo2skAJeRoRO75aOnR5LRy8CG44AknpsM83t/zhEr7KOSwLwf8cXFnCNNDgy?=
 =?us-ascii?Q?gnNj6FMLuacSWHFtqEsva7LXyyX7nOkNUKA7bn0fvA6eHY4lf2fWNfj4fr/z?=
 =?us-ascii?Q?jHuUESdBWlpdtzJ7ksR5q0dPZjzWGlm4Eiuqv+RIpVuFUVvdSoHW5sil45c2?=
 =?us-ascii?Q?bqSvOtRg1n0uKFoI6GFxC22pIm21aoSqzKMfsCLlllxmPq2AUKFhzmGARfyT?=
 =?us-ascii?Q?pKBXVQW2Mz7O8kVlA8loBzlb1qpzvnS3opZ4AgE4mltUeXQjfLOhyICSTuQj?=
 =?us-ascii?Q?cRVba0gV16pmu9KHgBdjs8g0lnHv5LyINHTCKeH8SaES1ift9duGqXUps9/K?=
 =?us-ascii?Q?RT2rr3PRjRXd8OZspn5AjjH+bzWpO0bIwWmBkUJEHPaZ0rtmaZPz1SZMgmsC?=
 =?us-ascii?Q?r0EZypP1BRmJwc6I9rrNFs6n+6okuY3vWusXQd0ZFHB6PEIX2D1+VAohL2uS?=
 =?us-ascii?Q?q1/VDF2vGs7siWVRGKyICpL5zZQ2DaG7HAtFRGo4bbQub90E7InK2FXoB2CD?=
 =?us-ascii?Q?r9+YJPPGMJAXiINNVBQEZLdzsN9JsWOr/VnUdjtoAWQzYs74X5MBDjP9LQu5?=
 =?us-ascii?Q?hpZAUC14Qb3y/BtTfDMstCz25E8ndsC1YaXjn4/SI4aL9V4PPXMhoFvebjbO?=
 =?us-ascii?Q?q+TtPVaZZ6UDaNHTniA4zdyXxAIEXSwmprq09AmHvQUaz8D8mCWHp7cXLUdf?=
 =?us-ascii?Q?gIvmgFPuc5PrS4ITHUJ2lS0S2Yoxcb4Azo/g83NFUqI0L7gqPCWyjHBL3S2s?=
 =?us-ascii?Q?gOgsuuSkvobt3EegH2xoTVPT9KBVCYIOJVIeOZ0vMDTs9sjQlm6V19UvZ8T4?=
 =?us-ascii?Q?pP61904SuMDgxQNmEU9M2S6So/KnxlnbkCd3NFZg3MahlbsTUQBw3yfh+b9a?=
 =?us-ascii?Q?M6mTZhM9bgZiEZCkWstfTaogiU5JsJvB6qVByXmtV2+DmFI3Pzik46kP1yfz?=
 =?us-ascii?Q?dE+ttRy50vZtfKSGIoiPD2OAlNBXFXk2SxKgPmFUOdTQhQCXlEC44qqPcgwA?=
 =?us-ascii?Q?ub3o+kDSKymlgFbthZAECtVr1IaGY+JasSpo8xnQLT5YA3ew9ArOxmrmLHB1?=
 =?us-ascii?Q?QhZcwy+kmGv5DWcUqgfnUTXcJRy0CHFEkE00N5kNU2kWzE0t2Ivc2ElLnIOQ?=
 =?us-ascii?Q?8cwpgWB4aRun0nGQajMu90/EiUEtq1B+82/UVfY7uyFpYoCx6JPe3WAvn+6s?=
 =?us-ascii?Q?x+UekrnoBq5mLBwdKZD7hj2iwsS1gx1E0fT4pQ/H1Qo6acuAKGHt5PU5mk/Q?=
 =?us-ascii?Q?M2r4J8lq5Q4Xn/ti1EEhAnMp61f9d6taQpidokqwhWBrqyJkNZjGUGLC2DN/?=
 =?us-ascii?Q?dh9LYQ2rsJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8SkOGGE+hcyvrmFPgqstoj1PaiGHaLC79chO1K1Hl218+n8s6/sghi7UeqfP?=
 =?us-ascii?Q?MOQZf6y8eC1LSZiAwbctPgZBqxNdBpKZORY/ykDhlu2IhMGV7SPFPiVLSeDX?=
 =?us-ascii?Q?EIy1YGmQeMkSRdkHltSbDDFzTUKkbGLIjEXt+CTsDnWS1kIv4E4qWjMByYyO?=
 =?us-ascii?Q?c+DMl/NUAeXHnM+l0rBKB2T4B2oygG0BUa/hVp0OHCCiCdgRI1mUx4BmekCJ?=
 =?us-ascii?Q?v8fTSp21P12wae4kpFMAqI7NdRA3f/Q7ZIhUtbAMXJWOXbAzxu1L24yE2MMj?=
 =?us-ascii?Q?zaEvYSZVvIssttrkVnOWd6oI5c6/uSq6ERjEYsOZ+sXvojQeaPKUau8XMg1B?=
 =?us-ascii?Q?+cm/85DLEFmyn0gtZwoncVvux7JQtioUc+GnxDVbUN/hBOk+KKy0Uz7jYjvQ?=
 =?us-ascii?Q?LQGvX05Jn4OlkzRjmUlrXCBBLfpbfgL4x6pIM/XyAjzI3SvB5AUuQYZWthtS?=
 =?us-ascii?Q?2Q9uOfAxck1j/r58VayvhfM3m3OEUhIckOzNrHZaC4BjvtAGQnVGf90t8Q9N?=
 =?us-ascii?Q?EH9vnpur+a0nf835XcZGt9EHG4Xis7UrihMiC9gp7KGRzbEsohnxbeB1hKYk?=
 =?us-ascii?Q?0xkT91O0h9l3djwBpgOEs6OPvN2lngnojypV9csRzeSJl9Hg+6mDQbgIcLtp?=
 =?us-ascii?Q?E9RAT/N3XbH1A8kcqEapKyDT0fT59sj9KZVSaxYhX6Hxr8gIEhCE1swnMYgW?=
 =?us-ascii?Q?cx6RIIU6bP1mM7OBwUSfCHchj27yxSnXSrZINcgO5tOs36j93PtImqT4Mg1o?=
 =?us-ascii?Q?4M1pmu+54cVpQiHXwzHLiQsvHXRquad0kIQE/X5g7EjHNDGWsX3rGCSfmhoU?=
 =?us-ascii?Q?t4risl41i+aEnuvnaY/+wkILf5HDiYcjnc8fziB8g1iu66gbFMuqcYXysrKn?=
 =?us-ascii?Q?tAbVjrSgoWKKIL7u1nJxjRaGlcvtHBq7ErH8GVuR66OyciXrXzrcu7qHdzLu?=
 =?us-ascii?Q?U5wDKSgQig4zGU56z+KyUzzUZUp2x+o5EmC/1FsTjkyqeGnqNYWHASkLcZW5?=
 =?us-ascii?Q?UDKct1FPDCkBlUWNtuj/DXH5TEHZdb0OnLZZ+aH2FMZL4TTeZgRjOwhYyYD2?=
 =?us-ascii?Q?ORsJd2Nj//rGyyAgqy97b9gS3fPQZX84yb0Nggf18uNnnEV7Ta3WGKpUTSNR?=
 =?us-ascii?Q?HGwMBme7zMA2WmBJOZDirow4Spul0y1YbiuFPgjFpYrIDWoI9Jg6wZhydFvK?=
 =?us-ascii?Q?v51r8DJYxLaL1NvCVPrVHjsboUajCBy7yeTOMjavYCBLo3CYLa84ok//roKl?=
 =?us-ascii?Q?caObR/G3mAUGvflX2angBoxIiXoQZiW9E7Df5ti4poDYphdq1CI2Gc0VGQiA?=
 =?us-ascii?Q?nZQlOTdvEr9+1nKU9UvTcbM2jlXwxii15rRSXCfb2qV1n/v1w9mnCZWpmNHU?=
 =?us-ascii?Q?fNolVRS4oDk2uZUYLowoLez82MOLJgPeyPQ3xzfaCNPsETr+VQmimTAV5p/W?=
 =?us-ascii?Q?0z0Z99c/AHKK8G9htiul9DAegiL0XRuJtjMXYCBkVyC36RfSqFG/RZcQr+6k?=
 =?us-ascii?Q?qFixzg79z9ps5qS6wseNxuryoiuhBHB5yYrmzEpTG3xspiU3+JpFd98mgeTS?=
 =?us-ascii?Q?QA4hak/QgcWXZiGQf4f1f0oPE74LTxqdPAwHTT0K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0b24b2-73e9-4a64-842e-08ddc49cf4dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 19:14:15.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 567DaESGPTjZwyyuQFXuyPw0Zp851Mn5diZlVlNf04RIy762L0WTOMem/64QQvQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

On 16 Jul 2025, at 14:14, David Hildenbrand wrote:

> On 16.07.25 19:11, Zi Yan wrote:
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
>> ---
>
> Thanks!
>
> Acked-by: David Hildenbrand <david@redhat.com>
>

Thanks.

Best Regards,
Yan, Zi

