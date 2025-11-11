Return-Path: <linux-kernel+bounces-896292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DCC500B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E77364E4FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA872F260C;
	Tue, 11 Nov 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U77nFJV4"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62B2F290A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903276; cv=fail; b=abffr9vHasDP3+xmlOqo5ryiv4R9flEFpzn+f/tRlLjMYmje1yPjqHD2lN0K92WX/Qk4raH5g+IEJQDOhXAtTa2caX3p7K+Pdlr+Z0//qx2+1HH9oA+NFFKncVg+cUiEY7XqT1SVWOo0BQXgWhSIZffmZW1TO7zk3HkgpJ1DU0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903276; c=relaxed/simple;
	bh=NzR8dBlOX22c8fv8EFryNlN+2M8H9m37n9XHJBF22Zc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sW2rEIOdXaLvlhEHq6HbvZsCEuLYIEzxva+JDIQZqdahGRlQM+DSIUAmosjqU9uwTOM+rc3lR2D4xE5OD9PFccSv/hbC7MfHXzC/nd1d3hrNdOXT4FeikrQI5cc2xv/UtIKu3pk/ETljUw0KBArWBunbyWBtMr6r/XjjY8v/2+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U77nFJV4; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWYrhh8EDpkgEnGPTEIy2cbwCzCnFKHfoVKb9HLamn//gCuv90tLy5Kd/hSZsYeFpuNrYmrOu2UtwrYGubSVSSIeAJ6z6sDmhqX9Yrpz/UL3nlbcYwK1NzXslRO0iTNneSAeYTmw2aYlvDCaWH/vSCONKUyBGt/5Vy8K0MvsmVlfyK6Zs7b3zK3fgu1D18VHNYVyQ2sgYyBiXVaBIo4nh41clfY6cHQvHjkgkL0+j6je7Xa1qZoULxzvIx/U46h0OlqxyPdTsgc/W1ttM3ZICfE3SAcQIHAhHSZu9PqlwxU7JVdvm7mw02eXUXc5tA7MDSC8/0lrGKk7hZfW0Hq7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aNbFAAZoiA5YYsFbrRxdV9F+JHncwjYUVoqeiQo6Ds=;
 b=aA4L2Bzdvkc7ieeoDwFwCYLdA784d1s+zKcaiQ3i3JIDIGgBFJjW0tgH/FSHT9YNBb9E3qvJHiZMbvPSHFl1mPCRhT1FDi4W8vWag8lg8h3lFASrTP9pR1qS/xgj++f6wuXxCDgh/yP/leHh2NOZTrZY+HPFi+m8OQ3QnBBvbrgmc6p1Z58W5Go83DAT+8gGHQZcOw6oCLW8oYBCd0uJgFAtzZXmWP3wWZjN2Os1a0dgTPHQiYufKjDZunnTe8pxidjzeqGabNiEXhSbOueDPPcpUOkva+VgVzWEQC7vH+JgRr5CKZv5OqJnsAmmxexCGJzIdV7Wsij/KWzuIS2KVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aNbFAAZoiA5YYsFbrRxdV9F+JHncwjYUVoqeiQo6Ds=;
 b=U77nFJV4SBp5iLNqXykBl0F74mW6seWCdy5VX9Fi6SMn58c1nfM47/pR0us+HYm/9XwR5W4TZ683A/uLHtdAkeJFjdxnxUDN+wagNT5P+L9N7XBSyR8sjuPbl0ue056/h9XgLdKqieyDgC4mQfFnqdxQOWwIQcjtVqMnL251Zjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA1PR12MB6603.namprd12.prod.outlook.com
 (2603:10b6:208:3a1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 23:21:10 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 23:21:10 +0000
Message-ID: <7e117908-41ae-4f42-8863-1361101c33ab@amd.com>
Date: Tue, 11 Nov 2025 17:21:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/resctrl: Add io_alloc_min_cbm_all interface for
 CBM reset
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "babu.moger@amd.com" <babu.moger@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fa2c3cbc-2af6-4d98-bd70-8ab49cb0d83e@amd.com>
 <4whfbgq336xfuov4i4nwwrn35ywwlwizuvpdlstmdqzkhvwrq6@eits26xbwyz6>
 <bcc8e6d2-8e91-4e91-9dab-f1c00f99c408@amd.com>
 <knqdzael7yihvznsdzijztawviex2n3i5pqbzslmk3rolnacrh@h3cwjthvyeuz>
 <SJ1PR11MB6083F15A9FCB09AEC3A46827FCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <937022c8-82cb-4f4c-a2a3-ceaf99580cc6@intel.com>
 <SJ1PR11MB60833A27A1B8057CDDFB1B2BFCCFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <w6thhucyyfnveawixyub2yugsb3s2goiocqtene7s56csrgtfz@x4zll7p6tyla>
 <7e264e18-23f4-4566-86f2-f0600a243227@amd.com>
 <589d5db4-68f8-4aee-9d6e-dee5b8754564@amd.com>
 <kszvsxhiz7gxmiklsiiybh3hiykvtishw22fkgg6gxlabulzv5@x4dtfw24uz2f>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <kszvsxhiz7gxmiklsiiybh3hiykvtishw22fkgg6gxlabulzv5@x4dtfw24uz2f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:806:121::21) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 689cbc54-06a3-4c89-5708-08de2178ff7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXJtRDZsY3NubnRiMXg0QTBoMVJxb29YNWE3R3RlbjVzSnBtaGlvam10TFhX?=
 =?utf-8?B?dTROV3U4eDZ4UjdzQmVSd3huN3FJbXRVRURTSnBUaFpQMWNJcXF3cGV5cDJr?=
 =?utf-8?B?cVVjM0h3MDkvenJNdFBXM3NWWHhYbWlZUWdoUXcvZTNSOXpYd2lJbGFJWE1j?=
 =?utf-8?B?SVBQNW9oUHdDazlFNlFyZGNDVXFiWk1FRW1MTndsR2VGZGVnWG9oaE9iMWJp?=
 =?utf-8?B?UGVMa3dIRGtWOG1VZVppZkJkQjdmSlZONGx0ZUQwbUFXTm1ScHIzdUR1bExZ?=
 =?utf-8?B?OUpldUVtTUhCNERTdzZUZ0N3SWVFMlZTYWdJMXNXTWg2ZTlhejBTOWlwOGJ5?=
 =?utf-8?B?VHlYN2JxajlNK1FWRGZsR3hoOEhvb21ZSnB1RWpjZS90WUJCZEFYVEk3NmFQ?=
 =?utf-8?B?Y2ZoNkJUdHB1YVlXVkN0aFpxdS9HenJ5TjUzWkZYd2lwTE9XTUtWNFMvQWlX?=
 =?utf-8?B?S1BLL1kyMFplY0RmZndyQmVWdzhEd2tMSEJEczliY1VvN2JZdFpoZ3pVVGVj?=
 =?utf-8?B?dWw4VEdQWGpodmVKa3lZR0lSYnRiYVFKTW9VOWlCNlZ3d2NqbkpjVm13YnN4?=
 =?utf-8?B?SlNNaHdFS1lWcnhxcVdhL2x1R3JSVXZ4WmluVXdMVjh2enprNHFPM1hWOVZr?=
 =?utf-8?B?VWQ4VmNid1doT1ZZTW9TMTJlTzlLUldxanJ3ZFl1N25HemdrSThONWs5Kyt2?=
 =?utf-8?B?Z3NMU09kTVRxWkZ3UTlnb3BhM1k1bHI4alEwZzJXc3YwSG04TEorUEcrdVZV?=
 =?utf-8?B?RlliNU1QNzhqRHBYMFlrYXRiOTg0R0I4ZER3NCtTUm1mUVo1U2hHZTdXNDN4?=
 =?utf-8?B?VThwSEJOcTBBMDlKRlpkT05XZ2pnanlEYkZFckZXZXpDNE5nenVIZ0Q5OTRD?=
 =?utf-8?B?ZE9Va3Q2NDlxYmxwV3RDZlloMzJxS3lMT1R2Q21yMXcvejk2bEZDQTVLRUNS?=
 =?utf-8?B?NklzbEZ1b1k1cUVoMWUrb2RrdkdRbVRIUy82blpja08veFBLUkk2Mm5zSXNL?=
 =?utf-8?B?NmhDbFhZZnZBeHRDWktIc3QrUWh6NWorRnAwUnBMUmlYWVdwTHlFUHFsNGR3?=
 =?utf-8?B?bEx1N2pLbnhtV3VxNnMraUM3UVdoWjczYS9wRmFBMGJQc1c2T3VWNkFqb2h0?=
 =?utf-8?B?UEZPNmxkTG5hTWx3KzNQNG8vdStrMzFsVmg3c3lSMHRQNlMzbHR0VWFWMGRz?=
 =?utf-8?B?Rzk3TW1pTFVnSDFIVU9LU1gxVWxPdjZPd0ROYnBmSzQrVERTSkU5UCtKdE5S?=
 =?utf-8?B?UlRsU0k0SjJRR24rU0N2Y0V3TDRXb09xNnFzL3B1Kzlrc0xlRWZyZUo1NnZM?=
 =?utf-8?B?OGlVZWplRFpMdjdHMFk4WUk3dEJHMUlwd3pJWFozaGFjcElEWlp2bkhGdUhH?=
 =?utf-8?B?U2FOd0RUSlpjTktURjZ0L0pvSlhYOG80dTAyRGRISmNXRkVOcDgwdWlINUU4?=
 =?utf-8?B?VXBQZWpVUVhzYS9NU2s3bHN3TERFL2Y4cWdsaWxKdG1jOFkwdktuR3huYkls?=
 =?utf-8?B?d3VwODZLR2xLOTRoRDhvZHFMblNXVk1JTk9TbmgrUDBrWVprQ0xqMG1veWww?=
 =?utf-8?B?cVNkWHdUa1FsUy9sdVhJUHY5RDZnN1FNYmxzK2ZFYzJCOEpCL3I1VXdTR2hn?=
 =?utf-8?B?d3hTNHdFN2lEcktSZm1STitOeHA5eGNjV211NDkvQVV0eVJkRXpIZkxHK2l6?=
 =?utf-8?B?NkdjOWpqcXpia0RnV3VyNm5vdkdWbXpESlNlanEvayt0dWIzN2c0dGl1Wmd6?=
 =?utf-8?B?Y09ZcXpMbmliZmxFUFVJemoyKy9PS2hNYUNLdnlITGNkMjN5QVY4akk5RmEy?=
 =?utf-8?B?b2N2WmJhd0I5SEo2dTdoeEE3U1JzaG5GLy80dHlSSmUvSWpXdlEvcmhiZjcy?=
 =?utf-8?B?MjQxMlJxUVBobktpdjF3YTlsK2N2enExRlFGbTZzRWRMTytTNzJ2RDVGaU1C?=
 =?utf-8?B?RENFWjVxTy83OUM5SVplYUJYaG5UcG52QWQwV2J0RUlNeFZia2xmK3FEd2RV?=
 =?utf-8?B?RmVHNjZkSVp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0kzQ1E4TDZEQ2lhYTlEWExTamJDZXFGYmdBU0p3Q2I1YXhsdEo3a3AzK2Ev?=
 =?utf-8?B?ZW1xVld0dTBLKzlzc1B6bXFHNWZKaVNnNFNZOUVvUFlCYzR1TG9JK25ENE5i?=
 =?utf-8?B?QXp2RlZML3FaY0kwOSsxMXlLeEVTU1h6WjFtaVhsRVhNODQ1VGtQMTh5MEhI?=
 =?utf-8?B?VVlucktXbnZITGxNMDJaN1FJWFdGUjhSVldDWXNaSWJ2dVhFWVNtRXl0dGQ0?=
 =?utf-8?B?c0ZXVjBNWFJoakhqb21wazNJY0p6ZDdUa3l2TG84S0pxTEgxUWNHQk9pQUd2?=
 =?utf-8?B?WkRzOE1CWC8wQmllUUVPNmlUV2lQVW5ENWVOdkdtTkF5aHV6bFU1eGVGUzFy?=
 =?utf-8?B?L0kwZ0NLazlSVlIrZ0F4Sk9BZTE4S1R4U1pCbVVvTHlUNEtmdEJaaU1xMVkr?=
 =?utf-8?B?VS9pQU9MWCt5ZVRZNzRGVmRVcFRhUktrRExsbWZkanppQUl6dENqL0ZQUXNE?=
 =?utf-8?B?UllwWnBtQ1JWSjdYQWtWdVN4S1FycUxCTXBKYUZTRkl0a2ZoZUYrbm9OMXVW?=
 =?utf-8?B?RU9pRnV2ZW9CaENsSTJoZ1JDSmJaazVVcXRPMzNkWkE1bnNjTTdRR2lZR2Qv?=
 =?utf-8?B?Wk12MmxBNFh4UjhCb3l1RjBtdVhYM2ZOR2Q3TmV4QlhwYStCbEZ4K0QzRTY1?=
 =?utf-8?B?R0tnREJhNU42a1o3cE1tUGgwSTBrZzhBTWQreW1hY2hiUDFUdWVwYmM5ZWly?=
 =?utf-8?B?T3YxdmNkZHRCczZTejMyZGN1MlkxdEY1OVpnYk5vSkZIWWM1WU1rYnJyUmNr?=
 =?utf-8?B?Q0NRUStzc0hhaE1uSWFLTUhuVUdUa2NUcDRna29JSTUwaE14VFAzNER1QktH?=
 =?utf-8?B?cHd2ajFFT2hMdHhuQlN4QzBrb2NhSnRseTRpN0czYjByWktwcStJaVdPRUQr?=
 =?utf-8?B?eUhnUjJCWS85eWdLRGY1T0lZMkFTTFJMc3c1WHhwZ1kvTE43Q01FckEvemlF?=
 =?utf-8?B?KzVBRVE4VWthWTQxTk1XNEdkYi9keWJMYS8wTXFzLy9saWNJRG5ITGpzSkoy?=
 =?utf-8?B?azJrT0VyT21hNUFaNjhicHRFaGpLRm9VdHdPVHhJTzNyQnhkTWtIZFJiYWtp?=
 =?utf-8?B?WkVnM0kxZFpaNWpQc2lNZnJMK2hETzNMbGlJb2Zkb0JXWU9pWFFBOWRnTWJo?=
 =?utf-8?B?K0duZkU2OWxITmhzWWo5UjZMdDJSczZRSWdkL08vaWJmRmRxaHhsOURvVm9S?=
 =?utf-8?B?ZUNOOU04WEcwUHlEQnROcnJEcG5Lc0wvTDRsWlNHRE1UM21USjFIQVVIYU03?=
 =?utf-8?B?Y3Q5TjFraGhpQy9sak9mS254bFRoYjU1MVBZd3R1VG5ZM05JSjF4d3ZDRkNT?=
 =?utf-8?B?UHRlYlY5ejRMMDRQczVMOFNzSUsvUjV5dVRFZ200SVh4YzZaK2habGdKRkxQ?=
 =?utf-8?B?ZDZ2V21TZUswVnlrNmltZzUwaTJKOXhranFhTnliWGc2NTQ4aWdwMlk3SjFj?=
 =?utf-8?B?cGdIaHZpZlZxV0U2ckphSzg5TVhFNncwa3A3L0VDWTlmd3Y5emkzZ1lJWVZS?=
 =?utf-8?B?UjhXQ2o2a213WmRSQVo1SzNRSDJHT0VQOHlhMFN4VEN6M2JkUjRMZVU3bTcr?=
 =?utf-8?B?VUFRR0Z1aHU2ZGVRV3lnSTRFblAzMlR3Y3M5R1R2ODJEYWtya25tN2dReSsx?=
 =?utf-8?B?MkNzRyttczBOak9VSTFRaTR1OStRMEorVUYweGIyUjFIdTRZSjA2b0MrSGpq?=
 =?utf-8?B?WDc4NDkzTC9lWFI3eFZsT3RESGFGdmF3SG5CWHpONjE4cEs1RDc1QzQrZlcr?=
 =?utf-8?B?dGplaHRIL0tBUUdmTERDTW5BcnZxdTlUTnM2dzhVbytnR0lyUTJDYkNvaE1U?=
 =?utf-8?B?a1pQT2NMQkVHOFJFMnRhZ3NnTjAvL1BFYzNBU2JhQ1FhM0RHKzNUdllPWFJ4?=
 =?utf-8?B?NjZFYlA5d3lLWnB6VnpxSXlFKzdNOWhmV0hXNjNqK0Q1Skg3NlljRjFNZmtT?=
 =?utf-8?B?UHNscXExQnVoWXZLelFQWk5YbElzTXJabVhzaHJmbFd2QmQwMktFd2JYSDc4?=
 =?utf-8?B?LzdBSVYrOFRHcFZYV3JraTk5eGVLczhFanZIT0dWemlIMzEwdFJhZGpWR05x?=
 =?utf-8?B?TFZQVEFZWFdzcWc0c0RWVmpKdDJoRlc4KzZkT0ZwN1doSGptTFBNS01IVXli?=
 =?utf-8?Q?1BUPoFmUw4LiSronN0hoUT85o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689cbc54-06a3-4c89-5708-08de2178ff7e
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 23:21:10.1503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfhykPGZWR/W9M6U/ZSYXM0qBY5rKEPc0UKsCHrk1wmkBQMhniMp1Uh/OCctbLKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

