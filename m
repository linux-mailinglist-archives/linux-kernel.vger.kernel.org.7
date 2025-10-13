Return-Path: <linux-kernel+bounces-849911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D4BD14ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1523B3F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE6274B2B;
	Mon, 13 Oct 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="NCsfCh5y"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B814A8B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324631; cv=fail; b=PMA8y430Kdm70ozuuCY5Vy3QSHWjk7UVOW9B5yvR0VD44yFVu3gdTypEUOqWHdEDDUx6d46WfhuGN8aq0kfuJBDprIZJ07gjUrBb2nsMT2yWzgAiWIBA2x7mUlJnSpuqlKTLaHdKgPKcVb8rLtPA967XiUkyBvJqaTAvQBplXkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324631; c=relaxed/simple;
	bh=HDEpHyJOi9nlFxWNUqDM3Z1q8kb0j2v6nPiUFGfWlCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7gH3RVA0F/OZxfZ0MlI9xAvfQdy6UaZAe4/B+lYpDKKmBc0tEafc1RYZP7Z+C+0ZslR55rsXLIQIm71EqZIemKPtHWELUD5pbFuAl5zR4hkRs/kuzOT3uL5+EtT3qqltIjVL6DcVvxhdOtkGSBe8cz++gYQrDiMW6D7EMY8fxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=NCsfCh5y; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59D1Z2G0946523;
	Mon, 13 Oct 2025 03:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Byt6ZUazXfx5h/KRuDBN3QDC9XBF9qDoYkWjD4gXGsU=; b=
	NCsfCh5y7Zb7HcRtjuNTe2YJuQVJy5qVojaVKekBlUDClZ0kRbQWZCQhQAolNVoQ
	mQIx9gMcUHp4OpH9twng4M1XG3mXjd9S7gsHTq5S0u4Oid8l20IESgPySciNEFdJ
	e2sZtwIoj0Dy6vt3JMdz5MszK94GY9bvP/AwBntYvu+McEbvi0VT1+ZwtznOv+Hw
	rP/D06XzQ9tA4tErOKbaal6t0U4knD9c+M5qWTWQ+J0ACvTdc1H3RZveYc2UAFqZ
	K/O8kwkuLMk9lCnIkU1gfoKDsVLjFiEsditPL1wknWRcIcPrmSXxdWCgMgy3LHJ5
	3jk7ZODFHPGyuPZUhYrRcQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qcewhddw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 03:03:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7q5q61m7MURasyKHp5XxxWkDoOqh9RI8NDejXHyST78xrsMcaaKKGzyGxtlxPnUHlkt0IVupSu959l2tXFfWBC9tiObls+9ufhX/1Aksf3Eh1KK0ePKoO3CW2GjORAEt4IOJwXZEwOW5DquU+mMl19ZqCryHuJ5HGa11jG+eyUilpOe7PCRmuBDwwk5ZvPRG4HrW73k4D2ijlnUdRQQmy5jqa1Y+9B4NiaCpu0lPUH/GFmPTzVspN7eGRmLhYlmhZRJFWlVWYKqsLDrdL0CcVsZ6Woy/BiIskRpwB4XAqv9pcoDh/1CYl+JAfcMlMop6PLV0noFEmQEk8hdfyN/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Byt6ZUazXfx5h/KRuDBN3QDC9XBF9qDoYkWjD4gXGsU=;
 b=FGqHDoDcwsUEiidnWx0siyKHgwsNJJ0FiO4xb4V7rtvwPzKtjjRtYH8tjl0SBmeL0PrwMKzGsAF7m7kxdqerJ7ycH2qHQ4PfPvSn6j2MCp1+vNb3KDiugevzOqosJtZODecOSMH4104srlPNnTMf0OMKfWS37KriBovzRT3XbVc///z9VsYi10Y+InstWYzDpUkULQ86Zz9iZGzbwW7g3xxLyM0HNIPmoNAAfJsiMM45rk7jpuA1H3UbnoB4AWDpFZzDVsebydkdxkkEGO03WRvypzlgJVzz0Kdmph0aqZnptcaPEhDewOYx857m+FyGLMJRsDGFIgapGv/eei1jEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:03:18 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:03:18 +0000
From: Jiping Ma <jiping.ma2@windriver.com>
To: jiahao.kernel@gmail.com
Cc: chris.friesen@windriver.com, jiping.ma2@windriver.com,
        hanguangjiang@lixiang.com, linux-kernel@vger.kernel.org,
        osandov@fb.com, peterz@infradead.org
