Return-Path: <linux-kernel+bounces-876830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28793C1C7E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CD9A4E3C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBD302779;
	Wed, 29 Oct 2025 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VFCf+O5I"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D22EB876
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759338; cv=fail; b=FKsVERHYe+WvVRcKFmMxNGvAXSCx/Apoa1PR4f3mzG1ZkVmmBVNqrTBXmwzsM5NkWakZkaEQPKcmuq+mnzcKQDo654EmrwvNjpeo46l4z7SWsxF+poX/9BLxxXeRdgnWJhs2TiKJh4xb9jYgdlsTDJCPfg1oiYmuanJ5s46BKqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759338; c=relaxed/simple;
	bh=KEnL7x8fQGgwwMXJC98S9WPx33t827nGx8UkBGh5BCs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJ7asIU2jimR3vlCEFj7rerFueQOoU8InAV4frZEujPcK3mX6RpF68DJEBxLBd8mb3Z2mqy4KTRDl7Sg+hlDCP2VGzgmEfOE2xAAlCk7wcxzgbZ4qy72dHWrT+t8vGtC44Nj5JrWYjPPtpjwSRKLqetUfxKC0FDivpVvP2Eg4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VFCf+O5I; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhYuNxVXcnt8DhpwVQFhgwqYkXlutAduRWxnXnxes/XdIvEpA3EoUz3tpbjb6grqv/WYEjbZKFKE1r3x8GhBD9WxsLqu2BSU5wFxC4ZUp7rhFMfj7qb/aG0IjPcA8oZLxIyyV4AFC2j7copP2u73MxvKnVydkOeP4Tnv7jdSJ/fgvjWHppl/e+0McExY2rxT7sq0lcd4yTKIVM9CNzaS8qqux4y2Te+RBPoLa+bSAqZ0lyl8XZPtbdI6+MsNe5kC6PwdAoHauPYNsy+i2LYq1rO3cH5zxCc0He5/TjKi8kQzWjr4A42aqEuVbwXs6ErM1sTixMcaU50itZHoYtMgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2AdUitOoTbWDTZcjO6iWZyfNYO+vvqc3Me1ZjXiejU=;
 b=lttPYjEyHkyxsSXXgCyCh+27fSx7uL/tMIgTgE8adFQRb0PHPgwqiveDm3XU181ieb4PFMgKpOVs9/ZXNDWtz8ynsAPgn+1Yl6xSkUkG4jYp8bHpLK9I690gidhS1WJZCsF102h+OvaFlwLT1+Q+u/Vnkt02Oit3w8xdLfshBXRMby/fo34vz7YB6kDN/YRYIS0rujyq9wOR4BteP30TYMIxZhx75A/oKGv8ffRBMmenyfzDf7BFxQgd03cZ+EO5d/kqfV2nN+wWr3BYtX1cvVexJMLZqKtgqOcGuI7G4cgXdR8U9WJ29GHQ1NF8tVtiF9AEyxHQRvhADbKzU2QGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2AdUitOoTbWDTZcjO6iWZyfNYO+vvqc3Me1ZjXiejU=;
 b=VFCf+O5Iupv7gvIVM7KnsZgujz8ezEz/UGL0FxkLQ0Sn0nU2WDQ/g2iHO6j/B2SMnTRAT9tIglXqQrf0jyTVoMY9PkKyNYgYN/nNFXJogzEMjdLdxKljT552HciPd7sby//jpToI2bSWrsDIQywMGcbFM//WTIWMyXcp83s9+JTRJGYmUq65WSE+uxMx0HijC8ZU2MVcbBvhnd+GtI29ga3decCLMK03qeQ6pviKtrjrF6ovJ52D8ZA5bOqHb3xL/K35Yx72Ueyc2CvC+Tv8vYdY68Z3GfyQ7IvtvlLzEGXyS22jDo8ajNU8GOZQ049pOkftIhn6fbMf3p9XeDUw2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:35:31 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 17:35:30 +0000
