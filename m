Return-Path: <linux-kernel+bounces-750450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABB9B15B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7059E3BB066
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3F266591;
	Wed, 30 Jul 2025 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMf3bZnl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D826292B53
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867346; cv=fail; b=Yb7tqUFZJpLbVVStlRSXzx25ZlOlgAbyJ5DkVvYEJpQH1GELYwkJDPO2tQD/c/fPjNXJSKVeYd/4TlXyTKP+MdxiW4fGcQgadc37aXjRqZwI4RZ6k8iczJn2BDL0LpLmyY4OisESxQAdrHFVjw+Npij+C/Q/tUV7FbmsiUykHGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867346; c=relaxed/simple;
	bh=b81vCYAgDYWnFo/X37o3ljmjTkBeYDqEzaqUSGx/V8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8sw/QiPHSeXLbCPs3yi2jX+lb9i3OmHpjt0/npdek+XzK7cyTwNpecO9KXAdfGsWi6MkRU24/JDu0cre+D0FDn6cdm/Oeo9ZJ52Otf+HxmhHn7cGLxeaOwdX9TwO/5UjzjJLjCoyimsS5eH2c3qot5N6Zme5x9tqCvbc6ciLHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMf3bZnl; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP6KYw+wLh7fWyYKIJ8eAeoPdXfcBlaHkqgwR+YTBU1W77jA6gjqAjZoExidUCWzmIy27ai2+GHtEtiNYhDxDmOioDI3WDuuKIuJa6O80NK4jk5S9J4vk7s9LodP+jMVZWTRuwYsWR+rEDf07lVU3BOZKe5ES4zGgXXi9DgoqigTecVJ015kGTARMhTVceMmugqit6w9rVV3E8r+nVdUClg2V1DbrckRAtO2Obrqm2mW4han8QRTVzJvt+EJWQAILXd/wKQHYWvD+JD+9KhZ8gMOC6X8kVVF1nME7h3dQp4+g9Q8PfSapFErGbbMuZJ68u1CB5t9yoqb8x8Pflr1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsP/IAQ6Ua9wYWxGynj+7OxAJZwGTafwFRbxz54zuOA=;
 b=bidSEMcQXPuEgyeQWgOT7zTvla9DzjsWSQ/grgu4Lc0bD2wWpw1BdokTyjdmvM5nod1d361W5iXKu2ZEwtdFoehC3p53WldgO3jNMer7+YW00InjUjDllKtRWdGKumjtoTcr9gpg8F2p7uhWXLHBtoeOTjCCToUNsCmDXuayGzyifFmN311UopufH/uIb1vDsid3IFRcyI8Voi/nLefLK4Kf8AX9oyVvjFqYtbuqJMlbj3ambKQMfXuy0Mei4Bcxg1RqEmnh6UfBj+JgZmpTwlgc/iIbQZa0yOdlPnMEmvuwbBnbclta8QMxBooSv7kwvWFLlURyjNx++fy/9KvJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsP/IAQ6Ua9wYWxGynj+7OxAJZwGTafwFRbxz54zuOA=;
 b=pMf3bZnlYvXM6qfzAS4YlT+0QLeodUQItE0GLDysqFXeDkb5ZqtZraus5j7SvGZF/mXDo0c/u+uKGE9xOtSMAif38tzwM+DuD/RMoIiOLuLZp4ecjHvvNJuwdwErdXb94/mE9bUGnvaeE/VjHNz4MSzIqVMCbCLlF2Fqn4+uiWB6XWh9FIUV9TXann9h9rTBAt81V5dMjH9RBiK42G1Ny5GlItqXV2QRps7DXO8jDvk5FUwt7z6jVoKmb/lgXBsRty+TAdnd3NFFEVYH3uhlMiMOoY6M6bZ5A7LR6+6WpJ7v0L00vTO4LqVyIiDVPUMW+vTH3bcm7lhZW3wp5norkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:22:20 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:22:20 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [v2 09/11] selftests/mm/hmm-tests: new tests for zone device THP migration
