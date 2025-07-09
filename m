Return-Path: <linux-kernel+bounces-724509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B734AFF3D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49705A795E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2680239E8D;
	Wed,  9 Jul 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAVC1dBC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IS5rLhbR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6472185B1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096173; cv=fail; b=CIgo52Nm6o0ppgSXBjss/k7S7ibgc0+6BJyIVHlZZ0lXvK3dTRjd831ErhAxROlpJ00GCV/O+fy5XOzRLTAo2INWErVydt05uM9+8VxFIoPcy7l5gR5OCI/33rH0eqrPMvbDZ9XFvZ87+Ao2sKyhbfPVWHmwo9RPdTuezu0OuwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096173; c=relaxed/simple;
	bh=+pIjIHrp2xCltG7adc5MNhwVMVrwcg48rlL4PSHtnKc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AlNvo9+wn3kCqunw+WJ50oE9RNPUDBL9bPz6vDM+RHUiNePXLUyYFXAo0P+eYd99sLptPhLNw2K5BaGopah2InqDl8GViYwVWkLfGz9a16PU5bjnV74luAuq9/uM5uii6SfYiP79VHgLpAvsCVOUZEW9hB9BifDjPJ0jpYSolJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAVC1dBC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IS5rLhbR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569KpvUo029231;
	Wed, 9 Jul 2025 21:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LaXozDlKB5yinKgKsLsMrxIDAP/8OaYGDoXt7yKlQ1Q=; b=
	XAVC1dBC+B0n69+A5oeI20l4ZAmt1xneMDTHlXS00u6c6IuxUNr6zBB9T3e2QqS3
	IuNyscepQD6My5X38ydpWU4uEe0cz0Ne9dDQJiHCE1QgkZsk7XhfIS16/PYQQqUh
	c7ipzAr97OSBL3ChtzBSKp0tzaqonzoykug03o9xngvjUlx0f3P9b07/gLjs7+d7
	wgtWtJPxumQrjk8awkzWvJnMSBBbAddz3sID5uIIxYGw16bP30wKzgHuDXUG2il9
	sKEbCDUu4aPVrLixOXyIc00/hE8SjGb/1TIbi7CLBE2SQvFMPGyWRhZRmEUTVxoB
	JFKz0D6lW+RUdGivSP5PBw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47syu281c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 21:22:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569Ko2SK023621;
	Wed, 9 Jul 2025 21:22:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbr0hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 21:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU6ksnvcFw81pWRuGKZ6EDZeKYbkVjc/Z/CFCNhHKlzgAOdNedZAUwEzhZkMN9Xbi7JiuQpZk+BW+nMddtdnfL9GbQl3axxXGm7w95d252jygwgGNVPgGK3mzfucvqXWc9HEDVyxijcVyqtslqyyFDvX4k4kMC268pUCepJLaIFxxnWGhBMpwCW7uY/tSPS6jB7b7Chjop2pfx22N4iJ/cgbUcOrKvNAO676rC14yD+PVoKFb7MkOwuadMkNMhWLi7kxpfDpPlml7fmMapvOI6VMi3g/GAwzwD6l/dK/JpDurxzmBIl3wcV9PBO+JCmSd8BnsbuZJ0FPBDXiO0AnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaXozDlKB5yinKgKsLsMrxIDAP/8OaYGDoXt7yKlQ1Q=;
 b=HxmrHlV80EQ7hY5AZctUlR4gRw7OXykjH2iP+qqjR2w3t11f9bRQMHbRGaDNFNIZ96DX5vi0z2uhCOCQLIgTUUWahGGFRdbZ2WFZItvUx2/kCwSCTYbrGQSOydsn8LstdOhq8X1lK2yTrItaASM+M9cJBFLwbwQrJuy1hnv+oI28qWcJnu7Ty6Hajyp550TxG9qeluiSvYAipgJFT3R+/9VuVLA2URhFD+GwK1fJMOXOf3IZnUKaQ6JW6N9eiEHi1RruoWp1Bdc+PFXatuDZ2N6tC5wURV33Z1qjN4zKgL7FG7wEdMJ32zn0pDV6QEW3wfD/RRTJ9N1OyR68LsH5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaXozDlKB5yinKgKsLsMrxIDAP/8OaYGDoXt7yKlQ1Q=;
 b=IS5rLhbRjWzAjJVvIc+dsgbFgDPk54H8D2Oon2cTYfkMHdS9B9KniWYs3XuArcNb47dTWH4zpqxiFP0jPgFsZlNjs4t6Cfkz2Zp4iVFjvH6hu/8Ug7JK9ja6Cwe6/pgOtvrbkTdtjOki4EYj055Bsdk9KZq/SSGC47nZuWW4Fck=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by CO1PR10MB4401.namprd10.prod.outlook.com
 (2603:10b6:303:94::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 21:22:17 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 21:22:17 +0000
Message-ID: <18a0f0b1-24af-435f-815d-523935816d88@oracle.com>
Date: Wed, 9 Jul 2025 14:22:14 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
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
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
 <1ece810c6fc291357f4fca3b2c087e2d73c0dc64.camel@linux.intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <1ece810c6fc291357f4fca3b2c087e2d73c0dc64.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::32) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: a65b1044-ba94-40b5-7661-08ddbf2eae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW53R0N4NXJGWGVuWFQ3YVBiRG9qbkJNcTczMjNvek10RVdrUkp3QWUxOXlB?=
 =?utf-8?B?Wnd4U1djV3dNTmIwS0VScjVsYU9NNkJ3SlZtV21lREl6eXZHMG04bDNhNFlO?=
 =?utf-8?B?elB4MHA4RUV0VmVIY2x3SGRFdEhyRzJnZndmOGM2L1htTFB0T2JOREZZZGJI?=
 =?utf-8?B?N1dYOE0xVG5MdU5tTUZMTUkxcjFzOTcySTc0N3VqUXhjZGRZMmVLNFBGRDFl?=
 =?utf-8?B?TjVYNHIxT3pWUmZ0cDAxelZLMmhVcjd1RFdkN0NDaFNpQ1lvNk1HeEE3Zm9w?=
 =?utf-8?B?Z3ZlQkczbmJvRWZac0lqNng5clFweS9iOXUvWitDTHRKN3NQWVdzTEVpby9y?=
 =?utf-8?B?U2ZobERQSGZGcWI0MnZDQlNJWE1GeFlrdHdESTZ6S2hPU1VpL1JUeXlqZ0lJ?=
 =?utf-8?B?RVJWMXh1ckpRamxNdU80VkJlbWt1dUlaQVJMeE91MmlkbGlkcW1PWlpQY001?=
 =?utf-8?B?MEFJTysvSnNSTUZtckZSTTh6QlhCV01YVU9CK3E2dVE0eEhmWCsrZjNGNTdy?=
 =?utf-8?B?OGVOL1dnc01XZjlQVzhDMHp2ZlY4VkRvSHNjN2xkZFpORXFHajQrNXhKRWlu?=
 =?utf-8?B?bU8vK3dodUkvbVlmMGt6cFdyQ0k4c2tYVnkrbVVnSG5tUnVJTngvVFA4Sk1I?=
 =?utf-8?B?M3pUQXhlK05qL0IvZU1YZFdkWk1RcjRhVVFGRDVzVFJ6RzZjYXlTWUtnajhL?=
 =?utf-8?B?T0NNYXF0RklZRkczV0VyY2UzZHhFaDA2WTRjbTI3N2thR1VCN1ZmUThaT3Nq?=
 =?utf-8?B?RTJYYnBQZlFLZlNJMGphT0dDZUZ2c1kzaWhaYys2S1cySjZKdkpjb0dwWnNX?=
 =?utf-8?B?R0M0cTlCeXd4aVJNaEtpdHhSeUlvVlpEaDN5cm12SitPY1FCc3ZaQlp5WnlK?=
 =?utf-8?B?NmNkYnlWRHNRWUg4cDd1d2ZuNkgrTmswT04rYkxBVk5PRnRWdnBnQ2tIOTJq?=
 =?utf-8?B?Y3lycUx1UzAzaUF4aGhYcU9yMmMvUFlTWXI2b2NGUDN2UjNnaVZBdjVtSERt?=
 =?utf-8?B?MzdueXhReTcrdXN2K0FjcEd0bjhTVjZrSnl4L2JJOU9EcEQrOHhwMWUwcG15?=
 =?utf-8?B?NGozT1FqRnFNbUdEYXp5TkZkcUdOQlpBMUgzblQ4UExTMmd2VDQ2TTlYNE9h?=
 =?utf-8?B?UEJ2amI5N1VyT2phYWNydW5sK2hKREpHUjRhbmQvVWxPdVhIeFE5clMrdysy?=
 =?utf-8?B?a3FyVkVVdFF1ZnMyV0ZUNzRkUTV1aHlFNVp0SmRnWGNwVXlyektKY2VzT0Ey?=
 =?utf-8?B?STI0ajZ3NjZnd2J5TEt0V1pmSlFFRGRPR3VQNjdxMGM5Y3NCMDI0elB1Q3Fi?=
 =?utf-8?B?SEVEQmlQaGxmYWxFSFZLVkNJTjFtRy9ERm5oUmpKeDYrdUdoSHZFc0dwQ3BM?=
 =?utf-8?B?QkNvYVgzZHlBZVdQaTJOQkpieURwZ2JWeHhBK3J6cnhTRDdubmhmSDQ3TXA4?=
 =?utf-8?B?V0xCcUJMdm11a0lGS1g5ejhUZXpYS1JRMmVKL2U2TENyRldkNXYvaTlML3lX?=
 =?utf-8?B?dkkybEdOTGV6cGlBbHRnaExmZkhxczRRVEpkQWVEY3kwUFJtVkxmeVBEWlNo?=
 =?utf-8?B?Qm1OdmlGV0llL29YbjBVY0lueDkxNUp3blM5M3J1MGRIbitJazB3NWZjbEI5?=
 =?utf-8?B?UWlhKzB5dEZNZ0JlNmFKb2o4L2hjRUNyTUR4VWRIczJUTlRrMzFPN2ZFSDZ5?=
 =?utf-8?B?Zk83L0hkbjVqMGZVdDE4Q05vWjV3RTdIL1RlK2QrQkR1dTM4RzF1eUhvRDZk?=
 =?utf-8?B?eHVrbDlXaTliNmZvalhTNTduVWVhS1BlTVVya0E1ZnlQV3dCbmcwSUF3L05u?=
 =?utf-8?B?bk96K1RQQ0QvelBFOE1ucnFya2U0d3RiQkkrOFl2N21DbFNITEM2MnFKb3kx?=
 =?utf-8?B?SDBubXhncDVQS2RXbmJmSFBTc3J6TnZvR1YxU28yWC95WUVZR243Y0c5czdO?=
 =?utf-8?Q?pqyVU6smBN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXo4WXNreER5UVdPMnlReXMrQTZwdVhZcmVxOGNWN0JJcjJKYjdyMkNqZ1Fz?=
 =?utf-8?B?UlNMUTFGdXU2YmkxeER5eVFXVEpPRnI2MEdacEQwamZ0QVpQaDdEY21VTVFk?=
 =?utf-8?B?UlNTVk1DdnRmOFJFOGxsbm9nOE1XdHYzK09qbkIyYXlpM042dTc5U3dKWWVH?=
 =?utf-8?B?L3Q4SUFWanlzTTkyVzd1eWRKenhObk95RkZhaUNYd1MwMytvVEhHcTdmMzd4?=
 =?utf-8?B?MkF6WExjVzI4dUVRcFZjaU1Bdkw0Z2xIN25HMnQ2MUx6cjBLdldzY1FhOUs4?=
 =?utf-8?B?ZVpuanFBU2VXZ2dpV0VPWDZIcy9pM1VOSnNCbFV6dEtwNk53bTJ2WmVrck1G?=
 =?utf-8?B?QkZpU2RlTk1BbmR3N3RNUVg1dS82SERFRFNpZVRvUUsrV2ZiOWZXQmdMemFT?=
 =?utf-8?B?N21mQlF0ZExVVEpZRHBpUnZIYmpZK2laK1kzSUZkR21VRmRBbWJEbFNYbDBF?=
 =?utf-8?B?N0pySm5pUWpsREpMOWNzWmZjcCtyQjFHUFV3a0lTWDBLOE82bnpyV3FiRXEv?=
 =?utf-8?B?TzN6UzFCcDFNekxHejJkRHk4TXY2RzI2U0JadmNaU2xiOTUzaFJXQUZob28z?=
 =?utf-8?B?bGdGUFltSFNjR0w3QXJaS3RPTi9ubHcvaHlObTVhTHY0eFBMOW4rdUg5ZG16?=
 =?utf-8?B?Z2xFeVB2bFJnMmhvRmxWR0ZJaTVtVWZFa0Q1ZWc2UTFWMy9QWjVnZ29YcFlv?=
 =?utf-8?B?MXpvYzZtNnhSaGJ2U01uUjc4cEtocTFlc1RFcWQwMENtNjczdDVGOURzRWhW?=
 =?utf-8?B?ampmc2U0aUphQ29BMXl1dklsV1crU3N5QkFWMWRCVUtjd2NUQm9aZkdkUTVU?=
 =?utf-8?B?eFllc0hqMlNWK0JaZEpYNUhSWkVueHVQalluTmdHRzdkQ3JNcFoySFhZditX?=
 =?utf-8?B?MHRZMVpJU3M0cEhZY1NZTDl2UTFVNk9HTFlDeWtuejAzTzVmOEh4M1RDS3lt?=
 =?utf-8?B?cmlka1Nqa2pJS3hQT1gwaHk0RHFZbGNNRTFqSEM4WWcxckdmdkVpcUZLS0pk?=
 =?utf-8?B?YnYxNTBRSEJjelN5REZEYlFSNVZjN3BYQkNjdjJYbWZ0Ym11Myt5NFpjMFoz?=
 =?utf-8?B?YWRkUXRHc0FWZm5Kc1E4cnorcHQ2QWFyQWRQejlzb0hOZHVha3kwRE5uSEFD?=
 =?utf-8?B?OXQ0eUhmdzB2emVjcGZyeGlWRkhTbDdWVGxmMkthV0ZsQlBTNDlBZ2p3b24r?=
 =?utf-8?B?bG9XcCtMNkdySlZVRHluWXR3dmx1TjRGY3VTZG4yc3B0M2UrcWxuV0JDT0Nk?=
 =?utf-8?B?aGlTczFib01FcjRYOUx6NFQ5S201QXVYcUtXWm9OVFdtazRLcFVVMVU1NjRo?=
 =?utf-8?B?Vm51U1ZwWTl6dnpMMytmWjlqTCtkcXBiNkcxRCswakdxZTNpa0huY215WXYr?=
 =?utf-8?B?bW9qSEh0VURTVlI5L1RsdFZrbGZ3N3RxSldFd3htbDZFWGNxUE50c29pdFdO?=
 =?utf-8?B?bUhzRFd3bVhWcS9CNzV4ZDl4b0pSNGJzaUx6K0QxNFpqSkgvZWZ4NThidmRu?=
 =?utf-8?B?V0U3YkY5Nm1sWDZ0d0NDSmp3eEpXZExDZXhaQkpjenozZUEwdlpkRVdoOVZm?=
 =?utf-8?B?eTBkVlVKOFhCSW1BUHBHbWNDMHU4YVEvUW1JeHFuajNTK0ppUHJkenZKVGZk?=
 =?utf-8?B?engzRWg0ejNvNER0SzU1VlpSSlJ1Ly9RcHFuM3F2ZkZrWmk2eEFiUE84NTU1?=
 =?utf-8?B?Wi9tVlE3NGlNbUw4UG50Uy90aEQ3RGd1VnBEY2wyVkpGU3grV0hoVjRReEs0?=
 =?utf-8?B?cDFhcDlsVFVDak9GMy9TYVB5Sk9qUFlldEFqVytsWGtIbGM1WlRkYXpJNkhl?=
 =?utf-8?B?ZmsvU3ZHNXpZV2lSL01qdXVyQ2NDWnRxRmJnMHY0WExDcDU5Y2hVRS9aZWlj?=
 =?utf-8?B?SnZybFpEM2txOFl6N2E2aEN6d2VsRFFHbVBnQmVGamYwc2RGTys2ZjZSSzhE?=
 =?utf-8?B?TUxoYWZUa0JyZHl1OWIzNUdiV1dZN0VOaHZIWU5pcFAyc3F2Q2RnU3lsOWZP?=
 =?utf-8?B?a2lDRnJ3S2NodUM2MGhQMlU2ZHg1MnhpY1BDeUFqVU96d1pHRVlPUDA2OE96?=
 =?utf-8?B?ajFUelJUaEE1QlhnWGxHc2tyTmIwS2NqRmpLNG9kbm1RMGw5TmhUcDZVMzBj?=
 =?utf-8?Q?pWgOUaxgmxyl6vCLNoUd5AJVr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXIz0n/MrojAXju6CM+g6v1ziMRWwv3mA02Z8Ubjk978ZTm7On+esSc76cqbhfS4/IcUWQ4TtGWBg0H+3lHRnTT8lAKjD4AkxsaYMcoIEaMzIT5SXSJDC/oB85Ym6LJ5Msb1kG0O202qyP8kFHIHBlva14EV4KQ6b9pAoCiWoZWfSeFEwZxV2VpndHMmHPkGeV+FNSg/6WwnAeriERmFno0axCFJ8WFOcsfTTC7ZadeOYN3wrpQVav0igskhboSPWmBmBct9chI2foMdVlKbrAr8OHiB/dUpqJ2kN0zQnnzEo27zqs+9g7l1NeL4COT1oqTVjSU2GwE6F+0bjwXqoWyXwOoWGMpNruMwvQXPhdabkXj87S5/Kc/gb0oYdhHhcx2ZwSCbrgYmTSV+D/8kw66ETggWXSb+Ke57Ut4AdIznlMN3+zzWs6cUPXwQ5w/HE730i39d2V/HNO8UeCaAfVVO19e+mUTona4ZB5N9f8lcKRczxeeCvRsNuW7bFNYKB3rBLzQ+lAQhwgZnYMSxIaAYIrTprLXnkGgRdevhuA8DV6QMB4UJb4CoixjHBhUl1xhcBpP1zkMrst/yxdYzz/+N+SzG8iZV2oZry5p2oHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65b1044-ba94-40b5-7661-08ddbf2eae77
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 21:22:17.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mio2NhmGuE9kdaTmEfiTIhfjA0HENDZ6KZzbh9LrF5slEWTpU8itI+qsSfaA+Ntrw/1uxCfyNGmauQNCiT5srQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090191
X-Proofpoint-GUID: eLixU1iNKfVc4nCIdavmYzayo2BJCQlK
X-Authority-Analysis: v=2.4 cv=csabk04i c=1 sm=1 tr=0 ts=686edd8d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=D4fzZ-2d8jIlhESPyVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eLixU1iNKfVc4nCIdavmYzayo2BJCQlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE5MiBTYWx0ZWRfXxAFg5gfx+4Mk x4nMx88GdG3pf4TCtKGpoF4hbtI7g4YkBlkz9/j02DBRtGn8bxcK7QtBPNgi/50fKiUgcTdxodQ 3G6mF2r041aigpKsCteXe8x2bK4DCA2Md5Y1LiCwGnEynpR2qktVYusK3FVvPmQkCyaDxR3pmWl
 bEv8rSszjq56WwrUlFr/9F4TL4vnfCiEFugofo0CSNBrMWT21piPzEckvnp53LoTwKafex6R8iW 7PavbOr8+9Ngbpbe2Mdo3vGXxkzr4vBvDjs/pwd5nB87Q2/C09i/1abL6jpY0/5K6xonLRDygE9 WPKNP0NWxrChgamRhrAfzbIVl/2IPxyvxG0zzKy0H51hyyFdbeJJxdYPaaxKPoIXDfEKVm+E5RT
 uNTOWNLJ8m6xlor1XMYBJ6M/NgxppA8yXurm7mYqA9lxlfjLjLZ0OsOcggzZma/oyNj5ozeC



