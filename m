Return-Path: <linux-kernel+bounces-842518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECCBBCE98
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912EB18943B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC86B1A0712;
	Mon,  6 Oct 2025 00:58:35 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020089.outbound.protection.outlook.com [52.101.195.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352E4A33
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759712315; cv=fail; b=bOwPsCI2dfFypZtseOncnrsRy1rxKkCefDmWrdUEpXb6ZWGjgVrYWy4UuiF72HyDy9bqSz4ef+q9wDlN4M+v+JdU9IfqY5yfYjRDKVqeCIyFWV6TtaZYlBNVNBE7St5wBLuxPX4sDR7PtoyA5Y03GuKAzft+mzkru81TFTZ+K14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759712315; c=relaxed/simple;
	bh=KR0je4h0wAc9Tg7dUYthszKb+s903zpwnr7h+5gmW0g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=coRmAXM0ahwYUJuwypYdI7ueCBQBG91eAi//5Ap4OzhSteMptVAlYNn+/tlZAapeiY+5iCXeh7+E8/VypFK2HlZPR489X0Nb3jrzkQI/BgPcqNW12rFmGOSktenrGFGDste3Sdm/FRA0H+0AL3F7JoBzPFZdvfQG1nwXo8+dTIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSHMWH2nRqtC5YS9njQA2ValICqqdDypVVHU0aNGo3uZxlN7higlE+pV5b9YeX458IM81EV6dpPL0JK1fIhXgHabRW1l6XyqwdNUrWe0ePs75qOcSEgYk4edEVmwNL2juKRR3D84OJ/dBM3ywrPia4ObHKMwYAumiQT9exOdBFIHyKSGh9h5iGfx0JHDj+8s8c+WfMasRVkjLd3/YldoTsMO1yEnXScnuT/s8fnP7LqoAtzuXDZK30lVIFgc99HhmffaUrIwlL/MAQni0ScaGabkmQymF3gbf54ElJSsijiJamRfdVP6rLSULL8RR9ZchKQKFWuBPAHMPpba2ucbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+YnG1W8hn4UFHq2s9cGgVgVQyIW+8VVQsp9RbpuTEg=;
 b=gdqagWujtBQWVz76rxZdgLM3WCrLqgnijDFY4aXPNSZ7LRArvV5RMneL7hsbiTcuimkOVXQstXB+kcQlFhzoMCHsGf1t/0/OqtfaEGkwib8vNVMY977W/lrIoSW2aB2iRo2GZ9iqSDCfDiDC2msEh43hVKjyXmxXbu0noZ7yoo8RPmxq23kwkRd7YqGH/6BmKn347EkqfAIGI988Xm7ULqvhqRRzztUlqoTqhEu4zZOqcJP/gWasCr/2joziVNeviWvaKLfCCNTAiLalyZb9ZULAElN4nFpceNGcn8Ny9wDPQRJrm+gG290ulLDMVuA0kwvWAwOdod+0u8GaDonTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8392.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 00:58:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 00:58:28 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tick/nohz: avoid showing '(null)' if nohz_full= not set
Date: Sun,  5 Oct 2025 20:58:24 -0400
Message-ID: <20251006005824.76187-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:408:fd::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: fea89674-3f46-41e4-c883-08de04737641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aE84MDV3eVp0M25MNTRoT0FjZW4wbHpqWDU3ekkrMFR3d3RnUVJ5L1VuL3V5?=
 =?utf-8?B?MEw2ZUg3ZFA4bXRwYW1HTmN3N0RiMUhqSDZVa0NGN1FoNG9rek5BL1VXbi9W?=
 =?utf-8?B?VzR1SG44Zm04NTAydzNDY25kYjhCUTRrSmk0OFo1RDYxY2R0SjZUYngzYVAw?=
 =?utf-8?B?YTJ5SUNGYkJFL0xCb2MyK29YLzI1TXAybi80MmN5eE4ySzFsVGVkSmM0OWJK?=
 =?utf-8?B?bzJQQTBDci9ySXNHSEliVzNjYU4wMG5UTTR4V0ZsVTQ5SnRTcThHbE9hcGJ0?=
 =?utf-8?B?b2kybDd3bVBGRmg2KzkvMjV5YjRjR2xRTVdlc0tRQkJHSURBZGl6UzNWV1VK?=
 =?utf-8?B?YjQ2ZUZqaW9WR0dZY2kwaHBOVEFHdTBvdEszU3EyUjJTTVI0SFRYM0NEQWs1?=
 =?utf-8?B?NVpBTFZLNkVIRERxeWpBbVBlb0JwSS91RExHMGdiZGd2cjlLTCs5b0dtL2xZ?=
 =?utf-8?B?K2lJMXBsR0oxakhBV0tGdkpJSm1NdVphY3RxUXFaR043MmNJcG1iOU5kMkRJ?=
 =?utf-8?B?NW5UWXhWQ1hYMVRDZGJ2dzFEQmQvc3lnSmQvUkQ5ais5aWR6UldTWU4vUWh2?=
 =?utf-8?B?cG9sbXN3UG05VDMzcXd4VWtSSjRoYVh4SWtSejdnU2wzUHpPcUtRQzNieXV6?=
 =?utf-8?B?ZjV1SHVudEV4b3ZTbGxRMG5PbnlGZ0NRay9ZOFZINTluTDFISWRJZEI3L1B3?=
 =?utf-8?B?QmhRUGJSenhhU3JFeC9VNS9YREx2MFVhTW5ibkRFOG5oSGswcjNKYjZkZFMw?=
 =?utf-8?B?UUZyN0ZEdDRYak9ITlhDWkg4azVXZ2tFcmpHR3lRUTAyb2xqY1gxUHBPV0Zt?=
 =?utf-8?B?R3lzVmQ5MFJSbWdtRnhzQzVNNCtXRk93SHhwZTdBVks2VGhRSDFLaE9yUmV1?=
 =?utf-8?B?V1k1aEYvcnc1dmkycDBJRm9aWUZaYmdZSFFNbE1US3ZQdWVTN2dQZ3VoS2U3?=
 =?utf-8?B?a0VQcitYWTd1ck8vSVVzNU1vMTVQZW5qS1BCeGJSZDBKanduL2dqR0VQZTBW?=
 =?utf-8?B?UkJJbElBRlJSWGpVYkI3UlI0eEE5bzNJRlBxOE01TmVGSXZOdnlVTCtNWm94?=
 =?utf-8?B?WUJwZ1RndlczdlBLdFlydGRpVmtURkJuNE1EUm03MVdlbkZjTFZETjNXelFW?=
 =?utf-8?B?dFBVcjVYZnBBK082WVE3U0lWZ1RqcUc1cGQ0OW9xVFhjblphK3FuYThwNFZJ?=
 =?utf-8?B?ajJNSUhwMmZtMUkyWFp3V1VnWWVrcVNNc1RnMzA2OG5oUVVyUXE4d3pTK0Ju?=
 =?utf-8?B?SzBXYVdjYTNYRzI3QzVJTmpWTHRmVFBZak51dWJqUzJsemV1NGFZaWREYVM5?=
 =?utf-8?B?Y0lQNUFzQTVJMVhnTnBzeDFKekUwV2Yrck56Y3I1WEQrRW4rZDQveHVSaXRj?=
 =?utf-8?B?OHRBakk2M0Fzc05Vb0w1dWFwRUF0T1FyVTJYbGhSMU1iK1g3TUhES3ZOeVRE?=
 =?utf-8?B?NlFLRDluVXRlcEFFOFRhVks1aWF4dmt5Vmp1NG1zb2F0UFU4ak92WmhOWTNx?=
 =?utf-8?B?SWhpVitZVTNEVDhWZE9PTFVqMHVSUVlCY0ZiRk9saHIrR2lZdUlmQkFpemU2?=
 =?utf-8?B?cm1QWUFSYUtrODUzYlZiWmx0SllFOEp1bHVsazM2SGU3ai9OeEtrcnJQNzV1?=
 =?utf-8?B?Y01aSWZSMkxwQjd1Q1BBVEpjVGZYN1V1QmxJWnF1YzJLRlVKYmxndjRGUnFV?=
 =?utf-8?B?SFpBTzgwVzVtR2MxOU5GS2NrTW1sdVMzRkNTdEhkMDgxSGIxVUNhTWpsMnNV?=
 =?utf-8?B?RUdPL28yZnpGRHRuSUd5ekV3Q1hVK3NvaU1zbFIzYmpJbStNTGFuQ2VpVmNV?=
 =?utf-8?B?SFhROGRib1gxMlhYbml4MlM3clhIS0Rybi9PaUYxMW5OV00wNFBKTDEwR2pR?=
 =?utf-8?B?eE5QT3BUWUt3elZPb0NJNndrR2N6cWs2UDVtVFBuN3Nqb2JaSFdwRXF5c2hL?=
 =?utf-8?Q?O32dyFGqBofvtEajZjUMapiGnnMZbLbz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGRRbzJ3NGVQc0NRNldGbHdDK2pvbkxudDRGcllUVTMxeGowQ0w5YmsyaGlJ?=
 =?utf-8?B?NWxIUytXQmxnaUhBOVhCMjRibitYSlNMdEloTFZCMDdEbU9FS1FFcXJhN1E4?=
 =?utf-8?B?a0Zva1FIYVduSm9tc0pBaDkwMXVPVUlBK05ndmlRUG53V24ycmJQQmlJTTdO?=
 =?utf-8?B?RzlZbjVsOFRCbm5sYkpLb0ZGMVU4YzBUM0M1Y2czbGk2SnlTQXdrbXpaMnFJ?=
 =?utf-8?B?L21HWUs3U0RhZ3VQbjh6a3lMUmtrYk1uVlk0S3FDQml4Vzcrb3RnMHNSdnpJ?=
 =?utf-8?B?TWN0NkNhbks2MVpzWVZ2em9PRXkrbG9VbVRxVUEvU2JGMnNjVjhGazRmUzdD?=
 =?utf-8?B?YURxQXRCZ3lkQ3JncGk5b1l4TkxEQXRFczNEeHB6SHFoTVdPYWhta3gwME1X?=
 =?utf-8?B?YU5FTjZCUUdiTXplSml5dmdVMFpvTEZpUm9FTTNGSFhlN3pyOXRJN2FFb281?=
 =?utf-8?B?T1VMWWRnd0xyYXZKcTJlajNyd2Y5NUo4VGdma1k3WmpBQ1RqTCt1ZVJXWGhO?=
 =?utf-8?B?ZGhiOGd6L3dtdTJ1OVRBVGdDTXhxd3RoS0JpdENKUWxiL3p1R0tQU0dsYVU1?=
 =?utf-8?B?amYrdjBIcWJNNXFUajRZLzdNWmJuVThsaysrTEsvRTRvMXo0cXBxWVNTOXFE?=
 =?utf-8?B?MnlxelRRSzYycGpXSEdYS083YUY0WE8zcXBNa2ovRnBlek5tcXppd3lOc2cz?=
 =?utf-8?B?RjRPVzBSN0lyaXhuU0crT3RMN1hDOStGOEdyWmc2d0pac0J0RU9EVVlZNjBS?=
 =?utf-8?B?eVE0SVpKTFg3d09KQmhZU0tmVTdvd01URzFIeWVMZklycTh5cFdSQ3lrUll2?=
 =?utf-8?B?WnpjeEU5MFpZWUZwUDU5VUVwWUtpT0MvZllVSm5SdmlUSTdNSHRPQXNPZURD?=
 =?utf-8?B?WUwyS0pva2JRc01zSEFIKzVsTERTOEhRSllzdEVQbXpUcXZNMkw2U2xuZ0dH?=
 =?utf-8?B?dFJGNDY1MG9YelkyOHRxejBxMk1wUjZGSXlpcE1xTVgvZkJEM0pENnN6NEhm?=
 =?utf-8?B?LzM3QlhUVlpjUzQrQTFXY3gyNXRKUGxzUXF0QnUrdHVieFZFT2Rya2U2eHhz?=
 =?utf-8?B?OEFaTFJPaVc1MGoyU01WRkNBRFhlekpFMGZodFVTVUkvQnY4Mk9IVHlUcVQw?=
 =?utf-8?B?QVg0VUhOVkhFdzcyNGdQUEhweEFkdUVaQ2VpeklORU9VaS91QTNPOE5ha2VK?=
 =?utf-8?B?b0pKaEUwSnVnVzVpNklGeEJPU1NhRE1iOUhBNTV5WUJDM3pMdUptVmM2T2tE?=
 =?utf-8?B?bWtOdnU1SFFqY3NtTFJucVh4b1M0YWxueDRpZ3RDUHVMcm5RRnk1TjdOZGR1?=
 =?utf-8?B?ZUNMYWhRVlFGOTVZcnVBbURkRGl3MjI2UFo2RlJoMUpheFFLaUt2bmFBLzRu?=
 =?utf-8?B?aUtEb2dONHhyeXZ0eWJ3TzFtN0RGdU1GQzVvanMvUUYvM3N0b1pkTmtqME4y?=
 =?utf-8?B?NllRZENjamVqYkJ3UXlpbjhVdllkcWVRaHhSV2N3R3NVNDJDbmp2V1ZYdVI0?=
 =?utf-8?B?Y0JXZ1pzVUl5N2JaMVBib251c3BsRW1ZaXdzS251NU9VZkZQWXBFUEZtakNx?=
 =?utf-8?B?NjVXZVcyQ28zaW9hUnNONVZuditIbmZkUzR1UjY3bGxiekZBR1hTQ1RBUXQ0?=
 =?utf-8?B?Vmg3WFNmNXJzTFYyNVNJcFlrUjMwR0RoZWhYUFpxZ3g4d1VvcmY0clJobkR3?=
 =?utf-8?B?amIwT09JdnNwVUhrN01FYm8rbXQ5ZThPUFFZQmUxcEpvVnVCRU80SU5PN1lo?=
 =?utf-8?B?NC9maURWbWREbGJrQUNkazRDV2FtV3VHYXBvMlhvZERDcTU1dTcxNU1iKzJF?=
 =?utf-8?B?RnZsT1hQUHc0ZjJnZzh5NmRPTzAvMlh6Sk5rLzUralpLeU5IRWc3Vjc0aTVn?=
 =?utf-8?B?dmF2djQxdXhMWWFHUGNoZjJQa0VZRXBqME4vSTJGK1VpRFRsQ2tiWng5b0JI?=
 =?utf-8?B?b2FHeUZRMS9HZUNaWk9ESTFZQU5HQ2NUamtCMG1sdzRKVzNZT0F5bkJrWDR1?=
 =?utf-8?B?TzBJQ09RTS9pT2xuZXJxOUN2NHlGaHJBYlVyOXZHcllUSkJKditOVXErNVZ6?=
 =?utf-8?B?R2hSU2c5MWtKOTB1d3R0ZG1pbk42bzBqcytjUDhmUzcwYUlNYzRNUmF0eEZY?=
 =?utf-8?Q?ytGuVSmKZoGJxmHsFfsPc/ctD?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea89674-3f46-41e4-c883-08de04737641
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 00:58:28.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6ltFSYR+RJfdtGMx/X9IhxEsxXOocCX3f3HdbqxMbyb2BJoSNYh2tYcOVikc7615dqXxpzc22Q8eImjfzRBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8392

In the context of CONFIG_NO_HZ_FULL=y, tick_nohz_full_mask (of type
cpumask_var_t) is initialised to 0. Memory is only allocated to the cpumask
data structure, in tick_nohz_full_setup(), when Linux kernel boot-time
parameter "nohz_full=" is correctly specified (see housekeeping_setup()).
If "nohz_full=" is not set and an attempt is made to read
/sys/devices/system/cpu/nohz_full, '(null)' can be displayed:

    ❯ cat /sys/devices/system/cpu/nohz_full
    (null)

This patch changes the output to print a newline (or 0x0A) instead of
'(null)', making it consistent with print_cpus_isolated() behaviour.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 drivers/base/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fa0a2eef93ac..f694b4b24d6c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -304,7 +304,9 @@ static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
+	return !tick_nohz_full_mask ?
+		sysfs_emit(buf, "\n") :
+		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
-- 
2.49.0


