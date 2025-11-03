Return-Path: <linux-kernel+bounces-883750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E63C2E446
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9E34E289A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9723305E19;
	Mon,  3 Nov 2025 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FtGwufGZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE453019C1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208964; cv=fail; b=ju2qLgnnKh79HcOtyrlBZLBFnW9EKIlQWEqtm0eRanu+WxtNGBaMGbjItNqP5NXQGTIiQt1Lp7wG9Om07g0sFLgNPduQyKzSF0itQjDzJRYvtEDnLmpl5Nc6NU+UMEi5yli+an2ZVSUuAaj9dhE1JptVvNR/oduwRhA5oKe7neQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208964; c=relaxed/simple;
	bh=t2KPFZFCQHhrUrsgzU3wvnxGCq3mKzptbYA3FKEPLGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmPgrC0YzI6qOLr+1Ka2UEK4f8V8gG419cT5cDuHjnh8x/OYSzuAeDW7cuH+CMeH1uATwlF1+97yutDMqQZqyFjCIdzrkAgrCS6RaBU52TyDNnRRTI34n+0xgiqFugzMWHOkzG45Gs5HljFRduUjvRX1m1nmTFLiUK5f3uAUgI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FtGwufGZ; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5qAcSk8VTpAkRSQgtaCrVAUuMdqXJaD/xkj02yj0U7eBcVeQA6VQMrXBwDXKvYA13Qd53eSDwfz0g5RMFQrbyPA13SE9gap03uc2kvcY0axDSYgem3UodxICBfneIrTcDsRpUpik45s2Eqywb2yEJcVmVri7M0ySVI1t0nrNly/91c1v0stwyP2hHm0lBJWTlpEcVZL2vRhxCwoeD6Cr0NDhXdooVv3TjIF25zgNznlrufzYCXeGDT3y1+36URpILMQKBsTY65+aga7W41aOK7rvAJFfFl+C9st2XcgsgZtpeQ/mtxcvFz4aLXrU/Xr7uqCnHjNQhqr+M5Eq5moag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2KPFZFCQHhrUrsgzU3wvnxGCq3mKzptbYA3FKEPLGY=;
 b=pfH5U8r2lK/+JMZv6xtOKmaeBWFwb1OBNOHTLCMYCTXD81eYYkzn76Std9OXABMynhHezPeE3R7q8YKmu+B0MDTcjKjQh00Os7tk98ZbMQW1WsRLjzIvm2jr87sr1ODGfp+7jE3WhZlC7d/wN5FNy9Pac+wRYI6RrB7tvcYipFa7Q73cxnuY5KUj/ieXdgeQokpujAeWGtpzQXS4dDo+3RgwBQBHwLVhgGJadNck9WgLaBZG05oE93AoABVUHLQwtOmUNr+gBOD8vyAaOJmU/IQon/c3bbJiE0Wu0qu3yfbRC7UXPK/zF9yXi6ELExOWTdx3uNiUlnjK16woSN1NIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2KPFZFCQHhrUrsgzU3wvnxGCq3mKzptbYA3FKEPLGY=;
 b=FtGwufGZ8vXiy9V1GZni5M4zaeUxrZ2TIBxztdsFvLQ22Dgk5M3DEOXtvDJ7ojG32kpjnXC0ywkjgNAwfh8VUccwj7WhBd5Zqv67UFvrVQB4fHEJy8ke4aDYi8IEgMulKvTlR8aqH+WEu2XBL3zfKy2D6hRRUDqLdYAJPax6JCAVsgYMFea8iYMW0Sl8/kL9r//LwRPqWidIyaXtyJ5ZUYSAYbd3PBoUbaGn9Ie5RWjaL+6kz0KCe8MkB7X9VVDYvxuZ23UjUEyc7DHJ7ciK0gb4TDtg87U8PdedxGmyHcd2COyO8gd5vu6yvHjzALKjOXgP+LrDURCIfGbYAY654w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB9073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 22:29:18 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 22:29:18 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "hui.wang@canonical.com" <hui.wang@canonical.com>, "mwalle@kernel.org"
	<mwalle@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "florent.trinh-thai@cs-soprasteria.com"
	<florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Topic: [PATCH] eeprom: at25: convert to spi-mem API
