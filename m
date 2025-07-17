Return-Path: <linux-kernel+bounces-735906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E288B0950D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C811F1C482EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF42FCE3D;
	Thu, 17 Jul 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="nw9VzIKr"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364962F7D08;
	Thu, 17 Jul 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780974; cv=fail; b=ct3jwD+sIM2PImBniN0mAcXtJeA6OtOj1uez4J80I2tPCBul99voC2+L5ikUjHDroHcPa6Iqix422X8h52prHkTEKiW7R/lK541ouoJL4ih/KKFOMRYuOQV5HV426/qeyq0g3piWIRupbeFT3tpRqD9XMAArrQjvhA7orrMvOw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780974; c=relaxed/simple;
	bh=ccmW1ezcaexSMTNE1Ab0FmdDROAnHO9DMbqaFduBvnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=krzIdxJbrHaFwyh0w4T7vvCeGlLlR7pspO7iRXuA6Fuff+cc6u1dBQZ4HEbq28pXIDrKAtOaHnQPoE2zIRW8gMONILVhVqfJnx6cgb3i/yC7UuiypUQRmL/cO7jrfevc+EhBKIGtv9iW+KYjEzpnZx5wEL7riT3EMLi6ej2mfTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=nw9VzIKr; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUYDnfjV6oFsiS5NT7NDdjjrOHzy+uweiKDAHiZ4ZY5f6+oRgmIo1D20JtOBZMadOZ0BS6GVucwEY57u0+tyb91lAbxjRPQHXX0ls5qFl65EJv3UbE9C+ULJAelnMd3VaVdTN6HgzdhKoc+Xvic9N2BUjWkT4DQKuJbw2v53N0QZBRMGh78U5hN98BNCtMADMfLieRADAEp0NTAurhVdOVqqX1q3qDgrd1npeO8WN02MkFk3Smr3YexYgANwejM7+fBP1JLqyLclcPq1Nm/KCKjkQXmuOVadBrIm/09QrnbElp/70xGiX2gFJaWo/S2pnOIleZrF6gimG3OFbpDPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S69vDv+YgTdJb9xsN94ivcRcHLRActDmA4TlohgCoJU=;
 b=wUGEX78Za7xHGTIp7jh0rmpcZ3uHlAnBA4P8M2aCooELMqcyUP75gX4in0pQpfw/XIMm+/KVtARDUjGeSwtOSnhaLvR3ydoB043QPeFTFU/tD0BaMp2fwOBPWkPpgCrerln+aRmGQg2RtTiJlvGksPSusI8D6GN180zbPPiXgEq03QMF315F6ewgEiuuv4rRChGO2nu3kdPN8WKr2FpFiR7DDUZtodrTBCuwBScn+3XTmzn7BTzvf+znPtYunacY1yvW7oQnoNKz102Z0PgYbWr4TqEI28AleZhpjK2ZnPRyrrLqKUOiOGktSrjK38M65djASZ6r66d2ARBQ/lC5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S69vDv+YgTdJb9xsN94ivcRcHLRActDmA4TlohgCoJU=;
 b=nw9VzIKrmAq7TNmFDIUb9WrqmZ0v+4sPpYBFCblYNgDRLO/ZdDif99e6POEWOYnhuwFFtVvSk3lvBg42NKrecnWOsKDNsfxUcpr5YvlcS2T+4o7gPLMCRCCLQ8Ub1Ue/LA8+H2PQeQfydLdn+a876vkvw6QF6yVG3Jb7CIjHfGJwi3idMfflMDr9u9oDUKKq0jbBHde9i9F26jESQGbBMRT0yacq6vmkIkosol26mA9naWnwIazP4I657k0zl9hRZS5zPAoOEESo8h0NPnCqJi5n2/VjOAYtcmFz8CW8EyBIap8da1jouoZ96eTR/tFlrXo5ZSks+Yh9iAc8EUuPaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB3461.namprd03.prod.outlook.com (2603:10b6:a02:b4::23)
 by MW4PR03MB6331.namprd03.prod.outlook.com (2603:10b6:303:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:36:09 +0000
Received: from BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c]) by BYAPR03MB3461.namprd03.prod.outlook.com
 ([fe80::706b:dd15:bc81:313c%6]) with mapi id 15.20.8901.024; Thu, 17 Jul 2025
 19:36:09 +0000
