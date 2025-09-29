Return-Path: <linux-kernel+bounces-836385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C52ABA98C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557613AD8A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB4309DD2;
	Mon, 29 Sep 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RZQ1ipg/"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8030B53D;
	Mon, 29 Sep 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155889; cv=fail; b=INmTv7NtTktbNXzRt6Z0R3S04AqfFxFi7lRQjWDd5dIIRLcaMq9wc7p7GIhfOjPl8VVPfXGyEjwtTRj1jXjmB6cuRsIUgCnwOY5IV9MAPjwlH5Tg35bPEhqSZXrpE45MBh2GvMPqKl8YSUL19ITUaTliQUsynfO1RHZ60Kgsldo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155889; c=relaxed/simple;
	bh=3lvyIi6EPuFI5jSKT6nJyBbhpNULKOOS4uIt6qtJysI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FQCM1k3f6yHph10QIgGJYCbBOuWExzFDT364t2tRYK/j6xNslVvPN2CNoCPTI43YnIIpExX4wCkSCc2MzcLrzGMYchhWUBucngZvSlf5IHcmaTExHtMZa69VAL0bZmshXzQOpbzfkQETrAZr1rRUJUH7kRlRnKNU240Y45dhWL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RZQ1ipg/; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9D8INc2Xu1xYpDBIYTMb1nuTakt3FfMY/BcUZyo1T08AI3+spVfB3dD9Zj+pd+JhjIKg4s6Y+6Qgr5qk5pWJtuLdSKG8bW1mvtTbBkLviUci0hZjqhxZMaa1dyhsIM7rU0YVTja4jApsYU6sY2Dbmw2AzUJ66lkzvr4HRzbyh/2LhHuhNadx0Pf88jpfr8N4UaNp8Z9VhsB6qoaEeJsS8tUHmTIm5H27KPaYJXs7eW1Zsrv0lRafOQyDZFygKIqPVe/8LlTT7bAvUfMQ0nhRCMZ6oqMu8yxwjV98syOaKSVrNTD6a1GpQ8+d/hJKxW8vXpqZ8bF49sP4USU+Q/pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVJl4bB8QiGoef0MB55ljZ5MSBlUEiekfe3RurAVcac=;
 b=O8bGmsu/lTf5E/BdCyslJASvTysv6T59H9CkKKQMDUeXVfCW7/WvuUIYdDt8/a0/oaO+NNaEmnU9xkbmPOhAwtoaFNjLMsqyXBhlZQyV8p+uajTWhKzBHldKQEN73M69eQlzgZQPbzz9kfL/bPQfYJ6MEBxQWwGr5bVwYX9UJYBUpStDhkM1ktuPRzyIoEF3pXJWbJOql3AqtZvVrUIzPndsK70rwAmZ+lyWc9h8JsRPB0Bzmhez/fWFqopXnZnl6XTCP6tLj7banEHNbt4jbvtxf5fGEeXQik6pS70nicrd5UBW5jP2ZN6na6planeX/PBD5IggPWBDGmOn3MgJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVJl4bB8QiGoef0MB55ljZ5MSBlUEiekfe3RurAVcac=;
 b=RZQ1ipg//d2kUeQeT+H6vMwzxmlRFsaX0JGxfJ5//Xkdt7vGVNcr5m8N3L3/C9ui9TdIgDx3sLI8uUxdtTGawzKDE4jGHMzGdR6Dx8XhQBHXg3mvF3kuAEKxqRXW1YJlmbEAZ9kN3LMiWhRJugiXj8nAYtrWEgo73nRmQpTva8VDZahC3hILobuv/5rC9KKhgys+Ms60bHaHLVOFXZlMEKVP4u8dLXkYyllTI8wKB2JKGjdlNc4G0mSwn3uyV/tzLKz1wAM7Mkny1YT2HQw2tL9jnBzWj7dHdxyTo9RUVK03T79INjTnsWsZUmms8/9jUGR83GIxFTGoShFu09Zc0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:24:44 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 14:24:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Sep 2025 10:24:17 -0400
