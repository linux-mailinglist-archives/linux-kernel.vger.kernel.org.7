Return-Path: <linux-kernel+bounces-874351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A59C161A2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D141C2486F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B716334379;
	Tue, 28 Oct 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqd4tNoz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TfS4c2Ko"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6132E125
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671786; cv=fail; b=dUe3i9/L3TZUlzWuc57dS1Ym+r+QMYUTqp8kDtekZcLs0fAKXlmqbR/qTz3uX8xOCNOQKKcwuqUkYsFWoifujoOazBgVu7vK4Uijjn0kIdvADYTwmPz9hvFkHbSxnrZotiO8SDkeinsRjcAsG/c4gHH/phAtm+IbJY+SHMXjyzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671786; c=relaxed/simple;
	bh=2x5uFiIaA90geDHKYxEpWoeFs8ZF9tvmLRl/WYu/HXs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nE9YlJDkYdTja8WQWkwAYfBA6L4UIgSjYahTrYB6uCKNQG5edJRc+m3hxJk9swDo5iYt18v2FZ1j3fxupIZsfC3ERL4xkYwfmxujRuOx8qkvq+sh3UzlvKSmfhH3RejpCR89DDTo9q6J0u1qFtXoD2EHAK3lDh0mAjjbOKSpZko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dqd4tNoz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TfS4c2Ko; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SGsKvO009832;
	Tue, 28 Oct 2025 17:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=Qq2wEgje7flW1ozHVl+KfAZMc0yLddsgOW1YZlJUNf8=; b=
	dqd4tNozIUBntMb1PFvS31v081CKHOsFjjH2EU/0B15mgXuJodhl4Vmfc3gnm6km
	y+TGuneMp8h7Lgmv9gmezolxTYD8RfxAHD+mABWRrmON1JXeqbZOm3y5fIw1CNw7
	zChZ4bqmXE7C3btfIw7jrhfVLLlIGChszWGYNtDzsYsK+5PigRtsbDrZl3mcTeCb
	VzCb91FYNoBhLFD56CO9RYU7ZBGKWLRHtUIvluNQ1UxXwhBscGx0Ema8/ZTkKS42
	eJqafPha6hn/77ZsgvDs8ZfApJ8VkLj4R5KG+eoXhs0Ymv55JCXYG05+tVESWBCg
	YEgUGXlDplOf/YLX87+KfA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s6pu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 17:15:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SGwQKH024504;
	Tue, 28 Oct 2025 17:15:43 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08r46f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 17:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuGuhKDQlhegUQzfSkdl4d4ULvd5xNunuHYuFfPQC40uCMkbAPTiME4r9l3n1GUidHxDKoAWnnzbgg7ZGTS1rAm4wa/H9NHnG5OsQMR231MvJbJx81q0UZlGfjkdu5kgXMJ40oQnrDCrapDe0UMwDsgYiNPYFVX0A0DmVz2tkKG1lOBupkA8wPL8wjhN/djFC5tv+3oGKZ3oj0WRJktp3vH5qyz7/YTqZdIQVhJfMkmXcgHv93wrywU7py9dtuXKqDjj8Rbb9O7SJEi9bqW3rBIiiax7IeigKarslmasrTl0Jy4w3mMZMHIkmM7BIvYUrBjCx1W79PDFsza/oR8hOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq2wEgje7flW1ozHVl+KfAZMc0yLddsgOW1YZlJUNf8=;
 b=i/18iAh8gIF2poN3Eg799VQReSoDFRyH6BzMyjkxf0TqlL8ZY1WlaKRtvmj3c7fSIp1F7jgBwBZxu/6NWh4w/OLwqoQns0LXoJbFBuhZf0+rJQJhhJX/IqvaRBXLgVVCPKl3RktWrHjb4n+WrpB7qLCabjDMCe1wQP8G0cRaa39wQGfBNjDCdIyfJzEaRPLXqA1RnzQ4zc62yru0wZ8zCVG9zdIba4KjdRo0Kaeamf/cN+JroWYJPP52UZzPD+RQ9JmfCT3+t9sZgrJzZiWd/T6ZAyJfyiyeNTv+1HoatiUYMBVG2ZhwOXnSBmsjG763WVXduzpOP+RMxDPJspCNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq2wEgje7flW1ozHVl+KfAZMc0yLddsgOW1YZlJUNf8=;
 b=TfS4c2Ko5+YluePPMytjmiqtogTLpqgXYDCHqpALKIbQFhJmfJ4Vpi58/u1W1g20MJR6iei53bwXDHrVLrRfEj5C1c34ubxlJb1b/hMAXrC/k+Oz95oVGdSIAP9xbjFM2CITBw67zZoXyUrH1lBc3DCahoc/KzJCFyA+vUx8Lrs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH0PR10MB4827.namprd10.prod.outlook.com (2603:10b6:610:df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 17:15:39 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 17:15:39 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, david@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
        acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        willy@infradead.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 0/7] mm: folio_zero_user: clear contiguous pages
