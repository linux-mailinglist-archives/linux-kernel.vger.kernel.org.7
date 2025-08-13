Return-Path: <linux-kernel+bounces-766399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F19B24642
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B791AA6151
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A12A2F1FF1;
	Wed, 13 Aug 2025 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qzI4TOp7"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A975809
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078554; cv=fail; b=EEBF6Qv6ddqAy3260H5i5IjLgNVb/iwctFtCj7wRYkjSlnyRGhVSudym1vkqf+oJRc0AYewC5IUCwR7bGKMyLuBFX5y1x7odmeE+3IA0vnDcrDWNRjtllw3mZm4Oxaxya7oODF86opqOjNNYB906ZVR8cCPi5u8LK+JwqyepvZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078554; c=relaxed/simple;
	bh=T840att5qOtKzTuZFPBlhKVKgu6IDbh2fe42/EAqZqc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=COBwIkWTUSLJfRKt6ofZH5GgwraOadSjRUNY5Ra43zqeNBrcNnlLc0ticgTJ9pg/0vXMj5T4xPRgeXk95NWSJiMfCEB7zlr62yNcxRNkOWVw8jj/jiJaXP9Lmi1VuSy4YoHsl6gnsYA/PAiFKJ0MG8wmWdWxCC0FaKl7U9akl5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qzI4TOp7; arc=fail smtp.client-ip=52.101.126.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IP0dFjjJW7LLfGxXBg5iJN6Tm3rawWbUgT/enVIzxQb9okKdH6fa+tnrVmG1rzKXT9WRKin7AuuolVvVutHINb6Ua8XIJrqaBej/3OXOb//1YXAHuw7WS4kqp/2L/6jJDZ2OIXyudpbOnLUMRPd8/trRG+kCdCAZFt4WEyhlj7Bi3OAhr9W3lJuy6c1z2rsFFmuOh5LmapU1e6r2hIAnx69PlYQvFjMZXqBuQE1Js1DsnUzNbcJDm2WuIt6QsFyCiJ8T8JcOk0jdj5btEY9crbWcJ0KoTjas1GcnA9pYPKl/POhzH7GvH47nkW5K5xl+EcanIVBK5vz0CzX1M+YCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEWXhajUaGzh4Sa04fH3luBUbGD5xLITVm1fQ4exe3M=;
 b=eRT3Xg7vG1+sQOYajOL8WYk0fiMzxuQKlkGrJ+LHQvzhbN4coxRosr7MdnnGNNTJy+K1EbUOezDxVhA1F4B2iuvhf3VG0lXNkFl3YBJRv4kmjr/nAXGVsPKQNVzN5/5iEmV5r3rubqSfXI11Fdj9OW+rAstijORUA08FTswQTxk6pJeBQh0sgmOq56CeLejAs+Q1tbOYsVTHzTVdZ1PvyNjruVbXitFfKEaKKQXt42kfNK9kKO2Ow2HZhF4nxFpxOw0slc7jTgRazT6Exk+Ql3yIJLoaeI/QpJN352v++dV4Tr8uDaCKynH781Ddks1+16rzUc06t4Y13VrJ0aV9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEWXhajUaGzh4Sa04fH3luBUbGD5xLITVm1fQ4exe3M=;
 b=qzI4TOp79IW/c8CYLxIKgtLLuPON8VcXxiQ7LRFTvovzrJZFvA6/fGayb95Zv0cyC9tyHnB68VP3ygXRHJE4qH+/xR25mrplMVpOF1Oy09WgNa4QrYWKlw8sjBdHGnoBr7fEPOIG+65v+1rNxI68qNzWWs9KT0KzgggPAwXo0hLJ4piRcS2vgkIxmlY6lXTA8EqYGjMwzloQBFJUaQY/kr9+RH6FydkHwg1ltseA4XfXwxp5OY11DKHEEEl9ACl4HUwEzSthevn3MSDCfAmD+wIGzq23ba6DUmxGNIaN5VwlUN4SK/hxbD2wlh9R9EyFzfKrkzYGH7E/L5IyRda9Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB6927.apcprd06.prod.outlook.com (2603:1096:101:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 09:49:09 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:49:09 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] platform/chrome: wilco_ec: Remove redundant semicolons
