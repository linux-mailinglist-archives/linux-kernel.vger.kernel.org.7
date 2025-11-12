Return-Path: <linux-kernel+bounces-897041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0DFC51DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A933B588F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68042FDC39;
	Wed, 12 Nov 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fHW9epox"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882430AD12
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945519; cv=fail; b=DbJenHu1gMSoD0rgr29yVnjY0ONiXu7cwPguNq6s9j/EvrmZt7nQMIa1Zs7J8pgFdClsyAKUmNdsyQsMsepIxUdMsTyaAGpVHkH2DEi+YWUmY+lRZBxAjwo40/+mbyK2g9hRYLujBlQ5DNYiI/duX76vE5KdWmrCf5kPPtXjhTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945519; c=relaxed/simple;
	bh=RUkasOkA+ig3hxEi3U4cRX/X6GhZs8UuU81+O4KymaQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EVeXq9MsPT25D7++KDtoXH3S+RvwIzfuXV5tDy5c62lDKmJO9r8G3G2qseXbASu4ksqzozN7lVZ+Fi+p1nSgu3fiQMnNW9QMUSi3m4HWlJVW4Lkk0X0VuUHSqBXyUh5ldlPAJjRO34btJQ/GJeydeVOaOLL+XDb5+V0ESJW3LAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fHW9epox; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLiKE2Rk5ZfzZOvh9wx9rEuBKkc0YVs9U0Uw2UhQaxvcoSROAzV6edfKHkk/8d/bkmG0zh+vdOJXhurGkvSayKjf/p5LH4UMHVI5lIApUHbIHE9Tq6/irJXYpKMjURHWxd77fzHlPvRh7dNO2i+wX8OY5J5EA9jgYhBXwH4OauRX2AlC05vUHCYsrGaRmk48Yi/WaQ2Rfq3orEGBtjfSzyoZo6uZx/uF0oM6C8e3vvW1krMYyQHjn7PoVEth9ZGeVJNxzzRRm4Iqgku+yF1sB+ZsltSODNABcxkg9h3t12gmWT2llTjbuG3lhWJV7JlrQdgqoIGHQd32PLInmm8QKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZpNx3FN5IGg5ovwU4grezciDhGRvLi6JtNUPLVMMhM=;
 b=dXxs7rn3PTVDeOeJGuAUBwky9qQntbYr2WuWlK3dzJuY5SBmOS4qQkrY3zqqbGPcmjOYp24qcjf+u0siSXv9xTjIOq1c6lOVHm5x33tDGQJyAMUrbEKassYKpyIIPnXkCxPpDPKchkJLmS+QMI0sbUALCXFvtv4d2vkhDmB5jyyxRDG59ahV2I/brqjzQgVd3XTldqMpkmPvNPCWtaw4hYqy+YBDUJQXV7nQnKzEHai4QdYZbQLlzJPdH2l/o3oF3G79nenYJekw99AXfhvjQlLATuR6m8QkKs37xBLgR6OIAJL1taWyYkOFiTlW3MQlW3orEHnRe4e4j/8h2wE87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZpNx3FN5IGg5ovwU4grezciDhGRvLi6JtNUPLVMMhM=;
 b=fHW9epox7RajvWWR8l1B07nTYUEoDYapkUDYqhJSP21hE5NSNN5u1HL2JcIISD8mKIoAGZ3oUvTaT9bT3k7jL1CZkxYX6DmYkz/uPKGg+tvCb3R/fpjxSh+t7yhiGC7npDoWjtvNrlDh8ASMXQVmBZLLr0WwfDRiZIg8yGycngZpb0NRjFgluzdumaw7gRe5UxgZR5hD5Zfy2z/9RLfrGTznmLIIHzxr6pb0GsGOziiz3f0Jz5wNGszC1LyuCL95KpYwsoIoalm9h8LaCTsmM1aVduyCbym5vFJdA0dXhl30g7gEQHjndTFIzsoE4Nx7Uepc5hqnpuwMVa7Isa9kug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:05:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:05:13 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 12 Nov 2025 19:05:12 +0800