Date: Tue, 28 Oct 2025 10:15:38 -0700
Message-ID: <87y0ovq75x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH0PR10MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a529238-3510-4d0e-5649-08de16459e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGvCNA1Qq3CA/unx60Y5rfwACACim577CXisQqrcrB+8K+kEV1/jTmvRqUbJ?=
 =?us-ascii?Q?3hoWlYC2xZrMYhVq6k1UBljrdMKIA9ebljN3LebnpvJkvFs7k5JAImbuVfsg?=
 =?us-ascii?Q?rE7vJPxL20KVtpqLgV3UqUd596eJOOBdQqGn/rUJLXMVYzYzfzVIycyiSQDA?=
 =?us-ascii?Q?Pls0qq5gLmPGkHJpQKUfbFPiXSqZbzYVy9TXdDferEkotAkxXpmTIawbUp9I?=
 =?us-ascii?Q?HKPctPUEyFIcF9Mv86JFigoZtg3cjgwVwfGxu8Oe8kFXQ2dCwrnJtekhgBWm?=
 =?us-ascii?Q?LF5Kx6N0A4rcxHKLExyutgF8SzQwtUBQYc/P8YXXSCx4DcTmo374YU9FZtkc?=
 =?us-ascii?Q?jwhENol4y9FN4G2TonGp1WEWfLh147veGOZgbxxkC7gkD/lsE6zo+r7OgZMH?=
 =?us-ascii?Q?1ekVv8J4ZETIUqsrHfuMDCKnspTYPqFDZ/66ZnFuqeQFD49cAXOoinCoJRhI?=
 =?us-ascii?Q?GSzBfFiyoqio/ob2y7Hsx4oueQXqhcY0ZHEeleXEnRDHEl6Jn2vJmUpYpjJo?=
 =?us-ascii?Q?tH/TVp2sX5B1HXGFgHtTH1/Q4zQdjB95icB6YoktA8wwwMOvwV4X1Vy/pWRb?=
 =?us-ascii?Q?D4iTxf8y1JejsXNNYb+Yi6t7QNECGLgndebhxHmprFcHH+FVjGOzqrlFDm7r?=
 =?us-ascii?Q?V9gTivxRH2EkpkSGVA48DUYESE1DBLWTFU/jpodAcndE0FgityKCTpjOhDJV?=
 =?us-ascii?Q?EW/bK4VNbNGGBK4ohiQfXK7ARud9Idwbk9fytbvD2/X6Co1cB3QtFs/a5Y5z?=
 =?us-ascii?Q?AXzYdS9FneN1S/jjWhrorqF1t+nfQhBnZL8tQCMDiD2kUdsJLUIR6tHTLzDJ?=
 =?us-ascii?Q?19pDmHZzfBP49hH+iCQhPYM27CkSzSfQ/DdbDW/e6rvJuWHkNOWJDi3owtV6?=
 =?us-ascii?Q?S7AdS8+smlfkokjo5ppvxY0H8y2bIhQtmOFLn4PcwO36/q0XX/LarNBP68MB?=
 =?us-ascii?Q?QMrW3CfYo0wLkF9MXt6TW5lnOQ+uVWuJ02s6jw+1Pja5mmylHO3p2bfxj+aV?=
 =?us-ascii?Q?Jv7hAhZBVbNxCarQVgZfFqFUQ/ou1z2d0ixc/UpsUVbWIirsqHaJNAKVxq2w?=
 =?us-ascii?Q?ubn3s4RzeprzIJWbXhcsI0+qJncrjV1egBTrwDG5HtzGed2Q/BtJ8zuRvJ64?=
 =?us-ascii?Q?BioCHpm8JyilZeJ9fDEbuW3wyHIDxGbMfD/n5huILmJPnyEixxa7CvABE+FE?=
 =?us-ascii?Q?xXzdh43iPsMFB36JrVCfR8/+C/HQFqYhELcYv62jEDE00KYgbE6v0V2wquid?=
 =?us-ascii?Q?Cz/5TtYZOD1bSDR1zDXl8+gZ41sJtljWcnN9V8+z0eYqI3uaFJaTyJj7tpxO?=
 =?us-ascii?Q?pbrJhWE1OysfmJUyKRaTR8e/FgJmHIiRnuwmT/xvfcE1qpawS0hb2t+LeIU3?=
 =?us-ascii?Q?UbV09PsNz/OR/I8ajh5++tdwEHeV1bZHtKl64Rtq5dHUR/abTggnzrwCE38O?=
 =?us-ascii?Q?g8b8a+TGxcTzfBQX+FOhYSrLMqyRcCh/Y2HFQ7orH5bjZFp+MGjGPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0qENWgHguStLiY7CGIK3g99IDlcTmCdn/1JuGTirxQKGqVK++Ya2c5NjcKec?=
 =?us-ascii?Q?iSIK+xU8wAR0p/mCtaeVe50cz+Skak4zfpoiF05oJq+wuyhXqVGq95dgTpBz?=
 =?us-ascii?Q?iWgn09Vo23b4MqK9GeE/+v92jDuDHnjFW/d7Nx5fhyrNFBLCBQhyqIKWDcoW?=
 =?us-ascii?Q?tPwKUJURXFmxDZfvyY6Gf80556huDVATmJIxhRtF1n/46LNjAoN6y7F1OSZ8?=
 =?us-ascii?Q?uVzX1p0PdYXrD+6VvAPXCdmwxgBIyvUj5kvwBSAJsQpY9IqCt9FZetTMMj9D?=
 =?us-ascii?Q?0lb894S41V7DSXuic2rCkLGzN0frk5ku9Rj5ZWHC4ANKsS09YKNn4TfEEsHO?=
 =?us-ascii?Q?A2k0TKEcvigO2CqbeJuRK7G+M6wueUFUnWdhaNIr/7gqKduBJ9aE9LhvySK3?=
 =?us-ascii?Q?ZVtUrtLU4yg1slHn86scTOhdWWCiiyQ9Ov03Sj6SB4o+FT8tNUbHqQszn8Hq?=
 =?us-ascii?Q?OvS6volgkbG/w4Keg1ijvPxrSqb3gdwuiurKfMPAZD609WzYZtTTfBAwNZJp?=
 =?us-ascii?Q?RcFzVqo2nld83895f7fdNCFQHqP6GoyfzMHfYh3HAFM+EsTo7DEVOvSMD9N9?=
 =?us-ascii?Q?dOoawNdXzLXF3Up1eX7n370t5vP0HEWUdQ4wFi/igycsYf19EpyYGLKXQaav?=
 =?us-ascii?Q?WDYlZ44o6mfsmjZ+WGakRdhc2+OwCmB+1d/QHixJEywQXgDNQd6QTDrUipiG?=
 =?us-ascii?Q?mLrF0b/ZaQa/SDC+WRbkIkHpgweQlFKS4Uqz3hAjMQ5QFls50QEtDRhWsT8g?=
 =?us-ascii?Q?ESSGWtYjsmWjYG2L9x/N+xvigHVZdBNjPAXkYnfGDVQaddL7XN8PWVwu4Z8S?=
 =?us-ascii?Q?xEjO623MoOzIsMhyr+ou/rkbhzUd/rp5k9SY7zDTMUXfekfaBY0z5ENpJfIG?=
 =?us-ascii?Q?cvng92zVe+/SO4iqvGY2K5TLHMGTUdjt2CnCn/so8Vu/+xcelWek6by3tsC7?=
 =?us-ascii?Q?XO0LLVR9KUNNtrpGVKI/m7YltwUJRHNGbbQU6RoLv2cBtN+RQnnlhQ0uu2Cd?=
 =?us-ascii?Q?fK2H21HVWdQIF9fyryS4lx+CM2YQ+mx/OkgtOvPs3nY3Y/keQmTwCBB6khnI?=
 =?us-ascii?Q?/G0NFeePkYGnAp0I8yYlMTFz0p4fQ2iiliTX6hhJdIZRhuXJYSKqI7OaOBkx?=
 =?us-ascii?Q?fYAUrAgIvHbk8OYN+NZn/GB4ofJjNZ6E0mZJzjQr1dpNYSjGw2Z0CEhMoO9S?=
 =?us-ascii?Q?CbV8TADJ6czDKbNH1zGL8XoCOewhCljDjEnFMYXS/f9rlSVoZzwvA4dgFj2Y?=
 =?us-ascii?Q?irPGRMBBBbYzA+YB14WvmaaBBapo1OT7O3LsmDE1kkJcYwdRwsk5Sm2Lsj6K?=
 =?us-ascii?Q?SyNymrSqWoEl6zIVTZpQ7sZyLD6+jSykwVSr/KVqcxN0CIs74YEpEf6hP9pi?=
 =?us-ascii?Q?IYusraFjQl+GVOpUM7BpqOjs1tS19FYKx/QTqOk2B5UxOyiVGLqLWobT3PS7?=
 =?us-ascii?Q?CrjUapMGWmZTknbosTccYioNTI1JrCtXjQVgV/MNYmdeE5xo5oSWtz62v0eT?=
 =?us-ascii?Q?otl3S9XUtX+0lm9uJZpIGtYm6ivVRprf7iyvQFxQLAH5ScuVlzxgL5v7obYr?=
 =?us-ascii?Q?4aaHSa4ozhJmL3RnnbLZlyhLWvqnpgoQLWB7jVM5Qvkpye2czYdsFtaf07aI?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S35cii4L9RY84Jpm8yPefYEzmC0tiRI2z6jUoqqjQ+uM9jYauypHBzjb84ZlRvGr6rEIJhGEqASxydUEA9AcfrXKDERJjkPUbq05L97LVzamz9QgPedqauLTo8dtomNZU76p5+jAv2Sr5srq97WMnbKJwEGj3/oCH6kOrcZ8pzvtIiYEt/AzeRnv0LbFXw1CjOflOxYL4+G4EyNjryPSiIGb37kZdjkUIkbX3h+hKDCTV4JvgXZNaCshejVFuY3c0L8eKuB1i8MsGeI3V9kA14js3XDHzTERnEPn8bAFbO1g11IJ//qwxSWSaAHRdMdcBKtySWWa172j85BGwcQbK9yWEq3QsvdA+F4smMX3gkqsqKdxLSv6DjEvwZk9Q0r7qyp/da+doFUxKS2XKfrNuV8ck+s/XEG/Frgghw66w5EF98HeE3n51vukYqCE7QH+zcdLwPdaDiwcs7HwT6hFUKsnL+vMptqA/dlTxzUIp1lzNrFr4/Hbxm87UhvPC5IcjDbvcfLzcUISukdZvLyM/YCqlFN7J1VPaYERJoGpWTIWvhfMyoKJv+wDy47aoeYLmWQ1cSmTpBIKS/QrRZ5BiEWUcteCFAp3OnFXT6fMlRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a529238-3510-4d0e-5649-08de16459e0a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 17:15:39.5397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJwQCasYYH4CDDD/wVdRip9RL+WseAkL/mRAkzUwe14y60lLNcl2tkprOP2FN23AA7Au3m+7K2w7FzptVbypl1UZctIXgdaYCcYyRdraQ2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280146
