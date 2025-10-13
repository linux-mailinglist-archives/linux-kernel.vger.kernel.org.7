Return-Path: <linux-kernel+bounces-850011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1CBD19FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18A53B943D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DA2E2851;
	Mon, 13 Oct 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fiXDGD1w"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963CA2E06EA;
	Mon, 13 Oct 2025 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336458; cv=fail; b=MGTN3f9Z6dr5UtHpSsK6Y+arxLPXplrTR8uycVE2Q/iTpLNJS1a1X7T/ass0qjNTWLEUv+0QWQT9bUYEKqpeyLQasmm7WNGzJFXlU2KJsf1UzBfRLWgnn5TgZvbY4YpTuWKPTr9swosqSxgz+/MSKX1sKO0TN+ZJsyM6UgHgKEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336458; c=relaxed/simple;
	bh=I2wUEV5qwG7vhtj9sN8ejPLgGUEPP1VgYKjIwVIljp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzDopLbIiuiYL0jvrk2MRZ8Z6IJ50KK7wxIiYBTS8jMX6gH65ZKVeazUWhI0Iu8YcxlAmcC+7jyci4jtz0FTzvSlRg1zPz42sz2rS0D2BXqVNB55oA6+rBFja5HM3hEOwXOWbtiCTGfgBuSGrR1NA/VyOQmU6+C979T0+N1SOUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fiXDGD1w; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJL1Qo42SAAuNzCdClBmmuFI49rLvSdlNeCreqV8f8jNCr8+TIVWW6WjY+x+MY1VNygsTmzKQLHobjyw9lJOT2hFySAyTZcJKY5hMt1K0xklQV4FnPNnf/Ep8cubP63fEtGKdamhMZh/hCDPzzfE7kPkjUELmTnu2WrjHOcpEpglBunmnvvZflIE+EmWuG09YTqkXEhog85orJtkPPL33F1e1YkzpyqxcNNOzR9IybLgoUNVcGQ4FCj81alIKheLRuCtyuJkg03M8FgBzyIYz+V5dUckjLGbUgnR7bsjziar3cnGzImIRm8atZIjOhprJTjnaLagpIv0b+RGOz5ZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FZJyBWca6d79asUN580Cmt9UYfxWkNoK9JHvgF7HgM=;
 b=ljTbFmnvTpQOhx6hTvW4eMFcX9sQX5qWZ3yR3bLw+QSC879CancIAl+sbX+9fdpTjqOtdHyZc8F/5MHZ23eRRm6n/hS8T7XE4W12w+eRrN14D6XAhiXnIQk/B+GfrNmPgUtIoxlKOhn2Uhovb2+BL3VtDUtWf4RmCwVilVckIStDzD+BXsCIWGmj1gKnscws1Lv5JFhIVdAbrPC3UQyJjV8HwT0no8W6BDLrGrx0GmEdCZD8RtkdQgs/SIbRoXPDhOZF0DmdBrGWsOFrRsVXOpLgNtetTmIorI4RlNQ9GyrH06b0FKL+WCyyvHEF66hoNWQo59Nbjb8Zjk43a3WPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FZJyBWca6d79asUN580Cmt9UYfxWkNoK9JHvgF7HgM=;
 b=fiXDGD1woUlYnfThq1HOxxcjmZ48sI4z/ld1K+GzKnmB+o8w/d2YY61SRErWh1+pbPf4foComhittf/A4v4bOqF0XSlq6glILGPOEQV0ZTXByQUDbaaTzoi8JsZ9dmhXCQUFFiARtjVIIthYS57YH0Ejt5ArwAK4NNykaDmC5pDF7fMfNGqaedug+A4I9bC22CJAJcv3nLt7hTOpbejhHX331kteA7aUN5csvgjbu6fnfdRsIH493MDtFrYpjxP0xwtjCOEJi0yRnIVneohTknNIVAAwY9uKLtWCYM02Rt6v+G3Vtyhlf67DmZ02wIweS5k028eacCYHtgp6o5SDTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 06:20:52 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:20:52 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dakr@kernel.org,
	acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH v5 01/14] gpu: nova-core: Set correct DMA mask
