Return-Path: <linux-kernel+bounces-888416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C89C3AC3A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8474C3BF988
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC13164B0;
	Thu,  6 Nov 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="rugdnxzh"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021133.outbound.protection.outlook.com [40.107.130.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5755314D35;
	Thu,  6 Nov 2025 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430152; cv=fail; b=i7F1JYdEC3HodKs+um34OEyAnKGOgas/8WpAcqeCHtnLib+jYy801G6C+e8q6fZ0llNO1i9aRbM4tFHaW7syfFU4hqfr3LCWdPNTWuBMoZU/TJjzu30mhquDv5PGGHH38rDGkZiN9QRl15tL7Cstlvu5jmD/3IfIua2kxvacVKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430152; c=relaxed/simple;
	bh=obKVbnTZg4KyUIk4haYYyqz9qJ9SiJz8E16xqhQbvIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SotziFNBjknKxp0ixOLsXQPd3w18CH/+TENIrm+G1c86eroaKiiKXV+KIF7UYrivnVYCPG+zq5N9rEOr13XLu7LgOCoywb0GslLPtttHFqnMuuQ7V+asiqq2r3gkW1+dFSYACX4JsFM/WsV0QPWRwIab2HEr5MAf0eKZMatRET4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=rugdnxzh; arc=fail smtp.client-ip=40.107.130.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUkvZ4E26PMm/AS3x+ZWm739wpUxo32vVrWt1f6qNe5Q5maj5XhfwYWhiWaL8qBKXgFtqWq4mCSTicQ0b2iaZT7SX0C5vICdDabht9eRxDOiYIGnHXRWNcJIscbsajYx97ddaYFL3P97d4C0Tg7kvz7tkxF6ORCFclGinRHE7dGr+cVOrzPMIaJTJrQOzzRwifhnEoSDQJojihdyYlCJuGcg0WK1j0kgeoTNEBWkoNoPe16fSpq72Go86T646q6UVg0eE8iIvcfbqZY7F3Dza+e5t2aF8P2Zip6+zR/McxgloF0MM+TAKEQeKcq3IUMpO9zZ5dyGeQ/ATzxUEo2bwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyDnPh5ZpaJ3a69iy2BYUgKMKDcQl9zCN0aMXr8L3xw=;
 b=qaBALbn7hyepRpPXjjZaKUnZCnRNGxvw8wh0Ehq3kM/35Dzr9Ydzv6lvKjvq6bJMF6456V6joGHiiEYn+CtwnyZ9euzjtXAL29j90EYRGY4dp4eXyriWZUehmq+KirU8HrhrN8++fXK7jugTff/2vDXPcGW+O+6js/ahG82IJpgoQ0464UbB10WAFWXlBV8hRDuR8LX1xTAiPDbS55ZsUL2wdVoehodW0bmuzQCJOd1sc3t8xPAh7dXdNEaN+fEsDthmDmTQ4TEFKmLjowxclgmn+xa3VZAlUppV0AbdzRyuyVEp8u+mksUZ9r+3k6rh5cgsjmhT9Oba83uTQTnY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyDnPh5ZpaJ3a69iy2BYUgKMKDcQl9zCN0aMXr8L3xw=;
 b=rugdnxzh1zwjHbCL6OJLdBeEPHRCn86BLtYcnYRWSp53ZRANO9bqm3MQ1VNyfVtCaQgkVUUpZo+Z7kHMnPplz3y+SuAskcb90a5+poCXjKopmg7Zs9PPmGoaVltwNMmWJ42EW9cUJk+/hE+rzklU7SQL3JqIUBjA916GmjzxcVt3YQw3Pk1F1RG9hMHGkbA0Qn+7rWt73D5lLlZ3HuxBzf4u5N5LTJfm4x7qG/J3vCklbJ3lbJFpPjfUGpCqR8i+wkFM4Qs2Vs+tlokwfOTPb0fit4peg67OYG91T0vyKFn6+zkUOWJuHRl6C4BedAGU/Z/IbvFUdNWZsdtjiyMi/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by GV1PR06MB8419.eurprd06.prod.outlook.com (2603:10a6:150:26::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:55:37 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%2]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 11:55:37 +0000
Message-ID: <62a77b8c-6721-45b3-878a-f90f859bfbfe@vaisala.com>
Date: Thu, 6 Nov 2025 13:55:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mux: Add description for enable GPIO
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251105-add-external-mux-enable-gpio-v1-0-e59cba6f9e47@vaisala.com>
 <20251105-add-external-mux-enable-gpio-v1-1-e59cba6f9e47@vaisala.com>
 <20251106-imported-bull-of-storm-8c19fc@kuoka>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20251106-imported-bull-of-storm-8c19fc@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00002BAA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:4) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|GV1PR06MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 81af84a5-ce5e-4ca7-d097-08de1d2b6641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjV2UzQ0aVFhUlBmbE1Ea1U2dVRxT1N3VkhvcWhnazBLZ3hCL2NYSkpkbEhF?=
 =?utf-8?B?bVg4WndraVpadjhZNWlNU3JZaTBpWjB1b3l1N0Jld3RwODgxb3RXQjdOQlBj?=
 =?utf-8?B?Ulk0Q2ZsamV1NDlJSCt0WHJCL1RscnV3NnBGTHRTU01RM3UvYUN1WDZUYits?=
 =?utf-8?B?aGVKaUhDY1RIMXZEdDlHaFZMb1BXYmh4L051dW0vYkZCTEozRitBakJqSDI2?=
 =?utf-8?B?cDVTbk9WRU5xUFlZblF0NzBYZGlrd3VRajJub0R0Y2FORjRYSUZtVU9STmRo?=
 =?utf-8?B?RWwwQ0hwenFxdGJqb3hNMXFJcGY0VnlnZGZGSjFOdVp1S3gvUytNODdNdGh6?=
 =?utf-8?B?NjdiYW1WR1lVcWJOeTRVeUtRazlFUGs0UndYczdvK1hwSGhRSW5CTldNSy9r?=
 =?utf-8?B?RHpmSnNuZWVxSzNFZEtXa0JpenhCdUQ3SW9Eb2dxNGQ3aXRkdU9PcFZIblhm?=
 =?utf-8?B?YzkzWXVOU0thNFc5S1JTb3pPUEtDQ1J5ZTRDU29YWU9mQTBEcTJYb2hMZ1I2?=
 =?utf-8?B?cUJWUmJjWThsZzFnQXU2RkZNdzdYSFp1bXZIYW00VktyZHBHMENTZTZSS2Jp?=
 =?utf-8?B?d29RVlZjME9OSjUvd1pQYTc1ZnF6d2ZPelovQmQrcW8zY2MrdTdmOStLN3Vn?=
 =?utf-8?B?U0x4MWsxTS95b0RuOTkwUWJXbmE0QVcweXdJYVVYM21xMXpXLzkzTkVNWFZ4?=
 =?utf-8?B?UlRHOWduUUFZdk1rUGRaRW1oK0ZnQ0RNTmJuRkZpVVFMR0RJS2NKSldScE9u?=
 =?utf-8?B?NFA1N1dlWEpKa0hJdWFwNXhnOTcwR1o5SFhGeWgrS3VnL2RVQ082aVlZTEhm?=
 =?utf-8?B?MGRHSEd2YVhQbjlYWk5TdGZVam4vbEE1NjV4STBOVnZzcUExZ0VIZ2YzYUxZ?=
 =?utf-8?B?TDdIdzlyYXlza3VxUXQvSGhraFR1bGxqbmdRM2VXWHhoS3J0TUlKbWNpM2Nn?=
 =?utf-8?B?U1FVUkoxRVlvVEFlL0JCcHZxNUVCRGJJODMrWXBOV0wyUWRVK0pCNTMyU21H?=
 =?utf-8?B?cU1OVEVXZEdQZmd3dW9CaXdLNXptZXBjOEgwOTVRSXNvakxOak9SeGZvOGkz?=
 =?utf-8?B?ZXVnSVZuNnorMG9rZEtIWkozVEFVN0RMWGJpVzRXR0xLdWMwZFRhN2QwL2pZ?=
 =?utf-8?B?WGM3bWVjdStod2pRWWVsRVJ4VUdaWm1iTE5TQ1N0eGxuaFVWVnpRaWV2Wkcv?=
 =?utf-8?B?bzlRdDB5VjgxbHllTTIxR2UvWFJzQ0tNNUpyK2krcnlDSHdVZzJWSGtwWXVu?=
 =?utf-8?B?UWFTaVdMdHBVUU52bzBuNEN4ZWp1eEZJN2xWNjFGengreE5jcUVTNk9odFR6?=
 =?utf-8?B?RzIrWDJrcGo5MFl1cnlQTU93V2Z5ZFUwVjVrZk5zTHpxdGJEYlJ5ZUZVOEZh?=
 =?utf-8?B?RGFzdUFOZ3pDdTFTUlc5c0FDY2d3d1Z1QUdHNG15R0ptYnczOUJGWEdYbzh4?=
 =?utf-8?B?UDVpY09MRTNJOWZEQjg5dzZmQ3c4YSt0QnFmNEd3cFZCR2tzL1loZU9WTlli?=
 =?utf-8?B?MFEyQktmTElEMXFEZ09nN0hGajlUTURvZTNIN3A2bmZ2L2F4UWhiWEU0VmZG?=
 =?utf-8?B?MXhMWmI3Ri80UzNYZC9LN0crd1JXVW96bW4yU1JPMWdBeUQ5OURGUHZYc1V1?=
 =?utf-8?B?UGk5Q0pyL0RKZk5ZOXhGSEo1SmxqeFA4a1U4THBhVXBLS3ZPV3FoTVFsQ3Ju?=
 =?utf-8?B?bFJYL01jdXZtT0h0aVBBZTVOUG84K09qMkFwUkdlalVRRTA2U0ZGWlhNQm51?=
 =?utf-8?B?SFlrR1JWU0R3Y2JZU2gyVzZtMlV2UDZ5YkdyZjJvQ3FHMStmU2FCcTYyWkJi?=
 =?utf-8?B?ckdZTTB5aXJXM0djUWRWYlBkZitTUHVJYlVwU0JFbFNuQVppeDhGektjRmph?=
 =?utf-8?B?MExYVWlwRFFlMTlTWDhFNWlkL1B4N0xFR1hjeG12MXV3eXdNTzJ3dCthVWVU?=
 =?utf-8?Q?Y4XgOzv/rge2G/7oAr1HPCtK4p7vYW42?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNLNnU1ZXYwR3dKaHFuZUcwR0E0bTZsLzhvdVpkNWdQOWh2SUlrcE1OSHVD?=
 =?utf-8?B?OVgrZGxrNWphQlczU0ZCSDZGNjJ0bXJQa1lXQkZhUXViZzZjMTRLdHluSWdQ?=
 =?utf-8?B?SDFYT3V4WXJLZU5GRUM5eVhiNCt6TDlXSkd3RGlOeWkyMEcvSy9lcjZ1WGs4?=
 =?utf-8?B?eTZ2K3VSZEsrell1NVd6ZEc1SjUyWFJ4V1cxMzZBV25tSTFXM0VncFh4Y1dt?=
 =?utf-8?B?eDVtNDMxbE5aNzM5eVhmTmtFd0VMTlJRN2tFYVhrOG1NV2YrZDEvOFNPRHdu?=
 =?utf-8?B?Mi9oVkQrWVoxcDcxUEdtdzQyd3ZqZW1ZYjhiZzB6SGF5VjI4Ymhqdld5aXps?=
 =?utf-8?B?Y3BER3A0OUdTZE5pSUJpZC9aSUtHL2E0L2ttS0tiSm40eE1raGdzVTE4YVVK?=
 =?utf-8?B?dlFXM1VycEUxdHdzN01qbmlrMEFNdkhHbDZxcy9Td1A5ci9XWjJSUjA3TXY5?=
 =?utf-8?B?UUFGOCtZa0p4UFhKNUF5c0kwN2pHVzhIbnNVdmVIaGdDRThJVXM1empqd3Uz?=
 =?utf-8?B?SnV6ODJaYndmdUNtQVBUVjdpVGt3ekRVYTR6SjEzUU5yQk9JaWtadVlLMW1Q?=
 =?utf-8?B?Y0c0dHVIRWg0WCtrWGMySDRhQnBxc1JMdjB4ZExncmwzOUdjUE9HR1hjVG5M?=
 =?utf-8?B?emRHbDZFVG5EYm1CZFUrSmZQRWs0VytqVWhqVmFMQ1RlQko5dVZ6Z2I1ZklQ?=
 =?utf-8?B?ZGlNOExOVFVNcUZqTUE5TTBkbzQ1a2djU1V3Z2t6M1pkV0tPaFgrTUlFdlRh?=
 =?utf-8?B?eFF6SGdzdCtpbmZFVkNLdWpCTVcyc0NZenkwZ1d3VmdXRTcxVXZVWWlQQncz?=
 =?utf-8?B?a1RDM09ORWU3SFVJbXJCU0tGUENxQWlSbXZCbSt4UXE5NkV2eUtnaUhZZFpx?=
 =?utf-8?B?bkF5YWk4M21NSmgzL0NNeWFFOFNZeFlLUllyaC8rbHREcEFrZ3ZVa1NsZWYy?=
 =?utf-8?B?ZEVZM3c0VlNrRkY0SjdVdjNrb3BQVnNBT3pJMjdYK0loSFhEWEIyUWJCclZH?=
 =?utf-8?B?QW5oUy91N0xSSTJ5NmtzRy9LTVg0RVFhWjlUTEZaUTJJYyt3T2l6Y1lmUTAy?=
 =?utf-8?B?QU11WkMwWTZXcHlvek9seUpGZ0lvQVVJbStTOUQ5M2VpMnVJcHN0L0YxM01G?=
 =?utf-8?B?WitreXR2ZC9hMHdyZXZjcWNOSFg1VEltUWdMbUFDQTdMWTNPWTBTOE1TZ2dY?=
 =?utf-8?B?aklkMnVUd1BUdWs5V2QzRWhjeW9GeWpORUtZZlBvWFFWQTJVUVRUVWlEY3kx?=
 =?utf-8?B?WStqWkpaZzV3QXVMRW1CSDNiT2RVM2htcEp0a2tsU216aW5iQ29oSEpVYzVq?=
 =?utf-8?B?aWlLbmR1b0J4ajRydndZL0x2cWxueUpaenRyaHBRUVdRNmc3cTZIeEUyVWNO?=
 =?utf-8?B?ekdWcUZCSHJWTmZuRll4bVRKb3RLSmFjR24zMnMyQkI2Y1g3S1p3cUdIWmVC?=
 =?utf-8?B?M2ZaaUh1aVdac0Z6Rk5ORUtsemJsdm5WdVlxczVUWHZUNkVIcUlaa2ZRc2Er?=
 =?utf-8?B?R1FDODgrL3hDZ0JENVlJT05LR1l1bXhnOTlKajJKaUZoNmtNT1UrTUY4NWsv?=
 =?utf-8?B?UUg3cUxjTjJjbXNrb3gralhMOHBnUmJWRnN2RmxiVVpzR0hINUFBS0IvR3da?=
 =?utf-8?B?RzNTcUprTUxndThlZitXM2NOR3RMV0NDQ2wwRFRkUW5naWhwdnlaMi9veTVz?=
 =?utf-8?B?MmI4UVc5Mm91MUtlZWoyQWZQRjZiUFc2MlU1VDljZU00RXV2LzJPOExvWFZ1?=
 =?utf-8?B?N2hSVFBKbU9hV3ZLUlFGZ1B5V0NKdFVQZ3diNldBN2w3dkplNTV6aGIxSklH?=
 =?utf-8?B?bWpCMHpMKys5K1BwVzB0MUl0dk1FSFVNQlZMTzdzMnQ0R2lONWx2ekgyaVNv?=
 =?utf-8?B?LzRITzh2MVUxOTVaclllemszem0rdU9WenVvck1XelQrcEE4Y0xXUDh1QytJ?=
 =?utf-8?B?UCtqdUNMV09sRkZMRnRReVZBc0NrUFh6NXI1Ry9qamV0Z24yKzMzWTFWSWI4?=
 =?utf-8?B?emZUYkgxUlBpL0hzY2dmcncvZ3ZBakM4UW42Z3JLYzRYb2JGbG43bXNiRENR?=
 =?utf-8?B?clBXUFNnNHgzRFpuTWUxUFg2Yld6T1IxMlFWZjBqaE5DRVNWMkd0d2s2T2xw?=
 =?utf-8?B?RTY5bjRYaVU3ejQzK1oyZ0JWM2RUMGdzK3FDM0JOd3JDZnAzbXdNdk1nWW5W?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81af84a5-ce5e-4ca7-d097-08de1d2b6641
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:55:37.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA3ZRLt4l0rBytEj+TFXzSgAZ1cfSeDGAD+S7B3D3YRipOptxmroVzNHfOuYyJFD5b6HyJREVmOewDRXiLJNpEpFOnsjB3az+66OTzSx+kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB8419

Hi,

On 11/6/25 11:08, Krzysztof Kozlowski wrote:
> On Wed, Nov 05, 2025 at 02:49:12PM +0000, Tapio Reijonen wrote:
>> Add description for enabling GPIO-controlled multiplexer
>> GPIO pins, according to the state of the mux idle state.
> 
> You basically repeated binding. Please explain here which GPIO this is,
> e.g. give concrete device example.
> 
Here is the example:
     mux: mux-controller {
         compatible = "gpio-mux";
         #mux-control-cells = <0>;

         mux-gpios =
             <&gpio4 22 GPIO_ACTIVE_HIGH>,
             <&gpio2 18 GPIO_ACTIVE_HIGH>,
             <&gpio2 13 GPIO_ACTIVE_HIGH>,
             <&gpio2 17 GPIO_ACTIVE_HIGH>;
         idle-state = <MUX_IDLE_DISCONNECT>;
         /* BUS_EN */
         enable-gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
     };

> subject prefix - missing gpio-mux:. You are not adding enable GPIO to
> entire/all mux bindings.
> Going to change subject "dt-bindings: gpio-mux: Add description for 
enable GPIO"> Best regards,
> Krzysztof
> 
-- 
Many thanks,
Tapio Reijonen

