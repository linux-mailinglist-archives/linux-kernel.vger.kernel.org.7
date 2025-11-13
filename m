Return-Path: <linux-kernel+bounces-899127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02FC56DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A963351BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED40332EB6;
	Thu, 13 Nov 2025 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bBzqYt+D"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8B3161A6;
	Thu, 13 Nov 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029658; cv=fail; b=NZyYjSk27czLKB9J9PLJpvHLTlrTY2kngtYhFARfw5OfYpc5XOAczrOHvXUDRIHq3+heVfQsuBdA35p0cGcPiXtxHuwQi8QHuc+DG5toRDi6jshElOJ0+8u7tBl+rcoWmvyzWVqLbU2EryWUglQqOt9pXcGu+LsTsotLRUiAGIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029658; c=relaxed/simple;
	bh=g7Xf99QuObg2i339ViZKX/wi/qWA35KSo9qAW+a+76w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WQzNtA/PnmbArY6mP9/XCXIkfHn3Cr2b1J5bM2TbA6B6iZQPhngC24br56m3nCce78cZTNTCmzLPfh1mhsY1qYDPN0MjdRmNm5o3Jmg3HznIXV3J8rQZWUDuMGKIvZm9wA5OTpdj8YD4vtYzfdgqKVVop7YGRRyJB+pZaBugaN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bBzqYt+D; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYcbylW/rY4SJaD5lAYxYkKpWeH5zKobPbKjHqf+sNRY9ld3nM7Y6toMVyLtrjHuopR+CoDB3dotlwOWA/DkX1HoPw8EKR0pqZY+3Y76o0AAyoUy8Fr/jcIpj8TvUfRWlrnTKNgLowyZD8ryILyEiS3qx6u+hYRDALYNzheuf5xJPvm9l9BLvvbZApH+Szyu/WFrf/jkA/sYmme5poLoeILWMekyPGNqc2NJpUWafcTk9n/Mn9fgbw4xzW5TjOWY6bhtWZt4jCijfgzDmtL28mDViN9VVGuqymUrtmP+pkMySUWll+Rh7prsijFALcGetGkElc3qZ/7QThaqn80KPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfraXuYifrGoXXPT7+uCzBCtQw9aSx+M8gonv/e87VA=;
 b=WkHEz4TwOtQ44JYfCkK0P8PZiChmkmfYOhJRdi3xEhSDhxzfSDpacFyXpc0cnKlFS87q5zNNScJtU9uJEz67rzY9GHo0CbD+Ngp93A966f++WBUKsuJG3V482qfNt9TQ89Rr+Gh9xeIT09eMgfxHf+rcl0DIohZGpKpcz3rvDqZDvTzfg+XZ4E7Q7mjN1+wTsjrqH5WCx/dZ2r0Foqmu4bnEXUWWvba8mvJBbXQv/cIwYy3I2vghK6haIEU6MeMZj93TVemTadaoliKoe/rSNQRWtYgFggtdS/QALXYuTX35elagbeJhvdBLQ8cgGk/1IhT58J8kSaDF2VbnEWM+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfraXuYifrGoXXPT7+uCzBCtQw9aSx+M8gonv/e87VA=;
 b=bBzqYt+Dx2oRgSuodEqV8T/avn2Mgiyvb8ewCzdlXxqVPKePfrL+OAkKyPTLQ5b8F2JuMsvCoGvmx9SHEzA0Gt+ukaD2+3rDlw3Tw/DK1XZdobhaFreWysNKNx9v6k001d/Kf766IKp+abi3ZKc7wJEnqtKJB/LZCRbpqY5eR7dTDHv+tWSShWCqniaR65gpUqQ9eywCCerxh7e3f+5MFTLsxl5X9cyqnPzgSetBuoPhrla5Y7OLzMpg0LloXPbZ5UTcOQNKkkkPFB6M4Ud95NFfMjk6369s0B/uBH0tvavDLSHsNEdkYOd6+R+yzp1Msn0i/ikoc2kRf85dDz8JhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:32 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:32 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Thu, 13 Nov 2025 18:27:33 +0800
