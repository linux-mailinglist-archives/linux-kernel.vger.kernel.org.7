Return-Path: <linux-kernel+bounces-759335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A4B1DC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D5917AF59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5F26D4C0;
	Thu,  7 Aug 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFWhwNDh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFWhwNDh"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB113E02D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754586331; cv=fail; b=grtCOjsA58vaVjsWGFh67CUY6Cq6CHvRtWPa847RX7zuKvbLK+f+9pQVLaSe6xIYQGIBv4svzUarIXXv3mKOLBrn7B8N4bMrXdoi+sK+0gDcnu0q0fGvoa4TRYVswWc4e3eQpuoeUabKeY6M+uNA/gNlyf0gDQ0q7DgHuuWVOmk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754586331; c=relaxed/simple;
	bh=j2f3gUrCC260o5cwrNp0/CnlBDcomyyoK5onYMEIoo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkaV0CKKNtGgB9rPa1Gqec0BJ19zyYPc7IPC1F3XvtmzEOuLJNRHDjTGjd5eQcwpw5lAKR68kXAokv4oArUMrkhH0/LbW7O5EIM04u1AW9yvmqFJlp2l5HVNIg1O7tYz2a4Mto8tnnmNtXXafCJmZPXGl8QqAlusnRcPcmmWcpw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFWhwNDh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFWhwNDh; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ahg8FY0QGv3jkEXWUu6O1hcibMcFRK+YC/lSti74jpAtFHYLf9cOlojyBeWr21Rlfx97HHI4gyRmX58sJoLQpqJ3oS3tarD5ENDeCfeK4+ToLefxwgAxaNs3BOkO7qyvTGnoI2P3ENZp//Q6kUXjH2CUarSoDkMx3nuvYOvHaJq/Q4COA/d3WKTBoXTCgVa3p/hPBNBZP8bw1EM6hT1S9TXh4xasW28860l9p+gw/EvhoDeaQ3ZecrlWoYyHzmFChupjhmlVySFBVO8IamfXavmj963doYPrcMaExv/DFwg9PC7YCnLHsVC/2RdfIlpTiA4j5BjgtoTtphMMGyyeVA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPWjxI79Ok9iyVVnO37Q4CCKV/S4m0K1RPumyL01uZA=;
 b=pqt7hUrvqJQ0CsSf07qqngQ94k2ESgYUJ9+IkHsCg+4U8WptTaViRwF0e9fStgDPmP8+O9qQH2RV7lqJMvKFbTvLmMpF4zXSLS//gKctjINLGTBy6WJWjwscX3LoQ8SKd/Eb8XhfmTn0Fl2mSo0WiOEEYTbQq1ubcXDHfJtbsK4s55PnYY8BNUVdPPQMucw7l08vfj0QczAD4KuOVI4Aov0WX61B55Ag9GelZe/CewGBKzDfXwJ8TAwIYwG0zJbGu1s1Dmtal4xLmjUtfRJ4aRVTWHpQ5IiFEo16AmL7vb0NFthxxb15t2wRLZpsX+QAS4B2CJcUw2rG9Z/w2xzIwA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPWjxI79Ok9iyVVnO37Q4CCKV/S4m0K1RPumyL01uZA=;
 b=XFWhwNDhxll1V2wdrbiIEESbyjYLnKkuSQIU54cf801Q9rOnXqyf7P/sJFVPYb3fOvb1E/Gq43Vq9lWDpmFQtnGzNRsmMq228DbsrBZs5bAzaZ2hLMBk2M2MgVEdyv2WV0pCScvXCxJj/bEcq9qFYNspZUCbMA6diduKTlh1X58=
