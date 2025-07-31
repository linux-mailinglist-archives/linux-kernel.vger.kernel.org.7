Return-Path: <linux-kernel+bounces-752672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83254B17932
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A605817A0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B6272E6B;
	Thu, 31 Jul 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ERROlv9Z"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836361E2858;
	Thu, 31 Jul 2025 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002370; cv=fail; b=ux5xAUp4Gw593vgYOpjmcg2yLYLWEDHKvjBIXS1M3f5nvOeFqiYqwA4frwzmbCLWOcjjFvS6AHyK5NptsgQHWp0x4a3E5WV41zFW0A8QT/dusniDhdNpjDaVJzy1ws/85LJeDEfzFhuXWaSFCySN3f+IND4njfvz+ztf8Y4NP/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002370; c=relaxed/simple;
	bh=MX9uUIY7iwa+KVqg2gacPzxWnbvUZV+khAf5gtJJtDc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QnM2ZwJcdGJXe9aTgzAXNHJ0//dk3EcY/gHLWR4BvsBlU+/Z3mqJWoEtiDtHTrAyE+O2wuqnlsW5TqncZf0So6SnfmjElYze4FxUJQHyTeixlBp37peEuRJxuJc//VunhkcROwexHRMByxYvSmhSvAlujwlfGv467avvy945SNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ERROlv9Z; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLtuvcMTLuJJGRMwxM4qwRkIUxxK3KubBAJ1eyu6BD5vUdgTBH6hgcRrBJBWqxscc0PIqpnJv1n8Z9PD1gToETE/Gqu4PN4xkdECzVuEsRJ490cQF77cQbSECCuQe7OIMJo+L9nJSafsXq8JxqI7W4aeckVylAeVYMKCcs+MDbwrRreEhYUwbSu/UFxx1D7O+BovzDtrqU/Ese96l/oumrp2V5JwGhNGsNm2Uly40oTOEbXUI9RXluXfvzh4NGk3fAiQWClvHarN7zgo3ua5/C/SPUhkeLuTjZyhskQcGH4hSaMbXJU3bVlJyeEkbkbW0xfxjhBSkH1ZCEgUqTdQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OaKg3mT1xYeqzTpSrUajJbnzWNe6jDqYuj1fQ9QENQ=;
 b=NP03KZkjjt2bIzGx2LOjPZftkyfrJFG0IgTX4X5pMP71/4Ir+LajVUXS7qQR/65XaAp/ENpX4rTidEHUq/FD1fP2lLhOhCZ0J+QAmFrkPsE+kHBwXkeKM5VJ6ch4sbNHSrHVVGbZ699gmB18MGO35xkl9EvuFRKMX3GW/28uWmwUchqdQz5S8yZILtzE9IY30CNzllhEto+s7/ierq5xVeb47770eQA9Y71hLRvOKEZ2wxD3ju4V+sSYEmQ6kap0kwwP6oT6e90TXHlg/0Y7hMCsYQI5H5CqGKVS3l5+SEd9g0MmTQSCxXu9GiUmq/fYjb6iypdGwpDVUWGNGgCxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OaKg3mT1xYeqzTpSrUajJbnzWNe6jDqYuj1fQ9QENQ=;
 b=ERROlv9ZvED2oJNz7ck/kRYdbs7dgIMw5AeTqOQv1ZDAxW37LCKgNgo0oG64963aBrnDfeQzMiQ7nilLKVrYXSvVeG/gGZq7H4h28MctpvjsA/47Kt4l2uL38ZAiu4tfNOX9bjNRPwSk9EjSPeFKeDXL+SoxH2G1fVQho3oVIMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN0PR12MB6341.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 22:52:44 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 22:52:44 +0000
Message-ID: <5c784fb8-fafc-4529-afd4-d1acb71aded0@amd.com>
Date: Thu, 31 Jul 2025 17:52:40 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v7 07/10] fs/resctrl: Add user interface to enable/disable
 io_alloc feature
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
 Dave.Martin@arm.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1752167718.git.babu.moger@amd.com>
 <e311fd8f4ddfd33c29febdc71d5d41f8a06680cc.1752167718.git.babu.moger@amd.com>
 <ebd0a6bf-cb55-47ba-b9dc-65f56b065ab0@intel.com>
