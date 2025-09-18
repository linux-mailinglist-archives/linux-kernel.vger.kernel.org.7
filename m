Return-Path: <linux-kernel+bounces-755767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C0B1AB88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154563BF49E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E62900AF;
	Mon,  4 Aug 2025 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nzElplU9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95728D849
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754351023; cv=fail; b=gesw5dQvY8E4ZsJoBlBXFp1e9XyOEFM3ZeKsE/vOiUegjphmHKT9GL/KxFA9QGle1rRAoH5ceCyfm0WYnJ2Jv9eO8/b7XOtZvn1o0/RF1KkY9d/3NRHWhdgh7Si80CX4SfdsPfzgCW81fcgnQmhqyn5tuu75fVKAixYBxJBHzh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754351023; c=relaxed/simple;
	bh=9DXZKO6B80AqCEltwqPn690AaSVor57NcUMFVt49TzU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D+OOxX835673Vr4vI96hCECs+AF5XiyuvBi3b6cvmzHX5SQYGvNVGDXESkSZpcG9pLvsJSqY8bcdWGb8rkplVX0MiEZbfRsH8KE8mfs5LPcKFGsmj8zzqcfEnI0u/UiWa0/lrj/2udWkJXwUhD6M3PGVnygrRkJ4jlD4U1TVm/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nzElplU9; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAF0PnPKywGX4INUZz7chWGO9/c1CPPpwlnMCnV874XJBQ1SnQvIXB0V52eZTiHV11EHA1X2KGkun4FW+lPeazdSSWRPKTbCdJHhg/BhhEoHi3ThZMHgA0yoI5Lx810G+Gcqu+YSTNzrImksxG5xwpb0puHhhCG17mTPTP+5QhxN2bNhX73o9IGzJgw4kuDIvr7Gk6vctOYeWwKH17Bdadar6gUkPnhump2MLGoHKY8m/H3I8iopBrY7n6JdjNHmtpqC809cVoF9eqlE9xoPqaAAoFNwygyAdESFKLWp8KcxhSsSVHC2p82mqrWrgh5+oTTpMAl1iCRHSdj+yHrWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=504BX8UwpsdLLJ0YkYXX70XLU3JVmDjmy4llwjVAswI=;
 b=Cfgya1HHSWtNctEWDYfiCM0zCRw03Eyit5IZCw7RRM/qpsh8Wch5JW40tkpxmd7kCeUUCAlYGOHcmeQHjXhzjPdubMAiCyFqIx/eWZUdKofBgdzaKCiMOh6TJqwwg/EwJnbNIpFejfNznip9UfrIUov6kE4e1xW/NyiI8p0Gs4YKDlsJJ00zKwPPlZ0t0LrW5BFbGXypo1Wt8FuS5iPuzLxdOPfqNWXIpi/NiNx6Lfh9SQ7wtJgzH+n+Owxomn1/KiHyuuuvDfwxgAxl7LQcIHIooXHMDC2rQDAAyNsCXjmyWNlP7vg8SDNKuTqnJJrT0IwL8Wkj3Vgt04bIMWdK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=504BX8UwpsdLLJ0YkYXX70XLU3JVmDjmy4llwjVAswI=;
 b=nzElplU9g+mnZaGXB35Ym1sBTOFUN8WGG6l3pMXHemT6HwWagvEcPXo2j1lJ2C2H+NCO3F0etmoNH6VnGToanWJqeiR2XiTIvcfy/Ad1H3/cKZ6o+AcfSFFwAAcW5grJsV0BZy4afUG/MTBNrD4ZrZLvTyW92ucvruov/5JG0kLwlcPWF391tuokXlrp8hcwFdc/qZce62cz/qR0DY9b62JwKf110LpOaQapZwBn3lTDNMKivdKgCLew0DThgzmxr+PsS1ai5mUYsJg5fRvyBeZ0hAcdi/6MSFB0LWtx0VB2CyrIypxJQF9DVr+wVq23jNOMn8J/pOzxgofH+cLF+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 23:43:35 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 23:43:34 +0000
