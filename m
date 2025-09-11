Return-Path: <linux-kernel+bounces-811227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D3B52636
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B93466F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6099255248;
	Thu, 11 Sep 2025 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BMTfCuvi"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECA2264B7;
	Thu, 11 Sep 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555913; cv=fail; b=nI1gEhuM4nZ4qSCFzV/BSSXoknxGqSebILYIceGz2hQ9x38pKBgTR4omi1W/w6m6r1vDZH3D8jRxxkdVsIJydiD/UglYoPIGzNNNI7aihqHki7YdCtVfZfuk8W0pkLKmVAyem/O2Xg1JHEIn/MKq1AB2KsGizzj2hOa4sS3ubIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555913; c=relaxed/simple;
	bh=v8xhbVfMGpNRRrY/8GtK5qzP2XRdTmlbudH5qhQ6C28=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aoXms4gxSJDMSTktUgzJ5AYIWUyVO3TRF40VkSJoTV3dx5bbKYbpA95DS3KkIHCXZHOoMF2DIKeo3jqg3d8Fm8lDHWS/j1eB2Ppg6i8TEjgOuWDKm4fALYhHIvVUrCAzAfPN2m6LVTsZxVZ82C90tEERPcwGQcH6WF2dHtBoLQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BMTfCuvi; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVU7J2VOe+ACKPhrkZppHQNavKfPLDHbWt+UlU4NHa0ELldMGN5Eg0cG8qe06GLzt0wV8TZAPKqbHX1nB57nWbAYUB3NUFVTKKdvFOqk51NIXYt05FQKnfESHtqv852FheCPe7WtKitvp6gszbVRcSRCRNHBYAeWWw1Qgr33pZwiwNAKRJBSrUjd0fZwQOrZSpLzOjQ0DcyGmDjcIcO6OtHN/NmvdMTcVpuKvmhsyZv42veegbhbUD1jpWzdzLmEBYmxeQJqXVux0tBwrYHIms2pDLA/PVJ8ABNds26Ox3hT0gWM11+/ADus1dk29fkGGfNieIZ40ffP839SSrs+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkQTWNIGkPow2ufLlFzW3FEWgbzGtC6MBGZwye43q/E=;
 b=l+lGO5ow7L22D0m1yCFbWxeoA442h+9BWpXyHF6lHDHs1kdjuhZolQXBOd5yQeh9sm3ZW6datX0HQT8/Z6LJEdpgXDbZx74XCYvAY3j04Z2qwVL9I0aYBrlrogAJX5RFhitnwnBKMvJgGj98JpNXgjIbFjAUUNQqSab2F1PjYJ84aEfXKran4YkH3G8crzoZW2wlAegWrqf/a83N5yEqnVH4hP8v1QvUBSfAHWxPQ0TqEniaJYiA2R0pn+z/OdG4wrMnCoiOU63R58qiKuOVAJlV8HexS21sxDR+vl+GNiF1cN/+ZrpEKAEInMEqKe13wXUhMA9sm0wLJayUX1J2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkQTWNIGkPow2ufLlFzW3FEWgbzGtC6MBGZwye43q/E=;
 b=BMTfCuvimzZB2WBIuCZOQGjXeBhjUlfJqdg/jKfEUYNKK5m6pTA+YKIgySEjzTFQen4s5l6VqyxrZVLVWdl+66JFB5umkyj7jAQtHgLBl8QJh9ecJfxix32sywQf60SDTgaP+cTxsby8AUoa8xRU6nZRxNFhrdw/e0L0XA+FHVCw4eQqZzpJEIkwuikFGPDFbWQMp50hOCTmhAdyjjpH++xuSybkMRD5JJcB6AxueF/yCZaR5D1UwOqiZz57UFIL081PPVlakYvYfLq1ZLlliytIsnJyWBOSaJ3OHnPAra00+TH1hjHGv8CuYUmaXOOLN8yXiO7tnlrcTZezcxUSyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6088.namprd03.prod.outlook.com (2603:10b6:208:311::22)
 by MW4PR03MB6650.namprd03.prod.outlook.com (2603:10b6:303:12d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 01:58:30 +0000
Received: from BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8]) by BL1PR03MB6088.namprd03.prod.outlook.com
 ([fe80::76:3ba7:5679:37e8%6]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 01:58:30 +0000
From: "Fong, Yan Kei" <yan.kei.fong@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 4/4] arm64: dts: socfpga: agilex5: Add 4-bit SPI bus width
Date: Thu, 11 Sep 2025 09:58:12 +0800
Message-Id: <645b91221320191844b2fa700832f70dce9f4fb7.1756881243.git.yan.kei.fong@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1756881243.git.yan.kei.fong@altera.com>
References: <cover.1756881243.git.yan.kei.fong@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To BL1PR03MB6088.namprd03.prod.outlook.com
 (2603:10b6:208:311::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6088:EE_|MW4PR03MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 382246b1-6c1c-4162-5706-08ddf0d6b4be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/zO+1/bcIu7YtLVLVMrnfX0GbUYSclmHZ85l1doYBH4L7VtMiRdG9wEBqpI7?=
 =?us-ascii?Q?ZrgRcyeSaEUYeZhCnmy4vTAIwj+azMnoIftcLWIfB5cH7tG7IiVsa+hkFs1W?=
 =?us-ascii?Q?SNTXtXNxLNvt/ve/9FTjJDtn6tm8W1oIFk6A/SOwUmssK1nwxjrfkckCYJQh?=
 =?us-ascii?Q?R2CnLJlGqFLhdxqSubr+o93s42J03xsRv3j8llMlzjgsiFYvP2vUqq1dlYib?=
 =?us-ascii?Q?h97BEmFvyMxZzA09/sXGy8IyL9p/aQBmVwyFYCQIB4fPiD8jRSYTmVzMZayS?=
 =?us-ascii?Q?vNu0D6NZbjL/FZukLKXexLBV9ewQcqzkrK0+nSuLvI6keFlVtBs5CX6s3dTo?=
 =?us-ascii?Q?nMEL3wxoBktAE0PB9uSiz46+98f5gj2g7t6Ah7WvztAmDmAIe9sOZHFFUMDi?=
 =?us-ascii?Q?9KJLddpO2C/EY3majBcLNjz8JCBdin+8zLEG23tlxe589C5sZrZv1fzFkE/j?=
 =?us-ascii?Q?L+WYa8rQQWbU6UrT4zsRbvJD4w8EV59Wbt8e0yX9G0zkgu7RjX7a4ZQcv3DJ?=
 =?us-ascii?Q?hGkV8106S7f95ZNV+6ty8rWjS1st9dedt87iO3NRGn7FkZbpMrXUX6dRJc2v?=
 =?us-ascii?Q?dgftRi2i8Znt+dSg5CaCM/4AyAS0c78/v3LBh9YfNl88wtDkAqKOFN8n6hk9?=
 =?us-ascii?Q?9pCQ32p3i9TnprlbWr2fq+VbNDi0MyDmyx8xXZfHGUvy5DWG1mCWUwTuXkPH?=
 =?us-ascii?Q?lMTpX9IAREuY1nF6gocgQjv29kkNwWxwWu5LRXA2we90tMOBxsQ+55QTYMe7?=
 =?us-ascii?Q?WTBNpfI2Z3Os/Gs9AC9evEgjYRYhLCsuPTOykoUwAeOsk4XI14H7dkMe7dRO?=
 =?us-ascii?Q?2HpvWDSpftC2uW58z0XJlSxANOTKZ9rgR5CjGKGLD6vKbGXUBhmxYJnMgT98?=
 =?us-ascii?Q?VhTpcbMa2qAqYOX3XKy7qVuT1qWa0aHofytZ7HHzDavPYgdqENF/ifoPHbw/?=
 =?us-ascii?Q?0BwLX+OMONesmlZoDYc94tQcuf7yQJewtuYGqORHj7tqXtBAEvgEREOxv3Yd?=
 =?us-ascii?Q?rd6Nrh8buFDLH4cW3l1+bCsf3eFcyC6gPhrmqC0/GKM3ujuo/WLP/Uq6NfRX?=
 =?us-ascii?Q?58TCNJvXVnbnIgQIwiGqUIcoK/Yl+44gq3ENe/5Ur5y9UVqjp8sB55Js1Rgt?=
 =?us-ascii?Q?cwA2N8MHoNAeNmhjejxD21D2aqpHqAuuyLS6YBah5DZqfVBHHRE9G/3wOU20?=
 =?us-ascii?Q?KAJ0BQFNTjCTu6nYOKuuXJeuzWnJDS8PlKYK1nJBxMa5dilMkmtOicqfZ2Fv?=
 =?us-ascii?Q?1PK1TICTBZOAvM0FK7fJaxDiyD3pUIuWgpY6KDwprcy6C55nj52iuPz3oVNE?=
 =?us-ascii?Q?aaqF4QMx0Rx2mTt3I+OJH70YQACUt2UGgpFMV9xTkCJy+Y9u9yJJXc2HJodv?=
 =?us-ascii?Q?U5L3PvxWEbJc71C5yeprAfQjPpBMwkPQVRUju2LAZ0WXIrbHX55WWgH50Njz?=
 =?us-ascii?Q?TkPzlhPwG7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6088.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+fS56ID1nGLR0PZ9rFfaYB/aifqVzmnU1sRsiUhcifmoT9RDJRPO27rGnfw+?=
 =?us-ascii?Q?LIjKi+Ipauo/mk3U2VbOGowXwy1jZVU5TL+Wbuh891OQrW3FrsLmy0EJNXC6?=
 =?us-ascii?Q?Q0JXgmwH4+nc6bKvfeRuKc0yQPuNL6UyAsICEHC6VHU8L57US28dNENZNpQV?=
 =?us-ascii?Q?CJnEuNa/EtymqYZgXoB75YbzVa9ckKjNIhMo/DXRMcfiJS3wrTfIDmgBA9D0?=
 =?us-ascii?Q?EpHT8t4dP2vmhaKATU3s2YCfIzw2eIdlR+/0uMCtZufhtVAVcGReusi+TrmL?=
 =?us-ascii?Q?8oZh1yu2xMLBd2Z7jAJMY9zOFewbdTpZ4HMCbZ/+cAXkuFrLv1cV/gKQ3eXG?=
 =?us-ascii?Q?lCO87farkoXN5KtOQKNmF16VkQw96dNIPEEfG7sIGCGhxeONaa7Wz+Dpg0oQ?=
 =?us-ascii?Q?uHWbG/i/4Go4fz3jVv5TdhVjYXCWGk4FLbqxbtZuewgogwgeXDx6vV7yEDgW?=
 =?us-ascii?Q?NT2NR2sRkPOAMG0DjoP0w5uq62mtGg/+0nL59JKqqMTfO1CAjWE0JVXiqznB?=
 =?us-ascii?Q?ID6SpHRGJgl92i2hcdnWizieO+vousctmoY+5zCdq78451ifSIL7TSCHVLGZ?=
 =?us-ascii?Q?1zzImRghLiIDFNPjhDQNNOWvsvftVIDNtrFR+glE5+pko0hxAiLBll6rnaSp?=
 =?us-ascii?Q?ueKnecJ/ISstH1LehzSds//N5etSh1oZuRmUr54wQs7LDlaCPfmtQmfPK9X8?=
 =?us-ascii?Q?OVDdID/5MRjNdckEYvXBQJBNvK/FOdHsv7PeRdkXGuB9XOJx/dHDrB/ZUyQO?=
 =?us-ascii?Q?46dP/FQa/mX6CRT9K1pL04ElT8/ENpvkLGPXzNJr3AB+gp+WRuvPfuXDtaFE?=
 =?us-ascii?Q?jVPAO2RqkDX3rYeahDeY6av/rQawFhyEH6OEZjR48GoCz/sf5kOcw/xk/Vok?=
 =?us-ascii?Q?oHe2CSy6pT6PhqhbdYIyvuEx7zmJZi2/6wh9w7laqgA/2Ml/JdK8HcIDefEO?=
 =?us-ascii?Q?bczh40KWzlSEjK+7Rk6Fc2/Iu0Xf1Mi3rBf8vkJ59RtHPHbu3exjtmJLUZyg?=
 =?us-ascii?Q?kHtDRs/y7Pk0gcmoRzUTIoYDoR00ccJHH/DD2nL5DaHR949xkZff29J77z6j?=
 =?us-ascii?Q?JEoYpVR9NPewA+0JbOQRSGgHoKxS4TdnxrQokWrwl93xknBGZBEsy4tYVNAS?=
 =?us-ascii?Q?TtV86UXzAulPj0yOph1A8ky+9Rhz0pprl/+OYBLnRxluNaieAmsT9AaxBEpp?=
 =?us-ascii?Q?NVIy3AtMTx+0BBS3UUzIQT/3dMU1WlbG7sZQNdiWabBowNTZtrxxY7ctTKEV?=
 =?us-ascii?Q?1onKnPlQvZO3jtouwgjyruadh70uhf5SxJxucoUzNd7CGat+jLg+6RfC88Ml?=
 =?us-ascii?Q?XaJIl9QVeArPwmkRRuGjie4hO0OvD4+ekxEb1mcyvxceuERllZMhdcUQ5e7U?=
 =?us-ascii?Q?RDu5nvxFxDqBroTkPT0ehr1HY70bbVvEMih0L2sua5I3NJ9A5HcZYdmAsPYM?=
 =?us-ascii?Q?cttele2U62ExTPpZDvLCKR8iHB9dxgjNsGtPt4MpAzwWiHSnxYHqpsN0WoA8?=
 =?us-ascii?Q?sZ8P6WyA9xMlpY9WXCxcbITiggFmCM1Ocx+Pqz0+KjKLIUwzGk3INV2StPzS?=
 =?us-ascii?Q?s+uf9mYDy+jFSRqeDXnsLsC5Bf2j6q6BQPW+Xlnhq0AbLdicvHtaHhJUGS2q?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382246b1-6c1c-4162-5706-08ddf0d6b4be
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6088.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 01:58:30.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GmTANIVFu2lLsLbj27TxLNv/bImWa1rzQubd79wOHro5geTTeplBzZCH54418kDGOmyHVKoqwkvLH4OGyy5mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6650

Add spi-tx-bus-width and spi-rx-bus-width properties with value 4 to the
agilex5 device tree. This update configures the SPI controller to use a 4-bit
bus width for both transmission and reception, potentially improving SPI
throughput and matching the hardware capabilities more closely.

Signed-off-by: Fong, Yan Kei <yan.kei.fong@altera.com>
Reviewed-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index d3b913b7902c..853e260c3976 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -57,6 +57,8 @@ flash@0 {
 		cdns,tsd2d-ns = <50>;
 		cdns,tchsh-ns = <4>;
 		cdns,tslch-ns = <4>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.25.1