Content-Language: en-US
In-Reply-To: <ebd0a6bf-cb55-47ba-b9dc-65f56b065ab0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::12) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: bda33dfd-a156-4ebd-a47e-08ddd084f62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2hRblppdkU5K2wyOGJZRlREN253TUZzNmZvMzlDcndsKzhIbkdPUkJGbnBv?=
 =?utf-8?B?cGQ5dlpqSC8vWWVEQWozcmVqOFZCRDIvQkdHL0JHMTUvcjg2cmZSR3RyUGFy?=
 =?utf-8?B?SHlvYTYybnlpZlQxcHhEN1RPejEvSW10SmFrMU1XL1RpOVlWTm5zMkdCT1dT?=
 =?utf-8?B?dEQ4amxrajdiSzVVYWhpTFQ4OUNQRnJIVnBsUGtEYmVPbjFYUmtBMXdPczM3?=
 =?utf-8?B?YzNFaHpiZzVGeUFDclA1YlRlbnh6QWovdG9NL3J3c0x4V2d0bGhzNlZkaVRP?=
 =?utf-8?B?djRhd3VWUTdFNXI0YnAzYnAzUUo2VWV2cUw5WmJDZi9mZlhvZzM4b0JYVDlU?=
 =?utf-8?B?MzZiR3kwbVAzK0pvYmxWOTd2OTltKy8zZVJ5a2hGQ0VXWXpNRW0wR3hRNWdx?=
 =?utf-8?B?WTVJNUorK3R4NVZVREZDb1ZESFFpdzV6TXcyNmJUbUtBR3JXQ0tsWXVua1k5?=
 =?utf-8?B?S2wyWUdjbDhhbjlieDl6Qi9WL0dkNVZVT1J1Q3llMFhZYVhhYXBQRlRxdkRI?=
 =?utf-8?B?RUZZSVVVdWk1MnpsajI4S3lSNjJlVWFDZUZ3dk1LQnFMc0xQYWZoVGdqcWJQ?=
 =?utf-8?B?cTY2U2FRTnJadWc1R2JidE5VTG9LTDZaSzNYdU1PWWk2ZkJwZS80VWpKQm1P?=
 =?utf-8?B?WXlBKzhtQ2M1MUZwN2hqQlN6LzZURityc2dzdU9TZGM5T1Y5Z2hxQ3BWNitm?=
 =?utf-8?B?eGtFRTI3dnd2cXZNNGp1ejRwUk5nY1VuKys4V1JGNk9ZTUprY3l1L3dLa0xu?=
 =?utf-8?B?L2ZhZk5Ldy9pMWNtMkNIUExQeE0xanN3ZTFGQllqeFExTWxPZzlsYUdLVGNV?=
 =?utf-8?B?UHk3bW1HK0ZxYXVKc2NiNDhnekZnMHAxWHRtaXQ0K1JmTGRpMjlOMXFoZWxP?=
 =?utf-8?B?NGYzZ2QzcjVtbHM1VVBvVTRXck9PTURha1pUNmpXSU9IeGthNnJLNWRIcWFo?=
 =?utf-8?B?b3AwQ1gxMFdqcTlzcTcwUjFJcUx0YzkwNlhGVUQrL1g4Wk4xQUtETHVmWk9H?=
 =?utf-8?B?LzIrZUdtYkhBTmJ1RXkvWDkxSkw5K0l4YUpuUmFGTENEWUJZZEIvN212bERK?=
 =?utf-8?B?T1NXSy9sRVN3WXZvSHE2VU1qT3BCSURSVTVOUnFjb3pMWTJQcWxQQVQ1ZjN1?=
 =?utf-8?B?VUlQWFQ2NXNCV1d3bjM4RXh0WE9vc3FXenBMZXBsYXU5cDRUOGtTYzVKaUsr?=
 =?utf-8?B?dUxNUG13alIycXA2bXJEaTlxU25LNWJvS2FiZlE5L0N3YldtNW5wUUgrck1L?=
 =?utf-8?B?OWRqOWgrbUwvdTY0Y0RQQWJ5QXRoUHZvcnhmZVdVb2owckJJUDdVVjZ4SWM0?=
 =?utf-8?B?c0k2MTZkODZDSXRNREZ3U3l3K0o4Ukk0QTR0RitwalZmaE8rLzBkY1JZby9k?=
 =?utf-8?B?dTBUUWg4VzVhWDFiRTJKdGQvTnI1MjR0Q2JFQjhlS0Q5bzJLZWN3SEdadnk0?=
 =?utf-8?B?NmVEVHlFTXVVUlNYcVZuRUhNc1BoVm1MMUVBVHVkYWZGTktrUVU5ZDFNVXlC?=
 =?utf-8?B?YklNT1dtZzZQanR3UEVvbFBQMkFNWmRhd1JmalZ2QXBRTW5LT252d2xrNmhl?=
 =?utf-8?B?b2JrTitWZHN1aVRpTldwN1dvblA3UUV3TStJVTUwL2NRR0EzbWhyZDdoZVI3?=
 =?utf-8?B?bzZwR0RYMGdkL0QyZHlraFhFaVpWd3l5NmpqVHo3dlhLWUJIT1N6YldFNHJ0?=
 =?utf-8?B?b3Y1enBQaFNoUDNDakhBNzUvQyszLzlUZWxVYnVjeHdyQ2RCc1Jpek4reWEx?=
 =?utf-8?B?Q3A3eStma21wbFVpczZOck1pcVBDQjJyakVGVjdSQUFucXlZVUI4WEhsUEpr?=
 =?utf-8?B?MGRMOEF1c2Z3RWh5VGZSL3kvT0ZHZnBjRjFJdEtGYW41YUtGVTN2bFNocUtD?=
 =?utf-8?B?ekNvay9jNDVIT3I5bTFIeTJHWEdhTjh0L0FXQ25JRWxMZHdZcmxMSmtuVkV6?=
 =?utf-8?B?LzhIdnVUMDVJMGZUcUd2dzIrVWNKYUdoMmZFOW5BVUI4emxYLy9TRmJ5SklL?=
 =?utf-8?B?SXhFd2d0dThRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUFWWGhiblFEVmVwYkJoZ01xb0wzTWowcDBYY1k0WWxQNno2SmhVdmxCOW9J?=
 =?utf-8?B?RzBIeEtkb2pMNnU1T3RFZVpLaTVabzM3NmtuOXNFdmFOMTdWcjdjOFp4SUpq?=
 =?utf-8?B?TE96dllOOUVFZlpGTnZtczNSZFVuWDNxVkFaMllpN0Z3aDFFSGVqN050MnNt?=
 =?utf-8?B?eEhxYi9VbmF3cmxGVHZHVWhWeGFHb1haME5QOTVsU1R1R0ZwcXp5SE54NVlq?=
 =?utf-8?B?SEJXNGUzc2xGMHB1N2JCQTBlaE0zQnBzUXhaTlVnWVFyKzRBdC9tSEYwL1pn?=
 =?utf-8?B?c3dtTWFTRDFIUGlIRVI3clVMRGdYdjVObXFjcE9tVWpTQXE1aC9PZy9takFw?=
 =?utf-8?B?Y2Rmb0pWZnpIejNlVDhQOU9IT3RmejV0ejIxcllCbUVtUWtRWlhQMHdIVjJR?=
 =?utf-8?B?T0tzTEVlWVFXOEQ2b3VlbC8zSE8rTHZLMGw2ZTZ2SUNJRUZrSklsak5Zek9Z?=
 =?utf-8?B?Nm5XSXdGQ250enZ0dlowMjRJY1hjck00cmRPOVRDK3E4b2hWeUtsd1FGNTQ2?=
 =?utf-8?B?TkI2c0E2TWFrbVV4VHYwUkZsVmFsbjhjZjlmQ2Urc2lFcjZXZWVNd1VFQTBr?=
 =?utf-8?B?TmJyOXc0bmhjTTNDQlhmY3hPNndtdFRJV3F1QVhTa2pGU0Z5bVN3alhLeXQr?=
 =?utf-8?B?eSs3SStodERhZVhvN2ZnN2JWQUxBenJnbExERVZ4aVA5RmhHOFJ3MDRmbDJT?=
 =?utf-8?B?T0gzdzFMSkFoMDBTd050Tis2aDh1MW51d0pPeitXL0R5VENyTEZEdi92Vnc5?=
 =?utf-8?B?N01Bd1pUTzE1cTFmWWxRZitGc2RBV29KQ3dwY0hHK0VJRXJjVWczZXB2bHdl?=
 =?utf-8?B?YUdialYxTzhCSEE1K1FZdWozaUdzTWVxVXI3ckx1Rk5wRDkzZ1BFWXYvR2Jq?=
 =?utf-8?B?VEtNSHBkUk83VldiU3FaOEpOanQ3UURUVlhvM3NBaFpFbmRjNXFVYnQ3ZXMw?=
 =?utf-8?B?TnI2cWVITllDWm15d3psQUZnNlFUc1U4azBoaTJVcVlmU3o4UEwzamc5cmZF?=
 =?utf-8?B?ejZjbzQzTFpBYmVTc282SmxWVXM4Q2NmZi82ZEM5VzhxT0tqb0ZDcFp6b1U1?=
 =?utf-8?B?Ri9VMklHZnUxSXgrSGRVTHR4dUFjb2lOaFJwK1E1bFlhR0Z1endTSTJBN3Fp?=
 =?utf-8?B?cjhXSVpBMSs0ejdWdDZIRm5QQ0Uvejl5UFpKcnluRktJUEM4MEhHTWdBd0hJ?=
 =?utf-8?B?UUZKeUlEUVdCc2JTODhKSFJzdC9KeXV4cG42ZTVSUTZ4VjdQY3NFUGR2RzY0?=
 =?utf-8?B?ZGh2SkM3c0hQRFJLdjZuY0huTnJSWUJDdDByQjNHQmpnb09Ba21YU2ZCZ2w1?=
 =?utf-8?B?K01GUGtkZHFVMVhXc3BhYzRvTGZpWHFJZmdEaFR1UnhFU1gxL2NVK2NUbHl5?=
 =?utf-8?B?aEIzZjI0VW53QXM4QnNvYVRyR0ZlNmxKR25GME9lYUd1TTlMaEY0NncyQU5h?=
 =?utf-8?B?TThjcVdSeG03bDZEK3RNLzlYeS96NFdLQlIzMU5zZ1hQVjllamZOZ3BnR1gz?=
 =?utf-8?B?Y1MvVW5wRWpOdU9TK2dtajVhYTdXaVpCRmM5MmJHVlIrb1N4a29UK2QrRzVh?=
 =?utf-8?B?L0tjdXVLZTF0cUFraytsSjM3UVZUdUZGR0VIVHVrZjhxNkI4RHpEbHZ3VG5B?=
 =?utf-8?B?YVZKbXNveWhBdVBvUUYyQThHNjMrNURZMXRTbnZDeTlmWldrdWtMOCtEUVRC?=
 =?utf-8?B?eFRTV2ppdnJZR0d2b051RXl0Zm9UVGV5Y08zbG1vL2NPV0Z0U1QrWlJRcUNy?=
 =?utf-8?B?aXlRemFndkMycWxMTWJNWmFEbmhYRXltZmFUR2Z5bitaRzBaTFlXZjdmRWtw?=
 =?utf-8?B?eDRzNzQ2L2NYZlR6RzNCVXBKb2NOVVE5Z04ya3BJTWFqMkZFU05TZDRkb3Nx?=
 =?utf-8?B?bFNJOVVteFVCenYvZFhBRlZIZWZycEZyRU9IVVR3QmZxTmxaN1A0ejJGZ013?=
 =?utf-8?B?ZkxIZEE3dEhaSVl3ZU82eDU2T1NZbCszeDB2bldERWVXZ0dza0NRaVRzZTkv?=
 =?utf-8?B?RU90Qm5FUEFxcm9Vd1dVWDIzUXo0TDB6STFGRVVicFB0dFM4SUJlcHRvRHBx?=
 =?utf-8?B?ZUt2M2lxemwwbWtKa2hrQnVlQ0NtR2hmZGdmRWZTS1J6Vk9MYldIOFhEb1FG?=
 =?utf-8?Q?DuW0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda33dfd-a156-4ebd-a47e-08ddd084f62f
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 22:52:44.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNknPQKthY+ALyApMh/dnjrrCC6TlEEljjZv3jhQCx2+7Gnr7RIXiifwWq51ch3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

