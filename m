Return-Path: <linux-kernel+bounces-755510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB3B1A734
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B75A18091F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A932857CD;
	Mon,  4 Aug 2025 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="btII2jIg"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921382853F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325565; cv=fail; b=JiKv8PUnXhbsCSVOLTfAl7orSo/DaLkSaRNjwVJsGlYTDXd64X+s1aAn1VIHh81Y+L5dV2dGbRGucQkRZph51qXP5AHIaXjzyU/xX4E7srNF6Ytnd8Um5n1jHeo+pVbmpzI2TS5ksH9oHbc6xmSn3acosFvveVgepekaSXUhT7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325565; c=relaxed/simple;
	bh=fl4YCYAcUesVfY3Ev719cKmZb2zeS9BLPTB7Ij6T7WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBkRgrfTb40qJlDLzc4LuQg2Fg8ZwwIlC6jSofBulvuZFh1xVruLxvYpfLXQAMpqZ5/8kw203VsOLMqWvX6JW1xYxKmBZR0kGPLZvMwaw5ZQMkSvtlfAZUAarx3fo3W3Abj4YQcgcO70enV1J2z9o99j0yus4OXy7zDU14AWVJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=btII2jIg; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqq08xlbY765UQkjW6QxlRpWRtV3Ggg+w1F2SZp3eCAjNdXYj1tnu9hu4QEFIE3M9wS13BnJCGbnq8KiA1b3zJzX/enJ0BWosKoVvSESyM/Fbk8di1kxNCE2xQEMF8sjiudTHZsOHIR96D5YWC2Y3aL76z3GI/RPy+HEvvjmxpIkaRlMVtUnhnwn9p2h4/cdO3BTOPqvme200u8kLb9dP3x+t/AcQprSNW0GLbBaBmlMsYj9ZH0LTqxyeD58Cc93nTVxYtTYxi1rxtddvCUnm/kjGctp0642ALX35foSlV2TpnP2Z+O/JCcZ5u4cuFp6taA00phVq8LIecuC+kpkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FXHmKYUI9g30uR41GEgSXbO0pklMRhW2ER3+MFVrzc=;
 b=TDSM1zpX5vcoseEjHt1CZu+WJgYlEfzAUT/jIQnvIZcVpMx3IER+XZ1gRHYhL1pBBdcvpI/wpeuq8kCi/yks/4nOCmqJtWMcpDMtx3E7T2rCM3Izgeu/44/hJEtZzpPdvo/zURgnaINHyv9atwSVAHsYhi8axfe9Xh63GfFka4Uy0Uw9YW+Oor7mE+JlVXl7Z0wAsZwtQDJUSQ3zcHgq8nY5GbLxo4ogcv4odhyLD9CnJ5V7vd11i4oIEz5Iounr+SjEPjIvz8kbwek/DhYMwY7whU8oDJ+lpzKZwyR3dBMZX/d/UPsr0Gl2oguiE38qKbQLT9kGRQYyEvZASDWd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FXHmKYUI9g30uR41GEgSXbO0pklMRhW2ER3+MFVrzc=;
 b=btII2jIgSQz8XzjbYF8dcznm0JrnYKGb73F2ggx95mnG3k3QPKiPaygqFMxuK2Su3hdPaBhoK12wXMZUIMU0w9RsEdBdkHBFchuKuIy20749aOmVXBOdYnIXrJpeNeFonubHuKXo3j0LQeZbodXHsDgETXG8kDDxKIqqFiOl3q8iMoMqtBFgVdmeCoMT0mjaZ1ukO6i1vJGGtoW6zIJ4WddWhM9PehN4K4nO4P1D0YpgbPJm9sQZeLAVJHtQu4mXkW2ECxvnrfWQetQlBylkBb5Zx3FGC7fISyvJ8mmnFP466v5/kUw986P4wgF0iJvi/abooM9g6Esgcl+NNMg3PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 16:39:19 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%3]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 16:39:19 +0000
