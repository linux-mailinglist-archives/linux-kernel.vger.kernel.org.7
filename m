Return-Path: <linux-kernel+bounces-898439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B4097C554E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98BA134488C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B492C3259;
	Thu, 13 Nov 2025 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEYCVXG/"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884C2BFC7B;
	Thu, 13 Nov 2025 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998097; cv=fail; b=kmr85WPQ3IYTGgmv2gadIr3XURcmEWfe/gOjxX/5CHN+8WwRywTRCGtzCx0JMieIR6aKHq4Ose5ozeHr8801XoTuzXBMcUJhUh0/3RDpFXuYqtgMs2/hJ+LdZAus09xuKHr5b7UYnQ7R8p+kXwOl9Vd8Krn/fkwzizV+r6o05FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998097; c=relaxed/simple;
	bh=Cb5G+LAmQ/UQC+8VUgFRklKopTNHVYzq4t5C5Zq40Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5JEQl/hGxASwCmi8OoNyi0cQkL6P+ciH6+9MGwhgokHzXdUAoWzXV5YbrMFKuQpE2fYmnv4HWdzwcOLPU698Svqcx3Wsc0aNMymIIUYY3dAVTkLEmuhm+hoJnpytMeZmtSZshGksFKDxQyR2dcJaNhT2I8XmN9KYMcUYE1vlfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEYCVXG/; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qd2fqHVJ/K6x1OEljSrX233d45WvTZGs4uLPKMO0z231Bwui5GX6uo98xl0EJ2ru0VLq7FFqV/JQv0qdtHzriqHMTmMRxFbyIaYfUjWCm5yNbMHBa4FiI572V/P+LRTPVlz1GTrwcR3bOUSp/9VAt+kMuC8vZa5ZKiTxFYXXj3rMxwQ4BCmfxLcLyrZ5WN6DEysuVmRB6rrJWZoaCQTgPnv+vxSlFAt3souGwoECt35i38kEKJ+4pen5SkmiD81GeD8hXii0VfCnHWUWoIhyYA8rNyTweFcKlLO+96h/eyC3XJEzDWfI6oQ93RCuAqqiOmyOMKuTKlS32WB+lQmEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TguzUso4/U46nef4p/COrF1bhFUDyd+2t6kEYKT5xBU=;
 b=IebaQIsqYvc9bNM1/bIHJmakpyirRGx1YM+nLaBxr7XltwPs1dW+akAuSOXx8yKQbMdhCXEwBBw56JAtOVkQbpIC2ZvoDZGpODciRXFdRl8RsFr/y6RC5Rcua7ZIU1u3zPcKVY1vvA+mtV+oEn9vdH/Cw8UfhHluNDvaFOPBg8yAZMfmbmQnpZf+zGvwR5SpcnTgeTLzmBIO7S68wSarWMGT4peSZs/Zd0b2rYXrxi3oqgJgknFqcdEfqaWtZAeZH5O0VxUJ5++d8OFxv0NegazubLX8MBKLXFNoURZp4AG0criksIjEB+MHvrcJ/9Wex5b4bbj+wRmYL6GXvOXMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TguzUso4/U46nef4p/COrF1bhFUDyd+2t6kEYKT5xBU=;
 b=BEYCVXG/8I4T7mCdkDg6XPJswA+tYGsNmE5c5Z3E9YjtCt5wjekrkpHxX6EPk9BehZnkgtTEdiVxyvBFsB2Po+n03ytmu3HdjY5J+NDXFO5agKabmlWUYW7GJqhYyeFI8Bw5mNwJdGZNX/FydX2bQZvD4DwqrLYv8AQKptghgooX5TJi93+1gb1BLdXNoX4sIUxn8Uo11jRp5PkH09piLbQQWr2oveKwPSOR3uOtsY0wMsNjzFhZnDtYy1/TPDnqVi42aj1i50cGuy0+VVBuY6oTcgC5CXqnkXHIQ9LILlaqcw3S3VKvpL6Y9IiP907MYO7Y/nZ99oOo6Uq/MXm0iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:41:31 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:41:31 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>
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
	Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Lyude Paul <lyude@redhat.com>
