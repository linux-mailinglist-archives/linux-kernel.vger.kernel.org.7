Return-Path: <linux-kernel+bounces-759313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3136FB1DBEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF13F7222FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597181A254E;
	Thu,  7 Aug 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CU+KV0Fj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u9kRBBok"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D6BA36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585182; cv=fail; b=KidRk0KyAyq+rukgz9oIdSq3f+hkTZfIYBQio0HNKuVbnbmmUtJR/EXEO0GhN1az04I/8D8VaOg3EerF8eQ0UCJ3ElmajgrxBHnD6tuSFACyOi3WmV+/NUTuoohFaJGw20ys5B2Jsa8h1HR+wHBYB/KdOJgqjj6YnJFgMQ7QYxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585182; c=relaxed/simple;
	bh=eVfqmdtmhcevVZxdZKyoLc7sIk5H6q3amh3q0xRKGyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gKDYaWMDwzGRXLYr9ZJoi793pwkLZA7UjvhLhIbYQFheci/KVEXeRQtw2iUzptUKBdrMyD0gwHjBIDYgmqCi/Vwp8ZneEwOlyDkddUHQE8SdB2i202EwzHNWB0G51eE2aNf5bjGJPJJ4tK3b/NwZmSqxkH0wPJpiQRLXeR2WRyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CU+KV0Fj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u9kRBBok; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577GgHhp023204;
	Thu, 7 Aug 2025 16:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eVfqmdtmhcevVZxdZKyoLc7sIk5H6q3amh3q0xRKGyw=; b=
	CU+KV0FjJif6RhJXcXTqnzUUvViTk53DwxZMEw/JRFZNyEtGU3sj60SAaGEVDA8v
	0fg6144OEqfar52MneMe8OUBMdJ9shZh5EqJKrgiuu7Bn649dmS5MKqh1zNCJQSK
	6c/7CfSbfG+ftvl4ulP6IYvrmLLcQHmAEOgxu0uQYiQI44qVUvTf9k0BpI8G09/7
	N3O438Lfe4HL3l8ob0tS1wFegPXFdfhPoSu/1E6b5Ur1WrZzGddzGQjhHKesp4rr
	7GO55qSVZfSJq+1S/9bTtxR8vdJWG4NJ613wl8xBkJhJZtGShEhdw6ofZ2URrskS
	Sb9IwlWUH8PuYmaoRghf5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh4hj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:46:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FucgZ018341;
	Thu, 7 Aug 2025 16:46:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwspmnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:46:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFHIkoFvJb6PG8ZWMmvvRnCNnavgbxlpw6131WDO4JnLZiuqATAUQPK9qbMhkonA1ZaCvVDfu8eaPc3QYjGzGKlPo83NJypySGSvlyhvqBzP0bMbBBqvhChmT+h7lKL3NnkFW0TlK8w9cLW4kNeybCzab9ekGECTrKE4ROA8waTyVKpOqMAoe/6e4PTMlchGZB6gemBqHmRTZPSj7qHPuC66JVqjepEN6/MMZCVy3bNNI5RCWai7l67fgu3KUmFDrrHiWj5N0AsAVXZ+aQPJWnc6ob2Ej6EBl/qIosL7qwmdf762dALSJMFtej05LeZ8f4rROF85tzGI9yEFNamY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVfqmdtmhcevVZxdZKyoLc7sIk5H6q3amh3q0xRKGyw=;
 b=VDTCtDEOiMkqj9Zr/Kb6+lNUZnzxK+aSfldcn3HPX6ExSj9SFW7lgclszjXqyDFHQ1zCLbZF1Yug7OhkOGRjhUXhPBN7gaEJrSlhSxE5Nilsi8eUc+uVVEEB7VovDeEvWcGkPwi9qXtPI4aqJukr0eB6eRoLV8GFvKig3wAPruhqdykHaBHV1QDZ4frLEaoANd6RcoD5VUZovmIrESVXFAD8kD09k5Wb264GSkrRAj2kcVYrlhmhW4k60d3hFRTJUFC3GYgAHH6CDgOv5Wv8YIZ/EepMewzKoArtuTFM3kJETKgxm9KD0NcV1cKxuWns16RJTw2sJ0Eo4kz+IxK0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVfqmdtmhcevVZxdZKyoLc7sIk5H6q3amh3q0xRKGyw=;
 b=u9kRBBokDW6s/q2N4ckbJvWSQgqBngIVYmRQRcdZal8Cyj1Zrew32+Q591AvlLL03zGLza/qXVKgn593LJ7GLuTMgPucBiEIyzsqCYdk53qObvMXowG7PoLfiWTko1PNneijGKPMg7X9hQSUvtXjH1yGeudmbvHrWbEvGcYe5wA=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 16:45:52 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:45:52 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Topic: [PATCH V7 01/11] sched: Scheduler time slice extension
