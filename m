Return-Path: <linux-kernel+bounces-752705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741CB179E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9107417EF36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C349280CC1;
	Thu, 31 Jul 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCGBcPdV"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013063.outbound.protection.outlook.com [52.101.83.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602728935F;
	Thu, 31 Jul 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004030; cv=fail; b=S1swRFrYyBn2Bq4YcajePwAFX4Khqg+Jih0L8lmL25YLDwZM6bgOB6fns0otOuJNt0D7qdLs263WG86jtUlAtAxzZDND/zdu377E6La9Mu/9qvMn78AWq5MOc899FjTt1CrHldavn78UzivYjZeenayvT6WpwOC/OZE9qYmKCV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004030; c=relaxed/simple;
	bh=CYrQ5eWqmxEQ6SJvEBufztIGYDsf18Qnla8sFCeT0G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HfmaUASEKx4F2JXBTwnvigA534PhpIOmpWRwX02LOOf89KZe+GP5AvFtEaS/Uav0AUkxsqIDQWtCFB4EEXvThfgd7wJ2W7ALDP+h8E2mZvnhlnAAsNaR6cevvlws9/gEowL8evKKiSigQnwXvwp6+3rXtHSf0vyd2MZMu+Bq2ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCGBcPdV; arc=fail smtp.client-ip=52.101.83.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3Ud81Rc1xLqtHjyhY8S137oopOiM/94nJvnnPoOcYqGI0rWIA53/0+Y6OCvZ/CXgV0qUs9zOLCZ3Dsvzfp6Bp5a7ERmEDnFqQh09Ee+s6FNFXhI1k8F2wWKdK12jMYxd3GrH7huAZb+ABGQfEMcVnZCYuVh6wYjQ1RohbPJv5bkTXQNi7MsudcgbNq14xIB1zFFZMHbmjuB3dJIaoHH+bxbxv7E78Zdq4IyMu0x0lsvT+Lo+21pnrRqWTE8DSSVymseAAd+wVlC1v3bg6G4iMxyHabrzaNJxNHhwLtkJRrjx+sd3Ic2nXPf/9jGNk4jlg7zDr55biSlFZQANefvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtotfDLsSBzumBRFpWCEuAA0vZAhS8c3rkK3UyT78T8=;
 b=ZwF03nyCwqDY9HB5pIM/hAKd8Oz3GJWGhx4v8eKGcaBQdHkhyhGmYt3EVUWlg9xYV/4rlLSY1VF7w3cDQe81vFmfqgiOV9Cb5hT76DFQANJJA4CAbx/U8P8KRTapt7sxljKPJqbjZsWi4r3AllG9S/cUwmWKkECTUI/3y3icSuFeOQtdRx1UPilKNlbSdpWly77HOXb+sojQUE0xIL/JiXqto/cHyKGbGWd29jSHOXkh254xXSxmk6LZqeGyYC2PGslnI8B24ybQ3QcXLVfh7J1L0GXELJX6G0Gu+tPl5Eu4i/OKwxw3lwHO3bFru5/ObSFp5Z568Sy5sFXgYShLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtotfDLsSBzumBRFpWCEuAA0vZAhS8c3rkK3UyT78T8=;
 b=iCGBcPdV79QlREO/L1mjc6fMRqXhIupAHJDIhsNVVB5Y4YI9HwydRD3FNk33vL8M+DRLO03nC/b27xOejA3ONhsqGZCPffyihkUNhc8WNXE8yIEfu5aYPmA9WfqYdn4Cqu6TDIM4diPz3mf4p/wSxEYxtKnoPGP5jUGEnG6rcULG2GxUFyjPdmdVhAFZi8cjPg/QBDAv4hYOyUBQMzQC34d2rtvgOa9bKrpyQsrppg3tjBurwpJDBkTTU5gfetxpeYuVjsMzXpLgV5qMBoqFbyenbecZRHQ1cKevf+ljEsDl05PeVWmNNPTxtgw3qjWeoiig1vQ9vxZ7FZ8OZ4Z60w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8131.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Thu, 31 Jul
 2025 23:20:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 23:20:24 +0000
