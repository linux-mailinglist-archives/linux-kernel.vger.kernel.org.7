Return-Path: <linux-kernel+bounces-858139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FDBE918A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BA1189DB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8A036997B;
	Fri, 17 Oct 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mYb4vtrG"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA22F6911
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709940; cv=fail; b=UxBpa4rmwcM+GlLcmKbu4Z2uBTsTpVhUTg7DgMXMK5M1tNiTnjCERypS9CY2bRdGpGD228KmbtIXDlI+o2b0NJypix0pgtsrigYX/4ZVLkfCWbxFGE4pRkP4x/3kEVRyTgcLCuNsUC33vF794e5/7QDd62D3aQn2p8AR/EoC0ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709940; c=relaxed/simple;
	bh=NO8X+zlEdDnbEqUhCt+zerGbvQW2aanqGRMIyfNUa54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uwksXd5uOs3qY+ghbPfPufImHC3XJPu7vacUj/oMW/GkzY/qw2YdqIxOmgb3qLOdUaP8rqG4UX+1nmK58Qvu3vf+rwsQf8WBBZHMDy+mUNz2SVjTeyYE2q0QDBbAiH2otc/GLtrrcritAT9eDla9K3eI7neBoJAyxw50QeH+zZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mYb4vtrG; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPMPgdtkcIC/ghcCDBFIwghfYKKg1G5TcGtfP8j03//SgIgfBXx01GuwbDMN1QnHRG1scXTLC5apeOW1ZgP+Cv3QtPsqIfeC9RfcEpuQOOIA7+96JYuaRJtAtFD3JvCup/jz/m2+gQpqtvAc9CFjAh0Wpn6GHDgMcUTy+eYsxGnPYFb7so7FGjM692h0II6at8t+MJ8PbcO1ATevWzuttmZPcdwq06ZAk/wrXcveKh2rg5DJhbfOXmQeB4qXMtrRmKCBTWtsM/Y72D0aLGTMD5ZvJKkb/BZighlWaB9nX8jdisA5sxFFCsdaK6I78AUOp2ita2TJFoMi2TGNUN2YMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO8X+zlEdDnbEqUhCt+zerGbvQW2aanqGRMIyfNUa54=;
 b=ALCA6CJKNo09qv3Qwh+M2y4MHrD+ZRjlkj1ixGIpNjBE1hpkSln43tExvgRow89cgi0nIsjAemA7NMVR0y5zpNn7AT7HowgpcdRiAdknth2DIRakpusUUW7B1G0HWDrBct3RsqwtggsJLDmf6qXnchc5OFGIyK9JcvObQz7CpFC2SKjm+NzDBO+TKdkXUg2mMcqlOzB7xajYdtcC67yt8LoVl2F0ZsWdezcpLBdKpsBHk6OP7M6OhkwpKWlOM11Z+iO2NxSMEBEGNiXTbihFP7V7Ci2OTCnGqu7S+nFz19OHPfVJVYD/7Qufr9WaGtBujpftIkidW6RSobWgYddSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO8X+zlEdDnbEqUhCt+zerGbvQW2aanqGRMIyfNUa54=;
 b=mYb4vtrGs4QqYYr7esQLiP6Qks+jDlLL6DMc9/jGZhqLYGkEDd9HQvL622IOZ02/P+dmuHENYJiSuoOX34EbkCVcqWsbfeqexLgLRdG/zwMGlVQFXsUr195ZQnE8TIFWH8ufsVaKxuvlGwlpNF6/mo9hH6bLGJG9JxqtVMx4ZtQ=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:05:35 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 14:05:35 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 03/56] cpu: Reset global mitigations
Thread-Topic: [RFC PATCH 03/56] cpu: Reset global mitigations
Thread-Index: AQHcPuSmgZjhqZAw90aoTx01YlegKbTGYD3A
Date: Fri, 17 Oct 2025 14:05:35 +0000
Message-ID:
 <LV3PR12MB926591EA45E7186AA3BD2A7E94F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-4-david.kaplan@amd.com>
 <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
