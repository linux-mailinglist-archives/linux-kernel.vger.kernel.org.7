Return-Path: <linux-kernel+bounces-808304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45CB4FDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124044E54F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4179342CBF;
	Tue,  9 Sep 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2PqfARY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wH0CsAHr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABF342C84
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425241; cv=fail; b=chwhK2pWn7Rlwe1mqgAvoky2rYEJesgLDoonz3IHZnjMYdPMUgx5Xyy646UXNUqDiVqFtfpu0GoF+L0JK51Rq9DvDOo+VQ+qEX9ncxuA/0rOs5Qe73RqiUAjVmKUb0PgNTH3OejA1nqB7HG9WJ1tGA+vfFB0LrL7vd9eX0WNSAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425241; c=relaxed/simple;
	bh=0COPXZ7a0AYdz7zg5FabM7GU4V+vSlmqC7Xb9AZLgOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=taW6jX9FhQjH7RKWX3dDWYTyv/7PO7HREaKNe4/Jnb3uX7qFwhXrWzB/uL3HSMoEqHO1eX/sc6ILqhydMAyYyDjAhugbht0mUMfyB+GOPkjRO7ETC/uNfZ+2O2NpdwaP83Sup+KbAItWIeiFp5V//sKxNhlwc3rDbC4UpNxoq+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2PqfARY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wH0CsAHr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPGZW032252;
	Tue, 9 Sep 2025 13:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XazHwRsDrq8IQP5DjV
	sdYgHBST0+GfB04FGXoqalQXc=; b=W2PqfARYSEO/reeu1wzSrp71KrOnK1WDj9
	qvG+luKX6KPMw6l9G/vxuSVFnRZkBP6YniBelnFywL66Qlg7qDJtcearSn5lOWDt
	tTSYNE0koynf+qrE+x3F0jG6ISBNuqCHepfS4LZ5Ulye2h24A8LKwHfedaC16+a0
	rcNKOBq9yt7R3gOQ4fqu9QuLO+5Cu98Pk61jqdzTTxnZt0BAtc3tfQQwfJhIvKLW
	ULHQUTFolRMfbKaUKy4jwB2qxbttr/xYiyalUSoHyqwHZw5VIdGBULKIYu1HCzyS
	oIBgQPWCv6mca4R6M+wGJes7RNBUq/wBPMM12EB8msDnV1e/e6yg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pea14x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 13:40:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589D9rNk025959;
	Tue, 9 Sep 2025 13:40:24 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9myxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 13:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOHp4khV9y7gbhoktJok8bD2luOkNBNCez+rd73y9QETuVwumNhb5FStmQDROxh3ZicrP7tKzvxftENrNCVF7L2Y31iWegdxoLTDmFpFOxCkNUaIpkVd4S3HC6Puo+rHK7Mmrexn31gjiCnyLdkN38VM7zwtuAkMFLZNO5gG/eZx3QVbQ+c5X+zmyiVgjlzIHJGHNb9JqDKyvdzlMvN58kl5R08P/UFbHtPgvrEQ7Q7K6urtHOWyfIfPy3mQljh93/KKQWkvduLRNJIfZwK1+D42Rv8NtmnYDkpvQ4y05z8sCCtLqUNpgCyTJeLLDOdRYiXD6Y0ERtO8kXabZ2XQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XazHwRsDrq8IQP5DjVsdYgHBST0+GfB04FGXoqalQXc=;
 b=OzHbFutnsulnnyLYKHHxZ7CDTF/svVoBh47zhLCdj0+c2YmFaLQfSWA50GRz5VhujpgNyE9TY2QGS6tewmEd7IvYZQLf/h76zb9yDusuNeGZzsaKI8VIfLsZmDjbcxeFz8N3ZWU7oljzeA9BThDOz107DrsDfx9bjFkGbmjwQ5neisC1RiaCt+tRTwP2HvFBNX0JXja/T8gZ5vZZge5Sq7LNkiWEYMt/NxRGJVTC4cvo98U5TwwtbTQYgoYwDjC5tnHR0azge6faTBC/C1R6TWTeaNY2BzaehRpvb7TTiyzop37mVvPn5G6eVmi/QHjKnqAMOgyOwdnPdrUJE1cDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XazHwRsDrq8IQP5DjVsdYgHBST0+GfB04FGXoqalQXc=;
 b=wH0CsAHrfqFNKWHCACmrZDI4BcpZgSHcrxZvIACEPU1OPtRLAEW2V9IYSrPHv3Apy+rDnz4YPvYBqGNeL/lz/Guu0MZZ2A4oYPQ4GAyJGqRKb9tOCPCQt4nZFH3Mm0u0e1qw8d0Zsbn/dOFOxdbSjr7wKbay8T2oS9adIYSpz+A=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:40:20 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:40:20 +0000
