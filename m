Return-Path: <linux-kernel+bounces-861782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6422BF3A84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C46E484495
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B98332EC7;
	Mon, 20 Oct 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l0U+X3cD"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88744332EBC;
	Mon, 20 Oct 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994441; cv=fail; b=bsFU0P07TWa3BmfZBXbKYBCrtVDVbvwPmoLL2KywSApn9GDn80AwrcBacqZJGt1bH3Fk7sx5aQc4TGw+Q2zyc8cHpHK8yR6RfBNch0Ycd9xfkRCekBIKLtD8N02JJkVU401UDDBu4lbGiZeNavOdR6BiN5Yys6GuISy/EUL5eXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994441; c=relaxed/simple;
	bh=58DhL3zMvqEMPhqImw9/QOA5WT5XtR9bU7IqqSV35G8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UEGE7IXUUeVbHN06jzJCSFc77z37zU5vhzdKms/K+xeEjP3psJMi3EWaMheS2UdKNfMl3IPTFtBeSeR3mylAkBPOpsM7jkfGZm2CmG9J5QbLIqC4Y2m0tUW/yx3HwzIFW8vmO6sSxpkPFZkEmajx+8mBtXiDfANVlaooh3LVf/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l0U+X3cD; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/WndVf7mmbvz74aOCzxoagwCml/s7AYDlp0vwgi5TM7g4MkNTxitPVa3bdkGCkeSHzMMOjJfSYAkNaSlSZWQAwDyJ7DcYEZaO8fgepoBOmufgxCNQuLg1b2p6DA7AHSaIyltK4Hesn6WHwRu6oVXF5fMZW+6qJQ8Pp0p2ypLqJeZvLsQMS77xOpIGYfP4TZcgChquJVDG3xTIOnv8765W4NtkjYxgl0MsT9BtKOqrZLt9sp8FwnhmYXaSrX1HONYykcsa+SKT45+Sswjzd+Ha/xINVFIMG9/sIbOe9+COwxMRyI9Psp7ZWxfAwgoC2Etf1d0mk/GdlqQOHWppsezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDWYiLUFUXJSlR/58H0Y8CTY3R1C889hCziNwBY8y/c=;
 b=n7BmIHQXzAbVJhxJ0JuFk9CaHntpcCtvkfS33+KKxY0DC6savZUos3m7Yl9awW+Ks1z8FYpSKxQHmZYjY6FYcVm0mn3uhGJ8oVaOz1ptD3/mBTECBxZter0b+ZjPBPH3KUE3HYgCHEn+u7OEuRZQ/w4RO5LCnNpfq/OzIyE5HmdL4+9lxahz1dLD/N3YY/LmQrEIwam8qikLv05lrXUqMMdPQofCbAlWFj2wE4lVF4Y+W8fMyqXtCVgZGV5EQ7tC10IMUdwvhEHaBxaxH8Hv5to3xWIhS5Io2uMXtedcwRKl7M/qKKDC0b9qK5DIjM4XI6EwyBpddk7/yVtCAZZjOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDWYiLUFUXJSlR/58H0Y8CTY3R1C889hCziNwBY8y/c=;
 b=l0U+X3cDYZ2stGOr3NGocX2OdKl87IKEzLQn6zMZDyNm0kzPbU5OCNuM4bjlkdYeeDKIFmc/UHhXwGtu80Ei+63Tz1qmdRIKPk1MWVkICJcymE/Xq9E16IQAi7gahEpcJhI+SXWxDStzt2TeKddP2MgLh35Z/suL5TNH3BsFNvIw10lTZDhGemcsK5K6S1l+Bg7bLI05v5mPdVCULmCdeRrlbsprXqgoTSrBqon5XpC6+uFK9XtNVWiDnU6NXry/E7EeIOxpXTlaDjw6TGp8vY8h+FmJrJGbYr8HArvDuPxR6g17p/OFw7ySl0JIZrPC37QOUW6zCaQJn/ulJn9GWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:07:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:07:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 20 Oct 2025 17:06:41 -0400
