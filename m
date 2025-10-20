Return-Path: <linux-kernel+bounces-860909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC07BF147F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19F0F4EA018
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418F2FD1AA;
	Mon, 20 Oct 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="RjTJ8khc"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021137.outbound.protection.outlook.com [52.101.70.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85550258CE1;
	Mon, 20 Oct 2025 12:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964192; cv=fail; b=dIiJEZ2hCi+i2LNrMFaPw/YQDEqNgQ1nya7MOFQ0NXIuJvnkXNKcWtegV8fmmD5PczyGLwb5e9h2EBz3SvKn0BZS1ejj2B/T9XHJV3QSjGLPMJMGBGUb+nMo7bjP1t5Kahe8X30G/NNsuy/+GgpD/RG/N3FCeCCp0waiTLyanIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964192; c=relaxed/simple;
	bh=9eCQ8MMmvJkMPiPFhelbb8gATliPkZNv5DZe6Y2P/IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I9NSZez6fMG3yRYJXa0SOJ3mP/8jGSlD/Kael014ihA6hh11ld6tu1qF4y7BBCZ366lOnnu+39tElZc9pgxBSqu6Ji7nng94LxfqxYX99gfmdhRgMAlLHC3LD2JvACLa2K8daCCCMm4qEdlby9KsMczaGeN5Ft3mNuzzxPa2H/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=RjTJ8khc; arc=fail smtp.client-ip=52.101.70.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqfjHkZxGUhAonVFqY9wCalgc65Pr0dsrXJSQP55GCe+LawMEdQlXFf2EozhO3Zu/pKNe9BZn+rsly2+9Sd9apkKza7tEA3WKB4rKaMzcF2b/Xt81SZxseQQTqhhkuHgFlRJr99knZLX7Kn+dSgOAGd845+DS55NgQi+jePchAX885ArRZVI+FaowOeLteHlQ8GOpx0mYI7VM12bgB16HKpJ59qRK8l5ZA1hzVvJL5Pq2g7yeA0k8+yJgvrTahQsgtuhoajWvufnq8lf09hNpu0GcPa0OhyZLUxN+yvr4okdmrAVxNYIB3S4J37qYSkW15sTQmXJbAtoHXNE7lpiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eCQ8MMmvJkMPiPFhelbb8gATliPkZNv5DZe6Y2P/IY=;
 b=pHjuMxmls2BOQ+v4RmFzsxSxc1Dxl4q+8q/V5EXRwQQ5mMJnBH7E4LmFUAo8+eWN2IN2znCyZn8DbtEXdp4XlxumUNwLzylDTMCffxtlfhZlvewhlmic1Fu4oJmN18Ql8ETI05l+OnrQZbPdak8PBfw8djQgsTpGqRxOPSekyqWCI+tKbsUvTwQty4ikDz3vrVa0MHc/QAdhMExMzxu9QKZFS3WMMMdXmPGLPv9yIvNa6yZwKfTB8/PTdbmWLeiR2utt/VdQjSJ6Ys1lGdgrJTuRs/XOVGZ4k5YDqNmiDs9Uy8gCArRYfjqTyGlnkUReZt8bV306D4er7Np4fJi05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eCQ8MMmvJkMPiPFhelbb8gATliPkZNv5DZe6Y2P/IY=;
 b=RjTJ8khcfHjXdatGitu2KJKd0ksCaiGE2usGdj40g5Me0GUpURfgYSHkp0N+s393SqNd6TaiCybRb0LTAdstauLF0OoFL2omEX11tpYPQ+nfycfHvVTA5Mfw+n2Rg7cKsS4O55TNsR82eFp5lB6bytGVC/z/x3W0cPpyh77BzH+baEKcXhE6+uKtw9azuvKNPj2dYSUWor2EzXDtNmSGUVYamWnB5ucq6urRwDB4wNIxJRpXAnUSPNTQDn1Oh2jLKj99j2VZC4x/tO+s5U8Tm04wWHLFiwWdOLG/GgzjOzQ9oC2jgFgqMdcEeV84YGQUkv0EbPeuneetrlpIKvV0IQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GV2PPF12ABC40E9.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:43:03 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:43:03 +0000
From: Yannic Moog <y.moog@phytec.de>
To: "shawnguo2@yeah.net" <shawnguo2@yeah.net>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>, "peng.fan@nxp.com"
	<peng.fan@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Teresa Remmet
	<t.remmet@phytec.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Add display overlays for imx8mp-phyboard-pollux
Thread-Topic: [PATCH v5 0/4] Add display overlays for imx8mp-phyboard-pollux
Thread-Index: AQHcPAooHRlNA7CjCU2PYiP3b1rzxLTK/WOAgAAIrIA=
Date: Mon, 20 Oct 2025 12:43:02 +0000
Message-ID: <54efc169e9c82b52a96707f4fa8fedfcdc9242f6.camel@phytec.de>
References:
 <20251013-imx8mp-pollux-display-overlays-v5-0-fb1df187e5a5@phytec.de>
	 <aPYnD25ljde33_tq@dragon>
In-Reply-To: <aPYnD25ljde33_tq@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GV2PPF12ABC40E9:EE_
x-ms-office365-filtering-correlation-id: 00b3931f-4b0b-42eb-0ea1-08de0fd6357f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2pHVEdDZitpREEzRUh4R1FZaHJDeVJYVFJBaHltbUhQbXZGc0ltRFBsaWdJ?=
 =?utf-8?B?cDhrUmlXc2xJNTNqUW0rS3VRd1gwMUdoTjZxNkUzc0RvdVRYSUNMN242VnNs?=
 =?utf-8?B?bHB0ekNnVElsY3Urc25WSGNCMzNoYmZtcEFvbW1mbDJmMkE4U2wwbEZRdnlh?=
 =?utf-8?B?SHBqak5UaEFNdWo4Y0tmdHo0b21MOXZrakVmWWlpemx1QVI3RzRCMi9ramxV?=
 =?utf-8?B?ZG14WHNkMjJ3VnZ0c2wrcXJLOFZkZE1GQTRBOUIxSlhpbUJjU1RlY0RnZ1ZU?=
 =?utf-8?B?QTFZNjBHY3pYQWNTZTJKaG1kam1DNS9NSE1hWHFWcGgrZEVyR042dEZFbVhC?=
 =?utf-8?B?aStUVkt4V0JxL0hGRFpSVktsV3ZML0pNTzM1M3k5TXdhMVF0R1Fza3VaRVRv?=
 =?utf-8?B?UVlNSTlHcmNOR3VnejZNZ0hvUElZc2N0cUhTQyszcG1hWEpwdEJxOUQwK3pu?=
 =?utf-8?B?aEV3ZmtHeDVaU0YxSUkyWCtiTVBVc05OdC9LV3R3b21oc0RKcUVscWRLZ1Iy?=
 =?utf-8?B?UUlwMHhtQWsrR1ZHTCtka2liQ2U1UzJTWTFLZTJnN3h6NUltU1hsN015Qjhh?=
 =?utf-8?B?aFhEcElRMkk3akVHNXEyeU9KZ1NYN29LS1ZxbUp2Nkg4aGFlNGtPWnVobisw?=
 =?utf-8?B?MDFoRk8yOVp5T1BMM3IzbFJlUncwajlXeFZnVzBLOVJGUzFBam9WRWFiNlFY?=
 =?utf-8?B?bXUwVHdUZXJmNTVDaXJ1K0paMitMZTAxSGg2U0ZKNzMrWkkrbXRlUEV2Vmhl?=
 =?utf-8?B?QSt2Z2QvMERPejNKcUozMjFDUHdEUEhueWQwZTJRN1Uvc1dGNmdJb21TazRo?=
 =?utf-8?B?TVFjbTFiSEwvTmw3NUlYVTNiQSs2RjlaSUhKZ3B0UGIvSGRiOVcvVGhHZjM2?=
 =?utf-8?B?UzNzZE00SjJ1ZzFvd1NqNnRZWldUUCs1dWl1UzNjVytRcEQ2eWJnQkhkQmhk?=
 =?utf-8?B?UnBYa29rNERVQ0hqVVM2M2k2ZHQvWkU5U2RYaHZlMlZJc2VtUGpsK0ZGQzdS?=
 =?utf-8?B?SFJ3KzZNTWQxSXIzOE9ZWU04S3hHSkdaOEFWNW5SaFlVaFh2eWFDK2cveVQ3?=
 =?utf-8?B?LzEvQXdKMlQxdWxuekpvZlgrZzFhVnJUbXFWUFYxZXhxYmVhMXNDWXNVNDEv?=
 =?utf-8?B?ditLNllxeVY0enVuUmhYY3prNU9lNnBiWEdPbjBUdHJ4bFk4ODU4aloxK2RY?=
 =?utf-8?B?T1BOaFYyQ20rOGx4WWw3bWM4VmM1RWtmbE1QbFI2ZkkrU2htTWxlcXY3RnlC?=
 =?utf-8?B?d2ZiRTFibExtM0NLRGFrOE5GMEduclFDc1NFZ2hpSUlYajhySysxRTIyamNl?=
 =?utf-8?B?OTVJZkpvVEVMNFYwV28zaTdWWXJhRjZIVnRMTEFZd3NTdGtFeEF4UktWNzhq?=
 =?utf-8?B?RVRHMVpXL1g1R1BEM2szdkY5VThPU3BITnBmQUgxZURJdHZlMDlBNWlaYzZo?=
 =?utf-8?B?SThoUkdMTkNrNnBSWUNTNkdkS1RLazdXbGVFblNJeFAySTJFdGdaS3EweVpC?=
 =?utf-8?B?ZGtKZGVoKzFkMm56SjAzQVREUWowQUdpQmdldnJmREY1Rk4vMnNEYVpod2FC?=
 =?utf-8?B?dERsSDRYVEV1QStVdUZyM3BRc3FuckMzdkxLVkFoL1N2TFR0eEFyRVI2blQ0?=
 =?utf-8?B?SzNuemhlN05WSWxUQUlhTXZOanE5OEpabEJzRWoxa3V5VGxXajl3RXNTeThi?=
 =?utf-8?B?ZlN3YkhSSzJKOVM2QW9CWjRTdkZzQ08rMko2THlNQUpZbnBVODlPRzl5anIv?=
 =?utf-8?B?OEJNdCttRm1EMFJ0MkkwTEEvQ2Q0dUdaa1dIN2MxcUR2cVRVT3d0akNycHNF?=
 =?utf-8?B?b1F0THhxbzVxeDZSc3B4Z0NYYS82Y2NZelNsVjhYMExLc2lpdnBLdzRZdC9H?=
 =?utf-8?B?cThuKzlTblBaNjVqamxEZDBKamJCZzArKzh6S1lJS0FwZHIyQ0N3eitmQ2hV?=
 =?utf-8?B?My9VSm56TVF3RG80YXprWUZjNDRBOFJIckU1bUswT3BpZDJqT0VnZThKVXNV?=
 =?utf-8?B?N1Y2bWtlQXUwWTVqNG9OMSt2Y0c5UDdvWU9FTmNWMFdmZnh2SEFHWUZmMDly?=
 =?utf-8?Q?uoPIo9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmZZdm9sR2VBZWZFUG1LczE1L2pXcnM1b3ByTVphNHdsYXlrc3R4MlNBdXFY?=
 =?utf-8?B?UG45VTNmd1pjbDFwQzV6dTdzaWlDZGV3MC90UlYreGliVE11WHZNcGd3VGdq?=
 =?utf-8?B?T1ZHNkdOTmxYaGVxYnNtQVhLTXdUZ1FIMDB3NnU5MzdReWtJcUlnOUUxaEd0?=
 =?utf-8?B?OVArdFV1aUNBVmJMb3kyMEM3Z04zWGFvRzJmb0JKN3JxdktyOXV3ZGdGVFJu?=
 =?utf-8?B?T1lLZmhMNWtTRDlSYjdUcmpIUGxKc2FOSmlEcktNWXhMS1AzeWhURW5zOEVn?=
 =?utf-8?B?R3MrZEtBR2grWmRXM1pmd2JIZDB4MG5uRlpLaHVHQ3UzZ2xNYkJLU1hLcFNQ?=
 =?utf-8?B?SUdjd2QrTlF1SDJVWFgrSVlRVDl0eHZDRVFSY09iK0U5aXkxR29IOWxELzNX?=
 =?utf-8?B?KzNiMkYyVGliOHNlMjJyM2ZlaXJnZVBLM1cxYnFzK0swWmhCcjB5a0V1WEJI?=
 =?utf-8?B?MVVxMFZKaFlLY1ZBYWpxUHFxcElwTVlHbzNiMzV2NjJtSVZ2ZEFGNDZ0Yk5O?=
 =?utf-8?B?YkIzb2M0Tzh6ZTBOS1MxY0NnK1ljQ1NyKzJVSkVqdjdrdkNFZDJGTG5kVitD?=
 =?utf-8?B?OTh3aGpKWVVIbFdySlNETk85R0psVFYyUitVa2R6TlZvY2J0MnhjUDlmV0lW?=
 =?utf-8?B?czZKeHV5UE1WTWxIc1BsNyttTnV2elozQzlueVI5TU8rdkJML3o3dlF1Yjh3?=
 =?utf-8?B?dDFjVEo2Yk9FVkw3SHk4WWNTQ1lBMkp6VTRVdmduMFlnQWV1SHhsRlNtQllT?=
 =?utf-8?B?Wi9XUlZJcURUUUFNcmlZNG94M3N0UWlvdWRsZW54OWgvQXBQTG93WXdWNkVz?=
 =?utf-8?B?RzN6cXZnRWV1R01BeC9VZmhQL2pua2IvbU9xOGlKZ0tjdUlzSnZuaXpjYURj?=
 =?utf-8?B?ajJ0WWxpSG1ZQmtIR24wQWdQbm1ad2FBYVl5bjcrdkxBemNGRlFhcEJ0ODMr?=
 =?utf-8?B?TTJrcWhZbEJqL0lVeC9OekJsSnJaYlBweW9zTjBwQ0VXb0FCY0FTSm91VzdT?=
 =?utf-8?B?R004Z2dQVHRmV3lwYUtNRU90cThYeEtuZTVncnB1SlQ0MXIyLzM4S1NFbkdh?=
 =?utf-8?B?WXBYcW1VYVlaNXRiU3hCQy9VVHdBUlJSU3J1QlZjUmhyek9zVGd1MExWZTFC?=
 =?utf-8?B?UDhwdTh3RWNQNzJNQm05MTlSc2VUbGEwL1VxVVhqdURRZTJNMVFvMjgvQndr?=
 =?utf-8?B?blM4MHdrK2hOd1RRY3VZT0cwMzM2N0NGZEM2OHdwMGpNaWZRNGwzUDM0WVJs?=
 =?utf-8?B?ZXlKUzlWSWZCdG9Iemgzaktkelk5N0sxM01lY1kvL0tPYklSRUsxakhlU291?=
 =?utf-8?B?dVF0LzREcmRmcUZtRUE1SG5kT1JQZi82V01GWmJGenpsTXFoUjlEc2tVaW50?=
 =?utf-8?B?aFlsRVBheDRZWnNXK05DQTU5Zm05ZDJFditCZ0VtamYyTlhJZ0FBb05ncHF4?=
 =?utf-8?B?U05oK0srVU95RS8wNTZoM1IySUhvb3B6Zm5aTGJlV1JQSytHNnI2aXc2Q0R5?=
 =?utf-8?B?UUpVdzJMWlB5Nit6dHQvZFpEbmtVOEo1SDhXNEhtSDdmTGlSTEFFUVV2MkRC?=
 =?utf-8?B?WDBpM1JBU2F4MzNncTVCYmVsR0ZZRkNjTjFyZTJzb2laUVArRWdiYzNUcXBG?=
 =?utf-8?B?ZVZoamRIc2RiRTJuL3pFdGg5bzJPaFZFS0c2aUxNTWFOMjg0U2dRaDd4R1NN?=
 =?utf-8?B?cVlhc0k1bGIvazdOUENoVTF6dGVWTmROUy9sWlYxYmQ5ajdIZGF2UTZ5emxu?=
 =?utf-8?B?Y1FZTmVEVXFIU3lSUUlYSnBvaDBZTFBNelFmdjk2K1A4b2I5QTdvU1RJRVRK?=
 =?utf-8?B?YlNOdlRrc2dRVUx3ekZ4TTNxREF4cFA5Wmh0aDAwam5xL3M5SWJ1THQrbDNC?=
 =?utf-8?B?aVQyQ3N5ZTFOejBPK1hMSW9GOW53N2p5cGZ5ZHZZVWlxQzlpR3NackVxcU5K?=
 =?utf-8?B?ckVOVGhqN2NZaUJHQ0JIVUU4NmhjYkhFZlVaRjV6UHFicTR0Yjk1QmRpYUpy?=
 =?utf-8?B?TlYxV3RMbWxaOUpUNys5a0RDa3Axb3BLUzhjMjdtWnUveUJyd3VTbXdFYUtN?=
 =?utf-8?B?YVExSi81S0cvdERkWWZJeG5mSVlsU1ZObmFzTzA5UnJha3ZnVFdjRmtRc1hw?=
 =?utf-8?B?ZThxV2pKc2g1cUFWU2VLcnkyZllnR2hvcWdjd3hVVGg4WS9ESFZvRCtWRXdH?=
 =?utf-8?Q?4CpO7N2mkuT1CI7bYG3aBsSobRJ64fbIE4EsRv2/bGWV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A19212791690F4FBFD7C66BE498B91C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b3931f-4b0b-42eb-0ea1-08de0fd6357f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 12:43:02.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFNMVJj4XQIL3Jzh0woaKvXKMkahwP0cWLBITxZqJRPf+6DDjzaEkqTvq3X9UxbT4UCzU/VY2kGolnK5mKGeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPF12ABC40E9

SGkgU2hhd24sDQoNCk9uIE1vbiwgMjAyNS0xMC0yMCBhdCAyMDoxMSArMDgwMCwgU2hhd24gR3Vv
IHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxMywgMjAyNSBhdCAwODoyNTowNUFNICswMjAwLCBZYW5u
aWMgTW9vZyB3cm90ZToNCj4gPiBZYW5uaWMgTW9vZyAoNCk6DQo+ID4gwqDCoMKgwqDCoCBhcm02
NDogZHRzOiBpbThtcC1waHl7Ym9hcmQsY29yZX06IHVwZGF0ZSBsaWNlbnNlDQo+ID4gwqDCoMKg
wqDCoCBhcm02NDogZHRzOiBpbXg4bXAgcG9sbHV4OiBhZGQgZGlzcGxheSBvdmVybGF5cw0KPiA+
IMKgwqDCoMKgwqAgYXJtNjQ6IGR0czogaW14OG1wIHBvbGx1eDogYWRkIGV4cGFuc2lvbiBib2Fy
ZCBvdmVybGF5DQo+ID4gwqDCoMKgwqDCoCBhcm02NDogZHRzOiBpbXg4bXAgcG9sbHV4OiBhZGQg
ZGlzcGxheXMgZm9yIGV4cGFuc2lvbiBib2FyZA0KPiA+IA0KPiA+IMKgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE1ICsr
DQo+ID4gwqAuLi4vaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1ldG1sMTAxMGczZHJhLmR0c2/CoMKg
wqDCoMKgIHzCoCA0NCArKysrKw0KPiA+IMKgLi4ubXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0x
MC1ldG1sMTAxMGczZHJhLmR0c28gfMKgIDQ1ICsrKysrDQo+ID4gwqAuLi44bXAtcGh5Ym9hcmQt
cG9sbHV4LXBlYi1hdi0xMC1waDEyODgwMHQwMDYuZHRzbyB8wqAgNDUgKysrKysNCj4gPiDCoC4u
Li9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMTk2ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgLi4uL2lteDhtcC1waHlib2FyZC1w
b2xsdXgtcGViLWF2LTEwLmR0c2/CoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArDQo+ID4gwqAu
Li4vaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1waDEyODgwMHQwMDYuZHRzb8KgwqDCoMKgwqDCoCB8
wqAgNDUgKysrKysNCj4gPiDCoC4uLi9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xs
dXgtcmRrLmR0c8KgwqAgfMKgIDUyICsrLS0tLQ0KPiA+IMKgLi4uL2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAtcGh5Y29yZS1zb20uZHRzacKgwqDCoMKgIHzCoMKgIDMgKy0NCj4gPiDCoDkgZmls
ZXMgY2hhbmdlZCwgNDExIGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiANCj4gQ2Fu
IHdlIGRvIHNvbWV0aGluZyB0byBhdm9pZCB0aGUgd2FybmluZ3M/DQoNClllcywgc29ycnkgYWJv
dXQgdGhhdDsgSSBkaWRuJ3QgZG8gcHJvcGVyIGR1ZSBkaWxpZ2VuY2Ugb24gcmV2aWV3IGNvbW1l
bnRzLg0KDQo+IA0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjEwMi4zLTE2OiBXYXJuaW5nDQo+IChyZWdfZm9y
bWF0KTogL2ZyYWdtZW50QDEvX19vdmVybGF5X18vY29kZWNAMTg6cmVnOiBwcm9wZXJ0eSBoYXMg
aW52YWxpZCBsZW5ndGggKDQgYnl0ZXMpDQo+ICgjYWRkcmVzcy1jZWxscyA9PSAyLCAjc2l6ZS1j
ZWxscyA9PSAxKQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjExNy4zLTE2OiBXYXJuaW5nDQo+IChyZWdfZm9y
bWF0KTogL2ZyYWdtZW50QDEvX19vdmVybGF5X18vZWVwcm9tQDU3OnJlZzogcHJvcGVydHkgaGFz
IGludmFsaWQgbGVuZ3RoICg0IGJ5dGVzKQ0KPiAoI2FkZHJlc3MtY2VsbHMgPT0gMiwgI3NpemUt
Y2VsbHMgPT0gMSkNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJv
YXJkLXBvbGx1eC1wZWItYXYtMTAuZHRibzogV2FybmluZyAocGNpX2RldmljZV9yZWcpOg0KPiBG
YWlsZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdGJvOiBXYXJuaW5nDQo+
IChwY2lfZGV2aWNlX2J1c19udW0pOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0K
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBl
Yi1hdi0xMC5kdGJvOiBXYXJuaW5nIChpMmNfYnVzX3JlZyk6DQo+IEZhaWxlZCBwcmVyZXF1aXNp
dGUgJ3JlZ19mb3JtYXQnDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1w
aHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0Ym86IFdhcm5pbmcgKHNwaV9idXNfcmVnKToNCj4g
RmFpbGVkIHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcNCj4gLi4vYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAuZHRzaToxMDAuMTgt
MTEzLjQ6IFdhcm5pbmcNCj4gKGF2b2lkX2RlZmF1bHRfYWRkcl9zaXplKTogL2ZyYWdtZW50QDEv
X19vdmVybGF5X18vY29kZWNAMTg6IFJlbHlpbmcgb24gZGVmYXVsdCAjYWRkcmVzcy1jZWxscw0K
PiB2YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9h
cmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjEwMC4xOC0xMTMuNDogV2FybmluZw0KPiAoYXZvaWRf
ZGVmYXVsdF9hZGRyX3NpemUpOiAvZnJhZ21lbnRAMS9fX292ZXJsYXlfXy9jb2RlY0AxODogUmVs
eWluZyBvbiBkZWZhdWx0ICNzaXplLWNlbGxzIHZhbHVlDQo+IC4uL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0c2k6MTE1LjEy
LTEyMC40OiBXYXJuaW5nDQo+IChhdm9pZF9kZWZhdWx0X2FkZHJfc2l6ZSk6IC9mcmFnbWVudEAx
L19fb3ZlcmxheV9fL2VlcHJvbUA1NzogUmVseWluZyBvbiBkZWZhdWx0ICNhZGRyZXNzLWNlbGxz
DQo+IHZhbHVlDQo+IC4uL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHli
b2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0c2k6MTE1LjEyLTEyMC40OiBXYXJuaW5nDQo+IChhdm9p
ZF9kZWZhdWx0X2FkZHJfc2l6ZSk6IC9mcmFnbWVudEAxL19fb3ZlcmxheV9fL2VlcHJvbUA1Nzog
UmVseWluZyBvbiBkZWZhdWx0ICNzaXplLWNlbGxzDQo+IHZhbHVlDQo+IC4uL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0c2k6
MTAyLjMtMTY6IFdhcm5pbmcNCj4gKHJlZ19mb3JtYXQpOiAvZnJhZ21lbnRAMS9fX292ZXJsYXlf
Xy9jb2RlY0AxODpyZWc6IHByb3BlcnR5IGhhcyBpbnZhbGlkIGxlbmd0aCAoNCBieXRlcykNCj4g
KCNhZGRyZXNzLWNlbGxzID09IDIsICNzaXplLWNlbGxzID09IDEpDQo+IC4uL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0c2k6
MTE3LjMtMTY6IFdhcm5pbmcNCj4gKHJlZ19mb3JtYXQpOiAvZnJhZ21lbnRAMS9fX292ZXJsYXlf
Xy9lZXByb21ANTc6cmVnOiBwcm9wZXJ0eSBoYXMgaW52YWxpZCBsZW5ndGggKDQgYnl0ZXMpDQo+
ICgjYWRkcmVzcy1jZWxscyA9PSAyLCAjc2l6ZS1jZWxscyA9PSAxKQ0KPiBhcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC1ldG1sMTAx
MGczZHJhLmR0Ym86IFdhcm5pbmcNCj4gKHBjaV9kZXZpY2VfcmVnKTogRmFpbGVkIHByZXJlcXVp
c2l0ZSAncmVnX2Zvcm1hdCcNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1w
LXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtZXRtbDEwMTBnM2RyYS5kdGJvOiBXYXJuaW5nDQo+
IChwY2lfZGV2aWNlX2J1c19udW0pOiBGYWlsZWQgcHJlcmVxdWlzaXRlICdyZWdfZm9ybWF0Jw0K
PiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBl
Yi1hdi0xMC1ldG1sMTAxMGczZHJhLmR0Ym86IFdhcm5pbmcNCj4gKGkyY19idXNfcmVnKTogRmFp
bGVkIHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtZXRtbDEwMTBnM2RyYS5kdGJv
OiBXYXJuaW5nDQo+IChzcGlfYnVzX3JlZyk6IEZhaWxlZCBwcmVyZXF1aXNpdGUgJ3JlZ19mb3Jt
YXQnDQo+IC4uL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1w
b2xsdXgtcGViLWF2LTEwLmR0c2k6MTAwLjE4LTExMy40OiBXYXJuaW5nDQo+IChhdm9pZF9kZWZh
dWx0X2FkZHJfc2l6ZSk6IC9mcmFnbWVudEAxL19fb3ZlcmxheV9fL2NvZGVjQDE4OiBSZWx5aW5n
IG9uIGRlZmF1bHQgI2FkZHJlc3MtY2VsbHMNCj4gdmFsdWUNCj4gLi4vYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAuZHRzaToxMDAu
MTgtMTEzLjQ6IFdhcm5pbmcNCj4gKGF2b2lkX2RlZmF1bHRfYWRkcl9zaXplKTogL2ZyYWdtZW50
QDEvX19vdmVybGF5X18vY29kZWNAMTg6IFJlbHlpbmcgb24gZGVmYXVsdCAjc2l6ZS1jZWxscyB2
YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQt
cG9sbHV4LXBlYi1hdi0xMC5kdHNpOjExNS4xMi0xMjAuNDogV2FybmluZw0KPiAoYXZvaWRfZGVm
YXVsdF9hZGRyX3NpemUpOiAvZnJhZ21lbnRAMS9fX292ZXJsYXlfXy9lZXByb21ANTc6IFJlbHlp
bmcgb24gZGVmYXVsdCAjYWRkcmVzcy1jZWxscw0KPiB2YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjEx
NS4xMi0xMjAuNDogV2FybmluZw0KPiAoYXZvaWRfZGVmYXVsdF9hZGRyX3NpemUpOiAvZnJhZ21l
bnRAMS9fX292ZXJsYXlfXy9lZXByb21ANTc6IFJlbHlpbmcgb24gZGVmYXVsdCAjc2l6ZS1jZWxs
cw0KPiB2YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjEwMi4zLTE2OiBXYXJuaW5nDQo+IChyZWdfZm9y
bWF0KTogL2ZyYWdtZW50QDEvX19vdmVybGF5X18vY29kZWNAMTg6cmVnOiBwcm9wZXJ0eSBoYXMg
aW52YWxpZCBsZW5ndGggKDQgYnl0ZXMpDQo+ICgjYWRkcmVzcy1jZWxscyA9PSAyLCAjc2l6ZS1j
ZWxscyA9PSAxKQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5
Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjExNy4zLTE2OiBXYXJuaW5nDQo+IChyZWdfZm9y
bWF0KTogL2ZyYWdtZW50QDEvX19vdmVybGF5X18vZWVwcm9tQDU3OnJlZzogcHJvcGVydHkgaGFz
IGludmFsaWQgbGVuZ3RoICg0IGJ5dGVzKQ0KPiAoI2FkZHJlc3MtY2VsbHMgPT0gMiwgI3NpemUt
Y2VsbHMgPT0gMSkNCj4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJv
YXJkLXBvbGx1eC1wZWItYXYtMTAtcGgxMjg4MDB0MDA2LmR0Ym86IFdhcm5pbmcNCj4gKHBjaV9k
ZXZpY2VfcmVnKTogRmFpbGVkIHByZXJlcXVpc2l0ZSAncmVnX2Zvcm1hdCcNCj4gYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1wZWItYXYtMTAtcGgx
Mjg4MDB0MDA2LmR0Ym86IFdhcm5pbmcNCj4gKHBjaV9kZXZpY2VfYnVzX251bSk6IEZhaWxlZCBw
cmVyZXF1aXNpdGUgJ3JlZ19mb3JtYXQnDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLXBoMTI4ODAwdDAwNi5kdGJvOiBXYXJu
aW5nDQo+IChpMmNfYnVzX3JlZyk6IEZhaWxlZCBwcmVyZXF1aXNpdGUgJ3JlZ19mb3JtYXQnDQo+
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGVi
LWF2LTEwLXBoMTI4ODAwdDAwNi5kdGJvOiBXYXJuaW5nDQo+IChzcGlfYnVzX3JlZyk6IEZhaWxl
ZCBwcmVyZXF1aXNpdGUgJ3JlZ19mb3JtYXQnDQo+IC4uL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcGViLWF2LTEwLmR0c2k6MTAwLjE4LTExMy40
OiBXYXJuaW5nDQo+IChhdm9pZF9kZWZhdWx0X2FkZHJfc2l6ZSk6IC9mcmFnbWVudEAxL19fb3Zl
cmxheV9fL2NvZGVjQDE4OiBSZWx5aW5nIG9uIGRlZmF1bHQgI2FkZHJlc3MtY2VsbHMNCj4gdmFs
dWUNCj4gLi4vYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXBoeWJvYXJkLXBv
bGx1eC1wZWItYXYtMTAuZHRzaToxMDAuMTgtMTEzLjQ6IFdhcm5pbmcNCj4gKGF2b2lkX2RlZmF1
bHRfYWRkcl9zaXplKTogL2ZyYWdtZW50QDEvX19vdmVybGF5X18vY29kZWNAMTg6IFJlbHlpbmcg
b24gZGVmYXVsdCAjc2l6ZS1jZWxscyB2YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXBlYi1hdi0xMC5kdHNpOjExNS4xMi0xMjAu
NDogV2FybmluZw0KPiAoYXZvaWRfZGVmYXVsdF9hZGRyX3NpemUpOiAvZnJhZ21lbnRAMS9fX292
ZXJsYXlfXy9lZXByb21ANTc6IFJlbHlpbmcgb24gZGVmYXVsdCAjYWRkcmVzcy1jZWxscw0KPiB2
YWx1ZQ0KPiAuLi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQt
cG9sbHV4LXBlYi1hdi0xMC5kdHNpOjExNS4xMi0xMjAuNDogV2FybmluZw0KPiAoYXZvaWRfZGVm
YXVsdF9hZGRyX3NpemUpOiAvZnJhZ21lbnRAMS9fX292ZXJsYXlfXy9lZXByb21ANTc6IFJlbHlp
bmcgb24gZGVmYXVsdCAjc2l6ZS1jZWxscw0KPiB2YWx1ZQ0KDQppMmM0IG5vZGUgaW4gcGViLWF2
LTEwLmR0c2kgZG9lcyBuZWVkIA0KI2FkZHJlc3MtY2VsbHMgYW5kICNzaXplLWNlbGxzIHNldC4N
CkknbGwgcmUtYWRkIHRoZW0gYW5kIHJlc3VibWl0Lg0KDQpZYW5uaWMNCg0KPiANCj4gU2hhd24N
Cj4gDQo=