Message-ID: <e8dc674d-39c1-4ba4-99dd-9b0efc6ad466@nvidia.com>
Date: Tue, 5 Aug 2025 09:43:28 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 01/11] mm/zone_device: support large zone device private
 folios
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>,
 Ralph Campbell <rcampbell@nvidia.com>, =?UTF-8?Q?Mika_Penttil=C3=A4?=
 <mpenttil@redhat.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <20250730092139.3890844-2-balbirs@nvidia.com>
 <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <dbebbba0-3c59-4ee1-b32c-4b9f6ed90d92@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: d235686f-58da-43ac-9c8b-08ddd3b0ba02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3FDWEtxMk9JK0NmYUFuUm00SmdEMWdOMGNxamtvMlZGSEZhT2RpQkRhNkZs?=
 =?utf-8?B?blN4UFJJVVkyUllkZjFnMkJZZTAzMkhSQUEyYk1Hd3ZidGczNWJKN1NzSWtk?=
 =?utf-8?B?cGU1WDVTWFF2b2pkd1UzUlFzWDFlM0FmbUVwSlhnWDZkZXFIKy9IYU43L3J3?=
 =?utf-8?B?MW41b3pxQkRHTXhUR3JGcHZBSHF1RU03VVRISGU5ajVyZGNRQmRlZjBiZnhG?=
 =?utf-8?B?ZS84SVNZVFg5eGFJZ1o0b3UveDJRZE9KaUR6QklyQW9TZG40UEt6TGJBY0pT?=
 =?utf-8?B?QXdPNk90RWJXc1REb1dBQUduMGgvaVdKdm9KbnF2ZVcwaVBEQ3ozU2R1Zmty?=
 =?utf-8?B?QWtTTFZBa3duZUtzZExKay82Z3JFZTBJaXUzb011RmsrVXAyeFVQZXhsMjYr?=
 =?utf-8?B?aWNITldMN2lRblJySjdsU0szemF0NUIzMTJkWlhUWW1lZ0hQeUpHTDNVY1Fl?=
 =?utf-8?B?SURUdWFKOE94VlpLNGhpL2ZSVjVrT0ZGUW1SQWJyWHgvOU1IMGJzT2Y3RzRY?=
 =?utf-8?B?TEJHekFPTTNDeUlyZWZCWDRaYzVpOXpySVdRenc5VHYwVWdFejAxMmdRSlI0?=
 =?utf-8?B?amdKRU1SQ1ZIMWVadGxOZTdvbGs4eWxTa0xUc0dBWkpqeWJTL1NSdWJtTE51?=
 =?utf-8?B?U0FaVzVTWHlOZGZBOW9pWStEQ3FsVURIbnFTWitUYW5mNXZHd3hTcEd3a09Z?=
 =?utf-8?B?aUFmdDRUak9DQkpBQWNmUVN3dmVXalJocHIyQVovRjhSTEFaNzJsRW5uR3Y5?=
 =?utf-8?B?SjZPZDdSYWI3ZlNxV3Z6MUNlU1E5SjIyeXJ2d3RBV21WcTFrOFdzaDVzcmFL?=
 =?utf-8?B?MlVYWHR1bHZQT1l4UTJnOFE5clM3MmdJV1FJL1VsSHZYNnlCK2htaWRaWEVn?=
 =?utf-8?B?cDBWZ0lGK3F2MnUyV29Jb0ZoYnkyb01UUnZBbTY4ajFYREJ1MmNoQi9uWlV4?=
 =?utf-8?B?a05OV2FVai9oOGVoenhEMmR3K2hITVZ4MGZDUjQ1akZqQTVBS1A5SUNlbklX?=
 =?utf-8?B?enRpRXQ3b1ByOWl0ZWVaQTZ0Tk1ZcFc3bDFDVThNRVpONDJjTU0vUzJFekRO?=
 =?utf-8?B?bytCdjhlNmRzZ25uVitCNUVLd1dpcE5STDNHWmsvVjJjYVpNNlE2QWZWYnls?=
 =?utf-8?B?eXNGcFNuVEFTUE5FUXZiTTBxTy9IVFFpVHNsR2t2WVdYbFRzRTNHeXlpdnVW?=
 =?utf-8?B?R2NuaDBKMk9xTUpZUmNJa3dsU0lzRzEreHp6OEFBZVFaUllia3NTNmUzbzJx?=
 =?utf-8?B?Y084eHpoTzNIZ0VXZ3NTcHlWVzdlYkFLZVFLUDludllkZ2FYUVBmMEhtTFdV?=
 =?utf-8?B?TGw3T1NOT3I5K05tQ29jQTYxaTFuUHdYalRUVncxTGJIdnJ1RDhGWHdERzJl?=
 =?utf-8?B?V0Fja05IWmFyMllTUjJPdFV2L3VDV3VRbGlHL1ZKcVNXUEZEVzB6OFdhUnJS?=
 =?utf-8?B?ZVExWGRkT3hNd2swd00xU2UzMDN2YWVhS1M0VTVXTmdibDVNRkpCd25YaGVJ?=
 =?utf-8?B?WDV1eHlMSmprTkRqbUJMak9BQjRVN0h5eEM0TG9jelhMOHk1UjQyVERoOEJ6?=
 =?utf-8?B?RSsrMmJhMEhaa3NWb2dGanRqV2s3Wk5paGczM1FNdzJsd2U1RDkrR3BlT1cw?=
 =?utf-8?B?R2hmak1GU1NabTNGUVJGZU53OVVqdzJCcStJMllldG5ja0hsTU9abldYTG8w?=
 =?utf-8?B?MHplK0RablVIdFB4T0lmQzJLUE45S3h5UWI5dG9IcFArVkhFK3JnVGUwcUtI?=
 =?utf-8?B?ZzhnS1JETlBLVEJuck9ocy85L0d6WENUWDU3Ukc3eUUweDgzUHEvYzczVUc4?=
 =?utf-8?B?RDFkSmJxUDhmMUVSWWdZK2JoVjlXVXM5MkY2Mmo4Y3UwQ0lJTGhiMWQ5cktk?=
 =?utf-8?B?ZVV3bXVMUksrWlRoUWQvVU9hZ3JISWU3Qk1laWV1WUlkcmYwVFlYekVKTmJk?=
 =?utf-8?Q?X7bZTgxP0FE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ZQYWZOMGtDKzdGeWJLSEh2alpRcVF5MDhHU0llYm9SMm5zSlV6enExQ1Ni?=
 =?utf-8?B?amo4OGJxZGhacDJkSFNEdGg1K1l5T0RpRU1OelZqekM0ZlVRbWVTRXVmdUpj?=
 =?utf-8?B?eUF5dytpTFRjMGVldXlRYk0vbzFkNGpTaUt6c1BjT1g3QVgzNFl1RXUyV3FI?=
 =?utf-8?B?UnN0bkxPOFc4Vy9ldUJYN1JUTEN1WUtHdlRWTE9rRzFpQmhQc25YN0lkaEp4?=
 =?utf-8?B?dlhWOC9Pc25IMmVOU1h2MmtYSVFHZHQ0S0xiTEhPaEtncnk1WWs1M3VxZzlj?=
 =?utf-8?B?MmJPTVJSWjNuZWVyV2ptTkhBS2t3eGJVNUFlNHEremg4cGFULzJ0WFhsdkh0?=
 =?utf-8?B?bmFrOHVDZ3BqUHFBcjUzdUYxL2ZkZElKOWhONkk0QVM3TFVJSzQ1a2dQZ2pC?=
 =?utf-8?B?Y0VYbzhOZ1NINk9teXpZaC8xa0FyRWtuSWtrdFl5U0k5L0V0Z3Q0dlpkcW9z?=
 =?utf-8?B?MUVnNzRyK2xsckNSeGFmNFZtSVQwUGpkUEg1ZlNBTlpsc1BtNzRYVVhaM3BG?=
 =?utf-8?B?SGpoeEdkNzFTRHlWRXBKN0NVRllvWENlYWs1aDhxdzRmL0JKdFFpSWF0cUdh?=
 =?utf-8?B?WnBqZk9Ub2dQZ0ZCbUpBekVVZjZ0UWc1U09YdTNEWGxFbjlXOTczY0dvMVR2?=
 =?utf-8?B?VHltMW5PTEg0Sm9nUkh1dVA2RnFmMndUcmxYK0JqdCtCcDRSL2dxdG1mYS9Z?=
 =?utf-8?B?R1l3ZzhOd28zRDUxMjhwcWVpQVovL2ZsOVZEQW5Xbkw2aGR0djl5N05xdnJ3?=
 =?utf-8?B?NDVibUNRbnRjM2ZLWUNMQ2J2Zkl2QUtIRFVLRVhvZ1JrRFI1TWJ4cFlod01p?=
 =?utf-8?B?SmR3eWlXQzJZOXhUQjJPN3lGdXhwdDVzbFJaMnB1RjBzOGJmTWhxS2ZNK2lx?=
 =?utf-8?B?Vi8vWkpvZ1g1Yjk3MnJzck92Qk5GZ2szSW5UQk9IbUpydVRtWDAyN1FuNjV4?=
 =?utf-8?B?UkhHc2xUdy9DVnZiRE5iREJ0S3pRbWdZMS8rMVFUSUFFL3llcVNrVEg2b3Bz?=
 =?utf-8?B?NmcvVnpLNWZxSTlxRU5HUzNTOStsQmxZV3laR3ltdTluWS93UkhIeUEyOVdM?=
 =?utf-8?B?VVV4eng1cGtTR29Eb2xKcXI0ZXNrMUQzdHBGaENvWCs5cEZYQ2JNaUNFTnJI?=
 =?utf-8?B?dkFFL2I0ODZFZmdpSEU0UVAvcGJVZ0lzMEJMUURSZTFQNm5yN3hvTEVnelRs?=
 =?utf-8?B?YnUrUVVZZk9zaDhTZ2UyVWJCS2lqdHlzcE42ZjBUbDNPNEhVSTB5dkdDOW5o?=
 =?utf-8?B?cDM0a24zZjIzZ3d6RDUwcm82eDJUcC9FM0xtekx6aStqRUdGZlRsdDJvVFJQ?=
 =?utf-8?B?VXBEYnFMQ3MrS3orek9HU1k5RnA0elpHVVh3dTBSdDNIMHhZQnhBaXZBc3ZL?=
 =?utf-8?B?YmxWODN5NE9pYWdER01xQTI3Vk9sdC8yTmRPZUllWlJzOUJmNjFja1pSMzF6?=
 =?utf-8?B?VkpVYzNTU0Fzc0FDU3ZrTjFkZXI3YnczSTRleUJ0WGduaHVETjhaZWt0elZx?=
 =?utf-8?B?YmQybjdRV3Qvams0YkkyZXhyMEU2VW5qR3dFUERxT053V2RVSjNxYmYrTndq?=
 =?utf-8?B?S1dHellzVHdNUGRHK0VGSHFjMnVtRDJSTXI3bjZvUnppRmh0NUlJbjIyYmpM?=
 =?utf-8?B?UVFXNkV3b1NrZzY3OFF5LysvaFVOZGxTN2RLWTZRVmdKcGFtVWpMWmhraExm?=
 =?utf-8?B?OHVjVFFTb0FPOGFJcGRkcStwS0hvQVJSZzhuSVJrQmVFaEliRzYvV3Z1NGNl?=
 =?utf-8?B?Y0FSeFFOSXhwTVM2R2lXK2ZVeDY2Qlc1SFpwR2tUNVY3Y3pvZTZWbGE3bmdk?=
 =?utf-8?B?YkRUOVJhZ2wzRVJpbGlhZDRqcW50YUYranlHVEozNWNlNy9YbGkvajQ2WWc1?=
 =?utf-8?B?K25OcXJRQ3VsUDRRRGUxZ3hjVmZ5R2pXK2doUERkQi9yeldrTkNBdVBhTGo2?=
 =?utf-8?B?MXZ1bWFlVDY2QUt4ZW56TElacEw4TWJJbUlOZG9XOU5sdk5LOFZobm5JMjdQ?=
 =?utf-8?B?b0Z2VldxN2VSUzlzbUo2YkFjUWRzem9DNW9JY1hRQWpSeXVZa3hEb2NHNzZa?=
 =?utf-8?B?Zk1iamVaWStVRVVxY21UVFBwRzRLc3Z4WExjUGtaUGNwenBrN2xlL3V5U2xn?=
 =?utf-8?Q?k7Y3yQ26xG8QLo4Ggi5sUTWm3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d235686f-58da-43ac-9c8b-08ddd3b0ba02
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 23:43:34.6915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfbebp1luw1roOEWGEJ74k43+E+u9uTTwIIxaGDiiV7OoKQfCgES+BqAolrXjCNVefRXRZc1GS1/jzJsHV+5TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047

