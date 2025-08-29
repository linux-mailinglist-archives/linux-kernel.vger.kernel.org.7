Return-Path: <linux-kernel+bounces-792317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5379B3C29E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E5B56695A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75D192D68;
	Fri, 29 Aug 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lz/2v5kW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dP0iZwU/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80716188734
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756493131; cv=fail; b=FFAi02Clg4DztvF+Dr7tMAIt6lKzqohmJIMV4qpCidYRb8n+QdlnK9VY0R4oziaUVk8kxv9NucZQEudsKBl4yYJ2YhjghxWOKnKOaLr/oW24BfG+CdgfKyMLk2nMP47o1mwgfw6XkMJEQpSFKUO1O4CNhXd3kihGPmDPjwZWcL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756493131; c=relaxed/simple;
	bh=z6d52q6UUIVF51ZZAEctJNT0w7+dzPIF8j7QgP0Ahq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LW1BzAKOWfrVgUILZgQGX44sO8VNXIF0ucZuJy0+Ghj+kTHtvaA/geJRFJxvpHCuNwpVKWIQcMb3P7e2WN7GplVWkPOgVHaMdreLcvrRRgQenGIW/+2rgoTAS7RG4TOwYyV0dwZZ0mOqVBKwTwGXtjV1a4gzxOuMsuoaZQlENu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lz/2v5kW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dP0iZwU/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGg7wb010079;
	Fri, 29 Aug 2025 18:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z6d52q6UUIVF51ZZAEctJNT0w7+dzPIF8j7QgP0Ahq4=; b=
	lz/2v5kWWSTCj88exQrPF+p1FXnsz0vSaHZ0yLPCwE5lk/kz+IlpMrNl/52vfOj5
	Q7HZGGvTL4zkpAzjUaVOogJGOD3SC3phDWvE3hX+14bIpPSrZsSAYEGVE3TFNHOj
	GJlGxk+SgUUqVCRrMfncAb+WsHDhHjP7MCVRTPbpaypnhZ4lEJUagYMj64YJWLKj
	uGxOCdNd/umDtzPZzySeC9lKUcM2pSWu23Ez7xf3LFeiucmUCYCpt5i9vuMw/MBX
	gKE+HE1CIQntz18JmXVq91GpN9oNJr46kbo4zAWzV9bc2C3mMlltJn1KOKmOgrko
	xcVm/bdbhB+CKblEypJEnw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twhqwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 18:44:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGutIm005044;
	Fri, 29 Aug 2025 18:44:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8dqg91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 18:44:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkCKUNaYLxMhKZQkcck45xTEyqOrVwGt6lYyJP88QP49WTR0B7HacBp8VzaOUNGKFSgJh1GvUkXWsMqGCglqclJnHci4KqpNUVcH6kvTkM5LvFci4M7Kpk+lteX9iEud6nRdsFx+pWqWoGH8XDdH+EfJut2khxPdXccLEi8wqShdzG2jcHkF95puNHoXLn4k4XwEoM2Pl7nVh0UoNEsqsv76irWZ/ZAxZtGCnOg1WIUKX+GRJdjveI2xkNM/B6ED5dOThuTLhlfX2LLXv3JRnf4qP0pWmvHZVl3hzhlYaEhmlWtwM67qlcy6RWvOWzh99aS5NWHDlu4BYJ1MuEjDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6d52q6UUIVF51ZZAEctJNT0w7+dzPIF8j7QgP0Ahq4=;
 b=yKD2SFT2uALDSvg2O4VfpZeM036c1OwirI8Vvvy28yCu01nFrqGYwO2LseIolErZ+2FQcXFa+X+9l8OX5/sGvYaTRkZqm+8Vf4YLuS5oO+vOE48RI+Q2LGURnAcU76IkIeExZvdQupgDxWmzkwNRaxJhheKi4iFlQL+VThUQ1n/Q7eJvgo+U2gLF2hXCVFhHenAku9ixW1KqlK/759QYTb7oFqffFJwNqyQyoDPlZfJixe0xlPL+myuRehmS2feMQxY489y8dNb4L1ZMyglBBUokZaS3TVQUhhQ004WKVh17iQSRJHod5qpWSKEER3PI7hQLGc98XT9DB13Db9knoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6d52q6UUIVF51ZZAEctJNT0w7+dzPIF8j7QgP0Ahq4=;
 b=dP0iZwU/yhip4hc52m4O4k8BVXSohkI+QDZv/fSVMdHDJxGU+piY+mjDA9ZyiRPC8Y37q5NJZDb1KxXxi0n//dt4fVlndplHaxEcIesgAiYCcGitpFEz6/g3LZEZZqc7rUWrhDDwhC3JfoQwom4Zm+U+UXPt1RDr6q1C7ousIu4=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DM3PPFE23691A9C.namprd10.prod.outlook.com (2603:10b6:f:fc00::c50) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 18:44:51 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 18:44:51 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Florian Weimer <fweimer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng
	<boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>,
        Sean Christopherson
	<seanjc@google.com>,
        Samuel Thibault <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
