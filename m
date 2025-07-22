Return-Path: <linux-kernel+bounces-741002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B0B0DE74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D059E7B78B8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18004176AC5;
	Tue, 22 Jul 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FH8bHCgn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79920A32;
	Tue, 22 Jul 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194232; cv=fail; b=JH9swK7lvHETgp9Xtdmob4ZWYW0urWUo1XI6BD94t8VZd4s5bDCZ2VMmU/8dlMnd+1eTbSPtghqCEermC71nqlynpCVnRvKXSQXdwJ63L2b6EflfrIDNwfizXk2ZpH4NNjUp18+uSxPO9zbm+x8708KXc1EFBUESwQuKyMG4hTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194232; c=relaxed/simple;
	bh=qaH5LQSpYLgW/U+RhEdZj3FG+t9V3hinhopUpqtseBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EsMF0SGLBQB0ggpO/6hBlWxa0eHdleX3BamJDXyTxJB4/DXYQCvFcS8PyaFf+wWm865djDRKDlhv56wDJSpXiefbjHVsIWFIRGPwGDFhH1WD3npKOSa7vRqksTL2e64pOGflfatg8yFrPq+ZsoEgsSp7hGsDEUmejrnWUoNaJnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FH8bHCgn; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL9R+YpphJd9An0oqUEvNTJYt3bt0QSFS6/Hv7D/NIGzRIbTYXZ1Tqf2RHic6w4KCIO4Y54CvI+6WgUGPHQbX4lslCqCKaakZZh38MVVqwLZalPmcmH0nVU90sjytYPFHdk09d/iAQA8svK+dIhIiagVUp8TlJyflEsAfDsec4cxmfHazAetgWr4x0jOnb6jMJ4ijKjozUBdeZhOPztzd3+BgcIzhoFVOYPwmjdZZKj091awMOj90FbMsXMKm20nmkXU4riQiHtnx094lQKEN+A9kDX8BiWZWHsRUYOioHrA19/PoasVstRkltUW6VkmCN++2jVZhgQGiu44ptivpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LtZrZA+aUhDJsh8dCX305sCHWwg/2yqxT4ZCuzIVss=;
 b=R7dLgbn5WCjoA0DXEi6nfayqFAjUI/YYunDJozwAwcaiBZlIVHowkYvhcB7+NGHt3abGtcvxKYOdEFi/JPH1tF1/KqE/LVnF+45MwrrThhoIv7xo0raeWbuU1V+OZo592lq9Qyf1sEqsQfcjpMKZu7C5G7rhNRCDDfnR1BEr/6CPPXrMrL7H9zKRDMCg2gZwietgMC8z9g2WaRuAbfUhMKqMX5L72E/xWzjcHx0e6TcXzcOX6CnicDDCjc0QYOiytZGNPw5EpTL/fQQu5A0nF6jlRHG6oJb6zyp/vTn74ZB6M5M/QVhudyE8GcjbMKwLlrV6Kni6oPlfM/oUL8KZWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LtZrZA+aUhDJsh8dCX305sCHWwg/2yqxT4ZCuzIVss=;
 b=FH8bHCgn+W0Gd3t5snbHRjCHCl1JVUvnXdwfAbcH5RAURt5kdbTn1p5sRmWRSAj8fbQRah1bjSBeMrzz0JVA7KA4O3vXMOQ8zhc/FLZh1xSGkdWQXjl2qtll1aqbnTCXfkcTZcefw5a1I2MfMp2G2mm/yL13ASejhSw04lUOoQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:23:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 14:23:46 +0000
