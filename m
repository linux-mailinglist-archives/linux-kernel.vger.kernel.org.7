Return-Path: <linux-kernel+bounces-879565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9093BC237B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31DDD4E9F82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5331430BBBC;
	Fri, 31 Oct 2025 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dbNmMD7x"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D03081B1;
	Fri, 31 Oct 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893911; cv=fail; b=ig9hcz3gdOHAYxUYb7hY/H/G4UFGpKy2R4a9cuz4SSvOMTqqW22Gx3kU4BjxEIJbenu1P1kSkZxvxuV0IHWyBWdEwFUMSymLYRC8BJphf0nRUwDEJUpXXFsp/4BcxHFWOob+VwjY3EP50vbb6Wfaogmi85QQQQfDl3nn4agBZF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893911; c=relaxed/simple;
	bh=VxS7VZ4oIPUP6FbiUJuPQhfeeYLX+9v7KFuzwivM4WA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=l+Y+Ujk5m9MnPzB59+n3HgWZFD01DhpR6yzo+RFCUP5StbwUmVdhmMq3RZA8lV3nH3TibkM/7Jxi95Ebgv8z7JisSTqqWBiyEx59QN6W40Be+Nm5hl+GKtHyw03O+CfYBmVj7HRklr6FBnzxvQ/qukFyiM9lCd+6C3X1A0tDEJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dbNmMD7x; arc=fail smtp.client-ip=52.101.229.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDfq4PIR8kU3CS5N7d2c3vnFS8vLSVeuedWFliRpvjpWErRjwuYyhSSm7M+bjcwUOu132tnNYarnPzbhpgRt5KMfsR+hL7a7Br6jn6RTfxdZeOiTWBDPx1PsuGY1LYvjBBhcSIkNxnTaEBZJxxFc6ktmgJ8W5ZzutgkMw7SKSi2XiI9/HCjZxYSjwN3rJu2lHTwB3QrykdczBLfM2bc5FGoiRnZo76OoO3zJvkHsxV8QFM8QFcBcQ9CnQYivQh3RsArWs0Z4vIvBd6V07X2E5b0wOhUBmnxt6l0iogYxO8WhLNo5cqaZvBRl9vJu1Q/ALFoAMIfQqHWvT0FnBJv3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBP6TWKdtBkohZxGvmqugBsR/ELwjmgTDcvCnyPs2ps=;
 b=gFLd00ZxKwfmTUSQro5C4c4rd9Bvb6nl/sQLRZkmlgOE0WPF04v124YhUTTd/rF42tNzimIlh+cFDSB7u8KyOqDINyt7YCG6/H6gL+MrvgAzJ/syR8I5b+ytspa+wHK3/ml/JaEISM0z21+d6LK5B1FdknglclehYrN3V9XAdTVWJKS2v6faKTQMPS0xqnpuBmusq/FM67lp7hvzXhQxmMKvvDBRh89QTdLyeADK+YnHM3aEPf7BC9/EROLCwDXqFXGRYJ9drO1VLBxgD5KHl4zgsggcTWj0Bzpa/hKD4cmxjp0zZNQiourrj4OVoobHf77ae2lYg+EH775zCIo81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBP6TWKdtBkohZxGvmqugBsR/ELwjmgTDcvCnyPs2ps=;
 b=dbNmMD7xrwEqYeZXoullmJPfMuKrwVritbZ90YJzmzPUlnKzY0LRjWdUyzERN2rwO8x3rd/1r2ZUGEF3Um2FXaol/EiExpxXWK7MhtN7ONdttajspv3uYyFWdWW/VZcvSNQiEKBrwGYYkNV9pBctsS9SaTJjuG/5H44lqwMImFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYWPR01MB9327.jpnprd01.prod.outlook.com
 (2603:1096:400:1a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 06:58:25 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%3]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 06:58:25 +0000
