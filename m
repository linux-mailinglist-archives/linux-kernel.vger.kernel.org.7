Return-Path: <linux-kernel+bounces-800105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 916DBB43376
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9461BC62AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988B288C39;
	Thu,  4 Sep 2025 07:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CVHr0oVN"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012067.outbound.protection.outlook.com [52.101.126.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683431EDA02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969848; cv=fail; b=Mw88Uz2M0BFS5clP3QRwgfluG/A4zycs6QZl0UnRNIVLHKrvVeN/TlI3pmydwSVe+VOdHcgFcop0T+LP/ESRvtxqcCPVNW7hrfSlTLCnbS27wiPMmB9ZeU+rQmw7IEIvEuq+zwJc1am5ZDZL2OSI11wc2puyLERVDFkDPVSEjJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969848; c=relaxed/simple;
	bh=vx8NW84JQt2RxMzoeFEc+TVZtc93uQoz5/ITdjFNBmM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cgqJ7zLfi8HJ5lb28o6xtW5FJdFNYZQuI4QUbx0srDNxR8oIfd2ZaRvdhmsUHuC9jJhUxRpyGDSpGiOlcCpUAZMEOK06rVa+nwvSfa6tRS22hRHEeKWaEfLpfu5ZQiVbfFQUblPMAtHEZLpHi3/sswoGYhyC5uVYM+T/zwrw/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CVHr0oVN; arc=fail smtp.client-ip=52.101.126.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmRYkjEkquk7tZfplQI2Huyl1ib6umtcq0M6RvrtOcxwiBCfKGuRnUcYzkr2ozWoYA2bZxJgE8i0WDYgGer4FRO74hAiRfHf5Leujyzmlh65QxWAM+CwrzwtWoIl1iY+hgiEgQvPVx5yadbJvEKoP+Y91aknUFOAzpm83sr9oIYxhNaEG2gOTc0uC6zo0m+pXgvlfWUBkLtlLM366sC7AYb3zFcNARUu/o8Od2gge+LBphRIBwqB3wAGW+AcqpQRBW8biaSZzRlrQ1QhfmYJLLjImE2jIbqrJAVjQOY38VCEns8NgA8Ccfo7uHGWojeA3T2V1Sx7Eg8B/oiQ0E9clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvlworWhrNPPigrhMAWj+BOJkdwngyG4nz6adatOqQs=;
 b=GJx1pFfLFFEisYmvrS8E37Y3G2RToFGT2YG1LUrGuV8xyNiBWmEUxzMW6kXg+7692mKkNrUndmJ6n9rbc52jevh9LjY0ufu2p8yAprWyUOfu0dQdEmtYjzCVOZc9QhUy6XsJpUTE/MqYMHA9cmbBwikmrpiAeEKyLApSb0+K/HKCufl/mU2gXJsUmKk38knPHGZenOMafMG+SWfSTFQtYs2zrDF7IHd5udv3eT9QrzN0iK8zDC53pGkX2f5pplGBYIXvewThd6l00zMwbC1hMdgEEKUmCbki4yBdqpRU0wgiSV45FSpE2YzF6a23N2qBF/dU7gdcn9nwChXTFDJWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvlworWhrNPPigrhMAWj+BOJkdwngyG4nz6adatOqQs=;
 b=CVHr0oVNXtSePRrFoq3oZ4tW3dEHbxxTjI7IBBTSRxbHSBqJaMSnfgZyyALC3CSHbapwNA1D2FtiSkMtQrPKXbsKCHLX+JL7tzdhcsUkkz6u1r8icVlcd5Kj1Qk9Zjcu6ggIN1dqdKA3jGfQcUIUeQQPp0Z0jgSV7Z2CneRoBzBUeZJyJqEyN05QQSwRdV6w/QoSacIVCNPmolSdptmU+u5yH0COqUp8DEWC9CrQErM9IJGW6YDdvXpOwdCO2LV/W2s5A9/UN1XieNUKafzdRoXNvaWvNMPZE5+rJfL/YCbnjKoETl83d8rGuJAcLvevXjfHZY8Cco9ZpjWhkebH+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEYPR06MB5987.apcprd06.prod.outlook.com (2603:1096:101:c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 07:10:41 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 07:10:41 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Austin Zheng <austin.zheng@amd.com>,
	Jun Lei <jun.lei@amd.com>,
	Peichen Huang <PeiChen.Huang@amd.com>,
	Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Roman Li <roman.li@amd.com>,
	po-tchen <robin.chen@amd.com>,
	Anthony Koo <anthony.koo@amd.com>,
	Harold Sun <Harold.Sun@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dillon Varone <dillon.varone@amd.com>,
	Weiguang Li <wei-guang.li@amd.com>,
	Charlene Liu <Charlene.Liu@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] drm/amd/display: Remove redundant ternary operators
