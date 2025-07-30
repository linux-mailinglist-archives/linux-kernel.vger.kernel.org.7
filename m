Return-Path: <linux-kernel+bounces-750902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC92B1627B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2B3BE88C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7E72DA76D;
	Wed, 30 Jul 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="oXEV6i5L"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013039.outbound.protection.outlook.com [52.101.127.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5DEC8F0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884970; cv=fail; b=ivVTO1FCX9/I97B1S9YHZ5QumcnWGwrTV5N/2Sqjx/92pqJpyNt6mHCbx2mTC0IaZ9Xp0kbUYI+kG58XYOCTxw9HMIU+2/9sNVe2iJPXkJpYli71pR8Ea2deQ+YcQwfO4yUCxXHsKLrdK7UYG5qaQP0NTTY/lPaV/sSqlFZB9No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884970; c=relaxed/simple;
	bh=lEGehBQseTJrHwKtWAsUk1NDxrktwhiU4oepHCqRY9o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eOC8xk0aA+TBQb8KuNhf9WsGdpFOsEeUj0h8RQlRrmIn0WbNd7YZxJ8Ud0lhvult/k4t4vZjPF2+5iY+RCUWtJghcV6LUNQsBNXJGraoxIIOlZmDJcm3FIMF9szW5bjVnIaYiK3SbOl9j0/p4s2A6gHZGoaErL2Ou1Fb1DyK4i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=oXEV6i5L; arc=fail smtp.client-ip=52.101.127.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIVL0P6ADEx7g3Kr8tYSOKZMy8oMxHFy2h/XYpqS0q/e9lWkZ6k1PmIqsS4vXel52bf4qVR4oczh4RTZeMKMBTa5pan1NRkZpVDFdCBw3qEdgUsfGDfaFEMKp2XMMUYAqKzI5LZJmZsw0F+KVy8Tbw3HUqqCEErXFld4moLro4/YES+41r04/Vf14ISjmE2T4pWyeFaGKoiv/g2BGLxF8kD2+nEU9UdDihtFaYZlnTTk0TUqyxKrBgWt6ub9jqWLgIEp8GlNBogZT3MitzTIA9ffU9cpYuhY1VBp3XkoujPomLA5MWd6tBq4fHjs+Wf5sYn8GWvztDilz7Z7wDpI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3CasgspQbIFsK9qnm3ZrVR1wny5tvTG+/AsV0nDA3E=;
 b=k915uZDjTCQAaq4lSSxUVzXvOqtNFdiEKh+E8/fz/+LyD+ErUyQi3JS61nxXxHBtFI757Vd2GIj+WEiRAOtcXOEEVjv3w1jAivG9XZ9qn/86LQ2jz69CIpmFQqCXpsgkIzOQ66JEEWpMZxGY5X/YP4QkBxqX32tVM4qIrqAZj61PYPc3CoEGWhyxRYMTYghMTWqIu1ZE1jRYS8TM20qp4+Hx8XaLaEp8aYIxymXO+dGSX1ORU9ODg3QOZ1OE6UT+cdNes7EH5IDfq6UQQvypbjIV9qz+hjmVq2lAf7d4Dju7+iEvRbhk30wwMwWcZ2kf2EhkRBtrKHAOZFTeA4KLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3CasgspQbIFsK9qnm3ZrVR1wny5tvTG+/AsV0nDA3E=;
 b=oXEV6i5LLGh1piXkusCoFBnGDWnWtiSB8Ay9PtbQqSBebAUYA2HrIPtBSgmWlXdLy7aGRhcQacp4+OV7PCaIopjXbLjE+EFoOUwGnA/Nl2KS3NfgyU2j/IIVYxQkkRd2hjwZlYCaW22tLVMJhXnHatCjauXMqUXkXD7n5mJbbvnUxNOY9YCmsRI0ECW76qf3wVBbcXS8+VkCAXY01W5K4UBV8Mxb04xpVjTBISe9l26R8aXB/wVO+F2brjaLNWkFqXPO5YPxVPTf6vTY8O+u3IT8/r9d7iy3LqiUjjRCUFQY88bRkAbO2QYYLpk/Y6HMnx3AjR5YOjTwZP1wLkeuug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com (2603:1096:308::24e)
 by TYZPR06MB6990.apcprd06.prod.outlook.com (2603:1096:405:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:16:04 +0000
Received: from PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2]) by PS1PPF5540628D6.apcprd06.prod.outlook.com
 ([fe80::5f12:df6:9716:ecb2%7]) with mapi id 15.20.8964.023; Wed, 30 Jul 2025
 14:16:04 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH v3] f2fs: add reserved nodes for privileged users
