Return-Path: <linux-kernel+bounces-731946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32BB05E10
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBCC580402
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313D2ECE8B;
	Tue, 15 Jul 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EfElaiti";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBLa+/hg"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43E2EBBBC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586698; cv=fail; b=iBm9aN02hWuSzGUIQy5OVbuS+bd5E6LDvcC/xU489bBFPP72IQ7oOSB38vlPx3IEh4A7x37ELymS2wY+XuiLYvM1N8ZL5uPfH6NLnQ3+QSVAQ9wzEIzm+abU8Tw8+nmK2oEceNZjHTWBe6nZgFVw4CqrwiBNnj9NXf9mqHkYIxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586698; c=relaxed/simple;
	bh=1qMVxgCfdwoKZfhZQgAesqL46BpnqR7AAGvcMyAAkrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7KHsxwsvaANhrfSzQErfxeVT3zn9aFGrtTrw2YECLzn6MPqV628P1PnwEQqfKGkWrR3pVEw8sTF/v+vaoizhMD8Kdu8J9gUaNiZAlUGaQ4y7KWOn7JiL79l6ZzmR75ExQh3NbrFUbnNDGZYeQ9oWppJQOb4rSuVrHWxi0yf67A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EfElaiti; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBLa+/hg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZCS7009061;
	Tue, 15 Jul 2025 13:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g2NXKJ/cW2O88FN718GRfshc1bijHstDgT6AtOhTkgw=; b=
	EfElaitisTL/u2CzTgepEqQ+ac8p+D6h+U3D2vl9bnDFm4NGtYzMGbz7QQ2deXWG
	3W1avuq+kJckMWOuV+Hx8ZjqeREk8mnAiPdXDDqfJNrfO08HHczYPrmA4IICj4wr
	to1ktM2U1sVs+NQcmmqTBSim4+pa+V6dSl6p7W5YW5s7J9c5btIhMmAh00+xjNum
	Dcb0V20Xigm3Ht2h0bQyscYF+xHO1sySKWXFTF/dNPG+uQ/Plmnp+IXz7oD9MtH6
	i0Oenz3zVQ5LdDiSeWQ2h0iO48Vt1/2x3fyJ4AWmI8NjE4q2oO/xn7rtwg0MkW73
	N4w3kfpbnoUix3nHCybqIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4pkwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:38:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDARKU011692;
	Tue, 15 Jul 2025 13:38:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59ytbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 13:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QX7I5l6Ar0TUqJQSIrQOSjsT6PidoNq43ZCQ+UxwL3pmJYTuozlU7Tzwm8bfa94w/N9X6EsuY1gWb/k3McqOkhx53VGsZ0jg3UfQ8RronICIwxdSo64zE9PlaVAgKqqO24LiVIxcI9Ft1pg+aQ9Bl2U6jgahsgW0HHkcXbDniApquOQtJVtCXNytd3SW5pTjRxHmUucE0OQk8vijlX0wBAK2KbgNFYjhJ9KfqbxRfXXEc1kUshz2w6XNvnvW3BFaMKY1PJLPtJvsEfs4vQan55sCyBewXDH1ecIk4oq9VpxwHD5H6WxUUwqencbSxEMEJUwwhx3QsKPBi6/5nAaeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2NXKJ/cW2O88FN718GRfshc1bijHstDgT6AtOhTkgw=;
 b=HI3kQUQ91oEf5Wehb9spoje6HD3hk9twFxjS6URzj2loyi9z705FlUbezazEjTVCQ7sB1Csm039rKZMhTxzqKYWsihQSgr/jEsC6rSRADFL5WImA+Qm9uUWrr7qRUm9+4oT1/wmYZw3YwWKyRyJDVCK7y5KZcmfT3OUUUHVyuEgcovMTHJ1w2wQMhtgU08sUN3E1+qfbgDSynYgh1QmR/nJEwOu83w46IUx0H5f8+43e+LBSTiIepOzR1i6Wti2ub8EPApM09Tw3n2TKb32e95+P6HclBkvf5dna8NtuTHI5raWJHA+g4oqWMvHn1wTpP++NYKTBgkOSOj+9kikfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2NXKJ/cW2O88FN718GRfshc1bijHstDgT6AtOhTkgw=;
 b=vBLa+/hgTmLam45SWTDt5uzYDTMbvOjPg85szfg0HcbwcETwivOH8OmHXxu+NdOZ0qLj+OkUXZalhBZ+CXGax1dMAyQwc8tjzqDjgEf45n1QvnJ/J+YtYsrm5XVxEFhcmqrOVGgPhvOPtZI6OPfKKSW4OMWYrHq3r6D/o7khW/Q=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 13:37:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 13:37:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 5/5] mm/mseal: rework mseal apply logic
