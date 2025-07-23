Return-Path: <linux-kernel+bounces-742350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2ABB0F066
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F3D17C41D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB52C1581;
	Wed, 23 Jul 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BHGdm3qe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cqW6dqqx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1163C2C08DD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267846; cv=fail; b=MtVK/1qlxLebrks52S+wBovs6BjTICnrchfIF44pFG8Dc2yvd1HEDUW5Zme2lL/OvEV8Ka4uR9NrAIqCmDqeYTdPda3EwKv5wZGMqjXn5ePSaf1w6AaHMceKJDhl5EJ2TejaDkhVbU6G+TED/oI8HToLZJIE/LS/9d2qCCRrXMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267846; c=relaxed/simple;
	bh=R2FRw6NrWbnu/2aJHKe21aiD3tC5eULUjIK4eiAAGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RtMvXN6wyWWh4Fqah0ljBxTqSG5F+fTGJtZ9DzeCKWqqveg4fbtCgux62Z6FiHa9m34RSUoY3GaQO8e7sUuWbYIdybNFXkslB+NJn6UZ/GvMBXb9Da38ycCYX8lfQo5QqQLsrtKFrgrrN/1hwG7GL8vsRHTNzfxVz0FrA3pDTA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BHGdm3qe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cqW6dqqx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NNvq026141;
	Wed, 23 Jul 2025 10:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3QdUr/5MOw3aklOW92
	yhcOgRexJhji+m63BSi1mPzzw=; b=BHGdm3qeBRBWclrIQAUD34Z5q6Wxq6gIP0
	39MrAnL+/LRaYenOj0NXChkyLJnmxrFL9K6juDkuhsUPqQlXg/xXgguUD3tnbHSr
	k4/cDFmwgOpE1H9ausDqWUYu5VAgBibmRk8lx3zE1iaG1pij7zaUqjLIxp3o8EZc
	q4sBuG1wfrq+2kx2dJYhRfSW4EC3+bmd23bLlFgRz2vN5bWxY/T5fle45xjRIoT0
	X2UUbZlZpFZi8ScL8utlff1kAKhDb33O1nx43fTLHwhJm0HEo0jiGdMeIZyvV6JH
	f57aX1cL0e4IuR0xj7pqa9iR3FMMzqqoQ5tjtkq3TZBeXRlH7r9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805tx7bxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:50:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NAL98g031503;
	Wed, 23 Jul 2025 10:50:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tgrg56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 10:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdei2Cnj+w7pJmZA7BBdE6XY/3O3DLBS5GdxQeBi1VnCaBag41ihME/xqmU+6hrH7owxpOkVLjonqj6nOWKlnr18tCF4QheWKo+cImI7v1vxGsihNKwW211dLZDq8bZFucmHb9I2mBsCtNq3WInwAPFP8BbDT9WsfrBiCgf6yVQPw+zp74iarSBaalj7vu95ee13OopeyW575vbG1E9++9T4VuoaGandGXEU8gSiYSMEWZC48lPBL1JpiBvR6VlmWmW1Iw8hVhELVND6v/WbgJ6bTOk21qkdTLWWaSQlxxHcWl964L1srpHBuJ/TmEh8u+sECY87Q7nYi1SMmlrDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QdUr/5MOw3aklOW92yhcOgRexJhji+m63BSi1mPzzw=;
 b=VGACWwwFyYJRdonxHpW0wMs6Jfur24OTGxq7c+poma/4Q7wD09xd0qc5C/KtXHSu/CqbpFKHsSPDTSCajLgI+mj+jz7wdZmJyg67R/gPJavkSVMCJWRt8EhC+8T3FcpJJsPowu3149CTHDI8wRgNdfr2Ue8/FTV+7bd50NPaa3OiH1ZRE7saThKWi2kP+B3f50qAyAQPE7fH+9gysaBNbLBWJ6oq/4z92g/IW1HZSl5tqIUPAfP7C7EBJxIFGBN+hUNtV35JJ7jN+BRPU7aR6byWC/FXEWmIlIOt5RjxzYFcpH6PhS3ria79Nbs3MujS0YyL4Ppb/pvImqDmuOLXlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QdUr/5MOw3aklOW92yhcOgRexJhji+m63BSi1mPzzw=;
 b=cqW6dqqxlLmuCa95z+uUAhZVOieDt0Et/byZqMuNap3Gt92HmOdoC3ZopX+mrP1PkFAzUV5RBg5hFvJka9B37+MkLDfBt0Vfln2p/TkaAq8B+kS5MNzyxbN+s90fqfqCo8QI4scmkYUgsFdjzETDbxJfmsCC65mqEKFTZWNtGoo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF1EC0B6C27.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 10:50:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:50:24 +0000
