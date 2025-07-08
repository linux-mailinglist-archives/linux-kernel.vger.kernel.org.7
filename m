Return-Path: <linux-kernel+bounces-722089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7838AAFD53A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B163B99AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BD2E5B08;
	Tue,  8 Jul 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q+brptDB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqgzSdKo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FD1F91C8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995420; cv=fail; b=uz2DWbAf9J/ecimDLYtxzbK8CzoIZy/9R7G8Qz1Y76ideP6IZxKVIrWPlEoUhDi6RAfBUBg9xgciHtUAZ0ozO1Q217n2fP+ALEo6CCVKrK1UrEcCGYJWqMaPYiuv2JPlbEK+7Bl6lp9Ba8TrlWzmZEy0SODwdz+0DsssL+NUcrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995420; c=relaxed/simple;
	bh=tW4cyERTIOXQ+BFpxgVjORZRSQsHYR96+iCHyYCKwNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6UCzneAdmi7dVp53wNg8KKKBhb6arhtcWt46wkziuJ/ywfHJ7RFj1AvMhnOqEVT2jdfFhIAtUm/33wmOJTkq7OFEaMgXTbNJ4osH1WHo1Bxylnf/PcYUWEwshp+FNDDaKhU7FMPUHBc3p7SxqECOt7Qxih90redCEx4dttn+mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q+brptDB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqgzSdKo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Gb4b9013589;
	Tue, 8 Jul 2025 17:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=roqJoO6+LYCi7XRWxWS0GDAP8j99D6l54l94RFTJ748=; b=
	q+brptDBJih/woGr1eCermFgdncoXXSTuggiqjLUfja995vxn8Xcon1A/C9bASgK
	fOELkJ/f1RcUksKgxPz9QIzMR1siR6zv5FWUZkLKNx1IJmXGNR028jp0ITl+6KPh
	b1+Eruj9y1BRAN7BXGTI9GwbcGMGMYCqRAEsrtN14iiSQ8mtm0PdNhTmxI+KamPO
	seAaZ4ct+qSTovNafo6Bsfyxc9lQ4uigGvaEFRhrV3+ptzTBGuJsS44arE6Tp6gs
	n+QCAjY/WVXs40G33ysZgyjxySb9hH/mdRvJhIIzApbDKe6b4oQUhiuugF4GIuZU
	NPqVYOS8ouo4dYKbDjN7sg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s70j02vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 17:22:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568FfYR6024391;
	Tue, 8 Jul 2025 17:22:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga5jpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 17:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhZ3JWZsTnTfgh8A19glyQkIfD0dhbSYuGMfY0MvkypyUopIU+6mVG0EsFRmD9D15imNOg5bX+8RyTy3H4WpG9gfz5j5cAB0cupmoFA7BtAKeazzNItBNYYS4S5Kjo9R7m9CWuAodfCvWUdHgDuZlHCIJNOAdw6ZUhErcjdInqyXQ3ZfDHnwPktFTNHG160Zeqx8dYOmKHJcZozcMG59XuGvij3bdFFIv1KztfRkCrCg5CUzTgKdDW2I4x3BVdbqpljyl2NGFnBXYkLbciBe5D52JY1zrgPQiFqnhuJS95suhgZMbrHKJlzPbKW3qYZn3d61qeaP6yAeasNEWEfWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roqJoO6+LYCi7XRWxWS0GDAP8j99D6l54l94RFTJ748=;
 b=bGP1qM3G+XLPPQpgvP/egBeOdUtPlS+bwDaiPEaltpzpnfBj+LMkTbSZbG0OOQe8tnHKE6IpXKh6jNr31iVvlSc552O7InSMYFks4v16dkyOtRXoBCFSDJzuabvIJmb7s8YruaFojXVxtsj5ExxTCKkIQuMrZl+bHWSA5yqhhue8qkFSW5t8QTi57LdiGceduDCSD7opcEq1PZwNg0JsxdttcMn/AzNPJkKgY9g46ozEl09u0G8bQtQ+MUjMewMmt4gpj7c+69yMChOL+M88AP8Yv1EYb6GFJN3hKki9etPcQBiIYqV4UXZcghFUKOQQGF3pq2QKp/4G65Hq4yDwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roqJoO6+LYCi7XRWxWS0GDAP8j99D6l54l94RFTJ748=;
 b=bqgzSdKo43yUIogj8K/qFToCDViihbCU6sSGTYgA46YxsLLX5xYVfWc7xgP4l9jyuf9+Rze9qvR5UOgFKoDGljy3oVpVWU1xKM9feybMVUaCVcJovdjO9NI1Zz2myuzvgCqafr7byUmGiZJy70e14uDjkmgjRLHTx9GKKLJOFXc=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by DS4PPF92DC283F3.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 17:22:42 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 17:22:40 +0000
