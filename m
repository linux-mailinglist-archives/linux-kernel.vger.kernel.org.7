Return-Path: <linux-kernel+bounces-732295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6798B064AE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2401AA5B52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F42797AF;
	Tue, 15 Jul 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uUNqhwMv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF519F464;
	Tue, 15 Jul 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598421; cv=fail; b=RhSSriWDV8qaVHjeuGw1zcRzIKGXv+M7hAX4zVHQYPEvia+6ncVGJ0vAKQ4jmjXXtVB4Neu4PtmZULYFPhJCgvoikzQF1OyVM8Hu1eHfqc9r3xAy1WAJa3LJNNLz9a2iRGvLdB9NsDZQHGFFGSGa/XClEniAI6n6oRyUdiUpgHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598421; c=relaxed/simple;
	bh=MkK8u+A9LiwCYAa00Q0CIfmbb6RSNnYEjILOUI7II+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pqaAfWic0R4cMYONwDfyMOXsOWHmjvW7BnGrq3HE+XS10peFdhSVBcyx5+FqStYQNuomijqTt6XeGTKO1NUKAGEu1FjKi9c/DhnSnijI2wAO1O72bXW4XF0aE3oVKGhWHO3+15S0zFqU0tQTSZ0VMatbjCkdfPKkEcCmQNGqznA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uUNqhwMv; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKTNzEpdjpYaNU4UFjJbgMdeN/unvkwssKBoWIJ/moaIo0O0hB91c48BAaOe8rcYAzQIhj+tDgcCWGeEZjgbjJRoWVo02Ck5zpP92QONYoDFGKuw/YZBAnSDkzU50YYWFq0N1QbGtKF1XVd1rBlZz7f/bjVJC664Mh/hda1Fc0Tp2IUZmUCzxzHeIBwWmPbsP/EtzH+S5g1mo0HDIDlmZMyejLVPR7Bse9RKOsXNzLvqm6G6ECogFHPciqvS4Nip5TlkoATXMVGtyTtI+BrfyKbEvAxTaQJ18w27cQ7JStXR+EQV3eks84o9J85i4uOFo/0MvItfTuJwReSiKN376A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDrATGbnB8oQjIICMqsmKUdk9K4LleXxbD71ay8k1jQ=;
 b=DlOLejmKEIULSrM6Qvo9x/jkceWk89U2W908EAw6P8EKg1JLK4d88huYsyHu5Brzim4XBhKlmSoOl3sBrFsedcHuKTqTGR4AIXvkCboUPA9gcfTkcXu7vdkCwY/A7TTLzQNl9bSS8y1q9BFFOemUD/p2sHv4hrs4LrqbbnZkHmmzHJjeReBNYZYMSf54u4srjNMFTLxNzvJzPPWUjZsn9H6IRe7CIGt7b77zXAYO08xpeduUl2YUi6GjSVgJBVj86Alf2RBluVrcqkEJAhGQbXuU/Mh/uBmRVYQFG7SefScDDiTe6rqDckAqUAJcpp7ADrnAKXJSVPHQQXunigwoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDrATGbnB8oQjIICMqsmKUdk9K4LleXxbD71ay8k1jQ=;
 b=uUNqhwMvjZKkf4VkDDzcDvj8APg5MvtKNF12B+lPt68B+d3jK9jjQ5kFapWHYK/f4tQYafWoYagc50qqqoy5QvYUTN4My/j2dm8lQH6mWoKS/5tTJeHhkbWyErJKr4b6jFueK13rHlmhoCNzRfh1KEK3MCwrwRE7rlwzSE0iVss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 16:53:34 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 16:53:34 +0000
