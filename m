Return-Path: <linux-kernel+bounces-768841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB033B26626
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33BF4188F6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924C2FE07C;
	Thu, 14 Aug 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BvTHBHdP"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789492E7BBC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176651; cv=fail; b=j984UD7KYavpEEx7tgAZugtqUZb/NgIyFRmprzTNRJtUOKx98SEMpxX9leQMKJ8wi8pE1FnduOmNTvnqciKkasmY9V4KOOuCN0guZ5f2QSEOp3Q5l0SwwlSoY5RCrXp/8O0ZOw7ZWrUbmfcHCJ90Npv8/hvOmsQ74MtfJeONbLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176651; c=relaxed/simple;
	bh=tMn32fTg5wTlmrqJyDJ8YottQHOw0ba6Avdo7exb7qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UT4o7H6LkKxLJtizQd140Uco09YisOAomDlOtdOKIemVPvDTCtrhlo5A73MDug9cTn7h+w13h0IiDuotpgLht9rQOyUh4+uhEwjkzSZ6GZQRWFWoF92rVbktk3PLWkoTsd2Oh8DXl8j2I3bZiOpLNRWDszjcDpW3k73xn9dJ9sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BvTHBHdP; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKBN+aT4nP02EGaQXNSTmH4eHXU0EpEwV5raO1jiXEnrBPLpYdj03tyImNJxr3W4rGKV3LQmSs6ZXzdEtUJAz0HJPNKTSgDewUaY9ZHKmJk06Zf2BTO4r7bL+nzGDvw1mXpglXUjss+SX/+HrVuvSJaWnkaI3j+/luZw1HVYj/WUqoIRNsHZarIZYSXCkL1jKwBRMn9Q05f9PAat5lg/suG8szVFbJj16ES3aivl2pHMBYdBj8GiBwWmeUB6/wH2NsW5YMDM8N0D1zbmchsAJrbd4gXMzK0q90a1cqvz0dQI12wDnBlkEoN32umX6MmsKcmV87IX+G7W8SgX/Le7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByG3rd199MAi55+iK54XyCOQjZbM/19E40oHHdQcm84=;
 b=OADZ9F7IFLx1G+jTD8XXlneBsVR4WRuvkp7YcIx49MmCLAQ4sWOVcBIqxanA2DmuibV/jJCejxPtxmBgTGNfM3akbWR4AUHylViqJSCAt0xZF5QDp6QOYqjyaylbwvUKv3bavWeKKj6BJNImO9OL5y66Lj1/1JWX5jFahmPvbGvhnnmyOJEQI9ME9Yu/8rEW7HIKkP6cz+t80Oor0P69UWNy5dKgVICds6ymePAHQGYJfwgo5Jbnl0V5WtKJ7rNI8U75CUg6c3rM0IiWx3uBn3K+AMF/aC3SyBoyZ3XdWyuYzGFelGQ40ydy/PcI59ETbxpn/6LUbxti/3ewdEep9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByG3rd199MAi55+iK54XyCOQjZbM/19E40oHHdQcm84=;
 b=BvTHBHdP3usLCQDLMS7LwaKMNg+M1C9bGQ9yNL2IdzOflxrGWUo/B9lyb9oJzVVXijIM2Y1Kp+fDfz4M7OSGLu64Sr69TOP3Idek7Omv4QXKEWiYggzrcp3U3CMh2ah4G2HRdueAkmrMoTc5vGJuF6OUqD4LLpkNwR+9MO5yvPjdtwThYlRmmDIqDJb5EmQizEngjsfcvmcSmqBhvnknT/DKWSZy1AVfLisvU3yNdjU19eJDb4obmiZdgifMyg9MGTtBgEvZwo0sjSFkm1hCBG3p9PtRO+Kbm5U3HNl5hnrJLYbxiA01hRXrAJkRtB2VKhw/Ct52GF3OnqiRiAu5/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 13:04:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 13:04:05 +0000