Message-ID: <9e78f54c-f993-4505-814d-b8815f5c6bf0@oracle.com>
Date: Tue, 8 Jul 2025 10:22:36 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
 <6a36eae1-7d1c-4c23-aec3-056d641e3edd@intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <6a36eae1-7d1c-4c23-aec3-056d641e3edd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a35ff2-c8fa-4123-2cb0-08ddbe440ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTFTTDVOMlNvVTc0YlpIQXU0N3BGR0l6MWYxNGZmRlkzQm9XOW0vZHl1VnQ3?=
 =?utf-8?B?YTFRVkFPdWtzSEFETjVYeUM2bU1aYVZEbm1QaHhZZ3dhTzBkL1NaR2YvQ2Fu?=
 =?utf-8?B?TVRhQ3diTERocmlPK2RYUENubnRkN3JPem1mQVRVQ2FjRmx6YmVGZ3R4eFNH?=
 =?utf-8?B?VXJmR3FQaHFBR2tYOUlQd2t5NHhieWd4SUFNVXptNlViZCt2eUQwOTVRS3ho?=
 =?utf-8?B?dWZnRW9yYjYxZy9BQWN1Tmh2bFNSTndITysvZDNvdGZUMEg5RTRLYU45Vlhq?=
 =?utf-8?B?UDdPYjBhWC9ZeThmRVlTbWJpcHdWSlRJNUhORTFmaVJ1aVlpa3BjdFpZUzFB?=
 =?utf-8?B?T0hNN05ONXRaT1p4QnUrSUVwTkRFaHpUNUdpM1ZjN0dab0VMakF3MHFkZVQ2?=
 =?utf-8?B?dTJZZWxiYTEzbEwxbm1wYmE3ZWNERFYycXRwUGtzaldyNFMrN210R09UclBu?=
 =?utf-8?B?ajVTSHJYbFFmMnUyY01sOUlsRGUrN2Z0c3RSUXdFeUhkQWlmZm9KN3REUXQx?=
 =?utf-8?B?ZU9PM2NHd0JNdlozWlowTjBsWmtCeGEvbTBIL2wvdDFaTy9yNHRiU0VWZlht?=
 =?utf-8?B?ZWNtUG9wbzQvN0JnV2ZzUjFTay9QU3N6Y1NTSUs3b1dmNGlRbDNlQmRVTlpr?=
 =?utf-8?B?VDI1dHdwMmFtUE1aa0dsbU8va3FzZDdleW13UFE0eVEwWGpkYXVxOXFQVysv?=
 =?utf-8?B?MDJ3cVFRaVVyQ3l4aTNlZUdwM1ZoNzhoNUJiYUlzLzBuZ09xa1hXVlFaYkt4?=
 =?utf-8?B?bkJKN2dtWm1SbmhSZzRMZzQzRW4yNzlwSTZoQjB5SzlPUGtSUnU1THRKYkIv?=
 =?utf-8?B?bVBReG4zTnE5bzNrMVpONjRSU2xzQlFMakJJVVJwM2RTR1FwaGV4UVFPNSsy?=
 =?utf-8?B?My9RWSs4U1M1NnFqZ0hJT1ZTWGpXWTV4UTh1bjk0REkwQ0wyMk8rcjhKTkJT?=
 =?utf-8?B?QzdxajQxZEExR2ltNU5OTUNiSC9yaU9HN3NwdXNZWnNBQlhYdk9oWG1xcVlZ?=
 =?utf-8?B?Z2ZiVjJyWFNmTWlENEhpSVRCWHdNbVZIZUFVY1hZdmtBdlNBU1loMlBnbys2?=
 =?utf-8?B?MjY3Tk9YWUNlaEpyRUlHLzZQZGpERXlDOS9tbmtTQ0FWbmF6a0tFMUpLVHly?=
 =?utf-8?B?RjV3b2cwOUVkTUx4UHNweFNUSXh4N2w4cC9XblRzL0RMUkJ5QVhqZjJnU2dS?=
 =?utf-8?B?UGV4bDFHRXVGMzY2RElqdkxwanhhUmxIVTNOd0laMmRON0RQNnNrejBVS1hH?=
 =?utf-8?B?aXdNcFU5b2ZJQWVIWlByc3hKd3gvMjRVUGhaWlhlZkczQTZxSzlHTlh5Nm9i?=
 =?utf-8?B?V3p4VTFRT1R5Y2NtK1JlZHIvWDExVDhQVktZS2lXQzdEbXhXbVZ2NlBVNWpS?=
 =?utf-8?B?ZzFmOGJMcU1Va1VKd2Z5bnVmWWd5anBQeDhhRXRrcit5bFpMUm5Hb25SbnhO?=
 =?utf-8?B?d3RnOG1SZEF3L1NESnRQazVnQjY5VTFYRENuRHBORnMxdkM3SHZSaWxhU0xN?=
 =?utf-8?B?NGpzU3o1cjUwQ0FPNkRWV0ZoM285UGlxODlnV0hvVVNLd3RtMkF2L3RVVFlR?=
 =?utf-8?B?QldnQzNrWGhQR09TMFppTnFzdkFxT29ucTJ4YVlGcjlMeWpLMFJoOERxQkYy?=
 =?utf-8?B?U3dLRHE4ajhqcnJyelpRWEhwZ3FhYXdrc0JjZktIUnZmOUhVZVJTNFUxVzRz?=
 =?utf-8?B?YmhxczZuNndMRzZYb2Z6bEczbDJCMm9sQ0JaQmpLUEt3bEViNVp0ajBPdVdj?=
 =?utf-8?B?RmwvMnhMcFVZWUJlREorREFlaGdPc3JNTmRrU3JVVkZ2L2JqaEV3Smh0SXR1?=
 =?utf-8?B?MkhHQzl1MUZoV0Z1TjJwV2RSREVDemR1V2h0aFV3bkRURVdOczB0T2JURjVh?=
 =?utf-8?B?ZG5lWU8wcUZHK3AxOVB3WUE3OXlEUEFwbUNSdC9QMXkvalgxdTlicDdQVnM5?=
 =?utf-8?Q?0TX1OGy5oHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTdQL0tZVWRFbjZyejN0VHFRY1k2K3pscmljYTQxNmZIclAzdjRYeW1SNVFq?=
 =?utf-8?B?a21KdzRSTFZhamJDOU1hMW1malA5VFJ5S2lLY05SejhTVzAwT3JRY3JRUmts?=
 =?utf-8?B?eEwyeUxtNEtvK0ZkQ0NUbjRmL2xEcDV3ZEV3MXEvT3BhZjg2dkFWQlE2cE1u?=
 =?utf-8?B?VjllWmVXaTNyNjJHeUlOZzZRMXBGQURESGFPaXlLR1kwa0RYTWpjS2dyNGpl?=
 =?utf-8?B?OXRoRVRqYndJUWc5ZGExeVA1bmc2SG1KeFE3a2c0TXFDRmwvMzE1bDlNUjIr?=
 =?utf-8?B?aldlalNKdGdHWFVTYzJjdFpSdDdNWW8wc2Viak5iVWlIYWdJb1NHWXNBdzYv?=
 =?utf-8?B?cWovK1h4TmYzSk5TYVNGMHpYZlpwbVBDcEU5aTJKR2pJK2xkOFV0bkNZQkNi?=
 =?utf-8?B?WEdpVHBFaG9XZG9zd1drYW5rU1M1VCtEbzc0ZEpvR1hSYzllRWxPaDAvRksr?=
 =?utf-8?B?aHc2ajJBSVIxRzFreDhGMnlWcTFEcW84dXlNZnVGRkpqMmp4SXFXZEZIVXYx?=
 =?utf-8?B?bGE1cUJtRGp2VFZOTGpXN2RSNFloN3JvRHdJT3lobktXcit0SGhhTldLbjRa?=
 =?utf-8?B?UnIrOTl6Q2p3MWVOK2RjY1dUQkdiR1JRZTNmcFJ4NmRKcGIvaHlnME1ZWE5U?=
 =?utf-8?B?VWNIWXk1ZDJacXBuQzdyOHorbmRRUUtRSXkybktleXltWkxTV3hOd1M2Z2Z3?=
 =?utf-8?B?QVRTaFBIZHVEOU8zaWFTZW9RMUE2cnVFSzFLQ05Ba3BZaFZyUXl3L0o2SzJF?=
 =?utf-8?B?Ykd1REhDbk1WMExKS3Fhc3ZEYTlYOW92RDNqeFh4RElwZm1hcW1ISnhjUm5n?=
 =?utf-8?B?Smw5djZ1ZVlZRXFwVVhzUDFCMjJ4Z2krY0pKL3pwbGxOMitCL1hiaDI5dmI0?=
 =?utf-8?B?TXJQVGk3MWNDNk02OUVjQ3hWSStHSnVKS09oWGdpQUg1T1ppejVIWGd5Mlp1?=
 =?utf-8?B?dlBwRTZmRFNSSnpVNm14cHA5S1NsUy9SaTFNdXdtekY3UTZrOS84N09vbHJS?=
 =?utf-8?B?bUNDa25hU3dsYlZLTHVTMFlzWXdxeXJzMU4vSnBEbldVSUp6d2c0Vmh0SXll?=
 =?utf-8?B?dUQyd2lJV2tvNFZqbEZHVDlYV1g4cnRsR2hpYXpTWVUzVHNJanZnU0Q4NjNG?=
 =?utf-8?B?Y2dqK3ZEMWxtNTZSMExKamoyVzl2YWtla0JwV1k2OE9Qa29mNE1lTTBHVTFG?=
 =?utf-8?B?T1BrTE9vbDRqYmpPNVZSeXJHamxSQnRoNTk0SjNhOEE2SWN3dkduUjQ4Z1d2?=
 =?utf-8?B?YTJ2QWgxY3FUa1NkQ0tldFB1Y0FLTXVYQ0hJdUpTVCt3clZWVzRQdzZTT2Zq?=
 =?utf-8?B?WWlvdnA5WW1OUnVoQ3pURWxXUVByTmRWQ1BCSjhoYTB3WlI2SjR0dGd2VTNK?=
 =?utf-8?B?dzd5dEJXY3hSZTNiazlpRWllMTk3M0toeHh2QUhYeTdGOTJIRXZMOWVmTEUy?=
 =?utf-8?B?RGRIdjhRRks4UTIyczc3Y2Rvb045eXpZbkVKZ1VJVWROajNHdWVjMjJhQVY1?=
 =?utf-8?B?eXJLVlJxUFpITDRxRHA2NWZSekJka25taDkwUHlidWFTbDZJZkJ3enpPSjdn?=
 =?utf-8?B?cmJoZy9ML2J3djFMV21HY2N0Zit2Z3EwTUUvMWdscGxSRUpKeFNtR2JsbThv?=
 =?utf-8?B?R2tkSW05MEJkMzNuaGk5THBOaVFpY0lYTU1PT3FZbzduZG0wQXRrckFXTW40?=
 =?utf-8?B?SnZUN0x1NzNSeUtCV3ViRTdWUEVxR2xCRkd5alo2VHZpMk5pMExDZERlU3JT?=
 =?utf-8?B?Ny9FT2ZKM0JtS0QrS1FjczBwY0NrckM3SWhiaUxrem1vMzRYVFlWdUl4QnBT?=
 =?utf-8?B?TG52Y1FnYkcxcXJUMFVpSXJmRmtYcVFZNXl4QVg4Y3ZXN1pGbUFsTEZBV0FU?=
 =?utf-8?B?R1dPdHJTc3VoWXRVZ3Ewa2t0VU44eldBRHl3V3FFSktNQmJqVzlHbFppUmFp?=
 =?utf-8?B?RjJyOVovRWVYV1dzZ2kwNVo3SjhNNG5VQ1Z3UVY3VWpmQkRzTllOTzFVU0NW?=
 =?utf-8?B?dmJhbE1ja054aStxcnhsYkR5NHNSaU4rSFM2MWtKZ2ZxV1ZoZVRYNTZMRVAy?=
 =?utf-8?B?aHpWS0VtajZCMGhWTXpwTHZVc09XckdCR29hSUxqdW9LLzQzb2ZPdlNBWkZj?=
 =?utf-8?Q?ujTXd5NB19vKVDoNltkKlTOOG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tIqAGO8p2OeZLgHZJuTOqmyQ9WKyoBodGoWSrVwkKhFAFWpEzLEvZwqjurNmKlOIUniHMzvPBGyVUOSsDBl14J8uIGfRAqWTQVM+j+x+AI5EN9B++T6kfM4Z5lIGRytylsSNguBUqEVEIcykPoKNf9n9+oy8w9SpeAlUbiOTJ6bbvxJTcJ0cOtYd+LyJB0QHjiNjUQ+f/HDOUW9NSIYrU7J8YBaD9uwDAVORX2xVeUjtH+jPS3ieCmNyS5WqEIRBzPKkfEZOs1QuW/LNe0cE9x24N43J4KD0gHrWBLpMe/GkbfZb0JmrrdNHQNURguCKxEGmGdyCdS/AMYC7lGqUte4JfGtQPKasrICDSroGusQlNGbn/yFmg8Ble1cDGM1spsLbNP6FG++IwTBCde+XbjeVU3dNBDzQAe0cVn7/1xAGLV+dvNC0eOdtfBRJh+oJ1zasU1C7EIfcaxk8FW7otZakBv+2xUQ4VOduLR6k65v9BImvyxhB8WieBloR67VPt4Db+KH+PHJSMsKInfM+4w/QGuszc3SMsCdpKrqLyvNEk/GFpP5bjCvQuN3k3gjo9xnwWVW41rCemhmpJyJTz01GHadaQJsBImu0aAHSHiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a35ff2-c8fa-4123-2cb0-08ddbe440ae5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:22:40.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u7Aog7ALCU42stl95AXOslv/Ba8sZr4XSUI1QVfeu7PSMnQhLAmekbLhxpdQJ1ucRGX1JL2j626kFihQ0UfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080146
