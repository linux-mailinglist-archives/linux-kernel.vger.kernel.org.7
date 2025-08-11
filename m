Return-Path: <linux-kernel+bounces-762958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBBB20CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA42D1893D60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059D2DCF44;
	Mon, 11 Aug 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BnDKhHGL"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B591DE3CB;
	Mon, 11 Aug 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924347; cv=fail; b=OYf06dHWtwZnLHMKaru/lACDriRx6nlXPDUCfB1TnU3j/1ADe3a40sF1K7t+rOY2BJku4+2AxaBWonOQrbbW9lMAJeLw9KuPXBZnPgX2XHpWASTmU2EO99sQvCn2eSM11pUCdSklZTvlMkQFuGVjnu7ieR/BrldTGV/bp3NVkho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924347; c=relaxed/simple;
	bh=GitMW4Ij+rLdujgMw/wJ9KaaI4pmAgcxKMddL86CSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HxCS1IHU/cDufOo7GWGS7t9U3wE6lVW3EiJr4dCTMj5YEAVU+aFxPkcoIDnFloOH6q314ACRv8TQ0GBMy7DJOO1LXcG+cGpbzdDTxRIAx8dkQ2gnzbWj7uSoXgxHv6CNlKlk16vJrOusU9K/62pcWiPb2FVtqbXWi4cewIBs4Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BnDKhHGL; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3BeObM6fHnon6UiP6KY761oMnrV/AqEtVAEbt+vrjxGryRRbA73oZ6BE/ZinzVAB9XhHLe61cUIuB6GTIpnxyM3+y7u1sBCFB2zQPPBQzaC6VaBhN8P4+HMRAFUdTIlVEvba7vSdrqdTRVgUCYHoYCWz260+1m7XkEYETNvD+gLd0fLcNU9Wr+pp+QtmWtaK2zAsHHj5TznKwnw0kOX4AtIDjs3HSdeIc8kzT5n3ZMRb33NSGYW2W0SBcWZvMmPxkbQL1xYGp7wZUS7zt3sWCaUMAM6wXvd9FvsSy/x5IZHvDEoPrtyW4QhXq2c0PzcoPVPrkmyiaD/GtkiZAaivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXFq7BOjPYvn37oF0Y3ZHMfZtiFtjo34RsQuqs8ayl8=;
 b=wtgAb25xydFp4ITOGRv7G8HuwlixpV+ulIGL7X2nfRN1qabKGEUakcWrbbVUPeMj/lTbcQVddr6mn4mraOQP/eCCSHCPW0Pl1T1JGvWSpiKQPETzUD4f5vkDSX+glRYGSZcoUtNYLk9aF5bl4yY8z4av3Wnz8VYSaAIXylksa3ahBhkXr4VOlP4B0uMTWCa8lxgrt0Qhn58Hg3G4/H6xnKajQpQ7EZOmsruZKuln0+nKbzzJMGv3ZYxk7RRvA3Puwz4THWBKxkHTfiu1r2mewk4Fl/4p3/CtVAKdp60+uy9R5Kc42uPyqWvlu7izlgY+5dFDuzu5JiNLwDWc4TSFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXFq7BOjPYvn37oF0Y3ZHMfZtiFtjo34RsQuqs8ayl8=;
 b=BnDKhHGLFuq3DUR2l0RcPqEBAjHIh0B4KZO9asJHksi35bV81tMFMJu9T6Mr8IxFAdTF1WDa2XatLFV5woE/8S9Wp0Be7j6XPnuqk3XmAcsoC2QOcjjd6B76Xj8QigAdw7JE+d0FeTOpio/efm26OB/IMtvR/BsCq8Zxrs6z8QH9p7r+wgCPnw9T4Al+EHEbvTxEhrG2FYnGWOqJRbeUc0uhuTYIsP5Psw2rcUydYeU269Am8uhYxnBR9/Mu5wdJWMl8EE1SFo05eO46FZWRR+MeUH05elvAF0NN26U0FHmnyVf3uN2/MK/rTNRvvscqO6kbKaWzE2mhagrUQyTCWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 14:59:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 14:59:02 +0000
