Return-Path: <linux-kernel+bounces-733125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B15B07083
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FD950564B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518B2EB5B5;
	Wed, 16 Jul 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HgV3Uoa7"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012053.outbound.protection.outlook.com [40.107.75.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2722EAD10
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654482; cv=fail; b=YtCsivOZF+YOHytoYmrUKIulfwJoaFYXzYzbzYK4ZsZO1vhb2Rb3mrtjphBR0EDsFSP3Jl5WluucRMaydJRk1lMN0bE7FMRsD+CDKG9nu8qEPRNkxBnKmL01KG0T+zSxyf7IHKcxCunVy2b431EYz3hUaxKpdQhU0gVo4WjJT1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654482; c=relaxed/simple;
	bh=Rcd3euyQBK3ytzHwECXLodl/EyDocCm7n2W1h7whVd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=be7SaX6rUrJJ2KYTjkQauhL8utGC9xH35bY8uLnJylAmwWjmcKcuSaANcWtDUrhjyJ21VMBzyajb2B8zk/dNXa6M4hd3Vg6CE7GvynS5Knry88o79QbhsqxCict8aPdLt7NwZuJqr78Kkol5yq67NSdYvRzK6ar+l+KxZOJDwwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HgV3Uoa7; arc=fail smtp.client-ip=40.107.75.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoA76FH4HK5EHPaXMAtB8rkrlvh0BUrNvyM8OhMhBjbHHoGIQXNCbPb4XGLpk1n96um9IaxmUfdOtD6ZzGF9OxcbyRvTWmAfHOvrBylrapp2MVuLIkx4MWVj1sXWdj7/olaVsRMJ3KdncbaSVWzYQi/eWqo/ryqIEy88KrJNDzEmRDJkkmPHYEK0z6GSJnY8EiSpay1pwFhTzytZJqmgRgeVndfqG2G4ANcNpwmBKCVMBFutfMibDUqdKk4jDUFMgLSxP1HNmTvC250f0DDC4X++zQBHnMFatUNA3DTzwcIh6Qv4RYdToxRteWv0/nrIxLbmBxnKhdjoerKOurr74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41MjVr8l6vSUjYXnQpWFoaHSQw9G5PoPMSlDdwVD4co=;
 b=XlBXWsQAuVR204aUxosRYXLKqOQfjZ0gvG6kQq8+QWx0q+1KEDARVhuu5ZF5Ta8NcOvvbCJhK1EvWB3w6byP6++XnTuZto40S2DKeIhAmI3ivV7Isba6ahk0AUhx56I1RiYv4nFr6lcor0OjvLWnD9TA1wHbosJrs8bV9a0x6W8Mwgcbdsu4bI8lpECcGubXanqtVyTVwQAObBuujhjqRRhvvnB0LsnJfyjMD0BEJkp5PzmodmQRviZTE6ZWedxXnHXj3X1KIbPl4EDm3l0TLul7QYkD7tjzPMMaH9wLcKKZXgH1BDXzhAXtXnQvRNXjIypKP9OIJ2IFF5ha+eRV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41MjVr8l6vSUjYXnQpWFoaHSQw9G5PoPMSlDdwVD4co=;
 b=HgV3Uoa7yXBwgOF7a4GlJ0wTG8T064r3lsOpHxDfqPHBCERTVGy7EfLm4cWOsTGac5WXtOjbXU+oer49HeAYiNyItnUTbU+4UFzYsRTrH1XyWfKlCB2kLxlKYJ3/WGHzO85ZX5V7hTeLYUkkyEUmzbXl48prJb15WFRiEMKFuPtj4CgOhqwoWwM+U+AyPJsEAcsXumMGOdPGklYf11NJA7zvWZPhUaSMHGiwAxcZA9Nm3+ZhYBuEhaXOj2vGNJG7yBYUJIUg93KUjlrQXh5pB/7HdC6QSWMG5JhJeY02Gd6K65OhdfzaD0W2rIk3TquaxNpldkUmCq9dq3/6B/T4gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by PUZPR06MB5697.apcprd06.prod.outlook.com (2603:1096:301:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 08:27:53 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 08:27:53 +0000
Message-ID: <4366bf0f-64a1-44ae-8f81-301af2d179d8@vivo.com>
Date: Wed, 16 Jul 2025 16:27:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: Jens Axboe <axboe@kernel.dk>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
 <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
 <51168786-6c30-4065-be82-6d07b2ae74a8@kernel.dk>
From: hanqi <hanqi@vivo.com>
In-Reply-To: <51168786-6c30-4065-be82-6d07b2ae74a8@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|PUZPR06MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: b8badca5-90fb-4a6e-a45c-08ddc442a851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejZGazBRYW9ucks5T3ZHSlY5bnBNd3U2eC93bW5SMGM5N3pYTWYyUnBPSUlo?=
 =?utf-8?B?ckxlU0pLOTUrVjQ3dzlEdjM2eDNLT0xDaGpSbzlleUE0RG9CMjNnQWdQRkUz?=
 =?utf-8?B?bHgyek1vTHM0SDdlci92Tm5RWTJBdVFRdVNBejNZNk9CWUJuM0tXd0ZFWTk2?=
 =?utf-8?B?OUpvWlJCcUNveXJwR0NUQTlaN2Y3b0VON1pkNXRoOURtZTUxUitJOGF4dXB4?=
 =?utf-8?B?N1lGdStEcFFrbDdaelIrbEFmN215Uzc3cVpTVExXSlpoaERUU2xqOXZZenYz?=
 =?utf-8?B?cUxGR2ZCS05UM1F3K3NHenhZYXp1RTc5OHVzdTBNdjNWdlB1SlA3SEpNdE9Z?=
 =?utf-8?B?cUpsZFk0U1QvV1BMdFpFMXJSUEtaRllRUUozOFV1TlNVNjV3VVN6UFpqT0tn?=
 =?utf-8?B?QVBTSEJ2S3h1RHFPNTFhRithWXVENmh0TXFmbDdNdUdyQno4TzdOZHpCUS94?=
 =?utf-8?B?RzcyR0gvWHJkZEYvQzArQ2YwMHZ6K0h6QW5jaGtybnRuUkxLVnpseFczZjJM?=
 =?utf-8?B?OW0wUHJoeHlZTHNXMlF6dDlUUHMwU244OEQ0UnhPcmVtTWRIR2dXRnNtVU9S?=
 =?utf-8?B?QWNJNDVBc3pkRGdscFprMDJMMmY3RmU4VldSL3piQ2paTmFXRzQ4ZFova1E1?=
 =?utf-8?B?bndrOG51bVNENTFUdC8vWFVxUHVUNHFhYWtFK1FqaDBtSEJuRHRETXAzQkxW?=
 =?utf-8?B?S2lGUi9WZVVQVlozMzFubnNxay9PNSt1LzA5VTZPZWtmNnZMb2ppOUwwT05S?=
 =?utf-8?B?Z1hQNEJ4c1R4N3pTZEVGMldpamFpVTZiS3lXUnIwbktxVTA0cGpYVmE1QmY0?=
 =?utf-8?B?azdzbm54ZjhTTHZQWTVnRlZRVzA4dXd1ZzR3T29HdjVxY0lIWEg5U0E5R3pX?=
 =?utf-8?B?dkl5SC82SVl2aHZxZzJGcVV5UDRJUjBKRCtybFBmeDNEdkFUdE1TMXlHWmF4?=
 =?utf-8?B?dFN3WFZkcSthUWtQdWNQU0lrbldJMHVlT3l1QytiNkRTbjhxczJ3SkpVeENB?=
 =?utf-8?B?NlhOT0Z4TzR2bHJROVdCUXBDeFRHOGV2K0pBR3A2dENhNFV2Yi9KcWhPR0l5?=
 =?utf-8?B?S1BMMk1zR0M3NzhueitTa1dkNU9oaGlxTEVreEd1Z1RjWTRLM29jYjFrUTFE?=
 =?utf-8?B?R3ZCYXpweEZMZ29JZU1FNmxYdXkzVGNsbkRyOE9QbWxmWU5KQ0ZMcEozeW1x?=
 =?utf-8?B?S21iWnRBaHduOE9oakpsNlBNTlF4cFFTTXhSU2puemtyTTFIaWJFSHNUdG10?=
 =?utf-8?B?MzFXbGZ3K0I1eEJLbDQ3NVlKS1FBUmJublgxR2w0bHBXL2FXOEZMVXJsbkFY?=
 =?utf-8?B?bXpST0xiWTh1cS8wSG5tTndNNTREdHRLRnpmeCt2UFJvaUE1U2c3ZW14TDJo?=
 =?utf-8?B?empUNFczcW02UDErbFVibVZWU0xjTVJ4aG1JNzRUNXozSVBLZ1FYeHVOTzl5?=
 =?utf-8?B?U2xHWE00dXFWUERJazBlWUQyYVRhSVdzbVliaW90dlJjU3lPYUgyWkJ0QUNt?=
 =?utf-8?B?NWZ2VWNoUTliRWI1eTNwU2xhVTZ1UFVCVTZWS1UxNFQ4cG8xM3FrTDIyU0lx?=
 =?utf-8?B?NWJqWmhRaXhhZWpVVWREcklaR2tNQTk4MTZ5UWcyNGVucWFxK3VFdDRaMERu?=
 =?utf-8?B?eVFiemROaGZKcWxnSy8vYTBpSFVMczc0WWx5UU02QU1zQmt6MFZNcHNVeFhN?=
 =?utf-8?B?aTFxTjBOSlJvT2Z6Y3FvSytNbkY0MXZFaWlOQUtVZkNTd1hiTlUvdTByY3RU?=
 =?utf-8?B?SUhYd0dtMHBiajdwY2JwYkI5eGNucXBQbkcvaElVSmNnb2ZNYnZsRSt3TG9x?=
 =?utf-8?B?TEg0WUFVbmpzVERsMzlBTXRuejVva1BuL2Q0dUx1d0wvWE12QXRnV3VoOStk?=
 =?utf-8?B?Ky90RVJ1cTB3Wno2M3FjTDExakl2Zi81bXlrZWltT1F3NTdlRWdSZUVPeXN0?=
 =?utf-8?Q?hm9jB6asWrw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdCVVZVRkczZklqTHFwbjRkUFhUM0NOdjMwdTdMUjZVSDhycWloRXgvQ3V0?=
 =?utf-8?B?UEtLMFhPYklCWW5IR0lobEIrK0dueGxnb3pnN3Z6S0drZXpZbE5DOUh1aXBo?=
 =?utf-8?B?UVFucVlSK2w2bGJNcWhXNmVMMVdHb3kxT3l5VGY5aEdONlhmdUlHaHJ1NWtW?=
 =?utf-8?B?OWdJcmJ5VnUrS2pzUkNFUUtBTXNXNWlBK0xGQnRuby9nM09RZHphNjR2SlZB?=
 =?utf-8?B?TmxCQzdKWksrRTg0VWZNZkFSWGRXMjNvaWs3MEUrNFpwY1luYkpWUEpYMUY1?=
 =?utf-8?B?UTBwbmRPTE81eHR0d2dhZFdJVk9yR0UwbHo4bUlWeUlRN1BGd0hsQzE0NW50?=
 =?utf-8?B?eCtlTXFGWVhRWVk2QTMyYTVubTU4VU1rNW0vdnhRTlJTRTVTVTR0RENVS2Vm?=
 =?utf-8?B?ZGd1a05XRlVIaytkcGRHOUFyWktZcUJ3NFV3dEdBcnc2ajlMZ2VRU3NrZ1NU?=
 =?utf-8?B?bmRLOHFxb3l0aU5jYTZJUnRPcTMySUw2ZTROWHROVFI4a3F4Q2VRSDcydDli?=
 =?utf-8?B?UXVkTGs4bFAwcXhrSDBIQXhqbW40S3VCY2RYQXRpZGpYTzRwU01PZFhXL0dC?=
 =?utf-8?B?YkI5YUMwd1E0UGl1WFVLYUh6dG5ReGtqSVlJaUxXQVFDZ1Y5OWg1aS94M1VW?=
 =?utf-8?B?VlJyYmcvNGVkN2xDNVdjaFVEbmtQOWJsb08xdkt2REJFYVdjVWFGcE11di95?=
 =?utf-8?B?K0FjNVlvZnRnbTZleHRRZERSVlRTaXc0UTNkaWpjNVZBdmplcVlnS1FJVjg3?=
 =?utf-8?B?VEdrNGMxMXQwQzQzbk5MQzZjcHpkbWQrNlZScjhPY1M0cjdYaytkM2N5YzZt?=
 =?utf-8?B?QzBYYlltVTRIYVI1TEpEQkNBMXMxc1A0dXhKOUFmSmNoOC9oVFR6U2JqWjRQ?=
 =?utf-8?B?aFN0V3I3M2ZsNmtuSzhxMVAyNnFiSmdKTWd4cFNHenFnN1NNeTluSkJNL0ds?=
 =?utf-8?B?STFDdFhwVmtqRGtuSUxjTTdJcHlFSGNJaHBEdE1takdHWGtKVHZPMVYzOUhM?=
 =?utf-8?B?Y3ByRmduU1VnS1RuVCtPVFExUXlRdEhaV2ZncFJuMHNsOGZDamtqSk5CdTlM?=
 =?utf-8?B?L1pjZ0tITmhvMWptZ00vbDRlbFMzSG12T2t2OGM1bXBDbWNzUkYxazZWaVo5?=
 =?utf-8?B?SG5lblA2WnpJWmNwTjV5OHgrK2FWa3JVMXd0ODhmNWZJc1JRa3FWR0RuZFRP?=
 =?utf-8?B?U1BJK2V1SkRKdkNZWElWT3hkenJ1Lzdib0xaZXI0Z2psOEZ3Z1FvY2VsSE14?=
 =?utf-8?B?UWdybHdLdGFZL3lKbEs1L1VkNEtLNEpkWWxjZGNsMUg3N0s2KzdiNU5pNC9q?=
 =?utf-8?B?UTBZSXZUTEJkWWJESGJ2aTJFUnhETkYyeExLUGdrMExHMjdaNWVSLzdYWUJS?=
 =?utf-8?B?ZTZVUE1KTzZib1U0Tk54VDZqOUhSZ21wQmV6bWw3QVpNU2RrVkVoRGhodkdW?=
 =?utf-8?B?dFV1RWZGcys5NDhOajIxb05mU0FPcUZSRlF2LzI3U044TlZvVE5BZVVDMG05?=
 =?utf-8?B?Smp1eloxZlJud0kwRWU3bWIwQ0N4VzRncWY2WmNlZkppQkFmTDY4MlVVMzkx?=
 =?utf-8?B?TDMxc2xFeHhBajEyaXFTVVN4ak82c3N1MEliTzZDV1VHSFlFMmt3dmFnSUhh?=
 =?utf-8?B?SGVaMmNkbWlpSkRtNlBEY0lraTR0R1gzNEZvYXJ5THNPU2tZam9hSXpoTlBI?=
 =?utf-8?B?emVOYzJ5ckxUTy9ITDhBVVVpSitWYmlTTDdESkFHRE9uUGlLUU5SYnFab0hI?=
 =?utf-8?B?QWlaUk12Z205ZGxJZ1ZJcU9KRUdFVWFLVHR4R3lVZVByWTdydW42VVhNMjlS?=
 =?utf-8?B?aWk5QWlkY1pWd28vdDZzK0pqdGs5VGhCNER5UnV5ZmtUa25VU1NEbmlLb0Nw?=
 =?utf-8?B?azYxa3NBb2R0U0ZWRlIxbCt5M3FLSXoxNmlqOUZCd2Z0WUtVTUpROWprb3hU?=
 =?utf-8?B?Rkh1OExLaVZFYm9yeldGY0ZIejJWRHZlRGFLamQ5VHFXalFON2JWUjlVQkdX?=
 =?utf-8?B?SW1kdFhUUVNkS0hCdkFqNUNWM2FnOG5UQUVQYlFySCt1Sm0xbDRXQnZIWVEw?=
 =?utf-8?B?Mkd3UjgyVVQ1UTZJM0lQT3E1NjFCc3pPdWxVQjFxTWtBdkk2R2RULzIxbWxB?=
 =?utf-8?Q?LcU5EvxIrjgtFZ/PDFWWFjYML?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8badca5-90fb-4a6e-a45c-08ddc442a851
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 08:27:52.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOvKiHHKI3uIa2Hu/BAhfds2EVAA6Fv1JCfiW9+TcNuUWBjnkOf5HKQh9OBjSqCm+zXz3PaZAhmFuWuJd3pZPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5697



在 2025/7/16 11:43, Jens Axboe 写道:
> On 7/15/25 9:34 PM, hanqi wrote:
>>
>> ? 2025/7/15 22:28, Jens Axboe ??:
>>> On 7/14/25 9:10 PM, Qi Han wrote:
>>>> Jens has already completed the development of uncached buffered I/O
>>>> in git [1], and in f2fs, the feature can be enabled simply by setting
>>>> the FOP_DONTCACHE flag in f2fs_file_operations.
>>> You need to ensure that for any DONTCACHE IO that the completion is
>>> routed via non-irq context, if applicable. I didn't verify that this is
>>> the case for f2fs. Generally you can deduce this as well through
>>> testing, I'd say the following cases would be interesting to test:
>>>
>>> 1) Normal DONTCACHE buffered read
>>> 2) Overwrite DONTCACHE buffered write
>>> 3) Append DONTCACHE buffered write
>>>
>>> Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
>>> doesn't complain, that's a great start.
>>>
>>> For the above test cases as well, verify that page cache doesn't grow as
>>> IO is performed. A bit is fine for things like meta data, but generally
>>> you want to see it remain basically flat in terms of page cache usage.
>>>
>>> Maybe this is all fine, like I said I didn't verify. Just mentioning it
>>> for completeness sake.
>> Hi, Jens
>> Thanks for your suggestion. As I mentioned earlier in [1], in f2fs,
>> the regular buffered write path invokes folio_end_writeback from a
>> softirq context. Therefore, it seems that f2fs may not be suitable
>> for DONTCACHE I/O writes.
>>
>> I?d like to ask a question: why is DONTCACHE I/O write restricted to
>> non-interrupt context only? Is it because dropping the page might be
>> too time-consuming to be done safely in interrupt context? This might
>> be a naive question, but I?d really appreciate your clarification.
>> Thanks in advance.
> Because (as of right now, at least) the code doing the invalidation
> needs process context. There are various reasons for this, which you'll
> see if you follow the path off folio_end_writeback() ->
> filemap_end_dropbehind_write() -> filemap_end_dropbehind() ->
> folio_unmap_invalidate(). unmap_mapping_folio() is one case, and while
> that may be doable, the inode i_lock is not IRQ safe.
>
> Most file systems have a need to punt some writeback completions to
> non-irq context, eg for file extending etc. Hence for most file systems,
> the dontcache case just becomes another case that needs to go through
> that path.
>
> It'd certainly be possible to improve upon this, for example by having
> an opportunistic dontcache unmap from IRQ/soft-irq context, and then
> punting to a workqueue if that doesn't pan out. But this doesn't exist
> as of yet, hence the need for the workqueue punt.