X-Authority-Analysis: v=2.4 cv=Io8ecK/g c=1 sm=1 tr=0 ts=686d53e6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=f1-pC5jMouwxZPuDz2kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oWO4qyuISJFxXYE9fNHzmG7jvQ25kjyD
X-Proofpoint-ORIG-GUID: oWO4qyuISJFxXYE9fNHzmG7jvQ25kjyD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NyBTYWx0ZWRfX2TsVoTQ38z+S k5lydxpnkCAPUSWXNRim7OiyKzSx3LUwC4LyITVt79zOZmJiJKfsoSDFAIpEe3jPp/0YjrUWcYy ugEes82dJG3k/HCRlFxV2qy2Jss56Wdm8LqixVA9SDc5pItoGU7Iswb7ZjMeG63+5PLF4pRvz9Z
 1pKZ6k6LG70phAYtHXs6Px4eND/5UW43AHVh8bit3Dbg6f+o71ccHgWXXfF981KeOlMb9I46L9M x+G4B09F+3wHc6K+sbpW7SX1YxUKyNfkQkjoIw/45uYmixelfZRS4sELkGYTb8oO1GglL9bx47G JVRTM0G6KC2c87UCfSnbsbc/7lxaaqjTawZlR8IiuT3+6GFcKuEXLxZdfOuaAxy9FUw46PTUqpn
 KHxI5e/aBnGPOoi7E5b7iUKTPWyDbxMVhoc+bmmuUNY00S+mLmlg4MN+SeaDuMXL3Vx1G0rJ