On 7/8/25 14:59, Tim Chen wrote:
> On Mon, 2025-07-07 at 17:41 -0700, Libo Chen wrote:
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
>>>    are not too busy (<50% utilization, tunable), or the preferred
>>>    LLC will not be too out of balanced from the non preferred LLC
>>>    (>20% utilization, tunable, close to imbalance_pct of the LLC
>>>    domain).
>>> 2) Allow a task to be moved from the preferred LLC to the
>>>    non-preferred one if the non-preferred LLC will not be too out
>>>    of balanced from the preferred prompting an aggregation task
>>>    migration later.  We are still experimenting with the aggregation
>>>    and migration policy. Some other possibilities are policy based
>>>    on LLC's load or average number of tasks running.  Those could
>>>    be tried out by tweaking _get_migrate_hint().
>>>
>>> The function _get_migrate_hint() returns migration suggestions for the upper-le
>>> +__read_mostly unsigned int sysctl_llc_aggr_cap       = 50;
>>> +__read_mostly unsigned int sysctl_llc_aggr_imb       = 20;
>>> +
>>
>>
>> I think this patch has a great potential.
>>
> 
> Thanks for taking a look.
> 
>> Since _get_migrate_hint() is tied to an individual task anyway, why not add a
>> per-task llc_aggr_imb which defaults to the sysctl one? 
>>
> 
> _get_migrate_hint() could also be called from llc_balance(). At that time
> we make a determination of whether we should do llc_balance() without knowing
> which exact task we're going to move, but still observe the migration policy
> that shouldn't cause too much imbalance.  So it may not be strictly tied to a task
> in the current implementation.
> 
Ah right, by setting task_util to 0

