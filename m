Return-Path: <linux-kernel+bounces-793478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8568B3D415
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B06189A8CC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27426E716;
	Sun, 31 Aug 2025 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qTTDRCKY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXzgknSs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EFE26E179;
	Sun, 31 Aug 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653184; cv=fail; b=rlqmX1n3jpSF+dsExkazkwHTlS8eWn2BxFaGgieszZ5A7hOM8okIvCDYzc5G3X2wwO+4QZ6HjYeWi+gmN5GeWJfFutZzqOuw8Z9j4MnFnHaOrppnIpW2O1NkcEyHqmWjGWVm/fZqm+Rzlx1RW8x92ZBk+ErARG6UN+aqa2WBJCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653184; c=relaxed/simple;
	bh=UHtNE4SN9P0Zjm8SZSCBVLPIyG8lL+C7WHO0+71ZFl4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsPT66KzaDHoLWeEKcNSLkpCr2G5zTtofDoRTxYnrsZT79XeSGuLHaJqF2e7KiXwm3gvme7ktFJJHpSWtRV2wBaufdnedlGrgBcOUFsEVL5ZHzU0AT0VICE+tlGmG5wjuhnb6gHZ5PidQ01gpJp4WJmOD6wASk5zrZx6uYTJb70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qTTDRCKY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXzgknSs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VBvHkB028983;
	Sun, 31 Aug 2025 15:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ixP1NAXCPU4zW2izQJEbxajgXMvPI7PkmSUg4tDIZ+A=; b=
	qTTDRCKYuSSInzqhtWNpr/PsGN/e63kG6h3aVdq3AB5/wQ7AOBho+iNKAY7E9US1
	Tj39a3YIngddKiULhepAqleMQyX3aiy9r+sUe8ZBjHsKaUB3167ooSk2UZJsZ0+5
	RFJsEa0/IJATAkg8X+QVfPn2zqa8mMY2ZzeNyZwuZAfyAeNXqOlR40on2D52trX/
	leHh5od/cHQi/B4qq2zaorJ3+nTJRZiP01L4BjxcQcZHogiNSbXOWFp3onZetx6k
	+ga8d4vvzBzc1+WR8Hp4HpXbFRxHEJiI7qZleLhpUF8oui/2nP/LymF17yn+Pvkt
	/leMhjdz3sJL1eHQjesIPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgs5c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:12:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57VDu2Sd026777;
	Sun, 31 Aug 2025 15:12:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01kmjk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 Aug 2025 15:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ9TOvFkZqRc6mmRLyYOPrzJGr48ozOawLZft/xcUKvTiap/ZPDXKZ0WoGBYDm0NXntBobU+je6r5d3HSS37Gtwck7iEfQC5VENHRdfBTQ313tI0TximhQZ+WD/wcKbAJFw0Uh7MlGatM9mvh87PYdLZTZ+IsEFaIuWyXdSf2j/TXxzQXIpAKWdo4++QfuoGH0liJuCkA5kXERcvbnEmj0wwVbTrZftE7K3IvSVFFRV89gnu5z0PveYXPfKsQ/1gFtcOVieHh/QSg092kI3tOTub0bP5VXbYMnksLilB9ID4KShcVLwHPZe4WL1ZZlWfV6ZGpgmbV5F0+se2vKNl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixP1NAXCPU4zW2izQJEbxajgXMvPI7PkmSUg4tDIZ+A=;
 b=p6548xjtPXaEFeYrF8Nw9VvTazwDfZdmDNxYx4sBh89+B5FCROLpwOkxbTzxGbf4xEhnxNvGsVHjeBarPmTNzbkCOzp0aq5i3TWXpzHoSHIZ/guYdB4FBTjEtf9NaTO5114rOiv42CvFEoqTfE1Sl355mUKt/OGBOSSsjjBjbzx6EPF12tjPykduIt0oaxTvD6ZH3PtVhca5TB0KMN6Il7SOzpJ7V5lNd+yt4zCY9j51L4WcfFaf/Tq4TTk8YtW8C8hmNeVZZBOCvQ+IBQ01fRnD+QPED7KahItW2psFzjd79dYIhojXBp0EJpOEz3/nf/FTBSxJugU0JJVOGw7oRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixP1NAXCPU4zW2izQJEbxajgXMvPI7PkmSUg4tDIZ+A=;
 b=rXzgknSsF/vvs/S0FsDCg6cptBLs8kGQZIJaO/cBL9WOLxyCruxyN0Q24UWWTbV0gAs6ZMYvjexV+OnR860m/CXnvJLnv/aYq3iaXTu+FPeO9/3hFBsdtk280B8b88FaM9sjAONPIrmp7BaXD0tZMKFx9XccXwlVQnmIBoRmNCs=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 15:12:55 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9052.019; Sun, 31 Aug 2025
 15:12:55 +0000
