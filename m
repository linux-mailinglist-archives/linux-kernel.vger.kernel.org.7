Return-Path: <linux-kernel+bounces-731672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D603B05803
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144363ABBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FBA2D8367;
	Tue, 15 Jul 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BS3HrtCC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BS3HrtCC"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ABD22CBEC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576062; cv=fail; b=GyE+ozYYE73gRhjF47IyqWhO14yDlY/SXsUojX6K01pahoVNu330NdvBwedYbiPlWJ6qmowxVt083TGE1PJrkkf2GiKjwfhK9Ta1lOEzRN6MTQODedcvyn3y83UACnj4nmwlkIxTbUcBvmv8S5+ZQh9FLGpaOQumIPkEpYkEAQI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576062; c=relaxed/simple;
	bh=GGVEy2JzedgoAJqDjjus9lSx9kaUDKoL6xDdpWmyMhU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqiPS97NnaKFu/f8l8FGTWYV/sUTKiKV4VQrIW79ZVbDZnz5IApanW61Y2gaAHP0cZXWh2As2Zv5TT329nrledJHIG5TvbaKfPJq7JIIBBpaQhteaLx+KoswQx+P4jw6R5GFvGfhWEIYoo/hNjG8l5orpdCz8S6R4/tsgBXo0V0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BS3HrtCC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BS3HrtCC; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u9qXzZG4uqODzuZctx1wSr4E4Rf06ltADnQE+y0NuuGqPolfFfntMXiAmLSoFmcO2WsKXJYZVmwt8JFzg+QUHtR7bFFiQFB/xDOYp2zIrgYDxzEjXacqnD4YdaXNAwSJL+vxOKPgTVY6AZnsaVNEC7pCqET6w5SxjZBO+8lphqA73ddhPEZAfYCjgoMzIoUsoB+fdw9xJ7l5bUZ3dXWOvIrz/eDBjZwwuE96fCcQx8Bg5U8bzwwScxJlwOWhyaaZ7tyXEhk5RJaQ/uJmnt8DoK58ZJI+VG8+VEdL9+kN6sDPM+Zzvd8jByTcrn8OugkxeNBngU1PVgKhPy4kw4pZtw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct2wfmG6TOs4rJwEzya0OTJOfc5+8V2icY316rXiehk=;
 b=PsQaFHfvqaQl7satVRjqb9Jc6Ee+AFgJ2IaoicSlbSOdAkYq7ofumrw52dQh4Dm4Z+sIyLch2xbqAW/xgBlDigyB+DCdWXk2dAN42HSSiQm0KC2ysv+CRRhTHwY4ZWey37ag1AL7r3lxkA3Sy3G8vJSoJepvq1VlZmLZd7YfrsN7eNkh93oVNTVwYL/AFUCCbmJsuhcog1MFw3M85I4XZ8W/UEC8sWcq9kh1gG5RqXcFlJypfUPR/HvTabH3K55yC7YfyPSgJFcZ/p9YkRqOow8u0Ivvz3A7aJQVVX8L5mxxT2ExplV8P3lQSjCW9ztvj1lSjlzu1KbtUHZVkZtKDA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct2wfmG6TOs4rJwEzya0OTJOfc5+8V2icY316rXiehk=;
 b=BS3HrtCCv3XcflsG0WRNhW37NGWliulW9MT9lYmq/tMzWsFX+9FAhUWD5uCBvXhWvnsq6x3EoOUKcmeAc1dIRsFbXRJiC2BcjLkd/1+TEWNGU3I9/F+1EzT4t9r2tnDOOVJcqBQYxknFA7BPF4qNbK6OJBoEYL1EFV6IDsUpVz4=
