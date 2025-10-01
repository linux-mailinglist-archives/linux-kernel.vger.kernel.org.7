Return-Path: <linux-kernel+bounces-839655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F593BB217F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7082F1925889
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76629E110;
	Wed,  1 Oct 2025 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SMrWTZ7k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WRAIw67f"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B122222B4
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759363140; cv=fail; b=E6jMMgQgXxHBlZPXkmh65kuWv7B0U+OaQdpPgaIfNWqX0aFgbH8i8o+tASFZsDSH1EMfjnzEO9dDfa1raNypmIMgHSMcBsbtGO1CEWrTv3p6ZXIp52g9q8pJVyR4mwFJAqXcyL19cvb1APVODeiYLYCAWMiQhswksNDXHxVAkC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759363140; c=relaxed/simple;
	bh=U8Y4GWiKxjyJuy0O8uYU6ENHbvBrvyblO9Aa3sQO8/Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=glKP0rlIaz+Y9C3FP8BVRuqza2uMm8b3Pu2MXJx6M6gYMbRi+gO9Mdp7+eOV4gfU4vGoTdRKfL1Xsm5ZXJUQmuEim7PyIZkg8+U/j9VI+2+c4XZf9mQ0MwNfaSodaUF3+BREDxCUtC2WMT7cDKQPP0AqpmeS6bcUh7X1U0v6Sgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SMrWTZ7k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WRAIw67f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591LfxXl009140;
	Wed, 1 Oct 2025 23:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LiKv/Q8TyXyUbLknhxYsvUlx4ICICu/FV0Owoy0U4uw=; b=
	SMrWTZ7kWOlRuYgrdgQd2NQ+qqoUnOjwQXc1waVrLAXLP2bIimf4TAk69DK/jicU
	GskiALWzYMWcbV3GpCDrnsOn3Po2wVqfwLDAcJR/Xp3rdC3efFgtEtUTdbU2Sx1t
	H7f5psV8tnM6ab1tGLWJiecpt1SFOO4tx3FWjAezCgcUjfjZmuqpnJFlxbEzlFAN
	FhG8Eeb0nzrZRpStOO57IbxuH+c2R7E+YPOBhPhckWh65uyWYg1POwhIWyOeFIaD
	0Cpo70WaowYyowB40Ca3IjTra3LgpxuVpNq7XN9B/xfOQUOrNgWdK2gGq4bnYJ/S
	LH7rDemxcjj1bdkfgXGjRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmactg2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 23:58:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 591L8F6P004102;
	Wed, 1 Oct 2025 23:58:28 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c9t7np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Oct 2025 23:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Is8Cy3oDdpiqPdyw01lZaneZ84osW8SRdnznQDZbiOnPv6PEbsIKWPaM/9fEUtS64g8ksiTDT2xxZphhNT229TpHu7uJtGw7XjgrzP1XkflcCahwKh4kqbcP7U7AVkKNvHM50mx97L8C4f0UsIfeakdUvw6qUS3bThfjVCrqYsMRoxIdm/eqHD/FvneLQwGIkHdZVFlRE+eFkbgAq0jLsKJVtrdSaMasJmKXIbln2otkqHTyVOFr4Xt4ZgJkumMAkOP5gUPttZPybYB1ZD9+mGllAYibSfV3e1DCmoPMhcvGGbKezD8eB5BOtBMeS8we9MiHQuF+CpjvpNCfY+L0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiKv/Q8TyXyUbLknhxYsvUlx4ICICu/FV0Owoy0U4uw=;
 b=qbso0iZXP68pvROioWzcglrg7uLH+T50Iad2H/PnmPb+W5zXbBE2Dx61rjylQ6CMzoQvb+RMbr2GW91Iid5+Px57yDfkBOABxK3BbqKQSL82VZYIvvHhI9BSdx+PJJP1Wq3XgSGtMDXjjLeoVxAKaaxF6A+u3O41FBlj5YJq5pCt3Q90oNxwEvztRAL+U81JgfhrgZyNF/vB4AMjaWlCNzUCNSuEB5bqFD7147wXBqJEIMaKpr7WDlRnSeLYCoojEAw2h4UcXEOcLjHkKQzxu1vd9ZV6mSiwUOp776c7H5Mgrf5B/5vurXd0f7XVu5iK80CfOcFWCogU9BhwpIrtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiKv/Q8TyXyUbLknhxYsvUlx4ICICu/FV0Owoy0U4uw=;
 b=WRAIw67f8a6bYWHHukKgLrtacLRcZ1FuyQN+af8FL2pFNVlWt6Mu85Hhzv4OoadpJhE6ota8tFWvzsbOKIziVcQapKkttoTno0rJSErci+Si06aX2JpbWZgjNvLx0Mks4Y/Km5i/f8d9YxaOcZojVr4KqJvDsgrIufIOT+lGjoc=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 23:58:22 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 23:58:21 +0000
