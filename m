Return-Path: <linux-kernel+bounces-869676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88012C087E2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD483BC541
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C621257B;
	Sat, 25 Oct 2025 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FpE26BMa"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE08EEDE;
	Sat, 25 Oct 2025 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761354502; cv=fail; b=uAKdtL9oAjbhXAQKj27fdnZ3gBLJZ62T9Qi6OLtn8eAe9kogyVJ94a/0HO1/w0qErD/JpFs1Lcv9FTQnCfck8whILAoYhVmZfQCDmrREhsV6zXydIkBdUI2nFlK/nIjBJU8ccmXKi6m3WBZYSatcyXqZ9PMEr8AgjG9W8YXStc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761354502; c=relaxed/simple;
	bh=0fK179NxPuKz5e+AFJakkbTj6kcJQS9dequnQIED7lU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dVPMCZbC674afLDkz9yeCVcbi9/CSWhUmlWoNCgwnr7yRyI3U0HYfPZwNP6vwbUcQhHLzhrgnxmGjoIGEfiKpngyvKYGpsY5x6l4zl9NpbHxB8ThSzeGLHaxXu+DNHdjXpxKqbbgp8E5tu83x938cv2m44XQ/2O+v2r4jKDE+HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FpE26BMa; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZzmbI7cjeXenZrvNgs3rXDwqiectxl1tLIOH8VJetnCygapnYj153tH/a7KGV6ddXbwh8s8vh1KE+X0lM7xBBWzY7Cl3XiG2UcvwRouIWrinCipYh9PQsqLnOpAL8rsSuzZVdkK2HQ0sN5Ct/4cBX+8pQt1l+TCKVFO+imPcY5DMFNRwDksfBIwChHS7+/4Akvp/5b67eYKUBoBKt7FakEjPZ2jbz//9Ya1KEEfJnqr5G0jSRtrZeFVcHzA0n1R13TDGPUgH0pJ2jgdshM7Z9+u49j6ixnmHVyN8uEPCy50gZhZBDF5WXhgyshdCz6QVJZMqhdId8AIYGT8ntpMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWHBz75xpvTLfA98Gp6pI/gdC5rOVk5k1/rjzSolmjA=;
 b=A5YcVRQvsFavvmHk8cz2Dd2HAPXlvq5tgT//CshE2wVt7H2BWy/EBrIvOinur/uUQ+0+lSzz3GWRUcSWaVPaAAywEol852X7PeqcPtVgJujG0nkLkyEryHeOGnGmkBx+HufE5PTX5lxKhHOM97WZyQMwXSMoEUwY1BCuFJydQ9sPQtAC0NapjGm0G8FHt8V+cpz0HFspamqhgUbP8PrQuppYmE2gciV3xJ5jjgghJnq3NoT/TJhpnm6O06j8lAmVHorwegJlWWmi6iXc9HhC9t6nFfR99KSDHA5mmCVAICEX4iVmDDnFHVHvEpHXRTVQCQeF+YkVRIYSn+2Twhje7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWHBz75xpvTLfA98Gp6pI/gdC5rOVk5k1/rjzSolmjA=;
 b=FpE26BMaeeaIz6WdTdTCr2gOgPWN7bw+nqptwpb3pKtI1y63eY3prd8jXvyViF+opfgFcYg4yAI7obVUWujusVz2Xi4b123qMlxpz0Opkr5UGVthpOebn01vXk+6kaX8eDHXUmjwAkKaSjLhGKunM+Jo3B/yUyu57c+/99tLVemdEaZebgc8CPlwbglshNP9wnrdLuhVZRceSd4loo/GEAfsLhK1aQuxH/w8XT8me25lo7CqImHi21J2n/gemeKOWbLhLzbncVDzBGYBlBsfVNezyzgmt5mGjpz6C6mqjsA+l2tfuVFbPW5osdrMV1ObdC3O46M6srQFSCA1u6QDyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Sat, 25 Oct
 2025 01:08:17 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9253.011; Sat, 25 Oct 2025
 01:08:17 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Edwin Peer <epeer@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] nova-core: regs: rename .alter() --> .update()
