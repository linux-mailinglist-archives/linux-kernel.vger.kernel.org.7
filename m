Return-Path: <linux-kernel+bounces-885721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FA8C33C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30C6E4E68E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFE23185E;
	Wed,  5 Nov 2025 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gBkeo3Vn"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109122127A;
	Wed,  5 Nov 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309697; cv=fail; b=YquYHk/n3qX6Ls3bodcKeLg+GB/NwXLjGkhQtnPeRZrm+Dh5pMwcOon8rbXSQWkBN5gAackdG9IjMB6N9zx1UwfkPR+wDwewlZNiM6a4vQ55KRoFeChUHJC9NfWEF3QJWlC94wOsqeg5e2brou82dZXsHwv5YcPa6Rzmt6Th6m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309697; c=relaxed/simple;
	bh=lLLVXJ9uCNQ7HADyCWI5IzFmZxBRHKm0RVjWz4+yENw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JijCIBqY6X/PXhratzN8Bdwz5L4o6Z5IA8RJiyFmpt7zFbJ2AU1eLhc3w6TjDGtyKenRnNuZ1B4/VzuBw3fhRby3gINmZsby5P7UiW0vZXW28P+SvxO/efSF3ITRGF29itB6If6lFBl86NaqNpMk2VYS3Lei9ivw1pb+6DpfwWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gBkeo3Vn; arc=fail smtp.client-ip=52.101.61.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5RxZfvglDMxft5d9H/+ZYYHbpVOQh9YrMos6bervVRDYZCIIVDPPb7UMkIx8sQIukTUWOtUHXuoHVTxd/zZpGsl1T8BZ9n68l0O1taZ2Q6PTBoBnYa7vlbVpixR8H4XzhVKgyW6yBMwzFTkl3MzSeidg8XzhAF7b7pAHUHUYCt0bs7VyRyj+2ivvCuFCuue7ZB1eyqecS2uKIW3OM6p/5muFdTeB+ksIWMd0DiM7V4++typ+qkXBAlrW5A4UfO93LUbqpxAOlH5Lz+yt7d3gtJCTgJkfnBQTokhFzPvUdi1+hDsDIO97QHo9MZ1dTMpu3yhrMJMHds6dYrLnC28aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2dYe6ZOVDpsTYdjF4diw+a8hDF5xe6CSvt13Wv3qjg=;
 b=lFFhGDQZ+thOyGTHB0CyWTdPkbkyDt15tUBbdu12nTPAwfp0Skkc3zDa80wPbbZKreF9+wPLo253/nYSUo6aQzNEEOZUHoa9QztLo9ZXLq8MssON7qbXSP/yx/h1j4xVAsSdgz+AsgCdnZJVXLeOcAIVGRvKhIv1yJIjyIbSyCtMWybtJRj4oYeNTndzwBuStDBi5HUcs1TichO9GhzGIwZwZDNrPU2ZJmjosMS9k0oc/RTxAr8kPrKzC4OxNEsTs47Tqe82jYsdiE/R2uLlSiP617l3oEOKG/BFtO8L0Q/Nv/OdIhOx0QNJWVbzKhfAHvOp8vokXre1pX5mv/wAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2dYe6ZOVDpsTYdjF4diw+a8hDF5xe6CSvt13Wv3qjg=;
 b=gBkeo3Vn/Js7byWxHiDFR7cxP6ZDNvI0K21bzUwMlvzJJWD3fr9qjnNUF1/sfpm87dNr4Mdfr1DwbBLVAVJteiylZxiOYYhzPaotKyOcxFqv8e9LH4yUaja3scT7NtfybLpZQDyG7RtClTCVvUja9rPBQdoh13tShqPTjq/1IZIRyyt5QLcL4NDzradDX3vGZ9Aj6mSha/YTWZpUd0agUORhBJ9R7ii/gK2sA871XnERtaCtKdSj6OhkLbRjWeEkUT6AfuWEwNddxCMvEzKH2/aPCbVLjShJscDPTdUWjvb/CXy21qJqvSbxfpg8KtLJQvHNuTcWfwNaJ3Qxh+jPLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA6PR03MB7997.namprd03.prod.outlook.com (2603:10b6:806:42b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 5 Nov
 2025 02:28:12 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Wed, 5 Nov 2025
 02:28:12 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: firmware: svc: Add IOMMU support for Agilex5
Date: Wed,  5 Nov 2025 10:28:01 +0800
Message-ID: <97c7c260544f2e2f1615e494408a608d6c731eea.1762308672.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762308672.git.khairul.anuar.romli@altera.com>
References: <cover.1762308672.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA6PR03MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c714ad8-bc01-4755-bb5b-08de1c12f792
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sH2ULpPrA/Txrx2+u/nTZMG1fRMalWf34m1umtV5VfHnFcDhEHL2ldiwfV1K?=
 =?us-ascii?Q?9pQzSw6cejlVwhoUgxyWKLQ4CsUN4r+zTW65usZb9GiWf7DpOqnez1nRAkHu?=
 =?us-ascii?Q?7r98uu0ovexN/OQtlBGRHqO0B2Csra5beTAEG5PYJzap328KN55TM0qMokwi?=
 =?us-ascii?Q?f9MO5gL0xsNZftsFGU8gRMoiaTh29aOjaCpMMB6Sw+8gCklzaiRd+ptOi2ub?=
 =?us-ascii?Q?14KBtjWfX1UJgr+zxmvWOLJ9cqLVGmxbTJ37p5NZu14fbZD91pvu09+Z9fOi?=
 =?us-ascii?Q?ch//s4YYJqCsnIswM7BwrpgtLx3u48Iwk3u1gorUfJ3amojbarqqjd8urXFK?=
 =?us-ascii?Q?u+IekrguNLA75VZqS7UwQa7VNEMpWemVYqZr4YybbP9nDE5tvl3Jp7v8Q+Bf?=
 =?us-ascii?Q?JGKlItnHX4DIWzmTT5PBeTy0HiUBRzHNwpIj2R8jIb0gTxi7h5ITttNK242R?=
 =?us-ascii?Q?64RthgzNTpNhtA0xjors828ZKSVhhRhOswloPbFPAnfSmaOIPSKOzz302Vf0?=
 =?us-ascii?Q?wi2+YSPiMeI5OJx5oXujn/shPaW+qteXUrjFXJ/Rae3oWn2ZFiZYbRPY+vAn?=
 =?us-ascii?Q?tJpNbMeULVEj1BQb5YUTiIJnIUmmb6pXXowYtFzTXG+lnvJBuJs33TQ4OR5j?=
 =?us-ascii?Q?bqpJyFDzraE1ydI1jEP3MxYcbLggI2N+HNiUVwn87rGGr7/j7qT9tQh3ucL2?=
 =?us-ascii?Q?oEcxDJKU0vz5UqlySIyU8GePW+eyDZ3OSz0AoC41sgfOYOaCAIVaNNtjgJrP?=
 =?us-ascii?Q?dSL7mh3ymUJI4wny6XGdrpjDIV5zWtVismrf4YU2aSdfZj3F0AWVqydFTspj?=
 =?us-ascii?Q?vyC7h8uUvyzpd8jd8+P734DQBrBIPtv0h1Jts0WwiKvcWwZVyzq6snc17Lj1?=
 =?us-ascii?Q?k44+wFGinQ0CL0XUks1UUhlZDrzN4LR4aoXLfy+QVkPfGqWLlm7WwxeujZzx?=
 =?us-ascii?Q?wdFzrMhECf6i/mkQx9W4CDLCAMx1Cvhge55zF18Uy30Hxb3ORYuqnDh/qmS0?=
 =?us-ascii?Q?ONbn3jisMjjchjWfbccAgobhPsoLJ1zU1z2dGwr6n/B2S8cjPfgyaPlmi8gH?=
 =?us-ascii?Q?Zg8Q26dNsNZCTozMv6/wNOVvyl8GZ/qD9ZiVO/MDaYioSbAvJFT0epRdQhgl?=
 =?us-ascii?Q?+ZADMdvIoscRE6d9QHly015ejefvlXqNLZiUfyYdAcSzHgEmEuW9NKvfaxao?=
 =?us-ascii?Q?5nDjsby76XokWQsUdtfbcqfTIIBfuYOTnuzxQ/VAXagR0GxToPwWzL+XRC+Z?=
 =?us-ascii?Q?/iPdpwAwXsyqGm7n9drb1ZHnrk3p8i3nKj9AUkx4Do2gDA/qO4VVgqwts0nj?=
 =?us-ascii?Q?2mtQYoBs/kIqNL1SSsrh8WhJ2rKdRUQX/eeDXYidQvyFdHxrLtaVHMZwP4Wo?=
 =?us-ascii?Q?gTQfl6i35AOwyzVxiGoiWB0Mke+XEnUpCqMtTDcIAGPI/Bg2cIA8OwvpJf5U?=
 =?us-ascii?Q?rU3Wv5j8MA0C6MsH74cI7P3kOg8kDywttw/A1z2T2JXZLYInpNykDPSTxCXM?=
 =?us-ascii?Q?VeTNr6dAQ9zQT8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSLur3G9clML8h/k7NMiN0h5lGkeiaanaIJzCfVa6VGO+VrDS/WQjOH7TIum?=
 =?us-ascii?Q?/fB/gtKef10l/MZGPdfev6wta2PlCyrWA6GVPDtRrG/Z+8H06ESXaYp1X+0F?=
 =?us-ascii?Q?eOtBVGR3BvtulB1iTcUt9hnyhHPX5xG/cBOa78PxecDVtBN8kIwZ+GVNbwCy?=
 =?us-ascii?Q?jZYUtUgteugecjqHOw3ramavC8Ir/X1p+aGU1fJTjc+W5uXP32nlZpSF/F9n?=
 =?us-ascii?Q?fYyipSmMXScLWzUotA/518LE+a0/lpoKMOZG/AhxzP5oSN5it/G9CtGI4FCz?=
 =?us-ascii?Q?nufbHGgC+45phWburL4Z61UNJORkaiR4Y2XD9+iIsPDaBZzUFuXeuyRZxtVg?=
 =?us-ascii?Q?4PBgMCQmjrG2TRyNfReSlehJIyxUW+h1vj5S0Bye5Hg4F0xUQTrD7z90HV+C?=
 =?us-ascii?Q?I4R5ZroROMx/puGNRPvIDajPRKLe470NWfABli0maqqEmucCdzi6OINvs9pN?=
 =?us-ascii?Q?uLHpP67ePOSJ2AxjgyBXvw5aMLpJjyQQ6n/11UNSwFY9gWLcaMz8g8kur05U?=
 =?us-ascii?Q?2i2VFznAn/DKgOAT6RObW8EG9tWS7gYRTL/kei4mRez84emnvF181j7VGtEy?=
 =?us-ascii?Q?g5VUijh9rCaQamD9gPB7gDBzWWXS8yu4duSa70CgzqXpsA961rdI+oJdaPXn?=
 =?us-ascii?Q?X0GXvtJIujVmx1t1VlmkDZhKgDN9fIJCoU7adAXUOnn3ZvChZbVZN3ZlLMSy?=
 =?us-ascii?Q?zOYlgm0AB6J5yKgBIR21yzun9xn7tGuzj2nr4oAGXSEAN/JSEvLUjQhk0k5A?=
 =?us-ascii?Q?qASLcjMT27Fvo60Ln+W5FmYr2Pf6Yogc4lhK9E8Y+1igWGNgTSR9Y4yd6AgC?=
 =?us-ascii?Q?KxgVYHEyTH3jSrAPJOus0cXd4gGc8W2vaZL7j/KMSn67IENLG3RwBmq4pooo?=
 =?us-ascii?Q?fXM3+L29Q47RPys4q2u0twUZto10IaY3rr+P3NwGNfMcvl92vQndSxdhKMrm?=
 =?us-ascii?Q?NcfdRLXI6wsLT/Pual0TTmbHKGO/eKE2dOIaPwJrJY1TGH1bnXZ+mZcSB5c4?=
 =?us-ascii?Q?KG/Srlb0qNjV9LhnkLgyYriCx8w9CmhxHk7q4P40hINBStpXu38hVFwRlh5E?=
 =?us-ascii?Q?/J+WfylifsrQoXuejLo5Ifyem98wjmBqlKhVAC67fw5n5zva5LjJNwORBkI+?=
 =?us-ascii?Q?7JezXsuzoffGg71mZS8DyuDP3yDBGqgrPnvKw8bBFWrXccs3p7nadIvjfwOM?=
 =?us-ascii?Q?j2r+WDK901gMj+DSWB5ubgUk/QnxbTSqizlHWzvFhn22M3hhbXEAHYNhaSYv?=
 =?us-ascii?Q?qRDROh2k31K+xWZsYls4NJOQTc8aA3+Bm76fYuho0HKmwiM36rVDl++FcYu/?=
 =?us-ascii?Q?5JSbwUn+KGPDkjHeKqFktnmYfvD+73j8aZrpJxuggtRYxgJcipwYjRtq8FF2?=
 =?us-ascii?Q?dPHgU1BPbOfALOzMtbq0cgi78rXWj8uzeBStBZe7KmeP0BTqNquUACTiwExq?=
 =?us-ascii?Q?fEihixJ0Fsm/Ewz0dRZ/6A2UgluaEBj6SEVBJeZIscR9Ma1BNwl8+EPXj4KU?=
 =?us-ascii?Q?w6uwETz2guLhlKxc7nM1iA8xymgT3pr/oz/6h1scyIEfwNfOWI1o2CE2HMGF?=
 =?us-ascii?Q?7U9f+5D8valAXs+HEz6uW5bd/lBWqnE7T6wBb0xBTuxvQUPtxOIYrlOWjf3Z?=
 =?us-ascii?Q?jYWDEPCcKHuE5lTklPxvRNI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c714ad8-bc01-4755-bb5b-08de1c12f792
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 02:28:12.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VJCiicCE/vhUpIhQfO71T+JqRSInlon4WK9b1Ft39WanbEv3Qem536yHI94D1y/mzXAJQWwvYGg9fZbTkPw31g8GRjJby6dGy8IRmyDOgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7997

In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
mode, enabling Linux to utilize it through the IOMMU framework. This allows
improved memory management capabilities in non-secure environments. With
Agilex5 lifting this restriction, we are now extending the device tree
bindings to support IOMMU for the Agilex5 SVC.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- Use contains enum instead of const
Changes in v4:
	- Fix syntax / style error.
	- Refactor code not to use AllOf but instead use if directly.
Changes in v3:
	- Add iommu property.
	- Add logical check where only Agilex5 required iommus
	- Rewrite the commit message to explain why this changes is 
	  needed.
Changes in v2:
	- Reprase commit message to exclude iommu
---
 .../bindings/firmware/intel,stratix10-svc.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..a66aeed0ddee 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -34,6 +34,7 @@ properties:
     enum:
       - intel,stratix10-svc
       - intel,agilex-svc
+      - intel,agilex5-svc
 
   method:
     description: |
@@ -54,6 +55,9 @@ properties:
       reserved memory region for the service layer driver to
       communicate with the secure device manager.
 
+  iommus:
+    maxItems: 1
+
   fpga-mgr:
     $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
     description: Optional child node for fpga manager to perform fabric configuration.
@@ -63,6 +67,16 @@ required:
   - method
   - memory-region
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - intel,agilex5-svc
+then:
+  required:
+    - iommus
+
 additionalProperties: false
 
 examples:
-- 
2.43.7


