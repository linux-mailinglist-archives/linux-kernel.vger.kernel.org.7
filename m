Return-Path: <linux-kernel+bounces-627105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C18BAA4B58
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CC53BE0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795725A645;
	Wed, 30 Apr 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MM1r/6R6"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191F2475CF;
	Wed, 30 Apr 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016512; cv=fail; b=dhDw5NFAggyrTHEi++mvk1ralQzHyhrBSnpsgTVuRqKOLMZAlKKJHBFh2dImd22TXYYhM3XQYITRJL91/gHPX8u/XxaQF4Gi0tTRJBJz/OTPhUNDYcfUMe5KVzycVMRo1n6lpm4HSwxXVNGNm+DpGldg8jVqeR3AomF+7wPhytU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016512; c=relaxed/simple;
	bh=Y1ndwFP3FF/Ve1/XvbMHDdDnQ3e1nmpSD1Se+fj8qX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DptIWuollEU6C6Ous8umSQoEmEUf+GNWCpNUt3YSS5zLm//ypqG3c1cOlEl1kUxUhyx+lytv9q01Ac5bx07+uCFWM0MnfYZ7XN0/I34RDNlfZZl7v7NZxEWAW05OwJa9rgv0NgbMnlvWtwiSJ2DpTTEGM7dtHjoGV2HF818HlLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MM1r/6R6; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3zNDtd6s0PkuBRbwLqGpYGzvD2YsciPBPodBcBk/5Wb3ejq1chlzAvwjVyXfWmpbFiMcGZwAMSBDp967tEeMCpgvTo8SgE602+ObOBtOlSx86xtq60GA9wiihULOlCL42MzjPVDrcBP66sjOwwA/n4ihtYBT8dTm6cexsw33QrJj4BKePkoiruzjzFyZVV2K4cV/3jtc5uAV4n/M4w9k5vwx6qBrblpcJBsLMhVRfnGSB9m5llPif7t0buUXECZ6aAN8IPcfDQzUg3i4q8lmtuVKevymSLhPR7NsT5kQ6Jq5EtFFv3DRqTXApd7RPinvUxwwzaZKx2VZVazVi9rhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlfzJGkGMDk+B2pOf6cstolPYrThjmY/iPbqMrFsYpc=;
 b=recQxWFSf32ySw3Ztt6uaivGbqFgzYWduy/UIZS+P7Ad5b8J+LxfXjCIKIIr26wII1zHDYZrNpGCL3FBDO8X3cgkHh5p9ed0urm8aMzbgaOWOOcp4qOSJkqNYHo474X/ne8lFoU81uMphHaIJM9YRXLU4CEL4Xl6lcjoVxm3sNzaw0j5SIzJmWMYZwZopFLwffP4PN2wZP7yKLEY0K2OiuUo9FhNqzizs94zbOjOUTbd7gp0VMyRfnDQkrWeUP6gbbS60bcjzxI3iIxjNizNx7c8ouvvJAJOkcJ2AVEJBR6JnD8kJ99vmz689+91ejOHYT0hnQtXdpZeWBnBRAZu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlfzJGkGMDk+B2pOf6cstolPYrThjmY/iPbqMrFsYpc=;
 b=MM1r/6R6KhDYtt7qeZdnSLw6KuvcB60VY5+dzzpGTMo12HT8rGdbAQWYDD5+rpBy2o9+kVWh2BP1g0djDxAkbT3M+b5nKULQlbBFzjMClrdDOaFCSpb0kuJsFbx0lDnPL3HjR6NaM5N1H1/9T2JFbpihoTMThhAcWMG64OznEQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:35:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:35:08 +0000
