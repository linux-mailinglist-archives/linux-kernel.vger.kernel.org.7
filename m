Return-Path: <linux-kernel+bounces-744204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0CB10974
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA01898853
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C171288C34;
	Thu, 24 Jul 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxWm5swV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lxWm5swV"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB61E8338
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357464; cv=fail; b=MX/Fn0o6VfRUr9+MBhcQRKENUMDR2tCKFoZUiSahYmoS3WAmRp8aoYsOo2vgs2mgLP0woP5b3H+HCBA178oLJxvKA2SkXN2bEnn/aQPuRSJDIfD3KcSTIXjweIfX2P5H12/eggdzQRuxFBFtTRHcr+y2SW+PRoIthHKZ2RLtcT4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357464; c=relaxed/simple;
	bh=rXL6W/XoIxUF7nCcRpXi2CQjwUMTw4sZ9rma2uP/gzE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uThQ9uZsv0MCzLkV6Zcu3o60Vns2rQyBYitFio2YA6NQeLw20yXZ20yqVSWAMloqh0Ao4E6UN9B0kBwuI0GuXyvIbfNQSWAM/ouGEc6m7wudny4ty0djai+HFDkoT3Ms5eyQ3IzT5SHQb098Op4I8GW/3lTKeYl/u/qkkmHCtvI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxWm5swV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lxWm5swV; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hMTL3HdQ0VoeOGUgbOMYHXhbOC+W35Ae5pL+7KMtE634KFMXFtBHl+632kco/j480PpAm3ErNDEMxOF7AP+VLnwU6zYcbw4W8K9rfigGErJ9gyjrC0eRgLg+SwqzyTNw0bvvPgeLsofqZyR0Xv4iXPElswlZsGEVpRQ4oORlBUrpKPfI8ramlTGPbvSjlJL7Zn44ST3BhYMRMfcSOsb++azW2m6Zz68SrV4gLDlxav7UH2MlKzV8PXttTgs/6If33XW+QCN0uDTUp9ofjIChQQISMI94/EAzMxGurlIfLph2nYSu41gD+XXijVkKcVV2rncYas/nq08lDI9rG71CPA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xy8MQ1rvi87799yY1EaXVwPUaRXoMRNQFSg47Ps7t4=;
 b=tnyzf4hb3Ud60t13Alxkxzq1LR9W1c6IdkSN/JBDFMuSGT4RSAVM+DQZxCfJbXwFSEmPpGQYPfSY+YwuBufityGCZRv6wfDdgyTV2Mi8QzJJeBG5a8lOXes2Xbx/I/DBg5GoE4cLDo0m5A/qzXh4d9wxXEK8QEmY694HuSK279Wx/i5mxx60MW+EtFMQxUQ57d6UgLjNo69NuG2ubV9kh9cBz1fB5nrtcLxTXBhfV1OGaLdcFOQFJpg/y7KmGORkrcJFt55IwqPi+UcN/vAJfiz3PrKAKOMQA6Lp1yadU9QYzLxc2I48xgqbnSX+I8os9kOGxFMyWHAhBfR7Reo9Ug==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=os.amperecomputing.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xy8MQ1rvi87799yY1EaXVwPUaRXoMRNQFSg47Ps7t4=;
 b=lxWm5swVciktB8n8jYx8wLGjhqW/gdBIx9Cxt9NWsSdoIuIAF7nQFBLppP0eBHYOmWNajj4PxAKtckzKr1Z8o1nLbPZ5a8Q5OoWEF+pU0BtEcR1bRJA/r5yhSd670lFjY0zMSFAAa/wZGLqPc1XaFvXYIqZR4NgAX1iTWLYIcyU=
