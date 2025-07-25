Return-Path: <linux-kernel+bounces-745279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F799B117D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B91587251
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2895F2417DE;
	Fri, 25 Jul 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NQ0FD+od"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011003.outbound.protection.outlook.com [40.107.130.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F023D287
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420384; cv=fail; b=Mzr92SUnrUFrTbmMENOu15c1XoOoQHoWrt6Sk4JtEqkmDTz0XtR9Wv3XYJuUtZscROSsnmcSASj+kEAprNDO5BCmkLrCsgeIeogGy0ysYax4BHxfHSRwosHFH6Nlkr0KWfwRtb8lh0w7rMPQA81R+k7D7PTC+PZuHcNzj8X+wUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420384; c=relaxed/simple;
	bh=FbZpw+pesoEqLsAUR6RQdsnFaYOQ6tNkdM04jJnhx8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVoJypN94vihY0wnfVFeiYSQoOOTourEzp1OesIYeETexBH54uIieTViERGQgcI9jwvDDvqqbfCGe6LE+f16JIIcMdQmgWNs/M5/5juATZIJFVgt2K2CLEUR60NBYS5xi2AR8JHmona0Kzhqjh5PXfVZk1CLiJ3ZaIXrBhHgsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NQ0FD+od; arc=fail smtp.client-ip=40.107.130.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9OFpdswF3cKU+Q0ZVoOU8Wz1SsKoRwD6Mql6d4Zoteldm9BnLW90VBRbs3P/QS5ti/gAi9bR60cHeHTYr0vYnzFZVq3od4UfGVpbROLq0upM5aSZJFo3d22rfCDKYbVps/HbRqqxzAgNVgr3qsEOgFFExkvCXribnfuVnnPOXmLI7yRFGPxPTAu+VNT3k8V8F8I7aCJDIuTWo/ypA3GpzFMlKlcP7mpTzM1UIZG9FREfrT7E43MnZ+BN/k9O550OekJSxl/81u8eDG3gM64TPme17uaPIOEdAp97D7zpnRldSuQZ/r+oEnGBEtIdk4T/J986PYwO30RN4TW31LYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G28pCr1ULh25lPB/864FnH3U2Q0Ms9n0vc2j9nuLox0=;
 b=dOfFcmXvVa+fNroo+GHOmMRgxoltW8USn/yMDPRR+vHhPyN9yU0TOSwgYLX0glZK/o/fk4dft8Awx1zrfNrYrjj6QG0cGp9SFEJw+k6vyDzoBbdpMfjp0gu7/w9c33TVAVALp0ZNTXqh2BcBxVz6RKHJkVVs61ADc6C7ClDvOwfgMM2PI6F6kmZbTGZJG/RbZlOAgbB0PAlm7QWkS9XWiNX7oPPTVb3CMbhhFtptTdM6srcLgfFrhXw5lpLok2QYjDbpc8LzLzH8WwwMvL7sFnXBd6sxOJ1Yi2c8fHp2+fxmU4O77vaHKYmiGs8ZTonty1AP9n7Krespf8gSCU7x1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G28pCr1ULh25lPB/864FnH3U2Q0Ms9n0vc2j9nuLox0=;
 b=NQ0FD+odchqHmJ1zG0rtFakKH43a6TYvtwySKgKlz4hAlys9FJOyyO6mtbVkuXVf3gbWtyMS1++jgugdTOlpGHJMRRKkgJz2TsRGMt5T33W6XuyuQXkoCUulCrOJ6Uoh9vRapO/IMsJ4rANWujurQHR4Y3nbyGrF5wv/aA5qiLERmJJZqv5YjJEul19FFuz8Lflt7lbkKF1a2KXJC5TFjCQdc1HUGeyvp7Hcx9cqFymAUjJq07FYhCrXnHVjAXQCyL412s5yFIPjkQx4qvjO2ClzVHYREez5GFm2lcFEQPMcjVfHAAlpFyPRZGYHfIeRelYXP9G1NG8GRJG8JnIthw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 05:12:59 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%3]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 05:12:59 +0000
