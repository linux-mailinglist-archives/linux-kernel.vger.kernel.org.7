Return-Path: <linux-kernel+bounces-829632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83BB9780E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3BD1AE0977
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255072DF15B;
	Tue, 23 Sep 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IABZtAxT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M0VP0r6q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870434BA3A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659684; cv=fail; b=ReFcvnO018yUuF+SlO8uZ+nMfAuSEphAXnKovEpMQIUYF5QPZPtjtl61GfRPtO4YQi+KF8LSh10LHGQJLgd/iRzEVKwHTEyx3HnmNHZ9rMExMbiNOLMmLXmmMao37qR45qJO42sn6CZAYUgO3NU/A7pZtE6JqxxDhrzBkCFAR14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659684; c=relaxed/simple;
	bh=WgOWtYLUlAlP/wxWw+rrwBxLQ/DKvBLeuLNsaIoO/Jc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TTtZcfzfHllk35HM5XOm1OCSdRICHot3tIth7TGFzscfOcVgD/i9DuMPuIXIdt0e80N++gkzXe6L8TjIAJAemj2sEjwBoV1BIWoz6YcipJByHu1xZKVZlJiqqGZPDMFAlIFtAWFaDxv0DTgMNr6N8G9wQuaV27VlsaI5EGN54TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IABZtAxT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M0VP0r6q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NJu6EP001196;
	Tue, 23 Sep 2025 20:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4B0l4VZ8kAMnNe1fbT
	eQZyzls62Ly1tL1QRSFgU9MIo=; b=IABZtAxTy0n1WnQt/nU9noV1aqdZlvqNji
	hNPYqIY/6SpCidGrYU/Urf39EbjHkedTkP74maWsl8TKyml4KGQ3JEyPQD2fmnws
	v1hAUqw3tho31xRIUrYRKmZ8vwA6fpQBJQ1ymwhEXcrSXNE1B2cOlNFM7/JSgSJJ
	Nc+P98AuVqkGBhDZA+glgv5RDQ7onp0vKjhoWhNygjdGJn1jmff2Hb7hmNOULDi+
	Uq74HYoz50SPSk+8MIJQkm5c9vj5gvEXMYMpzyzVhLz78yekoObUcXz5sy7uwHUf
	LoJT+MkBZz0tr8Ijjwe6X7tpb1ywmQMCmL9u1mXrIl5tFhX3P7EQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv15mm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 20:34:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58NJ4pPa028351;
	Tue, 23 Sep 2025 20:34:15 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq8ypse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 20:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWhiE56RCUrSxpglGw+Jv3t3pqD04efTlH8g8jxUCtuIpZXkxWWjayCcNKgOHtkkzmRM+zHwy1H3xOnphwYcNzV2R0vVBNkTnn/6iGTITdLiBkaC8vMm4iaM6yx8y0I4o/KY71/e9zKAJTpQ3mYQZ2fgfFmvZaGCMSYIg0xsbJzgWAdvZw3uguXQdk2NHgWFV5ho78zGtu9d/DAzfvWqJHGT/xJEuYg/y7vRGled5LPLXu6Q0sTT8ZgzulrPeuB5uQRGqBo9G14zJGI+WRglXKdEwHn9vQyJdm5egJrrqWMda9fDQcanPDzAJHpcu9PZejVv6/3YfRG9DimUggiaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B0l4VZ8kAMnNe1fbTeQZyzls62Ly1tL1QRSFgU9MIo=;
 b=xxxQlJNngHggAQxpW5tSTDCzcq+etbPQ064fwG+EzVOm9saq3sS9Xmuo5seKlRwHXr2V5+O8N5Q9VvNErN1LPzO/R7afXnSddbIC7y4QR1a68V9aQKwlfXNkXDx9YkHuZUNWTFBLQO0C0ru+g4VgMhvZKypawefKxqUheQ+fbjnn6RTe2CziHhuQ0widjIMlURIr2/Mu/xOY6XKV2C/Lgq4ipyTj0DbU5M/jn/GuAq2hSCE1CvMSm3j0V99doqhd1pKZzaQUusq8ZfwYfYDBvkTCacIJdZdh5ZJoVCD4AWdv608leq36Cu3WggA52krUFqVdvfvZMZX9A5aTbaQ0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B0l4VZ8kAMnNe1fbTeQZyzls62Ly1tL1QRSFgU9MIo=;
 b=M0VP0r6qT0qDQjSgNfplJpHddVz71txusRPYJsROjMxI1XA3ZFgOHXIpxVLREY3xj0+x8v5cSC76uS9FjXMs3+SWY0lNIf7WKWAsu4hl91jl9Vxlf+XuILuRng4QYP4aDIUZFTZXXQR83r5CyjmzblNlAUtx/bu9UAga5lBZzsQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 20:34:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 20:34:09 +0000
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-12-ankur.a.arora@oracle.com>
 <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
        peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v7 11/16] mm/highmem: introduce clear_user_highpages()
