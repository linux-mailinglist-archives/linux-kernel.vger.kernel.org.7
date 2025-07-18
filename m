Return-Path: <linux-kernel+bounces-736979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B2B0A60B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462493AFC71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F62D8388;
	Fri, 18 Jul 2025 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X2zQKUxL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37C81C36;
	Fri, 18 Jul 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848375; cv=fail; b=smOnzPoI74TrFc30J6THCjGCsUEAyDoBOdlh48sgBtV/Wy6XVVNKwW01LZrToAjv3CgwzS2tujGeHhrnFTEmRBMWXCNf93ik0tfJlwIY9/3/63/2ss1zmizGIworpv59IVYKs8TZNDR/9CUchOpXTr5x434CrB7fKoTi/Us0QrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848375; c=relaxed/simple;
	bh=akAa81vx63oEd+MVEy+n1i0MA4TNWIMlbkY9uqN4/sE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=phyqoe15HsdJrz4drWG6WF3jt+sr972fIO+PRDVTCE9bv5KUfrzvXWkiIbeXTme6sv/X8del31G8gopRy+V7wEFtJA9a1J4WbOilO1XbVSrVBUnETcjvxsR7rnWdHiQBTBneIXHdXbq6ZA9CIojuX1E+wtcZaxg7TI6NnIMzcs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X2zQKUxL; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrajgaP6HQuaxhq4rVlt8VFia8jQjIAGvrvcR4PYF9CxNyRzFu5hiidiItnK+CedmMF4UbGzXaF09knumZGuQPdwddqmYAEtNsToS1NuxCedMFdEhS9j/iFJI4L0I+MZL4+CntoQtzQX6yTi23nfbcHdSiBRB9MJ/tfeRRlpj0H9qtbDMfGox1+GJxdV/8toaqD2nPQmD59/SprVelMDJEOrVw7BCCbkPa8HsEpN+eYrRbACJDQ58wvpW/OxEolF3WKWCO5UDzNBWPgEAsrfOLFk9DB2yEl9r+Jr6RXyZNIlNXK+mb8HsdtDHklFXgKkwIHpZQXBMBGHIUs31yAyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIv58eMzt9TdT4xfoc2SeHQtJSxJQ9maedoz9YO0n+M=;
 b=WXl25z1TZvAlD61hDrwS2cQ9UP8JdLPVwvNNJai7nh643w/4EXaelP/uaZgrqhlitxRBFex3QScva2kcknENkQ79GKzVtBxjNPVQ2Ya3K37pGDIe80EUx+xU2OuD17psplXdD4fxufjIjXrmRXLl7aYk474EszIRTjH4WjCQ+4tzt/yspE+AWqkUWlRU3KxsMyuAkpZVJpD7Fcqu/fQX2T1ldtGKPG2Mk9iby9qPKhe04IhfM1aa5zjJd1dwiFrDjHZxS/c8EIm+hApW7Q7v+X5N1j2UkiG3UbBoYYMjkzCUoPfeFQOYY+pKDNuG9RvN5n7L1bgyJqaspGjbZ8yWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIv58eMzt9TdT4xfoc2SeHQtJSxJQ9maedoz9YO0n+M=;
 b=X2zQKUxLl5hkP5xVj3HL60dO9LdVNYn6NFefSwB0c7sagQEWfRdpzc42UOcKNKeOGxCKLOjIFq25K4dX4WkuLD8Ry6TbZ9x2DDRkfXxN9RQ0wGvrLFCbX5CZJqRab4x6+jJHnlIvdLGtnNJwtLtHoIDo7N64mJELLuVBjjmYXxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8844.namprd12.prod.outlook.com (2603:10b6:806:378::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 14:19:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:19:29 +0000
Message-ID: <b05156ce-2c9e-437b-9a69-7a3aae63d34f@amd.com>
Date: Fri, 18 Jul 2025 09:19:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/34] x86,fs/resctrl: Consolidate monitor event
 descriptions
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <7d999eb2e9435282339b1e6b39cfc5347664eadf.1752013061.git.babu.moger@amd.com>
 <9f7c1746-cbfb-48ec-ae34-155be9644fba@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <9f7c1746-cbfb-48ec-ae34-155be9644fba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 4689a76c-cb41-48e2-5bff-08ddc6061bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUxFY1Azc0tvTlJUQTlVVS9pSS91Z1dxbEJ6V1NITkZvRGxJdDVrVnNEeFNI?=
 =?utf-8?B?b3FDRGlmTlhCUzZIaVRXTWo2S3FpVC9POURVNGsvdjJlOUIzSFA4YWhJL1Bj?=
 =?utf-8?B?QkphYWVET3VnL1JqZ1FPRFBJdEdtK1RERENQWXNuQ3dvQnF1alAxdTlINXFG?=
 =?utf-8?B?UVdQd0gzdVBKTzNvWXJsQ1hvWi92RGMzZTVTUC91K0l2TXdON3Fvd1JCeC9m?=
 =?utf-8?B?MWMrRmc1V2pSNWNSb3FGZmx4RlRHL0M4eWFTTkZULzFlMUxsYURZVlpjam81?=
 =?utf-8?B?MW1tVDB6bHpveGVEY3B6Q2tpQVNlKzZOWXhrR2p3TGR6TmFsdkJtNEFBUG5a?=
 =?utf-8?B?bFRjTGtYRFR6Mm1rYjlSb0lRb1VSR3B5WHJkWG1PdXNiMGVId0R3RU1OcnJD?=
 =?utf-8?B?Q1ZKV0xJL0Fjb3lVNEkwZXNLSDBzdThqUmN5WUdPWG9Pd0RiWEhNelZkQVFO?=
 =?utf-8?B?K0RKeDdNOW1JVk1YNUlhOUp1d3MvQTlMeFBkRjM0K2R5aFI3TmQ2VFVHQnU0?=
 =?utf-8?B?dFJ0THk1V2dVdXNGdkNNc29XN0tZUCsrT2RTZ0d3V2tSaVRHc0FqNSs5MjYy?=
 =?utf-8?B?VHFFdS9pV1FiOWNzaDdtMDhBVnlxUm4vd0hHVS9EekNqcEtIUEZ3ZTQ2cGkz?=
 =?utf-8?B?TGlrM0NwN3B5VXBrdDlGVDV6Zm5obnVhWlVKclZFWjhkRCtFelZsTjg5d2tw?=
 =?utf-8?B?OE0wTjl3TTFGejRlSytHVXhrSlo3MmJ3aG16SE5mWHgxcW9BbHIrUU5KNDl6?=
 =?utf-8?B?ZThmak5qb1phck1uYU9zN3ZENzR6WGtvOHpqT0ovRE92RnpYejRhQWErMG1h?=
 =?utf-8?B?dmE5ZTIrV0lKUWMwU3RBZm9PS2Voak9Td1M2QWlyRlFQTENxM1dmckZtNXFZ?=
 =?utf-8?B?L0FhNjFPM2dwR0F0TFdTeUlDR01KbCtzd3lsRHoyTDdFMG5JUkE1bThISFh3?=
 =?utf-8?B?cTMzTEZJY3UrU01rcWhWMkNyb1lzd05WdHl2dkpXMERTVUZiMGhMT3FzellV?=
 =?utf-8?B?YzJ4bFBELzduTXJ1VTFzcDNMVEtnN2pGZGxhL29sWTlXUTVjaHBRZUdRVnRN?=
 =?utf-8?B?QXkvVkhxSEFpZEJCWVBBRDFlck5xUG0zdGVyZWRPY3VZMDJLdElNWmthbGdJ?=
 =?utf-8?B?THZlalNJTlhVL01HOTBVZGo3SFYxTGl5SnpNdm5LQWFJQ1FybDhDMnpLbFJW?=
 =?utf-8?B?MHViZVBlMDd4TDRCdnRWWXNydFpkSVFRckpweER6aEFmNHVUVGJQT0g5ZUl1?=
 =?utf-8?B?dFJVQ0wydlpKeSt1cHh3RlNreTNvVWtQWXY2aTk3ZXBpeU9JbDQrTG16elE1?=
 =?utf-8?B?S0IwTmJDOWlFV0lyMFJPYjVFajJYRThKTk43RDZWYlNleitOL0orWllOc1pS?=
 =?utf-8?B?SUFBcmlnVVM5QWJaZ2U5c2x3VUQ0Z2NaUkRjOURtU0ZwQ1prSGFqY2Rkc2Nq?=
 =?utf-8?B?RVM4NDZQcXgyUzJSdDBjRlcyckgzYVFjRmRDV1RubzNrL1hRUXE2UjhUa1Zu?=
 =?utf-8?B?bE9TcFNnTHI3bXJpVXBnL2lwamNReFVWOWZQTGZCS1BzZjlySSt4U2dHamZw?=
 =?utf-8?B?Z09PNmk4OWF3QXY2R2xJYm03UmJFYnpIQjlCNm5sUkxpTUNCMEJhNVIwWWla?=
 =?utf-8?B?ZTBNUjB3eUIyTHBvZ3hFNWo0MGFrekNzYW96a2NnMWNaTEgvNW1iWlBIMmla?=
 =?utf-8?B?UEdVS0w2WmJmdkRzVjZ2RGVDQnpKb1R5WG1Sc3VqRTVjMWhHZWJ2SVIxeW0z?=
 =?utf-8?B?QXpmY0JId3krT211Y0gyQVJOVHVCYThCbEtkMHdBK2VPMXpieG4rYm1pakhO?=
 =?utf-8?B?ZlFSbkRjYWkrMGlQYjNycW54SmJQekRqdFNuVUI0MS9xN3ViS1NGU3pKdWFG?=
 =?utf-8?B?TTNEckV0N2ZrVXUyVlBWeXdLamlhYUJXUFg5My9UNlhDTEkxOHdKN0hOdGhU?=
 =?utf-8?Q?bR6GGL6uaR0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzVNU1NnY2V3R1lZZ2hVR0VsTDdoQzhhS3I5dU5kTWVKeG43Q04zdDlLQko2?=
 =?utf-8?B?OFNjOS9FMUVDMHVBTjdrY3NqR3JSMzJ1cDNXU3diSTZlczBPbVhYcktxWlV0?=
 =?utf-8?B?Z2lkV2Z0SVQ4enNLZ1VYdWUzTk52VXpQVEZQSzYxTUwrb1ZHcG8xdHhSeWh6?=
 =?utf-8?B?WjhnZGRkL0pjd0lpdWRMK21ESm9JaE1VeG1JYlVHVThjRGFhK01rYnBnS01n?=
 =?utf-8?B?UHdEVEt6Q0oxV0dYa1hKenFCWFhhbGUwL01tOTlHdXFWa1p5T3czLzlldGo4?=
 =?utf-8?B?TG5uSVJWbE5lM1pyaVNxZGtNVFl5b0pwbEdhejVmYUU1OWkxZWhkbzVORmZt?=
 =?utf-8?B?ZGNORzdQazZZdEtWTHBkWFJHSUpYWGRQVkNVNksyanl4ZW5qZVIrNlgrOGZo?=
 =?utf-8?B?OHVIbVRKZ0xEcXhrNDhsU3p6anJ2d0tNWTFzVWhmcWNUdmErQ3pTVFBqRmpM?=
 =?utf-8?B?Y1ZsK0VEcmx2NWRGbC9DY3owTVRyR0g5UUNQcWZyU1ZqOFlCcyszMFFaSGZ0?=
 =?utf-8?B?RWdKNFBWWTNFZnR6QlhDVFZNNVk0cFFJRlJHT1N5a1J0VkNNUXZ1ZWdMRzA5?=
 =?utf-8?B?NGh4NDFhQytGQUZTeUx3QjcxT0xsUy9WNldGYjVkNGVMVlJOdFlPS056OEJO?=
 =?utf-8?B?TEk5ODk5UWlYakgwR21tc2t4WXJ6cE5KTmRqYS9JM1I3U0ttdndyVEFqSzVS?=
 =?utf-8?B?RDBPejdheWVBdlQ3RllseC8zM1h5SmJVZGExTTNuT3dXWVFWYWNMVk55eU1J?=
 =?utf-8?B?ODBGVTFTcWY1V0hTNmhBcXdhMk5ZYW91QXRRU2lDQ2Z4ZmNjTTBhQmtJMk8z?=
 =?utf-8?B?QzZIZm11S21OelorcmUxWVY3RWtZMWdGNGlhemxBTnpRelN1YVhVRFJJaGwv?=
 =?utf-8?B?bDVsOXkrNzZsSmxJRVNEKzRCbWJ0OTYwY0s2Y1AvYUd2VUJSd1hrZmxCS0Fo?=
 =?utf-8?B?VHV5VlJ0MGp6M2theDA0RUwyZFA1czJhUnhZYTRqSkFKNG45dUVSMlNrR0Y2?=
 =?utf-8?B?a1BvVjZLaDNBaDlPakRPK0dISS9HTElGeU5MKzRSUVNDTUd5Y0xLSS9XSHVn?=
 =?utf-8?B?VmQrM0dJUG9MZFpubjFSdWMxQTNyK3B1UVVWWFFyTW00Q2dpeXp3aFdMMDZh?=
 =?utf-8?B?b0ZDVjhuY1dZTDE3bGdwTVlGWThaT202UCtnNG1NWTJHS0haaWpESENKWWQ4?=
 =?utf-8?B?Ly9KVm1TL2FHb0NMWE5QSldnUVZ6UWp6NFpSKy9uZnU5cGFjL0VNTytpRmk5?=
 =?utf-8?B?V1IrUkRIUGdGRFVyTXVsai9mMFE5Z1M0L21tYjFMZ3lJQUE0c09HSVdFRlB3?=
 =?utf-8?B?YU9pR3pUS2o4aGpPUUEwcW13N291OXhJajF6Z3BVVE5BRStwNzk3QndtVVFB?=
 =?utf-8?B?UTZZelg2Sko1aUVaWURCRzJrd2JabytzYjA0RUZ6NWJxWmdtQjU3RXUzS2Nw?=
 =?utf-8?B?RVVTbk5IOHFNVFJEV21xM0xrdmZJOEpSMjVXaTlRTTFqbHRQQkV2dGlYbUM2?=
 =?utf-8?B?ZjZ3WVNudTFKN3VWMjBXQW8yR3h5ejBLcWo3Sk5hUmRFT1VuNmhXSFdpd1NC?=
 =?utf-8?B?N0lOdlFBRFR1ODdnMWRUa3dwVmM4K0ZEdVR3ZSs1b0daV21HcWRCM2RHRFdN?=
 =?utf-8?B?OXoxZzE0cG5ycmJXNTBhbHprZGkxZDliLzJNeTRPYnIrTFM4eWhOaFlHMDIy?=
 =?utf-8?B?MG5VL2NVM1hkSU9pN0VpSmNQV2NEL1dCdVJnV2lmbXNnK29CRVJxUmFuU3hm?=
 =?utf-8?B?ektiQnh3dkJVV0F1em5rMXJodCtmNi96RnFNUkFGMmU3Qm15cm9icGlSNjhJ?=
 =?utf-8?B?UWw2MlJrMnh3VXZyTmxiekhhcEExUGR0Z216dkZDc0xLdkdXbG5DWjl3YWFH?=
 =?utf-8?B?R0FGL1NuQ3ozT2FIc3hZZVpqMzlQN0tqaWx6dUhEU3hvVlNJSVNvTXhuN1dq?=
 =?utf-8?B?ZVJjQndRL0tXK2NiOHR5cFh5V1EvbExFQ3c5YmN3ZnZnOVdzblNkeGpBVEhn?=
 =?utf-8?B?OWozSFZ0M0IxY0NLV2JSWVVOcDNWS2owdzNqKzFWcWc2K3dtNEdZVnNweVFT?=
 =?utf-8?B?aE1PZ3BUWnF2SDhlc3lNS05mQTlqSlpzWXVKRUtKaUQ5OWZ5MTJtajNWMUlp?=
 =?utf-8?Q?SNqg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4689a76c-cb41-48e2-5bff-08ddc6061bcd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:19:29.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW4bNtMDFrt7oCocCn3W2c4NuMahrC11j8xpptH6p4+OTWvMvmQRc2PvlO8tMlki
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8844

Hi Reinette,

On 7/17/2025 1:43 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> Could you please replace the first four patches by most
> recent available from Tony [1] that have a couple of RB tags?

Sure. Will do.

Thanks for the review comments. Will address one by one.

> 
> Thank you
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/
> 
> 

Thanks
Babu

