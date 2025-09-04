Return-Path: <linux-kernel+bounces-800543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43162B43907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F373561486
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC492FB609;
	Thu,  4 Sep 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LY5WjsIi"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DA2EDD7D;
	Thu,  4 Sep 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982509; cv=fail; b=ewf7mOtrfojSpIJzG3nbTf+JCgpuRqX7wgePkAv2IlRN3+Jwv/Xtnb1iijpJ9wgusgdm3KjhL4zj5R85xe5MuNSzNhosPC3deyaoKKRPUsqB1VwShTz4xsJi2PBdQVtSx6/k8aPnVyKITdVXI0y9I0vnx5GmqZXBoawQFbHTtUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982509; c=relaxed/simple;
	bh=xr66WlM/i6ZxRR+YLoOC5w8DE7bxk8AcS//7Cwh5Bec=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TlYwCQQ9aKhk28tZ66wpaOOEyCT9VbdikByzwmj4aCFg+V0itlkK8PRRQfk95wKaLYVoC9qlimUUpUhNdLn++zkVxa2n37pLO5bnjJBPnRngav4dkEZlHkK9+H5fSO/e/xJMr+T7tQPlgM9QyxI6/q+0X0hiPSg6cQbgiOy73ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LY5WjsIi; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmzf+sYw0OXaCwKAX22FuBUhdzX7EY37tp9bBfJmqLbzSNJ3hDtGvdKgErrtBK05MoOCv+ZRUN9JycYYxH6Jly/y3POJ3B8WM4wkMor0AG0D9H67CAtZv/oOkiFLRziuf/+Tqb9dy5JbyUZH2tjD8MJ0xr5SFFgYtqfhIohDuZK6Vh+1jAXkj7MXd0wh0J0ZfRiO6rDKA9F8DpgxbZjmKZBthXD9eXWLDQM856CM0LTDOZLwKJJqbh2k2cgyiFO5leEQe3pmVZhpZg3KBDF2zZKKRteFjEucUFNNuAa60j/TVxDeBKy43inv0agQ35FYv33MmZ7iMfajQ9KUqhn81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWWa4Xl9jZ50sxnDK5ree5jtQjya/+PhxeKyRjsEl6Q=;
 b=CNB2vld4Sds3N9tX+Hh46NILNUIAuC3NjvsAQ/q+vKb4cNprq9Q/KhGMj9Y78u2wodrfHPVHpUnHmRaNwy6H+BFytwFY+fi+DRmdQlQiA3JwTQkNl9V34NkLq8ziKMPrSE+DmCtMOQY9oylq22862HDf2GWvAVW1QZyABxBLnsqlaaSAgIs2U0A7jPygSfuYAga5JDKJz3B9+gET9M6+0EAPt2Rl8+SFy4/RPWIIrP8u/g/XesVqIkuMC/VlJWHllf0KWMWpDDISha7lM90mAbBe25JsH0hVj5woJdO73Fjvh/SocgCxY7+S7Q7KZf/+/UezkpURa2V18BerxbM4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWWa4Xl9jZ50sxnDK5ree5jtQjya/+PhxeKyRjsEl6Q=;
 b=LY5WjsIio7w3mH2c+OGboVZXdSWfapB9l59eweP0StMm8Y89T2rqlH/ryOeWGSopesy0lRKuZkj24vbfeR21JNbqzKJhdBzTj52pu2Art/om3EIhV5zKm9igvjfb72/O76RSHaYEWIGAVz43uSIBC9/BbCIn3tJfs1pteyhZ6WK+X56cE8oiaDhSmPXdYHTf6bBpec2xn8NfydNsb791sjma4DoN+VrE7Y4HXiU+2pijIjPJOHtUrAq8iHWO5TzwxI0MEXGhUkywzINlAw14hCX9BAPPSol98haZP6jwfeeRgXwa/TUMPENF1GHaHb1qepp/CribJsvqdlraHUAEkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:44 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:43 +0800
