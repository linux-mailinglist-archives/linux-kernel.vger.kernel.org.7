Return-Path: <linux-kernel+bounces-854852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7DBDF925
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8F4FF0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C44337683;
	Wed, 15 Oct 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qnSyLaJj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D94F330D29
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544534; cv=fail; b=HnSQqv02HkjrcdHMaZ4cGdCI9gG6YVpF64dp7f+V1kVPdcbU8+/OcY+Sq92lG/nBgRRKR4X8HTkhFYqYkLYsv3As9fe/ug6OX7hxKOuI+NGlAz1kXjk2JqSThcO/5m7desTyvSYZadGg80BDQtW0K9KhlrlNy0aub+90gm/W7vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544534; c=relaxed/simple;
	bh=VMPP08Zl6tsatJ2g2DlrtZ5VjdCHtlwPbRxpP/+PA+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6qLLEIqKmEHtkDnxQRnqygBJN766KfHQcKrJwTTpM2JyM1kVITRvuFHAvHWhXm3hnpSAR9jVnZAcrjhl3BO8DrV8tUv0h89k/bcLbfcv0hr/SexGW0M5cDQUtY4SX63HEZgsK+ppFaH4RB/0wltCdH33ckeczMuLKO0NfcFR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qnSyLaJj; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHAjbeCWslK6KE+4dxiz98q5pBBOFjbVlxiJmLWY+d0n4RzdlNDZ5NupB9jZosDz926GPBSsntpl4UYG7V9LXvJkaE4+55kpHQDghPavQbHjTNoTTXcpQeYQi3608WuEx0F6LYv/03qyYV5hk4KTKot5eYNkeheuZPas/XzvTuX2jgQ+trmp5Y9p2eHmLXdy7Hhk6I2R2xUhiEG8IlWq3kg4w6iF92CtAq9P5DE/PfTDrxNn4nzJv27O0r5lvUyPXkwMUnX3nJL114c377iOHkRLNg4nv/jKZc27lOJuCSzsl30PjiHARrNaGup8Saj9BDzzgoongFLDZUDGZ3puXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaxAtJ9jhnTP5B6ZO5fHREpX89X5xjJXI67Yhfl3XnA=;
 b=La4EKZcQcF7tbHS55lb9Z8xqPJBv/+FmmIwstotKJqIx/ZZCFbfbhrSNCB48575hLiARkQplvnRF6RaEPe2q6lKJkjzBOFiU1EkzAFvesz4d3aRm9PPIUEaATSU0RNE3rOPXJ/uK9SpwkwTmQBEU6ahWbNF86So4DvHzV6Zp+6WCX8E084s9t8TSjczG5B1pKFobpcgnZWeTh1AEp7NT4wxfXUbN6Wu74LdixbGmUELs0AXatv3ql6xcw7f2fVUMxURoGXltKdALhgzibZYEtgHDR7QKgmujd3SgGrjbzOYkY4GTt6i9FQapyMf8/KwZcmphwa7/k8/tpQb9VMnaQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaxAtJ9jhnTP5B6ZO5fHREpX89X5xjJXI67Yhfl3XnA=;
 b=qnSyLaJjw09PqTpsJsaPszEnE5eJf3bmG7P0xz5IocZeHIlJw8HBkx2gALv312Y+P7BJM3w0rgEAqOSBkAVEyWNL5rglzGtWeE2YoGuN71mHVfQpccZA/LjCIf817N7V73AJfpWh6hBZBsfTpZEohS/sYeoKZDJeEbzUgRXUPpMe2GsWBHi9k+pwjzAO6OCu6P+3HOM4THqzxpBBvedFtF/KgqSffdY+NSxKI9tMpBl76oq7jR+luEjEmtZce+lCGIOwoH4XedlyBom7fsrIscuWPOV2Ow4EZweV+xjtkElte7ydAYcC5+GW7rnShiI69Dfo4pBlpur/6WrSaNRoiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB9291.eurprd07.prod.outlook.com (2603:10a6:10:44d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 16:08:49 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:08:49 +0000
Message-ID: <f609436a-dd4a-43ac-9259-384d3695e709@nokia.com>
Date: Wed, 15 Oct 2025 18:08:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Highmem on AXM and K2
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <8f104eba-6805-46e0-90da-232ce18973c5@nokia.com>
 <9ac3eb75-efac-4f3c-a3e9-6953db4babf8@app.fastmail.com>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <9ac3eb75-efac-4f3c-a3e9-6953db4babf8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0688.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::17) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d282f4-d1d9-43f7-8884-08de0c05204c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWRQOFFTL1NPNjNLRU5GaVkvNTdCazFUdUQwZlZoR21JZFdMQnBvRE9CZGh3?=
 =?utf-8?B?YWZsYTRCY1NPUVV1a0FCdmIwTE92R1l0NHpOaC9QMkw5eXB2QjlYTVYxSWNH?=
 =?utf-8?B?YTh3Uk1KclZxa05QbEJyUVVxTzZIOWRMZk5FQ1kwN3JLWFhRc2JSdmo1Smds?=
 =?utf-8?B?SVBETlFDQ0p4ZE1IVkh6OGV3YXh0UysrMTFXUU11VS9LSlJPWTBjMHY4WW1L?=
 =?utf-8?B?YWxuOGsrL0lMUGFGLzdSbkt3Vnk0M3RCZmZoMXYvT3BLSGtpdldaZWxFbTkx?=
 =?utf-8?B?blJmQUpMK0dYMEpLM3M1dmdzdnJHWXh4bGo2eUlSdzhrS3ozN2ladEF6U0JS?=
 =?utf-8?B?L3lBdUVsVDZYV09LdWtrd2xHOGFFb2tTdHJtNXcwVXFpdXFpMTUrUkl3WEFp?=
 =?utf-8?B?c0FGSnNETTdRd09CLy9qdHFmUmZWd200UGsyVkIxcXdGOW5ZSXo5Y0JYSDZv?=
 =?utf-8?B?NzlPekZDT1JCRldLNGQ2YU5Dc0NZRmZMYjNWUDNvajJXa0xnSEJZWi9FWkFJ?=
 =?utf-8?B?T0p3MmJrYlJlVUpZV2tRbzRxZEFOL3FUWEYxZG9TV00ySGxra2p2NkJZbXZO?=
 =?utf-8?B?S0dXZGZzM2hYb2hwYm1rNlVlK2VCOFlrMHNKMFdhU2E5L1FVTWlXQldHSVRI?=
 =?utf-8?B?bDU0aUUxQ053dWxiWHk2eVh6WGtWWEpnT2F4R2MvaWNkQ3Bqb2pMWDNLTGcx?=
 =?utf-8?B?L01PQ3hFMHdaWFRZWUxrK09BUDMwMWdYKytQOTgzUFRjeklMTDRkSkxWa2R0?=
 =?utf-8?B?Wi9vWUk4S1R4Z1NIbE9CTktneFdsWDU2R2lSZmtWbXdIK2dCWFRlWCtINXlM?=
 =?utf-8?B?UExjUzRiSUhlTCtWS050WXFVQldzbGczNGFHOHpuWVJUWTcwS2JLZXRuaFFE?=
 =?utf-8?B?ZGxSWlRIczVxOXpKL1hPa3hIWTZhSHFuYUFsaGd2K0FmWDk3ejdYMmI3dm55?=
 =?utf-8?B?Y254RWVXdExyTmRMUjN1b0ErckI0c2ljek5xSE1NQlFyQjlkNmZ5dWh6UXBR?=
 =?utf-8?B?dExDbG5SV3JFcmUvY3ZrS3NpbHlVczFXTk1GSzNZSnN4K0hUakw0QWlpSENa?=
 =?utf-8?B?TlVQaEZGcDV4bnc1YVRJTGNiSWZHVE5IallsdUU5NS9iWjJldFZWMmk5RS9l?=
 =?utf-8?B?b1FtOTJ3cFIvNjZOTXUzUGY5RXdSaXFJNTJMVGE5V0dtc0pEYzFaZDVEYVg3?=
 =?utf-8?B?OTNySVhSY2djc0hhNnlMbmZQZTRDTm9QR1EzLzZDS2JSRHhxUzNRWXZPNzdK?=
 =?utf-8?B?OGJReFJHZUNzMHFtbzVhV2dSVEhhMW1IL1Rrdml0VU1DRmVTaWxJS2prRG5o?=
 =?utf-8?B?WHVUdndkZUg1Ullybkw4ckpEMDZCTDRSQ09SYUFEUDF1OW5BR05LVmE3a3Q4?=
 =?utf-8?B?cVRHUHVrdDUzKzMrZVRXZlZpeGZtNm5aKzFDOU5KTDdyMXNhc25vYTBseFRj?=
 =?utf-8?B?YVVlaWNDcU50dTVrUW85VDNsU1pCdHRaaFZQWWxPNFA3clNqQlIyZ0hwaVE2?=
 =?utf-8?B?ZWp2TVVETGJRVXdzN0J2U0lXZ01yYW40dWtqcWdFMlphVzlCZUVSemd1NXQx?=
 =?utf-8?B?NUpmZzFWSDQ3cGtGVDRuTHE2aUVyU3FxSW0yY01SNi9RNWhFK1lna2RyU1JJ?=
 =?utf-8?B?eVVqd3pGd3I1YXpJWGd6a0ZvOVdmeHdQc2RMOW01VndSUmpNcEdON2RKWVFB?=
 =?utf-8?B?Q2IxMVdMMTJ5MDZ2U2J6eVhWdlVNMFovL3NSdGFURGJBdVgwOE13SnowdktF?=
 =?utf-8?B?d1lTdmx3bTgxNGFHYXlhUXFhU0QzZTlsQW11RU0vM2V2SXRSR29Eb1NLVVc2?=
 =?utf-8?B?WUl6VEsvUmIwOWJMMWhVRTNyM0dzT2Q1Q0tGekF5YXNZSDBqRDYzNFI4b09S?=
 =?utf-8?B?cm1EeVpHbElkZkZwWUVhdjN2WWp3elhSL0FqTVpKRktPUlU2SzF1dnJxakVt?=
 =?utf-8?Q?lUxqClWX3V0BcuK7ns4g6jt+a9tgU8zB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDVxU3Z2S1lyNzlsdmk2bVNrTG5RQ2xIQ3ZZbWNwSVZScldWaWt5TE4yU3NK?=
 =?utf-8?B?Y2s4Qm9BUitvbUNEbDNwL2ZRV09LQnp5VGFMUFRkcDRCQ0c2enI0d2lJbHJp?=
 =?utf-8?B?cTBFeUsvbnNHQW82cDFxS0wybUYvTG96YXA0dnFjSkhtdTNGbU4zZjNQakQz?=
 =?utf-8?B?bDJJMXJBV3lJSmhIWnoydTBSeWJJMXhYekxyTXE5Q0JIREJsZHpSNU1XQnBR?=
 =?utf-8?B?enJVMjZJMG05b0JxcmE5eVRCVkU2RlN5dmFWRDZ2K2YvM2FYVWRZbE5LOWZ5?=
 =?utf-8?B?ZW1oNDFTNmJNU1JxaGtJZWZHcXRWNzhpUnVHL3hrSGV4REY2VWQvdWZ1anRI?=
 =?utf-8?B?M3o2Tk9mbHZiS2tYUHdrcjYxZytuYk1ocThBazNMREE3cURKbTlmVHU1SmN1?=
 =?utf-8?B?Yy9wSEg0azBLVHgvRVpadkhnSGpSRUFkNzJwRkdiVmwzREEzc1B2cXRPbENC?=
 =?utf-8?B?M1pwMHVEcXI3MEJxVFlmeVI0cldQSWV2ajdIeFpuZUliSklMeDdaem53U1dV?=
 =?utf-8?B?Q2hGMWg4VjJ4RDg1MkhJRC8yMjNKZE1oaitmYTU5Z2hUQktVME1SaytneFdR?=
 =?utf-8?B?N3NMR0d1YS9RRlpYZTUzRmR6Y01oTi9iRzRCZ2dTNXpiZ2FjMWh1VGg2K2Vn?=
 =?utf-8?B?OEwzUU1KY0tDMzBCSlc5MGFJNWJjK3dXK3kvYnRJM1BwYVFvUWdiTm04QnFl?=
 =?utf-8?B?ZUJHVm9xaWdtYnp6aTZIcTF4cExXWUIvcnpTRjBKNWNMTlJ2RGlQSS82WkN3?=
 =?utf-8?B?K0ZjRjhrazY5bFQrSWhrTjVidjFxSUFlTlB5anlZOWVLMTFBNUx2MVMzTFA5?=
 =?utf-8?B?eHdJcGNaSGtWb01zY3hYcFZpWDVLQnptbnM5Zk9QRGhyUFd1bnVoNnJKUmZh?=
 =?utf-8?B?eElhU1U1cmdGRzh5M1RZcE43dkFzSkR4bkg2K2loOHczSTRJbnlsTE1JT1lT?=
 =?utf-8?B?YUQyMXBDbzBHZTAydEZqVW82cTR4STBiNEo3dTErZDJ5Z3dockUrYkk2RjhV?=
 =?utf-8?B?YVJ1V2VUR0NHVE5qclJLeGJsbWwvQTV1VHpDbWhuc01sLzVHMHplVDN3eTJO?=
 =?utf-8?B?dURaa3VkL255ZENPbVZUdllvWjVkRUtkY0U1MDNpZUlkM2lMYUFyakxHREQ5?=
 =?utf-8?B?U1g5Szg0NzA1YWZvUmJPT2pkYlU2SklrZzRiYkhoanc5ZW9vNFlMR3RicXJ0?=
 =?utf-8?B?K2ZVS0xhTGp2SGtQN2phaTZENlpaOVE4YWx3Y0FxcjB5Wk1PYlk2cFo0M2pT?=
 =?utf-8?B?ZGxyelZHK1kza3IzdlhmUXZjQ3hleDdqak1kYWd5YjRMWWZHUHEyL2FYZUpJ?=
 =?utf-8?B?azRKY2Y2Z3VMY3VPcloxMStLME9BdFpGY1dRbkZiL3F4SlUzbnNDYmlLamhz?=
 =?utf-8?B?d0pVN3Z5M2cydGlialgyTytqcEloTU9JZ1ZFVWk4ekJhTGMvK2VnWlBPdyt3?=
 =?utf-8?B?QjNzZGs0UW84Nml4dnZpNnhVbUZNVGREbFlNNXdaU1R3QzAyOEdzeVg0Uko5?=
 =?utf-8?B?L1Avb2s0d1BFL3dhM2VIVXFOblFzN0U5L2Vpakhza3R6b2g0aVhyTFBXYzM2?=
 =?utf-8?B?dUhxbS9wVmZqNXNQNml2SW5vUGRqU3VHMHUwOUl1WEdPemtNdVEzK1VrTmVz?=
 =?utf-8?B?Z2NTcCtSZmZZZXJncUpORFNoYnhUSHBRVmZkUjcvQnlQaGVBS3JTVG5weEdk?=
 =?utf-8?B?dFZwdW9DU01NZHZnM1dJOXBiaWVhMzhrRmJYSWtnRVVlY2RDVFVycUNRY0gy?=
 =?utf-8?B?RVR2aU84SWlhU3pjTlFzVmNOWitZSmVobDhrRXhDYVQ4VERWenpiZW9IZnVW?=
 =?utf-8?B?YWxja1NIcHR0elhKekdlcyt1UjNBbi9GajBNOXdiSUxLM1dUTXFFZXRRSkd1?=
 =?utf-8?B?cmlaem5XMFdSS2txdi9YdTJuTHM1YmtROHhwcnNZeDM1Z2t6Uk0zK1lmZS8x?=
 =?utf-8?B?aTN4Um9MMU1BZmVPN0ZCYzZTbGtCQzNVUUxzS3NwZXNqMmJycGNJdmx6UlQv?=
 =?utf-8?B?VG4wam1FWk01bXppUHM4bFcrV0tMQlBBa2FCaUJNV0xYSDQzTGZmRllIc2RX?=
 =?utf-8?B?OTEwbElMcjM4dmduMW9BaFJlT1owcXNYUy9FMDVKV1BFa2MxZWJLbDV4aFF3?=
 =?utf-8?B?eXRhMUdnNXJCTmN0cldwNUxTaVBEZndXTWJOTmF0Z1ZrSi9BZTBBL1ppM0tQ?=
 =?utf-8?B?dUpkSVF1a2Nia1ZROWI0bkFWVUJvYnRBc3JuOHFQOW9mVVFrR3RYRzMwV3p4?=
 =?utf-8?B?QjVRRm0rL205dTlST1B4aHdocWJRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d282f4-d1d9-43f7-8884-08de0c05204c
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:08:49.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ko4lmtRwBGV3MrCyaC4mgZ+cGQg7sXXfAu9J6b1qvJqgMdXwGtP422iDmIEYzkJDfXC4oCfnMp76Afg0pmUxrAKcny5v2XpYYSNuFf0QWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9291

