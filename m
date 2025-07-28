Return-Path: <linux-kernel+bounces-748025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9FB13B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B549F3BD0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87511266B41;
	Mon, 28 Jul 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrWOTZ/+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5E268683
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753709691; cv=fail; b=rzZM+0Khdp4ZTKeAQuxl4mrA3ZfDE6by1sDdmHnubodI41rHIG3FygY7Aok/Y3vz5F8Zr114shcObLxQ1tWgBjmN5X5ZyU5gtS4WXryCIsh6UE3JKDklMoEHxAmwXHCDsD1vKGNiyzT6SKh9CbrGQ0qAIt/gAoNXVvFFHnSN2MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753709691; c=relaxed/simple;
	bh=jF7QEslNvut6A1+xJVtleD+2OTq+EhewrRJjiHGT7s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CqSGuik8y7EGASWb9YTB8XWkjITp/6saRm/alhR+fvKUzuctoEzlUIDAgZCRjWLvICQetuOqyyCe3Gv9l4K0F76ff+CJxzrIdS5hwyj/n0YCydzseMuOfDYK8y93pUCdGL1Kw5zA8fKPMNkU1wMgDvWpYTBLoySFTWqTBzBtQHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JrWOTZ/+; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMuOC4YMpqFKNEpFIjVkP/cNivFbUNMjj41b1lHVuyBUy2KwxfbZ9bRJpK/i9CWascl6FIIlKmJzitLZwCPzXqjO1iZn9X7CJCiD0zOnSgpCavu7FvjorM1Fs7I3zBlLl049X5ylm5ju936N7ksbVqsaw9xQB2EIy9bSCDE6cYEYTHiDQOdarSOqYlGkKWSQ/a1xgGXPXIUfRO04tgkDEn8MVvFLvYiWAF1z33OB2JDbfOtyFMgKrLIEFjKp3gc6PQ3DbtlYAsQH8aoCuzjNEub/FZZOCs51MGtEDVQ4TjHHcvpG7xoj9oWb/WwIbYm0SBTiyWCNQ0b0Rsyqw4FQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQGzwWxkdNMAsebqaDhowvhD8OMZhYvXJHwf+aj4YsI=;
 b=NFKVFzhsZVwkxazGnV8SIlOZG89V0DdheB/bfL1AhCMu/Db2cBYlLuCeppkjAebLEvFAOgwG8ZWsK3lK90FsAhzgORmbbHGGpB3h+izfENL5XvGH6Rzt2rUBcnuRsEMWnlfvywlm084rfEFL20ITV3DfILcdgSUTwbOw4HH5FhVEydfLAVzif6jwLSV+G34B3mhVBgx6V88eAti0V7cxVWRwCldPnd++C3TuVW2R3a1LdbxwC+bud+eTFtzrvBj0a65oX7XWbTR3m7aigTiiClD28zM3odabQcgh7CMcavBkOUX1mT6Vx+hyNz0+XTtoUNE3aG4n0jEE6m0OjgY10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQGzwWxkdNMAsebqaDhowvhD8OMZhYvXJHwf+aj4YsI=;
 b=JrWOTZ/+kDZ9z6M4rw6vUW91os64cFQG9Z7mj47Amsj2jiOuK1JF0VCzPR4ogNMXowmzKco4c+kpak5PfGz2wITKPLG5j7k80lJPvZrwqsuKCyFLP1SJtlSrFqHMq4PBaPiRp+DgaG4tYqKeCLJnhGVQgaB5PEnHpSJVvMy7ZtczZJ+rrTjqoC3RKL2hbY7qe71K9pp07jTxWEcv1vEOo/O6p1bSVZu56lNDyCXNUvM/M6suTCnJbc0UGpscAWEHJKtKCTk8YHshrwqHPyUEls9DMslQc6Is+LORnXa0XWTbCpAa95HVdgZ0lR/TfxZD532KNf/143aqLsqylU3azQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:34:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 13:34:46 +0000