On 7/30/25 19:50, David Hildenbrand wrote:
> On 30.07.25 11:21, Balbir Singh wrote:
>> Add routines to support allocation of large order zone device folios
>> and helper functions for zone device folios, to check if a folio is
>> device private and helpers for setting zone device data.
>>
>> When large folios are used, the existing page_free() callback in
>> pgmap is called when the folio is freed, this is true for both
>> PAGE_SIZE and higher order pages.
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
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: Mika Penttilä <mpenttil@redhat.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Francois Dugast <francois.dugast@intel.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>   include/linux/memremap.h | 10 ++++++++-
>>   mm/memremap.c            | 48 +++++++++++++++++++++++++++++-----------
>>   2 files changed, 44 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 4aa151914eab..a0723b35eeaa 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -199,7 +199,7 @@ static inline bool folio_is_fsdax(const struct folio *folio)
>>   }
>>     #ifdef CONFIG_ZONE_DEVICE
>> -void zone_device_page_init(struct page *page);
>> +void zone_device_folio_init(struct folio *folio, unsigned int order);
>>   void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>>   void memunmap_pages(struct dev_pagemap *pgmap);
>>   void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>> @@ -209,6 +209,14 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>>   bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>>     unsigned long memremap_compat_align(void);
>> +
>> +static inline void zone_device_page_init(struct page *page)
>> +{
>> +    struct folio *folio = page_folio(page);
>> +
>> +    zone_device_folio_init(folio, 0);
>> +}
>> +
>>   #else
>>   static inline void *devm_memremap_pages(struct device *dev,
>>           struct dev_pagemap *pgmap)
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index b0ce0d8254bd..3ca136e7455e 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -427,20 +427,19 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>>   void free_zone_device_folio(struct folio *folio)
>>   {
>>       struct dev_pagemap *pgmap = folio->pgmap;
>> +    unsigned int nr = folio_nr_pages(folio);
>> +    int i;
> 
> "unsigned long" is to be future-proof.

Will change this for v3

> 
> (folio_nr_pages() returns long and probably soon unsigned long)
> 
> [ I'd probably all it "nr_pages" ]

Ack

> 
>>         if (WARN_ON_ONCE(!pgmap))
>>           return;
>>         mem_cgroup_uncharge(folio);
>>   -    /*
>> -     * Note: we don't expect anonymous compound pages yet. Once supported
>> -     * and we could PTE-map them similar to THP, we'd have to clear
>> -     * PG_anon_exclusive on all tail pages.
>> -     */
>>       if (folio_test_anon(folio)) {
>> -        VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>> -        __ClearPageAnonExclusive(folio_page(folio, 0));
>> +        for (i = 0; i < nr; i++)
>> +            __ClearPageAnonExclusive(folio_page(folio, i));
>> +    } else {
>> +        VM_WARN_ON_ONCE(folio_test_large(folio));
>>       }
>>         /*
>> @@ -464,11 +463,20 @@ void free_zone_device_folio(struct folio *folio)
>>         switch (pgmap->type) {
>>       case MEMORY_DEVICE_PRIVATE:
>> +        if (folio_test_large(folio)) {
> 
> Could do "nr > 1" if we already have that value around.
> 

Ack

>> +            folio_unqueue_deferred_split(folio);
> 
> I think I asked that already but maybe missed the reply: Should these folios ever be added to the deferred split queue and is there any value in splitting them under memory pressure in the shrinker?
> 
> My gut feeling is "No", because the buddy cannot make use of these folios, but maybe there is an interesting case where we want that behavior?
> 
>> +
>> +            percpu_ref_put_many(&folio->pgmap->ref, nr - 1);
>> +        }
>> +        pgmap->ops->page_free(&folio->page);
>> +        percpu_ref_put(&folio->pgmap->ref);
> 
> Coold you simply do a
> 
>     percpu_ref_put_many(&folio->pgmap->ref, nr);
> 
> here, or would that be problematic?
> 

I can definitely try that

>> +        folio->page.mapping = NULL;
>> +        break;
>>       case MEMORY_DEVICE_COHERENT:
>>           if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))
>>               break;
>> -        pgmap->ops->page_free(folio_page(folio, 0));
>> -        put_dev_pagemap(pgmap);
>> +        pgmap->ops->page_free(&folio->page);
>> +        percpu_ref_put(&folio->pgmap->ref);
>>           break;
>>         case MEMORY_DEVICE_GENERIC:
>> @@ -491,14 +499,28 @@ void free_zone_device_folio(struct folio *folio)
>>       }
>>   }
>>   -void zone_device_page_init(struct page *page)
>> +void zone_device_folio_init(struct folio *folio, unsigned int order)
>>   {
>> +    struct page *page = folio_page(folio, 0);
>> +
>> +    VM_WARN_ON_ONCE(order > MAX_ORDER_NR_PAGES);
>> +
>> +    /*
>> +     * Only PMD level migration is supported for THP migration
>> +     */
> 
> Talking about something that does not exist yet (and is very specific) sounds a bit weird.
> 
> Should this go into a different patch, or could we rephrase the comment to be a bit more generic?
> 
> In this patch here, nothing would really object to "order" being intermediate.
> 
> (also, this is a device_private limitation? shouldn't that check go somehwere where we can perform this device-private limitation check?)
> 

I can remove the limitation and keep it generic

>> +    WARN_ON_ONCE(order && order != HPAGE_PMD_ORDER);
>> +
>>       /*
>>        * Drivers shouldn't be allocating pages after calling
>>        * memunmap_pages().
>>        */
>> -    WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
>> -    set_page_count(page, 1);
>> +    WARN_ON_ONCE(!percpu_ref_tryget_many(&page_pgmap(page)->ref, 1 << order));
>> +    folio_set_count(folio, 1);
>>       lock_page(page);
>> +
>> +    if (order > 1) {
>> +        prep_compound_page(page, order);
>> +        folio_set_large_rmappable(folio);
>> +    }
>>   }
>> -EXPORT_SYMBOL_GPL(zone_device_page_init);
>> +EXPORT_SYMBOL_GPL(zone_device_folio_init);
> 
> 

Thanks,
Balbir

