Return-Path: <linux-kernel+bounces-836381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05BBA987B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CB53AD3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8F309DDB;
	Mon, 29 Sep 2025 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e+wTxiAb"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D226E6FF;
	Mon, 29 Sep 2025 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155873; cv=fail; b=RxhFg42e0OOw9pHkOnZfYMKEINLuKto28GN7/8YqCXq4bK3VkrbuJwN3xol55TfsF7Z03sfxqgc3CVjtO7F2HQdIrrc7fqOXip9YpGHZRu6t6jvCmoPBT0srWXL9wb1dZ2Y5m8qYAUKOgcAe2aRRi2RS7Fv55u20Lj2sqrbwDJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155873; c=relaxed/simple;
	bh=icBFyztIsa/NOSosyZIaaOciT7KlKcD6Ofi9v9wrrno=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hX6+sraqbm2e54wTaimusOPqxKcRAnF0nANgWFL9+a7wWJT9ZzdeP7jxIGEsSwMcVYvtWvM2kD6dUTKCMoaCUOdk5S17IJlCosIwee794FDPkBz7ViLm1Hvl5to9bhJ0At3daVaW/X1QQbYyFf7ejF0Z4vIOU4pSpTo6hsnfwf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e+wTxiAb; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtOKAOot5liVShHg5aYdp64Jlu7gN6FzeRZo2XYBH+NsrdUuRoywDXbtEFPoLX3zVz1Tkmm6111A4JrysGplSRPDxCCtPTYgFxof6J+m1g43+X4+35T55mNoa8PoZT4oKggqHTwck8IvElEYcQK4I40TkfvJHzyQCY5Vf+foWmZwGJ+HAbC1sjn+av98l16XqkpkVbnvGve6+IUIN9+KP9DZYycGrO4ZHuf1wx5cjX71X6L6tEa3YmewEGG1uWIi6CH7GJK6M73RvKFDWas8GxzDx2RFM3YO+sM2l4+n/jOWPCzCqvOdujpcxB5cTX1RVKvCiB4WjwUTZQ+visDMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4C72FEmF0TAAldjxHkoN/0iVEZWoEB7/zNFkH01ax0=;
 b=ZSyYdt4qbsriEX75ltCE2HOsEIsO5GlWMzDEJSoXsWNCEV4HV4h+sAInwpyn8fmYiGNcC3DGW6pPFvbK7IlXFPlVAf/5RkogAqYesIs3MBsqEEoRe7bFRKpqU0kPntOqP0D331sCJdkcerX3D/LYumnMgS9BQmGrUYggjTCeWQi9OuPqldDSqzKPGkbAOmR3rmUsTsPK+keVVB6JSzdTAmO11E7YB/rlgPT53aQyi4roM9kz7eHrQWslaR9dtfr0I/rMPBFT+zi6K94S3SgSP84pg/+1DN9BhrxGko4I26xxBT4PeR/60fqLJPAo4u5V7rRxviVsMzCpLcWvFgegtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4C72FEmF0TAAldjxHkoN/0iVEZWoEB7/zNFkH01ax0=;
 b=e+wTxiAbpGDooNartDOlUq82c+/h3Dy2RqgEq7GD7JHZYzTqtTVWnTpvkRvUuqJqvzC7tgEQPbopwbH2tj8pl4wme+SMAnl3+otu2yIn8aggZ1BOWCfzP2P88voqgKZ7AF4DkE8N+e0dyiZIdCAjnkw++HgaqoCsZKiKBNzc++KM4CVWy5RMGY6XC2SDwCf2rGzZWC9Nmr39mY07mszMtuCthKx38ZMJnA/ijWIn12sUUU6Pa/tdy34kCpqqAmILvrxQpnAjH0aDWtBrKrU2EavVlK8Kp39FggGdINuHnSJRgR4WRiTLE+OtKCe/4t/ZfUDgqBUO/gAhLyORFdhzMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:24:27 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 14:24:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/4] usb: dwc3: add layerscape platform driver use
 flatten dwc3 core
