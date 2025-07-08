Return-Path: <linux-kernel+bounces-722033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52623AFD2BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F8E176CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71C2E5B1A;
	Tue,  8 Jul 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ipetronik.com header.i=@ipetronik.com header.b="bqmWLkrW"
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022122.outbound.protection.outlook.com [40.107.149.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3402E54BD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993172; cv=fail; b=Oi3Q3FQGQWIFkH87Sf5JPNkbEO5W61oHTghrVJhWOg+ldi7CTXhskB9ZljZS/F87PqHwopZQGTMu5tWTk6rHRnb2Snr3rBW/JzBGwvdMEw889QzuKHU1Xc5QNvkcCXSsneHDKlCFz/BIIGWQvOS34lS7s5WTfFuhTMQ4ZSHgd2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993172; c=relaxed/simple;
	bh=WE86A1aPfPtY0EcN4ubpLygXlAeP1J+dpcPPZtdGl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=m/+b9bqV3fKjwpop5mC1vYPgZsWhbYhQKjTSRQUEqCOK9UTGIbbHArRSw2kruCWbGi8qIxe16+bEMFr2LHfZ/tBqmxmVGd0jcGANEAfA08gqdJovJNRgfincGkLD/EfmroRdqoRB3UJhzFoBfn8pMyqOfIZey7bA8c0Kro4xNLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipetronik.com; spf=pass smtp.mailfrom=ipetronik.com; dkim=pass (2048-bit key) header.d=ipetronik.com header.i=@ipetronik.com header.b=bqmWLkrW; arc=fail smtp.client-ip=40.107.149.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipetronik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipetronik.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cye/Rd+QWhrkEwLN1AG9WTcZ2M+mXRlUVfwHqj7HsxQ9WlKYYdjJP4OMzMH5cznZiC4NNnA651UHq4lhHZ0ubjHNy58pudq9z+Z+I1UGXrhozITMFK2RSrsQfyalo1lUhuYkC3LBWdrv9+3VCGyrbZwr91bU331pautXVmFSV7TOwf40kyOBhr+Q6UmesUxdm4b7Bg2Mo4cMo7yvppXeM6E6zAAr3oPIMf70xpoVrBlou0kkniZ51qYbu9Al+p8s2J7GJd694SW3i9dEtagEUzb1s0FYO5M2GtNXk8I5kPLqoPzFN3M4b2aKzWz+wzF9E0I/VCseXICmVAWezRHi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y3XcZ/pVPJtAAWzyXb7vmWgf+3IBzNNeJ/9pc8C0es=;
 b=RwedRXT07zkb/OYFAToGZgBK9CHuuobLtEGmcaWw2nJwOzjyzpYkwtQs/F41dQjqjlpf4Dyt6xu9QfJyXn78z5piU/443bNOBGZJEaaw2kVnrhSNAkMyLGoB36rlY2BwN4xMBaKHcQG6lD0s5H144YXhITKLT02hm/zouCXMdAXWBorSb/gsBfoDLdB8mGy0nQqd4bRh9jOZib1FM6148ISCgDCfVVemvWLJvE05u+smJ5rTtg5hwNUT0hiHsa8hRouuQiyATD1ao5sUFnLOgVmmAND5l3DLL5mxQ4mDKYVpqDdM+PG5uzuZL0jd5JeEoLsCzpbDRVHsDLH6fM03Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ipetronik.com; dmarc=pass action=none
 header.from=ipetronik.com; dkim=pass header.d=ipetronik.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y3XcZ/pVPJtAAWzyXb7vmWgf+3IBzNNeJ/9pc8C0es=;
 b=bqmWLkrWsAK7RTwj5TLDKz+Uw4Q1M26+b4bvR9C952UV7Ca9+bJ48Y1ND/Em5HcKUBXh6RsNb1kLZJhjBpctv9NHJ9FhfN+jwP/L/DURr4JS1zN52Y0P0qYvS4+8vga08RvH0adeawtQJrv5EZbIR+my5024igF5Qpaz1dIXvqR+d3yw4k3QoJH2pCii9Gwrz2RhvytIe/NPVlxgx1uJjWr8Hjys/+Ui8YJft54Q+9K754L87KuctKDDFAXKiqhhd3VZKM3yZ2EKl5ioLsvBCxILwNvkAZ3KMW+2FFlrdLQJI4vXg0FATZqNv2SUapLIBkCjCJdIlQJIS1Lcj/iJ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::70)
 by BEZP281MB3122.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:75::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 16:46:03 +0000
Received: from FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4f5d:a9f5:8b45:be42]) by FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4f5d:a9f5:8b45:be42%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 16:46:03 +0000
Date: Tue, 8 Jul 2025 18:46:01 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus.bloechl@ipetronik.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] timekeeping: Always initialize use_nsecs when querying time
 from phc drivers