Message-ID: <2afee6bb-b2f0-4a86-ba8c-d33b0b477473@oracle.com>
Date: Wed, 1 Oct 2025 16:58:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in memory_failure
To: syzbot <syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, david@redhat.com, kernel@pankajraghav.com,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com,
        syzkaller-bugs@googlegroups.com, ziy@nvidia.com
References: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <68dcb33a.a00a0220.102ee.0053.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::13) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: e71655a0-a385-487e-a20f-08de014666b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1ZGbjNYcDZiUU1FL2c2WGR2aWxLbFF1Z3l6NDdsL2c2UDBCdUcrYTkyY1lQ?=
 =?utf-8?B?Szd5bGdFUlU4dW5SSTdBQ2JPeDVtUmI4WHpwTVJLRzcyVFhIYlpvU1U1alVO?=
 =?utf-8?B?WnNPNUV4ZFFzeENwbUt0MHJTMExnNHNPM1B2Q1BCY092ZUJrZWlHdkZSS1Ux?=
 =?utf-8?B?ZnFnbFowamJ2elhLd1JEZmRJTzZFay9DTXpFMGxJemc1YkpHdVB6R0JzZGt2?=
 =?utf-8?B?WmFmV282cU01b1VhaE9ZK3lwS3I0eXZHaUdtZzFQb2NCQnJMazZHVjd3Z0ZM?=
 =?utf-8?B?KzNTbGthU1JLZjNrMnUvNGtaZnBZVjg5OUVjU1d0UUxXNzZBK2tyb01FVTdn?=
 =?utf-8?B?V3VJTjV2ZGN3V25YMG9iVjlxalhrRmJQY3VvcERxTEpoT0RSQ00xRlhwc3hN?=
 =?utf-8?B?OVAxZ0ZYRHlRMkVMam5TRnRjbjJYRUNzQ0wwRGcwVlBFVGgySTB0OXRZOXFn?=
 =?utf-8?B?dmZHdTZIWHgrM245cG5oc2lUU29pTjBoK1ZwV3dvWU93eFpwVkNkb2cvQmd4?=
 =?utf-8?B?Y1prSkl5Q2RhNngvajFxWDFaWklIU0Y3MTNxUEErRzV6b1VqenR6Q2ZwOUhI?=
 =?utf-8?B?UHJyQytqZWRHQ1NXdzJOWTJkZG8rMTJQTDNYSU50SFJWb3cwdE9aRnNXWHQv?=
 =?utf-8?B?RHMwdEdZckEyMEsrbkpXRDU2NW4vVElsWU1qM1NLTUZvMFB3TW5aeVVnMzNE?=
 =?utf-8?B?ajRmZ1RReit4ZWxUNnFzSHk2czNzM241eTgzNFNia1RUQ0pVV1hyWVdYTGJ0?=
 =?utf-8?B?QjEyWFhIODY0V0lPdWNoei94YjhiTkJidkZBeDdXeHAzSFc0M0tZR2d3ejZI?=
 =?utf-8?B?M3B4WTVGY3dqWVRWbjBxVndkN0FjMkRNS1ZXZW9ycXRvYzVyUDZoU1U2T29n?=
 =?utf-8?B?MkI0SmxhWHRqdUNVdDVzS09WS0dHNGFvR0hJcnZYb01zZGw1MkJQQmtZTUxV?=
 =?utf-8?B?c3hPbDVBVkcvZ3IrZFI0RjBBOUl4MU5mVkRYUG9FRDNOcXVWaWxITGdzcVRZ?=
 =?utf-8?B?NkV0bHVGUis1empTb3ZIc1BwSWRjTmhpWUY1TCtYd3NLNmtjaHlkaVYva0ZW?=
 =?utf-8?B?UisxektrM3VzSUdtVzA1cENEakhPZGU1T3NLN0lDUVBNcjcwRWNVaXNDSjB1?=
 =?utf-8?B?YXNUVXo1bGRBQzRTbS9nM2w2QkFWalcza1MxcHZic0duZ0VDVXd2dTVPelZZ?=
 =?utf-8?B?SXRxZmdUY1FVYnFBVlA3cVJGS3NHOXhMKzRxZmY1SmlLZkNvLzZ5YTFPQkQ3?=
 =?utf-8?B?djYwV0NrS3JkVlMyVzhhVFg4eHcrWjlNS004b0lQbnM1VS96MEI5TUFtS0tT?=
 =?utf-8?B?Mk5YWVBvYzNaaXFMeElwQjE3cEd0dm9qS1VqV2J2M013RkhNMWZjYUd3TGNa?=
 =?utf-8?B?NE43YkpTL04raXo1TmRiMmd6NWtRVzBNSlJscDFpR3MzNmsyemZUaUVVSmJr?=
 =?utf-8?B?b3Zud1IrM2tkOCtvQTgwU21wV0pIMGEvazN4T01qTFRFTE9QbGozVWc3OVZa?=
 =?utf-8?B?WnI1b3IxQmRFRFViSzFjRjBmeXBOYkhBSXdYY2s0QUFQa2Q2bjZhM3ZQZzQw?=
 =?utf-8?B?TWIwM1lEbnRSZ1VCNFJuazIxRHZnQitLdzlhNDZPeVhqendZOGZieXRnakZZ?=
 =?utf-8?B?UDlGdVFkODk4dysxVWw1NFJXSHd2Zm9kaysvUHdoMWs5MUROdUl6NjIzc2Jl?=
 =?utf-8?B?VTVXTU9GcThrZWZBVzNpbG42SWZjNCtsZ1A4VDFpMlliTXJpMmRyOHJXMjJp?=
 =?utf-8?B?T1R3REdaOUFwb0xtWU9XMUNxa2pmVXpVZExmaE9YSHFiWVI0RlhYKzNUc3NH?=
 =?utf-8?B?enFIQjhQMXNlNkd6RUl1eHZCc3o1alBuSWF0SkpXOUcwTWNiNnFCWFhDRTdS?=
 =?utf-8?B?UVJROUw4QnJWWDRweG0zNDJJZStxS25ycnpLS0pWWTVyWmxkemw3bUtoMG5l?=
 =?utf-8?B?aWUwS2VuemFMa3NWWVhPOWhrOVJJdXVEWXF1NGRDUTErZEF6Z2h5dkZtQzJT?=
 =?utf-8?B?VzNWL2Zpc0VBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGFIVkJVMHQ5WjFRbVFmWXgvbWVSL2kzTU4xVnhDRmhTWTM4WExYckVsWXFY?=
 =?utf-8?B?ZzFaMjFmQU1IQ0JOdndicU1CZnVRL25BT1dRaUEzejI1TEl6N0h5bTJMNE1u?=
 =?utf-8?B?cjhMWU9Ba2xUNWVWbi9VdnQxc3hFTHI0c1hKOGY3S2VqcUdxN25VamxFWTU4?=
 =?utf-8?B?M1VCTU14OElKcDVXYkJINndZeHRPTW5scTM5bEV0WkNzRmMvN2JCVFVjQWRr?=
 =?utf-8?B?Z21JcUxSd0NBTFl6QVFHMnUzTk0wcjNoYmRtVU9FMVVXTlhnU2NjL0hrVWtv?=
 =?utf-8?B?ZFBqWldvdkpsL0JPaG45RVozS0llMzk4dXlMcXBwcUdVOWtPUitDQzh4MmVh?=
 =?utf-8?B?MzVUUy9EMWcvdHJLNlNyMjVrQk81eURISGQxNjJPS0NORHFSTjJqazhtMFBW?=
 =?utf-8?B?L0U5eGZVWGo1eDBmUGtZY2hMd21QRkYvK0pXZkxEZGM1amJMN2YydkIvVFZ4?=
 =?utf-8?B?MmdJSHRrQ2RiUzJkbm80QnVSc3FmL1NZWlN4dkhoNmZWYUU1Zkc4R250TjhG?=
 =?utf-8?B?b21YaVRSSXVwNkVjbVN0YVZlckc5eHRUNVF2U21wL2M2T0lLUTJkbTNQQWVa?=
 =?utf-8?B?UnBldTNjZ3pHUDV1YWsrYlJydnNJL3JCRE91QWwxVDdadndyUm14VUVOc2Vo?=
 =?utf-8?B?UllQai81QnVDOTd5dElJQmpIdUFDZHVsSmZjSVZmNnV0NStOcjFHdmg4MTA2?=
 =?utf-8?B?bThKVElCekhDUG5UeVZOZ1JXVWpzT0ZST2Y3OHpGSWViVW9lcGdqK1NXazdu?=
 =?utf-8?B?TVROVjdlOTE0Y1VTSjNmd2FvYlNxRU50TjlqcklINXptc0RCRXMranYxYm5i?=
 =?utf-8?B?Z1lXQWcvK2NSY0NGb1lmeFZNRG5hV2JQRXRJUlZQUTJEeml5SlhmYjRKTER1?=
 =?utf-8?B?Y281S2xwWjhQemFGSzB1WWFyU3N6ZTBiUFFTdC9NTk5GN3F5L2tWUVA0bytT?=
 =?utf-8?B?ODVYSlBFaDA3WHcrZHZFYVRYdm0reDhVZWZsNkQ1ZzYzaTRlR3FncVRTOVAv?=
 =?utf-8?B?T1RxTmE0OTIrcFpUbmFVb29hOG5XWVdLU3plMWN2aE1Vc3NvWStFTEwrK1FY?=
 =?utf-8?B?bTBxdFBqajB1M2gzcGRTcHFJM01vNlVwM1d2c1hXWWdKTCswRDZMRlB6WitS?=
 =?utf-8?B?R1JtSy9ia0RoQ2NHM01IeUlKdXJTd1IwVmVZUFRnSThlUkNpd2NkeUNqdGRU?=
 =?utf-8?B?TzUzUklQZVdqT3RUd1dBWnFRZjBVd2NqN3pWSFlINlJvaDJCTmJxNTZpWmtP?=
 =?utf-8?B?ZXgvODdKUVdlRVlValNhNTBYcHZIRVJjaUQwaWhSdVlESXNranYvODVvaTZZ?=
 =?utf-8?B?dTBic2c5QzQ0TXU1VVV2T055b3RkRWxuSVVQNjBFaFlHMDNWdHhtU2pYSFNv?=
 =?utf-8?B?amhJY2hobVZDZldMTWlkM3AwcFdldThJUUFGbjlMNWVJeDE5QU10cThCT3BR?=
 =?utf-8?B?L2JpV3YwdlVxVksvNzdhQ1R4MWwxbnppZG9TSzRvNmFmQ0NCaDB6NXkyK2V6?=
 =?utf-8?B?RFZ1OHY0LzZRU3JmTnU5YmJtVUdta0Zyb3pnTFlDK2JVRE42MlNmZW13T2ZI?=
 =?utf-8?B?V01wUG1tNXEyeXdCYVJweWU4bk9sNSt2ZzVsSXFJMFJxZm53SWs2RDgyQ3Nr?=
 =?utf-8?B?YzlFdXZvd1ZpWnJVazRaMnNGVmVhSzA0UDg4aHAybFlrQTNzZzBxRDdaR0lC?=
 =?utf-8?B?Ym9zVllCdG9aU0t1bElCMER0SVlwTld0NUplbXlITWdIRCsya0Vrd3Q4NFZp?=
 =?utf-8?B?YVd2S3p6KytXWnp6dy9td2RxTGxmVWRncWZncTJ0ejR3dTc0eE1WVWZKTkNR?=
 =?utf-8?B?WGVJa1ZDV1NYWlNhV3hDakk0OXZKeW9SaS84amJkYVNkZGQvWS82VE1ZYU1Z?=
 =?utf-8?B?OWwwRENqSDFyUzBVNXZpc2pTcFptVU10eUFjWHpNYlpPTzA0QjBHeXRFbXFi?=
 =?utf-8?B?YkhyZXB1aFAxUjlqTmZLZ3dIemhiZmV6NTdFaHBCZmEvdVIwVG1ZNEdSL2NP?=
 =?utf-8?B?R1FRUlVpTEV4a3hJQlFJK1UyS3F4ZGhodFVVR3JDWDJkMW9EVEpZM29lUVdr?=
 =?utf-8?B?d1dZcFRJVlRJdnpPRVFycTNwdGFUMWcrZG1hZVFSenNrS1JwSks4S0p3QkVo?=
 =?utf-8?Q?4ad2kkjLJ8sTTVQ8mR/4n3fXu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+/RP65Pv9It9eiFYtMg5vZYaMuZCloD41DS0LRAJZ14xFgqPbg5xAWPOOS0L1fuBolzj3g/KCTwEY0wBW63WIvMwOKS85kK1YtON2vzqEfyTouTJmdpVWXrFl8XD9Nvz2ozl4h5TLEJ9Wn9nnr3UtaCkU+fuEPpkCvCoHoqBp4mENb+4oanYfmXyqVbcGo3k7f4XrGmN2wuTapYItqkwmXxBvsmFk0XqhTCpiM5rMKNiylpUQcA1qRBkKD7P64QEp8ZuZcT86BRvfgd+WCw/gf4hl0v8sa8+WYBFC/eV4b1l5H5rRe8bqygGGfCpd2CFGDK3ZSepMxGl5QwCXXD5h4PJpib6q3rYJUzxMiZuZm9NFsBUkSP1yw5rupcyUhYwMIdHxYGmcEkcXSN/jS1tZubAWbjo8xeWFF1f6EehJBibWn9BFjvfMk2v6KicATQwAYb8lB+2E+8cp3ddpj50ZXWS1DG5U0ld5MA74xR/KxaIVU5WbSLoaGjZJdXwKuEDai9+jpohn3UavNTnzUBgkLZ+s4OQwdARJm3IvONvAfKj54ir1H2NCJil+2PhAvvJy4wNOHUNNunW6+XQf3DeEX+OriFoO715a8exbuUZF/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71655a0-a385-487e-a20f-08de014666b0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 23:58:21.7758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDmmUL8FK2KpYZkmbOoK+XOfkdIAx20K0pH9l7sJ2WKm/0aHj4VusAdYIKw0J3EZmbLrTrD2bjJ6P53yC7XRqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_07,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010210
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68ddc025 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=edf1wS77AAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=bnBHPdndcopWjQMzyRAA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=poXaRoVlC6wW9_mwW8W4:22 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=p-dnK0njbqwfn1k4-x12:22 a=jjky5lfK57Ii_Ajn6BuG:22
X-Proofpoint-ORIG-GUID: 893x0tMwGOyVUd26BgoZKp5ga-LRmLik
X-Proofpoint-GUID: 893x0tMwGOyVUd26BgoZKp5ga-LRmLik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX98T0IaoBZvOy
 Y4szIxrIgtr3sqU87CwDI2CdhhT9yABeHUfT4biSfbADZE4BCioOLYFPJk7sGtscS4CbnK+q72l
 wAvp1to+dCr/TkBL2PAe362MWx9Y08iTLq27slN6juOI4rUZJ9E9EwKBiKDBFokrHCi3XninihA
 wz1oECujuHzrO0uhxXqzyRIx3duOnP0AaYndW5dzNzwhe8t974Ocwh2GliPJ+8rTWi974G5PM0X
 FkfDUinSvJFn0cp0i5whc3hvmd6mUE6Hiijrhn2nBvqQH3ZJTxbJb6DkasrpfzrSLuy7WQvX9+D
 L5vMV1xWEUAJ05kjpEPkq7glJxw+0cgbRPPPjGYAPR/P5R/NrucxwSzJpyII5AbnKXg/dvSQDXM
 AV7Qw6Yuqs3WLpAg/avUHr4ilRa6+g==

Hi, Zi Yan,

On 9/30/2025 9:51 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> lost connection to test machine
> 
> 
> 
> Tested on:
> 
> commit:         d8795075 mm/huge_memory: do not change split_huge_page..
> git tree:       https://github.com/x-y-z/linux-dev.git fix_split_page_min_order-for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17ce96e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6367ea2fdab6ed46056
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> userspace arch: arm64
> 
> Note: no patches were applied.
> 

My hunch is that
    https://github.com/x-y-z/linux-dev.git 
fix_split_page_min_order-for-kernelci
alone is not enough.  Perhaps on ARM64, the page cache pages of 
/dev/nullb0 in the test case are probably with min_order > 0, therefore 
THP split fails, as the console message show:
[  200.378989][T18221] Memory failure: 0x124d30: recovery action for 
unsplit thp: Failed

With lots of poisoned THP pages stuck in the page cache, OOM could 
trigger too soon.

I think it's worth to try add the additional changes I suggested earlier -
https://lore.kernel.org/lkml/7577871f-06be-492d-b6d7-8404d7a045e0@oracle.com/

So that in the madvise HWPOISON cases, large huge pages are splitted to 
smaller huge pages, and most of them remain usable in the page cache.

thanks,
-jane