Date: Mon, 28 Jul 2025 10:34:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, leonro@nvidia.com,
	Francois Dugast <francois.dugast@intel.com>, airlied@gmail.com,
	akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, dakr@kernel.org, david@redhat.com,
	donettom@linux.ibm.com, jane.chu@oracle.com, jglisse@redhat.com,
	kherbst@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lyude@redhat.com, peterx@redhat.com,
	ryan.roberts@arm.com, shuah@kernel.org, simona@ffwll.ch,
	wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-ID: <20250728133440.GB36037@nvidia.com>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <023ab16d-f3af-487e-a7ce-929bf7b2fe3e@nvidia.com>
 <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: YT4PR01CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: cec72e0b-b640-4ede-e1ea-08ddcddb845a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ky9uL2s5VUZTVTVMOXd0UUhrNFlBODVNSTRrcVZWclJ4UENvUHNwdjhyNlpk?=
 =?utf-8?B?MXA5enNBSld1K2dFMEE1VFFmWFU3S3ZzMExuYkFrR3ZOclBoK2RTM2RDWnYv?=
 =?utf-8?B?SThydWlEL1pyWTRjelRXTHB5L2krK3BEU1czTXI1S0p0Qjh2ZU81R0g0amNZ?=
 =?utf-8?B?M3Nqclpxb1RaSmprWDg1ZGRZRnRXandSM2loVGJxZWl4RE13YVZRREFoQXds?=
 =?utf-8?B?VEZhSzVleXAwb21YMHdqRENUYy9XOE8vWW1qTkhJQ3k4Vm94U0gwdGVvWUxo?=
 =?utf-8?B?QTBmaENqZ01WZVNXSUZjYWF4WVc3MU1OSDdCaW9ML21qVWVXVVBUNko5cDV5?=
 =?utf-8?B?OTM4d2YxLzg3WXZIOWxDUjA5bi9LamZhMURUb01rTXFCcUN0dUVBbkMyNWtU?=
 =?utf-8?B?TzVKd0FJUHNQOVo3WFJoUnBtbWJtY1Nqb2pPSVFUc2t2NWZoaERVaDdDRUgr?=
 =?utf-8?B?YnNBSk14UjZ3dkxiWGk5YUdWbnpWNS9jRkV2SUhXN3dZcGhuRHRlbzl1THZV?=
 =?utf-8?B?eUdsTDlPVVJHZkc0VUdtZ1VpRVhmOEl3R3VNYTZ1VHg2RWJqSmhLTzdFWVZC?=
 =?utf-8?B?R2RXWmVLTUMvcFZvYWRJR3RnSVpsOW9pVkZ2U1ozQlFIUkNvQUcvYVBzalZT?=
 =?utf-8?B?SWdYWENiMGtYYnFlN3NrRnlUeUJ5YkQzVS9SWGcrOVI4b3BiL1g5cXdOS3d3?=
 =?utf-8?B?VWlVNStpYXNqcmV3aDErN2NlcnlFOXFhWmtyOTkydXl6L21oZktvUVdrVEtW?=
 =?utf-8?B?VmNjM3R5NnloV0lheXdnMHFWazBNMjgxWDNkWm54TVY3a0xVQldRcWR1N1Zz?=
 =?utf-8?B?OUJKMENpUXZhQmtacVg1VldzNC9hOVpsbnhaVTIrZzFwaVRtbi9sS3dUTmJB?=
 =?utf-8?B?dXZzVGpBYkdTeFh1U3dUQkVGZ0d4YjltRVpUZG4xc3FlT2ZhVEdDdkNEaDlB?=
 =?utf-8?B?bmJwZ3Z5d1JMM003SlI1dU1sMnd0NG11Ynd1NFljcW1nVURCQ081NmNIN0dh?=
 =?utf-8?B?cEVZMVpOYXpyTnJqVzB6Uko2cVBJeWVxSjA2RG1VdTE4cmQ1eWt3VkpUN2p2?=
 =?utf-8?B?NDFINEFCL3JSMWg0NUtCWmZUM0VSOFdlTERha2VrSENUNzFLLy9pNGJVeEw0?=
 =?utf-8?B?eExac1IrbHcwbXdyeDkrVG1mWmwwSjFGSnlhSEtSN1g2VDg3RkY4RFNHRmJI?=
 =?utf-8?B?UDN2M1ZkRmp4SXNEc3RVaThLVjhRMXVxdFNRV1lUWjdUbVhib0gxZ3ExOGsr?=
 =?utf-8?B?YXZMNStucHdZYjlLQURDZDVVWUtMMDZEdFVVcm93aGNPdWdFNm5sS05LVmk0?=
 =?utf-8?B?SmJXb1JyamZzZlp5RXh3RTBzWGd3aklGNUFweWR5blB5Q3B0a1RITFdNbmFy?=
 =?utf-8?B?SHZCakRvRE1IMkpWZS91bDVXUnlPQlE2MCtBdVZUYlFsYVV1elFrMEh1VDQ5?=
 =?utf-8?B?RFU0YjZCMjJ1WXY1ZzRHdmV2ZVNLSkZiWVFEODUvT1ZuWHl3Vm5KUlB6K0kv?=
 =?utf-8?B?N1d2WStFdENoYmdEZElMYWxHcE5ucldNRkk2QU5WNTR3VzlEaFZObEZlTXlM?=
 =?utf-8?B?Qld3RUVoSWtkN1FwdUI4ZEw5ZjJnRmthWlh0R29oVlkxeDVWR2JXUDBRQjBI?=
 =?utf-8?B?UTRWcFBCVWZIMTJpVTF1MCtDWTJkbkdNQlROR1RUS0hUU2RoYjJQaU41ak50?=
 =?utf-8?B?NkpTTldnaXBKS0FzMHZQWjAxVUk0eHR5ZmcyTU0vRU1UamtMZDQ2M0NLRE9s?=
 =?utf-8?B?SVJRYzdKL0k3clp5UFdnK1kybnNxVndpMTRtOStBc1FZYXNWdXkrWjFKcmZO?=
 =?utf-8?B?ZHJnZ1RPdytJWFhPQnRPbFlnaVpLYXZzVzljUTJ4MThuWGVnRWUvQmRkekVE?=
 =?utf-8?B?YWR2WmJQWjllb3BVSHhtT2xvSjFsLy9tdU84dkFhUnZ5NDZVQzZQcURKSjZk?=
 =?utf-8?Q?iG13pm/Ca/g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk13Q2tTUUFWaEM5UEhvMjJRUGkyZi93bEZhR3Rxb3gxeDJCbEhWaDh6clRv?=
 =?utf-8?B?QUpKUVhVak1FNjAyaWhHM1ZKRUtmNmtlN0YwdG13N3JkM1FDbzNKV2RHQlVo?=
 =?utf-8?B?dndMRzZRMnQ3bCtUa0VtdWpQWFZIOHFFV21LYThmYU5DSFk1a0s0RHhWWVZz?=
 =?utf-8?B?YnQ2eWNpOVBoaGoxb3VLcUtjWEpnN0UrVDMzTXo3R1lGZjNweEd0MXF4Wksr?=
 =?utf-8?B?bGdKMnQwSzRnRFVuWmMzZFNDRWF5cTlva2RybTNFNExiOHJvcUw0ZjJicmtu?=
 =?utf-8?B?YWd1QTVSaVZOQ2ozZjRLdHFZZGh5bWlLOVhGTHRkVi9ncVJPeXU4K0lRc0l0?=
 =?utf-8?B?dWc4N0lnNG1PeFV2VkJFakp0MEsyVzFpSUlwbVZMQ2hwOTZic3E4VmUzaDVF?=
 =?utf-8?B?cVN6L2EyYlpjSzhlYmxFaURmZDhLZHVLUVJtSEZvU3p1dk9IUHpDR3Vsak1t?=
 =?utf-8?B?VzBSNER2cUtCSVhyWkcvL2dPbGRnN2dhRUlvK3RsNnlYaEFRUVQ0bXFKVVU1?=
 =?utf-8?B?eEpDbVB3dXRtYnZuQUYxZ0FWbkpYZU1nL2tPT2FmSGJ5WVBoaUdldjJtUHRh?=
 =?utf-8?B?eUkzbGtCbGFWSmxyNXJuOHBMVWhkWHJQaGtKZWM3cExDU0JWUkkveHpSdVJS?=
 =?utf-8?B?b0lMN3ZlR1RYdFNuQW9DUCttVkdTbUZuZUUwdnVvMEdJVUk4U1REcEZsbEtQ?=
 =?utf-8?B?dlZUc05jUTJqUkRYaGEwV1R3RmtyVkE0bUxrY1lEUXNNcitQMUh6WnJXRE9j?=
 =?utf-8?B?NENXUURaa0dFeHA4SGxIWVZDbmNpRjFTRGpNcVMybHFFOVhSYUNrMGxuS3B2?=
 =?utf-8?B?VFJOS0duc1RKcVU0eSt4SEpqSWN1TEFLNW81S1NYZWxXK0h1amdjOTBNOGtv?=
 =?utf-8?B?bVZNRmZ6THQ0dzBHRG5WM1kzT2tIVW9VbUlZK2N0V2RxN21yUXVqbWlhMHRD?=
 =?utf-8?B?b01rcm9MaWtWOUJVcmRtb0lnKzhxRFRyODJWeTE3ZnF3Z25IcllMU3VFWFBC?=
 =?utf-8?B?aTNhellYSU9ranJXUnp2QnVFTW9ZNGVKZTN0SHdSdDJoVFA1TTRVZzBnTGZr?=
 =?utf-8?B?eCtsUk56Q2NBU0U1YjNXeXNhZVlqbCtXZTUwV1F5blhTSnpsR0NiOHh0Ly91?=
 =?utf-8?B?Qm45SFdubTY3WTVSV2puK2xoNVJpWHpRUWI0anE3bko1ZUg2TGxyRGtoVkZG?=
 =?utf-8?B?UDUzRm42aGJrcXU5VG91TmRKeGxUM1ZtUSsrVmdYSlVFQzVrRFo1NXZnZDRW?=
 =?utf-8?B?WEp2SUloczBnMUJBMk4zeCtpZUR1VUlxa3ROT09hT2JkQ0hEdDlrRnBMbDVS?=
 =?utf-8?B?NEJFUyswQXR6b2NQZ3FTYTB5c0ZHRnNrUGNFYU5lU3cwa1k3VVdtWDAxdTdR?=
 =?utf-8?B?citZQkpiQTNYK3BJbDVlbW1VM2hpeTlFWHczWE8xOUxYRk1QZzIxeXpiMVJm?=
 =?utf-8?B?bE5kVnltU05YdDdkM1grdnNTYmpWbHdIK2NoRyszZ1RLOXlRNmVmTnliMnN2?=
 =?utf-8?B?ejdiT3UzSEpQZWgrTHZuanlNa1V2TGFiWWgrTHRMeHdvM3kxcWVibXZ4ZkJQ?=
 =?utf-8?B?WjR0OWdnTjRWWnRsVDU1Wk5jVmlvWDdqRThKem5SMG1RaDlyRlp1cFQ3REFj?=
 =?utf-8?B?ZXVDdTN5SFh5WDNCZHVVZEVhMlA5RkVlMDQ5M1VtZTJ5dEpDYVp5UWwyWWxD?=
 =?utf-8?B?K2dUaFdER25iYmhvTFJ3SzVNc1gyeGJ5UVRXNmdxanVicTdSMHVWWXAzM3JJ?=
 =?utf-8?B?TmlPTU9nQmV0aVYxUUJrRE9MMEd4ZTdrUTRRZEVNdDFEQSt0ekpNOXo2R3dM?=
 =?utf-8?B?V1JsSTdzYncwNWdqbWlZYTloejMzTCt6ZGJra1VGYzA5OTR2RmhUa25qTHFn?=
 =?utf-8?B?S1RldEVyeWdEYlRRaUNKSWFwQ1hoTEZrYlZQZ1dQSnNKZDdtNmpDanIvSmhS?=
 =?utf-8?B?SzdHQ281Ums4ZjhhRVNlenpRazROR0loUHhQenl3eGluK2ZFbmtUbXdQYlRD?=
 =?utf-8?B?TmllM0pwb1pGNGFpYml5cXBCekljN0s2Um16N21mNmNQNXhGc0twaE9IZ3BM?=
 =?utf-8?B?Z25obXFxcTZ5TTMwcVJnczBVejJIWkErMFJ2bVBrYnEwY0VFbUhzTS9aLytZ?=
 =?utf-8?Q?hpRc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec72e0b-b640-4ede-e1ea-08ddcddb845a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:34:46.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI0oWvm7czm9Q7nPVmw/oMJjOyT4NXc55bJruHyI1IOdhttmKt3p+4gOhwCszLwN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