Subject: Re: sched: observed instability under stress in 6.12 and mainline
Date: Mon, 13 Oct 2025 03:03:09 +0000
Message-ID: <20251013030309.2176524-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
References: <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6b8bb3-325e-48e4-921a-08de0a050f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRKx4O8lSwh04/sXm9PoD9DtKUm8Y5lqGgnShTEHHvkthx2j10ocsxVcx1Vk?=
 =?us-ascii?Q?CLtowiYAYG44flg3VTtWQdXoqSfj5FIVqE/0OgARLUO0Bpk0TzcPQmWmXyMO?=
 =?us-ascii?Q?JmrZ1WbsjoC4SXeLLd886vVbmOOB2jLzeZdtVxOfG9w308Vxc6J5A47gi8rT?=
 =?us-ascii?Q?MqKVtJJQXtFd+xtdwjdJkYiHsMrnrfzvTxWPcWkP1IWlqABvVDcXzHofQP+t?=
 =?us-ascii?Q?XZ2KgrUetmm8Pein1ssvfkn7PYRrdw9hDzH05Ey5N5hjltWioDbXP01g7IDq?=
 =?us-ascii?Q?LOIQJ/n5Kba9MiKbnAxuP/z+hCy4dThU4F3/WcxfMbH+gd8JXzFadVFayiLj?=
 =?us-ascii?Q?jD3JTzdAeh2n5pKWSEVODkJUEaanaUKcg2ZkuWiXR1oGSPHf8BjPs6GdcSFf?=
 =?us-ascii?Q?dL0xnaJJRMWssCbKK4Vmhfo+ZhGrMVEsa/JvsGIZNmVnJhRs7gB/H7tBo/GJ?=
 =?us-ascii?Q?D0uHRonlfh3EjW/I3SvL3QejF+cbefV6m3y0UU7GyElXXt7dzJxT7G2RhVSu?=
 =?us-ascii?Q?YJdn2/gugMCZCgl6TZjNZl2vZcppZNSqfnM1/TTE6afD77IrYNs0cyFfq5jd?=
 =?us-ascii?Q?IrvF16V8dVzGfB8aLP4WOt9RYsgpBDozFWLI9h/Ho6v1uJIO03Ut5T7E9DK3?=
 =?us-ascii?Q?fRvWBxmVUtnBduKSbxFxftAFNGkdMuqfySp/4G9bw8HUtnZR/EjTzGGec2xF?=
 =?us-ascii?Q?W8S//HWE6b3owEYocneSTM3u/T84NYUjcNP8yKACuUwa7lC/UCPz9KIzRrSy?=
 =?us-ascii?Q?AQ/iVXSS4cYikm8nMpABTtX5YJIBK7dZ3kPHZc56MJ1PjmZpgU3Bhvwf2FHY?=
 =?us-ascii?Q?UUfH/QHaHPTsVrT4gLjK0x2AmDJfWtUL4uPEFdJUkgyHWl0me/2JuwO2A/1a?=
 =?us-ascii?Q?M1UqdkWT4aCR4RpNGxN1pUkyPRAUiyxZoX2X4Zis7AT1ftj/lmopLcwYdNV/?=
 =?us-ascii?Q?3ER5MR0YZTgl8XeNCZsXi9JbfcCmLiVa1fudhQ3L+mKAPTJcP/sOvbQgxeXR?=
 =?us-ascii?Q?dxsdEAKShtW2gyG3Bo9aTkTonh87rg997O6Hva9VZ76PF1tg15bgHPPmVz+k?=
 =?us-ascii?Q?6ITlfzf4rs14aIwq/Q/vZA1DjbINh25UUyS3VTl2Kevg+uGOifMMIGQslL4U?=
 =?us-ascii?Q?a1Y4jjTRkYJps1R3LUDXGtqreFso4lo+AqDBSYiOBygDPcLE3DAJygtcMXv3?=
 =?us-ascii?Q?6sGtlgMjF+zU/KaTh7/yNXRSjBRrwl1d6WoJTz3oBlz/k2fDqbg/nOPmYJSM?=
 =?us-ascii?Q?TdPgrsHK2JOy64AeLJ8rbDK069mf7X7cevEBHAJUOiHLuOZCjGUUxcgo8pPn?=
 =?us-ascii?Q?K4CNL0s/uRIUmu6ot6DwjnHMXhlD+vHw8c5Mt517eNQO7FkwE8FOCMB19m9x?=
 =?us-ascii?Q?igGt2vZTYd1T0788zUfZCdZ8IgN93bbBTyKZ6RkENnnTjdl4caxBs2Mll1tX?=
 =?us-ascii?Q?c1Egp489t1yuC6vBFZWYP6Emxvj4pN2T2+rXdqdSitIl+rluLHaoW4ah0zAi?=
 =?us-ascii?Q?CYZQqCEn5vTsBeDGja22FbM/O6mslDYY5+xBKHJfmX3DLdr+pPTMU50TSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dvAEE5DjWYOMK0i44U57RwlL+vsOkiBF3c8lkbhhFTXk2KOIs6LORILUEd/?=
 =?us-ascii?Q?dSn53orpnYCdCaKg2+1D2JYprbYx4G6vdu8IKEhTku80McB3Ejxrr0HpOjQg?=
 =?us-ascii?Q?VQ83ynMd8m4v+6DTNFW1rHt46Yz/ySwF2GkeBcCfX3ewxKFco93hmtDB4xXf?=
 =?us-ascii?Q?KBCE/QOyVnR5gXFhD76q6CuFTdttCjVvN1iigQWOZFRWGgP3urahySCuRbrS?=
 =?us-ascii?Q?CJtBhEZ9qHFc9WdSkbxBIkjOLgfGnircsx939xZGl8MG/BFk14rldjz2mdUZ?=
 =?us-ascii?Q?Zr9idca+wOzxmpedBeDgcPVo+tGhuO6FqUvsnV1nBQtZn3+pd0BrA+Wz/rcI?=
 =?us-ascii?Q?fNGTwlN3MdAv88f04ZNqYZzjV0P7jA66tCd6sI+OtWLsyAEJNAAXa2GMmEwm?=
 =?us-ascii?Q?b6L1dBLbDgxrq8Ml1pRk6Nsk8dd/v1hEnp5ztI0P/kGiR1NYkNiKixQGXWqk?=
 =?us-ascii?Q?/N9oiVGaemk4KvFWtUHUZk13Z3dzZb/xmWpFu0OKXYTriT2YFA1ihsel3L2W?=
 =?us-ascii?Q?ZlMVmuBtZwsXScKjPGp+OXJNQc25GaGCj3yAI2PlNL8GSMlfCE3HGcIzG3Hy?=
 =?us-ascii?Q?0lEgw6m3MtqtCC431VFBiHmq0+KDtMyLLHqk3Hqav83ulQrlpzn1dOI556/1?=
 =?us-ascii?Q?c8vPY+EgNqg5+XM4ZqsZZY2jy9CC5kHHYUX6rJjai56HZ19DMfmpDtGvNu7f?=
 =?us-ascii?Q?4wCoNNP9r+y7GyIzlFAr1yLhy7VDrRJmFL5nJVcSZsQgQtuTdwZLiLjtvDvG?=
 =?us-ascii?Q?Z3lZbDnud6qGf5O6USuaspr/Z2Dc1f25gBP6iw+WCguha7R1McX4Ts0gY+0T?=
 =?us-ascii?Q?gL9W/EJjBPQkh1D59HcV/tGZOFTQ6g3PDSRJf+hFBg1rDAyYHWVmwThu7fDf?=
 =?us-ascii?Q?zJkgmjzUssjGou3q3gaiBvQbQoTQ7jrYd6gKu/ksFaDmTKR0ylv0BQPIDL8u?=
 =?us-ascii?Q?tO7/TEZZ0PB712O08yGHn+74m1JabgGlnwWArTePaWoMMIh1JKIuqL1mWZSi?=
 =?us-ascii?Q?JAYosQfvTNXiiP7zyGroqHeffwRQbBesUamPIaT9ANVmmcVUaU01PIWNSg+f?=
 =?us-ascii?Q?HqDGDmZ4zoqo7lSx0ov72Tlnub3OUuHqT5gkUefk6WGJbhYLT4w+spFUwq66?=
 =?us-ascii?Q?H4rR6Jd7qTBXsxrG5OMSuCeqTMrHNBK/6C5JjAn18eFEU6JkgUyJhqKu/WKo?=
 =?us-ascii?Q?W1nxkkkbZMN+9h5eOHz2Ba1iMDxCMZcLr4zsfuTJmITxX19i7oBknpF/K1Ly?=
 =?us-ascii?Q?36DAy27fV9VKMLf7ZMv8iw76XiajJWlXne1zCr0T+N4MY99nPywGpUKnElS4?=
 =?us-ascii?Q?9dLTEZroVpYhdCWmrnk5Omd/vjSrGmHWVOwupupos+uh7HdNU9s8kkZbJufR?=
 =?us-ascii?Q?7lEL9N7Ysf1+D2USYwW4cfeNZ2yaxy4nriY8J0EgHmpzA8S0vCmVrfSb6oj2?=
 =?us-ascii?Q?NF8S/y3wFtw3yyDo8nkmJ3uzs/oPYMI9qqJnS7OS7fk+3Z8oxEXBdHzby7Y1?=
 =?us-ascii?Q?/8loqLviR7n4GzluB8G8sZWPifPLP5DwpXvFnx9IwwjeiMomV+dNiqI0REPq?=
 =?us-ascii?Q?9m9/B0FlGEzqVBaalgrAavVqhSTytxXGdSG3/Z0KRIy8++IxBWNENb0xqZt7?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6b8bb3-325e-48e4-921a-08de0a050f42
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:03:18.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMg6nkfO83kK+8WB7XrUhKDI87BcL+FcB1fyf63AG9VvHL7/wEwlJgWW8st5LlZ1MTPcOeS8SkdzEc4QvEAY75Y4YxS0V1S7WTcBUXRxqTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-Proofpoint-GUID: PBjUBpeUht-Nih85lBlGplGarVsXcDvy
X-Proofpoint-ORIG-GUID: PBjUBpeUht-Nih85lBlGplGarVsXcDvy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAxMyBTYWx0ZWRfX7gpCiwZq1zWv
 N3GUIafHeodwr8dNhN7Sir7biI9JDjElJ/dNoYTcdDXQ5H0MlvVALF4OjbkjQqznXkl5PSev50x
 P2o8UWubaHPlachbnR/+Np68A7vJD+RqgVVG7jl7C8BvvdQtlh/XzWhfePZY/bcrksGanOX/ZBi
 7m08AH1ah4jSgFMFl87O2Ar42EmK0+652IDKdXujKAJiTczk6Qv8GoBIPKvRbmPJEVANpP7D+99
 egEv8nPLElK4/Nv5X++MrrsXva6t8qUBJGt4xaZhMWp2AFQml53a9XXbbmmLgQBZ0rHmYa+yU6w
 Eq+XyWdjGusPyHlLYb2E2YzAxfaT71mmY/8ykpDteaLfbF2t1Vm0aRNgib5ii09rG/brJ5SqWDu
 s63P7W1gTj/BlxYQac7AXWhOnKQGOg==
