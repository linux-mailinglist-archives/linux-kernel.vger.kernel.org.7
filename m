Return-Path: <linux-kernel+bounces-751518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D4B16A87
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E41E566868
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FC423B61E;
	Thu, 31 Jul 2025 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Uv/6KvHs"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012042.outbound.protection.outlook.com [40.107.75.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AC238C2D;
	Thu, 31 Jul 2025 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929905; cv=fail; b=UPmgFUiim1xccM47z9p/fMQ8b6EskvQbyngioFnaeFrAJmihUgGDBiGg1KzE9EKuDn2/2bKP+RFYNKsZAyfAAGhHFCWWLPkkMDSzowsGoEBSWwrsh9SbyhEBCOMPLcuvy7GBd3qA905JDe5ps1B9mfs/u77VgccxwJpAJBlv/tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929905; c=relaxed/simple;
	bh=+O6dHfaf39YcobKY7nEgqg92EddiRNtW4Xj+ycGRP3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eWShYmvzoCZ2Ce0CFBCG8P6vBy0GjekjEVsENH1vwTR8AtI7Cayu16QNzglTeaAEzAjlcb17hp4E8UCdPkTg4ocxgHSbQL7nUFhasUOevvJlu+dWagx0pSKhRJTVyft9gnAIkyYi4rL3afvI6P0EhIut1+1cFqlbdRYkm24LshY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Uv/6KvHs; arc=fail smtp.client-ip=40.107.75.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPCESA9HTuD/KfifycLhbiYWnZah/WOVA77Fk2Loo2svprsCIolVuPhtc12pO8a+rVzbc4nXgQZ1hQHyu5YOShZaHd2LTnX/Yc10UR34DRpoTfbn8Lgf64NyTQdiVioo2J9jrVTJzXO4lkf78wAYyd3Ii9IFgQ+3SHcoN9iSxYr1oytX9LFfZrwIjbAldY+yX0i0D7ZqVuYYxj3PVJwVm0qNB7W3P1rcBhKknkOM034utcZM4VfYKvJSQ9XsShvH5No96Hp0nEpJZMlsNRNPXr1mBDz0YgZo7UlYLQukihw21piGCegKTSdXuyCukE1lR5TN9fDnrnYUaPbbdPwZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ML+RJmsU5BR3DAb0TtE93kTiXaCIUWtGXG5UdG3uzQ=;
 b=VsBuHl3Uq12RKQsJVFT/eTY5OleNEjdskRFOmhWTmS2YLXeKw2W32YuIH+ZYeLhn+5bllzad31Znk1GhR+zhTvObi0ApugsQQtmE3aA2l9UTPmwjuQyFIPBrhJarLVU0NpeiURtxsNK61OmJODZiguM35LQ/5hFdynTEnweM4+Nx3A/lhPwuYt1yVltBx1PJPYW5O560qlpZpeJjTuB07CP+utjUvad09t7afYG9FmRL7Msoj9kYLQFzOPFJU7s/GyetIMi46dtqKYhoBjhDDjkqxSZiupxGGAvg9gZ+qvSlkvIDau/97gX3hvon4qYJrd+Iw779mxVhOegvHfcuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ML+RJmsU5BR3DAb0TtE93kTiXaCIUWtGXG5UdG3uzQ=;
 b=Uv/6KvHsQto4r1+F1uVL6X41jlNhe4j5F2iu78ZvFeMIZiRH0EiMI4j/HlSgiFo9kdEGZpVyiW3g3yU1SPbiAOEoggwHrreU6XK6UAMzrP3JBVtHZIIa82uiMPZ+o+KjJa2xNn/FTQnV7TDycfauu55RTg/mWswo4ZRK4Tb5N8MQsbOg4pcwWphfyfvoOtb2qJcAYMnAiESNDZ0S8arRsw32jeGZdsin997IZkBqPqVewVueI36lXp5f8nCeBttaQ0HXiRFK8gm4g/XnIRZJHmmtJPMN8xBUG6kmOmitbTypx3PmA3xO7HaoArrah+qa0Tz19oWL0j2wxDO2AcS8/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by SEZPR06MB5389.apcprd06.prod.outlook.com (2603:1096:101:64::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 02:44:54 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 02:44:53 +0000
Message-ID: <8b5162ba-2419-4552-9623-d73772d398b1@vivo.com>
Date: Thu, 31 Jul 2025 10:44:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, tglx@linutronix.de
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 miquel.raynal@bootlin.com, Jonathan.Cameron@Huawei.com,
 u.kleine-koenig@pengutronix.de, angeg.delregno@collabora.com,
 krzk@kernel.org, a.fatoum@pengutronix.de, frank.li@vivo.com
References: <20250730062554.269151-1-panchuang@vivo.com>
 <20250730062554.269151-2-panchuang@vivo.com>
 <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr>
From: PanChuang <panchuang@vivo.com>
In-Reply-To: <2afd89be-713e-4075-b91b-36ec7fb6072d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|SEZPR06MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aefb62-6e04-4f9f-b64d-08ddcfdc3a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEhjd0tiNVo2OFJoQlk0TlUxdCt5TUMybUF4M0dteloxb1VvdXI3QmRvRG9L?=
 =?utf-8?B?Sy9FcVZncGYxMjZkRmtXK2hMTjhVUXJnZDYxWXN3cDdsNlp1SHNOais1cGll?=
 =?utf-8?B?K0o1ZWZYU29GMzZCVlRKVWI4UjkwUDdnVlZlbzBaVmhDN1RLT2ZmYUc3cGJC?=
 =?utf-8?B?R3cvOEU0blR3Vng0ekhEZ0JjUFo0aUw4YzdYT0svUm00TVNsQjFnYjRXZGY2?=
 =?utf-8?B?d1g3TllMZFZxanpJbHFnWVh2Wkd3L3dIVjYveWtMdmdHb3hOU2hrNnRCKzJG?=
 =?utf-8?B?V2VGUjZnVVpxSUR3VnVKVW4zajBUZ21rVkRGRXZ0aDhpNW5ucTJIYUdmZ3BX?=
 =?utf-8?B?a1BIRlVTVEFRek95RERBd012SEg3MzZTdzc2Q1pHK1hvZlMwZE9ITklIRHd3?=
 =?utf-8?B?U3NKWnZzZlIyMjU0MEQyc0NwQ3htbVNoWnhtUC8vWUZ5Yk1KWnIwQmJMam11?=
 =?utf-8?B?Y0kza3B5Q1dTVzdEYnpJYjNUQmxVUkZtYUZHeHdiOHdrbnM3NHgrRTRuQmht?=
 =?utf-8?B?V2NxTHZ1MXc1RFVkYlFvNG1vdHhvTGJjVU9qdDBtSWlxMFYyS2VJemY4T3o5?=
 =?utf-8?B?YUdPTy9OcSt6cmh0d29SMXJOKzhvSXlIQ2pmeldUM0pzcm5TNWhUNjhoTjNV?=
 =?utf-8?B?MkEyME9XK0YyWkJSR1kwTlh6cHN5YlhkcjluTGxydlRvanArdmhhTStIZ2gy?=
 =?utf-8?B?N0JId1FHenVPSnJvY1ROY1VESDdWTExrbkRIQitEUG1oU1lkeHYzOGZudDJX?=
 =?utf-8?B?L3p2UWtIZUJNejN2WTk4NFJpOGdRQnp0UlZlUnFMc3BWaUVsUUZXQlV2Z1dh?=
 =?utf-8?B?NzZ2ejdOV0NGR3pDWm4yTERtS1NncWluWnZFZ2o3OTQ1QXM0ZUFFTHNZTkt1?=
 =?utf-8?B?NThkWmxxaFVmZzRjTUZEZlFkQjBTYy9WUjV3OUJaYXg3dDZvTW9uVXlqcldz?=
 =?utf-8?B?ZXpxUXZBdFo3T3FkU1BhRDdudm9PbFlaUE1xTXBSZ3YwTnhSdFlYUXFmQURZ?=
 =?utf-8?B?U3BHMWRmbWtpME9VYXZ1UnFOYXhNVEh0eW1RSVdYNzJpOWhHRTRmL2RCODg1?=
 =?utf-8?B?emdoQkRPZVBhWVhhTjl5VGd2T3F0aDI0Tjc3WnJHOWFCUmplbCtrMmZFTkpF?=
 =?utf-8?B?Z05YVFIzc2J6dEY2dFB5aldxdngwckZHdERobFRYdndlblZyZitPdzRVNEZm?=
 =?utf-8?B?K2VmNUpsV0hLZDBBSWVqNWZYa2dIYVozWThZcU5PZXNtb3E0SkNUa3FWUVpF?=
 =?utf-8?B?dTB4Ky9vSXZIckFKMVhLOG90U3N0ZDVTZXNZaWJhOGV4YkdpR25XRThQSlhD?=
 =?utf-8?B?a0o4a1dTenNkbUk5L3hNN3RBMyt1cExJOEhWMnp6Ull5VC9pV1ZsZzdoek1Y?=
 =?utf-8?B?UWk4OFcvWFBjU1p6RmRrODhXQU1RdUl4NjB5N2hnQjB5NXIzMDRiY2Jrblg1?=
 =?utf-8?B?N0RLZ0ZsV2YxSjJpcnZOeHdUdmgvcjdna241c0xBL1BUY1k5dTVzaUs0QmpW?=
 =?utf-8?B?a2V3VjRyenBoNC9rcFZLQWpaSnp5Wm8yQXFpN0orUktOeU9zTVZkRzVKSGx1?=
 =?utf-8?B?RDNCK3hWcGVhMmNDS01SbndnUFV4WFpDdTRQWUFZYmFHZ28xYkVIUWVLZ2kx?=
 =?utf-8?B?L1VZakJ5M3ZMNXF6L29vSXczRWxlNUVWUFJSSkdFUldIZ3pBbm9XS3ZyblF2?=
 =?utf-8?B?YzFsay9PNFFTSHZZOTNVVXNKTzY5WkkraVdsS1o2cmhZc3lPVVgyUTNHdzdE?=
 =?utf-8?B?eVhDOGtqcmVTeEJ5QVcxM1FuTEdyeHRoek56Y29ocGt5bVROQnZMWEVMejda?=
 =?utf-8?B?VTFCQnY2K05jL3oxSGFxZnJQTnlOdnl6Z1FKcXBCMWpiWXFLM0Y5blAxSW9U?=
 =?utf-8?B?L0xEZ3dWWmRvUjhyVmFTOTNoT1Y0d1BZbmJkK0I1VzRTT0JLYXJOZzZHdEl6?=
 =?utf-8?Q?681L7CPyP3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpmeXFvdTRDQUgrSStHK2pUK0EyeDVrMUFGK3NBaFBvOHJrTEZzdllUb1Q0?=
 =?utf-8?B?WndBWmNXQncrb3ByVzNNTjIxbFI5VXFHc3lQUlpqY2tKVnlrcnpYVlBmL0Vw?=
 =?utf-8?B?bEdSRktKVzRWdUJBZHQ0dW9DcUxJY25nd2NNVXIrczhYc3FiQ2FZbE5CTU1U?=
 =?utf-8?B?d1BHMytWd0JrbzlSclI3SnBGTmZ1cDYveklxcWd3bW1BVWxLdzJFVm5oaFI5?=
 =?utf-8?B?L2NwTmhseGpRdFZwakxHNythT2o2Wll1SGY1ODd1SWRRQUFFUFdZcS9icTAy?=
 =?utf-8?B?UEhmMnFDZHYwV2NHVUNPc2x4TjlYR3ljalVNbUNYNXdvNU8rc2xQYmRIMis2?=
 =?utf-8?B?eGlHeW1FYS9VS01LdFl5WUcrN1pCSnRMd3pWeUtidFoyRVZQQ0h6aWRhTDlP?=
 =?utf-8?B?RXJ1VGd5LzIzRTlRZFhoa2R3dXhJNWRUTUJvL3lQMVN0aE90cFZVOGtJdUF5?=
 =?utf-8?B?V0MwUFNzVW1XUG9pODN1WVJmZmtXd05MMXJhQUxzNlVNVlJOWE5YazZGcE0r?=
 =?utf-8?B?dVBuT0FuODNxQjBHUlpFU1c1UnVqTmRKbFR1N285NkNuRVJtMXRLNTRzK003?=
 =?utf-8?B?MUZFa09pY2NRVzV5emdBdHdMa2NySXRKcWt4b1k3YmxkYndWWFIrbi8vU3BF?=
 =?utf-8?B?TnJYdnpySElxNVZ3dkRGTHZpZmhzdVlkUlNTeEdOc2hId241VnBrajJscFhP?=
 =?utf-8?B?Wlk3UkU2WXIrK05iMkFXY2xRSXEvU245UDY4aDF2aUhpLzBzWjA2enRpWVBQ?=
 =?utf-8?B?VzljSlFMNFVEdkQ0UWVLUVVjUTMzemJTWWdpQUI1RXNYK1QrWFlrSHBoNUdW?=
 =?utf-8?B?TE82TWlKZlI2bFBzR0tJcFdJNTNLVXJaSnlxdjM3c0RMc0N2VFI5ZnZrZE4y?=
 =?utf-8?B?YUxudEFsdWtGamU5a1MzMklyM3lnUlFtemh0dXVYZ2hXemdIYklxKzJqdmd4?=
 =?utf-8?B?WW9lVjIwT3BZMEhDMGphTXNoZXBQQzBKNmxxbE85M3dXUTdWYVRyWUZBdXFH?=
 =?utf-8?B?eFIrWThHTThIMDNsOWY2R1pMOVZNT3JzZDdjUlo2Yy9PaWlkYUw0RWZIVGZt?=
 =?utf-8?B?N1BNKzA2alNsMXF6Z3hDM1FMVlNHWmNNT0s2Z1RWRmdZK3NVM20xVmJxR2Vp?=
 =?utf-8?B?NHRXc2NnSENyTzMzWTNNTXFTRkpKRUZlYUxvSmpFbXpZdVU2V0ZQa2wzcDlp?=
 =?utf-8?B?ellvQURncVRCUUU4WHRGeHFhdE5QMTBNMldVZDZDekJhKytVRm9ERUZ2UDRp?=
 =?utf-8?B?azFJNExERDFyYzJGMDBJbHNLamRjR0R2aFFVRVBBdXBiY0pXZVEvN2x0NVNX?=
 =?utf-8?B?aHh1SlZteDdEWmE3N084b0tNMjBidW5mZ1BncEJOelFrZm8xYnRQZHB1NEtH?=
 =?utf-8?B?ckt4RVRZbjUrNWxESXdCd2Q1WGhlRUdsNnIxNlNDUmZsL0ZNaTArWjA2RVhI?=
 =?utf-8?B?OVVrU2E1VTNDZkppWXFJREMvbzM3TGpzcHlJZlBvVjJoeG1jUTNweThUVXB2?=
 =?utf-8?B?dk5SUnp3U1VSNmhoWFF1ZzFuUnJtdFdqclFoOVJPQ1R4VWVySStPNllCZWlk?=
 =?utf-8?B?VWJBUmpLbVc4RFJIaUFaTUZCQ1U5UG9SNmQwSEgrQm9jS1ZIcTl4bkVsRXNG?=
 =?utf-8?B?eVRnNGo0K09kUDBEL3ZpTzB6emtxbXd0Rlc4VlJVWVBvN1F0TUV3aFFTbWk4?=
 =?utf-8?B?SVROeDA5NjFtZkY0MGZDTUYrMERFOFZFNTFEN2ZGRjJWb3l1Uk4xUWN3SmF5?=
 =?utf-8?B?L25JN1FVMjBvY0FuYktlbThpckZOUHU0akRkOHllOXJDVTNGZDZsYnBmNzg0?=
 =?utf-8?B?dkNjU082cnZIVkh0dnBHbEh2ME5DZCsvMUpjV2l1c3VHZHNnWW5sZDVQRDVX?=
 =?utf-8?B?d0sxWFhCWStPRkJSTGN2dUpGb0RzTURUVmR6aGdVMEc0b29QYnB5Yys4WnZR?=
 =?utf-8?B?Y3g0ekFPQ0tqbUl2MkplZVpTRko5OEhISUFTOUVkR0JoWGN1MlluZ2lUZTFr?=
 =?utf-8?B?OEY3U2pMNEpwRVA4S2JVWnowWGpxd29VSGFqV0YybUZQRUxwYTk5MGg4R0pu?=
 =?utf-8?B?bjEwUVptWUlTVVdRa0xBaXBJTmx2MWU1SlZRRWZHL2hUUEJXbjRtL2dFaVFs?=
 =?utf-8?Q?/crDMxoyUWfy0GQ++YhOQTgw7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aefb62-6e04-4f9f-b64d-08ddcfdc3a48
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 02:44:53.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdtCmxKsgxU36SvZqH/DDIabBIyIOqYk9Vt83JgfVQzMXPYtFpMGqjyFM2aYvJKwl/bqdc19+ou5oEqDA/m13A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5389

Hi, Christophe

在 2025/7/31 0:48, Christophe JAILLET 写道:
> Le 30/07/2025 à 08:25, Pan Chuang a écrit :
>> + * Return: IRQC_IS_HARDIRQ or IRQC_IS_NESTED on success, or a 
>> negative error
>> + * number.
>> + */
>> +int devm_request_any_context_irq(struct device *dev, unsigned int irq,
>> +                 irq_handler_t handler, unsigned long irqflags,
>> +                 const char *devname, void *dev_id)
>> +{
>> +    int rc = __devm_request_any_context_irq(dev, irq, handler, 
>> irqflags,
>> +                        devname, dev_id);
>> +    if (rc < 0) {
>> +        return dev_err_probe(dev, rc, "request_irq(%u) %ps %s\n",
>> +                     irq, handler, devname ? : "");
>> +    }
>
> Extra { } should be removed.
>
> From my PoV, it would look more logical to have the same logic in 
> devm_request_threaded_irq() and in devm_request_any_context_irq().
>
> Why "if (!rc) SUCCESS" in one case, and "if (rc < 0) FAILURE" in the 
> other case?
>
> Personally, I would change in devm_request_threaded_irq() above to have
>     if (rc)
>         return dev_err_probe();
>     return 0;
>
Thanks for your suggestion.

The return value of __devm_request_any_context_irq on success is either 
IRQC_IS_HARDIRQ or IRQC_IS_NESTED (>= 0).

Therefore, we cannot directly use "if (rc)" to check for errors.

>> +
>> +    return rc;
>> +}
>>   EXPORT_SYMBOL(devm_request_any_context_irq);
>
> On version 5 of the patch, there was a comment related to using 
> EXPORT_SYMBOL_GPL(), does it still make sense?
> (no strong opinion from me, just noted that and wondered if done on 
> purpose)
>
Since it is an existing export, I will keep it as-is.

Thanks,

     Pan Chuang


