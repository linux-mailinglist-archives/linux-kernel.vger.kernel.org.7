Return-Path: <linux-kernel+bounces-880953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AECC26FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA14E6A42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2330CD98;
	Fri, 31 Oct 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EWEQixEl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TeX+XW6o"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2B28725C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761945491; cv=fail; b=AncZ7QiB7Up3DihbDgJCW1NhsFXGVvOPeWf7SjVec3gKn7b6Ou8Fb3c2ASUYBH5ytk1B8pFo3dfne8K/qgQiu7hAd/BcLs0bIhiFgTBvCtoD0f8S1dVSv41ez2A0dv28xK2+NKvUgLGThQV/lW+dptLBR4sVoi95WpM2COhiIUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761945491; c=relaxed/simple;
	bh=zy5iMszr6rCO1L/yr1Ur/OKcr+8leA0F8sAvJLzMLOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGHvvL0eq5k7XDl1H7Mxg1/06mSEoUB59XSrnohP2mbdnRiw7zQi1t9eDehBe1OukDIoUyG62uIeveFriEh6yIcA7hEozthCmhlQI7iu2CvTwbJ4A1eWT5ARtYGZmc5dSGvJiGj65otzWnF8lcU93nF25vyG5DpEP20FSAEJ7RI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EWEQixEl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TeX+XW6o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VLEqPc010187;
	Fri, 31 Oct 2025 21:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K7ODo8jI2Dwb4qpRLA1TzYrcMqnZZSLuuhehAsrSTUc=; b=
	EWEQixElG735UzoD80lHsN2DQ9XZ5Su21RPndLBNoW1TClWHOyL4CfIpGmH9DgI6
	oghPY4T1s76ef/G1HYvBt9zuR4l3UlWpZOraVg++hdgCQU+puJCmaM24q0Rf5ngB
	oDvvYxn6o6bju6hNynUmjUd3WLgc9r68CC8qYUvALaoDfFwTI/hf/wNT76WvxDjT
	NlZPwItsOaqtdILY9TWcIqGF63OmVAUvWtCSrKBtJVGa8LXXIuiVaSgB96+8SziW
	ZM2lRvFh7B63Bi0j5PgQ/gRvBCiZ4TTlm+sQBHzY3GCvuGj4yVajRNK4A8dZOXgL
	hF0kXXQYeiQo6VPNJVxTRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a54usr037-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 21:16:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VJwQ7J027700;
	Fri, 31 Oct 2025 21:16:36 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34qb0ddk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 21:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX6fgo83jTIkPywzrW4g6yYAiYAlifgRZSL6LD0Rfs3YfIHPBeYmzJxiXEESihniJOKuQjycS/H0PS+foMOaOr04CbUfXlsqNnrEMZpFehIAi5u6PoKtYtmyzLKX9ReYU9LOSCUwABWoNPL+EV7jkJRV6YDAsmQG1I0MUr5B6Md78Q0XO2nWsQfFgzeuxWKjMtqXzDkEi5qHox/5X/5lR8g1Bfe90a2RS6jBWdGFJqQsIIuEGXX7ghfHAyZSmB/x298OaTLMuHdBqs1OlFcDhk5aAInHZ5zJbEpp9zjCiZQh0pOY/cvL25/nQV007diRooxYLjeP2ZObG8HQ6JtkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7ODo8jI2Dwb4qpRLA1TzYrcMqnZZSLuuhehAsrSTUc=;
 b=g4iSS4afKEDREVHzbJYXQVvcKg0HP8e58pCPhq6lYO51aUHx7gAnX60JJ8sKkhVmOOYi6LLKNvGWSzzojINBB9MXQ6psoeBSe7lZRANnt397cL4272HnpcIlCgpt3lydgHTGbWxZXSEb7p/LtzdvaU6jcUPylM+Nn5DM/AfDdTXwV0ed9j5d88pg4AD/gpugAvo0RjWtm0M69CSWo/JEOxlUFXYjSaZ5/2VtldYPMG64TxnfxTBM8RxmiHgFPCMCrbGu+KhwqTDC76LHbFBIC6+L1JIRFe96XvSUHWpXWlAdQHdYdo6nfgJEmsacI7PvcZgqipouQNX1zvv7r2diCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7ODo8jI2Dwb4qpRLA1TzYrcMqnZZSLuuhehAsrSTUc=;
 b=TeX+XW6ooiMJm60CH4nry+zZfyfSxLZ8spmHanUl3L5CV5TrEd5vDEppQa5vnTUK9SSCdMzg6vYHZ9BtdbUdOBZ1LfBFmqefjD36IeuUJ08M24CnUeYG7HxTOqe/HHXZxJ46IjVj1jgH86drkDv2EtvOylcimH3ek4ls9KmO7Rc=