Date: Mon, 11 Aug 2025 10:58:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8dxl-ss-conn: Disable USB3 nodes
Message-ID: <aJoFK1RQ3FSDKKjO@lizhi-Precision-Tower-5810>
References: <20250811063855.46431-1-ada@thorsis.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811063855.46431-1-ada@thorsis.com>
X-ClientProxiedBy: PH8PR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: eda7fa3c-a76e-4eca-01fe-08ddd8e79beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHo2MExVdUFGUkRVbC9hSDE0cjVtQnU2Y3RWbUNOM2YzZHVScG5nTjFVWmN6?=
 =?utf-8?B?MGlISnZjTU9ySlNpK2JnY1dpNWx6bXN6eHByWGNMTURwYklZKzZGbWx0MFp1?=
 =?utf-8?B?blJpRU0rMlM1TFU1ZnBQaWFUMVpoUlFrTHhZUmxhOU15R3RBZ0Fjc0E2dVZ0?=
 =?utf-8?B?TGtTelZrOU1xRlRST0U5QVJTdk5NczN4blZST2tBTWdyRUc1WnhpbGNzdmRx?=
 =?utf-8?B?d1pWSy9JMTlKZC9RbUlPK0pGKzdNQ1J5T0FxdThpN1NINFJVaDRFeE94U01G?=
 =?utf-8?B?VjBaMzlXcysxN2xuRkNFME5tN2pqL1dyMEdiWTNoclJ1WVNlY21MVWpndnFU?=
 =?utf-8?B?R2l1MVFXREhNNmluQktWeWxYd0lVR2dTaVk5OURPUldlL0ZkVzBiSm5VUGRH?=
 =?utf-8?B?cEU0cW5uMnBWYndBaGgyVW55Wi9SNXYzTk5XTWVMNWRnT1ZtV2JJV2ROY3dL?=
 =?utf-8?B?QndKTUhJbTBqU082azdrTm5oNlkxc3ovSHNLcTVLdkJwVUdaWGFabytoTHlB?=
 =?utf-8?B?UmNBaUg2cG9xOGFiSjdhazFYREFFSkhOWUJSa202NUNCR0hhbm56T3hjRHVw?=
 =?utf-8?B?UjA2ZE1mSkE2c01YaHlIK3FINkYrT1V6VVJQNENWaVVkcllKcFN0L1QyTk9n?=
 =?utf-8?B?MmZhVG42SnlYMkFLcDI3YTFNWHhrRU9vWjNFdXp0MnRpTGNaTENycVdhSjky?=
 =?utf-8?B?czN1azIwQ043dVpPYjRNUkFuRUk3T0xjWjNlWlJjdHU5NHRpRWxmNHo0TlJP?=
 =?utf-8?B?Wlg3NGtuWGdZTXk2Ykk5QlVCZkl3QkluMUxBOVNTZnF3bTI2QVpuK3lndU9a?=
 =?utf-8?B?THhYUStOakVtdjJPRU4xd083UG5DVG1JSWd1RklGUE5ad0ZlMmJjSTFYNFNr?=
 =?utf-8?B?U1pOMDNQT3h1cWlIdGZ1RGt0TXJGazNVNzQ0cFpBVitqYmVlNm5zNEFhNVVH?=
 =?utf-8?B?SXZzZ0c0RHJoV1FQNUNWTFFDT0YzaEg3NzYxdzBsUHg2eE1WWkZodTR4OVo3?=
 =?utf-8?B?NWdWTG52UFlSU3BkSUpUd0k0TTk5WGR1a0toMUVUUDlLeTQ2S3N1S1NBSXll?=
 =?utf-8?B?ZnVQQVV5YlBkbExrMzFnUEpOdGdFSS9RM0FzRTJkbDV0bHpUQzVDMWdsR0ZG?=
 =?utf-8?B?TkFKN1VnV3JTTnltR2U1S1JFanhzS0VpcklBbXdIcnR3RnltMzNMTFBsZnlK?=
 =?utf-8?B?ZkhVbUl6Qlp3RWF1MXk4QnRkMTd3elFEeGNIcThrenBLaUJ6VnpOT01PQjNL?=
 =?utf-8?B?SVlYWlNXZWdpalBCMWUrUXpkYlNwclZQNmRCQUZXUGJOMUw4TENteTV5Z093?=
 =?utf-8?B?Y2I1N3BXYmJOUUxZcXYvN2h3TmNBSlJXRFV4a0N4TkI5aWp5TFJyM0txWXNI?=
 =?utf-8?B?bFRyUWVRRXhaMkpCakFhbUFma2J5TEtJOWZzRGllUUtFY1lITE1BY2k2ejVl?=
 =?utf-8?B?UkVDYk5pMjgxaWRQQWdDaWswY0hhRWM4TTVzOElCZ0dTbXdibTRXUjVsdjll?=
 =?utf-8?B?NjJjN2hMdWk3UktwTnNVak9PQUJuaHM2aUpyaGhuUXJzVm9pYis4NlBxUC9N?=
 =?utf-8?B?ekl2ajVHNHRJSHB4V3d6NndGY3h0OWVUQ0VVcUF4Q2Q3MHdSSjIxUjArQjEx?=
 =?utf-8?B?SHlvZU9la0hHQit3a2E2UXpML0R6Z0Q5eFlob3ZYbTFVOTRmVmxpRWZwbjVP?=
 =?utf-8?B?cjIvV0Nmb0pVaXFoMEF1MmtFM3VZdlFGNGhiaHJ5RkRsWGRmcTNjeW9Hcm1I?=
 =?utf-8?B?VHUxSVV0RTIzeFJPQXd0cHlLL1JsaTZUUVU4M0c4Q1htM0kwTkM1aytJelVT?=
 =?utf-8?B?YTlic1A4RzJEZUtxc05EZnNtays3QVJmc2kwcWppMUZ6MVV2TlE1Nno2S3Vw?=
 =?utf-8?B?VWlwOEE3Y1JZSHhSRk9UTWJoUDhRR2lUZUxxa0NsZVNmWU0rNEF5Y2lRR1c5?=
 =?utf-8?B?ZnZkalE2SlJvZ2ZhaFZSQlN6bm1HMHFjVXRVbzRnN05ydzR3cUJRT1p4RC9W?=
 =?utf-8?Q?Gw5rOMv04LtzC3tbLiJwCSSF9wkkZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdUSVkwdU5RU2t1T2hGa0RrRWtXRnV3NFp6QTFMalB6YmdSVlNBVzB6NXF0?=
 =?utf-8?B?U2l3UFQ0elVTRWZpb1ZKSWd2YzR3VGs0cmo4VkxhMHY0QkNFeW1Db2p2VjdQ?=
 =?utf-8?B?ZGgvNnRRT3ZvWU9PTzlNZUM5MWlXQ01iLy9mR0F3YWNBM1RpNGxSanJXanBS?=
 =?utf-8?B?a1oydGlTdjNaVTNGMFkvam14dTBhazhIK21HaWs5T3hXOGhwTEcrMElkWDlE?=
 =?utf-8?B?RGFYTjgxZXJXYTZEUEpmTUovSWZ5NTd5MjlOdDVockphWEovN2dZZmR6azRY?=
 =?utf-8?B?anJaa0NFRlJzT1pFU3lnWVJPUmJkWjNyeS9ET2pYU0Q3WFZKN3NycU1CWmd2?=
 =?utf-8?B?NWp5bENmUlA0bU1DWThRc3gzSkwyamxsOVY4cEkveXluWmtoZkFsbDNPakty?=
 =?utf-8?B?cUJIV2J6eEc2blBuL0V5VTNBMlBNMDV1ZjBLSEJqdWNWYngyczVGZjdtTkR3?=
 =?utf-8?B?dkQrTG9yWW81aFVwRVY5aUVjVHR1TUVOUWUvQnZXUEUyRFVHcDZIS2hOQW9K?=
 =?utf-8?B?OVJFNVZFRTJidUJhYmN1eWNsQ1RySDBHdndPcjJ3TFhMYndJZ1ljUGpMYjdm?=
 =?utf-8?B?RGFKdGMwSW1YQzd4bFhNbEwrQWV2a09QbVJVeUpiK0VCL1BmSElnMkI4bkFU?=
 =?utf-8?B?K3pycmpsZWNYZmdYSEhHL1YwTWtOOXZiNC95UVFFaWpHTXpETWRMMThkNUFC?=
 =?utf-8?B?L3pJWjh0eklleTdsSElMYzBDa3Jseld5YjZURWFmZ3FiNS93Y3dHVkx6ZUNv?=
 =?utf-8?B?UGNDdkJsOUUyclRiSjZpVXkxbU1iMkE5d2FjU01GVnQ4UjcwYmhsaXBTYk1F?=
 =?utf-8?B?RC9vNG9GT1owN2ovK0sxcmRzSjlGaVRuUnZpUzFGTG16czljbGQzQXgrekkw?=
 =?utf-8?B?b29JcWorOFdyK0hsdmh1eWtTM0ZYMjdmTityeC9NUG9sS0lENEEycjZaZ1I5?=
 =?utf-8?B?UCs1bnY3Q1hISzNuUmp1QThmYy9FQXYvTE9ER3pvWkNRTk80d29ZTVZMTzUr?=
 =?utf-8?B?Qzd0WkhnNmY2TG1TMXFQc1g4TndHR0JTZStQRjlMZ2FsQkFhdjQvMHVyWmNz?=
 =?utf-8?B?UUxKOG5zTmYzOE1tS2tkRHh0UC9Ycml3Y3pTMGwrOU5uL04ycDZYK1VrbUhx?=
 =?utf-8?B?R0Frb255ak43aU9TOGJoZjF1NzBSZWg4djF1ZXo5MlZjTWZpa1krQzkvQ3Bj?=
 =?utf-8?B?N1VuM0dnNXdzOXNDQlI0VTdJRlF0R3Ywd2tqVDVPWFlFaTJ4NjZMQ0hEUERy?=
 =?utf-8?B?eTl3S3lxOHZhNDhhRUFQNlhCWTJnUURvMXJuR3J3d0h4cE5MR1MyZFRpTzk4?=
 =?utf-8?B?Si9rNStVcWVML1VWVXJ0MUs5YW1id1J3Ly9CWGV1WHFyeVRCK3pVZ2dVZjJs?=
 =?utf-8?B?Yzl1Y1BqWWM3bHZudVVUSWhvdCt1ZVA0dERVVFNkdWIrRUE4d1NMdEZKMmVU?=
 =?utf-8?B?QU9kZ0VVSnV3WHRkV2NCTVk1S1UrUitGcERJdkp4LzdKVHlQMmQxdlhBdEF5?=
 =?utf-8?B?VHRFUmpqd2llSllVclNFR0dHeGI0bHd4TW05Mm93a09oemNwbmtUK29Jbjdv?=
 =?utf-8?B?UDJrQkVKc29KVjY3QlFQd2c1eS9ndENlQ0dHU2FtWTMrT2lDRzlaQThlc3Yr?=
 =?utf-8?B?ODM3dDdyYUl6WlFIVmxHeUdBOHJwWWRHVUdFU3hXRGpDYWllSjZQV2hoeDJl?=
 =?utf-8?B?anNzQXlpWlcrRzRoYnpWYkhsODhxY1V1dFJiR1NFejJQS1lRMCs3VmlUT1lK?=
 =?utf-8?B?ZEEyVldJeDNITm40Tk83R0FKUm9jZVF6REVDRVllQS9SNmRxeE5yRjMrbFJh?=
 =?utf-8?B?MmxydWwyald0THlBN3pnK0xaaldjZm9BR0JyekRMc0pmdlM4MEhTQ252QmpF?=
 =?utf-8?B?TW51RzdFaGFqZmNJZmxndGJ6QiswM0ppbHYvdUtReXRnTWVGZWtjWjR6V29X?=
 =?utf-8?B?cnB5cHptWkhqaEdwOG40R0tNRnpCY1RiVWlVcytkbzlwaW9XcWlTZ0t3cDky?=
 =?utf-8?B?NzI0UE9sZ08rZUJNTkdBR2ZLZENBMHRLelo3L0FYUXU1TlZXaGtld3k3RWpD?=
 =?utf-8?B?cmUwZ3NrYWluLzN2S3VJYzcyZmNxWW5XNzM0S1k1a2hNMm9ZeVEvdkNwaTVx?=
 =?utf-8?Q?lJXNG46vGMz3YVaa9RujiJpDZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda7fa3c-a76e-4eca-01fe-08ddd8e79beb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:02.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jiSC1nY2q6D0cMoKWl1X5z+EBgdVJUvtMiHyFWfSi4iuCuFDUwW+Kua/LUs10+UeO9DiNKu9XtMj5pWrQ1zcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