Date: Mon, 29 Sep 2025 10:24:13 -0400
Message-Id: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2W2mgC/4XOTQrCMBAF4KtI1kaSSTq1rryHiDST0Qa0LYkUR
 Xp3Uzf+ILp8A997cxOJY+AkVrObiDyEFLo2h2I+E9TU7YFl8DkLUFAoVCCPaedP9Y66hiO3xJI
 MgcN9WXkHIrM+8j5cHpWbbc5NSOcuXh8Lg56uP8oGLZUkLO3Seqwd2nV76RfUncRUNcCTV2C+c
 Jg4G12iqdB5987NK8cv3GSe/3KaFDG6j3X7j9vMQXNF03RBL+vjON4BjmtHJ2sBAAA=
X-Change-ID: 20250602-ls_dma_coherence-c3c2b6f79db2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155863; l=3875;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=icBFyztIsa/NOSosyZIaaOciT7KlKcD6Ofi9v9wrrno=;
 b=oRv51j7FJwIH9K+NJuJZfw0iPsej7OyUzfb/kATyfnLZZBVJblW9LwmS6rqTpxATfd5WJezQj
 yVpIsPcd+orAVDrikJsyapoPA6HyZ2Y/8L1qCP5/wyxdB9eMwNw4t3q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd65217-1873-4be9-6fe8-08ddff63e53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE5ERUJGU1AzdVVlZ0dEeVpMLzQzaStYQ1AxTHNjYU54VjhUUnZEaDUvSFlz?=
 =?utf-8?B?ZmtaVGpCN0FicTZYS2pwVEtyWW53bVM0UmNXN1ZIWU16NDVTUHJuMXJaLzhN?=
 =?utf-8?B?WTUwbHcvdE53N2lsSXB3ZDllZEpPMlIwMUZqNGhMaXU4bXl4MllYZE5QZHJL?=
 =?utf-8?B?RDZWazZjVHYrSklLanMxSy9seWJXUC9nSEVBazFKcE4zdzB4QmU5NUlXRHZh?=
 =?utf-8?B?cmw0QWF1bUlWd081WVFQMmVXS3VEWE5DVFMyVjNJdDF6WmxFd0psY0t0TmNR?=
 =?utf-8?B?NDlLSG1ZanltMzNWT3E1cUg2dTM4WVBkUnorY1hEWGwvbGZKZFJ2MUN0Q3RM?=
 =?utf-8?B?dWNnaXVYa2dFTkxRM214R0k5S1RiVDhLTllLUmNWRytXUk5NVndnWUxBUUJu?=
 =?utf-8?B?c0YvL3hiOU92ckhYYjJxejMrY1RUeFZxMlp0Sm0xWWxOOHlFTDN5cjlwWTAw?=
 =?utf-8?B?azcyajVSeU9ERWp1WFJ5MkZaUDJ3MXNvcmcxN2Y1TnVvQ3hreVA4V1llYzZ1?=
 =?utf-8?B?bmU4K3JKNGdHQTdOVGRBQUFvWWppc29kcDN5R2d4ZWFnQnVHeEMyUUtjaytM?=
 =?utf-8?B?clRFb25QWWZpRitxL2o5djdkMGdaT1MvMGN5YXBWUXZNQWVnRjgyWE5RbGFH?=
 =?utf-8?B?aUEzTitIa0wzdFh0M2JpQmRGMnd4cHB4QkxCSFgvWTc2Z0dNeDRkY1hDRUl1?=
 =?utf-8?B?ekxDUWVKYVFiWmdScUZKK0JaT25XanpZamhmK05VcUs4WlN0WmNtZkNOc291?=
 =?utf-8?B?Y0QwQXhnTi9ucnlsQjJNcEtHTkZvc1ZYZ1BGbGZKTnlPMlJJUm1iZTBTQVlQ?=
 =?utf-8?B?V25td0t2enNpT3lkYlZuT0hpSjZYMlk4bkhoOTkxVzUzKzE3YzRKdkdDdjhn?=
 =?utf-8?B?QXIvOTIyaGFORnJXUEQ5dzhYOGdqTWdFY3lISndRWGdrajZpMWNic1lVL3VT?=
 =?utf-8?B?RktFa01Zajltc21adEc5RkU1MWFqcmN3ZllnYldaNVE2WlBPN3Z5ZURIbUsv?=
 =?utf-8?B?TXo1YWdtbC9MeUt5MmJxMXNPQWpJaXl3RVpReWprRTFZekhIRW9sMUdiTU5k?=
 =?utf-8?B?RXNvemFJZTdrdkNEWDZWNTNvRVlhSGZDWm1NbktwVkNwVnk4NGxKUFcycVpS?=
 =?utf-8?B?QmhEMU4rbmpLcU1aRmpwdEpEZ00xZ29CMjFzNi9rK3BjUUdkVFRKSHEvb09l?=
 =?utf-8?B?TlNnUllGMG5tUHF3aDdaT0k3WFhncXlMM3RmNGRzb2lhcjhpSlI1OXA5US9v?=
 =?utf-8?B?WTdUMG1vMXhsdkJyYlkwZlZRSm8xRE05S0p1YjZjV3YxQkVkUmwvQkpqNmc3?=
 =?utf-8?B?SWRkZU9EV21wKzZ0NjJZcEZuUHJQQXJsNEF5SzlpQXE2WnNYUVdUdGRMSHRN?=
 =?utf-8?B?TlpQU2xYcXJGNVJpc0ZVUlRieE53Rk5YbU16THBpaEFBdjgwUmpUSjdsR1RC?=
 =?utf-8?B?VGZyQzVYMlIvakFOT1Vsd2xINXNvYTZiVEVsckxGUlI5T1ZKdnN4ZmlZVXBr?=
 =?utf-8?B?RWVDNDdnQlJXTGhaWisvQTZkdG5hZ2VGTXZQZzFiWDBpaDB6Q3VUWS9sV2ZW?=
 =?utf-8?B?Vk1rNSttdUR3TE8xKyt6OXI2R05nQWdNQlRGMGtIMGFRMTRtVklyZzJ1VWp0?=
 =?utf-8?B?VjRhZ1hFUGFsMC83a0ZLdElOU1ZFN0txR05ub2MzZzNUZ09wNmIvQU1rc21Z?=
 =?utf-8?B?ajBzMThvcUtEcWdCTjd5S1RLcWpyNWtVb2NoRkpveEZyYVN3NlBkQW0vbkxt?=
 =?utf-8?B?RG04eHViSktXSnJqenN3dFkxSlZucjVXbTFaZUk3ZFVZUlJsUTg1bzZQYVho?=
 =?utf-8?B?RDBZcndYOWZEQXViVUJXQ2V5L2lVVCtnS216VFhZK003Z0hrR05UNjNRVXlh?=
 =?utf-8?B?N0FrTE5sSk8rU0JMTEIvMmp0R29mcko4cGZCOTEwbXZyNXY0WXU2M2RBKy9v?=
 =?utf-8?Q?+Ec3FsBBzio8apPnHG0DRGg1tUkMxjDv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE9rTW9GM3BYcCtxYUFLdGxqOGNUb0lKZWl5TnRDYzhLTTg0Y2xEMTFzeDVK?=
 =?utf-8?B?OHlFenpoYUx6UHNXYVpFK0xEMGlxdkJjaUhnUlhNZmpFdlBwZWhRcnI2c3gv?=
 =?utf-8?B?SGlGSVlTRnB5NDVNUmF4S2E1TzA1U1RwcCtWa3BUaVJDb3JaUG5xNEF0UXVL?=
 =?utf-8?B?N041SXBFMHZCcWlKR1FMVTM5cStNNDZGcGN0NUVqZW1MbDhoK1NJbDdJbDEz?=
 =?utf-8?B?cjlDSVp3UldZbU1rdjJ4STMwWW1NZitKZzM2S1loSTJqTGtqUVRDaFRPdGpx?=
 =?utf-8?B?T21OalVkU253TEp3N1dsMityTzJjSE1Kb1diYUhDSEZjd1ErajJ1S08rdzZ2?=
 =?utf-8?B?azdpVXlMSEl4UFVHVG1VeXNpS0MrUTMyQURpeWRwOW5CbUhXVGxlVnl5UlJU?=
 =?utf-8?B?WHRTYzd0b2R6YUNnLzdUemtUUXhUUXlXWEkwaUlITlVPTnA2Mkh1aXhENEk3?=
 =?utf-8?B?NWdldC8zVVJRTk5LOWhTbkM2T3AvMVVVbGl2angrL3lNbVlXVmNHTHZHQmVJ?=
 =?utf-8?B?UzZoVUlRb1E1Tkdmd3Fia2dXN2cvZWZpMlhaNytYSXNZVFcxUmdyaHlreWtL?=
 =?utf-8?B?bG1zc0svYi95a2hlY1kzb2RYKzVrLzBiRUVoOUZyV0VGMG9DOFAzaGNFRGEz?=
 =?utf-8?B?MURIcmM5Sm85am5LZm5KbG04SDBpQkMrS3JLTnQxZ0RYeWY2amdxbW5DMTBL?=
 =?utf-8?B?TUJnUldabTZUT2R0N0N5R2RRT0ZTUHBraE15V25wMmp4SFRHNENGa2N0aVNu?=
 =?utf-8?B?aG5raGZSczFBN0F4NWwrMTBWMkdhcm5EOTlrSkhJYkk3VWhHTzZLNnNFcHg4?=
 =?utf-8?B?OGVWUlVvYWhPdExJbWhXVHlwSmVRNFRUdk5ZMEQwSDREUEoyY2dxM1p5SzI4?=
 =?utf-8?B?ZHExck9WNDZOem82eGlCYUZReHN4eWtnOE9yeWJrS0hwL2Z0ak1jakVFOU5a?=
 =?utf-8?B?eVZwZ2ttU2ljVnFTQXErYUE2RDRFZm1uaGYzcXF6em83TTZLclM2VFo1NlNt?=
 =?utf-8?B?aHpaeXk4ZTRkYThaU2Y2RnNTVnFFVkF3WUVhU3A1dTU0VE5pODNuNVkzclRF?=
 =?utf-8?B?dFF6Sy9nRS9nUHA0TEpIbFE1VnpjcDN5WUVBMzJodGhpYkJVdnJCOThlaVlW?=
 =?utf-8?B?TzhWazdZazE1ZmNjdkxPZDRYbUYwalo5VVdCa0ZTK1p5QXY1akZ3dzlQRGsr?=
 =?utf-8?B?Z1lUekZibW9YVkRNR1FSNjlQSUF3bW5xUlhSRlhDeXR1NG9UOXpPWGJwRTRj?=
 =?utf-8?B?Nnd6SExTSWNQU1YwY3NzaWRLUU1aUzhqRlVqRlpkcFJ0dzVVNDQxUDE2WWJG?=
 =?utf-8?B?RWxYeUhrcHNRMmdYUDFSWjdzWW9LYlNiYnl2VW9Ebmo4QWVva2hneVhJVnU2?=
 =?utf-8?B?ZkpWVEpnTlJyRFd1aldCR05Lek84Umh5bDhGUDRHUHZFTzN6dmNLM2M2MVVi?=
 =?utf-8?B?SStsMjN2ME14aUVsT0FCdDRNTXFoTitMbHc5OHZWZXhtdUM1bno1dnpBQ3dH?=
 =?utf-8?B?RnphRVFveFJJYkYyLzRtOHd0cjcwOHA4RzRpaVJ5cWpzdnpXT2Z3cFBSaWsy?=
 =?utf-8?B?VVR3dE93Zit0cHdSbFRFazBNSkhPdkgwUnRXSVUxWEY0M2RRVmNDNWI1OHls?=
 =?utf-8?B?YzVwNy9YV2phaWtLa3k5WEFnQ0FXalhVY0JSQ1c2eFM1dlY5K1RrMyt2d1cx?=
 =?utf-8?B?dllCOTVjZTZnVXI1MktUYmRkbUtYaHJIUE40Ny83VS9uTkNhWG1CTXpFL21v?=
 =?utf-8?B?alFXYWl0RXAyeHVHZUd0UUJLQmNodDNrNDBEWVoxQ285SWRnQjI1ejcxa1VT?=
 =?utf-8?B?TlZrbEJCRU55YU14akFSOHRacXBqazBabm1RUzU2VWdQUHh0dytaYnJmS24x?=
 =?utf-8?B?VlNwOXVHRHh0SC8xZmdpRmhQeWM5UXcvc2JkUTJVek5QYkRiT3Y4SnBsdXV0?=
 =?utf-8?B?SG9wOFI2UWs4R01UdTc3S20rdjA4Q1VaanJROGFsbVVlUFQyUCtOSnlUWmJy?=
 =?utf-8?B?Q3Bva0JhY2dtT2wrL1QxaVIvbFlyR2lEUlMrUGMySUIvQ2N4dWl2OVFSVEkr?=
 =?utf-8?B?UjQybTlFeVlFanlWRnRBUkU4V3graG9MVXVCaWFVeHBINndnRlJPaFhSNFFi?=
 =?utf-8?Q?rva0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd65217-1873-4be9-6fe8-08ddff63e53b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:24:27.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTjiIEiWhPRbNgSwYw9XUGdAWA7lJK6mLiuo6bS+AVsjYZGd14vQotmzDn8uRm79wTarfoy+LaYAyR4n0ZSLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Add layerscape platform driver use flatten dwc3 core to enable dma-coherence.
