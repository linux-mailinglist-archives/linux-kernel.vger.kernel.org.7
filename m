Return-Path: <linux-kernel+bounces-720879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24481AFC1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6016717CDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F61D5CC7;
	Tue,  8 Jul 2025 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AKPmJ+0/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F341548C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948420; cv=fail; b=F/MJWXWlX8vgqQf6CX9Y3ud+qk62JwR4o0ji/A2Esqntw0VA1UIg9NIZW+GSiYSuAZtzIM5QaSCHgnI3lzCeWWnatCRdiEQtLfyup2uM6heMgLaB/mg+7VS3H5/edFOEil12LQhOUFRPQgHuh7feFG7FxlowRX/F/1zamgf17uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948420; c=relaxed/simple;
	bh=XAkh22gPcSB9OiQ795X4XKkniNywsMVDXB4hNcUR5sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5U69nBS6rbf2JPDC4I0NiuhFFMrz3H/M7XtJcZ1nqlJYt5d8EuEcMd6vpZweTsHYyoNfm6NyI71RX1M0QD9sVuuSIrHG8sj/IiO/6iololKoS8IQTyt3irFwceXpjusFWuL7hgH0JbjervOiWkt7vxTHV8CNxkgEoNIAtTj050=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AKPmJ+0/; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew7ASF4ZNNc3kAvNQoLXuntL+GD1nfV7OP4M+au9+KmxSAF8cg2VCY3e6S+f+PEeJNr8NcwTh4kbKGvd5IADs0Gk6KbXClB+A3wBb2RssOtz+sHVhYAE/MPhGk1lpCVyM74WyuGd+N1WFpXSscQKFig63C6021ffLN4xKB16fKImyRaw/2OF0ktfuLOB2LtlxE4cUOhG7nL3uQC7uCddA+8NcAhLfkntq3vMWSCDgSKpmVf0IoHTtJ7FioR9ENUuXg4PCQPsmmw8XJqqRDeB2Gy/YJOIiCqBOAKe38t82/7Au3Ivc8XymFdVsnMyVl++J1g6DF4nwl9rFE1sCLe4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2UEEmK2izcZ0fIJoeLAY513/c8VcRQm7VrY2FL6obQ=;
 b=gmmxUU74PxvNuL1Y19AUms9weDVEyhGh72teoty0fUClsXCMDEceHCBu44K5phSly3vvG/HZSM7QCSTWdrQgzYhmzb+S0fF7rJrs1jd3gL7s6Nl3eDnspoZAnj7CnHmfvpsfyB6K/QpPmYCDJxD4Wq/OTjvNha2fYlTco2KX8Lt9Nv6PLZhrX6mqs5SwbhZjU6rfB5I28hg/9VSjQ7Bq+gLJCWL8FHnjdbCsb1I8mVMwpuyUYLaCDBKBbKLz8PrURfIREmq17Z6xni1i310gvu1w7iyQCiU21UhU8XcCX86zyXNVjqAt3S0DoCtw9RS1+RFMpcoUVG5Rh6/8341pgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2UEEmK2izcZ0fIJoeLAY513/c8VcRQm7VrY2FL6obQ=;
 b=AKPmJ+0/OFAooy+r51obKO8G/gkqMvhf2ufZ6yqFHyBiATlmOoQTKDJi0ZOfZ6mylTAGyDM+aXXZnbMXPAbQ3Rlbv58thOCJu65IynvdvLclogLjNT4yAtX7yEqyeOr5uqZasGoH3ODKmsMQSMfI8C/Di5rS0ufz3CTmOGDnRTE8F2wFi8fKO2nnnrGN36/PmXK2A64W6rLA+fl7FEy0B4uszestGbejxa9I3IpU5yef+pEYO9Df4qeBzUki47jxoy7Z9tg52xVdfDxN/KzUjPFgAtkoXeN1V3SpQLGUv9PP77P2DRJi4oeEx8hgccI/SuIK1uZiyV0vjIMnDEwvNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 04:20:11 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 04:20:10 +0000
