Return-Path: <linux-kernel+bounces-875565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2389C194D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95D5567DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7E2DC355;
	Wed, 29 Oct 2025 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="j4E7pDvX"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023102.outbound.protection.outlook.com [40.107.159.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B92E2663;
	Wed, 29 Oct 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728541; cv=fail; b=Z0jzgBwsuadITGnMt3lTWr3mFTcGo9MUFndHGqoOIqwfnZTcfMRrjBN+9KwbxG4HbSpd8KfpSqx2c0ehI3TC6oneNk9sb7o5B5YJZ9O12AGjzKDKXNhW2YvNrv/jtcQwHzgErkyZCqcU93WvOSWqZEFpB8+UM7I3RBkZ65A7QB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728541; c=relaxed/simple;
	bh=zJ4DBBQekywd2K7EYgacfkCesLIvMIyu/Rm9SwpwPoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V23uq0iaB5n3eb73vY6zfdpWAdFZNpMBn2b54YWbQoSbWW4LhJcwNazvfo1fIbJok7MFSn1fYjmOmAz/2bAjWz7dyExTFPTybTdqxrFOlzJaOJp1k2vmkFuvvBOc7MiAhfHGCFWUAmC1ZIENxuVymGqBPIGJtl2LJFpWWd+PA/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=j4E7pDvX; arc=fail smtp.client-ip=40.107.159.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxj9Ck7DKvWNjbFdhshRx9lDTBv805gDZmPx1FjTrr7UIe7ODQOrobkuUyqo6juE/c8xXyGhYjXP6FpNXwsyZbfDBiKNpcoC9E2T+DaBvi7OHIPK/oQusxbrQKKy3OtaBQjCAgxUuNtl3ztqHES8mvgBcx0h8rbxSgEGfPSOSpv6zFHYeZLCXsb2lwRtaf4zIbd7qiFCmPakGwU7VMCUG3Qe+hPOHgmeCPCfgetrFPK3VeZu/Cz36tnoca21DilawSfrAhaGRiwdAKvfPGKVsRYIsJm0gsJUQOJs2kjPQeR2EqU7cavJE87N4Pw+zyn6gHAeR7PQvhzHSrEkP36vWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S1qumrmebMn9U+Afz1QyafTTjwGgO1MfexWn6AYA48=;
 b=VSHDOKnkLTmQGbRsb1L2Y6tbIRDTe0rV4QUKrQAxNS40w6BJ0YmUV/gm5I3/2gCYlaUXc9BqVYYhBOQisybQ9DQbHhseJiQPCu6PN0trAlRmyxoOceAmidVowW+VjHze7ZyN43LBBvlGtYNLu3L5mQp8rnxo/FFSrNbL2hkJDbkyCxmCwLIhWCgSGPlBzRxqf+KsbSNgQORUS7phLJhuBMZ+W2bn5GQG28+Yha0ZBoagrkttFF2tpNbarKL5+x3Sr2JycAO0tgIyWCav+zl5XcxFCHCh3P1bPiCzaQkXA3zIjSWEEh0RUsMswD6knoVThIAJ2SJ4m3VIwScY/LsyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S1qumrmebMn9U+Afz1QyafTTjwGgO1MfexWn6AYA48=;
 b=j4E7pDvXHtO3AJc6hArEtknSEURloJQsSepa3P7azFHET0TVGo0xMSBW+4rp6dszIydJvAIiTyS9TOFgT2FbhkpJ2SjjvwgEdmbGKrUCL2gc56JXrVPtmY6VJJlEWYRer//Z+PwoD4vQ0eIGVZcVKKx74AJWctGmLfIcehPUS+6gEpBn2XRkznwMMCg4bJvT2PR7UGTRG8g1AWKSbDDCWocKFPUsOEQzHw+unBxV9FjLvKySrrpCSxw2SuqDikpyakUjrjG+EHL3fDD4HnRfP+/pEFE0rxchjt2lAdXao3K41edQWLpfMNvcEcwUPGyqPzs/tYHTvDWjUIENgipl/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 09:02:15 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:02:12 +0000
Message-ID: <4733e8cd-3a2d-4d75-adbd-a3101760d13a@gocontroll.com>
Date: Wed, 29 Oct 2025 10:00:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
 <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
 <938f85b0-4c9b-463a-960a-f5f4e4092480@gocontroll.com>
 <20251029081138.2161a92a@karo-electronics.de>
 <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <4a47b9b5-f482-41b6-a441-7728572c5a0c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0011.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::8) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DB8PR04MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9fceb6-adad-4075-b865-08de16c9d988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE02NWZnR2d6NTZVZ29mSzZWWDlWRTZMNW1GVTc4elU0SU14b1FsSEJVZXgv?=
 =?utf-8?B?VW5TcjBIUjVzVUNPME80SElabnk2VW9xbU5GMnF1RXUyZlB2dENzbEVMOHFZ?=
 =?utf-8?B?cXpLMnZvVk9tRDk3dXBiWm9DNkdsbnhTN00zSVBWTytOQXRiVVBXamhjSnZC?=
 =?utf-8?B?S1lMaTVRVFR4N2pyMzdnU2hFZXNVS3FKZG9SS3JzeFdUa2JnSFBJZ01MQm15?=
 =?utf-8?B?U2dXTm5EZUVnY0hGQ0hXd1NLL1ErVkRTTXpGZVBsY0UxMUtmVFlMcnBVcERt?=
 =?utf-8?B?L3ZYTUtNMUFsdmhJTy9sUkh5SlZ5SWVxcFJLUjBWQXkwOTFqd0hBSERmdko4?=
 =?utf-8?B?TjRKN2I3WThBY0hMdkM2aE9rUzY3OUU1UnFwcmtURmRhTlJYYnI1cExFWGsx?=
 =?utf-8?B?ZGoyd2VKMHloMXo5L25QaFNKbFp3Qmx5amxBRG11WWxQWGlBRGh3UTFxM1BP?=
 =?utf-8?B?S1o1MHJXa1pyTnpaZGVobXdMc2dpU0JtTjhqc1JzdFFuNlZtM0t6K25FOWhG?=
 =?utf-8?B?aGQ3MUNnQTNKZ1QvVmZsMVF5eHVTTG5hSVo4NTk4aXRIdVd3NjNBYno2WVdR?=
 =?utf-8?B?ZE1QL3ZMT1dsK3BGcFY5NEZBWE1zN1JNNXB0cDF2VTlEamN1bVEvWWNwUmhG?=
 =?utf-8?B?UU9VVHNMZEExbkxnV01lNUd2N2FKTUJTMm9uTDc5KzBWNEU0QmFacFBTNFBB?=
 =?utf-8?B?NTQzK2VwUDBSWDYrMHhYSW9TYUpBRmdwUy84M3JIdHdqSHhnQ0Z1NGpWZEVN?=
 =?utf-8?B?KzBRU3ArSDBBMzI2ZjlsSTd2OEJIeU8zL0RKTVhyRHd2dE41eVpHa2dBN2U4?=
 =?utf-8?B?UXZhN0x3eVlzSTR0SzdKQ3NXY2VFbWZWN0V3Mk94T3VrNHR4VWVSejF1YjIx?=
 =?utf-8?B?eEd5RURTUlNkWjBta3NidjdWM1crbHNoaTZvallVaXpMKzY1N2g0M1UwRzlE?=
 =?utf-8?B?aTdEZUFyUFNPSzRLaThVTFRjWmdYTFphRjhrZ2pMdVFkaHpZU1BXZ1VQNWIr?=
 =?utf-8?B?a0tSNTYrdWl1RWRSWkZvOEJDK09PRGh5RzJqalZERmFoMTVLQUI1R0RWNEJ4?=
 =?utf-8?B?RFZucXFEclpoOVk5Ulp3S0wyRHRqVmNqbFFaSzMzdGpmazhTM3RDSVErdEJ0?=
 =?utf-8?B?dlV0RnNoS2MrNGJ2TXhOUTkxU25nMTV5QXo2YlFhSDJVQjRDN05VL0RncXk1?=
 =?utf-8?B?T09wbmN4eklxRkRiekF3T3g2TFRsV3llSVJLZVl5SSsvWk13elpKUTF6WFpG?=
 =?utf-8?B?c3ZoSW5QcG9SaVA3VnY0MFVlMGdlNGtGU1FjeDlFYnN1TXBSN0ZkVE5RK3V2?=
 =?utf-8?B?TGRTQVc0bU1Ib3ErWnhBWlJwMTduaFFMcjZUaktXaFNVSEFVckh5M3RxSVpa?=
 =?utf-8?B?cmlEMzZhN1kzQ21iRnRTU0tMWUh3ankxM2ZEMC9OUEZxdTM5RmdkbGdRc3hZ?=
 =?utf-8?B?bk1KOWNqZEFndisxNmR3a1p0UklrUTdDekVySEdJWHhGblhNWmU4SEhtMDI0?=
 =?utf-8?B?a2Mvcy9LeXRWUWUzbzNCMUVBbHBNd25QanE5TWZrSUJ2T09HREpkMUNHekRv?=
 =?utf-8?B?YzRJME4vcm9zS1FQd1dOTmZDVitFbTA1MmZTZlozTE5tSGk5aVN6bDV2RHVZ?=
 =?utf-8?B?bmEzNVoyVERRbzh0QWxkVU13YnNBSjJwN1VOV0VVNWxScU1ZRVYyWUI1anRo?=
 =?utf-8?B?OGhFdDVyUHVWRFdPaEtZdy9NWEtyVm02eVlGa2I5aFJBNVR3am10TDRnK0FU?=
 =?utf-8?B?QnBYbkk5eTBuYUY4bktpT0c0VTNpUmZ5aWdSVmNYb1FjZEJkZ2owRkRPMjZk?=
 =?utf-8?B?UmlsWnpQNlNTZWY1amNOcW9wRm1FbGVybFVaNk5oL0FjR2ovZ0VvMmVhL1hC?=
 =?utf-8?B?WmRwSzF3NGFVVGxxWXVsMW9mZVp2RkxxQi9aWlVCYSs4dzNpNUdkemJUN1hR?=
 =?utf-8?Q?fFDaz1QxLeiA3vqXk6MSldcmy0Ec8K/s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZyUVR6K1VjaTVGdVltdjJ1UUljOHpWU2poMUdjVkFHM1gzeFU1SEtiNWpB?=
 =?utf-8?B?QnQxd01xMnE2bUQyQ2p6VmRUdVpHK2RVUGs0a3phWDRPVm1MMVdXNFBBUmRZ?=
 =?utf-8?B?MGZXSmVxUVg5aGw1dkwwSU4yNERzTmhLKzNQek5kTlpBVSs5bmt2VW1oTUE1?=
 =?utf-8?B?V0c4Nkc4dXcvRGVmaUg2K3p2c2IyUG5DSEF2WUhob2p2TmNCSkVkbXNSRDRm?=
 =?utf-8?B?ZnN5ZlcxQkttMkVYcHhtVmFqQTBrTXhlV01kZHAyWVdQRDBnU2ZLVC9ZNEhD?=
 =?utf-8?B?SlJHREpWQ3VvbU5TcmRBZ3RCYktRekphVnBLc1ltT0ljM0NDaW5kckM3RkRs?=
 =?utf-8?B?QzVYYUVyaVprWXBiQzI4L3JPWlNjajUzQUtUWVQwQWRURy96T1kyUVVoVFJn?=
 =?utf-8?B?ODNYWXNFM1o3cWF3UmgyMlRNcHFoNUdwRGl4NG8zTHRNdVVvVVg0d2M1dHJz?=
 =?utf-8?B?YWRwdjNBU1hicEdzOGdpMHdzemZmcnlrbFN6TUt6emlRc0dKNTdPelVIWldS?=
 =?utf-8?B?OFY5MEYyalpLei9JY1RDcTJvN3NpTzZwbzRYWFdGSHI0VXozaVNGMUJYYmMz?=
 =?utf-8?B?b213SHJoYWVHWFI3NUlIQTNsblAvOVZzSXUrK3dweHJNa2Q4WXE2THFBYUwz?=
 =?utf-8?B?SEF3WFhma1ZBQlNLV2h4RndoYVY3Tzd2MUYrdUc1ZU1uZlJWbFQxbVhtd3Vn?=
 =?utf-8?B?R3ZURXVzUS9hajhlTTBYS2hmMnlhTWFad3F5R3F0dXk2Q1kzaDNkV1ZnOTlv?=
 =?utf-8?B?RWxlS3NVOUNoRjVTdWVVSlFEMTJ1aEN5bFFWSUZEZDhwc3lkUFFRcTUxcDZw?=
 =?utf-8?B?MUZmb1ZyYWc0a014SGVobms0bGdCby9TNjBiS2x2QjlOems0L2xXWmV2MW9p?=
 =?utf-8?B?RlNmV0JrM04vU25wRHo1Y0FuZ0tsY3FGV0NRMGtGcHJoM3RVUHAvVE5HTzU2?=
 =?utf-8?B?Q3hQZ2VLV3drVFNsc2xpcDJ3MjAyTU84NndaWnoyS0xTcDVqd1ZmUTZiaXJ5?=
 =?utf-8?B?UU9XdnRqcnJETk9nWGJRZzhrSjMrWGJsNTB0NTlEUnpvUTIyT3ArUCt0bmtR?=
 =?utf-8?B?Wno0cnJjMDc3SnBodnBrbE9CVmRVclozMEJyN3BCZG95bHhEcDNzL3pFUXNM?=
 =?utf-8?B?ZWZZWHdNT2YrWUdRUCsxLzlMc203VG1VVzJGTUVyK2JFTVNod3laU1JlOW9o?=
 =?utf-8?B?WGVZd29ERVhoMUtCVWsveTZhVTZ3a0ZvMU9oaWxJZzBjRTdmZU4yVjhCaVN6?=
 =?utf-8?B?R2JWYjJ0NUpDWmVvUWRKVTRySjZNRFQ2TE1jaCt0R21HLzJkUmhUQzg4QTVK?=
 =?utf-8?B?enJyRmRmN05jdEpqclh3VWxObVJWb1hrbzB2bkV2b2grLzIzc2kwS3RRSXJv?=
 =?utf-8?B?M0dSK3BvdVlYdktYWTZpZWc5QVBZdzN6WExud1lDT0lybGJPYlJidlVwVGYv?=
 =?utf-8?B?SGMwNXZ2SmdaZGRZbEtyL0dXRGhLbk54ZER5bUMyeXhxdEh4K0F2c2hDOVBD?=
 =?utf-8?B?M25UYmlRNEdTSU9PWndsTjZQYnVKTjlidy83bW5XYUx4VmZWeW83YTMyT0Yx?=
 =?utf-8?B?QU43QVJJUC92M3dJcElkWXdHR1g5UFNPWng0TWZXRUhld21ZTlJveVZrUHda?=
 =?utf-8?B?dFNEZWk2Rkh4UTFhOXZ2MWN0Y2t4bXl6aDRWK29sbFcxbk1xeTZyVUdkM2VS?=
 =?utf-8?B?RTBLWXBBbHRWYXE4eEFJNHVkUjRkN1MxTlZnQUFJaVJJSUFJbXdCZ3ZKR2dX?=
 =?utf-8?B?WktRdVlFVmVMcWE5RDhEYk1Mbm1pLzg1SHMwdUsycUNkR2xFNFhld2NWRkk0?=
 =?utf-8?B?aXh3VHpYSUt0Vm9zTDZROStZZHVlT2RWMi9WSDAyV09GK3pob3ZSVWE3SXlZ?=
 =?utf-8?B?NElLcFZGaS93SDhEbkNJMXd2QTlwZ1d3SDdNN3F1NS9kM2JIdzltcDNFcy9z?=
 =?utf-8?B?QzN1NUwwWVlRVzdMcWliZ0c4eWEwbEw4ZDZ0bFVLQTlzNTVFNVErTmd4bWVh?=
 =?utf-8?B?eWtXNVAvcytZU1BRb1g5TW9zdFhoQXFLaHljN0RZY1pSMHJ4em91bWgrRGgv?=
 =?utf-8?B?MGpaL3NTYklUTFFMY2RjUjBsZXIvV09RMG82YkVUWmRtNm9FbnNuVDJvYXRE?=
 =?utf-8?B?RHoxc2p1UlpNSFpVTnJHNzliZmtYVHpjY3psVUNxUEh4SUtFYmZzZkloOENF?=
 =?utf-8?B?a2NaTUFBaGpaYnhZd2dWVUFEaUNyQUM4bjZQRU5yak1BSDNhSGlEN3ZsbExT?=
 =?utf-8?B?QUE4VURZK3RPbzNBSFlaOXcrZUdRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9fceb6-adad-4075-b865-08de16c9d988
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:02:12.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Iy99hl2Bpsemr5sK52LdmLsn0AuvjuEr0QPJeG6GV+Yf6mQ1DixquWtENC1G2N6dRrHw4lav+UPfIb7YATS7djilVYSFJa058pf52mJwMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890



