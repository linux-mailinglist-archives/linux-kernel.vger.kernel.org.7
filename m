Return-Path: <linux-kernel+bounces-731848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792BB05A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FBB74349D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D81991D2;
	Tue, 15 Jul 2025 12:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y38fgqvh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF5165F13
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583641; cv=fail; b=KZQfO2m7DDALDwtszqQVNW4VNmRVwKgCQjsr8eo2kmSmq0lfEABBnXZRSNIzu7rVyQkenNAuK+NxrUJWWeyiNA7Ez9wXOAEruHbQYxd7Y4TuS546KnzZci3t17in6OitHnDN+2jyO5teH959VmTRpIAK0Xhr9g4EastcjHIshDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583641; c=relaxed/simple;
	bh=w2WQrwo9x6BnzK4K5/P42cRuVQqfo8LQzhVjg3x5tNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RkknuTb9E8dQUPXqO79uxKw/mAp5SWcNGdQnU+nouK3gR8YvGftIA6Cml2I2zAWbrj8oNjHxrRdmJCWf+pWjxouWanZDXioij9rIYI8WIFKlbgdAbYlu47bNJ4cgG2wpsi0J3D0mALs7OW1g7hZ5BnocvKzKv+/jt/QxYvAp5yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y38fgqvh; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYnwfPE0XiyZIbVoY5NUF/j/un6XbH2L859PapGyY5OxRHyfcGEypk3Za34ZoSgRPjQFe5dvjamxzSZfhIEd0PLBG95tBTS+1W46eaYDHMriGbNPQAKamOZIi+Wus7jRinQxKMfLukBUVc9Qxt1vSAVxw/3cLWYntO7wruMB58fuGwtg4pw32BgXb7W0LkDS0lvQ9lNCgAT+nsuwtQSxG6bj4o1EUJWusHLLYgJmg/ocQvB8wQkrz+U/RbWmIBd7Fb3nytZvkTRsmDzX5uqWDmh+hs7xT1PqBhfR2wlhURT8xWq8pxYuj8XRcOIvsO5+KnW7hLuiZ5b/m437VLi5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APXwCo/CMTETJJbZPZ/4oo2IHX8qxbBNIk61fsJqOrM=;
 b=nN0NRTiuwlaXJD4FCdM5DMYurU7yTgN8A1ZSv43yPlTO/6T2hOd9x8VQdNFWoP6iQfFKgLmuiYHKDGEfzQFFe199OE44AU9TVjp9yZk+eq+c5Bfy+Mmo+JvuPY+oXy4zmRt23NPe58eKxXgeJAmCN6uF1rTVciMZbULOilmIaMUuegQosY9jNa9FJfIEG3ibq0bEvC89kPVsfihy342WB/kmYCaa3L93dlOmI1sWZg7BPv7Cs7jFvKBvPXahX9IkRJyTil956+walHk0qQDxmJpI+pMp2ECur2X2pv6POhSlO0vlH0lynpB0pGPG40tp1AhYhuhzY6sFGzq8ousm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APXwCo/CMTETJJbZPZ/4oo2IHX8qxbBNIk61fsJqOrM=;
 b=y38fgqvhJzQg9pM0kjtB+JD4LBCdxwFBrd33D1twv2YjXevHD/3nWel6VtzmTx5KmixB3j0/5+QieTe+cCCqNG2yLhfvbEoCGZOeWD91dTYwCaFMk8VUFWxU80hHq56llIvGr11yzmon+7LPLWDJv/MXEc7EDk9eKzjDPSy4igk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 12:47:14 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 12:47:14 +0000