Message-ID: <cd5bc14a-8b96-40ac-bd5f-7ecedd1d3464@amd.com>
Date: Tue, 22 Jul 2025 09:23:41 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1752013061.git.babu.moger@amd.com>
 <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
 <d240b37c-e00e-4b6f-a0c2-267041aaf9de@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d240b37c-e00e-4b6f-a0c2-267041aaf9de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1693ba-6416-499a-f05c-08ddc92b5e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2dCQXppREZUVUVxbDM1bm1PbmpqRGVtNGRUUUhXclFiVUcrVEk5N2dEdVRi?=
 =?utf-8?B?MEJCTzIxdk0zR2NEeWwrbHg5V2xtR1NiOHNXMmMrWU03cHBGTURBaTA0SXZ6?=
 =?utf-8?B?THl4VGZESHdLYWJpRm9BSlJraGJNVVNhME5OMm5CQ0RUald5Y0JzRWtEN1Bq?=
 =?utf-8?B?MnVuRDM2bGxjNjc0ZE8vVmlyMGxsaXVQUkZFSEVWSnp2SGJWRFVHL2UzclJh?=
 =?utf-8?B?eGh2QzhrVUdnYlhVM3BtN0VkS2U0ejMrUWMyUmZrU1U4WitFUEFiSG4vcGV0?=
 =?utf-8?B?S2kxdlVvQkplMk5sMlpjd21Xb01qVUZCbDdESmRlRmhDZE9IWk1ua2lXcDVz?=
 =?utf-8?B?MWxSSC9lQy9Bb0FhdTAvWjg4TGRBL1duWGRHeml3QURGKzRyYS93aW5jQ0dI?=
 =?utf-8?B?eUx2K0pTZkNUWnF3VjJoTWFhR1AzSHVRb2pJQUNUd1I4ZVNZaUNabnhaL2ZG?=
 =?utf-8?B?UjFHSjcyeDA1MWd5UDU2ektjNUhjUldndnpjbmVoemJGek9ZY25mSXYyQitx?=
 =?utf-8?B?RlBYR0hOblBhK04wNG4zV1ZlUklTT25WSERzN2xheDlvdTVNMWZpRFVXenB3?=
 =?utf-8?B?UHZvdk15eUNSUERSZE9VUVR4aUV6VHM2cTc4S3E2UmtabXhpTy81ay9LNkFS?=
 =?utf-8?B?R0J2a2Nvc1BSaFdoYTFmKzhEL2pEcEcxNFdYVlBLbUpDM29CQ3NaMFQ1NEtO?=
 =?utf-8?B?OUROdGRXYkY3MVJYQjJxWmcvd1MyZG9RTnhaQnBrYldDR3EzckYwbHVWN2ZS?=
 =?utf-8?B?QzhSVHJDK0l4ZTdLRHpIMDd0YUl5d0RRRWdVejljR1VKbFBmS0tBelh5eW0v?=
 =?utf-8?B?eTFvVnhySE1aWm9VSm5sNnIzUEZFUFVjVlF0dXVqSzJTWjlXNmZGNlFLcC83?=
 =?utf-8?B?NHdNRHNtTlU4UGhyQVZaRTc2ZlJUQ2ZuYkJXQWgxQ2lOR20vUHRPQjdXZXN0?=
 =?utf-8?B?WFZWOVQwUWFIWkhyc2FZd1BsMmdQM0hYbzVWMjgzVVJWOC9NYi9UUXB0djJu?=
 =?utf-8?B?UzFya2tNMld1SFhObFVJd2ZFSWl0UWV6YUIzeldBMWZ3b0o3eWhZRmJNKzhq?=
 =?utf-8?B?ZXRKU016N2NaMnU3MVppNzRyR0hPbXRZb200U2xKaU45L3MxanVqemJsOWUx?=
 =?utf-8?B?OVd3Z2ZaUTA4b0tTTStZNDEweXhDanNiRytvdEMydENkMVdjYWNpUTlkR2JK?=
 =?utf-8?B?bWxhZy9mZDlhNTdwK2tNWnJZYVBSSlRZVWp5Sms2dkN0S3lIZzhmKzFRdDVi?=
 =?utf-8?B?VkxxOU9Wc2RxeERpQi9oR1JWdkdOaVozcTZLRXBKcTZ1RHl5K1hxQ1FWV0RK?=
 =?utf-8?B?QUh6NFpwOWZlazNLb3J6VytEbmIxTFF6ZmhOTzZxeDQvVURPY0gwK3Fjd2xo?=
 =?utf-8?B?eHpmZk01MmNRaVNlV29Lcjd1NDBOQkxKTTZ5TFZQY0tOZzRyTjkvU3Z4cFYv?=
 =?utf-8?B?cUJ2WkJkTVZabHVnR1lra21DNklURXFOV0FFbCtRNFlqcVByQUJyNE1ZdExl?=
 =?utf-8?B?RUhLT3M4TElDcFR5UzVIS2tmSXhUQ056RSs3RWpsMllpYnB0MmR2bERvcFgx?=
 =?utf-8?B?WUJlU2NlSWYrT3R5eGlOOGVUellST09RaGJxWDJ6RUNwUVA0V2dEL2lYZyt5?=
 =?utf-8?B?YlQvTU8yQXhMZFVVZ1h6MFBNQjh6Q2NiRGY4eW80Q0p6ZXdKQXVRZUIwdFhM?=
 =?utf-8?B?dnM2Yml5dmFkQ0dIRXd5RDA5bk1taU1UUk84aDJ1QUVoRTVOY0dNbTNyVERa?=
 =?utf-8?B?c3lkb1pvMXpvRHh5dDhwY1paTXJLalNSbCtQVy9XdVhqZ1FSV1UwSEVOMmpN?=
 =?utf-8?B?ZDlRRDRJdUtZeEFCcGdwYnpVSVVwdVJTWHo5M3NXUjRjbG9tdGZNVU93SmNq?=
 =?utf-8?B?b0R5Sk8rWlAzVVhhdENDdDBobHNuZ0xQaXpwL1Q0RGpldjFIL1BjZFNVSTVB?=
 =?utf-8?Q?ib6CmppYtR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW5xQm44RVllbEdhbndsTW5XcnY5ekh3UFpaMmxTcnZlM1BGdXMrZU40OGVp?=
 =?utf-8?B?T3QrVVNSVmEyMmFiL3pBeG9iWXRTMVcvWURFWnQxNjExYk8wVVUrbG5LaEZO?=
 =?utf-8?B?TUhjUVNsNnpaNDhaMXpXS1Y2TmNYMk9GWERiYkJxUlh3c3N2eVhnWFU4Z0FN?=
 =?utf-8?B?cy94dHpWL0xJZ3F1VElRRWQ4a2cvN2pvOWlJWVJTekVpSkNWVElybmxmRVg5?=
 =?utf-8?B?YXQwOXZtQWxsbWg5S3pLM0ZOdm5tMXJNVENSd3VBT3FlOTI3a0VZVEIxQStF?=
 =?utf-8?B?eVc4UCtyc2NaTGJUV09Vb0xQMTBXVnZETWtOYzZvVGJ4cEplYXFCVnNybDdj?=
 =?utf-8?B?b3prcVB3OW54Um93T0tTZ0wzd05jWFVtQlVpQnBsK3ZLV0tBZ1RiMzF0akg3?=
 =?utf-8?B?aGlGTzA4dWZvYksxbzB5TDlWNlFEQkY2b2w2cUhVR1ArZnBQN0xWd1FVcTVG?=
 =?utf-8?B?Rml2dGdhT1pwbUJGKy83aU1IbVhRNkROdisvK1o1R1dudFQxMEltZm1aOS9r?=
 =?utf-8?B?cm1CYmFJVHU2bUdnZ0R2NjZNTkZHbk5UMUw3QitmdDNnZEtPWVV1QzlaNlV3?=
 =?utf-8?B?QkgxeXdkVTV2QjdjdmNEamFjUE1HRFFvZFhGckFMOFFSWkZiVGRHcTEvZWIx?=
 =?utf-8?B?TVZSUnMxUE10S3V1Rm1tWUJIMHBQajBOeXpueGZxUXl4N0xrOEQ1ckVPWGdP?=
 =?utf-8?B?TzJyWCs5bk8xTWdEN1E1czBYSFVua3BOSFQ5UzhuYVNiOGwzZkhJRVRSVlh2?=
 =?utf-8?B?ck10YWtyYi9wbktzaUllVExEdS9OblRraVE5UXdOaFNXOUJvY1FObVBtbCtx?=
 =?utf-8?B?Qys5YUcxK1FKWXNpWnJMWkNua1IxK3NhYitTVlg0b3RRR1dtNXZBQ1RLSDlY?=
 =?utf-8?B?bUxjNVZObXhDN2d2QVBPZkM0MFNhUW5qN25GTXFxdHppTDhwcmpGOTJJL3VR?=
 =?utf-8?B?TG0wNm82akdvOGpIcXZlL3BiY2ZXQkxKOThTVmcyODRDU0E0aVFJZXlQUXNG?=
 =?utf-8?B?NkJMMDdpSXJJRGdWTXliSWVpWWRuVTJ1RDhHTzl1b2RvSDFHRXJmb0Nxam54?=
 =?utf-8?B?V282OHRENm9Zd0p2VkFHTTRzK0NOMmRadlluQ0dYcWoyd3hoaldzSm95bjBG?=
 =?utf-8?B?b1pSWUQ5b0FqV3haaHZCdVBtdCtQd1pnQlNXUTRwcmdNaldmN1ZhdS9mOHNZ?=
 =?utf-8?B?V2trdmZiWDM5Z2JCTGNwMnc0am12MndJTm9Oc3F2MmxHQml6K0g5d2JTWEEz?=
 =?utf-8?B?Sy9HUEVNbVpFRFNPbnJ1MGdZNTN2VTV4SmRQekZiaUsvTmxhTURhMDY5aWlB?=
 =?utf-8?B?bnVCZHAzWE4xQTI5UFB1bk5VZWNSdEpxOTlKZkRxR3hRRCsrMk00WDBNbWZx?=
 =?utf-8?B?aFBnbDFMTndKZ3NTVVB0R243V2hqYzN5bFNsLzA0LzZnYXZ5aXJKb0NFcDlq?=
 =?utf-8?B?VTNXUk5ZWUo2RmF3bGZJVEszeTZLSnV5ZllkcU5GaG53NXMyUzRpQzVaWkxo?=
 =?utf-8?B?MXZLeXh3YkNsbmtGaENVQ3U4WnFmU2NoRk43cG5DL3p3cDJ4RzVxVkdCMlQ2?=
 =?utf-8?B?RDdKdVJpYU5CWGUrMDhoRXVLeWZRZVVCVUVVSkhRN1owZmhuZzdLcmI1QjNH?=
 =?utf-8?B?QWt5SnN5V1oyOFVUbnU3Uzc2c1dMREF1WnRpd3IxWXc4Vkg4ZHFsWXhtc3VE?=
 =?utf-8?B?UHI4amt2TnF1eVVnWi90cFZJVWVRZkxidWsxZHU3dmxTWnpFbWZoeW9wMjQx?=
 =?utf-8?B?WEtOV2czVHZMbnpWcW8rSDMvM01TbWNzY29LeThpK3pJamo4TXUzcnpudncy?=
 =?utf-8?B?VENKQmorb1F0VlFNeGlWdkpGeWtzWU8xdjJOcGJkOEphYUtCTU5HRWJ5cnZy?=
 =?utf-8?B?L1pkYTE1RzI1WE4rejAyZHNncXJMT296RDRYUVdQN1Y0THlRam0wdHBHR2lH?=
 =?utf-8?B?NjIzSGZoNm1qOGxscDI2ZE11SzFpcXhuVG1rZXdHQ3ZNKzRsRDlVeGhjWFhh?=
 =?utf-8?B?WFlFUWtNeGduV3hneW05ZEFpZU41Umd4cU5IN2NGaEZDMVhZYWpGMTZ6MXZw?=
 =?utf-8?B?YU1Nb3VLUmpldjU3MURrbmNBMTllZGE4UVBEYy9VWEtJUWZNYWlvNmtQVnRM?=
 =?utf-8?Q?sI14=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1693ba-6416-499a-f05c-08ddc92b5e2e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:23:46.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbd9Ednte7qN3lObNspjU2GafB8EZhXylgSTqtwQGJFwiB/7Bw2p7HM1ROBqABBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

