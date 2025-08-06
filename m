Return-Path: <linux-kernel+bounces-758373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCCB1CE2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E1018C24A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93209224AE8;
	Wed,  6 Aug 2025 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="isFUOOl3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D5422068D;
	Wed,  6 Aug 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514191; cv=fail; b=V9EIyF0Oyr7Z/34GnvH6rpuVQ+Ef53HHMG0lupI97Bia1oGnMoCf4vGjMEJAUPF4TU6GFxXTIDUwBdjH7u8gy1uOj6RJYK5pUJvlBMXAn5lVXluAASTLN33iNwrpx8aBxeGYhvE3i9e0qutxIPszHZu+R8THsQJxk4sfoPfEQmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514191; c=relaxed/simple;
	bh=lmcpuYCa1O4BO78jrTtRH9HCgOrxNmxGTng47qzSGUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hawGW7Sj/keivZAHEwPmsSPPYn5+Brp3ZWI+plgMe6R4q8o9XJXOlfWy8GPfdJZGipYuMDNZUsDSJg5S+vvP1oRh0ZLt4guAg6ryeLnbY7UltXJya39iBX0pG7Yh5shRabr1XZLm/cyNQbvnYaTJ+pmS9X8vsW21zIKXMG79bJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=isFUOOl3; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSz/JZHcvTzQCK4EhDidIAtLOs4aP+8ELwF0eMo8xfJORy1DHKI7y9IA2FRXNsH7k4KV0lgocPfwkRI/H2tWyFaIXPQDpMgYp9ukqMqQePUJZGaQTbWQh/sCSVl5fJ13gInO7WOobGoX7uqO7LnDOFhvbffJoYAJcIFUaaY6EasEOBxT66Uw5JUFHzlEVnJdJ+KJPRPA+/sEPPlmByIStxgpU/cb2HUSG4EJEbt2wjZqC/YpSiySnuAYZP1gsDAl4i+lsv4lw27WELo7UIucmU1G85GL0LuEzeVWqxsOV/APQjWbegY3ZpUMXYzJjqxg3j0QYDu9mttC2NlJeDeWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK8aYC2lglg2Li3VU0hWXiUwnhhzp0HsSKz39Finnmw=;
 b=qO4i+2uG3wEdqLp+XTRsXYy/+0gw8V0I4tZ8W5pSx9gbPfYr2f4kQ9aCbkGOHD2voRn9vrydZ6DXv2519pJQMs1SOn3XHkNqR3rf5lOz8McViPxybaxzejqnctUJX7M0YjG+RU0dxHiZKBJIPJUAo4wHrgpPc5yERZISjnOu+wt8oH9gyDPXS1DEB8ewfkOE+dLmsPRoP03RjmJ23hLApVLuGIyVtnPcIFGd0lxA2dRhpJo2dIWnQWAYnGeGO46ZmHUiwXqieD7T1wg4wivzEBSdDItUpeMJdi31UsOyjgqVYS6YnriepKcCl8GQfnnrNvykD+izZjdtnl88aXJf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK8aYC2lglg2Li3VU0hWXiUwnhhzp0HsSKz39Finnmw=;
 b=isFUOOl3uqq4pQG42XwI+vytUGJlnFBZPMrjTdGJSH4wgQREVzIbiwvFJcLmues6zuxqLXBuRAAC3T3gdsu4Q+HSv5OJ8xmTDf6kpTOZdW/oOtx34ODO1XUsi7TjTrdY+/Lfn/goPwWLiXOvQasOPWv3w0/sT0I7Wh3RBALb0gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA0PR12MB4367.namprd12.prod.outlook.com
 (2603:10b6:806:94::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 21:03:04 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Wed, 6 Aug 2025
 21:03:03 +0000
Message-ID: <8ce71c26-395a-4d04-ae75-5d54dcaf51d4@amd.com>
Date: Wed, 6 Aug 2025 16:02:59 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 10/34] fs/resctrl: Introduce the interface to display
 monitoring modes
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
 <d336be7c2776ef08534031b4c1ef1f3c6850ba2a.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <d336be7c2776ef08534031b4c1ef1f3c6850ba2a.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0255.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::20) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA0PR12MB4367:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b0abc3-d6a6-4378-9478-08ddd52ca23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJLWFppTXhPZURhbFk1QUppRVNTQ1VxOVlDa2NNdDdQUi9zekRDcHV3aXJh?=
 =?utf-8?B?WVlZVzE5TFNOU1k3YUt0TUZwZVNDaEhYQVVHYXlLTWl2cjNEeXRyQmhZNVZP?=
 =?utf-8?B?TE9QUmkyd3dTMXJBTXA5SlFCZldvUW5nMFZQMzdiaUxvdEhTMWJva0NHTU5j?=
 =?utf-8?B?a0Q5cGgyNmVISFVXOTBvOTkyMG50UnR3ZGZub1RTdHBQQWpYY0Y3Y1pLbml3?=
 =?utf-8?B?V0xNSkY3T3VTUCtmVUE5cDZLT1d5WlYxaEFsNnphNXZhZEN6U0MySUJRWjc5?=
 =?utf-8?B?Z0NINjR3ZXlYOXF1NWhlejlVdGxJZ3pOM1N1RWhyRUFQSENzUzhyVGVodXBQ?=
 =?utf-8?B?T2kxbnhkNVExRWdsM3pXelRjdlpscUw5UVNpalBoL1FhRHh0VW1VUnhSNzJC?=
 =?utf-8?B?azZZa21hWTFORWtMc1J3U2U2aXBnc21FQjQ0WGo2ck01OE1QNUVsby9nQ1Qx?=
 =?utf-8?B?N2kxeHVBaXgvQmo4QVVPODljR2FYMFUxMHRyU094L1pmM0REV3YrUFZsRU4v?=
 =?utf-8?B?RXBscmdlV1NZODVOb05NeXNLYk1LS1Npb0l4bGJQZFlKOFI2enZPdW9ZaHkz?=
 =?utf-8?B?TS83eFhHR0lzdWp1VmhybndQblpsRkkwNzByWjJLdFM2R2c5QTYvckNrTi9U?=
 =?utf-8?B?bWNrUDhRenNUWkFMMUthTlNyU1FFeHI0NGtrUTBlcGs5aU11ejZFMm0rYmVG?=
 =?utf-8?B?eGFld3IwTDQ4UGZHV05iQ1Z1Y0hMNTdNUTc5aHkvZ1ZkelovNjAxTzM3NGsz?=
 =?utf-8?B?dWNxOUNrV2k5SVVlQ2g2L0g3czVnVlZXUHJic2hoWjZoNVZYdEhkMjJGczNS?=
 =?utf-8?B?WEQ4UFoxWmc1cVNiTytWVVR4blB2SHhGdEZCN3NUZHVuSUM1cDlwRHFSVTZ4?=
 =?utf-8?B?Z0VyalhFVUd0T256bERYL2lpOUJyTlQ1MGZoN1FpMjROaFF5ZXhaQ0VYaURo?=
 =?utf-8?B?WjRsU0ZDWVlRbUh6ZlRYWXF3N1BCaUw1UzNCODlBWVorSlVxa2I0WnB6K0RS?=
 =?utf-8?B?RmxsK0JMcWRoV2d4cUx1b2RHbVptQ25SczAxaGVpME1vVVg5bVorTndDU2kv?=
 =?utf-8?B?M3M3RGpJTzVJaXVMUUtlclQxMW1PNGVXOVd2Mm1UbVdiTnhVWHc2TERINktZ?=
 =?utf-8?B?NUkyVWt0bWtZa0RtSVpZTDVqNUJ5UzNpU3U4aTYvb3FrY2ttNk5IQ2ZQYmhP?=
 =?utf-8?B?M1pVREZUREUwaE5kWGlqU2tNb2RjWHJRd2Y4WnBaNlpoODd5WWlhQUk5c08z?=
 =?utf-8?B?TEhNcFJ2SkU3SVRSMHNhaWtZMno3N2FaRTNGK2hSaHM5RXB0Wnc3M294cGM0?=
 =?utf-8?B?U2xPQTZkVzFHY3NXWGQ5Q2NObzJGL24wT3hmR1Y3cVluYmdiQlM4d21zaE9H?=
 =?utf-8?B?bmtpaTg3dURhZzliU0VlRnVISGdJZGY2MUg3MXFlcTBVWlVEYVBEVkphUi9T?=
 =?utf-8?B?cC95bERQS3h0Uk1UQXhzR0R5SnllSU9zMEEwS1QxeXdVRFBQWjluTXF1ODc2?=
 =?utf-8?B?Yy93ZE0xOWNQSkhPcnZlM2pZaG5YbzgzSGtZWVRoVlZCd1drOFRSRUNDYlNq?=
 =?utf-8?B?LzF6RmZaM1lEMGFWZjVOZEdacEdhZ3dzVWNaekxHeVNTWSs4a0VIM0I2UGtm?=
 =?utf-8?B?cUVzSzh1RGwyMzg3RmtLMDlaUGR5aEZvU3VtRDhBeW9QM1pxaXdZcDZMSFZQ?=
 =?utf-8?B?aGJaMHUwWnc2NEh4bmlabDVCRUZ3MVowVnpKUTNreWpUbHREdzE1ZjVTNmxO?=
 =?utf-8?B?Z24zb0grVVNxRkhKY1h1bkd4TjZrTTdrQ213RFg5TDRBRFQ0bm9GQy81RDZS?=
 =?utf-8?B?ZEQ3YVM0QmU2a210SnRQbkFYVkF0clFsR1VDS3JTZWlKWEdBeElGaFlxbk1j?=
 =?utf-8?B?bVZLa0FlOTEyK2d3ZGxYQXk1M3VmS0dRNFpDK1hBcVFuMzdYVm1XM3U3cGd1?=
 =?utf-8?Q?ntcfdx60U2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjNmaVUxdERZckp0dTQydmpvbmgxcTkwbHVMeW12YWxjQXhIVjNhZ3NQMDNG?=
 =?utf-8?B?c2VTMzdBNmtBN0hlSlFaNmZ3K3hqY0lVSlRneUV6a0JDWVVyS2pTTklyS2ZJ?=
 =?utf-8?B?aTYzbU4yaHlORzlOOEEzVVFnVUs4dkxXSG1telpMOGc3VGpNMWJEWkJuT2xL?=
 =?utf-8?B?bmtaMVMzUTNZamdnRlNJdE8xRndUN2VwbHpndm5kc2M5TTY4Y3RTQnVKVjh2?=
 =?utf-8?B?WVI5U2xtd21OY2pBRzVDS1dxUmZZc1M0b3FPVUJVdWR4VE9FWEhaQVZyU3Nv?=
 =?utf-8?B?cU5sdWI5TnlJcTJWZENxWGJhdjA4cmVsZ3A1dll2a0dlQzh6K3kwRzZHODV3?=
 =?utf-8?B?WG51b3RteWtBZUtjVW5ZQUY4UWVtSTlldXN2TGtFRnJxbjhPL0RwS1UwbVN3?=
 =?utf-8?B?MHM0VGRFSVh2RTJTYk03KzZ0OXVmT2lkeTJjaFQwR1ZKcjFVWlV6OFVseDMx?=
 =?utf-8?B?Z2dzOHluTWpQek5WeG5vYXlRSGhGNFhJWFhFeTBkc05LNStnUjV4YzN3TGx3?=
 =?utf-8?B?alI3NDlYR1Z2dmt0Z0JhbUZ1bi85WFhSVnAyWk1ydDZmVTMxdlVUNkJTRys2?=
 =?utf-8?B?YTlnT3BIMWdHNDRRVnUrR2JxeHRLZThjZFRYWlIySkt4dW1aTkcrMUV4VTNB?=
 =?utf-8?B?MUt2WndyalJqVzFLM1dnMWEwMEY0dTcrQVZlTUxnZTZFSnRDR1BZWGZPaFpX?=
 =?utf-8?B?MVhLOG4xbVZJNkRRdSt4T2lqTUI2TXBOclZNTFFSOVY0Qlg0L2YwSU9POVNT?=
 =?utf-8?B?VkxZM3NRSHZLVDNRY2hKK0FVMXU5Y2s5SkFUM0dUTVdjRkFYdlpHK3puSHd1?=
 =?utf-8?B?QXNjWmZQM2xxcTh0SlQvb045NEMvVHVMdENJbDdoUEFrYzIvWG1CZ1gwallY?=
 =?utf-8?B?ZzhjVGdsRjRKeHMzNEVCSnM3NEcrRy96YmlJK1c0OHJTMmlwRmFHNTVPYk02?=
 =?utf-8?B?L1l5ZVdXZERpaWtVczhYeHFBdHpqSFBhSGRTSFNmZ1VFQzlGNGdobGRSRkx6?=
 =?utf-8?B?V2JFaE54VER6OVhPbFpjVVA0LytHUjAvdEVub2srK2xDL3ptTUtweDBDTzZK?=
 =?utf-8?B?QlZiTnhMb1VnOGVkZnY2THVHWlhsRFV3WExqOXBkKzJiZDBjaXZ4TUl5a3Zi?=
 =?utf-8?B?ajROdjJjL3dEeTZGd1FBRFhJM1M4WHZsSEVGQzdOS1ZlaGdPeFg3VWFhaHYx?=
 =?utf-8?B?eElhdllXaEZRRDNMM1dxNG5CRU1GZUxRbGRQWjJzNTFncFR4T0UyKzdXK3dp?=
 =?utf-8?B?QnUvT0oxdWM5R1BQbitHV3o0bWd5TmlSS0pDVGc2eFlkZnBaS082aW1UcW5R?=
 =?utf-8?B?aUVDVkQ2aDY3WmN5QURpZ01DMGRjOTR2dktsOW9IMGpNS1ZNRVdRdmltcEg2?=
 =?utf-8?B?dCtoa0E5VXdpOFd1cEtxUU1PcEtXMVA0bFhoT1U3VTJvb3lyaW1XNUxhQzdv?=
 =?utf-8?B?VW1mWXAzcXBSVFJlVTYrVFdYSHhVcEFneHZML2JYTjE4bk4vdXZlcFAzUHVC?=
 =?utf-8?B?UG1JYklobklxTnFZRjk3V1V0WEJJcGROVnA0dlNjb0w0QnRneG9CNWVMM1E5?=
 =?utf-8?B?Q2FJTzZyM1d3L1dYc3lNVDgyVkVieEFxZC9HRU1aNzZMR1Ztek1uRGRCNTE4?=
 =?utf-8?B?bm50VVJYeEtCQ2M2Rjg4Tjc4SUZ6SGF6dnNpcWJxNDd3bHo4bUt6K2FLbmdy?=
 =?utf-8?B?NEhqZldhUkdJYnRKRzM2ckQ1M25IanQxWUpNUlpWKzBsakdtMURzbUpjYUxk?=
 =?utf-8?B?TzRCNCtWM2xJODhvRkZ6ZHBzOGN5TVR3NnkrL3VNK3E0WTFDTkNXS3Y3WkJj?=
 =?utf-8?B?TGxla3RLSGw2RGtBS3Q3ZklrYS82dDhqYnc1TEJnS3ZBLzZoc1JnL2l4dTBX?=
 =?utf-8?B?Q2ZHcmdSenR2bEFoT0JzeGRSYlljRU5JbkZqME1ROUJYTVJsdXRzeU1adUNu?=
 =?utf-8?B?MmZENGFGMHhLMGorQWZreDIvWWtLWUpvbmZGUEI5TllpSm90aTM1NG5XNjAz?=
 =?utf-8?B?TDRkdWpjTnB3NkdMSVBWVDZIMHA2ZnZFc0t4ckRXaUpCTlhWS2tEa21OaDZn?=
 =?utf-8?B?T0N3b29wT21sL3lSNEpxeStJRk43T2lKNlkxZHFCWnVIZGxzUm5TV1ViWXl2?=
 =?utf-8?Q?ahhw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b0abc3-d6a6-4378-9478-08ddd52ca23d
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:03:03.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQY2BfOclzegPF8s4pHWhxrjsKOFplbHqkBhGl1BOEjdbbB6qJLnP6p+W7hh2zNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4367

