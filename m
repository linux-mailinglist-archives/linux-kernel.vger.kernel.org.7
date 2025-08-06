Return-Path: <linux-kernel+bounces-758380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1348BB1CE47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63E8F4E1288
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D163225416;
	Wed,  6 Aug 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YG1qOa6m"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D62AE96;
	Wed,  6 Aug 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514742; cv=fail; b=dM5hJ5eX1MdyzNpqe++NjrjUt7ipgwvv9Cbp01TyO4ogiDP4QJ6WqM0RinSMK7mj8zZ0T4XUmNcNpqRMHL/qx9IaWPKrL6jc2htjdsxjsYHMQTdTfQvfmx5w69YzUeDt6ZgA89PZPVfaQXF+4pQkumT5nq64T1+/U+EfxcFDr4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514742; c=relaxed/simple;
	bh=Qm861HYhrMH3XZN810eBKoXn4bzdpr854LUQH9r77Uo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTepEM8L+zuB0bjXOWGL3/guDu61UviU6RJ2DztcHSjHFOi2c+Wq4J33kWcqudrD/QiE3BU31zKqP8P0AzvaOlV0RO8dRGN56PQHNX5Zoh+mPM980U+RF/zE+tj/BM2G9TYzdOeFIWKlwjuRTqdBomTb+6kynsyM/kPBO3wsvPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YG1qOa6m; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctUt6o5Qe4u12LWHATd+vHc9kMzeqHb7RpzI5UqFL3xlojt2VCv1RZCFuwYFWVoebb5Gr1rzgAcAknyKnY7Ds3t6Xeq/St3uhj0eHoxg2gOu5cMjlCoXhe2M6rPGiLl2t8xo3ZwyCunQrqFUZJ2ShVtxOfqhLRkNdrJsi4zoZodYneeWT6MwgKYeK595EnE65K8TZSeul6SYdcLctxqs9Z7/MxJ123iVdZHzaej786wmPI9uvvxie/YJejWBjGWgY9qsKP/qR1JN17kPpT0tbtVRX25z2yANYmGmCGA2sTEyjLheE4lIlvu4/kBUZWWc4e3NWN8se+5eVJeJvx/SCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KP5ICGuC4pRL1zQYwEYybSA64AS9SMZlMnFazW+asA=;
 b=nv2k/rLDdfOUG9NM9c0vtns3CHT7IUh3jDA/tVxdUSZfd+PAaK0IorRTOIigNYqOl6q8YoZtnLfSmtEfgrH+1EsRrUxHxeA3QE3HBsKNGLOVxEoq5Rv3iaXd3OZT4A1yKDcYznz9cLwYI5t4Z8KIVV2o5Sz4tWMK1A3lXO0lqmOLM308P6xIm7/dNJPuWtXh4iZsitKBImf9I+dUuRMDtEz68BdsKySQZrHIeFltkY0/JyS+CJRPKzfdnuUHqnebco0PGFToITfSTLO4Pv2Rgx5s5InQ4O4fRSQ1Q/4zoO+rappEQOKVJYLblh5wwg+VoLmNrJB/ML47iA+rwQBzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KP5ICGuC4pRL1zQYwEYybSA64AS9SMZlMnFazW+asA=;
 b=YG1qOa6m9QhNakvpE9EtRkLNPaYhrzlZLHEBSyRMw71Ik7I0HgCrhorMAoWpZDR9czxDQuMBeOq+jjXqC5Zb0CUQjF1A3Yw1U8GPG6UhW1pSCr0Rjle0W4gios1s8JuMq7OGAu7MQ+dw+j3UwNYRa9sirjW0TyQubILjRGZSU9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SJ2PR12MB8720.namprd12.prod.outlook.com
 (2603:10b6:a03:539::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Wed, 6 Aug
 2025 21:12:15 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 6 Aug 2025
 21:12:15 +0000
Message-ID: <4b3e158b-2e27-409d-8b23-8fa042939132@amd.com>
Date: Wed, 6 Aug 2025 16:12:11 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 11/34] fs/resctrl: Add resctrl file to display number
 of assignable counters
