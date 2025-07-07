Return-Path: <linux-kernel+bounces-719464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD66AFAE44
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 10:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D774A0CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F086F28A703;
	Mon,  7 Jul 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DoEUPHnp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DoEUPHnp"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012022.outbound.protection.outlook.com [52.101.66.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6028A1F3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.22
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875736; cv=fail; b=giiORpTQ4oxbcckyTrCIMAmQLuAPx1zLs+V4J7BSfzNibQXE88l/exaSPXgEAm+g2F1RFSxRwZSWjheXks+iJmLmWI4EZyOylMMdyPJUsN3ANdaySdCei+/FucJOjvb2MlFKNABzL/TWPIMDQF90NmIVSgKmeGszInIiulViaUo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875736; c=relaxed/simple;
	bh=cDspw3YZpgCNzqlprhugvwDAaV69H++EqRpao5b6Dd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6qn2hgFmarzHRKRIN5PW5LU4lxSYwEF6xhXbS//FCPw9744LYDNoxs6dHdXSiJiHFrXI2aeHiAS1FoQpnpjYCceAzx3r3V6EzFMO1mbO4YOgCGuoNiuhfwnTF8K8EZr4BYbpSs9Rd4NOCYRGbaGov0/sknOtTAs4NJxAQADLrU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DoEUPHnp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DoEUPHnp; arc=fail smtp.client-ip=52.101.66.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BcJt8AXrrGtxsKMHv7jq5JLO2ggw+mp5ICzXcJbwieqfYrGb4NTtD+zMojnHlsPpiKUtlXIhIOJO7VaDJVjnpr88Ef8MiBOz6d5zy8pEpJhH1C+x9b7PedaUbUhrsCGsZtOZfH6L4B0AeF5qyegEycWBl+bnSu9yPYbfQDxDOB4DVnfPq5R2RshR63ehKK21ebLTwEpUxIPXtYjFzR/V9xovbaBGRlmh3amxsEI/NegzrK3lgwiYXkkU3mjG4nX8HWD8uAyhB8r2Bi+bSpRcciCgdYbXp8VEvNE2irxGSczq9lF/WNeQdcl20GkcpY/TugMiRMfLrwMRB5Vy6QvpIQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQm/vMkOh3SiXontS9l4CPD/mrT2/oQ9/GBHmQvIx4w=;
 b=APi4vp/ir2P531Gdnd2Vqrrw28nFZ5DVyF1c/Pup/aL9pSBlGIF6iQtm1EJ2qbMnYjfQl//7+5dRn4nrBXVUY9rH1tWyqwzQ608mmg1b0uFBkk5aedu6SFjJmlRknpX7SxOOIxYGFWxqzFlxPvuqGIoMFc4/D9CCeC1EIaJEIUIZ6RcItJvpBry4ciBi+fTN5vTvXlkXp6hdPq584qB82cpBLvrDgBQWuqFjotuRZ7cLEffD8vmZkPWu6+pV60QEmuvpHM+0OyCcmbSdsS4VAtlEcwHxDV+dgjKIFqOGB9Wxm8MT3VezZnbdC6eLiJHGsUQznIyZh/sTM8cSZ6FaEw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linutronix.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQm/vMkOh3SiXontS9l4CPD/mrT2/oQ9/GBHmQvIx4w=;
 b=DoEUPHnpuPjs5LOciWvShAm3g4OMAzoActtoQ54ea+tTx9lDstUPKG7+GgzZTGyQxDRiQyVyITQFowz/gNvfsXmgheGyROfvOmUXCHuvVYPGGutyBdhQwtbaz3TrpzNcos4mDVD7gFTMZ3pkTNH+ZHYNQQQ5JkqvIayG+neeK6s=
