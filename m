Return-Path: <linux-kernel+bounces-741674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40CB0E797
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D7F3B2054
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB03FB1B;
	Wed, 23 Jul 2025 00:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PgjYWJdS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0778F26;
	Wed, 23 Jul 2025 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230429; cv=fail; b=F9VM4wAEn5Rs+DdLpcKdLUBW5d/1pBXGbIXDgmz/FbDYqsee95WKjDubOXZzaHbFsWlHPmawvXT4YawUO2lpWrkbClKvQtAC8smSt7sSa3+SxL8Icg0JCJPR1bb3U+E3QqdaFfuAirQQmfdC+jeOrxY62KSuOwsSTiL0GKbui80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230429; c=relaxed/simple;
	bh=IglcQ2O98oAxPqOSY9Ax+Sd++ZMfUGkpkKV2CZUac38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YtfKnyldIFOpnwbNYwRhEFofDmBBYiEeD4FaoRrhH7sR4ztRmICe3vB2qj+EeQAsbY/Qpn5vnB+kcxfYaWCCzP2VFvMgasfMz9Nguj2fkyPns9WssBHcr7PwmADZSybHMp9/x4noMM3/qJsq+O64DZte04aaEOUOivWo1g49Las=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PgjYWJdS; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKKkCzSqUEwQVD9yJIhnU5Vc7UIb7HtSMUlw+UpjQE/Uo0eucjLk/ot7SjBDSjbUyMZAk/8rw+taqQ5q/OMFIPXsbBYPpSxJafvut+G7eyL5zLrT8n5qhE5VTt6btfSe5u+5GWfhnOZFyQ5cw/WiAvVRcF4Q8d/kHEYHzyjlkZvBjk1nS0djJRn01wbjsZ5Z9pa6UKxAVtdlrg4SUfqBhnJj/8H2v5lAV2edTxTcpx4W22Pc4N8NEdk5WtDXNRKHJ/PYnYiX0v9qdk0TtCwQVWEUJlolYe+Dqlak1Y0Y969gMAU85PQUpRIouH6JOlQOUDLiKOSBbFJCWLDggtvs9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2gLI27kmh2Qunlqp9tjZqQWCK7JMkxv9+KI54brKWA=;
 b=AJSmfO9/vt9BdV1eePFXfOkJieNpxUxc2SQssmMfCIZiR+XcMKjBekVkL1D0R+ZqOwC9fdJzVPzRlw1N9khfEygDVpkBWe/dwr/czZWUS5E37cefEc56VLqOGsysl79H8hgh95/Qa0E8YcoyP3f3fwWqz0Mc4ThiGnf8MEGr7CnQWiXqaLlN+G/CSQ0E5GzK5FbyJ/DX+hW9Gu+9YYJT0km+Jlv1NGZHJWwKm+OBJVWn+U6hLKpl1zTIyED73dCnry3Dnl4ndVj2Nrn0vgw8VEuhF2OzzEMt0dJ2mVp0b2lBND7KRBVpZspU++2boaCtVyfTGWHzVMc+Gs5sC6Vo8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2gLI27kmh2Qunlqp9tjZqQWCK7JMkxv9+KI54brKWA=;
 b=PgjYWJdSvjp2DZCSnqOYfb+fUcC0J2IPDhBzUOUI/nR0KgeWqbttwyTYK96p+Y7p8d8d//bUqlmO9UVQLYLorV8OrzfeTXP0SfJA02Gpg/6b0431L10+C234DVzFxVgEHm09ztUVDaVHSz8DztmvoYyMAVt7AAPJvigyMntaiSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 00:27:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 00:27:03 +0000
