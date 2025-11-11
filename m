Return-Path: <linux-kernel+bounces-894547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3CC4B47B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01180188FC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1331353A;
	Tue, 11 Nov 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YY8K3DAw"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F8243374
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830365; cv=fail; b=Zln45soFL13UoZ47GaX37mDJKiqIyzzwBB/RgUo8ukux/KV1u73ZNhsaOWdRU81HxKdanXLfvr1fN/E/RXNkHM2pr6cQCYrv9kIXlEShf2GCMx9HB8NadGOFLtAoS9eBYTx2Gyk3y+TlVh7fI/OMUll7hMLIMo939sJfdZLUyJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830365; c=relaxed/simple;
	bh=/48AGtkp+HfI1r4o21hU1dkNIxmpCi7nrICvfAvoKCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruw37p0HKBbVbKDmJCVp3ZDY3al/zhX2ijE91F+PMVsmyR9MJdxresPfiZOzGVYZwyfk1gbRNhjBqNCOaKmqTjEDPZig/4ERAz7B0G3l1+5E0p78eDzxt/Nj6SoWWkpGROAoeCvz41pLDNPWN3b0z3LPDvw8Xt749C9N3W3MxXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YY8K3DAw; arc=fail smtp.client-ip=52.101.43.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKtE3Hjii53FFHe/eKrZo1CV8IHrFCEHW8R96N5inZ6X7X7IB1N1t7pb2DAP3M95R6bwVBLjou0H2iaYsNgbi9t71Y1pL+dsnG6uwCGF1pzJbBJvma4mHl5ue0aT99m/FbW3Cejepk5zjHwSuXFmkOhvX2GlcXG+0zH3NscAa+huMeSrcgE0z9S1CDugKyWS1MqhKCYgNKsRoqNkibZv+VY08OmQ8KEMLgk67J6i9jTQLzDQqWHQI84M7yQ7F5ompy71xLCQ2OaPUCFhdlL/ptzvypT/CdThETWIg/KGeQO14IGLtK7HfV8wC18p7sFmPiRwAl7hKgd1peBgLWu74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/48AGtkp+HfI1r4o21hU1dkNIxmpCi7nrICvfAvoKCI=;
 b=iwZy/X0ohGulC2j7HZnxllszI7JaUjXCJzMguUI6rGPwj+KtuthU/6nkPnokLLAj+OyMJvuGwVqb1cvIJ9Q1y6j8ITkRlt1mymDLAIDzpa9TirizWqrHNcHiIxTzvobcng8JVvLydcU0f8cbvvddmX+Xw+h3iP9alftw+StO/+7V/cJs4BH1YVNLQTAm9MTKygBzGtzSK0oBIorL+QquChl2BAfKdJmgZD90yGfiLTymZEjcdVhi/h/yKBaF0DCYCPSHqePytfrwpGp1WGoEFtY+OPHBk22mm3HPK5gkevCZOQHZv8R43RmzBF6zNM5624rwzSX3FBO/Iimwx43OTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/48AGtkp+HfI1r4o21hU1dkNIxmpCi7nrICvfAvoKCI=;
 b=YY8K3DAwYNX8x5lEa2KwJM1BxLpxiI+8b+gsOVOb7dc3XoMwSWjVUf+60FE2CDlTRAYBYalOOgiZUd6RxNn39XoNoir2P8alu1ujpLoxbUOs4w1T13exG/+8LFD6f2T79SjrgS0g16neS4xNsdQiUDXzkNr1MrNLqXBQrZaiNpEkiCj/MfCcFgSORJsGTRt0XsVx7kblEpUub8+cI9s9LkUpial+oPjEmuOM2lz+SOQHh877Ft88ZjuuCnDZjcybdiLxtXA030oGwjnCLULWyP8U5ULPfz3Dd0z6CE5hxaIecK5WkVMrL+ywun0fdLfrxm3FUk+friKeCER6Lioqbg==
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f3a) by CH3PR11MB7675.namprd11.prod.outlook.com
 (2603:10b6:610:122::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 03:05:56 +0000
Received: from DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::3a7a:4ec6:bd62:1e0d]) by DM3PPF9623118BD.namprd11.prod.outlook.com
 ([fe80::3a7a:4ec6:bd62:1e0d%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 03:05:56 +0000
From: <Manikandan.M@microchip.com>
To: <lee@kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<Dharma.B@microchip.com>
Subject: Re: [PATCH v2 RESEND 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for
 LVDS display
Thread-Topic: [PATCH v2 RESEND 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for
 LVDS display
Thread-Index: AQHcQzRL9uTMIGaRdUqsOR/B6QxTn7TltNKAgAc0+IA=
Date: Tue, 11 Nov 2025 03:05:56 +0000
Message-ID: <ec44b024-a06c-4ea1-be7d-3a8993a5b362@microchip.com>
References: <20251022091351.472331-1-manikandan.m@microchip.com>
 <20251022091351.472331-3-manikandan.m@microchip.com>
 <20251106130233.GK8064@google.com>
In-Reply-To: <20251106130233.GK8064@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF9623118BD:EE_|CH3PR11MB7675:EE_
x-ms-office365-filtering-correlation-id: f289ce8b-5b6b-4ec0-b7d2-08de20cf3bbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWZ0K3BVWmp4Lzd6K0o5L0R2SFVNczk3VzFHVElxUnpENHBxbGxRc1V2Qzdp?=
 =?utf-8?B?ZmhuekM0dkcvOVlyNEduallSTUk3OUxybE05VFMxQWVjNm9hOFdnRGFuUHQ5?=
 =?utf-8?B?MlEvRnRoY3lKUTNTbnZtRUxHNzB2clg3TzlMREQxQUQwenRZRFpXVW10QzJl?=
 =?utf-8?B?RW9WdmRJTzVoZEpHTXlVS0hzbzFQSnB6a2M1ZytXN29CS3IvZjQrR3lBL0w1?=
 =?utf-8?B?TkhFODlselE1MU55ci8xMldvam1hVHdtZXE4WDdTMTNUTlJNUnB6OEtWRmty?=
 =?utf-8?B?NnRBVTZUdGxicVZoRkFIOEltUW5SNVFOWko1eW55Slgzd1hvRHVzSmpUdmZz?=
 =?utf-8?B?ZFA0eW5LQjZKVWtsWWhyeVZzRzdxYXd6aFdQcW9UKzZieFBBM0p4dXhURmRS?=
 =?utf-8?B?RERjSXNHbE1hQllRdzF1bXRoQk1PQ2Z2R3locXZXeGVxcGRzWUcwNytndk9X?=
 =?utf-8?B?QjdZcUY2M05idlNDci9JR3g3aC9Xc1BSaGhUZFdBaXJhQzhsV3VSblVQQlRC?=
 =?utf-8?B?ZFh2QUpyNGdyZkVibVpzdGV3V1FRTDMxMEVjaFN6UGwrc0FDUWg4NGhkblBS?=
 =?utf-8?B?aXVCQ2gwNGQybXZKaktsYmh1anJwZDdHaS9qU3hwbGNhTFRzWkQyeWdldU93?=
 =?utf-8?B?anVFM3pmcS9DZnhUMDJ4NGtxT0IrY2FwNXNBSUxuYUhiekVVREZka2pOWndX?=
 =?utf-8?B?T21yZzVmSlNJTTZNVFNtVDlOOVY5Y05iamN2RTFVZkZBWDIrd0JvaTl0TytJ?=
 =?utf-8?B?a1hCOVlFWUtiMSsvcjBlNTNyRUZxTEg0cmhleVZKVHpzZHI0WDR3eitIRHA5?=
 =?utf-8?B?RVk4RnJQVzlhTHloSloxMVNyU3VzT3VyYTVlM3Bvb1FaN1FNY1ArTzVFMDk3?=
 =?utf-8?B?Qms4djdxaFNML3ZBKzZjZWVpTEZxaG1VKzcvUnJWQW1tY1I2ZFNNRGcwZm1y?=
 =?utf-8?B?Vjlqc25XNFJVb1BBS0RodFZvdDRoWmR0YUw0THUvU2dtMlhNRnAwUlJ0cmUz?=
 =?utf-8?B?cTZxNWVxVnZPR2thTitOdktmYUU2RTZ3L3ZmOVFacThuOVczZndmSXI1bDNa?=
 =?utf-8?B?djFSbWxGTE1rU1VYd3BTRDVrV1BFY1NWak1zOW9FU1FUNGUrcWNXeUFaVFZk?=
 =?utf-8?B?SjhOR3hPS0R0VS9na1NKQ3dLcXdpRjJDY2lmaE05ajVPUEZCR2YzK2IybFJJ?=
 =?utf-8?B?NUVHcUxLaHpaWXhnUEtqV0RxYzFCcjBTcEVEeFZKaVhwZ3BaYmdySk5PS2JU?=
 =?utf-8?B?MHduYU5uSG5CanhYdERTa3NzSTNTVHh4aEVkZnFDSGxHWmU3RlVocGltUXht?=
 =?utf-8?B?UTFpeFJ2RGRoZ1hablRGZ1BnejdRWXo2ZlRQaFpKNGJlMEUva0REVldqR0lL?=
 =?utf-8?B?UlM1VHlSOEpQVWhzSVNrSVpkcUxyQm9WQzYvM2VsRTVVcmpZZUhVdTY5bUtL?=
 =?utf-8?B?SksvajBwa0x5eDVYeHJwb0NVS2x2MkQyMng2ck1ZVlRpR1VENVZxYUhCQTlx?=
 =?utf-8?B?R1IrSHp6amdpVnh1b1B4WktEVm1FNEpFL1ZwMGU2RjV2cnpnd0p2MDVQdjJN?=
 =?utf-8?B?THcrZEJoRWxtOVJtTmN1TXJFbW9IcjB5YzlnYkNMenVIQkhhNFBFeW1VNHVP?=
 =?utf-8?B?U2tlRG1YaHlUOVQ4dldrcXorNzZzSWFpUjZCWXdpUkx3S3hqMWMwZWpaeThY?=
 =?utf-8?B?WTIvdStid0ZRT1E5YXkzNEZmTkZXN0tlaUlZd3AzNWVPdk1pZjRQYUtPVWZw?=
 =?utf-8?B?MWRYaGs0dnprbS9KUlJpZnZIN1FLSUhJOEg5QjN6dllSR0luSndRWHVpVVoz?=
 =?utf-8?B?V0VSNXphRWkrVzMrejlMZk56RFM1SStSeFdaUXpaUkxXWjg1M0NzaXJkN0tX?=
 =?utf-8?B?QUpSTmwyRjZ4M2YyMUNEalpycXhQZVdHU05MUGVLaXU0d1VkOFQ5TlBkaDlw?=
 =?utf-8?B?dUFXSFk2cWROSjRGVk9EMlg3OE1seGQ5bXBUR0srcXZVbldTNG8xWFF2V1lK?=
 =?utf-8?B?Mi9SNFhRck5iQWFEVEZBajJRd1orc1BTY3FLeU1QazJ4SmEwM2tPVDRzR0hW?=
 =?utf-8?Q?WZ+XVC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF9623118BD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aC9wNzA1Y2tjMU1JT0VOUENtcmV0UGZMWWJCT3RnQmd0bm1EWEI3TUpFZEpM?=
 =?utf-8?B?OXRyanpzSEZZSnc4N2k5N2NRZUw2RDI0Q25ueWV4RG1QSXIrZE14dGxYQU4w?=
 =?utf-8?B?VlJFcjBEV1V6eExIYXUxSjQwbmdWN1YvUzk5aGwvRWU2cFBRQTRwcU9aSlVa?=
 =?utf-8?B?aks5cENPczk3Wk1hT0p0TzhCVFhCTXYyQlJPZWozWFJqeGR4SGlPQVdWSTJw?=
 =?utf-8?B?RXBJQkJCUklWeGlkMVBDaEFSaldrN2Y1c0NvSVZLN1FleUZjSGRmN2FYSWtR?=
 =?utf-8?B?NFFVN2JGTUVnSFAyNnpURFNDdTdMOFhFemF0dFFmSGJjMFc0dkVYRFJoRDZa?=
 =?utf-8?B?RjJQSWVVbjdTYTlFMDhoQ1l3WEx1M0VhNENCSkd0M0lSMlpveVhuZjdZOGNx?=
 =?utf-8?B?M3FRaENUZ29PdkFFczY0WHJCd3RhVi9yRkxoREwzWm55QUZiV3pnOEo5eFFs?=
 =?utf-8?B?bk9OK2dKZU1RMENKZ1dIdFhGSnptTkdQS1BXbzlJRkRYeTFmZVJYSGNobnNJ?=
 =?utf-8?B?UmFNSUNXUGYvQlNOb3lKN2RJa04yV3F1dFZBbG80VTY2TDREN0c1US9maVVF?=
 =?utf-8?B?NHdSRzl5LzJjYVV1bTE3QmRacWRqaStQWitnRlV4eUtHZDNwSjg1bHMvdXBG?=
 =?utf-8?B?djIxRERlVjgybTc2bS9BN2h4emVTRHRPREg3SkNlUG9QdDlib0xJSmd3Q0tM?=
 =?utf-8?B?WE5SaTkxbXlTM2N1TFlRVUJVZmVkTFdDVzZ1dkdFbC9uYUhWZUVmNXNOYkV1?=
 =?utf-8?B?S045TE1wL3JFRzlEQ2FjRUVzbWVxdFNlSExld2ZaR3Q3NzdtWGo4NUhwNFlP?=
 =?utf-8?B?L3dRWkNraWtONVNVZU9nN2VHelI1QXk4UXBkQTFrS2h5OC9jSFl6bDlHTnZ3?=
 =?utf-8?B?VzRiR25Sanp0REsvZk0zcVV5RXMvQlZIdUNIbFVRR2daU0lnRWpTUnI4VDZV?=
 =?utf-8?B?Si9KbEZOblhydVZCK1FDcE4yNmRVbFNyaE80Y0JHMzR3L1lBWVM2eDdVQ3Bn?=
 =?utf-8?B?TTB5Ris1VUNhd05EZmFwL1hSbUV5VStFazkwZnU4Q05CL0Z5YllKUmx6SHVi?=
 =?utf-8?B?MHpLUUIyTStXbVNLSDJnY3dPa1VHUWZBNzRNRTVVRGNDd1Bmb0FYTjJpeHZ6?=
 =?utf-8?B?eDMvdHpjNzJ2U3JTLzAyeHdlVU5MYmF5WU5PQVJJa1Z4VDgzcFc1SFA4L01u?=
 =?utf-8?B?SVFHQkEwVmpKU2dVNzNNTTZCNGc4OHFGb281UXMxNFpsckRkL3NlOEhyeU9L?=
 =?utf-8?B?enlhV0ViWVUvc1B6cVVVVXJYK3BXUW9yQ0o4L1VDTDZCbTJGRlZuVFZldm9h?=
 =?utf-8?B?bXREVk1yWEx3dE5YeFZ3STc4Sno4RENUbHp3REJWTjJUOXBKa3Noc2tVRVVL?=
 =?utf-8?B?SytzZkd1WWZPWUV2R0NjTlZFdW5kbC9JVzJMZS9uQjRkVDJ5SkdvSWUzWU1L?=
 =?utf-8?B?MFpsb1R2WkZ2TGJnVEg2RFU4UC9CN0poNVg2TUhsT0tXN203UUdBRUlQUlY1?=
 =?utf-8?B?WkRINUx0Y1RnYkJHb2xKek1xSFVtcWxoVjhjMTh6OUpKaU11QnlGV1dmT2Jw?=
 =?utf-8?B?clFaMlBMZHRFOVBrWSs1OGt5UXJxVkdIRjhJd2ZoTEpOQThsRW5mT0xuMHNk?=
 =?utf-8?B?ekt0S0hqSU9jZk9WMng2WkV0NkI0RG5lUmJRQzg1WmUvWlBCRWxzbXZxa0p1?=
 =?utf-8?B?L2RUWU43WjRuVUZzcXZnV2duK21DUTlCb01qbnlRMjZDa3c5QjU4VFJpYlVG?=
 =?utf-8?B?NTJVeSt1N0IyMkx4ZUxyY1lHYkJLcXJjcTZVOFd4TGNsWWJoZmwvcGFEdHc0?=
 =?utf-8?B?bWJPbFZ4TmI1aTZ0SWJ3SEdzVzhMc2dscG0yajE2eWhVTE5pYVNqci9PU25D?=
 =?utf-8?B?b1RmQkZRTXVWbUtJeFJyM0ZQeFR4WUJxK202eFlYZExCbVhBOEkyNm1XaGY4?=
 =?utf-8?B?QU9NUnBnVjRYVndtN3Noa0szS2trT2lVMkIzNEc0YWlXMEo3cEJNSlc5Y09V?=
 =?utf-8?B?VWczZkpUcVJOdWdJdG0yY3RlZnNqYzBLOWJnQUZEeXpuNkVraXJoNmo2eHJK?=
 =?utf-8?B?ZDBCd3dCTDd1d2tCY1NxRDI2RkdSa0ZFSDc5U0l4ZTNRbm9PUXZGZFZ1WEtT?=
 =?utf-8?Q?fvwQfSxTeQ/+NaFaAFrWstOd9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E19EDFB5BC055447B90F40816410CFD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF9623118BD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f289ce8b-5b6b-4ec0-b7d2-08de20cf3bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 03:05:56.5248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Whpn7lc/mI97aHbXpSQj6zIPD1/yCiDiKXD0xaGQIpIXmGeX87Hg367zHkPfvlq8QJDDQc5l/Q2f7gq3Mbg5srhpcZVU+3rR3Wva8mVl4YI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675

SGkgTGVlLA0KDQpPbiAwNi8xMS8yNSA2OjMyIHBtLCBMZWUgSm9uZXMgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCAyMiBPY3QgMjAyNSwg
TWFuaWthbmRhbiBNdXJhbGlkaGFyYW4gd3JvdGU6DQo+IA0KPj4gVGhlIFhMQ0RDIElQIHN1cHBv
cnRzIHBhcmFsbGVsIFJHQiwgTUlQSSBEU0kgYW5kIExWRFMgRGlzcGxheS4NCj4+IFRoZSBMQ0Qg
R2VuZXJpYyBjbG9jayAoc3lzX2NsaykgaXMgdXNlZCBmb3IgUGFyYWxsZWwgUkdCIGFuZCBNSVBJ
DQo+PiBkaXNwbGF5cywgd2hpbGUgdGhlIExWRFMgUExMIGNsb2NrIChsdmRzX3BsbF9jbGspIGlz
IHVzZWQgZm9yIExWRFMNCj4+IGRpc3BsYXlzLlNpbmNlIGJvdGggdGhlIGNsb2NrcyBjYW5ub3Qg
Y28tZXhpc3QgdG9nZXRoZXIgaW4gdGhlIERUDQo+PiBmb3IgYSBnaXZlbiBkaXNwbGF5LCB0aGlz
IHBhdGNoIGZpcnN0IGF0dGVtcHRzIHRvIHJldHJpZXZlIHN5c19jbGsNCj4+IElmIHRoYXQgZmFp
bHMsaXQgdGhlbiB0cmllcyB0byBhY3F1aXJlIGx2ZHNfcGxsX2Nsay4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1pY3JvY2hpcC5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEaGFybWEgQmFsYXN1YmlyYW1hbmkgPGRoYXJtYS5iQG1p
Y3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IGNoYW5nZXMgaW4gdjI6DQo+PiAtIFJlcGhyYXNlIHRo
ZSBjb21tZW50cywgY29tbWl0IG1lc3NhZ2UgYW5kIGVyciBsb2dzDQo+PiAtIFJlcGxhY2UgZGV2
X2VyciB3d2l0aCBkZXZfd2Fybg0KPj4gLSBSZW1vdmUgSW5pdGlhbGl6aW5nIHN5c19jbGsgYW5k
IGx2ZHNfcGxsX2NsayB0byBOVUxMIHBvc3QNCj4+IGRldm1fa3phbGxvYygpIGNhbGwNCj4+DQo+
PiAtLS0NCj4+ICAgZHJpdmVycy9tZmQvYXRtZWwtaGxjZGMuYyAgICAgICB8IDE2ICsrKysrKysr
KysrKysrLS0NCj4+ICAgaW5jbHVkZS9saW51eC9tZmQvYXRtZWwtaGxjZGMuaCB8ICAxICsNCj4+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9hdG1lbC1obGNkYy5jIGIvZHJpdmVycy9tZmQv
YXRtZWwtaGxjZGMuYw0KPj4gaW5kZXggNGM0ZTM1ZDQwNGYzLi5mNjgwMzkyYjAxYmEgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL21mZC9hdG1lbC1obGNkYy5jDQo+PiArKysgYi9kcml2ZXJzL21m
ZC9hdG1lbC1obGNkYy5jDQo+PiBAQCAtMTA4LDEwICsxMDgsMjIgQEAgc3RhdGljIGludCBhdG1l
bF9obGNkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAgICAgICAg
ICAgICAgcmV0dXJuIFBUUl9FUlIoaGxjZGMtPnBlcmlwaF9jbGspOw0KPj4gICAgICAgIH0NCj4+
DQo+PiArICAgICAvKg0KPj4gKyAgICAgICogUmV0cmlldmUgYW55IG9uZSBvZiB0aGUgTWFpbiBj
bGsgcmVxdWlyZWQgYnkgdGhlIExDRCB0byBvcGVyYXRlOg0KPj4gKyAgICAgICoNCj4+ICsgICAg
ICAqIExDREMgR2VuZXJpYyBDbG9jayAoc3lzX2NsaykgLSBQYXJhbGxlbCBSR0IgYW5kIE1JUEkg
ZGlzcGxheXMsDQo+PiArICAgICAgKiBMVkRTIFBMTCAobHZkc19wbGxfY2xrKSAgICAgIC0gTFZE
UyBkaXNwbGF5DQo+PiArICAgICAgKi8NCj4+ICAgICAgICBobGNkYy0+c3lzX2NsayA9IGRldm1f
Y2xrX2dldChkZXYsICJzeXNfY2xrIik7DQo+PiAgICAgICAgaWYgKElTX0VSUihobGNkYy0+c3lz
X2NsaykpIHsNCj4+IC0gICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IHN5
c3RlbSBjbG9ja1xuIik7DQo+PiAtICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGhsY2RjLT5z
eXNfY2xrKTsNCj4+ICsgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAiZmFpbGVkIHRvIGdldCBMQ0RDIGdlbmVyaWMgY2xvY2ssIHRyeWluZyBmb3Ig
TFZEUyBQTEwgY2xvY2sgaW5zdGVhZFxuIik7DQo+IA0KPiBEb2VzIHRoZSB1c2VyIHJlYWxseSBj
YXJlIHdoaWNoIGNsb2NrIHRoZXkgdXNlPw0KPiANCj4gQ2FuIHRoaXMganVzdCBoYXBwZW4gc2ls
ZW50bHkgaW5zdGVhZD8NCj4gDQo+PiArICAgICAgICAgICAgIGhsY2RjLT5sdmRzX3BsbF9jbGsg
PSBkZXZtX2Nsa19nZXQoZGV2LCAibHZkc19wbGxfY2xrIik7DQo+PiArICAgICAgICAgICAgIGlm
IChJU19FUlIoaGxjZGMtPmx2ZHNfcGxsX2NsaykpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgTFZEUyBQTEwgY2xvY2tcbiIpOw0KPiANCj4g
RmFpbGVkIHRvIG9idGFpbiBib3RoIHRoZSBMQ0RDIChnZW5lcmljKSBhbmQgTFZEUyBQTEwgY2xv
Y2tzDQo+IA0KVGhhbmt5b3UsIEkgd2lsbCBtYWtlIHN1cmUgdjMgYWRkcmVzc2VzIHRoZXNlIGNv
bW1lbnRzLg0KDQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaGxjZGMt
Pmx2ZHNfcGxsX2Nsayk7DQo+PiArICAgICAgICAgICAgIH0NCj4+ICAgICAgICB9DQo+Pg0KPj4g
ICAgICAgIGhsY2RjLT5zbG93X2NsayA9IGRldm1fY2xrX2dldChkZXYsICJzbG93X2NsayIpOw0K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL2F0bWVsLWhsY2RjLmggYi9pbmNsdWRl
L2xpbnV4L21mZC9hdG1lbC1obGNkYy5oDQo+PiBpbmRleCA4MGQ2NzVhMDNiMzkuLjA3YzIwODE4
NjdmZCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbWZkL2F0bWVsLWhsY2RjLmgNCj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWZkL2F0bWVsLWhsY2RjLmgNCj4+IEBAIC03NSw2ICs3NSw3
IEBADQo+PiAgICAqLw0KPj4gICBzdHJ1Y3QgYXRtZWxfaGxjZGMgew0KPj4gICAgICAgIHN0cnVj
dCByZWdtYXAgKnJlZ21hcDsNCj4+ICsgICAgIHN0cnVjdCBjbGsgKmx2ZHNfcGxsX2NsazsNCj4+
ICAgICAgICBzdHJ1Y3QgY2xrICpwZXJpcGhfY2xrOw0KPj4gICAgICAgIHN0cnVjdCBjbGsgKnN5
c19jbGs7DQo+PiAgICAgICAgc3RydWN0IGNsayAqc2xvd19jbGs7DQo+PiAtLQ0KPj4gMi4yNS4x
DQo+Pg0KPiANCj4gLS0NCj4gTGVlIEpvbmVzIFvmnY7nkLzmlq9dDQoNCi0tIA0KVGhhbmtzIGFu
ZCBSZWdhcmRzLA0KTWFuaWthbmRhbiBNLg0KDQo=