Message-ID: <8409b02a-811a-4bf6-a4a0-2eb63778a79c@amd.com>
Date: Wed, 30 Apr 2025 14:35:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: remove unnecessary NULL check
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <aBHZuejTTKkdnGaZ@stanley.mountain>
 <MW4PR12MB566769E097E394ED607DBD9CF2832@MW4PR12MB5667.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <MW4PR12MB566769E097E394ED607DBD9CF2832@MW4PR12MB5667.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0227.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 636193e2-565b-4ea3-e9ec-08dd87e370e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2RLRGJqekhGZGcyb09JOTJtTmlwWlR5ZVloKzhrRW00NU00RTk3ZW5ROEFn?=
 =?utf-8?B?ZE9yRXp0dlhBREV4bWM0SmxUWHBDMmU3WCszMW0yeU52aU9VaC9MY3VrZ1Zo?=
 =?utf-8?B?bkt2alRtMjlXTTlJa0dyeGVwajdHam5FV1o5VGxXTEVLQm9OWnBQZzJxMExU?=
 =?utf-8?B?b2RDLzQ2QUkvMnJaaTZEOG9hajhuZEl6NGVnd21KYWQ4bVo1TUZiR2QzaXhy?=
 =?utf-8?B?WTdqdzFkRDlCNnl4RGMyV01uQ1hpeGw1bDdHK2M1dkUvYy9rY0Jlb3VXM05E?=
 =?utf-8?B?STJDZ1E3NzJiL1hYblJUTFQzK1JoM2lJRkZsVVFoaHhWdmhRbXZseExSMFZu?=
 =?utf-8?B?emNVZG5BSnF4NGxHTjBGMTJpTVFsR3BMOGNrWWNIL1B1NmJqUXlReWhJRVdD?=
 =?utf-8?B?bC9HdnhuUm12c3M0RkdUZzVXeklXVlhtTzJDWkdsVGgrWlpka2FENTJUampL?=
 =?utf-8?B?c0xCcC9XRTJsb2hQUi9ZY2xxcDhuVVlyL25lT0JvUjhxZDd3aXRPb1FtNnR1?=
 =?utf-8?B?YjFkdVlkTHRBVVRheTJyRFdzaDk3QVBSSEhaRkNOWHYzMUcrUHdreW54ODh3?=
 =?utf-8?B?ekMvOWlHUGdrOXQ5bmc0aDMzeVorVW9ackMyMTlwdGREUllEVXdmYTlTU2VZ?=
 =?utf-8?B?dGwwOEQ4bnBzcXBMWk5kL3YvczdqMVRTaFN6ekI3OW9UNi95dXJMQXNwd1hz?=
 =?utf-8?B?Y0dPRzUvQ1dRY2kxa1RiR3B4WnFKUjdCZkdnUzJsanRXR2xxWUZjcnZKeERQ?=
 =?utf-8?B?ODA5em9ORVloYmFWT2FQbGN5UCsyeVJvWjlkWDR1MTRHRUhMZE8yMUxMQ1lI?=
 =?utf-8?B?TmMvZWZVTmVIU1Jack9FWUc3M3EvZE5qNTdiaUZYd0Ywejc3d3dmZTRpcml3?=
 =?utf-8?B?OWRDeUwwRGwxMnpicnNoM0pmcG5XSlBFS2VVWmJwKzcxTUZGTXN5T3ZCdW1Q?=
 =?utf-8?B?OTZLM28vV3k3a0dvM2J4OHBCbWh4MHdsSGRXQUlkWEM4YTZnb1lGcmZ6QnFq?=
 =?utf-8?B?R2RlZUFZUU12SWJZWTVqVVEwL0V3NW0zZExES1JrZkFHclpwcEJVZHlXNHZT?=
 =?utf-8?B?T2ZocE1kTUpISEI0U2tFSjhMTDJjRUpreStSdzN3Rmk2UjVPaEVvUmRVdGk5?=
 =?utf-8?B?cnJxS3V0OWlsaWNDUW95TjFxUmNYcm1qSGJyMTFXV2Nuc0t2emY3ZlVBa2I3?=
 =?utf-8?B?VE43ZFR2QUZjcTJvZkwvSmU1Z1JIK0RtWGZNMmJwSmFWU2hJSlpERE10TEVF?=
 =?utf-8?B?a1ViaGE5QVU2VUlGbTNhRGJ2MlNlZXFHalMyMG1pMitxMENaeHNlOVp3bEd2?=
 =?utf-8?B?STVBTVVTTC9LaW16VGJXN1o4UVk3aSs0YklORHdQVlJQZjRScUVQU0xxM0wy?=
 =?utf-8?B?N0d2enVSUTBCQUxDQi9ZRS9veTZhdzltbHljNWt4L2tURVJCZk9YN24wczZs?=
 =?utf-8?B?OXBpRFVHTXFNQk5mT0xrWlpmZEM2dk1kSDhlVjJzYnkyaEI4MklrWHN2SThZ?=
 =?utf-8?B?aUFOSVNodnRKWW4xUEFBcDVSem8rVVJ2eHZEZkxTNWpWbng5UC81bG9pdTlP?=
 =?utf-8?B?NFY4aFRScHJuTDNJMUwzWHAyaytRU1AzK1VxL2RsNGhnREIvN1VlQjVaU3pT?=
 =?utf-8?B?d292bzROeUwyc0NwbDBUZWhOYVE5M25ZL1ZyOFFhWFlBV3RqY0Q5VW5ZT0ZI?=
 =?utf-8?B?VFpQaG4vZmlqekY5WThDQTZxVGM4Tm1FMloyTVlIVzFBMis1L2UyVW41SDNW?=
 =?utf-8?B?S0FWeXdTdTVsaWJHVExRZlFOdDQrNjBMQmtjaGdNMGVHL01MRVVHd2JPZHBw?=
 =?utf-8?B?L1RndXhXdWlldEpmUFVzUzl6VW8rK2U2Nll0RmU5YThtRXVGUzBYSDBjWHJz?=
 =?utf-8?B?UGpzMVZlNjMzTEdGMkVXZG5RS0VFRytBZmlHNlVrdEhVZFVRMmdiZ1VsM21Y?=
 =?utf-8?Q?p/JIVY/zWJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVB0Mi8wYVhWaWd5K2h1akF5alFnMXFicm9tK055YVYwdTNKOCtwaHd0cXRB?=
 =?utf-8?B?bm5ZaGIza29tb2lpQUt3cXhma3Y3Q0lib1B3eEhiOHNvaTh0MkI2eHNQYnh2?=
 =?utf-8?B?THRaekVUVzM4clFNZUc2ZFlnMHZpUHZSTTZycjFzRFp1ekpZUG02cjVWenB3?=
 =?utf-8?B?VWlXdGpuQ0hYWUh6OENWRitrVTZNcXJjU0UzNHVTMHAwVlJ1SERFRjBmOUFS?=
 =?utf-8?B?bkdRQ1Y4YTkzOEJpdjEzQ3hEaVhlUmZJRW9kb2IydE84cERiOS9HVnJvYVZK?=
 =?utf-8?B?WVhRRklWZHJoVEZ2NFBBYk1zUVcwRlQxNWRMLzBXRmFYcHA2cTdCVDBYQ2J4?=
 =?utf-8?B?em1kN0N2VFUzeXNLYXlDOEFGMnFwU2dzaCtsZmRhbE12RHE3RTJQRlcvWkda?=
 =?utf-8?B?UVJ2ZW5sT05ueGk5MXRlbXNiT1dGZEdWYkkxam15MVBuQnFtcTNNaURsQjVM?=
 =?utf-8?B?elUyR2JIWW9ITjF2ZkdrZjNIMWxKbFZkZG9ta3FPWFBiOWdmeEhyUzFPaVBx?=
 =?utf-8?B?K1lkYytpMFFIdkRzam9oNlBnVkwrMzdNa3RCdmVLSm5JNUtrL3FqeHlwbUhz?=
 =?utf-8?B?OXlyc0RRdzNaVktyMTdIOWNnK20xV1VyT3dEcG5kQm1YWE5hdU8wbFYxKzhO?=
 =?utf-8?B?OGlqK2dMYzBUWm9VUCs2WTQrWWZNQVd3d2F5c1ppNjVLblhJUWd5dWdMc09x?=
 =?utf-8?B?alltajNybjM2UzNvTThtWFNJWmoxUGJFMlliRWY0SllBOUFRd0x3SEZ1QXlS?=
 =?utf-8?B?dko1SkdzMWlWQVovSUJ6OUc0b1NKTGZDa1FIeGtpZ3RYU3JvRFQrTzVBUnNw?=
 =?utf-8?B?d0pJQlVwdFVRTUFOTHlyK3NTQ3Q1SVlYYUJhVXpKUE1RZVVVUEVwQkI3c0pZ?=
 =?utf-8?B?VnBCWmNLZG1Hd1Btdm1BVUFEL3BWRlpMUms2a1hMWVZjdXA2YVl0YmZsbDVy?=
 =?utf-8?B?ZWRNSUV3d29zWWIxZjA1aEdxNjBWU0JiNlhkUVhycmg2enpQVThjRTgrK09p?=
 =?utf-8?B?SFhSbTgzZzNXbi85Tlg0WWIzZUVkUXBmUXVUTTlUbkxUeXowR3ZoTEh3UEdO?=
 =?utf-8?B?NW5QaGswZUNHQzM5eGUrZy9UZlpLaTFiR25Xak16bENIWTZ6OTlxSTh4Mnpq?=
 =?utf-8?B?Qk1ZSDNvZEZMTmNySGozRGQ1MmkxU241eDFveFdhYnU2YjB0dzJGaUg3RzlK?=
 =?utf-8?B?Q2ppaXg1WlVGS2NTNm00ejgyeHhSTmhSUjk5RThDc2FLYnFhbTlOQlp2Zm55?=
 =?utf-8?B?Wk5idVpYZWIrdlRvbk1IaDhwZlp4L2VMQjB4bytSZGhRcGo0M2wwcnZkY2N2?=
 =?utf-8?B?ZVpRVnFObWNpOWFaMXNXRXNIWjdUaXFWYlFoWmp3OVVtQ2QvN0N5THA5ZWd4?=
 =?utf-8?B?UGdEemZSaVFlaWdsWlZadGw2THJOcXEwTlk5Qi84OXAxSVRSL1RJL1Q2WSt2?=
 =?utf-8?B?eE94TCsxNkZTNER6M3pMK1A0OERvMnlLaHp3T2poYUwyTHM2K2tUV3Vab04v?=
 =?utf-8?B?d000TnRadUtNY3Z6T0xtRVZoU3dMYTBxRFIzQ2ZSTS9RZ1RSLy9CdGtEbkRM?=
 =?utf-8?B?MGJiZ3RlaUhLRzVBazg1TksxVlRRb0tVc0tRb3NUTFVLUW94V3pXY1FtZ2hR?=
 =?utf-8?B?VFRkMnpDM1NRSWczWHRzRkUwVnRiVFgySXZOQnZrYklYUUxZRG9YUWEzdmJC?=
 =?utf-8?B?d2RVYTNUallRZGt1YzlnaDZZUkQ4WWdoNWdqYUFTK3NBN3hhTk1XdDFQZkJX?=
 =?utf-8?B?ZTZGbHAreUVQK2h0SDBEUUZNb1l0RkpGNFQ4NFpJUkIrT29nS1B1b0ZoNThK?=
 =?utf-8?B?OVpFWWpBRlhtMVdqNlNQbU1DTkxvelZtRnlrOVAvS3NVeFp1eDFGSU1EWjBi?=
 =?utf-8?B?b2t6VkJxY281eDU1THNiWkJhaGc3QkVzbHBJNi90a1VkUTFzc0I5SGE5NXd2?=
 =?utf-8?B?bzg3akhFakRZaFRIb2R3Q0pMeGpyWGh2cFU5ZVZYcHc0emloOWJHaEs0cGNa?=
 =?utf-8?B?ZWE5b05xUDZOdll6YUI5VDhmVHJiTy9QS1AzUW9kcDZHbVBUdC9Jd0k2Mm9q?=
 =?utf-8?B?ZjQ2Qy9Nc2dWQlpLUmVTM1JGOVZjeDgzR0hwdnpPMEdmRnh3UDNiK0tiVCt1?=
 =?utf-8?Q?mUUrjOc5eF75ahGp7glRLYyRH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636193e2-565b-4ea3-e9ec-08dd87e370e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 12:35:08.0647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPVEnD9GLSwFV8L3IAGsszoJ3RZpBc6Tb4OkC/5Cm3jxdFDQvIRydzwBWf+vn8YS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