Hi Reinette,


On 7/17/25 22:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
>> to account for overflow. This adjustment is common to both
> 
> The portion factored out does not just handle MBM overflow counts but also
> handles counter scaling for *all* events, including cache occupancy.

Yes. Got it. thanks

> 
>> resctrl_arch_rmid_read() and resctrl_arch_cntr_read().
>>
>> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
>> this logic into a new function called mbm_corrected_val().
> 
> This thus cannot be made specific to MBM. More accurate may be
> get_corrected_val().

Sure.

Rephrased the changelog.

x86/resctrl: Refactor resctrl_arch_rmid_read()

resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
to account for the overflow for MBM events and apply counter scaling for
all the events. This logic is common to both resctrl_arch_rmid_read() and
resctrl_arch_cntr_read().

To prepare for the implementation of resctrl_arch_cntr_read(), refactor
this logic into a new function called get_corrected_val().

Signed-off-by: Babu Moger <babu.moger@amd.com>



> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v15: New patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
>>      with mbm_event mode.
>>      https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
>> ---
>>  arch/x86/kernel/cpu/resctrl/monitor.c | 38 ++++++++++++++++-----------
>>  1 file changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 017f3b8e28f9..a230d98e9d73 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -217,15 +217,33 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>>  	return chunks >> shift;
>>  }
>>  
>> +static u64 mbm_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +	struct arch_mbm_state *am;
>> +	u64 chunks;
>> +
>> +	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> +	if (am) {
> 
> These are MBM counter adjustments.
Sure.

> 
>> +		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>> +				hw_res->mbm_width);
> 
> Above can be aligned to open parentheses.

