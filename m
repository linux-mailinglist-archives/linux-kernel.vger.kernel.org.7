Return-Path: <linux-kernel+bounces-890400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C03C3FF79
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC3A934FB80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E572604;
	Fri,  7 Nov 2025 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k2GSLVS3"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EF38D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519588; cv=fail; b=Ufam5xwyzk1vanysNJkNcRexbP/hFqBh4SAn51O9XJdNnSKJh8ODmIXBgprlKRTQwBbZt2UG8oubTsINAG1I7YtKiIuRlohnnsdaSVGOvK3eHVfLZ+Wu88UF3J/qGUwU7fe6ot+WjCnOsAZjCGIOrsHOiAJM+Xypr27NEb7JFw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519588; c=relaxed/simple;
	bh=BIa1hFN1WB6DOjBcrQaQV+SuqRNQ6h0kots9RIsmDu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvX2PdhnTqNdLxbt/jOL0fi4neIIEZncx5p6NOLXtjUUVUUGLOSfyU09M7g7uO0vSfDuDrgIsCx4lVX++hyYR+un4uLPBVVS9ZHWT4GVLbCHmVZYCDdDy+rp074YKnaLlAQlRqYVa+bK92qClEdj39y00p9szHiLGzzUgMYQ5Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k2GSLVS3; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8pqYWxcR1l7ucUWNx7e7ciZS4/fzY0CJnEDUnue/SJ6u/9YJ8Ymf6HcsBeGuLwZhO5S4qHkpqthwg3D40HzRDgqkl2Ag1PoJj7iVTGaRKxZiwM94/jiym/4JfqedW54pLhtAN80F5/xI4vV5yrq8MY4yOMb9KGOroQ11/Pl0JHC4Dx2AoNNKWoN9GhZUNpmpUTYXEi2B59GcX70DleaHExUQ0SbiuwvbeV4FWYlXw+W+V3U/gp9RXFx1+HbzPktYgeGZQYCVlI/mHHy7KzIgujYM9UwL3nZj49VYs7ok9qyPx+sKHadWA87f9Dw5etT8SR58EfN4lI2ZWlgnA0IeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW62RRPvK87QbAkHr9ZdIHiBheUDoS8DShKuI8lBKv0=;
 b=oJ1ep4StXYfKRvXtdqYPysgw1iyVF4IZ4tP53vHwVtfMZJsKXetwDH4AEZHpDyARuwFYpuG0tSiS/72+qCan2s7psdHH8tWImG2IHhpfJBe17XwKStw/suz6a2M45BUjD5tNsqeDNh6VSY+zhlUYRGIf/PGBczXcm2ZxJALUUd/0SufYD5cXnUB0dQtEuF9USvGRSl33Hl0pZbbvFwIlCAEz+GVCDPYYo5mm0AM/cYj3d2nu/fornm4+DG+El64BSWAxg3Oz1+uyfxlb469F2y5oQzwrNG4N02OAA7VCx8Z5thZvBQ1S64IvYoijm9Xx420hcsdgsArx7O8huXz5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW62RRPvK87QbAkHr9ZdIHiBheUDoS8DShKuI8lBKv0=;
 b=k2GSLVS3LDE0Aw3jJcMM01/KnNDcy5pMbxZCAqfWXgWRgiHZWyDiSmz97WsJHDIEvNo+d8Uv/o3HpHsH0AK1pyP5vqJ5P2TGUWUdWdBp14CDcsiS1Nc9gK5GUOs4sNbkbPOFHx9hvQhUlZL6uCQ1uf4xOETepg+ojtqjjzV/Sd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 12:46:21 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 12:46:21 +0000
