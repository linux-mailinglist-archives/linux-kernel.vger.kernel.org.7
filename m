Return-Path: <linux-kernel+bounces-811723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38AB52D08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E7456005C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0052E9EC1;
	Thu, 11 Sep 2025 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nE6tsW2Y";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="nE6tsW2Y"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023095.outbound.protection.outlook.com [52.101.72.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2201F63CD;
	Thu, 11 Sep 2025 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.95
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582439; cv=fail; b=GBkK45kOw0PPCOIB5iEEMe2lBT+Mc+0NxWVDpvfH7EbRVhIh37ar0qHhxJ80l7bczc1+m8OQPHEZ4At/mg8fu7ISj1ypHj8pg3FPGq2ivDsvv3BQ4oR3C/GWdbcbaxbyXUxUJnY3PmbxjuNxsc1qR2FaaslVVm5JP7U/LU1Bsjk=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582439; c=relaxed/simple;
	bh=E67u0SoTdnKBm/r8LBLKAGV3bDhBuBL2Z/q29c7skr0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y6Bs/ggupteO3ev7atBw0HWd+Bh0DycYRssiMhy/VkIyW47fW+YSJFQ4kIS6oCGODpQU0bS68BAB0FAWzusX87K7akSU8K3NwWjLK+WlWACa8o71b9VCCjrk1z6oFrIwNfpESf3FaSb60ChUncVdxpXHlFIFL2rsOxO+No9ykKo=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nE6tsW2Y; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=nE6tsW2Y; arc=fail smtp.client-ip=52.101.72.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tmXvsb1KN7pKUigShX1CEVbJ6IdfNlDy6wxHBDSOClMuf524jmqtyAkG/ekRMHdnP7Yz9+n9kHeqq6Smo7feLFNDarGYuCJaYpeRRzyxbHOcuQhRxkEGGs7jm/iLWrzb6rg5rQFwErl6CBjnOxpQkKQ3uAl/Wb3gLQSjbJVzSsuExbDpBdS16rNvVTZgFWzGK+NIcdQUQ4Mvm/Ch+zxvcJHEh0RCrYZ+DtLcIs9uP4fwr5+CeJQMrsVcqA4C33VLDGU4WeCTkPQVi7lR2pLVWiQ15Q9cXu2cuL86uon6SFQBM5JE43HdOW3diIcg5euLiOhiJk4SCGVN9wIcPwjJdA==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAhRTgTF9Ux0WfCRxdEh8hzIKgmDnz9OPcMPEmoTLg4=;
 b=u/EMYKYkoMQ3ViiG8yiKWb5OiJ422JMzW7OEIscWsltPlKb/NcIdPhEMd0+y4Gh+pMoxraymRmymI+tAJhDJ1fETrdoTSoZw7B4YpNU48TZ56wXSc1P17dy2w6hgOdZb0ML4LwkDy9VYAwQ7JC0rU8F6pMCjYUxwrtb3ChSHqwy4xtpg5EwZiXnqbFno5f/eq76yR7ay52Rua9FMB0ek/G6NLMFLiFDIUrLyYIImAgEshb1OyB5oMI1u/anCo1w0va85B/RAKRi3aT7oROULWGjamAJxpKFkrpgkw7ngDtklB1sztNflH2iOSzQ2qQIYuQxhgCYyBxyRalpUMY8tQA==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAhRTgTF9Ux0WfCRxdEh8hzIKgmDnz9OPcMPEmoTLg4=;
 b=nE6tsW2YC+9YBDpdeqbZFLXV40wY7MrR5AwYYJg4YmPG2AFSRPYXIaBIODMtjFNwMS4KTuA1f6JXvSfLiF7sxwraN8VuuqSqkOVAK4DKohyIZHSJ3aMuCmgXdVWaStRWMkMoa3o/kY2k8nkCqIDffHCVX/MhbbdLJuLxxPeuyCg=
