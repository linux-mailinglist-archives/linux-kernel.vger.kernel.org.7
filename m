Return-Path: <linux-kernel+bounces-764285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A76B22112
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B234560AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B92E7BA7;
	Tue, 12 Aug 2025 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mvSik4xE"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3272E62D3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987249; cv=fail; b=hBzyPuhq789TR+VjIjnaH2ikXG/RLoIV/JXihZjvNXD7EJ/7ZMPTamuzak3oYZiMLuu1Gp1mQ7LbC0UGnzhMIktgtu4Ab8sxn1KjjaRFaQVs3lnYNXJOdsY3cYn5g0LNTbPGS5y0TUOrAtz4GT59h9edFvhrvt2FTL1BhSEvWB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987249; c=relaxed/simple;
	bh=P0h0ZC3cMuiAQ2O3CWAjHkzi2FHi4Y5a5Bun1d4sa9s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N3JZU8WlM3ztPCGzWYf6hXu2sXro6jn9w6/OUBVZ+wer1hOSutGapTVnzMHp8XAaG9z+ib4IsgPTheY/e7mFhQyALip7XjFzbBESEIFb3Vw4A2OfZafa8y7L7RI7UrA70BDq38fTCO55tZmYDSNGtF50/1OfHQoykOGcDYZHWD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mvSik4xE; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsEEiYxVgXgMW1GkMBvunusz6CzANZmFd7aaKGVlGoLdDsaD0D2UWcBavHy7o2/CvsI+IYBTgFgFiapDhLMMMWvo1ZyqLOeVpv9u5RDYaxXDlNVDof6vZxig+EZD4Jd/TNYEYF0n3SOuvaCohBjxqnA29biLl7/pz6c3PrIkMCx/9In4asmdOhEA8ZJR6OTquqFALgfdUdNK0fFaXUCfwc/GenTtQq93VqCS0o6djpiwFK7AJWtZWT4eZMYggRp5H3V8Vsx9Y7vXz/MLl4wliDLTWkq0QkwF8XRLDVYWjAx1nEFBst/qziMpN8cQdpoAiFUXzrXnatb/Yc8HUHl4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSat2dudL6VXNC1cyECbvfcED07gA3Dl9qydAfwl84I=;
 b=fnx1Cki57+YnD5Uzy3TclV4Jy7kMVQ0MfzkdTs+2mKOlrYLtYAaAvV7BpRRMTcGate5OS/08oyqaRY8L8VI16DgE0HO9B2QABGD3JdWqnkP8k6cP/jtKjI8GtHeVsNtbQvL+hujBs8fK0FgRj4EGrDf7xqyTv2Fr/Dw3I7blzowiYZlqSkqIp/vrUalcbPFA9QyEvT2rL5cu2urx1kBjRdpYbzaS1kCya68PSI9wGsMsFAo5heXtYKK6YWpC5X9FaIpbpWJjOnT/TlLoUph0RH/t7n32fX5L6hqnNOb+QRJZinJtt8sBs0keBYP4WSxyho8Mmy0aFkwKF9VrayJEfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSat2dudL6VXNC1cyECbvfcED07gA3Dl9qydAfwl84I=;
 b=mvSik4xEdqv8FDMjtD+T/X+An5iSvhXSjK+9I0d0qzWzvu1gxU6fv8Q413KCMMqCDcOMmOvVEXap3hyXAEx2riUZuc3oQcOGt/ctpGe2hx5bOfQb4YVuYW/S7/uUnO2kieWl3qSkb3XqxaGW8Pvv5zGM5K2Vw5NIKFNeP5UIJU2kx+Hnw8jkQ9r094/B3HbK31aIrEm1Ai5D1rwWpnOMwpzhLTYxBEqllrd2QgqpCDBz0BG36gn5hp120/+TLek4SKc/LUdmFEH++nZNoFE23dsTSwmHqdAsXNBNSN2L48njjBo7XPnKZ/wk5fRE1Z6Z4JmVQOtzfHuEubhrusMmcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5829.apcprd06.prod.outlook.com (2603:1096:101:c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 08:27:20 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:27:20 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: a.hindborg@kernel.org
Cc: leitao@debian.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] configfs: use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 12 Aug 2025 16:27:09 +0800
Message-Id: <20250812082709.49796-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::12) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f726d1-47ad-40bb-e1ff-08ddd97a0e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Z2EPj4nHfgKwg7e4vdZt9RMIMt1dQg5Hy78C9M/tEnlkt8sdzCzUbXRwRcI?=
 =?us-ascii?Q?JxUg+370tslniQZt0JQQFe/Wch6KboeyoKaF6YII02df1P53Ne2YHntFwhQX?=
 =?us-ascii?Q?+cOK8cS9h/Z4hbe971O4xB/nQTD6eYGNFwB/VB4z2ylQK51sQPHkCy3ETonk?=
 =?us-ascii?Q?yAB0ZUPPaH+Mz9Q9yoyeo31J7hP2WEldnj+fmGVvf6fj+VTV/vthVrPvymSa?=
 =?us-ascii?Q?vSux0P8iwdyXtdWwszo9QS3u7i3pmWsTIbxWmGI0kLHKb6L2LP3yDjUvWywP?=
 =?us-ascii?Q?hQFvFmKfIZDuCsW/B0/UhYdknB1BqkTNTJys5eDCb6Sqz7UZsRYA+MFoSbLJ?=
 =?us-ascii?Q?iPOlX3Pv5eJKx+EkfrhoFEo6kLLUhas23O74cVSGNIle9rt/hdB4B7A99My9?=
 =?us-ascii?Q?YlyawRn9EVWMcvj5IYwXxBtJn2YDU63iva5ngCQig0TrR1YDc9xxYifHkzsz?=
 =?us-ascii?Q?kyB/jI2WxCDXhFbCNixP8gqFzlyyCzmKYiLE4ACzdYcU87sxM0HNqLTQWquG?=
 =?us-ascii?Q?GzdApC8LRFqhJhGAJXDIX0toH5tCGTTn5TH1Y8Y711a+aArQB5pme/DqRvtP?=
 =?us-ascii?Q?uu9Ersg4+/pPV2Aq1QE+3aEmf1WcQea+tgEgN/SgBQDtu32gP0up9YlzcRKK?=
 =?us-ascii?Q?nsPg8YN32o/S+TTIXKn6zJCrSq4siiMX9M55GOvenVRVpvBPWXVVi0qS0iLV?=
 =?us-ascii?Q?N7ZWQDMQTsjyBJlq6dmtgjiC0SWVvV+0PuEcDq3sbO+YLGvMEeiATdZLWsW6?=
 =?us-ascii?Q?CazDLql3zELYb3F9e7nbABCRHtUl5zbKfOqkmTpEWbKgSLtmRUQ2EfdIvDsJ?=
 =?us-ascii?Q?DZ+wltTgWawaVu37GCVtkwF4LuxH0DR4pcTLwG2wYPcu5SuJa10xVKXYIWop?=
 =?us-ascii?Q?GfSXt8yX1az1sfbytE05uL8MPwngBntBzv61xSFMB0zGcVr/oYwOAD/oMb6R?=
 =?us-ascii?Q?5lpc1KAxWinrLya8fr3u2ThCqQ8UMqzHH1TzT6h3BshBs7Ro5688DXoiMh19?=
 =?us-ascii?Q?oBVhT7pMHWpkBRgVMbEqqDrHTtDZ25p4TxY9IiNJ/OyQqdkx8rnY2NIFr+Zc?=
 =?us-ascii?Q?weRZbQUNRGWCCrmWuC7JbrL0n4B7gDbASlf9HRHLdvrLXt6dTga/MnGm5qh5?=
 =?us-ascii?Q?0NgaNpNICpG7pTP5FlF3HJ0JLQMUwnxqGgrevA2XQVKc0XRNjEfJzc3aVT3C?=
 =?us-ascii?Q?FE1dXqrT4ygHL9ngjG5zcUPcst5jDBI0DBPCq5J06mhKqFAUl1Ndb+E3udLe?=
 =?us-ascii?Q?62z30VScWWzyx+FUsctxjNsAk2eK5fMPKgDV1u1rcvUYy1RafHfKrs5b0kwR?=
 =?us-ascii?Q?smxrHkBWwhSKJ2pvvq8hDCfB40SDxLTyO2w1AaoQeBM5xzYSMfSwBXnSd0VO?=
 =?us-ascii?Q?nzvNohE/1PAHQxSHQLHbWscODCWJ2JMTqtOVx9v/9sRth+AtR4MUUIuui2WS?=
 =?us-ascii?Q?Wk1+4RunUHl+7col44X69GEyhwkuIEkxKpHShueSrBVO+OUYrILgcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoqT6nvdoQMKAA+C46WaMk8SUo3/u1X4koff9hcmdYJy7jttRIoDQGNaAx9l?=
 =?us-ascii?Q?YUgvTiL46+TaKCJaQKHNbnlYwrru9cDnXYJWVfG3FVbazBQ2aDXGD/9O26rU?=
 =?us-ascii?Q?OU2w+8diZrmroFIhwhsSUWUCytgSLJHiWWBj97AEtR7HY0V16QdiERdOc4d8?=
 =?us-ascii?Q?28HZnEL+vvk02x5RW6wQFZzSV7kuTSJATtwPkXSVIyqVCC5brE4ZA8/kkOJ/?=
 =?us-ascii?Q?wYjfbUgXw2FmwsqwHP6lthDyE5APJJ/eZr+quI+ErMv3VN730AXWpNVbnZJn?=
 =?us-ascii?Q?5OHg4oLPbp4xgm10yCqZfzNTCa+fB4gzMrQq/EHDe+q5qxv52L5BW4REYJWs?=
 =?us-ascii?Q?BZa2hsZ6OnRfVXwnXWyp3B8/tJHjriTMTef2o9tlmf24Xf13BZOavWLjb205?=
 =?us-ascii?Q?xiMVMGzvN6rVmaDQ1denmqDfLPv81F6WIp06nTJ5pimPjw/XpayeUHaaJerV?=
 =?us-ascii?Q?Pm1bLdZKdJJdpBsGe0MsYoXRfx1a8iTjS5UO+MpAhy7PtElBkcz0ons+FpMR?=
 =?us-ascii?Q?CLX3gehZKlXkYZWijoqcgmvKSPJhcVnoDW1GR9BdwV9mnPrbWn47+4e8zFfq?=
 =?us-ascii?Q?FjTmCf4k1jySabZjqT9orTm0Ga/Jqpp5Til00QrB/kQUyFSC+ltllu/KT6Vr?=
 =?us-ascii?Q?hOLqb356AqIocPVqXQK3/+uyYQoIoLOZOkMWqRYy03JwDowNGzK5kbx+4szA?=
 =?us-ascii?Q?Kp7hMIRVglbX4ynh89T8zFZxjTkwTiOgbHqAB8bckARiFASiMaoehoR2HbEs?=
 =?us-ascii?Q?fmb+qeJkgQSdf0jciZf4zpaftaKVDcz4sdJyxnrqLgRRtDn7/l5xbZIByDzu?=
 =?us-ascii?Q?7K5QLMSmLBQOFcBZrefIX84ytHPqy14YeKWLMFw6cP4wJQHvXfts2y+HNuqZ?=
 =?us-ascii?Q?ClozM9Qb57seQ1UONwGRi8zrqk9F+B4lsyGnGM0JSXg6M0yf2v8Gl3sMTNjf?=
 =?us-ascii?Q?zCKZfBIYbSBlFH0b/Ssx/Qzmy9FCE5qfSxuzNIKabsIfHrrl4eopPSl9NUTN?=
 =?us-ascii?Q?I6LZHNjJqDk+ssrilXhc83/wASacQxPJaJeJYNNTncNo5r+KAUBvagY1c6J/?=
 =?us-ascii?Q?yuND1p1rUcDMtWzi0omNKg62Pej3NhdHE0OxG5TSYyjTEZfmtgr5UKNOuyk0?=
 =?us-ascii?Q?4RoZJYrTQ1/3+/X+sQtJRpZ9PT5Wct0mOnYpL4Oh3Smfl6Frx5Dz/9mw3TGO?=
 =?us-ascii?Q?9IscW7vIK8XFr2c8eEPbkXAwudewxfJk5pE33/VxTXgk+DGCM9TyfVg2txYD?=
 =?us-ascii?Q?YJiEIwsMMDOligQLRQyFN8a/tkQRgsEM1H+LBQ0/tMGZzfjxtmtw0QLFe7fb?=
 =?us-ascii?Q?rJdN/nBHDtohUlh8kQn8uIwckvFzLMrInAmL3DqGucsmbuTMYZfLgAsJh5c1?=
 =?us-ascii?Q?RJOyygpbCWiucUFvN0YeddaDTBfNwxtZIlgo0qLHDDQGFy8AL9UL+88g/j1b?=
 =?us-ascii?Q?7RaPX/pUmVqH24xLrFEecU7RCZuDp2oivLG/N+q3bE4y8Vi1H8LxwBAMy8fk?=
 =?us-ascii?Q?5FO2WPtcC5BY2ogJ5zf6bu8R+aNcZ1nw2Jur5d+hFmpuk5jBV6ZOjml59t25?=
 =?us-ascii?Q?aCqyinZtVzwpOdhfhkb1N7S1rzxDENIPTBhQTQ6N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f726d1-47ad-40bb-e1ff-08ddd97a0e03
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 08:27:20.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S9IZWGhFcQ5InmEUYuTo1L5SwXy5PoxcxJP+nKJEq4kjwrvnxpvVoEaKAKHF9dh8P2CPqKoXYek3AJF5i90og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5829

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/configfs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index f327fbb9a0ca..81f4f06bc87e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1601,10 +1601,7 @@ static int configfs_dir_open(struct inode *inode, struct file *file)
 	err = -ENOENT;
 	if (configfs_dirent_is_ready(parent_sd)) {
 		file->private_data = configfs_new_dirent(parent_sd, NULL, 0, NULL);
-		if (IS_ERR(file->private_data))
-			err = PTR_ERR(file->private_data);
-		else
-			err = 0;
+		err = PTR_ERR_OR_ZERO(file->private_data);
 	}
 	inode_unlock(d_inode(dentry));
 
-- 
2.34.1