Message-ID: <e61ab0eb-816d-dc5d-dde5-e305a27705b2@amd.com>
Date: Tue, 15 Jul 2025 07:47:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Content-Language: en-US
To: Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>,
 Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, santosh.shukla@amd.com
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com> <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
 <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
 <aHUx9ILdUZJHefjZ@google.com>
 <20250715083827.GBaHYTg9eU55LcHKR1@fat_crate.local> <85ecuhx1eh.fsf@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <85ecuhx1eh.fsf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:806:28::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: fa166ca2-3fef-4250-a812-08ddc39db932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2JualYxeGczSjV1bnZHVTNCeWJBczZqRHdqaUlTZXNiNlAyU2dQbWpPZlVx?=
 =?utf-8?B?cURSQXlKT2Yrb1FaeGVPNFlUN2RHVlFPUDZLZzFXNlgzaCtzN1RxYlppeG5r?=
 =?utf-8?B?MTB3SndwL0c2MG4wUUJ0QkY3cGg3Y2hMaFU2M3ZpUms2N2tzV1RHbWFKL2dw?=
 =?utf-8?B?SjMwSGkyQjNYbWxYcnpSd1MrajI0MEFmVjFhZW5oR2RWdGg4VzRneHFsOUtk?=
 =?utf-8?B?V0V2VGVKRTJLK2lCenJpcEUwV25XaHhGRjJmRWhneGlTRHMzc3BpejNHSDln?=
 =?utf-8?B?cERvQnkzaFJrOVdMb3JrNEpmaDZxT0dvTHF4aGY1MTFJL1BROGFEaDBxaFFN?=
 =?utf-8?B?QmpPTzRMeWV5Q09iUnZzSmNYUGk2aUdOMTNqbEtrRlBFTml3OHNXMGxTTTZx?=
 =?utf-8?B?b0hvUW1QSEkwYXYvSTU3bk83UU5zRzUyaUZ5MURuV0pLQ24yNlRHSnJoQkhr?=
 =?utf-8?B?UlZGSUF5QUZGb09qZ25PVlpYTENsb1dXMFQzL3FudkRFRWZwcjdXb2ZLY1p4?=
 =?utf-8?B?SFJZVG1yU3hrWlZuWU4yNHJrKzhVbEVwTmdWdWU3NjlUVkRJRVVCN3ljdXM3?=
 =?utf-8?B?Z2IwYU9nQmdXUXNydmpXUFN5and1eTFzd21hTkdFdFM5ZzcwamZMNHk0UXoz?=
 =?utf-8?B?U1Y1dVVvdTJYOEpGaER0WG9lL0ZYRUdmbHM1OTFUdlQzdEp6UmxBOG1id3Nr?=
 =?utf-8?B?K1lscjNVUXpQd1RsbWRoZnlZd0VTQ0NEcTFoS3NXNlovTC9kUjNLMkN3b3pz?=
 =?utf-8?B?UTBCZGRzRHJ0VWpIc1Z5V2w0TE5qSFFoNUJYQlBmSUkrSkFNWkRZSWpPQ3B3?=
 =?utf-8?B?VU5uQ0hrY3pNQUV0YXB1Rk1XSDlYdmozN3pzN3dNQzkrQ29qRjl1QXdUNUVV?=
 =?utf-8?B?OUdtekRnMEJOMHRoaE9DWFV2ZzI3M1FZa0VjYUdsMVZvSmhJWFlBTGdwcWZh?=
 =?utf-8?B?d1pJSzVZMDNyK0pJM2UvZmk0ejZCd1NORk00SXRiTEozNUNhQm4xOFJSR2p4?=
 =?utf-8?B?dWh2ZHdveEZ4ZC9mV3lRNDA1azlQODJtVDZXclQvS1dpUmJGOVBSZm1JNDJW?=
 =?utf-8?B?dnR4UGtuQVQzRjZVVHdBVk9UVG1GOGRjNHZxc3V0bGg2Mit3YjRQSnBrL0NN?=
 =?utf-8?B?dkp0UUc1TVdXam1DbUhQeXpnK0xCd0gwNHhNSFNSNTBpMTRVTFNZY3dYaFVJ?=
 =?utf-8?B?UzJadlJhUWVVcGRsK3EyKzZUK1Y2QUNhK3o0aGM0UXVuZWFKbCtkYWVIaWdz?=
 =?utf-8?B?TVU0bVp1bis0NEFLNjZVL2hWSTNaYVo2ZDhZQ0lrb0N4R2hONzZGYmVaelVa?=
 =?utf-8?B?RzFvQjlaVDBRK0JDV0V1ZXFyajRnQUVWcmFueEM4cmszejduclNBdFg2bCtU?=
 =?utf-8?B?Y3BTaThaNDB4bS9TL1RrdFo5YXlpUzBEK01NZG1LWFFCN1FtOURicnh6cE1D?=
 =?utf-8?B?SHNoSnZpWkdjaHpBaUM4aDA5VzA5aFNkUUFUT1VsdVBEaDVBWWVUMXQxTkFC?=
 =?utf-8?B?b1JTaU5ydTRtZjdNN05mV1R0N0dsUElpSDZQcjhQSjk0NFNtSlkwMHN1blgr?=
 =?utf-8?B?U1hoK0lhNG8wL3ZGYmdtUXFFd1BpT0htL0ZHNGZoVVRDMjFKUjB1emtoL0t0?=
 =?utf-8?B?NmZpQ3RLWXZ4YmtVZEs5TE9iSFlzVHBnanpGY1dEdXZmUkFTVTdCK2hFZ09x?=
 =?utf-8?B?Y3dndjBENXg3aTFELzJPUVpnVkJhUGExT3hMdGhyUkl1alMzUzZDYU13Mk1m?=
 =?utf-8?B?MGlXSmZLaGt3Skp0alVQVHhyOEhReDRrSGhDZmQ0VFlaczYzVDRjWDFoZ1BX?=
 =?utf-8?B?VGR3dXN6bFR5bHFZdE50YjRyNjR3UTNxRnJUYnNHaldRTnlQb0MyZmYzRU5r?=
 =?utf-8?B?cEVxY0RmQjErVUk5ODJ6RWllZml1K1dVQTJ5eDVTMTRYSDh6THZZR3plL09K?=
 =?utf-8?Q?m6SuIM6qFmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzdqV1dVbGtYTG5neTRVWUp2a0xEdytxZjZZL3AxcjFUeWVEZ1BoRTBDcnl6?=
 =?utf-8?B?WEt3QVFIUUphZVZxb0JOZEI0Qkw3SXhiSnRLOTN4U1dRYnltYkVJaU56OWpT?=
 =?utf-8?B?U21FUU1xV1VVNEV5SEFoL1pWQktrbUY3YzRXUGd0SlJ6SndMdUloWnR6WndM?=
 =?utf-8?B?N3h1V0llK0gwNk0zZzVUMlAybGNwNGpLdU1mUXF1Z2dtendGem1jcGI3OVlI?=
 =?utf-8?B?dUh3U0FNOVYxTndaSjdXNExMVi85b1FDYzR0NVhjWkJvWGk1dDVzVDVSdDdo?=
 =?utf-8?B?dmgzdHhJZ0tMVEs2Wk9vR0ZyRTRHbjRKdFJaQ0lIZk1uY2xDelE3cHZxNmx6?=
 =?utf-8?B?dUJ0N3oxY09OR2pCYm5Bc2VlaEVrV1Y5cytOWHUvc1I3elNBQkZMcEkxSjMw?=
 =?utf-8?B?SlpGeEpUOGF3KzRxbzR1VWp1WVVYN2kyTFUvVGYrMjlqVkMvMEJCbkVOWVVW?=
 =?utf-8?B?U2ZUM0NDeDFRanZOOEo2c3NkL3JsUTdjSS9ScllaUTJ5OTZ3Q1lCVHMreUhU?=
 =?utf-8?B?SS85SjVYUVNwZVlWT3htMndTa3lETE51NEVGTHhvSmVRbEhPOWEwL3dmMVMv?=
 =?utf-8?B?L0kzRktUK005alBiOGVKRUgxOTViYWZneWZ1by9QT1ZUTVRObFQwaVlyQWwr?=
 =?utf-8?B?Sm5PSXhMWnpIcEF4RVBjOGNSNU1oWmpPSTg0UkxVUXRpMkI1V0F0L0Q5NWRM?=
 =?utf-8?B?cy9aQ0ZVd3hVclJPaEtGMmRhclBrT3k0SUJWb1dER2NsN2xTSWhmSXFaZFJm?=
 =?utf-8?B?NjZZdnc5enlQRnhXaUx5MVdsMm9LZU5QdnZYeENYMXhkc0dJMktuZVE5VlRQ?=
 =?utf-8?B?a05kZm9oYkUwMGswU2hRaitQdEJhdGxUY1hNZ3hwNmpGNFJseWtjNlZPaXQw?=
 =?utf-8?B?UXRWUklMT05MMG9ZWHRVQlh4K0x0ZnpZL0ppWEVzSHVyRHJIY3B3SWdNSUl4?=
 =?utf-8?B?YWQySzRMUDQvWnMrUHBTbkRzWk5nTWY2RHVTcGNwb3RDQ1o1Z1dydGsvaitM?=
 =?utf-8?B?Z05RRnYzNmFYV0p2MzJOMkFUb0RyM2F1R2s5M0gwa3haTnhVaVZvSHJITGtp?=
 =?utf-8?B?YWtEYnVKUUhWaWgvV0ZnL3lRMkhaVGJXeEJqQk8vNWF2WDJEazhLOGE5OVJD?=
 =?utf-8?B?NU9UeU4vczl6WE41bWZZaHRRZXVrS3pROVJXTlhYWXg0b3BHaUEyMzBVZVJL?=
 =?utf-8?B?UE0wNjZCejlnVDkxcWUwY3Y4MmxlOWxDcmhuMlhzZ2tZZTUya1A5WG8wWlVK?=
 =?utf-8?B?V1BEL011YTMvUmcrWGNyOXVZTUM2ZlZoU1JvMGtkSVAvWUV3M3I5STN2b1R2?=
 =?utf-8?B?RnZoMWFwSW9tT3ZPcDlWTEJiaDAzK1dGYUl2ZStQR2xiSW1FbVZXNDVqYkQ0?=
 =?utf-8?B?SEdkL1hhTzcwaGNzY3ZSUzQyVmc5NmtkVVJ3QUloZUJIRnQvYlBCdmVSclBi?=
 =?utf-8?B?ZUU3cXZBcDRUd3F6WGFuTzZ6TDhpRDBWSm1qOTNtKzNnWVp6NHVKUlZhNTda?=
 =?utf-8?B?a21CT2Q1RnN1YmhsYUJRSXNNeHdzdkozb3Q3Qy9zT0lXWXZ5ajg4dGpNRjFX?=
 =?utf-8?B?U3JIRXFOMHpmU1BkeDlrZXVjV0JmT3lQRGFXQkRZR3plb1RROHZZZEMzd2JJ?=
 =?utf-8?B?cjg4R05za281elEyQmJEOStZOFREQ2JTVVM3T0lNVmtraXhJdDN0SVFKeTI3?=
 =?utf-8?B?Y2taSHdNajU4b0R3Ym1oQnlhaWo4b3hPUDhCMjJhdzZGcithZHV4VFFyaWFl?=
 =?utf-8?B?cGxRUTFKNElmclRqZ3VJSlpUVGt0dDNFWkdzM0FjeFZmYlFTbk5XWXlxSUs3?=
 =?utf-8?B?Z0Q3Q1pvSGs1dDhoUWR6akhiTjdwN25vSTJOVFV5c1VhdjFScWlrVTB6Sk5i?=
 =?utf-8?B?L2VLaHp5RlgydU1uaWZ4OC92ZE1TNEJzNFM4Q2ljclNZMFdFZ0VMUVVKVXho?=
 =?utf-8?B?akwyU1JJa3RVeVlVbEQveS9wV0QxQmhiN2d2MFB5NzAwQWlaellDZmUxUDhE?=
 =?utf-8?B?cGhHK2Z5d3hVVDNFS0JBRXpGWDBDanJUd3dxY1VZWHVnYnFvM0NzYXE3ZEEv?=
 =?utf-8?B?dWFSU0cxQ2pvb1VrQVlRQ2ZXNktJUjczRDlyYXhiNlpyb2F2SVgvdVRKVTAy?=
 =?utf-8?Q?+GYIn1zA2UUF4k4r4lIorSBsJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa166ca2-3fef-4250-a812-08ddc39db932
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:47:14.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWMv48X+pTNTdRW2FnbGxOfBdGspo0bLKO10VezYiD5Bw9yhImNj1BclrEvkSYpKAf1kMtJ451JO+UCbsJraVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

