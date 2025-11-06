Return-Path: <linux-kernel+bounces-889539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B017BC3DDDF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EA5E4E4D84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25234E776;
	Thu,  6 Nov 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="UCgUy5Si"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8857346768;
	Thu,  6 Nov 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472142; cv=fail; b=ib0Y+Kgpd1+NuYdfkhrAMmWGZFXtuLbLWUuFthD7LiyZ+Al40PyvbwADdQXs/5zGcabxGKeuJKGdDMeBtJ267WxIoxwQjMtEzMiy1vegkF9tEjIzArivhyH8C6lWde+Nyq4lEmINerVAYCEgNGy7Kz0BDQb5wzVu7v3q9HCyXcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472142; c=relaxed/simple;
	bh=jmuaSAn8gIAnr0kEoS86E75oxzsFDSS01ghhGn2iDVw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkUPJFSHQItEZ0NnWdrEBYY/096HElpKqnxvwjGj3YocVobXL3y5S/pmINKexXUtZUHCdBeLjoIYH5yVaqo36NvUDdIfffKJXFRjWP1Hyqd/03GWcydQRFTBAZXNFLC6RUSs7yd1DwXPizBGivncrcTgbS6DbbAVKr4vgZVuBXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=UCgUy5Si; arc=fail smtp.client-ip=52.101.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XacaY2Ihkk13EUyJF6zm+Sqepyxwl04sjqcw/jygijxSdar47/lHNgQeli7BFql8z87yq5LYEXLCtww3jDcgO8emf0ZpaJa6LenKf8sP4+/GZGuukc6kEor6YZVKtUouGj/ZgmHXLb+ZOqYTByVbhG7ERjKspxYs2wKDPyFAHinsG9A8WzyNlZiJQ8mrdJWKxeyVRjMRRvtirnQ0+VjV7pulD1julDjyTImR4viipfA651SI0aA0HMgN7UgO7ZCne+pz9jC8RCc5w7ISUXU7vjY9jQO8K5QxSKhvStLFMZgBLdW3r82d40rQFDp7zpd2ya8ConCVit/3fyWSbwRABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Ef9O2c94HgtEr/jzM+bZabRAj3zZ80C3OWMM0rNvI=;
 b=Vld86cI4jWIFybYWfj3YgjY6uhE8tmGWj4tAY2BMF0KWEl2ObNtkgGTZOvjerjHlNo1M8WI9rC6QUxzdlojU51uqOFTPolgszYJpJvqQjHVAfTc9QCEOsmRQadfdXmyMqFtm8Ek1jZ1Cfb/tlINjOu2bOYGhyR3dN65XR6r2AVmsI3giO0xYa8ypvNAo5eh1pvwP2FZ+PBGtzhjx+vGY9I4de/Al3oScNjQnx6rTrIXba0LbLmmad3tHq1TFzO7jDWXGI3VMbWoWBVFkaqsshvgWxBPD2XCABTNklYwELpCr7tKGgssv0BjZhQI4tZnM5yR5EiuPNNkv2XdWVaQNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+Ef9O2c94HgtEr/jzM+bZabRAj3zZ80C3OWMM0rNvI=;
 b=UCgUy5SiMraNULqeJmWf1PPtusrYZsU/U1+UeDPbIN+ZnswJXTbqjsWoTK0h+mteGnGOGsVoiUju4eLVfiYwebOfgY498cqRiU4zkz6eC9UUl/domCAsR/+dNQx40ZKz4j6DzfsPFPc3D9hJ8vbBpaVDdRWJJ01PyqNdpEv+GZ2dElILAqmLbWhnR2NTKDtMLJDjOCoP4drl9DaQN22u/giT0ALls/8YxO+y+1e6Hk+bsXCKAGN3IsvEqo+0XT1FSk0IbX12r8qJzxZMnSaqdz6UIGxawUZI1s73RGmKp5pZlT+HjWW+lejCmezbiHR4l7dRKZfEwYF/oMtTuNqX/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 23:35:38 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 23:35:37 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v6 1/2] dt-bindings: firmware: svc: Add IOMMU support for Agilex5
