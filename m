Return-Path: <linux-kernel+bounces-853333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF9BDB510
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D51E4E5982
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62809306B20;
	Tue, 14 Oct 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="I9qbdOa5"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022140.outbound.protection.outlook.com [52.101.43.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB927F736
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475004; cv=fail; b=mvg9kfEMtazpBVKiwqp3XJz8p2/bRwWT+KgfHrl1Ssa0YA22xgsBZveJvVyCcmRRhkrHriEmN0y91LsTwFnnQn4tP3ZONhqbUGr1t1EiwaXaNt2UJDmoYRhoQFKVxjp1tL+b8FCf4/wSkOATafSqzN0duuBtLdu9A6C3+af63mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475004; c=relaxed/simple;
	bh=FJSiEDfohpWKApSeY45+7X7DDgdQLgRF1IwZD3pkfpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+3Frljr5K74i5RBcznFkHsLzEldtwAZ9F4kPdiSAzN5FXovNiJTWT3Atne2657ykLMys06pqRYEEWGd2c+QNRZESgRJx7od7FJyF4Cza5TeVwLtGCBcixukclpchnNZptcLiYtnF3oSU7Toheg4VRDUiAaGkUGb1+sDIwTYMtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=I9qbdOa5; arc=fail smtp.client-ip=52.101.43.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEz6KFN4YevtIuMarHlPxOCBuRl70q6UxZaqRC4+Zggw1BJvnDRlDOCObB/pPCiApc/rrC2AVX6y3DU1hiu7jd2bZ0nTCkXqV4W098ckB2B+CMZMbXftEIQjG3/siiRyTPLExJ6yRYz/dBnW5+th9/S5cRWuboVAMKdteur/CWCsErgtO0pvCMWTaTZbK/C3ujQ38PC/xWEbz7dxjrDyGFRGq81S5TjYXuc5NDIdb66CV5OKOTYZ7JWFFvEDelAdL37TPh/kt6Bj7OHyBkZ+aTESDZTGAHDWVmEyzRtIIp0WGbt0NOgWoTvXmUkCZuDZz6L63tYCawspzPIkpCahpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7piVXFHhf/IfGNiteKtDAp5QT4FJmKMvvwHnYRSDd2w=;
 b=uH+M0O5+RSlv29o8owJQ2K+YnwG+ACpO+OpOUNBfk2GubFLUQE1g1GPboDVk4+QELCo7zAjh42F1JoiJIRPnabuyd1kn+wHLZ3w+fNj+UahiJH1wxLwUXHMVN7GzMhSe3TJwwAyCa73mvX7waxnoBNYSfe5LU/xud2q8ooKhXd/VLI9eUMJtAmfJcVAECzGJOemzTX2N8gIMyrPw0y06KQLaykxfKY4xFgvrO+ioN8Wc8q3lf7yWe3v7KbRg88mYCDabS0Yiu3njwgXox0YNDkiIBrNtePw45YF5dmdR+wEawyvSYIAEWFMjMGNkNmuKfv1GgPVz8JTGjeM+OR/dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7piVXFHhf/IfGNiteKtDAp5QT4FJmKMvvwHnYRSDd2w=;
 b=I9qbdOa5O1alcqBx9+R4RIa2QhR8A3vrdg0eBBBM2mSdnTFf1Z3I8COteMYBlhkaZvXoafx4MCSrLElSJVLdIimKbkVe7P/haUuf7LD7lh8qLF42DDK5Zr08YlLjSuS1vvB4quoT/Q26rtZR1E4LP9HJyUW3JGZzevvW9znaMOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6261.prod.exchangelabs.com (2603:10b6:510:8::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Tue, 14 Oct 2025 20:49:58 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 20:49:58 +0000
Message-ID: <1449b3b4-2dc0-4a59-94fe-5a4a6dc69986@os.amperecomputing.com>
Date: Tue, 14 Oct 2025 13:49:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
To: Ryan Roberts <ryan.roberts@arm.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013235118.3072941-1-yang@os.amperecomputing.com>
 <91f6da2f-1968-4c23-a534-20b463463faf@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <91f6da2f-1968-4c23-a534-20b463463faf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR19CA0052.namprd19.prod.outlook.com
 (2603:10b6:930:1a::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e1753e-dafd-4db1-288d-08de0b633c96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTFQUms4NG1IdkdmNnU0Mmw5Vlh0LzcvenVvOGpxekltQnVoRklOSDdWVFpB?=
 =?utf-8?B?S2sybEdnblpWRnQwekFjSytSam9TZCt3dlhNZTNtV3NlMTB5RkVDSlFld0Z6?=
 =?utf-8?B?OVZxZ3BYMm1vdUlGZVJVdmx5Wld4a1VrcGxhVWRMeHRQK1JsQ3dCSmwvZXBk?=
 =?utf-8?B?V2ZiNzJvQ0gxYTFxemRlelZ1dDJMV1c4T3kxeGtKbDh3cy9DdDh5VlZSQnFy?=
 =?utf-8?B?WjJXWWt3eVV3VnVub1Jad0xWU0c3cGlxZWU0d25XMzVpQVAyc2pURkVUWHYz?=
 =?utf-8?B?Z01WTnBqY0FkQ2pNLzNXcVFLUUZGRHJvNjU3ZEdSU3dmNVR5Q0NOdE51SGRk?=
 =?utf-8?B?UkRFWVVHNUsraGhYa3JPZkk5bXJQU3ZHQnNJYjBQRlRIVnQwMXQwd1M2U0tF?=
 =?utf-8?B?YnF0amdTNHhlYTBSODJXaGd1cEtoeDNHdGQrRlo0S0t0NTdmY1hQN0ptVDZS?=
 =?utf-8?B?RGVLb3pmVUJEdkRqQ096eFh1K0FScCtnd1BSQldnYjY2N1BuMWRVRkpZNFcz?=
 =?utf-8?B?bVBSRExhZGZ5VUlYcUJ2WmtLQUpTUmNiMVYySDV3Nm5EZWZKNVc3NzV5NERh?=
 =?utf-8?B?ZXNrRDg5OW1DUW0ySGpRQTBxYzJYRHhLVVlPZ3N6cDJZQ0hmZmZDcjNaN1Vt?=
 =?utf-8?B?Ulp2WWV6WjdwckJmdC82S3J2MlBIeFB0c3g1VUE4cHk5WE1XcWxycHJjOUhv?=
 =?utf-8?B?eEFHTHRIajREVlB5aGd1WXlUak1HVDNjbWJJZ2NpaHk5Qitlbmg3cmRlWEgy?=
 =?utf-8?B?WGpmZ09zK1hQbGRmektGOTBSN1RMU1FpMHFwUy9XK2NIdzNycFNBVkRMQSt2?=
 =?utf-8?B?bkxncGFaTmZTYVdhUzZ5UVhFR01WNklwOTJGbUI3OHhFYkdwcmpSSDRkcFF6?=
 =?utf-8?B?OW1NbUVlWitZVi9LV1cxY2ZOU3RIdU1PRzFKNCtueHlMaXNhR0JUQ1lldDlX?=
 =?utf-8?B?bWlrNGpFUzJVSDQwZnNZSkJVNUxKUzNPKzhjekozZmh5bHFXTCtsUkt4eERu?=
 =?utf-8?B?bEdpa2IvTW5TcjArdzRhOVVsWkZiMFlyMFljWFo5bW1iVWJvR1VmNGdQZ0FK?=
 =?utf-8?B?QzZaN0hYS3JNcjUrNHlraFcwN09rcC95dndRMm9pT3RCeUhMUjhhVzljcjJ2?=
 =?utf-8?B?aTdRZExKTnphMUtwVVhNU1ZZQ2JyZnd3UWpjUTg1OXVWaUFJak9sRFNWWTlG?=
 =?utf-8?B?TEFkWkZzYVorUHZjTDBKcXJWZjF1S3VhMktLaUVxaTdGU1ZvMmZZeVZ3cWxJ?=
 =?utf-8?B?UTVaSFV4eHVjSHZnbnYyK3p4UnhLT1FvY245MEY1K2dKa09adk5NYVZ0blBq?=
 =?utf-8?B?QTdTNWFPWmJ2a2lFbzJzRXU5c0x0OFVMNW9YdFh5QU5jaElwcE9pTnd1aDNs?=
 =?utf-8?B?bzZnTXdKYWVmQmlNbWFobVo2RGVka1A2eWwwTFRDNEgzNG4rMFIydjZraGdX?=
 =?utf-8?B?QlNGRXFVZUE2Y3V3OGZIc1VGa1FEN0JqZFkvMkxvTUUyeHNBMjNSZm9OWnN5?=
 =?utf-8?B?RkVPQTQ3UWRZZzdhUkMxaHM2T1k1RHo4RCsxNkQ4WG5VdnpDOHN1THJMeU1t?=
 =?utf-8?B?TGRqTzNVMkxZNkQzZWRpS25rY0xqbEN0alkwYW1ydW9URExGd2I2UXBHNGt4?=
 =?utf-8?B?OWUreDZMMzRnN042S2tQd0t4b0EzVWxvQ2tkVUduVXppdW92VWVmRGhUazRs?=
 =?utf-8?B?cHIvT2hkbVZqNUVrV2xDaU5qVjQ5MXNBSGozeFlXeFN6KzZIeDhvamJ6ZlNu?=
 =?utf-8?B?VDV6MXdmRDN1RmkxMStqd1o2bzBRSVZXeEhGYXo1WHFzRFlFVGxSQkdIQ2dh?=
 =?utf-8?B?cEtXYVBMRzhOVW0xb2lsVTE5L2pQaTQ0LzdCQndkZFdQQjdkRnpjazBlbUQ1?=
 =?utf-8?B?MThNRDRTa0pmZENWSUkwL0hIMWF2V1FzR3V0V1NqR05ya0tWWHU1YWVMejlY?=
 =?utf-8?Q?IfC7u8bcHDmL+3FtPzYWuV3Ne+nvEWBj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5xWHZKQ1NZMmNZT0FvRTFWZFNDNU82Tm16UW9WTDJJekt6VUJrUU9Mclpn?=
 =?utf-8?B?U3d5eXBQMlZ4a0RkMGpnaFZHVzFaTHEwUVBTM081U2htSjdDbW1TWjl1cjZL?=
 =?utf-8?B?R1NCMWg2TkIyOFVsNFVyd1RtSlZiRDBKZ1JuZjhob3MzT1lLS0kwYkI0SEE0?=
 =?utf-8?B?YVhibjB2Z3hPYW45ZkYyS1FSSHBtbW9IcjRrMXhhRVJsLzRSaGwzUUMxdXAr?=
 =?utf-8?B?d2Fkbko0aVRYTUdHWFg4b2JVL0l3NXcyOURmZS9FakxjaFVIamFHQ0VOK1lj?=
 =?utf-8?B?UHY4RElYOHEzMUhId1BMZkVtbWVtMjU5Zm45aCs5eGE4a0FSNXJUV3k2SUtD?=
 =?utf-8?B?OFZnYVIrdmVYbGttNWM4NS84eEdrUDBQWHBlaGxTKzBsRGI2VVU5N2VKL1NK?=
 =?utf-8?B?R3d0WExncWY4bnVMamNnWDczSDlNLzVYc2RBOFNURVkrTXZCL3ZSbzdPUUZp?=
 =?utf-8?B?eDY0Qitva0NseENCWGZaL01aWDYrMTg2aVd5dUVhVDRvelM2YzZaMkJOMXFC?=
 =?utf-8?B?d3NKa3A3bHlnRnNZc1Q1eU16aE1rQkRmeDhwcEVGN2VDQi9LY0dWdjE4NHhi?=
 =?utf-8?B?QTlsZWhURVlwaStLMWZmK1g5cFhkaUFNOEkvYXR3MUR3Q21URHRoa1hZZGFE?=
 =?utf-8?B?azhKcHREU2ZxazlCQXhZeVYrTW5UbjhuL2pCUnpkaGcwdWtZQ0ZwSVBxMkVw?=
 =?utf-8?B?V2lwcWdtL2ZWM0h3ZjVkZEc1cSt1NG5IOUY5OTFCZ3J0S1NmRzNpS0Z5d2V3?=
 =?utf-8?B?aXRMV3Q2UlMydHpDVUt2aUMwL2ZlNjYxY0ZZQ2psZkYySUN5TjF4RndEODFM?=
 =?utf-8?B?UHRycjlJVWtpckNaTng2d1pVZFQ5Z2o2ZUxMNW54RCtUQzRzV1hacTh0WVN0?=
 =?utf-8?B?K3FpanN5TWc2amlpOTd4cEhIUE1ISjR3cEYvaFdhQ1VBSW16L2VFT2lVbEZw?=
 =?utf-8?B?T0QrRDRPYjhZL2g1QW44amswN3JxRVAvdjdIY2pGTXVTY2loeXRkM01kdVZa?=
 =?utf-8?B?ZFZJeExyYXRWRnNFdFVhcG4yN2ZTS1Y5bmVWcC9PZTk4YmZqRU5vMFpaNXBy?=
 =?utf-8?B?MUlqSXJJbkxFcmU0YXV1S2d1SmxtRFJBcjlFb0pHRjh6R09sUlBnbkdzVzdV?=
 =?utf-8?B?eW1Qekl5a3BvODB6VFdUcjVFQTV2NWJEYnZTeEpmQzVoT2xqdjFJQ1FRcVJB?=
 =?utf-8?B?eVlmRzVtT29LeENYb3BnMmxVc21WaU9xYndqdVJNMmxZSTVtU0oyaDk2eU9L?=
 =?utf-8?B?VENGdmZEVTJuMW4xSDZXOWRxNFI2Z2FjYlFmM3l6ZDVITWM4UmlFUlBwODg2?=
 =?utf-8?B?S1VGZU00Ui8raXA2N1VEL1pBN2IycjFNZU4xaUhoVlNkNWdJQlBUWGg3RGpj?=
 =?utf-8?B?VXhDU1BzN2RNOWQzQTgrVms4dkEyS0M1TnFEWUxKOUt4Vk1UYm5NTmE1eEUr?=
 =?utf-8?B?VDlyS3ZoOXo0bldpK0tGNXpLKzAyWGc3d0krbjluV2REa2lsWlZZaHJ6M25p?=
 =?utf-8?B?VmFwMWp3V0NnSmt2N2dNb2t3OXBGZDVBK2dvUEt4OWVCUktPREdybS9OSC9L?=
 =?utf-8?B?emFkN0piVXIrdEdpOXlrSGFxbVBINXgrMzk3T0Mwd3NDOXNOU1dmUXJNdkRN?=
 =?utf-8?B?OHJSa1ZaRXFsVk1PTm4xM1hTRlAwcC9FWURieG94aXFSZUx1LzRTdStVVVVE?=
 =?utf-8?B?ZERraXlBQjlrN1hLVmZFTlh1L2dLQ2VGK0kzSHNCd0JHYWNNWm45RGZvVTNj?=
 =?utf-8?B?UnZPMWFFYXUrbUI4QzlQSi84Z3hzK3Q3eVdGb0xtU3NwNzZITHk3NEUwYU4w?=
 =?utf-8?B?TVlXVS9mSjBvUjR1TkpUVjJUVEZRZDM5R2VoNVpMdU1BMmFRVzh2RkpIbVhY?=
 =?utf-8?B?SHhKSGtCZGZlaGZhWG9KTml1WnR4VlNlKzRwejJUZXJ6RWs4Qlppb29ibjhG?=
 =?utf-8?B?NkVmUVh3UFVRQkxZSmVjT3NDc3FXRk5YeUtHZjVONjFDdjFaTk01YVVCU2NN?=
 =?utf-8?B?TVJ4UitZVW1KR1BlYzZOTi9zWXZzck9YTUQ0citRRUVYUXJnM0tyMm1obGY3?=
 =?utf-8?B?QkNYZUxRNWMvY0VsU095TU5VbEN6RUNFZWl5WjhYWCtZUFBFb3AxNlEra0M1?=
 =?utf-8?B?UGFBRDE3SzlUdmE4OWgxcW1mQzBjbEJObmZRNjVYODhTT2psbmtvbXlVVEsv?=
 =?utf-8?Q?hZGJ3JqQqyM5mWxyzp3jd6U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e1753e-dafd-4db1-288d-08de0b633c96
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:49:58.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxTrOAtbajvkPO3TXbdqnFlPC8+QVCEmUHe5sEN05j3p6FFVxZWi4ZU+Q+xDaKBXrOUiPlo1+tTzF3nAiAuK375+nKZnZQKNZjGTI2jYZEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6261



On 10/14/25 1:43 AM, Ryan Roberts wrote:
> On 14/10/2025 00:51, Yang Shi wrote:
>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>> rodata=full"), the direct mapping may be split on some machines instead
>> keeping static since boot. It makes more sense to show the direct mapping
>> use in /proc/meminfo than before.
> It's possible to divine this information from
> /sys/kernel/debug/kernel_page_tables. Dev even has a script to post-process that
> to provide summary stats on how much memory is mapped by each block size.
>
> Admittedly, this file is in debugfs and is not usually enabled for production
> builds, but Dev's patch Commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
> ptdump"), merged for v6.18-rc1 gives us a path to enabling by default I think?

First of all, it is in debugfs, not all distros actually enable debugfs. 
IIRC, Android has debugfs disabled.

Secondly, dumping kernel page table is quite time consuming and costly. 
If the users just want know the direct mapping use, it sounds too 
overkilling.

>
> But I can see the benefits of having this easily available, and I notice that
> other arches are already doing this. So I guess it makes sense to be consistent.

Yeah, some other architectures show this too.

>
>> This patch will make /proc/meminfo show the direct mapping use like the
>> below (4K base page size):
>> DirectMap4K:	   94792 kB
>> DirectMap64K:	  134208 kB
>> DirectMap2M:	 1173504 kB
>> DirectMap32M:	 5636096 kB
>> DirectMap1G:	529530880 kB
> nit: x86, s390 and powerpc use a lower case "k" for DirectMap4k; perhaps we
> should follow suit? (despite being ugly). Although I think that's usually used
> to denote base-10 (i.e. 1000 bytes)? That's not the case here, we want base-2.

We should follow the lower case "k" so that the script used on them can 
work on arm64 too.

Do you mean kB should be base-2?

>
>> Although just the machines which support BBML2_NOABORT can split the
>> direct mapping, show it on all machines regardless of BBML2_NOABORT so
>> that the users have consistent view in order to avoid confusion.
>>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/mmu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 91 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b8d37eb037fc..e5da0f521e58 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/mm_inline.h>
>>   #include <linux/pagewalk.h>
>>   #include <linux/stop_machine.h>
>> +#include <linux/proc_fs.h>
>>   
>>   #include <asm/barrier.h>
>>   #include <asm/cputype.h>
>> @@ -51,6 +52,17 @@
>>   
>>   DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>>   
>> +enum direct_map_type {
>> +	PTE,
>> +	CONT_PTE,
>> +	PMD,
>> +	CONT_PMD,
>> +	PUD,
>> +	NR_DIRECT_MAP_TYPE,
>> +};
>> +
>> +unsigned long direct_map_cnt[NR_DIRECT_MAP_TYPE];
> I wonder if it would be cleaner to store this in bytes rather than blocks? Then
> in the code you can just add PAGE_SIZE, CONT_PTE_SIZE, PMD_SIZE, etc as
> appropriate, then the reporting function becomes simpler; everything is just
> shifted by 10 to get kB; no need for the shift array.

Yeah, good idea.

>
>> +
>>   u64 kimage_voffset __ro_after_init;
>>   EXPORT_SYMBOL(kimage_voffset);
>>   
>> @@ -171,6 +183,60 @@ static void init_clear_pgtable(void *table)
>>   	dsb(ishst);
>>   }
>>   
>> +void arch_report_meminfo(struct seq_file *m)
>> +{
>> +	char *size[NR_DIRECT_MAP_TYPE];
>> +	unsigned int shift[NR_DIRECT_MAP_TYPE];
>> +
>> +#if defined(CONFIG_ARM64_4K_PAGES)
>> +	size[PTE] = "4K";
>> +	size[CONT_PTE] = "64K";
>> +	size[PMD] = "2M";
>> +	size[CONT_PMD] = "32M";
>> +	size[PUD] = "1G";
>> +
>> +	shift[PTE] = 2;
>> +	shift[CONT_PTE] = 6;
>> +	shift[PMD] = 11;
>> +	shift[CONT_PMD] = 15;
>> +	shift[PUD] = 20;
>> +#elif defined(CONFIG_ARM64_16K_PAGES)
>> +	size[PTE] = "16K";
>> +	size[CONT_PTE] = "2M";
>> +	size[PMD] = "32M";
>> +	size[CONT_PMD] = "1G";
>> +
>> +	shift[PTE] = 4;
>> +	shift[CONT_PTE] = 11;
>> +	shift[PMD] = 15;
>> +	shift[CONT_PMD] = 20;
>> +#elif defined(CONFIG_ARM64_64K_PAGES)
>> +	size[PTE] = "64K";
>> +	size[CONT_PTE] = "2M";
>> +	size[PMD] = "512M";
>> +	size[CONT_PMD] = "16G";
>> +
>> +	shift[PTE] = 6;
>> +	shift[CONT_PTE] = 11;
>> +	shift[PMD] = 19;
>> +	shift[CONT_PMD] = 24;
>> +#endif
> The ifdeffery is quite ugly. I think we can get rid of the shift array as per
> above. I was hoping there might be a kernel function that we could pass
> PAGE_SIZE, PMD_SIZE, etc to and it would give us an appropriate string but I
> can't find anything. I guess keping the ifdef for size[] is the most pragmatic.

Yes, I agree this is the most pragmatic way.

>
>> +
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PTE], direct_map_cnt[PTE] << shift[PTE]);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[CONT_PTE],
>> +			direct_map_cnt[CONT_PTE] << shift[CONT_PTE]);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PMD], direct_map_cnt[PMD] << shift[PMD]);
>> +	seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[CONT_PMD],
>> +			direct_map_cnt[CONT_PMD] << shift[CONT_PMD]);
>> +	if (pud_sect_supported())
>> +		seq_printf(m, "DirectMap%s:	%8lu kB\n",
>> +			size[PUD], direct_map_cnt[PUD] << shift[PUD]);
>> +}
>> +
>>   static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   		     phys_addr_t phys, pgprot_t prot)
>>   {
>> @@ -183,6 +249,9 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>   		 */
>>   		__set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>>   
>> +		if (!(pgprot_val(prot) & PTE_CONT))
>> +			direct_map_cnt[PTE]++;
> If adding size in bytes, you could just always add PAGE_SIZE here, but select
> the bucket based on PTE_CONT?

You mean:

if (pgprot_val(prot) & PTE_CONT)
     direct_map_cnt[PTE_CONT] += PAGE_SIZE;
else
     direct_map_cnt[PTE] += PAGE_SIZE;

I don't think this is efficient for PTE_CONT, because I can just do 
"direct_map_cnt[PTE_CONT] += CONT_PTE_SIZE" once in 
alloc_init_cont_pte() instead of adding PAGE_SIZE CONT_PTES times, right?

This applies to the below comments for PMD/CONT_PMD too.

Thanks,
Yang

>
>> +
>>   		/*
>>   		 * After the PTE entry has been populated once, we
>>   		 * only allow updates to the permission attributes.
>> @@ -229,8 +298,10 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>   
>>   		/* use a contiguous mapping if the range is suitably aligned */
>>   		if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>> -		    (flags & NO_CONT_MAPPINGS) == 0)
>> +		    (flags & NO_CONT_MAPPINGS) == 0) {
>>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +			direct_map_cnt[CONT_PTE]++;
> Then you don't need this.
>
>> +		}
>>   
>>   		init_pte(ptep, addr, next, phys, __prot);
>>   
>> @@ -262,6 +333,9 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>   			pmd_set_huge(pmdp, phys, prot);
>>   
>> +			if (!(pgprot_val(prot) & PTE_CONT))
>> +				direct_map_cnt[PMD]++;
> Same here...
>
>> +
>>   			/*
>>   			 * After the PMD entry has been populated once, we
>>   			 * only allow updates to the permission attributes.
>> @@ -317,8 +391,10 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>   
>>   		/* use a contiguous mapping if the range is suitably aligned */
>>   		if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
>> -		    (flags & NO_CONT_MAPPINGS) == 0)
>> +		    (flags & NO_CONT_MAPPINGS) == 0) {
>>   			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>> +			direct_map_cnt[CONT_PMD]++;
> Then this can go too.
>
>> +		}
>>   
>>   		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>>   
>> @@ -368,6 +444,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>>   		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>>   			pud_set_huge(pudp, phys, prot);
>>   
>> +			direct_map_cnt[PUD]++;
>>   			/*
>>   			 * After the PUD entry has been populated once, we
>>   			 * only allow updates to the permission attributes.
>> @@ -532,9 +609,13 @@ static void split_contpte(pte_t *ptep)
>>   {
>>   	int i;
>>   
>> +	direct_map_cnt[CONT_PTE]--;
>> +
>>   	ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>>   	for (i = 0; i < CONT_PTES; i++, ptep++)
>>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>> +
>> +	direct_map_cnt[PTE] += CONT_PTES;
>>   }
>>   
>>   static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>> @@ -559,8 +640,10 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>   	if (to_cont)
>>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> +	direct_map_cnt[PMD]--;
>>   	for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>>   		__set_pte(ptep, pfn_pte(pfn, prot));
>> +	direct_map_cnt[CONT_PTE] += PTRS_PER_PTE / CONT_PTES;
>>   
>>   	/*
>>   	 * Ensure the pte entries are visible to the table walker by the time
>> @@ -576,9 +659,13 @@ static void split_contpmd(pmd_t *pmdp)
>>   {
>>   	int i;
>>   
>> +	direct_map_cnt[CONT_PMD]--;
>> +
>>   	pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>>   	for (i = 0; i < CONT_PMDS; i++, pmdp++)
>>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>> +
>> +	direct_map_cnt[PMD] += CONT_PMDS;
>>   }
>>   
>>   static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>> @@ -604,8 +691,10 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>   	if (to_cont)
>>   		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>   
>> +	direct_map_cnt[PUD]--;
>>   	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>>   		set_pmd(pmdp, pfn_pmd(pfn, prot));
>> +	direct_map_cnt[CONT_PMD] += PTRS_PER_PMD/CONT_PMDS;
>>   
>>   	/*
>>   	 * Ensure the pmd entries are visible to the table walker by the time


