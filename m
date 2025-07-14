Return-Path: <linux-kernel+bounces-730263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EDEB04212
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966521A64D59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C82580CC;
	Mon, 14 Jul 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VF7PDKfB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DIn2Ecwr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C2236A70
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504268; cv=fail; b=PBO/GfEsBU4xQifVWKdAlpeWSQF7dOgk67b8AJfh9DGHWc+1oWM8+hoWVmqLpXX1N95tjwECkIeBGcKMS8Yh4+lLR8D/w6T6e2lFiTKoWB0yj42lFKtvFlsXGRCKpqHsdH+0+JMwjOnMHIrshfLK2SNnmAcoUN8E95lmtMEinTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504268; c=relaxed/simple;
	bh=H5EV9lU1/cgf7xqJPuQTrgJ2S7U/f6JtRGWooA5EwNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZTfjlpudJhV7zeGNTr1NbmmWQFm8SqVPNhPi6yxkYJ/rTi7RRblxzEkvZr/L9PaBxT5AH/9zeWfwbWKgVdxy6ljRQJ5sLlsi2jb1w4PD9g8arjANeeyMjwO1+IV6JQ2bXCTRLhDqx3XejxwLCgkpJFivut+yUuXRl5bV6ivx0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VF7PDKfB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DIn2Ecwr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z61S031362;
	Mon, 14 Jul 2025 14:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sDJ5+x8YYtMeSD1RCz
	2qDUxkl+6Lh/TbadNKmf9QP9U=; b=VF7PDKfBGdGO08MZ9pPmphrOMbLbjfYi4b
	PFjerl2mDNFF0HKtSlncI1IefKxPxalU1851UEYn1FcR/B0T8xj3kd1Cf6/ID25a
	6NzlZ1mUgh1j96tNtLHC7BnAHLYCgrfa+EBckadMvqpENjLA/Mc66DdCtusCIK/C
	Kkbp9TI2an8GH+RF/m+UxscrwiicGdp4eb+YUt2YiUjo6cAz5A5xco13vtDMJYWb
	M+1h29omlPkhiM/AWxcjgdSTVE/FKnj3voniGO1m+0mjs/MUz4A3BYngAHSoRh0D
	AIV+j19eSFxNsmuqAMxs1ugm+8d9Xu/8xjdpYpWMrbOF9uPMYx+A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4m95f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:44:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EEhIIw012988;
	Mon, 14 Jul 2025 14:44:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58487y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 14:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFbduY3SxMMZgJZi2xFlEsbrljcSiXZym1JVxyxINeU+8++A6i1uRYL++gfWLhbdnqfrLyGNgm2BrM2MGYAysv1pCYDWL1jsiQbTLMHDAYGw9AqQGZG7Me1b+a8P+uHXbdJSmYMWG/R7t5u0DXXc3aYABj57rt1HLrwye7ubsOamwBpwHMgqSvvNWcgSRsg6BfmcZHIS2xz5UeeZ0cEeDgC7OOS75SokW4WohU7w36oQKQtlSaLn35yOe5TY0Fco3uN267gPq166OH2GXD+x1vpeaqYVAh6Y/IzaK8BOWuDKpvBhZXilaCQ2ASu4gc5ui7FvToqk2OMtqbCdpALf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDJ5+x8YYtMeSD1RCz2qDUxkl+6Lh/TbadNKmf9QP9U=;
 b=Dg1B3PDLmRHyj7yT7qHKirjcom76hGAcm5Gz03gijdI1vw0Oa8CyYxBJeYKAF4NYbR3JLERr/HIb484PZW3YMujF7qCqZZvGd/hxf+4ZxtNNQLzwIem1g2A3Sjz82/5vmc51tiMio7S4AJyx4CxAm7YUUrLcKoZi1Kw4+MUe7pZpPbcTkgrKotBwuBz86+tnOLpywz49VNPyLd7NhjzvqY1UQwnInfbSNa0fRolxKQ3ZRT+l1xV/f3DHig6ro448cAOUICqiOuO7jQ7S7gdpWF4gQh/5+4SlDIBUTTqgBBFaFqVaVY9/zjhIYcP7UHPHkq062SAOlr9f+5uBO2yJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDJ5+x8YYtMeSD1RCz2qDUxkl+6Lh/TbadNKmf9QP9U=;
 b=DIn2EcwrXHKnP3A34ZUKfye6yinPczWvJpEZJnzy/06W/u+tXFF33gruZfTCDcxQk91bca18pXn81peg8kMyNRminYuWRHrsuSL1WNMYZzvoe86M73l4QtBWrIccfiDYhCGAlW+LU5Qy+CwV713SKDY6A4ZQVx1NWk64q8ZMIiA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PPF1D4534BE4.namprd10.prod.outlook.com (2603:10b6:f:fc00::c10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 14:44:02 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 14 Jul 2025
 14:44:01 +0000
Date: Mon, 14 Jul 2025 10:43:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vma: refactor vma_modify_flags_name() to
 vma_modify_name()
Message-ID: <u7dta4gc7h3bkugxchev5k2qlk5yzn5aygkkggmh75ppu6edho@tcc3zbby43un>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PPF1D4534BE4:EE_
X-MS-Office365-Filtering-Correlation-Id: d87852b1-b47a-4e59-addb-08ddc2e4df9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtKS4B40bdCArihEIJG0tZgCLVJ3kU/obWdAU+l7e5/FZqk7Qs3339GxW85+?=
 =?us-ascii?Q?4e2tyAn77c3y7e+OZOYKvqzjJf9qnymiLUH0ScYfz6rSlC3u0EvWvNfLVT4l?=
 =?us-ascii?Q?PRQCfuhzNdpYzLvhYuS1jBVLIq9Pl2HGRHshWW8A12/25JpFySKgWWttnv/3?=
 =?us-ascii?Q?EaCo91ASMeb4i3RmAHR2uPkYHYBsg0Xc72LUbixfgprcxMySoZxio7tTKz84?=
 =?us-ascii?Q?X+UfrTYbW7bxhzMMNxKf9SncoMD5lEf+xRwwBi0dv7vm47Bn/rjnsAoD/v/o?=
 =?us-ascii?Q?jJBOPpOHgZKaWjs14vg0CkUP38DUKpn7Q+kNjcwyhWAd8sbIpe82O5hy3ph1?=
 =?us-ascii?Q?LJBG2IBMkH/DKb7pD+s/nwyEXtgk4+JqFsJq9xYy5LMIXBYRy3uwSJfVV0GD?=
 =?us-ascii?Q?M7i3I5lBdXEgGCNcqNWDYj74aSMWU9BeEE1jhVW4X60qLaZIA7Adn4irJ215?=
 =?us-ascii?Q?CRdM1TLfqdnk7j6O1jNNk9VAmTthWvHkxHFj7Z8gYNhWlTpY5YmjTiiMIyvH?=
 =?us-ascii?Q?uhy6b5GORM7GClqQ+AptsccUSbdgLJDKlgZbzaFyZNrmNefuA8ZvBm/vRhP4?=
 =?us-ascii?Q?sQ/QOh827WmSHA8wAyMpWp6Lo2MGjcHlW1d7JoUfn694pScs9Op0UXVo7vup?=
 =?us-ascii?Q?S8NCnTY2ZXKTvD29aoRlVb5qYIUCnFfdH8DDV7zIoYXGOnTycICMnIORwQ+w?=
 =?us-ascii?Q?y1R/mf2vwdvfEs9d3G72K24PqGr/mQ37nZSQXEizUOGyaOKjOYZxbhUQjoAg?=
 =?us-ascii?Q?kS4IYD/uo+ZJN75/4FZU+A6gbDutD7RYq8otOKrIa9De6xM6FoIu9cdml2tH?=
 =?us-ascii?Q?vM3VezcOX4NvNOrKVWaU4Js+RRZes9S4gJ+cM8SspGwbFB5MEmevY1uAnMFU?=
 =?us-ascii?Q?1TNmHAkULP0/PDl8l5Q1CTnO+TEkT2QsZ2Qi3f56NeJFVPpFmrp5FSz37Enh?=
 =?us-ascii?Q?IPgMl6VgMtt5w4Jtfjxba2UDHvxtMNwrfVnvU4+yn6RrwSMwBmlLm6WMVo+a?=
 =?us-ascii?Q?gElPqATylSA3eC9D1YsQhoEaqDiThXDmDr4RlP4nIf54K1DQdlj95kcinktA?=
 =?us-ascii?Q?LF4/VUYcUt4YoCvX26PVm2vcD/um+xSNe8KvrjUXEjaC2yxg+zuTGTSpOhHF?=
 =?us-ascii?Q?Nhv3icGcSjAvboWIsx81Io5kk2deI+OdYSRCw+nVZG92NfP3kpijnsKOIrMN?=
 =?us-ascii?Q?r1MJCanyIPY46qTQu9oKKsL3rhPo9y5Xo0wjqyKec8nSPGXXG2LLD4zzCN3y?=
 =?us-ascii?Q?SZ79ihXZlZgM+aziNKXFh0o/ggn5GdD59TXnZXP3QgDNLsxySksFxTrBVOIO?=
 =?us-ascii?Q?FUhFVvpra7cwRLwnHAZ7qBl4ffuiWHcqY4m+EKmYt1zSi8KFMdmVsrAB7H3J?=
 =?us-ascii?Q?dx5O3cf3snxNCr/2tjRq0lfMKuL8kmQIPnNy+wxGe0PTvOW4X3Jd/1CKwjJH?=
 =?us-ascii?Q?+iyWzw08Ycw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8kgcbdgq+TuKj/bR+JSZcfq3R6lHJj96sopp7eqYkVUjQNY5Dm5hLp+54zM?=
 =?us-ascii?Q?YHTuI5+T6e0v1yfHZnLP4BqrWOGf8cWSfS7/Lt/ETNeK0t9oD1hUvTXFJoA/?=
 =?us-ascii?Q?X8HEl8bG+u0zm2Vzc8bqYPZpak7BzlVm2Gj5cTZdI5A9JvZ6HtW0rAQXDB4N?=
 =?us-ascii?Q?Di4O0yHSWYPur0fPT5JRISl4Rus5lNIfACRDDSeSHnQevC0O57i0ZENouoaR?=
 =?us-ascii?Q?/5DqILMcwJg1BizPuO/yCdNzkNy+Lrw1K3RymXRshwG1sMPLeqihAdGZyvFA?=
 =?us-ascii?Q?Bsw/9xPi4KcdSzZVk3GC1l3p91N85NzWfevxyfDqZKQK/fBFUuCzfth11Cdu?=
 =?us-ascii?Q?83SEkwB4ildf4JD1WGLvTtxIvsVhdAtNWDD4940F6Fd+GndcNizKJYifuORo?=
 =?us-ascii?Q?xZQjl/ZiRVRkf4mEw8pwqf8ApUmgjZnjjrZrc2eij8Sdotn2fUYTFck4O7mx?=
 =?us-ascii?Q?v8aiy+bkwaBHhtcjtxIPv8yw6Dy/RezsUlIyTOTEVRyiNmPhY6jQUjjgHP46?=
 =?us-ascii?Q?azIDcU1znCD6N8hDTkAoOXiVTn3I7xprqEofMKpUi+bi74rE1kVTjkMj738H?=
 =?us-ascii?Q?ojRDg3HCxcEAEa3AHhHp9jIF+JZJcucS6kae8s+gKJ0Sfhy1b/VG0xV7yiUF?=
 =?us-ascii?Q?x49fNDRCq+54PXc5dCiZof0Fl2gtfTL95yFInh66S1gm/0yOv5/c6Os9vAJw?=
 =?us-ascii?Q?1SRpsL8Bunh9KMSaerKYtzP+6dltTuXGuGXhAQ6kyAAxw4PFlw1UqnUwTrNC?=
 =?us-ascii?Q?CaJn2ZC0md+xinnfJONsNCshM3bgobEdmY/3Pg8UcW7UsY975b0Of2rRlTQ2?=
 =?us-ascii?Q?j2VwgFpTBUvKTtaIBDjzcniQj9+3A6WIgQfQ7BNo/KbiR1+Km4ei7tBiVf4y?=
 =?us-ascii?Q?qsVmoQ0oDx7TzsL2FutrAhGL1bc/i15ZAe8Y/4f3ax22wdWXKu0NTbWqhmvG?=
 =?us-ascii?Q?22uqe4xcLkvlN0aGJQMAysCmjsw21ptXF55BIAuaV9tnmxPEzMsbbd5fvO2L?=
 =?us-ascii?Q?4+y+pptnHPmSAsbesKZXJr+5Mte58zL7SMRGtQ8mbYJGh14uRAsy4kicivOD?=
 =?us-ascii?Q?cfFQLbK/RSwAcXeydIUoeq4955iPwmvLg5UfohXhUl+eq6iK0c/1pYY3pz32?=
 =?us-ascii?Q?Ywh87fplW8YsLSF/FppjbqL2Ip8daA/A6AGtbwZrTkAQdunNW7TllZI6B38+?=
 =?us-ascii?Q?tkAaC1znsLw+2djcSQYhQPIM2HuuUKrPoMimZsOUjUbUZCIYEZHO3NEzSvgE?=
 =?us-ascii?Q?dUC4CLxsaBSeLsJasorF4wVkR09mY5jWKvcUXBw3aJZUfYHpk6HCdu/WVrgk?=
 =?us-ascii?Q?Dr/XhduGlvSD6/DntxPAH2K7m0UHAi9/lTormSOscVSfpE0KronzDm9z5qiT?=
 =?us-ascii?Q?1nM7R7/SAJkP9Qw3Upw88FLW6msFAFq0YtpqfOPvMQ2U+mv4qHsahGFLf6ZP?=
 =?us-ascii?Q?238gD+z5xMTZaoexf7TVzguoHtnsMvTM1lM9uldIoMGyvAYQb8EyRPQK4S9Q?=
 =?us-ascii?Q?SmJbeupkHJteoVl1CB4+72KYfVJ9u6AT6D/N7Dy0y46YNjRwfyr+k+sj5hZ7?=
 =?us-ascii?Q?Jy0C0HGrHOq+6LL986DRVWkJT509nxoHMa8tyMX+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eVMw5lHGxCULU5MNgnXOD6Ggj1bIjtOEUmHQ6GeVKQQ50MYJAz8/nblUQy85wc/JBBpxBYGmhGPLJG29xm34lErWjWqfsuO8q8WqXC3dsNKMX9FBi1JkWTWc7Yf2mi6qVaxUwa1bKUaMBB4cqjeHu31RymkQb8JH4sjbThUzfIjPjPmi/Yk8ZhmTZ8kNduG95vyc0ljRorIvqMhN1TNuNc44HCZbnNZ7rG6/N4Wf1XzQrJ7nb/jbcfLhhgEElDHiUXS1wxzwJed915zuCgzFEYgYnErdSFxic3a7Gk02tOEzBzlM+DXAArFiXSs773zekXvMcr9IazeXejSripsz5Nr5faoG5eHI9qKDJqmN9sXAsuv49NxrUyAYdYkYziqnEhkBrUToki9/78mv3E/tjUuA8IJtnuRO5nCzJucuYInWbFG3nQ+mjmEX8KSInnkv9+8AHwv4IZukVdbxf+H+i1QolaLfbl8jkHsNyG+7NPrG3xNNk8W5lQWgt57yIcT2i01zVl6CckE/PDkycu7IworefFrP59LVm087Rz+f1XWo1I5gkqigyI9UbhccsO2fq0Uv96OEFtrNAqFxFClQz+Zj3sVzqM6OzYspjs4wIsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87852b1-b47a-4e59-addb-08ddc2e4df9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:44:01.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWHFaR7f5OFcDq0M2x17qqBrI+lA7r1pgm+3CNKhn+HHP7HLyWpjK0B4wDNfr+GMWozsYV1aDjYU99znP61/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1D4534BE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140086
X-Proofpoint-ORIG-GUID: JRblc06I794xGqn0kX8O-P6pD7yasMOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NiBTYWx0ZWRfX+wIvjX8+cmWy 2XmbDV42wImk3kFbQ39wVJSgpwXZbID+7B5wRoeyNxNQoHNiP0as48IV3LGbzZSph8QaEvhvVJl h6aMwI8fiwGmFkDgalcDaj3wEYcrpCTcPVmeADV5W7Paxl2x83EjPPpVOpYEeEtaJ/MQhrNhYd8
 43FMtH5cgUgE2Dz1/ItQ1pqXPPdva0e+gv1gtpzVHIGc94mwWae4VNVZMgGC+vG9EPPl8Q6Qk7H hwTwLtXAvprcQ2HFyYXASnni+opPxEmPhBuzGFt1UrQIDVVK8uvJ+WjqaHQujugWOKAoa69I+nG ILcLt0fk+nshujzIaVx3tnA3qYn7zsa/E92t41nrr6ihTO4Q/kEbtPWjMz548R3hbfrwHvoaCEV
 SK+QxI2+qnEwLkvye0OEZF1EL9n+s543CcxwA7xy01noLF5/kNPQkp+KZnSiqGtMStrm9iSq
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687517bc b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=YJ_ljrkiBCtyFHit7pUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: JRblc06I794xGqn0kX8O-P6pD7yasMOU

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250714 09:58]:
> The single instance in which we use this function doesn't actually need to
> change VMA flags, so remove this parameter and update the caller
> accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