Date: Wed, 23 Jul 2025 11:50:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] MAINTAINERS: add MM MISC section, add missing files
 to MISC and CORE
Message-ID: <39c72bcf-d9d4-4f07-856d-4cf27e55cf36@lucifer.local>
References: <20250723095823.21940-1-lorenzo.stoakes@oracle.com>
 <cbf19dfd-f1a2-4fec-bee4-137df33098d6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf19dfd-f1a2-4fec-bee4-137df33098d6@redhat.com>
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF1EC0B6C27:EE_
X-MS-Office365-Filtering-Correlation-Id: afa55a7d-ec0b-4500-828c-08ddc9d6ba89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6r0CiAjdz9nDbsXJpJrdCDcPINRC6loGOoSFxMNccKq2dxtKrbUam+WNetgD?=
 =?us-ascii?Q?Om7mxu7C3Fcx4oso80O6fAHp8PNA9htB5p6T29VPa8HGd0SohE8sYxDq0fvC?=
 =?us-ascii?Q?EGU2tJgL6Jk/UQzlJrcP3XYTb6HfCT07U956z6PB8dmB6aePU37al2pjAxT8?=
 =?us-ascii?Q?Hc/bkmwJ+SLyHrHZHcj0kD40FJErMnZS7L8FMgOZ4+fk/ho/QbdeO/uuuaPA?=
 =?us-ascii?Q?6bfs5lZcElE1kdoJp/4JKDfnaidFiLvu1L4ZZEFqhwHeuQDldtKx4dHx1G16?=
 =?us-ascii?Q?qtNC+rXLf/7Rzu9vjPRCcdhIepWNQzgbRy2DNO5ZsIc7RNt4IW38zILIALLc?=
 =?us-ascii?Q?TjoUGybUQXTNaLETKmTptYPFeOFtPnGYIlcng5MMtokjtkL6vXMCLcixcvAi?=
 =?us-ascii?Q?TTgH2oDyfQFPKlXFobZqCvooDBunJ9MfF9srSCDq5ZRCuTrO8zunWco8cyqh?=
 =?us-ascii?Q?uyoeSEENpyCQ3lEnVbGn9jNn6rJR0kedpcu65LLqEsfiNrfPqj+URPDzutB1?=
 =?us-ascii?Q?+cGR/+sIVw3qzT3EVAZWly1VMo5sfPta+6YglMzLKVRNd/3HfWHoE4d269Jx?=
 =?us-ascii?Q?830HXouc9rpI2T+M27tgQx4IaX9YD3MYTvMEtT5AkKSopscnfDuaWMO83umg?=
 =?us-ascii?Q?PZYe+IvzlgNSvClUzATuD671AoF1/cRN0qvLLzPBbHuAzw4LeytiMtA51fj+?=
 =?us-ascii?Q?KJz3JxfODGcAv93JWuSca2V0bkzMBBuRxv+zbGEw9GEeo7b6jRR181X+XFPj?=
 =?us-ascii?Q?TFuLd8x+BG9q+Lr1FbxI5FMdh6iKmcgszIDJFs4wH8693HxxXFqfDnwVxdWx?=
 =?us-ascii?Q?RbQAwHV2M9Aaapq5iSziV0xZO6PuNqPRxkt63xAW+l7P1jjEHZxHrMZ+RcPY?=
 =?us-ascii?Q?Z5z/qfjqtW8G1NKiP0qA/Nm1SyV1olMMrvlJsNWG02Q77x+r+0saONpQGV0a?=
 =?us-ascii?Q?fbCLT4HDVdDeh2Dwjho8I0AEHFYJeGov3OJTqNwDazZZNPJlnuPkAr7US9HO?=
 =?us-ascii?Q?euNWFLGmU2XyGJd1X11OxPsPtkg6OKYT+1sNXTlRBrZkWFBn2rryAg35kanI?=
 =?us-ascii?Q?4BgxgKHrIn9+i0jfS3Q5D/GHTdXC/Vnu18Nm+2V5a0GDBU4VpzjdbUIJ9vI9?=
 =?us-ascii?Q?w9qbFTyehuUKrT/ThhySAuyOm6eh/rJtHCWe9PKMOVX3mB8gLGcJCJqFaLSD?=
 =?us-ascii?Q?auRHD7FXcrsUV3rXk3P8kMxNUeXoYHQmEByzCoHhJAh3l/qzdl8xxI7e2F6U?=
 =?us-ascii?Q?VfYjXXcDcaJTwgNrrxZnRc/kTSRODmalShcknj/hwYOgklbAPn51ass9KNFw?=
 =?us-ascii?Q?7drNDzqzERmWkEfNDgCH6ilmBvpnHKUggDtWCEANQfx0sWsRggKV+k9O5cDu?=
 =?us-ascii?Q?Tmb5Mcut8LtqMe4cZnde+NbtRjvd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYqijKdpsAIfFNDd0mFE/Jjzf98yspHkMRi0qWquBcjLPHx/vu+wrLSgClKR?=
 =?us-ascii?Q?po+09ZbQZ0E928eozU2+VoOVh6VAbBS8AFep5bH+aUlUytzax8V8kUccFJUB?=
 =?us-ascii?Q?aY6RxxDg/oxJf2cJnUGQ1sO4Av+stGwhsaCER9jlJfgYuU6W5cLoryhuS0YL?=
 =?us-ascii?Q?bKFhyUB0i8KVrxpa9OYEWt6+t6K3K5Eok8iE+2NQsiCz1OfFH3nfO1omr3Cf?=
 =?us-ascii?Q?ziKLgR2L+381BABANIAbplXvPcWBqHTzvjlRIYU9O/3ZDce9g1CzBQU+bjqs?=
 =?us-ascii?Q?AAxTPWGLehd/Mjlmsb8pIf85yOKlBmJWvCZ8Zgp9FCUzLYWmFDv+gZpLMZuk?=
 =?us-ascii?Q?N4kns2tkqrHzQCsLrWelK12S0Wc9QHYXNk+ja+MeIGuepPgVF9a7s5Gnzpgv?=
 =?us-ascii?Q?WWiT1E3pud3sh9xYM1z2Euk+NZBkYtZIdKKJ8hJJT/F8fcUr54j+6CsPzNTV?=
 =?us-ascii?Q?YXBHcaI/2BKIT0VSWTQKrXOCFmmNTgG3LBS84Hiq0w1s67dIi1i9cn/TDIlA?=
 =?us-ascii?Q?ivFVLF+BsKyjWcSrzpLM4Czv6+7trpq3c/4TFWl8UEYxRonDVAQ3iML2Q3MV?=
 =?us-ascii?Q?ak4cOzipIml+GcE5YcsN7vIWy7/BiAooYMd6eIqXCoaozML9VTrK/yP1NkHn?=
 =?us-ascii?Q?LBni6mN8XoEn76IhemNAdyiOWvwGCS4GueUdfpY5SDL9ykDWP/DHZU/S+nsA?=
 =?us-ascii?Q?TLp9VeUYV98CVtwSS++jsU1T4OvRuLxeXxY6Yqdopmi4nP909YXxG3qaiGoc?=
 =?us-ascii?Q?K2Mc7Oea7U6asHhpJk834KfcDLwyr849FyOmcNHnSKbhanI1GsmQ8D8Jcuh9?=
 =?us-ascii?Q?HeRr2wPwN8ZG6id1haUh0aDSI1L/mVJy10mRYoKX7rOulvI18qhy80cZwIIW?=
 =?us-ascii?Q?5/NeYn9L0b3beS+tcYODQV3Wd/Jf2xoBoWE9C+bk15whPcblBhUp/c/kZ8Fs?=
 =?us-ascii?Q?caj7I3M56Vn/WH6+WFvFzRFKfxQfSBJCzC3urATxf9FBzAn0DHtiTLkW+xdy?=
 =?us-ascii?Q?pRjQi3RJgwiHAvSX6yH40fd4Z3J4DVKPiTFN0gFF97ljB01ZsbbgbpgEWkax?=
 =?us-ascii?Q?6rlPUqt1tXBrm54M/zstH7CdrJ/v3kb90ohd7MeghDU8fTIziz8n2Ce0pReE?=
 =?us-ascii?Q?QCppyrLU62iLNZtdp6yPiGhOH7k7/IsUHMB1ihZnzdsLa7GxM+/A7oyQFsU1?=
 =?us-ascii?Q?abvsTHMnK+eCzuquBwSGGfPY0u+Mw/ealAXXTyREMKgPHp0+v5siC4g+0kzN?=
 =?us-ascii?Q?Rnc7dVtbYmWt8vkhOddzLMcMQTLPNBG2bz+KYz9UGi5ewl0n8csYZbHNjgsK?=
 =?us-ascii?Q?2OeS1BgkfjGJDs+Bd6ynf8r+0PRfFjsOd9qrdMyh89unnlK0rn7yu7cwix+m?=
 =?us-ascii?Q?jSLDRdRxZGOQ2e300PvhazfkphUEeAsBeqrbqGPl3Lz7YZpO7kzcw3mQKdQ7?=
 =?us-ascii?Q?uRFBmoYFsSUFxYuxnvaV56ybB5wsBn4Yv+C/BKocgPUcfhi5GKU854ilMyVN?=
 =?us-ascii?Q?l4W0Y5IIjgIYXrZKyW8DO/4O8efrzd7AI++2lf2yQhJrTGY+PxQ5Ti0cyEKU?=
 =?us-ascii?Q?tplY54ySr2D7C1phaxl7NziMbJrLnG6G5UEb8UYDTaPn7mJb0QfFvmF55LHM?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HyA22/K3FIp6n9cdujxiGUzPA3zCQpqIFwKd9eR9yRyqROvy7j5xIFRr+Qi5oMizP+B0qkTPP9rhK7JO7FN9yAS9zpzjjC2wal6jJjycBJWyZHJHqrbwQ7u5tYF4dMpkLr+xM/5pF1KDxEnNM5PPs7ip8a9ZP++n48zzfifHsHC1i00/p0UHTWZaE7l/FiOMH9KVhTqaHUExyCn+4lBewzBT8hjcUxGhOMiAbQDlzWYrnsltZw7eiixJWDmc3nCLDHrdLldz2Ekq8Tp2K64LSz9GkHMZmL/qCQJJ/u39Zpa1w1k6UT2A2vgys0hrTADWq12iHWb5y2Jt2EsfOU0MBbWPpO1ofxk53qok6l/boGj6acwhhQ7y7nTI8k1fgLFfURtoUgfUcmP40dIULy/QOSJn7t5YIIyDMAPK2NafGDVNzkyvGR94LpFcYUV9ApBoXX6G2R77JAmMl4KoQrbF0fYCSgzO8n/KH0uHm8JPScdn1xLlf3EBz0D/5WdToahZAvHx9OVsDcNG5ldQWj7U+vnyKy/ZtnEznnU9cTCX4MtkKfIivV95DQQVrCdTfS7dSETB1JK03ozIWWVdRBZYhbrblp2jWDZ8SMqi8Cy0VZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa55a7d-ec0b-4500-828c-08ddc9d6ba89
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:50:24.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YiiMONoPMkBn/mIB5u0EYGg+bNZF0jSP5ossw4xlIBHMqfg3h1ctkzBak3xfnkim4BB7dnmkDbzv/E7DRDGvox3aulriQo4Cu612LTFY9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1EC0B6C27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507230092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5MiBTYWx0ZWRfX9k5NfvFbBD5X
 nWmtbQsKMSev2ctSJLxNHRZWGtkol2S/Ymv1Jgr6jbkJf8q4XfFsVVURy34Qc7xAE4OyHrbVvAO
 7aUF6olquZsXH2bnx8TyBWik2qK6Z1TJRY+ghWbSsEPQcS98OpSFEY6qN/z+EIFBbo4suvtirrO
 klPBF+l3701Vg17pIch58P5jl94DQkv6x3J6HVsfMoSesIy04gIPqFMdkQgK0anNHrYHi+Slrem
 aexU9665HHRBpkkZxjEF0WFtGEXWnlC9C839mhfk4G/pnzqiDUCic3ikzyaUfrPIScPwg5shbco
 vV1vGnknmfSJuwsw0jElywzIURYIvsSQSldcIa70WEpxGL8K79gcaD4lTulCDrbSyAsxKVZoOZ7
 kE8nFz0E/v2zNKT0YxSLBLj4tZsiN3/IwvJutka7UeNo68Ci1T/LpHk0RD92AsCrNHcJ9YZQ
