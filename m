Return-Path: <linux-kernel+bounces-877053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CEC1D126
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCE3B4E1A24
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E21363353;
	Wed, 29 Oct 2025 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iOIzIZmv"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C035BDD2;
	Wed, 29 Oct 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767712; cv=fail; b=ZSs3yiNtHI07ER9CGcadp/ZtUdPnInM8P+CM6vELQ/MsUqDDoHWuXw9aP4v0kloKQ/ZN4fHmhDcnlkuo5cSHeuSiDidxKNT730o+4e0LIvcRjOyk+esfuFkchkPGSYujT18U0FvdGC4SlOvG4gbQmmXl6ql+zHWVwf+AdoqPIwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767712; c=relaxed/simple;
	bh=0qqRf3nkvfjk3FYwXTbY1J3U/+G7IGh6G1m9WBdBO9U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ge1KV9D7hSJkEQwge00pbVwxObH8NfQVqKsSIgpPLUoTOlosnNhKvXPvqkvAYwy29cmtTnOAJPMvrPte03irI+yYjzJW95N3YlkIuxIbJgEBsqx4bVaNhsIAn2xKWOz0TjND0DwGJjKyVsjTP2WXL3muiLX5DzrN6+FXrDLy4z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iOIzIZmv; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW+WLWa244b/BVIvEnUbZKrc3uzE+AfiMDHKuulRPvM36RlVbkzQDIEYOlSlDGi6upye3vu0oNM1LlAcLHBLHdYTzDfEFLvF1sVCILCiXKJvPz3+oJsF7FtAHuAPMk6YPa7Z51T07xjdijWd6UwJJ17tl4FLMEZaUr5/kFfEBy74iMEdWiIHmuQacNjGLH2wt6k59/ISFSRa4s03UBfuY8ZZh+KP/f6gI4bFo4unxL8slHrITqCcnI344pQv9llaXgl5JJP6MHiKf76vKvBbmf4JmfHw9S2QdpuKj0D9AIfB3zQ8YqC6nKvAqwYHHn3J08LAzl1YC9uQLk+ZFfxxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waUulGn1w8/8886GfVNFNVcvt2quyznih3VPW1/rdJw=;
 b=KgBjhHyNx/wZrCZsN8+AQNi6dAphANd9ju34rSbWrdUvG82bOfkKtDwb+JgKzGaBxWjqc+CNN0iWqNtClRnA+PCJsw1Eda21DAKmP0OFxrKAIiz1+pWYD8ddw2nv8yM38IgXMZJoZ4UtzuhM1uawe7O8QZZK4X1HIB1OoMxGCod3FwiZmMJFYr/3AF8ireHnRlNThRQmJlg61uk8RcNJWPMCxwlbbVBK4M01Ny45eHvN7mjcpO/oF8KNuoYflAs92oPKc9sHUS7kGm+IIWeKG4YkMAP38ZF+ohYq1nbM88saXnvYwaxUZx6qdzfYrNbZrVAHHDHfq67YgUkhKXPN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waUulGn1w8/8886GfVNFNVcvt2quyznih3VPW1/rdJw=;
 b=iOIzIZmvrZykF4F+M0+Vx8078ojNqNU3NwL1mEE4qpNRgOhLIPusjqkG8mv5UfYp0R5HXQ3Li5x4/ixNnvQp/oGVjJmq+Y4KTbD62akUr8wPyfSqvCHD+30xKe5hdN+QGRHJUt1VHfxxlZ2TP9ZvagR4tjpRhAuOogrAU4WuDt27hwIPbYAcVfrtp18iPwgTnD0nh2e6SwQ6JOyRIeIKBoqJw/1mfwsT5cDPfq1frf92un/cDPCP829Zy7uhbgRSPLWisYz3H8aNoYdpjmydurxq0mp4uw1xktHVZEaQVqhe/HvRyq9SAW+xtthDsmJwPLKJXI5aNNrETW72x6NpgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV4PR04MB11377.eurprd04.prod.outlook.com (2603:10a6:150:29c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:55:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 19:55:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 29 Oct 2025 15:54:41 -0400
Subject: [PATCH 05/12] arm64: dts: imx8qxp-mek: update usdhc1 clock to
 400Mhz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-8qxp_dts-v1-5-cf61b7e5fc78@nxp.com>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761767689; l=850;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0qqRf3nkvfjk3FYwXTbY1J3U/+G7IGh6G1m9WBdBO9U=;
 b=nE9FAwxj9DzBjjJUxyW8KvGztxspXUGzQxyHBER5YBN3bHKe2AprAeV6wFZXfmKeqObyrvuSg
 /01/bEO+2mWD/0CWjhvBeVt317a1ahLDcQzQ8XH2BYlm/2Brc34uYND
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV4PR04MB11377:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed0914a-a8f7-4022-4509-08de17250ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1VaDF3MFRNOVpTVm5kOHBEenhOcEx1NG83aDdSbjhwUEV0TllXZVczQVp5?=
 =?utf-8?B?NkJuNXdsT0NnL0V0eUNpN004YzNVbmVVaXlRT25NSHhaYi9ILzJtNm52UG5V?=
 =?utf-8?B?bjV0dTRCSnNiNDhqQllYK1RuVThWS0lBcDE3S0FrOUxxcG9QN3RUc285UVQ2?=
 =?utf-8?B?TmJ4M3hUVEpqTTR6cVJhVDMrbjc2N0RhcXhvYTRPZ0VvT2RTSHhNNC93YkpR?=
 =?utf-8?B?TzYwaVppQ3Npc21jNFV5aWg4UmliZ1NVMWRZZnhJQmVlTlZaeGtrajMrSXhV?=
 =?utf-8?B?cEdiNzlwN1dMNVpPRU5yMTdPZ29zU3BjR3RQWlIzYmw2VVc1VlV6emFRTGJa?=
 =?utf-8?B?VXBDTVFGbjgyQUZZTDVRUUYyZlRsMVFyc2NkRWhpRUxQUkppUTlNSWx1bkEx?=
 =?utf-8?B?TmhEUDlqSzdkY2lOeGdVM2p3L0gzYUVOTG5uS2ozYXp5RUo2dkRqU0RqbFNT?=
 =?utf-8?B?Ym13MTRUb2lWWjNoM3Vwa0VaOGNCc3p1UWZneXRRcmNqajJPc3d5VUtManVm?=
 =?utf-8?B?TTJOaWFNaUlNZys2RUlPUERyQTJoZWphSlYzRkVrbkI4Uk5FdUFNMUFIM2Rt?=
 =?utf-8?B?UmJDQnJXZldXK3B5ZFZlUnVJRmdRalZxcEZubnhEejRweWFwenRFUjBXTlVi?=
 =?utf-8?B?dkFyVk5EcGRiTGs2ejBLWktkRVZmdUVjaTlaMlIyQ295VEx1UFprdExTeGJv?=
 =?utf-8?B?Mk1Wd1VaV09waU5IZXNPc2xNaUlLTm9lNFBhcG5Ma1NNcU0wazBuYU5GblJa?=
 =?utf-8?B?Nml1bHd3TStZU1BMRHpxcS92Nm5NMnRMU2hiUGd1bWYrVDM0Q0VsT28yR3lQ?=
 =?utf-8?B?cSt1WERKbEtucitMaTlkbk9mdXdZRjFkRHp6L3lTaWsrUENEQU1tZ1lLUWU3?=
 =?utf-8?B?R3lXUTl5aEE4TWhndHpESURQYkJDQnVHM3dHQkFnZ05uaGpaVXFBNXE5V0Va?=
 =?utf-8?B?RXcxQ2t3aVhwRitHWWlPczVGcENiV0xDemFjTks3NFpDRGVnYnU0ZUNwUlI0?=
 =?utf-8?B?ZlhWSSs4UW45STRlRXVPY0tCcCtsaFNRRko4S1diUjJ5RnZWMzFnK2Y2QjBt?=
 =?utf-8?B?T3crMHBtODFoZGw2WU5PU3c0RUFJazIyMWM1KzBkdE9ObjVDc3AxYWNWb05W?=
 =?utf-8?B?M3IvR0w5c1B1THVDdnMzVVNISWRjRnREaTZjUnpVMnVyY0lERHhrblFIY0hC?=
 =?utf-8?B?d29uc2FIT2pmV24xaCtzbitKNXd2eDR4enB4QUVRaGtjcUdxbUh6S2lQT3dm?=
 =?utf-8?B?bDk0aGZYZGx4V3RXU3VKcVorbHJXUUZWMG1VU0hsRHdubUZ0U2Uwb1VrZ242?=
 =?utf-8?B?WllNNkxwNnpnQ2FNdDZMaUloOXkxM3RsQmZhaTMweE8rL1Jqeks2aTBUa09W?=
 =?utf-8?B?RXVrNEU5MnJoamhwT2ZnTGYvVFM4VjhmejFZbVkzRkxTQkJ6SytCRjRkRHg1?=
 =?utf-8?B?T2d0Q1h1c2hINEx1QUNMRzRjSjV2ZlpUTFk1WHpIMmczMFlqWm92TVp3Y2ZN?=
 =?utf-8?B?U0FhMHhXanVGUm1pb05lNE1rN0YzdWhmZmJDbVRrMTlTYUFBclVReit1UjNS?=
 =?utf-8?B?RXJoTGcxWVVsOUc0elhPNWVWaytnWEdOTG44OC8xeGozNlY4VnVTU0toTUZl?=
 =?utf-8?B?M2xsUGRTa0JzZ056akhJVVNpTy9yR1V1L2k1OGhlRVBDUUlwL0M4R01yQUY0?=
 =?utf-8?B?eGUyWWtBQzBtaWhmMERjanl2a1VwdW5kMEdBZlQxMnNkK1l4QXhpTjdRb05r?=
 =?utf-8?B?Q2ZFNHZLZ3pBQy9VMk1hTWVjRjQvNkduRlRUd2hUYWlRWWplVWZESFJKUXJB?=
 =?utf-8?B?VGV1b1c5YzhvZkRnckxXa0hFOE1LOHBQRENqZTM0RGdjNkw3OEtLWE1MWEFn?=
 =?utf-8?B?OVNXMVhyT1FaZHdpM0F2RDg1c3Z2cWFRL0RyQmVRWlNUM1VJMUc5WUhMUUcz?=
 =?utf-8?B?R2t3NFh6R1BmR2M0Y2tvejNCcTk3YUkvamJ0ZlQzRElYdjlUaWlORDFEUWc0?=
 =?utf-8?B?aXRkVkRjTXVJUnNwWW1udnRuZ2EvS1Q0d212S01VaDYwcXZwcjk5dEV4VUlz?=
 =?utf-8?Q?cJheeo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmtlQ3d5MGlYUk9IRS9zK3ozR29ZQkNINnZwOCt4TnhIZjI5RitMWXVPRGw5?=
 =?utf-8?B?QzlEVXRQVWl0WXlXRlZaMkVKUnl0SCtIUndBUWxxbjVTMTVDWnBMQjBFNVov?=
 =?utf-8?B?ZWFWQXNDUnB2aTAzQ0JndWwxSnRyZUZYYWRwK25nREdzcVNNdU45S1BKVEhS?=
 =?utf-8?B?dWlOQm9RelVLV1d4NHpPbUVxRzdBNkdzd1lYSjN1OFpjQkh2TTNTdzBHcStu?=
 =?utf-8?B?TktaVXliV1R5T1FEeC9QNWI5UmpXeHAzU2R0OXpIWXQxY1ZDRW54Nkk2ekxh?=
 =?utf-8?B?WFR2Y0pZUVRtMkFYWFlpVklZNWdaMzAvbEdLTm1rSW4rNnZiWTRHVSttQWY1?=
 =?utf-8?B?ZzRqQjBiNXl0Tm01NHFiTDBsNXJuRmpHeDF5Q0dXSWRwOGI1dmpxUHlJM2NZ?=
 =?utf-8?B?QlYzdzFxRjNSdnRaTUdSYkZadHRFZ3pYRmVKTk96elo1WU94MFdCeFcvR3Np?=
 =?utf-8?B?cjFCZmRXdHdQdXZCa3JKQUNVeFA0ZWtsU3Y0Q2s0WjViWDkrV1hpUTVaZUFG?=
 =?utf-8?B?YjlNV21Wa3hkY2xLcThXN0FxR25aS2VJa0g0WXE0ck10b0pIYjZXd01lSUNS?=
 =?utf-8?B?MVpEcHYvNVRpVzZOZ0w1djBrTytqVEljTEhrR0piY2hES3MvL3FHaFRRazY0?=
 =?utf-8?B?Q1A4M25CM1pUQlNuV1NEaHZZVjR6U1NMOHpFZVd0MXNrclFhWGI1dE1ud0tl?=
 =?utf-8?B?REUrSnNoaWc0V1Bqblk3aXpYOFhhSFpQRHpZMy9oNDBySUwyZzVkWU83RGJX?=
 =?utf-8?B?b3B3cWFzYXFsQnVmOFU4NGY0OTZiVGQ1eTc3Y1FVVE4xMFYza0xnOVV0ZXY5?=
 =?utf-8?B?elhCS2NocGl0cktJRllHNXNYaUlKMTFwTlRycHMvNkJYT0VUYWc1TEdzaXMv?=
 =?utf-8?B?cXF0Wmk4ZlJZdm9ucStGd3N5K0RDSGoyR1haUzd4M3d2SzNNZDNUZjgyemVq?=
 =?utf-8?B?WW16TjZWR0tPZ04wZ0xMbE95dmNLVzZHc2oycTNFSEo0a0FlVVpQTDdmY0gx?=
 =?utf-8?B?WVVabnZvOFNwdEkwV3V0a2UwUzM4TTlqQ01OQTVyV0dKWmRRV2Uyb0haemxO?=
 =?utf-8?B?VVJlYjRNM0hRelNFMk5VekJkckd2ZjBidS9jbE5DU1NUWTNpeGxhZ0toTmdq?=
 =?utf-8?B?c09lN0VESThQWHhsaU13QUl2cEdRWjIwMExrb3prdk01WDlIWXpQdnZmMzRF?=
 =?utf-8?B?VEJ5NlpLbU0vM3YvNWowdWl2OW5RTWpta3E5MDhXMlFvMk9iWUM0amxsNEc3?=
 =?utf-8?B?VlRLcTc4TlQ5Z3d6ZTB3ZFNqU29ZV0s4RDg3OGlvdEtpWXptMy93VXZiZGJF?=
 =?utf-8?B?VmhZWFdiT3YybzlPaWV6MVpTdG50M004SVFBa3VpZGp6c2NPUFBGQkh0OFFl?=
 =?utf-8?B?WWtWVE9tQWtZVmQ4YlB5Vjl3T1JYYkV2UGJ6bXV2dTc3N1pWdlpLVWQ4SVFT?=
 =?utf-8?B?eDB6eXFlaVFTWGJ0ZjV1OXBpWk9PQ213eEUyNFdnTHI0UEpEajVnSVFkeklm?=
 =?utf-8?B?akNaK05DU1dmY3V1RUxmaHR1c0dUdjJMRTBBQ1ppNW1sTW03ckdrOVZpOXg2?=
 =?utf-8?B?WlhMQlUyMEJnanhsN3NpbHJYWncrajNFckRlcmFKTllMcWREOEc3bEQ1RWtC?=
 =?utf-8?B?RG1WRC90VW02T3ZCbW54S2tqQlhHbHI3Q2lIRWZyVlB3cU8veU9zY1FGemt1?=
 =?utf-8?B?R28xM25VeG1Ob3plU2VSVVdRTk1yUVZobUozSjhNUy9qNm5wRGhpNUdENlVa?=
 =?utf-8?B?RkFPd2h4RHBobmxTSXpaVm9mVGZLdXYyWTM2dFJibjZIekdSRDRFdkk2bVFZ?=
 =?utf-8?B?VSs0WlNSTWt5UzJsaTk4bmRybUtYYnJwb2F1cEtISjYvWWZ2SlVTNWphcDNE?=
 =?utf-8?B?dzVUV2cwNlIzUXI4M292em1qM3Q0cUptRWtxcHZxYTZTQjNJeUxKS2J1Rlgz?=
 =?utf-8?B?RXhXL2hOVlRlRVcxeGNtdy94OFNNY21hNmczWkkyR01Dd1FVOWtscDRtREVw?=
 =?utf-8?B?YWJmMDZJaTVYa2pKdllzQkFyQVJFc3FGV2YvMUd3SkJIYjBjamoxTnJwbVdp?=
 =?utf-8?B?UkpieVprM1ZENzNNbnVrWFVZVlA3Z004VkEwMWVXTGw0dURoUzdvSHEyL0ZL?=
 =?utf-8?Q?09FqUBB2PLRuGmBKV/VucHPcy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed0914a-a8f7-4022-4509-08de17250ff3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:55:08.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtHHHq0I4kiC3EXefgGSc7iJBzsEREpH5vQUsYKCvR8BgIitk4SdVO3qdMJwhx9xWaqv1BZAeWJbb76soOdAnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11377

Update usdhc1 clock to 400Mhz to support eMMC HS400.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 617370846de73940f2d6c7ec9f8a4d119cbc17c0..80f4ab5339578b16aed3e3f2db6000f668de815a 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -729,7 +729,7 @@ map0 {
 
 &usdhc1 {
 	assigned-clocks = <&clk IMX_SC_R_SDHC_0 IMX_SC_PM_CLK_PER>;
-	assigned-clock-rates = <200000000>;
+	assigned-clock-rates = <400000000>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1>;

-- 
2.34.1


