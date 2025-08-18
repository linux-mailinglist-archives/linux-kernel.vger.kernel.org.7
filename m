Return-Path: <linux-kernel+bounces-774477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734FB2B2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFEC178D28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D963274FFD;
	Mon, 18 Aug 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="amiNZWxs"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C9274669;
	Mon, 18 Aug 2025 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550121; cv=fail; b=CTFSpgPwhCS0hlY00ebeqmjlktLcWncUu+JhRwl/RV3EbGIU+wQ7xAqCTCu5jC2JoLPg4Mw5Y0vW8XpfqdaxAXCecDw/K/Q+Zf/mJxYO29pcleu0hdsyp0tw/a9CZ1gaXVR9Ln0lv5WWmxV2sFLsjl2x72KgVet/hJm7QF1+kDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550121; c=relaxed/simple;
	bh=iHWba/eFT+y2/HWha/lh4lli0ol7ab86fBaoM8IzlHs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jb6/xeHLls6r98uOPBzCTxIzali5qUynzZ19JJGMjCkbWTQH5hGS9k9Dv4M0hMGVi4uOwiJooHWBkqo1N8sQU8azCGt8C5YUZ+trEGKEIhQge3BAKSF1tmKY0E31qNH9RHfYtf/BGIuSWHtX3j5Jh+pqNNl1PMJlD+da1QSjTEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=amiNZWxs; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3xY/DeeuU7ublrW8VKLMcfPcw1x/PolMv6O98blI8R4WSIQu4mvRWCUu7YrAo+GV0tdi8/0IY8qjzD1uEqI76xmlsF+qo22yfh4morfB7zasE21xLu4KaJ7O5jRqB/oZ2IIvq9Oes7A2GWmrPRmbnL+IDclXZaKoB5F7sUJRdpzfOvkNCO8NqFpPEHzq3ZX0YhSPmUK697mcXHK+YPKWJzrMT9hX5qI/1JDIYJaYXbsHmkE6Qw9VKQktGi+A5HIKLn/PvTLe7iZ7JQFjFC8ZaCbugUKNFBrm3S17omp1IkqfCPlwdNoSQTfLwaeP+7mvDbsn5J0Njs+94PPv5kgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONDw5EA1Dnme9vjiLgN22ND8627isepCTUA+Z61llBY=;
 b=hZ08pR543udP+l5ah5xZNNn/4yPzIf5kC5bfa13PN7NravdGnyc4E26zMjPdy6jCQhopgtwhQuzdvgn2Fw3NnS/4zEv3bRmhhVG1iY0qXjW/Xl7Ix2MqrtH6H4JGmvgr4CYhXnHzatJy7j+Ymh2sVp+MYYprpMnSDOO1GTIkmIh8BYNTgBFCDnHaDElzxcekE9B05kfsekeyIjKNUZssyJ+FXrmRsqJSkV+e60hrmLYioxGek5/yLrr6BAkNz0t+dtrjHKYvXPVjtvosYLyyS7LfnbYHcIAZAkkBm4ZT7FXDLydLrujYzQ/QO52+oL80i33Ca65+b3ky+VPuLezSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONDw5EA1Dnme9vjiLgN22ND8627isepCTUA+Z61llBY=;
 b=amiNZWxseYJdHWgxJhLPya4wyLY+P+mTi5dOj6H8paepeDbuEu6DaTZEf7lBiSnuUoQmw1Wt6nlejaz2X7zL1FiPTX29RcwI0Ka42BewJNx0/L3gNe2APxT5BTMp8nLUP8tG0CE+epFHXvDkHlkIAmqfybK0992zd1obJiVzdmUz/sjxXmu0gUWbxS02V3lp1B39G77Zku+/WY23PbUqoigndYxty7DJCJCfrDlaBZK9a0pM/xx1Ny1S+GEQAqOLKkToBenextmfApsEla5hqg+Ik2k+fOn4GRob8EMtyvz/1QeYT+mfZ3JdZqeMhnwfFC5wcO8hact3gJ6Zd4GJ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:15 -0400