Date: Thu,  4 Sep 2025 15:10:15 +0800
Message-Id: <20250904071024.248230-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0144.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::20) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEYPR06MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd232b8-36de-41a6-21d9-08ddeb82281f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nUEP30L3nvYzysC8YEWD53sMyeTFFsu+Yj9oohdvNPquM++CpEc2igR50jPC?=
 =?us-ascii?Q?yXcTACQPX2cDaBbuGEl2nRrSp84wMu3NDn6u7VkMgpUt27z9YB8wPqoqQ2Zi?=
 =?us-ascii?Q?1TIS9QyGVPEb6wTqkNdCj8iPVZYKOluAwOM7zBCig2F9ou0eg3t3gL94Eofh?=
 =?us-ascii?Q?WVKqg6VDaNAfll1ztd84pRrUqVxUcF2nWx6ob4eE0uePr2QNGAv4jyr7+vX8?=
 =?us-ascii?Q?f7FKR8W5jywNjYZH3fGwv+n/grDEeCSMq01YIRZsIrtaJg5Yt2eJCQcEX8LL?=
 =?us-ascii?Q?xsfDILLUDL8LEtfGw/DTfmXhU3uU7E426od86Ny+2eU9kV+HC8eTAVsZACIG?=
 =?us-ascii?Q?d2OUqA2RQGJ4TrbtNhYiOib9SyWwslzF5jFize7q70LGseoyrXF+jr0jGEs4?=
 =?us-ascii?Q?ew9t55RFcfeJ1WKTjKsTxhQe8k3QenGYSGQaR96wcxhpcLLjHgx05UjulZfw?=
 =?us-ascii?Q?Ew0CwjhODOoOIMXY3ubzhy05lKiio/Alh6Zze2fuVhjXQMOxhdrgowQWmZ8f?=
 =?us-ascii?Q?IvYwtkY+PdnopByvCwfwPKd/4DRGRQBSZP1P6PzO8rwmfnr5E/cJOgJJ3ZnW?=
 =?us-ascii?Q?P7EuZ2C/VhHXNdbhxvZ5NsVLGlI0LkIfML7iDIbe2V3ohJklXKSYBETO5SZq?=
 =?us-ascii?Q?PtgUkMr+csJEVsxtq5rKkGE/D4DkgdEnrucPhnh5PbVjdMqySihSUkkxTgil?=
 =?us-ascii?Q?qDPzP2xw6REJh6P22Z+M2NiKpwZydr7pLFr5WbvW3VEw7/QKZhHTFGZ2U73w?=
 =?us-ascii?Q?ewsXFHVBcn9bhu8Nbrf6y/mvg7v69R77H9RJGgGeQHBOzgYbuR8Vg62i8RF5?=
 =?us-ascii?Q?AF51g4zg5Jgp67wp9fZoWXPG5JokzSTAbTC35YyVI5i8wacm/O8pN6D9ribX?=
 =?us-ascii?Q?FpuY4I6l67eqaNTvfDHmbeNQSTTYCnSfM/RgML92KVH+g2vq7tVQ1MHEKOIP?=
 =?us-ascii?Q?iwTkQsRtFRTepk4QmNHj4FZDiNcGAdLUIXMJlX+KqYzl6m3E2Lratvo06mHh?=
 =?us-ascii?Q?L0BOwRy7kmJpKXhcfP5XTNETku1Hdp4DLREBQ2ejFSjTBgxm36btStdLpg0/?=
 =?us-ascii?Q?ZtVcFgwiuJ1xe1hWmVmjeFvzIeOK05SuaVyEz2LDpXpiaTAFq3NgG70ZvKVd?=
 =?us-ascii?Q?6Cl8GxrtAAmdcyG52TmqIXvL9+W8/MAfFU7AHQtMlfxjr2T9Muj+fdglUjhl?=
 =?us-ascii?Q?3thB+5Q1S/7IKI67/rPIE9luBrhM4if5CFXH+ck/M03575oUp4LrNC0LDLjN?=
 =?us-ascii?Q?XSMADwVyV8Ut8x+VWVieJxrRTtbWk0Sm6OUP/uk7LsN5zR0wS/8y4g8bbAhS?=
 =?us-ascii?Q?KhIulrVXE4DpE6wumV43TuG0QHv+KEwm7hxLtMUOhmY7SaQneGWqECg9cBAr?=
 =?us-ascii?Q?U4x3OHWqdeHomlTH2pCXbAXnrFJHArbF4sPLyVvHqOb8tdsYeT2QW0xnONn4?=
 =?us-ascii?Q?j/fJ0HEBxxaQdZtsoJqLKvfT1auJV5EWqQoBzbEsNOWAwvpXaKgT1TGDXla1?=
 =?us-ascii?Q?v3rEQWjjXDiQ544=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaL6lE8Flb2p+AjA+fFPZAbIuc/2A0tDzmfiVl4TO+f0y9mTwzJIhttaTqz0?=
 =?us-ascii?Q?eai+WxpWd1AFmOsl+D2GlWh8n7Gzg9rHD6c4BR3v3I1GW1fx2CK/Oa768MXB?=
 =?us-ascii?Q?rTr5CS9UOmObbfV89p0BZ3KbV0P9vNOo4fsW8rz/L2BoH25vQHhmcD1/u6k8?=
 =?us-ascii?Q?k+OUcDIEONAkV1Bb63E5xsg8x8meAr+z9fBeXoLrEkamhk2gq/1nBnlB5N4S?=
 =?us-ascii?Q?KzX4DB13+swemTpB3MbwOI+QLZo7ktKdOg4ba/8Zx640k1ovl1GpFZGbieyb?=
 =?us-ascii?Q?4ofpSvJ4ttg3rtz9Def9mjT4O7g4udC8/QhwF2pNvrCbRLtHrOVSgNp53Jnf?=
 =?us-ascii?Q?hpVcqOnHHX7xs5MavCqI/NvlyyjGT77pM5fo+WbQLctEEjBzVrEFCHAALqMn?=
 =?us-ascii?Q?bZQLAo+ZmN02wtylmnVqiSKm7GgXiHnzapNCL4bv58ny5NL1BkZxCDVtuP5d?=
 =?us-ascii?Q?yhGBZ0KpA/JW3xCBkGqz9zk8X5YL9jlybdx019GtJJqtgxhvk6RQ3QFjsrse?=
 =?us-ascii?Q?VGPshsS2is4bMRTiKNaqZocMkLwqzrmLwEO4lfVGmKYr5Dy9aKHDcol5jPar?=
 =?us-ascii?Q?OT9ZxZSg/LjVe0cFmnKgbo46AJOpdrFRSm8lPxJXi8QFTwviR2gUJiFps0Rq?=
 =?us-ascii?Q?M9eye7HBAnJJINNGG1/sZdms6Q5Qq78hxEk5GCN1xTcTSoodJXE8xzkngrcs?=
 =?us-ascii?Q?5nWO+Ja5uDTAE1tHpVPCLXcZIrBLTSlNvjNMPuKj4JnBN+u46QZQXi28X4MF?=
 =?us-ascii?Q?vx2/fcv88rsdA/pNMUJ0TJwXi7DFoyvl+FhcdhrLXj4ctgB5EScQUTdb3gJS?=
 =?us-ascii?Q?ChW7mMq3OiRmVv33v7/6SfHqHJ81Te3+0CrtwfFZnjidWNzpJr0FIdcCbuAZ?=
 =?us-ascii?Q?eWS5OAhmRG5WjdYweURpaSfl7sb2BjV5qJWQ/d5D3nswA9bbRNOJgRKREJiz?=
 =?us-ascii?Q?G6j/DMDTOt+qWkChtFg1YiLXEnRPpXUKm/97tBFkIcHe+xByPVaDX50IiIlL?=
 =?us-ascii?Q?2qz0UoCOvPrxxNXRdTo1QjVPIZaJj0S3+CdlXP/mO/hND+LlUaB4qcOSWdtX?=
 =?us-ascii?Q?swZASfDZkMuJiG5rF+EsJkYbWHIoiYvnlcdw2JzczFo/sCFP0FmEcoAfdD/d?=
 =?us-ascii?Q?2NsfkYJHWAzcTO7RoiA1ld8AJsX29OMN0dLM/mUYiZ5QeNrzf6QvlLgj+BHL?=
 =?us-ascii?Q?UU2WNh9NG78a6JBIYcylAY4LmPZCQLO72OZC02OojgSAm9ZUZf5CX+FENeS5?=
 =?us-ascii?Q?hR3TwxDI2PQVPFSE3ZfOzyPqEmA5pK33ZvfRUCpOmH0Bq5csqWHecyk9PjsE?=
 =?us-ascii?Q?aJj0VYSZA6PPXhnfvF/QhrFQuQ8jI69nGv8+7ZYmAaHU6UmU6LUD283wUEH0?=
 =?us-ascii?Q?cYk+KVy1+VJPaXolcTbEPyZkmn4UC00XbqidKIK88ymhJwnFfkS+sbpJ+htk?=
 =?us-ascii?Q?f4y7YzDqwmv9hyaR53Df/AS/2WQVLHMTjwVj0pYcdu4T0tnHh+e94YU3RmjP?=
 =?us-ascii?Q?ItOQvrxOI+Y/G0q1DTQt3H6nF+v4e4t9TZoIoPtuzaVct6lyt7IqWcx0Mifj?=
 =?us-ascii?Q?gF6TXOfsziEwasVJLH1S72DU1bg456GfFs76MQ22?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd232b8-36de-41a6-21d9-08ddeb82281f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:10:40.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHRY0tPSIoQrMYVywKpKAppqZT6RIxqLev32SVXD3rU7zT8PryFIuKgttX1nUB2tNCbinK24LyvIJrXIxsLGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5987

