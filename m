Return-Path: <linux-kernel+bounces-739859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39BB0CC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80704E7289
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4023D2A0;
	Mon, 21 Jul 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJHqTIV0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161323B600;
	Mon, 21 Jul 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131561; cv=fail; b=u+kqcwcXSufB7TFQ0jgEZ2d4S31r0am4Yt4bbRvPlkxb2XinzFuFif+Yow9jfQ7gUsFbaMxV3RbMABLtDV2Hav2y4oLS4rWihZKAvblJtgyN9tQfFL26LYmMenfuJVOVGw0hq0I4AGNV02EhNKtQNzq+wjqQoJZN3RileA+AaSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131561; c=relaxed/simple;
	bh=38iKiQyhTdtTYYAZ58WwAtcuFZPhG2ivqvBCY67znDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NET+kncBuj9terGgTAlbku1mCbjr4FARSS/E4gHChFInwX9N6pUcNd87ZgfIo88y0ZByyKTG5zhTBTQRzwVCVjGLIh3gKgXSdOPkVQjvAk1dtdGtJTlNkay16noY6GxhMmt/0iYUqrizE4E7Wm6nMADs4VeewNHcupOJym4ekBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJHqTIV0; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFT09nUWv6XgjVjPzynV5ifwD7kul9Ck4/n/GyB0O3jCdu1+hUmfquQAhy245k0YtmrfFoVYe2lYFaoCO82k3kfe35D1hkvZZwTeWx0rlACRm4IxI5JeqcKaRfI11p6j1TkuCUcGocTknwMUZGz4BIwv2xvZyeLcadqRKau+eQDzUikug82MugRi4RvZ+gXLyAPIvZooEwegx3p1GRhZ0hvqSwMjyYnhYFhBzzUyGViD/ZdUWjoBy4VMqTd8W8asHXsrS/yVvkWmn0UeWR7iltCAp5s/dpXbeOHOst7bcjSZNPqduLRK+iavhyeNwV7DVrwO2s8tVJ2nKl/7qYlBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX5ZtYPEIc7CclQrYMP6NcHVeqwUIGc9f0N99trWsGI=;
 b=AVFyXgsDJMAXyjbA+SSpYFRxbqTwzGxgF9lCHLe7w3L+RMiDZoKSYd9shMtiK6C9vHEkxfwHZhrgY2Z96ZE0fy3Xua8Hg+1ORAG10CPsrUPWZEEDm9IgiQJ9SQWgNMa72mCsSBE0rl55ybZIPLQb8dSsrsNekXbFzqgTyskf0qdalzPje627oJ+cBgCwajRmcJiAmx+YOBNBIbrPxPSDjXbPmlqSb3oCHnUB8fXpgge6P2HcYQsrm/vH3m7bQO1sYHa91R9b3Pkz2YpcjZ4XlboPutM2h2D1EE+uIBdQ09Um9bTI2tAqgFYYR4+Tzt55knX3huaSS9KgscAVP79rRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX5ZtYPEIc7CclQrYMP6NcHVeqwUIGc9f0N99trWsGI=;
 b=uJHqTIV0ZTcddhTtO2ilj31SL3e9D6obNattjWcPhSq9xsVjlEdHgnLgSEcqqwc7vxXWrvm5z2beHodaAWXIxwYeAkURAik/Q13C1cRzhrIz/z1uayzr6F9l32mdnqskl+C6H40OtqI9sHf6sAGj7jYu75JbfA94xq0NE9QNkAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ5PPFA5F0E981D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:59:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 20:59:15 +0000
Message-ID: <6e925211-a988-4317-9879-f0c47800f80f@amd.com>
Date: Mon, 21 Jul 2025 15:59:11 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 19/34] fs/resctrl: Pass struct rdtgroup instead of
 individual members
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
 <5b017f308d3bff1b746c8904d0dfde0c11706fc1.1752013061.git.babu.moger@amd.com>
 <c52cf3c7-6dea-45ce-8cb8-28ad230d54e5@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c52cf3c7-6dea-45ce-8cb8-28ad230d54e5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ5PPFA5F0E981D:EE_