Date: Thu, 31 Jul 2025 19:20:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mbrugger@suse.com, chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [PATCH 1/8] arm64: dts: s32g2: Add the STM description
Message-ID: <aIv6L30mf5bzUqup@lizhi-Precision-Tower-5810>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-2-daniel.lezcano@linaro.org>
 <aIp+XTCSpNGee2qx@lizhi-Precision-Tower-5810>
 <5be6d858-01e1-4c2d-bd5c-0e3385251af7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5be6d858-01e1-4c2d-bd5c-0e3385251af7@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e74b517-b6c9-4af6-af1f-08ddd088d39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|19092799006|1800799024|366016|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em03ZysxakIxNnV6OEhUQm5uSWpPTDVLcENjRWhqaDFIV1NpSnluSTlBbG1p?=
 =?utf-8?B?b0cvbko3c0FBVGJFem03TlNXQlNSeDJpRmZkSGliV2hDanZTUlJHTDVDR3hD?=
 =?utf-8?B?SmdOQlpNczIzUS92UUE0bDlISkNYc0YyTDRWRzQ1bUNjSG5LeHJUeFdmeU1T?=
 =?utf-8?B?dGt2Snc5OXNmMWxJTk9EQkJZek1QWjFKdnhXNjJDRlRWbWh5azRFcUtZcDFQ?=
 =?utf-8?B?bnVyQzNxOE1xWUJncXlYcExlS0QxSjlPcC84eFpkRVNwRFN5d2Nqdks4aTd5?=
 =?utf-8?B?OXV2VjhoWktVT1MySENOWE1OT1R2aHBvUHhQYWFPbVFDcFlXQ0c4bS8wUUtz?=
 =?utf-8?B?NUZCZTFsTGxwUDR5Q3FkRTFuVE94NGRSU05VL0JmUzhYWVowcmdJREVUaXFH?=
 =?utf-8?B?S2Fzck5ZNjFNNnYzWnV4cU1PQmdEcUxGWG9aekhDSDBIS2dUVDgxSWZqMzVN?=
 =?utf-8?B?eVlUVStiMXJtVHdNL2dSOVRjeHhDT2cxcGVCaHllV1VmMG02a0hkYW9vZlJq?=
 =?utf-8?B?QWRYbjdTVms4ZkVsZm5qUE5uNTYxM21zRGZBVWdLWlJKNWdGTC9YTm9LMExM?=
 =?utf-8?B?SDEvTGhZd0s5cUlWK3RNVW84bW9wbVB5eEErZ1lQRGNrR1F1SWxJZkdUdkRQ?=
 =?utf-8?B?OUplUkdPVXJib21CVitpNWhFRVNJNGJNVCs3NWUxWXlVZGtxKzdjaFFhcjlE?=
 =?utf-8?B?YlBzVktOdHNEcytxZXFicFUvR3ExNlcyM3lyZ29IcSsxZGgrZ2RYVWQwRkNW?=
 =?utf-8?B?QXdVT2lEbEV3NExGNFhGQk9ZR0Z0OGdXTExaaWxWTUdiYXU2OFZuNi9ZNml3?=
 =?utf-8?B?a2dUeUNjWmFwVWY2MDljN0poZ2tvTitKSWlRZlV0R0EwYzh1blF5eEZ6OGE0?=
 =?utf-8?B?cUUzNVhWRmxkemxVVHA5OVBpWWY0cTJnODM4c1hTTnlDaU11M3cxWENHRHVF?=
 =?utf-8?B?OVpFc2QvcEs3MHZHRGpmazlwMHlwbEMvZ09LaEliWklOTERLcTVYNlAvdUxY?=
 =?utf-8?B?QTdKdFJvWEYwR2IvUHg3Mkl3RVdOS1UwQTEwS293LzIzZlBHckYyZGhkbXl6?=
 =?utf-8?B?UHpXTFJ5VE05ZUpwaWpSRmJJUHY3ZVo0ZytEaDlFWG1JQ1lhbktWRUx1WUNU?=
 =?utf-8?B?eW92R2JGOEN0MmRORGY4VVZMeHRCSmRoKzcwN0EzTTllT1ZQS1JwKzIxeERs?=
 =?utf-8?B?bmtxMTdoeXc0WEk3NCt6T0xtU0drZHg4RmFEaWQxNERobXNnUFJSVWRrR1lh?=
 =?utf-8?B?KzVacDFaUDl4M3Z6VnZkcnh6eVdva0xaRlJFNW9ad1pQc2Mwb1phamN2NzVl?=
 =?utf-8?B?QTFIWjBnR0t2TTZ1YitLekQ2L2swaEFBN1FOREU2OWV0cE0vc01haWRNVGE0?=
 =?utf-8?B?NDg1VEFEU1NlZkJLTmxMSUFPZTJQZUt5QTh6MC9HMkFyR0NRQ2NCOW1iQTB4?=
 =?utf-8?B?ZzBrazNrVFR1ZU15ZE5TV1pwaGRnRCtRL3RCSjBsSFBGUDZET0hqQmhBRmlC?=
 =?utf-8?B?QUlsa0o1c2lPUSsyb2lxSTRpdVBnT1VKbWNGMEdOS1UzejJMODBMMDc1RUtl?=
 =?utf-8?B?NE0vajV6Tlc1b0V1U0g0Z3h1TXFSNHdoR1EyWHdmZTVhWEJPdWdnY1J1cXRv?=
 =?utf-8?B?ekkyNTZFNmZvN2lMQ0tVS2JZVnVkT1orcWs4WUdVWnYyODJ6czhvTENUV3ZQ?=
 =?utf-8?B?MGttd09KTVBpT2hwNHJ0d3RPUm82M3JjT2U5QXBMSDIrd3FKNDkrdXF4V1J6?=
 =?utf-8?B?MDIvMmQzejREb3Z1NThtU3BUU0ZyblN0UWlSWFVSNUo5YVZTd3I3WTBJQmw1?=
 =?utf-8?B?UGlQY0dJSWxIZUpXdllScUFHM1Q1TW5jdC9aQkpESlU2aTljQ0Y2ZnZoLzNS?=
 =?utf-8?B?T2lEbWVxZ3Fvb0hsUThzSGQzWTErUS8zOTdFT0duaUxJV0g2NlEvbm0xTGxr?=
 =?utf-8?Q?TuLYdQDkXFo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(19092799006)(1800799024)(366016)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YndCRHV1eURuWnZoLzRZTGlsNGI3MnFzQzJRM2s4Yy94N01uMDJsaHBpTnBX?=
 =?utf-8?B?L05TbG50QVB0QXJXdUZlaW5JbDhnZGFoaW0vbmlPQlFLa3M0NzE1NHZSRGpE?=
 =?utf-8?B?VmVHbE9vMDRtYTl1djlQbGRrdVBXbm1IUmJ3dFpaTTJXRXdtLzY5NTUxc1Z0?=
 =?utf-8?B?WVdjeGl6NzRUM05KZ2YzR1ZmNzNHYU5EVGorSXo3VWlKa1dWZzJrTjJHaUhx?=
 =?utf-8?B?Q3E3SlRBRWR4cG5PNk9kQklyWTlPcVlWMmg3QnR0RWdGYWUydHFZU3NOK3ph?=
 =?utf-8?B?Y2ZWSnJybk1zNGs2QXNnQ3J6SHhQSGhzK21jRXBZdk9DRmpvR1hKcTVCTktX?=
 =?utf-8?B?NnNUb0Q0VmpHYWVWVHE4aGErS2VaOFpzdHBHbmppaTZzMHNZZEhLNnBuRWs5?=
 =?utf-8?B?NFRvZTV3YzhhUUJjbnNlWHoyaEI1RnhvUVhTSHl0OXFCUDU1Mm9DWnlzNXI2?=
 =?utf-8?B?QWVTMHY4SFZOSWZXNHVBOXRtYmQvV01nYmpFNDB6QStOa2ZVd3VpR3lhektG?=
 =?utf-8?B?MmhGWHA1b3IxaVNFRjhLTmtTTkpQc0ZIZ2dxL0prbEMwMVB6WmpVTmlJUzUr?=
 =?utf-8?B?QkhoSHpKajk5Q3JBclMvK1BlQndXQ1VvaFlHTUl1Z1dGUjI2WTBLMm9wTW9B?=
 =?utf-8?B?V3ZLQTBFUVlQQWxLMFNiNnBLWkNTcjdHbHZTU1FzdE1HRTY4NEx3OTlGb25k?=
 =?utf-8?B?M2NTY3BBK0hrNVpRbVJpSGxQdm5mNGJueWYxVVdEY0ZtbmkyNDVnTU9lZkRp?=
 =?utf-8?B?YXpFNm0vWlkzc2Z4L212MzJNcFZwVzcwWFBadnZSTnQrQW9sYXF1OHExYkdE?=
 =?utf-8?B?aGszMUV6YWpFSEhDdlpUNzYycGlqL1JJYlNhVnk4bWk4OUN2WklObjdpMzdw?=
 =?utf-8?B?Z3BWeEVjL2xUMFl0aFpTQ0Z6Rzc0V0hCY2dJbWU2T0xvclBRNlBWZUZBdmF5?=
 =?utf-8?B?ZnpGZHd4Y21CalVJWUZ2Uk9zRXVHZ2lrQnMrSVE0TmUybFNCaEVOcUxlNGRv?=
 =?utf-8?B?dndYdG1JUUpSNXNyUTh6Q3BFVWxFU2RWNlVCMDRxMHcxK2hiTjNFaHArdDhU?=
 =?utf-8?B?dUtpSTJEWmJEamc4azZkZE5qeGVrSDF1V1JxR1NQUjFLRlVRTjhZdFRFeWZB?=
 =?utf-8?B?aWdnQWI0cmRtSGliVG1reC9SOGc1ZmZ4V0FMKy9OVFA0bXVDNUtodmU1dkZI?=
 =?utf-8?B?QUhuYnBKL1pVVFJ1N1RaMnczTW02Ym9ZM21obzdFR0FmbDFFRkJrQW0zMlNo?=
 =?utf-8?B?QVVEVm5WZUd3RlA2OXM2UzhlREg5SWtpTURzSmZ3WDFRQTRpcXRhWkNCYytp?=
 =?utf-8?B?VDlLSXVReWViOXJLdElldTZTOVlaTFNXa3dVR245TGJLNFRwTVZqa2JCQ2xC?=
 =?utf-8?B?RDZiWUJCTjlhSDcwMG5jb0JhSWU1Nkg1OGtuOThBVlZ6Y0thVVU1RGNBeW1Y?=
 =?utf-8?B?TXZVYmVSOExRQy9MdHZKb01PV2ZGMm5QOHVJVnFCOUkvZ1NVYW9XSlVYbVRu?=
 =?utf-8?B?TE9zUnRlblBha2xsNTVzVXlYc3VwT2cwL3diK1dhbjhLaE8vYmhxUkRZL1J6?=
 =?utf-8?B?bFU3T0xhbWx6aVdiZ3dzVVRJUFV1dVVPU1BrUEpyUjF1emdZcVNkTElDV0pR?=
 =?utf-8?B?Q1FuMG1sY05tYStod0NleU5DWTB0MFZTWDFBby9PV25zVkpOZG4vUTUyYzI0?=
 =?utf-8?B?OTAwcUhGVXRFZ2xFbUhESTZxb1VGMzVjUDg4NnhYblFhSGZxeWFVSitYRWRQ?=
 =?utf-8?B?eG0yZTVJdWs0cnhPdjFHckp0ZmJ1TUwzV28xcFZlZGtUbTlaTTErSktSSjl6?=
 =?utf-8?B?SlJCcWhZTlREaEZWSGt2Z2lYOEl5OGxCOXRrbVR1d1R5MUhrT0QzQ2NTMVZm?=
 =?utf-8?B?SjEwS3prZ2RpaHlEbkF1Y2h1VUJwckZKNm03UmxGdUVWdS9rNE5mRnNOTmRl?=
 =?utf-8?B?MThnc0RwSldHUGd4blhGelp3MjNFd0JTbGIrME4wL3RaVDRyVFoySmdmSkZJ?=
 =?utf-8?B?WUU1MjhOTUV4ZFlscHBMZDlSRWdncHRoSTZ3Y1pxUmdmVk8wK0NJUiszblBY?=
 =?utf-8?B?M0JsVUtqUEZHMU9oUDhKK2pZM3NDSEtaK0RWbEU1Tm1XbTdVSkxWZGVrLzgy?=
 =?utf-8?Q?0zeQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74b517-b6c9-4af6-af1f-08ddd088d39d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 23:20:24.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkfiO2KjSVZrL7UStruOUvyfsJSADk6iV6WixlMbqEwtZpiO5EPOzcTekJYn4JxBrWThSyqO5UqAPqOptNPokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8131

