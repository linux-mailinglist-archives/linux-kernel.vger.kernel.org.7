Return-Path: <linux-kernel+bounces-760597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6395FB1ED85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC951C8036F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D9426E705;
	Fri,  8 Aug 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJlilnpN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ABn2uBJQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2379CD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672070; cv=fail; b=jpkgwFOBK7ibdWiOJwbl08UllwiS2sQIWISRqAVeEZTHrcP89J5i/pFPXe8HoX3iOSd/CQGp1EGYTWo7gGuym1wgCC8Z4vknUk5GCe9vC0Ov5+X/wz1pX6zodyAERUGXyr2S3bzW7vlN+Avd2YTuKu5a0Aaz2hPsVAV2w86XT2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672070; c=relaxed/simple;
	bh=QHLg1FROfUPseNyJYeew+PqcKVUqgybY7F1yePNVH+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wz7eXZTpTutjCby/vNmWzXtA93YitGjM6iD2l+bxLAa3DM1sECV6nrrgx3BweRrz9Ii7Ia4a3kWtHAP+BH0TY8DvSQzDxpu49a+B7xVfBR7nXEHagzTMN8VU2XvNln+n0ZiIJr0G/4u5FQGtBkkRhTR1ZAxtPEJcbbMqM0aaTXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJlilnpN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ABn2uBJQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNThN007046;
	Fri, 8 Aug 2025 16:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QHLg1FROfUPseNyJYeew+PqcKVUqgybY7F1yePNVH+g=; b=
	DJlilnpNLRFIBUwdzrNAn5224HzkVVGr2hYNT/3lPpg5qXWronaMLpGvovP+LROX
	unGFtyF1pnZgG+5VYTqPXDAA0A6N3WfQ9shFqhXGfwQhRYU7ll0COoO5cSQCj3fM
	eLszjrHcHCLmDBlm7Mvb0o680BlLGh+eQ9ojZOUL6e69IW69DQ+aD5Jk7LCPDxDs
	tZ1SwHZBASw2KFggfFxA6upmR/laxzn/sbHh+9j/SEqeE/O/Ki4RmhYbdSylf9IJ
	MVqEGntS2XB/m/jx+gf5d287qFE5Xso+22r7dBkZkbIIifgg/FLKW7+kk4TWDrxT
	SrxdEiwLz7cwXOO99kf8Rw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvg6r8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 16:54:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578Fs0AK018366;
	Fri, 8 Aug 2025 16:54:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwu10bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 16:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNyOv6JM3+eAi2NZqU/JVJr9AIPrQi8A2P7Y3BTUPr88LVLU0YsQTH1ZK3/w38ytCAWwDqihGth5RnN5DoSR2nSrum1ulOqH8opD+ixCr1+PofyPRLtP39or/AvOHJXiLvlHaycktG06+K0oO0PiBmEEskWqqSBl4g36AyI7K9n8HnTnkFZp9OmiBcwdOvkmRbgwUGSUR90ACr6q4NMTH40O9Uwn8NvrXiRmv1WVkAZt5i+OcebltkOgFig+l9O1uoaHS1i1dsUZlvP9A1239UUeJJYz6FD09VPxDaFEI1VfR+rOSst6c6BML0werA7PDDX8eTJGOTkWJpplwssOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHLg1FROfUPseNyJYeew+PqcKVUqgybY7F1yePNVH+g=;
 b=E6vaaRXLdde8CxKqSxboNokgtotRmwG/5NksS9ZTGhZU/Z+FRk7ArDXhzKxgPsCQWGv4U+JA/llxhN6uEhbzEa+ESaIb+kOLjwXj1rH+deb7F+JUnaKIObVknDb0n3sz4Yq/9SS+oPFpSr7uYoP3wzXsMjqRu9YQ56aR/QsjcEBpGbOdbcSY3QHXrOyPekIRO3JMx8CM2GeJLmmJZAJ8VH+4lhf6GRgKdt1yd1ePs93fAEGb/qda+ZCSQXX2yg9PwDr3dd8I+yV2tXxWd0QgG8SObc9H3gOazatvHjh3xfGAzveKfUQ7CAGZxNwwUpOQi+djD61GLuwKbqjAfzNDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHLg1FROfUPseNyJYeew+PqcKVUqgybY7F1yePNVH+g=;
 b=ABn2uBJQSUDDT1Z/w761c6LU1Ll9zTRO9eJMnU0J7uh45DSMwi+zFBrqnSpV8EHfORxFoKQmTciphGMq4LgBgxjszrH6z0rdP1nw+UXeJjW5+Mnyr2+WZxcDHOMd3z/q3bPWsMI2AXjRoLv4Prqy87c+wVcvbEKy81Me7RqOVoM=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MN6PR10MB8046.namprd10.prod.outlook.com (2603:10b6:208:4fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 16:54:07 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 16:54:07 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 09/11] sched: Add nodelay scheduling
