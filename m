Return-Path: <linux-kernel+bounces-891036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB462C41AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A73BE433
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9B212562;
	Fri,  7 Nov 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="djpEyGdF"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4F21638D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549220; cv=fail; b=R2yBC1dkM5PgRgBxThB/AM+9is10maGU/nFhI1UmSb5a/crmEEwndtyudt4iwu+QJ1dGgCNwFq6D11vYOWZurSJIkbKoEgB3Ox11JwOBsvpwF0iwL1gW9L7v+u2wUP2phhkGkOfQ6NJJU0a4jogVJjQJMlP29o5LTiFxH6xJMOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549220; c=relaxed/simple;
	bh=rvq6h2dSaQBV9PHvwqGF+hEs3X4kHa6EfTh/pkD3XGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nI5cWMsFwbDHevPcCrj9I3sN+Yx3NMEjN12zC2+cg0PF439+0JJ/V+nVOKozq2196he8rbABIaYAWR72um2o/rJCblTtXPjN0lPmxiwOeZ4/gPunU6RXUx7mKmmJbelttpYS0THT26h4h1O5yiZUFRuqV5xJzglOwHYmPtY/z04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=djpEyGdF; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Euw0XyKc8o+ZHqygGt9ElRHCa+mK/Pb9v8G5Vf0HRDapTdteczqFSDdsB6M38cbdiG1bvR508K/zod80MPolY6GrxEMByFifdEB2us8pV4Zep7VpVekQWsw8C4efgvi9QMXbJytoV4kpKwbqlu+Q+/iCiZhBO1qCfxa/LirTCRPtQA9xXAeSW0ocGGACSWymBAifUdVhCDEO6hZ2SCg05oJsthTLvxToUqB3ZkriaG3DpjKXI1LM2MTWCpm/chqhm+62oVEPJ9nnDv8D3eB1MsAne0NvH/GMNPMNQGSvXW+LafZIjWa3LsqR83c+0yC0zqmLhPGtMXWM2py9vR8OOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+zdc6tUHvpLCY5uCE/ZWMGVLaELxGHpcMBX5ycwWiY=;
 b=VG+MuqIClgrzQ62Qgu+HQDHwXD4oyNH7Tvu93H7gNHDWwe77RJk+6BH88KcQwtxILEbgj3rb8T5SINvbfmoEPhbEIOVNIcud8xnnTan7gyU531/1n6R0qwzTYXlhOEpcCuHz7yq1CEDGQDn7RQazDzMuuUsfTcSRrGZcn/kTFD27rVqPCNqjrz+40VAgiT0xrD/NXYFCZ6KiE+3KMkOhd7ij3XJ/ANVZN7xCld2fsg5uAXuXNg0TeEbLt9OrAhKbmb6dWpFnaFpVRce/ish8tl+1yZ7Sj2Erpsejak6xg3lbVp4w512enRBh28Z5PvcJn72zyfGhU6CcWMGyf6//+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+zdc6tUHvpLCY5uCE/ZWMGVLaELxGHpcMBX5ycwWiY=;
 b=djpEyGdFUu/BOclbZfuMfn4M+TuGQn3fDGhT5fQZ7T5XzZpPsWtisJ/FvhB8UCv5s594tNAvT2gcEa9reWjIlxQAGGS3hnKk0zOdv9Pm+PcqHbfgh6Crw3apcVm7IRmSm5hs7Vd8spyAn5RR3MIe5X6bcjvh8v+xULIDyIj9MKBa3Z44nZbrVlZVs4zEFXDcMtOo9evjWs7Hx8T8tHEPFZ6nfHN3XmkyZMZmqFQ2JTFLeY//u58DqR9gUdqh7wXnZX6xSyC2LCmjRJbxIhXATSMoEW4GdsDX3SSdpiDzL8yh6krz5LDvB0iR112SJDRoJTHMtsjszGmvT9mUg35z3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7800.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 21:00:15 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 21:00:15 +0000
