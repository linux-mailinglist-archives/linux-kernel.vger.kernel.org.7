Return-Path: <linux-kernel+bounces-761220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2409B1F5E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F09170D70
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352D81EFF8D;
	Sat,  9 Aug 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zj2Yatnj"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2F2BF3CC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765307; cv=fail; b=mWhg58Waa7ppTY1fEwQctnMDadOpAouVzKLgFwF4Ok4dssyhgUcZ8bwOg7sSk2m9dN7gakZNfyl6OlQ91IhNu4XFXpo2U3xYspJ+E7MifSAyArqseAQikXzUoRMTdhWNF1MJryjqyOJAkgANfvtv2GMb30D9voOxZH01zUkcU4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765307; c=relaxed/simple;
	bh=Ql+/Un2trNbMr+Vv9ekJ/k+vLdiEj1JUejdCJh8ItRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcE92PJUTIkYMNU9ebLhxXTkXQ5hIF44xEcLm+NYidCot0WNbEQq7u/vj+usGALCTxJ6PxOpN8pdORKazV+pkG33VPTh3m9JPe9efFJGYJkNZPWJA7k7UQUpEK1+fjSUI+Q5s7NNrs+K2EWNPKT192vl+p9lZ/wtE/BNVDDCVaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zj2Yatnj; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UocOF6je3nUltk/9JYhtlLXwooIMlpaZpeSx0v77D+TsXYDk6a3sn5DXMtc1dmLj68UlNWLLIwaPR2f24+rJf8C0Atj1Vx7nYkYwqDs7emZ9ua6VJOrEZmzVfBSo8dEWj12BS6bpURLDvGYYlFD8k/Ec7jAasrprOp/pBm9alsOozzaYoIyIiXGJ09jUev+gQtigi6dYeox9WdsJ/0vkqH1lwZJWbKqj7nLBByukD1+Sbcag/Os8/ljNw7CHbBJIzVMe52V60poDJmB42/yL30oQPrXftRmi4NcR5M026CGN29Y5OjLEK37ovu7H8V6Cai7J1Uwtf9TOZji3hkicUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znYVJZh8W5eS1K4oMuOKzYxkvzqKvkxEyadZaHzgwmU=;
 b=I+JM/WzjwRwsq8Z9ty8PMZVEe59G05AXejKImrLyvIJ6g+hSRq6z96uQq9lsZVxrnK0meGPd33W72irwYDIjNV5O651Mu7reSBjXIcBW2ZFoLY2VdYhlayrED0toizWdBwRPDJFViZZZZoNf1tG4/af/4JeUdGwCUCd2Orbx+DOI98VvCFInfL0EKofvnKEqdU8NAzTgUz5rO4zNQe1UVyr6DFU+HG1R471hkjBnnwYGcH8bUe6a56SywRV3ced0sKAOzhdXU7mJCzgscwVeJZaGG6BE+dGOuhzRlu5za4icETJAxooEp5wnNDEaMoK7+7w+htUqqFc6mmBK9uyElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znYVJZh8W5eS1K4oMuOKzYxkvzqKvkxEyadZaHzgwmU=;
 b=Zj2Yatnjk/BoQBy8wzInox2oR8Gg/NSDwKoMsJkvHIGxo9Nx4gaJ48j6LENGAWNxq2qNO78pg4iB0zu3X6oeLnRrKBaUeO2cB3HL5D/g30sxpi8/CEpZdY8eXX2HxS7cRseXZKPLxf2loFshQywQzg+dYysmN6vOqExsdGvfm0buKHnOjyq0WJFtVNCg4as28halTd3HKFo4hJ6BHqZzrTEJYL5PzS4I3K/lv0gqkBfSrm4xgMNYhK7UP7nRe3K75cqFK5DA8sbSPwWb2uCh3XISAUBjxd+Xh1hndsTzz1yeXYKuCMAEeVooPQ6SWO69UNyQcyQMI1n6jFsjzns/AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:23 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:23 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH -rebased 03/15] sched/deadline: Clear the defer params