Message-ID: <37f2b5b1-0e99-45dc-bba3-c8c22fb298cf@amd.com>
Date: Tue, 22 Jul 2025 19:26:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, tony.luck@intel.com, james.morse@arm.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
 <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
 <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
 <791ff5e0-dcd8-4bfc-810c-b085bc4ca543@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <791ff5e0-dcd8-4bfc-810c-b085bc4ca543@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a62d1c-a62f-4e52-dc4b-08ddc97fa4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1M1ZWtaWUJZb0lCSTIxYzhpZkZqM3NnWXdBZlBEV3U1aVZYVWFpUlpoNmFp?=
 =?utf-8?B?dktST0VRR0ZLY28zSUJ5bTNYaUxzK3JuREM0Q3o2WGVIMVlaZUpMVUl5dEdY?=
 =?utf-8?B?SnE2K3p4QVpPTytQTWZaZ3Q3bW1GVHFyV0VCcVIwa01nOVJWQllxL2k2dkJL?=
 =?utf-8?B?Mms0eUhoNFdaQ3lDbUIwOTNpTVd3NmJwY1V2K2JWa2owM05icXpBMGgvdzMw?=
 =?utf-8?B?NTR2QWhYTmI0SE9OOCticjV5MUE4R1N6UkJ1djhjTkh6SWZKWTNpamJ6MzZR?=
 =?utf-8?B?WlZuRTBCcStJNTU3UksxSUFlWGszNi9kUTlmN1dZcWNFLzZTVVBKQWJMZmVM?=
 =?utf-8?B?NzdvdTdUZGFwcDhYdFpPbEU2NVd3MDdFeXpoand3a1hJK2Z5TzRJNmxUY2dN?=
 =?utf-8?B?YThwamk1dVRhaWtNclNlWW5WaE9RdzZiQkV2bEE5N0NMU2ZLOXFINGdSQk41?=
 =?utf-8?B?WnZYUFc2SWJOVHQ0T2hSSXhsVlRaN1VJeVl6QkpiY1liMWdvRFU4RUhwTzZN?=
 =?utf-8?B?bU5wRXpiSHFReUwwaXIzaVA0THc1b1JVTGhsWVdzQm9RS3Q3RFZiTWQ3SWw2?=
 =?utf-8?B?UnVsS2E5aGhxUm9laVphVXhYK1FvbzZVb3BxZ21mM0Z6MFplTlZLR1VGbmpp?=
 =?utf-8?B?UC8rSlp0dHZXeFN5dW9FbUkwYkJlTW1haEkzZGV1NzFlWTAxTDloTGRTSUU5?=
 =?utf-8?B?RjRnd2IwdXZSdGVON1JUajZ0THJncGs1WHY2U1VSV1BzQUI0NjlYdjR3SFVS?=
 =?utf-8?B?VmFSTDJaN1VZdlVVYi8zNE42ZjlkTm9LMlB2UDJzWW15REliVzlSdE1ZUTFB?=
 =?utf-8?B?R1VDWGkveGF5ZHp1VzRQcDYrV2NxMVpwN1dYN0FhOEVnWUJPcVJHbjZVZGVJ?=
 =?utf-8?B?UVZZK0VUdXVkck4vNytuNmQ5L0JjcytIU1N4ajRNbFR6Rll0WG9TcGt3azky?=
 =?utf-8?B?M1A3bmZCUmI2SWV3THg0MnVMVVUxbjJKWlVZVWlqVFc1cm5Mb3RzN0xRNjFu?=
 =?utf-8?B?OEdZYzNrLy9HNXlwN0szSW83eWhWRDVYN1FsNEVxckFIR0prSzZKT3M0T1lm?=
 =?utf-8?B?MVp2Mk00UitsRk5rVlJUcmdJS3pYckhvdmJ5MEI0dDlJWERzQ3BFc0t4MTl0?=
 =?utf-8?B?YklwRmh5V1Z5b21ibnhwSUNONjVxNVFvcUd2VmFMcW55cDBBcTFUN0g2WnB1?=
 =?utf-8?B?VjMveDBibW0vZTliVlNNNUVGbDcwSEQ1MzhYeThiTk52eWZWc0EwYTZrUnZV?=
 =?utf-8?B?eXBrWlcxcDJ6eGw0MWY4S2xRajlqSEhWU1RWZ2JwOXdHK21HT1ZzbTgwOTZp?=
 =?utf-8?B?Nm9qaExmamprN1IrY0diWVJaTFRWL1dTNHlEUTA5UldvaXRKZ0MyOEFJMnZ0?=
 =?utf-8?B?S1Rqa2NkYUlyT054UCtuVG45MytUUExOOEhQK0p6ZU5SV29rZUZXZGZJTnZM?=
 =?utf-8?B?RmN0RnNBeDE3Zno0M3NxNUpJSHBMMFBQYXFFYlVMd3FUYm9LQ3dDN0hML1Rr?=
 =?utf-8?B?cjVub0t0Y0xvOXdxRnRqdnVYazIweHp5WWxGK1p1ZjZsRVZtTFhxSjNGb1VC?=
 =?utf-8?B?MGthWGlaTXJ6U1kweEJUQ1pBTnEyMVROV0lGQTFtSkg0K244OFJTdkRkK3Rw?=
 =?utf-8?B?bGFXMjhnRjlxd3JWL0hqeFlvTXI5U05QaStUWmVia005aVh2SUQvdkJwL3p0?=
 =?utf-8?B?cFZ1bnJLN1NrdmFJaE5mU3puVHlJalNKQW5BZmR2OWZSOUN1TDZHeG82eGI2?=
 =?utf-8?B?Znk5bVVkMjl2VDlDSi9TZ0w5SVhlVGhRMG51S2dIZFpTOXc5c3lhNWw2ZGg3?=
 =?utf-8?B?U3dldWZkOWlGSFR4bEwwaVM0Z1B0TmpLbW1UZ1FBNWg4dWFUaUI4NVNMYW9w?=
 =?utf-8?B?ZjU0UlZhRDNuQjVCcjVtdlRoc3RuQTlYN1BpUkNPdzlsck1YOFpjZlRrdkJ6?=
 =?utf-8?Q?udkH6y/9uQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE0rT1UwWGY4UVJ1akFCNWJFK0tZUlgxZSs4MUJjclVrQmc0S20yTHgwd2Va?=
 =?utf-8?B?Tm9yREZ3aTJ2a0EwZ3ViLzJxbE12Mys0NW1tLzg0bTlEbFVmZXNyZGpmN0dR?=
 =?utf-8?B?T2ZMY0FURGl3K0N3NEMzU0pyejlzd0w5anNIS3ZEK3FzUjQxdEsvbjBRdmFT?=
 =?utf-8?B?RzczY1lWK01kcTQ4dmg0dXBEeXVuWVdhK2ZONjZCMzg2V2hTY2pYaGJaakg1?=
 =?utf-8?B?WUEyalphMi9aRy83VTdhYUZSZ1lCNkhSYkVtcllsZUdwbnJielFXV0llVnJy?=
 =?utf-8?B?Y2haWDFlb0xLUnpvWWwvWjgycXQrSUl3T0xxUkIyUWFXTG9hUGNtK3pDc05E?=
 =?utf-8?B?RWF0Umppbzh3SGRzK0xhSVUyb3dyUTRSdG5vb245MVpPNzNiTkc5T3MvdVJq?=
 =?utf-8?B?cVkrc1h5NUdvdkVabzRvUytuZDhjK1VUajFWcFhLK1pwelhEZnh6R1RtRUxI?=
 =?utf-8?B?blhEYVBUbDJ6dzlyNldONU9LcUQ2NmhvMHpGTHlNUE9qV3dMQmVXakxZcWRq?=
 =?utf-8?B?SWdjb3QwMGZUNE1FenZRaXBNeWRZUnlxcGVkWEZhdWtNdWJhRVZFU0RURzh6?=
 =?utf-8?B?RXQ4K29tQS9lUXhnd3FqZDBJYWpPK1NsZjh5RkswczlTMTJsWEZkWTIxcUZJ?=
 =?utf-8?B?eUR6M05COENzVXJQRloySXNOdUEya1pXY3ZFeW0zTmJiTmNPK2FBTjR2dXBt?=
 =?utf-8?B?Y3ZTSm1xdmhkY2FxeGQySmxMaEZVRTh5SmIrdklncUkza0pHSWQ2WWh0MkZz?=
 =?utf-8?B?ODNhWFFOc3BmMXVMVGJJZTVuT0YzcnZiR3hxWWhGcllVYWQwMHBUZUp4akxa?=
 =?utf-8?B?TVJzSWJ0am9TUDVZMWlSV1BCT3U3ZWhLSzl3bUwzd2pCQk5aa3plNGJkZmEr?=
 =?utf-8?B?eUNUTEM2ZExCb1BWNFNrNWZIakNlL2ZQMi9zM1J2OGtyN3FWTWhSS1R0Nkwv?=
 =?utf-8?B?VHUwYm5zNkpwZEZ6WDVXQXBSeVlESEx5RUZyNnFlUFppcUZ0RG9hUUpyUm1G?=
 =?utf-8?B?dkt5NTBzU2VrVTVZdldPQzFaK3EyaVJJNnJoYzY1Zld1dmdIeDV2a2pGVkhZ?=
 =?utf-8?B?OTVZd2wvNW1TYWF5dGR6MDBTeDUzQUVaNGFnNzZLNEd4Z3ZyK29FM0ZweEhI?=
 =?utf-8?B?SG40aUpZYXRJeVNmcjZzTnFLc2ZUMk9hRFJXYVV2Q3Q4MktwZERJZy92dFhw?=
 =?utf-8?B?TmRBYVcydWlTU0ZSeWVjUnNBSVNzQ08xU3VyVUtSSDZBemVkK2FTRWdQSzNp?=
 =?utf-8?B?ajcyRGMzSjVQdGNrc0EyQ21KRTA2OU5SZFA3NHFlcmJnU0VmOGpvVHdOeTRD?=
 =?utf-8?B?cExNZjR6d2IvaW5QYXpUWVRLQUVSL2dQWjBDK1lxWlBCSk5YSEI3SnBjWnZu?=
 =?utf-8?B?aVlYaTRkY0I1TjVlQzJMNWhWQmVIcm1NbzhRWWk5QlVvNEgyZWgvSldqWkFK?=
 =?utf-8?B?d0hZa1lSbzVMVGlCb2RwRmtQTXlqWjZhYVF2ellYQXhWRmdRMEJnMjBlMGZ2?=
 =?utf-8?B?UU92bjZLZ0lURm1kMUx6ZnhwMFZITSt5N3V6RDBpdUhrS1BYQjgyWi95YnJD?=
 =?utf-8?B?ckRxVDVMdTU2bVIvVnV1cFlLQVFmU1FwZ0tVbW9HUW9jTXo1eHF2VlNuQzdl?=
 =?utf-8?B?bzltaUhhemJvZjJwMUFWb3NtUllQZms0eEozNDBxTnp0VGZqbDUxZ2xOd2Jj?=
 =?utf-8?B?NFNuMldNcjZrSTM0SzY5L083RkE4NmluTVk3eUZYR1hOcEJqVnNHNWJKNnBQ?=
 =?utf-8?B?RWdvazBEbXFhR3VzMUNmR1lUWDdPTnpldmRZWWJTRk1EaTJXTUw2K3pRWmRM?=
 =?utf-8?B?MER3b21mWTJYT0wrZEs4amRoaGRYeFllZXVDdDRzaFVDK1VFbUhKNXhJN1J5?=
 =?utf-8?B?UVp0a1JFZmlZUVdyN0VUWkg2MnRuaE5OcmY1VXYxUDVJSk1hRGRPTUwxNmU5?=
 =?utf-8?B?azhKMWN1bE83WXgwWmZsbWJ6S2s4N0JraXRiUVNRMWNjYmNJWnRDaTdNTVZP?=
 =?utf-8?B?SVc1Tm1nZmFYWllVL3NqWW0xVFo2cjlha3BpaFdvZ2VjSzY5LzN3WFJNYmt3?=
 =?utf-8?B?LzVsQ0NxNWh1NWd1blJxbndZMm14TG40eFNNcGRnMjFpWEZzY2xUTVg5OHdC?=
 =?utf-8?Q?jFOgDGjwuYMfwfiSZ5C43U4/j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a62d1c-a62f-4e52-dc4b-08ddc97fa4d2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 00:27:03.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWAF5U0Jc5hNECOMY57yEmyNA5XLaToc29JAA3W4XVlOvw59lSjL+zy/ycJHaYHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336

