Return-Path: <linux-kernel+bounces-818412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F364CB5916A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0794D3AC122
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96AF285404;
	Tue, 16 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N1K/7rov"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13C029A310;
	Tue, 16 Sep 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013063; cv=fail; b=BMV83xLRpDwcUq8o7YgXoli5A4Z+rwbW+J+Vul7UKO7i6hos73DVgx4zctpxmVfohG3nb6OBvbTkeQBMHbPi4mHdmJZrlv9yjb3P3z/w7DJibRDrniSiTC9wFP47OeXHyvIFhq9LB2CCd3edQtt2Az1XPnvwi1w6Z02wgTbRark=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013063; c=relaxed/simple;
	bh=PYRiOB1lPtuhfcmZuZgN85t2G3dZoVVcLXJJ+lpqMb4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Pd2HBRJjconGr7McigFcJSALllOljystl1cJcP+wqIpNTzHJZNudv+KCKEBdqEsmNgNQUretVc9/Kex81RrSbYxp/XSygtSoJwisKNwxtwkEVSMxfQoTkZhv7V8FMSLDEKG9iRgqbbo20FmVlRwV4xLeQfHWBbvXZOnbMiZYf+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N1K/7rov; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3xzfBz2HrQmpkvN9ynDofj0hxXrtJAd2aXuRYx6antz+k5aXK/92dxqG9vDyt9tB2fSA3OfWwCeP8Nm4QCdOmk3WOKtHhrAQlaEoUVpndv9iHrzSo1kuI5dfvenioqQ7DY4yvKHOdxKabAqcf1xGT/uqhiRGGSjBe6qP47xvDy0jkRQhd9TDsrw1W6EFEYrV0TRZ/ZKt29KeXkVsmOK1sTHKJvIE1O+O/YbeFAshkrtlyeTRjD7+pR9yUbLnxI+rR2DCu9n5gvaNd5SSOyb5HkTbTCr34TVLLejuOx9srVMr7SRPJusFf/7NCaQFw0/TlRxoDm8KTszaWlpkJzj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MxBCVvK46wHCNMjoBCyvBFz/yWQ5zv6IrqnBvsNtnM=;
 b=FRk2W4MKhwr5HJYH3vZX56QcJbibPGn3MECcmvJpI52EbMIbdBByH0vJr2+8Z7zypISdWVLOEIYb5dnoWDIVRk8GyFfDiYEbd3T91KhzDTF2V+f+yKua+B92qTYmdrPQGSPzsPV1R5xSV3MiIuxWH981xUuLWBXbUe0UgDDf+bljm/JTQlSFAm7G8AFRlK2h2H9paCCeQhXd+0pWTpAETQIRhHd5DGakQDvGc+AH5bU3v5v6y/RlaiQyfYw1TVtdOjMTDFt/DBLwrpJSQFG9TNuVRqL5vqJFVcQEi0CYwqeT3B2+rbolZcSe7MsdWTNmOwxASm73wIfhzHJFwTzzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MxBCVvK46wHCNMjoBCyvBFz/yWQ5zv6IrqnBvsNtnM=;
 b=N1K/7rovGzkBXO4HY6B9MA3srjmI651auHuQzqIJFBhEKB/5+tDAdO9qXX6anhnBEPe+V7BuTdG8gAstfD/YTd0+qLe61RBEso48aLpjiDNgdEwKnQaosGmt8f7M7SO4BFTVfCAisTEb8T+oOzeHPTy5Dn3lSVaSEZ/puKkeZq7eZ3hmK5jB+6mD8XizvfQFR8J1x+uu3ehO6YyuiFWkW9e+m86P4ZazhTWQhMjiyAmlTAQL8Msfz0o4GrM/MmiNWn7szgsAGDZ0OT9PIhzi8QUZ2hGg3YXrDv45vng6qeF24rCc8AzJTq2unOT1gK56SjkDlwupT0Fk38UDSM/unA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 08:57:38 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 08:57:38 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 16 Sep 2025 16:57:30 +0800
Subject: [PATCH 1/2] arm64: dts: correct the flexspi compatible string to
 match with yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-flexspi-dts-v1-1-61567f969165@nxp.com>
