Return-Path: <linux-kernel+bounces-896592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E79C50BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA29188F881
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074D2E7182;
	Wed, 12 Nov 2025 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GUcNrX+e"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFA2E06EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929387; cv=fail; b=ZpYylWsm+wLQBYZntfjsPVCyeRy4Wh2AScsTZDaYt7bOgZe/adKN0pGcYOqc6aLyGbVgI1+q4qC8oYlI468BBU2MGkC4if8O9bNFUzgtcKCwpskNzyt+ERFa7uPkpc9CFP16EYnV1zfQ+rWWOc4wzFGcM0RwIjW3hcbQJ5XUA2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929387; c=relaxed/simple;
	bh=cKir5GY9MDPVxXpDKgg0UgEtFcz2CrFU9GyO/yNUjDE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iLzygSsGt6KlUC6WD/EFfMdpQ/Niy/kMst3BH+wO0sWm8uTqqN3q9uVakWPFL0zpS89tlUEsGXk0dGkc2v7Ifm6JtiZGhyrpQagYlQz5XQMgtEitiD+W4FedbOCI1X8ZQwov/IoHuqB6Bttm0G0Ht5AMyL2Tppp7QSLrHC2KMZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GUcNrX+e; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1vTHNFyCTiz4VloRYNW5LXdYZIl16sC4+H3HEL8spMdela9FrbSsd5tGq7LF/O6qXAD1g5T50Sre1f12hHxpIJ7iUlKa3blusWTNF29JvshNmFmkjDLhRAMOwdCeq57TEgLEBXeYMQ/rK0vbxkXiazBKfMU7PKucpRTlw8QD037LF0u6fMYFskkqV+HmPj6hprF7kj0FBKu25MRLlzTwhJi8Jck250QxE+35J3vymwHVu8TwQhC0KEaYEoWA2SJX6OteIvYmGviZ0n7YxP2BnUUDgyyNhqWJYMNqNXZBU2RoqzWGZkmDzOgE143TUGoizXK+E/OAu7ZWs95JWHO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2wHNjMJIeExzSbRi+BrgexIPrcHFzYxr7myJ9CjTyU=;
 b=xEXlpCAJPp8e9BvMVRuxH4mgaqAfbjbjZBOTSL+3Bifh/sXtWTErYx+l7kIeboi14AlrOMXKIzG/9DUF55wUa85zVbMFvDdY/O4Ni8xpv/faZBHnhXZ/oUTPPKcvyCxSbB63StjfsxONMDC3o+H6//xvVfEWQtN16je6pR1h5ku8U/uZX8mmA7qCgihhe5Nb74uVHfpX1zhom2KkPHCBCmU0LzZIN/UEc8ms9lIyOqmEvftMSlkToebUqP5tsWnttoNo9RG+A8NxgnQHgQ6x9RDRkWlv2POrqPV+3cEwFzrxrXakaj+8v0T6D9eDlsbIPqvgzpNGscqIhKvafiWrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2wHNjMJIeExzSbRi+BrgexIPrcHFzYxr7myJ9CjTyU=;
 b=GUcNrX+eCVT+6i6cYAzyahFRSSIHBb0e3Qc+Cp0bQSyJI5oVDxJdJ7tMjMkP0xXgt3vIDbZrukUCMvivPxK2szpt7Y9txZsAo2JJr6sviKgPXmbfElfOzFIV9C+SQ7t3w9YgQarGlMY0GVLqtL0W0bQEuLdLP6aiKTHkSGdmn01QPVsv26m9fiLz45asUkYGGhaeoHgdl2qx4sEAeUTy2w0mOxOcmAuNmh0/HjYsH34N48V9xKvDTriX6Rwk/zPRt1KI0enAwdnySOMAOMv64XfvecXdjtTLNy+1Xz70FfX5QKNDbQ8WQ+O8SO8E5t7mQPzOUUl/HhdfHEoVe0HHZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:36:22 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:36:22 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 14:36:23 +0800
Subject: [PATCH v2 5/5] mtd: spi-nor: micron-st: add comment for
 mt35xu02gcba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v2-5-8699383714b9@nxp.com>
