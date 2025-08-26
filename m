Return-Path: <linux-kernel+bounces-787184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC10B372A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B625E86E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0924371E94;
	Tue, 26 Aug 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SMCLnSx"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2232F36CC9C;
	Tue, 26 Aug 2025 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234398; cv=fail; b=dZDfhbryFG+NWPhJBLjN16ZguPwaid0jeK1juyxmfOBFphUtuvkf35Fe/1CFh+q5BB3k6jkSMvz5EI0BIhsEgnO/ZAvFIRlYET4JeFFTgS7Nk79dtd7lPK7smW5Wjs8c+PzkVTS0RTAckzD9gFSanYIX8ENOtbb4E3GzyLu+Tlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234398; c=relaxed/simple;
	bh=MxfwS5RDfuym9/2PJEt9QjvgH+0yw8hQwn+tgYfq15U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGCldHVyHowv0b99xghJ15gC3Nah1kGq60wiF0p7YEZ4TFqLMJgbqSmyHYHV/I30FfaarqOrZ5E7Up/OsAGgVZjMKZuH4d/JQE9hCUBUyBi8FKYU0Q611Y35ZVz9udSw1JTW1hw7SQgmLblMZ0vfXW6WnlVwCx2JWY/04BzK9ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SMCLnSx; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grz1I/zPrFhIogGxSeRNgmYdJMicXx3vHt90K6wYfoHYQzbvAo6xl/NXz0X4sixpQrv7ebx9vKL9olPgvkmEAtHtkM0+RYc6HSlhJdOg3y4OeYV/kWFqWLBoJrQpYSgVyVpOU1hOMzeGKalEJUrnEUL6+Je8ttmRmqiHNwJQuQjVPK2mWAMD2nIODXD/bkphALv/FNgHmXg6ajHY+JRAnejyP4h4IulUShwAFJTeYf1UkZ0KM0ZNxPTA3iJp70N3W4eK7TwIii96QpXfbAB8AK0CMGpUoDKV7p012XlXBY1OcqUGMzrlt3qTa461kgHqQRfhIjeM2BZv8rBXbvm1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyoimNZdv4biRJcrY9VtF+isp/qAMWe/XoHJ9nedleE=;
 b=EQVsj7JtaagMEvS+i5sfX/qFnhrFFQ94nbhF1NPEQm++qk4AurTPJPmMYTcT/vsxH0D3tkLwjlTajTp5ZonyndwiD0N14Mg5c7er8J6NwDUZHjjlEoB1MQhsuB6W0heMEdDIgSiB+wC34Vf/+XRk+LuhC3nriMcdPSUHOPxCKGL4YYCq43Sr07rO1mReTmtvHRURuP6gJZtuMUvMhUQ3pzDo1IB8/lBa+siSLqwLVQn/3N75Qu1BEj4fr4s0yrxhzAhpdysmdToQZe+LF5UkodUQCmKm4gTbGh/Vk45k5J0Fs/1j2nFtKMzAaendI9a7CcPHynFqyVJqSPXY60WwGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyoimNZdv4biRJcrY9VtF+isp/qAMWe/XoHJ9nedleE=;
 b=3SMCLnSxkafcso1bLwyTJTmbwvLmbyJOUO3Xn/AKFdNnbdhamLYS+3mwDO3CtnBwt9ZTyeoi+qK7NsJl7wDbmz3qz0v48GQiELoY3R8Lf3rSM2E9/vQtqJBBBR8iD/F0+yi/lgBDDm6LgnhayZB3iwjCSSguvhjLrxsV20ZYU5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by IA0PR12MB7751.namprd12.prod.outlook.com
 (2603:10b6:208:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 18:53:13 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57%7]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 18:53:13 +0000
Message-ID: <f7c6b5ed-a812-4f46-b40c-74d55e47f24c@amd.com>
Date: Tue, 26 Aug 2025 13:53:09 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 09/10] fs/resctrl: Introduce interface to modify
 io_alloc Capacity Bit Masks
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, Dave.Martin@arm.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 david@redhat.com, arnd@arndb.de, fvdl@google.com, seanjc@google.com,
 thomas.lendacky@amd.com, pawan.kumar.gupta@linux.intel.com,
 yosry.ahmed@linux.dev, sohil.mehta@intel.com, xin@zytor.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 me@mixaill.net, mario.limonciello@amd.com, xin3.li@intel.com,
 ebiggers@google.com, ak@linux.intel.com, chang.seok.bae@intel.com,
 andrew.cooper3@citrix.com, perry.yuan@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, manali.shukla@amd.com, gautham.shenoy@amd.com
