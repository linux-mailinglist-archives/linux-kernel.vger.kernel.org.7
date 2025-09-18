Return-Path: <linux-kernel+bounces-790966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A1B3B075
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D89A5E124F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA161DED77;
	Fri, 29 Aug 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TZb8Axst"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCB1C3F0C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430739; cv=fail; b=TWayRQtzmOxfu+yg8VxeucYQGwYviwxlWPGLny+OY/rMg9gxM4jYxhAqWBtBaRyqK0ku+9KuWS7IIB1jOwuyFtqcXpFzxDkldZG34NIruOkRwHGMuPCImlz767L4fw+DN9xHo10nLtZGouakt4gS7c/8ZlqtlpdnJUnM2/E/ZO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430739; c=relaxed/simple;
	bh=dyyftUgBA7QRl1NuA2K+JfkudniujgXXWZQdRIi1JlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWTy91V8EG93sMA8PnJqobIxB5v4s1Nck5sgkV+xK/QfUHYyLW5tbQTUCIFIYq3UNQZL760I4wTApCMw2B3L8BPgelyhf0VGjyQiF8zhkltbGbSo2IBU5rQLUOKw7cAP8P1DckxsUWIb/RLoMVTs5ycjEdDvw45V1VYkhXe2PH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TZb8Axst; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erdeS77ntPMI5i0/gXeaNTx6WaWa4Ax9r7IZk1CUC5JFWo1pqN/r8sT3WKNTyDeleC9Lc/+zGhWe4Y29n7CwSrAXraxM42E7RbE3sxWQDxo2znFz3isKKtDflnvCOhKlXXI0rSDBBbxpw8yiv107i/uxp1Et41bvjY8K4KCc+q2ENb3Zs1l5ipr1nwBy23i2m0h2fX3VlIVmeKlK5+KMbWQ3f4mdTmYfYte/P2Lr3Tk0yiHz5J5HqUaRO1wFDN0IEs7iUdSa36p5Wtr0RS/TiaubMuKezoFYoX5AbV4BRDZCH8kruIJqSAqwn4vtdyPQh1okGPFdkRwBzk14/VosbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OslBuWv2zm2Qr+rvueV/AaZVT6lNbrvVinLtk9b40n4=;
 b=QUwiwoylqeWMNnTUcz58GgNz07i1O+FeAek3nk5JJHkOYiqp7q9xzCjr4fG7DHO4DS6ztcruakTJMBs4UO0EwdODcVZzaUml7SGiOllEcYNk/dM8WLFm7nKfFqXpDQopR6bQRC2dBKpqFuSiiglSNEGLSRAKFrOyFweohzDT8mO5BNnhDAZA6WLady4AgX/2H97i5daZ4LkBLGFkHKtUtywvu3SLKChPySdZ+lEOnUTTjsUMYeZANkXVrasUjdtnq/EyFuBWu3Il7TbjVYAaCq/WHpTbR5fqsNCubS7H5sC9gRZh30IWOt+9PZzQ2Bc5DL1II0JtTl6HR3gVQnPKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OslBuWv2zm2Qr+rvueV/AaZVT6lNbrvVinLtk9b40n4=;
 b=TZb8AxstlYArSOuHOwbTg2RAKxrqaPq8fer/rhDCwiyCqlp0s29pU55yrp11i7KPZ2TqbfrMVYh6SNKXxTZvP4xj3+iAiHT19ZqPb4O+tZBS8+cZ65egu/kUolGOkzXlmqLBA/slylqIs4p3enV8TX/v7ph5/n4PzzbevhZmNe3Ac7RR90y9eqsIzmhcJh42tpkjt9WODUWivyZ9YzMGC+9s+V7i7yMku+pNQLJpHz83Xe1gJBtNRzLHWdAEH671rkHXDkuk/e5/1uuwJrEWdyE48uZ7fBgvvA5xpGMI6HyNfJTnAvcsNDAxHUja56iFCG/g+IFDJ0tsieiMBHKgNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.25; Fri, 29 Aug 2025 01:25:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 01:25:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] huge_mm.h: disallow is_huge_zero_folio(NULL)