Hi Reinette,

On 7/22/2025 6:28 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/22/25 11:15 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 7/17/25 22:53, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>>> When the "mbm_event" counter assignment mode is enabled, a hardware counter
>>>> must be assigned to read the event.
>>>>
>>>> Report 'Unassigned' in case the user attempts to read the event without
>>>> assigning a hardware counter.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>
>>>
>>>
>>>> ---
>>>>   Documentation/filesystems/resctrl.rst | 8 ++++++++
>>>>   fs/resctrl/ctrlmondata.c              | 6 ++++++
>>>>   2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>>>> index 446736dbd97f..4f5eb5bbd4b5 100644
>>>> --- a/Documentation/filesystems/resctrl.rst
>>>> +++ b/Documentation/filesystems/resctrl.rst
>>>> @@ -434,6 +434,14 @@ When monitoring is enabled all MON groups will also contain:
>>>>   	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>>>   	where "YY" is the node number.
>>>>   
>>>> +	The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
>>>> +	counters and allows users to assign counters to mon_hw_id, event pairs
>>>> +	enabling bandwidth monitoring for as long as the counter remains assigned.
>>>> +	The hardware will continue tracking the assigned counter until the user
>>>> +	manually unassigns it, ensuring that event data is not reset during this
>>>> +	period. An MBM event returns 'Unassigned' when the event does not have
>>>> +	a hardware counter assigned.
>>>
>>> Most of this duplicates the "mbm_event" description added in patch #10. It should just
>>> be sufficient to mention that this applies to "mbm_event" counter assignment mode
>>> and then user can look up the main description in the doc.
>>>
>>> The last sentence is related to this section and need an update to reflect behavior
>>> when a CTRL_MON event is read and it or some of the MON groups do not have
>>> counters assigned. The paragraph that precedes this does describe how the sum
>>> works so this can tie into that.
>>
>> Just added following text.
>>
>> When the 'mbm_event' counter assignment mode is enabled, reading
> 
> Not sure how this will turn out ... if I understand correctly it follows a
> paragraph that already starts with "The "mbm_event" counter assignment mode offers ..."
> so there seems to be some redundancy.

