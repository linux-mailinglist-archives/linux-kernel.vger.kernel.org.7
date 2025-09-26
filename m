Return-Path: <linux-kernel+bounces-833822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E22BA326F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908AF387FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1A28D8F1;
	Fri, 26 Sep 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="HkwksE4d"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B844207A;
	Fri, 26 Sep 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879076; cv=fail; b=qSVBIBjD34BtAGDQFXYa26oxJDdMbE41rpGMw+uPT86FNlzd7ZYc+s6FQSa/vy0DCH16WgQaEkO2QJZOoqLUIQKrHP9GBdDkxWjKDKBFt7YrLA3dAarrT2z2rUyNZHHdalS4EcvSqjDEnthhzhdrmqCgCr9y0xAHFqop7DzytHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879076; c=relaxed/simple;
	bh=FtGLhQhJYMpA9MY8juXz3GYHqPVTG4a3jWpKZgLqH3w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKapXg7pwzYFoURRrz5ev17BO+dFldPrb4jfzPeJ5Aq7HD/xGIYw7nMJT7PTVEZp2a4Rp0+kb9X+f/dpN+cdUECZGKmbZ36fny7gkbhbhIIst9X0HAUB0HaQ7OK9vawnFVvPJA2W82GI0wu9dmNMbihsjmsBL39UeUu6Rhl4ZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=HkwksE4d; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsBD6eyoZWKUxsjGwzREgYSSwVWY+XgGe5DRLMMyUYhphvwqZla9XwW4mxSKohI9eBT9oCqphuj9ojQnzN7pUAEmyYD0qk2ZMvTgewD77Eu0tK24tkcKMh7mqiMjvSoOU/LnLCp1jo4L0hGI01OkdIIm8YVsSeH/EL3Ax1GPg71F5dk4ld2iXFILX4KlXYZaZ4aETOLAL4jscSd5HKv/TMGeCoFO6URlG5DkKfF55ejJUVR3WOpavIItYv+hZzQc97pEqRq3H9mAe/C+i+3LEzVPNS1QdFxOegBESvTU471BMQRjsniLO6FSpBC0Zpf0l/39GYYEbFqfpgmrqDAjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yri90RlP39Bp+d0/wXGLp+l3FpKKx1aegV6kXSLzCQs=;
 b=vdgtH0uWxyP3AfdOTgVMSbJXnVBfZVzResezhNpGaKfejijJpSLl4JWP5j32MLG6qrjFBjuwlIFP6idPJE1JArZeSeHpdou8Ir/+4XkUfcCjMUHRW/wqsbk7YsQkNG7Ee3QnG6l9VsqQOtvF9XmqYO6XWABMU8bv34A4BoiVYJYEztdFmrP+vjq+eo8cLrgv6xF8Uke9AOW/d8OO86ZevW6tgj5C61g10G2+Y382L1dZD60s5fuDolTVncuV18dzQ7G4XTNK+YIyfsIBc3r+l04dvtEUVDzwFXvx76VMshzgtA5dXv0yQFTDan3iX61NtDTWirhblY9aDYAJFRHJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yri90RlP39Bp+d0/wXGLp+l3FpKKx1aegV6kXSLzCQs=;
 b=HkwksE4dt1zAoiqlxQFj8gp/gENzu69oqFmwTmmo5a/6UWsYx+TuSOtFLEsctegxkS422Zrb22sqvPIumRcQ8lWKMUxZU7IKSNQPSUY0vutlOUsJ0W+4t3DzJRL+gYnTLS7R2Rnhp5pwHtISrw/iEOpIaSZRN/i+5qHaXm0X2cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:254::16)
 by AS1PR10MB5746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:31:06 +0000
Received: from DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7956:ad04:35d8:6f0b]) by DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7956:ad04:35d8:6f0b%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 09:31:06 +0000
Message-ID: <4a97f86d-a466-41bb-860c-ed64715d1bd0@prevas.dk>
Date: Fri, 26 Sep 2025 11:31:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx6qdl: make VAR-SOM SoM SoC-agnostic
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250925104942.4148376-1-stefan.prisacariu@prevas.dk>
 <aNXAaewv/MpqL78M@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
