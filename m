Return-Path: <linux-kernel+bounces-791546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CEFB3B866
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F70A7C2B79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035E23081B3;
	Fri, 29 Aug 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ONJyCzaZ"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013026.outbound.protection.outlook.com [52.101.127.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188F2FE07C;
	Fri, 29 Aug 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462471; cv=fail; b=Sp2wHJp2/qY/We3SIbaadhieH+3V/OD8ff0CttDIm3SKmkYX2njWk09bn0jWVRj5m3tIYcEeRGo4mk+uPfj7GU2A+LNeC0vFQVQcZLgKEGr4+GAGklLMKTPOO2egaFa9k9Bxul+56EcmOzGlSMBQsZ3DC+eZOTrdaDRte1z+Y5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462471; c=relaxed/simple;
	bh=qm8JxcuotfaQw1qSQojaL7BQ0nFW8rXqtSHl0trx5Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rkOwTe7Z2EWRgqrUuyStYPquKQwRx2ijIdgjDJ/hrR5DOLoQZmuyVnCrbf2SM+fI45L1Gc66UmDSZpD3ua3IplHwkkxG/5qz2+E0TLkB8664RqdCB7HttUx0zrWKjpZ+3Rb9oG7xFywEHJbnxWq4BXjGcvY8hFbtIeljwmI9i7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ONJyCzaZ; arc=fail smtp.client-ip=52.101.127.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMIkyG1w+KAbXZih2BApajMMohbK5aFCS1vUJfhva9dO2SuD4EsO9FzNClswIeFJJO2JGWY83FT8ua4dh9BPYMJtR2uBOFi0H5A9g6GpOmLlTyxohY91J4Be2yX6bKZPABF/OOZ6eH1uuxqOFd1f7JlH/e2bYx+XK1+HTAyUNoMBsZ0hC2bfHdaJEl5hc2UYeBN+hXavjHExnV5cSpI9LPDenRCjJyDudFtFZRm1relJ5Zwxoo86ufWpNa9w7YoKh0+zzSG4r7Cn9R7UtqmQLZcbQCiOh83pIU20vSy4uhrUCcrJEZQvlSqFHj/5cvW6HybYq3XztjJja2jPwudtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3XmI+kHYb67lo6TKHuNiHJbnpImg0OeJoz/8UvWq48=;
 b=MFzsh+Q1tCPLzkE2vLG5g0UQIjPurDp7lSPnwIkpKfczEHI6VNACz52oNbw0ri96peqC/Yv4/spbgJb3Hjo1K1IfvYpyyvJtQRXrpQaTQ9V2LRTsk7zmDycCY2LUTIGoZ519e9SvZ0oxTDNlHe9wOMbKg/a3IXgp5iMA9hu76v5crPtfokgdu/2lesoJOJLzlpiiUl/W12vuLAwUghn67FwdNCU/cLV/fZlY9cmnXbbkOgcr4JjbO9WBkFiErlODCbtlODQSnbl6VmDoGCg3rv6Aqfse8HqCoSUkiu+rZkzy/NOwbCtYC89rpLr4mzaVPrTjsk79Xu0RWbf3VOLFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3XmI+kHYb67lo6TKHuNiHJbnpImg0OeJoz/8UvWq48=;
 b=ONJyCzaZIL6wuvzmymJReothz4vumdKPMB7aE9ZM7ZGKfMKIQRtybDWsbS/yb8PQczmVEr5sizN9Zr8evTsY05q0jFX09z6M6OjlOewxSFe0LGQ5bZrVLL8wRInaJoOUQtxCpPVM0Pclv+zINzRqAp0L3mUbOJ26GTtpboQQWQ27jtwE/RjhjkuWUk9SHKsnAAi32JmSH2TTKTwIy2mL+e1ZBsuEL6z7wHMkl6c/kgDS3rGLzxqWibxZmoXNnjMqYhlSxUUyHq78JgaxGxt3e3f7N5x1I+dIiJMZHzjHwX1sT4TkONjPj/ismymYrZAB7+i2cUhapTnXyqpACtKbAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB6788.apcprd06.prod.outlook.com (2603:1096:400:44f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.18; Fri, 29 Aug 2025 10:14:22 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 10:14:22 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] regulator: scmi: Use int type to store negative error codes