Date: Tue, 9 Sep 2025 09:39:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Jann Horn as rmap reviewer
Message-ID: <foqgbk35xwj7jdj5bsj4cy2nfazf2a6iom5tlsocle4f3herf3@arde2gytrk36>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908194959.820913-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT2PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c45f97-fda9-4711-5ea4-08ddefa66b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SOD/wCIy6P0pvG7ruU2LJHBclo0d0B7b5MyAVMzyRM1rFBt0g97qsRcf30ZJ?=
 =?us-ascii?Q?v5glCeGdHxM46gv3KYq+zWur/5vTxFIS8mdParcU4ocoTR4AjoUviL/HniWn?=
 =?us-ascii?Q?o4YhUsJbGUKn67ds6Vij1amYOxBu6JmplwUq8xbPsVzqtR9gkIjIzpZ9aDG5?=
 =?us-ascii?Q?AI6e70MBE0Q87ReRfOaqbQfTYEKBlEIUfIZgsnv7Etx8dHA7pwsNKiawBoK/?=
 =?us-ascii?Q?rKdqgkAJseO/4MPqtJnqjog5M2xxaCZ6+deNFd1kKfofNGrpMGBrmqf+qIeW?=
 =?us-ascii?Q?N/y/hKBp5lj9hb1bUgNQJIeeAnqj5od2SJ1WD/S5ZGp1W0C7iy9228J4Njfb?=
 =?us-ascii?Q?v9pbQSGLe62+y7XmaJn7440ZZ8k1L1gkx+0RBuBkrrxTiHtU5EHrA5SzStqB?=
 =?us-ascii?Q?1eYa2jPpuyJ03Tzby/FtlVcdqdp5qT2XZWFAMiFT9If0RG0ZVlFdJZIGB26I?=
 =?us-ascii?Q?8a8O7eAnR2v23uIF+vDZbDEMTl3sYP9VVgkkWrYDsNQOQxzAU9FB6E1QIXCX?=
 =?us-ascii?Q?6CuEyW6xX5Suqq3jcCLS4fRl8sIIrYfWCGHaayIu26HZLIOP79+05zWqs6Aa?=
 =?us-ascii?Q?bweM8m2Go2mRHImVSmTmtCaynIj4Q2ydLSESoSaxJr/hFQjCoGHkjUgqrUGa?=
 =?us-ascii?Q?K/sv2yG5TTjtELVD8xy/jzb+Jx5R4vOE7M21C210gfnGVL0MsIeBjsP1H6XN?=
 =?us-ascii?Q?e74D+n4EMMThJ4icCUUiYXvo3V4p31YXR8bit2M+fjA6K65Du+zn/BrPoMCP?=
 =?us-ascii?Q?g2WeDSYwDVNBYfffvrTtT7oL02n+ye/iWQh7BX86MWldhsEvFUvBn0SF5J7t?=
 =?us-ascii?Q?ApNxdXHDLppVEX8FGXsAtnoF7d3PlH1nWFPzxJ8rQSkpPlu2CYY7lq0QHTx7?=
 =?us-ascii?Q?oLW+TfJj5x39fFoHNvfV3MM7WEWXxLK6VML6rKv+KcbLcEtrVEqNZOmnRGQS?=
 =?us-ascii?Q?Ac5Yoc7tbWRYa4touojLVU5S56CY2Ibxr4dm/rVG6JAkdNooTiEZakj/AChB?=
 =?us-ascii?Q?9RVHFYSeOu/kiA4dctS05LCl0oh8u5hBqRvfj50zjjz5aLvGyc69GZSl0/8d?=
 =?us-ascii?Q?+CRj2ky3AJQ+33oPo9ZFY92ppdBiIDei4ZzqGg+qQQjlFL+LFtQeezuEl2wR?=
 =?us-ascii?Q?63KKf1WU97uVP02qLzeIYcQyO5+GyJtYXFWg6ziBvL4UHpWub48YYEPC7QpP?=
 =?us-ascii?Q?Bj0slhP5y/d6gxOp5+BR/lAaoy7+9bDBwJqTZTvo27cBUPx3aym+g7fZwzhQ?=
 =?us-ascii?Q?IZDZ7S4orZMUTc7eQovpy0qXh00pL56V+Aaz9n0FaV8M2voXOOcFlhbmGV0l?=
 =?us-ascii?Q?kLUED85f0ua4DH3Tzo24VOVn6TLe+xuF82L7fleqmcvAMDql/urNlxNbLv7m?=
 =?us-ascii?Q?/8zvAcilvsS6mRfXf6TOhUjToLge+MXxXdDuClIKoHlQQgt5wpPrcXsS7sxB?=
 =?us-ascii?Q?PqqZadSIja4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grrlPD7Jirg8ydFKkokKa3vBW0fV06nW0Menbj8n974e0bBNmmeoQ8qXFlJO?=
 =?us-ascii?Q?Dnugmvpbn7wMqmUbqEaICbO5/xcmseJM6BzHaxCOAwn6u1KmnisgTSH3mors?=
 =?us-ascii?Q?a1dvOt1rLwbum/c12BcJ2ufSlwZziMfQh8HpL48q5JfXHsSW6gjOMIofuQJS?=
 =?us-ascii?Q?/ew8+B1Vd+LCLoQsKrCzCeaw2Hyf225+rpMi+fNL9fSIPXluZ3SuCXewA2e+?=
 =?us-ascii?Q?KHEzyv/yYOboPUlopXK2Db7qN3VHHWYYfhNFD6S6LuMxWfUCP5DYgBHelq1B?=
 =?us-ascii?Q?PqrfkiTX6YlcsBr2JbPt30UXk3g9qw/cDS6R0HSn02sDIAw5NUg+xJ5hLktg?=
 =?us-ascii?Q?ZmCDX2DBOPGqGRgO0E2sv1alC1mbXxR57v3oo3fmcC0zOPpsB2b6R6Gyba4n?=
 =?us-ascii?Q?fKFFPGG4kP46RuQiipCJaUCeeEhZQPVrIkWVMOE0+7QPXZJcmpEIE1KA3KW/?=
 =?us-ascii?Q?pYnMDdOzn8olCu4N/g7L/AKfC1jKgL+mahXi4JPrDrU2T/r8KnUK71zRWRDg?=
 =?us-ascii?Q?puGHl9stMYEEdYdw6vlGzJ1soDp1bmkPr8TKVoBnD+dKw7smNZau6DoJX/9a?=
 =?us-ascii?Q?q8Crjhq+EkJtMeoqJU05HLIwTylRKKFu4DV9xA1UHzVHDoZ4no1YUdpLO42z?=
 =?us-ascii?Q?rkKNN0MApjMFAGY5G8utpXVAmNB71BuhyMfOIplqouta/Nx0DleTXtO9HOGt?=
 =?us-ascii?Q?rpuX2KnS7Tl60elCBO0d4JLRX6Z7NSojtnm6S+2aLzqB2KG2n2KD91/dM1nt?=
 =?us-ascii?Q?6N59I+BZMI+5c58Vy2/+07LFNjd02/lbJhsqExQ1W4kJ5YFnaR10QB8ypuEv?=
 =?us-ascii?Q?Y6gfcwr7KXXthfHJ7WrvsPZjhjdsqN8XCMJ89dVMWngA3tPScZVlivnZZNCS?=
 =?us-ascii?Q?r+naGkdoqqzk8ogNWCHMeplyBeO6E1p5Dxe/PSL0HuwMLQdEBYXkU2ugTq58?=
 =?us-ascii?Q?9iExNBBPmz1E3OmA7iKlb+MKmtU2pEzAkjqkborsRfQiTMMx5JWeB+RqaMp/?=
 =?us-ascii?Q?qeKiJki5YiGvfSUbwHhO3G/oYtXbGlPdoUDqGWN02OFuW/rAQ/gGQkQO3Urh?=
 =?us-ascii?Q?vdiwIHpAsd6cLFwsCxuYzTIWYHz47xUQU3sKBn7+neXxqpieejbD+fJqVBGf?=
 =?us-ascii?Q?7l5XmhmDxmS5o4Qwo2L/4s/3n8LHChArHd0mL/EZmeF5GU/NsqfSa+ao8t10?=
 =?us-ascii?Q?RvAmm0EDVMfP6jfD5Gaz673isM8s5W5y6GOkzlZwG9bpW/WYmDrcXFEOWsiF?=
 =?us-ascii?Q?GRAcPXqu4fUUyF7QHd1pWp6q/M1Y+ODJvpdRXt+TJUE/QjWhFPx0Mw6iqBoy?=
 =?us-ascii?Q?XAndRemy/j7EyaEe0eSDBypOm5PajQgbilBl40OdXuu5Jy+nR1nF2C655XP1?=
 =?us-ascii?Q?TywCj9cFvG5//m2VVLgAGhKlztRqRhxi/oHzfh+PH2JnPg5VKzJB5d33iAaA?=
 =?us-ascii?Q?W5dHAgeZttgeCnzO+gk72PWV1OjtmtBBmIGdupbcZ1fZraSsincZNM8urqOQ?=
 =?us-ascii?Q?mcWpyBW4LFm/oCon/gGpf5ddiQqWQGBLD4YFTOoDmA8fRO9iwJqxaEQJdK9/?=
 =?us-ascii?Q?DzK8Da4z2lDbIoWIeW9TxBujIpu8lhWWk69YXVC4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ms2THmXwcaeGbQyW2/aH/cl5Vxp5Mwi7x4DGiVhe9WIabJuoK3QUNHPMnMSyhEtjuAspcZaMewcSKw4h3HMRjwtl2aIXSAPGfACR6tOutF6+0WHJx2SiTJzOkaAYGhv7Wj7Kmm1KiK8IAJ4RTno/MQV+SO636o9nRGvDjS8ejVrt3e8dBtuOkrvu9jrE9/I5kA4qebt5/mmfF8HEsqxKQOVx7VpwTaJ0PozDSJlKOGsXusSLaGQgGVWTG9mJJdY7Dt+Plk/EJaNw6qLTgAWmI+QKiXlNsnkK6IjvK0DIwuO3tQhytIIeamNHcQVa4oBDSReZXc3lFN72w4nlVXt5JIv5r2kE9v3Ty2AZsLkRd0DnR/VXKluTmie++Ir8ohOGs0fWBICRAz3ZNW6wNeAcQcJv8t6+BtzUMc+2VhAUYd1vDCaMAOZix+JWNVJMlLzUtR3IveLXdbpdKA++Q9rCOwYuZC+hez+thNu7ASsUea5X1I5+brektlMoWUz85M1g5HOJsFK8E5Tvqc+6jVkZHzHRJBccxfF9Bs6dcZW0HGv3Tt7tEQg+C55+OS/cQ9nc1uf8i5SfasNSxtTmnQrkZb5mYba1DqIPteQTXBiT7HQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c45f97-fda9-4711-5ea4-08ddefa66b50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:40:20.3052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2etDDRKtKlnKMxcqCBsxi3ODSmRWb0A81CPUxhhvW8WmLsaoWzHCTzHQT9OOOaFBcSXgmH0ehvuxYC4gGWlMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090134
