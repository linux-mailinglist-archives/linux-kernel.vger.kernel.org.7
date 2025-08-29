Return-Path: <linux-kernel+bounces-791162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3458B3B2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87C11C836C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95CA21C16A;
	Fri, 29 Aug 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J/C93n8A"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC01401B;
	Fri, 29 Aug 2025 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756446385; cv=fail; b=P5sBSBPFLuLMwRpyCUyTAKq4wjgvrEuwELw3EG7+hMe/+RRaaSeFwlYbvYbt9KNYxiFmX+5u2LYdDKXw0lXmInK9SDoEBwDH+g6uNaGjaEX4Y24o4xpvmo073UqpsaTuluDsD5K7tme1ZNLKPBzWtBxOGFnOETijH+crK4+h0XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756446385; c=relaxed/simple;
	bh=ZDDWvmRzIRHrzD3lYLWHN1BnLQgIOyxZroOyIxAANUM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTEi/e4Kuxe722v0UyNN0n1XtFOEOtefZaqgltHUuTj19MUJ5URTQYt+6laqk82yVe1njeN+2Y43jyf4HLM4ak2eP+r5U6b37d3tnA2plYCIeUcEZI7Xp6uUrzLqEEv/74k/DhLdv8JmQ3lMQEETdV2YSAZ3bPKH+oLSNSjtZcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J/C93n8A; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfEHMyEQazScT/iExmdP9ieSatp6Q+WHrHHn1dt05Kr3TCQte/XRPfRYzXDcoZIGXflkkXv/iR6DQDAxBhs6kOeV5F0XwiGxwRWD1/l8mrvr65ETbH8m2IDaSWUaJXo9x8LLvHWY+ohilsXBRmaG3ztv8yVXVflhd3nljyLGNbhKZ90mxwPLvuLmbRnQtZ1lkUu0z/SoMysIJh7zlaD5XQKk6COlKzSG4ivGNv/j3d0WIHEVGBmzTuva83XcZZuasp/GCu9f8PZROen1POJMN59UNGoHrL7NIfD3lNWIV3QKFsMqH6sGN9IrK0ewwwWuw7vCUFSotlMakQyhdrnbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biQV1XtjRwcSvn8vPSDRvy6yuE41j8PEr+SAkTboX40=;
 b=LTtCuVCKtIdP5fDwMHoaIrt+d1fRTxn/qhBqd83/Xfa1Cvc493+MUSRUkEnUfuwvaj+99UJdlDbUA9Nl0tfEFfYDDzv2F3ftWtQzFMvMfKYRO4o3hVpdQclczYJzXRibiBfDpdhKLkdCYkRQiEMzV2yl1ZKigWzZgTXBLWtr7mzTzrakdtHvyclMyKsDFooELB41qpHHYi22KQJaJvDsYmEHaIWZEPBQbv/xMD1r5srbrtC9hGWxCCkglUGtK8WNjqhXQ/uUzYAIYyu61PQhI2QdwqX1ML69evjdssCjW9PWfXhekMWTj21DrhVUPVq+h5Tjb9pWN64mZO9Ftd0Umg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biQV1XtjRwcSvn8vPSDRvy6yuE41j8PEr+SAkTboX40=;
 b=J/C93n8AmjvO9h4njo+Ow3um0OJbjNBxCGxYt3quZW/rdLtNIqjhEP3jbkjfgYFvsq5WpIY2Y0kd+/2U8cyhLAEMHgbKOhDvR9WRWt6du+1jeM3mS7R6IWXDqDyE3z3hbevmRzL8OOX7JhU0oFFkDpyEYOnqRsX2buCsnF1Z6N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 29 Aug
 2025 05:46:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 05:46:19 +0000
