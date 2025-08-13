Return-Path: <linux-kernel+bounces-766823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73BEB24B98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7621696BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F22EAB90;
	Wed, 13 Aug 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MAOKK9ry";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="El7hIuJR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B02E611F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093782; cv=fail; b=sQY5eguWJ2+UgAVgcA10p+MWGqNvgmZpw5X4tZ+EjFu5InuMwO2DCEXskIkiTe97EzAVk/nhBGx3bJrIDL6fF4/6T1xLnnnrki86eaWiZ0qoyuSQlPJjwNZ+CoKjnHGUWvB800ukIv66ybibJYc76fXFrazRmp2Scmht67MLmxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093782; c=relaxed/simple;
	bh=hjhdfe1SCZF0cdN/DzPMxVmgiERkRJHIMwXGMA9VIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VkxZ6E6ZAAQrDTRc15oec4I9a3HJpV+9p/qTrVX6/7a223jwLgJXnM5N9jbyNleGTImVNKonITDeDKgf4KdU+AgxEybrKqtdp2FNsPouDRYBfE6QnqHeA4R0rIl0+Tq+vFrDdt2X9px/E19suc2Z8KIvImp3g2JzcuqP2fva0eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MAOKK9ry; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=El7hIuJR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNSjG002146;
	Wed, 13 Aug 2025 14:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2lovIrpTybTKcxpy2B
	dDPlwZQdV1pso0C0Wti0ombwU=; b=MAOKK9ryn9D1sb6bBqE2uM5mk41XlfLzeG
	Zk7HSjfWQ9IHXGXvy85U1e6t4TR1Jk3c8VBzGb4nqz/5KnxerdUBsVTny7sAZLg1
	agAC9B8pslt4sT2lCp9zCr8laM6Dcrd17C7IV0UQWQtKYT2YqOJf/9YvYpZtpJec
	eEzcxZuwPIbasdwqsZeM+VBIgjHavwqNYrpPy7svqzR7uFqpy9OgTduxQ2F9HrVS
	TGp5jZlyvThIifV7ao4/0hlHLU6E0QrXqDQK15X1e29oK8gbTlkF6MM/AM5Dz658
	wCM1Ln8tZh6BaLBeL8LGEQSYLq5qYvM7s7qfl5IDB51XFmnu7I4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dqgja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:02:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DD2M2s030018;
	Wed, 13 Aug 2025 14:02:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbeuue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPYlJbscXdp0NS9Xbc7870auDbvEGWxzSAzO4AWI533EPQEYWvp5WhSTQ/CH20cWNtuEAtypKfuWkVcfguM2ufHImSe4HEdtSJLrpyP1QMGbHPH9GX0osbGP6oGKMdUdWex0cw+kUe+hJbU+oM5lE0YQWD58XBkZAwaNL69Elpw6u3tTaqFGwN0lu2OMqR3QbXzRO1jSoXxzsOwNe3U5ujLgajrMA2igkxfBA8CpTqmgTbJ/Uy9Rp6dnsmHhJNy6M018/7xRge2nhawaEWEjC9ltmTlclv5B1zpc6uQl2FeB9OZehQsnKznrwAKFDAxhDNqdt8Tf+hiFJwy48UBMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lovIrpTybTKcxpy2BdDPlwZQdV1pso0C0Wti0ombwU=;
 b=Uny55d4GDSK6szhjcihOby+gPnCdZPeV7YnZvQ17+JKpaAM/1/OTeHmGRI+7DaKuEbuRi9BMcUqgOdEBM4eH2thfRu+xI8ELdS68epEfuT+FOmve0MMNiy8zxDfoPoZR3Yy8AyilThukwWCS3KKYTcmrG4qj2WpbzxwyyGqZRR2/U0/JaS2LMY6VWajZX6pdSefAboj7fxHvRCphJoJ+8hipHZOEt+uUbVVr90V7zZLZcFEXCN8+WCKugwOttkf9zAmz8Gru/R2MQ0etBfmoVDbAa4Xr8rZNDhtj5RD6jFchIVcO/OPBEGzPRGAqbRqpdqaOlrF1OCWO9dDwG4fNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lovIrpTybTKcxpy2BdDPlwZQdV1pso0C0Wti0ombwU=;
 b=El7hIuJRdXh8hPMu0MtPu+I2YgRUCny1/kFmo9h5gOXIiJss0mskuogkRAACoWy7kPc6pVNtSKoqq8+FqUbW3cvQdfCgVj3DhjsRAF7A3oeL4xlWEuX70Fkdizc0fdlBr7Raf4VuKT93jWz6ArfHawItb0wP6P3r2s48EQLfiFo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4335.namprd10.prod.outlook.com (2603:10b6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 14:02:44 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:02:44 +0000
Date: Wed, 13 Aug 2025 10:02:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
        "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
        "open list:MAPLE TREE" <linux-mm@kvack.org>
Subject: Re: [PATCH] maple_tree: Remove redundant semicolons
Message-ID: <qlw2pok75g3wx2kic5tn2wtb4xjz67po2m56epcx3mjhev6y4h@m2hmlrt7xtv2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Liao Yuanhong <liaoyuanhong@vivo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>, "open list:MAPLE TREE" <maple-tree@lists.infradead.org>, 
	"open list:MAPLE TREE" <linux-mm@kvack.org>
References: <20250813094543.555906-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094543.555906-1-liaoyuanhong@vivo.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0297.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a987f7c-dae7-4af0-f4e1-08ddda721331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U99Ni4C+QKnG/HqYJ4fRvP8HyUlBRgfYO5ybMJRbajm41HCGqMfbQyI0o2ms?=
 =?us-ascii?Q?7W6gcuZdKeSSBUqljTQpYGA+so0T0lomv3Itgzp0aPvIuCxxI/YrI0pIlgrn?=
 =?us-ascii?Q?cMURyLR0cdjMeZoKuHyf8J3wjypKwJSHitwTvtQrCzMPgTsqae9tc6r42uuQ?=
 =?us-ascii?Q?By7adxr7g1Wg0MhDvWAwQ5vUI4ezh/4MRsci++7oJGCWkRzV2pnRSPkyTqt4?=
 =?us-ascii?Q?1NW5UhbOckyylGlBg5scNB9eiwfumh9i6ykWY0jUi5asnM99mJ/5gS1kzCjd?=
 =?us-ascii?Q?SWRWFQ4VL6xKQnU3/Nk35BgdBUmleq7ZrqUmDC5mhs1arfxn3ukOZzW8y7fV?=
 =?us-ascii?Q?Lm0fHfTAKEkhlHIRecozYUVGkAL4KSwb7c/b8zvnHNlaQd6EjTktqtdAfPlE?=
 =?us-ascii?Q?Ha2XCNehAlprmeaTozNeJzeYW/f/SJqy0EloGmmtAm1dh2pKyCJTjFBjlbsr?=
 =?us-ascii?Q?x3788WzA8T1g3iftBCuF+lhGYSy8wM6U92t9wbQmQAH4gJZQpj0WQ3FWTe+W?=
 =?us-ascii?Q?6AGt/OP2QpqrgibOqGzl+HXSsJHNtUPQGU84AKk4ncIxSD276wcFBeOwHNvU?=
 =?us-ascii?Q?CpkUEL1mpIFGRND3U7/cxchHCPbPzDSfi4EejZBufvR6IjBkdk/ITUQFJBdk?=
 =?us-ascii?Q?kwLnLw0wMKeMRDq/0tfE7L5drHqCyIfdKTM4qGYTrGhOaVuTR+8TIwSkqd8H?=
 =?us-ascii?Q?hbd/Q69K06QgFAGeDTnZnElbdnAJVAyD+d0KuSORxlmEITwnljl6XGlPqGdd?=
 =?us-ascii?Q?IKlBnhnOHVvyvflE/u4GsPSmCZkqSoIDzRGrMG3/5dZq8/bULgkMPOyGaQ0R?=
 =?us-ascii?Q?GKYSD1bghmDp+oLVKiTP+GP6ok0I0S/CkoL50PZ0MA2kPVMTDaQ3Dc+9L7LW?=
 =?us-ascii?Q?LaGimssRBj7b4Om5lrH3MrTQw8pyLSmmE2AufLmXJcxTzcnoMfGM5Fh5bTTP?=
 =?us-ascii?Q?xSwI35Mibfed4ovEzFiMu+187D4KN8sibW9Iukld06OmttAKJdl5eI089Zma?=
 =?us-ascii?Q?TdxD0XNUv7JDbQScVTOgj0ZScW+F2zyWlmVIj3O1yfIbvh7PRdJNwOBj4RuJ?=
 =?us-ascii?Q?nyVVXCSZZfd35Cyx9vb/zrLObYUikmf3iU5ZrkcWeIUMDgolDigFgTXi/vWr?=
 =?us-ascii?Q?JutWcpZz7wZx4XC5pQzoOGslKsuMi6HznEieprwGQlgvI6xjbDUZuX4ynz8d?=
 =?us-ascii?Q?GzZP6Hz3Ibx+aOEs60mE+dkYV4qlVkxkiLj7NLRBQHzmsy3gUHT02G2WYxnp?=
 =?us-ascii?Q?eNh9d4pr68LWsDTNo4A4Tr+ZJAzZYyiA3ByB8uBTs7CzMNs/i0/4cMtqWKSd?=
 =?us-ascii?Q?keP5GxhSUHdpMMdTdE0jOLX0yWzp1F/dVXQoxHC710PGpMWuuhTq2lUiTReS?=
 =?us-ascii?Q?FgOs9frRx0cAupC01dYUN2p7KkJCu8cETD5ehc92y+rgDgF1c+LShHIIuyjm?=
 =?us-ascii?Q?6BWePl40lYs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Az1RZEgqYMZoGr3y8nZeLAmQL1VhtW9h34O3WxPisvW3crvx5WTDoE6BLZDL?=
 =?us-ascii?Q?YJdZkjiEfGH9hvm8B+R5BcPxyEtb0tv0u5ABWLJ7sEPAHNdUJM8BNdYMbHFV?=
 =?us-ascii?Q?itxz/YXG8ezA57RBVIJRE0Ks9q03p5I/AqQlPtmloNdB0ocrFcN7aDyIfiWD?=
 =?us-ascii?Q?4LUOpOpPR8cUvWsp35BgBtx7BzGpY7IgDLoC7boIw24b94UlWUKa6M0rSs+n?=
 =?us-ascii?Q?VWoxZLVHu2VNSx2S/v4zf9TDAUzDi1fhTYxzsnYNopK46BQWvbIWtjZEo8yt?=
 =?us-ascii?Q?hV4HkDrM8x5QUTokK6Mihr/L+fWn4+/8iJGMlBdafMfPoikJSFZtuouSh71K?=
 =?us-ascii?Q?Cj/OQyVpLZ/0kZCgzmxcVhJZv4QtrjKtgtBxMPFjgIAkZALY4CFyaG1NNGJl?=
 =?us-ascii?Q?lQKS8yd8w3FkJ3RXcxKrzPT0dehXYiB3yy5QN0MD3ZJmiwsIozZ8AGP3SF/i?=
 =?us-ascii?Q?JRd8IGqMzXj+aLRf1MEAlMTizC7QmUl9SO46Sz0MKfceSEimmP6XQXyENBZQ?=
 =?us-ascii?Q?HsVqHpZoOBZFd+b/+//VqXfMdoNEFkV/KPK10Cwd7scGk0VoQainNZen2PnA?=
 =?us-ascii?Q?IoRCY5a2E5jHHQywd2NYpNUr7SwGPq7Dir+PBrYgo4pU8Mj/6wzLGc1i/AtQ?=
 =?us-ascii?Q?OWjn7IABCXbjGtCvaMOFg0/F9K+lxO1jiB+6F8MDkV3/ZWBO1Vjj/bNDFVdu?=
 =?us-ascii?Q?Gicsda9pD1IyMnJsPmHMr7P6aVDiFcEsgXZuJFh9mHJtYQ2HApGgbMH1nv6J?=
 =?us-ascii?Q?W42zJEvUW/LjTcNJakiOx2yFx0srPr/CVULjHxpbgI75NIPixXShYoCvscbN?=
 =?us-ascii?Q?6K7ytA/B6QA2BvAPxfV1iBAOPJRp7TMSgpmoxJiSazXRBI9684AKY/HngO2D?=
 =?us-ascii?Q?iTKsKfwmMaLBQYYJ1iIn7RkClWqpoZenTWu8FoOy7KhINWJtlWc7NeyHd8NY?=
 =?us-ascii?Q?WHPdNSURphlayuIDIA7iBQW+UHAEtiqOwfwAaweZYquQ/ppcV8RaMUHL7zis?=
 =?us-ascii?Q?KMc7U8EnXVMEKPbHIQPTDoZGcYq93f5sxMNzJf7XFyHu+oZyU7Z85WMMu24/?=
 =?us-ascii?Q?C/yyCTuFRdX/60R3DigSIXuKh0K4c6SUnJvqxnvVSvQ8N+TLopOXzvec/pbE?=
 =?us-ascii?Q?+JX4fc2x/2W6oHI4O6MtZH/NQTFWGXUGcfG6pqcoKOqy6QDRNzkdQVbFXAZL?=
 =?us-ascii?Q?aqKT5osabf18yopgGTAAjUEdenx0NTLmx1by02ZvQKBfdIS9EUEFehXdF05a?=
 =?us-ascii?Q?/lsRXwHx+nqMxmuLa9RR8FUT9hfPatyu8DWZbjMm166mX6ue8UqH08v6UeR7?=
 =?us-ascii?Q?021u4T+uI9GvKI5zb6hfh457XtHQJraEjwE67t8ml5q1LT1eKwyGGhWe4YIP?=
 =?us-ascii?Q?rcsHGvqF7P4q5tBkXd+tF5wEEFfX54g4MgPmdRRMw3fNjlpBh7HFunxc14fN?=
 =?us-ascii?Q?aqraQMRPen3eRkzanTXDiWImWcKxgVEOEJl83+vPHkPvuhsdYAZySRYfV429?=
 =?us-ascii?Q?PST7HqbmT7pXX9KuW7iCK2FEsTfjpXGcvaBvvH3tqKtSTZ/NS2GNydRIShv+?=
 =?us-ascii?Q?QQVq9C95zTOgnHwC4ErCVvEMkBTvEXr5iByvsfJp89U0RrR5Hv4I81qcTIMp?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	64NRZlfOtOCaaz+DTvjm1csdqiwUf+e2uWqJwPqE1xnzY5ONmoe6OvhSmbs2n+jGass6WzBtEQe+CcGXNsLP8rOksEGClCeSGtEL6iSVHYiBrGDC8goImv4RO7z/lAjFK6Q6bGxMumwmuQg4lJc6oGqCBE7tfY1l36p4Vl3uRihxNPIhckjvy2C1Ry7h5EYhe/9M1P45+JIITPq/TDKXswC14so2CZyM13zCUEckqU4RJi3Nev9q4k1X9ns+sn9n8mQBF2C+zFbK967LwEeRAzhxyyEwyZa35yqMopQ/QaYcEzZrzxbDG0AH9V9MKvl/atzcpS24W+LAa6yyv+JVudM9JV9cOjOEXS1yboJINV2oY0cZC2B3EjZ6jbXwFMpUFYjzsUbiIXdp9YH9bE5hsfvimXrSzWJVwwUxRSlE960tmfjJFp7RsbIp3UpgbwZn4vmUVAnXt8j4w4q5U3ajAzlOOPVVMvHyOwnZi3WoDEVhjFi029mM2K92hbqnulNzJECphqvxgVOmnHRdIjqeV2GMsr5c4m78hPywIdqVabe/QQjAQfJqa34+fVdgIN1K8D4vzmPUw9uN1ItDMfpE083no/wPNS1sw49NOr0dd7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a987f7c-dae7-4af0-f4e1-08ddda721331
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:02:44.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjVeSVgfDDcvmw5/1xgBilO8TLhvr3kIj5coIMyxWew0TwGnMOS25jJj3+JsL0mBzNcWQRnMfDHG5v6Gqtkeew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130132
X-Proofpoint-ORIG-GUID: 8tvRl_ttEKusiBa-7dd_80p6khSb4ad9
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689c9b09 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1WtWmnkvAAAA:8 a=yPCof4ZbAAAA:8
 a=iZfw_hwLpUH7yu-2NFAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 8tvRl_ttEKusiBa-7dd_80p6khSb4ad9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzMiBTYWx0ZWRfX96scBxbQcnA1
 EFIgHOEC+7W29UdUIkEMIKKZw3QLzSrfsRlf6pTV42uxeZhLrbSJR/lvllb825m0xA3b341QL+N
 lNM794y3AUsuG+MfD3YnOS+Q9tEF+wacdQj0Lafe5i4gb5KoG+Scj0pwEN+jWifU43aBDuyiJnt
 x9fDFcG480WRBEEaP3hL2Yq4urypmZpKJR9y7XYrqVOVmg8hJkr9Oz8G/ncd/wMk9CQL1g1+Ewn
 Q51yLFgc7K1cPgG1nlTkdZSOMYow6CxG7m4QGXnI7q+YUrXoyL67vy67kv1e7Am2VaBcnklpG9R
 HIsCTStmj4oYq/YwppSSRy27ySMrPBpQduECtkLwt+fYD7cIRYdxQlVwTCnT+sJT/d4CcdZd1/u
 Mt52UWCX13SFYJx4mF+HSSV4IT0PGeQpajCc4XB+yvPDqECQij8UB9/DZ2K/M4WiTTk7pCmH

* Liao Yuanhong <liaoyuanhong@vivo.com> [250813 05:46]:
> Remove unnecessary semicolons.

Thanks!

One nit, it would have been good to state that this is a test code
change in the subject.  Usually I use "test_maple_tree:" or something
like "maple_tree: Remove redundant semicolon from test code".

Please mention test in the subject next time.

> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/test_maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index cb3936595b0d..1433ecc854cb 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -3562,7 +3562,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas.last != 0x1500);
>  	MT_BUG_ON(mt, !mas_is_active(&mas));
>  
> -	/* find: start ->active on value */;
> +	/* find: start ->active on value */
>  	mas_set(&mas, 1200);
>  	entry = mas_find(&mas, ULONG_MAX);
>  	MT_BUG_ON(mt, entry != ptr);
> -- 
> 2.34.1
> 

