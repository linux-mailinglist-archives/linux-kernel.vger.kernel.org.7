Return-Path: <linux-kernel+bounces-872560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEEC1174B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CE43B89B7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CE323403;
	Mon, 27 Oct 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UACzq5jX"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191931C580
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598686; cv=fail; b=a0CBtNdE7b1P++T4sqYLpvJJEYSUAllYBs/2RnNiPEJ+kKeBGDMscqbUel7wUQ84BS9MKwBt3EpYKKFtEMbs3FhxYiXq5x6ettIC6OYw7fFhXtorsza8Ulne2aIL35YWDGM3KzglwKV2+CpLkBlqbGCWcq2CEz7jqHqFWvDkCxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598686; c=relaxed/simple;
	bh=8dc/DgM9jdwITbPfyBTwZfAhvAUJ3KIbjhSLisxWY8Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RkYmuhFYpBFCwqQLPT1tnuwh0hb2KZAThorFRkOANbGo5jzj2JC1sXh+0Q6pa4+y/lQcXBSEN7G6mvO4vvoIKA3M4L6KAKkJTC7UUEPsHPyygZRnRX5LE3qZH8arEXipoEqy2j2VHkGJEWtcTe3x2wqNexQgoEeIwKkhwTOYYrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UACzq5jX; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIWVkO+s7eq45HsB1gJZuBIT9hPKl5B79MnGLkQuGy1sMEAWxNPNsqGEdXPlQgYhkm9cc92J97pNRlAwQYOo0fHR4Y5sfznLnbUQL3DUYZi8dbyUf9RTKG/DkY2YaWC/NdNjYD2E+IVFjWGidpxh3CNOpit04CDvDIfG+8gSVCyqtW3T+rchQzDFEwaW5+YYt/CBMjjlaxjHCYbrNgRgMAAR1dXv4fFgeS42LyM6joiLRw8vm6zgxI5eifRVUVKDfz/KEiWT2Ya3vRBsb4YJerX1vwtfWhHe+t+6wtUqKFe0uym+CpEIkKX8t67kM9Q4St7jN0jJ8N7ngepoUo2Taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os9SZ3OMaZaj/7SgQgMWJ2HKdnArCiZ1riBMZOCT3NM=;
 b=IdLlZU2UegLRirhO/bSPZTIwa/s44Sja0FlDU5LRGv2dxpTYFErS10YoLdAU+dK6jLRz4juzqYI5FlH0BrIr66Nb/KAELw/u8RpHOHym+TfNqSZmAljSNMq+SMNHTUHiRX3iZ3m7QqOigyaVZe8Xk2GYpzfPQb8wTcEuAX+eTajsMF96xmUFbHgCBDMUX655TdwloFaOc6v4sH/0AEpV7ozwu5L96jTRRn9sCilkp9YWEUalNvZJW+D0XlcRuMgnaXzBlCjQ2tmTKPJKNSsRDzLfKry3anJw0fjHNcCDKy4mZKCEm27ij6Z/1MbXYMXHCXbVEK6+1Si/9ybcucfhtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=os9SZ3OMaZaj/7SgQgMWJ2HKdnArCiZ1riBMZOCT3NM=;
 b=UACzq5jXvvhvwiW5eit4iN/EwLiRFHC0zNcPekcyh/ZxhI7qLFuAyLVBMX9WHMRytBpsnxcu2a8waT9JLSpsqqDP2lwYstMfRsd+rbzPncbLHsih+79IerXn/OrgDIlFqAGZvQHWAOSGQhgOjsRbiFMHmvjqbxy0wtxn1dzWl24hVOHMAJ9y9y6cfCVSfggldq0vBcqCJqmdcqNlf57sUbH2UmygPD47z9nL/L1k4fU8KMW8pl8wi4EWX72XwrLp5avo6+aMl9cGzSzDJ/UbOh+AmHZfoUE7C5LtXHGBKKtZo449QFE1An5VtDLpxHrJl66WKPEkWYSgun6kJhkXlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB8577.eurprd04.prod.outlook.com (2603:10a6:20b:424::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 20:57:59 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:57:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 27 Oct 2025 16:57:39 -0400
Subject: [PATCH 1/2] i3c: master: switch to use new callback .i3c_xfers()
 from .priv_xfers()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-i3c_xfer_cleanup_master-v1-1-e9bfcb083a38@nxp.com>
References: <20251027-i3c_xfer_cleanup_master-v1-0-e9bfcb083a38@nxp.com>
In-Reply-To: <20251027-i3c_xfer_cleanup_master-v1-0-e9bfcb083a38@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 =?utf-8?q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761598674; l=6714;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8dc/DgM9jdwITbPfyBTwZfAhvAUJ3KIbjhSLisxWY8Y=;
 b=zhlECactro3b2jTNAY1G2gpwS/ebOuiyuhqTcKpGFsHc+aHlsMiwFlh7K2T2HnERcp9vXvluQ
 xH5uompsthMAPfw3VRUFgjtRyHkd6MY0o92/UD8WM3cpJnF56b8qAIj
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: b03067af-ce18-48ba-584c-08de159b8271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWsvRWRoS3RoV01tdnF2LzBHNktueGY5bmgwSlJsdng2YVVHVkJqQy9kblh2?=
 =?utf-8?B?MGJkTm1vQ3hvUm9DVEUrNW4raUc2dGtpVnN5UGljT2xxb00xRDFGQlp3TTN4?=
 =?utf-8?B?RkxqSHBNU0Qxd2FReUtjbFpXRE9BT0d2Tk02MGhCSVJ0RzQ3enZRY0hiSmNF?=
 =?utf-8?B?ekovMHhtemhwZmhQYVBZdzJGVUE4RXNDUmVwUEZNM1lRdFdrd3Vvb29mbkpE?=
 =?utf-8?B?N3QrVVlyZkJNeGk2TUV0UDZzbmF3RHRodWNKYnM2NFQ3RFVzRWY1TlEvR3FV?=
 =?utf-8?B?cE9nZGthTXd0WHFRS2M1bGUzVFc2YnErT1F2OTVYS0tKV2lQOUdrb1lJcitT?=
 =?utf-8?B?RmdzZWdJY2lYT3F2eU92MUN5d0o3c2xnT25oNWFHSmpzc3BncWRKcGZ0Ynp5?=
 =?utf-8?B?MmxtNmg0ejljZ0t6Z1Y5N2FXaWxEdDRxeGhxV3FtUElJekRoYWFBT05VYjU5?=
 =?utf-8?B?THBLQlNNVWJzRVhxVXFxMDJMNXR5NUVMRzlGY1JXLzRwSXhWY016eU85OHhm?=
 =?utf-8?B?RjJ2S0hFMkFrMG0weHFXK3VvSDllUGQ3cTI1MjNkRU8rTDg0Vks2ckhtYXc0?=
 =?utf-8?B?MklMb3lEazN2K2FJTHlSOW1xQzcxUnJEczh4Y1orUS8zZmhndzRaTXM1aGxS?=
 =?utf-8?B?NHZ4aitRaTM2OUZ2U3FHbGlYMHEvUEhIVE9EdEdibHlzcS85M3VDcUtFV3N0?=
 =?utf-8?B?MUw3WCtTUEMxTlFJZ2lrSVJhRmRST3ZtRzJsaTBYWENxU1dXcGZ3RFczVE1L?=
 =?utf-8?B?dEhVd05zY1VPeFJ3dFBzVFBra1JrdkNhLzlLMklyekxOTkh0amJobzNsQXZk?=
 =?utf-8?B?QzBWdTk0V29XOHBvU29oVVBnNXl1OGtFdnJpRUo0SVFiSEFtQTY5YkZ5SDNt?=
 =?utf-8?B?VEt1SWcrMGxtRGhnRnlBckZaMmFOa2g4RWc2cEpnajNnVm9XeXYwRlA2bkNN?=
 =?utf-8?B?aUsxUE5nR1ZSWlViUmZKT1Y4b2JpM1I0VUgvdzNBOVE2ZXFDbTh5S2lWUUg0?=
 =?utf-8?B?eVJTTG05QkgrQ0JNVG1Kekp0YnVuS2p0RGpYMGtjMjkybUpDRlhiK3hDS0Nm?=
 =?utf-8?B?Z0lCWU9Qd3c3WlNlSG5DbmV0WWlxMkN1d3l0UWxvMVJiZHBxYVhiV2VZUVNl?=
 =?utf-8?B?bE5xUUxNTnFyUzJhWDNBYjZKcW04MlFXK0ZiQVRScHE0MFpXemdtTjZMTzNO?=
 =?utf-8?B?T1M2Q2RlMmExNGRqNCt2WERPcDRHa0FNR0cxUzcyRjBKLzNtVEJHNFJETFJE?=
 =?utf-8?B?aktjeGpkRlN0Zk5MQW41TTFJV09teXlDU3NMdzYwR3cvalJQUVlEUHB1QlJt?=
 =?utf-8?B?RkV4eHhRbFQza3BzY1NJTjdwVkdzaWJabitJTDBtbnlVcFlXU2M0RERMQlVZ?=
 =?utf-8?B?TmY1NWI4VGtTNVFQOFBMOFdidG1obWRZU1ZXZUZydXB2cURJbTJIRnAxditY?=
 =?utf-8?B?bWQwWUdsK1BUVmFJWW5HaXVSbkFKaHNSR1ByK1RrNElpbGoyL0tRdDdCdGNr?=
 =?utf-8?B?Ym9qUFFvK2k0ZDBDdmI2M3VMRjNsbHQ3ZkFOaHJJY2dwMUV1SXBQRzdiVVI4?=
 =?utf-8?B?ZU5zWGZRcS9GTDdmem92MUl3eDJTTDVSSTh3UFpmejhIZUZPclVCMGhwQXQz?=
 =?utf-8?B?T2R6OGJIdWRySXZ5d1JseVJkcDhIUVRoY3l0SHlaRHloYU5OUUtzcmJvZUtv?=
 =?utf-8?B?UU1ZOTJpdmpqaG5SeGJMRjNyS1c0QW5FdjhNMWwrUFVKUHZ0bjJaUkNyZ2pT?=
 =?utf-8?B?c2tqakF5SHhiOThGQjNDbmlrMmduRlc0dDNtbnlQUlFQdzFpa0JQcmtHREM5?=
 =?utf-8?B?d3hkRGkvVHQvbGxVNTBxNFNwK3hkcXFLVzQrR2lVNW84Ry9salF2cHU3S3FE?=
 =?utf-8?B?cGxLT1ZMSmpJTGNMKzJwS1JScHdtRWROZWtHZnY2RVBoblVXak02RjROWTFS?=
 =?utf-8?B?RW9iOXJNZlduZW1pZVRWR0ptZmtRbE82NVZNNmpHRE1ZSnZiR0RMOWlocE4y?=
 =?utf-8?B?OFZBSGF1SGIwNjg2L3FVZmhMRjhtdmUwMEhlRTdtQWNoQjlWcktaSVY5aDZY?=
 =?utf-8?Q?Pp2DMf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bllla3FrcmdiaUptWGNZb20zc3V5OUVnRXYxcmhEeWhLMWp1WmQ3bjdMcGtO?=
 =?utf-8?B?RkNsVnJrNjU0Mmo2T2szeCtXSkJLa2RKbDEwT2F3TzhoelkyM3B0TEdrS25D?=
 =?utf-8?B?ZG9KL1ZGWTNpVTVwVHZQVU5CYm5kc3BvOGlnOTBPK2RPeGdZK2ZNc05QcHM2?=
 =?utf-8?B?SGt1ampYdjJJWVU5K1hnZ0hvOHgyMG1EOW40R1pHUFhsbng4WFZQSnM2SGJQ?=
 =?utf-8?B?Zm9jcGdOUkJtck5ZTVpibWNWVkNkVEJXZWdCOXZNcmtoRi9EMVpYVVQrbzJt?=
 =?utf-8?B?WFhUeVZzV3FTY04yZDNzLzMwcENSR2ZMWFY2emQ2eHlIa0EzOXpteDVrZURy?=
 =?utf-8?B?UTJ3RXE5UCtzMEZ4WlVnYXN3alliZm9LQUhGdzVlUkJZR2FoRzBCVDNEUlJX?=
 =?utf-8?B?R0xjdUQ4eE5PTTdycWw0SlhTYlRJazRrQTVYUXI5QUJsUHVaN2lBb1M0Y3Vi?=
 =?utf-8?B?c2hKeS9wMTNwZVZ6WXRnYWtYMlVQQWZrYVZYeWR5TVgybXVoa0pYeEdGN3VI?=
 =?utf-8?B?M2ZZaVM3b0VLc0xDOHhnSXRvbjJOYTJuV2VnUW56d1FTNFhkZjFiamo5OG9Y?=
 =?utf-8?B?aXdTTG9KMmtkcDFMeVFZY0RzcDlNRnRaZGpJbU1wUWtNa0xaQ0hmMUlGTEs0?=
 =?utf-8?B?cy9tOEorNmFkTlZyNmRMY3JnY1FzL0IxSVBxZmIvQzZVNFdqS1ZIdlhxNENI?=
 =?utf-8?B?SHRxa1piNVorVC9RcEg2TG1jcHMyZ2xEb1o4WG04NXhpSlBybVJhMmF6L01o?=
 =?utf-8?B?TzZabEluSEhkc1RIZzc4TktQMWlDTmhzTkRlZkFPV1Z2MFN2dDRZSjY4azBu?=
 =?utf-8?B?cWxlckJvcmtCRlZVREc5akh4bXYyZjNOMmIrNCt4ei9yazFzeVhCU21pQk51?=
 =?utf-8?B?S0o4ZHpLWlZWaTlReW9WWVBIV1BmN1czWVpoR0p4eGFRK2YrSFVJZHRvWEI3?=
 =?utf-8?B?c1h3eDViVWRRSWhUSWFlc2RaN3hiRm94M2xLYkdTZzJoL24xS0pLRWhKb1BI?=
 =?utf-8?B?cWhyQkNFU21uaHduMUczWkJEQ0ljclhMdk5lUE5BczZQbVdhVmZyZ1p3ZUZl?=
 =?utf-8?B?VUpxenI1WnpOU1hXRllLaFFLRzZ0bUJzSWZKTUd3K3grRE9zRWIwU0N3TGx2?=
 =?utf-8?B?d0szU3h0N1hTL3FRM1NLa3pZM1lqeEJVSFZCTnZIK0FsYnVhdXdGRWxCOTlI?=
 =?utf-8?B?cEMzdTVnZk5xbW5XL1VGRTREc29idEtCdnNqazBnSmJzUExEQU1JMVpOeDJU?=
 =?utf-8?B?YTRiZEpyT05PenIvK3lWVlhDRzBjWDQ5djlKSDA4NEU5UU1IMUZrc0JyL284?=
 =?utf-8?B?djBPT2RFellhbjgzT3hPZ1NxVUFUekN6TmhFdjVRVXpyUnU1SUxnQ2RzT0Rp?=
 =?utf-8?B?eWE0TWFiV0ZITFRhSjMyTzMrMTVqZ2RFT3kzMjNXWVVmd0Z4SjRMTWhmeG9Q?=
 =?utf-8?B?RWRsRTIxZHlMaWNDRjc1UndOOHpMcG5MQzdFTGRPL3l1YjBaMzI5WUNvVmZv?=
 =?utf-8?B?STdxSUhHL2txRm42eDlHeFNFWGVTTm4zYTdsWDJ4U0tyY1U3S0tJOU9vWEJq?=
 =?utf-8?B?elRRU0UrZy9GVi9IazllUWhqaVBSRzlUWVF2MGMxMDUyb3o4cU1uamJtWFBF?=
 =?utf-8?B?V05NY1IrQXFqOW10WVRZSHl4NWErTzRySlkzWlJGTFhVMVdTUkhDeWg5T3RZ?=
 =?utf-8?B?eUxhSVE1dHBTRXlMT203dFdkTEdlcjV3VTN1UXRIdnRNb1BlZHoxQ3ZJVFZB?=
 =?utf-8?B?bFUzTmFpd05CSDVoY1Y1R3Iwd2IvTFpIeXpiOUNYVDVBaXpoSjN6eVZaTzlL?=
 =?utf-8?B?TXZIMVQ5cTRvTCtFRFhYN0c1Q0Vzc0hOdGIwVFRpTVVYNWNXTzNFZjBtcmZi?=
 =?utf-8?B?M1ZMcEplUnZiUDFqWVNWTDBrcDNNVGdyblNPWnRCbDYrS3QvWGNaK0hFRjIr?=
 =?utf-8?B?SWNadkZ1NW9FQm1kQWtIdi9lMmtSY25TYVVIK0dvMmo0NUhpQU1Fd2FPbGNs?=
 =?utf-8?B?dFpPVXBZVE9UNjFVL1R6YzZwZUxLOE9zUCt2U1c0blk5Ni9xQWI4SW1Jdm0x?=
 =?utf-8?B?V1I2djhYWHNYSjBmOXlzeEpORWJUeld6VXd2cjdUNEZQTlVhY0lxRTBxQWJC?=
 =?utf-8?Q?OwoSvFQ7yEEKleGb8c0E9w8ap?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03067af-ce18-48ba-584c-08de159b8271
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:57:58.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T/lnOux8ygPcoyp8TKTr5Pc/WXpjtAarHkiAirQ09/Dj1m9u3qnYQbp61e8mH9gJNtSX9th+j5Q8c7eInPR/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8577

Switch to use the new .i3c_xfers() callback, which supports all I3C
transfer modes (SDR and HDR). Also replace struct i3c_priv_xfer with the
new struct i3c_xfer, as i3c_priv_xfer is now an alias of i3c_xfer.

No functional changes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/adi-i3c-master.c    | 8 ++++----
 drivers/i3c/master/dw-i3c-master.c     | 8 ++++----
 drivers/i3c/master/i3c-master-cdns.c   | 8 ++++----
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++----
 drivers/i3c/master/renesas-i3c.c       | 6 +++---
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
index 82ac0b3d057abddc78671ce973db12f528984ea1..00eb80e492afc736046f04fa454be16bb718004a 100644
--- a/drivers/i3c/master/adi-i3c-master.c
+++ b/drivers/i3c/master/adi-i3c-master.c
@@ -365,9 +365,9 @@ static int adi_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return 0;
 }
 
