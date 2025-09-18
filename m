Return-Path: <linux-kernel+bounces-753180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89935B17F97
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A293A2DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EC22DFB8;
	Fri,  1 Aug 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a2RaJpEW";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a2RaJpEW"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83952264BD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041676; cv=fail; b=mO9z4G+KcsnHt9Oqfa8rfC1FqymgRvS4Vt6Gqz/2eNyicoYCHYnR3W1r52JZC9agWXmyg7sOsffNrcvWslMIiAt6RkTm2CCt6KpyIQki8nDSDC9ve1XRsVm1RafNdVlXyBFIbyV9pQtMdKQNBUIhX0OWytFxdVC6KwGJd24qyto=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041676; c=relaxed/simple;
	bh=DWENHCqWmsZEJaW/RUKP3FxdlPWJjUyQPSH6GjTgnm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5ECjyqD5dQuYsLabW67zfHBoqZcjVI4yfxqImkPLVtjWnuqRYUPklRbYfP1yfOgVcUC77NvRCyzFuY8I+IdO1FSWxcQx5XePcXGTgicJy2+Dx9m6s9sx9gzwiob+pAzV7ahLml+rKAMWIzlf97Q1wV52I+ID6geYuNisjsu1TQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a2RaJpEW; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a2RaJpEW; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GOFerXCa7vDk35vsboH49JTaQWF5UNnQZfzntxBHC59gHem8q1ztCDxA37axH7aSzhsL7fx9obaUcM1U39Tl57OHBEVfKGsuIy6/9jd2Z5OpDsJPufbgHeLqkyMhw6QFqS/mt6JJfnuFEa0vXzt0vPn6t+0DyhBdU44F+TSKUlAxDsAB3/Tuh3s/GHlHXFORzsVnGTGDRxaGIOzuvdmocOs09BEl3tmViSV4GLSUcxqMQK+FGM6E3NjoemOtNQL+jp5e8ad5QUA1QEgjC4KUb54pBT9u7LgEKpXgxgzNNT9T5Rp2yjbxOAa1LiJTAbzKzrYzL9RKGdjclWpGvj2J+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjs1yxxR1JT24VgoIX/HLRCKcXr0f8bQpi8KsdOMhpQ=;
 b=uoajT4ysTX15Dpk6IRxOTdjq4xThpTtnRKHwqQZ45mPlxRxI6sh+ouUhk1WpiEDAL6nrNJN1j9BvHUBwczLB7Y+J2XRmqwCJF7vSxu0ohV/3eFz0I07x6Vpy6ZXavqd7stILDuC6qtUeHTAp8ffLmWh/aPtMn6wby2xrvC/gPBiMajZDgzI1aoKWvIXvyj85bSDRvi60KimbGTZQEavxaZY6JfXjdZpV3XDhdxHoFEYKW8qx4jGT7FXLczALrJrxQm5KXVA7/tKRIInNYYo2u/HNJdUqDCzfC9aTZaA3cm7xH9yjk+1q+26NmFqVxxKdblsdDgkl/R0f8EbJzZAxJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linutronix.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjs1yxxR1JT24VgoIX/HLRCKcXr0f8bQpi8KsdOMhpQ=;
 b=a2RaJpEWo20pZ6rQXzSMpywnkZp6owYpCucDiHRm2c6AkTDqxhhO8mS6eMMZLbZw/doKOpWXaIiDwZSV5A/i11g9fj4DXD24tOmPVvDIa/OLiW0BkT8t7JKzu4g6be0IqDRmgcI8jLlHUjhXpWbEG+sVxPSfnSiWKhdhLTaU+yk=
