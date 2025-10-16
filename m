Return-Path: <linux-kernel+bounces-856806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F7BE5265
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4F5E5049C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BA23ABB9;
	Thu, 16 Oct 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EG1DCuWd"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022078.outbound.protection.outlook.com [40.93.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44581D5178
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641197; cv=fail; b=RubPyrg8fQrbULu/3Epe2cbKFNO2ITytZDb0XpwZKf2vn+mf2JsPFvkk0O/l0mAGNyZntypyLiLbIyFqwZXxtw2Cz3WtNrY/EJFQKxWbpNhCdNKtc0Hu9WOgs0GYt47W7gq90J8oRWwt1g420mNppbv3sqfEWp8PzOcaLBv/dcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641197; c=relaxed/simple;
	bh=2HLrOma4LBjqFv1I7l76AswnIgrDADNC3pIxL+nuV6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IdTeJLvY9tuh+i2CSYAZNc1k9sRKy44n9alGzKJ0PDeRxsv4iIn7XRC4PwQNkB/lqC9iPPoXM4s3n3opo2io9Qci0NE27Cemldg64zdbhEN3hPFZTNiKWh9d5Sb838Iv/rj9c8JQ/xAhFYiKsDr4DeZMaHgwluDUbkyt/+r1Ek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EG1DCuWd; arc=fail smtp.client-ip=40.93.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qx9cgdp/spdUSbFJ5Y5+xVDrAoO58JnjhAHvMSHc4dUEUAPzmWsiVjVh7tztHPNCtETe2JsfizIeuGKgv/0tzpNI0l5m0S4Q78n/JZxAZ9UZ8o6UouQral8Im14wJpdIq6+Mm287LhtgBtC2A77iqx6qW5YtBU2vioUY8QuNe1sEeS7LINkK57nfA4d07e9Yc6C0LEBDAjtXW+CG0146xBtcyuOJRfQj5llRHS3bcK7kGmmfUdQdQo9hly07+1WN/gaXFZLkR8sjDU9+ZsKGhKGlQPmXOhwOyvSDXpaocKca81A55q6A/Lwd286DYY5pYpVfvDEb8SV2XuKK3M4P9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6El9Pq1A1ub5SKAt97NLe+Y9eLv9uvyIfR2uWRwPp8=;
 b=KMvyqUK3JKF9m6hh0OqOfVuIu5nf5a8QDKCxtEIHB1oU+D2/XYz7bvdxsxKt1lUloN7nuzZNDVf3hSwPfaDxKYv5lzcJK9yc6q/C2BbFfoNYTQ9QDVobIIyZK5VbCySqLeRtBUVmfiCqhA/9idipkScjQj2sI/H48g13X4FMTkwo0zSQETMQsASFUe8EuXOOvKgOeuwuonLD2vAGZ+9csQOYp/RN4dF9p3J9f7EX2cCrDBwv+y796kn1JMfSpNIOB2DpDPGf5e1j3NVd5u1vqBE7UJqu8Z3GG26LtpMJyMrUKtpb2WaBJNQWKabWdIWrQOS1/X7oEO+CLPvWGmEpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6El9Pq1A1ub5SKAt97NLe+Y9eLv9uvyIfR2uWRwPp8=;
 b=EG1DCuWd/AIyI7qGYlC5MnY0mFgrD4MzPKJFYgNmveMmlaCQaEtrbaKr7oCE2zNBcY8KpKNzut5dX49FvkTzo1SGGOCC38qwHyrFqhawtLnDprllxeLZgxhn06omXa3pmNN1ms7dyuZ2yDyRhWtlYMlx62EZ8OtQtrTfPmDy2dA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB6742.prod.exchangelabs.com (2603:10b6:303:f7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 18:59:52 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 18:59:52 +0000
Message-ID: <e9b182a6-e965-4f39-9759-9812525af502@os.amperecomputing.com>
Date: Thu, 16 Oct 2025 11:59:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: show direct mapping use in /proc/meminfo
To: Ryan Roberts <ryan.roberts@arm.com>, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013235118.3072941-1-yang@os.amperecomputing.com>
 <91f6da2f-1968-4c23-a534-20b463463faf@arm.com>
 <1449b3b4-2dc0-4a59-94fe-5a4a6dc69986@os.amperecomputing.com>
 <97d01dfe-df9e-4780-8069-b6dfb0e8323d@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <97d01dfe-df9e-4780-8069-b6dfb0e8323d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:930:d3::20) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2957fe32-e3de-4813-b4df-08de0ce62fe0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFRVQmlyc3E1dDZnbVV2RXkrc3k2WXpPUlJBS2MvYjk2cTRJUU1aVmRKQkdX?=
 =?utf-8?B?RFg0cVZzM0Q4M3ZESU12Vk55SytIemlLK0dZZjk2QURLMzc0RWZLZysrR1VR?=
 =?utf-8?B?ZERhV3ZoNWhibUxGYncrN3VSV3d4SG1hc25IVTZINUxIRTFmelcxSWJ2c0FY?=
 =?utf-8?B?czlQYWtZZHJ2YmV6eE91T3JGZmsvVXpNNVkvZ2NzaWhmK0xwQnhodFNDL0FW?=
 =?utf-8?B?SFIyakd0MWV4QjBPOVBBSjdybHdQYXh4YlQ0ZWZkZTJjZERFTFlrT0ZJbWFr?=
 =?utf-8?B?b21CMWVzM0QrcTdFamFaUHF1RE5pZHBjM0pINzdDWUNGRitNaDQvQm9pOGR5?=
 =?utf-8?B?eU9YWFJYWlhhYitvTmt6dy82bERBRllxOGhjUUNONHZ2L3lNTUNUZHhuWTJK?=
 =?utf-8?B?c1ozSDk1WGN2Y1ltVkNsdVRNNWkzTUNNK1h4QlhWdWFMRk40SlBKd0hvMERK?=
 =?utf-8?B?Wi9JMUMxTDVoTmduK3hVUElBWngyUC9TdHc4WHB2UDhiOHBGNjI2WDVPcTFJ?=
 =?utf-8?B?T1RCQ1R5bkZ3MnFrUFdUbFNxTzBieGtwTWFib21PaGpEYmlLVWJlbG1rRVdo?=
 =?utf-8?B?a1dIL29rMzNtaEtURndGZ20yamp6RGNRbkI0UEJQWng0MSs2V2ZhYlJqenln?=
 =?utf-8?B?MmNVV2ZZOVYyUXBtZ29zR2lyTGk5Sk9FUDNkWFZYeVRaSUthV3ZxcEJkSHZV?=
 =?utf-8?B?aS8raXUrcHZFK1U3dTg0ZmdFeTVDc1lOS21UampKdXlUVHY0UVQwMWZPNWJ6?=
 =?utf-8?B?SjFSTDI2dS9xRm40cVliV0xNRUtNQVlSbnRCM1R3RmMyalE1Y0ZIYjhBSzY1?=
 =?utf-8?B?eTNnRm4wTGxNNjVCRThPSDRrdUdnVFVzcmx0RkJWUW1GWW51MUEySXliYnUw?=
 =?utf-8?B?bHFFRmpmR2lwRncvQmFjc3dHeHhVQjJvNkZPdG1JSUdXRElIYzJlU25rUHVx?=
 =?utf-8?B?bUw2b1dsOVlkUFhTdDNUOFRFcDlycHJvSTB1MGgwakwxVnhNZUZIUGtHejFE?=
 =?utf-8?B?YUx0TktzWjNEcnFqSkIxMWJOL1N2bWk1OEhQNjBHaWRXWm1VRjYwQVFaUHY3?=
 =?utf-8?B?Y1ZhcktaWVgwYjBTcEV5WDRWc3duWEhUNnpZRGRSNlRPL1FoMnNIeTk0cE92?=
 =?utf-8?B?MzJoaC9GV1Fmc3RaN1Z6YlE4TzZadFBxWmpONXBOb0JHV01zWEliNytrd0xY?=
 =?utf-8?B?NkdKQmh5bVYzWUxubTJZQ2FVbXlzOTRrQzZBUTlQNDVnalNRMmtTMlhSdHh1?=
 =?utf-8?B?YVd0Qmt4eFR2S005dmdHdDJENGdPMk9oT3lJcjU2bTVZYjh1NlRkc1hUYjh6?=
 =?utf-8?B?WlkrcTJQd3VzYlVKUlVUM0VWNndDZ0RVY1hDYmJoM2xnRXk5bk9oWkt6L1pV?=
 =?utf-8?B?dFVMYThjYzN6QldtSlBVSHpqdGdXano4ZUFMUDhsRUZ2ZjZna2k3TW9ucTlV?=
 =?utf-8?B?RmtrOCs2aGVHWXgreENHVDlnRFpyQ3JrNExYU1oyVDJESnVYWDI2a3NzVi9J?=
 =?utf-8?B?c1NaUlVWUlBEa2YvNFp6L29GZWxWcTBpOS96L1k2azhjYWV3R3YxMmtqT0ph?=
 =?utf-8?B?bXVUWk1NL2drNCtDTXJaUFdqTENUUndiNmNROGQwSDNlTFQwUHd3UVM2ZUYy?=
 =?utf-8?B?bDF0QTZIa0dlcTRIZitXSG5yUEFkNXc0SVJTZDc2Z0NZZ3A4d3ZneXVjM2ty?=
 =?utf-8?B?dUdreUF6WnRsUWNpWUx6djJDbzBtd2dWa1lGMUhCWW5wcDhMekw2VjFWK2VF?=
 =?utf-8?B?MzhkbkRwR0pzbVZUOU1ZZVhPeDRvKzMyV0o3ZUwvdDgxKy9rVURRSHJ0aE10?=
 =?utf-8?B?dFdtVVVKc1pjOE84OVlWTXhFTDR5MldkOFR0aTFVaFllVThtWTFpd3Bud2dI?=
 =?utf-8?B?U1pXNm9UdzRkeldjQ1M4NjQyc21XbFVLUkJQL0k3U3pWSkFqanNXTElQSUIw?=
 =?utf-8?Q?0yvu9QuhZdVCr8s6YU18DambCSyJJIkJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y21UTmswVGlYOHZGSjdLR0Nyd3dwNkNMWDRhaDhnQ3dhNmpEc3pPTnlQMjdN?=
 =?utf-8?B?cW9maUpaakF3NmNHbTE4SEdsU21vajUyeUlyRkMzUjJoTVZKVXAwTnZoT0t1?=
 =?utf-8?B?RGJnaXJLVDkzR0UzajY3S09wS0VUZHl2Tit4NHZyK3dmYkg3d1hldjJqb1RZ?=
 =?utf-8?B?NmVaOURqMG1DZWF1bmNaMHRtdTFkVWNiMmNwMU1EZ255eFJwZElhT08vYXMr?=
 =?utf-8?B?SStHdlFYT2lINlgwNHZCQVlqRy9aVFZQZ0RXWElrOXdNQmlWNjFQSUhaYjFs?=
 =?utf-8?B?SE4zQVlVNzk2OHJwZXd5ZTB4UDdxekV5VzVqQ3RjUGRTZ2VnWWVxb0lvZ0Jm?=
 =?utf-8?B?YzVSdW80MU1XMWxuUXR1VFlPQ2grcndTaHdVaC9uVW1kNjcwSytOZXUvZUhC?=
 =?utf-8?B?Y2k4Vm5BZHRlRmdDKzh2akVpS3F1d0g1QTRqM0JmS2JOMmJ2ZTBlbE5zU3ha?=
 =?utf-8?B?R2Z0RWVRa1RqNENCY2JrdWwyTGNZbmNrS3pKWDVJbldrZWpOYWUwSUtudmhv?=
 =?utf-8?B?V3cyMklobnkydGZwZ0Uzamh6ZVJ4K3V4N1VlQTM0ditXZFV5cFJjTDVIdEZC?=
 =?utf-8?B?WEQ2TCtENEJXOS9GNncyQUZVdmdrTUwxYnBLSXV3NW9GQ1FqYWhlWUxjZVBz?=
 =?utf-8?B?NWpNbVVSczdncTZDc2hWNXBvQ0ZoekYxbStvYkNKU283dVdTa0NwWVpqa0Nz?=
 =?utf-8?B?Mk9teWowMmVXSTczRkpSTitVdzhlY0kvT3hFcTRHM3dRdnZnZjRjTVFrcFkx?=
 =?utf-8?B?UVQ2cEI3L1VlZGpkY1Jxc3IvR1NVOEQyMXJGR2kxcHNCUis1bEg3eDdUcEFT?=
 =?utf-8?B?encwK3RwdUZNSWpkbzlyRG1KNnNWMWUyQXdpOW55U2c1VGR1OUhmSHZETmpU?=
 =?utf-8?B?SXpEOExML1Uxd0xkenhIZHlabG40cE5kWGpVYU4yTkEwRGRGMlBVU01YeFlM?=
 =?utf-8?B?RldHQkJZTUV2dkFaNWpJK3BtV3oyMzc2eVFiVlFURTE2MzNOMjNlUWQvTWF2?=
 =?utf-8?B?YnZZTHN3TGVjT1M4MW0xMlF4aGhsSVVBVXJxUHRKWnVFMzhhMDJkMUR0QVov?=
 =?utf-8?B?Nk1LVDJ4RXVQZnIwWVBjdEE4VHU1N2lXSjhCZVA0ZW5BYXBHVWhPTGt4aVFO?=
 =?utf-8?B?RTUvbUFuaHJlTURIdzNoV2djMllqMHd0U3JhUExCTWtTYVdIekxOQ0VZaC9u?=
 =?utf-8?B?aWY0eURyejBvaXlvbVBSaGdxUUtQaktPdzBmUXNwelV2Z1oySXZOK1NOTDht?=
 =?utf-8?B?ZXVSZGc0YWlsS2xrMHNRSWx4UWFBWGFiOWkvTytCTGx2Yzh4UHJNUXVvWUJx?=
 =?utf-8?B?b1VjSm02dHJNUXFJS2dselo1VEJNYVNuWC9ISTh1ZWtkazZqV0JXTy9KZEJX?=
 =?utf-8?B?NVJDems5N05WdnZBcHNpaGZ1YlArekJBdzBvY2dieFY1S3JHRXI4ODduT0N1?=
 =?utf-8?B?bk1DdzEvUDkyTkVaeFkvbUt2OXBjdGM0cTZnQWgwWE9aWlhmMkRGcWxrTUps?=
 =?utf-8?B?cEhOYjc2SlN0MUI2a0Q1WXp3MFBhR3dkWVhueEZuV0FUNFFNZlp6UE5yRld4?=
 =?utf-8?B?YlN4SXVHYUgrSVl6QW5rQlpFUlpGUTdBQUIwQzl0NUpxYjZOQVhGdStmRDFH?=
 =?utf-8?B?WkdaYXNOcE5uZDlXejBMY05QRGNuWDR6NXIyNDIzaGdtZE9FaWZkbTJuUTZ5?=
 =?utf-8?B?eWI5L1oxMUpwaStLN2xQcGFoQzBJSVRlUlBSOWlUcnoyeWpyc0lJWXFkM25t?=
 =?utf-8?B?RHEweGJPckRDSFNSZmUrVTBuY2VVSFE2NFRHVzFibXZZUzhQVkVSbzlneEUv?=
 =?utf-8?B?NGFvL1hRUjd1aFdhVnovLzNUemhZeVRvQmpLWjFTaXhyWk1xQURSVXQwRHlT?=
 =?utf-8?B?V1NDaEI5R25adm93K01UUWFUVEJ1cXVBU0l3aXRETG45emI1TzhPbkVabXIx?=
 =?utf-8?B?UmF3bjk2MzVEMVVybWVUQi9UMWRzTENybWVjNXJkNjBKQkR3RUVZanY3TjlI?=
 =?utf-8?B?QURiT21lL0NZbXJoOTAxYXZ4WldZbWlSZW55dzBsZmJXWWVOQk5WL1Nwdjg1?=
 =?utf-8?B?eUh4VjRwcXF2aFM1eTNMSzd4Lzd3Qk9YUG9COWVRVzk4ZjM1WTJSWVRLczY1?=
 =?utf-8?B?SUt3eis4VGpxNEJpZVp6VkdjQU9YdnJwZE5hWktyRkVOSUJzVnBrV2pVNVFv?=
 =?utf-8?Q?5yikpiP8rUMJwB03oA3UkBM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2957fe32-e3de-4813-b4df-08de0ce62fe0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:59:51.9622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyMmommR1PePzlUKxB0leWChT3Xg6Lljk1aATXWjaeWLhRz/RlIDFZpFCHX5AdTFX0BRKBx+9BWTnnKdRRM8VM4YuKv4zAbhG8erf31PlUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6742