X-Proofpoint-GUID: Mq8lWeXFuWdltIrK-WxH4V0KarHrQBEO
X-Authority-Analysis: v=2.4 cv=IsYecK/g c=1 sm=1 tr=0 ts=6880be75 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1-S1nHsFAAAA:8 a=Z4Rwk6OoAAAA:8
 a=37rDS-QxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8
 a=8TyXHA1wEKZpi4cGJ-YA:9 a=CjuIK1q_8ugA:10 a=gK44uIRsrOYWoX5St5dO:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22 a=WzC6qhA0u3u7Ye7llzcV:22
 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: Mq8lWeXFuWdltIrK-WxH4V0KarHrQBEO

On Wed, Jul 23, 2025 at 12:36:49PM +0200, David Hildenbrand wrote:
> On 23.07.25 11:58, Lorenzo Stoakes wrote:
> > Add a MEMORY MANAGEMENT - MISC section to contain files that are not described
> > by other sections, moving all but the catch-all mm/ and tools/mm/ from MEMORY
> > MANAGEMENT to MEMORY MANAGEMENT - CORE and MEMORY MANAGEMENT - MISC as
> > appropriate.
>
> Curious: do we need the catch-all because of untracked files, or because of
> future files?

Untracked was the intent, future files should be added to MAINTAINERS
(maybe I need to write a script for this somewhere...).

