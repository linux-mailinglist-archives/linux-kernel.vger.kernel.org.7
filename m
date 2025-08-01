Return-Path: <linux-kernel+bounces-753003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BDCB17DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AFF3B5610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE44202C30;
	Fri,  1 Aug 2025 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kAq76dwc"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1214F9D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033639; cv=fail; b=B6RdBkgsvgttwwRSh1nY4FW0GUmj9RtUbIqZhheMcfKktOpm6kIHfC5lEW3GT6uMhHgRkHOl3CdohYz+WQzpg1kAUTjQjUAo2DlLHnQYy4oANK/l7pSrJy5XyDrxu91vRoGM1KgZeBEhF4MgtYLFjZCHEwzIzvzuPO93aRH89ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033639; c=relaxed/simple;
	bh=F9Dp6je2WrMRZJH6L8i5gBdn9bMHxjbhD0NxUkqh3LY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eOZukckw0SPWDyV+du9tq/kyoF8OWCg4AAv8ogDKS2M2NvA/72N8E/h1nHt35vuLTIumWOFLg4hgoW9MnI3DdUxev4hm71EMEiQuHxsiRkwIhnD//cXdN/69F1gDNUcvz6b+xa0+9v47Ndw38l/+ZiY6bC61BjHncRS9zlw0IxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kAq76dwc; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wF6Lzwd1S2S+0GNw9Yv5/78nSTvEdu/73PVI1tVGOk3kTIS0bvXoBztwD34y+ycDxMwnF4gZ9YrB1cMjRKqBEfVZ+QvdekKRReZ1hyzjLghWR1+rcxVPYwA9sDMObIrx+o21zMlpa64XEhwVkocq78DN99kTLhUIi/u5EBCZDN4Gjh8Cwh2nmhR4CuFbMxmcdSodJPXbWcHrmGrdKiJRL/lrd8/f8FmVfSojmXLoNn741BLn+ApSYM+kgaZdTWQkdf+dW/k19MhYuQhNrv0z40Qx6qQi/h7dqixLEFbn4ZebohvJNTXrS6I7QI3IL9PJ/XvZJwLlA/JvKDgScOnWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKTfG//Lj9uJw8GYmja6FaLbquC+kTq8Q0kHcMTBRHw=;
 b=cWL/QGXl9ZGmAdDJKqc6RtbCqV5bzt1/+LcRdrVeFwtF9SnYXudYD1TkwkmNd2bGkncnqocVrrY9iE69dTkx7Si+fK4pcDXLbqWoJWTNI3AUe4+7AqcCtA7lIFCXIzyS86XB6JOCxaiB+PxE2HRtpVTVA6dhpvptZ8nOUsZhKOYvWEmglGQImX6CddZY7LxYyCwiksCZiOIRka2XpDm4t7yEFC9HWpcv+La/lWPPjYR8FzVjXFcbwk2LSlQ0lJE853IGL7WqOmpN6L+aJGW8r2CorwKDthDnViLMlmUXZ9TvwM+txcVhCCxLeRcu1TYYKZEWk6h/bKG4oUlhwnINBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKTfG//Lj9uJw8GYmja6FaLbquC+kTq8Q0kHcMTBRHw=;
 b=kAq76dwcBQ3KY08VvraR3mlpP8D7N6JtAgLkK9nhNQv5T/Yw0/73xoPQ+rpqXJd9wOizWzh3mQaoV4Uks410kyrwQk9ptq1UXb0GjhCcJVbo8NKfFZMS+v83EzwGJwlLQGTSCxh8etp5kHJCmDhOOXIq6jaXN/4MLyO1K0/pttLGZfjMldogM9f+zaiS1CKiYjH5liSYr+lHLADGIzwHsWdR3YG3cHw4TFUdpIDAXFw2WfSMLxsta+jFiaRR2w4odW3947T0H2otdj1O0LOz10F3zKLwevlc0wUhP8n2jUJa4CHl4HYjAiA3YowBxXh80WjDIlZuX4M0EuGyDKuExA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 07:33:53 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:33:53 +0000
