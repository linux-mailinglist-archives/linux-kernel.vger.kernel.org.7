Return-Path: <linux-kernel+bounces-739803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61283B0CB30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F4327A4C94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ECA23816D;
	Mon, 21 Jul 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3tQjxBci"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3222A7E2;
	Mon, 21 Jul 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127662; cv=fail; b=iU5P3d4wlahExP/u+Hr9eTgugj/8cx3iGiqhYHkZ4tT/Ckey5QynZaaiwV4XuFztKI58M2D+GhqPTwUhmFNw53gn3uiA1AYwjV30L3Xx1Xr1EXF/+mhgmiEZLsAkuYdlw4fOHCnYhWhqp9qBHOdpNAE8j9FSBOcAoQaAyo7ikMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127662; c=relaxed/simple;
	bh=4pESHH3CCMbkqGOasQy0q0nT+qsQjuqshGsn4NTzGaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JQgn5K4/lXhjGpOWYdCDV1u39FW3vYnbEf4P/e3NLLbKFMb4MSZG6rTM1NoeOp6seRh/NGHIM6S+Lq2dJm1IUHOswTJbZts5myudcnOdJWrYLAx2Fhqrqln59e68WUuqEa3qMAnG2FG46EiOuP1pdZiuGtS4K7EnnakrH/PlPIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3tQjxBci; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+zIXpVm1oP2hY0DAd1IIpw/HAV5FgfWmkz6Ok+ROq7lXvHD2BzzoLHYL+2ONVM26CC8Pvr/64Jx+kja5OEFumfhWP9J4s8rcfAyt0Y1L3pl8OxqCnk87ox5D2SPXSCZt9wabeZ5PF4p2ejfLV3SbJ8WSU51z7mTx7vbjjaeEVrfCYUryI+cWsdT9PlovYByc6LO2CJS36eqYRpqUVyLHfaqJCn4+hzjbKH1MdTQVJvv+Dxs5LnKhSNbzA9Ua3YVI2vbStvKbYJjFTg4BTZTAc90zF4OZRBtA6Yj2waLi/5zsRRfNsyhYoZvdWFNdt9NMsHMSX72bue7LjexWmJJEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp02bOwQ/mn8J1sOVaiVe5rlFNURULKgEXuOWtNATJ4=;
 b=AJ3naOgj87jtO/Ru3u89rba8sZGPxIhmObCoXBP6YXFsm2/Xd/lyEN6+jwPu+45TTRzaHwDnWdZS9qjIZH2ElHN3By8neLf4HipYZ2z7aygpShpzZ7Bj8wU3bmrEOOdw1PIV9mH5UVXgZrW6sUHSXEMqF7ZzRPtk+FKI/TVSSvqyOXotJEuMd1jZNcJZ1U0hAXJJHtA5ftQMhNMFfPdpOXhRNVvR1Fm38sn64w5HQf482MntyO7DsmQWa82EMP4ympWeCbk/FnlYJrej3oYWoti/r6mkdaRAXyl8//Hy+hBXqv4TOZLO7z5mItxxD9hIFr5VuV/GQibRcyHtNR9Tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp02bOwQ/mn8J1sOVaiVe5rlFNURULKgEXuOWtNATJ4=;
 b=3tQjxBci7ie/9d4gtlE1zPzVhScVKM1Vx8BDNPrbxTZ5WyUck0Sxtb0obqchucbpVdxdM++6G7nYGaOrEVIPgE+dXrczqN8spjpGkCWjUXMuAtJeQYRywHj3yTd5AaVJ61RHysleSpy22ri94Am4owmX5i6LqC4VBPRajWkhbZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Mon, 21 Jul 2025 19:54:18 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 19:54:18 +0000