-static int adi_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				     struct i3c_priv_xfer *xfers,
-				     int nxfers)
+static int adi_i3c_master_i3c_xfers(struct i3c_dev_desc *dev,
+				    struct i3c_xfer *xfers,
+				    int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct adi_i3c_master *master = to_adi_i3c_master(m);
@@ -919,7 +919,7 @@ static const struct i3c_master_controller_ops adi_i3c_master_ops = {
 	.do_daa = adi_i3c_master_do_daa,
 	.supports_ccc_cmd = adi_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = adi_i3c_master_send_ccc_cmd,
-	.priv_xfers = adi_i3c_master_priv_xfers,
+	.i3c_xfers = adi_i3c_master_i3c_xfers,
 	.i2c_xfers = adi_i3c_master_i2c_xfers,
 	.request_ibi = adi_i3c_master_request_ibi,
 	.enable_ibi = adi_i3c_master_enable_ibi,
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 9ceedf09c3b6a6e75063ae09a22854f6f3151a3f..b07452a150cfe4c461aac471c3bd6970a681ecc1 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -897,9 +897,9 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	return ret;
 }
 
-static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				    struct i3c_priv_xfer *i3c_xfers,
-				    int i3c_nxfers)
+static int dw_i3c_master_i3c_xfers(struct i3c_dev_desc *dev,
+				   struct i3c_xfer *i3c_xfers,
+				   int i3c_nxfers, enum i3c_xfer_mode mode)
 {
 	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
@@ -1493,7 +1493,7 @@ static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.do_daa = dw_i3c_master_daa,
 	.supports_ccc_cmd = dw_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = dw_i3c_master_send_ccc_cmd,
-	.priv_xfers = dw_i3c_master_priv_xfers,
+	.i3c_xfers = dw_i3c_master_i3c_xfers,
 	.attach_i2c_dev = dw_i3c_master_attach_i2c_dev,
 	.detach_i2c_dev = dw_i3c_master_detach_i2c_dev,
 	.i2c_xfers = dw_i3c_master_i2c_xfers,
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 97b151564d3d31092975cec14958a17ddcd91d13..8eb76b8ca2b00a46a65f3a6dc7416d8af7ca288d 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -720,9 +720,9 @@ static int cdns_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-				      struct i3c_priv_xfer *xfers,
-				      int nxfers)
+static int cdns_i3c_master_i3c_xfers(struct i3c_dev_desc *dev,
+				     struct i3c_xfer *xfers,
+				     int nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
@@ -1519,7 +1519,7 @@ static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.detach_i2c_dev = cdns_i3c_master_detach_i2c_dev,
 	.supports_ccc_cmd = cdns_i3c_master_supports_ccc_cmd,
 	.send_ccc_cmd = cdns_i3c_master_send_ccc_cmd,
-	.priv_xfers = cdns_i3c_master_priv_xfers,
+	.i3c_xfers = cdns_i3c_master_i3c_xfers,
 	.i2c_xfers = cdns_i3c_master_i2c_xfers,
 	.enable_ibi = cdns_i3c_master_enable_ibi,
 	.disable_ibi = cdns_i3c_master_disable_ibi,
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 47e42cb4dbe71edc5a022f4cb0fdf33a281eb4a7..607d77ab0e54691705845c33a79939820a83c9f0 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -266,9 +266,9 @@ static int i3c_hci_daa(struct i3c_master_controller *m)
 	return hci->cmd->perform_daa(hci);
 }
 