On Mon, Aug 11, 2025 at 08:38:54AM +0200, Alexander Dahl wrote:
> The i.MX 8DualXLite/8SoloXLite has a different connectivity memory map
> than the generic i.MX8 has.  One conflicting resource is usb, where the
> imx8dxl has a second usb2 phy @5b110000, while the generic imx8 dtsi has
> one usb2 phy and one usb3 phy, and the usb3otg @5b110000.  When
> including both imx8dxl-ss-conn.dtsi and imx8-ss-conn.dtsi as done in
> imx8dxl.dtsi this leads to a duplicate unit-address warning.
>
> The usb3otg node was introduced after the initial imx8dxl support with
> commit a8bd7f155126 ("arm64: dts: imx8qxp: add cadence usb3 support")
> and since then leads to warnings like this (when built with W=2):
>
>       DTC     arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
>     …/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi:148.24-182.4: Warning (unique_unit_address): /bus@5b000000/usb@5b110000: duplicate unit-address (also used in node /bus@5b000000/usbphy@5b110000)
>       also defined at …/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi:41.23-50.4
>       also defined at …/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts:645.8-653.3
>
> Delete usb3 related nodes at dxl to fix above warning.
>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>
> Notes:
>     v3:
>     - reworded commit message (thrown out irrelevant parts)
>     - rebased on v6.17-rc1
>
>     v2:
>     - reworded commit message (build on mainline with W=2)
>     - rebased on v6.16-rc3
>     - Link: https://lore.kernel.org/linux-devicetree/20250623075440.36660-1-ada@thorsis.com/
>
>     v1:
>     - Link: https://lore.kernel.org/linux-devicetree/20250610060756.8212-1-ada@thorsis.com/
>
>  arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> index 9b114bed084b..a66ba6d0a8c0 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
> @@ -5,6 +5,8 @@
>
>  /delete-node/ &enet1_lpcg;
>  /delete-node/ &fec2;
> +/delete-node/ &usbotg3;
> +/delete-node/ &usb3_phy;
>
>  / {
>  	conn_enet0_root_clk: clock-conn-enet0-root {
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.39.5
>