Message-ID: <a41b57f6-08d6-4af0-8383-7ba3b90c1acb@amd.com>
Date: Fri, 7 Nov 2025 18:16:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: madvise(MADV_COLLAPSE) fails with EINVAL on dirty file-backed
 text pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, zokeefe@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <4e26fe5e-7374-467c-a333-9dd48f85d7cc@amd.com>
 <8bc796e2-f652-4c12-a347-7b778ae7f899@arm.com>
 <ozkb6mcxuymlz7tm4vcnqf266gd4ruiik2zal2koo5ffprgxfk@35godtyix2cf>
 <43a8c8a6-388b-4c73-9a62-ee57dfb9ba5a@lucifer.local>
 <77a54f63-f5da-42a2-b24d-5c8a0f41d1e6@gmail.com>
 <0b84865c-5b23-4be6-9902-af9d5e63c182@amd.com>
 <0e616478-96d4-41e9-b6c1-fa641c36fba3@gmail.com>
 <671d07a0-0041-4825-9e6e-978907cb4d29@lucifer.local>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <671d07a0-0041-4825-9e6e-978907cb4d29@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::51) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: db69a937-237f-4915-b69e-08de1dfba722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjExcDNBS0dnR1NScndVdUpQMUdKVzFsQU90S1BwSWVkZGVrODBCemRodFcr?=
 =?utf-8?B?RkQxTGd4cUlWMU4wSzdGMUtyNGx6eTI3cEFLSGtPc3FxZWZzRHVrV000dE1t?=
 =?utf-8?B?NXNNMjZZY3lkMlRzQS9UZFVXQUNseFFRaXY1Z3JCL2hwUXFWazZGcUpkbmg2?=
 =?utf-8?B?T09VVE5BbVJYVHdWZVltZHJ1ZmRudGw4SW1UQmlsT2ZVcnRVeEFKTWdZSEND?=
 =?utf-8?B?STRwNzRiZnNaT2dMSkVyR0l4VmsxYTZOQjh4UFpYeTljOCtqTjdxbVdoK1A0?=
 =?utf-8?B?K0pmc3J5UERNb0w2ZmhTZGtOWHVQdVpFNko5NHJZSktZNXNvQ3RZQkVpUW43?=
 =?utf-8?B?dFVRRHpRZDEyY1Zpa1VBTXdyUEFZY1JXYmJjcTN1dTA4a04xTkRmQ3dQV2Nl?=
 =?utf-8?B?V015dUhyZzhOZGFIVG9XM1RqbndzSUROTFRqR3ZLbS9WRVVRK2VpWEJRU0g4?=
 =?utf-8?B?S0JKTHc5d2hjVGFMVDhJZHlzeXhMOFJjc0gzYVBWbjUrU3hmWE9UNUF1bDBN?=
 =?utf-8?B?OW9aTXZ2UWdmaVEvM2FjRjkyUGJmeWN1dG4zUk5PajM2eVZ5b012dGdPNnhV?=
 =?utf-8?B?VFUyakRiNjlvNjg5ZzRUMmNFOG9iY1UyRi9CQ2ZjQzhCa3ZJdE82bC8reWdE?=
 =?utf-8?B?MUxkSVBwZ3MvcklzRjIyT3dLUTdzR09kUXdsekdwS1ZjQkRid1IxSS8yV3FX?=
 =?utf-8?B?V21NR0t2MlFEK2RRL2NoTXE3ZFlJNFBOcHNqZUovV1dRVkEzN3F4ZVJXTXVU?=
 =?utf-8?B?akdIc3NTZ3k0RDZZRmwyK1dEb2V0amE2WlVtL0p1cHByb3ZZU09LMVp2cHU3?=
 =?utf-8?B?OXJaTmRRUGo4dm53Unk1OHJ6emNHZFpLRzVBWXNQK0lZckM1bnBJTTdpRkpr?=
 =?utf-8?B?SUJ4MksvTjdaM05qdTVzTGp4eDlqd05vdWZuc0V3MXpNNUNUK0Q1Q2tVWXcv?=
 =?utf-8?B?ZzE4TFJPZDNNdW5rdU91ZHNRVDhWWk41dzNJUU0xelFwMnJtdndwemVlM1h0?=
 =?utf-8?B?SkFwRXZxR0FOa0RBWHJRN1JYbjRSMVlwSitmWmhTVzNjOHdQZ3hUVWpJYkI3?=
 =?utf-8?B?c2p0WXl5M0pVejdyYXlTd01HOS9tTU5mcHNPckJ0RDF6WFVvWER3YnFiOXBF?=
 =?utf-8?B?Q04wMEpqMWoyd3EvcUdwWVpUenp6UG14QlBUd0xIdVZFR3MyWmpaUjZIemRC?=
 =?utf-8?B?b3BnY2x2NjZoVlp2ZkZjSmE1WWVCSkRBVFlWK0lKM3dSL09yWldNVmQ4TlNh?=
 =?utf-8?B?WGJoVGZYa0EvQ1NDeDMyS3ArU2FwcnNRMERVRVFjTU5US2FyekxyMTUzS25P?=
 =?utf-8?B?ZDJxMlkwek1oL01LRnZYakFidVRFK1prOTRlalNNZEZkYkd6SmJqWTFwYXRC?=
 =?utf-8?B?QWNoaWpVcjNPbVNEWGtwOEtYWkdRVHppdEMwN2FkRE9NNFU3aEJpZnE4bU9i?=
 =?utf-8?B?dGZrZUx3czFrQ0RKbnRnblRITjBURHpYSFB3ZjNKV2FVWGN4Kzh0RXZMRER6?=
 =?utf-8?B?WGNjMmZCdzVkZlB5amxha2pBdlNXTDlYeEdyRGlSMXFHZ3dCN0NGcUdwTnRT?=
 =?utf-8?B?Rndla0thTmFtLzl5NVJoTGp2MXFrd0lnZy9OZ3I3ZUo4S2NLWXF3S3VKTmMv?=
 =?utf-8?B?WWV3QnVjQm9QcXVEV04xaEoyMXZtZDQ3ejVNNUMvL3FQcThnalY1c0wydm1k?=
 =?utf-8?B?MXg4Mkp4VXhVeFU5WHRFejdMQ3I0QVh3WUVDRmY0YW5nMXVqZjdna1MrQVZt?=
 =?utf-8?B?V2c0eVZqVStpZ1NxbW5ZSXJITFhxbEpvSFdqSHVMTGNMRDlROUQvRnl5NjJz?=
 =?utf-8?B?YnZiZzlWRVhRQkpsdVZuSXZIWVduQUNxcmZObzJDVFk2cWZuVFI3VDBaaUtT?=
 =?utf-8?B?eHNleGVIYi9OZ1dhQU1zU3BVTkhGdzRpTEw4MDVGdlgvRjJqL1ZJNzNwOW1R?=
 =?utf-8?Q?kVN78WVxEZKMGnSgl3brwOlyXJ66xOPM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZENYWlArMi84Y2ZiWDdGajB0SE9lODF6N2NPbkVTRkRRTXJVRGd0VjY2ZTB3?=
 =?utf-8?B?SnNGYUR6b2VUU0M5WVBEVzk4amltUU5NbmMxWW9zSVpIS1J5U0dTVzR0MjZL?=
 =?utf-8?B?VnRvemlEQzRySnFZak5LRkZzdmx3ZnBtdnFuckFJRHljMWtpVUVLL1p1RFZY?=
 =?utf-8?B?ZVlkc2p4bThTa1BJeXBCNE5MR0liQVpRVzI5ajlYREFYQ1FWWUs1SUFIcDE5?=
 =?utf-8?B?TkFwYmxzc2drWXEzL1pxbnVac1NiRFJDR24vTXJ0aVdEc0hOS29vcDlmQVNu?=
 =?utf-8?B?WmE3QzFIZ2VJNDI0SEoybzdRbkRFM0lEM0k5NHZacHpPT0JEZHVzanA5c2Ex?=
 =?utf-8?B?NURDc0VRSkFZekt5ZWVOQ2EreTh5Vys0KzJocWNsM3ZGL3hzZm1qeDg1RWJD?=
 =?utf-8?B?TXFuTU14Y21lRWJzZXZUOGs4T01ydWhwVUVlT3lmRXRxWDRzZEVXU0lPQkUv?=
 =?utf-8?B?RUcwdHYvc0s5YS9qR0NhT3ZZR0tHVXlmOEVlazZLcTc3U0dDL0FWK3lnZ0xh?=
 =?utf-8?B?UERCM2Vsc1dtOUtCT1ovaUVmUTI3eFdqVlE5dHlmSEhYeHl5OGkzNE9GT2ly?=
 =?utf-8?B?NEE0a3N0cHNLSHRydGtLUlUrVGxBK1lWMUpvdUFoQUZPQU1UV2M1allkWGtt?=
 =?utf-8?B?K2x4RmZMcTFqRkVpZno0a0xXN1RtK2JQd2wyZGgvNXFTSDloT3lVTHl4TWtm?=
 =?utf-8?B?Qnc5blptRW9VRUZ4YlFxd09sc0FHVndZQU5uZkhHVDM5REJnL3J1blZDNzhY?=
 =?utf-8?B?VUFudHNIb0NuNE9naGs3WUloWDYyaUtrQmQrQ0h3bXdPSzNHVTlEWUgyc2ov?=
 =?utf-8?B?RFBkY1V0SG53cGVVTklRSGcxSENDMVpEYlFzYkJTa21INlM0YjlXcXp3cWJM?=
 =?utf-8?B?QVU1a1VBWXRxN1Z0MjRmNGlFRDNudVdoc0srUUNhUlRZb0tWem1yZFRBT0dO?=
 =?utf-8?B?RGZWUTUrdjNhQk5XMGxxSmY5OEdRL2diUXA3ZXZySm96REs5SlYwYVh5RGR2?=
 =?utf-8?B?RXNHS1FXUnV0RjFYT0xyYkpaOHF4NmkyQS82T25rNmpyeWN3d1ZCU2RSaGtG?=
 =?utf-8?B?Rmt6NzVKbW40TWUxeWp1WUQ2cGUwc1F4eEtWa3ZWUUIxUzF6WnRPWHBKSEhn?=
 =?utf-8?B?WnYzYTZFb2NXY1hNZ3BmUWk4dXI1aHRLOGI3Z2tFdEhoYlZITkhFM3IyVGl0?=
 =?utf-8?B?NmMwU08yd3hKSFFMTngycC9aeUNhYStFOW0yNWxiZjU3QmpoTlh0dzlhN0Rt?=
 =?utf-8?B?SE9VVlExSExCTEVtVGZOTG0vK3lMWWQ5UC8wWXM4UFZxdXFMeFpTL25xZ09D?=
 =?utf-8?B?OWNlL0d6bWFDaVd6d0Q3eVBJWUdSMWo0elNKWFNIWGZyZURtelptekxmUzJ0?=
 =?utf-8?B?SjRUejNGaEYzTjdUdFZvMDB2MHVzNmNqZG5PNFNuVkpBUGY0SDI2eWpzM1d3?=
 =?utf-8?B?Zk1KOVV6MXlWL0U2ZnBRVzE0Nlp5VWFYbm5XbjRHYTlzdEtidjRHWE5SOFZP?=
 =?utf-8?B?eVRNMWExam1CTmVNOWFvLzZBbkdHck5CZ2V3RlV5YWhybTBhaVlWYXVvTlhT?=
 =?utf-8?B?bWZnNkNhd3NvVitiZWJTc2NYM2hqQXdWSUkvOWREYnBIYmVQL0N0aDMrT2tk?=
 =?utf-8?B?ditOWGRnRGpFcjB2aHN6aGovZmUxUndhQUZsRDBIZ2pJZkxhOS9VLzd2eTUy?=
 =?utf-8?B?aFcxZktyL2NOUk1JL1h4bm5jcnVnL3AvL2pxQzZQT3RmbGtDNWJzTVFXMkpZ?=
 =?utf-8?B?UGJFRy8wRSs0eWs3VGgwRHladWxQaU1lZTNSYWN2VFk1NTJueXlnK1NTWDVz?=
 =?utf-8?B?aC94T0JveXhhOTVMdmlwL0ZMdGE0dHZHSnRaMmpmK3E1MU1yWXpBUzJVMjlG?=
 =?utf-8?B?bCtjc1FzSzFtSXE1c3ZnQ0tPRDJpMElNVGovRWlPUk5KWXJwUEZXRDZMR0lL?=
 =?utf-8?B?azQzVXJXbFFtNlpJVkozWHM4T2o5RithdjRZdDlLQUtDMElFYjc3U05Qaysy?=
 =?utf-8?B?RElLMUtCSU9kMElyWHluVG9ZWmhSbGJMditDRWJJNXppYVZPNHpRaUpVUVlr?=
 =?utf-8?B?am1wRHlEWHBxbC9USlJYRlNBTW5XdUUvTzVDaHpxV0QwNWw5eC9jUCs2dkZT?=
 =?utf-8?Q?N3EXSYFAvYPow5pJMQ3Glrm7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db69a937-237f-4915-b69e-08de1dfba722
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 12:46:21.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOMrRfwH7GK+Lu3svMVXC6yv6MFww+MeNm3J9Yr+BTvoDewHOzDeuYC59/z+KGjBUrYprfHA4IFUyd2iH0+j/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794