Message-ID: <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
Date: Wed, 29 Oct 2025 19:35:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
To: Johan Hovold <johan@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Lazar <alazar@nvidia.com>, Simon Horman <horms@kernel.org>,
 cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5d2f6a-d3a9-4623-2cee-08de17118e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVaVVY1RjdlNkZtRzd0V0pEL0tyQVJEdjFaYk43YTNXZEZBL21kMkh5eEVv?=
 =?utf-8?B?QVlwQWQxQ3Nrc1k5RTErMElPSUJ3Y0tGOTdaQUtVTGl5OWRieGdPU00zWlBH?=
 =?utf-8?B?OUtoaHZRd3libmtweklHWXBwZnVHS2JxYXc3OGtDWDJ0ZXVDVUpMaFNRcktm?=
 =?utf-8?B?cSsxYlVMZ1V4UmZRWEc3WTJVNGlxcGxhVFZ2ZS80N2l6MTRkU3BhaU1nNUdx?=
 =?utf-8?B?RUs1WnJtQUFGdWp0LzJidTRnMTVlVjV1ZlliemNQTFA3UEF3bHNDM3JoL1J0?=
 =?utf-8?B?VGJIbmRidytxSjJBc1Y4aTJrNEdDRXdXeGJyRzZmaUJHQjgvMFQvMi9aNWI4?=
 =?utf-8?B?d0g5azIxRm42c1JzWlhtNDU4N2h3YVNsZCtzOHBFWkFMdytmZ1ZKdDN6QzJa?=
 =?utf-8?B?N2NZV05Yc1p6aGc1VExndnVKZloySFgrTGNHZ1d4TVdMNzJQM2RkZkM4QkJp?=
 =?utf-8?B?akI2VUVDMWhlNHJjS2tGdUJKSFpCdmFiQmpteDJ2SlhYNjFIbk05WkZIa3Za?=
 =?utf-8?B?Nm9KOTVMdjM3eGxQQkM3OTltOU8wQ0tvdi9NbmkzRTgzWFBHeWtMeHRJTHlU?=
 =?utf-8?B?SFZxK1k2SjQ5ZjdlaFhZYmlOYnhpbnBiSjh3ZEhVMUQ2djhIK2M1bmtZRS9S?=
 =?utf-8?B?TXlYcDBkS0dYLzl0WDNNQXJQMHN6YnA1eUdkdXpleFJIZDA5RFRKMkxSZDVX?=
 =?utf-8?B?dTUwVThvckVBd2pqdUFDclhSMWtDOTRMNythcEVYay9CQlhQWWtsbTdncHd4?=
 =?utf-8?B?eGUzdlpBNi9vdy9YTlh2Y3dHaWtxTFVWZ214NjJWUjhCK2c4dHZXc3hHWEZI?=
 =?utf-8?B?bXgyZ2NPYU9qRUxuRG15NXMyRnhmRVYwcisrN3FEUEM4bDVsZW5KeFd1UUI4?=
 =?utf-8?B?OHoxUlJTc0VRNEVzaXVNMnNHcDg1aGFwWTRaU09tdDYveXhLZFJBdmFqOFJj?=
 =?utf-8?B?WGZldkdGeVdtRldWWXZ1RU4zNGtITXZSbkxCSUJFNnFjOG1OZy9zaFlIQmho?=
 =?utf-8?B?VVlkZlVxUlJoVUFMQ1pjYlRocUhBZEp1UEtoNU92Mms1Tm9DQ3prelkvTDY2?=
 =?utf-8?B?Y2U2Q1duQmRndDFkSTVFS21abnFVaU5XYWhzbTZkV0JxU1BDN3gwMk1uVC83?=
 =?utf-8?B?Q3JaWVlhZ0x1bDQzSFFhaGl5b3pIa3dqTyt3V3FhS3hzOE96Y3g1d3BmbTR3?=
 =?utf-8?B?QlFWOEpZak1aamMreDhYS2k0c3Q4TEt4VW5tQXBDVUNvK3dNa3Nvd1M1Z1l5?=
 =?utf-8?B?MXBHN3UrSkJHVkM0YUxFbUFMd1RWTzRPQmlTZjhwYlFtMG1kNVlUK0piWWts?=
 =?utf-8?B?QUlWOCtlcDFPT3liWGFKb3BONWN0d0lLTFJqYVQzVW0zc2VqYmVhQU1PV1RU?=
 =?utf-8?B?NFFxM0VCWkNVUGRjZXZWOUZLM1pDVmdLUEd0VnZsZ3hvc0Q0eVJZd090S2hH?=
 =?utf-8?B?WEsvSnAvWUNta0thU01QS1JuQUpTM3ZuZnRidzhWR3lVTStpUUJMQWVySlBq?=
 =?utf-8?B?dldkcHAyRGZxYUVrMVlxNE5wVEgxYnB0dzhSbktMRWxJcHpRcENWeUFkeTBM?=
 =?utf-8?B?SkdPd0hLUDl6MmdLZUU2V1VPajFaQ1IvNE1kTjBYaGM5cHFYWTlZY3U5elRT?=
 =?utf-8?B?cndIQSt3TkkrQWVLWi9HdG5MdFpKYWp5WmRXWFhTNkx2VW12ODVlVnJjNGF3?=
 =?utf-8?B?MXUveFBxT08yZ0RVSUMyRGZyTVY5Y21hSENmOFRtb3JWUjlHS1dVNXFkcklS?=
 =?utf-8?B?ZTJlRWRxN1d5aTBqaklZRDhITDVtTjNmeGRlbkcwVjkrOEg4Mis3TVlDUGRo?=
 =?utf-8?B?aFZ6WDJMUHpjaGV2MFdZSFpBRlZSZnBLRHg1cWtlYW5KTG96MUFkMXZHSVJj?=
 =?utf-8?B?TzFNN2J1U2ZLK085M0Ezb1Jua1NTTEhJdzZTd0MwYW9RSERkcUtVL2VCdENV?=
 =?utf-8?B?Z1pqbUJaM0MzZEhVc1V3OXRwbWExVUU5cUV3cWF2dkp4aHhHTXJqR1VZaEF2?=
 =?utf-8?B?K1lMczlibU9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHpLRjNWZ2k1MEVtOVhrR1d3L3lxNmRFaEVjRzlCN252UVQ2SE81NkRUSG1W?=
 =?utf-8?B?QUtZZVp0WkRwM1NLdFJqZTlNM2MzZHNXdDUyUkxEWGc1Q01KRmRxUTF2aVJ3?=
 =?utf-8?B?bVBmN3dFRHIrRFgwZUZPcnpxdUJBdllTaWZEZEN5bnN5UkRyeWtndkFLMTZR?=
 =?utf-8?B?THVheTZkMGVMb25PdEFFc2J6a21OTXJaWmFwTUY0Q2RqL2dCWHNvQnBmeFVF?=
 =?utf-8?B?UE40R0xmNkdwcllaUkdIZ3Z1UXRneXBUWWNoMVhKK0p2andSeEl1TU5zWlpX?=
 =?utf-8?B?dlRuOVptQ3hZUHhMSUszUFdOL0h2TC9na1BmVHBIRlIyUlc5UEZZMTVsa3BR?=
 =?utf-8?B?Q0RLV3h0dmhKeTVjdVRjZWtLRjJ4SUJFbFJxejVKQlIvRDJZYTI2QjJCczJp?=
 =?utf-8?B?ZmpVYUtDU2lkR05BRC8ra0VKNlBZMWpVdVozNFo4SXdDWGsxUmo0d1d3c3E1?=
 =?utf-8?B?aHRDMlRRbDlYZ2x4NDlWZGEwM0xyUzVrYmZjY0JydFQ3NUhlTjliZUdJZGdJ?=
 =?utf-8?B?YnVGVjFlYjkxOTVzSVdnSXhmeEcxK3Z6QlVIc2dqbHZUbVB0NmFtOHBUdmFR?=
 =?utf-8?B?RmxVaEMrL3pEU3JJT0hFRjhQQTNSbGszNHp1dzJkNVJ2T3RSNzdEQys0N0pW?=
 =?utf-8?B?OVNYeGU5UXRCZnN0Q3dCb1RTUmZCL0ZWV21nVVAvMW83djJtTjNEbDNBdGxq?=
 =?utf-8?B?bHB3RDRvU1hHK0JFU1NZQnA4ZUhOL0VmeHFTT3B3TDlNbWZpSE1xZjJ0NFFV?=
 =?utf-8?B?RDRYUlhTaTlZZE84ekFhUWdlWTgrd1FpeU55dm9iOXRtY0hNT215RjZCSFBS?=
 =?utf-8?B?a0FDeWdhWkN0ekh4aXJRU29LR2xvOW93K2NBYytKV090M1QwS0g2cy83Y2Yy?=
 =?utf-8?B?Z1NTWTZVZkJwWUJma2lKc2g2UmRBVGhoMC9ER2xvcGoyTlRXWnpYcngwTFVz?=
 =?utf-8?B?OVFTbE90czFYOHQzejNaZlY2RnFmS2pscE5JdUROT2JsYVZnZG1IaFk0VmpL?=
 =?utf-8?B?aDZhRFpqUlcxRXJXYUN3cnB2aVpuUkZqc1Rtc25qTHdvbGwzbDNLY2tuM29o?=
 =?utf-8?B?bVh2aFZZUktBajh5cVpoNGJ4ZWc5S3c4WjIrcFhua2d2MjVHUHozWGc2L005?=
 =?utf-8?B?cmR1QkRjN0ZQanRXNFkxdUFkNmJ5S3h2VGRrQW42QXg0NVJ6bGNyVFdSN2JB?=
 =?utf-8?B?TkhCbjY4OE1hQnMreTQ3ZGRkcFF5aXVaRXMwTjAzUzQ0OTVjekFsZHZWaVF0?=
 =?utf-8?B?cU9icGlQaXNnWDNSbmNJKzlsVkdNUVlSbDl0R3Y3c2J5Q2J6b3AzVE1KMkh1?=
 =?utf-8?B?Y0dVeHdsU2E2ZEplYUoyejlwM2l3ZDRVWXhGS1EzMy9QMllBNEJGa3krWjh2?=
 =?utf-8?B?bzJKQXlmNUp0T0dJVzBzQ3JZZ1RreFhlanFLTVpaNWE3WTlFN1ViQXR0SDFF?=
 =?utf-8?B?WmRvMEhZck9qUmdLSDRqTHdTb0pWdWVMMmR2Q3grMjhzYTdDOXBVT2JOa0NC?=
 =?utf-8?B?VDNkWFd3MUEySUtjWTVPbXNCYTlpenhMNGRET2s5VGxLYmJSdElib0xkZGlT?=
 =?utf-8?B?YUxaMXdFZlpMTFN4RDQ0ZHJoK3o0TjV5R2hTL2lYL3VJZ1B3QTR1bHdySnhL?=
 =?utf-8?B?V0hFbXh5aXlLSnEra2dwN01DaEJqaWJvU2JwaU5IYVdPZ1k4MFM5TDRjSU1F?=
 =?utf-8?B?SHUwS2pzOFVSalFub0VqNWo5ODlKSFpBcWg3QUxNWGQ2Q2t5dUs0RkF3QzFz?=
 =?utf-8?B?SVg5WlVCUHh4ZHBVSWJPOStrQ3BLZ2o4QS81UGxsZnkvL1FCcW15YjlQcFds?=
 =?utf-8?B?aStIMGkweE5HeHFRd3JBbzROY2xhalhHdzFLN0ovSGdSY2VnSkJoYzZCS3Q5?=
 =?utf-8?B?YUpPUEZhNHdwRWR3aDZPTTlId0h2TkR3UnlPMXBvWWNjSHYxRzVIcmVWbVFL?=
 =?utf-8?B?TW1YaVpYdFg1RFZBT3pBRitOMlFmT1paRlJVcW9GMk8xQVRzT2NJNXBmZXNj?=
 =?utf-8?B?VXRBQm1pWkdvS3NIU2xLODZDemE3enRQUWM2cm8rTGRlaFV0NzFuVXhXT1Qz?=
 =?utf-8?B?TUcxUi8ydXhOVDBxSVNCbE1UM0JabDZONWo5TzZLa3h3ckFMT3RudnJsSzdl?=
 =?utf-8?Q?npH0n7YVMLuWR1xPw3MGqpRgP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5d2f6a-d3a9-4623-2cee-08de17118e5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:35:30.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKNA1mbwoE5Pwo4YZa9mqZFdQGEJZiktIIVgQS0CG8UROW8wpV6aGy4HOsAwj4vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On 29/10/2025 18:38, Johan Hovold wrote:
