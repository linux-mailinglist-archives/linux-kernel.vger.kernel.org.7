Return-Path: <linux-kernel+bounces-854909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6DBDFBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B2E3E82C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1E33CEAD;
	Wed, 15 Oct 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S5HXfH0A"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776D33CE92;
	Wed, 15 Oct 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546710; cv=fail; b=dKTOX6iKzOzVpOgi/hwYp9I9o6UdSPwIu7CcJs/Ndij3qs3m2YrdxYqJHgn7YHJbvHPZLsVqbsyJ4utMSAi7/lJyUjo56fp2uKe93AOdSnlhmAU3nBYrQETAJutpT1/FqsbJsx4FM3rHlQE+CXBYtutTci3JJSysTOW2/IpGKlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546710; c=relaxed/simple;
	bh=oVUUTzXEys0EGLaNi6pqcX39W4KcvXr7QB6CkAdgx/k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wwbcsxvd/62YD+nhz2w8qpnT/bpFvzOHz/CQ6u7gJqrQufJ35CGbDyeBTv9oBkRgNkGsrDsSG7a1sKwNIU8TYtzPYBx+VZLr4nRXXNmp9e6fUExj1VeGK6DEznRVq5zOriZpd+rWV2BWqE6zJFM5j8lAZIvmNC1wOnz+9qd9iyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S5HXfH0A; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mzy30gOy5xrZF7mLVVwKfW+2ZGiQPoKAZ6ZMIfYWaP3p9DOGbqOpQOLWcTtPbLfyYXJemwY4U2IDJBml3T8ozS4D2obDzd3jgjDSL8T39bSfdgo7BVb/uOpyzdqBU8nofQXq9A2AFWg56juh/Ce0gO3M5BFgaVJj1vLyh3472oc7aS18zfWJhAljla9jJQQbWmJkJEnp/lOP2XyMl9Byp8nu0/LbpLyixprfl+Msx25/xr+vTpJZBjKb+bT76vib+hJ8rKLpOyqq5kHOWX3ubhOHkztVdhJDXUvEcxJN+vLHDuGxMWZSDPXVrToILAMF7ww/J0FJiTSKHxoFnhcb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzixAsWVBHBotlHxvcqhoEdO+gcVwq8N4sYgjnTSg4Q=;
 b=DHiSTq7hWP9LLeRMYOaqxEeY1xkmtg5A2E82DgYq4MHnPyRrpv9q6gX31av4W/M8uVDVGn1cUnBy5Z9SddrdXn6lSoLaV3IbuTKRxFFGmIVy9w1p0GjEAskvSnFqKYgxEQWgm8xmav5UpjTO2TT8KLJ4SEjuX47nXDg6jezKYHXFZFzZV9K2uWbhdmqzrRYQqjfbMJtdv0W/n5bTCvG9wbZ1J4f2a/8+aM2mS182JGGHMtEwlvHxipESrQlAS3LmLnC1dU4+hCmc0Hg/QOYae1VJ9KFbxUXtZCpGSBm/xtxqtOMM6F+31n3ltceGLomIcI3Dn/T5DOvftXVgau8qeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzixAsWVBHBotlHxvcqhoEdO+gcVwq8N4sYgjnTSg4Q=;
 b=S5HXfH0A8KpmMblyhJpLG8UWB2jbzb4FZ5xaZKNOP12VUAMAeUYfyN/e5KOG6vFGP8kYXL+xrDNwmjVNuTbhVK5j65GOGVInx0v6EFMOu1qnX1diGKmroIzOcLoYJ4sQDU7cq33GImXekoOHr0xERyrFcSb8tYQbZ7sBe3RrpIOoGovmd3PqDzYagiG1USKICcggx0A4URbBuX7u2SSndyp4Dc4U7kycuoDPm/inZPmAa+myfWFPytPBnveqYHg1++n3sSqrz0YjE2Y31nWQOIKoQSx31P9lA2Vnyv2IehNT9DCXx9xvIn7i1E65RgCTapgjjnzkL54Hsh77fEkorg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:30 -0400