Date: Mon, 13 Oct 2025 17:20:27 +1100
Message-ID: <20251013062041.1639529-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013062041.1639529-1-apopple@nvidia.com>
References: <20251013062041.1639529-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0119.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: e82e202e-2d21-41af-30c1-08de0a20a8a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8EJve2tP5+ugfP0rcwVyV6Oy8+035r8p6PcvNzEo2OVV2fYH8VYBGgfSIpy?=
 =?us-ascii?Q?8eH+GcWIywpZQdrt6BsVyH7f0jVVWYFHoqxFOfMb5pw+gy90nJExiA2lbNy8?=
 =?us-ascii?Q?pXSiRSSCubZWlc0eJYzqmZE5N1dvoKjzC5SNEGfs9VvRjrKkj1WFvzxh76/G?=
 =?us-ascii?Q?ZxYUBmbHTaTlGjUAuV9cjCR9/0bycUA+vrtRWIs0X7xv5XJ/bStWoFaG+1Qt?=
 =?us-ascii?Q?SC747X9tuLK1Bym64rAsQvNCVj2cca0VZ6XDCCJVDZd2Valv2oYGQiP8aGZ6?=
 =?us-ascii?Q?jCxNm14mlBy9Z/Jl5fKFK6YtTwOpXbbs65yXSHTlNYwm8smFKm8l2N2DmkZf?=
 =?us-ascii?Q?ttst5KwC0vGGfUHYBD9fvv7NAmR8M0hfufQXjY3h2TFrM3mxw913i/fNtzXK?=
 =?us-ascii?Q?WyZkyy4dlVXwkMR0lLj1e0v8EH3HmCPl1mQC7nmAh5e33A8pnXICaYCtQFCE?=
 =?us-ascii?Q?9mSw/azOTz+dJiRGqDIkB3RxIt+Goxc4MpcmEX54wkEg4G8bggfB8lDlp3RB?=
 =?us-ascii?Q?pSzskgnN0uWlgqCcG2q1zK9sgbHi143+Bm59fSiVv5Od4Ymys1/44OL+SVpe?=
 =?us-ascii?Q?zfaiGFHob0WB399hxQt8Vv2XR0Cb1RDtV3YmKJIgzEqOfiNeJdYq2vMSf2w0?=
 =?us-ascii?Q?qsSyN5BlNomRRl4uUn38/tz59HD4x5ObpgiL1C6QQvcapjxNzCg11BcquWEs?=
 =?us-ascii?Q?1FZHBOG+NMis2l4EahabvKi3lkYEBuiw/KeA2A6fPJFlkrCVm07yqXYlot+2?=
 =?us-ascii?Q?5J3q47K9s5X8FZyY48XStWugGIm3xUNjluax2BjNQX5VDDKtkYdWLEo7ncew?=
 =?us-ascii?Q?Ow/RIMJYnAPegHfuS9QdPh7TTDBY5Fzo0Fe5u/NKT6cV0LlyDHTL1lTrzfYt?=
 =?us-ascii?Q?dGlqK6phCWHZTlTvj4f01/FlxJ/XPyCZHf+MK2F4p69FVv0DL7mejdT6438f?=
 =?us-ascii?Q?HBBdk/hrzcfWztAlT7BIjz842k6U7WtSrUGgTNJ13R1fFFLKZsvscGk+Ejo6?=
 =?us-ascii?Q?GP6VD4vVVPwDjKPfKLLOckCHBSixLcvCaxBqydnE/jr3TkHHMLpz1CXZvWFm?=
 =?us-ascii?Q?lwTuAO3lbRkA10AxDTBIoTHd++jMjakRFd0CivqopOsg68yFEIEjwnaLE/TO?=
 =?us-ascii?Q?kTk9rhGMUaQy+sqAADDgomRvQmZX9Dkw8al5EP6x+IxDVJQraPJNHNWcbbRB?=
 =?us-ascii?Q?xNev5v8Gq//DC6NB6SwOK7pTxYI+7O9gLoX7Nw2U9vNkjPHL9w6wifMrBLhS?=
 =?us-ascii?Q?czuEnUHFiuFBJOl1b/hwQH/6EQ4t75wD16SmIT6ZtQ1EZu2D0zcEhdhUV7cE?=
 =?us-ascii?Q?4OvgKctDr77fRYI+GR+77HEMV0VyyO6T0t5zFi4Hkz21hiGO51MBPm0G0QOo?=
 =?us-ascii?Q?RieLWy8EuUaFLul0FoeLN65rSD7S5p3Ql56CeRsZH/2buAg8yuDIiS17yje0?=
 =?us-ascii?Q?n/liP9m9YlL8XNjCI/tcK+DF2cnzbtbv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLLq1u4+HFOntwLGo9Wiu8vpiHxGJkLSbLp+iSfgUnMUMeYejETHsoudNrCm?=
 =?us-ascii?Q?pbsDEpkn16NGl5gG1JARhH5RNvnsaZgTxgQgVlYvwO40nIZVI8w6kgK1MyOV?=
 =?us-ascii?Q?ioonXzf0WQbWK/E7CMEPsad8EhhjXx/Nwq+bUDyon84Q2rVydhoXdBjZUW66?=
 =?us-ascii?Q?cFNOJvHK9VedtUflyZOE/BfiOIYQOa4MQ39hKVXejROyoWXhZm93cwNeNeo/?=
 =?us-ascii?Q?vyU0N8h8V6pW1uppXWCvJh4vhGDZejGp2Ie3X+D5phrfAB+D3ATTPIRY4LF+?=
 =?us-ascii?Q?1BGZwLRE0/20TdYpziwZQ3RY8lq8Me3q2JNxKzxisdzrnX+XnwiOOnYb7UQk?=
 =?us-ascii?Q?w2Q+ueAPjmhkp/A0qk7kgy7QRm0PgHJjRc8nTs9eSnPC1mcSIv16sBifzMyj?=
 =?us-ascii?Q?WX5/DbyG4/riLU64U9VqzKaMJNN74d2oNDgtEnshISf710lEy3x3WIuVMmWG?=
 =?us-ascii?Q?QwCh9lHg7PP5UYmuzuyRsSM0M+isNsGkgfadXI19jYE811x2MtjW7XZ3FQ10?=
 =?us-ascii?Q?y1GKZaG4h3dSF7PaMm0CplmUwbYiSElA7wr7sRLiiHUJ9fR9mgg6uglLoDu6?=
 =?us-ascii?Q?ALOH2Wut8gywimjD7XWENPcb3nq/rMKTJHdNr4A4+wxP8s9VliNy1upEHu6s?=
 =?us-ascii?Q?Ppytt+mrBqvmi89GlttHo74RJHb1B/jpHKQ8F1Uc/5GtMFW4moHAQTKn8pt7?=
 =?us-ascii?Q?W5wjUY7rt+IcK0+lVkz6NEeGFLnQjY4iKjoKreIR7cLdfux85XjLgMZ1Ty/y?=
 =?us-ascii?Q?54T6fYKPW9F/g8UXAUSv8T2CHRvhxzdXlHJRujNK78Nbml5XSbH5RM/vAfnc?=
 =?us-ascii?Q?vAouK/O3Uy3KDKElnW2RFI7+8NOeiRFioeatIly1t76rvxr8CPnN9urI4qef?=
 =?us-ascii?Q?i3FE6PR/GAcywgkXWtKuPXN26Dgg6SR+WXnq2eHWxM+TD57NO+aXOCb2O2e0?=
 =?us-ascii?Q?3Ubwgqj8pziGi18jGubOKcCOIqCXFwd0LBTLsrmz8P4TAMUsdR0LjqKbX4dv?=
 =?us-ascii?Q?GyRBby8MRiRid7Q8JstqcbND4FsTnPiIH6kwh/5XrR2+kBnupUp+FdAdrPGj?=
 =?us-ascii?Q?Uq8xgqIO5QmsDmDulCo7d1OdF6xiJVunNa/34o4T2hHTjMc2fS4ssisqz0Y3?=
 =?us-ascii?Q?/3/oQzscEcyAKEVcEZJdU3Sp0EgfW88/TAb0U2l8w2wboN7FRU09qlG/ReJx?=
 =?us-ascii?Q?XWb4SKDkzqTmtNO1gtAOgjnaLHUIPltkZqjOTwdiGzxVIP8EHIofMKgkd05f?=
 =?us-ascii?Q?R0Hc3Ab2/jgCbXqPZDVXJo+z+kefF1C/WDYfOfgbY/jG8+mNLHHIGpgsjuGn?=
 =?us-ascii?Q?CeNx8lDzvQ+vBA37Ho1LIqzZaOQIq883QDir2KyPd42K9zVe/oXvJRFwneDO?=
 =?us-ascii?Q?6wmTHEWd8SCKf3yNKd//+6vIYJ+r7eAIXEgtnW32e+Y39n6RutAod1wgjCKk?=
 =?us-ascii?Q?gN3yO3IjuuOOpzjY2eN1rlW5zbVhaVpU87bi6sr2o9VkjXllXIFKmuoX9+PA?=
 =?us-ascii?Q?8gpVpPfD54soox+P2L4V0rHS7z/mk19to+RBevPzxzc8rXz4TM3XsFTVJU+t?=
 =?us-ascii?Q?wrRNU9ybSasE1PATblnxqYe3J9pMHV3Y8msVqknd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82e202e-2d21-41af-30c1-08de0a20a8a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:20:51.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVQh07iSk5CGglUnQbLUtY2LV0eRKLBzHT0SQ2HjOPqP1QKVnDuQMLmkt6cki4LWNuT/o1mOa+0PO83p3RggHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406