Hi Arnd,

> Thanks a lot for getting back to me on this!

Thanks as well for your comprehensive feedback, and sorry for my late reply,
I've been on a long vacation.

> Ok, I think this one is fine for the highmem usage at least. According
> to our current discussions, we'd likely start by reducing the references
> to highmem but keep supporting it for the page cache. Even with the
> earliler timeline I posted in [1], 2029 would be covered by the LTS kernel
> that gets released in late 2026.

Ok, thanks for confirming on that!

> The other problem on this platform is that upstream support has been
> abandoned by Intel a long time ago and as you know the drivers that
> did get merged are incomplete, so you are already on your own.
> 
> Alexander Sverdlin at some point in the past considered upstreaming
> more of it, but that never happened during his time at Nokia. If you
> or someone else are interested in improving upstream support for the
> Axxia platform, that is still something that could be done. I know
> there are other users interested in it, and some of the original
> software team are now working for consulting companies that would
> likely offer their services.

Unfortunately, we have finally abandoned plans of upstreaming AXM last year.
Almost everybody who has a deep understanding of AXM (like Alex) has left the
company in the meanwhile, some drivers are not in a state that would allow
upstreaming without major refactoring (to put it diplomatically ;-), and with
the EOL on the horizon, there is not much interest from the management side
either anymore…