Message-ID: <87ldkr36cv.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: HariKrishna Sagala <hariconscious@gmail.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] ASoC: soc-core: proposal to remove num_auto_selectable_formats from snd_soc_dai_ops
In-Reply-To: <2daa603f-13fe-c803-17fc-4fdd8e5723ba@gmail.com>
References: <2daa603f-13fe-c803-17fc-4fdd8e5723ba@gmail.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Oct 2025 06:58:24 +0000
X-ClientProxiedBy: TYCP301CA0083.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::13) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYWPR01MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edf2e28-fd70-4af0-6c4e-08de184ae307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|3613699012|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnJDbjV3ZGErRTZPS2ZFcnBXM1NTdjBlR3pJN2MvaFZCaGdPTmkzMUdIUjk5?=
 =?utf-8?B?dzUzTEVJWGNiRDJnWStHSWZId01ZZHk2Vk9nU0ZZWHA2eUZ4WXlnYmdCNFZp?=
 =?utf-8?B?ZExpL0dtNFFrTDdabDEweEpyb2c3ZkoyM0VzL2xhNnhKcUJFRlY4bWQ3ME9B?=
 =?utf-8?B?RnVDR0M5RG1Yc1BHendzR3ZKR1VsaS92TEJWUmpQZVV4QkxrUTVBdW9XcFhT?=
 =?utf-8?B?UU45NlQ4bWUwOEhhTDIwVTdDbmFHekREa3dMNU1XaFpYY3JLalZobStNaThG?=
 =?utf-8?B?Q0wvUzFmdU8xcXZXbWJFY3RKNjlRRkpMSjJjZjV5ajlNWlV4d0lSVjhBTWtR?=
 =?utf-8?B?MjAzTGdrMnVHcmg1d2M0STdxSFZhY25vcEVVUytFdC9QSUhpNGdWWDZKejRn?=
 =?utf-8?B?ajVVRkFTTHAwcDZ2QkpUN1Q1SzFKQVpKZ2l6ZkY3MkVqaVlSYWJXSFp3VC9O?=
 =?utf-8?B?U21SdC9ORmQ5dUVJeE9wcjRxMFdwMDJEVjhrVzdmU2pZZnVESUw0dFBxcjk2?=
 =?utf-8?B?NVh3NG00MDFZZmJ2REZKaUlPMUpINnhRNk5FL29HR001bUxJS252VEJBVldF?=
 =?utf-8?B?Vml0WVZLazk1SWdhQ0Y0WGFuc1RNamhEUm1hVlVOVjZ4TEZsdGY0STdJV0xV?=
 =?utf-8?B?K2w1SzhZbU1GbmhWOUVleEhMZHoveHMyTklsM3FpRStLcmtwdkxhdktuaGwv?=
 =?utf-8?B?TFlPQ1VJTGJYVGlabHZhSjB4RXlyWVFjNUdCT0VIVXRMejBKWlErVzQ5TlZt?=
 =?utf-8?B?dEhaTnNiV0pXMDVNY2hnaUFvMlZNZStkbjFaTnZ4bmxtUUdSR0phb0pGN0ti?=
 =?utf-8?B?RzZ4Y3pRcWNMSzRDOWZXTW0vcm5VSHpOL0F3akFGZ1pTVHUvL0cvY0Z3TG54?=
 =?utf-8?B?N01hTjF2dEZmTElGdTR3NVVTSzA3cGYxN2t0RDEra3hGVGdTaXFnLzF3dlFB?=
 =?utf-8?B?Z1ZkSU1OcTJoOThNZmQvandNS3JMb2NNZDY2VzdTaTBwSHJTSkorTkpyYTdU?=
 =?utf-8?B?Zkw1VlNJcFUxb2l3WDJsZ0pRSGtjNjFwSGNOUDV3MC8ybFgxdHhPY1dUM1dy?=
 =?utf-8?B?VFdwOVFQMEpPNEUrMDY4YjhabXBXM0VUaWNvNHdtb1I5VFo2cjBSOUJ1ckRC?=
 =?utf-8?B?aHhMdVdZVzdWN25nM2hzbHdSL3dKTk5XVU9wWVJkN0VZY2FpNldtN2ZrN05I?=
 =?utf-8?B?UnJCWUNGRUJaK3pPTGVyUE9MZ09oWVlvalgvMU1vOWc5bzBQRitDZkMrYXQx?=
 =?utf-8?B?d3FpME1zNDF1UFFtNkJhU29lTnZOa3N4UjcxSmlqMGZtVjQySXBXVnRRWFg4?=
 =?utf-8?B?RHBrdmw2YjIwbkF1djFEMDArdVY1U3pyWlFmd2JyT082V0MwSVAxVGF6OGhs?=
 =?utf-8?B?VnI4TlhVZC9MclVqVVNOaDhoWWt6N3pZSG41NFhSdDE0SGNwTHdFVGlSVERx?=
 =?utf-8?B?TTZURjBiUHJ4ck1WNklEbWJhbmk5VzFvc2cwK1diUGtBMlJWZ3pyZ01JZVc2?=
 =?utf-8?B?M0t0aVB3MUVjbmhxR3NhUnQ4UDROTXdlaUdINldJa2RRTVJoMUV0SEJSSkMy?=
 =?utf-8?B?b1JDSnlkZVM2S0JnYTdYU3hVd3hBV2RJeDNFYTlETDd3Ky9qajdyWHp4b3Y2?=
 =?utf-8?B?Ylk2VGhxUXNIdnkrZ2Y1MWpGMHp5QWZ4SWRFVmZkNGZkdk1HMElXNEZ2T3ll?=
 =?utf-8?B?Uml0cG01akVHbytkdEY0WVJNMjNzTDUwMHQwdndXQyszYmU5Q3U4cWp0SDlX?=
 =?utf-8?B?UEc0Y0hPUjZMZENqQkdiUy85NHJuNFplcnIyNzduVUtYby90cTRXODVpcnMw?=
 =?utf-8?B?a1JMeTJwK0hDcDdoVk5wVU9nUEgvanJwNnlmWHR4NE9rS3RmZ0wyRFBtZ3g0?=
 =?utf-8?B?UG9CY3Q5WWJaSU5mbytQbWJ5WVFVYlN1bTVPcTNxd3ZjRlhGbkJXQmlsMnUy?=
 =?utf-8?B?Z1NsNDhiMTRqN0ZnaElRVFdYaXF3TnlVUmVOc3gwZ3YvczRPNjl0T3cwUDhR?=
 =?utf-8?B?YXZ4UTNsdy9MZnJadDdMWXltNVlXNFZNZ0hMeFdsSERPUDFuWmdHUGo5cXN3?=
 =?utf-8?B?RWIwQzdrWHg1ZmdWa3hIUGYvbTlYckU3M05odz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(3613699012)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpCMVNNN1FnS0ZlNlJjc0Zvb0lEcklVR0w0ZExPY1ltZTkyYzBvTDdPandh?=
 =?utf-8?B?d3Z1eFRSbzhUamFPaDhVcVVla0NtdU1XSWFEQkZmUkdQdXBQU3FIWG9yS3Ro?=
 =?utf-8?B?cm9FV2tOOEQ4SDIyZnRuL3ZOYzVhOGZaUUI1Vytveit2Ukk0T0d4RXk1aENM?=
 =?utf-8?B?Tm1pVXN6VC9UOVM1QzhoNVUrMmlidlVZbjU2SDBnOFcwYWN6SU1sWTlEV2lC?=
 =?utf-8?B?aVVvd1lRa0tkcm9CMmJQc2EwcDdoTzNmdytUSHQ3aWxtVmN3aHpwV25DSXRL?=
 =?utf-8?B?aGZVdEpxQTc1OGE5OG9YS2ZTOGZpSmpaQXRZZ0JXNTgySEpwQW9HUXh5cWs2?=
 =?utf-8?B?am1nTm9tR05qYmlGa0tVUXRHZDgrTURLNlhSWTZNUXA0OW9Ra0dpWUwzZ0Vv?=
 =?utf-8?B?NWdYTVcwYlBUb1Zhby9vZlFIc3Y0NGp3ZXFmRXdSakhXNUlvbndMbGlTTnNs?=
 =?utf-8?B?VVFRQVZxVUE1RXdqR0E0bnd0SGtlbGJNT3ZPQjBGekc1NG5rQXZmN1dvaTZx?=
 =?utf-8?B?WGRHbytnTzBhNWlSeGdMWnRVZTk5OEIzQ2ltQ3psYlhnQ0JrMWJBSDlGbDE3?=
 =?utf-8?B?SHRJREkyWXBzeGRacEQ3U0E3dndVZVZEb2RWeDNLbTVUK3RVbEd6UHVmSnFQ?=
 =?utf-8?B?TEtHc3FMdkYzd0JDdDVLNWx0K3IxVWdtdmhjQ2I4Q0w3MjFFbHFFMHRBVkx0?=
 =?utf-8?B?blNOTGhWMjNmazNQeVNWMnY5U2dlWkpXcE83S3hiT0VIU1JsN25HWHBQTkls?=
 =?utf-8?B?emovYlZMWDRPS3pHa1BLZUJhYnNEK25Vd2lDdDZvNFpiRlA3bG9aV1V1dmM0?=
 =?utf-8?B?KzJpZjIrNjluemNBQnlKUlp5K0xYSnU2NGdURnpvcGJGOFlRMWdLbVdqSzFS?=
 =?utf-8?B?QVBxZGpRak96YVNKZTcwaWZVVGF0SGZydC85V1B2djlSaGtFRnUwR1BWMi9K?=
 =?utf-8?B?N1AvSkFaZjByb08wdkVTbENWTCtqVXJZR3BtM2RHdVkwa1BPb2tES3VHSlJz?=
 =?utf-8?B?Y0lMM0YvV3A0alh4ZlcyQThkR2dTY2lWMFdtQ3FqdlJrcEY2Rzl3c2tUdFFC?=
 =?utf-8?B?NmJNSDRlL3Y4dDdQVzRNN2Rtd0VHZmRiaFdIMDZwNkc5QXF0SU55UldmcUtM?=
 =?utf-8?B?ZlNmbFZUTWtlZXljdWE0L3RkeDNwKzQvNG9iQUJ4ZnJCRytpL2dXMHlCTk51?=
 =?utf-8?B?OG9OdlBhdU5YWEVmdDNhblRvait5Yk9OU3BpQUlVQldwai9KSEUyOU4rUnZa?=
 =?utf-8?B?ZUlubjU3SlVGWkswNVcvNnZUOFpQb3dTc3ZoVStOMGZoMHY0K2ZIeTVWdHlG?=
 =?utf-8?B?cWgxOXhIczVqZ1dSMGkzNGlZRFBMSkozWWwwRERiRkZpb01FZERxUUtTTVM4?=
 =?utf-8?B?aGE3K2RQR1hjWW9nZ2c5anFZb2V2UUlrTk5uR2RXRjU3MEpsbVY5NnVGZFg1?=
 =?utf-8?B?dkc0ZkZyNURRRjQ5VHhlVUtoc0Nhd2FEQ1V0VEUyVXhyRHllQzQvKzU0bStB?=
 =?utf-8?B?aDlEbXVKVXpoVFVhek9rQVhyVDcycUN3MXcvWTJEZjBLRDJPT1pKQ1h4VUw4?=
 =?utf-8?B?b2dMaTBWM3ZQc1JnRXFoU291TlB5RXpuV3VrQzJZa2dTakNqUFhhcXFnZUgv?=
 =?utf-8?B?TjJKYzJUbXZZQXNZTVVGM1E3N3VGd3dHdE9IOHB6bDc3U2lNdXYxVUNMblBz?=
 =?utf-8?B?VCs4NERGcXUxb1FkRnhqb0srTjZzN0pMUUNDZ21qM3AwM2l0MU5UMzhaS3hy?=
 =?utf-8?B?ZTVpUGNoS2ZPNVl6UGlkVG8rV25xbzlRQ2NZMmRlaUN5S2xRdEJSSldSU0hz?=
 =?utf-8?B?Ulh4RTQ5aytwSDRvRkR0VEs2bnZUZGxQdUJZMWFnRDd0UzNldFRNd09Xdjhx?=
 =?utf-8?B?cXJTVDNvVUhRNFlHckVKQmJ3bmxldmlDelJIdzdWdHBxTmFLR0xCRE1weHkw?=
 =?utf-8?B?cEx6UTNiK1VWYVhnQ2RxUjlSS1ZmVi9wb2VMWFdLUjNGMzJWdVM1cVp0cHJX?=
 =?utf-8?B?NVBtS3VKVWhUSkQ2WXZyOFVXSmp2TFBxL2hxMFZiZFU2eDEzaWVHSmN3N2o0?=
 =?utf-8?B?OFBpWjBCa3k2RGllSnhnZlVBWHdKblRIMWxWYVZlR3RVZm5CREI3dUFWWDRT?=
 =?utf-8?B?K2hvVk5VWnVsUTJMMzNIczdLbTRaR25qQWlzZ3YvbkNYenNiVmpJb21yQ2Na?=
 =?utf-8?Q?UJ3UGF75NieGHxXij6/Hz30=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edf2e28-fd70-4af0-6c4e-08de184ae307
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 06:58:25.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLSiFfLoHpq0fQAe7lNZL0Gg7RuuMY+2tUW7w1h2A2vpBLp0enFUJragRW0AzvDpBeLuFed2GYZGu7vvN3M5543dcRK1Ks3dtrdaYf/hxW0xxqFnSQNpNNPxF4Qrk1Ln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9327