X-Authority-Analysis: v=2.4 cv=M+xA6iws c=1 sm=1 tr=0 ts=68ec6bf8 cx=c_pps
 a=Zn3nEQaGnpTLJDFXYNee2g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=p0WdMEafAAAA:8
 a=dZbOZ2KzAAAA:8 a=FAi8nJ5GjmawcuvqnIAA:9 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510130013

>> Hi,
>> 
>> I'd like to draw the attention of the scheduler maintainers to a number 
>> of kernel bugzilla reports submitted by a colleague a couple of weeks ago:
>> 
>> 6.12.18:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220447
>> https://bugzilla.kernel.org/show_bug.cgi?id=220448
>> 
>> v6.16-rt3
>> https://bugzilla.kernel.org/show_bug.cgi?id=220450
>> https://bugzilla.kernel.org/show_bug.cgi?id=220449
>> 
>> There seems to be something wrong with either the logic or the locking. 
>> In one case this resulted in a NULL pointer dereference in 
>> pick_next_entity().  In another case it resulted in 
>> BUG_ON(!rq->nr_running) in dequeue_top_rt_rq() and 
>> SCHED_WARN_ON(!se->on_rq) in update_entity_lag().
>> 
>> My colleague suggests that the NULL pointer dereference may be due to 
>> pick_eevdf() returning NULL in pick_next_entity().
>> 
>> I did some digging and found that 
>> https://gitlab.com/linux-kernel/stable/-/commit/86b37810 would not have 
>> been included in 6.12.18, but the equivalent fix should have been in the 
>> 6.16 load.
>> 
>> We haven't yet bottomed out the root cause.
>> 
>> Any suggestions or assistance would be appreciated.
>> 
>> Thanks,
>> Chris
>> 
>> 
>
>Maybe this patch can be useful for your problem.
>https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/
>
>If I understand correctly, we may dequeue_entity twice in 
>rt_mutex_setprio()/__sched_setscheduler(). cfs_bandwidth may break the 
>state of p->on_rq and se->on_rq.