Message-ID: <b84846bd-801f-42b6-b1d4-3d784ddbcd1f@nvidia.com>
Date: Tue, 8 Jul 2025 14:20:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 03/12] mm/thp: zone_device awareness in THP handling
 code
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-4-balbirs@nvidia.com>
 <fd86a9f9-66b4-4994-908d-af4c6637442e@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <fd86a9f9-66b4-4994-908d-af4c6637442e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb049a9-c282-49a1-f3f7-08ddbdd6ba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MS8xOUhQSjFWM3hZcUlyaE5jMDVpYlRVZzJIN0R6QWMyTkdpN0RoR3RIbUVH?=
 =?utf-8?B?dHJWNDgzTkdvK1FtVEljZkRrTUI2RHkwMVpFN0RxbUhQeDA2bUNnWXBrVUcr?=
 =?utf-8?B?bE9pS29YSFJLR1NvWWpyKzBjbHo2aHlFMmRVM0VNK0x0VFJ1ZGpUTHFMRElE?=
 =?utf-8?B?ZnMzOWlrK0hBYjd0a0hRRlZkenhFWDZYTUU0WmhpdVFBY3Q3VDZyOC91ZEpQ?=
 =?utf-8?B?ZGZ3NEFTdmlVMmpaMXQ2QW1YYWFVblYzSG9SY3NUOGVoN00xRFZxUzVuNFI1?=
 =?utf-8?B?QnNZUmFGcjNGMTN3SEZmcDdJZ2pSSFRJTDNmNi9OMHZBeHRTWk01c2Y0ZTBX?=
 =?utf-8?B?UHZwMGhDcmJzQWZQVHFkdGdDamNlcHk3QzVnTUlkWFp5VFUrSlBWaFE0WjQ3?=
 =?utf-8?B?ZUJ6QUJHcm13d01YbmdQN3k3WDFwbHBrV2dXOFYvNDhJOUc5VGs4dG9ZM3Zz?=
 =?utf-8?B?WlFWN2Q5bm9xK0lzM3lBUnpCMzZoSXJQY25veGdUVDU3K21oN0FGdkQ1bG9O?=
 =?utf-8?B?SGNSL0xYRlozNUJzSFJvSHRWVVdiZmNpU25BcW52NnFFRjV4YTIrRjJ3Sm5O?=
 =?utf-8?B?UXNGQ1A1N3JuUTh2VlhDY3lwa0F3VW9zNksrNUtSeThCUUR5QnFFWmJXWVRR?=
 =?utf-8?B?aXk4UHVieU5WSlVmelVPVlN5ZFdqQ2E3Yy81MFVXV0FYOG8vS0V1aXYrRU5v?=
 =?utf-8?B?Y3pJNjA2eWduVEE4REd5Vkpva3BCZUw4MVZ2QWQ0dWFENHA4VTFxd3dkR2ZM?=
 =?utf-8?B?Wkc2WFJ6UXgvQXBDQ3VZOXAzRWhoeTh5K1pmUUlRRm51MXorN0ZnMzNZOEd1?=
 =?utf-8?B?MHJBVUhBVUdXaEdXdTZyVjlweFRhMFJvV1hUSkZpb2FvR0haam1MTU52cXdW?=
 =?utf-8?B?Sy9tZHpQY0VSQ1UvTGZ6OFY5eUFtT3hlbTNmT0ZiNFdva2pBd3FGNXNLd0hV?=
 =?utf-8?B?TWozTTdEOUxMdlRXY1Q0dENOcTlXdmlEaWtIQVNKdHc5SEJwdHRzYk9qUnpa?=
 =?utf-8?B?SGZjTUpzd3lSQUowT1VSOWwzZHFkbDBvWDRMbjNucklPT1BMc3FHb3psMEZW?=
 =?utf-8?B?TExTOTBXRlZLWU55S1pER0hEZ0hONk9qQWEvVmQwQ1JDRDJicWMrdDdaMVZF?=
 =?utf-8?B?VGxOcFNZTWVNa1haUk5Pd3JYN1U4blpxOFo1NTREN2pWSHgxOFg5TEpDdFBm?=
 =?utf-8?B?OEdHUFFqMFA3akUvVHBNc0ZEUlRsR3JtSnVIZVYxZUlFTGovV1FSaUNSOG96?=
 =?utf-8?B?Y2RSc1htVUkzd005S05CTEI2UExXRGptbmxIQlpid09mb1ZHQVZ6RnhNeDlt?=
 =?utf-8?B?QjNyT2djNUlLOXJYWHMvSHVTU1V6Y1U4L0ljbkgyYXlzL2Jwcko2Tklwb2FU?=
 =?utf-8?B?M0RldE11MlhyZlJUK0RobjVhQUJjUythYitrNk9HQTVaNjBESlNhR0g1QUpw?=
 =?utf-8?B?VUs2UTk3RGE2WmU4NW91ZzRUdVR3bmtPaXM0UWQwZmlERU1XTVp0czFFWWNi?=
 =?utf-8?B?a3k5M0tXRmJrK0hlOFlBTDBzcjJSYlZkSWthenFlU0RjaTFzUWNrajFnVzAw?=
 =?utf-8?B?SmY4R013Y0FxbDJUUUVTb0xxbzhia0hLU1N0SVgva1ZUbHd4cmlTK1E3amNU?=
 =?utf-8?B?L2owVCtHekVXeURQQmZzcmFabjVvN3ZYNld5K0VBZ1gyWUt5dEpUYVJPZXJ0?=
 =?utf-8?B?dzB3enJjMFBucjM5amxhT2l1TE1mLzNkR3pYVVZwdTYwUEwxQUYvLzBYOEFC?=
 =?utf-8?B?MTY4ZzMzK2ZrMjZqcEpodDJXUVlZT0FmVTFpbDFtbWNSUE1aeUUraHh0c3c2?=
 =?utf-8?B?c2k3VWJqQWJscjJMZnQvaCsyS3o0VDh1ZFhSMi83bU1DNWZFQnk2VWVnRHFT?=
 =?utf-8?B?MGV3dFZZUU5RRmQyNTBuZFlkblJpNStFaTg3a3d0NnBYS3BwRFpZWEdkTzRx?=
 =?utf-8?Q?be32GEg5bOw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUo4K1FmZTVEc2ZFY3hFTWtKZFVsa2dkdFdzYll0cTlvL0VtOTJ5VTNyOXdr?=
 =?utf-8?B?ZE95cFAwV0l0emFxNXFQWkUzZnlXWk9tVnVmVDJjam1jY0dWOEhTZGVlMEtE?=
 =?utf-8?B?YjNreDg3QnFpS0ZFN2U0UDZvSFk4TWo2VDdPbTJOTXFKcy9FTW9mY3dCT0Zx?=
 =?utf-8?B?aGMzTURxRmpTOGptYVQ2eUoreHVWcSsxWWIyTTN2ZFZYK3o5UzR5bG5EUG9H?=
 =?utf-8?B?Z043M2NRVmpYYjA1T2xTYXhGMWdZNTY5Tk1DMkZidWdzWC9BQXJQbWFRS21u?=
 =?utf-8?B?OFRaVDlsVkp5bjJDV3BGQndZNnYrNWtnYWd3MlNpOVZLWmI4WDRrTHdhc0dX?=
 =?utf-8?B?NTV3Uk56Y3ZYNUVaKzlNeHcrSldialZOaDFsODZDT0dJaGVDWUFFazRrNXN3?=
 =?utf-8?B?WkF0Y1p5aDhFVndNaFUrM2pzdUZqT1lVUno3eng0c3RRc09ieDlreE5XZ3l3?=
 =?utf-8?B?bjMxNDZHVTBQSXhCaW4zand1dnhERFFiZmt0N3BpcXM0akM1czYzTlkrdTQy?=
 =?utf-8?B?V1JueDBBMGhIZXFkRDVWNk80bkh0bVp5VDlRNy9JbExzVjNSRnJIenJRbUY5?=
 =?utf-8?B?cnA3YU5XaHpiTGVpS3duOXlWU3JYNFY4SHRUT2xxcHVRa3FnbmRFL3V0SHRL?=
 =?utf-8?B?dHphRFNkOGs1ajVjdDhyRnpkejBoQzEvL3liWXdDQXp6bTNLSXNsQ3BNU2Yw?=
 =?utf-8?B?WGl1YmV4QmJ0SUE4S3V2VzVCL0ZrRFIraUxUczF0OWhQZDhMNEo5ckp6TUtv?=
 =?utf-8?B?QS9TQVlXTGNkL3JoTDhaZlV1MFlsWkFPTVhZVVZyb29yOGI0aXFhMHVEb2Zh?=
 =?utf-8?B?bUZJTUNrTXNKemNHa2tyNzhSaU5ORHNiaVB1aDRQUm14U0dYMzk0akFrZTVX?=
 =?utf-8?B?TmNKc2I5Q3pqdUVja3ZYdmZGL2RzQkNXMTM5ZVhzNXl2Y1F6SU1EcUtmbURn?=
 =?utf-8?B?clpLM1M3WUlRM2N3eVA2YlU2ZkhNSmdVVkpVZm1MMXV2M1Q5TzNEUlpjaXJT?=
 =?utf-8?B?RHJJV3lDNTNuQ3NOQkU4VGdOM0NQNC8rTjJUN0xuemoxaWh0TUNuTDI3aUF1?=
 =?utf-8?B?MGsxWTJGS2lMVDZXSFhkcWJURGdXaWtaNGh5VTEzVytVYlFYQVFkT01CSWxp?=
 =?utf-8?B?ekRGSWU1M1lHcllNSHorcHBxUXI2UVFvaTIzK2I3eUVvTEpoczk1TS9xUUNS?=
 =?utf-8?B?QmlkWlJiMkRmZGFvS3JMWW1JYWlSZFZFUDFVN3JpcU43VVdURDEydVFDYWlB?=
 =?utf-8?B?VzRvV3VvcW4yc2ZIQTdEcnJxK1JoS1kvNjNueGF2RGhFdnh0N0M4NHZZQzlM?=
 =?utf-8?B?ZndxMlkrMVcxVlRsejVQQVoxN0R5L0VpZEpRRXptUUNmdTNFYlZWVmNLSW1h?=
 =?utf-8?B?VlBYSjRoNXBqa21NQlYwc203cVR1RVZWNXBabkxQNzl6bkpzQTd2c294UDlp?=
 =?utf-8?B?N0l3eExYL1dHMHhFeTJOVW9pNG1md0lXNmlOeHBmaklWbjVORCtBajVQU2Iy?=
 =?utf-8?B?MXhUT2xOTG1xVlIwVHBYS242anZHT0FEVjZzUUVRaElCL2ZMRkNGVHVobDBu?=
 =?utf-8?B?djREQ0dlN21IV2FzWXJOZnJ5OWJGditWaTYvQS9JenMxRk1wNXBaeTRkSjIr?=
 =?utf-8?B?N1Z5VEF0MWUrMENVWG1hdXU4MkhsVlBVV0VpQURHaWJaMXdYY0g0eld0TDdQ?=
 =?utf-8?B?TzQrVjVocWdDMjZGYzFjTjBhZVVPaXVIQ2taU0RUQUh6bTFBMXY3RVhCM3Z4?=
 =?utf-8?B?MHkvVks0allNYUNmdS8waldwMEt6Q2taanFDbHpHZXBNRU5tcnZpc05valhh?=
 =?utf-8?B?UzZ5ZVQ0dkdxOTZQeEYyUFdHM0doNXFpanRwS2s2K2F1VXF0TlNGY1RFL0o5?=
 =?utf-8?B?S01DbUxVK2tOSTNuSkVQbHMvZ1BabDk0RXR1VlpMSDRTRGtsUmlTWEwxQlps?=
 =?utf-8?B?SEZHRFJFc1ZEbVRiWE9TdVBVbGxlMDBKN1QyaEQrekhDbGlVNSt1aXkxRCtR?=
 =?utf-8?B?WXR2R29KdXNkWml5SHNDc1ljR3lLRjE0aFlvdGJrclRYMXdjNjBKb2hBVW9F?=
 =?utf-8?B?UWFickpxejNHVEZMRlJybWF2TEFqbksxSFZvMEJRd2R6bzNuS1hYVlg2akYr?=
 =?utf-8?Q?1lozqgGBjk+x7/WlmI4rAHdyN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb049a9-c282-49a1-f3f7-08ddbdd6ba7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 04:20:10.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jtCSeE2+cVD/W35lb4KBfUgsLU5CkscfcNz3IY5g0Nw8BiqkfydNHhggPfdf6KMPSEPIH2y1gNgYrGjTQ7RZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

