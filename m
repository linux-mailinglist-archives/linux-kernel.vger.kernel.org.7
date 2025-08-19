Return-Path: <linux-kernel+bounces-776428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F51B2CD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B94E4B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E883431FC;
	Tue, 19 Aug 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bOFXxoWb"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B2342CAE;
	Tue, 19 Aug 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632683; cv=fail; b=R27Rb/9ldHOXx8ih1VHV+l3MSSXXC4OyJYYrvSFuI0+o/ZIkSvysM+81GVs0i+Me0A8VuTml7zRuJ4SnU0y7h/QSmt6QXORu8j3bTJrmBaXciGvRioHEFK+pnbjgUYFOjKPtQ+d4ms9NCgbboSOpik7i2LxEJ4MtMFU2JM7KMRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632683; c=relaxed/simple;
	bh=0LqINnyQsqNKvIQOWLLNyzE4LQalSxQU2pFiI3j3KB4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lb1+9qOk9kIWALTeWXrUQ39Ej2MizzDl8s+f1UR14V1Piaj7V8z6LnhM7dfbjDg9zLeyOlhuezkskyrM9gwVDy0NN3sQLHUSarN/ScvNy8qeeFWVBzy9Mcd+KHL4Roaj6lZcorVGrNrM4QGnWpDJCcj3tymam8qRWKSZup+kyGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bOFXxoWb; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVy00GbOp29rHT0QOLlOVKD8uDX1WByoyuXIFoY1wyOa6Dmkq/01q9g60CsgSN/MwSlWxmcb9CC59jA0RKUwd0bqQSUb9bafa3pdKgSMCJIj/zNJfPX14OWiHzykI68uGuI1VCZOrQhY5sD04/qPL7O0ZqhWvCUIR6xHD94RiWi35WVpmHWkvncHuW+Fl7ccQv833qe+Fr9BKMy1NsrnRpzuwlKxqUBafH160cBsV+to7vQ+F9v9HVRMQXCg2MJxiHKF5eZp8Da08DPSFF6u3xpbZhsLcp4WCudPTQVlDx1DGt2KJ2aDOe/j3x1YpFMUUfyb6udVErWRbwmpUpj4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O5yLnvcQDNtyaoUy+tcVUE+F4aCrNzBO38oEi+g+Zw=;
 b=oWpR/iaPUcY0f7Kq2lgYwNmgllDdXaN70uxiHADkIVidv/fDqvkad4xmLADwP8KBLKAaxqVN8kwgbH7m4Jz244HNO6RjEJfZFXXIGX2yd+BYa82TBFW4YpOjLYnIxxCbtxXRLWrzGKgiS2S1if6bZpwRngIAolJ3RZSr82VMChvaaTuxzDjR2QxL1AwnUoxRmVynneZ7OfwzVgwx/TxEoHnQznHkbF7t8nXHVDBBgdqBBbDMbUrwY1xWDXoOXMSRmaJa/UQ+FzF0Sg4zyp3ReIjmZz97m3CryIltQWtRY2OR1wcmPc9aLkWGhfu4CY03mmg05lyNAk+vWLCy4LA73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O5yLnvcQDNtyaoUy+tcVUE+F4aCrNzBO38oEi+g+Zw=;
 b=bOFXxoWbRsbv5SxW56lQGcUZ+jvi+Q5Ti7fGfklLUcHk7+FtFM5/ALfDlR9mcj+d4AsFmJ7szbN+vuAxF9cLpoZ4c4QKuWND3Ema+cUExJXVHpGk6Tcj10gCBClLJhuZbCLaQdMRh7JkgxcnJ7XXpcBbOHdOKTGTWlIPJsWwZsME8VRxutbFyrEfwknTEumHHYfJtrE59CK0/tSTOKOxCksSt4EOYn4cGEE2jn9ueFbVqKW6ZiIehM8/ax4Tl+QTQAWzuBU4MMgNfAw1DYetturN4PfNYw7mh825P4wJGuu10RZx4XWGEae1xcZaLa9zTU+QN2CZ/ii/KCeZ3qiMjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 19:44:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 19:44:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Aug 2025 15:44:08 -0400
Subject: [PATCH 3/4] ARM: dts: vfxxx: rename nand to nand-controller to fix
 DTB_CHECK warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-vfxxx_warning-v1-3-080930d8e1ea@nxp.com>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