On 7/8/25 01:29, Chen, Yu C wrote:
> On 7/8/2025 8:41 AM, Libo Chen wrote:
>> Hi Tim and Chenyu,
>>
>>
>> On 6/18/25 11:27, Tim Chen wrote:
>>> Cache-aware scheduling is designed to aggregate threads into their
>>> preferred LLC, either via the task wake up path or the load balancing
>>> path. One side effect is that when the preferred LLC is saturated,
>>> more threads will continue to be stacked on it, degrading the workload's
>>> latency. A strategy is needed to prevent this aggregation from going too
>>> far such that the preferred LLC is too overloaded.
>>>
>>> Introduce helper function _get_migrate_hint() to implement the LLC
>>> migration policy:
>>>
>>> 1) A task is aggregated to its preferred LLC if both source/dest LLC
>>>     are not too busy (<50% utilization, tunable), or the preferred
>>>     LLC will not be too out of balanced from the non preferred LLC
>>>     (>20% utilization, tunable, close to imbalance_pct of the LLC
>>>     domain).
>>> 2) Allow a task to be moved from the preferred LLC to the
>>>     non-preferred one if the non-preferred LLC will not be too out
>>>     of balanced from the preferred prompting an aggregation task
>>>     migration later.  We are still experimenting with the aggregation
>>>     and migration policy. Some other possibilities are policy based
>>>     on LLC's load or average number of tasks running.  Those could
>>>     be tried out by tweaking _get_migrate_hint().
>>>
>>> The function _get_migrate_hint() returns migration suggestions for the upper-le
>>> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
>>> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
>>> +
>>
>>
>> I think this patch has a great potential.
>>
>> Since _get_migrate_hint() is tied to an individual task anyway, why not add a
>> per-task llc_aggr_imb which defaults to the sysctl one? Tasks have different
>> preferences for llc stacking, they can all be running in the same system at the
>> same time. This way you can offer a greater deal of optimization without much
>> burden to others.
> 
> Yes, this doable. It can be evaluated after the global generic strategy
> has been verified to work, like NUMA balancing :)
> 

