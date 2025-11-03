Return-Path: <linux-kernel+bounces-882542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24282C2AB1D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084F018907B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AF22E7BB3;
	Mon,  3 Nov 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="Ii8ero/R";
	dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b="pm7FMw77"
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C372E6CA7;
	Mon,  3 Nov 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.142.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161285; cv=fail; b=NrUGnlSnvbcdYM3fjMe2dfqzA1RvmlnrAJqg3GJKGASaha1IIZwwyJafZSOyBLI5Ce9nxlnh1zASMAZ719Q2N8emswwdpA1qyxJPJu1nyYtjBKGV+/ez/iFkIMVUiD79qg27cpd0ImK+nOuZnvE4RAEJ7aTTA8RxOpWMRtLxoIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161285; c=relaxed/simple;
	bh=pxrcb19Mc642PvpfZgTBSnROtnMXKPTn9kEpIiCcvW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bNNbhJJNo+Gq8Tdg9wFtrs0bIA3eliqjQ5d+UDBXLzUcYg/XRRkuLtHwWnD5RwHUW3fYHeuI+CPrmHj6Bsjx7oVZFqgJOumaKEoLkaNeWfznZxWRcSTvkEgEYwlPg10UbwSA9oe575kkN2a9zorTtPP/+cK2o3ULhrK6lSUGhtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=Ii8ero/R; dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b=pm7FMw77; arc=fail smtp.client-ip=148.163.142.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Received: from pps.filterd (m0484884.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A33LTIr016137;
	Mon, 3 Nov 2025 09:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=hkAu
	wmNbEnugw7Mt/O8lk/nTd3TAPtVRNryZTv10N1s=; b=Ii8ero/RTvbAyOi8M0Tc
	uQ6Td38oFrT97r5T/nAozgGM3WUTTFxxP8CG0VJrOrpOKXRvq7HBmbFWF+PXctF5
	vMqQI6LWt2bs7/B0qG+iu0osBSg2JDTW+jFgrT/SA6MXzGblFwrf9uyOesz8BxPZ
	vDfiXonrhiWvvj2T2SzfGRv6ba6czG6OhC2dTfCScZL0Sgg7aR8b70Bq96vXLpi8
	PXaaFNt2TGbl4lsrnefbmWJTR+bkMHCMW1oB8/vW3yzWGyEDgHUKxurr9K1oTqBo
	eK4gobPOykiLcdLGGVUVy/HSirSHAGYmm7ZJrci+nX46D7h2Hh+6b4VW2vK9y03Z
	pg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4a5xv3n7un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 09:14:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hqqrh1fjtz6bXY2vzLozrNnshbmiHmWe7o8Qryok5atFPXkD4VhbhFjYPab6iozNooXwRUVYH/fRU8kbinqWGwR0yXsevkwfxZCHNiaOcdoC3ZzVexS/S+V2uQFHhdRyTwHbt8xOCeUD6zuBob8DQjhH6D8ZEq6amLFr8+aslZeVlUT4x2hB8VffAFv0ljPPNn9FgAMh4tTe+fFbCSJPZgxiwJpS7s3xDellXzQh9G+KZONI2NGHiBJxQ2D39cVATGBAfVM5KPuiTt9oZiDWhMoczO9ygy5wTiHzkTdykZYSOPK7OeWJpGn0aIXzo/koEb5aVDR4kz0Q2VB2bfOI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkAuwmNbEnugw7Mt/O8lk/nTd3TAPtVRNryZTv10N1s=;
 b=FFTBjE6Wyv2/1cGSHxEcmTfIcsOLDq1+bcdIVlgg0SWXtwRxH5ekdwwxEzMj15GjFXKL7jBoUMhxihqth6gm5xEK8Pczj7MYq6Oa6S5rNJvk8SgCULOuoLG1+w2f6HuieGF6YrkXiLwjb22GVtEg6EnapsJMFnXjuuPzCQ5AfMeD2XpTJSHPGRhUYu5j6BfnpGZ835dLTGC762SN3aEiAi24yUwsvEvHwK/1kEhBo3wB1U+5eZIUh7qAAC7YS8zqSk1J/IbEeHng+OL8ZhjnG5I+TgWfrA2yM5Nzk2mIlnFBkkbimpBD/+F39CDGrHZaqx7owhWogLOdbrewPwsevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Emerson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkAuwmNbEnugw7Mt/O8lk/nTd3TAPtVRNryZTv10N1s=;
 b=pm7FMw77+1qKJ31SDBErI0zawEaH0hUQEMzKIxv9tTimZaWs2QDPVTHQi7txzeTABGQJUYQKvRJRWh6ne1rAESt4957oOzx0MrGuENOFRafYmlPWiJHlgULplA+dfHNCvLr0Q39FqZ9Y9fsrDVADgqJ+KVAXpforWEr65OLMZzkzhNPk2NoXAGZlGIJwwW+XYNRc9nS4GKNdd3++I0mJhByY4ziYYw6XgC4kjpywaeg7Ce82CP7aeGQMW7e523uWEloy5ZIybPDtGyYKJhUyfnd76VQGlLw741iXfgbPHg6ZE1Kc1d3sJiB8Lmln17osRp9f5Nzdqge1vT2IzE7WmQ==
Received: from SA1PR10MB6614.namprd10.prod.outlook.com (2603:10b6:806:2b9::10)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 3 Nov
 2025 09:14:33 +0000
Received: from SA1PR10MB6614.namprd10.prod.outlook.com
 ([fe80::80bf:9034:8477:6009]) by SA1PR10MB6614.namprd10.prod.outlook.com
 ([fe80::80bf:9034:8477:6009%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:14:33 +0000
Message-ID: <ecf736bc-c679-4473-be22-a98ed2b2fabb@emerson.com>
Date: Mon, 3 Nov 2025 10:14:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re:[PATCH v2 1/1] arm64: dts: xilinx: fix zynqmp opp-table-cpu
To: Neal Frager <neal.frager@amd.com>, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, git@amd.com
Cc: michal.simek@amd.com, jguittet@witekio.com, jay.buddhabhatti@amd.com,
        arun.balaji.kannan@amd.com, senthilnathan.thangaraj@amd.com,
        micheal.saleab@amd.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
References: <20251103065344.4022482-1-neal.frager@amd.com>
Content-Language: en-US
From: Thomas Hommel <thomas.hommel@emerson.com>
In-Reply-To: <20251103065344.4022482-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To SA1PR10MB6614.namprd10.prod.outlook.com
 (2603:10b6:806:2b9::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6614:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: efcba7a9-4c95-4472-23fd-08de1ab966ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amh1Vy9NR0FuRHozN1VaUEZPQUVaT2Q0Q0N2YnJsWFR1OHRoRC9VSVlDaE45?=
 =?utf-8?B?TkpxUWlnbk9GNmRVMjhUN20wWEhFSmlsV2lUYTNDckhFT3ZTdmRWZU4zaGhX?=
 =?utf-8?B?cXBYNEgzRmtadGNnd09MWEZwQm1UcndXenFkSG4zSnUyWndJTk96MHFQaS92?=
 =?utf-8?B?WWJhTXoxWUJVQ0hsSkdMdkVXejRsdEN3czZUQlpzSGdOWTU4R1U4MlZQZmUw?=
 =?utf-8?B?QmFRa3VDalEzNW5ZNVJKSUZkK2d0N0hldmdlL2NTSlZVeWxvNUI1TnhNWERt?=
 =?utf-8?B?cW1URGN2K1BNeGVXbTFMS0tnMTlVQ1o3YnhyUXM2cEZnZnNqdG4vY3NPMk44?=
 =?utf-8?B?RTFWT1crMTkrZkJQT2JZN0lXTDVWcE9VZnp3RDk5VWQvcUNrcmtmcElqMDVm?=
 =?utf-8?B?dHZJR3hROVptYURaYXZ5cWRLQWo5Q1R6NFBidUs0cFpZTE1yQlFkbHB3cERh?=
 =?utf-8?B?cnZqckhYNTRDL0Mxa3FpcDNvaGhXM3pPWm5LN2haSTBCc09IMm0zZHI2Smli?=
 =?utf-8?B?cjlRTUFhYkJ4UmpkYnlsS3dCUW1sRDFkYTZXblpxNWhTN2FnaEpsaGFuMUE4?=
 =?utf-8?B?U2ptQjRJdFlBaVk4aE11dXpqaEdSU29ueHhNYlRjVFBLZ1ZUY3o4Qm42ejhx?=
 =?utf-8?B?NXZuRXlTMUVkNzlTRmcvMUEzOW1nUUozT21JK0sxQXZjb2l2NGg2bFVLRXNp?=
 =?utf-8?B?OVhlSUZFTkNWeHlNWkVJcS96UTFoUHkxRHNhVEVWU003U3BxUlMrOVN0bEIy?=
 =?utf-8?B?V0RtOThNTldQTDRsTlBUTzFWNVJrV0txSjA3ak1FL25NN1dtQnJHV1U0Y1M4?=
 =?utf-8?B?RVYwdVNvMVFGSnRFaXAwcS84Wmh5eVNWVE55My9oZUFBU3VlaGpLeXovWlBv?=
 =?utf-8?B?bGRzUXZQdnJsdFdSUk14UGhyajdZb25GaWV2WGxzV2F6RVFwYnNpQUZkM2Vy?=
 =?utf-8?B?NzBkbGlnV2NMR2JLN3ZFdUdpMjlhdjZGczYwV1k2ZnAxUWVhbWN1RzJSVC9w?=
 =?utf-8?B?VjJ0dmhFZjhKdENiVXdnVlFXZ0syR255REJRSWVTeXJ0eDdtckF1VWFKa2Zo?=
 =?utf-8?B?MkdCYWFiTGIvWGwxK0xneHM4SDkxRXZScmo5UElXMitJVG9PZ1E4WkpyUzY4?=
 =?utf-8?B?cUwvakE3TVBEYXY1NW5RZ2V6YUZJUWg1WkNteVl2KzQrMHBxTlNaQVN1WEVp?=
 =?utf-8?B?WWJGcU5jcXBNNXIwSkhidlVabkZsUGVZTmZFZStuNVJzbGgxZVRWWVRBQXI0?=
 =?utf-8?B?cUdQbHUwZWJtRW4yZjZhYkg3Q1JlbmpBbzQ5WVgwVjBjU2M0MUZ3RHZRYzUz?=
 =?utf-8?B?K3JocUYxVzkwZ3NnUUhmWlhUdW4vc2ttY1NCeW9rYlhrYlZ4UUNJUUdNNkdz?=
 =?utf-8?B?VXRLRW04Q3Rtb0FDRlRDekVaaFhlbngwWW5rSmw1WHlHYklzRFhwMmhCT0Vs?=
 =?utf-8?B?cTRUa2FZMGxvMTVPMnQzSGNnZVVmbk5yWWdDVXJYejZQQ0l2dHNSVVpyMlNp?=
 =?utf-8?B?MEVMYkVTWFdzZUZzUUNrQTNsRXd5cWt3bmF6OVpJVmVKa3Y5TE9vMndZODM2?=
 =?utf-8?B?VTllK3FEV2liSy84L205ZWFqQWl2UU5LZG0ySG1SbXZ2bnBweDJKRmcrNkp6?=
 =?utf-8?B?MkU5cmV3ZytzbkF2S0NxNVJKajI1N1dDSWFCRXpmUk9BMTBKU25GQjloTTlR?=
 =?utf-8?B?UjNOK3VBTTI4OU9QVWtXWWlDL3ppTysxZ2ZXQzgrUzJDWXdwOW93Tk81T2d4?=
 =?utf-8?B?RGIwYWw2RlBpeVY1a1VaVi81SE94ait1Vk56R0lmZnFIdXkvZDlyMlMxR2pO?=
 =?utf-8?B?WW4zOEJaM2ZsMnNiQ2wvLzdSZjNIY2kzemQ4OWtVUFUrQ1lYRncyb3NmK3pF?=
 =?utf-8?B?TGN2aU9HT1B3cUlzUkFYT3ZuZ0JXWml2d3RTL1F4NVBhd0o2TzlEN3paY1JM?=
 =?utf-8?B?elgzZnppTThSbUJ4ZkQyUkRoMndXS3oyTlE4UW1OTlhQS1BCdE8yNE9JWHZ5?=
 =?utf-8?B?ckhRdWJqdXpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6614.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW1DK3kra2VOb21Bbk50ak4yUWhtaXFrRC8yUTdtNDE1OXQ5M05OVWZZdUdH?=
 =?utf-8?B?aFZmSEZQRm1Rejh1eDFhTmJ3MzlLY3hpdUlFWlFNdWR0OGFCQThRMXVML2Ux?=
 =?utf-8?B?b01xZ3hGNzk5clpEczI5VmE4b0dXKzIrbDFXZVdTclRNeFQ1TUtLaWlIYlg2?=
 =?utf-8?B?SE5CTzlPanBTd2lLK0FiL2ZQbWhQditubGYrUGhKSHVETFRMVVhGOFZDQ2dw?=
 =?utf-8?B?dlRURk5FNGwwdjNpUTl5R1c3WXVxTGNPempTa2dxVUM2SHFLdXhEbkVEWGF6?=
 =?utf-8?B?b2dJSVVRZndZV2gzcWUvME56ZE54NTRjcFJzTnhRcFE1aE42eVFLc1VYWFBp?=
 =?utf-8?B?RXBzRVUyV3pTcjNvcEZNK29PLzU2N2RZQXEzZU00YWwzcmZmblBmblBIdWtU?=
 =?utf-8?B?ZFRTemZWV2xoNXJ2Y052R0krUitSMVlpREZ0bkJ5bVhZNkxBZ2hMWWZMbXJS?=
 =?utf-8?B?YjZ0NmxjR2liY1NrQWdxT3VoaW1HUzZxUng2aml0KzlBeG14TkxuSmN3UDBL?=
 =?utf-8?B?Wmhmek5GK3o3cURQTng2cUtDY2kyeW1VK1d1azhydnFLVjRnczBLMmNsbW1s?=
 =?utf-8?B?MEpSaCtpc1VPWDlkazVwZ1BvbUtETy80WnYxcE5OVUNiMStmTU1BVngybFRN?=
 =?utf-8?B?U200d08wZ1lVdkNHbEl4TDdDaEtIVTA0T2JnTVFoWW5ZWlhNZnVGQW5SYjVr?=
 =?utf-8?B?OHVmUzVnTUJybDNjSWtxbUJXNzJEZmRlUDNSMTZicHdIUXlwNHM4KzNYME1D?=
 =?utf-8?B?RmFkOVVtZWNNRnNKTFBabExjRkFabi8rNStqNkZIUkdxd0VzT1psWGsyL1dJ?=
 =?utf-8?B?cDhqMFVYL1RwZ2FPamRjc2pwZFR1bUZjeTgwYjNUOWlpRHFZNlpOb1R1Rm5V?=
 =?utf-8?B?R0ZNZk5kZ0VrRGNoU1pNTXFrdkxuTk4vWlJReThPM0NGV3hMUjRGZkRaWWpR?=
 =?utf-8?B?UzAzUXRHaTNkYUtlNVM2U3hsYWJ1R3JINVJweHNIaGV4ZWYwTTBzOTRrVnls?=
 =?utf-8?B?RXFDUHdaZWtxRGVYQ1dsbEZENVhWdkdNS1E4azBBUitPa1pZRzV3Z2FsWWdx?=
 =?utf-8?B?U2tvdkpQNDNTSFh5ZnBBcFNvNXJiaWxheFlDL0hwbXhRWmkxZkxJakYvZWdN?=
 =?utf-8?B?T2wvcnVtY1hTaHdPQ09nSkpxQndrYmVNV1IyR041VGxMMzZiWDN6cW91SHZ6?=
 =?utf-8?B?L3RLUktWa3VWeXkzTVhSZVZtL0RadHlRRmg0OXRCTWVmNG5PUFl2MFRtTU1L?=
 =?utf-8?B?WG1JK1hVSlErbEZGb2RhVWloVU1iS3dZY0VMMkl0Um1lN3BabVlDeTdqQ2Q0?=
 =?utf-8?B?MjRWWGMvV3lzRGljNTJrNFl0c3puSW5vUTZDK3AvcmV3ZGdwbm5rM1lRcDVl?=
 =?utf-8?B?UldiN3NnWmtleWRnN0I2Y3l2c0JMQ0prTTVGbkQwL0l6cHJwTWVJYzQvd2Fu?=
 =?utf-8?B?OUpXT2pJS3k3ZjZ6cGlITlhKNGJCRVNEMzJ4bGpqZHpDd25tckIrYVViTlhT?=
 =?utf-8?B?K05uRVVNcnpvMUx5YVZVSjdzTjFJcjlvbnRSK2ZGanpENXhDMCs3N3VYZVF4?=
 =?utf-8?B?akdiWFlTYjRXUU5FVkZ0Y3RkU0hWaHN6bzVsVWhCSkNqZGRJRHJFYzkvd3c1?=
 =?utf-8?B?eEdLRGRJQ3V4WEplUXBEVklFMEZQMU9HM2xSTjhVVzJGSGhFeEhQb1YyN3k3?=
 =?utf-8?B?bGl4dVhVMmZDa2ZnMzluU2ozOWZXei9naG5NeHE4Zm52blhTU2tsUDdkRlUw?=
 =?utf-8?B?RGhlbzhvZHFtYUU1cXV5T1B1QjlSdjdWUDJrRkRiUTRXVmhpK0dLSDcrakdT?=
 =?utf-8?B?L3BERzVsL1AzVUpsNGhHaTNtRkUwTHRXTExqeWFZVlVNQVBwWHl6Qkk2cGJ4?=
 =?utf-8?B?M1FDSTNNb1lyRFBrVGZIZVY5WDNxUHkyVlRTSEhYNWVUNlBWdGMvdW1SaUFX?=
 =?utf-8?B?ZEF6K3NIS05JTzlERkJkMDY3R1ZDbm1HbDEvQzgyc3RvV2NmckRTYklHa0xB?=
 =?utf-8?B?NG9TREdWUTd4bko1S1k0RFNNRE9sRktJRVo3QkdFVmZWM2tYY3VyZ3lEMWtJ?=
 =?utf-8?B?N0hTLzNIMU5wWEdrRWZYMktsbXJWK3IzS1pVOGxVdys0RkhNYjVhTWpCbDlm?=
 =?utf-8?B?clcycG5wS0ZkN0F4elF4citiRjJmdFZLRTIvR3VPRGhjNkZ3a25xcHFrR0xG?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcba7a9-4c95-4472-23fd-08de1ab966ed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6614.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:14:33.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnV3+6yxTgr49olHq8qpbg/Fh8jvpOLXI8FOhibsxD5V24eV3ZRhpd84FUjEQPDeBlkuPUbx9HMFKeNwEVU9qso8JJhKpDxR93puOGc1kos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDAyNCBTYWx0ZWRfXwm2DOdAxZJW5 XqUtR4axm4JRlxvcW6mScvf6hcJAEW0FO1VPbnYDlr6wrFLqZAxClRRZfFsXdGlk0/jl054iUBM k4/cjcHNqZVNh8TEi/TpfPiT9M4H08gfcSy19aVCadC1Zprteo+p6LEWSXXMPv+dQIO/EP7Ztjz
 YFTpwHyds3BuFOs0NvuEGJ0/8zmtPhOFPEAF4Tk5/INP42jkcB1i6ITSpV8Vlekk1EG/nkMxGf7 rhZL3YFA+FpGHHVZVOgpHUPqfBl1YGHciVemgp9T5u5/8gRXzngmYKY35OcbBjYFi3ztoOq198p zDPchmR862jgSrcXVaC0rrat6sYVpPB1rBXtInO+SYuNo4UYxXCdJmc0/dZnIOufkSEPQEZ0Jvp
 M9kTw5V47TukbtZ6XnEevFPplCGNfA==
X-Proofpoint-ORIG-GUID: 5QAtGc8ZxZzzPxytCqx1Tist8h9as3Xf
X-Authority-Analysis: v=2.4 cv=EerFgfmC c=1 sm=1 tr=0 ts=6908727b cx=c_pps a=YpUwD7Le0KImUpHpM7zjfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=ZPWZ4rD8_x8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=geDs06hvAAAA:8 a=zd2uoN0lAAAA:8 a=pIErxabnKMYiBJYXHqcA:9 a=QEXdDO2ut3YA:10 a=7yvi0DHx91fDKfvzWsLo:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 5QAtGc8ZxZzzPxytCqx1Tist8h9as3Xf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511020024

Reviewed-by: Thomas Hommel <thomas.hommel@emerson.com>

On 03.11.2025 07:53, Neal Frager wrote:

> Since the following commit, the zynqmp clk driver uses the common
> divider_round_rate() when determining the appropriate clock divider for a
> requested clock frequency:
> https://github.com/torvalds/linux/commit/1fe15be1fb613534ecbac5f8c3f8744f757d237d
> 
> This means that the typical parent clock rate will be 1200000000 based on the
> zynqmp pll configuration. If the current zynqmp.dtsi opp-hz values are used,
> this will mean the divider calculations are always slightly above the correct
> integer divider value meaning they will get rounded up to a divider value
> which is one too high. The result of this issue is that the cpu clock speed
> will always be one opp lower than the requested clock rate.
> 
> For example, the following will occur when requesting 1.2 GHz with the current
> zynqmp.dtsi:
> 
> root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 299999 399999 599999 1199999
> root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
> 600000
> 
> To fix this issue, this patch updates the zynqmp opp-table-cpu, so the clock
> rates are calculated correctly.
> 
> root@zynqmp:/sys/kernel/tracing# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 300000 400000 600000 1200000
> root@zynqmp:/ # echo 1200000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> root@zynqmp:/ # cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
> 1200000
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
> - The clock-latency-ns and opp-microvolt values did not change, so simplify
>    the patch by only changing the opp-hz values in decimal format.
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 938b014ca923..dd9bd39f61e8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -103,23 +103,23 @@ CPU_SLEEP_0: cpu-sleep-0 {
>   	cpu_opp_table: opp-table-cpu {
>   		compatible = "operating-points-v2";
>   		opp-shared;
> -		opp00 {
> -			opp-hz = /bits/ 64 <1199999988>;
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp01 {
> -			opp-hz = /bits/ 64 <599999994>;
> +		opp-600000000 {
> +			opp-hz = /bits/ 64 <600000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp02 {
> -			opp-hz = /bits/ 64 <399999996>;
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -		opp03 {
> -			opp-hz = /bits/ 64 <299999997>;
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
>   			opp-microvolt = <1000000>;
>   			clock-latency-ns = <500000>;
>   		};
> -- 
> 2.25.1
> 