Date: Wed, 30 Jul 2025 19:21:37 +1000
Message-ID: <20250730092139.3890844-10-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:806:120::13) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6bba58-3d56-4e60-aa72-08ddcf4a95a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REE2MG81SktQSEF2MExCWlhqMDFSc05GNzJrR3A0c1ZSRG43dVRTWStpZGFo?=
 =?utf-8?B?cFY0dDN6WUFpRkNqc01Ec2ptaXBEQW9vL0NKYkQyMlBqaVkzMGN3WnJYWk1X?=
 =?utf-8?B?c3RZbmhZdk10aDdRQ3dUR1oveHJXcHlqaUloYXZ0ZTVhelpRTDdUYWE0STAv?=
 =?utf-8?B?SkhvbnZSaEdEZi9MWXF6UGdJeE9rVm0wNnBXbWE4MmlOamQwczRZbVIyYzZH?=
 =?utf-8?B?c1dGcWhXWTBCbDFQVzZZdEhsZ0cxY1JmY245d2wzUGZoTUQ3RFA5WnJIVTFR?=
 =?utf-8?B?ajE1dnBmdFQxWCt0bXFycU9OVnNJYnFuNnZLNVRVTW9tZEYxWWtUbGgzeWNu?=
 =?utf-8?B?WS92ZmxyUDU2ck1ncFFaYWFqVmM5UitmZXV2Vyt6SVpld0N4NHI3UmltQjNM?=
 =?utf-8?B?WjNFQnBkQTRWVklXNER5VFB2amplYkg0WTdPTjZJeEY3SXZGdlA4MVZnSG5t?=
 =?utf-8?B?aDFwOUdFdDJkeC9wZnRHRC9GSVhhOTJjUUR1T3FyOEgrUzRXSFFBU1JPdllw?=
 =?utf-8?B?YlNXSzNuZHl5YnFQWEo4NXVab3VudE5vRnN0cW10VEJzaDhEcmFNTENqQlNp?=
 =?utf-8?B?NnlEais4N3MwaXpOUzBEbWs4S3paVTk2OTBlUWRVallqM2R1THdSdkVEMzAy?=
 =?utf-8?B?MFQrSkFDOURBMG1DWmEra0RuUmhoNGpPdHBQRU9SSWhyZWRxT0oxdk83T3dr?=
 =?utf-8?B?d1JPMk1UU1I1a2JGdHN4ZDJxU244TGVEa1pSZW93RTFtbm5oT0RLQnRsTGJY?=
 =?utf-8?B?aFRUb3lHclpjTzZuclhhaG5wRXh5Z3doTDVLaTVSM2c3a3BuWTB2WjZtNWd0?=
 =?utf-8?B?TU9aS0JFNWZ2QlArSGpoeXlYSTdKZDE5V0dSMFZIZmdlc0xsRGkyYzBabVZZ?=
 =?utf-8?B?RlNLT1k2WmlaNWc4YzNZZDROSkdUWlFzcXA5RnRUemh1MnlvZ1JFc3BDeTFR?=
 =?utf-8?B?SVJZdVZyWVVnRXQvUlJEYjZRZi82akVzTHByVFhrS2I5OXYvSUlwbzFadGJ0?=
 =?utf-8?B?SlliUDFwcFBXMVRjVzEvQjZvTzZ6ampkLzc3M210WXZOa3BISUpISTJya0dm?=
 =?utf-8?B?RjB3RTh0b3QxcE1YNWliZnRua2lob3QwVm9qSHQ2eDU1T1BsYXd6WDA2cmFO?=
 =?utf-8?B?Yk9lbFUxNzNJWG10OEE3Q0ZnZ1lvWEhvQnh2SnUrWEY2YmxhTitaYVI0eHlB?=
 =?utf-8?B?amgrYk9maTZPUzdoZHUvdldvbTVnS01hbFRPMTQ1ODQxcU1xcEpNdWdGWlR5?=
 =?utf-8?B?R2dQVkljS1lBd1ZPVkN2SVVlWlFCNERqS1kxcVB2cnI0QlVuRitFanhBZC9L?=
 =?utf-8?B?bVZzcUl3ZEtxK3hhcDZRTjNoVEtOSy9wbE1XcmxEckI3bWI5UEFsQ0xHU1RO?=
 =?utf-8?B?M1dXdE1UUUt4ZEFySFRmT2toUVZ2TjdVQTRmelFVR0FjdHN0d1V2amJ0M0N3?=
 =?utf-8?B?WnZiYmZzcllTYVp1Z2FYeDI4OWNRYXVzRW9vdjR3dm9ySXk2dzBCdzh4SVRS?=
 =?utf-8?B?aDVPVUpjTGNSem8vV2RUeENoWHlvN2RMYm84M2U0aDE2dTIyc1FBNkllVUhu?=
 =?utf-8?B?N3BNVWp5S240QmZVNGRLU2JTQmV3V21ManEwanZ5QjEvN2drTTNOWHFxOWVQ?=
 =?utf-8?B?NDVwWWZWWkpqejFzK1RuSHpNUW9TUHdkcXpFTmdaNlNVQ1h1NXZGa2wza3Vh?=
 =?utf-8?B?RlcwdURTdDRKTkxPYmZGY1gxOWNQR1ptdGNPWUF4cE94Z0dmc0tRMDRBeFMv?=
 =?utf-8?B?N0ViL1V2a1lTQ0VBcUQySlRubi9rbWV2dnFoZjNVclhwOTYxTldwYzlycWR1?=
 =?utf-8?B?ZzVFc1hqYjJtS0dXQ1VtRUN4cTFlUklwTWgyQzE3c0o4WVFRR2ZPVXM2ZUNy?=
 =?utf-8?B?aDdXelJkdXBLTm5lN0JUK09Ha1BlRWxmTjhnOXJnOGl2L2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjIrU3RWbGVFYXVFSTR4eWYyMFdEWHRvSlZlYkNxRDJ2MjZjekhCNWpKWnFl?=
 =?utf-8?B?VVVpc0YxVGhQZ3NZd01ZdHYrT0NhTlZwUE55MStlR21seHpPTDZzaXoxMGlk?=
 =?utf-8?B?MUpRUlBGb2crWXZSYm1UWldzdW1ycmFsMFMxaVNGN1lxVXBEY3lMMjF3azMx?=
 =?utf-8?B?cmUyVDhDQmVZaHlwa1hzc29wN0RLNy9mS0M5cU1UMUpzNWg2aGJxU0t0OThW?=
 =?utf-8?B?WE5oVnFrcXRyb3Q4Nm1MWmxWOVZKa21nWjFJVElMMFVUY0pNc3VpVjRvYlRT?=
 =?utf-8?B?eGFFSThhSkthQkNFUjVhdTh2dFc4VGxyWnJsV1U3TlltUnAxZjRLUmR4OXNn?=
 =?utf-8?B?TXJHUm9WcUFza0NRMWJqUzJGblJrWVk0R1kzU3NUeWxYTUViSG1yWFYwOUp6?=
 =?utf-8?B?aGcxc3haWEk5RXVBNXFsdVNuTk5ISDBwRkZHOHJGdEhkRXRIUkpKMDdldS9E?=
 =?utf-8?B?SnlDRVZxRmNBRk9BaExza2dLSm5xZUlYa2JUeWlqSkg1OVEzTnNPYXBvSjE2?=
 =?utf-8?B?eE42TjlWTkh1OFdJMGNFUHBJQWN2NkFRbmtqOUc5Qk00Y2pvWGZ2U1k1alZJ?=
 =?utf-8?B?d2s1c3VmaWlMNEFkdlIybWppbVMyOFIzcXUvOGxXc2V1NHZFaVJxOXFnU1pz?=
 =?utf-8?B?L2dvZ3RXMklFSFZncVJYdjNYd2lvaXBRSm1Gd3UrcXVUSC8veGF5UEduMzR2?=
 =?utf-8?B?OWZoUHpDQllsMWpVTktBRGVHWDAxV1JoMnhiZ0hic3E1S25rU3BwNDFlY2RR?=
 =?utf-8?B?aUU0ZUg1ZWloaGRQMVpsTUhndXloTHF2cm9MTjRCOHNNTkhBeGE1S0R4YndW?=
 =?utf-8?B?Uk53S2tPK0NOck5Jdm5mZENJQ25sTzRzVnVGWUJucnJwaDRoWnhXUmFWT0dT?=
 =?utf-8?B?Wmk2NUJubDEyOWtGVVN1blJVYmlUN045NlNUNzRtM2N3YXBaaGxUb1o2UlVT?=
 =?utf-8?B?Qi9ZalJMN2pueWU4T0w4N1BzQkR2QmxqNUZnWkpiM29zUXRCNkVUN2YvczBu?=
 =?utf-8?B?LzlNd1lMY0I0Mm1UTFpmUnFlT0pnK1BFRmlKWml3Qk9JRHdSdy80WjJ1Yld0?=
 =?utf-8?B?eVI0cFRVdkUwdmthdHJVMVhZU3ZaWU9aODYvalZuTkNvRDdISlZSVGtabkJw?=
 =?utf-8?B?M3VjZ2QwZmQzYndUWGdvRVJhWEdYczJZUDFYQ3ExRmlJR05xMWZqZGdJVlps?=
 =?utf-8?B?bXdiVW0wTTdIZTZSbEYwVjdacXUycDJQQVAzc1g5dlYwcGpsTGkxdkpKaUxs?=
 =?utf-8?B?cEhOMit3em41QmFhcitmb3RadVlMUFJuOU41cE1VUjJFaVQ4SW0yTFl5bjF2?=
 =?utf-8?B?TmxUZ2lVcm5VQ1BKRDZVUDJVVTJOMWFyS3RQVzhCcEc3Z3RJQkswRHlNaHE5?=
 =?utf-8?B?RVFISGlSRzQ4MmcrSHVxaXVMQXRTbTdiZFhnVVlFWkZicFdYNkczemFqYURx?=
 =?utf-8?B?a1hSN1p6dFNmMDBnNUlCYnFYaVEzM29ockxTd0xabFpiakVPZjAxU1JDQ1lL?=
 =?utf-8?B?WVlURmpKM1dtVnRPaUp1QXdKUlNMRGNQYUVtTmMyaHdBcG41V3JXTktnYXRQ?=
 =?utf-8?B?QjN4djJHWFptdWRTOGhmcXRJSkYxR3RoVHNwd0JUcXQvblJYMG1xR1VKMkJw?=
 =?utf-8?B?M0RFK0IzYUFHdVF6bTVSRHJUQysydkhQYVNieGZoREt0QUZPVWRMRXNTdE91?=
 =?utf-8?B?NkJZbk03UnIzc20zc1FMSWczNXh6dm9tY0V3TlcwNG9CMkNOVWNLd2xTaTBq?=
 =?utf-8?B?SjZFMUdnbVUzcmlVdnNoQ0ZQbnNxM2lHekhSeHlHN2RtTHRxZklzaE9JYy82?=
 =?utf-8?B?MFRFbGk4RHArUWpoRmpvRjBtRzNvcjV3T2x0dVUrY2NLczVJaWszRWViblNt?=
 =?utf-8?B?K0VJVHFES0dOcDhKUjUyYUp6Y2JFMnBPVHQ0VlBNTUpOUG1qc0JIeVJ3akl4?=
 =?utf-8?B?NVFqRnBkSUdPTmI2QVVQNWsxRzk1QlVOalJ3RThYTFdGVExJZkhlR0FhMzN5?=
 =?utf-8?B?Z1N6YW44ZGJqU1ArRHlUc1R1T3JOMmwyNDAybUNtU2R4RDZ3dEJrZ0dMUlVX?=
 =?utf-8?B?RkpMVkdlSVJ4YmJOcEZ2Um5PaVFFRnR6U0l5MEROSFVwaEdJaWl1U1Y1aFJU?=
 =?utf-8?Q?CWJadOrW4GLCbN1nGVzvRVCwp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6bba58-3d56-4e60-aa72-08ddcf4a95a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:22:20.4588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+tBz6yKiJq7MZ7tashXvv4m/S6cxFEqHj1QdicgH5Gy1SsFM2M+16luzm70EcCCdfsca6wTKTvtCKitmgkwGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