Message-ID: <58532255-5e18-45fc-87de-fc8af9c12908@amd.com>
Date: Tue, 15 Jul 2025 11:53:29 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 08/34] x86,fs/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
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
 <e48edcbf4fe2c258ab8d38d9ff78fdb8849c353b.1752013061.git.babu.moger@amd.com>
 <8e4aa815-e08b-4513-ad41-9fa542fb4243@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8e4aa815-e08b-4513-ad41-9fa542fb4243@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::7) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0504c78e-17c0-4326-6f7d-08ddc3c022af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em91L1NCZm5uU2tScThha201djBMQmpIbEJta2wyUEpyYUZjaXo3SG8zRElX?=
 =?utf-8?B?U3ExZFFlcjk4UVRUZGUyeWxYZDFXZDl2VUQxaXpZTHBKa0x4QTZWaWVMdWpY?=
 =?utf-8?B?SXlnK21SeTVJWkt1Z0YrdGsvTVRvV0tiSWlURzA4Q0lORVR2OVBPTkJYZmJD?=
 =?utf-8?B?MnZsRVpUWStqckpLMDBFOGQ0cnl0R1BoaU9UU0s5OVVwQUsrYW5lajJVSTVH?=
 =?utf-8?B?Q2w5REdvSjVoZGxtN1N1TS9VQzI2SjBwS2s3bzduVkUrRCtXTjJxM1VQZWFN?=
 =?utf-8?B?OCtkcENiZUQ5N1VqWnNOMTI1QkNXTGYzemZ4TjVDd3J3MXRPSU1EWU4yOE9t?=
 =?utf-8?B?QlMyZDZtRFE1c0JoYmQ4V2xqbnNDaHhEZitQMWxHTzBsZVV2UkRVbjNMeTNt?=
 =?utf-8?B?S3B4QnlwaHlxaFlZdlk1cUZrSXBXSjRWdlRPZ1dtc3dlMFo4d0N0QkZCTGdv?=
 =?utf-8?B?dWh5d1VMUGFPbzM0eUJFalpoV1JJazZQaWUxOTZuWHVNQXo0eUhRQWFjMGI2?=
 =?utf-8?B?WERIcTJtK20vZXVIcDRnVTZjNnI3QlMwOGQ4YklSYitZOGYyNHA4K0NsU0o2?=
 =?utf-8?B?WFZ3Qk51bnBBcHpZYU8vTVBBV0FzQitsdkd6NmtqYTRvMm9CRXd5Q1ZDZ05S?=
 =?utf-8?B?YW5rUkZ2eDAyL2psbGZHVzBaUEZnakFUR3l2UklqMXpBMXgxR3dBY21NQmtl?=
 =?utf-8?B?S0laaDh3aktGRXk5KzE3WXJ4UGpQOU9JZ2pyME1iZ0dHQWoydE83Y0VDZjU5?=
 =?utf-8?B?WkQyc3QranA4Q3VHKzkyTldQQms2amladHh1OEVJeVJNdUl3VmVGL1hjMWtk?=
 =?utf-8?B?UEhIaHhLYithc2srTEgzZzZ6Y3FXR1lrbFF2eEgrQlNOSCtyNHFPVjVKOXBp?=
 =?utf-8?B?WmZkV0dQeWd0SWRyd2R6TmxiMGRPNE0rWVJpN0N2Skg3Mmx3aEY4YlpVZ0xv?=
 =?utf-8?B?eG9DVjdPc0cvc2hKV3h5U0YxRWFFaDduSURNV0xGVWx1S2lCdUwrUmJFMmhI?=
 =?utf-8?B?T3JpUi84cGVrTkRiQjE1U0EwdjdoMUVwbW1VTE40Z3lxVERkMndkek12TnRL?=
 =?utf-8?B?OVpUNnljR3EzVGU1MUtDcUljNDNMR0NwWFYxcnNrdERSVEtiQXI0TW9neXBV?=
 =?utf-8?B?ZHBHRHJlWXd0b2lnNzBKMFNETDlPY3VTd3RvMVpJT09qQ282bzBnK0pmcG5R?=
 =?utf-8?B?d1VwMktINHVEaytWSWtOWUovMlArQ3JiVlBZRnBWaUlmZWxrRHFSR3BsV2pT?=
 =?utf-8?B?NURESzhYSDZWUHorV0paSWl4SldQVE1aWWJPU3l2ZHQvc1NHVnRNLzBhaTFs?=
 =?utf-8?B?ZjJBUzIxcEtrVTE3Zkx5bEQ5dG9nTzhUczFBdURoVjVVc0ZmaWNrL3dCNUZU?=
 =?utf-8?B?ZERzRkxNcm9BWWF4NjNBT2dNYktJajZJNFUrN0UxUm5kMTJCL09aMXJXakk5?=
 =?utf-8?B?RnNnREVNZ1ovVjBHOSt0dElQZ1BpQlpjUVpPTWVjaHR4cE9XSGY0dVlBdVNO?=
 =?utf-8?B?SHd5Uk9GOFIrNkErMU1qRC94bkRsSXprMjJXWkFKcmphZTRzbU9pSURSRDdM?=
 =?utf-8?B?WU9IZVBMeFk4eXFoMzdEVVZPVEhzZnBBZnQ4K1E0UlhmdW5JUERiR3JWT1NI?=
 =?utf-8?B?SStITytZT0FIOEVVQVRTRGVIdy9BQ2gzMURwVWNRTDA0Slo1MjRoWW55SmFm?=
 =?utf-8?B?djZCR3NYeHgyZVNFRGsrTklMbkcyaXRLakVoQVRKZ0ZXTk1zSUtqSVVwS3Mr?=
 =?utf-8?B?Q3MwMUR5cWZVRFRoNHAvNWRTakEycm1FaURndTVTNmRHbGN1UWlQQjcxSW15?=
 =?utf-8?B?cVZuV3BsbUhGNDJoSWFjL1RKZ3ZXOHlueDN3RDlITHkwd1NOZ0JjSjVWR2FJ?=
 =?utf-8?B?RG5iQWx6WFNLM3d3ckRjU0RicTh6eFVHK2ptc1JwTzQ2d0hBZHJQMVplMVY3?=
 =?utf-8?Q?GxJ0dn1bySg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW9aQkJmZXFWSm9EVmdna2duNXB0aCt5bFNoSjdMN2puWVp6TVNzdHp0eDJx?=
 =?utf-8?B?Q1dFMjkxdEhxemF6N05HT2ZDOXQxQ2JrbllVeG52eVhkMWZLMUQ4OWx5Wm9t?=
 =?utf-8?B?U0ZPR1Vjc05ORThJVFJvem1BTU1JbGN3cnVwU3JldkFrV3RsUXY0SWthNElE?=
 =?utf-8?B?aUQ4K3FxeUVwYVVQQmJJZHRHZ20zU01PQURuMG5OcTZwdFpydnJ3R1dveFNV?=
 =?utf-8?B?RXRWM3I0a3hYYk00cG00cUduOFBkdmMrWngzOVJDZWZUa2ZDRklWSWZZaFRB?=
 =?utf-8?B?OGNnU21WUnR6b050MHhPNkdYYkNSYU9OaWJOMXZjcnhoQjRWdlEyalhHRFJ4?=
 =?utf-8?B?WWs0elErY0VwMEx6ZUoyc2xVcnNqL21ITkUyWmhqUGtqM3BiL0wvNVM0aGVI?=
 =?utf-8?B?NnRwZTBQbW4xQWw3NFVNMEQvSUs3NDVjZGdCYVVWbWRDTXE1TC9nUHhUeTZ3?=
 =?utf-8?B?NDB6R0cxQzBIY1FuRjhHT3NxZ2ljV2wxUzdkS0ZlM3d5MGJmWWpWbzR0VkIy?=
 =?utf-8?B?emVSS0d4NnNHWEZrc3BOU0JJa2F1N1d1UUtBWVN0ZXFDdGYwRTdvTVhmQkNi?=
 =?utf-8?B?MUdDeTVYNUE5TVlPYWwxejdZR1JkbWplY3drYUQxd2ZNYkNjNzljYWRGNTMw?=
 =?utf-8?B?NFpmREhuNVQ5Z0tLSGRxcW9MR3FWOWp1OFJjaVQ2WDBKU1hSaXNxT0lQS3pG?=
 =?utf-8?B?eVJyclpMRkF5eDVlWmd1em1GS0YybmxuaXJGY0RJbkhScnIrdXFuUmt2S0tl?=
 =?utf-8?B?UlE1OUphL3pmRTI3M1BWRVVNNk9zeUVJVWlTREJVRWhzazlCZkVSeFlaZ1V4?=
 =?utf-8?B?NjdxMEUvdWtzc29xekpMMkNvbnRLU29pTDhuS3l6TWh6RW9ENlJmeHJaVjdR?=
 =?utf-8?B?YVBMNnM2NTdJZk1uc01wVXEzRWNyMmJ5VjBpa3ZlUEdjTDJwT0NqaklsS0x4?=
 =?utf-8?B?Y0Q1QitIQzREbzloRUdyRWpjQzAyenAvNWJJdlk2UU5UOFFqeFFzTXlva1Zj?=
 =?utf-8?B?Y0FRV3Z0YXp4NnUrR0x5eXNlS0tnd0xoRjBublUrVktwWCtWT28wOE1FQ0Fi?=
 =?utf-8?B?TzVLbTFENWpWRVB4bWxvVjVXTHpVTXhtcm93OFYrS3VLL24rVmZvRWNWTUFx?=
 =?utf-8?B?b25QNU94NE1vcXQ4UXdYNXp4dEZDS0k1Wkt4U0l2T2prdUo2OU9BMTR5LzA3?=
 =?utf-8?B?aVRjbHRvQzJYRFJ0VjVrWTZNRDdYOG5vWS8zZUZid1ErZERmZ0NjT2NNN2JI?=
 =?utf-8?B?RGtmM3FHUXBXb0c3dnJXdytRdHlEVmw5WTFCc3h6SEw2aXlDbkl0RGtIa25l?=
 =?utf-8?B?ajR6UDI4WSt1akJ0QVRoL3RmTWxjSklaMFBTME80R3dudm9BckxsbVZSVFJE?=
 =?utf-8?B?V0pZcnFUYzJLTG9DaHB3cFpBVmNjTTJmRXhLcFF5Z0dWVVNYd3lxTlZUQ2RQ?=
 =?utf-8?B?SkZSWlZudktiVXFEMElZZjI2Sy92aUo2MU9kMGxmSVk0NlR1UnhUSmV2Z3Ba?=
 =?utf-8?B?L3lOcGZITnFPc3djbGl6cSs1QktUY1diRFpWS0xDbmk1TlZoWm14YUl1dG5L?=
 =?utf-8?B?RGMrclE3cG5yUnhzZ2svT01JcVFWM0xXTlZwajk2aVpNLzU1WDJEVUoxcDN3?=
 =?utf-8?B?WnFhYzB3N0NXUVpKVjFuY3h6Tjl5azZGVjVBNTBGaGpwa0xpT1daMWcvb3Np?=
 =?utf-8?B?SmxqYzlnL0RGTTFiYnJXSGRyRnBORlF3c2JCVnpkRUF3UXNVcy9uREVXZzdY?=
 =?utf-8?B?VmszOW9uK3R1S01XdWkvQ2U3ZjgzTmRId1FaM3lmVVl1ejVvekJpbnR1RWZr?=
 =?utf-8?B?RUo4ME1pQ2RFMEZVT1dUNU13VExRbS95RWp5dXdYZ3lQaklOcGltRVhydmx5?=
 =?utf-8?B?bk5yUCtjRXhOSzMvbisrS0pYV0tGazUwaDN6WFdIVW8vaDVaMzFjR0NKZ0lY?=
 =?utf-8?B?ZTBCcnByM3phMm4wKzVCQkV5c3ZieSt3blBNMjJPYUFtSE9JeVBDeDlwWWRJ?=
 =?utf-8?B?cXRwMmt4U3pzNzZoVWNpVlMvTDkvTmRuQ0dPT1FENXZpUTMrSkFEektNeVVz?=
 =?utf-8?B?a1NuYnRmbDRNRFNNRDlBQURUQ3lwbHVlQmpQTW1GQi9XekNMMytBZ29TK3Q5?=
 =?utf-8?Q?HKWw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0504c78e-17c0-4326-6f7d-08ddc3c022af
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:53:34.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5sq4DdBevl1cWS5EjhZYK4I3NA954ZQnNstykWDzjWLN9Gig9pVAi3oGgBklJTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

Hi Reinette,

On 7/15/25 11:26, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
>> Bits Description
>> 15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
>>      Monitoring Counter ID + 1
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).
>>
>> Detect the feature and number of assignable counters supported. Also,
>> enable QOS_L3_MBM_TOTAL_EVENT_ID and QOS_L3_MBM_LOCAL_EVENT_ID upon
>> detecting the ABMC feature. The current expectation is to support
>> these two events by default when ABMC is enabled.
>>
> 
> Did the right patches make it out as part of this submission? The above
> changelog contains text that was removed per
> https://lore.kernel.org/lkml/aca368e0-0936-4852-9cf6-688931e0c65d@amd.com/

Yes. Code changes are taken care.

v15: Minor update to changelog.
     Added check in resctrl_cpu_detect().
     Moved the resctrl_enable_mon_event() to resctrl_mon_resource_init().


But missed the changelog. Sorry about that.


Here is the updated version.
--------------------------------

x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable counters supported. For
backward compatibility, upon detecting the assignable counter feature,
enable the mbm_total_bytes and mbm_local_bytes events that users are
familiar with as part of original L3 MBM support.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>

-- 
Thanks
Babu Moger

