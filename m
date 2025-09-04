Return-Path: <linux-kernel+bounces-801271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788BB442E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E30F1C867F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADF723507B;
	Thu,  4 Sep 2025 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="B+RhvIho"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830A1DE2C2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003724; cv=fail; b=SjoAEFlCXPsW4PL3uDaVa1MgCsJJ+b7hBNNbvsgP2ve4+ZxwXIOn4TsToNOT+gXYXQowN/72kKfaU13mWFdfAbV3h3DH4nqS8gRwPF/GeAlpsnrHUadYBf0ijU6DIQx4s4XC7jKPeGnN886oL57/NgHiHy+dd6O4d/BKGDfc+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003724; c=relaxed/simple;
	bh=19SOwnPHMJcVmSYApHBEKQzEK3u9+Fu74f2SFm5Cptg=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=eAyEmLuqCGl5rTP+Bb+/u1YwivIvR/cUeqFjRTvCKuU8yj/Tvtiq1PByYGEr0mxi4YqM3kZlBdI7IaMZYgOsogD+4Ijy0QRskFLUf73773EmJyZfTKt6xUecHX+/nSwlifpzIDhvIOIGUq0RrkmDA/OLHIGEJsJ8Fjd1kbN0voU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=B+RhvIho; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 584BIfxj2703661;
	Thu, 4 Sep 2025 16:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=7aAca9U8n
	VeLtt1SwmpFw++8ccnYf+Tu+KZwaj/1gYg=; b=B+RhvIhon3lrzUHeRZWlJS3UH
	LmMN7Z9iXBvKyr63HOAWU11EDXRw/AYnxxRKCV6f59OsQct7sGvi4VTLu0AjlKHE
	reKUpj1Qo63DllXggtKhMoEqGdKuZJrzmqT1fxIp/5APQJ+WYD5THqX/1Aqr7wEe
	rXE0wCS8dJDDR30CuuN1XbNJQazRL3n4IjsZFP1556/zMHxHcEs/39MR0IK3I4ou
	rjIpK9qFdszLl9V6iK9Q3ie4Odb472VxJevi3NNDye33ZSfhLM5pdwxP3Z775YYq
	LzHQLThSmulY6a/ai0R7jQXkXXSRKjbNVEGxRWPmTLaW/Ni81tO/yaIk1t5Og==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48y7p7gfgt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 16:35:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyC1cLMBk1y850krcjCX7OMvN6frO9q+MjMSB/Yr6ecLqHaQoAxVyRL8mZ+Kx1jsIjV9M0ksrYtu/+q3l6bxhP8lgRGuXGQxAZqCH+qUS/aj1P2OzPa6P9tVHze9aMX8lrDVfHTQARpMPFoxeKAAzRLQ1oiWDQvhuwNZCwXhbik91r2wpstY3os3uqINTkb/VI+gZm8ipHKRUcYIe1C/yiXUjQNOg+QEXbE/odqYUafWRo20vETaCLYnxAe6KUKtEopxxF0J2Jp+PGT00lXUQae/4h9e43q9hmxmW6RcYNYvhPPeS2IpfL4MU+5FA1Ul97EHzHzK4E6PTo2Djl/HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aAca9U8nVeLtt1SwmpFw++8ccnYf+Tu+KZwaj/1gYg=;
 b=Tt8VtAza9ckYnnQ0dnICy/ff5YLmv3d8hb3CiHhQ9hlVTExNWE46hgXvmUsVF7Tnuz75GKJRfsEFqg9q/FBIhk25Y9FOShHCNtee8JNLijAFCGMb1sP+3NqyheYU51GKrIhD1E0IRwrTvH/3P5+Z08Yp0P+trjqc5B+l+d5xlBdtlbRs5Z8OcRVBBY0bzYeo5Pm2B91VG33eisv8NUHcCeRWTYhDaxZW4d/+R/l0/l/6yEdmTKk6ARNtjcoeghBtxzmZsAbByBx7Nb+81o/SIzfbcQi0trnZbd01h/TY4fgaxWv+TCuXzs+2SEZngPB+tEn0EyYo45Y7DrfUJbkf7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by IA0PR11MB7792.namprd11.prod.outlook.com (2603:10b6:208:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 16:35:03 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 16:35:03 +0000
Message-ID: <87254ef1-fa58-4747-b2e1-5c85ecde15bf@windriver.com>
Date: Thu, 4 Sep 2025 10:33:20 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
From: Chris Friesen <chris.friesen@windriver.com>
Subject: sched: observed instability under stress in 6.12 and mainline
Cc: osandov@fb.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|IA0PR11MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc0511b-4b6c-4127-1002-08ddebd0ff8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjlkS0dQVmtZejNmakJENlBWMncwNkVZdHFCV3RpQmZTTGoxRWdDN1c3b25v?=
 =?utf-8?B?NTRLZ0FsVTExRjQ2T21acmNQTmRRNDlaVTN1dXpkbGlLNC93VVQ0Q3psdmR4?=
 =?utf-8?B?UTRFUU1HV2NYQzhOZDJLRGMraitYbjY2bEIvY2JWTExqZTFJcDlTMXA1bEpN?=
 =?utf-8?B?Rm1jMHVwUm9oRkJiaHVKY1FoMTNkWVNiNFNxQ1pXcUxVZWhaOWZ0dTBQdzN1?=
 =?utf-8?B?blRmV0RGaU8yeWNCZDlHNEs5ZEx0c1ZGK0pPb0hvN3pxUmF3N2E3Yms5aWdO?=
 =?utf-8?B?QXJud2ErM3VuU1BsUlQwU1VyQ2FKUG5mVjIwaC95Mkxta2lRK0ZYS3lBRVMr?=
 =?utf-8?B?cldxYVBzakJnVklUOXg2aTNzV2xWeWVnbSsrOXpuYXJoUjN2dWJ5UkZ0Yzk0?=
 =?utf-8?B?aEZWYzR0YVdXTTRLbmxnMmRMdGVZblFMbDgzQXJnUVlpTFZkUkhoVytNUXZ3?=
 =?utf-8?B?aW9wK2NCY1RYdWxDSmN5cDZoUCtMbVI0Qzc5ZTl6elpKQ2NlWDVkK1VRUmtC?=
 =?utf-8?B?NmJPb0MzcWl5WG9Ia3BjaHA4Z2pRRFFVQ2t6RVArVW9raW4vSnlQWmVjQnQx?=
 =?utf-8?B?MWVEZ1krcDBGUno5S2dkWGt1NitxZmhJMi9vUDJoNmU2WkZ2aXNRYnJPWUdx?=
 =?utf-8?B?MHQ5R20xODlwbnJxU3BIYWlGN1poRjdHMXZsYWhUMlZjRjhBUk84UjBuTUdm?=
 =?utf-8?B?SGJSUUFsM3R0NUlXUDVzTEwyczNVQUxWTXpXUjJ5M3NLaG9PUyticUYvNmVD?=
 =?utf-8?B?Ry83d09nbFp4eUV0M043cDlVNUg4L0J3SGNacVF5bXRRUGdFY3hEb1U2UVFx?=
 =?utf-8?B?eDZ3MmIybFBNUmVHZ05BcFQyWXljSUlUVTZBQUpITko2dmQraCtCcmQ5anVW?=
 =?utf-8?B?VVIxNkl1bHJDMUphOFRXUjJXU0RLNytTZkVMM3BjT3p3eDdSRHpyZUE0cTZE?=
 =?utf-8?B?Z2tXbVJldTNLb2xkUGR6czYvMEJQWDlNVm91UjBrNDRZZXpzbWJBbnBlTmN2?=
 =?utf-8?B?MVViZkhSTjlXYUNneFVMS0Q5ZnR3NUdEQi80dnM0SEsycmVWcDJ0aEMwM0xk?=
 =?utf-8?B?eFA1SWcwOSt1Zjg3dW9IY2JHcGtQRU10RmxHWlRHVmdCMEllTDZQbzZwc24v?=
 =?utf-8?B?dU5JTWJ2Tml3WnYxa29BbDgxVUw5TUNISzR1ZWpMeVk2OW1BM2ZScVBBdUt3?=
 =?utf-8?B?UnpTUXQ3WDFURlZjYlI3WHFiLzNiZWoyT1YyeXpUUUFkeDMyRmkxRkd3TWlO?=
 =?utf-8?B?TnVyQ0dDMkhuMTYxU242eFcyMmE5dnZvbGVLUHZTWmpHVHZpaTQwTGw2a2FZ?=
 =?utf-8?B?c0RQSG1ROEZid3RHNStUL0NHVG9pUmllODd4WkJuUGw2ZGIwbHBuanIveWhU?=
 =?utf-8?B?WHdCRnA1Nks4RWVON0JpTUUzS0w3blZJaFk3ZDRvcTY2YUJMaE9SVzZZKzE0?=
 =?utf-8?B?ZmR6M3ZLZ0owUkdQQTVRNlZvWWhkUzE5MnVLUGRjckhFRFJGaVVGeWZkSlhi?=
 =?utf-8?B?aDF0cEUzbDVWdUdnY1JMT2lGWklqSnU3V2UvaGFIcURSalh6d21qbEZESTlr?=
 =?utf-8?B?d2g2dEN3Q3lrVFNVWmpwU29VakN0ZFV2Tk05UVpRNzZaYzRBWkdDS0c4bEpI?=
 =?utf-8?B?SGhpRUtpb1dQWjBVbWlCRlc5RnFSUmM5OUU2V2VKZXkrbzlqSVJzdVNJYVA1?=
 =?utf-8?B?dytnNmY2c2drNzQzNE50WGphVytQa1YxeC9kWWtNUHRvWm04ejBXNnkvOW9p?=
 =?utf-8?B?YkF1bStUTzNEaEJuTkFRVENkdmNxTy9WL3JobUFHU3B1OGFFRzNFeDJlMU10?=
 =?utf-8?Q?GxWAkwEfCJ1N269p8WvQ/XXsp8Nk2uBcLoUP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0dyTE9EVlc2ay95OUhxYm1SVDloOFdpQkMrV09nS1FFc1FRYTcxaDJuYkR4?=
 =?utf-8?B?bUNVemdPY2hrZ1RxTDlURE1OUXJWNlZsSlJoN3lrWHM3VXBkNjgyQklGaHR5?=
 =?utf-8?B?V1hncmcvTmxLYllxNGVBaGZzTlhIZXZQS0ZmSWluVGlOUUZUOUJjcmlaQ3Iy?=
 =?utf-8?B?OC9qcjJtS0F3cUh2NlJlQVV6MFp5QmI0QWI5N2w5YTF2MVRRL1lnTGloSFV3?=
 =?utf-8?B?cXdQbjJqOU9MTnVEb1FhQjhVbEYvOGJXR2pscFpkS2ZHMHp2OHdDQkpac0k0?=
 =?utf-8?B?SU1IZUdTK0dtMnQzWkVESFpmTk1maEpsNzIzNklacVl5VXo2ekQvdUNIditK?=
 =?utf-8?B?UlpCYjZDSURWM0pRQ0M5YWZJbUtoVVZWeUpPSUZGWk8yQmhtRlN0OVBYTnNV?=
 =?utf-8?B?d2hJZ0lqVllGalJNa3FKakdhNHJnRlNqalBjNjh2ell1cFhSczVXNmUrc0ZB?=
 =?utf-8?B?UTE0VEdyR0tLNFhkNUN1dzNRQ3VlNTUrdVdjemNMVEV4dlIwMjlveTM1ZDMz?=
 =?utf-8?B?cWhRTk5vcDlOcVg1SnUrQTFGUUk4bjFlNHdiWEx6SEh4SW93cjdOblFjanJh?=
 =?utf-8?B?R2ZsZFg5VnNUamw0UUYySldmcytUdnhLT3pQM0ZTL01iWkZsdUxibDlrZ292?=
 =?utf-8?B?UDJmc1hyZmtXeXYvOXJDNUtrY2w3VlJJWFNmcGRkN2NKL28vTy8zdkJ3SGVK?=
 =?utf-8?B?TEhIZ0F2NHFzWTl6WGQ4R3FoMnBpbWN5K0hGdDg5S3NPeUNTQzAzbXVyY29R?=
 =?utf-8?B?WCtkVTZpRXJma1Zvc1ZIcUR2RXQ5TVdrTnp6bXRZZmhDNDcxaUdVMEZ3dDNM?=
 =?utf-8?B?ZFFEQ3lLQlM0dmY2SGlURXlzNWRGcW9DcCs5NCtZVHR6TmdDUWVCWUQ4Mm1B?=
 =?utf-8?B?TG5KcTh5TDhHZVN0TWxTZHpPVWcxMkxreFRMaXNMTHVQWE10TGs5czRGeEpv?=
 =?utf-8?B?N2lOQ3ZYQ1NRaUhNNzd5dHVlTldKMnNCNUNRbXRoeSs3bUZDSURyZzZSMERK?=
 =?utf-8?B?SDRXeVRvUmJqaXhMWlJxV01EWGtFRm1tSVhGT2Jzb2VRT2xDdWU1UmxpWWJH?=
 =?utf-8?B?SDhqTEZ3VnhIMDMvSmg0d2h3VmdVZWVtbW5ldS82TkJzRnQrcHk3QUxNdm9m?=
 =?utf-8?B?S3UwNkRwM01yUjFkaHpVaDZhS1U3bHBMdm8xYmtOendoUCswVFZrTTJWd245?=
 =?utf-8?B?Ty82RDNKY0w2MlJuVllCUldQUnRTRWpSUFlhVXBkdUdWOHlaNlh0UjAyQi9h?=
 =?utf-8?B?WTBOb2VSbHg3QTVONEZFdktMMm9CMXQwdjdZVDgyU3pIaHFTVm0xakppMG84?=
 =?utf-8?B?cHIyMXYwQXZ6cDZLeGhnWWlHVkdsQ2pkcUl4dDB6bFVmREY5RkR5KzVpK1cw?=
 =?utf-8?B?c3ZvUW9YYmx2dmh3ZWhIbk04NGQzZ0lvR3kyV2VBNURZOFNzT2JzTGJlM09m?=
 =?utf-8?B?OVlvS0hTbVpPSDdHejIvMzd1M0VtUVZjRDRsQm9tQWdoRDlnazRQbWUxM3Zj?=
 =?utf-8?B?cGZjTHQ2cXlEcktjWURGVUNWRjNxdEplTndod2ZrQ2NUdmhRa0hQeEc0Tk5F?=
 =?utf-8?B?QW1rSEx1cmFESk9OeEk1akEzUWVuLzNqQU16N2E1SXFSTjdXVDlwOXB0MjM4?=
 =?utf-8?B?K1RPSjdQTzNnVVZqcVExR2NuVE9oQ2ZEL0lwVmpkVXZGZ2ZMZ3F1NXMwZzNG?=
 =?utf-8?B?MVRKS2FsOHA3Y3d4RmE0MXNyRWR2c2hIRVlYVnVtdGx6NGZ4UXoyMVpLUE5x?=
 =?utf-8?B?WEpoQzQvdTZDYXdNUHIrNnFCWUVlUjJKbERQTFF6Y0JzT2szaTFYbVE1dGpJ?=
 =?utf-8?B?ZFYreVBtTzJzUUZtYVRFWUg2RjY4RUhVaWFBNDMyeGU3bW50RmJ3MkpxV1h5?=
 =?utf-8?B?cTJrTWpXWHNWZ3daYndsYWhRT2pWVEhwRitQMjVBSnZTVkNQZG9qek8vMllu?=
 =?utf-8?B?MjFtWmUzRDFpNXMybytHQnluQkpRS0lzVG96RG95VHN5OTlBcUpwQmdOOFk2?=
 =?utf-8?B?cTgxTEljRXVrUUMzUHR1Z2h5d2FVZDhVek9OMTBOU1NLUmY1bDFzUlByck4y?=
 =?utf-8?B?emoyaDBRY1dGTHFkYW11Z2tVTFN2QWV1M3E3bXM2SDVGNnNaOXlJSmJUN3kr?=
 =?utf-8?B?ak8vU2s5b3dQbCtVeVF3cGsxTWNZOGlMVFR4QWxmMm1jZFdWZXUxRFE3TnFJ?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0511b-4b6c-4127-1002-08ddebd0ff8b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:35:03.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcVETcvJHAvZdppQSCGX/AdfO4Yn84i8pQIOJTNN2rsE6BPvVd53cq7vQ7pmZwQwxMVoP3O+ZPpPErSpf7E86wYQI+l6Ptr+1bnd+BSPAvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7792
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX0LhhH9gCzkoP
 410dR/MhKE8k3LAiB43XgdfDMKA98iJ2qNQCp5OxKC1AW32zaZcjFPxcS6JfCYsHU4UxmuApype
 U1pgRSLVkVMj8jk39wtnJMNYgpwVmYxYNLgx6EHDtgR394OJ35/LlJ2wcGsGuFViOQ4GNfKmmA1
 b/hR10GF701JIsNlF4psJXLLFrnfDiYFl6zB+lYMOgXGwiGuVM4mm0zudlHo02gv5iA0u2HI/og
 AdPyiYilAkgOHMeQXsHGy1ldCKkOLNtAgTP41TNdncUfKTnNSW1Sy+NDoTBkSIJPBT21A2Dd1wh
 x4Nzl29pHzJnN0TZFhDQuc1T5aD5lxRDn/mwpUc9GE2oy0qhb2b1rq1zKd9AXU=
X-Proofpoint-GUID: 81uyKsuV8QYvDif5leRIFJK_f7pTXf5R
X-Proofpoint-ORIG-GUID: 81uyKsuV8QYvDif5leRIFJK_f7pTXf5R
X-Authority-Analysis: v=2.4 cv=faOty1QF c=1 sm=1 tr=0 ts=68b9bfba cx=c_pps
 a=i53RzH+K57V33sAv+zykgw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=p0WdMEafAAAA:8 a=NzbjGtntMflMrEhWyS0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Hi,

I'd like to draw the attention of the scheduler maintainers to a number 
of kernel bugzilla reports submitted by a colleague a couple of weeks ago:

6.12.18:
https://bugzilla.kernel.org/show_bug.cgi?id=220447
https://bugzilla.kernel.org/show_bug.cgi?id=220448

v6.16-rt3
https://bugzilla.kernel.org/show_bug.cgi?id=220450
https://bugzilla.kernel.org/show_bug.cgi?id=220449

There seems to be something wrong with either the logic or the locking. 
In one case this resulted in a NULL pointer dereference in 
pick_next_entity().  In another case it resulted in 
BUG_ON(!rq->nr_running) in dequeue_top_rt_rq() and 
SCHED_WARN_ON(!se->on_rq) in update_entity_lag().

My colleague suggests that the NULL pointer dereference may be due to 
pick_eevdf() returning NULL in pick_next_entity().

I did some digging and found that 
https://gitlab.com/linux-kernel/stable/-/commit/86b37810 would not have 
been included in 6.12.18, but the equivalent fix should have been in the 
6.16 load.

We haven't yet bottomed out the root cause.

Any suggestions or assistance would be appreciated.

Thanks,
Chris


