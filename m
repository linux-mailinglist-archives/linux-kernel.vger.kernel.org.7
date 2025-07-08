Return-Path: <linux-kernel+bounces-721657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367A4AFCC13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068C21BC1FC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D72DEA99;
	Tue,  8 Jul 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cJBbvLDo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA562E03F1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981235; cv=fail; b=KcnrKm/MivNW/Rj0y4JuP0yd9DzwA6gfhuYK9g9jxOro4An6q94fKUhcqBSUbMwnjVwqzHPFfhPHwHSOYhY6LmF71eESXWuQwL1zDjrAaEZjN/oNQeG6E8Z5nIJ/kc3xzGdaPHUDKqz5bti3noA709sWdtQb4h8vSsVPWjQWm2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981235; c=relaxed/simple;
	bh=NOr/2UaIc2fkdnjUo5nFwq86MY9+8z4arDmTIa3CGl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELv0NU8TJJpKCTt7kSwru8Yql3dI0DMSe3njj5k5i5ryLYC6idUaj8+2AT+8INdDSl+59Ku4D7ZtTiR+M0WN2sJmvvrRXJrN7KBhYRcw3Cf6s6Wgab2igiVdbQqRvkY3TcctiOaq6t8tEFJu21kev1xG+Q6n7TX863DKo2IN6fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cJBbvLDo; arc=fail smtp.client-ip=40.107.94.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaLEnotEa1Bh3i8xfR8blcEgSesIKzTiJzv09mVAG6X/VXODPA0SyH6YtdZTJemaqgagAKld/e5pTZobfIUoHCFifBK9bx3BtKPYDeO/Kj85RBMwclQhTsRbxDFqDMal1QDgehpJI5lQWHQXNm0LNW9EsMn1Et6aIPvXS7a02nespm1Mlsq1rCQTSs4JvtpmpDJE2/LfiohXBh+6frxH9tllXa9KjxbtCvqEONdhnG9ot8wxTSjBR6U8fp+s+JelPziGi28iuWOcyQ2yXnsmnWX8B6weYjiNvZQM2wK92TDl2fPDIrB88j/t2ZLgnDN0a35Z04q2jZFE/SUhMV2mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrI5AeszdbgxNm+NKbksdRfQEI8sW1z20jeROeXiLHM=;
 b=aUbvv8jL10WlGSXU8dwyQ49EDUagS3a2C66o9nPN7EtxACcmgg8j7ByStu9clkTthc1jz43g+aGCHFpm38tvWP/Azyn6Q+6ySHp79SgbVpKUqBP1lnNEgkCPDbYiLvoUdnVwqbZy2c3oeP1tKCMlDxdrdaCWeF08c8GC46taJyoy7HW7BNpkyeiUt3dDc19U8OTUrhOX82CSsMbyFYZF+F+/9lHe05+JBVz4rezgZVxPYXnOuPWyLDhXBETZ7pLmxZQz4ZoYcwh3xhRgCykeaII+nSVsmhNPWqhCkeTMDHQlZ8ESP6fMeGO4SxiYMk52ui5+OEoErbvyEHa7JCl73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrI5AeszdbgxNm+NKbksdRfQEI8sW1z20jeROeXiLHM=;
 b=cJBbvLDotQGsu3wZQ6sVkRCvIwBSFDMi+9BsWa/+rVu0lpKFjcs9Ia+/QD71mDCpMd9ts2HTCJg14NFLd/LyTligXte5HYDBejh8EfmUn6nqzvKP/OMA/X3zN6ze8fQYhrkkGmmc68fZ+p93JFIvdx8AvdPAdY1KEQJR2yMjZGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8322.prod.exchangelabs.com (2603:10b6:a03:536::6) by
 LV5PR01MB9442.prod.exchangelabs.com (2603:10b6:408:2fa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Tue, 8 Jul 2025 13:27:09 +0000
Received: from SJ2PR01MB8322.prod.exchangelabs.com
 ([fe80::83fc:f69d:1950:9f42]) by SJ2PR01MB8322.prod.exchangelabs.com
 ([fe80::83fc:f69d:1950:9f42%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:27:08 +0000
Message-ID: <2388de76-4827-46e3-a39f-4a19ddef9617@os.amperecomputing.com>
Date: Tue, 8 Jul 2025 21:27:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix imbalance issue when balancing fork
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, cl@linux.com,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20250701024549.40166-1-adamli@os.amperecomputing.com>
 <20250704091758.GG2001818@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <20250704091758.GG2001818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To SJ2PR01MB8322.prod.exchangelabs.com
 (2603:10b6:a03:536::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8322:EE_|LV5PR01MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: e29e1f73-75e7-4201-b88d-08ddbe232341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1BR2MraWVNVlJQR1FObEYxMkdqYjUrWUcrdnVtVnNlcjJkMUphNC9JK2Ew?=
 =?utf-8?B?bUdwQ0dreHFyU1lWUU11aEZaZlh2NnYwUXhaU1g2cCt4ZGxhQzhHNnJiOTdm?=
 =?utf-8?B?a1ZVckE4aC9WYkNOZ0tuQVY1bnd5NFE3UTVoS1o1bmJIOExhdVF2cExVeTgr?=
 =?utf-8?B?SXZ1bU12by9Jb1NWa0wwbDFGVVVpQ2Q2NHlGQlhIRzloQk9oL3Y5TTlDMW4w?=
 =?utf-8?B?U05PbG9kTWg4VjU2WW93bDdKLzRGREcvYWVpMyt5K0RnZGo0bUNidzUyTWt3?=
 =?utf-8?B?RllSMksrY1BGdTV4UjhxbnUyOTV2M3FHKzJRbURIbk1WTkEvUCtZOTA2WFp0?=
 =?utf-8?B?WHhiblc2MVJab0d4QXg1ejNyVFB5S0dJMG9IV3ZxVjFXQXV4NThiWTRJTnVm?=
 =?utf-8?B?elllMSt3WHRIQjFoMFVKUFdpUnVVT1BkK1FsN3JxQmVOTEk0Sm1rUGczQUN3?=
 =?utf-8?B?Yi96WFQ5a0NoUjNsK0UxczMwVWJJVjRMRHZLbzF5RHdLUkd3NWdwSUdWUjhG?=
 =?utf-8?B?NUw3VmZvWnBrbm9PaUNDdHVNNi9SeHhXc3NOV041cEhZTDdNSjhSblA4SVVU?=
 =?utf-8?B?blJTL1IzYU93SDYzZEdMdS9pUG5DZTNIOXNuQWwxb1hYNjI0YXFHdmhBTGVq?=
 =?utf-8?B?MWI2NlZtaEJiQ1UwcGowRUxlZ2lRNVI1RXhYQW45OEQwR2VmeU1tSnc3Wnlk?=
 =?utf-8?B?QXAwT2d6QTNtVHNnTmJkY3JIRmFSTzlhc2IrY216WkNwN1RSRDlOamtaVzdJ?=
 =?utf-8?B?dDBSd1psaGpXK1RmblRGRWdTT0VPWlkzNklobVk1TzhOM3lnbk1ySWR1bkdO?=
 =?utf-8?B?UW1EZm56K1R6VFplZnhLb0w1K2J4TExCajdnb09DRmhxNFBKc1JodWF4TkIv?=
 =?utf-8?B?YlpTT3VwVEkzSzliOWtHOTl3MG1taFlyOVVSbGlWUzZoSnBEWW9aYnlCaHVk?=
 =?utf-8?B?S1hNWWd6cG0rWFJ4K042Ni9HZDhveDdJcGZsWktZbGg2R1l6MlZwZHVrM0d2?=
 =?utf-8?B?VUhMTXJnQlFFUzBqajFvRm8wWkcyQStlT0k5bUZpS3BuM2d6T2gwNmxQRzEw?=
 =?utf-8?B?MGw2Y2RqbWJoc3Q4L2FuZERVOGh2YWt5UUZmbVlqNzhZN2lQdUVKT3JhbzBp?=
 =?utf-8?B?LzVoZkVyd1FGamR1UnJmQjFhSEVzdVJHaC9aeGlwMk9yQlRmSllqdlBqZlBx?=
 =?utf-8?B?aVo3aWJscHl0VDR1cW1CeWRyRlNVQUEzNlBueU9iTVJJYjh2ZXhhOVoxbWgv?=
 =?utf-8?B?R0NGcUtaeXJLOGozdXRQbHluUTJ6RWpCVWNHcEg0UUhjVmtkYzBueWNWRndi?=
 =?utf-8?B?RFdzb3VQY2pqTWpGZkQrdGpqdmE3QWhkbGJ0MEdYZFpuOEQvZUdXUDNPRXJL?=
 =?utf-8?B?N0dIeWQ0WWxtc21oRTF6anJJenppR2FpUGozOG9VRmJLRkFpck8veWZFVXF5?=
 =?utf-8?B?aWgxQzNhdE9PWStEV2Jwa243SkpEKzVSR0RPZ3dFYmozeER5a0hXQzY5WlNE?=
 =?utf-8?B?ajdhWmdiUmZidHF3YXQ2cjIra1pJYTNlUnI1TXhZTkVQbWFZNS9RdWtXUFFu?=
 =?utf-8?B?aWFoNDg3RDY2dUwwK0lZOVIrTGZXUGxpejVxMWh3NWhIZGljTzNKSmc5T29z?=
 =?utf-8?B?ZngrZVJvTFF2NTJydHFTT0N6OTh5QUVvZVFiRnpiYTQ2QklUZnZ1eWlYa0V4?=
 =?utf-8?B?Y1pyN2NCdGlQNjYzTkdxcW9hWEFyTmRhSExMQXI3OCtyZjdLY1RweUdnSGlR?=
 =?utf-8?B?RVFtbWJ4eDVhdWRNdkptN2QyQU9uUDh5ZjlZTkpLc0tPUm9UWDZxZ25aNU5F?=
 =?utf-8?B?eUhEeERPRkpDUTlwL2YxV281b3FsbWtxQ2ZuWUhGdExJdkorU3JXa3kySlEv?=
 =?utf-8?B?aVpFOWNvQjhDYUlCTzVzQllLN0VXTWRTT25OY0YrcHNhZ1MzMC9Mc2dBV2Fv?=
 =?utf-8?Q?ptTs4m0e4QE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8322.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHUvUjN0Mzh2WVVTdlFCMDU1ekZkQ0lIclFnck9EZUNmWWJuOExPOG9rR01w?=
 =?utf-8?B?R2orSVp3aVJkaHpPZFVrbVJHSnBEbGNjTFMzeVMyZ2dOQ1NHdTZEWkRLaVAx?=
 =?utf-8?B?aXFnSVVXMGpoalVaT1diS3E3bE5oNDdOOGEvT05ob3lmUVNjMXRqSlJYQU1Q?=
 =?utf-8?B?MTJ1dXlqSzhBbGRmWTl0Wkx2dTFYZjdodTA0MFpIbm83cXRwN0FmdzhxbEF5?=
 =?utf-8?B?NDlMWUZZUitld3VRdHNQSVF1SE5GQ0ViOGkrcFBLMTd0bndDY2NoS21Fc0JO?=
 =?utf-8?B?YmNndklObjBzVjc4cmFaalpxdkI3OVJDbHJKaWpCS3dUWUM1TVZaamZKQ2xn?=
 =?utf-8?B?bW1vZFVtNmtWYWUrdWhkTGJkUzhUU1RHb0lray8wOHp1Tk1PTmp4WUNNNlpa?=
 =?utf-8?B?cXRYT2ZGVkx2RjNXUi9mcDlhMnNSZXFvbjlHcXhYZnlLb0FZTm5pZm9va09R?=
 =?utf-8?B?c3NncTZTT1lSOU1CcVA5Q0VjOURTVFNlTSt1ZVowSDRMVlJ5RG56bjh1UXAw?=
 =?utf-8?B?ZTd0eStidFNvM1ZqZVZhZDdtVXdkYzcxRWxORjUyTXM3Z0I3QlZGYncvaHor?=
 =?utf-8?B?UERUZFZiZ2xYK1hBN1BnRWxiMFU5QXNncmxyK1A2Ulp3K1I3M3E1UkF6Rmls?=
 =?utf-8?B?WUM2eXBBM1B4ekk2eXdOc1lqa094NWJtSGg4YktpNGw3YnFuRkNTOVZDN2Yr?=
 =?utf-8?B?S1A0T1hXc2RMNC9NT0Zpd2FsSERNcDlyOHJCRjRiRVdhMDFaRUlGSXdxWmRm?=
 =?utf-8?B?SWxnSDNXcllFZWxsTkxjdG1mK1FFUmhiejZnam9VbXJEVW03U2tsczI4ZVlO?=
 =?utf-8?B?NUk5WU4ydktXa2NKWXJUSXRZd1A0VXBNWnlGNitOd1Z0UUgySWk4RmVUVXdQ?=
 =?utf-8?B?SURiZVdRcGtGVVJiZ05XTmZFWUEzOUovRHpBQ21QUnY5L3BjQ0NyaFpDVHhE?=
 =?utf-8?B?NmVxNGduMXBLWTRiZ3JYWUxXYjFkSk9aYnZzWXZuWDVaY0VGY0xPc0Yra3V1?=
 =?utf-8?B?bHExTGdTd25MMHdzOFZBeHNJYmttckN2S2tkZU5mYTlkblY0bzdRaUZRUHlz?=
 =?utf-8?B?WEJOQklRVzJGeGFKOWdPc1d1bDc2bnVFUnFsRC9zM1paa0hyL2xwK2NRK1Yw?=
 =?utf-8?B?TTVvcEhWWm9idm5adEMxYmRnMk52UWdpa2JvNWxMOG4rMTZmdkdmd0dBaHNm?=
 =?utf-8?B?MFh0V2g2bWk0MTZJbUpGK0RiODMxQWE4cWhCTG00M3dsWUw2M2NKMWp3cUto?=
 =?utf-8?B?a2dtNlpSTkQ5LzRlR3U4czJuZHlNenV2cklrazZVUnJvbjdWNFNCVTBMNFNL?=
 =?utf-8?B?MVVBcnYzdTNoWTFOd2dhbnBpai9vdmNENjFybTJiSDhKblZvdXQwMFBwL2cz?=
 =?utf-8?B?OTBQeGRkL0tQUS9yVFordUYzSk5QZ0JmTjlIQkt5TmpKVlkxVk9xTmxTR3d2?=
 =?utf-8?B?ZDFQNWVzaFdGa1VsOTB4WnRNTkFENnUvSGt1OGNuQ1hkV2tOUGR2RU5oSlQ3?=
 =?utf-8?B?UEQ5blZ3aTZ4MzZOVDBSZWltWW5MYk80YUt0SEx2aTlCVCtWVTlwWWJsN2Ju?=
 =?utf-8?B?aUNhc2JCeHg4QmJEWEoyMU1CZ0ZaMGhIQ2t0MC8zcGkrYVlpczVVTGwxWHk0?=
 =?utf-8?B?T2w2TzBtd2lqTWFYa3lPTDZsSWUwWWFxTytGd0x2NUxDdTR0T3FEYzdHWVdm?=
 =?utf-8?B?bzYvV0dKUi9xMTlZM2pYVmhUZGtqanBzS0tOK3hPK0RIekJUVktQMHVOQjA3?=
 =?utf-8?B?ZVI3aStPMEJIaWpjekQzL3g2TFk0Z0tjRk9OV2ZqaUJBZEdKTVBheGVJeE1I?=
 =?utf-8?B?QzYyUDR1TTBIR2hBb0E3NytmZTh3OWpOclFUTlJaTFpFUFlxRjQ4azFkNXBy?=
 =?utf-8?B?WVBTWTVRV1ZvKzdoQ0cwYkVKVVpYZXZNQlJmQUZrNmduNzBqekZJT0JHTDI1?=
 =?utf-8?B?Y3M1Qm5hVFl2bG1mMWNQUzlyNFJ2bnJwZnB0Q3ltOTlZUmkyRkFXaVRBeXdi?=
 =?utf-8?B?YzBBYzhMbzZ5dTd5STA5WnUzTXZFVHNGV0NmUTFNTmswTmdPSXcrU0JSUlVw?=
 =?utf-8?B?dzJsK0s5M2JpTFJ2ZFU3b3dvSVNRb3ZhMTQ0L2pVSHhSNnZGYlk5V2NGRGRE?=
 =?utf-8?B?SGhaUTVpc2xydkJORWprOUxTTEU5Q21oQjQ5V0xkTXYvTGw0eVNQbEZhSUY4?=
 =?utf-8?Q?NMPIrtRUtFFwPiTW8d9ZfF4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29e1f73-75e7-4201-b88d-08ddbe232341
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8322.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:27:08.5151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks1IjIkfMQTfsZzwy/aH9i8YeQxBglwnydtER8fk3VY3jdi3QbLH5Gf1Or4EVM6DjJ8Y7aTo5uZcfyIoyti9j2R7ouqroD8adEda/pXhT5LxRVW83LkAM1oomJGfv3aw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR01MB9442

On 7/4/2025 5:17 PM, Peter Zijlstra wrote:
> On Tue, Jul 01, 2025 at 02:45:47AM +0000, Adam Li wrote:
>> Load imbalance is observed when the workload frequently forks new threads.
>> Due to CPU affinity, the workload can run on CPU 0-7 in the first
>> group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.
>>
>> { 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
>>   * * * * * * * *    * * *  *
>>
>> When looking for dst group for newly forked threads, in many times
>> update_sg_wakeup_stats() reports the second group has more idle CPUs
>> than the first group. The scheduler thinks the second group is less
>> busy. Then it selects least busy CPUs among CPU 8-11. So CPU 8-11 can be
>> crowded with newly forked threads, at the same time CPU 0-7 can be idle.
>>
>> The first patch 'Only update stats of allowed CPUs when looking for dst
>> group' *alone* can fix this imbalance issue.
>>
>> And I think the second patch also makes sense in this scenario. If group
>> weight includes CPUs a task cannot use, group classification can be
>> incorrect. Please comment.
>>
>> Adam Li (2):
>>   sched/fair: Only update stats of allowed CPUs when looking for dst
>>     group
>>   sched/fair: Only count group weight for allowed CPUs when looking for
>>     dst group
>>
>>  kernel/sched/fair.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>

Hi Peter,
> 
> Hurm... so the thing I noticed is that update_sg_wakeup_stats() and
> update_sg_lb_stats() are *very* similar.
> 
> Specifically, the first patch does something to wakeup_stats that
> lb_stats already does. While the second patch seems to do something that
> might also apply to lb_stats.
> 
Thanks for the idea. I am testing this.

> Is there no way we can unify this?
I will try to unify the common logic in update_sg_wakeup_stats() and
update_sg_lb_stats() into a single function. It seems not easy :).

Thanks,
-adam



