Return-Path: <linux-kernel+bounces-789565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CAAB39767
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C9B68124E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880672EB84B;
	Thu, 28 Aug 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="AGJ/oxz4"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011037.outbound.protection.outlook.com [52.103.33.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098E30CD89;
	Thu, 28 Aug 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370882; cv=fail; b=BmvFU8rroI4BEsgdBqu2o5r5fHiJKqWbzaPsIQGd41dSOwmM8S1sN1uqYF2fwZxc778zx4O8/hbCFTGvg9oC++pjt1bP0KXhiSb18Q8gzfuI3QIFFLnd0FfgYwJLE02SSa0l1IJQ93qgdjsczpSVfk6lcDXJU8cTSYEF6ApGUGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370882; c=relaxed/simple;
	bh=LJKTM4R15ZfAkGV4P+arTCDay5Aj5czPXRhbIoXNKa0=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K8fm+BrNzIcN9kFTesUhlrYnRsW7sYMsOEoBPO0UKCVKkexFhmZx/D/EJCqnLzmiXcDROXm7OgaX0WBlhMm4bkSn7u8bmHwjCxtPIkiUSwJ0shMVGinD0VIOpNcrikOvXASI0AAC3FZOJpzCsjOGThwR+PRmdZkhuYK6rMxKZNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=AGJ/oxz4; arc=fail smtp.client-ip=52.103.33.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb21qGb4orLiAiO83wXsrytypEJkMLclK1vRV01rH5Ykap9YW1JzYpv4M6ipFjFHYsSzrIWsVTVe6SLbi2OkvYrskkMIsO5i2uAkMf/AiFD4S1m4dRHn4VziU7hr3hZEqes3joXK4XH7gTzCkSFUMy3F2CeiZPCw8RgaOvEr7SE8gGzA/qsZH67cb1M+qrQ0xFeDGC7sPROU5vDTIhcWQxD/JePRp8K3Zn0jAeEQJ9TGWuLdc7dqYYJHSO/+abKIJ1ARDgBOdfYRqqpZDTjD4EjXzC8820+vOvJL6vroDOkfInNOPmlz1Ex6QYS8CfnrZL97tDmPxrBubdPYgQJvJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV0JtfyD0a7o3NmY0oc0/E9UvWT2LBwGxVC2a39GFpc=;
 b=mmZvTx6TidjSlyARnzIMlM93jX0i35o1RNZ42BZp8xlOhGz1CJripX5bX7IIIbFTTAhAL3Dw/XohEuNkaKsxEfEiv3Mh8qapNlp0JbT3kl/bvgaNkhzF1uu/5+r5bxMovO/rnGM73cVQbAW2RkOBN2tMAbV8EZJ8IABUIPrs0SJe7GyZd+fxHSoWpi4W3R7y3JH5ZwND3JlsFB269MdmAJRHJ+EbaqP2XbkB+X+WlLr/iNarWfPRDH9IM2Lgba5+FRa8YFXf6F/li462x4vtXTK60t77fBOtmDj5n+RCVmfN4HFJCUbwtvb74cDUJV8KXPQtF63fqZ/fzB/fXK+dCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV0JtfyD0a7o3NmY0oc0/E9UvWT2LBwGxVC2a39GFpc=;
 b=AGJ/oxz4ml14hnyHZePW4Wm3a6tehL+olLZ6eH04SYV9hTyzj8xDDE7SquHUZqEG/ciMClWIerXt4ggW3ByzlEnkXZflhjPxBCY5DKSBECgIJ4z64+HJW88zAv+rb5DGj/mc6vco80UfkND63DBI7CdWYaTidwRonlC3y6xvMyb16ZA89MN2Koeh1uV5mYr+of84/6WOcd51Y4zzNffYQYHlVQitAshn9RPwjo4acQf9rsnawTJnCaJB5A5EdROnQZ7rlnHGbO39chq7n6WVYtyuVIVQubTRHWG/tF03sqZpdmNL1WPekoSch/j66XR0tWTJsXRjjFS8xJ6IpEkzDQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by PR3P189MB0876.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 08:47:53 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9052.014; Thu, 28 Aug 2025
 08:47:53 +0000
Message-ID:
 <AM7P189MB1009A67370CA029038DF2A69E33BA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Thu, 28 Aug 2025 10:47:52 +0200
User-Agent: Mozilla Thunderbird
To: opi5plus@bcc.bai.ne.jp
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sound@vger.kernel.org, robh@kernel.org
References: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enables sound output from the
 audio jack on OrangePI5 Plus
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250826134456.9636-2-opi5plus@bcc.bai.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::14) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <34ae1895-4bba-449f-bb4f-7c6c6ac34135@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|PR3P189MB0876:EE_
X-MS-Office365-Filtering-Correlation-Id: 553e713a-7ecf-408c-ede3-08dde60f9334
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|461199028|6090799003|5072599009|23021999003|15080799012|8060799015|40105399003|440099028|3412199025|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk96aVZoWnpKVzZuWEMzd2s3UHdraUZyVDRGRmlaWEhNM0o4cG9jSjhZRGNt?=
 =?utf-8?B?QVNQZzlwdXhKMHBMaytaVjBOZldubmFPWmU5NldIZldwQ2xDWFFUblBjcDdG?=
 =?utf-8?B?TzVvZXFnYldRWEZXM3Q5cm9McjVodzloZWFtTjFsMDJscmVONXJHczZNRnlQ?=
 =?utf-8?B?TFBoUmVtalhTVkh6b2MwQnc0ZFpSV0E4QkRsbkdkWnlMYTJHaERWZGNUUVAv?=
 =?utf-8?B?VDFpQWpzM2h0TzhqOGkxNStEZXlGcWxDa1NuK2djdU1TU1VBNXI1bEtCL3VM?=
 =?utf-8?B?MzhCeEtJT1hxeExmV2daeVI0NWxNYlVBZ0FDVDlCQnA0dDUzZjh2NGg3SWh4?=
 =?utf-8?B?b2wzd0ZNa25ySFEvdWxnbWlPZVRJL1RlWG1wQy9DRU5yUGljVDVLR3VNa1lB?=
 =?utf-8?B?U2tXM3NNcU4zb1c5cWJWaTc0NXAzN0RaMkxQTUs2RXc4M2pobC90Zmt4VlND?=
 =?utf-8?B?MTFFb01zbXpLY1ArTVdlUTJadmNoMDVxUW1oSkVuQ2RsOXdaVkFtejRHRng4?=
 =?utf-8?B?bmRjRmFYcFQwQytMTTNHd0JTbGEra0d1WFQxSXpFTGFobm5DcllmdWFQcTZh?=
 =?utf-8?B?NlhpL0ZOODRMVUZMNnZNZzRJZGRqSEg1aWgvTzB6SkNpM2Z0TGZRaXFhYUlT?=
 =?utf-8?B?UEd2TlpMMGlFR2pOTkM3bjc3MFZOZFRrall4Zi91NzZSaGtNWitTb1hhbTFP?=
 =?utf-8?B?K2xuWnFyNG1ZdkZCWk9DdncxNzV6WUJwRUZ6a1JtYS9YU296RmIyajRaZENG?=
 =?utf-8?B?VG85UlNLVFpBQitSRU51bnpCZXFaNkZpeFBZYXIrcUhrcFg4Zk9aNXN3TFRU?=
 =?utf-8?B?d0ZrRDZlS2Y4UFNTSjk1RS9oM1l5eko3czZTbHVCNDVqRGpTdWFBbjdBMHFD?=
 =?utf-8?B?UVVFNXE2ODVqZTM0Y251d0dIOEExTzRqdkR6Uzdtc3EzWjhSU1E4cUg4cEg0?=
 =?utf-8?B?VDBnS0VYVm9ma3BLVHhMaCtFWFVWYWhBb3lPY2VSY3hCK3dyMURPbkJvR25t?=
 =?utf-8?B?dE5UMGR3U282UU5vSWhDbTdodStkM0MzOFRqZ0ZxVklLWnU0MzlWbGI5L3FM?=
 =?utf-8?B?V1EwM1ZNbERqeE9wUXhDaFY5MVp3Zm5VT2RLVUUvRnV0Ymg3Lyt1OCswQlFt?=
 =?utf-8?B?ZnVBYmF5eUZ1d3ZKMEdTZThPSVRBcGcxU2xDUXduL0tLWEhFcC8xQXhyVy9h?=
 =?utf-8?B?TStUYkxnenYwdlo2RkRMaHpIeE1JQit2Z3B3QVdPZnh5MHp3dXlXM3hnbzBU?=
 =?utf-8?B?ektwemRvOTNBNnZMN0dhNVJGTU1SdWlwU1NOZlkvOWwrbVZIZnZFeE51KzQ3?=
 =?utf-8?B?ays1cGg5WGdPT0orSFJOUis1Y1ZOa3NOa0RLRUU2M1ZieDNPQUt4YjE0bzFK?=
 =?utf-8?B?UmxmVEF1YTlOS3paeUNWY2E0cUZmNUFOZHYyaUV3bmdNUU10T3RQdU5jOHVo?=
 =?utf-8?B?Y3NkU0dIK0JYRmN6SmRQRm5qajIwcDNyTjhsdm9CRmFnMEk2OEpzVG5CODRN?=
 =?utf-8?B?UGc3WDZPWHBZZTlHaUhQYTh4TzRJVVdpdEh0bWl0ZmQ1aFRhVnk0WTlFT1Q4?=
 =?utf-8?B?ZGcyVzlKaXRnalhnaTBZK3lOaHhsWW9vVHI2VGRDaGJNNDNvOHY0ZXZYclJX?=
 =?utf-8?B?bGZsYWlnOUVTcE5lUFZCVjhwdVZNRzVndW16UXdMOFh4a0F2Y0ZaSEM1cHF2?=
 =?utf-8?B?Q3pTRGxrU1JhNEZQbXJVNUV0ekVHQVR5T08yVkZKdkcwQ2NHYXFpc2dhMVVB?=
 =?utf-8?Q?gKlJF1TUv88f7p6407fd5C30Vzylh/IkPFmVwnp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUhpM1daOERmRzhtYzFPOHVHVWh4NjVUTEgxS2tndFQ1Vmx2YnhzYllIbWZT?=
 =?utf-8?B?c1FsSGo4Tkxla281aDBMck5UNThiWmwwSlZrdkM3WE1RUEpsdUEzUEJ6cnVU?=
 =?utf-8?B?cEtsWkMxVjNrZlFqY2hJeWF4WVdjNDRQZ0FKZ2IxbTk1SU5heFl5ZXhkYTR0?=
 =?utf-8?B?T3VzZmdQRGRXSE5NbEJYRUp0MjR3U1BTZ0V5TE94blk3Nlgxbk9ydHNIS2Fi?=
 =?utf-8?B?N2YyaDBlVXBuTWxHcEg0TFYwSVgzUzhIOFpHRmJ0WFVRMkVCK2lvM2s1aTcr?=
 =?utf-8?B?VmhDMFNiemlMQjZXc0d3V0diZnU4citiQURtT2tpc3NDTWJyOWFDaHhxSFN1?=
 =?utf-8?B?cmtwZFl6UXdqcUpqZ1gwN0MyQXVLZ2JwY3FwR1dBb24vancyZHdyMjVzQnV6?=
 =?utf-8?B?Q2VMVDhkSzUyZFBIbEM1MHZEYThLNnFPL2RpVkRFK2FQaUcyOVAybC9FKzFI?=
 =?utf-8?B?eXg4RjA5NXoxU2ZqU09Jd2hBL2svZUg4VE84QzRzYWMyRUpiTStJTE44VFRI?=
 =?utf-8?B?UHJhQlZ3VVN6KzVBQmkvVlBxbThhTWt1WUVKa2cvTTM4d1J6aHVmUHl5S1NX?=
 =?utf-8?B?S3dYRmpOcW53eHBReU9mUWFuWHdZc1FvajhocmlJS2lJZEVSOFA0eFo0NHV6?=
 =?utf-8?B?NVgrbS9PU1N5QzVhOGhlVmdta2pLeEplTXpOa1dCS0EzMTNUbmkxM0VERFJZ?=
 =?utf-8?B?WHNUM3hZWUhVS25aQXVvYVJkeGdUYTNvNVJWMGFtUXM1VkpZdjZUNlh2R0RQ?=
 =?utf-8?B?ZTg5SDlhMTlSSVZSdEJXdjlJaVdwRG13NWw5TXRjOEtabmx3Y0lWV0tRVFJF?=
 =?utf-8?B?U0xINWNiTzBFYUZXcGpuaGNoS3UrekJWTmxvZkIyMFQ0bEVvcVFGc0M4ZWxH?=
 =?utf-8?B?YW9kQXRnV3pxa1hJbGVacTlPay94Qm1saTk0RnRtdkF2NzBxT2kwOWJuTDA1?=
 =?utf-8?B?OXgweDJoTkRCMEFkZkRRY2dyNEF4cnBSTytxYTZBcUpYWkFjUUFxTzFrWjlz?=
 =?utf-8?B?VnpzVE9sZURqaTMxTkY0ZTFRSlE5YjltRytYSlRvcTYxV05BRDB3VEgweWcy?=
 =?utf-8?B?S09vOU5QS0RtWmNxTlEydUc5LzBvaGxkamkyeFJRUS9meTY4WmNKbDd4cWh3?=
 =?utf-8?B?YUl5SGMrZktzSzdVRU1TY3dES2taMStFQXBMM3U3RWxPZk5XN2FmL0RwZ0dK?=
 =?utf-8?B?eEJqKzNONVNQdlVmc0xpNUhySnhqRlo3bk9qcGU2U0Y1eUZzTkpxYzFyekdj?=
 =?utf-8?B?Z0dDZm5za2owOHZWV1FXVC9kZEE5K2NkN3pzbTQ3Z1B2aHQ3cWFxR1U3dkZ1?=
 =?utf-8?B?QjJHa3RzZDlPU3ovbXZuR1JMdFNlckpMUnEwbHJoRmE0SzZ1elZ6OHBiVFZ5?=
 =?utf-8?B?TjBNclZqbDlNcWxBOThyNlE1NFhNQXRUZDlZTGNacFdVaUU3a254aDV2dXU5?=
 =?utf-8?B?ZGk2dlYzT01PUG13WVBIM2RQaVFGd0NmWEJ0N0U4WmFQT3Y3NGdMWUxLNWVa?=
 =?utf-8?B?Y2tpaTMyelNEY1diU0w3RWliMEgyWk9XVThiTmNHaFBXRW81eEptZk1ZNDky?=
 =?utf-8?B?NUJqYmRDUDcwT0thNWI2NVBnL1B4bTlwVXRWYXNxVGhOQnJNczlRMk9RNklI?=
 =?utf-8?B?TnNzdVN0bC8rOEdsNWZ5WlkyRkNDbkl0VDl0MHdrb2ZCdFY2N29xVVg0Zyty?=
 =?utf-8?B?aHQ1Ly9YeGRlTVM3TU9kSmd0bnRkZURZSXMvWlVDVXNsNmtWNWVEL0hLUDBT?=
 =?utf-8?Q?XEYSLaKHNcwKdsYS70Uw06AEVSd0/rxF39nlM7d?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e713a-7ecf-408c-ede3-08dde60f9334
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:47:53.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0876

