Return-Path: <linux-kernel+bounces-736391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840A3B09C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FFC5675F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBEF21B9CD;
	Fri, 18 Jul 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QpDTt5qx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9722192E5;
	Fri, 18 Jul 2025 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823426; cv=fail; b=uVj2ZA/FxxT1/SalDAS8qfWmL3Fr5UKGepF6XB8PP3JAFcFKxgfSJUrfUD2+lpZAAVirho3sVklsjBbvYm7w+RYwp2xFShTrlfYQtFn01bLo1l+6hz1Cqy7xdRXXQuePVcpKRR9BgqPPEmkl0NxZ29sTnI4Q1FCR47e4fZDDhP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823426; c=relaxed/simple;
	bh=jT+xvtGMdoVElYBaYwK/uJ0Q/8j32YsI8lVe1hU2S40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D5BNgP/+9k3e4aAeRYhHB8yjj7M6VGHXr/xoeghtWOynW5Qi8q/8rQJ2Gn6g6nuVQ6bVP+mWNJBkekugbMImeCyE/pZUjZr6eglIImPkJ5agbDf7Oa9msyqLRCNyruQzFPXqb0smYQmvIF+2YwKVS2JPatsH+a5HfPQRUHbrPqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QpDTt5qx; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAV8SfwypLw8awwhfuNz/9icyPaQspUyDIuJFubWXYEagx6UYYbsRZdpaq1xnPiMouCh5cfEllycUgel2+k8OqmUrYMmAqvC8B083/v+ddVEqG/jaHyuWfFn2PgNXOGpkX92tQjcxwz9J+UtN2gPF/F1Xm89ksIRwEO+Fh3aHEPfHmWPB3//mA6qmuDGq0vkJR7Re2ex5idnUVXUDxwTqo9AAy9ZAqWLlInWNH26StVLTHXR4KeYnSju2FvDyEj5VwZIiAbG9hwrRDE/OwuSC4Q5/BtjK7nyzESHN9FXuBwMJWWH418fgP6ULsA2p8XJCpyfXNdYda81Cl5k6CUpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTLWivVCB9rWDs5kL6Eo3ecH7MUoB4Lmwk4KkNCuCy8=;
 b=D1s3IjQe3VLPCgnqiSZ2jATkdB8T5v6SrD/cixtUGML7n4vT7WZYqjpK6VIrPsSrydLmnSExVccjWr4NutU533n3rSekFFbixz62VByFhqwNYjSwqeA5Utj2lI3tFVV7/SNlyLhS9JyxhQ3xy8IXbrBPmfuFYFZi+SXb+9bhGXEsBRIzuFxLoAPCAJ37ad3Rr8L6yG8GuMTVffQY4f6NnngeT2JchTapOFEAEIWV3bKGUzYaHP6gws+W4r1u6nUSBMutjZdEx2vVAeTayxo/nAR4zxLQXbxV3fxNMo77crAjUZc9R1/je174F7Bw6jrXqkJe2KSYfgq21Yqm+bKkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTLWivVCB9rWDs5kL6Eo3ecH7MUoB4Lmwk4KkNCuCy8=;
 b=QpDTt5qxZ7RQT53vpKR1Wk7TCfuZGbByFIJ+lJkD2vKvuahSc95fFSoD8g75ijzVWSBbXuB/n4zYWZE6i7WpqeZw7ClvaihGIcI9X2+1mLPgKlhrWG2AbWZ45Q0gWt02xnB5h1o2s8WVA2KSRFg7xmSwkuvymBFTYiHGPQ833k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 07:23:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 07:23:38 +0000