Received: from AS9PR06CA0574.eurprd06.prod.outlook.com (2603:10a6:20b:486::12)
 by GVXPR08MB10812.eurprd08.prod.outlook.com (2603:10a6:150:153::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 08:08:45 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:486:cafe::6) by AS9PR06CA0574.outlook.office365.com
 (2603:10a6:20b:486::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 08:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 08:08:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/fMn/RTZqOL0PbOgSjCrSXGJGglXHKFmu3nzh5CeeAkMc2pghMVFq4RSOfxbmzq4jv4l9NmiXry7K/ES9Hv3sN6Y334lmXazFSvtV9vPUW/Ffzl9YGk5a3Y47COCRnok8gGxEivM2ei0owtxwb4uMsCgb8jylyjHfsbvl/jf5TFIU3ZgK/vHVmizukTjS1JOtuH4PiJMeNtCMYsh3oYl0hwqKYcWd3G9sCedxtoUVl4IFBwwZJOWrpmN5N1cQ5I35+H36HCepdpUHmv/hKmKdhS1jrCzILNmCbDrnX1czTYhKo2pgXjz/TckowFW9vfcDjizHNiTm4RX3xeKqCaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQm/vMkOh3SiXontS9l4CPD/mrT2/oQ9/GBHmQvIx4w=;
 b=pvxSc8lCmxrC4pSZlmQ4wrmNWh1HtfNacZ/FwEGrbNzl/n+b6E4QfkqxckGW0L3Fl+XeRHBwcgESj6Rg/mp0QWlpLNR2TkUUorv6XtQtpQm9SmraIiUgzWXd37tuF+eAcIDyImz03fUruBa5JA2g+uyqbX5fmFRDMnE1wsLIEqRVBjBbSowqC8at8vafIVvXZok+Pn/JUIgonpO+BIDCSx5v7rL/27txY7wKRTeSVIoof0V6Bbjj2ctJ9NlYfjMBaNfcZ2GoKYgR21ygPtljhha53pxy3E7MKkmaOWQbqXsFgdJKALZ+0khwNcXhGR+yeFWlsp3c1K0nGktc92BOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQm/vMkOh3SiXontS9l4CPD/mrT2/oQ9/GBHmQvIx4w=;
 b=DoEUPHnpuPjs5LOciWvShAm3g4OMAzoActtoQ54ea+tTx9lDstUPKG7+GgzZTGyQxDRiQyVyITQFowz/gNvfsXmgheGyROfvOmUXCHuvVYPGGutyBdhQwtbaz3TrpzNcos4mDVD7gFTMZ3pkTNH+ZHYNQQQ5JkqvIayG+neeK6s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by VI1PR08MB9958.eurprd08.prod.outlook.com
 (2603:10a6:800:1c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Mon, 7 Jul
 2025 08:08:03 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 08:08:01 +0000
Date: Mon, 7 Jul 2025 09:07:58 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	kpm@linux-foundation.org, clrkwllms@kernel.org, rostedt@goodmis.org,
	byungchul@sk.com, max.byungchul.park@gmail.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	nd@arm.com, Yunseong Kim <ysk@kzalloc.com>
Subject: Re: [PATCH] kasan: don't call find_vm_area() in in_interrupt() for
 possible deadlock
Message-ID: <aGuAXup8Zap5pvMB@e129823.arm.com>
References: <20250701203545.216719-1-yeoreum.yun@arm.com>
 <20250707075946.2lAwc0OR@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707075946.2lAwc0OR@linutronix.de>
X-ClientProxiedBy: LO4P123CA0630.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|VI1PR08MB9958:EE_|AM4PEPF00027A61:EE_|GVXPR08MB10812:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aa721d-fa0c-4aba-8345-08ddbd2d7eb5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xz/10+fPXUts04dBRGNek/OvfgK8KhEHIoGFkbskaN/O7+wewempmyhE2pMN?=
 =?us-ascii?Q?WqN7r9AT/F4mVB+XNqupGLiUPHT7Yb97rcwBtpT+/IdRiJ7F0+rUB6qRngEE?=
 =?us-ascii?Q?tbtdYmFKDjF1KYCqim4bqHLMXv0MqjkuLzavU4ph5LmHUau6Gk7tg6o1o8vM?=
 =?us-ascii?Q?+tmtvlR9wiQmOeBSukXwLN+53pGGZr1a3EKnfwNB/iLA6IxbbYYPfCpuyqL4?=
 =?us-ascii?Q?aQZejbDkB+DgUxMA0bV51IGmS7Sgho/E4Sl7hPQvvLElvYEmRFXUHP7iQ5zO?=
 =?us-ascii?Q?X7RoQaM/YR85g4gos38bIOd2cABRAQCeQYrM5sUzy3alP07vGh8IRNvk4MGh?=
 =?us-ascii?Q?AhfHrEct7DjCYF7FuMFdKQFI2vTFefreUvjuiD7q71w0GjBVCCFJJjjkrfaU?=
 =?us-ascii?Q?jhmQUoLKH9SAzHuvLUjy0MLTADaf+jobQjMk1GBsZTkvKfVsi0iLEdOXqgmp?=
 =?us-ascii?Q?iPDL1iikTkMiX8CQ7YI3Zgyt8F8yLtAwtWacRY8pa049Pq2yqKUU6I8KFIOP?=
 =?us-ascii?Q?rbreHPda6BnayZ+RheJ5+OM402kHSmZz3ct6xmI3/xZb3UHMCsrGzWVEMuQV?=
 =?us-ascii?Q?d1jFk551hMW6TZ7qxu1dd3hjQYZlbHpwv2v/YQ0NAx4gAT2Z+h/VKS9WJwBl?=
 =?us-ascii?Q?GPyt6vyQJpKs/ZYofEH0MI4rZHZ6RPEK+FqCZn4grtwuFrP5G2noEpQuikbP?=
 =?us-ascii?Q?tbPpWSDzHIFzRjVn7Xd3ji7ERjk5DiUTemLYAXflnloj82HGSL+AnPYT5Wu+?=
 =?us-ascii?Q?+ak7jyvpwiPPP5KGo2tKCiJkL9EDIoUuwyUpYNrKp/Tq2luNFW6Ij8kiIFia?=
 =?us-ascii?Q?9VkfvNR0VMdoOybuKCKGD8Ifv9akrEYSgdyRQstGvqsKuGIoT35siiq+vU45?=
 =?us-ascii?Q?eD7yQZmosQ4QwypQAN08l+o9Pbbs3IYLyvFCNNSoSZ0ebpakVV+D9LVQLfaH?=
 =?us-ascii?Q?o8uX2SgTs/PdYdltZgf3JBxMfJwhO6XKUcphinDpPt59L1Z3Gbe51hRZA8xm?=
 =?us-ascii?Q?ee6Vuiafdztuy/wR8mMG0F5/n9Hi+a3UIyqBHwjtgnLgCFrpgkOAN8BgyCD3?=
 =?us-ascii?Q?u4a14mIunCie8AZJfXWoT74AT1VSiiQkYfWfjAPl78p2jAagGh+EwV84NvMM?=
 =?us-ascii?Q?1RlU1eGJWuYRU41tD+8S8nUFokgqq0WxFp59+G9qcX6gx5Re9ULnd0Q+nJ3i?=
 =?us-ascii?Q?5vMvHlHdfrrMGdRsyDQw0VD+4Y6Lvd33+GeQuBYgyORd/1WcqA0sNtaXrpOL?=
 =?us-ascii?Q?oMIhZMn4HmObQEsui+wC0o7GjhkYviPNU5T76bvTPeo3lF97oBE2SpuAqKAN?=
 =?us-ascii?Q?oDtgFEphz3XQeF7Q9Adk9RW50NCL4tZ/7WUzd8A4D8D1C7M+eek/55hzJp8R?=
 =?us-ascii?Q?kCPm0t4wivKcuobwgPJjmyyY0XEXx7MqyJKSJvkW5RMoj+1KrvzSoBtioo7N?=
 =?us-ascii?Q?Z1IlUBRrlpw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9958
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	46fe3ece-29f2-4120-e7c3-08ddbd2d645f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|7416014|376014|14060799003|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rO1BgD1kIsBYD/7XvsoeN7ibC2arsWV3ekJS5v49ibdtZzDo0t8CmQmD+Di0?=
 =?us-ascii?Q?PbkJG5K1+epYAVlnQq8NKTIQAz1B73kDLxLtPs38aMzdU71J+XLFd1GzUn8A?=
 =?us-ascii?Q?67iB8yTAIHfC3H3fONQpRVP+PLef9QMpScLWfNiGDKun25mawB0l+iebEGT7?=
 =?us-ascii?Q?QrATBbTkXPQ+z1SUG2nt39EQHcUIvjKk67OzE10VkixXCNp4DHc3+NS8RL3l?=
 =?us-ascii?Q?YQ7qgBsR/qDYEWe3ywC4o76z4LBLEVO6GrcF9BgBjkJYaZWFtMAdHlas7nKM?=
 =?us-ascii?Q?1celD3iY6YsH7aiCIKs4IekFTl6iP442zKbkOi5xxSH4JK02o0NmwkAYzA69?=
 =?us-ascii?Q?ayeoVVO1q6xLBXKnrdqDCU7DdoCp268IWW9+BEqMPbvj0lX4iE9/Q99jyxVi?=
 =?us-ascii?Q?+FNizfhsnzssDnko0T+R3v7K59dBWzl/ENhFF0EZze1kNOeMwWUh7FWBh0ew?=
 =?us-ascii?Q?wdvd/CWQ/QuaIpmqPJKPtRKYpWxg/eNi92RCsTorI5y0G5F9IN77wgQ/CJj8?=
 =?us-ascii?Q?TcVp8rG6SKtooN85sZEZMxDASTIZ3XeS3i19POwIlDA4iXbV8uaNMMNOcMFR?=
 =?us-ascii?Q?FatQAELsrv9+Utxdi/YWhwxHE1M2y2hJy/WoinEqUDFe4hrWDI/nZl59864l?=
 =?us-ascii?Q?IdG/UBXBQb9+X6X42Dz2OjCv542dJkXhUwipXWY6AxBSIEkFF01QKt6je+v7?=
 =?us-ascii?Q?+B0d5TCg8WWt3DMG/FWT8/gSSzPyqtWPR0yOELkKkvuo8SW1CEhqmkg26sQN?=
 =?us-ascii?Q?BcgVWFTAR2MyRt5+kU04Lq5muTCuCOQmzboteu3UstVb5d/gU4IeNHJ992k5?=
 =?us-ascii?Q?PUQTjUMzheaNNLBd0VlH+dL1ViVkVUjNDc0rrPmlIfC6UE06UP5//5hOPskw?=
 =?us-ascii?Q?WmzvnFeu2OteYPLsnQe2ufGlVvgQA7YjABcLWt3P1acPgtj0fHhTfI12atrS?=
 =?us-ascii?Q?UAl6gCDxYTQ67bDib2Rb4ACnkLl6bh8GlProtidzVwCDULwHLv0x1kxzA/VR?=
 =?us-ascii?Q?NnYFJLhPexVfY4MIoiFPW35Njfq8/ABn3nD11aUEHAX/smFfrucrmgKtOdlM?=
 =?us-ascii?Q?m7K3TMKrpjHZbv41FXa/MlphcaDK37R9EcrP2Ubex0CUdGP6Ww+ViBAZTNup?=
 =?us-ascii?Q?floriaayjGJLV9uYl726xZF8nanSpc+w5QaOn72mRAFM8D0OPPk0/4m0raX0?=
 =?us-ascii?Q?NvQcrk8+wQwCzn3jh0hXYP++dAwYDFX2ceOlxWFv+JaHKSUycG8/fgaGKK1m?=
 =?us-ascii?Q?foKOB59ur5k9B8amHAxVTeJUgKwc1Syix5O0k5yVLL0lPubQm8pxgNyJy+zR?=
 =?us-ascii?Q?sdWEuXheLJE43CebXpn2bz7D2j/38R7AOILsJEcf4wPzVQxgqxH7DYkb0Qxr?=
 =?us-ascii?Q?sJ+Vqn4Yj8+hjtFOKNOkqAfFZ86tkHEOINq5eD5NxOfnxZ1CyuJmMORG01ql?=
 =?us-ascii?Q?CxhVy0TfJIXC1CJElU4BydjnG/+VoLQRD/jSl7J9HzQmRYZsbVKnuhR2I/pg?=
 =?us-ascii?Q?XQ4cwEVPnYFVkf+7+rye2nOBfLYLzt9sNv1T?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(7416014)(376014)(14060799003)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:08:45.2497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aa721d-fa0c-4aba-8345-08ddbd2d7eb5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10812

Hi Sebastian,

> On 2025-07-01 21:35:45 [+0100], Yeoreum Yun wrote:
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index 8357e1a33699..61c590e8005e 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -387,7 +387,7 @@ static inline struct vm_struct *kasan_find_vm_area(void *addr)
> >  	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
> >  	struct vm_struct *va;
> >
> > -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_interrupt())
>
> Could we stick to irq_count() ?

I determine to remove kasan_find_vm_area() since there's some case
couldn't be avoid with irq_count()

Please see the latest discussion:
 https://lore.kernel.org/all/20250703181018.580833-1-yeoreum.yun@arm.com/

Thanks ;)

--
Sincerely,
Yeoreum Yun

