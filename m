Return-Path: <linux-kernel+bounces-748953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F009B147FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C6B17E61A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD41256C8D;
	Tue, 29 Jul 2025 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uG5jSE/5"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821621A76BB;
	Tue, 29 Jul 2025 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769114; cv=fail; b=LYfAFwuNqQ16DbLK289+/yG2Cy+mKriG6rpivo0q6dgE89LTaraq0BIKHdbGXFgiP5PYrQ7ciFwlO48d162bh271myAVbJ13P9c+qp7loPAi8zPvahntzW1ipdAvkaO/vIVX9udu+BOHx2x1QkcxjlJpIxREF7l35hBCjSzSbeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769114; c=relaxed/simple;
	bh=gtC7o3K0TB+8QkKdNsRUDjhEWx1/TYv2wmH8RcXTMPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JpEoWvFwDOr9wsuXxm+T2O/kaNbJag4+nKzCcQo5uwDq6t/u2lSPrhIWYGZHyBF+qs6VRZHDhTveKL6LBU3rkNeEqzHLT8+F4TxXeg4EHnNoDcA2uQJV7DyMfHN7wF3CHzxWH39WmdzQUdIrcJJ8e2+2yzi28dT1SEQr7bytdZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uG5jSE/5; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/Jj8Bxmu0GQiz/BeuCgrvwYpi/LDW5wldqeCcgolDwxov1V9MgYZpjqdDCvAqVOemLTG3K4OpqGJSJgxLu/jrkxAeTrTGMfmgFIId5YJZFOZqiqL3StV/9cCzm8wFOIDEpW19XU0fCxysPmKppFxhz82j0CjshmI8waV8QGD1HO0DAmoE6Owikhb9fPMlDD+nrS+ljoNq4UoUxhCZEX9ZJq0f3fWLzxBx2G1KelUrwUtTeInVEWs2/0zw2W9L8eDrhhFZSVCNkVTNHiQvBnLaBKrrvZODYxeUSAVFYDl7TLhu1ULen33FDAkdssi9+mh3lXzxj2oYCI2NlbqtubPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpXh0KBFg7mjcFR14pt5LtcRguy1pkAhRni0a7wlTpM=;
 b=U67oPBBH/MKXOuj/F3smwdEzpodLfuXlQuk5OxCZv3K3ylIdyP5Q+1wpIqUToZ3zkiyTHP7IhwROPzaFpCvJFOST60Y3wrXQ/wqCn7H+p/wBFwMojmBqqvSnaL8RTbplemGx1mGNoUjHKxVM8wZCbF5lQj67nnWtonFJShO3ZnokCqlXtnp693xlnQPyAA04/4sQfUUQgkSFOKzxiGb1lIdg7sWlxKb+mL0rE5NGnb/W2Y2aQSAQV413fRu8XnkYxNKVmdf5R3poL24HPCalYFJf0/JmmeUd3bLfnTFq2vWWjZpqXm9T+8pLf/8p6varobatFlsfd2fle7dek9pqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpXh0KBFg7mjcFR14pt5LtcRguy1pkAhRni0a7wlTpM=;
 b=uG5jSE/5JGXwN/Iyv+v8NL4mHR9AMHVW8IsKC6/S3NoIRwOkOLNfwl40NpDathpFIWn6s8uHBnxpG+7Jr+LAq51lYQ+ycucOxyIsFLAXUPbk6iewzjtDpGU2HXcZLD5Mx7dglDCjfjKNzdratBlSwYC+cz597EhEjV8wrFYcYKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 06:05:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 06:05:09 +0000
Message-ID: <7d8c0bbf-2911-4e18-8287-e7c72fab396c@amd.com>
Date: Tue, 29 Jul 2025 11:34:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: acp: Adjust pdm dmic gain using module
 parameter