David already pointed out the document fix, so it looks good.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>


> ---
>  mm/madvise.c |  4 ++--
>  mm/vma.c     |  4 +---
>  mm/vma.h     | 15 +++++++--------
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9de9b7c797c6..afa9e4db2adb 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -162,8 +162,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
>  		return 0;
>  
>  	if (set_new_anon_name)
> -		vma = vma_modify_flags_name(&vmi, madv_behavior->prev, vma,
> -			range->start, range->end, new_flags, anon_name);
> +		vma = vma_modify_name(&vmi, madv_behavior->prev, vma,
> +			range->start, range->end, anon_name);
>  	else
>  		vma = vma_modify_flags(&vmi, madv_behavior->prev, vma,
>  			range->start, range->end, new_flags);
> diff --git a/mm/vma.c b/mm/vma.c
> index b3d880652359..fc502b741dcf 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1650,17 +1650,15 @@ struct vm_area_struct *vma_modify_flags(
>  }
>  
>  struct vm_area_struct
> -*vma_modify_flags_name(struct vma_iterator *vmi,
> +*vma_modify_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start,
>  		       unsigned long end,
> -		       vm_flags_t vm_flags,
>  		       struct anon_vma_name *new_name)
>  {
>  	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
>  
> -	vmg.vm_flags = vm_flags;
>  	vmg.anon_name = new_name;
>  
>  	return vma_modify(&vmg);
> diff --git a/mm/vma.h b/mm/vma.h
> index cf6e3a6371b6..acdcc515c459 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -290,15 +290,14 @@ __must_check struct vm_area_struct
>  		unsigned long start, unsigned long end,
>  		vm_flags_t vm_flags);
>  
> -/* We are about to modify the VMA's flags and/or anon_name. */
> +/* We are about to modify the VMA's anon_name. */
>  __must_check struct vm_area_struct
> -*vma_modify_flags_name(struct vma_iterator *vmi,
> -		       struct vm_area_struct *prev,
> -		       struct vm_area_struct *vma,
> -		       unsigned long start,
> -		       unsigned long end,
> -		       vm_flags_t vm_flags,
> -		       struct anon_vma_name *new_name);
> +*vma_modify_name(struct vma_iterator *vmi,
> +		 struct vm_area_struct *prev,
> +		 struct vm_area_struct *vma,
> +		 unsigned long start,
> +		 unsigned long end,
> +		 struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
>  __must_check struct vm_area_struct
> -- 
> 2.50.1
> 