Thread-Topic: [PATCH V7 09/11] sched: Add nodelay scheduling
Thread-Index: AQHb/LZSLlq9aSh2/kmT1hjFQdgmRbRY1pUAgAA6DAA=
Date: Fri, 8 Aug 2025 16:54:07 +0000
Message-ID: <B8447D54-1E59-4705-9BDA-D1B88D831023@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-10-prakash.sangappa@oracle.com> <871ppmc5cd.ffs@tglx>
In-Reply-To: <871ppmc5cd.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MN6PR10MB8046:EE_
x-ms-office365-filtering-correlation-id: 26e5ce1c-bd54-4201-863c-08ddd69c3085
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVgwYVRwbnk2ZTZXOXVtYndvRTFpR3hjd21BSUhBU3ZRV1pBVU44U29YQUJh?=
 =?utf-8?B?TWN3aE9yRzVhNG0vZ1N3RjRyN3R3aU5Fejcwekx3dU9hQ21qdkF2Snl4K2h4?=
 =?utf-8?B?dVQ2a0s0bTVMUHZobmc3OXJUdEg4cXluaEQwR2NPMmh2K0RRRkRhdGdBYTlV?=
 =?utf-8?B?dG9kZ1E2ZU15VkF5dnJPdStCMXRBVklGRzkyWlVieDk4MUx1V1NWYy9qM1Rs?=
 =?utf-8?B?ZmpNUmlEUTlyQlJKUnpJanFtamQ1ZkJvazB3cGJXZ3lPTmlnTmFXcEVQd3g1?=
 =?utf-8?B?VDNqVG5KYXZabzJlbHhrOXBIV2NUWkxQVEMxS3BJeVlaKy83V0lmbHZoU1lU?=
 =?utf-8?B?ZkRZZ1VORjV4NjNCZ0xuK3FPUXZFRE01YnJPQVRXRmVvcTVjRGNka2ZDMjEz?=
 =?utf-8?B?bWs2dkVUandzWjc3NWtHNnNCY0hGK1Y5dnpJbDFqNVN1Y2xEamtDekJPdVlz?=
 =?utf-8?B?WTZ5TXI0K3NUYjdNS2l4MHhZcENyQWcvYmY0NmViK0w1cldteCt2elB5eHlI?=
 =?utf-8?B?aHhUL3FMcjI2UGc5a0hhUUpLUklRUkRPd3I4eUtBYWpDajNDL016RUU5M1Ux?=
 =?utf-8?B?UVFFR3NUWUU2RzdpM01ZQlNERVBWM1VGNDJSc0x6ZUhNNGtta0JWSWRHSFll?=
 =?utf-8?B?S3RaODdnWkVibmkzYTNhb25tNDZMUThBL3hJY09RL1E4UHU5RUtSM0NnL3pC?=
 =?utf-8?B?QzAyMTdyZXROaDNlM0k2U3Q3T1F0aFRURDMzS25FVzdaSTZ3MElKV0NQLzBn?=
 =?utf-8?B?elM2bjJhOGgzRzM1aWZGa0FwejQ0S0dLN2k4WGNNR2pWdXdQYzJLVGJ4M3N4?=
 =?utf-8?B?dVJialJDUFdKSkR1dkQvSmdudW1sRE1MMVRKTnhyZlZoUUh6ajA3Q1JMNDFQ?=
 =?utf-8?B?V05JNmcwK0plaTFsOG5xREZSVGJNcHZ5RjJxVk9oejFONnNwSjZDZU56aTNj?=
 =?utf-8?B?Tk93OEpIYncvZmlFWWZrMmdqc2dwVFJxaDNXT2t5UUpKOHB3UStBdGFibjNq?=
 =?utf-8?B?aVRYNjlqcUJwZDBieW9TNTYxTktmVEQ0M1RtN1YvbUt3cjNPK3lacXJxbHlu?=
 =?utf-8?B?RXhXSWtUd3E3WStZa1dyWGdnVG0yMEIvNTFWbkhkTXZTK1hacW9BZlRmb2c3?=
 =?utf-8?B?Y3RIN1NCWkxzd3hVRWtIV3BxTUhoR050aEFQbFhWYTNCRXkyTGpDa1hyUDhn?=
 =?utf-8?B?WDlsNHBnSFptZXVOQ1Z3Mng5Sk1JR1ZjSkNhRUhYbFV1RUpGM2ZScDd4cFpj?=
 =?utf-8?B?YjlEQ09XTHNZQldwYnZzQ0F2SHVhQlh4ckkxMVByUE83NDBVQWFCVjQ1VDMv?=
 =?utf-8?B?Ym1KcklhM3Q4Q2dLNEFuUDdKYTZSRlphcmp3MHIrNXlJaHZIUXZWNjdIMnF0?=
 =?utf-8?B?WXFSRnZxTjZSWVk4L0RGMUN2dXJUeWNaNVhaTlZ1Z1F3MDB5UUthZG5WTFl0?=
 =?utf-8?B?UTI3eFZtOTlVYm4zbS9rRHJVWmJDWGEzNjhqZnkwcER6RzhWQlFDOGhwc3Vt?=
 =?utf-8?B?S0piRUNia0x6WUdySUM0RzVHQzFEd0llSnNKdmNXU3RQSkt2d0hMM1lYVmRL?=
 =?utf-8?B?RFcyWU9POTJwQlQ5NlRGTUR5ZytmWm5SbVRwaVN0bDFPb2dqbFZGVUMxQmVs?=
 =?utf-8?B?bUlFMXh5MG84TkM3V2Vwa2JJNFRWU09DbjB5RzdBNVZlcytZMGRjN091M09Q?=
 =?utf-8?B?UWttWUNWZFNKYnBmSHFPc3VyV0IwbEZVTkxPQTZLUjFZMEVjbXZucTVRM0t1?=
 =?utf-8?B?c1hqamZqQW1JUWk0N3RFSTN6NHdDVFY4SzZJQWZPT1pvdUV6WUxFbFdjd1JR?=
 =?utf-8?B?QUlUZzdaUkIvbFdWUDhCU0ZzaUFETkZiYmFYN2VVZXlwbTMzUXFad01vZFJw?=
 =?utf-8?B?Q2wvelVYUFYvVjA3T2F5T1ZlcStZRDVOV0p5Vk43N1orUUNoQjRIT2RpRGRi?=
 =?utf-8?B?VXJORWlQWDJza2V0aXZIMUNZNDE2VG9MVm45MHFtbFprVHF1UWZ4M1BIWHZs?=
 =?utf-8?B?dkRYdEVZQkx3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1d3WGsvRnEwMTlydFRaQ0thMlhiSE5UZ0Y0VkpOai9ub0x5cU9vNURpSTJa?=
 =?utf-8?B?Rm5XZjZCeVNUQTBBcHdSMWJjVGM3MTE0WDQybWNHSi9SbUQ1d2wrdzdmL3N2?=
 =?utf-8?B?dkRvMnZEMWYwR09leTluQ0Q1SnNuRUFOT3J1WFJBczJIem12QStXME8xdEFI?=
 =?utf-8?B?QlFMQ29VY04wWlBtQTNTakE4Z2daKzZhWVQ4bTlnMWluNiswVjkxRnJZek10?=
 =?utf-8?B?VXBWTldTMm5jdnliUm5aRWF6Vy9XaU1CdXVXd1UwYmkxQkd5N0NBaVk4MENH?=
 =?utf-8?B?OVlQSzZjV25xRU15YjBtcjhManhGdnFTWEx1UWpxc1F1YmFUM3lFNzcyVGVn?=
 =?utf-8?B?VDFIVDE3YUFJY1V3eTRnTkhzSVNOcXk5Y0RIK1kvMmIzNGpBaTFVN3c4UkNK?=
 =?utf-8?B?UUowWTJjNHBLWHh1VmI2TWlQcHV6Y3lSU09BZDJRRHQ3MGNQL3dMNXhXRVRG?=
 =?utf-8?B?YU9QZXh1UWpBZnV3Y05EZHBXWTRaUWJzRUFHWTYxVFFtV2VjTnpsRDdVV1kv?=
 =?utf-8?B?Uytkb2l3OTR5NTdOdHdnczgvdEQ3Q3pvdENyZTV0R3BPdGlDbUlDSmZmdFds?=
 =?utf-8?B?TEhRU2plQTJjQTNQZGtkNm1BNk5XM2VLZGIvbTJraHdKckFmN1NXdS9CYlVq?=
 =?utf-8?B?YS9YY3VKTTRYaW13MnpiRkFzM2hLd1h1Wkd0ZWFVRC91SkpORWQwY29oTklj?=
 =?utf-8?B?NjZoT2lNcDNIUHRUUWhzdTcxQk9sVUt4bWE2RVlVTE9QMWFxTkkxTkFoZVlY?=
 =?utf-8?B?Wmt0bXpaK3lrSkZYZ0k5RzV5ZHkxVHBzSXlIY2U1YU5pcHRDZWVEYXVvb012?=
 =?utf-8?B?UE5DdWFlS0Q2dmtpSkY2L0d4U2pMejJHZ1hqazNSVHRPQWptUmdSdkNmVCtG?=
 =?utf-8?B?THlYaXVERTJQOFY1RlBYbnZqQmcrZE9icFYwN2hueUQwQVAwY1BUeVNoY3lP?=
 =?utf-8?B?WjljNWFPa1VGTU9DeDBEblppZll3QUNoS2xZYkdBanBHeEFxZUlCRnVmRy8x?=
 =?utf-8?B?cTl0cjFBU01EZHlFcDB5c1pEU1lxTjdYc3lZNzBnMEwvK2xGRjVVeVZrRjRs?=
 =?utf-8?B?Tm5ZWlkwdkJrOGNtNE1vM0NraVVCTWF1NjZ2NEswMkRNWklIWXhBT0hDM2p1?=
 =?utf-8?B?ZWVOMEZEUEgvRGhrR3hWdGQ4SWJ5YnE1RnRyVVhOVkdiSTdDNzZUSmphOUJw?=
 =?utf-8?B?bUhncjY0NUxpYnlRajBPaC90RzY0RmxUa3Jud2dCenREa0ZZWEFYTlA3eS9o?=
 =?utf-8?B?cXpHczJmRnprMDBVL2VXVWNTMDlXSHg0T1I4a2NMeERoOU5SbmR6cjVTajFD?=
 =?utf-8?B?djdnQ2lmbCtaOHNlNktDL01kcnJlUWJiQlI4WC9xUnJtYmJUbkJjTHhya25r?=
 =?utf-8?B?cFRJQWQxaVRnNUM5bFQvYWtGakJndjg0M0xUZGhYSVp2ZjN3cERNNHUxRjV5?=
 =?utf-8?B?OHR0V2tPa0lJbitBbnc2VXpKUjVtMEdKVWppUENmWjR6N3B3MjhKQ09JZmtH?=
 =?utf-8?B?RldTY1VuWGdHZjVhSTBKbThZUEdsT0M5Wk9TbGkzZW43dWprS2VESzlnRm5i?=
 =?utf-8?B?VnJRd2pwTnNVNktqblZXUXk5UG1rMkZQeTl2azVaWVRlN0R4M3grWmdXcHgv?=
 =?utf-8?B?anQzdzBRbWt6SU9WaEdLTDFQTDg4dFo3bTVKVGpLVG9iOVExMDVEWlRkTjVs?=
 =?utf-8?B?NzI5S2pPdXN6SURkRlRLZVlqLzlTbXQ5Vk94REZoZzlHVHVZbFR6eGlGUlpZ?=
 =?utf-8?B?WGExSXdOUFBaalMxRUR5TVpaaW95aDRhRzRMVWlxNnovRU13K3NKTUpMZGdY?=
 =?utf-8?B?VjRCM2x6VndOUitHVDQxR0FQQnhqUFM4QWZKOHpXeDZWQXhSNS9nU01rVUwz?=
 =?utf-8?B?aGYvTWR0R204YnJyUlhYeXY0UVRuMmFZZ3ZNYlZwczl2d1ovMzZIUXJHOGZw?=
 =?utf-8?B?VXlMMDlTRHFTRm1manhOdHRMSlFVNzh3UmRzalhvQ0JBNHlwRFZUK3p5WnpP?=
 =?utf-8?B?VXN6Rm9FMDI3V2Z1Yko5ckUyWHpDWjNQUWZTd2Z4TzZrbk5YdzB5cVJNVkp3?=
 =?utf-8?B?ZmFqby84TWRkODVxV2Y4a21qelB1d002UzdXb1JOMDZYRmczUFc3UjZoTkFR?=
 =?utf-8?B?aVRNa0JVOWg1ako0dEhSdGpxK2F0WGYrUDdUMHVIS25XRk1MNzhYUVgwajNF?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71C15900F969A4B870A89A1D0F2D197@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iEFnm3V3HAO2CPcj2Dm59jeC9lptfPEJea3kDy++2cVL8uKwGkjbklOstGEuFvIxVGCrnRRyjJ2IK0GZeQ64ZaJ4lU2OnqSLwaCYbIU8K1tGTH/gFXUa6xvOW50hTlLCVKyJ+4C2W+aaKTuwqjK5LhvO5g5KTtd1RZChiT1J99qrY6IpFJUS87mu9dYGncyxWCBwcy/89vPte2LKysnphI0C3soSV0L+umgCSXLMWyjWlBn+IDxEnBF6qZx4rYDKK0/5s6nhCpO/VhI5JBiojQQdU0S6lyiUe+Ot8Me7xppiBvHJFcBhQZ57z4G4bTwvwEtA5RUgvYcmMLBdxJbbkuhaDusIC/WVKmqny3B9ig0k8nKjCCkouqUSTQK+v5m1Vsr69dwuTfM9KR1A9rzFE2k+TQqIi2ovFmdBZ76K2xZQSyDacE+yZD89iZmK0K5qcEhk9MyOJDG284TFj244/VNFcoxhF939p/4W3DD+2f6XV6k1G3/2hC6GemADHwEesUHEpKKPn9i/SrluofyF4L5fbylXnsWf1okgFlqYRLS3StNuftFPgBcv12tYkMTtGEWEP0pHOZGVD0Vb4eYNrsylOFq4CzHYXWFEajoL01c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e5ce1c-bd54-4201-863c-08ddd69c3085
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 16:54:07.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EejxoXKMUEGUGWLGAAjDav8l/uV7s2E6PApjpuM3K2gWCbbo5qwVL+EfanFx72Cwy3Lfm5kD4g/cKqrsW2Yd2cwhsWeaUOokUfXr39fwt74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8046
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080137
X-Proofpoint-ORIG-GUID: lTO8NOnWJh_G-UDfX-dWAiqSnijdb_go
X-Proofpoint-GUID: lTO8NOnWJh_G-UDfX-dWAiqSnijdb_go
X-Authority-Analysis: v=2.4 cv=QORoRhLL c=1 sm=1 tr=0 ts=68962bb3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=_i59J38s6et2GF7_Sn4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDEzNyBTYWx0ZWRfX8CG5IDr1J2yZ
 /ky/xdZx9L6YV1t3NSgFSNGAZcGKft4WHOsEoDmWKLzJcYqO9QalGLF9a5O0a0PQ/vZR4YsRN3a
 kD3YhwZRb00OLUkIXIMk6AdKlB71JLo35ITSvM74UXKi1DRLFByDfvZuXjmj+ijWRgMl0pABz+z
 v+pIe8rTFl5weUi5k4Nwa+zI4ZWAdWHkUvhog50X2AuUMMuTFdKoXRIbLH1syrx0FTGHfTlKRE9
 kciBJfDFEjUedeEBm4QpHOa4RXUbOZRWarEP0yvHkH0HR5aQMBUIkLucBn4fqhG69LzOeuFjsMn
 ytvn98mqe3oPuc2yAP9KW0f7Qrbbppb8Mbvc3mt9LR5hr2PO/IQlo3ty7GZVXWoGG/2Buljl+bO
 U1BhkQUDHLSfNZTQBkTXMWtJnm1IxzMxlkqNEWO0dC8ngZcfvZwn+FoNSIIKwoiUxm+nmkVJ