On Wed, Jul 30, 2025 at 11:15:40PM +0200, Daniel Lezcano wrote:
>
> Hi Frank,
>
> thanks for the reviews,
>
> On 30/07/2025 22:19, Frank Li wrote:
> > On Wed, Jul 30, 2025 at 09:50:14PM +0200, Daniel Lezcano wrote:
> >
> > I think replace all 'description' with 'node' is easy to read.
>
> Sure
>
> > > The s32g2 has a STM module containing 8 timers. Each timer has a
> > > dedicated interrupt and share the same clock.
> > >
> > > Add the timers STM0->STM6 description for the s32g2 SoC. The STM7 is
> > > not added because it is slightly different and needs an extra property
> > > which will be added later when supported by the driver.
> > >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > > Cc: Thomas Fossati <thomas.fossati@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/freescale/s32g2.dtsi | 63 ++++++++++++++++++++++++
> > >   1 file changed, 63 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > > index ea1456d361a3..3e775d030e37 100644
> > > --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> > > @@ -503,5 +503,68 @@ gic: interrupt-controller@50800000 {
> > >   			interrupt-controller;
> > >   			#interrupt-cells = <3>;
> > >   		};
> > > +
> > > +		stm0: timer@4011c000 {
> >
> > keep order according to address.
> >
> > 4011c000 should less than 50800000.
>
> Ah, sure. I'll fix that.
>
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x4011c000 0x3000>;
> > > +			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			status = "disabled";
> >
> > why not default enable.
>
> The S32G2 and S32G3 can have different variants with 2, 4, 8 Cortex-A53 and
> 3 or 4 Cortex-M7. We enable the same number of CPUs present on the system.
>
> AFAIU:
> 	S32G233A : 2 x Cortex-A53
> 	S32G274A : 4 x Cortex-A53
>
> 	S32G399A : 8 x Cortex-A53
> 	S32G379A : 4 x Cortex-A53
>
> Otherwise we would have to do the opposite, that is disable the unused ones
> in the s32g274a-rdb2.dts, s32g399a-rdb3.dts and other dts which include the
> s32g2.dtsi and s32g3.dtsi.
>

That's fine by default disabled. but what's impact if it is enable but no
one use it?

Frank

>
> > > +		};
> > > +
> > > +		stm1: timer@40120000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x40120000 0x3000>;
> > > +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		stm2: timer@40124000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x40124000 0x3000>;
> > > +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		stm3: timer@40128000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x40128000 0x3000>;
> > > +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		stm4: timer@4021c000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x4021c000 0x3000>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		stm5: timer@40220000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x40220000 0x3000>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > > +			status = "disabled";
> > > +		};
> > > +
> > > +		stm6: timer@40224000 {
> > > +			compatible = "nxp,s32g2-stm";
> > > +			reg = <0x40224000 0x3000>;
> > > +			clocks = <&clks 0x3b>, <&clks 0x3c>, <&clks 0x3c>;
> > > +			clock-names = "counter", "module", "register";
> > > +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > > +			status = "disabled";
> > > +		};
> > >   	};
> > >   };
> > > --
> > > 2.43.0
> > >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