Received: from AS9PR06CA0215.eurprd06.prod.outlook.com (2603:10a6:20b:45e::22)
 by AS4PR08MB7632.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 7 Aug
 2025 17:05:25 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:45e:cafe::10) by AS9PR06CA0215.outlook.office365.com
 (2603:10a6:20b:45e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Thu,
 7 Aug 2025 17:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Thu, 7 Aug 2025 17:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYmLZKKI0r1ZsAxnIn41eZENynbJwvYcLzgnIkDw4DBKOFO7ZlgeYv1zgRzlrGK4OdxMx8CXmHFaBuoxJYRKNU8B4ssQZ64V5DcX4TW2Bc5L6KtPIcNiyMOUPTTYxAwrnYe+zxRB+IinKazSOGw5TSpYXSu8NiXfSASIw91vNHgW16c+C2uhpN1D1/Lo0dpmzWbzR11PGTQtxiXtpyiS2tQnngoauFF1zQlOS6YwVEVGynTZ5uxpeYZV6pnlAh/0TVos72Xid9/UCCKYy00+7eqC7/diwdZLpbcGgp3dZ4/GftQ5OodUFsfOchPJdoVWwryF2zodYb8SFJcY+uXh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPWjxI79Ok9iyVVnO37Q4CCKV/S4m0K1RPumyL01uZA=;
 b=Dkij+IZp7n4dN7UZ4SW/j6SvB3oizbV2aN5tNyMKuHuuDnwNbQCdi99UPh9mO/hPJCWgzfYMjiy46uLBDpYqtd8zR9Qd6A5JukY3Ht6KbwBdQ9840Au8BD2dJDHNhmxWktyNHPFiUNgB8kCJH6oAE7mIDxAtJZ1fROicOTZdK+CkP+jroTkqQqOKlkKvul2vSZeIKiJdYqKhc1TpbRkPWEgbwcwSgaIFQ8+xesFi1ejIyNWC3wns+pU3PnN5YG/K38hJ7b5pJNbw6192aNtZqQ2zzOGqJ4bdYAoSWcMHAPm1UNgVYT6KqzX3mUa0xM6SmtcuhFzTpUSJPknMwW4jUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPWjxI79Ok9iyVVnO37Q4CCKV/S4m0K1RPumyL01uZA=;
 b=XFWhwNDhxll1V2wdrbiIEESbyjYLnKkuSQIU54cf801Q9rOnXqyf7P/sJFVPYb3fOvb1E/Gq43Vq9lWDpmFQtnGzNRsmMq228DbsrBZs5bAzaZ2hLMBk2M2MgVEdyv2WV0pCScvXCxJj/bEcq9qFYNspZUCbMA6diduKTlh1X58=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM8PR08MB5778.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 17:04:51 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 17:04:51 +0000
Message-ID: <507b057b-8130-4f71-bcb5-11a2000f20af@arm.com>
Date: Thu, 7 Aug 2025 22:34:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm] f822a9a81a:
 stress-ng.bigheap.realloc_calls_per_sec 37.3% regression
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Bang Li <libang.li@antgroup.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, bibo mao <maobibo@loongson.cn>,
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <ioworker0@gmail.com>,
 Liam Howlett <liam.howlett@oracle.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Yang Shi <yang@os.amperecomputing.com>,
 Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <202508071609.4e743d7c-lkp@intel.com>
 <9e3a59b2-11c0-43ca-aff3-414091f04aa4@lucifer.local>
 <97419aca-af5f-4328-84dc-c97bb73ca1ac@redhat.com>
 <96e931a6-c70e-4a11-9e8c-c5a08da7f512@arm.com>
 <66f44615-8df5-4e81-97b7-1f6a01401687@lucifer.local>
 <923f1a9a-4e34-4922-ae2c-c8d974c2522b@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <923f1a9a-4e34-4922-ae2c-c8d974c2522b@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::7) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM8PR08MB5778:EE_|AM3PEPF00009BA2:EE_|AS4PR08MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ce8dd3-f43c-4a89-901b-08ddd5d49987
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?NlZPNmlqU291VWtBRVE4M3JQWmoxTVkxYUlaTlg3WXcxd3phQ21sZEF5ZERj?=
 =?utf-8?B?bHNDemlFNmoxeGhHS0hRY1VnQkxXUlBqMEZhNnF4YXcySnp0bHVjQ3paREJn?=
 =?utf-8?B?bWIwbDcyY1JOYUVKN1EvdG4zUStGN3J2enhQSGFJUUVscmltT2VzQlJoTkpP?=
 =?utf-8?B?UWZYUTJ2NGMrYzR5QUFpbnJzaTA3cG4rSXl3Z090cEE4LzZFNC9oUVpHdFZX?=
 =?utf-8?B?ZXRwTCt3YUFxSFF2VGRUeXJQVzQrN3dBRVN0Y1BZV0xOdHBZLzJER3RnNnVL?=
 =?utf-8?B?K01YOWNRanJwVEtoZzRIWklsL0s5ZEZKV1UwRVdNRWtNVGxaWEMrOHpGYm5n?=
 =?utf-8?B?ZXlXT1ZaRFpPYkI0Y2o0OWNzampTVTRYNzcwcTBZUTJQRC9yL3J6L2w0SGsz?=
 =?utf-8?B?TzFBVlhlenpydFhOUEdwelBiV1g5MjZzaVV0a0JxVmMrNnlUODRxTjZHRnJJ?=
 =?utf-8?B?L0ovd1IvZmRrUFJLNERBek80enFDS1dWckl1V2oySmM0ZzJZYmgwT0xBRjIy?=
 =?utf-8?B?MU1iSWw2cG5Bb1dOY0xrbDl1c1JUQ3Ria1NYOGlIVXhoYjBaaDV2S3hCMnZW?=
 =?utf-8?B?ZGV3alh4ZXVTcFZoNzNYeUVBbEMvenlBclMvM3g0STlCcUIyQ2RTQ0MvWDVK?=
 =?utf-8?B?bzRGeDVMWEtmWUp3ank3UmpvM25wSDNpdkNaLzhXTzFNVmViYzJXVEMxSnZN?=
 =?utf-8?B?djFpN2pObUpSUVRUZ2xPYUVacGh1QWRqSHRsMDNQQWl4bE9jdUU0YmloRUYy?=
 =?utf-8?B?Mlo0Y3NWc0lqYXdGWGl3VUJ4YTJ0M0l5c3ZpWlBUbVhpMVNGd3JTOHhjV3Nv?=
 =?utf-8?B?b1FQVkxpemFDQVdkdk0vYS8rTnFlZ3l5ZWs5VmdnbVZvY0I3NFAvaGhkcnJK?=
 =?utf-8?B?NmJ0Wnk2RGNHY2xhejNRK2tzb1ZtaEI1SjRnL1V5dkdKRG5JWThoYzFIMUN2?=
 =?utf-8?B?T3ZBVW92UHF4cGU1RTN2VmIvV3pHV214MFpVbHZEN1VIVXRDYmlKcThhVTZY?=
 =?utf-8?B?aklBZVRQMFhYNjZKTmxYMGMxSzZkVnl5SC83Y01kY2kzWGFPQWtZUzBZWURM?=
 =?utf-8?B?bkJyM3Q2MnFnZWJKM05iY24rMktPZ21COXFEc3BsUU5sSy9MS0syY04wcTRF?=
 =?utf-8?B?eHNXOGp4OGt1aGhETzhxbElqMGo4UW1Dbm5jOFh3T2VGSkJjOW55c2lCRzhm?=
 =?utf-8?B?bS9PeFZVZ1UvdG5mVmYybytaNmQ3QnZHdXlnWUgwUVUzdG9lMVh2bkpjeFA0?=
 =?utf-8?B?MHg3djRzeVkvbHBTaDg5cWdDVWFOSEhMb2dzcTIzNWNqVTBZa1RnYWVUZlBJ?=
 =?utf-8?B?Q0pRKzYrVm0vTmRLUVEyRSs1cXlsbnpRdVd3bmRQaGJCUGhZSGVDcVZRcU1C?=
 =?utf-8?B?azRaTTBrYjR2NFBvcDNuTkl0TTk4N2RFaG9kM2NJd05laEZUN1NIa1VqQUE0?=
 =?utf-8?B?aHQyMndqQ3hpMmlvMVhOYWZZdTViOVVpT3RKUG53TzViSEY1dTdUWjBXYk03?=
 =?utf-8?B?R0pZdHpGZUhZV1hwMlhVejdGdGsvcS9PUCthUlB3T01hcDdENGFKSlE2YkpN?=
 =?utf-8?B?bWM5TVE2SmdpM1hHcTNiVlpiQ25WbVp4M2sxTE9VWi9BMDZoSWZwcEVXZDdV?=
 =?utf-8?B?VFEwL3FsTG12SjFLa0ZScTkxMkZVbDA0RmF6My9FSHh4VVdsUE56Yy8wUG1I?=
 =?utf-8?B?SHByRVllNmVxOTN4M21ob2V3Y0ZIV1NGSTByMmpKbXlMZzlxYzhZWDg5ZjJD?=
 =?utf-8?B?RFRkRXIvTHZuMVZNTFVORnNSa2JFeWNOQVYrTGhjM1FBb3VrZUh6UGhnSHZQ?=
 =?utf-8?B?Y2lyUjJHTkFxNS9Rb25jUEhHVERYa1dvQmQ3a3ZieXVEYXpQVFQ1YnVSZHAy?=
 =?utf-8?B?dnhuQ3dLS2FtblhPSG51bHVmZGVMdk9rNWFQZk5BYzd6Rmh2N2xOUmg5R29k?=
 =?utf-8?Q?P61C8ZXaSs0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5778
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	260c42c8-5323-465e-3318-08ddd5d48593
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|35042699022|36860700013|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RZNmZWWE55dTc4aGllWTFDTHFhNkd3UzhPTEJNeklMeWVQTDFFdzVuRzhV?=
 =?utf-8?B?UnJmWUZMMGExTzE5ejBXTDhhZDlyKzZJUDVnV0laR0l0Nk9PamE5R1picmEv?=
 =?utf-8?B?NVNrN1oyZFgwZUVZZEdVQjZkWDVaT0FSMk9JK3dteHFWMHAwS0xiQkZBSnhy?=
 =?utf-8?B?Ync0QzZMdTJ1TjhHaXkvaWQ3Q0JpbFhvRjZqYURVeEdpK3AwZ0VtMWNMOHd0?=
 =?utf-8?B?aGx4Q1p3VkxtbHAzQlJXRGduTFA2Sy9vb0lOTDM2d2VmNjY4UnVKeXVIeWFY?=
 =?utf-8?B?b0pQQjFjaTN2ZUt5cnFBbDFpTFZISVhwUmZNTGk0aGdySkl2MXc1RE5uRGNj?=
 =?utf-8?B?MmdrcmVWMy83SjhXblRWbkt5SG9MdkVPM3VISXB3djNaSlZuZVdDbUFORjZv?=
 =?utf-8?B?QzVndk9Va1FnZjg3VGRCazloUGhyZjlWbFdtbUhjcVpQamtrMmdhckM3cjMv?=
 =?utf-8?B?QWNIWkN6RzFGOU0zS09XMTk2Y3l4cjlleC9YT05mZ0ovdStFRDBsUU9MNDVp?=
 =?utf-8?B?WGs2TUJGZENvYmRSeXFvcER2STB5NVBGRG1odzBVbkt0eXBITmVTeHorL1lG?=
 =?utf-8?B?cE1nQkoxS3VBSVdFVDVDTy9yUCsxalBsVGNiZjZZaU1FaEdBWHd4akYyakxx?=
 =?utf-8?B?dC9La2k4OUFialJKM1FmSU9vSlJJeFFPRmZ6NGlOWjdUR2QvVG1uUWNaMlI0?=
 =?utf-8?B?TXpDOFM3SjZQRko5Z1VtS0dVWVU1UlFzYTd3MWQwdEJTTWd2cEJVeld2UmdP?=
 =?utf-8?B?QUwrOVUwamZuMmw3b3ZyMmhaN3pXTzVZWUZPK0RUeWUyNG9DajRYQUE3Nldk?=
 =?utf-8?B?MGhWRGNGTTdnQlNOVDFGeGhid3dDdDVvM1ZVT2EvWnQzTkZwWWtYK1JOODZj?=
 =?utf-8?B?ZGU0UDREckhNK0RLN2U3cHhPTTQwRXdrbzdhVXAwTEZzNnpEVFdrNnU1TWpN?=
 =?utf-8?B?M0J3RGxVOC9wcW9pU0JaV0Z1b2xpOTFMSm1lRFQrdnB5dklJbmFDVXpka3hZ?=
 =?utf-8?B?cE1wOUoyN0JzZ0lNZ2R2bHhtc0hvK0VRdFpQNlAxUFpNWkNvQUJteXdia25G?=
 =?utf-8?B?aUdrL2QyNFlGTU9CZzJHNHMzL0paRlNYQllCanA1akVyTlhOOFZDNFJMSDZU?=
 =?utf-8?B?Si9IV1FXT3J4ZEVwSlExdVFaVm5pOWlVTlpYSTBkQVh6ZTVBTHZ5MkFFakh1?=
 =?utf-8?B?elpUTHZQUmhoUEtiMGV3Nk0yMEtHYnVicHlxKzBoOHVyQlJINDlHTGpkTHEw?=
 =?utf-8?B?WGRjSktUbUkrSUFJblZaUlcxUUVyZlNuQjBwYjhrNHYxS3JZR2VnM25pLzlT?=
 =?utf-8?B?cU50cVo5WHNrRHFzUGdSU3pkN3dwT1RoMWgrQzBYQ1pqZlN4TEw4NGxiMWRJ?=
 =?utf-8?B?QTFwQzFsdjJvbjY1eXlSMUVVMzc5SnBadStPL0R6SjFqRy92VlhsSXhpTi9B?=
 =?utf-8?B?WkVYMkJyZEthK3ljRExkNmVDazM5aXpkWGlJN1IvUGF6dFJ2SHRCT0dGaGV5?=
 =?utf-8?B?cEh5bVJ2TkY0VWpQUTBscDFYV1hRZzd2REkzMmlyWnhpdDhBQ3FINElRZWZs?=
 =?utf-8?B?QjAwWXRGRXFWdEtpOERpa2Y3Qm5zenFzSVNvNjdSNG44QjBxUzRrZG1JZ3NF?=
 =?utf-8?B?ZCtWWEVISFRIMmkzZjlHVVZqWWw0ZDF0cTd4eDhwK0p0RytFNDdzd2NVa2lj?=
 =?utf-8?B?Z29DRjBNS0RNUGxKelVzL01TbXlVUmxXMVFyOGcrKzc4bnYyVjVpZXhNWXBZ?=
 =?utf-8?B?SWhRT2t3WjJOVXRQejlXL3lWcjVYS2U0aUE4VGhJTVlUQ2ltbFVtMlN6L0Iv?=
 =?utf-8?B?K2hPY1BVWDdWUEFLUEdwbWdDbUg1Unp6R05MaTV3UXZCRlJIL3lHM0VIckE3?=
 =?utf-8?B?TWtrZDZ5VUVzRXpCelhkWXpyRUJiOExlMVZpZlpHZGJmc05Ibm1CU3BHNStK?=
 =?utf-8?B?YUNiVWZrNWdKUnBCMGN6WWlFWEVISFBicnZRZit3M1NqQlJMeVBnZ09RTEJQ?=
 =?utf-8?B?QnhJNStMVmV4T0JMenJmeUxpMFQ1cFF4ejk0a2pyak5oY1NzRnpQMWliQ3BH?=
 =?utf-8?Q?vraw+C?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(35042699022)(36860700013)(14060799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 17:05:24.1099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ce8dd3-f43c-4a89-901b-08ddd5d49987
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7632


On 07/08/25 9:46 pm, Lorenzo Stoakes wrote:
> On Thu, Aug 07, 2025 at 05:10:17PM +0100, Lorenzo Stoakes wrote:
>> On Thu, Aug 07, 2025 at 09:36:38PM +0530, Dev Jain wrote:
>>
>>>>>> commit:
>>>>>>     94dab12d86 ("mm: call pointers to ptes as ptep")
>>>>>>     f822a9a81a ("mm: optimize mremap() by PTE batching")
>>>>>>
>>>>>> 94dab12d86cf77ff f822a9a81a31311d67f260aea96
>>>>>> ---------------- ---------------------------
>>>>>>            %stddev     %change         %stddev
>>>>>>                \          |                \
>>>>>>        13777 ± 37%     +45.0%      19979 ± 27%
>>>>>> numa-vmstat.node1.nr_slab_reclaimable
>>>>>>       367205            +2.3%     375703 vmstat.system.in
>>>>>>        55106 ± 37%     +45.1%      79971 ± 27%
>>>>>> numa-meminfo.node1.KReclaimable
>>>>>>        55106 ± 37%     +45.1%      79971 ± 27%
>>>>>> numa-meminfo.node1.SReclaimable
>>>>>>       559381           -37.3%     350757
>>>>>> stress-ng.bigheap.realloc_calls_per_sec
>>>>>>        11468            +1.2%      11603 stress-ng.time.system_time
>>>>>>       296.25            +4.5%     309.70 stress-ng.time.user_time
>>>>>>         0.81 ±187%    -100.0%       0.00 perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>         9.36 ±165%    -100.0%       0.00 perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>         0.81 ±187%    -100.0%       0.00 perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>>>>>>         9.36 ±165%    -100.0%       0.00 perf-sched.wait_time.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
>> Hm is lack of zap some kind of clue here?
>>
>>>>>>         5.50 ± 17%    +390.9%      27.00 ± 56% perf-c2c.DRAM.local
>>>>>>       388.50 ± 10%    +114.7%     834.17 ± 33% perf-c2c.DRAM.remote
>>>>>>         1214 ± 13%    +107.3%       2517 ± 31% perf-c2c.HITM.local
>>>>>>       135.00 ± 19%    +130.9%     311.67 ± 32% perf-c2c.HITM.remote
>>>>>>         1349 ± 13%    +109.6%       2829 ± 31% perf-c2c.HITM.total
>>>>> Yeah this also looks pretty consistent too...
>>>> It almost looks like some kind of NUMA effects?
>>>>
>>>> I would have expected that it's the overhead of the vm_normal_folio(),
>>>> but not sure how that corresponds to the SLAB + local vs. remote stats.
>>>> Maybe they are just noise?
>>> Is there any way of making the robot test again? As you said, the only
>>> suspect is vm_normal_folio(), nothing seems to pop up...
>>>
>> Not sure there's much point in that, these tests are run repeatedly and
>> statistical analysis taken from them so what would another run accomplish unless
>> there's something very consistently wrong with the box that happens only to
>> trigger at your commit?
>>
>> Cheers, Lorenzo
> Let me play around on my test box roughly and see if I can repro

So I tested with
./stress-ng --timeout 1 --times --verify --metrics --no-rand-seed --oom-avoid --bigheap 20
extracted the number out of the line containing the output "realloc calls per sec", did an
avg and standard deviation over 20 runs. Before the patch:

Average realloc calls/sec: 196907.380000
Standard deviation        : 12685.721021

After the patch:

Average realloc calls/sec: 187894.300500
Standard deviation        : 12494.153533

which is 5% approx.


