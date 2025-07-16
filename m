Return-Path: <linux-kernel+bounces-732761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A96B06BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D54D1667BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830422749EC;
	Wed, 16 Jul 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="UQX4eD/Y";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Ea4Ps85B"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C1522F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635007; cv=fail; b=S4AGMSZsm5TiOPNiObsQBjL8biV6Rg8CBnigA1qUgW9yQ77Mk9tY6mVnqqX11EnsWOQw70kR9jT4qok62RMC2vNtGvgJYaj6q+QxG6g779ervrTnr7KEOwv73RVL+SDuyKHNYpgpb9alZHG9v60+ZHtW4nbFgcaaYseInGum3NE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635007; c=relaxed/simple;
	bh=lm/wxNNtvUfFxzkNdFiBWS2Nh1BU8zopx4pqOTneIok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RkwnEpORComkY4Hmn6rCDKTRQNvCLmg2q6FlNKJarDbIqNp/IyZ0dWqKPc+4GoDxaz07ei6Y3IRypTGtReviRLimsXYgtWNvQvPoLCNzEDMCkGMjnFI6y6g0W15J7lWtyHiznSzA0KUmav+TjhomMCNpKNzBQ9PjImVbvenwb9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=UQX4eD/Y; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Ea4Ps85B; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FHPf8P013966;
	Tue, 15 Jul 2025 19:47:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=lm/wxNNtvUfFxzkNdFiBWS2Nh1BU8zopx4pqOTneI
	ok=; b=UQX4eD/YA8tvR6TvtI5dqlQMDFbq9TDn/PP73RasNWQBIeycUnKWA9Wb+
	dxavB3bvfnOZGBRliM6T5VDMyq5k774+e5sXyXwh7Hf4Dgxaj+ADA1/01t38XmWS
	1t9DILGTL0B7ozL3XYGUcFyNPsIAWwMAzCN3qZsMZDrJhKUcKAUCOESMi94D6AhF
	IAwa5vvspOip++wjpKwuiFSqtjeXTAxOBcHuUebhryY7BC4m91q5blda6N1oqKeM
	P+kWH3qdmoVLY5ko5iIWM7b4F4ROHmpoESQIMxPs8d9LiV+iI2X1XDcbMkz6zrp+
	C4tSTtMuSvseD1mL8iFdIxpkrHu4w==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2111.outbound.protection.outlook.com [40.107.95.111])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47vscfe0ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 19:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTBDb/ALthvr+37gre1uOUGlEqqIBd2dkhJtS12/Yx964NnyvZwfxSE6SY7/nTSTfnI5OnphtriUhfORS5JJjA1zwHJsuHyjxrtAdPElu+Y9ZVNeWFaL0P9eUhZnhe3EYmXFb3N38piAnUMMyx1vUZCHWkQ4uePaNPq3rkWy4GPtzZHJSXBYCj+KMUzUpZ6zv7dK6Hi3FkjP1bZDkNKKk9D1FBhgk8EoxJYwWT5GAiGWCFaqdWzm+U/rC30642+AAY7X/MEKTJ4VMdrvVQ57yg/u5Kb9d0YfREOZqAAGu6LEBGqj9Gef3EksQdJjQOt3Zf6aPeyCnjSy8R9zVKn7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm/wxNNtvUfFxzkNdFiBWS2Nh1BU8zopx4pqOTneIok=;
 b=gg8bJCN/ie2c58e3EKJ2POaX1Toz4RmAE3iFJbTTL/Gz3/zZl6SqWnR9yoty8SufGU3JqpivM4eYqIWEJYBLo0IVTEpOK8oW/yf3NfVsKCoxnN3H8FxUkv0gD51dny67Ob2aqMXyuvUddgZkiZc+bI/4aFKGQJmpTpgxB5fUmBrmj5qRXP+qwGLSaJ7O1ucZd2G3mKpSJ/iA0CUqvgu3T/eCMU/IRjwn4ILyjcxUDuQSnSOsG4KrYwPjaNat6oykbz/zQwy79t2uk+FF6+DlS2b5Yr8Ek6JdKFbikAdKbEuy0n/84bvgg7hNYRKyaZZjZ/LkKAtcHE2ncRm9jmCqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm/wxNNtvUfFxzkNdFiBWS2Nh1BU8zopx4pqOTneIok=;
 b=Ea4Ps85BaEAghBLv9eJK3S1FKi4LT9D9Fi+/l4+yTxVn5ATj89WgukjQs3qYA5tEqouo3iG+e0NQDPzHZD8OSzUJxDghBASGnvTDbx5aUjLUTWEk8V12e8+sWVC1Uj2nVy7SEDtVAUirq/BFihD+zSUTbZcxa8ZUtVWjZIyoqjf22wAWUiKIWf7P1IoVJwmlofAZcVZAx67zOvBWNMYWj15NCbUw5es+rsirAdI8INUiGL3mJXnuqBlLnKYVPD1eAcESc2liIMx8cb6O4fmPCIygJcl/TF+fEPciJcvpvK4z5R505eN1VdsDgOHhTltTtQuRcpBqOpeaCKeeb+VBRQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by IA0PR02MB9219.namprd02.prod.outlook.com (2603:10b6:208:435::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 02:47:54 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%6]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 02:47:54 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Zicheng Qu <quzicheng@huawei.com>
