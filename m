Return-Path: <linux-kernel+bounces-892341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF496C44E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B259A188DA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2745329AB05;
	Mon, 10 Nov 2025 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jqPZ58i/"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA4298CAB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747381; cv=fail; b=eVmuF20YIqm/bqV94fXD6TS9s7sN4ugW0NeeyKyEKIG1/MARYvgdszdgVmc6bMiyOaPbwnrV/goO2duLk94/xWWKDgD8ww/hCQ1nJ4PrghMVZux7WICVn0yZ9Cl8YGLEofDE4JpCk4wl+AY8qFmUnjWXFZcsHUVb2vVK/04ojRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747381; c=relaxed/simple;
	bh=EReFlv7Ednl8OCXQ0nxKlbyMuUcufsImMTdYhF0odaI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r9kC+9dmKGMygUtjMHrWTvU7gF/vGWBbyzUgosKWwydsit8bQxUzTi1bgQ58zBhdryQhgPrtK73w0BvtptRF17GFMddVL14GSeyIF/zsepHRU35DHoBukfo+bfXngnf/wB7fefDUNU+6tr4taieH40b65sz6DXsF/Urz/1/vzt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jqPZ58i/; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiD4KlHUg5G4zsHxXLJUGQtYIRZ8IUzCeM7mWLCfrYOjfKo2LuQ1sryNZMaOkLYvDt0vcKw05faVCp1IvGfXKzV+4a92GnnSAnDKKuTvYAgF4nKZiyebWx82cfkWf8EWOb571ixseMB2vHiWUQUANwC7yUD6cVsf12jeIrTWrCJJUNdzFhpBklvP6cn+aCEsLsww4NumIN+Kori5CYZozIxpz+xbtvOKwziXRTjnuVfRaiVexFaBPWp7gCGwjrHJjqTvg04rB6i8TQobIw+ETgTagmy0tFXoQjKF6TlZMdWay/q/h2d9duUs7/57udG876MEz5rANxurKhKNxGrEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6vtFZDxH7qDRf7bY5KG565tgcNG4wc/poDnHUgUI2Q=;
 b=jCDufNO+xmJKIL95U137eM2xd65qnN/KdChKVp91KNpyT7z7++du9K+pAgIJdCji9PgIEszkHW4d7AWzBPatVxVNvqV5HrkdYRv3D82yXlFvh6Vgbh5PSeUPmN4l5b8JVU5ad33WNBviZ+vbv1ABHKWk0sLBuu/lMhxVYGXjC6xf5bzY/PUWh0oNx7yMb/O4ak1KHTv1jBbEMowID+6E263v5beteZsllcI07ZOpU6ch+7DvPhukSB/vQ+yZEY4dmfoAOF9PrPxKJTVWvVpTNa7zkV8l/ywjK0h5WbiKvWzILHyyftcre/bLNfC2TsuaZYEGqDEMoyMt3gd4tH66OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6vtFZDxH7qDRf7bY5KG565tgcNG4wc/poDnHUgUI2Q=;
 b=jqPZ58i/EjRw2YBgeFHs6WGYolRIhmdj5Bm1VmW011JMz5/B/fXZa0OXIrBi99zdbVyO09hnTkJMYhVW1eDc8oRnCUCYu1wTJ021ww97KWfsVG9LEqPW7OWW+fx3L6ok8tm/Bf3Ygahl93fr6PYWkRMuizZ3JmdFd7BC9Am+1EaD13tH3OBQ7DwOGtVXHFpPgjddhtwLs7/3BJ+MTL+n8MgmBTt2HHJ1DgaNCI5c7NEZKg48PEzazF1PNzfGKPvzqqfYoY8oq1O/+oTkAjL7bjE3flIXygXmxQ0JHmwTEgvWP3dB299ibq9WpH6thxj4hrl9c0CVZnRDDorx/A1LLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI0PR04MB10949.eurprd04.prod.outlook.com (2603:10a6:800:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:02:56 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 04:02:56 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Mon, 10 Nov 2025 12:02:59 +0800
Subject: [PATCH 4/4] mtd: spi-nor: micron-st: enable 8D-8D-8D mode and die
 erase for mt35xu02gcba
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-nor-v1-4-cde50c81db05@nxp.com>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
In-Reply-To: <20251110-nor-v1-0-cde50c81db05@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762747415; l=1658;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=EReFlv7Ednl8OCXQ0nxKlbyMuUcufsImMTdYhF0odaI=;
 b=j8bGw7/JtaUQnplt8ipojF8SLt9Mc981uFoVfMvuOlXJgVd/PUMp7cDX+v5xLwrECbwoMYZzG
 QoC5BmM5+MMCm4iuzFXekMb7gxapZsI/Rwug6wLMW0/5g3vRcvVtECE
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
X-MS-Office365-Filtering-Correlation-Id: b3831131-7340-4074-2ba5-08de200e07bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFBPQjJLQXY5NThTT2diMjVBRmxmK1JVeFBCTlAyNGprM3lvTzA1bFhuRmxE?=
 =?utf-8?B?eDRGbVhBMm9CRE85Zk5LWnYwdVYwaGE4amtYcFUyWUlicldrMHFNNFNJdklT?=
 =?utf-8?B?QlNZMVhPMW9DTkRQcklTYXAzSUFzVTE2cVROU0ZoL3dZN2RiZWUyN3J5Q2JZ?=
 =?utf-8?B?MWNtRTJMdFlIY1NPdTJTc3lHSWtRcW5icHUwdGRqd1BDTXNrT2pMaTFuUU9p?=
 =?utf-8?B?aG1MN1VGbjRkVmluK0I4aW9oMnUyRFJSS1Z6Y3k3UzlIUDFPdHFIK3ZNcVRq?=
 =?utf-8?B?NWhTYXNHOTVicmxoTVJqTitlSUNTVjB5MW9ZbHRYamZUWHVVMVBIeGMvSmhS?=
 =?utf-8?B?QWs0REhoVFNNblB4N1hNcG4xWlRkMjBkYy9VTFZJT1BJRlZXdWpxcHFPUm1z?=
 =?utf-8?B?dGc5SFUwcFRwMk96WmcyTVR0WU9KdE5PVkVRM1JnSXNkVmpOakkwWEpoQnlz?=
 =?utf-8?B?S1Yzc2lWS2gyMFJGbWVQcGM2cWpDWmM4cXFYckdhcXBJQlh2VkxxY3psdlJ1?=
 =?utf-8?B?cnM1K0hMcjQ3MlJIeXpaaWpzOHlFQkQ0a29LRGM5THY1d1ZVWGJZN3NZc25L?=
 =?utf-8?B?R1I0bXNPTElUVDRGTTE1U3AyN0xZOFFwMGF1TnR4TVJVQjBJcWtiTmYrN1Nt?=
 =?utf-8?B?R2xQR2FMOWdkTU0vU0tBZ09MWnB0TkRTZFZDNmFXUktPZDVzcVRQYXRieVpa?=
 =?utf-8?B?ZzZXdENIa0tPTytELzBkbytCUGxCYmh3NVY5RDllMmo0NU41c1FSa2FEWWZa?=
 =?utf-8?B?RG5zZmFQR1ZwY255RE9rbFJucThMVWtQUkllOEJXb3pXWWxXSHRQdnVMS3hp?=
 =?utf-8?B?R1lFTEJlRVdTQVJ5M2hRZDdTWHNkM1QxNG16MDRGckFKTFdNYjNoTDRNWHlx?=
 =?utf-8?B?Z0FvNjdkTmRUY3JERXp5Uk9kWGh5VzJWYnQ0SzIwVldhU2pWVk42aUY4UHpK?=
 =?utf-8?B?Z1JvTnBQT1J6cTNqNmFhMk5tOFBqNEVEU2JhOVd2M21EZ1RQRHd1RDdmNEQx?=
 =?utf-8?B?enBVSzJrS0ozY2hOWE9zaXJ2aFpJRjJXZzI2SUhOQ3JwVG4yNzlmMFRoNnVJ?=
 =?utf-8?B?QjBpdFY4WkpSdFNTRm5ZNHoxYVMzOFQ1Rkt0UDIyaDJnVk9CSnI4a3RGRG9X?=
 =?utf-8?B?c1hQc1pyV3Foc3ZUSWplYWRKSkJqWksyUC9xUVBFbVJBc25zQUdBRE9GbTgy?=
 =?utf-8?B?V3M3Z2NHZFIxbCtUWlNka2xQTndmWkNWU1Q1STAxRlZtWWx2dWlKVzBJNHVa?=
 =?utf-8?B?Q0laWFd5ZVFQR1Jkbjd1NjAzTG1jMHo3M2I1cUpKZjNHK3dYRWQyeUFaejRz?=
 =?utf-8?B?eWRHNjFZYUFuL2poOFdrOG5OcEVQcnFPd0tCaGVZZFg5ZlpSb3NvNWw4MDRo?=
 =?utf-8?B?Y3I1LzVmWnhxZ2Rqemx2c0xWNmttL2RHSythcFVqWlRGeGY3REpKR3ltVU9v?=
 =?utf-8?B?bUIxTVpYakVJeTIrbS9ueE1seFFUUWw0SExwQzJTV1NBdjhHU3RRRitXQ3Yv?=
 =?utf-8?B?QWtuOXRMcU9zRnN0ODlnUFFMeGNTRklZQjluaTNtQW1SUnJsQU9NS1B0WFZJ?=
 =?utf-8?B?aTlWUnFjZVVGRzBYVTFqYlE2MFhkZ09nM000RDZGTnJTZElDR2V0SnJ2OUtI?=
 =?utf-8?B?YzF4UDk4SnZTWVY2L3BiQkJhSVdaYjEwK2JrRXZ3QzNYRXhVM2ZlTlVnYXZE?=
 =?utf-8?B?Rm5XMnUvUW95RHpVcmdEWm5HczM2a2k1cFNlV1dRaUpaVnFrZld6a0U2YkV2?=
 =?utf-8?B?cWNTamErUUYrVk9XK0dNOWdjSVViL3VUMnlGdUp5SThTSmFGb0ZrZHBtNWVr?=
 =?utf-8?B?NysrNDJmczBFMUhsSWZyL3Y4ckoxd3dqelNtSGhJVmZITVZjS3g5UStnZGtJ?=
 =?utf-8?B?b3AxbE9DWW1QUFhNbVRmS1I2UmRnYU1RRlZVR1Z1b1A0TXVxSC9xTFl5R0Np?=
 =?utf-8?B?dXlVcDg2Slp4Qjg5Q01uV2UyTnEzUGxHNGhSTFRhUmRMSGhKM2dIR21LdzBo?=
 =?utf-8?B?ektpT2Fwd05BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCtCTTh3ZFRnekVQNW1IbzVEemVVSGVJMGdLSGVGbThocUpnanFIOHk2UXlh?=
 =?utf-8?B?N1dGNGdSNHdGbFJ3VHBlUFB5SmJLTGt1eHpvbXIvVE9jL3VualZDUlhMMS9T?=
 =?utf-8?B?VitEZFlmT0tsd2UyelM4Y21LbE9MR04xK0xiLytIVHgyaXBaa0lVcjYwMnZi?=
 =?utf-8?B?Nk81MFBFZDArcWU5NEZOZGtJRDlFb1hpRHBadW1vd2Rwek94OU9CcG5WK2Ez?=
 =?utf-8?B?QXBsRjNqajF3S1BrcUlPcDd2cU9DZHRNWHZ6ZWNCamlLZnBWcENUUXlBblda?=
 =?utf-8?B?WlhiWlBRWDh1M0F4czdRcE9mTU54Y1o0a2tWaERzSncvYnBJdXQybytNSzZD?=
 =?utf-8?B?akNIMFRJcmttY0RuWjZHZ1RtVWlsWko1THUvbkx1T2ZZK1lUN1dseEx1NU1K?=
 =?utf-8?B?Q01XMCtLRFRjcEdpOGJNWWpnKzhxU3NGdWJlb2hxWU9hU1JPMXdzRTRhRVQv?=
 =?utf-8?B?VTdUK2NBZ2lEWGRJa1d0WTRoV0dxSCsvcGRETGhnSnU2Qnp1ajFiUGpjMEFj?=
 =?utf-8?B?aHFBWmFDYlBGdWpxWmlMZEJPZHYzZkF0SlROUTdqbmxkT2QvSUJDL0NCZC80?=
 =?utf-8?B?WnVTSkE4WGhoUTZZa0VZVmQ3SXpWUHZpbVI4UTdUZzloSk5KQjY1RmdKUllq?=
 =?utf-8?B?M2R3Y3NMdmd0TXBWdjUvYjhuOHAzeHJBK2xUM0REVWExOFFLUXoxNmlrRDhW?=
 =?utf-8?B?cTBZWTYrWnRRMFlqQlVSVUdWNG5LWXZzL0oxNTJ4NHJCQWk3UjJPWUFvbDFt?=
 =?utf-8?B?V1YwNmtKNmsrcEQ4VDB2UVN4NjBwZERMMmRtcEU3RVdiK0pvUkRUT3Ixd0h2?=
 =?utf-8?B?NU0vSmlOdFZQMFlodm5KTkZLRjhOOGYzZ1FOOEkyVEpKeUNYOXgyZEVDcmZG?=
 =?utf-8?B?a0VoeU5MbDE3M1lKaCtOVEZzNWtJZDhtczM1QXVvQjFwZHVJb244b1hhT3NU?=
 =?utf-8?B?TXY4RmRpOW1iMmZmcGxPeFFhbUpBWDNBVElFNnk0SU14RU5Pc0ptZjQwMVZZ?=
 =?utf-8?B?MWIvcXJHTmluWDFsQVNUQkdBY3YvMFFVcnJkdmtBYjltY2Jld25sVDAyZmll?=
 =?utf-8?B?RjNHVDd5Ykp6MG5RZTloREozTG9QK0RRcnJUWVVDUVQxeW1sOWp3SjdKVlFk?=
 =?utf-8?B?OHBjcDh4UkhIbTR4MWZXdWtGZkNkM05KYjdUWlRtTGJSSlVRb3J4UGJiN0ww?=
 =?utf-8?B?VXZwQ3FERGNqTnk4SUNUbmN2NHFORmd0SWUvbndML1kwcytEZlFPb3plQnFn?=
 =?utf-8?B?QUVBaXpNUGlpd0E1SmJVazNhcU85eEo5aHZ6dUNQZVltR0gvTW5naEVSSXgw?=
 =?utf-8?B?cnFIZlV6RnVOVU52OEk0U0Z0N1FlS25DU0xHSXpDbXlOZTVUU1hsVnFreWNj?=
 =?utf-8?B?QkVzOXZCbC9OSlIyUXVwa0YvbVI3VnJkMWR1MmMrTXIrQmk3QTZyUEtMbjdj?=
 =?utf-8?B?M1VKT0RJTGFKa29YaVhPdHI2aDdPMUU0T3h0OXBjRktYcU8wdHJwZm9BU3ZB?=
 =?utf-8?B?YWViS28wa3QrUHRZamZNYTYxWG11SGNuWlc3RUkvSHVFMGFMbEtTRm96Z0s4?=
 =?utf-8?B?SUZGUGh5a0VFNHlwL1lvUUpDa3lJRVRMM0plbUdrdjltOHpWbGhxdXg5R2ZZ?=
 =?utf-8?B?aW1jMnRGc3lua3hwL0o3bTZlWFVJNUsvNUhLL1pwNEkvcW9HSWZCV2FyUXlK?=
 =?utf-8?B?REh0TDdaWGl2enFLV3NlUVVnTWZvQStSUGFYRVVYekpNUmhBWWE2dGhSTzZW?=
 =?utf-8?B?RWFLSitnM2pKM2c4VG9TTGQxVkJVem0vZnNNdHlKWlR4Ym1rbFAwNngxNldI?=
 =?utf-8?B?S3VXdU5KcG9oOHdZMnlGTjhsNXIwOHBQVndJOSs3bnFaTlBvc0pRbDRSZE5D?=
 =?utf-8?B?aVVZNGl6VmtUOVRuZTdUTjZ4QWJ6MHJ4MUVwdjJlWTg0bjVaZmdBRWNsZTR3?=
 =?utf-8?B?S05XQXIrZi9zaUNnV2hSalZiSkk5MjFIb3FFRU9wMzZzQmdEbytNQWVBM1JP?=
 =?utf-8?B?OUlvOHJ0M1RocElvUzJUc2loRXVialBkb3pLeUxSTGZVN2RiYlVDalFVTStB?=
 =?utf-8?B?V25kS3psSUIvallCeVJUQ01rMEwreWdady9ZbVdvMEpFUjJwYndYOGNUR1F1?=
 =?utf-8?Q?J568Ndx0SIeELyztD4x9y+++K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3831131-7340-4074-2ba5-08de200e07bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:02:56.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3sUnmeJ+Zj39B0egVBeAl9tKqShtJ0DGt+4Oym6v8XcGkgF123KmevrkEwtrfLPRE9brpL0D/Fd9aBq/BLnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10949

mt35xu02gcba is similar with mt35xu01gbba and mt35xu512aba, but with
four dies inside. And it also support 8D-8D-8D mode, but SFDP lack
SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mtd/spi-nor/micron-st.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f724313f4dd3720908968c670e8d3d58f41c099c..b36174436b7aa0f7768dbe48e4ad4927c08a3d6d 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -214,6 +214,12 @@ static const struct spi_nor_fixups mt35xu01gbba_fixups = {
 	.late_init = micron_st_nor_two_die_late_init,
 };
 
+static const struct spi_nor_fixups mt35xu02gcba_fixups = {
+	.default_init = mt35xu512aba_default_init,
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_four_die_late_init,
+};
+
 static const struct flash_info micron_nor_parts[] = {
 	{
 		.id = SNOR_ID(0x2c, 0x5b, 0x1a),
@@ -237,12 +243,13 @@ static const struct flash_info micron_nor_parts[] = {
 		.fixups = &mt35xu01gbba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
-		.name = "mt35xu02g",
+		.name = "mt35xu02gcba",
 		.sector_size = SZ_128K,
 		.size = SZ_256M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_OCTAL_READ,
 		.mfr_flags = USE_FSR,
-		.fixup_flags = SPI_NOR_4B_OPCODES,
+		.fixup_flags = SPI_NOR_4B_OPCODES | SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu02gcba_fixups,
 	},
 };
 

-- 
2.34.1