Hi Reinette,

On 7/21/2025 6:40 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/10/25 10:16 AM, Babu Moger wrote:
>> "io_alloc" feature in resctrl enables direct insertion of data from I/O
>> devices into the cache.
>>
>> Introduce user interface to enable/disable io_alloc feature.
> 
> I think it is worth a mention *why* a user may want to disable this feature and
> why is not just always enabled. Here it can be highlighted that this feature
> may take resources (CLOSID) away from general (CPU) cache allocation and since
> this may be scarce enabling user to disable this feature supports different use cases.
> 

Sure.

>>
>> On AMD systems, io_alloc feature is backed by SDCIAE (L3 Smart Data Cache
>> Injection Allocation Enforcement). When enabled, SDCIAE directs all SDCI
>> lines to be placed into the L3 cache partitions specified by the register
>> corresponding to the highest CLOSID supported by the resource. With CDP
>> enabled, io_alloc routes I/O traffic using the highest CLOSID assigned to
>> the instruction cache (L3CODE).
> 
> This is a lot of architecture specific text for a resctrl fs patch  ... I think
> you are trying to motivate the resctrl fs implementation. Similar motivation
> as proposed for cover letter can be used here to help explain the implementation
> choices.

Updated the whole changelog.

fs/resctrl: Add user interface to enable/disable io_alloc feature

