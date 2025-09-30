Return-Path: <linux-kernel+bounces-837457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A79BAC5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77DB192714C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713872F49E0;
	Tue, 30 Sep 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="gCU9c0bd"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023131.outbound.protection.outlook.com [52.101.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B23221FC6;
	Tue, 30 Sep 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225605; cv=fail; b=AwUnk428VVk1u+wP0w81aD7e0oXy3HjAy5Pp5gXZtsSF9tI+1L0iJrHxAGvgeHlpfCN3AmctXSEqRz2EHO1TKuwa08+oRnce4v6Dy+pNOglmB+wV4bmUrAyrbZAAjdwlgQH1+x8PwD2P9fENFK3Dy1hibqM5sl5WJO1b3WaUxw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225605; c=relaxed/simple;
	bh=1QOE2tHiHwwKJhakmV2goDMjtxQMmzQ/lz3eopxbDZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TWqKOV8NPUOdBfLD/m+7aMa0c8aX4XmLnWu37HhS6iGkR3DdgPb2HzTMvcWbRtjWn/oGX0+Kk2sxxoujtQEWpMBCD5+X5Je8S0k/uZVgI+KzqypFvdQ+DpoKy+ls6u7VTCplIY/HGk2hWsfekj3/Okusi2TBuVf/lhZ1qHyrodU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=gCU9c0bd; arc=fail smtp.client-ip=52.101.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLfYoH3GaPo1NcpnHpeOYVfDlL/iVX7stxjU7ZCfAvCJKk0cdcGPb+KBYbPUz0j1pu3szPmGoFA6n5ZUm+UeaPjzqrLdEZ9RPyWPadZZ+wk4nMS0G4qqlRfMuTjIMQknteIA70n9gElnZLedngclF7I+wuVXAP6DEAtCdUBwGdq1dsOuKLfW7KPnGcHY1pY0J20KESXZRjoDMZSwgpY+/oVz8nF7lwdJPa2aN7pqlADoq5J2oPjfaR+9MuYaVsvsghbiVjEgeHTKGItbLfpzdlkiWI5DYIF8o61jcx0JWqsJjchrHMAWKQ53Hq1rZZJCg3X84IrfMMqN+6Lr3DE7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffNRKBhnvdptK6uvnYARjc5MP6wn25Kzi3nxgTcRbA0=;
 b=hVvUYCuj3D6zXW9yYeW40Rvb5GTtKPipbp+0ZmqK8UB81FfFGOEZftXl0gF8wXCpUzHhQb2W7YSafy1JT27Xp/l13qTioLwKWdzKHwbv+GXEJFuL2orzzkI5qQr7R5sIMUN5TBnVMp4tm9rtnQjpcPaQbvfD6djqnScI38imz1BDHBm47AKeJQ65EHljx36F1sevdi65c5UBZxfJNQFaPm7omIPbpUp8gD/tkIckbLfla4Uo2vrTAFwbiSpbS5sy/9t00iIG4gCxjXKDBdw+0nvB7rBmEt2PXRsDT8re1oc9K/DB1hG41gYZDMUVDU5RM/rq5UB124aA9aq5ttvYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffNRKBhnvdptK6uvnYARjc5MP6wn25Kzi3nxgTcRbA0=;
 b=gCU9c0bdXO57wyLsaRKbBCvbmVnWYRM8xvKcBLvOoKoJ4JLHa61WMD3LrcO02EPDnI0buc4/CBHTfOWB6AQLkomFlYNOSpY996sAPc9PgjVOfhjplCyTzsGZ1chW4iY4GcbvkHUyttCpMJPEwGZmn5MdlrmBO0XdRMjgukTWpz1HU+3RrdQSdYPFep2vmM04qHin49hZP1vjMdIBrnzCZfMlVw6tgOMTYUMIBkfe73S2EMqEpJjVVBvqYFcK1SpACZFKm2yoVek2LeXHW1TJVQXKUvnREFJAS497bD33eRa+73cSw2svRkqwoEZoeq4Hx0Oogv+63EO3m7AhjfgTJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYZPR03MB8214.apcprd03.prod.outlook.com (2603:1096:405:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 09:46:39 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::e1e:5c95:a889:828e%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 09:46:39 +0000
Message-ID: <494c1e2c-9acb-4190-870a-4541c7a285d7@amlogic.com>
Date: Tue, 30 Sep 2025 17:46:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] dt-bindings: clock: Add Amlogic A5 peripherals
 clock controller
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
 <20250930-a4_a5_add_clock_driver-v1-14-a9acf7951589@amlogic.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-14-a9acf7951589@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYZPR03MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 577e5301-cfde-4ef6-24eb-08de000640c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnoyVEk0a2x6ZmNoRmxCSmtOWjROdkdtL250VlNGd3FITkI2VlpkK0hhZS9r?=
 =?utf-8?B?SUN1RG1zTHd1YTFkYXhGVWZ4c1R4TjBZb2x6TWtQdWxLZm0vVGhCOEowUmNJ?=
 =?utf-8?B?cTJxQ0IzWkxSeERlWUlFUjFTNGNkM29jSHdiM3JiUlJ5UzA3NE5CamZ0clJr?=
 =?utf-8?B?OEpUN0srcHoxNjdWeXFpZzJCM05JTXJORElEaHFlelVQZG5XQURHVzhlWGlt?=
 =?utf-8?B?b2hrY0VkeDZybWExRlNUaHdGSHFrRnFiZUcxUmpIdDVxNndmWFErUjZiSzlX?=
 =?utf-8?B?NVo0ZEhGOUd0bU9XeFVaeE1FK1hXUlhCZzJMYXRxMmkwUDBPbU82UlR2OTkx?=
 =?utf-8?B?c0FGU0JlY3gwa0RqY212RStNUmh6dVpweHZuSEdOWkwwa1dpTjJqVDVJTGNh?=
 =?utf-8?B?cUtCZ3ZXbVd1UStlK01STTZoRnhaN05pWTltUldWbDYyb0Vlb2J2ZGxNMU1t?=
 =?utf-8?B?V3FzL0RJUVhaRmFKNU1DR1JiSTgxSW81M1FyMVZoNG0weG53QWxZT0ZEMlN1?=
 =?utf-8?B?TXY2dENua3B2R0JYVUJVazY0MWtpdWhYWXR4LzAybTlKWUFYbWNuYy9lMFBW?=
 =?utf-8?B?dnNBNDdQZ01sekRaQXpLN3NiS1pJNkZCdEE4b05LTUN2SjNPd3cvc21OQTBm?=
 =?utf-8?B?UVFXTy9UMHlLNTVZSFJYY3N6ek9RRmxVVGhudlRxTE1RbDE5dHdZVEFCRjRV?=
 =?utf-8?B?Sk5wbmRwbkduVWJZWDNGTU5UejVaVXZWdm80aDI1SFZUUmxOaklZczRDL1Jm?=
 =?utf-8?B?U1liUmFuY052cmlvQ0NqaDVDR2dBdlBlYjUzK1o4SFhFTGN1KzE1c09hUkdH?=
 =?utf-8?B?R0RHbGxzcnU4R05EUGFrTFdYRTc5cXhGVVltTGxlSUU0QUJ3QzlsTit4UmhX?=
 =?utf-8?B?MzlSZFR4MHNxYms1SDVMOEhzVzNuR0twMnZ4anZBWnVub2FWOGExQkJnTGpx?=
 =?utf-8?B?bnE5V3BWQ3IzWFZyVXhuYXpINXZXbUJuMmtWZGw3U2F0SE1mSXpuTmlHMExt?=
 =?utf-8?B?Sk1NOFc1c3ZUbFd2ZUJlbzBsUVBTKzJ2ZzJJNGNvbXF6M1VDRWNGNkpXaEZp?=
 =?utf-8?B?bk1jSEN5cWFKVFBDazhpOXNZK0xhU2JQQ2ZvenFmZkZ5V2JoaSsvL1ZLak5H?=
 =?utf-8?B?bU9TTXh5MUtGak9QakFvWUtOVFNTV05MWlhzZUsxSXdXZGloQVZ6OVlYYXFR?=
 =?utf-8?B?R3JaWkxpZnR3WDl4UXNwZmxuYmlJUDZhaVQ5ZXB6OVQwTExXQXlJd05lRWla?=
 =?utf-8?B?Nms1cVJLZHFyVFFodVVjTDcrYjBkVUd0VkR4NyttcG5iUWQ1UXBjRVVGK21y?=
 =?utf-8?B?QTVHWUVva09rVWNoaXRoQnhZV3ZRZkh6QTVmNHFIWFdQVWNRVHl5cktLM3lJ?=
 =?utf-8?B?U3JaSTlxd0dsd2N3WnhiSEd6QVdubXI5a0dTbDIzRk85NUl4eUk1NUEyWVRY?=
 =?utf-8?B?VjV5NXplS2NyUGw5eFhCeTFJdnFrYitITDR1ZEs3elcxd1RSZDd0M205dXNW?=
 =?utf-8?B?c0hJaUFYdEJCZkJaMUVrcFJPOGlVQnlQNGJLdUFaNi9sZ2NIbUFnUkpyZTha?=
 =?utf-8?B?VmhJdERKR1UyUWNjUFVKbkwwM0tXRGVINDBUOUtSc3ZWRkNLcnFqU3NIdHRm?=
 =?utf-8?B?RmJONTd4M3N5RjNGUXc1YjB3Tm9Sbi9yYzdraHd3aTJNb04zaGM5NFhvWmlm?=
 =?utf-8?B?OWNaaU5ZMmVEd3VRTXJGcW9wbE5peW9GRlNNK3pJNXNuV2kxNVRyZW5ZZC8v?=
 =?utf-8?B?U08zMWVFV0E3N3dWblJVSTQ2ZUlhWnpXVkVRakhjSFBLdERvaFUvNFdENzFp?=
 =?utf-8?B?Y05CbVcvZldzSytzbUVJVVFlaUVtN3VrL0hWYUc3ZjJHZTVrVjZmV0Znd016?=
 =?utf-8?B?dmplVGdzTTdzbWV3Q3V3ZUorWXNQL09RSW5kVkdsK011Nnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2dicWhIYUo1UHlsNzJUZFRHY3Fnd0R3NU83N1lQU2grR2w5aWU3a08wUGM0?=
 =?utf-8?B?b0xYTlhLVHpVakJQemZ0eGpXWmVIUDVHcEx6ZVZnT1IvNm9IK0hUZGlla3N4?=
 =?utf-8?B?VXI5VnhFTXZxMitPaUI5UlEvWWx3a1crMkZjejFKbTJHNGFld3hBQTlkSy9H?=
 =?utf-8?B?SlZjd3BtaWNuSkRUZ0hWckZjQUJVMC9jSjFVTld3R3EzREZZaHJrbXdrTExZ?=
 =?utf-8?B?SGR2bURtdTQzODNDMUJZWnNiL1JSWEJWY3ZnT09rUzZpeWxnaDlwaitaaGc0?=
 =?utf-8?B?NmVLbFVBSUF1TWFJR1ozR2FFRlZRRndxL0tneWR5a1V4M1dKN2RlSG54OS9n?=
 =?utf-8?B?NzV3d25jVzVMSko2K3c4NUlSaVNyNldDekpNajNkYUFQR1Z6VWtFai9XS3Jn?=
 =?utf-8?B?ZDUvY3dTdUZpLzdGK0JrTS9xZlQvVmhZOENXaGtub1BBK0FMYi95NllMZ1ds?=
 =?utf-8?B?ZmRiUm5TWHpDOERhMWo1OHhqRWcwMXl6UTVqL05DOTZpUlNlYXlxeUFSVEc4?=
 =?utf-8?B?d1pXVlpSanZGeUtMRjRrOHdpbE5wZUo1dE5tR0l5S0FodjdiWm5qM0UzdG5v?=
 =?utf-8?B?WlJoeDlQeDUzSDJ4ZkZUZ0VjbGQzZHV1MG1vL0k1dU5vZHg4ZmNCdWpLUUpi?=
 =?utf-8?B?ZUVDd2xIMDMyYk85WmsyRmprV05zVk8xdmpQUUhEdHBCU1FVcGZFSEp2VkRx?=
 =?utf-8?B?UEw2dzNnVTdXblViQTF1ZmNkcnZtSzNkVmtxamNqODR0ZndhVnNDTUdLNFhF?=
 =?utf-8?B?ZWdiclB1Y0F4TzZtbW54ZnBtSEhnblh2UEd6YkF3d01ib2tCMUt1UEZzYTM4?=
 =?utf-8?B?SDBjdkk3UXlMbWN3QWVUTzBYRjNsK2tSQWNob1lMVTdCY0V6QmRCV2VjWmY3?=
 =?utf-8?B?Q1pZK2o2dnk3OEtFbUZRTzBCcUJEN2FqdXVPTTQxWWtNOEJrOGtDTFRkMW1j?=
 =?utf-8?B?VDVyangxejJrT2NmUVF5RzMzeFhPSVkzZGlqaU1YMDIxU0RrVjN2RkVNZi9r?=
 =?utf-8?B?ZnpWVndBT3ErQ2xSM0RvVTdaNlRBakl5UG44SmNhSzIrUjZRcjMremR3Zzls?=
 =?utf-8?B?MEppQlhwL09mTHErblJYNFFsKzFCaExNcGZrOUM1U0puRTZpc3BSM0FlM29t?=
 =?utf-8?B?aDgyRnZCM1FuanV3aW1ZNFQzOVhjOUFWVkx2dEF6UzdOaEJFOW9LRGNyNmtn?=
 =?utf-8?B?ckNOUDA5NW81NzBudFRTTjNGTk5YU3pSK2lNN3lTUUxJOWY3YmJJcW41dUZY?=
 =?utf-8?B?QUlRZzgydnAxTVZzSVh3OWdmTkdoOG13VG1VQklPaXNvQ010VDNiUGtpR1ZK?=
 =?utf-8?B?eGY2NWtFYmg5TWw3Y0Rpcks5YXdzNHcvQ1FQWGZFOUEzdVBBRHUrdHFiUy9l?=
 =?utf-8?B?SFVCRU1rTzhOc0FqSExPVUd5OHZrcFZWTWEva3JOZG1nQ3gwMW0reFZvL1B2?=
 =?utf-8?B?QUtUVDB6Q1VCWFVWL291QmZJUlNzcGI1dlNyNzdna3ZzUUNSNEFJeFpmeHB0?=
 =?utf-8?B?MlhsYno1SElzYzR4U20vdGoxaTAwd0JQbUxkYjd2L2FNN1VFamt0RWl4YVh4?=
 =?utf-8?B?QnFzM1VNOCt5VTN5T2ZaTmdSY2kyMUs5MXVJUE9USkdXcFFnTGpPZ0pzWjYw?=
 =?utf-8?B?aTVsZGVSaFQ2c1Z4NitnUlVOdURBOGpiK3llWVFraHhtVDNGMEJsZ2VOT0gy?=
 =?utf-8?B?V2N5eFFocldlVnIybURCRU15K0NDcDJtK284VU84cUFvTW9LNTcrZHFwNFhm?=
 =?utf-8?B?MlRoejJHSUpSbWdxMjJRWnV6S2IyMVN1MzRXYk51aXNpQ0M3NGVNdGFIYVkw?=
 =?utf-8?B?d2VsNE1lZ3BycGZKS2ZWNnRzVFlzU0g4OElISnVMTWpwNERhYVl5d3V5YkVo?=
 =?utf-8?B?bUREM0doU20wdDFmTVdzelBheUl2NG1MeG9odFo4VEdUemJma3BoVjkrUWo4?=
 =?utf-8?B?N1VXNnR6MVJPZmlhOGVTT1lTTzd6eW5TVnRZb0FVTlJWUkswN3lTdFI5REhS?=
 =?utf-8?B?WGZIUnF0blBFVnNOM0NKekZjbFlaOGIydGdxZzhTdTRwTGlpS2h6TitVZzcr?=
 =?utf-8?B?M1FSclYzaTNEcFdIamMxbnozWTBraU5kem9QVXl6RTlyNGZKRjdqRUY2bHpK?=
 =?utf-8?Q?F/9vAb5XQg0mUfIzCGkFHMHLL?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577e5301-cfde-4ef6-24eb-08de000640c8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 09:46:39.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLSMwUmMmjEbOtJ7WDOid4U+CJM0YRFSgJUQfzi3gOBdx4jWscpMG0xkE+dV0HJNlru8Yp0r6d4B7bQso0ZqKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8214

Hi Rob,


On 9/30/2025 5:37 PM, Chuan Liu via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
>
> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add the peripherals clock controller dt-bindings for the Amlogic A5
> SoC family.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Co-developed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>   .../clock/amlogic,a5-peripherals-clkc.yaml         | 134 +++++++++++++++++++++
>   .../clock/amlogic,a5-peripherals-clkc.h            | 132 ++++++++++++++++++++
>   2 files changed, 266 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
> new file mode 100644
> index 000000000000..88d71d9a72ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a5-peripherals-clkc.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,a5-peripherals-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic A5 series Peripheral Clock Controller
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +  - Chuan Liu <chuan.liu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a5-peripherals-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 18
> +    items:
> +      - description: input oscillator
> +      - description: input oscillators multiplexer
> +      - description: input fix pll
> +      - description: input fclk div 2
> +      - description: input fclk div 2p5
> +      - description: input fclk div 3
> +      - description: input fclk div 4
> +      - description: input fclk div 5
> +      - description: input fclk div 7
> +      - description: input mpll2
> +      - description: input mpll3
> +      - description: input gp0 pll
> +      - description: input gp1 pll
> +      - description: input hifi pll
> +      - description: input sys clk
> +      - description: input axi clk
> +      - description: input sys pll div 16
> +      - description: input cpu clk div 16
> +      - description: input pad clock for rtc clk (optional)
> +      - description: input ddr pll (optional)
> +      - description: input source from clk-measure (optional)
> +      - description: input rtc pll (optional)


Compared to the previous V3 version submitted by Xianwei, this update
adds an optional "rtc pll" clock source. Since the change is minor,
your "Reviewed-by" tag has been retained. I hope this doesn't cause
you too much trouble. If it doesn't make sense, please point it out.


> +
> +  clock-names:
> +    minItems: 18
> +    items:
> +      - const: xtal
> +      - const: oscin
> +      - const: fix
> +      - const: fdiv2
> +      - const: fdiv2p5
> +      - const: fdiv3
> +      - const: fdiv4
> +      - const: fdiv5
> +      - const: fdiv7
> +      - const: mpll2
> +      - const: mpll3
> +      - const: gp0
> +      - const: gp1
> +      - const: hifi
> +      - const: sysclk
> +      - const: axiclk
> +      - const: sysplldiv16
> +      - const: cpudiv16
> +      - const: pad_osc
> +      - const: ddr
> +      - const: clkmsr
> +      - const: rtc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a5-scmi-clkc.h>
> +    #include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@0 {
> +            compatible = "amlogic,a5-peripherals-clkc";
> +            reg = <0x0 0x0 0x0 0x224>;
> +            #clock-cells = <1>;
> +            clocks = <&xtal>,
> +                     <&scmi_clk CLKID_OSC>,
> +                     <&scmi_clk CLKID_FIXED_PLL>,
> +                     <&scmi_clk CLKID_FCLK_DIV2>,
> +                     <&scmi_clk CLKID_FCLK_DIV2P5>,
> +                     <&scmi_clk CLKID_FCLK_DIV3>,
> +                     <&scmi_clk CLKID_FCLK_DIV4>,
> +                     <&scmi_clk CLKID_FCLK_DIV5>,
> +                     <&scmi_clk CLKID_FCLK_DIV7>,
> +                     <&clkc_pll CLKID_MPLL2>,
> +                     <&clkc_pll CLKID_MPLL3>,
> +                     <&clkc_pll CLKID_GP0_PLL>,
> +                     <&scmi_clk CLKID_GP1_PLL>,
> +                     <&clkc_pll CLKID_HIFI_PLL>,
> +                     <&scmi_clk CLKID_SYS_CLK>,
> +                     <&scmi_clk CLKID_AXI_CLK>,
> +                     <&scmi_clk CLKID_SYS_PLL_DIV16>,
> +                     <&scmi_clk CLKID_CPU_CLK_DIV16>;
> +            clock-names = "xtal",
> +                          "oscin",
> +                          "fix",
> +                          "fdiv2",
> +                          "fdiv2p5",
> +                          "fdiv3",
> +                          "fdiv4",
> +                          "fdiv5",
> +                          "fdiv7",
> +                          "mpll2",
> +                          "mpll3",
> +                          "gp0",
> +                          "gp1",
> +                          "hifi",
> +                          "sysclk",
> +                          "axiclk",
> +                          "sysplldiv16",
> +                          "cpudiv16";
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
> new file mode 100644
> index 000000000000..b8a68b7f29dc
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,a5-peripherals-clkc.h
> @@ -0,0 +1,132 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> +/*
> + * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
> +#define _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H
> +
> +#define CLKID_RTC_DUALDIV_CLKIN                        0
> +#define CLKID_RTC_DUALDIV                      1
> +#define CLKID_RTC_DUALDIV_SEL                  2
> +#define CLKID_RTC_DUALDIV_CLKOUT               3
> +#define CLKID_RTC_CLK                          4
> +#define CLKID_SYS_RESET_CTRL                   5
> +#define CLKID_SYS_PWR_CTRL                     6
> +#define CLKID_SYS_PAD_CTRL                     7
> +#define CLKID_SYS_CTRL                         8
> +#define CLKID_SYS_TS_PLL                       9
> +#define CLKID_SYS_DEV_ARB                      10
> +#define CLKID_SYS_MAILBOX                      11
> +#define CLKID_SYS_JTAG_CTRL                    12
> +#define CLKID_SYS_IR_CTRL                      13
> +#define CLKID_SYS_MSR_CLK                      14
> +#define CLKID_SYS_ROM                          15
> +#define CLKID_SYS_CPU_ARB                      16
> +#define CLKID_SYS_RSA                          17
> +#define CLKID_SYS_SARADC                       18
> +#define CLKID_SYS_STARTUP                      19
> +#define CLKID_SYS_SECURE                       20
> +#define CLKID_SYS_SPIFC                                21
> +#define CLKID_SYS_DSPA                         22
> +#define CLKID_SYS_NNA                          23
> +#define CLKID_SYS_ETH_MAC                      24
> +#define CLKID_SYS_RAMA                         25
> +#define CLKID_SYS_RAMB                         26
> +#define CLKID_SYS_AUDIO_TOP                    27
> +#define CLKID_SYS_AUDIO_VAD                    28
> +#define CLKID_SYS_USB                          29
> +#define CLKID_SYS_SD_EMMC_A                    30
> +#define CLKID_SYS_SD_EMMC_C                    31
> +#define CLKID_SYS_PWM_AB                       32
> +#define CLKID_SYS_PWM_CD                       33
> +#define CLKID_SYS_PWM_EF                       34
> +#define CLKID_SYS_PWM_GH                       35
> +#define CLKID_SYS_SPICC_1                      36
> +#define CLKID_SYS_SPICC_0                      37
> +#define CLKID_SYS_UART_A                       38
> +#define CLKID_SYS_UART_B                       39
> +#define CLKID_SYS_UART_C                       40
> +#define CLKID_SYS_UART_D                       41
> +#define CLKID_SYS_UART_E                       42
> +#define CLKID_SYS_I2C_M_A                      43
> +#define CLKID_SYS_I2C_M_B                      44
> +#define CLKID_SYS_I2C_M_C                      45
> +#define CLKID_SYS_I2C_M_D                      46
> +#define CLKID_SYS_RTC                          47
> +#define CLKID_AXI_AUDIO_VAD                    48
> +#define CLKID_AXI_AUDIO_TOP                    49
> +#define CLKID_AXI_RAMB                         50
> +#define CLKID_AXI_RAMA                         51
> +#define CLKID_AXI_NNA                          52
> +#define CLKID_AXI_DEV1_DMC                     53
> +#define CLKID_AXI_DEV0_DMC                     54
> +#define CLKID_AXI_DSP_DMC                      55
> +#define CLKID_12_24M_IN                                56
> +#define CLKID_12M_24M                          57
> +#define CLKID_FCLK_25M_DIV                     58
> +#define CLKID_FCLK_25M                         59
> +#define CLKID_GEN_SEL                          60
> +#define CLKID_GEN_DIV                          61
> +#define CLKID_GEN                              62
> +#define CLKID_SARADC_SEL                       63
> +#define CLKID_SARADC_DIV                       64
> +#define CLKID_SARADC                           65
> +#define CLKID_PWM_A_SEL                                66
> +#define CLKID_PWM_A_DIV                                67
> +#define CLKID_PWM_A                            68
> +#define CLKID_PWM_B_SEL                                69
> +#define CLKID_PWM_B_DIV                                70
> +#define CLKID_PWM_B                            71
> +#define CLKID_PWM_C_SEL                                72
> +#define CLKID_PWM_C_DIV                                73
> +#define CLKID_PWM_C                            74
> +#define CLKID_PWM_D_SEL                                75
> +#define CLKID_PWM_D_DIV                                76
> +#define CLKID_PWM_D                            77
> +#define CLKID_PWM_E_SEL                                78
> +#define CLKID_PWM_E_DIV                                79
> +#define CLKID_PWM_E                            80
> +#define CLKID_PWM_F_SEL                                81
> +#define CLKID_PWM_F_DIV                                82
> +#define CLKID_PWM_F                            83
> +#define CLKID_PWM_G_SEL                                84
> +#define CLKID_PWM_G_DIV                                85
> +#define CLKID_PWM_G                            86
> +#define CLKID_PWM_H_SEL                                87
> +#define CLKID_PWM_H_DIV                                88
> +#define CLKID_PWM_H                            89
> +#define CLKID_SPICC_0_SEL                      90
> +#define CLKID_SPICC_0_DIV                      91
> +#define CLKID_SPICC_0                          92
> +#define CLKID_SPICC_1_SEL                      93
> +#define CLKID_SPICC_1_DIV                      94
> +#define CLKID_SPICC_1                          95
> +#define CLKID_SD_EMMC_A_SEL                    96
> +#define CLKID_SD_EMMC_A_DIV                    97
> +#define CLKID_SD_EMMC_A                                98
> +#define CLKID_SD_EMMC_C_SEL                    99
> +#define CLKID_SD_EMMC_C_DIV                    100
> +#define CLKID_SD_EMMC_C                                101
> +#define CLKID_TS_DIV                           102
> +#define CLKID_TS                               103
> +#define CLKID_ETH_125M_DIV                     104
> +#define CLKID_ETH_125M                         105
> +#define CLKID_ETH_RMII_DIV                     106
> +#define CLKID_ETH_RMII                         107
> +#define CLKID_DSPA_0_SEL                       108
> +#define CLKID_DSPA_0_DIV                       109
> +#define CLKID_DSPA_0                           110
> +#define CLKID_DSPA_1_SEL                       111
> +#define CLKID_DSPA_1_DIV                       112
> +#define CLKID_DSPA_1                           113
> +#define CLKID_DSPA                             114
> +#define CLKID_NNA_CORE_SEL                     115
> +#define CLKID_NNA_CORE_DIV                     116
> +#define CLKID_NNA_CORE                         117
> +#define CLKID_NNA_AXI_SEL                      118
> +#define CLKID_NNA_AXI_DIV                      119
> +#define CLKID_NNA_AXI                          120
> +
> +#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A5_PERIPHERALS_CLKC_H */
>
> --
> 2.42.0
>
>

