Return-Path: <linux-kernel+bounces-773017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA71B29A80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4797162AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E52701D0;
	Mon, 18 Aug 2025 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="KiTJ3M95"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011030.outbound.protection.outlook.com [52.103.33.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5D1AAE17;
	Mon, 18 Aug 2025 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500748; cv=fail; b=Lzw/teYVp9Q/8P3iZRUUFX6VRWkxiFEyZU1n9EhchJI5bFQBZ9/GUjNFc1knfXiaKXrU44PgybXl39/T9CNxut/gEHJtJJUiqlAzqK6cRpIHK2x4gftG8b90Uv9lb+ysMiYCZNXeY2fTSfe7TBm+PlwV6vlGplbY2j/XZ6/Nx00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500748; c=relaxed/simple;
	bh=Lhc2aVw1ZIDgibd4PK/MFEx1DrrqK+zjM5iNLJ6CIUE=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1PYZs2p4NgfJUuPTMieYoOSkEkcclFh1X+tdGk01ia3k7QNJZijmTPD0adeccShDn+nRTElUgcNVOKzyaSUwC58l3CBKXs6XXQ0+ztne0aOtXlvhmdyrzIB2uwEukgB71d2iXNCoqzEn6jpdpRK7DLENVjRn8mNYLBcfxuyaL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=KiTJ3M95; arc=fail smtp.client-ip=52.103.33.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIbD5XFttXn62oO2WTMN4S72CHcPIkYWl/K7pyARhSQbzjHqVPsUNbNzcODMMh8r4cugc/734px8vnFsiEeUmf7NCgt8mGGTzEFWLlFFYz4HZashguLiD4UC5ER5iI9d2w0cTCY/qWt74BU58vMUqPQFl76SElThM5cTrrtj18DVQzOQlVnXBcdFvVyC1lPr0gi6TJTy1LlNvMA7Gzs3i56nAbLNH6Cq8LDe52uQxGMs3eh7kRfgcvLHHo4Ff90bUp+GLWDafsZJvEVqYzh+33nDAC9XGaIXvw7J5HXjMbzPm6AO5gxxYVYnyXFppS7I/qkcshDJ1jD1sCsCwk2zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMrEArI//DesKHwuXxFhr5yzbczXQNO+/VlJQ34kV6s=;
 b=XhUwpJYdBEUxrv4esXMIHw20g3QF9taEaKmJf7f6gQe296qyQLTetOSi0ADpnLmObOmUFTa1naG+nstoyYK5dn+zlZEIChxZjg7aKaH/YNq8fq0Hb7Ev01MiuL83ORKDZ9rpZGO9bf7HlWb4YNPNamKVuU3NRDJQs6lc0aGszAFbWK30CA1okhkNG+4PlGQ2xSCG+J/S0wu93Ffrb79L4ZLTO/SHGlM8uRN/8SgDjwClNK6LC9OV9jnv/N7Qb9EW6QzBJ5V/8bUAO3TdRtWPtRAU8m6fPXU3ksS+zTl3kmRn7WVJJLrt7ancHXXnE1LfkNX4jmBhp3QTrAaJPyM5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMrEArI//DesKHwuXxFhr5yzbczXQNO+/VlJQ34kV6s=;
 b=KiTJ3M95m3r3s6i8KhgZb1DZ66mBJnKGHXE2U6KWuS6NfhsJIUpwBrtBGfX7RIuMamdnAQuTVFPBi4Tt2odA5C5Qh/AxlXbhwWVzfA3lzf9oiAVe6SYRrXTGp4IjtINcYmgrJoYl9sv3xCVxcp4DX9+hV5CRBpeJp9HdjfTsyv8aD1NNxLr9dBYJuPfp0odC82DN9GDiML4NFdSNGBRc38wdtosHtwzE4g3UhTOaSjJ0UuW2rL1PFWWUbWdepNKoePiBo/pgtRaFl/zUgxP1F/USI/IKM9vC6Owd93Afry0Somg5BQejleDPk1Z9LAVYqQByYG1Sjj+ohMMomSTLtQ==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by VI1P189MB2563.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 07:05:43 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9009.018; Mon, 18 Aug 2025
 07:05:42 +0000
Message-ID:
 <AM7P189MB100938514F7432BC936B7F11E331A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 18 Aug 2025 09:05:41 +0200
User-Agent: Mozilla Thunderbird
To: peng.fan@nxp.com
Cc: Frank.Li@nxp.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
 shawnguo@kernel.org
References: <20250815-imx9-dts-v1-10-e609eb4e3105@nxp.com>
Subject: Re: [PATCH 10/13] arm64: dts: imx95-19x19-evk: Add pca9632 node
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250815-imx9-dts-v1-10-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <04e3aa44-aeab-4940-b773-25e7564f4017@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|VI1P189MB2563:EE_
X-MS-Office365-Filtering-Correlation-Id: b80dc0bb-5bb4-4b5e-88a9-08ddde25a4ce
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|15080799012|461199028|41001999006|5072599009|8060799015|19110799012|40105399003|440099028|3412199025|53005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHNWRjcrS1N1cnd0d3MzRXAxazRsVGFtTUM5K3JVdUl1NDE1Um11L2tZK28y?=
 =?utf-8?B?UWRnR1I4WVBya2tOWURQaStRdkZuUmdOaHhyT3ZVT0RQTXdTcE1LZXozVlI3?=
 =?utf-8?B?b0ZDbE54TEpjYmtCbjBDRFVMOWZkYjRLbk5RT0hELzMwS2VWOHBZYnU5VFFl?=
 =?utf-8?B?VXBSeEJGaG92WVpUaml0ZGhuVE5jdjZoa0p6N3Q4NGhEbkdRNHhScFZhUzhk?=
 =?utf-8?B?MHI5NWVaQ2grV0lyazU4a0NrYVYzZE9PZ2o1NVIxN1BrVERnZHhXck05SkhV?=
 =?utf-8?B?aE1ycHplTU5IU1hlU3YrWWtPdjNiM25rc0I5aWpjSG96dERjdDljaHlVd0ZR?=
 =?utf-8?B?S05ZdXNEZ3RObGdMemxoOHFLSC9tWGF4dUdpZ0hSaFhNZ2xscStyTnFFMkhz?=
 =?utf-8?B?dThUL3RlcUQ5U1Z0VjB0MnByWDg2bUJkYzBXdTUyeEQ1N25YOTBPQmxraVNM?=
 =?utf-8?B?azIxdVdEQTVZRXlHOSt2TmZyQUtscERQREN3S25lOVE0VXVqT3dNUXdTbXNv?=
 =?utf-8?B?dHNVUUJmUGxRc09KNmRhakdYTlF3Q0crTGo5Mm5HMmt4R05JOTlVL3h6Qklj?=
 =?utf-8?B?ZDFid291ZU1oQnZPQW5NRlhoNnV4QktFeG5VSlBSMFRTalhBY1RTTndIL1d0?=
 =?utf-8?B?eThlQW1QNXBYRHE5anorWFh1RnB3YnJJVmsxQU51Yk1jZ1NERG1KVkJEWEpO?=
 =?utf-8?B?aDdlcHozSWJFUlRqQkw2dTRwQ3YweUhyRVpnYVBTcWpDVzYza0xPUVRPV0k0?=
 =?utf-8?B?MVlXcTRuSWZWTmkyeFpTU21KM3U5ZHp1bjJoQVNpMHdSdjdsRlk3MzlKdlgr?=
 =?utf-8?B?NTVYcXlXV2gyLzd1SUdrSVUvd0ZBeUYrbElycVBOZ1hOSnl4bzNFVlZ6cE1h?=
 =?utf-8?B?N1JVQXhMUFFpeWtibnByNlZoRkdESmZvbjN0YVJuTHpaWkNsZ3VBS28yRm4y?=
 =?utf-8?B?a1ZQMmlXcEpJZjlMbnhDMXpmdVFFMEtxNEZiLzRVZGQ2M2RDMWpxNitvTDc2?=
 =?utf-8?B?dmRrRW8vbk9JWDBzME1zZGZRWGxRRHdzdU1Ya0QwQktOSGgzQU9Tbmh6aWZC?=
 =?utf-8?B?YzlUM2VTYzlRSUs5ZkVHMXpkWDMwMlpQaDR2cmxrYjQ3NDJMbjhFRWx0RnBS?=
 =?utf-8?B?R0hGbVBCNDJPL2I1NjdaMkowMGsxZkVXcElJc3JkZ3hiQWpXYk92TzhsVk1P?=
 =?utf-8?B?WG5NUkFsMEdVUDZTWWtISFlSSmZKbnkvdCtBdHhBVVVRRkxJSk5VLzBxWWdn?=
 =?utf-8?B?anJMMWtpSVBZZzZ1VG5mYi9DWUxvendYSGpQdExOTDdnR0Z3aElyOXZNalR0?=
 =?utf-8?B?czZRL3lON1pJbWdiRzliN0Z3K3lwRTJqWTJMRkh4cFpzSGlnUGdiNFQ4djBl?=
 =?utf-8?B?Y1MzM0JnS0dMeTJmU1BNVWRaMzcrQnVsSkMxSFRmclJXYkZlRG9oYXMrcVhP?=
 =?utf-8?B?ZHNpc0diWWpyS3BpZzQ4L1JXaHN6VWpEN20vZFR3NTJieEFuNG9Hc1E0UFJJ?=
 =?utf-8?B?eHNMVnRuWTZiMG5QK3pHLzFaZUg4c2R5KzY2WW54bHNkUUlFWjQ5a0pFWWZz?=
 =?utf-8?B?Um5qOUlQRjVFQmtjTU1NUDlzNlA2V1ExTml4SkFrYWFVZFVGalM1bEJFVHhB?=
 =?utf-8?Q?vpJXMtrsZ8u3TIPejW9xL9jMajyaaO4vtd0yJOd5EYY4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBleER0QmQyNEljREZLdVhvd2ExNUxUYzFqTlBVak1XcUZaMXA0N0ZGa0Vs?=
 =?utf-8?B?TGNiVkZJZUhwRWZRZ3dRTEVkekNCcUUwbHF6ei9PSTY2My9iak95cFNhZHVz?=
 =?utf-8?B?ODZoRjkrTzl3Mjdqb3MyVS9BRXEwcTlmdVIvRGVIT3VQaW9OZnVYcmhVYkoz?=
 =?utf-8?B?REpFRzBhRWdzbVVCcFBHUVpVWWhvSVk3TTJxQjJRVGRmaEZJZWY1aFNUTnNm?=
 =?utf-8?B?NFpQQkg5eXVoMWl3RnRkaWdKb2FsYm9ERzRiM2gwY0NabjFnWlRJaEo4RDZk?=
 =?utf-8?B?RXR3WFllK1h2S1o2M2JvS3B5Z1l4ZmVFMjhFTno5VndMQkdHT0NTb0VpNzNh?=
 =?utf-8?B?K0puRTJDRm9UditQUkdtRVJxNWFqTE93NUsyRjdrYXBrYy9pU0FUSC9JbnN5?=
 =?utf-8?B?aTBaTXpnVjJoVjRXNm8vQnI0ZWd2OWJpcDUrY1NhMDRON0kya0loL3F0Tk9Y?=
 =?utf-8?B?ZURDbm9MaDlTbmdVbG14UjNyd3B2SEtId0hyL1I4T21KSFFJRGczUTI2bGJM?=
 =?utf-8?B?ZTZKTGpib0pHZnc1NDZFVlk1dk5sSXpoeS9NbU9zZFhhUXdTQUdiZVh4cjNW?=
 =?utf-8?B?L3E4UXhWeE9xZjdabGVkRmM2NDYvZVAwaEFsK1lkaUhLQTBPbnBYeG9Rdmtq?=
 =?utf-8?B?OEIyT0xrSVVYVGFTNXdRckRrbE9oTTJNck5PR0VzamRxYW15aGFjNEF2S2hu?=
 =?utf-8?B?a1Y2dlNpTzVCWW5CWVVIMUM2R04xc2VhZFpxV2R0OWdlZzB5anNsRHhQUWFs?=
 =?utf-8?B?WTdJSms5OSt6NzIrQ29jVnlBdzlCb1FscUgrSFZYYS9EMWtQQTFNSDF3REE5?=
 =?utf-8?B?UDBvSTVYT1czaEk0SlNjdjZKTlJuR3NkeWNnMldqWlR3TTBWaEdDS1JKZlBY?=
 =?utf-8?B?RTEvaHpQUjMzSmN4alZqTk52dXVtemw3Syt5NDA3TnRtWDRudG5vTzF0cERw?=
 =?utf-8?B?TWlUa0dTV05YZktoak00Mk9WcWJla0p0QkVFT1hEK3prNHMxNGJnZ1g4dGNS?=
 =?utf-8?B?djdIeEFEbDBOQmlyR0IxUHlsZjBWTFZIM3FVamdsUHNFSGJLVGh5WDFtcEJY?=
 =?utf-8?B?eWFYTDllamtpMGdCQ1FmYlBhdmRIMWpITnB0WGQvcXRwcU5sY2pkcEtSNVVw?=
 =?utf-8?B?OHFjeXBHVjJ6TC9mWTV2TnZZQWFPVjlUYW9aWEMxRUNMbVppMlFtMlpDdUJm?=
 =?utf-8?B?MmQ0Y1F6V3hTZ1Z5NGRMeVQzZzNZdEkrV2Q4S2dGSlNCQ29ueEQ1ejZuT0hU?=
 =?utf-8?B?ckRnMGtqOEE4VzE0MVBCaVI0cmVJajREN2w1RVVkU1FLempRZEV4TVE1eWgr?=
 =?utf-8?B?bTB6UWUwVWRVMFVRWHJZWEp5VEV4eFdtQmlBTC9IWG03dXpjZkxvM2IyY1BV?=
 =?utf-8?B?OVhSeE5KQWNCdnEveThIeS9qZi9yWENqUzJwNmJMckpoVFZsRTA1emdDQVU1?=
 =?utf-8?B?eGJTN2FEeTIxYlFTS2FDc0lPNEp1YmkvcE9janNocjcrOHNtRlpvZGplUGF4?=
 =?utf-8?B?Q2RmQ0N6a1h0UjlYWFV3MG1nbUNleVFERFcrYjhDSlNOeHNUTzg0ekNtQlBm?=
 =?utf-8?B?Z0pOcWs5UXRBRTFNOVNRdVlGcUEvVHMveTdsblF2MVR3NVQzVVowRHM2YWhn?=
 =?utf-8?B?SjhzUXV3Y0ZMSWI2NlI2N2pWRjBKWEFsUWE3MndISzZYVjV0My9TQkRaTFJD?=
 =?utf-8?B?ZnFJK2FTQzNyODU5ODkvcTVtbVlTYXpUQXJjb1FjZzFPTmMwa25CSm9PYmsw?=
 =?utf-8?Q?6gbaZxIlaDe9Zv6SJHGzMyTSPgxFwd5TlxiUHID?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b80dc0bb-5bb4-4b5e-88a9-08ddde25a4ce
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:05:42.8034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2563

> Add an I²C-bus controlled 4-bit LED driver PCA9632 under lpi2c3.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index 82e183dc581012a7c5be3d2bf749463d0a8a360d..c35a5083c837379804e07f98163c0a5d4301abd7 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -329,6 +329,19 @@ i2c3_gpio_expander_20: gpio@20 {
>  		reg = <0x20>;
>  		vcc-supply = <&reg_3p3v>;
>  	};
> +
> +	pca9632: pca9632@62 {
> +		compatible = "nxp,pca9632";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x62>;
> +
> +		led_baclklight: led@0 {

typo: led_backlight

> +			label = "backlight";
> +			reg = <0>;
> +			linux,default-trigger = "none";
> +		};
> +	};
>  };
>  
>  &lpi2c4 {
> 
> -- 
> 2.37.1
> 

---
kind regards,
Maud

