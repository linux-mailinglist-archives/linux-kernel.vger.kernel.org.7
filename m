Return-Path: <linux-kernel+bounces-892338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC364C44E31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26D794E775C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB801DE2AD;
	Mon, 10 Nov 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgcI2TWu"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092D27F195
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747374; cv=fail; b=fap7FG6UIb48YHYzjxGaIrrKyGoexKNo3bsLGHqpvnWdNnKgyzJTamrias3Nv5X6K18zKpmYeNC6UsJsE5Zv3yPrjaiwPJsqaCkQxVaBjf5UtIXW3bdGsUfX9JjqbQ+cqNtiJcTrIeqNoXjXiSkDqAQTOTXo3K48io+OA08271o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747374; c=relaxed/simple;
	bh=GpjbNIIrzn2/VDJgR/O+MemQQamVYZGwCRb7pgRiTPQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=entshIq8C/o45f373vdVPIJFCCHSwnWNSs+9w8LoKYJKVe/+mbQFabLGERg2j1aSiYZmSyCWA++C4nitMwsROG1lqV7hCWwGDeFndJGYvSZclxNpx0TfDQO3V9e+F+FH0/wVfLzeBqy9fvyToLTkmHd9S/EtyddPYrnUW7PgzxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgcI2TWu; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCdn8GgbVN9+Vcnlv94yIJu/d7uaBUEu4VvHWYxejcyK70ffGF6FjRu0rVLuCJSxonsHbwafBC6Kl8d6BT8agU/8rsioP2K+mt5IhEj4WjagIdxQj92spWkBH1/60bI+WKyEwnXXSKGRNMP3U/QN7NS7b87NEKFrEJN85UdlQVzIzZ7dw9THr01yHjbFE1jimY+CXwcznnJB+EJDcYkWGB3yYj3XkzzF0mKRBvuKROhDLjn7p+1WO2bwBBefDPQm343nxBjWkVNTahmEmGfLCSB8xWOvcsm+vzu/Ys27marrHftgkxDN88RkjqbZb+LqNfrnOQClrXULXicufa5K6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyXpicf99Xi1erJ9Oju9hV72/dNXpGM5tJktCyH0Z3k=;
 b=McClrqwZLV3xO+fih2kSwbbjAvrDYJZnRj2urR77UUFsF1UYlvMqwWfIeyi5PiA29Uf0qQpfBNlV/9VAvftHVwfsgQY5vVG78KjjRugjL9lTPI0lvjZqK4j/C6vqrZZp/YhNlLcCDoczE0vo80ZFOiT3WG/tdTsQoL74xq0UG7mX/YlSRF/XA5VB/CUCnHTGSLZKHQ9BYTZ6CGWrtlm4Kwjcd73ljLb9uj4OMzMKIrss3ZQRY5Zwk0slzHz7TwBmvyxObPLMfDpz9Xjp4FOcoiGi/NZAtdBfTmJCeSD1SZAjOixDUYehwi7QzzJo3rwFz3ZgrNoenTJHQuoDCtk3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyXpicf99Xi1erJ9Oju9hV72/dNXpGM5tJktCyH0Z3k=;
 b=NgcI2TWuTZnUuUvWsxklZvdb2BvJQ5Tx9JzJXRVKTohrP3+GSmsz5cPnV27hcrOsbaQVVJg5GM56nQhgQpuM+D9k2dzwHUy1gpJKJELvgAQ6ByA0cO4FvdhkZrpGxpbXuSNudD6gJ2EypkHSXAWn76aX+6ZqvQPHrvy7EpdLykiSVVl3ybgmKPBSTZuXPR5ay8RRXpj51YtM1OciYo9752Zl5G8IZBAm/Ynsim74cW0nCaw2Is3qY4HUv9iHCI5AmwLEBybVNzIA85uheczgl7IL4aIdrROf/i2kQ+FqXDZd4QalDmtLk9bhrrVjS64QXDgtkzDTcB3BFKMWwktyVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:02:49 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:02:49 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 10 Nov 2025 12:02:57 +0800
Subject: [PATCH 2/4] mtd: spi-nor: micron-st: add die erase for
 mt35xu512aba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nor-v1-2-cde50c81db05@nxp.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