In-Reply-To: <aNXAaewv/MpqL78M@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:254::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4747:EE_|AS1PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: b5338154-4a5b-4c0a-898a-08ddfcdf6b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS92ZlFSN2tBUUp3bGlRNkpSZGhUUWgyQVJscGVUU1lPQTR4M1YxcllyYnYz?=
 =?utf-8?B?dVdGcWcxaTlyN3RHM2ljbmt4dzVRdEZ2emR3a0kvSTZnZGt1Y2l4ZTZRWXVC?=
 =?utf-8?B?Z3AzQ3NlMUE2TnVueWIrOHQ1YjlNdnQvQ1hZOWllVEpjVzI2ektKdFBrOFNh?=
 =?utf-8?B?WTNYSDIzYy9qclBGWGo3M2RYenVSUzIxaVZSc0k1cFVqMURFQmpHSXdRRjNT?=
 =?utf-8?B?ZVI0ZFIvM2ExODBFRWlseCtZR1luRFdIOFBCVGtXZ3JCNjZHNktlOFNieG1T?=
 =?utf-8?B?RVRYRHFqTllmdmxSNko4TUNENkRBQXpWZnZGclQ0Y0VxSWdJTXFmVG9rS3Fq?=
 =?utf-8?B?VGVPbnZBUWE0cDBVZDVreThiNGpSNTZ0clBIczlRanJOZ2p3SG1rU1RjQklz?=
 =?utf-8?B?cUVidC9WNjZaWHh2am10NTBsTDg1RkF3Z3VZSkNYVmVoVzVGclpESFNYTVg4?=
 =?utf-8?B?cGxENWdmNGQxUktQd3V1V09Way9rWllCWEd3Q004N2R4dmhMdzVwVE1xZyt0?=
 =?utf-8?B?VmN1NlZCR01GVExFREZhVnY0OERTdFRtK0hsdVpOd0o4Tzd2Ujl1NU9NT2Fp?=
 =?utf-8?B?cDZvM2FSOVNGbmdPaC9QN3U5RVVGQktzbE1ncGY3WmQ0Z25CTzg3R2hJTndO?=
 =?utf-8?B?R1grOHI2T3oxcXFCdzVBUExLNnhSa1dJek9vMWdWblpsNEtIcm1ndUE4SEpw?=
 =?utf-8?B?SGhoOFE5TnR3Q2ZSbnlkdGRadVA3dTE2MXowaURERzZ6UzdIRUpHUDQvRG03?=
 =?utf-8?B?bklHdWNuTFVVTWVNTFNYWmtPSXVqUnBvSTd5ZUVnNTZ6b3NwbHJydlNuSnJj?=
 =?utf-8?B?RmVXQTEvc3JBUTUvbEZxUDE5MncrU2xXQ3ZjNldlT0xVNDBuV0xEempOYVlS?=
 =?utf-8?B?bVVFV0tMVU5MRkVtbjZBY2xYd1RNbWhLb25kMXVqSXdXZTBUT3JCLy81QWZZ?=
 =?utf-8?B?QWVEUmUvdGJSdDRBblI1K3BOeURmUDlwdENSbWpiTXovMTRJTSthSGE0cDNS?=
 =?utf-8?B?dXNIYnZadkxWU1BrdmdqanRjc2MrbEk1OGlkbzRiUkNXaHhVNEdWZnBRbWx3?=
 =?utf-8?B?eGJ0SmpUZ29ObDdrd2J3QS9kM3NWTzNqWEFKMk5OdHBDWFNpcHpCM0JEUGIx?=
 =?utf-8?B?SVAyd3JUL0FEc2JqMERzT1VWekE4RmgwU2EwdXVUenFYSUNtUzQ2MkMraTND?=
 =?utf-8?B?NmM1cE5hTFlWSnErenIxYWxkcGlGMDBFL3BTTVFHV2w1YlUxRUVRQ0RVaVJV?=
 =?utf-8?B?bFp5cERId0JKMXZjdFArTXhyaGR4WE0yQjB0UFIwUGcrTWJpRGxtR1BrZ1Fx?=
 =?utf-8?B?Qk5CRmNSbnYyQVBYQmxMVmphMXNGOVhOdG92U2pvQlhncEtLNzBiNGRyY1Vz?=
 =?utf-8?B?QXFkVUhDcWs3QUMvYk9KTUhIUDhybGNVLzZpMlZoS2xTaUNaQURoQTVaUGc3?=
 =?utf-8?B?ZlExdDVaSEFVaWhDT20rUjBOODlvSWZGRGg5bjd6NVpXUnJ3clBnajNhRUFw?=
 =?utf-8?B?emxmV1l3QzdlYlQzbVV5cDVtLzQrc0NCdHNNTGZ1YWUzU0J6STVsNEc2dk1O?=
 =?utf-8?B?TlVBNTVuNjUrbTV3cGpzY0VUVGxrVVVDTWFiUFVCWWZRUmFPUE84bXI5WlVW?=
 =?utf-8?B?dmxNNk1ibUt2RUFUOWtDdFJiS0x6dVpOWHpidmlSYTdaUnkya1grMDJCQ1JX?=
 =?utf-8?B?MVVXbkdsbmo4R1hTTlZEMWlzM01zTEcyOE50OEJkd0lWeHZIUWpuZ2NlZUpB?=
 =?utf-8?B?S3JocnlVVkQwbTNXYk1zcGtVSHROa2pJWjlkbFRjS2NuencxOS9tRDREdzl0?=
 =?utf-8?B?c2RNN0F0OWV6ZVQrRVd6VktVNng3Ly8rYk5pZDJwcUVNRVczT2hKZlQvSXpt?=
 =?utf-8?B?VC9aSktTYXQ0ZGpLa0hvOWVWVXVnSlNaYS9Vd3ZwUTNCQS9GWkJnSE9sWDlr?=
 =?utf-8?Q?O4S3uUJ1cCIu7kc/y4ugSBFUuokD2RHZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTFpbUIyZGFKZERWdHRnRTFJMWlnL1dKeXVQUW9qS3l1WmhWQVUwOVkxRnF4?=
 =?utf-8?B?NHR3dUNUTytnb1V1WGFSaEYyWDVjb0FFWUc2NFpZR2w2OVEzS2FNUXNjRkZa?=
 =?utf-8?B?TGdNaCtmWDB2cUF4elVvcWJKUUlIbnBObm1TYjZzRUhTK2NwN0FaK1d4dmZ2?=
 =?utf-8?B?L3dFb0Erc3BTY2l5eXNJY1JkTFRSdUthM2VnZGhyaE5TSkllaU1SVk9UQ2xr?=
 =?utf-8?B?U1NiWXRnajJUL2lRcmYvdGxTM0REeWhvSW5GNFYwSHBmWkJUamxOay9oNGlU?=
 =?utf-8?B?MmVsOXZXNGNjMFB5aGg2SFN3TUZ4KzZOSGtRMVBSTm43SWFaVURERmV4c1Z0?=
 =?utf-8?B?YlJrVXVPL1BOWkVOQkFjWDlSVFVqM0lpM0orYmE3elo2N2xZQ1ZsamREanpa?=
 =?utf-8?B?U3NxV09adHhUb1RlQUhPZGhnWHVGKzZJWmN1VXVEL0xGSUNZWm1NV25lT21p?=
 =?utf-8?B?NXJUZjdyM2p4OWlQN0YyVnRuV2xSOEZ4MHdqQldEYTBOZm96MXB1d1hkSkJt?=
 =?utf-8?B?U0MvVmU2TEtETGRNK1djTUFMTVBMLzZYemtrdlF2SW0xaWs3c1NTdlBZV1JV?=
 =?utf-8?B?NCsrWVJ4dDB4bkcxRm5OVUE0c0o3Und1ZmFibVlxYXk5VXQ3Q2pJNExjK2lr?=
 =?utf-8?B?dks5NllFSVFxSjZvODRUMW5EZTJ2bGxSV3VRUGtvNEliRVJoQlVITUJVODN5?=
 =?utf-8?B?VHBaUFhVOS9CZDlBa1dSRVhjeHNWL0JwTTZ0QzIyUFZJb2tCM2tjS0ZsQnF5?=
 =?utf-8?B?cDArN0ZVVHFHd1lSVVVlUks5VUl0aEVHVEhsV25DS1pPQVU4cXo4SGtYZ1Ry?=
 =?utf-8?B?eDd5eTNoZ0RBSXZMTXlNdXFzbUdaMzdZTUVkR0ZnLzBWQ0cvZlhURGplZU1t?=
 =?utf-8?B?a25la3NQbC84SDFZanRHL2paUEJMMGIwV0hwcVRnUnczc1JzZmN6T05zWERh?=
 =?utf-8?B?Ti9qdENzL2xUVmhmWkh0bllkVGdQaGdwMExsYmJuQlFlbUE3dWk1SEtwRXhH?=
 =?utf-8?B?azFYVlZ4WEMzY2Y1Y1JwSkVmeG5wc3VkT1hDclRFY243K05zZTVjSVl5UnNk?=
 =?utf-8?B?YlppTXo5WTB6RXFqd1labFdwdnN2dkVGb2d2eWdqdld4Skw2Q1hzclJTWWxM?=
 =?utf-8?B?KzZUUnpHbEY3cjhDdS9WK0FyaUhtUVVMdFNtWTE5TFVEQXBUNmdOZWJJekNV?=
 =?utf-8?B?VTVDdit2dXg5NGpYSVZWWENsMmxBWmtxNGhobUZYWVhrT2VsZnF1SitXcEto?=
 =?utf-8?B?OXBoVmd1OVIvdkNBUTZxSU5zMm93Q0p1anJmb2ZTVEJYeUFRVS9vcklTbk9R?=
 =?utf-8?B?cjJMSktFYmVucVM2NTRNczVFYVRiK3ZhSys3WTl0cUNleGhLeXZGUVBFR2hk?=
 =?utf-8?B?SHN1bDlXWFBtSUZvZ1lUVW14TmloUEs3QTJEL2VacnU1RitFaU5hbUM3dncw?=
 =?utf-8?B?NTlkNVQzL1BDOTJGQkZaRGFvUHZaM2w3Yk5oMVMrQmxUZW5yMmRLYjUvVm5u?=
 =?utf-8?B?TWY5ck01bFNqTjVmNWlQUXpZeHlqc3FsdmxJamlkWVV6Mkp0N2xTK0VtVXd0?=
 =?utf-8?B?TGlGY1ZMNkk1YlVkTURYRUIzcW40WXhSWGpDUzR4ZEFQNVdpbnp1akRWYjFq?=
 =?utf-8?B?M1JyaXJ1QU51NlBwNkhNMzZOZ3hWeTNRVjFOR2xuV2JPNEtMYTJ2R0ZIekNM?=
 =?utf-8?B?a2NJY2xmWjg4U3ZRalJtSkNmakNUaGx0TzR4UWl5NjFnQjlpVy9uRXJPTS9H?=
 =?utf-8?B?eG1nMzc5dkVmUE90TExFM1M0ZGJxaGU3cGxuQ2QwaGY0a3BXeGMrVWZKRDFO?=
 =?utf-8?B?NW85TERUU3BQdmhxSS9paUsxVVVybFpIVUtUS3FVdFZJV2hQSEhVLzNTMTdp?=
 =?utf-8?B?UFF6YWlBVTkvQ3RmNFljVnJyQ1ZjOUwySlh6dFJyQTNkdmM0ZS9kcFVVYkVS?=
 =?utf-8?B?QnFvaGRmQ0RIV1lLOEI0VmxHMkVxcC82TENhaEdpL3Y0cnFlUGVPYW9FeTJr?=
 =?utf-8?B?MzdSQW9CcHlIL2FGZ2dONDhUQmFkREpLWDUvQXJ0UTBRSTBSZldQS21uZzNU?=
 =?utf-8?B?bktSRUtNWjZYYmNLSW5TY1AwOWhmODFEZU15enFQNk1HSENDWE43d01IUDY4?=
 =?utf-8?B?ZHRIZHo2QjdHajQxSEZlRHY2U1NSM3B1NDhybC9rNm4vNGtjT0JVaTdwZEI5?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b5338154-4a5b-4c0a-898a-08ddfcdf6b69
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4747.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:31:06.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5CBV84AweOwPX7YqwyIirflQzKhr6S6MXNumnZ8unOvtG0S0L3+xscVIhTWERUpDhwTd6O7dYnhhWoTDN6VjhDFmzt9QYMVTMol9NvdW+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5746