Date: Tue, 15 Jul 2025 14:37:42 +0100
Message-ID: <1d6abf27d8eac0001f8ad47b13f0084ceaa6657b.1752586090.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
References: <cover.1752586090.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0470.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 953761d6-17e6-4081-628e-08ddc3a4cff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HnJ4RK/Dg/HnkCsDUEqnNBsLGVuVUjfJVbruf+M1AbE/FjS5wQGiD01nPuT/?=
 =?us-ascii?Q?0J8J9DDgfZ32Uzfv8KBXdSpvmp+VJjyQpxTxBdGqY0h8bU91i5EGYhABY8pM?=
 =?us-ascii?Q?OM8M2xp/1B8WVUckZV+RjQPFA2s6tQPGMoAK9PGl/myYdfVqyJ7Rv+jfZrtc?=
 =?us-ascii?Q?5B8Rzb6fR0s0NE7M866g6kPU2ALyv1JCTfqkURSf0jo6Q7tUv+IJgaSw13kp?=
 =?us-ascii?Q?r2porEv/B+JZWBNwRuNvdo5xyD3LFcE4IJoZq13/We8kzr1qNdC1lUNLfvc3?=
 =?us-ascii?Q?JaN9JdkQyffkInc/zmxG3uvQR7LwaNMMwwKtOUUkDeV76Iolxv2WHULT56QP?=
 =?us-ascii?Q?WRNBUnIwGw3o1ijArctkiRACvjVKckCxZ6RGvojqj5qqJ/42O6mOxD1dKymB?=
 =?us-ascii?Q?0nWuJmrTLzytEJyxQkSJsDSzY74Hh0g3q9E8ihRdiTIYU7GANy4cM9eVgXGl?=
 =?us-ascii?Q?i0dPm7bw800q2S3svZuRZvepqr2mdc9LXbtBwZ7lK3HknheMvM7MmjF9axf6?=
 =?us-ascii?Q?pjy2QIobykAVJJj9fBVW7oMynDUitvOd0R7o4ZWhxLXPNsmPDVHZNfcoLpFh?=
 =?us-ascii?Q?4uFCLgYvbRNldFAF1Oshcv5+Vdq9BRGhGBzbWMFlBB6JraM1GfQ4s1kgYkFf?=
 =?us-ascii?Q?B/P4EDlAvVC+pXAIJFbdLYmXlSXr+SMMRZCAxBWkkP/NzOuy4YFn8BvY2JNs?=
 =?us-ascii?Q?crfpcXxF9AD2dt3jyVcqGXkYsyhdMuut0qT9038ifW25FpWxvR8U5pRMnIkE?=
 =?us-ascii?Q?oTt5aBvB57qOukmLg6EF6CNLHi3LLA0fwsu1xcjB1ekeDvuq9zW+SSVBqGM7?=
 =?us-ascii?Q?1Nr6UEi0PeMeaj6H7MtN5UtMufWSaWO8cZ2FugiXMcgarGRxfzl1REHaACrn?=
 =?us-ascii?Q?9lP4aR5zjOvxZWm63CcfP/EWhxF0rRkVnErknUnRwTFEy9JgFofb7ancHD+L?=
 =?us-ascii?Q?GLrETKVHCqHfIE3cloCQXMkEUNgnXzyr5YRiuOyZI88IQnog/k+an0lbnw98?=
 =?us-ascii?Q?o/N1TnCWd5HY5J9eRr/3yc+73laKNR3Isqb65U4KkBV4HgLHGuSbT1+bnVmv?=
 =?us-ascii?Q?fzvhA8V5mwd8nGxtie2F2JI4VKQk0lO5kRQeTk8PKhsVlj6t3X8hf2/7XqpE?=
 =?us-ascii?Q?yyu982GJwAfndyp/VetW3v+A+9dllsoLQoDwmgSZ/VUsrj/GRTIRbh/50QKV?=
 =?us-ascii?Q?Jkyg12ZFd2KFygIRAEmE9i3sVmVS1XyWM0YMDKVtExoaLNKHkWA2POeD3Jap?=
 =?us-ascii?Q?QchcXSeWGfKWn91Av1T0ckS8IS7ftcFSORi0WW2nNDThJKTTJfPusgUwFCwi?=
 =?us-ascii?Q?gQTqar18on583TdfwjAdM2rXNPFWtBUe87E7yykaECYC2oeonAk9pRzn2ohK?=
 =?us-ascii?Q?qdB5ECsUkJfwejQBVGeP2SGL+Zl3NSOFWs6WeqeJtuDymnRgyOSDeOXVDJwi?=
 =?us-ascii?Q?G67yLfRN80M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LG2DZrYwWKmzaZH1vtJRAs0Nulnm4+nGYgFgAB8ARgRvEway37vJBHFsUZba?=
 =?us-ascii?Q?cnlKxYbickP3OX1i54DE6dGrPN6Fyomjyb+0ISr6bescP0QWjF56vj782h5l?=
 =?us-ascii?Q?DCRaTd77/yxcds4DnDxxynB06NgexfOo7blfZzrwsstjKRe5lj294lLAAAtq?=
 =?us-ascii?Q?8kMrJNiT8OF6W+P22ewRT5iSQtNTFNfYm4mU0iKgDJTDt2c0wb2Tn7aaYEUq?=
 =?us-ascii?Q?MFgvjwl8ExeNIbqhMzv1Fk6t8Y0DnoWCU188Pps9/hwD40Tafp5kfBRKPjh6?=
 =?us-ascii?Q?PITqAOwkHwPPHn3K4okOn3Lr2aqmWJ/Zv2AST8PqjZ6ZEYyOHzlsvPcFvPZH?=
 =?us-ascii?Q?jnIoNBAOVq/0qFyPP69siGBAS4nUbqN74qANh6qqN6ppqrMVPAsJDvfqXHx7?=
 =?us-ascii?Q?ESu1TrTMlHUxBp1Gtt5EI9VVgRsAQVE5edqa8HImhT2njLo7qW6ME44cm8EF?=
 =?us-ascii?Q?jhSHXHFKrys2p1POsZRopwy2+v57IUn5oaETGDby0lMgbla5kuhqN4qH8zld?=
 =?us-ascii?Q?hsdhfSFteovN1me5zcEFgon1iFPSFado5o7GTAE7iPIXlDPGmANfJC18GS9A?=
 =?us-ascii?Q?QoFBa7owPPY3aYGAa1T7Radi6YQOVvPrsPk1vPjQtkbG4tT0ODvFvImPWFCp?=
 =?us-ascii?Q?EubponWm429r2YmgYV1MVV11IzVTfhsYN22EfVhVzW/YCylxJbiQROY/YBAJ?=
 =?us-ascii?Q?eYrLaUgheuqBtRQhnwKHDmCSeL/6h85vljBv3rZLulhyX5Li73H9neM3N/x5?=
 =?us-ascii?Q?CClBtbvuDpGhA0M/6eLuQGugo4eUaThQvI6N1fR83Fv+qxITiKwyE/Szpvzf?=
 =?us-ascii?Q?3OkqpUqeSWqWIRZPAwCoUyzzFjPh4j2Q/EPR8SyjD+fJ0i86kiNP9PGpeBFE?=
 =?us-ascii?Q?j1i559rI8Cpk2Zmz6d2KTkYgSFfKU9l3sF9GgLytyuCEscb3omODlXic70iq?=
 =?us-ascii?Q?5zqWAqzUrKsisqG/K1FjaKLrmYbcaXW8uiF15PS9DjKdKkRPD6FGHsi0B2W6?=
 =?us-ascii?Q?9lpa1Cg0owus0dyb/tBwbHrH1ZKwUjPI2llggJ+8DlrA7M7GnV9ujBTCbxCS?=
 =?us-ascii?Q?m4AWAhd3dp49q+Bo5DE6O90+//3uTcRCpS9xgpuUR+9slcJIgh46X69Pqy+H?=
 =?us-ascii?Q?Ydf2xS6Jc9tzAU3VBYn6m1opX6VJEbfw5hA7tYXOuSyYL/HMDxP3WDM/BZq+?=
 =?us-ascii?Q?kBoplG9DQkCnJG9c36QLecLS+743HyQabatbYaz8bi3M722CxurRxlz6R+8d?=
 =?us-ascii?Q?0aFW1GgcHw1JUXVYp94KbfPixv9oMCGS0sSXyRH2I+Wv1pPLeUFi8eA6RN+L?=
 =?us-ascii?Q?pNiVmRP+Ch1K1tsAY2gUi4hGtVZakWL754EuVx7gtRXY35M8U6L8bEQtUwN0?=
 =?us-ascii?Q?VnKZogK001GA/Bn1RUCPz/4COUsVIy3u5dOd+bN+l9qrg0ed3MEFVulDomm8?=
 =?us-ascii?Q?Cm04J1ecRor98fChA4ZBPJnmy2jQCI7JYY2y3YxFm1897BxNsDfmV769V+DR?=
 =?us-ascii?Q?EnjzXACjB7C1QiBPnrqkqWtOyKv3icBqPIqNZ2RS0f7W09u2YjdlyTXWK3MM?=
 =?us-ascii?Q?fguO2zj+kpsu+KdUWoRAf1OLNMEVK8X3YhJzks1NdJV8HIt8OlwX+/hzEcLj?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1cm/+7yanq4yseokEhf8IEuMRpB/F8rP7FKoDe4P96agIprqOBnLtsjAKz8TH66VtX1u4URMzuEAZvyQ+gk6TnZ54F+4QB7ti69GnqDsXc4tsxs0b2lQszKY1WN7V6mLZ40sanPOTf3uA0zE5pHGFMpe7liZj7/hlc7uIzx7g+HyOsvKhJP6h4LpyGsjAfWmPz5OaJQpgtWfG6FAlBX8XiiWOnrfdrfik755THfISEqP29mK4ATeHFzzAvDRYEJMUbHisSxnYkBXf9zxZW1iBR9g/Uua6rGJ0JqfWk+6RDcZKSe0n82zB1b19lMAc5RQ3+K3DexMwAIgesfjx6BTo4+ns8vMZMg7zi1zBMKu4xp/6J9gGa65csLRG4NXvevZhX21PYjtgrw8Ecrr6sDl4/E36oeeG0Nr7jX3fsGTjZKPPmq+Xr6Y9U0wpkA6+nGMdxibsAMU6zgdFv2wb9dJKr/jnVAMI2tNjD5anzQSO5Yx761GD4qpKCkX0x5L3tBCMyl1fHIMoRiyDpMPQOQz7Uy5HGESMzV+JV7SftS9A7uhprqNwv3EkihgWVzf2K6qNXm9UA1F2siPLyS3PbU9cqq07yFlDBft9v7MsPgDAXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953761d6-17e6-4081-628e-08ddc3a4cff3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:37:58.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7g3buyZHW5Y/ESv8XoF2G2I0bAeKguix/TINpP85mDgZ1//67oCboGkLUH0PxW3EJLuu2WZceHWmmKzEFNUl2LSHf0YqIsoPSW9ChW8bps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=803 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150124