On 4/30/25 11:28, Sharma, Shashank wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> 
> Hello Dan,
> 
> --------------------------------------------------------------------------------
> *From:* Dan Carpenter
> *Sent:* Wednesday, April 30, 2025 10:05 AM
> *To:* Deucher, Alexander
> *Cc:* Koenig, Christian; David Airlie; Simona Vetter; Sharma, Shashank; Khatri, 
> Sunil; Yadav, Arvind; Paneer Selvam, Arunpravin; amd-gfx@lists.freedesktop.org; 
> dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; kernel- 
> janitors@vger.kernel.org
> *Subject:* [PATCH] drm/amdgpu/userq: remove unnecessary NULL check
> 
> The "ticket" pointer points to in the middle of the &exec struct so it
> can't be NULL.  Remove the check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/ 
> amdgpu/amdgpu_userq.c
> index b0e8098a3988..7505d920fb3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -631,7 +631,7 @@ amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>                           clear = false;
>                           unlock = true;
>                   /* The caller is already holding the reservation lock */
> -               } else if (ticket && dma_resv_locking_ctx(resv) == ticket) {
> +               } else if (dma_resv_locking_ctx(resv) == ticket) {
> 
> Its a Nack for me, There are a few situations (particularly during the first 
> launch of the desktop, and also when eviction fence and new queue creation are 
> working in parallel) where this ticket can be NULL, we observed it during the 
> stress validation and hence added this check,

What that maybe before the code was moved around?

As far as I can see the ticket can't be NULL any more.

Regards,
Christian.


> 
> Regards,
> Shashank
> 
> 
>                           clear = false;
>                           unlock = false;
>                   /* Somebody else is using the BO right now */
> --
> 2.47.2
> 