X-Proofpoint-ORIG-GUID: tvCYbl50A2QrqkE0WWx_N1LijR_TfpJL
X-Proofpoint-GUID: tvCYbl50A2QrqkE0WWx_N1LijR_TfpJL
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=6900fa3f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Z4Rwk6OoAAAA:8 a=tF6A24u6ckdUWmuWyVYA:9 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX7D4IEcMic0JE
 VisTt8RArFPADmljPPCDh4akud1iC3TxbINyx9hy+G7PgXA7bxQsPtdcZj/nni+8Z+63dN/PjUb
 wr4L4Fm/wEhshNymKtUzadpqdaeP9pjStCRubLC9AIBbEZKpN49pyySc9caB6wR7VGXIaRY7qAD
 JvwvPLl4pJmUtZSK5TDxJjSJv3kZ4CrV5QCF9E5r5QuLKYVY/DzQXIw8JKxW15w1Pqz0tkTJ1N2
 4xtJ+vhD8vAtMplaleCwxcGUDAkJdnTuFoCF8YTDvQ8UQ0lehujI2MJG7BktF9puN/O0yrX1W2E
 S7asWB0EVDaM+tWOepEPaDpK8twNLcesj2EsJMMyk7euO7xh42CnffSUSxK/NxClF4cfMoo0aGM
 BhBoOlSGL7Fwm42r2nyOWofwqO/BCg==