Subject: [PATCH v4 2/6] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-2-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=2702;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xr66WlM/i6ZxRR+YLoOC5w8DE7bxk8AcS//7Cwh5Bec=;
 b=fuiUD8taNk8YBKghPJXu7v0Y/2sUF1cnweIsLYj28n3w+DRyQQvVFCjvxVrOicLny+TqtnxxW
 pFZCk9WQYhfCtXhXz2xH/o4Supv4vmIgEqUq1kHXlOOj/WZUJLj7HHX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ea1b0d-b391-4dfa-173e-08ddeb9fa3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkYydFlRNWRuWHA5eGp6cjJMZ0RFdEcrYkJvcGd2K0FZanZrdVA3TUVXcXNB?=
 =?utf-8?B?WENtTzFkWHJaYndIdmRCZGdBTk4weWJBVlZmc0ZXRGNkMVlQbFNHcWs5Y21E?=
 =?utf-8?B?a3hJT2lCbEc4V3dDQ3lxeGVNZElCaDZPbytQYzBEcFhMNlJMbGxuZTduaDNx?=
 =?utf-8?B?dXczM0loWXRia2s2SG5NWEdXTzhxb3FxOVhHK2sxMUJsa3pxSzdLMDNHQVMy?=
 =?utf-8?B?VHVjbnk4ckNmZENhd0ZoZHFoQ1huOXhqTXlIYnBvbG1PNzRQeWM2WDBuemd0?=
 =?utf-8?B?UzgyRzJkeHRhQUdFRGlXYnk4YVhjdllEdXpKY1VUQUs4QmdMeTNxMzJMUTR6?=
 =?utf-8?B?SG9YaGQxcktJWjhkU2hqNEdHY25Ec0hMeFRHS0VKVm9nRG5LTkhkYUxQQVVY?=
 =?utf-8?B?UmI0RisvVEsxNUpxYThydHF4dzlSZXZxY0kyVUx4b0ozYU80YlRhWGdHcjV4?=
 =?utf-8?B?MWRDck1kL1ZYdjk1SVM0TW1oMGtuUE1tSm1vRWV2cEVJcWhoWURxbXRlMUZM?=
 =?utf-8?B?OUNmNVJRV2xBbnVmNDJDeFdIaFFKZ1ltM1czZloyakVZY0o5eFRnWVEyRkcx?=
 =?utf-8?B?Y3EwejJRVmZjUU5TRUJ4SFFRblVZK3I3a1ZqaDIzMzduM1UzNE9kZm5mcmpG?=
 =?utf-8?B?RUtYcnIzS0cvT1NNcit4V0ZrU29URmRyVnVCOVRlSTlicnFja2lvUnBRN2VO?=
 =?utf-8?B?SllXS0RlVTVwbUlNK3RUSm5YRDhORnMxV3lSL3NtWVJnVXM3SlI3ZnVjWU1Y?=
 =?utf-8?B?QU5IWHU5c1V5NFZ5c1FhM2pndnNBY3dYUWczblBiNmJ4N0ZNNVNPbkRPdXBm?=
 =?utf-8?B?TnVHdG9UaDl2eW44c2JaTXE5RVU0cWhoM3JrVG5reGlJdjJIeXBIZlhQZ2Zq?=
 =?utf-8?B?MTVaaUJ0b1djcFVGcjRhdFg1WmJhZDNXaUpGaVVGYUVMVklpNlFUWFUzZUJq?=
 =?utf-8?B?M2pwcUowM0J5ZXFtTlZRY1RBYUZPOUlXcEZqcTZwVWtvcUtZeXQwd1JVdldL?=
 =?utf-8?B?R3F6Snh0MHdhcFB6dEozbnpab09MalY2czUzVnRwbUswaE0vU3kxbTZCeWZF?=
 =?utf-8?B?MVB2WDdmaGVBNnRUSTdlbTBreVdUWGVid2ovLzRmRjhvYmIweDJxT2xrdlFl?=
 =?utf-8?B?emdwZ3pvTjRJV2Jlc1BXV1hjR3VPY1NOK20yZ0dqQ3Arem5lS2dNWWNUbkpp?=
 =?utf-8?B?blMvUzRVakVER3p0L2NnblNpZGZ4Q0hwZ1hmTTEzd3VFK3RzZitjVVVTcFg2?=
 =?utf-8?B?WUtLRm1hdzlUaU16WW16V3FaZ2N4V1VkY0JJOXVzTXJPZkV1dVNES3VHdXpY?=
 =?utf-8?B?RUVtZHdUUmVFRUtVR0V0ekpVRk81aWd3VEJ5SmR0dVpsb1YwMXhhSlJJOTV4?=
 =?utf-8?B?Mmhib2prZlQ3b2JwVkVtN1VvbDViV011MDhsUlhNUTFwZVVpbklGL0l5ZjIz?=
 =?utf-8?B?bWtCczZQbVlCcUp5VHptTzRydk53aDR3VkNvT2JEL0gxcXF1MHArS2l4MWFK?=
 =?utf-8?B?RG5iWW8vUzJNcjRjc29pMXZGNEx5bEJLYjBKVXArQlRGeVdFbVB5TjNPMDZh?=
 =?utf-8?B?N3dZVWlFN3VnY1F6OVNpdU8yNzZFYlBxVEJvUXoxcmtNa0x0QVE1NnFvSkRu?=
 =?utf-8?B?UVF5WDF2TjVrclRHU3lJSGV5ZEtiZGI0eWxoL3l6ZmNhUWdNb1BhWk8yTW15?=
 =?utf-8?B?MmJKd3NHYmo0UDhZVGtyaUFxekpnOHo5QTAyRjY2NjBKa1pyT1VTYkhsdDlQ?=
 =?utf-8?B?dFVub3hLeXlLaCtrT3dpQkQ5R1F2QVc2WDlUZHN3aTR6aWtOdFl0bThoZVdq?=
 =?utf-8?B?V05GdnNUVzBDNHdkQitlNitoTlNqZFhTVU9lSDNncUVHT3p2cisrK2JCKytM?=
 =?utf-8?B?dklkbkc4M2ZCZkhRODJWMmJaSFVTVFo0NE5ZNDNpbXN3N29NV2JyNUVrYzdT?=
 =?utf-8?B?SVIzU2RaQmVvblN3d3F2R2tWR0RLQ1cwTnE5RDY3Rk1KYk94amVyUWN1ckNY?=
 =?utf-8?B?MWhvUlZLMzRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlBmNW5IUnF3WW5OWVdEdjhpNlFKUVROWEVIeUtaMFBJbUpxZUtlTnQ0RUdI?=
 =?utf-8?B?STlqQy90RjdqNGtDaFlNbm5pUmdhblMzWVZuRExMcytma3Q3SDI0djE3RUJD?=
 =?utf-8?B?Snh0QXk5Ni91SDhVQzNjaUlHMHZZK1JBaXNERlNaYnEreEtNVXZReFdDWnlP?=
 =?utf-8?B?WW0rU003OE05Sm4ySEhBZGVNbi9MUVh2NWdwNTMxL3hZc1lvZlhRRkxZOUZ3?=
 =?utf-8?B?eEhMUEhPODl5ZzNJVUF1cnJnMzNGUUd0dWY3OU9yU0hWcUZSOFN2Z0R5bjVN?=
 =?utf-8?B?TjVneFNXYXNwUnludmlKSFFhMjVrcmlxYzBRSDVuWWdqTzJqcVJSNVFOb3lR?=
 =?utf-8?B?aVE0WTluUlp5WThlaEJSbEVRN01IWEhHUDJpVTdtWElYQnJuZ1hwUVBEb3Fj?=
 =?utf-8?B?ODlxZzNEdnpVaExUQjFRZ2hMM1MvUTBvaWo0K3ppNVoxOWFTaXNHQ3VOMU1h?=
 =?utf-8?B?eG5qeEVmVEVwanlWSnd5ZFVRUUNaRFZoa0RkNTQyajRKN05wcWhBajIrOXhB?=
 =?utf-8?B?Wk1wL3Vab1o0REtEeVVOc2NHcmJOa21USjZaeWdRWVlrUnlXZ25mUlNsUG9Z?=
 =?utf-8?B?NkRySDNWVGhtakYzeWhMbXdINjdXNUdmY0k2d2J0UWFSaUF2MXBrVXppa2xp?=
 =?utf-8?B?RDJ0aFArWjBMT1Awamh4NTFYM2FUT0NNVE84WGt0NWZLdVdGbEQ0R2sxNm9r?=
 =?utf-8?B?c0NoZFFxMlU3eE1NcllQNy8vTVRzR1VzU2ZaRlFTb3dWSk5LYTdDMHZWbHNI?=
 =?utf-8?B?TVVqYVovTGlqdzhlNnc5SXV6blo2RFRFdXcvbDdvUDN2QXlYeittM0txc3pq?=
 =?utf-8?B?d3VzZm5XL0ZMZGRNcFFtWVFNbjB2WGhWNHJCNmVabDBPTlJmSDA5aHU2dUFW?=
 =?utf-8?B?ckgvK1hJYlEvV1pwejl5OEljTGtIZ3RkSGVjdUMwemxnVXYvMTdsQmUzR1gv?=
 =?utf-8?B?Zkd4N2xqTmVZempRM0RPK1FJNVB6SHZ4NjJ0eHJhYnZoUGVrWWt4STVtR0tC?=
 =?utf-8?B?Tjg2bEgzdkpmSm9CK2ZKZ3Q3SGlKVG04MlQwNnJTcnU3TEphMWh5NlB4cGkw?=
 =?utf-8?B?TUJ2RmZwanNNSG1KVXA1c0pkRytTYWhzZjhjSDFhQ0lra1VNc2xsMm1GSFJ0?=
 =?utf-8?B?V0hub3J4VE1Hc1BqRkRUeHBDU2VtR2plek1GQUUzSGNzMk94UmovOWdhSXVW?=
 =?utf-8?B?cEZVSkF1bStuZ1Vad2xtdWtkV1ZDYXlMSzlLVFlMQ1NHQVF6OTM4RzJndE81?=
 =?utf-8?B?RXd3Wkg1SmxhWW4vZW56SkJaN1M2WSs3OU9FQ3cyZmJiMm9iSDdmQzdHbzl6?=
 =?utf-8?B?QUY3a0NBM0tLVWNPdDRHRFI2UkZMWDRUcFgxQnN4VXo4RTBMSU9zL2xBTkpW?=
 =?utf-8?B?VnFtWnpubXRaNXpvVUQxejZqckhaNm1saFdQTm9HMVp6U2tWTHFYQXNPdGtD?=
 =?utf-8?B?b01qTzdxM3JTOHZTZit3dGJvSVZvdkpCejAxc2FxZEdwNzNPOUlGRk5pQmRi?=
 =?utf-8?B?UFFpcDAvcGY5d1NHWGlRSFpIci9KRlM3UjBXYXVaM3pFNG1BM2FCdEc5eGxD?=
 =?utf-8?B?Zi9XeXlIUTJlaklnUURKV3N6TFlIbzI1VTlENm1XY0RJaGdqa29NY09UUmw3?=
 =?utf-8?B?SytCeDF3aUcrUFpjb3VqQTQxdG9WUzdTSllnUzZZaUN0SDRpQ00zdDNFTFdN?=
 =?utf-8?B?YU9vM0szcE1kRXBwSGxYdUJBYlFTd1pyQlpWZEhPbWl4cVJCVDFDbHk4QUkv?=
 =?utf-8?B?K0x6b1lYSGFCNHNMZGNkWG91S0ZLcFlpb3FvMzN3RGFETFdmUDZDSDdTRStk?=
 =?utf-8?B?UFFLOUZVWUd3YUVzc0s0QWM5aVFMc1lQclFhWkdoVUp6SXFrSUdjTXBPbmE2?=
 =?utf-8?B?ZWtSdDAxejVpRlBEV2o1NXdjQTluNGRHRlZHUWhtYldESnpZT1kxMmdhVTNz?=
 =?utf-8?B?Y0FBTTlqS1V2UVB6cHYrZG9MUHVVdnZqRzJseURmTWo1TDVSRmg4VkFCWU9k?=
 =?utf-8?B?UGxoNitTbXhzbCtZWWZUM1hUa1lRdjhlanRHRjFBd2lrTzJUVzEvQXZSUWV1?=
 =?utf-8?B?UWVYWUR5bWRUT3gyckpoNGYrOGpDVW1zZ0VGakNaOVczTy9uRlpwa0xwbVRL?=
 =?utf-8?Q?41YNh1T+tEVbMCf4Tn+2oPD9p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ea1b0d-b391-4dfa-173e-08ddeb9fa3d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:43.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq3tv3t49/D0vmSesSdikE3mJXxlqOGB0UFeOsD0xJ95sPqyNl+RJzUN5rACS6aShIYqL05sjRfzJAJ1lOW4lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653

