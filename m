Return-Path: <linux-kernel+bounces-787678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BFB37981
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD247B0F04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B330F950;
	Wed, 27 Aug 2025 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKDb9U90"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99630E0C8;
	Wed, 27 Aug 2025 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270798; cv=fail; b=RuP6PeVj4HwqERHeN4IGw4Yj9Bh/Q24fWBgSaKHJvYvY8Jkq8JNuN+bb2AcwzUAvELhYLo7PAGy/BEsCH9b7zDyBHbn/T0WuS19roESA1ySDVU+0+yTRNU7PRmyQwX1oiVPN+RnQx0EnFZWs6AA0+4l7OT7IG/iygIGfiAOwcQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270798; c=relaxed/simple;
	bh=smAOw2LLys6Ccvgu3BgWXtBA5tydyCv6WOl3MxNr6AM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oxbuB5zHExdSO9JrH4SQesi0Ul0asqGI20Gn3VRMaf3wFN9c2BipoM/TKzl5cdA41vwj47C60KUk1sE15fPWuVAuZZLFC5UC/4gNAuk/pJS5QTK7RTJlkC/BsBU1FW6L4TTShcnGI7ziZSC2wXhcz/XA5N9DxdvKrdmqc1FiWFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NKDb9U90; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DST8h9u93Y5RbzJ6DzXeCcR1nsGnJNI8K7nsPAwcitln0w4ZbBLYl9yXc7MK5BMa/xgenO3/LUIqdn1vqRFffa/VKfGVi0xov+5hlqxkGq3J40NgpVlq/e5Msg2cO0JWjDrgXTHSiChc+hd30laC/6VOU98yiJbmshvlbLGcpzucTISuEPvHdaSI15FF/s5454H3OzlVrlzX2IyGbeYwne+8GE5WFWoALhAi/941C2QWXE4xaJgy6iACtozQDpRundbgyiKjO90GUKskxyko5Ml1u5VQSqSv4aqXETg5/ihd9+aA5gwIoKIdKszOEU119VmlSVI8SaGDbDb9hXW/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBBeiKTrAoJrc6ov3CW0ga8L4TPQoHo3OhY6qTTHfNY=;
 b=ak8T7HE7uYQLgtl8CM/1dzA9HPcJt63dwAnqRatdQnX0dxHSOfebQMcihA6f7QSVFIhr9elLR89Y1I5E1TJVpJhW4S1RxgRFA4PbQucjxlQH7uC6Eub8U4pYPumT+ax8vFQhZVF2E5cjXJVfQkh1NWWP/AIglXoJTlGX6yIaciXDLa89wBuDEh5XUkyxzidOkleI1E+xdK/3cKUNseo+KvPJ0+C0JmFpoAzruDuqPY45NW75ysx5EJtmt58LA6zV67Po9FndPqiFcUYTdDJ03HsrVu0+R3jmMzj23zb0PIZO+9tPR3wV+zrB+xxu82/In7k9LpCCNlD5Of63PCRyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBBeiKTrAoJrc6ov3CW0ga8L4TPQoHo3OhY6qTTHfNY=;
 b=NKDb9U90LK0lG0GxcDVVXIM+Aeu3BZSH8K8mqdH5rtbN1WyfqVdNhjJOggsXfIOu30UzLz/EnhSabCZcrIRuW1FF9A310/hHB9Orb3yAoJhUn+RRYk5W3qe/YieVdrz8fbVi/UAYF7m8KOVj3s9/m8dPfdyBbUi9r6EWoxD4L4noWpyp2gdEKnnVWDjFyzsv5RUV7f87hDLauIaIDZxPkbEAcqxE9/rHbWn2EcjP/WBlnJHznhJ2638K7Xsxmfl6jSH0P9EzIjGSC/EuzasJq9DizM2wELkyGF3j8nMLyAhlRWoD/p/D/yF0arSRI9/vr6l2orzYzN7QY/o8FlWAiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Wed, 27 Aug
 2025 04:59:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:53 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:18 +0800
