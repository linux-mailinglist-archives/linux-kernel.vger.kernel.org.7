Return-Path: <linux-kernel+bounces-797340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B694B40F05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A947B5020
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136034AAFB;
	Tue,  2 Sep 2025 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjS0xlal"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD32E8B92
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847222; cv=fail; b=ZCGBriXVA+V7wH9hlh2XUULowQLuCvBBIV+o+EOWvzG+/MdhFfxksnS0WUens+//5BzVeMok5eEuZbQ0a6ayVaivkuHJxvIJR+hxaoBTuRgMB4pjpZ69hftlCWq2PNjRe4+pMmwhdVmchGYp//R8ugWAQHWz/7BF4uRXt73TV9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847222; c=relaxed/simple;
	bh=2zcX+HN58ufxJA1v1XbmMGShjdmTZQPu9e9/TRL27uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwwMoMKlcPu1+wq57xCL12l0kmz52oUvm71fbnMLBFcJdJ1hNReE9mF89w1MN64HbY+Bo6+m8RWbt9WDTUi/l/Xmf00om1VduYeDzuG3Ou0n687PHKlQWopJIl9Ltx5lj0fDhmIschDDIJGj7UiychDWAh9nzcymDJpGezQX+m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjS0xlal; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDdi7tndFO0n1SVoL4kCVuXQ7ApMa9FD8d8w15b8qqn/X9a23PsXeuNAg4ZnR4OM/zemFeF+H1XiI2dE2LWFRqJw9F0IejBiODJxHCtfI0+1vWp5iAhcOJs1/2k9pNXIBM++DEcGbixfCEpnFvzaWM9I9+vlCJl1h3KEudgJGGUzU+ZKsDINHux8Cf7TSok98/4eHjQ6XEIqimKsn3gmHK2ACcLxspL7ZpJeHn7WDI/dIN3xJwa8gqGlZdWTF5W+GpPeqhkpJDRVBmIVtAAfnM+MkxxoqZfjmd0mrHryPOdKfdhFyHyetacMB36mwgSLCLdBjvfF21X4Sz3VCusD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SLKgw6H461uDP59KqAWqULogMBuH8qf+/kmkUNiilk=;
 b=YyiDJdMwqATSO55K2AFZ7DfhgfRwBoOGxZwrfIHQwIGRveF9nsC/vIBVUyvwsOgYj+Xyt+EgDIYZkP9AYg+JX6lw61VzSipitElzJdPXUk8a79ZTS+V++CfMqmR2YCLhkwO/7FsquDht+VqobOP5T1ID3h90QkYevIt7qBlfBPJLBLkamttnKNJqoHrgjDQ7Xb0G2x1Rdz2jzRYLCV7tab+J4ErRVTNKqZVM6s8Srx07otBcYSaPbNYr8YG1pdlwuhdn42u0/dIvSidz6yoT5T2js34DSDH6SdEZEgGMmoNIu7f4jBewztq88MOy3jH6KqA+EZkVNa+emGUwSIkMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLKgw6H461uDP59KqAWqULogMBuH8qf+/kmkUNiilk=;
 b=NjS0xlalCOTnw9S3hgb18OicYsvtxjWjUH9SIv0wqmuRGLtuYCT4Bw2fNrE9HPhxH2qlPK31GeS4h7mifY9JY62nRHXgKNyBiYlfZvB+p/uglNFYhPQOf9BF1+HUYuw9hkqpkJ7mZd5vgTUqAkmMU93ufkg1JH0pkSrxhhQcnk09juyRwQ455KoJOe5+X9wizf8FAP/hM6YLsFBIdjjIl+E5y4IoQAknnUW0cAbgYHvMj03hCJ4o1CXM6ea9Bv6I/WWPRjV1j09zIK0W1T0Eow9R/iMYZ6lAgMUG+yn9vY+AmCZsLs97Ix+iiusMRCLJoVgu4z7gYCAHbEkKtB4JDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Tue, 2 Sep
 2025 21:06:57 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 21:06:57 +0000
Message-ID: <84bbc996-27c7-4f83-a8c2-4f88b439bd23@nvidia.com>
Date: Tue, 2 Sep 2025 14:06:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] percpu: fix race on alloc failed warning limit
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com>
 <061405e5-8670-2873-9b6f-0f152863adfc@gentwo.org>