Hi, Jens
Thank you for your response. I tested uncached buffer I/O reads with
a 50GB dataset on a local F2FS filesystem, and the page cache size
only increased slightly, which I believe aligns with expectations.
After clearing the page cache, the page cache size returned to its
initial state. The test results are as follows:

stat 50G.txt
   File: 50G.txt
   Size: 53687091200      Blocks: 104960712       IO Blocks: 512  regular file

[read before]:
echo 3 > /proc/sys/vm/drop_caches
01:48:17        kbmemfree kbavail     kbmemused  %memused      kbbuffers kbcached   kbcommit     %commit   kbactive    kbinact     kbdirty
01:50:59      6404648   8149508   2719384   23.40     512     1898092   199384760    823.75   1846756    466832     44

./uncached_io_test 8192 1 1 50G.txt
Starting 1 threads
reading bs 8192, uncached 1
   1s: 754MB/sec, MB=754
   ...
  64s: 844MB/sec, MB=262144

[read after]:
01:52:33      6326664   8121240   2747968    23.65      728     1947656   199384788    823.75   1887896    502004     68
echo 3 > /proc/sys/vm/drop_caches
01:53:11      6351136   8096936   2772400   23.86     512     1900500   199385216    823.75   1847252    533768      104

Hi Chao,
Given that F2FS currently calls folio_end_writeback in the softirq
context for normal write scenarios, could we first support uncached
buffer I/O reads? For normal uncached buffer I/O writes, would it be
feasible for F2FS to introduce an asynchronous workqueue to handle the
page drop operation in the future? What are your thoughts on this?
Thank you!