Received: from AS4P195CA0033.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::20)
 by VE1PR08MB5759.eurprd08.prod.outlook.com (2603:10a6:800:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 11:44:14 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::e7) by AS4P195CA0033.outlook.office365.com
 (2603:10a6:20b:65a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Thu,
 24 Jul 2025 11:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Thu, 24 Jul 2025 11:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE2eZuFGuVf/5crvw1hWsA1+gKxlhn4UkmpQ+PnEPsDXoFzVBlg3w4BetUBl10f2+yzkVsnmmB+B6Y3uQxzAiQve+Jd0T6wWG8LzmU3op8AJKatbiSH+99NLvjJJay086cDyS28XSEQOHFeh+zQUwGWHBlTXVcsVFMv9ePI34h5Poz9VvO2rORaAqBf+3OceQ/lul93tTdaqq+ONi/fpSU/jaMO907u10lYkUNmHQts4tvrFBauPsoHjHtrOhGCv7Lyz7dIvi3t8VCOQMyk8QqwLVtyodQwFdbS7vUTVP0f1GYtseShllMT6RVfrEtCscaiqPzNLklx7CKGUJjtXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xy8MQ1rvi87799yY1EaXVwPUaRXoMRNQFSg47Ps7t4=;
 b=WdWvhT1Fc6WDp3FMFYwZoQMuTbxHd2vyASa/IWS7H28VE2Mp9Veez/H3i0x1rt5Seh/gRseuXwU2yyM2QpYmAVtw0F9sDeCc90wMOBFMzeHKB1PbtNf37uRPpVy/pztXMrsF+NCwAgGJDZYB0iLpnCASxsvX+eeVQS8tgeMebgQBrwosx4auAF2kVuisZXXRHz13ENn075n/6mIn4BiUs/+PLpAOhH9D2uV/iALa/lD6BOfvkMtOaINrojJpNZtmYFsrbnSXCSvQiFrKwl8QqqOEIczG3RjrRUeiAFVoIDh3JE84t+q7KFTd3LCrV1M4beLNFHpjn3Cn1YNGM2UfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xy8MQ1rvi87799yY1EaXVwPUaRXoMRNQFSg47Ps7t4=;
 b=lxWm5swVciktB8n8jYx8wLGjhqW/gdBIx9Cxt9NWsSdoIuIAF7nQFBLppP0eBHYOmWNajj4PxAKtckzKr1Z8o1nLbPZ5a8Q5OoWEF+pU0BtEcR1bRJA/r5yhSd670lFjY0zMSFAAa/wZGLqPc1XaFvXYIqZR4NgAX1iTWLYIcyU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6006.eurprd08.prod.outlook.com (2603:10a6:20b:29a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 11:43:42 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 11:43:42 +0000
Message-ID: <c77aa9e4-2209-4dbd-904e-daace1c929b6@arm.com>
Date: Thu, 24 Jul 2025 17:13:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Yang Shi <yang@os.amperecomputing.com>,
 Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250531024545.1101304-1-yang@os.amperecomputing.com>
 <20250531024545.1101304-4-yang@os.amperecomputing.com>
 <f036acea-1bd1-48a7-8600-75ddd504b8db@arm.com>
 <50a4f767-0007-4f6a-8c62-398962d54029@os.amperecomputing.com>
 <ed942c01-58e8-4d91-8f86-3b3645af6940@arm.com>
 <452be681-f28b-4b5b-848d-c967672b4f5e@arm.com>
 <3b3be4db-4f8e-4d81-8e52-dadad23dcd24@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <3b3be4db-4f8e-4d81-8e52-dadad23dcd24@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6006:EE_|AMS0EPF000001A2:EE_|VE1PR08MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 40587557-d2a1-4449-b89b-08ddcaa76a40
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?N0UxMytOMGl6b2RPYXFKaURSNmo3K0tZVDQ0b0wxVGlmeldLNi96YUV6Yzdl?=
 =?utf-8?B?R0ExOWNzcDBvOGZ6STZyUW93TzBPbHc1ci9HUGxWMzk1amxmaWJ4dmdCWkN4?=
 =?utf-8?B?VXRZOUpPTlFHYy9TM0VIcGpSNVhYajRUK1B0QVU4YzNxa1ZhR2E5Y0xHajRR?=
 =?utf-8?B?aUd4ekNpSTVtZVNVZ3l2SkQ0eis1YjRQWHAzWG1DNCt3bnU5a3RTR2NJU3VB?=
 =?utf-8?B?Z1NqRm1HMkVoVDJUVkYwejROVFhWWEEvZ2Jham9vUUN1RXBLa0t4U01KdUpZ?=
 =?utf-8?B?N0tES09WOHBRK3F3dlNWRDdaUi9oektzNGx5K2VjYURxRktVT2dIckZCanN5?=
 =?utf-8?B?RThxTGtZVk5leUtPbUpSdTJCNjhUMHdqVXVRMTVzM1hPNzNZdWtKVDJNclph?=
 =?utf-8?B?VnBQWDZiV3dWaWVKYzNKdUIwalo3elVUcDQ1ZTJBWmhKc2xpZVhjaC9oaWZ1?=
 =?utf-8?B?Z3JGUDhJdDVQOGtnbGZMWEVqMjBXdmlPN1lVYnpPamdJTDZpRXpOa29FSXUv?=
 =?utf-8?B?NGZ2WUhqanJ2Z0NnVkhOdm9TRTlWaEVQWHFyYVZycWpnZ2x5c2Z3dUtXYjRo?=
 =?utf-8?B?Vm85L2pxTFAveW9mYlVtdThrb2JFWFRjTkE4QnY3ajhKZ0szanpGejZHMmE2?=
 =?utf-8?B?VkZReUJrK28yU0xwZ3NrY1huV3N1WmV0WFpNN1B5QmdnMTl5UTBGYVJzY0RL?=
 =?utf-8?B?b0F2OFlndU5OYkIxc0ZvblVoS2lUbzlMR2RDWlp2L0ttc3NyQWhqRUV2cHM0?=
 =?utf-8?B?RE5HaWd0VFZ6WWhuM1ZvZEkvYkFBc3NHdk00SmZEM0h1TWhyTGtNYWR3Um14?=
 =?utf-8?B?cnVhOHVrbEh3ZXp3QmpJUUtkbVhrdzRSbTBDQ2dDT2QvcWQyOFFrZlNpd0lj?=
 =?utf-8?B?TVZ4SUVTUGhYVUlLY0N6Sk14MWd6U3lkbmYwekhnOGlTQUtHdkFNUXdZQmtZ?=
 =?utf-8?B?L0pncHFCQW1BemF1T0xJTm1SbkRWUEVVSFdadzRrdG9YQUVjMGhBblRhaW0y?=
 =?utf-8?B?TG43SlBSQk92Z2pOL3hOQUxjMUMzUmoyNndtVDVseUxYMzhVNUY2N2YxdldQ?=
 =?utf-8?B?Qll0MnZpUG1SSXpLb1gvUkZLNnBHektlYXVhTmtRN3k2b2tzUEhlMUZyNjVi?=
 =?utf-8?B?Q09YRnNPbldkRXBTVTRseVRndlJhdVVuZzlTZmpnQ3k3dWJKUFB4V1ZNQkRH?=
 =?utf-8?B?enUrS3ByL1BmdmROZjJiUEN1NmdaVjZrcFJXL212ZlZZd1pCd2dzaUs5L3VG?=
 =?utf-8?B?YWVzckV6Ui9lUXdDRU1iLytiTTZnMzJWM0hLYy8xV2FkeElwNjBKTUxLeTg0?=
 =?utf-8?B?R2pVNnBUNXRTbXg1c3ptL1Y4V3JsSllTcTViWW4zbEgzWFJYUmVvQ0xjTnE3?=
 =?utf-8?B?MU80bDkraFQxdklieXdmT053cVhBKzVDaVkwTFhobEJlZkx3ZzlISWJnQU1V?=
 =?utf-8?B?YnZkdUZOV2UvUEJiTWJ2U2RKRlFpTEc5dDYvMkNwU2hZaGVFeUZGeE5aU0xq?=
 =?utf-8?B?VkE0SUo0ZktiK084Rm9UWlNxWTdhUUl3aXh0TlJRVDJKczhhTGFYTDUwMDR6?=
 =?utf-8?B?WnNTTnp5eWYya0lhZFMydWF0UlAramJYVlR0Z1BqUC9CZTlvMlpUOXc1bFlZ?=
 =?utf-8?B?VmJucnpKblRDVTZjTXZDOGh2OXV3ZzAyS1NYQWExWGY4WmlIcXNyVFFUL2pB?=
 =?utf-8?B?OTdmaFdSM0RCZ1BVajloUlFZTHVFQ0tWOU1yZCtUYW8vdTE2OWkydzhkU1Vq?=
 =?utf-8?B?OEt5TGJ5RXgyTSt5VlZPSUFiZitzSndHZWtkVWdkWWVjdnkxNUtDdjdWZnQ2?=
 =?utf-8?B?QmhvV1pPWXpVLzRSeVVkOGdZTkRzRXVPUkhldzZXa096Y3hWVDJOeTJpSUFN?=
 =?utf-8?B?TTRBQWxnSExHVGk4SkNKcWt4NHE5TnNoY3hWZGt4MlloSldrcWlVZVNGN2FR?=
 =?utf-8?Q?QV+eOatM/nE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6006
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ab2e41f4-404c-4142-3249-08ddcaa75692
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|35042699022|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjNYdzdzcTZXNG9ScXlNQjc5djY2cFhlMnBDOWU1RStqcTV6VkRkZmFERVdh?=
 =?utf-8?B?WFphWThDYi92dVBVOXJGV2sveFczc1lGWU1XKy9PMkJ4QXRvUFFlRm11aEta?=
 =?utf-8?B?dElNdU1XT1dXekVEL3RiMWhTZXBLNUxIVEtPUzd5OUkyU0hoTzRmVm5jRm51?=
 =?utf-8?B?OFArN2RLR1hTTGNMa1JrL1Ztdzk1MENSSXJQT2p2UVJYdlNUUDdFaG9qRDJX?=
 =?utf-8?B?VEZwZCs2ajEwOHpyNFNEVjVhMXhxZExVd2U1SGwwdzBZMVhPTVRsL2ZHSGUx?=
 =?utf-8?B?SmRpVWphZi93Qi8yeDZ0UFF3WkpOOVhmNWJmZHoybzhVcDNzV0xhZy9zNkpL?=
 =?utf-8?B?NlpLK0VOWUZha1VmclN1ejdaVjhHR2ltM2Y0NTE4aitPaUpGQlBiTStwUlZt?=
 =?utf-8?B?K05sZU5wb0E2djNaTmNHd013RUFTWmZiLzJpcDAvT2RoV2hVc1paam9tck9Z?=
 =?utf-8?B?aWp2WmJ6U2VtdlN3cDlNOTVicTFxVHgxYXc1alNxVUVDUWRrNnNCZUlHdFpX?=
 =?utf-8?B?bTlRREZEeFdGcjN2dm5MZHI4Z1MvOERlY01oak85WkMwdnNXZ2hKMzdrNTQr?=
 =?utf-8?B?QVB0ZWRIWEQrMURpRXVCemJ2Z2s1ZTcxYUY2ZXJJVDJVa09YRDBEclgvMFdH?=
 =?utf-8?B?UUM4Tzh4dEhqNWdZdjlSTitleVRHTUxzR1VIaE9IYzRIdUlGaXBMM2p5eGlw?=
 =?utf-8?B?cUlIajVwbGN6RzJnb3NnSkdKMnVnM0N1Wm13M0xwTzd3cHFVejVPaStRTnRk?=
 =?utf-8?B?SUVmdUdZcWFkRzh4OHYwc3JsK2QvT1BCODJIdFVxdU1vSGFqSlhkcm1NMjNI?=
 =?utf-8?B?VjBaZS9RTC92cWhHNlA5WE53WnJkU0tPaS9UZktmS3Vza3lBK1ZNSUZNbnRE?=
 =?utf-8?B?a1ZnRk5wR09uSUJSbWJwRXlNR2RkeW9SeHdRVW9HNVdkSkdFbXRpYTlySWxw?=
 =?utf-8?B?ZVJzY09lRTJPVzBQKzNsWisxdTRhamsxVzNkck43TzVUcFVUZlptVlVGd2FW?=
 =?utf-8?B?cGtrT0ljeFpqVDh2dk9BUk1SUGpUVVhxYVBMREVKUm1vNUp0aElOTHJQMkFs?=
 =?utf-8?B?eWtRRFEvMnFyaGs0SDR2Y1J0Z0JqRWtJMWNmTGZlenBkZitXZVNsdTdDNXov?=
 =?utf-8?B?d05kU0htZm5EcFhuWUlId1hHMzF1RTU3OXpzRndwWE5QOHJ3R3RZODVGSjh1?=
 =?utf-8?B?S3NtMGM5Yk9jUUlXOVVZZlBoU09FMm1PNlN6bjlwZDBPQ0xZNWoyZ1EycVVs?=
 =?utf-8?B?ZC80dmFuMFNIc2c2STY0VG0rMk1oOU0vRUFObnFEeExDa1ppbkFUcm1VZDNr?=
 =?utf-8?B?RGRhcVdwSkgyKzFhYnp5eHJwQ25leG43MTdaZ21PYTRjd09LSDg1S1BHbEUz?=
 =?utf-8?B?NTN6MEI0eTd5NjVsTlNPUktYNDZsQ1QyTFZ3T3haM3JCWnZCUTdzaFpCV2JJ?=
 =?utf-8?B?WU0wT3IyVWNDYTI5RmVaOElrNkdVTXRJWTlYcUdyYUsxK1BEUkppb0QvL0M0?=
 =?utf-8?B?d0lXVlI3emp0Z2JMa2ZDV0VKV1ZlL1M1eTZGWkVzd3JUZFVJVDl6N3NiR1hh?=
 =?utf-8?B?MklrZEdZczdiNlBRdXIwMFVZbXIvRE83c0xCb0dQb2xYSk40a3YvL3o2M2pj?=
 =?utf-8?B?b1REbERXQnVVMVE0VEROcmNFcUMvOHNoNlBCOW9MQjVDU2d1S2FWd0F1ZHZa?=
 =?utf-8?B?c2NPQjBzNk54cXhZS2RmUXF1MUhnc2gwZTNlcTFJQTJUWnhNc0RSSmVLT3A2?=
 =?utf-8?B?TVNHVkFRVGtoL2pzVUFHWXUxSWl0V2I5cGN1ZjNuRmpSRXRXMVdXN1lFVnpp?=
 =?utf-8?B?U1VRclRib3RsQ0JSZ05HUnJ6dmFzU1dUaER1WktKY2JsbE1uU0JkUnBEVEV1?=
 =?utf-8?B?dUVyUXBybDZBK09LZ1ppRGY1SEQyMit1MUs0VFlIdjc2VENtNEJBSjNhb2RS?=
 =?utf-8?B?U0V3UDcvYndtVDdreDFwQWJVZlRhQTd0WG1yR3BteWVKL2FGQ3dYZlRid3Jm?=
 =?utf-8?B?djRIZEY0aEhZTEppSHpnMXZUdGt6QlVkZWQ2S1EyVEU0aGh0dENDOWFKaTQr?=
 =?utf-8?Q?XtIixL?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(35042699022)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 11:44:14.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40587557-d2a1-4449-b89b-08ddcaa76a40
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5759


On 24/07/25 2:21 am, Yang Shi wrote:
>
>
> On 7/23/25 10:38 AM, Dev Jain wrote:
>>
>> On 23/06/25 6:56 pm, Ryan Roberts wrote:
>>> [...]
>>>
>>>>> +
>>>>> +int split_leaf_mapping(unsigned long addr)
>>>> Thanks for coming up with the code. It does help to understand your 
>>>> idea. Now I
>>>> see why you suggested "split_mapping(start); split_mapping(end);" 
>>>> model. It does
>>>> make the implementation easier because we don't need a loop 
>>>> anymore. But this
>>>> may have a couple of problems:
>>>>    1. We need walk the page table twice instead of once. It sounds 
>>>> expensive.
>>> Yes we need to walk twice. That may be more expensive or less 
>>> expensive,
>>> depending on the size of the range that you are splitting. If the 
>>> range is large
>>> then your approach loops through every leaf mapping between the 
>>> start and end
>>> which will be more expensive than just doing 2 walks. If the range 
>>> is small then
>>> your approach can avoid the second walk, but at the expense of all 
>>> the extra
>>> loop overhead.
>>>
>>> My suggestion requires 5 loads (assuming the maximum of 5 levels of 
>>> lookup).
>>> Personally I think this is probably acceptable? Perhaps we need some 
>>> other
>>> voices here.
>>
>> Hello all,
>>
>> I am starting to implement vmalloc-huge by default with BBML2 
>> no-abort on arm64.
>> I see that there is some disagreement related to the way the 
>> splitting needs to
>> be implemented - I skimmed through the discussions and it will 
>> require some work
>> to understand what is going on :) hopefully I'll be back soon to give 
>> some of
>> my opinions.
>
> Hi Dev,
>
> Thanks for the heads up.
>
> In the last email I suggested skip the leaf mappings in the split 
> range in order to reduce page table walk overhead for 
> split_mapping(start, end). In this way we can achieve:
>     - reuse the most split code for repainting (just need 
> NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS flag for repainting to split page 
> table to PTEs)
>     - just walk page table once
>     - have similar page table walk overhead with 
> split_mapping(start)/split_mapping(end) if the split range is large
>
> I'm basically done on a new spin to implement it and solve all the 
> review comments from v4. I should be able to post the new spin by the 
> end of this week.

Great! As Catalin notes on my huge-perm change series, that series 
doesn't have any user so it does not make sense for that to go in 
without your

series - can you merge that series into your work for the new version?


>
> Regards,
> Yang
>
>>
>>>
>>>
>

