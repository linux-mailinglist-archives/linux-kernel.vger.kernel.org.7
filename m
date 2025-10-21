Return-Path: <linux-kernel+bounces-863270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6530BF771D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6B7487D15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88D340279;
	Tue, 21 Oct 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="vMUTENn3";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="oQA4Ynu2"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E933336EE5;
	Tue, 21 Oct 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061255; cv=fail; b=dBHCJwordfX4igeOiOcQQQPDNHdwTJ1zOZs8et+YEcTr6T9WbRtoGZ2SiWZwAsgBWh52vDkTx43NNfxILunxCeCfNDcV+Q+sp3+eGBOU/KnotCPS3UZyub5m44cyRlTdcFjbdcNahxL9fD7E+7nBHOCxM2gxKSk5N8zK1iTDozA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061255; c=relaxed/simple;
	bh=PdtEdXd0j2/BUsBljN3wurOO5Gjmj3esLTXp8hwsUbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ausptzbe8SPmL64IUCDn68awMfxnlvjfo7VbCJ2lX5BkxhuqsH/NeExVbqLMb1IBBeZ5Yl1g5nJOouoWDsOXRYjsmTiEMkkgzPc8bJBqLgTKHT+IY7jutP88n/fCNy/SN1fjKQGjxjgzXvXlLcBwZha/DeqX3DxcqD7p6TL/mjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=vMUTENn3; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=oQA4Ynu2; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LEqq0J1324130;
	Tue, 21 Oct 2025 08:40:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=PdtEdXd0j2/BUsBljN3wurOO5Gjmj3esLTXp8hwsU
	bY=; b=vMUTENn3faam73waOZzy7Uu44b9UM2wF1wzUBLOJ89QcQu5vvR/pwJpxP
	0/Kg3A5ht/areCvtdfRJVisQuu0KwRbK7vKbLgEuCBgTCFwcLxq+xHNZNNsbSyjU
	5f1pdFV/igEfWJdB20MChEfnDJW2F7nSDa+a9RjDmP8oQ13ROuQSyUqqw3E0st2k
	SKGUcw6KFLWj9f+KqF7Q9PWnhdMmcMuL6SyIKzMTVKhy+rROYwykz9g+1eXdTFJv
	MD9n+mA51Y1P3Y/Y5lsFLmt5Hq1RwaxGM5rWCuY5Msu0sgO28rHMbMiDZNTLbWdF
	NHqcuhYynUGLoTC3tBULKtbaP+YAQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022075.outbound.protection.outlook.com [52.101.43.75])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49v77s5xt9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ2Jo/g5vjjy6SqZ3E2p7rsPsXcnCu3Am42/vztkXzieWzReqHNDn7kJWDgDZg9wSUtH1wH7CzM1L/ezbbT9HqvIR6xjvneoRBP/D0KAZHBIwTxNh3A1lfVAFHGTOdKr5fEv92KjpTT2XuGsegGXnUvoIB7VsFroLUbShHMGh6B5llImFITXTfPYgcpQFbsrCQ0ozDdYi0gcePVbovRDEtM0k1tnAKG7fumiBz/Gj366Zmo29QQ9KtMNWfq2UCPCOMPSe0yuGSnMoVsK8ecrDFuEozABdNtYmNamOEhtJdx0vP5ioLqdH/4Y3c7LogB7OsVLaKtyMagWwLnIYTBlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdtEdXd0j2/BUsBljN3wurOO5Gjmj3esLTXp8hwsUbY=;
 b=BWHkSgcwrVn7JnV0NsPMWkmsVvhpNWUArQDCf/jm0Erj8YivnuQMkn+BCsnAC/fkU0gEPUzcWrs2iyYXXqHnRwL+GpQxeDbeH+HsxxTTRReEXnj/9Ft/D3yEQGahQkfPg/0uohOG/RNm22Z5EhWHqPbDPg/aEHGPjiUbqwoG6TTFeszW7mOa7dwOULbeeo3i5RqKyiXEkVoWUr54FCdIC9e1GIsYbY+nTKJDgIm7YNmI+fLlt1qUljlnmBAv7N6xxpq3Qt2BGdNhYdnQYg1oWmVrOJy+qRlcd4oEkJp94PrDXsZ+l0fj1Cx5Nx98nmKO5BWmNlXw3g81mOOSewg4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdtEdXd0j2/BUsBljN3wurOO5Gjmj3esLTXp8hwsUbY=;
 b=oQA4Ynu2+J/A7kuqGXo3Xt4cUG/9kgudKKPfLaP1HkbabK6bz9nLDTG4wysIsoZNI6SJNiXiKGo3mim4BVWi6qcQ2r7LUz8YWyzUOIa/uepuWn30flsMv3nuyyUHYIUDoGHqYAlY9O6XsvRuWa2kHQ6gLtA1C006fcIlv2fb3cdUD/R2CH+v90DPnACRgZpYFuqhacLOJBtVbocm1smlrDl11hpySPmdw9QVBs1LMHUZ+VDndiTua3tNvARPlD5jgv8Yf3p8Wp9I/WLbL4GhY6Qe83J9vCXWhLY9ARsgcMZMhwdstD/f1NFU0bL6SvdDKsqvUqPU2x6iNoVBb+6oYg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by BL3PR02MB8130.namprd02.prod.outlook.com
 (2603:10b6:208:35d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 15:40:25 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 15:40:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Brian Gerst <brgerst@gmail.com>,
        Brendan Jackman
	<jackmanb@google.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Alexandre
 Chartre <alexandre.chartre@oracle.com>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Topic: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Thread-Index:
 AQHcPv2ViIPRgARTk0+c7Boi5TEVVrTLdggAgAACrgCAAAzWAIAAGO+AgAAJB4CAAPrcgIAABhCAgAAKfACAAAv3AIAABR6A
Date: Tue, 21 Oct 2025 15:40:24 +0000
Message-ID: <F7C33A1C-2E4C-4B32-989F-CB9303D8A6BB@nutanix.com>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
 <20251020204026.a7xuhnagsqo4otpx@desk>
 <225134fd-033f-4d63-b88c-772179054694@intel.com>
 <20251020224159.xkhfs3phai5o6rzb@desk>
 <1D952EBC-CA16-49FE-8AD0-48BCE038332B@nutanix.com>
 <73a22a19-c492-4a75-8352-a4cfac47d812@intel.com>
 <883EDC14-1A26-46F4-B9E9-C75A6DF07195@nutanix.com>
 <67cdba64-d1e7-4f18-b790-4ecd2c573bb0@intel.com>
In-Reply-To: <67cdba64-d1e7-4f18-b790-4ecd2c573bb0@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|BL3PR02MB8130:EE_
x-ms-office365-filtering-correlation-id: 079a461d-b1e1-4475-1e63-08de10b826fa
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWNmWSsvdmx5WlNJdGhHaENTdXRQblYrbXdNWmFBY1ZxclJXRmVyYnZvalpo?=
 =?utf-8?B?MWVYQXkrODJXV3hTSlZTQ05xSTc2TjdtSVptRERaOFpUdTd1RXQzZU1tazRh?=
 =?utf-8?B?QnhwZUhZMERqbzBmVTlGMzhGdG1ydnNXY09GUXo3YVNzdklLOUVlc2RzOXRt?=
 =?utf-8?B?VEtiMy9wU2IvU2ZiYWJ0MkhGL1A0TncwZmNMTW9NeW1yaGlOek83djYwZVdQ?=
 =?utf-8?B?cWNxamZoSStxd05veWFsWnE5WEZTNlpUdXk1TFN5S0U2RUs2MURsQXp6OTAx?=
 =?utf-8?B?NlV6bWVEOHloSms2bjI1VThyR3piazZtVzMvdCtNaEU3Snptck9iOVIrZEJC?=
 =?utf-8?B?c016WVl0eWtha1ZrYjk0YzAvWVBQZzgwZmorbDdKSUF4TkFpM0UwenI2dUZx?=
 =?utf-8?B?dmxOeUlQNjk1MFNTbGpSQ2ZYN3dycDlvdEdITXBVeDNJbncrUVFtTGx6aXpN?=
 =?utf-8?B?c3lQWkR6NmpBM0pZdmFCbGx4TFdCdk10dm9hdVNHVTU5aDJQN1hraE5MazVG?=
 =?utf-8?B?WCthOFIwM1JlWVlueVdxRjlrOXBiZjBKdkwySFFWWVJnMWh2SlZqMFJ3cnJy?=
 =?utf-8?B?eEpYRkhFSGRwNDZBRjdxVHlnSFFJcjczKzFVN2IxaVdSTGFMNkt0a21JMEt1?=
 =?utf-8?B?VjlKWlpzL2ozamNKbXZCY1dqWWJ1VytGR2RoU0NUbTRJazhxVk5aVmhHMGlt?=
 =?utf-8?B?UWVBMTBORGF1bDREN056aWJlVVlBVE9oTDJWeXN5ak9mMUNPd0hpVHhRUDRo?=
 =?utf-8?B?TFg5Wk9MdkdPZVdKdGhRaDRQUmVlN0k3UnhhSXRSZ0xDRkd2OU5maGNZTklV?=
 =?utf-8?B?RTArelNCbEI4dTYxMXIzVHlkVUR0OHo5WG9hVmh0aDFqZDdkTnBmdFlLa1Nl?=
 =?utf-8?B?WGM1dzFueWo5ZVg2TmhOMStCMFhQMTJqc2N1Qnd0VGh1WDlpcExTbmhLQkF0?=
 =?utf-8?B?VTBKUEEyeERqT3pDK0tYSEhpa2VobVFyV3JRM2c3blBBRUxZTWNuU2R3L1hE?=
 =?utf-8?B?VFJjSWpPbDUxVlNlYmFDOUVPNlJCOWVqMDVGdllkNzdiR1ljSEZzZTBMT1Nu?=
 =?utf-8?B?aVJIZHNTeEg1MVB1T1NITjk0VVUzdTYxclE3eDN2UDNpclpvVStkdEoraUtE?=
 =?utf-8?B?NzlLaVVvNlF3d2phS1BHc2xacDAzTFdua2tZSmtIVHpNM0xvRUJOa3diRTBW?=
 =?utf-8?B?V3RGbWJrOW9EdlFBRks1Zmt2KytwWG1yZGtHRERpUU84VlZ4SllwTWJ4amlH?=
 =?utf-8?B?SGpKMld1RTZUVHBTdVJwVk5zU0FUQk5GYkJoREJlUC9TQWJuNnBkMGxkVE1s?=
 =?utf-8?B?Z2g1MnFzRWlHM0tCMlpvV2x4NHNRR1NGQVhrNG5qQ1VqaDM2TnpPMDdEQ0V1?=
 =?utf-8?B?akxRNFpGNmtYa1NzdHdzSmpwOVpyci9LOEhoUWkxL1NSODk5cUFGQjBtSjh6?=
 =?utf-8?B?bXBaYUlRSkdXdmR2YjhzL2M2SytPcmdla2phYlR0dlFOZmJnMkFObmpqbmtY?=
 =?utf-8?B?QWRBSnVqY1UxaCtHTkdQaVhjbEZ1Q2cvVUpBZFJvS01VUUJOTjhVUlZQcWY2?=
 =?utf-8?B?TmlkZStMb2pHcVY5ZnN4c3kySjNFeWFvQUdTeGtPdHUwZGFqZWo0bDhtVHg2?=
 =?utf-8?B?RENVVStFakRkYWVCdHE1eW51UzQ3WkRJNTgrN0d6cHdVR21WWmZyL0VXRkdL?=
 =?utf-8?B?NlQ1RnRnMkcvdDd4bzdMeHdIeVozWFJPUTd3SUlPTWduVFZRMVErRDFWWHJB?=
 =?utf-8?B?Q1Z5Yi9wM1NWcTRIMlQxUjFlZW5JUTVOcmoxRm5BeEdBeTZqUGg3RUNmVW5O?=
 =?utf-8?B?YWNCZDNUSFZoRytxbHdkcGdvSmJ1ZUo5WS9WaWt6MlBHWkFNeEJjVGcrQlA5?=
 =?utf-8?B?bVZyQUhqNTYzdDJ1WTN5VWtwU0drWEJXeUNTdTlQRTN1MXpyekNCcUYyMFJG?=
 =?utf-8?B?aHIwQ2FSeHdhZXVtOS9jcEIxdW5XUEpNb2RhbmJxZ2xJVkhPdnFQeWhZUlg1?=
 =?utf-8?B?ZE9uQ2RiaVNzZkJhUU5FeW12cXlvMDc0N1pWZVNYNVE1MzJyMDdSQ2VGY3FM?=
 =?utf-8?Q?WePiLm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3E1MGhlWnRTaXpJR1JseDVuMjZHMm01MVYzb29kdFlNZTBuTnR3VFE0SEZW?=
 =?utf-8?B?czVLSTVYUzk3ZEVRV1pUSEpUZmdwcnhzSGp0RVN2M2hRUGJRNSt1dXdzSmpD?=
 =?utf-8?B?NWJlMWZQOW5TNktHSmFtSmxKL0kvczY3eWRSM3g2dWFGN2VuNmtkUUpBOGFi?=
 =?utf-8?B?bTNWZTZCRFgvbkxvYmQrdit4NFZJSk83V0Q3dmtLVFJESTJZTWp2RDhXZnR0?=
 =?utf-8?B?UWJQWVdJU1VnbS9NbFVlQ0d1MnNWaEZMbnU1WW9jWGsxNjd5USt2R3BXSGhs?=
 =?utf-8?B?dXRjb2lvTWlZTWoyYzl0aklPcTh0S3hSSHNlQUtJY1RvNlNjbU1wRzFIK0Nl?=
 =?utf-8?B?VnRRdVhYSHNNNWhMT0JKZ3FURWp6ci82enQrbmUycjN3Ukp6aG9rWHdxM2JC?=
 =?utf-8?B?aVlSa2ZNSVh0NXZ3dEZGTXhBb3pqVEt1RldqVUVscWtmdnNyWHdHa0llajNz?=
 =?utf-8?B?blRkbjhpYzlmZkxnbW56TGpHYmVzNVVxUFdXcTNrUGJ3Zm53T3FUSjR6TFAw?=
 =?utf-8?B?V0QvTFIvYlJKR09FUzlITjJCODVrZFpHL1lNOUo0ajJEMWdMMEFMa1YrUll3?=
 =?utf-8?B?QjhocHNaN2RpanhzZHlVRDBVbHdFYnFvVHJoSDZMR3FObXBpb2VLN1VlQ3dq?=
 =?utf-8?B?OHpiMEp4Uy9TUkc1dHdzVVZ5V044UncwK0pnOUM4SGJ0YmdUWFB0SlRHWG5E?=
 =?utf-8?B?VnNVbVFnTmpGdUFzSWVvb3Zua3pHcmRQQ1YxSG4xWFRHenBSK0JabXg4RDNk?=
 =?utf-8?B?eHFBN2ZnUFNLZTBqeUNXN1RCTmlseGlXZ2dzWTJTQ3BRV2FRMXhubGRNbVRS?=
 =?utf-8?B?RE5wMk0zVDEwdHE5bzNpUHpPL1BEZHNXbkEvb0xiZDFndWlENE81T1FjcGl5?=
 =?utf-8?B?bnBDQXN1VkZYMW83TWEyTEFGMTNSVWR3cW8zeVJGLzg1amRpZmFZYnZlMktE?=
 =?utf-8?B?dVdPSURpcnN3TFk3ODJ2WndNaXpLaUZwYVFZM0paKytzZGxkUUh6YU9jK0Rz?=
 =?utf-8?B?OG43anZCUEVMSm9tZnZEZmt6VDhySE5lc3kweFYvMWpJV21SeW95NndGdXIz?=
 =?utf-8?B?aDZBRjZuT25SQzR6eGVQSkpCa2JjSjdUU213WG1YSnVvREJMN290elp5ckJ0?=
 =?utf-8?B?aC9xMUYzQVp0Wm5qaHk5UHd4OXMxcWEzdFg5TlZxUlFWaENkT2pDeXZYQ2lw?=
 =?utf-8?B?NUpBRzdITGdsMkZvT2tOMEs5WGExd2ZSMThOWVphTVV5VmZSL3dQNVVXYjdP?=
 =?utf-8?B?KzZUKzBycnVPSVZ5NkxZSEdISURLV1dRcFY2SDJJMU8wYVFqR2xHMFNteE1S?=
 =?utf-8?B?Yk51bE9wMDBLMWZWVlRYdGllQkhSdmI2b1Z6TERwanBMZHNLSUpFWGdmTE0z?=
 =?utf-8?B?bTIwaXgwZ1Q5ZGNSV1Y0TjdxT2hUQlJZWFRLMktHR1YvM2NZZjNXSEFDZy8y?=
 =?utf-8?B?SG8zc2c1UjgrN0JaNGk4NDJHbmVIdEZyOHVoZW9IblZJalFhOTRMa2FDRnJh?=
 =?utf-8?B?SmdIWmNFNXhLNmlqT0RQK2JzSHp3Q1Zndjd6cW9ROHRXbnNkK3cvT1k3bE0r?=
 =?utf-8?B?bjhZeWpjWFEwU0Z2UWEwQ0h1OVc5c2tEQTVsa1RVQTlvVC9PZDdZejd6dTZV?=
 =?utf-8?B?RU12SG9QWkd1VVlNMThSZmJMT2dWUVA2eWJlcXNjZVJOZmFDcEdPaWY5cmE4?=
 =?utf-8?B?eFc4Y3BENEdnYXVqV3Q0am1YRDNzb1JYR08vd24yZGVsSXd1dWFyK1FnK21W?=
 =?utf-8?B?OWswN2M4d0Q3MDhmRVNTS3VlVUplY3FRZGUrdm1yZkVjL0txUUI2RktNcHli?=
 =?utf-8?B?eVllOXA3QlNITkxZT2J1TVQ2RlVnelo3ajBEUWFWTFdhaFhCMCtWWDhzNVNC?=
 =?utf-8?B?cm9uWklmVjdFODBDVXlBb0VkVXp0YmtWVXNKb3lXNnJWeGQ2Mms2TStkbStE?=
 =?utf-8?B?L1hnVURMWTY3OFlTYnU1dUJwK3JlQjlCSWoyRjl0L25ZODdTT3ZRdFdqR1dh?=
 =?utf-8?B?V1NLWE1Ed3R1aWYzbytPTnE2Ui9VYllDdVMvb1luK21TZmxJVnN4TlljT0hL?=
 =?utf-8?B?cUZvcXVhYXkvL3ROMVRjY1psMEJSNkFZVnQ0KytFalJBa3VUSjJZNUpNMnZt?=
 =?utf-8?B?Lzh2LzhpdjJzeUNzOXJKclBESGczSkltVWFjRU5uaGhvS0NNd1h0bG9aMXpi?=
 =?utf-8?B?c29tdkpSSkZyczRDZUozOWNiMUgyUzR5RGlxU3lnVG9RcWw0UWo4Und0Sm9n?=
 =?utf-8?B?d2ZGaUV1eFBuYk5IemZMVDdtNjdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68B41E51DCFBE243BFDC26DF80DF173D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a461d-b1e1-4475-1e63-08de10b826fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 15:40:24.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcy2gecplWLArpwnxzf00jOdSfxN72AVQu7HTcnaKRBMRRLjgFNJtnnrl6/D+/0mkFAZ3ny/p1PxO019Jvbq7j8U2mGNeZ8DY+N1BOgxygg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8130
X-Proofpoint-ORIG-GUID: 90SunQRV16k11R7pZNP3yiqyFBzMPYJt
X-Proofpoint-GUID: 90SunQRV16k11R7pZNP3yiqyFBzMPYJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEyMyBTYWx0ZWRfX3sgGKO20xYE7
 7bu+zcjYCiDe5STGmG+NrEdp5wxTGo6fbbpVqL1gDNH/6X4lAUmSJ1aycOIaCMfjZ18RvHZezhn
 g/ILoz7I5wL5vGrCg52/nesyHg6bFVDoLvct/dZwqSxH5XQowba8VWm68YnbJ7je42aud6lbN7p
 WugssoXstjsoSq2VfhGRCLq1TjxL4/udNADPu20DfCwg/iY5veDcr5+g54t3tO25oJFHr2Jp1/4
 iri1I8LmtvK4Yv5cjMsVCnlRFpXf90TZOqTS6m1Tj9S1EiMEek2J7I1tdIxmtsLb7wfjx4biYyW
 tXodMczCJ8uEl6WNW0zjNy3mt7ZBKtSYNrIgRLRDc1OFd3emS8by/plwqc8xE0FbXWpyC7AcOKo
 vegyBiiz1ei9WqifL/96Qv2upMBU4w==
X-Authority-Analysis: v=2.4 cv=FrYIPmrq c=1 sm=1 tr=0 ts=68f7a96c cx=c_pps
 a=7tpojskyxclYbGypRN9vEg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=yBvVpO7SmKXcZLPk9uAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMToyMeKAr0FNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5o
YW5zZW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ICEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tfA0KPiAgQ0FVVElPTjog
RXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gMTAvMjEvMjUgMDc6
MzksIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiBGb3IgQkhJX0NUUkwsIGRlcGVuZGluZyBvbiB3aGF0
IFFFTVUgdGhlIFZNIHdhcyBvcmlnaW5hbGx5ICpzdGFydGVkKiBvbiwNCj4+IHRoZSBndWVzdCBt
YXkgaGF2ZSBhY2Nlc3MgdG8gU2FwcGhpcmUgUmFwaWRzIG1vZGVscywgYnV0IEJISV9DVFJMIG1h
eQ0KPj4gbm90IGhhdmUgZXhpc3RlZCBpbiB0aGUgUUVNVSBzb3VyY2UgYXQgdGhhdCB0aW1lLCBh
cyB0aG9zZSB3ZXJlIGludHJvZHVjZWQNCj4+IGludG8gdHdvIGRpZmZlcmVudCB0aW1lZnJhbWVz
Lg0KPiANCj4gSSBoYXZlIHR3byBzb2x1dGlvbnMgZm9yIHlvdSBoZXJlLCBhbmQgbmVpdGhlciBv
ZiB0aGVtIGludm9sdmVzIHBhdGNoaW5nDQo+IHRoZSBrZXJuZWwuDQo+IA0KPiBGaXJzdCwgSSBw
ZXJzb25hbGx5IHZvbHVudGVlciB0byB0cmF2ZWwgdG8geW91ciBjdXN0b21lcnMnIGhvbWVzIHRv
DQo+IHByb3ZpZGUgaW4tcGVyc29uIGVkdWNhdGlvbiB3aXRoIG15ICJlZHVjYXRpb24gc3RpY2si
IGFib3V0IHdoeSB1cGRhdGluZw0KPiBzb2Z0d2FyZSBpcyBpbXBvcnRhbnQuDQo+IA0KPiBTZWNv
bmQsIGlmIHRoZXkgY29udGludWUgdG8gYmUgZWR1Y2F0aW9uLXJlc2lzdGFudCwgSSBvZmZlciB0
bw0KPiBwZXJzb25hbGx5IHRyYXZlbCB0byB0aGUgZGF0YWNlbnRlcnMgd2hlcmUgdGhlc2UgVk1z
IGFyZSBydW5uaW5nIHRvDQo+IGluc3BlY3QgdGhlIHJhY2tzIHdoZXJlIHRoZXkgcnVuIGFuZCBi
cmFpbnN0b3JtIHNvbHV0aW9ucy4gQSB3YXJuaW5nLA0KPiB0aG91Z2g6IEkgYW0gcXVpdGUgY2x1
bXN5IGFuZCBJJ3ZlIGJlZW4ga25vd24gdG8gYnVtcCBpbnRvIHBvd2VyIGNhYmxlcw0KPiBhbmQg
Y2lyY3VpdCBicmVha2Vycy4NCj4gDQoNCkkgZ2V0IHRoZSBzZW50aW1lbnQsIHdl4oCZbGwganVz
dCBoYXZlIHRvIGRvY3VtZW50IGl0IGFzIGEgcmVjb21tZW5kYXRpb24gYW5kDQptb3ZlIG9uLg0K
DQpBbnlob3csIHRoZXJlIGlzIGF0IGxlYXN0IG9uZSBtb3JlIGFjdGl2ZSBpc3N1ZSBoZXJlLCB0
byBtYWtlIHRoaXMgbWFyZ2luYWxseQ0KZWFzaWVyIG9uIHRoZSBRRU1VIHNpZGUsIHdoaWNoIGlz
IHRvIHVwZGF0ZSB0aGUgbW9kZWwgZGVmaW5pdGlvbnMgdG8gbWFrZQ0KSVRTX05PIGF1dG8tbWFn
aWMsIHN1Y2ggdGhhdCB0aGUgaGlnaGVyIGxldmVsIGNvbnRyb2wgcGxhbmXigJlzIGpvYiBpcyBl
YXNpZXIuIA0KSeKAmWxsIGdldCB0aGF0IGRvbmUgc2VwYXJhdGVseS4NCg0KVGhhbmtzIGZvciB0
aGUgYmFjay1uLWZvcnRoIGFuZCBzcGlyaXRlZCBkZWJhdGUgaGVyZS4NCg0KQ2hlZXJzLA0KSm9u