Message-ID: <74e08aa1-cb04-4002-9f98-a1eadbfe6869@amd.com>
Date: Mon, 21 Jul 2025 14:54:13 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 17/34] fs/resctrl: Add the functionality to assign MBM
 events
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
 <70ef9637d73825ee5e7409ab04df1039dec0873c.1752013061.git.babu.moger@amd.com>
 <f45d9b7c-90cc-439e-b51f-5e7aa3d8ceea@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f45d9b7c-90cc-439e-b51f-5e7aa3d8ceea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbb9ab1-0fc0-4ef2-5afd-08ddc89060ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNkTWxweHArOUo5YmNmVmp0RlVjbWxKTGJEcW8zNjlZdHkwc0JYVmZPWUw0?=
 =?utf-8?B?MFhCSUZJK25SWEd3NDE1Y2J3QnBKTDkrZkU2UGl6TWtmZzFSblIvWGZXS3NP?=
 =?utf-8?B?QlJTbFlQb05yckhObm9NWFYwSjhjQlB0Qk1kVmZUemM0WEphK280enhCb01h?=
 =?utf-8?B?RElkVFpsdXRGN1JtMUMyR1F3eS84azl6Mko1NzdGZ01LcGpPcWRxcCs2STRE?=
 =?utf-8?B?ZTZMTWdrZ2g5SFRxVXFZTUxHek1pdGhsanFPQXhpZ2NIUnFCalRPL01kRE1l?=
 =?utf-8?B?a0tVM0hMTm5YSzhOb2p3ZDdhSW1QeGxCNHBVY3dYa0ZWSGdjemdVNFpBL2Vi?=
 =?utf-8?B?Y1N2NmV6Z2lqQVgvc2l4Q003Y1hjcUhKWHlRRUpwdVpiZGRWdklwMU40bG9h?=
 =?utf-8?B?L0VMZ0t6L1lPZ0NKemR1TlNmdVg3RXZBbkRWM3E4VklWV2QvbzFjVEVzRERE?=
 =?utf-8?B?QWxmVU1BV3J0VjJ0OWdhYWszcWk1MHdFenZVdzMxTXFsU2IySEo5Z3V5VVdo?=
 =?utf-8?B?bjFuQjNjWGRhTEVxMFJVeEVHZk5WOWF2VmV3SWpQcDMrWVhGZ1NFSklwZTFa?=
 =?utf-8?B?NVc0SDYyZ09KblZpS09iZ3h2RUdGQk44RDcrakI3Yjg3amZ4ZmJoMmU3UnU4?=
 =?utf-8?B?R2RVK1Rjb08zYXRydGxTMEpYbHdEWU9IbWg2VjJ1YWFvdUtDaXEzdW9xK0xU?=
 =?utf-8?B?S3ZwQytjSyt6enJBcGV6VWRqdVFBWUxDcHZZZUpqbFl1ejBaQ2VyVndYNVlD?=
 =?utf-8?B?MnpLWlZ1bTNkTlU3TlJhbFZjd2lIZ3JsS2NvMS82ekYzemJkOEY3K3QzOVdz?=
 =?utf-8?B?bndVNElLNWN4SHo2N1VWaDZCd2syUlZ2S3Y1dVZsTGlKQWZ0MzdJeTM1bzhE?=
 =?utf-8?B?YmRMK1RsZG1vdzNGQitOREFyUktSTkhHWTE2TG1RV0c0ZXV0ZlByVWs1emtv?=
 =?utf-8?B?Q0F2ZG4yVFhIVzVidU41N01rMTRZZ09KcEd4cG4yRlp4V1NiN29zK1MyWTRq?=
 =?utf-8?B?Rk5wY0x1Rm5OZmQwdnpjV25QdzloTnJQb2JtTHM0RkwvZnM5U0ZFOCtQNzMw?=
 =?utf-8?B?R3ZFYllSMzZXMUhHaENDVEFQZlRmWlQzeHBFcnFEVitOMFJSdm1BSFBMVVhJ?=
 =?utf-8?B?UVlwYjIxdkN1UmxXYkU3dENuMVlwS29UYmxDOEJzMHJHQlZwU0dTN1YxTXFv?=
 =?utf-8?B?dzF5NW0yWkZabm5SeEk1TXRiS3VNWFdEb1hKMHlNRVNKUmtURkoydFFWM1BK?=
 =?utf-8?B?ZmZzYmNNWWg5RHlEanR4WXBlRFdLSU9Mak9qdDByMHBSZG1qSjNIQWN4UGhU?=
 =?utf-8?B?NHllTW1iNGV5NU1LTHhaTkU5UVREUVRWY0JYcndDcldCbDE5aGRwVExTYUpO?=
 =?utf-8?B?dDF1cUh5YVIva2R5Z1MySHFuaWN6OGxnbG5yMSs2cWtTSjV6SDllazRnbDJk?=
 =?utf-8?B?Nlo4N0EzZ1JzRFVrVlFHTFA3Y0JjZDUzdGpMOWVWN3FEQVNzL2J3TDd5eFVp?=
 =?utf-8?B?ZDJGQXVyMkMyNk1QNGZvZXQ3T0haenhIWWl5V1NYQ1B5QzRTcDdaZVNHOGUz?=
 =?utf-8?B?SHFTdmdSOUtBTC9pZTZWT09ITVk1V1RWSmRwRCs0ald1NVllbithTi9MR2Zn?=
 =?utf-8?B?SU9pYVlRKzhzZzYzQzZPMkN0S2NFaVgxblZkV2wySllFRlJYckYyVm5oMVNC?=
 =?utf-8?B?TUlmUE5tZjV1dERWUUVoOWhZaFJUT21Sd2NFZUN1WlhCd0t3MGhtYkR5NkQ5?=
 =?utf-8?B?bDhIVmJpenN2QjAzdHgwU3kzTFZuOXIyNkRmcCtiRXFJWXI2bEFHYytidGov?=
 =?utf-8?B?MFZGbzlrSTQ0UW5YNm5KdzFMbUMrMUFudS9tU2pkQVhMdnpmL3UySGNaU3d4?=
 =?utf-8?B?UjVvNUc1VlpEeS9QNzhRdDFidXl1eVlSeHRFc1l3ZDZzQWJ1Tnp4dE1vYzh4?=
 =?utf-8?Q?SXm/wDlzwbo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mno2N0tOeHE3aWcyYzBBRGFmN3dJaVR4ZnhOR1dhSWpGc1p1Z1RwZkJJa09u?=
 =?utf-8?B?Sk1RRkNJa29iWUhETW1Damo1bm5ZY1RXQVdWSzhXaWgyNHBkSXdtaXlCOTZO?=
 =?utf-8?B?Um1OT05teit0bDZ6aHVLTUFkaGhUTGdSM2MrbzI5ajdkbVQ0a3hsY2dWQytX?=
 =?utf-8?B?VWVrTDk0OXhRcWVaeEdJamFGWnJUUGtRaVY2cloveElIeXBoTG5XcWxYdG9U?=
 =?utf-8?B?OWdSR3NGT005V0lPTTQrQ2RVaFJLcGhqYVAwNlh4aUM0UTlTTVJyeVFuei9Z?=
 =?utf-8?B?K1AvYzZMM1dSWXFvSnVleGc3NlBmYXVHcFdHS0tIK05FcEFvWGRHZnFwakoz?=
 =?utf-8?B?UE1MZC9MZXIwZHZxeHBvQ0xrYllPd0hXdzM3ZWVlREJ1R3FiaSs4VE5taHh0?=
 =?utf-8?B?OEZMdms5ZURWOGhzc09BdFRDcFdRWFVVUjhia1JvNUN1dzVwVkV5YnViZmFN?=
 =?utf-8?B?aGlyWmswSlN6cU83SUZmS0gwWnB0SUF2aGJ4WUFhMWJMcGt0Q1JQdjBQTHl5?=
 =?utf-8?B?ZXBRUlpyU0lwNHdFQ2RIbXN3cVRwOVB1UkFORUp0aytTV1hERDVobm0xaTQ3?=
 =?utf-8?B?dEVzYVRuK1dlL0wwVjM4RVAyalhQUmJBYlRqU1F2dGdQeXYzOVNQMnNaSUNy?=
 =?utf-8?B?VGpsZkt0TGlhekVTRUY1K0RTd3ZXZFkrdTdKRzNFdCtoSkl3anlCRWxZV0tR?=
 =?utf-8?B?M1BjQ2xFaEtJZEJzWThXSVBYTnVYY1NiUzRrZUdycUtOdTZLT3gwbmdOL1Ft?=
 =?utf-8?B?V0tvSXptbFlLUWpLWnE2dDlyQVdWMjN1QzBrWmNGNnNCQUhlSkRST0Rpalk1?=
 =?utf-8?B?YUlWVWdjUGYzQWJTNmFpcUllV0hYZ3k1emNKcGh3bW1rN1VsSVc5aGJacDVa?=
 =?utf-8?B?a0tNcVZ2TEtPYTNYdWpvRzF4VG00b0FXWGMrVGxVSXEycDkyeXowZEllaVRB?=
 =?utf-8?B?Y3FzY3dONXBjajNMMU9xRnpzR0Q0UGowUVI0RTJpSE5BcUZHcDZJY2J0K0No?=
 =?utf-8?B?enFGTjk2Ylh0bDk1TXA0OHZrQjdjemVNREpxSnU3b1JYQWFSWU9KSXk2YUox?=
 =?utf-8?B?SnhsVVE3QlhaWnFOeStmUVZCUHZwZHVXK244WENIaUFFbEQxZ0FMMFRWcEc1?=
 =?utf-8?B?RU9vWllmOTBaY25UMm91M1BCaEtMWG40bGhmL0FYUFV1MHZ6RGtQRTYyNyt4?=
 =?utf-8?B?WVdmcVlqc1VGRE1Jb1FYWTEwQlFPS2VDeGlUSzRVSjg1V1ZWdVZjbnprOWlP?=
 =?utf-8?B?TDAwMmxzejVVTXpnM3NackRKaDFJMHJtZVpUOGE2VzRHanR2bG11dGMydmZz?=
 =?utf-8?B?SmpYNk1xbHQ0M3U5eXFvOW0yZDhlbXJ2NlcrcExYYkdidFlSZGVpRHU0R1Vv?=
 =?utf-8?B?UCtqMlBsWCtMVll3MnhDMGlMcCtCaFRIbkhLS1VVdjZVRjNCUDUrcDJqKzUz?=
 =?utf-8?B?bWNRYUxvU0Z1c3R0WUR6TEkxR0dyNjF3amlkb0dOVVBwM3Jtd3huRVhXc0VZ?=
 =?utf-8?B?VEkydG52QWgrU3hCb0NXa3ZYeU02bWE3OWR3bUdjU0F4bFdpei9ra1Erd2E0?=
 =?utf-8?B?VW5tTVhIZjBjM2RiaDhtNkovamx5eXBoVGtFVG0vcW8rMkJTRzY3TXhjU2xq?=
 =?utf-8?B?alBSbmduMllmRExSVGN3VmtxSFNFaGpnOUpWZm1PTXpwQlF2ZkFqZmVUQng0?=
 =?utf-8?B?dXliTllLcWFhU2pQLzJNeEZpOFY3WHNWaHFoSnFuZnFzTXRUUit4T2NqUGdr?=
 =?utf-8?B?b3FSZndMYzA2b3lraUJwQm5RODgrcWN3aFZieXQyK0ZuUVg3eVAxeTF2eHhj?=
 =?utf-8?B?S0hPUlJWQ2dhUFVrRml6OWNwNFYwS2RrU1F6c05kWlpKcnNPZGFTakpjTkpH?=
 =?utf-8?B?cXdRWWdzaFRnNjJOdlpmc2NSWXVuTEZjREI1ZzNaa2RJeDF4Z2RCVThGaXgv?=
 =?utf-8?B?bXoySzZsWDRyYzRUSVVoam1hWEdjQTVRQnBFNlEwY0NPR2hxSHdydmgwNjM3?=
 =?utf-8?B?ZHhqSUZuUURFWkorVDNpbE1MS1pONGRONHROWTA0MjN2c25TaS9NcS9kLyta?=
 =?utf-8?B?L2dvT3pBMDhnMjRBd2o5REYyTVdsMERYOHRHR1FOZ21SS0xsdFN4ODJiZXNh?=
 =?utf-8?Q?SZSI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbb9ab1-0fc0-4ef2-5afd-08ddc89060ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 19:54:18.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1IyG3xAhXULZ5/uLf5b1OdeT27QGaEOxjBO7ZypuFUjHwxVPy6CdBkOmCQbTN8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862