X-Proofpoint-GUID: DXZ61bex-0qEmnQHkg6DltAF_lR5VdRv
X-Proofpoint-ORIG-GUID: DXZ61bex-0qEmnQHkg6DltAF_lR5VdRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfXxwjAHaj9rPGh
 vY/dVz32NrZG6WWFDl8ymzxKdPIqkFOEJmw1ftjnRFK3QTl+EUPHFIhqRtF/Pkn2qlA1DA0vSM8
 VZiszxH1Ouv8QW9+XgoBsdAar+sPeiu1QSkUfADctBYeV/iA99RurdlETJON7EcjNpvUtjYQuRC
 k995uP6hLkX3dBmQAp2sb9OQfucGOp4E5R89Aahn3M8RdmpOu8vrw/OfsavtHiVVImPyCKR6b5L
 5RbzZMMkYKoTMG+SC25NrsfnlEEn8WRgq7Tuyx4YZYH8kdG2eM7YIzMk2FKYFc7X9IeP9FIUcoR
 mGWypxbN8cMfCp+LD88xIDXnr+7T3l9Xk2U/2p4Z2OqcRvS3duNvFEWeZNig0XLDyqbBsb2h3Rd
 WHtjH+J/gl/7m0+i8YUo+IeUljWLqg==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c02e49 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fwyzoN0nAAAA:8
 a=1XWaLZrsAAAA:8 a=37rDS-QxAAAA:8 a=JBU-24PaHKBSD_OOYAgA:9 a=CjuIK1q_8ugA:10
 a=Sc3RvPAMVtkGz6dGeUiH:22 a=k1Nq6YrhK2t884LQW06G:22 cc=ntf awl=host:13614

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250908 15:50]:
> Jann has been an excellent contributor in all areas of memory management,
> and has demonstrated great expertise in the reverse mapping.
> 
> It's therefore appropriate for him to become a reviewer.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> I spoke to Jann off-list and he kindly agreed to become rmap reviewer :)
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fef05bc2224..ededb2cf8f9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16198,6 +16198,7 @@ R:	Rik van Riel <riel@surriel.com>
>  R:	Liam R. Howlett <Liam.Howlett@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
>  R:	Harry Yoo <harry.yoo@oracle.com>
> +R:	Jann Horn <jannh@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  F:	include/linux/rmap.h
> --
> 2.51.0