Date: Wed, 13 Aug 2025 17:48:55 +0800
Message-Id: <20250813094858.557742-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd6def5-a2d5-4fc8-9093-08ddda4ea673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8bG70xhAt4RCm05KbfR/34dAliSLDcNeERUfVhWm2MWSSrWzykcAjLp6vod?=
 =?us-ascii?Q?q26AL2LJGO/wwMuq/IZk1ZV7Gnad4wdGwjoLKqMusCbasoigApCoMrVXxt8d?=
 =?us-ascii?Q?946PVeNCzaokEqVY/KrMNLqqX3lsR68lkmPZk+8oDaqzJWoH4oeb/85k8E7/?=
 =?us-ascii?Q?lbe720woIHBTenqTRrYh7w/G36GqEcVt7F/vlhiE85KFGL0bVaY3MczHi20m?=
 =?us-ascii?Q?fsxCeuJl99/gecbcwKzi5Fsii2pT78hHGgfglByGEvQnH6M9dZPp9VbfOSCz?=
 =?us-ascii?Q?yiStyJs5rl3p8ZfXjSn1Fb7iHadDvIvVPUkHXkmOL4DmNdDe+WPkfWJMR46c?=
 =?us-ascii?Q?H1IWdpZLd7eG5ewe2EhjXeMC2NTZluTTsPyk9S1AluPApkcW+aZmYWWS06Co?=
 =?us-ascii?Q?P4rHxy/q11K9j/E1iaQEvbLPuftJa8j9Z7sEzOYkvH46qMWeoK7RIYjehJwa?=
 =?us-ascii?Q?6iFcbwnw6f9V4QOd/z7HZXQo92AIsxg5HdCsR/YmD3juxJlQFWcM6Q0po9Qk?=
 =?us-ascii?Q?/oW92Mhh8kiPe/nnhw5cieZakAXEndkae82U9437A4MxHY26tPi9z0JiYFmM?=
 =?us-ascii?Q?PXzvq9bDSTmTG1RmX6mHqLwrIQJDg2w7pbZoD67zH29Ofcdaxs3xw75JF+JI?=
 =?us-ascii?Q?1ye0G5bhp9AoZf73OLeA1Fm1MICOHxcgRJkZUBOyJUlqGHzbtQQ1YG0p1APy?=
 =?us-ascii?Q?yJT7pVZbvEZZxzYQ5Q+rfZquGTUBIad/OYuGbMu2Wm+B9b/ydc6yR5frXi2Q?=
 =?us-ascii?Q?7HwFN/cJnSwqicgqxYN2as749YxsKCAwNtx97CzFTxa8jOmEt5Nc0q1TrYiy?=
 =?us-ascii?Q?XWSvsiYc5DP39AJQWHR3S4Dq4678YE0PicMtfFetD1xMlSvCH4UoaFgYE3zr?=
 =?us-ascii?Q?yV4Sq3GGTsaCDvSHik2HLtbfzwCS/NdtBKsQkcgPSNQVRU9/MZQbk7Vzamys?=
 =?us-ascii?Q?b69l+wxl+gsNIcRe8oZ1SP5vxcJCFDSo8qke4mJq79EbZEQIeR8dJAjaT428?=
 =?us-ascii?Q?0yJTgdbrhj3L5/5hyZlrcOfou/5bTX9SAOZzYFgw8SwussMuFgnyv6Be6y7k?=
 =?us-ascii?Q?+VuKiw5GaVY/mvB9koxrpQZEq5KxRZI5sHIJ+yAJdTl7W30iv/cIPywLwRO3?=
 =?us-ascii?Q?Pq4ZFx6EvybBhReKGpSn1o+esJZxqix/eMflIDpZkIwT98WkA2FiJjH264FG?=
 =?us-ascii?Q?ocsEdGjtr72edKn4Eb8wnXnEnarF/OEYi+9PCdh8mGwTO3lu98Z5rgQxZy7p?=
 =?us-ascii?Q?HOKXEtK/rMZjwcv59uIF75wiJXoRA1Y8Y/zFSd6uSojydCX8LtrROwiUXs54?=
 =?us-ascii?Q?yhiOy0gd5HoqNwnC/DwQ3+m/0kzxPfB5qDkACREgXq1eZTp4srgDphC3yGgu?=
 =?us-ascii?Q?BigeeybDvvSmhRNJhXdL1/tV/19d6VhMGmCNoY98G7NjLuw4wGjTipaImXbB?=
 =?us-ascii?Q?ckWXK7klb5FRZ+LAx3KC3YF1+AXzPkPeCnrKN8gQV+aaqHGL5dt5gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eqs6ueAXBw+Yt9egyXqjO6WyJExbiJj3X/HHmquOL9xlAU21/DfBcb1O4jJO?=
 =?us-ascii?Q?OlwOvNKooYWH1/zZ8hMw9PSd/8bTETED6pR02D0QBLBGx2mldeHKXV3CWixa?=
 =?us-ascii?Q?Ny9diMtrd4NMYMZ9v8mvYaBjKwjDEUnMnvXznIxJ2acBR1jWBoXB+8XkL0Y8?=
 =?us-ascii?Q?NWDdHW2ioenpMu2ydeR7Ae0Nr95qT1HeQHwMnZfkU43fCzZSzeBvFOFQBjSw?=
 =?us-ascii?Q?bd4r4305k/kyvbrF8smPpKX/9SZHyS93adN8oMFjev0VBGDALWezw8Q/Lcmb?=
 =?us-ascii?Q?B/4dm4pQeMTJ/4Xweh6XpoWd1S5CZaCgY7I2+1PUBnVjG04FczqYKnaOInwe?=
 =?us-ascii?Q?rMgXqWhriLOh7179GzbftPQPsS1k25vtntWZya2G3P99+sBzcWtuCi8eRP9h?=
 =?us-ascii?Q?g0xcU5trtvZNsST7sUDXLMHTrv0jP3WIg5utzqBn5RsrXkU/07gJMZw3dq+3?=
 =?us-ascii?Q?gjKOCOt9wT+x8v2WonTwjqH6VFUnlXAq1wY1BhIhhHmM/d+1qbQyBfnNgdvp?=
 =?us-ascii?Q?QrC28/BBJnXx5zxm9RJWj5c6PzlzhH17FiUbzO06LcJr0qUy0TmDDeIJuXEA?=
 =?us-ascii?Q?qhb7sGDOjGoTggrOY78m+Oioy0D+kersJ4G0BRLLlL23J+N3XNUvXsFSdG4J?=
 =?us-ascii?Q?mPKHoQrgPl3Y27R7ypXc7SzC/WyJZAlLoeIRvsSQYYbl5GXQOo4iYVExBges?=
 =?us-ascii?Q?EtkUth8gWVmvFG1mHo+uZ1GhaRNHsHHLX3KwVDSYEYSxENss/b255E027BYj?=
 =?us-ascii?Q?OvuQeJqbj9LTKEzFqh1+RIASHpieMiskVAd9LuSg1uprupl6t+FiJLW+8oNe?=
 =?us-ascii?Q?Rq5eyPs8atzqeaQpW7Ovdh6UzL/guhE0tI0vZQN99eCEcmfMx2EM/e9cavtk?=
 =?us-ascii?Q?SFOhknz5ldXSUWqhUMZ5AhMpEHitAEw3mi1W2sKD5vnF4v6xBgRJhvHK+03s?=
 =?us-ascii?Q?ZOEvnLSIDk2hY8fILHC/yzQ/CA06L1ZbMvr/KcFPjxkjYmV19X4J+LikYkbQ?=
 =?us-ascii?Q?TnpytczuJ8ERzqUkI/sMy1N7KRWLGh3Asu/dJBgn9BTSKEiHvut4w4Dv29T6?=
 =?us-ascii?Q?SHubF83uol/5PBZTmM5hPpe2NAr6SI8GG9oU2sgInRkxzdppmQVZIlw8k/5I?=
 =?us-ascii?Q?2RX4ZBW/7EPk+Yc9HerpGwxzXLpUFuqQWMgQlTgXiwZMMqm2FWFQYlJsiAk/?=
 =?us-ascii?Q?MZ4Lgq3PytMrTx/vYrq/vAlO3oSZi8DSJqEzr0fiH+53fwoddfLs6kjmIfbq?=
 =?us-ascii?Q?Q/gfNzoJ1t1SYYAlKrXfasBcHNmlX17rVXPSprmYIAG4A5m2a+yVrke7Z4h8?=
 =?us-ascii?Q?GXvK1WVL1E9eDYTuBZwpE7fy2Iin0PYUWFF9adaEbtDkPvEtQJCwFNQmnA5l?=
 =?us-ascii?Q?svOYSn+2YJCEg/KAnK20p+Tlxb+d8yoeQQphRqF38gDlnUOulJcqt0W6bbi0?=
 =?us-ascii?Q?8/c2kGInTHLsAojkmrLgQ6o4P0m0JYNsTO2AF3PKIooRZMLclhYhG97mLK/f?=
 =?us-ascii?Q?OSS6P9dBGam8aQ1v/in+IFTbLRC/zTOCc+aNqmcAGquk0aZ0hhuimAi6L98C?=
 =?us-ascii?Q?k+7EWmpdObY3jj+Rqrdf3gFHMRiZKa00Noc3+jFG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd6def5-a2d5-4fc8-9093-08ddda4ea673
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:49:09.3445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAZuwq7ZO93m7YSLuOMXb+kSKn84qjTpiSJdVgCUF4nOBX5bviWPpbocdhtxgOI06m5LhBr5l427gyIT1YhJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6927

Remove unnecessary semicolons.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 7d8ae2cbf72f..b18043e31ae4 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -388,7 +388,7 @@ static int telem_device_probe(struct platform_device *pdev)
 	dev_set_name(&dev_data->dev, TELEM_DEV_NAME_FMT, minor);
 	device_initialize(&dev_data->dev);
 
-	/* Initialize the character device and add it to userspace */;
+	/* Initialize the character device and add it to userspace */
 	cdev_init(&dev_data->cdev, &telem_fops);
 	error = cdev_device_add(&dev_data->cdev, &dev_data->dev);
 	if (error) {
-- 
2.34.1