In-reply-to: <6626d497-4c27-4263-9be1-1c05d2672019@redhat.com>
Date: Tue, 23 Sep 2025 13:34:08 -0700
Message-ID: <87ecrwewn3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: bd77ad44-cb90-4441-2f24-08ddfae08c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgEoPUkYyg/b6TnSXbicozL6UFbeOk9FETVC5cUJkfccZV6CefBtlH70gkbO?=
 =?us-ascii?Q?dV2GNLp31LevQgKBEpIOPBQPedDm5U1VfdEN8ge8W7KmWHTzDk+pwh2ukQxT?=
 =?us-ascii?Q?bwjtUVjk34wqa3pT3fkaUmf0n66klOlO9J6PJ0RImOb8IadhlIpZ+wGMj6eb?=
 =?us-ascii?Q?k/Ri22RRgtcyUOgmpDudJmjLJ4VszlmY/Y5iCaSwfcU1ISk6e6ai7La2kNN5?=
 =?us-ascii?Q?MZtkHKUdk/qYoEjDdicTbcsiphktGlSBdu15M3n9Np88k4KVbQb+8u5tLcAH?=
 =?us-ascii?Q?HXKsSXb45QFT+ECLxxFMDJXrPJ+vV7tvI3Pr8O2zjq+VSFf9Mx52fBpKgd4p?=
 =?us-ascii?Q?JzLLW0Au9DWMxs2d27Zs+WwgG0sxWA2DUooi1JtbusQ8bAB7TzXibj/pMtbi?=
 =?us-ascii?Q?KDeY8llDnHRo3r35ipcwoGU2NrykhEZnZjxOO/hLlvAmwNavDSHZl4J9Qunl?=
 =?us-ascii?Q?MyYzh7bOc/0AEA+HOLhgVxeYFOhcyvBllZm1m9NxXf7MBEeAMf/FC7VEhXaR?=
 =?us-ascii?Q?X40+dt8PxNKre/JSiK6vt+A2QBUxe+HkgZF1E7KZEqpgonXpgVc6RmzxCbYF?=
 =?us-ascii?Q?MrgJeXKNv4BdGJ6jEdauSn8JJbE6e+lwgRpp80dHePqvzhLqDSxDTTlkduRT?=
 =?us-ascii?Q?S3Zbd6QzDGZKKaTgduHPgFL0RAc1wX8BUx0jADAatZSAr51OlLx+OSj/wYbD?=
 =?us-ascii?Q?WeumplMVpRzIxl12K7LA6uTCiabnN68dmDcPgzFw46i5C6oOdont8Y7sjWb2?=
 =?us-ascii?Q?FI4TRzVMLHlSlbBFTYq2r3ItaHP16BCm5O35Q56t4Dy2cXfm8YxTN8RzYkkm?=
 =?us-ascii?Q?nqiA5/89Q3snFGO7kgM/jA5sgJqBAaO+MWIM9vvIiDS6xWAAjtt1yEJr22fj?=
 =?us-ascii?Q?s+3mECSL33I+sytyK67Is3Ts4m3wxIiBc+p2Z+MKXOBZUHRydk9bVWiDDWvo?=
 =?us-ascii?Q?6E6A6wCOm31ohe3I8ufHC3jsfYpvgJ6fDir8KroMRnImVGkJhKAouzWv4POD?=
 =?us-ascii?Q?msgNRf0IW73yKPa5uq5dKX2F30N94eEiKpRAkjj/cOoIspK6+CjCCeJ0zc9p?=
 =?us-ascii?Q?aZ+l1ARvxUTZ76S5//4sF3Q8bmNbOMD2YUPNoLVc6SYyZrppa5OA6b2uK0NO?=
 =?us-ascii?Q?8LWPdR8O7nlGnJtyhKfHmlX4TiaZ9bcr/IDIYfRrLgamOsvn99KUXO00pE5E?=
 =?us-ascii?Q?+IBbzp0S1I1TVl/YITxepdLcF3+0kMK8KKVJUkgc+1uZABUD+nb3KLv9bPuz?=
 =?us-ascii?Q?keoqnysRq3qGdT1maqAC7EZwJ55c7IDtVspmYn7YP3irEiQfRnTxw+bgo55a?=
 =?us-ascii?Q?1QDYX5hexklLs1Xlxo1cjc8qgVjYzXverh4KztpnfUdE0BCLOeama6rgRFKH?=
 =?us-ascii?Q?6rs/8mNkA0w8cOskqytx+tFRPeosldO+3sRIuVk6k6CoxTGH0V5lFBglSUAh?=
 =?us-ascii?Q?hXFI+xM6GoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0oODM6/kL0UQK3B1nStfL6GtUTiMsILDPq+viNhH1aGDaDTEWIov7DO2C8Q?=
 =?us-ascii?Q?ir52neqbQOG6B2US0lwvwK67Q0hQhFhNwxrEiwIV/BXK6gcK5klIzmrRFyHw?=
 =?us-ascii?Q?SM0r1U732kKlMwl/tP43Sg5dkFwhXCSyQ8Mi+OG1ZsODk6tCjVhWzD4k86D4?=
 =?us-ascii?Q?jn8tnH8uf5BH1AZHMRDb7TDDXjoWlCVpEVRsvkBI0ARqnyjPrBsDTvYt1zGd?=
 =?us-ascii?Q?EX/TbV2SUm0UnyjLTaoqgZImM3hFKj6pu+75ITpxm38Pivsj8Qv5ydfYL1D/?=
 =?us-ascii?Q?raPAgGO7Fewm1LHhVJv/Ql6jUS8vascAVjpSbIvFrxRiPwmx7Wu+AkLrQ3PE?=
 =?us-ascii?Q?NTbgxEzCeDw5sioP6PATBVRHMW1OeV5quWZyvLbkKaIagtR54zrXFOMzzSyE?=
 =?us-ascii?Q?G3Fal4U/s48AnQRyuot5shJy/sxpGQVFXigxggnyiX7X8GQMbK8eAQxUZYNH?=
 =?us-ascii?Q?eox2deZNs31S+zkeSdbpJZUnV+ZHqfOJHlNh/DUPWIg5MUjt2pPFPa00GGjn?=
 =?us-ascii?Q?2FvOWf9VLXr/YXs/5RnUZdrKcEz658IcvJMfUHGLrXfX7ZINJGFfagqmA2Al?=
 =?us-ascii?Q?ov5Mfu013NSlc5I9kNXpNcexqCf9UzLzJy45PS/Ov1c6Wf0vmE6tGwzWACmt?=
 =?us-ascii?Q?Mrv87KnifER+1pY8htDKv43QQ7ghC/eGMrJyZy5JIrBzD4oljRjGyUPPlqbl?=
 =?us-ascii?Q?cQzy9vj35qqbLyNVI1K/upR4Y5KcsZ5pfr1FwN4lZZCOmYyii8IkdGbVcws8?=
 =?us-ascii?Q?kiipBWxQcaeXWVKFo00ibgBOed+rZkPUxEt3jduZWIds9LJJ+lHw63ZEYDdN?=
 =?us-ascii?Q?tkugT9qmknRnS685z8NYWiWjpqhuLYxc/yw79wj/gKvxQNq80U1k24uDo/dg?=
 =?us-ascii?Q?TFT1n/ZUkrvbwPDIf5Ko+nP0FbVUMIV9UwB3rG7bp/bz5dz7rHstyhJXqOed?=
 =?us-ascii?Q?xLoHakGjswAs/EW23XFGLGTKO2o0oSo6Xlxnssp9k1+St9IL21jIqT3cv7dr?=
 =?us-ascii?Q?3JAViXT7fYmcPbjeo6saKxFQ4JwTFccuQMRoRw9TkX7THpK+KkIJbe4dzXet?=
 =?us-ascii?Q?BjCiYPtH5uF0VpoF5Fm+IR7J8P6AgU3uJ/pAl8zbIRZKj0+byQYASkJsgeRw?=
 =?us-ascii?Q?wxoKgMsnOEKZAijqrrCbmGeGcqbfacjh3N9vFQVRvZBWkyZ1Bl8neIedUzIh?=
 =?us-ascii?Q?q3k3ShcCbirrCemCnxHM8Er1mnyfc7BbJW+KtX+z5GWGOJgSPubVLNSXbNnJ?=
 =?us-ascii?Q?CSkrUze4sY/SOAkNMxry1DaZeIWkbAYqkxfHwYcSnyd8o0yQfFyQhD85DTPZ?=
 =?us-ascii?Q?jAzjtvK4dVk8KOwUSsEVnuXgSiiriVBe0yuNTRPZWVw4Fa1RPCJTeVA0Ib7f?=
 =?us-ascii?Q?yhw2DCSNk2UWw74xqlhdzL05OTaJ0FbYEr2kzrUyr/JJ8CElzvlHarzcm6xs?=
 =?us-ascii?Q?SUUKe9nzrDbeJ1gCwmOtmIlmq6Na2whN1roq/fsOACOLzl/UE/ueiaYENqMx?=
 =?us-ascii?Q?f7ljJ35s9TWeQNL5iU40qjJpcQoXpuUff+Q6wyfZkTgK1NKHxfiT5Hrzs9WL?=
 =?us-ascii?Q?xtKCzzEIV13yXbW8nhAN4SAI97H/NjUxLyfwzcWZq7V/PYYLJdftPJSUzCM9?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S+8NRO0QY9HBXCm3ltBYpwABtC/XAnKdHzUNr/AEV+llbdXYjTMUTBr3vpTwnzZl4McLg5hoRjWirI9m/RcSOn680KDmaVdUGymTGN0aViTKJWJydp+xp1z1l6RvtbV5aP/ezV6mI3mfTtnfS9/q445gNXSiw3LQv3Rm1lONQia6lS8SUC6O7vfrMtseh4rpIs4h2MRlNKZa09oilp6Np8cgYgAcWHzmtqPOQc7iCm7U+YnY0WKMjG6RD2KXm0XWLjwaxWmKwsUzknzPsGfVziVHMsIDfY8AnNBSDPPlP9dr1i6kDWzFolw1lLEaSiFCH9g3bhetqL/XHeQI57nhkQ/R+pEdqt06c3bx0+vGLcUFoPdFjV6LlH7WkoAnAB4Z89QHQ5wncVZR0e2C6W9QxJxYJvIWk9EIKR8kQU+Iouc34kQDgnKjfj7wBi6vhasX2EbAJa7Itb8gS/iAG/5MuFY58HtEHi8I5ViiV1PTFpT8UjGl7xEXWq/TCyiSPMi5jY4JzXlZ5bpQ1ra1IgQpX6UdJ5U249jbfNhR2Wx+8fPtj9rMbN6K/LRKXe1mITJAPC4MsnESlpf861voZhQZkprnGLFjdBZ5TfoJzLZRFZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd77ad44-cb90-4441-2f24-08ddfae08c99
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 20:34:09.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHkY+DViMqm0NJ69td8Lh9xuAgks42ZevlR8KF4YlazR4FWFL84SS92kax+cJls8wXLZepa9M+yk+2Cxy5/nYZ+kO6gXzX8cN+X2SbXwcYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfXx2qGssU7yTUz
 0dKLxHiNcEWj54AOAGo6eLwSP7tKsamBmVgJwVIwPp+fbMMDKhLrSvf81vV8Gb8pJYfzPdQRQEL
 7ZQgbgbGjmgWBfXMTGUoC70+3ORBPF6bKZq4WfnVh7ELS40u8K5PJQdBuBLUaFnlw+eiUPMG0rm
 Z7N9T7vrsHHplZWfhWzen/PJfjx2zvzAYTxSt/zgkeOOOOYAoTWyuJA6KpJdOyRuwb5bydpLliD
 1wpxAiAcRRefiV67Gb085ZTif4HMg5Gcts23VnyRmlaEq4AMM3hbkWR2QqZdpR6Q0daKNB43/JC
 jXY4HeyXM3SxMahDwrrTE33ieT1KweVDlQCDCmjrxhG3zrOoDXR6Vil2J60V5mu7A1FJAzgc+IM
 +/f2bYjS
