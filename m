Return-Path: <linux-kernel+bounces-854675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC5CBDF14D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099B919C4EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E527B4EE;
	Wed, 15 Oct 2025 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Xm14qIj6"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447A817DFE7;
	Wed, 15 Oct 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538759; cv=fail; b=KyBQtuhxyhBgvkPhtCB9pW3gqbx4uEWUtIYoiLGxTaTZMd1zP4HRNfYJ6R+HGz4izXfpCeaoZZH27VPACZDaYKHMOh2nRaX16OB2KrHCdXRPnqMUnwjNPv4ojGND72cDK1yfNq/aeaGtb4iS9+tw6RIF4PrMe5f0iuTcvYYi8nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538759; c=relaxed/simple;
	bh=F7Ep2+EhvuHfANiN6sHBAgSxUxCEA9p9ak6iGdugzNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUhQKt9E3hWXZx0klf0qkLjLHSlQC+noVhwB1EWynrUb/Nt/PnIzgJkESLqOIXjaYIMzI9sZwfl/NUjFr7V8bTpzZ7zpajUrylx3IHpk3BPUdu0qJr8Asu+eCjHGb+bzPJw2AYhd7qjf+LzI8p/6Dl6FmXdbWAs8WKFAhWe9IbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Xm14qIj6; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwGjJKOrF4wSLKOOD+DLWb1FMHCcHKnoj+YtKvydvPNRBnd5FAaDGwNq3X3uKc+BeW+29wPgiKKyPJw7hgf+TB2KjeKdti1xzPj8ixgLnsVSmwOLnI1rkeHrQUKNmB0IyVAnUQReYPxg8viNVnFzQEaQs8H6WHnQKlvr9htDwtN2giiPbafoWRU7tSPZNxkSgtHsDrPX5rf3T6nrTOKD77RLI9fjuAVSWTfDkBUnJFV1wdCMCLwz+eCijit+LNf4YxTxcHElJ2ogcofUDUXRkL8jJpEcUfJ9//eWu1UpSaBVMfy0LSza981k6Rf+T43kLzamHfRQo/h1/hM6obBbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0ePBLBbjLy+uCt0Tc4Axavwd1Tc0eNB+6T2liF8URo=;
 b=VEm3pt/tsH0zxnI7AIqBniDXK3cNDLaUNI7ysDEqF+WlUnvuNV7a+Zw4OfMkEJ45TgWeqlddofHwHmrZBPIrlhvNUGah+vdhw1EMBXlLIPVcHcZidGxi4hZShJ/+09tyMCucLrperCRsxDiWpwLQHo3jhZ4hQ4Ph+oflxnI8aYJL3BA+oFtgv9cu/68pF6F3fTWrweQAph/f2BOXYv5zMOamzd/NI1U0OYGrpgBsRsw5gJkXuJWbzdjf9TPn1zJvEexyO1sxmdBzFPE5+IWvnCVGuMG7epigNpa3kwKFonfU35lRqjcHtMkP6bRBw+BD2IW9YHxrcEJ7piKuWay3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0ePBLBbjLy+uCt0Tc4Axavwd1Tc0eNB+6T2liF8URo=;
 b=Xm14qIj6qE0rSydWIxGBO21BTUZmgKcJKSXeFTnloX3IA279EAoyMijq1/+26T0xyMEwPmnaKocCsAVLm2LQlx/Z5dx0vE3PjK825epgqlhH6SD6cOs/b847IRjcSfXmCUOlRQH+1lXh7oOiS4VdOhUyvy7wfPfcPDHvcxlCVoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 14:32:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 14:32:34 +0000
