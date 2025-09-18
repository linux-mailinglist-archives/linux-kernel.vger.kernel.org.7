Return-Path: <linux-kernel+bounces-789018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64024B38FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A27362CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC31B0413;
	Thu, 28 Aug 2025 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQqJu/dw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GLUkMYFC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD3AC3B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341066; cv=fail; b=o2z0+XYTH8U3IZp5CyOgOPAIAd+q7YUyp1cLHnkekib1YtMHfRdC5G6I/ogNn0VnIE1my+QSx3HsuFj6yP/KIm2etoLm4KBYXQgZzak8cLbGkbFUJ9aNKPwiwrDdVDwfiWjKxE9ux2vl6lJnWBgufXQmCDxip1PbT0TWMSMC5ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341066; c=relaxed/simple;
	bh=P1apJGEMbKXkhDdGsH1JcvNQoKjT5U2OqqLDfkrAV/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSyZi4lk3r2SCeAzHvTfNO+XTTp3iMxet4m7fzVGUiGtjpeq+3MsJm6EzhlFN+s7M0JIM1qMFUdIArVKQbUkGcY1pg8JQ9rccwX4TYhNhQFenRlg1MK6fJoY3Trv1RFQWM1EIcZXCjS3WqffFf0vvQFeTWyvFKeMY0rkHsYefi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQqJu/dw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GLUkMYFC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLH5a0023266;
	Thu, 28 Aug 2025 00:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=veaLqqgHO9gPs6+waJYWbYTsiVXznJRJoC5iTUDDOdc=; b=
	eQqJu/dwWd0gqZudYecR2fFnhZ6e+w0QX7pLuANx+xBfq/czzCdf8WyR5WQgq0Z2
	DKLVIwOr5rVytr1IikO0VgJelox4ajCQITHIL+5G6mXF+r8DXL9w0lIR5CWszGQG
	tOG+AhM4tmm8aRqyM9DXiBW3zKGv8E+w+gO0aTB8HmO4PjmwSI0B/5NLA/tP2lSB
	uhpIn5lVDJFCE14OGKeZLKi3IunQUQvukSwCSLeGvzxE52AJqPRsiSPj9+E5U0xQ
	UIcXd1sK6Bt9d+4GBk7RNaNWNhwRWtgnYxQBcuzXwpxzSIZp1F3GLU2LRUtYbx3V
	61aqt9MniACHh3V20J+m8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s7gdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:30:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RM1uYB026697;
	Thu, 28 Aug 2025 00:30:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b51jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 00:30:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXOvXwV1hCfbxW7nnsJgQo++xxlISlDDP8rQWFXmD7toRP65RMsNF7eroDe8nMcBKd3Ft5Okzt+FJ1N+4LQP3e+3GMNmmeAEQowXSph6reEETq1wEWH/KyH/aExZOqZfBhH61QPbosSrlX2kfHAX42a44YXaLuSXafQxBfOLF4wUio+ItvggeNI56LmgALP6pCXFEP09hLYIvxy4MkFoY93SQ3WgHEw5EMreoHJbR671LV4qBpDPz3cwm+ziDUOVtgMrER3Jo8eaY+e5NX4gE6uHKApJH/18Q51gzV3ExSxha64S2ULw70msdwcarA1MGj4ygPm8lx22Y5GCJXNkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veaLqqgHO9gPs6+waJYWbYTsiVXznJRJoC5iTUDDOdc=;
 b=Ju+m2VAEFqeaZedcSy+2r9weiCf7dVZuVF3J5SP4zQ2R2+9jQTK8s/fDy6sZnmvbxQjv/FCiZycJW8M+fEAvivQNpWyF0SPEk1rhpI04rnPp52EySUS9uFEWwfqpL6WvFOeW2POhYf3nzYLG0R2SKHsW/pdwL/tjOfkTCAEVa9T3j6qSYtyiOZSjEixyrq+7EpbBX5d6qL5gOYPq4N2XfqPRlKYOzyBJEGItJSTGWjU+Gj4bMxv0n4AG73CeD+7CNULvBPwp2oVdp6M2Fvl/ALZ3xQ4dZvlLin6LUoAYHuSO/yGUKCIHEWV24MJmTfYxuZkXwsD5a2RTmPSJ7CUA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veaLqqgHO9gPs6+waJYWbYTsiVXznJRJoC5iTUDDOdc=;
 b=GLUkMYFC/pzEza9lpQ/La1CBZ8OOeKy+mwDKxDxFtscZhTi7TprcYo9gkuWAfy4vlDc51oDWfyiLM1uACDt66e9yVSaJBt6/uI0l2JK2EZKFVpY9je5amdDGMgPqbfJ7hE+L6bTVe0M4K0KLdX5KFuJRfclD/PSqXB2HtZK2zMY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 00:30:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 00:30:51 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sidhartha.kumar@oracle.com,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/2] maple_tree: Testing fix for spanning store on 32b
