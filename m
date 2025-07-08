Return-Path: <linux-kernel+bounces-720932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B430AAFC23D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635561AA0611
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA732215F5C;
	Tue,  8 Jul 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmmzauNy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C891C5F13
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953763; cv=fail; b=i9XUqDgIuSZ5kitiY9OYgxRAouMvjythZIaqVyGHLcRCGRlniZieG3tOx3oRbKTtJWjEnQiiUnRvuP6bdWga6vuSXUENghdTOoltsXxJlJ8aHiNSGQzQ0lcMCtGlDVOgZPUgi32pm17DtkMig+EZ046ktaGrDpxmsdsd3lz6TI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953763; c=relaxed/simple;
	bh=w2jcy1hyV9cKeuOr7Kk6d4eB3Yk18nAear6IB6XeKPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TCWLTSwrjhK0dfACSDrNpuAaFsu2wRtgLsx5KYfJKKx8+nrNEF4zxIh+0NaCkwc6MIIaUpSNtl5wqRDCpKa8RRhs2EIkKqsiYIESZRq6uIVBwttElKLo53E94SZlrA+Vt/BXXnephLcWtqt/jU8al2S1/CA0sL21GtpYEvqAF04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmmzauNy; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUI/4eX47P/KMsKmF1RYiC3PNe9pBtJAWvaCgz6grn2Tf7mHp9dq2gzu5G2YZ40NuXtsD/v26Gapch4kpNvCNaTLhc3DmE8Ehh++8sNa4kmHcKtM+WLpnCrqQcU3OZFrHzZqmyvw8lL6YfeDgQ77yHdO7sQMnmLZatMnsEc4iXXD0mDc4R1yteRDzkmX6nn0JXpawEYN4qjVB5CdAu3ETVdhyXH5AiWxMAdB0JbXDlCAs3pHFLy/0AulLqXZk4dl145u+yHQG9HyE3tZkA2NpcpQCHRWLdi+gkn1cIp05wHCPSechlapU9bGqELAMbiUtT6CGlfxopYyrlN+XWQEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIBYLs5O9tY8HxsfGpEuIJvHysAOM3pHpaHQp8ov/J4=;
 b=ax5l/vlY+QMmGawd0CzYLoKT2x8/2Hu0c4eeR1RfU5Ecgj+ITxYgAy0srJCopeEpVYFRD+bM5rFpy5XvT+fEE122TWCSpiWdSTbmw58ATHkHDPtHgfBRnHV8QwM9CtHw26liFffbuOiPhRL7M2uuak0cigdeh1ZbiVUJnWN4vdeMXUrrE9ISHeIEDWcp3EwnV9I8k2hXkyAo9L+EVbvVdw1yOLoxqQWC7x4I7mSbyAzhNnfRdVAWDCvexpmtglw3HpzbDn/5pFkkcBEL0FPCewqWXBbHODIERx4StDEaI1cKHbgzy7ZpTWuDJsguQg47wcLnTSJ47J79IfkBd9Pmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIBYLs5O9tY8HxsfGpEuIJvHysAOM3pHpaHQp8ov/J4=;
 b=OmmzauNy/oKrnrGGap45H+v1Ts8wSTj2s+EHvSEJQrIPtiAlHRadnY3jTDlJq1dGI6TqGZb2qqe/jI9QAbuTuLhfubp/ofz+W/Sc5TRpK6VYQYAn19oIm12x243jDiKjRhyxtl/6pUp0tID9J0AcXvbeOOB4B+8wnPXgMg+ZZ/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) by MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 05:49:19 +0000
Received: from SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf]) by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 ([fe80::40bb:ae48:4c30:c3bf%8]) with mapi id 15.20.8722.031; Tue, 8 Jul 2025
 05:49:19 +0000
