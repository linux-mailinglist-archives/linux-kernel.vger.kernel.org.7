Return-Path: <linux-kernel+bounces-818381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35446B59100
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80AF173C38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD32882DB;
	Tue, 16 Sep 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="XVu65bUu"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B8286890;
	Tue, 16 Sep 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012092; cv=fail; b=EElMc08DgY/pF5ilywMzflVFU+bMa9zXtxbWnIAb+DjGLD+R1yrS53VFPMRnwHDpQGHiMvK9YMN4aIfXu3Fp/bY3XZ6tEOo7By93aNq4VmSSP77Q1b3ojE/H93ffeOtkmrvvGWkcmLOBhQFEEI4fl/JGe9gK0hdaIeeMP56t0vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012092; c=relaxed/simple;
	bh=MMaMQmAKqdN4vms6IN+TeIoEzRJJCTHOb/vxD+bc9V8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G2I6G9qagHYw0Sl6wZd2kYUO7EtKBNKIx3lKj7tEdlwjKVyqPnaibqYmNdDzmG2o9NIku76ZXDQ/fLdljCE2wwvUtmYwnXJx3r6x1WGxQq+iboNZLeIK577V8+ZSd2UiFqcYAzz/NjKJr6fcWaolucOk1OMJH2Xuvwbr1Bqh2o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=XVu65bUu; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQKP1BYvPU2cAsPWk+4NYP5/27k0ZrcOG3Ic17YUL6QAfhIK8vRp0S2QJMoQxe6yWY8tyEC22r812BNEJyVHo7eTXsUOt4TM6YwsBi0F3/RRRsg60ZlJxhE1JdFdGiT9RCEtlBKn12nKDR2P8n1jFE/iTQsraidQLp6vQLWQx/yAsaIVo5mUMGF9CqwLYi5N/IvQyakZCKJ1HAe3dt4PPLlwGIIjHUr4dfFQ6Reb+FWVDvh81rWGwjrPkCCKXozv7pMfPk94WaH0wbfpWEvao5U/zBEyJmN8WcTJdcmGUM4Qe7wI9UqNA+LdcZf2N9NWMoDs/9bUlf0COQuz21TRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFxo0izUIfUxeJ+7SMdpCQbiRKl9Z7O03hQP6sKrg1I=;
 b=yavLtoF5fNp/fkcAmzU9gmH6lOyO9OckY8DtVhY/OwRjSvaXs8S2bRbrskH44xmYOwcEQrji+brXvl/qjWHtAie4KLCq5o2HvZHckRpv6bEpZCQZGp9qosTroCiCoReFStPGxeS3eviedtPO+BbzCXTwapuJnlwq8WWZ7C+SFmEf57SheZX2yFfVlO9mZFAhg/sQYdt/TJqN+i2zT81tFt9m6cW+5CFCmAiXJQEMPVAEfT3fuNWtasxh1E8HflIKbnq9KxEt6geXTeDaQKeSRMt/Q0JMZpHFWHO+eRc3CYfYq2xjvBFuqfloOozlMaG+rUhWa2Bf/c9pDnm1m/Vixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFxo0izUIfUxeJ+7SMdpCQbiRKl9Z7O03hQP6sKrg1I=;
 b=XVu65bUup/QR+4sDbYI6/1U80PZ0oPdSiMZSe5MF77PJix9InoPcA8oaiPimqLkLBfl/B0ixGHrOTscNWUaN450zopZ0FENo36GEDE5OOsa3zeApE6awFERytHf8IB3BlsggXI8WM0rkV94pb1GWDAj0fSavX/3OA3ln+wN5gh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 08:41:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:41:25 +0000
