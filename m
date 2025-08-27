Return-Path: <linux-kernel+bounces-787942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051CDB37DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE36F460D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCF338F26;
	Wed, 27 Aug 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSZB5usv"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29F3376A5;
	Wed, 27 Aug 2025 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756283442; cv=fail; b=EgOJJQ/H7NrMZhX7f2kCDWn6yQhbxkL2L1TrNOpnwwPsZ2pEzucE7kDC3sxus7iVlWF9nvPcQLxOqxrT+ApoZHYf48co2NpFNw/sLLMzCjYFiQX0i0hJwCHADRTOnsVvtYSOT7sSVeoJQFojQ54sf3JcnMCTKTqjB4ngkU6hMO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756283442; c=relaxed/simple;
	bh=tOcTeDToszv4bsoXcJkS2E5GHPYwWNCXTtv/4jTO7Yc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ZMLAYuqdcvKT0n0wGPILIbM+KdpSuSu/GzsVJI39TfFgkKZgzHO1qn5CY8R+UttlqcmH1Obtz2p19G+Baf/X9qYOgR1X5mcrSnp8OdLFw69YLUbx5kl7CrrTO6rrXNyUMPyOaeFI/oUmdlFytBf4sI5hfY6+tkoLQ6bMmIHVAm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSZB5usv; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuYJ1VBoWlt2+jh1o5yBtM9GM7/0XO6Cl0ql5I0dBy3yqgs3a2IGfE+6rTHdXFQlChWwPAAkxo2UYGimGA72zEK8VkgGFYuLzKEN9pbwFemp3n4bMVTBOvwh8AYTtFj62yvJj+YziywEoOp+W4hHsc2cfddALIvPZ3FdSQv/GDLyaxbRlFWocWSaPGF+5jnkWxdQO98/LUhw307Q0M8ijRnnMd/g91uinEYGpj7NM9FSuYz8NJkAb+uHj3tgRnxf2hE9k62svP+uIbx7NYB/iLFj6Ba6PHXYDC7Wk5Jvk0FokKBPMySRfkeHdfF8YjYzcGIqHN1imWqF7bKU58TBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl0ePpfnJghyx9jt0OWKnad+UdpPth8PjZnxe4RFoW8=;
 b=SJnFa6q0n0mYYmeK36iFKGXx3AOU/yZWKCO4Ec34KC59mI5aSSPgNbeMthVUpiVmIqvwoFelw0zXs++HsySE95Fj/nnH+TYNtA9XUCX43Qky52AqSBbJEyTNG6bJhQfAPq9yieP9v0Lxhm1+pN4Rr6CmJdd9UYHgjGMO125ePRf+PskCNtjb2/k6CIZgc+LhRgl9HCHfJZVH9HI2PSwBQlMEB8S0xILp5XAPT/RqRH1m1WHrpi0vNYpXCLdF3LtEO8tU2NLHYBTOj8bgujeCewQ3nemJgXJEVsu/fcmsFt1+p9ca+QGmSNGtye6ttE4IOH4rN7OOAkXNaIDg1mrHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl0ePpfnJghyx9jt0OWKnad+UdpPth8PjZnxe4RFoW8=;
 b=pSZB5usvPfE0dk3A8QO0JPVt3ksyAuk8Go7Y015pOBTmFSRmw07thcSXiJ9cailMUyPSDmTA3R0NxtKwZePbpTFkbZKmRpeqFrKHYd66IKEda06PKgvLXnwdc6+mOQ/oSRpMCqtfqA8HJeTN6yqom5GVlj60vqUr7rXiy5/ety/ZZ8Htfx/sald7qKwWArRvXK2uvoWAJZu9zL+VrmqavKngM7sfMyQzeT7DEmJEm2U0jLKdFKp1lDzIYFcvPev5xmSRzXgOuGaAEFSIxbxI5yRaw5F6Gd5HPUpz/GA5Wb8jWAynWU3HSqK90/7kDUn5/8TU1+UYgC0rRG1XQle2+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 08:30:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 08:30:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 17:30:31 +0900
