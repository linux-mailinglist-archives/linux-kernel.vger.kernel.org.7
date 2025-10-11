Return-Path: <linux-kernel+bounces-849132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC65CBCF451
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864394E8F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7609A265614;
	Sat, 11 Oct 2025 11:21:59 +0000 (UTC)
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020137.outbound.protection.outlook.com [52.101.171.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FC262FF8;
	Sat, 11 Oct 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181718; cv=fail; b=QhIzpHzsWNvaco/f2N730CW7cGGj4KoQqnvIaPOaf3QQ/RScNEgyzmvB06QTM3jqWo+x8Oxndg3KpDfpYd7aKaN24W9tvcvbFE9Kspgb/WUFBV7+vqmglFKwz8q4eaSH09FIOu5IW8XFgZzXRu6hUps1ipLyOnM2hzI8tXbeUlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181718; c=relaxed/simple;
	bh=INUqiUxHufvlgp3rY3de+K6aGXbfx8ZhNzH6JOmCxnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z9s+aj7t3OKOMwx3x6YWEAee5YbijsoZBEpsbt/9geJXAyHfJsSlCUGMzyJjkxR66Mqbf9SaX6pyt2A2K7/f7/i7i5l23zXTMYHqd9DiR466D2bbFUPjklrk49vdKF7ZUYPlAtkl7Smfyze8R7VT6Xne8+hetyMse3+jf4utX74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass smtp.mailfrom=siewert.io; arc=fail smtp.client-ip=52.101.171.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siewert.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5HfvoVsqweyINjo0rBr5eLhwcEKOzV5DujJBoHE/gWqsI7hV+2zGlCJMzATHusbFVcwhgAu7QsnTNc+wXUAEtM9G0aRryeiGPFCAesTYzwFxEYtVRyYa9O03iRrK4AHOcsh9njsLe0ZfW/Hd81ZesI/LShAIWtMvVQhWjcP0NCVgAT9hRBWWtch0gSbBwUd9+OH/xUHYg/aVj0Uk2UH2EDeSIWG1SUe39Kumd9Sqt/zwI57hlfJHkP55HZ8euM9+IPeY4xJXggb+Dw8bppoQjQISmG1ytwNlERv0+yYAFRgD0nkEo7u39YrmCb2RIyquK04mxZUWQU28JFYo1kiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNbdl9XBIkoPGKQTdSwnC8Q0GMLgGmT2rPjbbIb73pA=;
 b=Zxur+5frH1EfRZy9T0hr+mfF2V43Be36bknnkud5tTeH3rZmEIGUJ2t5k6spWOrsqJiOhdto4+Oz8btAQNb6pOdkTWAh5Iuz+Wg0cUu/qKZ703PQJenfzaFOUxaJ9gPX6mw5g20nRA5fCocgkmffzd+bI/g3KM7t9OQGzB14M8acEoO7+8dKesNmakny+Tba5uZ0oe8sNNU/eO9C4IyBKVt5laxAuzBetHX12cjf78W0hk2mx0njO/CowVNzWTmWKH6XtMIpPueM46nG4HbjsjQ+49NAJQYT0h3QomY+n5WNR8uV6/mvHLMJ+MZK7HxFleqPHkseEV15FNhO6vuMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by FR5P281MB5421.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 11:21:47 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ac8:ee5e:7e24:98a9%8]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:21:47 +0000
From: Tan Siewert <tan@siewert.io>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>,
	Zev Weiss <zev@bewilderbeest.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add ASRock X470D4U BMC