I guess the intent was so Andrew gets pinged on everything whether tracked
elsewhere or not?

>
> >
> > In both sections add remaining missing files. At this point, with the other
> > recent MAINTAINERS changes, this should now mean that every memory
> > management-related file has a section and assigned maintainers/reviewers.
> >
> > Finally, we copy across the maintainers/reviewers from MEMORY MANAGEMENT -
> > CORE to MEMORY MANAGEMENT - MISC, as it seems the two are sufficiently
> > related for this to be sensible.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >
> > v2:
> > * Propagate ack (thanks Mike!)
> > * Retain MEMORY MANAGEMENT section to contain the global mm/ and tools/mm/
> >    directories and remove from MEMORY MANAGEMENT - MISC section, I misunderstood
> >    how these catch-alls would work. As reported by Vlastimil.
> > * Update cover letter and subject to reflect the above.
> >
> > v1:
> > https://lore.kernel.org/all/20250722192704.164758-1-lorenzo.stoakes@oracle.com/
> >
> >
> >   MAINTAINERS | 68 ++++++++++++++++++++++++++++++++++++++++++-----------
> >   1 file changed, 54 insertions(+), 14 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 507a999f1955..5a9d4c57add4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15741,22 +15741,8 @@ S:	Maintained
> >   W:	http://www.linux-mm.org
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >   T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
> > -F:	Documentation/admin-guide/mm/
> > -F:	Documentation/mm/
> > -F:	include/linux/gfp.h
> > -F:	include/linux/gfp_types.h
> > -F:	include/linux/memory_hotplug.h
> > -F:	include/linux/memory-tiers.h
> > -F:	include/linux/mempolicy.h
> > -F:	include/linux/mempool.h
> > -F:	include/linux/mmzone.h
> > -F:	include/linux/mmu_notifier.h
> > -F:	include/linux/pagewalk.h
> > -F:	include/trace/events/ksm.h
> >   F:	mm/
> >   F:	tools/mm/
> > -F:	tools/testing/selftests/mm/
> > -N:	include/linux/page[-_]*
> >
> >   MEMORY MANAGEMENT - CORE
> >   M:	Andrew Morton <akpm@linux-foundation.org>
> > @@ -15771,18 +15757,32 @@ L:	linux-mm@kvack.org
> >   S:	Maintained
> >   W:	http://www.linux-mm.org
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	include/linux/gfp.h
> > +F:	include/linux/gfp_types.h
> >   F:	include/linux/memory.h
> >   F:	include/linux/mm.h
> >   F:	include/linux/mm_*.h
> > +F:	include/linux/mmzone.h
> >   F:	include/linux/mmdebug.h
> >   F:	include/linux/pagewalk.h
> >   F:	kernel/fork.c
> >   F:	mm/Kconfig
> >   F:	mm/debug.c
> > +F:	mm/folio-compat.c
> > +F:	mm/highmem.c
> >   F:	mm/init-mm.c
> > +F:	mm/internal.h
> > +F:	mm/maccess.c
> >   F:	mm/memory.c
> > +F:	mm/mmzone.c
> >   F:	mm/pagewalk.c
> > +F:	mm/pgtable-generic.c
> > +F:	mm/sparse-vmemmap.c
> > +F:	mm/sparse.c
> >   F:	mm/util.c
> > +F:	mm/vmpressure.c
> > +F:	mm/vmstat.c
> > +N:	include/linux/page[-_]*
> >
> >   MEMORY MANAGEMENT - EXECMEM
> >   M:	Andrew Morton <akpm@linux-foundation.org>
> > @@ -15844,6 +15844,46 @@ F:	mm/mempolicy.c
> >   F:	mm/migrate.c
> >   F:	mm/migrate_device.c
> >
> > +MEMORY MANAGEMENT - MISC
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +M:	David Hildenbrand <david@redhat.com>
> > +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > +R:	Vlastimil Babka <vbabka@suse.cz>
> > +R:	Mike Rapoport <rppt@kernel.org>
> > +R:	Suren Baghdasaryan <surenb@google.com>
> > +R:	Michal Hocko <mhocko@suse.com>
> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +W:	http://www.linux-mm.org
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	Documentation/admin-guide/mm/
> > +F:	Documentation/mm/
> > +F:	include/linux/memory-tiers.h
> > +F:	include/linux/mempolicy.h
>
> That is already under "MEMORY MANAGEMENT - MEMORY POLICY AND MIGRATION"
>
> > +F:	include/linux/mempool.h
> > +F:	include/linux/memremap.h
>
> That will be MEMORY_HOTPLUG, right?
>
> > +F:	include/linux/mmu_notifier.h
> > +F:	include/trace/events/ksm.h
>
> This is already in the KSM section.