> On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:
>> On 29/10/2025 15:29, Johan Hovold wrote:
>>> This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
>>>
>>> Using "%pe" to print errnos is in no way mandated and a driver authors
>>> may chose not to use it, for example, for consistency reasons.
>>>
>>> Drop the recently added cocci script that has gotten the build bots to
>>> send warning emails about perfectly valid code and which will likely
>>> only result in churn and inconsistency.
>>>
>>> Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>
>> The test by no means mandates authors to use %pe, as the output says:
>> WARNING: Consider using %pe to print PTR_ERR()
>>
>> "Consider" :).
> 
> Right, but it's preceded by a big "WARNING".

Right, I don't mind removing it.

> 
>> I would consider it best practice to use it, and a few drivers were
>> converted thanks to this test.
> 
> Unlike the rest of the misc cocci scripts I skimmed, this one does not
> guard against any bugs. Instead it's pushing for a subjective style
> preference, which is just going to result in churn when the clean up
> crew starts sending mindless conversions of individual printks.

Not all cocci scripts are used for fixing bugs:
err_cast.cocci
memdup.cocci
minmax.cocci
string_choices.cocci

They are used to improve the code.
We can probably agree that for new code %pe is preferable, but I
understand your concerns about the churn of conversions.

> 
> By all means, use %pe for your drivers, but it should not be forced
> upon the rest of us this way.

Agree.
This script helps us for our drivers.

> 
>> If the issue is with automatic build bots, then maybe this test should
>> be excluded from them, rather than deleted?
> 
> It's both; it's the noise the new warnings generate but also the coming
> flood up patches to "fix" them. There are already some 40 commits or so
> in linux-next referencing this script.

It's OK to not like these conversion patches, it's up to the maintainer
to accept/reject them.

For example, I know Jakub dislikes the string_choices.cocci script and
rejects conversion patches. But the script still exists and can be used
in other places in the kernel who might have a different opinion.