Message-ID: <50379c05-c8b7-4858-98ff-da7ebdc06863@cherry.de>
Date: Tue, 16 Sep 2025 10:41:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: rockchip: Enable DisplayPort for rk3588-evb2
To: Chaoyi Chen <kernel@airkyi.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Robinson <pbrobinson@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250916080802.125-1-kernel@airkyi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250916080802.125-1-kernel@airkyi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:803:1::25) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2b73fb-f096-41b2-3b22-08ddf4fcd1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkhOUnoyQ24rY1Y5alI2eXh4S0NjWktXVDBRR0Rkb3R5ZTVwRHpEczdHeHN6?=
 =?utf-8?B?SVNxK1p3MVBHd04wOWpyVzJ3RENtVnppRytlelErdng4dS82TG5lc3pUYnBu?=
 =?utf-8?B?bTRkeG4vbDdQOTh0RU5mdHBzY3FLOGRpSDkzU1JEQVNma1czWGRtN2NzdWxC?=
 =?utf-8?B?ZFJsQjVvcXU4MGpaVTJjZkdvYUo1Q1Eyc01KekRSbUdhSWpNaGdXVENFQVF3?=
 =?utf-8?B?MjJWNmFQTHJNVUtMTjdjVWJBSkZaQ1FBR01DK0JockZWMDh1N3htbnEyWlRn?=
 =?utf-8?B?elhnaHNNdUg0OWliTjlwb0ppbC9oczhvZjcvZXUyU3l0YnZqdkh2QlpORWFT?=
 =?utf-8?B?TTg1TE9hUklNMjdQa0JjVDZrbzRBWGttOXV5RjRoeGt5bEN2UmZYWGdjcjk5?=
 =?utf-8?B?TTBOT1lYaDVMYkppWUZRK2NvVDhnTU5aeGJ0MjMvMjRQVEJlSEgzVFIrQzdr?=
 =?utf-8?B?TDFNaWpCSm1jcytNY3IvQWJONWJPZUFDOW9vTk9xdGQvbTFBYnZjNWsvdjBZ?=
 =?utf-8?B?WFhSYTF1b21pbHpjS3c1MmV5SnUrUnBQcjNzKzFkWUh6WmsrMnlWY1JsdzYx?=
 =?utf-8?B?NHZnbzZYQUI0YjJ2YVZWMElqd1ZYUzNVVDRPaFY0MmJIOTZkYy92bnhreDVX?=
 =?utf-8?B?THBBRDM3V1VXMGFreHlsNVpXU0dvRjV3emU3aTM2NVF5cGJRWU92YjROOTJM?=
 =?utf-8?B?aE5tcW9XL2FFUWhQb2Jibm0rSmRGa2ZleWRzWXZzZ0lDZTNmdVIvOTloMFRY?=
 =?utf-8?B?b2pSUGw4dTJNUWVkVlZOOW5pd1F2RGdmRVgwdTRLVTl2ZzdYd3YxTEtIZ3M5?=
 =?utf-8?B?akwrdm1BcGd0ZERtTnU2YkszcVlic01aZG1ZUlJVN1l4aDNpQmxaQldEN0hT?=
 =?utf-8?B?UzFrZjhmN1JNRGNTL0o2cFAzc1BTL2dzaHNLait4NUF6MTY3ZnFtOURISEFy?=
 =?utf-8?B?SVgyWTVhMzFWMVZaMnJra3JJSjlQUm0zbmdKRi9uOS9Ic0trT2tLYUY4RlZ0?=
 =?utf-8?B?WEhFbDlOMDZPYno2ajRwOGpCZ21sVlVHbVhhZWdJR2JNcnRiblcwL0s0cU81?=
 =?utf-8?B?cjI3WkFCd2I4UmtobjIxQmpTamdDaDVWSElRNUM5aitiTE5aUUhOcERSaVFC?=
 =?utf-8?B?MTlWd2Zubm5nK1RDWUx2VUpzb0F4aWkraFRhY0UvbHNhaHVKMy9lVmwyRmtY?=
 =?utf-8?B?TUtQcWJrcHR2U0F6ZWJJaVdsRHYzQnM4REh3bTNEWjd2NSs4M0tYZFR5ZytR?=
 =?utf-8?B?aDAyemR5L284L0xVNWtha0E3WjIxMFBUTUxnVnV0SFFMWmprTm9oeXF0WmJq?=
 =?utf-8?B?S3BxV1dnaEYwdndTVUlORVRuQWUreGpDQ3FtVVRCUVlTbGlQcE5maktwMGpX?=
 =?utf-8?B?U1pPeGNiNE1UMU0wV0ltdms5S1FHbE1wVXFIN3FPN3QrS0IxTEUyZis3ZjRC?=
 =?utf-8?B?aVc3TlV1ZDN3aEt3aklFcFhlc04vaS9FR2ZreVdvQ3N2VlNUZ0dTaGZBOVdV?=
 =?utf-8?B?TTRVcW9KVG5yOXpreFMyUjVBNGFrUHdJQU8rNWlsSHVNYTdGNjRyWWdNcElI?=
 =?utf-8?B?cmFSaTVVZ3ZLaUJ1S09kREVCbUZmb1FxK3VzMDRhbjB2Y3B0T1pwb21EeElJ?=
 =?utf-8?B?T2doWGwxSkE3b2lUaGozUGdqeWZ2SWk2Q1MxZVZ4K2VtKzltYjE1b1YrZFNP?=
 =?utf-8?B?QVhtN1NyZnYzK0gxVG8zekVRdkZ5NEpUSjdQMGNQNDRpQjIwK1Y5NjRzOXZa?=
 =?utf-8?B?TTZzNEtIY2VGdVpRZ0NrcGJiQStuSmE4cUdzTFdWbFd2VE1peWwyZjQyMUlL?=
 =?utf-8?B?WS81QUZrRjZFYkFhV3RPQnAvTVRyQXNuZ1RXWVJkQmM0ampMbERLZERLYngv?=
 =?utf-8?B?Rk1VUi8zYTBCWSsyMUhkUFZ6Q01yMkVkWmpYUEtyckV2blZiSHRpWWtFMEdq?=
 =?utf-8?Q?rHsZpvRwvdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRvYlE2WVk4ZlVuMFBRUTE1eEdsRFV0SjZzU1o0aXZKV2swUjVkYUJhTEY1?=
 =?utf-8?B?R21DcFJPb2V5d204ck9ONmdzOW13Mm5BUmUrdFBWbThzczFzZlRCa2tOYll3?=
 =?utf-8?B?QlV4akRKQW0xRFF1a3FaSFRVYmVPVlNsU3NvS0lCcXNVczd1OC9Jb1RsWXRz?=
 =?utf-8?B?TVJEZkp1dm1EODZXbEhHSEY1SW5aa2tlZ3daQXAzcE5uVnJ1WVNVRUJqSUxE?=
 =?utf-8?B?UTFmbldWek4xZlNhV1hIUXh4UEVST2NoTkhsL1hsSjlYVjB6ZXB2a0hCUVUw?=
 =?utf-8?B?WXkrNUt4TFJNeFl6T1BhTFhuMlE2MVA1TUxIQVhzQjZ4NldiRENzVXluRFc4?=
 =?utf-8?B?RlN6cjZxQWQxVEc5MWwybGozNlRVcFFHYytVZ0hOZUZnVG5BbkNiQ0pzZmw2?=
 =?utf-8?B?WHVoTVB4K2FQTTY5bnpoNE81dHNrY1lISE1MT0pQZDNpYS8vdTY2MlorZU1K?=
 =?utf-8?B?VnJOS3dwcWRzZ3VvUjVMU1B3ZCtjMGRybkdpQVJpaE4wQTFoM0Fvc2M3T3By?=
 =?utf-8?B?UUR0Nzcxb0cwM3VoWTNod2w5eWdXOWVRaU5NNi9OZ2U0ZUtpVkhXb1pGUzFz?=
 =?utf-8?B?dDI2bzltWmtxbFFQSWhoVkNHN2dXMEl3OStBK3JPaDZzT3F1eXkxcW5WSHdr?=
 =?utf-8?B?clFOcDkybUI3dFZ4N2dlTm1IVEFVN3pjZ21UcC8zOVFSOG85U2VWWHZ0eWMw?=
 =?utf-8?B?dlRxR1JXendzRGJESUxPY24ySEJUcExFb2c4YW44MENCMEVYQnBYbVZIeXFD?=
 =?utf-8?B?U2g2RkFsaFAyZ0NWbnl2NHd0S2VHV1FVcXZweW9hSUoyK3lhZFBNMEErUWhx?=
 =?utf-8?B?UUx4OWxWSS9OM3ZMcjNyTm9uZlZPUVgxL1Nid3BwRjIzTDkrc0x0T00zR1hV?=
 =?utf-8?B?dFFpb0pOL2p4c3Rnc0FpK3ZIWTZOZHNRWldWczNuMG5OcGN0UUdyZU5zc25X?=
 =?utf-8?B?NXJIUXRXd1lSREdNZ2dHSDJ3MEVsNUdOYnRqb2JPUEI1VGdFNTF1SkxLZTZK?=
 =?utf-8?B?UHE5RW85Tkd0Sm8rN056NEdoQVpOcGR1cGlTSTM2cHpDV0ZnNExNbXFGR0Ry?=
 =?utf-8?B?S1dPWVFDNkljNndmS1RvaEt5ZWNMczFONUtNbFdSd0VZT0RiNDMrdTB6Q3Rx?=
 =?utf-8?B?bVF6TU1HUGl6azFSd0U0QlN0VGpIaituZkNMeWlSYktuSUVDaHJGR04waTJ1?=
 =?utf-8?B?T2ZFbWFjKzFqSy9BU0Zzd2ZrZjRWNWFpWm04ck1ab1phOGRtKzBEN3d2VzNi?=
 =?utf-8?B?N0dTNk9vcWVGc1kydHR3VXY2VS9CQ3daZVhLeDNaRE5jd3h4Mzg3cG83TmNO?=
 =?utf-8?B?bFA2K3h1ZUZRODEwbFhjWDZOR3lnNFN1V1g2cVo4eWQycDJqdVlpN01mZHcv?=
 =?utf-8?B?SW9ZYlBDbEIwVWhmMzU0Qzk5ZlEvakIrdEp1UEFKcDgvM0MxclowOGc5MVIx?=
 =?utf-8?B?SlBERGxVUzV3WGh4MzRJU243ZVlWRWVwWjRsU3RvTHluSTNwM1BreVphVi91?=
 =?utf-8?B?YTllMStzKzJsU2dhWnZ4eHhPUE1mWVJFaGtrSVVwUUMydEE1QlZ4ZUY2V0tC?=
 =?utf-8?B?bGYyMGY3SEtxL0VPUVVETFZIOFoyY0xMV2JCVHpmRzE3VVdQc25Jd2N4ckxw?=
 =?utf-8?B?N0N5YThMRFd2OGExai9qZWlQVlF5c0xSb295L2piVWNLTnIxRDlTY2VjTWdT?=
 =?utf-8?B?NTc0MU9hWU1STi82bzFWZVZkbmFmeEhRT05pM3Y3ckJTNC9lak9qTHpaVkRL?=
 =?utf-8?B?U1kvU2Zna29yTjFEd3hGMllENzQ4Q005L1BvbWl5U3pMSUk3N3ZJS3U0Nzkz?=
 =?utf-8?B?YjAyZnlLY0NBYVlCYlFWS2Y4bXR1NG1WZC8wTFd3VUNHSDd6RzFrclpxbVlo?=
 =?utf-8?B?aloxeFVBK0duck45anE3bnRGSWlrcWhWVEd0WDJKWXp3Rnpxem1pSkJha0Nr?=
 =?utf-8?B?UW5BWG9NTkVJL3JZTE5KZkl0QjE2Y1NsMkJKLzYrVXdtOEFWdzA0RWRaZ2hK?=
 =?utf-8?B?a29idENGM2FtcjBINVpBZUhFd1JDcGhqbHlJekU2K0g0bDk3d29zUndXZGdQ?=
 =?utf-8?B?dFRzOHhLVDJud3hVR0R4dGEzRm14NTVvK0VmWXI2ZHlCbjdQck5QZk9McURO?=
 =?utf-8?B?cks5L2RndEI1MXpDTG5DYUhPSG81WWozN2NSbk4vUklRd0J0VGFkK1NRU1RB?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2b73fb-f096-41b2-3b22-08ddf4fcd1e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:41:25.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URjk2yD8/+4GO61aUgyjaKLKU71CUNeo13Y/nILM+2uEHp3cprlUNziomoJGlTb8jGpYdRxNQnmqQtrvKUSxfBDq6WpAZmtlGBVMeamtOjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8906