Message-ID: <bdbe0185-341c-4cc4-a388-34f6c4c7f9b4@altera.com>
Date: Thu, 17 Jul 2025 12:36:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 0/5] stratix10: Add framework for asynchronous
 communication with SDM
To: Mahesh Rao <mahesh.rao@altera.com>, Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20250708-sip_svc_upstream-v5-0-9c4289256d54@altera.com>
 <95fbffd2-2f1b-4219-a366-392b48ee0893@altera.com>
Content-Language: en-US
From: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <95fbffd2-2f1b-4219-a366-392b48ee0893@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To BYAPR03MB3461.namprd03.prod.outlook.com
 (2603:10b6:a02:b4::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3461:EE_|MW4PR03MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 6303e5e6-8cb3-4f65-1436-08ddc5692e24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azBsbTNQWnZlK2JVSktrN0x5Yi8rN3BiMjhsZkRscHJYOGVUZ2JvRzJuMFBO?=
 =?utf-8?B?clQ3bi9Ud1VMN0Z6RkFqUzdqenhrcjBVbGEvOTZBalVVTkw5SUJ2cll5aVU3?=
 =?utf-8?B?dThUYUlneFZZOENYenVlanZwb0l2Vml3UVBMSHVlSDRNZkNGVkREOE9reFV5?=
 =?utf-8?B?bWVQWlJjeXduWDJEVE5PcmM0ZWJteExMZWZpVlhqS3c1UjQ4NFVMM0xsM0hP?=
 =?utf-8?B?eGZ3dW1hWFZSTEFnNkk3cEN2U2gzdkpsTlhhUU9NTFFwdDMwR1ZOaVBrU09s?=
 =?utf-8?B?ZG92Q0hKcGkzMm8xWmg1Ukk3V01vOWxoa1FnbGNmVmhRNm5yd3NwRGdiNnF1?=
 =?utf-8?B?dXlFWFgwY21ZVlJWOGNBd0VXRDExV3pxWFkzZno3OWFxaVRkM21aZ3Ixc0lm?=
 =?utf-8?B?M003K2hKZ3hiOS9yT1BPbSsxaXVIU1BEdSs2UmtuL1o5VFRRNi9yNTEzai9r?=
 =?utf-8?B?cnZqSHFBSUZsZmJJN3NveGk3MkZFNTVLTWt0WkV0TW1yY1FFWi9Oc1pqVHRm?=
 =?utf-8?B?NUtPYlQwczdicGZ2SFRYZ3BvaEpiWXJ0NFBoNm1Vajc4cFc5b3R2dXcrWVFp?=
 =?utf-8?B?a0Vwakc3UUhTZHdEY0NDRjI0T3pDKyt6MnVzL2FpaUE5NzRpN2NKSTRQZmEy?=
 =?utf-8?B?ZmFBbHhuWnJnOFFJbHBJeUs4VXVUaEUyTDJQWDRzTjM3WEQzSVJMNkhuWU1D?=
 =?utf-8?B?aUpUMXo3VHF3WnYrY0JETTZVS2o5YUN2U1c5YkljK2xBc1hQWjJWcGdKd1Np?=
 =?utf-8?B?WUZWQmxla3RmVW1IaFpEcm5pbVRoRzBsTC9SaWltRGltWU1CLzRxeit4UjJP?=
 =?utf-8?B?eXlDbllNMENxUG1oSXhmS0U0WmVuQWFOSi9zL2NvQlcxc1JzRDlZaDYxSHVj?=
 =?utf-8?B?VUFRZzltcm5Oc3VYbUZFR1NVTS9vMm12QStzczBGeGk0emxwVEI3ZEtjRlBa?=
 =?utf-8?B?TzRRRHFuSWdLTlVVRmtlTnJtTllXUHBhcDRMVVlNS1hPM1ZGcEJjOUJYR3NR?=
 =?utf-8?B?aFNaZGJOTFhCWGZRQ1QrMDNQZzR0Nkxld3NzODhwaGlON25IVGRyWXVSWTlu?=
 =?utf-8?B?a1NJSmJ1OFIrZkpxWGs2VXZEZHh4Tk5pd0hscERmRXlJSXBmL3ozc1htUkRB?=
 =?utf-8?B?NFcwendwbkFINlpxMWZGTXltT0k3YWc2K0VsSk1hYzQ5YWc2Mzl0cVpBSXdV?=
 =?utf-8?B?T2MwQldxaElyUDQ2bmdaYkFIVHRpWkdnUTRvQy9IVXRKazVjZUo1Y1pOZTNN?=
 =?utf-8?B?OEhSQ01yTnc5d2E1aFU4UExRVjZHNVF1RGx4d0M0cWVaK1NyMDIwTk9CcGhE?=
 =?utf-8?B?WFJVNnk0MnZDVHZMNHhpb3lEWUxINWtPRmpCcm80RU5xNTVIZFZudEYxbEhh?=
 =?utf-8?B?VklsOFdmOHZFTUtETEZNRTJTcWlpS2V5WXh4ZjlMTkhweDllYW5hQUJ1c0dz?=
 =?utf-8?B?Y1VZUFJRRzN2bGpTelpmcFVQay9KUnZXK3ZCZ2NoeXpmcU14VVR6OTYzQW8v?=
 =?utf-8?B?bWwyRXNCUmZyK1JySHZkd09XeWhDb2E1T29xN3hxdmcxVFNaYjdBaXVlYWth?=
 =?utf-8?B?U1hPZWxYNldnUG4wVlp6WWJzd2hzdFZKcU5VejVQd3hZSHdLWUc4aFlCYjFV?=
 =?utf-8?B?ZnVqOEVGVHFDS2MxMkZKT1hEWFBRSm5ScURhT1VrMXhBUjZ3c3FEY2J4Y0xj?=
 =?utf-8?B?T3VUWWlpZlk1REx2QTQwM2tUcFR3cXI0RGFCd0hPNC9tMlJsM0t0K09WcTZR?=
 =?utf-8?B?TDM1VVVyZnlmVWJQZXFUaWU0NjlEQjlWUFc3K2V2ektNZ0pFU0VnWGJueTE2?=
 =?utf-8?B?R1dlK1I4ZWVicGFyUnJ5VGpKd0ZIUi8wL2hrWHg5Q3ZQT1Bsa2lMVnl5Y0o0?=
 =?utf-8?B?a01ibWV5WTNWR00vWktHb3UwZE1FSHRNQzlMZ1lhWjU3d2pGSEdtV0hWdmt4?=
 =?utf-8?Q?f/GajGj85dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3461.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGRwU0R3dFhHOEpFTGtnekFNdXdERUxXNUJEbmlvTzRhUXFwaHZlMzdHUllS?=
 =?utf-8?B?YzY3dXdPakthY0RGcjdTM0QyM1pLYWUwTHpINDBkZlNZUXNRYWF1N3NoL1Rh?=
 =?utf-8?B?KytZbHlWZ3lxeFF6ekMrQ3N2aHRqeUNGbTZ2dXNGQTA2d2xoQ1pDdXlQamE3?=
 =?utf-8?B?Z3Y0SEJvQ2hHOHpFUEVOTWhTNDMxVnpXTCtTcmtEdk8rMmxBZ3lvakdWUjdh?=
 =?utf-8?B?T0s2VTdFdWR6OTgyU0JKdmFGYjZlZHZTN1kzaEJLdHdmcGpVaGNrR3poQTRl?=
 =?utf-8?B?aUZzTU5oWU9NYld1RkhuTXNyeXgwWVV3WExSaGRpRXU1MmwvNFRHc0lGZWkv?=
 =?utf-8?B?dktza1hYTytWOFg3T0dqbklUZWxNTlZNQ3BSYlp5L1BvTmJrRzlFalFDcmFG?=
 =?utf-8?B?NVpDb1NPalpsa1BVb0pXdTk1ZWVrUk5YcUtPTCtKeXdZK0dJak5tQ1NKcEZW?=
 =?utf-8?B?M2J3MGZrbVpzWGl3WmxqQjFYOG1xb0RsdzI3TUxwbWR1T1F0YVpqUTJXR2RJ?=
 =?utf-8?B?NFpPdHRCTnIzc2NJS1QwUllxNGpCS0R5S0FzemVBcWQrM1pmTDl3S0lWNmlk?=
 =?utf-8?B?eVFocWtYMHdsUksrNWtjQW96YmtrOEZmck5ZcUlONlh4SkVrMHJPQ05vbTFR?=
 =?utf-8?B?K2xaUmNzWVNyYk5pQVl3L09iTU91WVVyaUZJRDUrMTFRSmVDSjlTL3BJWWVr?=
 =?utf-8?B?MXI1M3VwbkpVL29ielBiNlVGM2YrN2F6SC80S2ZVMmU2VGlTVUJaZDdlNjl1?=
 =?utf-8?B?anZCSFRhL0VnUHl0ekU5bWJzTjFsd3NhQnlUN2RLN2tXZzc1R2R6OVkvTlkz?=
 =?utf-8?B?N1EybGtVcjNWOFhvdEFYR2tjNzhqeVpnRWdVQUtTWDRYSE15VVZiUCthUTZI?=
 =?utf-8?B?bmVvVFVqSW9FVTNJNzNmZWZhTUNzT0tPNTV3SG00QXhaMENvWmYzTlcrZWZU?=
 =?utf-8?B?TWZtL292N3FlOE0rQ0loNTNyU0t1N3YyZWM3b0k5RUVSOEVNdG5wZE5uYW1E?=
 =?utf-8?B?NjV6MVV6MTRhSCs2cWlGSGlKZVFUOUUzQTJZbE9TUE9JbDZCb1AvZ01uSGhO?=
 =?utf-8?B?V0pXTDVwd3ZWcXI0ZTR0OHNpM0dGdVpQUmxKYjYzRUxDUldiQnlBN3FLM0FR?=
 =?utf-8?B?SlhydXJFQVAxY1pjM2I3dG5CY0hzK0VscmM4ZWsyOHRuNVN1ZGYvWExoMGF4?=
 =?utf-8?B?ak5KOFhGRFN6djBWU3lSWXZzVUt3Z0lRMFRFT1RhamQyWlVUMzdyNmljTzMr?=
 =?utf-8?B?TTJ1WThLQ3k4V0dlcFJvYTBPN01FZGtRWFNKN3ZXV0lHem54ZDI0UWprL1Jq?=
 =?utf-8?B?cnZqMHV0YzlCMXFVdE50WXhBbjdxd2syMkViSDZ6OGN4bGJ2THh1SGJ0QXdX?=
 =?utf-8?B?MlUycEpFTC9GZlNqc0xGdUo1RE15WDZiTWxnYVlSblg2amlGa3ljckxkTHhO?=
 =?utf-8?B?Um1HRE9jTXozNmFyOGFNMGxnaVdUV1QyYWo2NEpOdG5JakxGNXlLb25uc1hJ?=
 =?utf-8?B?UkVHcHZMc2NBQ1dUWm16KyttMGRZd3RyT3JHWmdKZWZVUkxRay8vWlcwMThK?=
 =?utf-8?B?QThEbllYYTRyYk9YanlQbUYxWllnRjRkNHBVekNRQmd4bDhXK2RZdlJoWTE4?=
 =?utf-8?B?ZWI2NmdadXArSEJPMlhBZVowV1hXeDd1Nm1YRmt0Vy9BVi9RQ09UdzZJMmpv?=
 =?utf-8?B?Z2pvdStlNFhRSGlOZWVoSkI4M0piN0ptY1VsRXhobkdSMlRlcEg4YW9maURF?=
 =?utf-8?B?S3labVdBS2x2MUZ1OEJzUEw1K3I2d1JYTG15NVE0NTlnK0lqWUN1dWV0VjV4?=
 =?utf-8?B?eXNUVzIwNFRmT2dwZGZrRks0M2VsWmNxaUVvOEpJK0RHSlc1aGRPc2F6MWx6?=
 =?utf-8?B?RnRyZ1JReVl2SzlUR2RIRlV1TEhOL05hUTUwVjlBcHFuM1Zjc3BTZlVweDV0?=
 =?utf-8?B?QjkvZDZBOTFKbDBaZmNtTU5YM2dqRVZXUEg0Rllxb2MyM3plTzdoQkIvUUpm?=
 =?utf-8?B?enQ1M3c0ck9mRVFRZHRkWHRzMFc2Q0pLSzFwSmdQTVNWeUhRMDZTNVFaQkEr?=
 =?utf-8?B?bzdTdE9Bbm5mOGd1NVNRYUpISjNrTmpLV3EzSkVKZ2FmUjZpemZQb2VQWHZS?=
 =?utf-8?B?bjg2TE9IVVJUTHNqZDZvQWhwVkZtRHEyaUgzTnNVZ3F3TWx3TGVZa1lEZVZa?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6303e5e6-8cb3-4f65-1436-08ddc5692e24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3461.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:36:09.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IEJiCWlBpP/bw7t1L6MBa0wozhRBXNlMiUtSXU0/QvaqsIMByX9OrJ+EKK/+sYJgjcZKXkeRijB4hcIynWFUHzJDwVQ/UmhWUA4tLweU3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6331



On 7/17/25 1:43 AM, Mahesh Rao wrote:
> Hi Dinh,
> 	I hope you're doing well. It's been a while since I submitted the patch
> set, could you please take a moment to review it when you get a chance?
>
> @Mathew Gerlach, I have addressed your comments. Please let me know if
> there’s anything else needed.

Thanks for the reminder. I see you implemented my previous suggestions. 
I have no further suggestions.

Matthew Gerlach
>
> Best wishes
> Mahesh Rao
> 	
>
> On 08-07-2025 10:19 am, Mahesh Rao via B4 Relay wrote:
> > The patch set includes the following changes:
> > 
> > - Add protection for querying memory objects in
> >    multi-threaded flow.
> > - Add support to generate and maintain message id
> >    and client id for asynchronous communication with SDM.
> > - Add framework to communicate with Secure Device
> >    Manager(SDM) asynchronously by sending a request
> >    and polling for response.
> > - Add commands for performing Remote System Update
> >    (RSU) operations asynchronously.
> > - Migrate RSU driver to use the asynchronous
> >    communication framework.
> > 
> > ---
> > - Link to v5: https://lore.kernel.org/r/20250620-sip_svc_upstream-v5-0-732d4ac08a32@altera.com
> > 
> > Changes in v5:
> > - Use FIELD_PREP, FIELD_GET() and GENMASK() for bit
> >    manipulation for ids.
> > - Bring down probing when stratix10_svc_async_init()
> >    fails.
> > - Other minor fixes.
> > 
> > - Link to v4: https://lore.kernel.org/r/20250610-sip_svc_upstream-v4-0-bcd9d6089071@altera.com
> > 
> > Changes in v4:
> > - Added description for svc_mem_lock mutex.
> > - Wrapped commit message and comments in source
> >    code to kernel coding style as per coding style.
> > - Added minor code fixes.
> > - Moved variables to the top of the function
> > - Removed HWMON support from in the patch-set, this
> >    will be sent in a separate patch-set.
> > - Added support for RSU commands to asynchronously
> >    communicate with SDM.
> > - Migrated RSU driver to use the supported
> >    asynchronous commands.
> > 
> > - Link to v3: https://lore.kernel.org/r/20250526-sip_svc_upstream-v3-0-6a08a4502de3@altera.com
> > 
> > Changes in v3:
> > - Changed "Stratix 10" to "Stratix10" in the commit
> >    message and in source code.
> > - Simplified stratix10_svc_add_async_client() by removing
> >    redundant code for async common channel initialization.
> > - Fixed resource cleanup on negative path in
> >    stratix10_svc_remove_async_client() and stratix10_svc_async_init().
> > - Removed optional interrupt handler support, will send the patches
> >    in a separate patch-set.
> > 
> > - Link to v2: https://lore.kernel.org/r/20250512-sip_svc_upstream-v2-0-fae5c45c059d@altera.com
> > 
> > Changes in v2:
> > - Added Reviewed by tag from Rob Herring for dt-binding
> >    patch.
> > - Resending the patch-set as there is no response from
> >    the maintainers for the previous patch submission.
> > 
> > - Link to v1: https://lore.kernel.org/r/20250422-sip_svc_upstream-v1-0-088059190f31@altera.com
> > 
> > ---
> > Mahesh Rao (5):
> >        firmware: stratix10-svc: Add mutex lock and unlock in stratix10 memory allocation/free
> >        firmware: stratix10-svc: Implement ID pool management for asynchronous operations
> >        firmware: stratix10-svc: Add initial support for asynchronous communication with Stratix10 service channel
> >        firmware: stratix10-svc: Add support for RSU commands in asynchronous framework
> >        firmware: stratix10-rsu: Migrate RSU driver to use stratix10 asynchronous framework.
> > 
> >   drivers/firmware/stratix10-rsu.c                   | 272 +++---
> >   drivers/firmware/stratix10-svc.c                   | 954 ++++++++++++++++++++-
> >   include/linux/firmware/intel/stratix10-smc.h       |  76 ++
> >   .../linux/firmware/intel/stratix10-svc-client.h    |  92 ++
> >   4 files changed, 1253 insertions(+), 141 deletions(-)
> > ---
> > base-commit: 47633099a672fc7bfe604ef454e4f116e2c954b1
> > change-id: 20250131-sip_svc_upstream-e78d8c9b4335
> > 
> > Best regards,
>


