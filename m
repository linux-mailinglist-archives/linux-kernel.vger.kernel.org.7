Return-Path: <linux-kernel+bounces-848939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC4BCEDB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7D534F04F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566514A62B;
	Sat, 11 Oct 2025 01:18:49 +0000 (UTC)
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020105.outbound.protection.outlook.com [52.101.196.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D83AC1C
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145529; cv=fail; b=TBR9sTmOXPlOBtSp6TofhwwTiUhRW7NsGbMR3N7cMepRnPTC006Beqeh7Mi4YCgshYhdUTU8+xTPp0VlDQK8EkwYiYvq+8xKg15i6wsAivOGYE9AbYzwndyOaF6So+1Z3UoImJJlDpYU7TRf+Trp/IeZ2Rt1rtMA40Y0nkHw5mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145529; c=relaxed/simple;
	bh=JCPfdAde5HJbo+HFwdqg14ONjiKvVzKrs48SBRg93tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRd1k7nhy6jeMFvM0cdeNy4YdEiBPamaeYF+LOnhUxq4h21j762nvcogFxr40huH550OnE14JpEsVRzEpy3fyCRXZ1NRiBjGyLSOOHMBv/rD90qIsBFp8IBz231UJgl+11cT/Jy95BX3Slgja28rkvLl14Jse00uXs3zO7fN/aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTBK/LMiridDAKqJhBzevqDtFEWHBFyMsj3tdSW0+UFAMxmXgzY8Pa3EBtC5/k/KSZq//AYerfpG/qC9XUqzcUaHGCcP8sWgfxkiR6Qd47VeySaOM+eLO1Vkj2IKxsyQ0sdwfLgE51bgvEflW37oueg1M8TjwA290Jw+nzSJnOvGJIRjbxuGqrPPIQzkVVzwVyu59R57IhNu3TKlGsN+NYSKab3dpP4xLj20gnHN8i6vRmk18LHNcXCcB4uPUVPjxDQWT/68FAbWT2uSKiagG+LfEQzeSBVl36uGDJhA5Hm1JTOdFHwT3OgNo9XA14QUxRcl7oIMTFCTQoVpk+UrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+k1r6Z2KYnj3lSV0jVIkTiiHXhhJ1GZLfZHqrGW7xE=;
 b=T3U4qXHSdoBkOooCWhw+GgT4/68fan/jybTHOeNYmhsbOe/7+twMlBbcwLPwe0MNcEsSHO9vZj62nIHGmSf2tDLXWh7vc9Rf+q9evQRsDZAN+JWNgZViSobKvcF4xCVJvg6R/yvHaNZDepjLAgWeCac9AYSqPiCb2dHguHNUA0UjQ2WW4TdYNoVK9OQicKKRoSX1Z2a+bZBGJ7kwUwevnVyunTIool3qUeGDeJE0hDsNb42h1vnueJckrAUyhEcUqGJEo3yv8YQnal7FJmuDHDIAC7CaiW6Hz9XVx70PTsaB7Xc4kq8qb6wVohsWu6SIa6K6/L2/IGaH2Jz+v2aS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7766.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:18:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 01:18:45 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	nathan@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tick/nohz: avoid showing '(null)' if nohz_full= not set
Date: Fri, 10 Oct 2025 21:18:30 -0400
Message-ID: <20251011011830.6670-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251011011830.6670-1-atomlin@atomlin.com>
References: <20251011011830.6670-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:207:3d::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 16616748-81de-4ad3-188c-08de08641f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFBqeWtWbnRyS0dSY3NYVkxHT1hHQWtnTVRJVUd6SUcwczZ5enUrRWR0MDJ3?=
 =?utf-8?B?MjUrVmFMQnhnQlZUdDZtaGpWa2JidWpqODZPcjQ4dzdQRWdhU0IwaUFBMlcr?=
 =?utf-8?B?QjA0cEViUGpJME1DaUVpTnBVd0RVSjhNR2J6ZDJZRlVWWGNGRFAvTTF5dFVN?=
 =?utf-8?B?M1BZS1U4UmFKWi9ROEtsdWJ2bjBFQldLNGsvS1FLZ002bWFoQlFiZFNoK0xv?=
 =?utf-8?B?Um9tbGwrNzhGaVNzOHdjemVGamR2alJwTzJaYU41bng5ekc1eExNUTM3a1Np?=
 =?utf-8?B?R1hkRmN2SDF4dG5zd0xuZVhoRUpqQWVFbDlUaEh6UVZJeW8wWWhRcEhEbjNL?=
 =?utf-8?B?S3ZKcmZ6SFhPeW9OMjR3eStKazFxUEZML0cyUURzazJodE1rKzgwZ095ejh4?=
 =?utf-8?B?SVRKWWhIYVloS2hYeHQxZU5SSUJZamIvUW9FN00wa3I1bUNGaU4yTm9xdlho?=
 =?utf-8?B?cS9zMHlZUndSem9TdFFYdGtYanlUeXhoT3d0Z3pZemZnbXBScDdBaGFLNmM3?=
 =?utf-8?B?Y1ZQTEZyaEpEN3VHMEhhS0lGMUcwa2RpazRGd2JnWERaZExCZVIzMlZscVRy?=
 =?utf-8?B?aHBkMFI4WXVKbGdaME1GVWgvZGhGOVI4MURhd2ZFalhxLzgzdWhUZktUUFdC?=
 =?utf-8?B?b0lwTG5lV3FQKzNWWGwyd2txRnVtTGFaY29HQi9lV0hjSHpWMVBNcjNxcUZ2?=
 =?utf-8?B?NWRva0xLVExFTDRlOURMaFAxMGc0VTk2V2pUdFJuT3NRbnVBTEpGV1d0dlZF?=
 =?utf-8?B?Z2Y2ZmZ5WENQK3VCVG9oN1Z2WUhITlVpaG5aamVvYmttbk5GOVprQWYxUWt3?=
 =?utf-8?B?OEI1V2t5YlFpS2xaajRaTE82emFWK0Z4STZQTFlyUzh2OVZxZ3l6aFh3T3Jn?=
 =?utf-8?B?NmJkajVYWTVSc01IK0dYQXNPNXdGaEJzT2VLNWQ0L2tPT0IyMUs4REUzZjdq?=
 =?utf-8?B?SXczckRnVVdTaEdQenVVcHBZMjJUZDVNdVhSYTl1bEM5OGo5YmowdFhaODlp?=
 =?utf-8?B?UGVabHl2bnFNM3dzVFFhQVdRLzE2bHliNUZQSWxhL05KbGFQNHVYWGVmNU10?=
 =?utf-8?B?d0UrY0hWWWI2QmVsWHlmVnUvbFdRNGsxODMxalZid2UrUlFNcXh4TE83a0VQ?=
 =?utf-8?B?Tnk0cWZjaXdvUXZnbWI4ejVvSFNZam1wRGhPb1lZQVRFUHpnMzFmakVqbHRs?=
 =?utf-8?B?U0dEZEVMUGVvWEpIeU5GU2JjWGc2b0cxc3liTENVWTRpcCtHME0yd2kyTFhl?=
 =?utf-8?B?Vk00UnN6am1NeUlEMnVuQldrWHBCS2xkcC9SYXpvLzNrSWJtcURUTHhVWEdX?=
 =?utf-8?B?NzFMVmFhUHNNb0NnaGFsazZqVmNUYWE0VW9xYndRRGFUa05JbGhaV3hheGtZ?=
 =?utf-8?B?ZVZaaUw2OEF6YVNYc0VoZGk3bnd4djgyekRNVnlJK3BTMHovNDI0NkJQYUVY?=
 =?utf-8?B?RnltV2RWektsZ3lxOSthZ3JOeFM4NGxlWU9LaWJCUmQxSTJJTTRnN3dCemdY?=
 =?utf-8?B?VVZ6YkJ5eE92bDJIQ3BuR2Z5d0pEamJWc0krQitvZ2Ryd0VQbmNveDB0ODRn?=
 =?utf-8?B?dGJodWZVSmhxeW5YV0ZXc1Ntczk3eUpMQm9yelYyUmpjVk5HT01lSzU2NlJq?=
 =?utf-8?B?VkRRNGxacXZPQmdGQTZ6RzJmellQbFlKWi81WW4vTFZkaHNLdC9UWXhTSWhG?=
 =?utf-8?B?bTVveUhFOUZ6b3JFRWgybW9YN1BkRUEwcnRmV1Y4SFRTQU84SGJnV0doWU10?=
 =?utf-8?B?UURKdTJyVkZ4QkdTeXNTR0g3S28zSnQvaWxuZ1g0TlFIU0x1aFMwWU56cmtU?=
 =?utf-8?B?WElTaUtHeHNYeWVxbG00M3BzdUZVVE9KaXlqNU5FdG1vVW9WeU5iQ2hxUG0v?=
 =?utf-8?B?dGhqckcxTGJkbnNyRWN0UXkveUY3MUFwMHlDVlIyZ0lmS2Jja2xDU29uV09W?=
 =?utf-8?Q?QfFhTNrQ05rMbfvlAcPlfHjxNwfQtJva?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG5FTUwzcWIrMzdUZWhRb2JIV1p2bUpLNUs0QTBoclZpMFJNK3dFbjdtSkpG?=
 =?utf-8?B?WHRkRldSUTVzRjlzODRjUWxnbGtZQ1ZlMmdLdGZxNVVnQ0JhSmU0U04yd2gw?=
 =?utf-8?B?UWYwVkVZcFdmNDc4NVkzMEZaaThDVUNheGNKbndPamZEemltd3FtcmFiQlps?=
 =?utf-8?B?dVN1WDM3bDNPcElJQ1laMHpoUWY0akU1djVxaS9mTzhyVWw1MjZYUjNncGpX?=
 =?utf-8?B?MVEvVE1vMEFybWEvOFlpSHFLY0YzK2o5TlpjOHRKeWUveWFSMGJOdlVDSFgx?=
 =?utf-8?B?Q29PcVlkT3RJMTdtMC9UditNMGY1QWZJNVVobU9uenl0ZFFWUjVzVDRPL0xv?=
 =?utf-8?B?R0dsQVFBSFh2R3lwUkhtc3FDRk1TSkYwelN4OGdTa3hmNitoOG9ZN2xEY01S?=
 =?utf-8?B?dHlKMmNrNlJublc3bHFXTHY1Y2U4TldIMUtjenlpSGptWktZTTA3ZnZISzdR?=
 =?utf-8?B?NTJLNkhJNVpPZ2UySVR1QkN2eXdMUlc2VFNIclJtWmF0MkdHZmU4cXRqUnkx?=
 =?utf-8?B?ZXFOU3dNR0JwQkVWNGt1M0hQSGpxd0tuZGExUDJva3VmME1rODVkUzZCbk9a?=
 =?utf-8?B?eXh6NnBxdnczcXRaamlvL2NCdE5WSnVjbTEwbVBYZHEzdHFXOUlXMUtiNmFx?=
 =?utf-8?B?WmROWVFJMVhoNzVvYnlqN3FDcWpaYmt6VEduQlc5SEprZHpvTTRGSG44VHdm?=
 =?utf-8?B?aFpTS0t4TnpWVTJhSmJCNC8xOExxMmNXbWVGWE5haWc4ZWkyLzdqc3dpL0JJ?=
 =?utf-8?B?Q1FvUGRjTUkzTTR0ZlcxVS9lQjgyMlI5V0NHQTUyVS9SMFZVRVBORXcxaXdr?=
 =?utf-8?B?amFCTkZrTS8zbWNsRFJML1oxMTZjZFJETGFuOFpQdDBnOEMySjArbW8wbko3?=
 =?utf-8?B?VGJnSDhpM2FjWE9hdFh1ODh3NUVQRm5oOVh1anpCbS9ONTc2TkRtWGFTZ1JE?=
 =?utf-8?B?K213dGIzSWppZnppU0F5SWZkRGFDUk92b3AwdC8zbXFaSWxQc2lXb3ppNU5o?=
 =?utf-8?B?QU9SSEF3dElick5STG5KWjRKUHVmT1RFeFFteElvSXVVUS9LOWs4aCtpRVJw?=
 =?utf-8?B?THJadnpHT1NiTC81dE5xeUpGTXBYbC8vRndMbEV6ZkNtQlBkbUJpRVhYZVlu?=
 =?utf-8?B?aXdzWnp1T25Idk8vcEhxanRjV2Z6R0NIQjloMGM4TkVVcnM5ZXRXMVFMVlYw?=
 =?utf-8?B?Q3RhZ3oxZDBFcmdWMngvMTlwRVErbUh5eHljWHVuMmhJdDIyb1o2UzVnczFB?=
 =?utf-8?B?eHZodmJGQnI1U1ZDRXBIUGNzTTdvcXN4Zk5neEtCZWxVSWpEV21hYy9CSkJL?=
 =?utf-8?B?d0dWZUxGRHJmSW1LV011STNqSkR2VFVCWmppU1pTU3Z3ZVpLK2hBOVczOUFa?=
 =?utf-8?B?ejU5cjE1YWFtVW5OOW5UVTBEdDAvVVlPZGZXRXlodUh2ZGxTMFVXVVhoeVBi?=
 =?utf-8?B?T3ZTU1BKZmM3cWdqZlRTS2R0Q0hMTE9tQ2l0VzBRVFI3bnEvUVRFSkhOaTYx?=
 =?utf-8?B?TlFuSmZsNlkxS3lFSGd4RHc0V3NmY1d5MmUyY2Q3SkhUd1hnM3FnZDRTdkF6?=
 =?utf-8?B?SzJuSTFYb2xqcnJZL0VLTFpaYVh6VWIxbUZCeTdiVk1XaUc4ZHdzdjVlcGVL?=
 =?utf-8?B?OTBBOUROYjc1dGFiNThGcEZ2RTI2Y0M3dW9PVHFOekVZdzlQNGttVkZlcDEz?=
 =?utf-8?B?azBFSDMvMDczcWFvdUJoMmhVSE1PckRvbmpsREpTVE9IQytYSklicldpQzd2?=
 =?utf-8?B?Z3BIeVBSSjVmY1hCN2Iwejc0UlVTQ3gwRWpXaUhZZVRZSGpULytvc01MeU5l?=
 =?utf-8?B?WDVvYnhpS3ZTM3UvOEVzZFBuRENvanVmaERwWlhpZGN5ZUNWTlM4MGlPamwy?=
 =?utf-8?B?WXZxSFRGSlMvZ2xQUXZaMFZsbEtWK2dLZGo3SWsybk56d29zSVZGeUl2R2xn?=
 =?utf-8?B?UWhkZUswT0pGVUgyMzNyMUx3dTQzK3l6U1JwMTFmNG5kWERlSFl5SGg0UDJE?=
 =?utf-8?B?bm9jczN6WTdPUmkzc0tFTzJEVE85ZjZhOEl4MTJqSWNyWTcydlJhYkFFWFBE?=
 =?utf-8?B?NFpPVXMvQmpTNWlrell0NTR5aHFBSnoxY3dKZ2k3Z1RYUVhGNXJUWElKaU4r?=
 =?utf-8?Q?eF8kNYOlpQfRZ9zSknafNza55?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16616748-81de-4ad3-188c-08de08641f7c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:18:45.5296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2j2nuq1gUShXHyV8T9tRQry/cCj2I5nQlT5z3s4ddMIeJ4prQxlkoqoRAVEajZ6wqP7RMmvjaGAMkW9pXUmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7766

In the context of CONFIG_NO_HZ_FULL=y, tick_nohz_full_mask (of type
cpumask_var_t) is initialised to 0. Memory is only allocated to the cpumask
data structure, in tick_nohz_full_setup(), when Linux kernel boot-time
parameter "nohz_full=" is correctly specified (see housekeeping_setup()).
If "nohz_full=" is not set and an attempt is made to read
/sys/devices/system/cpu/nohz_full, '(null)' can be displayed:

    ❯ cat /sys/devices/system/cpu/nohz_full
    (null)

This patch changes the output to print a newline (or 0x0A) instead of
'(null)', making it consistent with print_cpus_isolated() behaviour.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/base/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c792ec66462d..e3cb47eae982 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -305,7 +305,10 @@ static ssize_t nohz_full_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	if (cpumask_available(tick_nohz_full_mask))
+		return sysfs_emit(buf, "%*pbl\n",
+				  cpumask_pr_args(tick_nohz_full_mask));
+	return sysfs_emit(buf, "\n");
 }
 static DEVICE_ATTR_RO(nohz_full);
 #endif
-- 
2.49.0


