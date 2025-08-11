Return-Path: <linux-kernel+bounces-763737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46AB2198F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E563A688E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3ED2853EB;
	Mon, 11 Aug 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjPRIqF0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF31A22D9EB;
	Mon, 11 Aug 2025 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956328; cv=fail; b=kRrLRhnCjOsYbRMXw/5f5NGHjh41sU2wU+5Vth0OiF+4NzjGcwGw/ZjQS+be481bs3DXieJkGj1EBCdGyCPDAMuDLXojDRLRCmcGQhZD16ZXHoBRm9EnHiwmcZvoTnfbB67708u2nRMgw4lbKMrHXMYyAk4TWaQPe1H2eP1KK5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956328; c=relaxed/simple;
	bh=YGycEF3zT3pmxAWOiXEiL6BzUwb9JYK0L+kIgB6ZVhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AWAXyy5J+yKH1MB9urXfEr6TyvzftNY2n7CUlusa2jbRlKhOW2zpV68YvTNiXFoZ6mv68glDkWollMkIltO/q2e/lXeII7iELl/ZjNcqFEx+j/nnVbD7md67JvOYo5LtF1sdxUClZzVsn37l5X9gbnPvVKCgqlQliWlvQSn50GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjPRIqF0; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYUCEGgweiPG7pG/e8J1fUWAmEZjASOSOXjfNW2zLafet0Er/7UrqY2/vdBL5DJ5nmUijorH5yCZpBMnB12VVPUzcfby12n799X+AKvFaO9G8uVGoZga+2ChP3l69L3aMMW6gSb9BlrXWMmefTbtnlv0m1q5OCDS734+nBvs0Dq30FUvJLK3qt6u+Fyp6nVlqJnKaYVgRJH8rL+9dNLqjb4EKS30Vx5T/pIEO1Z8ThkbTgV+5ZVcN7H0t2tBNdMwQtKGR03T3Mflo9aKE5epgovNaqqKRGlkLq9FDs4hDIysZFk29fsc2LKEoMR0vZpbbPtUR8bh8kGfNbthm4tVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yhe13I1EAZA9MvKs85Ixo+Gia4f1tQPhAJWnBNl+BI=;
 b=W8GnPBSvepOwj/mdqHlM7ksX0NZcIrW1hejfMst60pvOnuZcF6OIt3eWQ/RuSbznzQ1/7SMiOsxMhilGOrVBsyU9ii0QE5KT4j+DYv8BkUnD087bjok+0FNgS/p9SA+r7uKWfQb9o9IvgQTsgi5XXIcRdweEeF0XGYs+mBSsNmSpvpVUXOg5jvh8HZvqfziRUJtLyjrvChpqdo+/J8oegQirGl2fhF/Kjha3tadZeeDiuhsVi53g0mLBP9pNmtiuhw9TopNK82srJFJiBh+fhwrv8UJofZsQoU4AwTU3EMTr9ev7nYkRo9Q4lUHhihmQpxFhiOQImJTBAz/X50l+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yhe13I1EAZA9MvKs85Ixo+Gia4f1tQPhAJWnBNl+BI=;
 b=vjPRIqF0sElUaOt843J/VaklXa8xWN/UHYl0/EP5glLwJwBQ5IwiJTcwThVhXgYS6QrxoJTf+KsLZ0PC3c6mUi0Ck+PBr/oQdcpOTfkrJ990KGIEpr4fc2Q8P78cUaYgE3NbzueuLLxhoTHZhjsoOXhR0cchmSmDEcoRAjna1JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by MN2PR12MB4270.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Mon, 11 Aug
 2025 23:52:02 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Mon, 11 Aug 2025
 23:52:02 +0000