MISC protocol supports discovering the System Manager(SM) build
information including build commit, build time and etc. Retrieve the
information from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index a8915d3b4df518719d56bfff38922625ad9b70f6..c2928bc89b001b288ee64565cec9da5668b56e7e 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -25,6 +25,7 @@
 enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_SET	= 0x3,
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
+	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -65,6 +66,15 @@ struct scmi_imx_misc_ctrl_get_out {
 	__le32 val[];
 };
 
+struct scmi_imx_misc_buildinfo_out {
+	__le32 buildnum;
+	__le32 buildcommit;
+#define MISC_MAX_BUILDDATE	16
+	u8 builddate[MISC_MAX_BUILDDATE];
+#define MISC_MAX_BUILDTIME	16
+	u8 buildtime[MISC_MAX_BUILDTIME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -272,6 +282,33 @@ static int scmi_imx_misc_ctrl_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_imx_misc_build_info_discover(const struct scmi_protocol_handle *ph)
+{
+	char date[MISC_MAX_BUILDDATE], time[MISC_MAX_BUILDTIME];
+	struct scmi_imx_misc_buildinfo_out *out;
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_DISCOVER_BUILDINFO, 0,
+				      sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(date, out->builddate, MISC_MAX_BUILDDATE);
+		strscpy(time, out->buildtime, MISC_MAX_BUILDTIME);
+		dev_info(ph->dev, "SM Version\t= Build %u, Commit %08x %s %s\n",
+			 le32_to_cpu(out->buildnum), le32_to_cpu(out->buildcommit),
+			 date, time);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -299,6 +336,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_build_info_discover(ph);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