Hi HariKrishna

Thank you for suggestion

> I=CA=BCd like to propose a small cleanup and simplification in the
> snd_soc_dai_ops structure by removing the
> "num_auto_selectable_formats" parameter.

Do you mean like this ?

	struct snd_soc_dai_ops {
		...
		const u64 *auto_selectable_formats;
	-	int num_auto_selectable_formats;
		...
	};

> Currently,snd_soc_dai_ops includes the "num_auto_selectable_formats"
> field to indicate the number of entries in the "auto_selectable_formats"
> array.However, this count can be derived programmatically using the
> ARRAY_SIZE() macro wherever needed.

If my understanding was correct, unfortunately we can't do it.

We can use ARRAY_SIZE() in each driver, because we can access to raw array.
But can't use it on ASoC framework, becase auto_selectable_formats is just
a pointer. see how ARRAY_SIZE() is defined.

	--- driver ---
	my_formats[] =3D {
		[0] =3D SND_SOC_POSSIBLE_DAIFMT_xxx | SND_SOC_POSSIBLE_DAIFMT_xxx ...,
		[1] =3D SND_SOC_POSSIBLE_DAIFMT_xxx | SND_SOC_POSSIBLE_DAIFMT_xxx ...,
	};

	// We can use ARRAY_SIZE() in driver, because we know raw array.
	my_dai_ops =3D {
		...
		.auto_selectable_formats	=3D my_formats,
=3D>		.num_auto_selectable_formats	=3D ARRAY_SIZE(my_formats),
	};

	--- soc-xxx.c ---
	// it will be error, because we don't know its size
=3D>	int num =3D ARRAY_SIZE(ops->auto_selectable_formats);

Or do you mean create new macro, like this ?

	#define ASOC_SELECT_FORMATS(array)\
		.auto_selectable_formats	=3D array,
		.num_auto_selectable_formats	=3D ARRAY_SIZE(array)

	my_ops =3D {
		...
	-	.auto_selectable_formats	=3D my_formats,
	-	.num_auto_selectable_formats	=3D ARRAY_SIZE(my_formats),
	+	ASOC_SELECT_FORMATS(my_formats),
	};

Or am I misunderstanding your suggestion ?


Thank you for your help !!

Best regards
---
Kuninori Morimoto

