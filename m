Return-Path: <linux-kernel+bounces-854911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40965BDFBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F401506F25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460033EAF8;
	Wed, 15 Oct 2025 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpWwfBOM"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0333EAFB;
	Wed, 15 Oct 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546718; cv=fail; b=MzwnVt1/NgFi+WUJ3gggjzcja6y/9+GXjBbRm2Q4qT087mMhhEP9i5x1djT/zF/zGMegQ6Ohb5Ina7N3KPitZ6YCprjiBBXmG+NJusEzMkAZ57ZncbvssjYXPz/H1VIy6EYJ6ZnO7Cu1B24P3nGoDfUhk5HsuGTcmquQYHaOGNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546718; c=relaxed/simple;
	bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s9/thr2PWxXZN4nEL0PN6nUQ/oGzqqeZk2o5PnhT2lXzTzKDXlH6/Nq1uRKqV7tCyQuRXwN3FYRaQcFAaEK0niAPc15r6NOlr732o9HAygMItF95yboo5VIXGwSLZJL+p1G3/w0RNGim4x//CnSNWJ78pKY0cRO+5vvJ1hRSa7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SpWwfBOM; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+Le+2mbPyHeIvxfoDXLvWgu2us6SWDg/n830na2b9qq3eyMCFqE68iWSzdnjgAqEAVJtbHY6uBwmjQ7F2/OP1Nc5z1ELhOABb4898WHt7gDtoN1V7aWUx26FTfZhhkhIq2zcttM7dAdhYdp+bZTaMmsOii7yyhrJ3aEvCyaO2WScdvUbp7RgLZWleADTEsZ9t7a3HFdhq6DMPNKP6Flxk/Ww8Fdg9TRO/6WT9sTD8dUueJd8VzyztFJlLWrkg5rFof9GVixGwUKL4jHROeybW2xhN7mhDXOeH3LepPPM5e8aAk8yxjsDKFesGTQ+izt92N8Wchs44Nu4H8CD29LwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=rAqVbHw9VYLYxrRcB2XQUzXsEVWmKBEFMAJGsTy2O2b/0GbuH+ezSdCfMewNhv1F/0BOrC92RhpxuwPhcp/RL5JuRLOPp3bAqyxbSLaybO0KuGICMIPJuktF6ePjMHQFOBztp3ZUC+V4WtrBA9v/Kfdz4KrDZFjyhk+fcCFJHU/87pFLL0a14t+qqVJ+EE/hpLl9bPjxeXzqXLHzr9XI0g9gMEIa0Zzz0QVwAlzniGTc/cgrD/1BbT7+BDAcTCeQ0PM/DuymEwAhPGpUqx9flaBuOf4wzAapdQTlCz0OovpfPRTL4JvtLyZUmT9wwMpGMpDwld2f2/fBv/QK6XyNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDXJc4Up7QXPdAyEDqSa4Ayrn8e6rVWtgxGrmOuUZ0o=;
 b=SpWwfBOMzadCRpJv4OI+j2JhwClDimsIT/I10Sw9BabIQVNepKvXVdIvAfrwydBF3qFH8AKj6s9hwvz8cCOFc4a5A7JteMObHA4KyEaM/usvfmzz2jisAaCkojwpsXygC9gPW34m4nXcimp7OVqLqGijsXKSC2ixYQg8vnsLJBo0IgTDiWln8LppkPz8ULaMMInqBUdCQ0MOpI96fwh+PnPfn1b+W9nH02EVxrX87nrbPgH69AVqOqlTw0a7UB69OUVsYiKMR1ZZXXJetOYsrwMr4f80GE420dA9XyW+J8c1qkw6qf3EP3L1Hx4Ex9HzFrJnY4V2VTM9Pyy7LxyapQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:32 -0400