Message-ID: <ff20aa57-9858-4cca-8709-51cbb67037d5@amd.com>
Date: Mon, 11 Aug 2025 18:51:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 30/34] fs/resctrl: Introduce the interface to modify
 assignments in a group
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
 <5c589b07428d3bce95616b0f69fc58883eb86360.1753467772.git.babu.moger@amd.com>
 <2e88d204-cca4-4df4-94f1-478150eff2cf@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2e88d204-cca4-4df4-94f1-478150eff2cf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:806:28::32) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 993bca9b-3181-4c9a-e5fd-08ddd932114b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SngxSVBwZk5HMHdZV25NN1BIRnNFenVpcWtaTm14d3NkUkZSZUptZm5QdnVr?=
 =?utf-8?B?YVFBSnBDYjNSeGNpWVora3RMZlhFUFh4WXl4YTNsMjBYdzU3eDdETkFxWEo3?=
 =?utf-8?B?KzFUb3kxeWdKT3ZMU0c0dkRFbnRXeFZ5ZnVpY0VaSk9qbG5UaTg5R21Pb0JH?=
 =?utf-8?B?R09kRGlMcFFCN2pjQnp6UitEbk9xem0yWGduYzAwNGozQXV3WE9IclZnakhB?=
 =?utf-8?B?UjVucWVsMVFtYTBqYnJUajlvc0xpTEhidnJPdXBMK2hOY2ljWGNnM0JvMWlw?=
 =?utf-8?B?SHo1NFpPeksrbStvQ3M0dERPZFNSK0JydmlqT3RueFVNL1dqTCt4ZDFJTkZy?=
 =?utf-8?B?TGhrSkhsR29oTkhEMnVYcXFLVVBqc0xCd2R5VnlWOW5VVTdMSHNPMG5nVzhT?=
 =?utf-8?B?Y0h4b0h3aWdtNXFod2ZQODBRUDNTdzRvRGxlOUpGMm5wOXdSSExpZmFaZDY3?=
 =?utf-8?B?UnZWY2V5Q2Q3bzBpU2FseFVQN3E2WjF5aTlHOTVBeHB6aGpuYnVpRXFrd2Vi?=
 =?utf-8?B?ajdBMGJHVXBNRFMybmdPWE9qanpaWjVmcVNPMDFSTTZYRDdZUTM1NkpPd0Ir?=
 =?utf-8?B?VVgwRVJvM1A0WGRUTDZSTlZSazNRTHdhdG1ETlB6YVd1bWx4QU8yc1NFUmlP?=
 =?utf-8?B?SmdEaEFMeGlSSnhVTDN1M3c4RHFJV2x4Qm1vYWVYLzJpcVNoUUlYYUJkVloy?=
 =?utf-8?B?Ni9VYSt3UVpleW1hYWFhTHVCaHNGSTI3TmJTVGlaa3o5eHltaGM5WTNnMTYy?=
 =?utf-8?B?a1c1d2RsM2RQeVhqV3ZOMFc0OW5maEpJcnV4NkM3bC9qanQxaUt1eVliRWRF?=
 =?utf-8?B?L2hFS3QxS2FsYnlieEtpL1lrZEVjQW56dXd6WG9ldXozSStpdUpwQ0NubVBy?=
 =?utf-8?B?YnUyWDY5ejk2cDBucktSNkMvdVlDYkw4ZjRrUkJlNnJuVTN4RGhSY05FeURh?=
 =?utf-8?B?RXBsRit5NGhJZ0JudE9heHlaV1ErQ1V1Y2k5bFdGTXN2Z09JT3daK0NWcitV?=
 =?utf-8?B?V1BoakErVXgxNWR5N2g4eDM4bnYvMWxWOWk3OU43NlBYZ0VpQTR5aVhiL0Nr?=
 =?utf-8?B?cXkvYmx3NFlLeEdidUR0SnQzL1h4czhBMERlZmtqMDJuaDZSL1dHMTdrV0ho?=
 =?utf-8?B?SktVTHNaNFJHWFJTaStTZWFvaG5XTG9CaGtaVGloeEh5MjcybzhCenhsNTFR?=
 =?utf-8?B?NDcwMzlWaFIzY1NtUW5rM3Mwb013NXA0WlZYS1BJUjdoSXBDRVRGMm8vU1d4?=
 =?utf-8?B?bW04aXY5c2JpQU9FZUZwYy9IRlJlQld3QXJiNWZHaWxrcVBubllyNStSdkxN?=
 =?utf-8?B?NzFudWtDRi9UaFZrTE5UZkptYllmeDczY1piSStsKzRwQUhyWEhZenVZZzk0?=
 =?utf-8?B?WXVSd3JIOFNGMmcybnRJS0ZwMVdKNGhNbmZoTEo2N3J2MTlkUGQ5ejBzRzFX?=
 =?utf-8?B?TGxLZGd5ay9jQ25wYkZBMlR1SGp4SkFoeVlYUzY5eFEyaWVTVGhPOWl5NnQw?=
 =?utf-8?B?TnBveDJ0bGtqQWZlTXNDZHB2dDBIcGthaEwyOUcrQXptMU51d0N5VjhmNVRh?=
 =?utf-8?B?RXpWVFlGYjk0MldsZUZ0Qnd5U1o2c3ErMzhhcHI0YUwwRlY3U1Q4NTZ0dm0r?=
 =?utf-8?B?dGxvYlZKRmNZT3AwNTBXVU9qZllXaElPVHZOTnFpRlFsdU1wSWlpMEZMSjdD?=
 =?utf-8?B?bE1sdWZHL0ZiVDlFeFFuRjh1a2JobXhpNDVZaiszcjlDQ0VVeGk3Y3NORHZ3?=
 =?utf-8?B?S1BBQUtXOFIvVXIzL2hvMHE0Ylh0Q1F3QVBlMzY0TjQvaFVQRVY0Z3djQVFQ?=
 =?utf-8?B?MklhQkFWcHExaEx2NVM1bk1UZ0tPMzAvZlJHQTJwdGQrOXBIL0daMk5WWnNi?=
 =?utf-8?B?cjh4dTBYUGxLR3FnUTdHWWhKV2pmWk1lTFZUcmhmeWlTMlpnTEt0Y1RTNWw0?=
 =?utf-8?Q?exFVgYjrGuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eldGa1paMTBTU0JDUkZ5MXlmaDFVOEVkZnJFci9yT1BkLzhFbTRyb09hY1pU?=
 =?utf-8?B?SVpyNGtIbW4vQm01UFBDM2t1bUk3b2VEVjNxUy9BV0pIOFVwdzNjZ3NObnVh?=
 =?utf-8?B?VGIzM2I0QlFQQlh6Kzg5d2ZmbGNYTHBia0szWlZJVkg2NjAzbkI5STkvTDhG?=
 =?utf-8?B?dFJ2LzdSZ1Y2WDBIQzJ3QjkzRDREYktBZU9lV2VzeWorUHFmSDk0WjZ6dVZ0?=
 =?utf-8?B?ZnJnYWtDSUhtZ01XVnYyVGFxM1ZHT0orK1k3YTRvQ0VzTnMveDBXRTZBK0t2?=
 =?utf-8?B?VmgyVnJMSlhvbTZMOVRpNWpuOHZzSlMwS2lXaWVENWNTL3p0Y3pHbGptR0xw?=
 =?utf-8?B?YWd6R3VHaTNkNVdZdnd5V0hZNTJoUmhxQS9VNm5PdFh6VnZQQm8wbnRIZzEv?=
 =?utf-8?B?aUovaFJrTDEvSEU1SU1HbFVnbUJYamhtMkJwY1BXQjNRY0U0d2VHbnBteVBB?=
 =?utf-8?B?bFROWEpubDlIR2ZzY0UvTnZUcERmS2pQbVprTjU5VllmYmQ2M2tZUWsycUhN?=
 =?utf-8?B?SUUrMGRhOStMQ012VTR0aVcxNVZqNGdrZ0JkUTA2K0xVajVvUVZBbG5zL08z?=
 =?utf-8?B?TFlDUTQ2OEVHbXR5dWoxdEVneDRaUnVXenVGZzBSeEtRWldQMVFMb3ZkU1or?=
 =?utf-8?B?Q0M5K1J1UHJIcGd3TUFVajZVT0UraXgzNTlXb1ZtSnBCamJ2bGU2S3B1U0ZX?=
 =?utf-8?B?NXhoc25rWENKYXg4bUlXQUVlN0xTL1E1dkdQR3ZNaXJUdXYyU2FjWCtYMFF1?=
 =?utf-8?B?UURSRmtFamJUdnFGa1UvSlg0K21jaTE1UkZhOTR3Zmw0NURKNmNSb1V5b3dj?=
 =?utf-8?B?eWxGODRjWWhMdUZqa04zSWc2Vm4xaFQyWUw2U0dEU1hqbmtvV3pwbjdjNno5?=
 =?utf-8?B?bVB1dWFLOC9rMGVLSzI3bG94U2ZqR2xYRmRSV2piajFmNHB4N1FvRmxlR3Ux?=
 =?utf-8?B?NFkrVEhqMFZMTHNJYXpSUExqTlc4YkgyR01PUitjUUlDemVrVE80Q2pMbGsw?=
 =?utf-8?B?eDVjaE1pbUU2eXZ1S3dsUjB1UjJOaHQyeXJLY0ZzZ0wzSFE0OEJNQTB4R0x6?=
 =?utf-8?B?ZU1RYzhmMmVMbEQyZi95dlJKRHN6TFpxdEdQTmNhTUlENCtXNG1xWitqRGJW?=
 =?utf-8?B?Tjg4c042NjRJWlFXYzh1Q0RIeHJIQ2NJVzVSbDc2YWNwelpVQ2hJTDJOU2J6?=
 =?utf-8?B?Sk9Tc1NnQ3VuQTdOQUhxajJyZ2hZZFU0UjBldmhwaDdJQ1VlMkt3ek11VEVx?=
 =?utf-8?B?NzhmQnZIWjlTellpcW9TcXg0WW1JNTRqVGN0T2Q0Y2RaSkNTQ2xjaGJwR1Av?=
 =?utf-8?B?UkRONDk0VlRGRmZvMGtOdk1HaFJ6RGJkK1owZGJsR0QvbjRjRFUva2gzakJN?=
 =?utf-8?B?TllCKy9BbmZ2Z05RTDM4QVZYOXRLUCtYd1JibmNzVlhPNmwrcGgzSnpzb0c2?=
 =?utf-8?B?RkJaNEU2MjNrekVZOVBzNXRLYmlCWHduZUZlS3Q0MzNKa0JETHF0SnVEbTVN?=
 =?utf-8?B?RStLdE5HN3FuZWRDV2JrbFZ3T0VYajR2WlpqamlLZkZvV3UxSFFQWm1BcENr?=
 =?utf-8?B?VVBPbG1kT1hnZTcrRzR1OWhZbjRFYlhXZXljV0E5UlpGSGk1M0g4UXZoVXgv?=
 =?utf-8?B?RkdLbjJsL2pxeHc1Wis0T3lSbUNUaEJHRHViRmFBY01lK3lzR1YvajJvYll0?=
 =?utf-8?B?MWR4RnJWYXNqNDhKcmlGMkpBT283UE1Xbmt6ZFlBc00ydkJJTlVXUGFRaC95?=
 =?utf-8?B?RHNNd251d0pKT1pPMHJhNmNPdmErQm92cDc4RzArbmMvZkJTVHlWMDAvSWRF?=
 =?utf-8?B?dGwvN2tZRHFhVXY4VGdDNlU2T3hFVkJNa3Nmd2NLbU14OS9IMGt2ZXZFNXJB?=
 =?utf-8?B?RXJ6amhsV3QyNjhwTnpycVoxVE12ZUNYdWlrVU56UTNwKzFjYkxEQmVVcGlz?=
 =?utf-8?B?blU3c1ZSazJ5Vm16K0J5VDJPQ3NQa3YwQzlpbTE5UlRpL1VqV0hQWUxoYjBM?=
 =?utf-8?B?VXhHNXIraWdkdURtVmdYYmFMZjlpc3JqdmVtb1NiRThxa2tOUThGTzRzUTd6?=
 =?utf-8?B?c09NNnB0OWUyZVRLblBRcW5XMWE0NVNHbnFFRWtaL2RMeGZ5dnpPb2dvREtM?=
 =?utf-8?Q?7Z7M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993bca9b-3181-4c9a-e5fd-08ddd932114b
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 23:52:01.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8uShAWWHuEhdX9r672ns154bYN2b0mkLgcHNuWn+88/bihUw5fGgBg7ytTN8rx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270