On 10/15/25 8:37 AM, Ryan Roberts wrote:
> On 14/10/2025 21:49, Yang Shi wrote:
>>
>> On 10/14/25 1:43 AM, Ryan Roberts wrote:
>>> On 14/10/2025 00:51, Yang Shi wrote:
>>>> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
>>>> rodata=full"), the direct mapping may be split on some machines instead
>>>> keeping static since boot. It makes more sense to show the direct mapping
>>>> use in /proc/meminfo than before.
>>> It's possible to divine this information from
>>> /sys/kernel/debug/kernel_page_tables. Dev even has a script to post-process that
>>> to provide summary stats on how much memory is mapped by each block size.
>>>
>>> Admittedly, this file is in debugfs and is not usually enabled for production
>>> builds, but Dev's patch Commit fa93b45fd397 ("arm64: Enable vmalloc-huge with
>>> ptdump"), merged for v6.18-rc1 gives us a path to enabling by default I think?
>> First of all, it is in debugfs, not all distros actually enable debugfs. IIRC,
>> Android has debugfs disabled.
>>
>> Secondly, dumping kernel page table is quite time consuming and costly. If the
>> users just want know the direct mapping use, it sounds too overkilling.
>>
>>> But I can see the benefits of having this easily available, and I notice that
>>> other arches are already doing this. So I guess it makes sense to be consistent.
>> Yeah, some other architectures show this too.
>>
>>>> This patch will make /proc/meminfo show the direct mapping use like the
>>>> below (4K base page size):
>>>> DirectMap4K:       94792 kB
>>>> DirectMap64K:      134208 kB
>>>> DirectMap2M:     1173504 kB
>>>> DirectMap32M:     5636096 kB
>>>> DirectMap1G:    529530880 kB
>>> nit: x86, s390 and powerpc use a lower case "k" for DirectMap4k; perhaps we
>>> should follow suit? (despite being ugly). Although I think that's usually used
>>> to denote base-10 (i.e. 1000 bytes)? That's not the case here, we want base-2.
>> We should follow the lower case "k" so that the script used on them can work on
>> arm64 too.
> Thinking about this some more, I really don't love the idea of encoding the
> page/block sizes in the label name. This is yet another source of potential
> compat issue when running SW with 4K/16K/64K page size. Could we consider using
> PTE/CONTPTE/PMD/CONTPMD/PUD instead?

