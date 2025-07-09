Return-Path: <linux-kernel+bounces-722773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F744AFDEA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50063A4B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAF725F97E;
	Wed,  9 Jul 2025 04:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zL4S8zPN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41413D2B2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033687; cv=fail; b=JHN/zZ0GXgf4DKqDxJ/pqz9v9d1VRbWX0oG08IWFnSYV4n4BtvyW9D/Zz+JdgSlfP+7Vz3oNUSMvZ7Rb8qQOmnjjWNfYGAGucx6HEcHc78dxDln90j7yxwkBoWI1xGkrav/xNByfnNc8kvL7qUwP6jl8VnMegxwp54G0zZXlhjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033687; c=relaxed/simple;
	bh=my8V7OsDDRgXmACcTlr/CVanuDnikjMCL8YuwkZ4zsI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqYgICUQ6kQBQBYPHGlDiYBt2aDKLJLlz1UPER7xABWavfJ3z27NmzDNBL6mjcs85pOUAAg7Qx/LE6utJl/PedxKjnHbPEUMcLoKY+3Ymm3F6I/Oma6be7KOLbN+FUO/hJAzM4iva+gv5EhAzu90C419Y72PBhTxLnDaB9cvZos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zL4S8zPN; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERA50cN6GEYgMiBbYpuwIKZUnlfw1QdhbO4drqcd7rxuuVRkHvf24oFtZTQji1eKu7d5Ihcis8h2DknQBNuCUo/xe0aZTM10kEE+EJxy4BTx/2VOXUHV95fXBZ+CmikPVT6T9LexaoPXbU+zr/6gP+grEmfT/ip7zOW6fj4PCKIyTdanOxFKi80zZDNF6MteQ9dx5+7SfL9GGVnCXj/M8HPq1dYahtJrdoqOUW43XtnNZBrgTs2DdLKu5eVqQaDeWhiqS4WVZ+DJBq3d9zKjSxPfx9OpY6VlH97sGuTukVO9Dw9ActcLhwp4SsMWJqxhDtCSC+BKxWQ+EN78Zgd8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgxPh3MTlhUi8jJLgdnfsNxNS+7+QpRPi9do7M8yGuQ=;
 b=HmMp3dsR0nMEjpjQXp5hQ4f/ymBaC+a+5wNEQJ/RU3IRPdQEJKfc8NGXEwRlsr5AqCbBBUo9DlR3PEyY/Ju2/MYTjCPbYYDeYAm6l8KbwHPXBD6zbky8gJe8lRLvaES+SJ1Nrrv0sjUKZa9M1JwNTQkoYjVyySjYl5DKBs2eJlVs2uIfVGLj/WUw2KN2AXbXTd2hWVD/W+1G2jvoon8bYaJibh11/zzQLPNj0SPv8XfQtdP49y+nzXqRArGKK46fnvZa2UI7wReW7dC4xWCHtM4zE4sisxv/KWBv3eVPCP9U7jfza7gdWdU/HT8rxHhuxiLydHwnE8Nj/ciEmR4CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgxPh3MTlhUi8jJLgdnfsNxNS+7+QpRPi9do7M8yGuQ=;
 b=zL4S8zPNcfD47lEntvKGde4RTpxyyOr4OZVyK/ZifarFS3GNbnmufWpooFHuLsVV0+HRjQ1szB1/GKqy/Z8lNWQG4CM33fIbpAVMQ2dB6Ar+V1Qm+0fKdtipFgbUA3I0QbpdHP2SiIpNy4BlC3uPHZ7yMcs5XjlHJ13XvFOM4e0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Wed, 9 Jul
 2025 04:01:22 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 04:01:22 +0000