X-Proofpoint-ORIG-GUID: sPVmSGJ1AlZT4bg1oieUdG-cFDpJoDX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEyNCBTYWx0ZWRfX2xL2Yfjqa/Xs aiC9/ylmZJ2p8CDfRQB6xIbq2ueBSFqDgEqRL0vOfnHBRtya7QOU4tVgVqo3TjiOSSbwbX3JY0l PGbYONEPXdKgDmq7PYczAeIhBkqO5rRu/V52yX3hhU6EggIAy2FXEl96ROk33hrJoZ2plKHcxJ7
 ommJiZqwDPu2IJ7oqPKfGubLMG1lJUL3PHvZwPGRH1QH4WeDXMDix2gZH4UyHPaeI/F87CnkzRh Z3JO1+TD/j6qhltGif3kne29Nd7MeO2aPdPMwMXJXztFsEjJ2/GxVkOWtraQJWokxLXrGOpE/hN qyt4ZKw11elBxJ6XB+Po6YQqH6924fJxA3dX7TpQoOgsnL9FbCDd65tV5ZarahSbVQMQJXjaiXY
 23oBDyCfKduI+Au7lVKKHu1rm5LjJV0n5ptwg55Aj/fzjJY/HNglUvVz0IUdxwn8cWpeuXyk
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=687659ba b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bYyZlYpX74AIGI5vcOsA:9 cc=ntf awl=host:12062
X-Proofpoint-GUID: sPVmSGJ1AlZT4bg1oieUdG-cFDpJoDX7

