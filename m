Return-Path: <linux-kernel+bounces-739644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF78B0C91B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316BF1AA5596
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53E2E092A;
	Mon, 21 Jul 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rD5wrZuF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RwIEmdOi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A672D63FA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753116791; cv=fail; b=T3qrEzXzpRDGFRvCMjbluM9DEF+vfbvjwuLm1Se4WNfddy3sPieYPa1Dp/J1lXQb/TEktPeVeg8kjANsdVZ1S0aU2ijoHVVVNpqMs9MyFqS7pN1figk3nkBP/ciacONi0CAqmqaayuium6HNKEC18xyj1oMK18qem7DfdBiK0CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753116791; c=relaxed/simple;
	bh=bZFI/Phy+JZd/vGRiWR7XwopfAjsf6WPOt2e1yY0c6Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P56mQCdDzBjmfwP1bI1ijK9oC2viOqMEDJkqAAWdQ/BfoKCIbLORcd52RLnP7C04cUNsOFrTZwsm3BQtn5dIk981dyHUCMuvw9TQJ92g0/pmh2Rxgp96GxrK33OOLeQYI+G/oluYjhXwLczpoKMwNcmzy7CtpmZKtLLcgO1eKeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rD5wrZuF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RwIEmdOi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFQjQo003740;
	Mon, 21 Jul 2025 16:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bZFI/Phy+JZd/vGRiWR7XwopfAjsf6WPOt2e1yY0c6Q=; b=
	rD5wrZuFgYhOuntvr/DTmUzyvh2+7SattvuakSY72c8Q81YydnvmG4K8nfFtW1aT
	F1otZciVbpO2o+rB/oYJEex8Ye4HccUChohSZYWGV4YjD5cZpvtFhAMtKdioulrU
	ofOxvQUJGowULBqldYp5wyvhgTVqNXSw2AdtBykWxmXdUjEEtJ+CNxbARrPcHcpk
	aMJ0kNFzJA8G3Y5rLbZLIbF7Qg/oKKKdF3djTYnpuzp34QhlzgbMThmYO60vyhjb
	aiP/iObLp/AptImxHobxZijBPTXrB0RCmaHVZ9YaAQsVQcVuZ+LndpgypAJ2w7DE
	EDE3cFGL029in3uQ8HP0qA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056eb8fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 16:52:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFN0Gc010809;
	Mon, 21 Jul 2025 16:52:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t893bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 16:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDTlWflOaeZR8LesZap4COKis7OOGOAkJvhlWAe5NwJP4cjvItzGkuECud4FM2QMHwJBcrttDXnnpyEzvwUNv7Yi8LJDIuQZjnwe9HPFaiVbBQUBcP/4eHzTqTH7PHyMuNSsrcD/lI2DlG8Qb71H6QNvYZs/4oCZyZT3vHsA8Gb9CwM3YCD1HCW7qWqYazcq2BCNSnWYiedYZUmkVQOGvNuyt9q1+s+7GngN/SmB37/JNXpa98K7oRyrIKN++tFgmxhazUN5ny9OcZ9LUVU6i3Ofv9fR+FOkDNyBGs3SwcloM2736jwiS2YQBPnfU7FrvXz0oX9z6aD1Ar2RaPVKiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZFI/Phy+JZd/vGRiWR7XwopfAjsf6WPOt2e1yY0c6Q=;
 b=h5JdiH8STAtRniCPc20YyLe9CRSOc2AGZuTM1lu2reD9p1Q1MQCZvtwigrkPTeAECPUvsrTrrqT6fjIhavO8+F+F2a6TR+8/dgDZo+pEd2Qnqhgqevv00IwONJ0HTrGm8gWIvRDxajgTRugDpgYuM9NhTjLt43xzTZKkaW5+CYyXVP99s/aAA0GIfd6dpNjqO3RHqqFFJ3BFGFXEU2QaRtwDY42ato3D5nAQKP3MHXR7qjw9GKCfTM/pd3PMBDlUgZqTPnIK7Fj6XfIGhpGDMzh7eXvLqWYSbHxGBUFpRSZz7rmWvly6FpY6/Z2YP6tyNPFW1kF1HAKnYDDax6SX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZFI/Phy+JZd/vGRiWR7XwopfAjsf6WPOt2e1yY0c6Q=;
 b=RwIEmdOiflOKk6a1M386cG4DELXVBDLI8Jwbpk9vl6hX0munVETcCUctUPdZv3SwbEr68lHCnzQmGIk8nrBwIZYLHCGHz7lX5saHw/0gbTOD5XGcowVdwmlwlBFAZ3mV01OyAvIIlORlPNpS9sDM8sijcDQjBBiIX7w3TgrURE4=