Set the correct DMA mask. Without this DMA will fail on some setups.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v5:
 - Update SAFETY comment for dma_set_mask_and_coherent()
 - Add TODO for using different masks when we support more GPU models

Changes for v4:
 - Use a const (GPU_DMA_BITS) instead of a magic number

Changes for v2:
 - Update DMA mask to correct value for Ampere/Turing (47 bits)
---
 drivers/gpu/nova-core/driver.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index edc72052e27a..2407d0ab15e2 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -3,6 +3,8 @@
 use kernel::{
     auxiliary, c_str,
     device::Core,
+    dma::Device,
+    dma::DmaMask,
     pci,
     pci::{Class, ClassMask, Vendor},
     prelude::*,
@@ -20,6 +22,15 @@ pub(crate) struct NovaCore {
 }
 
 const BAR0_SIZE: usize = SZ_16M;
+
+// For now we only support Ampere which can use up to 47-bit DMA addresses.
+//
+// TODO: Add an abstraction for this to support newer GPUs which may support
+// larger DMA addresses. Limiting these GPUs to smaller address widths won't
+// have any adverse affects, unless installed on systems which require larger
+// DMA addresses. These systems should be quite rare.
+const GPU_DMA_BITS: u32 = 47;
+
 pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
 
 kernel::pci_device_table!(
@@ -57,6 +68,11 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         pdev.enable_device_mem()?;
         pdev.set_master();
 
+        // SAFETY: No concurrent DMA allocations or mappings can be made because
+        // the device is still being probed and therefore isn't being used by
+        // other threads of execution.
+        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA_BITS>())? };
+
         let devres_bar = Arc::pin_init(
             pdev.iomap_region_sized::<BAR0_SIZE>(0, c_str!("nova-core/bar0")),
             GFP_KERNEL,
-- 
2.50.1


