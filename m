Return-Path: <linux-kernel+bounces-756188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86702B1B10B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F196B189EBC3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF349251799;
	Tue,  5 Aug 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZgpPJgXC"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013008.outbound.protection.outlook.com [52.101.127.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F421CC62
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386196; cv=fail; b=WDyeySnuUnKvj+q6flW3WKX3es/8llogDG1aRHXx1liF+XTVU8XYxhKMtl+Tp/AVRd9wKaN5BF2YNdgHxTGplAfYle0XKkME8qPdK3UX6x5DfbUnkI7jnIxPSvEiR2q+k+NjWcy8P/Q5bPqTr4jWYNdqFu319OuZh+ncxelQmsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386196; c=relaxed/simple;
	bh=Oz6JeiNHjyAOFvEpaflqKAclhKevHSCONIhijt6/UtU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XdwLWKkqdqTD0Ogx2PIxJBFGRM7x4F8yADXPhowbqeZe7/eC7uSy5XtRmgbAURcNstibFG6ezKOAMU/kqnfhOJNUHYMA4W8Uol2rp+bJ1AMBVu/q/nSSipW+/UJenJHZKqhChOHQY1P6qFC8sshyT8uF5h105bcm9aOXFCO3Ex0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZgpPJgXC; arc=fail smtp.client-ip=52.101.127.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqBNC0DajQRQ9MbNW58hs11aRdrytOr9wcUd/fWojtA3bryBRaoTmN+Ii7YYTbJGni9Iu3dYwNTHm6aZ2GCIM6dk4tSSn28TrdHDnILk+yJOlZfHsz9xuuwxPveCO7SV36BDM3mxTiNCBTUISyO7FQAXq25aMf5agm6oSIjfwJgBnV8njhtCGB/AJzPbDUYIaRnk3RjZ26ecx13vh7k9kdOvAg5vg5rEnwDLcdJEem+pUM1qDCyHnNm0sSKs6sROCFedTuTLe/F+9POIIm/FQC+l6B27QMH/pzLTXdnR+1mzG5XoYUAHZ6AIMKJi/Q+Zo8LWk3MbdKo6WDjqBSEeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv9pLKoB5WVSMtqUTNi/4oT14DquUB3LxGFLSbVV9bI=;
 b=oAMGfuFj1vFlSl6iKht3HXNx3u651CrxXztsBsX8eeSH60Nj8swHUmnjpPzb6WVW7UnPR52WnyTtK+/Req222bT2UYFqkNBNo5lnlFvjU3pxL9C9TgERu/+A0gYuAIJeb+Dc6sAK72qmpYMEkU1viUw8mpcF0AJH8F1o2Br3QMZJZXlcxrMaHJDVyP8vjgUBvyouYd8tD8is4DPWQdLUnl1rzLleXBxpJhwOlxkTly0z+zovRuqID82b8jxPJ4M7QXFSEtyKpMJLhQRYZ2S1x8eLyCCEV/Ffe/suuKsmE+WmosAchkYX3Kx9o2bViiVtMstKMQ+C3vhIzNkq92I5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv9pLKoB5WVSMtqUTNi/4oT14DquUB3LxGFLSbVV9bI=;
 b=ZgpPJgXCoU5hFB670CIzKV5jIZ+8GvhTt0kyqItjvFDJD1RciDUcSAYxNU8ioEOoVrlDPDepPG9JoCoKVr3NEGmVQXypZUQkV9MhfB4uyf5tt6QlHHiRgajeNOc+kh6Xab3ispeU6gZk7dP8vExSLI481SZ/Z+WNvAEbrSAbGJUX1LNDbonJINKaq/SeGXl1bDWd13oAbcb5j/SrzBQJvXyjk/lDH1VjM6GFxgfJkJLkgnetbYARwTHulM9bzecNU7CqaxR1OaHfq1mBNJegEe+IahcTt6kManHcJqK0qh1/DyX5BAiYd8zPBn5s4XcUyaLv7eeKnSKg3Pt46PzhFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com (2603:1096:101:2d4::11)
 by SEZPR06MB5643.apcprd06.prod.outlook.com (2603:1096:101:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 09:29:48 +0000
Received: from SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b]) by SEYPR06MB8068.apcprd06.prod.outlook.com
 ([fe80::e524:973f:e6ef:299b%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:29:47 +0000
From: Pan Chuang <panchuang@vivo.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Jonathan.Cameron@Huawei.com,
	u.kleine-koenig@pengutronix.de,
	angeg.delregno@collabora.com,
	krzk@kernel.org,
	a.fatoum@pengutronix.de,
	frank.li@vivo.com,
	christophe.jaillet@wanadoo.fr,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v10 0/1] genirq/devres: Add error handling in devm_request_threaded_irq() and devm_request_any_context_irq()
Date: Tue,  5 Aug 2025 17:29:21 +0800
Message-Id: <20250805092922.135500-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To SEYPR06MB8068.apcprd06.prod.outlook.com
 (2603:1096:101:2d4::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB8068:EE_|SEZPR06MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: c915b859-fa2b-4bf1-e8a7-08ddd4029eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9CbUCVu7aC106HNS1O3vAHYuu8xuFUBAgooasU2LsF9F3vCBH7/Tz45+T89?=
 =?us-ascii?Q?KeffmnlBDC9WGPfxXwQ5MdpfeROQE3+kNL0PTRsoAHWvXEwGcd+YurDEC0Id?=
 =?us-ascii?Q?vV+wB28C680CPYFCN0Ah2Em3d1F3AAUbTBvC7alLVkGhRs46sDoSBsEn5BnL?=
 =?us-ascii?Q?PG3opetXxg8UBwDZz5srBB0e4sBT9dz7JDD3xcSLrCE2biPaLjgMNaYUO8AB?=
 =?us-ascii?Q?BLn/jIYWPgMZOK9HmnGrnTQUuC2Tl8c3kZLuWfipTHz87XP6hCWbsp2NWsMY?=
 =?us-ascii?Q?68NlJSGHsj8wwhZCkUWmkuOKoQbY5R9AjNoeM0Arf/IwoI4Cf06kmltu7Dlz?=
 =?us-ascii?Q?o9ltX4HeMNtlmcaxKHDvXbjsLzwDhxk3LtiVrSGTR3hb/15lRzn47jiRQEzJ?=
 =?us-ascii?Q?hnjryQkrq/X79zy5pQOi6U4S2xdAobmenPBzc41VJjS1dTA6BM9R3hfErYLG?=
 =?us-ascii?Q?YFop6zz39MzM7KmLSkI2oOC25ktUcd6VraTIB86JgyF6jfghFT4T2oKNw1Se?=
 =?us-ascii?Q?yw98pbl77D2u6Pmgb0uQBIRLYQB4dHNxN1E/LdcpRw9Tu6USGG6dFEqjdbBE?=
 =?us-ascii?Q?7+KcARud80mM72XbSD/ZEdrBSQ6b8Y/975nG8ZMTJ5K885R34AdPRtSPTcnV?=
 =?us-ascii?Q?F8wIB/mW0SnQANjZcWdeba7IyuxYTFycqmTSb506dhuqn2UkqVk8+7rDEdjs?=
 =?us-ascii?Q?S/13XaFeo2UTLy6O4+U6PA6qFlo19Qt8rAPzQWSosdpRlRjldoOJ9PZVhr3s?=
 =?us-ascii?Q?/hD9g9sqlEnkAtaW/LKAz6gajMjoULiHSZpY5RZ1liiqWbha9xBlYwCb/SQS?=
 =?us-ascii?Q?tXPcWIyPQUQqRZzuwFyjVy7p8PM8yep4hSLe7mbI11HSaO5ZIzojxedcC/j2?=
 =?us-ascii?Q?e79nemD0Fye62Z0E+bXIiJrA+UPav+YpvuJhH9UPS+jLdYD6iuIieD04ZwTr?=
 =?us-ascii?Q?CPGom0ITMpRaCgJI5eEyNDp7JP1uuVqLtWHTsY5VUYf0VJny22xOUZKILxov?=
 =?us-ascii?Q?8YjIZeUfI9AeCGIVjCVNJtin6bJhQJ4M6M3vInSPncQXe3sdRQEcxpe13qW9?=
 =?us-ascii?Q?mJayUzR6e9aGwMDa7cgRzqOo3Flj48O3Sdrc8C82ECMlkABxA+a2bRI82QBJ?=
 =?us-ascii?Q?XB/NhXxXDPG5hB7/Li98UHKl1SvaSGGrcMK7QDrumFktAq4jxTbo8ARbPXFF?=
 =?us-ascii?Q?MMlXXayyWxlLv6UHMVda67GGeQ0yJcJBnygYQAJkMyDekYcJbWyNr0ort0L+?=
 =?us-ascii?Q?EDOrYnkSGRHz4wQVg9fZrppoLfZBfyx+5F0iHkf2N0l/vKEQ0WgswD7O0boz?=
 =?us-ascii?Q?nBYeobUn+FRQ4TJlLEEyv5I06gbDLxYh0DweEpX58tggXTl76gzTwozCKJj1?=
 =?us-ascii?Q?tsVxCHT6HEMsQ9akonfWonC7Rn/CsGATdxcFuXbMMWqU1oXwV4gv3l3g4UYg?=
 =?us-ascii?Q?g6+wz7xS1x8vlj1mslO7g/LVx+zKswlQjzDZ0SZlvQeBNcqMyM5Du2C9pvF4?=
 =?us-ascii?Q?uYVf4BemEbIqv1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB8068.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7/IdMV+ILIABnTI8Hh4HNWeF2AL3wgE5Aq/v+Nkb6yC8YSqTMNi5HZrHACB?=
 =?us-ascii?Q?9L1XiqpEXmrHtMFmKAQGLav1zupGeNNdX7Ub/5XWEShSfkE0c6s6EjX/Dz1n?=
 =?us-ascii?Q?5EhdF95SNYPIQiOuoH9WXAhNeTUFm4zX8dD+i2LgUKljM0PSowsTr+/V7stP?=
 =?us-ascii?Q?5FOtmqIwNYlpvsOHmLWFqtKBAeBHgMQyBUaj0HWV/90fITCswzutHjXGREU6?=
 =?us-ascii?Q?oQgCeLsbZ5pY2RAArBLQyszpRJaa9tnA2JgEOpMs7HtCvzsrx1Wqmeg2pVtA?=
 =?us-ascii?Q?ITt85BCbor5EB87M6pN+siqI75DAoTBKvCcblVqSP0L5tDv3Exd6Om4he1M0?=
 =?us-ascii?Q?qwjLcSpl6x1zVv0wrHOTfpZxeb6IRNVzUZL3zL/O4TNwtymJNlIWtNohRUWw?=
 =?us-ascii?Q?8Vef8T7X5G9NsFp+6e/mUCYh7+5qfiJGzULrtULIe3rg/KScKd2xos8naMaC?=
 =?us-ascii?Q?/VIi1iL0tz622Vh4VEBjFodOLs4VUa9pSn5NPNO2rGHvwCtmXL729Yv/K5RB?=
 =?us-ascii?Q?0ku2yU0DTE9dCB+t/gzcbidFOaL5xOO4pT7s3ekFMeoiT7h0XBi6Zhc+DkYx?=
 =?us-ascii?Q?g1fd88TiFDLfHJhNbR2l33M+jWwwhMJ3HtYRzphKulVYXljOKWXbYsC5OfjC?=
 =?us-ascii?Q?6IFfsNvgFM11NaLP9bhgR3DnUzrDIlEfwNi3UnhGxcDWBn5V5h1ezyziAIMR?=
 =?us-ascii?Q?KZt4ibyT2+uY46nasHZ50QS/Wzz/UoZdArun7WF9o5Gt3NG/kTJSNSaGhLzy?=
 =?us-ascii?Q?cSnujm3mklxTGf8N89pq2xP5kprfJzUAsa6pW45AF5e2YnUWfkDbZNajDVYq?=
 =?us-ascii?Q?XdIvHyqxQvFV12lD0BLXxb7HZv6DiWiRBc7WYwFTrvV80nUoMMybBUpm0dO1?=
 =?us-ascii?Q?AUqkJXMBBkvfJAIiwibeqoFA2rwM4by6oRDoNQb8aw1dlRAPTKKcX6x2oVrH?=
 =?us-ascii?Q?wW/gF8uWc1VktZ/rlNbu2u4NXk8J+Od37aMoy14/fy2AHdPPWCDbEaCmMWn4?=
 =?us-ascii?Q?MjiByvwQU6na4OOZW2gBMRM7ULArQjEOLX2h7EuVlXs+NBLYD4bi4KOs7KFA?=
 =?us-ascii?Q?HVL5QUKbbC5wrDDL+Td9Y0WLnHyQo8Ykh4g70tiIJyfscixcagMBcukjuUDZ?=
 =?us-ascii?Q?vzHE1OhOoN04Xuit94W1N5x0o23YKaoOeUbY1FfT+5AieMrCXy4dO1HEhwgF?=
 =?us-ascii?Q?wFX9Er8zR8tpwW6d8mTtvDAdtdSAm3sNry91TT3wgr0dbFF+Ii3uTWHMnD3f?=
 =?us-ascii?Q?gcz36xX2vCYmztNSRRBC1HwnvwNB4yXDrC4fgcCimyRfBD0X5w9z0pXxVdJE?=
 =?us-ascii?Q?5NuaDXn26dULWLVfhfV2PZ7iWEyhC99rqHth2YarzRQlBAPHpQuBvXn3DYWZ?=
 =?us-ascii?Q?EaEkCsC6iHHIWUzmVYygobd4h/aN1SK9tZkumr+DhBEUYm3EyeKGI5DI8cCb?=
 =?us-ascii?Q?rYG5ICuoER5A7Zi44yn8SvztISMuwLqB2raoEh8UEJiUWCuETlREdiIdzIOq?=
 =?us-ascii?Q?YQDiwlRzW7buOZZP6THXi5/jPvutaMpnXl3WIBOwitOLBc2LRvs9CCNuY25p?=
 =?us-ascii?Q?HatBMhw87pI8Fk/7wI4/YyWEOOIcuNjFBLd6mCpb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c915b859-fa2b-4bf1-e8a7-08ddd4029eae
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB8068.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:29:47.6216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPQuU7/c8eeiGd2+A+fkZCTX4PKeq4wtwbLaUAwWtysq7UQzJwPaB2F6GSzu9Gxnn1+BT+/SIqXo4lzZGBUmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5643

There are over 700 calls to devm_request_threaded_irq() and more than 1000
calls to devm_request_irq() in the kernel. Currently, most drivers implement
repetitive and inconsistent error handling for these functions:

1. Over 2000 lines of code are dedicated to error messages
2. Analysis shows 519 unique error messages with 323 variants after normalization
3. 186 messages provide no useful debugging information
4. Only a small fraction deliver meaningful error context

As tglx pointed out:
  "It's not a general allocator like kmalloc(). It's specialized and in the
   vast majority of cases failing to request the interrupt causes the device
   probe to fail. So having proper and consistent information why the device
   cannot be used is useful."

This patch implements a standardized error reporting approach[1]:

1. Renames existing functions to __devm_request_threaded_irq() and
   __devm_request_any_context_irq()

2. Adds devm_request_result() helper to unify error reporting:  
   a) Provides consistent diagnostic logging via dev_err_probe() on failure  
   b) Returns early with success code if no error occurred
 
3. Creates new devm_request_threaded_irq() and devm_request_any_context_irq()
   that:
   a) Invoke the underscore-prefixed variants
   b) Invokes devm_request_result() for centralized logging

The new error format provides complete debugging context:
  "<device>: error -<errcode>: request_irq(<irq>) <handler> <thread_fn> <devname>"

Example from our QEMU testing:
  test_irq_device: error -EINVAL: request_irq(1001) test_handler [test_irq] test_thread_fn [test_irq] irq-1001-failure

Based on the v9, add devm_request_result() helper.
https://lore.kernel.org/all/20250730062554.269151-2-panchuang@vivo.com/

[1]https://lore.kernel.org/all/87qzy9tvso.ffs@tglx/

Pan Chuang (1):
  genirq/devres: Add err handling in devm_request_threaded_irq() and
    devm_request_any_context_irq()

 kernel/irq/devres.c | 123 ++++++++++++++++++++++++++++++--------------
 1 file changed, 83 insertions(+), 40 deletions(-)

-- 
2.34.1