Received: from SJ2PR10MB6990.namprd10.prod.outlook.com (2603:10b6:a03:4d2::19)
 by DS0PR10MB8151.namprd10.prod.outlook.com (2603:10b6:8:204::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 21:16:33 +0000
Received: from SJ2PR10MB6990.namprd10.prod.outlook.com
 ([fe80::622e:4606:5ed3:5553]) by SJ2PR10MB6990.namprd10.prod.outlook.com
 ([fe80::622e:4606:5ed3:5553%3]) with mapi id 15.20.9228.016; Fri, 31 Oct 2025
 21:16:33 +0000
Message-ID: <5e236e56-5fbb-48a3-84a7-839f4ab08f6d@oracle.com>
Date: Fri, 31 Oct 2025 17:16:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
To: Adam Li <adamli@os.amperecomputing.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Chris Mason <clm@meta.com>, clm@fb.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
 <ecca7938-a166-4a32-acb4-e38fb9b426a4@oracle.com>
 <97d9d369-aebd-4471-99dd-177fa83adbe2@os.amperecomputing.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <97d9d369-aebd-4471-99dd-177fa83adbe2@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:510:33d::19) To SJ2PR10MB6990.namprd10.prod.outlook.com
 (2603:10b6:a03:4d2::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB6990:EE_|DS0PR10MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e71a46b-1175-4376-8e69-08de18c2c438
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QVVnSkxqQVk2M0cvVXUzNUdzV0I5ckNSQ0gyNjRieDJpekVEcHJQbDhBQ1E3?=
 =?utf-8?B?Zmdoa0JjOWkzRlJWbi91a3dOQTRZc1l4TkhSUDZrSStkeGpacnFmWEVqVUZB?=
 =?utf-8?B?SjFSUnJML09DeGNtTkkwYmRxV2QrL2hOaDYyVkIzcnNVWkNnU1haVGxQYkZm?=
 =?utf-8?B?WnR4QXpVb2JTRm16SnRVcmZrMUlBL0p4dXA0dzhDbkx5S001UEdxdXkySkxv?=
 =?utf-8?B?R3prY0lBN0RMT09HcGNaWnVuSVhXbVJmU05GTWo4MVlRcXZjVVRMSFFEdEUz?=
 =?utf-8?B?c0p0V1lHaVJEeFFBV0FRSmJHbHpqVm15V0dJNG5aRXVRQVVheEJMb1dwMm9t?=
 =?utf-8?B?YXRCOGZzQjJoZkRQUWI1dUZtY2ZrRGw1OEJMaGxqMEFYRDViR0oraDdUWmJV?=
 =?utf-8?B?UmROV2ZEbk96M3pwOWxXTG0xcVpKUlR1dGw3WUxDMnFKMHZJTVBVWjNqbGdN?=
 =?utf-8?B?WU84eEQ2WVcxQTRyVklmMGJLSXBwSHZTU01oWG9DQlQ4cTdiVVhyZnVQeGtt?=
 =?utf-8?B?QStRZTBoTEUyQkJMaVFkbHdlOVpTdU9aaTBXTWtPekxVSUQwR2hLZ0JITU0w?=
 =?utf-8?B?R2FjUUZaZjMxQU9YVkt0VHN4OEVHbHRiMkYySXNDZ0lSZ3lVMVh3RE1CRzIx?=
 =?utf-8?B?SFJhRmt3UVlEeVVqN2FoU0c3L043MmxUMTZWR2hNRkNwMHBReEZLNVc4T2RK?=
 =?utf-8?B?QXkzbHR5a2wzQXo5dU9rU1loV1h5MGFPRUFyZFZGL3BRSmpQeVJ4R2hORk9p?=
 =?utf-8?B?TmFpcXh5NmJ2STRMNHdRcmUxT2xDTkpNazRZOUlCWHlUY1g5WlA4YmpTQXlN?=
 =?utf-8?B?VFZjMStwNC81RzRiWmU1MVp5WjlOMERUZjFrV3pLSnhVSG5ubWYyM2l4bEUr?=
 =?utf-8?B?emNsVmxGQUQxcWMxbmp4ZHRpLy9kNFNSb1FKa2JYNkRlbWs5c2NLVmJDcGgz?=
 =?utf-8?B?dGQ5TXlIQW4vMGpmbVQzbkNIYmFDaldKMXpnQmR4Zm5lRkVkcjdVNWMvTHU5?=
 =?utf-8?B?ampibkhTQkFqN3NnaWRYcHZ1OHl2SndjWld6eXI1V012UWVEV2Fvb0tkd1J2?=
 =?utf-8?B?T1llcUNoMFd5clNMR3p0VUZkcUcwWWF0amxoNWhHSjZubDlRYjVGZ3VZV0ps?=
 =?utf-8?B?SlpwMGdhekhMQnBZNTRweUxFR01UYmpiVnNiQTRHR0p3bWk3VTBCSW9LSi82?=
 =?utf-8?B?UnlWZktHS1RTaTJXK2FNNk1DcmdCZDhRbnJteUF4WFc0M2xYRy90dnhpNjQ1?=
 =?utf-8?B?dUdkOFJwaGZwSTRiajM3aVJ3MjZ2WkxleFpuR2ZiY1p6SUNaUkpublpENGY2?=
 =?utf-8?B?T0xNUXpWTkZPSHRPdU4vNnA5ZUdaamJJcHhmZWE0NlRNT2ZMSEJtRDludmlo?=
 =?utf-8?B?NGI4dnJrNHRQdHBaWExma1JjZFRnRXJkaWFOb2hrTGlUYzNsMGFjQjhKL3hG?=
 =?utf-8?B?VmdaRDNCcCt6YTg2TnFDY0tKaVFOME9mMlFBdmtVSkVrTEtDSEY3c25najIy?=
 =?utf-8?B?Z3B5V2RSbjlqYkhhZDRtWS9hWUE1NkNoZ2pRbDhRLzQyWmpFdUhWUFdOTWlU?=
 =?utf-8?B?T2t6RTkyTzhHbWIyT1pOZGl3NER4aXRQbitkZTVrY250K0RYeXdzWEpCcC84?=
 =?utf-8?B?a2FnMTB1VVQwdEp2ZWxTTTF6VTlORnRjZ1RLRG4wRDBveVhiVkhNQ01vdGFI?=
 =?utf-8?B?UkRLYmpERTY5M3ZQNmNwSHVmL0FnZUt3SXp6MlpQbGsxSW91YXJZUFoxTHNF?=
 =?utf-8?B?L0NsNlZDN2FZSTBhdFIrZ09QK1RzZGdadUxERnhSTG9OTWFJTXJxUUxTWE93?=
 =?utf-8?B?K3dDdHFWR1dQeStCM3IrT0ZLYVlVaFk0TEF5OXFDK2VvNGRlNEd3U1AwN1ZH?=
 =?utf-8?B?aG5kMjQwWVJpYW5qUDVaMVJBMWJWOWViY2xIVDlkemhOMnlhV21MQ0RHU1Nh?=
 =?utf-8?Q?peCHa/zyYUcgvCBMafcf0CiYqP6GtjdZ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB6990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?M2NFYkltakpwSS95bW92TE1heDBLMjlQL1VGLzZFQnI0RmRjcDIySDgxRlY4?=
 =?utf-8?B?Mys0eEVvcGVMcFZOT096aDRkbEVnKzcxSGZvZE5kM29FS1BXOS9QU2ExbWEw?=
 =?utf-8?B?VEo3UHFQL0FQZllRNW1PUGZXMGhubjROTStmR1VGSlB3eGdLWDhIS3BPSUht?=
 =?utf-8?B?N25wUmxvNWlmd29Yc1hTQW1mMnJLclMvVm5HOHgxNWN4eGk0OEtDV0dHd3hF?=
 =?utf-8?B?RXI0ZFpGTnBJbzg3NjMxM21JdkFzQ0k5TlMzTWxQZmtYb1MyL2llYUN5VjBj?=
 =?utf-8?B?UU02UmZ6RSt6UStvYk5EbWFoRXdZUVUvc29MQS80WkdPN3h2bWJqR0tGQXdV?=
 =?utf-8?B?MS80OVN5UFVYUlA1YVdwNlg3OGlGd0pGSVhkTVh3SkZwYU5WL3VMWnJabjlR?=
 =?utf-8?B?VGwrTkpMRmJmdzM3L0lSZ3JBeU9VckJsY1N3cHdWL3A5SXA1UFJYWDd5T1E2?=
 =?utf-8?B?RU5UU3UrNkJVNEZ3aXN4aTRHWVI1ZGdhaGtaajh2VDBYSGpoQnY1TkxyRlJX?=
 =?utf-8?B?RXdXdGVqZmdkTHAvSkpqUk55a2ZIRVp6a040WGowYURJNDV5T0dadGZYa05a?=
 =?utf-8?B?eU1CNHBOcEVRSzFyQ2U4Yis2bzVLTVpXSDJYOWJkRVpmemhRUXV3eS9pNncw?=
 =?utf-8?B?OHk3QkNpZSsxM0hqeUpqWmdOYTZIUDVGU3p5eWtSV2lIdnRvZkJ5d3ZxOVJr?=
 =?utf-8?B?d1VVeVBUWTJiTmZkN0xaa2NOTVJkZkNCcmtkRkh3UEc2bVQ2dW5TbnZzakMz?=
 =?utf-8?B?T2xVQkNIcisrekZ2Q0d2ZWh1YTNERWxXSkVZVlpZbEY1dk85M0RyTTV1L0Zn?=
 =?utf-8?B?NFJzQjdVajNiRGRQZ3RJSjIvelR2N3dkSDhhaEVuaUFrL010Ykc3QUtxRDhv?=
 =?utf-8?B?NzcrdTRxYUtLTzc3OW5INmZzYmxReHJjSkx5TzArUHFpeVRKdWpadjg0S2ZK?=
 =?utf-8?B?eXQ3NjVGMW5sSkxDWERFZkhLQXYzOEtteEZxNVBtRmt0aWw5U3lmZHNBY0U3?=
 =?utf-8?B?YldpWXQ1eUszK1BrbkhncmxrdW9oQzIwcEgwVzlDVk9VZGVQRmJoTEdBMEND?=
 =?utf-8?B?WGpXbWY1Y05GREpRNy9Odi8rWXRYR0lCTXcyUUpMRXBuajJ6OGUyenArd2hu?=
 =?utf-8?B?ejcyeGFRYWRIa3VkdmxicFd5Y0VHRUJkVExxSlV6T0dmcFkvSWRqZll6NjVP?=
 =?utf-8?B?UHVybElEa3lkK2ZKUktscm9HNGhxUWptWUc0amNLMjVRS1ZMS0FTenRrQVhU?=
 =?utf-8?B?eTZYUEZpRnI0c2hpUFhEMS9IU05RMG50NWtxdFVpM3d6U1hDdHl4TmdiVDNG?=
 =?utf-8?B?MXVRWGlQcGU3YkxvN05rOTArU2JJbUNDelZ0Y3NhTitwRHJ4OTNOSEd6ZzQz?=
 =?utf-8?B?TVpQeEZpTEZLMm8xSFBsNzZpeE9DS21QZ01tU25QT0VvM1dZYzRvWlYyUXBU?=
 =?utf-8?B?SGRtZjlkWGV2UFVjclRKdXl2OWZrd2UxZUdPMWlyUkxVbGtLclFyWXF3UnRK?=
 =?utf-8?B?dk11dzRjMkc5cVlueUFpaGFxaW9Qb1BlVU1wOEJ3eFJTbXhlWFJ5eWpoVzJj?=
 =?utf-8?B?UHg5dExndWVZYjRGZEUveTJrdlBHMlhsenJmTU1ZVXJqTGdqY1hjZjcrQ3Js?=
 =?utf-8?B?RDc5WjhnS2dWMlRBUWJiem9IZy82VDVLY1NOU3Z0YTdRSGpvV3ZGNlkvenJ6?=
 =?utf-8?B?NFFibCtqN1BBMTdWVHV2bXBJeXVJQ1lpYXY3cnREN2xSZmFIYktkMFFSRE44?=
 =?utf-8?B?SXg2R252U2kxdXJQemdJODVQNTMzZlhHcUNLeXRjb3BnZjIrcXRBWXhVcmFO?=
 =?utf-8?B?cElUQVk2OG9iUThHc0lQMDV3N3dZUVB3U20reDR1Nk5NMytZYkJiSCsxTUdp?=
 =?utf-8?B?c25QMlVpWEN1YW9SQjUyUzlMVWFSSmtBMzlhSjdNanVtU3VXNkowVC9KZ3ZM?=
 =?utf-8?B?YTdRTFg0V3ZsMlg1QzRyY0lCZU1ETEk3TXFBVFltb2ZtcThCT2FEUGNoYVp5?=
 =?utf-8?B?TXNPRW1hNWV4Ry9OS2hsTHp2R1RhN1lRbXZIY2xEMTV3N29zUWRVZE9GaURV?=
 =?utf-8?B?SE9wTEFNZUtDTDF6ZW5QZm8zOUd1MFBZQno2TDFuNk5KMVYrSW5VeDczWW13?=
 =?utf-8?B?WlpseUc0WWUwVjJhSVhEVThqZHJiS0FsWkFYOHZnZHB5UkprQXJMZllTM1Rm?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PPImZZPakaiKbdKviB788VDeejm6r31pKL1Jql9K/FnP3cMf9h//z40icymVGnUraqjbfxbARxZsWcNHBSJKwSyQpmVxW8DMWjYYfMwUYuae9wSw8LtiLX0YdWX019uKiJsAQP87QN5g/NS3eO742nKF2XA8fReXuR6LVUPi7O7ix9TFKOnW6DW84FQSlQdn4ijW3oFb5PMsYaypsmVSUXIYi+ZVYLijtGL6fSm5u+rZkwEgsjKXiz/ofuD95O8m854U27hNJUbSsAPClFk8lfw+9WAWCWSM6nAu4kYoohKVPjuOf4XcpxAT3/5sOPJcdvjxjfV1STcR5whhA2i/QU04nBw+FHOTz7e9UcJ2bZGtVDUDp9eTQfZrviSxKi52DkqOH1ePK7WLUD5FxfR1yiT6wY+zyq0Yre0lZ9ZagQWp8aonlzgzN/LZop8HQc3FMh2LN4A8rdsbmUzLSIVi4gIz8i37fCqMUN7QcWrv2bKAJyc6Rs4X8q2I4RoQeXyGc87fIyxYF5AnvkqMSnJqP3+4wQnkxaxWFsNwuSQxuHvjz3l2KFUfRKxTCMpxPFK8TOEtI8eHMWCBX54P5GRcVjDlY95f6oNurJq5L2ojEeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e71a46b-1175-4376-8e69-08de18c2c438
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB6990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 21:16:32.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U9KDk5CBfQz/uTm4RpkgFVN5xnfjSx2D0b6uFnZ9Xl+jVqAQScDYarjpeAW407SqLNsBQhRrZPqfjvS0TXCocTcvKEaG16XYBvc/ucCTU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE5MCBTYWx0ZWRfX0lxxpBUaJ6DA
 JkydNB1XAE0+T79ifkzgzWAfOeL5fqHIjV3zxAMYfiVaTzGcPtextG7LBzLuP8Yxg7u7+2uVtJy
 qLBE/wT18cf3r3VLvY89ggPraBs6AiN8pj6pAbw8obI8rt9nQvo6LSkVpM8SlnhXKBoKU+xcjFL
 xVml1coM4+Io4NhnrobVKRNg26xdN0aPcZI9oLmMMyFPR1p4i/zEBLwy0HV8d5sSf14+h9RMfyP
 sRM7f8ZiRGqopF3PziLkp2n1vjhXY2LjvubWArGwSVrUmdCY4lIkohW7+Gh6o/JO+8laxa0XIPF
 h6XUD8MBMLUgH3WHLfPNGAcV0gEGZDMUy/xJXbCFSVoxk6bkid1PIUi+rlx/T+Srkelm18OCl9p
 xOdTYJ2qXLMe8idulqNtcrJ3DLOCIWiAlPJWw7m4un5LsU3jsXU=
X-Proofpoint-GUID: DeUxDUZPLtMC18Io6WDTKTTqXOgxQaPg
X-Proofpoint-ORIG-GUID: DeUxDUZPLtMC18Io6WDTKTTqXOgxQaPg
X-Authority-Analysis: v=2.4 cv=TtrrRTXh c=1 sm=1 tr=0 ts=69052736 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RGnG5d-m14Jcu087PskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124



On 10/30/25 3:29 AM, Adam Li wrote:
> Hi Joseph,
>
> On 10/18/2025 1:01 AM, Joseph Salisbury wrote:
>>
>> On 10/10/25 13:09, Peter Zijlstra wrote:
>>> On Thu, Oct 09, 2025 at 09:04:40PM -0400, Joseph Salisbury wrote:
>>>
> [...]
>>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>>> index 3c12d9f93331..5ded210701d0 100644
>>> --- a/kernel/sched/features.h
>>> +++ b/kernel/sched/features.h
>>> @@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
>>>    SCHED_FEAT(UTIL_EST, true)
>>>      SCHED_FEAT(LATENCY_WARN, false)
>>> +
>>> +SCHED_FEAT(NI_TARGET, false)
>>> +SCHED_FEAT(NI_SPARE, false)
>>> +SCHED_FEAT(NI_RUNNABLE, false)
>>> +SCHED_FEAT(NI_RANDOM, false)
> [...]
>> Thanks for providing the patch!
>>
>> I performed the same testing with this patch applied to a v6.12 based kernel.  The performance regression still exists and is slightly worse.
>> The drgn stats are attached in a file named 'apache_drgn_log_NewidleRework_From_Peter.log'.
>>
>>
> Just wondering, did you enable NI_TARGET feature?
> It is default false in Peter's patch.
> In my test 'NI_TARGET' can fix the regression caused by commit 155213a2aed4.
>
> Thanks,
> -adam
>
Hi Adam,

I did not try NI_TARGET.  I will try changing this in Peter's patch and 
re-test.  I'll post the results.



