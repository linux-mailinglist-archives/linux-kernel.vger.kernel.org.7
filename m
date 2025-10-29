Return-Path: <linux-kernel+bounces-875923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438EC1A235
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 056F24F8718
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5992233A01E;
	Wed, 29 Oct 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NuY5gK9n"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032B3090DD;
	Wed, 29 Oct 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739655; cv=fail; b=k3TqSnPeKUssLZKnm4T+ByfmaRFO/yqc5qVQoTYcqaTJ3PtDMl3ArX61VQ+S+inf266PX1aCi3wF0FlZ3ARrz6zZawisIH6gpfEB8pG7pSqXizFhTicLmdNwOtl2/BivmwavUgQLYN2Z73Bjg9dODgmjc3oCRUHD49u6ksTeSKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739655; c=relaxed/simple;
	bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B1KEzoo5geZTNnRrpQ72vUK6D4slEGEcATXX2Cku/0lKXlBBZGnGbQUxlTRoE1gat4Zn101IV65SUAXUWvdUJBL4zGuNpfx+/LFaIb9bi96CIy2PsEjV9UJQZJH2mcGNob0zgF1hGbO8Exslfq0DTLWvyQfFJw6ppfnejnKhFcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NuY5gK9n; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrxrLrJiQ7/xI1dgk4QCjn4R8QM2vOJn9mpKFBYZROLxxNi2C+X+g2PRSOxeWVbh3X237mEiIZnqH6KalomIb0gW8aQqPTaQyRsAk5p+W9wEP7To+WBmCGPziNbV0V6NNcU1enUA563Di2ZBQg2495A/c79TVThLMApozfQ0HT0rou7BgneT14jWjr0Q8aNvoQ+JHLYOBmonwd4PjzmOssdcV7torY38g0HS1oS+Ad4ibAEGe82l4vqQICkUW3Ki8ggcmldx6ZzNLgPnTNpSYzYGsUgt+LzKdhFGTsHeLOh9S7dETmRlA3UtcGYQNZ6kmAmDDSHR4ULWCXSsVJtKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=o1XN7OGC3TB1MnbyQ4ZUnTrYcSkCZme6d3L+us74G361YJoktf+mUgjGd0zWY9eahz5AnsqCKsIjC58Lo3HYebYthi7XQqZ2NfsdYuo3btbLgot+MYXUEi2QSru4rY2F4R6Izk5cl+zieCDiDhg89Izz7OlsdvOAKh1vw3fAjRirJe7hMjwUyBA+jeFks4IV5lyer2MWG1wfwGVt+GlD57kybyhWb6zQ72f1pEHM3Q8RVHzrTjv6MdIyx3dm8js91TYePkpd+JAMLf9aUN/4106AceFKw0KTJoqqWcy8MOviT6MHJstlAx/yusnNCEqV3ACMv8V0nUBKvl8yXdSqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=NuY5gK9nsM8XIjnyTCnmgU7y9xjDUIDOSEuCxONZjlrBrPTrxqtWJMLQuPTDXibu4y2eA4NaVBzfxD5ux9vXBnjW1Tknw0lle3nzV3EELk2KXRnuba/GfzaYwTJiGQeLeQ24f7RyhP8u05JvG1TYcP0sfvhdQk7Q2XJeJpWoF5+jvIsp61+gdBGLNUtIca0t5mArxD7eVVw82VaEe4oENo2e6kW0R8TIiTtZf0zMe06tbrf+fxPydCa8x6bqYtbO6yaIxg56nKBkpMlHhAMWXcD09ihKgfbAOH/ZjanZGVxRT+r/p66x7sw7t36Fp8mz2SH6uYPsKVPaeuHdU3aVNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 12:07:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 12:07:27 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 29 Oct 2025 20:07:01 +0800
