Return-Path: <linux-kernel+bounces-861559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C00DFBF310D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF8F64F9AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880B3321DC;
	Mon, 20 Oct 2025 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="azKrgy3b"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC5331A77;
	Mon, 20 Oct 2025 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986568; cv=fail; b=GQIdnsR8ZGjY5MziO4Ls9wkeifbuQVby3CBAw2VnswYFYNeoAC00lz5Eoa5SvqkfoO150yYhFZFCZZrRp9PpOS9+DcdlFmQasZo4vx4qWtIjMJ9TB+MwHGGx7aTmxvS+U872Xo1p2vOe8i2uhnXy3rqknK+Oq/TysXmHwNUu/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986568; c=relaxed/simple;
	bh=xwPCf0BIEo1k9nSDyRTEoUK8n3ga+b+pGD9Z0g9uvKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AN6A34D8nM5l/GknpeVmaBAnSJPJvHMQncQ7y+GF77aUSiDKjyTcmI+nKP9E7qykdZx45TMVi58HdEC7Iv22mZk3cErQIoQ8HPiYKdQSgyhFxyPyCMOvpmqGXZgN1On+qwevG0pHnopKp3kuv1gR2Gb8TPMfOdxV1oBP2qhG25g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=azKrgy3b; arc=fail smtp.client-ip=40.107.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv8H8/2sGkQzutpsAsOFPspqjU/8pKazfa3ASZZdSrvT2SoHIs1xkfuSymJxRG8MnlJYoPqMazyTFExBcJa9x2/9eRJxcfp7xrP6FuU+jrE/d7C17ImVAYpDs5bvC+Nvc6k12/sAIRREy98J6l8Vp/qmoM95hfn0NisnFXv1BJ6zJc8IBxEWPw8ZNHQzej8rmIckuRltpjBisu9mhKdtJmsxyPJ3ngxQRIYy/anNxorQVgzjh9ZFT1uJc31grONXysUZves6pXq7JyXg0xmhXbbo1Txwhu/+vBV/LOtKs2/kD22nar7Fw87RG4AFOidMyg7N6xHOZlzTOaOu6rd1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkkoMmoHMjUPWt50vjyFNzk47vMs0swawDnj4prvvdM=;
 b=sfrF9ml18oHUuP74xxaRTYyc37FPBcK2wDYMne/ZL2qJ5Lk0nZZTVhdJDAuD8VEWAfC7DPSUoSk8Avk2wNkvt9xQflmcQG4zqsKaVxu+jqLGvSR5HMGJP5gNtsBkXLML3Io4C/DrZTugmTbgQtz2nYyB/6PehoiyIdEirFpQa9rl4ZwuEtBHjhs4W5HrcSARdjK/HE8ziXQvR0x+vLJDEYC7I5Oc8q+i1eeieBq+Q3c2wC0v3YcZ2iSMwngIC3LyCtatF94OZ+6QHzBH6VhfRRU2TMu4HoIAC72B5i4ti5DLQPHSsUSp48yt7siRbCrs6Vta01oOcjds8KY3MBDU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkkoMmoHMjUPWt50vjyFNzk47vMs0swawDnj4prvvdM=;
 b=azKrgy3bgN+GaerlH3xQxb5Zow4x1sFkhhCydpjmRbi2y/PYzsrHKXj7lWrsEjkEA5iEmro92rLlU76pZzX7CQzPVkiGYJVP8X5IT+DqyabPNYeEhDKkHZIfH2K9yC68P7kuk+DzLozIRsX383LozqnYFls4EFo3zNpg6OQLbjKN6hWbcmhuoVS1t+tw2/zFzt7Sh5+XqnC1b9Qd8siMZwEk9at+BoFhmLin8JWhvyBzgl5RfB0sSgELoS7eG/md9ux5pTJyHF8Y3MdsMkxnuO89zhgSFknpIoI+fwHSFVJ7ChX2QkUmE2KF9r7egV1VceCOeRVtM0JdLuJDHbvDaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 18:55:57 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 18:55:57 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	dakr@kernel.org,
	acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
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
	joel@joelfernandes.org,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: [PATCH 5/7] gpu: nova-core: Add support for managing GSP falcon interrupts