Message-ID: <1d3b87af-63c5-4d42-a981-87bc397bca60@oracle.com>
Date: Sun, 31 Aug 2025 20:42:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: dev-tools: Fix a typo in autofdo
 documentation
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250831150710.1274546-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f3530c-433a-48bc-93ee-08dde8a0dc73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGFuR2xncGtxUXFybGovczcrNUVZZzllUW1LdTJlS1F2NWF3d2ZTYWczeDV4?=
 =?utf-8?B?eXNjQTZlakpJMmV0ZlpZL2tlUXRzYUUvWU9KbG93T1hma0YvY3Q3UHJqWTFy?=
 =?utf-8?B?d3lDZ3ZNazBkYWQ1elVWRUtJeG5YdDJZWWp6S1NFWWdCbk5WeXBoSHpaQnFx?=
 =?utf-8?B?czMxRjByTG5XOExHamFlZ3ZuamdzUWV5QzlzUmpsS2hhSXpBVzcyUnVnN0Qx?=
 =?utf-8?B?cGRpeHBnZFhWL1lrYkorK2ptOGd4bGJpYVFPeW5MWms1ZVVBRzQ5N2tTS3lY?=
 =?utf-8?B?SnJYQWs0cTlEWWNwcW1ER05BOHZoQVlsa2hoK1BNaDY4NjlKY3VEQ2tPVCtC?=
 =?utf-8?B?cGl4UmR5YUVHZVVXNWl1dzdVMG83LzNGN2tlYW53UXM0RGREUDlYajh5T1Zx?=
 =?utf-8?B?NFkyay9veEZmWUVGWmJlYktZL1p1dUduUzVxM202QmE1SGcyQUFCSG41N2VJ?=
 =?utf-8?B?eDlEdmdja3I3U2pxYll2LzBvWDN2OU5UV2FFeHZibkltaHRGdkFvUDMyYlJ0?=
 =?utf-8?B?aXBtS2lxTGcyNk5abkVlY1EyM1ZJZFJqMDk1QWVIN3dsaDVyNDZReDBxbm9n?=
 =?utf-8?B?WGZHOStBYXNra09WZEdLS0hpVFVoMjJaZEQxdmpuMW1oV3hLUktsc0ZNOWRr?=
 =?utf-8?B?NkFTbmtxNDJYNUx4UjNqUUpuSUZVSkszWUNvZStiRUtLMENTSFZNckZXdzdu?=
 =?utf-8?B?QzBDcDZsYkMvU0duNEF4YWE5QzFjbDA2U3ErZzhPVldwYjBheTR1Ly9oL3FZ?=
 =?utf-8?B?ajZOR3haTWxHYVZkYkUrRlVkcHFwaFp0YWJDOXZHSExBWHdLRWsxb0NRZHlo?=
 =?utf-8?B?b2dKRitFN0dVMWVodzRsV3dWVDZlL0RRSTY4NG9aeWxFeVRmV3ZYb3NkRHFN?=
 =?utf-8?B?dDNaUmxNbHUwbSttNHNVZjhFS3JSQy9JRjdyWTFpOUdsRzR4OHVWNURXMzhi?=
 =?utf-8?B?UXhMdTJJYXp1d2lsemVTMiswTVE4Q1hmdXpIYUo5OWx4N2k5OExWb0t4SkZa?=
 =?utf-8?B?ZkxRS3ZGVmVONlhrZXMvWmhPZDI4NjcxQ1hmdmhGSk1QdisrTm1JWmRtcStq?=
 =?utf-8?B?T3JKSUhqL2pmbHlsRHd0VXZ4dEtSQUdMNytMSnN5M2ZCRXlYYytvRXBRSWdT?=
 =?utf-8?B?MWFuckUyV0RaMFNpTG4zOEtCU2pORFpzT3VPWEVlLzFKemIycmF1M0tEeGdv?=
 =?utf-8?B?aU5ncjhTM0E1UHVXZUE1M2paU1hub0xSdk1lREI4MmxNM2lOZEdjUGY2VzBQ?=
 =?utf-8?B?NFI1WDd0T0owcmpNMjNoOVZDUjBTdzlqbzYwVmRGMXhCSkVjK2YwdG4xeG5t?=
 =?utf-8?B?OUFueWRWNjFWTkxaM0k2cE5QRlR3S2hqZytYeWNBMDFHKzVWKysvV2FQd1VO?=
 =?utf-8?B?ZFQrekE3T0NGeUFVTEc4d1ZMbkFFK1pHUml2UG5uSktKNXo3eWRHelB5THRS?=
 =?utf-8?B?MGxkcFpjdmpYK3RaZVdmVW53M0VtRG14c0tIckoxY29NOHc4QVpTdEU3MDZl?=
 =?utf-8?B?djB0RkZzWkhOdDFLOGRrWHd3QWJVeTJvaDFia3k0L29IZ1BjU2JzaGVhRXlU?=
 =?utf-8?B?UTkzOEdRZnd6U08ySUdvcEI4M2ZLNERqMHNjMThDd2lnTloxajlQaGVWSjF4?=
 =?utf-8?B?cmdLb2FyUURoL2dmTWUvcG5veTJHUXZDcjNuSGtEZ2oyRlRsOWFkbWxCbk9D?=
 =?utf-8?B?N21kTklSUzhzM2VPYnAzN0pzazN1bGFYSHJwaEJjb2hOem92OVNOU2FhR2ta?=
 =?utf-8?B?SWgyZWh5QzFERi95QXpyWG4wV01LM3FTMHptaEVXNE1JVWtMbG5KZzVUcnVp?=
 =?utf-8?B?M093VlJKQVNULzJpN2wwYlpZUmVmUnpwMlZBdm93cWxqQUx4SEk4NnpkL3ls?=
 =?utf-8?B?ZG9udDFUWUNRZDJHL3krTm5kcVNTT1YvMzNiL3ZsRVo3bmVTaEd5NDk2Nnhm?=
 =?utf-8?Q?kVQPcjs5LKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2RoOE9pdGhRZGxZSTZFbmtNZ0VYaCtva3BMS0M3RVVHM2pqNTBrRnh3VG0z?=
 =?utf-8?B?NmhEVnI2SlJ1WTBFMW8yV3laYW53QTZTWkRncXZFbDk2T0ZPeHd0dVM2dzlG?=
 =?utf-8?B?N2FpYU8yS04zVDVNVjFER3BhYmZyemhlYXl5bThFcGdlamY0T1lLZUNYVFJJ?=
 =?utf-8?B?RGlmRUw4ZHkzOWlndzBydHdJV01tM0llUXFod3dza05WWTBqQ3FaRTNZWDcr?=
 =?utf-8?B?a1JGU3REbURvUElzL2FFZGI2Y1p2SzRBRmE3MXYzWE1OTkpxNDdYNXFPQ21k?=
 =?utf-8?B?cjZOOWgrWHZmR2dLbkN2QzhvRmY5cjZTd2MzSFg1aUd4a3Jqb1NYcGd4QmZH?=
 =?utf-8?B?bHhmMWhVUGV5M2k4ZG9SeXZFTkRka0Z1UXZnM0dwbmNHRjJUdU9tTGh1ZGxl?=
 =?utf-8?B?SlZYbFdocGVzRk9qcUlHTTRyZ0o2MUwwanZocWMwMmUzVlpURjhhQ3JVYS85?=
 =?utf-8?B?SVhxZ3ZlR3V2N1lhbEhLejZ2U1c1YjMvNUV4ajRCOWlxbE11TVduQ1ZhUGRT?=
 =?utf-8?B?a3JuaVpoV1AwWFVPWXlLYS9rZ2QvZC9nN3hyZm9aZVduVFlFN3lXNjFqUU1q?=
 =?utf-8?B?dGxYZllQWkJIanVmT0dqTWZlVUVvUVZPcFBqNFcwUUtLcVl3c0JGK0R5ZUYy?=
 =?utf-8?B?cnM3VWNmbXVzZHd2S0d5aE92MzJ3cmZaQWRLd0NXVUoyaUdOUkdxbWdzWC9i?=
 =?utf-8?B?YjVWUmttVnlUL0FvWmdhRUJGT1Yrcmp4d0VNOUs2aU54S0FwdkYzS013SEcy?=
 =?utf-8?B?RFJVY0ZMc3VjaENMcnZTOVNtTDJGZ0tmdFN0NHhPZktYNzVRTTYrZGVIRXgx?=
 =?utf-8?B?VmxuL1U0TTN4VEN2Q0hMcXJuM2czT0lOMFkwRkc2eTVHbGpBRC9DTDlLZEpn?=
 =?utf-8?B?M2Z5K3lsM1BoWTZxTWtOZ25ueVBmazdac0M1cDRWT2JBTlRDdzdDWncycFZK?=
 =?utf-8?B?a203NysxajJQdEVpMGVZYW5TMU4yeSsydlZjTTM4QjI1NlFxSCtUcnhBL2hv?=
 =?utf-8?B?SSttZjZKMjV5VkpKQWJOaDVrMEU3TzBKRGpsNFZPWkVGUDdkbmNSVktBZGdE?=
 =?utf-8?B?Z0hzM0loTTlaUWdLMHpnM1VLdXVlMlpTcWhlNFg5VmsrL0JhMmZXNWxCWHRC?=
 =?utf-8?B?MzRSM2FCVnFOQk5kVTArNXdUTzFOZVNFQlBvblh1SDM5MThsTHJJVGdJMHgx?=
 =?utf-8?B?SFFPZ1FyaVNzMWhFcFFXMmhGaTlMc3d2Nks3dWdLR1B1RkVWeGd0b3hJc1Rj?=
 =?utf-8?B?N3JSUm9xNVlsZVRSbTFNSyttWG45bWlHeDJmd1AzL0MvV3BHZVVhNkNxTEww?=
 =?utf-8?B?SGFCMGdZbHlTYzNKK2hCeVFoZjNNU20vUU5tVDQ4UTcwSUJqS0FUVWFhZG9O?=
 =?utf-8?B?RW0yZmQ1d05iclZYMDczNUpMNWNnUlNnUTdXNGdmK1lNZEZwWDhzTzdRL0NG?=
 =?utf-8?B?YSt5THI5ZGNoZmE4V2tQdHV6cnl3T29HRFZCeGtqSHhQVUk5NHJPeDJrTjRt?=
 =?utf-8?B?d2laUnBVY0t0R0dJVWJ0Q2pRMGsrTy9tSHI3T3MybW5IMDRNSDFhMVMrT0hU?=
 =?utf-8?B?T2RKTHplVXk1N2JWTXZiM2syRHNFaUc1ZEJxbDV3cG1XaUpxTGhMQjVBdlJm?=
 =?utf-8?B?TldSRGE1c21zd0k0aTlXYk5IT1VsRTgvUmtEeWVOc25nOWdWWEVXRzBXL0FT?=
 =?utf-8?B?WDhvR2Z2b2JPUjVoMFZwYmhGbTRLUnM4NGhRcFB1ME4ySVRVNm1GUEVSZEl6?=
 =?utf-8?B?WFlGdUZLYjdhUDc4Uy9oa2JvaU9UOTNOcHg5SHJubnhIcjFqQWNzUnVVRDBo?=
 =?utf-8?B?UUJZYkVYY0tQcnVyTi80ZHZncjQ5b3laN25DMC8vaXNMWXBUZjJ5a25tb1lZ?=
 =?utf-8?B?TDk1SHl1cGNZNU16Z2RvdWNOQzRjMHo5Uit0alhPc2YwUDFIWFBNd0JLeEZC?=
 =?utf-8?B?QlVTU0FuWXZhRDB3amRMMVdndkd3eHNKbTZWUnAyTk1EekRocEcxSmV5Smxu?=
 =?utf-8?B?NlVhRmNlR0dwb0VjekNCKzY0T1NKNlh6OGxGdE5XTUR3N2lVYVZWcHJhRW8w?=
 =?utf-8?B?cThZVVNQMlNmaHVIU1lPL0VJc0tuTzR1ZXJsMU5seXZFM2J0TGc0NnVEMDRt?=
 =?utf-8?B?ZmRwbmptRTVQVGFCUFNKajRzaVlmQTRqVWFVOVdwSXdheEhvTXVrNGRKR1dz?=
 =?utf-8?Q?SL/rkTynaFReYrirnZYOkjw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S+HzX3U0BmL3Hk4Z8idkNG+85jithvmSTsUm3HzGcSVdrxaUYL3Kj428kXHLgv+9YW90+6AmOHpXfZxvQ4m976FpJ77rxgB+RQGSyqzrpArhQvObenQnF4XZF1wmFD6dJU4YVeZOsK0Eo/cfzn/FQ7Dj73+g/KSYjne9SgVga5++XWZq3KR6MMvjoF9ADDz7Li/eU6TXh0Sd43lCkBV7Aydq4yxnID7sr3K8NMUtXMtMqIsCytlaXCix+po9/ZkTS7VpVvQFFy+ajfiRWdyCDd/r2382RTDejPJA6ld9PxlQ9Hl7tGlg7aPPcueBDAaSRmE7e97GXGrxYAuqUxVsiHBBYjS3SUz0/K0UJ0663Pk7G/bzmE8JLuUJiT2K8kiwkz/vNDoMG5tASaJj/7xz2jzOx05GItnHhsPA+PVCgfDLCafsdlEydBA+MGAqRTnXkvls/BLBdveg5HSukT7GOJ1AxvT/FOZweBAQkIK7UbyRrXAe5En4pNFufLqtnKIlF2S6I2Fwanv5C2yVGKsukP6REfn9YtpfJUlxArEZXrzxmP9zbF88zt1pdtdjID+CyyVbu7taoCj69miK+FUq/BBm+MSVjjYuN5EFME0B22E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f3530c-433a-48bc-93ee-08dde8a0dc73
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 15:12:54.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yI9a0jXh3uDuj4FuWnk/1XRRJNrd3/UsE3nRstXaKlYIVSL5/wcz6OmoOFOv8bppfcSzjoEYhb8ydYeln3hY647V6z84Z8T7NXstuvF6mqwxdqB0FHsG57golHEPdJhG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-31_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508310163
X-Proofpoint-ORIG-GUID: WF8wf5UfNQa47kpJi8TunJ8q5QasavNt
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b4667a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=_l-NOD16TJ_2dFQU9qoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX0kwG86GbvjBo
 wvfFodAgbJ6jod07AMJerg9HLrqf//sg4+dRcqfFKjijP4HqKjJdnB2JF4FxreUdAzsVAYziOfb
 ciG4xEPQzbSVm1bgDyXHRvnK51Y4LRD6sugqxYaL1yndCPF4zGKgxO1IAO6apBm8KP6CrFjwxo/
 NgK8//FlF20EQVqymmPdXkw6u5w8i1PhcYBd780teejiSXnH10xegTPitleTwMT0gQp23mSZs/R
 zGe8jJ74i+p6AXkURY4QpusctK+zt+6/lOzKs8lIVZx2BWNSUSN7j9fKbSNQpxwvTQuh49KyQXf
 Ds+x8LxEbaYGcqRuLZBrnUbFw1jkNB+n6JKajLyUmhBedKT5UA/Ud36vzGLgOFEVPaM7HVzHdmT
 BaF0ijEZ