Date: Thu, 14 Aug 2025 10:04:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
Message-ID: <20250814130403.GF699432@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8868cb21-0c04-420b-a244-08dddb330c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1BOQ1RkLzRYa04reE1WUGNVdUJQelIvdW5VSmRvd0w2REFEZXZ2Y3pmNVhW?=
 =?utf-8?B?N0tBeHFEUFdCYXZwOEI3ZmV6OU9ZQ0FVMTRJNXQyYWE5OWoyUTEvRVdIYTQ0?=
 =?utf-8?B?VWdpZE5BVy9EV0N5UW9yTWZuTjRDNm5idC9PYlhyYTc2eXQvR2tyTkk3dkFs?=
 =?utf-8?B?T0M5cVByZnZiQ0t4cUhkQklmUjZjMk9aeVhFVi9qR2VhNmFZQWhPTFhCNFd0?=
 =?utf-8?B?cW9kdUtnRW44OWk1WnV3cU9SOGhDeTEvOFNuMS9uUDh1YlZaNVF4RnNUZ3JE?=
 =?utf-8?B?a3FJNjl1MTRzOXR5cVBXWW1rWVpveDlhejBvUTI2d1EzaHUwUVFEVStSSi85?=
 =?utf-8?B?MmxId244U2ZlTzdFZkJDRmlQYmQvZDdNNDJOT3FLVUFWT2YvWi9peEpPTzBJ?=
 =?utf-8?B?cHdRMTJZbGl1ZlRwSmdOOWs0TE9PeTY2c04yd2U5ZVA0UFJTR21WdkxXdVZh?=
 =?utf-8?B?ck9rY3dZSExkVklxeXdyUnZnaStDTS8zRWViNUJRZG1mMHdvZTFnbWFhTXJs?=
 =?utf-8?B?UjZXNjhFUVpIdFRuc2hjZ0FHYWF3QjZ2c1pSR0dSTGlHMmUwMG5uUHJLMEhB?=
 =?utf-8?B?b1FNKzdEUGJBZnFHbFVwUVJkTHdNTGNPWnlwaUUydHR0VHkzdHBvRElqZWpH?=
 =?utf-8?B?ekdNdzFZelZlR2F4eEJkSU9INldvVDZKSlliRkMrSDdZNHVoQjZYaU5MeFQ2?=
 =?utf-8?B?RkFYOVpjbVJ1VVpWVW9GeWRLT20xTnE3dUI0eXY4emlMaGVYNmJBZkJqZjFw?=
 =?utf-8?B?SGtxVFIwSTBKL1haUHBGcjBDZ1ZkMTZNK3NUTnNOYmQ1Nkg3a1N0N0FEenBS?=
 =?utf-8?B?YmtKV29qZWJPQ2xDRHA3N3djRHM3cVliRUhUbmZDb3JBeHVkOUwxZ2xoZ0x6?=
 =?utf-8?B?OENuT1JHRGltN3BVaisvaUVBNk85OFUxYzE1TWNSMVk5bzh0NGZtUmZYTUZu?=
 =?utf-8?B?YkhpT293WDlnTkRXWXF3RkdwZVFxZ2kxZVBQbXhvWk0xTnpDdVR3dHJUc2Y3?=
 =?utf-8?B?Z1MwRFlKZGxLQ0JwaGQwSk4yLzkyOE1NM21vRmp5NytzWXlMWVkyNFk3eE1Y?=
 =?utf-8?B?MFFvWEprOFRmcjNkZzMzd3MrS0M3Sm9qK2RMWFVRNkZ2aHJ4K29GeTVQcGdn?=
 =?utf-8?B?ZFgrQ1RLR1JZSnljeVA2VnZDUTUxNnhVYjFPY2VIVVF6Z0lleGdKU3ROVTlG?=
 =?utf-8?B?emVwUDZnckpDMUxza2wzcjZDYlVjTjdKdFFBS3BWalByeXU4OFBpNXNZSVJT?=
 =?utf-8?B?Y3hJZldwK1pNVjFPVVd4UGd3NGgxZGZ4V21hZ09IOFZ2bENZMnU3dGQ2THRC?=
 =?utf-8?B?aldYMG93TVJMOEpTcFRLVFRTTzJVZzVad2lmUHBPWGRqUmVZTno2OGdEaFhS?=
 =?utf-8?B?U3F6RUE5bHRTQnFSRGF2UVcxbEI0NFVpdysvNUQ5UFMzTzhJbGdMMENyQUxs?=
 =?utf-8?B?Z2Z1d3BVc25aK0VhL2JKaVk3d2NHSGF3Um5kNS8vOXZZYVVSUUtxdmNpL3M4?=
 =?utf-8?B?Lys5VzVDc3hFTDBueUpKbGkyS252VmhkNUxERk5GYmxQRElLVUFmcEV6S1hY?=
 =?utf-8?B?dUxGTWx2RTl5T2RkRW1VSWFhZ3FRaDNyZkpNVVNmcU5jWHQ0Z1RpbWhWL1VR?=
 =?utf-8?B?U2RDZHFHUGFZdmhrOC9UV3p2YkUwenJ5MGRudVhBU3kwVDFXazA1TjRIUXJT?=
 =?utf-8?B?dUNVcWNYQStkVUk3TFoxVXVod0VQdm9rVG1EQ2JPc29jTHl4NzRiOUpUYUdD?=
 =?utf-8?B?eTJyQWt5VW9VRmRSSWIySkxxQUg2SllOa0Fud1NLTTBselhoVWEyaXh1NGh0?=
 =?utf-8?B?aU1MUnhNdmRtK0pnaUFUNWRkTXd5UndBakg4R1Fqb0VaNUd0dTNGTGdCbmpM?=
 =?utf-8?B?czBCb3ovNXRPR2JOaWp4OWhZVmNqN2N2YktYMzRyRXRpT2NVc3B1L0dJbVkz?=
 =?utf-8?Q?XNpQdmoVzPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGVMMzhoUDFhUHZzeDV0TVB3elp3VUZtYnpGK1hhTWhsUG1tNWV5akJXclgv?=
 =?utf-8?B?aytaWm1aVklsSC9vL2huOHRWNCtETGpoY2tYQ1JiSllnMVpXTlNOOXV0aEtJ?=
 =?utf-8?B?RlgwK09yRDVkQks3Ry95NHIwTzh6NTdhNk1iaXRTVHR2TU5ueGF3NnhDSTV1?=
 =?utf-8?B?TUZ3cVowWjlUcnU3cWN1ZVpnWmVLRDFCcUZQNWs4Q2p1NnZPelduRE02blFh?=
 =?utf-8?B?QXVLdHdpYzNjMHFBRjExdFRJQ1JEK21rNWpmNkxDVysyUWhNMmpud1U4Z3BE?=
 =?utf-8?B?NDI1QXk1VGsxWjBGZjg0ZUhVdlpOZ29FUnpYa2hlMUJXMFRqVzAwUUVuTzE0?=
 =?utf-8?B?M1BYRWhZcWFaRmk5aW1pMXBMckgvUzBBTTYvd2lXcUhOb2gxcXhvZWg5U2ZB?=
 =?utf-8?B?b05ZdkdOS05BTWRWR0lFa0RBRHlPT0hsdUlBR1MwRG1HbFVoVk9XWmJrVVhC?=
 =?utf-8?B?bFRDTkxOZGx4VGhTc3JMRDNGYkJVcEJWVVR6QmYrZCtETjNRQVEvYy9GT2ho?=
 =?utf-8?B?NGdoY1hQa3g0cC9xOTVZc3ZaYzMrRzRFcE96VjArelZaTXpRWEJodWNMbkpp?=
 =?utf-8?B?WllFbkhWZDRUYklJQVlYVFpmdk9MdzVMYkVEcG51aHg0ckw1YVp2cGJnYllx?=
 =?utf-8?B?c3cwZk1LTm9hbkJoY0NVUXJPeVR4SFVnODh5YnpuVE9Yc2J2K0NYTVJreGl0?=
 =?utf-8?B?bVk3MkJGTkpuOXhldEgzVHo0Ty9DeVhOd3JKbkN3cmp4TDdLa0RrbXMrY1Fp?=
 =?utf-8?B?Z0hxenNvSlpVeExNbW1XRVpMOURuUGkvbzVsK1VNNGd2SnYrSm5zNkVBU2lM?=
 =?utf-8?B?NkcxNTRDdjV6SGRwUWdWclFOZnpzaVdBZWJvaGNjVHpzanNTcGlyekx2MFcv?=
 =?utf-8?B?K1VxS1hXY3RYMm11R0ZzbXNNQTVBNDc3WVZ6RHhrNFdVMzlhdDZPTkR1bWRp?=
 =?utf-8?B?WTRQcTluUTlKbUxia3d1V2FQTHNSNUV1ajBubUlialdSMGNiU2padVBQOUcv?=
 =?utf-8?B?eUV1Tlk0Z3B4NVBNaENVdHFNR3BablN1WVFPUjcxRU12MEo4c0ZWNWFBaHIz?=
 =?utf-8?B?aUNmWEtGSzgwTnVKQUJ3Ny9vdUdKa0Z6cTYrWTZKMS9hRmFlNW1JR292aTVv?=
 =?utf-8?B?dnM5SWNBQ0tWdWNuWVgza0x1T3BsdG5aZkMrL1dSYUJER24yYi81NHQwZ2JK?=
 =?utf-8?B?RjBFZHdxSytvUzZnTWVsajA0VnNwUlh0eVRVVy9qNllmVjUwcDhPWjB4cWMv?=
 =?utf-8?B?Z2VrODUrNDZveVZ5cGpya1FYQkZJL2d6Y1pLa1IrWWlVQ0xDMDcrWW9vV2Nk?=
 =?utf-8?B?U2tmNml6c1RRUmwwZ2NENkVrTkQvUkNHRHJtZTZwRkVIVzdwbEFPLzMvbG1n?=
 =?utf-8?B?QnBPenFZZTNTN210bW5WdFFKQWVrbVBRd2ZacEI4Q0hLd0NFTW84b2crRC81?=
 =?utf-8?B?cVpwdnRPeXBzMmJIVFhtZUtXREdqRHRsUDVNeFUrT1lJTEpEQmFITHlubjVV?=
 =?utf-8?B?cTczZmt4WG5VYUs2Yk5PTnAyZ1pvdU5aZnVPNXZST2k3T0x2a1JlWjNLSlBa?=
 =?utf-8?B?WXI3Q1AwUnBCaVY1blF0QWNubjBBc0pOWVB0Yi96ZDlsdmxLci9Yd0l1WXRl?=
 =?utf-8?B?bFZscnBWT1ZxNmIxUDNoUmtvMHJEREdqOGpmclNDaWF0SXM3L2U2SHhmUS9K?=
 =?utf-8?B?OFVkWmJIc3lsNlhvVWRCdC9CSG01eTdjaWdsZlUrSmRaZkd3TWtpQlBlZ3pK?=
 =?utf-8?B?QzhMZG5jcWhRcVFMempudXAwTW5YWUVmaDgyeFNVcHYxVUl2NU5kR0JYSG1Y?=
 =?utf-8?B?SzdyeXhDNUp3VW1IOXUwVk1CQnY1Q0QrV2toZkNUbW1PZ0NMMW12d012c0Rj?=
 =?utf-8?B?N2xXa3BVVWF0Z2pCaDlzMFhpSkNCVm55VFlEN0ttS3oyT0VBSEN0WkhPeHNW?=
 =?utf-8?B?Ly9VMEg1cnpUdnpRdDh6emErK1RseEpYKzlHTjFmbTJKNmp3QkVUSEtUa1Z5?=
 =?utf-8?B?N1Z5OS9NNmhuRitURXE3T0JzT1FpYVVneGZhYjIyWFdzQU5Za0g2ZENJdTYr?=
 =?utf-8?B?WW81aTR3SVhJblM5WlVFNGo0UDRNekpEbm9vcnBjQXloY0ZQbjB2RDQzQVJW?=
 =?utf-8?Q?GdVw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8868cb21-0c04-420b-a244-08dddb330c32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:04:05.2895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9Kbqh4GtwzWUqXjHctUPFI2O5Xm4+V7fIaLIJjFE6PSbiByHIlVKnMHE5IwAUSz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

