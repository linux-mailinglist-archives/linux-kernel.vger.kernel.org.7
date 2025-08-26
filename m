Return-Path: <linux-kernel+bounces-787346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3989B3750B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CA2A8338
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FD299AAC;
	Tue, 26 Aug 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2hBdVjgF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344530CDB4;
	Tue, 26 Aug 2025 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248692; cv=fail; b=B/VPT6BEpSQ4wpVpLsXmzcWtMAJVA7upObqy+YQ93lTQUnJRt/PCgBN1YwUvt4hcltked/ebLYOwn/WM593xCjy3hyD87emHOdEBDhH/Qj/VT+0Pe/wy8/hF1WCvVGB2caEdSlyBi4MY70AfNNV8nniFVZsSkLOIovje2OUGo/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248692; c=relaxed/simple;
	bh=0fT49ihmos785KdArov+KCKjrAKipbI2z00GKnM0lug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hV1O9Xh2uYAfMVruJqx6aR9uN1+bkY5OHY49OlU/FWEDjFREFrdYfgKXTb/cQs/3gyOUWVirGHnHPT6vFetVAiq3aaueIe+H1GCa1eknp2OVHl0ZCCkCH+Y3TND/prlHpQBJnUQO5+JGCgqpZOHyx2wvUksBABKlzAMcVlTQkCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2hBdVjgF; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZV1UUGZj+QtR1QeijUJqpfn8GOOJ3zksHLISiFWbMDbZ5VUIW3QVj7hsBt3aS6OM2oDrY4O4n9xpy4oQ8YTMzKi909EApbp+3A6YJGU5Jo9eFMrBjXIGhfFmADDhrn5Q9Kn/hAOK6cYU1gnY91JcvUKXk7vwNt0evegUBoca3nU/2QOodhd1cZ/rPN2vHBDLo7WWdV+IPAS94sHzPvCg10yZK4surRsTZQFi8rlaM0peyMnWQ3Z9lr43v4GSCngzD/pPlgcgGXay4pw/p9D0kX4NJFKC0+rKVhEL0JyF5ipVcCZTDSFoqSp4OpAZhW7FaPe7Y9wXuS5x/Wo7vX3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOdK3BGtCsBIUErD576kHf94P5PO9wMzhT44glUiVE4=;
 b=r1zgu6wHWL6iBWoR4G0Di/7iK/Gjbfomvm9rI/YZOPfUgf1k6d4+q0GXEUZQuuCsjUla6/E9SgWMPCKbT03v7+csMqjlIiQqQlshV7Gt4wBKJyuWSDPXmANRhO+WuXapZR/e4kNHtoMnjWyakAVHQMdAWk0y9HiYfrlTwbmxE4rJQYJ/pSTnZbCgqNJiMgrfG3NdlUvEgYpKZb9M8L0j5yf6fZrkgLxvXesraM6sToMDSQBxip96XCMvVpyIEYmWNW8N/3ZOSMRupbR9355/m4QeSclBznc0wMI6frxDiJE4ngzR+e679/ptT2GYZxmDVwHYE4SrHQ2+RKWn+MEY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOdK3BGtCsBIUErD576kHf94P5PO9wMzhT44glUiVE4=;
 b=2hBdVjgFOF3mZJSHj2pb1JXqYZjx+C244qbr8hw7AM+YWcUk2oIy6n4IlVy7C7oVqgNTgdiiOf9Z/n8DgS9dhI3EWiOwEjMDYXsTIkib72RI9r4fn8p+YHdHhvmym9nmFzt67x/7bdQb9kpDz0uguAdHBPmHhJ3fC53AyT86Bek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c) by BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 22:51:26 +0000
Received: from DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57]) by DS5PPFA3734E4BA.namprd12.prod.outlook.com
 ([fe80::1370:cd3b:4c30:5a57%7]) with mapi id 15.20.9031.023; Tue, 26 Aug 2025
 22:51:25 +0000