In-Reply-To: <20251110-nor-v1-0-cde50c81db05@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762747415; l=1934;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=GpjbNIIrzn2/VDJgR/O+MemQQamVYZGwCRb7pgRiTPQ=;
 b=zKylZ7miavjmgWl9yCnsA/jHLIGyFj6bw7xV7jPjfxZ7bqyMhCI2BpWJJOUfuG+VcESh5PE0T
 p42tZzQZMUtBLLwrV25Q0ojCiDcPLA7BrZfAJHQZt8kC8JIK+V/YyiH
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI0PR04MB10949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9b4ab9-9ef6-4d66-7dc1-08de200e03a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTBJRHAwVFY3SVFDMUFmYmNZNVN6TGdWdjdqWnFjNzFoVS9FdkgydG1mUXFj?=
 =?utf-8?B?NUVyUVl0Z1ZxOUFmWkhRZkZmdWVVWGJJREgxVlhLeUp3cG4zSjVpT056UVFr?=
 =?utf-8?B?QXU0NnpTRDNGV0lRaFNLYUJqYXhPaE1mQlh6QjFvcDk3eldlTjR3b01mVGY0?=
 =?utf-8?B?a3JiSVZ4MXpEVUs0cEo3ZjRmbm5CeTlpZTVCMytyaGIwMmp4bUQ5TDVsd2hN?=
 =?utf-8?B?SXB2VUZEZmhpWDRRU3JER2M1SHVMYzBQd0t4THRUcUozZm9ycDR6R1NnRkJY?=
 =?utf-8?B?b0VPMDBZYUQ0SHNJZzFmNEl5L29DZVY2cm1GM1lPR1dCejB1V2c3VDRYWXRy?=
 =?utf-8?B?SmFia2lNWkNDNUJMem40QjZ4cng5RzBjUmNDemxUOFFGU1hwNXc4RzBrNXZv?=
 =?utf-8?B?STB5VjBtUFVqMGc5emdUUkFZZ2dPNDhrN0RYQXV1RFZsb2wvRXhaWUFSZ01P?=
 =?utf-8?B?ZStHMWNrRkdKUXB2akxmc0QyallsMmJRdnE5cnJuUitYTTNKd05laDZ1UmFU?=
 =?utf-8?B?N3F1MUkrc0hmVmpxRjY5dVk0dnRKSmIrZ0E1MUZzaUVHUERGUHhPSUpiMUli?=
 =?utf-8?B?OTNBY2dxbHpObzkvN2dPbVBiZWJOc01vZSt6VnBabUoydU9xYkRaeTlPZWcv?=
 =?utf-8?B?UEgwQnkrWXhwcFdPakZuQ1FlSjlSOFhYUm8wR216VG1ub09sbEJNL0VnWEJP?=
 =?utf-8?B?L3lKVGROYjl1dHNUb1JvTnFyUkdtcXpzMW16YjUvNmVaL1Z2NzZXVjJpUEdu?=
 =?utf-8?B?L0N4empuVkZsYTFxc0FIR0RCd1dJQk9SQnJzVHl1bVpMZFZaZGVNVk1YZGFP?=
 =?utf-8?B?VmJyWVd0MlJGa0w3WEpFMTZEN01SSXdUdG1PVlJBc0wwMUNhTlBrT1EzMy9F?=
 =?utf-8?B?ZmtGVkd0aDlxaWxNQ3ZjVG1mZkJzMGFsMTF3YVJKQmdnQjh2UjJhMk9yV3Bu?=
 =?utf-8?B?clA3WktVb1lHQ3ROZWhQVnZYcUN2eHd0SG9aZHNKYjI2d1VtUitxdmorNGVL?=
 =?utf-8?B?Zyt0aVNZcEduK1NEajk0WEpHalc3UTBPY3VtckgwNUlwYjNnVkRXR2VEK29w?=
 =?utf-8?B?akZNcTVJR0kvWVJlRmhOOVU0Y0x1aElJbEFVbDdCMHdGSmxFd2c1UWVEWDdR?=
 =?utf-8?B?NnI2aVZ3eWJ4ekxobWQwWjVGWjZxbnE2eXNsRUNuQjFwR0w0R0tpRnhlSC96?=
 =?utf-8?B?Rjh2bUdCVHBDd1dnMXBFZ0ZocDdZOHpjRC9WR3Z4L1h5QXg2cGJyWVpEYTg3?=
 =?utf-8?B?RzZVZDBhQ0lBZ0dFR2JRTld2R21oSHBuSjE4bnpTRmw2Y01Zd050cUVJdEhN?=
 =?utf-8?B?WWl2TVZRMHhHTHIxNUZ2N0hMbzZ5RlJzUWZNTUdEZW5ORkJNSXkxMlRsVXJH?=
 =?utf-8?B?ZHNQVXdSTmZQcFRzVlRlNWg4T05mNk11c0h4bUZQeXBlU3hpWXNicjFYLzdU?=
 =?utf-8?B?VUR1NTA5WTk4YXJRRFJBcjdLSnJtUm9BVzN0SlFLYmF4L0JLQVVRNWluTTQ0?=
 =?utf-8?B?bUFOQlQ3K0xMdGxFbmVnUGZvVnhCUmVSMFltUXppbk5hSkZ6VU0vV2s5MWs1?=
 =?utf-8?B?K3hjb1FiWERVV3ZETUFiNmFaNU9hM1RJbjI0enVhN0x0MDl2andCMkxoMlBr?=
 =?utf-8?B?dFFoaktMaGJuNHh3bThVUDZBRnA0M0VnK3YxL2RwOFBmcFJuYVhTdkhjOE5p?=
 =?utf-8?B?TUx3TnhJSGl5aXZwZndBdWc1ZThlcEpOVmJobUNFc1VjaitLTDBDWmNsdFM4?=
 =?utf-8?B?RjllMkxzbG5qTzV6VXZSTEhDenBMc0Q0WDMvTElRZVpWYlFGVGNaSFN0aW0z?=
 =?utf-8?B?S0hDNUl5dTFudFBTL3pKdHZCSWpneC80TG5HZUxhRS9uRmpncDVCSlgvRlFR?=
 =?utf-8?B?TTMwSzhZRVlIQlFoc0l4c3ZrenVDWnVMaDZaTnQxakp2RzVBRmFuMXhwalhN?=
 =?utf-8?B?V3c0dzhIVmlvRUFjQnQwVGIwbHlRM0Y1bDN3Y2Z3aWp0WlNtVkNIYk5xQjlh?=
 =?utf-8?B?cHhyZi8zQjh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dldBUGdhcUsyU3RScE44ajYzbnJwbTNSSGVYamJZVjQ4d0ZEaGlRWDBrSE9s?=
 =?utf-8?B?VkRFazhqZFBrVmN3Rnh6enNFTmhLd2U4bVpHQlNNQnl6WXVodTRsSTlwOGg0?=
 =?utf-8?B?UTRURnJmdjVnWlhyOFJnOGYzd1dPYTc1WUVZclcrazArR0kza0hPQ2xhVXRK?=
 =?utf-8?B?OGJPdXRoY0NlUTczWU1DUzNiZ05vUmhiS21kV25laWR6Rm1FTkErSWRIcXN3?=
 =?utf-8?B?dTBKQStBUGRDdlhpLy83TGY5UHkxQnZKc1NGMFlPbHd1MUVHQi9KaFBWTnRu?=
 =?utf-8?B?M3NzOVVkc3FWVjh2L2VUSTBOdDRPWWtHQ0UwUDhjdnVjdEc0SjhmTXljSE02?=
 =?utf-8?B?RDdvRU5jTmM2L3VCVm5ZVjlKOHNjMjdTbjZLMjlIZDAyY2hFcGN0aFFlUlNw?=
 =?utf-8?B?c3I0cU1aMTlYa3V6TUtlb3FZV0FIZkpQb1dxZXpLVzBURTRpU1pvRHd0cUZ1?=
 =?utf-8?B?TTVVMlNOMFdVS0lXM2pESDFMMWE0aHcyeUdDWThoLzNSWDNnSnhKSk9tMTlO?=
 =?utf-8?B?d3lFbU44NjhJVStwbVo2OTBNNjNOd2J6MTZIa0R2T0tCaUtUYkkyOUU4NkZW?=
 =?utf-8?B?SmxKZnlXMjIxY0hYa3c5dFBsNXkzcnNzd0JXdUlwZFQzQUJEeUJDWHUvOGZP?=
 =?utf-8?B?Y1RReGRJUVBIYlFrd2JpZ3RIaXRLWS96WnFIU2p6d1Y1aDNzY1pvOTZiQzIy?=
 =?utf-8?B?TjQ0SjAzSWQzUk9nR21iN1A5SmtOVkFxa2JsV2RGVlplQTQzakdsbEFkTVg3?=
 =?utf-8?B?WCtGRjZuM2JGV0RrVlJ0ZUNtSWZJTTl6R25qNVdHQWRXM1ZIejB0czBEQ29o?=
 =?utf-8?B?eW1MQkhRK3FJVjd1VVBvQ1BmMHRaYVJTRUdiTVVlbHVmYmpFSElneVd1QUlo?=
 =?utf-8?B?V2VabG1XQ09iM0tuQWJ1N1UwbGU4MGRRVndwZUNFNyt2VzgwVG9jSDRaazlX?=
 =?utf-8?B?SUdQb1VsMTVXQ21RQmFhZFFTeTJtNUZpYXFjMVJ0Q1lxMnJWd0thQTVJZGVO?=
 =?utf-8?B?VVlHZUFmRE4zQTVzcXpkVmIrQjZ5S1doZXBXS1gyeC91NGM1Q2pPQXZtWFAr?=
 =?utf-8?B?akU4bFlEQUtzM2ZwZklaKzQ4dTM3QlVTY0c3SE9RREtULzMwN2tJeEVTQXBK?=
 =?utf-8?B?NWdaejZSQWFZdDc4U1BlQzNlemgxeDFvT3Iva0dNaE56WkJwbHZXL3RhQTVL?=
 =?utf-8?B?SVZCTVlRQ2N0Wm1SOStScFU2NXJZb3o1UnhodE5jNzY1cXFvUlVRUitCVE5B?=
 =?utf-8?B?TXhGTmRKSzRBZm45NEN2dk83dENRYkVEWWUrT0c1SGhVVFZwUWtUd1RkY3FM?=
 =?utf-8?B?aVhOQkdFcjI2RTZSV0JOb3ZjRzc4VThMczV4cHM1UlhnS3JoZFJBTzB2c0ZY?=
 =?utf-8?B?b28vMndIRCtBeU90Q1k4WHpEaGhOZHpXajBvcmxZdkFYZjhEWmgzV0dnYUls?=
 =?utf-8?B?RVpCSC9pQkhOTWR1YVZqTWZUdkxVWnVjdmhvOTVZWm1Ba1FBdFZNaVBCTGQ3?=
 =?utf-8?B?Z2NHMEExUGRJdVBVYzZyTEM1MDJLaTYzVnkzdEZUL3V5bFd0WFhCaXRkQTU0?=
 =?utf-8?B?YzBKaFhmZ3VQazZnSUtyZFVPNVRLQm9YdlluNExnWkdzbzhXVVJxMzlSQmVs?=
 =?utf-8?B?NFNuUkRGOThDdE1qeTNTS0F4SjhnakNNSzZyVjFMMjRtQ0t1UlRqZWhzMHE1?=
 =?utf-8?B?aWFBYXMvUDJON2RzbWo4RWZvM0RsRE11WG5jMFNqSmpCQXp6VU1ZZjgybG11?=
 =?utf-8?B?Z3h5aCsvVTZJZEpwRmI1cEMzUmFJdGsxSHkwTDhobTVZMThlZnhvNmxmemRV?=
 =?utf-8?B?blRQRHZlamxyaktScVNwYnVqNkFkYURpakNtNWNIUHg0K05DemFjWVlpL3Uz?=
 =?utf-8?B?U2lFdU1xOXVBLy9SK1lIWHBqUGxRUmtNaWpEYnEvVk5tZGpOaVNRTnFDMTFp?=
 =?utf-8?B?WVZOQkZHazZhamZWK2EzUVNCNi8wTmtnRkI2MXc5dkJyOUZSMk0wdHZFMkdi?=
 =?utf-8?B?YUJuckF1QlBLWG1TR0dQZjNkaVplMFBKNkdqMWtBRDZYQlR5UTJEeW5GZlF4?=
 =?utf-8?B?OVVKd0FuYUNPa2RVUWMvbDQ2OElXL1docmc3ejNsYmpjZjRsZTFHV0ErR1Y2?=
 =?utf-8?Q?B2S+6O+e85w1rRo4ca6Yih3Hj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9b4ab9-9ef6-4d66-7dc1-08de200e03a7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:02:49.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gbrArGSubLuplvw4m+bQwRBHtHKmKdbuGCt5a1yVu0uJZaKjhjcTHuzVcLbLJZS0LlspmAzWjTcYxQiV5G7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

