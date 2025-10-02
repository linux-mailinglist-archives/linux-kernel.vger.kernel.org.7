Return-Path: <linux-kernel+bounces-839688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C7BB2286
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D88516A95F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64441C63;
	Thu,  2 Oct 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A0eWSotc"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94005227
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759365541; cv=fail; b=sHTrs3zHkuMXN20rSeffzKGEi9MMvCCKwK+EtepT83dZVqj3Nt6TciDMh+C84K85++yzMltUakHX2WNiUqt5sqxE994oW6vpgHWpiY56lrDKM5LG1bfniiyEWfQV5ds5b/+5et6B6zGbaT8883XCngyAz8yvGMomN78ussC/r3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759365541; c=relaxed/simple;
	bh=SeQzmgbB9A42m5QpJxYoIPFS+SxGiKUwkwn9Wl8O0oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FQOsq/BYVarxa2UFVc4U+oCp6egxnkaGoz4H2E7RXxY0+zSzl0lEJBCdaPHuuaxw97WkYcBYvtIVLY7/3iGhz19xo1FuaKWga/meK84mlJqDxraZxG8isBfxh3+fNzuyOOVlI071y84Xos8cQp9c8LpNJ/nS4AqXdEHq9mtqFfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A0eWSotc; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl7cLh/oUBixpIrGxBikx01MNHlgBjx4U3miDUReR2VRPCR2e5xjkjUuABPCw5YbHtZ6iAWVkVZwPyYXffq3nMPoP+WafGJxpL9pnCxJSWcqU9DwNcfgzQxYRuJOvyYTFGQ2etGrY7OxkBnUmoDjs39rE4tWebcepgHqC0G1iI/siHOeoMv8oOV8pcHsA7e080tqRMup3ZtIu+zgqrAnSUDnGZAq48g00TorrssJBMH4RQnWd7dqS4M6Yc0/9sdFCPOx3a+x87lwC3MsNsMkGkRARlW5mDXWLg0n/uWXZPk96KCDIKnbYsi/IwUcWfIPOxc3AaMfYI2c/CutspXtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGSVUna2rSMem3R3CazjTmA5+U56QfPD6STKNwCngS8=;
 b=rvCSoDGokmucsdYJy0THg2V5nxMnbJdjaFK3xan7J2hvukbb/AvEEcosTvVWLtSA5M1izXuTcHQepapJfEG63gcJADmlcFl84uNmNaDAD0Waxe6jqJgRTIWENuxRoUzrdkkxXEKBIfRkIOXFQrQXisOMRm8ZxqWJSOGwroZ3mQJCm9Uz1PiZ8yVwS3vvA4zKTEw5kAG6CBHhx6Sxi2q2zIigXtLd+VuCS60iekPiJupdT3tB/SZW4uNk82Auw6BQsw29f3pNo1O4hxj7ySawVbC5iDTjrweF0Q+1kpKG08A78St5XMNs2fzG9JOcc7tZEwBDv5oyqMZJ7qSoqYH0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGSVUna2rSMem3R3CazjTmA5+U56QfPD6STKNwCngS8=;
 b=A0eWSotcucYSQdtFV8BvdxwDBuCDSjmCnR3mnquEtHSB+m9coJpg1rYjhiiIecQNP9QDNrYaD+EgcpC83HUhTKsK7F0dcClmprFrHRy01zvmQFjRYU60gPVzdYGURX9867KFds7oYf9Y+ZFnyHnGRXB7AH21amVhDeMnCXoPV7aJsVpoygtyHcpjLbuStrfvAGrYBHQxzKWzV/GmddmRRMnqY5kbGGURpDSVF42/zLkSGHmR9WXJ5DBgb98b5fsXbQ6p22j9Jnywv5QK+StsLDSvalGfIbvR9r3fbFqjrNK2Xqen39AJcduw1xguUu6w2lqrgOJAJClg9nvwo+BMKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 00:38:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 00:38:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: jane.chu@oracle.com
