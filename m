Return-Path: <linux-kernel+bounces-853777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38062BDC952
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2181A4E7437
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300A2FE596;
	Wed, 15 Oct 2025 05:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N71hsDRK"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9052BDC33;
	Wed, 15 Oct 2025 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505200; cv=fail; b=RMWDz3efrbSp1lh4s/1Cdug50BxbPsCnXM74Y9TC8FTTdQ49tik2nBmDgCWrRJMTu/hbFJkR6hXJjXvPAZGKkMGkWqGREMF0gUNu2WwNz2VwF9ZcL/+F/id1/h2QzYWRE9QQoLZ+Bw1RyaVbVZ8voDiH+ies+OiprFGuDZJhFIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505200; c=relaxed/simple;
	bh=Jbc16j5wB95CaRmezWk5BIKt6CvMCFyQ9d4M/U+F5s8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eUUPKoWpnh2BJoQdkbEV54Uj9hGCeL9+4gvIRmc3J8bFz/l+iL70Kj0w/5MkVZLRf9Xo2le6yHGnPTbvzRrORGsFHepGUeMner8QwoFfF9+qnxWP+dT8y3lTSXG/YuuCEdHKndhvkvycWlYbqAsrsK5fJUwFWv9hRMlP1tMbXh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N71hsDRK; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+mFzyyaWaK25BqtGXhSUfaCZ7xnNHa7tbZaFE5XNZJmUkl5VuSbGBJ5Qi3gzJIWrnCw/IxF3P18HUa1/xFFVezyCZcAN/QTi1YrvYv/6yonTukeV5s7PkHKNDP2hxUGRL6ExibzvjttsowhtBQ8R8CTpfn/nEtParHE+x5El6QO7d2KA74jqMnrt3qZJn/xFmWGPKfFJdb6aOu7predPILPndqiavIs8pRcXYz18oBUhi5YHiAuQnq3PjyVneBBV0NRP9We3NPKNt5RmuNLrLkY035F6e7+rlUy1rsogkFuauEh8C/DRyLquI8YV6q9M4OnHJzLagU3gqk2C1EgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9DW0S2AuOK8Li7KuoYbLO/Tkudbvb81phKBxBgSl6w=;
 b=x3S3o+eYKXzLwGusIVa5PlqcldrP1T3RBpCie9oU9xMgC0ivxJtJ7TK2ScGWWw5s2HEYulaUpVvCCLqG1XopCMj5J9KNNU96XRq4p6mi3onvkcuY9mM5qjMHhQqkURifVoV3TDT3T0VGzpPeBhsxmrOcTUc9nnT7CdklaGPNx1e0S4JMGY2hypx3ycdMcUjeIyRkfJQ6koo9Pfr10+0HJUF1p6IJumcVEzfWKSpoDTG6NbTD3jq3akA3of0duEA0sO2zkaddP2VaHzNq1yVubf99wQ8Elp260DCm/rYfN0dczfyn1PCXV/cjMLDHPiRsMs5xloeSRSTvsP8cfiLWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9DW0S2AuOK8Li7KuoYbLO/Tkudbvb81phKBxBgSl6w=;
 b=N71hsDRKdJYlRzy2rI/lQt1VDWUtJKiWoY+AxL+mlPpLVQU9tqAPPmuEttdFhdVVJ6dTtasZaAUx9UoJfAdcnvqF1Nbp+RL//kr8UkOuMe/qDJcV0G5XjPiKDWK4deDhDNTHyIWlqdhXEtnriblhAhQRO6rVEEFUX9zmPgdfEm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:13:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 05:13:15 +0000