Subject: [PATCH v2 7/9] ARM: dts: add device_type for memory node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx6_dts_clean_2-v2-7-3c12ead5094c@nxp.com>
References: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
In-Reply-To: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994408; l=781;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=58DhL3zMvqEMPhqImw9/QOA5WT5XtR9bU7IqqSV35G8=;
 b=05WFV8O4FSXaDwEQsvedGToTPdAh4BKWy1rRDqFRyQt1ueU1AXMRyNA7wghimYtkRpyWhZti9
 8GI8uWatEovB4GWvtfFXHlq+fT37vrMNaP9TEYGtumE3NCT/BoICQG0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fbc7b6-e46c-4c71-233b-08de101ca5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNMMkEzTjJHeWIrVnM5TVlMRExUNEVFRVphQkQvTUZnSGZPekRZbW5kUFRu?=
 =?utf-8?B?UzROS2pQR3NRYmJCcUlDV2x2VzV1b0RuR2p5bllGbXZZTkFxVWF3WmNxOXd4?=
 =?utf-8?B?dEZuUXVTcUZCODZTSHdTMnJURkU2S2hDbTFJQ1hhYTN0T2UvNjhLcnVVdzJR?=
 =?utf-8?B?YXFuTFkyMzRVbzdGZ21oM1F1VU5reGl1alpUUWxHNllBUXNTTnhFSE1lMkNh?=
 =?utf-8?B?bmRHbk56YkY1eU9SZU5oS043OFNiWGFRVlZ6VFdHNmFwZ0VXQnVHNldMMUow?=
 =?utf-8?B?QjYvWldWcjZ0Y3RQakN1SFUvdTFTSnp2ZVNMemZKUVhLbWwzSC9QOFZuWldH?=
 =?utf-8?B?UHY2WXd1cEhRc2ZOeDFJWEJOWHFEUGpOWTdpRzRrSDZyQzh0ajlJZnpLRmlY?=
 =?utf-8?B?NHpKMmJtcHM2cVNzR3dFYzlZVEZ1VjBtUzlsNkdLQnVyZm9YSHZpeTM1UVda?=
 =?utf-8?B?UXJzSnRCZmNHa3FZWDJ6Y0hrZzVZNHQyVnVTd09HaDY2TFdVdFB5bmdaOHAw?=
 =?utf-8?B?R0NnWlBSTG4yOUJaOUxhZWdXWUpEeDdOQzlGQXRSTmlnQXJpRWNWT2F2anpQ?=
 =?utf-8?B?WkhUOVFlM1d2MDJSR0REWll3OEp1R0ZBSU5CZDRzdmRZZUwwMkJjeFMwcTd2?=
 =?utf-8?B?WTJMeVBhTnhrOVR3K1BvSXZrUTVrbHYrblBXUDQxSDBIK096OTFQTjdmN0R3?=
 =?utf-8?B?c1FDM1BXc2F1amhUYi9mditYQWxROXAxcnVjSjczS0xDelR1OHlIMUVzQ214?=
 =?utf-8?B?NEJ4YWxXNE02Zit5MWdxS0RERFpub1FiNElPNFBZMDc2Qmwwa0NFSmR5TUFI?=
 =?utf-8?B?cG9jOCtubWloTkZmL2NYb1FYUW5LUjFuUTFMSFpHVEtiSDY5dlhsNThHM1R6?=
 =?utf-8?B?ZzdtUU41ckdKSllTVmZ4TktyakJuRE9aU2sxTjNVcitzNVlDeVUxcFhLNE56?=
 =?utf-8?B?QUgwcUgwYm15YUk1K3EzRCthdFhkdEVtTDRCTVRtUXBEV1dzbzhnSUhjU294?=
 =?utf-8?B?bWxsVklONGIyZmw1WTJxVlhCWnBPcXlTUXlVRTdZMzQ2R00vVjFwSlRJOVM2?=
 =?utf-8?B?TUFNTU9lbXExRkxXNk1YWXI5d3YxSDNMdU4wME9EZ2MrZ0hCRUJxZU1XeEZL?=
 =?utf-8?B?WW9wUUNFYnc3TW90TlpjRE8zZUJ3NHlCdzd4cll2U2wzVTNMR0Y5YlFjYndB?=
 =?utf-8?B?dXhHZ25EbVZOaHQyd2lCamdhSkt4WGk0L3JwVGVNR1lSRk1MV256WE9SOEF2?=
 =?utf-8?B?NmNkb0tiZTMvT2Y2R2ZLSHJkdkwzVTBncXhmMnpMaEtDbjlyMUdzUStUcUQ4?=
 =?utf-8?B?dGwxUGlIRWFmNlA3S2RQWVc0czROVnlPWWRFbDhEOGFLTlREN0oyeVQ4em13?=
 =?utf-8?B?NlNBSmJ1RjI0dDhCbkJTUCttWmkyaTZCd0J6VmppbzE5VEVDb2d4czM2VUFP?=
 =?utf-8?B?c2ErNU5FS1N6cS9BeldiWXBqcHdVVHpKQ0ZyZnZiVlR0UE8wU3BxdTVMdXJO?=
 =?utf-8?B?dHJtNUhwcVI4c1gvVDhLR3REbTFJS2NtSy9hZVBEUytEanhxUVl0eUF3M1Fk?=
 =?utf-8?B?dnlFL0dUL1dLN3QrUWg2WEhTWm5FUXJUT1gzdHlIOUxyOGdmdFE4V1QvS0hZ?=
 =?utf-8?B?YTZwbnJReFV2alp0SDJWMEs5V2kyeTJOS2VOM2Y2UVZLZVpvTm5idGtVa3Bo?=
 =?utf-8?B?RzNrWXNKUTFQR0FjQUdYMzVLOWVLMHBvK1M4NzRJWVR1UFBLRUJvZ2xGZUU2?=
 =?utf-8?B?TEtVUFg0c3IxaUVvMFppVjJINjViSnJrRXI5ZENkUWxBMU82di9EdWdHTDV1?=
 =?utf-8?B?RW1OeEVLYU9xRU4yMDhwd0FheDF5akNzYVJlTlU3S2xyK1dlVDdFREUySFYx?=
 =?utf-8?B?ek1ZZTFIemRWd01Dek05WG1JbE9YeVBNckR1N1NYM3Y2QnVZUTFOdFppa1FP?=
 =?utf-8?B?YWRkSzdCZ0cvQ1ppWVN5ZFVobFdpV0RDZm56QWRpYmt6Mk9BdlFpVXV0RHkx?=
 =?utf-8?B?UkF4UGRnRmhqQXNlVlpKM1ZXY3hITkJ1eGFEUkJtNTNRcXZpaGo4N24yejFs?=
 =?utf-8?Q?bRvp+b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzFOQWE4eGZVZ3dHL0Z3VnBSenZJbDFyc2lzeVZQY1VpZEJkb0dLS0Y4bmI1?=
 =?utf-8?B?U0tMQXFXeUZkSE04MWswSTRhYlBlK05ERDNEQyt2ZGt4Rmp3OW5Ea0YzSGdz?=
 =?utf-8?B?VTJMblBBdFRmSVBRQWRySTNUWGFRQ0ZzTjRPQm9kL0pVcUFPRnlxMkZxVmQ2?=
 =?utf-8?B?a3QweUsrK05sTFhReFlNdnZ4L1c4WXlVWXgraVBkTGxmMFVXWGQ5K2kyK294?=
 =?utf-8?B?VmRsekFvMEFyOXUxeUZUTjZpUkh5cUJlandVOG5xRXRoMWxUODdnMFRadmxN?=
 =?utf-8?B?VUlhYkd1aFlWVTBtZnFQelM2NDJ5aGNDaDRrcC9EWEd6cHdMR1BYK01qbnVE?=
 =?utf-8?B?UDlyaTN6MXVnN21tYjA0MTMwSlh5V2xFRXdKVmY3cDBMTVZPOW8xem9aUWxz?=
 =?utf-8?B?SjVxRnBVNnJJdkNxU3pZMEVpa1I3Qi9TYVFlMUhaZmxQT25qMEsxU2JqZFlC?=
 =?utf-8?B?RnFTbnpna0puYjk4OFIzT2pEMDIwY1pFMk5YOTc2NnIwaUVCVmFRb0dKaHdE?=
 =?utf-8?B?L1hqVXBNU1ZoSnJTMTBDb3NXbmh3cXJhNUxmZlBja3dvUG5qSDJYQ3lzcnpG?=
 =?utf-8?B?NCtyNGszQ0wzMXk3QjlhOVoyZFc2S0NDZWFrR1YyeEJLZDdVV3FVNzVsUnJ3?=
 =?utf-8?B?TTlrdTFYOG5wRkcrMTNybVpqU1pDTGovRWxxSEp6cXJwMDZ6YWc2Ui85OTY2?=
 =?utf-8?B?enpneE0wQWVOc3daLzZjUXNDRnk3Wmd5TFA0ZVFkUGZHRWlzdU5WTytFaS9s?=
 =?utf-8?B?UGhhMitLQkdJWHJpcEZCUkFaVTZ3a3hpbzYra1V5NVVrSC8vbWorTUZiNmIx?=
 =?utf-8?B?YnFUMVdUVFIzNkJ0TWh1YkI4ZDRBanBDbzRzNndIWkF6VWZrdm45bVdWTHpM?=
 =?utf-8?B?OVZQb3U5aXlFY2hOd2MzRi9WSk5FVVdQelJGWEs1aU1Yc1BYQjM3WUc4bmhR?=
 =?utf-8?B?ZUhxY2Uya29Nc3M1UGFhZWlZNy8rYjdiVjlkeDc3a1Zla1lFb29wcmtEZ1M0?=
 =?utf-8?B?eENYL01NNEplQU1WZEFOcGRXMW1EelJLQlVzUUpTbm5jSDB1RjNYV2FKWnpE?=
 =?utf-8?B?am8ybUtKMG5JNnU3d212SzBLdHoxaVp1Z3djUmgxMm9qbktyWVIwbno5ZFU3?=
 =?utf-8?B?SG5ZWFBvVWN2MC9hZzRzZEdUVm1SVjdEd1Q1NjFPSDdoWURaNEhTZ09PZUxJ?=
 =?utf-8?B?Q0w1eUF6M3V6dngyRWlIaHMzbDBNem1YTTF4Y2RsWmMvdnNvREFWS3VpZGZv?=
 =?utf-8?B?T0RmSEZvaE1KdE1DMjlOVTgvajNCWEIxSEdJTWRmNFU3K2JJZXdLVlp6UVI0?=
 =?utf-8?B?NjArSHNJdmVUaDdITlQra1dFNjRCbkk2VUxXVC9LZlByemgzMmNhM0FjZW5w?=
 =?utf-8?B?VGZLeU1BU2t6S0FtUnBWTXJvclFHZnNETVc5TGM2OVpheVl3dGQ4WGdQV0ZB?=
 =?utf-8?B?VHpsSGtJWENkeVp2THAxWlIrSUZ1U3VmL1c1Y1V1UVFqeUp1MitweHFueVhr?=
 =?utf-8?B?TjEvZ1ZNVHZLemptWm56a3FYU3pUdWhQQy9SMXFXbnBjeDFMZ1NucktXeTlq?=
 =?utf-8?B?bHF5ZzduUWVKdFMyUi85TDhrdHlHeE9pOXBCeGc4eTNDc25aeTc2d29FUzNa?=
 =?utf-8?B?RVRUcHNyNk1xTlZDVlNyaUxnNlVEQW91ZUVta2cwV2JTcXltSXppT01rOW9t?=
 =?utf-8?B?bXc2ZWpNZFJxOVR3Rnl3OHBqalJMNVhrbmtWejB6VEliVkxQOC9lbVo2eXFB?=
 =?utf-8?B?ZkcxUXBNRHB5ZVRYeUloWDdPWXRiT2k1RnFaYmZ0aDBDT0xNUDJYNlc1YklR?=
 =?utf-8?B?OUxwMEw5eE9SaDJmOHBsdXcwNy9VVFdGL2FrYVlkanNyd1ZQVUVFSUdvS0tP?=
 =?utf-8?B?ak9WalV5OFRTNkhhWVBzbXVGek52dk1KanFaUHE2eTlqL3R5T0RXTnlSVG9N?=
 =?utf-8?B?N1ZoSHZTMVVUbFcvUHloQjFOZ1pvVWtpKzI4Rk9CeklqTnBQMlRsekgxdnRV?=
 =?utf-8?B?NlloMXk4WWhMSGE0K0VLcVRHVHZ0MzhydC9ucy9Pc0UrY2xmMm9vaFcwcWJh?=
 =?utf-8?B?YTdpY3k1K1phMit2ZDZ6OWpEdVhYZDJVNVJ1WDg1U3V2UVhIeCtsVnpMdEtQ?=
 =?utf-8?Q?z+UVaU2IA/8qaqJBM1eU1NBaY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fbc7b6-e46c-4c71-233b-08de101ca5b1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:07:16.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyIjQbxN903xoysfGF8lmgNB8W6eGedbFE8ABaXV7fJTIURblrpXopzONxhc+koBJjZaQKCEIvGQA8FHldrEmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Add device_type for memory node to fix below CHECK_DTB warnings:
  arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dtb: / (ge,imx6dl-b105pv2): memory@10000000: 'device_type' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
index 7a3b96315eaf55328cae2329357305b70c99fe6b..d5baec5e7a7824c05ca64c36a1839efff0bd7f71 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi
@@ -14,6 +14,7 @@
 / {
 	memory@10000000 {
 		reg = <0x10000000 0x40000000>;
+		device_type = "memory";
 	};
 
 	reg_3p3v: 3p3v {

-- 
2.34.1