To: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <d1073b4bc959cd57c40d26bd80b0cccc39748123.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d1073b4bc959cd57c40d26bd80b0cccc39748123.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::32) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 82866513-e0fc-4374-5941-08ddd52deb0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3FrVTZkZmZkc0JSQzBHTTQvMEJxQW45UXQ4cFRSYUVGcVVtclduNFMrRlly?=
 =?utf-8?B?Sk5Ub0IvR1FoczF4ZTA2ZGxaczAzbmVzaTl0aWt5dFZvNUx1Z0U2RU1YcDVU?=
 =?utf-8?B?Z09mN05yK2JXL2Q2M0JNdVRBZkhvbFhiVlN4aExHcTNpOU5zcnlSMU9pMWNs?=
 =?utf-8?B?Z0ZGNUUzT0RpYVIrV1kwam5lYlRIbjh6S2hpSk05ZEZWNHVlRFpVL3JTQWJY?=
 =?utf-8?B?RStZMzIyaWNQcUgzSkwxdWtaVlRsTEtaT3NZZGJOQm1VVmRaaW1DQnpRSE1S?=
 =?utf-8?B?bHRlQVV4bnVyRmp1cFZqN3dtSjlSanpVV2RhWHR2T2pTWFUwWGt5RmpvdlZN?=
 =?utf-8?B?eGtqdDdSM3hyR1ZhbGRtMnlCNHVxNnBRUUlyTWI0Z2VQYTcvQ0pic2NxS2h5?=
 =?utf-8?B?UEY5VldJdm5CWG9NWEFscHdSalRjOXFUY0E0d0dxVGxlclRCS0xNYkMwaUN2?=
 =?utf-8?B?R0xHTC9udDIyREZjRjZMbi9EWkZKNE1FQUJsWElXb3BPNkZFeU83Vm5Ja2dw?=
 =?utf-8?B?WHpnQWgyemVjTXV5TnNqWWRUelFqQUdJcHJuT0hEQUhmYWErekd1azQrUU9T?=
 =?utf-8?B?aWVGQi90Y0xRMWJRN1YrZHdPUkphRUpGRExCWEVJZmViZkx1YTRwNzU1SFJm?=
 =?utf-8?B?QmtnVEZUZDZiVjZnSkZ2clM5dnM5c1ZVY2xvMlkyRGc1cEVwc1VsRVB5MitH?=
 =?utf-8?B?Um9EOEFjTkorb3YrSi94bFgzRWRDYU5BYzEzK1lrM1lkcy94WjhzL2xmd3lk?=
 =?utf-8?B?blV6WG9VZ1U5ZHZLaisyQ2w4T1BwU3NDbWVzWnl4OExReUl1VFpNcmdodDZQ?=
 =?utf-8?B?SVZjYk5BVlJpa2JaNzJqSzlvTU9oU0hYakZFQ0tidGtKNVFuYkQ4dnl4aFFL?=
 =?utf-8?B?bUhLSlUrd2VqTXZHcEZ0T05IT0U4SjFUL29nYlcxanE4clJKNDh2UG1RMjAx?=
 =?utf-8?B?Si9xc0lzUkFoSFNkeHUzSXNVQW1tcktpOHNxVWptSWVYOGFKcG1FTDdpdWJG?=
 =?utf-8?B?WTUyODJvMHVlQUFaZzBkVDlPOVJUL1hZeElOZXVpb2RySHc4WXkvWHhDQlBl?=
 =?utf-8?B?RGhSUUtrdkFzenMranNzbDVuLzdiNkNDMUtEK3JoWG5uck9GSmxGeGZyQlg0?=
 =?utf-8?B?YWp0ZVkvWDJDc21pbGYzSGp2RnpsV05IdDRoZyttZzdjVUVTb2cyakgrRjlv?=
 =?utf-8?B?K1hlUC9keUJtSHFiRXl2WWpBMWtReW5IN0tIZ3N5TTh5RDFGR2tWbVpOdXNX?=
 =?utf-8?B?YmdYU05qYkJINGNPcWFka3ltU3NhRm5lcGl2TTE3alU2aWtMbEtBMldKT0cy?=
 =?utf-8?B?c2JXdlpGQ3RiOHpDVjJQUDE1cnMwZ1d5cmRUQjBzdWJ4aTlBaTB6cFFtY3Vl?=
 =?utf-8?B?YlNxZUllTktNTCsvWEtVK3g3NUhpa1RBeGJsQ0praEtyREgvaUxHelF0VC8y?=
 =?utf-8?B?dnVoVHFYejFXbUM5V1RXUXZaYkhDamNWMVpSZjk5Nml5OTFRRnMxU3ZRemxs?=
 =?utf-8?B?TVZ4V1dZcjc4YkRveDc5UzdGNkE5RnVPOU8yNVBVN2dwM3JQV21yMy90RHo0?=
 =?utf-8?B?Sm5YK3hzZlVzK1drSWdVbWkzZURGcWh6VkNpbFFSOHY1Nm1pODhoWE1IcDFP?=
 =?utf-8?B?Yk9KWUhJYmw4Q1d6QnNsa3RiUlRSRWtxTWozWXhuU2QvbHJ5YzdCTFByMjR1?=
 =?utf-8?B?OXV1RXVUaklpUjRtcnJ1WitiRlFFYjhCMTVQNUovNXAxVUszM3NyMnFqYnpV?=
 =?utf-8?B?UnBieW9xQktnd1RIWGw0OC96OEpkdks3QXZUem84Ry92aDFsWG1PNDRxZ3JI?=
 =?utf-8?B?aUc5VmVENWlYTElJSEZ3UFRCbDQyTmFBbzBObkltcWtpVzBra1RScm5La1Nr?=
 =?utf-8?B?cGIyNkVMK3VWWHRtMjZVNG1oOGtYbzFvRTFmKy9nb1JiU3YwL1VhNHo4cDlM?=
 =?utf-8?Q?vR+1OGh4MQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXAxWTArNzMxWVB6ckI5Nzl0b2YyZTl6VWZQRnMxZFV1dTJsdHpEa0ZKa2wy?=
 =?utf-8?B?U2FYWnpXUmhrTENJVW5DcGpJc25JSXpMV1Bvbkc5QWJWVTZwd0hOMzdGNGFt?=
 =?utf-8?B?eEp4QVZoVXJLaGQzVk5rS1N4VFFzUEhla0ZXaHM2MU5IMDRsWHpFdmRiNTlJ?=
 =?utf-8?B?ckxDWmdVcGZPYWZRU2FxM0V0d3JiTUw1UkJrZE5pV1NzMDNSeFk2OEdBZHls?=
 =?utf-8?B?dVVyYlQwRUJ6aEppUlUzTllHSGZmMy9sMlJkRnFSUW4zdFczRkxBMTZzT0hs?=
 =?utf-8?B?WGo1Z3BwbEhhV2lXbWhva01xZFFta1VOUDV0OWhjODQ0Z3FsMHVQbSsvNnNx?=
 =?utf-8?B?ZGpoMVQvUzFKRHlKYVJmWXJaUHJKK09JR0tDcktXWDhBQmsrZ0lvU2FjN1Rx?=
 =?utf-8?B?cERwYlhsSDd2K3NoZ2RMTzVYeDhna1Z5N3d0eWtWbDIzdndNaVkwUnlWcjRC?=
 =?utf-8?B?eUZZUXo5eEpnczRnTHZHcGh6Mm5Id3VYbnluSGRNVVlnTXZ4c2d5SEVLaHZS?=
 =?utf-8?B?RUtZd2k3UVQybHBPS001cm02b2FnNVMwcWYzemxIZjRINW1ob2thdEx5Mi96?=
 =?utf-8?B?YkdCM0d5dHJJVzI5OUJSRFFCaE5GVGQ1dTRCYWhBU05kdGJnaTZ6dk5YT3Bk?=
 =?utf-8?B?S2FOUGhoZXlMOVNSZzBqZzZKT0dZd21yaDd5R2hHRXVQQXQ3d01NNEZpTkJ4?=
 =?utf-8?B?Q2xxUHh0SW1hdzlzbFZNTXgzbUttZlE0eEp4c2FOTE1TK3hMVCtla0JDbTVx?=
 =?utf-8?B?YkM3ZVJ2aUdCc3NwUjh2MjdDcU92THNiQ0d4VmR0bUI5RGNmL09jaWVpS0Fm?=
 =?utf-8?B?dzE5RktXbzJmTFN1Mzd2NFdNNi9KQkovTGxjTEdQWTRlcDZwcVNmNWp4UEZx?=
 =?utf-8?B?NHlQNWRXZUE2dTY2VzJKbUxYWGRnQ0UxTUtUbDRpeXZBL0l0UGFlMjZGQkcz?=
 =?utf-8?B?MSt6QXY5WHdXMUpDdVo3QjloWWRLNDJ4Z1IzNFBpTVhleFRCU2ZvY0JsdTFB?=
 =?utf-8?B?OUYrMVRxTmJQVFJxcFV3WDBWeG9CcXp6MFd3YWtiNThSUVY1T3J1RnRHNmMw?=
 =?utf-8?B?VVUyVXpsdGdqajZKL2hVZWh0MEtMQnNVVUJVK3NZdWJTQ1ZWbDNXQmpGYjVi?=
 =?utf-8?B?SnVrczR0QXVoektaRFp1TDZyaGJZTzVzckQ3dSsxM0NodUs3di9kaHJSQWp3?=
 =?utf-8?B?VHRNZVFjNkUzc29LNHZFZFk1UmFWRGhrRHR0eEl0NzhHd2g1WnpjMUdzYzdw?=
 =?utf-8?B?NUUyZStDRTV5S3BjTHlaNlBIdXBjN1I2ekVOOWFNYzcrbGFpbXdZSnFxWWI5?=
 =?utf-8?B?YnRoZGRzSGdaZ3pFY2ErSWt1YlJVQUFraEFTVkVPWUNKOHgvSkRnZTNTck5r?=
 =?utf-8?B?OEY3amUvTnEyOHVCYjJUTUl1ZHJVcWQ0TWZBdkVpL0x0My91NVMzTkNXRFI1?=
 =?utf-8?B?Vmp1dkJxdlIweFNITDBnV2dNL0llRUp2ZTl1VzBoVEtVbHBCWGFaaVZ0VEQx?=
 =?utf-8?B?a0RFQUIyL0kvTk9BTVJ4MDk5MDlHYVV2SVlDNEJTS29ZcjNnOWhUSzZJN29S?=
 =?utf-8?B?a1F1WFh5cGZ1SUpoMDRDZkllRmsvUTcyMStvUTBieDlJTFJhUEhaUmttRFpO?=
 =?utf-8?B?QTg0Qi9oVjloL25NeFM1ZGlHaWNvRlkrSmJxMkVXUU5QY3Nna24rNkI3d1Vr?=
 =?utf-8?B?TXg3SWs0RnNES1NlSjJwOWgwc3dUUHFGcjB3RGJ1UkhBcUhXNWFja1JnVUx6?=
 =?utf-8?B?Y1ZoU2tUWmhpYkZUYUQxSmdwczJIdzlJLy9YZzhGOElBajRPVTJOVGpiVklq?=
 =?utf-8?B?cUtVMUlicG1OWk1HTDRjMXp6N1E1ZVJTa2pPb2tpOHIzK00vYnJJV0FCUjFs?=
 =?utf-8?B?UkJHVGxmY3p1eDUzNzZxZkZvRlk0OTZJOXE5Nkg5bjhRWFROUWN6NGtWUGlr?=
 =?utf-8?B?NGFLaFl6VVFmRFBBZ0FhOHNpUVZobisyU0FpUjRGUlhPL2d1VFQ0UGlxcHFo?=
 =?utf-8?B?S21zcUVVQVU2RTRrY1VwSmV3bmtFMm10L0U2ZUV4WEhZb0NKaXMxRDM4aXlB?=
 =?utf-8?B?QkRBejY4SXpENXJOUjN4cFRMb1lhSEU2QitzcU16UDFhcUxZWFhXdWRPWExq?=
 =?utf-8?Q?v4fM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82866513-e0fc-4374-5941-08ddd52deb0d
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:12:15.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TduYQv48uSOdEpt23kguUWo6C9i4nf01+DJGpcz6vdUOKPKW4cEeklyXKFiRsovF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