Subject: [PATCH v4 05/13] gpu: nova-core: gsp: Add support for checking if GSP reloaded
Date: Wed, 12 Nov 2025 20:41:11 -0500
Message-Id: <20251113014119.1286886-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113014119.1286886-1-joelagnelf@nvidia.com>
References: <20251113014119.1286886-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:208:52d::25) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: e6026602-369f-4410-b48f-08de2255c534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOLz9NolPG6OMpB3C1o8GXig8ZZm2Hy/7NXYK4rfIYrYlondqvVXOC8dDkoJ?=
 =?us-ascii?Q?ExjzdEFgJ/Sq+lpX2YNgA3AA2g4tNyVJWbvjmnHjKgEJG6qU1muClv9tIWkZ?=
 =?us-ascii?Q?ffSH6OwGAncbCXmePKYdcUCLn42BAozRdA4axyTI6Squc2A5Sc2Ez/QJUeJp?=
 =?us-ascii?Q?YcOi5jPngq9qi+570gOUcaz7u/afJ+HtGt+G0uFXMJLjlJbxgwgiIvmFJF3o?=
 =?us-ascii?Q?NzZjEtLUPEw7m5QalUJ1KUSsdKgW9Unah6/kGJ5glISbabmvz9EbJ7EX/FOL?=
 =?us-ascii?Q?H1Zxktxazzs86VeEv0T8fQ8juRs9XCO8l3G0zm79IN/nL/6atI86Q4qerOJw?=
 =?us-ascii?Q?JiaP7lgMO00NOx5h5PsUDVSHRUmMbdmRR8l0nCWR30HGZ2fXeIfKpEGI7EzT?=
 =?us-ascii?Q?qWd5ut6B/rB9s/ZgsgGMdP2t9yfsmErY3K9xAt5QlpPLtlrQ6wZy1FfIYL2w?=
 =?us-ascii?Q?nIWCWDxmvIElCSX2OjiZ7a57HdniPPaT+YQ0s2fBbRo120FMCcyjQ7RZDkCd?=
 =?us-ascii?Q?SpdtMWzGiokKAjIzn+29w9qprS4dqgdRTsRAfRdlrGOOToq+lAFP2gVhuh92?=
 =?us-ascii?Q?iMu8/JanXcswjjq6F+74uuBpNRuOHHDHYHENuTR8QFR0qidnwqEHp7gtib97?=
 =?us-ascii?Q?H2B4zyao0JfDKnmbuucCCArYAlZ9Xjf6BwQiC3rzCMlisVXdM26CqBC8QbzU?=
 =?us-ascii?Q?wNwhP9X+jJ9UQx5Ud/OKBMEDqhhSZ2HhsSKftPTLD/M5+MdjyQv3X82k6X2U?=
 =?us-ascii?Q?ih5IzcMwz8Sc8wiL9DMOcwsJlSW5K8UVJmFO1vFVPxauESUih4YpPo1jEW9F?=
 =?us-ascii?Q?zsf8LAQDpMLWU8wbHfxZV9DsEtuaGCZERoHBvgmrQzFW76198auHI1AYSY/c?=
 =?us-ascii?Q?0CvLO9x0XYfytp7L3+0wgZK5ty3nfZJOyUwtO1ODm97n2zxCDtLDbt+efCyB?=
 =?us-ascii?Q?smhbd2n1EQaoNLxCz78URWyK7QzXEhltSc0ZHawKAfybqW1VfBmod7fWPPvi?=
 =?us-ascii?Q?LobkWhGSPJ3fUZZoSDSFd4nfOaIQUKHoEAI0jklMs+1rOH9i/iPqg5Fi8I4S?=
 =?us-ascii?Q?VZYEmDxfCEdZ1Dp9gB/4fYZYT7uA/M/cjK8rVsyeIKM1EpgGPuJMua4uPEMM?=
 =?us-ascii?Q?QIRdoWW9mOd7dipdoNm0i/QuMR2AqnxPVDgFVw8lA0CHRdH3kQoGY0A61peh?=
 =?us-ascii?Q?EPyQsP6ziAXe54dZgHU2q6tTQlKt63ElaxtXx+PtLsWzqUDOZjLLhP5OHAYO?=
 =?us-ascii?Q?hJza0nhf1b8/IKvg2mJOXPsSNznukr0jSkrvY6ebkWfeURmVxkqzNFBSgfdQ?=
 =?us-ascii?Q?LdqzpzMMi95XftSqXHOsRyaoBoebofAbHRsE+Xar2DRYBLDm9yJUfulnD6pS?=
 =?us-ascii?Q?MmYrCObrT1uZRQcXoGkouesS5onaOSyJByNMVgbqAAq2L3CrNnM4HtyIiD+a?=
 =?us-ascii?Q?NvWGYZcezwF7OqcF2hNaRkGwCOI22UBL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWP+KESA579UR276P7DIjbDmzWGB5rm4H1IHQJG9R03SI9bqjUUGsghMFSia?=
 =?us-ascii?Q?k3Ld7etwqDw2IFDdm9DC4VMew3G88P8WKw8HMkUh6Nfm/RjiSxRF+F7cqO5S?=
 =?us-ascii?Q?hgvM27nsS5gfzLIZwrubXy1FyBwUrNl5WGsAiqBD5LsqDU4PlCGNeTqMqmjc?=
 =?us-ascii?Q?3dv8oMsatUK/VXkxcFVo67BEBTttFURaZt4x1uBLb+jlb81/rRiDMFaPoN1g?=
 =?us-ascii?Q?I5j01DkqJLvLxpVejxQb7npty/yL9sBcJj4/BMUDa1pwy0oN42wv1iGvtiXM?=
 =?us-ascii?Q?iAZuoD5cREpRbgG7i4EBF4Ddwk1nEr2HeVCH1iJgC7V70ZeBVoInz5DXVfR3?=
 =?us-ascii?Q?aKqglv/TB2xkKt5FbWHsU4vSomfmk0WgbZvvL7AnW5KAxwXzE/nP/aPlHUFj?=
 =?us-ascii?Q?zHKcaJNmAgu3Lax7RUl1/qU3F1eqCd9FnJqNg+4x6Qd7q/k3plQlGvJZhN51?=
 =?us-ascii?Q?YhyZ0FKww5ErnWlOVA1Tov3DDlHk9U1MorrDkIRET9AjeKGfYx5MyY6G/5AV?=
 =?us-ascii?Q?i1Y4UQnSyep3Cj+mLFVr0Uo0802/gLYaLNORL6/cTLWLQFZ5FKrDokVe33/Q?=
 =?us-ascii?Q?O9i5MOyVjgA8Tsus6kbeSlWp4r6T0RcaHmoEO5lI1S/70uyGfqm3+C7nU6tE?=
 =?us-ascii?Q?3WvKGso3qzRaVbUnKOr/fqNOSeYsCX5SxfJuyDiE5IsJx5uKBtnd909uRrKM?=
 =?us-ascii?Q?KZLRmcgbQSMMmF2qXcP97nw7hpUXsmKJuemF33vnVwmD3KofaDgu6GmFbZJU?=
 =?us-ascii?Q?gOwzd6srCIfOXOGNXusSOyJLtQNXRnVqROF0OeyV2mMYofVQLG6GUV6+nSes?=
 =?us-ascii?Q?1q8xz7uCrSVF0e2PXsv/gE1yQEM5VqZm5RyEFffObDn7YiisR2RPKwy7I5+7?=
 =?us-ascii?Q?Wz666+7G+UkzjbkFSqHrdMYFirXr6XNZ+qjyUwBH6TuaB4WDekXuM+xOOb4Q?=
 =?us-ascii?Q?p4pnHCeUIvLx38KfXlZQVQXZE6eT0QGd0FuEV0mz7oLsSd5LY5rUhv/OJGda?=
 =?us-ascii?Q?EpCnAhipUda/jy1lbtQ74bdz6b79L9Qnv9zCc/e5i40iKUg6dTlWs4XgYsut?=
 =?us-ascii?Q?lXSbcIkYCW6H8IRpAa0TLclNKN8fLp2oEzN/mw4xGps7dm3/mZ+GYSXckZ2N?=
 =?us-ascii?Q?GiPo7zJDiiR1+V0Nzw9WvnP5EiEcPJFlw6gsutr7797nuga82iM3gDjK66/K?=
 =?us-ascii?Q?jeBOGZ+fjZJ3nEUR/gXubq04QuZ4YzEmV8cVtFdEWBHbvnVCPkOK+d21bTUp?=
 =?us-ascii?Q?Tx3INDDyiZTsfdY1LGEDi7A2CLnW8AQfpWrF+oa5Mt3Dp/2tXyg6+IkiZtY8?=
 =?us-ascii?Q?9hiu+889ShQJtdsgR906cLQgYU8QXtmMtkMLjlk0vJrjAWQYNY0K/Sr/oqYR?=
 =?us-ascii?Q?g7aEWrxo1UHOjRTk33Y1xj8vCPtMaufNfMqUvGFEAInjeg+rYAqFYULwF720?=
 =?us-ascii?Q?IDZBB9aSqo2MeYwZyQE/rd2rkBrvhXIarU6QixGviFvzD8yB4X6b4IWBQ+zk?=
 =?us-ascii?Q?0AfFRrf/TekXD6kcgjqD+PmiI562ZmtkJU+cyGwqXfFv6LH+x+63Kv1Gz2q/?=
 =?us-ascii?Q?MYvaDEWvUX5IhM+hrhrKFMw5b48dCi+iYqLDKydP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6026602-369f-4410-b48f-08de2255c534
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 01:41:31.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Deih/OlAYca/1OvZO597JSdTy0cTbaQVFfp8H77Yny97spVBk1UFkx6bvmXfzFto6yXKqsTuIAas6aRJB4FUYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

