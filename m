Return-Path: <linux-kernel+bounces-783656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077EB33049
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A90160D91
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A52DE6F5;
	Sun, 24 Aug 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrxBWRfc"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6420F2DA77B
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756044017; cv=fail; b=IMUYRCQSUULubZDdB4fgVbF/oSMnojTaTVCbnZKm55rhIHhqSokZB05qpRzomYWhzGHhFLzU4etFgdSQO/Az3iy1SDyiG9YXdV3V1ioPjvYeL74WsDmgNl7yVIQSh+a/LVm2jnCcA5nxIF5op3AQ1J2Czo13SfLxhCU9C/YFGF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756044017; c=relaxed/simple;
	bh=v0cD+g+2XUK1eKZslV8nqe64/XUHBj4F9IzXwvVVe/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c7OSdu1uJOrwxSeyZhXBWE+n/DzV/1g/Pe2otTpWpoO/e9aG9iNN+3TuwMRU2i57Nn5uqRWj3Ph5T8PVTrMBgP/hJEZ8bQlpy1fujDLQBJtCUdIbFSESYytkLEj9LzsnrDb7bmQtjURPXRaY5IszrchSLr0XFCZcMvNuRDC4yuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrxBWRfc; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNU14o418Pyi56DmvKapGZiF8eB6G1Pw6D79pyXBiZLbC3t+0YL5wJCwAuVjzR6+JramIasb/bPgEDrd7Q9OB9cWp02D5MQXPYaxmonrKzIU7AatR+/DQa0dxL2exwYGHMLNrmfAg8JXt/LO9KfKbYomVvq6v4aBhpGBUuJoKe5Wkxaz1pL6u8TvdKmfYnXD11CXYDe5076KvORkvcch0+zQ3XVrcahBClFe3xbqjjXkRYBybRsCTi1GpGTXxMtSJ/OczcydzNriMe+ZH9qDu5lyxl8VvgeggQ4cj2W930ei6mXJVF6cPsWzfmiGAFwbUKBg7vPnN5tVRduWk/h9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv1NqhIMtl8sX7i8vDm/uHPwUoaUG6yFxAfzZWPecec=;
 b=raSXaqsDqVS7Bjl3VypnZsIcSjfD+w+Bcu+dAb23Kp7UtoND+1xUe2lj4GzoNKtsISgUVG4Qt0TUeOgzr7EHH1NyPQSsjbLnIGo7dyLG996zHyuiWLMPOJwUbUkOK5ecG5HHmGCwaDIIcm43Uxt31MP5NMWk+AQxzkRGiKRXIsOuG/9T6fJU1zvUBQy3VDOHpbLAciIfBl+J5dnjZgvalPy9DwrZOTeFKIjvCTYIjvD557GihGvYQRwLO5iujMTKGFg6qTnwhw/0MU9hiGQz8ysYPzvvtwq1/goBpqNP6rvIrhA6AdIBEIbTgTHVMvTFClXsQMMv7lzgS5PxVE1REg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv1NqhIMtl8sX7i8vDm/uHPwUoaUG6yFxAfzZWPecec=;
 b=mrxBWRfc9txlMHzIEhdLc4zyBG8XCT8GN+aldYbuB4T1Q8tdYPesXU9cAo4e2hcz1YyPI1tmBfQHXh8t7VH0VZ8B843utzwE4jXShBUOrVgKSVk0qdYHlLtDTplSpWXjRo87UH+ZfXff8Am/br0PdlwHxSwH+NtgmDrKUju5eC8cDDUReJEbWBSeN3UX2Z7L/8YjxNDQFX1GctdhMxgVQWzlI/0hl6se31fsQ755ztNChgS9/9KAEn14Iy1stHWEnSWdgsKwsyaBIb+rJdh/fgZhH62sQiNgez+Ec5H8WSXGdsSryCyLCy0PSSjZi7gumRXvCsUShY1GRJa3QlYWng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 14:00:10 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9052.017; Sun, 24 Aug 2025
 14:00:10 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] nova-core: Add KUNIT tests for bitstruct