On 7/15/25 04:13, Nikunj A Dadhania wrote:
> Borislav Petkov <bp@alien8.de> writes:
> 
>> On Mon, Jul 14, 2025 at 09:36:04AM -0700, Sean Christopherson wrote:
>>> Or as Tom suggested, return ES_EXCEPTION and let the kernel's normal machinery
>>> WARN on the bad WRMSR.
>>
>> Ack.
> 
> That will panic the SNP guest instead of #GP:
> 
> root@ubuntu:~# wrmsr 0xc0010134 0
> [   20.804335] ------------[ cut here ]------------
> [   20.804336] WARNING: arch/x86/coco/sev/vc-handle.c:383 at vc_handle_exitcode.part.0+0xc1b/0x1090, CPU#0: wrmsr/607
> ...
> [   20.804507] SEV: Unsupported exception in #VC instruction emulation - can't continue
> [   20.804508] ------------[ cut here ]------------
> [   20.804508] kernel BUG at arch/x86/coco/sev/vc-handle.c:123!
> [   20.804514] Oops: invalid opcode: 0000 [#1] SMP NOPTI

Did you fill in the context with the #GP, i.e., ctxt->fi.vector and
ctxt->fi.error_code?

Thanks,
Tom

> 
> Regards,
> Nikunj

