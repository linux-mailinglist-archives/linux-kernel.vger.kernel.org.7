Return-Path: <linux-kernel+bounces-749515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB628B14F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A087D3BCF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CF01DDC15;
	Tue, 29 Jul 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XzVuZfqI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CA1D7999
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799915; cv=fail; b=ZCAWVJDfuGOKH0wlUHED6JIii5KbS8AK9CChXhqd5mTi7ZVQ5FMZaJM4m5nEFp+Pyl6d2VR6LGqwBUqsh66oq3Jc6Od3Om2sXhrd1dH/Wq6Q2cnbHaK+b0VRjs+HtiFxeHQYIa2iQrz7S8fzpkg5Zo1UfODj40KfbcfrLp6JpZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799915; c=relaxed/simple;
	bh=iHMhd8GCfJFbozEwLyQAir3WIyowRxCZSpXtinErNr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ld4UyOHX/W7Q0GNPkw8UkXuJ3fbqXt0qhkp7sp3pEeUY52BLrthdC/Lmfmh1D8gmpcjeVOj8BW9RtZX5mn9OlQHjd4X2ahvoUQIy6XP6N/YhgLD9YLWHM9rjTm49NCL6B0+2qbf4629UXqLtypI+IAZ1A38t1SSyC+p8xuRg3gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XzVuZfqI; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6CRUl2IL8zKK8o0V00c3VC2jbMhYBIw3yG1hCX/E6OXGspLaHwCrqeLZ14OWix9rIJXci898spRi6NNtFcM6dD6vZPhtrTaDPos/UL4oGW85alrogt3KxgsrE+F53kxQc7ixaS24VYC4hP6hWOEsFZDEN6DQJ4A+UkihcVedcWkf3Z2FpDnisd8f3a9KPcA+NOrjWfSLed3ox5ZP8GYPdwcO0gKby/rwe8ZpKJsvBovSjLTSVowl1/R+WV76QYkf75B5toh0z0UiQ1d34vAzdbHaGI6k7dpl7O9BiqUY0sqEnC90u6pZ5xJebG6aWxnOHufQhOcINww+1uau8a3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh+FIwLs2A/hbEPj3dCOkXSoA/5dPEjI9zxyaXtRQpU=;
 b=B1MYie8yNZ5Zi2RsWJzzB7ZzWDhxBKEZNst3zECMqpu0YS7uUanpRYaX7Xf3h1Pb8drkvHjIxP9J8cU8fh81DkKzFHGAoKjBJXVpRNEpgzlj3Jn4iqe59Mb+jZWjoKFL1D5lM1BGWlUy0OyBlS7Ep/2U2Zzz7cDtSFwNiJFta+zBd3EN7KrPfa7b7qN+jJZih3oehO5GRflHRrMKgyFVUs0Pv9K4qfOY6XZbXaUpv3AGHjfAeMObAkzCPPAiPXuJz5DRfz4fALbgrADoHosNg5sMDe5PTBfD5HSa8/IeEJ4C3zfVuqzJerlolkHlVlj8tKJzkEX6QzF2otUxITQIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh+FIwLs2A/hbEPj3dCOkXSoA/5dPEjI9zxyaXtRQpU=;
 b=XzVuZfqIEGep5DmtNtbblphy8wn0bo/rSwxKWEWxWsQ5fEgSNe4j8TX5cC/t3GTPBEzoPHvoYKDeaa0AupT/oTSThhih7jO93EjuaeQWh1CVsYkbEqqOquYym4SbrydYe5/w+62Hfj+Cx9/G39bueflAVr8xb1dk4ZWRFhO+JZLwQJTb5qzr/XiQVYGt2+Al/ZWE6DSm09eZmhgL9n/y/TWllfCdLG9ZM7in1G31Ds8ZWC1YA+OCQDdmLWVaA7XHSWUjWC22jVM6IfQkB5agj2AbQfqWhDEbFO7ZvKCAIoV9ND/1kc06UhOSbQ1p6FqsPpbTrL8j1zZ/YofmNgdPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 29 Jul
 2025 14:38:31 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 14:38:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] khugepaged: Optimize
 __collapse_huge_page_copy_succeeded() by PTE batching