Message-ID: <3942336d-20e6-457d-8b53-e198eed5d9d9@amd.com>
Date: Tue, 8 Jul 2025 11:19:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/util: introduce snapshot_page()
To: Luiz Capitulino <luizcap@redhat.com>, david@redhat.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org
References: <cover.1751914235.git.luizcap@redhat.com>
 <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <88d956248f7528b7998ef00ca8742061839d1036.1751914235.git.luizcap@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFF6E64BC2C:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a9f645-02ee-4c2f-b6fb-08ddbde32e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzFtczZMaTNCYXpGZDl3aWliVmEydUpLQ2pxbUdVMlFrYkNmc242UlhEVDZV?=
 =?utf-8?B?NFZTdEEzaGZudjh5dC9mUFYwejkzWmY5eHF0SnNFWGc4WEErcEQ0ajhKamYz?=
 =?utf-8?B?VjNxYi83WTA4aU9wNjdUY3lDNTk5L2lFUjdNU2FaS2JwVGNIOVhMZWxDaGt5?=
 =?utf-8?B?akJ0cVN1UzNHR0VsODBvbHNJT2k5QWVzbi9iUmJOdjdyM1k3WFNYV1VmS1lD?=
 =?utf-8?B?aGxCenJ3ekkxUEFxMHpOOWpvMTZMS204dUp1OEhKM2hsMjVQR1oyME1RbElC?=
 =?utf-8?B?K25GU0k2czJHZlJXT3MzeTRtTXIwekVaZE45cURrTzJxRklkT1RqMzRQbFJ0?=
 =?utf-8?B?MEJDSm01QXNBSEpPYkw3ZnV2U1JoWE1UaXVLTW5ucTJ1cGFoYWEzR29iOEVk?=
 =?utf-8?B?OUQyT1BtdXlQQXM2Z0FueEFWN0tqZnZNRFI5Z0grNVR0b1VPQ0hGeU93WDdi?=
 =?utf-8?B?c2tGakFNMTB0eGNFY2dwa08wMTNQcUJHUjJTM1VveWNUUWlHZUhySWxKWi9y?=
 =?utf-8?B?MDJ2NmxlbVVzNmJSY0JmY3h4N2hPekQ2OERkb0JjTjF5R2ltTjJEaGxwTE5w?=
 =?utf-8?B?bDZCV2tzYjdzaU1aT0JvU3I2UnFvODdqMENDU01QRUtkOWM3K2x2S3V2T2Mv?=
 =?utf-8?B?V3VWUkxiSy9qRUx0cGtnK0dWY2pIRkNMUGZjSFZrREgrTk0xdkNnallabUR4?=
 =?utf-8?B?QlQ2MU9pU25CUzVQT01KM0UrNGxBTDNFWWZPN1pWNmt2TElDUXhIUUVRUXlM?=
 =?utf-8?B?MytEbGNmM3ZYWjQ0aXBqRkh5dEF0RGQwMWFXS2dpWkdPMmhUWDNZeFNtVHRC?=
 =?utf-8?B?SEZRRGNDUnJmK3RBcmYyNDNlWVYxZ3gyeHY5N1V3NHQwYVdhQ05OWWl2MkFD?=
 =?utf-8?B?M3hzbjh0OXpGaGRiYVRRSFkrY0dRc3ZHWGltUjVCSXRkWVVCSUQrRkhjZjUz?=
 =?utf-8?B?STJES2RuOTNpbXozbE1BWmRTTE8zVlBlTHFlekp1RlFuT3ROTWoxTTRhL3pk?=
 =?utf-8?B?TEJPNU9mZHVqUURwalIyQm91L1JuSDQwS0g1T2wybTBDVFJuQVhIeENoSnB1?=
 =?utf-8?B?Y1hoeEtuQWp6eFpWQ25pZkdzY2MrZzlXZ2MzMzg0QWRYNG5BUTk4QWYxb2c2?=
 =?utf-8?B?QlN5NkZPVS9tUTk1YS8xREZrcll3NjBiQnhQcGZldmdrZDhXbjhlRTlaYWph?=
 =?utf-8?B?elFseXVmQ2ZHdjZheXQ1UjlrVTRVUy80S3NlWG8rdkJ5UGpIemprR1hqVnlv?=
 =?utf-8?B?cWxQdmduWWV4NUVFZm9PYU1nL2lhSUxMdXhjQUlCbEIxSGkvWWwxVzhTUjRj?=
 =?utf-8?B?aGJnUEpOaERCK3Jib2xWUUR3UVcrak93K3ozb2tXZExxdkFwaDRTbTRZSmJ1?=
 =?utf-8?B?Mi82RXp5M0VYanFBVTkzSTcyU1M2SWdFK3o2ditjWTZMWEszaTgzWXQ4UU5v?=
 =?utf-8?B?RndQd1g1YUFDOXJaUk0va1h2N0x0RE1MWEMwMWIyS0hnK1FjU1hlOFlWTlhT?=
 =?utf-8?B?OFI5ZVVRV0xoTEp4b3pnb2FXYXhkd1dxWXA1VEEzZWg5QmZRVmFQSTA1VG03?=
 =?utf-8?B?TWFYR3lRYUwzb2NCeGNDeU9SY0tkblp4RGgvaTMvcnNGUTIyRmtUU0V6TXVV?=
 =?utf-8?B?ZC9mSHpnbW5CaGZFamg4K1BFNVZGenJVQ2FYNTZtTWtzMS9zTGVPbVZMMjNL?=
 =?utf-8?B?QUc3WEJFYk83UnpmRG5lTWhpSjNtejg0ZEZwbnVQUzE5OGJBUitIZHhxb200?=
 =?utf-8?B?ZTBsY2NZOTF2WjFWNThsdmJiSlpjMm1FUERMczNDZzFybVFyZFhJa0pHZ3Ir?=
 =?utf-8?B?LzJWUitqVitIUis1TmJ0bDVLYTRQY1ZRVDlrcUpjcEMvd0IrNzJEK1VkbzM2?=
 =?utf-8?B?dXE4ZFErYWZvV3pQSnp6Vk5jNlBkcXE2NDJNTWwramZmczJBZGs2RkZZUDZl?=
 =?utf-8?Q?AVCKr7LkLVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPFF6E64BC2C.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckRYalpPemtCYWMyYkViT2ZvcTZLd0l6OUhOZ012T1poVXlDTjZFNW1IM200?=
 =?utf-8?B?KzdwZzN1TUp0c2cwS1RDdFMrNmZINnBzSVpFU05HSFZWV1dOL0pscjhjbkFm?=
 =?utf-8?B?YUtyeVN3bFRwblZPUi9UU3VQdjQ1WUtuZk5ibTEzc0pjaHo1V1JZTG5DZUNv?=
 =?utf-8?B?SktoS0ZmTmZwc3VVNXJ3cVM4aDhUblRSVmZxaHVaUC96UTk0UlB5NVVheXNE?=
 =?utf-8?B?Nmk0WmxONDJZWnY5U1RIb3F4NE9CV0NWeXM1Rk80UFMrcTdNcVNsQUpIWnE0?=
 =?utf-8?B?bzJxOXBoUXBKRlViVnlRNUpiZ2hJOEllQWZDMW5XUko5SEVsT0JlVGxlTjU2?=
 =?utf-8?B?TTcwNXdCWFpXcklFZVZ2RURYaTJZZ2tESkpZV1VNZDc5ZzJQSFhydWEzZ3Y3?=
 =?utf-8?B?QXQ3VDQzUzFPUDNoYkVoQzlieElZQnRGTjRIcXhQZmVBb0UvT3M0K2xMelFz?=
 =?utf-8?B?cWxmM2k0UEhFVGh4NjJHT2Y2ejRkOWxCOCsrcGUxcjZNVjltTEhNMkxtODlN?=
 =?utf-8?B?NTROZ255eUVqZ0oxSEx3K21qWXNsNEVNb3FzSUEwSVpueEZIb1VLenFrWnFS?=
 =?utf-8?B?MHZqb0IrNGVDdm9LV0sxTTdqUkVMRHRjL2EzWHFJVXJBc0lIM25ubkk1NXJ4?=
 =?utf-8?B?dkFBcnc2SklxMDN1UjIrM2haejRUR1JTTERoN2s1Wmo4eXBGbExPbzhBL2R2?=
 =?utf-8?B?MkFCR0JJMjQrV1dkaFlqS0VFaWZaTXJJdlRNbkVlb2J5R2ltbGtzWTZxeXZH?=
 =?utf-8?B?WDZSbW43cngvZ0xQU0NOcnpJb0xGNERyNWI1MG9zNHRGSWg4V3VMUmRSbldQ?=
 =?utf-8?B?TEFlcFdwSDZoSmI2QUNiTWpFZVBGZGRmSWV0MkRxN0ZXSHhicU5TRHpmd015?=
 =?utf-8?B?aDdrUFB3a3Y0bmhrYXR2a1B4ZmlzWVFjVktPcnJsdUZvSjB4NVR4RVkrcFdJ?=
 =?utf-8?B?aDZmMVA2WkZCYlhseVBGYUszUGtlcmRXWTJQNVJJaU5kbTNHU2VzcnVDQ2h5?=
 =?utf-8?B?NnJqOERUVHZEY0IxNTBtc0wrVnBDQ25xeWgyQWtzUHlsU2w3Nml2Q2VkZFhI?=
 =?utf-8?B?MHhOdmwvYmM0MzAvMVU0ZXhpdXltekE3akx0blVUSUFFcU85RkFML2xDTkcw?=
 =?utf-8?B?VWJZRnBKZXFJQStqSTgyZkNFalpqeWlRUXZMdU5Yem1HMFdaNUtHQ0xCYllP?=
 =?utf-8?B?Ym9wOWw1RXJrMm52ZGVlcW03YitsdWErTmtSNXFnV2ZnOGJCendxL21pU3Bs?=
 =?utf-8?B?ei9ZbnBxcjNPaVYzODJScDg3Y3hOQ0xvTFlEdjZrcVRSOG5qNk9tTGhZRzdy?=
 =?utf-8?B?SXg4R21uVjNXUk0wVjVVNmJYYkFUbmxiMWQxS3FwM0dTZVYrWTZURW5ZUXpV?=
 =?utf-8?B?YURTei9TU0VJaktpS2t4Z0RLQjlveVljSDQ1dmdnOUJuRkRISTJNb2lrNU1Q?=
 =?utf-8?B?UU5xbHJCaXVCbFVYU053TVRKOEljVmhGSm5DeEF3NGh6TnMxWUhyZ1dJV1or?=
 =?utf-8?B?RnorSW42bEpIQXNzWkJrdzB0SlJiTlJNTk1aaEttZDljNVdwYWRtb3FodkND?=
 =?utf-8?B?VWpRMnhQMUtjdTM4T3FLKzFSOVNmMXovU2lTUisrc1k5bFVCZFRYdWRIb2tm?=
 =?utf-8?B?bHdDM0RQVkR2SHBTZUZscThnOExxQ0l6WDJ6ZEY0Qi9taWxYR1pnZW5kQ3Br?=
 =?utf-8?B?NWF3bHZQOG0zM2VDc0R3bE5UTmlkdElDbjYwaW5pejJ2VlQ2eGsyS3NVY2lx?=
 =?utf-8?B?WkN1eEI3ZEJXbUY2NHhSb3MyUXQ0VjJQcDZqbjhmeGxFS3B4c2FNMmd4Q3Ir?=
 =?utf-8?B?b3Y4QS9rbTdhamNmWklRSUp5MldORmIwcWJrQ0lwR0c5blRxdCtxSGZwRmRi?=
 =?utf-8?B?L1A1c1JXaUVHVFZ3RHM3NFpkblloM3lEdldJaU8yeFo5djBvTUdxWXhCRmxZ?=
 =?utf-8?B?K2liSDhXT1NLMUt6b3pGbFQ1b2tRU0hhV3huc0ZDMTdGb3k3TmJjendJSWVi?=
 =?utf-8?B?aDR1UkJWYlVjM2NoUEFhZkdDY2RHMHRpQzFVWjJubDJKOTBRNlZwVnN3MkVz?=
 =?utf-8?B?cHdST1NxMGdwWFNURk5xMXR6aGFERVFhTEVBRm9hZFV6OGM1SkFIWTMrZUQx?=
 =?utf-8?Q?Gx9fo1NtiRw6yax+cookqe/Q6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a9f645-02ee-4c2f-b6fb-08ddbde32e55
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 05:49:19.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl3Gwb8ZNM62eYZXAxdm4C2ak/BcKxKMEUPyyrrdtwZlr1ZKjl7dfA8GENcDMB+/kA892Y9Avnp85fynRwHmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488