Hi Chaoyi Chen,

On 9/16/25 10:08 AM, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The rk3588 evb2 board has a full size DisplayPort connector, enable
> for it.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
>   .../boot/dts/rockchip/rk3588-evb2-v10.dts     | 39 +++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> index 91fe810d38d8..0e5af61f66fe 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb2-v10.dts
> @@ -25,6 +25,18 @@ chosen {
>   		stdout-path = "serial2:1500000n8";
>   	};
>   
> +	dp-con {
> +		compatible = "dp-connector";
> +		label = "DP OUT";
> +		type = "full size";

This isn't valid according to the dt binding. It should be "full-size" 
instead.

> +
> +		port {
> +			dp_con_in: endpoint {
> +				remote-endpoint = <&dp0_out_con>;
> +			};
> +		};
> +	};
> +
>   	hdmi-con {
>   		compatible = "hdmi-connector";
>   		type = "a";
> @@ -106,6 +118,24 @@ vcc5v0_usbdcin: regulator-vcc5v0-usbdcin {
>   	};
>   };
>   
> +&dp0 {
> +	pinctrl-0 = <&dp0m0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&dp0_in {
> +	dp0_in_vp2: endpoint {
> +		remote-endpoint = <&vp2_out_dp0>;
> +	};
> +};
> +
> +&dp0_out {
> +	dp0_out_con: endpoint {
> +		remote-endpoint = <&dp_con_in>;
> +	};
> +};
> +
>   &gpu {
>   	mali-supply = <&vdd_gpu_s0>;
>   	sram-supply = <&vdd_gpu_mem_s0>;
> @@ -916,6 +946,8 @@ &usb_host1_xhci {
>   };
>   
>   &vop {
> +	assigned-clocks = <&cru DCLK_VOP2_SRC>;
> +	assigned-clock-parents = <&cru PLL_V0PLL>;

This is surprising, the only other board which has the DP0 enabled (the 
CoolPi 4B) doesn't set these two.

Does HDMI still work as well as it used to with these new properties? 
Why are those needed? Some context in the commit log or as a comment in 
the DT would be most welcome!

Cheers,
Quentin