DQoNCj4gT24gQXVnIDgsIDIwMjUsIGF0IDY6MjbigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBKdWwgMjQgMjAyNSBhdCAxNjox
NiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+IC0tLSBhL2tlcm5lbC9zY2hlZC9ydC5jDQo+
PiArKysgYi9rZXJuZWwvc2NoZWQvcnQuYw0KPiANCj4gWW91IGZvcmdvdCBkbC5jIDopDQo+IA0K
Pj4gQEAgLTEwMjcsNyArMTAyNyw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9jdXJyX3J0KHN0cnVj
dCBycSAqcnEpDQo+PiBydF9ycS0+cnRfdGltZSArPSBkZWx0YV9leGVjOw0KPj4gZXhjZWVkZWQg
PSBzY2hlZF9ydF9ydW50aW1lX2V4Y2VlZGVkKHJ0X3JxKTsNCj4+IGlmIChleGNlZWRlZCkNCj4+
IC0gcmVzY2hlZF9jdXJyKHJxKTsNCj4+ICsgcmVzY2hlZF9jdXJyX25vZGVsYXkocnEsIHJxLT5j
dXJyKTsNCj4gDQo+IEhvdyBpcyB0aGlzIHBvc3NpYmx5IGNvcnJlY3Q/DQo+IA0KPiBJZiB0aGUg
Y3VycmVudCB0YXNrIGhhcyBub2RlbGF5IHNldCwgdGhlbiB0aGlzIG1lYW5zIGl0IGFza3Mgbm90
IHRvIGJlDQo+IGFmZmVjdGVkIGJ5IGEgc2xpY2UgZXh0ZW5zaW9uIG9mIGEgbG93ZXIgcHJpb3Jp
dHkgdGFzay4NCj4gDQo+IEJ1dCB0aGF0IGFzaWRlLCBJIGFncmVlIHdpdGggU2ViYXN0aWFuLCB0
aGF0IHRoaXMgaXMgb3Zlcmx5IGNvbXBsZXggYW5kDQo+IHlldCBhbm90aGVyIFRJRiBSRVNDSEVE
IGZsYWcgaXMganVzdCBob3JyaWJsZS4gV2Ugc2hvdWxkIGF2b2lkIGl0IGluIHRoZQ0KPiBmaXJz
dCBwbGFjZSB1bmxlc3MgdGhlcmUgaXMgYSByZWFsIHVzZSBjYXNlLg0KPiANCg0KVGhpcyB3YXMg
YSBwcm90b3R5cGUuIEFwcGVhcnMgaXQgd291bGQgZ2V0IGNvbXBsZXguDQoNCj4gUlQgdXNlcyB0
aGUgTEFaWSBmbGFnIGZvciBub24tUlQgdGFza3MsIHdoaWNoIG1lYW5zIGlmIHRoZSByZWd1bGFy
DQo+IFJFU0NIRUQgaXMgc2V0IG9uIFJULCB0aGVuIHdlIGp1c3QgZ28gYW5kIHByZWVtcHQgYW5k
IGRlY2xpbmUgdGhlDQo+IGV4dGVuc2lvbi4NCg0KU28gd2UgYWxsb3cgZXh0ZW5zaW9uIG9ubHkg
aWYgTEFaWSBpcyBzZXQuIA0KDQo+IA0KPiBJZiB0aGVyZSBpcyBhIHJlYWwgdXNlIGNhc2Ugc29t
ZXdoZXJlIGRvd24gdGhlIHJvYWQsIHdlIGNhbiByZXZpc2l0IHRoZQ0KPiBwcm9ibGVtIGxhdGVy
LiBLZWVwIGl0IHNpbXBsZSBmb3Igbm93Lg0KDQpPSywgSSB3aWxsIGRyb3AgdGhlc2UgcGF0Y2hl
cyBpbiB0aGUgbmV4dCByb3VuZC4NCj4gDQoNClRoYW5rcywNCi1QcmFrYXNoLg0KPiBUaGFua3Ms
DQo+IA0KPiAgICAgICAgdGdseA0KPiANCg0K