"io_alloc" feature in resctrl enables direct insertion of data from I/O
devices into the cache.

Introduce user interface to enable/disable io_alloc feature.

On AMD systems, when io_alloc is enabled, the highest CLOSID is reserved
exclusively for I/O allocation traffic and is no longer available for
general CPU cache allocation. This feature is disabled by default. Users
are encouraged to enable it only when running workloads that can benefit
from this functionality.

Since CLOSIDs are managed by resctrl fs, it is least invasive to make the
"io_alloc is supported by maximum supported CLOSID" part of the initial
resctrl fs support for io_alloc. Take care not to expose this use of
CLOSID for io_alloc to user space so that this is not required from other
architectures that may support io_alloc differently in the future.

Signed-off-by: Babu Moger <babu.moger@amd.com>

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst |   8 ++
>>   fs/resctrl/rdtgroup.c                 | 149 +++++++++++++++++++++++++-
>>   2 files changed, 156 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 354e6a00fa45..189c1ccb92d6 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -157,6 +157,14 @@ related to allocation:
>>   			"not supported":
>>   			      Support not available on the system.
>>   
>> +		The feature can be modified by writing to the interface, for example:
>> +
>> +		To enable:
>> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
>> +
>> +		To disable:
>> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
>> +
>>   		The underlying implementation may reduce resources available to
>>   		general (CPU) cache allocation. See architecture specific notes
>>   		below. Depending on usage requirements the feature can be enabled
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index d7c4417b4516..06c854caa55c 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -70,6 +70,7 @@ static struct seq_buf last_cmd_status;
>>   static char last_cmd_status_buf[512];
>>   
>>   static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>> +static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid);
>>   
>>   static void rdtgroup_destroy_root(void);
>>   
>> @@ -232,6 +233,16 @@ bool closid_allocated(unsigned int closid)
>>   	return !test_bit(closid, closid_free_map);
>>   }
>>   
>> +static bool resctrl_io_alloc_closid_alloc(u32 io_alloc_closid)
>> +{
>> +	return __test_and_clear_bit(io_alloc_closid, closid_free_map);
>> +}
>> +
>> +static void resctrl_io_alloc_closid_free(u32 io_alloc_closid)
>> +{
>> +	closid_free(io_alloc_closid);
>> +}
> 
> I do not think these should be helpers/wrappers with a separate
> namespace. It will make the code easier to understand if it is clear that
> the "io_alloc" CLOSID is allocated from the same "pool" as the CLOSID for
> control groups.
> 
> I would thus propose a specific, for example closid_alloc_fixed(u32 closid)
> helper, and just call closid_free() directly.
> 

