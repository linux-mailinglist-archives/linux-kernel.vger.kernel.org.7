Return-Path: <linux-kernel+bounces-720934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAC9AFC245
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096CC3A63CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A9219A79;
	Tue,  8 Jul 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RzrZ3Vx"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C81215F5C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953895; cv=fail; b=l+nnGksdIZmQgDgf8wOILjOrDA/jI3yoS9th6LvCZKs3/zH77/A9Oh+1lJhRsvenstfVlMAkmJKaK1ARLId5vU7XGPKqj6hxommcmAHUqlUln/SCEiVtABK4KKc1hIejpvOH2+lvPCoz/q09L1HrWtnQWCUUtlQRILUd3JAHWxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953895; c=relaxed/simple;
	bh=tWJcCrq1g1+Rc1aL30Iq8ZK2e4nrRofHDmi7U2826kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CT4JxGvGHgznw6HNPxe/YJXXvsA96g+QT17su8VEfHxf45Wd4yLAX/f6gkvX9/N74mqwLWr7Y+M9Nzbk1I8abTrA2KmaVIPM5Wy1LAWAGHU2aL8CpRA8n3S69qn3SUYcdxI6y2ONT+wEGaXC5kHCxhUUmFGIM8f6zsLhOGG/yGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RzrZ3Vx; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huliv3KQDRBqRWRoS5wFK/j/cSRL+ZWLoRNEisUkIFJLomzUS4X7xHyadTxipEZXsfWeR7/dV2oCEKlySW9k1d5X6mgmkeiRDYM2mV2BsgM6h/r8S+GqtcK4aa9VhuC+yiO5aL2/VNAl8EKTFn0WviG5a8PsNZphTVaAtMqSZFrr7cllWhp/REmQmiXmX76Y2XoON8MLRW5RjEcawEjTLBKqlQsxBYj4ZUTeEIU3kgwguetiZ1btQcEuOxwarRRUcsBqFMpzjoSQHnRIiVKykFzFB1vpn6VHcp9nG+3fJaL3VOpb0wE93l3A2DYsHfO9QrVdgXgqaygdeXM74Pw7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/JPYh80x+X9bhHUfuKae896s3E6rKdXto1wHmzXR1k=;
 b=Jwt1bknoifsJNKkgV6e9siSJyo9hDExsikI8nc7anQuqvxshPpHtooTuXgvn3bVJ24v+YjCFjQYefYC9O5xgJNAd1HMXgOEH4xfiebbTP7MisBfN51AYcywKiDduSlxhVjDrAw8skUiE6rKiHx4to4KhzHCaU7ggVfUJzlfXSYduOV8bvw2y6LzPnwKwMifFaCykoyhQ8+TcxB5bGrwhx8h0UM8P+2sn0zTLL29wm2PWLJf9O44IfxfhH6cCsE6qD5JpUj2kfVU24gDeFAUfkVT1NjYeiUE8PAhvv6bLl7j5fItlAFa3fmfNd0siCSz6FL9MWqJypPY1BtaxMjX/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/JPYh80x+X9bhHUfuKae896s3E6rKdXto1wHmzXR1k=;
 b=1RzrZ3Vx9SAi2T/Pbd5XKvfHVBflrI7jMlwc5KqlO/YiKFsIE0mnAZWuj7j5dXFyQRBEr/GNbHJEMX7AVbEp59oVgYXnxb4YloI7RqGFmr1K51KbPEInSFaWyAj2rlFMEhEOMBuxdXPhAGMB+ozEz0izZAC+9W2ZN98InZVtZbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 05:51:30 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 8 Jul 2025
 05:51:30 +0000