The logic can be simplified - firstly by renaming the inconsistently named
apply_mm_seal() to mseal_apply().

We then wrap mseal_fixup() into the main loop as the logic is simple enough
to not require it, equally it isn't a hugely pleasant pattern in mprotect()
etc. so it's not something we want to perpetuate.

We remove some redundant comments, and then avoid the entirely unnecessary
and slightly bizarre invocation of vma_iter_end() on each loop - really
what we want, given we have asserted there are no gaps in the range - is to
handle start, end being offset into a VMAs. This is easily handled with
MIN()/MAX().

There's no need to have an 'out' label block since on vma_modify_flags()
error we abort anyway.

And by refactoring like this we avoid the rather horrid 'pass pointer to
prev around' pattern used in mprotect() et al.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 mm/mseal.c | 69 +++++++++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 47 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index 794d1043a706..e0fe37623632 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -15,60 +15,35 @@
 #include <linux/sched.h>
 #include "internal.h"

-static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct vm_area_struct **prev, unsigned long start,
-		unsigned long end, vm_flags_t newflags)
-{
-	int ret = 0;
-	vm_flags_t oldflags = vma->vm_flags;
-
-	if (newflags == oldflags)
-		goto out;
-
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto out;
-	}
-
-	vm_flags_set(vma, VM_SEALED);
-out:
-	*prev = vma;
-	return ret;
-}
-
-/*
- * Apply sealing.
- */
-static int apply_mm_seal(unsigned long start, unsigned long end)
+static int mseal_apply(struct mm_struct *mm,
+		unsigned long start, unsigned long end)
 {
-	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
-	VMA_ITERATOR(vmi, current->mm, start);
+	VMA_ITERATOR(vmi, mm, start);

+	/* We know there are no gaps so this will be non-NULL. */
 	vma = vma_iter_load(&vmi);
-	/*
-	 * Note: check_mm_seal should already checked ENOMEM case.
-	 * so vma should not be null, same for the other ENOMEM cases.
-	 */
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;

-	nstart = start;
 	for_each_vma_range(vmi, vma, end) {
-		int error;
-		unsigned long tmp;
-		vm_flags_t newflags;
-
-		newflags = vma->vm_flags | VM_SEALED;
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
-		if (error)
-			return error;
-		nstart = vma_iter_end(&vmi);
+		unsigned long curr_start, curr_end;
+
+		if (vma->vm_flags & VM_SEALED) {
+			prev = vma;
+			continue;
+		}
+		curr_start = MAX(start, vma->vm_start);
+		curr_end = MIN(vma->vm_end, end);
+
+		vma = vma_modify_flags(&vmi, prev, vma, curr_start, curr_end,
+				vma->vm_flags | VM_SEALED);
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+		vm_flags_set(vma, VM_SEALED);
+
+		prev = vma;
 	}

 	return 0;
@@ -185,10 +160,10 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	 * reaching the max supported VMAs, however, those cases shall
 	 * be rare.
 	 */
-	ret = apply_mm_seal(start, end);
+	ret = mseal_apply(mm, start, end);

 out:
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	return ret;
 }

--
2.50.1

