Return-Path: <linux-kernel+bounces-821398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A8B81268
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD3F7B0505
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA22FB0B6;
	Wed, 17 Sep 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Px/9vu7A"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020080.outbound.protection.outlook.com [52.101.201.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDE34BA44
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129689; cv=fail; b=L1a2QwTDgNw1bcxMDe25xIGcsTEJNOmG63t09IksH0eoshb6jwFUUuxllE8dNOkdR7Fg3z2BUmi1StEHBv1xJBSYhvyxJUp9PfbdlGuGcDMW6EGaPEfSE5xUleKBIAtdd1ZAVjx+0oxCw9PfpgVFwlTzhTV7tS7sA2IeDx7iCN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129689; c=relaxed/simple;
	bh=Fj9eIN5pho3u0PpQkItri7lAjuDrNKJD0sT7/bylBJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XnSByC7OYjKZ/N4/IxSRMHYHlrz+xqS7fR7D872IROefRrLP5YakZGsVLp5chFcGRcT5Fzbf3+KCBWHNzZsF+9/dN9QAPLknEip7kp7f2gMumFV1gevLfLxGCb0BDWTZTku8+nGyJYQN0Gxgk93DplOc786v1L7TiDklkqM5P0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Px/9vu7A; arc=fail smtp.client-ip=52.101.201.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUEdx7sw0wvq1Q9d9FCzq45cLu/lQ2i23JqDdjCRDvR3IN7wQ63hwImDG8yZvH8nqT/HS84D3xZVhajGfEtzHu2zMP0/wYt+NiCjl9clhuYViZQIkdsQoq6Rbq68at7JYi76UeKeLqad5WLdkLjUq062tGDO4WaL3LptruYLqpIXEZGyrDrC7HPSW52vFzNI3NzqU4ltKOfK9IxBrcYlYk4nerd6FOAMmcMxMJ1VJ+fVmkUJnp+0JXizgGaHT6DQM+CnB+ujE/8eZMTrgKoa3DlwZ8Pl2w/B27nk2i/+IOZucknf/gqMvHaMPH7SyndA/TAfA8d6TRUuUwnpboBtog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPTQNy7i63KLtgIOoL4jPoCuy5OzW6Sq/Y/K1W+Wwvc=;
 b=pESFcxSA6EHRhtHIk8HI6PfvzQQuKvTLp8o1kN+Xuzb/Y57C9btp66Msn8qXJfo5Cs0D9aQcOBF0fmIh6rGRJDGx3zX8M9dwzKLr4rX5Eod7C/AUQN3KCudIAYWqoIdQmYVgc6x+DQohd5voghndcf9sHhamI8Fr1rx9KphOJLy5AjFC0tgTwnXcADV0f8LY6jNyy/ImrJ8pjAkqNhiqPhFP4JrW1rPBJPQlqkNxw7RG3/wlWyieawY89qksiMl3Y87NAYkjjcJQBrVU5u0Ix6671krJ5ttl1f5L31kpfo75bqOm1lizmLopuqG5DE+vySGyD4aIeRw994v9Ss/Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPTQNy7i63KLtgIOoL4jPoCuy5OzW6Sq/Y/K1W+Wwvc=;
 b=Px/9vu7AxfsKlPFeFE+ahkci+qSjEOhNNFvYM/IWgpE7cz5MEQ5KAdqTPLruZNNSPdz6im+56ANQgg+FZjYtye6tKnom5vtEezgqM3NMbql2wUhCyx2Poa5Sq/6gP/TzU129pdsXHHffHufi3sVLDdDwh2AOEkdxLD8XckinV78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB8086.prod.exchangelabs.com (2603:10b6:806:332::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Wed, 17 Sep 2025 17:21:24 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 17:21:22 +0000
Message-ID: <f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com>
Date: Wed, 17 Sep 2025 10:21:17 -0700
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
 <bf1aa0a4-08de-443f-a1a3-aa6c05bab38c@os.amperecomputing.com>
 <39c2f841-9043-448d-b644-ac96612d520a@os.amperecomputing.com>
 <d7cd4004-bacf-47b0-9cd8-f99125e02238@arm.com>
 <fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com>
 <8c363997-7b8d-4b54-b9b0-1a1b6a0e58ed@arm.com>
 <4aa4eedc-550f-4538-a499-504dc925ffc2@os.amperecomputing.com>
 <1cfda234-1339-4d83-bd87-b219fbd72664@arm.com>
 <55a79826-48e3-41c0-8dbd-b6398e7e49a6@os.amperecomputing.com>
 <92719b15-daf8-484f-b0db-72e23ae696ad@os.amperecomputing.com>
 <e86e2aa5-c66c-41a9-a56d-74451df0d105@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <e86e2aa5-c66c-41a9-a56d-74451df0d105@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:806:d0::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b21cc-14b7-4466-9bb8-08ddf60e9fb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi9IV1Z3eFNPSHBpaGtXVmF4Y3E0M2xFei9pR0RZNCthOXdmUGY4c1hPZGFv?=
 =?utf-8?B?b3RwbTJKdS9lTUpFMUVYMzVJV1NnRUtJRFE5SmozQ2JTd000VVNVdnJoZ3l4?=
 =?utf-8?B?VGgzK21xWmx3ZlFQclp1WXNGQmt2c0p0eHp1dmJsQWxkZ0U1cEE5QzBacFdI?=
 =?utf-8?B?eVQ5OTlsZmZlTHZzeFFjMEJGL0ZLeEw1dUsvSExUcWdXa2pQb3J2Yll3SzF1?=
 =?utf-8?B?YldmdnBBUDlQMVFYdklGV1dISjdqL2hyc2JLb3ZvU2JnL0lRUGgyR1kyakZU?=
 =?utf-8?B?a0IweVloMVV4dUdLRGR5Tm1KMmpIVmdCMFluamRrcVZGV001dTlqSExVenh2?=
 =?utf-8?B?TDZqVlpvbURaaVJUdjF5YUxsR0M1SW91V3RBRGd0QitlRno5bWhGT1MvYkUx?=
 =?utf-8?B?cElhckRFTnpCcWtPOVV1R3pRRDljRFJVTGM1VzJwaEVyckhtcWVweUtobzR0?=
 =?utf-8?B?Z3ZKZXBPaTAyUEFnZVJMcUUxK0FRZ2YwZkdrL2paMW9CeHN4WmNpSU1CcVZR?=
 =?utf-8?B?TDZzWlhtdXU5RHhpbFNycklLMVlJY0JVcFVvVXpQZjYyeWp1OUsrR3J6Y3lr?=
 =?utf-8?B?amN4cHFrcXU1QWRWZ2ViWldzbk9UNUJLQTN1bkgrN05wZ0h1YjVUckFkQ0d2?=
 =?utf-8?B?ek8vVCsyeE5DSFlsR0ZSMExrVVlEWE5NeEs5dVcwVlJxN2FuNEZNMWJOd1Jr?=
 =?utf-8?B?TzJ5VXVSRU1aRFpETm9Qc1llQzZEMk5VNVFTaHVzMWtGNVp1TnZyZ2ovUTl6?=
 =?utf-8?B?QzRQTm80NWpMTEhTNkkvZVRpUit2dXFwYjhjWm10ZnJzUk5zeTR4cGVSRGtK?=
 =?utf-8?B?MFp4SS9GM0ZPZnNGditGdEFQTkl0NytxSmlnVFJnUC9Cdk9meHBZaUlLUlpl?=
 =?utf-8?B?S1IzcDFLQUlXa3VLWWVhcC9yc1RybnVXM0kzZnJGVTdFV0VaS0FFZlB0NGV3?=
 =?utf-8?B?czlLREpYVFFmZnAyT2lkUWQyeElRaEhxL3hHZENUeEZ6YTZDK0xvWjk3OUxw?=
 =?utf-8?B?T0FYb1B6SldkTXF3c3dkeWpWTFh6bmk0blZzYUhjVi9FQ016cXBHeVd1Y05h?=
 =?utf-8?B?dXFyQUd6aXFRV1pqcTVkM2V5eG5WTjVldjFWbEFqT1UwVTBoeS9UaHVaYTM0?=
 =?utf-8?B?QlNjR1AwMHIzd2M0dGJGQXVUTUF3aXE5aHloRXcrWEUyODNrL3poN0NvSWxa?=
 =?utf-8?B?S3JkUGlJUmtkbU4zUk5RRjRoTFd5Z1RCWmF4ZjZsVTRrU0Y3am5ER0J6N3p1?=
 =?utf-8?B?d1Z5S1F2OFIyazZvTCtSVDI0S3JoNUJwVGc2bWxKRHlIZW8xRThCNkx4OFgx?=
 =?utf-8?B?M3FUbFpGV1lzR2g1NUdoSk1heHhRQ2loMGZhQzJ4WlZWWmc5VXRCdVVub1E4?=
 =?utf-8?B?T3hiNlFOSUxHMkZpUkNmN0pObUFXaUtLOEdtNTVlQkFZdGp6Skg4NndYV21m?=
 =?utf-8?B?dVlNd1NsN0hlT0Exb29TZzJaYi9wczNPVmZ2QjM2NXNlcWZxVlRiSVhFS1g1?=
 =?utf-8?B?Sm52dStrcXE3WFZHbHR2NEdzNWdXQXZXM1BOR3k2bnhBbFFmcmN1OTU1cVZl?=
 =?utf-8?B?VytsV3N0QkdyYWZEREVuQ3A3U1R4SDlOdmRjRlN3WU9Bd0FSdXNUU3FaNWFZ?=
 =?utf-8?B?SXJ2Z3JmL1BwR1ZCak50SHRTOU1MR1U3NjRvS09BRFNBRmxFNSt6R0R1YTEw?=
 =?utf-8?B?dlVvVkdtdG5pYkd4RGpkZ2s4ZG9tcFZkTExjZFVWVDFLVTNIazhvTVhreTJW?=
 =?utf-8?B?dnlJbWJjWkFraHNiS2Z4dHdZNzlva1orbmgwNnhMMzQ1VnpYOXBaaXdLWWtq?=
 =?utf-8?B?blZnTlQ1djR5OHBZbmdsbjErNmRRcnloVGtnV3RQSGE1eGsyNTg5MVFCK2Vp?=
 =?utf-8?B?Q215YytJWmRYZnd6dFZyOTZ1WTJYc1R2cDJrVHpDd2NDd1AveUpCVnBFTU1W?=
 =?utf-8?B?V0FvVndEQkZadTlYNEZBVG9mRDU3QTVYbGRLQi9hajRUZ0ZIU0hCYzYxLzRY?=
 =?utf-8?B?UWRxY29malp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWxKU3VtMzRCbVZYZUNXbElMTGluR2RrenB0cHlDdUg0WUl5S0JmdDBPd1di?=
 =?utf-8?B?T0dRU3hWSzVQYVpjYjdLY01lUkh5bHFUbXRQVVZIcyt5S2NmQ0dtWnBGYWRr?=
 =?utf-8?B?VENwWlNRNS81SW9TbnJiM3BZcnUvS1duSjhOalhIRU5PT1pLOEwyNzY5dWZS?=
 =?utf-8?B?UDhhc01pVk5yelB0SEYrV3htYjRSZFJoa1pTZG5abk9jbW1BTVNvbXBFQkZM?=
 =?utf-8?B?OEdQOERrS2pkaEdCU3ZIM2dzZENHdktEWk8rVVBwZ2FUWWFkUHV3Nm1rNzZM?=
 =?utf-8?B?REF0NDdsVis5NCtxTGdnRnFzbHJHRHdvem1VUzNKTTZGdks3TlpwMFZpTkV6?=
 =?utf-8?B?QnhNSVZBUUVPQkVwb0lQWHRHUzVwdXJpMWphekVtMjJsZGo5elBudyt4c3hN?=
 =?utf-8?B?VXU5VC9wdnBlN3dMRmZkQUhHOVlJOUhDaW9NYnYxUmdGVytRZjhnVGZYZ2di?=
 =?utf-8?B?enBJVjZNUVJLM3VtOHgweW94Y1pEYjYvak5veWNBM1EreGVnRHM0TDQ2UkV6?=
 =?utf-8?B?dExIZEJRbGVndGtoQmNZdzlXaGIvMHVxUVZoZFdpeUlpbUQySk1EeWxIRFFG?=
 =?utf-8?B?bDVPN25ucmQ1OTZrMTFVOW9rZ2Z4Y3BEMFFROHZubEhyNUF6MVpvdWxOMVpI?=
 =?utf-8?B?dTlZLzZFbXBSbjE1YWpjT0RCNTk0SWRvczBrS1M3VW5oNFBNbzFlb1pNcEpm?=
 =?utf-8?B?ZS9jZUYwV1pycWdiYmtqYTlyS0J1K1MxN0tUc3d2QXdzU1A5NkFicFBoS1ZY?=
 =?utf-8?B?a0lQV2hRTlM5UHNWRGNJZFZpa1ZGTFhRenFOcExPYWwvajBLQWRnNHF5c0E4?=
 =?utf-8?B?ZFVEcXZMMWZVaWRWY0Z1a203VDc2cXFXMlM5YkpwRjMrdmEyY3dlbllJaUly?=
 =?utf-8?B?bEJZUzlhYnVhU0hMdVRJUlEveklvMXJPblFDSjRKQlg4WmUyUVFTRDU5WWFL?=
 =?utf-8?B?ZEFSa1JiMWRjVVZ2VGJTVS9IVVJVeXl2amtUZ2JGaXl5Q09OZEtIVHJwWldM?=
 =?utf-8?B?bkk3RmZCNHo4UmlvQVl5TGFOOU5pUHBmZkhxbjRibUE2Q2trWTVkQ0phdWpU?=
 =?utf-8?B?VzdzT0xxYzk4STZwbmZpSytHakppWmxpNEp2YWowTVlDNXJySkFDUXUvZ3ky?=
 =?utf-8?B?MjBCVGVBb2RMaTVzNjdFK1NwaWFBNDIzcHdqT2J1MldFOUFlb1F2cVpJeWVN?=
 =?utf-8?B?RDN4OHlNcHhSTzM5M3pNdHUremNhb2xWdk1LQmdBMjhxUUFUSzZoN21SdlQ3?=
 =?utf-8?B?eGJJTTNjVE12UjFCazY2OENRb1NuWWdEVjlrV0I5YXFrdTVRZXhOQjhmWTNl?=
 =?utf-8?B?YnhaeHJqVDdvNjZGQWhOajhOVGREWlRjeVNMTFlNZXprcm82SFhoR3RiZVBY?=
 =?utf-8?B?Z0daenZUc3owSmNqdnlGdGFOUnJWN3lKL3NsSWxSdUZEOWI4VGhsYUttMU9E?=
 =?utf-8?B?Q0IzaDFESFBvdEswQlRpc0F2bVpyZ2x5QXZsM2JEck1jMnVnci8rVTFFSk1G?=
 =?utf-8?B?MTd0bTBVdjVFUERKNUt6U1RiZG0vTWlPS1N4YldIQWxjb3hIZGowVFZ3WGE5?=
 =?utf-8?B?Rkk0MWpIME4yNjd2NCtUdXFnNTZ1UDNxVklFTXZXaXdhVjNacnA4YmF3MXM1?=
 =?utf-8?B?eVRmaU44TEdSQ094bEdSVEtJaTBEaXA2MVZJUUZlQk1VT3QrOXJwRVV1WGhj?=
 =?utf-8?B?Z3ZiVHhvbVBWbGlUaTRTWkpwR3VTNUxsNXk0OG5LbVBZQjRLSVdoOEYwTzhr?=
 =?utf-8?B?UExIV3FEVS9jR3dKSStmUjYvcDluRlZiOVN2RFZkeVBlTGlobUlrRzFDY1dt?=
 =?utf-8?B?cCtjOU1nZ29YV29sVmxFenNkbDRDZ0VvZnlSbk9Ldm02a2lTRXZXRkhwdWhU?=
 =?utf-8?B?bmxnRXRmTmlBdUJaZk5vTDRxU1FWVHJsSCtyZCsxYTltL3lYTDBIK1diNlUv?=
 =?utf-8?B?L2pON2x6dmV3c2UrdGF5RldlQmRBMDlBelhuUHd6MXVZbW1rK2RZUEhBNGYw?=
 =?utf-8?B?MVc2TTliOUttcTVvc0JzaFU1aXo0cTI1M1U3S1NxcFA1bGEvcTNFYys0bFM3?=
 =?utf-8?B?aEhXZGdJcTMrTE4yNGFrVUVpZ3RWUTB3TURxWjViWUVMbThENyt4ZkhkTmQw?=
 =?utf-8?B?dEpDSFVENnlHSHE0RjJXSlZsbW5ZaHdlNVBOSnNLNWQrYys2U2oyaktkR2F2?=
 =?utf-8?Q?0xBC/e8WCexsuKKtxfA1wQk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b21cc-14b7-4466-9bb8-08ddf60e9fb6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 17:21:22.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdrD4JixNYoS18zklucas+TBtWIoHCywQ8U1x1yEHWYjkowdoMtrN5IC96zL2gPM4aZhccEHMBeeVeckImmhRO606AKqE4zhhE9G4KAnT90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8086



On 9/17/25 9:28 AM, Ryan Roberts wrote:
> Hi Yang,
>
> Sorry for the slow reply; I'm just getting back to this...
>
> On 11/09/2025 23:03, Yang Shi wrote:
>> Hi Ryan & Catalin,
>>
>> Any more concerns about this?
> I've been trying to convince myself that your assertion that all users that set
> the VM_FLUSH_RESET_PERMS also call set_memory_*() for the entire range that was
> returned my vmalloc. I agree that if that is the contract and everyone is
> following it, then there is no problem here.
>
> But I haven't been able to convince myself...
>
> Some examples (these might intersect with examples you previously raised):
>
> 1. bpf_dispatcher_change_prog() -> bpf_jit_alloc_exec() -> execmem_alloc() ->
> sets VM_FLUSH_RESET_PERMS. But I don't see it calling set_memory_*() for rw_image.

Yes, it doesn't call set_memory_*(). I spotted this in the earlier 
email. But it is actually RW, so it should be ok to miss the call. The 
later set_direct_map_invalid call in vfree() may fail, but 
set_direct_map_default call will set RW permission back. But I think it 
doesn't have to use execmem_alloc(), the plain vmalloc() should be good 
enough.

>
> 2. module_memory_alloc() -> execmem_alloc_rw() -> execmem_alloc() -> sets
> VM_FLUSH_RESET_PERMS (note that execmem_force_rw() is nop for arm64).
> set_memory_*() is not called until much later on in module_set_memory(). Another
> error in the meantime could cause the memory to be vfreed before that point.

IIUC, execmem_alloc_rw() is used to allocate memory for modules' text 
section and data section. The code will set mod->mem[type].is_rox 
according to the type of the section. It is true for text, false for 
data. Then set_memory_rox() will be called later if it is true *after* 
insns are copied to the memory. So it is still RW before that point.

>
> 3. When set_vm_flush_reset_perms() is set for the range, it is called before
> set_memory_*() which might then fail to split prior to vfree.

Yes, all call sites check the return value and bail out if 
set_memory_*() failed if I don't miss anything.

>
> But I guess as long as set_memory_*() is never successfully called for a
> *sub-range* of the vmalloc'ed region, then for all of the above issues, the
> memory must still be RW at vfree-time, so this issue should be benign... I think?

Yes, it is true.

>
> In summary this all looks horribly fragile. But I *think* it works. It would be
> good to clean it all up and have some clearly documented rules regardless. But I
> think that could be a follow up series.

Yeah, absolutely agreed.

>
>> Shall we move forward with v8?
> Yes; Do you wnat me to post that or would you prefer to do it? I'm happy to do
> it; there are a few other tidy ups in pageattr.c I want to make which I spotted.

I actually just had v8 ready in my tree. I removed pageattr_pgd_entry 
and pageattr_pud_entry in pageattr.c and fixed pmd_leaf/pud_leaf as you 
suggested. Is it the cleanup you are supposed to do? And I also rebased 
it on top of Shijie's series 
(https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=bfbbb0d3215f) 
which has been picked up by Will.

>
>> We can include the
>> fix to kprobes in v8 or I can send it separately, either is fine to me.
> Post it on list, and I'll also incorporate into the series.

I can include it in v8 series.

>
>> Hopefully we can make v6.18.
> It's probably getting a bit late now. Anyway, I'll aim to get v8 out tomorrow or
> Friday and we will see what Will thinks.

Thank you. I can post v8 today.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> Thanks,
>> Yang
>>


