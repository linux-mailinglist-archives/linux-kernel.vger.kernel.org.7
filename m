Return-Path: <linux-kernel+bounces-792325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883FB3C2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C65A1B44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C121FF7B3;
	Fri, 29 Aug 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cMQ0eCWr"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2133.outbound.protection.outlook.com [40.107.116.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1E188734
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493462; cv=fail; b=i6We4vdE3zxoWidZPU/gX4+9lddYMpQh7zr8UhqeVXIUlhZOmNPW8pzJxwf3x8tdXQHewLD0+e4lgCw1V5kijOJS3k4EO4uqo+CimtpbL7j40q6ybUeRdW/YLKBF5UcClbbtCS9EwxkfGVkEjCbiOqxFT6x57JqjHyWWY+w/fog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493462; c=relaxed/simple;
	bh=ezgxnCThKnq3Ly4i4cMtpYE1szjHI6acnojxARpUoK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gKI8oeTgIe+G7+vRnfSc+qd4sInHwelnhJ11olcHujXVkQrGkLZLudK4SFkn59jSBVJPcGabBnD0xtqW4gRA72PFaN+YwZAFrbaTrt8Ph7UfuLb6P2XnN7TSQ6F8vTMumHzvoV5T0KRkNc8SkupD5RnNp0EhV0Cgy6eUYaY2vqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cMQ0eCWr; arc=fail smtp.client-ip=40.107.116.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvKEJq7ymVPcy+pHq72hpfA4f9Fwo+Zg4r0W+Js8Ktvi9vdal8nOuuDkHFOlqiPZ3mThFALmQHrm7l3wgqJcMoeiiMbViSrqDuMjiv7aJ+ZwgwxDmyT9oC9xrxIwiYKpGowDYvny/7C5SjqndP62PaGM27lM0YWx+NLy8NZ8kzT/D4JK60fxYR17xUu52MTWUHuMav9cxccKM/nbK7xfq99wsjUgUtHwfPnBpTlv4N8BLE3rq+f5hBiLUZEqKuQ+BN2t3s2W/JnhPB1kbNTLSQFJEup6AREdSV+mvme9tmWLKZOBTi8J3QLIdZrOHtGHdp8K/59NeoE1uqk6EObuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9aVMPC6OoZCpBRXXoD7RjHpc5t+k4iYuda/kRftft8=;
 b=DuESWdgYQjE50ehgxcvHV+IK8r7r5UlfuNgKgsxz617HHB9jxnWNfoh5hEamDliV7myBz2RZGk1Pa+06bRxjuR7r/qPaInbU96CxucCXgAwfLONk6GpFc2QGvMxEFOJHgZ2Q8Je7hCLDkpYZBwBxSC1fZ8e2rfZ3OJJhhmEGJRUOhXUm0VG7UhS2IAFBTnvsV691Mj9wji/nbcmZyvo8zHJv6FUCWd+FlCLmZrnRfg/V/Cne2q5AQPBlfCwxk9FYuQVe56YORODxiufJ4D6l1OF7el8hjHXZl0k8yTDZeyKhoWfmaPoiWHZeBbcdUf9xGP6kEyZ4JBWtSaWixtCwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9aVMPC6OoZCpBRXXoD7RjHpc5t+k4iYuda/kRftft8=;
 b=cMQ0eCWrotjsAo5uXTp2+Dusrc3eovFto6Qh//JxkkPz+y/t6527b/ABNxJ8v3XNUdQqK2Fa6sVs/GEViuXvZs2f4mk8P3vBXYL1+F5xu2je0TRITo5ty7mN0/D8G9RsQ1yUYa0T+QRI8usZROaW1hj4k9rR59aR7OWLdm+ewndbR9kNsf+UKtSgT349+zLTdEsWvxHlNEC5Y+cErxWhjn674mT0UBvBepNqMSb2yFGb/jak4CmVYHioK7oepncJpl0+RVHSfC//PGhkmwrvpuSrf8zfpB7IVHEKswXbPmu+0CWI0+5kcQRLpdmXRq6B9jTeZY8VGk7PCbJ7qwQ5Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT5PR01MB10946.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:135::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 18:50:55 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%7]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 18:50:55 +0000