Received: from DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 16:52:41 +0000
Received: from DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e]) by DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 16:52:41 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel
 Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] wait: Relate wait_event_cmd() to its userspace
 equivalence
Thread-Topic: [PATCH v2 1/1] wait: Relate wait_event_cmd() to its userspace
 equivalence
Thread-Index: AQHb51GJJozqokvZ4EWcu9m4JxMgO7Q88Q4A
Date: Mon, 21 Jul 2025 16:52:41 +0000
Message-ID: <0BBD3D4E-5FD5-43A9-8677-F6A9D2FBA1BE@oracle.com>
References: <20250627105207.1613044-1-haakon.bugge@oracle.com>
In-Reply-To: <20250627105207.1613044-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB6839:EE_|PH0PR10MB6436:EE_
x-ms-office365-filtering-correlation-id: fb9b0403-634f-412a-30c7-08ddc877020b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YlVQZ3ZaSDAwREU3NWJPV0tZOHltVk11Rms0dDlRa2ZLRlc1M2c2RmI2d0RN?=
 =?utf-8?B?SXRKbURXZ2ZwTmVydUxVTEU1dmNBR2lWeWxiM2FweURvaVBGNmxsUldvbjlL?=
 =?utf-8?B?dGlFK2ZpNFRya1dnQVVidFU3T2NkNGN4Y0VjYWNuSTFTbWVNYmlYbDZPbHZJ?=
 =?utf-8?B?UmUzLzVjcllpOFRhTEdNL0gvWkRsZU1QMDU1bE8za3pjVFRHeVE0RjY2cHB6?=
 =?utf-8?B?Z01CZUh4TFByL1pKWGhZTkU1T3hnb1hDRXhDK1FudUNKUW42dkswR0Q0ZlJR?=
 =?utf-8?B?Rk40NEg3bjlNUHdnczhQWGpSZVRHcTBib0FLQTZWcDM0aWZmdWpwUm5yZGZ0?=
 =?utf-8?B?dVVLZXl0bTVaQnNIY1lvM3p1bFo0SXEraSs2S1FJNTFUUEJ0cHNuaHZYc05j?=
 =?utf-8?B?MWpSTlA5bTg5UEdGcm5PODdGTWZpVUR0OFZBYmY3Z1ZETkpzNFNCbEo4QmhM?=
 =?utf-8?B?WFB0Slh3TEZJT2ZxMHZINjF1QXhYLzhORzRHV0N4bTdub0haUm1ENCtsZVhH?=
 =?utf-8?B?ak1qSkhsNEpjaHNVdjB0eEVXREoveHdHeGhUMFhHR2NuKzZ2SkZpWFhWb0xT?=
 =?utf-8?B?SDE2Qnp1TjRiZmtPTzI2NE9QYUNlK1I1TGE5VHJVRFQzRXkwSklxQzh5Z0po?=
 =?utf-8?B?dDNsL0kxcTFlK2lqSlpIdEdkdktMczZYUEpWRk5jbHJqbGlUb3FTQWhSWUgz?=
 =?utf-8?B?cWJRZlRCYVllYm85MzZVRFhQN0Q2QkIwSVh2ZTJMZXZWc2hJOUZxblNRVzNY?=
 =?utf-8?B?azF3eVRPVjE3cWRDVkE1UU93cFdJUzJMZVhGWnRuN000MW5iVjluTXdsUlVO?=
 =?utf-8?B?bFJTMkdRbVhRb3NkSVdyY1duZDZhUHNMU2pUQmZQc0NJN2tJWWdoc3BiNERV?=
 =?utf-8?B?Z21wNnZyemNnVTU0anhvekVpVEcycnFMRVd1VGhmS3BwUHZJK2FySnBkZWEv?=
 =?utf-8?B?NThPT0VMSUIvbW9TS1JiVWo5MWEyWGtrbjlQUzRGc08yMDM0cm8yNzlUL1Zr?=
 =?utf-8?B?cEVETDJ6WXEvZlhXZGNnZHlrSzQyMHRuNCtURFFLUUVML2d1bVgrVjRQdGRG?=
 =?utf-8?B?NkhEY1VrWTlncXBZaW5HM1RUWk9qY2psTEFQamtHaS9GRk5iL1NFdFo3Y1BQ?=
 =?utf-8?B?RnNUUzRwWWY4NzE2OENjdXZzMDh4NzF1TThYR0R2aitFY1BOSWtEdGRvK2ty?=
 =?utf-8?B?M2p3ZExheC9OTjUwNW5XdUNjOUo0UkhmL2FYUkNaQTN3VVVnYnJzY1Erb3lV?=
 =?utf-8?B?TFlJUXB2ZmJUYjFSUE1yT2xZemM0cFBqUGhoWmFTclg3Q29XYkdPNHFBTjA2?=
 =?utf-8?B?M0pDRHg2ZGZFMVo4NmJyZlZTbUtrSERMVWh4ZjZiaDBpU2E2RURTSzlqR1l6?=
 =?utf-8?B?TkJSYXdXMHFsMXhZTUZEQ3pWVUZzTEkvOCtSeUlmWlcyR0RQR1lUcTVwREVp?=
 =?utf-8?B?enYyTGlGU2RXSDd4V3ljcGVuRVA2dkVFZGd4YUxuR2FkZmY4Sld2WlRVZjlm?=
 =?utf-8?B?NkVpTGw2OU1GTUJkNFdkWHFTb2lEMjhyVlVxcGg2YkNnOFVLTHV6Tkc0M0do?=
 =?utf-8?B?azNscjZwYVVNU1RLWkpmM0p0WElHdWFkMGlRd1ZMT3NvMUd5SFpXRlhCamNo?=
 =?utf-8?B?YmhQM2FtRk1PTDk5cFFORHJYaXRwUWt1ankxVE1UbUc2bHdya2dzQWUyRW5a?=
 =?utf-8?B?bVIyUmE0N2dEdEhNSUVTWS95U1JJNEZBWVR4VEtJZDVqL0duZEJZdzZHSlVv?=
 =?utf-8?B?T0NEa3JFWTJyZGpyQlFyN3doQS9raS84dzBSY0V0Y3pxZGNkV3lUTEkwN1dq?=
 =?utf-8?B?Snl4QitlUTU2U0M4cDA2TzRDc2pMMXBZSnpuZDBnK2JrTVRkRFpQdndua1hh?=
 =?utf-8?B?eUl0R2I3RXlreGphd3VZSW1CM01XbHRkV21GSXlzak9BWnFtRXErd3ZVdm5U?=
 =?utf-8?B?aGhXRUZvSTVrWWpIK0JUSExwbHZibFpxdkNVMDdWS2k5czVUMGJwTmNBQTFV?=
 =?utf-8?B?VGZVaDYvb3B3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6839.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGRadWx2cFRTVVJkSjB5K1J0YUFJR0NIZFRpZ1BrYStCWC90SGU0NzZtejhD?=
 =?utf-8?B?NjZqT05sdERxN2FFWFdTb2JqVDJNNlJPaDJrMXFhb1ViVTJsQmNjYVhmdkFn?=
 =?utf-8?B?SGRhS0hhRDJXT3p0UTcxTjlHU3hUM0pNdXZ1aUlkLytHUEFhSzZqMzhhR1gw?=
 =?utf-8?B?aW9WUXlWeVZGQTJ1UmtYRlNnZTZ0VkcvM3RwdDJWQ0g4NENqak5GcFEyRUpI?=
 =?utf-8?B?M0pWQnVqMXBrYndpMjdQaDJRMSs3T0VjQkFYelExckEzbFBkQjFmWmhzQm9H?=
 =?utf-8?B?QWpkRUx1TUlQR2d4WXNsS2dpRkxrMkdYRUpWK2dMbjljTk1tSURKMW1CUmZC?=
 =?utf-8?B?dnVHSC95T0hPSExMOHZwYjJBc1greS9WNDErSHJYKy9tV01lamhjTGwzTXZj?=
 =?utf-8?B?SEtIblpzU3czWHFBMmlqMXRJVFNkWjBEbmlFVDk2b2pnVGFnZW9UUlZ4SzBy?=
 =?utf-8?B?S3ZRQ1VDVXJyenA4dmhLbng5RmE5OG1BZWJOWnUxeU80R2t1VnFTaHRWS3Zn?=
 =?utf-8?B?MUZZYXpvMjh1dW01UHpYN3JqaitBWlo3dHM4KzlsbENoQlRBbURmSk1GT3gr?=
 =?utf-8?B?enlkZHVaSUFHaHRlUDkwRW1aQWRMZ3JOdkx1Y29uYkxGVE05UGRNd0p3aDdU?=
 =?utf-8?B?ZS90dnlMcGlaWUcwUTg1dGk4czAvNnBsdHpOMWx5YStDV2ZXMDRCeFAxNldR?=
 =?utf-8?B?NnRMelZIQXUycWdEYzlQem14M2gzQ0Z5TTdBZmg4MUUyVkZWYkFjbEpwTzZj?=
 =?utf-8?B?OGVKZllLR05IallMNDgrcmljUGlVMStYK2h0Yzd1cDFBRzgvR1JnOEJoMExS?=
 =?utf-8?B?RjdFWFp6b082czBHQlVuemx4OFZ3dExQU2tvdlNkWjZhSTJVS28rQkJHU09C?=
 =?utf-8?B?OGwxRTZNaWhBU01rajF4L2hDWXZhNit6ejlNbVQxaVUybHNmdi9lQ0daL0pE?=
 =?utf-8?B?NDBOV3JhT0pPbmJDaTZOOXVwd2Nsak1pcTdsaHpGa2ljMTVNWDBlRmFBSXVX?=
 =?utf-8?B?RTIrekQxNkVhejRtTlVuQmpXb1g4LzJ3ejZSc3gzSy96T215bEo5TTZNYTRL?=
 =?utf-8?B?eXlUWXdybUFtWDNxbHcxMkl1OTJDdHZDVHl4bCtNV2tHcnFTWk5rdS9CYTFW?=
 =?utf-8?B?cFNXeXA2MjZQaEJmbjk4WjNSNlBELy9vMStTNHVLZDhNYS9FZ202MGxIZVNm?=
 =?utf-8?B?QkdrNXUvV096VkU2d1NhNUFENVdlR05Cc0FYQWNHaDYwT3FFQldTelNxTkxU?=
 =?utf-8?B?bTk4aXZpWWNQQ2hZYlU3QTlZZlNlcWpSZmR2SFZGaVM4TXh2TVRYQVRZN1Vv?=
 =?utf-8?B?Qy8xc2pYelQwYzRQNTRnSFdTNm50a3pUL1A2YjdoMWlzYWx5ZnVFSldadlNs?=
 =?utf-8?B?Nzh6bDNlaUVLL0tjMDBKc2lxM3dpWXlDNGlqd2R4NjJ2ZTc5cTVndUt6VGk0?=
 =?utf-8?B?Tkt2cWoyMmh2YkJaYVlSSm9NM0drZjNQcEdTWmU4VkpsbTJ0OXl3cnJFcFho?=
 =?utf-8?B?dGZrenNrelY3REw3SnI3SXlvWGxsV2Q4TDNhZTN3Y1pWUk9obWRtN0owUlpK?=
 =?utf-8?B?UXhYRG1mTlVxYlExYXo1eXhYSmUrRzFTZ3pONUhTb3M3VlVTOVdrY2RycC80?=
 =?utf-8?B?cWxTaTVhQnRLV3dVbzdqOUdzWThWZDJJcXFTUXphMmRHYkdVQUdLd3QwUlpu?=
 =?utf-8?B?MUJJMmZzOUtpeThORElBc2NVTUZSK29lbUdxMFh5VnA2TVFlTzE0Wit3WFF1?=
 =?utf-8?B?dWUrRmhVeUtUN05UWEJvMHZIcGJXSTc5bS82Mk1RdU1wQ3lpdDEyaWpTWlQw?=
 =?utf-8?B?RXpDMG1BQW1wclcveWFHcjRjU25rMzhrZFg4Y2E3UEVRKzdUT3dPTVFjemVF?=
 =?utf-8?B?Q1g3dkY3bkgrTEZDSFhVM1BVNHcxVEpqMmFjOVg4bDlsUXdVOVVEbE1ianIr?=
 =?utf-8?B?bFpVZFZ0OVQrTGhKN0F1eTdaRUpsOXk0SFk4VURJVjgrbGtYVjVPeTU4eGZh?=
 =?utf-8?B?N3BIWWpQR3J2MzdPTkhnMWNrRGZteWNKamNNaG43Y2FDaGZndk5WNTZWU28r?=
 =?utf-8?B?bzZLWWszK1E3TXVVaENadjFiMjVUMzR5Qm5aSEhOZ0RMTiswb3hLR3hWQ3Yy?=
 =?utf-8?B?NDByVFgrS21qZWFEbHg3U1BnK3pBV3BLc0s2dkttZXNqenM4ZTFCcUdFWFFm?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5818E0C100C2CA418E9A6F9F6194B4DF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gw++jD5HwQUP7T+u+yhMZg3JGa/YPa4Hr9nN1gN1kf0iGRozx6l5BPcGWXa/aKDDslXZMjxeQXkiygLaEkVAZC+i8aNvO8Hee4ICRV+SICiawc1LwA2fbIeHguvGKXCoOS2FNKF7p7qNgPguy0ADoA5u7JTh0BK2L5pxEG+f4xVE6BMPJf5eSiGKqOLDiOV8XyqstvQKsuMl2X2MKxvjZp21jK6d4pIQjOym+fOE1IZGGhCseK8fqXMBsvMhDPMl/c/AzHpU8hn3hRT+FiEi7jLsbBhQUSkAtsdv7U8fQnYrp7/TVNl9hfYKWspTRST4pJRGO0AyQUJely3p0Cg5fdhNOyKrdLKlCBCy3y78e8UNz4rAnIhxvYNhPdyV6zUgnm3506EQorusQqWfNRAP1Uyk7BLLGmzwP1fEVS0cgcXuTNc0oS/zMlHsbBmkIhb1pkdufVb9J8I/J96K9H3G9jS1hFbk0O8jlrSHbMKj0nSxKT9FxXwHxcXoWyNfKAWEWfHcH59Zh+SFgQ5NvlYcUpTi7BhHRyh/SdRUDuTd1DZLsC7AggShOKjCLUkth8Z0sepNlZ30i7k2TVaN68+GM/AoYYm/HBcPPO+L+6hUmk0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6839.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b0403-634f-412a-30c7-08ddc877020b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 16:52:41.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbhBj+gVl9PYiBdhai3oviZhiP4/jAGl9XcHgm/5Ki4EjgaV2d53ANuc00FrumH22wCY6JLBtja3xk1vFH0MbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210149
