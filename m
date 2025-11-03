Return-Path: <linux-kernel+bounces-883787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A680EC2E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A4BB4E5BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A962FF660;
	Mon,  3 Nov 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wl2pFG3P"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835529BDB5;
	Mon,  3 Nov 2025 23:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213186; cv=fail; b=T4CZ86fySOwkyMg4PuRKjaeJQC8lFcWzc7M0i9lzJLHyGfzwc0hh847QC4unPMp6kW0i7mmRJVRvhMA/YgrLwTiJFnucf7CklUKja/MLdlkebZgWrxNx/ZIQS+ibdfgQEvudWDb0Gw5FawW6lDslaJKKcJgLH66mdFZnC4YqqDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213186; c=relaxed/simple;
	bh=OYcjTFOxL49PX94Nc7U+wErfJId7tVQ2oCc4E7JZHSs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qynf52g+DM6AH8uSL/QxD7DQ74VTmoVdFTYx2meyE39ZNfuT6MCZbUBvt6SQ3OJzt01UwABKR4IYAZvIwp9q9oIN5wlbnzb2yGkMPFZbixxz85w8sWUhYpvp3G6o85jpnsl+gR/Xi8ukFUgw16eZ9i2eOrFObtM4eAA+FrRWomU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wl2pFG3P; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWlKCxFqZ5Mqi+u6zzfb0cMEcLyCaCTBOG963LeCY4YtVrz3hfEJJ9/682KeOD2r5PSO+RBwYT+VQEsIAlKeGCD9OHO230WvKbsEG+gaWrxmj6p5Z97kId9xX8mWudNmj8KF4e04qBGPgcU0NDTR/BZ6/+a5+gkh6ovSV+U/ORq+ZW+ScJip9tCQoZF5Q/2LoGQPMT4WorZKkHZeTaOkLrhOOoYQPLk24Ms+Zh7X1yDd9doRZxPMLORGMxjoUfROj8GIera9KLCUvk73jgJIzdkxPFDYPz1w9QaGLJGlIrU0rw0+O83L8sRRKlavvku69ApDm/Vyp1nSqjxKNBGEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+UKR6y4Pzp2Z/1G1QQge47p784TwnBLomRXIMZyIOQ=;
 b=MGhVZSCHXBVXWZDyh9pbZ/TnIuYfxXiCYgz9ql5XjEITJmqeK1vHrhuiVEbW2RoJ6YixW7x1mj93oPDOk1JGfYiq/SdPxMVZl0DopXmzoWzrYlvuJvP0ahEXzKSPqaBoRHmaJGThbNXaaXox1fTucxsouHOVOCZjrFjFCixY+TN+bmKZfpv380tiAM+//na8Q2f1B++IYcULCUd+QpYV3E8tbFcv/yUkuCIVNFXxWT4UPSKGgu7woTNEkvVdnkWIt/hmGhj42K8cXEV4/+lACrlX7wxDS9s9aFPtXwOhE9pES4Pb3mpsei7hz/HaAUE9/OTHKbcFgUdrZfvkjx2LxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+UKR6y4Pzp2Z/1G1QQge47p784TwnBLomRXIMZyIOQ=;
 b=wl2pFG3PpvGWyDlXsDqe+wS0+uJZUUPe9SX+C0rjKf5fWpWts+EJSfe6gq2X0IUBF31KaTbQOWVQqzsPgeYhO/IydVn1W/XQRS1wj6iZLH5euPPKsqoB6ag/TJeUVka7hoCGo0nC4DTkoGy26qCpzOsFFIA4/cSMueN6h5aSJEdSU1vx9AZpbI2grsw9HMN0Br2Q1VGQSzyxKGEh6x36Ra4q+JcQYuMGJBaxLnugZFCVzPQ7QQ2YYkavNYD/bgCU1absYyInShVmaaGpSuPlkCkdNZeFvEJItRI3/9XUdM6LhaT3WZgB7Wt/fdH8OH53iWjGpPaIjlBwUKbgeF13sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by MW4PR03MB6538.namprd03.prod.outlook.com (2603:10b6:303:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 23:39:36 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Mon, 3 Nov 2025
 23:39:35 +0000
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
Subject: [PATCH v3 0/2] Enable Service layer driver for Agilex5
Date: Tue,  4 Nov 2025 07:39:26 +0800
Message-ID: <cover.1762135710.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
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
X-MS-Office365-Filtering-Correlation-Id: 3280fb1e-e1cc-4de1-b8b4-08de1b323f1a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mjkx9akpiAbASm3tNRXAnSqcsE9d1x1gwKDx+sQUfnt6/jO+EarnjxAWErFt?=
 =?us-ascii?Q?67v6PtVcGc0YOCYNB9kFI6FFa6cujwS1f5ln58TtWuv9J64vO3R/QenBB+Ya?=
 =?us-ascii?Q?oyJSqixNWc+diPyW1VbIP8W73eBjmagPJ6nZQAab9esWtOkNjlplC+f2UeVu?=
 =?us-ascii?Q?n29RRaIvR8pbZngn8m3MsOZw7RjQxP4zFtFSbY3eQvh0qDYn4Up6PCHcUCLc?=
 =?us-ascii?Q?cqw81SUHsGn8y4oUgAgdWQ6pbfE5KbKQG88KzsFk1dtwiGFru0HzMHCLHxvS?=
 =?us-ascii?Q?R3z0rYfZb9/LJRa/sm+MKE5p59Q3euPqRYADNXq7UU0PYVzzZG4UuBd8a3UP?=
 =?us-ascii?Q?XxLJBjKUksim94bVf56jL1xCeuUZLhljMJU9+0xcbgUzS5YrmQrs0EdCSyyF?=
 =?us-ascii?Q?hKorZeQNHc/FR5diRJnfeI6aS0O7jhs5rAL5Ew3zOKIq6PvOF+mWn4e9XgXY?=
 =?us-ascii?Q?jhEbSINBFSERtG/hoLo9SE0AjNX7YmmTW1W79/EgF1ChpnxHxp7EQ3EZ+Qor?=
 =?us-ascii?Q?WCSTrLxIdLeVSI8cKxToe8xu9bsOUpD4klkbwssiaQrAHkRJ4jiei6mHBFxq?=
 =?us-ascii?Q?slFdttCXRRKiqTKrxWvLdm3tKs1T5xR8xjAJV4HLLuRzICYz5VbLtVpPQE2E?=
 =?us-ascii?Q?klXxXpLEx36exa9mFUzh9LUx2z+ZUQxDGhFLeRX0DF4CYahh/bY7XptjMpjk?=
 =?us-ascii?Q?tE8r03aeAhf1m9VO8ZR/ijDzC3Pi9XQqaNiQ1D57rtP8QCqmXn9UM/HEl+//?=
 =?us-ascii?Q?zFM49X12Z7whpeL1AI6HxjwoXMCOBxm0R/+7zniigNjxOaPewXV8cWREGG8D?=
 =?us-ascii?Q?xdjfOw+cRXoxWQAmjIT918ApALcdKAzRROPHnpk2qRSDEQnEKLwQypJ4ygxr?=
 =?us-ascii?Q?/e54RP+hr053S+Uy0jnOQNKtr5vEFmsQ90SNy/39Qh4WspA2KUfcKUO+vL/y?=
 =?us-ascii?Q?sfUF1T/XlBKlPlEbn5ZkOEkHWwBpt/Vjud3P+T9QatKQ1NN9YqOWm84Xq9TK?=
 =?us-ascii?Q?8See90bSOO5EDXCwTcKYKHpxqGJzzqjieK08rF5M2sNZeMhpS/Gn8uaVzljT?=
 =?us-ascii?Q?HVbHP0qlWtmaJnXne/4qP0yeBpoZbtyIWPKcBqF4vbZqt4EY1l37QugFw/DW?=
 =?us-ascii?Q?d9R+PZejFy6yv3wgnU7MC/wBoSTJwun6R9HJzqdH7J8MHvu56aNMecPkPt5T?=
 =?us-ascii?Q?M+ZeuW773z3DYL25YjsBqPRwJPn6EZh/qhH6LNqDPsUm200/xBQyGK9sBuKB?=
 =?us-ascii?Q?w/y49JYf7Jw5+9qUddXoYAGCZBBebDewssgX8An7ciw4926WflivZdAFu/9B?=
 =?us-ascii?Q?ivlqLAJN7yWDv4jhcDm3YJFK6b8rmZoWCqJZwYXU4Z8MhmcR0VfaBSULzglh?=
 =?us-ascii?Q?Mpv3B0u4kJ2/i0fbaS/g5hxN7vZeAERYLmAI0R42a/mPNq1Qhpjmsyq/Wlmg?=
 =?us-ascii?Q?xpGTSEJZkQ+nbsrgxoqPljsH0cwlOy6N0w0n73S/YZSVBTxS5WNLr13YPM4r?=
 =?us-ascii?Q?Znp+kZ7Sd54VJ50PexhXk8EMVoPn8cpHyU8Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wLbLiplJ0+KfQVTlK9OKEdE19t9jZATWHts5yk6pMi5C34daZ9tDHOAP7B1?=
 =?us-ascii?Q?Kh07VBPsnlfu+yreUqTykrYsuSD7IEsKDsSEnE4q1AAt4kUoAzyXQMajqcX/?=
 =?us-ascii?Q?+Fc65rDnadmkwtAQvP3GBzSWMv0UqWBDl0GovEK9OSdCGLii5k7Gf9w07llC?=
 =?us-ascii?Q?Ii3A6EmigY39JMdxVsoTOXrnmX1bCjmERlpnMG3Gq8JhqYf4HxJj6IDJatR9?=
 =?us-ascii?Q?Fl2ZS7sBlwAhSgI6OSFprz4vGP86o5/ZPZNZNHHaXe8Tv8OwGlPLoAXslBwR?=
 =?us-ascii?Q?KTPn5pVb5OZIcBIp3uba84JwcKvP0HsJNIdeU1cnQyV3KuO7CKl0jrdk/bkO?=
 =?us-ascii?Q?w2ApeBFyWwA9SPCz6oAhILJClcAL27WefPL4xCZ7z1ivM2D/GgOEXQDXB+xK?=
 =?us-ascii?Q?LnDDVaKw5RqgtH9P1Zf8GDimSKj+i/46PovOY3DLGkYmxBwbKZLA2QATUY2C?=
 =?us-ascii?Q?gRfIZDcfHxpBck53ATNo5QwF7/4EUUNcPoLxAsX3x9VClqw8OpCYIhE0z7sc?=
 =?us-ascii?Q?qn5TKba5kIXdyDXkR2h1xyNdYvcbudy5H0A6rSO0Tzuc+hjCb0OrrunqZtsK?=
 =?us-ascii?Q?lt/M7/gws9a2kDPwbHpvEK/kPN3I1p6YZIXXKSC45INGCHRk72qXfbxMHnyG?=
 =?us-ascii?Q?nrE66+ZIs959OerRn+aYEj83dEUko/yOWLGJMwwR1je6NRVd0hXC48o45APc?=
 =?us-ascii?Q?osREioP0g7HBbFqp8iDH6KjPJ7qgLqFgI+ks9afynSp6FLTexyBdyRLqnTsI?=
 =?us-ascii?Q?8iVjS3YNFn4J5AdQOPW96Smtgl7RlMNQ9VPqbhhelXDCkgJBgu+D42FW4pjA?=
 =?us-ascii?Q?9es8zKzBrl4BwQwn1HVWjMtdNKIs08msWjCVOvC4HsF4vANVauLNgwl1Gajv?=
 =?us-ascii?Q?/iFjaAHdMCfI3hFYstELyNUW0bVdckMhvTyKi9fOiH08mEn1mZofTFS++rA6?=
 =?us-ascii?Q?CweyM62kN1xE1/cd6jg7k2pk/S0VFKKXDxvBBmZWnv2E8/Bi5ej+WzTGo7MI?=
 =?us-ascii?Q?swJ+s9xOOnt0lAWefCkrVw8ebLqH2DzjBdufilpIOjygnL9DD6lQBqa1f/4e?=
 =?us-ascii?Q?JoQXmbpebJOiuGQ5OqONwDX8UOFUliHQl67Yo5G984F+lK9Ug2GWVLR4bhAD?=
 =?us-ascii?Q?DS7sPG1ByZl+3QBUYVq6xjZSma5kfCGZM5oj9O1/+JWcsqH7AZwVQTIz1KLL?=
 =?us-ascii?Q?YZZpHawvjEA8qGyg1NJx8YlkGAF6xCvqLbnOx26zWhdhPKvO+y7YoBl7HadQ?=
 =?us-ascii?Q?i5MphuL3QQPNHOeXfwVIXSOYe3O9WEpB1M+JtJo6IdDUipLbDnVDyFzWKJpu?=
 =?us-ascii?Q?yraawoLcUQijcp2vOuVydm2h0k36ESra4qnRO8tOigAiZZ+bfSix/NXvyDkz?=
 =?us-ascii?Q?NDmvFNTaISIi310nAfYUVgco/DtcNoEOaC0zSNIhbzE6BTwqDhf+2xuzBfp+?=
 =?us-ascii?Q?Yk6YLjMAgBonOoluj58EtgX2PnVsLn9FX0tyxLzWcz4QGG1+46xwU3GEaX8U?=
 =?us-ascii?Q?EU2qR8tXPI3iv+X7YaZQSx3Sbsq70OdcROgVPdE+ksejOVfB4QntdKu231cn?=
 =?us-ascii?Q?MzIxJcGtG+PEgbhSvAdQ6drDgfrG5AF8yzJFjhY/OSO7LExXh1eyO2niJ470?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3280fb1e-e1cc-4de1-b8b4-08de1b323f1a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 23:39:35.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICJ+i4rq2S61Pxhsq8WVvy/4TC1WJ79RH5pvVU3u3oTZa6TTENRlyEglVxzfETzViNo66R/K7F0GkxF1dZZk9AEd0o/nSsq2W/8gYj10QAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6538

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

 .../firmware/intel,stratix10-svc.yaml         | 20 +++++++++++++++----
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  9 +++++++++
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.43.7