For ternary operators in the form of "a ? true : false" or
"a ? false : true", if 'a' itself returns a boolean result, the ternary
operator can be omitted. Remove redundant ternary operators to clean up the
code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c | 2 +-
 .../drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c            | 2 +-
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c      | 3 +--
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c       | 4 ++--
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
index e0558a78b11c..1c1228116487 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_link_encoder.c
@@ -812,7 +812,7 @@ bool dcn10_link_encoder_validate_output_with_stream(
 					enc10, &stream->timing);
 	break;
 	case SIGNAL_TYPE_EDP:
-		is_valid = (stream->timing.pixel_encoding == PIXEL_ENCODING_RGB) ? true : false;
+		is_valid = stream->timing.pixel_encoding == PIXEL_ENCODING_RGB;
 	break;
 	case SIGNAL_TYPE_VIRTUAL:
 		is_valid = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index 6ab2a218b769..6f30b6cc3c76 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -397,7 +397,7 @@ static bool enc35_is_fifo_enabled(struct stream_encoder *enc)
 	uint32_t reset_val;
 
 	REG_GET(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, &reset_val);
-	return (reset_val == 0) ? false : true;
+	return reset_val != 0;
 }
 void enc35_disable_fifo(struct stream_encoder *enc)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 0318260370ed..9deb03a18ccc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -535,7 +535,7 @@ static bool dml2_validate_only(struct dc_state *context, enum dc_validate_mode v
 	if (result)
 		result = does_configuration_meet_sw_policies(dml2, &dml2->v20.scratch.cur_display_config, &dml2->v20.scratch.mode_support_info);
 
-	return (result == 1) ? true : false;
+	return result == 1;
 }
 
 static void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
index b68bcc9fca0a..892907991f91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
@@ -138,8 +138,7 @@ void setup_dio_stream_attribute(struct pipe_ctx *pipe_ctx)
 		stream_encoder->funcs->dvi_set_stream_attribute(
 				stream_encoder,
 				&stream->timing,
-				(stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK) ?
-						true : false);
+				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK);
 	else if (dc_is_lvds_signal(stream->signal))
 		stream_encoder->funcs->lvds_set_stream_attribute(
 				stream_encoder,
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 71efd2770c99..ce421bcddcb0 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -226,8 +226,8 @@ static void update_v_total_for_static_ramp(
 	unsigned int target_duration_in_us =
 			calc_duration_in_us_from_refresh_in_uhz(
 				in_out_vrr->fixed.target_refresh_in_uhz);
-	bool ramp_direction_is_up = (current_duration_in_us >
-				target_duration_in_us) ? true : false;
+	bool ramp_direction_is_up = current_duration_in_us >
+				target_duration_in_us;
 
 	/* Calculate ratio between new and current frame duration with 3 digit */
 	unsigned int frame_duration_ratio = div64_u64(1000000,
-- 
2.34.1