On 10/29/25 09:42, Matti Vaittinen wrote:
> On 29/10/2025 09:11, Lothar Waßmann wrote:
>> Hi,
>>
>> On Tue, 28 Oct 2025 14:10:04 +0100 Maud Spierings wrote:
>>> On 10/28/25 13:42, Maud Spierings wrote:
>>>> On 10/28/25 13:15, Matti Vaittinen wrote:
>> [...]
>>>>> Could/Should this be described using the:
>>>>> 'rohm,feedback-pull-up-r1-ohms' and
>>>>> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment
>>>>> correctly, that might allow the driver to be able to use correctly
>>>>> scaled voltages.
>>>>>
>>>>> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/
>>>>> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
>>>>
>>>> Ah I didn't know those existed, should've checked the bindings in more
>>>> detail, thanks for the hint!
>>>>
>>>> I will have to investigate this carefully, since I don't have access to
>>>> the actual design of the COM, so I don't know exactly what is there.
>>>
>>> So I am not yet entirely sure if this works out, I used the calculation
>>> in the driver:
>>>
>>> /*
>>>    * Setups where regulator (especially the buck8) output voltage is 
>>> scaled
>>>    * by adding external connection where some other regulator output is
>>> connected
>>>    * to feedback-pin (over suitable resistors) is getting popular 
>>> amongst
>>> users
>>>    * of BD71837. (This allows for example scaling down the buck8 
>>> voltages
>>> to suit
>>>    * lover GPU voltages for projects where buck8 is (ab)used to 
>>> supply power
>>>    * for GPU. Additionally some setups do allow DVS for buck8 but as 
>>> this do
>>>    * produce voltage spikes the HW must be evaluated to be able to
>>> survive this
>>>    * - hence I keep the DVS disabled for non DVS bucks by default. I
>>> don't want
>>>    * to help you burn your proto board)
>>>    *
>>>    * So we allow describing this external connection from DT and 
>>> scale the
>>>    * voltages accordingly. This is what the connection should look like:
>>>    *
>>>    * |------------|
>>>    * |    buck 8  |-------+----->Vout
>>>    * |        |    |
>>>    * |------------|    |
>>>    *    | FB pin    |
>>>    *    |        |
>>>    *    +-------+--R2---+
>>>    *        |
>>>    *        R1
>>>    *        |
>>>    *    V FB-pull-up
>>>    *
>>>    *    Here the buck output is sifted according to formula:
>>>    *
>>>    * Vout_o = Vo - (Vpu - Vo)*R2/R1
>>>    * Linear_step = step_orig*(R1+R2)/R1
>>>    *
>>>    * where:
>>>    * Vout_o is adjusted voltage output at vsel reg value 0
>>>    * Vo is original voltage output at vsel reg value 0
>>>    * Vpu is the pull-up voltage V FB-pull-up in the picture
>>>    * R1 and R2 are resistor values.
>>>    *
>>>    * As a real world example for buck8 and a specific GPU:
>>>    * VLDO = 1.6V (used as FB-pull-up)
>>>    * R1 = 1000ohms
>>>    * R2 = 150ohms
>>>    * VSEL 0x0 => 0.8V – (VLDO – 0.8) * R2 / R1 = 0.68V
>>>    * Linear Step = 10mV * (R1 + R2) / R1 = 11.5mV
>>>    */
>>>
>>> Because I do not know the pull up voltage, and I am not sure if it is a
>>> pull up.
>>>
>>> So:
>>> Vout_o = 1.35V
>>> Vo = 1.1V
>>> Vpu = unknown
>>> R2 = 499 Ohm
>>> R1 = 2200 Ohm
>>> Gives:
>>> Vpu = ~0V
>>>
>>> And:
>>> Vout_o = 1.35V
>>> Vo = 1.1V
>>> Vpu = unknown
>>> R2 = 2200 Ohm
>>> R1 = 499 Ohm
>>> Gives:
>>> Vpu = ~1.04V
>>>
>>> I am not quite sure which resistor is R1 and which is R2 but having
>>> there be a pull down to 0V seems the most logical answer?
>>>
>>> I am adding Lothar from Ka-Ro to the CC maybe he can shed some light on
>>> this setup.
>>>
>> R2 is connected to GND, so Vpu = 0.
>> With:
>>     regulator-min-microvolt = <1350000>;
>>     regulator-max-microvolt = <1350000>;
>>     rohm,fb-pull-up-microvolt = <0>;
>>     rohm,feedback-pull-up-r1-ohms = <2200>;
>>     rohm,feedback-pull-up-r2-ohms = <499>;
>> the correct voltage should be produced on the BUCK8 output, but a quick
>> test with these parameters led to:
>> |failed to get the current voltage: -EINVAL
>> |bd718xx-pmic bd71847-pmic.3.auto: error -EINVAL: failed to register 
>> buck6 regulator
>> |bd718xx-pmic: probe of bd71847-pmic.3.auto failed with error -22
>>
>> Apparently noone has ever tested this feature in real life.
> 
> Thanks for trying it out Lothar. I am positive this was tested - but 
> probably the use-case has been using a pull-up. I assume having the zero 
> pull-up voltage causes the driver to calculate some bogus values. I 
> think fixing the computation in the driver might not be that big of a 
> task(?) The benefit of doing it would be that the correct voltages would 
> be calculated by the driver.
> 
> If real voltages aren't matching what is calculated by the driver, then 
> the voltages requested by regulator consumers will cause wrong voltages 
> to be applied. Debug interfaces will also show wrong voltages, and the 
> safety limits set in the device-tree will not be really respected.
> 
> I think this would be well worth fixing.
> 

Do you intend to do this Matti?

Otherwise I will give it a try.

Kind regards,
Maud