Received: from AS9PR05CA0267.eurprd05.prod.outlook.com (2603:10a6:20b:493::31)
 by GV1PR08MB7681.eurprd08.prod.outlook.com (2603:10a6:150:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 10:40:52 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:493:cafe::1b) by AS9PR05CA0267.outlook.office365.com
 (2603:10a6:20b:493::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Tue,
 15 Jul 2025 10:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Tue, 15 Jul 2025 10:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knq87VQXBHAyjQTeL3K3JETVRRdIIj2EpV4fbiKBk6s6Htv+SIuTR+0WvhrxL1ui5UGxW9D66Ptw9RWDUJh0qbiQk4jC7u4xgdCJSM8cO2CLr0AOTlWIKjkdWmZTSE2NB4NcD1pzt7fYWmbiYhpmVkL983gtVb10PgpJGBGRbkeS9gFLH+M581j68H3frQLM6RNwA37qsHdalVp2BBSF8aPnn7rj+7xK9hxn3GvCo4oIyIOejUzVR4TsjqanGigs1apI+V/++gj9DtKebJkqNBvlJtDIVyMMQrI3jgYNDoxRcYxrJO6BYH0E3S/Getk98kGLvgTxMVeIicm9w7fa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ct2wfmG6TOs4rJwEzya0OTJOfc5+8V2icY316rXiehk=;
 b=eG9kIvg8WoWVxu+tI7qhYqgmrSBKdQBmL1QgNfc6lLdOyfgF0OxxBO6pBBKPdYnBW1QpKAYU+1PntzvPXcLUp8U3IFQpVPPj6NkhpLJMajpM/PVRcc6/O7NOPZKmJw89ugyIQGFX/TZgUT3uUPke57pXsmWF+i3TFbcpepkVV4ejo5S47Ku1JXU+FuDsWy8D0BZkXJgUFGNMRb7OrFXQGWk/fFf/51ROH+kLBw2fCvzUFtDotC4KUMhgGJZSG9t85vSqG8SxoF6hWXXewLV+jG0hduCZMe4wuiVOHk96YER/CqDAJamczManYUV1ezNGXfD5PcEq2yg05aC9ZHS56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ct2wfmG6TOs4rJwEzya0OTJOfc5+8V2icY316rXiehk=;
 b=BS3HrtCCv3XcflsG0WRNhW37NGWliulW9MT9lYmq/tMzWsFX+9FAhUWD5uCBvXhWvnsq6x3EoOUKcmeAc1dIRsFbXRJiC2BcjLkd/1+TEWNGU3I9/F+1EzT4t9r2tnDOOVJcqBQYxknFA7BPF4qNbK6OJBoEYL1EFV6IDsUpVz4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB10770.eurprd08.prod.outlook.com (2603:10a6:10:532::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 10:40:16 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:40:16 +0000
Message-ID: <2d0c061c-df01-42dc-ba04-69d47d7516ce@arm.com>
Date: Tue, 15 Jul 2025 16:10:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp() for
 large folios by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
 <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
 <b82b860c-8ad9-409a-8668-e3db11b9f7a5@lucifer.local>
 <adf4fba6-f246-4bf5-ba90-ac1357024dac@redhat.com>
 <7ce82695-f2f6-4a9b-a512-422e9efa902c@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7ce82695-f2f6-4a9b-a512-422e9efa902c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB10770:EE_|AM2PEPF0001C709:EE_|GV1PR08MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3097b5-42a3-4432-dab6-08ddc38c10fb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NHFWSFRqWXNNSVdmT3ZxcS9FcjVhYitSN2JPUTI0VzRoN3lQT2czVGhweDNz?=
 =?utf-8?B?S1pqcGZtSE9XYnU0Y0RUejA3d2JzaVZ5aG5EYnJjdE1RVW04Q09sTkcrUlFU?=
 =?utf-8?B?Vjkyak83cElTU0Y3ZFlCZFMxTWNYWlJEdGNaUDRmU3BidGtxeGVucDQ5cnhF?=
 =?utf-8?B?d0JjM0MrbjB1YzNyQWZBd0FOV0Z4b2tzakxtSi9WK3llVUQwUUJscmUxcldn?=
 =?utf-8?B?aUJwZ3kxTWY1UHdyTlY2MmIvM2dTVmdLcnVEZXRsYUJWbGVuZmgyZ29NTHhR?=
 =?utf-8?B?L3N0dUEyR0wwMis5SDFiQWVIWk4zWE5WR1BIeWYvcDdrditmWUE3QWlHMkdZ?=
 =?utf-8?B?YW9HSUFKVXZLL1ZjSXlXRC9xL2dieTlSRFVtc25lMmVsd1ZTbzhZWHZNTi8y?=
 =?utf-8?B?WDFJQjBYV1NsMk9nNEY2dGlZdU80a05XSk9pVmVybEhjSktwdnlRbDZYc1Jl?=
 =?utf-8?B?aHVwSmhLTVdUVllMZ3dJZXYvdlR2WjZZUFpTS0ttSjRMZjlkYkp3NW84ZEFU?=
 =?utf-8?B?QlhjL2xnN2dUcnJyVUY3c0dvM0dqV1o2bHZFbE9hY0pnTjZoTHhxUE5QL2dO?=
 =?utf-8?B?Q3NDQWZLKzV0UUg3WjVHbitBbmJ3eHdTbkx1TUxtR1RrUDM0bmlmbENFWlVO?=
 =?utf-8?B?Z05SMkhmV3ZGTzlUTHAxVDBJL1IzVFBnTVFCQlIzQndUUXY3L0dGL20vU3g2?=
 =?utf-8?B?YkczZXhNaGwvTXVQQldFR2lwenpOVHRpTlA1OFBQaVNHMG1wcHUvUngyMGc3?=
 =?utf-8?B?ZDNiR2tFQmtaTzNZYmhuNlJsUFo1MkM4MWVXQU1lMzFaa2pJdzdjT3NBd1d2?=
 =?utf-8?B?Q0tDMFQvZGhISVBCem1BN0FDMEtJekhlb3FNMUJ2WThXdjZHdXBUVzlGNDht?=
 =?utf-8?B?MHVTS2VBWUR2cGRGeUprK3NsdmkyQjA4UERUbWpURDVCMldtNUVaa1ZCeU9o?=
 =?utf-8?B?QThvOHdKek5ZNWdncHNsVGMxS3lTaDN5Q2s4RGxXUWRYTEhla3FHUm56ZWQ0?=
 =?utf-8?B?MGU0bEluSzU0dHZPQUlQaXR0VDFjeEN5bExxWGxiWW9qUmtSK2ZEUlZxaDdy?=
 =?utf-8?B?Y2ZGdzhSTUxTT21CNlUyb0ZqeWdkd3FNVjVSMGVPVCtuZFN6YXI5MjJORGdV?=
 =?utf-8?B?UUFab0JLNzkyZ0l4TDdHTzhIM1Y1WU14WENZNWNHcTVUaGFnNU05cmt4bDYy?=
 =?utf-8?B?SGRVWktKeGVKd3hVTnR4WTgxMyt2VmJGUGY4ZC9lTHRQMjBQUFdGUnZ0VWhS?=
 =?utf-8?B?cjhUU3p3VDlFSElySldxUzNCKzA4YWQ5STlMOU5mc2RRSHFtdW12YnVHMnl3?=
 =?utf-8?B?Wk1RWHRYNisxMmNHYTVTQTkyTlBxN3dqdzZVc1hkcTEwZ0tWRE9RcEMxMWI5?=
 =?utf-8?B?dWJLaU1iZWZEcllDTzFVSUtoN2pBcmZNcGFjMWc4NTNNV3hPSVhlKzRlR3RE?=
 =?utf-8?B?UVFWUlZsRCszNDFoaE5OSVd3MW5wMW5sSVVTaUFFRlNZZkNtSGtTZjUvY3ZM?=
 =?utf-8?B?dU0rRlJpcjlwL1laYU9PYUEzdk9wTmhpZ2krVGx4Sjd6NFNJSVc3dnFIUkRr?=
 =?utf-8?B?enJhTkMvVjA4c3lrcjdIcUNWcTFPNTJMam5Wemt5MXlJWHYxMmE5Y01OVkw0?=
 =?utf-8?B?TUpOSWZwL296S1FqTGlrb2NhbTdjVnpZSzE0TEVTV3NzdjVIV3pXa1FvQVpH?=
 =?utf-8?B?SFBvcG9JM3hUT1p0cVQwVXlqY0lVZHcrZXZIK0FGY3RiWncvL2lrWDFmdVNr?=
 =?utf-8?B?TnQ5eEVVV1NZZHBvTU9Ya3lWbTVrbVFtbDBtdHkwdzI1QStKVngza2JCWHNq?=
 =?utf-8?B?V3JQR2hUM1hSVlhWeVJJZVhFNHhwdUorM3FzRXFqVGxUL2grb3lmbE12T05i?=
 =?utf-8?B?dFNlWXRSdEJvczdKTTdpRFkrTnJnZGlCZ2NmZ1JtTGk3V0E9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10770
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fadc981d-eb2c-4c16-cb04-08ddc38bfc5e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW14bE1NNUQ2ejI4T2JpUEtXSWtIc3dtRWNPeWQzam42aDhNYWZKTWNVdWlv?=
 =?utf-8?B?b01JcjFjUDZwY2tFOWgyQWhqZGJpTWZHTkRZUkZ5c2NSK0liVUtyalBHVkJB?=
 =?utf-8?B?eUVIcm9jZWkySXN4ZHZHd2gybG9BQllTWlg5blJlek5BSDNMWStKNllJeDJm?=
 =?utf-8?B?WDdJUlVmRGNBNStQcytSL0U2R0xyK0w2Q05qdG5DbGtOSzJxSmFDUjJnck9X?=
 =?utf-8?B?ek00SzBBdDhRZFcwdXZyTzhZd1BIQ0s0S3VpMnN1bFpXaGJTNGNXOXhxT1hY?=
 =?utf-8?B?WVBJSHlpa1p1N0lFQ3NPeUdWVjhhMCtwekdFLzhycWw2YUNiZ3h2OVg2elhy?=
 =?utf-8?B?a2ZyUmt5c3BPYk8wSGtqMjU5cUl4T2tQMHNENFNBR2crU0IrMU9KYW8yM0hN?=
 =?utf-8?B?eldMdGZjNVhtM0U0NElDc20xSDdZbmtPVmhEZ1dmYzlmL3FFbSs5SEVXS3BE?=
 =?utf-8?B?RnEyb2ZoRm9kQWRCU2dLam5NMnY2bWxHdG1pU3psNHhmbTM1R0EybUZBVy9o?=
 =?utf-8?B?WTBZMUs1WTVPU1dQOFVtcGoxQ2MyOHlrdnZFWTV3eG05eXNndWZxNWdHQlVh?=
 =?utf-8?B?RTVDdjdtdFVqcDZKbUZYNDRQRTlaVStmMmtkMng0L3N1UFNFbXYySFJab0hF?=
 =?utf-8?B?RElHUnYrTDBRUkoxT2hrWG1DN3Y4eXBoS2xCNzFDNEVxZVg4bU05V05WeEV4?=
 =?utf-8?B?MnZrcmJyT0N5YXdBRG5XTDdmbFV0M1dJS2pVV2F1djQybkJLMytTN3hxMUo1?=
 =?utf-8?B?ZzJCNDgxdVZyMzU5OVJJQjdFa3dDb3lLRmcrc0lGbXR0YlUvd2xtdlZGUHUr?=
 =?utf-8?B?UXJXeVRtQlJpRkhvZ3NMSDJxa3BuYmNPVVZEOE5CK3RkRXpTckZXZXY1Skps?=
 =?utf-8?B?WkcxZmJjY0s3VWJIN1NBcTcvM0JBOHdRbktLUC9GV1lVeUdKUFQ0Ky9KbWxQ?=
 =?utf-8?B?REFpZ1crZmp3THN0S2s1WE1LRWFWUFRFQnJudlRIK2t4UGZRcUJkbmQvenRo?=
 =?utf-8?B?RVBtSWtDdTY3bHpmYzVoM1I4RmU2bzRrWC9mdGhPd0lQbnVvSWg5WDFDdlJH?=
 =?utf-8?B?REcxOGZLSGhKd3JRbyt1ZzZWUEU3QVBoTUNvby9PSXFJdTJKL3V6Ry8wd0di?=
 =?utf-8?B?RVFOVUlFN0Y3RE9Nai9kUXV3dTJvUHBjOWxURGRyenRkbGVmbkpiYmxXb2h2?=
 =?utf-8?B?MDVvVGppakZHaVZ0cVVRODJDcVkxQ3h4YjNJRnFrK0hHK0FWbk5va29neGlV?=
 =?utf-8?B?aVp3ZXdBdjNYNzNkZ3N3VllFWUNGV2tFaEkyK21aVlFHNHNZWDFsL092Tnlk?=
 =?utf-8?B?T2FXUHZDdGpRWnNldUFsTnJ0UFhqc1FJVlBNaVhkQnVHV3drSG9XU1VLQVJj?=
 =?utf-8?B?Vng5czFyTEFYaVlBWm1oQ1NidnA4WUJEbzFGSTVnckl4b053L2RjUDF6TGF6?=
 =?utf-8?B?V21OZ002RmRHQ2poNGtETG9ZaTBiUHlTKzZEdUlOOTNGUng4ZEdBNUpESDdO?=
 =?utf-8?B?cS9KNEpLb3FSeXpKSGl3dldXa3FGZWZYU3NqM3dvQWJDZEhjOHE2VGxTV21r?=
 =?utf-8?B?NE9GTXFzdEVEcitMS2FNZXhNTm1PMFd5WFYxd2srZEV1Q0dBcXFJMS9JbmxR?=
 =?utf-8?B?Ryt3MVNSOWxzVXZrUXNYa0RzbzErdkZ3cUhsdG56U205aWk0TlJDM2dPYkow?=
 =?utf-8?B?TXRiZExWVGlndC9Zc0pGdXB0ZUl5TktkWUxRaHhiTTZBaG9WQ0JlMHdkTHpp?=
 =?utf-8?B?ZGxhQ2tUdEJZWDBzUDJkSjRrT2NObi9nclB0aXJrcHlRWU41OWd4SHV2VmNj?=
 =?utf-8?B?VkFPTThuaFdvOWdzVXg1cHFmbGxWenlDS2RQV3BPNUNVWHJtOGg3VUdLaWpI?=
 =?utf-8?B?eWV0cVJ5NEppbzU4ZVdLTVNsOXpXYStLZ0ZIMmpLSTFacStmQVdQNis0V0dj?=
 =?utf-8?B?QSt3Z0k3dWRVTWQ1SUpZTXc5YzZoMUFqVlN6U3FJbkhyZ05hVlFGTU1jbFpB?=
 =?utf-8?B?d1RtNDVVeUdGVmhyUEw0bVc0QXVtRzQ4YVdmamt3dWFPbE1TdGVSb0lNZU9P?=
 =?utf-8?Q?7md/yz?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:40:50.3423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3097b5-42a3-4432-dab6-08ddc38c10fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7681


On 15/07/25 3:32 pm, Lorenzo Stoakes wrote:
> On Tue, Jul 15, 2025 at 11:56:26AM +0200, David Hildenbrand wrote:
>>>>>>>> -	if (nr_ptes) {
>>>>>>>> +	if (nr_mapped_ptes) {
>>>>>>> I know it's ironic coming from me :P but I'm not sure why we need to churn this
>>>>>>> up by renaming?
>>>>>> Because nr_ptes is an existing variable and I need a new variable to make
>>>>>> the jump at the end of the PTE batch.
>>>>> I thought you eliminated nr_ptes as a variable here? Where else is it used?
>>>>>
>>>>> Oh how this code needs refactoring...
>>>> If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
>>>> which is confusing since the former is plain and the latter has a _mapped_ thingy
>>>> in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.
>>>>
>>> Sigh, this is still awful. But probably just existing awfulness. This whole
>>> thing needs a tent thrown over it and fumigation... but again not your fault :)
>>>
>>> I mean fine, this is fine then.
>> Probably best to be pragmatic here: as long as the educated reader
>> understands the code, all good. I hope I'll never have to explain it to my
>> daughters.
> :)
>
> To be crystal clear here - Dev - I am not asking you to refactor the existing
> mess, and obviously I concede your point on the issue raised here.
>
> Did you need to respin other things here? If not I can relook and give tags.


Yes, I will have to respin because of folio_pte_batch() changes from David and
have to add a simplification patch to this series authored by David, I was just
doing that and was reading the email thread to see if I didn't miss any review
comment and then I noticed I forgot to reply to the above point.


>
>> I know, I'm a perfectionist myself ;)
> I mean if I wanted perfection I'd have run screaming from the kernel right at
> the start :P
>
> But in general on the refactoring point - I think this code is hard to
> understand even for the informed, the endless nesting and nesting and levels of
> 'you just have to know what's happening' make it really easy to miss details
> here.
>
> What I'm saying is - we can improve on this, and really all I'm doing is
> todo++. Possibly even dave_todo++?? ;) Or could even be $<name here>_todo++ :P
>
> I find it impossible to not mention this when it seems apparent to me... force
> of habit :)

I personally suck at refactoring code - it is something I have been trying to get
better at. Now that I understand khugepaged a code a lot better, I have been
thinking for a long time to clean this file up, maybe someday I will gather
the courage to do that : )
  

>
> Cheers, Lorenzo