Subject: [PATCH v3 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-sm-syslog-v3-v3-1-64e14a6e3f87@nxp.com>
References: <20251029-sm-syslog-v3-v3-0-64e14a6e3f87@nxp.com>
In-Reply-To: <20251029-sm-syslog-v3-v3-0-64e14a6e3f87@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761739635; l=4493;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
 b=AuCULEbK1bJZy0nz6q63HMKBlRFn3KT9TzPiVISUpFNC8v+ore52xM2MVivM01q3Vf69/KLIu
 fgS4F8/o4WhB0nIOK3LKybQ8u3mhpDkt6BM1MLCHSldSSwVKgcGCTBP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 16930631-f505-4903-7a0c-08de16e3ba04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJua1dLRFphRE5IRDRLMjFwTTFmK1VTazQwVmZ3TnNPWmtlTi9kQlFiZUwx?=
 =?utf-8?B?SEw3c0p1Z3VoRzc5NEw5cmpUcXl4TkVmWVJXZTNBQnoxcDBRd0pOcDBCZ3FO?=
 =?utf-8?B?aEpBcWxYUDFZcG9QWmhUMG13aFlOWENjM0dDNkJFT3l6eHgyRzVnQm5JZWdZ?=
 =?utf-8?B?czBBVUpCQWxVNHN0ZEt3ZjMwalpnY2llbzRrWjhjOXZMayt1K1ZoOEJYbzRj?=
 =?utf-8?B?OUJRQURiSmc0U24veWVhcnVxOXlucmVPYktrdW5zZjBGYUpUL3VoRHZHL0FG?=
 =?utf-8?B?bDA1WGwrOFFnNUtzS0VlZzROcEdYekwwUGkyZEdPS3o1TFRPazVQNFQ2YlNh?=
 =?utf-8?B?V2JNNHZEZlg3S29CYXU1TVdZcWF5cG53NXFrd2M0bmhDVWlRUmR5NWhhdFFw?=
 =?utf-8?B?TlNhNlV6R1JGUExEUDFpV0JUTC9pNnMwMEdJekxRSnJkMDF6SG04NGFBMzQ1?=
 =?utf-8?B?dlhUbFBKYXhKeUVLUkl4MkpRMzV4Q1ZtY1hvOHZFaExuVzlsZTRSNy9vSTJs?=
 =?utf-8?B?ZWtkM3c4eTliYzdzUzkzVkV2SWd1NTUwUVNMUFhDeVNmUVRiTGRNdG81b3Ux?=
 =?utf-8?B?OXdqRkltVk5vS2xWRmxxQmt4dTZjcWkzRWkxYytpdjhLdU9LaERHdysxUWNM?=
 =?utf-8?B?MFlKM2w5TjgrU0htVWVxaDMxUnF0Q3R4NC9QbU1DeWx2cU9NSEtLUExlbURP?=
 =?utf-8?B?MU92WFFWNTNLOEl1dVdRaHRWWDhuZ3pWNENybkJQMnd6SjRsbEc1ZnBpMFd5?=
 =?utf-8?B?aTdoTkw1YkpPekpqSHU4ZlN0R01yM2N5SnhaZDBlOHJoM1RGT21weWF3Nytu?=
 =?utf-8?B?RTNpRlFZeHVzQVNCSC9YNkVWNVpNMFlLNExlajltcjFhMGhYVDNPYy91WHBC?=
 =?utf-8?B?eC80cTVhaVQ1cUZCNGZYRk8zUkFZUmpFS3VESjdUTkcrR1VjUGpsQUNtMkxI?=
 =?utf-8?B?RXFwdWJXNGJ0UERTQk1XM0NYbW5EUHI4VmxTRFl5T2JsakFDUTNoSHV1b0pr?=
 =?utf-8?B?Yk41YzNNekFkYzczMkwzaFZFQmZGTjl3dlVRZDg5MnlIcDNJWnUwK0Y2ODVJ?=
 =?utf-8?B?eUt4RHh3T1hDK0NyU1QrTmVra1lXblZ1bDVZcnlLc0N0YmJYRVNscGJkZmgr?=
 =?utf-8?B?bG1NaTUwZmgvWnkyRXJHT3R3TU1IVWh6WXpxeUhHektGYnpCeFB4Skd4QUt5?=
 =?utf-8?B?a1JhVzBscFYrcHFLNS9UWlhGMFE4UE1qTkFNajVxR0RMZVZNYSs1NWRyWCt6?=
 =?utf-8?B?SlFERmtQWVZJQkVFSlVBWHlFaVhnOUt3VGVNVGM5SXlTeTNtem5ENzh4TUwz?=
 =?utf-8?B?SEFHdmZFKzRFQ1NtckpzTXNVVHRSbHdyblprdHY1Y3FJNjdLSk5LVEFBTlZ4?=
 =?utf-8?B?aVBWMng4cGJ2SVRCVEliUXBuNkI5UDBtdG1zVVBsWFU4V01KNmxSM09CTWx4?=
 =?utf-8?B?VE5xdXZJWFJjTlAyMkVEb3UxblhPVHdwZnIra1hmS1lsSEJsSk9TNHUvVUM3?=
 =?utf-8?B?U1V1b2t5TUsrN3YvUFdGaEZnalpCaXZqcDFNNGdtcllDS1BhVm1xZE5GZFg5?=
 =?utf-8?B?RmNURTh1Y3F0WVp2ZWhvTEZqeDhwL1VtcmQ1VUlTeFdmUlNmUUF0ZzEyaE5y?=
 =?utf-8?B?d3l6aFY0ZFlUMXRoRCtWd013SldKT2xVUnZTM3hkdjlHRVV6RkxndW9na01E?=
 =?utf-8?B?YVd0aXpaQU5wMFFpZHBOUzlpU1ZEb09laittN0tOTnlqamlIK3N5QytxaWFF?=
 =?utf-8?B?S3o1cG5xL2ZNRzl4VlNxb2dobXJXZ255YU56Y3MwQlNQQkswcUIzaDhhMWJR?=
 =?utf-8?B?cmE3TDNuTXl5azhLUHI5Mk1WNmJlS3VINWJaSkZveDA5bkhVUTNsWkVqdzZz?=
 =?utf-8?B?VFdUVEZHNDFBeTdLSE5kMy9RUmlsWGkybUU0WHloUkRBczFPYjdsUnd5OXR3?=
 =?utf-8?B?dTdGT1pNcUJBOVhsNUg4Nmhkdk9qS3YxVkozWHJlR2dVMWlrUW41c2ZSZnVx?=
 =?utf-8?B?TDF6dVU0N0dEY3dtVUNQTGJ3aVRmYlVHUkhuNW5wRHlFQUtpRFNqWTc4VkdL?=
 =?utf-8?Q?ceJUk+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmUwTlRHcTJiOWtRVk9IV3FHbVhOUVh4bnRRV08vQVBmNnRBWFVod3RuOWQx?=
 =?utf-8?B?bStnSEpDUGRQSFRqcXE5NWtGRFU4elpwVjFTYnUyaHpYYjBDSFFMS2h1UDBj?=
 =?utf-8?B?RnJRR1RnTDN2cGxvdzlBSGduaDRxbFo0R0Y3NUVoWXRtUUpsSVFrZHY2MEpT?=
 =?utf-8?B?Mk5xRzE2Uk9jOWtlcFluTFN5ZE5ETEJmWmhZZlFadlBoWitjbkV6QyswRXdF?=
 =?utf-8?B?Wjl0UEdGcFdSakwxbCsvYTRJb1VTUVVqMDQvUCs3RGtheGREOXlMUC9HaGMw?=
 =?utf-8?B?RDUva2xKcXVPYi9TWWRhNVpodldmMXNVSFlIVjczT21RTWFVck9YUlZhejBO?=
 =?utf-8?B?TGZzdkJ3S2NXMi81T2U2T3VHaUJCNElGMTVIa3hydjdjblFVZTdHeFlITGhN?=
 =?utf-8?B?Ym04RnNuSGQraFBWY1ZSQ0k2UzM1bzJHMTUyQzhFc2EyYUlZdnRHTUljZ1Rz?=
 =?utf-8?B?THlVLzlsaEpHcjkyQ0F0Wjc4aUVzQVR5VTc4azJ4VklGRGllQVFESStNWUI5?=
 =?utf-8?B?Rm4yckpsRGRtMlNSeXYrUFduOGNWRzhKRFZjcldCTnhNYUtiaEFWaXpRQlVI?=
 =?utf-8?B?aFpmOW9uTFVieEgwam94TEEwanJhaGQ0d2xkNGptZkRRUlVBaGs0N1JSR2ta?=
 =?utf-8?B?Um9NakI4ZzJYdTAvU2FZbXBCY0hZNEpWbVVYbWc5dW50dXhraWx3dUZMaEpq?=
 =?utf-8?B?VUpoSHQ2UEtaaExUOUV3Z1ZwMzNVTDhSeEluZnFzSE9SWXZnNDk5UUdjQlJ3?=
 =?utf-8?B?NUtNRzBoZ1huZ21QRHpFcWg1alNnU2xmYWVLeWRTTU5LQ2VXMm5XOGxKbVhP?=
 =?utf-8?B?WVBFRFQvQllpdnprOGM1czZjalcrcWErOVhFZUd0NGpJUjVxeDFnMlIwd3Ru?=
 =?utf-8?B?c2FvUm1UYjJPL3hWS245SE1LTTRPZnVTQUtud2swSU4vR0RGOGRIOE9FMkM2?=
 =?utf-8?B?ZkNKbXpoUWZ5RExUTmE3UVVqc21ieUlTNnlaRGlzRFcraXBBM0g4L29ELzRi?=
 =?utf-8?B?WWtpTGNtVjNycHY1UFhoKzdyNVpHajhjN2JEVnhoVHRoRDgwT3MzQS9sTURk?=
 =?utf-8?B?c0lTZDdVK3hJN08rdmNuOWxNV0pNWUtxZVhXOTlyc3VGMDVEWUpnbEVOY0Rj?=
 =?utf-8?B?ZFZSdDNhYnZIWFoyWk1YUldKTXd6OHZFMWpFRU0xMXhoWGtiWnRkM2pLTXcw?=
 =?utf-8?B?MGt5TzVuNEFVNjI5VlpUc1B0Rk5oTEFldG1wTXNIUlpUbS9WZVR2R29mVnZO?=
 =?utf-8?B?TkZZb2s3aVVHNlBReFZuQWRleW1CVEdSWlpwSG5VVUkzVGhOUk90Q0dWUmI1?=
 =?utf-8?B?ZWpYY1FmazBpZldhdjI1dDJGTjhZZmg5TXRlTlcvbEVtSVZ0UHRWQm1yZnp0?=
 =?utf-8?B?NzVVNzVERGVsTTZaM1RmakxtaWtrdWJReTduTVhNV3B4eUNoWERCL21BYUs5?=
 =?utf-8?B?dTJyell6NjM0MUdHTnlMSklGcnVVY1JON2k4MVpJbjFFeTg2QjJQM0JZNHBl?=
 =?utf-8?B?ODdCdjRSSHUrOEgwU1VaV3paSGNUWUpjd2pzV1pPTHAzOFBJTCtyZFBOYVA5?=
 =?utf-8?B?aGQ0VU5tcTBOeFBNY0ZmSks5RURBd3ZFUGhoQVMvRllZV1NTYWF5WGkzcmtq?=
 =?utf-8?B?YTZrTTY1bXordVRtL082VEJnTFFrb0U2end2eHIybFY1TEZTWEUvM3h6YlF5?=
 =?utf-8?B?Y2VleHFpN0pjRm1nMUFBVHFaUlF6V1VQRlZycEVQNzBRM3FmM0JaZGJaaFVZ?=
 =?utf-8?B?SnRqdThUaGNqVjVKSHM2a3VkTGFSdnhPWTRZWk5VRHcxQUJvTFRvMmN6L3RE?=
 =?utf-8?B?USt0anA4ME0xa3A2aG5tTjJKL3poMVpUQmhnU3FNaVpBUmtoYXA0bnpyOVVZ?=
 =?utf-8?B?MjlUbnpuaHVmNTVSNyszYW43ekJZajNjdzFETkhhVUhRTjMrSHJTWUZITS9y?=
 =?utf-8?B?LzA1TndpUnZaK2RVSDdIWm9aUHg4ZndMR2RDcUlEbTQxMU00N3hyL0pUeWFT?=
 =?utf-8?B?MzNzZmwvV2kwcDZidS9DSEFLeS9Rcm9DQnVLMWYzOEswekFJelA2U1V4WDBO?=
 =?utf-8?B?YUp3Y2xzV24zR1g5U2xwbzJoZWY3c1dTYnMyb013WEVaVnlpc01vYU1VQ1gz?=
 =?utf-8?Q?7eywP+PGVjQO+8C6tud4o6zCD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16930631-f505-4903-7a0c-08de16e3ba04
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:07:27.1007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVL+aCFjphPZmo+xwgljght7sj+fBCOWJrnrn/NXFoa61Ybt9ovwYA3T+y2HEtxJeLPWSWKp1eUHDP3KEL1jCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708

MISC protocol supports getting system log regarding system sleep latency,
wakeup interrupt and etc. Add the API for user to retrieve the information
from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  2 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 700a3f24f4efc153ca4a9ef1a9e50a7ece492a18..eae0b0562f6cf1931be612852ba2651f60820e6d 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -28,6 +28,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_DISCOVER_BUILD_INFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
+	SCMI_IMX_MISC_SYSLOG_GET = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 };
 
@@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
 	u8 cfgname[MISC_MAX_CFGNAME];
 };
 
+struct scmi_imx_misc_syslog_in {
+	__le32 flags;
+	__le32 index;
+};
+
+#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
+#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
+
+struct scmi_imx_misc_syslog_out {
+	__le32 numlogflags;
+	__le32 syslog[];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -371,10 +385,79 @@ static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
+	u16 *size;
+};
+
+static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
+					     const void *priv)
+{
+	struct scmi_imx_misc_syslog_in *msg = message;
+
+	msg->flags = cpu_to_le32(0);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
+	*p->size = st->num_returned + st->num_remaining;
+
+	return 0;
+}
+
+static int
+iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->syslog[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_imx_misc_syslog_get(const struct scmi_protocol_handle *ph, u16 *size,
+				    void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+		.size = size,
+	};
+	void *iter;
+
+	if (!array || !size || !*size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG_GET,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	/* If firmware return NOT SUPPORTED, propagate value to caller */
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog_get,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..2407d7693b6ba1303e07629e45e2a7eaaa906fd3 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -59,6 +59,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


