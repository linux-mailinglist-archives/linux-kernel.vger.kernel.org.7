Return-Path: <linux-kernel+bounces-648363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 598E9AB75E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 21:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98931BA5F65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3A2918FE;
	Wed, 14 May 2025 19:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hEnZVJUQ"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021114.outbound.protection.outlook.com [40.107.192.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5528F95F
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251055; cv=fail; b=XQrFgedKUIDZxFVOwkXDTTe3ODj7Yky6tiaM+njDbWO5A9sEFXS3s/A2mfyD21WzsPxJ0kLYT82KR6Q0dGs03ORhIaY5Z0BjGNw/TGdtFeP+ZerAADwebrneKcRWpwEPXuwHLN+QZEuB3XxMvs8GjyDugFujxnR3EUN5LrnoSsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251055; c=relaxed/simple;
	bh=bt8AjrS5pEVhxFtf4/Cg/tfZzV6kfF0Cm8q5qlZP104=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=aPXM68uEsMfwbzl7BH4fYnmprMOIyj2KEvgXD8A92YqAnmD7RbXo5tIde+FniJpEK7gxFuCcpTO8E4zVndqXgdXoWBUJ+HxPLUnCh+Dq55SSi7QPL1lY1EGjoSw++hKyS8ml6Hx8Djt3SK2WlANRbArUF6yk1ryM5/Ej9xePftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hEnZVJUQ; arc=fail smtp.client-ip=40.107.192.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6B0nu7GI904nMWNOEn/lKPYaRshR6q+IuliI4yTtzwUPy85DeVSpTfZ4ZWCkMt6qZ5ok8yszFauztS9GXSHbVe6g848iyXjhGkfTL3miGTy6y0Y4A9W2C2jy7jChlP3iqqiDEw8EMlPeMFuE1jTH/Zi3V6+OVZyG3Q9c7kp9bWh4Y2Ca+lAUSuCDiK0xU72b6XCE4/kTZTJV27Sz95jHv6ouRzSfsQ8IqeJZUDBpdDqdoT+TdtY04Q3GgaI1clAsgSDaJ6d4i0DGZyTpHsetnkJHBMJX8ouL8bwVok+eEVWbVJMmL+NacP08hYXsuG4W/EHVfUX4HyMY0POThi9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bv4H3tZGyvHEJ0V4ggzolkh052k2p1+NiJ6L6cuFy4=;
 b=hKAx3zoK99prhLYzxw1tLO+fNWc8i2Y4w1GOWJixcIYFGfIDX/JZ3SEsgBeDy8pn/5vMvREFdd7dXMtbxZFPMGsOo7pA3+R0hYb1QTZzficMe2fm1T/B2NU6yN9hAut6jd9f2dm4zY67kiYEK9eUWGotwcx1xNhR4EJyZyMnl1+OCIkQ3s43z2CJebWdSW3b8ZACuuqbm8l9ZCZE0lWprbuyDcWP0dCiJJ2/a4XRrUT5WH53DXa0K4QrFVg/gonavUwF5vW6w3CUHQPi1/gsuRc72bUWd2I61wCtorUuF5FnKMAlOJo5lyioUZgaHq0iNsRDIk5nJS2/PMWEBugj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bv4H3tZGyvHEJ0V4ggzolkh052k2p1+NiJ6L6cuFy4=;
 b=hEnZVJUQ9OgWoOyuWW6XgpdC/S5N1Pg9yq+LYG43fJivoyPrSJGAwSREsunCSaNeBBgMtHUiUPOcCfgeBmcF8cPx5DsaqnRB24hczFnAm8/MUYIpBf68PLm0O8WGFNqQkva6K5mtMOfuam7oaAd6wtu2GKs9o+v4Qw2IgvbeBr2aYIpJGaE+BegzoaTsnNHZMay64T3TBUO+axjeWrvq33sGIs9p/kkXWy+Qkmem6mEtxJQG7OpzmFZNRLswcxEFyDkHP9kFBq+WvAUcBXH+WG7nrHQcQ8abW0hUzHXKt2JeA09hGL6lSceXn0mCXMHAEssIyLV+Z5IYr7b7w3q3ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6535.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 19:30:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 19:30:48 +0000