Message-ID: <0752fcde-6c25-4cde-b35f-2204e24ff0f1@amd.com>
Date: Wed, 15 Oct 2025 00:13:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/9] platform/x86: Add asus-armoury driver
To: Denis Benato <benato.denis96@gmail.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251015014736.1402045-1-benato.denis96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:5:280::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2c95b2-d94e-4d47-ae75-08de0ba98b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZENCNlNlSlc4dENaVmhVTE9EY0RpK3h2eVRvVXh1a0JETkJDeGNoNG42czdK?=
 =?utf-8?B?c2dkallzUTZweHFibkZFcXoxNUxndFZHWGI5bUYxTkpYWXl4eXZjNnkwOHRW?=
 =?utf-8?B?VXIvd3V0WlF4cFBZZG9lalcxcFIvRnRPQ0RDRGszQzdONTRoMWUxOFFiRGgx?=
 =?utf-8?B?R3dKSU1KZXZpYUQ1ODVqTlAyamFOcXhGS09XZ2pGR2YyNDR5Q0pZWGNkUENV?=
 =?utf-8?B?M2Izd09iNzRTUXF1bHZrV2xPekVvbkhhQTZKRUNpSTdmTnpqb2lDTHV0V21h?=
 =?utf-8?B?VDNJUDR0QWdvK3l1emNDSUdBT0xqWFMzZWc4aTU5bm9tekk3R203VERzQmZ0?=
 =?utf-8?B?Ui9lQktOUU91RU1tUHJBZWR2QmtzZ2Rkd1dMVXYxdlRpb3NCc2VPNmF1WHky?=
 =?utf-8?B?MmdDQk5wZjc3ZTl0Z3hUVkNDUVV1ejZta2JqUnhGUU5JM1NHaEoydUpPQ0k0?=
 =?utf-8?B?Z3BReXErWnA4UkI5KzVSeGRqNFZtQ29jOGIrbjN5WHJzWmxFTHhQMEJ6NkZp?=
 =?utf-8?B?NTRXRU9qZ0k5S0xDZFpSVi9aN1V6UXY1MlFMemNDZDVwdmt0ZXlPdE1lWmtr?=
 =?utf-8?B?ZURqbGRGU1JsYzE2OFh5KzE2NWNwd2JtSW5pQXdKVWtuQmdtckhOcERqV01y?=
 =?utf-8?B?eXZxV3VmeE83aG43WDRDSjdIaFl5REYyZk0zbmlpOGtock11Z2FSbGhLNzVP?=
 =?utf-8?B?NDNMMmdTeE0xc1dJU1dkbzR0UUxtRGs5UHV6NG9HUDZoRTZ2cHVzampMbVhu?=
 =?utf-8?B?UFJwdzJjeXpUcjA2K05CckJ2NDhud2ROVmVKV2pucUQyeWE2V3htU3lNQzRH?=
 =?utf-8?B?WHRIWEw1ZHh2ZVBwN0xQZEM2UkxwWjJUVVpqSi9rWDAxNDVLYlA0aWtoREdZ?=
 =?utf-8?B?R0lYcExtK3ZTNjZ1b1loejhMSnZsdkloZThvb2hTbGlUSGRZZ3FtUTE1T25Y?=
 =?utf-8?B?S0RXQXYzWEpmR3krVE1YZytIOHczd1drNlpLVzBKb1VsNStxSzJDVThVSkUv?=
 =?utf-8?B?Vy94c3NnQlU4L2U5VnJMMnI0cmQrODhnaVpGelovT1NrZWJlWkc0NWNzRVBG?=
 =?utf-8?B?NEVTK01PYUZ4aWt3enRaTThEcXU5cFZYUFZvYmRxRGkxV0F4dWY0ejZtUHNI?=
 =?utf-8?B?cWpUamdtcmdDTEJzSXl0VytxenVnOEt0QmRMU2tEOHZ4VVR0M1RVMW1VL25K?=
 =?utf-8?B?YW5wLytCVHc0enE0bnZlaVVDTmdzTlJuVVNyS05IN0ZRSVptUFBra3ZIMzNL?=
 =?utf-8?B?M1g0eG9OK2srTU1nVktPaVEwOWxZeWc1VVlTY1VYRGQ5U1d0ZzgrYjU2ODRh?=
 =?utf-8?B?NzRQckdrWEhjWDhiNTlOY1lOV1N2K1JPb2lPU1hLVkxwOVJjaGZiSzIyTG1T?=
 =?utf-8?B?Q0lTeVRKZVlTSnBReEYyWjh4N2ZkcGlqK0lDZFRmMzJ3Mlh6d1htUU8rc2po?=
 =?utf-8?B?TExvdVBBMXB2UXVWdDEzdWZTVitQVVBYcys1ZXN6Y3V6UFZDbnpISmJhbGpK?=
 =?utf-8?B?NW5GSnYzQ0xEZE5oMENibVRqbk1ET2RzSitFb3A1OEoxYzNPYW92ZHZJbEJa?=
 =?utf-8?B?SEwxWmh2a0o1NCtkY3FvM2ZzN3N2ZENHVTRFVldxNEVwNjZCWFFycGlEUEIr?=
 =?utf-8?B?TFArbXlFNjNDNk5rSzlKNDVtY1J5VVc1L0ZOOUU3SmtvQzJtS1JwV0RxM1pM?=
 =?utf-8?B?Wm1oN1JLSkJEVXN5ank4djBnQSsxUGlNNFRPbXpDTEpRZUFQWEtLZHZyY0Vr?=
 =?utf-8?B?R3dqb00rWGpNekplUldiQitxdUx0Rm9UbDVuTVNKT253WHZVUlRRY2xwUHMz?=
 =?utf-8?B?U0hYR0xBRTJaOGV6RlNsbzdvaUJER0dzU1M0V2NHcUxCSExYeUd3SFcwRDl3?=
 =?utf-8?B?cDZIWUlUcGtUSWZSUWJXNUNqL0t5NExOS3FLSWk5MWlRWWRUalA2RkhhRUMx?=
 =?utf-8?Q?2TK8jhwvwu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anR4M0hkdVhiaHQzQjMvL25zeU5naUI4QjF3dTRzcVBuY3NsZVpnQkxiWlBQ?=
 =?utf-8?B?Qk1vRnExMFB0N1ZRay8yNThMMXFJekViSG5UV1diaWZHTUZLeGFkVVlobHND?=
 =?utf-8?B?M3poeWdsdWxOc3RieElRbU1PckRiNjRVSTgwNkdzbGw3NkNvRFRFVzVSSkRZ?=
 =?utf-8?B?UkYxeWhaTWxwbFJyTFVMeEkrdmx6VDdXSHdRcThzN3ZCRmNtK0FXbEFSWW1W?=
 =?utf-8?B?UEJOclA5Rm9hd3ZnNGZxQ1VBalRXY3lNTm9iSTZ1THNGWS83M1k0NHoreGR2?=
 =?utf-8?B?MzlVbExhWUxRMmxkWGx4RTFVUW5jbHlwR3BHMjRCOE8zbnV0Z205YTZobitS?=
 =?utf-8?B?aUZSU0YvTml1NGtQSlU1dHZLdFh2elVCY2ZDUk10SVFyNDd4bmNSbFdxaTVY?=
 =?utf-8?B?dWx6M0M5SjZsZjJoUkt0ZHUwQjVGaUozR0s3enh6UTBudVNwdDRVVjJxUVEx?=
 =?utf-8?B?clBic1RoMGlRbVdqQTcvSm9sejlIaHZHdWx3RktrdXpBam0vSTlrWkZ5eGtM?=
 =?utf-8?B?VStqRWo4NkJxQUlvQSsyT0hSYW00RjJ2d2txZnRFdkgyTlJIZm5rcU1EMVdu?=
 =?utf-8?B?TWpFZ3dOM2U0Y2pkanM0RHk5K0xxTm45aHNodXZHQWpCcWVMOGlEaTVaYjhZ?=
 =?utf-8?B?MDlTVmNyalhzVTB1Y3oreUYrZUZRNy84RSt0b3RGNkgwc0M3amJqR2VRb21n?=
 =?utf-8?B?dDMyeU5vWG5uTjZaUVRPQktjNzlkM2VTa082YzNOdW9PeXZDbktpbkd4OW9H?=
 =?utf-8?B?ckEwUTRaYnFTcWtPbFBhc2EwQzhKVm0rM1RIL3BWWHZqSkFacURzTHZaT09K?=
 =?utf-8?B?Z2I2NmxiS2FHZWdOZGY4L2hzbVRzRGFyRDBRVFlqOE55V1lqR3BxdktVWTNk?=
 =?utf-8?B?T3ZXbTBNVWI2dklWMjZFVEx3UmFJckRjclFFOG96cUJZOWZmL05OL00yTE9w?=
 =?utf-8?B?cHZhZHI4Y2VJODhqTHdUUGZpNW56TEsrNU5zdkc0WDdubkhJL3cwNWs4b3NL?=
 =?utf-8?B?K1hONXBsVlliZThWaHVnOEZYUzNHcXg4TmI5L0tCbVVJUjJSSVQzcUYxWlNq?=
 =?utf-8?B?RUkrREJwVkdUcSsrVFBQNGwzalZJLzZSYjlZbjVHZU83NXJjQjA5WGM0YUhH?=
 =?utf-8?B?dzYvWmxha25LMnlvMndDaUhaNTdLa0hKNGlLYVdUS3h0emJMS2VZK0VsUG1Z?=
 =?utf-8?B?MDVzbC9iR013K29WSzBpUDdqK0xGS3Zta2lZN1dmRlY0ZSs5UGNWNzZzYW5a?=
 =?utf-8?B?NUZRc0hxOFZRalpvMUZGY3RYL3RvMXJoM3c1Mkd3Z1pDUzJuMk1RVmoraUN3?=
 =?utf-8?B?MU1WTzBoR3pvQytLM2swWXM3K3dPZWc2U2FxdGdFcWRsaG5QTlNCN0V0UnhB?=
 =?utf-8?B?ZldpS2svZjFMNm55T3lrSFJYNzZqK0hUcDNrRDVZNkVuZnF0R3RHdnp6NC9a?=
 =?utf-8?B?cVhET011dlU5M2QzeFFDNEZYcU95L1hQQmZhY0R4S21LZ1cvTDdaU0R1bzBI?=
 =?utf-8?B?aE9DVVpXOW84VGdjZlVlV0RJYkxVT3NYN3JPR0ZtTlltRk9MMUtiVG5VOWk3?=
 =?utf-8?B?VklGTmtRcUJ0a2NIQmRsa2wyNTlPblN5dUhDUG9nTmdNUlUvZEJTaTd3Wm56?=
 =?utf-8?B?elhaNlBtbGFXOGtNbCtmdnF5YklsOVpsQjY5d1V0Si92OXBXRllickV0M3NJ?=
 =?utf-8?B?d00xVmFQQjkrNnZRY05CZk5oUWhMVmVmdWhpRDBIWkFnbThVOFd4NmlzK2ZC?=
 =?utf-8?B?U0htNCswazVrclViMk5kSU8xeDZzVzRwUno3Q2Q3M05DNVczVHlNS2hmWEhl?=
 =?utf-8?B?blVwenlYV2R3b2s2M3R5dERNYmN5WW0vRnFtaTVNQzNpVHdrYU5Da1BxSy9M?=
 =?utf-8?B?T3M4OFpTVithbmo3blhBRDlmQVRzczNqZG10WjB4bXRUZTI1Nit2NzZ1RVla?=
 =?utf-8?B?MjZuWFZINU41R2ZjWWg3WlVrZmdrOHNuN3ZEMVNEdlBmUU1ReS8xTkprakRX?=
 =?utf-8?B?eXZtdXc5bHBLM29pVHZmK0xqTmt2THMveXRBcUFiWm5wbWtpWmZaZnRzalF1?=
 =?utf-8?B?aCtsdnJ0cVQxYkc3MEc5YkZxdVp1em9aUXRhSVRjT0pINURKQ2RWa3lyazYr?=
 =?utf-8?Q?l0tmr62FmQ7fDfVYkd8GvcWvG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2c95b2-d94e-4d47-ae75-08de0ba98b9e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:13:15.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7DaOMkFOE+6KvZuzkSnvDwRaVjruh4jHA2nZNYZhPoyxOVRatszFdj3OF+ltQxBGNHxXPWL3zXMHjvOTXGLFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8074