Thread-Index: AQHb/LZRoohaxDA/AkO7zPAZBTuqUbRWKXQAgAEmWoCAACwngA==
Date: Thu, 7 Aug 2025 16:45:51 +0000
Message-ID: <57FC4F60-01FE-4201-95FC-694841BF90F8@oracle.com>
References: <87ms8cchqf.ffs@tglx> <874iujcjj0.ffs@tglx>
In-Reply-To: <874iujcjj0.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MW4PR10MB6322:EE_
x-ms-office365-filtering-correlation-id: c1240aa2-3aec-4c26-9797-08ddd5d1def3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzdoQkRlN0FmOEJZcWlFMHQwcFhNQVdSRHlpR3JSZmNGb2IwODZOVU45dzZX?=
 =?utf-8?B?aHE1ZGhIRDlFOFpET01FblpoN2YyOThQQnJQSlhZcU9IaVdJMEdXSm1WTitm?=
 =?utf-8?B?UTJONkZiUTYxWUhrV1lNZWNoWHpSb05YUVhkcFlPM1dQN2FNQnU1K25wU2tR?=
 =?utf-8?B?RjZFMmdxVTAwRHBNQ2ZoRjkwc1ZPK0thd1NvRVkxTjl3REE2aDIzU3lNU28r?=
 =?utf-8?B?R3V0M1dwSE51QnhNVlNJV0dDa3lRUnduTE9xKzEwM3EyOHpaSkpxeHNZOWdM?=
 =?utf-8?B?OWJFQ1ZySjM4cVd2Z1RUNWVTckc4Z3dPWnFHeHltNDlHTGlkb1Y1c0V3V3Fx?=
 =?utf-8?B?aTFCZHllTE9EVnR3V2F5OEFGbWZRNHNRLzNmZllRSFgxUlo2NEJHOHZnYXlW?=
 =?utf-8?B?OHpNSDA3OG1pVWRBclZyQitJUUVZU2ZPZ2hjQml1UmFESExCbU1NeFRrU0d6?=
 =?utf-8?B?Y2VWa3M0cFJiTWRveStWYzZZV09ZV3lETklPRXdjT1VuZE1tandYbTJYOWpv?=
 =?utf-8?B?aWVTaHp6RVE5UEZxZU5VNjllT0V6UGg4ZzFLOHRrdjhFZzYxS29icUJ5aVFq?=
 =?utf-8?B?T0JVOXpySGdldmZyeTBoOWg2VGpVVjI4Q1hNUWFWclI4MEdhUVhaSzhYVU9j?=
 =?utf-8?B?ckxSWXpnQ2srVFVlSWdmSFVVYS82bENKcUpEK1hDSE10cHI0SXJFc0REalZr?=
 =?utf-8?B?TjJxbmxZbHNRMjNDUTJ4K3drZmo1akFEakVLL0ljUWJpeEprTnVTbkk1Rmtr?=
 =?utf-8?B?UzZ2ZGJzY1VyVlI4SkRIWUdMcVpZNlFiRFRNcGgwZCtURHJGM2FMaFBLVjQv?=
 =?utf-8?B?d0lITW9VRlJjSXpZUnZyKzlnUGdUVDRYeU0xWmFhU3pNc05WSGkvbUhMU0ha?=
 =?utf-8?B?UWk2WDd3QW9LU3JrRGx1RUhYV3BtNXMwSk93MUpzOTN6dTZLSUZwQkFYTTdi?=
 =?utf-8?B?dnkrTHUwYmtRSmRmbnNtcjhDbDFQbE1tQjdmR0prcVNlUVV1aDB0TW5lSE9K?=
 =?utf-8?B?NytncGMwRDJnR2dmUjRuM3RhZ0IwdXFIaTEzZHgyVm9BQUUzRkZFQ3dsZGJj?=
 =?utf-8?B?YmVrY2xaWjZlS0FmVjFldDUyT3htREd3VXdUQzF2bmI1R3VSZkdtdmZkQUtI?=
 =?utf-8?B?WjY2eXNXSjRPQWx3ZkljcE8vUjBzWkNsWWVTYnRGRHdzY3RWaUpHVXMrNmNw?=
 =?utf-8?B?Yzd3Z2lUeHMvUG12RWNQdGxPTDF3dE0rTkNBWDJMZWVZdkNRSWJ2d2NObHQ1?=
 =?utf-8?B?WHhFOHVoQXZYRDhzdVJsSkZwWlFyZHc0dzZaeU5vc1ZxZFFIU2c2aitISVkz?=
 =?utf-8?B?c2IzNXZrQWNLOWlRaXZrMjZRcTJzNzFBUDNjL1hkU3JHcTVkVHplZUlxZW5q?=
 =?utf-8?B?aVNHSUJNK0xVU2ZxU3hhcGhFS0lNcFJmcktLdzJLVkFseng2QmRDT0dWUDRz?=
 =?utf-8?B?WHArbWp6VElVbDNwNGNEUFpGQ1VGQll2WGRIbDQzWjR5V1Fva011RXMva0tp?=
 =?utf-8?B?amhzWlRoTVlCMkpLY3ZxRitZOUNRYlBkMXliYURLOHUvVDdXaUZQVmFGSHVB?=
 =?utf-8?B?QURqcThvbDV0NkRTM2JHMGZxMlU4NXBDZDJsc0hYYlRkbUx5MUhTaU9uWFMy?=
 =?utf-8?B?Tjk3VjJaWER2Wkc5ejJLTlJzaXh3NnNJNmVBUEtlZU1rcjdCUi84bnlJTzlN?=
 =?utf-8?B?TXAreksydjhTT3Mza2hXRys5emNpQ3ZnNVhGTHhJbWZBQ3k1ODRSdUN0Ym5E?=
 =?utf-8?B?S3Nzb3RXbGFIZEdOc1NRZ2tSUHdxS0FvVzRheVdyemdhM00zRUxlN0VENSs4?=
 =?utf-8?B?QnhvWDB6VmZjNkdjWXgvVTRNNUhJVVZpbkRKWnNSTFhPS0lVVjZCakFGVC9W?=
 =?utf-8?B?bWJqWkkrNVRWNWF4bEpsVHpZaWZjMmZoNXYzaDA4MTdMcGRsVjllZ2xTbTVE?=
 =?utf-8?B?Z3FxOUQ1R2JOSEh2WDdmbmR2RHprK2swckxHOUpubG9pMFRpTkhjMnM2aUk3?=
 =?utf-8?B?c3NoVFMxNkhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXpZS1hRV1VpNDE5RDBGZVNhMGZpUEo3cnNmcVNpSTgxQldWNHk2Z1pONW9j?=
 =?utf-8?B?ODNyNVdIK3BOQ2VNaW8vdzZpalFQaXF2dTI1Vlc0YkhXRCtNRUNIenE4bDJ0?=
 =?utf-8?B?SXJGYmR5QU9DcWJJS3dmYi9icldnTjVwcDdNQzR2eUJrNGVjdXN2S2NkK1Zw?=
 =?utf-8?B?ckpGYUk0Rm1VYU9Ic3NiNHBVV3JEVll6Q1JmOWxwcVVBZFg4RDFzbnZEeGtl?=
 =?utf-8?B?WUE5bGkrN1BFb2lLMVVGWWVCSEVNRUx6ZUZmWWJwUlNSMzdad2VpZ280MG4y?=
 =?utf-8?B?Z0QxNW1CdEhzQWhrbG9wUTI0OHNmTVBUbzRUaTFpdDI4YzZHK0l1bUdyTXZi?=
 =?utf-8?B?THN1djc0WS9RMFJSeDdoaGhxN2VKZ1AxU3JKSkExZXozeVZSeTBEalJKS3o2?=
 =?utf-8?B?R2V1RGVOaTVOcFR2bnRvQnFRQnhjckgwM2szUTlQOXZEdGZxaGY3d2prb29S?=
 =?utf-8?B?bCs4UndOekxweGVLSGVpVWdSRklsdk81dkk4RFYrZVVQYzlTeHVTcGptQjIv?=
 =?utf-8?B?ZTU4aDhnbFNpYXNSN1A5TFV3VktPeWhwemx1RFNrMTM4dmVoS2pjQzhRS2dI?=
 =?utf-8?B?d0MwaDI1RkpNOE53SjJEbWRsNnJTQWphSHBkQmtnZmJlT0Y4V0lpRE5VT21U?=
 =?utf-8?B?Mjg2Nm5EeHFBdGNiMnBCTFRldHFlT3JPYUh4VENuOFZSK2g1bjBtUVFzUjVv?=
 =?utf-8?B?ZERaVmg4NE5iV0h5dmJKRk0vSG14YS9OVTBwUmNXTnlncmxEbmhvblpaaU05?=
 =?utf-8?B?dnNodHVLZXp3VzQxbG43Zy8xVFVRVDhqT0dNZmRhUHZUTmUza1VyeEZpUmRQ?=
 =?utf-8?B?bEZidDIwVGd3M1FMSlRPWjlRM25teVk0OVlUam00Z3BUQzhXQ0N3TTJHdDd2?=
 =?utf-8?B?WitVMFJQd1RoWmNoejVXMG5rOFY1WEoxZXhNNmMyWUgrQ1h3eU9RVXUyYUhP?=
 =?utf-8?B?WGJ5QnFta0wraVpNL3pNY05vSytmVmJsWE5qcW9QcXQyZUM3RTltalQweXhT?=
 =?utf-8?B?elcwQWlKa0lOMmcwZWcxN0paK0pIWDNwR2hBcWY5VHI0cm02Zi96ZzFEQzR5?=
 =?utf-8?B?OXN1TDY5Mmo5YVYxQ1ZuckVJTHZCWENkdU1qcEd1cTNPdURkdVVuRGwzWG9X?=
 =?utf-8?B?ZENqMFBubTZnYjlDdy9McGZnZWVPZzhUSWZKTENNMkhwR0xPNmZXbDlQMlgz?=
 =?utf-8?B?YngvRVRWTThobmd0QnppOVpCM3d3SG5HNlBQR0R1VEFJN21OY05mZlh3SDVh?=
 =?utf-8?B?SHZKMkFpZ1cyOVlQQkVXd2xialhtZXFWalRuaWdaNDhneVZ2VEdLOU8rUkp0?=
 =?utf-8?B?S3hCU3lkbTJxazZob3VEblJpaVMvbEJjaXpTMUhPQzFVRlVGS2J0K3FVVWp3?=
 =?utf-8?B?c0xRRDQ5VGdmaWwyYkJiRXRDK2thK3dMOHVJOVo2M2pYb0ZZVVhiT2g1MjMv?=
 =?utf-8?B?N0t1dDRyc01EbytNUTBuaVVIK3E2QzhsSG1vVVJiNExidk9HdzFvbDJ4MUVX?=
 =?utf-8?B?NTBpeVJ6UC9pdDc0cUE0elBhQ0lVbVpiNTNVZUdOeURpRXNTVS8vRDZ6cE9J?=
 =?utf-8?B?V2FKb2g1c1lqeVd1MDJkMFRpMXdQWFk1ZGVkTXZFTjVXMGcvQ1RmM2Via3RC?=
 =?utf-8?B?Nzg1TGpqZ2Izanp0dWFuaE9UQmtHeXdYQytla2cyeWtZenFkaVlYekgxMU5S?=
 =?utf-8?B?dmxrcFVJRlFqK0w0aWhWYzkwb1lhSmlHcUw0aC9seHJFZ2p4NFRTNWhrUm9t?=
 =?utf-8?B?VDQveHRiaTh6c2U3K0pQNnNIVWp1eXNZWk5iT0NKTlpFdUdVTnBaVGNDRFRR?=
 =?utf-8?B?d1M2WFNYQi9xR3J1LzU0ZWtsMC9vaFVCSDA0Uk1UVlRUcEdjZXloOU4ya0Rp?=
 =?utf-8?B?TDRGaUd1c2x4UmU0M2pkbjlFUW9OWHpFRVdmNUMxSnpFamRPL21zN2NSay9X?=
 =?utf-8?B?aXNidCtWUEpQSStYNFhoMzZReEZoNURFdXNwNUt5R0M2aEUwMkN1c2tPeUZH?=
 =?utf-8?B?THpCYUsvZmFadjlYbk5SQXk1RDZMaTJaeTQvL29ablpVeDM3eWJoMnNPcXRw?=
 =?utf-8?B?bDU0dm9taDVUWG8vRmpJcjhKR2ZyQTZMSlg2dVNVZE5WeUFFMnJPam9EdWdQ?=
 =?utf-8?B?M0Y5dnB1SExQL2hKVFB2STF5aTBlODk3ei9YS3Q4M0d0L0ZHdmlTNkFkV1NI?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0066A5D37D694CBB4657C2AFB11C4C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M5d7GOiJz7K8aAytwZU7/VkZ6ddYuI5HdbEP2mUGSpDDjvHHZeBJLuUT0GcOk3uLf6+lVsBe5pbCdnfZqTF8jgnT1F8w1e26y/rjlt++VpzbfUxLW9Y4n7EJGVLEw+471DYokvH19mIQzSmZNOPu6JxPlUFg8fRxuR3QWJBOuo33ktv2t1tRyjVQDLFQpxFSwLnIsyBFMp5V4tzuxEB50YJD2qlx5kWRyZWe4InBpxrc75u9g0kpQBAh4Tx0waTopM1xOzkzbzWIBVOmjaKrhJMAaUaxhcAi59E6K/QHjCJ1aWVu4yS+vVzSgtiRPdze2P2BBHVajwvbS5KEhi4DQYuFQJ0UZDnADw54siWjRH5QB6Fx9gvvP++wchjpTsGtLoc/JSKJeoAnG4Z7d6GeazBt73KiaQvXgcxacxj5RgCDZA5IkxBwYN3HyJ7ia2STCRm2/Le18FxU+Rg49/fhgnLE9Vcz6jR6pMDSsooxt6w7az71eRH93DTkfDf0um5E2E4vSePpC3+oaicAn3s3Kk5lmsiUIVhPPM/WpVhn93RlGog+xHUZEj/PrfD0bQmCMIu+XTLPYfyLqGDbfhvurxsWcGIddYMg43u+t/ZFWLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1240aa2-3aec-4c26-9797-08ddd5d1def3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 16:45:52.1781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Qdrlk261HTr5AYELMT9aYkltDFneyHFLLEvM40vMRWwE+2EqcjcRZnHKrP+kt+wQ9pXyo+qIIZDy4jPWN9mvNmoxy9BeBUTx0VuKnyg38g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzNyBTYWx0ZWRfX+Wpni42iYMqB
 VupifLPBtIRc6JHZZHIjxCOxlqWWr7odZlTVWP3UUgGp0NcT9HBwZ5ecfrAP5+jGb3ijpS1wH+h
 jTqiI8T3WpwAiqG+acTZrYycZxpWnqlYChLbsudUQ5LBP4+Z1sfLGu4Yj0dyqpNfQlc8RMsEVjI
 lyjslclAm3/8f/dnrost0q/76m6VqsLeBNpnY2NR3txuMhoeLTDpcQ5Xu0WRwRe6R6+TjGy6cq5
 uqlEepEPRXs+a3y/ho7wFdh504T71uNdaSmjcNYCOmnRtkKii7t7wRUeTwmBKqzds4tfHxMWRuV
 1nju+7gFq0Gb9G/kzbaeUH+MEEVW8ikx1lo7sTHwEmvyWVKMbYQFnySuHm4HHV3MVRGIxOaImES
 e/PL8xOWNNVjcBQNMdma/rwrO4zRda5Y5ZWkFMrLjYkLIf2BVzGVb+R0YOfWZ/Z1SrWn4eNS