Message-ID: <64a06760-e474-40ae-92b7-cd2341261d5e@amd.com>
Date: Tue, 8 Jul 2025 11:21:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] proc: kpagecount: use snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <15f86615b7e4291ad040a64d45e56fd2bb578943.1751914235.git.luizcap@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <15f86615b7e4291ad040a64d45e56fd2bb578943.1751914235.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::12) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: b41d53cf-e982-4343-13ed-08ddbde37cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzRHanF3Zmk0d2xJNzY1WkNEZHJtN0VDeXdGLytmYVMrQk1EVkZzNVp6dUNT?=
 =?utf-8?B?Wkl3NERNcHNnblI1a0FXNm1oMHNudklNeDl3NlVkOVpjWjRBL0tCOVpVeVBa?=
 =?utf-8?B?YXB0TWlSRmFQUlhEMmJnRWVDVXdIdGw2YXlnMUJDRUw1UXY3Q0NtZG1tcHRq?=
 =?utf-8?B?eGQwamFscjRrWHNkMTFHbTIyMnYyQlE1WGdrc1FLYWpZUU1PN1JKQ3o4UnBi?=
 =?utf-8?B?bVViYUYrT2dBZ1ZTZEt4U3dJR3dxdVpxUjBUU0dRTzh4Zzk2WUtucVpFa2hN?=
 =?utf-8?B?WnJVZGNqMUtla1hET1hkV250TVNSSEN0RDNCQXZzbWdDZ1FiNGM0aFZNQmho?=
 =?utf-8?B?US9RUnE4U3FUZ3lZNjhkTmU4ZzZjQ0krL3E1cEtIbHFzcXRocThvUmVKNmF1?=
 =?utf-8?B?VFhLcTVObndzRDBTR2FTa0EvQjFnYjZzM1hUcEFjZTVxUVRiSmdlWWNucHgy?=
 =?utf-8?B?SlBqcS9ZM1BXd2hKSWhZa1dCdUF3bEtmZGFFMXFzUHVXMitBYWkybVRzM2l4?=
 =?utf-8?B?cWJPN09GbVhhZUM3c2VoMDY4c2xCcXFMdkdzRGVWZ1JoRGx6SDNYcE11ZjFj?=
 =?utf-8?B?SVliaytGbThOSmNmNUtBaWc5dklNNzNiQ1hqaS9tNTh0a0ZINlhvZ0JpUm1T?=
 =?utf-8?B?ZDJJQ1BNMklsTi9SUmRRWlR5eXdhMUtzV3NnNVlveGxNTU5Yc3hnb0dhS3Y0?=
 =?utf-8?B?UytUdnNsQWsxQlNaczMweU92Yld6bEcyUExVWjQrSHM1Sm9ueU5SMVQwTWlE?=
 =?utf-8?B?Vnd1bG1zSmw5V2xHTHhkVjZpVlBEaWtKekpma3dTTmxQUkliUjZFL25VT0Fq?=
 =?utf-8?B?NVp0SjVBRGRIeWtyVXZPMlhMZVZmRDlEdkx1YzVGcUNzSjdySG5BeXNoa2tB?=
 =?utf-8?B?YzRvekVyYy9pNEtPTXN1M1lTdXlJY3d4MUtnSjQxVnB3UWMvdG1ucWcydHlE?=
 =?utf-8?B?UkhRbFU1akY5VUt4MndpS24wY0xwcG8xWm1naC9Ib25SMTF5NE9zbktZVUFW?=
 =?utf-8?B?RkdrSUFoS0NGdG9ud3NZQUY1U3NEOVdzUlBuRVlFWXV4Yk9NQ3p2Y01GODNQ?=
 =?utf-8?B?RkxDb3ViWVRMUkRFUnR6NkRjQXdRdGhQME4wT3l0MWxqWExWTFh1UlI4Qjd2?=
 =?utf-8?B?eFF1UUxHUmUwZXc1UVBjSHlxQy9hVURQUmZDa0lPR1VpbFZzcERITnB2VFJp?=
 =?utf-8?B?clhsemVvYTRRMEFBT0p6alc5bEJkdlBhZUhRMXNXM3FKNVZKak5oZm5zb3h5?=
 =?utf-8?B?bVBRSjE4V1NpZnNFcldtc2xUb3NIbHM4L0RIb3Z3YjQreWFuc3pIMVhqNCtz?=
 =?utf-8?B?WU02TmNDVGE5T1cwWlFKNGtHWjZmeU9BT252YjFYWmhLTDQ2NUx2Mm1JUW5I?=
 =?utf-8?B?OWd4QUpCWi82cHN6TVRReUNFdXFzYmdmUWdiTHpNVkNLdVpFL25EcjB4RVZB?=
 =?utf-8?B?SjhncTBWay94bmxLRjBNbDhHeUhDUG9jUGVqcUNqTkNxSlVOeXE1N3p4d1Z3?=
 =?utf-8?B?Q3BZbVFiK3lvS0c1d2czbXVYQXJmWFJqQU9GeDFSWFNrYzQrcU9adkwyNEVF?=
 =?utf-8?B?UGNxL1g2VEdhUmlvZTh5U0VsMkVhODY5ZHVkOTBSamlDL2taR0Fra0paa0lp?=
 =?utf-8?B?d3pubU9hYXFSKzdnbjYrWVNvbHEvQ3dLQXVMZCtTZFA5dEowQ0FzZ09IQ1V3?=
 =?utf-8?B?WGlnbmZWZHV2ZHBrRVByRFl5bzJ5OEpZbTVyUTZEbHJiVlcxM1FGVHQ0Yk4y?=
 =?utf-8?B?R1dKWFUxZGNiRU9TZkFuTnYxK1ROYW5BTUFqcEx1Zm5xUytESjY2R0YveHJn?=
 =?utf-8?B?N0EydVFhVTdCZnZQeWxrSzJxcmNYcnhjNnNxZUlCbDdQVGJaTUttcjNYLzcy?=
 =?utf-8?B?U1pEYTd6K0xOYm1ZMDNNcThhOW5aNVluazVsZjQrUk93RVNoY0NyZytFYk9I?=
 =?utf-8?Q?edY7gYFmJoM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTVCcmU1R1R2R1hrbVJFS0JiYVBna3NnK2Z5U2pWOEpFNE9HN0Jkb1V2MEVC?=
 =?utf-8?B?RGhOcTJpU3ZMUnNnd3dPd2NXVlkvRi9XbnNmN3h3Qmw5aE9GUHE4Njh5RUd4?=
 =?utf-8?B?ZldwckRzN0FQV3FFZ0VBVDBhMzJSNUxUcjQ0U1paU1pWM1I3TmZXbEhHZFli?=
 =?utf-8?B?UHp1ODk1d2dNeWMvTTVweDhTNHluNy9HeDljRG5pTGlTRlNvbTh2VzVrZTZo?=
 =?utf-8?B?NE0yUis5NDNaWkNJU1hWSTErbE5FR0c0RC9tL1BLbFFqR0FZWWVsMCtiVXJn?=
 =?utf-8?B?WnFHREFpUXppZG1HQkNFN21JZlhKY09GUEVXdlM0ejA5eHpCQzRwc2NJOGk4?=
 =?utf-8?B?QzB2cmFRYXV5d09BdWZtc1FHcjVhYzFQRnRERkQ4ZWNSYzIxcWgzMmdxYzJY?=
 =?utf-8?B?WVZWN1F6U3U1UEN0Z1NvM1JueFoxVUJmUVlBYktoRFV6cnJ1dmtuSzRoZURv?=
 =?utf-8?B?QTJuRDJ5YWVoVVUyK1RSdEFKcnFPYzVEVjJXekttbURtTGVyUmFjT1NRNjNX?=
 =?utf-8?B?d2RBUVJKbFRPTTMrRk45ZXlFaEtIWGFoR0JKVk9PaHRWRklMS0lDRmpGd1VZ?=
 =?utf-8?B?b1pmN2pxOXlHQkdzQ1VZYlZrRDFZcDF1RG4wdVdmWCt6d3VhV2VmalNqM2hr?=
 =?utf-8?B?TlFINFIzV0d1amFEQS9DTFBjdEdZUTU0THl0YjVMU0srZ1RNU3p0VG5VUEtW?=
 =?utf-8?B?YTY2M1pPNHVONStaREpMN0FXY1E2YjBIZnBqeEdhendLV0ZzQ3hnZG9KOWhw?=
 =?utf-8?B?aWs2ZHQwNjN6MkhTYitvUjlPdVpMNWxGcXJMM25BT1N2N2gwQzd0aDg4bnVF?=
 =?utf-8?B?L1JaSksydERhWHF5bStsRStiejNrWGw4MGxleTRPTDJNTFZlZmlPbk1SQi9I?=
 =?utf-8?B?SUU1cVZydkhNZzc4ak1HckhRdVk4dEdBb1VhS1pJSjZHWHRpQkVKQm9ZM0VB?=
 =?utf-8?B?VkdmYXhVekhyZUs3bGRTQUJGSTB1aW1kVTZTVDJZM1EvN2VGNHA5WGFwL2VS?=
 =?utf-8?B?YUoybiszV0tyREFvazMxcy9kbDlrM21KeHc5eWwyWkMwSjh0cVBZS0hrOHdl?=
 =?utf-8?B?WlJtVVU2aXo4ZkQ3ZWozYTJwZzdjR1gwd0dWaFNRWm9yK0hFK2lQQzlEN1Jj?=
 =?utf-8?B?ckNybC9FREl3SU9EMFB4ODVyT25EdGFjQ2twSWUrY1AzVlNNQ3hNZ2gxandq?=
 =?utf-8?B?NjUrS0VNZEN4QzE1T24xYjFrQ0xpZGJraVplY2hKUFZ2dkRwMnAvU1JuTFNn?=
 =?utf-8?B?M0RZTERndlZlemdXb2VoWlZqUFA2TXp0TE1vU2RxeFdlRUN4Qnk0RWllMWJ0?=
 =?utf-8?B?TjRad01TMjhKbFd3N0NSMHZXVnZlTnVmQzg0L0g0b3dBOGNDVHJVV2l6Zlhs?=
 =?utf-8?B?NlJ1QTlUODZLR1lOc0lnWVV0RGY3Vy8rMmcvS2lqbEZtNUNJcUFuVDhUcTls?=
 =?utf-8?B?bUZmUWxmZFBhMmNJcUpScHN5YU9tSzdZdjMrZ2grYk5md3RmWWpiNVVlSmJR?=
 =?utf-8?B?OXowV2lmL2xPeFRzS1A4SkgyK2E4NU8rSzkzT0g4Q1E1NGVBNXAwdzh5Ylpy?=
 =?utf-8?B?YU5Zd2o1R2dZeS9TNk5vMDNjL2Y1c0pxSG4xcE9XRTRjQi9WVnlaNVNYbVRD?=
 =?utf-8?B?ZzV6a1NBSWF5aldMcnBjL09KQ0J3RC9YVWpmWjFEYk9lcGNHVlhJMmRSOWpC?=
 =?utf-8?B?cmRFSWNKYVNPWW8xSWNLbWQ0L1krci93Rzl3b3dRdHRza0lIL3c0dFVFNFA5?=
 =?utf-8?B?OU1yUzdIZmRQWVc5dGgvdlYzZzFXYUJ2N2JNQzE5Nm9ETlNnOGdlOEhadVNW?=
 =?utf-8?B?aHA0MU1SYm94ejZDTFR1Z3BDQzY4ZXRtRGFTZnVIMWI2dk1pa3lYdmtGRURI?=
 =?utf-8?B?eTRoeGhLWmlrbW9UazFaRk01K0krNXJ2YnphTU5DSVB4bU9qUVZYejVMeUpn?=
 =?utf-8?B?cTJPRjVqWVk3d1h1NVBoYjNlUkV3VTdCUDZNL3pYWUYzTyttTzg1WjRGVGc2?=
 =?utf-8?B?cVlmTmpvL2xNU1BBK1crVTF6ZTJkeWNQcmtEV3RXSm9LR2YxZlFkcjMxZW4w?=
 =?utf-8?B?aHV5NUE1aG4rS2JSNFdUdG1hUnRGSG9iTkF1RlFGU2xueEFRa0h4SVMyemxR?=
 =?utf-8?Q?oYgMhSNZs3KoDrUF/2gOAvbk5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d53cf-e982-4343-13ed-08ddbde37cbd
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 05:51:30.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4Lq5DZWujRpGemlCEgbLtztL9N6gm0FkDViCk6RqZ5gjj+95eQDfAFd0A6HiEA6hLAWwg+mFUt6IWXLs10Wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488