Hi Reinette,

On 7/30/2025 3:10 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> Enable the mbm_l3_assignments resctrl file to be used to modify counter
>> assignments of CTRL_MON and MON groups when the "mbm_event" counter
>> assignment mode is enabled.
>>
>> The assignment modifications are done in the following format:
> (needs imperative)


Sure.


>
>> <Event>:<Domain id>=<Assignment state>
>>
>> Event: A valid MBM event in the
>>         /sys/fs/resctrl/info/L3_MON/event_configs directory.
>>
>> Domain ID: A valid domain ID. When writing, '*' applies the changes
>> 	   to all domains.
>>
>> Assignment states:
>>
>>      _ : Unassign a counter.
>>
>>      e : Assign a counter exclusively.
>>
>> Examples:
>>
>> $ cd /sys/fs/resctrl
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>    mbm_total_bytes:0=e;1=e
>>    mbm_local_bytes:0=e;1=e
>>
>> To unassign the counter associated with the mbm_total_bytes event on
>> domain 0:
>>
>> $ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>    mbm_total_bytes:0=_;1=e
>>    mbm_local_bytes:0=e;1=e
>>
>> To unassign the counter associated with the mbm_total_bytes event on
>> all the domains:
>>
>> $ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
>> $ cat /sys/fs/resctrl/mbm_L3_assignments
>>    mbm_total_bytes:0=_;1=_
>>    mbm_local_bytes:0=e;1=e
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> ...
>
>> ---
>>   Documentation/filesystems/resctrl.rst | 146 +++++++++++++++++++++++++-
>>   fs/resctrl/internal.h                 |   3 +
>>   fs/resctrl/monitor.c                  |  94 +++++++++++++++++
>>   fs/resctrl/rdtgroup.c                 |  48 ++++++++-
>>   4 files changed, 289 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 0b8ce942f112..0c8701103214 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -525,7 +525,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>>   	Event: A valid MBM event in the
>>   	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
>>   
>> -	Domain ID: A valid domain ID.
>> +	Domain ID: A valid domain ID. When writing, '*' applies the changes
>> +		   to all the domains.
>>   
>>   	Assignment states:
>>   
>> @@ -542,6 +543,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>>   	   mbm_total_bytes:0=e;1=e
>>   	   mbm_local_bytes:0=e;1=e
>>   
>> +	Assignments can be modified by writing to the interface.
>> +
>> +	Example:
>> +	To unassign the counter associated with the mbm_total_bytes event on domain 0:
> The alignment is off when looking at the generated html. What seems to be intended is that
> "Example" is some sort of heading but it ends up just being part of the sentence that follows
> and thus not apply to other examples that follow.
> It can also be "Examples" since there are more than one.