Message-ID: <9fd284e6-f3aa-456b-b91d-44d4ff5c55b1@efficios.com>
Date: Fri, 29 Aug 2025 14:50:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Weimer <fweimer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Samuel Thibault <sthibault@debian.org>
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <F9DBABAD-ABF0-49AA-9A38-BD4D2BE78B94@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <F9DBABAD-ABF0-49AA-9A38-BD4D2BE78B94@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::18) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT5PR01MB10946:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d80ee7-7039-4dbc-93f0-08dde72cfc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEZ0TVFUZi9LaCtsL2wxYlJOS1RQSmZQeXJFbG9USWpHSTZGVlBoeFJKOUVk?=
 =?utf-8?B?NE9uRGo1dmVmaVdyT01xL2srd0Rzd3NTZE83NHBYRDRRNG12bFZJQXZPa1RN?=
 =?utf-8?B?U1pwRitldUJESlZJeW5HMXlkYVFTWmVDLzBsTlZVR1haVXpFcGg2eUdhUUxy?=
 =?utf-8?B?bjZPdVR2bktXTzV6WVVEaWZDbzJEWjk1R0Zsd0JwMUJNR25IZEtSMzVpUG9V?=
 =?utf-8?B?dkp0elBXSmpHTGRnbmxvU0E0dzE0WVVLaTR6dzNBdGtCcWhhSkxzblR4OEpY?=
 =?utf-8?B?SUFrMFNMTEV5dlpLM3E1bHR4ZEFGOVlmdGR4Y0U2TGZ4VDBkNCtpYXRPU0dy?=
 =?utf-8?B?OVMrK21nWlhlajJZaEhXNVZpMG5IcXNQMWh1dkgrcEk3VlByVjJ1N1dvRjBL?=
 =?utf-8?B?TkJmR2wxcWw5MDA5ZWVqRGYxcVYxV3paUUFmNCtnU2ZBV3M0RXkwUFdRRWZm?=
 =?utf-8?B?NGVzdkh4SUtqTnJXWm1LV1ZIb3Vya28xbUNHMnZXaEJaS1hhNCtOcm00WTNo?=
 =?utf-8?B?N2tVMlYwK21ybGU1b1RYcjFqY2tlbXZNbGo1UURpcktDMW9QL2dCeDhiTVUx?=
 =?utf-8?B?a0Q0YUVDY2puWmI2UG1NeWlPblhiQzdKMS9yTzJ3VEI1RDd3RFJXOEtBcC92?=
 =?utf-8?B?Wm5tcS96Nzd5a2lBYlViMnV3T3EwZHBjdE5IL1dKWEZ5QUhrRmlsODFSNE9W?=
 =?utf-8?B?RitDUEZKMmdOWDZNK09Sc2l3a2k3aEZPY1dSQkNvWVMweXpkenEyUlNsVWNq?=
 =?utf-8?B?NUIzS3liT09JMkJjcFdiTGduTFJIYWhRZUhSSVBPeElpRzQyVnIxU0VpblZ5?=
 =?utf-8?B?Tm1CUGwyRFZRc2xQNy9ybWNQNDlJKzhMSnc2VEtOdGh2QzUzeTF4azZXcm10?=
 =?utf-8?B?RW5JZGh4TVhNZ0NyRHM0NWFxbkJGaVQvSzhOSnorNUFGQnRwYTFOK1IyOE02?=
 =?utf-8?B?NWQxa0gvSEM0NzJ1YUIvMm5UNXlSenhqZUVvNlhqSzN4OEpvVFdhSUNyTEoy?=
 =?utf-8?B?NU5Ybm90THBvYnk1NTFGRHpnZ0IzVDlCK1FOc3ZJbjlCY21tWVBqcE1RQmFw?=
 =?utf-8?B?TkNxQ1ZEdGRKKzFJK2Y2aWcxTWFxMU9QOVRFcTRpQlVpeTdROTJPSDgzMjBj?=
 =?utf-8?B?MzYxQXpHV3RPcDZyM0ZBK01UUHNiNnhVcVg5MVhjWldoVnM2SGtEQTMyWjJE?=
 =?utf-8?B?S3FqZW94a1hBcXJCaWg0SGxGNjN5bTRVc1NpY2RPdm1ENHQwSGNralZPV2x6?=
 =?utf-8?B?MW5yTnN1WkFBRW1mVWp2OHgrbW5wOVpQZHA5UFZvUXhuZDdBMTlEV3A2R3p6?=
 =?utf-8?B?SFdsaEloZ2hPdE50NlNUdng1RGpDSG16dVMzMVBvNWRWSUZqZEY2dnVzQWZh?=
 =?utf-8?B?cExVZXF6MWFNZ1ZWeDlZVVZuWlNrSFIzTjFXVFp5L2RoRkVyNkpYOU1XUGJ6?=
 =?utf-8?B?ODMrZGZid3pUTVZsZk13RDU5WmtJb3RjWWFpK25FemU0QWdod0xZVWdqcE8x?=
 =?utf-8?B?Y1dPejlKSGRYQXAwbGhIczhTemtKcUpRbCtXcDRCeGFPY2pST1dsOUVOcXRv?=
 =?utf-8?B?Wm1URThQUHhGeU5YTENhS3RPZEcvc0liaG0zVVFQNkF1SitRUzhDREZreG5t?=
 =?utf-8?B?Ymt5RThLbEVjZWdaSWgyVFAyVXRjRFVDZnhadUp4d011aUhWdW1ncUc5RHg3?=
 =?utf-8?B?bnBJUU44RVorQ0FBMUVNbEpqQndDMGN2Q05PWVAySUVvUnJOUENtYVdhVmh0?=
 =?utf-8?B?ejRuU20xSkdOaFRMQnk0dkVPaHhuMURFd0lHKzNTVnI2RmJsZU5MWVZVQXZH?=
 =?utf-8?Q?aXwvFFkBBZdeR9GvzCnE/8KByceYScJpDhf7k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzVoR01qY1FGOTE3VHZlaGpqQXpnaUl0RmhseDZTak9KNlMvOENESTdMSHFP?=
 =?utf-8?B?NTVHVWdaREo2cVJjK0gwMTVyYkhNdUZTQUlUWmh0QXpHK1NwcW5JSDFnTWpU?=
 =?utf-8?B?UWZPY3lheW5lSVg2VldIM0NsV2grMmZuRXBkbzdQWXNtWUpjbGdIM0JKclc2?=
 =?utf-8?B?ZFE4QVY3eEVXQ0lBZnIrR216NDZmVlpML3pLNzBQYkQrMDBiUCtLaThVc2pQ?=
 =?utf-8?B?Ylh3YUZHQjlyS3IxR3NoZTR5bzVXMmNVbXE5MjBPOWg5L1FYY01DcFZGcmhw?=
 =?utf-8?B?bWwzcGN1dnBwcDRjeWEvSWhhMmhhY2R0L2ZmelY0cWlTWVlaa014SVNETHlY?=
 =?utf-8?B?ZXpFSkRQNDNVaWNqZ1pmVy9VVkI4d2hMUU14ekVGbWkvMStQNDl3c1FTK1Ry?=
 =?utf-8?B?UzBUbis4M01LeCsyTXRXSGhYK0VMclV2NUg1TmlHM2grZFJzWWZJYThXRHpX?=
 =?utf-8?B?dVkrLzUzd2ZORzh4MnZYVGIxRGtvTk50aW8vbHFzZWlWbHJkVld4cFdtNDVD?=
 =?utf-8?B?c3QxaEFLK1pEV29BdjRiYmdPenFyNVJPd1RhZUMzTXVWd3hzL2VwMnp1QmI2?=
 =?utf-8?B?TndmVTdFS1FqbE9jaldwQytWTGpwSkF4ZWZ6VkhwaFJyaDk1Ri9kL0pBS04x?=
 =?utf-8?B?R0g3TFVROTVrREh3N3F6aTJ2STExdlNOUHhGL3cvSFFEOS94ZVFlTnBWRkFX?=
 =?utf-8?B?V2ZvS2NlbGRra0l6YUVxNWlsNnhCdldUYTVod1ZDcGZBZTlPZnVIcjVBTnBI?=
 =?utf-8?B?bWJsV1ViR1NVZGRmeWxmTmRiWXNKRThJc2Z5elpMMHArMWdhVU9iNm9mL3Ns?=
 =?utf-8?B?MWlNRGdOdEVCMElDZExJTUZtcURiNzQ0R2s3MVpJWllCZ0ZHVWN4SXF4dWNZ?=
 =?utf-8?B?TTRSVlZINkhuSytMdGRwWURKSzhGNEhIaEVTSEowZ1UvTk1UNUpiTUlVME93?=
 =?utf-8?B?ZlNxZ08zWXNEZUlEMjQ3SFBiZXFkUzdiQlovR1crbkc1Y1NJM0huQVRneTlI?=
 =?utf-8?B?dXBuaW11NE9udERnUG83QTVWS2NjVG1hRHQ1b3ZwN3JBakUrdWszbFZNZ2pC?=
 =?utf-8?B?TUMrVjFEV0dOVFFoV2Rod3RFc29xb3pzSmt3QVQyTnU5d3FNaU5hR0JiSjVB?=
 =?utf-8?B?U0NpMjYrdGJ5TGVtMUhYaWRWN0N4TzNYNmhOQVVkUEkrYXRjdDVSMzZGbWEr?=
 =?utf-8?B?WllRVGRzQ1RNRTVZTG5oM3JacndwMTBJazQ2V2szOUlvcnI3RE02NVVCK25E?=
 =?utf-8?B?eS9NbTJaYVhkakRodXJDN09pTkRCU3orNGpsNXRnUldpWDVGTGJrZllLNzR4?=
 =?utf-8?B?K0cyTTVJVGVYYnExdU0xTkJHU2NST2VIWnZ4Qkw5M3R1UmNqUkUxenQ2SlR6?=
 =?utf-8?B?RE1USmRwcTFUKzVLeHNQZi9MTnEybkx1U0hLYjFXaWVkUXFacXBrTk03QkVN?=
 =?utf-8?B?SDU2V3hEUXI3Z2tYK1lnZ2xKYlZVdDFxdDBldXZFSm5ha25xTzVLb3p3NHJB?=
 =?utf-8?B?MkFUeDJyR1NzeVdFVXYxY3J1bTdGWGRoZVpkS0xoOGd1b1p5d09PNkVweElO?=
 =?utf-8?B?MTdUSHltRmpWdUQ5c0pIMTIxK0I0YWdXNUVWYThKMnNWbTNMWnBRdXNIdE8v?=
 =?utf-8?B?dUN0TWk1Qkhsd2ZHMHJud0o2UFM5Ti9sVEFaaTVPN3pNb0pOZUtSdEpsV3lx?=
 =?utf-8?B?RklxZ3NVekdyY2JzT3J5VVNTN242aDNjTVkxbDZHOFBIelNXbWp6TEN2Mk94?=
 =?utf-8?B?ZklIbVBuYTE1Q1FyMVJrRDNCajN0Y0N0T0dNa3RJb0g0bUJDcUJhV2J6U3U3?=
 =?utf-8?B?SzFpTWhJY20yazlqODh6Si9Jd252ZTJKaFZ4cEo2eE9TZ1VPSmNGczUzbktQ?=
 =?utf-8?B?WVMxcWFVTUVNandjS3QwZms3MHNUVmVaVWZuQVpYOFlReGh2YS9iMFpheUVC?=
 =?utf-8?B?bGtPREVlODloUVdnb0tndXNtVVUxWFphQzFTRTBEdkdtOEZPdUZZRDBFcllL?=
 =?utf-8?B?bFlrNG9la3NtbHEvR2Iwd1BFK0Z0ZmpaSDI3UVpubVBMRU9YelEvcXg0cXlP?=
 =?utf-8?B?dWNBb1QySFhBVkVjdkFNbEdXcmxaaVFjM2NwYzJJZUxYeVBpMWJhR01GbjFI?=
 =?utf-8?B?cGx6WWpDYzJoQ1NGMUpNUnpKQ1NyZ1NwMWFBQnZoWVJHNjJ6NFg4WkZOMDRv?=
 =?utf-8?Q?soOUKPhXa5BooKD6hpidSqs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d80ee7-7039-4dbc-93f0-08dde72cfc5c
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 18:50:55.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvQfQUDNcif33NA3A/Pk8esYifsEJYKLsCpOvdnr8yWRjWoauZPenmGX2XgxdYjZ6UTNGBSAGW2e/gXO2+CqhUcbgDxvSt0fWk7WO89yDv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT5PR01MB10946