X-MS-Office365-Filtering-Correlation-Id: b08f7d82-c2a4-4775-8655-08ddc89973c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlVQUHJKQjFwamtZaUc4bm1pM2F4ZWxQOGdNeUZNOXdCMjZUTHUvemRTZ1Qx?=
 =?utf-8?B?ZkdVblFBSy9ocS9hTktaTlZwNWhNUzc2TWlYK0QxaE9KQ2VFY0ErczVSRHhL?=
 =?utf-8?B?dTVRNTg0Q1ZWVWlVaFdGcGozVW9JVUMyUlhTSmJDSHQ1NGZCOGVQN3NxdWVI?=
 =?utf-8?B?Z25iOWJWUmF2M00rK1IwMDNsckwxME85RURLZzhJQ05CVkttWFRGNkJMbmZJ?=
 =?utf-8?B?ZFhaSUlvSStpVnArdUlGZTA0YVNUKys5Z1FQQWdvdC9BVllXMW1lWUtqKzEw?=
 =?utf-8?B?UU5RLzRQdmtVbzFMVTE2WXVpa3crT3k2M2RWL1REckNOaE90NUhCUzhTRGQ1?=
 =?utf-8?B?aGRmZ0JmVDViT3U5L1U0M0N1emQvOGowWlpkbHNLeVUvODUvUURPY2FEWklR?=
 =?utf-8?B?THRrcnYxRFl6V1NMSWtnSmFSZ1NudnZobStPckl1aTdkTXVLYy9NcVdvVk4w?=
 =?utf-8?B?ZkRWa1JUaUNremRPaEdwU1JtcnhKeGMyMkJwZGI3eGxpNE5mM3RqbmtvRmxw?=
 =?utf-8?B?UDYzYTJVcXJQYTB4UzFhUWx2RWR1Q3N4aVF5MVRJTlB2KytYVlhhNDRsY1di?=
 =?utf-8?B?eW9CRm5lNzRabmxWRUExWElReWpNL1Rqd1podjM3L0tRUmQ0dndMK3VnTDdV?=
 =?utf-8?B?emVMT3ErSW93Y0V1NmNMcXBiUm92UHNOS09tQ1o0dWFXc2dsMXAyaVgxbXVB?=
 =?utf-8?B?dnp6K1lkaUlWc2xOVUk1M2pCU1JoTGJ4U3ZZUUhNbkRBWHcrMkRSRVphSk9T?=
 =?utf-8?B?Z0VpUW5HbFk3djNWTXFoYWNVNS9EMXNpd25nQS9jWWszYTliTlFscVZkZGw4?=
 =?utf-8?B?SWJ6R2tvR1ZpVnN2VWUyR0dTMkJtRFV5cE1qVHA2R3JQVkVtTlFWNVlsbDd2?=
 =?utf-8?B?aUcrSnJWVW9SbUdSeGVWdXRJWVJYOHdhZXhiZUx0aVVad1dYczF2bXJlOCsr?=
 =?utf-8?B?bnJMM2E3K0cyYXRuaVdhYm1WcVllWndmZWptWDNVdGJCZ3FsNjl3M3UrMHNX?=
 =?utf-8?B?akpkNmFoWHJqZUhpL3l2YTBEc0d3b0dyNFZhNVV0eVMwTE03MUJJRDljZk5J?=
 =?utf-8?B?bzczU1RpQ3RJMHUxNkxIR041Zk5CVGdpS0YvQVdodFNTUGxHQTBkV0tNdTVo?=
 =?utf-8?B?N2ZST2JFWVJjUHBpZlYrd2QrTWVIem5EcC9zK2JQREtVcWdQNEk5QlB0VnE4?=
 =?utf-8?B?SVBmeG9UVERIRjZZQnJxNGJCN2diQllHTnNhM3dtRXlRUFJ3TnE5aDBIN0R4?=
 =?utf-8?B?Szg0YXVUWFBEM1h1L3VRTG9HVVZIdWZDV2xHOU1jTXVOTkVvNHVYVlpTbWxZ?=
 =?utf-8?B?ODQxbmlXcitGMkQ3UmoydU91WWswbUY1VFc3MUVpU2Q3THdQNkxHWDBKLzhW?=
 =?utf-8?B?cy9yMjRYbFRwU1h4djVpMDBQK3ArUWdiOXVKS09Jcy9ESVBncnhIMHB4Y2NT?=
 =?utf-8?B?NFUxNFBrdjQ3UjNUWlVuTS9xYkFaZHNGNTg2R1hRN2VLVmE5UHRoNHpwaGUy?=
 =?utf-8?B?VEo3Sk9zSUJMUUtDd1RKcHQ2MTUwNWMyR1JaWkU5VkRRMjdzaDZGWHBlTnZw?=
 =?utf-8?B?ci9tUGpNZDEyT0JtVmhLclZQVW90Z0xVdW5pUXJVRER5N05lVlNYanlrT253?=
 =?utf-8?B?Q00yTmJMdHZjclZ6N293UGVnbnVKRUNpVzlrelJWeGdBOURmZmtCd1FXdWly?=
 =?utf-8?B?ZElJUC9jRDI0eElOUm1DWFZ3bmJDd3Z3SlVseVlpY1hCT25QYS83SVBOQS96?=
 =?utf-8?B?Z2RIdjhZQ2kwWStLNm9kdFA1RWpKbWppYUU1RmpmRVhyaW5FOTlGZW1vOWw0?=
 =?utf-8?B?R0ZKcjh1QXBFQlR2bXRsS0J3WWpreHhXRXNqZG56MVVDazE2WGxHYUJZWXFF?=
 =?utf-8?B?T0lOdkUrMGpjU0VqRnRuOStTcFRwdFF5UFh2T2ZKRFk1NWNmL3J4Ykw5QUlt?=
 =?utf-8?Q?HMVqPQ66hy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFpFamVObjIxZ2NoVndWUXB2bnhqSXpRVnpiNGFqK1BSVmlRSlNVTmZIRlhp?=
 =?utf-8?B?TU9HRFRBaEgyRVF5czBYK2ZpSGdxOC9WMzBGZnUwSXVLeWpJRi9WeStjWGwx?=
 =?utf-8?B?WE1WS25tYUdkSFZnOUl1a1psWDIvNWJtOEFDcDRka1ExTFRFamxaZCtCaXpG?=
 =?utf-8?B?d1BGc04zeXZqcHM2KzJyVUJyanBuWDZoQ0NpTGFKNTY3ZER5MVk5dWNxY0VV?=
 =?utf-8?B?NGtLazZqanA4bGZIZEVwMWRCSXEwTjdpNkFhVUZtMWFOMVN1WWpFZS9LMERL?=
 =?utf-8?B?b2I5SGJFL3dtUHlPWlkvZkNMZXFlbU9icEFJSEg4VHpzdDNaa2tOb3EyVU9M?=
 =?utf-8?B?cGdkNnV1VVdweXNzRE1JTHMvaGpBOVRhejVGQVlkMmZaZEpWYm5GZm1rSW9Y?=
 =?utf-8?B?YXFISjJpaExKdkNFMlAybmNkRXQvSFQyS0tJY1U1dXovTnIzV3NxUU45Yys2?=
 =?utf-8?B?OXpJTGN1YURBeVVuMWt0Y1MzSk52TTRaNTJRcHErRFBXaWpVc3U5TDYxeW11?=
 =?utf-8?B?MDZsRlg0SHNxUVUxZ3FwTmVQUHN1M1RXdmxLemJ1clBSU3NFK2xHWHJXb2Ny?=
 =?utf-8?B?aTJpOXpzWk5aQjVjcGw3aktWY0laWXhlMHFrKzNYWFFNOUhmUUQ2S0I3RU1u?=
 =?utf-8?B?K3BOMFU5SXlaak1ZM2cvaXVqQW1xNEJ2aG9lQVUwSVduanl5YUtMVTBUVVZJ?=
 =?utf-8?B?N2Vpb3kwMFBYRENKbWg0QTlaR2FaTDFETkEwSTZud3F6SDFGc2lWSnkxR2oy?=
 =?utf-8?B?dFRCaGdCS3hoSzd1MllUWFV2bjF0RGN5djNldVVlQ2dNRGhoVy9XWXJ0Mjkv?=
 =?utf-8?B?YzZzSXRlckNUNzhHVElPRlZMdERVNGJNM1BzMHBXQWM3NUJxZk1MTlRCU2dp?=
 =?utf-8?B?MzJmRlFieWhqWVNtQys1MDhudWxNNm1lL0FvSlF4Z2lpSHJjOXo5SVJSSVhF?=
 =?utf-8?B?SWJPMEVqMVNKSVRDYU9SUnJvdUoyaUxWQk1HemVBTkdQYXZWakhaZmtiMi9K?=
 =?utf-8?B?UTkzWExQVWF3ejI5RnBxbEg5UGZKbjdGdHo1MjNnSi9YczdxaFMwY0kzYUJk?=
 =?utf-8?B?cjE4SDFQUkp2MkIvSU56eW5pS09hSDQ5bmhRTlN0ZXNFLys1TmRPODdrblY5?=
 =?utf-8?B?ZCs5WHNUSG5pUUhpdTh5ZExFT1RXSHg5ZDBLU1dnaEFEVjRWQmhQODdjSjNH?=
 =?utf-8?B?eDllUkgwcktUR0pTN1BYSE95TEplR3VXb2tSc0VncTVFajMrek5VSzVkUVdM?=
 =?utf-8?B?RlA1V3EwRXlVaXNtKy92UHNzMkVId0E2MFJoeFluZ0haMytVWmszRk15cTBp?=
 =?utf-8?B?Yy92NVQvaEJJcUJ1UHRNNE0rR3piZC9rcXVBaDMvbXZYVkphNHRkVTZST1ZQ?=
 =?utf-8?B?bytyZXp1Q056SDNVbUdYeXpqV3lueDJLWGNjY1MySFdEOVYzVFlyMXlnR2U2?=
 =?utf-8?B?YXBkVWxsTG54WllnblVYbG0yWWV5RDZDQi9SMzROaEVBbUxXUkI1eWgwQTVo?=
 =?utf-8?B?TVB3S1pyd2lqaFVWOXphbkFJeThjSWhIOXlIS0UxYnp6NmlwNFBUVzBQVWVj?=
 =?utf-8?B?ZlZHaGc1aDIxVFFBdDFLbWl5MkZVT0VMS1l6VURaYzA0b2ExS3d1dkNqZTln?=
 =?utf-8?B?TGdidXpkRlZXcWt4dTRCWWdlNDNERmo5Ryt5bnlVdllwY29UV3VTbi80R3lV?=
 =?utf-8?B?VUYwRm5iVEtINzNXTjVSR3o0UWtOZkZpVCtLa3ZjZDdwbEtSNDZXbWdJcmZE?=
 =?utf-8?B?L3d1WWVMbGNPY0pYRjhmSUQza043R1JCMXdEb2ViMXkzYVVlVEJta1U2dHhP?=
 =?utf-8?B?ZDF0cWlJRGZSMnFrVDV4ZHNNdlJNRmx0cjh3V1p1aDRSeC81UEYwQjdkMlBH?=
 =?utf-8?B?Y28rQmp6VldZU3JEUm55NWcxc29XdWl0bTArcmNlZVVjMHlqckc3YWsyVGpI?=
 =?utf-8?B?bVp5RXRvZXZRRGxNeVhCamRIZlJ6RVljSlBXdlg5ZTVWZit6c2dZYzRSVlpz?=
 =?utf-8?B?b3NGaUpqamkxdU5wVzcvdElTVGIzSmgxVmRiaWFRQk8zck1hdEx6cHVibHVm?=
 =?utf-8?B?YWVydDZ0S1RJVkZTQjVnY1hFV2xQd0VlejNrZVgyVkFOUkRTZ2htQU5YazMz?=
 =?utf-8?Q?WlbI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08f7d82-c2a4-4775-8655-08ddc89973c6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:59:15.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ4N8HzJKxcDFz2R3qKRXxTAVv54M8WJK1RWNA2Y0Mdm9UlNUfi/A7dPq6hIpyAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA5F0E981D

Hi Reinette,

On 7/17/25 22:54, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> Reading monitoring data for a monitoring group requires both the RMID and
>> CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
>> separately to several functions involved in retrieving event data.
>>
>> When "mbm_event" counter assignment mode is enabled, a counter ID is
>> required to read event data. The counter ID is obtained through
>> mbm_cntr_get(), which expects a struct rdtgroup pointer.
>>
>> Provide a pointer to the struct rdtgroup as parameter to functions involved
>> in retrieving event data to simplify access to RMID, CLOSID, and counter
>> ID.
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> @@ -429,9 +431,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>>   * __mon_event_count() is compared with the chunks value from the previous
>>   * invocation. This must be called once per second to maintain values in MBps.
>>   */
>> -static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
>> +static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
> 
> Function comments need an update to match this change.

Sure.

> 
>>  {
>>  	u64 cur_bw, bytes, cur_bytes;
>> +	u32 closid = rdtgrp->closid;
>> +	u32 rmid = rdtgrp->mon.rmid;
>>  	struct mbm_state *m;
>>  
>>  	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
> 
> Reinette
> 

-- 
Thanks
Babu Moger