Date: Wed, 30 Jul 2025 22:15:40 +0800
Message-Id: <20250730141540.603144-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To PS1PPF5540628D6.apcprd06.prod.outlook.com
 (2603:1096:308::24e)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PPF5540628D6:EE_|TYZPR06MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7ed495-5d71-4021-6a5d-08ddcf739e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6soCbp287X4o07dhAWxjp3OqXiMIO723eeR8DUxtnq3lks0HtqeTP6indsT3?=
 =?us-ascii?Q?17fCHehLOCIrZhvrFuENY77awDrbDSKBXWjk0cBJp8p3/VNW6IPOzqVooNoU?=
 =?us-ascii?Q?5rnnpQZSV24vbVrKImH1Do0k5wXtjJ6MdVcYg9oDZu2Hveawq2G+vnqWZkpP?=
 =?us-ascii?Q?2L+tZjiIftBTmEURiUPXnRHTKTFBZh9rN2fQYBaipzThkmTkOh4dHzfE/MD6?=
 =?us-ascii?Q?rplNvsQUV2PO7tck3sAPCwRe1xuG+ZbCSHUf6us1bFPHMrh7J+YGfUbOsTfi?=
 =?us-ascii?Q?lr1CeGI3zAcQwMhurAuNeFBYykuhGzDmNJ+zw11hUcUovIcykVbj19yMLWNy?=
 =?us-ascii?Q?m839nfMde5prf462/GZ1he10PSSiQ27ibxWbWqyNg8V35cHMe7s6ihOWFQdq?=
 =?us-ascii?Q?iF/ZbizyW1FMQp7Fwqxw8nm6YCcnRWrbjF2vMvJjtRf7Zp5NWkW5j++m6v7X?=
 =?us-ascii?Q?/xJLo9jqkj9ivDfoaZcLdEgc2Hed/iZyWpahFKScSP3tx4xm377x3o6d2ebZ?=
 =?us-ascii?Q?skUgUH6beG1UEoxQTWjr9sGf1Xd58OlFRX56xJXCfyiaoShfYUebYteYPZnW?=
 =?us-ascii?Q?SvXXjuOzzVdL7lQqkbcntp4E0BsXThCsj3pIWj/22f6J/4o7G/gP/x76qdiB?=
 =?us-ascii?Q?PoLUxd5MjLmDr2IvK3PN3y9FgmqC7JpdMrKB8AMGEVAtSBLRKEuJf8skqwhP?=
 =?us-ascii?Q?FdS7RexDDU44IRqOHTgwLCg6UUrsOiOWEXTIIodSXH+gch2rOwJFXGzmnMc+?=
 =?us-ascii?Q?ZrrWeilNEXrcvZvDZfXpN6YyOhYzeCvzyo2DakXBFl8MTKn5yz9ccw4Fdzvf?=
 =?us-ascii?Q?1wxVRvTxISpitvqlBRlkCxefMwTmwWJalX0ugV6JURPS2HUB4POcrHwUggYp?=
 =?us-ascii?Q?i5zUo3NQURh0WjFJW6KeenYzf2l0hRtuhqLcu3N61LOY/cLlbSjEv6SbLBFr?=
 =?us-ascii?Q?yWTSILe70vRViAKqXqSF0zpHHQkFANY/cjxqD927yJc0uOmNcsHEoB7qsnQL?=
 =?us-ascii?Q?LCKjLRDlEZJKLOV4pPUdQHt6RjtBGMG8Ctk0a2KJ2tyYCb/DKYRhXbdMA6rr?=
 =?us-ascii?Q?ZVKHgzVn69FAPovrcijnZz4jP8grrAMS2MAx4uXV3po+nfPl2r7IwDaGBIqO?=
 =?us-ascii?Q?86eG/72VT+OY1jgG7qKKUCHfACpk5YICPxETWMVwczmeMSrShPWwvpXt6kHT?=
 =?us-ascii?Q?FrydxWWXiAsFouZhOMurWSLUFl5pXiaoRkEY3/zsLFKl1ywlWKCZ2g31FZcp?=
 =?us-ascii?Q?IvcXk1eBNYgjKE9j2x4c+lZZ286gywOIoszuzEYjrL0RSzymDamiweYgyxM+?=
 =?us-ascii?Q?IFeTHGs7mA2An5y5v2pjAqFL8MSztb8bfM/mgPXsQ4MGkj801ZxHD/ef9apj?=
 =?us-ascii?Q?aVKQOg1WZYvqONmD6TuoJhXTXziHB1E5zTfpWQipv3iywmLf8fwguC0+MRdC?=
 =?us-ascii?Q?+nSvFcmVZkqHjcvU+7YpWTBINNypgUg6FutsPMjonuQWN4r4RRo430Zrwfn1?=
 =?us-ascii?Q?Qnii6MXggr89OHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF5540628D6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bsET2vAGA7K8ZhZIWXtAuI+RT1Dxj3tAum3GOBSfAD1uVGHfYjVCDPJSnvSg?=
 =?us-ascii?Q?5Rr3zs8asgYUtzWI2hW874hJJaWanyjHPBZmlap8fylFOFGs00MKU2AKT5Do?=
 =?us-ascii?Q?G4ACM0MdRO17MKKUNhJDrul8TSUETenegrfCsi3oxKgc+ZHYF6SJruoMRPnF?=
 =?us-ascii?Q?1sE6sDcJgTS6/h7R2xfWN7y3PlbwwgWvjuTG50dZd8GpJVtnZCW9Z96ui6Oq?=
 =?us-ascii?Q?8l62gQ2k/WRxqZ/ZjWTEX0DY8RNe4qhC4vf8UtWtTyR4CMPT2IjoeENQ44Sw?=
 =?us-ascii?Q?XQg3uULRsUAjhtRyT6RuKt83WHOmx471OGjy7A5gMDnBLEu0x2NT6ZpzSKUe?=
 =?us-ascii?Q?Ot8Gzg1VJ12WNss7Q4RrngoSDnPWKkuNlVGsmKpXmUbHtWF1YTHfQLQ+DfTO?=
 =?us-ascii?Q?AzK/IcS9aT3Kc413nsSnU/CyjAVNT5MIX/DSQh5mbKSFYyfoNzLt9ppJ8AYl?=
 =?us-ascii?Q?D1T+2npDZNMKfbdFcNClilLa5CjyvY5yNo060sv7wMZ7TCnlLYDKHnE3+pBp?=
 =?us-ascii?Q?J4Nv5fNbz/btBSVH5z+eTCb7SJcB87V+IcWmnyVsMzUDTJ4/gHK1lwNiocYv?=
 =?us-ascii?Q?scThQNfXxXz80LGOtiWI/NJ1OxdxUaX3RbMRlxtaRL/I6oMyd1QUO5u3V/Ih?=
 =?us-ascii?Q?6+v8NBrUxpc5FSnzwcmpRCqFVrc90z48Tsjdi4AvFmaVJAHdpzds7iXV1NqL?=
 =?us-ascii?Q?F1m72VjPDRCOqTVI6WCjayPVoiEXWpyICo4w6b2DgxfYP+igSACSf38aqGfg?=
 =?us-ascii?Q?GIdgv2CCEz8x83xWkZZcDfdWAQwZyyFtKdIipE6iaxCRoy6BP9ZDaxPM7c0L?=
 =?us-ascii?Q?Cm72tAU56XYFX1Lx1VyuqqbV1HNC9LY9dUciVZ8Uh9u4EnC/UN7iUavbd2z5?=
 =?us-ascii?Q?2eXRvTsVHOJzF8xxGVnWl2Cj5rX8/Y+UfAQq2LyQEFx8rao3CSus6dKdKBhC?=
 =?us-ascii?Q?bB6suMLmVFwqIHKX+HDxmS2w0+Qprwd8zuflokhfQsbzjl0vTyzL1pQ+xH8x?=
 =?us-ascii?Q?x2mLAL4CmXyzsF9JY+n7q2O5TCWBIIUYLKi+YTaqRFn/NDxpKekOCaxrzE4L?=
 =?us-ascii?Q?njnvccsovP7BVbPPdeM4J/2PlmhV/11CiIe9m0ov4/iPs06vA8Ef1AnFyTKV?=
 =?us-ascii?Q?VauG0N4Q0CNaB/BPR2toeW5NTeoIqHi/2mbNlSCUtNYpcThBOWhPSkTjNDt7?=
 =?us-ascii?Q?a/FPCL4DiRP2IqutN70/OdA9xbSFxf5RnTga+sz/ly7W4F7YaKNwmdbyWvXG?=
 =?us-ascii?Q?C0HMxL1al1oPJCDLIRtsr0N4K2dk4iXKsZdPJfRXVB4yEp70cqqBqcnTW+Gd?=
 =?us-ascii?Q?kXGG4hUYOx+D23SdQ7EbZgu+SEDoMOddmJp4qELkCz/ggb4byI88fsouWgPW?=
 =?us-ascii?Q?P6JGORqv0ah0TxOI9a2/TU7v0dCBNZS8Y/sKMrZWHIIUfxRjK1kFMr12J9RN?=
 =?us-ascii?Q?hAqysscpqmcoyIPwxTYH7XpWFB/hL97A+UTMlk59Ki83Qc7pkO/Tb+MIcclw?=
 =?us-ascii?Q?XhTem24JFGNy9SYAXLO/KuBKltDz7sZOsMUtBbvTXA6yRGB9wzCEVod5UveO?=
 =?us-ascii?Q?sxcarNORCcuSdtrrEXsFACtBwnAe9CEOk95IUpKK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7ed495-5d71-4021-6a5d-08ddcf739e2b
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF5540628D6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:16:04.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVecj4p9x6m8GLwjlFXz4MYlci2q2eCJ0SJ1nZyBhsJhodvQysmHK6ROReTfvJPHFqz2LGFuHRqO4bcxPK3S6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6990