Date: Tue, 29 Jul 2025 10:38:25 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <60A6F85B-1B13-4FD9-9A7A-31297505D8F2@nvidia.com>
In-Reply-To: <20250724052301.23844-3-dev.jain@arm.com>
References: <20250724052301.23844-1-dev.jain@arm.com>
 <20250724052301.23844-3-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7a9543-776c-43c2-0248-08ddcead96fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fy2gG0rW/umSjOL1eaQ7IDYX5cxaFq5sA4Hed8ovwdcg2GwgbWNu6lOf9tZM?=
 =?us-ascii?Q?Ev44rgVpYr1Jt7MrEFYjL62CrNFsjIlpcQKa/MTiMvqVlUm5ltigRs8j3kvv?=
 =?us-ascii?Q?XSnSY1mfOwfPDON1x5HSvYqxt9DuFfYEtlztPGuhKBg8ax+ua53ZiCVO0bYw?=
 =?us-ascii?Q?DHtjNcK2AIym4mNjyKsusuq6v2Ch/tSh0IGEjXEoPkWKszLach5ym8wfMLTL?=
 =?us-ascii?Q?oqjmAuAh2Ecbm9pQicuZd6fkOAOndvAVSdxX8N931ZXson6GPuY1LEiVqCMi?=
 =?us-ascii?Q?1AXZuqLpHOrm0OLDr1vdTENmMpz1w0L+rcQR/bjeAVMk0sq/SF+ysLn9tfhb?=
 =?us-ascii?Q?0JeR1esogzojGEoGHYcOhKHLzK7t1BAMH2/R25dHCMioVNFLsyZOT8caITfY?=
 =?us-ascii?Q?VbZ06ULaN7aZzvd7iBH1Qkphv0mqnPBHZLU2t3sSzSh/mZTQ5jvah036qytH?=
 =?us-ascii?Q?kgM2mjNf4D/fXKF0aKN571JAPqASoIeCLgT4zCEo4348VBU/A+mALoN2qIhu?=
 =?us-ascii?Q?THKtrL6qBC+fxD2J64R0F+WUAbcpxRY+VwQOcQzV/8h9ZM1NZBnAfEV+dSGV?=
 =?us-ascii?Q?YHEP5ANNaWkadLo4pR0PQ9aNAT+dCiqo81gd2bCoKKHp5UrK5gdxAfG18aY+?=
 =?us-ascii?Q?bhXJTeaKwAeBMRJtPp/bN/gaGJInL8zdOskLKUWYTxOQz0R/tEg/j14KCQ9L?=
 =?us-ascii?Q?j9hzSZ5bvfo6bf0MSKPakiplP3wX8wbKjqeejGonAN/oR4CASLSFcB5CbHbl?=
 =?us-ascii?Q?c+5UVLkFOLSIDOaEBi3RoG6MB/v1LyL9JJTfvQeRLi7k0f4qkpdGXYn5GnmS?=
 =?us-ascii?Q?qgqG6bzSUcHCKyGRtWGZuTkhMWW77FgL3u40Gwfn1qd/qQ877z+ickAE37ss?=
 =?us-ascii?Q?KVQLRxI7rx5mhnJZWLzVAWX2ZUwIwy2B09dQj4wxDUCFx7isiIa0hDsfnX0t?=
 =?us-ascii?Q?azT8sCTQVWNg9bNidA3Ukvnc/DzfAKvAiiM7Lc/uUKP1MlNtUpYy50lnUqSw?=
 =?us-ascii?Q?e+UmU6CDp/ZizxNCseBsRaGaE64qPFkKhipmwqjQZfEkGWG5jCGCRr+Xo5/V?=
 =?us-ascii?Q?3W97FdVCdvDphYSmU6WVguG/KoprCrl1gWNKDX/Db6aTz8Ml5zlx/xa4GaCB?=
 =?us-ascii?Q?64UDc4z0qLVZSC0g1zAEXBcSGgtT4ZrunrkxXIfJLoamGXbY+CNd+RsVYkRP?=
 =?us-ascii?Q?vo20j81LZ11NXgbv/P8N13OMoiZ54X2mtqUgsNp4oZ9niNJYqnXEHLKGnMUL?=
 =?us-ascii?Q?S2f+gPEX3dGoT9ZKBm7OiOVmdVM0/w42sUsILwWf6fWE5IhuvDuKvDrTBCKu?=
 =?us-ascii?Q?qWBZdzc5zEHapobqMRYPG+ytnu90VsQP6qnrUsj/SHTh+7MSCnErv98M7zKS?=
 =?us-ascii?Q?4lqVWXdqtHqc0f/P0iJ+QE++kr1/rN5II3kwl203C5dDr2VxTQdNsRGdZHWE?=
 =?us-ascii?Q?OofVbkP9MCA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sPuWAMXl7Gc/8V+Xb1LvhCaonbjPsr+0jcI1ePaMOS6bjmojXrarfTnvkVR?=
 =?us-ascii?Q?msx/+z2RgBD/rbI42G5coOX5aso+JO7mHrKJVTDPE5rxF/diR3uYn8ipUBlz?=
 =?us-ascii?Q?X7R7QM+E7jOAp6CvkuueAqb+dj7pF+/QqA7kWUkKE1DL6KsYANXQsbnc5Uce?=
 =?us-ascii?Q?tf+Pkrf4ZC45hBhoESvZmK2p97/GVRK/HninDXgrkL/sN1my23I9k3kzHJW9?=
 =?us-ascii?Q?zTBDRh8CJYBEV8+2CwcuROGd2he2ZQmDq0MAV8ld46U1E87fl0IkanJf2iNs?=
 =?us-ascii?Q?eFk9VUGLfYov6aTSg3mm7VuGvg9qsCbvRii8D6l3ma+zYjJgwIyDeFcrlNVf?=
 =?us-ascii?Q?q03QWzWuFIN3vNRfQR7TvMTWJACNVOAlOG/CfsHIu7mgbj1TErA1piAH+cnI?=
 =?us-ascii?Q?T2wpCauyiyPz/pRs4Dgrm6byavlgEZGGae3iC5cMJ7TS6sw89r0aV2FjhJ1J?=
 =?us-ascii?Q?RtB7V0CjuByDTtcZOX0vDCvZaaPjY8YHFx/rQ06C5PbNAgje0NHtMd2hNG2D?=
 =?us-ascii?Q?cv3u5W9iwp6G2aaVUZiJKND+LSqH1ne1cyzE9Hlavkyt30g8XacgL3p/bwwF?=
 =?us-ascii?Q?6+Q4JDyLhoNcWHjez8hvgBLgl4NrIVcD65eBrnztECqq4FpBdNnw9F8ZxrwI?=
 =?us-ascii?Q?i6Pf8gBN1fRdE/D5MsiuW8gOUSdhDzaZgCZ3u+uaiCmE53lblU3GvDAb0SzZ?=
 =?us-ascii?Q?/3EHOYuKOGkWewHKKsp4OF2L3cPYgUfQCThtqKZSg1EacUmDTletnqXTWYM3?=
 =?us-ascii?Q?MH385OmCfoyJN3elbBh88H+ocEEnzL2Wds7j7hp7PooMKv69yj2C9LUgjVpz?=
 =?us-ascii?Q?7I0XoJ4RT1ffkHeL4Y/xta5ULCJ1f65Maf6YJ2/3mjBSVvcWhQsTsMFrKsz+?=
 =?us-ascii?Q?RjeclgsoEaNzpMTFdXKD55AJFaKIYhjZS1Tpwg7C67XxHklv/3dxB+Apv7BA?=
 =?us-ascii?Q?GYUsVccIQhBgnu4PXkbTHEP3z5b198CNey8SFPfZ3Df1bbi1qZhrzdy5G8Nh?=
 =?us-ascii?Q?Mqv7xwGuvKWYjbpRDfbtObPE6sNHqJgkxysBposX66JXlUSAhs9Z+cWq17cY?=
 =?us-ascii?Q?qrMg5yqLmTqFORQGfxlF0918mDlnilJwg2yWBjjFRbZqFkggP0AYrYNHD/gj?=
 =?us-ascii?Q?zGjMEMgww0te+RJM/J40PWs3tEIz04+afy3Uu8mcioemPtmWq8Xw8cOUY6Vo?=
 =?us-ascii?Q?P0oeUBacZib2KmPS8jUgFgok40PHnrFQU37VQEW8Ba+l0gaLWcb+BK1Px5GF?=
 =?us-ascii?Q?99IfIXs0nypaXYCIoDAZpGv/U9qQl5dkqpGpqoi2k42DuXNfDzPxgXogXk0F?=
 =?us-ascii?Q?WfxsT6CxKvEwVvySNdUCPI8VwSxjiT6xExVuDkPAY3dItChwhBE4IIYlb5Ux?=
 =?us-ascii?Q?TNWD9KYbhcivnKI2skzcQgH3Yo6/15DIammJhRZho1HQj4nyzHIyIDk0hWwL?=
 =?us-ascii?Q?ScZNKJUeLO2fU1HU2mylmtQai8T70sZJUmeEi8LUxvu0jsisOJ8XRTpdCLFM?=
 =?us-ascii?Q?CHnn90x+RMigtxHdaH8/Y9wWOeNLtyxz5EcEjShvtGZLqhd8qOf6z0zKl7iN?=
 =?us-ascii?Q?ghmqL1OAL71PfWHT5Fw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7a9543-776c-43c2-0248-08ddcead96fc
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:38:31.5565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvEcQ4hn4eGom/3h/Z8ZRjO2Z8I+h9yjc5tbU5VPjQDOdWsU6vbiUbEw0nHfjbIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

On 24 Jul 2025, at 1:23, Dev Jain wrote:

> Use PTE batching to batch process PTEs mapping the same large folio. An
> improvement is expected due to batching refcount-mapcount manipulation on
> the folios, and for arm64 which supports contig mappings, the number of
> TLB flushes is also reduced.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