Message-ID: <9772ae76-7a92-4d45-b4f8-d1bb07dbb886@cherry.de>
Date: Wed, 15 Oct 2025 16:32:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: add RK3588 DP carrier from
 Theobroma Systems
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 damon.ding@rock-chips.com, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20251009225050.88192-1-heiko@sntech.de>
 <20251009225050.88192-3-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251009225050.88192-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 5950e1a6-217c-4c35-f4c4-08de0bf7adb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WitMSFVlYnRCSUF5LzArK21BQUpYSmxNZzQ3akllRUJmV1pSSHdWQm9LbC96?=
 =?utf-8?B?VjNRUytDVFYzZ096RmRuTm9Tc0pKZW5Uc2JxOWJtb1RjZXNRY2NTY1J0ajgy?=
 =?utf-8?B?cGc5cWJPbWlGUG5RT05EdjJwbmxOcHVrMVp4Q0s3S1RvQktQTjJxYUdVY0tH?=
 =?utf-8?B?YzB4cEtzeExJcGRlZVpCeUZKY2dXRkx2NmNvTFArR1NWSGpPN0lnaVVoRDli?=
 =?utf-8?B?SjdRTFBGVWI5VHZ0dGFLemJ0UmdaeG42eTVNcS8wUjRCeEVaSUZZSWxTbjVB?=
 =?utf-8?B?aWZaTzU1MVlraFRGR3BEMFRWeHFPb1BjVTlmNmRFV0l0UDdnMWxtV01LTWs2?=
 =?utf-8?B?OW91TXNBb3V2eFJLM3g5TW1MNFpLbmFWZkRoTGoyUFY4aHdac2VSbXp4ZVFl?=
 =?utf-8?B?OEEvbUFtRjZycmFTT3ZqOEg1ZEFBTGttNGtBR2M5NjY2QUt0ancrSXJFbTlo?=
 =?utf-8?B?T29JY2oybys5RnV4b1BWUTc0WDRKT0xYb094bi9DZktGajc2UlE4TTdTdkho?=
 =?utf-8?B?d3B4QjAweXJyWERxampQem5OZi8yNUZ0MlU3MlZ0RThkaDNUMGF3ZTVtdHVW?=
 =?utf-8?B?OVJuMUJ4RTlGeThzUmFWU1Rra1p5S0tqQnZVNTFYOHQwUjZ4Wm84anFkNWd3?=
 =?utf-8?B?QmYyUUprY2VVWTJoa3BKTzdZZmY2RlNuWjNWc3Vwcm9NTVlERFJmU3AwL2Y1?=
 =?utf-8?B?aDhzOE5VWUFPN2lZemZ2cHRqbFJtYTM5cEJQVlJWRWlTZDFTVnNhc04vK2s3?=
 =?utf-8?B?UDRKWVRERmZTMG10MzdnanpaUk4vbnljeDZiZ2ZjbEJUVmVRb2Jya0QxWEl5?=
 =?utf-8?B?MW9YT2FGZVlQWFBtZVgxc3QwMHVpeGI1Um8xNkt5MWsvZlp1bHAyWW0wSDk0?=
 =?utf-8?B?Vk4yMUVPVk9VNzNLRUs4TGdocGZqeDN3T1YwOVJrZEIrR1VibXVITzJBUlFw?=
 =?utf-8?B?cGZ3cjhtYStKUU9DaEt6M1JVWFErTUQ1aFVLOFhiZEpoYjNrelpFekZRRS9h?=
 =?utf-8?B?NEVvQmlQSnRMVllFTnhkOTVCN0pIbTJ5akRqM1J0aWphNWxYbUFFbkwxM0hN?=
 =?utf-8?B?WGFwUXBJUWNoeHNIM2drYmdRdDdpL3VneVVBMUVTZmJXb1pBSHQwUHFaWld2?=
 =?utf-8?B?anJGL3BWU245ZWhjVjZMR0NkdFZuUGFNa0pkTjlsVWlGdW05ODMvZDRiRTFE?=
 =?utf-8?B?UjQvY0ViMjdPK2xIdlZnZVllRUtVamQ0c24vUTVTUlk5eUkvTGZlNnlpU0Vv?=
 =?utf-8?B?eXlydXB2V2o0Z21RaXRCZ0JqKzA5VEo0U0tabTYvbXJNRG9rNVJzV0d1L0p1?=
 =?utf-8?B?WjdhTVhhbXNMeENORTB2VkJ1aDlzY2dnTE15bTdpVFVnS1FDUmxSU0JQL2Vm?=
 =?utf-8?B?azZrazlBbDk2cVNBRkNpV1ZSaUNWeWZXa3hNRUh4MXREUEI3WFlwSzJNd2hP?=
 =?utf-8?B?MmhTTWdzckRKbGFoaUpWanRIaFpTZSsvRFNGSzA2dWIvbGliQUVpZ0pKbW9Q?=
 =?utf-8?B?aVNJSDBKSTk1V3BFOTBvMHZSTmdaWXUxQXlHZWF3MTk0Z2lLSXAzK1dLQThn?=
 =?utf-8?B?ZGlVdG5CRkFwam5KcDE4SVQ5eUdOWXhtN00xM0YrU2VzSndiMjJ0eXhpbFRZ?=
 =?utf-8?B?OHl1N3E0aUpzaFhiNnlXaGxRN3RWNXdlS0Rkc25wN3gwOEx4YjVJZ0U5Wlha?=
 =?utf-8?B?S1kzaHlqQ0hQMnRPWjdscXRKN3RsQXo5d3c3Z0pSKys2U3ZValNQYngwRS9T?=
 =?utf-8?B?a3R4c1BQZG12Uy9INWlUZ2hPMHoyZkFld21lWTBiQWZMditBaWdRVDZVeTJr?=
 =?utf-8?B?c0gxZTQzWkNVQldONjlqMVJpUVlydUJCK3lKbHhsSHJNUmRYU1RGUjR5SzR6?=
 =?utf-8?B?Wmw2RzJKVUxuMzFRVitHTjM3L2hiSGNJd2wvd3NEa1BwQ2toUmlSVmpDRDhp?=
 =?utf-8?Q?XhG3AefjBTAn2C4UFJS9D6/X3M1KFoxd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjBXTmxvRjU0UVBtQjBHYjdpSG1IMGQrVWMyNG1IOWp1eWtFbUtjc2k1RVQw?=
 =?utf-8?B?akVGVTdCcE5aSUdER01VTVdCaHRqK0hoS0ZNbmg2QkR4VmpYVEg5cUN3d0Rs?=
 =?utf-8?B?YU5rSTI1Vys3VXZPRUVaVGdnUDJ5RllCTjViNFdoL3pnN0UwQ2tJUTJVQW5K?=
 =?utf-8?B?Qm5DcXNHYU1xR0hNNWwzYXF5Q0lpTTFoRGZmZ1FVRmlpQW9nNDQvQ2pFLzdO?=
 =?utf-8?B?b0UyNFdYSmg4QStEMlljRVU0SURlelk1L1ZlNkxNanNkK01OTWV3RjBhWjdO?=
 =?utf-8?B?NjhkNmU4d0hNVjMyTWhzbEhZelFHTmFDTXR4cGpUTGp1dHFDRXpUV0ZWb0NL?=
 =?utf-8?B?Ny9oNkpKenkzTGN5Yy9sNG1xeWZiYlM1ajBBbEFaVzE1dFpYYzVlbFoyS3Ey?=
 =?utf-8?B?UHpVdzZxTTVtdlpJaklTaldUbEFQdjkyM29Bb3FKMi83ZFo0ZnU5bTBmT1Ux?=
 =?utf-8?B?eER3bUJRd1JBZ0Z5QXhXT21vN1ZjRVIrcmxyZjRmZVhSZzRGVmxhRHoxeHds?=
 =?utf-8?B?dkhJdGtGQ3V1SU83cGFCQjVLMUtrazVTMjVTUVZLWFNMMUI0RXp5b0hPbEdP?=
 =?utf-8?B?OVlsMUtReHVpVjE5VjFYN1Q5a0pCVXlHS0k0czN4WU1ITjNqcGdNMkdMOGsy?=
 =?utf-8?B?U1pMYW53MWVDN2RLbGxLK2FSeG90VE5BK212SzZwblA4Y3liM05TRm9mS20x?=
 =?utf-8?B?dDVLb00xeTMvcnlBZm5BZXB3T3ZzbE5XR1IvSzUzOTBuLzI1bjFCd2s0cFdx?=
 =?utf-8?B?UVNYT1UzWE9JY3lCRTZacS9hNVZQNTZwekYyNkRLZ1JSRXMxakVPRWMzaFlE?=
 =?utf-8?B?YXdTaFFxeTcxOGJZcm5DMWlLb05CY29aMjBIZ0ZibnRsODZuYm5lWk9MMHFD?=
 =?utf-8?B?ODlMVFdmZjFreXQrRFk0c0F4VGhFKzQ0MFVOMm0wLzBLQkhUUi9DYkkzcUhi?=
 =?utf-8?B?Vk1xbmRmN1FoTGZ5SzNDM25UdnlDZ016MmtGYU9IMXE3U2RjNmYxRlZmUkRQ?=
 =?utf-8?B?bHRUbFN3V21XRXZySE1Rdjl6QWpiRUl5RDU2Z0ErWEllVmZ6MVdTOFllbmQz?=
 =?utf-8?B?TENWelhyL2twVTg1a1M4Wkx5SDNsblcybVMzcnNxNkhPakpUN2pVZTR1cXdO?=
 =?utf-8?B?MCtjNWRXUWpySDhuU1N5ZjQyTkNXVWEySFlrNHh3bWUveFRESHVvaGw2T2E0?=
 =?utf-8?B?SlVjOERUTEcwNnRodStZN283WHFZdFRtYk9ya1FVbjJTazQ4cUlZUEtlTE01?=
 =?utf-8?B?K2ZEa0MyZ05JNkVjd0N6ZzkrR3diWUN2STdqQ25CNFYrTmlvOWJGenJiVUhJ?=
 =?utf-8?B?b2hwdnZpSHg3dzF0SDA5Tyt0MmlIZmtCeitUaXQ3QU5ObDgySWpwOGpSMGxr?=
 =?utf-8?B?SG5tZ01KYTdsM2NZTUVvNzd0T05WcGV3RXRQSUhQc1hTR0lGU1pTMWF5LzFt?=
 =?utf-8?B?K1ZyUnZIaUg3a0FVaXgxZmF5MU9mT1o3bi9HbkJsR3lLa1VFMk5vc2NsOGsx?=
 =?utf-8?B?S2dGM0FhMC9DVGE1SlRBanIwSkd0N3UwTHlrbjFZNzNadHYyZ29lU1VRUkF6?=
 =?utf-8?B?M0ZrZmFuMUpWYklYRGtVbkVwdm8rbVlZcWdWak1WdmExZlhEZlhFdEdoM3dM?=
 =?utf-8?B?OWhMRjRQR2hYVmtnKzhVVDBhVm5ycVpVVTdWdmxNeGhUUkhCZm5HcTdacnJN?=
 =?utf-8?B?bFloTndSQjUwMnJ2R2R4bzVnYkcvYXQwZEdsMng0aE9HVlRGNGZsUEFnZExl?=
 =?utf-8?B?djcrMHg5OE1MdkE1djBFVEM2ZkphYlJUWVB5MGhSeWlEallXZWFZblRkc0RE?=
 =?utf-8?B?VlRzTUg5L2hZTEUxTkNCVkZSMkg1NGp3YlN3OHkwbGFLUFdHcks4bldxcE1J?=
 =?utf-8?B?TjFQbElBUEtMTEJ2S09hbWs1dDROM3pGNWpqWWZtbE5oT08wanFjZmpjbDdX?=
 =?utf-8?B?RXY2R2R3MXc5Q3RRQ3BsU2tRUDUwSEVMdk5EeVZzU3RaMTMzT0l3NzE3cjQ0?=
 =?utf-8?B?UmhHdFVmaGIyNEYvM2c4dE5qTWlVT2s0NWd4RGhRTEtEcmFkelM1Wk9DbFh4?=
 =?utf-8?B?anFMQXpzTStpc0hubHIva0t6QWh4aitncm5QbmxFWExJM0ttd1N1K1hOYUVP?=
 =?utf-8?Q?AMUAcSLYPrMrt3u2IjyWd0Lu1?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5950e1a6-217c-4c35-f4c4-08de0bf7adb7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:32:34.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAzsXiV1ka3zGN3i3yEIGpt1Cr0R6whHXanNK+4+q405wmXQGPDfmk3T4l69HGvoAN0W5BpV+oPhfL07FQumdOsLv7Gx8OBnQpskXdky5k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238