mt35xu512aba do not support chip erase command, and it contains one
die, and only support die erase.

Unfortunately the die erase opcode does not have a 4-byte opcode,
here forced to enter in the 4 byte address mode in order to benefit
of the die erase.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 92eb14ca76c57f29ece1edb3fe652c56d1c2888f..89cd146095584ddebdd258a186f6398b420e5800 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -159,6 +159,22 @@ static int micron_st_nor_two_die_late_init(struct spi_nor *nor)
 	return spi_nor_set_4byte_addr_mode(nor, true);
 }
 
+static int micron_st_nor_one_die_late_init(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+
+	params->die_erase_opcode = SPINOR_OP_MT_DIE_ERASE;
+	params->n_dice = 1;
+
+	/*
+	 * Unfortunately the die erase opcode does not have a 4-byte opcode
+	 * correspondent for these flashes. The SFDP 4BAIT table fails to
+	 * consider the die erase too. We're forced to enter in the 4 byte
+	 * address mode in order to benefit of the die erase.
+	 */
+	return spi_nor_set_4byte_addr_mode(nor, true);
+}
+
 static void mt35xu512aba_default_init(struct spi_nor *nor)
 {
 	nor->params->set_octal_dtr = micron_st_nor_set_octal_dtr;
@@ -189,6 +205,7 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.default_init = mt35xu512aba_default_init,
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_one_die_late_init,
 };
 
 static const struct flash_info micron_nor_parts[] = {

-- 
2.34.1