References: <20251112-nor-v2-0-8699383714b9@nxp.com>
In-Reply-To: <20251112-nor-v2-0-8699383714b9@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762929419; l=1213;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=cKir5GY9MDPVxXpDKgg0UgEtFcz2CrFU9GyO/yNUjDE=;
 b=L4kCKnU/2O6e/kHQbMqsrHXfWq2n/pGlbh0+fg/Of/x0O88hppd3if63gnI7QMMAb5uRlb1Ue
 PMb5NL2bjQMAjhY4mmqM81ZuBShaIoJgc/Qnto5ZZLbE4uELQVJcP1f
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e84fa5-8026-48e1-162f-08de21b5cba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGRFcXNydVlkSnBORDQ5ZXp6dCt6QVZlZlQ5cnpHcUtyTWJaREl0TWhEL1dX?=
 =?utf-8?B?QW90bXZ4dm1pZEk5WG5NTmd5cm1OTmVlR0V1VDFpWDFGbnNuYURIU3QwK0Rt?=
 =?utf-8?B?dWhwZU93K2JzZkJjTTZXdklWdlRtZUdJbkNBTlQ0UnUyKytwNWJwTmtKSXFk?=
 =?utf-8?B?ekFyOFRqa0pJUmdRZ3BnbG4zNk9JYk9oRVRSbUx0ZkFGUzBjOFFLMENDYXBE?=
 =?utf-8?B?MTJaV1NkTmpMRC9EN055LzlrVjJLUWp4dzI2RGFqQnB4NjFXdDlUUlQ1bGxu?=
 =?utf-8?B?MWRxZ01jNGxDb0Z0WkFvdUNPZlhzV0NRMXpsWVFMOE90VjRiZG9MTTdnR010?=
 =?utf-8?B?NGJjdW5laTRaNDlMRW85Rkp6NTZBUFJKZTBBOGZtek5weEEwVUJMSFRxZkpM?=
 =?utf-8?B?eG5KblY0V2dSSi9WTGRKRXg5UDYzVGdDbWpZdFlhdWdDclhVOWRDc0NxN0Rv?=
 =?utf-8?B?VUo4Zm1NMTBkREV0WEdxTnBXd1JVYzh3V2ZRV0JiUGpXVXlOZTRnYThMSW1M?=
 =?utf-8?B?R2Q5aTZDZDI2NFl3eWk1eUFGc3Y1dElmREhNVXA4amxNYlQvcm1qS3RFRTM0?=
 =?utf-8?B?OTlSSXR5cVQ0bDVFWU9PaCttVTFEbEd0ZkJIb2UrVjBTd3VPeGRjNFlieCto?=
 =?utf-8?B?blA3dHNYZ0pvMXRWazBCOG9CenFIcUlSR0tTbnhTVnd1Tmp4cDFLODB0ak45?=
 =?utf-8?B?ZUZwcW9hQnhiVFdsWkg3eXJVbGdHRHl5VGx2QktsSTZDMnUwaUplUWd2aEVT?=
 =?utf-8?B?VVpCdm1NSVZnSnVlZUFwS1pVMUdlemxReUUvSFRsUGp4REMyTk42RjFseFV2?=
 =?utf-8?B?bkc5bktLMDV1ZTBQWVNKTjhFSzQ0T0RYM01IWVpyWmNtNjNoUS93NVNLZk50?=
 =?utf-8?B?NVhucUQvWjJEOG1PbllBQTZTa0wwOG90aWZDSmVKTng5bU5sRlVSNnVUUHEy?=
 =?utf-8?B?ZE1xVmhQVmZ3SmVrRllLcVJzbEo5RDBKL24wemNRckxuTkoyWFMyUlJMMGdV?=
 =?utf-8?B?dGc3WUNjMDYyRjNVVlFJbGw1cVNQV1JuQnZreE5PelZiSndzbDNRN2hWZ3dB?=
 =?utf-8?B?Q2hYUGlnU0x2RzllZUMyazUxL2lVdlJXeHJzVVB6UXp0RDFydHVVYzNxSE5q?=
 =?utf-8?B?bXkwWUdmUGVOeFJ4cWRnWUhma2lvUlF5c3c1bHRWbGpJYmdURXJPWjNsWEdw?=
 =?utf-8?B?dUU2SGxsZzFuRGgwNkI3NXYrTmVIZmRxVktPT0x1anVMdUJxT3Y1VWdhd1N4?=
 =?utf-8?B?cHhPQmVUc3RuMlNrRTJOeGNLYmVyMGZKc0g3NVRkUjk5K1o4RnZpRnhEcW9h?=
 =?utf-8?B?eG1VTTBXa1Y1RWd5MjZRcWVrVnBWdkhRRkVzcGtOYlp0dmM2aTk0V2lDM2pO?=
 =?utf-8?B?aitnOGdQTXMrV3RPOC9BNnJHc0wvWk9xaEJKQS9FN3BiTENSSXczYzAyd3dn?=
 =?utf-8?B?dlJXZk0xM3lKMFNLamt0aUIrRDY4NHg4QUFwWVlTOW1Rd2NEWlBTZjAreFhn?=
 =?utf-8?B?dlBvWU1xVEtESDh5TklDVk5mWE5tbXljalA1Y2YyaWhENG5wSkpIaFUrM0Uz?=
 =?utf-8?B?Q2ZWYUtsL3lPMGZmSHhvTFd2c1NCZ0FSc2M5bTVWV2YweUl1NjMzZ1JVb3Z3?=
 =?utf-8?B?ekFCSTFaRnhXSUlKMWVEQlNVanBaQUpOcXNmOER0VkxQVUxWak1Eckc1MlpH?=
 =?utf-8?B?ZlF3RitGWGR0WXhTNk9xczVZekR0TjNsd1J5a3hIWXhQK0NvWjd6YkR6Vjdh?=
 =?utf-8?B?dnB1WlRLTld5eWRUZFVWTE13ZmpRM05KYzNSeUJWWk9qK201aHBxVkwyaExm?=
 =?utf-8?B?YW9ReE9HVGRGOS9ranB6Z0tMVGl5WGtkNlEvRHk1Njl2aDdpTEM4d3dlYTRV?=
 =?utf-8?B?OEJnVnNacDZPamJiaFZCMUIrMTBZcTArQnhXK3pKQ1drUDVrZ3ZXRUtDaDli?=
 =?utf-8?B?QjVsVm91UnJYWVdFWVB2eW9oUTBMRnhoUzE1QlovSnN2aURuN08zUDRxQTJt?=
 =?utf-8?B?WU9LUFZrQ1ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1abE12YTJYdytiNmxiWGlibkJVdFRPc1NIeE5OYyt1SVcyaFRCVU5IYk1v?=
 =?utf-8?B?SCtHaU9MUUZPNk9ZTGZacm9EZWJQQUE4M1pQQm5HbWpHUFRneDBVV3E1QUR4?=
 =?utf-8?B?MzRJUHc4MWRaR0ZUeENCVWRuSDJyZjFvWUUycHFkZjRaOC9EcExVRi9PMDhZ?=
 =?utf-8?B?QVdRSWMrVUQrMTlCTHcraUJQNVJseXlXOC9jbm9tVWk2OGZzYlRyb0lYc1Js?=
 =?utf-8?B?R2hsd3gyd2pTVmJySnIvWEFXMGVYYUFMSFV6N1JMenFzd3JyYUJ4NklJWUp0?=
 =?utf-8?B?V3BpbVZVZk51L1RSRzhkNUF6MVJ1TG1sQmU1Z3diMXh3OEF0TXV2bitiSFk5?=
 =?utf-8?B?VTQrTGdjTVdKLzRaOVQ2RlVaZkdkOU5TR2dqTitmUmI3NGt5bThkTmJQNzht?=
 =?utf-8?B?cHJPYUhpbXlqc2pPNDJ1cTZQTG5kK1NLZWh4MTR3VERvZk0yNDY0VUhhRVRU?=
 =?utf-8?B?N3JQYWp3bUtLS0RyblNCcmJDUk5rVW1EZEhRNjNSamJMb2ZpZWUwRWJSdm1G?=
 =?utf-8?B?WWFxYXoyL0twZmJsTXVSWFErSEdtLzkrQXJIOERNTnlveEgxS0NDMUZJNEt0?=
 =?utf-8?B?UmlIMTZrem14T29MMWZoSEpldmlJcTJJV2w1eWdxeVRSY1FZTWhPVmpvdG03?=
 =?utf-8?B?VVpzSzEzNGNVRm1UeVdHMFdNZlhUTm5BKzdLZVZDV3hpQzVqSC9ISHRQNHFn?=
 =?utf-8?B?MTZ5TGFSL21Bc0lSWGhLSitTZUR6U3pjdTBiQWxBYStiaklReTdqQVRQbDJR?=
 =?utf-8?B?UDBRWGg2M2JoZDkzWG5qbmorbm93b29RTUJrZ0lhYXJyYURSN25pUXpRR3Yz?=
 =?utf-8?B?aTBySVVJTUIvSlFhT2hNRGxiOVlBeU1yd3EzUnlQYlcvejhVMm9HOTl3WkJD?=
 =?utf-8?B?WDg4dWY0SWtqVlZTdXNNQUdIcFpYZUZubDRCV3UyVERKR2lhK2s4TUlidEN6?=
 =?utf-8?B?cXk5bXl0T2FzUlpXU3BIbzV3ZjlrdUdpT1BzQVRpRmo1VU5ldWxFaWtFaHV0?=
 =?utf-8?B?OVB5K3hjamRmckhZSGlGeXpQQWZNSVpBQmNpdGMrY3dGK215UTM2M0NWa1Mz?=
 =?utf-8?B?cElqU3l1QlU2bSsrVWRMNzhLYXlNWEpPWktYYTcrcEh0WXZDRTA3VWN3Tlh1?=
 =?utf-8?B?NjV5cThoSnhaUWQzbllaTS9pRkVid3Q2RUpXWVB2aDN5TlVodVJXMkMwUDl0?=
 =?utf-8?B?Smo3NVhRdklWOHM5cmZOcnBFcmsvS1owV2tqTGNYQUZFYUxDcFpNT0FRaGFZ?=
 =?utf-8?B?NEU5eXVvL1hjOERXZVNaMXRFbGIwRUVBbGVIaXVDSkhSZjFGWWszQ05ibndH?=
 =?utf-8?B?WHNTTlBDUndnbHZsbjRiY3gxRUtwclhBUkdlYlRZSzBqT1dQcitkcHN5ZFM1?=
 =?utf-8?B?c0drRUlhbUtISG1aTGVrMWZ0NzZ1QVd1dlFFUXhVSzFkVGRBUldacmZ4elZu?=
 =?utf-8?B?V05pQnBacTdWektkN25UbUw4Y0pNd1JySHJuY1drQ0tHaEI0enFjVUEwK0NN?=
 =?utf-8?B?T09iMG1mUEVpeGF2LzRiNXRDM0NSUGIyaHQxZHlmeHZtL1BNcHYwOXJkbjRo?=
 =?utf-8?B?cTNVYVNqSWg4TW9zenBqNFhlZmwzUXdJZ3VWcFpQQ0E4MUgxQ3llUWszczRv?=
 =?utf-8?B?T1l6Q0NxN0s1dk5YUnRMWi9CQnBvSVZ6V1AzUS85NnFkdE5DcFhqNjY3U09X?=
 =?utf-8?B?YzhEcXBiMnVhUzU5Sk9UeXZyc2VXQWt3amIwUThBdVRkbjB5YmNXSnVPQWlM?=
 =?utf-8?B?K1RraGdiblRiY25TdGRuNDFSdWg4ck0vY2pqdkFUQkJIR21PV05mZU8veGFH?=
 =?utf-8?B?cG5pZktUeEtxVlZUU0lYSzBoNWIxRkxBVkpjY3d5TWkxNC84U0xqak5tSVRU?=
 =?utf-8?B?Q1BEdlB6ZzNqazJzaTJQelBwOGJiVHg4aXpoUnBXc1dBaW9BT2MyME9yNFNO?=
 =?utf-8?B?ZkhlSHE0NlZvb0ZpZnlHMGhCb0FESkxrRjVvK2JOUEFGUEtRa1FPWFZoQlBx?=
 =?utf-8?B?YXZkeFpKb09QSWRQVHkwc2RnL0R4cHRmR3NiR0ZMK29TL3NrT29TYUVRMTAy?=
 =?utf-8?B?cjZqdjMreFhQWExaZU5talZUTHFqVzMvRjZDZVN6Zis3OHB0NTZoeTJvVEdk?=
 =?utf-8?Q?t4JgZECH13PkyBa+M2hmbNLAB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e84fa5-8026-48e1-162f-08de21b5cba7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:36:22.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtvGdD2TVkiK1qdicddT78Deoyd7PzQFmF6Eaumdv23MIL9SHMiy6pmkXMenJprcCXd0cIOIAi1zWIKNsJCjMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

mt35xu02gcba is similar with mt35xu01gbba, but with four
dies inside. According to datasheet, it contain SFDP and
support 8D-8D-8D mode. Add comments here, remider to change
the code in future if has a chance to test on this chip.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 6d081ec176c37249e5ddb724b61bd70f68088163..cc053b4d615ade3f12068618f8355779561dce55 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -206,6 +206,12 @@ static const struct flash_info micron_nor_parts[] = {
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu01gbba_fixups,
 	}, {
+		/*
+		 * MT35XU02GCBA contain SFDP, so no need the size
+		 * and no_sfdp_flags here, should similar with
+		 * MT35XU01GBBA, but with 4 dies. If someone can
+		 * test on this chip, can change accordingly.
+		 */
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",
 		.sector_size = SZ_128K,

-- 
2.34.1