On 11/7/2025 3:40 PM, Lorenzo Stoakes wrote:
> On Fri, Nov 07, 2025 at 10:12:02AM +0100, David Hildenbrand (Red Hat) wrote:
>>
>>>
>>> 5. Yes, I'm calling madvise(MADV_COLLAPSE) on the text portion of the executable, using the address
>>>     range obtained from /proc/self/maps. IIUC, this should benefit applications by reducing ITLB pressure.
>>>
>>> I agree with the suggestions to either Return EAGAIN instead of EINVAL or At minimum, document the
>>> EINVAL return for dirty pages. I'm happy to work on a patch.
>>
>> Of course, we could detect that we are in MADV_COLLAPSE and simply writeback ourselves. After all,
>> user space asked for a collapse, and it's not khugepaged that will simple revisit it later.
>>
>> I did something similar in
>>
>> commit ab73b29efd36f8916c6cc9954e912c4723c9a1b0
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Fri May 16 14:39:46 2025 +0200
>>
>>     s390/uv: Improve splitting of large folios that cannot be split while dirty
>>     Currently, starting a PV VM on an iomap-based filesystem with large
>>     folio support, such as XFS, will not work. We'll be stuck in
>>     unpack_one()->gmap_make_secure(), because we can't seem to make progress
>>     splitting the large folio.
>>
>> Where I effectively use filemap_write_and_wait_range().
>>
>> It could be used early to writeback the whole range to collapse once, possibly.
> 
> I agree, let's just do a sync flush unconditionally and fix this that way.
> 
> This is simpler than I thought, the key bit of information is that we have
> freshly written the executable so it sits in the page cache but dirty.
> 
> Thanks, Lorenzo


Thanks David for sharing the commit. This worked for me and fix is simple.

+        if (!is_shmem && !cc->is_khugepaged && mapping_can_writeback(mapping)) {
+                loff_t range_start = start << PAGE_SHIFT;
+                loff_t range_end = (end << PAGE_SHIFT) - 1;
+                int ret;
+
+                ret = filemap_write_and_wait_range(mapping, range_start, range_end);
+                if (ret) {
+                        result = SCAN_FAIL;
+                        goto out;
+                }
+        }

I'll do some more testing and post a cleaned-up version with proper comments; rebase on mm-next.
Thanks,
Shivank