Message-ID: <0ab8b56e-9399-48c2-b107-5821c905ca4b@oss.nxp.com>
Date: Fri, 25 Jul 2025 08:12:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] clocksource/drivers/vf-pit: Use the node name for
 the interrupt and timer names
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-12-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250705160129.3688026-12-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0017.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::11) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3092b7e3-6e6c-420c-7dd6-08ddcb39ebde
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVlUktUZDRtU1A3UmZmdys1d1dBNEw1c2VVQW00T0ZIU1hINUgvTFJ6SXFa?=
 =?utf-8?B?RDQzaU9aNUVtVEVuZHBPVDFpWExzWTM4Qk4ySC9SY21iTFh6czR6bWFadi9v?=
 =?utf-8?B?SWxRNXh4RXo5QzB0OXNBZ2FteGZmWHZVMUJFak9rYXVWMUFlU0NIZE8xdGE0?=
 =?utf-8?B?T2krYWpPbWRyQ3BzandmZDJad0Nia1Y4SkNGS29wSkgyYmRzOFRyRVFRTHhU?=
 =?utf-8?B?RGdnZyttRUxsQnVUSWFYRmw4eEdhUm55WVhQb2ovSWVjbnpVbG1JaUNoYUxR?=
 =?utf-8?B?NitaZHZCSk9uMzJ6alFpNkpIVGlzNWErRkJlOWFiSTNpR2tHWU5peTBwTEpS?=
 =?utf-8?B?Y2dhVE9iaXpjbTFYQkxxaUZ6YmtVaFpmWDl4V2JlanpCTldSV2lRalhXQTIv?=
 =?utf-8?B?VnRVcUpoa0plbVJ5bUM0TnhGOU1rdFlRN0xnRlJpTFNyemUzYk43OVpOcnVi?=
 =?utf-8?B?V0ZsK2c1M2RvdUgyeWFIVnZnVVdHZ3V4bzByMHFlTUhlRXJmTXdtcHhVQmRj?=
 =?utf-8?B?Z05jYjBKSVVaY2xIRENMem9IekI0UlNxTnN2Q05jU08zR1ZSUFIvc3VpeFQx?=
 =?utf-8?B?b1hCbUg0OWxoSkFOSlJVd3ZPbXJmaCtvbVlSU0swWnR0QVVCZUJ2bi9Cd1VB?=
 =?utf-8?B?aDlnYTZtdXpwUXZBQzNxOVFUNGQrZ1FXclh2RXNtRjUxZXQrdXJpRzFaOC95?=
 =?utf-8?B?NE5IQ25HUVNjYXozQ2pFVTNtWjU4VEQwcS9HVERYbHNMdWRzWnd4RmlGK1NF?=
 =?utf-8?B?clNabzdEM3E1K1Q1RHpaeFJnUnlScDJvZ3BWUnh4VTVtbFpYTHh6NGZiVzhC?=
 =?utf-8?B?RmJUc2VhYnB3bEV3b2ltYW1sODl0WFFsVDRaRkhITm1YWk5HZzVKODRhT0tv?=
 =?utf-8?B?TG9Ud0E2MDRZYnlKTVI0WjNpOG1PRHlGZ2VZQys3NU9wa3lRdXU1TnRRMkdt?=
 =?utf-8?B?TW9JUWxjenFlLzFjbXJZYnlKSE14aGk1bkVLVlh1MFR1QS90emJhTmVmYnlW?=
 =?utf-8?B?aER6ZTl5eEhhUy82Q2xBdGVDRTB6YWlSY0Q5Y2hCc0pkZEdCTGc0VENvdWFo?=
 =?utf-8?B?Wm1Va0RQWlNnWlpnTGRkNGFmNGRES0hIeng0WTZlMEV3aXZpNXFDRkhzbUNL?=
 =?utf-8?B?WDYwQVo1S2hGSmJ1M01iUzQ1V1J4empURHZlRlQ2TkhlRWhTV3FFOE5xSUhl?=
 =?utf-8?B?RFNqc2RWU2lDb2YzU0pKMm5nd25WMDVqeTBhanB1S1U4NmZpYlRJVG41dVY0?=
 =?utf-8?B?Zk5zYmVockliRmMzc1pRL3pZRGgxWXhHSXI3VUVYV1ZFbFU5enZSOFJ0d2pG?=
 =?utf-8?B?eWtZajN2elc2cE0vMSsyazF4UkhqbnE2dHBrYm4zbEZ0QWdOUVFtSGd1bzBN?=
 =?utf-8?B?OTErZVRFc3VKVGw4b0lGMTMzQnJUcVhIZjlHMnpzTDRaYWZGMlpaTERqYzJP?=
 =?utf-8?B?K01CN0wrcnRUNzh3aXkzVWZXc1dnUFZBUDdpcXdWalNVdUMzOVAzbXh5TVhX?=
 =?utf-8?B?REFpT0gwL2tXa1hkRHM0UGFKWU9KQkhTNmMxYVQ3QjZTMTRHemhsTHhiWTBz?=
 =?utf-8?B?dWV3OVR3eUlHaUV2cjlSZGpnRWNKMG12c3hjUDNZMHFqeVZqZDZEOXNRcGgw?=
 =?utf-8?B?S1N0cXNleUJXbFJYQXQ1VDNzeDZzejZhekJhL3JtNTBka2YwQnRJY2RaK1Vz?=
 =?utf-8?B?NWRRUjMzQWZnVlBUNlI5bk93eE8wT3NLZnBiTWVwUENMVWNXVGtEYjAwemhY?=
 =?utf-8?B?d1A0dFhKbE9qdTZpMWFYZWRQQWV3L3ZFazR1UXMwdjdURDlnZTRFL09RcDF5?=
 =?utf-8?B?L2F1TEJjdWhXUHdQbXNUbU1TZzhLSVZWVENBbFRTeFhEM2dtc1loTGV6U1gv?=
 =?utf-8?B?V0F2THpjTDZmRk9yTDA1RlRkdXNRMVlzTVFPTnVpc3RqandZbWdVeC8wTnh2?=
 =?utf-8?Q?EY4504Bp+Ck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE94S2NPTHFRUnBMMGtVVDI3Rit0TmZtalA4cVVIVW1vSmd0VmxtK2k3M2Jo?=
 =?utf-8?B?eFJFSmFCMVMwK0JmNnhaa1lVWjBvZFZSR3k2cWk1UjFyOExMMGdHalJxa2VP?=
 =?utf-8?B?VkVOK1FDTk1rZWtsL3h5dE5iNTM2a1RQeHVCa0hFQk5nMzRJMFgvU28veGl2?=
 =?utf-8?B?c0FCS01rTUMyRXM2NGFMcTlRRFhYR01pYndtcGVQcjRGOTdqakNDLzJXTE9Z?=
 =?utf-8?B?NGVhWUR1MTBMdkZLYVVIcmRmaTI2d29aM2hJV3MvR0h6R3lWL1dURC8weHRP?=
 =?utf-8?B?SWc0VmNkZXNaODZTL1dWRjhyQ1gzSkZUTk1mUW5MSTFiSWhIcllZUHJ5ZFN2?=
 =?utf-8?B?VkJ4a2plSVhHRUtCaXdGVGtOTC9RWWpIc2RtbGhPTG02bG93R3J0RS9oQlcx?=
 =?utf-8?B?d2hsTmpJQ1BCdzF4dThNdFF4LzZ2SXZURWQya0FtN1ZFR2g1QVF0Vm53TStH?=
 =?utf-8?B?THl5MnB0Q3ptME5RVEFIOTlZclhkcS9IcWpVMDBZMzFsOFprMDJOMWl5dk40?=
 =?utf-8?B?VFYwTGpyQ0wzei8xUi9XZWVRMmRBYWkwVXFoV1Y0MFF6MFA3UEc1ODlwZ0Jp?=
 =?utf-8?B?WSszbWN5ekpGbVNiUjNWZTNMQTNnMnd4eTU4L3lJRWJxb1FscHF5RkczZUtT?=
 =?utf-8?B?MStnVk5WT3drMmsraDR6M212dTI0NlkvekNiR0d5ZGpCZHBySCt1TTJjZlA5?=
 =?utf-8?B?KzVQZ3ZtaVUwL2I1c0hHRG45N1UwbTdDTVQ4ZjV6TFNQdW1BYTVpVk1xYm5Z?=
 =?utf-8?B?cWZBYXF2S2s4MkFwWFdERXNhUDdDYzdob1RiTFFvRmtwK3R6aEk5UXYyWXlj?=
 =?utf-8?B?RUh5TEVYRWFUeWNhNUtaWDdMNHJMWTRVTy9HTGRycFpBT2U0UEg5OGhicmhE?=
 =?utf-8?B?TTRSZXpnRm8ycWdNcnowRUdpUE4vRXp1WnBxdlBtVTY0Vm9CLzVqM29ZeFJi?=
 =?utf-8?B?YlJDcWJpejBVRVhabFlmaFhNSzkvTGI4TE5LQ2p4SHNzdjRBN3NIYVJaWTJH?=
 =?utf-8?B?VXlzbTE5TVlGc1BjcW82MGFQcGdhVHJzVlR5d1dLV2c5Tmo4aEZRT3pDb3Av?=
 =?utf-8?B?NWZRY05kOUwxQmFZOTZTRkY3c0JFckRXRkRKaGZLSHZDbVpYS21XejA1K0l1?=
 =?utf-8?B?RHlQelo2ajRXaEp0UXBkR244VFpOL2N5azlST2VncGdzMHA4VktkQVhwUzVa?=
 =?utf-8?B?VFBHNEVtVzg4VG9jTmlWWHlVS0FRVEJlVE00VXZZeHhHbUNrOHFTOS9NdWRi?=
 =?utf-8?B?ZkQySk1maXFabUcyZTBhZEhQbm16bFRZSDAzMCs5OExqanhWNzh3QjI4dytt?=
 =?utf-8?B?MWppV3BJSEtkVUlWZEw1aE50aW9nZlprVUEzNWV6eWRwM0FQaWU3NE1WYU55?=
 =?utf-8?B?RzBzVXVVZlR6a29Rc1liNlpiREdZUVFQdEE2YlhjSWVqaFk2MkFvdHUzNk93?=
 =?utf-8?B?eUx6cGxOVG9XNTJCdU1GNVM4Wk9SdElBMXV3L3g1TzEvekZ5QTB5TVluSEph?=
 =?utf-8?B?eUZpQWpXOXZjQjJjK20zMVMzKzNoVjZJSzZ2b0c5VHpyOXlCVncwRFNaZG9s?=
 =?utf-8?B?L1R0ekZKdEZrY2tEaCsxR1MrYlVVK0VDWmZLZ2xna0lnYk8wTERBWG9Ob1RX?=
 =?utf-8?B?aElYb05lektvMXJLZXkxSHBpeDVQSFlocHZoSW8wT2MxSW8yRDlNUWhXc0du?=
 =?utf-8?B?TFIwT1lGYkRNeXZVa0ZONCtuQlo4ZUhnMXlYeUdDQXRWWWtLTzBXclVCS3lJ?=
 =?utf-8?B?WkNjeEcrS241MDFucDJOc3hhWWM3R1NyNW13Z3BaeWdVc2ljc1JkamttRUZU?=
 =?utf-8?B?VHdpNjBRMGJscUtUbmcyRHUzKzBQNkdqdjRaVnFiajYvbUN0QlYwVGVoaVdU?=
 =?utf-8?B?UC9tQVk1ODVQNHNLYkIxZlJmVkRpY1U5blNaYVl5eHI3QjM0WVl3RFFsWWky?=
 =?utf-8?B?NFBhZU1qMmwvWjRvSWZjZStjR2hIekZXSGFUYVAyNjl3QmtpQ3dFZ1B2ZkNZ?=
 =?utf-8?B?VlM1cWZ1bUhnZG5OQ29reXVQMXFTUm1vWS9vK0R3RVJ4Kzg5b3NIUzZMVHhv?=
 =?utf-8?B?aHZxR3ZlNHNuYW04WVFvTlVFbXpuamVRY0FUQ3NUcUk0R2M3dmJqUHhsVjBB?=
 =?utf-8?B?NVY1a0lMUXU3eGhNVDF6RmZucEZqRG1mSEVJMEZ3UXdHejA3Ym9QeDhqYVM4?=
 =?utf-8?Q?Z0E7pDs6kL7QDxkXDxcVBQk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3092b7e3-6e6c-420c-7dd6-08ddcb39ebde
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:12:58.9880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS6fRVxYUJy1G/rNCbhSMu2L9ZCjIt8YatiJ9ktqFRvx7w5qtiPJ0h+iH8Ep6qpwAtt9VlD0GAzdr7954t2+nSJhjeNy6QiFxD7ga9T40j0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808

On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
> In ordero to differentiate from userspace the pit timer given the
> device tree, let's use the node name for the interrupt and the timer
> names.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Typo in 'In ordero'

-- 
Regards,
Ghennadi