Message-ID: <fb527d60-f31b-4383-ab03-e17f0ba96a0c@amd.com>
Date: Wed, 9 Jul 2025 09:31:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Valentin Schneider <vschneid@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>
References: <20250707105302.11029-1-kprateek.nayak@amd.com>
 <xhsmhldoyq547.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <xhsmhldoyq547.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::6) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c294aff-634a-421a-3a5d-08ddbe9d4447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDlibVZQb2UwTCtJdU5ETm1WZ2Y4Q3MrdXpLaEdIN2J5T3VDMmZmaWtzYmcv?=
 =?utf-8?B?WVlJMFNkVmJjQk82Nkxyc2tTRFA1ZzhNcW1MRHcxN1JmN0t5bnV3TVExNVY4?=
 =?utf-8?B?M3B2NHZ3UmRxZklHa3h6KzJiVEZvUDJTa3lEK2JLVHpia3ZNKzVZVVgvL2ZZ?=
 =?utf-8?B?K1VnZXNmajQyZFJuOFgrMUVsbUc2R2NvUWxPZFUzcitHQmFuZG1PVmdOcnZI?=
 =?utf-8?B?bnYwemNrTW1GMVg0eC9oVnBudkZaVlFpWGxKSDNNb0ZOY0hMbitSMVRqQUFr?=
 =?utf-8?B?Z1lrM0xON3BiK2ZuR3RXM0FFTGU0SUlmZzRFMm14TnBVeldHU1dCVTl2NHEy?=
 =?utf-8?B?OGxiWGx3dnNHQ0FKUWdpeXRuSGIvaHhWYXJiKzJZM25MMlQ3RmJwbDgrc0t1?=
 =?utf-8?B?YklKWXNXa1JKUktlQ1dYaUJXTWtKU1VvNzlIL0t4TGdJaXo3ZnZvT1hWc2Ny?=
 =?utf-8?B?VjhuWEhRS21KQXA4SlJyMkZWSTFBNWpBa3FhVUFKSVZvekNPMU9zUFoyeDcy?=
 =?utf-8?B?djZXcWZ2ckgydjFlaFpnb2dlNHUzTjEzT01OWGwxTk9ubUxWSkFyWVV6dDhX?=
 =?utf-8?B?MHNmOVV4MDJjdFF5aVZhNXFuM0pWN2NybnpoZzJPaGE2OUtmSXljMXpTeWNt?=
 =?utf-8?B?d0srZkRKMFlaTGI2QVhTK2NTOHR0WFBCTGsrZUszejFlT08wbU1aQU1pQ2wz?=
 =?utf-8?B?bHppWnY0UERJSld6WmdEQmV3dlRQaVA2TW9KcUU3ZldZREtSQnZtdUpKWEQ1?=
 =?utf-8?B?SndSN3NCNVBDOEp1ellwUzluSjJUTjN1Q0NzWVg1em01V3l1eTBQN1dtNE1N?=
 =?utf-8?B?QzZiTVZFbXNESU1zVFFNRTlCekY0M0syNzBRdUErVEZnZmQvVmpENFM1cWpT?=
 =?utf-8?B?aXBUZm1ES1ovZWpjVEtqWCtDMUZmN3luS3F1RVcvYU13RmhpV0RGbElnWitl?=
 =?utf-8?B?VzVuTXdqcmVZSk5qSzV0V3hzdC9aVjA0eElKb2FNajR1SHFEOUc0dFVLbGtQ?=
 =?utf-8?B?NzIzNHVmeENxa1dVbDE3UlVtTjNjSXRvY0RZZUw5aG1xd3lMV01oUWZFYTNK?=
 =?utf-8?B?MTZ2Tlk3NE9qWk5lQktoOGttNjMybGhjRTJLeENNQldhc1FMWGg0a0gyYlha?=
 =?utf-8?B?cHA3bndyMnUvWHEraXlLclVvS3FodVVqU3VpK0JCRytPdDZJM1Z1YlpZMXIr?=
 =?utf-8?B?b2xneDJHYWdVdkluVVZuZlRBZ2gyNXU3Ynd2dU1FNXB0bjdPVlliMnA3OUkr?=
 =?utf-8?B?dzhjNmUwdU1Oc3liMElBMy80T2lRY3Z2eDdSS2hHSGM2SEVRYnpmeU1CRGhy?=
 =?utf-8?B?NHRTZzdDcmgxN1ErbWRQMUJqUmhwdWNBL1R3QUZyb1gxa2tLOUlkTXdWYXQr?=
 =?utf-8?B?ZmZtR3I0Q2hMZXlQeW94UjhEb1ZtcTZ6WmFXeFUrMmpvZk1GLzcrbG5zSXp2?=
 =?utf-8?B?VmhOTzVrVFV2RC90cFExdGJkcXh3aHlZZk45RitLNHJwUkRzTzhVZmpVZWNk?=
 =?utf-8?B?dE9QNkRPL1p1cjBVb0JqWXhqMC8yOU8vbElDekF5c05lNVFGN1lMYnRuSC9O?=
 =?utf-8?B?RjN3MXEydzFjdjNicGFvbXptNmlWd1AwMUY2QnJtY05KNUlqVnY2eUFWcy9j?=
 =?utf-8?B?QnI2RnJIYUhTNTVTWWlyZVV5eWptSnoyRTUzOU4xU2d4MytJS3ViaUVXc3lB?=
 =?utf-8?B?cll0U0FMV0o5TUx2cW0zc2FrZ3ZaTlU2L1dyOU5zREthY2dZM01nSlQwR1U3?=
 =?utf-8?B?RDRmQ1ZXMUMzbkVONTBvN3VhTXd4ODVrb3VQcHQ3T0hvbHJvaUZzamhzY2lG?=
 =?utf-8?B?d0I2ZW5IR1BaejB1MzZ4K0RYaEpaOUlJRFBSRHp5azE0NjBNd0JsTVhqeGlM?=
 =?utf-8?B?Zms1amNRZXc2Z0hWeUwwNXFkTGxnVFJGRXhwNDhHRUs0THEwVGFTYnV0Y1hu?=
 =?utf-8?Q?EQAMBW70K0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhFb1dVMjB6c1lWbGIrZjlQZ3ArcUVzcndMZVJWZmFJMGxKbkJkbmhEeE44?=
 =?utf-8?B?WjkwQm5JcUZvdkVlMVhtTHJsRFJzN200MnJHRUczMTBTOWhpcjhTajdiYXVV?=
 =?utf-8?B?L0tRajg0bzM1WTdzN05QUkxFLzFBZ256eXA1Q3Q0UFdkdlZQdGhWSkpzM1Iv?=
 =?utf-8?B?Y3h1R015Y2xzcmNJd2VEL0Z1c3pja1RhdVlQcmdSZWJqUWkxeW82S255Tldi?=
 =?utf-8?B?dEhQSDN3d2NOSURJVGhNZ3JYS1BXV1BKUWNHQVNVcTFBd3Nsam43U1EvYjl5?=
 =?utf-8?B?QlVVV1Vma0RwNVRZbG04dUczekNiMGVhYWxFYWFIOXg1UDZvMlMwR0svZFhB?=
 =?utf-8?B?ZzlUWFQ0b01KWTZJK2pNQm1IMnhFWFJvNGJKVjVKRDJaeXRSdGtOQmFRZGhZ?=
 =?utf-8?B?eVdDVXlUeGUra1VCaGNnV2hhTWhDR1NyNXpPblF2bWRYM3JqckRRNFViZncz?=
 =?utf-8?B?cUdsMitCUG4vcG1STVh1NDJheUt3eTNWdEhLalk3V1VPUHEwVktHYzFKbzlq?=
 =?utf-8?B?VGlIWnNPN2M5cVpXbTJKeFp3SmozMCt3TllsTzZnV3M4QTRiU3FhbzNlVHZv?=
 =?utf-8?B?T0x5MFJxeWEwK3NISEk2L2tiVmZKNWxWYUxVSm1vM3VBanQ4bHpXVEl4SFNF?=
 =?utf-8?B?SVRVWUJmazJVNHRDTHNOZjA0WlgzV0I3MWxTK3ZLRzdaY05mWGxsUW02NFph?=
 =?utf-8?B?WFJpNU5lUkE5T2pmM2tRTUkwRjY5ZUc5bVJMaWkxZGFMek1mckcxVDhDMkw0?=
 =?utf-8?B?bzRwMzFSWjZxSFlNeUo3VTJMUjJKajN5T3ZudzFuOWhObFZlYUVVcnUxeEN5?=
 =?utf-8?B?N0IvSlU1ZEFmelBTRCtuV3JHeFRGSGJiMlNrSUJzTVlLeDVnRUs0Z2VMZjVV?=
 =?utf-8?B?OCtRdDhhZUdlZmJLOU1MZU9UQnVaWTlxd3dNcmNncURSdTY3Z3Z0cWd1dDRo?=
 =?utf-8?B?S1VhditkOWFsR3hFQ2FhVUttNnF1TWZEcEh6SVM4a0Z4TmE2M1BqbUZBTGVY?=
 =?utf-8?B?ajBpeGR2dXVNbGpKcTVsbWYrejJmN3NaYnhlcGRScW9XSXgya2Fad3lzbmtE?=
 =?utf-8?B?OGNwdXVqUHNtU1crTHFxQ3F0UVQvWU13TG8vRFNMS1Vic1NJeUo4cjVvM0h1?=
 =?utf-8?B?Q0E1NHZnTURFQkIyNXNKZFZUNW1tQjlvMU03bWlORzRYbVBWVmdrL2swZ1ky?=
 =?utf-8?B?SDh5NWpyaDVBM3FhaTdWeTh3Tmx0R2ZvNk42cml4VkU4Nk1rRzFQelYzQXhl?=
 =?utf-8?B?VUxKaTdTd1laYmUrN1Y3YURuUm55UUpPRlhoNkxmT1N2Y2VlSURKN3kvRmRI?=
 =?utf-8?B?cUJiVGV6TW1mbVR4ZVlxUlRFS2F2MWFKelZaMXZzTUV5aDV6blRvZkhKTU9l?=
 =?utf-8?B?bjA2T3ZDaG9LMzc4MTFFY3hwUHhxVW9pUW5hT1RxMDJtaUdWLzcxMm9BTDg5?=
 =?utf-8?B?RkVhTUk1L1dGQ3ZEN0hldExSVkQwak9NRDhqYzJJL0lmZmhHMGk3bCtNS3ZD?=
 =?utf-8?B?bnpHM3E1aHVrbTlHaXp5c3BOU1NTZzFnb1FRL1F6MzF0RVNrU1NURDUwR1dU?=
 =?utf-8?B?eW5kQTIvN1VEem5ONzUvYzZQa25PMUplb0w5eG9CRWJWUk1QeVk1M2w4VzAw?=
 =?utf-8?B?RmZGRk9VRjBickcxUDc1T040T25kQ0NKMkZTVTZ4MFJiMkFSOWU4T09KWmFZ?=
 =?utf-8?B?eWRONlRKUWEvcEY3LzloaklPV2pybzVweGpHdFNwbWkzSEJ4TUlwUkVhRkVD?=
 =?utf-8?B?dW9sdTZsT0VPWGljQTlVMU9zRklYRUxueWlaL1BHTHd5K3QrcElCbTNiWE45?=
 =?utf-8?B?V29VSFNRWXh4UEdtdFY1UHE0RW5BcW1SeVdPWHBIeWZWenJyd2JuK0x4WXdR?=
 =?utf-8?B?ZGpUYWgzU2dtRkhsa0NLdXFnc3huZXhNMkdDTXpESGI1YUF2TEF4RlNNNnVq?=
 =?utf-8?B?R1BvOTVWcjBCL0krRmZYQldhYmpNZWFxdW40VUZtSDM5WEwvUUFVZ2VDZHBa?=
 =?utf-8?B?b2RHUEdrUFRLR1BMa2NjR2FqWnlWYURScmY1d2phV0p6WnhzdW51RUhySkl1?=
 =?utf-8?B?WW1pcjRVVllsSEJrTDkzN3luNGxITVdRcTYyYkVWaFZrMkhObEtHVHI0WkJX?=
 =?utf-8?Q?mWaZjPSYvd54TvfayKc6ele3g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c294aff-634a-421a-3a5d-08ddbe9d4447
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 04:01:22.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDYIeSGWGCBf2ToEJYS8FPQR7Zwm2XcsRXjB1JUtvi/uIH6oFKw11eQRDJYw2g78fV8t7XjSIBz8T5cz8PFnhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Hello Valentin,