X-Proofpoint-ORIG-GUID: 4NWhCe_M1X7pGu82IVns6ynv2YoEaEhR
X-Proofpoint-GUID: 4NWhCe_M1X7pGu82IVns6ynv2YoEaEhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1MCBTYWx0ZWRfX0szVWAZwcltD
 pkYvffHXdxFLrXe9wv3CtEPWEz1Oc3gdfJc8nPDjEPj2aq9kfPkAvvpA1/ZmxzlHmUrPynSuaDs
 m9H1PA8rE/jXLaj3txGdmiUanbcm21d9wzFZDA0QYHLvZbiLzwnAqlt+0brcKn9R0J5gRxe6Je9
 JdTG9sXNGeREcTNpLmFquIsVlQRXyy5UVtCeT0JmqzV205pb+lYEhfl9DHjFPhAwkDwX7LUlYdP
 sexUU/U8MEjqr9oDkha93CTkLM+Ro5BHkFoozJ3z/xn2v7B/0N20/It55vLpa5RkCuCeFRHErho
 f8yM/wUNHsdeQfkUpsLQvZszR2WxmLxBPvdvzdPOmZuLy3B48nd50WMxC5v7czjWXV7uBeQE/yn
 UWBUpBi1ooXo5XTQ3YKONxZdhHWlYWe72tZqEgd1zW/P9M6+Sw10dERpJzEt+48o3SaA09nB
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=687e7061 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=w3mpzlLb4SduKCTSkx8A:9
 a=QEXdDO2ut3YA:10

