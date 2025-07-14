Return-Path: <linux-kernel+bounces-729334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B8AB03516
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA07189937B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D81DF963;
	Mon, 14 Jul 2025 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/4RzXAi"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F04A11
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465835; cv=fail; b=hnHNfx+8e2BzlCwyQpfwRpYS3Ne4pLX92R2mePlx7/ATS5zzmd528RwHzkH5QhBKfydX8TOXodG7K69TsY0jwDPL8Vi2slMed2MAVeX4p5YwKZQvNm/FURDP5p9BkAyKNQE/w88VxNqPhi7e/O2HiTE1sSMhG5BQmGcm+gxLdAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465835; c=relaxed/simple;
	bh=3cIq7iBQaLL38FA3eefA1FLyAr5I5ZSAk6dYaLcdlYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TGc2gnpTOko5TuUoJOQnAEzPuIq80Knu6UhYb+vowoFolwDp1WCoK3aP0leE0AkJDAgNi7d9yYO5WjsHZQHHw+/SLhbe8pahwYeoeWF2cqY3HRe2poGiuNdHeOS89RVbml8aHLEjEwtJbCaLogtQm4lXatNboAVffTI+3ZME6N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H/4RzXAi; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzVt7qM50ttdXgF0guWDIXHxZMh1r9pCt4FKuTn8MHox+EKJrAuubIo0lo+FOiXbgiI4oS9EdkJklAfnHBC9M0s4nW0FQXTdDTbMOINz6X6nQI9WpVQu857BWinada1Ida1cAAVR9pd0+1OoJ0fSQTldarOE1BbUCG7Ci6xz3SMECMRjMkqKlZ5+FBFPo7z1D6+z6XaghEQck8EQdU/F9KXBQGeKq65yknn9DxsEk1x4VHj0PWzjpQmkT1FgbDF61WZCgDt+Vmf/Gb5vJaS8FLs2bnbOcCaATDdJOzfmQfd3lxRgVAzTpaZceDc/Fn/PRep9UwtTyGJgZpGQ91pJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK2BgBC7gDFIwmQtO4n13MQPh+Cxw+YYlo9vStSlOeg=;
 b=o5/0TOqcqfi/LZyDluGT8B/H38oCgbzLKJbdnQy5jcFHLD1V4Q6RdRXMc1zQAZSoqZtnApUbnugmcDtIPYtPNbXiBg690+8Co5n4+Ob0eFHOAKzbfw9ztDi/d/hdAYr5u9qse2YBfnA2oTP7LgFXqJdPmbYtJiYjSc+MDw3iIjwiv+DM6JVSdFcRIbppGdnVibuc5/owFE3pK+RwaIVF8HKPVdHyZjQDZozhnx7qQSa9iYU8b4Y7JkSmNBV4Mbj/fEMjBoE//zqnT9QsgTsdU45pYQfY5A34sFDdU8LwE7ZiNiY5d/8NJszYNmynmeOBTTLS7+vFS86GFnCSbNWbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK2BgBC7gDFIwmQtO4n13MQPh+Cxw+YYlo9vStSlOeg=;
 b=H/4RzXAi0SyVugPR0QyydCi6Jjl7gTLTcpZ3nx0s4hSiazV2g5GCWTVbF7Vmzc9gXo2pyp4Pz4oMy5ZyV39VbJBSI+ESU6+U2BkBuBrQdC1xeQZAt+E/Dy/lgfchxE9zlpotgxdfAW8R2X7MAwvvNydmjR4d+GwZnZ5IfLujkoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 04:03:50 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 04:03:50 +0000