It needs set gsburstcfg0 to 0x2222.

There are some several try before:
[1] https://lore.kernel.org/imx/20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com/
[2] https://lore.kernel.org/imx/20240123170206.3702413-1-Frank.Li@nxp.com/

[2]: add new property, which was reject because there are no varience in
the soc. Fortunately the below commit resolve this problem by use software
managed property.

d504bfa6cfd1a usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

[1] was reject because there are not actually dwc wrap at layerscape
platform. Fortunately Bjorn Andersson's below patch to make it possible
by use correct dts dwc3 node layer out.

613a2e655d4dc usb: dwc3: core: Expose core driver as library

This resolve problem [1] and [2] by use flatten dwc3 core library.

1. add soc specific compatible string at dt-binding.
2. create platform driver for layerscape chips and pass down gsbuscfg0 if
dma-coherence enabled.
3. update layerscape dts files.

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: bjorn.andersson@oss.qualcomm.com
Cc: imx@lists.linux.dev

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- remove of_dma_is_coherent() check
- Link to v4: https://lore.kernel.org/r/20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com

Changes in v4:
- Use flatten properties, instead of use dt pass down information to core.
- Link to v3: https://lore.kernel.org/r/20250926-ls_dma_coherence-v3-0-602b1c0ce6b4@nxp.com

