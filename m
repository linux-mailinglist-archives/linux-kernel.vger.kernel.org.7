Return-Path: <linux-kernel+bounces-751950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94462B16FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA1718C549F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514662BE63A;
	Thu, 31 Jul 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EIOraIad"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138232BDC29;
	Thu, 31 Jul 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958825; cv=fail; b=poV1RrHPg1aOW9CuiAICeaPU4r2//HGaIkkw4yxux5XpJKBUw9PkfzkbQuCFYo+jrgoZRX7p1FIS8EfHi7mRSVs7j4oBiomKG8UGfWEkJ55zD1NiewD80fJalUoOIoT2otZmiSrdBuuTS/mA+7J7MuAnyTtUxTRIrKWq021dU4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958825; c=relaxed/simple;
	bh=Nq2k2fFdp4js0ih+Bu7XHR2xV/Ldqp/lu5co/8bm5Po=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SkvRdiaMGDpCY8y9cmGwjpTKAAPPKZ0mHFau7yPUMU+mZymYU6dLkHvSXDjmT9WxZQnyyV8t2+MV8LPoT7PIcNvYNltWJjNrMcv8dytugjivBrbBLfhAxIPE9AEJZ5vK7rDiUuLW7RSqk3c1X8OdfRQhF3RqlJB2tZS7c/z+K7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EIOraIad; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2bXBOulP9MU5FQy5sO/BNeAhlJEoA+FzmUDrHXfl//oH0CquSpuwWgTZ5lD6IV2SWBHuksV9gQwmLOhjyxi33XuSscRPxK2ELDvAeOcBI+KgJ9m/LHUFJ0FoSUMDzigSLlWLYSOkHU+J0Bu9Zytf1d+8dXvEtSJcT/orbkLOfWOhCFmLxEBrJVnO7HF05f9/hmUTSquUuOm7EclaRTXsixk3T6qQPrV+e1U+1HnSvyjjjheQAAs2Vk2Nx5PeKp8OaKnjRw8IAJY3RN9wpcK/LthhnyUniZHv+hp2SeuMaogaNyYa9Y1p5IgOOvPR5hOMCVZkvqmNvZFyMm1GpBYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05dKTBB1CowTsIztSPzC/fjh+FW/uE2SUKo/fDL0Z1E=;
 b=RqbqbCqqJeDveZU9nXmo24UpEnnBIplv0sLQ3cmX4SNTKDW3zdXhpHFG5MC0taLLwMa9I+VicktJW9C2sR0x/fJ7eEon1ka5bjVcWqUUV8Yh9q32W8l9qBMdZHu3DM+S+pjnLAzzUyyHivgccKse8GTOFiQ33DO7+hyE6RGkZYjOyWwcJpCplGrQexqFclI4p2o13tXVX7QTtC1wqS1r13TaJLhkfnPXcDExwBi+W7xKrizcz3uRUOxorLTx/eah3Fp25m0uY+wHWV2WkJJXtLJynzREY5FSSNsRjF1CbMcX44XGQ/uGyHQ/ILPa23zZ3PNXF3Z56vtZnVjJ7Lhx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05dKTBB1CowTsIztSPzC/fjh+FW/uE2SUKo/fDL0Z1E=;
 b=EIOraIadK4jagx2VwRUXTOZhB+FIKHQ6MWUW58Zm3lppDrL4xbj6Iiv6LWI4NQBqsfH8Deehm+gnRVEdblFmD9k8zohlq5snEkf0EWUMSIeMgbm4iwgqtMkPGye5HkZQXNvyWE8MjVT2eoDEMIKo1MvW+IApdSnornLbnn+GPVCNIOptRnjeCkJhL6mn0QmNwBTlQUQvlaNRhYiBKeplVRECeqc4/4Lhgjf0JWfQwhk8+nUhdrW76KNTz+IebJOLTZLml5DYcFa2DkoATOQKlOOX6dzNrZdeLQZFpg0ChOeGKPTly3+edSRpqKDOEikC8qEgaS0qU6gK9Guxb9h1IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 10:47:00 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 10:47:00 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Thu, 31 Jul 2025 18:44:42 +0800