DQoNCj4gT24gMjcgSnVuIDIwMjUsIGF0IDEyOjUyLCBIw6Vrb24gQnVnZ2UgPEhhYWtvbi5CdWdn
ZUBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IFJlbGF0ZSB3YWl0X2V2ZW50X2NtZCgpIHRvIHVz
ZXJzcGFjZSdzIHB0aHJlYWRfY29uZF93YWl0KCkuIFRoaXMNCj4gYmVjYXVzZSB3aGVuIHNlYXJj
aGluZyBmb3IgZnVuY3Rpb25hbGl0eSBjb21wYXJhYmxlIHRvDQo+IHB0aHJlYWRfY29uZF93YWl0
KCksIGl0IGlzIHZlcnkgaGFyZCB0byBmaW5kIHdhaXRfZXZlbnRfY21kKCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KDQpBIGdl
bnRsZSBwaW5nIG9uIHRoaXMgb25lLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCj4gDQo+IC0tDQo+
IA0KPiB2MSAtPiB2MjoNCj4gICAgICAqIFNwbGl0IG9yaWdpbmFsIHBhdGNoIGludG8gdHdvDQo+
ICAgICAgKiBXb3Jkc21pdGhpbmcgYXMgc3VnZ2VzdGVkIGJ5IE1hdHRoZXcNCj4gLS0tDQo+IGlu
Y2x1ZGUvbGludXgvd2FpdC5oIHwgOCArKysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC93YWl0LmggYi9pbmNs
dWRlL2xpbnV4L3dhaXQuaA0KPiBpbmRleCA5NjVhMTk4MDljN2U1Li42MmRmOTgxOTNhM2E3IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3dhaXQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L3dhaXQuaA0KPiBAQCAtNDY5LDYgKzQ2OSwxNCBAQCBkbyB7IFwNCj4gICoNCj4gICogd2FrZV91
cCgpIGhhcyB0byBiZSBjYWxsZWQgYWZ0ZXIgY2hhbmdpbmcgYW55IHZhcmlhYmxlIHRoYXQgY291
bGQNCj4gICogY2hhbmdlIHRoZSByZXN1bHQgb2YgdGhlIHdhaXQgY29uZGl0aW9uLg0KPiArICoN
Cj4gKyAqIFRoaXMgaXMgdGhlIGtlcm5lbCdzIHBvbHltb3JwaGljIGltcGxlbWVudGF0aW9uIG9m
IHVzZXJzcGFjZSdzDQo+ICsgKiBwdGhyZWFkX2NvbmRfd2FpdCgpLg0KPiArICoNCj4gKyAqIFdo
ZW4gY2FsbGluZyB0aGlzIGZ1bmN0aW9uLCBjbWQxIGlzIHR5cGljYWxseSBhIGxvY2stcmVsZWFz
ZSBjYWxsDQo+ICsgKiBhbmQgY21kMiBhIGxvY2stYWNxdWlyZSBjYWxsLiBUaGUgbG9ja2luZyBw
cmltaXRpdmUgY2FuIGJlIGNob3NlbiwNCj4gKyAqIGNvbnRyYXJ5IHRvIHB0aHJlYWRfY29uZF93
YWl0KCksIHdoZXJlIHRoZSBsb2NraW5nIHR5cGUgaXMgY2FzdCBpbg0KPiArICogc3RvbmUgYW5k
IGlzIGEgcHRocmVhZF9tdXRleF90Lg0KPiAgKi8NCj4gI2RlZmluZSB3YWl0X2V2ZW50X2NtZCh3
cV9oZWFkLCBjb25kaXRpb24sIGNtZDEsIGNtZDIpIFwNCj4gZG8geyBcDQo+IC0tIA0KPiAyLjQz
LjUNCj4gDQoNCg==