Date: Fri, 7 Nov 2025 16:00:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] i3c: master: add WQ_PERCPU to alloc_workqueue users
Message-ID: <aQ5d1g95N86lXXT2@lizhi-Precision-Tower-5810>
References: <20251107132949.184944-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107132949.184944-1-marco.crivellari@suse.com>
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: dc54d9b9-1c2e-4d1b-4580-08de1e40a63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkdNNkxDcVdydW1ibFpKMjZ1dFA0eVRwMGJON3NTbVA3R250RmVucE1kQVZx?=
 =?utf-8?B?UVh4cWR0by9sQzdPdGJFYXBiMlVzeDR5SnF6ZTI4bldxeHZCT3RmOWMrL04v?=
 =?utf-8?B?WDk1WFhmVDdCaUpKVWVYQlNxOFlQVHlsMzdxWjUrMjN1aGM1cnU0bDRNTkZT?=
 =?utf-8?B?KzRRTUdlUGt5RWkxOHdhWWl5c243a3NGb012UEJ4V3pmVTRSbzNoRkc4L3ZR?=
 =?utf-8?B?WTJtV2d4Zmg5WldzMjRBb0IzMkcxbksrenVvWVE3UnFkcjArL2VzV0ZIM0lE?=
 =?utf-8?B?T2JVdm1YMno1L0tMZnFBWGVmNUE4cWNOSmdubVg5eGJnTHMvRkpDOXpuQ3Az?=
 =?utf-8?B?eU1hQkFTOUNzTkZVWUpyTW55MTR2bURxTmJpTi9wZGVDSC9qVW10SXhoMER2?=
 =?utf-8?B?dExpNUlqZDlZajhzS3RBVC9lRVEzSmMya0phLzI4QlJrYm40VWUyTTByMnNr?=
 =?utf-8?B?SmVBdys5LzhkVkhzN0tyOGVVQ3lPd054cTBieWRRMkptQ3NCZkJGbnpRMjBT?=
 =?utf-8?B?UVB0bzRPYkVOdzd6eUF4VEs0d0x2Mkxyak56bFFZeHd4MjhhWXkwM1RQUXVo?=
 =?utf-8?B?S1ZXMG9UbHd5eWJFWHkzU05XZFltOEpXYVNxL1E4VjJQZXZvN2Z4blkwd3E5?=
 =?utf-8?B?TG53dS96SGkzbjJkVThBK3owdkRxcmNyU1ZraWJ4WlhFU0tvcFZDemdqczJM?=
 =?utf-8?B?M0oyUERrWHFMUVNTR1dQdU5HQkRLejg0WEI2Z3dqcDU4VGRpRHR4eWNOSVQ2?=
 =?utf-8?B?NzkxWk04eXlISlhuTkxWdVFqeVNYWHVGK3dIUE9RSHB4QjgwZUR6QXVaSWJ4?=
 =?utf-8?B?K3hWSkdYZ1pyaDMwWlFtOXdUTWF6eDVMWlNCUmxpdWlEZUJBNHp0TktEMU9H?=
 =?utf-8?B?RzNUTDZpbG1kK1lyaEhCajl0MmYzbXlTMHpiZVVlMUZvdEErSEh0aTJKMmNn?=
 =?utf-8?B?WDJGTmVRSXg0OFRZdk1vZld0VW8yY0RpSFJmK3hwNEk4Z1h5N3FNMlVLYVdV?=
 =?utf-8?B?R2p4ZHp6NHFLcFdCNlhubmFoWFBjTklhblZhRjhYQjk4UnAycWdWd3VxR2g0?=
 =?utf-8?B?Yi95eHNJWDlGNFRxVldMN3ZIcWJqaVB6Ny9PMFNIVThUaVh6ekV0VWowUThk?=
 =?utf-8?B?dVhaZHc3MnpUTlVuZC9XSFhSUmxFK3FERzVMVEg0VUhyTjBiMWwrTUU0MnZT?=
 =?utf-8?B?eHJzWmhHbFNRQ3JOL3l6bHJ6ZDVkWmZDS1hpOFZNT3Z1NGJkVTVMNHlMY09R?=
 =?utf-8?B?TWxuTHk5UTlGbThqYXNXWUZXSy9zZ1J4WlhNWUFsc2dHcHFuQUxMOXkvTUt6?=
 =?utf-8?B?NThhUFUrMko4b25lY1IrYkwwUTE2ZWV2UGhaYkJZRlg3dEtXT2d6QWVqaU43?=
 =?utf-8?B?Q3A5NE5INk1TTERTRVd1QXZyaWlpd0IwZ21nWk5kcVB0ZFhmYmNUM1FaUlo3?=
 =?utf-8?B?ZDk5TENRU0wvb0hIVUhRczdxd0RPei82bUNodmEwK1dPdjhjZTgxZExDWExP?=
 =?utf-8?B?NnI4UzBWNkU2VVVVL2xHcmRITFozYytBMlduZ3hrdndjc3VBckNDWGpHV2xL?=
 =?utf-8?B?eGRVMjV0U3V3eWttbWw5eG1mNVFsODVKZVlkeWVxRTZUT2dlblkzNkhCTDNW?=
 =?utf-8?B?S1BDRm5IZzdoZ2xTTWppazhsblhoekRIbkIzU0lEMkF5aE5DR2R0UnJuUGp4?=
 =?utf-8?B?dHdteWJLZW5DUjZwNTdaQkdVSzh1WG1odU5oOG5WV29zUGMvZXU3VEY1cFN1?=
 =?utf-8?B?aEJRdGowS1B5Y0RwZmtmUTNyYmdpY01GeXNIWGovanpWKzlDcC9MSHBjeGpn?=
 =?utf-8?B?cG1TUjk5ZW5ZNTNNRmlpc2Z0L2Z6NHJ0eTlYMVh4djJ3NS9xL0lsTlVCQUhU?=
 =?utf-8?B?M2VvYSs1N0tLVGlrSVVDNVZWYjY4RDNFc2pCVnNWTG5wMVhnZUJKWUJCbzB4?=
 =?utf-8?B?dWJEKzVTV3Nnd3plT2k4NkUxaWk3L3dFc0JMVDZrelNTU0JZZTg5T3Nxd3J4?=
 =?utf-8?B?dGdTVVB2dUFxSXNGNTNoOVJSZitUZk5qYVluTExWUWhaaHVVVmlnRy83MzFi?=
 =?utf-8?Q?0njdgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5SaVZPeCtjVUNjY3pRUk1vYk1DNk15em9PSDlkYWhITHNQS2QzcTZ2OTV5?=
 =?utf-8?B?QmVKWXlHeXpFV2V1eUxtYVpYcGNVYmx0MkFybmZpbzVUV3F2elB5ZFhGTWt0?=
 =?utf-8?B?bGRKVTBtWm9CRmpxRmhrWDduR3F6OWRrZElYR2Q3YnhsVnIvdlV3dE1RWlVp?=
 =?utf-8?B?WXJjeFUrQlNUc0hIaDJyTXhqRUtlK0RINDNmMWtNSzV5cStweGY3Z0E2Um9n?=
 =?utf-8?B?MnlzdUdWRVM0c1FhSkplM2JQRHUxaXpZR3dWdXRmQjYrNVRNZWx2OFhGUTh5?=
 =?utf-8?B?VUo5bm9lbWZEem0xRFc3K2lsajNQeVpsaE41dHluZlBvZHRzeVJudWVzOTRu?=
 =?utf-8?B?eFNpQTFxUjV5MTAyQUhDcU4zL2VOWFRwY1pvajlDQWVNWnhFekFqaVduMWJw?=
 =?utf-8?B?NVRkWmNpWitvNTU3OWxzWnBLcDBVdXc1bUtpZGY2U09ZVXFyN3c3bk92VGFW?=
 =?utf-8?B?QVZzNkQ5aFg4ZzJ1Q1VkaE9lVm9Ia1BtdWZtalNQeFdQOFRoclNVTjkzcDRL?=
 =?utf-8?B?aUxQVzNXTmJsc1E3VkpKWm95dXFRa0Vqc2hwb0hYMXF1VDBGLy8zSXhjVXRT?=
 =?utf-8?B?QTNudlQxYTAzZW4vN0FxRHIrbmdKRjYxTTYrOGdGSWdRUGhvYjdsbURNempu?=
 =?utf-8?B?NS8zZkQvdkFDTEE3djlLa1lFc3hwbHpKYk5FN1Bma3NGQWJBK0hYQXZYOXlo?=
 =?utf-8?B?S050Vm9ydFRxVWd6REJjcktGbmVuOFRrVUVFd3dQZ2JLR0l3cHZUU2R6cWxF?=
 =?utf-8?B?RmRkd1VSMjhKT0U5dEVOamcxYnBxMXl5UXVHaUU3S2pGdVhEcGlEUVZ6NWMr?=
 =?utf-8?B?aWw1eTRtRDBEMjFuNFNINlpnd2xhYm83SFp1bHErbUdWcHNkaitTYWxrZ01M?=
 =?utf-8?B?RXU5OC9jak4ybGo3OG1ya0ZHS3BueUdtYy9LREZVVlhjUGpTTXpRYnhNaExa?=
 =?utf-8?B?Nm5LRUZOZXFod0piMkN5cE9qeWwzVG5OZkxSbUNEcEtTNkdBVmhLM1BXcjRq?=
 =?utf-8?B?c1RYYjNxQmFUZjhtZHZxRXlmRGxJZnljamhNSnhVdnhFVWhSdmxFQWN1RkF6?=
 =?utf-8?B?SEFhZHgvcUxmSGprUmJCRmE5NFY1QTJ6Nlh3SnpkUzM5Tk5rTXJMMHFkVjhZ?=
 =?utf-8?B?bFBiL0NqaDRVWHRFeG1lOGNpeGVpTHJkWUYwS2FwNUh1dEQ2SDZlVExOY01C?=
 =?utf-8?B?VDRlNXNaL1pDTTRTcFFWSGdBYWc2OGRoL1hOZ0pnS21CTDZTMURJbUtqNjVa?=
 =?utf-8?B?RHNRcU45c081R0hFaGd2dFI0bTM4MGlJT2FZUG5Eakljd1NsR2R0WEx2cmhO?=
 =?utf-8?B?S28zTTNDUlhZTmxqbjhERFBNeEpHcWVSRTlCZWJhYjhNclMrYjIxWUZBNGly?=
 =?utf-8?B?aWZOa3ZQLy9JUzlJOVdaVTduRUZPZjBNSXE0R3VNWXVOUEtsYTF1Z0lWYXFR?=
 =?utf-8?B?STdXSENlUlV6OVRBeFY3UVAxU0FXUGw5MEdMRGZoK01yYXJKdk16SzA2YWRD?=
 =?utf-8?B?V0VVL0xMbkYrcjZrYklkTmpFUURVSWVMTUYrSVNkNG84SDRZM0JTTFhQcjJo?=
 =?utf-8?B?RWJ2TlZQTXlrblJLTUh0NDdlYkpXNDkvTHB4SW1VSHBPeHI3T3VISnEzMzk5?=
 =?utf-8?B?T3FqT2FRZTdjWEZqTFNaRDU1RUVHS1dlZFBNMmlQMHhQajNLNGlaZUhEQmJG?=
 =?utf-8?B?dy9rcXptaWFLS3cxbWFiZjM4WTFSOUlSK1NRYjJScTRlM1NuZUJvdWdESTJI?=
 =?utf-8?B?Wmx2TzlXUEljNnoxMlJCQjRzVGVEY0MzOUgyRDNKQWxkVmZDY0cxQWphNEt1?=
 =?utf-8?B?OXFkTDVZcW55OGM4ck5Cc3BpN3JmSlNvKzlVb2g1cnhpYmdnZjY5QTk1QXQ3?=
 =?utf-8?B?VFRQQWN2aDNnNWFaWGdHQ0h0VGxDR2s2STBkTFdicVZBOC9oQlBTeXpHZVdh?=
 =?utf-8?B?NTI3YkZvOHk4OStOZkJmd0h4VGdVUEM2cHFJYXJXZWw5NTgzbnN6MURvcGhG?=
 =?utf-8?B?aUx1RUVJOGJuU05VakQyOG5sS09oZUlJWW9vZTFWYmVDWXlTMEttUC9mT3hi?=
 =?utf-8?B?VDJ0QkpDTVhuK3RkSFd3Ykdrb1BDQ0cyaFpTbXg3SkszamluK2pNNVNoNGln?=
 =?utf-8?Q?HX9w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc54d9b9-1c2e-4d1b-4580-08de1e40a63e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 21:00:15.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccBS63vO6pnQzpUHQIiIOh6vD5P1jTJ5BBjbcbB+nCcLsfMkNPymS0A8/ZjQ7spkn4iL87NkjE30426ILjmaNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7800

On Fri, Nov 07, 2025 at 02:29:49PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
>
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
>
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
>
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/i3c/master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d946db75df70..519b98c37ac7 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2925,7 +2925,7 @@ int i3c_master_register(struct i3c_master_controller *master,
>  	if (ret)
>  		goto err_put_dev;
>
> -	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
> +	master->wq = alloc_workqueue("%s", WQ_PERCPU, 0, dev_name(parent));

Maybe off topic, I think it is not neccesary to create wq for IBI at all.
it can directly use system_bh_wq, or other wq.

Frank
>  	if (!master->wq) {
>  		ret = -ENOMEM;
>  		goto err_put_dev;
> --
> 2.51.1
>