Subject: [PATCH v2 07/11] ARM: dts: imx6: remove pinctrl-name if pinctrl-0
 doesn't exist
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-7-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=1499;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IBe0dESJLCX7jHaCf9dLwBLd5K8sW+7qIOzaAeP0mA4=;
 b=m27E+mSpnEOjtQcj0bwRCJDXNcUZBTrTG6oOFBAqRxCwTb0OC4oYE4Bp4mNeFc9024RX8rX8g
 ec0r7IlAJAFC+MyzujPUkyFW/t4MI24q7Zf6yljwW8W/pUUnWqEKF0B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: dc55ca65-72f0-4cf1-cb56-08de0c0a3327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGJNUkZPL0RKTUZ6dUI4N082emNoeUJVdzRLOGFHU25YbEt0K0MyYXVvOFhl?=
 =?utf-8?B?OS8vK1V1c09uVFVBdzArMTFmUThXNk5NOHdoVStBdDZDc2RmczIyckl5VXNV?=
 =?utf-8?B?cENKaTZFSERIUVkzSDdRQ2k3NG01bkFZNFc4bTNidlZvdVZxa3dEb2Nuc0R5?=
 =?utf-8?B?MTZpeUgwZmU1Z3N2TXR2WDJ5STA1amNTOXk0bEJCVHZGaVdTWFcwMGFxeE5O?=
 =?utf-8?B?c3lxS0ZEakJDQUp6ai9iSVRkV1dvTHU5bWV0Vlh1a0grcDNiaVJGb0lmWEY4?=
 =?utf-8?B?RkgzQWNMZ2loRkU3Zy9MOW9mZXdxUXJ5bFJPMjZ2U0N2M2RxTVBsZCtuSTZz?=
 =?utf-8?B?N1BtR3c5Ym5qRmNjaEwwaVZyS2YvQmlIaGdrTXM3cVRDbCtYR3lUZHF6QXZa?=
 =?utf-8?B?QXpTRGVDYkFlM0krODdnTEhXZ1pxbHhXbmVTaVRZZFhBbDFMdWgzS3ZmSVQ5?=
 =?utf-8?B?elVJdnNSZ0Z4eUNtcmtDR0ozbWFiL2FjV3FsNGY4OW5WQjZjckhRMXN0YmFq?=
 =?utf-8?B?a09VbmFablNoZ3NWdGVUZGdTM1RCQUE1a0hIc3lFQmdScnhMbngzZWFiTG1Q?=
 =?utf-8?B?OTRFT0I3bnVBZ3p2OHAwbjlwMkcyZC9UOUMva0hiRmVWSG1RVkFSaWFqUS9a?=
 =?utf-8?B?ci9uZGVSb25rbEd5RkNYY1ZTemFNNEdMM2NCZUw5VC8rSEhmcXZiaUhLdmhE?=
 =?utf-8?B?YU01aVhNMThQNGpSaGNnRHNjUGx5SVRJVEgvZ0JQZWdpVHpJM3JYODVHb3Ni?=
 =?utf-8?B?YytpbWc5Z3hLRXd6MjlodTlidit3MHNsUlFkelZxTmVyNytkY3oySjBiR3ho?=
 =?utf-8?B?endpZ0Y5NTdPSWZpV2Q3MU9IdmYxZndMWVpKU0pxV0g2RUE5NzYwZGVmM1ZR?=
 =?utf-8?B?SE9NbjhwRllqaEFlQ0NUN1FreHU0WEE4THZucmZLL2tkcUM0VkZUWkdnTGNQ?=
 =?utf-8?B?QzJ4WmM1eGxzYjdTTUFLbStZbzlWMmU0a2xaY3pwS0R0Z3JBVVJXUWdsUW1x?=
 =?utf-8?B?UWdZNHdzWm1jMkExbHNJYW1iMGNERWgvZTdqZHVCZVBJcHRGV25DcHFJaElH?=
 =?utf-8?B?V0h1UW14ZDhBcEpja0pIS05ZK3drRHpsMVVUTzRFUDRUeEFrL2RTanRobTlW?=
 =?utf-8?B?WCtxVXFHQVgvVUt5OWIzS1J2NWNxYS9ITktMRGFBQUVUZktDS1paNkthdDNM?=
 =?utf-8?B?KzFoOERjY0R5OW8zcHdvak9Ub2FDbm04cHBCY201Wkw0RkVyK2JxUjUrQWxm?=
 =?utf-8?B?NEl4ZHJ5ZlB6bm4xclF4bGozeGV2aDVUSzJsRU1lV2RHRlZWSGpCUTdDamsr?=
 =?utf-8?B?MElBclZPUURlQ0RtdnJqY2JOaU05Q2R6RkhhRkVMMWFTL3RxLzhTaGluVEtJ?=
 =?utf-8?B?T2VMd3F3dWpKR0pJVURzSGZTWVA3VWRpNGRVOGhVdTdubitZV2R2aEljQTU5?=
 =?utf-8?B?RTc0T3ZkOS9HajA2OUpCaVcwRml4K1JsTTMrRll3MlptY0xoZ0tnWDJ1cTA5?=
 =?utf-8?B?ckZWek9HY2NjYTN4MVJSQU1ROTd4VS9tSllUTjNQM3ZyR2pXclhndTcxc3JP?=
 =?utf-8?B?Mk9PU2kxVTZheTQrMkVOSTBTaHhIYVVBZE1iY3ZDQVUxNE9McWNKQ2MrUEF5?=
 =?utf-8?B?MnVlQTJoQ2s4RE01dC9PNXZsNUc0aHBKdDNCMzc2V08xa3VHd1dzQjRxMWlk?=
 =?utf-8?B?SW9MVTg5aUc1TGFwTEtycU9QQSthcVNRNTFkWmN0MHo1QUJWMVVpNTBhRUJh?=
 =?utf-8?B?MW9pU1dPS21KMGJBNUJaVVhabVFNYzArMSs3S0tSS0cvMHYvZDdWN1ZKVG9J?=
 =?utf-8?B?NjNLeXU3RnlBOHYxS2ZKL1VqMmJ4V2UwWkxaMlZNbFkyR3VtWitOY0RvVHN2?=
 =?utf-8?B?ZCs0SDNVMDlBYlUrWml3UFFmUHhpdGQ5b0huMzl2VlVsWm1oTDFqM2FiNzZK?=
 =?utf-8?B?US9kWXo1YVFPY29rdkx2RGY5bEYxT2tVc1cybGEzZjYyMmpxczA4dWx6dk5h?=
 =?utf-8?B?M1RyMFRncFd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWp4VUJZcnpSQ0xCbmY2TVBTYUVBbXh0NG13dE1CekFSU001VUFwUjdqUFdY?=
 =?utf-8?B?ZHRRN0labnlSVzVZN1RxeXBTVFVuWDA3RE4rYldxbWVDa2pLZGZrVUdOcXd1?=
 =?utf-8?B?b1lybHJMYXRVYkZTcytORUNiS2QwSjF6RW1DaWZUSDV6alNoL0UwU3VBdDRF?=
 =?utf-8?B?T2JIOVM2akUxUzRGb0Z0dVVJUmNaM3NRZ25RRDRqM2Q3VHRiWENwQU11WFZi?=
 =?utf-8?B?Z2NtMjZuUG5MYjhkTVh5cldvMDJ0T0piNDc0aTlwUjc5UGo1STliVVRIdUlY?=
 =?utf-8?B?bnVPZDc0Sld3dGxpYTE2QzFLNTFMQzZDWTMyR0dpYmFRaHQvOHZraXRBblJt?=
 =?utf-8?B?UkRZa1UvNHo0c0lsSG1TZUMvMFRmcFE2MEtoOWJ6V3c2VTFMN1FRTkFBYkp0?=
 =?utf-8?B?bks1bkxmOHV1bS9zbmVBWjJraE9Dam1iOW9XTzFqczA3bkF5OTAraVlYam9h?=
 =?utf-8?B?d3VzMU9TdXFzYWx0UEtiZklsZnNPTTFNNVI2SHhURWNiZFFiMnJBRUlUVlQw?=
 =?utf-8?B?U1pYa1poOVRMcjZ6d3QxUzBQN2pvamFFWndxTW10QnZ0OFhkdStUd1F2QXoy?=
 =?utf-8?B?WWFHNFJMMXl3SFhXOVkrcWtKazlFMGVFSzVYWUdROHVhSldYaDJnQjU5cEMy?=
 =?utf-8?B?WEt4bUIzbVVzbDRTM1crb2kvMVVDdFJOL3JKYU1Kb3hMU1FXUG9lSFdUWU1Y?=
 =?utf-8?B?UHVhTkRRRVJNL2Z4WlhySFd2OHlxRzg0d3kzTzk3RC8rLyttNVdnWXlGMmpa?=
 =?utf-8?B?UklLdHhSM3FzU05oQWphRFV1SVlMSS9Tc3dKMm9nYXVjVE94NFhrQ3JuZlE4?=
 =?utf-8?B?WS8rcmtGODhOc3VQaTA4U291OE92YlJLd0FQRkx2clM5dHc2amN4MEVxakk0?=
 =?utf-8?B?cFh5aTgrN1AwOEN1RjZuVWtONkJRckNHNExVdERSMXEwd2JSRlQxdnhUS3NU?=
 =?utf-8?B?WkpiYXNqeVArKzdqVXJVRnh5NlYxNUxIeGxUZ3h5WUtzY1RqS201bENmMDB2?=
 =?utf-8?B?VHZBWmV4aVBxci9oSStydGxTdlBQSlNHRjlDUXp2Wis0bkRlVVJCYW5tRUwz?=
 =?utf-8?B?ckJ3dDhnN2R2aW5zUk9HNHhxWHJMN05PVXVhTS96N1h5WGgvMXpFTm9XRlZh?=
 =?utf-8?B?dTR2L3dyMk00NEJ4NUZjaS9sSHhnTTh4NlJ6TS93S25YVlpjVkZxSFB0Y2JL?=
 =?utf-8?B?NnQzYU9yNjgrZlJ6UFBXYUY5TzlyOGZyclRueGtzenlaVldzbUhoWWl1eG00?=
 =?utf-8?B?em1lcFd2TllLMWRKbWl3NmNvMHdWdi9FUXkxYWN2ZURyOWNZSEc1bU16amtG?=
 =?utf-8?B?SXRJQmhybnNIbGNJbXhpaEpkNnJQOHpkUWNwSWNXZ2ltN0hkR3VJT0lDeTFL?=
 =?utf-8?B?d0FuVEdwMmJZQk9iSytuWVRZcFFOVVBsOGNzZXlWMUFJUmVwMGJZNmRaenMw?=
 =?utf-8?B?Ui9ONzE4NVF3K0lsWFJkMGRzUHFaaDdhS0Z0RWpkUFo3STU1RUgvcE9ERWdj?=
 =?utf-8?B?QU5BdXNKaHJ5cWVmSFE0aW56a1dsR21kV1ZJbERWdXNOSGZFVVM5eWc5L1NK?=
 =?utf-8?B?TGIzZjVRSW1lZU5MRWVsRW5zSnVCYWRsRzN3SGIwaGo2YnY2WEMxSjZPQjJN?=
 =?utf-8?B?azdVdWtPRFJvaGE2T3ZSbEozbmxGQW5XWk4vY3J0c2tPTWI1WVE0ck1NRDJR?=
 =?utf-8?B?OEZBWmpKcFFDK2VtR2lldUxrRTUzVEdzRExHSlg4TlpTa1lleFh2N2NaQ2Vw?=
 =?utf-8?B?Unp3QXZSbUZKck5WcHgzYTVwbjNnbktSbVE0UGc5a2wzL0twck5GOHZiVUhZ?=
 =?utf-8?B?ak53c3poYXVqWlZUOG1icDM0dlROMndPQ21XMjJEdk9HZWpueCthS053OEFR?=
 =?utf-8?B?emg2S3lPdFVNMWFuMEo0QURERGlhUDJVTHZxQzQxa0JZVDZrb2Z6dzl0UGpD?=
 =?utf-8?B?K1UzRVluTnM1SGkxaXFvV3pHT3dKb2ZWWUlSSzVBYTZhZ0dlTGNrN3l1bGp3?=
 =?utf-8?B?YmliT1ZCaURBdU0rR2dlc3F5ZVUrNWxNNnNUK2kwTHBBbCtDSG16M21xRDEw?=
 =?utf-8?B?UkE2WHBzMlBxZUFXa3JtdFBJd2pOcHMycTE2bEQ2TDlyK0ZhZUZYdEsySmV4?=
 =?utf-8?Q?TW9Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc55ca65-72f0-4cf1-cb56-08de0c0a3327
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:08.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVlab7Sjbdzz2AfT0W6OIyeKyE4i0NIg4vxNKY+X6v1pWUMpkdZVFIKDikTNXjRChbEd+uq+/D81d0JN+cUAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Remove redundant pinctrl-name since pinctrl-0 doesn't exist to fix below
CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dtb: pinctrl@20e0000 (fsl,imx6q-iomuxc): 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts      | 2 --
 arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 56b77cc0af2be51d8eb6a9b0931d977e1f267670..6665c3ee623d915f4a4a2e240478e41a23d1b0e5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -324,8 +324,6 @@ &i2c3 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0  /*pcie power*/
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
index 2694fe18a91b12718c756c015ba99589073bbf07..7cda1f21e4182cd26a9322bc92ef6b7f88945eb4 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sl-tolino-vision.dts
@@ -227,7 +227,6 @@ &usdhc4 {
 };
 
 &usbotg1 {
-	pinctrl-names = "default";
 	disable-over-current;
 	srp-disable;
 	hnp-disable;

-- 
2.34.1