Date: Thu, 28 Aug 2025 21:25:26 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <81B36E34-BDD0-4A66-925C-CCC809248992@nvidia.com>
In-Reply-To: <20250828084820.570118-1-max.kellermann@ionos.com>
References: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
 <20250828084820.570118-1-max.kellermann@ionos.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:408:f8::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: b6caa6ba-b7ae-4b12-6085-08dde69af167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WFGJ9r9ZFLQ2i8uv69BkwVj0c68LHKRm3/ZE59zQR8dfUXXyQSSxId+wrfY2?=
 =?us-ascii?Q?IJ4H88onloXT/Fjub617O/XuDEiH+hNl2EO02FsRNlkUe1wUZJjsgXAbfs6X?=
 =?us-ascii?Q?R7xaroWIQzXJJ9CzcZxL/dE8h9QGJTlkUdIOL2LHPKrlDSlC2B55wirdtO09?=
 =?us-ascii?Q?CnSFspvQgNJW3V551KbIR11eiIRiD3A7/FqxAkGoh4o8xnHjjBPVcQ/VuwX8?=
 =?us-ascii?Q?Htzh3yolXClRDvVXMFXBb/HP9eDk5q6rgvNllZFbhwQP5jf/UomRzu7mEWmy?=
 =?us-ascii?Q?nbWZL9C1GnamUqqbGUDFPIpHa03FPySs20q584MMBY7QOExhPfVsRJWWkJz4?=
 =?us-ascii?Q?6vasksohy0qbQk5/G02fxsBI10nwtTdDUIUmp+7W4LVtatp9bBgQNWrwMmOC?=
 =?us-ascii?Q?CM5GXEGHSHXe0g9Y3BJndi4nely+me+e/Xtj3L2cwT1SriMNHcIsvavtbIll?=
 =?us-ascii?Q?bn/vK/Jml6qoW3rSQwZaH1pknODf4TLpzqqPgoyR595Ov4I74qFpWEJBm/2k?=
 =?us-ascii?Q?TiVivsKS86CWBe7Yu+kBHLGgwOw2I6Wz+1oNKY+TJEdIKwUH5qN+Rf3WWFpv?=
 =?us-ascii?Q?b+3byubtU68DqeKgT3vSF0YRol2W0jgITuhSRMAfbAo1flogeNuVUNP5axiZ?=
 =?us-ascii?Q?coZMyBnWvRkJKzkGSloMU2HHInyFiSJUQ6L5MOHl+GQEUpmPHHCiD/idFYJw?=
 =?us-ascii?Q?0MGy01eaBsPFHLw51BauI2tiJ97jJPZYYfTzrVftxplTNgXBRImgHCTIQiaD?=
 =?us-ascii?Q?PNnGBblM6QyyW5Pac9fvGaaJlCuhQ41EXmEZ2r9fn5lx4UgF6lpyYJzwpedW?=
 =?us-ascii?Q?s2yhjVSbz3huv9S3OXIJywhVYjHOQJNyzjXiOO3clMGhaDbUEQISobzv7wht?=
 =?us-ascii?Q?mpfYlUoRG4QgCjUE4prb7Twa3SIhcFCrdQcccheIkXxDBCsHWLq2kk4kFYae?=
 =?us-ascii?Q?FOdVFCaafN9VVb+8h6UWyXNM+nE63w1cUzlunoeaeAeFkl5+x23Lg6O525OK?=
 =?us-ascii?Q?btMre0lo416upRE88GbidnUa7vRK9rTWWlgOITtUmt56fWauUtrQDod0eXWT?=
 =?us-ascii?Q?+oT7E3OqegZsSKdWIeBFDI+01Kgudl+kKEVnkP+e5PA7yfrCcJn7ZHn7l+GH?=
 =?us-ascii?Q?xIr+4wgvCysL5t7ivoazyWGBoPoQeieqpg0qneqUXkUoPg77AxnJrFaI3xos?=
 =?us-ascii?Q?BIdRuWExlg4agC1B52ilIUsQtqIB/tMyYxynwUJtbngjsj5pmEJbu4rNLzjI?=
 =?us-ascii?Q?5dqge5fZ77hXOLGLgAOudPSQZ2VYBOwFoL4D77Y3vDx2oKHwxMDT0W0SHDAc?=
 =?us-ascii?Q?poaOzycMk4/gz8ZxJi25DUgVB1RNPn/QQLNHZGCNvLnGVx5GcoQMSNeiJy3k?=
 =?us-ascii?Q?WWPFPV1Ip9UjSETogwig75bHAwiwmwLifKaORqiVu6KjS8cFjH86qXh/UMXG?=
 =?us-ascii?Q?IE2bnGVcS4U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OGxxjMsxyHNiS02MHc9qCx8ktfOx1/9L0RDLwmY24+niggdEbVfFEaRWFmNi?=
 =?us-ascii?Q?2EAofXH0QYZAsXUIRqxzGDBK63AvNAJ2UOLcWy+lAOGCJz1vfdcLay6M4gPA?=
 =?us-ascii?Q?uUw40C0iShhTFm+hsU1Y1x1dyAzLQ+Flj9EvixRImuCBGdjoUpKye9ILa8P2?=
 =?us-ascii?Q?+xOvxtPpDdJVowQHqTcZuoken1KjvU7ciEWjXwUPxljmSylFo/dbZfeGoK9g?=
 =?us-ascii?Q?zpkdEgMKkFZGgMc+AGdvyL8GSk+3lVaxCvjCoiEAXERWMkCpVPs2/Xm5yLHn?=
 =?us-ascii?Q?Pmm06kDRdzeMs6bY7X8G9AD93GandaHWcz8HfDp6Vh7AmwOSE5P4VIN37Dyq?=
 =?us-ascii?Q?t1hidPJu4UtfqvXMhUEUPjfLpTU40LrBSJyPuqHj4dI1hCjC0jmK41mYeGOa?=
 =?us-ascii?Q?7xBw7aGzDYCgfadc1Gnwp+2vFtJGTjjYYMRBXPHgnrLxiipYgkLlPJ7cyIjp?=
 =?us-ascii?Q?vWd4OmvgLxlMXuxTDEJJNR6jB31/1GC+nB52w66LnSl93LAwccuVPRUT7l/1?=
 =?us-ascii?Q?hSgT32g3vnC4Qw8k9LkYrIoCVevNfjKS67zOa5Tis9DB4vTyaAjbrRysDrd1?=
 =?us-ascii?Q?Ycv1HabW8BzysA5okdlbOw/m+CO89WiJPw3mqhO64YKPiIVITtAElP7eWBe+?=
 =?us-ascii?Q?JHmyTOypSckphyJ83VGNNrhsYreKLbQgyA1ssaB4M+QZLZ55SNdsGLfA0Uc6?=
 =?us-ascii?Q?B1wlpBW5o6LiGuKzVHScC0eUvt3KfoOBA0M6IH2udgx2nP6VvFcAam7FPc9y?=
 =?us-ascii?Q?zvFCPphdEM0ung0t0zSukRC5u6azZfNXbRKGpLxGgkpJ/rR4X3P/999LOCg1?=
 =?us-ascii?Q?s9DC7COH4DSeOoR/CaTw8TrBCZ3DG65vfqh51Y8c5Khgu/CuNG3ERlOnz3Kf?=
 =?us-ascii?Q?2Yl7lR4lE2NQNjUDsUGjBVzdf+DdM8px+Uu0mi8jWT3WB/diE6JPWwgG0SI+?=
 =?us-ascii?Q?wmphNgtNEE0hl3Xdmnt1S6zExdimyybVlEaUuI5zH94HClGn5J4ktHKkLQMn?=
 =?us-ascii?Q?jOOeC2c9GfVGGdEwOhSgnYtddvB8zTDyafnpa5W7sTDVW4gtf7102XQ1/vC6?=
 =?us-ascii?Q?DceBLCeCP+wW8Po/rATLsSqJyJb6F2FOj7q7NaQWlWxdYyBxBXh3wW8+veKj?=
 =?us-ascii?Q?rFAHdIvuL4DWWA0kip6H7oAMeNf19QF0gF9Dy6dX2tVkoFimrvZMBJ3+wwVE?=
 =?us-ascii?Q?L0qQogbSEABArsat5YvDkPEAL3qvjkHEY/WijXx5Y748MwZPag9d94FPZ3o3?=
 =?us-ascii?Q?nM4p0/wnFAwxYu+uMsynFy6T4PgAxgIHnuV6ikr/y+dpbzlz9Tff7VSJh+0s?=
 =?us-ascii?Q?B1KvGML2wh+s8Z6BvENmWyDq4jj6y67G1I8040t20Z+ukiUOZqBMOlKbhBmd?=
 =?us-ascii?Q?ruc5RioOXvDAC6KEesf2kTeIWfgtju/WkCMeV/mZX3nCON42ZiaA8Cnd5NAo?=
 =?us-ascii?Q?TuvnGzhe6ToyplK/bQI5POf7CwCIy0asS42MGtBJw8VpaKfDuA2HPazMM8Wx?=
 =?us-ascii?Q?Y2ibZR2PJ1bEgeLNduOH/D35lrpp0hMdy4RFkBjzUPlSyToW6POnQbxYQRfk?=
 =?us-ascii?Q?cWuYYOyCG8kBD23kloqek4jYm6McAPF+pM5LYDzh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6caa6ba-b7ae-4b12-6085-08dde69af167
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 01:25:30.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEp+w88ujVdvPmNFe0T1TzYPF+DRhjSZkErVMB/NkPUBXmcyUKNEw0rTMPo1WL9S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

On 28 Aug 2025, at 4:48, Max Kellermann wrote:

> Calling is_huge_zero_folio(NULL) should not be legal - it makes no
> sense, and a different (theoretical) implementation may dereference
> the pointer.  But currently, lacking any explicit documentation, this
> call is possible.
>
> But if somebody really passes NULL, the function should not return
> true - this isn't the huge zero folio after all!  However, if the
> `huge_zero_folio` hasn't been allocated yet, it's NULL, and
> is_huge_zero_folio(NULL) just happens to return true, which is a lie.
>
> This weird side effect prevented me from reproducing a kernel crash
> that occurred when the elements of a folio_batch were NULL - since
> folios_put_refs() skips huge zero folios, this sometimes causes a
> crash, but sometimes does not.  For debugging, it is better to reveal
> such bugs reliably and not hide them behind random preconditions like
> "has the huge zero folio already been created?"
>
> To improve detection of such bugs, David Hildenbrand suggested adding
> a VM_WARN_ON_ONCE().
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> v1->v2: using VM_WARN_ON_ONCE() instead of checking huge_zero_folio
> v2->v3: use "!" to check NULL; removed the #include
> ---
>  include/linux/huge_mm.h | 2 ++
>  1 file changed, 2 insertions(+)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