Message-ID: <8be48e66-792f-46cb-b5ec-036f450ca925@amd.com>
Date: Fri, 18 Jul 2025 09:23:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal-net: Update rtc calibration value
To: Harini T <harini.t@amd.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20250710061309.25601-1-harini.t@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250710061309.25601-1-harini.t@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 09065906-b0e6-47b0-75ea-08ddc5cc0394
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWw1bFJ0ekRRNmNmdDREREVQUTU2ejdndnhqbDNaVG9TYis4WlVVQWtRUnlU?=
 =?utf-8?B?RnJFQ0diaFhkeHovcEI3SEM5elQ4a2xZcG9tVFY4cEdnVHBoWDF3U3RwZHFv?=
 =?utf-8?B?VU0wbFVwK3pkVGc3OWhnS1pSQ05RTHZnNWluNTljMjZ1TElFaGtqYXRBQnBL?=
 =?utf-8?B?UythVTA1eHZNbTZZZlVaZ0dzUDNnbGFEaHZrYzU0VzEyckI5LzBaZUp0ZWhx?=
 =?utf-8?B?L0krS0JFSjExemc3R3FYSUgwVEIrZDFZaFM3ZDBMdW40M0Uwc1pybUlEaXhW?=
 =?utf-8?B?T1I3R1dJL251cE5INDVEYXF1ZnJwbldrc2hnVHpmdEx1ZTBWOGpkYlRRK2tk?=
 =?utf-8?B?cUkzTm9QSDdUVkFWdEo4OXNVZ1IvVkFqU2NrM3Z0aEtXaC93djhkblNwMjEv?=
 =?utf-8?B?NjNJUndLVVdPdnJZeFAwUUpHNUxKSXUzZ24vUUd0MEN0c1FDa0UzdXhHVU1S?=
 =?utf-8?B?VUhYRHJkZS9WK3ErY0Z5YmFoc2RRbHZkZGJlMGdVM0hVclRlVThWYld4a1NT?=
 =?utf-8?B?T0Y1bXd6MHMzU3Y4MUJQamFGMWN2dVNHd3NDelMzR1FaMERPaWhhQ1ZQZ3Ni?=
 =?utf-8?B?NHhzRXc3aXZraXgvT3FjbnQ5V0VpWlpGSmFXSTFUd1I0Y0N1SDgrbGNtTVBB?=
 =?utf-8?B?TzMvWUlrM1FFS3dKeGFaUFhkUXNlckpSU3FSUG9Pem91NHVtWDdZMFVLMkNp?=
 =?utf-8?B?Nm1ENWxsbGNoOHRvLzBCNitkQjRIQ0lGKzJKdnZkM21oU1R6WGJPb0tRTTh4?=
 =?utf-8?B?a1duSWxDbWU1WG1xS0N1a29yT1hOMmJLTHAwdFllOUlFSGMycXczV00zMHQx?=
 =?utf-8?B?OVlKVUNxZmdlQ01LYUxEYUxMWXppc0lJR29ManBaM29KNTMya1VoOWgxc1Fp?=
 =?utf-8?B?OGlRYVJrQUJ4SldZWlMxbVp0SlZWemRqeERSYlBicm9iR1l5cG5OQ2NjZWgr?=
 =?utf-8?B?OTFqMS9SbkQvYVNTNVRQNHJoS1J4NFVZelZuaHExQmxzL1NUNEpscUFnME93?=
 =?utf-8?B?R1d6SE02c0NVMXhTT05lZlVPRW1rejRDZzkrRDhaUHU2NHZ5Vk1PcVNiNEtG?=
 =?utf-8?B?Z2RrcHpCWjBKQTZ3UzNpbm5xcWkxNXM0V0QrWk4vNGozaVd0S1IzR01tNnVM?=
 =?utf-8?B?LzlEYXprRmczU2M5bGNKZ3JMbWZCYy9aV1R2a3l6blJWV1Q5UTlJRm1zWEd4?=
 =?utf-8?B?R05WUkVvMFZRVFU0Q1dxTGY2WEFwTzhZOUlQelVOZ0RwQkIwSDd4Qm5QM01J?=
 =?utf-8?B?Vk9YcjNZU1hVem42c3hLT2NZRVZtZ3J0Tm9SZml4UWJaL0hVeENGMmt4dUlq?=
 =?utf-8?B?YXpYQ1QreXZEaWx3dHFxQkhZVXkxeVZtVWZ2VlZWQ2hLMUJWWXRJUTBtZVFV?=
 =?utf-8?B?NTdRSVZnamZVVnRJbm43WlBGcWtTZFBZbmpiSVpRZGcweFRzU1k3T1ljZGtv?=
 =?utf-8?B?M3A0T0tnTmxMY2J0TlhOOGVjUXBPN0wxMGt4ZWVNN1QrT1AvYWNySmpwR2tB?=
 =?utf-8?B?ZENaR2lEQ2lXeUpNaWY0UTJBNUl0QXcwSjArUUNZMU52K25sZERuSHdNYmFL?=
 =?utf-8?B?emwrS2MvUGhDRExaRW9RY2FkVU9MOHJHSzd5dFdJVFNsVHFmVlJ6WU9QOUNB?=
 =?utf-8?B?bUdsYXVuN2hwVlZ5NGNDVm5nYWFXeExjWnRLNlZXS2xRMEx5N25zY1Y4VlRH?=
 =?utf-8?B?QjAvUWFma0ltSDJyODNTSGJSeXpGYUMvWS9GY2QrOUtxTjlGdW0ydmZ3Tmh5?=
 =?utf-8?B?R01qcmRuU2FvSjBtay9RYWUyNTZtSGNzcmRjeHhaZFB2cll5UFUrbmJkU3NY?=
 =?utf-8?B?UVdkTGlhZE5vcEVTTlhuMDdwZzRURVphcmVUeXBZczRBWk5obUduMjdHYitM?=
 =?utf-8?B?WHpBZHQ5d2lxOVduVDdQc2IxcldmYXR2U0pacWlObTl4MW5VYWJsWnB3TWpK?=
 =?utf-8?Q?4eKn4x52eWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRYV1FYMnV4b3R1ZG92YkF5L3cyRlhRWGp0MTFtN2hlOHJnNWkvRldmTDJS?=
 =?utf-8?B?c2g1UjlMSWJOMm5BUEh6NFJKUDQ3Z0xSamYzaWRnNWZUV1REbkFiZ3U3emxh?=
 =?utf-8?B?NURYSG1yZkY5aVRocUhwUmNleUs5N3RyQjF4RWxkTE1LWW94UFAxclVQdFpH?=
 =?utf-8?B?b1hpUHB6dkdGUEFieUMyRVp5V3NzS2h5UVQxTFViZnF4QjJTT2F1K0FOOEtU?=
 =?utf-8?B?RmVqS3VVYVEzc0dnQ09TY1kxZXovVnM4TXlNZTkweURlbEJQV3QwWlFlSjN0?=
 =?utf-8?B?Z1FiRmYvM2dJb2hBVDYyRmJ2NzZsWkJPdWw1Y3BsZThxOUZJWDZNV0I2em4r?=
 =?utf-8?B?YWVLZHJ5MXYrQllnalcyd25OdnE5MEFXZWcwdGh0dVYrSHY1TDFldllmd3Bs?=
 =?utf-8?B?MnhPSExyZWxPb203UTJoT013NkJJV3d2TURadzNPQ2pxazR4WWJWcm9wc09n?=
 =?utf-8?B?MTVtQzZDckpaQXRRcDlUT2drSHpjNlRubkdhaG5jTDZZNnlKT1RPQTRZVmJu?=
 =?utf-8?B?K1VKei9hVkR5Umo4RFAxTU9KanJJOFNLVWUwVzk2UzZnWmJZclFhRHptSEda?=
 =?utf-8?B?VEJKY2xyQkl2aUFIWnBFRDdtbkxxczZQSjh0VTNHbEtRNS9hQ1ZCRkxHNzV5?=
 =?utf-8?B?S3Z6ZTJUcWVtS0doZ3ZGSjZOYk45cy9FOWJ2UGVEZk05dFRCV21hcVhwclVX?=
 =?utf-8?B?VkViWGpJQmk0N00vV0F5dUpzQjJYS3ljKzBDZVkzNk8vS2l1QmJKd2R1VDN2?=
 =?utf-8?B?dlNyNXpYM2tsVjY4Mk9yb29mcWErQXVpeFhUWU9BcWRVcHBjVFlkc2xzajdI?=
 =?utf-8?B?dlpTUHNjMG4xK0JVWmVDV3YzYjBnblJmRHRjdUs1WG1YMVN5dEE0YktCV2w5?=
 =?utf-8?B?TmpDUGYvdTlEUU9tdCtGb1NNTDBoL29KcFI5ckFYR1FJNVFzb2tXZFpaN0g3?=
 =?utf-8?B?TXY2a05qWFlNRFpOYVpQVnJzV09iNkpEUUZCMEl5eE94WWZlNjZUZWt6UXo4?=
 =?utf-8?B?K0xmS2JNWGs4RWgvNHNpaHRaNTlGVEdhQkJ4a3VWbGJ0RDZ2NmJBU3J0dEp4?=
 =?utf-8?B?Mi9lemVMTWdnYW9TcDFjOEs4emRIajMzb1BHN0JveTFiRlpLNnB0cTEzT3o1?=
 =?utf-8?B?U0hnOG83S2lEUVhGR2FwQ1NWdjZPb2VvVWh2VUJKOXZXMkVMNHdBdVpWcE8v?=
 =?utf-8?B?UlNXeEJNWVoxeHNveDUvc2JNZHY3ck5LelA2Sk9Hc1J6ZWt0T0wyclJrTzMz?=
 =?utf-8?B?NnFtQ0k0aW8vei9BY2FtZkF5SC9VdTlEN1N4NG4wK3g1TkpIOGt2MHphY1ZR?=
 =?utf-8?B?aEtkZDFVV0hpKzZJUHZkTmFWRGlZeHhuM3p6Yk9CektIMkx2cXo3aUZqYmox?=
 =?utf-8?B?Wkh2cTlQZ1M0cytaK0dWeFgyK0orZVo4L1JqU1ZudUgzSitzYnErYzQ0aFRB?=
 =?utf-8?B?MFlvWWE1Q2NCYXFpRHlwWXhOdU5vZmYzN0s2d25PSkRzSTM5S2dGY0VYYlNi?=
 =?utf-8?B?VmIvZUt2TDhFUnIzb053N3daSVNKV2xuRVhnYlN2VmU4d1JjKzZ6UjJ4M2x5?=
 =?utf-8?B?Z0tyUk9JaEV4QmtSTHJTdmNGTVQ2R2Q2VzRraGJpaHpZNTc5UFJsNng3T1Yw?=
 =?utf-8?B?UGs5azFQV0pkcDFtOU9rWHNpQXphOTYwbG5PaDN4YWpLdXk3a21KSjdadi9D?=
 =?utf-8?B?aVhXbklvSjlCMFdOU1Y1UmFjQldaNVBDSElYQ0JaV3JteFRRWjBvRmQzaWRJ?=
 =?utf-8?B?U01nWXdyLzlLSC9VZUZpZUVBbjJNb3VnL0dRTHR0VmdmUFNVV0JKRHY2Y0lu?=
 =?utf-8?B?SXN5Rm1NL0lsaVp2M2Z1alFBMVRicjZ4RjJYTnJiYVlrenV1Slh5WmdsN3pF?=
 =?utf-8?B?azVPd0ROcENhS29JY2FXbno5eXJmekQzUDJvMUJSM0lRZXc0cVkvcHR5QkZo?=
 =?utf-8?B?dWFZelNBV2dkbjMrOG5PaU4yOUJ1VUlQVitnNUxlV3lKSzBCQVVQdFBpdXE0?=
 =?utf-8?B?SURsM2YrN1BEYmpyV2FNQXRHaXlhdGczUlBlZUkxY1BjV2p4V0VhcUNaMVlE?=
 =?utf-8?B?dFhOS01GOUZuZ3E4bm5peWxtazYwSHVXSWhyM0tTWExRckIxSFBWcXhJYUw2?=
 =?utf-8?Q?gh17vq3M/TKNJsyYpcFj4xJky?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09065906-b0e6-47b0-75ea-08ddc5cc0394
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:23:38.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X32tlsWkoObB2M2XawLcabYh4TnAZhAVb3l2UaEe8WWTMkj9fwP/LVabyr3KrvnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441



On 7/10/25 08:13, Harini T wrote:
> As per the design specification
> "The 16-bit Seconds Calibration Value represents the number of
> Oscillator Ticks that are required to measure the largest time period
> that is less than or equal to 1 second.
> For an oscillator that is 32.768kHz, this value will be 0x7FFF."
> 
> Signed-off-by: Harini T <harini.t@amd.com>
> ---
>   arch/arm64/boot/dts/xilinx/versal-net.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/versal-net.dtsi b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> index fc9f49e57385..c037a7819967 100644
> --- a/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/versal-net.dtsi
> @@ -556,7 +556,7 @@
>   			reg = <0 0xf12a0000 0 0x100>;
>   			interrupts = <0 200 4>, <0 201 4>;
>   			interrupt-names = "alarm", "sec";
> -			calibration = <0x8000>;
> +			calibration = <0x7FFF>;
>   		};
>   
>   		sdhci0: mmc@f1040000 {

Applied.
M