Message-Id: <DCD2IM4THRWE.4M1IQTEWX6G8@nvidia.com>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <DCCFOGR3BPVC.3OW6B74N372MB@nvidia.com>
 <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
In-Reply-To: <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
X-ClientProxiedBy: TYCP286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 975dfdba-0c4b-4efd-7ecd-08dde543fe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak45ZDV2ZnlpcUEzc0pBZ1FTbUE2TkltaTl5ZVYxL3VQc3A2NmpyVk9MV2RI?=
 =?utf-8?B?d1JBZnBEbWRBQ09DMkhDczRqL3R0QkxjVDVsL3Q2d2wrQ3pZdlREVE1TRjdN?=
 =?utf-8?B?dXJ6dkhXQ3lHRkg4aDdoSzdWZElNbmlhUzk2WDNLWVVoWThPelBTYWtMMEtr?=
 =?utf-8?B?Y2h6LzJOVTlVNDNIZVo4OFVxYkkzcjZOaklpNzN1RitiUW8wMHIxUk83Mmlt?=
 =?utf-8?B?OUt2THozaG5rYndSN3djS29yQlo2WFlHazZjcS9GTlRNUXltVFkzN294Yzh1?=
 =?utf-8?B?R2N3ZVlDenEvZW04ZVBkay9kbWRsV1V4b1IzRWFQcXFwdnJwU1dWMzVlb0Q1?=
 =?utf-8?B?cjhnSWk1NWtBb2ptWDRPUS9XWVJ3eFBadHZmZml6RXdJS2dlUzNmdVg0aktt?=
 =?utf-8?B?Q2V5WnVrekdZUWEyc1hSbFplZTNPSGtJZ2FmdUV5a0MyZTVqOVBOV3BkZTZR?=
 =?utf-8?B?N2xjT05tR1NXNnJ0djNmdzYrS3ZMRSttNkQyM3I0bjNZWkRlZTRXTlNTWnJO?=
 =?utf-8?B?SkkrN1JPRHdvYmFrUmY4NnllR2g3QUVtTldLeVdzMU9IakMvb25neW40QjRa?=
 =?utf-8?B?Tkl1ZHBSUTJJSkFlc2hVVXlFemtSd0lqRUo1a1Q4M2hJbWxKS3BtdHViQk5v?=
 =?utf-8?B?b09qeWFxS3dEdW0wU1V1TlM3YXRKVEZSOXMwYkFSQkI3bUpqcU9NOVJ3eVlh?=
 =?utf-8?B?eTBWeVVjMWw4cjM1dnZWUklEZjduNVZhWWFSdERHUzBVR0FsTjdmQldaZnky?=
 =?utf-8?B?QTVCcnJzSlRWUkt0MTdZb09sM3ZCSHUvWTN6RVByWklOMU42QTBTQXNkSm9t?=
 =?utf-8?B?Mk1uNEIvSXlYZElEQXlVdk0rNGU5VWxaZ0QrZE92MHIrekVVQ21uUExaTUov?=
 =?utf-8?B?SjVMUnRHN0ZVWm53Uzd6dndXSUZWbXVnYkZZdVNYVk04M2V1MzRJMlRVZWk1?=
 =?utf-8?B?aU84ZEZjSFprWHB2aU5EY2MzcXhhTU1BdkphdUwrVEx2RHJyN05EbTJpWnkx?=
 =?utf-8?B?elhaL2E5L2s5OE14ZE5mUGJmNTlCZk1lazk1eE1Ddko0RTdmSkV6TGN1ZnVa?=
 =?utf-8?B?TklReFRaRldvRlh3ODlhLzdBbUtyd1J0QVVoNnRlbFdTNzBsK052Q2xKN2RR?=
 =?utf-8?B?TS9hdGxZanFRVmZ2MGUxUVNEMW9JdGVQbWhzQzB1aHBVVy9RSW1LMUd6cnYz?=
 =?utf-8?B?cUFITE1mR1QzbUxiUVVjYkJUZVJKN1FtTFVWeU81ZFdtemhzeit4V2FRWkZm?=
 =?utf-8?B?a3Z3eGsvOXpaR0hRcHNBdVIrMjdHc1BGa25XWTh5d0tMQkxMWkFxQ1NWckJy?=
 =?utf-8?B?SnVnaTd0QStlNjgyamloVXB3TlVUMlAwTU5MenhEc0x4QS9wZkR5UWpqN0FE?=
 =?utf-8?B?Wk5yS01CTVAxMGdyWTFmV01xZ1FMY2h5RzNvbzMvZ1ZubWpMcGwvdkxacEVT?=
 =?utf-8?B?RzdVSFRqeXYyMWIrb2ExWDBVdkhmUm8wckNrWHNkZUZURmNaaUkxS2h3a28r?=
 =?utf-8?B?bnNJUXF2eVU0WGdhdnlJNk1rbkUyNEVTSDFzZUFlb28zV1hnVU5zZ1NXaHYz?=
 =?utf-8?B?aGsrS0k2cE5HSEpHdi9WNUdJTnF2ak5rcGd6KzJvVlErTTNoRlRiUmNqSlNu?=
 =?utf-8?B?TnJWQXdTUzlsdnhqd2hlVFE1TU1ndW1LZk1QazhZMEVPY2RNUCtIVjFub0w0?=
 =?utf-8?B?c2Uyb0RsVEE4bTJBbk1uajhUd0ZYQnBYNE1vZVZVS01aUzdwUElIc3RqWjFq?=
 =?utf-8?B?Yk4wVlI1dzh6VEUwcXN0N09RSUhHQkdZcUd1R1pGbjJWbVRhNVEyNUxRUklk?=
 =?utf-8?B?Zk02M0FTeS9kazhieldJVFVUUFplWnhIQmhSUGdHUUs5QTNDcUMrVzJTTnZU?=
 =?utf-8?B?d3pNTzg2WjR5TnJxTTF1dFdVMWk0WG5WdTFhOUFJZEZrUkdhWnlZcU50VHk5?=
 =?utf-8?Q?IkQSk5nvPpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0lUSjJldTVTVm1leHN1QWJnTDBqU3QzMlhXM0xmRXEwNllZbFZWREhWSHho?=
 =?utf-8?B?S3FOR0FXaG5jUFczMHB5d1dIdUVJWE5ZY3VRWGFGazlPOVhJcGs0ZXh1MUNB?=
 =?utf-8?B?eFdqUTlrNjRiSGZlaWlzZEdwaVBuOVFrT2F2eXRPMDlKZm00LytpbDBMUGdS?=
 =?utf-8?B?ZTJ1UzAzaG5CSForeEREMFJnaFc2elVlYWw4QXpiSlU0Q2pSSS9oeWo5TU05?=
 =?utf-8?B?eXZPYWFxM202cHZqUHFyaEkybEp4UmdKUkFsQlZVeENISUFSbVNuN0R6M0dw?=
 =?utf-8?B?R3RFMTY3aWg5dVpMMWlmZitlN2c4eE1Xa3JGbXk3U25sUFJMYWRKNDBYeGcx?=
 =?utf-8?B?b0lFZTc1U1Z5VGxVOTVxSzZXU0ZDRlJZVFdkaEVQd0RnN0trejRFa0dING1N?=
 =?utf-8?B?VksxTjh1c2o1aEZpLzhmbDM0Y1daR1Y5VGRMcXJwU2NiRnBiTWVGUjNEWHE0?=
 =?utf-8?B?cE8rRGpMQm1oRlk3UkJCNVI5VWtDdks1cjFHYUlud1hiTGozYStjS0dlZlpL?=
 =?utf-8?B?bzVzVVJKV1pKOUlCb2FPRDlFY1orOHlUVzRHVzFNY3R2cXFQdisrYjFVcUxU?=
 =?utf-8?B?czNsV0hxVkI2alFHK0d0RmZYUlorQ3kyaEFRZGU5bVlQclZiWVJHeEhyQ0hC?=
 =?utf-8?B?aDZ6cmZXdTN2NnRBS1Vla3JCTzFMR3NaaE1sTmlERnVGTU9hYmFORXIvTlFP?=
 =?utf-8?B?Y0tFWnJsRVhXblpJa2xUNSsyWVJDaEdrRDRjckMxQ2cxdU9qY1lOZ29rRHp1?=
 =?utf-8?B?d2gwZHphUkVKMFVNYkQ0OVUxM1RvdmdsOE1CLy9sbHBUMG5pSlhSNmQ4MnZH?=
 =?utf-8?B?ZXB2UXNDSjQzb0pXY0tXWWV6M1pFY0I3MWh6MUxGQlFTZjQrMk5WdFQ0QW1h?=
 =?utf-8?B?SXFkd3gzVCtRb0hXWVVoZE9EMGhvczVzUzI1YnE3SjErU1dubFdrVklkd1Mr?=
 =?utf-8?B?emljcVg2RVpzcGdaTHI2blZTWEN3bGlndUxrcUdjTG9IN20yQVc3aHQyOVdq?=
 =?utf-8?B?YXZLVmVPK1NxK3NMS0tpSzlqcEwwbk5GbFhidDFQbHFCOGVIL1RTMittVDRi?=
 =?utf-8?B?aXZiNE9VVEtIVGpTYkdDVUhBdHFhOVViNDR1MGFHMmRWODhyU2Foc3FUTHpT?=
 =?utf-8?B?M1VBa0ZDaUx2NVJzSFhINGtvS3F6L1prWFFUbzUwMzJWUW01RENYa0w1UnVt?=
 =?utf-8?B?NVM2UGxwWTlwOVJnNkIwSVoxcnlRV2xJUGllZUVmVisxSlBGMUljdlNPV3Rj?=
 =?utf-8?B?eTlJeEFYalFhUnB1YzJ4ODRxN0hEeUtCUVlYemhLT1llamY3WFliQTg5em84?=
 =?utf-8?B?L01XSktMYk8zOU1ibjdCTC9pSVliNmlNK0UwbGVFNTVGSVU1UGVRU0lKL1pn?=
 =?utf-8?B?Y1dEcGR1YmZhUlVWeUJFa0xzZFpRT0lxZU1mcmc5RTRNSnZKRWg3ZTk3djFu?=
 =?utf-8?B?ZXk2SUk3d1BQVUJ4ZDNoSXdpeHhPTmlkTlh5S1NSRmpJRnRkTDc4d3pVYkh2?=
 =?utf-8?B?QTExc1RmaXE2Mjh6cEMyRk9UYmpjZkRQQWppd3QweTlMelQ4SExDQWI5bWJ2?=
 =?utf-8?B?MHlqbW80R2RFeE9UdWRsUWtrdTcyZmxyekxDTkJJMmhwMEcwTjY1Y013bkt6?=
 =?utf-8?B?YjI1WkFRbWEwRFZLdGVua3Z3OE1TKzJCM3VxTnlFbFBvRkRkRnUxczVGMHN5?=
 =?utf-8?B?bVRjZE9kY0xHOGt2UDlDWEN4dzkzZE8yVTY1UEV4TURkVW9GWkR1Q3Y1STdQ?=
 =?utf-8?B?c0w0RkRMSlA5UFJHNEpuT09tbkpDVENNTHhESWdXSVF0amJnV3plVTl4bktt?=
 =?utf-8?B?R1ZNbm93akNsS1hFVFFDMWJXZEo0eE1oWFVMVmp3c1RjaTM3RGc3Mkk4cUFv?=
 =?utf-8?B?UXp6bWE5UUFBeExCakZ6VDNqdGQvYWtQUjFMSlJvVnovczdMYnFtY3cyVzlu?=
 =?utf-8?B?d0JjZSt4Nlh6QlBNRm11YmI5a0JpSVhQeFBzano4ZkJGbk1DVWtBWVYrR2RJ?=
 =?utf-8?B?cTRCaDlXQUtKc1FoYVVPV2ZnQnJidWY5ajhGYWdkd21oRDhNNXlUWlZUMnRC?=
 =?utf-8?B?dVJNRFAvdWV5UFNzQS9ranYrWWRwZXJsZDFJNndXczNUMkxRUllzeVhicENF?=
 =?utf-8?B?cHhaT2xFam9kOWhaRDN1b1BLT1pVWllicnVUN29SR0Q5MndEN091QXB3SXFH?=
 =?utf-8?Q?2YSeJVja9nGYqZiecg6fwJuKfjG0oWqogjD2hc5bOWQN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975dfdba-0c4b-4efd-7ecd-08dde543fe5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:30:35.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R+kCp11Z/r9FyijffNMRgGW1GbkMYMP+E4kqtXfcDC/AZXWfVkw1dCjoW53aIMr9w9owGWbGf+ds+dt/T2/ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635

