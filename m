Return-Path: <linux-kernel+bounces-720725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49190AFBFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC53F1AA4875
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E4F1DF979;
	Tue,  8 Jul 2025 01:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="elXrRRV2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="igShuRYP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DF35962
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937410; cv=fail; b=o3oGh1q6f5bIVHoYrhGap0sxN/9I6lzHXvQZS+HmG1yEnLSceZGPxKaFuBoG7I4xTPlxx4nHUxH2A45l1UQCcHybpL5+mNS+OvOgGGZ+Yd1NqQKBRrZxu4RuC5uT7zmZe8jKtglHiQw3XxAROQfW+nAhVMZvOjGIc0Ftvs0a3V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937410; c=relaxed/simple;
	bh=9BiQsrPOxQhkV3tY2DYwUcmxMeTUdrM9VfnVII9yLUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zz47cAg0vf4rSQZlxpkVKuK5+A5FRQQD1ILbLUgxu22k5+E6aGA7saVviKmjjIhld2xgodjB/yIyx6TrGP9xPpbAjXhX30UVVfycMfECZj9KMHp9HUgtfAC7tLln0QS+Gpm1M1ekU/o1eSFfQDInvcTYaHAmrvnRMID7y7XGuUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=elXrRRV2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=igShuRYP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567LYo39020202;
	Tue, 8 Jul 2025 01:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MO8Gcc9f3csilRfFykxGKAr6fA3n9OyRNQ7osMAlhk8=; b=
	elXrRRV2ZA5PToRD9DQHZGHv1i9h8zqDYZhiV1ivezEhVnrIEXOMSEd8sbiXidlQ
	Ildob4vr3xTeaMWtHdw0lnRLkM9Q5uqt9Fb2lmqGHLB1W9SMZEFtepPqctbn8Iig
	YgZba7DBQev476Efd6wb0GLJICI6e5o2l/XJQU8P+OvVEmo/4xc8wgG3fM7TW+9w
	pDw/gXp/4bYsBIrj0b/1cJa/R5tLDJfOwHtddOFuNYmmcTXJG9EuX2pyvLKVsOV5
	n6XczvR1sDOU5I/riRvhD8ZgF5d9GpztpVfwzEG9EbBmqoB5GuA+Bh+IveRhxXXo
	x8aLHMZC6VVHw+Ju7hERrg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rngc0a34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 01:16:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567Ml7FL024391;
	Tue, 8 Jul 2025 01:15:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg97wq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 01:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tf6BM64+bkkWck61lFRSU7nH0Dg+7BZMPuoX64wiZcPWla1K41DtpAi2fy9Z/uEJPGjxNuLYZwb3KmVjX0dFWI/m7i9ZfuuQx7wsm3/1tl0rw/vSKObdAEZzJtWwCrAsjGPODMZcoJKpD15P4K50PihZPRkovi048de9DvpXcVWwkA4cWmwzsLEkwtH0umHN7Az0pymZQ+UTZYB/3eTNy9bPsRvFIW80ahdnEFEXQjYLZfLb+Wlkh69Y98p48Yt+HTFQOV5OHONqc+rdeNVH1iNlMcvNTMxnx5hZ0RgqzV5gjLw679WoBON6vmnuPnzJ7+tnPDFwjttRGSMHFL9vAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO8Gcc9f3csilRfFykxGKAr6fA3n9OyRNQ7osMAlhk8=;
 b=my1eDDNQ5B7o8K8R2F2ZDlosmbC0abeqgdzrHuymuSg+mLZXnaVg8cYEtNi6WFmVwkJ7FdKEcyyU26twJzaScyAPRnGxCZZh4Ykw/G57aRFyqQtZE2TPKceg/iMZ/PHDAbTcKLPQVoryGIrRZO61nZr2lRTaTOYwUfWpdEmXVF2A4uTIv1KjxJfI6Wkn0hkQOyuyEKMVfy9tABv0Luv4NsswBQ9uVVFAZgWYoxpLb8jXnmW/M60ZGUNuZNwkRA+UKYSb3fujmmDRPQz4eLcZGe+AwtQgzVFnAY1Nvl72gvZnxymaGBxkXvScnXPvNbBvihC0SX/t3Hnpe/vpFYbBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO8Gcc9f3csilRfFykxGKAr6fA3n9OyRNQ7osMAlhk8=;
 b=igShuRYPbSts0E/yeTNoqCkSbU9s5uqFDlL7nRzEKREDSiFjPoXRJOYKpteNgtOr0t+WXoPRJDx+1TFcJ5j4cDq2Bk6Qpydt+01Dajh9+TIGqxb+GZEzbK2dQZ5oehMIXAHf4kujBGVW84xqPTrW1QB0eDTCdUObVVp5+TDpH+o=
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f) by SA2PR10MB4747.namprd10.prod.outlook.com
 (2603:10b6:806:110::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 01:15:49 +0000
Received: from DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65]) by DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 ([fe80::fe3:65fa:7909:aa65%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 01:15:49 +0000
Message-ID: <60a01353-c1f4-41ea-99b7-a300aee35bb1@oracle.com>
Date: Mon, 7 Jul 2025 18:15:46 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [RFC patch v3 02/20] sched: Several fixes for cache aware
 scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
 <d73418022de76dab9f60c0c5432d783b3b2833dc.1750268218.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <d73418022de76dab9f60c0c5432d783b3b2833dc.1750268218.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:510:324::17) To DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d1f)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF5ADB4ADFC:EE_|SA2PR10MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f28076-f6c4-44a6-5fae-08ddbdbcf96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUIwSXltcmNnSThGR0E2ZEVLRTNCZXh6TmhGZFd3Z0hvMzdzVkdDa1dPOGh6?=
 =?utf-8?B?R2RqUTcyYzloUjQ4K1BMRVk2RVQyc1lJNkNUbS83b2dJRlVnM3MxT2QxUTBZ?=
 =?utf-8?B?bnpDN1JXMzBMUjVjSDAwenJTYk1FRlp1cE9YNkh2ai9VWE92a0NXenlmVGdK?=
 =?utf-8?B?QWdSbDR2MEM2M3Z3cGpQeitMVi9aREI3bllHSUN6M0lSSFdzQ2dBekFRWSs0?=
 =?utf-8?B?a3RpZFQwT3dCblBuN2FYV2tKR25LbXBmUnN5alluVkpPWmFSMGNpQ29mR3U5?=
 =?utf-8?B?S09VOG0zR3NsMkFuQUUwUE1YQjJuM2JjS0NPRzJFMzkwbFMvWHFBN2tTSm5P?=
 =?utf-8?B?ZTRBZEYzZUQ0ekhwU3dseTZyWEg3K1FMRmRRc1VNQkJseGF2Q01pUUJDcnlT?=
 =?utf-8?B?bjlrWTZlRG5RNmlHNEdXWlBoOGFHY3FSR3dIdHUwQi9XWXZPQUoxWDBWbmNs?=
 =?utf-8?B?OFRQaXhac1VKd3g3dHlkUUFZZ2RIZ2Z6M0NFUThPTXkrbUU0RTFiL2Nta0Fa?=
 =?utf-8?B?NW1SQ1FGNXFwcEluNjJyRnQxMWhLT04zMUJQVzA3WlR4Q0dyK3UwdWpmMWdX?=
 =?utf-8?B?NGtrVEt5cDRoVjJXSllzVzdxaTUrSWRkankrMFFQREhkOGIwaU95VDJvbDJh?=
 =?utf-8?B?aDlsVE5ieEw0cG1QUG1rL3FGYlB0MGVudkdnYzFXQW1IajdnZk11UGdmUkNm?=
 =?utf-8?B?Vk1wZTVCNWRFdnZjODdUUWhvVFlSM0RYQVc4SnNsanhNZFlYQzBuNTludFZS?=
 =?utf-8?B?aDN1TWticGR4dUNsNVc0Ujlkc0tva2g4TFB1NlYzK2VGaFRURFZNSldOUzNp?=
 =?utf-8?B?VlhZb1VaY2FIbm9OWkZEejlMK1VLSHlpamdMVi95NmxoeWxudDViamRwcGVt?=
 =?utf-8?B?QUE3V3dHb2NhTVV5UlB3aDBMaURBazRaUTJkSDNJQjFqdzMzREtUbmlCZVds?=
 =?utf-8?B?M01zTmlsb3FmR0lIaEx4dlZ4NHRIbmFYUnR0anNtalJ2RFpZcFIrVXEvVnh2?=
 =?utf-8?B?UklaQmRyeXZqMjdYRlNlRkZOOFN5VE41ZnZpSXJFRXZodTJPODRHVFkzQVND?=
 =?utf-8?B?TGNMdnJNa0dPK2RQUThaVUdISTViSGlDaTZjOXFac3NzaTdvcHZ5RnNHdDVB?=
 =?utf-8?B?OTZNcTJ5NHZGWkZJRkt6RDVkc2U5NXh0a1duUXZvK0RGbDJXdytvaGJWZEg1?=
 =?utf-8?B?VkhUZWZpMzlocU1GZnh5MUJHQWh1T1REWDB4VzFTTUFqYkJjOHdHU28xZ1Zl?=
 =?utf-8?B?WTQ3SFdoZGNOU1RxYUI4V1FLSGdLZS94d2lCcFRkWjFab0I0M09OK0JlcGlF?=
 =?utf-8?B?bU5kU1NmQzloL0c5U3lqdGhCZ2JPZnBQM0Q3dXEvZHNVREptellGeEpUT1g3?=
 =?utf-8?B?WXUvSkNVd2Y0ZzBRUjBqSHNoMjdPdEh0RFlUUDhsV1BkR3B3bE5pTDJIRnRB?=
 =?utf-8?B?UUZoR0tudzQ0eElVYUFGeTlJQjRRNjk1ZTh3QzFVNDRYYTc0SU1hNXhuSVRw?=
 =?utf-8?B?cmN4L1JTazNuM1VwaXJXVm84Z3hKalhKbjBPeVZ5VUpRNTUweGZGWDYxc0Fy?=
 =?utf-8?B?azlBZ0RTMnh2MEgyb1hxZEd2anQrb0IzRHlaak9TR3V6bVJnSkJLR1ZqWjRC?=
 =?utf-8?B?WmlhY3pubHBpZEZqRTZVbHFyTS92ZVd0V0hPdkdUT0V1T3hPZkVrdzlUZnFJ?=
 =?utf-8?B?aERTMEU4azNHR212bkVxaU9ja1RXSnhMamhzemxDTnc4cGFyaDREZVFoekJJ?=
 =?utf-8?B?dEtvRzgrZWk1bEFiWEJ1ZHd3THJ4TzBxMTlnbXRmbnAvdnpRejY1QXBCTFh1?=
 =?utf-8?B?ZkJ5c2x4Y3UwL0pVblNqTGdKcFduelBrRzF1cERDL2JqWmlEVnRaRHRJMmRO?=
 =?utf-8?B?clBJdTkxMW54ZVdFZHhXcEpHWVQ0bE13U0NlM3IwWExGNDQ2cHVYRkJTUndF?=
 =?utf-8?Q?JolyRjD5j9E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF5ADB4ADFC.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dtZmVEdldLSHdqQkh3OXFrNmVXUUxpc3ozVExEQ21yY0EydmNXc1hNU1V4?=
 =?utf-8?B?U0V2V0JOalhOdEg0blNZdmdPMVdjcGNWSmpVclFEVVBZd28zWUVGMlE0OGhq?=
 =?utf-8?B?QzkxVXl3Zk0rYU9rQUViOXNYZUFWcUJBUXYzS3U5TzlXTHJ3dTBraFpyaGNV?=
 =?utf-8?B?VGhjMXU1d1J2K3J4RmdNdy85b2VjYXBWZXVzU2xUcUxxQmh6SHhsdVJ4QUdP?=
 =?utf-8?B?cmVHYmpnSVpUa3NvSE9ieUNLSkJsanFNWHprWjRoYkRmajhLVzZqdGk2T0tn?=
 =?utf-8?B?OTBoSzhvNHFRMHY4T2dKRk1DQUN4QVZuQkNySVdZNmJvNWN0Y3hRSURwRzcx?=
 =?utf-8?B?UW5CRFVMRGtVaWZ3ejVYb0NQcXlZaFNiZHV2OHRySzBOREliUlFuWld1cGV1?=
 =?utf-8?B?ZWZXNEpFOEhCdXJsR3pQMnkrOUhCV2VHK3djREYxZFhOWHUzOWNHUnJJYTI1?=
 =?utf-8?B?ZHdVUEpad1VoWVgrUTBpWFRUQnN1U3FWdUcxL2NxcG5iMDVpcFR3L1ZMcjFs?=
 =?utf-8?B?dm8ydnVvVVpsVDcvMW1uc2dodzVKVWh5ZDRCWnNZLzZFdWU3UkwreDRVNkR0?=
 =?utf-8?B?YWFaSzBlQ3dZTEd0RlZ4Q0x0cTFDNGNrTmM1OGdSVTlSQTdQckd1c1Z6WjJz?=
 =?utf-8?B?Rll4TTlyZ0YvcDZjam4rMDI5eXMzZGs4Z2hRcHIyS2VzRE9VZWZBZEloT0NN?=
 =?utf-8?B?RlBEOXJheHdNSy8vcy90SC9RY1d4WEI2TTROUCtYd1l6WHoxMnp5OHhxLzEv?=
 =?utf-8?B?NytaalZrVWszcVZQZUVrdXVwRGpxM3N2c0w4QnNkemQ1VTNXaFdOcDRjL2Y2?=
 =?utf-8?B?QzFxZW9KbnA4Z0xWTEc1eENSY1kzMUM3Tm9XRnZEOEVYTjdod0Z4QjZENWN2?=
 =?utf-8?B?bXkzM04wNEZMeUJXamNWbDNKWDErakU5aUVwc0lQM2pCTVRwQVVzbnZkL1VL?=
 =?utf-8?B?QzNnUjV0ZkV3MEYvMDdpbnlWTnAzdFdhQSsxK2hQSnA2QS8wejF3cmcvZ3Jm?=
 =?utf-8?B?eU9xdmpwZmswNTdpWFlwbUhjRHQxM1YvOWkvd0JNMFE3MWM4WjNXRGhwZUl3?=
 =?utf-8?B?M0VxUGhnTkt6bUJMeE5xUHlCRFhRMlhNVVZONDBPcnZIS2tvWE5WOUowVmFR?=
 =?utf-8?B?a3k0T204aW9UMnlrTXUrem9tVkh0ZzkvM09rY2FBSEIvZnlWbUMxb05HYVl2?=
 =?utf-8?B?dWhPcFdRakpOUTN6dE1zSEpzb0Vub05SNDJ0bkJkZDRHdzlXT0t6Y0lrTnVm?=
 =?utf-8?B?TWZwUzQza2oyeXplWTBWM2I1MTZabFJreGJUNFV6em0rQjlHUnVwbTYxWVli?=
 =?utf-8?B?L1ZrUldiY3htVVlqdFB0MS9BRUlmamREcDN3V3VRcGJicnQ2RXRRSHJBS0hT?=
 =?utf-8?B?MzdXMER2dnJ0dWN1TTJHdE1LQ3NEb3crK1dPRWZuV3BUT3ppamh4TGxpQkZS?=
 =?utf-8?B?cFpUb1VtQmFqbDk0M1FBT2ZTeFluL2RPbitiL3VFUUMxcEJVVmluc0s5Snhz?=
 =?utf-8?B?K2dQT2VzRWhtams5T2h1VHNUeHQ4VGdqeUFTSlpETU0ySHZmS1Y3OTRiRzZN?=
 =?utf-8?B?dlVmMXlSU1ltUktXaVBVclR4a0M4YkFWOHhQc3BXaElyb1QyYnVsNU10d1RP?=
 =?utf-8?B?eGgvODFub1JtOEI2NGU3VmpyMERDRzdKWDJ0R2lNNWwzREZwZytadGttRUhM?=
 =?utf-8?B?eGU4S0liVDFKbzA1ZjBQM09peDdHeFBERGxOcXVoMmk0Nks5NHFMdHUybEo1?=
 =?utf-8?B?WFduWFF0NWVjdmh5U1lTcUxnRVBKLzVPZERRZkpWeUVuS05mMzhpSGFjK3p2?=
 =?utf-8?B?ajdFRTdBUnRNVVk0alY2ZFJ2R3RrWElZWU04bmE2MjNHQjc2cTJFRkpHNUM3?=
 =?utf-8?B?Uzh6WXJBSTRuT0N0bEFyNVF3Rk5WYUNYS2dGbVdUek5XNnBWRENYRXN5bENx?=
 =?utf-8?B?TFJTZ1BIVGxJTEpobjY3VVVmTDluMXFQdjZCalo2ZVVlYVlIaUs1L0FDUktK?=
 =?utf-8?B?UmNJTGxseS9WVyt5aVBMa3VQTitVL01aU296VHFWczNkZWMrMmsvbjdXdndo?=
 =?utf-8?B?TU9ObG56TnVBQ3VNUjJFZjZzaXZWa2liZlAvd2Ivemwzd1kxM2wwV0FIV3Rx?=
 =?utf-8?Q?OidDXhKZ69P55Nn3yI3vmHKRJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xm8j5nmS6GKIH9mdTOGv9IfOQOOJJOgkzVt+5ZefSgatJxWqfRrY4JkdB7zNE1A4AMX6LKS3plsofN2Qgxv3mu1DSjYh6l22Pa8O513rmKpoED/m5AoX5PJSuBBBpG9CwtRNkatPwblkA2GDRWOQHhuZdZuOMYG4QwXs6EtHSIFeY7xxJLVqVW4Suqt8QmjbRzG14+QzfgtKogVopUNXzCDIKIy99FV+X8yfdlqjfRPjaF3K44jTJQBR8N+O2sZLMSZomJMPkZQ0c6i1KHTJymyg0/5DoFfBJJmaVGE8zMT368MuhcDO+cBTCcG6q7TG16UTWtch1Y2bRz5Fh0lBCBu3XKUubF6Zi3Y7F9UaDe8l7bPYZKf/Ahm1fxOor4m62ytYA+bpki1y/hAit/aEWBQNZvAkFOA8m5Dhr4X8RGa0dbw338xiEpV+hbK3PZROwGJwa/FkMWp4xGB85JEHyvG5tUae/wBRq02z+TEJqRQsdjdp+DZLftlQMWfoj7z7tAVLkX4EnHKDZxeYeConiINUkOb67yX/V2zv+rHs12fHHd+J1fLVCOB2aBIBDSAq3KUfWiua1YBIvN8EBY4T12fvRrgzoHX6WDr8k2qGRSk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f28076-f6c4-44a6-5fae-08ddbdbcf96c
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF5ADB4ADFC.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 01:15:49.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1Nkzwg5SpZo1z9z+XaWIIm7xxy+DFih1cnfD7jMtqUzEy//LY9C0kqJPdGLc3fp8eWBgA37hyFJL7qAKWBWFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080009
X-Authority-Analysis: v=2.4 cv=PMcP+eqC c=1 sm=1 tr=0 ts=686c7156 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=v1yG3dcteFXCVwukUdMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OYEb2Fgzg56TSIpFu4nFxPkxC27esCpF
X-Proofpoint-GUID: OYEb2Fgzg56TSIpFu4nFxPkxC27esCpF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAwOSBTYWx0ZWRfX+r/wQjBiyXid xTvUetJhQTptj4PmHhAH/80wzqIloWCzybJwzCEwmtjTCXmhKgedo9Q5FycsGNOQtU+fkviL6dC 7lhG6UfsPlExdYyI/cwGQtnmp0T25Af5/h9y0f9ycG1eBxgRIzvRC/rN0o1fn1TVafOTnWaY2Iy
 9487TZoIcoFd1x0YeTiMEmA1KQZCna/QZHCyM4+25tguad/F7weln9tdxqrF5kT0Z3WltSZ0YY+ V9gi4MRlwc4iABW8uQZpvc4sLfRJa4ZehykVHMk97ORdBUqh7B+awrxuOEtZQ1oOMUM/6qr92sH 0QBnAY2OYb+Dgik7YkAA/CqRmO89sRxkBc3GMNPb3z+8OtM44jnSh4itcowiUsuSHmYmKAq8DMw
 vrf7NuYHj6sqAyNBZ0dninNFqD9den0F+9BvSjwyAEWsjPMNYQNnJwFXAMG19mLQnJVc5W4+