CC: "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com"
	<vschneid@redhat.com>,
        "raistlin@linux.it" <raistlin@linux.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanghui20@huawei.com" <tanghui20@huawei.com>,
        "zhangqiao22@huawei.com"
	<zhangqiao22@huawei.com>,
        "judy.chenhui@huawei.com" <judy.chenhui@huawei.com>
Subject: Re: [PATCH] sched/dl: Fix race in push_dl_task
Thread-Topic: [PATCH] sched/dl: Fix race in push_dl_task
Thread-Index: AQHb9fFuy3NZ1HAYZkCf2KN20920NrQ0C8iA
Date: Wed, 16 Jul 2025 02:47:54 +0000
Message-ID: <11E57357-EDAE-4C7A-B292-3BD41BCFA9CF@nutanix.com>
References: <20250716011516.3591655-1-quzicheng@huawei.com>
In-Reply-To: <20250716011516.3591655-1-quzicheng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|IA0PR02MB9219:EE_
x-ms-office365-filtering-correlation-id: 332a15f4-1515-40a0-6937-08ddc4132a2e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDVjRHdMM1B4NkU2dDJVVnVRekg0amlXZWRJV1l3QjErMjlzcGtMdHNVQTJE?=
 =?utf-8?B?Yk1JaGQ0eUVUL2EvaTltYS9VSFQzTXh2OEpWZ0F4dUxXNjhnNXZUelEyNGsv?=
 =?utf-8?B?UmZXSVVleHVRZkNvN1pDWVIvUVhhOGZDb0puTFozM2FZU3RESUgxelQwK21a?=
 =?utf-8?B?YjUzOUVaL3FMUm5kRjNiby8yNndvY2RRUjVtaWNEMWx1UEE0Q2tzL3ZLVGN0?=
 =?utf-8?B?M2pTS0J2cFBmc1pzNjVwVVl1a0Y4dzl6OHRYa2p5T1BhVVg1TE9BODYydUpV?=
 =?utf-8?B?M1FPS3hmMDZJQnl0R3A4RXFKdm41WU5CNWcxc1UrUzJYbG05dW5kM09pWisv?=
 =?utf-8?B?VXhvMlphRXZQRDJrRXViUk1OS0djNzRwQUI2QjR6c3A3dlQ2Zm1vU0Y5U2Vz?=
 =?utf-8?B?UUNNejdGMm1HYzFoYkJZZ01BcWs0eWxHL3NCREtwOEZETWhjRVBka2Q4Qi91?=
 =?utf-8?B?NFRSQW96c0dVeXViTUVacmJ1NElTSjd2ZHlYbTJBd3Rqd3JBeUtxNnBtWFFj?=
 =?utf-8?B?SUw5K1d1ZlByd3QwYmZST29vUWhjdWk0R2hBVi84YXhTNEZxYTdxZEQ3VWk3?=
 =?utf-8?B?SDBwYUtyZlVMd01CVTFCc3dhRmF6MERESTFxUjBETU9nKy8rdEFDNnpNL3hi?=
 =?utf-8?B?TitaVWxncXdvZG1PYWJIbWRyRk5HQ2oxa3ltZi9vZkhoM1JTVWxLSnhPSElJ?=
 =?utf-8?B?L1dkSXFYNTdLODd1anVnbEl3T3R4dkRnU0NGYjE4OHNlZlRmUHRxYVZWeFRG?=
 =?utf-8?B?T1JOUWVmL1dYcVhneXR3MDRmZ0Z0d2t2ZnZ1a3BTR3lMb2wxM3hTcTE2MzJY?=
 =?utf-8?B?cVpLdTFqQVNFSnV6MHgzM1lEWjdzR1BGMW4vT2cxMFVPZzNkU1VkQWVObTR6?=
 =?utf-8?B?YkhqQURrV1p5Y0xvdkFzaXVnNldYUWdmdS8yaXNiSVprbzJ5RjI3Tk9xNUtT?=
 =?utf-8?B?UE1qTjFFWGZDdzdvdG9vREhEUFQ3OXJSY0FFZ283MndrYXlqdzZIZk9Gd0RM?=
 =?utf-8?B?S1VkZlhyWmVuZytmNWdpRERzbmsvcUJqSWE0WXczdWpSTE0vSUN0MjI0YVRS?=
 =?utf-8?B?czZKbkdEeFBzb0dIbFFHczZHTGkzQmIrZUFxRjVQbm5SUEZnVVZzdE4vcXow?=
 =?utf-8?B?Q0lGMld5Uk9iQWFUVU1pUmZZUEE2ek1OK2lmOWlzbGFJOVlqUFFBNmFGSWRj?=
 =?utf-8?B?TjBDMUkvMldwbUZ0aUZPTGVYN3ZNWXdZcUJMbWU3V2htdGJGL1VVdWJ6QW13?=
 =?utf-8?B?OTFMelpBVTZ5SnFRRHMvL0FHd0NOWjhoOFRoR2FEQTR3NFJqemFwNWd0WU11?=
 =?utf-8?B?UEMrNDhnTVhNK0NjMExsN2tSbkE3Mk14cTNRY1plTGd2eWVFb3E5Zmtla0ZD?=
 =?utf-8?B?VFJEbEtRbzV3UVJORDBIYlJGM0szUWs5ZkRFUEh1dXl4RGRldFhRZ1NBbnh0?=
 =?utf-8?B?NTUvaEtvY2dud25qdmVXUkxpdWRMSHg5c3pZdVN1REFtL2dkMDNKbDR1N25Q?=
 =?utf-8?B?cDJlekJmL1M5NmpCZGFjaFRSQXp2bVVJNHVWb1RtVmgxSmNEQ1ZlRWY2b0h6?=
 =?utf-8?B?QjhNbmsrcVEwTThiait0Qmg3czJLOVBWeHIzWEZIS25rOHFsdVNPNDBxVm9j?=
 =?utf-8?B?RFM3MFY1K3laS0szaGx4cy9id0NNQmRoeXplaGdaNVFRcGVsTWtXSHpKa2x2?=
 =?utf-8?B?aTFyRUlmbVgxQmNqczJmdTlnVVlhaGRGdyt4aTVvemRwUFh6WW02UUJqQlZx?=
 =?utf-8?B?cmUxd2dTc2wySG1uNEVVS1lJdi9CcndPYlRQQ1picm5UeW9zQVZYdEk3THor?=
 =?utf-8?B?Y1M4a0Q2UGV0WDkrMEk3SGpuaDFSdWNMUnlJUEYzV3FuYXc4QVF5S0R1d0g3?=
 =?utf-8?B?TlFEci9weS9pcU15b3Mzck5SSEo4Vkk3a29Ka1p2UXZOMGtuaEJmKzFqa0RN?=
 =?utf-8?B?VkV5Nm4rZ0V2VXdzSXpSLy9UNDlTY2VYcEY3Mm5CbWdsYXhUNExpME9FbWND?=
 =?utf-8?B?aVhuZlBtU1JnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHl5VmxYcS9jeTgrZnJBcDlWeGE3TXVINStseFEzYkhBV0g2YWMvQ2RadExC?=
 =?utf-8?B?T3E0QTZlZVJwUHJGYzB3UGI1bTVqOW9qUStxcko1V0cyMGU2WkRDWWlmSkxl?=
 =?utf-8?B?ZjdLZE9WemxDS2NoZ3c5dWpvK2FvUXBuOW1RNGQ1NHBDaitldlgxdHl5Tjk4?=
 =?utf-8?B?Q3dYSDJzVHZYMXBjak5FRTZKalNrT3NsMFFha01oRXRpQmw2UVNLS2hxL2cx?=
 =?utf-8?B?eVNqalhlSk9IQ21OK0NoL1hQMVVyN2VDaW1iTFQ5WENMeEpDRkU1bUYwOU9T?=
 =?utf-8?B?R2sxZGx3R3kvRzlvRDJQR2NKdjMwTHVPcFFFUjl4dStEME5iUENqRE91ME9N?=
 =?utf-8?B?Z3JIOXp2RDNNTkxGQVJ0eERvNmRVUk9XdEd1QkQrSWdMMDFaVW1ZVXI1czhs?=
 =?utf-8?B?cWZwaVRMVGx5L1BjNEpXeHl3bDg3djFKM1cwd0c5THd1ejhSQVZOUUlramxE?=
 =?utf-8?B?bGZVLzc2U2JOZStUdGtGejAwb1pMUnlkZmpzUTRRUElkdmR2eDBCMmJuWmR2?=
 =?utf-8?B?aUR1VHJJYW96YndwSG84WklJRnlVYVVkQkdGMmREbklZOEhwVnBZVVZ1UFdD?=
 =?utf-8?B?Y3l5QVQxalBTUHRZWSt0R3lZa0RUZC84YjNTNWdvdzR1aWhXaE9FNmdONjF0?=
 =?utf-8?B?Wis3ZjFvTzYvdEQ1cmFyNWxLeEkvZktPYXdUa2pPWldLWHVIaEZSTS8vMzI2?=
 =?utf-8?B?T20vOG1QK2xZSm0vR3RualBhaUxmWmExcHBzWFM0ejFtSllacFBsOWpzTmp3?=
 =?utf-8?B?SC90dVJhM0JvdnJNOWlXdGdtcWV2RVh2bDM4SE9meFVqem9haEQrSSt2b1o1?=
 =?utf-8?B?MUZxU09aMnc0VlFmN1dYemVJODdJQ29TRXlEcURTOERkS0dsd0pmVisrNFhh?=
 =?utf-8?B?ZHduVVhwN0NpR3BlUHFqYkQvN1VFM081RndTb2lOaVFmU3BCVi9La3BTMzlI?=
 =?utf-8?B?MHYxc2xEQjhwMzlNbk5WdTJ3elAxLzlZaHc5R2FzMGNLcEpQY0xhL2paRDdx?=
 =?utf-8?B?dlFmNFBJQk9lcHFOb3ppOUdzbzdMZy9EcUZmU0hWbDNXL0NPZGRjK05MRDFo?=
 =?utf-8?B?SllSNWgxWk1YSEN2UlA4SXYxTWM1UEhUa0ZKN1J3NzI1SWhqKzlJK2tpb3pE?=
 =?utf-8?B?SGdXUTVYVkQrZ1R3OG05blZMQzBiM3pEUmlOZEpNOHZHd2JDMU9PRHo1ZDY1?=
 =?utf-8?B?aEpBc0tkUUlYRWVIT2k1aGt3S2szM3UvNkNOVU54Q1F1ckk2L1hVam9WMVdO?=
 =?utf-8?B?VXJrcVJqR0ZzYmd2SEMrV1JISUVmQm5RWHpFa1ZkOEx1VkF2TFF4enVXMTJ1?=
 =?utf-8?B?OWRjQzh3UUc4dGlrYUJJY0svK29DKzNHSld1S2FCa0t3YnZLYXlkdlFIN1p2?=
 =?utf-8?B?WGlxREllcXIzVzJ6ZzJ6SHhBQVhTRHAxd1hHbjUzQTI0eWUwZGI0b1l5dWFk?=
 =?utf-8?B?Mk9XSHpjRWRLWDVXQW85Nmlva1pkb1IrSTV6NkFiS0t4bmVKN0Z4T04wcDJ6?=
 =?utf-8?B?aFVWZUI1L1JidnQrR20wWUNBbDhIQk1ZbDF2NGNPeWYwUVlGZjZGaUJhV0Vs?=
 =?utf-8?B?dnlMK1BCM1ZCMzdXYTIxYUhLem1VTGt1M1dMajN2bVNzdTdWRlFNdmlJaXV0?=
 =?utf-8?B?alZuRG93RldyeFJRT2MrTHk3ajFPVi9tNm5LRXVJVFcvUU1QRC9OZXYwRXN3?=
 =?utf-8?B?dXFMNmQzMHFGYmVvdWhoSVVvbEgwYjhJZ0hUS3NPYmVYMzBVQThmRHhFQWR3?=
 =?utf-8?B?d25YblBJZ0RPTXZ0TmpHVTdEMEhGRlFCNW9XbUdrWEJzdlU5ZHdVOWxEN1Bp?=
 =?utf-8?B?eDZuemtYTFd4dTl1OUJDZzJnZnp6a2FFVnQvcEIxb2FsM21IMENiUkVqSmxn?=
 =?utf-8?B?WUgzRDY1bWZqOEV2dC9nRVpqU3h2SzZ1TjZib1NROFkzYURLNWdrU0NqQjdZ?=
 =?utf-8?B?Mm0zK29Yd0tJaXRaQTZqOGR0azZaamU5bEpvQ3NuQkozRzZhcThMN3lXRGEw?=
 =?utf-8?B?eTRXOTFscU5aN2ZQWVlpamdBcS9MRno0NmdPUiszM2xlaithT2Fha3hMeEFY?=
 =?utf-8?B?OWh6K0hNUUloYk16RmZRMlVEcHZIS2RBNkdUb0RRZmNBbFpQKzhrUkR3dU1x?=
 =?utf-8?B?L29VT3pWUE1EWC93cTlJVFI1RmhxWDQ0YkthV29LSTUrU2pTOUdncThoZmJG?=
 =?utf-8?B?VVdjc0UzUFNYbERKb0F5YnNtQUd5VkVnb0tGd0YxOUZXM0tienpUNU9qTlpD?=
 =?utf-8?Q?k23KU6XAItRpzYHIjqSdsr0K+2JEvabTSgTTYaA8o4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F0165704017D4CA21F7AFB9AA71FA5@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332a15f4-1515-40a0-6937-08ddc4132a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 02:47:54.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffCQ2dCibRWkbYYWhH9YPi4qZOdWH7XqDSQj8yvqDGrhoQuOwauQbmAhi1VITSSXELE67YO+Ew78X6BCYfoqrTVodRsGgZ4vX7UOmUHcj18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9219