Message-ID: <4778e89f-0b94-441e-947a-dfc9839b250b@nvidia.com>
Date: Mon, 4 Aug 2025 09:39:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-28-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250711183648.30766-28-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8abf15d8-0b1e-4c47-d72b-08ddd375749f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVhXZ0p4MHh2TCtCc24wYXZGekYzNzZjNk4vdE9YUlRadUlKWFVONGE4bjJB?=
 =?utf-8?B?YVJlVWJabkJZUXozSGY5NTFLKzI3bTgzWEVpNDIwYk80a3dJVUN2eEkwMmht?=
 =?utf-8?B?RmdrZ2ZXR1UyWlNsdVFJdlR4N01FTGV0aFhsL21teXkvamdNNTdDaTFFekNn?=
 =?utf-8?B?Rk84Qlo2TDJhNTl2RTJIMDdmVnAwRGNDSVRUbk1pMTRFOW1jTVRBQTlURjJl?=
 =?utf-8?B?c0h0WVdPc1FtS3l5SzhnclE3SWZaV0xocm1LN1BJck1SeGtudzZENDIrMW5I?=
 =?utf-8?B?eXZLcDNjN3JoOE56WDl2UW9zWXNSOStBOU0yOGRCRUVuS1BqR1V0YnFoN2ox?=
 =?utf-8?B?NlRCdWVIY3U5Tmlkd1NDRjhXd0FsSXNCRUNxVDJsWjhLenZ4cGtkUEE1WlFI?=
 =?utf-8?B?STJURFRQcXlVTCtTQ281T3NKaUoxOVFyaHdZSDhNUUQ0ajlDTTB4ZFdKNW12?=
 =?utf-8?B?MFk2aVVOTmt4RDZQbG15d1k5R3lGZFNRVFZSTndEVTJFQzhGbjFlYnZDY2h5?=
 =?utf-8?B?ZjJ5RU5VenB3aENZaVYzaWRxY2xmS1VsRVRCQUdIRGk5ek15Uk5zQ015djRj?=
 =?utf-8?B?R0YzQkwyWmFhcm1EZktSVUdzd0JjVWkwNUdaeExhc2lxNjJVRGhNU05YVlRT?=
 =?utf-8?B?K3ZrYU8rQnpvaDkxczg0MGNUTE0rcTJMaU1UTnZVdDlldTkyZ2FCSmwwV1E1?=
 =?utf-8?B?aFg4OWdVVlFYQTJub3hFV0U2bWxjcWdGVWkvbndFM0RjWkRERW0vWHI4Qm9q?=
 =?utf-8?B?Nkdib0owd3p6L2VqeUNOR1hYZ1dRa0FoQVBVWHZJak1nREJzSlVTK0RoRk9K?=
 =?utf-8?B?bEFhS05ubzI3eTdLb3F6c3IvdjM2WHRhWHlHcC9YQ0k0bTVFSkJKRDQ1UU50?=
 =?utf-8?B?ajEvMTVDWEZDdGtETUlZQUdkOE5meXNReWVMVnFpVVRCakhZcHNQUG5Jem5T?=
 =?utf-8?B?c0RjeXIvNXE4S05mc0M4RENLY0FEb1J1MW1WK0pYdlg3YXp3eDhNT2pVUVAz?=
 =?utf-8?B?WDhvVDJRZFFFVXoweDBKMzRtdWNMckRCYkcrU21BOHVraWFpZURsSmlJWmxn?=
 =?utf-8?B?ZDFYT3lHemFETVVvaXoxVFRoUFlqOS9LRkZEQVhtb2pDeURSWG1aWEhiNlB6?=
 =?utf-8?B?TWtWS0RWS0Z1L3F0WnFESC8zMU0yT0NmVXRwWE9LR1JLUElNK1FjL3ZrakZH?=
 =?utf-8?B?eko2RHFrc2NLaWU2b2pSKytZZVBqTnF6VVB6amtZMExNeWlmbzQxemcwZWVq?=
 =?utf-8?B?WnJlVEdvK1haTTV3eUxMYWFjUUVlZkx3YmVSSXAxdSt0SkZoTE8zT3duam4x?=
 =?utf-8?B?ZGlSWFJMc3BFOUMwYnE5MmYxNG1tSnpnRytOeXZqaWs4bTg3bUFOU3o3Y0hi?=
 =?utf-8?B?NXIvTG1yM3NPRnNKWG8ycFl6V1UyMGZIcGNwUjhsNm91TGJ1MjJvS2NFMTlP?=
 =?utf-8?B?SnNvSnhDa2w4akhycThNelRxQTZsR29UZThVUzI0SUJRT2tEemZqdytPN0Zl?=
 =?utf-8?B?TnNJYWVrNnJDeXBNU3NOaXZQUWVwSUFtTXA5M2JTSS9STFVPZkl0dEhBQW9a?=
 =?utf-8?B?VEhjY01kY25tUU1ITTdRTE5ZRDQ2ZjZWa3lzM1VSSVIxY2VvTEdackkwSHNU?=
 =?utf-8?B?Sk9pVlplajJ4VC9FOEJzZFJTcnV3dkg2dXoxWERaNWJNbTV3THhmNWRuT2tJ?=
 =?utf-8?B?eE1TT3I5a3JVZGxIMjUzUXZtbUk4MHdQMW8xRS81dDJlcXBFNlE5ZVlZaVpQ?=
 =?utf-8?B?K3h3M2dhOG5abGdjeWlqcnJvRzIyY1BYc3h2VWRQTmpXUFdzK2tQUkViK21X?=
 =?utf-8?B?cUV4WmtiUVFZVnEwSXhvbUozbXJkZzNHeUVEdDlkcEg1ODh0bDRBUHhwVjRh?=
 =?utf-8?B?Nk8rL0EvNmFLQml0dnVyWW85cjBIWWNSZElzUHRidFl1azNLbGgwOFl6Tzl5?=
 =?utf-8?Q?G0I7wtkD46o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNNdk91Qk55VkFTUEJ0TnFiQ1hpMmFIaGZJK3QyMjlvaUIzSnY5eFNFMzRi?=
 =?utf-8?B?a0c0YU5XK0dzNjQxdTVRZWIrS3BjajdiNndQZ2hoWHFpUFpNeEJPbWtRaGIy?=
 =?utf-8?B?RlFkVzNFMmJNemtGeUN6QWdmSkFzRVg1cWZldUNRemw3b29VMnhBNiswQ3V2?=
 =?utf-8?B?R0NZN2w2QTRqTEJvbng4d0s0bGxlSjNVelZnMkFiSDZBQXRYT24rUk1NZFZB?=
 =?utf-8?B?Q0RHeVFZUThsNlRjdFc3U2NNVEtxQm1TL1JNOEw5a0F4OXFSRi9uWEZ5djFJ?=
 =?utf-8?B?V29wVFhNTDBiS3Rsd0N1Vlc3UUFUcGk5aldlZkg3SzVWSjVlNkQ5ckVOQWhC?=
 =?utf-8?B?eGYycklnY3VMRmlyZTFoZy8xN0UrUzlCTGFpbXQxR1l3YjVWclNnT1dqZ0NM?=
 =?utf-8?B?UmNvRWdYVzF3cGZnZDdaampvNkJNR0JBZVNHU0x0enZxT2w5ZG1xTDMyNFNu?=
 =?utf-8?B?cjZsdkE4MVUzTTBWRk1LcWhSdVJPSThVaFl3akVONjQ2aXRoRklXREcxdm95?=
 =?utf-8?B?TUVQT3ZDZndvbzB4THVVYk8rTHhLcWJMRnJuQ0preVc4VEZEN3lMaGl3a3lq?=
 =?utf-8?B?UGN2R2Vwd0NFSDJ2blZqZUhyQVhweGpUVXdhWENZV1h6WVJIaW1jR0V4TnJs?=
 =?utf-8?B?dDNuQUV2ZG9EckFiY3dyNUFYZnBVeWU0TUpvOEd4RVJRUDRkaGNKL2wwSzkr?=
 =?utf-8?B?RWxicXhuUVByOGhYM1lrZjU2Vm1WNjVkTTZzcjhYWXhiOFBUMU42a1JKazRE?=
 =?utf-8?B?akg5NnNGTkFrdDQzR0VkQSsyandIaFlQOGgwU0VvQWhuNWlhZDZBRko0ejla?=
 =?utf-8?B?TDkzUTFsbmpjYlRzUlY5VzVBSHQ2NHV5N2g1eTdhQjFHT3dOYUZ5dnRFTzNB?=
 =?utf-8?B?emVleWFrdW9DT3dVQ1VuR2FCcXU5S293NW1kZFJKYUs1VTFEMnlIL0dDaWV2?=
 =?utf-8?B?VFU0d3ptUmNkNlN3ZUI2ZXgxTGFVZGZSTTE2dGFSTDV3QnVhSnhTajhWSGk2?=
 =?utf-8?B?N05CZ0hTZk1QL2ZXdTU5YnNaaFNZQXh6d3NpL0hvNkJwNHpwTEZaK0w2Q1JG?=
 =?utf-8?B?N2ZubDNtQzltdVhyZkI3UWNJU0Q1eXJ1SS8zR3RQMFRhMFoyaUFrNTMwWTIy?=
 =?utf-8?B?L3ZUVkhYaWJybzBPNU9TbElIUEdscXlrclJSWkZIb2hIajFaZ1ZWNFZrNlpp?=
 =?utf-8?B?M0hUUlJ1cm5iYklrMTdvY3VaLzA1UjFOVENYL2MvTk9hbVNwN1lhS1ZFRE95?=
 =?utf-8?B?Y3ZUQWF2Uzh5NkhWR3VVbGE2V2ZkWnB3SXVqVGIxRFN1TTAyN1NodkRyYnA4?=
 =?utf-8?B?VjVsMVB4L1pXbURoSlUyNld6blZUNGRabkdzdmZHdmN6dUVBVlA5alo3K1V1?=
 =?utf-8?B?R3FROFMxRDRMYmRUSjJQQW5lQVBTelBEcUxuOTMvK0d4Q3RPMWNHK0VCbFNR?=
 =?utf-8?B?NVVQbG1NcmpOd0E3REdDWitDN3VmY21COWpKdmNrOTU3bGRYOUN4MHIyKzJU?=
 =?utf-8?B?K0kwTklvRUNUTmxYbHFpNDdkK1dXcVgrM0lCNXVvU0pqcGdnNnhwMlZxZWFL?=
 =?utf-8?B?OFpOdWI4b0h4dmN1VGZlZjI1NElYWXY3WGNsQ0Q4ZTdXMkJiZXM3OEpiSG1G?=
 =?utf-8?B?RGNKbVk4RWdnOGdCUi9Vcnd5Q1BYdUZCQU9TRDN6R1F5N2NXNm85UjJ0aDdG?=
 =?utf-8?B?MWd1R2RtcUFkSDVjWnMxLzBWVTZ1ZXRNRUNsaDN5WGU0MElJT3lndFQzdFAr?=
 =?utf-8?B?QlI1bldOak5sTDlyaEJnS1ZHblNKd29BaHVRMmdPQUI4bzNrTndtSjVDV1NT?=
 =?utf-8?B?ZjUyd3JOUWtSYTUxMGRHRCs1Z1BHYXRtc2Y4K1pOTDI3UlBDOHN6dDlWNkV6?=
 =?utf-8?B?Vm1uREx6R2I0UDQwaXQyQXYxLzhJMHFGbSsrOXg5WEttOHg0em9JLzI1VWc4?=
 =?utf-8?B?Qm12ZjYyeUJaYzhBOHRjaWxNTVBqRDFGZXN4eFQ1ZklUWDJycHUycitWZXNl?=
 =?utf-8?B?RVZuV1RQK1ViL2d4OCtOMUx2aDVLOGM4NU5FczVhTFpldmRRVHZWdXlQTHRC?=
 =?utf-8?B?dmJTMGoyUm4xelFTUUFoVUhIeUJjclkyN3pNNDV0aUxCT25lNk5UaENXZnk4?=
 =?utf-8?Q?B1blCwA+A8yGi6ozMFJbhki6V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abf15d8-0b1e-4c47-d72b-08ddd375749f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:39:19.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2f8mGsqq6xLkwtylYmo8ELWtdu3V1EGVSf62AzaPGyRL+gWHEYXzA6I+IEWhKm1G8jQWD8ty2l7L5ilFwZQEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