Message-ID: <897fe294-d268-409e-a772-2bcbd3db2d64@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:33:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/20] clocksource/drivers/vf-pit: Encapsulate the
 macros
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-11-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-11-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ddb3f8-cb15-455b-d3c9-08ddd0cdc42b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHd3ekFZZnFsVVJzYkc2L2lRU3Y2dGdJczRBTzBrZlpYMU9QUlFmZ3ZyZ3Fw?=
 =?utf-8?B?WWhtRXc1SmRkc040bjB2ZVFqRTZpeDhWd2VBVnhlMklVVlZ5MUhYaXJqZ0d1?=
 =?utf-8?B?NGs4TVZaY09NTExvMlgrSnFobXdCWW1LV1lDSDNiazdTcUkzVllaL1pNUDI2?=
 =?utf-8?B?OHczU2dJRldJalJJQnRvcVN2N2tQb3NzS1VVb0xpK3AzcStycXZXdzJrK3Rx?=
 =?utf-8?B?aFM2ZVU2RTRNU0hsY2txdjZZdzA0ZTQ0cGpRSWxuYnhlSUpDcFJnb2xhZVFU?=
 =?utf-8?B?U1NyYTR4eCtpSVJpUDNlVU9tTng2OGNDOHE0VDNVN2FUZ1p3bFhmSTVuS0ZP?=
 =?utf-8?B?QzJaZ2JFZ1VBSTZZSlV5OWZvdU4yVi9IeGhlaVRpSEFjaE5FeGU0c3JNR1o1?=
 =?utf-8?B?MzVvU0lsTjA1c0dCeWlVSytMTmIyWXFSU25iY3FrZGhralplc3BKVnR1VFJB?=
 =?utf-8?B?WjdtRVBRUHE2UmJmQlF3bktneW5POUFVZit0NllWaXpOZHducVFtN2ZhWlRy?=
 =?utf-8?B?U3lyWklPeWFsblE3QWczUm9OYXRzN1U2TkZwYXBEa0VzQlR5NFQzeWx3RUJM?=
 =?utf-8?B?MzVWOU9iT05lbGY2OFVmekZUaGVwc1dVN0EzL25kMUdMall6YW1DRWh6VldZ?=
 =?utf-8?B?K0ZvL3VuQm9tMWNNL0k5QlR1VVlMcmNaaFROdDBlOTdmZVJJbDY5c0piRm9I?=
 =?utf-8?B?ZkkwQmRRQnFYUXc2NHlmRHJQNWZDc1JEMU9OZDNwTGUzaldoNDR1aEo0WlBt?=
 =?utf-8?B?UkFGY0lyZzFkQUdoaThEcXovSFFkeHkzbDN6VEFlMlRyR2huZVMrNzFkbUJL?=
 =?utf-8?B?QWdQNTU0WU4wSFdwSlhIK3ZzZ1c1U3drWm9sS1JLYlc5ZzVzUFJuY0UveVRV?=
 =?utf-8?B?MktmOWlnTVRZaE5OUHBncmx3d2toUElFdXN1NHpoVlF4emJUSnJ1Y2xRQmZX?=
 =?utf-8?B?amFPZVVldFNPK3FTRVd0OUZZYXhTaEhHOVFzS0JRQXlOazRVdk1Ebkd2UlQ3?=
 =?utf-8?B?R2hPNzcyb1piYXYyR0F6WUltRDZUdWxOcUVKaXZTM0lyTWlSemlOUVRMT3B5?=
 =?utf-8?B?YWdKa3R3dnFKNDYyY0J2S1RsR2l3RUtObys1bnZDQ2VGL1BxL2FaOFhSbGV5?=
 =?utf-8?B?R1kwODdjc0YzWEZkK214MnRkaEFHalVuWmU0QU1QU3JKV2gwSzlHNG51N0Mx?=
 =?utf-8?B?bFU3L3N5V2FXVVZ4bkl0bytQWEplemQ3QUlEWWN1WCt3NS9kdkxOQUErSXVn?=
 =?utf-8?B?ZEV5RW1sZ05rb3ZucmJMWEdkblBjRWtnVEtXemQ4U1U2RlIzOSs1VU52M3RJ?=
 =?utf-8?B?ekJuamsvSG1HbUlwWGY4SzNDZW9pcE90WHlQRTQ5K2pVZm44cUxDZkwvU1Ra?=
 =?utf-8?B?ZVZoSU1TWTNya1R1TkJhZzdINFJtdFRYV0dTTnBVQnY4RjUwV2xmdnBFOENE?=
 =?utf-8?B?dTNXUnA5Yms0UlJ4d2RLMGZJWUJ2bXpOS1h3cjJoemtxK2l3Rk1RSForcUw3?=
 =?utf-8?B?aE40K2dmZ2RlN0NNaC8reEt0dFBtbXJyeERNeWluTG16YUVSTDFKMW16V2Ix?=
 =?utf-8?B?a3NJUzMzWmhNUEhselZTR21RdDlsNElQdHQ5Z2xaQUt5cW5ZNmZPTm1PVldO?=
 =?utf-8?B?azNkMVVTbEMxYjBybGIxNUxZOFprNllyMG9POEJzRFlGUEdQbTc2ZTJpdzA0?=
 =?utf-8?B?YkhvVWxzNm82K3dxZTFlRndPSXdHdGdtMFYwazhBVms5SE9MQlhpM1drMENn?=
 =?utf-8?B?aFdzY2x6Y3FGYzZ2Q2hyVHZ5Wit5K3d0L251Uzc4eFpjYzNYYzI1OEwrcENB?=
 =?utf-8?B?QzRMbTJncm4yWlB5TytGVWcrWnQ4bk9Ea0N6dFJJVCtMdFFKMXZFejYveXVW?=
 =?utf-8?B?YTVzOGNNMjFML1NNOWE5ZnBwSFAvU3NmUTNtcmpVSzRuQVNnRUY1dlR0OFFp?=
 =?utf-8?Q?DBLsViakIM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZuYUU3WUFEUXoxeDI0YkdLczZpb0NReXQ2TFBKTGFsVzRrc0hxTGx4a0k4?=
 =?utf-8?B?K2Q1N2RqZmNMY2dHNkY0M2pWdUc2SndQRk1RZ2QwSmxoRGhNSDlobmtKd1pX?=
 =?utf-8?B?bHc0Kzg3andmZ0d3cWRjck9QQjI1T0tzZTlZYUpHdEdDN3RucEh6ZHhOWklH?=
 =?utf-8?B?bDY4RVRBMXZ3VzFnTjI0ZTFVdFlKbkI0L3JWckpueXVzQVgwVlFTV1Y4Y1Ri?=
 =?utf-8?B?Q1lNZjJ5eWtpVmRlelE5cjlTOW5WWFBNbXZNVHYvRlRDcjVMYktTWmMyYldv?=
 =?utf-8?B?NGhobjRPUlgzU2xHb3dBVk4wZU9xREtydUYwVWZxNWttdEpqUkJHek9UaHhP?=
 =?utf-8?B?aTYxWjFaYjNFKzJicHQ2andYT2l3cm03SWNsak0veTU4U0xabzRJekcrcW1z?=
 =?utf-8?B?YkRmZWZCSXVTa2d4cEZFN1ZqNzNpZWg1NnZRN0tDdWQ2NkdVRnFHcUovY040?=
 =?utf-8?B?ZUxpVGhNaDVOU2dWZnRkVnAxVUIrL2JSK3I1UFBhTkVTRkVxZUlFTHUxSytt?=
 =?utf-8?B?T1I2KzU0UGFKUC9ORjdvalZWNldQejhiOXFSaUQ4L0hFOTRTOGY2R2YwVkxl?=
 =?utf-8?B?bEM0akIzaTJ2OFVyaC9PdTJ1SmdwRjVRSzUxaHRzM1RTaXRkdG5Dc0YxRi9J?=
 =?utf-8?B?SzVzVmZEZmQyY2w1Tm14SGZQSDJUN2NNcjBlNXJoa0ErckwzUnp0YXh3bzcz?=
 =?utf-8?B?dUVCQ1Z1RzgrUXd1dFZFckdzYXloVWFZdEZnWGVxT1AyMkNYRWRzZVBSZTZC?=
 =?utf-8?B?VWJ5RnIyc3ZMVG43bEc2RUgzUDFtQlMyY3lpclBXVHFGME0rSXpIUWFPUWx3?=
 =?utf-8?B?Z0hVSGQ5allLUnJwVC9LY0d4cmNpaENhTlRYWHhPTWlIVjNRTUt6UHZxUWcw?=
 =?utf-8?B?cGZQeHdPSW83WW8rUlg1WXB4azMvS3B3YmxVbFUxeHduUEl6bE9MTlBySm0v?=
 =?utf-8?B?ZWhDQ0Q0WnFyWkROZjdMbzhmcDBSL0JaVHhWOVBUYTZiTGxFcEFBYmRFTk9o?=
 =?utf-8?B?UGxuajR4bUZRK21oU2RQYjJSZmRUTWcyR0RMTXlRRGJLUHg1ZHgyU2g0VWln?=
 =?utf-8?B?ZHh3cSt4RFVkcjFPamVabUVDVDdpRncra2QwL2lZTFRhS2lNQmJrQ3VOVTBi?=
 =?utf-8?B?dmNkUU1JMGVZaUVhbHdKdUlyR0RDRE5rcmY0V0hmMGdzbG9md3JwSkdMWU8w?=
 =?utf-8?B?dlVxd3AzTktncHpOak93MW9lRnRXUFU3UUlsNTMwMzNtYjVyanNjWmRzd3V1?=
 =?utf-8?B?ZFI5N1lVNUR4eENJQWt0NmE1YXFYQkVNWDFJQks5ZjhDOUVUWlluQjJDRFJL?=
 =?utf-8?B?UE9kZkJvYXJIS1BneEQvU2FnMDlwdE80VXJFMFZZU3drVE5GQk1HSHdMYnVy?=
 =?utf-8?B?eFEyWG9DYitYRlI3WVc4VGxYR0ZhM2NETyt1SEttdllBVENJQVJ6WjV1WE5B?=
 =?utf-8?B?amNnUWlPMHg0Zk8zVGhjZngyZkZuTGhFYXFxNytCSmE1REs1eVgrelozMEZM?=
 =?utf-8?B?S1NIUTR5cmJZc1lNcE5OQU5oVXM2eFpXYWc5eEo0UmZLVU1ZeEIyc1VRd2Ru?=
 =?utf-8?B?WEsrRUVUVHZTSHBCUmF3RUd4cFk4U0VOMjlhUW5HaG1adTl3aFNXZUlIN0JQ?=
 =?utf-8?B?djA0d0hhUFhnNXErcnJHNGhHNE5NVDBMMi9Mb0tmWWZrbklVa2pCM0RCdzdq?=
 =?utf-8?B?dHdxTHZSK254VHhrenhqbjJoaU5LYjQzRFpBWlZRRWFUSytLTDFpSnRGYlhJ?=
 =?utf-8?B?YW1henVFTzNOVzcxbE9Fb3J0NWs0WGtXZWJIN1pRSVFQYkRCNTBFTkpTNHl2?=
 =?utf-8?B?cDB5YkpqUnJvZUNJMWphQUdjdlAvUC8xWWxVbnlxTlhWOXJYQWhIcVdqOS9x?=
 =?utf-8?B?UW1HU09ycS81Z3AvUDg5Vk1aTWJEWW5DU1lGa3F4WVRiQ3FrRGRVUno0ZVRo?=
 =?utf-8?B?MDVPOVRwVmkzaVkrSEdkSkNJNUF2TWd0LytVZ2E1Mmk0M1dXd2w1b3FYL1NC?=
 =?utf-8?B?SWk0M1RvL2duSHZsQk1IUzd2UmV1VTZVRlpoWjZIaTVjdkNiVUpRRGlLeUkr?=
 =?utf-8?B?Ym5YNTh4WDdHNmlpQUJaNC96Vkc5ODhjZG9JazJ4TjJBa1czYkFXODhueUpB?=
 =?utf-8?B?cVlPcURxRTdWeWJCRnFqUExkWHN6azBqQTNscmJDZjR2dzR2VllwKzM1VVJ2?=
 =?utf-8?Q?tSTXID0K2HR9SbB+ZeSYiP0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ddb3f8-cb15-455b-d3c9-08ddd0cdc42b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:33:53.7216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8qlrYiOGjDVpEu5n/KYWSZN3E5hGG5hV6s6GTy6r4NR52aIVB7RQcDvX+om/IzqZ/9fxjd0SjhcbT+s6Vq0nnfZLtqYxJxqdC1/MP5sJSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:
> Pass the base address to the macro, so we can use the macro with
> multiple instances of the timer because we deal with different base
> address. At the same time, change writes to the register to the
> existing corresponding functions.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/timer-vf-pit.c | 35 ++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
> index 6a4043801eeb..8f0e26c0512d 100644
> --- a/drivers/clocksource/timer-vf-pit.c
> +++ b/drivers/clocksource/timer-vf-pit.c
> @@ -16,18 +16,21 @@
>  #define PITMCR		0x00
>  #define PIT0_OFFSET	0x100
>  #define PIT_CH(n)       (PIT0_OFFSET + 0x10 * (n))
> -#define PITLDVAL	0x00
> +
>  #define PITCVAL		0x04
> -#define PITTCTRL	0x08
> -#define PITTFLG		0x0c
>  
>  #define PITMCR_MDIS	BIT(1)
>  
> -#define PITTCTRL_TEN	BIT(0)
> -#define PITTCTRL_TIE	BIT(1)
> -#define PITCTRL_CHN	BIT(2)
> +#define PITLDVAL(__base)	(__base)
> +#define PITTCTRL(__base)	((__base) + 0x08)
> +
> +
> +#define PITTCTRL_TEN			BIT(0)
> +#define PITTCTRL_TIE			BIT(1)

Checkpatch:

--------------------------------------------------------------------------
Commit eedb32b08f7f ("clocksource/drivers/vf-pit: Encapsulate the macros")
--------------------------------------------------------------------------
CHECK: Please don't use multiple blank lines
#38: FILE: drivers/clocksource/timer-vf-pit.c:27:
+
+

total: 0 errors, 0 warnings, 1 checks, 79 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

-- 
Regards,
Ghennadi

