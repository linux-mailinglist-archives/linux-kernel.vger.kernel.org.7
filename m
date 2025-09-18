Return-Path: <linux-kernel+bounces-757546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF686B1C374
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C618A5097
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E1289371;
	Wed,  6 Aug 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l2n7GAiW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l2n7GAiW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC81FBE80
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473116; cv=fail; b=gjBBYKFqEafmsnlNAUwH0h35qdYTjGu/A6UEELJmOsogHFI0QOXy8uTNsvHNZT/6DdXjAijmdcWa37n4zsBYHLASQ+NKT4Tjn3qf6AL/oKWUe6a5t0fgl8tu5gZw4X141ta5ICK3DXoIXu7w1KA81uXrWQZ4A+5cvQvkLzraVT4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473116; c=relaxed/simple;
	bh=41DBq397RZaNUED1k+6NFjKtF3o5aOP8n4u+ldVpgCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pbI9QkiIZqtZ/jT/IFOI0JtGp9nHebYq1DWpbaB6P7lsn0G+NDNxRnqiFtjdmXYxKjiIhf7wPK27N8GbK33F7kVMp4N/TUilt8O95NnfVXvfQr6+6AMcMOcZOuRfWRPMmWioWY1NDZSJ3M/d1hxSnSVvc9C3da+0AzamrZBC2kg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l2n7GAiW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l2n7GAiW; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H5D1xFJz+lbphAGlp8RaiihF2twXy0fhEEIMPWKBC38PuNXCF9L1ViRpLQmgLIYMuNBgGpzeXj5njH/fmy8wyS0x5683WOzddS6aVcxsFaHCbUGsyo+3ez7fZ2peVJWFrqtZbb26QetfWspxMkz8uyyyiVriaVZbL067gV5TfHkis3fJhJ7Z/T1W/V57U17hmLIJVbX//zbMZ+Te9/1OIWZHBPQzey4RKL4CSAWSC7sKDJubI8bzWy6Hki2TsUDqnTyC+le13RQv0LqtkwgU1hrT3Q9zu8BtgrTaxtj8thazvvMMAV+a2Ub6+SAnrKeyQSv6v1KMP3ZdkyEaFA2PmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdxin3BSq9DLcrtFa+Vibwc7mGe8xRqde6g68/MoAoY=;
 b=L9NF+9UT6AT135fgrY/PrBx1YHcIoQ5/fjJHlWSBHBDRU+FLLvxQc4B9P8i7p6Nghz3OVF5HOCZz2micV3qtkE5h3Oy+vlt5nRtsyDsZnQPj6m9ttNTx+n6UxpvTZ5KAH77G0QKSKM2lE3R9TPWlDdP958EGifBK/TyS3VgjNbe/no+ZcO/0gv5KwR3fQ5heCWkd7fDXN76XdYBu0ffgwzfG1GLSi+38VKK1QI6GIHMxWuWdiw3B6ZlqWdb9QD7O+jj+SyxOy2RX04zH/Sk1oTvWQx3dBhPRzvMbghAJBz2hBN9tmH1xKvglIEhA0Eus8Q8s3MCvraZr4Okmi+9XyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdxin3BSq9DLcrtFa+Vibwc7mGe8xRqde6g68/MoAoY=;
 b=l2n7GAiWUaUIt7GXFIC4YfavsKr7Wn3kC4J1SD+1rsvWxww6tieuyFf77zUB6G7FHgzqNR0XhUaLjt+fwwZ/3ir0m4hajtJjbpAytfYLzbgv/Y8IlvujueF9Y5RUuStOM1rM+4E+gA8x/EFFWs6XYwFKAEaOvBnYQ8g2W2fZjqM=