Date: Mon, 20 Oct 2025 14:55:37 -0400
Message-Id: <20251020185539.49986-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020185539.49986-1-joelagnelf@nvidia.com>
References: <20251020185539.49986-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:408:143::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7280a5-5c2f-4764-7f10-08de100a4db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYupJ2F9gCF/kfKf+5FQMP44uzVQSxBnM5v6X75u4CPv3n414asBEH81aC9i?=
 =?us-ascii?Q?htrqZSTjp5nMlWNqyOB1NW8TLMdZVJMYQ33Ej7CzDcdGBm+1/bm+Az1ANIQ4?=
 =?us-ascii?Q?V7bbeIJWw58I/uk60emgxHILsOkZB5ejf7Uu4eSocnYX6MHaQIIe93Lk9GUj?=
 =?us-ascii?Q?etINgLyaWbHoclKfPV6QG3EfIWB+28UxVpQYVkD97Kx5yLWdX9znbMVSEMc1?=
 =?us-ascii?Q?ALHoMyor89sCT+okS9ZNeyo+rU0FK75I2MMNRFaOO7u8cgwOduJT5YdrM1D/?=
 =?us-ascii?Q?LdvaM0UXCjiley47LDUP9utMhJUlHH43ngnH6OUtQ8dhH4V0WdKEVuq6kvG6?=
 =?us-ascii?Q?WRChz0X+HecvhvEIBlb+jOGlsiC+qZ8fKleHtgvAVFx5ta6g+2uTSBu8WgCA?=
 =?us-ascii?Q?Hoq8ZKzO9W8M2WaGOVoOeHE78F774sGWbADYOx7gnQZOHjrQ3n6iNvgxQ08T?=
 =?us-ascii?Q?GAmiO60Vs0wj1z0Q/TK32WJi5lOB8tT8e3xrTtr+Khm3MWf90206YBn9hgR/?=
 =?us-ascii?Q?v4yjwghENOZiFM3e9TMQJvcKZ9huvISymJI5J6symD20YPcAj4WygHCC43Ja?=
 =?us-ascii?Q?r3lQD/0ase0w/xWBIKqf//wqCRYOd4zUDZflsHcKdSeoFNCiLVozbaubAIqd?=
 =?us-ascii?Q?le58qMfSaZy+eyCNFhH6OAPN/zNqg3ZCQUgEyCCcapJap8aU9XhtPqhz3VSm?=
 =?us-ascii?Q?r5ZHr3xpq9RkV/zImsZrJmYNeAwXj6qW7gDOk06k7zUZG0xVhQ0+0dkiI4lO?=
 =?us-ascii?Q?5YzwFLW9I9UreZZ6ZVvpX6+jSQel4n/w6AiSaJAOuYn1xspazWd6m/fk3Pzr?=
 =?us-ascii?Q?RgtOtPHpec1cRN329qlz+w0t7e9O2kKXId2pXpaIyi9i4MSPwO2hpJAw1nU5?=
 =?us-ascii?Q?anG5P3WrXIpZKr0yAyrtoovB4YdE81theXGgzNQjY5kpoxkFJjcH+jfZypZW?=
 =?us-ascii?Q?O1fWg8N5ImEqVNGuaAY6iv7DRC0vQRV3bY2mUFMTa22S1TNQQnYxJQhpZaor?=
 =?us-ascii?Q?u90X0wyTPMw7hDXXsdU9qxsKjsEhHZz1oT7StsWQbUkdYg/cAAMjx8h0PnXB?=
 =?us-ascii?Q?Q4Pz2iQ/gtLw7uh9Vzl3NvNqr2QWaz+4Aps6RxSiyFHfWN0t+K9cuf0i8LDW?=
 =?us-ascii?Q?SK2mbhDVhDPDWcfEbR3+x3hAfMRS6ne5UPvi+NwNMAWdZWf3s8dwfRvQaV3b?=
 =?us-ascii?Q?WrORcAuxVgm8Nz8xXLyQK0HiGeY9t+u8rlWM+4Wg38jBk15/u5aK/qxOXUOA?=
 =?us-ascii?Q?avXi0uq5VixD7OzE6Rj3vKVeA8gd4MMV8ElnMcfpyg+dvlYZ9k0Z5UK2rF5G?=
 =?us-ascii?Q?gsGQDqBcCZiZrjlJW3Thstr5ZO6iRT1x26ykSrAWozI7xYeT5cNm1alNuNy2?=
 =?us-ascii?Q?w2K0Xb31L5p5JbUowWekqe8VHS8Hfq3I350dIH8Bmua2PN6q4KoMO4p4oqiR?=
 =?us-ascii?Q?CYqSIkukYRIno7rDvOIBztXj294iatBM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8nQTXpU1WStyecGDxA7g/XirDRF/oFFrRLNeZSLwhef9j+zI3CniD/k9DBw?=
 =?us-ascii?Q?r9k/Xl+XT6e7w03FYEmQjWRxX2WdYPsItdm3Eodinsw0aCllH7j7I1rSYRy0?=
 =?us-ascii?Q?TuWHBCHH7XoJzIVY7glz4fFuhcxucPJe+GF8SfJhRt2CHZKxEWhLdFyTeyKE?=
 =?us-ascii?Q?3HpRfeLZZ1nzfsbETPXt+KsYt+3ztkN+WzqefvT0sqZ7Z6RdH+oZeEmvstV3?=
 =?us-ascii?Q?C/Sip/FFADKPM73K2LO0gP0tSNlguPFupxWwzopDGC3XXbw4jT6weAZxRjmJ?=
 =?us-ascii?Q?32qmJgrDu+uCInv18jFK7cB2LTcFbmnRgHMC4yZXNik5WgqwvXizGVsWqIg1?=
 =?us-ascii?Q?7lbvEG/dqygvwlLBiFB4aWA+PA5eeRCkVt7og10CUSm+bTNvAq7jCDeMUNUg?=
 =?us-ascii?Q?UaiNI+NvCxKMEhn1XlrShdsXOkeSSMutRpsRMwP7j0bYR/2o+bhVxTSikPFf?=
 =?us-ascii?Q?3G/wCsSUchbFM2d33c0ndjfe7k/CE2mCdJfFmSw7ZTJ777/2wTgDhuQ8XvoV?=
 =?us-ascii?Q?LHK6OERSki22UZX9kDCZhqiOBx8fYkcRrr1tHPov53pwJ30zOXWe0JU4Liul?=
 =?us-ascii?Q?G4Kq/UOl9zsKD/xR783tCIM7y3Ikx1z2jlr5EUigYhLJTp2HYYRIWyRGKrcQ?=
 =?us-ascii?Q?akwuGE73/zYSQCY+aPWKaMWz4ZwFTR9rWHpaj1xI1l+Fx8cb7egopavayuva?=
 =?us-ascii?Q?o4m8acz2FxQ1YLXdP1AiFaSsxgqn3NcD1Kh+ASCEQ5UjQTy1a/byVeuhlCJF?=
 =?us-ascii?Q?qzF88txMbcUQmvT4Pzap08XdTuSPlhDmOrTpRbfTigEVYyOLm3NZD23MKtG3?=
 =?us-ascii?Q?dWru+eYVQoGZTK3unlIQDnhTSjyAAMDE8UR8OHsvUzCsXeAmgut9Lf2UogS7?=
 =?us-ascii?Q?6j8ZntBHd24lv9Mm2/k3rOU1jYmKRRJJH063NTWiX88w8AseEKpvyjggqTeG?=
 =?us-ascii?Q?c5O01PNYTCOLZci9xfUbYk/LZuZ5TbVlokFWPimSgCMZxQ0vNt8lghaEGT+A?=
 =?us-ascii?Q?5ZpCHomEbyOBfwfRUXy8vPw+2g59jK1JBbQzBfF7OumyqZS8oxp0Pu+U3YDL?=
 =?us-ascii?Q?PTkkf+gTOp2H8PF3eOI0munIzOhKj5B6QlxUo0li2EfzTrP3nhVl6A83XM+h?=
 =?us-ascii?Q?73JVCvdM04UzsrvWWFdPQlqNoB+itr5WdTBbGDWllPjb9KBrTHlWYsn86kp7?=
 =?us-ascii?Q?Zw+Fnl8gWPnsHTxG3g6RqXzKPmNxzI2N+3+84IUPzRBiYSli97xB47lAdTEa?=
 =?us-ascii?Q?no0mxXAtKTikr3VoZZlN69RKew6Nv3FpVxb0/qPbJlR/uQkBZ+Vje876ON9M?=
 =?us-ascii?Q?x27I2qKgxk5TlLKxFQAAO0adXNtOR7MBKSpaZBxvqzM4KoAlrB8CPoETYfUa?=
 =?us-ascii?Q?K0OKz8zxq1oPbcBkSLc7HCkAnyOgZKflze7XyoBiFxgCyvluOK2HTF9+Re+M?=
 =?us-ascii?Q?fb4HGsG5qBnoYW+8Eso2gTBaZpIV2b97mBtTgVbv7NDNJsjeYYdsq1YzY9KI?=
 =?us-ascii?Q?NjaVE+dZ27qonQFyFQ55nuBLliMsWz5Tq3iXVL2Ep/8crpyXi32VpYMZ/e1f?=
 =?us-ascii?Q?iCLIzVsW3XrQ3qSMUNb9moeTeQgHb6Xv7S9eeztv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7280a5-5c2f-4764-7f10-08de100a4db6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 18:55:57.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWDSKDSQNwQ5p7wtvEKNpPBx26D4/CG6JepHkcmv57ri0TQAw3/salW2YlDtyHRJ9yLyCj8pmJCHWUBE7otjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

