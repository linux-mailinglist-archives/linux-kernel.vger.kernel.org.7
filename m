Return-Path: <linux-kernel+bounces-784572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B3B33DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EDD205E68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC382E1C79;
	Mon, 25 Aug 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="Vg5gZCW8"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022117.outbound.protection.outlook.com [52.101.126.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FC2D5406
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120166; cv=fail; b=Hw/2NZPsVKwo5S+BJz6LnPXPM5X1geaqENz8f7LtDaxp37wM1nmmlc4zPP8UeUv2OP5kAbN4hvDFJuS09gt0bie4HFTiH31KXMBD/XphXoR2x3Jvo9K9XhNVReAV1SezjhenVFczjTlTLxNBGm6yYixNCWR0wbfldqcGbaUZJFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120166; c=relaxed/simple;
	bh=SA7qsg9UNDKLka9ck44Dy3mcI0DIqVXpGoDdmz9vW5w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iuqYXWz8gmfkDTCJPlh255Zx/KGL1X9gbtMCdZQ0xBYxVaGQhhxLwGEqARGFuvxPFLIvYWp2cj0tGPyL15GYaBy7f8gbzI/rVaNtrKgkVZBTA8/yqBToOT2s7TwfOO30zKYWDCfmlWUQngJMCry4tACQSz9rsN1M/7sdKSLjUMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=Vg5gZCW8; arc=fail smtp.client-ip=52.101.126.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAq8ZD8mEx8Jxg1mXe05zbCHfUrn6BigubfkJ8i5M2AndMBh3GIH39bnhBVflxOxxYyFD5PNeYjg7rpipYj6jv+0FT+LT6zLt1nZfIb/tZ6w6083RyYJyUDdXva0SMPxVv2JIj2TXHDCpjD0XU0iRLoT/RbOtc9w9C0VSHkLiE9lf5zOXC8FKxb0Dr0tp4Fq5khw+hWXIOSsYcO427SbmELCZmGxbTdHUoZ5fm3SI8WTZfCPGEmchtyO7ViHshE/HobN6bqKLdxr090PzGtq337qZi41LMo3LorSsrItGBGVhg+LFC2N/nqtxaXtMWNgvRbREoL1xcCmEtL4+RCKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA7qsg9UNDKLka9ck44Dy3mcI0DIqVXpGoDdmz9vW5w=;
 b=ezOUHTXtKyyrPKTjnKof017LItw0QhY83gnDD3pB1IkcgpxD41ccgMcWF857aKGyWTwe4DeLoyAr8LqCbyf6BUhMtj4N8kchH7CNnU6Dh+QbVjUljee2IsPUsg7OUXey1rgo0X/DaqxrXQgN46QNPvfK5S4gbBS/zNOjIdDmWb5v9Ude81Cn6uvF8DtDtyhBkrkElbKdlXjjQW2dGsSU+jfRPqeDjbnhYCUkKGNlRm7D7gXPhznWYLuN4g4Y4Pep9eeiNmjKSIGFU2ACXf814/6K5t9CWmbtpvv0/qym2vyzs8E3dCEtXEfrQxLPZFf1sGiqXMe9C6701opDRvRTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA7qsg9UNDKLka9ck44Dy3mcI0DIqVXpGoDdmz9vW5w=;
 b=Vg5gZCW8knDWSZ9YEIGJxDd92slfPBLC/t6tgZlc0Vl5pP5FUdhyf39v9IzqDCtT7P3+CURXebSnDgb7viWSFiMbEa+RaT9HNcKXqLlkMuGD7KBbsXD40O1Qfmq2eZB3veMsznXos+FiHh4091PvjiqM6IlsLxhieAgt/1WuehM=
Received: from KUZPR04MB8965.apcprd04.prod.outlook.com (2603:1096:d10:4a::6)
 by KUZPR04MB8927.apcprd04.prod.outlook.com (2603:1096:d10:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 11:09:21 +0000
Received: from KUZPR04MB8965.apcprd04.prod.outlook.com
 ([fe80::4992:f5a2:2328:6b52]) by KUZPR04MB8965.apcprd04.prod.outlook.com
 ([fe80::4992:f5a2:2328:6b52%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 11:09:21 +0000
From: =?gb2312?B?bWluZ3podS53YW5nKM31w/fW6Sk=?= <mingzhu.wang@transsion.com>
To: "kees@kernel.org" <kees@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com"
	<david@redhat.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org"
	<rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiazi Li
	<jqqlijiazi@gmail.com>
Subject: [PATCH] kernel/fork: Update obsolete use_mm references to
 kthread_use_mm
Thread-Topic: [PATCH] kernel/fork: Update obsolete use_mm references to
 kthread_use_mm
Thread-Index: AdwVrn4fgOowLKw8Scatb5BbeQ28xw==
Date: Mon, 25 Aug 2025 11:09:20 +0000
Message-ID:
 <KUZPR04MB8965486F5D00D5B7BCC0B4738F3EA@KUZPR04MB8965.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZPR04MB8965:EE_|KUZPR04MB8927:EE_
x-ms-office365-filtering-correlation-id: 2eda7e8d-fbbb-49b5-20b5-08dde3c7d775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?byswSVZWNWNRLytqdDREQThXOUsrQnhuRTJuQS93ZVAvNko3dkx6aEVpYjhh?=
 =?gb2312?B?SDMrMEpJMU9IWlJ4UVRLNUJDOU5SeUJuSm51OXBkNWpvVzc5MDN4QzdMUThx?=
 =?gb2312?B?RXVmaHZxOURPZ0J4WVVnMEp1OEV2QXRYZ0VjZFUwWjQxYlcrZnI1QTVtS1FO?=
 =?gb2312?B?STdqai90V1NwZXlJUkRwN0E5S3ExZDhsTUx5V3F1RGdCWDBYYUQwQklGT1M0?=
 =?gb2312?B?NVdQZUV0OFFGditHVmtDTWVZY0FqZ29hYTVFNDB1VzRRNFd0RGlobDFySGQz?=
 =?gb2312?B?Y0tQdVpsZVQ2WnpPeDM0Vy9jTncwdlg5eWR2dmtSRXVjVkNLZ1BJdTd3NUtG?=
 =?gb2312?B?bzBKaWRqbGxNckRib0xQdDRvZmRocWV2YU9kMERyR3EwWWtFU3JrckdPWE8y?=
 =?gb2312?B?eENIYUpMS3dEY2lpMHhQMklQTDNnRkp3eEYyWXg4dlNncThzcXJCMGlVbHhE?=
 =?gb2312?B?WDJJQ1lCK0psOUNRdDRsbWZxVWNGTVBzeUZERzRLdUpDOFMwVlBFcXRoWjRs?=
 =?gb2312?B?MUFtS0p4dHdZYmdMZWV2YUVRMXRKUEZobGhrNjF2WjI1ZFRpd3NWS0JLbW5m?=
 =?gb2312?B?UzFaZEphQldNOGFzS1VZbi9uRFBkL2N1YWM5UlZTSkQzbE1mbkg5andkYmV3?=
 =?gb2312?B?QW83c1dwUGlqYWdudDAyU0hnRmx5MmZPNVp1L1grWkgxTnZUVDZWVmdhcGZw?=
 =?gb2312?B?Ykg2SUx3Qi9KRzViaHp3S0labkg0SzFaWUJ5N2FVTnF3R1ZDSDlUWFhxQVNr?=
 =?gb2312?B?M2k0SjlJQ3F2MlFqU2E3UCtsWTRTY0ZTelNVZVpRV0g2UUNrcTN5NjgyZUZP?=
 =?gb2312?B?NVYxOVB2RmF5NjJERXhVZDc5anI4dGgrZGoyNVNnUEh1TnBMd1FpbFRYamRT?=
 =?gb2312?B?eloxeWlxZjVNWG9qb0IxUVhDSGU3MndZQUZON1BBZ2M0RWJsYmNwRm81R0w4?=
 =?gb2312?B?T0tVTitRdEdpRzk1d281MmovamtKbGRsbzFBNmZXN1U5UUh0MHdEK2xJQXpT?=
 =?gb2312?B?R1dwQnZlVlViNC9vcTZZdzNKMllSTG1JTlY3SUtQenBUK05BRlFNQ29Uc1hS?=
 =?gb2312?B?SjZ0NDV0WS9zMUJ6bUlWVmJ6TWJjalQ4dzhjanNxeTJkRVpOdG9oa1NWbFJo?=
 =?gb2312?B?Z05NdTNuRzNCZnk0ZU9JdWhBenhKZkJ0bE5LTmlRS29UMGg2eEVSNytFQkpk?=
 =?gb2312?B?SzE2cE5sVXdybWI2aGFrSnU1OFZqV01QUjhNcG9hTlQzS0lnb1MyQk00a052?=
 =?gb2312?B?UVBESDdsaEZVRnZ5K01kaFF3amllVy9VeC9ueTE2d01UOTE2bEVZL2FZTEox?=
 =?gb2312?B?aGZOeWZRTTlrT0tzOS80NXU3N0NQbGQ2Z3pvSmQ0ODMxVEtHV2NMYmZZRStB?=
 =?gb2312?B?NTZ2WFd6STB0MkxaMW1XejRiOEs4OWVzYkJaSU1MREFrUmVMSFZRVnBHMmpJ?=
 =?gb2312?B?RW9SUGp2SkNjOFAzUzhheG5YTU5BY1FCZWVMdE85Smt4M05UZy9pUmUxU3hN?=
 =?gb2312?B?RW92NE5QSUJUelhGSU1YSTNNNEFZbG44bWplVVhKeGRCcmVvR2hOMXpjaEFI?=
 =?gb2312?B?WFFBcnNhUUlxb1d5U0ZkdlU0YnVJZ1c5TkM3OFpLdVNxUVIyZ3hicHp0Uks2?=
 =?gb2312?B?emxUNm9jamVBMUxNWlAyQ1Rza3dlRUNaeGlqbGdDdXhleE42QnFUWS9ZbXpQ?=
 =?gb2312?B?anZRSXMxUEJveUMzV1p3T1pvWElhUmJMY2ptbXFoSDhqNSt2bUk5OHByQmMr?=
 =?gb2312?B?eHVMbEoxbTFCczZ4SkEyVm51RlZQQW9GaTM5akdOTDhxQTlaUmVPVStQSVNy?=
 =?gb2312?B?aHNLVGlkY2VNdHVGcUpVREZ6alpwdCtUMkJEZVcxZFdjZnpFQzJxSEFYOTd0?=
 =?gb2312?B?bjhCZXB3NGNhYjM5OTYvaGFBclErS0hoR3JkZ2tyTlYvbzBzMkdEbGVnZExC?=
 =?gb2312?B?TU1iZ01sY01KK3oxUG5mWUlVQ3ViMTA0S2UzUFJRVDdrZ2p0WWxseGhBOFlu?=
 =?gb2312?B?Qld3YW1XWXRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZPR04MB8965.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?akpOSzdJbnJwbDJYblVWTXRXanVvbjRIWjNXY0xpS0tVelFzTWs3Z0liLytN?=
 =?gb2312?B?enp3L0hVaXRNWkhBRzNXaUhPazMrTlZNOTFwc2U3Sk1KWmV1R25LS3liZ1Bx?=
 =?gb2312?B?MEpMaHB6QlJud1M5MEVIVkNlYStIN21TdXR0M1ZzOHJXdkZKdU1Sd3ZxaE9C?=
 =?gb2312?B?WkFsVzUvM2tCdXY5bmVMUGpScHFLQ3VGNVVYdVBZTWY5LzhuTXFpd1I0ZFVh?=
 =?gb2312?B?RHdQaXB2Q0ZvSjE2Mlo3WUg3d3ljQjUwb1JrYVBkKytxM09WMG5QbHdSL3lp?=
 =?gb2312?B?djlIbmNrZ0Q5WUdRYm12RndvWG9JSmhXYzk2MEtUb3QxRlZMMTdnR3V1VzVQ?=
 =?gb2312?B?T1ZzMks2L1RzZ1NtTEhhU2NrcG43Mm1JYVhXWTVpNk9FVTVKT3dnOEsyOUdB?=
 =?gb2312?B?ZVJDR0ZwWlhsSzNJdlFaakJxaDZhTUxyVHhtZXNIVy9jSUZVL0d4UXZJN3Rs?=
 =?gb2312?B?d2pUcmN2d2hZbWtZOUtTeEx5YzhrSHF1VnF6SjVsdWFlaXZEUkJEOWRZVy9z?=
 =?gb2312?B?SkNaNTIyZnZPL3E5cnJNc2hkcE02cXh6UUV3WGxGdWg1aHJwWEczNWF1Ykl5?=
 =?gb2312?B?cGpaS3Z1dTROVmg5VWFZbmdhSm1yWkdiYWhEcHRpNk9MeWl4SHNlTm0xYlV4?=
 =?gb2312?B?MXNibDk5UEVCbHhLa0RDREtiS2FQdkE3QjVYZDFqSm5HYWtmMWdCcnllM25s?=
 =?gb2312?B?aWxsSHRzalJpVTUxajFyNWFrSlJSOVZYbk01V1NlelAyN3ltKzBRK1RGV3dW?=
 =?gb2312?B?d1BpbnJHSzM1OGdIZS9RS2hVY1pITjNYaUlaT0VOb25QeU1PdUZ3Y0R5UUhK?=
 =?gb2312?B?djBlVVJUazBQQ1h6UG9scU1vSld4a3FyTkVkZ1VQVlROb3l0Y1lDcXJiV2JZ?=
 =?gb2312?B?a0VyVTF1S1FiK3dFUXROOHJWYmJid3poUndxTkNyYVNSZHZHN2VpQXJMeE13?=
 =?gb2312?B?MXNIMzhva2gweUx4b3RoOURFVUpLd3BnOUMxVWxiK0E5L2hnRVJBYTBURVRD?=
 =?gb2312?B?bjBtS2Q1WkwrL2JxTjJIZWdycWpRaVNFaHdVd0xwdlpDVWtxRXJoclVCaTZo?=
 =?gb2312?B?UlcyZ0trK21YNm9ueU5oU1JTTWZ2Tkx2eFFMcE9CaCt3RUZNNlR5dXNENGxv?=
 =?gb2312?B?clNLRUVVRzZMbWNtbEZOdzVDVUtHUGFkc0JiTm8zWmpNdGZpTWZOYTRNbExt?=
 =?gb2312?B?alpvQXdmZktQVDRWY2hONEM3L1hNU2JPSWlrdEhhVTUxdSt5aVk5SWU3ZFgy?=
 =?gb2312?B?M0xKUytaZTNIOGtWNmVlRHRlcHRVaU4xR2VYaE5JeitYM1VYaGJaQ0xwc0hi?=
 =?gb2312?B?L1FVOVZDQ1YrZVhrRXVLSWFXSUhPWC94SkdxZ2tBRnNidmh5d0k1KzVvRGVQ?=
 =?gb2312?B?T1d3SGtaZit5dnpFZy9aK0tOR0VjYjVWY1J4eHQvQW9Ka3l1azBNL0h1cDc4?=
 =?gb2312?B?Rm5FT3R4clpkS1Ftc050NXBaQ0FLSHhlK2lMNzk3bHQ1NVk4cFprZWo5SElq?=
 =?gb2312?B?SnF5Rkp3QXJnaGtUM2N4QW9TUStZSU1ERDBnaHZWMW1HbjdxU0U4UnM4U0t5?=
 =?gb2312?B?UmpyU1QzQnJBUmdRb1VCUk8wODRQcDIxS3ZaTTlFVXRBL3ZKcW9MVDdBSmhm?=
 =?gb2312?B?a0JQV2tLRThpZlc4bTMyZXFFTTFxTzdRbEpsa1hkQXBpMjZvNDhRVUtDMHBS?=
 =?gb2312?B?OTArbnZITUtoWnBMenhqZWRjZjR0TFBEUFphTTZVYUtHUmRpWTJhWEptRHRE?=
 =?gb2312?B?eS91UXo2cmhhbzF1ZWM5VktEbiswd0xYVTkycmNYWUFCQXpRRDBBaStXcitH?=
 =?gb2312?B?YTNaR29XN2xXQng3M0hQaUJkWTB3T243RXE5TVJTbkRjc081UFkvbjNMRytZ?=
 =?gb2312?B?dW1lUmlYTjBVVXRkaElFbDdjL3ZWQkhrOXZ3TjNoNE4yRU5xK1FXNlZiRitm?=
 =?gb2312?B?MkVFM2JlNG91K2syQUV6Zis0TmdCT1pKODIyMjdqZWR0QzN5Tk8xM3RPSXhi?=
 =?gb2312?B?L29SYThtdFgxbHRNOW53aHhiVXNXK0tqQ1FZYU5LYkRHeXVxYUFKb0VjSGJs?=
 =?gb2312?B?RjZDTGFHeEVvSXl6WC8rNzBQZWFYMEZ0MHozOGErODc2aUdCclBmLytCSVpP?=
 =?gb2312?B?cW5BMHg0NEgyM0VSWm04d1FwODJ0aE03SlV6Rmd4S2VQdnlmdTQ1eGxqSUls?=
 =?gb2312?B?R0E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB8965.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eda7e8d-fbbb-49b5-20b5-08dde3c7d775
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 11:09:20.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSOhgR13U6cD42aMK/pPNaXbsJ2fkDsPCijkLGh9QjicU1VZs7/9LQ+WFVrlZGQGQ3db8kYui6QPyqeb0pcpzGt1rldd8fJwBtOJKW+L8rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8927

VGhlIGNvbW1lbnQgZm9yIGdldF90YXNrX21tKCkgaW4ga2VybmVsL2ZvcmsuYyBpbmNvcnJlY3Rs
eSByZWZlcmVuY2VzIHRoZSBkZXByZWNhdGVkIGZ1bmN0aW9uIGB1c2VfbW0oKWAsIHdoaWNoIGhh
cyBiZWVuIHJlbmFtZWQgdG8gYGt0aHJlYWRfdXNlX21tKClgIGluIGtlcm5lbC9rdGhyZWFkLmMu
DQpUaGlzIHBhdGNoIHVwZGF0ZXMgdGhlIGRvY3VtZW50YXRpb24gdG8gcmVmbGVjdCB0aGUgY3Vy
cmVudCBmdW5jdGlvbiBuYW1lcywgZW5zdXJpbmcgYWNjdXJhY3kgd2hlbiBkZXZlbG9wZXJzIHJl
ZmVyIHRvIHRoZSBrZXJuZWwgdGhyZWFkIG1lbW9yeSBjb250ZXh0IEFQSS4NCk5vIGZ1bmN0aW9u
YWwgY2hhbmdlcyB3ZXJlIGludHJvZHVjZWQuDQoNClNpZ25lZC1vZmYtYnk6IG1pbmd6aHUud2Fu
ZyA8bWluZ3podS53YW5nQHRyYW5zc2lvbi5jb20+DQotLS0NCiBrZXJuZWwvZm9yay5jIHwgMiAr
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMgaW5kZXggYzRhZGEzMjU5OGJk
Li42NGUyMjhjNTQxYmMgMTAwNjQ0DQotLS0gYS9rZXJuZWwvZm9yay5jDQorKysgYi9rZXJuZWwv
Zm9yay5jDQpAQCAtMTMxMiw3ICsxMzEyLDcgQEAgc3RydWN0IGZpbGUgKmdldF90YXNrX2V4ZV9m
aWxlKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaykNCiAgKiBAdGFzazogVGhlIHRhc2suDQogICoN
CiAgKiBSZXR1cm5zICVOVUxMIGlmIHRoZSB0YXNrIGhhcyBubyBtbS4gIENoZWNrcyBQRl9LVEhS
RUFEIChtZWFuaW5nDQotICogdGhpcyBrZXJuZWwgd29ya3RocmVhZCBoYXMgdHJhbnNpZW50bHkg
YWRvcHRlZCBhIHVzZXIgbW0gd2l0aCB1c2VfbW0sDQorICogdGhpcyBrZXJuZWwgd29ya3RocmVh
ZCBoYXMgdHJhbnNpZW50bHkgYWRvcHRlZCBhIHVzZXIgbW0gd2l0aCANCisga3RocmVhZF91c2Vf
bW0sDQogICogdG8gZG8gaXRzIEFJTykgaXMgbm90IHNldCBhbmQgaWYgc28gcmV0dXJucyBhIHJl
ZmVyZW5jZSB0byBpdCwgYWZ0ZXINCiAgKiBidW1waW5nIHVwIHRoZSB1c2UgY291bnQuICBVc2Vy
IG11c3QgcmVsZWFzZSB0aGUgbW0gdmlhIG1tcHV0KCkNCiAgKiBhZnRlciB1c2UuICBUeXBpY2Fs
bHkgdXNlZCBieSAvcHJvYyBhbmQgcHRyYWNlLg0KLS0NCjIuMzQuMQ0K