Hi, James,

On 7/11/25 11:36, James Morse wrote:
> When CPUs come online the original configuration should be restored.
> Once the maximum partid is known, allocate an configuration array for
> each component, and reprogram each RIS configuration from this.
>
> The MPAM spec describes how multiple controls can interact. To prevent
> this happening by accident, always reset controls that don't have a
> valid configuration. This allows the same helper to be used for
> configuration and reset.
>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_devices.c  | 236 ++++++++++++++++++--
>   drivers/platform/arm64/mpam/mpam_internal.h |  26 ++-
>   2 files changed, 234 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index bb3695eb84e9..f3ecfda265d2 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -374,12 +374,16 @@ static void mpam_class_destroy(struct mpam_class *class)
>   	add_to_garbage(class);
>   }
>   
> +static void __destroy_component_cfg(struct mpam_component *comp);
> +
>   static void mpam_comp_destroy(struct mpam_component *comp)
>   {
>   	struct mpam_class *class = comp->class;
>   
>   	lockdep_assert_held(&mpam_list_lock);
>   
> +	__destroy_component_cfg(comp);
> +
>   	list_del_rcu(&comp->class_list);
>   	add_to_garbage(comp);
>   
> @@ -909,51 +913,90 @@ static void mpam_reset_msc_bitmap(struct mpam_msc *msc, u16 reg, u16 wd)
>   		__mpam_write_reg(msc, reg, bm);
>   }
>   
> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
> +/* Called via IPI. Call while holding an SRCU reference */
> +static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
> +				      struct mpam_config *cfg)
>   {
>   	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
>   	struct mpam_msc *msc = ris->vmsc->msc;
>   	struct mpam_props *rprops = &ris->props;
>   
> -	mpam_assert_srcu_read_lock_held();
> -
>   	mutex_lock(&msc->part_sel_lock);
>   	__mpam_part_sel(ris->ris_idx, partid, msc);
>   
> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM, rprops->cpbm_wd);
> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
> +		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
> +		else
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
> +					      rprops->cpbm_wd);
> +	}
>   
> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM, rprops->mbw_pbm_bits);
> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops)) {
> +		if (mpam_has_feature(mpam_feat_mbw_part, cfg))
> +			mpam_write_partsel_reg(msc, MBW_PBM, cfg->mbw_pbm);
> +		else
> +			mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
> +					      rprops->mbw_pbm_bits);
> +	}
>   
>   	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
>   		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>   
> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
> -		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops)) {
> +		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
> +			mpam_write_partsel_reg(msc, MBW_MAX, cfg->mbw_max);
> +		else
> +			mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
> +	}
>   
>   	if (mpam_has_feature(mpam_feat_mbw_prop, rprops))
>   		mpam_write_partsel_reg(msc, MBW_PROP, bwa_fract);
>   	mutex_unlock(&msc->part_sel_lock);
>   }
>   
> +struct reprogram_ris {
> +	struct mpam_msc_ris *ris;
> +	struct mpam_config *cfg;
> +};
> +
> +/* Call with MSC lock held */
> +static int mpam_reprogram_ris(void *_arg)
> +{
> +	u16 partid, partid_max;
> +	struct reprogram_ris *arg = _arg;
> +	struct mpam_msc_ris *ris = arg->ris;
> +	struct mpam_config *cfg = arg->cfg;
> +
> +	if (ris->in_reset_state)
> +		return 0;
> +
> +	spin_lock(&partid_max_lock);
> +	partid_max = mpam_partid_max;
partid_max is not used after the assignment.
> +	spin_unlock(&partid_max_lock);

Doesn't make sense to lock protect a local variable partid_max which is 
not used any way.

[SNIP]

Thanks.

-Fenghua