Thread-Topic: BUG: rseq selftests and librseq vs. glibc fail
Thread-Index: AQHcGRT6xxcx/EnjgESs64c8pjMFrQ==
Date: Fri, 29 Aug 2025 18:44:51 +0000
Message-ID: <F9DBABAD-ABF0-49AA-9A38-BD4D2BE78B94@oracle.com>
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx>
In-Reply-To: <87cy8sy2n6.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DM3PPFE23691A9C:EE_
x-ms-office365-filtering-correlation-id: 5d3b38f7-d363-4e61-0bc7-08dde72c236a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFYxZG81VnRUNHBzZFlOMVFiQkUwdFM3MzFqNmwrTnNhekc2Y3lTYjJaeURO?=
 =?utf-8?B?enJCeVFKQnBrTmcvSC9mQ0gzK2RRMW1UVUpYN1hOOTlLTHNidlBROE15WW1R?=
 =?utf-8?B?NGx2N0JVYVphbDVuV1cwUTRHbEpaenZtd3crWHpCYzMvWUNqd3dIMGl6QWJh?=
 =?utf-8?B?Mk55VWFhNGRGcGF3cmRuUXE0VTc4RTQ1SG1FN2ZhWGpVNS8wZlBocFJEZzd2?=
 =?utf-8?B?Tm0yT2lWNjlIYlRVVFJ6UDltNVMvbjhPMUNJU3JRbDBoTGt0L09YUUNyUFNY?=
 =?utf-8?B?aWdnYVBweHd1TFRkNGNmOXJOZnJ2NFdZTGNkc0RVU1pZcGltT1N0SGtpWXVC?=
 =?utf-8?B?S3d6NHFHY1RKYUx2UTdrK0hoVEtHTms2aTlrdDFRRWlQUW5EY2hHLzJMbkhK?=
 =?utf-8?B?SDlGL0xHZFVDc3JRdlphbkNtd2puOXFtYVlPQmJPaUozSGh5U0hSNWYyQWVQ?=
 =?utf-8?B?bStkODI2R0ZzV2N0TlpNa0dINTdQQUlKT0wyTmxEN0w0VVFmbjZaazJVSzMw?=
 =?utf-8?B?ZUhyT3JHV3krNWltanA4VXVRQmQrWVVYdCtORlNtRUJyWkRyajloN3p1SGs4?=
 =?utf-8?B?VGhxSENWSG1FWUNWNEtnclFNSEg4WWFObEZPeXVjZHhNd1ZUSDB0OEw3MWpX?=
 =?utf-8?B?WUJuSXRuUWFONlk2TGlxTWZBUmYvKzMwZ0lNaWppWmV0L1FmdWYxTXkwREhm?=
 =?utf-8?B?VGxmd01HSXFGWmFFWDA4Ry9GTVBiMi92NU40M2FlSGNjd3Q0eVVLK0UzYUp3?=
 =?utf-8?B?VHpGbHQrOURQanl2U29iMGo2SGYxd0hLRmhFMDd2QVVxeXd4eDBOQi83S3Vq?=
 =?utf-8?B?dHhTOFBJVmFsVU5ibjlUNVQxUnU5NjFDWktvbHd1TzFMcTZBZGJFWE1XakFl?=
 =?utf-8?B?ditJU1JWWlAvT0VpMzJ3SFRhVW9samV1VThuTHZZMFV2ck8zQ3RtcmxzTlBp?=
 =?utf-8?B?Ri9VUUF3ZzYrUzRWOTduZVgxcjhXZlFrR0JTdVVzZDFuT2cxRXdqRFhhd1lK?=
 =?utf-8?B?N2owMG5SRDFlOGwwUnBjV1RhYU5UOXAyc1grTTFZRnpZenFzeWJSMXlPcjZW?=
 =?utf-8?B?aDRJOXkvTHRhdUNncUJtTGI2aE5TQjBSVTBXbU1Vbkc1TGt3RUtCNFdQWWtV?=
 =?utf-8?B?OHRtcWFnZThPYTVNbVJ1SWRBRUR2Rzc0eHNiRjNvV3dZSWFCaVhWeTl4R243?=
 =?utf-8?B?amJMUjFPWElBdnMyYTVmU2NzRWwwUGVDSFByUXBwT09DQmpVVEp2aUhFZzA4?=
 =?utf-8?B?Z2RuK0MzanY0RmFCTkhqaExjOW5SMTYzY1FqNjl3MlUwNFcyUUxHTkJJaXZY?=
 =?utf-8?B?N05JNUIrc2tJd2Rid01yU285VjVDTUZtTVZBVHdoS2FHM0hMMitIN29mZmk1?=
 =?utf-8?B?T3hGZDJQUXFQUUFrNVIxVVpmaE1vQUs5SlZiemlOMmRiUlM5bWsrOGc2eTBK?=
 =?utf-8?B?ZWJZVCtNTTM5K2pPRFBGbzMwVi85SlJocWtTd0ZreDR1SVNlTXlwc2xNbm5N?=
 =?utf-8?B?bDFQSHp3TGdPaFdNbG4wRGJJVzdkRC96Mmdmb0xYN01VVzFlTEVLUUpQczN3?=
 =?utf-8?B?ZFhQK1pDUUpzaXZVNnM2blhjWEZqUzN0RHQ3UklyU2pxWUUvTjdTZ0NUMkxw?=
 =?utf-8?B?dUZtRVE3bmZNbWNzZ2xJZVA5QVYrQzJ2d2I3NVcxNnVSY3hzTGY0OTY1Zksr?=
 =?utf-8?B?R00xVXdJc2dKbDVIV1JOaHk1S1l1aWN1TXBzSUNtUFRCeDVkWWprRTVhbkJw?=
 =?utf-8?B?T0FOZndHWUlVRk1tT0JrbkZNVW1uTGhhVERBRjJWR0ttYmg3eEkzUzc2Z2Nl?=
 =?utf-8?B?YXJ4dGlET1F1UjBYeHQzbWg5L1Ztem13dHgyY2pHRkRDejh4TFk0V1I2bUha?=
 =?utf-8?B?THRpYm1QNFduNHFTYUJuN2twVHBIQzJTemk2dGpKazc0ZVhGamsvelJhWjU4?=
 =?utf-8?B?b0JUK2NuNGY2VzRLTkozN1hXei9XUVErbzZ5TlpqYWdKcWlHMjkrbzBuOG94?=
 =?utf-8?B?NVNkdzhSTmZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkxrSDNvV1JyUkdVY3JTVENweFdCUmxBZ2lpam16S0ZVbmJhMERKeUN4YzZr?=
 =?utf-8?B?b0VVMGU0a3MwemNIaEVqUmxtYTh0UnA2VjRRemp6QVRMSzJJZTFGUlk3S01x?=
 =?utf-8?B?SVJrQjRpK3RJU2FKTnprbFJ6ZExyaFZ5WWhHMWxLS0tickZvMUZLRVI0dDA5?=
 =?utf-8?B?dVo2Y0NZcEVSWWFpdEtBdk1nMWFhNGw3NWRNbW1PNVhHcHhUQS9XSDJ3c21K?=
 =?utf-8?B?RUFLV1luR0orU0RXNFkreHJ1S2c3eThRcitha21rWm5JYUZiVGQzNjBoR3hQ?=
 =?utf-8?B?UHBVdGQwU0h6K0RNSk42azhlRS9OZGJkdlErRnVKMkZnbyszeG9kSjhhZDQ5?=
 =?utf-8?B?dE5MQktFclZkYmhPdXkwalYySUJQcllSNG5aOWxoZUg2cStuVXVrQVVmbUJr?=
 =?utf-8?B?OXduQTF5SEpWbEJZQ3JqMmtSekxXamRrWU55dVRIN1VwYWdLYlFEUjYzendj?=
 =?utf-8?B?MEN4ZGxpRkVOOWlFU1RGYnRiNUNXOVdQOEdxYVh6R3Iva3Y1S2hxTnVxbkRI?=
 =?utf-8?B?RzVQWCsyR3U5azNaRi9MRHgyejhLNWdtMytVQ0NHL2NINkIrTlcyM1Bzb21j?=
 =?utf-8?B?dnJMVTRET3B1WDNGS09kSlZuZDIrOVhKeVpCWm41TUJoejJCZktLSGFveW9m?=
 =?utf-8?B?cVpGN2FGZDF2ZjJMVTFDbFFnQTJpd1F6bWNGY0x4YzRUWWNsQXp3MEh4VnI2?=
 =?utf-8?B?WlY4TGx1MWlVZHFXbzZYR0pVcjI2eFJsNjhkblFPam1FbnBhUFFnOFBRMnQ2?=
 =?utf-8?B?UUxiV0FVbVRyL2tYY0wxNUl6Z0FxMnZJTWpONk5mLzB5Z3lQV2tUNWNQTTRE?=
 =?utf-8?B?T2lINThsT3dsMW5yUjM4T21idEl3VlhRMjJNcVlweUM4VWZtUDFkWDhUbHNE?=
 =?utf-8?B?UnRnUUhTVXc0UWY3UVdET3FNRFFNclFwZFdSVWpYQXFWUmI3S2RwZVNnaUsv?=
 =?utf-8?B?UzNEa3FWWVJDOU1VZjJqcWNjM2tFeDB1Y1orUHJ1dDdlL0VjNHpNSy9WbXZh?=
 =?utf-8?B?M3d6OGpJWWszaFViZFBlcThqSkN2d1hzd3NnQjJIMldWeDVJUWJUb0cveXFM?=
 =?utf-8?B?YUJjeS84VHZzR2VOclhMdzRERlFJclIvT3ZCQlF6V1lyNDBheTdKRk9ZQXkx?=
 =?utf-8?B?dEdubzkzZ2hQQzUvWkpFbnZ6V1d3aTJIa0liUXpBVHd1NTVQL0ppL1MyQ3Jp?=
 =?utf-8?B?d0JZOGE5RURYUEpSdGNsZDREKzVhVnNveUFWZzMwTFY1WmlFRzdSS0tuYW1S?=
 =?utf-8?B?NFlJck1Udm9nM2FMSWUxbHR2THNpZFRWRzZEZmp4bVpXaEpZRWFYblFuTVAr?=
 =?utf-8?B?UFNNajlLeHlxQ05kbklUeWRhcFlWQUtReEZDV2kyWkphL3ptaUluWWxVMlEz?=
 =?utf-8?B?ZzFGaW9pZU81d0Rkc2JVRWVkUkNHY1JiVlZ2UTlpUkVJVmZaaldFNXh3b2hW?=
 =?utf-8?B?bWU0V1VaVzFQRmsvaE92MWxKKzc1S0ZVbmwvWU1XK2dIanh2aTdGWndHWFk4?=
 =?utf-8?B?ZnhjNHI1d25tOFQ4N29mbHNCTGIyR3JTUi9jZGVSNlJPWkhpdzNaR0VHYVIy?=
 =?utf-8?B?SlYwVzRVejRjd1Y1dytadTcwUGU0TkdSTStzbWxJd2R6dmZBV1ZCQ2dXdkFm?=
 =?utf-8?B?K2Q3bURMVmZxbU1RUnVvWnhqMDdkRzYyeXdoK0lkaFdhSE9zamVURWZmcVEv?=
 =?utf-8?B?Uk5TUmxCbXRZVnIvQi8yUXBQSXRUMGRMRUZRcEFWRE5HejA3TkJubTdtUEkw?=
 =?utf-8?B?UVFzWGxYZWY0aDFPKzk2Zm9OTStGMVZTNVQ0TVhCNUM0R3VyWERIMEJuenM4?=
 =?utf-8?B?TGpoRkMzemhVemNXeFFZS0hiR0pqZWdKRVZGSTdJTWU1U0R2QVpIM0xJdmVX?=
 =?utf-8?B?ME9UWVJrVzM0Y1VRT3cvQlp0Nmp3YTVEZjFjWHpGY2NvSWNMNVE4Tk9pS1ln?=
 =?utf-8?B?cjg3bWxRVzNUTm9zNlI2blpOa0tlVFFxVXZvcXdkU0loWENkTytzby9WSjAz?=
 =?utf-8?B?WEdVWGpsRHRGaXdVcHRvN0loRUlnL1NtcTRLb29wb0c4RE1jUlFRa3dOR1NP?=
 =?utf-8?B?TFUyTlpTdDQ0V0VMYXZJNXRkRVRWYktZY1dtMDkrU1RubzZwbzU1clZ2aUR5?=
 =?utf-8?B?WG8zYzVva1F3S1liNUpRSzV1ekhCTVNENndoa2I3bTlKOFRCRmlNTFFtQzVH?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D1D343CF95B2E4F83DD42B95E9733F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aOcw20xNkmqbfORmPI91f4L+BxiUH2YEO1UiYLrujt1E73AJ4umZue5KPHGVGMloIqzE8GUOqLuknGPWtcCnvrYN6yJNC39cN8wWjc9rT6RYqT0mzBvX31KKrXkAF76Y5odDxTsUJJ6ryOuUkrurLQkAp6WXfj7Fi7DORGym1ZxsNQPWyn/2MOXLmbGfU6q3ge7GQRDlGILeG2OFQo1b7Tg0Ayn5e21KvRNVPyEl5hZXc6oji917AOBP+0RJn8SmVaGPaEBqgH981yR1AodhZzJ9ugiT806pOe0yVFon6NlzlrZdk6SS1UTxE6tcfiVKmCIooOsseRMvfI9YgkO2IAIV6RG0z7KxDhbTOzoI44x6HESK4/jKDmslLJLAxWE9KXhwuUXJy4r1SOfPawAfm1mT55wox8D80H+6Rbi/G1MmQukDdoBZD7gX0yecYT/O+I+nF5Nq5ZO2Im9WnoiVbUxEchYhov5POGyfpltHFZVLTyQICECjpmKssIlS00+oFXj43M1mTDejJ1z9e7/ZGsa2V4sY2NHYZTj0oZc2UYtwgqxpPP1gyuxM+iPe5sJ32emaYh20ZfMRZzb+musr703EotASkcHW/MpGvCUlGGk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3b38f7-d363-4e61-0bc7-08dde72c236a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 18:44:51.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fb/zJAaDtPoypoXiokn5wjNlD09uoGcjje2dEkpaQUZ6yAmGtMFNxX2yaX+ifm+UahapquD4wkc8tO+058c3pEC4qGUAQrZfBk4lttOkM84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE23691A9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290165