To: Greg KH <gregkh@linuxfoundation.org>,
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250728094243.3824450-1-venkataprasad.potturu@amd.com>
 <2025072814-stardom-anointer-0a62@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2025072814-stardom-anointer-0a62@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 648019e4-f690-46ff-7845-08ddce65df9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXc5Rld2SzhDeFJuRWlJc1ErUGZnN3N6SllmcUJyN290QkFIUzdrYk01V2ln?=
 =?utf-8?B?Mkh2Z1hsWG1XSDNzOXd6Q1JJMENxS3RqNEdBQS9xSkhxZjN4QXdLbm8xWUJZ?=
 =?utf-8?B?L25JdTlCNlZrVnZqUTB4dmUwWHJ2V1E2ZlBpKzJIOW81MkNLV2xseXJXc0dJ?=
 =?utf-8?B?TWZEbjh2cFpMWG90SVZabkxRVWFOa2JTRlVCY1dlK0YzNkdnT3lxVVFPcHdv?=
 =?utf-8?B?SXpSZHpHcEI4Nkt5RWdHdGQ2VVd5ZGFaNzVnOS8rYVhqbDM1aEpkbHAxREhK?=
 =?utf-8?B?ZWRzMmlER01aajRhb2toajN6SUl4TmkyWE1FK3RPQ1BPZlFwUnFhUkVyelhM?=
 =?utf-8?B?TEI4b3ZxQ1ZsTVJSQmtoNkpMRno4ZDhwWjd6QlhMTlZzcE95b1RkVVFmcWRY?=
 =?utf-8?B?SGdBeklMa2E3SEh1MTBLa0lLSFFVU01hVmpJWXFwR2wrNWo2ZTdMTFk5OWNF?=
 =?utf-8?B?SFdnWkxVSHJyZHhkR0FiUWlsd1ZPcVVLajM0R2hsZ1FheTV3NTZSZFNsNG1h?=
 =?utf-8?B?TnYwN0paaFpEUE5NWVhIcndjNW1yejZ1NjFsUzlQdkhBY3hTdDZkazB0VEpy?=
 =?utf-8?B?eEpXSWIzLzcremNyU3RlbFllN1AzQ3QzOXZsREdPSFFvQmJNZ1ljODRZVmdU?=
 =?utf-8?B?TUdXbjdza1h6NXJrYUdVUEZWYkovY2xRYitKMFlZQUlDOStJSVB4dzdSWXJU?=
 =?utf-8?B?RzBRWEdxWlRTTEM5UVN2UmVEQTM1c0tWb2NTbE10Z3JDdm0rZXVOaWNxNU55?=
 =?utf-8?B?YzFuRGw0UnJQZjR6cGhmcnNtZlJIMmFPellOMk9NeTVIWXQyc245dHoyWTlv?=
 =?utf-8?B?akwwTVdOQUhuUWo1TXR5SFprUFRyeSs1QjJqQi9jVmo3ZDVxYjN3SGRHMGp5?=
 =?utf-8?B?VkoxYnJGaWRIcmRWY29qeTZLL0ZKK1pjejdLcHVzUTdoTHNSQWVGTmxlVVp1?=
 =?utf-8?B?Qkxzb3p0QXZyeFhqNTA3eVIwbXJZSllzcVM1bEpBb0ErME5acnBGOEMvbkZR?=
 =?utf-8?B?dG1NNnJZOUhKY1h2dk44RFNUUy9NeWxGTmJYRmlYUFlheWQySlE0QWtqWlA5?=
 =?utf-8?B?SlpXZ0J3RDNrcVBEaXhuL0ZoTWprYUpENFBSdXExaUNPRG9nVEJyMkhSLy84?=
 =?utf-8?B?V2JSUml4OUxhV2J0Z0hRdnMyeXZzbDRubm9HcTFFNFVrNjRxKzRXY201UEZZ?=
 =?utf-8?B?bUM5dGQzQStsM2E3YXpEc25RMFROK1hGQzhlNUN3QTZXb0pmd2RlZTdxSmRX?=
 =?utf-8?B?a1NGd3BOQ1pFLzM2UHlYN1pRSjZQekJmNGNtQ0tJYWZFYUlYaUlRVzhMSW8y?=
 =?utf-8?B?TUYwR1Nmb0lIMnBFK3k3d1VXYTFnZFZOTFpvTWxsK29Hd2ZjWlV0d0ZTOE5Y?=
 =?utf-8?B?UmRuUHRjT0JJM2xsY1lsS1pGRDY3MW84N3VBaThzZGVzT1gvV210NFFZT1Fa?=
 =?utf-8?B?UklyMXVnZlhNUkRwNUduZjlieDc1YWJjZis4SjNkTnpyL2JQT2h5VWRFcnZw?=
 =?utf-8?B?MXgvZCtsZjhZbVFoL2ZOYVEvQW1PYS9XeU1WTXcyYjRKSU1zMVoxeW1kVlBt?=
 =?utf-8?B?KzFLdHQ2VURicm9hejZpV1JHeXhrM3Y3NGlWenFiOEM4NXIzVDArbVRITWx3?=
 =?utf-8?B?UHVmYllzZGlIRWVMTE8wVzlFYzdvKy9Ub2J2ZVZPbVBmY0l4aVNlWkx4TUxm?=
 =?utf-8?B?VktPR0QxSEgyU240MlI5WEhHMXh1eVBqWm04VHF2V3lZVnpsZWRhRERtVnVB?=
 =?utf-8?B?UXlpQnFiVXR4UmIrcGFpZ3JTZW1MN1RWNGYxY0l6QzdBc01pK2hDRmRUWVFK?=
 =?utf-8?B?U1NkSEhqdkFtRWNjOFpkbDZjdTl0UlBNcThjNGt0M2w4Z2ZLQWJsb0tkVXVN?=
 =?utf-8?B?SVVnR3EzeVp1YVB1eVlCbktFTnpXa1pPVm9WT3RCQnhJYVZWQ1FiUjRKZzZp?=
 =?utf-8?Q?nOdeMkH38NE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVdraE5rOXcvbmJtaGV5WFBtS28xaHpqOHVVVFN4QjJ0Y0kyV2hCYW9EcjNE?=
 =?utf-8?B?dzljcHl4Q3ZwV3Q2Y0lVOExBOGJwK0ptWHh4UkFBL0tWaDJFV1dEby8zQXQ5?=
 =?utf-8?B?WFB1cytXL3BNb2FrbGc3VThDQnUzd1JONm8xZ3cwQjZKb3djQVh3MU9kZnFH?=
 =?utf-8?B?WmhFdnh6RUlrK2U1NkxZcGxKY2RRUWF6d1poajV2bVJIeG5OM2ZsV2VORk5S?=
 =?utf-8?B?TXVnZXFlZnR6QWsxSkNWYWJnWGxwRmI1c00vcStmdUlQdGowdjVPRTlzc2RW?=
 =?utf-8?B?aVpMTjc0UlVOU2lCOVdVV1h5YkVzZitydzRycHNjb0NoMWNaYVNObVdrTDVM?=
 =?utf-8?B?cmR6bU9OQjdmeU45dHA1Zm15bk1IQXE0Zno4VXBxekZyZDBZT00xaUFKcHlx?=
 =?utf-8?B?QmNGMDlpaUxtYVB2REhjNjNtZ3JxeGdlaU4wN0dFYW53Vk1HQXhzdFQyTVVP?=
 =?utf-8?B?eHBLSnNmWnNVMVFwUzJSeGwycUJ1OXR2dTZnMHplYUVUV3ZMay9tWWNQNHZV?=
 =?utf-8?B?VjBwTW90N3psRWVzQlJmajBuSGdJV0pwVmNIbzZyZGswNEMzT1crOG4yTkNC?=
 =?utf-8?B?Q1I0RkUrd0RaTm45Vit4TmpWZ1NxcHo3bmtDSlFrMUYzSzAzNlZsWk91S1ht?=
 =?utf-8?B?cEY3VUFlemE1b3FueXVORDliSVBkbkVpaXJxRHFrR1orTGU3ZDU5M1ZSRnhH?=
 =?utf-8?B?QTUwTzJwT1A0bnNVYVBxZDlSNERKK0YrUWNRcHpjNmc4Q3N6UThCdklobjZt?=
 =?utf-8?B?YXpTKytrellqT2VZR2E4V01uY3FKdlVGK2FZM3hZV3hTYU9QYzYyS2hFN2Fy?=
 =?utf-8?B?emQ4SklESGJpN0R6dXoyU2xaT0dNTXZDNC9ENkRCeWJneW1FcjJ4bnRxcW04?=
 =?utf-8?B?MlBGVmZNcVVKcXZ3NFZhSU5YZGZacDNSVlp4bFVEVnFuYU80aHNNakQrR2k4?=
 =?utf-8?B?SWxyY1hYK2VJSW96U0JhM2ZzalRYYmtQZWtkdVI2aW1uYkVoM3ZiK0k1TXVP?=
 =?utf-8?B?Z1ljN1g2eDJHdFE3SzQ5RThwMzljWG94SzQ2VVJFbC9UQklTc3hYbVhNd2F4?=
 =?utf-8?B?bVEvZGJtRnphRnNCUGpJeEpxUmhhd3VFVnRmQXNrSlV6MnhyMENRSFJMUy9T?=
 =?utf-8?B?YSs4S2IxRDE4MjEySjhqNnhWMnp3TDkxRytYZmZaR1Vzc2c4U1AzUUtCM09X?=
 =?utf-8?B?VWMxdm43THF0NWFQNnpkSm9KblFvelZOVlo4Qi8xMkhBOW5kMHNQOWM3R2tx?=
 =?utf-8?B?cWJiK3k5NlVESVBnOTVtREMvdzMrckkvMUpUamhtcy95dXJiRXZua1JPc01J?=
 =?utf-8?B?S0lYb1Nnd1Mra3JudHZoQVlseEFDdjdBaTltQ2UvRFR0NENmVzNMR21QekNm?=
 =?utf-8?B?TGYvNk81S2owVVM5dWJaazlRc0N3ZkFLckNtL05wTVkwNTlKMHU5WkZ0eUk0?=
 =?utf-8?B?NG85STBIWEV4aGQ5MjhuV2RLYmVTZTFyVUNWSlRaL01tQmZBWkJJZ2Roam5v?=
 =?utf-8?B?YmlDVTZBV2ptbDVicGxWRk8vNnBSUE5teG9FMU44R0RnVjVMRmFlWEpuaGVw?=
 =?utf-8?B?azFHZWpaTFRObmgxQld0UDQ4SDgzdCtmZDZ0NnJqVXR6QkcvWWlZSjQxYkgy?=
 =?utf-8?B?RXVlazQ3ZjViOGZKSlMybzVTVnhNUmtUVVlJdnFxZUIxVlNHcWNmUHltc0Zo?=
 =?utf-8?B?UWJYZTNHWHRnMUZzclc3WkZXcEwzLzhpenAvdStSMjRWZkFJd2pNV3pDVVNY?=
 =?utf-8?B?emRpTjJiR2FxSVcySjVET0VoZ1FjaFBtbEJtN3pUeWNFZjF2V3Fscms2UFVC?=
 =?utf-8?B?b2FDeW9SVnZ0Y0FrWGJEUXFVK25hMHlxeXZ2MnF5OHZ2UTd4eUx6OUY5U0NB?=
 =?utf-8?B?OEFpK04vMjFFN1IyVm9vaTY2ajlhTzhRa09xV1d1b1dKNUJhTFNiZGFIQ3pj?=
 =?utf-8?B?UUFEL1BCeXhwa2tqL20zT0lzM3lsS3Y4RVp2TTY2OUFvcGw4U1lBNG1nc2ZR?=
 =?utf-8?B?aGtvZHQ4c2dNR3FQU3A4NDZuSmFuczNFZFRzRjAyWWE0OFEzVVlQT201M2tp?=
 =?utf-8?B?dHJLWVNXQ2Q1SDdZMEZ0cS9HOE1XZXdLZ29VNzZFRFh3QlppdVRieEdGWWUx?=
 =?utf-8?Q?VfpkWa3BKIk1/C96ckPlA3Ds5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648019e4-f690-46ff-7845-08ddce65df9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:05:09.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRkDcTo7cfzH/xXcYu4vmAU2LjZiN3xrcq79W0D8MAm8NKdHhyUnaLroCQuRQtWvaewmHXwlBJZEyyHUEjTaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