Subject: [PATCH v5 4/4] arm64: dts: layerscape: add dma-coherent for usb
 node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
In-Reply-To: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155863; l=8726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3lvyIi6EPuFI5jSKT6nJyBbhpNULKOOS4uIt6qtJysI=;
 b=C9ZbLT8rfFK6Boq6s+MDumbV7G/EmJlEJv8zmKodKqQHlAgvUPaNRY7qnHzFnoiwi8gm+b9tg
 SOaTVrlgeD1BUJF+YX4KfwZOND9+xOQZ29r9NVIKScDXMO2T7bmJqRg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd41e99-3cdb-42e8-ff11-08ddff63ef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFJjYmRtMzg1ZmxZa2djK0FNa056ZUllVEc5YU9udVRYSHpYVi84S3FYMVYz?=
 =?utf-8?B?M04zejFnNGdiaUFlbS9odnJnNldZVGJxbU9PVStiVmdPeTVTaTdGNTRNT3RF?=
 =?utf-8?B?aEIwcVlwejJ0NzhJbnFiWU1WTVhKYWZwUmhMZW5PdnMxTGduYjZSeXVBYWFR?=
 =?utf-8?B?WXl2cHc4SWNsMFN3bHNISjBPZ09NVUhIM05sR0NPNncrRkowa2dvKy9HTnI4?=
 =?utf-8?B?bnprRm5LOWJ6S1dXMHdmME1CODFXMDRtcnZOOU5xa2dzMk9nNTlGRmx3L0tw?=
 =?utf-8?B?d05pK096bU1mUno2a2N1alRJTGhrU0NiWFA1MXZOQXZqNWxPTTdrNHFkbzVQ?=
 =?utf-8?B?NHZrd0o5Rmg0L3d4WGhLdXdtck8xMlpUQko3YkpIZS9jcSs4VnI1a3lQN0NL?=
 =?utf-8?B?VDZDNldrTlF2bVN4dG1GY0gwV1FzK25FWEl5YVNvY25ja2QvakY2R3RqcEp4?=
 =?utf-8?B?cFBmRUNuWE9acnNzc2ZOMzgrajZRMy9IcWdvQWRGd2QyUkkvdURteVFmVmpn?=
 =?utf-8?B?SW1GSzVuTmtGQWgvS3ZVRXdQRXpRSzBMb0lkMVNKTVdBdlcyQUIySWhMVkdY?=
 =?utf-8?B?NGJTbFNzaytSOWJMVWZVczVUeGl3WmtPdmcrdDY1NWV2U0ZmZ3htcXFERUZ3?=
 =?utf-8?B?V0d0Z1BLOXkvMmY3Y2pkaFhkNWIwSzBjckQreFJFZmxFQUlONEFvWHNkSmtn?=
 =?utf-8?B?bHdmMDdwZkp1MVVyTjdydmdLOWhUYnZkWE80NFJWR1lnWWJqNE5BejRkRDRD?=
 =?utf-8?B?TGU4RXk0L0JveENCLzdtU0VtMTVNY1hHd2haTHY3ZlR5MXlnOVFXZ2hSekR5?=
 =?utf-8?B?YXZ6UmNmOUtmaHlXbC8zTFlaallCNlFtV25BZG9mSDlkamxXd0NGSjNUMXBr?=
 =?utf-8?B?emE4NUl3V1hlUFhPMzNONU03WkFaWnhBUEtpbGNuNEkxRFlFN1dsRGRiT0hW?=
 =?utf-8?B?dnJEYlBBM2F2NDkwejM2bVpZaGptNmhaUUQ3MjBjM2RrbENqRjRDZmJnNzR5?=
 =?utf-8?B?UDNpYllISHlnTFVLVWlvZHBacitZU1FpMWJYWkZ2WGdRdUw5cGFiK1pFdFQ1?=
 =?utf-8?B?RUNZTlUwY1dJWnhDMG0xaVhWVmRBR3ZyOFpTVzkxdU5Ca1F1cE1oSDJIdFBT?=
 =?utf-8?B?MW5BYnZFbGQ4WTFnVEprc3BrZVF1UTQ3RngwaWo1cU85NmxLaHBWM2t3SGZW?=
 =?utf-8?B?bjQwRnhwdFlpQUNtMTY1UzlCckVRamtEak5KYVJTZThiVDcxeXVRdDBPS2k4?=
 =?utf-8?B?cjN3cTEzcEo0VHMwS3RBUDIxQmlrWGpVZlhCQlRYNGo4RXhtSFYySXNVREo0?=
 =?utf-8?B?T3ZFcEdrM01xbUtxaUVzR2JGVDRORWIrUUJhZm4vZnZEY3JacVgyOG1nTm5r?=
 =?utf-8?B?Mm1YUTg3aC9jSDlzbHJvVVdYN1gwRGg4SzIvK3F0TllrZlpZQ1BUQzlLeDN1?=
 =?utf-8?B?dzFSTEx6NGYyeHZFWExvVFpKWTdDeTQxekUxZEJHRVBaVVZBRHdEY211aGta?=
 =?utf-8?B?QVJyL2RVajVKQTVRN2tGUW5haFJITmV3NGIrVWRMRFNibkM1ZlVHcXpNU3Rw?=
 =?utf-8?B?QnkwSnhsalFreU1nMUNLZ1NxNS9JRExENmpTcDVDMThzaUpzYS83VFQzS202?=
 =?utf-8?B?WXRDTVZaNVJxVlVxL0U0RVpIZFJUUGc0YjdLeTJBTG9jRHhJQ1ZuSm5vQU8w?=
 =?utf-8?B?SjcwRTcxbEVNTXJJRGZNc2V3dmpRYlVFdE9VMy9jcXVPSm43Q2VCUFE2NWx5?=
 =?utf-8?B?aXJXRnZ0bnhjZk9ub3gyVUFxVzNQbWxZS3d6a0h4cThPWHJrUm9BY2ZoNW9h?=
 =?utf-8?B?VW9ZODV0S2NjRkE1U1BpNXFQK3V3cE9kNVJ2ZkZQdDN2WThzRlI0WHRwN0pE?=
 =?utf-8?B?NzNZWmtLNEZ2ZXc5dTRyUllkc1lqTDY5L1NOR3NNREo2ZVoyWEltaTBQNmJw?=
 =?utf-8?B?WU9kSEgzdWhSeWFzQTdDaDU4eUtCSDVlZWV1d2pKaGlZeG1ob2ZrSk54ZGd0?=
 =?utf-8?B?d0VBaWkrOThCZ3Y3RERhNS85bE5LRDdORWpUU1RKNDhkV2t0TE9lbTVzcmY1?=
 =?utf-8?Q?P+vuvZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RC9HU1QvaHVDc1A4emNvdWhJOTExU3g5amE5TUJ2N3ppTkYyMkhDcnYxQkQ4?=
 =?utf-8?B?SnRTYm5jNkJXbGk2d0Z1M3lHeHpYYmJJckl5ZGI5NnNIMVhpeEYwamtvZEpN?=
 =?utf-8?B?YytCU2RKb3Zyd3dFc1lKd0FVaHVuMVNUTC9EbkFZNTl6Um9BU084ejJNK3RB?=
 =?utf-8?B?cEd0ZlhmN0MwOEE4eDNaM241eHVwZ0g0SHhxaDV0dzIxNFd3RTNiQW9qUTVY?=
 =?utf-8?B?UHpYc2l6ZDZ5T2JHQ2w1cHVKWVVGQ3Q0THV5N25IbkR3RHhZVDhkWVJ4Umti?=
 =?utf-8?B?ODM3eFZoMlJESElRRmkxSGw1VytIL0YvVVpsdVUwVkl3RjducGQ4M3E4blRZ?=
 =?utf-8?B?NUhUTkl3eDFnNXIwaTRtYlVhbi9vempvZ0o1S1NsZHhabWFmRmN3QS95ZWtH?=
 =?utf-8?B?c2MrZGlBWnJtOTQ5U0JIazJjNWg4WmJyaGY4WmNQWUdBWWtpVU15S2lZRG0w?=
 =?utf-8?B?QTZEeXA5di9IM3dmRVVwc0J1TXpPZFYrNFI5MGowRXVUVTJPdys2N2JJNnJs?=
 =?utf-8?B?WGU3d0V6ZDZhNm4rU0NKRDJJT1Y4MGpQWVllczQ5cldsbFB1dUtHVVhJY1lu?=
 =?utf-8?B?Z1JQNDdMUmRVOGNMRkFqUUFuai9TMnFUZ3lkR1JzTC96eGt6NTBNRmRMMjZu?=
 =?utf-8?B?Qi9PQWJBdW1SYWxsNWh0SStSSDhjY3U4eU1iN0Z5d0tOeVpId1Z3VGQrdytj?=
 =?utf-8?B?RmxZWHBvMmMyeGVWbTU3N3pxUVNuTEVhQXlvRkVOQk1UY1JZb1Z6R0d5MzZD?=
 =?utf-8?B?WWM4T3BYOUIveGtEd1pPS21NRGNyM3podTNmUGFlYVN4VW03VWlycUpSWXh3?=
 =?utf-8?B?RjNsZXg3Tzh2eTdkbVdsR2Y3N3l3bEtubWNNY016NXc3dHNHbnU4NTNZQWdY?=
 =?utf-8?B?YmNuUFNva2FWeUtVQit0UnpXMjh1anYwN3pNUEhKWEVTQ1o4WmRYZGdkRFND?=
 =?utf-8?B?OEVQdE00NWYyamFYWTNaZGxJckdiZjFHMGVRZlUyMERTTjBrRHBGODhSY2g2?=
 =?utf-8?B?UTcvNk9GVjlpeVZlSzIzTjV6dzYxT3g1K1d3UUhKSkd1RHU3ZWJ1QnF3T0V1?=
 =?utf-8?B?bFRTb3ZQWWtyQXh4LzhMajR2RWhwTFBsdTVSbTNZcVlVQjdtYVhscmM0QXZP?=
 =?utf-8?B?dDdzNEFrTUxTZHNzc3oxenZaMGROaVRxcHcxVkZVNjNRNE5sL3R2eWpFbHM1?=
 =?utf-8?B?U0dqQ1VYMzVGRnJSVG5lam5uSk1Pd3V3QUV1MUNWKzA4V0d4czVlNERtQkpM?=
 =?utf-8?B?RkQxQ3Z6akdBR3JtbWQ1RGdXQXdIaExNQVhscCt1UmFmanA3UFJxMklwemk2?=
 =?utf-8?B?bmdyYSt1Z3JrRG5HWSthTzJKVFBGamZ5eGNTVXA0RnJ2cjhkdTZ3Y1JhUWlS?=
 =?utf-8?B?RUFTeWFrNEdXVkJjc2I3Wkk2NU5zYnZtT0h6WGtTajNFQVZ4Rkd1OFloYlZy?=
 =?utf-8?B?WWNIN1pPdEpDRExJT1lWdUFsMWtrR1lYYlNWbXFGcXNRTDQraFNkOWJ4RVlG?=
 =?utf-8?B?NU8zb0hzeUpMbGxBREJjdGFPZ3B0L2phTm5Qa093MUZGbElzanFQRjc3Zkp1?=
 =?utf-8?B?TGYxWUNTS052Tm16b0lCT2x5WU40YlMweWZBcXF2dHhLL2s5UDZvWWVGQ2k4?=
 =?utf-8?B?Nk5DS29KRGFiUWVIUndJekduTHpDQ1FjMXQ0YUZDQ05VN3ZCeGpMRUZNbFRp?=
 =?utf-8?B?QUxjZnNXTE1QRlpaNlBkQWtXMngvWlZ6ZXl0WDQvVFgxak1SeHQrYklJNzZQ?=
 =?utf-8?B?dmNKcVNzS3VqY0x5TG5ZRW0vSkhpVE03VE1JSFU1bjk0bTVXZWt6cmZ4Umd5?=
 =?utf-8?B?Ymd0UjJlTm5Gd1VaYXBjMXJNSkxHckowa0MvV01uMUh6S3JMZmdkWGlKbHFR?=
 =?utf-8?B?alY2U3REaHZONnF2TGlsR3hETVUxRDRiV0h2N2pycXR3aUNuYUVjMWdLUnhN?=
 =?utf-8?B?Y0xLY1ZlTXVmYllISUtuWExJTDd5Z1RDN0l4WDY5QmJNVzd4UzM4blI3UVNX?=
 =?utf-8?B?UzNLOHJBcXMxKzlZSjFRT1JWeFhvTVpoR3NJSWRaUHp4aUN3ZnRsckh6R3h5?=
 =?utf-8?B?SDB3T3NwdUxUb1Z3cFZCQTlyRXcwdkZhSmNVMzcyL1Yxd3VJZUNSNHh3ZHVw?=
 =?utf-8?Q?9gR0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd41e99-3cdb-42e8-ff11-08ddff63ef98
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:24:44.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDPUEkXJ47jsTd7MPS/hDg6O/MYP3WqK0fS7dPceFfSH2OSElo6RsfwekAfz76YKQaBkjkIkaBrPv7UYWdxN8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Add SOC special compatible string, remove fallback snps,dwc3 to let flatten
dwc3-layerscape driver to be probed and enable dma-coherence for usb node
since commit add layerscape dwc3 support, which set correct gsbustcfg0
value.