Cc: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, david@redhat.com, kernel@pankajraghav.com,
 linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mcgrof@kernel.org, nao.horiguchi@gmail.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
Date: Wed, 01 Oct 2025 20:38:49 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <637BC0B5-B911-4A79-8107-BD7CDB351660@nvidia.com>
In-Reply-To: <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
 <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3933833e-b6d1-4113-c172-08de014c10c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hpoceiO49Kytaqyqr0dwBYH1mAe3KLGYH1GIoUP1nxcBqM/3wMOLAVCHdoJc?=
 =?us-ascii?Q?Z4oGscbDK0ukcR+BFbO1nxIuniaXNy5Y0oINMEOOZ5o2rmeQ+/9sYh7diaVV?=
 =?us-ascii?Q?ifz1TnqwXc2af4w068FT4lPviZjoTW7Zn5n63KRUvAS5M/eZJuJg2VK9JyhR?=
 =?us-ascii?Q?7nhUsGV+PGE6bL/Z5Yc+2HYCfxJId/pkf5TszF0fod3VaTX6O0SyUOAgtSaI?=
 =?us-ascii?Q?+CUGx70Wd8IRqnsbMd7Uo2vSNWtOUcVnJntspOND0rY5Jiud9OZabtRvJd4v?=
 =?us-ascii?Q?FzfHpBUdmL1TL5u9VxdaI1rXtS/wCBlAwYTu9OZlPHvComWb704MrMrXg5k4?=
 =?us-ascii?Q?JhrcdrU9ClPPp2I392krWITN/uXlrtUPwhwSGgPJqpef3+sqhYoVK6i0CBPY?=
 =?us-ascii?Q?FwdKovsZRDM67wb16MgiUEJNVZPCJ1Fh5y7j++tdi2x7jSLtxZNM3goCI6oP?=
 =?us-ascii?Q?FahrKu6wuiKNsOVtni0F5okBd2J/9bPHTVS6DcUGBzo749WNzC1Vje0N/TUe?=
 =?us-ascii?Q?TlKkiXYpfXMqkQ2cFX9ccHa+Tq1gJRRaJU6nycN8hPmwgnB9V2cNRu/ZJGqf?=
 =?us-ascii?Q?wQj7Bmi8twbEfQEzgBeYgsJsgrv1lQaGUlmVMY0gYdb1k3b5e/jWaIB5HY0Y?=
 =?us-ascii?Q?3V1chmyzon0PfzapdNi1gi+BHpKtDaIwe1Gf7JEwvY6r+dDqOcTbspiXK4WP?=
 =?us-ascii?Q?Iwv+kcqoHyjhPQMJ7m+k7DHfgVvidZd4yTfhYFWVwbYylWp8HFJCFFe4sh5C?=
 =?us-ascii?Q?ZKte5p2g1XOeuRrHexR4o5PgPmKTbS0R2bKwNB3UKSGSSyAdCddZ5iZ2TP3O?=
 =?us-ascii?Q?lUJyDz3kSKQba/FZvhN/6Z3CNzRoIDxRi/fUh7sZBJQTmjh6FzkzHfcC7pha?=
 =?us-ascii?Q?ZjnahinLnqT69XWiB2VtNQGsqG+zSVreaAP7Zd9iJRPQD+MYgACQTY5j0Qwq?=
 =?us-ascii?Q?yzJ9pkaqkT9NW6D2BUoP8QMGD+1fOnsyqPbl+tz2tsLLYbxn3Ts9CW8KKPP6?=
 =?us-ascii?Q?mRR3vCRlFQrITBHrDq5+cxFgSLKhWCi7elmVFf5MsbKbJz/8J2O3ew1Piyvr?=
 =?us-ascii?Q?n2Ad7VtFBpFt1zXnndwI8wC7zp/DXAweKoCRUaBtaBBSP0oiaNczkPHngKD4?=
 =?us-ascii?Q?xGAM20juqhTFYbpntoPiKV6En4JpX4Ucc96QOI6ElDn9qR5EDYy9O1SSKpeL?=
 =?us-ascii?Q?9bnH6+C0aZ45gy9of2JVMK0gFFSRaEuiHRYWCeUQ5VO+iQhYs3natrdELizT?=
 =?us-ascii?Q?9DHVxEVYobqgixIqD0bOB9LXjU1+kDyyLJse5ZN2nlAvZAMyJCckjuNTMS4R?=
 =?us-ascii?Q?Qjq3aWhzSQ6+1dVySxgNcWBu2sADEdnaw0FYBxnCZuYfvLRX+a8sOsCOMgwK?=
 =?us-ascii?Q?aCP40nRDpvUSGfdMv2iBRWpkbC8M/0WfIfW+amGHMzrNCc1huw3jTSN2DaG1?=
 =?us-ascii?Q?8wfMwApydmW2FFxRgQjZ7KYr7Aqp8zDnHk+UKE9L+l8agh+os+/u4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNJxyDTYukPpnkHN8HAAea+2bboZ8mM53fvHsRFsk81zdlMHSbMc8dK9Q5Di?=
 =?us-ascii?Q?q2dezP5gRpko1N0NvsfkzM66piNYUtUlhUPQRbT0VNMCzDGYzsInYNsAHSH9?=
 =?us-ascii?Q?kEV1NCxfve8d3+iSqrRQeL8+THmezXYSlJh5GDraFxzAvd5ZnbomVhlliA11?=
 =?us-ascii?Q?wkczbwwaLL13EBFpEMlPWPwteoQyNTTba4SPsyzwiPEjiXumMrb1rcUbR49M?=
 =?us-ascii?Q?GLULNbaA1paMvA9feeKt2zvpuf2/Tl4ya5ri9hK0hwOPMTcV2EM+l9B51YoC?=
 =?us-ascii?Q?SVhSAjZHJUrbnWyQkGc27zmPcL0XOXsAGlbB35VM8rhKEnU/Emt06Bd6QPgn?=
 =?us-ascii?Q?XrC7MohdwIxfzR2U/vexuDVFwiGPEZ2T2CGLIihQBTh7KxvtcWEy5y4mhUia?=
 =?us-ascii?Q?Iw6Ub2cJ3wjnb+3E0uJFxC2sQ8fgcmW6oq7M6BO7NFNepWZSo60pfa/oHBTK?=
 =?us-ascii?Q?FE/mmK+0oM1cmV0VGLDe8zVaKSk2Uw81/7lCnj3mAoJUftjW1ZPgC8sdo+eL?=
 =?us-ascii?Q?Ffu9tqWQYguLP2ERkZGPAnALydXlsvj/D0Hx7VmImx8z76+AbXw1oKKVOPxK?=
 =?us-ascii?Q?yBs8HSkvond8wz0wEvapKOwEnHTp8G55BZwDeLzRcjyY89LeVkx0Q5Er0HMD?=
 =?us-ascii?Q?TrPs9s5E/+/mfrJI4H070y4QlcTHwe2LkAcOtlN+nvsUvX7hL7JcdJNVJT0M?=
 =?us-ascii?Q?gGvberEMDuA61qe0FusWLKKe26eEN0ETZgu7XztK9zhsHYx7D/MnguXzOUfk?=
 =?us-ascii?Q?SOtiSSZ15uUEFWe5SaxfqP6edbCHTSVPfT9+Mq6rx3W/sC7k+VBUuy/BYsDd?=
 =?us-ascii?Q?qrOYj5t6k4oZQ6nu8UyZ4OvgIMgYCNQ8w1kkdJ0iwfA1j3j1T639DeQIHrWW?=
 =?us-ascii?Q?mr4T6C5DLEDWae71J83nylPywcJx+h5MLenUvcPVjVpWAG/1iM7tPYHsXXM/?=
 =?us-ascii?Q?tCTKnmtY1Y79aLUDwSoyDo+y8CpbeHzLsAPZGteELhhV/J7E+/dUfx1z/Qbo?=
 =?us-ascii?Q?eX8pSxri5LDDwgprcIorezsRasVGzkP+7008iI9HMNql9HcXyDGHG5Ch8rwC?=
 =?us-ascii?Q?CJSL6tCSFOn8d7Ydd1NiZYintnI1BJnml1rzZbpGNq5qCDGT/Uhdq7xBvD2R?=
 =?us-ascii?Q?qPbDoRyjjo/UjT/eWz5WI7S4zTOSIEbf/8CdECW/1b5TVl/hrn6yP9xS/Zhk?=
 =?us-ascii?Q?QjxgqyCpyhVRASXZbOsrxbDIlNev35DZZ1kNnJ94qU/ppha8PbJMUve21LwP?=
 =?us-ascii?Q?C4+Gk0+tCGHrGQ8Umpm/xOaUcEJ1eX4yDsONPte3S9k96pLjVOFfguKfYNBP?=
 =?us-ascii?Q?EHy1EBnHK7E1shVngtV7PVWU1NE/ruaC2fS55b2D/fkmuUkFirml0X18/9K6?=
 =?us-ascii?Q?RtKhmp8W5nl9PCuDsoIa0G8HexwuoSEIYJSX2GHV3b1hSEfHm9cjMu1EyPgP?=
 =?us-ascii?Q?Mrp8Prk2RWmURVCpoF/KWuAPvPtKmzVDxozhCDQOgGzmJVj1mdbUWR16Z272?=
 =?us-ascii?Q?I8G1QianZq9eFThbOFqnoyeSWngdUYZXS+N52L3WSjk5yDJecqjpA3BlaPIJ?=
 =?us-ascii?Q?E5T7fy7fLU3/1lJicYE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3933833e-b6d1-4113-c172-08de014c10c5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 00:38:54.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9YiDxL139RSWFIZSkTjC2pCzZpo86PPUvLL3UAytmVg5bYkV9HyLwyo/PVOs6ci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203