On 2025-08-29 14:44, Prakash Sangappa wrote:
> 
> 
>> On Aug 18, 2025, at 10:13 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Mon, Aug 18 2025 at 16:15, Florian Weimer wrote:
>>> * Thomas Gleixner:
>>>> It's trivial to reproduce. All it needs is to have in the source:
>>>>
>>>> __weak ptrdiff_t __rseq_offset;
>>>>
>>>> w/o even being referenced and creating a pthread. Reproducer below.
>>>
>>> Well, that's sort of expected.  You can't define glibc symbols that are
>>> not intended for interposition and expect things to work.  It's kind of
>>> like writing:
>>>
>>> int _rtld_global;
>>>
>>> That's going to fail rather spectaculary, too.  We make an exception for
>>> symbols that are not reserved (you can build in ISO C mode and define
>>> open, close, etc., at least as long as you link to glibc only).  But
>>> __rseq_offset is a reserved name, so that is not applicable here.
>>>
>>> The real change here is GCC changing from -fcommon (which made a lot of
>>> these things work in the past) to -fno-common.
>>
>> Thanks for the explanation!
>>
>> So the only way to make this actually work is to revert that commit and
>> the folks who want to link that statically need to come up with:
>>
>> #ifdef _BUILD_STATICALLY
>> extern ....
>>
>> #else
>>         ptr = dlsym(...);
>> #endif
>>
>> or something daft like that. A proper function interface would avoid all
>> that nonsense, but we can't have nice things or can we?
> 
> 
> Could the rseq(2) syscall itself return the already registered rseq structure address?
> Perhaps a new flag argument to the rseq(2) syscall to query the registered rseq address
> or return the address of the already registered rseq structure when it fails to register a new one.
> 
> Application can call it when the call to register a rseq structure fails.

There is a ptrace(2) PTRACE_GET_RSEQ_CONFIGURATION to achieve
something similar. I don't know if a dependency on ptrace would
be acceptable for that use-case though.

Thanks,

Mathieu



> 
> -Prakash
> 
>>
>> Thanks,
>>
>>         tglx
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