On 10/14/2025 8:47 PM, Denis Benato wrote:
> Hi all,
> 
> the TL;DR:
> 1. Introduce new module to contain bios attributes, using fw_attributes_class
> 2. Deprecate all possible attributes from asus-wmi that were added ad-hoc
> 3. Remove those in the next LTS cycle
> 
> The idea for this originates from a conversation with Mario Limonciello
> https://lore.kernel.org/platform-driver-x86/371d4109-a3bb-4c3b-802f-4ec27a945c99@amd.com/
> 
> It is without a doubt much cleaner to use, easier to discover, and the
> API is well defined as opposed to the random clutter of attributes I had
> been placing in the platform sysfs. Given that Derek is also working on a
> similar approach to Lenovo in part based on my initial work I'd like to think
> that the overall approach is good and may become standardised for these types
> of things.
> 
> Regarding PPT: it is intended to add support for "custom" platform profile
> soon. If it's a blocker for this patch series being accepted I will drop the
> platform-x86-asus-armoury-add-ppt_-and-nv_-tuning.patch and get that done
> separately to avoid holding the bulk of the series up. Ideally I would like
> to get the safe limits in so users don't fully lose functionality or continue
> to be exposed to potential instability from setting too low, or be mislead
> in to thinking they can set limits higher than actual limit.
> 
> The bulk of the PPT patch is data, the actual functional part is relatively
> small and similar to the last version.
> 
> Unfortunately I've been rather busy over the months and may not cover
> everything in the v7 changelog but I've tried to be as comprehensive as I can.
> 
> Regards,
> Luke