Message-ID: <0305d98a-0300-429a-adc2-39fd9b3af876@amd.com>
Date: Mon, 14 Jul 2025 09:33:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Li Chen <me@linux.beauty>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Li Chen <chenl311@chinatelecom.cn>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 linux-kernel@vger.kernel.org
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
 <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
 <20250711130601.GD905792@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250711130601.GD905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::11) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfb440f-426c-4f54-9177-08ddc28b7075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnNySWcwQVZFMGwwSUsvcmpncG8xUzJtNWtlWi9nMDNBcnVWU0NxRG0zdENu?=
 =?utf-8?B?WXlyVE1OM3g0Q0hhdkwyRGpPM3VhakVhS3pGSnZMK2E2bW5Yd2xsNlRKMElB?=
 =?utf-8?B?aDluT3NpRmlxSFo4c2NVV3Y1V0NmclJUVFRLMUZoTy84cmhteUh5b1UwaFRq?=
 =?utf-8?B?UGVsdnJBeEEwOTY5aWFqRTgwMVlYMmpmcTBhQlJzcFdvMjBJbEUxY1pRaTZT?=
 =?utf-8?B?K1VVZHBReTYwU3YzODBBTUZ2aXZUVkV0eklsdkU1V0xXczhuSldKcVNIbXFh?=
 =?utf-8?B?bWlnZWpnaDg5WjJvdGg2S005UlRiWEtQaVZaN1VtMFB5Z2xzMXZhZkVxS3I5?=
 =?utf-8?B?YTRLZ2FpRkxVM2IxTmp0SjU5Y1d6RkdDVEtJRFoyNVRFakpjVnVNbUxZWXpx?=
 =?utf-8?B?SklUZkNvVVl2YnpsK1JjSTF4SFdhbVVlay9lQTFiRFdzOHZXV2RPdEJObThs?=
 =?utf-8?B?aFpQcWRKVC9XRVZBbUNJdUdPSkNqMUhVMDRuVHNDR0NEYmxRQXZTSU9oVkNl?=
 =?utf-8?B?VnFHRkVDRUZoMDNjdVpGS2pHQ1Yra0Z6Qkk2VTRqaC9YK2dNQ0gzemRLYkZB?=
 =?utf-8?B?YzIxNHAyZDRMRzVob0VxdWFQTVptWW9NbXl2ZkQ4V3dVa0JVakdxay8xS01o?=
 =?utf-8?B?WTNNYTJUSzFQMXBicVVjaFIzSE4xOTRyK0dFUXBUR1M0TmZDcllqWXBEQmp0?=
 =?utf-8?B?TWI2Mkg4bGMzQnROaUxTeGMwY0plUTYvZW1JUklUai9LcTUxaVpGRldqcjJw?=
 =?utf-8?B?MFVKYmJDQzVXOFE0NVVMemlzVHJZR09RV1NxMnBlR0tYTmNhdmNxMlk1bkNH?=
 =?utf-8?B?aERhaFRQUzE4Yk1lVEppNXlOdDFWdUE2SXAyM3AwenRRcUZwYWRqQ2JYV3F1?=
 =?utf-8?B?WHlHVFpKWUNoQlN5R3BFMHRDUCtpZmE3SXlhRmRyd3pUOWtrTklmUzhKVXF2?=
 =?utf-8?B?dTUrcjBET0FzZ2d2Qk8yVVc1UHQ3Mzk0SE9NM25LdWVKVGluSEs3d29aL3FO?=
 =?utf-8?B?R2dhakZDSEJIUUtuOE1ZeXRQMDU5QjZSUkh2NG1RRkIwMlpKdjNsdHBSUnhW?=
 =?utf-8?B?TWprKy9JdzR0azhKcEhVb2llMFY4cHpmQXhxZkRqVUpmTHkyckhPeHVsVDl4?=
 =?utf-8?B?cWVEeUVnNlgzbjMxSTlwZ096VjhvNGhRTGpxazhqZjMxaGNrMitHbEkvcTZv?=
 =?utf-8?B?WW5uZnJIZHRubHRDRHF4QVJTem4wdGhlbXpkMEtaL3d6WEc0eVhFK1B1OHBW?=
 =?utf-8?B?SDZwejZrOW9RbWo5T0tBUDhYSUhkQmlRTk1zanRpWm5Fdm9zclFnaG1tQWRm?=
 =?utf-8?B?elNVb0VzSkFZcmdMSG5ST3RaZWxzeVlIQURXSzdnNnhSdjRKNXlpUEFSVDEy?=
 =?utf-8?B?d1BORm9vK0FZQmJEOFNSaEMyS0JMQW1SdjBVSGk3dUU5Ym45Ulh5RldDY1Jv?=
 =?utf-8?B?eWtzeUxUU3NJUm9kUWxGZmRMRjlBTndVemZzNUNQRGdla0kxYmFmQzVMUXpP?=
 =?utf-8?B?Wmw1UjRVS3JFdHRnQjdlMVRWYmViRngvRExBbXVOOWY4b0hIdU9oenBLc1NN?=
 =?utf-8?B?U0ErNEt2Ylh1SzlUdVh4ZDl4QUY5dCsxVUdiWllqSEZjRkoyK1lqV2NIZklZ?=
 =?utf-8?B?Yzg1N0JmT0VSdmViQUZHWGtoTjdKN1YxUTBlL092Vmx4dTlacGh0RDRPSFJr?=
 =?utf-8?B?WUFwMmJ3dnp0c1RGaklGZ0FSSUhjYlA1OC9MQXpSOW9VaXdtUElqb1VhZHgv?=
 =?utf-8?B?TFArUExNR21JYThnS3A0N3RPT2xFRWcwV1RjL2tHYjNlNG90dVV5THJhZWFr?=
 =?utf-8?B?YnhDUXp4SE10QStjU2lsT2hncS82Tml0K0dHRXZFamVrWjRLVTNHUmJkZjFq?=
 =?utf-8?B?YW12QnRRUDR1S0JBMnY0YzdGOG13RktOb0JVRS9wcVVTdVB6aTdNSGI5ZTR0?=
 =?utf-8?Q?9pM8ERV4zWU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tnl4UUhBc3VmMkJCTlJWTjBTSFFHZHJLSzRuNlRzazRwMVRNMGkxQzZPTUto?=
 =?utf-8?B?TTlkaUZ0MzJ2TE1mb0VmQkFKTUI2YTRaTkpDNWRPbzN5Qi9YeGI2ZzYxSUlr?=
 =?utf-8?B?UU5OQXlzQ2lqSkNBVzlTM0ZDSllYYUdIR2piMk5WUFQ1bkNXTjhKZGQwYUVD?=
 =?utf-8?B?b3hYTExpYzVyeFRuZnp5SlRGUUJuTmp6SVlhRlBRckJFV0hDYlBCQmVManM1?=
 =?utf-8?B?VGwxbkFpd2N4WnhQSDRXUGRSa2tMK2EvOHNUK2dlbFA5b3dhdGludzNGTTFD?=
 =?utf-8?B?QVpkZUVxNndOTnZvTHN2b1JFMGY4WWNiWmMrdkppU0ZUNWtqQkFhSHh4NmFV?=
 =?utf-8?B?MFFKeFJEQi9GQjlEdyttTjZUbjNaS2lkNkoyREFpRUNORjBwUDJ0SklQalA5?=
 =?utf-8?B?b21mWnlCWlM0a004TkNibTVCUVR4R1RrQzU1Vlc5Q1JtYmp5TGNvMVNQTTRa?=
 =?utf-8?B?UG5OTXVoMmNUM1RMRkovQnI5SktlZ3J2VEhiRXJrNHhMNTVLdnNuaThFZy9D?=
 =?utf-8?B?ZWx2NEJRY1loQ2pUR1VIbUoxMGhWVW1wWDhJUHMwZk5UVXdpOXZXRUZTcFBp?=
 =?utf-8?B?SlVLRXowNUlYWE5IZDlRY2dndHU0amJ6NE4vZ3RPSFJpeitzNWVOdFZ0YWRx?=
 =?utf-8?B?V2RONVRWbVRQSHducURBYVhVY3FKUk5VNFVwaFVyUVFISnltU013Ym1WZlRv?=
 =?utf-8?B?SU1jejZIV1Y1OHJvb1dmZVBEN0dVVHp3eHBuVldzZEVxMXZXMFNhWGRRN1M4?=
 =?utf-8?B?VDFSamxuM2JFZGl6dkJET3ora202aS9WdWtveEN2MWgwbVJrWDM3TUlxZlE0?=
 =?utf-8?B?Nk1BS3FFTmUwOFZuVzhVdEFRd3RGUVM2bzQvVnpyd29DVWZTMEFJL3hXOTVn?=
 =?utf-8?B?RWc5ejNNUW1ieEl6M1ZBQlRtNndGRjZaRERtVmlGMXFGUWlueHFLM0hyeXZT?=
 =?utf-8?B?MVRWdjVLdDJIcGJKVTZ5d3NPb2g1S1FGMFdvMkFIdm93NmJPdzZQOXRJdHNV?=
 =?utf-8?B?aTdwOWk3b0JmbUozZUdwNzZpNE95Vmgxb1Fxb2lVSVNWMEcrb2NRSVh1dHNE?=
 =?utf-8?B?Z2N2YjA4eDZNNStDZDZvaTR0M2JrTjZvN2RCRm9QVEJqR0FpNm04TitYTDND?=
 =?utf-8?B?SlBEMlhIakMvU2lISzk1T0hhNHhLZE9BVko3SENwOUo3ZU5hTTM2TzkvZmVZ?=
 =?utf-8?B?bDhhN1dvcmt0eWdYZDcyMkJ6clpHa3BQQzFEL21EckgvSVdUckZIM3RCL0xR?=
 =?utf-8?B?UkMrekszUE4zVnBpenpiT1NVK0NCWnptaFh4dCtGR2lEdDgwMkZ3UTh3WVFo?=
 =?utf-8?B?Y25JSUhNWFV3YlJOWkJMaGlQOWQzQlU2UGdwc0dEOHNJOUZwNGhQNjZ6SEVV?=
 =?utf-8?B?eHRYOFU5QXd6YTFuTnM0YnBONEJlK3hPNEJHQ1dWQk9GZlJWR3ZtMzVZODNr?=
 =?utf-8?B?OGtqeml2a2xJb2dIZ1B3Y09LUTU2RE90WS9CUWhZcWV1TWpCQllrQUcxcXAy?=
 =?utf-8?B?WCtjTGdZTzZsTzBzZldTOEZBcFFaTXJuREpRZmZXR2hFTitBc1JvVHBGN1Yw?=
 =?utf-8?B?eDRUTjJkdFdOUkpCYUZnRnZjV0tpcFJwank1c3JTWW9NS1FLK2gyTmthYisw?=
 =?utf-8?B?NXA2RlZ6SGkvQzNYbGZsTnQ0N3dHc1RzaUlXUVBCSXRPczhvK2FlZldJbm9X?=
 =?utf-8?B?dWdvZTM3eW9NUUsvRG1McjN3aDNma1h1VEFHVkRwTW9RQjZlQVM2bGVMVi9p?=
 =?utf-8?B?byt1NTYwRTVTaGpFMk5EZEVTR2grMkxBdS9rU0UrRkQ1M3lxcU1xVlNiMUta?=
 =?utf-8?B?Um5SSnpRNDZQOVpSdVJpdVBkVGxTUGdNK00wUlJjalY5VUVjbC9KRHNzUURR?=
 =?utf-8?B?d1ZCVFZZdXdKSUU2MEt4ZXVRcC9wZytHbTNJUDd6Y2MxRTh6STRBOXdoVWpD?=
 =?utf-8?B?MkFuMmNQY1FGQnFMVGZNNDNUbWdsOFJEOGFyZUpFNVpndGptSG9sSEhMd1dX?=
 =?utf-8?B?N2RXaFVkZk9ZOXVzZ2p3RE0zOS9MdE9QZnpZa0tKQUVKN2VMWkZMK3JlLzFr?=
 =?utf-8?B?dnNOTTZvdzJ3eFhSZWFrcE5xbmpsVlEzM1FTQXBFYjlOcDRWUjk0ZVhYanpL?=
 =?utf-8?Q?J9nx6x0mxCjBmdXvi7E+NHMxz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfb440f-426c-4f54-9177-08ddc28b7075
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 04:03:50.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KjNzmswXX98Ue5AIH9knMRqOiQI4Yohh55X3EbhBwVulZHm932pQFX7JWy659b+40LWij02JnbxoUhTugZJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