Date: Sat,  9 Aug 2025 14:47:48 -0400
Message-Id: <20250809184800.129831-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:408:112::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: ad561d75-e8d0-4524-1e1a-08ddd775516c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQhUwxlz74fGq+cFTwB5iTkQYC1vdfGSIE69foi4di2vQTUpuqGe1eoL8S9H?=
 =?us-ascii?Q?4t+vAm1Sob9kGaCDZEH9Ju87GAxlbv5qcWd3qW3qeWIN9EtWXow+c5fd471/?=
 =?us-ascii?Q?5c5VM1PpwyX5D3e2RSJ0RfLzKWh/5Ur5yLJ9gzhkxxlSPjSpvcXUcwd9wfTM?=
 =?us-ascii?Q?X+wUcLJt2+qVibjxW1sXN5dbdg3LnR4VSh3dPb41VrJGC4NNi51alP7MqFMB?=
 =?us-ascii?Q?Q/nfNYXIUu8VXnsMA6Rdk51w0i1tq/MnXIQVTc9rfO5mbaszor1IQ7zDMQc6?=
 =?us-ascii?Q?t6VaZyZjsaAQNFM2jPu92axB7LCnJU0l7iqE26MgOpwL28EX89+N7Z8u3bMq?=
 =?us-ascii?Q?J7HBFrAL53lRnZBPZ0kZu1fzjkbjnXpL46a8R1cyRnVUXdPfZr4b3G/iNnFa?=
 =?us-ascii?Q?1Wh9MlJT2WqMThYqvJ4yktD+/IGHtzmwOoQJONNlR71TIIsA0ZLA2Iu3M1qM?=
 =?us-ascii?Q?A2rXIuhnzgauYX1+sfjFW3OmU2+hfNiwmPfLq2ce2uwPz5ftcuwsVjE4uaiJ?=
 =?us-ascii?Q?6z8vga8BuJRFV6wmATTDXRpz4VWudfVrWCJSxGL7K18kd2tFfIfHYkJiISnh?=
 =?us-ascii?Q?h6UqMZjagO5r/uOVe5dlhB4ssmCWdrCz6yRmVs0/MP9u1B7lJBFzDG5Z/Q3y?=
 =?us-ascii?Q?UoCHGFCsaKz/5PVhKULdIELUKpjf9BuXsFIJjXUAh7vqrR20A3msFGoqgsBK?=
 =?us-ascii?Q?8RvipUzAeh+I7an/QbTG/DuiFVWDhi5j/hS2iL4TnjQ5DEx+pURhZn8T6Mz+?=
 =?us-ascii?Q?fg0MNg6pbGowXyvY8Sm5/koPd7JM/QaUj80Y8GH+5oWNH4hbYS9F+SObtWhd?=
 =?us-ascii?Q?vLeYjCzMvrCoP21Ie1Ybyc6ZyPe/hRUsIpNd5mQWTff7z2X2wy1CPHBl8beV?=
 =?us-ascii?Q?krcB0RzxKtpnrivruoCPWZ9F+MwK+0WWngtsaXBybsRRkX+/QUiWCcmuMHoM?=
 =?us-ascii?Q?/MFhc9zgGC+Nl2T/aBAu2O0KGA3k/FFBtev+FZoy9+SpWLMBsxLk1YhFtYdu?=
 =?us-ascii?Q?oxE/M6uC+8v4rijv5demJzmN9M/wDUGOGbo1avHE3nyveu8PPycZkyfWhM81?=
 =?us-ascii?Q?82z2eIEM0mg9AnFujijeOWiWC6TxggP0ZkiOc3eGxLdLHa3ywvLjUpKyjtKi?=
 =?us-ascii?Q?DeNlNWW6j6smVx+fSzLKpBlsUwQ21+4wtN2Y2Zak6Mf6cxeFiok2LjSWeRYp?=
 =?us-ascii?Q?IB77Uob1+GQw6pRPunc4x0uyaGQo5Fh9F66b+TfzQdCpBePlRboZfFxNJ76W?=
 =?us-ascii?Q?xXsmBBeitLVN1VVLxC3KlGzXNQwrpp2qbrKzC0IDySHrGFCj4YI1/26UUQRg?=
 =?us-ascii?Q?A5gqaKLGPkqBnkYA4bcbrHkEuH5MpeksBYzrcm6vxnvRO3RmFoK+qqXZLy0b?=
 =?us-ascii?Q?+7Aj7/B3p3Va8UIYv+wPeDtgugfQgnbxP/0ap0kHzBktOetsYc3kHT6biZg0?=
 =?us-ascii?Q?lv2RIER3CLP17vlmBGxCoIDMBIHuWP3rOu+eALQxAHL2QLRl9nVl8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfOGbF69zsKNwnXOqOddhNOUJLfN+9XAjM5U4WGddusoNEdLu+oe4UQ2XThs?=
 =?us-ascii?Q?m30V2DtkmuyvlaW6aVUaQldqkdHTmEOboR1WRltH8J7P8V5E30sW8pWwqKZM?=
 =?us-ascii?Q?d+l0YQ4CQvjh6WWpUNv1Zcz8u2VZFcSPKVjOdZADbH56tFNfrUml7J+qt0hH?=
 =?us-ascii?Q?pt7Z9vDMpIfcNepWuVcVoUSdod5z9gQgbx2X6pCQhqDh62ay0XfdiURYYK0Y?=
 =?us-ascii?Q?dIdW5mQnN4rgpkiepQknc7/hzyaqnSMjYJm2u5zuNG0+byjOVTtd4HO2BiBg?=
 =?us-ascii?Q?1RrmT1QUfPHNEHhw2gVmSV2pZOHnIk3PaidBVP1l0CNg8WDfTvTj1T1YKYPm?=
 =?us-ascii?Q?0HTJ4UVz9qOHQ/89pxVT9gKegEc7fjHXSetOLomKyS7myfjamehS4UTn4W9/?=
 =?us-ascii?Q?JiHK/9N2en/TgtfdBwFQrC/dq/9EQ1tyn+i+HEXgCYFvpcP7gt20tI6JjBIS?=
 =?us-ascii?Q?VKmpvRK3ADybJO2rBveAFUzD+KQ/DFuMSlD3TaJl01XqsOrfGsuId9dRrROq?=
 =?us-ascii?Q?fyzgHRIMSzkKxpU3Vgqpcg4X3Ewah3sDFOWUjR8+geF6lCjQBgHlT1OWDGr8?=
 =?us-ascii?Q?CBDhTymZcZ+If8hj6+k7HMaJF19K5zGWbAg/UgOBBxMg6gUw7EKlWUJWbyfc?=
 =?us-ascii?Q?MRMOy0xgaCAbFMK6ImXUju/Yq2f0+lDvgtBHGXj7hSQtx0Ep6EWhTO5IVVkh?=
 =?us-ascii?Q?AdQtR2UgW8oT+cWmFAj6ykx5CWIWdjXNButqnTYMHSulVewkHd6xvi9i+tKm?=
 =?us-ascii?Q?DlWDIwe2TjpsRxKISZ90dU70i1FvYSNoCehNc7ab8JChdXCTVD6hDV0gkAdq?=
 =?us-ascii?Q?0XZtlzL9l4ynDOMcdHDVFc8qw5sO8gZwYaf0ea5NvxBGEiOKhLVYpFfdbcPt?=
 =?us-ascii?Q?q/phayXBREKj2hRWTT8zzysqAZq5BRqxVkOk6S/3Em6tSyjz5+75zLG3T+ga?=
 =?us-ascii?Q?HKRECJgeshXBvu/v4DKz7hnAqz42m3tBRnBdCB2IV1WHCwSUUs24Re8wikr/?=
 =?us-ascii?Q?r25C5gl1M072dFnvxZSRr+o4BH1Mu57bS3diJaFANqX0UfG+sIjrIabCgfFf?=
 =?us-ascii?Q?A25bEdHa1cXNxusiYsGfmeMzR9kvaPWFKtGdxt69+5/ntaOMaZS1SIKk/o/u?=
 =?us-ascii?Q?VC12wvISClyObo4H/JdYkNNSKOhEMnT3eI9hTdyqPkD8VeAYxCNbJ28jgw53?=
 =?us-ascii?Q?gO7gy01HRiYDHm0QyKBf+zV59PQftAQJhXjTqwJyxT8rtQ+lCjPM1gnnG1ll?=
 =?us-ascii?Q?cZHxebKt+mFX+6UT4t1eLi+wun9pYAjRnEuhyZ1zuZ228AhmTVnEbifnO45n?=
 =?us-ascii?Q?Vz/gT2QtT67xVCFxmHL5jFpYZ0JNorcHxOtuDw4wRk6O9/Yve3sqxUZCYme3?=
 =?us-ascii?Q?o0D+tPM8bA2AWIBxrcEBi1E6dLaedsmTNEKJeQnRFYqnnhQh/kp2luB1+Ut+?=
 =?us-ascii?Q?wRQfEbrllHtBwl85kU/z9iCuyaCEPr9FdEbx6SU0nF3SfLbyHz9W0l8heMkl?=
 =?us-ascii?Q?hml9u29qUL6ZEfTuXPF6GYYtoa9Dt6v7h5XJkE6dI5KybcQqeftJeCYwUrIK?=
 =?us-ascii?Q?kg1QbU4NS/lFPDf508298YBVRx2zp2Sv8BnijM+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad561d75-e8d0-4524-1e1a-08ddd775516c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:23.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlxYiVZ89PQwjONGL14Uc9wScBVeI6mm7XRvJuNnx8X2pK1p2yn1TlZiSiHBDZN9frSedYDoWiXKlhOFTpjkcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e2d51f4306b3..3c478a1b2890 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3381,6 +3381,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.34.1