Add iommus property to run at old uboot, which use fixup add iommus by
check compatible string snsp,dwc3 compatible string.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3 - v4
- none
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 3 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 9 ++++++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++--
 6 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index fc3e138077b86cd5e3cf95c3d336cb3c6e1c45ef..ef80bf6a604f475c670e2d626a727e94fcb2a17a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -493,10 +493,11 @@ QORIQ_CLK_PLL_DIV(4)>,
 		};
 
 		usb0: usb@2f00000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1012a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 7d172d7e5737c4b6e42ee88676c5763fa7415260..e7f9c9319319a69d8c70d1e26446b899c3599f95 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -613,9 +613,11 @@ gpio3: gpio@2320000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -623,9 +625,11 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
+			compatible = "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 73315c51703943d9ee5e1aa300c388ff6482423f..50d9b03a284a2aa4e13aa3323c25bbc5fe08f3d0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -833,10 +833,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -845,10 +846,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
@@ -857,10 +859,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1043a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				usb3-lpm-capable;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 770d91ef0310d971d044a1f55cc5e2cb738acc47..22173d69713d1bd2abca986e76668ad437dd34e4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -749,10 +749,11 @@ aux_bus: bus {
 			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
 
 			usb0: usb@2f00000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x2f00000 0x0 0x10000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -760,10 +761,11 @@ usb0: usb@2f00000 {
 			};
 
 			usb1: usb@3000000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3000000 0x0 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -771,10 +773,11 @@ usb1: usb@3000000 {
 			};
 
 			usb2: usb@3100000 {
-				compatible = "snps,dwc3";
+				compatible = "fsl,ls1046a-dwc3", "fsl,ls1028a-dwc3";
 				reg = <0x0 0x3100000 0x0 0x10000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
+				dma-coherent;
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,dis_rxdet_inp3_quirk;
 				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 9d5726378aa015eff10578bf095908a58b9d9eee..b2f6cd237be046123de9342e2167aa32248a8a16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -489,10 +489,12 @@ esdhc: mmc@2140000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
@@ -500,10 +502,12 @@ usb0: usb@3100000 {
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,ls1088a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index c9541403bcd8239a48d4ef79c7c4f9e3b607b556..d899c0355e51dd457a4e7259709cea98a488f557 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1094,24 +1094,28 @@ ftm_alarm0: rtc@2800000 {
 		};
 
 		usb0: usb@3100000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 1>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
 		usb1: usb@3110000 {
-			compatible = "snps,dwc3";
+			compatible = "fsl,lx2160a-dwc3", "fsl,ls1028a-dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			usb3-lpm-capable;
+			iommus = <&smmu 2>;
+			dma-coherent;
 			snps,dis_rxdet_inp3_quirk;
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";

-- 
2.34.1