Subject: [PATCH v2 05/11] ARM: dts: imx6: remove gpio suffix for regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-5-41a7281b98c6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=1691;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oVUUTzXEys0EGLaNi6pqcX39W4KcvXr7QB6CkAdgx/k=;
 b=ttFVGKQpj/JbBQJFE6ahY4COy8QBEQeLzLAsaYlchOV/YRsc3IgakaXxM2f1GuMDQ+MTHKO54
 NAvoh2tUkwSCg5n2pj8uxWbejGDrlsg9mmT1nxO0DKdA6vvq72tmcEf
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
X-MS-Office365-Filtering-Correlation-Id: 845b63ac-0bbd-4bf1-30a6-08de0c0a2ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWpWQ1BmVUFCZFBqMko3eWZvbjJIZTRlZ3luWTQyWFNyVVZTcGtGMDUyQ1Jm?=
 =?utf-8?B?ZitsTHF3dUFDZnd5d21PQk41Q3VBL0tCU0lQa2hnWEhhWlJOZUhxVU8vNnFS?=
 =?utf-8?B?TU1maVFOTUkxTFZqT2F2cy9rVzlLUGNyZnhhVnk4VlJHaldvRndYaW5FT3hU?=
 =?utf-8?B?MGZqbkNoR0VucU5zSmRGZ3ZzV3ViV21VZlVhOUY0Nkt5djJ4dnFLOUoyMDM3?=
 =?utf-8?B?VkhNV2lneGlycUE1b0trMVl6eXBzQlhjQjQ1SDRmTlBiOXFCV0tzbUJaakh4?=
 =?utf-8?B?c0RUSkJ2YmFSNlVyVGt2MkUwd0NBaGFzSGVrZVBZMW9HelYwUUV5V3NYVmFO?=
 =?utf-8?B?anYwamU2QXk3UWRldnI0QTd1MmpNMkhTSy80TEZHdnBqTjNUV2NUMTRkMEZj?=
 =?utf-8?B?T1VKdDJtQkMrL2F0eUcwLzRjdVRNdnN3TENNcE1pNnVDbzJock01TUsyalhD?=
 =?utf-8?B?S25lcVQ0aThvb094elJPV3JkTFN6eXFYMXhKcjlQVTl2RFRVd3JYUTV2Q0gz?=
 =?utf-8?B?TGpYWVVNZHEzQThYSVRMeUtrMDNsVi9sZnM1bEFtZENDTi80Rit5b3Y1TVp2?=
 =?utf-8?B?TG1zM2Zsb0o4MHovblFaMEQ5dGhOR295M2luT2NjQm5lME5aa2haOXAzN2hq?=
 =?utf-8?B?MUdQZnpGdUZLVHhYY1BNYjU3U2ZvaXZFa05TZVJIcVVNNHJ1UUthUEozK2JL?=
 =?utf-8?B?ZHo5b1lBUFplZmo0b3RDUllpelFzV0NTSFVkMWNqTFcwczNFZ3BGcDF4SGhi?=
 =?utf-8?B?SlRBcS9RUTg1REs1OVdJS1Zmb0ExeklDcjVzbTZ3dUJKQVpBbE82U3RYZXBJ?=
 =?utf-8?B?eEFUZHh0NWJNTERUQjRxRlR6eFlyblFrbEx6dzVSZ2RueFdRUnczWjNsSnFS?=
 =?utf-8?B?NU92MWRxTUlDa3IwMzBTVWd1eE9lMWJyUzdhNWd4VXkyTTNQYVU4alZZUS82?=
 =?utf-8?B?dkpGM0h2c3FUT0tLWHgvVjYxYmp4cUJRWS9ZTVp5Yjc1VHQzUVE2OHZldjNC?=
 =?utf-8?B?MlpjdlVXYk13YTlXSUd1Y0Eza3V2c2xrMTlVc0IvRUw5UkpSeU54RzZ3Zm9t?=
 =?utf-8?B?NlJHUTNza25MWXFhKy9scXAwekNTaTRRUVAvdG80QjBGL1B3eGR1RzdHaTdm?=
 =?utf-8?B?Qlpkd0Z5M0hDT3pOYzd3bC8zVFcxUS9LbElWMzNZWGl3S2t2UldDUHFrdmdy?=
 =?utf-8?B?cVh0dVFHemZBQmI0R2sraGs3bFRIL2xLL2NwUU5FOU5GYTFLMG9KZ29kTFdB?=
 =?utf-8?B?dlJ5Mkw4QU5ta3A1NUxNaFo3SkliRElXRWx3VDZXWVVHaEgxemprWVJWUVJS?=
 =?utf-8?B?MjNXUTRnT0FOcnhqcmJPZ1RKd1BSWHJHa2RzQzdDVFY4MFdtZHBraG0yYTRP?=
 =?utf-8?B?MW1XNlRsdGZtRmhKcXZrc1Y1VXVMMnQ4cXo5RkwrcDhTNGtTeTlEQTYwbGoy?=
 =?utf-8?B?amRobFNOaWxqOVB3TWcyaVV3MnNTOGE2VG43dlJsYVA0TFkxRStORGhtQ3Vi?=
 =?utf-8?B?cW9ReHg0NklDd3RQamFrLy9qOGkxREdJSkFKRDY3djQzVW5XYlh4WkRVRlRW?=
 =?utf-8?B?Q1pEU21maGJGRXFoajNRdHlEcGdDZU9aLzJoQ2c3aFZkRHBodFQxNnVoTjEw?=
 =?utf-8?B?Z1YvYTVLbWp2eTJtYTBkQU5qMzlTQWR2dXhOd0VKNHJRRXVxRFFLSzNlWU03?=
 =?utf-8?B?NmRWOHdUOVVVb0xqemdVM3VkM0ZRNG5hSUJoSFFyckZNSmtWbWFhaXJKSjRy?=
 =?utf-8?B?Q0ppWUhKSC9PT2ZtRkczUGNSMGNuZ0tadDlRRXc2KzFvc3B1djlpN2kwdlVY?=
 =?utf-8?B?akhQTVh6aXlmdUxjQmpzdVEyZ1pTREpucGVJTVlaVWl3aDNidmZLZVRHSmQ2?=
 =?utf-8?B?dzkxTzdPUzQ1UG1QbHBVeFpUS01sM2RtL2Q0aEQ4OHZNVVVDdWNpQTZhdklu?=
 =?utf-8?B?QzBaYjIwa2FUWnVlQlhudGEvTWc1TXRHbG9jZndIZXAvVGhOQ043cGFmL0hp?=
 =?utf-8?B?aEJ1eXFiZlBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUF6SzdpZTRyOExtM0UxL2x5QlpYUUNtaTJ1aEN2Y2RSV1p2dzh2ZXZXMTRM?=
 =?utf-8?B?ZmNkU2lkbEo1R3g0MzY0QTZRTVc1THUxRDkvK3kzL21TdndMc3lpSlphQ21K?=
 =?utf-8?B?K1NuaVN6UmIreDBLdm9jZGIrVUpVZzhRTDE4QXVZK25ESGJURVVxUXdWaXpq?=
 =?utf-8?B?RWxoVUViTlRyYTE2K2VpVnlIcGRWeEtORkJFcFIzdW9KNzFKZWRCRWcwZ3Bk?=
 =?utf-8?B?SXF3eU5TNWV1SFFGMWJ6STZVRHQ2dmNLdDFHNzdjQTdlZ0tJcTZDVDZKbXpF?=
 =?utf-8?B?VEd4Q01uOERVSzVpOGM2bkgrQlprYlhzS05rODBMRmFrRFJibGZjWnE4UElz?=
 =?utf-8?B?YUM0ZUpFVGFGTVU4ajduVDJ3V2ZTNG8zTVVhOXFOenVpN25MSm5DOGNUTVNU?=
 =?utf-8?B?amVJNmxmUnZad3pFUlM4VG1QZ3BSRmh3aXJXVHkya3htUFdoRFUxaFR3NUFT?=
 =?utf-8?B?R1FGRWFXTmx0UHlEMEVUZEx3ajdwOFBSWWZRaTNKTUd2bGlFNzN4T0pTOEVZ?=
 =?utf-8?B?Q1FGK2NXK0dOWHV4TkdJWGF6OURHSTNHUWRVUU80eGpiMGtDTVk0K2tJYWda?=
 =?utf-8?B?WUJ5Uzlocnd5SUduTXpaemVZWFRNTXZhVGxTVmM5aUE1a0ZPOE9zMTZZL3lo?=
 =?utf-8?B?YVZyVTJmSGJOQ3dFUGlmNFVXcm92UXIyRjZBRC9FK2JrQUxINzFBNVNwcGc2?=
 =?utf-8?B?Y1dmZVRLQkhsYnB0WEliNTF6NFpZNHBYUmMwRVgwbitWdU1MWXhZRTh0a2dO?=
 =?utf-8?B?bUk3V1NBU0FKK2huVWtKRzBQM1RkeDVySUZyRy9mWEdyekNwV091R1Z6ZWN6?=
 =?utf-8?B?SjJiUVBHUXpYOEhKbmNqY1M2L0Y3VkNOcjAyV0MzbGl1RmdEbjljUU9jZUpR?=
 =?utf-8?B?T3Y2M0Flc29WeG4wT1BHeHNVeVVXUGVQaGxjcHZ6UFRYa251bE5NZlFGWE1r?=
 =?utf-8?B?SkVLd3J3US9IZWJhTzIrZVVaKyt3VXkyUE53ZllGQWh0V3VJc3BIdDIrK0Nx?=
 =?utf-8?B?eWdpN1N1N05MQUVWM1FMcERNam5kdG5zYVBkR2wyY2o3SjhadS91UFptMy9D?=
 =?utf-8?B?NDk1eWpBUUUvdEpWbWhZeTF4N3pnUnZoeEdkQVhMdTVTNHVyK09rMGhMOTZl?=
 =?utf-8?B?SSt3dUpSc0ovbGNBcFV6aEVoTFJXRlRESXphd1I5aVZPeS9xMjNEbzdDdHZH?=
 =?utf-8?B?T0ZUMmhoaWFmY2x0N2ZqZEZQbHFWSDVBYVBicnRKNlc3RTI5enFjQVRBYzhX?=
 =?utf-8?B?TnkyMGF2eXlleUFjMXlBMzROK0FhekhKUkdtdmc4T3ZoVjc1RzZkT0F6c3lw?=
 =?utf-8?B?S1NGR0R1WEU0SDdmaXVlVm5RZVcxaUxrL1BTUVRNZ0oyNS9YTDFia1dCMUtY?=
 =?utf-8?B?U0pWUndnZUlhc2xkR082VGVQRm5JS3hBMWNhN2R5ZjdaV09YZWdTZ1J0Yk5p?=
 =?utf-8?B?ZkZBSVZpMmFMQS9pMTlBUEY0Q1ViZEJuQTgwYnlNcUtreEYwWi9TVFljcDVU?=
 =?utf-8?B?Ly8yYVRxR3dQUU11ZHNpeUNmNENTVFE1Q2hGQy9zZGd1cG9WZVZQVzhFZ1dC?=
 =?utf-8?B?eFFhTkZJYTg3OTBmRmdUK1ZyL1lVTmczeFdLL2dxc0c1b0ZKdHh6R1ZhclB2?=
 =?utf-8?B?bFMvRDZDM3hqMFdKUDRMdUFkejl1T010cmUyZDFtdmduVUdxMy8rQnVSOEdp?=
 =?utf-8?B?M1lCcmVBR3MwN1ZyaGJuckRvNzYrVDhteVJNOG1rVG5kZk5UdjhnUk9NbUNt?=
 =?utf-8?B?RnN3MnhxMWNJTHZ2dUFuR2c2cjNSd3IzQm5maWVwajJUclVENXpDRTNBOFZN?=
 =?utf-8?B?TktLbWlneERJUlB4eEx1d1RlS3pIc3Y4V3VnTm8wWXU1TUZ2VlRWajRKMHpn?=
 =?utf-8?B?MXBaRlBxcjdDQ3dadENpbEpCWkVNWnBTVytPdDJBcmp1Rm1zQTN1QWZmUkZp?=
 =?utf-8?B?MDEyaDZxVlFFTUhlUzhkYlU4STdOTVI1bjZ4bkwrTFdtelkrN2M3d1F5d09T?=
 =?utf-8?B?Tmd0RmRQdkxJbG84NWs5NEtYRlFJY29UQVp2aENndzdsOEtCTHA4a0R4aTBF?=
 =?utf-8?B?NXNiaTVZYzAxSmhjMC9VNHBJUFhRdWpKSXhjbGdQRzdIOGZEa1d1d0lGbyt1?=
 =?utf-8?Q?fWWDM69VjB+18diWZcVtgI8EB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845b63ac-0bbd-4bf1-30a6-08de0c0a2ec9
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:00.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wed5bna7fdW7OccwJKew8AxhyAcWLi4dlcS6wVPYh6vCbmuas64SDrbqq3l42mQ+wepOw8QvEkGGd1bg19T1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Remove gpio suffix for regulator to fix below CHECK_DTBS warnings:
 (fsl,imx6sx-sdb): regulator-pcie-gpio: {'compatible': ['regulator-fixed'], 'phandle': 69} is not of type 'array'
        from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
index 299106fbe51c4ac1e9e0a70a4ec12e16b8110497..789a9aac005ebbe20e600dbe7bc7262ccbf74c64 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts
@@ -73,7 +73,7 @@ awnh387_pwrseq: pwrseq {
 		reset-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
+	reg_pcie_power_on_gpio: regulator-pcie-power-on {
 		compatible = "regulator-fixed";
 		regulator-name = "regulator-pcie-power-on-gpio";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index c7aeb99d8f002011a677ee50c7c849b9aab91374..3e238d8118faedd39a923aa90d859301516cd00f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -119,7 +119,7 @@ reg_enet_3v3: regulator-enet-3v3 {
 		regulator-always-on;
 	};
 
-	reg_pcie_gpio: regulator-pcie-gpio {
+	reg_pcie_gpio: regulator-pcie {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pcie_reg>;

-- 
2.34.1