Received: from PAZP264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::12)
 by DU0PR08MB9001.eurprd08.prod.outlook.com (2603:10a6:10:466::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 09:38:30 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:102:1fc:cafe::a4) by PAZP264CA0041.outlook.office365.com
 (2603:10a6:102:1fc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Wed,
 6 Aug 2025 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 09:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWn52IkLUo7y95QfsWcLA504g3xjuNzxa1/T//I3CTdj/rkaKF1b/b690r+qcw4dn1rKqpDwvffFiP+qOkN/hseP/Kxa1Xsypx6OsV6a+jATOzIM58tVfnNpRdMUdglBv+ZTowkoRE+iVfPpBhgf4uUa8BsMpw11PkkmR1NRId7UwSQV89PECBwa15gQz531BPkNEU638PMlX1rdhPHVrpiqjl1sPd0bkZ96xY0PDtchAJm7/exNUFk1ph3IVRS0YwSCvpSQ/vnO29JHRuH2Wx9OnsXl7YZ1Ikvdkt5xMXAZjzNGmo4OAujjZ4/NJoa+2frZI3PtPYLsNf+a/Hnakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdxin3BSq9DLcrtFa+Vibwc7mGe8xRqde6g68/MoAoY=;
 b=kAIcS55A1yN+iE5ptdVR2zyBXF2XhjzsTGXJ9VqX1cKPYeejhiNCROzxbT2ze5F+xDltEM6WGb7/VNTEyWHT0nfXDSN674KgYhE3+gIwIDqVzJmnq/TQO67iij+CsfsHJVlpUgOCYxC6ue6TsLyt9XhP8bVeLrdLB+VcaIl8tW6AKcx+gjLqFR2u0GOiYmo4rnoxFRQqQQZfuoesrpjt9XdQspGg99Z5dm6jC5UIZ83lOMXMonkB1AED3q7eINtLi3T8Cb3O59Q2lYdIc6saM1JYpfCTmoq1e9KKR3uLr1Jk4t0cuQxEtb49ITcSkP1wv/IZ9luVpMRxVXkeJQLcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdxin3BSq9DLcrtFa+Vibwc7mGe8xRqde6g68/MoAoY=;
 b=l2n7GAiWUaUIt7GXFIC4YfavsKr7Wn3kC4J1SD+1rsvWxww6tieuyFf77zUB6G7FHgzqNR0XhUaLjt+fwwZ/3ir0m4hajtJjbpAytfYLzbgv/Y8IlvujueF9Y5RUuStOM1rM+4E+gA8x/EFFWs6XYwFKAEaOvBnYQ8g2W2fZjqM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB10842.eurprd08.prod.outlook.com (2603:10a6:10:533::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 09:37:56 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:37:56 +0000
Message-ID: <0d52d680-f3d3-454f-8c12-602f650469ab@arm.com>
Date: Wed, 6 Aug 2025 15:07:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
 will@kernel.org, Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, baohua@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, christophe.leroy@csgroup.eu,
 yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
 hughd@google.com, yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <9552ddff-d778-4934-9349-37c7237cbb78@lucifer.local>
 <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <54ee1971-d91a-4fe6-90b8-16212c8568d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB10842:EE_|AM1PEPF000252DB:EE_|DU0PR08MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 2265a10e-7299-4f89-0fa6-08ddd4ccffe3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UFRadzZIdVdwamNSekJxdVdLYnJpTklEUnVSNzRCMytoQmZ1TEpVaVVXZFQ3?=
 =?utf-8?B?dVBrbExTOGltZHJwTmIxOVBnVnhzeDkzdGF2MHNicFlrVGo3alM0RlFZYThG?=
 =?utf-8?B?Nm93NmpMck9rSW9NTGVPeGJ5dE5CMDBlUTM1SzM4MG5mbThTYVNUaHgwb0Rq?=
 =?utf-8?B?VU5IeXo0VzFqRS9GZ3lnTFR1SndxR0JYQzlaRXBmcEdFb0ZtRUtGZUFxendm?=
 =?utf-8?B?UWFBcjVEN0hCOEt0MDhzc3VMclUvY1M3ZUlxb2xuc0tIUHhQMUlKbG5oTTli?=
 =?utf-8?B?VlFXSUxjOVB0dGF2dVZyQWgzdCtSVHh2SUl5MkMvaG5hTVRZYXlvS3NGNTBm?=
 =?utf-8?B?ZURVYm56d1J4STVaOU1rREtnM2ZrVUd0RkloNFdtdEJXZG1VTjdMa1ZiMFJ4?=
 =?utf-8?B?VnFvNlBMNHhxeEdwVmI1ZGNBK0tyUGRaTS9SVkZKSzZ5QTQvTWpGYWJYN3Vt?=
 =?utf-8?B?N3BhRkZ1WXZDZEtJWWRwSXRTRWNITEZvOXcxWUt1UklnUGdaQXAybTE2Nldm?=
 =?utf-8?B?MGZ2VE9LcmxiOFE3QTlvOVFIa0VWWmthdnByZmVVNUtQVUhKKzlhUjhaVXY2?=
 =?utf-8?B?WWJHcmlYY1dUa1dlbGdRNU9FQTBtbHhFYWtmdWUwSUJsQVU1SW0rUlN4NnFM?=
 =?utf-8?B?QXYxcXVoZm5xY0Y0SGFvSUJvRytDOUk0OVU2bC92S3ZJMklHMkw4QTBtdldp?=
 =?utf-8?B?Wmd0OExvWFAxSlExNVJYZEdydVlLaEJTSWdsVUt1c3dESnAzS21idXZLRm9E?=
 =?utf-8?B?WENXaXRkMEhDamhqblVyZXBWUm1oUXhWRUk1KzRZb3RtWHZRbThnWFAyVHdM?=
 =?utf-8?B?Wk93d3E5cGtSckxUVWROQnRhdW4wdXlpY2FzNzRxcDJWenR4SVIvRy96TlNU?=
 =?utf-8?B?SjlhMnhWZVZ5dmorYXIxbGZvSVpIU2J2QmYrci9aYWErNEFGZ0VVVXdVZmpa?=
 =?utf-8?B?SkFhSGtyb1UvbENRQ2RPYzd3RVRVcVVTL3A5R1lhVGhIV09ROG96YnJnK2tn?=
 =?utf-8?B?T3FtaXdVSjhjQ2h2ZFlYMlN5RkVoa3NoRzRsaUtQajJ0VjhtVUVMaHJDeVdp?=
 =?utf-8?B?bDRtclJ6MUtEbmEyVDRBb01wTEhqc0puTVRxTlZka3pZVzVGMmpsMTZlQ2Fp?=
 =?utf-8?B?VzJNWTV5YlRza3RVVkFiNVNnTnJTMzFxMDBCWmpaSnNyRGhEVFVLTENiVVIv?=
 =?utf-8?B?MUc4djFGTlJGK1R3MTNNTkFTTEJ0RnJlZldJRVZlYmZyNkhHN0s0MmFacjMv?=
 =?utf-8?B?MzZiUkFNUy9OS2dlWWdoMmUyS1V5RlJIOXJtdWVXZWdGT0E0MkFSQXBzSU1D?=
 =?utf-8?B?M0tRalptL0p1YWhVbkgxZktEMEJMLzFRMEM3RTFWbjd6VUw1VktDMmpSUGpT?=
 =?utf-8?B?U3lzNUsya0hXTWdCMzY3MWs5bU51R2FycGErdE5WVEJrWVZRM2cxU3NFTnpO?=
 =?utf-8?B?UjYrR2pnNHBPT2RsK1JmeFV6L3l2UEpIb2MvWFJvUFMyblpsZnJCQi9kQ05B?=
 =?utf-8?B?VFVFckRkczRrS2pkWWZlR3ZrejQyZkdLNjJVMjJjYVZMekYxckFZTHY0eVZS?=
 =?utf-8?B?MFY4c0Z5L05sckRUdXFVa0lPaGNyTTVlYWpJY0dOWW5ubEk4U2FodHFFT2lX?=
 =?utf-8?B?VUg1TFVpME9wWk5LcnBzTExoMkYvWGpodS9QeE8zY3BuR2FoTGZObWhTNWZm?=
 =?utf-8?B?OXZKaHBqUDJGTExPc09RSCs5YU12TlFsdllNRndYMjZLWFJEYS9yRU16Uyth?=
 =?utf-8?B?YjRPa05FVFJRZ1U1Ym9NU2NvNlgyYUFpSWdpSHVMWUFEVU5OaDUvSnZMNlJR?=
 =?utf-8?B?UndWeWtma21vdWd1d3F0bXhNYml5cEpNbzlNbjVBRnh3K1orVk9jZkhITFVr?=
 =?utf-8?B?TnFrTEtjQjY3Rnh3R21UOWRSQVg4TVgvMm95T2YzblBaOVE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10842
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e138de5c-3968-43cb-434d-08ddd4ccec96
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXVzdVVETUZQWDRJOERvTnR4MENEYTZWd0pvNWl0QnlRR2kzK3M2aUlOQjNm?=
 =?utf-8?B?dzhNeTl3UXR0Q2Vib0wwMHkxZks3RmN6ZFBvSlZESi9TcHpjSWFGR3I4V0E3?=
 =?utf-8?B?VHNpZjV6VSt5N2RYMFpadkVuQmpJVUxPNENLd3BZVTlmQjduaHJldnk4Z244?=
 =?utf-8?B?bklHSlJIeFp6ZmxoTUhoUkdRd1ZsandocjJ3aklYYkZYS3NMNU1MYnFLRzg0?=
 =?utf-8?B?S1UvMnV1OEIrVzhkblh6T000Y2RESDBQWlBRdC8vZkdQRGNnK2JYNlNjVGE4?=
 =?utf-8?B?US9wYzVpSXo3MHF6SFZwbkVUdGt6Y2xWVExGeFhBRVFWL2xKcFhVS3Q4UExo?=
 =?utf-8?B?aGFBcVovSU40eHA4SUMzaUwzRm5RNjE4TUN1U3N5cjFqUk9sa1dYcWJ3dDRz?=
 =?utf-8?B?NmpmaVFHYWZZWUszbGJJdW9TVVlJcVlkeWhuSU9Oa0pva0Flbi9abnp0ZWJu?=
 =?utf-8?B?STduYmhQeURzSUZvdGpFRC9uTFJsVXRLMzFjQ2h5aTUraEVqOFh2blVsQzd5?=
 =?utf-8?B?Vlh0TU4vNUxrUm1MMytiRDZGVWczQjVVWW1QelVFSkRhTytZc0pCMlA2Z0dv?=
 =?utf-8?B?R2pYUUpTL3A2T1g2YkxMazNZMEhMcCtjNXNQS2I2dlJrMllQajdWd0tMdnFF?=
 =?utf-8?B?ejJrdjZhMGE5cG9DbkNJNkNzY2JoRG9nQTJSdmZPMjd6U0pCeW5hSGFzdGNJ?=
 =?utf-8?B?RUszRnNZVGZ0WEltSEF0VjZGZTRna2VUa0h1U3FFeCtPT1JFNmRaZ2JrNXh5?=
 =?utf-8?B?MSttbnB1M3RYYUpaOUM5d2tydmRoTTdsQWtidElYTU4rdExRTGUzLzMyNEYz?=
 =?utf-8?B?UXNQNVVVa0RyWDhZWDVSVEhHQlNDeDhDazREemxVckJ1bDhrbVdDUTJMV0hz?=
 =?utf-8?B?Mk1SSWJ2Wm1sWFRSOUo3dDdINHlxNHZkYmdORmlYeis0dmhMU3hVOUhkUmNY?=
 =?utf-8?B?V2cwcmpBcm5DKzBaZUQyTStFMkh4MmFqN2JLTTZBNzZIMUtabDc3REpmb1VI?=
 =?utf-8?B?aW1GcHRwLzJZVnNxa092UjRzQXYvVG4vREVGM29mKytsMWd5RTNMWDZhR3k5?=
 =?utf-8?B?b2xmaVdma3FDZkk3em51YjBpU2QzQWpxODB2VHpxY25DeGFqNmlMWGdyKzhy?=
 =?utf-8?B?VmJGQmRQcStQQ2Q5K1k5MVdJbll4WUFheWIzQUM1MFl6QTk2cm8ydm8wN00x?=
 =?utf-8?B?RURFR1B5TGpTZzQ0ZXl3QktkV3cwR00rMS8zdDV3WkVtZFNIMHpZbUNQYnQw?=
 =?utf-8?B?dElpbUFMVEp3akJxcS9kVTdJcVdkZjVEeTlCRFZaU2UzajV2YTREa0FNQUQ4?=
 =?utf-8?B?R21OMjM4aVRCRWtBc0JmUUR5d1JTTEFmaDMveUgrRGRXalRZNXQ3MjBTaUJx?=
 =?utf-8?B?eEZFODJqNldmUlZpaUgvQkxEbGhhUUFlM1F2OTFOWVBHdXVtcExsKzV0TmlO?=
 =?utf-8?B?SGQwNlZ0K1VXVVFNTUkvdm81VFVBaU52THJ3bndYdHdYcXBHL1l0ckRpdUMw?=
 =?utf-8?B?TU5sWmN0R0U1Yk5XVER3REtrZ2NSeE41ZldjdXRIOXV6NFJBR0JBbHUyODdy?=
 =?utf-8?B?ak4xb01vRUFNNkxLdFQrRWxhb01USzc4ZXQyajA1ZVhPSnhFdWZyd2dBaWN3?=
 =?utf-8?B?LzFwWW9VME0rRlVnZUd6ZExYTnJONENUN3o5SmdJaDlDbGVGQ0NtT3Y2UTN4?=
 =?utf-8?B?L0lKOHBhdFFieVJsL3lrMmExVXF4b041d2U2YWwvWEF1bERMMzFFVlk3SFVq?=
 =?utf-8?B?eTg3bzR1a2tRVHBRbnZYR25lRVNzTDVUL3pURW9CZTB1czBKS3JIbkIrMWRz?=
 =?utf-8?B?eGk0MENrUHBiaVg3SGpQbW9YZXAvVkZhdlE1Ylk1ZUJzMG1qWlB5bkhBRlk1?=
 =?utf-8?B?RmE0U0dFc3pTdnpOZURCMktiTUNvRnRQZk9ib2xtK2FEdTBadXI4d1Z3MTMr?=
 =?utf-8?B?NmxxUVhBcXZhNUZmSXJzblhJY1gxNC9qYlFybmgwYkswOGpjTU50YXk0b1pm?=
 =?utf-8?B?MEhhUHRXOE9naVdhQzBpcUFYMGh4Vi9qTFlGLzU0cGJNemlVZDNMMjluRisv?=
 =?utf-8?Q?c3/byH?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:38:28.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265a10e-7299-4f89-0fa6-08ddd4ccffe3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9001


On 06/08/25 2:51 pm, David Hildenbrand wrote:
> On 06.08.25 11:12, Lorenzo Stoakes wrote:
>> On Wed, Aug 06, 2025 at 10:08:33AM +0200, David Hildenbrand wrote:
>>> On 18.07.25 11:02, Dev Jain wrote:
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>
>>>
>>> I wanted to review this, but looks like it's already upstream and I 
>>> suspect
>>> it's buggy (see the upstream report I cc'ed you on)
>>>
>>> [...]
>>>
>>>> +
>>>> +/*
>>>> + * This function is a result of trying our very best to retain the
>>>> + * "avoid the write-fault handler" optimization. In 
>>>> can_change_pte_writable(),
>>>> + * if the vma is a private vma, and we cannot determine whether to 
>>>> change
>>>> + * the pte to writable just from the vma and the pte, we then need 
>>>> to look
>>>> + * at the actual page pointed to by the pte. Unfortunately, if we 
>>>> have a
>>>> + * batch of ptes pointing to consecutive pages of the same anon 
>>>> large folio,
>>>> + * the anon-exclusivity (or the negation) of the first page does 
>>>> not guarantee
>>>> + * the anon-exclusivity (or the negation) of the other pages 
>>>> corresponding to
>>>> + * the pte batch; hence in this case it is incorrect to decide to 
>>>> change or
>>>> + * not change the ptes to writable just by using information from 
>>>> the first
>>>> + * pte of the batch. Therefore, we must individually check all 
>>>> pages and
>>>> + * retrieve sub-batches.
>>>> + */
>>>> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
>>>> +        struct folio *folio, unsigned long addr, pte_t *ptep,
>>>> +        pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather 
>>>> *tlb)
>>>> +{
>>>> +    struct page *first_page = folio_page(folio, 0);
>>>
>>> Who says that we have the first page of the folio mapped into the 
>>> first PTE
>>> of the batch?
>>
>> Yikes, missed this sorry. Got too tied up in alogrithm here.
>>
>> You mean in _this_ PTE of the batch right? As we're invoking these on 
>> each part
>> of the PTE table.
>>
>> I mean I guess we can simply do:
>>
>>     struct page *first_page = pte_page(ptent);
>>
>> Right?
>
> Yes, but we should forward the result from vm_normal_page(), which does
> exactly that for you, and increment the page accordingly as required,
> just like with the pte we are processing.

Makes sense, so I guess I will have to change the signature of 
prot_numa_skip()

to pass a double ptr to a page instead of folio and derive the folio in 
the caller,

and pass down both the folio and the page to 
set_write_prot_commit_flush_ptes.


>
> ...
>
>>>
>>>> +            else
>>>> +                prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
>>>> +                    nr_ptes, /* idx = */ 0, /* set_write = */ 
>>>> false, tlb);
>>>
>>> Semi-broken intendation.
>>
>> Because of else then 2 lines after?
>
> prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
>                nr_ptes, /* idx = */ 0, /* set_write = */ false, tlb);
>
> Is what I would have expected.
>
>
> I think a smart man once said, that if you need more than one line per 
> statement in
> an if/else clause, a set of {} can aid readability. But I don't 
> particularly care :)
>