> Can you share more details about how exactly system uses its highmem
> today? In particular:
> 
> - The physical memory layout, especially whether the memory
>   that is assigned to Linux is physically contigouous, or if
>   the memory owned by other components (the network processor
>   or an FPGA) is taken from the middle. Note that at the
>   moment, any memory that is too far away from the first
>   page becomes highmem, even if the total RAM is under 800MB.
> 
> - Is the memory mainly used for file backing (including tmpfs) or
>   is it used as anonymous memory (like malloc()) in a few processes?
> 
> - If most of the memory is mapped into a small number of
>   processes, how close are you to reaching the available 3GB
>   virtual address limit in those processes?
> 
> - If possible, share the contents of /proc/meminfo, /proc/zoneinfo
>   and the /proc/${PID}/maps for the processes with the largest vsize
>   (according to ps)?
> 
> If the largest process needs more than 2GB of virtual address
> space, then there is not much hope in changing to CONFIG_VMSPLIT_2G
> or CONFIG_VMSPLIT_1G. On the other hand if your workload does
> not rely on having all that memory mapped into a single address
> space, using VMPLIT_1G would likely improve system performance
> noticeably and have no other downside.

For some of these questions, I'll need to consult with higher layer application
developers first. I'll do some investigations and come back to you on this.

Kind regards,

Stefan