References: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
In-Reply-To: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758013066; l=1644;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=PYRiOB1lPtuhfcmZuZgN85t2G3dZoVVcLXJJ+lpqMb4=;
 b=j7DLiZzYr/SFWLkXJ8joJgpwDzGw7OCaTE47qOWLDvqAlUCLdzr/cU32+PS9ihkgf7uQWS18w
 Y3Zx+GZnwfEAZv2SSZZ+Mae5qWQ0VfcplSm1CtUioXtQSmgAq9cQ6X7
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA5P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: df68e0ad-c092-4561-1823-08ddf4ff161d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTh5Y0pjRENVRGp6c00xdGNFR0xBSGVpUkxBanhEeFVZTGxnTDR5V3dQSnZ0?=
 =?utf-8?B?U2hxNzRyNlppd2h3UDlDUjk1VTljMlFKdWtmMDdxYS9iM1FBcjQrZllqK2t1?=
 =?utf-8?B?SUJsOVd3NzVoTDkyRVlSTDJDU1oyeDlGdmhId254OS9vVkpuNFZ3NFVVU0cw?=
 =?utf-8?B?dTVJRTI4K3d1dTZrZGl4MWNqVk12MDN6c294N1YzY2hubzRab0sxSmdRSGww?=
 =?utf-8?B?S3FHQnczRWtYbytZZkhQQlp4UkhnTUxNSHNzc3EvRE1DY205SUlpK2Z5TzdK?=
 =?utf-8?B?QjVaSmxNSjNFZXJtTUF2K3l6bmZVMVhOUjVyYWZGdmJNdmpvMVkwU015V0dr?=
 =?utf-8?B?TmRueGxCNCt2Y2NFTk5DYzRvWDR0TWlKa1A3dWVnTE5QQkg3RUcyYVAwK09z?=
 =?utf-8?B?OWxLNUxzdWxLbmtDb0MzWHlsNzlmWW9HOE91STZ3WVdOUloySlZud04vbit3?=
 =?utf-8?B?TjlRamtOalArTVB4RllCVEo2N1IzK3ZONERVblJzdVNQdzk0TXU1dkFqTkty?=
 =?utf-8?B?M2RaL0lFUENiNW5KMTlLUGpxbHZTTzhRQVJXcURPMEEyeHo0WlYyNXM5Vkdt?=
 =?utf-8?B?QUlzOXRNZEw1WFRRLzZ4N0t3NWk3aStpcGlGZ2xVR0RmOVBEQUVUU2dsR3cz?=
 =?utf-8?B?b0dNRCtiQTBCemZCWGJaM3RTNGxlZExZQnY4andiVGhDVWdQbGFpUi9nSFhx?=
 =?utf-8?B?MHduOXhDQ3M1RzV6aENhVzVyWkpXQ2QxL0JFdHUzMHZuazlOMkNTSFp0VWR0?=
 =?utf-8?B?SkdZZW55NTY4eWpsMFhpVXVVOVBnK3g5Nk5CYTRLQ3VVekJoOEZ0YWVhei9H?=
 =?utf-8?B?ajE1WWpTOUNDT2t5NTAxSHlaMkkvMW9laVNneWhDeXRyVmpwWmlEaHRtSTcy?=
 =?utf-8?B?Ty9BSC9YVVpDbStZSmVWd1hFZVFZQXMxb1hEUVB6SkwzbkVwN0V5dmZBZzVO?=
 =?utf-8?B?LzRuekdJeFo1VitMYW1VYkFDWFdtYTdXNEM0SHpDbFJSOUIrOTdTeU5aQ1dH?=
 =?utf-8?B?NWl6Qk1nZ1VkZk1mSEUwSkNUZTJ1RFFCZFdrdyttd1NkZFV1RlIvcGtRQ1hX?=
 =?utf-8?B?bUQ2bmFBSHRwaG5BT3I0dUpxd0NmMGpaY3ZOSjBLS3lGMjlJZ3YzZ3RIVjZz?=
 =?utf-8?B?TVZYNDFVYzh0NzdCNUY2cjJHYTV4TDRZMGRIa1czSTFoSzVKOExVSHhKV2tL?=
 =?utf-8?B?ZlFYOWhKaHBDbk5DQmZTQ2lYcU1DbS8yM2ZJZGdzZEIwTnl0M3pSVFowc21p?=
 =?utf-8?B?bmkzclphMmoxYXBQdU1iVXYrZ200bWNNSnplZGhTZkZ3anlzVlJoTlo5RTAy?=
 =?utf-8?B?OEp2cUtTVzkrRUxXUHZIbWdjZGE4VUl6WHJzQTRNSVZJSTVBSkpZSHdPZ1E5?=
 =?utf-8?B?bXVOZm0wRXBodUFtWWlVVWhWa0pyamdrZDViZGhsdTRNaUY1azFUcG9HTVJ6?=
 =?utf-8?B?V0JUb3JVNVJ1M2FtZXRwMlVMYThLKzJsTDZnQUNBR0l0VDhsQjFFOEt6TXdL?=
 =?utf-8?B?WnljVnhTUkxocHdrSk90aFBOVC9JUGY2dlpqY3JiNENCREJ2Z08yMjNMcTdP?=
 =?utf-8?B?ZUZLakxVVk02cnJiV2krMkkyTWF5ekJHQzYxVkY5U1dIaXQ2YWtVUjkrMzN3?=
 =?utf-8?B?dmR0dDdQT0dQVE9hUTJLSzdNWWlXNHdtbzYrMEZwZXVjbEFGKy9ReElpeElZ?=
 =?utf-8?B?aFVKQXRVOTZRWk1adzllbHpFZUxuQjlIOEdIRW8vcmM2K2pEM3ExWU9pN0Iz?=
 =?utf-8?B?TngwNHFIRU5ZM2d1STZHa1ZiamxNdm1CbUlvblRnVFlZeDVBZG1DK09hNXJu?=
 =?utf-8?B?eGt5Z1ZUQ1lma0o5OEhZTXY4VHN0WWo2bnI4dWhjZ3BtWEFZZlFRMk9FNFNr?=
 =?utf-8?B?SnlKRUlVc2JQZnI4c3N4ek5mNVJGVmlDaklxNy8zUm5WVWpNenlSeCtHYkNG?=
 =?utf-8?B?amM1WHJhVlNvZUVUbGJnWVloYmhQR3FWWjRhRElVWWYvTUY4Yi9YbW44K25v?=
 =?utf-8?B?dFVsekd5OVN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjh5TEhzZFNrdVNhdXhkS3FMeWErWkdFd3FvRzJSTUdrQzMrdURlei8rMXJP?=
 =?utf-8?B?TWtsSjF0QVpneGVHUld3ek1TUUlkYVNJalA1V0IvOVBUaCtUcmJ3V3g4K0ls?=
 =?utf-8?B?QzFlZDNjOGtjYWJ1VWRmOVFMT1QvTk1rVHVPTGJXMlg1ak4xdUZhWDhMZE1v?=
 =?utf-8?B?azgxNkFrbW9kQVpPREtKS3pqZGNLZXBla1Znc1JqN0U5OURFV002alM3MWdG?=
 =?utf-8?B?M1lWRzhSTTlNN2pJNXdyamVxZkMwaFFRS25LWEIyVGxLcU5EVXVMNTI1Q2t0?=
 =?utf-8?B?V2lUV0NCTzRjaXU0QmhjMzZzUFFsL2hjczc0RU1ySTlqK1dBMGpFQjljS2hB?=
 =?utf-8?B?NDlib0U5VTl0bzdqMmNtMmZncWJuNkkycE9JL2k4U2lpRkZzOUdJWkp1d3pE?=
 =?utf-8?B?TERYNlJ6RGZyYVh5ajZrSXFmdGx3SldmU0doYXRSOHpQSUNkeStuTXN6bENp?=
 =?utf-8?B?NjBheGNWMi9zalhZZ2hLU0U0K3hIc2ZRb3hibVJ1UnY1TDhjNUx3eWhUdmFv?=
 =?utf-8?B?akc4akxOTUlVdHBXQ1lYSEJ1Q2hpckRPdlY2ZEZCenRGam16RnVEZ2h5cmYr?=
 =?utf-8?B?eitYUGpLUS85eUxrTnhhMmhoQUFjZ0RPZUFNTE1hUVA4UjNvZTJsbkhOVVdG?=
 =?utf-8?B?TGdxN25mUExkSi8yQ1lvMGxFa3JGT21EVnErR0JvSFZlYzAwcG92dTgxaTdn?=
 =?utf-8?B?bTU3WG9KUEtaZGpEL0EzcnNKbFp1dHF6dEJPZUxRcSsySmI4L080eTF2d1NQ?=
 =?utf-8?B?SnNQNXExanRhTm5YL1NidjU0cWE4U2h1Kys2T1liV1FGVGZBanF2Znp5cEVt?=
 =?utf-8?B?Unk0RHJGYmpsaWhzYmhubkNkQW1pUXg5a3BjT0FwMDR4VjVadWdsNWMrNUQv?=
 =?utf-8?B?UW5wNGJzZVlZNCthUzFpekxWNURMbkVSZnRtZG5IYzZUdEt4bFFVbUQ3WXRt?=
 =?utf-8?B?NTdTbExlNGp6NzNzNkJDTkZpR282aE1weUhoSzRGc1BIc1F2TE5rTUFoWVJt?=
 =?utf-8?B?Y3FaeGhWN3E4TFRqeFhLMHErZ05TRUdVZWRRWkh5QUhtZDhWOEkvR3VrQ2Rz?=
 =?utf-8?B?ck1rVE5MOVhTSXRGRmJqaFhsT0FOUHlPeVJhdklQRlNmMmlINkpUVHVTR0VN?=
 =?utf-8?B?MDdFMGI3bWROeHR0L3k3b1BXZDVlV2dKbzFJdTkwczhpOFZEOXFlbWczRDU5?=
 =?utf-8?B?NHZwdTkvVG93YWJJbVNtVjFlMkVHdWpUdVhqd0hBdHUxU3JNRE40VFVxMSs5?=
 =?utf-8?B?d08rWW5ma0NocGVYcnVVK0pXWlJlYi9adWt3UDdIaWRmQ0w3blJ5K1NOQVVo?=
 =?utf-8?B?OXFkWDd6bCtSVlpmUmlzMm1pcEZQL0RJRS9VcjBUWGZRY1VBY1AwbEVFVjll?=
 =?utf-8?B?Z0lUK0cySVRhK1lVMWZqYVBTTkZ1cFRlVkZ4TWtLZTZLclE2T1R4SnA1US9v?=
 =?utf-8?B?a1kwWU9zbCtqWDhxWk5tQVVZYjEyRkdleS9sUC8waW1ZaHl4OHAvYjk1TnJm?=
 =?utf-8?B?Sko0Q2ZXR0ZMaXIxTXlEMWVlaUs4aWJHQ1A0QTVrUWVJa3pQdGR1WlUyZDY1?=
 =?utf-8?B?eEtZZjNJMEVTbTBPMGRrakplWmVDamdXcnYzN2hFaWRWS3N0NzFVb1I3U1Vz?=
 =?utf-8?B?ajNZaWtDWDNrbjlKM3VzU1AxRjBZRVJJbjFVWDdBZVRKT1pLVDB1NUtPMmNB?=
 =?utf-8?B?U0VlMkZIdUlwMDJsUmkreE5wZjdVTWFaOHNGcTNsWXNSSTgzMVhnckRDa1Yw?=
 =?utf-8?B?WEpDTGQyVktLa3VUSVBncEVaSzZjZWJrdlZsM3hPWEhVeStObkZNZ01HMkRv?=
 =?utf-8?B?Y0sxYmdqWDBpWHF0ZkkyUUFyZlpneDVhMXNOdk9sWDZYNVBCTnA0Zy9YcWo2?=
 =?utf-8?B?V25BR2M3aHl3N3dwOGNvczMrem8zR3g3R0twdURTejlCNDAvZ08rZEtqRUtO?=
 =?utf-8?B?eTRhcUp0TXAxOWxPSXR5Zm42eWFnWVplWkdMWVFFVnZPU21SeldOQkJQV1Z3?=
 =?utf-8?B?SmpHTjBjU21SMGlBNnVDaFhmSXVSdWNXSmZsSW5jZWU4STc2eWZVQ3M5a3dH?=
 =?utf-8?B?R3RWbnEvZW5lSDhsZzgxMHErY0pUVEJpblVqdWtBVVJUc0xCcHJlY2NUWjNY?=
 =?utf-8?Q?bJB6REGKpFIznEaGq6liULvcB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df68e0ad-c092-4561-1823-08ddf4ff161d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:57:38.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPtVhvOvJNhJZ01m69FBLCo8KnWbVAVWQcPf/iVtdrV2kfc0LkXtnH/8WLCOK3ASzbxTH0BAqeU7yd/KWupx5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
imx93/imx95 should use it's own compatible string and back compatible
with imx8mm.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 52da571f26c4e8a2703e4476b5541fa7aca52f10..7958cef353766a430df5e626ff2403dc05a974b1 100644
--- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -706,7 +706,7 @@ flexcan2: can@425b0000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx93-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1292677cbe4eb8c5f3ec2874a17ad6efd0111192..a0ff7002be9fa0529ba5712df4c056c56f0e3242 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -945,7 +945,7 @@ flexcan3: can@42600000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx95-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;

-- 
2.34.1


