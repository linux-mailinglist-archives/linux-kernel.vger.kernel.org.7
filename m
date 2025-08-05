Return-Path: <linux-kernel+bounces-756160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1552B1B0A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EAAB189D238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EA259CA1;
	Tue,  5 Aug 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DvrMEwyk"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013064.outbound.protection.outlook.com [40.107.44.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A367EEC0;
	Tue,  5 Aug 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384691; cv=fail; b=Hg4eo9AG54Jt1lvHsDOXfi/ampK72AXp/W0HBZ73QOx5Aq0Bp4jxwYo+e/Xf+a1J3pKYhRUiYGgnnK9xie9TqSOKZ6nZPTPti1AFDt9MuObIEXFHr8TrIE/sTIUqcT2b7SZfOXS9yixznxZM4jlWZl8H7im45TvqF6jkT3WJyHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384691; c=relaxed/simple;
	bh=ChbqRGL8ZTgzP5eZDN9av6ITfgeHEkQG7Ve1NXoL/bM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oB+kFo+rdQXmEppq0kvTp7/RlK6uvKmlkA2J2Mi87ST8WVaAQAJ/9LB/67f13/42rXzwKcXPywbKETreeetUAo/tTXxphLOr8GsMZftMqlQfcf9XTZ3Hh3J9nsHUS1FtyZ23tL1WdQUxBfgn1Q8YkyEo5/o2yPFbpLJwtUmXE34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DvrMEwyk; arc=fail smtp.client-ip=40.107.44.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XludA71V2HdqTlfT+InzYlLvq26xw9xOfnlolpTN2YmPmQl/p9srG1it9V6pHUYI5pYZTgEy285cRF+87DTiRip4kfHG2zrbzdXMHUmQafx4RZJoa1GnXISudFwj2PKUAJ8WTLFY0d9JCDICRRN4zbvRxzN7b8hI5juMiV/0jxaZqgLcyU2h7COjxoTYDiYQ1YPFXU6keTdDY+oii2VgM07Fn/62/A4nnoEylQYfRKcRUyiaSbdc5p84jfNPuKVF/CvvbP6+QlUTUj7YUQCifumji7agvqf//SK99Tcq6dQmNjug3W6j6GCgZcYC7fcrSgePWNFgLRKL+jmbwnX2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqE4oipae9bN7USy2D42bcfM5tlmPcZNusQFwfZvT5U=;
 b=YR/f+VkeNMmZw7jA+q8U6BG/o2XJkjTveYchcBbzZ4iVPFIJmVqaU2zSHN1oCnkGNoUH2iWyGiPD3VNX/n79VC1HHF6fpGj1Zlu3NbWPMct6TJVPFRcyZKD/Eo9nH5jeCzxDMxuiQ8JqhGF56J6bpfx4nsV/eXzDmdgbDp29b31i0gjaDZz7xYV7/5CskGhkkR1RxwlcPqsLYJizq8W6BnNIQPiB9WOoOW0aOg4/AI0McaAd2RQyyeKA1pqU2d44oTL5zO1Rm04v1PhxEOJxdgPxmVMyVVOEhPwTmSoUo/bGSkqF32MZMgMacH7ToiawrmlI4yPVxmgywn70v4Uffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqE4oipae9bN7USy2D42bcfM5tlmPcZNusQFwfZvT5U=;
 b=DvrMEwykNRl3QCHilGY0a8avAid9mQGfVkWbjACg+uItxXwtPlZL3vsP/qv+Sh655hvru+3d4dqf1Zm2ssRQqo4QLcArPtz6w4FxP2Tb43iUz+EGrJhSyQVTBl3gFj9KhC/VNRECarGkl8tsXJvbWOapIRi3F0S04CgpBxzd/xSUxrJYf4RjsLy2D24/ITpHWSWIkFbAbnW7ERa8KG2cvh6tlTYVoVbDZIow1plZ7sQ36yPoRud7+J4t4WAnTbImWzaz9lEfkcCirJM97GlOk0Byp/53s0I9TxReGdVFWHaSoSXLizaCUdwVL5hSntTOlLJVJ5+j/8kSRIg8PB5P1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYUPR06MB5980.apcprd06.prod.outlook.com (2603:1096:400:357::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Tue, 5 Aug
 2025 09:04:43 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 09:04:41 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ASoC: cs48l32: Use PTR_ERR_OR_ZERO() to simplify code
Date: Tue,  5 Aug 2025 17:04:31 +0800
Message-Id: <20250805090431.117114-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYUPR06MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 192b8073-5c24-433b-d386-08ddd3ff1d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xk3FJJ0scNCPpHb3vvX4fwqffWlr9TCxwp03tX1+Zi3JF0fTd6BHYOfqxdrh?=
 =?us-ascii?Q?ar6Z6tASxL0te/8C6F0iitjxAT+if5kYpmFXjueihhHJAdbSFvE1gmsWJtIO?=
 =?us-ascii?Q?I6WVjyTQuhOXlflmaQCN+Ue+D8DCxFrARRV3gly4NyMGwF3t8dWxFpQ94MEu?=
 =?us-ascii?Q?2h8TGEYgA+yVtDDqEBraRh6rkt95wLsjsfDXQtFGOzITDrc63Q33caKW9ttH?=
 =?us-ascii?Q?SGlan3tczw7XPKb/uy0TaRTbYUPMNiDaFhnMe7kMRC5h8tuKswJ5B5GYKD68?=
 =?us-ascii?Q?/LTOXaDr+UJ2+sgerpE8CdDL77D22Wd64nW8HYpp6hsnS9zbu/nlHprpBryF?=
 =?us-ascii?Q?XExNm/dF/3QqxFBivk78mFIPeG6o4td3sjD/O8JyWluKLoROOemC8MQAhEoT?=
 =?us-ascii?Q?jm9CIli8ODwTI9gjQb7hlZpMUwJoziab4/oiEiy2aLGEyMUNxTjk093a9xQD?=
 =?us-ascii?Q?rDLMXJ8jDz2HTaT5DEUS0PTe/X2shwxBFfwzYmPU9IOiP60YWTp3kCf7qngA?=
 =?us-ascii?Q?3080HixuW3py9nYvTULFABGH4VY4gX3WSyiiP2z4jPmtaYljcdcrh5l+aApf?=
 =?us-ascii?Q?Fa6qVnfLaUxWk3O7NMz/0t3zomPHiUR1k/AGvTuuQPnvufzog3LY8T7FNTu5?=
 =?us-ascii?Q?miBfdCinWoo+ojDvvCGvS6AvRqE2byQna42z0ziaiUt1tkPMy1viCDhErhaG?=
 =?us-ascii?Q?q9bwry8YtgOcS56tBKJEeXk+YazE+HlIzzRSImRN+sqkZxdC7Z2OqWybo4a5?=
 =?us-ascii?Q?vCM9JRO3wt2bQKPgLWB8iP4wLb7m10NRHig+eF0HIvD/X1mHiqhyor/7PN+5?=
 =?us-ascii?Q?nworqVbBmXMnikrE5yrCecCTXyCyRKi0qxgj2DkONnc3rv+u8HVuTS5uTGOF?=
 =?us-ascii?Q?nJs0vGJr4Tcc1+VFMqD2jJWvoZcIt0E9oo/bztfswJNXDDK8DfKuixcY0eBY?=
 =?us-ascii?Q?G1AgYYnNkxniIPBpCBkN0a9bWWhOL6qlyoOEohjW1WjGv3Uqmw/2CoEavzOx?=
 =?us-ascii?Q?Rs0E3OHl8MtYulHg2Vi3F1Yq979k2/5yf4vgKPBTqaWApMMFeHYHuXAUNQx7?=
 =?us-ascii?Q?hHgmDI4A0D0TkBNc+zXJ49lzi3ns/i2LoKbRC0KFoZxcS80uGIcc/G0mCHXv?=
 =?us-ascii?Q?xosKyKqj03m/Be61zoZxVpwlQ7SQjHmkn1gTsCYFpCAgJ6oTH5eCNfFoUxgu?=
 =?us-ascii?Q?8rOFzcA7/t/JctRqogEOWq4+Fz+K46z2riNnpVOVg5+XNlkLUAocKzYhb0HQ?=
 =?us-ascii?Q?p4kfPaTm/lZYiApHlnL2dEjJ95ryNTep3X3ME1w6mJYLazwABpqYFCOaC8WX?=
 =?us-ascii?Q?XwDMUOyzFHAZRDWAoopomZFOY73qaDWvuOMh6uwLMOLgvk8+W4FfIaniGJgX?=
 =?us-ascii?Q?lpngzc1xs83kKuJe4qbfMuCFyh8uIu8mqf+ia00y7el3kaougAs2ja0JGrbH?=
 =?us-ascii?Q?mQs0eAmIEo4Brry5W/hn4tpomsb1P/AeZIBOdBsKhf1ZOoRgkaBfhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qMMUmeP1P/4Ny0wFSma7Ygqr56xm0sscgBpnk/E9lOn9U18e5E6CDzSThEPJ?=
 =?us-ascii?Q?OTTUPhv+yX23jv56lgy8RJcwj2XMHtG2npHaPo246AinnAUgh1h76ARX55zs?=
 =?us-ascii?Q?16Ifjgb+FsjVfKdaixm/fZn2dA7quWkF1cEGN8/bqHs0Hsn+MQhHbUgKQPpw?=
 =?us-ascii?Q?B9GhLIo5hKCB4MCUs8f1OZYW1SYoMJdkdG8UeMWL1Gdlva/y/XKM31F7mAKZ?=
 =?us-ascii?Q?sQ8XbumjRu3OBWNnyk9N9syc68bEG68IKuyOajY09X5nqvAcotXpFBaiHqWk?=
 =?us-ascii?Q?6vLig1oYwCMonQLwBNFEVhjqejnCacsXmcMsnQDoIWlEpZe0KSDP3TH0ZCSy?=
 =?us-ascii?Q?/M87Wz3IKHRDqvDEOvZCRIBj1kT3SU7WD8L9eqyL4QBVyEuYlIQAU6o7+iT1?=
 =?us-ascii?Q?Li9RX1939lemLeuegKF8Ao1Vew192/HI+FQdvL4vIX6mQ6zjInQpiMlv6hai?=
 =?us-ascii?Q?ULcneNrA6qn08uO5nIP0YeRp+g9MtL2BV6KBSBjoWwBqWFvELiY6s3HOBRFy?=
 =?us-ascii?Q?/5LupPXoEz/mcMkTRyYuGjy7+ON+YCWaPgOUerXQkXM9B1E8VgJr65d+IfQg?=
 =?us-ascii?Q?GsZPoNvqsiVR0AfS12cEVbAVuLjq99OxTjzcRvXq/voc4CcIw7Q6uDL0cp4R?=
 =?us-ascii?Q?q4bbQYycE5x98Qxm2H5KyREr25Vb7a6FQtcqUcdVVoIchskvLAfDBBP/v6Xv?=
 =?us-ascii?Q?Y9oHUbEJFsmY9f70S65csxQlzQJ6f8JH0ejQvO3VRPitgAWNUvbN/9NbLWe+?=
 =?us-ascii?Q?l03cICguDXNmbkzYNKqcns0XUIWyG0ati8Kv3LZ6IeP5jF6S4k4+mbehdScz?=
 =?us-ascii?Q?cwUfnWRbRS+VfVUWAe9RXQqnQNR4loZp+8xsqHqKDbXfekMM3SBpRNh/cKTX?=
 =?us-ascii?Q?qm346oGtBPNuniKqO6586jwDnJebYcQpTocDVcyQVm9824m+TVBKK3ynwvG3?=
 =?us-ascii?Q?St1IRopye7QS7HyjcQDWQjDuT57LvcJRHb+3CBMwYxAtP3O3cThkVzsalGr+?=
 =?us-ascii?Q?M4f8Tr00zGs7ht/w+AizStqcp7FvJ4oBikR8E+32r42We88CO/NTngGhatkw?=
 =?us-ascii?Q?Isu5oH/4qaEdc6j9v2AW3Nngd0HAvMF1V0w/Xm+X7oV2xFg0Z6O8IoUNYJRU?=
 =?us-ascii?Q?rdR8UhYOjDzkjoT1Gy4EgglOF+9ElWC8P6A+c3b6ufGKsJOVurcZeOSTgKZq?=
 =?us-ascii?Q?hrF7IW3l59mIP4dFj21HlREvvSZ5nXNRkSx9Mnp0kG71MxcFgn02SxuDWSrs?=
 =?us-ascii?Q?EgiV16bhbzBkHLag+xOvT+UWu5Ngz3YtsnP01aIMRm0tEa56fWSsPGrH3mYG?=
 =?us-ascii?Q?Dwmfb7y3Cw4GFRqcSP6MFQBnqJ9NG6Cw8hVxqPWtjqQV1yL+gyM5JHw1vKe0?=
 =?us-ascii?Q?8km/yFRyYiZmbTIM/Hk18ulGN8UyVbzGKqlE8XPMwfrstWC+6sbCzRK86thc?=
 =?us-ascii?Q?69OS5E+ILKwlZSPmBP/3wiVO5/RWcmtDq/j5VPVgSKcmE1OXfaChk4VJndeL?=
 =?us-ascii?Q?oiY2z7rCfmTDubnpH1/TwzRFzq4JgAx8B89ojQ6w8ki0Hje24vR8CRQaqsAE?=
 =?us-ascii?Q?Ba3aO6DMnlSAq3b4dNvXSFFjxHY8skvTmGo3jFRk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192b8073-5c24-433b-d386-08ddd3ff1d12
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:04:41.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WErLp8HCzCLzmRyiJ8rC5IXoYeROGxCjaHPKJWVKA2QNI3xSdZZT/sDSFRX7tJ2Oz8uflJfvZiA+iCSv1inE1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5980

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 sound/soc/codecs/cs48l32-tables.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs48l32-tables.c b/sound/soc/codecs/cs48l32-tables.c
index 59eaa9a5029f..8ff3652a010e 100644
--- a/sound/soc/codecs/cs48l32-tables.c
+++ b/sound/soc/codecs/cs48l32-tables.c
@@ -533,8 +533,6 @@ static const struct regmap_config cs48l32_regmap = {
 int cs48l32_create_regmap(struct spi_device *spi, struct cs48l32 *cs48l32)
 {
 	cs48l32->regmap = devm_regmap_init_spi(spi, &cs48l32_regmap);
-	if (IS_ERR(cs48l32->regmap))
-		return PTR_ERR(cs48l32->regmap);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(cs48l32->regmap);
 }
-- 
2.34.1