I will run some real-world workloads and get back to you (may take some time)

>>
>> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE? 
> 
> Do you mean the SCHED_CACHE_WAKE or SCHED_CACHE_LB?
> 

Ah I was thinking sysctl_llc_aggr_imb alone can help reduce overstacking on
target LLC from a few hyperactive wakees (may consider to ratelimit those
wakees as a solution), but just realize this can affect lb as well and doesn't
really reduce overheads from frequent wakeups (no good idea on top of my head
but we should find a better solution than sched_feat to address the overhead issue).



>> Does setting sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?
>>
> 
> My understanding is that, if sysctl_llc_aggr_imb is 0, the task aggregation
> might still consider other aspects, like if that target LLC's utilization has
> exceeded 50% or not.
> 

which can be controlled by sysctl_llc_aggr_cap, right? Okay so if both LLCs have
<$(sysctl_llc_aggr_cap)% utilization, should sysctl_llc_aggr_cap be the only
determining factor here barring NUMA balancing?

Libo

> thanks,
> Chenyu> Thanks,
>> Libo
>>
>>> +static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
>>> +                       unsigned long tsk_util,
>>> +                       bool to_pref)
>>> +{
>>> +    unsigned long src_util, dst_util, src_cap, dst_cap;
>>> +
>>> +    if (cpus_share_cache(src_cpu, dst_cpu))
>>> +        return mig_allow;
>>> +
>>> +    if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
>>> +        !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
>>> +        return mig_allow;
>>> +
>>> +    if (!fits_llc_capacity(dst_util, dst_cap) &&
>>> +        !fits_llc_capacity(src_util, src_cap))
>>> +        return mig_ignore;
>>> +
>>> +    src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
>>> +    dst_util = dst_util + tsk_util;
>>> +    if (to_pref) {
>>> +        /*
>>> +         * sysctl_llc_aggr_imb is the imbalance allowed between
>>> +         * preferred LLC and non-preferred LLC.
>>> +         * Don't migrate if we will get preferred LLC too
>>> +         * heavily loaded and if the dest is much busier
>>> +         * than the src, in which case migration will
>>> +         * increase the imbalance too much.
>>> +         */
>>> +        if (!fits_llc_capacity(dst_util, dst_cap) &&
>>> +            util_greater(dst_util, src_util))
>>> +            return mig_forbid;
>>> +    } else {
>>> +        /*
>>> +         * Don't migrate if we will leave preferred LLC
>>> +         * too idle, or if this migration leads to the
>>> +         * non-preferred LLC falls within sysctl_aggr_imb percent
>>> +         * of preferred LLC, leading to migration again
>>> +         * back to preferred LLC.
>>> +         */
>>> +        if (fits_llc_capacity(src_util, src_cap) ||
>>> +            !util_greater(src_util, dst_util))
>>> +            return mig_forbid;
>>> +    }
>>> +    return mig_allow;
>>> +}
>>
>>