References: <cover.1754436586.git.babu.moger@amd.com>
 <4652b5d8fac8ecad90b3eb734851916036246140.1754436586.git.babu.moger@amd.com>
 <5003e6ca-6683-44f7-9a44-7fce8537a7e4@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5003e6ca-6683-44f7-9a44-7fce8537a7e4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::11) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|IA0PR12MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: b817aaf2-b97b-4773-c173-08dde4d1cefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU4rK0F5dzVKV25ST0x0WUh4VEJ1dE5IdlBLOTFOZWpvelBTL2pIeGpSSXQz?=
 =?utf-8?B?S0pkdldWblZqVHRZcHhtbmdPTHVjZWd0QWhLSjYzNFMwVkl5WlVNenQvNk1S?=
 =?utf-8?B?bmpoVjhxaGxVczhBdWQwQ0FhbllpYmlVVlN1S1dRYm0ya2FsaW1Edzg5U1B0?=
 =?utf-8?B?YzZMb2dOOGVRb3JyTUt5VjhFWWtsMjB5Zmw2QWpBRXk4N1dvamZlTGF5dk1w?=
 =?utf-8?B?eW9YcGxKQ0dIWW01cjNJN2lYb2h2SFoyZmpIbGswUERZdk5rOXBzS29OTVgz?=
 =?utf-8?B?bmZYeXBYUklnOGFYTjdTVERvVDRUNDFjT1VTSGgxL2kyeG0zVlVnNXJwc2c0?=
 =?utf-8?B?bm9pUENmUy9tVG1ObGtNeFltU2xjcWVoU2JqSnVrZEhiaGFVRnd6azlYdWhx?=
 =?utf-8?B?TzlVQUdpUlV3Uldzby9zWEQ4ZGZSaHRUT2VoRWUxWGhKSnQrRkN0cFRGN2pD?=
 =?utf-8?B?RFlaK1lTK2tUZzNPTWNoaXBpWXZONGJTQjFBc1dlb1dpcUlmVk9jRmR1ZUpz?=
 =?utf-8?B?QkxNQkU5bzlFU2x0d1dlTDBKNXlIMFEzSW00ZFA0NGpxdnFQL2JVVmZ1bmRM?=
 =?utf-8?B?TndtaGdtN0tZZlFuOXI3N08rV3lrK2UwaDdpZzFnSVBtZWlrZ05jVW1wSzAr?=
 =?utf-8?B?azlqS2YwbmowUkluc1JlVG1UVlhlekRneFRCZm1qNmZndk5vU3FPQjFOZ21x?=
 =?utf-8?B?by9Pd0JrZ0M5enhnd3dHakZ3bzJtNmp2RmFiTUNUZEVOTWhQdHRWeVBGczZz?=
 =?utf-8?B?Q01oMEVMVldWMlRMK0p3Uzdqd2xYem1LNTJ2NUhFUjQ4MWlaRXdxZVJDU3h3?=
 =?utf-8?B?L0tuaGF5QU1zV00xOUsxejdDRXpVWnBvWGVzUnZLdEhRbUlSSlhTL3lFWGJi?=
 =?utf-8?B?aWx1UzBFYzI2YWV6RVBkWWZLcVJRbmFYWktUc2c2U3lvanUxNlRhZmdYSjlN?=
 =?utf-8?B?TFhnYnRnUXE3OGhEUTNTc01ZTWZxK29LbmhpemJ3VXduVDhTMk02VHg1UEZh?=
 =?utf-8?B?MUY3bU5aOWY4ZmFMUkRieHZRMVhrYjBsSW5vZWtqSEo2N00vOFJndlUwY1E4?=
 =?utf-8?B?b01IdERvSTA0MGFtb1RnZXlZZ09URmVzSzZTVGczbHBjRU1acG9OUSttU2dr?=
 =?utf-8?B?YUxhSzRBTGovVFJmcGF4dTZieERlN2w2NjFmRUdBMTBoUTVLOGgrcUlDTnU2?=
 =?utf-8?B?Snoza3dmOHZsanBvS1lYVWcvNjhhTWpMa0Vsd20wVTVMWXVGK0ZrT3I3MlVm?=
 =?utf-8?B?VkN1WmNhUjBJVWhiMDltU2hrcHhTOHNraGVURHFHOTJFOHU5SHFuUDl6MVk1?=
 =?utf-8?B?czc5YytUWXlTMmg2YVlvSlRGY0tLTGF5bGhuckVZNk9EQXJOTGhPRjZzR1BW?=
 =?utf-8?B?aWp0MEk4NTVQdWdzVFVoYXFFSXQ3cm9mQUljTElrYVZhcENRUVI2YWpnSEht?=
 =?utf-8?B?WlVmSnVmZjFNdS9TQk9jVlUvakV0cEdSbXBzR3IrLzBMREs2d2xZNW1Gdkla?=
 =?utf-8?B?R1gyUEZrSk1iMjJnUmpMZS9oaDJNcEZFZElsNFA5YjhlNEdiUnJFYzZlZldm?=
 =?utf-8?B?ZlNueU41K2E2MW9IV1VqSHBJSWVFTzlqSFZWR1RkaUlJUDRudTExV2VUa1Qz?=
 =?utf-8?B?SXVydzh4Nkw4dm1zK29HT1Z6bFpEaGRVTDArcHNuSkw2RU1aYmNDM2w3bi8r?=
 =?utf-8?B?RGMzUU9UeXFuWmRVZVhsV3EzK3krb2RNNU9Pc2RGMnFSZjJ2WXNDdXZod1BS?=
 =?utf-8?B?RTlqbm9lTTNyUmFieVRDNkl2RmExbUJKcGtsT3duT0k3anozdkcvTHh2b3Nz?=
 =?utf-8?B?a0RxSlIxLzhCMjU1d0VEVmhBNkZpbEZTdGRUSVovV0hFdFY1SzhYZ3FWU1I3?=
 =?utf-8?B?eVE2QkxuQ1RreWovbjY0R21xZS9vVGRyRE4zMHV1YXdqcnNPUFlONFU1WTRN?=
 =?utf-8?Q?lRsxmaJ2puY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXFzMncrR0kxVy9zSlBPU21ScFl1ZW00bmRKSWZJamwwQUhuV1JyV1VFM1ds?=
 =?utf-8?B?WkZteXY4TUZGVW91dExheVhHUS9QNFZpNFdhMWxVLyt5TnBhaWNpVXp5Tlc3?=
 =?utf-8?B?WlNHVVd3NE9VNDM1UnNmM1VVYk5Cc3Nnd3ZMcGkwTlllU3ZSYzEvaFc5a0FX?=
 =?utf-8?B?ZW9lN016MlVzb1Rna0htRzFkQ1doSlV1TmVldy9nTDg4elRZc01kZU15dzNY?=
 =?utf-8?B?L2NLNE1INXVTL01rTXg4QjNYUUpyZU41bEtMZVFzcStsamJ5aysyVk4wZmJS?=
 =?utf-8?B?a3dUQk94emh0Qjd3RXl5VzRoQS9WQ3d4Vi9SQUN5WTFISFZQemVCSWxIL202?=
 =?utf-8?B?bzcxcm1sdkFkTzYvQWJoalFVVXI3eWIra1NTQytsNW1TMzlQZk45WnF4QXlS?=
 =?utf-8?B?REtKMnV2dTg1QlFOZzd1SEdaZ0V4VkxZOW5TVlZzOVpaYk9XSm04NEdhazJl?=
 =?utf-8?B?eFVkUkJOL1VQOGVYSWtiNjlHQk1LT1FveWNoRWFqRGNicEFWMjVCZlBsUlc1?=
 =?utf-8?B?eXRFSzB5ak9ZcjN6NE0rbUZwQWVHNVNZbHYveTJmZXhaSnRydmNsbDJzL0Uw?=
 =?utf-8?B?UHZGbHZPREppZ2pIb3NpcStIYXRyM2VJOCtkVTY3clJCUm1CbHc3amtkSTQ3?=
 =?utf-8?B?ZnJEa2t4aVFzUVlmSXhVSFhnQ2NmNjlNUTFkc0UwVWFlYlIrM2VsNTRzSWRo?=
 =?utf-8?B?ZGRDYlNBNXBZaGY2R2ZOQzNuUVBpVDNFc2xJZFNUemtGTE9tMDJGWUpZTVlz?=
 =?utf-8?B?VTlFelVhV3Mwand3bEg2dEc1M1FUcXpaN0xDaElscitSLzA2UlN0QVVxWWFm?=
 =?utf-8?B?cW95SFVqYzN2bmNnSmNEYmNETUpHTzZJbzZKVUorWWJpVDVxY0YraWtHRVo1?=
 =?utf-8?B?alc0ZlBYdUp6bHRTOUcvNm04blZCU2JNWnl4dDAzdXBUcFE2RG9WbnFiYkZv?=
 =?utf-8?B?c2RBQUR1ckdJbndJemtFcy85TUpHd1lKNG1wZ2lLNG1CU1Z3WFhCb1c3bmh0?=
 =?utf-8?B?RFo5NnFUdGROWXlMMGx1OEtvQ3B4TFFHYmdrTXU1cnZRMTdyUFRkY2lYRlVy?=
 =?utf-8?B?VU01NkhJSzVtTHNIM2g1RGo0VjNMTFJWbkgyUHVrYUlkeW9aQzRDUER1L1pR?=
 =?utf-8?B?VHdCTFZzQ2pkNEZBendXKzFIUlNsbVdVYzF0Mzl0cFJ6U1RrSGZQcUo3Ylhp?=
 =?utf-8?B?UitWdXZ1SGdiRlN1Q0JqQ2tTNmREejhBQmx1dVFhVzI5eHlDLzNvMDVPMS8w?=
 =?utf-8?B?R2EwK2VraXJrMjYzald4bUt3SzlOcWp0OUszbXdIYTV1SVdrNHQ2NUhaaW5l?=
 =?utf-8?B?YzBXRldMajBTOEcvYUVWWTFvaGRkTy9Vazg1RUlIWThpZGNoNkQ2ZTNHdTFj?=
 =?utf-8?B?OUZVYXRueXoyUzN2MXNCSDNzdHhkRDc3YUJYVWcySkFnMnNNWGxVTElsdytx?=
 =?utf-8?B?ODE2MUI2K0cxVlZOWXhvL2Zkckl0dWtLV3E0UWpVcElCN21rRG9FSnRibjZp?=
 =?utf-8?B?MGVsTzBxREZvbWRCNDhOVU95ODhmSmE2T1h4ZktJZVdGczNGSkhFYXdiaVpv?=
 =?utf-8?B?cFVKU2MvdkZKMTBjdlhkSGFBOERiS01zVFZwMDRpWFdkOVU0bWlRb2VtOHpN?=
 =?utf-8?B?Z3VDZ1BPL0o1U0RQczNodFBrclpHUFZKejQrbys0ejEwdk9qRkJjM0c5eWxa?=
 =?utf-8?B?bmpCd0hJNWszVGFXa2I3UUwweHYwMTJSeHoxYURJalhQcHZqUGVaaVFtWmVa?=
 =?utf-8?B?V0M4c3hXUFpTOTNSU3VvdTRJczhqdkVTU3MwSUMxcnZUZkhYTFFnUHdyeS9k?=
 =?utf-8?B?MEdsY1I4T01FMXFIQ2JWSVhBcm4yMzFmbXQzV2xIK2xmL0duR2l2WVRZalBL?=
 =?utf-8?B?ZGM5Q3M4UGxhYjZTNkVIRlgzZnFtanVDeTNtbFpZRUpQQmxzY0xLRHBZbVli?=
 =?utf-8?B?WnVNaFFxNVJUSHlYRzhGKzA5V0xJalFzcUR3ZlpRQ2k1bmhSVWJDcWVkTXF4?=
 =?utf-8?B?bU1WMDUrREhBcGZvNGl4bUU1NHlmY090bHkwSGVGWlpLdkhTV1J3M29kT0ZY?=
 =?utf-8?B?SHp3b0k0cVJlVUZvN1FaTHFzWGtLR3hUMUxIRWVxa1Jsa3I0dUVrdm1ITkVG?=
 =?utf-8?Q?HMAc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b817aaf2-b97b-4773-c173-08dde4d1cefe
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 18:53:13.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbttbXr4OFARqhlMED5pr/nsWewkz8rJvBMB6DTS3ah2hKmPEpExuTmMwgll4mRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7751