References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027143309.4331a65f38f05ea95d9e46ad@linux-foundation.org>
User-agent: mu4e 1.4.10; emacs 27.2
In-reply-to: <20251027143309.4331a65f38f05ea95d9e46ad@linux-foundation.org>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 27 Oct 2025 13:21:02 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> This series adds clearing of contiguous page ranges for hugepages,
>> improving on the current page-at-a-time approach in two ways:
>>
>>  - amortizes the per-page setup cost over a larger extent
>>  - when using string instructions, exposes the real region size
>>    to the processor.
>>
>> A processor could use a knowledge of the extent to optimize the
>> clearing. AMD Zen uarchs, as an example, elide allocation of
>> cachelines for regions larger than L3-size.
>>
>> Demand faulting a 64GB region shows performance improvements:
>>
>>  $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
>>
>>                        baseline              +series             change
>>
>>                   (GB/s  +- %stdev)     (GB/s  +- %stdev)
>>
>>    pg-sz=2MB       12.92  +- 2.55%        17.03  +-  0.70%       + 31.8%	preempt=*
>>
>>    pg-sz=1GB       17.14  +- 2.27%        18.04  +-  1.05% [#]   +  5.2%	preempt=none|voluntary
>>    pg-sz=1GB       17.26  +- 1.24%        42.17  +-  4.21%       +144.3%	preempt=full|lazy
>>
>> [#] Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
>> allocation, which is higher than the maximum extent used on x86
>> (ARCH_CONTIG_PAGE_NR=8MB), so preempt=none|voluntary sees no improvement
>> with pg-sz=1GB.
>
> I wasn't understanding this preemption thing at all, but then I saw this
> in the v4 series changelogging:
>
> : [#] Only with preempt=full|lazy because cooperatively preempted models
> : need regular invocations of cond_resched(). This limits the extent
> : sizes that can be cleared as a unit.
>
> Please put this back in!!

/me facepalms. Sorry you had to go that far back.
Yeah, that doesn't make any kind of sense standalone. Will fix.

> It's possible that we're being excessively aggressive with those
> cond_resched()s.  Have you investigating tuning their frequency so we
> can use larger extent sizes with these preemption models?

folio_zero_user() does a small part of that: for 2MB pages the clearing
is split in three parts with an intervening cond_resched() for each.

This is of course much simpler than the process_huge_page() approach where
we do a left right dance around the faulting page.

I had implemented a version of process_huge_page() with larger extent
sizes that narrowed as we got closer to the faulting page in [a] (x86
performance was similar to the current series. See [b]).

In hindsight however, that felt too elaborate and probably unnecessary
on most modern systems where you have reasonably large caches.
Where it might help, however, is on more cache constrained systems where
the spatial locality really does matter.

So, my idea was to start with a simple version, get some testing and
then fill in the gaps instead of starting with something like [a].


[a] https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/#r
[b] https://lore.kernel.org/lkml/20220606202109.1306034-1-ankur.a.arora@oracle.com/


>> The anon-w-seq test in the vm-scalability benchmark, however, does show
>> worse performance with utime increasing by ~9%:
>>
>>                          stime                  utime
>>
>>   baseline         1654.63 ( +- 3.84% )     811.00 ( +- 3.84% )
>>   +series          1630.32 ( +- 2.73% )     886.37 ( +- 5.19% )
>>
>> In part this is because anon-w-seq runs with 384 processes zeroing
>> anonymously mapped memory which they then access sequentially. As
>> such this is a likely uncommon pattern where the memory bandwidth
>> is saturated while also being cache limited because we access the
>> entire region.
>>
>> Raghavendra also tested previous version of the series on AMD Genoa [1].
>
> I suggest you paste Raghavendra's results into this [0/N] - it's
> important material.

Will do.

>>
>> ...
>>
>>  arch/alpha/include/asm/page.h      |  1 -
>>  arch/arc/include/asm/page.h        |  2 +
>>  arch/arm/include/asm/page-nommu.h  |  1 -
>>  arch/arm64/include/asm/page.h      |  1 -
>>  arch/csky/abiv1/inc/abi/page.h     |  1 +
>>  arch/csky/abiv2/inc/abi/page.h     |  7 ---
>>  arch/hexagon/include/asm/page.h    |  1 -
>>  arch/loongarch/include/asm/page.h  |  1 -
>>  arch/m68k/include/asm/page_mm.h    |  1 +
>>  arch/m68k/include/asm/page_no.h    |  1 -
>>  arch/microblaze/include/asm/page.h |  1 -
>>  arch/mips/include/asm/page.h       |  1 +
>>  arch/nios2/include/asm/page.h      |  1 +
>>  arch/openrisc/include/asm/page.h   |  1 -
>>  arch/parisc/include/asm/page.h     |  1 -
>>  arch/powerpc/include/asm/page.h    |  1 +
>>  arch/riscv/include/asm/page.h      |  1 -
>>  arch/s390/include/asm/page.h       |  1 -
>>  arch/sparc/include/asm/page_32.h   |  2 +
>>  arch/sparc/include/asm/page_64.h   |  1 +
>>  arch/um/include/asm/page.h         |  1 -
>>  arch/x86/include/asm/page.h        |  6 ---
>>  arch/x86/include/asm/page_32.h     |  6 +++
>>  arch/x86/include/asm/page_64.h     | 64 ++++++++++++++++++-----
>>  arch/x86/lib/clear_page_64.S       | 39 +++-----------
>>  arch/xtensa/include/asm/page.h     |  1 -
>>  include/linux/highmem.h            | 29 +++++++++++
>>  include/linux/mm.h                 | 69 +++++++++++++++++++++++++
>>  mm/memory.c                        | 82 ++++++++++++++++++++++--------
>>  mm/util.c                          | 13 +++++
>>  30 files changed, 247 insertions(+), 91 deletions(-)
>
> I guess this is an mm.git thing, with x86 acks (please).

Ack that.

> The documented review activity is rather thin at this time so I'll sit
> this out for a while.  Please ping me next week and we can reassess,

Will do. And, thanks for the quick look!

--
ankur
Date: Tue, 28 Oct 2025 10:15:38 -0700
Message-ID: <87zf9bq75x.fsf@oracle.com>

