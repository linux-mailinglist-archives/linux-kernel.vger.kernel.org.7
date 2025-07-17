Return-Path: <linux-kernel+bounces-734912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDDB08819
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1823BFFED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146328314B;
	Thu, 17 Jul 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="tDzSAu3z"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C41F9F73;
	Thu, 17 Jul 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741840; cv=fail; b=tO5sg/pllsgpHGkx+YUoDt0CnkoMKjbs+F9cuVVuKrHuHJUAf4aaRWLV/EBnfJBcHQQVL5T4NcmCBuLvB1RNA6gRvzC/rRNSAV8U/H0jMRzTjKV9Ce96kkIKOItlcMHrUPcKBVSGI8P3uWRVjqqnoWsquB/AzvbKIpXCS0TeTXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741840; c=relaxed/simple;
	bh=IqzdwjVS70ltsuKnJF3A0vgq7ZRKOMyvZsoo9IKvl4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TYQVMTPzx/4E23r1JPj8gxvn65TLIkxESf/Zy1xaHj/Fvq8/gZi2ORbZJY66J7TKmQs7m6dyJPPG/1gajhkXlnrW/iQXiH0rfy6x054SIko2lfgTirlOg6cm/vdW2vyXzxZLdKBnhFWNjHRVvu9nWb3oESenM8iR2EvwUqsRfDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=tDzSAu3z; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6UCw/bTX3/fmd+v496O0pNsf8NR4K7+9iiY6UhFfQOFXZPO2yBU7Th/IvaySUCfDpM7JRvHv2a769tq/341vdgMT8iycOvSt6n9T76Yld8wR2G9opUqykjEK9FD9mU3VxYuK+X3N0JymELbdeOn2Az7UytUkP9BlQSv+t3s5R2D9fw0y+iYzAyeKR7yO96DkgQNDipSDiIOXACoXn/r3oueaAsxpPg62DtOGEA9ixMJugGxbr7YBcYMCQvUw3ncK6iipc+rRu7OgynvR4Ij5m6A3qeu4hS6+P+dzYsH0YnfTL3tUD77tcaxDYXRi6shX5o4IIRkDX70Bxt9MB+94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD8xJiplt+xx1HxcR8lmUKyCjOCgPQ1/yos9sf4wpwU=;
 b=vSPmhpgWtBdpmWU8YNRlJ/pnstkoZh9ogCUz7EzDs68cDbB65L/8lEARFFFVpSIy5uTmiTE1r9uCg/jvm6V4/ZzW3FiowgJ3OAWGLGBZ6i3xR4jc6YxOH+sqMHzoTxtNUV8ADsE7rPCow+yuX8CXWbDfrIW4QMi6pAD/CnmCiOJspM3PxTojdev8jZn/RDFnlS44lvK9W96iLVVts9R8RxrR3vAdoie/Ax4mFoXl3ovoBWy7F9zcnZlkqAMT2VDEE3h80DBYJVdTPN1HQ8TQyj6iUXKgyOq4/y53uQcWTDcADPD9EsAU2Tp/H2UBw6yuIN1DTEGuhlDWqIxY+4RfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD8xJiplt+xx1HxcR8lmUKyCjOCgPQ1/yos9sf4wpwU=;
 b=tDzSAu3z9FVrJJaq9gaQQY5mDRde6jjRzAi2zraeNDdCQS/4uzi+j1HaTUzaDkdY5DcFtMkbfFUK+FJyVu4bEfAC4fwXFIvq1jsSt+HuI0ug6JdisgZ+4DZVe8z4vkbW1IkpyDe+stGWS7AcbeBCZ4DXbYLFz0ZnWJ52I6GIBPx35kgo2J/g2LT+u/XQCZRpi+QnN3k3Kh2V6HNFeEjXU4DmZ4OkJBUSo2POdJJs7h670EUGULLY1otbEIWwkUC2Ku+Y0LZqTJuBWz4FXns/6V3DuDDOcRaUWQ9Gi+CR8YjAKacXWo1h3hP6lV+/dgz5hQprsAS15JXBCveOEhaBHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by BLAPR03MB5457.namprd03.prod.outlook.com (2603:10b6:208:29b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 17 Jul
 2025 08:43:56 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 08:43:54 +0000
Message-ID: <95fbffd2-2f1b-4219-a366-392b48ee0893@altera.com>
Date: Thu, 17 Jul 2025 14:13:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 0/5] stratix10: Add framework for asynchronous
 communication with SDM
