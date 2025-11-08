Return-Path: <linux-kernel+bounces-891193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE49C421F0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85F318971BE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896021F5433;
	Sat,  8 Nov 2025 00:20:08 +0000 (UTC)
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022131.outbound.protection.outlook.com [52.101.96.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88041EF09D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561207; cv=fail; b=uERRcqlW7RfHliEd4TN/+LARNylmiXPu/0Mp4NcYgAFVahxEYzzpHnLZWoV8aG0V9SDObx4Zk8HlrUNlH3OvGNco1rDzU0ooPk/aAXgXsjUnmXiSgnZi19OBylHtqF2nMSRlaTPBqSrqFlXmRQ2l6LkBHPYSWaR5rCJqYAmmz0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561207; c=relaxed/simple;
	bh=c1zW41IwkDQM//k8S8NxuNCbBFOfP+XL36zTENQtDWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFgv+61MbcL21yNOw0YAP2HEwBQaCE6hrTv4hJUq6imcapwdgseRpsIpQa7bdRY5TZVKKgaKP5TRonrG75/Z0cdZ0ZOKKfdd4MNSubmqCOiqTqNZqMzAtmAjv1XmEYEsIhRU3LIa3hWe4qhY6xrmD3aka4Z1/25Xjc4eLCW/fzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g07etq7BcB8b7yZNQL79yih7SjAmJLQ8Jo7IuoQNb9O7jaRC6XqrTreMJ4uSfzo6iMGoNFlopt/hyD1ZHlbWXv6ZRSeG+iGXx6G1xCc+yJANeRkL6560LXcqygSq4U8bXdMjRIfrOrUBRTCt8j8PWp0h9HRyTN5jojaa6/HZOPAdz9k7Z7Yh/Kt9Ib+hSaX+PC5056mLUGw8JI2kNjhEhIirUej0JrVI1A5s46jqG3PP6PZHvBUU2/S5yXVPsLWTjWhTKe3PfRFrp3ZV/grF37u05YRNFlkBzdy/ipLefkhGjD75L5eSUXopclXhcGT8ECb9h6+0KZydI0cSP+W1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJWiIHaac27XUqYeZQD5ZgkHsuDODChNl/Rgw5qZxqs=;
 b=lIhG068IpgQwIJiSrYPkNCFR2zB2uIy3OcE3fafvAagDU82y32lYaf8LrJLPlEBlHE7WRN1t0eiseN7t5aE3TM/71hg0WvTOajsvatdqvg8NRpL9fdueTUyZUygrYzHBNEYRqQevJo1JsySpCtrPP9iV4jQaazNPaemgnv81yhlBIF8s8KcRjcEM1+4RZPCVNxNDFTOap7DoIglxS4zn78dFIoMAJSMz0G6eRlJDRx9FTl56lDXmNd37w+juC9gNEyfmeJHZMl+iPlNXGEsgNSaFihWt0AiJ4oKqmFvnMZstbSMHbm7jNQNOm/ya1fWGVsPshiE5dLMLa7dtzI1pZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2990.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 00:19:59 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 00:19:58 +0000
Date: Fri, 7 Nov 2025 19:19:54 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Moger, Babu" <bmoger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, Dave.Martin@arm.com, 
	james.morse@arm.com, babu.moger@amd.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
Message-ID: <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
References: <20251107012401.224515-1-atomlin@atomlin.com>
 <20251107012401.224515-2-atomlin@atomlin.com>
 <2a0b270a-e398-4d88-aa10-421f2769a759@amd.com>
 <53iuqiul6uo7zj6sfckm2h465cjusaxvpxrtdmnbmhvbzuqiq6@7ogm3zqddzjd>
 <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
X-ClientProxiedBy: BN9PR03CA0687.namprd03.prod.outlook.com
 (2603:10b6:408:10e::32) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2990:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f52ecd-70f1-40e3-b5fa-08de1e5c8cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXM4OTJFQ01lRDhqMGM2ZGI0SWRTbnNIS01EbjFzTGpDcXNpUFI4SWQvdEVG?=
 =?utf-8?B?ME5TeTBEamQzWFlNaTVyVjhKWFFVcWdkVzZWdW1XcWxJSzVEdnd3amU2K1hV?=
 =?utf-8?B?cExocTd0Ti9tOUNUUHZmcGYwM2NWWGtXQ0ZLbStjY3c5M2RXclZaT1ZQTmQr?=
 =?utf-8?B?aU90d3AzelliOXhGMXFwQ2tOajRXNTRvMjgwSExrREcwSEh1L2RpS05HSFJF?=
 =?utf-8?B?WHIrT3p4Q05WbmhlaWh3d2Y1cTFPQnJibXhGWEhHRGt2b2NUTDNkS1lnZ1c5?=
 =?utf-8?B?SEUxQ1Nib3dhZm1WZS9EWSs3Q2tIajNMTG1LcEhXYkxGMkFqdlpyaVpFN2Jm?=
 =?utf-8?B?emNRMElzQzQ1bk55RCtUdndNSzdEZm1INTExa1I3cVdoeW9nV25BdXk5cWV2?=
 =?utf-8?B?akNCN2NpQzBhUVBjYjJPUU5mRzZJVU52OVlSempXQjZOVEpMdm45bC9mVlp4?=
 =?utf-8?B?RzBEV28rVCtNSDFUVWk4L0V1dDFCQ0lkSlByaVA2R1V6aWdTb05PLzVZamNm?=
 =?utf-8?B?eldML1l6T2h6d1cxVGlZT085dFBpZlBIR3pVQ2QrTEFCVzVaaHFwTkx0US82?=
 =?utf-8?B?Z3pXNkFCalI3RzZOOFo4UEdncmZocUFuZUJQV1BpT2ZJKy8weENQM2p1bXBq?=
 =?utf-8?B?Z000clNqQ3FNMG5jRzY3RmV6aGJGTUZaVng4R1N4Q1h2Z2pWSlZueVlWNnU3?=
 =?utf-8?B?cmJWb25qdkpmU3JJYXJjcUY2SHIxa3JMK2NCOG9tV3E3L0tVbmkvQVh3RzNF?=
 =?utf-8?B?Z3cyN2lhMWR3T1NpSDZTM0FFYjMwZk5pbzhiaHZHb3JtOUd4RDlDOWR0anR0?=
 =?utf-8?B?eFI3YWJpUVdMU3ZrVlZWbmdrQ2NWbXhkZnU1cHBlMWxKczYwTFRVZnJid2dF?=
 =?utf-8?B?eXZTMVAyQ3hUbW9sVVlveGRQVFdlbFk4MVo4S2VMd2tVcURQdTFsWnNaK3Bs?=
 =?utf-8?B?OTg4Zy9MR2QyT3FMSEN2NHAwY2FyV2N2SkIrOHNUTU9HbTRrbFRLNUsxMUo4?=
 =?utf-8?B?Q1F6WS9jSTJhOXFzMVVMeXVzRnBYT1lGdFZTREtwRmtiZlBES05TMlpQUEp3?=
 =?utf-8?B?STBGRzUrcmNhRHNDdnNrVWs0VUJUWGlqSFBVZFRnejM0WkVzMFBkUXhkdk1F?=
 =?utf-8?B?aTluZ3ZlbTJ6MTU3SzBpUWpoSTdxZjFlcnFEazdmU0xkWVRad2dQTEF2ZkJt?=
 =?utf-8?B?OEdWSGFVYW16VGtJY0RHVFV2bkJGQ21KY2xZYjlmT1lFN1MvV2dYelJBYXc0?=
 =?utf-8?B?SjV5eDN2SkhTSy9FMHpzNWdYcVJVNUg4elNNcDBVWE44K3AxcTZGVlVrTFEz?=
 =?utf-8?B?a1NIUjJxNGlWNHQrSmhCOWN2RnNRS3hTMDN3dVhOaFZSNjBWZmFBMU9wTWZa?=
 =?utf-8?B?aVRKSDJxYWFnb0tuUWgvWVNLM1VIRFFkVVNzdkxXSGY1Z0hqYUU2MFNUVG9a?=
 =?utf-8?B?blB4N0dQaGhSL0xwOC9KdW1yamRtYTJENkVYSFE0KytTUmJUMHNVV1oxNG9F?=
 =?utf-8?B?a0hVdDJMQlNWbmo1ZEVXdS9kbEZmenNad0FHWW1lSW1hd1Q1VjdVUjF5UGtC?=
 =?utf-8?B?NndleTYxMlNXVVNGSk9aTzl2M0VnVnNHSGd4S3lRVVNjb2g1MVFIbXZ2RjBl?=
 =?utf-8?B?ekZJOElSa0ZTa2VWY0poTFlIMkhSWTMvQXlyN1BxTVFNcHBNWThCOXNybFRw?=
 =?utf-8?B?bFRja3g3enh1b2hiUG00RmljSzRsQU1UUUk3enBWYWhPVS9oTzY2UjFJVVUw?=
 =?utf-8?B?T1JvN3V1c1pyak5ocUk2YzQ2T3JKTXRBWUYxN2FyS2xvT1NKcFBjdlM3OTVa?=
 =?utf-8?B?cmIyYjhrZjR3aGdiWUY1eGdad3V4dkhmT2g2cDVWVVNDY0toRnRMdldwY3Zz?=
 =?utf-8?B?S1NhQThvU21kYm5EZ2hyUmdDemJQVjRnRXBMTUs5Umx0YnNxemNNUWp4QWNJ?=
 =?utf-8?Q?vFx3qGWIB1nsMmLhndzuQhfvEgHrxMVx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEM0NzIreEc4djMvSm1KNlg4NFNxOTdkdjRPenFGeTlOenJtT3Fod2NwSm0r?=
 =?utf-8?B?NjM0MWJ5ZFZNQ1ZDVlo2ZENFWVNGZ2M0eWlQV3FPUGp5SmJPM3E0VXQ2WFZj?=
 =?utf-8?B?ZEhoZUpUWURrZ3phblpOL1FHUHI3WXFVblpRaGZYQzl6UWVJckVzUXdDc2lN?=
 =?utf-8?B?NUQ2R0RWVEhaNEdZNFZOMG5zVnZ0Z2hMdTZGREpsWXZubXlzU24rRm5sVlVE?=
 =?utf-8?B?Qmk3R1A4Q0taNEdVZHR3MXU1SUdyQjdNSmtIUjdOSXhTTDlPR3ZYdDBXR1J4?=
 =?utf-8?B?MWFzWVBjU0lkWitRZjNLa1h6QUpGbktrYXY3MlZKUmNUbmNNUmlSWmVkQU1t?=
 =?utf-8?B?RG1QZXl6ZkRYTk1TNGF0d00yUlVMWFhLZW5OalpmZDVMSjh3VkVid3BHMWkz?=
 =?utf-8?B?VHppVmE4WGg4RjB5TkE2RjNOWU9ZTXA2N09wUTRIZjE4eXJkdG4vSHlmS2Ex?=
 =?utf-8?B?RFR5SVdaVkY5aTkxQy80YzVYdkR0V0Y2cm1qTVVCK3d0OFo2OFMwZVVJRXhK?=
 =?utf-8?B?MnU5SXcwaFQ2NnJ2Z2cwNTlPeHFlNnNoQlZsUEFjVUlGM1psazRYZzI2cmp6?=
 =?utf-8?B?THRvT0ZBWEtpY09XUXR2MDlldGJZeWZpQ0F2ZWFSWHBIS3M0TEtpRnBwcEYv?=
 =?utf-8?B?T1NTdDN2ZnhEUys0SGk3Syt6ejRadDJuRi9ZWjBQODNPZ3N6OVQ2cFJ5YzNr?=
 =?utf-8?B?UzNHOEtydkRaejFiVDI1cVRINVFabzlXVzY3Z1JSOWl5RzQrSjc1USt4ZEdv?=
 =?utf-8?B?ZFIxRFdFb3N1OWxGZXlHbDBoZVVXZThaVGsvKzlHOUIwZEJDU3dnWk12U0x3?=
 =?utf-8?B?ZXdRM2xrS0R1VWVBQ0FLcUlZb2kwMys3M25uakYzWTl5RlM1MExEQU1TWkg4?=
 =?utf-8?B?TUhjVXVLUmprS2RJR1ZiaEVmcGxmY1RELzVyY2pSMWxXQWZOdWJmeEpadkpV?=
 =?utf-8?B?V2RjRDR3WUJ3Q2l1MHhZVU9MYTNMZzFoeDhRYUhVL0cyWWJ6UnpIcDV4NkF2?=
 =?utf-8?B?enFZZDVSTmNibTl4YlVaci9nOXJpakNtUDlWOVlkMEFHbC9kMzJRRFlPeTRP?=
 =?utf-8?B?M3E0c0RzRk13bDQvOG01VHRtcC9HY3F6ZVhnVDNSRlJKczl0Q3FiWkdUako1?=
 =?utf-8?B?d0F1bXMrTUp1Nm4zSHdsVFVQMVRMcjFENDVkVDBFTnE2MFR3TGg2MjBCcFVn?=
 =?utf-8?B?cGZZRlpyT0IzZzAxOTNPQ2YveTUzYzN5cGVzM1dXVGVKUjhVZWJCc1NJRzg4?=
 =?utf-8?B?QjZONUQwaGtEOGU0ajlNUVlGNzh0d3FUK0ZnMzNUZ1hZV0JlRFRpSWdCT1VB?=
 =?utf-8?B?aWt4RlVBNEV2MzVVU2FmVmVmK1pSdjZYa2JjdlNCTmdLRk9tbTVnT1VRU3dO?=
 =?utf-8?B?eVljOVFzckVHMEZiL2Nndkt1eHU3Ky9vTWRBRW9OMSt6Yk9iSlMzTnFtcTRX?=
 =?utf-8?B?d2ZzNDFWL2pmaWNwTWE0TkpvUGVKdDFRbmRjdnF6YXVoQ2dSYnAzbG1MbWJv?=
 =?utf-8?B?bldvdGtMTk9zWDJsSWFBUU80NGJXWDg5emx4cTJmNGRyY3hpcnB1VlhJcVpW?=
 =?utf-8?B?VkdtVHZ1bmI2U1NSeXl1dzl4d3VJekJOVzM2ZFFVZmd3V0RhY2Zkb2ZtOTBq?=
 =?utf-8?B?cTArMHppU2JsemtObWY0Ym1TVHk4WkdXdGR1aHh0cTcwdVh4c3JJakptZmtj?=
 =?utf-8?B?a0Z6ZlZ5TG5CREx1M1VGL3JpNWpSS3dyR1RWRm1udWxNVm9kQW1KQUV4NmFU?=
 =?utf-8?B?ZXVIekpBTXV0WHQ1aFhBbTRGNXBwdFBKOUdnM05qdmhaeEwvWkxJY2FKWms2?=
 =?utf-8?B?alNOV28vMytJRVd4VU4zY2Y5QkRpbDVCK21SU2JyRDRBR0w2SjE0Tmk3MWsv?=
 =?utf-8?B?OXdxMHYyNVFEa0JDNk94aUhZc0xVeTJqUjNUQWJ2T0ZEckpZMU9KajFTYXJW?=
 =?utf-8?B?b0FTSDZMRHhvemVSaUZmUnFGS3ljYjdVT0xGS3dhRm9TUmtPL1NMNjArRm51?=
 =?utf-8?B?Ui9HVm9MZndaNVBhcjQwSVRJakIzbVFJeXlwMTZrbnlneXVFWDVmVzdyQ05B?=
 =?utf-8?B?UEVZY2JoandZUTZtdnBlOEJpZjQvNFdrU24rc1pzRDl2M0tzNUxtY0l1MHI5?=
 =?utf-8?Q?wR6wXbEynaSr+wB9sR8ymekaM?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f52ecd-70f1-40e3-b5fa-08de1e5c8cc5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 00:19:58.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2i57LtoX55vkfUrD5jrJ4s+IhZG8cmOpKuvqd6hczMFUkObagPinI418e+i1S0tSaVyPMYfW9P4GkuZ6j4ZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2990

On Fri, Nov 07, 2025 at 05:08:03PM -0600, Moger, Babu wrote:
> No, I don’t agree with introducing this new interface.
> 
> These settings are intended to be modified only by system administrators,
> not general users.
> 
> Administrators are already expected to have complete knowledge of the
> hardware and corresponding configuration details. They also typically rely
> on benchmark data to determine appropriate settings.
> 
> Additionally, this approach is not consistent with our existing CBM setting
> model.

Hi Babu,

I fully appreciate your point that system administrators are expected to
have complete knowledge of the hardware configuration. I believe my initial
motivation may have been unclear, so let me clarify the intention behind
"io_alloc_min_cbm_all".

The intention of this new interface is not to hide lower-level details from
the administrator, but rather to simplify a specific, high-overhead
administration task and prevent human error, which I encountered during
testing of your series.



By default, it is my understanding that when I/O allocation CBM is enabled,
all applicable shared L3 resources typically have their CBM bits set (e.g.,
ffff). If an administrator wishes to revert to a clean baseline before
applying a subset of dedicated bits, the manual process requires them to
not only have knowledge of every single Domain ID
applicable to the shared L3 resource but manually construct a long,
error-prone input string.

The objective of "io_alloc_min_cbm_all" is to provide a quick and accurate
medium to revert this topology-dependent default configuration to the
minimal supported state, thereby avoiding possible miscalculation or
omission of a Domain ID in the CBM string. As shown in the usage flow
below, the new interface drastically reduces the complexity of setting up a
specific configuration:

# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
0=ffff;2=ffff;4=ffff;6=ffff;8=ffff;10=ffff;12=ffff;14=ffff;16=ffff;18=ffff;20=ffff;22=ffff;24=ffff;26=ffff;28=ffff;30=ffff;32=ffff;34=ffff;36=ffff;38=ffff;40=ffff;42=ffff;44=ffff;46=ffff;48=ffff;50=ffff;52=ffff

# echo 0=0;2=0;4=0;6=4;8=4;10=0;12=0;14=0;16=ffff;18=ffff;20=0;22=0;24=0;26=0;28=0;30=0;32=0;34=4;36=0;38=0;40=0;42=0;44=0;46=0;48=0;50=0;52=0 > /sys/fs/resctrl/info/L3/io_alloc_cbm

# After (using the new interface):
# Administrator uses the new interface to clear all domains automatically:
echo 0 > /sys/fs/resctrl/info/L3/io_alloc_min_cbm_all

# Then applies only the specific, custom masks needed:
echo 6=4;8=4;16=ffff;18=ffff;34=4 > /sys/fs/resctrl/info/L3/io_alloc_cbm



In essence, the new file automates the clearing phase across the entire
topology, allowing the administrator to immediately proceed to the
customization phase with a much shorter, focused command.

I believe the efficiency and guaranteed correctness for this specific use
case justifies the addition. Please let me know if this clarifies the
motivation and if you have an alternative suggestion for achieving this
guaranteed full-topology reset.

If, after considering this clarification, you still feel this approach
should not be merged, I will certainly defer to your judgment and withdraw
the patch.



Kind regards,
-- 
Aaron Tomlin

