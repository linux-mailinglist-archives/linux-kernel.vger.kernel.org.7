Return-Path: <linux-kernel+bounces-784777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9127B340E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE516A273
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E6279357;
	Mon, 25 Aug 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ef+JteHp"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013047.outbound.protection.outlook.com [52.101.127.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC36274B37
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129027; cv=fail; b=TKv2E5gNP0lMG01gVhIEjyM9ZWiq4WF9/f/91kTqi6NFPQDFfNs3qUhIkYe5tL3a4TvMpTnqovcq6vcAuOPCJ+eYZXXILouIFGT36gkXhTA437pq2WwsXDoHvPDN5SJXId8Xn+cwfzGlRe0D0C/NcXveQB7f471eovgmVAEbU5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129027; c=relaxed/simple;
	bh=q0z43gLqdzz6XePCINsyEfdJVAHMEYxYWlhOBfsWGdk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bvfXAG91jnMDD6wsc9fBNe4oBMXjB+jYbv/FJn/10Vf4vucQRTLZqQXB+sERd4rBVObaMJEgJ45G/RAGjEyfs/iEj8888JwErr87xNSCNt/2wuSe1i1s29CLpZs/VgSC1QF88XWPwKYKIZTqW1CUQB30aSFN9vT7Au4cVqwl2lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ef+JteHp; arc=fail smtp.client-ip=52.101.127.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsjm/p1zDwAcKrr6PE3dNpPqNO/AFYyHfAh1SIpgjawL0a9DpNY6Ez6SuV1/OLFHAvRhCmCGCFZ2aI9u1v4L8M9QN+hyA6zFZan12EmozuJ9LpBa04fy4FIeFbo0nUDv9eRP3Vlrh6Rm3QnsiAUOh5k8BIdEd8zb/pimCh666/KJvVbEx1inyeJgcU+UBC4E12e1qCNWqq7zyqmMKl6DpCzQSMdWFl98knDNd9yljdHX5sHN6QjP5QAlqwnL5+C2zYE2Ei4uV50j34nJhxMmnORTgrKOCJpzKZBpn/7yP/pGZrW/RUsVWhTDdBAwXaMpIutfsqgHowq3YUngHI3wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibYwYm6DWdbbC3cHOdNNm+FYoNK3jWJdWlPfkpoXXlI=;
 b=RdskOaU/KxIEZCjtciQdSqA5oOV2OA70S4AyM+PRw00oRrWczRIgdTai1Hd2B4sXd8tngQzNOx0waLiJM6DuV3PFSQtjxyIkC6unHW0ltF69u736LNANt6BAwthWanZD9M1pKpn756WYyQpnFFNwhx3ZNd8eAZgMkuEupA/N9/V8fEv80WnXipUPP2TmTE3sDRgDrO2I6WWnCAUH2F256gv1unbyuWPC3Nq1lN4vgCtP7O89BEJ7z6v6MKg1+9Qazw+TK7wa24kNLG4suDlRQCwEUdbRsA22BNZuUvkRC3U9CoboND7ynEkopGx4nAn6pEXB2yI7lf016/hxKgR+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibYwYm6DWdbbC3cHOdNNm+FYoNK3jWJdWlPfkpoXXlI=;
 b=ef+JteHpRWWnMeQj0rFqkPM+OoWYx/EoJgXIrecGfs7qIb2N8pdi6/2FukcZFabb0ngHkwo3gu7RHjeeUxlca51j6ygwNuv+n4zopNhBs7uaUFsuFBslEr+TYcOajlTk5h4mVunfHdSat24e5/xaztxriNAjqyCyyth1bz5lVeacO9XqrBLGlXQBigTkGO8HT0vOagMmCPQjO+2u4814oVgJEnGzLdKkMeuxRZR4CZqY09f9VQa+8W0g1pF1QII1gTrnAs35TAvX1CVltQ+t78uyLyNM86cLBcNhmeAnys/Hr+VFMuQTHrlWJlYYdej9GSrTrMzxtBRbouLi98hLeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB7023.apcprd06.prod.outlook.com (2603:1096:101:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 13:37:01 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:37:01 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net (open list:JFS FILESYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] JFS: Remove unnecessary parentheses
Date: Mon, 25 Aug 2025 21:36:49 +0800
Message-Id: <20250825133651.337691-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: f70f866b-5e6b-458d-0661-08dde3dc78b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sFnEvLM/vnOgSwhwczdlLZNKURtaRPs8FwYPC0c6n1ZKSjXHJxiOD87DoDmQ?=
 =?us-ascii?Q?WYFTG5fnK1kBfJKvBLDCvJH2jgh3ua15oe3W0RdLp7QM6M/5kK2EgvfzjMQO?=
 =?us-ascii?Q?Fl4oHdVVU2CfxOjwNfOOVBYXnfELrLcRtvlrXgtCIFTA3xpnXuSVyo6uzOa7?=
 =?us-ascii?Q?PtHpxPEVv5qWSrz+k0aiVY6kTkfGTrgoGef6wwNwa2m0w5PFvLdEPSpEO8x9?=
 =?us-ascii?Q?OCJb4pTKltwk33iJ0rI16g0v+KYfG2mHdxI0hEbhFf8clEgU2WLT+EW37tK3?=
 =?us-ascii?Q?Fr7uWepkjwPAQzLobp0Ltz4KIuXlyaUdUjz0eYarIcfOAuq/iY9sm/3XWHXk?=
 =?us-ascii?Q?yR6O4d4CoBdRMxAVuxRZAnTO1RM2NcpscZ99a/rIuFmV58y6RTq6XasWr5Zc?=
 =?us-ascii?Q?MITzUfb3AWpzrLr2iJbKGCwAYmqyu3G6P3TxEHlTdOR1Z7gB2WkUyoriFc2Z?=
 =?us-ascii?Q?aOa+Wq1F6u/+c9ScQO+b/p9eTpaIl+KCMRtdOI6Nw2FQDncyESfIs6n5EeEK?=
 =?us-ascii?Q?x40iGPJMoPaL2uXw13fj0AYeccKx/SDDE4AQ9exIQGZfYfdGlV/VnSukJ3Qh?=
 =?us-ascii?Q?bUoYVSKFlCKxGildajMDHV8g/zNaJOS8Rai3KL9sVtcFh8ZtK55OqAkpW9l2?=
 =?us-ascii?Q?yAKTFYDVcX6bCaXWhzOtyQvNQPiML1P8y4fAhY5esR8Ujew0ODETio9/8RgS?=
 =?us-ascii?Q?lpePK2pSYSwer+a1JDeWp2DNEQr/1D1BWYgje8u8EySoTQTBQ43o9OvtzsRx?=
 =?us-ascii?Q?8SnhoCmVAsRyCO01kKtFzIzUPhxEQQW6aVy1KF17lUVxO/c/0cNwpFzD2Vk5?=
 =?us-ascii?Q?Mo7Zi9+AUvK/GWhZ+5xwaW99TH8oBgPJO1TpKgVAbYrOybi1rgT8H3LCGKaf?=
 =?us-ascii?Q?Ph419OYTaUqYK88rD56YBv8MVSSFP104KTh13/FApQ5LyOZJbVIUJ8sSrnr5?=
 =?us-ascii?Q?c9bgdQomt0By4I+KVHd+CE3329L7HvrLna8Y0vseK7G+M7mAYe1lmVtYJGJ+?=
 =?us-ascii?Q?sE8kBGqJzObxDbKUrDypT3mlFsYOhIuxXzyvTK85jGH9BqEaqHkzNEXt51Jm?=
 =?us-ascii?Q?nvJ79BT10lvubD/sB3+QLjl3QVrihvp2ix91c2/WV5IM8pkJV83M1PJALw4s?=
 =?us-ascii?Q?rM9m9ddHgipqiUpf/f/1OMzvLPbikpf3tO8X1l9nXXqeknrq9O2ZwIvtNFHb?=
 =?us-ascii?Q?LQVwuQ+wq+nOWidMtrNROqatvaDe3OwriIg+VgQH1qFGOrkQzRadaZt1LBCR?=
 =?us-ascii?Q?T0EuPZcDHK2SMLi2OXiWttgyY+0yY6NZE6ZOFkp6scl1ovFfD77SfR0qzHKE?=
 =?us-ascii?Q?AiCq8Lu+KBGRvDCMX9Vfz1iEZCvgESi6zw5bvrvDL6cRZMbMQGlpzwVAezaX?=
 =?us-ascii?Q?GGMdTnfzpzD7iY2QvfOZFFa/j2KiTGjC/T8dri+2kRdIWYeotDtD+poAqoz0?=
 =?us-ascii?Q?izOgKKHdB6hm2hs9J8W9ST1/+p8eBbD0Jc/ccl04X219w79heSiqwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0eMJXXw0XB/nSDWnhArAEkndQfJALYS0DkjL9DtSxVaR3P4sE+gUxPdgbf+E?=
 =?us-ascii?Q?4RiYlAz0us8UDtoFnWFcRarwlfnwoPkhRbga4UwXycebis94sXyDgiXoFdyX?=
 =?us-ascii?Q?B+uUjIvsSdT1CfjIrOO0NYVgEfD2WMeTOXuVEGPqeLBk04v3K/44zNyqCmT8?=
 =?us-ascii?Q?B11TFSj0PAHJx1BoGzG669aHKQAkTQCcDjHb7kOdf2u2zsAvXrRwIBN074Tv?=
 =?us-ascii?Q?olMHa0tfnb0oX+34DtDbnvmsY8T0J5AgemSolCpU2LWLCDqGnQ9Ob1BL8ZW/?=
 =?us-ascii?Q?Ey8g7xeHlEtwN8NsFytOrCSsafJ2j6TvUTIqWWNL4vwFNM3JDZIiwMCNrLfh?=
 =?us-ascii?Q?PtzMHVRGI4pN40V89YLFburDGYd5sMtT+q1n4KhZozlRzjtiEEfKVxh0X0ec?=
 =?us-ascii?Q?22EH4ogKPqrdNi+9JOvJHywTaz8oV9A4hv7vmnmwDrFD7yBcSuXX4xmtXcV2?=
 =?us-ascii?Q?Rrea01IIsCjFfB1M61U+8JD/jouUZWRoGeQp+pgCU6agGSyYERkCQX1AtLLk?=
 =?us-ascii?Q?PY+rHpcVziydSOZhYGoj8QLYUEgXRgva7KDNtrKsbCFlAMlKH2+3Rkal4GU+?=
 =?us-ascii?Q?Ys6x/KcouPmuNc6w9UWr5fRohTz0UiSQVkC7q2VH0VmgIgaWhDG95ReaDimc?=
 =?us-ascii?Q?ngmKUQpS4NldQwpI8PH8BCauXjlOyq/Ctp91yQlQcDhrnNFiCEvlEJx9Fk5q?=
 =?us-ascii?Q?FwsebehYyK0DxCsIGloxKKaoojJTvPBr9IOiSH8/xNRvByOhdK8dHNv1x3Cq?=
 =?us-ascii?Q?Xfree23oJ6GU+6TM+M5PmjQ3pLp0Lv+Pm0FcCIRafALavqT+3qhraAaDJabb?=
 =?us-ascii?Q?/c4CpaKqnBQcd1zypUwjZ7GVA9225Bm0E+d3Mh55/QWhxv9ImSEgGftNvDGE?=
 =?us-ascii?Q?gQ6zmQ+6hDO9MZkSBaGg5mM1DjGNQrjzFXAtRIeuEyXl3LFwmLjjIbCYpzFR?=
 =?us-ascii?Q?fP9+2nGAW3pmY/Ov/eHRAfKnhi6iT3VXTuPMWAxVim7UNHvrWQLxJTof5DBk?=
 =?us-ascii?Q?3Oin3tjJR1rXdzxS7QcGAMzT5+nsX/49BcgYzrCaqNx3/9qXzDe/FiLHSlIe?=
 =?us-ascii?Q?4yF9BwW+bAIBgFxfjTm4MPywjYhqZYc2JrpHCLvi9wl1EsMjk6FfvtDu29CC?=
 =?us-ascii?Q?C/+qyZj0EnHoxzAetVwpvIR96LK9a7ttHnnaTJvwfqB7fOtH4SqskRpeVsq9?=
 =?us-ascii?Q?RrCIoLGtS0ks3Irpzts7OikFUzDqkdlb0nNBc34ui+TR/2/D5rnwP6YXd+WQ?=
 =?us-ascii?Q?/4BAGBq1bGwpLAqII9FLt2D3BelOljw4pVuHH57ru6gechzzKefeKxhxzpPc?=
 =?us-ascii?Q?wsQroXil/fdu8ceIepi3xYsbvXLmvv35e/j8uEclsIHcxWanrvWdjrBegza8?=
 =?us-ascii?Q?cilgrnezY7VIdMcCzEs2VulyDZY9mzfT4w4qhwHNAl3Jr5EcPPgZsqThKSiB?=
 =?us-ascii?Q?ry/gtCkouD1+zD4N5za4gliDlN1ahXLBxly9AUq4fwS8DuF/Ajwq2RuE4oBA?=
 =?us-ascii?Q?v5FnK1V4ssFpKDUkaqjL0+zqbB4gjud3zgCL157xvitRkGiLC60pK+Ys+nxP?=
 =?us-ascii?Q?Bi7d58tYGESEkFDpUENt4niaHVMFSKtMkpR5/YgR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70f866b-5e6b-458d-0661-08dde3dc78b5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:37:01.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNnta6FCRx3zUopP9uXKtEY7FgEj8BGHrrUoAT8n9karIYGZx8eBXfhfByunEFEqG+oTNKQXj6W1InDnkAVX6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7023

When using &, it's unnecessary to have parentheses afterward. Remove
redundant parentheses to enhance readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/jfs/jfs_mount.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 98f9a432c336..52e6b58c5dbd 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -325,13 +325,13 @@ static int chkSuper(struct super_block *sb)
 	if ((j_sb->s_flag & cpu_to_le32(JFS_BAD_SAIT)) !=
 	    cpu_to_le32(JFS_BAD_SAIT)) {
 		expected_AIM_bytesize = 2 * PSIZE;
-		AIM_bytesize = lengthPXD(&(j_sb->s_aim2)) * bsize;
+		AIM_bytesize = lengthPXD(&j_sb->s_aim2) * bsize;
 		expected_AIT_bytesize = 4 * PSIZE;
-		AIT_bytesize = lengthPXD(&(j_sb->s_ait2)) * bsize;
-		AIM_byte_addr = addressPXD(&(j_sb->s_aim2)) * bsize;
-		AIT_byte_addr = addressPXD(&(j_sb->s_ait2)) * bsize;
+		AIT_bytesize = lengthPXD(&j_sb->s_ait2) * bsize;
+		AIM_byte_addr = addressPXD(&j_sb->s_aim2) * bsize;
+		AIT_byte_addr = addressPXD(&j_sb->s_ait2) * bsize;
 		byte_addr_diff0 = AIT_byte_addr - AIM_byte_addr;
-		fsckwsp_addr = addressPXD(&(j_sb->s_fsckpxd)) * bsize;
+		fsckwsp_addr = addressPXD(&j_sb->s_fsckpxd) * bsize;
 		byte_addr_diff1 = fsckwsp_addr - AIT_byte_addr;
 		if ((AIM_bytesize != expected_AIM_bytesize) ||
 		    (AIT_bytesize != expected_AIT_bytesize) ||
-- 
2.34.1