To: Dinh Nguyen <dinguyen@kernel.org>,
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|BLAPR03MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 31022976-66d8-4750-a820-08ddc50e0f99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGxQemRSRTlEZFBIZzRucFNpUVlmU0c4aE9XRTJpdDI0VFRBOXIwTDVFeUtK?=
 =?utf-8?B?MEQ4NXBkWW1kbXdtMW50a0t4TEF2cmhJZEZTN3FSQkJjTTV5bUc1bHJqWXV5?=
 =?utf-8?B?RVJmcUMyNzEvck5VNGwwYU9aY041Rms5REYrS2VNMm1UQ3R4bG16OVRpa0Zk?=
 =?utf-8?B?NzErNnBHcnUxbTJVNmVnR0RVUGJqY3UyaVEvSlFrQUpzcS9QU1FlWVBjY3hr?=
 =?utf-8?B?VU5raWZ6OFRkVVpUQ0NnNHduelh3T1Rod3k4eWdxeWJHclVlSTNGYlduNGhj?=
 =?utf-8?B?TWoxZFp3R0JHdXQ5ZWtIS0IwRzY0YzJvVVdyK1o0YS84aXJWNHJNWEh0aFdh?=
 =?utf-8?B?MEJsZWsvNVc2UGRrWTAyVCtoQm92SzZxVHMvL3JnZHhqWmxkYmM4dVNWeE5a?=
 =?utf-8?B?eGo1VkxrcDJsZklXaFlGTWR1dkUwc1h6OEE1T2g5b1pvNkJkeG9DQnNNcm1u?=
 =?utf-8?B?TEJidU9Lb052NDJZcTdIbFpJdnpCQmpHUGg0VFkyNU03clQyTGxvVWhFS0F4?=
 =?utf-8?B?anR6Z3IzZmF1WExwWmpwS3dVeGZUOEJ3blJHS1BnM29rdHRSNDRhcGV0V0FK?=
 =?utf-8?B?QWR1QTl2WUlvcXBBT0RlbVU0NVVhcTFDZDBBSDJCakM4RW8wUGtuNUhzaEtM?=
 =?utf-8?B?S0N2ZGEwYVRDTmptRWJVbkV3Ym5PUVZsdnRvWVExdGhXaG5jdFVnTWpmT0w1?=
 =?utf-8?B?eTVpbUFlOVJzSlBmKzNvNGZpc3R0a2N3RXFsalRJMTROdjc0em5hSTd4Ykcw?=
 =?utf-8?B?bUQrUk1VNVB3UmF5Tlgza0l6bUMxYjJNM0RocElHclJ3dTVWcHJKblNPOGxM?=
 =?utf-8?B?enR2WUwvRkZtc3pLaGJ3N2lrem5TYUh0c3JjZUVFODJLWVEzTVIyOFVPUmpG?=
 =?utf-8?B?ck12K3pMb3N0b0hLaFRRUmlGMzdGZVh6WU9ZM0dLMkthZDJtS2dOaGFzMDVY?=
 =?utf-8?B?Qy9vY2N6RklDSFlFQzZpd1VscFp0dFY3Q3BSRFh0a09nTkNaamtHNlVSM1c0?=
 =?utf-8?B?eGRuQjVjQlREZk4wOUtJRnZwemlkdnIwUkdTSXRWcmJMZ2Q4c2VrYk5acVg5?=
 =?utf-8?B?UTN0aHNLUG9TbTRvYWttcDB0bDdyRmx2WWZGZWJDRitIMGFreXJuclN0Slc1?=
 =?utf-8?B?clhhdUVoRXI1R1A1c0gxeFluKzdmeU4wdzgxbE1Mc2dab21aYStma21BcmJj?=
 =?utf-8?B?ZEFENFZDVHVzT3dQYlhUbnlnbzRta05lcWRhZ3Z2UURMUkNsZUc0ckZ4Q2U3?=
 =?utf-8?B?MmRIZWNFZFowRzBUMzN6TU1zMUdKZVJjMTBUMzRTbkNEZFJFQS9TcDJKTGhv?=
 =?utf-8?B?TjJkM3A5WjlyZW81VmVFZFZZelh6eC90UitpTW5UN3ZZYUZENzQ2Y0VOU010?=
 =?utf-8?B?bk9oZUxTN1V5M1FqcFdlMDNieXBPSDA0NlBrZFNzUTdXSjZqQUVUcG91UldV?=
 =?utf-8?B?RHNFV3d4U28vd2didnBvNUJUSFRUMmx1SzFkbEpIdi9kMWpBK0ZESS84Rktm?=
 =?utf-8?B?cUEyRW9VZnJ2QTBEKzlZQzBMZWV6cFpYdmVva21YTU1YSGowNXhKZUtLRXlP?=
 =?utf-8?B?djcwWTU0STBEbjlCOXBqR3d2Q0RpOUVWSGQ2WTN3Zk9sa1JHTzdNZW85cTlr?=
 =?utf-8?B?NnNlSms4Nk9hNTBNUFI0THdYOGVzY2NkNFVqWTZoZExRMS9mTW5hcUxaNS94?=
 =?utf-8?B?VzNWMTYxQ2hjYTFXMjI1UUgwQzA5bDdPVDRvSERvdHAyd1d4Ulg4bG14SFFK?=
 =?utf-8?B?T1BzZmduTWhzY1ZWaGNwWnlHeFYvbnhqTXZ2V3g4ZkJrUy9za2kwM3NpUGpV?=
 =?utf-8?B?WENTRXhKTmp3VWMrUTY4b2g1bm9uOEVaUWxWV01mRjZKc3UzS0YwMEdHSmlp?=
 =?utf-8?B?TTFwSGZZc2RYTlVkVzVCSWwveHJHMjJNeDVuVTBZclVnNUFQNFBMaE5FWWhT?=
 =?utf-8?Q?aKDRJV+OfAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE1VT1Zxd3puUUI3SWJRc2VGbElSTjI4L3g3TTFFbFJsWU1ucTM1UW45c0Zm?=
 =?utf-8?B?N3c3dWxmQWpSUDhnVDljR01LdHdISGhYT1g5K1BSMXkyVjZSL1lDQy9DWURY?=
 =?utf-8?B?L3pleElBYWNKSG9Ma1VaYXU4T01SbURZeEQxd3lQWUlsaGhpeGJHVUVKOFNQ?=
 =?utf-8?B?cFNFcjAxVjdlZnF1V2FyZTNCaWw3azRIcDFZcTAwVHpRV200YmU5Q0lsZkZn?=
 =?utf-8?B?NEZvZlVWbFVCVllPUnpSczdxdjVoTEQvalpoaEgweFpZaHpGUjVnWWNIQ1Fv?=
 =?utf-8?B?bVYwZWdHM09ueTE3M2dhUjZrRVdBbnBZck52eXRvYXh1U1NsQWF6TTlmQThx?=
 =?utf-8?B?QWZlZm9oL3pWdzQzdm9TSGlpUGV0R3U4T3JDNmZudElEcnZmUFNaeHVMNVNh?=
 =?utf-8?B?T21xZXlNM1IvZnNnRGdyMmJIS2VrTkc4UTR6YU50R3YwTUJwOE8xV1UxekVw?=
 =?utf-8?B?NnpuRmtYS25LMWZMa3NrVjJKVW5CRmFaOHlzbzJyQmdJSXVqMVNwWHFqVm04?=
 =?utf-8?B?NUpXVmVUVG44eEM3TVg4dHRZT0tlUWN5Q1llbXFZYnoxWDhydkdZaEF2VXJo?=
 =?utf-8?B?MDc0OXJ5V3RVTm9nb2d3SzgvbzV5cHVSVjYwN29SdVVpMXk1MnlGQ1NJS2VY?=
 =?utf-8?B?dytQMWxVK0lsWGg2NGNQUXVWc2NsL0NHdE9ZWjU2b2hDay9kNUkwcytVSEh6?=
 =?utf-8?B?bC9LQ3Z3KzduMFhkeVkvN2dTK3VCcUdBUHBvVFZaNVBXUHZSL1JBa0xWc3BC?=
 =?utf-8?B?WVE1dU53NUNzTEJoNmZTbXFhNUNvZk96ZW1vREtaS3Qzcldad2J5ejdZNDZN?=
 =?utf-8?B?cnkwdnZtNjg1Y0RwaVNERFY5N2lHWmxRcVg1a1ZTTy93L2hyNmhEVUZSQm1u?=
 =?utf-8?B?d05JZU1INDlQSDRoUTZISE5ZaWJ4dWF3c3AreGRLOWt5OVBYdlVsYnVBVmJZ?=
 =?utf-8?B?QWhFVkxOTFlIcjR3UDVqVEVqS1d5VXk0V2FobTBBSVY5Z1FoMzhjWVk5UjM1?=
 =?utf-8?B?ZmZQWlhoVXJxWFZZekVVMVFuZVhldkpkNUNFNXFkdkkwbzVlcDZOeDdESWZj?=
 =?utf-8?B?cmZEMWJpRHpIc0psOVQ5U1d0djNDRHFqVUpjdlY1QlhocTc5VXVmK2tmZE5k?=
 =?utf-8?B?TXpjMW9iekV4NVJJS0ZxTnRjUlpiOHJPT1duOExqSTg0SnhlN0FXQUUwenZr?=
 =?utf-8?B?WHhjS0pETmNxSzNVRGJJY3lsQkJhM3J6ZzRnWFNLNGRBbExKbCtSV0hhWStq?=
 =?utf-8?B?bXlHOVRuV0pYSW1FbURwWVNXRXpWT0xXV2JSTjR6ZStzTXpxbWFmd1VMc0VE?=
 =?utf-8?B?Qzkyc0JnOW1XSTVGb2RHYnY1WjBIM1hyVzRGTTEvQjY4ZTdTTUpMbFE1aTgr?=
 =?utf-8?B?TmtEL3BtL0cwcW9xVngzTDdPZmFxTnhnM28wRll2R1JZYm9PaW1rb0t0Um9a?=
 =?utf-8?B?aWNna1RsblpmTC9mQmVRMkVVaUx4ODV4UUV2NlNBWDA1L01FMnB5MzY0bUlZ?=
 =?utf-8?B?dS9vcUZNcVY1ZGJjQmVKcmcyNmJzSVhVdVYwM2h6U2czNklIby9VaVFSbHQ1?=
 =?utf-8?B?cjVmMjRKcmhlb3Jibk1GNGN4N3ltRmw3QzVhMnNyTit3OE5FUDFvWlRmQjNY?=
 =?utf-8?B?bGVvd2hkajJidGJuQnhhSWw0RTJ2aEhpTnRWZWdLWm9hTnBSY0NSdXJ0Wm5G?=
 =?utf-8?B?RVp4V3VJR0w1S291WWk4aXdsM1psNTdFK0NjcENpdExNekFkckhaMlZBZTRX?=
 =?utf-8?B?M0I5dThVcEtuU2JYVnlaNzdEbUhRTk42anJ4dmFOZE41UVR4WHArQXBqaVFJ?=
 =?utf-8?B?L21IRXFtOVFDUUM5dWphZ0p1SFVFVjBvTngrbWVoQUNTMTJ2NWJRdGFvSWEw?=
 =?utf-8?B?UFBsblhidUZYOGtna3JjWncvWTJrZ2psVXVnakFHaHFrL3ZMdk1DeDVOVHh2?=
 =?utf-8?B?ZmJtK1BSYkZpU1Z2TUt2QU0xSEREdXZmQytEZWQyZ2M4NGY4VSt1OUFXcEtG?=
 =?utf-8?B?SUVnRit5MTdFQllkeG1GZ2NvUTFCMmNCLzJuUjROT0lSSldWbmlkTzl3Y1ph?=
 =?utf-8?B?dWhGcXN2aVl3Vk42Q2Vaa1YwTy9yZkpZZ1pDL0ZRYW8rM0l3eG9palVQWjhz?=
 =?utf-8?Q?AKY/v2Zo4u1Y/NmlSIa5Mwhvb?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31022976-66d8-4750-a820-08ddc50e0f99
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 08:43:54.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwMUyzr+wvWDIfQvbXOmXmp4TU+vL/+SidqAwMM+uJ5uzc1wuuoO2CF0oprpkQwOU1EhW7PjsPfs2EfjDE+tMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5457