Subject: [PATCH v3 2/2] regulator: pf0900: Add PMIC PF0900 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-b4-pf09-v2-v3-2-4c2659516582@nxp.com>
References: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
In-Reply-To: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b586eb-7e89-4467-fea3-08ddd01f93d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M09KeTZ6dGUycXBsY3o2b2M4WXJOUFdCVzFVcitQd1BXK0JzTnB1R1FJOUlZ?=
 =?utf-8?B?ZHlpeTh2dTJ4elo5S2lmcGtPZ0hqOUZpdE5uYWs4Sk1KNVM5aW9WMVdVbHNO?=
 =?utf-8?B?aThwMGEraWtJdWJDMVBhekNOaFVvZ1hyZ0JLL1JSMzJlQ2szT2RpMGU2bXcw?=
 =?utf-8?B?NWx0TEl6ekV6dzB2ZHNhNHM2N09QakxUOXpWYUVNQXZEL3RwNkJaZWtmT21q?=
 =?utf-8?B?OFlkVXF5WEp5OEJhWmhlbThRQjlOYUZhby83dGNlbXZ1M1BhSUtTai8xdkdz?=
 =?utf-8?B?ZEMxTG56TE1LRWRxcCtEZjZOdC9sa2l4Y25TM043aVA5WW5mMVUwKzJmSGw5?=
 =?utf-8?B?NkU2ZUlKbjBwL0puSGJUWndyc3MvelpwaWZJSUlpaDVuK1JSdUdNTVptd3Ex?=
 =?utf-8?B?Ykp5a250R0ZubGxUNWdRaFZsWDVYL1JnWU1GTCtFZ2JBMnhqbzlWMUw3RWR6?=
 =?utf-8?B?WFVzNWVPZkNHQVM4TVpDSDh2NDBtRVQ4NytPVThmMGpROFhmR0hKT2hLMlhn?=
 =?utf-8?B?WHJsbERSTm9maHdzeFpWTFhycloyYm5JVUdoSUZvWGRtTlFtMEtPMUFsajMx?=
 =?utf-8?B?RzVyQzlSUWZQS1EzOGJlak91bk80dXBlTFVsUUl3T2hZWlkyMk9oWUNQcTZ3?=
 =?utf-8?B?cVkvUUU5RDJYbkVkRkRBY1FPREwzSDh0UllaMFdRcDFqczYxMk1sek1Ca2s5?=
 =?utf-8?B?UU9WWlZISFNIazVUVnA3ZHNDTkdHNGxHOXVjQ3didFV4enlGRlEydFVobUhj?=
 =?utf-8?B?NzRiYzk4U0NpbTMyVUlWUVhPUmF5UWkrT1lhTjQ2eUgvZlM2WmtVajN2ZmFx?=
 =?utf-8?B?eTRGVUhtanpCc1h4aGtKaFJmekhKNXo0NjVQeUtMZng1TWFBWU8vai92Y0c2?=
 =?utf-8?B?Tm1zeFpoelErdmdPeXVSbkFmeUV1YjNuaEthVXZoVjVYbVVPT0dEeUV2cXJL?=
 =?utf-8?B?K0QzUHVhUXZNcnQ1YjdhcXBsdjVNdGNMeGJqb1pReGhIRE90dmVjeW5GMDQz?=
 =?utf-8?B?V2didWVsajQ2ck14L0hLZStsS1F3b0hZNnVydk52S3pyU2hJZlFVNGx4VGlI?=
 =?utf-8?B?bEdjeTVyQVF2RDNRY0pJWUxNbGIvYU1wVXB2VHVmUkh2MDMwR0xxREVESmhQ?=
 =?utf-8?B?N053NWFIRVdJY3ZRLzh1Z3QrUTZBN291VXI0ejhUejNzS0JSdFpPWVR5cHpV?=
 =?utf-8?B?NXpaREVqNk1wVjlsdlpZa0VVUVpUamJieEVDWmd4L0k1QWpXRE5wS0RFUWoz?=
 =?utf-8?B?a1BpU0p1L2FZRDFWRUM5SHYxWUdEYk1wQkJleDErS2dFSGRXcEhEeTJ3T0c4?=
 =?utf-8?B?MSs5NHE5a0dMQlluenpJbFVwcXlEUEwwQkRXNFVIZHI3SzJYQUxwczBWWUVa?=
 =?utf-8?B?VEpoR2d1RUxXa0JLV01GVXBueXcxcCtqaDZHa3NLS3VNWHAvOUFHWGVMc2hG?=
 =?utf-8?B?NkxjT0JDZHIxVEdCeW52TmtiSVVWNmp1UXF4aEZ5RGgwZTg1Z1Y0eVNZTUJU?=
 =?utf-8?B?aTNRaFlMbFh4Zm56VklKYTNkNmhmR2RGd0Y5dzRlTUU1UEZaaXRHTzVxOXpL?=
 =?utf-8?B?UlNoeWxVR0RIVEVjOFNLYlkxU21hN2dEVC9sbm45em9DallGYjJ0Mmc3ek5u?=
 =?utf-8?B?NTR5UmF1TyszRzZXSTduVlR3UTFJZFg3a0l2QitkaGlLZTJWM3F1c1FiZFpk?=
 =?utf-8?B?L0pVMmgvNXpnVlF1RzBvY3BhengyZWlaWTdyTEo3Q3FFUk4yWmtKUUZpc1dB?=
 =?utf-8?B?c2VtSnFHcGpBcGdPNHBibDBuVncvMkZ6RlZQaHV3U2pSOTlBeUxHZEFhN2tw?=
 =?utf-8?B?OUFMMXpoL1NPWHdrWWJlRVlvb3AwL0Nyd0hDSi9HNk54ZUsrZXdvcURJa1gy?=
 =?utf-8?B?QndxcEFzUGZNNloxeDlkR04yaWk5VEhHRDJ5TmtsRDY2cktZMnF3QjJoNWFH?=
 =?utf-8?B?aEd4Q0NPSmFTUFJ6aXNOb0oycWpUZjh3NUMyZUd6OXJXRzBOaHNZdk1aOGNU?=
 =?utf-8?B?TG5GUFAxU3lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEdvRUE4aU94UE5rcUNOZWZxNlp4cG1zQ1JyVjlpL2pOaTFYVTJsN2tNUWls?=
 =?utf-8?B?ckpjeUNsUm1GQ1FYeXovQ05jeTQwRkFRb3JVZjN6OUVCaUJyQnM1NnMzMzVN?=
 =?utf-8?B?bndKVWpBOTVXVzcwZU04bmEvREtTbkVQMXNxUGN2dnQ2NzJUUU8wL3FIbzRV?=
 =?utf-8?B?SkMzNHJBMXdTM3JFK0VIZy83blVuS3EwbUxkUzV6c2ZNSm1jM09qWXVyTFlG?=
 =?utf-8?B?V1htVWJaTStVZS90ajNMNWRMSWVYaWFGK3UzR1RuM01Vdy9HbUJSWDZXenlM?=
 =?utf-8?B?b3BoRzdKQWlXdkkzUXgwMU5JQU51WHJ5eUFvcStjNE9rbDVJZ2RidWkzSHJC?=
 =?utf-8?B?akZBZ0tmOHhXc3hxV1NocGRabVFnYmo1Z3dyOTVKTXJhbEl1UHhxaU1JdnJR?=
 =?utf-8?B?RUlkcmFENjd5UnhjYWNuS2h0RVF5T3pDNmo5WTBkNnBMRHNCNzdQTGZQWE4y?=
 =?utf-8?B?OEp6MTl3eE5nK1lueUhvTm5INXFLR1draGlCZ1FPN1NnaUdWUkdyYmVlblVD?=
 =?utf-8?B?SHczYUx0WWFmQnNxNlliOW1wYWdvdGZaeUJBZ0pnMHNBNXY2ZGJvTWRidkpE?=
 =?utf-8?B?a3pHclRSYTBKcWpiT3BqLzFXZGs3YldBQTB6Sld3Tmk4K0pYUVprdnFYOGVW?=
 =?utf-8?B?c0NFZUFwU2VlOExuc25GZFJrNi9JRHA5SWJPYVJ5WFhwM2puNHFYNFdhd1Bm?=
 =?utf-8?B?Y0pxaEZ3RUI5YXM2RjFmL0VRVXMxL3U2dWQzQTFrUUxhT2krUlVOMTQzMzMy?=
 =?utf-8?B?cHNzUXFZSHowc2RGZkUyWUF5dmFXQVFUalMwREhnUkU0REVVaVQzTU00MExx?=
 =?utf-8?B?VzlVSS91bmlER2EyMEdlMVBkcVMxUGRsNWRBaENValc1S3lVc1laVFU4UG52?=
 =?utf-8?B?VVFQV2JwUHBsNUVNdTBYRnRIOGJib0VtbDBKQno3S05jbkxDVHFlV09qemJO?=
 =?utf-8?B?VVNqNGRMc1ZTVTI5a0NGWTZRMDRCb3NZNTZtMjNRcURWZThlWk5oODdUM09r?=
 =?utf-8?B?OVBBMEpXMk83emlOdkxnb2M3WFZSVURoRDBUZkc0cE40YzFPLy94eFh4ZmRp?=
 =?utf-8?B?b1JLOVAzOWpIemF3TFVqalkva3I1MjIrVnNzRlF5Q3VNdUIwcERDU29SbUZN?=
 =?utf-8?B?SExEdCtsRGIzSkd2VWJuN1hwalNOa2U5Z3ppYjdTTDJ4bmdDMjQ3Nk5NQk5u?=
 =?utf-8?B?enlpQ0JmVXVhUUQ5bDlxRmlreVRnVVd4L3h5NWtQWDV2Q2dHNEZncnZkU0RU?=
 =?utf-8?B?cEdCa0VnWXZEcHpNSlQ3OU5KTVdIKzk1SVlkVlFmYkQzNEY4bE01RkxBWSt0?=
 =?utf-8?B?aWJHNHFjaC9rdE9uQ244bSsrR1U2YTJNSmxwUHVXVzJxcDhzdHdZVU41ejlB?=
 =?utf-8?B?cC9HZkZDbHBRS0gvams4MjdNUGYvcEtad2JJMnpPVUVZdjg2QlBrMEZQMzVK?=
 =?utf-8?B?cFZpYTZBU083YVZDckN1SG9UenZCbW52M1BsdTdwcEtWNWkveFZGeEFobVlI?=
 =?utf-8?B?Tkk1U0swdm42VUxoYTVoZ3IvMG5KK01RbnY5K1p6bVhmd3lPci9hNGppcUFa?=
 =?utf-8?B?QzU4eVJ5aWtwOG9vVFYwMThGbzBNQm1NY2VzSEtjY1FDVitoamhCNFdtMVl2?=
 =?utf-8?B?V09rZmZXRE1JVW1jZ25BRmVqb3hteWg1MEVSZENiQVhTZVJoZVlHMXM1c0dt?=
 =?utf-8?B?TGJyNzMzT1JFemtQdkEzQ0ZQRG9ROFByeUFNZkVsRklITkhwMFNybzJYVVhU?=
 =?utf-8?B?ZUpSdEZqbk1pcUt3dm9GQTdqVUR3MklWWHVRTm5pL09NS25zanFTK0NOUEkx?=
 =?utf-8?B?QkZ2eEJKeUtPRjdrWHpIdUxSK0t2bVY2ZW1rTERZMWVaOFlZTTNQWUkwWGFp?=
 =?utf-8?B?ZHUwOXRLUk9UMld2Y2g3Zms3Q2lZQ0ZVTmx5Z2dObHdlTElQeitZVUVoUUhU?=
 =?utf-8?B?S3d3YTh1RExoRVJ4MXdJMzZKUVE1WXNWNFNreGJGTmJaWUw5Q3JTVTBKZHdt?=
 =?utf-8?B?alZJRmJtK0NUQUQxSFplQnUySG1zYVFESCtCOGJNUGFYRlBuaTZVZFp4bytV?=
 =?utf-8?B?dU14SnVwZWdVVktsamZkYUg3WDkrOVNmLy8rWEFMNmdRNnpvU1B3K01VaHNF?=
 =?utf-8?Q?xpfy3maX86Hn/64eNlkuBqOLm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b586eb-7e89-4467-fea3-08ddd01f93d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 10:47:00.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FshFLa472VC+rFAAzEsSDD40l/50e1ToweYmkWGN4a1hDC+OSlfDwa8LEmpYpwqx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