Subject: [PATCH v4 4/5] mtd: spi-nor: micron-st: add mt35xu01gbba support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-nor-v4-4-e4637be82a0a@nxp.com>
References: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
In-Reply-To: <20251112-nor-v4-0-e4637be82a0a@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762945552; l=6786;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=RUkasOkA+ig3hxEi3U4cRX/X6GhZs8UuU81+O4KymaQ=;
 b=6SUIuAqMZXRvpAn54frxDJnvkOAq31DQJhWZL9nH1R3Hz/eIVd2avl7kOjfMUML49Ws5CfcrF
 USdKU+JhQaBBc27EWBdlRh6Q4eGGYAuE9tGbQEzvv3KTaM+Biwv9jcS
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 29834621-2f31-45c3-71de-08de21db5aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGVyYUpuMHIwT2QvQWFGTWgvbnZGaUdTQVhLUjdUQU85eExucWdKWEZFV2F5?=
 =?utf-8?B?LzRpNXhCVGQ5KytEeW9vbkllZXBLR3N6RW05Q003a29LOTIwMllmMk93NGNR?=
 =?utf-8?B?ZEc3L3B3QVdBVUNjekkycDdDUmRCRkxSeXhucnp6K2I5YWVQU1BQcWRoSjg1?=
 =?utf-8?B?bE5rT3JEQ29hU2pxYjhEcTErZU9jQmxNWTdoK0xoVi9SUGRFL2k2V3Q3ZHpB?=
 =?utf-8?B?TlVqUXhVSXQ1Rkl3enViRXVmdkxPT2gvM3J6T0xqay84dXV2cUd6WTE2d1Ay?=
 =?utf-8?B?UHdZdklZQ1RLS1Q2VFNKQ2p0c0tRWGFkN01BV0xWTWtkdEtiM1NZRTJyL0dF?=
 =?utf-8?B?TzZGaGhzMGg0MUFXbStZRHlOdjFIS2lwdWtKWi9NSXRwQkFKdS9IQlRic3hR?=
 =?utf-8?B?cUtQZ08yZzFGNi9Gem9BaWJNVEJraUZncFlJZE8wOWhDN0VyVEh0WGVFOGdS?=
 =?utf-8?B?bFY0dWZ3NE00SnFpb3FZWVFOeXFpM21iM3lNa2VaZlZ2Zlp4ZElUWDBjVDJS?=
 =?utf-8?B?VTR3MmoxYkNnSU9zNTlieW83YThQTjNuQkpmbk91VlJhcmNWMjRPVzFHZDd5?=
 =?utf-8?B?ZFFSb0NUOU1RclhCeFpXUGJMTWZhRWhyTUZFSHJ5RlBHWXVGWjV3U3V0bldP?=
 =?utf-8?B?YXdvemFyNVUzbTZzSVpKc1E4OHFKK1BFb3VQZmxMdmpLbTY2bm1nVTZ5THRS?=
 =?utf-8?B?Tk84SVdoU01lVGZyQTBCMVZETjB3bzRETXZQSEg5QmRtZG56YUNGVEFNV1Z3?=
 =?utf-8?B?RXN1OHFHZXNMdjJGK2RHOHU3YzN3M1RVSmczWHI5cnJzK05XUVcySGVRRmJ1?=
 =?utf-8?B?aFFsT2haYjEvYzNNZ0s3ZDhUQjhSb0ppWk5JcE1JSnVaTHZiQmVUR3c3RzVh?=
 =?utf-8?B?UmxoVUxrelE3cm8wS2M5MTVjWlNoRytpTkVPZGhQam9MYS81VHYwMEtDMUEr?=
 =?utf-8?B?aWVKWVluelQzZVUxaC90Qnp2S2R0UjhSZEZ6Ui9RamFKV0RaVFFveTRSK05G?=
 =?utf-8?B?UDFXeVNVb09yWjgxQ0NEMVp2SGVvZ1N1REREbXdybm5lUlVsQjcxTUNwaDI0?=
 =?utf-8?B?RGp5K242UUFQUCtkVlA1aFZXNVppT0JLaGV5ZmQzcElzTmN2M29wOUdzZytB?=
 =?utf-8?B?aEE1OG1uQTlhWGhUS09rNTFJNHRrQmpTYkkzNVZzMm1RVzF1cTU1WlF1cmRP?=
 =?utf-8?B?dDYyYTArRzJuSGxSVGExWHVuSnJKdXNCamdBc2dsMTY4Q2E4N2ltcUhTQkZu?=
 =?utf-8?B?YkJsWFo4NmZsRjgyMFdGR2xLWmhRVzNCUkdEcWlVdjNpRFRlQjlBSE5CQjdu?=
 =?utf-8?B?YTFwWHo3NHRxTXBPTm1wUGF5MTBRSEpPZ0NHR0ZFK0ZHMjl4WDA5T1I0UkF2?=
 =?utf-8?B?R2t2WTdYakhVNFVzeEE1SjlWdFdNdkRxd1crVEJ5MmcvRm1pOTlMMlM0em1a?=
 =?utf-8?B?WWlVeU1LT2NkaU4vTjVndVFQeWQvN2tZVTFhaTc0cFhUTm1OSkhBSlpybDE5?=
 =?utf-8?B?RVVVcWxacjBSMm91OXJCdkxrMzBYU0ZzdUhtb2ZzQk1Pd0tQWHkvb3hPQU5t?=
 =?utf-8?B?QWQ3ZWZzeG1PNmJoQW9haXRWaUxsOGduY0JUK0wySk1wejhVOEtUT3RJU1pE?=
 =?utf-8?B?d2k0Y3JiZEEyWC9FOE9QclUvTFFHRTlvNXF3MFRuQ09PdC94Z3lWYjdFTlU3?=
 =?utf-8?B?c0RsU0Y5dlJScHZ1UGNqV2Zlc2FmcnVTQW1halNKc1NDamp3Ly9PelBSNk9S?=
 =?utf-8?B?NDJ5S3lwYnp0dHJpcllxMjVKdWw3SnUvQUZrcU9Qb3NLTWU3Vi9lT1RVaTA2?=
 =?utf-8?B?RDJPazFHYTJzVDlHVDkyeXNIenVRMGNhcSs4SmhpT2Fwc3VZSzBzVEJLRkZ2?=
 =?utf-8?B?cGRUU09CMDVrZW1Xa2hlVnJKZlFQM3hORU10cDlCZ3k1REdGZHR0OFZnYldW?=
 =?utf-8?B?S0FUVTA0eEc2djVudTFsK0xtbE1IT1VlR1VwOU9aemVCYWRGY3ZsdWdFTldW?=
 =?utf-8?B?c2wycmpkRmlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDJ2UWdwaUFML0ppVWtjS3dJMVNpaXB3ZmRhQktPdkJKL0d6QmFTMDZFcWRI?=
 =?utf-8?B?TjJkdTY5aVY0clVEcERSeXRWaGxqUWVnS2FtNGs3SWNpNHlBb1hEUCtJMzFx?=
 =?utf-8?B?akFKS0JGSkFuM0prVTBtTkhiRE1hbUUxY1Y0MzhaOEdEbUVhcDhqbUxhWFA3?=
 =?utf-8?B?cU9oK0pDcmZKdjNHb0NWTGlRanEyc3M3T3RjQVVPUEt4K3QwaEljNnB3S3FS?=
 =?utf-8?B?T045WFVOSjEwSDhMTDVkVnRsZ21TOU1mc0srbkM3K3pDTTZ5U2FXY3VFTS9K?=
 =?utf-8?B?cFFFd1QyVGgxZTgyMWlWU09SbHRoYjhzbk5tcE10MFliSlZFZURwUXBTZUxQ?=
 =?utf-8?B?ZWYyTVllZ2kvY3pPemxPcUhFRE81QVRBaXo0YnpLWWJRTmpjdEJUdTZ1TGNU?=
 =?utf-8?B?OXBPakwvOGY4NFBaekZaa1pqUDI1S0pTMi85b1pOd0UyMHVWb1cvYjZ0bG01?=
 =?utf-8?B?Nno1dkJodDdXL3Npa09sdUx3QjhVNkFBVFVLS0k1WU4wRWNUWGtOR2s2ZFVQ?=
 =?utf-8?B?Vm9KN3J5cnpDWVJNMXc3NnpjKzlGeC8yRmViNnJtZTRFODNIUXRWNzZ6N3lh?=
 =?utf-8?B?RmlzNFNmZUEvNXVDZlFwcmFXUFlzdWhza0FpQ3VyYlZMNVpPdDcycVRUWktZ?=
 =?utf-8?B?YTNkbElkZ0hwc0xLNEVMaUEwaVlCTXRhNDc4OVdpaFUyTWk1RnNXQ2lBVk8w?=
 =?utf-8?B?NC9oYll3Q0JMYlBaQWV3TnYrZ3YzQ0JyYURrNW00enVVWTZFaDJMa0JOQkFH?=
 =?utf-8?B?OXU5blBJZjllMGU5bDZYZVVFTG9rcVA0ZFFJYjhrbGx1a0hCQm16Nlp4Nzd6?=
 =?utf-8?B?S0FCVDBNcEpGUlNDM0dIdlkxTXFSRWpidnZ1UngwRnk2WWdjeHBuL2YybE9E?=
 =?utf-8?B?MzUvQ1g5ZHhyZWNlSy9IZHV4bkZzaDdpYVlFUk9ER0g0R3FCVjRKWlpNT0pz?=
 =?utf-8?B?Z3F6LzlqWkQ0SDR1V3VJcWxBZGNLZi9ZQkNNMTB6TER5NGVETnhZa2NhcENn?=
 =?utf-8?B?bnBDZEhTTldrU09pMzFxamJDRHFMUUVQLzVLRk9MTnlTNlM3b2JnSm5JUlBs?=
 =?utf-8?B?SENiQnNEdXVuRzl2d1pVWDlYUTJzbEcxZXdRTVBQZ3d2UnFEdytodUxaOFly?=
 =?utf-8?B?aHFkQWRuQzlzQ2prVUVJRWhselg5bE54aE5ZSGZYQ0dORDRBSWNRMWZ2R2Ri?=
 =?utf-8?B?WHdad1VxWW5nSkU2UXJOZU16cHZ0U2NJTXdaZklLVm9CUVRaQ1ROdktjS3RU?=
 =?utf-8?B?MncyaVhMUnV0MTZvN3JmNkE1U21RY0I3RUhYU05UakNVUU5aL1VGTEszczR5?=
 =?utf-8?B?VmkyeGlLd09Bc1hsSUVzSVZJNWRWZXM5bjdFNmRFK2dWNGs3dTl3ZkpDRnZH?=
 =?utf-8?B?Ums3ZkhXUUVqQ3ZQRFBNbHlKS00zUUtjeFdVaFd3cGRYU0ErS2ZiazZCdG1C?=
 =?utf-8?B?b2k1NzA1Q3ZDWG15RjFIMXdick5Xd1lQREUrZnpWUEhRVjFmcjlXVlpOVTFj?=
 =?utf-8?B?UXZsRUFZb1Vkb29KSFJTcFVzU1UxOVNUUXA2QytTNHBmTUMrNlU3ZFZVQ3Bw?=
 =?utf-8?B?RDkzK21kcDZKMGpGZGZOOXdLd3g0Q0I2WUNpUXpuRzJIZ0FGT0ZNRVR6eWhs?=
 =?utf-8?B?dTVJU3g4NXJZUHZoZVA4bFFmcWdYNUtTenpRdWIzblYyeGxyc25hTS9obU11?=
 =?utf-8?B?S3pPM0FFd3dsV3lubnUxSzRSS3FWSVowVG5wWEhIWUVCZEtBOWRKdjdsZ01q?=
 =?utf-8?B?ZFZHRW9mcU5WNnI1dDBPSmFGbG1oQUlaTlZsZ2d1bGl2TXgzOStqYklDVk8y?=
 =?utf-8?B?VEdyV1JZYStBcEV1R1l2WENNblFKQ2M2WVFEcTBOdTlRc0YwTHZtZkk0TWlw?=
 =?utf-8?B?aWUrZHFMdU1OdTlVYVYvVlZyeVM3QlpCWGdudnM3b2NFM2t0ekpRZzE3eUYz?=
 =?utf-8?B?UXJ3Tys4Q0Q4TXM5NEFRMW5JRlZkUzd4WUNaajMvRmp6aks5d2N0amh4aWFZ?=
 =?utf-8?B?WXgzYjZUN3ErQWZES1g1QTAwZnBMbXZQcHVManQzUzdsMXZqTkwzcjMwcmxQ?=
 =?utf-8?B?aThDUzZ6N1BMZmswR1JlTXlTb21wT3dxbHZiSDJlNXFKb2pVSWhUa2lKMVRQ?=
 =?utf-8?Q?l4Z9fnQnzriYcWhKxkGR4GPzC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29834621-2f31-45c3-71de-08de21db5aae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:05:13.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrEwDdyX+gKn/4PZKsZnosWnQOr4MROdlsaHvLBSWKtTHK7t2JfYhwoYsZeW9hCstKc3vxg5UfVSFgtDym61QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