On Wed, Jul 23, 2025 at 10:02:58PM -0700, Matthew Brost wrote:
> On Thu, Jul 24, 2025 at 10:25:11AM +1000, Balbir Singh wrote:
> > On 7/23/25 05:34, Francois Dugast wrote:
> > > When the PMD swap entry is device private and owned by the caller,
> > > skip the range faulting and instead just set the correct HMM PFNs.
> > > This is similar to the logic for PTEs in hmm_vma_handle_pte().
> > > 
> > > For now, each hmm_pfns[i] entry is populated as it is currently done
> > > in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> > > optimization could be to make use of the order and skip populating
> > > subsequent PFNs.
> > 
> > I think we should test and remove these now
> > 
> 
> +Jason, Leon – perhaps either of you can provide insight into why
> hmm_vma_handle_pmd fully populates the HMM PFNs when a higher-order page
> is found.

I'm not sure why this is burined in some weird unrelated thread,
please post patches normally and CC the right people.

At least the main patch looks reasonable to me, and probably should do
pgd as well while at it?

> If we can be assured that changing this won’t break other parts of the
> kernel, I agree it should be removed. A snippet of documentation should
> also be added indicating that when higher-order PFNs are found,
> subsequent PFNs within the range will remain unpopulated. I can verify
> that GPU SVM works just fine without these PFNs being populated.

We can only do this if someone audits all the current users to confirm
they are compatible. Do that and then it is OK to propose the change.

I think the current version evolved as an optimization so I would not
be surprised to see that some callers need fixing.

Jason