(trimming the cc to only kernel/sched folks to reduce the noise)

On 7/11/2025 6:36 PM, Peter Zijlstra wrote:
> On Fri, Jul 11, 2025 at 11:20:30AM +0530, K Prateek Nayak wrote:
>> On 7/10/2025 4:27 PM, Li Chen wrote:
>>>  	/*
>>>  	 * .. and append 'j' levels of NUMA goodness.
>>>  	 */
>>>  	for (j = 1; j < nr_levels; i++, j++) {
>>> -		tl[i] = (struct sched_domain_topology_level){
>>> -			.mask = sd_numa_mask,
>>> -			.sd_flags = cpu_numa_flags,
>>> -			.flags = SDTL_OVERLAP,
>>> -			.numa_level = j,
>>> -			SD_INIT_NAME(NUMA)
>>> -		};
>>> +		tl[i] = SDTL_INIT(sd_numa_mask, cpu_numa_flags, NUMA);
>>> +		tl[i].numa_level = j;
>>> +		tl[i].flags = SDTL_OVERLAP;
>>
>> Tangential discussion: I was looking at this and was wondering why we
>> need a "tl->flags" when there is already sd_flags() function and we can
>> simply add SD_OVERLAP to sd_numa_flags().
>>
>> I think "tl->flags" was needed when the idea of overlap domains was
>> added in commit e3589f6c81e4 ("sched: Allow for overlapping sched_domain
>> spans") when it depended on "FORCE_SD_OVERLAP" sched_feat() which
>> allowed toggling this off but that was done away with in commit
>> af85596c74de ("sched/topology: Remove FORCE_SD_OVERLAP") so perhaps we
>> can get rid of it now?
>>
>> Relying on SD_NUMA should be enough currently. Peter, Valentin, what do
>> you think of something like below?
> 
> I think you're right. SD_NUMA appears to be the one and only case that
> also has SDTL_OVERLAP which then results in setting SD_OVERLAP, making
> SD_NUMA and SD_OVERLAP equivalent and SDTL_OVERLAP redundant.
> 
> I'll presume you're okay with me adding your SoB to things, and I'll
> push out all 5 patches to queue/sched/core to let the robots have a go
> at things.

Works for me! If you need a formal commit message:

Support for overlapping domains added in commit e3589f6c81e4 ("sched:
Allow for overlapping sched_domain spans") also allowed forcefully
setting SD_OVERLAP for !NUMA domains via FORCE_SD_OVERLAP sched_feat().

Since NUMA domains had to be presumed overlapping to ensure correct
behavior, "sched_domain_topology_level::flags" was introduced. NUMA
domains added the SDTL_OVERLAP flag would ensure SD_OVERLAP was always
added during build_sched_domains() for these domains, even when
FORCE_SD_OVERLAP was off.

Condition for adding the SD_OVERLAP flag at the aforementioned commit
was as follows:

    if (tl->flags & SDTL_OVERLAP || sched_feat(FORCE_SD_OVERLAP))
            sd->flags |= SD_OVERLAP; 

The FORCE_SD_OVERLAP debug feature was removed in commit af85596c74de
("sched/topology: Remove FORCE_SD_OVERLAP") which left the NUMA domains
as the exclusive users of SDTL_OVERLAP, SD_OVERLAP, and SD_NUMA flags.

Get rid of SDTL_OVERLAP and SD_OVERLAP as they have become redundant
and instead rely on SD_NUMA to detect the only overlapping domain
currently supported. Since SDTL_OVERLAP was the only user of
"tl->flags", get rid of "sched_domain_topology_level::flags" too.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---

P.S. Are we still considering the following for v6.16 cycle?
https://lore.kernel.org/lkml/20250709161917.14298-1-kprateek.nayak@amd.com/

If not, I can rebase it on top of queue:sched/core and send it out with
the conflicts resolved to save you a couple of edits :)

-- 
Thanks and Regards,
Prateek