Add new tests for migrating anon THP pages, including anon_huge,
anon_huge_zero and error cases involving forced splitting of pages
during migration.

Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 410 +++++++++++++++++++++++++
 1 file changed, 410 insertions(+)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 141bf63cbe05..da3322a1282c 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -2056,4 +2056,414 @@ TEST_F(hmm, hmm_cow_in_device)
 
 	hmm_buffer_free(buffer);
 }
+
+/*
+ * Migrate private anonymous huge empty page.
+ */
+TEST_F(hmm, migrate_anon_huge_empty)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr = mmap(NULL, 2 * size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr = buffer->ptr;
+	buffer->ptr = map;
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge zero page.
+ */
+TEST_F(hmm, migrate_anon_huge_zero)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+	int val;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr = mmap(NULL, 2 * size,
+			   PROT_READ,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr = buffer->ptr;
+	buffer->ptr = map;
+
+	/* Initialize a read-only zero huge page. */
+	val = *(int *)buffer->ptr;
+	ASSERT_EQ(val, 0);
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Fault pages back to system memory and check them. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i) {
+		ASSERT_EQ(ptr[i], 0);
+		/* If it asserts once, it probably will 500,000 times */
+		if (ptr[i] != 0)
+			break;
+	}
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page and free.
+ */
+TEST_F(hmm, migrate_anon_huge_free)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr = mmap(NULL, 2 * size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr = buffer->ptr;
+	buffer->ptr = map;
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Try freeing it. */
+	ret = madvise(map, size, MADV_FREE);
+	ASSERT_EQ(ret, 0);
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page and fault back to sysmem.
+ */
+TEST_F(hmm, migrate_anon_huge_fault)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, size);
+
+	buffer->ptr = mmap(NULL, 2 * size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS,
+			   buffer->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	old_ptr = buffer->ptr;
+	buffer->ptr = map;
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate memory to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	/* Fault pages back to system memory and check them. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], i);
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge page with allocation errors.
+ */
+TEST_F(hmm, migrate_anon_huge_err)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(2 * size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, 2 * size);
+
+	old_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr = map;
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i) {
+		ASSERT_EQ(ptr[i], i);
+		if (ptr[i] != i)
+			break;
+	}
+
+	/* Try faulting back a single (PAGE_SIZE) page. */
+	ptr = buffer->ptr;
+	ASSERT_EQ(ptr[2048], 2048);
+
+	/* unmap and remap the region to reset things. */
+	ret = munmap(old_ptr, 2 * size);
+	ASSERT_EQ(ret, 0);
+	old_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+	map = (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr = map;
+
+	/* Initialize buffer in system memory. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ptr[i] = i;
+
+	/* Migrate THP to device. */
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/*
+	 * Force an allocation error when faulting back a THP resident in the
+	 * device.
+	 */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+
+	ret = hmm_migrate_dev_to_sys(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ptr = buffer->ptr;
+	ASSERT_EQ(ptr[2048], 2048);
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
+
+/*
+ * Migrate private anonymous huge zero page with allocation errors.
+ */
+TEST_F(hmm, migrate_anon_huge_zero_err)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned long i;
+	void *old_ptr;
+	void *map;
+	int *ptr;
+	int ret;
+
+	size = TWOMEG;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = 2 * size;
+	buffer->mirror = malloc(2 * size);
+	ASSERT_NE(buffer->mirror, NULL);
+	memset(buffer->mirror, 0xFF, 2 * size);
+
+	old_ptr = mmap(NULL, 2 * size, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+
+	npages = size >> self->page_shift;
+	map = (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr = map;
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device read. */
+	for (i = 0, ptr = buffer->mirror; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	/* Try faulting back a single (PAGE_SIZE) page. */
+	ptr = buffer->ptr;
+	ASSERT_EQ(ptr[2048], 0);
+
+	/* unmap and remap the region to reset things. */
+	ret = munmap(old_ptr, 2 * size);
+	ASSERT_EQ(ret, 0);
+	old_ptr = mmap(NULL, 2 * size, PROT_READ,
+			MAP_PRIVATE | MAP_ANONYMOUS, buffer->fd, 0);
+	ASSERT_NE(old_ptr, MAP_FAILED);
+	map = (void *)ALIGN((uintptr_t)old_ptr, size);
+	ret = madvise(map, size, MADV_HUGEPAGE);
+	ASSERT_EQ(ret, 0);
+	buffer->ptr = map;
+
+	/* Initialize buffer in system memory (zero THP page). */
+	ret = ptr[0];
+	ASSERT_EQ(ret, 0);
+
+	/* Migrate memory to device but force a THP allocation error. */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_FLAGS, buffer,
+			      HMM_DMIRROR_FLAG_FAIL_ALLOC);
+	ASSERT_EQ(ret, 0);
+	ret = hmm_migrate_sys_to_dev(self->fd, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Fault the device memory back and check it. */
+	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
+		ASSERT_EQ(ptr[i], 0);
+
+	buffer->ptr = old_ptr;
+	hmm_buffer_free(buffer);
+}
 TEST_HARNESS_MAIN
-- 
2.50.1