On 7/28/2025 4:22 PM, Greg KH wrote:
> On Mon, Jul 28, 2025 at 03:12:27PM +0530, Venkata Prasad Potturu wrote:
>> Adjust pdm dimc gain value using module param.
>> In case of regressions for any users that the new pdm_gain value is
>> too high and for additional debugging, introduce a module parameter
>> that would let them configure it.
>>
>> This parameter should be removed in the future:
>>   * If it's determined that the parameter is not needed, just hardcode
>>     the correct value as before
>>   * If users do end up using it to debug and report different values
>>     we should introduce a config knob that can have policy set by ucm.
>>
>> Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
>> ---
>>   sound/soc/amd/acp/acp-legacy-common.c | 3 ++-
>>   sound/soc/amd/acp/acp-pdm.c           | 3 ++-
>>   sound/soc/amd/acp/amd.h               | 6 +++++-
>>   3 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
>> index 57982d057c3a..dd804fb95790 100644
>> --- a/sound/soc/amd/acp/acp-legacy-common.c
>> +++ b/sound/soc/amd/acp/acp-legacy-common.c
>> @@ -173,7 +173,8 @@ static void set_acp_pdm_clk(struct snd_pcm_substream *substream,
>>   	/* Enable default ACP PDM clk */
>>   	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
>>   	pdm_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
>> -	pdm_ctrl |= PDM_MISC_CTRL_MASK;
>> +	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
>> +	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
>>   	writel(pdm_ctrl, chip->base + ACP_WOV_MISC_CTRL);
>>   	set_acp_pdm_ring_buffer(substream, dai);
>>   }
>> diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
>> index 1bfc34c2aa53..ffb622a7a69a 100644
>> --- a/sound/soc/amd/acp/acp-pdm.c
>> +++ b/sound/soc/amd/acp/acp-pdm.c
>> @@ -38,7 +38,8 @@ static int acp_dmic_prepare(struct snd_pcm_substream *substream,
>>   	/* Enable default DMIC clk */
>>   	writel(PDM_CLK_FREQ_MASK, chip->base + ACP_WOV_CLK_CTRL);
>>   	dmic_ctrl = readl(chip->base + ACP_WOV_MISC_CTRL);
>> -	dmic_ctrl |= PDM_MISC_CTRL_MASK;
>> +	dmic_ctrl &= ~ACP_WOV_GAIN_CONTROL;
>> +	dmic_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
>>   	writel(dmic_ctrl, chip->base + ACP_WOV_MISC_CTRL);
>>   
>>   	period_bytes = frames_to_bytes(substream->runtime,
>> diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
>> index cb8d97122f95..f2567e06ccd3 100644
>> --- a/sound/soc/amd/acp/amd.h
>> +++ b/sound/soc/amd/acp/amd.h
>> @@ -130,7 +130,7 @@
>>   #define PDM_DMA_INTR_MASK       0x10000
>>   #define PDM_DEC_64              0x2
>>   #define PDM_CLK_FREQ_MASK       0x07
>> -#define PDM_MISC_CTRL_MASK      0x10
>> +#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
>>   #define PDM_ENABLE              0x01
>>   #define PDM_DISABLE             0x00
>>   #define DMA_EN_MASK             0x02
>> @@ -138,6 +138,10 @@
>>   #define PDM_TIMEOUT             1000
>>   #define ACP_REGION2_OFFSET      0x02000000
>>   
>> +static int pdm_gain = 3;
>> +module_param(pdm_gain, int, 0644);
>> +MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
> 
> This is not the 1990's, please do not add new module parameters, it will
> not work for modern systems and is a horrible thing to attempt to
> support over time :(
> 
> Please do this properly, with a per-device setting.
> 
> thanks,
> 
> greg k-h

As the main purpose for this parameter is for being able to tune whether 
the property is correct, how about adding a debugfs file instead?

AFAICT it should just be a single register write, so debugfs to read 
current value and write the debugging value seems pretty straightforward.



