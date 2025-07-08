Return-Path: <linux-kernel+bounces-720986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A002AFC2FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FB61BC0E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB3222575;
	Tue,  8 Jul 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qAHU1Ofc"
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539312222B6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956881; cv=fail; b=LQaeaJ8LpVSrFODSeqLPPEvKfxfEfka7NIVdSf9cfvYRmr/3Od9OWVtBkEDS7rh4eDiQHOxCmQWHGzdzM4txb6KkXC/sRpBld2/3iiOxRKSlseMz8+++MOHpM+RfsA04d5oxBaX5BDsoQT7WyW8F6IE2DJHOnPuhl5kY1JMEDjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956881; c=relaxed/simple;
	bh=UtFCPLCqXMP7ruIIrLLDfWK8ThjvbksXrvBr4plza20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FP/4g21Al4TGhJTEGXZ5FL2Fuau0YtMxBr6gX00X2nnbS2Bu2BnjH5homh8W/1aJKjqGtWH0u2Wp385WWQnk0jDB9xhesF9agiEmTuRji0zEI2jme0uyNtQrWTIXATVwtM3A7g0rJoOHqEJtu+b8FLaOCreMNHJzk+kzITjdb3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qAHU1Ofc; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1751956879; x=1783492879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UtFCPLCqXMP7ruIIrLLDfWK8ThjvbksXrvBr4plza20=;
  b=qAHU1OfcZIchp9mmBJb8dF+f5H5FkEtXwzNUTD3o8wnWzqpXVCCJQoI2
   gikoatA6430h2NwzmMgWYufjVzYQH6kOmMqLEaPZHRM9SUvQ5VQiBKS35
   1S2ZvAfJu1sfv9BS3Ip/8XC72ADezhcTHwbZJGuga7F3MXeRu81+uwdmD
   B0UQVzwikL4FOr+D0PNyIZPer1re3rg8M+1m9vBuyJrF9EEjl5NYCvB7R
   FBCaCPvfdIr6F5SAY5wiHr9857Cd1blcyGNqNZdZm5awsJ6ie3yeN1ag5
   xw8ubyQa8soj+h4gYq5TWteeSOUx4Odz6qXElgKbfq04rins8339mcJ00
   Q==;
X-CSE-ConnectionGUID: 28WpNIoeTYaQ3uKuUzb8og==
X-CSE-MsgGUID: JD8uB3/kSgyLrgDryfikmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="73878963"
X-IronPort-AV: E=Sophos;i="6.16,296,1744038000"; 
   d="scan'208";a="73878963"