Message-ID: <txyrr26hxe3xpq3ebqb5ewkgvhvp7xalotaouwludjtjifnah2@7tmgczln4aoo>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::70)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR2PPF9A8CE9F7D:EE_|BEZP281MB3122:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e813c2-a8fd-4d9a-001c-08ddbe3eed4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2NlS2lJejAwaTd4YmgyN2l4cG1sUmxJVWM5SDF3bDhEVDZjRHJ1a3c2QWcw?=
 =?utf-8?B?eGRScjlNeXhqb01aTlZzK2R5dXFUUnhZamZ0R2hCc3dsNDEzS1lKZ1Z6T3N0?=
 =?utf-8?B?TEd1MW8vOVVpYWNHUjJ6emowdFZvODQ3ZU9xWHlteGVyalRrWWVUcElaZE5w?=
 =?utf-8?B?dW8yQVh5TUJsNWtDQnFvWDRVdHZjT09LVGMzQmE0M29NdlNoVERTdEZwR3BM?=
 =?utf-8?B?YlBRMTlQTjcyMzFZMXJhd0NYbkprdjR1ZFpHNVlNczUzNkRHMW93K2JncWhJ?=
 =?utf-8?B?Vm1mRUxmeDczL3lMeWdMMHhFcmZCSVc2a3JTdWEvMGwvNDE1OVdPbzl3cW41?=
 =?utf-8?B?cW1INXh2dmMrak5wNGhzTkQ3QmwxTzlJdjJRVEdiQnpLTGVaRCtGMTJmZnJC?=
 =?utf-8?B?b2JGN2dlcEFRK2N4QUd5VEpKZW1URFN6b2w0T3k5UlZWNUtoQ1NqWUZKb21E?=
 =?utf-8?B?MGRGc2FndHIrdVYvek9IS3pDdkxkWHhGZmcyNlorZncrUHIvKzlJd0xDNnBI?=
 =?utf-8?B?bkx2MHVZOGhkZ3BHRFN6b0hiTmhzdTA4NWJKZnNPMFNBTDg0R0hvZDNsZjI5?=
 =?utf-8?B?T0NqYVp0M09rMkxteFF3bWdiSUd3SVJuSUREVWZyL1BNZnA4bTBkNWlkbTdX?=
 =?utf-8?B?MjMzRjE1MGhRTk1FUytLYTQ5ZXR0eFhJSWthOWpTYVBpSUQvVEw1MlhVL29W?=
 =?utf-8?B?OFlwMzF2M0luYzZkNUpvVytEY2Z0Y2tSeXhPSGFoN09sWXd3aFRVRlFLYlJO?=
 =?utf-8?B?NVc5OGEwNDB6V2wwM2RyWUxYVVRKdExvT2xnTzBscU5SN1FjeTRDSFNaRGN1?=
 =?utf-8?B?QjU5WlZZRU1xYkN4MTcvKzk1VEtHM0tEYlJHRlVIaFdMU2pPWDlBTmFvWWtH?=
 =?utf-8?B?anVQeFEvSlZtZGxCdjZQSVB4OE5GT2NVQmJ1WlJYNGZrMXk3ZmlXV05RbFpQ?=
 =?utf-8?B?N2o4eUU4cFoveGdTNjRGcndQTmxRQVFGek41M1N0NkNZZlZlbVRpTUU2NTNz?=
 =?utf-8?B?RFk2elFhMk91d010N2RlR0hPQ2tRTitvclMvM2FHWGtFNFNzWlVuUCs5Y1Ja?=
 =?utf-8?B?aUNuUXhqd0h2SUovY0xYMzdrNkV3clR3UEFjRFduRnBRZy9BYWM1V3Flc2Ew?=
 =?utf-8?B?VEhxUExVa1BpVnhZN1NSVGVqVnNpR0V5cGsxUGhNSjIvL2xLUFRTTTE5MnV3?=
 =?utf-8?B?SVVwMmo0UUZpeVZXUFNDenlLNTM5RnVEeFg0aldBN3hSNUNsOXBnTTJDaGNr?=
 =?utf-8?B?NStZaDhvc1FHdDR6bTdRTy94L0ZVMUg5YTRwNG1HVVkzNUVmK0t6N0NEaGJZ?=
 =?utf-8?B?c2lMMGpVYTA5RXBlWTlOZ1Avby9ZRXgyQXdYWHJZUS9oTTQvM3JyS1B1c1Bi?=
 =?utf-8?B?ZWY3aEFNUzhDa0Zxd2FKVStncVBnbFRsc0p1REdGN1N3THk5WXh5NVVpRW9K?=
 =?utf-8?B?amhCSkxHVGNIamRET0ExWXZsUlVHQktOdk45TzhUbnVFL3gvWG5QMWZGSnBC?=
 =?utf-8?B?ellmczR1QVk3bWMrTENlZjRtVXBqSXF0TXAwVllkbk5HRVNtY3owbSt5azZB?=
 =?utf-8?B?N1BTTHYyVUVrWkE4akp0bVM5UEhiajkvTkpxVHJlWTYzNVBoWEZyK3V6djVW?=
 =?utf-8?B?ay9pNTdtMnNFN2E2cTFDTkNtR0RWRG9udDdWcXVYc0h5c3NaTHo2aUdjUWdZ?=
 =?utf-8?B?enVaM3lmWjhoZ3JaRXc3cHVOVklzTkw4ZGJKcXNBbXZzcGgzdjkzcmdvc3FU?=
 =?utf-8?B?d2F1RC9IVmtSaEVGSDhPRTRvb2xnWFB6ZlQwUzBud1dxcWNodTJaUXZaNnI4?=
 =?utf-8?B?N3BoKzdZeGpoS3lqL3htUnY0aHlCbW9kODVkbHY2ckcyWGJpZFBNRWd4eSta?=
 =?utf-8?B?cG4ybm51bnhjcUpZNGk4QmZVZHBmZFdtNy9TOUxyYnJITVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTBSbTZPUEpocUtvN01zNzFHd2l4Y3VVcFhqK1QvaWNsNzJ0QTFSZ3RsdytU?=
 =?utf-8?B?UGRWVHQ1Y3JvOWpYc09zbUIxcXNSeSs1TFZhZXBzRUdSanVOS2c1MWo1ZFEz?=
 =?utf-8?B?dXQxUW5iREpBSlVHZWI0bzJjczQ0MWhYZ2VUYWRMTnVGQzZSbURlWTExNEJo?=
 =?utf-8?B?UE9uQjVhSkZoWWVBektvRWhic3l5TitXRzA2dUtNb1JiNElEVVUyb3NCeHBT?=
 =?utf-8?B?RmMzZWdwdkpQRFVYV20xUjVuN0ZjTHROenVwYlF3OUxCb0JZOSsvb2xuby8z?=
 =?utf-8?B?UUs5U253N1k4eGtoNXRJNG9hSk1tOFdqZVlwUGdjNm5OQkxrS1JlaGQ5NGpG?=
 =?utf-8?B?LzErejV5VDZCU2JCdjgybjZpRkt3V1hjNmhlR0d1UVBZRlRBZ1M4L2N3OVZo?=
 =?utf-8?B?YkR6SnJneElEbVZTSjZKUTlHRVZtZnpQVlJyMVZZKzJoNXI2bDRTa1pxdEl2?=
 =?utf-8?B?L0pNbmt4NXBtZnZZS3NQUjU0MWdNY3dTOXBpcXhtUUFqMTNYcWR0aVZkVXFu?=
 =?utf-8?B?NDFJazhydzk2TEl5Qy8zZmh2K0wyYW03clhlOVFnVk1uR2NrOEliOVpxSUps?=
 =?utf-8?B?TUI3OERCVngvVmhvN25KVW8xS3ZGRlFydVR1cy9BRnVvMTZ5QTVRRWpmU0Vv?=
 =?utf-8?B?S29Oa1l6UGtnUnhDSTlEYXlvK3FSZWpKVUZLQnR0NFRZV3FkT293VXJlc1lo?=
 =?utf-8?B?RDRST2dSVFd6akNUWEdyQWh0UGxVWm9WMm4vUTc4Z01oRzJpNWwzZzIvR2xG?=
 =?utf-8?B?MjhTaStZMjdpU0tPc3ovVFptL3cvOGpOa0ZaVldidHlmbTBMK3FIRzdudmIy?=
 =?utf-8?B?bndUYmFFemw2RFNndWlHUllxY1lyWks5YlhaemdrVjk1NFZhcjhKbFVrN0t6?=
 =?utf-8?B?OEUwNURvMzdhamd6VDJBcjRtQ09VU2VWMjhzditvb20yNWMvWmswUmY3RW1r?=
 =?utf-8?B?U3hvN2FFN3JFeFNJYTZlazEvdEhHSUljR1pnTXNJemVFUnNaOUpuZ3VLNkNB?=
 =?utf-8?B?blZ3VjBrVXI3QkVNZ3IxUnVHaVNiUFZSUThDS2ZiaTRYWWdUakhKc294U0hw?=
 =?utf-8?B?M0hBcDQ5WUI0OUpBanMrQ2NlZ0xzZzczQlF0WEhtRjZueUlwVkNpSmZHRE1X?=
 =?utf-8?B?YUxaUXFPS21TclFUOW9acVdWQ0M3dllBWVFONTRIbHhLZ3RCaTN0bkJGcTdU?=
 =?utf-8?B?V05GeTBEa2RSVGVYdDlrY0NmanJuV1ppamlncHFDR3IzNmRzaTBGb2NiUkFq?=
 =?utf-8?B?RzBNcHNSbzBTc0RlTzJoeGRFbDBHR0hPT0pUbEdLQXBxZUx4ZEY0c0xwMVVE?=
 =?utf-8?B?cHRRcTFSNUJhM1JKQUl3ZHZuaXhMVi9reDVkQ2JLZXlVQW5rWi9iVG1ySFM0?=
 =?utf-8?B?M0syZ0w2b0VqRVQvV1d2QXpHRXdueWxvTXd1Qk0vV0JwM0YxT1ZsWmE3UEM2?=
 =?utf-8?B?RXZ2anp6NW9BeGU1LzRncTBnazA4ZDRGd2NkMGV5amVmcGtWenUxTUlRYXJ5?=
 =?utf-8?B?SGVJdGdYWnBBUzFRZGE1dENDSVhKRGRuSm9aeXQ3MG96bFFxVHJCb0VkZElI?=
 =?utf-8?B?OExNZVVIRGJpVDlxZ21tQzhYc1ZVK3FiVElwbXNOSHBVdHJsTzBaWmZFMzJk?=
 =?utf-8?B?d0YwYjN4OXhteHV4VEd5Y0pGcXNUbWMrdk5uYm13UUc0dW1iRjRic3RWRHpP?=
 =?utf-8?B?R1VnbXczOGFkZ2FFNHNHb0dGb010WXZDNGZKQjRCVmVKTkZUY1hJMFM1ME5l?=
 =?utf-8?B?L0pkUVpkb2xoV3YyWkFKb0dKdlpKazBueDBqVXRLa0JyUHhjVXNXcGFhblZS?=
 =?utf-8?B?eU41OHpTNll3OXlDdWVBY2xGeEY5UVErVFR3SnR2K0xCWDN6MlQ2ZUphT1Ir?=
 =?utf-8?B?M3lPRVIzZ0RjVXZhbzh0STJ2dEVTZ3FxdmI3ZFV1dWhCQ2haTGxZa1dCVUxJ?=
 =?utf-8?B?Zzhabk5Zeit5VGRHMWVrSlZ2RUErZGpiOG0zSXZYTlFkdWNvUytvOUFsbHFw?=
 =?utf-8?B?Z3doOTh2MlgrYy96VkVZaXBSdUEvQ3N0UDNreVVFbFY5VStHZ1RZMkJleWNL?=
 =?utf-8?B?LzFWUUc5WWtyTGQybHpQeGRwV0VIQjVnTFpDb0lvSDh4aHpaK2N2NkZZd21h?=
 =?utf-8?B?cnphWVpXa3FST2MwZmY1N2dTM0xWV2xUbVVRY1V0aXlaQXBJTS9mVkpUQ1Zx?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e813c2-a8fd-4d9a-001c-08ddbe3eed4a