Message-ID: <4145a0fc-138a-4a96-879d-34b07fd169a9@amd.com>
Date: Tue, 26 Aug 2025 17:51:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
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
 <6d34357ee32bb519c607a0e2f0195194c1096d7c.1754436586.git.babu.moger@amd.com>
 <79e7f426-e592-436d-aaee-f448282c66a2@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <79e7f426-e592-436d-aaee-f448282c66a2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0019.namprd11.prod.outlook.com
 (2603:10b6:806:d3::24) To DS5PPFA3734E4BA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::65c)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPFA3734E4BA:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: d4eba10b-7b5d-48b1-d0eb-08dde4f31600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WElqMFlQdkM5T285SGRVakx0L0IrbGlRQnJsTndpOWw5WE85QTRqV1prc21m?=
 =?utf-8?B?RnNNM1ZpenBnY0R1OFpWY1R5OENDbmtjQmh0cCtVMmc1RUVmM2NIQlpaRkd3?=
 =?utf-8?B?eXluNVpNYlFEeGk1aFBTczRYSnlyOWsyK3dKTXFOVThCMHAwT0l0WFNhNW5C?=
 =?utf-8?B?ZEV0UlBMV0hPQmt0eFM5dkJuanM1M3FLRnc5cEFWa05mRmdZSllTaVdXK1RC?=
 =?utf-8?B?WVdzODRaYXFCdnBRcDBkSHg0ZzZlR2FFSkVUM0huTDYzNzcyTFFyU2wvL25k?=
 =?utf-8?B?VXVOTzhtYkI3cldPSzZ5SE9NZ0dsTEFXb2MyMTg4clduRmxDY2F6MUUySWYr?=
 =?utf-8?B?RFp5YnRiODBmRHRsM1ZRRUNFTko2dWYvbUhiYlV4ZmNRUG1YZGhuQWVQNDk4?=
 =?utf-8?B?QndMK1dwY29LU0RPZHk2SVRtejNwSHlGZFVOZjNvQWNqa1M1c2F2OE1FTk5t?=
 =?utf-8?B?MHUrSlNxVE5wSllBSERNSWUvKzBPUlluWTlwYkRpVHJxWGNOcVJMTE9QZEFT?=
 =?utf-8?B?d2RSSG82cWtXaE9QRktWdlQxNlZYK2tmdE9ESmtYTUQrbFowY3psK21mSnMy?=
 =?utf-8?B?aTE0ak9tNHNHNjZDM0pvN0tnNGtKajZzUjluYmJub1RNUnArVG0wSmJ2endN?=
 =?utf-8?B?cXk0WjlCTktpMmViQlpHZ2podkxCaDNyUytoT2xPVGdreFVsMzlIVk1rdDJw?=
 =?utf-8?B?aDd5SzVZcHBxQ2J1L1U4eVNCam93UjVFWnJNeU9lNkprK2tmTUVTV1RCMmxI?=
 =?utf-8?B?QmJYdkJsbERjSmJ0U3ZiMFZXMDBsYjZrREhoR0k0U1IrelB5NHdmM1JZN285?=
 =?utf-8?B?M3NEaEtBSTdsZjAvLzk3c2VPdzR2Tk9mUFVEVVRMVTdXZnJ3aWdvVmVpSWxa?=
 =?utf-8?B?dFpyRHZyQlNNNUVmdUw5SHcxbHUzL3dnVG1WMDNMS09WRXEwdXRLZkpOOGNh?=
 =?utf-8?B?cDJlMXUrRTZySWpaenlhajhJMHRmUyt4SnhNMWJrS0d5R1BqS0daa3RsMEU3?=
 =?utf-8?B?eTlGK3RFVnRZM1d3bHJReEEvK3lYSjJyc1ZLVVpuV2hNdENZMkJpSy9Ua2Qr?=
 =?utf-8?B?UmRCSyt3SUU5dS9EU3pIZ3gwMHZGK1NDM3BqdUdNeS9OOGJvOEZqNzRWMVQ2?=
 =?utf-8?B?SXljOHNEUlA0UmtwMmV4WkxJTXhlRWhRWmJMaE1KS29rSlhoTWV2dUN6cGhZ?=
 =?utf-8?B?aHhtY3V2UkoxcHZtTWNZbWxRbEdBdkZkVC9ZS20rb2tRMURIR1JpaGxEWC9M?=
 =?utf-8?B?bE9iWmhXd1h0UTY4Nkh6ZTJiS2ZURjB3WWhIanVzYXpUQ2NBRlVKNkRyb1Jv?=
 =?utf-8?B?Y0ZpWC9obnVrQzQ2S1p5VVZ4emxOb2cvRHJRNjI5MGhROTZOdlpLcVRlMzFl?=
 =?utf-8?B?a0c2VUJTdlBaajdHUHlpdUZRNncwbmZmYk40YUFEUGpaeEdlUS8zU2djaWJy?=
 =?utf-8?B?VXVCK0RWZHIwVS9qVmhja08yNmZXWUVTLzVqVnNwTHVQZzA5ZnBpSHlPVlNG?=
 =?utf-8?B?K0J3VkphMW5XTitEdHhKZGVKRlpya3d2dWxMdm5EOG1BT2M3ZitVaHdmZzYx?=
 =?utf-8?B?dHBmLzVoK3ZjdVBreUw2eERyOWg0S3oxNVNlSnhEVWdwemdPaUJlZWdzZ2R4?=
 =?utf-8?B?Rm9ueFdEVi9PQTZHMllJZXdTeGdweHhoZHEvUGl2eGJxVk9XY052ZDNhaEd5?=
 =?utf-8?B?MXdxWWx5WC91SGI5Rk85VDRzZnFPMGlFNmsrcWVrNHlCaWxUOGx5RGNUUmtM?=
 =?utf-8?B?eDBOeFdkWmxUakpwWWtrRlRvdE9BeUpmZnJ6TzZyNjdLWXJVWXh6VExHbWVI?=
 =?utf-8?B?bGxJcmIwU3R5OVFnbXVzdmZTdHg0c3FsRHBRUVk3QWFybkd1MnJVazJndDlK?=
 =?utf-8?B?NnhwZUlEYy80ZUZQL2lLNFNyTHNLYlhwMHlHaXdOTzBDUUxWeTRvMWc0bWlk?=
 =?utf-8?Q?eDkm+WLBDL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPFA3734E4BA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFc1azc5Y0tqRGRFWVd1WXVrKy9XVUErNkltQUtheWE3T2hET0JxbTJmZFJn?=
 =?utf-8?B?TGtLMnhXMXhhQmw2Y2VpZkpXcmFJRUI3cVBWV2ora2g5bE5pMzRPb2xyMzJi?=
 =?utf-8?B?S29YQmpwKy82aDdUcU5LVDBvK0U0N3Y3Skg2cTRNOHkram9kdjFyTC8wYmhX?=
 =?utf-8?B?bmFDZEV2SFdhcjd1RDVVbnBQZXBxOE5lUTJlR3duMjY1L1ZMdE5lbEV4Mkdu?=
 =?utf-8?B?NEoycXNQbXVxQVBIRWxQVUNaNmtueC9pc1ZSaEcyOGNCemY2d3grei9xRExU?=
 =?utf-8?B?MVczZDhQWjBOOExNdVc4TGdDalI0N0dTd2hWdkhpaTNsdkN3b0dMOFVCTHpH?=
 =?utf-8?B?eXY5YXNwTCtkWFE2QTMrME92akIvQi9BTVpHYUx3cnpqMHROTVQ0b0ZyQmMz?=
 =?utf-8?B?YzMvWmYzaHVwbkw5cFFLOUdqbkNSRHdoYk55MS9Sejc0c2NldjdtMndsczlX?=
 =?utf-8?B?Q0NrL0c2d2pKSW5sVWN5NWhTUURxTGhCRUp0Vy8wMm90QTlWR2Z6MHVLbUx4?=
 =?utf-8?B?WVRtOVd1aWYrM0pjbjJYdU9XT3BWbTVxbVBFTE5CeVRGTGoreHM3c0FwQzdL?=
 =?utf-8?B?RmdOL3JLZDUyQlJFMG5tczFOWWxyNG9nM3ZsT0dHdTNDU1B3UU44bEg5ZHlM?=
 =?utf-8?B?Z3gwWFVSdnVFZFVpemdBalhSN3dpdVB4WXgyTjRoV1h1VFpCNmp4UFp5Zk9j?=
 =?utf-8?B?Vkh4VXMwRHFwZDNpVjY3Vzd3MlVKYkJKRWI4N0RkWUVRdTBXQUxwVTlJeDJT?=
 =?utf-8?B?bmFHYm5MeERZeDFFWlNPeGZPWGJ3YTB0THNhYWk5YTcxSUg3WDRCcFh3VnFR?=
 =?utf-8?B?c3JzVThMWkk1V3ltVTl5czFGb01lalZuZ2JjbG94SXk2RncrTThFOWlPd0d2?=
 =?utf-8?B?QlJOMDQ0TGpZME90bVhSdURjcmNmNGdzU3BEMlFGRk9OTTM1ZTdKQng5RGw1?=
 =?utf-8?B?MDJTUVBqM3BnT3VsM0FZWmZIenBZNUExNVhaTXJsSkUrc2p2c1p6b1pLZlJL?=
 =?utf-8?B?MGEyaThvT0Y1cVFHd1o4WnpuckRwTUpSWFE0S2VhWkNPbHI3QkFjdWtPTGZt?=
 =?utf-8?B?anZodHBkVjI3cTRIUG42OXVHS0RaRXJDNTZ0MXptdGliVWZVTFdRSkNDOXls?=
 =?utf-8?B?MFRuSllsNHRrbitFM21CV0RHZ1BYb2tYVVp0VW4wSmpSZHlPKzVmazdKT3N0?=
 =?utf-8?B?RnBsR0MyUHM5WnFRQ2pzOUN6MFVHcWRzNllqNWNzK3NVeXFNbWFHMy91WG1m?=
 =?utf-8?B?UmhYMUZqelllUmJLWFlGbnVDWWZRZmQ4RmdJZVhSdzhBcW1hNGlpWEdRL05S?=
 =?utf-8?B?VFN6L3JQYnljOHUyZEZLMnV5VjJlWU1UOHlsSjAzL01OaExtQWZtV2J0SEoy?=
 =?utf-8?B?MXl1eU1QWTRIbWU2aFFKdCthcUE3eHduZzAzd1lYSG1xS0x2ZFB4MUtRMXlY?=
 =?utf-8?B?dVVrNFBNZ2NKaWhKbitpZzVmUXBIQXIrb1RSV1EwZXdPMk9iM3VqRUtyMUla?=
 =?utf-8?B?cVpQQjVFWGdwNkRGMC9aZk1LUU9taitjVFJ3ai9BRVlQYnZSRE1DTHlxdVZU?=
 =?utf-8?B?Y2NJWWtIRmNSRE5HZUg1UTE5cFd5Tnk5STBQaGw5RWhMblVxOE95WTB5a3lz?=
 =?utf-8?B?RU9HcGxYWTlGZGJmYVA0TC9EbnV2R1J1UXlxQ0VNS25tRjFjdHhqMldKVnYy?=
 =?utf-8?B?RVBtUk93RlJrT3RzRUVaNFB0ZnZFcXdqSEZVK1g2TVo5NWtnWm1ZSHZVTm9v?=
 =?utf-8?B?RlBHcS92ZFo0K1dFbkt6Rk53dzBENUpEdzR6MENzbVkxajgvaFAvUjVaSk1z?=
 =?utf-8?B?MzRMSTZVRjA2YUZRazU2Q3hrU25iQ1dSWVZWZzhwcmQ5elpqOWEzNzErRGFm?=
 =?utf-8?B?dUdOMDVqQWk4OUhkSXlDQ3NYR2VKNHg3ditSVk1ka3hJSythbGxwdnFQL0xa?=
 =?utf-8?B?VHpsNkpHZ2JnTzNJOStaSmNlVHdVQVY4QUx0YnkrQTJ1bVc0Q3BRTElQaUZv?=
 =?utf-8?B?M1o1NGc4b2pIbWpSVXdaVDJCbXRmb01YZGFlbjlzeC9WdnU2aHlYVDlXajV6?=
 =?utf-8?B?c3REQVMvMXpYSTQvZkVDRndhSzk3NW5RNUVOODdaZVFJL3VaREN4TDIxdTgy?=
 =?utf-8?Q?p7Xg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eba10b-7b5d-48b1-d0eb-08dde4f31600
