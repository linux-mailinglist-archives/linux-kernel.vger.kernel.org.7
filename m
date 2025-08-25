Return-Path: <linux-kernel+bounces-785459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61726B34B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155C117B95B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524A2848B4;
	Mon, 25 Aug 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tWufEjhb"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2115.outbound.protection.outlook.com [40.107.115.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22B2367C9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150800; cv=fail; b=sfVmA3VcurvVYCfY6gXy1yyqiLBn7N04tL1jS8fNxrVKmmc7YfZuA5NcQTWz5gAbmdrfpnPesACiSwtF7qT7SZt0UMwidUFIZKTsosRD1RNTomix+3nLFIQNwir4fTekKKsnJYpieoZ0h91QwSwIaWMutpAdk0ADpHKuIzi6yOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150800; c=relaxed/simple;
	bh=+zyv6Lw67fVjZcyoL/LHiarF2vHpbSAS554wL1QImsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ukES1J4JfQ4j+mykbL3Bf2IMWvbC4h+TXy5yvdvVzYau+W13wAtmdQeRdfvEpiy8nSVTuKPRTwm9C+XCSROKpsb4FCd+GY34o1VytS9rMH3GcXAP1yGF6QU+aoJCy9NBtoym4k3/XJEIVvRB7KSfx0FrlMnddXUfgDrENpEaclk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=tWufEjhb; arc=fail smtp.client-ip=40.107.115.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4IdhZlqKPwwRz047XPqqg0yaAvGe25JL20Lo2FgfGhTgqeD3PlEZjvhH9t1e3Wl8/kr1xX/4K8sfsZabzO3PlbciwtVwvmnG8pB9RMn90MHQ1y3YfuGljVIivIU88mtPBmRHd3QH8lsYodTNX7se3Z2CZ3/k6hbklMzxlSTtLtOAyh1PeXb6Nvk02HEpoqh9XbEYgmGIa2SBz9L+LBay4mQXzQQOHAWYeflcj8phhHZacrGRtN9MCI2U10mRJZ9Gbe1luiPhLOUQhgs77MsYRsjLC+Zwpw7vEhFwwa3agTDexGeFlJnwjtU1GlDGpzXGUrxu0oq1I1mHbdi2gPLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkFTnMl5ML/AWiyH5JlbIIxNNdo16iuRQ12UVQVqHLM=;
 b=V6Wa2zJmyK6efXV9uPz7I1j0hx8jV7njz1Q7qTlZjKafnyjaz6civjW+WB8+KNcq7+b9K59Mb3KsNisAaXCWcbtzZI9ZsXGKWzZxfpJLippR1x5Xpf8x61yJwtAW4DQL5A85fED2tRFyacdzp4DPRY94MGdJqsRj1cc+OcFbQBg2gQunGK8n/lP5gPqa8tUIvzXtZi+Wjc2z5vlzlcPmQ8BgCGmD+ITKyTb7bnppXZzhrmWoW9tuU5ENWkfBGqOmGgz/PXuMZ6L64Y2skK+GHHeho+wCIXtlHY72Y8mLdi9NZ2N3sNLnG8QASENecX0ch06QWsu9Wf0ITIhizN6LpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkFTnMl5ML/AWiyH5JlbIIxNNdo16iuRQ12UVQVqHLM=;
 b=tWufEjhboo+5fNHQMfpb8GU4kKft9FSfp6q8Q8hlXoFLuYrbZCSQcGS6zQO3u8JPcaLchBnw4kzlTzwb9uBnf+RvZd6Wei2V4mRVLw6o+FVI5FldKLZrwP/YbJHialXLCi7sUrq7aTeURRx1T+tAgACeUgkOQZjZt1xkk2yKE6tPdobngep/wRly3TLdYsaWOwWJsQ9M/fT8EsrqtnGKbZcbjz6M1jNYEMjMBmMZTlFKgYuMBBHfuF4vid3CUgf5Hc+orCfI0twOCOqCSMGS+0ZQvD6srPXas0nZgLNr45WMjO8blZdbqlPa6F+Az7VXqvCQ45OzD2zT817nxgGpXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5828.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 19:39:53 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 19:39:53 +0000