Hi Reinette,

On 8/7/25 20:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> "io_alloc" feature enables direct insertion of data from I/O devices into
>> the cache. By directly caching data from I/O devices rather than first
>> storing the I/O data in DRAM, it reduces the demands on DRAM bandwidth and
>> reduces latency to the processor consuming the I/O data.
>>
>> When CDP is enabled, io_alloc routes traffic using the highest CLOSID
>> associated with the L3CODE resource. To ensure consistent cache allocation
>> behavior, the L3CODE and L3DATA resources must remain synchronized.
>> rdtgroup_init_cat() function takes both L3CODE and L3DATA into account when
>> initializing CBMs for new groups.  The io_alloc feature must maintain the
>> same behavior, ensuring that the Cache Bit Masks (CBMs) for both L3CODE and
>> L3DATA are updated together.
> 
> Please rework this copy&pasted text also and make specific to what this
> patch actually does.

Sure.

> 
>> Enable users to modify io_alloc CBMs (Capacity Bit Masks) via the
>> io_alloc_cbm resctrl file when io_alloc is enabled.
> 
> Here the changelog can provide overview of what is done by this patch
> when a user provides a new CBM. This can include that a CBM provided
> to CDP enabled resource will copy the CBM to the CDP peer.

Sure.

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
> 
>> ---
>>  Documentation/filesystems/resctrl.rst |  8 +++
>>  fs/resctrl/ctrlmondata.c              | 97 +++++++++++++++++++++++++++
>>  fs/resctrl/internal.h                 |  3 +
>>  fs/resctrl/rdtgroup.c                 |  3 +-
>>  4 files changed, 110 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 3002f7fdb2fe..d955e8525af0 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -187,6 +187,14 @@ related to allocation:
>>  			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>>  			0=ffff;1=ffff
>>  
>> +		CBMs can be configured by writing to the interface.
>> +
>> +		Example::
>> +
>> +			# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm
> 
> It may be useful to demonstrate syntax when more than one CBM is modified.