Received: from DU7P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::27)
 by AS8PR08MB9195.eurprd08.prod.outlook.com (2603:10a6:20b:57f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Fri, 1 Aug
 2025 09:47:49 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::a6) by DU7P251CA0010.outlook.office365.com
 (2603:10a6:10:551::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 09:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 1 Aug 2025 09:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/S+sMsIJH5WdaZ6AFS87BhTJNRbJ3DgKKiZiU28ugyIoSFBP2Ev6c7Q296sen+P2dXu495r2oSMM3Ks7rbniaCChz+r8aQ3lMeUQTFWVYkzoMYXBy6vj/AGbB9W0DlldJdNg58/Ai7yFgRgyfet7hjltS6jRSuMRT3nOI7m89Py3r2RYvKGjQm5m3kTYaEGaLSGhQLPCCWBSsfxBgcALmrJKX/GgXx8ZjekEQMVRzspw0v7nbWKYX5XnmN/1hREimfN7U9xI/m1ya5kSVkqm0RnXelmMrknO1bCvQt434RPdlH/K8MTutrD8zIEbCuoTUaI1+JOB7s3+PHlW0ZIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjs1yxxR1JT24VgoIX/HLRCKcXr0f8bQpi8KsdOMhpQ=;
 b=TMq69DzUYmidNxq3JHJBF8X3WZU52uK1basnHQNcY39O/0keuHsg472FtQ1ibzGS0xWBCrVhqBzxa60DgT2FK2j1zPD1cZbNFx+EkRh3/++rec9/k/mEt1syn3WrQUisSZrbDjk8C32riBgCwuy1yx8d4Z6YLb5sgFbO+/LclGe2vZy9ZYqyElh3nGzVOqRc8l8YfeBRdZN9XDox+/dwc6QiZloZ9ShsKHWJ3mN2BP5rg+vFu9ymPakQJhW2Az1k86pozVPuOIRvp+SJR85yS3yFyOvF3JOGV0G02oiXYyY4nVnOAITao6xig2nI3unclnXyd4bwB55Y6W05F3seRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjs1yxxR1JT24VgoIX/HLRCKcXr0f8bQpi8KsdOMhpQ=;
 b=a2RaJpEWo20pZ6rQXzSMpywnkZp6owYpCucDiHRm2c6AkTDqxhhO8mS6eMMZLbZw/doKOpWXaIiDwZSV5A/i11g9fj4DXD24tOmPVvDIa/OLiW0BkT8t7JKzu4g6be0IqDRmgcI8jLlHUjhXpWbEG+sVxPSfnSiWKhdhLTaU+yk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6385.eurprd08.prod.outlook.com
 (2603:10a6:20b:36a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Fri, 1 Aug
 2025 09:47:17 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 09:47:16 +0000
Date: Fri, 1 Aug 2025 10:47:13 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kasan: disable kasan_strings() kunit test when
 CONFIG_FORTIFY_SOURCE enabled
Message-ID: <aIyNIdN5dHTgzzQP@e129823.arm.com>
References: <20250801092805.2602490-1-yeoreum.yun@arm.com>
 <20250801113228-5a2487e0-0d90-4828-88c7-be2e3c23ad3b@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801113228-5a2487e0-0d90-4828-88c7-be2e3c23ad3b@linutronix.de>
X-ClientProxiedBy: LO4P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6385:EE_|DB1PEPF000509ED:EE_|AS8PR08MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: ff662d9b-55fc-4567-0807-08ddd0e079ff
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?BlRpSKwrLcnfX2DmNZ6eEaqW256gMI9qQsY69kV2YQgfj9YKVipgMi/VxwED?=
 =?us-ascii?Q?zW0goIT4tdPsBUaagzrkoWIyqQsx8lcbqxI5GSJFX1jSmheR7u731LcAMnN5?=
 =?us-ascii?Q?cRfqIhQK7UoU0YfbNj4FnkauKjxpkTdA6Eq3VX0QV2GkUj8A9GV9pjky8mxu?=
 =?us-ascii?Q?IwdkpWi/Mwziw4n1SyLEkFNg8DacfRXE1mCHkuvUBBlC8Syi7LktNCEIFzmu?=
 =?us-ascii?Q?l3D9NoFnIs1zAstx0K7aR6YWp3pXLsY9JUlBgSPJRqp2XjsURYAexwatZ4I9?=
 =?us-ascii?Q?BSfYVfQB9ygo7QOY2PSEOBPEcXbKCNT78Y4XZ8xYr4inDe1cBnIXlhNDw+6K?=
 =?us-ascii?Q?P4RdynjqrdzKeOdCGOtDUeVwBzuj8Ky3xvp/ilGu2um5SmTYtD6ut109tT1P?=
 =?us-ascii?Q?QN4/nYso0tHDcTZtM/PWyiKWX5hE56UbVrCqXyIhbzQgJq6lm5948Bg9ec4c?=
 =?us-ascii?Q?vo2CWINffWNL+VHqYTEHGtPqMCEOkWVM4VmCPIDJw95gd32GfJsGw+Ix0nhr?=
 =?us-ascii?Q?xnRKjFwvuQMQOMehXDEXH2lySn7JmIlO06mu3iK2bXLYJnkMYS4TDNZhFigo?=
 =?us-ascii?Q?mLqfg+TqDH195GY7v0bgPEBfaCMtz38d/a8frsO+lwmzvVeLrZgNoPrF3tnp?=
 =?us-ascii?Q?w3Yym7cMMt8UnaqAmzZyz/0Vims/zTeaepiekjxLvRasJDPKtsbdvRIEz81r?=
 =?us-ascii?Q?R7MMRx1AtxEJVj0whcEP5TMXkuR0J0kf3JUsBLhxgVewxLoQrIrhX6y58H/i?=
 =?us-ascii?Q?VkqVAYylrNecoJWMDHw9LV12IkUxJZ8MVii8qicMaPX8/83INI1NKpabXNXA?=
 =?us-ascii?Q?Io4vfRT8Rtb5Q1s+K537AVR0vCdXah3rk+aF6d+X9isuDK5gT2tHi2X05g1j?=
 =?us-ascii?Q?poSjZiJkMLFfZ1hJTG+7idhNimCW7gdy+3eCEQ98aGskF9d0P3bjornfbWkW?=
 =?us-ascii?Q?i1ApGRG4EhSXh4Q/i7HKEQsvbtUdsCdPBbgNntcJzUPcMjrYuCkevVcm3h4b?=
 =?us-ascii?Q?Nk5AhVw2jtgMrHGMRQVU9wUsV5qFM5YRYM5S+gDpNXW/h2SzEYiaRi4am+H2?=
 =?us-ascii?Q?X2r/7ysWsPFdS1x5MZ6fGXhImBSZT3R6DR1fCjctsgwBhms5bEFm+mhNSkxw?=
 =?us-ascii?Q?k4o5x0OhEoUycBGc2T8kirRK1eM1NFBxRO4ikP9j0Op66QUXouVxSbI3F8c0?=
 =?us-ascii?Q?FdtffqJTqgEvYlXhQEjDP3NfECBSGYCrZSxBpQcoQZsJgm0niQ6PQCrE+rPl?=
 =?us-ascii?Q?8aegVnI+vkCOGlHcJ69GxkSdDM5OLvOnQeN8CDA+CjhQYvpgZVyPz1C9CGLN?=
 =?us-ascii?Q?KD5f/HmoTs0jhEDU2+w7ywb6Z/xy5IGNC9f+lprXSIF7nd1ZLvhZuWeUtBEX?=
 =?us-ascii?Q?JeROzh1//GfT9iTgx9EAsKFDqjQTsG8vXdsx8Y6ylEMJl7yH+D5M8NhY6sxY?=
 =?us-ascii?Q?wCZsE1wtGLA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6385
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c4983e28-efae-4fb8-f600-08ddd0e065f3
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700013|376014|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tR78OOhimaY0VufK97Xta3YsND3ZehsYB2TMYtYuINMIby8owHgcSklCkWFI?=
 =?us-ascii?Q?vIkSPtLdoMxZzSOQ1q6/g+3LRrqxyDheAgefAGR38XmSNEgCBXMbl2d1fxfq?=
 =?us-ascii?Q?eGGp+zhhiyd31L4qHf2/omj5fEYFDeyj4e5uRGbW67B7JG3guYEy9qusNV4j?=
 =?us-ascii?Q?tSmvn8QBhtGIr4a9hdp+nAXuyy6swwY5XL4YZYwwHmiiAXvF4CQiqxoEu9i4?=
 =?us-ascii?Q?MKg3G9Z7gRM1xwk95I4UcbxdN0BZ3H7wwjLCdHrOQoWPCsUGzfh18ztk9r8z?=
 =?us-ascii?Q?AdykkPJtIFSinKji8UXOmANHTXHCNdMNGalCufYCnthb44Hgvg3xIU7U5luD?=
 =?us-ascii?Q?aujAyThhIAv+Eqykd4H7HuLsokSHabNy2jfc3YwgNHdLoar9MdKADuv9G7uy?=
 =?us-ascii?Q?74aYS8ix3/wGicHTfsPHsH5jBPBDXPBTgzKI58wQe44xLQ37KgsA/WdjkqsL?=
 =?us-ascii?Q?6aIC1UIMgPF8NGVle5GoRSkRTzeOBFbktTfvpAyPiFhnhl2bfj/ZaP2kg2nn?=
 =?us-ascii?Q?aRm9ANfrtsYd4pGcccvn1FaOcAZ4LSp/SbtLC67SN9jtau7L6tidU/Ed3KCk?=
 =?us-ascii?Q?V+QDHRBy+vjx6SJmGWPUpgce3oalgYFQrEONClre6dTQD3CVvKHnCoxcefts?=
 =?us-ascii?Q?6ZEGt4LM5b1noPk4n4pm5LrXbg71WD49wyYEQgEbPMCQHiMdcFK29ILdk1ob?=
 =?us-ascii?Q?ATQwNNyQccROb7IXaPh0Ep9fGfkswRgOdegCd1TS1s90iUJsQu2rg2dCLWFd?=
 =?us-ascii?Q?2Lw7yXYVJxAtJtx06ZbmG1AGnf8tV4MjLRmRPmiKMs1Ls7Y+dEJuw2ulDSez?=
 =?us-ascii?Q?58/Ya9r+O1Yw+JWeLnZPY8HTxYJeiZkvLBn5+J4mEuWLG3LFfAgHuF+wWyUK?=
 =?us-ascii?Q?0XOtbajQd9e0ktEKLd161YPXda06CBQy4fRff/lm+HfdPGyNzy4pc8g/ih2C?=
 =?us-ascii?Q?KTPJitG+hZh24ZFdUkD0PkEIQ/WAmyyH6TN4UtWZEbjTJmMysE7J+x0a5Air?=
 =?us-ascii?Q?mYcNyLvqrDKLP2Lsk2dHv1EZXZWSsDcl7BgVcGooNDRtbHl1L0/PvtgZCl9o?=
 =?us-ascii?Q?pcYqelgOvYytfpNk1gIE5xOD47Q0ROo7x9XNA02ZdJ8LVFf02EQ55eslDESM?=
 =?us-ascii?Q?+NWefozmUkGAw7Jdbanvjw5JsrUns5/V/tLHBoxfCDShG5An3hZN6kdoxNUm?=
 =?us-ascii?Q?fEbyEqhYw+21XiHk2Vo6ZKIEVUv28jSLDcyKAZx8HF+8LdjkDuzzQLOsBjGb?=
 =?us-ascii?Q?l4QjhLQKT5tBxPbT1ioQO73V9mCrO+ep864wWvJZ3WCom4eCoolDuAKBYHng?=
 =?us-ascii?Q?i87ZrFsiPJ+lfMpg/eZkSoH/b4c3XeOdzpx+H/+ASbIlRIcL9SpigJ8z3SMl?=
 =?us-ascii?Q?tOViRtVm23a5rYyinaPWJjikv/F+oK/3CYOGaahDzo+x+Hh3HXaaLlIbb2ds?=
 =?us-ascii?Q?y6NDASo6z0NMaAXO5u4qBdenwC/PQjz4zjTuFoI9QBslCUL5BAHC0aNUBm7b?=
 =?us-ascii?Q?xWX6oElx+Lu9KtisSDgYntJ/E2sto0lmyiNN?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700013)(376014)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 09:47:49.3504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff662d9b-55fc-4567-0807-08ddd0e079ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9195

Hi,

> On Fri, Aug 01, 2025 at 10:28:05AM +0100, Yeoreum Yun wrote:
> > When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
> > triggers __fortify_panic() which kills running task.
> >
> > This makes failured of kasan_strings() kunit testcase since the
> > kunit-try-cacth kthread running kasan_string() dies before checking the
> > fault.
>
> "makes failured" sounds wrong. Maybe this?
>
> "This interferes with kasan_strings(), as CONFIG_FORTIFY_SOURCE will trigger
> and kill the test before KASAN can react."
>
> > To address this, add define for __NO_FORTIFY for kasan kunit test.
>
> "To address this" is superfluous. Maybe this?
> "Disable CONFIG_FORTIFY_SOURCE through __NO_FORTIFY for the kasan kunit test to
> remove the interference."

Sorry. I'll refine the commit message with your suggestion.
Thanks

>
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
>
> Missing link and changelog to v1.

Right. I'll add

>
> >  mm/kasan/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> > index dd93ae8a6beb..b70d76c167ca 100644
> > --- a/mm/kasan/Makefile
> > +++ b/mm/kasan/Makefile
> > @@ -44,6 +44,10 @@ ifndef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
> >  CFLAGS_KASAN_TEST += -fno-builtin
> >  endif
> >
> > +ifdef CONFIG_FORTIFY_SOURCE
> > +CFLAGS_KASAN_TEST += -D__NO_FORTIFY
> > +endif
>
> The ifdef is unnecessary. If CONFIG_FORITY_SOURCE is not enabled, the define
> will be a no-op. This also matches other uses of __NO_FORTIFY.

Right. However, it would be good to specify a relationship between
the define and configuration.
So, some usage of __NO_FORTIFY in Makefile using this pattern
(i.e) arch/riscv.

If you don't mind, I remain as it is.

Am I missing something?

Thanks.

[...]
--
Sincerely,
Yeoreum Yun