Sure.

>> +
>>   /**
>>    * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>    * @closid: closid if the resource group
>> @@ -1030,6 +1041,16 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * resctrl_io_alloc_closid_supported() - io_alloc feature utilizes the
>> + * highest CLOSID value to direct I/O traffic. Ensure that io_alloc_closid
>> + * is in the supported range.
>> + */
>> +static bool resctrl_io_alloc_closid_supported(u32 io_alloc_closid)
> 
> Please move to ctrlmondata.c
> 

Sure.

>> +{
>> +	return io_alloc_closid < closids_supported();
>> +}
>> +
>>   /*
>>    * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
>>    * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
>> @@ -1858,6 +1879,131 @@ static int resctrl_io_alloc_show(struct kernfs_open_file *of,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Initialize io_alloc CLOSID cache resource CBM with all usable (shared
>> + * and unused) cache portions.
>> + */
>> +static int resctrl_io_alloc_init_cat(struct rdt_resource *r,
> 
> Mixing two features (io_alloc and CAT) in the function name is confusing.
> How about resctrl_io_alloc_init_cbm() and move to ctrlmondata.c?

Yes.

> 
>> +				     struct resctrl_schema *s, u32 closid)
> 
> No need to provide resource as parameter, it can be determined from schema.

Sure.

> 
>> +{
>> +	int ret;
>> +
>> +	rdt_staged_configs_clear();
>> +
>> +	ret = rdtgroup_init_cat(s, closid);
>> +	if (ret < 0)
>> +		goto out;
> 
> More below, but I think this flow can be simplified by moving the logic
> handling CDP here. If CDP is enabled for the resource then a successful
> rdtgroup_init_cat() can just be followed by a snippet that copies the
> staged config of the CDP type to the staged config of its peer type.
> Their CBMs are supposed to be identical so there is no reason for all the
> rdtgroup_init_cat() processing to be repeated. resctrl_arch_update_domains()
> can handle updating both in a single call.

Yes.

> 
>> +
>> +	ret = resctrl_arch_update_domains(r, closid);
>> +
>> +out:
>> +	rdt_staged_configs_clear();
>> +	return ret;
>> +}
>> +
>> +static const char *rdtgroup_name_by_closid(int closid)
> 
> This seems generic enough and appropriate for rdtgroup.c
> 
>> +{
>> +	struct rdtgroup *rdtgrp;
>> +
>> +	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
>> +		if (rdtgrp->closid == closid)
>> +			return rdt_kn_name(rdtgrp->kn);
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct resctrl_schema *resctrl_get_schema(enum resctrl_conf_type type)
> 
> This also seems generic enough and appropriate for rdtgroup.c
> 
>> +{
>> +	struct resctrl_schema *schema;
>> +
>> +	list_for_each_entry(schema, &resctrl_schema_all, list) {
>> +		if (schema->conf_type == type)
>> +			return schema;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
>> +				      size_t nbytes, loff_t off)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	enum resctrl_conf_type peer_type;
>> +	struct rdt_resource *r = s->res;
>> +	struct resctrl_schema *peer_s;
>> +	char const *grp_name;
>> +	u32 io_alloc_closid;
>> +	bool enable;
>> +	int ret;
>> +
>> +	ret = kstrtobool(buf, &enable);
>> +	if (ret)
>> +		return ret;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	io_alloc_closid = resctrl_io_alloc_closid(r);
>> +	if (!resctrl_io_alloc_closid_supported(io_alloc_closid)) {
>> +		rdt_last_cmd_printf("io_alloc CLOSID (ctrl_hw_id) %d is not available\n",
>> +				    io_alloc_closid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* If the feature is already up to date, no action is needed. */
>> +	if (resctrl_arch_get_io_alloc_enabled(r) == enable)
>> +		goto out_unlock;
>> +
>> +	if (enable) {
>> +		if (!resctrl_io_alloc_closid_alloc(io_alloc_closid)) {
>> +			grp_name = rdtgroup_name_by_closid(io_alloc_closid);
>> +			WARN_ON_ONCE(!grp_name);
>> +			rdt_last_cmd_printf("CLOSID (ctrl_hw_id) %d for io_alloc is used by %s group\n",
>> +					    io_alloc_closid, grp_name ? grp_name : "another");
>> +			ret = -ENOSPC;
>> +			goto out_unlock;
>> +		}
>> +
>> +		/* Initialize schema for both CDP_DATA and CDP_CODE when CDP is enabled */
>> +		if (resctrl_arch_get_cdp_enabled(r->rid)) {
> 
> I think this block can be removed to simplify the flow by moving the CDP handling to
> resctrl_io_alloc_init_cat().

Sure. Also moved the whole function to fs/resctrl/ctrlmondata.c.

> 
>> +			peer_type = resctrl_peer_type(s->conf_type);
>> +			peer_s = resctrl_get_schema(peer_type);
>> +			if (peer_s)
>> +				ret = resctrl_io_alloc_init_cat(r, peer_s, io_alloc_closid);
>> +		}
>> +
>> +		if (!ret)
>> +			ret = resctrl_io_alloc_init_cat(r, s, io_alloc_closid);
>> +
>> +		if (ret) {
>> +			rdt_last_cmd_puts("Failed to initialize io_alloc allocations\n");
>> +			resctrl_io_alloc_closid_free(io_alloc_closid);
>> +			goto out_unlock;
>> +		}
>> +
>> +	} else {
>> +		resctrl_io_alloc_closid_free(io_alloc_closid);
>> +	}
>> +
>> +	ret = resctrl_arch_io_alloc_enable(r, enable);
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
>> @@ -1950,9 +2096,10 @@ static struct rftype res_common_files[] = {
>>   	},
>>   	{
>>   		.name		= "io_alloc",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>   		.kf_ops		= &rdtgroup_kf_single_ops,
>>   		.seq_show	= resctrl_io_alloc_show,
>> +		.write          = resctrl_io_alloc_write,
>>   	},
>>   	{
>>   		.name		= "max_threshold_occupancy",
> 
> Reinette
> 

Thanks
Babu