X-Proofpoint-GUID: fx2RS_PrRU5_-3OKw5TZ8ADRZMbEpXrn
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=687712dd cx=c_pps a=JO+ofU2DrwLhH3X65ZtMrQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=i0EeH86SAAAA:8 a=1qmy6V5osgmOyCbuNy0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyNCBTYWx0ZWRfX6PDhFBPl1yRV 7MBSqKfcyovP9RAq+984dc5V5BdPzsM/kbNCjTgeUB+JYmcCLti/GV73gbczZSMwEJlOkU6ef3B Lhc1YA2N9ASTF8CSXNk01Biv68Ki/LQX4CnAKrhEd3Z8GEv0OsSLFPTpS3zBAci1+cSZ2bongNr
 dTJqHQ0ksAbKHf+QTBgLPMnK0E8UcYgdWgKjAPDf046kjv3xQzdlJjyZKsQerqtCGQg/1cdZx6r ubvErQg3poiit4AB/1MqHxfK+NzUAWrzeDB6CIJdGJLNqKjdn7rtU9AWTikqDOLVS6G166vgg0G xAtzr9qya8lGv9DNqKSNKyaUv/LUAubXos3Ga9Wwy7Dn4ZiWTO125lofDxt1h8FDCPhHhnJiMzk
 PaQMn8WvR1k9Xz1Tpk7LpWb9ooFAN+kn6NbHfO5PUbiVvbFD9l/H1rEB6K+zEMT/yYbku7kB
