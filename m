Return-Path: <linux-kernel+bounces-720196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5335AFB86E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33719165429
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7B22ACEF;
	Mon,  7 Jul 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="R0L2F3Cq";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="R0L2F3Cq"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021113.outbound.protection.outlook.com [52.101.65.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249522686F;
	Mon,  7 Jul 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.113
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904754; cv=fail; b=a3HntI2DnWFZ/pF65Gw9OPXKSPLdIi9MOcwvZIkuE9zlLpW7YJnWlASUePaJS2vfjTUi23W/rv2OZWURLf2CgG3bKiTSPE8BTrlrbx0N5Wtxww0OBXDO18XhjlONhxlU0ZutQIdqCOWlynbTf2nBZcqMnxynHfAZ+HbuU0WBcGs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904754; c=relaxed/simple;
	bh=iLwGB9Cz+ekHVEBz74ll88bIdltrxet9rAGtIUnkARw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jz8zpO9wNbWZ5jV+V/E5NpvHH5p5SAEKwb28n3IDugtkJOcHWbbA0zQ5wA5Jl67nFLvdOxRgquFz4G2sZSjpfSHYalNcQV//xtjsWxUb0EqTgtmIiGYduJCSbpjaZwmhpRPoR3l4qNX2LuEbqgK1FVXhA2QPkKI0/5SjmRF/VBw=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=R0L2F3Cq; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=R0L2F3Cq; arc=fail smtp.client-ip=52.101.65.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tXyBG0LJiZIxiw3wBlcMTL+At8FO18v8OoecGZpuyU3mAt59ogl4trPEpDQKNWGEEoJ09nYK3sfhZvJ95KWf8jyg/C3pF2esmABdeCshW33Ht99seBjShByhjXTVeOjyaoDG0QnCpGTVwAbPuhb6Vc4gnHrHDt14JP4mlHK783yq9QwHCfPxmHyWk10T/ja4h3AqtWlENMTuK8k111/L60thnLmPvdHK/RYH1pDgdC7Yjll6QJyVTVi+b0Xf3ffBB0QAZH/SAw7YyTfe7FfsF3mbiE1XoYQ8YCDo6N22mxjWe4vygo9jZ+0qo524ZxrLCYdvUItxUSTg2g4rde0jwA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH3nBWchK4dL3OJQih0nbJlMVklro06J6MOi9chmabE=;
 b=GfOXvCg1uZw2jjCQ6kwdyQsptIipiAeh5lX1dZ75PXnKeSoXUbp4yvzZ3S0N2/G8PDjDulD2DyQdOJjsktNSRBxJB/VlV23ldz0B1Sari2MQkFWkqAY0AaqLvNu+5wHnlA4bHOEqIXyoci93QeVXtpQjinEJhxAITl8nJhz0Udn6EDDmCWHkBYxBg8g86p9WscPTHrwqXhnIuScM4rv19VXjT00VcMzn1bebfcTIm/J1yI8cLrZdlAfLbI+VdlYN6E/l3fLbmKbQjQ6GVGhv1635D6ZSwvCwQEtwTE2KjA9ECsxON8IbojfDkQiImrQMn5Zy74hSH2QZ0M5JbpqCAA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH3nBWchK4dL3OJQih0nbJlMVklro06J6MOi9chmabE=;
 b=R0L2F3CqFlbs/X65+dM35G7CHYsYYKTRTdiftF4NPsNZMQ73e4M1nqnMv6YoL5jVg5jxUI0EvWqdcSZh7e6AzdN/zIAZu1M3WFe2tkIGUnxJ0WptryKrK0wyliqcq5viCJB4XunS+zmiUDbbcQmx1yYr7TGByD26C/nHx6PgXeQ=
Received: from AM8P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::31)
 by VI2PR04MB10217.eurprd04.prod.outlook.com (2603:10a6:800:228::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:25 +0000
Received: from AMS0EPF000001A0.eurprd05.prod.outlook.com
 (2603:10a6:20b:218:cafe::65) by AM8P189CA0026.outlook.office365.com
 (2603:10a6:20b:218::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 16:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS0EPF000001A0.mail.protection.outlook.com (10.167.16.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 16:12:24 +0000
Received: from emails-7501188-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-201.eu-west-1.compute.internal [10.20.5.201])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 03E767FFF6;
	Mon,  7 Jul 2025 16:12:24 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1751904744; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=sH3nBWchK4dL3OJQih0nbJlMVklro06J6MOi9chmabE=;
 b=A5KFZ5Jl5Fm8/ablCYHyQrjeoAN6mjRPqRT/HTFQUxZqxA2yGaYSCT/asnB5jVVATrFKu
 VRFP9GTpTHyqFVJDA7VqmbruKHTf56Z8qvgZJj7hcMXwVUI9l9/yWEyM0m3svqMoSMHZiC+
 rCZopQ5krUm+fiLA9XXI3v9F/5I9Fuc=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1751904744;
 b=QC2AMT5PFEOXWntRBXBT5HlN9vUNnNBgXbHNwLg30/ntMz34LxSKpGZHuHrx7vY7HXgiw
 m7BXzFEtXq6cyy8MEFHIU7c0EP5DDQ3ehMg68KOVl5wSQAv9r+SnLnCgpCdGZp7JSo/84A3
 dzL4k0EKvFBksmDWr6x7mE049cctBIQ=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9RyQI8maJo7JP5J1GkkwOcSzCZwWPrKcBhWatrCnw+qs5fd09Y/jj6XL5j9qf3jXryfhV8JhA2vN77RAkzmUgb/zjsjrV3aAOtAZSMeSVhwb4RKQcay7qfyY7Tki8VdST30Alzuge9k0YoVqi0iayAwxyXC1PG7QDpxacsTHnTfhdant+kdR7kdoodf8lwHvquneJQqgeaHE3VwgQ3UabGWh183weUEvhA23PeuzfxS6uFKbW+pSpC/HGGhXwF012+sQbkzduwmuUeZrzoaQQTT+9XnIJn7ANrlCh3/wMBg2PtYFucF962VHR4n3q86M6pFnM33JHkkdL0kUlVh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH3nBWchK4dL3OJQih0nbJlMVklro06J6MOi9chmabE=;
 b=wnTWarI82sNdPh82At+ly0a6KFzMlqABeR6N8/lylza8DznBxLx1nHFgKHxSKm+gPE4aq2RRjYgo2aQ5X44kIj2wWTrlU2tJoBcX9jNe2oT2AmiOVSQOKsnd+0WDzdoTdjPP5YG3Efm75sus9dLnh5p96439UQW4yHvFyUAW4faPWqpK46paBO7zHt/njRNaF7vvi27jzOgd534zBYj5v6HcFjhHoNV6uC3iK6KuKt2TsvXIAnwRdsiUdP9LVTm6VGB6ttwHaHL+FwPJ1zI+VHqKNe8Uyy9BEUu/FcNyk+he8vyJPlrmMl6f/UWsptzNuWk5cezlpkePUdrfn/ULoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH3nBWchK4dL3OJQih0nbJlMVklro06J6MOi9chmabE=;
 b=R0L2F3CqFlbs/X65+dM35G7CHYsYYKTRTdiftF4NPsNZMQ73e4M1nqnMv6YoL5jVg5jxUI0EvWqdcSZh7e6AzdN/zIAZu1M3WFe2tkIGUnxJ0WptryKrK0wyliqcq5viCJB4XunS+zmiUDbbcQmx1yYr7TGByD26C/nHx6PgXeQ=
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
 by PR3PR04MB7354.eurprd04.prod.outlook.com (2603:10a6:102:8e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 16:12:12 +0000
Received: from AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f]) by AM6PR04MB4567.eurprd04.prod.outlook.com
 ([fe80::6d60:a27a:fde:6c1f%4]) with mapi id 15.20.8880.021; Mon, 7 Jul 2025
 16:12:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Mon, 07 Jul 2025 19:11:57 +0300
Subject: [PATCH v2 2/3] arm64: dts: add description for solidrun imx8mp som
 and cubox-m
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-imx8mp-sr-som-v2-2-785814ef09a9@solid-run.com>
References: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
In-Reply-To: <20250707-imx8mp-sr-som-v2-0-785814ef09a9@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To AM6PR04MB4567.eurprd04.prod.outlook.com (2603:10a6:20b:19::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM6PR04MB4567:EE_|PR3PR04MB7354:EE_|AMS0EPF000001A0:EE_|VI2PR04MB10217:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e1b24a-cae0-40d8-7691-08ddbd710f78
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cFl2RGVoODdVUU8wRWZZMWErS1pqNVNxR2l3YXM2Z2hyYXFwdTl2R0QxUENy?=
 =?utf-8?B?ZHQvbzFjbE8xM0lXQXNsd1BtUmJTRjhka3dXZ01aNUlyL3VDVDJOK21sNzlO?=
 =?utf-8?B?REovNjdBZFpCTUtrLzd0NFplT3d1UndSVno5UGp6bTRZYzF3YzdOZ212RWVR?=
 =?utf-8?B?NDhCZDNZY0J2Vm9ySEk3VEFWdEc1NmJZQmpZNXdyeG9PNndsREFsT0kya0o3?=
 =?utf-8?B?bElEWUNjaE1JT1ljWjN2SjdERmQ2NDMyb0MrWlh2SFBtV1FYNzFMcmVRblVo?=
 =?utf-8?B?T3dCQ2t3NnJlVFE1MmZsWDF1WktZR0c4ZFF3M0p5VFNwYWpQd0x3V3FlSXAw?=
 =?utf-8?B?Qm9JTUU3dTBGeWZQeEhhSnRPNm5uQnJhYThKRWtXU1lFZW8xVkVvVWJFd2xK?=
 =?utf-8?B?eXRRVDJqVFowYURCckcwWUM5c2hraDdxUUpkdjZSY3Bsa3QzUDRCR1NzczQ2?=
 =?utf-8?B?eUp5TEJOVVJDWkZvd0FSb3FqT1luK0prbHFyQk4xU1ZBTUlnM1BVUTdaSG5X?=
 =?utf-8?B?QzBkenkrS3MxMC9jMUMvVUdhaldIVy84TVBVWmcvZi9Za2FhRFdyT0pkcktG?=
 =?utf-8?B?aFBVVCtqd0NuRGRrM3UwWStkcjFqRnA0c3J1b1ZBbys4dzA5T2I4bHRDTXhB?=
 =?utf-8?B?aGo4TC9SN2lzTUh4T1lpWGRINDNndGRheDIwRXBQblZXQ1h3dFhESUwrd2JT?=
 =?utf-8?B?NHBnNlFhcDFwMmFhRjc2MGNZS1ZLSnV3bHhZSnRHazlQSTZ3N05lVWRtNFZY?=
 =?utf-8?B?NlFKdE41ejBYYWFEbGVCci9vR2RYTzJoc3Z0RlpDTEVNSS9sdE1BT3pFOXp0?=
 =?utf-8?B?VlltYVZGMEhIUXhWWnpjM1VOaVVCTm9BT0FDRnQ4QmRTeVd4N0NURnpubngy?=
 =?utf-8?B?Z1cvNVF0TGl0WkxITHJSZ0NuMjgxMkZ3NHFxeU12aWEzTzdYQU1XdVg1V0Nh?=
 =?utf-8?B?VjREaFNsQjBaa1R4bWxaRjg3NFdyVHd2VW82NGl3RlhPN0VGcEswYTM3eldh?=
 =?utf-8?B?Q1dyL1ZORFpHNkxncmY2L1BZRURDZDBDUTFXNzNXWDgxMmszQ3pQSFpvQUZz?=
 =?utf-8?B?QS9SdjRHTUtYUCtyQ1oxUGI2dlcxODZJazRVSVB1c1c3K1pvMEpFb0ZXZWRt?=
 =?utf-8?B?cTJTYllYTStDck5ic0Z0S09yN01QZEg3VDcwWWt0bHJseVBwbnVOKzVwREFZ?=
 =?utf-8?B?UHhJdkI4R1NvU3dWUEFGaC84cUtaQWMzbUNoVkk3Y1pIQXJaQTdhWUxHM0hF?=
 =?utf-8?B?N2RVT3RaWUp4SWUyKytEampLek91R2JHbmFub1haMmZMREpZSmFuWHdWQVcz?=
 =?utf-8?B?NWhlNzVDUmhWRW1HZzc1Zk9tVXlXcFEyTlppbHhaL0NrcGZabStPY25aUldo?=
 =?utf-8?B?UHhjV2w0bWtSMDJaN1B4M2lVcGZsM2dlUWZ6RXQwcklVMDlteTJnNHoxMGxy?=
 =?utf-8?B?TXB3WDEzL1JpNTRNcHpBcU8xL0VVejNIZ01Xdk5aNkRUamZ0ejV1Vmt6bDFE?=
 =?utf-8?B?UGRpaXZiYmtVaEhsUkljSXo3SlAxdjJaYzdIb0k2RkN0MkJOT0V6SkRBc3g5?=
 =?utf-8?B?Q1IvL0dmZEh1VWNxU1dCd3hGbUZjZlRyMk9hT2VPcTNHa2ZMYXdIMUNjaU5r?=
 =?utf-8?B?cDVkYnNTVHRiOC9xVDcrZmFxNi9XWUdlaHFrazRLQmZBNGVHQWtWOGlyQ3pm?=
 =?utf-8?B?ZXdTWnpTdDJNVmhoZ2J3WERBMkJUVU5jMnAveFIweE10dzcyZnptWktVeTMw?=
 =?utf-8?B?OFlhMDh3cEg0ZDBlK0g2N3BlOXRUSVVQbEMzY211WnlhV3BFbVEveHNHSStP?=
 =?utf-8?B?TndUd2NKaHhOcW9RaFNLcnZZV05XTkEzY2NrZkNTNXpJYmh6MVNxRzI2SWIr?=
 =?utf-8?B?Q0h6YkRGblZabEFkczFMMlZaUWZ6cEtFbzhRdzZCYXdPdVc2UjdwVzV0aVB2?=
 =?utf-8?B?eldndWJRNGtSUHRoWFJoRHpZWnJIa2lnenNaMTJaaERWR21IYWpwL3Q5bkFi?=
 =?utf-8?B?MUtoUzJBWUd3PT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7354
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 81ee328948bb485cab8288c22d94e9b7:solidrun,office365_emails,sent,inline:9dc78d7a0aea7e94852b4c8673104263
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6f3cbf3c-0613-4b0a-fa2c-08ddbd710841
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|7416014|376014|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5jUEt4b1Vqd0pHL2QrRVQ3ZzQvSWQzbXE0QWZVeUs4Y3B5bmdQNmVKcXk0?=
 =?utf-8?B?WmRqdFBSdGxkaC9QS1JRajU2SkZvektlSjMwaERYUzh0RldLekY5UElsZ0tI?=
 =?utf-8?B?bVc4K1FVOTFUa2t6N0VRWkhEY1JWSHFFb0JNbmU3UW11WE5ZZm1LWk5EM3dO?=
 =?utf-8?B?d28zUmw4eDN6S0Y3Y2NWdktnSFJPbEhkaFhqbXdXNmlmWnpEZUNzZ0xuajFT?=
 =?utf-8?B?ZFlDbUZWOEUzVlFWSUZRRzRKT0g1L0FXVTVUaC9Gem90bURVZS82K2lsSSs0?=
 =?utf-8?B?aFBpdlRnR2QxVzA4Q2l6ODJTYVFQKzgzNUZ3NmlQd1ZReTFlVUQ1dm8weG1D?=
 =?utf-8?B?SVc5SXFFbmlGZ3NaZ3dpRVJobTEzYWMxRFF2dVM5YXFJY0gxVCtIRjRITlVC?=
 =?utf-8?B?QmtTS3lKd0NHa1poTmk5YlBKdVQ1Q1dmTEhnWEN1dVJOdUd2OC9jZHFySkxF?=
 =?utf-8?B?VmZLWUlVR1hYR2EycnJSQkpiSkpKNkdjTFJDQ2VxQkVuUlhVMjNxZXpHMVdU?=
 =?utf-8?B?Q3pVRVk2NW5yM3BKM1NCVy92a2xQb3lEVkozSm5Ud1hneHRObmZldXdyN0NN?=
 =?utf-8?B?MDFSS2lETnpzb1NrcGJHZUptODhyTVhWdEJ1bnEveG83QWZpU1VTQm5FMVkr?=
 =?utf-8?B?bG5lWE9KVFB3RFpTUE0xbDI2cDdHTFAwTHl1Yi9ja1lPLzlrOFBUUkx0T3pC?=
 =?utf-8?B?ZmpieVBwTE9zSEZna2NKdTZmMG9HUXBtL0tUS1NJaWorNVJXQlo0aFV2eFU5?=
 =?utf-8?B?MmlYMWYxM25tZ2VIeTlqOXF3dGZIYTkzaEFRWDhDbEM0bUQ2U1FKUTM2NWtu?=
 =?utf-8?B?c0p6bXVnU1hBbitQZ2M5RG0yYzQydHI4cERmQVM4di9qc0hhY09pWlVHWlYr?=
 =?utf-8?B?T1JzMFZoR3UyYWdGV2pvekZHRzY4K2wyRHQwQllMNDJRZ1d2UitOYW9oMGw0?=
 =?utf-8?B?TkM3ZmxTVkNrRXY1WkZxaWlBdEgvZWk3c1FuNTIvOFBsS0lXTGxWYThKYllM?=
 =?utf-8?B?bkVHbTc3Zmcya3J3b3RCL3NpUnp5enZGa2JLRUNna3YvV24yTC9renNvdnB2?=
 =?utf-8?B?UkQwQVoxWEJKUmtsaTFEWnZIbXFGSXZDcjJkTXVDY0NpN2dRNjBlZGkvYzVZ?=
 =?utf-8?B?akJSQ1ExREQvUG1nNU5zdXBjSDJBbnNMZXRyM3pjNXdmOEFUeTlkQXZ4aEUy?=
 =?utf-8?B?MlZBUnE0bkJKMWRNQUJJazBoQkpxOE9JeGVTYm9DN3Q1dEd4Tko1NGhlamZF?=
 =?utf-8?B?VFROUC9HUitqbTFhTHVPRXJDR3dWWkw0WUgrZFBodnNrNEczWStYcUNJMnNi?=
 =?utf-8?B?a0ROZktzbXl0MUpRY0YzS3ZDSllsNG5uM3F4U25qY1A4cmJQNS83NjBLSDBK?=
 =?utf-8?B?VSt4dnpndndDMUVacEdMdUdwL0NrcFcrNW1GL1FRMkExbTdWQ2FmQzVJMFVI?=
 =?utf-8?B?U1VvN0VwUTJFd1l2SExLa2hXTkdoeG1xZUtFWi8zcXJOZXQwdjRJVHo1dWVa?=
 =?utf-8?B?aSsvVXNBc3lvaExCZmxqazF2cExucTBWRWhid0FVMFl4QlIzaVh3b2N0NFc2?=
 =?utf-8?B?NEQwdFh4eWI2Q2tBWGxvTHE5UGZ6RGdNN0xndzM3endaRUpzMUhSa3RMc0Rv?=
 =?utf-8?B?dDBCZHZsV1BZVWNEbk9NcS95aUlYZis0b2xld1o0YVdYNzdKbDBRMFhsVjMv?=
 =?utf-8?B?WUdJUG1hcVBoS2M1WE9qUXdIU0IvUjNUTTN6V2QzTkNpUlZYRUs0bWEwdWZT?=
 =?utf-8?B?Sy9uaE5vd0txd3N2QVBLVUxyZkNLRFFKUG5zd3FQeFNzZnUyOGtOTy9vakNQ?=
 =?utf-8?B?MFlZaWF2Y1hDdlJWdnM4VHVSZHJNQTNTeUZDV2t0QlNTR3M1WU8vcXE3cmVM?=
 =?utf-8?B?bTY5QXo4UDArU01lNysvZkFCRVNqSEltNFU4b2lWZzVqY01Md1BBQnhEWlls?=
 =?utf-8?B?TDBBd2h2YXJHSzl0KzR4VHFjdGp4MlVaR2MvNldMVWxvOVhrOVZ6NXhDbWRx?=
 =?utf-8?B?Y2tVM2JadGJUcWdHWlFweldXSUJPR3c4T3hVOHNKa2xEblUwWFpROG1NQm9z?=
 =?utf-8?Q?vus79c?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(7416014)(376014)(14060799003)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:12:24.4056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e1b24a-cae0-40d8-7691-08ddbd710f78
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10217

Add description for the SolidRun i.MX8M Plus based System on Module, and
the CuBox-M.

The SoM features:
- 2x 1Gbps Ethernet with PHY
- eMMC
- 1/2/3/8GB DDR
- MIPI-CSI Camera Connector (not described without specific camera)

The CuBox-M is a complete product with enclosure featuring:
- 1x 1Gbps RJ45 Ethernet Port
- 2x USB-3.0 Type A
- HDMI connector
- microSD connector
- microUSB connector for console (using fdtdi chip)
- IR receiver
- RTC with backup battery

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile           |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts | 224 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi | 591 +++++++++++++++++++++++
 3 files changed, 816 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d12008ff79d6467d9e1c7ab2c4d6a9a6..e98c15eb949957a193eb3a7612f3f0f2b04790af 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -194,6 +194,7 @@ imx8mp-aristainetos3-helios-lvds-dtbs += imx8mp-aristainetos3-helios.dtb imx8mp-
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-helios-lvds.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-aristainetos3-proton2s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-beacon-kit.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-cubox-m.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-model-a.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-debix-som-a-bmb-08.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
new file mode 100644
index 0000000000000000000000000000000000000000..13da5e0196a3fc168efdde63d86f0fe776f999fb
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-cubox-m.dts
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+
+#include "imx8mp-sr-som.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP CuBox-M";
+	compatible = "solidrun,imx8mp-cubox-m",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ir_pins>;
+		linux,autosuspend-period = <125>;
+		wakeup-source;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		status {
+			label = "status";
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+	};
+
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+		status = "okay";
+	};
+
+	vbus: regulator-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus";
+		gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc_pins>;
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <250>;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c3 {
+	carrier_rtc: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	hdmi_pins: pinctrl-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+
+	ir_pins: pinctrl-ir-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x4f
+		>;
+	};
+
+	led_pins: pinctrl-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x0
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	vbus_pins: pinctrl-vbus-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x100
+		>;
+	};
+
+	vmmc_pins: pinctrl-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x0
+		>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc2_pins>;
+	pinctrl-1 = <&usdhc2_100mhz_pins>;
+	pinctrl-2 = <&usdhc2_200mhz_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cap-power-off-card;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..a7ee0a4d4f765581dbc27d3c5dfc656b026d27e6
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-sr-som.dtsi
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+#include "imx8mp.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP SoM";
+	compatible = "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	chosen {
+		bootargs = "earlycon=ec_imx6q,0x30890000,115200";
+		stdout-path = &uart2;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0 0xc0000000>,
+		      <0x1 0x00000000 0 0xc0000000>;
+	};
+
+	usdhc1_pwrseq: usdhc1-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
+	};
+
+	v_1_8: regulator-1-8 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	v_3_3: regulator-3-3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&eqos {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqos_pins>, <&phy0_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy0>;
+	snps,force_thresh_dma_mode;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			reset-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <5>;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <5>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+			snps,map-to-dma-channel = <0>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+			snps,map-to-dma-channel = <1>;
+		};
+
+		queue2 {
+			snps,dcb-algorithm;
+			snps,priority = <0x4>;
+			snps,map-to-dma-channel = <2>;
+		};
+
+		queue3 {
+			snps,dcb-algorithm;
+			snps,priority = <0x8>;
+			snps,map-to-dma-channel = <3>;
+		};
+
+		queue4 {
+			snps,dcb-algorithm;
+			snps,priority = <0xf0>;
+			snps,map-to-dma-channel = <4>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fec_pins>, <&phy1_pins>;
+	phy-mode = "rgmii-id";
+	phy = <&phy1>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0x1>;
+			reset-gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-1 = <&i2c1_gpio_pins>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	som_eeprom: eeprom@50{
+		compatible = "st,24c01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-0 = <&pmic_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 GPIO_ACTIVE_LOW>;
+		nxp,i2c-lt-enable;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1150000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_gpio_pins>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-1 = <&i2c3_gpio_pins>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	/* routed to basler camera connector */
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&i2c4_pins>;
+	pinctrl-1 = <&i2c4_gpio_pins>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&iomuxc {
+	eqos_pins: pinctrl-eqos-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		0x3
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		0x3
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0	0x91
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1	0x91
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2	0x91
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3	0x91
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x91
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x91
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0	0x1f
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1	0x1f
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2	0x1f
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3	0x1f
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x1f
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x1f
+		>;
+	};
+
+	fec_pins: pinctrl-fec-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x3
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x91
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x91
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x91
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x91
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x91
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x91
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x1f
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x1f
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x1f
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x1f
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x1f
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x1f
+		>;
+	};
+
+	i2c1_pins: pinctrl-i2c1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA			0x400001c3
+		>;
+	};
+
+	i2c1_gpio_pins: pinctrl-i2c1-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14		0x400001c3
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15		0x400001c3
+		>;
+	};
+
+	i2c2_pins: pinctrl-i2c2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA			0x400001c3
+		>;
+	};
+
+	i2c2_gpio_pins: pinctrl-i2c2-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16		0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17		0x400001c3
+		>;
+	};
+
+	i2c3_pins: pinctrl-i2c3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA			0x400001c3
+		>;
+	};
+
+	i2c3_gpio_pins: pinctrl-i2c3-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18		0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19		0x400001c3
+		>;
+	};
+
+	i2c4_pins: pinctrl-i2c4-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL			0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA			0x400001c3
+		>;
+	};
+
+	i2c4_gpio_pins: pinctrl-i2c4-gpio-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20			0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21			0x400001c3
+		>;
+	};
+
+	phy0_pins: pinctrl-phy0-grp {
+		fsl,pins = <
+			/* RESET_N: weak i/o, open drain, external 1k pull-up */
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x20
+			/* INT_N: weak i/o, open drain, internal pull-up */
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18		0x160
+		>;
+	};
+
+	phy1_pins: pinctrl-phy-1-grp {
+		fsl,pins = <
+			/* RESET_N: weak i/o, open drain, external 1k pull-up */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02		0x20
+			/* INT_N: weak i/o, open drain, internal pull-up */
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03		0x160
+		>;
+	};
+
+	pmic_pins: pinctrl-pmic-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x41
+		>;
+	};
+
+	uart1_pins: pinctrl-uart1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX		0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX		0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS		0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS		0x140
+			/* BT_REG_ON */
+			MX8MP_IOMUXC_SD1_RESET_B__GPIO2_IO10		0x0
+			/* BT_WAKE_DEV */
+			MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07		0x0
+			/* BT_WAKE_HOST */
+			MX8MP_IOMUXC_SD1_DATA6__GPIO2_IO08		0x100
+		>;
+	};
+
+	uart2_pins: pinctrl-uart2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x49
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX		0x49
+		>;
+	};
+
+	usdhc1_pins: pinctrl-usdhc1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x190
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d0
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d0
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d0
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d0
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d0
+			/* WL_REG_ON */
+			MX8MP_IOMUXC_SD1_STROBE__GPIO2_IO11		0x0
+			/* WL_WAKE_HOST */
+			MX8MP_IOMUXC_SD1_DATA7__GPIO2_IO09		0x100
+		>;
+	};
+
+	usdhc1_100mhz_pins: pinctrl-usdhc1g-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d4
+		>;
+	};
+
+	usdhc1_200mhz_pins: pinctrl-usdhc1-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK		0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD		0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0		0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1		0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2		0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3		0x1d6
+		>;
+	};
+
+	usdhc3_pins: pinctrl-usdhc3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d0
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d0
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x190
+		>;
+	};
+
+	usdhc3_100mhz_pins: pinctrl-usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d4
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d4
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x194
+		>;
+	};
+
+	usdhc3_200mhz_pins: pinctrl-usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK		0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD		0x1d6
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0		0x1d6
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1		0x1d6
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2		0x1d6
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3		0x1d6
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4		0x1d6
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5		0x1d6
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6		0x1d6
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7		0x1d6
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE		0x196
+		>;
+	};
+
+	wdog1_pins: pinctrl-wdog1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B		0x140
+		>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	uart-has-rtscts;
+	/* select 80MHz parent clock to support maximum baudrate 4Mbps */
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		device-wakeup-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		/* Murata 1MW module supports max. 3M baud */
+		max-speed = <3000000>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usdhc1_pins>;
+	pinctrl-1 = <&usdhc1_100mhz_pins>;
+	pinctrl-2 = <&usdhc1_200mhz_pins>;
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	bus-width = <4>;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc3_pins>;
+	pinctrl-1 = <&usdhc3_100mhz_pins>;
+	pinctrl-2 = <&usdhc3_200mhz_pins>;
+	vmmc-supply = <&v_3_3>;
+	vqmmc-supply = <&v_1_8>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wdog1_pins>;
+	status = "okay";
+};
+
+/*
+ * Reserve all physical memory from within the first 1GB of DDR address
+ * space to avoid panic on low memory systems.
+ */
+&dsp_reserved {
+	reg = <0 0x6f000000 0 0x1000000>;
+};

-- 
2.43.0


