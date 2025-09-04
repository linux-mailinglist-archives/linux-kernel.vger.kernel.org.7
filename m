Return-Path: <linux-kernel+bounces-801406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DBB444A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0039E3A64ED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B193128CC;
	Thu,  4 Sep 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iZheaJpi"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2103.outbound.protection.outlook.com [40.107.220.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AD2459CD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008086; cv=fail; b=RrMM242gAh4WqHWgzpxMj5sV1K+PllxG6JvQKQ2IsuBuYnAstqxcWjXpwOTIHxlyJWED77IP+zJBZ1XV9RL7Hw+aT1pVwxzXQlJPOe8MsLrz6N4j1RmorLszlHWYio18w+5+HTwpD8Y/XECuiUO3zW5P1qETHyN5qSmzwGH8aY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008086; c=relaxed/simple;
	bh=IK2NVgY5/3GIopYuYj7w/RjtTo0GEJFGI1kd/VYl94I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMMsap6Qw4wlAw+RfBxDBNmnPcXYRiD/OmbbDDYQs4IBxnxEEdFOOdsxMSCkgRlMeqU1HHfYeqpG7a/kVbZHPQ6V2nOQpHz6ojEua0buGo78og/LUEAEyBfKpC6fNn0TAmwDgksgVgsmQIcbXCFvx/MiuCQc2scXBdvAMnNgp2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iZheaJpi; arc=fail smtp.client-ip=40.107.220.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw3kWsWry97bvXQwE99rWNEchRdf1aohYaKVotMIKLUDjT1vu2YNxukObx/TPhLGOxwwRY72OEbK5DbnD7q1UT22Ci/kBDSqt0cVSQg/H2Ou9Qfr/+fXkaceWo067N2BjugZcrrvG6EkSnAYLrxRUI285LEdzwpIbL706AOtiH0qY+ZwhJl1NOL2DfbYROAquW5bmZm/HAWavyGj7uS6rfgrbhcCtcN1ZQxtKyvOdke31LVmUN4/CywneR5rSeK3+UavTNJzOWrJNZQE4XjNTtZ5oAOgL0k0tMS0XJK3KYMu0Goo/JbnHzP3OxTuCDjqBWTL8fV1izs0HkGzfLit3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxnDZbOi8nvPl9oBI754SV/7S8VFLHNtyDFqCZS3cyw=;
 b=vJ2JdjkqsGM1UAccJNMY0MTPGRTt6bLER4+eYJ38IQv0IButM5gNu/gY88DgjWTYBPs0KfA6ZyHiqeQMEN/H+EtmQcEk7MvKMSME3dl294AC61bXsLKT/0iTcD0bZLyoukDmP0URGiThnkH0Xnws3UKEyuVAuoOmiual5+Er+75arG81VzmQKOAGyEbW34Me7wjLO14+6gHoiYVptY/XoB8kkjP/zf4hpr/v5ldfWuk2vn00FecymNFGpDZWALnRnc7qAI/bUPaOI+Fy4uh7KK2sFzrcI941/KzPtRc9F6igy7iqo5TisBA109xSAqKLeWTeqoNhTWbI6Fcp5e2hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxnDZbOi8nvPl9oBI754SV/7S8VFLHNtyDFqCZS3cyw=;
 b=iZheaJpiiZIRrL8g/AksTiIyfy0I3fhWKkAe9jcz5usuAbXLj2zLRII5pY5WzJVl6Johs/2mVSQNmKFNfncZioya2WpFj3xfkuZmC9ygZzWYWWhj5GtdmNvkOUWQ2S93vRsjzdNOF97Dxb8owKJXUPJRsPtbhkwd96XYXVa8Hy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8309.prod.exchangelabs.com (2603:10b6:930:c5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 17:48:01 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:48:01 +0000
Message-ID: <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
Date: Thu, 4 Sep 2025 10:47:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
 <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
 <1471ea27-386d-4950-8eaa-8af7acf3c34a@arm.com>
 <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <f8cf1823-1ee9-4935-9293-86f58a9e2224@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:930:48::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 628bf72f-2d51-4b3d-5abb-08ddebdb30d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2cwbDhmV2tBU2JIaWg0U3BOY0pzd3dZZERxWVZVUnc2cGZURGxYRnRiQWVI?=
 =?utf-8?B?YldFaGxZTWRKMnpFV2d5eCtkMVUxT2o3TFBMVXVBdnlKcGQ3V1FCRHl3aU9Y?=
 =?utf-8?B?UnhoOXhkTTkwZUJpWG53bktteWx4VkdJeDJDdVpOaGg4VWJJTktVeUl5VUNz?=
 =?utf-8?B?VTN1Zk1sMjQxQUhxTTNaZEFMQktXTWVBZUlJOVRXb2FlM0l5dmp4VGZQaWhI?=
 =?utf-8?B?aVdZQXpCSlpGYVI4MlNiVnRDa1RMWkRQUHBBNEQ2ZitqN0wzUlJ1WmJmcTI3?=
 =?utf-8?B?VkttbXlFUENRZXVkc2FobG5hTmNkUnp3NnFlUGtJS1ZVS3Z1TlhuUHlWUjZP?=
 =?utf-8?B?ckFHNk1EMTVWdFZPSXk5QW5kNFN6OTJtMStpT0Y2WUo5ZVVmdlh0OGhBY1ZW?=
 =?utf-8?B?anlQVnpoVmtYc2s4aWpIS3MvTVJ2bDNGbURwamlhQzhkeG5pSFYyT2RIM2RZ?=
 =?utf-8?B?dkVQR2phTW1nMXE3NEd5ditWK2kyak5pT05mT2ZMNnorWGtoUm4yNjRXR2pZ?=
 =?utf-8?B?ellJcHV0NzJTQ3dMYnpkckFqclRndnRjcXppNVdrZk55UlVlNEZtd3lyMUpT?=
 =?utf-8?B?ZkVmQ3FQVVJRMlAyRkhzWkNiSXlwUCtka2xnVUR4dExOd2RJT0dkSForbDNI?=
 =?utf-8?B?ZGZmMVRKc2dwNGttb3RjQUNhVlZ3cW0vRjBIWXprZXZQSjQvLzA3MTZaaEJt?=
 =?utf-8?B?cy9hN1NwT2tFTlRTWkxXT1JET3lkQWhsSjJ0RDdoUXpLZHJOajNUd1IrYURh?=
 =?utf-8?B?T3VOUnNqZURxdCs0SWcvMTF5c0hueFNRNXl1MHhtcDFMQzJLeUxvT25WYlVx?=
 =?utf-8?B?dkhjRGZVQm9qb3BlN1kyQzZaQW9BemE3WFlZTWx4VEhsbURMVkIvWTA3VG9s?=
 =?utf-8?B?eU5renNSQTdTZlRpY0tlbkZaSVk0eGV0dC84aEtqa09qdWJVN3lRZDNuNzZ2?=
 =?utf-8?B?RlNySm5SRE5JRy9tY01WRzlrSXpReDBVbXdla0JxZlc3aFd5QWhzYzNHbzk1?=
 =?utf-8?B?SVJsUDh4RGFoVzFHc0dxeEx4ek1ySExhOWdUNHpyU1hHZGVKRmhGQWRab1dx?=
 =?utf-8?B?RWg4ZlZYUUQxRzQ3NFVsaEtRbzIwZlV3cjRudUFoaDE0SjFnZnNxMWN6eC9y?=
 =?utf-8?B?UkszNWg0SDgrcnNxZVI1V1YyTUh6aGYyQ0huZGNjODdzNWhxUTZVbzhuUnQr?=
 =?utf-8?B?aFkyMVgxUXMvVjZUYkowNTFZcXlDN29qN3JtWlJWNlZ6Zm0rTWFHM1FSZ0w4?=
 =?utf-8?B?aktkb0ljRWRsQnBadU1ZenR1NUNuaGt4YkNMQUVhdng5dURsZWJzcFZtSE1F?=
 =?utf-8?B?QUdLcVRYS1duMkhoUlJkV0lGTTRsYVRYZVJKOUpqTi9rWUVwQ2plQnF1ZFRu?=
 =?utf-8?B?eG05dUw0L3VMS1BjMWpqRlRZT29keVI3cm5XQ3NvR0JwdlZkdUpVSjEzdndv?=
 =?utf-8?B?UmJOakx1SHgwS2ZtZTBIS1VoOVBxb1E5a0NxK0pOOUFhcjMrTTF6SU5tOU1X?=
 =?utf-8?B?YXJoVW5KZzM1RmUvLzNVUGFwbTVqQUxRanlkZ2dhUUd4K05PVE1VVWcvV2RJ?=
 =?utf-8?B?RDRkcVBmYzZ0THRlYllUUDZHTjdwRUFIQ3ZXRnF1OTQ0cjgxcjdsdDVZRXg0?=
 =?utf-8?B?U01wUVdnVFUvalltb0tTcDRZZmd0Y2NTZVg2anlxYmFTdnFJOTNaSkI0S2Iw?=
 =?utf-8?B?WmJobzBTOS9LSmI5NUJWWmRMZlVINXpoeklZQkJNNm5IMlN2SkhaZnhnSUZV?=
 =?utf-8?B?Q0pxcUNLdVVZcHl6Ujd6RzIxUXcyeWFCbW4rYmhKVWw3OFppbDA4Yy9LSG1V?=
 =?utf-8?B?em1tUmZUQmJ0V0dlbWN4dmV6UlVqTlU1Z0lCYmt4ektVM2NIdXJQT0xxcmZI?=
 =?utf-8?B?eit1dGpMWXQwVmFtdXRRdXg4dHpsOGhramNHSmtNdWFkT05qYUhncGd6MEhO?=
 =?utf-8?B?cFFPeXFWcFRkU2Y0RXJTb2l5cGFpQ0EyK2h0TWY0UmNaZHM2VnovUU5UVU9X?=
 =?utf-8?B?YllZejZueElRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjlpR3RTT2tPbjFMUnVWVmIwNkZwTTlJcHd0bmhkTmlGVStQakxVMzJtSWZI?=
 =?utf-8?B?QjQ2b2w0eER5UHhlSnBNZU9kN0lobjAyZGdIdHh0OWx1TUNFR2ZVTkNBQ1JH?=
 =?utf-8?B?cEUxemhiZjA5UmxSWXcvdlJaVll1RmVLckJDcGZxVXVZU3UyaWhXTUZIVVJ0?=
 =?utf-8?B?SmY0MkdpK0QrV2RnSFJpVC9FRW5pb2g5eFREbUE5VDJaMXpQU0Z1cEVDODgx?=
 =?utf-8?B?bnhIK2dJc053elUyZ0FleUQyR2k2NHZVN0g1aVNuelNQRkVjaVBBbEx5YWdh?=
 =?utf-8?B?THVhejc4R3M5Q2FOeThKRFZNMHk3dlZZNVh5czFiVUpncVo3Tkc2aWhiakdR?=
 =?utf-8?B?bTRoaXU5OWlRUHlUR2gxa1RSUzYrREtJUTNib1ZiVHdMbzdwMHQ0anpnbXFT?=
 =?utf-8?B?cHdHVk5EclRGNkpyREdWNjV6VGRPZWpJU0hYUnhEdEliTkwwSFFQRktqNWc5?=
 =?utf-8?B?c3MvY2pxSlJQellhTlB0THJpVlVwelVqZE0zbmpzNWZsQWdzVDJhUi9uKzBj?=
 =?utf-8?B?MHR4V2dGdkppOXErMy9MNzFTbDdTZUliLzV6M2I1NDRtL1JQU3B5TGx1Q2Vs?=
 =?utf-8?B?aVRKS2xsVnhObUd5czEvNm9ib0RKVjZ0eTBYZnl6c3FvMlFRbXpkeDYwWTBW?=
 =?utf-8?B?eG1rRFgvNmxMTHBSYVR5WGZKeEdyc0tpY0p3SDl5MzhqeEt5bmtOMVBqa2ll?=
 =?utf-8?B?TzBrQVVwa2NQQ0V5WG5BR2ZUMlNacjkrZmd3Q0w4RkRlM3lOSkdUSG1INW92?=
 =?utf-8?B?L3VXV1hLc2NVcUFjL2ZjeWU1YkMwSlJwSnBWbUcxYnZ3NHFpd1E0MlJvb09T?=
 =?utf-8?B?NEdMeXJUeDJTKy95Ty93WDNDbmpqcjZ1VTJLc0FHMDFQcmpFSVBmTjFjbnlS?=
 =?utf-8?B?bllhcjRHWFVHWkMxMXFXcW5qaWNVbHo3MmZzVEtrSjdqeG9Rbjk4eFkyQzNK?=
 =?utf-8?B?VnNLckdjdERhaXB0WVJ0Q1lndklHMncyUnFzdmRDRytlTmlFbk9vNHo0UnpY?=
 =?utf-8?B?WFRCbUlUcnMyWmFUMkpzdU96bGhVckdGaHQyZzI1TU1uM1dJUlZKWjUvNCs3?=
 =?utf-8?B?Y294b1lFQ2ZqRWZ1ZzROWjZVR1Y4RWdzWnVVL3hHY1ZBSWk4SVFieDEvMGpE?=
 =?utf-8?B?eVZNak5FL0JRSWxCQzhFQ29JdENHSVRhK3NDK1hVV1B2SnhTbzUxTURPZDVr?=
 =?utf-8?B?Mm41a2JTWEtXeE1oRmF1T0NsemFKTXBVS0NZbTNqeHNVOUhxUVJoZm0vOEVj?=
 =?utf-8?B?d0k5OXozZGo4Q2Ird1lPT2RmY0gzVjdMZ2t2eS9EWGdqcjM5cERFa3FMUWRV?=
 =?utf-8?B?S0tKT2JXNEw2UUFtY3hPblM2Y1FjQ3RHSHBtYk9LODlneFJoekhlTmc2MXBX?=
 =?utf-8?B?dVBGQldXc0kvWENsajY2TE84T0tiUkpPRWRQYWkwbkNTcDdOSlgvdEJhQ0tD?=
 =?utf-8?B?M2FwSEhrSC8xVTdqeVJNOHhFKzZUQUNYZkJlRVgraWhhT0loU3YzU052aGNX?=
 =?utf-8?B?ejB1aktyM001cis1UUhPRmt5amVxWXlObEVITkdNTElEckdRZFcyNEFiOHRv?=
 =?utf-8?B?Y0IvRzh3eEJxUDlwM0xBb0RSTENNOUpTeDNlbTFZZ0drYlZqZXNFYXBIeHZ0?=
 =?utf-8?B?b2d5cWMzandmenUxZWwxaUNYaG14YnhPQ056bGRzY21ON2grUWRVa3c5ZnRs?=
 =?utf-8?B?Z3V0bU9LM1ZkWmN0aS9nclZ0Vnh2UzR4QXFjWm1SYzJON3M4NmthRXZKVmFy?=
 =?utf-8?B?eHBUNmU3QXpBVkp5ZzBGRTZmN3pBV3VjckZjSWF2d0lQaWliZXFLRGtWVkNl?=
 =?utf-8?B?ZEVlcFlQdzljNUpWSndMVkVoWEc3WGM2NGNQTUw0aW93R1ZBMjg1Q253VEx0?=
 =?utf-8?B?NzZvSWVhL051VVk2QkdaTU5FdU9xVmlnSlQvNzJocjd5NlJEOEIzeXplYVRZ?=
 =?utf-8?B?NzZoY0tnbW01SktEem0ybnE1L2tibjVrUFZlajV4TEpEcW9MMUxTenp0S1RK?=
 =?utf-8?B?SzdIQkx0d0NER3ZqM2ZGci9tRzM4ejMxWmsrdkh1S0lHVXZEZHRTcjZ2OXBU?=
 =?utf-8?B?ZnMwSFg4SUVpVldubkFuWSthY0VtNU9HZThaNzRHK3ZlMzU1aGVaeTlOTXhy?=
 =?utf-8?B?dFh0M3lOWUNHZHR1K2h4OTNoSVMybnNiZVZSMUR3NXdEUTJ5Q3p3YXRhWEpM?=
 =?utf-8?Q?/IUdKyP0odi8tRfKfq6HrCA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628bf72f-2d51-4b3d-5abb-08ddebdb30d7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:48:00.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhiXYM8YuVzgDeh9KXI0QDtUvVRYX93nzHobYjI11SGxSUbaKS01XyccBpgof/ytGTFYZSl7tIJw+q69Lwc4f8QEfpcp7r2Ia177XVC+QmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8309



On 9/4/25 6:16 AM, Ryan Roberts wrote:
> On 04/09/2025 14:14, Ryan Roberts wrote:
>> On 03/09/2025 01:50, Yang Shi wrote:
>>>>>>
>>>>>> I am wondering whether we can just have a warn_on_once or something for the
>>>>>> case
>>>>>> when we fail to allocate a pagetable page. Or, Ryan had
>>>>>> suggested in an off-the-list conversation that we can maintain a cache of PTE
>>>>>> tables for every PMD block mapping, which will give us
>>>>>> the same memory consumption as we do today, but not sure if this is worth it.
>>>>>> x86 can already handle splitting but due to the callchains
>>>>>> I have described above, it has the same problem, and the code has been working
>>>>>> for years :)
>>>>> I think it's preferable to avoid having to keep a cache of pgtable memory if we
>>>>> can...
>>>> Yes, I agree. We simply don't know how many pages we need to cache, and it
>>>> still can't guarantee 100% allocation success.
>>> This is wrong... We can know how many pages will be needed for splitting linear
>>> mapping to PTEs for the worst case once linear mapping is finalized. But it may
>>> require a few hundred megabytes memory to guarantee allocation success. I don't
>>> think it is worth for such rare corner case.
>> Indeed, we know exactly how much memory we need for pgtables to map the linear
>> map by pte - that's exactly what we are doing today. So we _could_ keep a cache.
>> We would still get the benefit of improved performance but we would lose the
>> benefit of reduced memory.
>>
>> I think we need to solve the vm_reset_perms() problem somehow, before we can
>> enable this.
> Sorry I realise this was not very clear... I am saying I think we need to fix it
> somehow. A cache would likely work. But I'd prefer to avoid it if we can find a
> better solution.

