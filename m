Return-Path: <linux-kernel+bounces-890758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E6C40DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87103A9759
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A6261B99;
	Fri,  7 Nov 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="g3TytzeG"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022130.outbound.protection.outlook.com [52.101.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD8258CE7;
	Fri,  7 Nov 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532438; cv=fail; b=YAeQrhQL26cvGiZpIXTdKazii7Cv+F/qf80PogYnC126yQb13BwR+znQS7QFytqZXMgpnM9Ei3yYX4FfddNuN5V0GfJZY28Lq4Rz6THOr8D2nG/bENf1KAkIfTi5NblDzFTFhEm7qea1BPUVjSI9CLp6VSJY5oCml6AQQEGuJM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532438; c=relaxed/simple;
	bh=aEaOC9Drrr0Qasa7NtmKL3z7YJ2t+fU2FXKLpygtKDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXDu3xug0J0HClqTUAY1K032ciyDMcj1RQb7NJW4+cmFvhpvlDX80+8jPk8xTweg74E6HPGUaIt5Y1GvsvATedTYO4JQCHedUi3zzzSPG1ljUNGK99JnvTBLf42z4B6X3jdR8PmRnO+RTPtKCXspyR56S8jlMb+i+P8hwnX87Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=g3TytzeG; arc=fail smtp.client-ip=52.101.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNSavJYp+PpcYg9AWQRE5gnYSVbMLpHxtm/sIDJX9uKTspYqN6QQTCWTE9KhWCl+eXreCbqaJHKOPOGYDbPofxUTmzPk5q3JMLexDWrk6ipJUr8f9ARcSWPicsoPQD+Q/3hmeVwi5Id2RFLAewYb68sgLsAa8XHW0ZCGZ0CkVWCQ+bHbWYTvOGyua5ddMvfzoiGSsfGvQkIR3mhPBl2Q61OvhCBITzYvEkK92Oz11SrXQQunIAWyTaBUoQ2xUxw04YVvN6CNdxj8QRzUbFTtWhyhae+Kyk3qx0rL0mCIvoXefezrJfX4EOKF5vi95qRDSLkXYNWhs7MkMTL4H7u52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y13471qbTRUNnBppMM3NroIypPMTngKMmrh+DNU31k=;
 b=UZh2Rre+kKJXAM8zOxSBa+AJRQKSVx31rSHZTE/xSMwzU6/yvY3b3Chgduu0CaHgDuHCwkmO3dS9JdCe20yT/coRAsW7EgNglezP53T9O+Vjgb1DpBxVfLUY049HbxqtyZ+RTo/8hjHui3hmw6E6+16FXShvG9UsOWoC30MnWHfOQ7md9PNT+VTbGZll5m46UoCxtNAXGVMvd3dbhhQt29kRYX6iOa8VvwdT3slNngr1OlBapwi1HSMq4ymo7i5JH6dyJllXW7cqh3nGDhB7aRCA2l86PBqX+la2TlcyDXNdfyitZmB1beNGXxGVFWZHDfdiXwL7ViEUszQAUU0wLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y13471qbTRUNnBppMM3NroIypPMTngKMmrh+DNU31k=;
 b=g3TytzeGRlQmUqMzgoI7gB/pzc9z1OZxtMs6oZFA99D8Jljr58B0GTi50sqMN06Hpe47qgLvgqmvxNyRDXlYtORkhZSI3TI8q8FqwDC/T4Agpn9gLXSiXYQeX1JDF5AyIPwI/3oKAxkPfESfPemLHyOxJ+P3qBNpxTtelntPqKt1AvtuK6SL7B01LZoiGHxULSZrFURSGcKVj9iAoavSqHyzg2ZPY1SzHKOZDYSDeitO94GEjAQJHROBJ9asUDthIk2TpRdKyTZonMrgJ48FDsHYLJ5CsgXB6bTqHJNjggbPRLu9+qKL/yNIefjhVwBp2waNDhNb8JaKjMLLWv8FVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7149.apcprd03.prod.outlook.com (2603:1096:820:ca::7)
 by JH0PR03MB8147.apcprd03.prod.outlook.com (2603:1096:990:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Fri, 7 Nov
 2025 16:20:34 +0000
Received: from KL1PR03MB7149.apcprd03.prod.outlook.com
 ([fe80::a311:33f6:519d:73bf]) by KL1PR03MB7149.apcprd03.prod.outlook.com
 ([fe80::a311:33f6:519d:73bf%6]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 16:20:33 +0000
Message-ID: <236a568d-c809-4dc7-be2f-e813d0d85368@amlogic.com>
Date: Sat, 8 Nov 2025 00:20:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] clk: meson: t7: add t7 clock peripherals
 controller driver
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu
 <chuan.liu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, robh+dt <robh+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-amlogic <linux-amlogic@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20251030094345.2571222-1-jian.hu@amlogic.com>
 <20251030094345.2571222-6-jian.hu@amlogic.com>
 <1jbjlnxuug.fsf@starbuckisacylon.baylibre.com>
 <3b9a5978-aa02-486b-85f5-6443dc607dd5@amlogic.com>
 <1j1pmew1cu.fsf@starbuckisacylon.baylibre.com>
From: Jian Hu <jian.hu@amlogic.com>
In-Reply-To: <1j1pmew1cu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To KL1PR03MB7149.apcprd03.prod.outlook.com
 (2603:1096:820:ca::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7149:EE_|JH0PR03MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: a171c256-9e09-489e-756d-08de1e19934a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVwalhITTZSUmJNRmJTd1RzN0FJUTV6K2JiK1JGaEZrdy9xTHFvclZyZUYv?=
 =?utf-8?B?VXlpd2V3K25yQmFCd0M2Vk5OOVBNVmI2RHVJTEtxdnFxdnRQTVpWVktBcmZX?=
 =?utf-8?B?SUtlRThUTHBZOStMN2V2dTFOQnd6NUxpeFZQZWIvdXRBWUtOa2k2dngrSlFR?=
 =?utf-8?B?Y3JJbnZBR2EwcXNabTlWeUtSQ1JxY3VSenFUYyt6aUtBMm5BYno1bWM3RUZq?=
 =?utf-8?B?dnR3QWt5aGErU0kzS3NYOTBlbTFkR2cyYjF3Rk1mYkxLZjFqQ1JrZFI0NkF6?=
 =?utf-8?B?Yy9uVXdCWXovUUUrTUIzWjF4ZWJ3dXdUTzFsNnhLYTVyL1hxdllPS2oxY2RN?=
 =?utf-8?B?V2o5NXNiUThxUnl0eU02bkMwdlppWFhtVjVYSXdXSE5SaVJ1Y0R3cHB3Tk5Q?=
 =?utf-8?B?dS83MWFkbDdiYkNtVkNvSWlWMzBTUmFiNXpYS3AxV243TnZWdFhrMjdYS3dN?=
 =?utf-8?B?NUZKNmY0QmIzS2F1NXFUaUNHYUtIUjBoS3gyYUt2Zlg4STZneDFHcmtKVXk2?=
 =?utf-8?B?UUFUTjVVbWpPeTZIWjdtZ081Tkd4bE15MkR5OUludStwR2ZRUzU0Q09JSWdO?=
 =?utf-8?B?OWpZQUNaU0YzYU5NbDRXaEQwNXJQTGdoMURjMjAvd0Q3QUJNWGExSGxyU2cx?=
 =?utf-8?B?MFdRZ1ZpaWlISFRJSVN6cmp3YnVTRENNaVhZR0U1Q0loUys4RUJKdWdTRElx?=
 =?utf-8?B?THpxL2pXbURPRmhpUEJncVB5QklMSy9Jd1RRWmxHbEpnVGNnbm9vUVdQR2pF?=
 =?utf-8?B?d202WllsbUhFakkyd0dyb1BCQUFpN0p5YXZpOFhoaWJOQmFkZTh0YXEzZU84?=
 =?utf-8?B?TTlDSjJOV083YmRwbUQzMDB3MmQxay8xVEdzNkg5V3ZaVzZtOE42bUhlN29u?=
 =?utf-8?B?ZWQzQ0swaVUzamU5WkxoV3dNWlAxeHJsUVVFb0lVR25aaHVNd3hZeWEyQmpp?=
 =?utf-8?B?N2dIU3N1aVVlOGJjZXVNT3J1QjRZRUxIZDhjV29tRXBFYmFZNTQvUVNPdlk3?=
 =?utf-8?B?bWN3dEp5SGd0YUpRNVpHY1ZaREd3alByc3NsWHlBSG5YNVJWS1E5Szh1a2Vn?=
 =?utf-8?B?LzJ6elFKbTRFNTVnV2JEdTZRL0kzci8yVGRZRTQwalVreUd3c25VbDBpbWJF?=
 =?utf-8?B?TEVxN2ZORFdiRGhBSS82dk5GbFJNamNpVEJRd0tPNmJSTmUyMVNYR2JYTmw1?=
 =?utf-8?B?QnFtM29ldzFpcDg0ZHB6Y2UvMU9Gdjk5Q1VHc25VZGtHeUUvQlp3VTMxMjdz?=
 =?utf-8?B?Z0FpZGkwWHA0M2NtellvK2VndzU3RDhmMXpLZVR3dWRhL21WZUJpdHZRS2pH?=
 =?utf-8?B?SUQvTjUxZlNJbEhtbk4zNXcrZVB4WktCakRucitweFgrY2hUMXE2QjQyOHpn?=
 =?utf-8?B?ZGF3YVg5UE1PQy9PY1RiS29FTXJQNGc3Mk1PMU1uRHE0SS9KOE5GcTZDS1Rz?=
 =?utf-8?B?emYzQ3VnbGpZdWUvb3ZuM09VNFlpMTlKQWtWNlBJK2wyZDY3bjZxRDZSbGxZ?=
 =?utf-8?B?aUtWUHFvS2lEZ0NKSm9ETDg1RzVhcE8wYW92VGxlVFkrZkJXbWtuR3p6Szdl?=
 =?utf-8?B?V25VR0ZWUDh3Zm0zVW5hK2FKajhmTmhiV25oRTdRZXdHMEhyZVVFaVVRYjdL?=
 =?utf-8?B?UTJYM2ZxNmNLQlpIbXl1d3EwSFlQa2FpVHVrK2d4dk52bFZkZzM4cklhNDdS?=
 =?utf-8?B?TUtlVUJCakFZdndvSGg2czAyMXVYNzVnUGZueW1CdktwVGpLb3l3SnExS2hr?=
 =?utf-8?B?VUxCdnp1TnhQdFg3OWszUGlwdG9xbHBOYVlOdFMwWDNXL1FDRHl0bm45bGFj?=
 =?utf-8?B?ckZDaG10SVhkTlhBd2g0V0FubS9sWHUvczd3VFlpV3ROYzF2VTl5dUpiSWZN?=
 =?utf-8?B?MkNRd2pVTFFzYU5tKytXdDZkZWlJS1VYWmFvbG56NDl0eW5GUFdEdWpSOHZH?=
 =?utf-8?Q?cRpMTTlcqnioY1jwY1ORIAXdFqEg7onn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7149.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE1iREVXMG9UbitNWkNGN0J5b3Zld0crNHdNeHNkemVZR2RxbjRRVWRpNmZq?=
 =?utf-8?B?WTRtQmUzMUJrUHBVQ1ZYMEVoZGNLTXBXMEhuTGtoRmJoVkFDK0VoNS9oQUlJ?=
 =?utf-8?B?RFlkR2xJcDhWMURheTIzMzgzZWg4SlQ3NjUzYlkyQXVVZzBuTWg1YW96OWZJ?=
 =?utf-8?B?NWd2Y1gwZURKekt3S0h2WW1VV1VOZUlpSWR1SEZ6bG9haXptWms5T2twL1lM?=
 =?utf-8?B?L01YbHF0Ry9TTXNmZmZybmp2Y1F0L1FJSDJTems1cEdEeFQ1K1RxUW1YbG5v?=
 =?utf-8?B?NWcyV3VQbS84V0VFS0FJODRWYXZ1alZPNGZDSmZubGthU211UEFqOVpuTnJq?=
 =?utf-8?B?VFA3RE5XSXBENUV5bVF2ZlV2VytobUI0NEJrVnVCTkRQQmRVcjdYcytaYm11?=
 =?utf-8?B?NGFxK1c3M1dpclBtR0YzZ1pkU2pobHUxU2FyRmZqZ01kUXBvRXBuQWNJTmsy?=
 =?utf-8?B?WDdKRjltZTF5S0thMFNXMHFTRThUMVV1Z2NWK2FZcG1RYndhOUxvOCtTZEZR?=
 =?utf-8?B?SHdJaThDYmRrNXZrdEtmS2JIZ1lrSW1tZHkxVkk4TDE4T0ttbnUrWHF4NG1n?=
 =?utf-8?B?RUdJSG84clJrdTNKYjIwZW1aWHQvR1NKclA4T2pTY29JbkladmJZZVNZYmpF?=
 =?utf-8?B?TmJsemV3T01YVHY5a1FzNU45VGM3TFVrdGlZTDNVdURaTEdBZ1czNWZFM0xX?=
 =?utf-8?B?RVIvUGFzbjNUVFRLTU50REgrR3JNNlRWbHRINWcyUU1YOEg0eHpMZHRJMFZR?=
 =?utf-8?B?Q003OVZINTdiK09ZTUtLRVpqTERXemJhbytEUmJ1VUpWTC9JYkMvWVhYTkRH?=
 =?utf-8?B?aTZ5eWF5b1FIMlhESHRGV29DUTd0eGxRSkV0c3MzUHJFYnZaUXVQRUV6eWF6?=
 =?utf-8?B?dUNvdkpySnhUUVMvMlNqU3BXUUNFUTVKM3ljdnlUYWE5M1ZZOE9MOXlGVEl6?=
 =?utf-8?B?Qmc5WWEwUWlIZkk1ZHpRdVNsdkVxU1FiRC82QUZWcFkzaysvYXRVb3JNRHI3?=
 =?utf-8?B?SGM0TElMOXV1aTJnWEtHZHZLTnlyTHJxSlVWS2FEZlRVanV4ZFk5M2N4T1Mw?=
 =?utf-8?B?dkpTREI0Y2ZDUEdNYW9ZS09EaG5FNVN4QytsVjNhQWg1V2M0YmFyMEEyNmhM?=
 =?utf-8?B?NDhhQzBNMkxhdmdIbCtmVVJ0TGtlS1haNHh3dWJMOTFEYjJZR2ZPdmlMNndN?=
 =?utf-8?B?ejNtamRuTjQvSGVxNlAxYkQ5Mzd4Z29FbUZVcDlnc21TNzFQcHVZV3hhVVBT?=
 =?utf-8?B?eGJRSVdQYkZ6ZmJWcTRDZ2huVEFUMWlJakNidGZJRzdEcW12UHJJdWphdW94?=
 =?utf-8?B?NG9reklUTHlNZUJDaVdodU5IOUhIRjBDVmd3V0pUbkFUbVJpSFVWTk16Sk1p?=
 =?utf-8?B?bjNkMmo2Yk1CTU5TV1ZidVkyQmVDeG80ZENiWXozbTNMRFFhYTNYNUdXK2JW?=
 =?utf-8?B?VkcrZm80dHlreno5UXd3d0JqVUN1TVdmUEpSUnR4ZVBqcW4yMmRSemowYUlt?=
 =?utf-8?B?bmZWdnh6eUN1YmRPanJkVnNUMDAwT1JrcW9xYmJOY0V6ZGVvbzFQZVZYRkNO?=
 =?utf-8?B?dVZ0aFJHYnlObW0wY0FTa1YvN0ZGa1RiWXM4UUlZVUZoSlVtbHIwek1VWDRi?=
 =?utf-8?B?ZTRZZ0pya0phbitsUDFudU10RjdjMVlVdjQvY3pLd1UrY3lWa1MwbHYvTW1I?=
 =?utf-8?B?S25IOERUOXNGOXp6czEwRG1Sb1VIZWRhZHhyMmFGZWdPRERnYkdqYnhvT3Rk?=
 =?utf-8?B?dlduTmt0WUtaYUhKTEZLeERaNW5qWXF5UmNXOHhoT2NZckY1VHhTc1FmWW81?=
 =?utf-8?B?Wm9jTkFRZzFoL1NNNU5XMGZNWlN6cXNUcXZNUXZNRkNzV3VyZWlsWVppY2E4?=
 =?utf-8?B?RTZJeXhtYi9UR1g1aDRPNElTcTQySjFQVmZLTi8yWGloYU5FQkd4bGtHSUxR?=
 =?utf-8?B?YUhWOUNLSGRzcEhFdXpjY3lBT0ZVTTlONXRkeHNDTG9JMjlUbGZOMFNFd2tN?=
 =?utf-8?B?d0tVdTBHdXdmSm9Md3E2WGlYQlczNXdwYVNhWUFrU0NnNXIwcGFHUUI2UVo2?=
 =?utf-8?B?SmJESCtpRGw3bVJhVTJaektNZ2tlUUlXa2ZUZDhiZi9CZCtGYnhESUVuSFVH?=
 =?utf-8?B?YXhOYmkrdkc1a1IzdFl4UnNXTXJ3OTNVWWloSmYvMUVheDYrV29hM3M4ZGtz?=
 =?utf-8?Q?zejCWXunw1JaRudsEMs8spFbD0oily1iUHIZKZJ8S9iB?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a171c256-9e09-489e-756d-08de1e19934a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7149.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:20:32.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg221Lc3G6rGYulgIYLTh72CMZn6Qij7fx6Uc983ZDoIBn+vtA0Y4lkSRDfgfM1lqcuOV5OJ1Dc7ejH1seM5Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8147


On 11/4/2025 6:14 PM, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Tue 04 Nov 2025 at 17:17, Jian Hu <jian.hu@amlogic.com> wrote:
>
>>>> +
>>>> +static struct clk_regmap t7_dspa = {
>>>> +     .data = &(struct clk_regmap_mux_data){
>>>> +             .offset = DSPA_CLK_CTRL0,
>>>> +             .mask = 0x1,
>>>> +             .shift = 15,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data){
>>>> +             .name = "dspa",
>>>> +             .ops = &clk_regmap_mux_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &t7_dspa_a.hw,
>>>> +                     &t7_dspa_b.hw,
>>>> +             },
>>>> +             .num_parents = 2,
>>>> +             .flags = CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
>>>> +
>>>> ......
>>>> +
>>>> +static struct clk_regmap t7_anakin_0 = {
>>> Nitpick: for the DSP it was a/b, here it is 0/1
>>> Could you pick one way or the other and stick to it ?
>>
>> ok , I will use 0/1 for DSP.
> I think I prefer a/b if you don't mind. see below for why ...


Mali is named as mali_0, mali_1 in this driver.   And G12A/S4/GXBB 
series do the same.

If they are named as anakin_a and anakin_b here, there will be two 
naming methods.

Shall we keep consistent ?


If use 0/1 to name them.

dsp clocks are:

     dspa_0_sel

     dspa_0_div

     dspa_0

     dspa_1_sel

     dspa_1_div

     dspa_1

     dspb_0_sel

     dspb_0_div

     dspb_0

     dspb_1_sel

     dspb_1_div

     dspb_1


anakin clocks are:

     anakin_0_sel

     anakin_0_div

     anakin_0

     anakin_1_sel

     anakin_1_div

     anakin_1

     anakin_01_sel

     anakin


If use a/b to name them.

dsp clocks are:

     dspa_a_sel

     dspa_a_div

     dspa_a

     dspa_b_sel

     dspa_b_div

     dspa_b

     dspb_a_sel

     dspb_a_div

     dspb_a

     dspb_b_sel

     dspb_b_div

     dspb_b


anakin clocks are:

     anakin_a_sel

     anakin_a_div

     anakin_a

     anakin_b_sel

     anakin_b_div

     anakin_b

     anakin_ab_sel

     anakin


Which one is better?

>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANAKIN_CLK_CTRL,
>>>> +             .bit_idx = 8,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "anakin_0",
>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) { &t7_anakin_0_div.hw },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>>>> +     },
>>>> +};
> [...]
>
>>>> +
>>>> +static struct clk_regmap t7_anakin_clk = {
>>>> +     .data = &(struct clk_regmap_gate_data){
>>>> +             .offset = ANAKIN_CLK_CTRL,
>>>> +             .bit_idx = 30,
>>>> +     },
>>>> +     .hw.init = &(struct clk_init_data) {
>>>> +             .name = "anakin_clk",
>>> Again, not a great name, especially considering the one above.
>>> Is this really really how the doc refers to these 2 clocks ?
>>
>> bit30 gate clock is after bit31 mux clock,  and the gate clock is the final
>> output clock, it is used to gate anakin clock.
>>
>> I will rename bit31 as anakin_pre, rename bit30 as anakin.
> Ok for the last element
>
> ... but I don't  like "_pre" for a mux selecting one the 2 glitch free
> path. It does not help understanding the tree.
>
> For such mux, when it is not the last element, I would suggest
> "_ab_sel" ... at least it is clear what it does so, "anakin_ab_sel" ?
>

ok, anakin_ab_sel and anakin for these two clocks.


Maybe anakin_01_sel and anakin for these two clocks, if you agree to 0/1 
naming convention.

>>>> +             .ops = &clk_regmap_gate_ops,
>>>> +             .parent_hws = (const struct clk_hw *[]) {
>>>> +                     &t7_anakin.hw
>>>> +             },
>>>> +             .num_parents = 1,
>>>> +             .flags = CLK_SET_RATE_PARENT
>>>> +     },
>>>> +};
>>>> +