Subject: [PATCH v3 6/6] firmware: imx: sm-misc: Dump syslog info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-6-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=7930;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=smAOw2LLys6Ccvgu3BgWXtBA5tydyCv6WOl3MxNr6AM=;
 b=q1ZH81UDMLxqzKFVWODbFCwpVs3RbMM57gpFgrqvVt4vu6nGzeHgNgaaORAMWtiUky+oby4f2
 4F+r8310M69DnH/9kdjo+2aGf5O9ElKjcnKVzGrpf4tmcqJ2ZAPYe+q
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 91820f7e-7aee-46f7-fc39-08dde5268f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0Q2bGJFakpkWFRyQ05DeXVaTkdPMlBydWx0RUM5U3FvNlZCcFJuOUVtbSt5?=
 =?utf-8?B?UzErVDlHT1FJZmw4VDFnZXBBZnFSMndYbExrNjYvbjJyK0VBc0x3TVhmZ1l5?=
 =?utf-8?B?bzBodGh5S1BYb0xpbEJubnAvUUl1Y2Fqci9WcXo5ZGJoZ1lzYzBYYTBCR3pT?=
 =?utf-8?B?NTVMTjYxME0wV3pvSUZVeGI2RVhwQnV0WWNEems1Zm9HM21OT2hSci9RdFNi?=
 =?utf-8?B?VENyN2xqbWdHUjJrTjdHZTlUVTRieVozQmpSZzBHa2daeVVzWXN1S2ViZGFG?=
 =?utf-8?B?ejN4aWg4VGlna05DK1pOUFcrcDdLOEVHUUs1Y2VlQnl0N292eGlTU29LOVln?=
 =?utf-8?B?Q1R3SVY4dVpYTno0UDJtd2F5N2I3NlVKMzFMK1lISm9YNkhYaHBBRW9mK2RV?=
 =?utf-8?B?WWp3N1krZFhLbWw1MHV1a1pkVEkxL05ZdjZVU1pISlVqcWt1VGFyR1MyYWl3?=
 =?utf-8?B?SlpTUk5rRkd2QnF0ZTQ5V1FieDhET09jUy82OHFDdEMzNThYNUs2MDZuWHRT?=
 =?utf-8?B?RDQ1YTkrdEowaEVkNURueTZOUy9uTWR0SjFlRVIxaDR3ekMyVTcrMjVrdEhu?=
 =?utf-8?B?UVoxdVBWZTNIejFHcWZxRmFFQWtnMXp0VkYvT0JaUVQ2MkJOVUFSMlZyN09M?=
 =?utf-8?B?NmpvQncrQkkrdU40YUwvODR5a2pheXFuTVRFUjFtY2Nhb1FBU2lucUJRb2I2?=
 =?utf-8?B?ajdRL0tYYk0wTWw4ZzNiblJ3aDF5RUNqL0ltRDBBQk1pN01MMVhib2RWbEt5?=
 =?utf-8?B?UTRKKzlZc3NwUGd1TUxpZmo1RE9zZFhkYVRJU0gxRnJQb2JtSEtvQmcrSTJI?=
 =?utf-8?B?RHk5SnYwQzdJMUxNQXpZTWQ0dXJTa2lJWHFEVHBxbE1hOVd6WG1xbGE4bnQ2?=
 =?utf-8?B?bkZhSTYxSDJPNkpFT0ljL1NIYk9HNUlDTzYvbTV0aTQrZzZQcHVIVlVucnAx?=
 =?utf-8?B?cTlwVlNTa3lkYmtjUERBTzQxK0xPNlVhRUR3Z20rZTljUHdTMFBIblVMK3kx?=
 =?utf-8?B?a2ZOSElJaDFwWExLQkh5OHJuN3gvV3BtYXI2cnpFTFo1aFZJK09nM1JEc2pF?=
 =?utf-8?B?MWFSTlZuRWhMSHJSYVJ5b1lGVnJMcTNZbFU5NFM2R1RqNGl1WkJPcDM4b3dQ?=
 =?utf-8?B?VUdMMEMyOWNaT0F5SzA4dmI3VUFKUlB6clNQcWU3TW05Z3N0QnZwNVVjdENu?=
 =?utf-8?B?WGNzKzJPRkEwdmlaTGlEVGd6Zk5PV3JIVENkbFlQbE9qMWZYbVMvMWs5eHU2?=
 =?utf-8?B?VjVBV3cvQVBKZnhPYkxBekFXWW9TVkh1enhlNnBBeWtmWjRMMXBFT205cWpK?=
 =?utf-8?B?N2lXQ3F2Z21oWHphNGJRR1NNUDFTWHNiaS9nN29rNFczL0xwNTJRYThWNWFn?=
 =?utf-8?B?OHJ3dDBVbWZWYXF6MW1pdElmNUhPUFBnNXgrVFh1L0ovWWJWMmxpQ2tOTkZ4?=
 =?utf-8?B?Ynh3R3Q5QmFCWTE0UFBKZitzUWh0MGYyblBaaUlsZFNqc1NXRzZVQWVjT0FR?=
 =?utf-8?B?Q2xQL2N0RzdWc3FlWlRqdEV3bE1jdVA3WHJxbFhIZTlVcG5EeldkZWRkTU9D?=
 =?utf-8?B?RC9XaWNTVWpGK0R2WkYyeDJNYm9sb0FqL2I3L25ldnRWdDhmRXNUdUZEY01F?=
 =?utf-8?B?eVVnRGRWSHBPNjFkeitPUjIwQmh0TG92eUZFeXdGV1NYdTJFU3gvMUFnSTEx?=
 =?utf-8?B?NkkyN1ZZSWd1K2dVbjJrdDJHRWJSallCT0FNZWtyckRYR1hBYVBMRVZ4MVBF?=
 =?utf-8?B?MHFySitDQUZSY0tFQ1gvVk1WMWVjUTNDTjlWcXVMSkV3bjdvQXdpRGhqdDNT?=
 =?utf-8?B?MkxrQXgvdkc5NXFtQTNMQVcrdzIyNzhibmdZUnp3Z3FTd3RMK0IxUXZuOGtq?=
 =?utf-8?B?aE9VQ0t0UFFOT2hhMmd5V1Vxb2poYWxocXk3Q1pNU2VESWN3dHhLQ1NSUXlh?=
 =?utf-8?B?aERFTDU0RXRqWXBjWlREbHoxd01LR2k3KzNBODFWc1o2ZGh6WEltaHNRWGhv?=
 =?utf-8?B?K1V6OTNrTE5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zzh5Q2VIRnU1WURUTzBSVSt3d2t6NHByWUwrQ0pUeEtPWE8ydSswMHBudEti?=
 =?utf-8?B?cDJjeDU2bXlkMVJJbUtNSGEyWHFUaWZ3Z2dEQlkrRzdpZ2RUdFJZa1RSdGFQ?=
 =?utf-8?B?dTlZL1FWQW50NkJLMCtia09seFJWUURrOW9mb0krWlU0OGNBcjZ6V3FpWW9m?=
 =?utf-8?B?RXp2dmp4OHRmeVJKR1FpbUJNMW9ZZFVqdVFyVFNBTWNWNCtZeFQvandPaTFC?=
 =?utf-8?B?MG5ZSmgza1E2MkFDVi9sSGRBQzNLZGRzeUtrSUtXaUdNbjhTdC9sRHErY3BT?=
 =?utf-8?B?dlZtQ292L2JUREFmUW9ZQWs5dmkwNkhMR1ZxK2x2UFVHcUl4QWtQbFhBSlNM?=
 =?utf-8?B?RHh0djZ3TERzblpKRXErbmxmM2Rpb05mSXd1UWRqbTRra21abmFScTZack5z?=
 =?utf-8?B?NGEwUzhVVmUyRFlSRzJaOTJuMXZMQ1JOYU9NMFhaTUR5ZHUzNEVQTzdLaHE0?=
 =?utf-8?B?RG92dTlwSVBybGJKUkx1UHNvTFVQU1dpZG5GeEVldDFtZ3dEZnpNK0xvOUZl?=
 =?utf-8?B?NkN3SW8xV0ZyRnJnS1YyTmQwYTVUWUdlMll1aDdPbERLbWhpeWNadTNRd2I2?=
 =?utf-8?B?dG53TGNXSWtqVWdGT055UU1OdnMyaTgxK2J6TWd5eE1YRm5pbE9NRjVENitv?=
 =?utf-8?B?dkRYZkx3UnBzYkNLNDZ0OTBxU1hESitnbXhOa3hWT1ZQb05nU0llM0xVQVVT?=
 =?utf-8?B?Nm42UnhvcEU3YlFtS1VoZXlBM0owdFhVZEdzZkI2TyszbWpqNmlsM2dDSmhQ?=
 =?utf-8?B?NFBHREtFS25ONk1zRkJCRTBvSGE3Ly8vY3pJdWIxK3JheVNVdjBLQXlHQjQz?=
 =?utf-8?B?OWxiaEg1MVlLNzNiZjRmTHhlUXJZcUtNblNRNGNHdGJmT1pHMnFLcjQ1cjRW?=
 =?utf-8?B?RlIwcUJKRStFZFFTdmpPb01MZEM0d1JzNVRTcU5nVUlSNVhSbUlVaWQ5RVNL?=
 =?utf-8?B?ZHFwUTFWMEY3V1J5UHB1b2syTnRja2JjQkRIWCt1UnlSSWFXTHdnMDdDck1x?=
 =?utf-8?B?aCthSEkwQk80Mk1CNm9qUGx3K2FKK3NSdHRSZHJscTFCVWM5Wi9PR3lOV05x?=
 =?utf-8?B?MzFkdXRjeDVJYXNPSWtPWjFLNjlTNGdENG90clBCYVVDMVJ6dGFOcUIvem5D?=
 =?utf-8?B?R1FCNkFOVnRPcXFUdyt6anRqdXRkcFI2dk56OVlpc0ZRMWE4RkF6cWd3TTRE?=
 =?utf-8?B?dnNKczJJbnlLRDUzUjRXUWhsamtRRkcyOEppQzl3Q1UzVGFjbzdOcFA4R3NR?=
 =?utf-8?B?ajhvTVNNUzhSeW9Damd0dGlHSmkvV2NWQ0xDeGs4K2tDUkVuWnlnMlpmL28v?=
 =?utf-8?B?d0krb1BSSk05VnR5cE90RDhMRHBtQWtqYVE5cVhwb3NlVTJsa3NOWlZQdVd3?=
 =?utf-8?B?L0VVRUlwQVdyNVprOTBIMEprOUNvWWIxNUhhU1R2cnNncThwbVhpLzZFbTlL?=
 =?utf-8?B?QmNJdXNaY2pJYzdwVkJZL1QxVWRuYUlNRHp4c2NPTFVqcmd4RTk1aFJ1WTBj?=
 =?utf-8?B?SGk4eTZRRXB6L3VIWVlzNUoydWhNbkVaeXVlYUZOMSt5UEptUkNSaGh4R01R?=
 =?utf-8?B?OVBvc0xrdG5UdUxpYkN6eGtZTjFlano4aU9lM05zbzZHa1hDQ0FDU0ZBdUlp?=
 =?utf-8?B?SStISm5FM0pyL1hnTmtxNTNCTzVjNFpSdEpSWWtYYlNUejFlNHVrR2hoT3NJ?=
 =?utf-8?B?Y2E2a1duanRRYkcwazB1TG91bFpKazVURXBTeitZZHd2bmgwVndKQm1xdUNL?=
 =?utf-8?B?YjRJSm1ZT3paN09pYi9najFVR05OZ2VTUnQ5RVlwNWRUUGdrTG9Lem0rZzhH?=
 =?utf-8?B?d0haa2g2eTFKVmEyTTI3RnB0N2lEdkwxWHI3SFNzeUpJb3hxZFEzRGlQTkhi?=
 =?utf-8?B?YTh0WVM2aXNDNXJQOHRFdU1NamFQQ0pzNzRQVm9YclZkOUxjUFhqZ0VOVTJD?=
 =?utf-8?B?QlpSbVJ1RkR1WWhGU1kwdnB5WUcyd0RVWDNvSXlPYWl1TXZOK014ekFpdWpn?=
 =?utf-8?B?eHVtOHpyMzEyVmZDT2tRZURacHZEZnJzdUZLdjJkVXVPZmp5aEZPaXpEMGw3?=
 =?utf-8?B?OEU1TlM1OTYvNjNFczgyUWFCbTE1QVoxcmx5eVl6SVZNWGplbEIyQ0ZpMldw?=
 =?utf-8?Q?4y00J6eErR3/2egfrTcu5USd8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91820f7e-7aee-46f7-fc39-08dde5268f71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:53.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u925if8JcZ/0EBSojHLZK573HyKC8Tne6FRvn9Dp9NbGbXQs4Z+vGMnBPY9ucYC448PbBel6B7YF8mihpKJokg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355