During the sequencer process, we need to check if GSP was successfully
reloaded. Add functionality to check for the same.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/falcon/gsp.rs | 18 ++++++++++++++++++
 drivers/gpu/nova-core/regs.rs       |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index 93d4eca65631..9ef1fbae141f 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use kernel::{
+    io::poll::read_poll_timeout,
+    prelude::*,
+    time::Delta, //
+};
+
 use crate::{
     driver::Bar0,
     falcon::{
@@ -37,4 +43,16 @@ pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
             .set_swgen0(true)
             .write(bar, &Gsp::ID);
     }
+
+    /// Checks if GSP reload/resume has completed during the boot process.
+    #[expect(dead_code)]
+    pub(crate) fn check_reload_completed(&self, bar: &Bar0, timeout: Delta) -> Result<bool> {
+        read_poll_timeout(
+            || Ok(regs::NV_PGC6_BSI_SECURE_SCRATCH_14::read(bar)),
+            |val| val.boot_stage_3_handoff(),
+            Delta::ZERO,
+            timeout,
+        )
+        .map(|_| true)
+    }
 }
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 274e53a1a44d..b32c07092f93 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -138,6 +138,12 @@ pub(crate) fn higher_bound(self) -> u64 {
 // These scratch registers remain powered on even in a low-power state and have a designated group
 // number.
 
+// Boot Sequence Interface (BSI) register used to determine
+// if GSP reload/resume has completed during the boot process.
+register!(NV_PGC6_BSI_SECURE_SCRATCH_14 @ 0x001180f8 {
+    26:26   boot_stage_3_handoff as bool;
+});
+
 // Privilege level mask register. It dictates whether the host CPU has privilege to access the
 // `PGC6_AON_SECURE_SCRATCH_GROUP_05` register (which it needs to read GFW_BOOT).
 register!(NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK @ 0x00118128,
-- 
2.34.1