Date: Wed, 27 Aug 2025 20:30:23 -0400
Message-ID: <20250828003023.418966-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250828003023.418966-1-Liam.Howlett@oracle.com>
References: <20250828003023.418966-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BL3PR10MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d014fc-dabe-4a78-79ff-08dde5ca243a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AF/iaBbN3FMTbfxdfiRkWik1AIp0G221I4iQLS6RYDfN3ThEwH6PXBMTarAD?=
 =?us-ascii?Q?3ppmcSdOlCDmmAzZTfepqECZww/KEFccmWEw+y6kSmcTVorDn6gT0ulYIpZ6?=
 =?us-ascii?Q?YPmVwlUY1bi41f3RsvNsjnmacBJriUrZGDlQC69vhdQnJkihZ6xPdOxr1DaT?=
 =?us-ascii?Q?4NUiDaAFu0qveBtxCWQ9+IjyW1z2l2X1hziJQjKoyUyDSstDUjheABbfAK1R?=
 =?us-ascii?Q?B/Baxv0m6PsipPx9dXAxXKqpYAFNZ00MuEeedICGAmurCpGsPfYKkCJrnb82?=
 =?us-ascii?Q?ehjUOCmuDILDsS09sVq9EZOlFlWrT1SplygBbGUBLBiEYWNIR0oOSK/oZzW4?=
 =?us-ascii?Q?8/B7VmgowIBFu7dPvw3Akv+A0pRpuh4kOvotDmeSF2+YQxQTdPAVcch36Ba6?=
 =?us-ascii?Q?8Z0g+RFJoIOsDu8MI6e4WubalIb+cR6DWS83CAch9kRAFQr8FjU/NnDOYSnI?=
 =?us-ascii?Q?rKq6u4xW6V0PyU2Yn9Ka/dG+X6TxmVu8M8CFFGVlCMS3ntuj58uhLEoqxAHT?=
 =?us-ascii?Q?tMFdKJmZ7mmkcZ42WOPX6XMTIIfWjR0ntDb2RBTfPQzJJg7/7Ctg2uNItBaB?=
 =?us-ascii?Q?QhK3TUggXUYWZYNjjrr1rGgKFhbMzCzHgct9CnbvZ2/QcMWLXgHAXZcPN4ds?=
 =?us-ascii?Q?tKC9HLPSPBCxN/pMJC73ez/WxEA7M375sqpn5J3VNZnMYNGkEOaZS1LhVLA6?=
 =?us-ascii?Q?Z6FclgghwIg6gNeyBersGj/xEHw0cy0HmzxWFCRum77BW9C4fuHfQJdh4hz/?=
 =?us-ascii?Q?oFQ9jtxKq5xol5g/4NlO+BLpb83kSRAOXRbdzC12qeN2xuP5NneqRWjYDwAW?=
 =?us-ascii?Q?yXu+OEcGoRLlC8mMlN3YWDdodqaEGjeW/oZ/JTcHQUnyLOH8jcr46GLnJQCp?=
 =?us-ascii?Q?8shP+BC+o9ApzVXL0yvvykPJlYAoZ/3hLV/QKg7/LjnfvZmorwlJtVYXov4t?=
 =?us-ascii?Q?cCFDTFuI9h9n+vcfnewn95T6EnC44+WxgT5/hgU7wWAqLziCstuXC7U5d7ey?=
 =?us-ascii?Q?gJcwSxyFU3RsBf37bIEoKkwisLE97I/P8FaalGKPRHYOXShns8b5z5Zg9XgV?=
 =?us-ascii?Q?jkVlMImms6vZGiqSRifJQFqRTJ+QM+P0671vX1JqHwwQp1faxKLLl6FSLPQ/?=
 =?us-ascii?Q?lgSAgDkuZ300CAUWjZl6hIHYaFPMzCTao7j7EF37P/b8O9vabqCZIW4ut4SO?=
 =?us-ascii?Q?phmF5MIJs3YduTGU/mdckCokoxnAv9KvRGToB25RkzcpSXn9je4qy5oII6tZ?=
 =?us-ascii?Q?eOl084l64FdqaDLEA8tFy8alvhBoRgzXq7auF8Ge/iS8rGsd3nWHDQKatyLA?=
 =?us-ascii?Q?QW5GxIzVvAdI+rcgqZRNOuZDagazAppEz3gYy7L+pIvHM5YTd/l/yfcgQDzv?=
 =?us-ascii?Q?QnlABA6rWNehag1tnpZ5wj0lApihshbBqhahIGYZjJCoqNJWEhmYju2nTEbU?=
 =?us-ascii?Q?DOKXDj38FfE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gYt386qvyjgJBlB40L2tPoiiRw0sXnAjloQ6ERZ4dQZqNxuDZ6bPF4MayDAz?=
 =?us-ascii?Q?2hKMj2qofBVMRo/GDDtHMzmcj7t7SRiBBxtQUMhjju47CxEKLjoNdn4FIqG5?=
 =?us-ascii?Q?Fh27LoqBNYYfpbuNykeeDOb7+JoU+ODUOxYiCXpOcqy8GpMsefPug8cU8ss9?=
 =?us-ascii?Q?NcRj3bkZSL4RpC0FBkXqpaipZKhUxceDKpIa88UEDuu/wjLaHWYprHtHbzGR?=
 =?us-ascii?Q?hxfiMviFn5i6RcphVxhr/tHzig/hkrcdwM5vSrYTeKm032+Dtsl6JewZ5t0/?=
 =?us-ascii?Q?O4IuSpPtzTsC6XSbpxQNoCllzVFwTmzrsKIw6QWaNwbvbzh621iZdlcDly/I?=
 =?us-ascii?Q?j3qw1ACto08TANQUQdF1ZYROIdPJxIApR/LBHRtObbbpwkD7NiWxzwausyrC?=
 =?us-ascii?Q?APNMMG1A2LfD2OwsOXWBIj2Z6fWipsh4Cd3hGwG7XsFUrPACDpK6JsotfISP?=
 =?us-ascii?Q?P7cs4DBQhac8vwgbt8Vuk9gcotCGbiU1XKYIpCpHIrRDPrfsKr+qYKLdFnNN?=
 =?us-ascii?Q?SGfCR8G5/ki2b21tS1qb97OSVBLF2UxuKT/tMKzr+DGKY+TN6UVgJJTCMmpr?=
 =?us-ascii?Q?HxW0Cj8lv/wi5bgVMhrTQHSU7NyBO/vjzWsB6In+6EFN+mQOafek+h9MrNpn?=
 =?us-ascii?Q?uA9nKaEeQLQG3XdkKlK9/dmd59CuYlDJ7oyFh+Mg8kpq+gskJyDBnpsXpaNB?=
 =?us-ascii?Q?EVTXY6TbBe90MXruRmRxkzj0GKAWGvpsZV38KXRYgJ2ZTKTc1BVcwXZn34wC?=
 =?us-ascii?Q?Q+YhftH4h1YAbpyUPLrD8Oi7kdLUzxsDfkdU8DlaTj+N28hh28ZbXvqXUudR?=
 =?us-ascii?Q?BY2TDWXhfBoWaPHdBlvWeP1l5BZNj+Y5N4/DWtS5OMaODXL0ZVquNPstckcs?=
 =?us-ascii?Q?NU7sKs2xFkAQa98K7VFT6+Hh2tspUlFG3FGTbXZoQiq3ESTcaopnAqAKTzDE?=
 =?us-ascii?Q?20sQKAV7d0RCxDQm7aO8iXTd5IBu/2yUTBRRLUDReuAbX7E5N6rTaxG1aNlN?=
 =?us-ascii?Q?ioYnQFTaT8s8CZKHn8rVzeKXv0i+PxJqO4wFz+ShPQPQn3nxtMNshtu77QhA?=
 =?us-ascii?Q?bwCNuZ4yCWIeHROZ2NmmCzqqX47WbhP9gFUJGjExYHuOCpwid1Na9VHNRmzn?=
 =?us-ascii?Q?A+9vnGfFBfsO/3fS3ErXe+bhroFTFKp1mqgz9XMI6xQcmAa9AbQSYykYDWEv?=
 =?us-ascii?Q?/KSglxbSYn5xFbnNcG7tGl34mny7zqJagtP+8TtAylFTNUU9AcHncwcduuMR?=
 =?us-ascii?Q?YSHzgHjbQy+cEZ2tvLW4gGnkA1oApn55jN+SHrYgiYC0RJHloAfN74tr9aw9?=
 =?us-ascii?Q?08+/WpecDkoWvT2viTUPgzjoSiuxiBVFyz6LOFyzDDatyPfsdA87Hx0BaP7z?=
 =?us-ascii?Q?ASwOTlNPrTAgmXnPqapUsMd8k++xTBLDLy7zi9qjwYoXwLSQuxLVuNDq3gdq?=
 =?us-ascii?Q?EpNRS6K4fC8loB1gtS0Bfnf0VIJAZoLByMhSj6Cz0jifa/MXr64mePnwvVNv?=
 =?us-ascii?Q?9A4jCrbdFwjQn9g8EbKAj3zqJKQ4wPhfiSVv6WAmodzdKXcPLOjgD1bwDW+/?=
 =?us-ascii?Q?yeDamcbLPTc713/Znw0e83WWheWwYfZX3k78vEaUFpVw+NSmN5cqM3pp0Wcc?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	odY/Ftgxnya0tpHnC1LZuWx1h7vUkvYbLTiJ+K7a1ZDtWszAkR2vNe1dIRulVhxQQSwcqbG4wlUGr0VON/lcj/yBUa+rNUVymtUO6Pdlo3834eyZi1BXhHMQfXCKBtXuQipuX+NpCRI8dNJXn9Dp67kfNeIg5fdZo90+o+fl77hYNZzecU+3WCknCoWTgBWFpOwcsKh8bgBDEDz/X0PMkwXxPRxAlZvM/Mrt7axRhcU0bEMEL/WcyJCkGbjeQnJI5LwAO4IvIblHzgLnVlPGCauvdduW5Euq9brn1xPCzQNh/BEsjNCgOWOJ1lZOvSieCorbSk9mDAjzHy77duGWxIARudSe3/vE/eftp/fXRme7k3T47BiVF5QlENMZrENxbTzWR2O0Lw8FC1R2z1xiku4gn3HIqdGYdRrYJSiFYQdzgs971waowxEjQ9ogTxd8Da5ln5/k+Jk5oOt1V9E2mgMyjKbctoKuD0BY/5R8kOc71PpH3SiLMCv2fSJ5C1W92oh5ooJpeb2K238Ow1vrlxG2aiUk1ltD+7tLRfP8IFfZuGIieYyaO8wYSyZjU1tcYbs1+qZmdOKSg/RSPwBvwMDpPF7hMAfzn/hcwADZQEU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d014fc-dabe-4a78-79ff-08dde5ca243a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 00:30:51.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIDB9G99upRzw0mgUG+4yjNERvcl61v2LtYfkv0GpCZa9/3IYT9JzyOFNx5BzYKnsC+1tZpVF7Nn7aeBHOPCsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280002
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68afa33e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fKR94OqTs2IUYFoxKnoA:9
X-Proofpoint-GUID: h5DNsR05UDQU9VO6SfKWsYjapcAdWB8m
X-Proofpoint-ORIG-GUID: h5DNsR05UDQU9VO6SfKWsYjapcAdWB8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXxFOhER5Slpb/
 7H0exd21GfCYGVnlj+1cObAxXBCRGNh6SIJ1aMaRync93P1QNXF1sYYCWjj48YrPPTZ8mPNvo+u
 eiro0YTmBObO68q+Up1mmS6apAt7u0M3wh7ZQOUhal6c6SK350ZHy3KdVxUYNQthcf9ob7Hvy+Z
 PLj8etjGvBO5jH6LZDyG6JWLMhWoIurAJJhbBWZsUs9bhU3a1GywtJ4xq20UMoE8y5E2iWRq0Bk
 r2r3bD59GwixNwejCwjYNZJWHWbHIb8WppbtwWk6ODO1x/m5q3vym3IwuIajXdtvnV+22oV973Y
 IFY4frE1X3E43KUg4W+grFzBtXIEJVT7ZMqmi1dXchdiEoalbhHXKEsRlWLgypikkB8VDL0j2hF
 54WWdw3r

32 bit nodes have a larger branching factor.  This affects the required
value to cause a height change.  Update the spanning store height test
to work for both 64 and 32 bit nodes.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/radix-tree/maple.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 90a0db45a33c3..05714c22994ea 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36327,13 +36327,18 @@ extern void test_kmem_cache_bulk(void);
 static inline void check_spanning_store_height(struct maple_tree *mt)
 {
 	int index = 0;
+	int last = 140;
 	MA_STATE(mas, mt, 0, 0);
 	mas_lock(&mas);
 	while (mt_height(mt) != 3) {
 		mas_store_gfp(&mas, xa_mk_value(index), GFP_KERNEL);
 		mas_set(&mas, ++index);
 	}
-	mas_set_range(&mas, 90, 140);
+
+	if (MAPLE_32BIT)
+		last = 155; /* 32 bit higher branching factor. */
+
+	mas_set_range(&mas, 90, last);
 	mas_store_gfp(&mas, xa_mk_value(index), GFP_KERNEL);
 	MT_BUG_ON(mt, mas_mt_height(&mas) != 2);
 	mas_unlock(&mas);
-- 
2.47.2