On 1 Oct 2025, at 19:58, jane.chu@oracle.com wrote:

> Hi, Zi Yan,
>
> On 9/30/2025 9:51 PM, syzbot wrote:
>> Hello,
>>
>> syzbot has tested the proposed patch but the reproducer is still trigg=
ering an issue:
>> lost connection to test machine
>>
>>
>>
>> Tested on:
>>
>> commit:         d8795075 mm/huge_memory: do not change split_huge_page=
=2E.
>> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_=
min_order-for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17ce96e258=
0000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D714d45b613=
5c308e
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3De6367ea2fdab=
6ed46056
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b=
7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> userspace arch: arm64
>>
>> Note: no patches were applied.
>>
>

Thank you for looking into this.

> My hunch is that
>   https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-k=
ernelci
> alone is not enough.  Perhaps on ARM64, the page cache pages of /dev/nu=
llb0 in
Yes, it only has the first patch, which fails a split if it cannot be
split to the intended order (order-0 in this case).


> the test case are probably with min_order > 0, therefore THP split fail=
s, as the console message show:
> [  200.378989][T18221] Memory failure: 0x124d30: recovery action for un=
split thp: Failed
>
> With lots of poisoned THP pages stuck in the page cache, OOM could trig=
ger too soon.

That is my understanding too. Thanks for the confirmation.

>
> I think it's worth to try add the additional changes I suggested earlie=
r -
> https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@oracl=
e.com/
>
> So that in the madvise HWPOISON cases, large huge pages are splitted to=
 smaller huge pages, and most of them remain usable in the page cache.

Yep, I am going to incorporate your suggestion as the second patch and ma=
ke
syzbot check it again.

Best Regards,
Yan, Zi