The PF0900 is a power management integrated circuit (PMIC) optimized
for high performance i.MX9x based applications. It features five high
efficiency buck converters, three linear and one vaon regulators. It
provides low quiescent current in Standby and low power off Modes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507221720.jxsGRfcE-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202506181134.0Hkvy7CK-lkp@intel.com/
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v3:
1. convert to use maple tree register cache.
2. change of_match_ptr() name to lowercase since dt-binding changed.
3. remove the of_parse_cb and dvs from pf0900_regulators since the
   unnecessary property nxp,dvs-run/standby-voltage removed.
4. add set_suspend_enable/disable/voltage for the SW regulator_ops.
   the run/standby voltage can be adjusted via the API which regulator
   driver provides is recommended.
   These changes come from binding review comments:
   https://lore.kernel.org/imx/e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org/
5. add bitfield.h header due to build issue.
6. correct the sw4 id.
7. add PF0900 prefix for shorter macro in order to avoid duplication.
8. merge the same mask in order to simplify code.

Changes for v2:
1. modify the copyright comment block to C++ style.
2. add reg_read/write for regmap_bus.
3. remove original pf0900_pmic_read/write.
4. remove many regulator operations.
5. use regmap_read replace pf0900_pmic_read.
6. use regmap_update_bits and regmap_write_bits replace pf0900_pmic_write.
7. move the code from pf0900.h to pf0900-regulator.c and delete the
   header file.
8. remove unmask status interrupts and add unmask regulator interrupts.
9. remove many interrupts check warning print from irq_handler.
10. add notifier for regulator event.
11. remove unused macro define.
12. add PF0900 prefix for IRQ macro define in order to avoid duplication.
13. use GENMASK() and BIT() to replace mask marco define.
14. remove redundant enum pf0900_chip_type.
15. remove redundant print info and comments.
16. add dvs property present check because this property is optional.
17. remove ret == -EINVAL check from sw_set_dvs() function.
---
 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf0900-regulator.c | 975 +++++++++++++++++++++++++++++++++++
 3 files changed, 984 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eaa6df1c9f806652a21942bcb48084ba63f942d9..b474b4bf63b37d374834067caf6166d8b093699b 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1006,6 +1006,14 @@ config REGULATOR_PCAP
 	 This driver provides support for the voltage regulators of the
 	 PCAP2 PMIC.
 
+config REGULATOR_PF0900
+	tristate "NXP PF0900/PF0901/PF09XX regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	Say y here to support the NXP PF0900/PF0901/PF09XX PMIC
+	regulator driver.
+
 config REGULATOR_PF8X00
 	tristate "NXP PF8100/PF8121A/PF8200 regulator driver"
 	depends on I2C && OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index be98b29d6675d8be1ca984c2d137bdfc4ba2de87..74b029d29a8b7faf79f3f82bb848eab65568753f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -124,6 +124,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF0900) += pf0900-regulator.o
 obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
 obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