On 7/7/25 13:49, Mika Penttilä wrote:
> 
> On 7/4/25 02:35, Balbir Singh wrote:
>> Make THP handling code in the mm subsystem for THP pages
>> aware of zone device pages. Although the code is
>> designed to be generic when it comes to handling splitting
>> of pages, the code is designed to work for THP page sizes
>> corresponding to HPAGE_PMD_NR.
>>
>> Modify page_vma_mapped_walk() to return true when a zone
>> device huge entry is present, enabling try_to_migrate()
>> and other code migration paths to appropriately process the
>> entry
>>
>> pmd_pfn() does not work well with zone device entries, use
>> pfn_pmd_entry_to_swap() for checking and comparison as for
>> zone device entries.
>>
>> try_to_map_to_unused_zeropage() does not apply to zone device
>> entries, zone device entries are ignored in the call.
>>
>> Cc: Karol Herbst <kherbst@redhat.com>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Jane Chu <jane.chu@oracle.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Donet Tom <donettom@linux.ibm.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>  mm/huge_memory.c     | 153 +++++++++++++++++++++++++++++++------------
>>  mm/migrate.c         |   2 +
>>  mm/page_vma_mapped.c |  10 +++
>>  mm/pgtable-generic.c |   6 ++
>>  mm/rmap.c            |  19 +++++-
>>  5 files changed, 146 insertions(+), 44 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ce130225a8e5..e6e390d0308f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1711,7 +1711,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  	if (unlikely(is_swap_pmd(pmd))) {
>>  		swp_entry_t entry = pmd_to_swp_entry(pmd);
>>  
>> -		VM_BUG_ON(!is_pmd_migration_entry(pmd));
>> +		VM_BUG_ON(!is_pmd_migration_entry(pmd) &&
>> +				!is_device_private_entry(entry));
>>  		if (!is_readable_migration_entry(entry)) {
>>  			entry = make_readable_migration_entry(
>>  							swp_offset(entry));
>> @@ -2222,10 +2223,17 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		} else if (thp_migration_supported()) {
>>  			swp_entry_t entry;
>>  
>> -			VM_BUG_ON(!is_pmd_migration_entry(orig_pmd));
>>  			entry = pmd_to_swp_entry(orig_pmd);
>>  			folio = pfn_swap_entry_folio(entry);
>>  			flush_needed = 0;
>> +
>> +			VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>> +					!folio_is_device_private(folio));
>> +
>> +			if (folio_is_device_private(folio)) {
>> +				folio_remove_rmap_pmd(folio, folio_page(folio, 0), vma);
>> +				WARN_ON_ONCE(folio_mapcount(folio) < 0);
>> +			}
>>  		} else
>>  			WARN_ONCE(1, "Non present huge pmd without pmd migration enabled!");
>>  
>> @@ -2247,6 +2255,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  				folio_mark_accessed(folio);
>>  		}
>>  
>> +		/*
>> +		 * Do a folio put on zone device private pages after
>> +		 * changes to mm_counter, because the folio_put() will
>> +		 * clean folio->mapping and the folio_test_anon() check
>> +		 * will not be usable.
>> +		 */
>> +		if (folio_is_device_private(folio))
>> +			folio_put(folio);
>> +
>>  		spin_unlock(ptl);
>>  		if (flush_needed)
>>  			tlb_remove_page_size(tlb, &folio->page, HPAGE_PMD_SIZE);
>> @@ -2375,7 +2392,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		struct folio *folio = pfn_swap_entry_folio(entry);
>>  		pmd_t newpmd;
>>  
>> -		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
>> +		VM_BUG_ON(!is_pmd_migration_entry(*pmd) &&
>> +			  !folio_is_device_private(folio));
>>  		if (is_writable_migration_entry(entry)) {
>>  			/*
>>  			 * A protection check is difficult so
>> @@ -2388,9 +2406,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  			newpmd = swp_entry_to_pmd(entry);
>>  			if (pmd_swp_soft_dirty(*pmd))
>>  				newpmd = pmd_swp_mksoft_dirty(newpmd);
>> -		} else {
>> +		} else if (is_writable_device_private_entry(entry)) {
>> +			newpmd = swp_entry_to_pmd(entry);
>> +			entry = make_device_exclusive_entry(swp_offset(entry));
>> +		} else
>>  			newpmd = *pmd;
>> -		}
>>  
>>  		if (uffd_wp)
>>  			newpmd = pmd_swp_mkuffd_wp(newpmd);
>> @@ -2842,16 +2862,20 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	struct page *page;
>>  	pgtable_t pgtable;
>>  	pmd_t old_pmd, _pmd;
>> -	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
>> -	bool anon_exclusive = false, dirty = false;
>> +	bool young, write, soft_dirty, uffd_wp = false;
>> +	bool anon_exclusive = false, dirty = false, present = false;
>>  	unsigned long addr;
>>  	pte_t *pte;
>>  	int i;
>> +	swp_entry_t swp_entry;
>>  
>>  	VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
>>  	VM_BUG_ON_VMA(vma->vm_start > haddr, vma);
>>  	VM_BUG_ON_VMA(vma->vm_end < haddr + HPAGE_PMD_SIZE, vma);
>> -	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd));
>> +
>> +	VM_BUG_ON(!is_pmd_migration_entry(*pmd) && !pmd_trans_huge(*pmd)
>> +			&& !(is_swap_pmd(*pmd) &&
>> +			is_device_private_entry(pmd_to_swp_entry(*pmd))));
>>  
>>  	count_vm_event(THP_SPLIT_PMD);
>>  
>> @@ -2899,20 +2923,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  		return __split_huge_zero_page_pmd(vma, haddr, pmd);
>>  	}
>>  
>> -	pmd_migration = is_pmd_migration_entry(*pmd);
>> -	if (unlikely(pmd_migration)) {
>> -		swp_entry_t entry;
>>  
>> +	present = pmd_present(*pmd);
>> +	if (unlikely(!present)) {
>> +		swp_entry = pmd_to_swp_entry(*pmd);
>>  		old_pmd = *pmd;
>> -		entry = pmd_to_swp_entry(old_pmd);
>> -		page = pfn_swap_entry_to_page(entry);
>> -		write = is_writable_migration_entry(entry);
>> +
>> +		folio = pfn_swap_entry_folio(swp_entry);
>> +		VM_BUG_ON(!is_migration_entry(swp_entry) &&
>> +				!is_device_private_entry(swp_entry));
>> +		page = pfn_swap_entry_to_page(swp_entry);
>> +		write = is_writable_migration_entry(swp_entry);
>> +
>>  		if (PageAnon(page))
>> -			anon_exclusive = is_readable_exclusive_migration_entry(entry);
>> -		young = is_migration_entry_young(entry);
>> -		dirty = is_migration_entry_dirty(entry);
>> +			anon_exclusive =
>> +				is_readable_exclusive_migration_entry(swp_entry);
>>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
>>  		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>> +		young = is_migration_entry_young(swp_entry);
>> +		dirty = is_migration_entry_dirty(swp_entry);
>>  	} else {
> 
> This is where folio_try_share_anon_rmap_pmd() is skipped for device private pages, to which I referred in
> https://lore.kernel.org/linux-mm/f1e26e18-83db-4c0e-b8d8-0af8ffa8a206@redhat.com/
> 

Does it matter for device private pages/folios? It does not affect the freeze value.

Balbir Singh