Content-Language: en-US
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <061405e5-8670-2873-9b6f-0f152863adfc@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::33) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5f404d-2f54-4abb-6061-08ddea64a6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVRxY0w2dHY4eGk3RXZsaDJCQ3RMQTFPK3NHaHZFWEc2bk5TdzYyQlpWUS8y?=
 =?utf-8?B?N093WS9xaEsxa09ZOTRHZkl3Tm5jK0VVQU1vT3dDNjZFU3lBQy9Eb0R5enYv?=
 =?utf-8?B?VXh1Qy9FanE0NXdyeWRVdzlvZDlwVmlwWElNM3BNSDRXZFBVbjNBeHpsUjRS?=
 =?utf-8?B?a012ME5tcFN0MndCcVVjM3YySjlYQVRoWWROVHFSV2R3dXBXc2p1UG02SWJi?=
 =?utf-8?B?NUFRbmhPak5MYjRHSld6Qmk0MndwQk0yRHAwenNJaDRTOVVPb1VNT0RHRGNF?=
 =?utf-8?B?cmhSZDFuaXdSRVp0TlpvTkpFTEt5T2lrS2pRcWtUTWpSOFUvenhlT1JpS3JS?=
 =?utf-8?B?WHRva3NJYmVHVEM3dFYrTHIrNEhaNVR2VDA3OVR4dXdtYTBVZytLbFB0U0Nv?=
 =?utf-8?B?SEtNdmRFNVQ3OTgwZTBldk9ma2MveTBBeXRKQ3NhSG1JTnErdUFsVTdLa2FM?=
 =?utf-8?B?Nk5TdVRKMndxZWRvQ1RkYm9lYlk3Y2lha2RvcGliWkh5UmJCRkdidno1WGR2?=
 =?utf-8?B?eHJTcGV0OVV6KzZ3N3gwc3NtN2ROdmFCblJ1RTJQVE9ZSzBGb00xalRyMzl1?=
 =?utf-8?B?MGMvZGdNRlRRYm5wZUJEUGF3MWo1L2pYWitJRWQyY1NIQVFwaGtGNTVaRnZw?=
 =?utf-8?B?WEhWTU5BMTcvM05reXpmZnV0UnhIcXkyQzZYckZYUDZmVFZncXExaGFTNDlM?=
 =?utf-8?B?TmhmRExRanQ4a29CbDhCZW04WXdYRjJNSmNocWNCWjI3NlR1Z1lpY3RNOEww?=
 =?utf-8?B?Q2tZaE9TdENBQU8wKzZXd2NLY3ZOK2psQVljQWdDZDM4WTFETlVaU1lzZVE5?=
 =?utf-8?B?LzlIUFpOMDZXY1ZsU1pKV2cwU3pET3N1czNta2NWZXUyb2N3Vk9NemhqbHE3?=
 =?utf-8?B?ZFZoV0VCSnJJcXZWUXNOSC8yTVBHSVg0MkFIQU84NHJEZ1dJYWZERmE5cUdP?=
 =?utf-8?B?c0wrdjJRQVA0blgwNWkrWk9CV3d6MkxPbkF5MlhUblhTd1ZLbWllZFJzMG4x?=
 =?utf-8?B?YjcydjQxSytndmQxeEUzcTEzK0dMMHFsbDJSOVA5YWlkS25DODF3R2M3YUJJ?=
 =?utf-8?B?U0ZMbEVzeDJKRThwZUJtSEtMb3VMNmRzQkhvMTJkK3hrOWxyM3paUWMvdVRI?=
 =?utf-8?B?UlB0Y2hQU0tFV3IvTS9NYWFkM0crVWZTaGpzaFJodzVDaU1IUDhDUTVrWDR2?=
 =?utf-8?B?TGthMjJrcjBRMW1EQ0w2VzVOSkxjaGFOa1luVUZBUktXakFmZDBIRk13ZlNV?=
 =?utf-8?B?Yi9TSkVXWHJISkk2dFU3N1BVUytyRENDWExDd1Q2Wmh6MzhRc1lZdU1CUEh2?=
 =?utf-8?B?ZHBQcURhVkRNVitpeGtwaUlRNEVTTmlvaU9BUEoyQ0dXU1FUZFJyMHcrcTVW?=
 =?utf-8?B?VDE2WE1qaXlKQXdnQnphYW5IS0ExTEF0aUdidmZKOXJlTk13RWUweXRGaEs0?=
 =?utf-8?B?aUtzVlBpR0tWNmkyK285VG1LL0x2ZGh5aWluYXhqNmZwTVBjMmx3MDBseUth?=
 =?utf-8?B?d0lGZktVTkJpdFdGY0wwa1lRUkxVc3pFdzRZWWFpWEJ4VXlzTER6dFR6T1hI?=
 =?utf-8?B?WmtrVzBvSEgzMTZBM2JEbzlxSUdKWU01a1pyN0NTbFVlMjcrM3BrL05VbFNh?=
 =?utf-8?B?b09CcWNIaUxtTVFkbzZVVEZSemxyTGNUeGZYMG00NjgzaS9sc2lZZ0tuVmZS?=
 =?utf-8?B?L0VoK1dpbE5mUDBnYXp5NS96TERoQTBLbk1FQWpVQnlXalVGNUNhVTBRN1hB?=
 =?utf-8?B?dFBHZUYxdkJiYTVvRXVnbFdnZEhmYnN4LzFKckJCTmc2ZUdlZ0hIZVRlSEQ1?=
 =?utf-8?B?akZueElVemRuakR4amQvc0pNb1VNMUs4OCtDTk92SjhwM0kvNnJmaFkwWGE3?=
 =?utf-8?B?L0lEaUhGUkdrWE5rV3NkczZCMlViZytWdkg2V0NaOXlNTE5TOEtPV3VkRVlZ?=
 =?utf-8?Q?ecC03lzybDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTQ2aDFMU0hJRklpU00zNHF0dHUxV003RG5WY2tDQ0hhOG1BekJqYm5FQ1Ju?=
 =?utf-8?B?d2pDMHRPOXQxNXN4QTk0aFQ5b0plTEljaVp2QTRkK1p0djBsRndoZTl3cVd4?=
 =?utf-8?B?RFpEVnN2LzYxTFYzSVlRN0d0WFREa3QycHYrUFBXQkRjMzBGd1NqSy9iRWlS?=
 =?utf-8?B?V2ZBWFpZa1ZSdzZkZVR4VDBoMTJTZWR1QVgrWHBPa2tKVGplV3RzTWtjRkln?=
 =?utf-8?B?WmpzcDlvWmVyMWY1MExwRjJwVHRiZVdIQ3I4ZmNFMldCcU13c09hYTFia1lG?=
 =?utf-8?B?dC9OM3FIOVZUbWNDTlNpa1h3U0pyUmc4MEZBcHZQSU9DWG5kUWJ5N2phbGNT?=
 =?utf-8?B?TDRSSnJuQ2EzMm9RdEl2QjFmR1N6dGY4SXhmSVdiMGF4Vmw4ODhYYmFEeVJp?=
 =?utf-8?B?ZVVRaHMvcG1iaWxHMlVKNHliVkhOU0RLeko5dnphNDFJcDFhVEIxTjVnUDFI?=
 =?utf-8?B?ZlFHMWU1ZFdjWU04NTZXTjU3V2pKYnFYMFFwcUtuQmJzZVFubGJVZnhTeW80?=
 =?utf-8?B?OXFTYkRoeExkNkdIbnhiNzRjY1BvdHFaK3JoQmhTN3E2Mlc5SzMrRVgvZ0wy?=
 =?utf-8?B?UHVzRmo4RFdLUXR2UGFGNWxGZ284RDBUTElXaEJLd2NsKzg1cm1BazNFSElG?=
 =?utf-8?B?eFdWZFN0dC9xZjZCQXYyemM5ZHdBakJibTZPSi9XblFXa21HWmY3bEtsM2I2?=
 =?utf-8?B?UUk2eWFDMHlTNGJJYnFSWUN5NlJ6Y0J2MXM2aVVoa0M4OEJQUVRGT3VyTEM0?=
 =?utf-8?B?SWxqT2R2VGxtaG5yVWU5cDJ6Slg5K0t4eFBGRHRxNE9WQ2JNb3cwdlZhMm05?=
 =?utf-8?B?aUFRTnVFZ0F4RnlxVEI4MkJmSC84VC9FKzk2dkh6dmJsaU1yVkN5SmJWZmpp?=
 =?utf-8?B?MkhBOTI0UE1zTnRvZzdJZTFqOTJaMnhWNWVmMThGNmJpR0FwWERMSGtIWnJP?=
 =?utf-8?B?ejRrUC8wZm55NXVpTW5qQk82TkFDS1duaWN2TFZhdU9HYUJtT0FvblFJY1Fy?=
 =?utf-8?B?bVNoWmRRTXlpMTBVMmpHWnFqVjE4dEFNQnBGR1l6ekIyaXdTOG9OL2VmWGNY?=
 =?utf-8?B?TUVWbThYUm5HY0d3ODRUUFVlNHJ5bWNtQmg3RGJYNHNIKzVzZVFSbGxtb0J6?=
 =?utf-8?B?bXYzZTl0ZjJPUnRBckdndGxSY3ZVa0lFNC9mRFdCT29XYjgyRFd5bncxaDZ1?=
 =?utf-8?B?Y3dhandrSFBPWFVxRDhxSkFXQ3Q0TzNqeVorTy9PTVNhVVJhTHBaelRreE8r?=
 =?utf-8?B?bllyN3BPL1NrNGJKL2lvMVlQcFFjUGRxODkzczFiVVZYekNabUFHTGZva3Zy?=
 =?utf-8?B?dHliVlRuUTNjSWZBMXp3Rk1sSW9wUi9vd2lEOVU3T2ZrS2NtRjY4V3hwZHgy?=
 =?utf-8?B?Q0FVYW5TaFpabTBmZmozdWozYlgrRnc2cXlNNUdRWlFadFJYUUZFVHVZTlVn?=
 =?utf-8?B?dmNpYkRiSlpzK0RGL0htY2dyY2dkb3VPRGEvSlJTTzdKYW9yNGN6K01taUs1?=
 =?utf-8?B?M1IxWWx0UFlBWHZTNXA0eldvbXBSOVY3RGJKaWh3aFg1SmNhbmVXckEyTzhx?=
 =?utf-8?B?UFl5SWg4RzRIT2kycFVOM2pLZFBQQjRWczB3eHFtQUplcjRxZXhJS1ZpSUhn?=
 =?utf-8?B?T29sbmpjcnZ5NUFpK1B1Vy84UnFleTJRR0VHQ3FnWmZ3T2Zob2hIei9NL29H?=
 =?utf-8?B?SkgwNXExOEhpWGJoNnU2clJZYnNYT1FBMVpNcyttRWhuUWRjM3FMeTNOQVEw?=
 =?utf-8?B?NmxERytFVVl4bkppeEtnR3lGNWp2VEJKRWplbU84dlc5Z2M2eXE2d2k5Y0dm?=
 =?utf-8?B?ZnBtWWtRMFVTNUNKUlptU05zNnFLYnBpT1M1VE43OEViR3lGWDR4YkhJK1FZ?=
 =?utf-8?B?Mm55cFl5NGNBUTYvMERqeStQMEFrMHNPVmg3dGlkcTNxbmpRQzVJeC95V3hZ?=
 =?utf-8?B?QzVDMjBaMWp4eXNTODRGMzNaTHgwS3RkTGJVSHUyS1U4bEtWZGEvUWFnVzdG?=
 =?utf-8?B?a1B3TXBkcTZyM2hleUZ1djlsSHV5MVRpZHVlS1g1K0RKYWMzWUpUb2MvQnlK?=
 =?utf-8?B?c0ZDZkJzaDh1OXA0TnRvQ25hYmdLLzM4REp2R0ZQUFkzVnpodll2WlpvKzhh?=
 =?utf-8?B?TmVYeTlhNFN5RHhWMjhBK09kRlo1R09vVVBhbGpqVlFNUUZOTENUbVJwc0Zh?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5f404d-2f54-4abb-6061-08ddea64a6d8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:06:57.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiJXABx30o7vcwxxY3ZMVhqVxc9HKZc9bvDnuRxVD2P/DdNopYgdFWuKCJXqC+nrYB/lX2BGb6BGxomwnvHrww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999

On 9/2/25 10:39, Christoph Lameter (Ampere) wrote:
> On Fri, 22 Aug 2025, Vlad Dumitrescu wrote:
> 
>> +	if (do_warn && atomic_read(&warn_limit) > 0) {
>> +		int remaining = atomic_dec_return(&warn_limit);
> 
> 
> The code creates a race condition since another atomic_dec_return() can
> happen on another cpu between these two lines. warn_limit can go negative.

Yes, which is why I mentioned it in the description. But compared to before,
it should be benign.

> Use a single atomic operation instead?

Did you have something like this in mind?

-	if (do_warn && atomic_read(&warn_limit) > 0) {
-		int remaining = atomic_dec_return(&warn_limit);
+	if (do_warn) {
+		int remaining = atomic_dec_if_positive(&warn_limit);

Should end up with the same visible result, but w/o going negative.

Would you like me to send v2?Vlad