mt35xu01gbba is similar with mt35xu512aba, but with two dies.
mt35xu01gbba has SFDP and support 8D-8D-8D mode, but SFDP
lack SNOR_F_IO_MODE_EN_VOLATILE, so add this fixup flags here.
Besides, mt35xu01gbba do not support chip erase, but support
die erase, so add that in late_init().

Link: https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

---
1) This mt35xu01gbba is populated on the imx95-19x19-evk board, was
   tested at 200MHz using nxp,imx95-fspi SPI controller.
2) root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
   2c5b1b
   root@imx95evk:~# cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
   micron
   root@imx95evk:~# hexdump -Cv /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   00000000  53 46 44 50 0a 01 03 ff  00 08 01 17 30 00 00 ff  |SFDP........0...|
   00000010  84 00 01 02 90 00 00 ff  05 01 01 06 a0 00 00 ff  |................|
   00000020  0a 00 01 08 b0 00 00 ff  ff ff ff ff ff ff ff ff  |................|
   00000030  e5 20 8a ff ff ff ff 3f  00 00 00 00 00 00 00 00  |. .....?........|
   00000040  ee ff ff ff ff ff 00 00  ff ff 00 00 0c 20 11 d8  |............. ..|
   00000050  0f 52 00 00 39 61 99 00  87 8e 03 d3 ac a1 27 3d  |.R..9a........'=|
   00000060  7a 75 7a 75 fb bd d5 5c  00 00 70 ff 81 50 f8 a1  |zuzu...\..p..P..|
   00000070  2f cb 27 8b 00 00 04 01  00 06 01 00 ff ff ff 8e  |/.'.............|
   00000080  00 00 00 00 00 00 00 00  00 00 00 00 ff ff ff ff  |................|
   00000090  43 0e ff ff 21 dc 5c ff  ff ff ff ff ff ff ff ff  |C...!.\.........|
   000000a0  00 0b 80 9e b1 81 b5 85  00 f0 ff 9f 00 0a 00 00  |................|
   000000b0  00 0a 1a 88 10 00 00 00  ff ff ff ff ff ff ff ff  |................|
   000000c0  00 00 06 01 00 00 00 00  14 01 81 03 00 00 00 00  |................|
   000000d0
   root@imx95evk:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
   3848f0bd2436d7ca1373cee33f90e09d6479d0f4dc4bfd19f6a082d9e0039495  /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
