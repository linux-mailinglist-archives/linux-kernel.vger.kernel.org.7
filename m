Return-Path: <linux-kernel+bounces-883789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F4C2E6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAF4D34BF3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33E2FF161;
	Mon,  3 Nov 2025 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VM95UqL7"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85382FFFA9;
	Mon,  3 Nov 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213190; cv=fail; b=l6OkOwslJhtc7e7553SsdZ7y7q8fNvpLKqiFw/xzdey+0rrGGCLmaC2DymlDK/kk7dJIviP1fw2brnaASPaO1zGqqQPLXFA46Hkr4QGSEYaAVPCtSnd+nrVE2+LVNOUPwmgkpf2pFrrwuCi/my/nRFsqddMK5dB8aq9YAxOROQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213190; c=relaxed/simple;
	bh=TepML46+RH7rd+iJnetmGEBxmbPZfgb3toeLM+d1TLI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gUUlYuXqQr1WEshGq1c18/tPnJSZOBTFUHJZvv/arezC3eYfwKu13+tnpIyilinF5J2DJHc70GY5FhptMEkIc6pJztir2+hrdJPVJ/BDjBRtraBt8VAniXjx/Yt4cXSqzs0I/qaSqSdLB07Ozl98nLsEDQHeB4BoCLjr1bMWsIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VM95UqL7; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L902MI3CHy/nddpMscenvcmH6dBQWftXyupRmBAHzTvMS2nDFLJXq8/O+ySQPIYmx+0PNZdhd9LsFkfbKYmqqP0qf5Fb8M5xfNaXdDCwB3AevD8TzI93Dgkn4C6WzycgZh5U8aYtFN9FpaQ97uXqtaxO1+XZM+0Qkjj9pkqTSDAAtq/tfyItvvmoOLNSdStV0JEQuDHSKoiK5FWMgSyVuDsa65LsIEVbQuHPxFRIgo7OGeVxEqAyvsHGDx3DwgfVLEavEN5EQkLFpf8UFJIKCdYQasrr2urRBkv+FGjGx1CQjt32N28xYqSBunWg77WCiT1mKQzxrnG4YEwM7NQ5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX36vnoOMfRLM6sZjWS6wdnQBhbTaytm8ER/QiUV0nM=;
 b=K9M+j54kMC5aIkaPtkEyPtc4Bk3/GuCQ3zga+nUSfkiTqt1N2fs1OgEKPC6ZZEOwRaFnKSO2am1Zo6586bJT2UzmN1eRxgxxwWiAeM6NyIveZ987D0hPoInjZskBuHohiM8aHwqaaW5mzgsZhWa33UUht3HiA/ZS+OjriOVKqGpSsAYNNHv31oQdZDgKQalKaPi2HFwYWHfMx1b+D4lodQEyLFT5Xky2LimFDPDAG+62Yh3+JV9PSHy/6L/FFf1GUYFHWzihK8Yq1DZYpcoxV805tGRzIssPARnZwC0jQRVNsEiaPHgMncnFaUHZgl+H2muVIjs9RwIXuTYCEKP9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX36vnoOMfRLM6sZjWS6wdnQBhbTaytm8ER/QiUV0nM=;
 b=VM95UqL73wF2U70jelIMaiWMdvpPQ8Ka9dEV5Eo2EoeLqm9ziLBvUgFTM2zn2bMmTpq0ULXQxxr24Z6lRIw+UwS5AnPH5QtiRuUXHprKP9EuXBKQiWdawARU0A2mZrb56a0KSqCJRnvGeDfJ5mtcsQGQMJ49o5sVs3vMCKqcRz0EJUAUT7lQOVoy5BdV4wlMcGNWn1SbFKFWV6cQ5eSBAXmF1CsVOrLmWmuwGjAImmRMDaCPIXZ/rqbRkp22xwKEcrwTJZ081/oWqI6oLzDlVwCij2R+FpHYZpyZKI5UAPy1Io4hBArYKyekcLbRU8VN8zXMGvujJqnweivcG2DeKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6538.namprd03.prod.outlook.com (2603:10b6:303:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:39:44 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Mon, 3 Nov 2025
 23:39:44 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v3 2/2] arm64: dts: intel: Add Agilex5 SVC node with memory region