Hi Aaron,

On 11/11/2025 4:34 PM, Aaron Tomlin wrote:
> On Tue, Nov 11, 2025 at 03:04:55PM -0600, Babu Moger wrote:
>>> Here’s my understanding of the discussion from this thread:
>>>
>>>
>>> We plan to support the following operation:
>>>
>>>     #echo "*=value" > /sys/fs/resctrl/info/L3/io_alloc_cbm
>>>
>> Looks like we are going with the above approach where "*" represents all the
>> domain.
>>
>> Couple of things to consider.
>>
>> a. Send a separate patch to add this feature after [1] is merged.
>>
>> b. Add this change as part of [1] series in patch 9. The series is mostly
>> ready for merge. I can add the changes. Only concern is, it will might delay
>> the series merge little bit.  My expectation is to have this series ready
>> for next merge window.
>>
>> [1] https://lore.kernel.org/lkml/cover.1761844489.git.babu.moger@amd.com/
>>
>> Any thoughts?
>>
>> Thanks
>>
> 
> Hi Babu, Tony, Reinette,
> 
> I believe the most prudent course of action would be to hold off on this
> particular change until the main series has been merged.
> 
> As I was the one who specifically requested this supporting functionality,
> I would be happy to prepare and submit the follow-up patch for this detail
> myself.

Sounds good. I will go ahead with the current series. You can send the 
patch(s) after series is merged.

Thanks
Babu