On Wed Aug 27, 2025 at 12:18 AM JST, Danilo Krummrich wrote:
> On Tue Aug 26, 2025 at 4:36 PM CEST, Alexandre Courbot wrote:
>> On Mon Aug 25, 2025 at 10:24 PM JST, Danilo Krummrich wrote:
>>> Add a safe Rust abstraction for the kernel's scatter-gather list
>>> facilities (`struct scatterlist` and `struct sg_table`).
>>>
>>> This commit introduces `SGTable<T>`, a wrapper that uses a generic
>>> parameter to provide compile-time guarantees about ownership and lifeti=
me.
>>>
>>> The abstraction provides two primary states:
>>> - `SGTable<Owned<P>>`: Represents a table whose resources are fully
>>>   managed by Rust. It takes ownership of a page provider `P`, allocates
>>>   the underlying `struct sg_table`, maps it for DMA, and handles all
>>>   cleanup automatically upon drop. The DMA mapping's lifetime is tied t=
o
>>>   the associated device using `Devres`, ensuring it is correctly unmapp=
ed
>>>   before the device is unbound.
>>> - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation o=
f
>>>   an externally managed `struct sg_table`. It is created from a raw
>>>   pointer using `SGTable::as_ref()` and provides a lifetime-bound
>>>   reference (`&'a SGTable`) for operations like iteration.
>>>
>>> The API exposes a safe iterator that yields `&SGEntry` references,
>>> allowing drivers to easily access the DMA address and length of each
>>> segment in the list.
>>>
>>> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> A few minor things below, but:
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> Used successfully on nova-core:
>>
>> Tested-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Thanks for re-testing!
>
>> I still see mentions of "type state" in the code (and the commit
>> message), is this on purpose? I still think this is a misleading use of
>> the term, but your call.
>
> I think I changed everything in the commit message, but there are indeed =
two or
> three mentions in the code still.
>
> I'm happy to replace them with "generic parameter", but I do not agree th=
at the
> term "type state" is misleading.
>
> It may not be the classical typestate pattern,