In-Reply-To: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755632668; l=821;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0LqINnyQsqNKvIQOWLLNyzE4LQalSxQU2pFiI3j3KB4=;
 b=y+qkAVVZaRKEVPC320LTP/I0VJPdM/J8RpMOZNYaXEb78UNFkuQRzz7z+JMniL0KAPb94QQWI
 GGK0+6vUuNQBVKABt8HDkEHAcFKjeZpNfThUbGsqczsN9AtVKhtnleC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d72395f-ff6c-42f6-4ae9-08dddf58d48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0thNU9QSHNmMnBGNG9sNlR3YkF6ekVEMytqRjRZak9WUW5GL0pLK2NiQnBi?=
 =?utf-8?B?VUp4eTl3cXAxVlFQWURzUGhGY0xKSEQ5dFFWbFJVZHhScURQSk1Zbk1ZdWdI?=
 =?utf-8?B?dWQ1YXRPa2hYMVdDOVVMVnplVjNxM0t4SDcxS3krYTUxZmlsZGVxb1dVZmRp?=
 =?utf-8?B?Z3Z0d2NyS3ZUbTJZUWVnRWdoNnFOK0dPOHNUalUrVU9qdUNIQ1BZakYzOFVs?=
 =?utf-8?B?Vk9odUlQWUJqbjdVV3pFM2JCbXpOUjhsMmgvMHB4UnRveTBMWHUzTmVka09r?=
 =?utf-8?B?V2UyL0tHL0tMYkdrZThQNGMwYW9mV3l0VndVVFJ6ZjRvazlTWVBaa2h3Qjlz?=
 =?utf-8?B?SXREaWVLOU5OS1l6a1JhZkFTb2hZeG1xV01mSVZhRzYwVEs3VlgraGtqQ21v?=
 =?utf-8?B?LzZ4QXlhcXEyMEE1dDJBcnIxbDlGdDRjQkpSQ1FoMU4zd1E3NVFuKzQvZjJS?=
 =?utf-8?B?aGo0U3A0cHdId0xOWjZuVytOdlNETlk1RENoc3JsMDN3aDNkU1piTm9KaklK?=
 =?utf-8?B?L2JwbFNBbGhnYitabkFZVFFiL3NMU2dIcGJYYnVUZ1pKUWIzaGdVbGFwU25Q?=
 =?utf-8?B?WHRiUWlFU1IzTjdBTjdTU29pbGpGTUNqYzBCVlhoaGtuL0VzY2hHUHhVZjI2?=
 =?utf-8?B?TzdHL2draXJrMnlFMlRFZCtXcHlpLzIyNitrUXkweTJNZ2JqVXp2aW9TVDVj?=
 =?utf-8?B?MmFrUTZFQi9FLzZVVWVBMHg4ZmsxR1Y1ZE5yRndoZTFCR3ZFRkc5MVJFeWd6?=
 =?utf-8?B?TTVVMEo3ekg5TnFCVmV3c29NblEybWEzRXRQYWZtN3VJdHdCckNSQTh6aXEy?=
 =?utf-8?B?TnJCcUh2azBkamVWanZocmhFYVIvR0hieCsrYU0xNHJ1TmRCQVY3UHNEdWJL?=
 =?utf-8?B?MnJSQy91WWJaaExXeWR3TDlQVEtBdmdYRVI4d1U2V2ZIQ08yOTJJVWNXVWtS?=
 =?utf-8?B?SGdYM1RtMzN4Yk1aT09lNUJoaHlQQWdqcnEyaHhyNmcxajkwbjBhZjNXZWpR?=
 =?utf-8?B?QkVFOHMvU3RETnRsWXl3N2QxR3ByMFZZWTFvOUhBVkNUYmZrVkpycXVCakQ1?=
 =?utf-8?B?VGtoeVhMM3VVY3hSbDBIa1pIbEZXaDAyNUQ1VVFDMk9sMEJBQ3FvUnFkVGIw?=
 =?utf-8?B?dWk3WnpURmdtaTN6eUN2K0hhU1U5NHhCcTVoWXNvMFQ4eVo5c1ZUSDJQMitG?=
 =?utf-8?B?bnc2NUo1RjljNUV0UGdJODZlVHo3aEpJODlpb2EvZVl6M0xBdlZFVk5FdW5L?=
 =?utf-8?B?SGNYRWRHZnE1cnN2cVZaQTVVNHAxbFlBc3JyUUNXSFRXL2lTTDNLUzlFbDEx?=
 =?utf-8?B?S3lVUXJERzhhVE9NcTBSOFJ4MnFiSC84QzZ6RzIxd0NEU015Q2Z2cjVDZEJK?=
 =?utf-8?B?WWZ3ckFBRmNzZThLQ2JySEtGOEZvb2JFWVV0Q2VkZTA2bHFuMUxQb3I2VDZ6?=
 =?utf-8?B?VDN3R0QvNThxN3JXUiszdDdkOXFyQ1dKYlBlQTB4aWVHakhzUkxVcHAwaHFW?=
 =?utf-8?B?WXRZSGwraTZXRUxvVk82a1NiN0tpSnJ5dHMvUTd3YVh5OG11NGVEU0VUTWZa?=
 =?utf-8?B?OHZPdXZFSSt0VnlxMHpQd3FpdjMyRyszN0Z0ZDJMdGx1QjN3UGdrQUlkcEw0?=
 =?utf-8?B?SndHZGltV2g2NURCcmpWNUc3dTVOVGJmWTNESlVST3BEWHVDVlpzNGZYN0I3?=
 =?utf-8?B?eGlpcXJBSVk0UkN4d1UxWkEyejc2aFlrdWFFTkNObm55eGNCcXJCdzRiTzdT?=
 =?utf-8?B?VmZnUnhHUGtGbXZQcE5kRkNTTXZQSjh4VGJHcmZOTE4ycUlJRmt2TzZpdjJ0?=
 =?utf-8?B?UFZBbjNQeFdyejF2QjFEUUZSM2haNTN4UzB3VXRuYWJBb3hSWDdTWGtCMWRP?=
 =?utf-8?B?b3lqaGJFUjVVbk50UlVYL29YNFJOZVM1elFHVWlqMHlGeUovNnBsMGlPNHhN?=
 =?utf-8?B?RlMydUpNYnNPUUNPRkw5cEVNVFZDaGp6ZSs4ZzN1SjYwZW4xQ01FdFk5R2hU?=
 =?utf-8?B?RDhJemlCZ2NnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlJ5NWJqUURYejdCT1ZVOVZlaENFMVE4eTd4eVI4Zm16MlZOd3VmQjY2dWNG?=
 =?utf-8?B?b01HR0h6RlJnTE9ydnYyMjhpZUlTMi8ySDBKcU1uNnZNeXBFcG11b21WMDZq?=
 =?utf-8?B?VWdkaFNweVl0OGt0ZlQrcFQ0clpycVlaeTlSbG5nbVhjZEhUdjdQelVYQTFI?=
 =?utf-8?B?SUlvSXNBcmlPVWFqNjNFUlkrMVNkSDVQNEhxWSsvWjJCOWtRRG5vdzJsMDU1?=
 =?utf-8?B?NHRHNkNOcVRjWG9lOUxlUjdsMnB5cFNUdDlnMWlpVXh4RWNNRkFIRnFmQWow?=
 =?utf-8?B?RnQ2NVFPaXYycC9qcytFRnUxaWNZSGQyQUVmdTduUGlFdzMrL0RMTlI4bVBp?=
 =?utf-8?B?cXpvUUdQc1VIdjY1UGVZQ1FkeDZqa1NWQm1jYURtSmlSQkI5cUwyOHRuMnlI?=
 =?utf-8?B?bkR1QXhxeGE5RU9kcUl0NGRqeTFmNTBrb21lWEFBdHV2aTZMVC9BQVpML29Z?=
 =?utf-8?B?WnBLdjZObzlra2Y1UHcyWnlZZlZtUU9BemVLS1FRUzM5V29SZGlqcUtzWFAy?=
 =?utf-8?B?Z1UvUFBrbWJ4QUlhOFRoSXpTWGcxbHpSZjY5bmdEbEZVZE1OdDdmQXVwRllN?=
 =?utf-8?B?RGUvUk9YdWJHcXpzV1B6Nk1EMElJVWlxTXZKOURPQVV4bUFIdVJXbkdhdWc5?=
 =?utf-8?B?cWs5RGpQbU5uZ29OMGlxczA3TGxVTmtHMStDUDY4NWNKWU5QZCtWKzFEVDlq?=
 =?utf-8?B?Z0h2bC90SnRxWmdMRS9SRVNWQVE0TXJCRDZPRldVbUp6TC9saTlqNzVLdlJJ?=
 =?utf-8?B?TnVqeldYVExzNTlhc1I1blZLWWVURnl1Y2g4eTJoNEpEMWt3a3pKTzRIS3Vk?=
 =?utf-8?B?eWdXSFBmMno0WWJnQ3E0NFM0ZFdLdnc0VTlGVEl5YzNvcVIxb1RoOHVMdnMx?=
 =?utf-8?B?L1owOUVtdFZ0WTZ5ZUR2TldFRWwyZW5sWlA0empXZU83em9laXJQc2hnOUF1?=
 =?utf-8?B?ci9Dc0F4M2FRZGxVNVYxZ010SVdIQklXNmVjZW5hUkhZbEswSzU1VEp3N2FY?=
 =?utf-8?B?UVpQZnFpQWcxeS9SaHpJUFR5QXhPeWx2di83RzBqUjlFaGRxYUZjUEdqU3Ny?=
 =?utf-8?B?aDZLVndzK1FpUzJqOU5MUFhtbFpZbHZ1WFoxRE1vN25nejZlOVo4bjdPNVox?=
 =?utf-8?B?NXZod3BzSW5UMm9yem4yRGNGMGFTUkt6bFNMV3hTQWwySEFpdkhPbVZ2aGor?=
 =?utf-8?B?OGpObWF5VUdxTDZSbVFuV0syd2NYSmFSNUpQN1Jja0tPSlhmMXg4b1BZRFB2?=
 =?utf-8?B?ckFvcFV3NUdBaGljcWtLWnVhN05lTU0rL2ZyMFByN1RmclR2TDhlTGtCbUdy?=
 =?utf-8?B?U0JHV3FKNnNCSmJiQXlWdDJGcmpvNHpURDh6RC9jYWR0YjlWMFhDWHVmVzJu?=
 =?utf-8?B?dzdiUWw1eTRXVDJYeDhmcEkybW13RHJCMWV6ZFZsOHZ3ZXE3eFBaM29mNkVL?=
 =?utf-8?B?cHJuU2d3R1FhQ0JUekFPWmZvM2trUFJyNkk0RW56bzJWamRZSmFkTjV2dFl5?=
 =?utf-8?B?YjNaYkxLTmZ2b0dFYUVwNWNMVVpxOHJCTXZOOTg3ekNZRnpsYUxJS0M0MmlR?=
 =?utf-8?B?ZVpQQUhENW9ZMmNHSXlPOEZ4V1pUTmR5WHhneE4rMGV0OXJxdjM0N1ozZU80?=
 =?utf-8?B?UGVHQ2Y1ZGJHSjQ2UGkzVWwrVllPSncxbFZqQ1JPOUh2bWxQaE83UnI4UjJQ?=
 =?utf-8?B?cnJYWGs5djIyY2Q1azNJSzEvRUdEWXViaHdSTWVHZitPSGlhY1NFdEdmYWxx?=
 =?utf-8?B?bUlMSytIYXJYeTc2K1ZMVzNNQTk0Rjd0MkRQRWJkWnR2T0ZWMUtOajdNM01N?=
 =?utf-8?B?a0F5UWRZZFNaTzR1V3VyUTFGblJZenhQclBOTTZucTFYQUttV05ZSVk4OHZj?=
 =?utf-8?B?NHVPU0VOVnVNTVMrNHBrKzlrcW54dXV3ai8rbEFWKzNIdDMyczhULzZiSUR2?=
 =?utf-8?B?SG9rSVJZWGIwSDhBZDlBb0NKN1Z4bzVjV245RlY3V0ljRmEyU2l2dS9oL0Js?=
 =?utf-8?B?cU1EYXQ3a1RmZmpUaTRoeERML2Y5MmZuUWR0d210VFQrRDJuRVJkblh0Y0Nz?=
 =?utf-8?B?NFkrSW9tZ0NLOGhpbFBoR3lEbTEyVXlQY3FWYzgxUXBoNkhhMS9qZnN0WHJI?=
 =?utf-8?Q?MUgWzRUBLyLd9q4HFwmbkmHfC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d72395f-ff6c-42f6-4ae9-08dddf58d48a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:44:37.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egb2nYwsKNXUlVio7a3giNF8kJnBAob9TuG9BdPfnnWKXsPpJDGgd+EpQ/Z8FI4Zq240O8Kk7wSxUpJr9cUSMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

Rename nand@400e0000 to nand-controller@400e0000 to fix below warning:
nand@400e0000: $nodename:0: 'nand@400e0000' does not match '^nand-controller(@.*)?'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/vf/vfxxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
index 19de9506e0c895ee0ba959b4f69424d811f0f064..568d81807c81559335cbcaa32ab229dfd6e1c795 100644
--- a/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
+++ b/arch/arm/boot/dts/nxp/vf/vfxxx.dtsi
@@ -682,7 +682,7 @@ can1: can@400d4000 {
 				status = "disabled";
 			};
 
-			nfc: nand@400e0000 {
+			nfc: nand-controller@400e0000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,vf610-nfc";

-- 
2.34.1