This patch allows privileged users to reserve nodes via the
'reserve_node' mount option, which is similar to the existing
'reserve_root' option.

"-o reserve_node=<N>" means <N> nodes are reserved for privileged
users only.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
v2->v3: Apply Chao's suggestion from v2.
v1->v2: Add two missing handling parts.
v1: https://lore.kernel.org/linux-f2fs-devel/20250729095238.607433-1-guochunhai@vivo.com/
---
 Documentation/filesystems/f2fs.rst |  9 ++++---
 fs/f2fs/f2fs.h                     | 17 +++++++-----
 fs/f2fs/super.c                    | 43 +++++++++++++++++++++++++-----
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 03b1efa6d3b2..95dbcd7ac9a8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -173,9 +173,12 @@ data_flush		 Enable data flushing before checkpoint in order to
 			 persist data of regular and symlink.
 reserve_root=%d		 Support configuring reserved space which is used for
 			 allocation from a privileged user with specified uid or
-			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
-resuid=%d		 The user ID which may use the reserved blocks.
-resgid=%d		 The group ID which may use the reserved blocks.
+			 gid, unit: 4KB, the default limit is 12.5% of user blocks.
+reserve_node=%d		 Support configuring reserved nodes which are used for
+			 allocation from a privileged user with specified uid or
+			 gid, the default limit is 12.5% of all nodes.
+resuid=%d		 The user ID which may use the reserved blocks and nodes.
+resgid=%d		 The group ID which may use the reserved blocks and nodes.
 fault_injection=%d	 Enable fault injection in all supported types with
 			 specified injection rate.
 fault_type=%d		 Support configuring fault injection type, should be
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97c1a2a3fbd7..70f32c118dac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -131,6 +131,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
  * string rather than using the MS_LAZYTIME flag, so this must remain.
  */
 #define F2FS_MOUNT_LAZYTIME		0x40000000