X-Proofpoint-ORIG-GUID: 8Gs8jBPHjRymqUC2nMtOKIhWHXemiesU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfXzaI1gTA4dK8B
 tOqKvE8fG8DBT2zCE3A2p54fdK//5StWZ0ljkDgdTE9e1orNMYF7PfD6vFkXQNg9DEQZAHVuzs4
 gkf4AyH0v4tsO2SepVN3Hpg+4qk0divdEtXtcLGD6/a5j/ndu2lC/wfgMcCrPQhfL5o4bc0/461
 dpghm6bOpC0Lfk2aWUfdCq2F0jk6MenJzDn4eR+sKvMcrfHK+Bo3Tgxhh27pafLV1IkBM8BpSKh
 fy+nrHn8Pa/6e0cuLkbXxqfnAlJh+A4smUTlNwhEPveAexFhAkFtbQG4omlL2+N7whFSnUmHWcg
 LLmYQgtCh/DplHrUVR0j7HrkVtOJX9JP62ulRIo0MrtSljM47G6J8PKwbvyNgEKJTQVvtpmGE7+
 fEySVSfwIMdX9qqnKrMB12RhF6yAEg==
X-Proofpoint-GUID: 8Gs8jBPHjRymqUC2nMtOKIhWHXemiesU
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b1f52b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=m83JS1-7bTpWAyjLLdcA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068