Subject: [PATCH v8 3/5] media: imx8mq-mipi-csi2: Explicitly release reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-csi2_imx8ulp-v8-3-2ebe378f7111@nxp.com>
References: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
In-Reply-To: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=1388;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=u8J2ZTLtJhUELsSg+uX9KuaMXfekiY4CVltJTBrx36M=;
 b=FpZ9k75mxQ6LDdojgy92zYw+FhgiRA4NRWU9n9MXPkj76frjNJmOE9ACFiKGlXGEkSODg9Vt2
 mD/cHrlXvOCAxQPiPxxuvUP5yE/H4MbFNHBskkU+oUpVZLJqruM8y3f
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e090360-d951-41c7-1799-08de229f416d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YlhxL0pjWDd0UXcxajdOWlplV1hXODFnemVySm9DRmdRSnJJUG5CU1F3K0Jh?=
 =?utf-8?B?SFdVVDI5NDI3VVhZbUNKQ3l2ZFk3akNFR0VuTFRlM1ZzbWVIcU1sMWR0NTFR?=
 =?utf-8?B?TEVPc3FNS2dsSEdhbWxCamgxV3B2a1FPakJ5VU1GYW5INEw0bHhvc3VMWUUw?=
 =?utf-8?B?QVJaakJhUnVEZjZMR0NUZFRTZkZhc09aaHp6V1BocDVLeVlJTUptWUNXOE5I?=
 =?utf-8?B?c1l5bWVManZ1bDBNTmEzaGJScmtXOWlhMW5tYmxTb0dBemdSWFk3ckZXRzhl?=
 =?utf-8?B?dzFybFBDVDFUTndRdng5clRZZUcweVhnVWZYNlAzSGRUZGozNWRsQjNkY0dn?=
 =?utf-8?B?UGV0MWttdG1JQk9TWWdUS3p4YXp5eG9QNURQSDJhS0laTURjUWFlMGRhcHpV?=
 =?utf-8?B?emFPYmRhSjZmaU9iUkhCWG1pNzhjaExkaUNmZnRnbzBIajBNVFdMdERXQ09i?=
 =?utf-8?B?Z3d3TkdXQ080ZktrN1NmRENpZmlEQW51RGs3bWZmTFd3REtqb0QxZmFaNmFn?=
 =?utf-8?B?U05LanVMUFAzTk43RzBabm9uQkFzTEVyUUwwVEFyMHZyQVJmSHl6aG5GdGpo?=
 =?utf-8?B?MzVwZjRHYmZHYTFqZEFHelgxYjlNalR0Z1duR0toNzRwKzluUGdERXAzbHYv?=
 =?utf-8?B?Mmdvb1NKZXJiMHF6WlF1a2JHVzkyQ2tkcFlRYW9STEowL3FVTlFKMlR2NEZo?=
 =?utf-8?B?MzE1cCt6elBJeXZidVpuVVI1VFBuWFlRRWNySi9OQVl4VGJ5NmJuU0xtVmtH?=
 =?utf-8?B?aVJFTWsrM3B6NXZEUXI1K3R2dmpGTnlNYWtDbEUybzZQQkZHbU5RZmxIS0F2?=
 =?utf-8?B?OUtHbHBqbHdGbzRNbzJBOFhkYVdQL0k1cnZ2L2p6WS9RQVdtRGtQY2g3dlZx?=
 =?utf-8?B?Q1BzTnpqOHIzbS92aDZFZ0t2Tmt5T0pCZEpvaHVCSFVydXVlNm9JQ0diUmt2?=
 =?utf-8?B?b2YrdUpYZDRBVFQ1cUtwcENKbU9ML05vRjJGdCtRRWpJdzIzM1JiWTFOYnlj?=
 =?utf-8?B?b0JEMDMrM0NQcElqQ1gwVS96R05iUUNLbi9kWWYyZlg3T2dCcmFFdFMrZjZM?=
 =?utf-8?B?MkFWSlpwQ01iOVhtTXlxUFk5NTl4SUt5dDllcXNmT3Z3enZTV2Qwam4vc20y?=
 =?utf-8?B?WnhFT2xQWGRjSXE1a1RlQ1FuTG5OdkJhbHVFRVFldTk0SU9BTlBnbnA5ZmFY?=
 =?utf-8?B?RDQzeGVvc0had1NwSWgxTmdwZkZjOElIbVA3VFlTY1lKTlU2Yng2TDVhY2RX?=
 =?utf-8?B?Z1c1ZGoxeHZWeXhicklPdDBzN0d1TjBNRFdtVWFib3ZKNm5yZjhJSVJtaExx?=
 =?utf-8?B?dmhIT0NxWEd0OS83TkFmSWlibE1Lak5QMW1wK1c3Y3lWZE1wbEYzWHNIUmRM?=
 =?utf-8?B?WDNuV3MwTkh6TXlqZkFTRW1vVHJ0aFhUd2p0UUtJb0F5SitPZ0RGcXJMa0JN?=
 =?utf-8?B?b2FTZFpHUlA4QmN3dW5ZbHcrM3JFUzlCN0pXYzlkREcvL0VDUnNickVhRVdH?=
 =?utf-8?B?SXE3UmZTZEZmSmNOYkpWY1d3NmYvT2t3UHRzOEZJUk1kcVdzQkRvQ2VWOGsw?=
 =?utf-8?B?VWE0Yk1SeUcxZThRTjg5ZlJxK1U2cERFOTZlL0pmU09PWmZ6LzF0MnFyZGx0?=
 =?utf-8?B?Vit5MnI2dC8vM2N5SWRlRnlaM28ycWRZYzVVbVcvWDZGN08zYnV3UXJqZHRM?=
 =?utf-8?B?dXdFNGdaaXRqYk5QNVlYeGVjdFI0SzR0emI3b2t6YlJaVzdxdGdCWlRIUGFj?=
 =?utf-8?B?a0pOVmtNYjNOenAyYmFZeDYwaWV0czlkRm91amFWb1ljU3VSL3pqNW9yQ3Ji?=
 =?utf-8?B?YzZBeTRNcnpuZXZ0eU1JVmJaM0VPWVZxMlpMZWEvdHhsUVMrUW5zS3RPb2tz?=
 =?utf-8?B?cHlSOUFXcjRpMHUxL2RpUFI4eGpGcnIxWTlVelYxR0hJdURZN3hJMEw2Y1dK?=
 =?utf-8?B?djBJQXJYSi9DTEtZOUt1cmRyMnY4SVBsc0E1VWNNOG5vOStXSUcxOXAycys4?=
 =?utf-8?B?VGxpUEdsWWtLbHQrVUxXSjNzdHFSZkVYWDVIY0pOOFFrZ3JlRjc5UWlETVhq?=
 =?utf-8?B?K2JwYXNlOXRNNVJuWmVwdG1IWkZObytoVDdWQT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SndJRjlsUWliSlZ3em1Qd2FlUmpZSHR6ZWhSclRqVW82VGlPbXUwODc2aTkz?=
 =?utf-8?B?ei9hWGg2d3hpWG5MNXNzZ2hPTkV3QTlyTFhFWTVyQkFWVSt6K3FOUWpOaC9N?=
 =?utf-8?B?eTRyT0lqNSt4ZnhFREZTYk9wUHpYSEVkNnhkVklBSDhLN0dhQ0puVXZZeHBy?=
 =?utf-8?B?NGxrNm9tREIwMXpVRXNMVUR0NzhvUzJvYy8xVXU5OStDVHpuZ1NzbkNRb3c5?=
 =?utf-8?B?K2V2cDFycURuQXVXNUJ2VWlvRVQxYkhxUzBRR0VrTVVzMFhrTWRlM21HNXlt?=
 =?utf-8?B?enRtdU5sL1ltUUVDVUZLZzJnSkt3VjBrcW1Rb3hETFhvNXJjV2VnUDBFMGhG?=
 =?utf-8?B?MlVKc0NXSjRVSmlucTliM3N1SGwzMWRRY0hpcjlweXVZejNxektsKzYxUlBB?=
 =?utf-8?B?endyVWRXSWRZZzZIWlE4eDJtZXJFNGdsS3lQT1VCMFVTSG1BUGhvQXJVb3J3?=
 =?utf-8?B?ZVZIby9aeG1CYmxJelNmV01rRkJEelJ3ekp4WDlZU2pyKzBac1dhaXpOZXQy?=
 =?utf-8?B?c2J0YmhDV0FUWXU5ZnJ6c21OVk11MGQya1RhZUlsN2s4c3VYQjNMMmZZVmtI?=
 =?utf-8?B?VHhha1kvSzQxeU93RmgzWVZidC8rY013RnlPTFU4ejJZMWFPU1Z3Z0gvZVVW?=
 =?utf-8?B?b3JzTHA4UFZZNVJOcS9yZnV3ZVNXQ1ZmQThFazY5RW9BWHhvS1dRcXlvUVFP?=
 =?utf-8?B?WXRnZjduOUtZLzJ3NTFndVBKTll2WWw2dVFzQ1dRVjJnRXRlMjBjVWg3STlN?=
 =?utf-8?B?SjhwdEU3VEZMa3Zrdlg3UkxKcG5OSytkeWYwUDlvWEpmaTl4RlJneVBCMHdO?=
 =?utf-8?B?OXNlcENybC9ubDNhM2JMajZsRkFtTVByaWNveHdoQkpoTlJPWDN0T1NFVUo1?=
 =?utf-8?B?YXY2cG51SEJveVlhWTBsdHBUTmVOaUlZNENtaHZac1FnOGJ3anVxc3pLa3h3?=
 =?utf-8?B?YXVFZkNlT3ZiVlAwNDFEaG9VS3BJUWFNT1k0MDhxdkVoQTNCSy9NeGZqVENV?=
 =?utf-8?B?MjlxTWIzQ3ZWdnZjZDBtK2I5cWxCa2MvQ0hKbkVoWUIwY3NVemI2alQ4RTZp?=
 =?utf-8?B?RFlrMTkzLzRDcUFKQnVtR0oyamluZDA0R0lpUTErRzJodENwcnh1c1NxK1BR?=
 =?utf-8?B?dGJlODBtdktIbHRXUWhRRWFIVTBYOHVBc1QwWHRWUEtYKzFsazJTVnhFN2NR?=
 =?utf-8?B?bTVkV2M1d3NkV1g0WTNVVHphUEhZNXo0ODkwMmlhWStIL0hrY1hzZFBGM0hj?=
 =?utf-8?B?TEtqWE4xK3loMGNlcW5hNE9welUrb2R4blpXbktKb3pHQ1FDbitqb1pjZjhz?=
 =?utf-8?B?K2MxOGZWQm51TjhyRWZSS25aRDYvaEd5aEtFS0Jld2M0bUlubnd1d3dLTEpG?=
 =?utf-8?B?MDhqV3NuNjhUR0ZUQ2lzSkRKQnZpSWNGUFlnOUh1RUY0ZUw5S0Fhd3lJYnBE?=
 =?utf-8?B?WHZObkJBNWxCd3NaQTAvYkJoL3RYNzlUb1I3cGpNRUpmQ09JN3kzN3UwUFFR?=
 =?utf-8?B?SEtiRGhPQ01leEJpalZRUEJucTB5ZFBDOXE5QlRoRlRkMzVsZ3lzKzVGck10?=
 =?utf-8?B?UncxdW5KMUFuK2JTdlZVcTdGNUZoRXVIVkxTWVBYUFV4dUVWMGdJQ3FWbHhF?=
 =?utf-8?B?VWh2VlJoRHhnT3ppK1JHbmtQNSttWFlpYmR4WG05SU40QVZTM2pnbmZ6K3ds?=
 =?utf-8?B?YXYxSDBoRk8zUjNEMkRzNHBCdmt2SWk4UjAveEd5SmdRYlZaTHY4M0lTc2J2?=
 =?utf-8?B?N2VEcEk3VlRLaDRyOFJVUVVnOXF4ODNsdWl5ekR0dHY3ZU4xMWhmOThocUF6?=
 =?utf-8?B?S054WHJ2NHZ0UzU5YndsVGFveE13ekRaaWVsSmtoM21xZFRmTUF2bjVxSGdo?=
 =?utf-8?B?ejJlbXJuUDVPc1JweE5QTGs0NnRxckcyZlZmM3VveVdBdWI2QVkvd0JRalZp?=
 =?utf-8?B?USt0bnNhbi9OeE1xWDFWQ3l2em5LQjZpbEs2ek4zZFl1ODI3Wld4ZUVzTHZv?=
 =?utf-8?B?MkNpU2ZycG1hVGZpTzRFQmdQb0NXZjVyZGRzWGlhUHB4RlNSaVFZamN5b3Ay?=
 =?utf-8?B?ZDhHUFNHQ3U1OUQwWjFSZHNjTmlleEZOdTEzVWpjamlwYW1qdzZvcmw4ZnIx?=
 =?utf-8?Q?Y36oBWmCy5Q+HCJ2xaj1I71A8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e090360-d951-41c7-1799-08de229f416d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:32.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugLhST62jFdSLLEM7Rc6GjOh8QtApeVX5EZ2Xn0oQSk8zXAscfgPMzPpBzqafHqE1EW4OJiO4p/BCHtETAzlHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

From: Guoniu Zhou <guoniu.zhou@nxp.com>

Call reset_control_deassert() to explicitly release reset to make sure
reset bits are cleared since platform like i.MX8ULP can't clear reset
bits automatically.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
index 40db2676bade94e8e750381b1237fd02aee9d0ed..05fa17e48fce428e7be95ebffa645c2e6dd0e36a 100644
--- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
+++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
@@ -338,18 +338,14 @@ static int imx8mq_mipi_csi_sw_reset(struct csi_state *state)
 {
 	int ret;
 
-	/*
-	 * these are most likely self-clearing reset bits. to make it
-	 * more clear, the reset-imx7 driver should implement the
-	 * .reset() operation.
-	 */
 	ret = reset_control_assert(state->rst);
 	if (ret < 0) {
 		dev_err(state->dev, "Failed to assert resets: %d\n", ret);
 		return ret;
 	}
 
-	return 0;
+	/* Explicitly release reset to make sure reset bits are cleared. */
+	return reset_control_deassert(state->rst);
 }
 
 static void imx8mq_mipi_csi_set_params(struct csi_state *state)

-- 
2.34.1