Subject: [PATCH 04/15] ARM: dts: ls1021a: remove big-endian for
 memory-controller node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-4-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=972;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iHWba/eFT+y2/HWha/lh4lli0ol7ab86fBaoM8IzlHs=;
 b=W7uTRkmvKms+ZRcp9gKUNSIiCzZGwPG0InQdlkblE/1QkqCRKcVBOY7fUd+nQ2p516lfFr+Px
 Zos89dsECpwAtJFMXdWu6W8V/qRggp1RWyuiSBDZ8Anj8Flblnd/TN3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4a88b4-f100-40c3-c071-08ddde9899f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNuMW5MYWZmaW5uNFJSTk9RdWgyalFwNkFTb2t3cW1HOGtTVXByRzhyNWpQ?=
 =?utf-8?B?bXBZSXJPbHVQVDRZZk8yM3lmQlFPMW1BMnhNdXI3MzNXUUlqWDlTeGdWK3Fo?=
 =?utf-8?B?ZTVYWThXemxDV01YOG9SeDRSYlhOamtrdlVLOWp2MUJuMSt3N252ODd0cGho?=
 =?utf-8?B?NVQyWk52R00vbERyVm55Ny9iR0QzYisyOEJIaUFsSks4d1o4VmtqS2I1aEZq?=
 =?utf-8?B?bHBqa1hTbFVuTGR4RDJnblBGRWtValcweUhjQTZoeW5YZWc2RUN6M3c3bFZn?=
 =?utf-8?B?YUdDWGQ4SGFReHVlbGVnTjQwT0duTHlMV1hCS2ZGUWY2RGxSek9RNXkwTnJZ?=
 =?utf-8?B?YnRFNGRKS0cvSDZUYlVjMGhaNWV3M2hXNzg5dC9xVldIeHpSSHJuSXVNdUxR?=
 =?utf-8?B?MlgwRWNvU3Nxb21PYTJQWGdscDRKSytuc2RWcDNKcjBWVXM0OWxoTTNmSmZ0?=
 =?utf-8?B?S0tqUzczelNNMmF5SUptRllLcXJaRGlRQ0RyeFNKWUxUYnhVck1lTlBBR1VJ?=
 =?utf-8?B?UEdDRkZaSDViRnhBVUdlRmt2QTY4ZzA3YWxSelk0SWtRaTNXcG5ZanZybmoy?=
 =?utf-8?B?Tmk1Y2RTRmVnNUpVOHc5NUxBdzBXSlV1cnFkaEo4WDY3R1BzaWIwWW13NjFv?=
 =?utf-8?B?TXBTbndJdWo3aWh5bysxY3gydEpIRDVIUFpHb3haNDQ3NGo3dzZoM0FtRnVW?=
 =?utf-8?B?N0dkRlNZQ1lrYlU4RllvSmJ4YjU4SFQrOVFPWWVJbW9DamcwUTU3UkQ0Rnpn?=
 =?utf-8?B?ajJLaWxiVEVRbHdYVjRQT1Jqa1hlNU1OZDhNaENMeWF5aTJmOWVTKzVMMjRW?=
 =?utf-8?B?QU1xcHVUTkcremZHSlc5d2ZZbm9yK2s2RVlTWGxIRzN5RG5mSmd3UXZLMCsx?=
 =?utf-8?B?RTM0QjlDczRGVlJUYVE0Skw3UzhUbW1qQzlTc3NUeEpPaEJWSGZvUVhTbnda?=
 =?utf-8?B?RWNIWkZJeEh4WnloMi9hQXplWEZiVHlWRVNyQUo2SVcyeVNZbXhmcWhvajJT?=
 =?utf-8?B?ZzM2aU5yR3QrUGRqSGZXeWltK3FUNXZlcHpUNEQwWTNhWGVPelkvcE5MdHB5?=
 =?utf-8?B?bUxNYmYySFNTaGhPcDVuZ21MRlpSenB1WThCQXF2cnZETzBYUkZKeG1XSk13?=
 =?utf-8?B?K1hzZ3hXUGorMnNkZUhqaXVsbVBtd1pjWFJmRzV4bmUraDBIdU1OdXFWTFdW?=
 =?utf-8?B?b2U5K3hOQW5TR1pMNEozL2NBRHZMOEZSWmJicFZDV1IrVVRDa01LQ1ZWbTJZ?=
 =?utf-8?B?ZmZPbk5xOVRjQzZWMmRtVStyajNEMTQ2VWhRUHJpV1NKMlo0Y3JUZWY3N3lD?=
 =?utf-8?B?MGp1cVlGbkdKTkE2V0EvNUNLdU8rd0lqWEdIS0szUisvOVpabS9ZQVRzNmVJ?=
 =?utf-8?B?aFRWR3Y1cUYvUER0M3pHV3NyZHNZK0NjSDZnWHErcXRHSmRaTjdoL2xwUHdM?=
 =?utf-8?B?WVBXS3l6dEVaYWtFZG1NclJFc3JoUGZLeGFlWkVLb2oramhMT2ptMS9BQmhx?=
 =?utf-8?B?dDZlN095Q3d1aER2TUlZdXgvdGVobjJrSDNpUytJeTJBa0JVTlpDRDRZUERl?=
 =?utf-8?B?bkVJeGVYUnhsZUpHMFpBTXQyOUJBdFY1eFZmS0E3blpwb2FhM0Q0NE53SThu?=
 =?utf-8?B?b05zK2F5SGhFbkJaT3YyV1BGWG9uZE5NWFUxejVqQ2xOLzhWK0dSaS9ma1ZH?=
 =?utf-8?B?WHdpcWZhR0VzS2ZwVHpSeG1ZdmhoVE1BSW5HMVJhOXc0cndiMEFVNXh0blkr?=
 =?utf-8?B?OHpiL2EyM3IwcGpmWXdseVNURXJtK0ZVbG1VSXhXeU1sTFFpQ242dDJqaWJI?=
 =?utf-8?B?REk2ODF6QzNXN2hYYTlTZlFTLys4V25JT21YNmxwR2xlbTYzOHpHUDZXZXlN?=
 =?utf-8?B?cWdyelJJaEVTOFR3T2ZteUF5QzViQ3g5MXVoL3ZVcnFHbEZLUXlDQ2ZtQlBN?=
 =?utf-8?B?R2Q3ZEMyaUJlNG9Gd042bWthLzVtOUVVaHJkSi9WN2hSaWkwOU9BQW1XMnBq?=
 =?utf-8?B?UHE0VUcyM1dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmtxMjFZTitOWXdGbnRWUlBhYk5QNVY0RUppcFk2Vm5sUDlkalJiWUM4SUgv?=
 =?utf-8?B?QTZaTXkwZTY5NjhZZDkwNS9abjhOVFFzRUdWVkVnS3M3SXVtN1JyVVBwZWNG?=
 =?utf-8?B?QTEycWxHRFpWK0lqNVN1cXhFZW43WFd2WTRuUFZRZWtvY1NtV2lhVUk1azl5?=
 =?utf-8?B?a3NIYjRISHV2VlJBd29TKzU4Q2I5bWMyamxjalJwNXpNajJUR1JYYUxqczhz?=
 =?utf-8?B?SnZ6ZEhqbDdsQ2ZqUWRGMnc4anY1MTgxeW1WSDNkY0N4K216c2xtNmtsNjZu?=
 =?utf-8?B?VkFDSGg3OVBDR2ZBVnM4NGp5SXI5RzRuK0xGb09kaW5yaXY2MnBTd3dROExr?=
 =?utf-8?B?ek5RdlRWMzhUd2ZYdWJPMmE3Vks3RVJvSStzNTE1azV1anBFYVQzNXZ0K2Uy?=
 =?utf-8?B?eUpWUW14SWxBT0NZN21YeFFRRExjVGl4WjQzZnpxbUdzS0gzUTFqRHpHZDVv?=
 =?utf-8?B?RlBaUjF1WUJUZ09sMjhBek02NStJa1d5QjM5bk5NT3EydE1wcndKSFpOQWpL?=
 =?utf-8?B?NkZ6azJnQ0RyZzg0eFYrYlpWUGNtOWtkZHBrRTg5eEdGSVdrQVp1RmdTQ3NK?=
 =?utf-8?B?VlZwK0xLUGk0WGFtbFJFOGRiM01kOTg5SXZrcDc5aTlnL05GWXJ2d3hiZ0FM?=
 =?utf-8?B?eTJ0NEhBYWdnM3AxelVmYkZNWkVkSHcvS3lHcUhKakZ4aXE3dFBabU9rbXN3?=
 =?utf-8?B?RDJWOEVXNUVTZVo1OFcrdmtmcC9nREFaUnQrQ1dxc2pJSmVzb0dCRTFoYmNG?=
 =?utf-8?B?WFU0REFsUVJrVXhxb2xsUmZ3aXUvZGxscnQ2ZU5nNFFKNC9ZaTh1bXYwTlVs?=
 =?utf-8?B?L2E1N0dmVXNjUmJLRjM0ZUJnSHpFWHVyRFZhejFyVENBVW5HemtMaEg0NGRH?=
 =?utf-8?B?am04OTVzbzgzamk2M01rMU93bGJxMkFwb0g3YkRFMEpjL0hmZHl5QUtyYTht?=
 =?utf-8?B?N0pRdWgyN2JONFNkcTRyUThTZTZiYXhpaXZJZ2RtSjVjMG54eVJPME5mdXRO?=
 =?utf-8?B?U0RxQW9BZDA3UmI2Rlc0dDVvU2YwY0FtVmZtVE5HR2p6dzRveC80Z01hcm1D?=
 =?utf-8?B?cU95Y3BnUEVmM3hsM0hUUGV1aEZSWG96SUtENnhMaGpNVFJhem8zbHRmaXBZ?=
 =?utf-8?B?d3ZTelJRSW82ekdOSlFXUk8xU3Z2RitSclRXd3dydUloMDF1bXZPcmJqRFVP?=
 =?utf-8?B?cFBkNHBIekhpemdJVUxHakhjUGQ0ekQvZzRZRTEvMUpCWm9DL1gyWUljY2J1?=
 =?utf-8?B?cnlscnJFOVVoMXo2M2x5NkRxTVNPNC9XMUtHaUhLaVFqK0lueE45K3kwelhN?=
 =?utf-8?B?cXNrLzA5dmF6OW5pbDdLdWhTM2JHVHc4bEJIUCtYbHlPNlE4a2lDdXdMYUV6?=
 =?utf-8?B?ZjlUSGJ1Zi9qMTVscWtyVVE3ejR0amMxQklacGZVUUJDZlY3R3JTZDYzVEVn?=
 =?utf-8?B?VU42ckpFVHYvSXV2RWk3RWh0MFA0SWR4Q1Z1U1J2RWxIY051VHRaSXBmbHdD?=
 =?utf-8?B?Q01ZajNFOFVhMVJjbDlrUkp4WnhsWVZTcTdzWGVLelpicDZQZ0pSRWhXRjJ5?=
 =?utf-8?B?K1lzdUd3N3JXcjlkNXhKV3pNSS90K0dYdW56aDZRQ1UxRzVzNkxqajBBeC92?=
 =?utf-8?B?VWs2MVg2WmIwTmN4WFhkV3g1bThzVmN6YzRKU2lmbzlQY2NTMkJHdFZtbTFp?=
 =?utf-8?B?dmFSSTRhbEU1VWZlaVZjb0s5WjBLTVJWVzdONFFzM1BCZkh1SnJDajNJdmEz?=
 =?utf-8?B?bFZCM2NiYWE5Uk1XZWpIS0diYWcvdGNZdVN6NGVuN21IOTd5WUxhUjFnZ21X?=
 =?utf-8?B?Q3huQnBUZDQ5bGZ4cWdIa2JINVJjVlhNRWNaeEt2NkN1ZEkxSDBwV1pIZ0xU?=
 =?utf-8?B?UTFvNThid21nNTZ2WkZQK1FKamJPa0hDVVVrdjYrNFNCSFpTbnNidmM3bGxI?=
 =?utf-8?B?VnR2bW53aGcxSzlPdWxIT3grZFlta28zQ1JLaFpvNmRzeUNvZGNoZE5ZRGZM?=
 =?utf-8?B?ZkEydG5QYk9CVjRVRkRwV3JLditVNHRSOHdIRm9ZSC90eGVJbHppTVlMaEdW?=
 =?utf-8?B?UzhOWHREcWwxSkEvdG5NN25Ja2N0dU5pYy9tSnhNamk5QVBKdEtRYTFlL21N?=
 =?utf-8?Q?zveWxn+jR9GmD0BAT2E4ALGHm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4a88b4-f100-40c3-c071-08ddde9899f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:35.7283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2Om3ZXHDAj7s7q03FUu8Ez6ZP8dwsmV7fQrr8tBRw/HzDNRjl62uFIOfHzJjFEcgsg8V3kcZEQrPYtcHivW0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

According to binding doc memory-controllers/fsl/fsl,ddr.yaml, default it is
big-endian.

Fix below CHECK_DTB warning:
arch/arm/boot/dts/nxp/ls/ls1021a-iot.dtb: memory-controller@1080000 (fsl,qoriq-memory-controller): 'big-endian' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index ba354c48a9cb4c962599925017828a089fc5a4eb..a4c16833dff0f33d0093a7d1575a9c67c94aa1af 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -93,7 +93,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		gic: interrupt-controller@1400000 {

-- 
2.34.1