Hello Hide,

> Currently, analog sound is not output from the audio jack.
> This patch allows you to select analog headphones in alsamixer.
> Works with kernel 6.16.1, but not 6.17-rc1.
> 
> Points of concern:
> 6.16.1 kernel with ubuntu 25.04 Setting -> Sound -> Output Device
>  I select Speakers Built-in Audio, the sound will be output from the audio jack.
> 
> Changes since v1:
> - As pointed out by Jimmy, the file to be modified has been changed
>   from rk3588-orangepi-5.dtsi to rk3588-orangepi-5-plus.dts.
> 
> Signed-off-by: Hide Hako <opi5plus@bcc.bai.ne.jp>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> index 121e4d1c3..44bb15951 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
> @@ -78,6 +78,7 @@ &analog_sound {
>  	pinctrl-0 = <&hp_detect>;
>  	simple-audio-card,aux-devs = <&speaker_amp>, <&headphone_amp>;
>  	simple-audio-card,hp-det-gpios = <&gpio1 RK_PD3 GPIO_ACTIVE_LOW>;
I recommend rebasing on the latest next since my fix [1] was applied.
I also recommend testing it with that patch, for me that fixed the 
headphone detection and enabled audio playback. The microphone is not 
working yet though.

Link: 
https://lore.kernel.org/all/20250823-orangepi5-v1-1-ae77dd0e06d7@hotmail.com/ 
[1]

> +	simple-audio-card,pin-switches = "Speaker", "Headphones";
>  	simple-audio-card,widgets =
>  		"Microphone", "Onboard Microphone",
>  		"Microphone", "Microphone Jack",
> -- 
> 2.48.1

Kind regards,
Maud

