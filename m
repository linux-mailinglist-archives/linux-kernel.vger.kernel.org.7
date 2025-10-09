Return-Path: <linux-kernel+bounces-846487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7DBC8256
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53ECD4E38B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4652D374A;
	Thu,  9 Oct 2025 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="kb5/GrWU"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023074.outbound.protection.outlook.com [40.107.162.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B205241CB7;
	Thu,  9 Oct 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000130; cv=fail; b=mz7YnsMzsVatdE+X11BKkD44ZbOcKi8PwVCib1QqICoXErNnlWcn2EJqLNtktdpatzDETdo7YJLcG8hviNPjDUoLmUC+0bjDx7TOkTfZgCAOzuyD3EiWBidXdAvRV3F1nPNgADNSs/M3RdE2MifAtWV3vGCrq3BBt4OKP24vDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000130; c=relaxed/simple;
	bh=ZVcGsZ/W+nSPURARGSUt0gGV2w2SDpLF8LmZJmaxkOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pxZFAdOoTUdrnCpi3mpPsIgMlbqOQnQl3ASeoIdezBpa8Ed8aeZeVVXeC1JjpcSIPSlUltnVRhlaLQUyTdyNnpe60vDGECEAy2f5+qxCKgPhKFuUEJOrcoLYD1IV3T3ClFFLMpSqiaVv2+cq35gWpPs86gPaV1BjwYOPoxi0pJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=kb5/GrWU; arc=fail smtp.client-ip=40.107.162.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyTeEei/+N3Y2jnxT8XRo35SAtNlCjJwCHSKeGz+CydKGEgVxsIHReZa3Z9bva3txB6O318Xyw0crIaWjYrleT6yYNsAM5veiWkwza6ylqfTCw/d3TmvE1RnRebo+Hetf7H6+BrEKYARqyvut2JZMRa/bzWfFAmA6J7jT9EFOBEVklqIYzMLmioblxaCdSYVQReGWMAktfwPW7C1TNVCIXxBWMjw+Bjoj6m2TLkLuS/RsG7ORG/PScv/Vpi7aJFkhxCJ1RFlieWm7cAao9/jtjbrvzE2o0K+uj+rH0zLC3BT70SPmQqm/p5bmeQcnTzlXGdOhb5j83fQ6vJl6xly+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVcGsZ/W+nSPURARGSUt0gGV2w2SDpLF8LmZJmaxkOQ=;
 b=rBXcM1UU9FKpHyY/c7tUdePaePQhtQryYisArywHqRyywiMeykgWLp/LbP+cHb/sXXPr6etfnkZlbGtj50XNNcoXnWu9j+DV1DZ7SSnqiLF3cftfDVKONmvJI+tPL30lWd8iQn+bgHdTRI28L54SYiCds9KEDmM5iWGFRI5fn/GJUv6fMFETET2RwMiYs3VX/G8PGsPph3PPxhK+XQ4ILMU3r2eIBsDvl4LRojbVYrZT9CZZGWsoDTkktlGulzZMyFo/QSC+2PmOKrKDryAgPyOsYsijZVXKxU044WufU7xKK3z4k1PuKbYWmz7mX4U5Odbex44h+F96/N3zYhvpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVcGsZ/W+nSPURARGSUt0gGV2w2SDpLF8LmZJmaxkOQ=;
 b=kb5/GrWUec6EHUdC9EuxL9OKPvED8owBOYyLsWY9B1n7WGsx/0wMiboCyoV+W+Wk8ObvASWSNZ+TjGncIkcG2XTxkX71YKIixvLqcN3w3/w2rWro10mnaHPysIpSH41VmCvIYO0wbfbekY9ObbDISDG40GsrNYOqyBkK7hcKswhdLoSRxb3r5b2OlS7jKIX8rkFBuQvzIJqec++0XwCkPTq57JltBFW1rREOOp6u7h5qDYml/M1kq/tdZOuMg6/f9V4fpaEGZG5rvddgT9ihMIpp6ei9ESTyWlCzNU3wWQ2gZIPGedcv8fN8HA4IWkEF+RmR2miAf2Vz5ZH9GofVHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9129.eurprd08.prod.outlook.com (2603:10a6:10:470::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 08:55:23 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 08:55:23 +0000
Message-ID: <15eb53dd-792d-4bab-84fd-2abd017c0a84@iopsys.eu>
Date: Thu, 9 Oct 2025 11:55:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4] arm64: dts: mediatek: mt7986-bpi-r3: Change fan
 PWM value for mid speed
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Frank Wunderlich <frank-w@public-files.de>
References: <20250930021656.1394942-1-mikhail.kshevetskiy@iopsys.eu>
 <ce4bad93-2663-4c07-8cdb-fb6fdcbfc1ca@collabora.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <ce4bad93-2663-4c07-8cdb-fb6fdcbfc1ca@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4785fa68-98f2-48c7-e6e4-08de07119523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUtaYlMyTDhLdlJWbTdNRm9MT2E4U1N5U3J3aWZtVEJSUVVsSXNXZFpYQkF6?=
 =?utf-8?B?dFVrZG5nWlJUSld5VUU2OWNxYkdYaWZtT3ZzRGxOZzNmd1pjWW9BaEltc0JF?=
 =?utf-8?B?YXROVU5BNFVnK09kbG9uSjk5dDJPa3lieUlwVjlTcGtidnBkSHMwVjR5SWFr?=
 =?utf-8?B?Z1V5WTEzUytkMmhqeDdLVU42aUpJV0RkNjFPVitybUFkMGE4R0xLcVhoVU5r?=
 =?utf-8?B?VkRNdVpMWXM4bkxiMVdoZGxHWFJaYzdjeXp6S08xWFNQd0RjbVd2MjRnSnZo?=
 =?utf-8?B?VzcxNjdIN3FwZzUvbi80cnBKSnF4RU9PODdMOTNSODF2VFFjamY3SHZaU0tu?=
 =?utf-8?B?WGhjcmgyZ0JpbmlodVNvYkpFU21YNUJsRnMrbnRMRDNIUVp0cFVFdFVaa0ZJ?=
 =?utf-8?B?RGJVa0hramRmNWQyemNhM3pGRjBwOHJVbUpNY09jUHlzMW1scGwwbDE0eUxz?=
 =?utf-8?B?WStGUjYzanhxVXU2QVNpNzFldE1JQm5TWkF0WHZ3S2t1MndwcHhWNmxVN1Vl?=
 =?utf-8?B?WmoxSThIQ2M1bXlxeTAzUDkySnJLT1FrY2UyUFI3SCswV0RpOWxWZlpzV1Fp?=
 =?utf-8?B?RThqZnVsVktjU1NaNlJEQTFnN3RQaWF3bkhKU1h0QnEvTjZLcVZScFBPSzUv?=
 =?utf-8?B?YVJNZTlYRER3eEYzc2hhaEN4aUU2UFZkaFgrbGpwbS92YkRIL3djRXRWUWoy?=
 =?utf-8?B?cmw4aVRENUVuN2VtSGxRdzI5bnVXZ0wyUlhnVGJHYzlFM3B6RVFMNThXWTND?=
 =?utf-8?B?UVozdGI4UWI4b3hmamdBOGNMVjkrZU11Q3lHNnhRNkpUY0pCSkpDT1VTSUtz?=
 =?utf-8?B?aTRPVmVjc08yMzV1dWwzdGNNYm0ycDViSmhRNXdoVmF4NXgzV0VicXlXaFpL?=
 =?utf-8?B?RmlkampxbFM0d1FwMHdIRVdURE5sbWNKTHh4ODJlU21OZGpRTWZaM2JpbW41?=
 =?utf-8?B?enUwdmxZRTcvNmVhSndmMUZsTTcrY2NSUGJ0MVR6NFFDNzVUaFlraGJ6UEJl?=
 =?utf-8?B?VU1CMjZRdHRMUktISXh0WWptZ3RSY0l4T2JoMUhlRWpNRHM3RGxKWGxQOEQx?=
 =?utf-8?B?NmQrUUtVZVVEcjZjcGhDd3pZQnk1ZDB3Vmp4djFvRko4VlZGRlBiREFaZzVL?=
 =?utf-8?B?TTFUYU5VcGpjd1doVXFGWkFmYi8vREdvT3NoV2FZMXkyYm5pdFJMV1BvQmsw?=
 =?utf-8?B?MFhBK1NFUjFEZ0tlZ0JFaHdxM2l1VmZjZkVuc0pHQVRsa3A0VlFaeXhrRWFj?=
 =?utf-8?B?OUFXV3NZTGlvVGlKV2VvKzltVzBLd2QzaHUzSHFONS9SZzNiSHNGTnhGMmhS?=
 =?utf-8?B?NlEyVUp2MmU1Vk1yTzBrZTN3QStlNm5sWEFDTkNrbHFLYndielhTTmVtajg5?=
 =?utf-8?B?S0lhbGZLRDl3N2U3TUtYQmdFc3VXdEZJbkI5Mk1ySmJGK1FoRDZJUEoraSt0?=
 =?utf-8?B?VGVwbDh2b2FUZHlxd2lQRHRVcGlxZzloQUE0S3o0aEROOEkybU1IWGFsQnF4?=
 =?utf-8?B?bWpVK1FFL2p4S3FTTEtUZ0NuUEpYY0U2Z2duV3BxZU5Bc0JENS9YSFE3dVRQ?=
 =?utf-8?B?Ullqb0NQTW9QZVhjRzk1LzR6K0hySEU3b3pRZEE2RkRZMi96b2IxL3NrVlJ0?=
 =?utf-8?B?RWM4TUw5NGtqMVdZVXQ1OWxpa3dwTE43ZmZSNy9GcUdENmVWS2FUTG9WQzEw?=
 =?utf-8?B?aHYxbHQ3Y2VhTlIrcFBEN1Z3MW4yTWFtSE41aFo1VTFIQTdJSUdpallmdmNs?=
 =?utf-8?B?UVBhVkJua0syazROMERvdzBCUGFzcCs2UnJIUkVJdWFVNWxvb2lpbC9BcDdZ?=
 =?utf-8?B?b2kvS2c2V1ZrbGIwMVh6QXpGakVzOFZReFhPaVpWNkpkTDFHbWkrVW1YVk1R?=
 =?utf-8?B?ZGc2YnVMdE5tNThTdWUyd3M0U2hNVE96WW8xUmgyVk9TcEhmNTNaUUZsTTE3?=
 =?utf-8?Q?sznQvsWDXpFeHk/H4NV7YxaFRc1BnaKO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkVIL0l0OG5vdzBvSkJBUGY2NjJsZ0Q0dkpZMlU4em9iOTdaczc3TVBBT0E0?=
 =?utf-8?B?N2xyUUY0dVAvckE3T0ZmRCtoeHR2QmJoT0ExdzdGM1IyOHZXTnd1Umk2UkFs?=
 =?utf-8?B?ai8vWlB0TDVDeVpPUjk2QS9naXQySzJacDd5aHFvZ2tvN0t5Yk9GZS9EdjVs?=
 =?utf-8?B?aWdaTVJENkFSQnM4QXc5N05IckVEeHdJUEE4UzZ1cmJ4bVBUeWtXS1B2V1FL?=
 =?utf-8?B?dEs1ZzNJWFBpcWRIdHlMMkhCRnF2Qi9yVnBjYVcyT3lvM1Q0SUlhVXk1cmty?=
 =?utf-8?B?U0s4S1ZLQ0xRRmZXYjc1WmlYcWluZTFKSUZkM2Q4eTNnODJXeDByMzROSUI0?=
 =?utf-8?B?dkpFck91SWFFMTM4T1ZyalBrdlY3TWJRQXdsSVhZZEI2NkpmN2tJM1FyMmhz?=
 =?utf-8?B?T0VUVnhlL29HL0ZPdU1hSDFrVHNCa1JQdExrVnhEN3Ywci9FTng0dUFaMGVR?=
 =?utf-8?B?YmJWVkxET01rNjBJSmd0MjBNaDQwU2pMbkw0MVgweVJLanN4YlVHRTAra3Bi?=
 =?utf-8?B?SFRybVNBbHpodTB4ck9TdEpja1lzV2E0S0Y5dUZBcEJHWHdUTllyQzFLaU9O?=
 =?utf-8?B?WHZzZEgwVy9iTGFBUjdzTVBwd1IxTVhpNFpoK3E3TWJtMEFVQUlKY3ViMXRw?=
 =?utf-8?B?cTljNk1keWdTaURYNXNVSmpPeWtEZWRXTFk1Z3FJR0JGRGFkd09OVUIreWFZ?=
 =?utf-8?B?cUJrbmVSN3AyT0gvc3k4STdlWVMxVmExQS8rM1BVZm56S2pnSzRRcks4U0Fi?=
 =?utf-8?B?SDRoRnRpM25RZGwzdmZheE13Y2poeWJaZkdaU1JRYWdoekMzVGxQa245WTAz?=
 =?utf-8?B?NG16blBJOWVyYVVaeGVaTFAxdzhJRXF0dzVnN3l2UU0yWWpGU3FmakVEMDVr?=
 =?utf-8?B?ck9McDZ6SUNxNTI0czFGV01DaVNWWThjRWNwaHAvMW9hSUdOamtGOGQzZlF1?=
 =?utf-8?B?T3g5V0d1U05QT2xPRTZ6MUFKVTBpZGk3b3ZNd25RZ2ZibDYrOGJqbGIwMjVk?=
 =?utf-8?B?dTg2NjY0ejBhYnFhZ2NISEswajRRcWtOblRua1BOYjc5M21MczkzOW9CRHVF?=
 =?utf-8?B?Si8xOHFSajhXRmRaV1RxOU9BZWN1a1MxVGZqQ0M2Ykx3RFVaVGFVelpiSDNF?=
 =?utf-8?B?ZFEzUUR6V1JqUlN5UmhPLzRjanh4eUlHYWR5aEhNODhHenhyaUtORXhtWWZ0?=
 =?utf-8?B?bHdzdkVETmFlYTN1Q0U5QUFDcmhKMXh6Y2tlTVY2cDUzTytFbE5vVHZXZ0Jq?=
 =?utf-8?B?bzJ0blRQdGtRWEZLcUU5aTY2Mms3NDRsckRYQVZqRWR2MzhIMFZlNDlQNWhZ?=
 =?utf-8?B?WUFiRFMxaVhNZzNZRGtxbGRRaUYwM0Vkd2xYdThvNGFsT04vSzZESThGdTBu?=
 =?utf-8?B?RVR2dVQyUng4cGFOcGYxb1dyYVlMZG9kOS9sTzA5Z21nQkF6UGU2UFZCUnhs?=
 =?utf-8?B?SE8rM3BMMDhtWWZpSHhjU2xPZk1UdUo5VDBraWVwQWlvS1R6MHN1RktDM0tJ?=
 =?utf-8?B?dXZyTjAySGZPcEJrSjZWL09manVnT0xTcGphQVdBMTBPbnBJNm53UlA5U3Z2?=
 =?utf-8?B?Z1VTK3dmTTRlVkZSWnU0cnRiSnluelBaemcrRVRKOEwwOXRoQ2xRdGNUZ2Fn?=
 =?utf-8?B?SUpMYU5hT1YraFBQR0RCTERrN2gyYW1uWlBxQlV6ai9nU1cvSTZnU0pUeTJP?=
 =?utf-8?B?dlNkaTl0MTkwYlBTd0JIVS9NT0p3cWkwV29HMXdOS0YweW5DZmFZZ2dOY3ZG?=
 =?utf-8?B?cmhKMFUxN3huVlkrSzZjdFExd1lGL0FXMkh6bEpOaTFTRlRUYkNVN0tTKytI?=
 =?utf-8?B?cGpnZWwvU3VrejFwT0NxRmJ4RWU3dm02WUIrWGYzcmRuS1phTW1Ick5QQWxN?=
 =?utf-8?B?VEUwaXAyWFFybGU4a2UxNnVjUEpnMGlxMXlISGh6cmUrdEF5c29IR3ZvODhs?=
 =?utf-8?B?cDZHUTBsc0pxYlNkeHRhOGEyNklwNWdma1JPTmJubzJDNzRIMG1KeTh0VnFw?=
 =?utf-8?B?QmlhV1pjamJsaXFJRUtEdm5ZaGtvSVMxOW1vbGI0K2E4bStWdWVHdnAyd1Nz?=
 =?utf-8?B?c3Jnb2RPcHN4NEVHWmprQWI1UnpJbW1pYXlZeHNwRklvNTdXRzJmZzcvY1pq?=
 =?utf-8?B?OE5FYUNyTjVxNVdpNXlGSmFtTW1acDA4eXlRTjk4R3hsTjM5RnFvb2VaaVNz?=
 =?utf-8?Q?4O0CVPam9xm1vIh50Cj19pU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4785fa68-98f2-48c7-e6e4-08de07119523
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 08:55:23.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgVsGHR6BH12kyCt9TPvnu6wDSHbEYFo7W8I3rXRdM3XlZf6xAEUyXf2HX5z7Uqda290AWPJiuocX5qvsBSMT4Lm9Fpy7ApyZhJ9s3Hzkpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9129

Is there any chances get it merged to linux-6.18?

Regards,
Mikhail Kshevetskiy



On 30.09.2025 14:34, AngeloGioacchino Del Regno wrote:
> Il 30/09/25 04:16, Mikhail Kshevetskiy ha scritto:
>> Popular cheap PWM fans for this machine, like the ones coming in
>> heatsink+fan combos will not work properly at the currently defined
>> medium speed. Trying different pwm setting using a command
>>
>>    echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1
>>
>> I found:
>>
>>    pwm1 value     fan rotation speed   cpu temperature     notes
>>    -----------------------------------------------------------------
>>      0            maximal              31.5 Celsius        too noisy
>>     40            optimal              35.2 Celsius        no noise
>> hearable
>>     95            minimal
>>     above 95      does not rotate      55.5 Celsius
>>    -----------------------------------------------------------------
>>
>> Thus only cpu-active-high and cpu-active-low modes are usable.
>> I think this is wrong.
>>
>> This patch fixes cpu-active-medium settings for bpi-r3 board.
>>
>> I know, the patch is not ideal as it can break pwm fan for some users.
>> Likely this is the only official mt7986-bpi-r3 heatsink+fan solution
>> available on the market.
>>
>> This patch may not be enough. Users may wants to tweak their
>> thermal_zone0
>> trip points, thus tuning fan rotation speed depending on cpu
>> temperature.
>> That can be done on the base of the following example:
>>
>>    === example =========
>>    # cpu temperature below 25 Celsius degrees, no rotation
>>    echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
>>    # cpu temperature in [25..32] Celsius degrees, normal rotation speed
>>    echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
>>    # cpu temperature above 50 Celsius degrees, max rotation speed
>>    echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
>>    =====================
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Acked-by: Frank Wunderlich <frank-w@public-files.de>
>
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
>
>