diff --git a/drivers/regulator/pf0900-regulator.c b/drivers/regulator/pf0900-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..b5effee3291724f95ba4c820f6518ee25d8a57e2
--- /dev/null
+++ b/drivers/regulator/pf0900-regulator.c
@@ -0,0 +1,975 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2025 NXP.
+// NXP PF0900 pmic driver
+
+#include <linux/bitfield.h>
+#include <linux/crc8.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+enum pf0900_regulators {
+	PF0900_SW1 = 0,
+	PF0900_SW2,
+	PF0900_SW3,
+	PF0900_SW4,
+	PF0900_SW5,
+	PF0900_LDO1,
+	PF0900_LDO2,
+	PF0900_LDO3,
+	PF0900_VAON,
+	PF0900_REGULATOR_CNT,
+};
+
+enum {
+	PF0900_DVS_LEVEL_RUN = 0,
+	PF0900_DVS_LEVEL_STANDBY,
+	PF0900_DVS_LEVEL_MAX,
+};
+
+
+#define PF0900_VAON_VOLTAGE_NUM 0x03
+#define PF0900_SW_VOLTAGE_NUM   0x100
+#define PF0900_LDO_VOLTAGE_NUM  0x20
+
+#define REGU_SW_CNT             0x5
+#define REGU_LDO_VAON_CNT       0x4
+
+enum {
+	PF0900_REG_DEV_ID	    = 0x00,
+	PF0900_REG_DEV_FAM	    = 0x01,
+	PF0900_REG_REV_ID	    = 0x02,
+	PF0900_REG_PROG_ID1	    = 0x03,
+	PF0900_REG_PROG_ID2	    = 0x04,
+	PF0900_REG_SYSTEM_INT	    = 0x05,
+	PF0900_REG_STATUS1_INT	    = 0x06,
+	PF0900_REG_STATUS1_MSK      = 0x07,
+	PF0900_REG_STATUS1_SNS	    = 0x08,
+	PF0900_REG_STATUS2_INT      = 0x09,
+	PF0900_REG_STATUS2_MSK      = 0x0A,
+	PF0900_REG_STATUS2_SNS	    = 0x0B,
+	PF0900_REG_STATUS3_INT      = 0x0C,
+	PF0900_REG_STATUS3_MSK      = 0x0D,
+	PF0900_REG_SW_MODE_INT      = 0x0E,
+	PF0900_REG_SW_MODE_MSK      = 0x0F,
+	PF0900_REG_SW_ILIM_INT      = 0x10,
+	PF0900_REG_SW_ILIM_MSK      = 0x11,
+	PF0900_REG_SW_ILIM_SNS      = 0x12,
+	PF0900_REG_LDO_ILIM_INT     = 0x13,
+	PF0900_REG_LDO_ILIM_MSK     = 0x14,
+	PF0900_REG_LDO_ILIM_SNS     = 0x15,
+	PF0900_REG_SW_UV_INT        = 0x16,
+	PF0900_REG_SW_UV_MSK        = 0x17,
+	PF0900_REG_SW_UV_SNS        = 0x18,
+	PF0900_REG_SW_OV_INT        = 0x19,
+	PF0900_REG_SW_OV_MSK        = 0x1A,
+	PF0900_REG_SW_OV_SNS        = 0x1B,
+	PF0900_REG_LDO_UV_INT       = 0x1C,
+	PF0900_REG_LDO_UV_MSK       = 0x1D,
+	PF0900_REG_LDO_UV_SNS       = 0x1E,
+	PF0900_REG_LDO_OV_INT       = 0x1F,
+	PF0900_REG_LDO_OV_MSK       = 0x20,
+	PF0900_REG_LDO_OV_SNS       = 0x21,
+	PF0900_REG_PWRON_INT        = 0x22,
+	PF0900_REG_IO_INT           = 0x24,
+	PF0900_REG_IO_MSK           = 0x25,
+	PF0900_REG_IO_SNS           = 0x26,
+	PF0900_REG_IOSHORT_SNS      = 0x27,
+	PF0900_REG_ABIST_OV1        = 0x28,
+	PF0900_REG_ABIST_OV2        = 0x29,
+	PF0900_REG_ABIST_UV1        = 0x2A,
+	PF0900_REG_ABIST_UV2        = 0x2B,
+	PF0900_REG_ABIST_IO         = 0x2C,
+	PF0900_REG_TEST_FLAGS       = 0x2D,
+	PF0900_REG_HFAULT_FLAGS     = 0x2E,
+	PF0900_REG_FAULT_FLAGS      = 0x2F,
+	PF0900_REG_FS0B_CFG         = 0x30,
+	PF0900_REG_FCCU_CFG         = 0x31,
+	PF0900_REG_RSTB_CFG1        = 0x32,
+	PF0900_REG_SYSTEM_CMD       = 0x33,
+	PF0900_REG_FS0B_CMD         = 0x34,
+	PF0900_REG_SECURE_WR1       = 0x35,
+	PF0900_REG_SECURE_WR2       = 0x36,
+	PF0900_REG_VMON_CFG1        = 0x37,
+	PF0900_REG_SYS_CFG1         = 0x38,
+	PF0900_REG_GPO_CFG          = 0x39,
+	PF0900_REG_GPO_CTRL         = 0x3A,
+	PF0900_REG_PWRUP_CFG        = 0x3B,
+	PF0900_REG_RSTB_PWRUP       = 0x3C,
+	PF0900_REG_GPIO1_PWRUP      = 0x3D,
+	PF0900_REG_GPIO2_PWRUP      = 0x3E,
+	PF0900_REG_GPIO3_PWRUP      = 0x3F,
+	PF0900_REG_GPIO4_PWRUP      = 0x40,
+	PF0900_REG_VMON1_PWRUP      = 0x41,
+	PF0900_REG_VMON2_PWRUP      = 0x42,
+	PF0900_REG_SW1_PWRUP        = 0x43,
+	PF0900_REG_SW2_PWRUP        = 0x44,
+	PF0900_REG_SW3_PWRUP        = 0x45,
+	PF0900_REG_SW4_PWRUP        = 0x46,
+	PF0900_REG_SW5_PWRUP        = 0x47,
+	PF0900_REG_LDO1_PWRUP       = 0x48,
+	PF0900_REG_LDO2_PWRUP       = 0x49,
+	PF0900_REG_LDO3_PWRUP       = 0x4A,
+	PF0900_REG_VAON_PWRUP       = 0x4B,
+	PF0900_REG_FREQ_CTRL        = 0x4C,
+	PF0900_REG_PWRON_CFG        = 0x4D,
+	PF0900_REG_WD_CTRL1         = 0x4E,
+	PF0900_REG_WD_CTRL2         = 0x4F,
+	PF0900_REG_WD_CFG1          = 0x50,
+	PF0900_REG_WD_CFG2          = 0x51,
+	PF0900_REG_WD_CNT1          = 0x52,
+	PF0900_REG_WD_CNT2          = 0x53,
+	PF0900_REG_FAULT_CFG        = 0x54,
+	PF0900_REG_FAULT_CNT        = 0x55,
+	PF0900_REG_DFS_CNT          = 0x56,
+	PF0900_REG_AMUX_CFG         = 0x57,
+	PF0900_REG_VMON1_RUN_CFG    = 0x58,
+	PF0900_REG_VMON1_STBY_CFG   = 0x59,
+	PF0900_REG_VMON1_CTRL       = 0x5A,
+	PF0900_REG_VMON2_RUN_CFG    = 0x5B,
+	PF0900_REG_VMON2_STBY_CFG   = 0x5C,
+	PF0900_REG_VMON2_CTRL       = 0x5D,
+	PF0900_REG_SW1_VRUN         = 0x5E,
+	PF0900_REG_SW1_VSTBY        = 0x5F,
+	PF0900_REG_SW1_MODE         = 0x60,
+	PF0900_REG_SW1_CFG1         = 0x61,
+	PF0900_REG_SW1_CFG2         = 0x62,
+	PF0900_REG_SW2_VRUN         = 0x63,
+	PF0900_REG_SW2_VSTBY        = 0x64,
+	PF0900_REG_SW2_MODE         = 0x65,
+	PF0900_REG_SW2_CFG1         = 0x66,
+	PF0900_REG_SW2_CFG2         = 0x67,
+	PF0900_REG_SW3_VRUN         = 0x68,
+	PF0900_REG_SW3_VSTBY        = 0x69,
+	PF0900_REG_SW3_MODE         = 0x6A,
+	PF0900_REG_SW3_CFG1         = 0x6B,
+	PF0900_REG_SW3_CFG2         = 0x6C,
+	PF0900_REG_SW4_VRUN         = 0x6D,
+	PF0900_REG_SW4_VSTBY        = 0x6E,
+	PF0900_REG_SW4_MODE         = 0x6F,
+	PF0900_REG_SW4_CFG1         = 0x70,
+	PF0900_REG_SW4_CFG2         = 0x71,
+	PF0900_REG_SW5_VRUN         = 0x72,
+	PF0900_REG_SW5_VSTBY        = 0x73,
+	PF0900_REG_SW5_MODE         = 0x74,
+	PF0900_REG_SW5_CFG1         = 0x75,
+	PF0900_REG_SW5_CFG2         = 0x76,
+	PF0900_REG_LDO1_RUN         = 0x77,
+	PF0900_REG_LDO1_STBY        = 0x78,
+	PF0900_REG_LDO1_CFG2        = 0x79,
+	PF0900_REG_LDO2_RUN         = 0x7A,
+	PF0900_REG_LDO2_STBY        = 0x7B,
+	PF0900_REG_LDO2_CFG2        = 0x7C,
+	PF0900_REG_LDO3_RUN         = 0x7D,
+	PF0900_REG_LDO3_STBY        = 0x7E,
+	PF0900_REG_LDO3_CFG2        = 0x7F,
+	PF0900_REG_VAON_CFG1        = 0x80,
+	PF0900_REG_VAON_CFG2        = 0x81,
+	PF0900_REG_SYS_DIAG         = 0x82,
+	PF0900_MAX_REGISTER,
+};
+
+/* PF0900 SW MODE */
+#define SW_RUN_MODE_OFF                 0x00
+#define SW_RUN_MODE_PWM                 0x01
+#define SW_RUN_MODE_PFM                 0x02
+#define SW_STBY_MODE_OFF                0x00
+#define SW_STBY_MODE_PWM                0x04
+#define SW_STBY_MODE_PFM                0x08
+
+/* PF0900 SW MODE MASK */
+#define SW_RUN_MODE_MASK                GENMASK(1, 0)
+#define SW_STBY_MODE_MASK               GENMASK(3, 2)
+
+/* PF0900 SW VRUN/VSTBY MASK */
+#define PF0900_SW_VOL_MASK              GENMASK(7, 0)
+
+/* PF0900_REG_VAON_CFG1 bits */
+#define PF0900_VAON_1P8V                0x01
+
+#define PF0900_VAON_MASK                GENMASK(1, 0)
+
+/* PF0900_REG_SWX_CFG1 MASK */
+#define PF0900_SW_DVS_MASK              GENMASK(4, 3)
+
+/* PF0900_REG_LDO_RUN MASK */
+#define VLDO_RUN_MASK                   GENMASK(4, 0)
+#define LDO_RUN_EN_MASK                 BIT(5)
+
+/* PF0900_REG_STATUS1_INT bits */
+#define PF0900_IRQ_PWRUP                BIT(3)
+
+/* PF0900_REG_ILIM_INT bits */
+#define PF0900_IRQ_SW1_IL               BIT(0)
+#define PF0900_IRQ_SW2_IL               BIT(1)
+#define PF0900_IRQ_SW3_IL               BIT(2)
+#define PF0900_IRQ_SW4_IL               BIT(3)
+#define PF0900_IRQ_SW5_IL               BIT(4)
+
+#define PF0900_IRQ_LDO1_IL              BIT(0)
+#define PF0900_IRQ_LDO2_IL              BIT(1)
+#define PF0900_IRQ_LDO3_IL              BIT(2)
+
+/* PF0900_REG_UV_INT bits */
+#define PF0900_IRQ_SW1_UV               BIT(0)
+#define PF0900_IRQ_SW2_UV               BIT(1)
+#define PF0900_IRQ_SW3_UV               BIT(2)
+#define PF0900_IRQ_SW4_UV               BIT(3)
+#define PF0900_IRQ_SW5_UV               BIT(4)
+
+#define PF0900_IRQ_LDO1_UV              BIT(0)
+#define PF0900_IRQ_LDO2_UV              BIT(1)
+#define PF0900_IRQ_LDO3_UV              BIT(2)
+#define PF0900_IRQ_VAON_UV              BIT(3)
+
+/* PF0900_REG_OV_INT bits */
+#define PF0900_IRQ_SW1_OV               BIT(0)
+#define PF0900_IRQ_SW2_OV               BIT(1)
+#define PF0900_IRQ_SW3_OV               BIT(2)
+#define PF0900_IRQ_SW4_OV               BIT(3)
+#define PF0900_IRQ_SW5_OV               BIT(4)
+
+#define PF0900_IRQ_LDO1_OV              BIT(0)
+#define PF0900_IRQ_LDO2_OV              BIT(1)
+#define PF0900_IRQ_LDO3_OV              BIT(2)
+#define PF0900_IRQ_VAON_OV              BIT(3)
+
+struct pf0900_regulator_desc {
+	struct regulator_desc desc;
+	unsigned int suspend_enable_mask;
+	unsigned int suspend_voltage_reg;
+	unsigned int suspend_voltage_cache;
+};
+
+struct pf0900_drvdata {
+	const struct pf0900_regulator_desc *desc;
+	unsigned int rcnt;
+};
+
+struct pf0900 {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct pf0900_drvdata *drvdata;
+	struct regulator_dev *rdevs[PF0900_REGULATOR_CNT];
+	int irq;
+	unsigned short addr;
+	bool crc_en;
+};
+
+enum pf0900_regulator_type {
+	PF0900_SW = 0,
+	PF0900_LDO,
+};
+
+#define PF0900_REGU_IRQ(_reg, _type, _event)	\
+	{					\
+		.reg = _reg,			\
+		.type = _type,			\
+		.event = _event,		\
+	}
+
+struct pf0900_regulator_irq {
+	unsigned int  reg;
+	unsigned int  type;
+	unsigned int  event;
+};
+
+static const struct regmap_range pf0900_range = {
+	.range_min = PF0900_REG_DEV_ID,
+	.range_max = PF0900_REG_SYS_DIAG,
+};
+
+static const struct regmap_access_table pf0900_volatile_regs = {
+	.yes_ranges = &pf0900_range,
+	.n_yes_ranges = 1,
+};
+
+static const struct regmap_config pf0900_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &pf0900_volatile_regs,
+	.max_register = PF0900_MAX_REGISTER - 1,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static uint8_t crc8_j1850(unsigned short addr, unsigned int reg,
+			  unsigned int val)
+{
+	uint8_t crcBuf[3];
+	uint8_t t_crc;
+	uint8_t i, j;
+
+	crcBuf[0] = addr;
+	crcBuf[1] = reg;
+	crcBuf[2] = val;
+	t_crc = 0xFF;
+
+	/*
+	 * The CRC calculation is based on the standard CRC-8-SAE as
+	 * defined in the SAE-J1850 specification with the following
+	 * characteristics.
+	 * Polynomial = 0x1D
+	 * Initial Value = 0xFF
+	 * The CRC byte is calculated by shifting 24-bit data through
+	 * the CRC polynomial.The 24-bits package is built as follows:
+	 * DEVICE_ADDR[b8] + REGISTER_ADDR [b8] +DATA[b8]
+	 * The DEVICE_ADDR is calculated as the 7-bit slave address
+	 * shifted left one space plus the corresponding read/write bit.
+	 * (7Bit Address [b7] << 1 ) + R/W = DEVICE_ADDR[b8]
+	 */
+	for (i = 0; i < sizeof(crcBuf); i++) {
+		t_crc ^= crcBuf[i];
+		for (j = 0; j < 8; j++) {
+			if ((t_crc & 0x80) != 0) {
+				t_crc <<= 1;
+				t_crc ^= 0x1D;
+			} else {
+				t_crc <<= 1;
+			}
+		}
+	}
+
+	return t_crc;
+}
+
+static int pf0900_regmap_read(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct pf0900 *pf0900 = dev_get_drvdata(dev);
+	int ret;
+	u8 crc;
+
+	if (!pf0900 || !pf0900->dev)
+		return -EINVAL;
+
+	if (reg >= PF0900_MAX_REGISTER) {
+		dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
+		return -EINVAL;
+	}
+
+	if (pf0900->crc_en) {
+		ret = i2c_smbus_read_word_data(i2c, reg);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
+			return ret;
+		}
+
+		*val = (u16)ret;
+		crc = crc8_j1850(pf0900->addr << 1 | 0x1, reg, FIELD_GET(GENMASK(7, 0), *val));
+		if (crc != FIELD_GET(GENMASK(15, 8), *val)) {
+			dev_err(pf0900->dev, "Crc check error!\n");
+			return -EINVAL;
+		}
+		*val = FIELD_GET(GENMASK(7, 0), *val);
+	} else {
+		ret = i2c_smbus_read_byte_data(i2c, reg);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Read error at reg=0x%x: %d\n", reg, ret);
+			return ret;
+		}
+		*val = ret;
+	}
+
+	return 0;
+}
+
+static int pf0900_regmap_write(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	struct pf0900 *pf0900 = dev_get_drvdata(dev);
+	uint8_t data[2];
+	int ret;
+
+	if (!pf0900 || !pf0900->dev)
+		return -EINVAL;
+
+	if (reg >= PF0900_MAX_REGISTER) {
+		dev_err(pf0900->dev, "Invalid register address: 0x%x\n", reg);
+		return -EINVAL;
+	}
+
+	data[0] = val;
+	if (pf0900->crc_en) {
+		/* Get CRC */
+		data[1] = crc8_j1850(pf0900->addr << 1, reg, data[0]);
+		val = FIELD_PREP(GENMASK(15, 8), data[1]) | data[0];
+		ret = i2c_smbus_write_word_data(i2c, reg, val);
+	} else {
+		ret = i2c_smbus_write_byte_data(i2c, reg, data[0]);
+	}
+
+	if (ret) {
+		dev_err(pf0900->dev, "Write reg=0x%x error!\n", reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int pf0900_suspend_enable(struct regulator_dev *rdev)
+{
+	struct pf0900_regulator_desc *rdata = rdev_get_drvdata(rdev);
+	struct regmap *rmap = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(rmap, rdata->desc.enable_reg,
+				  rdata->suspend_enable_mask, SW_STBY_MODE_PFM);
+}
+
+static int pf0900_suspend_disable(struct regulator_dev *rdev)
+{
+	struct pf0900_regulator_desc *rdata = rdev_get_drvdata(rdev);
+	struct regmap *rmap = rdev_get_regmap(rdev);
+
+	return regmap_update_bits(rmap, rdata->desc.enable_reg,
+				  rdata->suspend_enable_mask, SW_STBY_MODE_OFF);
+}
+
+static int pf0900_set_suspend_voltage(struct regulator_dev *rdev, int uV)
+{
+	struct pf0900_regulator_desc *rdata = rdev_get_drvdata(rdev);
+	struct regmap *rmap = rdev_get_regmap(rdev);
+	int ret;
+
+	if (rdata->suspend_voltage_cache == uV)
+		return 0;
+
+	ret = regulator_map_voltage_iterate(rdev, uV, uV);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to map %i uV\n", uV);
+		return ret;
+	}
+
+	dev_dbg(rdev_get_dev(rdev), "uV: %i, reg: 0x%x, msk: 0x%x, val: 0x%x\n",
+		uV, rdata->suspend_voltage_reg, rdata->desc.vsel_mask, ret);
+	ret = regmap_update_bits(rmap, rdata->suspend_voltage_reg,
+				 rdata->desc.vsel_mask, ret);
+	if (ret < 0) {
+		dev_err(rdev_get_dev(rdev), "failed to set %i uV\n", uV);
+		return ret;
+	}
+
+	rdata->suspend_voltage_cache = uV;
+
+	return 0;
+}
+
+static const struct regmap_bus pf0900_regmap_bus = {
+	.reg_read = pf0900_regmap_read,
+	.reg_write = pf0900_regmap_write,
+};
+
+static const struct regulator_ops pf0900_avon_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops pf0900_dvs_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.set_ramp_delay	= regulator_set_ramp_delay_regmap,
+	.set_suspend_enable = pf0900_suspend_enable,
+	.set_suspend_disable = pf0900_suspend_disable,
+	.set_suspend_voltage = pf0900_set_suspend_voltage,
+};
+
+static const struct regulator_ops pf0900_ldo_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+/*
+ * SW1/2/3/4/5
+ * SW1_DVS[1:0] SW1 DVS ramp rate setting
+ * 00: 15.6mV/8usec
+ * 01: 15.6mV/4usec
+ * 10: 15.6mV/2usec
+ * 11: 15.6mV/1usec
+ */
+static const unsigned int pf0900_dvs_sw_ramp_table[] = {
+	1950, 3900, 7800, 15600
+};
+
+/* VAON 1.8V, 3.0V, or 3.3V */
+static const int pf0900_vaon_voltages[] = {
+	0, 1800000, 3000000, 3300000,
+};
+
+/*
+ * SW1 0.5V to 3.3V
+ * 0.5V to 1.35V (6.25mV step)
+ * 1.8V to 2.5V (125mV step)
+ * 2.8V to 3.3V (250mV step)
+ */
+static const struct linear_range pf0900_dvs_sw1_volts[] = {
+	REGULATOR_LINEAR_RANGE(0,        0x00, 0x08, 0),
+	REGULATOR_LINEAR_RANGE(500000,   0x09, 0x91, 6250),
+	REGULATOR_LINEAR_RANGE(0,        0x92, 0x9E, 0),
+	REGULATOR_LINEAR_RANGE(1500000,  0x9F, 0x9F, 0),
+	REGULATOR_LINEAR_RANGE(1800000,  0xA0, 0xD8, 12500),
+	REGULATOR_LINEAR_RANGE(0,        0xD9, 0xDF, 0),
+	REGULATOR_LINEAR_RANGE(2800000,  0xE0, 0xF4, 25000),
+	REGULATOR_LINEAR_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+/*
+ * SW2/3/4/5 0.3V to 3.3V
+ * 0.45V to 1.35V (6.25mV step)
+ * 1.8V to 2.5V (125mV step)
+ * 2.8V to 3.3V (250mV step)
+ */
+static const struct linear_range pf0900_dvs_sw2345_volts[] = {
+	REGULATOR_LINEAR_RANGE(300000,   0x00, 0x00, 0),
+	REGULATOR_LINEAR_RANGE(450000,   0x01, 0x91, 6250),
+	REGULATOR_LINEAR_RANGE(0,        0x92, 0x9E, 0),
+	REGULATOR_LINEAR_RANGE(1500000,  0x9F, 0x9F, 0),
+	REGULATOR_LINEAR_RANGE(1800000,  0xA0, 0xD8, 12500),
+	REGULATOR_LINEAR_RANGE(0,        0xD9, 0xDF, 0),
+	REGULATOR_LINEAR_RANGE(2800000,  0xE0, 0xF4, 25000),
+	REGULATOR_LINEAR_RANGE(0,        0xF5, 0xFF, 0),
+};
+
+/*
+ * LDO1
+ * 0.75V to 3.3V
+ */
+static const struct linear_range pf0900_ldo1_volts[] = {
+	REGULATOR_LINEAR_RANGE(750000,   0x00, 0x0F, 50000),
+	REGULATOR_LINEAR_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+/*
+ * LDO2/3
+ * 0.65V to 3.3V (50mV step)
+ */
+static const struct linear_range pf0900_ldo23_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000,   0x00, 0x0D, 50000),
+	REGULATOR_LINEAR_RANGE(1400000,  0x0E, 0x0F, 100000),
+	REGULATOR_LINEAR_RANGE(1800000,  0x10, 0x1F, 100000),
+};
+
+static const struct pf0900_regulator_desc pf0900_regulators[] = {
+	{
+		.desc = {
+			.name = "sw1",
+			.of_match = of_match_ptr("sw1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW1,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw1_volts),
+			.vsel_reg = PF0900_REG_SW1_VRUN,
+			.vsel_mask = PF0900_SW_VOL_MASK,
+			.enable_reg = PF0900_REG_SW1_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW1_CFG1,
+			.ramp_mask = PF0900_SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+		},
+		.suspend_enable_mask = SW_STBY_MODE_MASK,
+		.suspend_voltage_reg = PF0900_REG_SW1_VSTBY,
+	},
+	{
+		.desc = {
+			.name = "sw2",
+			.of_match = of_match_ptr("sw2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW2,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW2_VRUN,
+			.vsel_mask = PF0900_SW_VOL_MASK,
+			.enable_reg = PF0900_REG_SW2_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW2_CFG1,
+			.ramp_mask = PF0900_SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+		},
+		.suspend_enable_mask = SW_STBY_MODE_MASK,
+		.suspend_voltage_reg = PF0900_REG_SW2_VSTBY,
+	},
+	{
+		.desc = {
+			.name = "sw3",
+			.of_match = of_match_ptr("sw3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW3,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW3_VRUN,
+			.vsel_mask = PF0900_SW_VOL_MASK,
+			.enable_reg = PF0900_REG_SW3_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW3_CFG1,
+			.ramp_mask = PF0900_SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+		},
+		.suspend_enable_mask = SW_STBY_MODE_MASK,
+		.suspend_voltage_reg = PF0900_REG_SW3_VSTBY,
+	},
+	{
+		.desc = {
+			.name = "sw4",
+			.of_match = of_match_ptr("sw4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW4,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW4_VRUN,
+			.vsel_mask = PF0900_SW_VOL_MASK,
+			.enable_reg = PF0900_REG_SW4_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW4_CFG1,
+			.ramp_mask = PF0900_SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+		},
+		.suspend_enable_mask = SW_STBY_MODE_MASK,
+		.suspend_voltage_reg = PF0900_REG_SW4_VSTBY,
+	},
+	{
+		.desc = {
+			.name = "sw5",
+			.of_match = of_match_ptr("sw5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_SW5,
+			.ops = &pf0900_dvs_sw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_SW_VOLTAGE_NUM,
+			.linear_ranges = pf0900_dvs_sw2345_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_dvs_sw2345_volts),
+			.vsel_reg = PF0900_REG_SW5_VRUN,
+			.vsel_mask = PF0900_SW_VOL_MASK,
+			.enable_reg = PF0900_REG_SW5_MODE,
+			.enable_mask = SW_RUN_MODE_MASK,
+			.enable_val = SW_RUN_MODE_PWM,
+			.ramp_reg = PF0900_REG_SW5_CFG1,
+			.ramp_mask = PF0900_SW_DVS_MASK,
+			.ramp_delay_table = pf0900_dvs_sw_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pf0900_dvs_sw_ramp_table),
+			.owner = THIS_MODULE,
+		},
+		.suspend_enable_mask = SW_STBY_MODE_MASK,
+		.suspend_voltage_reg = PF0900_REG_SW5_VSTBY,
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("ldo1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO1,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo1_volts),
+			.vsel_reg = PF0900_REG_LDO1_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO1_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo2",
+			.of_match = of_match_ptr("ldo2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO2,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo23_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo23_volts),
+			.vsel_reg = PF0900_REG_LDO2_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO2_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo3",
+			.of_match = of_match_ptr("ldo3"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_LDO3,
+			.ops = &pf0900_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_LDO_VOLTAGE_NUM,
+			.linear_ranges = pf0900_ldo23_volts,
+			.n_linear_ranges = ARRAY_SIZE(pf0900_ldo23_volts),
+			.vsel_reg = PF0900_REG_LDO3_RUN,
+			.vsel_mask = VLDO_RUN_MASK,
+			.enable_reg = PF0900_REG_LDO3_RUN,
+			.enable_mask = LDO_RUN_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "vaon",
+			.of_match = of_match_ptr("vaon"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PF0900_VAON,
+			.ops = &pf0900_avon_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PF0900_VAON_VOLTAGE_NUM,
+			.volt_table = pf0900_vaon_voltages,
+			.enable_reg = PF0900_REG_VAON_CFG1,
+			.enable_mask = PF0900_VAON_MASK,
+			.enable_val = PF0900_VAON_1P8V,
+			.vsel_reg = PF0900_REG_VAON_CFG1,
+			.vsel_mask = PF0900_VAON_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
+struct pf0900_regulator_irq regu_irqs[] = {
+	PF0900_REGU_IRQ(PF0900_REG_SW_ILIM_INT, PF0900_SW, REGULATOR_ERROR_OVER_CURRENT_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_ILIM_INT, PF0900_LDO, REGULATOR_ERROR_OVER_CURRENT_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_SW_UV_INT, PF0900_SW, REGULATOR_ERROR_UNDER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_UV_INT, PF0900_LDO, REGULATOR_ERROR_UNDER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_SW_OV_INT, PF0900_SW, REGULATOR_ERROR_OVER_VOLTAGE_WARN),
+	PF0900_REGU_IRQ(PF0900_REG_LDO_OV_INT, PF0900_LDO, REGULATOR_ERROR_OVER_VOLTAGE_WARN),
+};
+
+static irqreturn_t pf0900_irq_handler(int irq, void *data)
+{
+	unsigned int val, regu, i, index;
+	struct pf0900 *pf0900 = data;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(regu_irqs); i++) {
+		ret = regmap_read(pf0900->regmap, regu_irqs[i].reg, &val);
+		if (ret < 0) {
+			dev_err(pf0900->dev, "Failed to read %d\n", ret);
+			return IRQ_NONE;
+		}
+		if (val) {
+			ret = regmap_write_bits(pf0900->regmap, regu_irqs[i].reg, val, val);
+			if (ret < 0) {
+				dev_err(pf0900->dev, "Failed to update %d\n", ret);
+				return IRQ_NONE;
+			}
+
+			if (regu_irqs[i].type == PF0900_SW) {
+				for (index = 0; index < REGU_SW_CNT; index++) {
+					if (val & BIT(index)) {
+						regu = (enum pf0900_regulators)index;
+						regulator_notifier_call_chain(pf0900->rdevs[regu],
+									      regu_irqs[i].event,
+									      NULL);
+					}
+				}
+			} else if (regu_irqs[i].type == PF0900_LDO) {
+				for (index = 0; index < REGU_LDO_VAON_CNT; index++) {
+					if (val & BIT(index)) {
+						regu = (enum pf0900_regulators)index + PF0900_LDO1;
+						regulator_notifier_call_chain(pf0900->rdevs[regu],
+									      regu_irqs[i].event,
+									      NULL);
+					}
+				}
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pf0900_i2c_probe(struct i2c_client *i2c)
+{
+	const struct pf0900_regulator_desc *regulator_desc;
+	const struct pf0900_drvdata *drvdata = NULL;
+	struct device_node *np = i2c->dev.of_node;
+	unsigned int device_id, device_fam, i;
+	struct regulator_config config = { };
+	struct pf0900 *pf0900;
+	int ret;
+
+	if (!i2c->irq)
+		return dev_err_probe(&i2c->dev, -EINVAL, "No IRQ configured?\n");
+
+	pf0900 = devm_kzalloc(&i2c->dev, sizeof(struct pf0900), GFP_KERNEL);
+	if (!pf0900)
+		return -ENOMEM;
+
+	drvdata = device_get_match_data(&i2c->dev);
+	if (!drvdata)
+		return dev_err_probe(&i2c->dev, -EINVAL, "unable to find driver data\n");
+
+	regulator_desc = drvdata->desc;
+	pf0900->drvdata = drvdata;
+	pf0900->crc_en = of_property_read_bool(np, "nxp,i2c-crc-enable");
+	pf0900->irq = i2c->irq;
+	pf0900->dev = &i2c->dev;
+	pf0900->addr = i2c->addr;
+
+	dev_set_drvdata(&i2c->dev, pf0900);
+
+	pf0900->regmap = devm_regmap_init(&i2c->dev, &pf0900_regmap_bus, &i2c->dev,
+					       &pf0900_regmap_config);
+	if (IS_ERR(pf0900->regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(pf0900->regmap),
+				     "regmap initialization failed\n");
+	ret = regmap_read(pf0900->regmap, PF0900_REG_DEV_ID, &device_id);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device id error\n");
+
+	ret = regmap_read(pf0900->regmap, PF0900_REG_DEV_FAM, &device_fam);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Read device fam error\n");
+
+	/* Check your board and dts for match the right pmic */
+	if (device_fam == 0x09 && (device_id & 0x1F) != 0x0)
+		return dev_err_probe(&i2c->dev, -EINVAL, "Device id(%x) mismatched\n",
+				     device_id >> 4);
+
+	for (i = 0; i < drvdata->rcnt; i++) {
+		const struct regulator_desc *desc;
+		const struct pf0900_regulator_desc *r;
+
+		r = &regulator_desc[i];
+		desc = &r->desc;
+		config.regmap = pf0900->regmap;
+		config.driver_data = (void *)r;
+		config.dev = pf0900->dev;
+
+		pf0900->rdevs[i] = devm_regulator_register(pf0900->dev, desc, &config);
+		if (IS_ERR(pf0900->rdevs[i]))
+			return dev_err_probe(pf0900->dev, PTR_ERR(pf0900->rdevs[i]),
+					     "Failed to register regulator(%s)\n", desc->name);
+	}
+
+	ret = devm_request_threaded_irq(pf0900->dev, pf0900->irq, NULL,
+					pf0900_irq_handler,
+					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
+					"pf0900-irq", pf0900);
+
+	if (ret != 0)
+		return dev_err_probe(pf0900->dev, ret, "Failed to request IRQ: %d\n",
+				     pf0900->irq);
+	/*
+	 * The PWRUP_M is unmasked by default. When the device enter in RUN state,
+	 * it will assert the PWRUP_I interrupt and assert the INTB pin to inform
+	 * the MCU that it has finished the power up sequence properly.
+	 */
+	ret = regmap_write_bits(pf0900->regmap, PF0900_REG_STATUS1_INT, PF0900_IRQ_PWRUP,
+				PF0900_IRQ_PWRUP);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Clean PWRUP_I error\n");
+
+	/* mask interrupt PWRUP */
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_STATUS1_MSK, PF0900_IRQ_PWRUP,
+				 PF0900_IRQ_PWRUP);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_ILIM_MSK, PF0900_IRQ_SW1_IL |
+				 PF0900_IRQ_SW2_IL | PF0900_IRQ_SW3_IL | PF0900_IRQ_SW4_IL |
+				 PF0900_IRQ_SW5_IL, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_UV_MSK, PF0900_IRQ_SW1_UV |
+				 PF0900_IRQ_SW2_UV | PF0900_IRQ_SW3_UV | PF0900_IRQ_SW4_UV |
+				 PF0900_IRQ_SW5_UV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_SW_OV_MSK, PF0900_IRQ_SW1_OV |
+				 PF0900_IRQ_SW2_OV | PF0900_IRQ_SW3_OV | PF0900_IRQ_SW4_OV |
+				 PF0900_IRQ_SW5_OV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_ILIM_MSK, PF0900_IRQ_LDO1_IL |
+				 PF0900_IRQ_LDO2_IL | PF0900_IRQ_LDO3_IL, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_UV_MSK, PF0900_IRQ_LDO1_UV |
+				 PF0900_IRQ_LDO2_UV | PF0900_IRQ_LDO3_UV | PF0900_IRQ_VAON_UV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	ret = regmap_update_bits(pf0900->regmap, PF0900_REG_LDO_OV_MSK, PF0900_IRQ_LDO1_OV |
+				 PF0900_IRQ_LDO2_OV | PF0900_IRQ_LDO3_OV | PF0900_IRQ_VAON_OV, 0);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret, "Unmask irq error\n");
+
+	return 0;
+}
+
+static struct pf0900_drvdata pf0900_drvdata = {
+	.desc = pf0900_regulators,
+	.rcnt = ARRAY_SIZE(pf0900_regulators),
+};
+
+static const struct of_device_id pf0900_of_match[] = {
+	{ .compatible = "nxp,pf0900", .data = &pf0900_drvdata},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, pf0900_of_match);
+
+static struct i2c_driver pf0900_i2c_driver = {
+	.driver = {
+		.name = "nxp-pf0900",
+		.of_match_table = pf0900_of_match,
+	},
+	.probe = pf0900_i2c_probe,
+};
+
+module_i2c_driver(pf0900_i2c_driver);
+
+MODULE_AUTHOR("Joy Zou <joy.zou@nxp.com>");
+MODULE_DESCRIPTION("NXP PF0900 Power Management IC driver");
+MODULE_LICENSE("GPL");

-- 
2.37.1