Thread-Index: AQHb66DA/2ST5DqqmUGvisuiiSELdrTh5/AAgAAscICAACr6AIAAC/mA
Date: Mon, 3 Nov 2025 22:29:18 +0000
Message-ID: <437fcacbc39286d1256e1f7ef034a2a3d52a8b18.camel@siemens.com>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
	 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
	 <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
	 <662a5f56-8851-43a8-af27-237acd799943@csgroup.eu>
In-Reply-To: <662a5f56-8851-43a8-af27-237acd799943@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB9073:EE_
x-ms-office365-filtering-correlation-id: f844cd3e-448a-45d5-350d-08de1b286dba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTk5L01OaVZyemFLMytic0UrQXNPM0lvQlkxYVQ3b1E4TnpWYUdtUmNzV2hT?=
 =?utf-8?B?M3RSSS8wYm8zOGRLbllsUktYeElUbG5UR2xYdDYzQmxpdWVsOEdNYTFEVXZV?=
 =?utf-8?B?cWtzQnppR3V2Q2VoV1dvSVliU2JrYk95UFFSa2ZBOVVTY3pMN0pqQ1JqV3Bn?=
 =?utf-8?B?eEhQMG11bUdhRUNUS3F6TlZvdVh2Mms5ZnNRUkZZZE9JcmJjVzNQdGdpcUdp?=
 =?utf-8?B?dnB5Y2VUYXg1emFHeDNLMHBpdklWSU92bGZoMDRUZ21aMnNHcnZHSUNROWlO?=
 =?utf-8?B?R2lQQmhSWVEwb2l1TllXSkdqdDJPQ2svbEJQOExLc05WTmpJWXlkN0Yrd3Vu?=
 =?utf-8?B?RHJpeFFiS05LY1pLckhyY2x3dC9mTGxMTWZrZzlha2dDM2d2MmtaMkRueldw?=
 =?utf-8?B?bDdXczRGNS9ZQ1hWZnNXSWNjcHdnaFd0QmVMV0lrOTZFd3JWYm05QkZnaGt3?=
 =?utf-8?B?SzdSekptYUJHQmlXZ2JZYWozY0lKWWtCb1lNNmRwNHFITGR1YXVKMkRHaHIz?=
 =?utf-8?B?WmFaU3NrMyt6ZGVoY2h2WjhTYTFYMDBRNkk4cmsySmljdHlBOG5UTmdwcU5z?=
 =?utf-8?B?T2pOdzJhUkNlR2JobkIybEVUdVJvSHNOaHlWVDNLVnFOSzRCUVhZZ1I1WlMr?=
 =?utf-8?B?NGZjUzhhQjB4bzV3dDNpN2NlSURmUDRBZk9YZUdwbmF4TEFMQkdZZk5aazV3?=
 =?utf-8?B?UXYrcjBDMVA0S29YaFhmbGRHUTlaaG9xMW1iOHI1WWtlU2dqcWxuL1RWRDhq?=
 =?utf-8?B?amNFWUFSdGtta0VUQzJzZWc0d2JJRWovWkZLQW1jcUE4aGRMTnJXRTBXN3hM?=
 =?utf-8?B?emdXSmxwYms5MHNtdW85Qm1zNXM2MjQ3aDlraDdGUGZHbXBCSjY2VGUxUHRB?=
 =?utf-8?B?L2JUdllITGZBWWd6T3g5eDNKU09SLzF6K0VJS2Jva1R2RzJuU005RHoydmsv?=
 =?utf-8?B?L1F1QnA1c3I2ekJER3ArdS9VT1ppazVpUU9kV1BTWTRyTTBOY3hXZnBvTnd5?=
 =?utf-8?B?bnF3RUJXZWNYZW9qNDV4MTV6Q1ZGREVDN2xsU1FWL1VDU05BUXc4OFZoYlJR?=
 =?utf-8?B?ZDVReHFUVjRBMERBUjIrT3EzZDZVeEswUnVkRnNZMkgvNmhVejJUWFpBcHpZ?=
 =?utf-8?B?Y0RIdjJaTXRud1Q2MTAwRnpxVEdvNEtCNnBESUZHQThSZ0lqNC81amdYYkZz?=
 =?utf-8?B?dXN6Sk8ydENZY3dPNElJNFB4RnROWDZZSG9WWjBtSitTR0pxOGJ1NEFtdGhi?=
 =?utf-8?B?Z1VVSkh6S2x3UU13aEVMM2dtUG5JNEZqaSs5MEpDOHUreEVNVEsyOS9SQk9t?=
 =?utf-8?B?anZUdTZqMDAzaXJUUkdHZ05hanJqZlJCSXBiOWhFbW1rd3VHTlVSREpJcmk2?=
 =?utf-8?B?dXJhUkdlbE1iTDVLd2grN3piK1RBT1JlcjNnaWNGL2p5VVBUNXp1TkpGRmts?=
 =?utf-8?B?VnhnSnd3VDVpb2M1dHY1OHpjc3FOeVF0RHM3V3ZuY205djEyMUQyTElHMVg4?=
 =?utf-8?B?Wk91TEdrbHk1SGg3dWRYNUxDdG1ZTlFUQ2ZTNGluWGtLOXhKdE5kRmhEc1pv?=
 =?utf-8?B?UlhmTUhJeENUK2lkMWhVNG1zSkxLY2dMcEEwdm5HU2Q1UDAvZmI4WkI4WkVv?=
 =?utf-8?B?TWpzNWx1cUxrOEg5UGdjbHM5NUoyOUtOQzd5R3pTT1BZMi81L0FQTVlHeGQr?=
 =?utf-8?B?bWgvR0FjUGc1b1RpeFlnMURKTWJGck1LRnZyTjBqRVF1M01ObWltdlRCZDVs?=
 =?utf-8?B?MnJOeDNnbTRlN1ZFbWQwRmdxQm9CWnFPMDB3NmNuR2RrVDBxSDkvMXVGR3pN?=
 =?utf-8?B?MjVIZUczbEhCMzFCNEV4K1NoSU5CVzViakJ4SlY5S3JtUUUxcmZDV2ZQV2gy?=
 =?utf-8?B?NG0vbGFpbzUxOWlLZXdReDUrRHE1Tng2YkFWRndDNWhBdHg1QTlHMGtRNFRI?=
 =?utf-8?B?M1VDNktjdG5pRXZIY3p6anV2QUtsN0l5NFNoS0I5TUtsTnZwdkxCVkJiWGFE?=
 =?utf-8?B?Q29kRnhBZ0JBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGIremVqcWl5eGFaTjZSM0dHZFFzdjZHNU1xVUorUUpMdWFNN2FQaDR3ZEhy?=
 =?utf-8?B?SWlZK1p3MS90dndxRTRDTXhMMU56WXMrd1I0SGFKd3B2NUNOUlRsM2xWL1FF?=
 =?utf-8?B?S21EQW90ZFVzVW1BbHltSXJOQnJyOWwzUzZJZk5NVFQ1TE5rai9Cb3d6ci9M?=
 =?utf-8?B?N0xCV28yb0FkUjU0Y1hDNytLS3daZHIwM21kbHhQeTNXbFJrNCttNE4zc1Jw?=
 =?utf-8?B?aWREL1BrMnJPcWpYQVBTTWdHeWJZYmQ1TENJMUV5RFBvSFJRL2x4TndGMzIy?=
 =?utf-8?B?WExUU2l6NE9GbDl0RlVNVW9tTENyVitNNk85MnEvcVRieW1KUFV3RVhLTzlz?=
 =?utf-8?B?NlNPTFovZGg0ZlJKRWp4bmhXQ3RUelNGc1dUaUlNekJjTlBLLy8rTmh0RDZN?=
 =?utf-8?B?aUpHU0Y0Qk1OZGN2a1liU2dKU0ZOU1JPZjVtQUZtQkdwZWNEUW5EbCtFbVV1?=
 =?utf-8?B?UitkOEpqYVVIRlFWRENpdVdqcmpvUE54dGFkYXlGQ2FBSndWbDRxaHlXL0c1?=
 =?utf-8?B?VktYZk9veWI5bzFkQU9HbkJQRGppVEhDQ0NxcXkxMDkzTlhTT1VNNGtYUHRL?=
 =?utf-8?B?NG5RN202anpLYmhlOWtnY3ljYWllL1U4SCtoa29YZmhJYjJ4bW9wUnNKYm1i?=
 =?utf-8?B?MU0xRVNKOFZzZjNVb0xZWmZhTXlGek52RlB4SjBNSFVqL1JpUHZuak5pMDVr?=
 =?utf-8?B?RlRFeTNZZXBDZlNLWUZQMDdYamJDK2p0SzAwSDM4aDRWeStIVUZVdWl3R3pr?=
 =?utf-8?B?OHhsR3kvOGVzWDdWVFNDOStOY3NUaHNwMEJWUmZWTmJXMnV1MitUWEhMRzEz?=
 =?utf-8?B?bnNoZysvMzAzUk9QRGl0TUxKa3pib0NVazdKaFVsRkJSMmpPMnl6cEo2cytq?=
 =?utf-8?B?MWdBcWF4Vm9NVHJ5N3lMVnRiQm1SM0xOSE9YVHpBOFlHRGdXTVo0bktWZGdW?=
 =?utf-8?B?RUZvSytMRHVGSzdPeS9WUGtISkZKV1FSVHNRRW5WYTRadm5CSmhQU0NlcUFI?=
 =?utf-8?B?ZFltU09hSzRnV2JhSDJUQTg0VWx4WVhGTmltNS9FcE1hWkxXUVNjZjlCV1dS?=
 =?utf-8?B?eUsxQ0RGQktsSHc3Z1d5aU45YTdFMEpzZTNKczh4UExJdTNMSDljWGtOT2Jl?=
 =?utf-8?B?ZWF2enh4ZG9hZXVtYjhDWFNhWVRCYk8wV3NmWkYrZmVUVFhwTHBVenJLM29O?=
 =?utf-8?B?Z09veVhrbHdiRTVzT01EVmpYaHZJdjdrbTd4dXJHWm5OZHBIZEsxTzdTNUt2?=
 =?utf-8?B?UVZkalZhcUx0VVI3NGMveXREU2plVkM3OVMrb05KNEk1dURvaGUxODZaZ2VL?=
 =?utf-8?B?YmxnOGpka3JCVWNiS3VXTnNGMk01eFhxR1d5ZXNmcy81VUZRWk1oVllLckgz?=
 =?utf-8?B?cGVGT0RMeG5UUkIveFQ1d3UvRmxJT0xlWDY1OVlTdFpob3YwdWlUVitVeGh5?=
 =?utf-8?B?dDFJdCtiSlFJNzR4Rkwrb2xXYUNYVEpRR01hL3pQTWFKY1BVMEp6cmpjcllt?=
 =?utf-8?B?UXJSUFI2VG93TFgxUTlzMTJpQmRaK2ZMakE3bkh2QzdmUGxvZDBvQnhyQzJM?=
 =?utf-8?B?ZDYyR0ZZeURhbU5kTnpLaWVTcmF0dUIvUFhvangxbGNqVG1uMkMyQnpzZ0hY?=
 =?utf-8?B?R2ZWd1BTQzYvbEs0RXM3RnhHNUF0SjQvbmpHazMrMS9ucjlhVDE1L0FYR2Z4?=
 =?utf-8?B?dUZibEpTVEp3ZXZLS0NpRFpkVG1vdGJTelZzZi9FTEd6eVhDbnlBZ1dEeElJ?=
 =?utf-8?B?NVUyVlZXSjNJWjJEY3AvbHA5VStiZDBobFhtNDlpMnN6dlV4Q0tkOThmVitV?=
 =?utf-8?B?L1pPbzdUdUQ4aUFvczFmUTFpZmZSYW9PWklNeXVvZ1JnTFB0NXZ5dFh2dmFm?=
 =?utf-8?B?anRramF3Wk9DcWhqK01QRTdzMVZ1dTdZTzQvSFAwQ2hNNDhWY3diM3lzR0Fz?=
 =?utf-8?B?VzgvSExkbHFyQjlGVjhzbjBFS0l5dW1QV1FETWJNTUUyRHVJVlR0cDV3WHdp?=
 =?utf-8?B?Ui9vR1V4K1k3MTZHcGNRYndLNlExZ3QzY3FMTVh0VElmQlVBamF5a0YxcUJ4?=
 =?utf-8?B?V1IwNVlOMVN1bUlUdW0wbmlTQ0ZkTm9OTmtEN2U3bXJCU3dmZWdJVll3UGla?=
 =?utf-8?B?eUNPUE8vSTdTQUJCTXBUcVJzc05mNnBuSkE5aXozR1JBSUpQN3N4Q3VRZFlM?=
 =?utf-8?Q?Xh6I2+z7qV149XySfcYV8hY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3DE41A9E6B50E43A2C9C8973AEBB77F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f844cd3e-448a-45d5-350d-08de1b286dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 22:29:18.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3E5M6QendOh5jICPk/FuSZPo4zQQU1+vfcJMQNE4EScGiUUcK9zycAGM/Fo7JI8B56pyg4+z2svApV8rbWdoKh/Bp0V6e6DRgFwQUmBMsIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9073