In-Reply-To: <fxgzzp3yokq24swgfkokdnqb7jf53s3na2wjitr5koiamfizgm@d7uvxnuzkebd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T14:04:54.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS4PR12MB9772:EE_
x-ms-office365-filtering-correlation-id: aa2cef1b-7cc0-42d2-9c4e-08de0d863e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aytiK2M0bWw1LzFZMDM5Z2x1UHk1TkdtRVJDSVp4NVVNVXhHU0ZYWHhKTWNO?=
 =?utf-8?B?ekttZHprd3BteGl4MC9DbnNaMWhxV1ZYUHA1dUxQRmMvTHBuQmlUUks5NER5?=
 =?utf-8?B?R2dTeGY5R1UvVm96VjlhKzdqVVZDT3lWeHlzTWdjMXFqLzZ0QUxNckNVOTcz?=
 =?utf-8?B?NkQyNjYrUit6NXVFUVYxL1dTd1IyRWJWNzEwNjJNTHMwVVBxRDRKZ3JrWDdx?=
 =?utf-8?B?ZGpqRkhic0d1UklqT1lLeHVRaEd1TUVOWUtKV00zTVNDMnBMSEUvR0hsL3pQ?=
 =?utf-8?B?T0xRUHl4cnluekVnNjJLdVZFYjllK1VKZ2FnY0J2eUlzY1N5Mm1jbTBUd0I5?=
 =?utf-8?B?Z3lJa0xBRTFkbm93WWs4ZkU5KzBRdUtrdllLeTkvQm1NNDZ2N3U5L3E0SlFP?=
 =?utf-8?B?WlIwUGVWMnQyK0NySDROTFdmdW00VzN6QmZWUFU5YlNZTXUzUVBGRUNIVGh1?=
 =?utf-8?B?SitteXlFY0xMYWt2dzFZeWJ2dTNsQVc2SDNKeXF4ajk4VEtINDN6b0cxMVdK?=
 =?utf-8?B?dE9KWW9udDUvU2svN2VFT1JuSTNjY1FhNy9udlkxc0ZYQ2tERVU3Zkd3Rm43?=
 =?utf-8?B?YXpKV2J1aEtpT1cyM1pIa0FZakN1UnFHamRGb05EcnFiVjRqNWd2WGFWY3F1?=
 =?utf-8?B?NWVwcFNlcGxZVFZkMVE0Wjg3TVl6dnZtL1BFd1hmYTV2dSsreFo1aWo1TzdC?=
 =?utf-8?B?RHlFYlpMVnlmWW52K0ZrV3BOMzNFVVh2SEltZnRrbXEycHNnb0tpbThSQW1L?=
 =?utf-8?B?ZzNFcVRHcVBRc3FaVjFaNnlLamVwRGg0K3BSbGtWNVFTa2R1dk1hWWZjcFpv?=
 =?utf-8?B?Qmpac1ZKaFluem5DaHlDNThKWS9nZkNGKzBDVlJSdGJEb2xtTEZFY3BjSEU0?=
 =?utf-8?B?OXVhUDM1dVp3Q3ZwV1VNR3FBMGFkRHRQdzJqRjlLMWo5NDQrVlhPa1cwU3I3?=
 =?utf-8?B?bEJsL0lnVDFlSG1hejQySnlyaTU3SkFieDZPdzFwc1RENExsZlFvd3kvMWpv?=
 =?utf-8?B?Mk9ENFpZZW9wcStucDd3dkdYRm0vQi9qZFVzMEhvZ0VUQnhvbWcrUFh5bHVV?=
 =?utf-8?B?RzRrZGkrZTNDYmdaZFZBMXpWUFdpZFN4dDFhLzlpdTd6YXZVWFVxSUU5ZUtE?=
 =?utf-8?B?M1RzYWcyK3JZK0grazdHT1ZMK2d5TEFleStIYnU0Zk5aM0VXajhGam1INThI?=
 =?utf-8?B?ZHNpR2NNdm94WGRYMG5SdWZsWm1iTlhLSERZOWNhdXpVbGUvbU5nUGZEbFlF?=
 =?utf-8?B?UWM0UUU0OEg2aUFKT24zZnZMMm1UQm1UeWVJaWdGUnV5ekN6bWc5c1ZTaXJX?=
 =?utf-8?B?dnNjSzlLa0FnekswemhnTjA2dVRGdFg1SE9IUXZ6VTdxWWFpZjVPdmpoNTdD?=
 =?utf-8?B?aVRNQ3R4TENZc1gvS3FzekhkRVBxZVViM1FoOFNZTi9pOTBxYWs1LzY3SVBz?=
 =?utf-8?B?eE1RYU02SkVoSlpxdzhuc0hxRTZ5NFVjRUZkTVZ6N1ZraUxVdmdCOXJJT0Rw?=
 =?utf-8?B?clNFOFc1M3pZZ2lpTXdSQjZYYkVrK1c3T0ZtTVUwWURwM0Z6YTVrWUM3ckhr?=
 =?utf-8?B?TUVaYVdUaDRPWTdGdW5GWnBQLy9vZnowZ0dVUVRwMUFuYkdHQ0VRbzNGZUVj?=
 =?utf-8?B?bEJsY1RnbE00ckNQK2U2blFaWlZRc1hBV0x6cXdybGRWVnNraExleGdVaDFt?=
 =?utf-8?B?aWpMem1ySG5XYlFISjVLSFdnMkFKWUdOS0h0MUxTVnJzS1RrZFdDVDEwODFy?=
 =?utf-8?B?d2xGZnoydmRhZ2VQVzJCdWtuUWtyQ3MvRGo0MDRCTGRHNFJ0SjFsVmgwV24r?=
 =?utf-8?B?am5iU0N4S3kwcG1ZTm9NSU9yOGxLQXlRN3JSVEt4ODlzM1ZYNU0wMTNmandB?=
 =?utf-8?B?WjR4T3RaanZsa2lHTFpzK2F0Y3phU0k1VDhwTDlDWmNNMTBOVUF0dUdXdmh1?=
 =?utf-8?B?cXVCcUtibWFvc0UvWjVtaUkramd1ZjVnczREaktXcWVhcTJUbHMwNis1ZG10?=
 =?utf-8?B?TC82RlVOdDExUFptV2JscSs3TU5hQllxclVPUWw3cGdiQ25kZlZrUHlDU1pl?=
 =?utf-8?Q?eA1x92?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHBoT3FBU0Q1UlZtNlRSRVZEeXc1N2lBdkxlNE1KVU9CS3hhTWJOR3doYW9Q?=
 =?utf-8?B?dzNnblNVWXBKUUY0Zk5aL0VPUFk2eUIxMTRuL0lTSE5mN2xJU2Yva0RsSVVz?=
 =?utf-8?B?MHVRWDZmV0k2WjZnQTZhMHlPaHdNay85K1pqQ3RiTFdpSkZhNFJnMTdSZVM5?=
 =?utf-8?B?SlJYdG0yVjIvbmNGSkNPdVpMSG85ZVY3SlhJR29TV2dJUUxpc2JCZTIrbXho?=
 =?utf-8?B?T2VGK0dnaDlCVXFMKytac1JFMjdXMmtmSDBHMWRBZmdBb3RFVFVsZ2RkeDIv?=
 =?utf-8?B?MTRqeldld0dVdkowbTVCUHhaRGFqMFM4cjE0MHI5WG04ZEVjd3hhT2RMWjd1?=
 =?utf-8?B?MGtjTlpiQW9Ib3kxSjhWUEg2M0twdERJMlduYkx0OTZjSWdWMEdxTnJZVThu?=
 =?utf-8?B?S3ZnbVVHaEFuODFrdzJoU3plb3orbDhhdktlaHRqcW4xNnZ3aUM2MWx5YlVM?=
 =?utf-8?B?TDhhL2Vxdk10aDFNVk55WU5DeFltZk9VSEFRS01qMHlSRVRiL0FNbjU2UFZW?=
 =?utf-8?B?d2ozMnNEZ0dDNDdZRFhKaFZJMnVzYWYrUTB5anZMOHVRcFVhaDgzZFlJNndP?=
 =?utf-8?B?NzRFTzJ3c2piK1ZFVWlFMlRPekVIa1hTOEFyRE92anF1Ums1b1JSYTFpUVUy?=
 =?utf-8?B?a1Zydk9NaW9MQkQ0OVVwT2wxK3E3TE5mczV2dklVWEhVWnd2VUllRzZUN0pr?=
 =?utf-8?B?aFoxQUVpc21HenlpS0JnZU9uU1pUSXczdDdZNjNzK1ZNanBpQzVEdC9EVkta?=
 =?utf-8?B?UFNpNEl0djhuV0dNM2FqaFZUU0U0N1p5WGxrWTlQNTBTOVkxTk13TTY4WUE3?=
 =?utf-8?B?RXVTU2tuVDRodlBlZit2a2QrZ1ZPNTFUN3NtalBFQXdVZUIzd3RMTWlGNkNL?=
 =?utf-8?B?NlY1OUNCN0pTem5wVHpYSS9BRlduYzhWNEFDbE84ZGVWdWpnK2tMVHR3TWVN?=
 =?utf-8?B?cWhDaTJjY1kwUEdsajBWdzZPMnJCVi9YNVVEZytCMGsvTGFwZVZRanpCK2NZ?=
 =?utf-8?B?QmtOQnlURU1tT3pJL215WklyUDI2OUxadjF0bUlzZCt6T3orWktMUUxSMlZi?=
 =?utf-8?B?QkIrdHIwN1dhRFFtSERwYnpIcVVpaWhEKzJLeHpNcVd1R3lUUVZoQ05OYVpL?=
 =?utf-8?B?czlzN0xSR1ViU3ZNMnZBbmFWdFFHU1gzc0p4S3JuU1ZxWlZYeXRqdjd3RFUx?=
 =?utf-8?B?WUY3ZUZPa1NTNTBXUGFiazUvQ0JFWVdGRUlXNXRqZTVkMkZPdFZ5Q1ZtRmg2?=
 =?utf-8?B?b0dUZXhJWVh2b3U1UENNbnJra1cwbzlvRE5sM3lOeU9kSTUwemVnWkEyUTNj?=
 =?utf-8?B?Z3prbW04dDJRNWZTclB5V2ZhTy9UYlJFK2tDL0VFSDNaRmRjcU9tb21oUTJK?=
 =?utf-8?B?bjlWQlRLN2tIaHAzV2cxZ3o5YkhhQUtZT0xtbGtzZVE4VW83dVVLSHBERmpt?=
 =?utf-8?B?dnZPazFRRlk1TlprL2tVdXorNVNqSGJyZFdpS1VaQ0Y3TnNVZ200UGcxZ1Y0?=
 =?utf-8?B?TUJ2eWdYQXVKNmNldXFZQVpLSUN6NjlFd3pTYmt3eWVhK1ZHVU16WXBzTTBG?=
 =?utf-8?B?NkpCM0RyMDZXLzI0UVdiNFgzM1dQN2t2M0QvY1IzWVRMeWNqdnVRd0xhcTZC?=
 =?utf-8?B?eGt1amw4SVgrNEJFaGUyOVg2YlZPTXc5dTRCeEU1Zld2M1hhMVIwZWpvVE92?=
 =?utf-8?B?Tzk3Tnppek0ybExJd2dadlZRSUdDM1BVQUdwYzNIc3cvYUdIUHowakhxSGt1?=
 =?utf-8?B?aDM2bjVQSG9wbjVXanZwbnBscm1aS0xIY3ExRzJLaVRhOE00SThUKzliZ2hY?=
 =?utf-8?B?ZkgrRG1HaW85QzU4dHpQdC95a3NqZzdiSGw2R0pUb3U0Wkx3bUxCS3JJbHUv?=
 =?utf-8?B?akhsN1FLRy9JSWlldkpZK01SSEs0OEdJK3l5TVdacHZ2YUczbUpXQ0UyUVEz?=
 =?utf-8?B?Z3dSWHBRTmZOb1pyZEdIZ3ZCTS9abGJ5NGFsMkxKcmpHZmJjdFVJMEtkRFZ2?=
 =?utf-8?B?amN0YVdjazEvLzUvVXZTa2ZvbVBEUEJkS1RtaWJyZFczSzQrSmhmaElTRktr?=
 =?utf-8?B?Tm5uZWZrZEVPTkxGalFJTTF4T2dINHQ5eDdCZnNacHVwOG1kSlU3M3RFUFA0?=
 =?utf-8?Q?Mzpg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2cef1b-7cc0-42d2-9c4e-08de0d863e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 14:05:35.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fFtBdf33ru90ughmZh/vQrD1I5jFrrXGbSkfJh6kGLOoCombBL9ece+LHdh9Ipj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTYsIDIwMjUg
NDozNCBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92
c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDMvNTZdIGNwdTogUmVzZXQgZ2xv
YmFsIG1pdGlnYXRpb25zDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZy
b20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5n
IGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24g
TW9uLCBPY3QgMTMsIDIwMjUgYXQgMDk6MzM6NTFBTSAtMDUwMCwgRGF2aWQgS2FwbGFuIHdyb3Rl
Og0KPiA+ICsjaWZkZWYgQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMNCj4gPiArdm9pZCBfX3dl
YWsgYXJjaF9jcHVfcmVzZXRfbWl0aWdhdGlvbnModm9pZCkNCj4gPiArew0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICt2b2lkIGNwdV9yZXNldF9taXRpZ2F0aW9ucyh2b2lkKQ0KPiA+ICt7DQo+ID4gKyAg
ICAgc210X21pdGlnYXRpb25zID0gU01UX01JVElHQVRJT05TX0FVVE87DQo+ID4gKyAgICAgY3B1
X21pdGlnYXRpb25zID0gQ1BVX01JVElHQVRJT05TX0FVVE87DQo+ID4gKyAgICAgYXR0YWNrX3Zl
Y3RvcnNbQ1BVX01JVElHQVRFX1VTRVJfS0VSTkVMXSA9IHRydWU7DQo+ID4gKyAgICAgYXR0YWNr
X3ZlY3RvcnNbQ1BVX01JVElHQVRFX1VTRVJfVVNFUl0gPSB0cnVlOw0KPiA+ICsgICAgIGF0dGFj
a192ZWN0b3JzW0NQVV9NSVRJR0FURV9HVUVTVF9IT1NUXSA9DQo+IElTX0VOQUJMRUQoQ09ORklH
X0tWTSk7DQo+ID4gKyAgICAgYXR0YWNrX3ZlY3RvcnNbQ1BVX01JVElHQVRFX0dVRVNUX0dVRVNU
XSA9DQo+IElTX0VOQUJMRUQoQ09ORklHX0tWTSk7DQo+ID4gKyAgICAgYXJjaF9jcHVfcmVzZXRf
bWl0aWdhdGlvbnMoKTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYNCj4NCj4gQ29uc2lkZXJpbmcgdGhp
cyB3aWxsIGhhdmUgbm8gZWZmZWN0IG9uIG90aGVyIGFyY2hlcyAob3IgZXZlbiBvbiB4ODYgYXQN
Cj4gdGhpcyBwb2ludCBpbiB0aGUgc2VyaWVzKSwgc2hvdWxkIENPTkZJR19EWU5BTUlDX01JVElH
QVRJT05TIGRlcGVuZCBvbg0KPiBhbiBhcmNoLXNwZWNpZmljIENPTkZJR19IQVZFX0RZTkFNSUNf
TUlUSUdBVElPTlM/DQo+DQo+IFRoZW4gdGhlIHdlYWsgZnVuY3Rpb24gY2FuIGJlIHJlbW92ZWQg
KGFuZCB3ZWFrIGZ1bmN0aW9ucyBzaG91bGQgYmUNCj4gYXZvaWRlZCBhbnl3YXksIElNTykuDQo+
DQoNCk9rLiAgSSBhZ3JlZSwgdGhlIGZlYXR1cmUgZG9lc24ndCBtYWtlIHNlbnNlIHdpdGhvdXQg
YXJjaC1zcGVjaWZpYyBzdXBwb3J0IGFueXdheSwgc28gdGhhdCBzZWVtcyByZWFzb25hYmxlLg0K
DQpUaGFua3MgLS1EYXZpZCBLYXBsYW4NCg==