Hi Heiko,

On 10/10/25 12:50 AM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The DisplayPort carrier is a very simple baseboard only providing serial,
> ethernet and a displayport output.
> 
> But its main functionality is that it routes the Analogix eDP controller
> to this DisplayPort output, which allows to test that controller simply
> by hooking it up to a suitable monitor.
> 
> The Analogix-DP controller supports eDP 1.3 and DP 1.2, so can drive
> both eDP displays as well as full DP monitors. It does not support DP+
> so passive DP-to-HDMI adapters won't work.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Link: https://lore.kernel.org/r/20250723190904.37792-3-heiko@sntech.de

Please remove the Link trailer for v5 (if there's one) :)

I only have one remark: the device is stuck when shutting down or 
rebooting after this one line in the logs (can be shown by adding 
initcall_debug to the kernel command line)

[   21.973452] arm-smmu-v3 fc900000.iommu: shutdown

It only reboots by chance, after ~1m30s, because the watchdog is started 
before rebooting and never triggered again.

If I add:

&mmu600_pcie {
         status = "disabled";
};

then the device reboots just fine. So we either temporarily disable it 
or we try to fix the origin of the issue.

As reported to Damon today on the v2 of this series, I tested with
https://lore.kernel.org/all/20250930090920.131094-1-damon.ding@rock-chips.com/
https://lore.kernel.org/all/20250930094251.131314-1-damon.ding@rock-chips.com/ 
(patches 14-18 of the previous thread)
https://lore.kernel.org/all/20251009193028.4952-1-heiko@sntech.de/
https://lore.kernel.org/linux-rockchip/20251008133135.3745785-1-heiko@sntech.de/

and DP works as expected (minus some (I deem to be) minor issues).

Cheers,
Quentin