Sure.

> 
>> +			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
>> +			0=ffff;1=00ff
>> +
>>  		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
>>  		resources may reflect the same values. For example, values read from and
>>  		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index 641094aac322..1f69117f96f8 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -858,3 +858,100 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>>  	cpus_read_unlock();
>>  	return ret;
>>  }
>> +
>> +static int resctrl_io_alloc_parse_line(char *line,  struct rdt_resource *r,
>> +				       struct resctrl_schema *s, u32 closid)
>> +{
>> +	enum resctrl_conf_type peer_type;
>> +	struct resctrl_schema *peer_s;
>> +	struct rdt_parse_data data;
>> +	struct rdt_ctrl_domain *d;
>> +	char *dom = NULL, *id;
>> +	unsigned long dom_id;
>> +
>> +next:
>> +	if (!line || line[0] == '\0')
>> +		return 0;
>> +
>> +	dom = strsep(&line, ";");
>> +	id = strsep(&dom, "=");
>> +	if (!dom || kstrtoul(id, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dom = strim(dom);
>> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			data.buf = dom;
>> +			data.mode = RDT_MODE_SHAREABLE;
>> +			data.closid = closid;
>> +			if (parse_cbm(&data, s, d))
>> +				return -EINVAL;
>> +			/*
>> +			 * When CDP is enabled, update the schema for both CDP_DATA
>> +			 * and CDP_CODE.
>> +			 */
>> +			if (resctrl_arch_get_cdp_enabled(r->rid)) {
>> +				peer_type = resctrl_peer_type(s->conf_type);
>> +				peer_s = resctrl_get_schema(peer_type);
>> +				if (parse_cbm(&data, peer_s, d))
>> +					return -EINVAL;
> 
> CBM is still parsed twice. As I mentioned in v7 the parsing only need to be done
> once and then the resulting CBM can be copied to CDP peer.
> https://lore.kernel.org/lkml/82045638-2b26-4682-9374-1c3e400a580a@intel.com/

My bad.  Simplified now to copy the staged_config from source to its peer.

peer_type = resctrl_peer_type(s->conf_type);
memcpy(&d->staged_config[peer_type],
&d->staged_config[s->conf_type],
sizeof(*d->staged_config));



> 
>> +			}
>> +			goto next;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
>> +				   size_t nbytes, loff_t off)
>> +{
>> +	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r = s->res;
>> +	u32 io_alloc_closid;
>> +	int ret = 0;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!r->cache.io_alloc_capable) {
>> +		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	rdt_last_cmd_clear();
> 
> Unnecessary rdt_last_cmd_clear().

Removed it.

> 
>> +	rdt_staged_configs_clear();
> 
> Placement of this can be improved by putting it closer to the code that
> populates the staged configs. That is, just before resctrl_io_alloc_parse_line().
> The flow is not symmetrical in that the out_unlock exit code always
> clears the buffer whether it was used or not. I think it will be easier to
> understand if the out_unlock *only* unlocks the locks and there is a new
> goto label, for example, "out_clear_configs" that calls rdt_staged_configs_clear()
> and is used after resctrl_io_alloc_parse_line().

Yes. Sound good.

> 
>> +
>> +	if (!resctrl_arch_get_io_alloc_enabled(r)) {
>> +		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
>> +		ret = -ENODEV;
>> +		goto out_unlock;
>> +	}
>> +
>> +	io_alloc_closid = resctrl_io_alloc_closid(r);
>> +
>> +	ret = resctrl_io_alloc_parse_line(buf, r, s, io_alloc_closid);
>> +
>> +	if (ret)
>> +		goto out_unlock;
>> +
>> +	ret = resctrl_arch_update_domains(r, io_alloc_closid);
>> +
>> +out_unlock:
>> +	rdt_staged_configs_clear();
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
> 
> Reinette
> 

-- 
Thanks
Babu Moger