DQoNCj4gT24gQXVnIDE4LCAyMDI1LCBhdCAxMDoxM+KAr0FNLCBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEF1ZyAxOCAyMDI1IGF0IDE2
OjE1LCBGbG9yaWFuIFdlaW1lciB3cm90ZToNCj4+ICogVGhvbWFzIEdsZWl4bmVyOg0KPj4+IEl0
J3MgdHJpdmlhbCB0byByZXByb2R1Y2UuIEFsbCBpdCBuZWVkcyBpcyB0byBoYXZlIGluIHRoZSBz
b3VyY2U6DQo+Pj4gDQo+Pj4gX193ZWFrIHB0cmRpZmZfdCBfX3JzZXFfb2Zmc2V0Ow0KPj4+IA0K
Pj4+IHcvbyBldmVuIGJlaW5nIHJlZmVyZW5jZWQgYW5kIGNyZWF0aW5nIGEgcHRocmVhZC4gUmVw
cm9kdWNlciBiZWxvdy4NCj4+IA0KPj4gV2VsbCwgdGhhdCdzIHNvcnQgb2YgZXhwZWN0ZWQuICBZ
b3UgY2FuJ3QgZGVmaW5lIGdsaWJjIHN5bWJvbHMgdGhhdCBhcmUNCj4+IG5vdCBpbnRlbmRlZCBm
b3IgaW50ZXJwb3NpdGlvbiBhbmQgZXhwZWN0IHRoaW5ncyB0byB3b3JrLiAgSXQncyBraW5kIG9m
DQo+PiBsaWtlIHdyaXRpbmc6DQo+PiANCj4+IGludCBfcnRsZF9nbG9iYWw7DQo+PiANCj4+IFRo
YXQncyBnb2luZyB0byBmYWlsIHJhdGhlciBzcGVjdGFjdWxhcnksIHRvby4gIFdlIG1ha2UgYW4g
ZXhjZXB0aW9uIGZvcg0KPj4gc3ltYm9scyB0aGF0IGFyZSBub3QgcmVzZXJ2ZWQgKHlvdSBjYW4g
YnVpbGQgaW4gSVNPIEMgbW9kZSBhbmQgZGVmaW5lDQo+PiBvcGVuLCBjbG9zZSwgZXRjLiwgYXQg
bGVhc3QgYXMgbG9uZyBhcyB5b3UgbGluayB0byBnbGliYyBvbmx5KS4gIEJ1dA0KPj4gX19yc2Vx
X29mZnNldCBpcyBhIHJlc2VydmVkIG5hbWUsIHNvIHRoYXQgaXMgbm90IGFwcGxpY2FibGUgaGVy
ZS4NCj4+IA0KPj4gVGhlIHJlYWwgY2hhbmdlIGhlcmUgaXMgR0NDIGNoYW5naW5nIGZyb20gLWZj
b21tb24gKHdoaWNoIG1hZGUgYSBsb3Qgb2YNCj4+IHRoZXNlIHRoaW5ncyB3b3JrIGluIHRoZSBw
YXN0KSB0byAtZm5vLWNvbW1vbi4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uIQ0K
PiANCj4gU28gdGhlIG9ubHkgd2F5IHRvIG1ha2UgdGhpcyBhY3R1YWxseSB3b3JrIGlzIHRvIHJl
dmVydCB0aGF0IGNvbW1pdCBhbmQNCj4gdGhlIGZvbGtzIHdobyB3YW50IHRvIGxpbmsgdGhhdCBz
dGF0aWNhbGx5IG5lZWQgdG8gY29tZSB1cCB3aXRoOg0KPiANCj4gI2lmZGVmIF9CVUlMRF9TVEFU
SUNBTExZDQo+IGV4dGVybiAuLi4uDQo+IA0KPiAjZWxzZQ0KPiAgICAgICAgcHRyID0gZGxzeW0o
Li4uKTsNCj4gI2VuZGlmDQo+IA0KPiBvciBzb21ldGhpbmcgZGFmdCBsaWtlIHRoYXQuIEEgcHJv
cGVyIGZ1bmN0aW9uIGludGVyZmFjZSB3b3VsZCBhdm9pZCBhbGwNCj4gdGhhdCBub25zZW5zZSwg
YnV0IHdlIGNhbid0IGhhdmUgbmljZSB0aGluZ3Mgb3IgY2FuIHdlPw0KDQoNCkNvdWxkIHRoZSBy
c2VxKDIpIHN5c2NhbGwgaXRzZWxmIHJldHVybiB0aGUgYWxyZWFkeSByZWdpc3RlcmVkIHJzZXEg
c3RydWN0dXJlIGFkZHJlc3M/DQpQZXJoYXBzIGEgbmV3IGZsYWcgYXJndW1lbnQgdG8gdGhlIHJz
ZXEoMikgc3lzY2FsbCB0byBxdWVyeSB0aGUgcmVnaXN0ZXJlZCByc2VxIGFkZHJlc3MNCm9yIHJl
dHVybiB0aGUgYWRkcmVzcyBvZiB0aGUgYWxyZWFkeSByZWdpc3RlcmVkIHJzZXEgc3RydWN0dXJl
IHdoZW4gaXQgZmFpbHMgdG8gcmVnaXN0ZXIgYSBuZXcgb25lLg0KDQpBcHBsaWNhdGlvbiBjYW4g
Y2FsbCBpdCB3aGVuIHRoZSBjYWxsIHRvIHJlZ2lzdGVyIGEgcnNlcSBzdHJ1Y3R1cmUgZmFpbHMu
DQoNCi1QcmFrYXNoDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICB0Z2x4DQo+IA0KDQo=