Hi Reinette,

On 7/25/25 13:29, Babu Moger wrote:
> Introduce the resctrl file "mbm_assign_mode" to list the supported counter
> assignment modes.
> 
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned. The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user. Each event within a resctrl group can be
> assigned independently in this mode.
> 
> On AMD systems "mbm_event" mode is backed by the ABMC (Assignable
> Bandwidth Monitoring Counters) hardware feature and is enabled by default.
> 
> The "default" mode is the existing mode that works without the explicit
> counter assignment, instead relying on dynamic counter assignment by
> hardware that may result in hardware not dedicating a counter resulting
> in monitoring data reads returning "Unavailable".
> 
> Provide an interface to display the monitor modes on the system.
> 
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_event]
> default
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check to support Arm64.
> 
> On x86, CONFIG_RESCTRL_ASSIGN_FIXED is not defined. On Arm64, it will be
> defined when the "mbm_event" mode is supported.
> 
> Add IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED) check early to ensure the user
> interface remains compatible with upcoming Arm64 support. IS_ENABLED()
> safely evaluates to 0 when the configuration is not defined.
> 
> As a result, for MPAM, the display would be either:
> [default]
> or
> [mbm_event]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> v16: Update with Reviewed-by tag.
> 
> v15: Minor text changes in changelog and resctrl.rst.
> 
> v14: Changed the name of the monitor mode to mbm_cntr_evt_assign based on the discussion.
>      https://lore.kernel.org/lkml/7628cec8-5914-4895-8289-027e7821777e@amd.com/
>      Changed the name of the mbm_assign_mode's.
>      Updated resctrl.rst for mbm_event mode.
>      Changed subject line to fs/resctrl.
> 
> v13: Updated the commit log with motivation for adding CONFIG_RESCTRL_ASSIGN_FIXED.
>      Added fflag RFTYPE_RES_CACHE for mbm_assign_mode file.
>      Updated user doc. Removed the references to "mbm_assign_control".
>      Resolved the conflicts with latest FS/ARCH code restructure.
> 
> v12: Minor text update in change log and user documentation.
>      Added the check CONFIG_RESCTRL_ASSIGN_FIXED to take care of arm platforms.
>      This will be defined only in arm and not in x86.
> 
> v11: Renamed rdtgroup_mbm_assign_mode_show() to resctrl_mbm_assign_mode_show().
>      Removed few texts in resctrl.rst about AMD specific information.
>      Updated few texts.
> 
> v10: Added few more text to user documentation clarify on the default mode.
> 
> v9: Updated user documentation based on comments.
> 
> v8: Commit message update.
> 
> v7: Updated the descriptions/commit log in resctrl.rst to generic text.
>     Thanks to James and Reinette.
>     Rename mbm_mode to mbm_assign_mode.
>     Introduced mutex lock in rdtgroup_mbm_mode_show().
> 
> v6: Added documentation for mbm_cntr_assign and legacy mode.
>     Moved mbm_mode fflags initialization to static initialization.
> 
> v5: Changed interface name to mbm_mode.
>     It will be always available even if ABMC feature is not supported.
>     Added description in resctrl.rst about ABMC mode.
>     Fixed display abmc and legacy consistantly.
> 
> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
> 
> v3: New patch to display ABMC capability.
> ---
>  Documentation/filesystems/resctrl.rst | 31 ++++++++++++++++++++++
>  fs/resctrl/rdtgroup.c                 | 37 +++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c97fd77a107d..b692829fec5f 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -257,6 +257,37 @@ with the following files:
>  	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>  	    0=0x30;1=0x30;3=0x15;4=0x15
>  
> +"mbm_assign_mode":
> +	The supported counter assignment modes. The enclosed brackets indicate which mode
> +	is enabled.
> +	::
> +
> +	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +	  [mbm_event]
> +	  default
> +
> +	"mbm_event":
> +
> +	mbm_event mode allows users to assign a hardware counter to an RMID, event
> +	pair and monitor the bandwidth usage as long as it is assigned. The hardware
> +	continues to track the assigned counter until it is explicitly unassigned by
> +	the user. Each event within a resctrl group can be assigned independently.
> +
> +	In this mode, a monitoring event can only accumulate data while it is backed
> +	by a hardware counter. Use "mbm_L3_assignments" found in each CTRL_MON and MON
> +	group to specify which of the events should have a counter assigned. The number
> +	of counters available is described in the "num_mbm_cntrs" file. Changing the
> +	mode may cause all counters on the resource to reset.
> +
> +	"default":
> +
> +	In default mode, resctrl assumes there is a hardware counter for each
> +	event within every CTRL_MON and MON group. On AMD platforms, it is
> +	recommended to use the mbm_event mode, if supported, to prevent reset of MBM
> +	events between reads resulting from hardware re-allocating counters. This can
> +	result in misleading values or display "Unavailable" if no counter is assigned
> +	to the event.
> +
>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
>  		bytes) at which a previously used LLC_occupancy
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index ca0475b75390..c7ca9113a12a 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1799,6 +1799,36 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>  	return ret ?: nbytes;
>  }
>  
> +static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
> +					struct seq_file *s, void *v)
> +{
> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
> +	bool enabled;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	enabled = resctrl_arch_mbm_cntr_assign_enabled(r);
> +
> +	if (r->mon.mbm_cntr_assignable) {
> +		if (enabled)
> +			seq_puts(s, "[mbm_event]\n");
> +		else
> +			seq_puts(s, "[default]\n");
> +
> +		if (!IS_ENABLED(CONFIG_RESCTRL_ASSIGN_FIXED)) {
> +			if (enabled)
> +				seq_puts(s, "default\n");
> +			else
> +				seq_puts(s, "mbm_event\n");
> +		}
> +	} else {
> +		seq_puts(s, "[default]\n");
> +	}
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}

The resctrl_mbm_assign_mode_show() can also be moved to monitor.c.

What do you think?



-- 
Thanks
Babu Moger