Yes.

> 
>> +		chunks = get_corrected_mbm_count(rmid, am->chunks);
>> +		am->prev_msr = msr_val;
>> +	} else {
> 
> Cache occupancy handled here.
> 

Sure.

>> +		chunks = msr_val;
>> +	}
>> +
> Both MBM and cache occupancy scaled below:

Yes.

>> +	return chunks * hw_res->mon_scale;
>> +}
>> +
>>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
>>  			   u64 *val, void *ignored)
>>  {
>> -	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> -	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	int cpu = cpumask_any(&d->hdr.cpu_mask);
>> -	struct arch_mbm_state *am;
>> -	u64 msr_val, chunks;
>> +	u64 msr_val;
>>  	u32 prmid;
>>  	int ret;
>>  
>> @@ -236,17 +254,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  	if (ret)
>>  		return ret;
>>  
>> -	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> -	if (am) {
>> -		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>> -						 hw_res->mbm_width);
>> -		chunks = get_corrected_mbm_count(rmid, am->chunks);
>> -		am->prev_msr = msr_val;
>> -	} else {
>> -		chunks = msr_val;
>> -	}
>> -
>> -	*val = chunks * hw_res->mon_scale;
>> +	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
>>  
>>  	return 0;
>>  }
> 
> Reinette
> 

-- 
Thanks
Babu Moger

