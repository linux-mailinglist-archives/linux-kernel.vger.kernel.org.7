Return-Path: <linux-kernel+bounces-786092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7873B354EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DDE1B61F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91145295DA6;
	Tue, 26 Aug 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="raoik6Fh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mPcTmtKT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F828725F;
	Tue, 26 Aug 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191602; cv=fail; b=BD4lA3OJp8TV0XwIZJ5qFF1K2D09Zb/NeCnZR5k8tFUSddojyZ/Y7YmkygrtNZT4TwQtgfYBAozN7rD2vpQXDDf5t0WNmYgQccmEDFRAX1zY1SBmdNuTTCJB/INfoKfMmRLkfNP8dZtbGCObgSZm3Gvy6RSv3AZDvsDIKdAuNTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191602; c=relaxed/simple;
	bh=oW0yXhKD2cOXmC7Fl8lH4YiUJCBz1wG7JQxxdWHk2xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KWva3ANJBA5pb75McBmjMBQWlL8Ndt32oFIl35UDKH1Z5NA+1W3kybTkW3hrld/9fXZSTKYy7Wx52ZmR+MSAbkT50oN6Z4pohxpK2qVfRIwcOFTGZCzfVRlXSCi/zj6wmrui7/+eqi2muqP0b4gR5z5GQ4AnylMOWG45OOIQ9rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=raoik6Fh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mPcTmtKT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6CGUj030306;
	Tue, 26 Aug 2025 06:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+gl0q1u8855rFtd+JraM/9ktIsn0pB4oHTYlgPSrWR0=; b=
	raoik6Fhieyuj16inniC9GdH71t07YC1pRx/FFWxI1NB4lxS0isGNh364PGmUG4J
	PRVwhEKwF0WffUxlB8GqHrJgxQrBFs73n6LFCgOg1WlY08rFCkZJSqJGVHq2dqfs
	rNZEZ3QSzLrVw+XFc1XaEYcSr90E/jo4y1Lu2l4FHz6yzyEbDbJCCMi5rxu7cKpV
	8DPBDJTf+WfwZvjO16tDWwj2AQXQWUE9L6nvf/RNvttsk8liMlVBf9oPGtTM0fNX
	6K7TAKONGZIO/pF5ZIMBQeLhFji0L08aJwdTggvgNTcyJDl3EgmG+u3oTebyvLgi
	iXz8K2yWD6A6UUjxrA9dIg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t3mgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 06:59:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q6OboD019585;
	Tue, 26 Aug 2025 06:59:16 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q4397qvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 06:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHOhay174hWOPSOjzUDY/t2wKTER9zyxCG/7y6I5B4PncLnybIPVod29SAnwj421yHHpxgDANB+E8TsMSvq0Rq64Jx3+Xr3aA748r9R/YRo/xIXlfxLfL6XM3rDofLveie4IvkIBm16QHnzj3ml/0FaO/TtrmWs4VKmJ6+M5crZz7wrP4gkbxrrqdH3hs0nW3GqnRm8USkqXM04WL793JuqemWAh9bR2cBJfV3ujs//o+Rs6rIaxjHBl5c4WWCv7GF/N8LnJ9XMhKbBODPBsvW/eCgNj7qTd09KlFqmeXMUTI1Jyt6lxnhob5hLSbAz7nv1KmXVr4t8wHaPp3+3e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gl0q1u8855rFtd+JraM/9ktIsn0pB4oHTYlgPSrWR0=;
 b=Pw6FKKQU6ulfv4BaqcMw0mIUYNVThnZM9aYAqfDROFDW3/yazcsQzTToEmsfYHOS4X6ckyzcvBtxPPnlLIEVp9xxtZCM9kxjaQFxZXmdOoGW7AQCpyhVLaoAbesRzG9IUicoeDmcHZb7xY2ZUM1SFEnV468+CnZpeDwQh9Aj5TZkeF8LSdqY5idgU6TwQIXy21C4jGK+Kg/sAjrOXCXdVWtnHm39MhtGHjxfxdgdp7kR/beCThDkHk9xKllesqcrrlLLkYACuXLeSiVb/+fWvS/s/IBaWsWuytX1TYgvER16Yh7eR8xnESQP2LID+gTTMDM3NE7W8YMOy7uS746wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gl0q1u8855rFtd+JraM/9ktIsn0pB4oHTYlgPSrWR0=;
 b=mPcTmtKTprn02lXx3fQSvNt9KTVEGHN9rdj7+FGhw6TNamac6KJ3k9vT9dPdY7/LiqMuzENyAPxDYFj3QYS63/KTn7lPHlqhxa0/a2j5gqdqYq4vxxbDFNHQ9XL3EJ1pXY7mXyTw+9ujvabtiSzBTGwSbkXHHi8bp5SNQAi46ck=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 DS7PR10MB5072.namprd10.prod.outlook.com (2603:10b6:5:3b1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Tue, 26 Aug 2025 06:59:13 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 06:59:13 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
        Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 2/2] mm: document when rmap locks can be skipped when setting need_rmap_locks