X-Proofpoint-ORIG-GUID: fx2RS_PrRU5_-3OKw5TZ8ADRZMbEpXrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

SGkgWmljaGVuZywNCg0KVGhhbmtzIGZvciB0aGlzIGNoYW5nZS4NCkkgYWxyZWFkeSBoYXZlIHRo
ZSBkbCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggcmV2aWV3ZWQgYnkgSnVyaS4NCk5vdCBtZXJnZWQg
eWV0LiBZb3UgY2FuIGZpbmQgaXQgaGVyZTogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21s
LzIwMjUwNDA4MDQ1MDIxLjMyODM2MjQtMS1oYXJzaGl0QG51dGFuaXguY29tLw0KDQpSZWdhcmRz
LA0KSGFyc2hpdA0KDQo+IE9uIEp1bCAxNSwgMjAyNSwgYXQgNjoxNeKAr1BNLCBaaWNoZW5nIFF1
IDxxdXppY2hlbmdAaHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENB
VVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IHB1c2hfZGxf
dGFzaygpIHBpY2sgdGhlIGZpcnN0IHB1c2hhYmxlIHRhc2sgYW5kIGZpbmQgYW4gZWxpZ2libGUN
Cj4gbG93ZXN0X3JxLCB0aGVuIGRvdWJsZV9sb2NrX2JhbGFuY2UocnEsIGxvd2VzdF9ycSksIHNv
IGlmDQo+IGRvdWJsZV9sb2NrX2JhbGFuY2UoKSB1bmxvY2sgdGhlIHJxICh3aGVuIGRvdWJsZV9s
b2NrX2JhbGFuY2UoKSByZXR1cm4NCj4gMSksIHdlIGhhdmUgdG8gY2hlY2sgaWYgdGhpcyB0YXNr
IGlzIHN0aWxsIG9uIHRoZSBycS4gV2UgY2Fubm90IHJlbHkgb24NCj4gdGhlc2UgY2hlY2tzIG9m
IHRoaXMgdGFzayB0byBtYWtlIHN1cmUgaXQgaXMgc3RpbGwgb24gdGhlIG9yaWdpbmFsIHJxLA0K
PiBldmVuIHRob3VnaCB3ZSBob2xkIHRoZSBycS0+bG9jay4gVGhpcyBwYXRjaCB3aWxsIHJlcGlj
ayB0aGUgZmlyc3QNCj4gcHVzaGFibGUgdGFzayB0byBiZSBzdXJlIHRoZSB0YXNrIGlzIHN0aWxs
IG9uIHRoZSBycS4NCj4gDQo+IFRoaXMgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBpc3N1ZSByZXBv
cnQgaW4gQ1ZFLTIwMjUtMzgyMzQsIG9uZSBpcyBydA0KPiBhbmQgb25lIGlzIGRkbC4gVGhlIHBh
dGNoIGZvciB0aGUgcnQgYnVnZml4IGlzDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50
LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX3JfMjAyNTAyMjUxODA1NTMu
MTY3OTk1LTJEMS0yRGhhcnNoaXQtNDBudXRhbml4LmNvbSZkPUR3SURBZyZjPXM4ODNHcFVDT0No
S09IaW9jWXRHY2cmcj1RVFBWaE5nSDcxNi16VV9rUG10ZTM5bzN2R0ZWdXBuR21tZmlWQnBxOVBV
Jm09bC1GbE83ZjBhME80eE1jVzJjUy0ydHhod05DanNqbVhOS2g3dVVpTDNtdWdPZlE3M2VZQ3hp
akQ4MVcybFBxZCZzPXllVFZfU1p0aHpyQnNHdVpDUFQ5QV9BbnM0WmU2VlZoV25rNkluZ1V0ZzAm
ZT0gDQo+IA0KPiBGaXhlczogMWJhY2E0Y2UxNmI4ICgic2NoZWQvZGVhZGxpbmU6IEFkZCBTQ0hF
RF9ERUFETElORSBTTVAtcmVsYXRlZCBkYXRhIHN0cnVjdHVyZXMgJiBsb2dpYyIpDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFppY2hlbmcgUXUgPHF1emlj
aGVuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4ga2VybmVsL3NjaGVkL2RlYWRsaW5lLmMgfCA1MyAr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAxIGZpbGUgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
a2VybmVsL3NjaGVkL2RlYWRsaW5lLmMgYi9rZXJuZWwvc2NoZWQvZGVhZGxpbmUuYw0KPiBpbmRl
eCA4OTAxOWExNDA4MjYuLjNiNTNlNzFmMmI4NiAxMDA2NDQNCj4gLS0tIGEva2VybmVsL3NjaGVk
L2RlYWRsaW5lLmMNCj4gKysrIGIva2VybmVsL3NjaGVkL2RlYWRsaW5lLmMNCj4gQEAgLTI2MTks
NiArMjYxOSwyNSBAQCBzdGF0aWMgaW50IGZpbmRfbGF0ZXJfcnEoc3RydWN0IHRhc2tfc3RydWN0
ICp0YXNrKQ0KPiByZXR1cm4gLTE7DQo+IH0NCj4gDQo+ICtzdGF0aWMgc3RydWN0IHRhc2tfc3Ry
dWN0ICpwaWNrX25leHRfcHVzaGFibGVfZGxfdGFzayhzdHJ1Y3QgcnEgKnJxKQ0KPiArew0KPiAr
IHN0cnVjdCB0YXNrX3N0cnVjdCAqcDsNCj4gKw0KPiArIGlmICghaGFzX3B1c2hhYmxlX2RsX3Rh
c2tzKHJxKSkNCj4gKyByZXR1cm4gTlVMTDsNCj4gKw0KPiArIHAgPSBfX25vZGVfMl9wZGwocmJf
Zmlyc3RfY2FjaGVkKCZycS0+ZGwucHVzaGFibGVfZGxfdGFza3Nfcm9vdCkpOw0KPiArDQo+ICsg
V0FSTl9PTl9PTkNFKHJxLT5jcHUgIT0gdGFza19jcHUocCkpOw0KPiArIFdBUk5fT05fT05DRSh0
YXNrX2N1cnJlbnQocnEsIHApKTsNCj4gKyBXQVJOX09OX09OQ0UocC0+bnJfY3B1c19hbGxvd2Vk
IDw9IDEpOw0KPiArDQo+ICsgV0FSTl9PTl9PTkNFKCF0YXNrX29uX3JxX3F1ZXVlZChwKSk7DQo+
ICsgV0FSTl9PTl9PTkNFKCFkbF90YXNrKHApKTsNCj4gKw0KPiArIHJldHVybiBwOw0KPiArfQ0K
PiArDQo+IC8qIExvY2tzIHRoZSBycSBpdCBmaW5kcyAqLw0KPiBzdGF0aWMgc3RydWN0IHJxICpm
aW5kX2xvY2tfbGF0ZXJfcnEoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3QgcnEgKnJx
KQ0KPiB7DQo+IEBAIC0yNjQ2LDEyICsyNjY1LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgcnEgKmZpbmRf
bG9ja19sYXRlcl9ycShzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2ssIHN0cnVjdCBycSAqcnEpDQo+
IA0KPiAvKiBSZXRyeSBpZiBzb21ldGhpbmcgY2hhbmdlZC4gKi8NCj4gaWYgKGRvdWJsZV9sb2Nr
X2JhbGFuY2UocnEsIGxhdGVyX3JxKSkgew0KPiAtIGlmICh1bmxpa2VseSh0YXNrX3JxKHRhc2sp
ICE9IHJxIHx8DQo+IC0gICAgICFjcHVtYXNrX3Rlc3RfY3B1KGxhdGVyX3JxLT5jcHUsICZ0YXNr
LT5jcHVzX21hc2spIHx8DQo+IC0gICAgIHRhc2tfb25fY3B1KHJxLCB0YXNrKSB8fA0KPiAtICAg
ICAhZGxfdGFzayh0YXNrKSB8fA0KPiAtICAgICBpc19taWdyYXRpb25fZGlzYWJsZWQodGFzaykg
fHwNCj4gLSAgICAgIXRhc2tfb25fcnFfcXVldWVkKHRhc2spKSkgew0KPiArIC8qDQo+ICsgKiBX
ZSBoYWQgdG8gdW5sb2NrIHRoZSBydW4gcXVldWUuIEluDQo+ICsgKiB0aGUgbWVhbiB0aW1lLCB0
YXNrIGNvdWxkIGhhdmUNCj4gKyAqIG1pZ3JhdGVkIGFscmVhZHkgb3IgaGFkIGl0cyBhZmZpbml0
eSBjaGFuZ2VkLg0KPiArICogQWxzbyBtYWtlIHN1cmUgdGhhdCBpdCB3YXNuJ3Qgc2NoZWR1bGVk
IG9uIGl0cyBycS4NCj4gKyAqLw0KPiArIGlmICh1bmxpa2VseShpc19taWdyYXRpb25fZGlzYWJs
ZWQodGFzaykgfHwNCj4gKyAhY3B1bWFza190ZXN0X2NwdShsYXRlcl9ycS0+Y3B1LCAmdGFzay0+
Y3B1c19tYXNrKSB8fA0KPiArIHRhc2sgIT0gcGlja19uZXh0X3B1c2hhYmxlX2RsX3Rhc2socnEp
KSkgew0KPiBkb3VibGVfdW5sb2NrX2JhbGFuY2UocnEsIGxhdGVyX3JxKTsNCj4gbGF0ZXJfcnEg
PSBOVUxMOw0KPiBicmVhazsNCj4gQEAgLTI2NzQsMjUgKzI2OTYsNiBAQCBzdGF0aWMgc3RydWN0
IHJxICpmaW5kX2xvY2tfbGF0ZXJfcnEoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBzdHJ1Y3Qg
cnEgKnJxKQ0KPiByZXR1cm4gbGF0ZXJfcnE7DQo+IH0NCj4gDQo+IC1zdGF0aWMgc3RydWN0IHRh
c2tfc3RydWN0ICpwaWNrX25leHRfcHVzaGFibGVfZGxfdGFzayhzdHJ1Y3QgcnEgKnJxKQ0KPiAt
ew0KPiAtIHN0cnVjdCB0YXNrX3N0cnVjdCAqcDsNCj4gLQ0KPiAtIGlmICghaGFzX3B1c2hhYmxl
X2RsX3Rhc2tzKHJxKSkNCj4gLSByZXR1cm4gTlVMTDsNCj4gLQ0KPiAtIHAgPSBfX25vZGVfMl9w
ZGwocmJfZmlyc3RfY2FjaGVkKCZycS0+ZGwucHVzaGFibGVfZGxfdGFza3Nfcm9vdCkpOw0KPiAt
DQo+IC0gV0FSTl9PTl9PTkNFKHJxLT5jcHUgIT0gdGFza19jcHUocCkpOw0KPiAtIFdBUk5fT05f
T05DRSh0YXNrX2N1cnJlbnQocnEsIHApKTsNCj4gLSBXQVJOX09OX09OQ0UocC0+bnJfY3B1c19h
bGxvd2VkIDw9IDEpOw0KPiAtDQo+IC0gV0FSTl9PTl9PTkNFKCF0YXNrX29uX3JxX3F1ZXVlZChw
KSk7DQo+IC0gV0FSTl9PTl9PTkNFKCFkbF90YXNrKHApKTsNCj4gLQ0KPiAtIHJldHVybiBwOw0K
PiAtfQ0KPiAtDQo+IC8qDQo+ICAqIFNlZSBpZiB0aGUgbm9uIHJ1bm5pbmcgLWRlYWRsaW5lIHRh
c2tzIG9uIHRoaXMgcnENCj4gICogY2FuIGJlIHNlbnQgdG8gc29tZSBvdGhlciBDUFUgd2hlcmUg
dGhleSBjYW4gcHJlZW1wdA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQo=