>> Tasks have different
>> preferences for llc stacking, they can all be running in the same system at the
>> same time. This way you can offer a greater deal of optimization without much
>> burden to others.
> 
> You're thinking of something like a prctl knob that will bias aggregation for
> some process?  Wonder if Peter has some opinion on this.
> 

Yes. I am sure he has hhh but we can wait until the global approach is good enough
like Chen Yu said.

>>
>> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE?
>>
> 
> Actually we think that we can do without SCHED_CACHE_WAKE feature and rely only
> on load balance SCHED_CACHE_LB.  But still keeping 
> 
>>  Does setting
>> sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?
> 
> Aggregation will tend to make utilization on the preferred LLC to be more
> than the non-preferred one.  Parameter "sysctl_llc_aggr_imb" is the imbalance
> allowed.  If we set this to 0, as long as the preferred LLC is not utilized
> more than the source LLC, we could still aggregate towards the preferred LLC
> and a preference could still be there.  
> 

I see, I think I have better understanding of this now. Thanks!

Libo

> Tim
> 
>>
>> Thanks,
>> Libo
>>
>>> +static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
>>> +					   unsigned long tsk_util,
>>> +					   bool to_pref)
>>> +{
>>> +	unsigned long src_util, dst_util, src_cap, dst_cap;
>>> +
>>> +	if (cpus_share_cache(src_cpu, dst_cpu))
>>> +		return mig_allow;
>>> +
>>> +	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
>>> +	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
>>> +		return mig_allow;
>>> +
>>> +	if (!fits_llc_capacity(dst_util, dst_cap) &&
>>> +	    !fits_llc_capacity(src_util, src_cap))
>>> +		return mig_ignore;
>>> +
>>> +	src_util = src_util < tsk_util ? 0 : src_util - tsk_util;
>>> +	dst_util = dst_util + tsk_util;
>>> +	if (to_pref) {
>>> +		/*
>>> +		 * sysctl_llc_aggr_imb is the imbalance allowed between
>>> +		 * preferred LLC and non-preferred LLC.
>>> +		 * Don't migrate if we will get preferred LLC too
>>> +		 * heavily loaded and if the dest is much busier
>>> +		 * than the src, in which case migration will
>>> +		 * increase the imbalance too much.
>>> +		 */
>>> +		if (!fits_llc_capacity(dst_util, dst_cap) &&
>>> +		    util_greater(dst_util, src_util))
>>> +			return mig_forbid;
>>> +	} else {
>>> +		/*
>>> +		 * Don't migrate if we will leave preferred LLC
>>> +		 * too idle, or if this migration leads to the
>>> +		 * non-preferred LLC falls within sysctl_aggr_imb percent
>>> +		 * of preferred LLC, leading to migration again
>>> +		 * back to preferred LLC.
>>> +		 */
>>> +		if (fits_llc_capacity(src_util, src_cap) ||
>>> +		    !util_greater(src_util, dst_util))
>>> +			return mig_forbid;
>>> +	}
>>> +	return mig_allow;
>>> +}
>>
>>
> 