Date: Sat, 11 Oct 2025 13:21:19 +0200
Message-ID: <20251011112124.17588-2-tan@siewert.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251011112124.17588-1-tan@siewert.io>
References: <20251011112124.17588-1-tan@siewert.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|FR5P281MB5421:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b0ea52-5661-4478-4e8e-08de08b85d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kwRx3dIVlavfBvG/bO0FXJrv/xOtMgONEvpMEpq2Qt7a8lXbz9u8Dh3aO9fu?=
 =?us-ascii?Q?uyJAYLQIN77oBOjcBgyWG+VGIXyPi2vz7VUh088qH4g9oy2rpKMSugsrAAb6?=
 =?us-ascii?Q?FRXp/R9ipWgzTB3051fpvawihSj5pTtcYTXdNSe/Tc6ATYi0GJe4Jf7S8IFU?=
 =?us-ascii?Q?tQwkhx5E7QXKEBFei64xC9qDd5K5uNURQzl3IogJA2HGjE1RIZIKmNxpMmIA?=
 =?us-ascii?Q?k4fq0EOtN2eqDRFrwQ1356u43Gu1YgYJtQ9LxAZ8HBPISILwTA4IRP7YVEx3?=
 =?us-ascii?Q?aFXI0b1SW6zA/E0rqRWpPLl5sI++V6DL27d28q9ErChNZwjp6NU9nyS4md0u?=
 =?us-ascii?Q?VOCRjaOe0EIMw4hpARBjyuZ2I7cs/TRIgdv1nc/MDzC7N8b3BLKK7SfLqlg1?=
 =?us-ascii?Q?ps7G6fdO2bcdUYSbfzdwQ/WdpuLuZltcn9MrjDSx5QikNbS6fotxoAcgy/TI?=
 =?us-ascii?Q?jRNNVTrueJ92rz8+HuSEg5oeT4brX7EVBXESicvwOF+EWo3/WhXUuRnDyuqR?=
 =?us-ascii?Q?VcQZjwTQ2CjmOi9KcsYSn/uY3qorYBpfPsfNcDw1KESZtFANqTN0w+RjG/Jm?=
 =?us-ascii?Q?mmhAIo8Uy1w5geIIuR0+U34nqs+PmPDp4PmvAEDdu5FM4mIesQWXEClt9yqj?=
 =?us-ascii?Q?JXOuw42eLsUJvJuQ8UyhX/PiJrJO96/OWJmGnFwFZyA6QJAIxMdMykncsuWo?=
 =?us-ascii?Q?NsBeE6KMlXhKmigUmArAa/Akl9dHo3we83X3ZhhhXv91l2c4kRa3FyeG5+oS?=
 =?us-ascii?Q?IkM5ZnFfqKRulmyPinGippID+lYua9u4BBMBTyJaF2cPqmOi3S7KS51O4KuT?=
 =?us-ascii?Q?ILJwbGYwKngPpL/SbGBBLhOgj1RuQQCnhqwUYc4nO8hfldKozN8RiTgAgrSC?=
 =?us-ascii?Q?X5637UBGoCuNVEsVtToNqwr9hg8cJni+zC2cZAFye46GHW5PfjvcI/jpSsgU?=
 =?us-ascii?Q?pyfLkUXSEL/Stcdr0dERv68RlDcKcx/0/brL+p4bnlNu147vhdF3/YIv9Opu?=
 =?us-ascii?Q?jDPvnKc6xDcd6fHLbfIHa8+tMQ80T6NJ8qXKFUt6izas31myqd0zHqgAVKLk?=
 =?us-ascii?Q?++78tEI04djBXizF0Nid50g0zyRpV7YE5o9ROnhJRb2pED6EFoZ4rPxkUfd2?=
 =?us-ascii?Q?4dc4aV2HZtjvJqUREcX8aHlb2ygyydArXx2uLqUoogoYUUxKQgarHtawM4Ju?=
 =?us-ascii?Q?jIKq4QqsMEJmkGutw/wHychMjANlAFOUAn8B6JnVZdg8FUA6putTngskg7jN?=
 =?us-ascii?Q?5TEG3YLWkkJSRPOYftb5v6JXndj43pTe4qSd0JyBsE0Oyn7H/gfd0P0ddwHE?=
 =?us-ascii?Q?AEVInlNoenuvpzC16ZZl27RQ41bML31y4iHGUhYhyRcqyrD0WgyOYr8hR8AM?=
 =?us-ascii?Q?Sub+9RmqMuM0r49X6KFBquCshATxe7yftFLEtmfCOjr5z+o/aZkjLyE1oiJ7?=
 =?us-ascii?Q?jCCLkzcQKPhtscsmrgFqcjGNcxy8Q1ob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JcccScH/K7IYnpEOOP8IsNCqr5ghdKDF4h5y0NcgwYMPxk3JIZnt1s9viBus?=
 =?us-ascii?Q?bNEhdhrmDVm5CLU5obwj0uZGIsfZ5LJ26ISZ+CMFvIegWsfx2SUo/Xg8qYTI?=
 =?us-ascii?Q?SJ/Lr5Drfz885aQXnp55bMfGFFZUArW7hfsCTGTDwxh1rsZJp9pWODerW60h?=
 =?us-ascii?Q?EKdZiglmCM/mP79AZjZ9uLS5VNOLuOeseb/qrXyOGjkE/8z5uf2JH8JwisEW?=
 =?us-ascii?Q?PFldsg06ZOnVZ32mFSyW5Ho1gfs9db136YUMdcl3fM14JlTEKfGGw+yauvzr?=
 =?us-ascii?Q?fM/Nl+0qa+aeRoiQXQp/fvW6faEcbJ+X8Cutoj0lG+S42aRmijP9izYEqyQi?=
 =?us-ascii?Q?E8lS9iV6bK/YivjENCpM4Xxy8PsoQs+WkXUBNKFHnMPDZsULmnqnZSVMowvE?=
 =?us-ascii?Q?73XZ1HrNN+NjGBtg+IxJto9p/PqBIIU7PW9fjXuN0KR9RZP9Ug9he8soI9Z+?=
 =?us-ascii?Q?9VmGwy1ydj2sKLHJaQT0b0hxjgFjAD7R3RGguh1Itt6VBjKl+9D1Jx+JkT7I?=
 =?us-ascii?Q?9EH6HAI+DXaHHcIo0+3hHYmtTGf6rijx0i6nVvpabSfSR6sljV0BuHDlavcG?=
 =?us-ascii?Q?BvNsR0copggJA05sHMWc7zwLqrZasrkZL+xsKyq0vxyVkPQYa5gtPRBpOIzC?=
 =?us-ascii?Q?5IpJmlzZB5DxFntKOU/ue04WkorCcp1xtmp6lEP27rO+zIRFgLAFKUV7wjjE?=
 =?us-ascii?Q?U5FWkqYsTLFOnyWrPX2Oaiklr6ddqh0cQgPApe3rkS7z8ueILhwaNswn91Z/?=
 =?us-ascii?Q?tzOztN4cbxFOncfw0cfb5MlNSBZBVNqk3tyUSicO7ur9KijMFMWOyG09Qaw6?=
 =?us-ascii?Q?YEAFDaHHVgGXOgoWqJZ8nB+5RVfDTCyfcCJEE6QTLA7MK1s9QOSecxoZS7wj?=
 =?us-ascii?Q?8FZt7zXUidT7E/zk7xHDSo2AJtj5a0uOomiUG1Fz34shfDvrVYI6hKMDH029?=
 =?us-ascii?Q?J48nTCDPRz/Tigo86uNpmTPPTAZeYQ13g9o2ptt7Uf2MaQ2GAQBnb3iLchzO?=
 =?us-ascii?Q?zt0306sfQNjs7n/AskJmoNRchXWa3W6ZrskrZ5es30MVE+3pKMOOJzQpjZ4L?=
 =?us-ascii?Q?S929RyaiYD6ldPBeREy8lKZwJM9zx+ZVoCu981Ck0vkPhk1wlLxr5ImZZhLa?=
 =?us-ascii?Q?P1Tzgky/+tPPk+0NWqiyqj34p7Pi5G1E+plFRpTz86A/udDBvVKEX0+UeceY?=
 =?us-ascii?Q?KpPzY/9Hn5v9byilKqnMqZbcQwxVoQnyo8HWA4FZ42GzLHie1wlAUyIbCLfi?=
 =?us-ascii?Q?38hkzGgEbtAGsVUq6ZZlib9ezaliyM+FmbM+mgUhsTn+R0jrOOhF8Lz9FsYL?=
 =?us-ascii?Q?HgnmYQzFwOTSnvDpgxpTr5wEx+coW2V5RDZnlVxuEdAOlFXglGqq3sRdqjfn?=
 =?us-ascii?Q?L/jLmfwljaUNtd+2zr8NdojTC2BSKHNb/NPaZMtLCKU5qslSYauvw1+KUBVv?=
 =?us-ascii?Q?thx0uq7F6jG2bqog8XyW5s9Of0aEvsKkUc5ngj/N+WUVWKLXTSxqwjVosPbl?=
 =?us-ascii?Q?d90KVXdeEtV0RYvuWdN7RH+hfClB/boBEhsFaY6UCXW2xxdNnQsZs2UxxWCN?=
 =?us-ascii?Q?p4qtbmT5R0+rTYxC6hKzSlqw5cEkS6aFr4eInzLPrkMeYnNJ4ClCznqX5GUs?=
 =?us-ascii?Q?lELsbVUTiBogWZKdVcJb518=3D?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b0ea52-5661-4478-4e8e-08de08b85d97
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:21:47.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJaACERa/TvpPg2uBBsSjV3AHkphZbU6DSYb5vOtgaS9RcVNX4YFOUK23RUjqfrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB5421

Document ASRock's X470D4U BMC board compatible.

Signed-off-by: Tan Siewert <tan@siewert.io>
---
v2: No changes
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..02ac7c4d92e9 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -38,6 +38,7 @@ properties:
               - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - asrock,spc621d8hm3-bmc
+              - asrock,x470d4u-bmc
               - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
-- 
2.50.1