SGkgQ2hyaXN0b3BoZSwNCg0KT24gTW9uLCAyMDI1LTExLTAzIGF0IDIyOjQ2ICswMTAwLCBDaHJp
c3RvcGhlIExlcm95IHdyb3RlOg0KPiA+ID4gPiBSZXBsYWNlIHRoZSBSQVcgU1BJIGFjY2Vzc2Vz
IHdpdGggc3BpLW1lbSBBUEkuIFRoZSBsYXR0ZXIgd2lsbCBmYWxsIGJhY2sgdG8NCj4gPiA+ID4g
UkFXIFNQSSBhY2Nlc3NlcyBpZiBzcGktbWVtIGNhbGxiYWNrcyBhcmUgbm90IGltcGxlbWVudGVk
IGJ5IGEgY29udHJvbGxlcg0KPiA+ID4gPiBkcml2ZXIuDQo+ID4gPiANCj4gPiA+IFdpdGggdGhp
cyBwYXRjaCAoa2VybmVsIHY2LjE3LjEpIG91ciBwb3dlcnBjIGJvYXJkcyBhcmUgdG90YWxseQ0K
PiA+ID4gdW5zdGFibGUsIHdlIGdldCBtdWx0aXBsZSByYW5kb20gT29wcyBkdWUgdG8gYmFkIG1l
bW9yeSBhY2Nlc3Nlcy4NCj4gPiA+IA0KPiA+ID4gV2l0aCB0aGlzIGNvbW1pdCByZXZlcnRlZCB0
aGUgYm9hcmQgaXMgc3RhYmxlIGFnYWluLg0KPiA+ID4gDQo+ID4gPiBUaGUgU1BJIGRyaXZlciBp
czoNCj4gPiA+IA0KPiA+ID4gQ09ORklHX1NQST15DQo+ID4gPiBDT05GSUdfU1BJX01BU1RFUj15
DQo+ID4gPiBDT05GSUdfU1BJX01FTT15DQo+ID4gPiBDT05GSUdfU1BJX0ZTTF9MSUI9eQ0KPiA+
ID4gQ09ORklHX1NQSV9GU0xfQ1BNPXkNCj4gPiA+IENPTkZJR19TUElfRlNMX1NQST15DQo+ID4g
PiANCj4gPiA+IEhvdyBjYW4gd2UgZnVydGhlciBpbnZlc3RpZ2F0ZSB0aGUgaXNzdWUgPw0KPiA+
IA0KPiA+IGNvdWxkIHlvdSBzaGFyZSB0aGVzZSAicmFuZG9tIE9vcHMiPw0KPiANCj4gU3VyZS4g
QXQgdGhlIGZpcnN0IHBsYWNlIHRoZXkgbG9vayB1bnJlbGF0ZWQuIFNvbWV0aGluZyBpcyBsaWtl
bHkgDQoNCmluZGVlZCwgbm8gb2J2aW91cyBjb25uZWN0aW9uLi4uIERvIHlvdSBoYXZlIGEgY2hh
bmNlIHRvIHJ1biBLQVNBTj8NCg0KPiB3cml0aW5nIGluIHRoZSB3ZWVkLg0KDQotLSANCkFsZXhh
bmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

