Return-Path: <linux-kernel+bounces-833628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DA4BA27C8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC14C2D68
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED727A442;
	Fri, 26 Sep 2025 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U5bYgu20"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B91D90DF;
	Fri, 26 Sep 2025 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758866515; cv=fail; b=L0zNYtLaQDbIkyw93k9/WkDikZki4oLbFN7yvB+FqX4OXJaZEJQQSdbd9KfeR12sj1EGfLWJ8lYYaUlgr2egqkX2gvFxXr1qqFAK50x5gZiJJWAJnao4+j7UBGxs9r/g9iJUQprHBDOo1/x3oKVfPfjun5mU7ftoeYv4cP33m60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758866515; c=relaxed/simple;
	bh=EcSMdvE/6Ox3DD/YWmMMn8IIVSYqUQS0tkU3qNguF9E=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hjJkSPUQ+z9+wa1Y7eumPCgQ4C9vK7kox94atP15nK1CfiUXam+6uym+n+0n4xT1/AUPyiZXiV1niJfUzRm7dN7Mu9V1rdceoZ9WJiMtYQfikC8mQ4tpnMBLtiX72zAO5GPPyTNhuIuNAowpt4twCgh492/rKMjvvL6yJpFnOhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U5bYgu20; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSHfrwXiIuZFUIrJY3m+AmirIDH4gQI/8+apCgYPWOai42DKVZgN1J66DQBJ6wx99+In6du5x+7RoSDuVhBt8zEHCiiOi5SE9EL6bakIZqBkwPFAkKHE1pI/Qx5JyFISwiJ3OG7C2y9lAayjpiPOKVENLBUSGvg2sEjjIEXxjIReR7i2s3/oJttma2sp4DnJbTc0LXgPm3wugMEJfzPP9GAaXRHb3VpjyMVXaOAPpwqxZI+ixWdZKw69F1S5ApV991McGklNZqHmNM9b/8qQ90M+NtrCJWnDDxdUnlgHWzJ/MaPdiHht+ktFejUNniMNf5gb5rvMZGmYc7TTIf/hAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5c+LJiA+ugaaokP5vVlHQ6LTm0BE2XRRyTHd1Jobls=;
 b=tiWshhbmBigheCLKa9C5lMc56GdnxTortF2W2v9RUuMUZnFr28w4KVe5hPlPJp0FXnrQj0b3MlTNjLqr88xAtG9ZBHY73jn9UNpYB1jay41mvRktIQPD/2dzE/out2DsDiEj98gK0eRtFOigOlthm3tSmmkZFWi4qVHNIGIyggv5CRMLijbNtgmMeYLHY/wLanSQr4Qs1terYSrLxY+3B/VC1e7WVaYdoSzwVe0y9qu6Ct9oE6D0er25tpzdjDnQOf1bijdnCOevRBtyVB8ZXpOxttmVAZdHfYSWGn2hFGlf8kuu/SbYrmzKUYnuV3Na4oqDwQDR5rzZjT3udfWf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5c+LJiA+ugaaokP5vVlHQ6LTm0BE2XRRyTHd1Jobls=;
 b=U5bYgu200xUW73RzsLcrY8XjfLZADg1r+7wrKmGe7I/Ali7rQXNFrCxp8DYc3hQV6JTQZEctJ7Jj2QzcpXfgJqaiNeafhfAjP05mIUH+7FvlNx76nwFiEfqujwtD2PIE8U+FWAUlP4TmrLl6cqxqfBCQtVc+zR+9c9/E9iUHMlL9wqO77x+fw0n53M33HbJNmZ1x1HHfDCvN8P6lzw4B5KJjEvv+Hx/w0Gjm3N8QO+6H0h3dnei38a5HH6vUiF1q73+xaReB1Qoj9uIpZ6GCv64t4l3vRKj+tIZq1YEr2y7rc4QNO2Qb8TX2bP+RKxDTSVFKr8lN5zMGzf2qsW6IAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU2PR04MB8550.eurprd04.prod.outlook.com (2603:10a6:10:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 06:01:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%6]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 06:01:49 +0000
Message-ID: <d39bc215-5b67-4cf5-b9d5-6e1e9ab20159@nxp.com>
Date: Fri, 26 Sep 2025 14:03:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] drm/bridge: imx: Add HDMI PAI driver on i.MX8MP
From: Liu Ying <victor.liu@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 lumag@kernel.org, dianders@chromium.org, cristian.ciocaltea@collabora.com,
 luca.ceresoli@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org,
 l.stach@pengutronix.de, shengjiu.wang@gmail.com, perex@perex.cz,
 tiwai@suse.com, linux-sound@vger.kernel.org