Checking it again.

>
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=_;1=e
>> +	   mbm_local_bytes:0=e;1=e
>> +
>> +	To unassign the counter associated with the mbm_total_bytes event on all the domains:
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=_;1=_
>> +	   mbm_local_bytes:0=e;1=e
>> +
>> +	To assign a counter associated with the mbm_total_bytes event on all domains in
>> +	exclusive mode:
>> +	::
>> +
>> +	 # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
>> +	   mbm_total_bytes:0=e;1=e
>> +	   mbm_local_bytes:0=e;1=e
>> +
>>   Resource allocation rules
>>   -------------------------
>>   
>> @@ -1577,6 +1606,121 @@ View the llc occupancy snapshot::
>>     # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>>     11234000
>>   
>> +
>> +Examples on working with mbm_assign_mode
>> +========================================
>> +
>> +a. Check if MBM counter assignment mode is supported.
>> +::
>> +
>> +  # mount -t resctrl resctrl /sys/fs/resctrl/
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  [mbm_event]
>> +  default
>> +
>> +The "mbm_event" mode is detected and enabled.
>> +
>> +b. Check how many assignable counters are supported.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
>> +  0=32;1=32
>> +
>> +c. Check how many assignable counters are available for assignment in each domain.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
>> +  0=30;1=30
>> +
>> +d. To list the default group's assign states.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=e;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +e.  To unassign the counter associated with the mbm_total_bytes event on domain 0.
>> +::
>> +
>> +  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=_;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +f. To unassign the counter associated with the mbm_total_bytes event on all domains.
>> +::
>> +
>> +  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignment
>> +  mbm_total_bytes:0=_;1=_
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +g. To assign a counter associated with the mbm_total_bytes event on all domains in
>> +exclusive mode.
>> +::
>> +
>> +  # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
>> +  # cat /sys/fs/resctrl/mbm_L3_assignments
>> +  mbm_total_bytes:0=e;1=e
>> +  mbm_local_bytes:0=e;1=e
>> +
>> +h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
>> +no change in reading the events with the assignment.  If the event is unassigned when
>> +reading, then the read will come back as "Unassigned".
> While this example is for a single resource group the supporting text goes back
> and forth between being specific to one resource group and describing what happens
> when there are multiple resource groups (see (j)). If it is just one resource group then above is
> fine, but for multiple there are much more involved with the "unassigned". Same as what
> was mentioned during previous version.