Ack will send a fix-patch.

The ordering of these patches and sending all separate has made this fun :)
I felt best way, so one update with issues doesn't hold up others.

I am _very keen_ to get this done and dusted and never look at MAINTAINERS
again :P

>
> > +F:	mm/backing-dev.c
> > +F:	mm/cma.c
> > +F:	mm/cma_debug.c
> > +F:	mm/cma_sysfs.c
> > +F:	mm/dmapool.c
> > +F:	mm/dmapool_test.c
> > +F:	mm/early_ioremap.c
> > +F:	mm/fadvise.c
> > +F:	mm/io-mapping.c
> > +F:	mm/ioremap.c
> > +F:	mm/mapping_dirty_helpers.c
> > +F:	mm/memory-tiers.c
> > +F:	mm/mmu_notifier.c
> > +F:	mm/page_idle.c
> > +F:	mm/pgalloc-track.h
> > +F:	mm/process_vm_access.c
> > +F:	mm/ptdump.c
> > +F:	tools/testing/selftests/mm/
>
> Kind-of a catch-all as well.

Yeah but far smaller and we really should be pinged on these IMO. Probably
we need more work to add tests to relevant sections.

MISC is sort of a 'everything else' and we can update this over time.

I rather get us to the point where _everything_ or more-or-less
_everything_ is in sections and then iteratively fix up as we go rather
than leave something out.

>
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks, Lorenzo