As a general comment that applies to a few patches in the series.

The S-o-b means that YOU sign off on them, it's like a chain of custody.

Any patches that you're sending need your own S-o-B, even if they're 
100% the same as the original from Luke.
> 
> Changelog:
> - v1
>    - Initial submission
> - v2
>    - Too many changes to list, but all concerns raised in previous submission addressed.
>    - History: https://lore.kernel.org/platform-driver-x86/20240716051612.64842-1-luke@ljones.dev/
> - v3
>    - All concerns addressed.
>    - History: https://lore.kernel.org/platform-driver-x86/20240806020747.365042-1-luke@ljones.dev/
> - v4
>    - Use EXPORT_SYMBOL_NS_GPL() for the symbols required in this patch series
>    - Add patch for hid-asus due to the use of EXPORT_SYMBOL_NS_GPL()
>    - Split the PPT knobs out to a separate patch
>    - Split the hd_panel setting out to a new patch
>    - Clarify some of APU MEM configuration and convert int to hex
>    - Rename deprecated Kconfig option to ASUS_WMI_DEPRECATED_ATTRS
>    - Fixup cyclic dependency in Kconfig
> - v5
>    - deprecate patch: cleanup ``#if`, ``#endif` statements, edit kconfig detail, edit commit msg
>    - cleanup ppt* tuning patch
>    - proper error handling in module init, plus pr_err()
>    - ppt tunables have a notice if there is no match to get defaults
>    - better error handling in cpu core handling
>      - don't continue if failure
>    - use the mutex to gate WMI writes
> - V6
>    - correctly cleanup/unwind if module init fails
> - V7
>    - Remove review tags where the code changed significantly
>    - Add auto_screen_brightness WMI attribute support
>    - Move PPT patch to end
>    - Add support min/max PPT values for 36 laptops (and two handhelds)
>    - reword commit for "asus-wmi: export symbols used for read/write WMI"
>    - asus-armoury: move existing tunings to asus-armoury
>      - Correction to license header
>      - Remove the (initial) mutex use (added for core count only in that patch)
>      - Clarify some doc comments (attr_int_store)
>      - Cleanup pr_warn in dgpu/egpu/mux functions
>      - Restructure logic in asus_fw_attr_add()
>      - Check gpu_mux_dev_id and mini_led_dev_id before remove attrs
>    - asus-armoury: add core count control:
>      - add mutex to prevent possible concurrent write to the core
>        count WMI due to separated bit/little attributes
>    - asus-armoury: add ppt_* and nv_* tuning knobs:
>      - Move to end of series
>      - Refactor to use a table of allowed min/max values to
>        ensure safe settings
>      - General code cleanup
>    - Ensure checkpatch.pl returns clean for all
> - V8
>    - asus-armoury: move existing tunings to asus-armoury module
>      - Further cleanup: https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m72e203f64a5a28c9c21672406b2e9f554a8a8e38
>    - asus-armoury: add ppt_* and nv_* tuning knobs
>      - Address concerns in https://lore.kernel.org/platform-driver-x86/20250316230724.100165-2-luke@ljones.dev/T/#m77971b5c1e7f018954c16354e623fc06522c5e41
>      - Refactor struct asus_armoury_priv to record both AC and DC settings
>      - Tidy macros and functions affected by the above to be clearer as a result
>      - Move repeated strings such as "ppt_pl1_spl" to #defines
>      - Split should_create_tunable_attr() in to two functions to better clarify:
>        - is_power_tunable_attr()
>        - has_valid_limit()
>      - Restructure init_rog_tunables() to initialise AC and DC in a
>        way that makes more sense.
>      - Ensure that if DC setting table is not available then attributes
>        return -ENODEV only if on DC mode.
> - V9
>    - asus-armoury: move existing tunings to asus-armoury module
>      - return -EBUSY when eGPU/dGPU cannot be deactivated
>    - asus-armoury: add apu-mem control support
>      - discard the WMI presence bit fixing the functionality
>    - asus-armoury: add core count control
>      - replace mutex lock/unlock with guard
>      - move core count alloc for initialization in init_max_cpu_cores()
> - v10
>    - platform/x86: asus-wmi: export symbols used for read/write WMI
>      - fix error with redefinition of asus_wmi_set_devstate
>    - asus-armoury: move existing tunings to asus-armoury module
>      - hwmon or other -> hwmon or others
>      - fix wrong function name in documentation (attr_uint_store)
>      - use kstrtouint where appropriate
>      - (*) fix unreachable code warning: the fix turned out to be partial
>      - improve return values in case of error in egpu_enable_current_value_store
>    - asus-armoury: asus-armoury: add screen auto-brightness toggle
>      - actually register screen_auto_brightness attribute
> - v11
>    - cover-letter:
>      - reorganize the changelog of v10
>    - asus-armoury: move existing tunings to asus-armoury module
>      - move the DMIs list in its own include, fixing (*) for good
>    - asus-armoury: add ppt_* and nv_* tuning knobs
>      - fix warning about redefinition of ppt_pl2_sppt_def for GV601R
> - v12
>    - asus-armoury: add ppt_* and nv_* tuning knobs
>      - add min/max values for FA608WI and FX507VI
> - v13
>    - asus-armoury: add ppt_* and nv_* tuning knobs
>      - fix a typo in a comment about _def attributes
>      - add min/max values for GU605CW and G713PV
>    - asus-armoury: add apu-mem control support
>      - fix a possible out-of-bounds read in apu_mem_current_value_store
> - v14
>    - platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
>      - added patch to rename the symbol for consistency
>    - platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
>      - remove the unchecked usage of dmi_get_system_info while
>        also increasing consistency with other messages
> 
> Denis Benato (1):
>    platform/x86: asus-wmi: rename ASUS_WMI_DEVID_PPT_FPPT
> 
> Luke D. Jones (8):
>    platform/x86: asus-wmi: export symbols used for read/write WMI
>    platform/x86: asus-armoury: move existing tunings to asus-armoury
>      module
>    platform/x86: asus-armoury: add panel_hd_mode attribute
>    platform/x86: asus-armoury: add apu-mem control support
>    platform/x86: asus-armoury: add core count control
>    platform/x86: asus-armoury: add screen auto-brightness toggle
>    platform/x86: asus-wmi: deprecate bios features
>    platform/x86: asus-armoury: add ppt_* and nv_* tuning knobs
> 
>   .../ABI/testing/sysfs-platform-asus-wmi       |   17 +
>   drivers/hid/hid-asus.c                        |    1 +
>   drivers/platform/x86/Kconfig                  |   23 +
>   drivers/platform/x86/Makefile                 |    1 +
>   drivers/platform/x86/asus-armoury.c           | 1172 ++++++++++++++
>   drivers/platform/x86/asus-armoury.h           | 1402 +++++++++++++++++
>   drivers/platform/x86/asus-wmi.c               |  170 +-
>   .../platform_data/x86/asus-wmi-leds-ids.h     |   50 +
>   include/linux/platform_data/x86/asus-wmi.h    |   62 +-
>   9 files changed, 2823 insertions(+), 75 deletions(-)
>   create mode 100644 drivers/platform/x86/asus-armoury.c
>   create mode 100644 drivers/platform/x86/asus-armoury.h
>   create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h
> 