X-MS-Exchange-CrossTenant-AuthSource: DS5PPFA3734E4BA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 22:51:25.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1xxZmic56LX4aInKhbdyWOelF+r9bmZWl4jtIK9LFW9OsyP3qgqI/zpHIKk99Ya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

Hi Reinette,

On 8/7/2025 8:54 PM, Reinette Chatre wrote:
> Hi Babu
>
> On 8/5/25 4:30 PM, Babu Moger wrote:
>> When the io_alloc feature is enabled, a portion of the cache can be
>> configured for shared use between hardware and software.
>>
>> Update the bit_usage representation to reflect the io_alloc configuration.
> ... but no update to the bit_usage docs :(


Yes. Missed that.  Will update the text.


>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ..
>
>> ---
>>   Documentation/filesystems/resctrl.rst | 19 +++++++++++++------
>>   fs/resctrl/ctrlmondata.c              |  2 +-
>>   fs/resctrl/internal.h                 |  2 ++
>>   fs/resctrl/rdtgroup.c                 | 18 ++++++++++++++++--
>>   4 files changed, 32 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index d955e8525af0..1e46231b929c 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -90,12 +90,19 @@ related to allocation:
>>   		must be set when writing a mask.
>>   
>>   "shareable_bits":
>> -		Bitmask of shareable resource with other executing
>> -		entities (e.g. I/O). User can use this when
>> -		setting up exclusive cache partitions. Note that
>> -		some platforms support devices that have their
>> -		own settings for cache use which can over-ride
>> -		these bits.
>> +		Bitmask of shareable resource with other executing entities
>> +		(e.g. I/O). Applies to all instances of this resource. User
>> +		can use this when setting up exclusive cache partitions.
>> +		Note that some platforms support devices that have their
>> +		own settings for cache use which can over-ride these bits.
>> +
>> +		When "io_alloc" is enabled, a portion of each cache instance can
>> +		be configured for shared use between hardware and software.
>> +		"bit_usage" should be used to see which portions of each cache
>> +		instance is configured for hardware use via "io_alloc" feature
>> +		because every cache instance can have its "io_alloc" bitmask
>> +		configured independently via io_alloc_cbm.
>> +
>>   "bit_usage":
> More ignored feedback. I was expecting changes to the "bit_usage" section.
> https://lore.kernel.org/lkml/94d075e0-6703-449f-9c0c-8e5973349dff@intel.com/

Yea.  Added following text now.


diff --git a/Documentation/filesystems/resctrl.rst 
b/Documentation/filesystems/resctrl.rst
index 273c9c9389a4..0a56829407c9 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -124,8 +124,11 @@ related to allocation:
                         "X":
                               Corresponding region is available for 
sharing and
                               used by hardware and software. These are the
-                             bits that appear in "shareable_bits" as
-                             well as a resource group's allocation.
+                             bits that appear in "shareable_bits" as 
well as a
+                             resource group's allocation. When io_alloc 
is enabled,
+                             the capacity bitmasks configured via 
io_alloc_cbm will
+                             also appear here, indicating the cache 
regions shared
+                             with I/O devices.
                         "S":
                               Corresponding region is used by software
                               and available for sharing.


>
>>   		Annotated capacity bitmasks showing how all
>>   		instances of the resource are used. The legend is:
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index 1f69117f96f8..cfa766319189 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -754,7 +754,7 @@ static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
>>    * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
>>    * of available CLOSIDs is reduced by half.
>>    */
>> -static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
>> +u32 resctrl_io_alloc_closid(struct rdt_resource *r)
>>   {
>>   	if (resctrl_arch_get_cdp_enabled(r->rid))
>>   		return resctrl_arch_get_num_closid(r) / 2  - 1;
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index 5467c3ad1b6d..98b87725508b 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -395,6 +395,8 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
>>   ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
>>   				   size_t nbytes, loff_t off);
>>   
>> +u32 resctrl_io_alloc_closid(struct rdt_resource *r);
>> +
>>   const char *rdtgroup_name_by_closid(int closid);
>>   
>>   #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index a3ab2851c6da..b85c2622c94b 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1068,15 +1068,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>>   
>>   	cpus_read_lock();
>>   	mutex_lock(&rdtgroup_mutex);
>> -	hw_shareable = r->cache.shareable_bits;
>>   	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>>   		if (sep)
>>   			seq_putc(seq, ';');
>> +		hw_shareable = r->cache.shareable_bits;
>>   		sw_shareable = 0;
>>   		exclusive = 0;
>>   		seq_printf(seq, "%d=", dom->hdr.id);
>>   		for (i = 0; i < closids_supported(); i++) {
>> -			if (!closid_allocated(i))
>> +			if (!closid_allocated(i) ||
>> +			    (resctrl_arch_get_io_alloc_enabled(r) &&
>> +			     i == resctrl_io_alloc_closid(r)))
>>   				continue;
>>   			ctrl_val = resctrl_arch_get_config(r, dom, i,
>>   							   s->conf_type);
>> @@ -1104,6 +1106,18 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>>   				break;
>>   			}
>>   		}
>> +
>> +		/*
>> +		 * When the "io_alloc" feature is enabled, a portion of the
>> +		 * cache is configured for shared use between hardware and software.
> Please add snippet to comment that highlights that CBM of CDP peers are kept in sync and the
> CBM used for I/O can thus be obtained from either.


Sure. Thanks

Babu