Add sysfs interface to read System Manager syslog info

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/sm-misc.c | 232 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/drivers/firmware/imx/sm-misc.c b/drivers/firmware/imx/sm-misc.c
index fc3ee12c2be878e0285183e3381c9514a63d5142..e742a2fff06b44ab7f07e9f97f723ef7ca1ff259 100644
--- a/drivers/firmware/imx/sm-misc.c
+++ b/drivers/firmware/imx/sm-misc.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/device/devres.h>
 #include <linux/firmware/imx/sm.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -44,10 +45,232 @@ static int scmi_imx_misc_ctrl_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static ssize_t
+wakevector_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, wakesource)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.wakesource);
+}
+static DEVICE_ATTR_RO(wakevector);
+
+static ssize_t
+syssleepmode_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, syssleepmode)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.syssleepmode);
+}
+static DEVICE_ATTR_RO(syssleepmode);
+
+static ssize_t
+syssleepflags_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, syssleepflags)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.syssleepflags);
+}
+static DEVICE_ATTR_RO(syssleepflags);
+
+static ssize_t
+mixpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, mixpwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mixpwrstat);
+}
+static DEVICE_ATTR_RO(mixpwrstat);
+
+static ssize_t
+mempwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, mempwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.mempwrstat);
+}
+static DEVICE_ATTR_RO(mempwrstat);
+
+static ssize_t
+pllpwrstat_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, pllpwrstat)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "0x%08x\n", syslog->syssleeprecord.pllpwrstat);
+}
+static DEVICE_ATTR_RO(pllpwrstat);
+
+static ssize_t
+sleepentryusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepentryusec)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepentryusec);
+}
+static DEVICE_ATTR_RO(sleepentryusec);
+
+static ssize_t
+sleepexitusec_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepexitusec)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepexitusec);
+}
+static DEVICE_ATTR_RO(sleepexitusec);
+
+static ssize_t
+sleepcnt_show(struct device *device, struct device_attribute *attr, char *buf)
+{
+	struct scmi_imx_misc_syslog *syslog = dev_get_drvdata(device);
+	u16 size = sizeof(*syslog) / 4;
+	int ret;
+
+	if (!ph)
+		return 0;
+
+	ret = imx_misc_ctrl_ops->misc_syslog(ph, &size, syslog);
+	if (ret)
+		return ret;
+
+	if (size * 4 < offsetofend(struct scmi_imx_misc_sys_sleep_rec, sleepcnt)) {
+		dev_err(device, "%s: returned truncated data\n", __func__);
+		return -EINVAL;
+	}
+
+	return sysfs_emit(buf, "%u\n", syslog->syssleeprecord.sleepcnt);
+}
+static DEVICE_ATTR_RO(sleepcnt);
+
+static struct attribute *sm_misc_attrs[] = {
+	&dev_attr_wakevector.attr,
+	&dev_attr_syssleepmode.attr,
+	&dev_attr_syssleepflags.attr,
+	&dev_attr_mixpwrstat.attr,
+	&dev_attr_mempwrstat.attr,
+	&dev_attr_pllpwrstat.attr,
+	&dev_attr_sleepentryusec.attr,
+	&dev_attr_sleepexitusec.attr,
+	&dev_attr_sleepcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sm_misc);
+
 static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 {
 	const struct scmi_handle *handle = sdev->handle;
 	struct device_node *np = sdev->dev.of_node;
+	struct scmi_imx_misc_syslog *syslog;
 	u32 src_id, flags;
 	int ret, i, num;
 
@@ -63,6 +286,12 @@ static int scmi_imx_misc_ctrl_probe(struct scmi_device *sdev)
 	if (IS_ERR(imx_misc_ctrl_ops))
 		return PTR_ERR(imx_misc_ctrl_ops);
 
+	syslog = devm_kzalloc(&sdev->dev, sizeof(*syslog), GFP_KERNEL);
+	if (!syslog)
+		return -ENOMEM;
+
+	dev_set_drvdata(&sdev->dev, syslog);
+
 	num = of_property_count_u32_elems(np, "nxp,ctrl-ids");
 	if (num % 2) {
 		dev_err(&sdev->dev, "Invalid wakeup-sources\n");
@@ -108,6 +337,9 @@ static const struct scmi_device_id scmi_id_table[] = {
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_imx_misc_ctrl_driver = {
+	.driver = {
+		.dev_groups = sm_misc_groups,
+	},
 	.name = "scmi-imx-misc-ctrl",
 	.probe = scmi_imx_misc_ctrl_probe,
 	.id_table = scmi_id_table,

-- 
2.37.1


