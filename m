Return-Path: <linux-kernel+bounces-768100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5F6B25CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6331888AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057526D4DE;
	Thu, 14 Aug 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kM98HfW+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MB2you/H"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755018DF8D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155927; cv=fail; b=ESqJ1ajlePRKwv/yfCRHyen1tO+pG4+YVgZBG5b+FR8YOALYPIp8h/Jg3XlZ5LFBxCxv1fFOSWMOkC2H0jFNTZ/CdRVGn4CDkFN1mX8qdAFPPRp8ayHP2RppgMkwu/ZBqb0wqOho9Vl6xJ2XWWAoFArFU9tiUhps4n3rBwNUcnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155927; c=relaxed/simple;
	bh=dc5I2/EZVN52qKAcNwn3f/L9WSy7hdj86gyI6G1DHuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJo8tOeG+G5PmqHxWzl/xNoSmwGFpCoXKVkcPVgp6pH1LIjMcHv7uOT5cfJCTcBvEiGbTqQHezY/BZgc2RKwrOMmMvlcgD9CLQyB1+Ruj0tf2SVfdI4O6ZLBXVUVllQdZcS7zZ0spGPcDE44XlVR4Gj7fxRABu8KlHXRnlZbkq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kM98HfW+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MB2you/H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DLu4Ds022346;
	Thu, 14 Aug 2025 07:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dc5I2/EZVN52qKAcNwn3f/L9WSy7hdj86gyI6G1DHuM=; b=
	kM98HfW+XNbgLV3M1AuMTn3aUJp1c9RtNnT/h1Q3jyuV60Jrr8ejffivGBVrB+VC
	K9er4JoM3yDntewv/5pzKpiAMO5Zl3L2jHul1Zl8JgA+S+C+45gOA/Fgt9Kzki5f
	Hn3TacOpA/EwhsRXzwwTlgZQv7sQgTWcTMIwrqVKCTaYYNTrZ2kSm2FAw8MBz1kE
	qkNMauRt+8ZbPQw/w4vnzNRsl4j1wHxYqmv5RoA6f3zjsYp14QRivoP0JsvvWlRP
	CkvlOJ4YFUJ/BMgKKfCvKe4/DprMXlyCiAzTiE+4ZVgukcaoHcxzs2bPOX7v/leK
	hL70hMzInq+La3UFrjC+AQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw45181x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:18:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57E605MV006559;
	Thu, 14 Aug 2025 07:18:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsc6w9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Aug 2025 07:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvUUALvzAKy95yBhwu908BpnmXntlbX9ojZxZRmRZ0VGIy2Qx2vf0aX5ZWRK8crzsG5Ra+K+d7Dd6fkMd644eSs0X3o6KptIiW04141NzcqGeB98NPSRksHGe8ciS6bR9oTLekDMGrFKiWaRhU1wfIV7yjnZfMvT4188O8jvPtqQi6IguBmXL7NTKqsf0E9vxZ2+EmyqIF4ttVChhZRlktMXIanT1Dc58FL/ZbOAUSD4JAKJhPJcL7cSqKezY0tSvFHFHPB0AO6P2CCqkvv0mAVXDoCaf+ioJpASD4Vhs8zO/SmfRCyhZZKkUmm1f9/wP1S1VbK8S2uiM8GthaiGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc5I2/EZVN52qKAcNwn3f/L9WSy7hdj86gyI6G1DHuM=;
 b=Sb8uflQ/zdbRG+Vc2HGLPLHVJJwadbI2HybnOvEnRlNvJv40iLtzPGKWWfq3NyclmrG2iRB7EUqDmzO/+R3iXCh1oeU5gyyDfESL/fi8TWQPIpk6ufYLGTkZgGnvK9xzfEzWtTfgm0k1MP0pEaRnBewsYYzAmSlMfs87ojnH8h8CKgMZvDFx5zUsU0B/Z7RooMMFcB1F3vigwfkHARCJy0Cq9k7LlI5OJsuW3aCG5klIDQp6XqCKgR5jgAhD4bglO+2Uar2VTBv2sKLovMdzt/p0rVZxZaq55UC7R0dRJL27SvkZ6fguFey7QFNZLJKi2WLWSFIHjUv3BNtpwsr8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc5I2/EZVN52qKAcNwn3f/L9WSy7hdj86gyI6G1DHuM=;
 b=MB2you/HdoiSjYoInmWYCvpxMjuTlRVIukt49ojBMDYCyO90XmBSl+7Kkay/fpPlgcd8zSDlfgqbDcR4ud+w16ATKKiesZAYYY/VfL/Q0JrJOjDIUtOTy5lb/fc8OHxBkkfl6vazf0FS7btyQIo9y3l60P9qaLURKtz/pZPGKFU=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ0PR10MB6304.namprd10.prod.outlook.com (2603:10b6:a03:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 07:18:02 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 07:18:02 +0000
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
Subject: Re: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Thread-Topic: [PATCH V7 02/11] sched: Indicate if thread got rescheduled
Thread-Index: AQHb/LZRWD4e8xW/kUajTV/4QLnjF7RXPqwAgAA00oCABdxXgIAEjdEA
Date: Thu, 14 Aug 2025 07:18:02 +0000
Message-ID: <402952DE-F930-4F03-8482-E39025A6222D@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <20250724161625.2360309-3-prakash.sangappa@oracle.com> <87a54bcmd7.ffs@tglx>
 <BF199244-10DF-4B84-99AF-DDA125F775E4@oracle.com> <87o6smb3a0.ffs@tglx>
In-Reply-To: <87o6smb3a0.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ0PR10MB6304:EE_
x-ms-office365-filtering-correlation-id: 6de93ee1-f889-4e2d-1231-08dddb02b4bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUhaL2lTSENLKzFlcnJsR0xGcnM1Vm02bVhkWkVTMHUxN1o4RTVaTTdsUkNO?=
 =?utf-8?B?MHc4ZUd4RDBkeFExWjkwMUJsMUhBZU5nUGNaM2xpaTEya3lEeXp4L2xxZFdM?=
 =?utf-8?B?MnhBZ09KRHV2SzQ0N2JHNlhMUkF2NUxRa1NUUld6SzI0RjFWY3Z4aXpOTEN0?=
 =?utf-8?B?MDhpemMyVS82b3VvaHJ1cTNLMkhBQ2d6ZFJUcmtHYXRKazRwS3lLb05pMm9N?=
 =?utf-8?B?aDJCRnVZakIxVlJTMmtJaEZqenl3L3ZCV21DcllEMnkxRnZXcHZ6MDErS09q?=
 =?utf-8?B?SkhqUGczNERTUDhueXRBZUw4YmtCaWVrazc2ZVRldWJZaTE5ejZRbCtXZ3pn?=
 =?utf-8?B?RVJ3aTMyL0RRNU9CNnp3SVVMaHR4eE9kZE5nOFZXNVBlaG1HcUFsbWVvK1JG?=
 =?utf-8?B?WWxZbk9yQ3ZJdXo0UTVBc2ZrVWJKNkpEcjg0RXNpY3ZudjZtNk9ZSkpGZzUz?=
 =?utf-8?B?MVZvQjVoQUxscWFMUWNTcG5JbGYwSFNrcytQUXRlM3lOZENsQzUxNjlKdXhj?=
 =?utf-8?B?VDFMVHlVZjZTT3lkaWVHS3lmcWQwZjhUbVVIR0dSdEZPbEJ5TEk2My95VEg0?=
 =?utf-8?B?ZWRQVHMwdkFNMFhIOHJJc0gwejBsT2IzZHlZcVdEWEtnZWYvbHlmUHhZaGpV?=
 =?utf-8?B?RHhuRXB1a0FwRUdtbWNmeTNUdnViU1EvTlJjNWxMTW1FRWkrVEJSUHlRSTZI?=
 =?utf-8?B?TzY1TkxZbmVtL3NBTytsZURJZllwQjJGaTV3UWRoY3lDeG12eUFqNEtIZXBi?=
 =?utf-8?B?VEEzRjBUdnhickZOU3lOdWRVaTE4SHZjQnNETi9ZZGJIWDBsQ3hnYjQ0VHFw?=
 =?utf-8?B?SXBROFBEczFjNnVGc1ducmlXUzRHN2UwMjR0UUdWVThMNkVaUW5XZ3lyZzdZ?=
 =?utf-8?B?K29jM3VVcCthWDFWaUtENloyZDBzdDc4ek5MbmdsK0oxc2IwOXMwU0ZQcHd2?=
 =?utf-8?B?NHlxVGZTUExKZnRzbnM3WlFlR3dVdG1JZGxhMWtmaENvYm5zTkhPNkdwbFZv?=
 =?utf-8?B?ejBVNXdIL0lUem54Y1ZObVVjN2lYMUovR2tmSnJteTY1YkJWKy92K3NmNlYv?=
 =?utf-8?B?NVdvNU4rT3FuN3lVb0U3bW90Q3VxL2ZPTUhSbFpZWlI3UC93SHkvdmlvK1lY?=
 =?utf-8?B?RUlERnl3M0VoMnNEVUcwTG9UcENTOUhTNlZKMjNoTCtVSUxmbTZ5TUF6R1Iv?=
 =?utf-8?B?SkhRSzhwaWxLbWZyWE1LSEV6UTgxQlRuMlcrNFR2WEkrK1lyd2xuaWhENDBN?=
 =?utf-8?B?Y3ZNd1QyOTlVRUx5U2JUeGt2RTJFaHVlQ1JYSlE0STViSk1hY3ljOThDVlFq?=
 =?utf-8?B?NUh6R3FzS3hEdVFjZ1I4YVlRV1BmM01XaGl0ZzdRNG5wRmRTYkhXQkREeU9B?=
 =?utf-8?B?bGMyM3JEb3F2UlNCbUlvNlJqdjFFVExoUTVZMmszZTYrWHdFSElPYXRPQXk3?=
 =?utf-8?B?V3dHdTFsaEc3NzI3c1VaNjc1dlBHZmNpSDBDbnk0MUNXY1c4aUFrREpHTW5W?=
 =?utf-8?B?YlBkT3BXVnRPM0NReHc5b2V3V2ZraDhpWlhxWnp0Ri9UOThvSStUNmNsc0Jw?=
 =?utf-8?B?MlRoRGJ1RVZxSnVPQlB2SU5CSUFNNlh4TVRMdTRxQitMakxQNzEwTk80ZXk1?=
 =?utf-8?B?RjZnZTRnVXBEVGV0Qno4S3cwZzVxY3diTFdkNVhOUGExVzdPNXlyZmFHRkVN?=
 =?utf-8?B?NVdaeUVNcnNkeGl6N1cxNURUQ3E3NlpZem1wWWh0a0ZTY3pSN09GQ0lkQXYr?=
 =?utf-8?B?cTRaZERUaGExS2E3OUF5U2g2dmRVMytPOCs0bU1TUHFSLzVkcGQxbXdPWG5Y?=
 =?utf-8?B?Ty9JdW9vRFIrV2w1L1NsZ2ZlandJc0tlNlgvcDQ4RFRRNzhYZ2ZLRGh0c2dn?=
 =?utf-8?B?Nk43UjgzL2x5NFZGOThwemFvV0s0Um9DcWQ5M0I4YnNwbmNjend3d3h3bHFy?=
 =?utf-8?B?RWdURjdRQi9CMlk2WXYvNzZwZXJIZm9VamF0VGhPbk9VWWNHa0RxZXpWVzVk?=
 =?utf-8?Q?DflmYM6d2qBTELIcr1KUpENoyj1L1o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnpwL1ZvajRKUGhhYzJsTTQrMEt2eDJhKyt5UGNNQW5WMTVJTVloeWhnSFNZ?=
 =?utf-8?B?cGtZMlpyNVlDZllKd0UxVkNMRm5MQ0tzakkyQXpqODlLaTZPZzZMWjRDdTBO?=
 =?utf-8?B?L25XYWNyV01tUmZWUmI1R3Yra2xWWVZUU3hZVm1sR3VnZUtSNG9LMy9IeU5M?=
 =?utf-8?B?Y1JDcDFVeldDelZ4SnVTSHFFK3M4b2N3R1dOenJIc1VTOGFvWW9HOW0vTjBH?=
 =?utf-8?B?QnZCT2tUeS9ZTnlmazZGS0VHNVpTNzVmK0oxMDJ6NkRBSjBhVFd4U2hXcGR0?=
 =?utf-8?B?L1pxZEVoR2t6Z2tsQWdZelhMSGpOZ2h5N0Qzb0JmOFB2Sno3WEZTSjBibUt5?=
 =?utf-8?B?RmZ0UE1KckFqQWpaVjczano0d1FieUU3dHFXTEJhTlZIY1orazR2Ti9PbGlC?=
 =?utf-8?B?M1N4bWNreGVFZTkybDJmMzBjc3kzWnY2YzJMZUJNclBhWENKbHNxclFBcC8z?=
 =?utf-8?B?ZVNQSlJGY2ZnK2p1eUVYelVuYUlGWmJYYWdBK2xIWmVxODNMZXY1Qzl2Y2di?=
 =?utf-8?B?Ny82M244dTlXMmk3VVdXTFFZRTgvWVhiblhvVENjVWVST0tuZE1VUDVpU0tG?=
 =?utf-8?B?MmY5L3JVckQrSGM0Vkl3SXJxR1E5WGkvYUFuTndTRVE4U2Fnd0FzcVVOMVlL?=
 =?utf-8?B?cFN2NjFhOVIxOUw5Qm5lejlobkYxRGlVcXZ2WFdzWDRGUkw4ODRlY29Dd3I1?=
 =?utf-8?B?Ujh2QXMyUkhTQ1QxUkxwTDlYNk5RT1NVaExwdXJXZlNlZVprd2JORWdQaEYr?=
 =?utf-8?B?M1NaSXdVaWRXZlNsVzJ1cFNQUXM5NHVNcnFVQWJHUnNNRVV1ckRBZlN4azhh?=
 =?utf-8?B?ZVFUUHkzRXNuNExOTkc5M3dnMlpHM2tlS1g5c3pPT2Y5SVk0U1Z5cUg5dXE1?=
 =?utf-8?B?ckJTV2dYTHd4S1dFZWhySlRRRDZiZTRzWWh4aGtkc0g3L3I1V3RRSVE4b241?=
 =?utf-8?B?NnZqdXpaaTI4eko1WlMrWUl0aHdqNzRQUlErR3JYWVRFaWxSWDR6eHRtZnkr?=
 =?utf-8?B?QkZwdS9lMkpLMkF1anlpV1VvcHhwcFcwWmRCcTdiSThqL3lmUXN1OS9ZbGFS?=
 =?utf-8?B?cjRSL0JRWGZLSFc2bG42emFkOGNabFEvYnlIV2VrMUtRc1JqblJjQWY0YjVu?=
 =?utf-8?B?RTFBclVUQUFaa05NSEZTL2ZDOUNVcllTUnJsaFdYSmlqMnBGWFNaSDI0UUlv?=
 =?utf-8?B?QUhXZWloV1JuRGlIVGxhaVUxN3JsclBFVC91QjBDdy81RHhqZkdjS0RTQVZ5?=
 =?utf-8?B?ZGtoSitQbjVpR2R5V2Rld2RQRllzQWc2cElJemJNa013N0s4SDE1eFRWSkVy?=
 =?utf-8?B?TEFlUmJmUngwTTRFVjVTckx5c0k0WFhxNTllcHdUcFd6VWNtUWV6Snk3VmtK?=
 =?utf-8?B?WjVVVXgyRFdkaFpOWDNKSjB0MHdiT2Y4dnQwME10RXN0NjBuZ2MyN3E0MXNn?=
 =?utf-8?B?Q0VtdzdjcnRyODdVekhJQzljTU9YajRZMmM0M29PZC9ERFN0VDhpQ3VaVUlN?=
 =?utf-8?B?S0FWVFo3SzZROSsyeDdQRklRM21ZTFN5QTZ5NHlHdEkyZ1JKaHdKa0tYSkRk?=
 =?utf-8?B?c0tJM3VrRGJpYzdyak1yTHNqcGlIMkpUa0J6MnJ3SStkbUFKZnhNMkc2bWx5?=
 =?utf-8?B?THJhZmttSlMwbjhlek9jenlGb2hqdllEejRJdyt4Z2tUeHREODl5WDNqNFlS?=
 =?utf-8?B?RHJpSDZnbFpOWHFPZTM3ZUpnYitvZnl5SC9JS0xHWFZBRDByNGtzVmhpdG5x?=
 =?utf-8?B?K0ZoSFdTWFNSWEE4WkN2L09hNHpCUzNyVGVBcnRQeWp3VTl3Vjl3N0VYUUFI?=
 =?utf-8?B?Yk53YXlUYnFxdnNJeFBjZlA1VXcrU0hWRUhDVFhkdnNoMDA5SkJBdFY3OEhq?=
 =?utf-8?B?b0FkdjNmL1FKQ0dSaEJ3bFNEZUQwR3I4K1cvdFpIN1I5S1FoTkEyUDRqUXFZ?=
 =?utf-8?B?d1B0Zm5qdmdBeWQwalVRczc1ZURzb0s1Zk40ZThTTTJJb244V2FOOSsxUUxJ?=
 =?utf-8?B?TVo5YVY0T2ZDN2ZjeVZVRnBqMTZFQ3hIOHpOQmJQdVRSakt5bFo3QkZDajZa?=
 =?utf-8?B?UzhrQksxSnNxSEZKTC9BUDh4aDBiMVh4TmQ5RGo4ZmVySitQV2RXOEMzaGts?=
 =?utf-8?B?dld5YVIxSmVpakxwNDZENytVZXVMVHRKT2dMbC9wOHU3NmpES3lrQUx1c0oy?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F31508BCE1FE04FBA0C8AE9BBFABC3D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qxLVqvuOa/yR+bg+HF0fpOKq1EhbS/uuwTss6talLipC91onuXL2en2pAQT57o/J6uJo2eOlNwEEphdJ02btV/FFE1Pd1DGiRzsFEnK6cA4dytumAK7UxYfy9q8ez58m89eNNpmvmXoNxod8emASaZYpniidQLbc2Ml/WttuHA2FK8T2njydifA8rGpN4AWF+5Vg4z/QM7n9TX8aHMFnEmYHYaZn5et7UmIwjqSbDQabdVplYA5IQVxDjAjBmYJA7puShhA/VrYtFYa7DI3In0YSsNIoytAq6RirM9/lnU3kScvUpADErfDFKaaB4hRv1IkD8Igw00ddm0rcFZEthExxn+ryC1FbLKEHHR3GNQQis6plfetu5VdP9g4tF0XOgWRj0VVXCyQFwnBVlvBDf90WKbJVOj+DOaneDsZTaWNmiVXt7VfISxlqDDWWXWq/GuPcnwezrIuUEyp/kd0hiaa/VW9SOM0t4eby5+IOktwi8Sygm78V7iSxFWcY7I52DE2VBZV2LN0Rxz15qRZQmdgc04ahy9PqQ5K8F/ZDD/orwomEWqqnebmlu3lVInCkZlpQX3LTVjcwVqbncyh3yyFEEeDkjzIaOBihH2kg9YA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de93ee1-f889-4e2d-1231-08dddb02b4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 07:18:02.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iS43YnAxRl9fZjhK3jOjjJWsx4q4EtmqexQKfYlNKNNgG8BGcGqExke6V+nYG+jrNBku5/AYkNb3RV9y5vDuys2TgUZ4Gkom6Rsnuvdm8Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508140058
X-Proofpoint-ORIG-GUID: VOe8CSyi3cvIezZ2HYoNPOPIh--ySkCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA1OCBTYWx0ZWRfX1Q9olRmjdd6g
 5FEjXsS+Ae7YIU2pUd2LgZjiztYmuVEVs4yEFltXgfgAODnyyrQphJqusVbGQxdxGjKg6yVyn2m
 5GWT8Om2FrFPOG6EePBI6LBOOjESgvi9IemRA/cwi98V0dR4Y8DnAeSEv/6Y6CZP2kLItW1CCDC
 y3ocxQkFtSpOC6b7qfNEd0MYPwaJz642Izpdwzmg1XYZeXJLEovDzIEnTpl7tRri+IOJr9sYJLH
 YqIalEh5sMSfZ3OYKm/DnPZmJBWLPM+7C/Qws9h9ygGj/RWE5qCerhQwWtUI0/dTw4Rz+e1mhap
 Fyfd/HYHhxwsEE9FNobj9bzy0sgFPc8NZWk1IqlMdpYsB96HyNZJlJkbZEXUHnJDYF8TkfjLJdn
 MdRc0Uml+88hfcHiAn8w9xje/3/WzzvHPJ8jxg71RKDp76F+R6FMfPpjwbOOrgYzL8r3SWF7
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689d8dc9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=06Dfq-3ZSPfIlx2fBpEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: VOe8CSyi3cvIezZ2HYoNPOPIh--ySkCs

DQoNCj4gT24gQXVnIDExLCAyMDI1LCBhdCAyOjQ14oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXVnIDA3IDIwMjUgYXQgMTY6
MTUsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gT24gQXVnIDcsIDIwMjUsIGF0IDY6MDbi
gK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPj4+IHJz
ZXFfcHJlZW1wdCgpIHNldHMgUlNFUV9FVkVOVF9QUkVFTVBUX0JJVCBhbmQgVElGX05PVElGWV9S
RVNVTUUsIHdoaWNoDQo+Pj4gY2F1c2VzIGV4aXQgdG8gdXNlcnNwYWNlIHRvIGludm9rZSBfX3Jz
ZXFfaGFuZGxlX25vdGlmeV9yZXN1bWUoKS4gVGhhdCdzDQo+Pj4gdGhlIG9idmlvdXMgcGxhY2Ug
dG8gaGFuZGxlIHRoaXMgaW5zdGVhZCBvZiBpbmZsaWN0aW5nIGl0IGludG8gdGhlDQo+Pj4gc2No
ZWR1bGVyIGhvdHBhdGguDQo+Pj4gDQo+Pj4gTm8/DQo+PiANCj4+IFN1cmUsIEkgd2lsbCBsb29r
IGF0IG1vdmluZyByc2VxX2RlbGF5X3Jlc2NoZWRfY2xlYXIoKSBjYWxsIHRvIF9fcnNlcV9oYW5k
bGVfbm90aWZ5X3Jlc3VtZSgpLg0KPiANCj4gSSBsb29rZWQgZGVlcGVyIGludG8gaXQgYW5kIGl0
IGRvZXMgbm90IGNvbXBsZXRlbHkgc29sdmUgdGhlIHByb2JsZW0uDQoNClRoYW5rcyBmb3IgdGFr
aW5nIGEgZGVlcGVyIGxvb2suDQoNCj4gDQo+ICtib29sIHJzZXFfc3lzY2FsbF9lbnRlcl93b3Jr
KGxvbmcgc3lzY2FsbCkNCj4gK3sNCj4gKyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmN1cnIgPSBjdXJy
ZW50Ow0KPiArIHVuc2lnbmVkIGludCBzbGV4dCA9IGN1cnItPnJzZXFfc2xpY2VfZXh0ZW5zaW9u
Ow0KPiArDQo+ICsgY2xlYXJfdGFza19zeXNjYWxsX3dvcmsoY3VyciwgU1lTQ0FMTF9SU0VRX1NM
SUNFKTsNCj4gKyBjdXJyLT5yc2VxX3NsaWNlX2V4dGVuc2lvbiA9IFJTRVFfU0xJQ0VfRVhURU5T
SU9OX0VOQUJMRUQ7DQo+ICsNCj4gKyAvKg0KPiArICogS2VybmVsIGludGVybmFsIHN0YXRlIGlu
Y29uc2lzdGVuY3kuIFNZU0NBTExfUlNFUV9TTElDRSBjYW4gb25seQ0KPiArICogYmUgc2V0IHdo
ZW4gc3RhdGUgaXMgR1JBTlRFRCENCj4gKyAqLw0KPiArIGlmIChXQVJOX09OX09OQ0Uoc2xleHQg
IT0gUlNFUV9TTElDRV9FWFRFTlNJT05fR1JBTlRFRCkpDQo+ICsgcmV0dXJuIGZhbHNlOw0KPiAr
DQo+ICsgc2V0X3Rza19uZWVkX3Jlc2NoZWQoY3Vycik7DQo+ICsNCj4gKyBpZiAodW5saWtlbHko
IV9fcnNlcV9yZXNldF9zbGljZV9leHRlbnNpb24oY3VycikgfHwgc3lzY2FsbCAhPSBfX05SX3Nj
aGVkX3lpZWxkKSkNCj4gKyBmb3JjZV9zaWdzZWd2KDApOw0KPiArDQo+ICsgLyogQWJvcnQgc3lz
Y2FsbCB0byByZXNjaGVkdWxlIGltbWVkaWF0ZWx5ICovDQo+ICsgcmV0dXJuIHRydWU7DQo+ICt9
DQoNCklzIGl0IG9rIHRvIGZhaWwgdGhlIHNjaGVkX3lpZWxkKDIpIHN5c2NhbGw/IFRoZSBtYW4g
cGFnZSBzYXlzDQpzY2hlZF95aWVsZCgyKSBhbHdheXMgc3VjY2VlZHMocmV0dXJucyAwKS4NCg0K
QWxzbywgaXMgaXQgbmVjZXNzYXJ5IHRvIGZvcmNlIGtpbGwgdGhlIHByb2Nlc3MgaGVyZSB3aXRo
IFNJR1NFR1YsIGlmIHNvbWUgb3RoZXIgDQpzeXN0ZW0gY2FsbCB3YXMgbWFkZT8NCg0KSWRlYWxs
eSBpdCB3b3VsZCBiZSBleHBlY3RlZCB0aGF0IHRoZSBwcm9jZXNzIHNob3VsZCBub3QgYmUgbWFr
aW5nIGFueSBzeXN0ZW0gY2FsbCANCndoaWxlIGluIHRoZSBjcml0aWNhbCBzZWN0aW9uIGFuZCBp
cyB1c2luZyB0aW1lIHNsaWNlIGV4dGVuc2lvbiwgb3RoZXIgdGhlbiBzY2hlZF95aWVsZCgyKSAN
CnRvIHJlbGlucXVpc2ggdGhlIGNwdS4gSG93ZXZlciBhbiBhcHBsaWNhdGlvbiBwcm9jZXNzIGNv
dWxkIGhhdmUgYSBzaWduYWwgaGFuZGxlciANCnRoYXQgZ2V0cyBpbnZva2VkIHdoaWxlIGluIHRo
ZSBjcml0aWNhbCBzZWN0aW9uIHdoaWNoIGNhbiBwb3RlbnRpYWxseSBiZSBtYWtpbmcgc29tZSAN
CnN5c3RlbSBjYWxsIHRoYXQgaXMgbm90IHNjaGVkX3lpZWxkKDIpLg0KDQpUaGFua3MsDQotUHJh
a2FzaA0KDQoNCg0K