Received: from AS4PR10CA0011.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::14)
 by PAWPR04MB11572.eurprd04.prod.outlook.com (2603:10a6:102:50d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:20:28 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::b3) by AS4PR10CA0011.outlook.office365.com
 (2603:10a6:20b:5dc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 09:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 09:20:27 +0000
Received: from emails-4377714-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-20.eu-west-1.compute.internal [10.20.5.20])
	by mta-outgoing-dlp-862-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 0344980524;
	Thu, 11 Sep 2025 09:20:27 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757582426; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=oAhRTgTF9Ux0WfCRxdEh8hzIKgmDnz9OPcMPEmoTLg4=;
 b=BRcqh7yiw/KySc4OR/NubUQzhdz98o/N3iKKcT/hUTVatCIKaVTFSzXh/4zkD2lx8N6kN
 mfn44isXC1hxz8B+GZZOU91WllTJFOKs48XFLpv9IrCq7BqLhsb2MZE0vIeubnQtFLwl7Es
 zTM+3d4xFDi0FxuHuPHY7kjab4dd9s8=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757582426;
 b=ZA4qXYJ0EkNhs8syw8k5lntQ25wwL27Q+Je10D796mZ7tgc2C3ydQa+x3jLvwUZZHOpYo
 8QL7piscsWPHv67iJUL0H6HiM0O70QA808m0u3MpsSOgHJ33r3IuW5JOARATA5pGNwy1sho
 /Afy1vk1jxrQwNTbqX8AVyw/N3broCE=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHc+UpV88CoV/AiXT4usZfBdk0goOc7Uys9IsTFzoOPlZX+O+S2rjj1VUER2d4ck4bDhwWp/aSU4K3MisLGWSArXrB37WX07UeiYLp+mfyMEadGXPAZXFdfLHx7/pip+Qad7KoE0ZllikGtNG9O9ExdqpBZ4GNnA8joqq4H4cMzvdXwiATCj4gBWwU1XClvBiumfgxrYG363YEeFTC4AW/K+qZaoOXvYLQt85exD2phRk8ZsfF5kqf3cbzEN6hmwmpU6+PJjNviNTVXjHpuHIUbCH+FW/jo5pDOHy1mqbAZs2gcyBd6zVJI7PgzoFWUemRFg1v+qAp+M9+DvQaf9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAhRTgTF9Ux0WfCRxdEh8hzIKgmDnz9OPcMPEmoTLg4=;
 b=zWWSeno2+Pt2KsGOg2MQ/J7/E5FSrDZP4DsScMjx12NPwPYgfBxGVwPaylyZcSW/ec4aMIpYFo2DwWYMEsGkKaAin2QGTOBBGz8PF5o7f3p113Vnb7nkxTnSmu0RMxmbfCfeb8zxepTJmSAnDv3PouGLO830RtaHX/SyKxLtYnrzqov2b7pKh+JMBjahEQm/KkoTfkCrJbBvpMbshyXFbFXL1Frvj1oUiiATiZV+NM0sYhi56Ok/oBFGZsvCShKT3vqjgungC8desaegws43+kjP5I/R60Ga5+TvGeTV/pH3/aVhg3eS5Vf7k/3BiQBr7+WL2xqV3XaUeqYLe1qaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAhRTgTF9Ux0WfCRxdEh8hzIKgmDnz9OPcMPEmoTLg4=;
 b=nE6tsW2YC+9YBDpdeqbZFLXV40wY7MrR5AwYYJg4YmPG2AFSRPYXIaBIODMtjFNwMS4KTuA1f6JXvSfLiF7sxwraN8VuuqSqkOVAK4DKohyIZHSJ3aMuCmgXdVWaStRWMkMoa3o/kY2k8nkCqIDffHCVX/MhbbdLJuLxxPeuyCg=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PA1PR04MB11454.eurprd04.prod.outlook.com (2603:10a6:102:4ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Thu, 11 Sep
 2025 09:20:13 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 09:20:13 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 11 Sep 2025 12:20:04 +0300
Subject: [PATCH v4 2/2] arm64: dts: add description for solidrun imx8mp
 hummingboard variants
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-imx8mp-sr-som-v4-2-1b1fae6135e0@solid-run.com>
References: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
In-Reply-To: <20250911-imx8mp-sr-som-v4-0-1b1fae6135e0@solid-run.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>,
 Jon Nettleton <jon@solid-run.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|PA1PR04MB11454:EE_|AM3PEPF0000A792:EE_|PAWPR04MB11572:EE_
X-MS-Office365-Filtering-Correlation-Id: c79b1faa-47bc-47c6-86f2-08ddf114722a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MWJYRndXQkExU25HM3FlRjNjMVgzRHpZbE1RZDR4UVd6aXZNMlMweWw5WkZN?=
 =?utf-8?B?M1V5NkFrT0hiLy9TODlaOTdYbTJudklRVDFDMXZlc0l1N2JaY0t6YVN4Y2N2?=
 =?utf-8?B?SVpBcHF6M29sb25BYk9uOFJHYkVtYVZESjBPQUVJYmwrY0V1YTU2VDQ5Nk9y?=
 =?utf-8?B?Zm5peCthNWovaUVJa2Z6THV2ZVFYc2NXSkVUYjlYeDBkRFZJVksyT1A2a3kz?=
 =?utf-8?B?QTl2VldoVnljdERaSmYySjN4VHpYNlNOaEptOC9ZMDNzTk5KVzU3NmJWeWs4?=
 =?utf-8?B?RE92VndNaHVoSmZGdUVLWU9hK3hLKzIzSllSY3NEWWZjbGdvWEp5c3h5YXdi?=
 =?utf-8?B?UUNVbDFpc0lrUlNHbW42UTVCdStSakZPYUk5RjRYOUVtU2V1eVlrMWtBTnJo?=
 =?utf-8?B?VkhpK0pyRXJpZU1SV0o4SWNXb1NpTmE1eFR5Unkvclh5S3NOeXV5N1BxOWhk?=
 =?utf-8?B?bVcrZVJCRXNlWWU1Vks2b0VtbzFlUEl6aHBDOGkrNjUya0RSVVZzeWFqbEVv?=
 =?utf-8?B?bHJnNGp2MUUzWmI0eGpRY1FVRWFqSUJTcFIxUlNWcWFwVGZzSkYrS0R5RG5H?=
 =?utf-8?B?OWF0YXlVY3paZXBiNkJ6cUZ1QkZadWlkQkN6Q3VRaFd2dEFqbGNxdWFYL0JK?=
 =?utf-8?B?ZnRvbGoybEExRmxPY0RIK2xuTlpsdjFOQTlEd2F4aC9CVTVRdXQ5Rkx5MVNn?=
 =?utf-8?B?U1EwMktFRVVoeFlRZm45TTV4WXpDblhuLy9uN0kvY0tBRDRlSkRiTE11ZjJ2?=
 =?utf-8?B?dEtNTHdWamdjSVdXNlZsY0psQURjWStrbWJyVXVRb2JPNk1BWnBrYWNDOHhy?=
 =?utf-8?B?OTA3WlNsU3NJVWhnQ2Y2NTF2OHlqTkEvQXpwN1N2Qm9JYnRucWlza1NkVWFU?=
 =?utf-8?B?dTdGclBxZUtWYlI1bEJOKzd0Y2IvUEZVaHc0SXVWOEhZd1J1bUVVR2FqRXc2?=
 =?utf-8?B?R0pHYmNUa081NHhwbmhKNW5HZ2h4QWZoV2xmVHBvZzh1YmdSNm9paEIyZE5z?=
 =?utf-8?B?YlNWM1VTejc1QytUUGZQQWhuU0VHcGQ2aHZLQ0djQ080eThocXFLSjJ5RWJn?=
 =?utf-8?B?ZytjVSt2bGJGUFJPclZKbVBWTy84TnJPdU84NHlodGtmNFZvTk10MXFOVURx?=
 =?utf-8?B?MXV5OExMa0FDKzhtNitDUFBUSDI1YzRKRktiS21LNFMzdlhPdGlxUm1sY0VU?=
 =?utf-8?B?eDdOTmU5WjlCaktmSVdXWG1nQU51MmhqdjcvYTcyazI0a3JNMXNicE5ZSFhq?=
 =?utf-8?B?VmY2Rys2ZHFaaGl1c0g2bzI5T1ZFVEVBb2ZOOGluS3BiS2tYaExwRUxIbC9x?=
 =?utf-8?B?Q1NhVnlLczZRQVpKUzJxMHVmd012aTFkOWhmbklXREF3MFcwOGtvRlE0VVhB?=
 =?utf-8?B?RmhiWDRrbUNOSmhKaFJxR0M2b3dzczBvZnlvQjNOaFBjUkphbTlCanEvTWJ3?=
 =?utf-8?B?QkpGZndrWUVpUE1KZVZDMVNqdnZjQjJkNGZ2dzAzTUNmQmRJZ2dSdktjbXYy?=
 =?utf-8?B?R1REaGtZNGM2Yk0ySDdZVTh0Z3A3WjlldWhCK0U0WHhSODZER0tmV0pjRU5z?=
 =?utf-8?B?TGxwZVFVZ3pQaHkvY2VqL1pRamY3TERwemgxWGI0dHdJYmJWNS9oVTd2QzZN?=
 =?utf-8?B?ZytQV2dzNzQ0VjNzanQxM1NsNFl4TStSSXhQbjVKb05EbUJDUmpwTlJFNVo4?=
 =?utf-8?B?VzNudHN6dXljQzUzOUFQVXBCejl2RUQxaC9Td3c3Y1NFSFduR2JDc0lpRm1a?=
 =?utf-8?B?VXFmN09RcHpNSkR3RGtXTEFHbFVtbjR4YXlMR1FpT2FmS1NDVW53ODVRZHZ1?=
 =?utf-8?B?NTVMNU9hRTltczVobFIyWUhDLzZMWXpqaHpwR3V5QmIzdm95a1FuaStXdmxW?=
 =?utf-8?B?cG5RN2ZoR1NCODhEWk43clpHcDlJQnlpSmNnd3QyNGs2OTVzNlBJSG8xbmpz?=
 =?utf-8?B?RHZZVVY4UVhRNTFYVk1OZWtEa0xBTlNiWldVWnhBR1RiSkpRR3VoMitQRm5t?=
 =?utf-8?B?a2xUbi92VjBBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11454
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8391fb3ce2274b1b9a36ea13b422a047:solidrun,office365_emails,sent,inline:b8d89f8fb7121b0514dafe3b1055ac44
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	60eb42ba-d89f-446a-b32f-08ddf11469d9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|35042699022|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UW5EQzdQTjBxU2lZNDNrT1liaW1YaWhGVWlIODRuYWFSU1AwMVdBVmtVQ0VL?=
 =?utf-8?B?OTF3N0pnY296YzZpZnU2VG4yYTZUM3ZNUnJLOTJiT3daaHhOZ0lzSzU2Ynho?=
 =?utf-8?B?d1V3Mk4vcnZyWklnb0N0WWlweCtua2R4OGZwVTFOdG9HcmFpbCtOM0FuS0Mr?=
 =?utf-8?B?TDB4ME1td2dXeGI4dmg5M0RmNFgrdk1XQkxaaHhsOHF2ZktGaythVm1PSVNk?=
 =?utf-8?B?Zzh1T3JML3NwTWN0M2dtSTQ2MkpXKzgxRUZsa1pSdm5LSStyTzFlYkUwUWpT?=
 =?utf-8?B?eFpoOUxFNUtSeTNKM1FGOXhLVVNmVGFpRndKU0xxeERlNTRBUDhGMVVvb09O?=
 =?utf-8?B?eE0zQ0FVQ1picWFTSUFJeWhLaW05U3FFOHRjZHdDWXVnZ3Z3TmlpbWFFalhx?=
 =?utf-8?B?ZjZpRlFFQmdpZFcweldpWXFVZE42TGZyNjVtTm9rWmVNcTFFd2s4bzF0dHRt?=
 =?utf-8?B?VWp1Sk5UejFBb1pnNjQ2Zng0YVBRZno2d1dlT2lvOWtLSXFVRG9RZlc4NUEw?=
 =?utf-8?B?MisrVUJCdzZ6VFZGZ2J2TEZHOG5sV25RYk9EdDU4ZEdTazBSYkI1eW9ybFN4?=
 =?utf-8?B?WUw1TklBK0xiMWRGQktHZ0tOeWd3akF2SUVhNi9JVlNjc2VEVDRYOGZhMHQz?=
 =?utf-8?B?S004S0pCZWNJbVhKd2RBdlpUTlhDaXZKMkFQdzkvS1hhUmo5OWYzRjhBbkEr?=
 =?utf-8?B?RHNyL2V4a1hsOVFkbUhRQmdzRXEwQTI0czJiRHZRckY2Z3hmNVcvV1Z2dXVi?=
 =?utf-8?B?VG9KOERmUTdGa2VnanNQc3VGZ21wTkJ4U0lGcGo3aWw4bjk2Zi9mU2ZnSDJ0?=
 =?utf-8?B?aGNBUkxHcWpYSnRnb0haTUxQYVZCOE8wcDBKMDlZM1FidW1nRVZ4dFV4QzlK?=
 =?utf-8?B?MDdlb0lWa1M4aEhqRjE5bGtySmM3NHVlVVdXdktlN1kwdzBQdEtRMmtvdzhF?=
 =?utf-8?B?eDdoME50clpZYVcrMEhBU3VXKys0VlNRZi8zRml5cjBLdHVKbWJyL21vMjhI?=
 =?utf-8?B?c2RJNjB0VkZtNExKbjE3ZC9LL3ZWODE5QnBiRHZyUjhlYTFIVHpsZ0VIZGt3?=
 =?utf-8?B?dHBZNWR2Umt5dWNjeFdrRGR5OXk2ZXhrTk1mWFJja04xTHVsSXhDQWhCcUdC?=
 =?utf-8?B?aG44eEV0ZnAyem5sWWxINGZ2SE1Zd1A4cFBPa29NWVlUUnNXY2tzaXJXSHFR?=
 =?utf-8?B?M01hTnV3ZGxyYmFZZ2M2OU01R3dSSUxXcStNQ2Fsb3ppQ1VVSGVXSStFU1Fl?=
 =?utf-8?B?ZVZYb0E5QkxNRnVxM1I0OGZLcWRyaE0veXl2WTR6WkJLU0hZY0tzcWRxbjhn?=
 =?utf-8?B?U3ZLWk04MlcrMUxCTDRra3l2emlXT3hTTUEwQ3ZuSkJOWjFVd0tCV3pUNXN2?=
 =?utf-8?B?UmliT1VBaUpEemhGRTNwaFRDK09Pa2dLMlFzNFAwVFgwVWIxcVlOc0xZT3pn?=
 =?utf-8?B?TmhzbDhrR2pQd24ySWwzVnFKUnFGNEptakZuYnlINlVHdzhvWlhiUXZoSnJu?=
 =?utf-8?B?NndyMnMxWldyemJuQllzK3FXTXIydlZLVDZtd0M2T1VmU3RJdFQyTGlrZHF3?=
 =?utf-8?B?UlV1RHJXdm5BSk9JNVI0QmVsT2lOaFRmbm9hZ1Bmc2N3bUhSLysvOUFOSTYx?=
 =?utf-8?B?UEhRVmVsT1BpOGJpbjUrMllWSmNtSzhjYVJ3NCtLUXZTWVhsb3F4RGovYllW?=
 =?utf-8?B?NGtIMDBNTHpYcHU0d2ZBdGpucjM1TkR3YmpJWDZQWFN1b1g2azJlUWx4dFdl?=
 =?utf-8?B?eVdUTWJtcmpBZ2QrbEFrUWtJeXVIS2NSUExWUGFQcm85Y3R2Mi9QM3hzblRZ?=
 =?utf-8?B?Z2c5VytnTFpjOUlHQzNiRFBOWHczdmRJRmtlK2I0YUlSa1FodHJxL2xIRGlS?=
 =?utf-8?B?NG5hWkRRUW1zV1BsYU42bE8zSEVhYTh0ZmJDK0E3citWRHdSTzdJQ1BHS0da?=
 =?utf-8?B?L25MUGR6aWx0LzlGMlczQkpKRnZtQjFBZE1SWGhtYXVYTUhlOVdoTlRwMTRl?=
 =?utf-8?B?bGpHNENHZTQwd1Vsb2dEN0ZoOVZiTXcrSmNxWGkxMUtKTTVlT291bXdKT09F?=
 =?utf-8?Q?LLM3p/?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(35042699022)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:20:27.2607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c79b1faa-47bc-47c6-86f2-08ddf114722a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11572

Add descriptions for the SolidRun i.MX8M Plus System on Module based
HummingBoard product-line. They share a common designed based on the
"Pulse" version, defined by various assembly options.

The HummingBoard Pulse features:
- 2x RJ45 Ethernet
- 2x USB-3.0 Type A
- HDMI connector
- mini-HDMI connector
- microSD connector
- mini-PCI-E connector with SIM slot supporting USB-2.0/3.0 interfaces
- M.2 connector with SIM slot supporting USB-2.0/3.0 interfaces
- MIPI-CSI Camera Connector (not described without specific camera)
- 3.5mm Analog Stereo Out / Microphone In Headphone Jack
- RTC with backup battery

The variants Mate and Ripple are reduced versions of Pulse.

The HummingBoard Pro extends Pulse with PCI-E on M.2 connector.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/Makefile             |   4 +
 .../dts/freescale/imx8mp-hummingboard-mate.dts     |  31 ++
 .../boot/dts/freescale/imx8mp-hummingboard-pro.dts |  76 ++++
 .../freescale/imx8mp-hummingboard-pulse-codec.dtsi |  59 ++++
 .../imx8mp-hummingboard-pulse-common.dtsi          | 384 +++++++++++++++++++++
 .../freescale/imx8mp-hummingboard-pulse-hdmi.dtsi  |  44 +++
 .../freescale/imx8mp-hummingboard-pulse-m2con.dtsi |  60 ++++
 .../imx8mp-hummingboard-pulse-mini-hdmi.dtsi       |  81 +++++
 .../dts/freescale/imx8mp-hummingboard-pulse.dts    |  83 +++++
 .../dts/freescale/imx8mp-hummingboard-ripple.dts   |  31 ++
 10 files changed, 853 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86050b50d7046f161b4256cc43f6d434a602b662..525ef180481d331e9c4decd092b7b831c497b67e 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -206,6 +206,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-mate.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pro.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-pulse.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-hummingboard-ripple.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-kontron-bl-osm-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
new file mode 100644
index 0000000000000000000000000000000000000000..00614f5d58ea9de51aad9a5f36212dc3d4f3ecaf
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-mate.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Mate";
+	compatible = "solidrun,imx8mp-hummingboard-mate",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
new file mode 100644
index 0000000000000000000000000000000000000000..36cd452f1583987a1e826d33798d9aecaaf21568
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pro.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pro";
+	compatible = "solidrun,imx8mp-hummingboard-pro",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &fec;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+};
+
+&pcie {
+	pinctrl-0 = <&m2_reset_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio1 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
+
+&phy0 {
+	leds {
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/delete-node/ led@1;
+	};
+};
+
+&phy1 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..77402a3db9ef8747358e847daa9788f6c82c8df9
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-codec.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-wm8904 {
+		compatible = "fsl,imx-audio-wm8904";
+		model = "audio-wm8904";
+		audio-cpu = <&sai3>;
+		audio-codec = <&codec>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"AMIC", "MICBIAS",
+			"IN2R", "AMIC";
+	};
+};
+
+&i2c2 {
+	codec: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
+		clock-names = "mclk";
+		AVDD-supply = <&v_1_8>;
+		CPVDD-supply = <&v_1_8>;
+		DBVDD-supply = <&v_3_3>;
+		DCVDD-supply = <&v_1_8>;
+		MICVDD-supply = <&v_3_3>;
+	};
+};
+
+&iomuxc {
+	sai3_pins: pinctrl-sai3-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__AUDIOMIX_SAI3_MCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI3_TXC__AUDIOMIX_SAI3_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI3_TXD__AUDIOMIX_SAI3_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI3_RX_DATA00	0xd6
+		>;
+	};
+};
+
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sai3_pins>;
+	assigned-clocks = <&clk IMX8MP_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+	clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_IPG>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>, <&clk IMX8MP_CLK_DUMMY>,
+		 <&clk IMX8MP_CLK_DUMMY>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..825ad6a2ba14ec5530b9c317cf3d749a8b5022ac
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-common.dtsi
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+#include <dt-bindings/leds/common.h>
+
+/ {
+	aliases {
+		rtc0 = &carrier_rtc;
+		rtc1 = &snvs_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins>;
+
+		led-0 {
+			label = "D30";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-1 {
+			label = "D31";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-2 {
+			label = "D32";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 23 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-3 {
+			label = "D33";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		led-4 {
+			label = "D34";
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+	};
+
+	rfkill-mpcie-wifi {
+		/*
+		 * The mpcie connector only has USB,
+		 * therefore this rfkill is for cellular radios only.
+		 */
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mpcie_rfkill_pins>;
+		label = "mpcie radio";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vmmc: regulator-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc_pins>;
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <250>;
+	};
+
+	vbus1: regulator-vbus-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus1";
+		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus1_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vbus2: regulator-vbus-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus2";
+		gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vbus2_pins>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	v_1_2: regulator-1-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	vmpcie {
+		/* supplies mpcie and m2 connectors */
+		compatible = "regulator-fixed";
+		regulator-name = "vmpcie";
+		gpio = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmpcie_pins>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+/* mikrobus spi */
+&ecspi2 {
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_spi_pins>;
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>;
+	pinctrl-names = "default";
+
+	mpcie-reset-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "mpcie-reset";
+	};
+};
+
+&i2c3 {
+	carrier_eeprom: eeprom@57{
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+
+	carrier_rtc: rtc@69 {
+		compatible = "abracon,ab1805";
+		reg = <0x69>;
+		abracon,tc-diode = "schottky";
+		abracon,tc-resistor = <3>;
+	};
+};
+
+&iomuxc {
+	csi_pins: pinctrl-csi-grp {
+		fsl,pins = <
+			/* Pin 24: STROBE */
+			MX8MP_IOMUXC_NAND_DATA01__GPIO3_IO07		0x0
+		>;
+	};
+
+	led_pins: pinctrl-led-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22		0x0
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21		0x0
+			MX8MP_IOMUXC_SAI2_RXD0__GPIO4_IO23		0x0
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24		0x0
+			MX8MP_IOMUXC_UART4_RXD__GPIO5_IO28		0x0
+		>;
+	};
+
+	mikro_int_pins: pinctrl-mikro-int-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09		0x0
+		>;
+	};
+
+	mikro_pwm_pins: pinctrl-mikro-pwm-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08		0x0
+		>;
+	};
+
+	mikro_rst_pins: pinctrl-mikro-rst-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXD__GPIO4_IO30		0x0
+		>;
+	};
+
+	mikro_spi_pins: pinctrl-mikro-spi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SS0__ECSPI2_SS0		0x40000
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK		0x82
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO		0x82
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI		0x82
+		>;
+	};
+
+	mikro_uart_pins: pinctrl-mikro-uart-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+		>;
+	};
+
+	mpcie_reset_pins: pinctrl-mpcie-reset-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__GPIO1_IO01		0x0
+		>;
+	};
+
+	mpcie_rfkill_pins: pinctrl-pcie-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO05__GPIO1_IO05		0x20
+		>;
+	};
+
+	usb_hub_pins: pinctrl-usb-hub-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x0
+		>;
+	};
+
+	usdhc2_pins: pinctrl-usdhc2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x190
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d0
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d0
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d0
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d0
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d0
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_100mhz_pins: pinctrl-usdhc2-100mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x194
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d4
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d4
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d4
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d4
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d4
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	usdhc2_200mhz_pins: pinctrl-usdhc2-200mhz-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x196
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d6
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0		0x1d6
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1		0x1d6
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2		0x1d6
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3		0x1d6
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT		0x140
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B		0x140
+		>;
+	};
+
+	vbus1_pins: pinctrl-vbus-1-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__GPIO1_IO14		0x20
+		>;
+	};
+
+	vbus2_pins: pinctrl-vbus-2-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		0x20
+		>;
+	};
+
+	vmmc_pins: pinctrl-vmmc-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19		0x41
+		>;
+	};
+
+	vmpcie_pins: pinctrl-vmpcie-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x0
+		>;
+	};
+};
+
+&phy0 {
+	leds {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* ADIN1300 LED_0 pin */
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+
+		/* ADIN1300 LINK_ST pin */
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			default-state = "keep";
+		};
+	};
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* mikrobus uart */
+&uart3 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	fsl,phy-tx-preemp-amp-tune-microamp = <1200>;
+	vbus-supply = <&vbus2>;
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy1 {
+	vbus-supply = <&vbus1>;
+	status = "okay";
+};
+
+&usb3_1 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	dr_mode = "host";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb_hub_pins>;
+
+	hub_2_0: hub@1 {
+		compatible = "usb4b4,6502", "usb4b4,6506";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb4b4,6500", "usb4b4,6504";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&v_1_2>;
+		vdd2-supply = <&v_3_3>;
+	};
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&usdhc2_pins>;
+	pinctrl-1 = <&usdhc2_100mhz_pins>;
+	pinctrl-2 = <&usdhc2_200mhz_pins>;
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	cap-power-off-card;
+	full-pwr-cycle;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..d7a999c0d7e06a8c47a61632a59eb97faea9e3d4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-hdmi.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&iomuxc {
+	hdmi_pins: pinctrl-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x400001c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x400001c3
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x154
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x154
+		>;
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..8d8d8d2e3da8ab486eb82ad72db7be875fed4929
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-m2con.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	rfkill-m2-gnss {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_gnss_rfkill_pins>;
+		label = "m.2 GNSS";
+		radio-type = "gps";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
+	};
+
+	/* M.2 is B-keyed, so w-disable is for WWAN */
+	rfkill-m2-wwan {
+		compatible = "rfkill-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&m2_wwan_rfkill_pins>;
+		label = "m.2 WWAN";
+		radio-type = "wwan";
+		/* rfkill-gpio inverts internally */
+		shutdown-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	m2_gnss_rfkill_pins: pinctrl-m2-gnss-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO07__GPIO1_IO07		0x20
+		>;
+	};
+
+	m2_reset_pins: pinctrl-m2-reset-grp {
+		fsl,pins = <
+			/*
+			 * 3.3V domain on SoC, set open-drain to ensure
+			 * 1.8V logic on connector
+			 */
+			MX8MP_IOMUXC_GPIO1_IO06__GPIO1_IO06		0x20
+		>;
+	};
+
+	m2_wwan_rfkill_pins: pinctrl-m2-wwan-rfkill-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO13__GPIO1_IO13		0x20
+		>;
+	};
+
+	m2_wwan_wake_pins: pinctrl-m2-wwan-wake-grp {
+		fsl,pins = <
+			/* weak i/o, open drain */
+			MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12		0x20
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..46916ddc053355b6708629898fa13e55c6493cc2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse-mini-hdmi.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/ {
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "c";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	hdmi@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>, <0x3f>, <0x3c>, <0x38>;
+		reg-names = "main", "edid", "cec", "packet";
+		adi,dsi-lanes = <4>;
+		avdd-supply = <&v_1_8>;
+		dvdd-supply = <&v_1_8>;
+		pvdd-supply = <&v_1_8>;
+		a2vdd-supply = <&v_1_8>;
+		v3p3-supply = <&v_3_3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mini_hdmi_pins>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				adv7535_from_dsim: endpoint {
+					remote-endpoint = <&dsim_to_adv7535>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&iomuxc {
+	mini_hdmi_pins: pinctrl-mini-hdmi-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27		0x0
+		>;
+	};
+};
+
+&lcdif1 {
+	status = "okay";
+};
+
+&mipi_dsi {
+	samsung,esc-clock-frequency = <10000000>;
+	status = "okay";
+
+	port@1 {
+		dsim_to_adv7535: endpoint {
+			remote-endpoint = <&adv7535_from_dsim>;
+			attach-bridge;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
new file mode 100644
index 0000000000000000000000000000000000000000..d32844c3af05bdee2e56f60670244738063a4ff4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-pulse.dts
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-codec.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-hdmi.dtsi"
+#include "imx8mp-hummingboard-pulse-m2con.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Pulse";
+	compatible = "solidrun,imx8mp-hummingboard-pulse",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		ethernet1 = &pcie_eth;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&gpio1 {
+	pinctrl-0 = <&mpcie_reset_pins>, <&m2_reset_pins>;
+	pinctrl-names = "default";
+
+	m2-reset-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-reset";
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&hdmi_pins>,
+		    <&m2_wwan_wake_pins>;
+
+	pcie_eth_pins: pinctrl-pcie-eth-grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28		0x0
+		>;
+	};
+};
+
+&pcie {
+	pinctrl-0 = <&pcie_eth_pins>;
+	pinctrl-names = "default";
+	reset-gpio = <&gpio4 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	root@0,0 {
+		compatible = "pci16c3,abcd";
+		reg = <0x00000000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		/* Intel i210 */
+		pcie_eth: ethernet@1,0 {
+			compatible = "pci8086,157b";
+			reg = <0x00010000 0 0 0 0>;
+		};
+	};
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
new file mode 100644
index 0000000000000000000000000000000000000000..4ce5b799b6abc514ca00e2e2134d5ff1606dc87d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-hummingboard-ripple.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 Josua Mayer <josua@solid-run.com>
+ */
+
+/dts-v1/;
+
+#include "imx8mp-sr-som.dtsi"
+#include "imx8mp-hummingboard-pulse-common.dtsi"
+#include "imx8mp-hummingboard-pulse-mini-hdmi.dtsi"
+
+/ {
+	model = "SolidRun i.MX8MP HummingBoard Ripple";
+	compatible = "solidrun,imx8mp-hummingboard-ripple",
+		     "solidrun,imx8mp-sr-som", "fsl,imx8mp";
+
+	aliases {
+		ethernet0 = &eqos;
+		/delete-property/ ethernet1;
+	};
+};
+
+&fec {
+	/* this board does not use second phy / ethernet on SoM */
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mikro_pwm_pins>, <&mikro_int_pins>, <&mikro_rst_pins>;
+};

-- 
2.51.0