On 26/09/2025 00.21, Frank Li wrote:
> On Thu, Sep 25, 2025 at 12:49:40PM +0200, stefan.prisacariu@prevas.dk wrote:
>> From: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
>>
>> Make SoM .dtsi SoC-agnostic by moving SoC include to board level
>>
>> imx6qdl-var-som.dtsi currently includes imx6q.dtsi, which makes this SoM
>> description Quad/Dual specific and prevents reuse from i.MX6DL boards.
>>
>> Move the SoC selection to the board level:
>>   - Drop the imx6q.dtsi include from the SoM .dtsi.
>>   - Add imx6q.dtsi include to imx6q-var-mx6customboard.dts.
> move imx6q.dtsi from imx6qdl-var-som.dtsi to imx6q-var-mx6customboard.dts.
>
>> This keeps the SoM .dtsi SoC-agnostic (it already relies on imx6qdl.dtsi
>> for family-common parts) and allows boards using the DualLite or Solo to
>> include imx6dl.dtsi instead.
>>
>> Why this is needed:
>> I need to reuse imx6qdl-var-som.dtsi for a board based on i.MX6DL
>> (VAR-SOM SoM + custom carrier). Without this change, the SoM .dtsi
>> forces imx6q.dtsi, which is incorrect for DL and breaks the layering
>> model used upstream.
> Can use simple words
>
> To reuse imx6qdl-var-som.dtsi on i.MX6DL board.
>
>> Verification:
>> The DTB for imx6q-var-mx6customboard was rebuilt before and after this
>> change. Both the binary DTB and the decompiled DTS
>> (via dtc -I dtb -O dts -s) are identical, confirming no functional change
>> for the existing board.
> Needn't this section (good place for these informaiton is cover letter).
>
>> Alignment:
>> This also aligns the layering with how it is already done for
>> imx6q-var-dt6customboard.dts, where the SoC include is handled at the
>> board level.
> Needn't this section
>
>> No functional changes for imx6q-var-mx6customboard are intended.
> good
>
>> Files were introduced in:
>> commit e5c810848d2a ("ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6
>> SoM support")
>> commit a5b59a3f41bd ("ARM: dts: imx6q: Add Variscite MX6 Custom board
>> support")
> Needn't this section.
>
>> Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
>> ---
>>   arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts | 1 +
>>   arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi         | 3 ---
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
>> index 18a620832a2a..a55644529c67 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
>> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
>> @@ -8,6 +8,7 @@
>>
>>   /dts-v1/;
>>
>> +#include "imx6q.dtsi"
>>   #include "imx6qdl-var-som.dtsi"
>>   #include <dt-bindings/pwm/pwm.h>
>>
>> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> index 59833e8d11d8..51bcaf04546b 100644
>> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
>> @@ -9,9 +9,6 @@
>>    * Copyright 2022 Bootlin
>>    */
>>
>> -/dts-v1/;
> why drop this line.

As far as I know this line should be present in the dts not dtsi files,
also this will remove the requirement to have this dtsi file first 
included in
the dts files

Stefan

>
> Frank
>> -
>> -#include "imx6q.dtsi"
>>   #include <dt-bindings/clock/imx6qdl-clock.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/sound/fsl-imx-audmux.h>
>>
>> base-commit: 8f5ff9784f3262e6e85c68d86f8b7931827f2983
>> --
>> 2.49.1
>>