Thank you for taking a look!

On 7/8/2025 5:14 PM, Valentin Schneider wrote:
>> @@ -2418,22 +2419,34 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>>                * breaks the linking done for an earlier span.
>>                */
>>               for_each_cpu(cpu, cpu_map) {
>> -			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
>> +			struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
>> +			struct cpumask *sd_span = sched_domain_span(sd);
>>                       int id;
>>
>> +			/*
>> +			 * If a child level for a CPU has already covered
>> +			 * the entire cpumap, build_sched_domain() for the
>> +			 * domains above is skipped. Use sd->private to detect
>> +			 * levels that have not been initialized in the CPU's
>> +			 * hierarchy and skip them.
>> +			 */
>> +			if (!sd->private)
>> +				continue;
>> +
> 
> So this works, but how about using a cpumask_empty(sd_span) check instead?
> It's IMO a bit more future proof than relying on how sd->private is used.

How about the following instead of cpumask_empty() to avoid two cpumask
operation in the common case where sd is initialized:

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e682bf991ce6..e889ae012c17 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2423,19 +2423,13 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 			struct cpumask *sd_span = sched_domain_span(sd);
 			int id;
 
-			/*
-			 * If a child level for a CPU has already covered
-			 * the entire cpumap, build_sched_domain() for the
-			 * domains above is skipped. Use sd->private to detect
-			 * levels that have not been initialized in the CPU's
-			 * hierarchy and skip them.
-			 */
-			if (!sd->private)
-				continue;
-
 			/* lowest bit set in this mask is used as a unique id */
 			id = cpumask_first(sd_span);
 
+			/* Skip if span is empty */
+			if (id >= nr_cpu_ids)
+				continue;
+
 			if (cpumask_test_cpu(id, id_seen)) {
 				/* First CPU has already been seen, ensure identical sd spans */
 				sd = *per_cpu_ptr(sdd->sd, id);
---

-- 
Thanks and Regards,
Prateek