-static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
-			      struct i3c_priv_xfer *i3c_xfers,
-			      int nxfers)
+static int i3c_hci_i3c_xfers(struct i3c_dev_desc *dev,
+			     struct i3c_xfer *i3c_xfers, int nxfers,
+			     enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct i3c_hci *hci = to_i3c_hci(m);
@@ -515,7 +515,7 @@ static const struct i3c_master_controller_ops i3c_hci_ops = {
 	.bus_cleanup		= i3c_hci_bus_cleanup,
 	.do_daa			= i3c_hci_daa,
 	.send_ccc_cmd		= i3c_hci_send_ccc_cmd,
-	.priv_xfers		= i3c_hci_priv_xfers,
+	.i3c_xfers		= i3c_hci_i3c_xfers,
 	.i2c_xfers		= i3c_hci_i2c_xfers,
 	.attach_i3c_dev		= i3c_hci_attach_i3c_dev,
 	.reattach_i3c_dev	= i3c_hci_reattach_i3c_dev,
diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 275f7b9242886ee77a647149a808e2f184fb0447..426a418f29b61256fbbfc50cf578bf04629ec391 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -794,8 +794,8 @@ static int renesas_i3c_send_ccc_cmd(struct i3c_master_controller *m,
 	return ret;
 }
 
-static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
-					 int i3c_nxfers)
+static int renesas_i3c_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_xfer *i3c_xfers,
+				 int i3c_nxfers, enum i3c_xfer_mode mode)
 {
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
@@ -1282,7 +1282,7 @@ static const struct i3c_master_controller_ops renesas_i3c_ops = {
 	.do_daa = renesas_i3c_daa,
 	.supports_ccc_cmd = renesas_i3c_supports_ccc_cmd,
 	.send_ccc_cmd = renesas_i3c_send_ccc_cmd,
-	.priv_xfers = renesas_i3c_priv_xfers,
+	.i3c_xfers = renesas_i3c_i3c_xfers,
 	.attach_i2c_dev = renesas_i3c_attach_i2c_dev,
 	.detach_i2c_dev = renesas_i3c_detach_i2c_dev,
 	.i2c_xfers = renesas_i3c_i2c_xfers,

-- 
2.34.1