+#define F2FS_MOUNT_RESERVE_NODE		0x80000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
@@ -172,6 +173,7 @@ struct f2fs_rwsem {
 struct f2fs_mount_info {
 	unsigned int opt;
 	block_t root_reserved_blocks;	/* root reserved blocks */
+	block_t root_reserved_nodes;	/* root reserved nodes */
 	kuid_t s_resuid;		/* reserved blocks for uid */
 	kgid_t s_resgid;		/* reserved blocks for gid */
 	int active_logs;		/* # of active logs */
@@ -2355,13 +2357,11 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 	return ofs == XATTR_NODE_OFFSET;
 }
 
-static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
+static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool cap)
 {
 	if (!inode)
 		return true;
-	if (!test_opt(sbi, RESERVE_ROOT))
-		return false;
 	if (IS_NOQUOTA(inode))
 		return true;
 	if (uid_eq(F2FS_OPTION(sbi).s_resuid, current_fsuid()))
@@ -2382,7 +2382,8 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) &&
+			!__allow_reserved_root(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
@@ -2740,7 +2741,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count;
+	unsigned int valid_node_count, avail_user_node_count;
 	unsigned int avail_user_block_count;
 	int err;
 
@@ -2769,8 +2770,12 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 		goto enospc;
 	}
 
