Return-Path: <linux-kernel+bounces-725852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C711DB004A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1A189A246
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08627057C;
	Thu, 10 Jul 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPvdbf+d"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B165263C92
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156180; cv=fail; b=QYq735bEDBEwtmje0fmiHp8ws7m3xrVR1E9pHsRcF/Y7qud3thXV5FmXtZDRI1H1/0dF3UHJp2df/u3FUwAQRWshfqwvyd/VKgHpypYRy+5AowaUPB9orFW5OmM3gZwdBTNCWy+dppi2DYUD9GCsVFjbSFiucM9E4NrMXHxWAm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156180; c=relaxed/simple;
	bh=t7OXPCqOll4iISOQQ1XTMXs/Vl0Y0R2H8KT7UYBOgFk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anpZo60+PnHA8OUGpMAKlf2JlPUKF6qQx5A7+VlMT/yquxdk6USooxfwgbU2NWF+czptC03mIBiF3S9rYwC1Hv6V/HnANc06uYrLMjhkVaXUUaoNNi1DmAfbJ7N/w8qoT2IQKQPFJi9pEsUepwO3lbv8OJV5+OG1BPOmtvmrDmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPvdbf+d; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjbiFAJIRh+IBJv7ntFXQ+dFyHxbKBoCVf7jwrBysZGhS8qkIaX+U58bz4QlHFyKxls46xiG8R6Wexzd+yIrnyniZMqz+JhR9RICoyCYu2SDi6vlutL/G6ikYR/mP8oAnMJOH94AeTPWz5hs63eoFGa6JJpUn720v7YyeencMxQ5sAlQFjJsPJB40gi6sVkH6qbM1nXgUs2kez7qnVfGZZkxoaXvljAMW4zJB+RB+xO3KEfL9KYs3q71JohcpWDC0oqhisvbueNBAiXs3Xst2LZtQOmuztd1FZ9QP3LHqPPjodeasUBl4cM4r23YYSWfj7zriAnieyRF+Dr0PFuh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7OXPCqOll4iISOQQ1XTMXs/Vl0Y0R2H8KT7UYBOgFk=;
 b=gpm/yDP0eY+Af7UTRmuRRnxlTpt1G4F4Td77KCk7v/jUsMKi5sb0JsUTYpDq/CoHePMAZfVK18MiJbefYcvywbVhuVOVrvPgd4KDzPN61nTqpAqXuKvSr0ztrk8yUbX9GSvX2LLdE9OmFnT1EQdYJgTybJmLmDFdFUp05H+RxRq/odaypQjlfDM4Ej86DsNNRzb+N0S/94BEo4o1mq7+33UCIGXoYTLhqkhzl3GuwK4NpE3vnhtdZgqTi+3vM7QJ9gV5SGG8vk49m0Jx9ywL0VzoAjYD1taN10wDWxNzephVnUjiip/Ri/r3ftPNvXqsDvVe8jk/LEtaY/hLmbXU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7OXPCqOll4iISOQQ1XTMXs/Vl0Y0R2H8KT7UYBOgFk=;
 b=GPvdbf+dWd8qaS424iv6wls3x7WL8L7W+mXkfGEptPD6SyZqXPtivP6xNEHBvRDBmmYxFByUqZXosYLeiHAdVkMMZgJBuLWn4Pa+bkptNK3L72DlRf8m9zDYTolK1FNuM3vNu55itKVY8gpZOBv3idvaO8QVa6aLuMWFIICGxd8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 14:02:56 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:02:56 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 02/21] cpu: Define attack vectors
Thread-Topic: [PATCH v6 02/21] cpu: Define attack vectors
Thread-Index: AQHb8Yd0Aa2smvaeMkOjZr6TRuOzMLQrYrkw
Date: Thu, 10 Jul 2025 14:02:56 +0000
Message-ID:
 <LV3PR12MB9265E7C013D6BBA5E6FB586C9448A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
 <20250707183316.1349127-3-david.kaplan@amd.com>
 <20250710104252.GBaG-ZLG7p_LsNCjBm@fat_crate.local>