And that's what is confusing. :)

>
> yet we are representing two
> distinct states of a type.

How about saying these are "variants" of a type, rather than a state?

>
>> <snip>
>>> +impl SGEntry {
>>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that the `struct scatterlist` pointed to b=
y `ptr` is valid for the
>>> +    /// lifetime `'a`.
>>
>> Shouldn't the scatterlist also have valid a dma_address and dma_len?
>
> I don't think this is safety relevant from the perspective of Rust.
>
> Also note that if we want to provide this guarantee, we need the caller t=
o
> provide the &Device<Bound> in SGTable::iter() the SGTable has been create=
d with.
>
> For the Owned generic parameter this is easy, for the Borrowed one we hav=
e no
> way to ensure that the &Device<Bound> matches the device the SGTable has =
been
> mapped for.
>
> However, I don't think we have to provide this guarantee, since at this p=
oint
> all device resources (such as I/O memory) have been revoked from the driv=
er
> already. So, effectively, even if a driver would attempt to program inval=
id DMA
> addresses, the driver would be uncapable of doing so anyways.

Right, I forgot this can be used even after the device has dropped. We
even discussed this point.

I was worried of what could happen on a setup without a IOMMU, if the
hardware goes berserk after being provided random memory addresses that
it can effectively write to due to the lack of a IOMMU to control the
accesses. Not quite sure whether this can happen, but in any case you
are right that we cannot uphold the guarantee that the DMA address and
length will remain valid even if they initially are anyway.