Hi Reinette,

On 7/17/25 22:47, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
>> number of counters that can be assigned to RMID, event pairs and monitor
>> bandwidth usage as long as it is assigned.
>>
>> Add the functionality to allocate and assign a counter to an RMID, event
>> pair in the domain.
>>
>> If all the counters are in use, kernel will log the error message "Unable
>> to allocate counter in domain" in /sys/fs/resctrl/info/last_cmd_status
>> when a new assignment is requested. Exit on the first failure when
>> assigning counters across all the domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  fs/resctrl/internal.h |   3 +
>>  fs/resctrl/monitor.c  | 131 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index ea5c9fa932aa..8879e127a8b8 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -387,6 +387,9 @@ bool closid_allocated(unsigned int closid);
>>  
>>  int resctrl_find_cleanest_closid(void);
>>  
>> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> +			       struct mon_evt *mevt);
>> +
>>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>>  
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 11327bd8cf72..bb074773420d 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -952,3 +952,134 @@ void resctrl_mon_resource_exit(void)
>>  
>>  	dom_data_exit(r);
>>  }
>> +
>> +/*
>> + * resctrl_config_cntr() - Configure the counter ID for the event, RMID pair in
>> + * the domain.
>> + *
>> + * Assign the counter if @assign is true else unassign the counter. Reset the
>> + * associated non-architectural state.
> 
> Is this API only for assignment? It seems so. Looks like resctrl_config_cntr() is used
> for assign/unassign while rdtgroup_update_cntr_event()/resctrl_update_cntr_allrdtgrp() is
> for re-configure.
> 
> I think this will be easier to understand if the function names and comments match this
> usage. To help make clear when a counter is assigned/unassigned or when an assigned
> counter is re-configured.
> 
> resctrl_config_cntr() can be renamed to rdtgroup_assign_cntr() with its description
> matching what it does: (a) it does not reconfigure a counter but assign/unassign it,
> and (b) it operates on the rdtgroup.

Sure. Renamed it to rdtgroup_assign_cntr()

> It is only the underlying arch API that uses "configure" for assign, unassign, as
> well as configure.
> 
> 
>> + */
>> +static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +				enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +				u32 cntr_id, bool assign)
>> +{
>> +	struct mbm_state *m;
>> +
>> +	resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
>> +
>> +	m = get_mbm_state(d, closid, rmid, evtid);
>> +	if (m)
>> +		memset(m, 0, sizeof(*m));
>> +}
>> +
>> +/*
>> + * mbm_cntr_get() - Return the counter ID for the matching @evtid and @rdtgrp.
>> + *
>> + * Return:
>> + * Valid counter ID on success, or -ENOENT on failure.
>> + */
>> +static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>> +{
>> +	int cntr_id;
>> +
>> +	if (!r->mon.mbm_cntr_assignable)
>> +		return -ENOENT;
>> +
>> +	if (!resctrl_is_mbm_event(evtid))
>> +		return -ENOENT;
>> +
>> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
>> +		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
>> +		    d->cntr_cfg[cntr_id].evtid == evtid)
>> +			return cntr_id;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +/*
>> + * mbm_cntr_alloc() - Initialize and return a new counter ID in the domain @d.
>> + * Caller must ensure that the specified event is not assigned already.
>> + *
>> + * Return:
>> + * Valid counter ID on success, or -ENOSPC on failure.
>> + */
>> +static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
>> +{
>> +	int cntr_id;
>> +
>> +	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
>> +		if (!d->cntr_cfg[cntr_id].rdtgrp) {
>> +			d->cntr_cfg[cntr_id].rdtgrp = rdtgrp;
>> +			d->cntr_cfg[cntr_id].evtid = evtid;
>> +			return cntr_id;
>> +		}
>> +	}
>> +
>> +	return -ENOSPC;
>> +}
>> +
>> +/*
>> + * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
>> + * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
>> + *
>> + * Return:
>> + * 0 on success, < 0 on failure.
>> + */
>> +static int rdtgroup_alloc_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
> 
> How about rdtgroup_alloc_config_cntr() -> rdtgroup_alloc_assign_cntr()?

Sure.

> 
>> +{
>> +	int cntr_id;
>> +
>> +	/* No action required if the counter is assigned already. */
>> +	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
>> +	if (cntr_id >= 0)
>> +		return 0;
>> +
>> +	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
>> +	if (cntr_id <  0) {
>> +		rdt_last_cmd_printf("Unable to allocate counter in domain %d\n",
>> +				    d->hdr.id);
>> +		return cntr_id;
>> +	}
>> +
>> +	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
>> +			    cntr_id, true);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
>> + * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d is
>> + * NULL; otherwise, assign the counter to the specified domain @d.
>> + *
>> + * If all counters in a domain are already in use, resctrl_alloc_config_cntr()
> 
> resctrl_alloc_config_cntr() needs update to match function name

Sure.

> 
>> + * will fail. The assignment process will abort at the first failure encountered
>> + * during domain traversal, which may result in the event being only partially
>> + * assigned.
>> + *
>> + * Return:
>> + * 0 on success, < 0 on failure.
>> + */
>> +int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>> +			       struct mon_evt *mevt)
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
>> +	int ret = 0;
>> +
>> +	if (!d) {
>> +		list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +			ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	} else {
>> +		ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