Message-ID: <9b606d45-0d3e-4add-9936-380656475b55@efficios.com>
Date: Mon, 25 Aug 2025 15:39:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 36/37] rseq: Switch to TIF_RSEQ if supported
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.586695263@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.586695263@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 963ee43d-e696-4225-ae9d-08dde40f29cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3VQeEtyZEp3b2ZmaUp0aDNxMFFTRzNsZStmOXQ0ZkwyOHJoN0p5WmFPQVY5?=
 =?utf-8?B?Vjc1QitWc2RkaUFrZ1FVZXE5WHdJNlIyY0RCQUNSbXZRbXUwSFp6eW90Unpz?=
 =?utf-8?B?ek1hNzNEMUlyVVZlUUU3S3pFTHNLa2Q0YmlPeXNBMkM2RVlGY0pRTHZ3UHdP?=
 =?utf-8?B?ckxOcHM1OE5hVFRXUVhMU0luWHl2MXFSa2M5eEViaGVIMkRpbXkrT290QlJZ?=
 =?utf-8?B?UXMxYnRVMFNWQjZVb04xeUhTMHBJUlVOUTdUeXcxcGtqdjFQRm5iM2RBNm9W?=
 =?utf-8?B?UE1lVThXY3kvcktwR3NXVmJra2dEZDJxdmRjQzgxcU41VzYrNmRpSjN2SERm?=
 =?utf-8?B?V05nUVB5RzMyYkl6bTBZYkhJWkNpQTRKTlFta29MWktSbjhNSCtyWlF6UnpE?=
 =?utf-8?B?eVNyZnJoY3doUG1ZMzI0QnNFeE5vYkRMcHJvVGhjVGpYOFAzQnI5OFVFQjBr?=
 =?utf-8?B?dVNuaHBjdlNoei9OakdnM3dqZmhMQ0lCeXdlQ2lORTFCU1hYR2x6WnM3eXJL?=
 =?utf-8?B?aldjR0R6dFlucTVKbmdydTBkOXVEWTZGUkc4UlFCK1dPMUhIUzF1MUgxaThZ?=
 =?utf-8?B?VFhhT095VDhkTUZ3ZWFNMUV2TStLelZDa29USE1QTjVNV3cxdDZnWGVwZWZi?=
 =?utf-8?B?c2p1QWpQUlh1QnI5ZjBRNG1jYU5mMm1ncE1OSSt6Ull2MUZybzBHalpSSGxu?=
 =?utf-8?B?OU8xTFVObEdzYzcxS3crOU1aNVg4bGlQd1FZVUtDUGhVMDRJMHhUaDdPcnVp?=
 =?utf-8?B?RFpIMGJ0Y3V5KzMrUXY0K2Z6NVBXWnZxa0kybHV4NDV2aVV3aVgyNjdNMTQ1?=
 =?utf-8?B?T2QyYWZTNTFtbDlQQTFwdlZwMk9Hc0h0ZXlVNWdWUnNQTlZyVXE2amVEL3dr?=
 =?utf-8?B?M0NPcTNSdUxvbkxXME1JU1VJQWhyYjVRR0ltRTZkd1hFMXhnNWR5ZDBUUzVV?=
 =?utf-8?B?b2NCR01sakZQZkgyVEJYK0tQNFFuM3B5ZHZERFArNWJLSUpXaFlaNVo5N3pC?=
 =?utf-8?B?SGRJQjh1My9LYmY5ZFRnWEJ5R2dWR0U5T1grN2F3SVNGbTBkcE9Ra0M2TGZI?=
 =?utf-8?B?czNrcDZ5UkhoNjNuMjFhNlNVTTV0dzl6bm9VWlppQ2Zya0owYkRuWm1OMjZR?=
 =?utf-8?B?MS9KcnVvbkF1blp4dnlYdjJVWHhmUWo2Y0FDV1BVaG1nNnQwbVkyRXlSUEQr?=
 =?utf-8?B?NERnTXpENEtnV1p6K09FODh0eUo5KzZ5M1gxeFY1eFBvTU9WdjBja0xCS0cy?=
 =?utf-8?B?RFl3Y01lbkQ0bDZ1d0NyYmNHUUprcWxCb1dJYXlpYnVJRnNRajhkcVY3bjdS?=
 =?utf-8?B?aklYZ1dPcDc4a0daMS95cGFkM1pCU2Z5UXBWSmJCZmNMR05xbS9SYi9NTHov?=
 =?utf-8?B?dlRsdlZBdTdtQjFUYjZ5QXYxOWltZWZxVXJEVEgxTmtQTTJ6SVg3Ym9PeEV3?=
 =?utf-8?B?eW1acitnSnlKZmNWQys0eWkyRHdJcFh3U1cvOEtHV2JlbUIyT2I0bGVkS3pW?=
 =?utf-8?B?SEVSL3NVdktFNUt3RzZoM0JPNTdPK3c2WWJqT2RtUlZTNlJFRDNSbk8yUURE?=
 =?utf-8?B?b0YyZTdoQkIvakhkR3JBVWVLREgydGpHRCswRDZuMWcrUHJncVduMFR4b2gv?=
 =?utf-8?B?YUZraTIxT2tRbW16dW1yY1JnSEhrZ1dPMW1DYmdRLzdlWldSTVdmYXdhU0N4?=
 =?utf-8?B?OFFQQlQ0VWZXb2w4NnhtSUhwT08wYkxoTzc5RTFlK094dE02S0gybm9xZlB5?=
 =?utf-8?B?cStkMms4K1NkaW9uV1BkMG80VWNIRHNTWksvaTV5TU5IbmMwZG5MYzFiZk5x?=
 =?utf-8?Q?IklAwD0R9TwJtas2c5LYb9RZax5KlbaZBgzrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNXUDgrRDB4QUhzUW1uRmUzOERzUGVod3dLTi9TRjdTcXdFMytwUmUwVlRQ?=
 =?utf-8?B?dXhVbXJlNnJZYkJwb2lTd01XTGp5ZEpwbXZMUFhiMlRHb2w5QUxrbFVCbTBU?=
 =?utf-8?B?cmVtS05TaHJKLzNZcGRnRExhZjNsYlEzUldndTdZQXA0djRMUzFtNHNRK3dG?=
 =?utf-8?B?RXluTUxlN3lRTGdVaCtpeEhkQjZ5YjN6Ris0Qk9MeGlWa0JtVGNjbFZTL0o0?=
 =?utf-8?B?SkVJcDBuSUpsbVFtcSt0VDdqTjE5OCtOWk5ITVVMUGdXVTQ4NFEydE9lOTY0?=
 =?utf-8?B?M2ZHODF2L0VodFNML3JFeENxZkQvV0prZE81aTVFMERpaTVmSWhxTVVyQ0d1?=
 =?utf-8?B?KzNDOGxRSHpiaWwyalh4SmFVMWhheXk3VTJFaVl0V1ViTHdaM1NZWTdhMnJl?=
 =?utf-8?B?c1VXY2VQbDBoOGlBM3ROOTBndGlsTFZPWStyMGpWREQzZWh4SWhya2JEZFhn?=
 =?utf-8?B?MzY5aUZzMlgyaGtiaUV4MUpmSkFuTVM0U0NJMzBzaTBBKzd2YkJ6M0taM2xw?=
 =?utf-8?B?d3FQUHlXbS83ZU5JRjgzbHg4VG4vbytvSHphbEJCSDIzU0N2TThYeVlDU3p5?=
 =?utf-8?B?R1VrY0gwc2VzNThkSTI2bFFjbTFMZ05hZW9Tdkh5QnYxWGM1UlBVZmlzTGJs?=
 =?utf-8?B?ZklpY25vczB6c1BJTmJlWmhxSCt6eGs2QU01cVJHODFqaDRVTUgraXdKdVha?=
 =?utf-8?B?UFFqL2g1SlJmZEVIWGJLdlpZcXlZeXF3ZXhHTWxsVGdFbVZ0WVduTDgrL2Rs?=
 =?utf-8?B?a1FnakJMQ2psc2V0TVp5cXVYdEZNaVB2WGJnQ2lUbXB3eGNHT3lOK04wOGVK?=
 =?utf-8?B?K0lNS2xTK3VxVU53a2NYQ2xzam84bENhUjBadU5ZNVI5aDJtOUg2UWxYZ2pQ?=
 =?utf-8?B?b3RtZlNnQ3pvcXJDakhmeWptMUFyTm44S2Z6NkVnMUNNNVRKYkRqSUFBY1hV?=
 =?utf-8?B?Wmd6ODVWdTRML3V1cDhCVU02eFNPNFF5bENPUWlHdWI2cVFVcVpkN2FCcWVJ?=
 =?utf-8?B?MmVKL1psSjNZTWpNRk1GTXQyN3dhQWpOMDVaWVdiMU1ibDRKbS9scy9nVWt0?=
 =?utf-8?B?em5lRUt0K29TckRuYWFCaVZBelduZXlpc05xci9DN3FPUjlQSE5VazFGVHZ3?=
 =?utf-8?B?TnBjekxuc1lDT2h3NTV0UldVOHZkZW5TSlFkUlJOU0hLVC9RTkkvREJIdGxR?=
 =?utf-8?B?dmJpaHpQb2NVVjNzMlM4M2YzeHU3R2hEUHg5U3lQc1hlWnRMdSt4Y3RrTlY3?=
 =?utf-8?B?UXVZZUtyVldZRktSakVVdCthYVhzZktzRHE2aDNuZUI4TmYwTE81TDM2OEpQ?=
 =?utf-8?B?TURYYk15TmRFTFFNV1lxSUR3a2tDNlh3Y3JKemhhZU85SnNJWU01NnhzNnZj?=
 =?utf-8?B?Q3hVbHBmUnJDR0tHMFRFVTllbjVqNDEwN3FVQ1gvUW1vR3lwSU5DeXlhd1Uv?=
 =?utf-8?B?RmxRWkRUUXh3QUY5SjNQSW5xZ3dhd3hMd3hRZmV1amVqYVpLamVjZWVQU1ln?=
 =?utf-8?B?TlRSNDNIbHBRM0lZTWh0dTRiZzhwVHFENDJZMU5ITENvOEM1NkdHVnU0eXhC?=
 =?utf-8?B?STFYY2lNQ0NnZVFWUFQ0VEJscW1YdENyVkJFTnFwa2lDRWM0dEFCRVd5c1Nh?=
 =?utf-8?B?dy95bkdtWjNwamtFZ1FJV0hQaXh4aE5YOW5GZGhXNnltOWFhR0FKbW5jUFZP?=
 =?utf-8?B?SUpUWEdjdkdnWTN0MmpxM1dEZUdhS25tRFVGL3J6b1JtVnE1bmNJNzRVcUdK?=
 =?utf-8?B?amg5UllraHV3VS9nampDT1EzN2JxN3dlUzBwQ3QzSGR3WFNRb2RkaS9Vc0FG?=
 =?utf-8?B?SmNMMEFNbTN3ZjlDNys4M2l1bnFPaHlkWEd1d3BVQkRxNnFKRmNmZkpoOGxl?=
 =?utf-8?B?em1SV3Z4ckdrMFR4bFc2L1NObzlHM0hTcWNGQm5BZXRrVm16UXZ3UmJWcTJY?=
 =?utf-8?B?Yk95aTdERFhCa29LOGt0dkpRTk8rd056U1VSbGpkVlhYcmowTkZaL1lvdWUx?=
 =?utf-8?B?ckdNeG14Rm5yVmpDQ3UrK1J0UkdVSEVGSWh2aC9Pb1lLRDg0S2lIOE5NQU5K?=
 =?utf-8?B?VFFlMWswSWhGK09zdnNHMjZHYm5wWFdCZkwvajBieDlNTmlvNXcvcFFTOXNW?=
 =?utf-8?B?cWpDKy9yMEh5MldrSHNySGUxcDlKUmFwajlod2xBeEdsRFJvZGFCVHJrbTU3?=
 =?utf-8?Q?BTlchvdLCIU/EO/H2DBbZZ8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963ee43d-e696-4225-ae9d-08dde40f29cf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:39:53.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQVtTmbvUoctoqpk0ubViF2Cq4yZHcGxu5xiraow/unfwjYzPEUURnH5wzDmAsLFkoSq/WmNpoefhQGXP+HTw0ZHTKlfD0n1spCdPdMuXZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5828