X-Proofpoint-GUID: WF8wf5UfNQa47kpJi8TunJ8q5QasavNt

Hi,

On 31/08/25 20:37, Harshit Mogalapalli wrote:
> Use cat /proc/cpuinfo as opposed cat proc/cpuinfo.
>
Please ignore this, I had a typo in my commit message for a typo fix :(

Send a V2: 
https://lore.kernel.org/all/20250831151118.1274826-1-harshit.m.mogalapalli@oracle.com/

Thanks,
Harshit> Signed-off-by: Harshit Mogalapalli 
<harshit.m.mogalapalli@oracle.com>
> ---
>   Documentation/dev-tools/autofdo.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dev-tools/autofdo.rst b/Documentation/dev-tools/autofdo.rst
> index 1f0a451e9ccd..bcf06e7d6ffa 100644
> --- a/Documentation/dev-tools/autofdo.rst
> +++ b/Documentation/dev-tools/autofdo.rst
> @@ -131,11 +131,11 @@ Here is an example workflow for AutoFDO kernel:
>   
>        For Zen3::
>   
> -      $ cat proc/cpuinfo | grep " brs"
> +      $ cat /proc/cpuinfo | grep " brs"
>   
>        For Zen4::
>   
> -      $ cat proc/cpuinfo | grep amd_lbr_v2
> +      $ cat /proc/cpuinfo | grep amd_lbr_v2
>   
>        The following command generated the perf data file::
>   