Date: Tue,  4 Nov 2025 07:39:28 +0800
Message-ID: <7677ef6a4e25a0700ea2f4b493396145a791ac5a.1762135710.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762135710.git.khairul.anuar.romli@altera.com>
References: <cover.1762135710.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|MW4PR03MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: aff6cf20-8478-4e23-4da6-08de1b324408
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EaCW4Sr2RgV3gABNotYcWbiiEf3Gqw66h7y6dluox4uzvT8iBQqPfjrwGS6G?=
 =?us-ascii?Q?waVr5i2Lh2sGNQihp1HEwEmkib9XGOaWGnhxI3VWItR680PnXCtHKGCq4G9d?=
 =?us-ascii?Q?PSUNMQpMcd4dWq6d04Yg9Zh+e/di5j2wZc2zDoV1tT5nLUonc+gvstghZ8cz?=
 =?us-ascii?Q?Gr8gqQWaX29LZFt+Ifn+8UtB3iXbQOCwhNJ5sz7meUy39nLb/KhEIOMpN9vc?=
 =?us-ascii?Q?Pd0prCOoF1Kbobaoz0hY0oVN2U5h3vD8ZU0ZrPqstDOl437xZaD6Pk7d7fkn?=
 =?us-ascii?Q?M+OvZhMxxBJDqQxqIudihYysgqGHI8D7UvltK13IonLSBX2P0GO0T92C5Jiv?=
 =?us-ascii?Q?i+6Ar1vAW01m3Uw9l8lek7R44cCteGcmsUZkbIyF+rJzc2fE9HrYF8Abfr/6?=
 =?us-ascii?Q?1YDZhF7iu7t7IFFdU+ujix+ftDOD/fNoTIqDWK1RHd0ZqLhWxpGextW8dyc+?=
 =?us-ascii?Q?vhE49VN9CbptcVWFlCl893XUcpI85NgJ8rAqGN64CtJVhzxqr2VURjIUjtXE?=
 =?us-ascii?Q?eC7MwlC+h4mLuUrRCoO4lAl+tPz2zbdyNtHLRXjk7il7I0EGQH5bor1sdUz0?=
 =?us-ascii?Q?iqtN/aM4/4XegsSoNyQRYYaHRSWdd5yruZagdX9gBD3VOoH531tFVy4B+s2I?=
 =?us-ascii?Q?RDYPbKlHzOjB7dIRLf2u9COUXXv2eDpcIEVh0fTTVbenFAVz9nfr0zn9HQ3s?=
 =?us-ascii?Q?PHRw+7XQzDUIC/oiYLSkTeS0+6fh86n1gIgx+6JjnmwyC4/filq96itEty+7?=
 =?us-ascii?Q?6Mwet52GZew92jrRtU3K72t3RnXUHq36sWObFv8Ie9btgJF2KGbzW4lgNukf?=
 =?us-ascii?Q?pGutpheVSQQKRyz4IAu+eBMZRpQ+9yVVn9uQVuiiWxHblVXplHcKLixpnJtl?=
 =?us-ascii?Q?H52BpeSA/ufpGdgq3tD8ySq/9exuttrgDWTJsQ6Jj2mdMO2/UgQmBV+x5DyZ?=
 =?us-ascii?Q?Eg5e1KO762JvMs7Dotjv23kO59c/WFbNdROcVdeFrCRuPAIFiYOTWrr+z+fX?=
 =?us-ascii?Q?3IWpcJIW4G+5OenCFQcMin3ixOC2pNFDHIk0Fqua21uafXrWzmdUpdHAr8EN?=
 =?us-ascii?Q?L9ZN9Ez2+0aEIMH0N6+VeMTdDqZtdRdDQRiz/P9fkgJ0G9jIokvBK4CPSF/t?=
 =?us-ascii?Q?g8A5NvSBbXdUNaojQb87cUWjwfZMs2VqbKqVgj+DhTqFzs41lq9usgmmZa7a?=
 =?us-ascii?Q?/YcsII8/02yKfhVGkFU0Fjvo/gMfpxyLj29y+z76w64JpFUBUB9QVoUy9Lz4?=
 =?us-ascii?Q?E7wBMVCikN+jhTqsiulo6phdie6rioEwTVCEZOD9mKl+Oq0yTWvRXg4NItWc?=
 =?us-ascii?Q?ygyThpPk3KO3oTaN+LcGUXedsdIgQ/KES5SJPVTI03v/lfhxJmzjivi6MjLJ?=
 =?us-ascii?Q?118DuJvpXYKm3Vnydlo4Ps7kFrxQUGxtsCd0AiWkSgBTLTYWSPHgv7mJDDEr?=
 =?us-ascii?Q?7VCKA/e6oeWRcabwwtzJRzwS1A/OgD6OiIqlpPh/eMoON+Njeah1aGPQGFbk?=
 =?us-ascii?Q?+oYQiNgmcvPdXJo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCatr6QaqKBX9L3fa1JA7WgIXYQe47l4gxytlgvaiWT0MPFYEXXBDM4qUqfV?=
 =?us-ascii?Q?UHOWoYokQerzKi2xtHds1evlsPZ4w0KWnaaCxClgiY8y5dhpY+10f7LNkgwp?=
 =?us-ascii?Q?D+eswtWjqhUW7EujJwLMeNVYE128OrZ6o5v8IVGZR6VHA+ghceLqxiQiABFC?=
 =?us-ascii?Q?kXy8InrzFMJ/zm+IR3jlGxtEeFBUUzA88FcVSJoWjFunZYwn4nVneOslUgbr?=
 =?us-ascii?Q?TE5DLkRGKCnrS8sUeJ9J8IYubXJ+m+9N8Q+6KhhRC7F6hEKkzC0Psjb/oOYH?=
 =?us-ascii?Q?fVP5U+1Nx17SaKvSoZ+fvK/tPZzWfZgpF1gUa0gzCRFA9aYeNUHQzaauXMwh?=
 =?us-ascii?Q?TnRDycRK5M1FwtSSt70gjsASlhTAzVyTUsasXz72HbZkPGQUySYJHRltVRn/?=
 =?us-ascii?Q?O+/aO3863T5tYCL5lBCo1FAuxhU/u81+nMrU7nvj4q6Io485ugUWO1Maf8Vk?=
 =?us-ascii?Q?NqPzndTLcYKKR2yqe7JcJWbb/pajqL9g547RaEQx6gEPoQHmY4tJNmmKM4pE?=
 =?us-ascii?Q?vuFcHTOc47OsIo8TXHrEsKKPo2r4XSHi8edVaQ+dmRVN2yxUH/xac9xAztaG?=
 =?us-ascii?Q?yzj8edBWN/fZRiJ0kArGynSZ3cnnoNBZN6fXJD6BIdWrAbl21Bb1FyH+Maku?=
 =?us-ascii?Q?iArBY3ja6rHa2gDF6yZt0dl7U6uT/C6D5PXqeXR0H1Oq3XMBCU5tGTXLZkQm?=
 =?us-ascii?Q?08QkAwN3QnxCe1oUpnb9WO58N7bcnsso6iODCPyX5nJACFtA5BE48X5+Ityu?=
 =?us-ascii?Q?38Ty9e06dgpQ5J9OJrE0CRNGypvhIei5fhpTPsepxCe/kxKc9bbP6v/Gr05v?=
 =?us-ascii?Q?GJvTAQSZYxcZvkEycPbf+viqkJebSM6FRlaYpwJGqyeykIdNLkwvtRVw0ORv?=
 =?us-ascii?Q?bcN+AN+P2OjeJnoMSbV7P9FFwKy1hs46PdePp7YtYvULPjwi2E4GkMRwL1wS?=
 =?us-ascii?Q?gaV9J9Phx62UCos6gK/qVLy7kdVUN0AwrAF9azE+EOw7mz/BvcUjN/zZWnxX?=
 =?us-ascii?Q?TXzxvlL01Uja1H+NdV9q2EIVnoqb5s+ynVcGUd5cUbBgcrwHWkfRlb+tXrZb?=
 =?us-ascii?Q?Xxatlxsgy6hc0RBVOMArddhEB8Z9NkwuJNFAT7pVksYb7fXA657yaPnTROpC?=
 =?us-ascii?Q?KXTQQmSvrBwgBWv0iVpCGO++HRJPy3B//RaHFzUgWgb8B49NeNhG3VjnJAQH?=
 =?us-ascii?Q?g20APoBZPSE2yeqYE7LFjraLd16g/UTTf76UjKzVWUA5FdhEwI4dW8pUWGGe?=
 =?us-ascii?Q?xkperVsmZt15X/hF6IpbVn3bkB6JEblmJVZ0JL2Xx3ND1KCbFzoksQFwYLVv?=
 =?us-ascii?Q?cBSUiOIMslyp/LiYuNa/assXNmOhSb9kurmnwERE0M4mpr1YLsi+B1X+LVp5?=
 =?us-ascii?Q?JBjmjblzVZk6WaO4MQqCwsPTcVq9vhxWu1ZAeqboGXA1TCpcleLfqAJ57WS8?=
 =?us-ascii?Q?dYbMzsXADh6c1eAXzY+hGbl6XE9ToFPf92QPdAgbuVjzkJTk677LLaQSzL8G?=
 =?us-ascii?Q?fgPLn/L8noih/yPhyhZaVn8EE6ZXtgQpaQnb4kcZQ7n7mIKs5AzkdJXHBcgl?=
 =?us-ascii?Q?/EHlnrrvXRWninf2BPRb+6q+SFpqgFj/ag2OcCgpbu/9vC1BAwTjbBFlrpIg?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff6cf20-8478-4e23-4da6-08de1b324408
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:39:44.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sm9oaxavXWpEhtKIPsMrg6fP7UmBcKy6Mon2/hpt/OURxiuW6360wDV/bBTmBb7G+jDhai753WyZe9/0HkbdeJM6Py3SY2pAz2dt4ayana0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6538

Introduce the Stratix10 SoC Service Layer (SVC) node for Agilex5 SoCs. This
node includes the compatible string "intel,agilex5-svc" and references a
reserved memory region used for communication with the Secure Device
Manager (SDM).

Agilex5 introduces changes in how reserved memory is mapped and accessed
compared to previous SoC generations, particularly with the addition of
IOMMU support. Unlike earlier platforms, Agilex5 enables the use of the
Translation Buffer Unit (TBU) in non-secure mode, allowing Linux to access
it through the IOMMU framework. This commit updates the device tree
structure to support Agilex5-specific handling of the SVC interface,
including the necessary bindings for IOMMU integration.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
Changes in v3:
	- include iommu property in svc node.
	- Rephrase git commit message to describe iommu presence
	  in Agilex5
Changes in v2:
	- Rephrase commit message to exclude mentioning iommu
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a13ccee3c4c3..15284092897e 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -841,5 +841,14 @@ queue7 {
 				};
 			};
 		};
+
+		firmware {
+			svc {
+				compatible = "intel,agilex5-svc";
+				method = "smc";
+				memory-region = <&service_reserved>;
+				iommus = <&smmu 10>;
+			};
+		};
 	};
 };
-- 
2.43.7