Date: Tue, 26 Aug 2025 15:58:48 +0900
Message-ID: <20250826065848.346066-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826065848.346066-1-harry.yoo@oracle.com>
References: <20250826065848.346066-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0204.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|DS7PR10MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9347acc0-8a37-4e7c-7436-08dde46e06d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SUIc9k8KFfzuBjlcAo6NuwkTKlGwgBzz0yiOEJSbqelkcZiPX9vFRj4Zj0Pj?=
 =?us-ascii?Q?KUuBxxw7+ufuSIJIMC19NxMWW7lb1Q7plT/CuxRynocN2vR2PAn2kEwhSNnk?=
 =?us-ascii?Q?ZNRqXPgaNM8tgoSycQGCVil3ltoRH1x4FscD44NyIMBxBJO1heCQG7K9ebNf?=
 =?us-ascii?Q?p96JUz9R6oROPPySGw96Rm0yOHRwqJ1rVvFtR8Sj+xobBR80dl12uAFRAOld?=
 =?us-ascii?Q?VBpGS5f7tVwKI8a23dZOPH286Khu4tVipaBJXGXcKAkVkecCACwzKWZ6BBct?=
 =?us-ascii?Q?XLqgI9ICGBFnoA45Uj98/piBzMWP55hPujR4VexEqCOy7F0Z81PkD0dAZIW9?=
 =?us-ascii?Q?L1qtZ/oCHso9qLOVlwTOPPCk0FHiNJjGSlbpYDzhqKKZgfnYBajEwTr3hekK?=
 =?us-ascii?Q?GrKRu7yQEshrJIrLFb4vzozZrVEoO62r/tZLUmfTvuUurDo4EiOHy5iB2NPg?=
 =?us-ascii?Q?PKXDxqrYivifWPXjZ+OgEpe1jue46/QsSZkmVAkxFUYoSqo5numrZOunezC7?=
 =?us-ascii?Q?o5v8DzFi1Zga7lqEivAzchHsPlrKmSYh/CzsuL+NvfyNQRdqbRKk1C2Iw939?=
 =?us-ascii?Q?14rmo3tUEv6B/rs4ZXIz95FwPe1RaAMHsLNnCeNPsIR3LpQ4HH8Pf1VG7pg5?=
 =?us-ascii?Q?LUASv8g2AyS6PY1fBQTe/twdk7WjYc1DRSFWhoW08g0fGGS5N7y8QvCZsqEi?=
 =?us-ascii?Q?SFoXF4SXOntCQtC5m2hPyosLg+wO0TbAG14W8XnDwHjoc0FHj9CqONgaPeWC?=
 =?us-ascii?Q?TFUREoldUNk0NmY2WWjSDoKLsUcggorf5+/JycByX8WALtX0eE3EK3hc9SaK?=
 =?us-ascii?Q?3MCvqCQ9BWWKKNAdGJ+9JWzkoK/nnl7KZvP9ynuupgEGMki8Mr8hCBuY9mmA?=
 =?us-ascii?Q?Xsdnjv9xTlB7SfunKjwNwZT9Yc29RoUfCW50eqtGLYDcZlT8rYffh8ABfiZ6?=
 =?us-ascii?Q?tYBS0xgdnXvmUXXm6JhbcnFEIka/1NnJgmLG0Fp0LsgA28oZH9xJ2GJRrkxM?=
 =?us-ascii?Q?Vf26EB38tw/lC0CCaH2E+8MZWSsUlwEGkB+9KUyY6F6ElxeLZ/6jBSGW6KgL?=
 =?us-ascii?Q?1clmz5R2pYvbhaujQOzTCGE2Z061+xnf2qL+uEXYribfZkXNxjVOLMl5AEJ9?=
 =?us-ascii?Q?PhxW1O6bxf7oleCPycp4PusWGKOvexcqX2k5XA2oALZn8fL0qTe+Xb7KZZbl?=
 =?us-ascii?Q?krwdNSXbqLS7UhIZvhaipx94wXcken1n9J+pECVknBqKDeejvmye2uDDrdoc?=
 =?us-ascii?Q?dfUQq2+/lye+VqWeIBGhvfinfQa03255JOVBkpKFNf41APysG9/s6HMse0nW?=
 =?us-ascii?Q?2Uf9UwcFgGWZ9GyH44nWxrYWZXJZOAz3vwOobFPKxVd125tkkT3CuEqhEuQA?=
 =?us-ascii?Q?OhaAao43BS4PlblpnHlArTf8dilV0GJ6pykeKWXgMJj4AWwynpB/J0XeyUGq?=
 =?us-ascii?Q?b0h7H+p8Pfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ikkW9eVRlbz8BwTLA6dmT2iMkqx2g0wG/2lHcenLr2C7slskbSmf1zP90C3V?=
 =?us-ascii?Q?RItR9lA/7d89Q9E7XJOJTi8QgfaxuiQHUZDY0ASPBOugUmuHQyp2DqxLdbEL?=
 =?us-ascii?Q?rL3/6IGLQf3Ale60omF+Lr58zhHCgzJuruKm7nMsL/h4UxNpWGOBrriNMiES?=
 =?us-ascii?Q?gka+Sdg8zv/Ngjxm3RjXgyAHx8ldQevjZ6pYrTb3veZrvNmwQ6ixz+xCGmgY?=
 =?us-ascii?Q?Y5Arv3Qd6TC3t2akPuMf8qRjkS1flB6UGIZfGa/sQxL67CUtKPESOlP7P6CW?=
 =?us-ascii?Q?X538ozsOYd8GVSLSYUwa6GSiRxJR8JqU5R67FiAnJzi6g+DZabPyp4gdPjOc?=
 =?us-ascii?Q?QwXeNsgjSdPQGN2rSaQq7UBOidv6l6QU9GOSyYzQ9R+ymCXl1ooqtlfZUypQ?=
 =?us-ascii?Q?buFYwU8sH373FrKBCPO6fHwS7ZGjTojjzXmQHqZSugpcDj+Vlxk5YKMKzHap?=
 =?us-ascii?Q?PX4h0cjwsYe25+zGqJeuRBaj8kEhT6Gnmr59mdQlMjK6YU/bh3KCtg13kmOs?=
 =?us-ascii?Q?cOTio3NMPpmL5Mluf537kVXAT/pv3ey6AC1Yzu/PRgj82VWvN1dn3sweLHnw?=
 =?us-ascii?Q?JGKNqnwGoDjUJzCCfWXyZgG7LneJvmk9dtNwfbbccdFCvKC8zhIOh3/fWd96?=
 =?us-ascii?Q?tNuaK8RXmen3QjPrTOl4p3EoxiEoVepjBMOFn6TKLtqWN1+fYtFknmmNNJlL?=
 =?us-ascii?Q?b3gK8D2C3NnhvzpY25345GI8cojx0Ozk9fNX1ETNu5MpgA3+0RWYqxaBlRCF?=
 =?us-ascii?Q?mpPq/8HyHxZH7U9ATdQDj+vGVPUMafQcgZ7xAYrUAHlXCNh3icXlxy2tc3pT?=
 =?us-ascii?Q?e6+wkI8vfnEbUxSfNakQez0WYDEFoZ1+xubpGP6bHUEUaUeKvlHXaFxEx9uF?=
 =?us-ascii?Q?HExRk5wMEdyZRldWP4kRs3CD1gf3S21GTlK6oHIifGqKTq3LY6of+BcV01Z0?=
 =?us-ascii?Q?K9xPxBAHaFbwNbJlVXls6rew09yqanwI165FH/QJuGNqWFxJz9TKw2Z+aL0S?=
 =?us-ascii?Q?3EcyTxZfO+SfNnX1Sce0kgqW5JsKBFsF4v00xzZb6z3DIRh4YOHMJ0zjbZvz?=
 =?us-ascii?Q?rfMPBWtN2SHZuI16/cH7wwm6VXaEzth22N//4mrFNEPgTmLcw075ElSHPKs6?=
 =?us-ascii?Q?hHEeHBEdytF6IgzYR/dF7TSSJQZGLaVj3xLYHMqY82O9HfiefWKDa7fNtvJb?=
 =?us-ascii?Q?hB4/DqzyfE7t352Ne5YTAB2/8fJA20z5tF8v2Gcc5d1jpiJFXffM49iRfSwR?=
 =?us-ascii?Q?Q3GjiZnCnuqbz8rsPGLDrNwxND2NccLpaUR9EEWJ4yCxmCgiQ4GmN+ZTnrV2?=
 =?us-ascii?Q?MetAHgxU3B6DmrFGH/aU+srycCkGY7kIghWBDkK0HLJCV3HdTdH9F8y+pN4W?=
 =?us-ascii?Q?uHYlyvq3qWM97BgRZY1oRbHxV3fsY2SBB3dNUeUdG8IjfY9vOE3tujf4Ie4J?=
 =?us-ascii?Q?1Wt0knlqkTLaTUvNtyNbe5hS04MjS/Qk3zWEeeJyjnUWtmum5wQ08CzQRILq?=
 =?us-ascii?Q?3KR8cmwHibAKlsb9OuowzKbsxXD2ki+6/44cQTe9JpaytrIAxP/SdbnLxFqx?=
 =?us-ascii?Q?6QZFtcHwjoV04zp2uTNUASxYqICFB11ADyiX0gbw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cdMudDhNwkqsGXcWCoxZZHKM1hX64UayZj085qEN/6O5q6CrPiM+mOh2xknPOrqbZoouACvwGRtqhilOSafygs1UTNFRUBFNVebfx0ndx2wJU6p+A7Y+qgvr3G5IMPQjul1YdjxjTydoHV+T2UWQPjGrAbNrZFSGNC0f3cDqMMmWxT9Q0mw6GrgardobUqSX/ro0mu9m3rjbpJ+Z3XSuj/lIYZergo6UYbm7YQ1Xu5VgH7Z2BV1YkXW1Tp+1wMzmvHCgiZsRQJA6iSvp+Q/vkOIpHISObCBuV30I71VIgr/f8Mpl/qLID1EvTLquBHDtFGS9kacnAhdteHSO+7edWHTeENutroCohRA4T4q6dqm0kMYFcaHjcsk0tT8qF5ovKsE7nF+H5J90mHzogmJlBNW/4OhJ9Aq2nvIFR44ohVgneQc6WM3ubWhf5n+kTpTx1lKnBlYEUlq5BpdANlg2bB8aYI4Qf7S0Dcw5MRBzenUJqZN/ax8OBK/0mcCiAOPS/UXQH2aNQKkRzush0ar0fujcU75UDSoLeG/2FvjQbSSVTxI4u0a6Hvpkvm7XG1Y9wUsFux/MhHMBpE2KkTRb8XHzzWvY6ufUgfD16WUWfxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9347acc0-8a37-4e7c-7436-08dde46e06d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:59:13.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmjV1GevEUKMhtEgxOTYWQuL3kvomRymED6sE38pee/ql70dETj3Nx0A26Dfuf9YYLasLsytA/UFwgybj33Vrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX/AIQzFTgLSx4
 swJxepSdg+JRmnOYwrGaUo8ArZ0/NIy08Bl0FNnEDhYtt7YV//P7Orlt767GT+LiWhNIo83xRpr
 1q4q4MNdX51cOm0Nf5YQmIa2kO3RNBv04cUtezHPuKecu6/ztJzrDOQ41BnegHOD9p7k4+qMF1H
 7qK6sLvdjMi8pQePcMhLW5E+Hgf57Cb5MtdXp33sgIvDzgkwyQ+2bZkdLN0eg07srxCOw+W20nc
 Bc5l4V9ovD6e8dLNb2q/7BAdfSdoYQnoX+Kv2lBCBLFvKNjr9vlax77AS3rWwF7HuCUzSOmKkzu
 7uGF/6M+XDUY1QCYiX6NFPcgylg0jH+dFnEWWF0nJJsD6Ld1Ofosc/3SaNswc01cX1gdBRfPqwL
 oK4+dPSQ
