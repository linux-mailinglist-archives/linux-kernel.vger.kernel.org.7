Return-Path: <linux-kernel+bounces-879795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A0C241F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8B85636B5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C31330339;
	Fri, 31 Oct 2025 09:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oRy+GJVt"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEE232E738;
	Fri, 31 Oct 2025 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901706; cv=fail; b=tk8jDZIXpY9n2SjYOvsm0YYGWL7CRN7IlMeikz/jGDUJ5GzA1akdAN/r56DP1KDffDD0ds2zqS8TBLCYtRIE7tJlPonuGG9YZGUnNm+4foVBsb5bljmJD1UxiKmTVTytXGsqh9RVsAsYM7beADuiGXuNpnB1MewE3W/MivL60lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901706; c=relaxed/simple;
	bh=5/wMjl9MihR03dixL4gqq0Ktk6ffpZ9QRoVbolcOW5M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jO/AdbeCt5yS/YY7Pabb7zLQpXx4wi+ZOcuHaFIgOeMYmwBPqO4KeDl2ii3shzg7Oj/7uNboeFgPdGn4CjzDOCMDshuSkqYPvVCozli5JE7TH7Sd+ygt6Iyg6HHbYMchFY0R9bYkinqJpiCMkz9vCe+TCVDxYksQ2aqu6zl8aRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oRy+GJVt; arc=fail smtp.client-ip=52.101.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erQbryYKUIqUagImcSi/pO8fcYM6u6SRcjRNcqnYrj5IK/GV2GtPrdBXZ8QTbUTxYvsp7tM0Q3pVm9kOBUrgLpwhWISENNu/CyJvoCTjXAlVm9h7svxYGvWjqzE8rbLjr67sMNYiRV77TKefYGMNbvB0wOKkJW+uw1x/8fJ8I3izcH4cx7JyoqqT1KsqZYzcqmXgHmrBbomE251i68r3/kMkRchUfTXzDTvuoDx1zD2YXpuK8qTwhn2lHWadJb7HjJZCFeyMOx4DQ08AMzOEDV0JVmINS+uDrWqf4gTtJGBih6VI0mMIROx4WS7jPqeWyTOoZkLNJCSHvfUYbEjW9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaPQuiup7Zu/xewxGgJDhjj2e9jGERNgr7HtPd/x8PU=;
 b=FfWsquztLDa2SfZYYNSJvzrzWMrQB1G6e7KpXdPlp3yixLQ0v+xA8BtCU6qUyvY6RumyZe1mnGbwwuuEYke5x4m4O84SN8ja+jPP78uWzYs7QAQWRhZ5TzQkNeTzniYZ1jMD5b7qfKZOfrXLhZtNXQ1WmENZi4bRSo7+kPyqthgBn7NQFl8rv3bxY+guidgwqeBIibFN4YpkcpIxTWlzrkyHkGzNYZOq0iAk70na7iIU1IVbuTL8VeBLPvp8pBxkpMM1PXp5zrUvzZKH+9cRfM/odEBoOYX8DiGof6lyhYE8ywjpvj/vsObpuDA4u4U2GW0ezzvULKgelodOoPunig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaPQuiup7Zu/xewxGgJDhjj2e9jGERNgr7HtPd/x8PU=;
 b=oRy+GJVtDVu5ukmcQaud+Lt/CTKi8B9uv/dKb8HBYlNdJn/vgHgdxWPUkf481M6dia94YXdFAiRE4U6fmwv7VB1e0CeA8pnraLFl30X/L1SpoagdldKS7AZs7jwQSj7gfKzePPjDSfNctZLD38LIK/ib0Lsa8NWlGGNE9a7dMrqBfEQKdKsfpotqWuvEvhVexsjtOmL0rJe4jyKNcbw0CDFhyjGJDYibrR1NYlD9AaWJgT+Pg/Q9r4ygnyM4pfSsWmRoMCp+lehJEfqQ9/z7sUsuevA37WLb6t78JF0ylq0ZsaY66cDq6TJn11PcKbsrhgXxSIMGCO0Jfh2ZqLimqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by CH2PR03MB5269.namprd03.prod.outlook.com (2603:10b6:610:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:08:16 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::24d3:54df:52d0:1030%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:08:16 +0000
From: adrianhoyin.ng@altera.com
To: alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com,
	wsa+renesas@sang-engineering.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrianhoyin.ng@altera.com
Subject: [PATCH v3 0/3] i3c: dw: Add Altera Agilex5 runtime PM disable quirk
Date: Fri, 31 Oct 2025 17:05:55 +0800
Message-ID: <cover.1761901158.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|CH2PR03MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4e57c9-310f-490e-6292-08de185d06ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pik2Xfwh4/WamL9KFZa6WM35vgJrL4MT0IUDm5qH5K5jQTqQjeAU1Plwx4pl?=
 =?us-ascii?Q?PRXB3V0IM3q/j5Npl2ms3DkhwcsFCL+eLSEoi3q4TBmKaYLtaRP1H2TCC/WG?=
 =?us-ascii?Q?mQGOcDCGqNL220O/YOrvoVfh+7Rx3wdUc+u4d7FbQRtMffi1Z95yI44XlsVs?=
 =?us-ascii?Q?uvMrzmmLOuvoDVg1+TzbuK4rNADMKlP0FJci4Gr9H06DusLz7frcQDo5S6E3?=
 =?us-ascii?Q?GTRh1SzV4i8n2TjRaA97CgxH/8f9sBFVLgomywThMV/l5m5eXehbaDOgDmLR?=
 =?us-ascii?Q?b9J7WXbZlweymqoRh/PZwouu2Yyv/OCN8HG8cTx3Z5qL62ou4yKa0078E4wv?=
 =?us-ascii?Q?RvtF+W8/qpa0sTXeYDuYcLtsR7uoL4Ni0KrpVwDFnF2t0Qt86SRtD7nneMHT?=
 =?us-ascii?Q?E8Q1IPggBhIElFj4gywQtPcrFeULvqhujvdJZtd43y/sXUuFwbG63xslcOPK?=
 =?us-ascii?Q?LQpdZ5DWlof9NxrbSPsAra1DP4O/e7wsQf44tvJ2cOXsMF1ZuTR5GUvUUy2i?=
 =?us-ascii?Q?Bq/AgcS8dDIyQtnMKyK4elHxDBr+nmfMFR9MRlnOm+UVg77HuqTKAHUR/tcF?=
 =?us-ascii?Q?vCLHyxophRHASS8nlC50LKyEuJ5WcXAE/fm5WU9jZ/vtOi7/qCp6HV3qEv9q?=
 =?us-ascii?Q?cjeLpAqMr3R/dbTjxwhLUIQwnvaF81K7xKZAQqWUBHxjF8s+3Jytp5Mi6HHR?=
 =?us-ascii?Q?M8LopBe4NtwJaLQNwI3pjMKtTMx87CJUcI6y9knRnGF4NGZko4R0V1CaEyJW?=
 =?us-ascii?Q?yc6Jm68u33xEFUVDsgFfsGqr4kV0hSAQZ7FYeGngmqvnbbsA6rfGpM/mU6uG?=
 =?us-ascii?Q?Op1EIlCwkBh9IydGFU/lMdh3cJDqJrvRB+gy5YTRIr6L6RI/ubbwBiMUFrQr?=
 =?us-ascii?Q?hrzpNbaDmhI85kHuofIp6R/I8aiK102H0veT/R0KnRMWLQu5fkZwHhq655Kd?=
 =?us-ascii?Q?ZN/QE5rGQNfruy5D5HojAHXz/Z0YX++KduS3fHNJTu1gx3WrNM0tUvft0XIc?=
 =?us-ascii?Q?+bxXurUKQUaOmzZLzxd3zd6iBSEFNU79p2/yaaoIx2gzlLuFy2ZekPO8q/wB?=
 =?us-ascii?Q?7bHZ4inyjqjRK152HhUlODnzMMyFAKX+dsrt2r/JToOj0PFMC8MPPCHnWQYY?=
 =?us-ascii?Q?Fm853D9rFv5CvTqVYzy/JYZvhYJYr+HXhtIk7+W2foOR2IQRGDsxmTzRK/Y8?=
 =?us-ascii?Q?/yJ57tq6srrJS2x7TqkRAHyNN/AQ89fF7vo0+Oc2hdbL8Al+tMEShQo0X5jf?=
 =?us-ascii?Q?w774RGxUz/obI8f/Or6zh1SkBKPrJ0bzPjhuHhcAvDFGepvsI7UkSoIcQsNo?=
 =?us-ascii?Q?UWo0aupx42IX2/YIc3Zh3fo1DqNMQCe0Wt1uZr0HlrAISVudt2JdUY2GunL/?=
 =?us-ascii?Q?8VxdyISMqEqdwjOaPNmTFOcPC5WVfAwIm0FJZ2RKFvg3Clb1D9LE9cRcy9yK?=
 =?us-ascii?Q?vrD4ZT+7bnkivBMWXim3GJK+L8P2zmwusO9uoRTVnZZvyxpQ+cswFDqi8OfC?=
 =?us-ascii?Q?EAwk/mXuHWZIt0UsSJwUp1FrPmMuCfykIgU/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7rl6kicLxBETN4aebXlHMF20DkPQVt0XQkW3jzKf/ZqdGvKHWdlu097I9GY0?=
 =?us-ascii?Q?AzAB7aC0mzypzQ3ON1rdZnOcP+RYCVdD2FIWC6xwnuEyMi2ONOfAlU6uQI70?=
 =?us-ascii?Q?1cXrGa/Ro4Cpuci4br+zHbuUBd5qvhUSLNDOPI2jdCWFWWC2kMZ6KnOug7cS?=
 =?us-ascii?Q?5Nj63Gvjsf3ZE/N2oG78gpRYokPVKkPuvF9rJuSMrLopZi6Kyajv14rd0q/E?=
 =?us-ascii?Q?UkoF07YdCAZVJpA/YK7kAXoRkE0Vj9KKxb9WsgbhSfW685ZZYFvlsezTJ2Y4?=
 =?us-ascii?Q?Ur1ZNowCQG6RCdyFNvyGKJ/aoj8FBbJP0XygMY9loG8MLo03+bdMcS66uFlu?=
 =?us-ascii?Q?12teLuTQrCgMrn1Jy0/il+QW578ZLRtDeHMvMPC+/AzjgYLbD/FiKVgqf4R2?=
 =?us-ascii?Q?b5nSDwJYH2Nu+Qvi2ro8QdKIyC1zWpqgSLTeBPW2kcEWMn4abfejzwtdNDcu?=
 =?us-ascii?Q?kz4vdRwFwqNPOblVsAK3rZCs1uycRFbDYLV4bwdyqAODQhev7GSwIkGDHbCA?=
 =?us-ascii?Q?UUAhj7w8zbGANt1GezJycD2slJgfP6cx7g1oeKhla7MITA+r+t3W/k6f1fif?=
 =?us-ascii?Q?qEt6MvnWU4IJsMzwyfJIvuk7prNylVRm7tcHsu3VqDcyri8I8hRtow/5p/Y7?=
 =?us-ascii?Q?6wHBtIzS/fF91bJjihNn0Z8HaY9Fl5NXdF++YQKDCtUIXJj4d9r5wTqW7Q/2?=
 =?us-ascii?Q?0foUKgcNKaH1mEiDDUyl3Ng6rsp2mf9WaQmr3TqncLvxlo2a7QEkH3QMHepL?=
 =?us-ascii?Q?TfCADYnAH52ROxDbejUXHKEbyKy/lJCewuepKKKUE9HF0GxySwHWjFHER9Yo?=
 =?us-ascii?Q?axsmRikkHR6ZAXB8Uj4WLMi2sc82WrJnx1Nxr3ANC6YnMvuShAKrpkckKhk4?=
 =?us-ascii?Q?TewcV6r3HjpujDyWJ8QxAupKqkZFfYUIMcQS9rpjtPUfNgFBwN8Rz3JX8DGG?=
 =?us-ascii?Q?hYVovGWzP0yioy1aOfL6Ge7uIjBKZsp/4GYy5DaM1GBqoIH2lK4/ukrvNuFY?=
 =?us-ascii?Q?6ULYxMLzlM3t5B7FGmUmGj+us3QOYv29rRXohzIecHehekZPVSeCdeA7jRH0?=
 =?us-ascii?Q?9rOz/frSkrezQI0pKBbNE103Wogv1sX/hohcntIsFOl+qK6gQrqKeIOzY1Wr?=
 =?us-ascii?Q?GIcp168ITT7XKDaib0GNgJoPf1ECPC6A7A39vME6Hg3OLCfpP82HhCDHIilq?=
 =?us-ascii?Q?P9KV4lq3xnI4pduM1aTRj7GjbW80hJUumOmM3XZ7RpG+KdQaLsHsacoGYVdG?=
 =?us-ascii?Q?BUZwFfhwJf6BuVUpa7ASj4aTdGVjnRRsS4/ZVtiDxK2lsTMPjDzPAiq2MIcb?=
 =?us-ascii?Q?tdF/QCN20XwfOgoOsbNcPKFEij5kq4cx/bUtxredPpEfEWM77SMhxBE3Enqw?=
 =?us-ascii?Q?ZQfr3M1fsS+P2FWktD7R8lB8qeJ9ZiGS93i3bk/V2ZEwuUoLtrKj/Va0Ta3x?=
 =?us-ascii?Q?mdxQYs3pObLxcVK2TuSgAme4AfhSbSDk9SLe8PZgj98BzADCxVHEQHQLArHs?=
 =?us-ascii?Q?KY92jFo+HE4bNaisRsRkx5+34RktrzMRehZF6dPJSP+MAitrPiszqmuOQrGn?=
 =?us-ascii?Q?jRK+2EdQ1H1DySu21dD4WCd9aNz8F1EkPdzpCxj6zTc9UQW5IkbjWfIDLWNI?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4e57c9-310f-490e-6292-08de185d06ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:08:16.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5TdJIbZXGFBYA/xKT4Qj5XWFmkwUyW8fXSF3mlGW2bU8GRqzihDp7XdbiE24K9qDKKMt23kRYtkS0AxXo2JO/oJGH+035xWIV6Impc8Pd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

This patchset adds support for an Altera SoCFPGA-specific quirk
in the Synopsys DesignWare I3C master driver.

While running the I3C compliance test suite on the Altera Agilex5 SoCFPGA,
the I3C bus was observed to hang when a slave device issued an IBI after
the Dynamic Address Assignment (DAA) process completed.

This issue occurs because the controller enters a suspended state after
DAA due to runtime PM being enabled. When suspended, the controller stops
driving the SCL line. As a result, an IBI transfer cannot complete, leaving
the SDA line stuck low and the bus in a hung state.

To address this issue, a new compatible string,
"altr,agilex5-dw-i3c-master", is introduced to identify the
SoC variant. When this compatible string is matched, a new
quirk (DW_I3C_DISABLE_RUNTIME_PM_QUIRK) disables all runtime PM
operations in the driver, ensuring the controller remains active
to handle IBI transactions reliably.

---
changelog:
v2->v3:
*Dropped RFC tag.
*Update compatible string to "altr,agilex5-dw-i3c-master" to match actual SoC.
*Update commit message to describe changes correctly.
v1->v2:
*Add new compatible string in dw i3c dt binding to validate against
newly added compatible string.
*Added new compatible string for altr socfpga platform.
*Remove Kconfig that disables runtime PM added in v1.
*Update implementation to disable runtime PM via compatible string
match so that the implementation can be tied to a specific compatible
string so that it does impact the existing behavior for other users.

See previous patch series at:
https://lore.kernel.org/all/22286d459959f2a153ac59d7da46794c0f495c77.1760579799.git.adrianhoyin.ng@altera.com/ 
---

Adrian Ng Ho Yin (3):
  dt-bindings: i3c: snps: Add Altera SoCFPGA compatible
  arm64: dts: intel: agilex5: Add Altera compatible for I3C controllers
  i3c: dw: Add runtime PM disable quirk for Altera Agilex5

 .../bindings/i3c/snps,dw-i3c-master.yaml      |   6 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   6 +-
 drivers/i3c/master/dw-i3c-master.c            | 171 +++++++++++-------
 3 files changed, 112 insertions(+), 71 deletions(-)

-- 
2.49.GIT