Took a deeper look at vm_reset_perms(). It was introduced by commit 
868b104d7379 ("mm/vmalloc: Add flag for freeing of special 
permsissions"). The VM_FLUSH_RESET_PERMS flag is supposed to be set if 
the vmalloc memory is RO and/or ROX. So set_memory_ro() or 
set_memory_rox() is supposed to follow up vmalloc(). So the page table 
should be already split before reaching vfree(). I think this why 
vm_reset_perms() doesn't not check return value.

I scrutinized all the callsites with VM_FLUSH_RESET_PERMS flag set. The 
most of them has set_memory_ro() or set_memory_rox() followed. But there 
are 3 places I don't see set_memory_ro()/set_memory_rox() is called.

1. BPF trampoline allocation. The BPF trampoline calls 
arch_protect_bpf_trampoline(). The generic implementation does call 
set_memory_rox(). But the x86 and arm64 implementation just simply 
return 0. For x86, it is because execmem cache is used and it does call 
set_memory_rox(). ARM64 doesn't need to split page table before this 
series, so it should never fail. I think we just need to use the generic 
implementation (remove arm64 implementation) if this series is merged.

2. BPF dispatcher. It calls execmem_alloc which has VM_FLUSH_RESET_PERMS 
set. But it is used for rw allocation, so VM_FLUSH_RESET_PERMS should be 
unnecessary IIUC. So it doesn't matter even though vm_reset_perms() fails.

3. kprobe. S390's alloc_insn_page() does call set_memory_rox(), x86 also 
called set_memory_rox() before switching to execmem cache. The execmem 
cache calls set_memory_rox(). I don't know why ARM64 doesn't call it.

So I think we just need to fix #1 and #3 per the above analysis. If this 
analysis look correct to you guys, I will prepare two patches to fix them.

Thanks,
Yang

>
>
>> Thanks,
>> Ryan
>>
>>> Thanks,
>>> Yang
>>>
>>>> Thanks,
>>>> Yang
>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>>>