3) root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
   Supported read modes by the flash
    1S-1S-1S
     opcode        0x13
     mode cycles   0
     dummy cycles  0
    1S-1S-8S
     opcode        0x7c
     mode cycles   1
     dummy cycles  7
    1S-8S-8S
     opcode        0xcc
     mode cycles   1
     dummy cycles  15
    8D-8D-8D
     opcode        0xfd
     mode cycles   0
     dummy cycles  20

   Supported page program modes by the flash
    1S-1S-1S
     opcode        0x12
    8D-8D-8D
     opcode        0x12

   root@imx95evk:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
   name            (null)
   id              2c 5b 1b 10 41 00
   size            128 MiB
   write size      1
   page size       256
   address nbytes  4
   flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET

   opcodes
    read           0xfd
      dummy cycles  20
    erase          0xdc
    program        0x12
    8D extension   repeat

   protocols
    read           8D-8D-8D
    write          8D-8D-8D
    register       8D-8D-8D

   erase commands
     21 (4.00 KiB) [1]
     5c (32.0 KiB) [2]
     dc (128 KiB) [3]
     c4 (128 MiB)

   sector map
     region (in hex)   | erase mask | overlaid
     ------------------+------------+----------
     00000000-07ffffff |     [   3] | no
4) root@imx95evk:~# dd if=/dev/urandom of=./spi_test bs=1M count=2
   2+0 records in
   2+0 records out
   2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.0207974 s, 101 MB/s
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
   root@imx95evk:~# sha256sum spi_read
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   root@imx95evk:~# mtd_debug write /dev/mtd0 0 2097152 spi_test
   Copied 2097152 bytes from spi_test to address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug erase /dev/mtd0 0 2097152
   Erased 2097152 bytes from address 0x00000000 in flash
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# sha256sum spi*
   4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
   57300768c1271d4588b850dcbf4e1400f287f09b2d515eda610890456695b205  spi_test
   root@imx95evk:~# mtd_debug info /dev/mtd0
   mtd.type = MTD_NORFLASH
   mtd.flags = MTD_CAP_NORFLASH
   mtd.size = 134217728 (128M)
   mtd.erasesize = 131072 (128K)
   mtd.writesize = 1
   mtd.oobsize = 0
   regions = 0
   root@imx95evk:~# flash_erase /dev/mtd0 0 0
   Erasing 131072 Kibyte @ 0 -- 100 % complete
   root@imx95evk:~# mtd_debug read /dev/mtd0 0 2097152 spi_read
   Copied 2097152 bytes from address 0x00000000 in flash to spi_read
   root@imx95evk:~# hexdump spi_read
   0000000 ffff ffff ffff ffff ffff ffff ffff ffff
   *
   0200000
---
 drivers/mtd/spi-nor/micron-st.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index 9a8f82045e4d89f94d005086eb012cc0b3f11cfd..c89c06b1fc61a581fea2e18732be2501a15715f9 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -185,6 +185,11 @@ static const struct spi_nor_fixups mt35xu512aba_fixups = {
 	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
 };
 
+static const struct spi_nor_fixups mt35xu01gbba_fixups = {
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+	.late_init = micron_st_nor_two_die_late_init,
+};
+
 static const struct flash_info micron_nor_parts[] = {
 	{
 		/* MT35XU512ABA */
@@ -192,6 +197,12 @@ static const struct flash_info micron_nor_parts[] = {
 		.mfr_flags = USE_FSR,
 		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
 		.fixups = &mt35xu512aba_fixups,
+	}, {
+		/* MT35XU01GBBA */
+		.id = SNOR_ID(0x2c, 0x5b, 0x1b),
+		.mfr_flags = USE_FSR,
+		.fixup_flags = SPI_NOR_IO_MODE_EN_VOLATILE,
+		.fixups = &mt35xu01gbba_fixups,
 	}, {
 		.id = SNOR_ID(0x2c, 0x5b, 0x1c),
 		.name = "mt35xu02g",

-- 
2.34.1