Date: Fri,  7 Nov 2025 07:35:25 +0800
Message-ID: <dc40029c970d33b433e763202e6622a0a2f12d72.1762387665.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762387665.git.khairul.anuar.romli@altera.com>
References: <cover.1762387665.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: c564cdb3-e0df-41e5-1f32-08de1d8d3053
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WWyReHoLMHT+1XPWShdsWBffzr77N1qo/Mbm++Bwbf/dMTTJytH87LjDvAxd?=
 =?us-ascii?Q?QBHfN8Wz5cpRswZ5+hR1eUjEggcUcj/CxUErDSwdtvuottf7GUM8WHIFHfLf?=
 =?us-ascii?Q?eFRpvGVA1KkWwCZDuhzk4+PXSFhCceUewDXNhrcY4zBYryLKouzmQ0g/FKDF?=
 =?us-ascii?Q?6j3rPdYnRbI9iS7Iq+6ccSWQ9QfnjjdcL14ZH/ZYpp6MewhbI5/tCjmpaOq3?=
 =?us-ascii?Q?iCGHxHp1Lr3BRVKI/Bh8YN0Jiwq+xW5CEi8BXpyjgPXgblks+a2nldyMulAa?=
 =?us-ascii?Q?nsgo7t+nRZp0yI6aq19Bl1NbkjVgxTaCAMLVIiZb5a9E2VYShFRZhunIt2lJ?=
 =?us-ascii?Q?LrFv/xYSGbS1F6Rd9PM/GqzUcgX9xdpix0kPz0PPOTD/TzYmh8vZzxW0mMSK?=
 =?us-ascii?Q?MJq/Hra4EtNsBskrtQqyoEhsP5R8uQejNIvu6YPqVQFEUNP22byfypmKB0Fx?=
 =?us-ascii?Q?8y47wYFvGx0TvvfVukcdHOeWRB6sa7NeLxhvP1wTqgFctHpmr+BT9Celjzd2?=
 =?us-ascii?Q?U7Qhcn7QoVSgHn6qxcgft0qLwqszrnEK0uXkG/pJHih/74PtLxovbNawIYgL?=
 =?us-ascii?Q?M9UYSNSrqfvuzjncUhn1vadxWSJaajaW+1TBRm6eA9PrULn77Q7pqFP6K6E3?=
 =?us-ascii?Q?LyrAoybGWr3+4C/4v001IqoZrspsCG7xZdKzO75PNKlAx5yc1Okr950UmIwS?=
 =?us-ascii?Q?ALecMIWoXPxMM6hEcwXJQujyD1ie2fWEn+8iLRRdVNo9wO/9OHNALy1PU+wa?=
 =?us-ascii?Q?fVlfo3MvpvsIyy+ZuBMLSxf+7pu4Xx9OnDURPB+wiyB4ZCsuaKDR2nJIaURu?=
 =?us-ascii?Q?dB2+2/DEdfel3KVAybowiHNKCqcZwdFs0RhCvjsZyfQWjGZwO1DDhgZQmHMT?=
 =?us-ascii?Q?tcWOL07etaCbOJT8IXfVEsFXNX0pqKatdZyKSglB4K0Cj9YbVbyuORS3VcLM?=
 =?us-ascii?Q?DqIgfB6cGAe1vZu8IoKxg0cSDj1vYyQPKHEGzFR0W69rLCKMXAvngER/BFaD?=
 =?us-ascii?Q?elM04oVo2xnhEcpjYYWfQ8tyGjzx/jTZJ1miuQ4/y5WVxqx2qe+4bXxairxM?=
 =?us-ascii?Q?4SemYRgKObE2Ffh3t8sl1KivzplkHAm37R+xlDjDUFRtCiRvtGhZVL8Wx2PI?=
 =?us-ascii?Q?TfepByjGSSS1pXhZpApJ/XrqipaJry54x95clLl60sNRpfEOMbW22+SIG3+C?=
 =?us-ascii?Q?f4mQwigXt+5jgKvgzJDx12ENrbuvnhgpgQYsDLc4Pd82tE3h4pUdOdJ0MHZ2?=
 =?us-ascii?Q?M375+ixfCUe2Tx04r4AbPZlLJ7zVuKI/w4VbCwozwWiZrMsixuWfCfCaPiuh?=
 =?us-ascii?Q?zhu5/zM5WZXEAImNhw3R/vy1ZinIBy1xih3TX7NGsbqhXMZ55C/1mWsIR9/x?=
 =?us-ascii?Q?3B/cpEeQ9Pu2DUEb0kFEp9OTPq2L6i1yJDOcUcb38sEJfL8hMkLTsaO9NUWs?=
 =?us-ascii?Q?06FEwKy8yyO7rdNZShyKsnIWc1xf2WJC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXkaYBiitSRcnTa4KBk3xulvV2mFOp8sEldGbp3Cn8FBHdisETApWyZidr8L?=
 =?us-ascii?Q?rZuZKr6B68hmvSwkvIRYTBLCgPZOL7TEpUtqtzK4h1JQifNWQ5EZHSzwquuU?=
 =?us-ascii?Q?+6JQSwTqVqu6zOMUu6zF3TMpRFyx3c+oMU3fLM7VldZxAZUeZpQgO+IVNA9R?=
 =?us-ascii?Q?sIchV1LNsmVgpZuPaFh5SeiMnW7ijQW6PJurgHFdAMW5oDhUUjX/FnTi5pHD?=
 =?us-ascii?Q?VoFP5fYCwPZ5wfWJ/UqojOCDqOboa6FRpdRvKNSH3LiFhjdcgzUY92b6x7LL?=
 =?us-ascii?Q?giK/1H51BLkEvO1paXI5AGVuhYoXnFro8W95Myp0JBHjzHJxscFbcTPk8p7K?=
 =?us-ascii?Q?CKW8Dzi9b0aIAmTWwHmh27rChA4PdlXvXfJGMameS6yM/bUwV3ao0O2f0aTy?=
 =?us-ascii?Q?GB6aGc5JzVN2HLh621MOYik469GxB2N5ybnz9QFnAQ7kFK2uD/NITvEdShRd?=
 =?us-ascii?Q?SQv1q84jc8bMm8PKiILv0dQG2Ce2uhupka6AikSlVFDktEuZvQYjnq/ISsoY?=
 =?us-ascii?Q?hJ88MOw0hKfIl219f+s6MkIsHoBGUGFfv8OEAPhjTxbsa+Em2xWdGxM7zLh7?=
 =?us-ascii?Q?ROqyHKe9YY3doSgI/+2Te1X8wcWwOSv88O2bnmdvj5TQhxV51iBlkhoVUMU6?=
 =?us-ascii?Q?qdSZb/2QME0dAmGi8WROwpIeM1arKHj8ShrNu1h8Az+8s993UK4TnUJl2j13?=
 =?us-ascii?Q?f60LI8F/iOu/iYUhi1tZEpfDFO3fzbs9kXzqw/S8rDR9/xvuJU6XQ/KaM99L?=
 =?us-ascii?Q?MVOSKSQfIQQS9F0ZHlSEDy+q6HZlKxwpFQAmkTBD+pphFlsjYHq77DCSafff?=
 =?us-ascii?Q?1HxYe2SuOw50gwmG+PlqFUlSDwhXW7CYvcV2unxZJ4fEZf0b5Dhr2twyJ5NN?=
 =?us-ascii?Q?IDIh8C5bklq2Cu5dwO5ixgno0ZxiKVSPhBXRZjF3efuL6vrxP3hZ5VMngwj0?=
 =?us-ascii?Q?4MI4jx1JtPThNsJ/lr9UcIvzUt2z5AzDW0iyFeqCgjOE7QR8iSufMhtwRdNW?=
 =?us-ascii?Q?mlFdjpJDkLQe2RmlksH/Ve2dyEktV0AAwGIluuMAEYZW2y2mvJTa3jS9FN9h?=
 =?us-ascii?Q?Fssp2huZVLI3XMBnL9BHTdDE+AfI74/0XH57nVtgmsUhtJ+LUPHs43GteqAv?=
 =?us-ascii?Q?lMJxWd4wdMdG/F27vbWeMrnl4oHPi8oa8PGtyblKkC75N3ZUFxnt495KT0KT?=
 =?us-ascii?Q?nqSwC3fMfYS0N3O4YR96jPJOhfQs1J24Xr04gR2a4VZE9PXPwIhjV4+j5cUV?=
 =?us-ascii?Q?I9pcXjWRosoOcdgNOFws3Wiysr3BbUGfzl6LsYCwqrzBdyaCuGAACHwHSrj6?=
 =?us-ascii?Q?u/sotKU/5MMVvDIiFXfFCPe4VZuOXUjTHZB6igsQgVjQx0yRe7q0ymnCmHul?=
 =?us-ascii?Q?f7rt2sxbtFLOil1UpmhKTjFySZtT/34zEYKMMkuMa6MFSjFPlXoB7rRKwvn8?=
 =?us-ascii?Q?dGjnfQ8ojLtb/Pra72vjpsyI2MHu8l8t9rzRw9/XCnHFxYvdm80lqP1RjOd2?=
 =?us-ascii?Q?4hiOVVMOcVmGclvehq546PfFDz6EeDB7IctgzwzLitFlOI3xVCUQhkRSvq8s?=
 =?us-ascii?Q?rxAghqbOj1iD5OEtRIv6u+J1wrLZe/uuNCbCSogAF7D+hxGHnWHHQLPJsFxR?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c564cdb3-e0df-41e5-1f32-08de1d8d3053
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 23:35:37.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChkaJBGSxn/vxLQ7c/TmpgWQGSvVye9aEBj+8llDWxoSSk0TB8Wop9D08+48941gFoHkXPijvFQbH02/vwnQ2jMfq2M5tfn4kCYhjVD1Nj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794

In Agilex5, the TBU (Translation Buffer Unit) can now operate in non-secure
mode, enabling Linux to utilize it through the IOMMU framework. This allows
improved memory management capabilities in non-secure environments. With
Agilex5 lifting this restriction, we are now extending the device tree
bindings to support IOMMU for the Agilex5 SVC.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v6:
	- Reinstate AllOf to avoid re-indentation on future addition to
	  the logical condition.
Changes in v6:
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
 .../bindings/firmware/intel,stratix10-svc.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
index fac1e955852e..b42cfa78b28b 100644
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
@@ -63,6 +67,17 @@ required:
   - method
   - memory-region
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - intel,agilex5-svc
+    then:
+      required:
+        - iommus
+
 additionalProperties: false
 
 examples:
-- 
2.43.7