On 2025-08-23 12:40, Thomas Gleixner wrote:
> TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is suboptimal especially
> with the RSEQ fast path depending on it, but not really handling it.
> 
> Define a seperate TIF_RSEQ in the generic TIF space and enable the full
> seperation of fast and slow path for architectures which utilize that.
> 
> That avoids the hassle with invocations of resume_user_mode_work() from
> hypervisors, which clear TIF_NOTIFY_RESUME. It makes the therefore required
> re-evaluation at the end of vcpu_run() a NOOP on architectures which
> utilize the generic TIF space and have a seperate TIF_RSEQ.
> 
> The hypervisor TIF handling does not include the seperate TIF_RSEQ as there
> is no point in doing so. The guest does neither know nor care about the VMM
> host applications RSEQ state. That state is only relevant when the ioctl()
> returns to user space.
> 
> The fastpath implementation still utilizes TIF_NOTIFY_RESUME for failure
> handling, but this only happens within exit_to_user_mode_loop(), so
> arguably the hypervisor ioctl() code is long done when this happens.
> 
> This allows further optimizations for blocking syscall heavy workloads in a
> subsequent step.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/asm-generic/thread_info_tif.h |    3 +++
>   include/linux/irq-entry-common.h      |    2 +-
>   include/linux/rseq.h                  |   13 ++++++++++---
>   include/linux/rseq_entry.h            |   23 +++++++++++++++++++----
>   include/linux/thread_info.h           |    5 +++++
>   5 files changed, 38 insertions(+), 8 deletions(-)
> 
> --- a/include/asm-generic/thread_info_tif.h
> +++ b/include/asm-generic/thread_info_tif.h
> @@ -45,4 +45,7 @@
>   # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
>   #endif
>   
> +#define TIF_RSEQ		11	// Run RSEQ fast path
> +#define _TIF_RSEQ		BIT(TIF_RSEQ)
> +
>   #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -30,7 +30,7 @@
>   #define EXIT_TO_USER_MODE_WORK						\
>   	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
>   	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
> -	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
> +	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL | _TIF_RSEQ |		\
>   	 ARCH_EXIT_TO_USER_MODE_WORK)
>   
>   /**
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -40,7 +40,7 @@ static inline void rseq_signal_deliver(s
>   
>   static inline void rseq_raise_notify_resume(struct task_struct *t)
>   {
> -	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	set_tsk_thread_flag(t, TIF_RSEQ);
>   }
>   
>   /* Invoked from context switch to force evaluation on exit to user */
> @@ -122,7 +122,7 @@ static inline void rseq_force_update(voi
>    */
>   static inline void rseq_virt_userspace_exit(void)
>   {
> -	if (current->rseq_event.sched_switch)
> +	if (!IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS) && current->rseq_event.sched_switch)
>   		rseq_raise_notify_resume(current);
>   }
>   
> @@ -147,9 +147,16 @@ static inline void rseq_fork(struct task
>   		/*
>   		 * If it has rseq, force it into the slow path right away
>   		 * because it is guaranteed to fault.
> +		 *
> +		 * Setting TIF_NOTIFY_RESUME is redundant but harmless for
> +		 * architectures which do not have a seperate TIF_RSEQ, but
> +		 * for those who do it's required to enforce the slow path
> +		 * as the scheduler sets only TIF_RSEQ.
>   		 */
> -		if (t->rseq_event.has_rseq)
> +		if (t->rseq_event.has_rseq) {
>   			t->rseq_event.slowpath = true;
> +			set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +		}
>   	}
>   }
>   
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -502,18 +502,33 @@ static __always_inline bool __rseq_exit_
>   	return true;
>   }
>   
> +#ifdef CONFIG_HAVE_GENERIC_TIF_BITS
> +# define CHECK_TIF_RSEQ		_TIF_RSEQ
> +static __always_inline void clear_tif_rseq(void)
> +{
> +	clear_thread_flag(TIF_RSEQ);
> +}
> +#else
> +# define CHECK_TIF_RSEQ		0UL
> +static inline void clear_tif_rseq(void) { }
> +#endif
> +
>   static __always_inline unsigned long
>   rseq_exit_to_user_mode_work(struct pt_regs *regs, unsigned long ti_work, const unsigned long mask)
>   {
>   	/*
>   	 * Check if all work bits have been cleared before handling rseq.
> +	 *
> +	 * In case of a seperate TIF_RSEQ this checks for all other bits to
> +	 * be cleared and TIF_RSEQ to be set.
>   	 */
> -	if ((ti_work & mask) != 0)
> -		return ti_work;
> -
> -	if (likely(!__rseq_exit_to_user_mode_restart(regs)))
> +	if ((ti_work & mask) != CHECK_TIF_RSEQ)
>   		return ti_work;
>   
> +	if (likely(!__rseq_exit_to_user_mode_restart(regs))) {
> +		clear_tif_rseq();
> +		return ti_work & ~CHECK_TIF_RSEQ;
> +	}
>   	return ti_work | _TIF_NOTIFY_RESUME;
>   }
>   
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -67,6 +67,11 @@ enum syscall_work_bit {
>   #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
>   #endif
>   
> +#ifndef TIF_RSEQ
> +# define TIF_RSEQ	TIF_NOTIFY_RESUME
> +# define _TIF_RSEQ	_TIF_NOTIFY_RESUME
> +#endif
> +
>   #ifdef __KERNEL__
>   
>   #ifndef arch_set_restart_data
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