X-Proofpoint-GUID: EnA9KqWcWcdK3A5vO2qdUXI6reMhRjRW
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d30448 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=qd5qNzMdsjML4JxwBcYA:9
X-Proofpoint-ORIG-GUID: EnA9KqWcWcdK3A5vO2qdUXI6reMhRjRW


David Hildenbrand <david@redhat.com> writes:

> On 17.09.25 17:24, Ankur Arora wrote:
>> Define clear_user_highpages() which clears pages sequentially using
>> the single page variant.
>> With !CONFIG_HIGHMEM, pages are contiguous so use the range clearing
>> primitive clear_user_pages().
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   include/linux/highmem.h | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>> index 6234f316468c..ed609987e24d 100644
>> --- a/include/linux/highmem.h
>> +++ b/include/linux/highmem.h
>> @@ -207,6 +207,24 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
>>   }
>>   #endif
>>   +#ifndef clear_user_highpages
>
> Maybe we can add a simple kernel doc that points at the doc of clear_user_pages,
> but makes it clear that this for pages that might reside in highmem.

Didn't add one because clear_user_highpage() didn't have one. Will add
for both.

>> +static inline void clear_user_highpages(struct page *page, unsigned long vaddr,
>> +					unsigned int npages)
>> +{
>> +	if (!IS_ENABLED(CONFIG_HIGHMEM)) {
>> +		clear_user_pages(base, vaddr, page, npages);
>
> Single line should work
>
> 		clear_user_pages(page_address(page), vaddr, page, npages);

Unfortunately not. The problem is that I'm defining the fallback version
of clear_user_pages() as a macro in the previous patch.

        +#define clear_user_pages(addr, vaddr, pg, npages)	\
        +do {							\
        +	clear_user_page(addr, vaddr, pg);		\
        +	addr += PAGE_SIZE;				\
        +	vaddr += PAGE_SIZE;				\
        +	pg++;						\
        +} while (--npages)


And so using page_address() directly doesn't work because addr needs
to be an lvalue for the addition which page_address(page) isn't.


Thanks

--
ankur