Add support for managing GSP falcon interrupts. These are required for
GSP message queue interrupt handling.

Also rename clear_swgen0_intr() to enable_msq_interrupt() for
readability.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs | 26 +++++++++++++++++++++++---
 drivers/gpu/nova-core/gpu.rs        |  2 +-
 drivers/gpu/nova-core/regs.rs       | 10 ++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index f17599cb49fa..6da63823996b 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -22,11 +22,31 @@ impl FalconEngine for Gsp {
 }
 
 impl Falcon<Gsp> {
-    /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
-    /// allow GSP to signal CPU for processing new messages in message queue.
-    pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
+    /// Enable the GSP Falcon message queue interrupt (SWGEN0 interrupt).
+    #[expect(dead_code)]
+    pub(crate) fn enable_msgq_interrupt(&self, bar: &Bar0) {
+        regs::NV_PFALCON_FALCON_IRQMASK::alter(bar, &Gsp::ID, |r| r.set_swgen0(true));
+    }
+
+    /// Check if the message queue interrupt is pending.
+    #[expect(dead_code)]
+    pub(crate) fn has_msgq_interrupt(&self, bar: &Bar0) -> bool {
+        regs::NV_PFALCON_FALCON_IRQSTAT::read(bar, &Gsp::ID).swgen0()
+    }
+
+    /// Clears the message queue interrupt to allow GSP to signal CPU
+    /// for processing new messages.
+    pub(crate) fn clear_msgq_interrupt(&self, bar: &Bar0) {
         regs::NV_PFALCON_FALCON_IRQSCLR::default()
             .set_swgen0(true)
             .write(bar, &Gsp::ID);
     }
+
+    /// Acknowledge all pending GSP interrupts.
+    #[expect(dead_code)]
+    pub(crate) fn ack_all_interrupts(&self, bar: &Bar0) {
+        // Read status and write the raw value to IRQSCLR to clear all pending interrupts.
+        let status = regs::NV_PFALCON_FALCON_IRQSTAT::read(bar, &Gsp::ID);
+        regs::NV_PFALCON_FALCON_IRQSCLR::from(u32::from(status)).write(bar, &Gsp::ID);
+    }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index af20e2daea24..fb120cf7b15d 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -216,7 +216,7 @@ pub(crate) fn new<'a>(
                 bar,
                 spec.chipset > Chipset::GA100,
             )
-            .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+            .inspect(|falcon| falcon.clear_msgq_interrupt(bar))?,
 
             sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset, bar, true)?,
 
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 206dab2e1335..a3836a01996b 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -198,6 +198,16 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
+register!(NV_PFALCON_FALCON_IRQMASK @ PFalconBase[0x00000014] {
+    4:4     halt as bool;
+    6:6     swgen0 as bool;
+});
+
+register!(NV_PFALCON_FALCON_IRQSTAT @ PFalconBase[0x00000008] {
+    4:4     halt as bool;
+    6:6     swgen0 as bool;
+});
+
 register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
     4:4     halt as bool;
     6:6     swgen0 as bool;
-- 
2.34.1