There is no redundant text now. . Users can look up about "mbm_event" 
from "mbm_assign_mode". Here is the complete diff.

diff --git a/Documentation/filesystems/resctrl.rst 
b/Documentation/filesystems/resctrl.rst
index 446736dbd97f..01c33f62ce74 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -434,6 +434,12 @@ When monitoring is enabled all MON groups will also 
contain:
         for the L3 cache they occupy). These are named "mon_sub_L3_YY"
         where "YY" is the node number.

+       When the 'mbm_event' counter assignment mode is enabled, reading
+       an MBM event of a MON group returns 'Unassigned' if no hardware
+       counter is assigned to it. For CTRL_MON groups, 'Unassigned' is
+       returned if none of the events in the CTRL_MON group or its
+       associated MON groups have assigned counters.
+
  "mon_hw_id":
         Available only with debug option. The identifier used by hardware
         for the monitor group. On x86 this is the RMID.



>> an MBM event returns 'Unassigned' if no hardware counter is assigned
> 
> How about "reading an MBM event" -> "reading an MBM of a MON group" to
> distinguish it from the text about CTRL_MON group that follows it?
> 
>> to it. For CTRL_MON groups, 'Unassigned' is returned if none of the
>> events in the CTRL_MON group or its associated MON groups have assigned
>> counters.
>>
> 
> Reinette
> 