I'd love to it. We can remove all the ifdef churn for the size name. I 
used the page/block size in order to have a consistent view with other 
architectures. If we don't care to keep the consistency, using 
PTE/CONTPTE... definitely makes our life easier.

>
>> Do you mean kB should be base-2?
> No I meant that kB (lower case k) often means 1000x and KiB (upper case K) often
> means 1024x. So having a lower case k here is technically wrong since we are
> talking about 4x1024 bytes, not 4x1000 bytes.
>
> But its a moot point - if we go for these label names, we should use the lower
> case k to be compatible.

It looks like /proc/meminfo uses "kB" for all items. IMHO we'd better 
follow it.

>
>>>> Although just the machines which support BBML2_NOABORT can split the
>>>> direct mapping, show it on all machines regardless of BBML2_NOABORT so
>>>> that the users have consistent view in order to avoid confusion.
>>>>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 93 ++++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 91 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index b8d37eb037fc..e5da0f521e58 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -29,6 +29,7 @@
>>>>    #include <linux/mm_inline.h>
>>>>    #include <linux/pagewalk.h>
>>>>    #include <linux/stop_machine.h>
>>>> +#include <linux/proc_fs.h>
>>>>      #include <asm/barrier.h>
>>>>    #include <asm/cputype.h>
>>>> @@ -51,6 +52,17 @@
>>>>      DEFINE_STATIC_KEY_FALSE(arm64_ptdump_lock_key);
>>>>    +enum direct_map_type {
>>>> +    PTE,
>>>> +    CONT_PTE,
>>>> +    PMD,
>>>> +    CONT_PMD,
>>>> +    PUD,
>>>> +    NR_DIRECT_MAP_TYPE,
>>>> +};
>>>> +
>>>> +unsigned long direct_map_cnt[NR_DIRECT_MAP_TYPE];
>>> I wonder if it would be cleaner to store this in bytes rather than blocks? Then
>>> in the code you can just add PAGE_SIZE, CONT_PTE_SIZE, PMD_SIZE, etc as
>>> appropriate, then the reporting function becomes simpler; everything is just
>>> shifted by 10 to get kB; no need for the shift array.
>> Yeah, good idea.
>>
>>>> +
>>>>    u64 kimage_voffset __ro_after_init;
>>>>    EXPORT_SYMBOL(kimage_voffset);
>>>>    @@ -171,6 +183,60 @@ static void init_clear_pgtable(void *table)
>>>>        dsb(ishst);
>>>>    }
>>>>    +void arch_report_meminfo(struct seq_file *m)
>>>> +{
>>>> +    char *size[NR_DIRECT_MAP_TYPE];
>>>> +    unsigned int shift[NR_DIRECT_MAP_TYPE];
>>>> +
>>>> +#if defined(CONFIG_ARM64_4K_PAGES)
>>>> +    size[PTE] = "4K";
>>>> +    size[CONT_PTE] = "64K";
>>>> +    size[PMD] = "2M";
>>>> +    size[CONT_PMD] = "32M";
>>>> +    size[PUD] = "1G";
>>>> +
>>>> +    shift[PTE] = 2;
>>>> +    shift[CONT_PTE] = 6;
>>>> +    shift[PMD] = 11;
>>>> +    shift[CONT_PMD] = 15;
>>>> +    shift[PUD] = 20;
>>>> +#elif defined(CONFIG_ARM64_16K_PAGES)
>>>> +    size[PTE] = "16K";
>>>> +    size[CONT_PTE] = "2M";
>>>> +    size[PMD] = "32M";
>>>> +    size[CONT_PMD] = "1G";
>>>> +
>>>> +    shift[PTE] = 4;
>>>> +    shift[CONT_PTE] = 11;
>>>> +    shift[PMD] = 15;
>>>> +    shift[CONT_PMD] = 20;
>>>> +#elif defined(CONFIG_ARM64_64K_PAGES)
>>>> +    size[PTE] = "64K";
>>>> +    size[CONT_PTE] = "2M";
>>>> +    size[PMD] = "512M";
>>>> +    size[CONT_PMD] = "16G";
>>>> +
>>>> +    shift[PTE] = 6;
>>>> +    shift[CONT_PTE] = 11;
>>>> +    shift[PMD] = 19;
>>>> +    shift[CONT_PMD] = 24;
>>>> +#endif
>>> The ifdeffery is quite ugly. I think we can get rid of the shift array as per
>>> above. I was hoping there might be a kernel function that we could pass
>>> PAGE_SIZE, PMD_SIZE, etc to and it would give us an appropriate string but I
>>> can't find anything. I guess keping the ifdef for size[] is the most pragmatic.
>> Yes, I agree this is the most pragmatic way.
>>
>>>> +
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PTE], direct_map_cnt[PTE] << shift[PTE]);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[CONT_PTE],
>>>> +            direct_map_cnt[CONT_PTE] << shift[CONT_PTE]);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PMD], direct_map_cnt[PMD] << shift[PMD]);
>>>> +    seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[CONT_PMD],
>>>> +            direct_map_cnt[CONT_PMD] << shift[CONT_PMD]);
>>>> +    if (pud_sect_supported())
>>>> +        seq_printf(m, "DirectMap%s:    %8lu kB\n",
>>>> +            size[PUD], direct_map_cnt[PUD] << shift[PUD]);
>>>> +}
>>>> +
>>>>    static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>>>>                 phys_addr_t phys, pgprot_t prot)
>>>>    {
>>>> @@ -183,6 +249,9 @@ static void init_pte(pte_t *ptep, unsigned long addr,
>>>> unsigned long end,
>>>>             */
>>>>            __set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
>>>>    +        if (!(pgprot_val(prot) & PTE_CONT))
>>>> +            direct_map_cnt[PTE]++;
>>> If adding size in bytes, you could just always add PAGE_SIZE here, but select
>>> the bucket based on PTE_CONT?
>> You mean:
>>
>> if (pgprot_val(prot) & PTE_CONT)
>>      direct_map_cnt[PTE_CONT] += PAGE_SIZE;
>> else
>>      direct_map_cnt[PTE] += PAGE_SIZE;
>>
>> I don't think this is efficient for PTE_CONT, because I can just do
>> "direct_map_cnt[PTE_CONT] += CONT_PTE_SIZE" once in alloc_init_cont_pte()
>> instead of adding PAGE_SIZE CONT_PTES times, right?
> Well you could make the same argument for PTEs. you just need to calculate the
> size. Then you don't need any code per-pte at all.

Yeah, good point.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> This applies to the below comments for PMD/CONT_PMD too.
>>
>> Thanks,
>> Yang
>>
>>>> +
>>>>            /*
>>>>             * After the PTE entry has been populated once, we
>>>>             * only allow updates to the permission attributes.
>>>> @@ -229,8 +298,10 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned
>>>> long addr,
>>>>              /* use a contiguous mapping if the range is suitably aligned */
>>>>            if ((((addr | next | phys) & ~CONT_PTE_MASK) == 0) &&
>>>> -            (flags & NO_CONT_MAPPINGS) == 0)
>>>> +            (flags & NO_CONT_MAPPINGS) == 0) {
>>>>                __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>> +            direct_map_cnt[CONT_PTE]++;
>>> Then you don't need this.
>>>
>>>> +        }
>>>>              init_pte(ptep, addr, next, phys, __prot);
>>>>    @@ -262,6 +333,9 @@ static void init_pmd(pmd_t *pmdp, unsigned long addr,
>>>> unsigned long end,
>>>>                (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>>                pmd_set_huge(pmdp, phys, prot);
>>>>    +            if (!(pgprot_val(prot) & PTE_CONT))
>>>> +                direct_map_cnt[PMD]++;
>>> Same here...
>>>
>>>> +
>>>>                /*
>>>>                 * After the PMD entry has been populated once, we
>>>>                 * only allow updates to the permission attributes.
>>>> @@ -317,8 +391,10 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned
>>>> long addr,
>>>>              /* use a contiguous mapping if the range is suitably aligned */
>>>>            if ((((addr | next | phys) & ~CONT_PMD_MASK) == 0) &&
>>>> -            (flags & NO_CONT_MAPPINGS) == 0)
>>>> +            (flags & NO_CONT_MAPPINGS) == 0) {
>>>>                __prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>> +            direct_map_cnt[CONT_PMD]++;
>>> Then this can go too.
>>>
>>>> +        }
>>>>              init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>>>>    @@ -368,6 +444,7 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long
>>>> addr, unsigned long end,
>>>>                (flags & NO_BLOCK_MAPPINGS) == 0) {
>>>>                pud_set_huge(pudp, phys, prot);
>>>>    +            direct_map_cnt[PUD]++;
>>>>                /*
>>>>                 * After the PUD entry has been populated once, we
>>>>                 * only allow updates to the permission attributes.
>>>> @@ -532,9 +609,13 @@ static void split_contpte(pte_t *ptep)
>>>>    {
>>>>        int i;
>>>>    +    direct_map_cnt[CONT_PTE]--;
>>>> +
>>>>        ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
>>>>        for (i = 0; i < CONT_PTES; i++, ptep++)
>>>>            __set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>> +
>>>> +    direct_map_cnt[PTE] += CONT_PTES;
>>>>    }
>>>>      static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>>> @@ -559,8 +640,10 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp,
>>>> bool to_cont)
>>>>        if (to_cont)
>>>>            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>>    +    direct_map_cnt[PMD]--;
>>>>        for (i = 0; i < PTRS_PER_PTE; i++, ptep++, pfn++)
>>>>            __set_pte(ptep, pfn_pte(pfn, prot));
>>>> +    direct_map_cnt[CONT_PTE] += PTRS_PER_PTE / CONT_PTES;
>>>>          /*
>>>>         * Ensure the pte entries are visible to the table walker by the time
>>>> @@ -576,9 +659,13 @@ static void split_contpmd(pmd_t *pmdp)
>>>>    {
>>>>        int i;
>>>>    +    direct_map_cnt[CONT_PMD]--;
>>>> +
>>>>        pmdp = PTR_ALIGN_DOWN(pmdp, sizeof(*pmdp) * CONT_PMDS);
>>>>        for (i = 0; i < CONT_PMDS; i++, pmdp++)
>>>>            set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>> +
>>>> +    direct_map_cnt[PMD] += CONT_PMDS;
>>>>    }
>>>>      static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>>> @@ -604,8 +691,10 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp,
>>>> bool to_cont)
>>>>        if (to_cont)
>>>>            prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>>>    +    direct_map_cnt[PUD]--;
>>>>        for (i = 0; i < PTRS_PER_PMD; i++, pmdp++, pfn += step)
>>>>            set_pmd(pmdp, pfn_pmd(pfn, prot));
>>>> +    direct_map_cnt[CONT_PMD] += PTRS_PER_PMD/CONT_PMDS;
>>>>          /*
>>>>         * Ensure the pmd entries are visible to the table walker by the time