Hi Chenyu

On 6/18/25 11:27, Tim Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> 1. Fix compile error on percpu allocation.
> 2. Enqueue to the target CPU rather than the current CPU.
> 3. NULL LLC sched domain check(Libo Chen).

Can I suggest we completely disable cache-aware scheduling
for systems without any LLC in the next version? No more added
fields, function code for them. This info should be easily
determinable during bootup while building up the topology,
and cannot be modified during runtime. Sometimes it's not
possible for distros to disable it in kconfig just for one
particular CPU, and SCHED_CACHE_LB isn't enough for removing
the added fields and users can turn it back on anyway.

Thanks,
Libo


> 4. Introduce sched feature SCHED_CACHE to control cache aware scheduling
> 5. Fix unsigned occupancy initialization to -1.
> 6. If there is only 1 thread in the process, no need to enable cache
>    awareness
> 7. Add __maybe_unused to __migrate_degrades_locality() to
>    avoid compile warnings.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/mm_types.h |  4 ++--
>  kernel/sched/fair.c      | 27 ++++++++++++++++-----------
>  kernel/sched/features.h  |  1 +
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 013291c6aaa2..9de4a0a13c4d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1411,11 +1411,11 @@ static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumas
>  #endif /* CONFIG_SCHED_MM_CID */
>  
>  #ifdef CONFIG_SCHED_CACHE
> -extern void mm_init_sched(struct mm_struct *mm, struct mm_sched *pcpu_sched);
> +extern void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *pcpu_sched);
>  
>  static inline int mm_alloc_sched_noprof(struct mm_struct *mm)
>  {
> -	struct mm_sched *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
> +	struct mm_sched __percpu *pcpu_sched = alloc_percpu_noprof(struct mm_sched);
>  	if (!pcpu_sched)
>  		return -ENOMEM;
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df7d4a324fbe..89db97f8ef02 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1175,7 +1175,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>  #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
>  #define EPOCH_OLD	5		/* 50 ms */
>  
> -void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
> +void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
>  {
>  	unsigned long epoch;
>  	int i;
> @@ -1186,7 +1186,7 @@ void mm_init_sched(struct mm_struct *mm, struct mm_sched *_pcpu_sched)
>  
>  		pcpu_sched->runtime = 0;
>  		pcpu_sched->epoch = epoch = rq->cpu_epoch;
> -		pcpu_sched->occ = -1;
> +		pcpu_sched->occ = 0;
>  	}
>  
>  	raw_spin_lock_init(&mm->mm_sched_lock);
> @@ -1254,7 +1254,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  	if (!mm || !mm->pcpu_sched)
>  		return;
>  
> -	pcpu_sched = this_cpu_ptr(p->mm->pcpu_sched);
> +	pcpu_sched = per_cpu_ptr(p->mm->pcpu_sched, cpu_of(rq));
>  
>  	scoped_guard (raw_spinlock, &rq->cpu_epoch_lock) {
>  		__update_mm_sched(rq, pcpu_sched);
> @@ -1264,12 +1264,14 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  	}
>  
>  	/*
> -	 * If this task hasn't hit task_cache_work() for a while, invalidate
> +	 * If this task hasn't hit task_cache_work() for a while, or it
> +	 * has only 1 thread, invalidate
>  	 * it's preferred state.
>  	 */
> -	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD) {
> +	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD ||
> +	    get_nr_threads(p) <= 1) {
>  		mm->mm_sched_cpu = -1;
> -		pcpu_sched->occ = -1;
> +		pcpu_sched->occ = 0;
>  	}
>  }
>  
> @@ -1286,9 +1288,6 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
>  
>  	guard(raw_spinlock)(&mm->mm_sched_lock);
>  
> -	if (mm->mm_sched_epoch == rq->cpu_epoch)
> -		return;
> -
>  	if (work->next == work) {
>  		task_work_add(p, work, TWA_RESUME);
>  		WRITE_ONCE(mm->mm_sched_epoch, rq->cpu_epoch);
> @@ -1322,6 +1321,9 @@ static void task_cache_work(struct callback_head *work)
>  			unsigned long occ, m_occ = 0, a_occ = 0;
>  			int m_cpu = -1, nr = 0, i;
>  
> +			if (!sd)
> +				continue;
> +
>  			for_each_cpu(i, sched_domain_span(sd)) {
>  				occ = fraction_mm_sched(cpu_rq(i),
>  							per_cpu_ptr(mm->pcpu_sched, i));
> @@ -8801,6 +8803,9 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
>  	struct mm_struct *mm = p->mm;
>  	int cpu;
>  
> +	if (!sched_feat(SCHED_CACHE))
> +		return prev_cpu;
> +
>  	if (!mm || p->nr_cpus_allowed == 1)
>  		return prev_cpu;
>  
> @@ -9555,7 +9560,7 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  		return 0;
>  
>  #ifdef CONFIG_SCHED_CACHE
> -	if (p->mm && p->mm->pcpu_sched) {
> +	if (sched_feat(SCHED_CACHE) && p->mm && p->mm->pcpu_sched) {
>  		/*
>  		 * XXX things like Skylake have non-inclusive L3 and might not
>  		 * like this L3 centric view. What to do about L2 stickyness ?
> @@ -9633,7 +9638,7 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
>  }
>  
>  #else
> -static long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
> +static __maybe_unused long __migrate_degrades_locality(struct task_struct *p, int src_cpu, int dst_cpu, bool idle)
>  {
>  	return 0;
>  }
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 3c12d9f93331..d2af7bfd36bf 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -87,6 +87,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_UTIL, true)
>  
> +SCHED_FEAT(SCHED_CACHE, true)
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
>   * in a single rq->lock section. Default disabled because the