Removed the "Unassigned" related text.  Also removed texts about 
multiple groups.

We already have details on "Unassigned" in mon_data section.


>
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> +  779247936
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  765207488
>> +
>> +i. Check the event configurations.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> +  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
>> +  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>> +  local_reads,local_non_temporal_writes,local_reads_slow_memory
>> +
>> +j. Change the event configuration for mbm_local_bytes.
>> +::
>> +
>> +  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>> +  /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>> +
>> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>> +  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>> +
>> +This will update all (across all domains of all monitor groups) counter assignments
>> +associated with the mbm_local_bytes event.
>> +
>> +k. Now read the local event again. The first read may come back with "Unavailable"
>> +status. The subsequent read of mbm_local_bytes will display the current value.
>> +::
>> +
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  Unavailable
>> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>> +  314101
>> +
>> +l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
>> +done using the following command. Note that switching the mbm_assign_mode may reset all
>> +the MBM counters (and thus all MBM events) of all the resctrl groups.
>> +::
>> +
>> +  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +  mbm_event
>> +  [default]
>> +
>> +m. Unmount the resctrl filesystem.
>> +::
>> +
>> +  # umount /sys/fs/resctrl/
>> +
>>   Intel RDT Errata
>>   ================
>>   
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index e2e3fc0c5fab..1350fc273258 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -418,6 +418,9 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
>>   ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>>   			   loff_t off);
>>   
>> +int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				 char *event, char *tok);
>> +
>>   #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>   int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>>   
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index ebc049105949..1e4f8e3bedc6 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1311,3 +1311,97 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
>>   			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
>>   	}
>>   }
>> +
>> +/*
>> + * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
>> + * event name.
>> + */
>> +static struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
>> +{
>> +	struct mon_evt *mevt;
>> +
>> +	for_each_mon_event(mevt) {
>> +		if (mevt->rid == r->rid && mevt->enabled &&
>> +		    resctrl_is_mbm_event(mevt->evtid) &&
>> +		    !strcmp(mevt->name, name))
>> +			return mevt;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain *d,
>> +					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
>> +{
>> +	int ret = 0;
>> +
>> +	if (!assign || strlen(assign) != 1)
>> +		return -EINVAL;
>> +
>> +	switch (*assign) {
>> +	case 'e':
>> +		ret = rdtgroup_assign_cntr_event(d, rdtgrp, mevt);
>> +		break;
>> +	case '_':
>> +		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +int resctrl_parse_mbm_assignment(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				 char *event, char *tok)
>> +{
>> +	struct rdt_mon_domain *d;
>> +	unsigned long dom_id = 0;
>> +	char *dom_str, *id_str;
>> +	struct mon_evt *mevt;
>> +	int ret;
>> +
>> +	mevt = mbm_get_mon_event_by_name(r, event);
>> +	if (!mevt) {
>> +		rdt_last_cmd_printf("Invalid event %s\n", event);
>> +		return  -ENOENT;
> Extra space


Sure.

>
>> +	}
>> +
>> +next:
>> +	if (!tok || tok[0] == '\0')
>> +		return 0;
>> +
>> +	/* Start processing the strings for each domain */
>> +	dom_str = strim(strsep(&tok, ";"));
>> +
>> +	id_str = strsep(&dom_str, "=");
>> +
>> +	/* Check for domain id '*' which means all domains */
>> +	if (id_str && *id_str == '*') {
>> +		ret = rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
>> +		if (ret)
>> +			rdt_last_cmd_printf("Assign operation '%s:*=%s' failed\n",
>> +					    event, dom_str);
>> +		return ret;
>> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +		rdt_last_cmd_puts("Missing domain id\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Verify if the dom_id is valid */
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		if (d->hdr.id == dom_id) {
>> +			ret = rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
>> +			if (ret) {
>> +				rdt_last_cmd_printf("Assign operation '%s:%ld=%s' failed\n",
>> +						    event, dom_id, dom_str);
>> +				return ret;
>> +			}
>> +			goto next;
>> +		}
>> +	}
>> +
>> +	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +	return -EINVAL;
>> +}
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 47716e623a9c..2d2b91cd1f67 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1979,6 +1979,51 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
>>   	return ret;
>>   }
>>   
>> +static ssize_t mbm_L3_assignments_write(struct kernfs_open_file *of, char *buf,
> Please move to monitor.c


Sure.

Thanks

Babu