Date: Sun, 24 Aug 2025 09:59:53 -0400
Message-Id: <20250824135954.2243774-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824135954.2243774-1-joelagnelf@nvidia.com>
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:408:80::42) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 52935c02-b53b-40c6-5588-08dde3168a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pkokDVH+XhJV7051HUDw/6kvT+UccJdpo9rxQJbOGeEOzSrAlNpG11OPEa/C?=
 =?us-ascii?Q?B8EGywxJqmDjvvK6axwdTd46mGjGOGXwPmnN0QOP4aPHrmH3f3O6y5X4s8ID?=
 =?us-ascii?Q?vleeTfS/g0ReadJKaOzqvUcUQJYSK3RpvF0FHrJjwvz8q//D0lcYRXSHF5zn?=
 =?us-ascii?Q?P9KzLBkh2eXW9QzjA/YcJODEHADuhZTNtOLjLXBPr3RsuplQPLOWYMSfCRkd?=
 =?us-ascii?Q?VR/PNQRO1YW6aS2HV0Hh5l/fmyOqLqaQGFVuUQzCxzMuRENNlmifLTffPJ7G?=
 =?us-ascii?Q?G59zU0ftRPN4JOM6CCXxIEoRTnCaw/pIeAS5gzX3Oj7vzj/Ayi5QRW/2ZmNh?=
 =?us-ascii?Q?fqD80tEc7X92qHXSOThzr2kLrxwsg/1iBgFeA2vQJJeBlbxiraLbbuIIztrn?=
 =?us-ascii?Q?RbUDHXBMl+nlfneMmYSA+WLKnXLMf6GLgazBJXf69gvaq1E11Rh6hbUF55XE?=
 =?us-ascii?Q?3hZhGby5ml+F2GKQ6iNhsebFgn0we/2/fzl/p2lPoO8QM5EEOHWbCGsr5qP3?=
 =?us-ascii?Q?8M8IcGoX3YeFceI9tXGUTrIIOnfh6rk9UKHUGsEqJn8suSxxbLZwivhPh34P?=
 =?us-ascii?Q?cedO/NRWB4bosEp4/gd63wxLXdqSqYi6rEtA9Igl0qdKQabgQT2xhGaPzi95?=
 =?us-ascii?Q?Ti+swJQgAUUJTY/BUSlvpc2gEij016C4bQXD9cauBCdqCncfHuCG3BkZnkEv?=
 =?us-ascii?Q?Qc7sNiGI3EKbFnvkNPwe9i713QWzVSHVdFZ1z9+bjUWgCQQmYEjvAm50fzq2?=
 =?us-ascii?Q?wqrlw9cupjzFpOhince6i4Aw/asdHs/gMXy42VN83JTfDKoy2vfejmX9rwcV?=
 =?us-ascii?Q?3x/PKNfqUX7MDCgAaEvM+40NcsXVw+zRUqo0yQc9cqIsHF2A89dK4DSKk3qO?=
 =?us-ascii?Q?q8ksBc5xyFMHGE0T0WbuvTGlzUYYto2rJf3ZjSdv4Fph1rnZao+NoSgkFHln?=
 =?us-ascii?Q?Byfp1R2q1/oDHomt0/CkKFaURETdKsQYXA/iFV38yEvZWWO+CQhiMaMR4kS1?=
 =?us-ascii?Q?vC8yIedvsXQYU+F2iYd1HrLZlK95HvGZE0uhHZ4wkSlbvFm02s3I0s5QNKUx?=
 =?us-ascii?Q?ynAjpuZlu/D84zFqjn1F6GBqBouO8BzX4UAJaNgmTgx5oubQ/joKCiwnf8TD?=
 =?us-ascii?Q?OTtZm4nUjhz+PNGeMf1lbI3RAOSME7pBNQC1ikxn4Gqdk0yjHYvY/f41+VGR?=
 =?us-ascii?Q?KTbS+L669fGNk3e4XYZtH1vMusMYBENH3xtWCgz6NHu+sC7E3VHwOOmXTVPQ?=
 =?us-ascii?Q?WvlpTZrcK1O3bg8UlXklRU7FxxRl8hd58YnvOpdpI3qHC8PFtR2gtB83Ubrg?=
 =?us-ascii?Q?s+2/LWBz0HJGjOJAlHdykfmanNjQ+tVcNArT5mG45RAwCKNDYOVv2BWO5aLK?=
 =?us-ascii?Q?vqzZiNtLgvSQYZnDA1+o/+42ZCZQvQs2FyPUOg8bf9jFQ3rZRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FsfaB0mJMWD3UgqKxNM79W0v8ULByT9A+goekcqcbJrvvJxUgcbdFUg+mgon?=
 =?us-ascii?Q?nMYIImVjdLHf53pz5cbw4GfsU4wJYzUhUOpLdNcToL5BTyYbkZBp0CJOF1DT?=
 =?us-ascii?Q?opkbnVWUH9FgOLvBVi22Vvtjz2nIltwTema0SEwbfVAq93ZXiUAxmDNqIvcR?=
 =?us-ascii?Q?rVJuc+hsEp2t2opC/pYHWx7zT2z6bN5gAGTtHn04lRqFVPzdYFwje0yDp//D?=
 =?us-ascii?Q?AkKa0BqbpjLqZGtSVH/GR0vX/lv4xb27N+SoWlLuBoCCHTbUEAv+4M8+cYdU?=
 =?us-ascii?Q?1FnN7WWXxaKL+UgAcOCswfSQ3GJsxOG7ryy58mprGBOb2q6653UavmykhVwH?=
 =?us-ascii?Q?hKl+EO9endiwkkayTiL7HSdsZzyyW2j+gGfPM988Ju3HKEnX5BkZMvD9KpTA?=
 =?us-ascii?Q?KKzTpCA59q2sG4G96jBCgI0QDNX0oyKRwJMMdJVjEkcmMzGRF84hkVnI2y/E?=
 =?us-ascii?Q?ghRSNEjEhvv6U0jHSpl7LxML2Dn9l9F2SnZ2FOhMwF1NBivcyz5okl++/n8d?=
 =?us-ascii?Q?pwDRWLCZt7MqluKitJke48UuWRlwvgyKTAUBV+bBe5tH42ifErRuFWgpOBxk?=
 =?us-ascii?Q?3pMj17BRuE6rSVFF1YCm29IYKPogODkS1qig0KoFzx7FF0mhsK0tsBKdSgK+?=
 =?us-ascii?Q?iX8HBUWjjvL266m9SrWBVB2zEzRqqdptEiqLZG28+kwkYvqVxfzIeJZg2WD6?=
 =?us-ascii?Q?LIAnHPDmvF+p2CKIPURhVmWSYyeymjf0OCiEgZH4Ww40bZTkY22QcQ4vf28v?=
 =?us-ascii?Q?mQmCo2b86wqA96JY55cM6y4F9NXnA/wf87WRjAfgqoFv0gPd/Q5ZxnRyTBTS?=
 =?us-ascii?Q?NeU/ufRhUi0KNxYgBrXh4o+3SLU5RdzmB/8Z2hQyuJsqp9WGrRefz7BsIrn1?=
 =?us-ascii?Q?K2b2o0fQ/FRnEp8Vd74spLZu1frr35ICRYbbHlGczeayADjTTkLYf85zjTyO?=
 =?us-ascii?Q?2r82fmA9Sdr2hMrcV4Nk1qqIoHCX8E4/TyK3xkWClYI98oOekzjeDQpycrYq?=
 =?us-ascii?Q?Zy76MYyRJSfkKdGUI1jerK/5abpQ/RdEAmLw5zhTvYXpFudxW9jyH+0hZu55?=
 =?us-ascii?Q?FQ5xMNIz7Gupq+VLWXuWYBIDX2fCvDkvsePBP/3yGeiWZAwEvF/tl0wlOfc5?=
 =?us-ascii?Q?0e3IuZp8pQtk0ZhySn/j502PeeJvkTFwZ1D482ghVntrAX+x0H8D1L0TCCyz?=
 =?us-ascii?Q?jWiPkJiip4efAFGwiU3+tJaV3yofWXsUmBE8h7wLMfKNTpZ5zGfxMmLYbG/l?=
 =?us-ascii?Q?hqr+Mx0c3qMx+5dWG9kUa+UglzHw7Q8MDs/QxOSLniXCXsfwteb1szkn4H0b?=
 =?us-ascii?Q?zhXWEGE30z41rULVjdptb7EXuI56k4zFM8f0ksyyTAd5pCwrEclPYvbmASte?=
 =?us-ascii?Q?h8zbtMlEtPSdnWrtEaDusWjD/exdOUPKseeu0wavnc/b8T/WDjQVo7STZm59?=
 =?us-ascii?Q?PrZErO1tCUv4QDOs+65VIIo33TqVMf41mFKVuhHiSNr7lTSBLRKD6a/xuBzJ?=
 =?us-ascii?Q?wPLCFITxLpVgsKA2rJFlIFRe7K4iKB7zgSRt+l9usdVQLoFJaVdbJaqqYxtz?=
 =?us-ascii?Q?r9ErDhKA2+Lm0ahQ+k0uzYt1wbIBub3rJWG+tU/L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52935c02-b53b-40c6-5588-08dde3168a0d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 14:00:10.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iHhQJqZX6rZ80sQ7pEmK2wwLME1a4LsLhjHxw/AHCgcu6AQMGWmDH1aMMIM7Gat1+jwvnyoDGLnIaKSmw+7kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