Message-ID: <769c2a21-15c7-4c6d-84b7-cf1153106dfb@amd.com>
Date: Fri, 29 Aug 2025 07:46:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: xilinx: Drop undocumented "always-on"
 properties
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250828213028.2266805-1-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250828213028.2266805-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: fb71964a-1b02-4303-0887-08dde6bf607c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGRxYndWSzRpbmJ1Zk81eklmUlNyVVdOQXFHQ3JXYTNSRHBZS1dvbmpqalQy?=
 =?utf-8?B?Ym9yMWZhK05ydnZHVEZVYkdsZmhQMUFtWkRna3JMZ1Y0ZTBhY2w0ZG5STE5Z?=
 =?utf-8?B?ZU1GNkZHTC9YNk9yVVJPdEl6TFJWR1FaTWFuVG05bkt2OWxsQzQraEZEbmto?=
 =?utf-8?B?NDRCWEdZcW03WUgyQzJ4RWo2K2c5ZGYreUg5YTVROUJ0L2lXem4wdlBSU2pK?=
 =?utf-8?B?UlNqMFNvMkJES2dqalhzUzFWNGNnL0dlMExBT3pSWGVNVlBYQ285VmJxZWNY?=
 =?utf-8?B?UXMvLzFwNDVSSzZMbGxZRlF2Y2dBZXJ3N2xGSUxydERqMDdNUEVLUkxpRFhX?=
 =?utf-8?B?cmhWc29PbDFJeU56dDdzc0VxaGE2RWtFQy8zemwyQTREL3RqT1BvN2Y1L05o?=
 =?utf-8?B?ZDFSdC9DbDBIRm9VZDFMbG45TUNmUHpCYmx6d2xHa3htY2paZlI4c3M5dU9L?=
 =?utf-8?B?YWNVY01US0dvdFc4MkFsRmVqV1ZTZjczejg2RzhzbTVqWjJOYUlnbXd1ODFn?=
 =?utf-8?B?cXY4ekxzNjMrSTg4bSt5bVhSMFpqVkN2WVVMMk9Ga0R0ekk4dXdFS0h4MmFl?=
 =?utf-8?B?Ry9WQzBSSGNLaWZ5aFFXRno2clR3YXgxTU9UQXI1cTJ2MkJGWDJQS0ppSnpu?=
 =?utf-8?B?QXBtdldiemNkajQ5T04yaHZIMHZpRm9TV0NOdEo4NXVYNjk0UjJZUzR3QTI4?=
 =?utf-8?B?TXBDK3l5aUpkZnNnSDZvSlVsMThBTU0wN1U3VDlkTjdBUVp2WjM0aTc4ZGZK?=
 =?utf-8?B?MFArbXgrNzhyTmo4Q3BCSStxVnJxYWdqeTB0a3Qxb0ZVOGU1cVFNMUJNa3hv?=
 =?utf-8?B?dmNreUFxdk5Ccmx5U0RZUFZWZEp5Qk1oejQ1Wmo2MVJMRm1HSklrNytOSW10?=
 =?utf-8?B?M2Z6QXUwMFF5anhFOEFSMFE5UkhVY0RqV0NKZEkremRFMDZHZkx6dytEQUsy?=
 =?utf-8?B?QzJ3OXI1U2NHRTBvcnJRR3lXRGNRMG9nK3VHNW84VTYwajI0QWdXa0Vsd29H?=
 =?utf-8?B?UVk4ZFA1RUlxZHlTbmJEMnJSRnlFOWZZQ3BNZmVkSUQwK2F6TXQvUzVhL2xy?=
 =?utf-8?B?QjRmMWdVOU1zbkl6Mk83bkFhUDAremJpNHBlQ1poY096SjFGeEVDK0RiTVRr?=
 =?utf-8?B?NStvNkM2SlR4R0FnT2REbWE1WUtIVHNIajM5Si9nWnZrbTBWQ2l4VG02TEMv?=
 =?utf-8?B?aGNPV1JHMTZDM0o3b21yb2JJUWJ4dDNMN2Vicms1dWRvbHFWeWx5d2RaNCta?=
 =?utf-8?B?dVF4QTFCRkhNZDlwaHFWV1hnSUhwSmxyWHpLNis2WFRrVVluUUtMVEpCMzhD?=
 =?utf-8?B?bmJyNjFlbjN0MTVHTFdjUjRDcTFJVFhRenlDVDFLejBNZFpRb3ZEcHZDdWh6?=
 =?utf-8?B?TisyS296dENzZlRZYjZIWTVhY2hTbXNMMXFiODBwUFV5aXJRUkFwVGVrTFFT?=
 =?utf-8?B?QjBwU01YeW9qaVFycU96Uy9BaXdzU0ZmeFhHMjRyNHUxZE5qdDlsakV4bFNX?=
 =?utf-8?B?YnRtUUxUZWFkVDBwU1VqVWRYcGM5ekNXTUhhZThzRFY3SytiM1FWQU16Z0lj?=
 =?utf-8?B?aS9ZS2dWbUhVN1A3MzlKME1HaURsWXA4ajJkRCthT040UmJNRGtFaFNORlhD?=
 =?utf-8?B?SUZmcFNyWjNLVnMzaWtCc2pkb3VxMWRpQW4vdmtsRG1VZ3ptRWE4NGlJY21B?=
 =?utf-8?B?MTl2NjBOSThTcVFDZzNHb3ZSM3BRQnBmejBMbkJFVk1oYkw4RG9DV3EycEp6?=
 =?utf-8?B?bGJkTmh1c3JmbzhJZXYzT1hPTUhDWEdGSHBsckRwNUdIcTlCV2JPb3d1MFNp?=
 =?utf-8?B?SkErOHRLU0VWN3pha0p5T1hDVUo4ZTBTd09KbDgzTiszYVVPOWh4THcxMEFZ?=
 =?utf-8?B?WWpmUUo0ek50am5NamlhVm50SHJET1lLRHJCRVlwRnVWMnVXclJyWU0wT1B4?=
 =?utf-8?Q?2gJtnwn62Xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGYrZWVENnpabGtGQ3g4UHE1eXVvUVowTzBNSzJmcmFMTzZ1ZmlOZkQ5Q0tR?=
 =?utf-8?B?NGlMWGdQSWI2VFJic1F2bkRnaU44VTFoYXl6UVY4Z1FUZEIyWC9ib3ZvYnlI?=
 =?utf-8?B?RndzbWZQOTNCVThwMlU3dEFTUFNRb3ZUMGNFc1ZqUGhvcExrNHVrUWl2ajV3?=
 =?utf-8?B?aWNnV3J4NzQ4RkVaNit1cnMvSjFkR2tzSW9QaUJydDFVUlhUK2RLZWlQSG1x?=
 =?utf-8?B?Z3NkVlRYd3RjSmJSR3FLc2ZhYjZoYWRBc241a3VhcUE1UTI1ZXZ0aW5xbHJp?=
 =?utf-8?B?UHN3eE8zL3pFU0laZUoyTEt3ZWY0a0lPc3hVRzlVYmZJNUpQR01ZNS8vY2pT?=
 =?utf-8?B?TTF3S3VUS0xraGlDL3hUTlFyUUdjdHRiTUcvUXYrcnYydytuc0pZaUgyWm1v?=
 =?utf-8?B?d3ZUZXlBWG1DMWJoMHFwSVRSL211VGxIYlh2dmpBaThrQnNHVTNVSWw3UEdw?=
 =?utf-8?B?MjN5Y1pUSXRFVnQ1UHoyYWJvaUt1STRlanZKaTNMNWFTTkorZ0JWOWJFWTJ5?=
 =?utf-8?B?VThobFExOGZJVzZ1cjZOTmlBMDUwVHY5S2ZZVmc5b0t5STJGbHJVbmRhU1g0?=
 =?utf-8?B?SlFYZk5SY3BLakd1M0RWUW5ZaU1MbS9WZDNZZldvWXNJOVdhbVFJcHFWNDBE?=
 =?utf-8?B?YzZoUXIxQXU0OTlIdURwM2N6cWdhODlQZyt4ZFExSExHcFd5U1dCNFB3eXpw?=
 =?utf-8?B?NEtzQ3ZKSVFndW5VTzdlQm5yOWJkRm5zaFFkL1BybGxHTUJWaWdsTlAxTGRR?=
 =?utf-8?B?UWtYWEp0YUgrbjdmYWlSMjJJN1NweDF6LzRYQXVGSDFtUGxrSkp3OVhIRkFM?=
 =?utf-8?B?b3BLQnBvRmNRa2JISHVmWHBqWGF5YkhLU3JrL3l6Yys1ZFh4SnM2NDk0U256?=
 =?utf-8?B?MEE5SDREa01RRit3VW13ZXozZXRkaWZzWG9Md3krQlJ0Y0hLeWpJUS9hclVs?=
 =?utf-8?B?RjdiY0NrNXY5eklDL2hyb2RWSWNhc3FHS1k4cXNUUExiSHBRdkNrVFRDUU1Z?=
 =?utf-8?B?eUxNT0VoK294MEkxOVd6RTFDL1ZNMTVJbnkxbzRyQUdadUlWcGkxSW5Gb1lG?=
 =?utf-8?B?dldRWUFRNCs4cVI0YTJlQWRxRDdrUk5rL2hqVVRScDQxOHlOVGZOUTdsMElx?=
 =?utf-8?B?Rmx3T25XV0NWOU0rVXYxK01aODhxQS8xTWFjYUk4c3FFUDlPeVYveTNJMmRr?=
 =?utf-8?B?V3RONEtSaGtSODlNcm16aFRhR245R0tjd21mSGVxZlltRWZBeHYrY0ltVUY3?=
 =?utf-8?B?U2Jhd0VpS1JHcFpPT0JnRHo3SlhLTm9wZzF1MTlNMkE0azRaL1QxaW9KUmUy?=
 =?utf-8?B?c2kvOW1UaEhjOTNMc0ZtaTJsejE3WkV0SC9McWtJdVRvZUx5SURkQWFjcmVW?=
 =?utf-8?B?NVU1bmtwZkJmaGRxb2crM3RkaisrTVc2VjZsTG1FV1NsVVQ3UU5jdEJRUzho?=
 =?utf-8?B?R0o1Y2FiNHpNWW9wRzNacmdhTGpTQTZlcUdTbEdRQ0x0OXNtM3JIR0hRdnpu?=
 =?utf-8?B?S1p4ODQxeEtuWmZMNGpWQk5XMjBXaUZ2TGdzbTRNbmF0dVFwQktWeTFMbXRn?=
 =?utf-8?B?YjRaY3A2emdxUDZleWdqTWZrc3NFUCtWQ3FmakhnMTNqSlhXTHl5TmRlNWF5?=
 =?utf-8?B?OUEzN1JjdkowSFRwMnZJc0Y3UUp6N25RUDgzY3lLY3hqTkJWM2JncDRDZDlS?=
 =?utf-8?B?SWZhd0xjVnBoR3ZUQk9aeFhXNTlhblBKcThKeCtndFAvRDBQcWplUUJENzdQ?=
 =?utf-8?B?cTkwYTRyNEpLekNQUWdtOFFYUmZKcWdRMXc5czY0U3lBamNhSk9EMUxJaC85?=
 =?utf-8?B?WXkzS1QxRU11cGRZWXVtVVZVOUFKeG9id2tkVVJvRUhMRlROYWVhZXN4MmNU?=
 =?utf-8?B?ZlZ2cy83RHNZdmlFd1BBNTdVNlRSY0VWaDBPM1lyZ2ZjYkhoejRhTjBSNUkv?=
 =?utf-8?B?WERQTVJBNFcxZ0FPbnhtRWNCeDNXdkt3OFNkbFlicEZSTFN6MCtUNUZQMENQ?=
 =?utf-8?B?NGR6UFNOVGtQZnloNTJFME9xbFMyZFIrTDZYbGtob3BYUGM5L1FqaWx4ZG1B?=
 =?utf-8?B?eHVZTDQ0QWpsME9mTXFVUUxuVmVxWGVKVW5WZDV0RjVHdXhGK0RET2ZhcnVt?=
 =?utf-8?Q?4FGL6d+C/eLo2QJBkbg1lYA/o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb71964a-1b02-4303-0887-08dde6bf607c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:46:19.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDSW3qL/e4ULNOJeckWwjv8YcyfR67SUg58CGc2C4GloPHYcL4lK4SHoauXZ0IJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544

Hi,

On 8/28/25 23:30, Rob Herring (Arm) wrote:
> The "always-on" properties are not documented for "silabs,si5341"
> binding nor used by the Linux driver, so drop them.

Binding
Documentation/devicetree/bindings/clock/silabs,si5341.txt
doesn't contain it
but driver drivers/clk/clk-si5341.c is reading it.

1345                 config[num].always_on =
1346                         of_property_read_bool(child, "always-on");

It is there from 2019 when driver has been added.

If it is not standard clock property it should be moved to standard one.
And DT binding should be converted to yaml with all properties used today.

Thanks,
Michal