Date: Fri, 24 Oct 2025 18:08:14 -0700
Message-ID: <20251025010815.566909-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 892e5cef-4560-480a-ff91-08de1362fb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdupbjQ6mSYOuDU2GoReNIYMKGbPMioexTkACMC4s8Plb5Tfy/qLpQ5uy72f?=
 =?us-ascii?Q?G4rtogxwtTumPhONXXfw2gXKlW+39fUQon9EGgbssW30b+rAbkFbviLPtqgk?=
 =?us-ascii?Q?ofuzRjMgJEBecYhiBz0CscdyDJNC21AAe2rfJD1u+IO7K1+aTKwlF+4qgjvR?=
 =?us-ascii?Q?cKlw67822E96kRVu6m6xDgmuLuZzDT1iQmn95jmg/mHur6LQPy9Cutu4u0EK?=
 =?us-ascii?Q?EmBlzTmogLOVmY1lX4cKT+Xf7It6GLr6zlL+iqSh/Qc+2QniN7fwv2xM+q1J?=
 =?us-ascii?Q?w4EBvOIBtbQn5JwirTbo813G1e/AUAMJRo87de9rXmDGFlHjlHcqD7e1Dlnm?=
 =?us-ascii?Q?HVcynDREO9M70MuaZJRDYZoIusssf4Api1M/Wgrbu5zixB8rdXRnt5L460zh?=
 =?us-ascii?Q?gfS1b2IcVS1aQhD0X6cPGEjrN1mMxdWS5bPm50XQ4OujNMTlbOojPTleZM/C?=
 =?us-ascii?Q?wJs+rqhxQ277YK9BwssqJJEdb+8NmvVJpnHIbnFfRIxNbank7Ap+2DWy8Fyj?=
 =?us-ascii?Q?WfKd6AL6IHKqe9QlbbYuihLrEOSwzAxqr5uSoeAUyG/54dI1gOCo2d6vA6QA?=
 =?us-ascii?Q?niBej3QoMousf5WhyUGV++ZnlP/CwQkVVYi8dHbILvBZpj60DitOqvnglp2R?=
 =?us-ascii?Q?OKAQMmalXKL3Qt1OqhMN4AIxunm9/CZ5/G2iiiWKiZLrUrzTwolGhVj17vBw?=
 =?us-ascii?Q?7keFZwiwV0hktJuA/qJ7dgKxlQVrc8hQAorMcpT221ol075arNsgepzdlUTE?=
 =?us-ascii?Q?1RxvfbEX52xecmWu5xtEYGUVJhPyJicJt98AiuxuNuQcHWVhnViWwxgsB8xu?=
 =?us-ascii?Q?raar1BtITSdOzZ2iCtTgblgZAwHl0X13FlaGVV2PV5QuSz5yRXgGbLTDcy+l?=
 =?us-ascii?Q?v0lNusxwLGECrwcgyOwAlwFhBg/PpKIyVF832rrz/wePSQefcMGFh22MkZ3J?=
 =?us-ascii?Q?M226lUkD45j1jcpFKAMllilLBqpfWPIgYs1w7Tg5AIrb7CqKLD5TUsVvQ2nw?=
 =?us-ascii?Q?SajahNzQpvDYVYgHmBkKSS8iU5CXMwsSlVWYLk4V6yXz0MbGVftqck6D64h4?=
 =?us-ascii?Q?hXEjBcyDyJXSnJt+RHs6/0UJyYqOrsjyzyq5NEGXxkA/zzhJ9PhbwFTt0LRa?=
 =?us-ascii?Q?SZ6jgLTVGJQqx6dLKskDANSl04cTwf0qMdbA90T4LALodyv6ZBEhsyhhBif6?=
 =?us-ascii?Q?0uDuMXKGMHQiJe3bEqVuAe/CSyQiAtUDx8ve1pOQdj3Nc5fjjWaRvvA2ZB1S?=
 =?us-ascii?Q?KJYgVNqD18TUnfUoxKLuaFrkr2jBruw5bVgaES/QAdNjkG6ci+qe+055h3fJ?=
 =?us-ascii?Q?xULF8M/Bv/XAeFIBiW0zUFVvS7IteI+srSeoxtZxX+PfOBZlXeCtDOEa+fdA?=
 =?us-ascii?Q?ocGvzEQ/GAx5+uTcp+r1RxhoueEt+rcxUjHohgAToXNwewgXg9IjR8jt+Os6?=
 =?us-ascii?Q?bAQsOFfMo+MpkHpZ4mzC1DdZABeTF7GYmPNkN4HrfSFZXOBNapvlTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EP8ew6PsNGnwFULAGwuix5oa6ESOYWR2doL7lKyRV/RdH+KDUFb8+ihSAL8c?=
 =?us-ascii?Q?3fcNixjn40OWYVI4hSdUPtKw7q/ALKBWku351cwdXTHp0ewWajXEP/nIu5N3?=
 =?us-ascii?Q?mJfwDmDWqqrPkXCtqPKdjjtypl3aJwhtrOQYsUox9xM2MHrLhZ46F0+Q340C?=
 =?us-ascii?Q?HwGfCs7rcFoWejiij41Us3qVZ/SWa57SLhBkVbKGPVtpGFHPkuG8kZ+W6nz/?=
 =?us-ascii?Q?UF18n96xANEd30avBLPEq7+9+Yg6twKGBsStK0BT5Y6XCmHA/OP3XhBqC6oL?=
 =?us-ascii?Q?LQHjYAeDJqsythvpk+LaRca4K0a1+GpLERMGFg+qYSTCwmXkP+9HCAqqs+Gl?=
 =?us-ascii?Q?EhD+pbpLU8w78s/ko3NEv2ki3Szjx8Odv43tj7hk8M5Qvt89kbe95OPVu15P?=
 =?us-ascii?Q?UCvdBlv41fQ8UKy8cw1WqYcEt0Ascn87XGoXRVDruaXfPJ7OWutfTWdzlz0v?=
 =?us-ascii?Q?QwOy71+EG9pjY1poj44HWGb20VF7bhi6+GCs7DNCBvbqqHj7qbr1DxcmHA8y?=
 =?us-ascii?Q?VkKFUdSgknsKP6gZsoDfm/aT5LAukMb89sqUT3Wt56XIEHYnVW96iX1TP1Og?=
 =?us-ascii?Q?fpcT9bQsVjeNJvkBSBSLlbV9IZiVn2cCu2AykYUoBx/1ZLHtUquWyraxaxUC?=
 =?us-ascii?Q?RvkbDbVwGbpQjissXX/i7BT4PTkU8cwPEV8n1eat7lOhC+4Kws/Gs0hOi9TI?=
 =?us-ascii?Q?fxf8jacRseAZe/xXJZG1Cd6+gYuVAiZceeKuKKbMi1vf27jDyJUIEJA3ACTa?=
 =?us-ascii?Q?SKpHKyeNQi6VQtSQZR37Vb6nMn8zeVueVexa9jQkOSkYmuuFVrLwXHhUWBwS?=
 =?us-ascii?Q?Lm22gISEpwJJXx0K89Bnb9XF+qEtRnFuYEiZqXRBSOCZDhWmyFoGJJcoMysC?=
 =?us-ascii?Q?mxpNSMRGbEd4PS8irPSep1ECWws4PirEjpZoHy8hBJbYZ7QZ4PRR5ORZ+y7M?=
 =?us-ascii?Q?1pJ3Ll1BeQr/AlO9nFjq4XoPinrnejYeiWJgjr8lBcHt7wmQcvCYLveyo/yX?=
 =?us-ascii?Q?aXSSQhquMAVh7QbcrKjQ2yclGTU8ezCtQ/ufGKPbXWR4UubGoi+pi1IQqyly?=
 =?us-ascii?Q?/Oln4r5+rqpf5gV8rn+qSqOqO4xBv1Em2m/0egpbogla9BO3zv2MqGkksyOz?=
 =?us-ascii?Q?ajtD2Png6cJN2E1ak87TaDcLhJmgEXcZ8Hy3nYCNUTCnd9VtTxAoZcBxPKid?=
 =?us-ascii?Q?EiS3WKzbiiDo26zZhIphc+y6afUL/sQrKggcFX7hcVXA+1+vvqzFiYCrU4as?=
 =?us-ascii?Q?O1hRDUVVzaqwbVZpAVugJFmkXppwX5Au72+nzfqV9x00UJu4bpXEM6qXFUrq?=
 =?us-ascii?Q?u2REAQJf+5sIoGpC01l205u3w0qfsq5Xe0hwd9amFnO5CyfR3HhCuTj00kKe?=
 =?us-ascii?Q?4ea9uvpIBWmz5oUE1faqhgqUlCU7qcyZdSkzUOuzvOcgp3+aX6GaMkHgmixL?=
 =?us-ascii?Q?3Le8NWEwWEGbDyS1jB4PTxNjdNQw3SCP/Klf1WKTpza5+ODB6LtKYveNc1wB?=
 =?us-ascii?Q?npJIQUT+SOTd0/7q1pWqFbC5ErCUB7CsnoIAhVZxW31po99aBbmJ05YO0lLa?=
 =?us-ascii?Q?7bwS82aCV0cv9Wm2CkuOdoa4QXzF6SnIX05S2mU9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892e5cef-4560-480a-ff91-08de1362fb0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2025 01:08:17.4344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rL1+UcKzyJFWg4R1j7AadcCY1szHyVdVXB0v4ZLmhQSpPI0vGUw0IQcgwF+BA+wg7DTlpxMGkoWk4a66ueEXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

This is based on today's drm-rust-next, which in turn is based on
Linux 6.18-rc2.

The discussion about the name change is at [1].

[1] https://lore.kernel.org/2c5d90c8-e73a-4f04-9c1d-30adbd0fef07@nvidia.com

John Hubbard (1):
  nova-core: regs: rename .alter() --> .update()

 drivers/gpu/nova-core/falcon.rs      |  8 ++++----
 drivers/gpu/nova-core/regs/macros.rs | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 18 deletions(-)


base-commit: d3917368ebc5cd89d7d08eab4673e5c4c73ff42f
-- 
2.51.1