In-Reply-To: <20250710104252.GBaG-ZLG7p_LsNCjBm@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-10T13:59:45.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM3PR12MB9327:EE_
x-ms-office365-filtering-correlation-id: 8d121e2f-2619-41db-6fef-08ddbfba7898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WnBjSmkxd3pOTHZ5dE9TZnRPcElsc2ZPQ2wwMWVIaWQ5L1hlQVZZaTZSNjJw?=
 =?utf-8?B?WEFra2VKb3V6QTRDbndMeU0xMCtYNFJUUzRZRmYxTHdVNXRXQnJUem5NUXZO?=
 =?utf-8?B?VnB6eGwzaVVIaElnaEJwUnhDa0pSUkxUdDBhTC9ncW85OStSOEI5TGdHbkNX?=
 =?utf-8?B?WW52b2h6SnlwRXdsTnFxcWRBZmRhNnBIR0xNeHEvRHlUbnVTUjZYdUdxZXdH?=
 =?utf-8?B?NUcvaURqam02VE44OXNkLy9hZkc3V0hKYUFzS2hocHBDTUo0Qkw5U0RraUs5?=
 =?utf-8?B?b21YQ1Fkb3djM0RZbGl6SFp6Y2xkcEM2QnJIdXA0TlN1KzlaR1pxMjlpQlJl?=
 =?utf-8?B?SndWZGx0ZEYvdkdIU0hBMVBrTTVTY3J4enFJdGY0dXJwbkgxblFkejA2QVJX?=
 =?utf-8?B?dzN2dTJLQmI3VC9kbHpsK1dCcjF6YWlFQk8wc01SV0M3RHlYM3dmaHZxMDBj?=
 =?utf-8?B?cDNMUjJiYk5Oam5Xdmx1SkxaQjcvaVMrYlIxOFJyK3d5dW1SUU1XbGFub3FF?=
 =?utf-8?B?TGxIMEFHcTlqNmt5Ui9nVzhpTUhxODUvVWh0UFI4ME51WDgyWk1jcHFBNk50?=
 =?utf-8?B?di9NYlF2MFZBMXVPdEloK0FicGpqSmdyQU0zLy8vZStwYUhyZGREVjhCM2JO?=
 =?utf-8?B?M1pqNnNvUm43Yk12djI3MlNTdHNYZ3ZtUTREdTJvTWZCbFp3SFNPRHhKSldn?=
 =?utf-8?B?YVhYMi95cE5vSCt2YnNhVmYyamlOcWJIQWJaaXZ4Z3ZhZEx6Zml0RlROUkhr?=
 =?utf-8?B?SGUxLzJFQVVJdDZ0ejFUdmUrL0FJcDdDbDYvV3NVZXA1VWhFMWpLTGxYZldi?=
 =?utf-8?B?NXNRRHVLRzJ4TnZrQzhpamR2R09iaFhwNXUybjBFMlBTMmFuOEpTMjJCSWE4?=
 =?utf-8?B?c0lBdTZtVzBRcW5NL3Fjc3NEVGlLNVdFZklPWE03OGZDS3FLcGNpNEp4OWRS?=
 =?utf-8?B?VXlNL0hlcXBtdG45VEk4bWZyREhybEFPU1dDSHZ1SGtaTTNuVTk3bVVvUEtm?=
 =?utf-8?B?NkY0eVhxVDlNd29Jem55TDRPR1U0K2JtVnluRlZ5L0JaK25ha2tlTDVpV2J4?=
 =?utf-8?B?TlNuNUdEUjhLZUp3RThaRDB3OFY3b3piMm9rVFo3MDNlZCt6c2N0M1c2TWc1?=
 =?utf-8?B?NVZvWVF4SU1yeEZtRWszY1JxUFZZOTcrTnhrTUxJL3J1VzZoU3h0clRGVzRm?=
 =?utf-8?B?WnFWM2dQZVpUS0ZaTWo3TmFZenhodXlyRGdYZG5tbFJkcHN1bFJTZmJISHNS?=
 =?utf-8?B?cTF1NWlzbmRmeFF5WG5DYkkzQTdlMVpEUWhYd0hzK0x4ekhDRC92cXNDWG5h?=
 =?utf-8?B?OE50MTFpV3NrL2toN0ZrVEpmR3ZrL3hvL2NaT1RPYlZFYkljMFkzZjRCR3F5?=
 =?utf-8?B?V0V2bnVaOXVodWpNMGR2M1BWdFJBa2tHTWJtRDk2VmxUUm51TVl0ZHAyTysy?=
 =?utf-8?B?NFFKS24wbmhucHlmUVRXWWt0eVJaNWI4eUNldU1pL3I4clQzNFRtelM4VlZ2?=
 =?utf-8?B?ME9wRlVlWG00akJXb3N1MWdaaUpNVTE0UDczcGxGQ3BZVUtaektIQ01la3dJ?=
 =?utf-8?B?OG5lWlFKeUlnWDNHdXhzdExxcXFQNjB4eHZObmoyaGszWElkSDhJNTdCaHZR?=
 =?utf-8?B?QkR6enA2YXZseGhiaGgrOUF6OGJRZk1MTW5XUlVvdlRSQTYzM2ZWcTNKOFJP?=
 =?utf-8?B?UzE5RU84STRndmpEZ253T0pZNGRqVUdGRGI0aVlFbDhHakRXOWQ4VEFJd0xB?=
 =?utf-8?B?eEl1c1dlbUllYUVXOVg0cTc1dk4rTzBYVXZOWU00Nk5zU3I0b0Jia2MwRjVV?=
 =?utf-8?B?Qy92aXlhUStGMEExV05acklySTI3U29RVkF4Vlk1bCs1a2NNbFpsOHhEelhk?=
 =?utf-8?B?cGh0Ny84THlmdUZiWFhsZnhkbTMrbDliMlFnQVdleDk4dVJWMUp2TWVwZzlN?=
 =?utf-8?B?QjNmc3A2dHJuSkM5aUQzRE52K05rZkxkdlVUc1BIdU9seHk5V0FkZTgzaUV4?=
 =?utf-8?B?c2xqQmEzOENBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejZYdGNxaGgyK3NEUXI3RmVKOFhUWStQazd0WGRYVktSbkltVFg1M0ZPYXlN?=
 =?utf-8?B?bFcvcHgraE9TeFo1blZmK3FsaG56YXhmUGNHVGUrSDc5dUpPZHFpWFJEV0xZ?=
 =?utf-8?B?YkRQYTZIcVVHNG9MUWdnNzFLWldCSDJvU0hrN2dNMmtBZmRxOUkrek55Ny85?=
 =?utf-8?B?N2lrZnJ3aUloQWFVdnRQc2RBKzRCaGRuMHU5Y1hQbFQrNlFyY2svSmRtb3ht?=
 =?utf-8?B?TCswMHFMQ0diNkVZSHFidGVuTUt2TlBkQXU0aGhoOTBOeTZOMzdaR1NQY0dH?=
 =?utf-8?B?dnZVNmpkbTdkamlpUGgwUDVYMWZiSDV1MzgxbmNrbEtxMTN1V1pqNlRjZFpD?=
 =?utf-8?B?bWtOdFA0bjYwaVFIU3dKSUllZzF6Qjd2VmhpRnJDbzZhOW1ESCtaVGlhM3la?=
 =?utf-8?B?STRMdzEyTmk5bW5SN092b0NjR2J5NTlpMnFDTVd3NE45a0luSXptc2FYbUtp?=
 =?utf-8?B?bFpQMGw4V2pWOXRlbVBYMEd4dDcybDN1YTRwNTlvL21rNFpoOUowb1BqUTRk?=
 =?utf-8?B?REFmbllZSDY2NjR0UXNQT1llMXBaWXpnc3QyT3hma3dOdTlsOUxzcjRqcm52?=
 =?utf-8?B?WGVrdFVDL1hKL3VLQVQvc2M4emNIdDd1MTNzWkMwUC9vdTN5U0g2N2lmWjY1?=
 =?utf-8?B?cTErb2I4OHJLTFBxN29aWUZzejdPOXNlYWZkWnRRNVM2RUJPK2l3WDFJMDRZ?=
 =?utf-8?B?QmpRQnU4ZWtVY2RhVHFLS0hDNEp0d0NVL2txdDdwcVVFWTB3NCthcDYzaE5P?=
 =?utf-8?B?ZTNJL3RFWE1tZExLOE8zaVBGcjBVUlM4YkZseGdKN2o5WFAvY0R6eTNsWnFa?=
 =?utf-8?B?M0l3RGkvWGRkTU43N2xnbk5uQnBCZDZRV2dDeXhQVDBFcVVGUzhpV0pmeTBa?=
 =?utf-8?B?TXFEWU9tRTVrcUhTSUFkVVMzZVI5bHRUaVVFYzJURU12Vk90bWVibGcxandp?=
 =?utf-8?B?dnhkT1paZ0F1S0ZYcEp6V2ViSXNoTTZ4aWY3WS9TZFJaeWJBeURCeDJsUVoy?=
 =?utf-8?B?SCtrUXg4NHEySnRQMG41VHZrcTR0ODM3c0hkWU9HV3pRZllpNWg1eTU4KzFF?=
 =?utf-8?B?RnJ0dHlUb0U2cjRYaHRYVWZmVU1UOGN4NmtjZDZSTE5BdzdpMjc2UHhDRTZn?=
 =?utf-8?B?TTAySFcvbFYyU2lTTHpuVWZqUlF3SG1nQzlmaWxHTUozZ28xbnJpcXlGb0NP?=
 =?utf-8?B?R2EvdC9NY1R1YXRuZiswai9mb0svZWM2N0xkMVJLM2R1YzlqWVM1TTVyOGJ3?=
 =?utf-8?B?UnZjay9BSkljOHBaU2xGY2ZXTmRmNDhzSXNVTTBqa2RrM21UcTJQWFYrWVVP?=
 =?utf-8?B?cGwyMGV0SWR4UEs0RU9CRVFqRmwxUnhWMWV5emR1VFhHMUxzS2pEN2VNRVF1?=
 =?utf-8?B?NXBPSkxHdVVNS3VVazFONHh5Z1JxTm1UNkV4OEJWZ2JYcEY4bHBMdnNWaWR1?=
 =?utf-8?B?VGZJa2x3Nko2K3BBN1lndWtZOXNyUmdSNUxyZ0dUVHJxem1QQjlLYVlkekY4?=
 =?utf-8?B?RGdXZ2Zwa0w0UVJxSFMwYVJmNFBPV1kzRThxYUhmdTFBU0JYMnRXbFo5USt5?=
 =?utf-8?B?SklvRTZOYWdGQkFLakZXZUpITk9Qa1lHNHR4S1ViT3RTaGQzVjNPRGducVJ5?=
 =?utf-8?B?bjVWTkcyckZRNTJ4Nkx5bExDTzA1YXdBTFFkWERCMmFpcW1BSTA0NTN2alFE?=
 =?utf-8?B?N3F1SGFYelV0VnFGS2JmQUM3eEVEMTlZMXY5WjJJWS9qcnFkYXBHZUpjWmJS?=
 =?utf-8?B?Y1RmVVFoQTVvTlFiVWFDUStXVHVubnZtZDk5ZG1FWU9mRmZ6WXRYVTh3ZXFp?=
 =?utf-8?B?SnVMSDh6aVJKUFRQTUlmaGlxUUhvaWNJbnFvZ0xoZDJsdTduNmgySE9lekcx?=
 =?utf-8?B?dnVFNUdmL0QvSUJCaFh0aW15MytCSHJhVWcxL2o2clJuYlRQOU1VV1llUlVz?=
 =?utf-8?B?aFZyNzhKenJQZFlpQVZPSDZRdk1ReVBHYkRVemtaNy9NaEx6dWVtSVpyMk1G?=
 =?utf-8?B?Ly9ST3B4elVYYXA0WGZSVXE3TXBuWVpCZW15eEhrU1NrZ25KNVRBVytzUVRV?=
 =?utf-8?B?eGYzK3lBcXBGU1R1eE1BNWJMakhaTHp1dTRYNHh2aFRsbWhKRkFJTWZRZDYz?=
 =?utf-8?Q?zVXI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d121e2f-2619-41db-6fef-08ddbfba7898
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 14:02:56.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTtp70N0wmqT8ITIylHdNmQylCBdM2l0Uts6ciapm41LVFeBv4cvzatl17nsjjK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTAsIDIwMjUgNTo0MyBBTQ0K
PiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3
YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRv
ci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMDIvMjFdIGNwdTogRGVmaW5lIGF0dGFjayB2ZWN0b3JzDQo+DQo+IENhdXRpb246IFRo
aXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVy
IGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3Ig
cmVzcG9uZGluZy4NCj4NCj4NCj4gT24gTW9uLCBKdWwgMDcsIDIwMjUgYXQgMDE6MzI6NTdQTSAt
MDUwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+ICsgICAgIC8qIEF0dGFjayB2ZWN0b3IgY29u
dHJvbHMgbWF5IGNvbWUgYWZ0ZXIgYSAnOycgKi8NCj4gPiArICAgICBpZiAoKnArKyAhPSAnOycg
fHwNCj4gIUlTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX0NQVV9BVFRBQ0tfVkVDVE9SUykpIHsN
Cj4NCj4gUmlnaHQsIHNvIHRoZSA7IHNlcGFyYXRvciBjYXVzZXMgcHJvYmxlbXMgd2l0aCBncnVi
IGFuZCBpdHMgc2hlbGwtbGlrZQ0KPiBncnViLmNmZyBmaWxlLiBJZiBJIHB1dCB0aGVyZToNCj4N
Cj4gICAgICAgICAuLi4gbWl0aWdhdGlvbnM9YXV0bztub19ndWVzdF9ob3N0DQo+DQo+IGl0IHNh
eXMNCj4NCj4gICAgICAgICBlcnJvcjogY2FuJ3QgZmluZCBjb21tYW5kIGBub19ndWVzdF9ob3N0
Jy4NCj4NCj4gYmVjYXVzZSBpdCB0aGlua3MgaXQgaXMgYSBiYXNoIGNvbW1hbmQuDQo+DQo+IFdl
IGNvdWxkIGRvDQo+DQo+ICAgICAgICAgLi4uICdtaXRpZ2F0aW9ucz1hdXRvO25vX2d1ZXN0X2hv
c3QnDQo+DQo+IGJ1dCB0aGF0J3Mgbm9uLWludHVpdGl2ZSBhbmQgaXQnbGwgY2F1c2UgcHJvYmxl
bXMgbGVmdCduJ3JpZ2h0Lg0KPg0KPiBVc2luZyAnOicgYXMgYSBzZXBhcmF0b3IgaW5zdGVhZCBz
ZWVtcyB0byB3b3JrIHNvIGlmIHBlb3BsZSBhZ3JlZSwgSSdkIHN3aXRjaA0KPiB0byAnOicuLi4N
Cj4NCg0KSW50ZXJlc3RpbmcuICBJIHdvdWxkIHN1Z2dlc3QgYSBjb21tYSBpbnN0ZWFkLCBzbyB5
b3UgaGF2ZSB0aGluZ3MgbGlrZSAibWl0aWdhdGlvbnM9YXV0byxub191c2VyX2tlcm5lbCIuICBU
aGF0J3Mgc29tZXdoYXQgY29uc2lzdGVudCB3aXRoIHRoZSBleGlzdGluZyAnYXV0byxub3NtdCcg
b3B0aW9uIGFzIHdlbGwuDQoNClN0aWxsIHlvdSB3b3VsZCBoYXZlIGdsb2JhbCBvcHRpb25zIGNv
bWUgZmlyc3QsIGFuZCB0aGVuIHRoZSBhdHRhY2sgdmVjdG9yIG9wdGlvbnMuICBCdXQgc2luY2Ug
Y29tbWFzIGFyZSBhbHJlYWR5IHVzZWQgdG8gc2VwYXJhdGUgdG9rZW5zLCB0aGF0IHNlZW1zIGNs
ZWFuZXIgdG8gbWUuDQoNCklmIHlvdSdyZSBnb2luZyB0byBlZGl0IHRoZSBwYXRjaCBkaXJlY3Rs
eSwganVzdCBwbGVhc2UgcmVtZW1iZXIgdG8gdXBkYXRlIHRoZSBkb2N1bWVudGF0aW9uIGZpbGUg
YWNjb3JkaW5nbHkgdG9vLg0KDQpUaGFua3MNCi0tRGF2aWQgS2FwbGFuDQo=

