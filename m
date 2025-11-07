Return-Path: <linux-kernel+bounces-891019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4375C419F2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCF4F302F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76926329376;
	Fri,  7 Nov 2025 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PIH5QHrC"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D170276058;
	Fri,  7 Nov 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548324; cv=fail; b=CEEfSm7Q5tCfdehEF5De+JzfMzZiw/YQaAed6p1RBxcYOE/3Tce84AM+6DnmJMXcuSueQS8aL4ike9umm7A9r8GVUAeTkWkDpu6kWfZajRlBVT31h/MczOk/d74ZxB9AJwK8Q+tWimbL8kGHLuTs631sIQO/OGPORyWEDRgQ5Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548324; c=relaxed/simple;
	bh=KYE583q4vmW1mcXOjTH0ZrT2IPx0TsZuwDVd9xXPz9I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tEr+3b6VhUcIqYTauPUgYsg2NdQFOB1NM+77AZ/c7KqmvXpLPR8XcY4Q5dA61tbJg/HgHKQwnED/gk1U7gEmvCqBcp+hc+eWyIXkl6NY/BiV7oUFXoUM/dUHB8heNgNDbhLpBJBuYt7urjEsvLhQipj96YmEUnW5Tj0xbsq1R7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PIH5QHrC; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doJVsVGSOr0zEaKC0bH9DgQX+4D9TGCYVg76yK/IWohIECBsPkowA89CLLdM1W9qCIWATfcyxozm1iwBmpnM1Ho6wLu8onSpMUlUzvbBsbfmFGpdufBddAqFVl6fnCQsFaGFAoGb8NuYo+z2gJe3t26Ic9kepmUHwKXhnUrab2/MYSvGPZOOrvVv87Kb1SYV9FGiyCxjEXAcugkXATJlHVBDNKfbQSzAM4tMolDrITzz+GHd+8rkvp/0H5g6A8KY9gnwdtXsUQXfIhd/ae2CyXgjCZQmKj5NSgI++hr2000LemW208C82kjeIwrfXGo9YKXXRtrksk30FhrxXFIbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UYZKkcezqYuD3WQrO4Zo8+Ug2eUZTEFTtCV/8xZtvA=;
 b=JAzPxsA1yY6/S0SNgm+rKjuyNk0jjAdDm0ADRiZohhJ+tZTM1eGqiFl2mCiBMKQ4OOiVb+yUC7Ccg8A6NnqwbO317c7oNW349GVi3C/IQQ8m5vcEVTEtvQsEEpGy0QyhZPwPsA/S1etov0GO40t6fiOexcFjta1IrWpEBK09p6UU1HAwwqH3LuupUaYS8JqC/hTYxxtMLq+O3TtFvKwLOhMbc6wQsAu4WhJeCrkMn/pT5QdKkmGq7TVb15P1xfhHIbNJiYfwKsiA4V7K949GwfbN8WBRwetIgUQYuX323iRVWatEJ5Ny6BmpV9mFTmFhXHrlImIDfKswi+MMhR0XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UYZKkcezqYuD3WQrO4Zo8+Ug2eUZTEFTtCV/8xZtvA=;
 b=PIH5QHrCQ46ffTFEJw5nLdgNxvG8V+8BYqYWrbtnhifrJW1xY4Um5w81ivjTzyOiGFxjeITxuLvc/Dx1/lZNXl69pooTzBOF59SN8C+FqXDionTJdERumFRkb6Or4r00SKiXwqvY+VqwnumsPYo/w3kU88ymNU8qcLFUlblNq9iPzCaFxIGsXMPC9MZuHvjST7sMRkxYx/VVH6zrIoxHpq42NzT8e6HC/blSS5wRhAd5niSNXgmex16/WV7OyeMiTEWNa1/VUH4srVVjeR58pXE5iSOnXVwVXxwYm+dVv0ATYw3Vn+l/d1waNMgy/sfRbWhE1jWMLKIMSOcn7gzb2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU6PR04MB11181.eurprd04.prod.outlook.com (2603:10a6:10:5c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:45:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:45:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:37 -0500
Subject: [PATCH 6/6] media: staging: media: imx6-mipi-csi2: use
 devm_platform_ioremap_resource() simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-6-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=1527;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KYE583q4vmW1mcXOjTH0ZrT2IPx0TsZuwDVd9xXPz9I=;
 b=mx8SjWYV9fp6yu1jH2dyrCWYyDfRRQUwn+YYpCkwMACVGdPANgMh+JQHrA5tgX+qEFDbV9h5H
 Ika3wkKuGxvBYzzw9e/kj/Fp3qOCw3wGIqf7TWf1sCeNgkY18U27UnB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU6PR04MB11181:EE_
X-MS-Office365-Filtering-Correlation-Id: 639fea4f-9913-4f2c-1a66-08de1e3e8d65
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWpiMGFsQU8xODMwajIzWWNROGhmMVBoOEJxdldPQnlqS0dRbE9qc2tCekJa?=
 =?utf-8?B?eEhsbVZLWEtCUktOVjZFQ3BwU3ZLZjM0VnhvNWRPcHBiaDRsL3lVaDJkcFdJ?=
 =?utf-8?B?dUNxclRseFBzbjNBbzVCSndybEs4dkRXaml3VWsvaldRR0hEdW8wbms2Q1lK?=
 =?utf-8?B?NzZCRDlDdTB2bEVkUWFtbWVoT2w4U3dyQUovOEVqaDhYUXpHYU9TMFBHZTZJ?=
 =?utf-8?B?K0FIWnpRbTZvbUEzUmJpWklwQkdsbVVYZVlzaXNJRFdKdC9YWGZxVG5xb2Yr?=
 =?utf-8?B?bUlaUXhHY25renp1UGJTVVpsRXhBQjhPam02T1VxMm0ybHJzWmN4RG5wQy9I?=
 =?utf-8?B?dzMycWkvMzZJSElXTGlYYU9tanFjdCtwQmwveGdtc3N6dUp0aFFUQjlkRFNJ?=
 =?utf-8?B?cG1PVGEvdmxBWkpuQnBiYUxRUG40WjVCY2UrNWlKV3dJK2J1d1Zydmgzd1gx?=
 =?utf-8?B?TmVxWWdubFNkRWdnNEZnUndKWTkrNjJrdHVsc0N0SUx5K0VSM01JMXpmS0tu?=
 =?utf-8?B?eUlaWWJmQ1hDUHlvUVoyR1NTNThHZVJhUTl4ci9HVnREVGxpem9ESWViaE4x?=
 =?utf-8?B?VVQvaHpPNW1OQlNBM1NuZXJ3SCtrT3RsdG53NFlTdXZEZkdVTU0wM21uNXgv?=
 =?utf-8?B?OE5YbVBuNml5NU9qN3N1NmN1ZnI4ZGs4Q0FWS25lemtCNkZ4TkpFYlpNNmxM?=
 =?utf-8?B?T09LUVlPSE9OV3k2ckVSbGNGajM5R24yQXAwM0ErK0tiaXZSVkd5aktOVzVP?=
 =?utf-8?B?SkdyaXNMSmRiek9CbzNmQnd5QzJmYlRtczVEU3Qxd2paYmlhUE1ha3hQbTJt?=
 =?utf-8?B?bitSbDh0Z005RU0rRVdLek10N3NKOXhtVXUxbnYrWjErbXJOWWhHemJoc3N4?=
 =?utf-8?B?N2MvRTNPLzBUV2s5SkdNZ3BIQVpRU1FzRTZOUlZjb0pEWlJHaGY1emR4Unda?=
 =?utf-8?B?bEhYWGRwRFZPVFFKdzVnUFIrTUJVV3B2Mlo0a3pxWlQ1eU1ucTh1b0x0Qk5v?=
 =?utf-8?B?ZW5WVHI0dGVCa0Q4SXY5MjJ4bzg2ak9NT0NQL1FVTkQ0QTdJZVVreVRHQXhv?=
 =?utf-8?B?aUtGV3N0QWUwaVFCRVEvdm50K0pKVk5zbUVjczJkaGgwL0RjY2dDb20vbmVX?=
 =?utf-8?B?K3hUbFdMMzlHWkgwMHhLZ2k1QkJDQ0dlSFNJcUhieFZSOW5kSVRZUXBMYklt?=
 =?utf-8?B?WjVhS3BsbW92QVhiUkZmemZEQXlOY2V2NUJ6MStFRnh3TU1CUTI5clZraUxs?=
 =?utf-8?B?L0hHWnRJQzBLdEFQckdFaW45Q0liMU1ha2FaQnY1QkN2MkVEY0lhS1V1VHEy?=
 =?utf-8?B?VDhXMjVRRXU3U0NzLzVHam9kU1lWZThIdmF1VTFDT0J6dUkrMDg4QTRGZ3Z2?=
 =?utf-8?B?bTNJbzBaMjZRdUx1V2Jxb1dxYzdsb2ZzOVFJSTRZeW5Ic0h2MTNKNFhacnA4?=
 =?utf-8?B?S3UrdUNubnlrVmFqMTdValhOenI3SVdqZ09ZQ3RuUkJPQVdERHd5UjlsMUFP?=
 =?utf-8?B?ME5ORVdMYzhkYVM4eXViODJHbVBMVGdWOEd5SE5KazFET3FuUlRUT29tdnJ4?=
 =?utf-8?B?ZkM1bi9NQjVMeGRpN2FrKzNud3lsbzIzSTVPU0JXT1g2K3p1ZUdFWHFNbkMw?=
 =?utf-8?B?dEZRcEhYYkVxemRpY0JTQUdPNCtZMHcwYnFsUlRDZ2dmdjdvcEtwRUNUYTZL?=
 =?utf-8?B?MWthMC8ycGJ4dVJPNE5ybDdyVzNLcktkN1BPdm1RRmJFNkRtdnRLNXB4R3A3?=
 =?utf-8?B?RStuWnRoTnVlMjZWR1pLKzRpckZza3pjRnhBZjhuWEt6cWczeEpSSDBNeDBo?=
 =?utf-8?B?ckhsWXBibjZieUcrUm51bSs1NnYra2VmaFI0RitrMEg3SmxPbVNmaUtrQjJS?=
 =?utf-8?B?OG1ZdVZXR20vdUpBb1dxcytWZ3RDUFFWaXpYUG1rMVhXb3pDQUsxNzE0VUt0?=
 =?utf-8?B?dnNJK2QzNVM5cStRNnoxTmNnSGkwS1VLRjhqdEI5Ti9ObWlTWldpUVFJdlNo?=
 =?utf-8?B?cU5EMForT0lWczI4aC9zTTBkYzErTU9PdlMzd0U0cGpZY0ZsZEEyYmZUcW1M?=
 =?utf-8?Q?C7wX7i?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZmJhdDVhYk00UDJyTzNOS2xOVTNJZXlVL29hYzdVY2x4NDhUUTk4MDgvLy96?=
 =?utf-8?B?eEVIOFVTUmY3Qk1LWXlkM0VORDBOOXVTNW02dEFZNkF6MzR1Q2RhNUpTVzhq?=
 =?utf-8?B?QlVjNFQwVW1BZy9KdnBQb2tKUG1aY0x4NmxHS0E2L29QekhJRk5CQS9NL3o0?=
 =?utf-8?B?OENWMGFBc2g5b21VQ09tamVNK2lIbGRKTktjU3RWR1BNK2pBVFBGSWRuRnA1?=
 =?utf-8?B?eG5hQjRVeWY1NUFPTW9lZ2xiTURIcVNvUkIwRnRwalJZY1pXeDBzaDE3MHVE?=
 =?utf-8?B?T1JxeS9McThVWWJINkFPY0ErVHpaSlkvVWtVVlFsYTZSS1lHbnJNbDBBR1Uw?=
 =?utf-8?B?YkFkNXNwV2kxZDV5cHFqd2tRR05YZnlYM1lNZ0x2aDFZaHl0THcreVl1eS9O?=
 =?utf-8?B?NGp6bVd4TEFiVnZoaVFlbDdSQi95bEZaK2JORkQzMEdTM3hxTVMzTjI3bkpV?=
 =?utf-8?B?eldiZTZKaVZHMnFOUjVweWNIajJIV2d3UjFSM1VweDRUdm9vNnBvUlhCZm9h?=
 =?utf-8?B?VFVUZEJiME9va3NzN0hPS3NLeUlCQWZNYStOaFlIMTNvVUhnZEcwaFVFNEtZ?=
 =?utf-8?B?MTVGMnB6SU9wb0cyZlNQS2FSdVJ3NEhGUE9obTdVcHVoTEp6TENzT2lkckxG?=
 =?utf-8?B?elpKZmZEL2F1S2JXaTYybWhjSTNpWkR2d1MrTGQ5QUhwTWp2bWpyclRGemtL?=
 =?utf-8?B?VWtrK05LRGJzU3ZKWnhMRzlsL28zcVpKWVYwSDBnWFZ3dTFaOWlTSEk3dml0?=
 =?utf-8?B?dlpCRWJ0OTJrejlDSEJlM0k3RC9WMkt3WDhXNHVwVDR4Ykt1RnhuZEN4aS9E?=
 =?utf-8?B?cFRpL2dZcHc0dm1LNWZzU0tvaGdHTzkzUVRoeXZtSFRteXRxMzRObVV0N3Bi?=
 =?utf-8?B?TjN1aWVFejhBclVQMzJhQ1NUVVNEbkNOcGZwUDd3SGZuSG5FbDMzR2tWOU1u?=
 =?utf-8?B?MnZUR2ZMUTJUVGtRQzF2SmZ0OWJHcmUycWNjM2syYVdUTWZWOHhKazVjYXFz?=
 =?utf-8?B?cjRQTEMxbGZTVURYWk9qUlA0K0VJbjI0aHNJU0c1VHBtY2d6ZXkrdVVUWmVR?=
 =?utf-8?B?UU9EaWxvclJ5RFBtbGtzZDFsd1RqZlZKT0swS1hzc2NzSkNnWFhaaUdvWlB3?=
 =?utf-8?B?amxkM3FMSTMveE01aHR6MXlaWkZSdG5uZXZYaWtVLzMvU0FtaHlia0IweFlF?=
 =?utf-8?B?KzFlY2l6SzFVcVpYUXBTbFVTNGgwQXplQUdxY01vM0JPOFJHRzFSWU1BTFBN?=
 =?utf-8?B?UUI5elBtbENsZjIxeTNnTG9KSEpxK2FBYm16SnQ0MVNVUlhFVGlDSFVBdFhJ?=
 =?utf-8?B?UzZ5WFJGYjJNajFBdU1IRDVlbG8zZ3lOdE9jREJCVE5pRWVQWk8wK2ptWlVk?=
 =?utf-8?B?MVM2Q1JVL2QwbmpudnFRQkRZWXFFOVdjYlV4OFJ4NmZ1dkE4MG9HZlhXR3ox?=
 =?utf-8?B?WWsvZStyMHB1aHJhbWxicGxveHpQUlRIZkJ1SzRlSUZ5MncwbEJsSWxlSGN0?=
 =?utf-8?B?R2g0S0RYQ2Z2MkRwMW1wdk1ySndpUnF6eVBzTG51bXp5TDJCQ3hIQ3Nrc0NO?=
 =?utf-8?B?NGxaMlZjQkVsOTM1amtSemZkYStLS3AyQ3JqbVdXbytEcmwyZ0trK1VsMFpu?=
 =?utf-8?B?dEoySXQvUDlPWjB5R2xlK1F5T2VuOEZOaGVON3grRXZFWGlMNVUvbE5wYUVt?=
 =?utf-8?B?R2RlWFBkdjVVN0hIOHY1OHQ0M3VBWDZ1alJFWUZMVCtkaXBDTGRWcHRwYVl2?=
 =?utf-8?B?VWwrYWI3K2VhdWQ1cUhxcklUdXFCYkY4UUt0MEwxNFljdFY5Z0g3TlZDcXlD?=
 =?utf-8?B?TklROGdHTjNzcU5CUVRpZXZVZHZ5UjNOam1CMk9oUldBOHBRWUwzZ20rV1FQ?=
 =?utf-8?B?WFZVYlhPZzVweDNpU1M0ZWtmSWZkT3FlN3NIa2JiNlBnWEh3ZzhWRzl2YnNY?=
 =?utf-8?B?TmVqZVU1NjNNcFNzWTVuMExMWG5ibnEyY3UrdVpDRTIrYUxOOFhyN3Q3c1Vh?=
 =?utf-8?B?ZzFmaW1QeE9vdVdLNGJEWmhwcVVyck16NFY2UWR2czYzczZ1YVAxUHNzcTlG?=
 =?utf-8?B?MVI0bDNuQ2F0RGFKVmQyb3JXR1F1MlJ4akNoc0htalZhSGhzVUtSeXRqY2Zz?=
 =?utf-8?Q?2Z6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639fea4f-9913-4f2c-1a66-08de1e3e8d65
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:45:14.9291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT3so6bqHofInHqBUoDsMobL2y1cySIUrd4l+SxQVR7U7HkFeNgXFj0J07bVQk/FeVqsY57+gkPl994rNfVpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11181

Use devm_platform_ioremap_resource() simplify code. No functional change.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add Laurent Pinchart's review tags
- return PTR_ERR(csi2->base) directly.
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 54e9491d3428686288a5bc9bb58a5a0a25aca696..3d590968483e4f70d284f8abe2e789a7f32e6728 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -711,7 +711,6 @@ static void csi2_nf_cleanup(void *data)
 static int csi2_probe(struct platform_device *pdev)
 {
 	struct csi2_dev *csi2;
-	struct resource *res;
 	int i, ret;
 
 	csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
@@ -745,15 +744,9 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		v4l2_err(&csi2->sd, "failed to get platform resources\n");
-		return -ENODEV;
-	}
-
-	csi2->base = devm_ioremap(&pdev->dev, res->start, PAGE_SIZE);
-	if (!csi2->base)
-		return -ENOMEM;
+	csi2->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(csi2->base))
+		return PTR_ERR(csi2->base);
 
 	ret = devm_mutex_init(&pdev->dev, &csi2->lock);
 	if (ret)

-- 
2.34.1