Hi Reinette,

On 7/25/25 13:29, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned.  The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user.
> 
> Create 'num_mbm_cntrs' resctrl file that displays the number of counters
> supported in each domain. 'num_mbm_cntrs' is only visible to user space
> when the system supports "mbm_event" mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v16: Added Reviewed-by tag.
> 
> v15: Changed "assign a hardware counter ID" to "assign a hardware counter"
>      in couple of places.
> 
> v14: Minor update to changelog and user doc (resctrl.rst).
>      Changed subject line to fs/resctrl.
> 
> v13: Updated the changelog.
>      Added fflags RFTYPE_RES_CACHE to the file num_mbm_cntrs.
>      Replaced seq_puts from seq_putc where applicable.
>      Resolved conflicts caused by the recent FS/ARCH code restructure.
>      The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.
> 
> v12: Changed the code to display the max supported monitoring counters in
>      each domain. Also updated the documentation.
>      Resolved the conflict with the latest code.
> 
> v11: Renamed rdtgroup_num_mbm_cntrs_show() to resctrl_num_mbm_cntrs_show().
>      Few monor text updates.
> 
> v10: No changes.
> 
> v9: Updated user document based on the comments.
>     Will add a new file available_mbm_cntrs later in the series.
> 
> v8: Commit message update and documentation update.
> 
> v7: Minor commit log text changes.
> 
> v6: No changes.
> 
> v5: Changed the display name from num_cntrs to num_mbm_cntrs.
>     Updated the commit message.
>     Moved the patch after mbm_mode is introduced.
> 
> v4: Changed the counter name to num_cntrs. And few text changes.
> 
> v3: Changed the field name to mbm_assign_cntrs.
> 
> v2: Changed the field name to mbm_assignable_counters from abmc_counter.
> ---
>  Documentation/filesystems/resctrl.rst | 11 ++++++++++
>  fs/resctrl/monitor.c                  |  2 ++
>  fs/resctrl/rdtgroup.c                 | 30 +++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index b692829fec5f..4eb27530be6f 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -288,6 +288,17 @@ with the following files:
>  	result in misleading values or display "Unavailable" if no counter is assigned
>  	to the event.
>  
> +"num_mbm_cntrs":
> +	The maximum number of counters (total of available and assigned counters) in
> +	each domain when the system supports mbm_event mode.
> +
> +	For example, on a system with maximum of 32 memory bandwidth monitoring
> +	counters in each of its L3 domains:
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
> +	  0=32;1=32
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 66c8c635f4b3..4539b08db7b9 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -929,6 +929,8 @@ int resctrl_mon_resource_init(void)
>  			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
>  		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
>  			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
> +		resctrl_file_fflags_init("num_mbm_cntrs",
> +					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  	}
>  
>  	return 0;
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index c7ca9113a12a..acbda73a9b9d 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1829,6 +1829,30 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
> +				      struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
> +	struct rdt_mon_domain *dom;
> +	bool sep = false;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
> +		if (sep)
> +			seq_putc(s, ';');
> +
> +		seq_printf(s, "%d=%d", dom->hdr.id, r->mon.num_mbm_cntrs);
> +		sep = true;
> +	}
> +	seq_putc(s, '\n');
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return 0;
> +}

How about moving this also to monitor.c?


>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1866,6 +1890,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdt_default_ctrl_show,
>  		.fflags		= RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
>  	},
> +	{
> +		.name		= "num_mbm_cntrs",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= resctrl_num_mbm_cntrs_show,
> +	},
>  	{
>  		.name		= "min_cbm_bits",
>  		.mode		= 0444,

-- 
Thanks
Babu Moger