X-Proofpoint-ORIG-GUID: LH-bRcoUrG1PJSxHbAX7oepD4cc2NdTa
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68ad5b45 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7tFTlA079eH8DfdtcKoA:9
X-Proofpoint-GUID: LH-bRcoUrG1PJSxHbAX7oepD4cc2NdTa

While move_ptes() explains when rmap locks can be skipped, when reading
the code setting pmc.need_rmap_locks it is not immediately obvious when
need_rmap_locks can be false. Add a brief explanation in copy_vma() and
relocate_vma_down(), and add a pointer to the comment in move_ptes().

Meanwhile, fix and improve the comment in move_ptes().

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/mremap.c   | 4 +++-
 mm/vma.c      | 7 +++++++
 mm/vma_exec.c | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e618a706aff5..86adb872bea0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -218,8 +218,10 @@ static int move_ptes(struct pagetable_move_control *pmc,
 	 * When need_rmap_locks is false, we use other ways to avoid
 	 * such races:
 	 *
-	 * - During exec() shift_arg_pages(), we use a specially tagged vma
+	 * - During exec() relocate_vma_down(), we use a specially tagged vma
 	 *   which rmap call sites look for using vma_is_temporary_stack().
+	 *   Folios mapped in the temporary stack vma cannot be migrated until
+	 *   the relocation is complete.
 	 *
 	 * - During mremap(), new_vma is often known to be placed after vma
 	 *   in rmap traversal order. This ensures rmap will always observe
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..3da49f79e9ba 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1842,6 +1842,11 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
 	new_vma = vma_merge_new_range(&vmg);
 
+	/*
+	 * rmap locks can be skipped as long as new_vma is traversed
+	 * after vma during rmap walk (new_vma->vm_pgoff >= vma->vm_pgoff).
+	 * See the comment in move_ptes().
+	 */
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
@@ -1879,6 +1884,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			new_vma->vm_ops->open(new_vma);
 		if (vma_link(mm, new_vma))
 			goto out_vma_link;
+
+		/* new_vma->pg_off is always >= vma->pg_off if not merged */
 		*need_rmap_locks = false;
 	}
 	return new_vma;
diff --git a/mm/vma_exec.c b/mm/vma_exec.c
index 922ee51747a6..a895dd39ac46 100644
--- a/mm/vma_exec.c
+++ b/mm/vma_exec.c
@@ -63,6 +63,11 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	pmc.for_stack = true;
+	/*
+	 * pmc.need_rmap_locks is false since rmap locks can be safely skipped
+	 * because migration is disabled for this vma during relocation.
+	 * See the comment in move_ptes().
+	 */
 	if (length != move_page_tables(&pmc))
 		return -ENOMEM;
 
-- 
2.43.0