On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
> Currently, the call to folio_precise_page_mapcount() from kpage_read()
> can race with a folio split. When the race happens we trigger a
> VM_BUG_ON_FOLIO() in folio_entire_mapcount() (see splat below).
> 
> This commit fixes this race by using snapshot_page() so that we
> retrieve the folio mapcount using a folio snapshot.
> 
> [ 2356.558576] page: refcount:1 mapcount:1 mapping:0000000000000000 index:0xffff85200 pfn:0x6f7c00
> [ 2356.558748] memcg:ffff000651775780
> [ 2356.558763] anon flags: 0xafffff60020838(uptodate|dirty|lru|owner_2|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
> [ 2356.558796] raw: 00afffff60020838 fffffdffdb5d0048 fffffdffdadf7fc8 ffff00064c1629c1
> [ 2356.558817] raw: 0000000ffff85200 0000000000000000 0000000100000000 ffff000651775780
> [ 2356.558839] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
> [ 2356.558882] ------------[ cut here ]------------
> [ 2356.558897] kernel BUG at ./include/linux/mm.h:1103!
> [ 2356.558982] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
> [ 2356.564729] CPU: 8 UID: 0 PID: 1864 Comm: folio-split-rac Tainted: G S      W           6.15.0+ #3 PREEMPT(voluntary)
> [ 2356.566196] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [ 2356.566814] Hardware name: Red Hat KVM, BIOS edk2-20241117-3.el9 11/17/2024
> [ 2356.567684] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 2356.568563] pc : kpage_read.constprop.0+0x26c/0x290
> [ 2356.569605] lr : kpage_read.constprop.0+0x26c/0x290
> [ 2356.569992] sp : ffff80008fb739b0
> [ 2356.570263] x29: ffff80008fb739b0 x28: ffff00064aa69580 x27: 00000000ff000000
> [ 2356.570842] x26: 0000fffffffffff8 x25: ffff00064aa69580 x24: ffff80008fb73ae0
> [ 2356.571411] x23: 0000000000000001 x22: 0000ffff86c6e8b8 x21: 0000000000000008
> [ 2356.571978] x20: 00000000006f7c00 x19: 0000ffff86c6e8b8 x18: 0000000000000000
> [ 2356.572581] x17: 3630303066666666 x16: 0000000000000003 x15: 0000000000001000
> [ 2356.573217] x14: 00000000ffffffff x13: 0000000000000004 x12: 00aaaaaa00aaaaaa
> [ 2356.577674] x11: 0000000000000000 x10: 00aaaaaa00aaaaaa x9 : ffffbf3afca6c300
> [ 2356.578332] x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
> [ 2356.578984] x5 : ffff000c79812408 x4 : 0000000000000000 x3 : 0000000000000000
> [ 2356.579635] x2 : 0000000000000000 x1 : ffff00064aa69580 x0 : 000000000000003e
> [ 2356.580286] Call trace:
> [ 2356.580524]  kpage_read.constprop.0+0x26c/0x290 (P)
> [ 2356.580982]  kpagecount_read+0x28/0x40
> [ 2356.581336]  proc_reg_read+0x38/0x100
> [ 2356.581681]  vfs_read+0xcc/0x320
> [ 2356.581992]  ksys_read+0x74/0x118
> [ 2356.582306]  __arm64_sys_read+0x24/0x38
> [ 2356.582668]  invoke_syscall+0x70/0x100
> [ 2356.583022]  el0_svc_common.constprop.0+0x48/0xf8
> [ 2356.583456]  do_el0_svc+0x28/0x40
> [ 2356.583930]  el0_svc+0x38/0x118
> [ 2356.584328]  el0t_64_sync_handler+0x144/0x168
> [ 2356.584883]  el0t_64_sync+0x19c/0x1a0
> [ 2356.585350] Code: aa0103e0 9003a541 91082021 97f813fc (d4210000)
> [ 2356.586130] ---[ end trace 0000000000000000 ]---
> [ 2356.587377] note: folio-split-rac[1864] exited with irqs disabled
> [ 2356.588050] note: folio-split-rac[1864] exited with preempt_count 1
> 
> Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67812fbd.050a0220.d0267.0030.GAE@google.com/
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  fs/proc/page.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 999af26c7298..936f8bbe5a6f 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -43,6 +43,22 @@ static inline unsigned long get_max_dump_pfn(void)
>  #endif
>  }
>  
> +static u64 get_kpage_count(const struct page *page)
> +{
> +	struct page_snapshot ps;
> +	u64 ret;
> +
> +	snapshot_page(&ps, page);
> +
> +	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
> +		ret = folio_precise_page_mapcount(&ps.folio_snapshot,
> +						  &ps.page_snapshot);
> +	else
> +		ret = folio_average_page_mapcount(&ps.folio_snapshot);
> +
> +	return ret;
> +}
> +
>  static ssize_t kpage_read(struct file *file, char __user *buf,
>  		size_t count, loff_t *ppos,
>  		enum kpage_operation op)
> @@ -75,10 +91,7 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
>  				info = stable_page_flags(page);
>  				break;
>  			case KPAGE_COUNT:
> -				if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
> -					info = folio_precise_page_mapcount(page_folio(page), page);
> -				else
> -					info = folio_average_page_mapcount(page_folio(page));
> +				info = get_kpage_count(page);
>  				break;
>  			case KPAGE_CGROUP:
>  				info = page_cgroup_ino(page);

LGTM

Reviewed-by: Shivank Garg <shivankg@amd.com>