X-MS-Exchange-CrossTenant-AuthSource: FR2PPF9A8CE9F7D.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 16:46:03.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AK1W3A8wpBLZyiBqbBMfNU2c52lBz0Se1u9K43GrkJAfr2+bDGHZy9h/zvAC/j1fM/A5Px8lwxvJ2YyYnGVF2eulJmn9z7rQ4Fxe1LjWrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3122

Most drivers only populate the fields cycles and cs_id in their
get_time_fn() callback for get_device_system_crosststamp() unless
they explicitly provide nanosecond values.
When this new use_nsecs field was added and used most drivers did not
care.
Clock sources other than CSID_GENERIC could then get converted in
convert_base_to_cs() based on an uninitialized use_nsecs which usually
results in -EINVAL during the following range check.

Fixes: 6b2e29977518 ("timekeeping: Provide infrastructure for converting to=
/from a base clock")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Bl=C3=B6chl <markus.bloechl@ipetronik.com>
---

Notes:
    We observed this in the e1000e driver but at least stmmac and
    ptp_kvm also seem affected by this.
    ice was recently fixed by a5a441ae283d ("ice/ptp: fix crosstimestamp re=
porting").


 kernel/time/timekeeping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a009c91f7b05..be0da807329f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1269,6 +1269,8 @@ int get_device_system_crosststamp(int (*get_time_fn)

        do {
                seq =3D read_seqcount_begin(&tk_core.seq);
+               system_counterval.use_nsecs =3D false;
+
                /*
                 * Try to synchronously capture device time and a system
                 * counter value calling back into the device driver

base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
--
2.50.0


Impressum/Imprint: https://www.ipetronik.com/impressum