References: <20250923053001.2678596-1-shengjiu.wang@nxp.com>
 <b411c188-b564-4ae8-9186-d0877880fa99@nxp.com>
Content-Language: en-US
In-Reply-To: <b411c188-b564-4ae8-9186-d0877880fa99@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU2PR04MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7f6fdf-5ae7-4881-531e-08ddfcc22e7b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NWhwOVEyTUtNcExiUC9xQTFEZlRBM0ZSb2FHSXdaRzdrZXNLa3N6dXMzNTk1?=
 =?utf-8?B?bGozOUt2dXBseXp4OU9NaGpDT3BoMzVpdmhiZ1ZpanF1L0FQY2ZVVFVPRkNL?=
 =?utf-8?B?c3VBallCOU5wMzRnaGVlUFJGUDlVOHRNendTNUZEb1A4S1ExWXplKzVZS0dW?=
 =?utf-8?B?eTRYOWFOMWRza1FTMTA1U3VxM3pxaDZ5OWNVWkxIb2MyOXN0V3Y3TnpQbElq?=
 =?utf-8?B?VmwvYitPaGJjNzlIU2VhMkkwN0sxWlB1Y0I2TjN2OFFHR2VjZEVmZ1FnbUxE?=
 =?utf-8?B?Y1h5bng2dWVVRlg5NTF1Z1E5V29XcTh6YnlrR1ZORmZiamZhdm5lRk4rM2Yx?=
 =?utf-8?B?RWZvWk9EUlBUOFJwajlvL2lZM1VudndhaXdtS0g2SzFFdHNFL3ZRamFXb1Fv?=
 =?utf-8?B?VHExQTdSemt2eTlSaUpDbS9QRW0wNmpxQVkwQXJzcDVVN1FYaG9NU1RhNGdO?=
 =?utf-8?B?VEtPSGRIaWRSWWo2VTVEaFNubUZxTmdMbHFuZ1lkOHNxOXFsL0NraTQ3aktU?=
 =?utf-8?B?UE5EaHEwNiswYm5kTTV0bS9zd3BNU1lLOExqNkhBYzE1RVEwZUJxQ0t3UUhn?=
 =?utf-8?B?L0ZkaTVabWRzZjNkRmJrYm1aN2NTOTNWdTBrTVZnYWV4M3dkbDVVNXdxVmNj?=
 =?utf-8?B?U1lLR2IvUVUyd3Y2eHc1UXk1S2RYSHBWdDVBOUhNR2F1ZHJZcVFyQ2hIRTl0?=
 =?utf-8?B?b3NiNGZ5R1hBS3RSVFpzUnRsL2dCdmUwS2dwM3IxY2JNOWc0bDQyaWNHblpI?=
 =?utf-8?B?V2VWMmxrOWo1WjZMdmdpa0pwWU9SQWJ1TFJaV3pqY29DQ2w3N0FDc1VXendt?=
 =?utf-8?B?NW5rUTNOak9yUm9saUEyZ2FoWWNyanZyb09na1pQZVd3RmE4NjBDT0JDWjMv?=
 =?utf-8?B?VVpyU21IaDFxMHNZT1cyZFJsZ3lpK2VML2tTeWNMQm9UemRVYlNMOFdwWWtk?=
 =?utf-8?B?ME04L2xvK2p2eXJxNHRVakp0T3hPa1pLai94NWx6NWFDTXkzaUZlcWdCQk5E?=
 =?utf-8?B?T1FRcEF5c20rVk56elFZSjFoRndZTHVzVUZBK3lGTDEyRDFMVVhueWhrYU5s?=
 =?utf-8?B?akMxbEZpRDlxTXBpYk9PMDlCVTNHbnBhZzNPb2xQUExtUDZMdFdTQlhBTktt?=
 =?utf-8?B?OXJPMnl5emNTWEJwcHMySzlGcWIreEcyWm5UeEtPMVdoaU9ROEl2YjA2RmEx?=
 =?utf-8?B?elU3UDI4MHBEbzJWM3JQWUw0VUNYVEJXN0Noc3d5RjRROU9vYkVtdDdYNnVX?=
 =?utf-8?B?NXcvWXRJNmZMbDQ4SWVGNHlFVDlJMi82aFNBZk1RUk8rdDljaVl1WTRPWVJ5?=
 =?utf-8?B?ckhkbmgxMDJCemxWK0dFUk4ySEIyS3BranFWNTFwSXI1NUJaS21PUnl5MFA1?=
 =?utf-8?B?NjJKaElsWUtiSGt3bE1acUx2QXBic0Ntd2NIUkVkMGYrYkhnRzQvSHVyaktL?=
 =?utf-8?B?aGdvd3RHdG9tQXN3NU5ub2dHV2t2Y2JiUURUQ1cyU3ZNRWFpZjJsWUV4aGJq?=
 =?utf-8?B?eDRtK2JMTlhGSmwwNEVTaGswM1FtR1hFSmp2dWg3SFZKUWpmQXhuZWYxSnVq?=
 =?utf-8?B?NTFOSjNZeERWeVRFa1lwdnJ6ZTEvcmt4TzBjRGlxUGZFU05OVkd6WVVVbXEz?=
 =?utf-8?B?N1NYU09FMkxEQmYvK1c3SGNMbGw4U2svL0lQSjdERjhKdE1SZEV2eUQ1SUJz?=
 =?utf-8?B?TzB2QXl6ZHkyamV0WHpFUlhwejZqVjg5MmJjblZGaE5TSHU4czVHVEdPTUJC?=
 =?utf-8?B?dGtiaXFCYnMycUFkZTlkWUZZN1RGZnVIVUFvd29mYlBmNVhpNDRPRUlLRFl3?=
 =?utf-8?B?UnJxT0JydFJ1eWhWL2pDMTdiVVJnNk40RGFEY0toSEJDQWNRNVFCQ0xnMGFZ?=
 =?utf-8?B?NEVBYjZPUXYxdk1QMFRpbjFocUpTdjlTM3JaUWhsVFNraUdYYXA4eWp5VG5u?=
 =?utf-8?B?VmM5K1dsdWpLS3FVMmJJdUxhWU5RUzRQOStwazNzSi9wUFFxNkJXdEVGWFB5?=
 =?utf-8?B?RjVoRTBGVVZBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Wjh2cEhIeXl2U2M1VnIrd1VYcWVBTmNkZHl2NmcwamNXQXFXekg4SWo4MTN4?=
 =?utf-8?B?THpwNWRVdWJFOHhFd3A4OUttUUJmOUJUSHQvZWFFa3RvSUdYS1VtVUU2Lzhu?=
 =?utf-8?B?N01Gc0Eyc2FudWZHaXNzaGttZ2lxUCt5VTM5VDQzZmViSTlVZnhhYWNGU0d4?=
 =?utf-8?B?OHdvOW84L3Y2ckdMeUNDNW1YYUdHM3puRlU2VDlZU1ZBbWFtUFpickttbDB0?=
 =?utf-8?B?OVpKVkdtRzZhdENTT2VIVjRyWnN4c0FKbEVkZGhoODFyVUpueTVSTlVXMElV?=
 =?utf-8?B?MXlnWkt0RmtRY090V0xncXdpMGpWVWQxaTNtQVVVQ2kwVCt5dTh4R3JqQVNw?=
 =?utf-8?B?UXQvanFhVy9qb3U0ZzdOTXRjYmNqZTNkRVBhYlRSc3hSeG9VR3N5VGhHNmFC?=
 =?utf-8?B?S3I2dU1oWHBQcUIyamducDcwc2FzVGpseXowekFNc2xSUGFqNmt1L0R3bVZH?=
 =?utf-8?B?QThmUzRxa1BQUjAzVVNkQlY2Mld6QnYzOXJSZkVpa3ZmWi9pbzBoUzhxeGFv?=
 =?utf-8?B?QTBFa0tYeWFzNzBaM0ROalowbWFJd05WaFF2eGtFejdVZWE4WFQ3TVREa3hv?=
 =?utf-8?B?c1MyVUZxeW1YcEJ4Z05GaldXYktVQXhPQXZqV3RzOG13RlVDeURkcklQeWxa?=
 =?utf-8?B?Z25pckxYK2p6MC9DZkdONW05am1kL25iM05SdWMrRCt2bXNNZk1rY1lFK3hz?=
 =?utf-8?B?ZnZzRTFTU3ZaWFFzeFQ4RVMyYjBFQ3pOeEt2cUtxc3NUSmFCZDRmTDV5RmJu?=
 =?utf-8?B?VzFuSVpOVHhKUURkM000SmZVVjBrcTA5QVZlbEtCM2FKajRia2k5aW9WNU5Z?=
 =?utf-8?B?QWxmRmVQRm9GQ29STEd0ZDZCT0N4WDdDaGZDa3Y5WUd3Y2FTVXBSWGZCNS9C?=
 =?utf-8?B?Qk1ZVi9yYkN0cDJpWEJSYTJ0NDg0azNyODNEb3hUKzJTL2cyc3Exanp6aEZN?=
 =?utf-8?B?eENJaUN4UDJqN2hicVRZMGhXeDUrK3dubkNBSjdqaXRvcSs3Zzl5R0NPajdX?=
 =?utf-8?B?YTFyaUdMNENHSTJiVzI4emZvR0hyMlphdlV2WUhZYXE1ZzZCekM4NStkYTZv?=
 =?utf-8?B?RzdRTk5mK0pRVzRtOXNQOGc0eVBXanVqN05Ob3Z1QkllSWlJRHVwd280RkNQ?=
 =?utf-8?B?MmxNTGRScHJDOS96YjNFQ0Q0YVdUMlE3M0FxMG9Jem9HTEtkOW5mZTNFaGdj?=
 =?utf-8?B?K0dkdG9sWE1MSVZFV1JhWDUxeHg3NVpFODVDWGdxUFRZR2RjbWpNcFFvMWxt?=
 =?utf-8?B?WlR5WnFRL01nSDMyRVZYaTNQSGhPKy9xb3prajk0SUFhR0pwZnVuMmZURURO?=
 =?utf-8?B?VlhmN09jTU1EdnJKQzBUMU8vTlJIei82OGFqczR2WWlIbTkraWxxYWtZYmM1?=
 =?utf-8?B?ZnVkeVZyekJETUQzTHNIR3k1allzV0dMMm03aitQeDdWSjFkaTRaa1hDT1FV?=
 =?utf-8?B?UVZlL0NlZnYyTnM1NWQzOHp4UmwzMkhjeFc4dEhZa2hwQ2RUQ1UzTG51RHYr?=
 =?utf-8?B?YS9DRHNTbEFVQU9zRFVLdkJCWlhrcmlIeTZCTStVWHQ4SzVEbnBCVkUxUWZW?=
 =?utf-8?B?RUh4Z1paKzJjTUdRdU5OVGJEU0hyeTVqRXFySy9vUXllOFhMZ0dXVDhQR3hD?=
 =?utf-8?B?clBRaFovdE9VTjRQZkZJUDF6QVRLM2s4NC9UNkVHZFZRNVJvOStpdTg2Qmph?=
 =?utf-8?B?cmtnSjVwMCtkcVZTM2xJTDhYWmJENHNXS1BSUTVlUUVvN1Rkam9EUm94VWw0?=
 =?utf-8?B?QzkvYkZwNW1peUVEMmJ4OVFHdWt2ank3bksvZUhVZExjK1g5OWlaWCtWMWNI?=
 =?utf-8?B?SVRBTUZxVHRYTW1hdXRjTU9UQ0VzRGsxcUl1MDdaS3hyS3lHTlZDMWg5YXlt?=
 =?utf-8?B?QzVCQVBiSytETTBpSUZOOVhJVGZUR3NUM2hTTnFrWWJUODdyclp0QTVSbTFK?=
 =?utf-8?B?NUlGVXBLUThRRzNId0VKa21kWVYzakI3Qmp4SnVybGNlUDFJVUpKc0htMHhV?=
 =?utf-8?B?OTNBOS9tZXh4MWowbzVRTFpOQ1dMWmxCblhrd1BGREdiaTNiWGU5UXJkVHpP?=
 =?utf-8?B?WTFvZW50V0pHRzgwU05Xd1RsNU9XRFZKdzdiWGJaOVh0ak0yWDF0Y0RBcERR?=
 =?utf-8?Q?3sgl1emEfZKxfpNfi+aeIta9P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7f6fdf-5ae7-4881-531e-08ddfcc22e7b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 06:01:49.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A+OoQv++FJK374vrmR0LOymml7fMoOr1teXQfgt0fl8Db8PifID+FGJmZOUFU0jnFQn63isyIC0YRyXAf9rrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8550

Hi Jaroslav, Takashi,

On 09/23/2025, Liu Ying wrote:
> On 09/23/2025, Shengjiu Wang wrote:
>> Shengjiu Wang (7):
>>   dt-bindings: display: imx: add HDMI PAI for i.MX8MP
>>   ALSA: Add definitions for the bits in IEC958 subframe
>>   drm/bridge: dw-hdmi: Add API dw_hdmi_to_plat_data() to get plat_data
>>   drm/bridge: dw-hdmi: Add API dw_hdmi_set_sample_iec958() for iec958
>>     format
>>   drm/bridge: imx: add driver for HDMI TX Parallel Audio Interface
>>   arm64: dts: imx8mp: Add hdmi parallel audio interface node
>>   arm64: dts: imx8mp-evk: enable hdmi_pai device
> 
> Jaroslav, Takashi, do you think it's ok to land patch 2 through drm-misc,
> as that patch touches include/sound/asoundef.h?

Can you please comment?

-- 
Regards,
Liu Ying