X-Proofpoint-ORIG-GUID: ooAEr31mEPirPzZO7w4ob_L8u7VINAyY
X-Proofpoint-GUID: ooAEr31mEPirPzZO7w4ob_L8u7VINAyY
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894d84d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10
 a=0CXCDjFY0fVV9SMxxrwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070

DQoNCj4gT24gQXVnIDcsIDIwMjUsIGF0IDc6MDfigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBBdWcgMDYgMjAyNSBhdCAyMjoz
NCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gT24gVGh1LCBKdWwgMjQgMjAyNSBhdCAxNjox
NiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+PiBAQCAtMzk2LDYgKzM5OSw5IEBAIHN0YXRp
YyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlX3dvcmsoc3Ry
dWN0IHB0X3JlZ3MgKnJlZ3MpDQo+Pj4gDQo+Pj4gQ1RfV0FSTl9PTihjdF9zdGF0ZSgpICE9IENU
X1NUQVRFX0tFUk5FTCk7DQo+Pj4gDQo+Pj4gKyAvKiBSZXNjaGVkdWxlIGlmIHNjaGVkdWxlciB0
aW1lIGRlbGF5IHdhcyBncmFudGVkICovDQo+PiANCj4+IFRoaXMgaXMgbm90IHJlc2NoZWR1bGlu
Zy4gSXQgc2V0cyBORUVEX1JFU0NIRUQsIHdoaWNoIGlzIGEgY29tcGxldGVseQ0KPj4gZGlmZmVy
ZW50IHRoaW5nLg0KPj4gDQo+Pj4gKyByc2VxX2RlbGF5X3NldF9uZWVkX3Jlc2NoZWQoKTsNCj4+
IA0KPj4gSSBmdW5kYW1lbnRhbGx5IGhhdGUgdGhpcyBoYWNrIGFzIGl0IGdvZXMgb3V0IHRvIHVz
ZXIgc3BhY2Ugd2l0aA0KPj4gTkVFRF9SRVNDSEVEIHNldCBhbmQgYWJzb2x1dGVseSB6ZXJvIGRl
YnVnIG1lY2hhbmlzbSB3aGljaCB2YWxpZGF0ZXMNCj4+IGl0LiBDdXJyZW50bHkgZ29pbmcgb3V0
IHdpdGggTkVFRF9SRVNDSEVEIHNldCBpcyBhIHBsYWluIGJ1ZywgcmlndGhmdWxseQ0KPj4gc28u
DQo+PiANCj4+IEJ1dCBub3cgdGhpcyBtdWNrIGNvbWVzIGFsb25nIGFuZCBzZXRzIHRoZSBmbGFn
LCB3aGljaCBpcyBzZW1hbnRpY2FsbHkNCj4+IGp1c3Qgd3JvbmcgYW5kIGlsbCBkZWZpbmVkLg0K
Pj4gDQo+PiBUaGUgcG9pbnQgaXMgdGhhdCBORUVEX1JFU0NIRUQgaGFzIGJlZW4gY2xlYXJlZCBi
eSByZXF1ZXN0aW5nIGFuZA0KPj4gZ3JhbnRpbmcgdGhlIGV4dGVuc2lvbiwgd2hpY2ggbWVhbnMg
dGhlIHRhc2sgY2FuIGdvIG91dCB0byB1c2Vyc3BhY2UsDQo+PiB1bnRpbCBpdCBlaXRoZXIgcmVs
aW5xdWlzaGVzIHRoZSBDUFUgb3IgaHJ0aWNrKCkgd2hhY2tzIGl0IG92ZXIgdGhlDQo+PiBoZWFk
Lg0KPiANCj4gU29ycnkuIEkgbWlzcmVhZCB0aGlzLiBJdCdzIHBsYWNlZCBiZWZvcmUgaXQgZW50
ZXJzIHRoZSBleGl0IHdvcmsgbG9vcA0KPiBhbmQgbm90IGFmdGVyd2FyZHMuIEkgZ290IGxvc3Qg
aW4gdGhpcyBtYXplLiA6KA0KDQpZZXMuDQoNCj4gDQo+PiBUaGUgb2J2aW91cyB3YXkgdG8gc29s
dmUgYm90aCBpc3N1ZXMgaXMgdG8gY2xlYXIgTkVFRF9SRVNDSEVEIHdoZW4NCj4+IHRoZSBkZWxh
eSBpcyBncmFudGVkIGFuZCB0aGVuIGRvIGluIHN5c2NhbGxfZW50ZXJfZnJvbV91c2VyX21vZGVf
d29yaygpDQo+PiANCj4+ICAgICAgICByc2VxX2RlbGF5X3N5c19lbnRlcigpDQo+PiAgICAgICAg
ew0KPj4gICAgICAgICAgICAgaWYgKHVubGlrZWx5KGN1cnJlbnQtPnJzZXFfZGVsYXlfcmVzY2hl
ZCA9PSBHUkFOVEVEKSkgew0KPj4gICAgc2V0X3Rza19uZWVkX3Jlc2NoZWQoY3VycmVudCk7DQo+
PiAgICAgICAgICAgICAgICAgICAgc2NoZWR1bGUoKTsNCj4+ICAgICAgICAgICAgIH0gICAgICAg
DQo+PiAgICAgICAgfSAgICAgIA0KPj4gDQo+PiBObz8NCj4+IA0KPj4gSXQncyBkZWJhdGFibGUg
d2hldGhlciB0aGUgc2NoZWR1bGUoKSB0aGVyZSBpcyBuZWNlc3NhcnkuIFJlbW92aW5nIGl0DQo+
PiB3b3VsZCBhbGxvdyB0aGUgdGFzayB0byBlaXRoZXIgY29tcGxldGUgdGhlIHN5c2NhbGwgYW5k
IHJlc2NoZWR1bGUgb24NCj4+IGV4aXQgdG8gdXNlciBzcGFjZSBvciBnbyB0byBzbGVlcCBpbiB0
aGUgc3lzY2FsbC4gQnV0IHRoYXQncyBhIHRyaXZpYWwNCj4+IGRldGFpbC4NCj4gDQo+IEJ1dCwg
dGhlIG1vc3QgaW1wb3J0YW50IHRoaW5nIGlzIHRoYXQgZG9pbmcgaXQgYXQgZW50cnkgYWxsb3dz
IHRvIGRlYnVnDQo+IHRoaXMgc3R1ZmYgZm9yIGNvcnJlY3RuZXNzLg0KPiANCj4gSSBjYW4ga2lu
ZGEgc2VlIHRoYXQgYSBzY2hlZF95aWVsZCgpIHNob3J0Y3V0IG1pZ2h0IGJlIHRoZSByaWdodCB0
aGluZw0KPiB0byBkbyBmb3IgcmVsaW5ndWlzaGluZyB0aGUgQ1BVLCBidXQgaWYgdGhhdCdzIHRo
ZSB1c2VyIHNwYWNlIGNvbnRyYWN0LA0KPiB0aGVuIGFueSBvdGhlciBzeXNjYWxsIG5lZWRzIHRv
IGJlIGNhdWdodCBhbmQgbm90IHNpbGVudGx5IHBhcGVyZWQgb3Zlcg0KPiBhdCByZXR1cm4gZnJv
bSBzeXNjYWxsLg0KDQpTdXJlLiAgVGhlIGNoZWNrIHRvIHNlZSBpZiBkZWxheSB3YXMgR1JBTlRF
RCBpbiBzeXNjYWxsX2V4aXRfdG9fdXNlcl9tb2RlX3dvcmsoKSANCndvdWxkIGNhdGNoIGFueSBv
dGhlciBzeXN0ZW0gY2FsbHMuIA0KDQo+IA0KPiBMZXQgbWUgdGhpbmsgYWJvdXQgdGhpcyBzb21l
IG1vcmUuDQoNClN1cmUsDQpXZSB3aWxsIG5lZWQgYSByZWNvbW1lbmRlZCBzeXN0ZW0gY2FsbCwg
d2hpY2ggdGhlIGFwcGxpY2F0aW9uIGNhbiBjYWxsDQp0byByZWxpbnF1aXNoIHRoZSBjcHUgYWZ0
ZXIgZXh0cmEgY3B1IHRpbWUgd2FzIGdyYW50ZWQuIHNjaGVkX3lpZWxkKDIpIHNlZW1zDQphcHBy
b3ByaWF0ZS4gVGhlIHNob3J0Y3V0IGluIHNjaGVkX3lpZWxkKCkgd2FzIHRvIGF2b2lkIGdvaW5n
IHRocnUgZG9fc2NoZWRfeWllbGQoKSANCndoZW4gY2FsbGVkIGluIHRoZSBleHRlbmRlZCB0aW1l
LiBJZiB3ZSBtb3ZlIHRoZSBHUkFOVEVEIGNoZWNrIHRvDQpzeXNjYWxsX2VudGVyX2Zyb21fdXNl
cl9tb2RlX3dvcmsoKSwgdGhlbiB0aGUgc2hvcnRjdXQgaW4gc2NoZWRfeWllbGQoKQ0KY2Fubm90
IGJlIGltcGxlbWVudGVkLg0KDQpUaGFua3MsDQotUHJha2FzaA0KDQoNCj4gDQo+IA0KPiANCg0K

