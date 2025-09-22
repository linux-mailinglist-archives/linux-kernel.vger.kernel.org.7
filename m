Return-Path: <linux-kernel+bounces-827703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D6B92739
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C969A44467C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AF31577D;
	Mon, 22 Sep 2025 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tFNcTRXY"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020089.outbound.protection.outlook.com [52.101.193.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A317A586
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562459; cv=fail; b=s6bKRznF33uRTqD1eK8hcIvhMVCagf2ApC2rN84h9+0RhgX2zgnyidkHFyw7ph9B3W6pa0MmabC4Cl+DiVMjxyq78xg8Z91i1s/PyCu0fSZ6JAulKDxoxyDNgY1aIYKaa6G4bwDE6s0gdrLvUT9rBSwZdXBkiFkBvLwL2ZUh5/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562459; c=relaxed/simple;
	bh=GXHbyac5RxvmHhbWee/kAuH1xwAYV1OEnirQgtYPNSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=uIG5nbU5GsLGYldaTqLMdMuoPg2cdGmZhkn/mDD9QJeuq4H5Olr5924NdcPv0gHRvpsGlEOY8LgmroKDZGR6+P2kwyDMv939v1PEfvkXa6IpxaI7debsDrjxtSPluUxkh61uMh6mCTMSfJfeAQZKRbgww7VsuYe4PB1t6yqyHoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tFNcTRXY; arc=fail smtp.client-ip=52.101.193.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMdWu3LdUaBbpSpMfqDSeQXGRlzuOIy83ilSPlTbcr3AdGwZZJ0SaCcNo4duyDaL2kAHPnrzUAM/c+/pF8o/PNLBiKCt9eG5oZvurF8FKgDEBula8Jq34c7xahBKG7qJjfZNgKDfdhEwgseIUtqUYGwXqlCL7iHHrUTZMznNzbI9Ku4xiAGaI+o55HHPU6/mcSZw9Kr0mS6naFEhOEZEcZYaLsgvPXGK3EIqJZnxKFXXwJxbqy33Vyfy7MjYm/K2V50D1mVq8EhfyygwjKP5r5vo66fIl2gjhM4sywlNUVkBdLotHXz+1/u9lrwdWp6tXnFsFpFveg9HtxipsU6a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXHbyac5RxvmHhbWee/kAuH1xwAYV1OEnirQgtYPNSM=;
 b=KRosXlRtF0IN5M3dB0fDfvvwgoizDOF4xVa5c5Xf/0qrG+iRB9XsUqjHIYAPslqBNIkCDAbsUwM9IVHxFWK/g/N7KLXlX31joufaAU9MbWAYN4GYHjXKaEB7eNJIX/YU5nyxzMiWWg0YppcqK65/FZvm2Ub5XAorWoR8MP+r4i517vLgdu5QrZg8+CqjmsFbkSFef6xjAFO3IdXf23aAsOS+hqY91qIUnBCIfluGJlmzREKRXzK+yHN3c49yPD0ZS3Pu69o1fkjnjyk2+LKZMauKm4hBO63+DHLPwQG4zdOz7Vdo+SD8h4f7FagHj/HdZMApC9ArfRGCDX9Wh+JnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXHbyac5RxvmHhbWee/kAuH1xwAYV1OEnirQgtYPNSM=;
 b=tFNcTRXYZsx8Wv77jxdXlbX7tlqTUumAPv/rHRSFdNo1vZTeUoFTIscrxNRM7sYa3U8qpDExOy02YgEUop+3Cjd64bV6xTsQYrGva139Gt9HUo8fwqgKvizUaG5xDfLWQjwOVMfp2BN7rJGBXa+3RAjUgJfpBkAeWBVN3ELkMM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6862.prod.exchangelabs.com (2603:10b6:408:161::11) by
 SA3PR01MB7917.prod.exchangelabs.com (2603:10b6:806:314::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Mon, 22 Sep 2025 17:34:15 +0000
Received: from BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83]) by BN0PR01MB6862.prod.exchangelabs.com
 ([fe80::8a1e:34a8:2ad9:7f83%2]) with mapi id 15.20.9137.015; Mon, 22 Sep 2025
 17:34:15 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: Jie Gan <jie.gan@oss.qualcomm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
 <james.clark@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jie Gan <jie.gan@oss.qualcomm.com>,
 Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] coresight: change the sink_ops to accept
 coresight_path
In-Reply-To: <20250922-fix_helper_data-v1-3-905e8115a24e@oss.qualcomm.com>
References: <20250922-fix_helper_data-v1-0-905e8115a24e@oss.qualcomm.com>
 <20250922-fix_helper_data-v1-3-905e8115a24e@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 10:34:03 -0700