On Thu, Aug 14, 2025 at 03:53:00PM +0300, Mika Penttilä wrote:
> 
> On 8/14/25 15:40, Jason Gunthorpe wrote:
> > On Thu, Aug 14, 2025 at 10:19:26AM +0300, Mika Penttilä wrote:
> >> When doing migration in combination with device fault handling,
> >> detect the case in the interval notifier.
> >>
> >> Without that, we would livelock with our own invalidations
> >> while migrating and splitting pages during fault handling.
> >>
> >> Note, pgmap_owner, used in some other code paths as owner for filtering,
> >> is not readily available for split path, so use current for this use case.
> >> Also, current and pgmap_owner, both being pointers to memory, can not be
> >> mis-interpreted to each other.
> >>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >> Cc: Leon Romanovsky <leonro@nvidia.com>
> >> Cc: Alistair Popple <apopple@nvidia.com>
> >> Cc: Balbir Singh <balbirs@nvidia.com>
> >>
> >> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
> >> ---
> >>  lib/test_hmm.c   | 5 +++++
> >>  mm/huge_memory.c | 6 +++---
> >>  mm/rmap.c        | 4 ++--
> >>  3 files changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> >> index 761725bc713c..cd5c139213be 100644
> >> --- a/lib/test_hmm.c
> >> +++ b/lib/test_hmm.c
> >> @@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
> >>  	    range->owner == dmirror->mdevice)
> >>  		return true;
> >>  
> >> +	if (range->event == MMU_NOTIFY_CLEAR &&
> >> +	    range->owner == current) {
> >> +		return true;
> >> +	}
> > I don't understand this, there is nothing in hmm that says only
> > current can call hmm_range_fault, and indeed most applications won't
> > even gurantee that.
> 
> No it's the opposite, if we are ourselves the invalidator, don't care.

I think you've missed the point, you cannot use range->owner in any
way to tell "we are ourselves the invalidator". It is simply not the
meaning of range->owner.

> > So if this plan relies on something like the above in drivers I don't
> > see how it can work.
> >
> > If this is just some hack for tests, try instead to find a solution
> > that more accurately matches what a real driver should do.
> >
> > But this also seems overall troublesome to your goal, if you do a
> > migrate inside hmm_range_fault() it will generate an invalidation call
> > back and that will increment the seqlock and we will loop
> > hmm_range_fault() again which rewalks.
> 
> That's the problem this solves.
> The semantics is "if we are the invalidator don't wait for invalidate end",
> aka don't mmu_interval_set_seq() that would make hang in the next mmu_interval_read_begin(),
> waiting the invalidate to end

I doubt we can skip mmu_interval_set_seq(), doing so can corrupt concurrent
hmm_range_fault in some other thread.

Nor, as I said, can we actually skip the invalidation toward HW
anyhow.

At the very least this commit message fails to explain the new locking
proposal, or justify why it can work.

Jason