On 7/8/2025 12:20 AM, Luiz Capitulino wrote:
> This commit refactors __dump_page() into snapshot_page().
> 
> snapshot_page() tries to take a faithful snapshot of a page and its
> folio representation. The snapshot is returned in the struct
> page_snapshot parameter along with additional flags that are best
> retrieved at snapshot creation time to reduce race windows.
> 
> This function is intended to be used by callers that need a stable
> representation of a struct page and struct folio so that pointers
> or page information doesn't change while working on a page.
> 
> The idea and original implementation of snapshot_page() comes from
> Matthew Wilcox with suggestions for improvements from David Hildenbrand.
> All bugs and misconceptions are mine.
> 
> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
> ---
>  include/linux/mm.h | 19 ++++++++++++
>  mm/debug.c         | 42 +++----------------------
>  mm/util.c          | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..090968c6eebb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4184,4 +4184,23 @@ static inline bool page_pool_page_is_pp(struct page *page)
>  }
>  #endif
>  
> +#define PAGE_SNAPSHOT_FAITHFUL     (1 << 0)
> +#define PAGE_SNAPSHOT_PG_FREE      (1 << 1)
> +#define PAGE_SNAPSHOT_PG_IDLE      (1 << 2)
> +
> +struct page_snapshot {
> +	struct folio folio_snapshot;
> +	struct page page_snapshot;
> +	unsigned long pfn;
> +	unsigned long idx;
> +	unsigned long flags;
> +};
> +
> +static inline bool snapshot_page_is_faithful(const struct page_snapshot *ps)
> +{
> +	return ps->flags & PAGE_SNAPSHOT_FAITHFUL;
> +}
> +
> +void snapshot_page(struct page_snapshot *ps, const struct page *page);
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/mm/debug.c b/mm/debug.c
> index 907382257062..7349330ea506 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -129,47 +129,13 @@ static void __dump_folio(struct folio *folio, struct page *page,
>  
>  static void __dump_page(const struct page *page)
>  {
> -	struct folio *foliop, folio;
> -	struct page precise;
> -	unsigned long head;
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long idx, nr_pages = 1;
> -	int loops = 5;
> -
> -again:
> -	memcpy(&precise, page, sizeof(*page));
> -	head = precise.compound_head;
> -	if ((head & 1) == 0) {
> -		foliop = (struct folio *)&precise;
> -		idx = 0;
> -		if (!folio_test_large(foliop))
> -			goto dump;
> -		foliop = (struct folio *)page;
> -	} else {
> -		foliop = (struct folio *)(head - 1);
> -		idx = folio_page_idx(foliop, page);
> -	}
> +	struct page_snapshot ps;
>  
> -	if (idx < MAX_FOLIO_NR_PAGES) {
> -		memcpy(&folio, foliop, 2 * sizeof(struct page));
> -		nr_pages = folio_nr_pages(&folio);
> -		if (nr_pages > 1)
> -			memcpy(&folio.__page_2, &foliop->__page_2,
> -			       sizeof(struct page));
> -		foliop = &folio;
> -	}
> -
> -	if (idx > nr_pages) {
> -		if (loops-- > 0)
> -			goto again;
> +	snapshot_page(&ps, page);
> +	if (!snapshot_page_is_faithful(&ps))
>  		pr_warn("page does not match folio\n");
> -		precise.compound_head &= ~1UL;
> -		foliop = (struct folio *)&precise;
> -		idx = 0;
> -	}
>  
> -dump:
> -	__dump_folio(foliop, &precise, pfn, idx);
> +	__dump_folio(&ps.folio_snapshot, &ps.page_snapshot, ps.pfn, ps.idx);
>  }
>  
>  void dump_page(const struct page *page, const char *reason)
> diff --git a/mm/util.c b/mm/util.c
> index 0b270c43d7d1..c38d213be83f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -25,6 +25,7 @@
>  #include <linux/sizes.h>
>  #include <linux/compat.h>
>  #include <linux/fsnotify.h>
> +#include <linux/page_idle.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -1171,3 +1172,79 @@ int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  EXPORT_SYMBOL(compat_vma_mmap_prepare);
> +
> +static void set_flags(struct page_snapshot *ps, const struct folio *folio,
> +		      const struct page *page)
> +{
> +	/*
> +	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
> +	 * on the head page.
> +	 */
> +	if (PageBuddy(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
> +	else if (page_count(page) == 0 && is_free_buddy_page(page))
> +		ps->flags |= PAGE_SNAPSHOT_PG_FREE;
> +
> +	if (folio_test_idle(folio))
> +		ps->flags |= PAGE_SNAPSHOT_PG_IDLE;
> +}
> +
> +/*
> + * Create a snapshot of a page and store its struct page and struct folio
> + * representations in a struct page_snapshot.
> + *
> + * @ps: struct page_snapshot to store the page snapshot
> + * @page: the page we want to snapshot
> + *
> + * Note that creating a faithful snapshot of a page may fail if the page
> + * compound keeps changing (eg. due to folio split). In this case we set
> + * ps->faithful to false and the snapshot will assume that @page refers
> + * to a single page.
> + */
> +void snapshot_page(struct page_snapshot *ps, const struct page *page)
> +{
> +	unsigned long head, nr_pages = 1;
> +	struct folio *foliop, folio;
> +	int loops = 5;
> +
> +	ps->pfn = page_to_pfn(page);
> +	ps->flags = PAGE_SNAPSHOT_FAITHFUL;
> +
> +again:
> +	memcpy(&ps->page_snapshot, page, sizeof(*page));
> +	head = ps->page_snapshot.compound_head;
> +	if ((head & 1) == 0) {
> +		foliop = (struct folio *)&ps->page_snapshot;
> +		ps->idx = 0;
> +		if (!folio_test_large(foliop)) {
> +			set_flags(ps, page_folio(page), page);
> +			goto out;
> +		}
> +		foliop = (struct folio *)page;
> +	} else {
> +		foliop = (struct folio *)(page->compound_head - 1);
					  ^^^^
should we use ps->page_snapshot here?
IIUC, page may change due to race.

> +		ps->idx = folio_page_idx(foliop, page);
> +	}
> +
> +	if (ps->idx < MAX_FOLIO_NR_PAGES) {
> +		memcpy(&folio, foliop, 2 * sizeof(struct page));
> +		nr_pages = folio_nr_pages(&folio);
> +		if (nr_pages > 1)
> +			memcpy(&folio.__page_2, &foliop->__page_2,
> +			       sizeof(struct page));
> +		set_flags(ps, foliop, page);
> +		foliop = &folio;
> +	}
> +
> +	if (ps->idx > nr_pages) {
> +		if (loops-- > 0)
> +			goto again;
> +		ps->page_snapshot.compound_head &= ~1UL;

Should we use clear_compound_head() for clarity?

> +		foliop = (struct folio *)&ps->page_snapshot;
> +		ps->flags = 0;
> +		ps->idx = 0;
> +	}
> +
> +out:
> +	memcpy(&ps->folio_snapshot, foliop, sizeof(struct folio));
> +}