Message-ID: <d45c0e0d-0470-4ff9-b85b-4d92a2879732@efficios.com>
Date: Wed, 14 May 2025 15:30:47 -0400
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.15.3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0169.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e9b8ce-9cc9-4663-dccc-08dd931dd41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDFYNzBublRnK3hyNTVPRjQ0ekY4dnJncWRzTjlBVTFvZVNjWHc5OWplTXpl?=
 =?utf-8?B?cmcxV0tBak9TYTR1V2J6emozWElLTGxhbXM3VEZZZ3RBYUYreGEydXNoVjc3?=
 =?utf-8?B?VGVFM2NLS2dQSElreEN5d1VTTk9SRDRtdmFTNFpiTTBWdldTS0dzVmc3VERz?=
 =?utf-8?B?ekowVVpJZko4SW9OY1NRUCtpNlM3MXRZL2x4RTA2ZE84WG80cktqNjJSSTZp?=
 =?utf-8?B?dWxpS29MMm5IcXVMMUtLQVdlQmF6Rkg1VHR5NDN4RG5jODl4Vy9PekFpN1hL?=
 =?utf-8?B?L0hvNXRINnM2SDluZHNIK1lrOGtnZ2Uyd0ExTXVkTzdWNkEvZm5EcWFFcys4?=
 =?utf-8?B?YUJLVmxSTENrY0VtSjZJZFRUVlM5OGQzeEwwNzdjYUJ2bEltamZndS9GTUlC?=
 =?utf-8?B?WWNTam9mY24xU0k4Sjk3S0ZEN3BDdkc3N1ZEV0pFVHVrV2xvWHpiMWRkQ01t?=
 =?utf-8?B?K3h5aFZQYUJrb0lZWWh3S0YzdWN2a1FhSi84L0ExdXN1MnhRb1UzZUpCUWVV?=
 =?utf-8?B?SVFsY28xMUFlNy9URzFpN1dPVmR3VXA1ZVpkSkhKWkRyK1hSRlp0WnhPNW81?=
 =?utf-8?B?dHRVTlhaejBhM3lNbEVHMTlsNVd0KzdpTEk1TElLeW9INnk2Z2VMeU9DNlNv?=
 =?utf-8?B?dnhJR2U1RFFjMEQ1bi8zbldyYnRSd1BuSVN2S3BGV0ZlaTZvbTM3cEFtbDVU?=
 =?utf-8?B?L1lTbnhTTm8xbGpDemczK0NzUkRJcUx6cjR5V3ROaUw3UUdMVUdRUjJqR3g2?=
 =?utf-8?B?UmlneW84Vld0NjhES2FiZ3BXTGprSkdhM2NTZVNhRHdXVStIMURYQWZ3YW84?=
 =?utf-8?B?aGtpaUhMZUpKbUVhRlFUNHU2WEFtUDF5cHB2ZnB2MU9JL2w4aG5oY2dkcnFl?=
 =?utf-8?B?ZWFUM2d2YTVsS2RVM0hoVngxbzIyWm1aRVNnQ0wrNDFRRi9NS1NlYXJ6dms2?=
 =?utf-8?B?WHlhQzRzNUNpT0o5K1gra0k0d3BwU0lZMklIaVdFQWtMQ1U2SmhZTnpZUTFp?=
 =?utf-8?B?aUNUcWhTWVBUMzVIRkw1ZUdTL08yOFBMMHVCekdXTEVueE1iekRlcmp2dDNj?=
 =?utf-8?B?U0ZzOVptUWNDNkV0TEYwT0dWU3FOY3hXczEweUxZbGNDRFpoM2dvMHd6VHhH?=
 =?utf-8?B?YURiR1pOYzBBY2VOazdad1NzY0IyTXRNWEs1VXUwSldBOHViajdXaDYzR3VP?=
 =?utf-8?B?Ry9YenpQYlJFWFFZd1lZb0FWY3VyMEQxaGt2VUN2RmRKUkFqeDFxcFdFeGpK?=
 =?utf-8?B?OWl1clEvZm8wbmVMSzZSRXA0YURwcmc1RDB6TmdaeFlYVnhPRnNOZGhIUlpv?=
 =?utf-8?B?QXhGdyt0aStJVnlWRm9NS3F3Qkg5ZHMyWXlCc2NINjRTVDBYYlRJTE1scWpV?=
 =?utf-8?B?eFNlQkgyR28rYVljOG5HY016cVVKU29XSUdVNzF4OERtbHV4K2x5dGtZTDdL?=
 =?utf-8?B?YWQ5STVFaDVOSldWKzhRWjQ4bEp1NWpvYXNhQzhkazRzQTdiVFpEejI1MDJN?=
 =?utf-8?B?M0Vmd0dwMEZtREx0ZFl0WGhMT0lhV1ZyM3NVRjZhMVZhV0RhUW9rZXpyTHdE?=
 =?utf-8?B?Ry82bUdkRnhjS1NYNVdhdnk3ejZRQ3IzT0hpdWo4S1J3UDc0OGE3NkNMM25X?=
 =?utf-8?B?NmZZMHg4UDMzT2Q4TE9DVlhjalk5YXAxOEV2RUZsbFdlcTBkKzdlNE5Dbmt6?=
 =?utf-8?B?NHZObFM2eHAxZWZKUVNEekFjcUN6K3hVL0kvZVVpU3pBbkh4VzZ0bmtib2tv?=
 =?utf-8?B?T0E4SVRQR0JUWFJLc0R4TjhHN3lHZTRUdzN6c3hLVWZtUkJ1OUlhSkVmVGgy?=
 =?utf-8?Q?tnjf9zCpk9g53gb+eBwMSdH2qshKJOw4ws+N0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blliS05raWtjN2xvd1ZRVFBwSm05YlZrc2NpSjZiQzc2bFlES05LRGFDVmZO?=
 =?utf-8?B?T1E1c05vb2hhL0k5TjNjaU8vMXpRdndVNTNVZVBqSHBqb0h5Z1BBVG41bDVT?=
 =?utf-8?B?RU9NNXhUYXB1SFVXNVVWWTZSR1p3M0J2QUhXWGZuNTcxZTdhK1RuWS96aDVk?=
 =?utf-8?B?dUtwY0tTKzJ1MExhWUFxaER3ZS9LYnB0RFdlVFgrWlNKY0JwRVBycGppYm1y?=
 =?utf-8?B?NjFJME1BN3krWHZMMjBxQjlSZ0VzQnh2MXlsM3J1SXFMd3Izc2hNb1hsNUNs?=
 =?utf-8?B?WjNoeTRqNFl6cW94UzdqWnh5dHhRRklvU256TmpoSC8zQ3VBc1lJYkJiSTVw?=
 =?utf-8?B?cG1uUjJGVmxhWmpnSC9vamFIM2gxTkFKWGpQVHpXYllxenBYVWRkVDdjckQ1?=
 =?utf-8?B?NGVJSk9DSDFFanZNRWUrQXd0T1EzTzhZTXM4Z01VS3dBcXI4QzhnYm93a3I0?=
 =?utf-8?B?Vk8ya3BYNVc5SGdWSXVFNzk2b3RibExxTXE4dkJRc3VVeFk2dlpDaGNFVzRI?=
 =?utf-8?B?UWZBb09SK2RyaDFLL0pmb1lFdnIwKzkrSHBnZ3lOUlRlUVFSa0tEdmVGU3p5?=
 =?utf-8?B?NnRMM0ZTOGRzcTRFVnBiZnE3dzZOUTd0MWNqam5Fdzhqc3VweFdkTkR5cHFD?=
 =?utf-8?B?cXM4YWVmbGwzYU92eU1IQS83YXArVytsNXBNUHB2L0kvYVZJc0N3R2hjdnVp?=
 =?utf-8?B?aW9TOHgybXlVblZncytxWDk1ZzBGNkZhN1A1R2E4eWRSVUV4SU5DbUs4MW5C?=
 =?utf-8?B?c1hhWVd1ZlZ1MDNMUytDVjRUb3ZrVXZ1ZUFwTm0xS0tFa0x1clpUZnlwQ1RY?=
 =?utf-8?B?SWhPdGVST01GYTl0U3E1TWQvZEZEWnE3RmZIRzQydjNpZDArVy9acDJBc0xO?=
 =?utf-8?B?MFYzT0dyVVRCNmpNWjNFWXVLOEc0T1dXWnorSVEzemI2QlVOMXd3bWZVbjdm?=
 =?utf-8?B?Q2YyckxFeHdqL09VQVRBU1ZySnlyZm5rcUhxRG94Rm9BK1NnMDhWTE1hU2p1?=
 =?utf-8?B?SjhONjhXMktIcHNVUlVWR1A2RlpPOURZMUtTZnhHdlJUQzI0bEZGMzBTTUph?=
 =?utf-8?B?MUt0OEJvcnV6MU5lWGd0NzFKRjRsYmJHSGtJWHVXNFB2Qkl2NGU4WG1xUUVa?=
 =?utf-8?B?SWh3OC9MUVJrMnNIMlNIUVRYTmlYMGpMcUM5dmY3ZERBdUdZN3R5VDA5OXEr?=
 =?utf-8?B?UmdoTjgvQ2FLTUNXWTFTUVhoRTlhbi9yajVUNkFsMkpLZW1uTkRuekZSVTlq?=
 =?utf-8?B?NWJiaXhtT3JXaEYrWWdsRlNYWTFYN2wrRG83RTdLT0NidHprZEd6R1BsOThP?=
 =?utf-8?B?ZzJJbkJ3K21sZVVZU3hxdkJFQis2VDFwVHI3MnhyMFhaMW8rc21jMCt4dTVm?=
 =?utf-8?B?bytVQWVNNTVVa0Z6eVFGNjMzRzRaR0E2UTZJQ2NaaER1ZERVYjJ3N1pPNVpV?=
 =?utf-8?B?cEcwaDkzdE0vUDFlVHNrbFlISjBoQ3dMazJyNGdEaXlLR0NSYnFjMG5zbXRO?=
 =?utf-8?B?UDN1RXFOSXRUWm51MjEyMjErVHpUTS9GMVU4aGdPbk51YjVnTUxVKytjMzM0?=
 =?utf-8?B?OUUzV1ZEYjlmZnZ2ZHIydlhLZXNWY0FteXpOTTNIcUJocUVLQWw3WDJJUlB5?=
 =?utf-8?B?UURvdEhZV0U0c3lXQ0JtUW9mcU5hNTJ0RHJvSDB1a1JrYmJwVmxlZHRubnBh?=
 =?utf-8?B?SXByUFgybmU4aXprQ09sSGJmejl5Y0pkSmI1Z1FrOGZDZ3A4QUkvMzVRaGh2?=
 =?utf-8?B?SG1GN0pDWjYyRkUweFplU21CQkczKzJjelNTaWNaUXkweks4UWswd2VhdXJo?=
 =?utf-8?B?aDJnWlNOZUlSOFVFazJERzZXUzBUcThkZFBTVCtpem1mVW1XRWVobENnT2hN?=
 =?utf-8?B?NjBQdUtvbkxQSXhWVEwxRjhudGFGRzVlczd0aVJoOElOaW43Q0IxaS9RWTlk?=
 =?utf-8?B?SUMzSEVxVzRpQzFEQU5ybWJ2UlRHalhaSTk5SkZuelFTcDJZYTZoNC9VUDFO?=
 =?utf-8?B?K0dyOHV6WlF5MW0xelRvT29uUVpQbVozU2kvejVlMEF0V0wyMHV5WDVJNjlN?=
 =?utf-8?B?RktyU3BCV2xJWXUxcElGc09BWUloUXZ1dXpvS2RIb0lkYnBmaCtPd3BSZnEv?=
 =?utf-8?B?aUJXa2lkSkt3Ty9ua3RuN05YdHpxdjdiVG9kclAxb0JtUjUwWUlPNTFOZW93?=
 =?utf-8?Q?DT4Pe8Gb4RNxOpMGuKX+i3U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e9b8ce-9cc9-4663-dccc-08dd931dd41f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 19:30:48.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJGasLbJdflX1yy3RAXZvGQw9RkH7iR0gbYOQTlwYX+JO84swBgOLqXGlgV0nVN0q/fPvTXle7ZtKgXJ6jwOl2VGbPTvdX9fEuEi5qYCA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6535

Hi,

This is release announcement of liburcu 0.15.3. It is straightforward
a bug fix release for support of older compilers.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog:
2025-05-14 Userspace RCU 0.15.3
         * Fix: Use bitfield static assert with GCC < 7.1.0
         * Fix: Allow compile-time checks for GCC 5.1

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