Add KUNIT tests to make sure the macros are working correctly.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/bitstruct.rs | 198 +++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/gpu/nova-core/bitstruct.rs b/drivers/gpu/nova-core/bitstruct.rs
index 661a75da0a9c..7ce2f4ecfbba 100644
--- a/drivers/gpu/nova-core/bitstruct.rs
+++ b/drivers/gpu/nova-core/bitstruct.rs
@@ -147,3 +147,201 @@ impl $struct_name {
         }
     };
 }
+
+#[kunit_tests(nova_core_bitstruct)]
+mod kunit_tests {
+    // These are dummy structures just for testing (not real hardware).
+    bitstruct! {
+        #[repr(u64)]
+        struct TestPageTableEntry {
+            0:0       present     as bool,
+            1:1       writable    as bool,
+            11:9      available   as u8,
+            51:12     pfn         as u64,
+            61:52     available2  as u16,
+        }
+    }
+
+    bitstruct! {
+        #[repr(u16)]
+        struct TestControlRegister {
+            0:0       enable      as bool,
+            3:1       mode        as u8,
+            7:4       priority    as u8,
+            15:8      channel     as u8,
+        }
+    }
+
+    bitstruct! {
+        #[repr(u8)]
+        struct TestStatusRegister {
+            0:0       ready       as bool,
+            1:1       error       as bool,
+            3:2       state       as u8,
+            7:4       reserved    as u8,
+        }
+    }
+
+    #[test]
+    fn test_single_bits() {
+        let mut pte = TestPageTableEntry::default();
+
+        // Test initial state of boolean fields - expected false
+        assert!(!pte.present());
+        assert!(!pte.writable());
+
+        pte.set_present(true);
+        assert!(pte.present());
+
+        pte.set_writable(true);
+        assert!(pte.writable());
+
+        pte.set_writable(false);
+        assert!(!pte.writable());
+
+        // Test available field (3 bits)
+        assert_eq!(pte.available(), 0);
+        pte.set_available(0x5);
+        assert_eq!(pte.available(), 0x5);
+    }
+
+    #[test]
+    fn test_range_fields() {
+        let mut pte = TestPageTableEntry::default();
+
+        pte.set_pfn(0x123456);
+        assert_eq!(pte.pfn(), 0x123456);
+
+        pte.set_available(0x7);
+        assert_eq!(pte.available(), 0x7);
+
+        pte.set_available2(0x3FF);
+        assert_eq!(pte.available2(), 0x3FF);
+
+        let max_pfn = (1u64 << 40) - 1; // 40 bits for pfn
+        pte.set_pfn(max_pfn);
+        assert_eq!(pte.pfn(), max_pfn);
+    }
+
+    #[test]
+    fn test_builder_pattern() {
+        let pte = TestPageTableEntry::default()
+            .with_present(true)
+            .with_writable(true)
+            .with_available(0x7)
+            .with_pfn(0xABCDEF)
+            .with_available2(0x3FF);
+
+        assert!(pte.present());
+        assert!(pte.writable());
+        assert_eq!(pte.available(), 0x7);
+        assert_eq!(pte.pfn(), 0xABCDEF);
+        assert_eq!(pte.available2(), 0x3FF);
+    }
+
+    #[test]
+    fn test_raw_operations() {
+        let raw_value = 0x3FF0000000123E03u64;
+        let pte = TestPageTableEntry::from_raw(raw_value);
+        assert_eq!(pte.into_raw(), raw_value);
+
+        assert!(pte.present()); // bit 0
+        assert!(pte.writable()); // bit 1
+        assert_eq!(pte.available(), 0x7); // bits 9-11: 0xE00 >> 9 = 0x7
+        assert_eq!(pte.pfn(), 0x123); // bits 12-51: 0x123 << 12
+        assert_eq!(pte.available2(), 0x3FF); // bits 52-61: 0x3FF << 52
+    }
+
+    #[test]
+    fn test_u16_bitstruct() {
+        let mut ctrl = TestControlRegister::default();
+
+        // Test initial state
+        assert!(!ctrl.enable());
+        assert_eq!(ctrl.mode(), 0);
+        assert_eq!(ctrl.priority(), 0);
+        assert_eq!(ctrl.channel(), 0);
+
+        ctrl.set_enable(true);
+        assert!(ctrl.enable());
+
+        ctrl.set_mode(0x5);
+        assert_eq!(ctrl.mode(), 0x5);
+
+        ctrl.set_priority(0xF);
+        assert_eq!(ctrl.priority(), 0xF);
+
+        ctrl.set_channel(0xAB);
+        assert_eq!(ctrl.channel(), 0xAB);
+
+        // Test u16 builder pattern
+        let ctrl2 = TestControlRegister::default()
+            .with_enable(true)
+            .with_mode(0x3)
+            .with_priority(0x8)
+            .with_channel(0x42);
+
+        assert!(ctrl2.enable());
+        assert_eq!(ctrl2.mode(), 0x3);
+        assert_eq!(ctrl2.priority(), 0x8);
+        assert_eq!(ctrl2.channel(), 0x42);
+
+        // Test u16 raw operations
+        let raw_value: u16 = 0x4281;
+        let ctrl3 = TestControlRegister::from_raw(raw_value);
+        assert_eq!(ctrl3.into_raw(), raw_value);
+        assert!(ctrl3.enable());
+        assert_eq!(ctrl3.priority(), 0x8);
+        assert_eq!(ctrl3.channel(), 0x42);
+    }
+
+    #[test]
+    fn test_u8_bitstruct() {
+        let mut status = TestStatusRegister::default();
+
+        // Test initial state
+        assert!(!status.ready());
+        assert!(!status.error());
+        assert_eq!(status.state(), 0);
+        assert_eq!(status.reserved(), 0);
+
+        status.set_ready(true);
+        assert!(status.ready());
+
+        status.set_error(true);
+        assert!(status.error());
+
+        status.set_state(0x3);
+        assert_eq!(status.state(), 0x3);
+
+        status.set_reserved(0xA);
+        assert_eq!(status.reserved(), 0xA);
+
+        // Test u8 builder pattern
+        let status2 = TestStatusRegister::default()
+            .with_ready(true)
+            .with_state(0x2)
+            .with_reserved(0x5);
+
+        assert!(status2.ready());
+        assert!(!status2.error());
+        assert_eq!(status2.state(), 0x2);
+        assert_eq!(status2.reserved(), 0x5);
+
+        // Test u8 raw operations
+        let raw_value: u8 = 0x59;
+        let status3 = TestStatusRegister::from_raw(raw_value);
+        assert_eq!(status3.into_raw(), raw_value);
+        assert!(status3.ready());
+        assert!(!status3.error());
+        assert_eq!(status3.state(), 0x2);
+        assert_eq!(status3.reserved(), 0x5);
+
+        // Test max raw value - all bits set
+        let status4 = TestStatusRegister::from_raw(0xFF);
+        assert!(status4.ready());
+        assert!(status4.error());
+        assert_eq!(status4.state(), 0x3);
+        assert_eq!(status4.reserved(), 0xF);
+    }
+}
-- 
2.34.1


