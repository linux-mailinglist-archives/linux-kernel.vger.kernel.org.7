Return-Path: <linux-kernel+bounces-885579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CABF1C33633
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B64E8095
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101C2E03E0;
	Tue,  4 Nov 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="AcgsYEEl"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB712DF71B;
	Tue,  4 Nov 2025 23:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298970; cv=fail; b=NwF0SdmMyR1G47aCd74RMbW1wHt+1tFX1RKIYKc5W40wqe7fB1XbU/1Qo+Nug4ADVmPq3kxllVUOsi/O6b9KLwvlFRV5hTzMvPu0TmnhxU/undvy6zh+sPoU2BfA6iAyZdtnrA4C7sQ4DM00AL5LcFL+l73v8OEdGJKbVxFE3O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298970; c=relaxed/simple;
	bh=qoXzfPBQZT5oScYOwnlMWmKhxzL4bkD1IxQL3y1qx64=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rh9CkzjT0ifsjSDnW/WdPKmz173pZIgMfVjgYi5W2Lvzdi23TK9d7fWA+m3SPtULsmmSTQuV6LeGMsKGnD3CPJbZI2xUTI21XWjIPvcHFd+J1bgDzqvy+ImRXDR6lgOQzuZ1k2eB+7re0KMJ2jIJ8m4nDC+bNI2tUCzh542WR3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=AcgsYEEl; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKypoUKQ4XWIlQiIHA7gvD4Stap16PmdP84tn3xQfB+eleyLQRkrBmkBWElTZkdYrnNmaluLvFXAgzSThS1wLbj2Qq4d94bUi7YdCIX4DfS0FehE0A8Uqlarg+YM5T4iA6LE629SrGbVWjwHE7gDn+AFk3mhLCpHCtW21/u0iljz+0lfk3+cYoJcLApsTAF4J8vKy0tzXaa8i0OoHSkUSWcLtHWRevxy6D/S8NDA7BbHk2lXynntADlhRmuuPhAUAx66W4ln0Wzq0Avgb2/NtB/silVnBzOcitFPAErdnmPu0OTqS9o9yxtv+h/j37T0kOEyf+ui3MCjkzhclwTNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dix5WsxsY/TtuCR0HakkVR0Xoh53qrgZxJ7MI7SUB/k=;
 b=P13Hmi7x1bXnv7CJoPVLvQImcvO1d0wsnOLK8UWSDBibkoNnqNzMXFvh1IDQzrgP/YWS4pxTgs/h5+QutGNMkmpDaGFKLUrN1tu9FmJZGyiRGCIscxMlKduCfFTKftDiTfaUCmQHwp1ltNQzb1bA0DYM0k/6d/NTVwb/QNiblEIV0J+HoEFeqLFZDnAtO3rHA2j/iI+oOcZWpovjDykh+V6RIEM5/Xl0pYdHr3oM3t2JiwgrO9wkK0hmnLGf61VMNzhgPGyuNDnaESYf52nvddJaL0t29Ce7gnnFd7+4F6bVx7rqsiVvP0422ek6Tg6RxfU/SgZwv6chJYl05EnjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dix5WsxsY/TtuCR0HakkVR0Xoh53qrgZxJ7MI7SUB/k=;
 b=AcgsYEElOqxvWLVOyhXWhkQ2op9VWG2J0J3jIb3WnAd9WVQy/SbqySgt2PMw6gRYKELowItuw9e8x0tyVxx9TqYPOva8LG7dWZILIRuEkqaUQ5B8plTBMNo/WCQm/4vE7Xa7/c7NrHkVAThjfx8siFtuv4Qj6TvW+a35GjBuVaEQcgK2BAKnRKUxV2EOrsA1NOvy2depXSIcMosCur22BneIb27myHiwgIiMeJYPqjBtffzs9jHNUWHrabwtcPe6x/tyMvvUusDXWPLcrwMi++5dABtZMF56n1YSI95OP69k4eXZRxkEjiV5JdjKu/BAViXsuHUCh0fkNoGBcJHnoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by BY1PR03MB7239.namprd03.prod.outlook.com (2603:10b6:a03:534::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 23:29:25 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 4 Nov 2025
 23:29:24 +0000
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
Subject: [PATCH v4 0/2] Enable Service layer driver for Agilex5
Date: Wed,  5 Nov 2025 07:29:15 +0800
Message-ID: <cover.1762297657.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|BY1PR03MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: ab801a4e-e1bf-4c30-d427-08de1bf9fd15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4krtRoKedaogT8rEPYMnBxLtL9iCoBufuxDvZTx9MufLcZBEMef4nwdWzg2?=
 =?us-ascii?Q?P2KYam3YZRThPQU9fExGIoxQiNffYIX3vTwGzs+5mRAJWkmfmM2LPOmlSYmy?=
 =?us-ascii?Q?KPQCIif1qkwr9G/Ff7dbWaok2K43STQp7hGG/mW6NfnebTxJfaiShle+Wd8q?=
 =?us-ascii?Q?vTHSRTAsBt1GBeDW7rr2iGslW3e5/sYy2UZeRxSY0GOpQCs7iX/V0//FQswT?=
 =?us-ascii?Q?AGvzynHNnz0yCaxN9hxVcLVafd+4/dT1i0of+TCSwkwnm/H07JD7uwyvv1kZ?=
 =?us-ascii?Q?CqIjk3Uk1V2O2tSnbNIG6yw7fhhuoY4rGnNHH2kGqHXLV0exJHZN8oDi9VNP?=
 =?us-ascii?Q?TkZB7hCMjj/hf1S/N9sK9PiyaNbZqdpcyQYgO8ebLd5EvzYzIl2xLcHYHfCK?=
 =?us-ascii?Q?2DnJzisjFQfskRAvkEio2E9qMGItGzW/LXKsqaKkZZvnqv10peW1pXzidFtM?=
 =?us-ascii?Q?5j5IDT6/R0KXLazoOybp59ppY/vztfsT+tF3/uTbZMRzGhXDVs24E/PZnDBU?=
 =?us-ascii?Q?TDCJ3Sr9Fg2P84QYBv0lv//vkhlHSg6ox6oSuoOwBF6vVl1aY8+EZ5jOXEg4?=
 =?us-ascii?Q?uUA44ioxrD64raQocGyB5qMaPxrC4T1n58kICFG1LylpWQllWhT8eiuQYdk7?=
 =?us-ascii?Q?AFyHM7Idwp/xVzGb7+/ePCKVvw6tw28SieSSGn7TC2h7+jTFV4pdk/3zS2yU?=
 =?us-ascii?Q?+VmF8kGwOpqJbltA7gsGt42qRxkMJSfC5M2BoBuiCoSWemqsBafFdU2c5J88?=
 =?us-ascii?Q?/h1LA0JOs3qhxsc/fRRQrk9g9qGQLrMXnKIOoirwk/LKsByPZaw+rGJAyY4F?=
 =?us-ascii?Q?4GCR9NC+blSZupd2TdiPn48ZvhimSLhqCLJrsjS1WIJQEsok7lqacWpogBNr?=
 =?us-ascii?Q?oX1ikv2NRZ7btEVDbFp6Fp2rC6+YFZ+734QvdxU0wiM0JWJPHRNmsjsfySvC?=
 =?us-ascii?Q?w+E8jtHNIumoiYZtz9CqDkgWd84QUdy+P2JZhhHMB7pKI1c/uoCt+3ypkr52?=
 =?us-ascii?Q?M3ui5rMS7z6WaGTwd4fUmFX5kwrjCiHxX4peDv7sF8XcCkiv5mip8nqkOVq9?=
 =?us-ascii?Q?e+eKSaSLv6bcg4tNnf1LmEE5xWkhS1GQiPjMUOOaA22yHCX53TJ65/NM+udP?=
 =?us-ascii?Q?qwyTvDZvUu81Ojz9hkPaox61NSNIuLF0eF984gQNFPKaKN+1VZ85Jfs6h+zz?=
 =?us-ascii?Q?FmxsfWh8KMDu+FP70NUI9nIuODfPxvsTyDOjxuM20pc802qHquXpK+ez8U/2?=
 =?us-ascii?Q?nfnEJyjiGDv+dlirxkI81NJ40tjCWjnk6N273+xxvwbLFDxUJVUqH0qQqxjK?=
 =?us-ascii?Q?dG/YTfKr682MkCHQsQZeMUWQ9z1iEH4P+rgnCNt0OH3eqnZVbhq7EPjfHoc+?=
 =?us-ascii?Q?7Xq+VYsNNuFHELxtnuYWHFR3inFbDd1H6c5yoqIdFJvtcaxzpTVHkjVV1hY2?=
 =?us-ascii?Q?JttqtN5zcLfybfvP6F24NAHp2HOfYHyypRKVEfzL2/SAoFR6jKWaRmuIzE9C?=
 =?us-ascii?Q?zkzWMJzmZaVJ9zkeaMiCESYk5bQFTR/FjeII?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5q/H0cLOWiywionoN/YlsHnSzWXzmQ/VccEa2IT1Hx/Wfz5O5LID8+S81dQi?=
 =?us-ascii?Q?+a33xVU0gdbqWAMpIKIuJqJIMrmkPwMLWO7i47LFrX7IXMTp04MQWhc3uZMb?=
 =?us-ascii?Q?PJ4I+B/Odxj7og5AI1nKDjveyZ/tyVcX8tbg4YxceVtAb9+RUIOzDphY+PmA?=
 =?us-ascii?Q?XRUibKyF/0Bn0dEzb4A/KcVH9vKOxxv1+PT0lky0aR8M/tfKv2w4p+BtkF2P?=
 =?us-ascii?Q?/4706cafQaon9HtwvJsDYXkhBC7JflNha0l5EaeOMcuUqrrTyNawO8aIzP4b?=
 =?us-ascii?Q?rXQbu8C66pwP3SYc9SepczDx+VeXVooVEwc2BV8r2+/rIudZXNANnBiebXbJ?=
 =?us-ascii?Q?OXVIwcPuEXvV14dZezCkIM6i/l0lRe1rwfqb+nBvE7n4DCmKAZfepYY04Q70?=
 =?us-ascii?Q?UbxQtS04v1+TjA9X/WOeiVBUFkv53q2q9Yu3FreWRYmWOTTCxAuPD/LZ9hbQ?=
 =?us-ascii?Q?QjcjpykHwFTkbBhG8hXgWUjjfujGMZr3xWEyLqA53aiXkos9iOfHo7B0MVVW?=
 =?us-ascii?Q?04zVglgH83F/wg3Jikt3WAfoSIjiMegGYZLqCLwKu8yRr6X/5qYq801UlTkm?=
 =?us-ascii?Q?4Nz/k/YvU+Er3k9Rr52pZCplVK3dSX9fgbzh56cJVfACm/V7XhCwlQnvveQ0?=
 =?us-ascii?Q?q7qpiM5PuKs6fJ93jRaoWXneCzORORYHvqy/NF3wD9qHQCLSq9BLQHESsp3+?=
 =?us-ascii?Q?gCOmfw5wvIzd1AsJNyuRssKrDh+uaVeKM3iAMoqrzXpOw+QJV4jOZXbtp7d0?=
 =?us-ascii?Q?xYFKIAQ/AL0hzjrIbT/FmwDuU4h9IFn1hEdlLC32JfdEQMZzqipe/cf6cMQr?=
 =?us-ascii?Q?CyzLL0V+Qpx3czqns/eK4peFt6kGwTPYHAiRSvkIP8H8BlUsVfRS5mv6B3pl?=
 =?us-ascii?Q?yCEtX0p8oZ/g6sE9XP7ZWFCuK6bEy8+33aBtEKMCkrF/xq7HlaTnxk6plkWL?=
 =?us-ascii?Q?kYYCLu+rJPChQLfe/x5a3cXXyOYN+pS8BtcJGQfuP5OeTcfKXMsRCiMnogqO?=
 =?us-ascii?Q?K6Pf4dS4ENFIdYs7AqNn5PxJA/giukWw383/iK0m1j7qNzAxJsY87WT8WGOM?=
 =?us-ascii?Q?yVbzlDhdVJJFbUs5SX7nsPh6roHhMI3Wc8onTr65oW9p4npAEc0u4Cu8BhTU?=
 =?us-ascii?Q?aCn1USSzTE1vpXrm+pwDIq68fw87Lal+QRgVGwcd+qqgQhnAfrLs3rj7diyB?=
 =?us-ascii?Q?d2HMbVzrnPoUA7eay5bcjqWX4mM2lgr0R9wilWNYe4S6tf2Je70D1srOGO45?=
 =?us-ascii?Q?eOCwHG/ct+OX05fgBSjcyu4QHZhs7qenfP9+TYk5xBuH4OsrkUruuCCR4wCT?=
 =?us-ascii?Q?1fphAQuQ8RYT6CTCC9NShNLXPoGEVqsSy9F5bE9lQH/yRPX3Ic4zV1BYUQCV?=
 =?us-ascii?Q?skWnOg2ivh3VSLlTpvz226JgqrZJAlHp8BYGS9OvX7OF0YT2OB07lj7toJ1b?=
 =?us-ascii?Q?QuRncC/VxGmf6zXQsXX31GR+U3NAB/rZExu9eVNjIu2h0VdkUbqtq3B606Jm?=
 =?us-ascii?Q?AHyJsGeVBr40ceRrDHinGPWt50O/PHzL2wtv8Fs37ysnV8xcMy8Fq5F0NM1i?=
 =?us-ascii?Q?BzvMJsgGu6zykaWPw20NR9TyKURr/l29FsRVWcQFU3UXl+/3HxURQeDGIQUY?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab801a4e-e1bf-4c30-d427-08de1bf9fd15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 23:29:24.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnbRTua4KiukUVDSUtstIKss2eoQ+VL/QjRFr+Z99M0AQuCgGDbVuqCuXmgbb4z8P4Ov3d88so7bkANInX8S6qlM/oQz+D9BtVtSqdHYBqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7239

This patch series introduces support for the Agilex5 service layer driver
(SVC) in the Linux kernel. The changes span across device tree bindings,
platform DTS files, and the Stratix10 SVC firmware driver.

These changes are necessary to enable firmware communication on Agilex5
SoCs via the SVC interface, similar to existing support for Stratix10 and
Agilex platforms.

Agilex5 introduces the ability for the TBU to operate in non-secure mode,
making it accessible to Linux through the IOMMU framework. This key
difference enables improved memory management in non-secure environments.
As a result, this series extends the SVC driver and device tree bindings
to support IOMMU integration for Agilex5.
---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v4:
	- Refactor the logical check without using AllOf.
Changes in v3:
	- Remove driver changes in driver as it is fully compatible
	- Add iommu entry and rewrite the git commit message to describe
	  why the changes is required.
Changes in v2:
	- Add driver changes for Agilex5-svc compatible
---
Khairul Anuar Romli (2):
  dt-bindings: firmware: svc: Add IOMMU support for Agilex5
  arm64: dts: intel: Add Agilex5 SVC node with memory region

 .../bindings/firmware/intel,stratix10-svc.yaml       | 12 ++++++++++++
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi       |  9 +++++++++
 2 files changed, 21 insertions(+)

-- 
2.43.7