Hi Dinh,
	I hope you're doing well. It's been a while since I submitted the patch 
set, could you please take a moment to review it when you get a chance?

@Mathew Gerlach, I have addressed your comments. Please let me know if 
there’s anything else needed.

Best wishes
Mahesh Rao
	

On 08-07-2025 10:19 am, Mahesh Rao via B4 Relay wrote:
> The patch set includes the following changes:
> 
> - Add protection for querying memory objects in
>    multi-threaded flow.
> - Add support to generate and maintain message id
>    and client id for asynchronous communication with SDM.
> - Add framework to communicate with Secure Device
>    Manager(SDM) asynchronously by sending a request
>    and polling for response.
> - Add commands for performing Remote System Update
>    (RSU) operations asynchronously.
> - Migrate RSU driver to use the asynchronous
>    communication framework.
> 
> ---
> - Link to v5: https://lore.kernel.org/r/20250620-sip_svc_upstream-v5-0-732d4ac08a32@altera.com
> 
> Changes in v5:
> - Use FIELD_PREP, FIELD_GET() and GENMASK() for bit
>    manipulation for ids.
> - Bring down probing when stratix10_svc_async_init()
>    fails.
> - Other minor fixes.
> 
> - Link to v4: https://lore.kernel.org/r/20250610-sip_svc_upstream-v4-0-bcd9d6089071@altera.com
> 
> Changes in v4:
> - Added description for svc_mem_lock mutex.
> - Wrapped commit message and comments in source
>    code to kernel coding style as per coding style.
> - Added minor code fixes.
> - Moved variables to the top of the function
> - Removed HWMON support from in the patch-set, this
>    will be sent in a separate patch-set.
> - Added support for RSU commands to asynchronously
>    communicate with SDM.
> - Migrated RSU driver to use the supported
>    asynchronous commands.
> 
> - Link to v3: https://lore.kernel.org/r/20250526-sip_svc_upstream-v3-0-6a08a4502de3@altera.com
> 
> Changes in v3:
> - Changed "Stratix 10" to "Stratix10" in the commit
>    message and in source code.
> - Simplified stratix10_svc_add_async_client() by removing
>    redundant code for async common channel initialization.
> - Fixed resource cleanup on negative path in
>    stratix10_svc_remove_async_client() and stratix10_svc_async_init().
> - Removed optional interrupt handler support, will send the patches
>    in a separate patch-set.
> 
> - Link to v2: https://lore.kernel.org/r/20250512-sip_svc_upstream-v2-0-fae5c45c059d@altera.com
> 
> Changes in v2:
> - Added Reviewed by tag from Rob Herring for dt-binding
>    patch.
> - Resending the patch-set as there is no response from
>    the maintainers for the previous patch submission.
> 
> - Link to v1: https://lore.kernel.org/r/20250422-sip_svc_upstream-v1-0-088059190f31@altera.com
> 
> ---
> Mahesh Rao (5):
>        firmware: stratix10-svc: Add mutex lock and unlock in stratix10 memory allocation/free
>        firmware: stratix10-svc: Implement ID pool management for asynchronous operations
>        firmware: stratix10-svc: Add initial support for asynchronous communication with Stratix10 service channel
>        firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
>        firmware: stratix10-rsu: Migrate RSU driver to use stratix10 asynchronous framework.
> 
>   drivers/firmware/stratix10-rsu.c                   | 272 +++---
>   drivers/firmware/stratix10-svc.c                   | 954 ++++++++++++++++++++-
>   include/linux/firmware/intel/stratix10-smc.h       |  76 ++
>   .../linux/firmware/intel/stratix10-svc-client.h    |  92 ++
>   4 files changed, 1253 insertions(+), 141 deletions(-)
> ---
> base-commit: 47633099a672fc7bfe604ef454e4f116e2c954b1
> change-id: 20250131-sip_svc_upstream-e78d8c9b4335
> 
> Best regards,


