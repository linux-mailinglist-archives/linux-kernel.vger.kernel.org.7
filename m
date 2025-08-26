Return-Path: <linux-kernel+bounces-786577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B746EB35E81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEB71894CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619E29D292;
	Tue, 26 Aug 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BK0MqjWJ"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012016.outbound.protection.outlook.com [40.107.75.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC920330
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208949; cv=fail; b=PhyiQTFVMyqijWR3PO2Z8nuzfzeNGwLa1LGcIR7LXwxQ2Ph+CB+uByNL2v1Ky+ws9AOXlLK14/zRqFJlYuhIUYxk2kUTx2BO+8S+h7KhAPBoDyBhqQQi0JiaPNuUbTcetp5VzxIYx2cRrij4fKDqr3cR2T1k5c1p3rQPfiDdNtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208949; c=relaxed/simple;
	bh=VYE0GDLsv4v6rd3qmjkDCSiFRytEjYBKluHSUYI8egs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2nLxqQg+/+/kU1aF3SLZaanNnpHdPLyyN8NMD/Er21v16zX503VsHzbiNo5n/PrxWhjOvSR4kWQcCbp/Mk2o8JV8NEacjo3hFPZInUYpt7IW4iZHz7mHJ/TnIxDLY5tDaPwG6FeAoChj60aU3Gb8HrE/8tCyZdF9BlCmN7Kd1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BK0MqjWJ; arc=fail smtp.client-ip=40.107.75.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMaiqNPRpD+kSxxEgroghsBu+0LJaE4Ip/MLSAiyHMVhIzN11cxKoSNlslFIyPxh/rTHavafzARvWBMdfW4xeyEyzeoSC0ASfJHoow/0fPWUSelCabgwlhiWL8YqP3XnHSH+TjFx6yi1F5oQAnUGXXI/ue7LMHr5dpbc62nte5XD9STnSlLNZJOR1cbffTZ5blxTQITLZNgRGdzlXmIwXBg5KdnqQiTcBcjxSO45b8bV7RF2CLOP4p9kQDWXC1OtJ8Hue2KIJi03DD57WxPR4QW2t5rLQGgkzmZ8wovviSWwh88v12dCVNtLyMero5eJ7E6g7+MOePfbZdR9Bv+o/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be1f7g/buO7v5Xb6f7FUj+s80inLrQULF9GpV0kjBSc=;
 b=Q6KprPIgDUTSXxJ+PR6uXxS7GDU94yIoG+sspSNjS8rJtO6WuOApltNPHkA6+ZaboTnECgQaoI8+lqGqqS31SuP2uXiZre9fm1GgiTESYkFf6Km6KaA9RLm6sWZhmdvEiQH0YzKxvwEU7cRDe6L5mkscJ9SaMCTeyQ61CLUgL8axosBCn08G8TqemBXMVkH2WGnMUs0CK8CJy2PdMW9PEwTEiF5AlVUaKQRZATqfSdgSQIcGFp7diopSv2QguaM+dbIofdE0ASLahLGZGuR9xDl7wkBF3p9t8nOu1WFJIGAUr7ze6qwkoJQvK8lPpBHEfvNmlp5EJHfUavkaf6xRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be1f7g/buO7v5Xb6f7FUj+s80inLrQULF9GpV0kjBSc=;
 b=BK0MqjWJoOei/IHZWG/1rFDm1cDrOmqE+/ClEZuEM7zZb5dxY0+M9m81euYdjL2gmHMBNgi9QnHbvmyndyjZOI0pQ/9OmzmkbcypLlFHZMfQeZqRSIhOwvdOWXVAJ7jxa4YHhOqPoOgEd5w+6j2QxxDg1IfzxVbjQtQ9qGBZM5dT1TEwyiEo7LZl8clfouEr198dLMw99hegunTlvVCfj75P7wwJIvqnZ9ef01AA0nR5QgDNBA7EECrISnvY7lCtacri1ObqsrvltUjBr67V1uDkbT5KMO083TkY3T+6UqaNhCXcQUNVdtm1KxgfbDf7cfleODamzMsUeoMStwHVrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6940.apcprd06.prod.outlook.com (2603:1096:990:6b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 11:49:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 11:49:04 +0000
Message-ID: <fcdb1a32-a7a1-4dc7-bbcf-58d802743b79@vivo.com>
Date: Tue, 26 Aug 2025 19:49:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: use int instead of u32 to store error
 codes
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Rubin <matchstick@neverthere.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250826095907.239992-1-rongqianfeng@vivo.com>
 <aK2KHhaFqWbd5S_O@stanley.mountain>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <aK2KHhaFqWbd5S_O@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b51ca37-1e6f-418b-745c-08dde4968e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEE1d1VOcXVMR2djN25aTG1OZTNmM3VlbFArZGQ2SlBLeWZaS0ZmQ1J3ODcx?=
 =?utf-8?B?d0xJbkJQbWpUa0FFWkhjekQ5NmZ6OVNMY3FNU2Q1TUU1TEFGNkFDMmdwUmdq?=
 =?utf-8?B?QTF4YzZMaDRPa2ZKSEYxYTcvWTZjVUQ1MlBiQm9seWo3akJFN3A4b3E3TGlj?=
 =?utf-8?B?TXhzRjBmdkdlWnFnWFBvbUhJYkRLbmpEdEVGcFZjb0lLRlg1R0tVVDBNV0lD?=
 =?utf-8?B?RWhQUW16UytwSkNta3JaeDZRc205aGwzcm5jUDB2WWlmNnlUb2wwTDVGMjI2?=
 =?utf-8?B?cjQ3dUs1aEFUN1dyc3hONU56S2liMnNSYVE4dHluU09UZzBUcHBPbVl3Q2pO?=
 =?utf-8?B?ZHNVbDJuaEY1Ri9tT0ljYXVTVm5ZbDNGa3FYMWdsSS9SQXFUQXRNMit4MEpV?=
 =?utf-8?B?bG5NemtneG9JaW03YjJFa0MybXJidUdqTkFnQnRGSGtFWDFnNE9SLy9BSlF1?=
 =?utf-8?B?V29Jd1lkOTJPVjVEdytRbzNSazdQU3RRcXdGYVhqWTc1bTZBbThLSzZMREFz?=
 =?utf-8?B?SWZscjFqSTNJcFRtZy8zRkdybnQzU3lqSjNwY1FJYklBK2liTGxkSTFRaWl5?=
 =?utf-8?B?QnE4QTEvNVgvb1VjT3JTWGJZeUhKUDhXWWZDNytyM2wrbmZnMDhTR1poWDND?=
 =?utf-8?B?Ynk0MGhuNDVGTWVDdjhrcVFuTHpVVE9DWmhGYlVPdEZYeldLOXJTSmlSakRl?=
 =?utf-8?B?VUVPZ0ZQZjAwVEduYkc1dzUvMDNUVDA5cldpWFVOUjU2VU5SbEtMRm1LMWE5?=
 =?utf-8?B?Y0pDenovZS9DTVhFN2hZU3pEeFZmbDlNOFptbW0yTVdkMjZaa2FnWStkSlhY?=
 =?utf-8?B?a1VNaE05WGgzeDlIRWpFcGIwWVdwVEFGZ1ZwSTZoSTdLMTJEMmF6YndwZ3J0?=
 =?utf-8?B?L3dsajdCSnFIZlAreXZlQzdjc1hERTROMmQ0OFlrWDNwS1F2ZGxhbU04SkE5?=
 =?utf-8?B?QUlOZk1DZGJUUTFnY0NVRllIamljbDY3K1RNVS9kbGxINmpOU3k0VUhkcldN?=
 =?utf-8?B?em1pQ1c4eTFqd1AzdU04ZjFqWmtta0RtT0FuczZEVFUzWGdGdFBkRGdJQ1dl?=
 =?utf-8?B?RVJKOGhOMGwyNXY3d0MrS2k0dUtZbWpJNzRVNURpVFFlZGZNUXJHMnlWL01O?=
 =?utf-8?B?NWw0VmZpWlY4NDBNQzRNdlpwVlpzSVpHb0NXdTE1UlQrKzB4Um5nWVoycDhC?=
 =?utf-8?B?MTRoTXF1ellHNnc5TDBiS3c3TSs1ekFVOVhMNFFKeUtrYU15RGliWThENW9N?=
 =?utf-8?B?enlDNjNJNlR5WXduQjJ4cWI5a3F6TjFkUThpalR5OVd1TzJGcTRBTldHRm9H?=
 =?utf-8?B?N2RscnVpL1JjZThWTm4zZHdpdmpxWGVJL3lDUUpGQ2psa2gwc05GYlo3b3hE?=
 =?utf-8?B?SU9RaU00MSsvaVZaMWRaSEt6bXAyQ1psbm1yWGF0TnhsYnBUaEFTWjVqMTUr?=
 =?utf-8?B?YUxlMzNvbU1SLy9pZDNjeUNPWTh1VUp0OGhDRnl2K2JiWnpNUUxhL0RvWDBB?=
 =?utf-8?B?UWdFMTRsQ25TVWFRcnUwY0R5MlBWZ2NURXFwUHFFMDRKL3F3UjE1RlBjU2Ir?=
 =?utf-8?B?YUNmMFFXRllVeFE1Y1lsNEQ1dU1CNmo2SlVsZzhVTjZRT015QWdzQmNXbjU4?=
 =?utf-8?B?VDdEbTcxbkJUaURva0ZsbjQrQk5nVFg3UlAvS3F6UGRLeG9NRytWcHFDRllx?=
 =?utf-8?B?NkVEVmRJSlZncWZZNFhSeGcxRFpmdU9qWVFBYzM3SFRiWEtFT01mSFpma28y?=
 =?utf-8?B?Y2gxTUl0Y0s4QWxrL0dPbXI3Q0FQcmpId0YxSjBRVnJIRlMyenV0QzIzdXU5?=
 =?utf-8?B?Ukx1Mnd5anRtYUo4b3dlY0Uwd0I0anZDRFA1QmM1Yk51Vms3QUI1ZlVMT0dp?=
 =?utf-8?B?SGxvRnRFZmp1UERydVZ6M0ZmRndyZFdFdmgyeVJqYml2UUN6VWtOSktiMXVk?=
 =?utf-8?Q?Z6VsXZbDDxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGlFSWFKek40Rm8vNi9henhoWHUvamNrYjNaZHR6SWlwbHdrd2d6N1Z5S3Yy?=
 =?utf-8?B?UjlCNWUyVk9hSmtkMEpzOW84SXUwdWlJY1dJb3p0YjhGeVAvS080S1dVUFd5?=
 =?utf-8?B?a0wxczdoU1J0TThoKy95L1ovalg5QjBub0o5akJEcS9XZ01PZE1Nb2hMcW9L?=
 =?utf-8?B?RUJvQXNBNVB0ODNqRlh6SXV2RFNKMFpZL3hhR1BhOGtSaVE3cTFrRlNBdXBZ?=
 =?utf-8?B?K3VmMG45YVB0d2RPZ2IrU0ltQWFIaXEvMXptRzhrN3BnN24yT254Y2k1UEg0?=
 =?utf-8?B?dDBoazR6S1NQZkhVbjF6SFFzSkFYb0pUSUJHRHZRVDMwendGaWhsejNZVUMx?=
 =?utf-8?B?TDl3TGJxR0Z2K25MQkc5UkxOd1gybTdROVU2RlNGbVI2R0YyNWp0RTJ1OFY4?=
 =?utf-8?B?N3J0dXJSZUc3cFI4SzJ4RlZqSlpYY3VtZlBiYmZQdTVPYzBXK1ZMKzRVQmtv?=
 =?utf-8?B?cTh4T2loZ1hxemFSQXVVWFUvR2cyb3k1OFczTHdYRnhXRzhHVDcyM3FnM0xY?=
 =?utf-8?B?VER5c0p2UE4xWEJVSDR6UVpDUFRNdkYrR05ISk9vT1VJYi84N05CMXVaRC95?=
 =?utf-8?B?bm5pN2t4RHM4MWdVZFVOT3dhVGZJcWFuTG95WmtOSlFPeEJXSlUzd3BTVFJs?=
 =?utf-8?B?RjViTEJIVmlOMTh2RWs4WWtidmJSaTFZQXZ5blJKbUxjTHkrc3ZCS2NPZm40?=
 =?utf-8?B?L1Fac3h5Z0h0WmF4NS9wRFNYRGVtaGJ6M0NYbk5FQmF0T1J2WlJzMG01bHYx?=
 =?utf-8?B?KzR3aHFFVHU5cDFFMUN2RE5wLy9RZ1VvRW9kRVd3dTRIcFVqQk9taU1VU0ZZ?=
 =?utf-8?B?TUc1YVhCUXR1SFN3UU5zSGxkTEsrM1oraG1BdmZKeDVmcXJ6SS9Oa3lFa1pj?=
 =?utf-8?B?Sy8vUTB5cm5JQXhaNUk4RDA0WE1YaVQvb01IcEhITUZyNWJTQ3VwV0hXOERK?=
 =?utf-8?B?YkxmSVIxeXc3cEM0SXB1N2E3VTl1NzRhMWNiWGxLZEZhTWM5MHlXajd5ZTFV?=
 =?utf-8?B?YWEwdTZMSFBsUFNvQmFSWkZxL0d2dVROa1NNUmRBOGNzcnFnK3NGclk0K3lO?=
 =?utf-8?B?NnNiQ2U3MVlwb213TVdYZjJ3T29HcDJyNEg0ZEhEZkpuNzFDS1hSMmp3SVQ3?=
 =?utf-8?B?QXZXZWtST1BSc0xsTTVqNVVhTHYyNFZIZmtQZ0JzR1BDYUZtSDdNRC9KYlpR?=
 =?utf-8?B?VlB3czI0dHp1RFlJL0Z2Qk9xTG90UjdwREpGRTM4NW5MRjIwZmpvd0xMeTRn?=
 =?utf-8?B?d1RuWmJPWS9PenIxbUl0ME5YMksyRFBtL1ZMU0ZBRlh0bW5sRm40K2hxOVRj?=
 =?utf-8?B?TnArbFRhTCtsNXE1RzVUS1NNSEoxRG9oVERTMi9Lbm5QSDk3dUFhdDJnOG84?=
 =?utf-8?B?L01VVVBaV0tXQlVqL0ovYldkMENETGNPdmNEcHVxcHREVC8zZk9vUHdyWGp4?=
 =?utf-8?B?WWV0a0dqYURWLzBSbjdBTHlUQVRUWUN2eG85M0IyVzhCcGVobjBHeElNSzlm?=
 =?utf-8?B?Q3pWWHpCalJ3T0dzMzYwZXptKzErTC80SGhOakgzRjdlY2VsTkZQNitWek9l?=
 =?utf-8?B?cTZ3M2RGV3VZUkZ6L1Z5SkE1dDcwUmhLV1ZWMzRQZmU3UjRXZTA3bnh4L0tz?=
 =?utf-8?B?czdmZjU0eGd1V3dpaDZuald6Zi9VRnVIT29rOEFIMVhCZWNEcmxmWG1PRURp?=
 =?utf-8?B?TFcrTmNLbll2dzR2WEl0eG0zbFZDWWZyeTBaSkE1QThTK3E2Yjkwbkt1UTcw?=
 =?utf-8?B?WXhYN3hhYWVCZzI2c0JKTXUrMUxjWjhXWnlmYkdFM3Bma21ZYWNnNUNOc3U5?=
 =?utf-8?B?RE16N3B0T252WGo3SStzbVhIU0IrL3pZQTBzL1FIQTBudm5IZXhET3ZnTnlx?=
 =?utf-8?B?NG9XcVoralpZOWNVSENYQjZaaXlPK3l4YmF4djdETUJvV21GdFV5MlBnTTBF?=
 =?utf-8?B?QzFJN240VWg4SlNMNG8xWENxc2pjN1JaQW1PaFp5WE9yNWM3bDRob2NEelQ5?=
 =?utf-8?B?VzMwOVZyL2RadUJsRVlTc2ZzUFphcXN3Q0lTa29SeDhrVGxSck9QdXVmeC8y?=
 =?utf-8?B?SWxKcnVweFJXVlpQenRUOHVLNG5Nck5JZ2dqWGo2NGJWUVpWL1VDNDdmVnpj?=
 =?utf-8?Q?3eH97x+ud4A5XEiINPfwmnI8I?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b51ca37-1e6f-418b-745c-08dde4968e45
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:49:04.0701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MT7DYW7x7IuKW+S0arw8vnxfNcA9ZQUxWDuxgnKsB1c6WyOlmf3gz7udp6cCmvCuYs0uoiHsS8oDBJfvAng9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6940


在 2025/8/26 18:19, Dan Carpenter 写道:
> On Tue, Aug 26, 2025 at 05:58:59PM +0800, Qianfeng Rong wrote:
>> Use int instead of size_t for 'ret' variable to store negative error codes
>> returned by bb_write().
>>
> The commit message needs to give a motivation.  I would have assumed from
> reading the patch that this caused a signedness bug but it doesn't.
> The commit has no effect on runtime but fixing the type is a nice
> cleanup.  My commit message would say:
>
> The "ret" variable is used to store the return from bb_write() returns
> either zero on success or negative error codes on failure.  Storing the
> error codes in size_t which is an unsigned long, doesn't cause an issue
> at runtime but it's ugly as pants.  Change "ret" from size_t to int
> type.  No effect on runtime.


Thanks very much for the detailed comments.  I will send v2 with a commit
message similar to the one you suggested.

Best regards,
Qianfeng