+	avail_user_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
+	if (test_opt(sbi, RESERVE_NODE) &&
+			!__allow_reserved_root(sbi, inode, false))
+		avail_user_node_count -= F2FS_OPTION(sbi).root_reserved_nodes;
 	valid_node_count = sbi->total_valid_node_count + 1;
-	if (unlikely(valid_node_count > sbi->total_node_count)) {
+	if (unlikely(valid_node_count > avail_user_node_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 30c038413040..a24e855a38ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -143,6 +143,7 @@ enum {
 	Opt_extent_cache,
 	Opt_data_flush,
 	Opt_reserve_root,
+	Opt_reserve_node,
 	Opt_resgid,
 	Opt_resuid,
 	Opt_mode,
@@ -265,6 +266,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_flag_no("extent_cache", Opt_extent_cache),
 	fsparam_flag("data_flush", Opt_data_flush),
 	fsparam_u32("reserve_root", Opt_reserve_root),
+	fsparam_u32("reserve_node", Opt_reserve_node),
 	fsparam_gid("resgid", Opt_resgid),
 	fsparam_uid("resuid", Opt_resuid),
 	fsparam_enum("mode", Opt_mode, f2fs_param_mode),
@@ -336,6 +338,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_discard_unit			(1 << 21)
 #define F2FS_SPEC_memory_mode			(1 << 22)
 #define F2FS_SPEC_errors			(1 << 23)
+#define F2FS_SPEC_reserve_node			(1 << 24)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -437,22 +440,30 @@ static void f2fs_destroy_casefold_cache(void) { }
 
 static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
 {
-	block_t limit = min((sbi->user_block_count >> 3),
+	block_t block_limit = min((sbi->user_block_count >> 3),
 			sbi->user_block_count - sbi->reserved_blocks);
+	block_t node_limit = sbi->total_node_count >> 3;
 
 	/* limit is 12.5% */
 	if (test_opt(sbi, RESERVE_ROOT) &&
-			F2FS_OPTION(sbi).root_reserved_blocks > limit) {
-		F2FS_OPTION(sbi).root_reserved_blocks = limit;
+			F2FS_OPTION(sbi).root_reserved_blocks > block_limit) {
+		F2FS_OPTION(sbi).root_reserved_blocks = block_limit;
 		f2fs_info(sbi, "Reduce reserved blocks for root = %u",
 			  F2FS_OPTION(sbi).root_reserved_blocks);
 	}
-	if (!test_opt(sbi, RESERVE_ROOT) &&
+	if (test_opt(sbi, RESERVE_NODE) &&
+			F2FS_OPTION(sbi).root_reserved_nodes > node_limit) {
+		F2FS_OPTION(sbi).root_reserved_nodes = node_limit;
+		f2fs_info(sbi, "Reduce reserved nodes for root = %u",
+			  F2FS_OPTION(sbi).root_reserved_nodes);
+	}
+	if (!test_opt(sbi, RESERVE_ROOT) && !test_opt(sbi, RESERVE_NODE) &&
 		(!uid_eq(F2FS_OPTION(sbi).s_resuid,
 				make_kuid(&init_user_ns, F2FS_DEF_RESUID)) ||
 		!gid_eq(F2FS_OPTION(sbi).s_resgid,
 				make_kgid(&init_user_ns, F2FS_DEF_RESGID))))
-		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root",
+		f2fs_info(sbi, "Ignore s_resuid=%u, s_resgid=%u w/o reserve_root"
+				" and reserve_node",
 			  from_kuid_munged(&init_user_ns,
 					   F2FS_OPTION(sbi).s_resuid),
 			  from_kgid_munged(&init_user_ns,
@@ -841,6 +852,11 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).root_reserved_blocks = result.uint_32;
 		ctx->spec_mask |= F2FS_SPEC_reserve_root;
 		break;
+	case Opt_reserve_node:
+		ctx_set_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
+		F2FS_CTX_INFO(ctx).root_reserved_nodes = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_reserve_node;
+		break;
 	case Opt_resuid:
 		F2FS_CTX_INFO(ctx).s_resuid = result.uid;
 		ctx->spec_mask |= F2FS_SPEC_resuid;
@@ -1424,6 +1440,14 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
 		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_ROOT;
 	}
+	if (test_opt(sbi, RESERVE_NODE) &&
+			(ctx->opt_mask & F2FS_MOUNT_RESERVE_NODE) &&
+			ctx_test_opt(ctx, F2FS_MOUNT_RESERVE_NODE)) {
+		f2fs_info(sbi, "Preserve previous reserve_node=%u",
+			F2FS_OPTION(sbi).root_reserved_nodes);
+		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
+		ctx->opt_mask &= ~F2FS_MOUNT_RESERVE_NODE;
+	}
 
 	err = f2fs_check_test_dummy_encryption(fc, sb);
 	if (err)
@@ -1623,6 +1647,9 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 	if (ctx->spec_mask & F2FS_SPEC_reserve_root)
 		F2FS_OPTION(sbi).root_reserved_blocks =
 					F2FS_CTX_INFO(ctx).root_reserved_blocks;
+	if (ctx->spec_mask & F2FS_SPEC_reserve_node)
+		F2FS_OPTION(sbi).root_reserved_nodes =
+					F2FS_CTX_INFO(ctx).root_reserved_nodes;
 	if (ctx->spec_mask & F2FS_SPEC_resgid)
 		F2FS_OPTION(sbi).s_resgid = F2FS_CTX_INFO(ctx).s_resgid;
 	if (ctx->spec_mask & F2FS_SPEC_resuid)
@@ -2342,9 +2369,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
 		seq_puts(seq, "fragment:block");
 	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
-	if (test_opt(sbi, RESERVE_ROOT))
-		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
+	if (test_opt(sbi, RESERVE_ROOT) || test_opt(sbi, RESERVE_NODE))
+		seq_printf(seq, ",reserve_root=%u,reserve_node=%u,resuid=%u,"
+				"resgid=%u",
 				F2FS_OPTION(sbi).root_reserved_blocks,
+				F2FS_OPTION(sbi).root_reserved_nodes,
 				from_kuid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resuid),
 				from_kgid_munged(&init_user_ns,
-- 
2.34.1