Changes in v3:
- skipped, accident sendout
- Link to v2: https://lore.kernel.org/r/20250923-ls_dma_coherence-v2-0-ce3176396bdb@nxp.com

Changes in v2:
- base on drivers/usb/dwc3/dwc3-generic-plat.c

commit e0b6dc00c701e600e655417aab1e100b73de821a
Author: Ze Huang <huang.ze@linux.dev>
Date:   Sat Sep 13 00:53:48 2025 +0800

    usb: dwc3: add generic driver to support flattened

    To support flattened dwc3 dt model and drop the glue layer, introduce the
    `dwc3-generic` driver. This enables direct binding of the DWC3 core driver
    and offers an alternative to the existing glue driver `dwc3-of-simple`.

- Link to v1: https://lore.kernel.org/r/20250602-ls_dma_coherence-v1-0-c67484d6ab64@nxp.com

---
Frank Li (4):
      dt-bindings: usb: add missed compatible string for arm64 layerscape
      usb: dwc3: Add software-managed properties for flattened model
      usb: dwc3: dwc3-generic-plat: Add layerscape dwc3 support
      arm64: dts: layerscape: add dma-coherent for usb node

 .../devicetree/bindings/usb/fsl,ls1028a.yaml       | 33 ++++++++++++----------
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  9 ++++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |  8 ++++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  8 ++++--
 drivers/usb/dwc3/core.c                            | 12 ++++++--
 drivers/usb/dwc3/dwc3-generic-plat.c               | 13 +++++++++
 drivers/usb/dwc3/dwc3-qcom.c                       |  1 +
 drivers/usb/dwc3/glue.h                            | 14 +++++++++
 11 files changed, 88 insertions(+), 30 deletions(-)
---
base-commit: c45d2c21b3889c520bf141d576eaecb25666895c
change-id: 20250602-ls_dma_coherence-c3c2b6f79db2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