Thank veruy much!
https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/ can fix the original panic 
https://bugzilla.kernel.org/show_bug.cgi?id=220447, now we encounter the other !se->on_rq WARNING.  Do you know
we already have the fix?

Any suggestions or assistance would be appreciated.

[ 1461.107139] [  T17007] !se->on_rq
[ 1461.107144] [  T17007] WARNING: CPU: 1 PID: 17007 at kernel/sched/fair.c:704 update_entity_lag+0x7c/0x90
......
[ 1461.107339] [  T17007] CPU: 1 UID: 0 PID: 17007 Comm: containerd Kdump: loaded Tainted: G           O       6.12.0-1-rt-amd64 #1  Debian 6.12.40-1.stx.130
[ 1461.107344] [  T17007] Tainted: [O]=OOT_MODULE
[ 1461.107345] [  T17007] Hardware name: Dell Inc. PowerEdge XR8720t/0K54D0, BIOS 0.2.4 [X-REV] 08/11/2025
[ 1461.107347] [  T17007] RIP: 0010:update_entity_lag+0x7c/0x90
[ 1461.107352] [  T17007] Code: 0f 4c fd 48 89 7b 78 5b 5d c3 cc cc cc cc 80 3d 63 cb d3 01 00 75 aa 48 c7 c7 62 b4 8c 9f c6 05 53 cb d3 01 01 e8 64 a6 fa ff <0f> 0b eb 93 48 89 de e8 f8 a3 ff ff 48 89 c7 eb b9 0f 1f 00 90 90
[ 1461.107355] [  T17007] RSP: 0018:ff77b604c779f828 EFLAGS: 00010082
[ 1461.107358] [  T17007] RAX: 0000000000000000 RBX: ff4e7dface2ab000 RCX: ff4e7e183baa0908
[ 1461.107360] [  T17007] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ff4e7e183baa0900
[ 1461.107362] [  T17007] RBP: ff4e7df9c8e7ee00 R08: 0000000000000000 R09: ff77b604c779f7b8
[ 1461.107364] [  T17007] R10: 0000000000000001 R11: ff4e7e193edbb0a8 R12: 0000000000000009
[ 1461.107365] [  T17007] R13: 0000000000000001 R14: 0000000000000000 R15: ff4e7dface2ab100
[ 1461.107367] [  T17007] FS:  00007faad3d1e700(0000) GS:ff4e7e183ba80000(0000) knlGS:0000000000000000
[ 1461.107370] [  T17007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1461.107372] [  T17007] CR2: 000055add20c7000 CR3: 000000022b1a6004 CR4: 0000000000773ef0
[ 1461.107373] [  T17007] PKRU: 55555554
[ 1461.107375] [  T17007] Call Trace:
[ 1461.107378] [  T17007]  <TASK>
[ 1461.107381] [  T17007]  dequeue_entity+0x95/0x600
[ 1461.107384] [  T17007]  dequeue_entities+0xc9/0x590
[ 1461.107387] [  T17007]  dequeue_task_fair+0xd5/0x1f0
[ 1461.107390] [  T17007]  ? sched_clock+0xc/0x30
[ 1461.107395] [  T17007]  detach_task+0x36/0x60
[ 1461.107399] [  T17007]  sched_balance_rq+0x77f/0xe70
[ 1461.107404] [  T17007]  sched_balance_newidle+0x1c8/0x430
[ 1461.107407] [  T17007]  pick_next_task_fair+0x2e/0x3c0
[ 1461.107410] [  T17007]  __schedule+0x269/0xbb0
[ 1461.107416] [  T17007]  ? hrtimer_start_range_ns+0x2e1/0x460
[ 1461.107421] [  T17007]  schedule+0x23/0xf0
[ 1461.107424] [  T17007]  do_nanosleep+0x65/0x150
[ 1461.107429] [  T17007]  hrtimer_nanosleep+0x7a/0xf0
[ 1461.107432] [  T17007]  ? __pfx_hrtimer_wakeup+0x10/0x10
[ 1461.107436] [  T17007]  __x64_sys_nanosleep+0xac/0xe0

Thanks,
Jiping


Thanks,
Hao