Message-ID: <87y0q6mlx0.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To BN0PR01MB6862.prod.exchangelabs.com
 (2603:10b6:408:161::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6862:EE_|SA3PR01MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: d052829a-9fcd-4f81-588e-08ddf9fe4035
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CSzRitvX45nhr+yhshMNJUhmGAv/J98SDhc2jR9Fjr4A/zZrQsaTfCR8MizX?=
 =?us-ascii?Q?zJm/wGRZ9Jl5dTPXKkLEqcAQZ550vy8jx896GLBRl8D8s7aAE3aKWaFvp7hI?=
 =?us-ascii?Q?fi1CA1vq/N983QWI2p0oZSKA+PyL02sIvCT74iNtOD94E2REg2PmPrrdUu7h?=
 =?us-ascii?Q?xTgT0lLoW/RFJYL5LsMiOgWKb/U8w8hSSVZ5PIQMsCGY6qz8t0x8eCQ6dIcE?=
 =?us-ascii?Q?QdQZl5COvPPH1KbI/q52BTITBZMK8a1Ta5DEAHQGrELid2fjefO3dbMeUbn4?=
 =?us-ascii?Q?y4D7spKo3aKkpI9I3jva58S4FF37HQsJl1fW9mlqa0UzetmnjmNN7qeblvsM?=
 =?us-ascii?Q?zsSzjpltQuG17YHw/bKpFL9Yet0uKC4um6fmk3Sewj7A27XVJBTzu4o3hBSE?=
 =?us-ascii?Q?lqVaoZFOn/TUzU69OJEoXuF+XeM+jV8WUwV5QQs5x7jFKlZV6XT1LJjQXk7W?=
 =?us-ascii?Q?AecBBcIVeic9Zbd41gZ1NKONdb+537KBqnow6O4xwkbIIHo/+8XOwfaVWJpD?=
 =?us-ascii?Q?HJXl56B1b+oi+jMODbVb8EGh+usYS0JTv2AzDdxoQyzycfBKCfloyULvcW5C?=
 =?us-ascii?Q?6g8fEFCRPgeTO+g99/DSuzCBgLuvFZPKX2JJ2U00GX52GvYCFu2C3JoeRX41?=
 =?us-ascii?Q?xTTD5aLkSt8UtQk+KBdzGmwzu1iPEno8KmcHpl/NYEv94Me3fvabv3Qnkep3?=
 =?us-ascii?Q?mM9fZY9bU0+7JgSS7NkWrKgAry6jwLemhV0DOE/KNXeVNN9idOavjHKoEQbC?=
 =?us-ascii?Q?3ipborNw+IKRbWqHrNhHJldzOYqXqW8tWYgdS9MfuDfJ8MGNow4IKKBnJ6wp?=
 =?us-ascii?Q?uR7XCyoMXewBqp2edwpSEojkdPzX+kF+Si/H7d2y56vKbpN4lHHxWug59aUm?=
 =?us-ascii?Q?BRcjzUPLmT7f3BDHzGWFAmCy9XDlLnD0a+zSprsqd2JE1/Djsvzi8ZsJEEOj?=
 =?us-ascii?Q?RCOjTiEZPcA/Cyo7OYBYV5TerVJZq36sbeNSLoukRWTFVwIWvz3DoaUiwOZX?=
 =?us-ascii?Q?s34GFww148X3J27mUVfccD5Ikt6LuGJX1biwHfBCKh8S3XWhH0BTaWHLottU?=
 =?us-ascii?Q?WRJYu1fTcoGiGO8QBiwzBEpIP4S0iWb0oswjqfcTnsrb0UuYa15I7GcoUqNs?=
 =?us-ascii?Q?C+A0N2Ay7g5QC7tPoZDoYGOAKTYDzt4JNEnmpfxQIRbzO7jASNSgiWdqhg9P?=
 =?us-ascii?Q?ySkz7vzYOBVjBk2h230uZ03TZz/FjeDuxwud22CU6LFJaIGhRFWOtg5rOsrK?=
 =?us-ascii?Q?XEa9vhaieQ6ViEe/tV8fIf6MBcdfrzim4OcWx4rS8ZE/PUDSfAylWpwp8dIO?=
 =?us-ascii?Q?TCmVQsJB1qvHXHgU7HBVPu+yz3CUxwWV4cg+zj2Jg4SnepX6TrXKJ3Msg/vD?=
 =?us-ascii?Q?nJcOn2MBN/hjmvfc1W2Mqa74eLZsgY/nqhV9NEJ5cv9A6Fcy97A9OsYmurMN?=
 =?us-ascii?Q?LqNbR4zXkBUNUxs9QxP1BEEX0K2GbNfThL/dnvNkmFM2EfHBE1Y/vQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6862.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ahMHYuDFqk0MmrKIj3VEdlqBjawJyY7UxtbIlkHgNNXShXhk04hXsYARG93j?=
 =?us-ascii?Q?pW3jfjkEw79hWEyBmaKtetA5yCjA5zTF4U3ZDzU9+5+Qkqr5cfO5o5nlGSQl?=
 =?us-ascii?Q?vpsyzbLgGtovlRPvZZcQqrGSHZ2rlafrjMIyrimN051hJZa224FNygG7Au1t?=
 =?us-ascii?Q?afgdvLTEc7CkMN6nNF9elblxCAz5c+g4djcIZz7b/RDM8JCA6cqaMX2HA0gz?=
 =?us-ascii?Q?tsTRSpVoiqYbdswnxRglHrbcxl+2KeJl8QygP6V6cKpL916yr7KnEQBE7IE9?=
 =?us-ascii?Q?DuTMNHGxxDXvXp0ZWWsqamx98BoBy+4X+D61F9ew6oyx2plfoY2oU+lrjM+N?=
 =?us-ascii?Q?pzuRjR5PJXqsO4cKr/1ESNMlZnlk5tCxk0LlUn2OW2uqKjpypnE/TfB2Up01?=
 =?us-ascii?Q?9iWxeVyPopHgTNZtpY3T7rzNxJcayvDgrXrp32wZAOqRI4b0xLmnfNFRbMe/?=
 =?us-ascii?Q?wq37AjoDEFa2pBKgvtDaEtlxpA0j9Qd2TNF0f1+03zrSD04pIbj+mKK3TM70?=
 =?us-ascii?Q?tIesMDnT3JmvIkiMou4u4JMMbX3Vi/GuZClN0yTTNa7g6oNiYkN/YVCOdtgX?=
 =?us-ascii?Q?XVzhHMNSLaDxvrmIIN7fb6NED3mKffjRZDTa3deVSfdNl+774OTiRXRDeXJH?=
 =?us-ascii?Q?s06BaFW/pfGSmnL227Ms8l01PJ/0ckd3tZvOo4w7m+H9Ayx70378WhcPt8Di?=
 =?us-ascii?Q?39uaXM7l/ksaW7Nvp5HC18uvrEzBvBUiAKR3gRPKkvlw7Y2ZYFGJ0tRZjJ+s?=
 =?us-ascii?Q?Aj2OGlkg6QN/Dvrpc/obDKeh+J7XCMqEh75oESbZg/6ry4LVtqttbvyYjda6?=
 =?us-ascii?Q?iHc+PqwKFQRZxOEpD+6aie11ekmHclUnich0PiqA+P9eqdeq7g5ufp+7KjDE?=
 =?us-ascii?Q?nxfR3LOws25+NK7jQvUxRwZnWV8YCGKJxi6En0E+s/OrWg4QoaCgUraSfs6d?=
 =?us-ascii?Q?9n165uBef4vphNOcJwmkc21nkUPwALr5jkLUaEzgwW6YhcndRwGz8fs7yCeJ?=
 =?us-ascii?Q?mg3y5eRmvyKyHGuvngGeIm4v4grhEv8pDcdD4iGORgzNusqe+2Lz9hg3qoVF?=
 =?us-ascii?Q?PTO1Ail6RkmcFemtnjRyXDX/FhCv5/63N28UV2nmmVVFuR4xu4xWbJkw8Dfu?=
 =?us-ascii?Q?n9I9tr65ZPPr9boXc6v8zkCM4yooLV91r3WEIPmBJkvJnA7DKyLB3zIsq6lA?=
 =?us-ascii?Q?caZ8I+2YE46qY3Veq5ndAuUlQOTitUd/A0Jze3JkFir6l/9fEmu0Z3RwLguh?=
 =?us-ascii?Q?3RgRma4qjmG6/VzjVQGb+uFMJZs9M0w+TvXp4VMM5S8MFEjM7rMBySLNyxb0?=
 =?us-ascii?Q?kxTvb10gqGCoYKChEUHvK2U6pw9wRC5k0hO83EhrYcJ/0aa7JYo7diEv3NPb?=
 =?us-ascii?Q?C1hRJr7hv6FhZPtFgpDIzvCWAzi6KSOZ1Ves0ctEzfHO6WrwlMrdTbvQFzLq?=
 =?us-ascii?Q?03c7iCtUPTuVCpZi81jSWhvzKlIt2ck+ClmJS0eS1NxoZyNnNItPhJRyu5Sy?=
 =?us-ascii?Q?zkroX5fOcopQd8eoyuuvu0HW3KNco18w+lkYVScJG96ojKnt4v+RmenOg6z8?=
 =?us-ascii?Q?pACZ7nMRLMB0cNSyFdKracdO+u4pQ5dX6yteOUXAK2mi5/tuS92itEmD33m2?=
 =?us-ascii?Q?mnW2ib39dWK8gRbdhv80AiA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d052829a-9fcd-4f81-588e-08ddf9fe4035
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6862.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:34:15.1859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2h0tx+5hYOSL1t8CTc1XHiHiN2CiZtUqfLZcFhunee48U7df+vlUNkof6sBPxx8QdTIxylmJQHWH4gspvpc/ErJBbsUscsspcVA8hWGOmJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7917

Jie Gan <jie.gan@oss.qualcomm.com> writes:
> Update the sink_enable functions to accept coresight_path instead of
> a generic void *data, as coresight_path encapsulates all the necessary
> data required by devices along the path.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>

Tested-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Carl Worth <carl@os.amperecomputing.com>

-Carl