Received: from mail-japaneastazon11011036.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([52.101.125.36])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 15:40:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZuj9qQHoNJs7n3fC4J/N7sgJaokt0ozcWM1YhKrSSJPh1ssBa/VZ/dsJELPPkET0U+1mCjU+xSD+YHsVkuORAiBP8VdsNgcO9jFNKdekpyiwJQsG+Tket1BtLGre4ASqoxBMkcS0gxWFiXu40BOu9FcKSqO/kGbBMMvukq6oqllXOJlIGfEH83P1Z1wA8lv30qMuTLBMbATGXz5RbPqJyqQTuILWYwET2BMrssbOJhBylu26kp2fKeyEYhARSS5O9JW7jEOza3sMS+i/4e/wuVcXS7+4BiwL05sbhAfxutgmyD9YJOev2L9ASdNNWwV6iiE8DDON5SYoIJjKw4CVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtFCPLCqXMP7ruIIrLLDfWK8ThjvbksXrvBr4plza20=;
 b=HcgDpt7b5zVd4kedRAmaABEqotkbIMQkB6vnr8PbCYiRKFN+ltJFszGmXG3xsxoDvexERSFHI46k05MYuUgvT9H4VuzXaTBr7gioG8QSXb2PiRGlwXJXeyx9DrT5tJDsXjhnOEZKqeAOIftw/PIGVMRBrliK87KK8N3YoK9PdiuWynQtro0Db1pRpm/5E6BDqN7MV2RwoW36OwyW/u+d6hLI8z8E+1sHkvYXBxA0tAjrQVReizxceowwXmOsZXgRf06Mh9sCmblULw3j7Xc9ku0PGEOqsepvM2lep5XRRFjNTkeExRKA5BRfw8YKMbUXOjISj0eYQlVT2ZNrnbrDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com (2603:1096:604:3a3::6)
 by TY4PR01MB12838.jpnprd01.prod.outlook.com (2603:1096:405:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 06:40:01 +0000
Received: from OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0]) by OSCPR01MB14468.jpnprd01.prod.outlook.com
 ([fe80::5078:96dc:305b:80e0%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 06:40:01 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yasunori Gotou (Fujitsu)"
	<y-goto@fujitsu.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
	"lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
Thread-Topic: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
Thread-Index: AQHb5XbVZg4Ev2RiYUGAscIFS7XkjbQa/WiAgAyC+G6AABQ7gIAABeW1gABA0oA=
Date: Tue, 8 Jul 2025 06:40:00 +0000
Message-ID: <4f98ce21-39da-410b-bec0-2b6f240e550e@fujitsu.com>
References: <20250625021352.2291544-1-lizhijian@fujitsu.com>
 <e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com>
 <87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
 <ef637fe1-436e-4003-86fb-47f651433f7b@fujitsu.com>
 <87zfdfwg8h.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <87zfdfwg8h.fsf@DESKTOP-5N7EMDA>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14468:EE_|TY4PR01MB12838:EE_
x-ms-office365-filtering-correlation-id: 1f2079bd-413c-4390-6ba6-08ddbdea439c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlBaY0RQMWk5bUxqWmRYeVlqbnBqWDhWUEkya2g4cGN3KzNhbjg3dVJTOEtq?=
 =?utf-8?B?UWZZWFc3TjNOZ2JiM1NoWGVKOXNqQTZ1cU01em8wNjUyMXdCN0kxcC9wNXhG?=
 =?utf-8?B?S1M0My90RGtQRGQ4dURPQUZLWkFDTXJzanVzRnZscXJUdzN5VlhXRXRiK3VQ?=
 =?utf-8?B?VmRzNlpvb3JESVZIRks5Sk9XNXZ4MGR5bGZWaUprSEFDRmhFZ2JuTnhiN3dR?=
 =?utf-8?B?VE9zSWNsNDJoODFJWTJINjhwUnU2NW5PMlhrSm9wRFcvTk5PM1VETi9VZVF1?=
 =?utf-8?B?RGgxTGZod3E3aVAvZGVPaHF5N3BJWjFDcDllYkhkQkRCUWVDY0tjTjJtY3pN?=
 =?utf-8?B?dVJEZVNLaDFlbk82OVdSZHdmYW5CMmtZeVRYVDh1TCtUQTFqcnh2QVpVY0R3?=
 =?utf-8?B?aEsvNUxFdHBqeWRidmhJa09Vb05uSmdZQVJrdmNEVWFib2RhRE82V1hPRkxp?=
 =?utf-8?B?R3Z5TnMzaFNtVEx3VzJtNnUwOVI0cy9yRDBLQ0I1TTdXdGc5eENMVFNOR001?=
 =?utf-8?B?TEE3R21Ea1JjdUJLRUVlS3Fka25yT0tyWFBndXpkOUVmWFp3cmhsUmpOd2Ry?=
 =?utf-8?B?Vkg3Ukc2K0Z3ZC9mSStzbnU4MmFVWFliVkwyWCtXR3Z4QitiMlhrdEs3VDFG?=
 =?utf-8?B?NFdKbkpESEQ0UTEwWnJ1b0FibDB6WERJc1hoWi9vcWlPRUxOR0trc1ZFS2hj?=
 =?utf-8?B?aERQSlBNTzRhQzUvZWtwNU1LTnJrN2NrcHZTS3F5R1ExUVFxd2poSzRzUVRV?=
 =?utf-8?B?K3AyQVhvVlZvZjArbXlCNmlFWER0bnp2NkdiTVJycWRIRmFQc1NmcWc3OCtU?=
 =?utf-8?B?MkRBTmJGbG9RcXhNVG9OMjdaOFJYblpsTGlWa0VGMTJtaHl6R0prMVQ5bU1T?=
 =?utf-8?B?ekRVYTF2eTd6c05yeUpNN0lRWGpaeU95SnFIeHYwMDd0QnQ0aktvYnBvVW93?=
 =?utf-8?B?emRZbmMycE4vM0JGbE5XYkRSMTVjVXBsSHY5R1Bnc0YyNnBiNVNVMGVGMGpo?=
 =?utf-8?B?TTB6Tk9GekF4NW8yN3ZPQmxVdkpPcmR5eHBiTzBOUTZ1dlQrZmFZc21JbzFu?=
 =?utf-8?B?bjhHNnhYZjErY0ZudlpYVDJaMEJVVk9PY1prVE1XZ0VIdkh2NnEwbUM1TEdr?=
 =?utf-8?B?NkZaaDUyZGNuSkNML1RWd2JhazNvbEZNc0JlVm9qazQ1MVhveDNkZWwyeUI3?=
 =?utf-8?B?bU1OeDhRVjhMQ0JiSHRTbmlwckFSOXZra242VnpDWDR4eWx5cTVOYzVyM3Vh?=
 =?utf-8?B?eGErWXozKzBEbzBhTDdSd1J0cjdBS09kYkJGV21pdW1MRjVDamE4bHpnWndT?=
 =?utf-8?B?Y1VDdm5ua2ZtSGJvdnh3MWpxTFdhTWR5V2hhV3V5c2JUQkZMd3E4WmQrdHVJ?=
 =?utf-8?B?NzNBcnVoZmpTa3g5NURFY2FjMEFKaDZtNm52TkRMWFYrS3RDbEI1UFdiTkNC?=
 =?utf-8?B?czh0dlRWVXgxNzFJZUN2eHp1SGoycyt2Tk9YMlpMdWJKaG5mY3AyOXNPeG52?=
 =?utf-8?B?ZG1hOXZMOGtteHVGWElYWXZEWTIwN0VNellQM0NsZ3h6SXhJeVpnMWRjSGM5?=
 =?utf-8?B?OTg3RlR6aXhpbS9kNndMVHhvR0NRNzgwcE16ZVZlSTRUdU9XOEFWaXVTZUlW?=
 =?utf-8?B?anpaUGtKSDNRWENyem9lOEhsc2p0ODUwKzBycWZOWTZzMGxNUFUyelY3SE92?=
 =?utf-8?B?M0dEQ1gvWDUzeFhzVFduSWRzZmluV1RjR1h4cTI4SlViKzNsamk2OXR0cW5k?=
 =?utf-8?B?a1NHNDZrRm9KZ2Q4dnVpU2JWTjYzb2RObjhmSUVxTmljbzhOYjRvVVBDSk1Y?=
 =?utf-8?B?bC9wekh4bjh5eVgvb2hSY2tFVlBDWU9HMXlIekZGZllXL0grQm9IZ1hGWlRk?=
 =?utf-8?B?bFdkZmN0bHlOUE9WcmNDR1NPSWZTblowUldHdkUzLzNnMjBJVEJaTU1PY1FC?=
 =?utf-8?B?Y0NDbndQS1RDb3o4bXE1aFFRd1pCY051QTN0QjloYXIyR3dhYk9KM09IcVJN?=
 =?utf-8?B?YjFKOVFvNkFTdVBKQjhjNGRZbTdpNXd5RjkyRjNLQ0dpU3p2Mkp0ZkFialEr?=
 =?utf-8?B?K3RHb0kwYnNwY3EzLzZDa2gzbFI0RU55SmJ2QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14468.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alQ2OVluViswc3Z3ZFM5TUVxcDM3dkE2bHRpbXZXTVZ5YjBOcUltdTVyVVRp?=
 =?utf-8?B?UWl0QVM1RWZIcGpHLzVaVERIb2E3Skd1S0NWcGFzclZDVDNxMDNhZ2ZqSUIz?=
 =?utf-8?B?Zkh0em5YMWRkRlRtelB0cmMzM3dib2Y4RG5jL0tUTjhkYkMzQkFKVXhIckMx?=
 =?utf-8?B?QXlkZk4vaVpkQmxHVUV0cHZsRzB5S2pDdTJsOHJtRG1GMXlrbU0yTnVFZkQr?=
 =?utf-8?B?bjczWUh6S0grNG9mbjZ5YktGL3dKY3lSRDcwQk5INXl4WGtPaDdVU2tEY0Qw?=
 =?utf-8?B?eHRsYjFkZk9iNEZsNDIrRklPWlYzWFk2NGx6MkF0REFRVkNnK3pPK2p6R1FR?=
 =?utf-8?B?NStlaW5OQmxLaWN6OTVRVTY0R2VzL1ZIODBCa3htUDh6VlpWOU9aU3U0VHRa?=
 =?utf-8?B?VFhsRElYWCsvTWU1cEF5T00wVWJhSHZKK0drL3JxOUhPYTY5bTU4djd5RnIz?=
 =?utf-8?B?Q25aSUFiQnQ0cml1Y0Q4OG13d2lnbFM2RGlLb1FzOHVrL3pOaE5mOGprK3ZE?=
 =?utf-8?B?WGw5Q3RVaWdZM1l6ZFEzK0tQRkY3Wlp5Q0hGZE9kc2lrSkV5VjNsTEw0M3pu?=
 =?utf-8?B?R3d2RU9HV29Kb1pGSmF1NklTL2JZT1ZKeCtHU21iK0VYVkdiV2hmNUx0dGts?=
 =?utf-8?B?WEVMblNxNjN5eCtjWWNVbDBxNGNnWmRaWjFVNVhpQms1ekhiVjlqMElSMHN4?=
 =?utf-8?B?K2cyQ0NjNERUNEtuL2NiTklyYk4xMlFHV3hmZVlUOG50M0Q3dWY2a3ZFY2Yx?=
 =?utf-8?B?L0ordGErSFJRRlJFc0UxbndwdGxrSG1jTUpRR29pUEFlc3h2QTY2ZWVQdDBq?=
 =?utf-8?B?aHo5WEMycUl5ZlphMkM0SkIrNHhadUEvUHlHdDNNeXZYY0hTcXY2dThBdEhG?=
 =?utf-8?B?M3NncytWWHpPZFdOVG5xTG03c2UzQkJ6NHlxZXJGYXlHTHpLWVdDUmI1T3dG?=
 =?utf-8?B?ZFVZSU1LVk1yU2pNU0xXenJpTHVHNDA3V1ZBODRNdWRWNlY5bThTSENpb2lu?=
 =?utf-8?B?d0M5NUJmU3V5VWFTeTV2cS80aVhEZTJrS1ZQQVEwckYzRXpSaEltcTk0WFdF?=
 =?utf-8?B?TXVLSUdEbko3V2UzaVRMRUtJZWRwRnpkNnloN2UvMmxFSHZEbEhlT05LQTFR?=
 =?utf-8?B?YlZreFRLTkFNVEh0ZTR6TmNoSm1sTXpGTWFBbWk5cHN0Y3puaGJQaXJlMks1?=
 =?utf-8?B?QzRzYk1BL2Y3Q0pwNVJOVm12cTkyY3lPL0hVaHBvTWF3R0Uxa3FieDYwRjQv?=
 =?utf-8?B?d3RkUlFtS1RzOGhwNGlHSDNCQ0xPLzVReXdRL3hpTkpnQjRFSWxtR29WMUUy?=
 =?utf-8?B?M0NOYkxVUStJajU1eDNzcCtYbXBISWM1QjYwYkNnOXNVNm4xNnpvcjBZK2Q1?=
 =?utf-8?B?OGUvQmZoWG5tMytDcWQrUDRENE5rdFNvd0xncm8yanVZS1JqODNZSFpRN0JX?=
 =?utf-8?B?UUQ1aTA4ZjlPdEgyaUZJL2g5d3J5QWNZTWVxMjZ2QnhrK3FlejhMbjVMOVov?=
 =?utf-8?B?blBwRmZoZ3R3QjJLYm11azlQcCtIOGhzVkpERWhHU3ZiL1dRc2lHbUZTd1dE?=
 =?utf-8?B?KzFFVUEzUEk1T2Z6QklVblZ0TDJ1Nm5iQTNpTzBUVEVnT09vMTBnZ0FiUk9S?=
 =?utf-8?B?RUVzMk1qZXNhNmI3NDhRbTNTSUdUbDB6MmNPSUhIcE1paG5OV0ZIYjNwTVZE?=
 =?utf-8?B?clpSM0UzZVJseDJiT3paTnBmZHo2aHN2b1U0N2pTN3FXQ2lwSTVaVlZCaG84?=
 =?utf-8?B?d0I3eGlxNHMzRlVvNEVpcHpFeWcwTDY1djhqenBodm1KY0xReUpBa0dBNjVt?=
 =?utf-8?B?UUlPcDJ4MG50WEZoYkJxUFA2bE1VZWJEK0p2WUVIVjg4dmp6N2Jaa0NGWE9u?=
 =?utf-8?B?TFJ5Q1V6SUdEQU1SRjkwRjJCZTJmWDl0SDRjY2VSRzQybExSeVJSdkVKTzl5?=
 =?utf-8?B?NFNRbTFIcDVSUUYxb2xGS3pCdzREV0tGeHFlQklsRUFkUE9KdkVreTVTZ0px?=
 =?utf-8?B?ZjRTUWd5dTBIdFlmdUt1UFJzVVFzOGU4bkVVLy8vUENLbFl4ek41L0ZXU3dS?=
 =?utf-8?B?K2lLY0ZzSUFIWnB5UlVKWXZnOUFDSnJYTStvbms0Y0pZbkRGelJoMFg5L1dO?=
 =?utf-8?B?T05mT3FSZ0MwaFdrK3d5cFpuSTkzUHVQOWtDTjN3WHVXb2FWQUNCS09qbnlI?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A9B7224813C964DAACDF33E5E9F694E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Oq2Zl/PMHRPDfa5EM0xQ04CFOS5tcU8wJrw+CW2LXX1BJOsJMgrqOUtavhGJxdr1NQ+B6HeDh77Tb0IKceHvYOz2GSWUbRpzzknwXCeB5Pxb+1wiRJPjkFAjYPyetTUYFxhLnNX38JB/4eslxgoK8ZDIUY402A2S+a4XckeacRxjMghkVYRB3o6Z9IStbabWzKEkMkgaD7aFwrdWh6L9MLalmmVo7fuaHOM0+gzLkRA2J4bBlxtZV7bdtc7wHXMo95h8eVxDWRanvvSAYbCD452TdW2r6Rx4RmnJca5Yfnc40H2kC87cwFZhnykOJv3L8pIIyqeLini5ENaN3J1DVWHf7kJv9JDWqQjZ/JZhqCWVQoBXWBGlBpKRyKdaMgNg6oO3XZWj5hp0tS8kZ9Sm9uW/rOERf+6gmsyFTaW2Bjs/XsGj5jE479bDzkVsbO9KOTkjkz9kdWuIQ81z+sn4pwJw4HnCjM3dchH9qCxGYwsg//5VpoSGWNluItpsHDuFAeid8ZZ+fBbeCyLp1brZnDKj3bj16kuojBlNHShag+tiQvi+yfKidzvbEMM0/EJnbU7XK7W4cIYdT8f18OBKU0sR9b5sD4FlGP8et4BEU6XpXwd4PuaT5FbyDLg/DaeL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14468.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2079bd-413c-4390-6ba6-08ddbdea439c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 06:40:01.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Csz7cvxTdLySYeWtOxfHwAltYKKXJO7cEG7vxaxtUAeGpOtDxZ9vxHxIJTvQO7l3t8mbvzMLcX1JdjJw/e7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12838

DQoNCk9uIDA4LzA3LzIwMjUgMTA6NDcsIEh1YW5nLCBZaW5nIHdyb3RlOg0KPiAiWmhpamlhbiBM
aSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiBPbiAw
OC8wNy8yMDI1IDA5OjE0LCBIdWFuZywgWWluZyB3cm90ZToNCj4+PiAiWmhpamlhbiBMaSAoRnVq
aXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBIaSwNCj4+
Pj4NCj4+Pj4NCj4+Pj4gT24gMjUvMDYvMjAyNSAxMDoxMywgTGkgWmhpamlhbiB3cm90ZToNCj4+
Pj4+IFYyOg0KPj4+Pj4gRml4IGNvbXBpbGluZyBlcnJvciAjIFJlcG9ydGVkIGJ5IExLUA0KPj4+
Pj4NCj4+Pj4+IEFzIFlpbmcgc3VnZ2VzdGVkLCB3ZSBuZWVkIHRvIGFzc2VzcyB3aGV0aGVyIHRo
aXMgY2hhbmdlIGNhdXNlcyByZWdyZXNzaW9uLg0KPj4+Pj4gSG93ZXZlciwgY29uc2lkZXJpbmcg
dGhlIHN0cmluZ2VudCBjb25kaXRpb25zIHRoaXMgcGF0Y2ggaW52b2x2ZXMsDQo+Pj4+PiBwcm9w
ZXJseSBldmFsdWF0aW5nIGl0IG1heSBiZSBjaGFsbGVuZ2luZywgYXMgdGhlIG91dGNvbWVzIGRl
cGVuZCBvbiB5b3VyDQo+Pj4+PiBwZXJzcGVjdGl2ZS4gTXVjaCBsaWtlIGluIGEgemVyby1zdW0g
Z2FtZSwgaWYgc29tZW9uZSBiZW5lZml0cywgYW5vdGhlcg0KPj4+Pj4gbWlnaHQgbG9zZS4NCj4+
Pj4+DQo+Pj4+PiBJZiB0aGVyZSBhcmUgc3Vic2VxdWVudCByZXN1bHRzLCBJIHdpbGwgdXBkYXRl
IHRoZW0gaGVyZS4NCj4+Pj4NCj4+Pj4gSSByYW4gbWVtaG9nICsgcG1iZW5jaCB0byBldmFsdWF0
ZSB0aGUgaW1wYWN0IG9mIHRoZSBwYXRjaCgzIHJ1bnMgWzFdIGZvciBlYWNoIGtlcm5lbCkuDQo+
Pj4+DQo+Pj4+IFRoZSByZXN1bHRzIHNob3cgYW4gYXBwcm94aW1hdGUgNCUgcGVyZm9ybWFuY2Ug
aW5jcmVhc2UgaW4gcG1iZW5jaCBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLg0KPj4+Pg0KPj4+
PiBBdmVyYWdlICAgICBwbWJlbmNoLWFjY2VzcyAgICAgICAgICAgIG1heC1wcm9tb3Rpb24tcmF0
ZQ0KPj4+PiBCZWZvcmU6ICAgICA3OTU2ODA1IHBhZ2VzL3NlYyAgICAgICAgICAgICAgICAxNjgz
MDEgcGFnZXMvc2VjDQo+Pj4+IEFmdGVyOiAgICAgIDgzMTM2NjYgcGFnZXMvc2VjICgrNC40JSkg
ICAgICAgIDIwNzE0OSBwYWdlcy9zZWMNCj4+Pg0KPj4+IEl0J3MgaGFyZCBmb3IgbWUgdG8gdW5k
ZXJzdGFuZCB3aHkgcGVyZm9ybWFuY2UgaW5jcmVhc2VzIGJlY2F1c2Ugb2YNCj4+PiBoaWdoZXIg
cHJvbW90aW9uIHJhdGUsIHdoaWxlIHRoZSBleHBlY3RlZCBiZWhhdmlvciBpcyBtb3JlIHByb21v
dGlvbg0KPj4+IHJhdGUgbGltaXRpbmcuDQo+Pg0KPj4gR29vZCBxdWVzdGlvbi4NCj4+DQo+PiBB
Ym92ZSBtYXgtcHJvbW90aW9uLXJhdGUgbWVhbnMgdGhlIG1heGltdW0gcmF0ZSBkdXJpbmcgdGhl
IFdIT0xFIHBtYmVuY2ggcGVyaW9kIHdoaWNoDQo+PiBjYW4gbm90IGluZGljYXRlIHRoZSB0b3Rh
bCBwcm9tb3RlZCBwYWdlcy4NCj4+DQo+PiBBbGxvdyBtZSB0byBwcmVzZW50IGVhY2ggc2FtcGxl
IFswXSByZWNvcmRlZCBwZXIgc2Vjb25kIGR1cmluZyB0aGUgcG1iZW5jaCBkdXJhdGlvbiwgYXMg
ZXhlbXBsaWZpZWQgYmVsb3c6DQo+Pg0KPj4NCj4+ICAgICAgICAgICAgICAgfCAgICAgICBBRlRF
UiAgICAgICAgICAgICB8VlMgfCAgICAgICAgICAgQkVGT1JFICAgICAgIHwNCj4+IC0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS18DQo+PiB8IFRpbWVzdGFtcCB8ICBwZ3Byb20vcyAgIHwgIHBnZGVtL3MgIHwgICB8ICBwZ3By
b20vcyAgfCAgcGdkZW0vcyAgfA0KPj4gfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS18LS0tLS0t
LS0tLS18LS0tfC0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwNCj4+IHwgICAgIDEgICAgIHwgICAx
MjI5NzcgICAgfCAgICAgMCAgICAgfCAgIHwgICAxMjMwNTEgICB8ICAgICAwICAgICB8DQo+PiB8
ICAgICAyICAgICB8ICAgNTAxNzEgICAgIHwgICAgIDAgICAgIHwgICB8ICAgNTAxNTkgICAgfCAg
ICAgMCAgICAgfA0KPj4gfCAgICAgMyAgICAgfCAgICAgMTggICAgICB8ICAgICAwICAgICB8ICAg
fCAgICAgMjggICAgIHwgICAgIDAgICAgIHwNCj4+IHwgICAgIDQgICAgIHwgICAxNjY0NyAgICAg
fCAgICAgMCAgICAgfCAgIHwgICAgIDAgICAgICB8ICAgICAwICAgICB8DQo+PiB8ICAgICA1ICAg
ICB8IDIwNzE0OS41ICAgIHwgICAgIDAgICAgIHwgICB8ICAgNzg4OTUgICAgfCAgICAgMCAgICAg
fA0KPj4gfCAgICAgNiAgICAgfCAxOTM0MTEgICAgICB8IDE2MTUyMSAgICB8ICAgfCAgMTY4MzAx
ICAgIHwgICA4NzAyICAgIHwNCj4+IHwgICAgIDcgICAgIHwgIDUyNDY0ICAgICAgfCAgNTM5ODkg
ICAgfCAgIHwgICA0MjI5NCAgICB8ICAzOTEwOCAgICB8DQo+PiB8ICAgICA4ICAgICB8ICAgNTEz
MyAgICAgIHwgICAyNjI3ICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KPj4gfCAg
ICAgOSAgICAgfCAgICAgMjQgICAgICB8ICAgICA4ICAgICB8ICAgfCAgIDM4NzUgICAgIHwgICA2
MjEzICAgIHwNCj4+IHwgICAgMTAgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwg
IDQ1NTEzICAgICB8ICA0MzI2MCAgICB8DQo+PiB8ICAgIDExICAgICB8ICAgICAwICAgICAgIHwg
ICAgIDAgICAgIHwgICB8ICAzNjYwMCAgICAgfCAgNDQ5ODIgICAgfA0KPj4gfCAgICAxMiAgICAg
fCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgMjEwOTEgICAgIHwgIDExNjMxICAgIHwN
Cj4+IHwgICAgMTMgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwgIDEyMjc2ICAg
ICB8ICAxMDcxOSAgICB8DQo+PiB8ICAgIDE0ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAg
IHwgICB8IDE0OTY5OSAgICAgfCAxNDk0MDAgICAgfA0KPj4gfCAgICAxNSAgICAgfCAgICAgMCAg
ICAgICB8ICAgICAwICAgICB8ICAgfCAgIDQwMjYgICAgIHwgICA0OTMzICAgIHwNCj4+IHwgICAg
MTYgICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwgICAzNzgwICAgICB8ICAgICAw
ICAgICB8DQo+PiB8ICAgIDE3ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAg
ICAyICAgICAgfCAgICAgMCAgICAgfA0KPj4gfCAgICAxOCAgICAgfCAgICAgMCAgICAgICB8ICAg
ICAwICAgICB8ICAgfCAgICAgMCAgICAgIHwgICAgIDAgICAgIHwNCj4+IHwgICAgMTkgICAgIHwg
ICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAgIHwgICAgIDAgICAgICB8ICAgICAwICAgICB8DQo+
PiB8ICAgIDIwICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAg
fCAgICAgMCAgICAgfA0KPj4gfCAgICAyMSAgICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8
ICAgfCAgICA2MiAgICAgIHwgICAgIDAgICAgIHwNCj4+IHwgICAgMjIgICAgIHwgICAgIDAgICAg
ICAgfCAgICAgMCAgICAgfCAgIHwgICAyMDE2ICAgICB8ICAgICAwICAgICB8DQo+PiB8ICAgIDIz
ICAgICB8ICAgICAwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAg
ICAgfA0KPj4gfCAgICAyNCAgICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgICA2
MiAgICAgIHwgICAgIDAgICAgIHwNCj4+IHwgICAgMjUgICAgIHwgICA4MzA4ICAgICAgfCAgICAg
MCAgICAgfCAgIHwgICAgIDEgICAgICB8ICAgICAwICAgICB8DQo+PiB8ICAgIDI2ICAgICB8ICAg
MjIwICAgICAgIHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KPj4g
fCAgICAyNyAgICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgMTk5NS4wNSAgIHwg
ICAgIDAgICAgIHwNCj4+IHwgICAgMjggICAgIHwgICAgIDAgICAgICAgfCAgICAgMCAgICAgfCAg
IHwgICAgIDEgICAgICB8ICAgICAwICAgICB8DQo+PiB8ICAgIDI5ICAgICB8ICAgNTc5MSAgICAg
IHwgICAgIDAgICAgIHwgICB8ICAgICAwICAgICAgfCAgICAgMCAgICAgfA0KPj4gfCAgICAzMCAg
ICAgfCAgICAgMCAgICAgICB8ICAgICAwICAgICB8ICAgfCAgICA2MiAgICAgIHwgICAgIDAgICAg
IHwNCj4+IC0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS18DQo+PiB8ICAgdG90YWwgICB8IDY2MjMxMy41ICAgIHwgMjE4MTQ1
ICAgIHwgICB8IDc0Mzc4OS4wNSAgfCAzMTg5NDggICAgfA0KPj4gfCAgICBtYXggICAgfCAyMDcx
NDkuNSAgICB8IDE2MTUyMSAgICB8ICAgfCAgMTY4MzAxICAgIHwgMTQ5NDAwICAgIHwNCj4+IC0t
LS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS18DQo+PiB8ICAgcG1iZW5jaCB8ICAgICAgICA4NDE2MjUwICAgICAgICAgIHxWUyB8
ICAgICAgICA4MDc5NTAwICAgICAgICAgfA0KPj4NCj4+DQo+PiBBcyBmYXIgYXMgSSBjYW4gdGVs
bCwgdGhlIGhpZ2hlciBwbWJlbmNoIHNjb3JlcyBhcHBsaWVkLXBhdGNoIG1heSBiZSBhdHRyaWJ1
dGVkIHRvDQo+PiBhIHJlZHVjdGlvbiBpbiB0aGUgdG90YWwgbnVtYmVyIG9mIHByb21vdGVkIHBh
Z2VzIGluIHRoZSBlbnRpcmUgcG1iZW5jaCBleGVjdXRpb24gcGVyaW9kLg0KPj4gKFNpbWlsYXIg
Y2lyY3Vtc3RhbmNlcyB3ZXJlIG9ic2VydmVkIGluIHRoZSByZXN1bHRzIG9mIG90aGVyIHRlc3Rz
IGNvbmR1Y3RlZCkNCj4+DQo+Pg0KPj4NCj4+IFswXQ0KPj4gYmVmb3JlOg0KPj4gaHR0cHM6Ly9n
aXRodWIuY29tL3poaWppYW5saTg4L21pc2MvYmxvYi9tYWluLzIwMjUwNjI3L3Byb21vdGlvbi1l
dmFsdWF0aW9uL3dpdGhvdXQtcGF0Y2gvcG1iZW5jaC0xNzUwOTg4ODYyLmxvZw0KPj4gaHR0cHM6
Ly9naXRodWIuY29tL3poaWppYW5saTg4L21pc2MvYmxvYi9tYWluLzIwMjUwNjI3L3Byb21vdGlv
bi1ldmFsdWF0aW9uL3dpdGhvdXQtcGF0Y2gvc2FyLTE3NTA5ODg4NjIubG9nDQo+PiBhZnRlcjoN
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4OC9taXNjL2Jsb2IvbWFpbi8yMDI1MDYy
Ny9wcm9tb3Rpb24tZXZhbHVhdGlvbi93aXRoLXBhdGNoL3BtYmVuY2gtMTc1MDk4ODI5MS5sb2cN
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS96aGlqaWFubGk4OC9taXNjL2Jsb2IvbWFpbi8yMDI1MDYy
Ny9wcm9tb3Rpb24tZXZhbHVhdGlvbi93aXRoLXBhdGNoL3Nhci0xNzUwOTg4MjkxLmxvZw0KPj4N
Cj4gDQo+IENoZWNrIHRoZSB1c2FnZSBvZiBQR1BST01PVEVfQ0FORElEQVRFIGFnYWluLiAgSXQg
aXMgdXNlZCBub3Qgb25seSBieQ0KPiByYXRlIGxpbWl0aW5nLCBidXQgYWxzbyBwcm9tb3Rpb24g
dGhyZXNob2xkIGFkanVzdG1lbnQsIHBsZWFzZSB0YWtlIGENCj4gbG9vayBhdCBudW1hX3Byb21v
dGlvbl9hZGp1c3RfdGhyZXNob2xkKCkuICBXaGljaCBtYXkgaGF2ZSBsYXJnZXINCj4gaW5mbHVl
bmNlIG9uIHBlcmZvcm1hbmNlLg0KPiANCj4gQWZ0ZXIgY2hlY2tpbmcgdGhlIHRocmVzaG9sZCBh
ZGp1c3RtZW50IGNvZGUsIEkgdGhpbmsgdGhlIGNoYW5nZXMgaW4NCj4gdGhpcyBwYXRjaCBtYXkg
Y29uZnVzZSB0aHJlc2hvbGQgYWRqdXN0bWVudC4NCg0KDQpJbmRlZWQsIEkgbWlzdW5kZXJzdG9v
ZCB0aGUgY29tbWVudCBpbiB0aGUgcHJldmlvdXMgY29kZToNCi8qIHdvcmtsb2FkIGNoYW5nZWQs
IHJlc2V0IGhvdCB0aHJlc2hvbGQgKi8uDQoNCk9yaWdpbmFsbHksIHRoaXMgbG9naWMgb25seSBy
ZXNldCB0aGUgdGhyZXNob2xkIGZvciB0aGUgY3VycmVudCBpbnRlcnZhbC4NCkZvciB0aGUgbmV4
dCBjeWNsZSAoNjAgc2Vjb25kcyBieSBkZWZhdWx0KSwgdGhlIHRocmVzaG9sZCBpcw0KcmUtZXZh
bHVhdGVkIGJhc2VkIG9uIHRoZSBoaXN0b3JpY2FsIFBHUFJPTU9URV9DQU5ESURBVEUgY291bnRz
Lg0KVGhlcmVmb3JlLCB0aGUgY3VycmVudCBjaGFuZ2UgbWF5IGFmZmVjdCB0aHJlc2hvbGQgYWRq
dXN0bWVudCBpbiBzdWJzZXF1ZW50IGN5Y2xlcy4NCg0KDQpEbyB5b3UgdGhpbmsgdGhlcmUncyBz
dGlsbCBhIGNhc2UgdG8gcHVzaCBmb3IgdGhpcyBwYXRjaD8NCg0KRm9yIGV4YW1wbGUsIGJ5IGNv
bGxlY3RpbmcgbW9yZSBkYXRhIHdpdGggbG9uZ2VyIHBtYmVuY2ggcnVucyAob3ZlciB0d28gdGhy
ZXNob2xkIGN5Y2xlcyksDQpvciBleHBsaWNpdGx5IGNvbXBlbnNhdGluZyBuYnBfcmxfbnJfY2Fu
ZCBhbmQgbmJwX3RoX25yX2NhbmQgdG8gbWFpbnRhaW4gZXhpc3RpbmcNCmJlaGF2aW9yIGZvciBi
b3RoIHRoZSByYXRlIGxpbWl0IGFuZCB0aHJlc2hvbGQgbG9naWM/IHNvbWV0aGluZyBsaWtlOg0K
DQppZiAocGdkYXRfZnJlZV9zcGFjZV9lbm91Z2gocGdkYXQpKSB7DQogICAgIC8qIHdvcmtsb2Fk
IGNoYW5nZWQsIHJlc2V0IGhvdCB0aHJlc2hvbGQgKi8NCiAgICAgcGdkYXQtPm5icF90aHJlc2hv
bGQgPSAwOw0KICAgICANCiAgICAgbW9kX25vZGVfcGFnZV9zdGF0ZShwZ2RhdCwgUEdQUk9NT1RF
X0NBTkRJREFURSwgbnIpOw0KICAgICAvLyBjb21wZW5zYXRpb24gZm9yIHJhdGUgbGltaXQgYW5k
IHRocmVzaG9sZA0KICAgICBwZ2RhdC0+bmJwX3JsX25yX2NhbmQgKz0gbnI7DQogICAgIHBnZGF0
LT5uYnBfdGhfbnJfY2FuZCArPSBucjsNCiAgICAgDQogICAgIHJldHVybiB0cnVlOw0KfQ0KDQpU
aGFua3MNClpoaWppYW4NCg0KPiANCj4gW3NuaXBdDQo+IA0KPiAtLS0NCj4gQmVzdCBSZWdhcmRz
LA0KPiBIdWFuZywgWWluZw==

