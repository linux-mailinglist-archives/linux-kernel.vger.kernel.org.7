Return-Path: <linux-kernel+bounces-728019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64672B02296
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0A1C24BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F52F0C72;
	Fri, 11 Jul 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SoGFU8Jj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QZ3yHQfW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C25219A91
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254800; cv=fail; b=AF+ndSe94TL6rOmFGBDwRhWQHuw2uqcrJVPi2EPl+6N5Qmssegp0UZRWfTaNA6n/xjeJ3RDCjx6GJ2Byh27Mg2o3Vh3eugNGbCXydcjEmIEJEiuwFvJTDFZJEs59/5o/MAClvCYcP1oCmozPRCqkl12GE7OEBxsByYBLxHyFG9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254800; c=relaxed/simple;
	bh=q/szMylpH9IWz0b5hYOX6znCOk+FkhQC/skK29vaAIs=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=T1BT4puz8hVwDU9dJKCgbnt0/mj6qNWALola5QrGBYeCc1eJwtE/kgTL89YkAnfBT3pLjxj5gKJ82gJH7eW02GCStsra8gXcOoprrEyPUi84BpkqrG3mdIhOnzzlBrlfV2IiwA4ZNHRZAkcydmoQH1n6WR19p2YfJeSFCnTB8hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SoGFU8Jj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QZ3yHQfW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGRFxj025650;
	Fri, 11 Jul 2025 17:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dlu4Rk0fdfIROsc3aH
	RTtRd6sf7x4Ac+T2syQh6y4y0=; b=SoGFU8Jjr035cLw0xDlNvzMCFvje4mB3y+
	1bkyVgewkM1VPAtJNahGt58DGaonEb0PfMZn+p8Gy7+k5jgmsRJUZrVX1HHyK8B0
	iVqtcHhFgXEIs476jDlMU9iNuN4dri6kKGc2AfpFMrJ7dl/aDVTOqNxxu752iu91
	rc2d3Q7mHgiT0XTW0DvxOhtcgcyz1G0i5w+VAsFra6WXdYSGIHyC335o9696D8QJ
	GB4JDk75o2usJhWb+vi/Zkt3Tr2eLzr92fEv4saRCg5vxZ0Qg1rniqarw1j9evhO
	FmoTESLfoeCyoIBO9dey/4cgu5SrIvPQeV2LMqPXVWxw1XlCAhuw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u64yr4gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:25:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56BHKqoS014264;
	Fri, 11 Jul 2025 17:25:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgem95v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 17:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2cgViu58tf7O0QaxZrr5l3YVuxv4CCYC8SByf2kKYFzBhGqLRfGwC/SKI45/f1dAlMReugJdlSmxixJBsLdwiF8p5TDzCfy5wKsz5w6JQyGaUMJximUcfznui+NNEPR2jynFgc0icnGJV9R4c314/QRxnlzOGPb9+wfPh/HMyNqH2y5Kh1VcU4Cq/rHkW6Guv5yMjV3GQnITdPDgLXRoxmK74e5CEMtqwZkSfdTn2TW65rOCgQB4dYOTulSLAi8AYFyz1jEMZPvvu0C7/YvZ2CZt7Ug/aqmO47LdhDYlQjuRBjVPLh3/8aNFVPRShNc28+umEyIFU/ftPof+wbfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dlu4Rk0fdfIROsc3aHRTtRd6sf7x4Ac+T2syQh6y4y0=;
 b=M0lwYnjmfapLHLwRqXAYJCjVjPSawuosOzJ32dAXmWys3OLY8CCqDkSyakEb+q8CdjQMbGS4h5pfnZ9mo3/cENk9I/U35QE6+/fyH7O/Jh5wCZmPAa3riG1AOU5k2WeCElWIVpePhgJI0yPn1DWl7CY6QUHI+D3ryvIMnraYdKsVaXLNmNSgzI2AhqKeRtLpPCyssyAMTgi4djBe3P33PinvqX0Vx7YJwXQAKsRr3gbQZrmvAuK/D6XhlHWgFOPdJC5Pk9j+peMJT90CGQywCDssUNBRsRxCfIe66azyPBzd7XF37nFe7Nlt2OYZB+Ei8JvJIDBKEZaQIWgwdYIZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlu4Rk0fdfIROsc3aHRTtRd6sf7x4Ac+T2syQh6y4y0=;
 b=QZ3yHQfWu6POLU/0L3GhRzzY3+hhFrMF/E0kuekV4PSUKQf9+R1DcjPtH2yxZCrPlKcHFlttDTyz+nxmdb292m7v3skyQb7vpHK1PIIfE69kvaT3gxASyAX9lGn81Da8q4jWevokBODYIAWAILyrd6JnJji1GX3srTEcRHHX30s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB7981.namprd10.prod.outlook.com (2603:10b6:408:21e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 17:25:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 17:25:54 +0000
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
 <a1575434-77eb-4358-896a-6d0e62feef4c@redhat.com>
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
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
In-reply-to: <a1575434-77eb-4358-896a-6d0e62feef4c@redhat.com>
Date: Fri, 11 Jul 2025 10:25:53 -0700
Message-ID: <878qkuprku.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 24286f88-2db2-4f96-616b-08ddc09ffd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NFZ6Y4BLK42Sm4b7/SiTMpYnO8b3f+laRRXls3RMSUkHrvYhQ2tk5Emz31mp?=
 =?us-ascii?Q?VxMqYWvvpldpaZB8Qk+rFPXJ6fNK4Ra6947mwp4lqKJW3HFpI3BR/5vB3Sgy?=
 =?us-ascii?Q?NcdX+zWYXjA60equDAxGcONfAxIR9AQi7SPv5n80ywKFgzdOoaIW0J+vY4eZ?=
 =?us-ascii?Q?hl3BHPu86BtoqWs2G/t5HiCZ1nd7hypGcRhHaouJXie4m1R6v9JX4lpbzwt+?=
 =?us-ascii?Q?+AvEb/l66qi53Y8shY+nCu4CpnhnjxJIttUl/+Vy6HCzs5bCKYPdZ7XMs8Dm?=
 =?us-ascii?Q?mYYkIIyLyn42YtKYXhbCWdkKa3blIHhQFJWbwh5PHFJkPDQh4vKnlvAHleKl?=
 =?us-ascii?Q?td5rwnVtpg5KVBcdQbvJJn+0m1t1Dvuq4S/FSMa0rQuPo5rhB/6lMPTpOoP5?=
 =?us-ascii?Q?exlEL2XH4JSf0q34FG7l4m369sghJrAMv3929qn8zGGAhHucTxAWOqDm1+wX?=
 =?us-ascii?Q?Dn5fv3okQ4mzhSWngK+kCRv6kvbMeh09/gB4rwrVE2GCuotWacAh/fLyvROZ?=
 =?us-ascii?Q?sQDeDPmgBGMSnFTKRNNleu1WMOl/+loimHVIzfvVsXYhrEWjaGWJZ4+LC1qv?=
 =?us-ascii?Q?WsPRLkrsRkwRx9SVBbL23vJyW2empoiXKJfU4CO6VuzjUhWw+muf2gJ9Jgeb?=
 =?us-ascii?Q?qb4Vd3mfMTIVRMTjTIxAWZkT0MyzrA6+ODlmcFhVAqx9h33zx41X9vP7lAUZ?=
 =?us-ascii?Q?jUexUJ7DKfl4/JrpnQGkcmAr7QmuNiKcpABMax/5/nwXqdI5r95i8fLpPFIH?=
 =?us-ascii?Q?rs2stswthKazxtqyY2QtLKLGQPCJMdjdAfdLUjEvaqcMW7BllORB50tHJHE/?=
 =?us-ascii?Q?AU+Pylfq9tkSou0ahxShaZfY1qq62HjYQYrxVa8Fx60Zx4BN+041iZZ61A9w?=
 =?us-ascii?Q?6jLjymlrpP41dbUA5VRm+vfue5E87uwCKUpWQJQ4HbIZ/Ouyd2SCTjbAMpug?=
 =?us-ascii?Q?GtFXaLNG7bzUjNqCKCXxBJnEBnh7TXIrYs8NIG3pm5fp11TYu9l/u9FuzH+Q?=
 =?us-ascii?Q?iuVDvW3OSDHnEZpKNMgFmQBXWy0MZDve5oljgMEM2GlSxDQZcHjYCoNOYQ01?=
 =?us-ascii?Q?KVWXY+mFF0moYsn7MloYmKfntj7Oi6wgapLauFxObsmMzLU80RHFgnGoq7Vc?=
 =?us-ascii?Q?/3cHPP3JjWldZtO+LeScrMlzD9IVvrJzh/VZYJCIjXn5FH/5fF73Jjhzioks?=
 =?us-ascii?Q?RAJnUo4M4H+T5LTXtPclovyC9O/iEhZM6fh4MzH8yWcIUo9rGmaURA/34/k6?=
 =?us-ascii?Q?0+6uDmemDymJInizphmkeIMsIKA06Vp6br0dXvYzVzlOSv9VkjpYBfctqQkK?=
 =?us-ascii?Q?z0NCeXOMT0LisB16YIqkmruf4E6A66VhRtvdWqQ/p71BnObOzso5be7zrFo5?=
 =?us-ascii?Q?2HdJCPr8kL7Y14mU5Sg0BbNITDLkTVUMiv8twxRePWtCV9trY53d4PahFBbc?=
 =?us-ascii?Q?aBBAtg/NQq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MYJafJoLMhj0u3kQfv709IO4DjgZN7tpxVp751S4BrNrkWPUCqXT0vmtpcHO?=
 =?us-ascii?Q?o/OzXXyuSm3GWxS7N8Cy+4PKpq1AR7WpihyKn94seYNOxYDac5Lp6Fu7w7Rv?=
 =?us-ascii?Q?ZMLCnTiCGxEu/tj/hUme51cG5EwcueHv+dXXYvS6vxVc9QHvbA6KiOpZQ82q?=
 =?us-ascii?Q?y7O5FKW6pBvnaZT1otZS8a9vIPVRb0BvCTWCRkhBq/aHojvJHK4do007REHC?=
 =?us-ascii?Q?9qErj/h15eWpiJrXTSVLNhz/+ovnFNdQ0facsMV0y7vCQpMGkeSsqNa/qv9+?=
 =?us-ascii?Q?nlocYjsrSD7X4geMykgOe98Icuh6Xl8a7lFJWeU6u6ID50SHS44nuhKEomCD?=
 =?us-ascii?Q?aYq9sX4zIq9JH5vjOA6nuOIZ/JJPGnFV6hmcgabxPF80F6DSbLYLZEX2f2/C?=
 =?us-ascii?Q?MfCkvO80cCl3YYeUMPHJjKGq10h/CiLGs/z8pvGxKUTSCQZ7uvhRmJAlAT3a?=
 =?us-ascii?Q?GWdo3newOHVAr+Vq4CqWf8kWaCelDxNeNxze/T80QSYwlLfUQDZcp1d3+El2?=
 =?us-ascii?Q?e+3s3zImBgZwbWQVY5ytt47cRWqVgVNUkgXca4hxbjTP6Izb4wls8Fpa1kN7?=
 =?us-ascii?Q?/7VIzuma39mMwscHhUCcH8Fxw40VmrQFK2X7algYmnyUAKbr0MDsCkwzm8im?=
 =?us-ascii?Q?DhYPM0lUnABUcB0FB6x0KW2sOhEXhtZa3cS5Mfmnzfp6DdTFYEd+bKjraous?=
 =?us-ascii?Q?4utUJwRTErLUc9akMRSgBAqVoM8dZzmH0ExXG9PofznVlkl0rQ+oNYAbP8W3?=
 =?us-ascii?Q?rtvrWc/Wn4PLJ7NXdh9QN5TpYW0NyeK8S0RMiRzNAyEsy9VnkhDgzoG1Zcfu?=
 =?us-ascii?Q?cFdSkTi+6Y4jHVPD4o1ohf7OnSSxzmOSQTOaSyPFJdD6zgvRzmkMyAuDnm5v?=
 =?us-ascii?Q?AuiohHq0c0rtZik7157+Z5LIsXXJ3LC08oRRhXTsnds1QCB9loX2cFzUP29W?=
 =?us-ascii?Q?gSeVDMNu1q79E/+ylx2pavFrRPmwLaOttHhBE1X5GOXkyD6wbjHkQ3gWKcgi?=
 =?us-ascii?Q?p+V5v0B2WhFUHUrTY9PDbOUPqtRpAHf/Q3fKUE0TuwbR+ynHYj6bm2DwN1ED?=
 =?us-ascii?Q?s0mxyaqNrHTmNw4QkPgsctiS6FzuplDSrw3FVc7GIdHJADmdA1ClO8Wgd5DU?=
 =?us-ascii?Q?jfUdma9iCkK5mRvpWstpTtSMd3jX6WsQ3F88OgxGp+a19wD4aAvKA6dBmVmf?=
 =?us-ascii?Q?K3NGZTBAd2W5G7HW0gTFJgBcluUmycuIWxAOjEWoE+wodYhDdBcfHwvW3grE?=
 =?us-ascii?Q?hN5IwM0hpN2HeyIu6fW0gqFD3TN8mYDutBoDtPHx9fifPDjVZ68B6MO4FfrA?=
 =?us-ascii?Q?eX4A849eQq7nNXfy1MNWlXmHPIafR3CM95JuyGnfioU2jUzerR+SlPtvWAc4?=
 =?us-ascii?Q?hCuCqAEaaS04q9feTvzmv2uUgUwzb4OQvlOz9ooByjxk+635REFkiGmdiCp1?=
 =?us-ascii?Q?AuE0hOOq3I14ZfTQkPbxu8iBRu2rKPKPYrrE0cDAdBI10j/zGjYeLA3pTlSU?=
 =?us-ascii?Q?jpYdowh9Fj3ee5QaT6C3w2frJ/QtdKXNoibCzog6sk9EHCHj5cU3MG8bkp78?=
 =?us-ascii?Q?AhMYqgSbFsxzsbnwzh9UawAhx9gF/JUOa/KXb0ZFYXB3lWfg6iST6WzQ+Vgm?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tvfr2vETwzcIIptEGtDZs+2merQckLvmbq5goejNI89EdpZwPZ4qE1Nz+jzpR97437HMSiwF2De3TgDGNQLtT//krWkNugNlcojcFGxnT7BJ4ZvBBTrAjzYjP1UbVuQlWb5x30dr/mqBQuJH5yEOqBiGXtfeWHUkhGCAz6Np9Luv6pHTL7CIGqlxKAW2GLCWI+O8qAWab1Z4zxFC2zJwK6+Hds/IKNE/3BdTZMcRWuqJTKs6ey2V5F45KQHVi/nSdEzWPiZ2FU4V9oEVr62YkMzbxVKip616yz/BEdlGHLp+jxK3fibVpRm4xsgrMWfKqyHkh3H5R8oiKh3TPfx0ZxJ/nOj3NbeRMaSTt3HGiOp25XcFo9NstTf1myC2oVDzTlHoPkFzMY+vpvJsau0fZ/gICssBDw9rgX304Y0tECL/wQV7LCe6XAxoWJVnHWgIGyFeO1ueaJmeAxtlgyN1PrtISwNB/refr6HC8+4x2XC4vz1NCZjtmBZ/w2DSxRakXKYZIpf/SkhTC3YQfSmxkTseBma8uB5nycL9YILC3wTwrWDnIT4HYWz0JYfd+/WG+h3EvOjP1GzWJ/A2caka1VGkJcae735IhHD0r7vwK7c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24286f88-2db2-4f96-616b-08ddc09ffd9d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:25:54.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZesQpVTYKGiueMU/KI3lLuRwWxWeTGCxEyScAW9dzGcgqhjb+rjtheJNgSVRzfAR+rWtdyydXJ9RFHiyuJ5mp0hFcQdPYopDiKQh6bKINyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110128
X-Proofpoint-GUID: 4kWnASlpLzB0UiD0Pnfrtq2C5AcwfdD8
X-Proofpoint-ORIG-GUID: 4kWnASlpLzB0UiD0Pnfrtq2C5AcwfdD8
X-Authority-Analysis: v=2.4 cv=BtOdwZX5 c=1 sm=1 tr=0 ts=68714927 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=ZCfmum7VzfdetpSvuQ0A:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyNyBTYWx0ZWRfX3dS4aTj2cOLB gCAlDe2xqJS6Zqw/fAl2sUXjv53Wjuw1XjrV73lvGRMMU19pPnyzNEO/LMzYisdxcD5rNhvDk4a KRWWBuwyIY1UjhDyUU1vF9Hl+fQeK70GHOYeKiGpiMNbl9BNzNO3p+dOmIbdVE5fsyzl9rIT7zw
 2/dyhsTdcISqOosNpzUM5yoe3Be3ZE1ozoYCtbRA7eoB4zSq2gzobtcu8VPQzV5qPOsCiRdZNYz QbxKLIcAxBwuLbUbhDqMsK/bNRxg2c/XXWSI8iZX1aUJvGx6XSL5iruc7sTIOXgLpimKvq7o+V+ sTOTQbMgiArXv3Zcn5gsSyvFFlvChmFC2XkCpgDX7qKkkaOgk2LybDUmFw7GQnf+PR6NQp7TJXW
 jSC1in1YrrlRkEuuygqLwlU9Y9NVn0Av7z9m+ppuFS4JTkz0jSLrrgP8HVqtlc70nIim0NRU


David Hildenbrand <david@redhat.com> writes:

> On 10.07.25 02:59, Ankur Arora wrote:
>> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
>> where architecturally supported.
>> This is only available with !CONFIG_HIGHMEM because the intent is to
>> use architecture support to clear contiguous extents in a single
>> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
>> which excludes any possibility of interspersing kmap()/kunmap().
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   mm/Kconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 781be3240e21..a74a5e02de28 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -910,6 +910,15 @@ config NO_PAGE_MAPCOUNT
>>     endif # TRANSPARENT_HUGEPAGE
>>   +config CLEAR_PAGE_EXTENT
>> +	def_bool y
>> +	depends on !HIGHMEM && ARCH_HAS_CLEAR_PAGES
>> +	depends on TRANSPARENT_HUGEPAGE || HUGETLBFS
>> +
>> +	help
>> +	  Use architectural support for clear_pages() to zero page-extents.
>> +	  This is likely to be faster than zeroing page-at-a-time.
>> +
>
> IIRC, adding a help text will make this option be configurable by the user, no?

I tried changing the value in the generated .config by hand and that
reverted back to the computed value. So, I think this isn't configurable
by the user.

From a quick look at the kbuild documentation, for this to be user
selectable it needs a prompt of some kind.

That said, the help text doesn't add anything here. Will remove.

> This seems like something we can just keep internal, right?

Agreed.

Thanks for the review!

--
ankur

