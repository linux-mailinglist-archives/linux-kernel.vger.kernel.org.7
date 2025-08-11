Return-Path: <linux-kernel+bounces-763733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C3B21979
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7634B1A25170
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC722ACF3;
	Mon, 11 Aug 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K09RhlCO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C3158DAC;
	Mon, 11 Aug 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955610; cv=fail; b=Cik/Pznk5Uk8IEagHMrO7a5nG+9XKh891kXd+w+52gja+YLlA+fVgM6y6WTejxj6MbVIl3aJH0R7pJFnNzzP/kUlkrpvlTb0iWEUTOFN7y34xejoMZpkoCKwPYuszo9lRXuqi2vdlOkolI3ajCtXk9rdmh5QCeME/MiQPSEEWrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955610; c=relaxed/simple;
	bh=go6szpEfow/H8db+zJ3DpOO2WmZmpkKeTtJuyhIO9hk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WgsNqP5p/E6qI/lpZXm7T6pcYBhp9LWBfuWoHxdoAeXOmlKB47vN4g3aO7fzqLC1kLeF73X4FQfAwin+7GIRE7LyZRXPKYcQrckycEOKwjz15TIe77hxmkp4sZU9Ic3kMIcHH3/MLFcYpV09UJvM3TZlhQA71Ayapr1+y1aSBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K09RhlCO; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXT5AASG/d0qDjNsPE65GYdAoY1YJUkFWqoqFNhdUtOZuBO8Om4P7H/9sO1+xrKzNPonvedo2jRMca+3AkxT2YCLqjXUiXBPKajAAY7lQlALuY2kUg6zaYdQjHVUrckojsIPPX0jTYSQtSHjrwM1K1AquIy7sRRkfLZGj1hWj0MS97GDnJM4XqS6HcmmkeQ8uY3x1lWbFEdvckD/QYqgfok2VrcLWrVW99KELVtb5+YX1J/3XIYBay7trgoLdB9fHbPPtZUFBeK9tkuEtKM89mjsCmVb9pE8iYb3QjwgAxyucIWocg9Fybfus7F/IM0saFcyCQbKXjnsVjnaE4YDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL2IRNe9N6NLfvdtL9D1UbfUPpOoe3N4S9hit4NPRE0=;
 b=G+WlQFBcaTlmMUnVKXLWsp5Xh8/sn2pT8wkfbVyPrKWgVtibse02+GkbCdZTnGykYRZAFD1KkUOtStcreE4uToASGjk+pc1XEUqdbNhSixRnv+/jcLFVKTeowgHnp1bPw+wqjDyIaSlcAxTch79oXTVrdF8e90WJNPcJLYTXTOxMfaWeePe8IVaGr7pg4hpIx6Syth5Qg5vUNA1HxcVJH+2qJmxQNseoVKkZgeEaWY+stU/61Xn1Eum1GkWQk93lwWxjG5dahM0Lr4JIfTCepl1NC4iirTRorg7fC5ul9Y4Q+9AZxUT43p4ETrmoHiR5LdPyG6j5LVv4BLOkv9Xyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL2IRNe9N6NLfvdtL9D1UbfUPpOoe3N4S9hit4NPRE0=;
 b=K09RhlCO7NXlAzl567M1Ie3KqbbiiLS5KiH0hNbl5hLwp2gZQonM5NdEPD+Y3TfBJjQB3OQ87z/Q2oC4tY0mwtcqG9Cbe/0kk01h6xS1kbXyWnZDa+JOMvRk2Ii1U1D1d9QKfDX3lQzD2y0WlTg574jVE9MbE+emB+HUjB/CVac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SN7PR12MB7300.namprd12.prod.outlook.com
 (2603:10b6:806:298::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 23:40:06 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 11 Aug 2025
 23:40:05 +0000
Message-ID: <92fd18a3-ac02-48e3-97a4-13e07740aadf@amd.com>
Date: Mon, 11 Aug 2025 18:39:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 28/34] fs/resctrl: Auto assign counters on mkdir and
 clean up on group removal
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <df758bfeb3f8a3e975891029b3a0ca90da3744f0.1753467772.git.babu.moger@amd.com>
 <dbae9388-3fdc-4f26-9a1e-dd7abe73b0b0@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <dbae9388-3fdc-4f26-9a1e-dd7abe73b0b0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:806:a7::27) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3643b078-2134-423b-d899-08ddd9306659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk9vdjRWQUpiUEliR0l1R215Nm5VN3RXUkRxQklDUThObDNBK3F6VXFBNVJJ?=
 =?utf-8?B?NlJ5Sll6S0t1clB3UXhwS0RzV2I5Qk5odVhKYXJvUFJaL0x0Vjh4R0VET0Vo?=
 =?utf-8?B?eDkyd3ZCQnFwWHcvRHEzYnlnWFNOYnBMelRFR3ZnUlRNRENCZTRFT1ZBNHo3?=
 =?utf-8?B?WWNhK0EwTkMzb3ZQM3Blb0M2am1uUlgyclFsTzFUamdtUllRQjlkSTlHeFk4?=
 =?utf-8?B?dzk1SE54K3hhQi9rRDF0ZE1mWm1iWkljZ0w4YzNxK0padkJQZ0ZoOGZYYjR3?=
 =?utf-8?B?U3Vlc2pjZ0c1UFBUSDN3YXZSc0dxQ01HRUlZbVo3Rlg3cXRDcFFFS0c2ZU10?=
 =?utf-8?B?Qk83anhMS2RPNHkwSXFhQTJqcmc2UlZtc3hPeW9mT1c2a0RoeVBuMTRLelBE?=
 =?utf-8?B?ZWg0YVJ2OFZLR216WXJEdlFUdm5LdFcyam5TM2J2K2hUbnRadGRzNitPTUNp?=
 =?utf-8?B?NjR1d0lNaU01MHpIYWErSUcrL3BXbmNXTGZEdk14Z3VyY1VOQi9nWUlERmcw?=
 =?utf-8?B?U2NtcjYzc0RTT3pDdXpWV09Tc3oycFRrYkdGdFBnVkgzSnZJSzZlcjVKTUx3?=
 =?utf-8?B?eDYzakQzdmZLVUQ2RlFEZlNHcUlnMUZUU2c1d3VnVXU2QitZWUo4WHAyK284?=
 =?utf-8?B?Y29pT1Urcml1bUJxNU9udUh1bHN4aC8wNVlvVjZrMGxUWFkzN2dLaGp4OFhH?=
 =?utf-8?B?c1BSdjh5TGRxRk42RjFjbjV2elBSeHFVZ05DVklwelZtRGt1WUZIUTd6dFFu?=
 =?utf-8?B?YU5na3oyTEJ0SHBpTnZNVVBvQjdiMVdCUVJpbXBhWklGNnpOR2dYV1NreE9B?=
 =?utf-8?B?WnJmcDRrUjZ0Z1pBVG9id3cwQUNSQjlPSTNzWW1ZN0ZUdlRKRVVFRC9pWWhQ?=
 =?utf-8?B?aCtUdzREak5ZcHpYZVNOcEMzRi9Da3lIWDE0L1JseTdHaWVzc042MG42cjlS?=
 =?utf-8?B?K3Fib0tERlRZcU90Tkx4eFoxU2lyYlUvN0oxSi9WTXFQelZ2OHJwM0hjZEk0?=
 =?utf-8?B?K2JWYnNNVnlySEpQVUVYc0ZNUUUvOVJzSVVxemlqbnluMnN1QUlsZTBFUklE?=
 =?utf-8?B?NjhHQ1AyamxZZkEzSGVFNlNpb2J4NHRLWjFvL1poSE1obVJJZklyYTY0cTVM?=
 =?utf-8?B?Y0E3YzUyNE1GWEI1cmp3OERyeDg2c3Vhcm1JU3lZaXdHK3p2R242ejhkeWxY?=
 =?utf-8?B?WWxEWjZEMlh6SS8vR2dZTEtqMkVlU2RNV3kzUHRIZktZYkJjM2lubXgwdUlC?=
 =?utf-8?B?b3NqM2tWZ0puVENVNFgxVk9xM09uYWtpcTR1enNvaGVUaGZvUFkyRUVWQ3VN?=
 =?utf-8?B?TmxkSm1sd0ZCcElaaXFkTkpTa2VNMjZ4Mnh0UDJ4M0RISkJQLzJJUGg4WDRS?=
 =?utf-8?B?bW9memJsM0FFNmVYNFo5R1dqbFRIZTdIdkZiQzNBQjgwVDV6RlFlcmtqaW0x?=
 =?utf-8?B?RzViSXJhMFQyNW1vN2NaT0ZJano5YUx6SmFLWFc0d1RsSi9WSSttUVBBOXVj?=
 =?utf-8?B?cjVialgxMXdHRXZNWkxodVFoVXpuRkxaWGxodGJvYTVpVGQwd1EzVG81VHpG?=
 =?utf-8?B?aVJZVU9DcGNhOXdPTGRyR0tNWndRUUpXU005YXhzenRxdUtHZmdUNzhlWnM1?=
 =?utf-8?B?Ym1vRjRSRHVrTFJLNituZVZIaWM5cVgzY1Ewa0dBWWV3OXowT3RHWEN3MmRN?=
 =?utf-8?B?SlM1WXNWczVOMnRzOVNNTGVjWGNIbnB2RXdXOWNJU216MW5WQ21WYmtDRk9B?=
 =?utf-8?B?OFNQeG55aUx1N0c2d29OclQ1NS9jRVd6VnpuWHd2ZGluVTRrR0krNlo5NnEz?=
 =?utf-8?B?Y2pHNFZ5SUZXZHBxcU84eHVSazR0SEY0VGIzUUtDVE1TcGhndnJNWGk0Uno2?=
 =?utf-8?B?ZVBzT25VSGxkQ29tSFNreFJZcmlYV1BEc2dUOHBRNmNJclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRuU1R5d0owb08vUGtCeVF5NjhlZzlRSDJDWjBlWmV6bGlUdjFGWmgyYmph?=
 =?utf-8?B?b21jOTU2L0VqUHJ1eittUW5RaitIczdWMEl5VmVIN1prT1FpR2lueWdiUHpW?=
 =?utf-8?B?dE5sTnpEbVB5b3FpRVdNZmVNcXVvb0FUSkZsTklhVDBuMURNRmRjZ0JFcmJK?=
 =?utf-8?B?OFI4eDl2M2h4Nmo1YUVsWmlnWXBlbzR5V1E3V2F3a1V6cnBPM29LZ1pBQXhn?=
 =?utf-8?B?K3d1Z2U2UllyellHTXVKZmNJWVVxN1lhb01BNGtvUHlUQ1I3cVQyaWtVTVZK?=
 =?utf-8?B?WGZqUUc3aVVCYTQ1R0hNc3ZXRFRJUUZpNE1EWFFsLzJLTUkyenFOd0hoZkI3?=
 =?utf-8?B?Kzc3OXpOK3NXaWFOdWtCMktYZmNIcDd5Rm9vWDJRWnBMblBCNU81TGsxS1Vs?=
 =?utf-8?B?SmdYUW56UmtGcEFoWGNOMkZST0ZEblFKMHBNT0x1WXpoVjNkUnY4bExCZTl1?=
 =?utf-8?B?cUFlM2U2UXN1TGhZcC91ZmQwV2dIeW1GeSsva1REMnpmcTFMcnVqZUtyelZG?=
 =?utf-8?B?czJKYzZmQkZkazhubHBGbFY3YXVnK1RDTlpWS002aldZZ29VMi9XZGRoalMv?=
 =?utf-8?B?VHJLUG5WK3ZzMy9kSFBscEp0YldqdlV0TTl0SkppdDFYTlFwN1lrcHNTUmVR?=
 =?utf-8?B?Mm10OEVHT0V4NTFKVFpjUUNCQzR0bFVtbnVYYzRLdFRPSno1WmJGaW5BUWNW?=
 =?utf-8?B?Q2xpUEJEbGxOK3BESDdZbjZZMXpDOEY4aTJUTEJOMFVXZlBkZytTQ0E1VHp6?=
 =?utf-8?B?U21aVlRvWkZZTU4wMndoZThsajN4ZE5YZWlCNCsrMmVyQ1NjZU1Fb0x3elY3?=
 =?utf-8?B?bmFPZEhWcjFFU1hsalM0MVhaYVdCcFM1Zk5nOGxiNktiZ2RXQmV5UUEzeDVw?=
 =?utf-8?B?ZHBLTCtzUmJ0emFNTmdKRmNWZFUveUtNT2wwaUJhZGUrNC9hYzk3MHErdFlE?=
 =?utf-8?B?ZVk2QzBsRnZzMm0wTVdLN2trVWV4dzNrcUZYOTZwU090MkVST2l4QnB2aUw4?=
 =?utf-8?B?L1p1M0FibVRLMi9RYVJGV2FyNitUb0RUMlRvVzA5RnU0QVR0emlwYUhrL0dH?=
 =?utf-8?B?UmlmWHlTWm1lbWlEdEVVUzdXeHRSWnVQTXpPclgwdGNKaEtBWkpOVFBrNUNz?=
 =?utf-8?B?T0FEdjFpemNnTmRtVWZBb1ZuUjBBdlY4S0NnK0l0TzBIb2h5MXVMMGRLZHl0?=
 =?utf-8?B?c2p6cWFoM0grYkxiSmNEK2lrNkVna3RWbkFBbVUvMlN6bEYwb0ZiczdQNFZB?=
 =?utf-8?B?TDRKSUl2SGNkbFBVRW82bEtEdEZ6ZXc0aTJIMmI3VTBFWXJJb1Y4ZVRuSjkz?=
 =?utf-8?B?T3ZQbG10aUdWRzZDOVZWQk5xMUpMT3pzRmJZeE5vZm5SUERzaythNTBWSHha?=
 =?utf-8?B?ZldreGdiV0hjNkZkVGh6ZTVMbUlqMUh2Y1ZrbXRRVXpiajdYcUlza2lzM2Zn?=
 =?utf-8?B?L29kbjdUMGdUVWNyQnAxTEFmQXlQNGZpQ0w5THlzMjZMWEt6OGR3Y2lTLzVk?=
 =?utf-8?B?YmVrMWdDZ1dKeDgzWk8rbEFaL2YxYy9uZ0s4TUhGSGFpVEx1M05WMnRVUFlM?=
 =?utf-8?B?dmZCZ2FCbFRmdW01a2h4VnEzSWZHRGRKVUljQmZnTjYxczBXRU9oMUlrNXRx?=
 =?utf-8?B?WWIrVUhxV1lDbXpsekREOHI0TmowTkJUMTJRaDV3WTY2K21mMEV6V0xPSzBP?=
 =?utf-8?B?Z2VXQ0plL2dwVHM3STRlUXJBUVVzTDIxSGV1YnRUbUcxRXlxRFRWYTM4Yi9P?=
 =?utf-8?B?V25WSWhsR3JlQ2U5WklMUlgyQUdub0tJS1RkQm9KZnlYR29POFBpVmVPUnVT?=
 =?utf-8?B?ZUsxOVJucVg0Y1RPT2RWd2M2SFJqUjZvN0trSmJINko3NS9NZjZTSVZINmZL?=
 =?utf-8?B?WVdOeXZlMGtkSEZIUnpEWVBjMWIvUlZTQjkxYVZGY0RhWVUrUExaaVkxcFZS?=
 =?utf-8?B?QzBQVHpFa3ZKZExObjdGYy9rUkcrS2RDcDQ4M0plNXN0bUNZK3FKaEwwQlU4?=
 =?utf-8?B?SmtyNTRHWW1zdWJRSXh0UzNYWC9wZjVDWjFFeUVXNTVWTUZJTjNxOFc4Ky8y?=
 =?utf-8?B?ejQzdUhJdDNNZHIvSStsQ01xNDlpcXNicmNwdzJmTjRHNW1IKzVYbWU0QjBs?=
 =?utf-8?Q?D8DN9oq/op/UmpXhNyEqGE22j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3643b078-2134-423b-d899-08ddd9306659
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:40:05.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA+Y5tinLKoD89HKA692CPP970QA+CduT7INg81CT9oBSW64JhCNTDK3ka3P8leq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

Hi Reinette,

On 7/30/2025 3:08 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>
>> ---
>>   fs/resctrl/monitor.c  |  1 +
>>   fs/resctrl/rdtgroup.c | 70 +++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 69 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 6205bbfe08fb..5cf1b79c17f5 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1072,6 +1072,7 @@ int resctrl_mon_resource_init(void)
>>   		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
>>   								   READS_TO_LOCAL_S_MEM |
>>   								   NON_TEMP_WRITE_TO_LOCAL_MEM;
>> +		r->mon.mbm_assign_on_mkdir = true;
>>   		resctrl_file_fflags_init("num_mbm_cntrs",
>>   					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>>   		resctrl_file_fflags_init("available_mbm_cntrs",
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index bf04235d2603..d087ba990cd3 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
> Please move rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to
> be with counter management code in monitor.c

Sure.  Taken care of this.

Thanks

Babu