Date: Fri, 29 Aug 2025 18:14:11 +0800
Message-Id: <20250829101411.625214-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: dd270724-e301-454b-0fac-08dde6e4d294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3uZb+SJw6h0rSgQifkqoHrOlbMyglZ/iS3ezH2xvlu+LVa/vvd3vKPPiuO2w?=
 =?us-ascii?Q?ASyiYJ9kEfUGYkE4Y6J1dtP6bSYfHVH7wCG+jZxI+PyqyY4vPw0+JI+rq5I9?=
 =?us-ascii?Q?HaqrOsH95JfXxhQnlC4hqua/DAjdMwllc549cC4v5YAjqbpgHTKnNvW8hs2W?=
 =?us-ascii?Q?PUeSchJzx9bWOPcPjlXASBEJrQZMfoEWUd1epKDIjeNKkkw4wSKlvKh40BBq?=
 =?us-ascii?Q?g3i5zrzbkT7GG6J1bOMOumhpactPyEwxZ9zBZNk7PAuSrsZWKFPZoxKIMT/+?=
 =?us-ascii?Q?zl2NDjZNrbCSoNLCmmjuBfbmVXbP+PRNPsW6h+Zhou4jCUMCZksktVyNxiiM?=
 =?us-ascii?Q?htREmUBYXGyqX5sT1x7BFa4xsVQMqoNuHdUbVRiKdvhLfhwASOU/KjB2lXiY?=
 =?us-ascii?Q?XNSssBqZez9ahKIEjNF7na8Oqj+4mDGwQI0m+kLODZhITnyiBwS+s8AbFIgy?=
 =?us-ascii?Q?buHHrUk8V3EhhhnyPU79bW8+KX1aEuEmLv0+aFP44f+43+rZKUaBk/wBm1dY?=
 =?us-ascii?Q?/IkxcTMuEeyBhrV8ohgVUtDF+V+oI/rnl5G6MmMoXrcXwCYvNJmIBfGiTRv4?=
 =?us-ascii?Q?mPFvpPHtA2E2Jk28kd9cINzzaSPmnkbFCzASthK+hAdHsrlQ0zu4ysJ/Jzgw?=
 =?us-ascii?Q?j898lhnbfpyy29BlSK2b1dIMjpJgH1T9OPZOEIQyCwFVgBlMsmsDWwF1ixMo?=
 =?us-ascii?Q?ywBIDCsLEGTJgN0xS7HrIt7YF+NvgFkrfToAFhU/7ymxANnSy/97cdB5AV7k?=
 =?us-ascii?Q?F4tMRKA97wq47MmQ3vFibPvPs3Ta0ctqd9lKHjsVuEv3MSdnANihKeVsz46i?=
 =?us-ascii?Q?afkdg/iB+8ynaMj8CfZmO6p6F9RU5IHnsW/hufKymplPCJfJksh8SXF3nPX+?=
 =?us-ascii?Q?dDVLKAKpqTs4wTJIDy0yHibRjMzxOMR+aGvtWFdP44oLL8fcgyWQCTM6F8iL?=
 =?us-ascii?Q?qanOZA01hBLVktaAaMoRez1O6Suas+QggTlhpNCRslI8HBUWh5pZzgMwCcxK?=
 =?us-ascii?Q?QrQjz3zqWkP8qq9ioPmvt6YelI6CtPISdP+xiPdQXb9WUGyQwK1jlIVDFDsX?=
 =?us-ascii?Q?aqgG+4SVxhO3qjKKyd/aDMmBDs2zoexqAZUmb/4hp8QRB14de55Nwd+tDqWN?=
 =?us-ascii?Q?mW8Qy3+RqBohJ7nnGBv3Lxg45MrcbkiKqV+oz5/lhMV7F+nw9aG2IbQfQT6s?=
 =?us-ascii?Q?YDQ6wXyfSzATt+OjWMscUoLBK+AZFgXFi+OJ0c6Q0WDolP3swO06vaiCjzNV?=
 =?us-ascii?Q?dRYpQOvjhv1zjdSFSCmNK6GRqCGLmeRrTXSi0ZdPoO8FlcthSYmithr5/QB+?=
 =?us-ascii?Q?1wcYU899KKZV2gA3HWj1PAWIrs678DWDG5jSEKc+ehCmDsOJm/ZMWIRYFKen?=
 =?us-ascii?Q?xpLaFO8g6BhtjF3m/HtjoE7qT6fJ3ob3kSNgW7DmdvIUNgxPDA9shicFsFtv?=
 =?us-ascii?Q?3BB43GdEe0tuDXi+tj6AR8u73bRLJ9DH95Jqiu4pmCgxrnWkIDXkow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g48z3sDTTAgQjXThZAFqKmZKPrneax1yJm579ZzSrtRg8PmEj4a/BCqJUrhL?=
 =?us-ascii?Q?2pyqwCRq5qxl5MYHiS35XEWIk7FsEc6Td/RKZpmaOizeC7LEc4/VeszhCI/E?=
 =?us-ascii?Q?sfPKSay9z0jiWHNW6Oakje6V0UuCTVdxUS/XQ5Y6ZQPJk4MC4qR7LfP2DuRB?=
 =?us-ascii?Q?a6Y0REvYInKH/IXXkfZicd6zFytCpvti9bwJt7Hdf9yfOTkQ+yaXwpKMQ408?=
 =?us-ascii?Q?QCTAIilWKwqML6QbitrsW+MJ/Y+mmKYnk2Xuy7e7Jje6Yr0rJzG/9A4OdsCA?=
 =?us-ascii?Q?+fKo3WdiLUwJXcKgYIhRUFDliSC7m81YahKNXXpp6rR8C5ZpRtCWXUMDUx+h?=
 =?us-ascii?Q?PzQdHa/IYM7fJzH+aIu6dD1oedqB024MBaMncHtfAeo0ijEhPKizJYh1A7BA?=
 =?us-ascii?Q?rMj4Jw84QZs9KnfWl3u9D8oKZJH6y3jt4DQybKlIGsCst46slfstTBvcYvwq?=
 =?us-ascii?Q?JpxQKBjApQw0u/JpqdxHzKBolbOFSKi7hKmKQn4BGx38G6L9yYw74ng8imFy?=
 =?us-ascii?Q?y8kyeHq1PDuVeB6YurIr3/bnY4RC6UDTccnKqFjcmGqr/BVP70tp5KD/I1CY?=
 =?us-ascii?Q?gF8/lhGE1pzS2jMn/5cYgIohoks5chcXRbj+qpT9mbu+W6QG8FdpqCQhQY2H?=
 =?us-ascii?Q?vmtfWVxoGD+HBIMb4XQpwIIb+BtlqQNMuy8i1vku4cd/h5xm+IxYinlGQxud?=
 =?us-ascii?Q?yiWArE4HCoZ+UCdMsWEcXZ5vLKXLV5aLb0iWbfE6dT66s1Lhrzv9cFso8T6j?=
 =?us-ascii?Q?qOv0g/cGYJOs49Cp959mzMqigcy8GW8Q6EKphsunzperXJzazYMkFBeXhbpX?=
 =?us-ascii?Q?6DB70vEh0+mME6HFuJhEIe7Wumm8eC7iaWgUlIZSMFqWpEQTGCUyqNDEAdrf?=
 =?us-ascii?Q?ylv5pV9/gIYYW87MDdYlbTM5F6IZp52VTtawsqiTkXxky8OjC4C30lN2VePd?=
 =?us-ascii?Q?76k5sI0rJU1mxTFOuWMiDuYy1DbyaG/tVaVFuusD/P+3ptyCxWDFG/a5n5L0?=
 =?us-ascii?Q?PMwvErWX/iTrSFkAHFi5zVD4C+d++Q83+/y1G9OZB4I3QTKZs3xuCmEuw8QR?=
 =?us-ascii?Q?+2JAsZCU6ebsxk23O3F7SY4JDzRdeoQvdr02RCCxLFbod5eu/kqEhtJr3Qep?=
 =?us-ascii?Q?XkBkNeLwqXdb2xeN3Ux3mKEdzgikWjmwK+QDg01gDVOHj2U/3OsYAmvPg5ev?=
 =?us-ascii?Q?74p6T8faHcrAweI3yauE03E5VOzY+UGDixVMROquk8macoNJPa5mZve3aTY1?=
 =?us-ascii?Q?SHl1whREdpylP2o2PUlq2Z914o2ZS/1mUjavdgZHyDuplJPES2fyyCieATgn?=
 =?us-ascii?Q?oR0zaqvw4LF0tBFx0eT1LMNh89cmwGOlRtbHKBF9tsUJi0lFVtQYAng9NJzd?=
 =?us-ascii?Q?7LDihhxkUS0SSLLgrnVPwrEPLZS/YfGMjvA/Zk8eJRLwKm8XqG7uiTtdh8JN?=
 =?us-ascii?Q?a9SSl/qs+f5H9OqSnl/TExnenVodVoljUorrr3esX9OVWx8K8MIo6v8NQqXg?=
 =?us-ascii?Q?MlGy+UlHMJRNQFlSnQN2LPifIMHsFesN2MxSptjeKQoeD4HNNyupog0T5+Nj?=
 =?us-ascii?Q?RVskX2xwHQa4Ccy8vMK3TnLZGb31CMfKJpJKNPDo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd270724-e301-454b-0fac-08dde6e4d294
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:14:22.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQQTdJNiBT15DlyQgg5WOheWfKR4ClZZ3m11gacEoZ+iXSKUkIsmgjyjnEUH3mQwN+OBRrzf5ZsQ1Be7ZsSctA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6788

Change the 'ret' variable from u32 to int to store negative error codes or
zero returned by of_property_read_u32().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/regulator/scmi-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 9df726f10ad1..6d609c42e479 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -257,7 +257,8 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
-	u32 dom, ret;
+	u32 dom;
+	int ret;
 
 	ret = of_property_read_u32(np, "reg", &dom);
 	if (ret)
-- 
2.34.1


