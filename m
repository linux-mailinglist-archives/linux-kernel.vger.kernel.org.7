Return-Path: <linux-kernel+bounces-774996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601CB2BA16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F085679AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3C8257431;
	Tue, 19 Aug 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HnWNbU8N"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013050.outbound.protection.outlook.com [40.107.44.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D923D298
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586952; cv=fail; b=UZSkmYFp+O4DrD9c0cQcMh0YZjaTRaZxwZQ1tDeZ28B8GTJRK7Uq8DyFPLLVugouvPPSpiW9YZ3H4TbxpXmC3LQsFGbfKeTHwM22bJoAwuUI7dJKp3H9XA33Hk2S0ODlcturX1LbcRq4VKUM/72Oc2z9UQ97Qo+BAmf9sN8h8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586952; c=relaxed/simple;
	bh=+FHpT9WXf4AS2GQS1Cq6Y8pDYsMeyfVzpEGKfNp3ZXI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s+m5dt0IxFcgK07PPYUrZuGt4Zy/Ihm+dNI1wiiHY0zfhtfyCp0LXOSRMchtlQ3VniAM3ZvGJujcDEmY2V8OCkB3GJUT7KArgDez2gfYgKDceqqmqdrMQ1chFA0TPANys7x7z+26pOC+otFxP7Va7wZdPgWYFeQypVFYdhT7yTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HnWNbU8N; arc=fail smtp.client-ip=40.107.44.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC6basXWzZDp1xcAISdUVFOk+Y7ddVU8TISS778GX8nckNff0UMb6qMNjQ/BfPSM95zfGYt4dvzZ+2wBNcwAooOZ22woW/bXStz3RY3jbk++vH/8Z45bkZyo2/DR2NRxGhlYavHdiWpjDJtjZ1Fy3d+5SaO72h6mMCPG1eEiczl4bPV0u0xV3H8z+RDx0irgYfFMvQSWNtomQGHPa1g7Xp+7ZVUJBDG/lxLQzCDCq5omRWETl7O5WGonVYXNgEnRQp1SiLEhvMdHWNOcYoNgIn8qtKvZ8ap97loXFsbQTWdy2WTk+aRh38tOKFy3RnRNCwxQW2MqdrwI+VuTNp2nKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4lGp+aHzcSRDjH5z3oHVD9cwAcurxVvXxvC9tIQm3M=;
 b=qYHGSIVK1dKcCXaNYrePuzEWDC28ATt4Oe644WUTIJQm7pMX0p87VVNs83g/+SYmqEoscWxKgHBOv3i9sFTcaDgmQPGvD289k3V34ru3jRcwvjSd26TsoN7vJhktyDcRASYM58Y5SBDASyv7doSGlu6r6/vV9rld3EFwfpFm4b8JwW4ayWLPR0OTY/A0451fOws1cejL63cVXNDRjmiMkxtZt6ij/zUO154GaTnGDCs+jqJzSjkDzWydvB9bBo4wv/TzkKKkaOHAJTAsxoOsiWY5ZZ7+STztto8/e6d1O15MERRxYQ3T+zo7PrSwea66Dyfd1GqtNdTVwRAZxoi7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4lGp+aHzcSRDjH5z3oHVD9cwAcurxVvXxvC9tIQm3M=;
 b=HnWNbU8NrI4FUqYb7plifJnsQEzWpAMlGc6uECWWByQBtv6pSfTE7YXYY0Gc3nLfF20IwS5xO2Cf/qa7N8pFvvLmKvIEyMmEXaDiNMZZ2cbgbdDgimZKUk5iAzLVpT8Qu4vrOn9lrSUsI1HMFgh9IEqvmlL8NvJNaOsQ1JibGlQybbGHE8t6BcKUY1ehXRVm+Aiwj8xmxSVXRmO3qGunCd8qBUk58B+cw+1pScem6FB+uNil7POV5s8CpBvKe3ajIupB0Awgo8THdVza3DtVHfccuG0balfdP2GUFFq2GFTMYCe9WTiILhm+QB2EuQhc6wpHLN4jGC7h+/Hn3l2eXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6094.apcprd06.prod.outlook.com (2603:1096:400:33c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Tue, 19 Aug
 2025 07:02:24 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 07:02:24 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] timers/migration: drop redundant conversion to bool
Date: Tue, 19 Aug 2025 15:02:14 +0800
Message-Id: <20250819070214.485381-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2d0bae-7480-41c4-4488-08dddeee5956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VlZNoR9L+0kfeHc+WgdK60silZj1vRdI2LiEMm17NvS+PqK6rrb9D1ezucKJ?=
 =?us-ascii?Q?iEWPB1REmk+l6SwVijHP5CV/zrDlUP3FXrOQgCRfaKA/zjEtUqPCtrFqd9uf?=
 =?us-ascii?Q?m7Al/YnuqVCvkATKt0CR1c8EfP05rHH5tYBTEV5rTdX3KsEZm5O27oi46A2H?=
 =?us-ascii?Q?0d/kEqDcpsLfFf5/A77UAfdruoamHU8UCytcns45O98nF9ymlOyA/COiHQxx?=
 =?us-ascii?Q?7ahSWZfRVxxuxSvQC2N/HqDPAAYH4VGh5eyEQRECULKQ3FtsvZRaa1d1I9Dk?=
 =?us-ascii?Q?gkIF6KmbmCtls7O4gMaGVamJuuB8LwNZy53Cc59QDSBly8qyxGqvvkJJAkPw?=
 =?us-ascii?Q?TDLXps4ixoewGYtlicJPMqLHL6cW9KnUKSsQbsd3hVh2Xj8dvBZewE5DeaMK?=
 =?us-ascii?Q?4Ip8heX2/A+Mmn1bhpCBqfDwFWCdUICN9w01/Mou7Q2MK039Yz65kebx46fU?=
 =?us-ascii?Q?Vxl9A6ksmx38ywthaBGbvi3zrMh1HjP60BFxDBsIW3NzEz1dSk7BjVl3MRLW?=
 =?us-ascii?Q?STRY8y/Y8EwrxZ+Zn3KYzOmJV4FTVktxruqzDuTXw575WLF3PEN/BZFsap8I?=
 =?us-ascii?Q?zCRKH3boxXHV9kt3kPFyNMYbX1MYNcLwA1Kj4BCKymKyQ5e/BLI3eVo2WexA?=
 =?us-ascii?Q?0soETbuGnPKu8Pks2fMQBmwMeeHH2YyHW4tpM2jiNAdd2DaO+0NVN2tpRSVO?=
 =?us-ascii?Q?OUJKozGO6D20QDhACiEpTCEQKzpmI+Wxa8J/8DXDMD6L3JGEZRdUrSdpGEuQ?=
 =?us-ascii?Q?cuZClbKHpoZodpaGtYbv23LZWy2JsARl7xb5Hr1fe2FtSsQeFMDozh6wlYyB?=
 =?us-ascii?Q?WgxUwonv3Yf22OTo3OV9CNLp7wTQeBYi6p3BaJMMVwJshzJ186hSDXIfuQ3W?=
 =?us-ascii?Q?BDdtWBueeUoPREgjajriRHaWNqTX+b0ZkfKptsdnyDtDNgiKjuuOUzHYYLlX?=
 =?us-ascii?Q?ce472oUEkovW7XhBC1+wF5542ynVV53B4GIL41LQ/aVFrJk3UJAL/TngKsJ6?=
 =?us-ascii?Q?2sH1Nmzu1qNLO5i30WBkoCK0wTWIRx8gl7XMDRwjs/zUYKzieSpFaarI0gWO?=
 =?us-ascii?Q?6tfCtlmBXF4iL4KfCl39+Be6szWPZoRslWyg/VCU3ez0hilmwctTpUAcyFbh?=
 =?us-ascii?Q?V0MXjN37nW41DiljdgyE9ygGHYWbo2nc/3rbtkx7Sl9FdY7NEtAv0OQ4Gecz?=
 =?us-ascii?Q?5aJRja+dTFe67gzt9Iryxoi/HJmL4owwfdrYlqSok7S7OPVr3KEkG+Y/sHnO?=
 =?us-ascii?Q?5kn8NAB+P/FbbTr1QH/qpNV1qwImKaATRADbTX93+xNYhgSvYPcvuyCAW1DG?=
 =?us-ascii?Q?dAEeijWt/fTxiY0MUSan5nHQRJIOQih8fnjco9sj+KHCA+zRXkq5qlSvwGOl?=
 =?us-ascii?Q?0m6Otk3zGw81KWQaC8JNXe8H5I0zANAU86/YON7Lk9uEjvTosI4qqtS/FOYg?=
 =?us-ascii?Q?MpBEoMbxvYStZSK/vSoAoJJ5xpe3KwKsv3cxt8dv5xFndtPFEMH4TA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GnDQ9MjowS12S22ls8o20f8y0UYWQ3ta7wB5U/12JxKD4fhvD/Gg968WCpR?=
 =?us-ascii?Q?wORGHBuKLdcedJOafpqa1oHeADvG8fdzZ12nIO5YFNau0p9TRU8G/EbWYE5N?=
 =?us-ascii?Q?pFsNax52GB77ZTWRoqeSB0039i0W72q9DIMzD2RcJa8yF2IYOX+YFLCMzZlA?=
 =?us-ascii?Q?2dl6ADOSbT1pdITB2SLVwr+4vskRlTHOQDoMuqNpozzjKzmqbGZ3/otQmuAb?=
 =?us-ascii?Q?kRzhg4LBUzOXu5nG6dV+nNbrtfh5hjiUuucZyCoVb5/PiKyOf9EXb2WcG0Bg?=
 =?us-ascii?Q?61DANceSOLdseB8SQ63fPs3xuO72/OYa3DsZhwmZ2SV0tYoLnTERiGmYcR9f?=
 =?us-ascii?Q?jU+KAdlu7ThXjBxIup1GV3fskHA2gaEGBfX+HBAMS0ARU0EbP6Gg0i9OtumL?=
 =?us-ascii?Q?Al+V7ABYRodMP3CKo1Hk50PNDwnsqda6rEg++I94Gft+ZKdGIyozRxnkICYn?=
 =?us-ascii?Q?9rjHv3zWg39f2hOk+KyJC99C8u+wri+sCq5HSX70+gawDrjAfF0iCz9DkcJK?=
 =?us-ascii?Q?cO7vdKEpKY/CV0myORVqxNSWTQyH9otwpWPyqg5I2FgQauUccjnt5HREdT7j?=
 =?us-ascii?Q?iclonFDsKt+g3yfyC2PRj3AhkYpgEFXucfqt/5osOfiIqrwruv9rVwhtig1c?=
 =?us-ascii?Q?dRISSPitKFrK8DWCegODXT9+X1Xxj2eCyIZtOzQFWByFRBUSkm/HoeHScEwq?=
 =?us-ascii?Q?bJAp+fjJv/kpRV0TS9OdyxxF5sPVRIuhrbBWFMeWRy2C2KKRVYeROAGsIAYZ?=
 =?us-ascii?Q?+fDxm44zEvLPlwLvexgxD33ZumjuGNrttG/r8vI7fhTdY59c3NKbUalrqcDy?=
 =?us-ascii?Q?tR4Pr/Bf8UheMGgA0F5fpABLN5k/qU0GYYFYJbMWpE3hRns31Nt3rhYHSA2m?=
 =?us-ascii?Q?/eSyEyA7oOB5Bmhw56BS1nHXTGA0AuN+u2HMeUAz0XOQFHKKHDQh/dqnwXz9?=
 =?us-ascii?Q?eBlNPSeyR1ptRxjS3bdidDIyZkAupv6MiQVf7Hb0aLnq4fSz6RWzZbMKu8aD?=
 =?us-ascii?Q?yhELiChqZU03LkUGkPloKTKkHrXeva+47MJNXD2iWZB2731rvKnFQEpOf3cA?=
 =?us-ascii?Q?uaYnMEEyqqZq5bupmIoeIzOqVkXBlCGqv8SIwddwJWQjpdyIvDuFoM0+qSgP?=
 =?us-ascii?Q?6/yW0wFlxVR5UjFI24gVIwhtV9X8cClzNF3ZPDWyuUfV27wEUyVZ/4irdd/l?=
 =?us-ascii?Q?P15Cc6vCgmkLzWPkH2Dm0Q1HNpmg2mgh64BYbQn2oOFUoZNEnUPaz34xm5Vi?=
 =?us-ascii?Q?3weuT8PSbl9FpMzVMKonAJoeHW1HdavWX+gYjxPahdHYMN0Iyzur8ElN5a0i?=
 =?us-ascii?Q?+kscxzXxTUoRWfQu70XaQyUs3MZc4Ewx42yWbX+pTSC4aaBdouqzqLTDzmao?=
 =?us-ascii?Q?V94zIRa8HeUPMSzflpvNwAM5cX5aDBo1OI7htfl/r9j0FWPNbhif3+d7Yl5M?=
 =?us-ascii?Q?BTPrVYn9cz9S2VIIDDN343EBGGN1D3qoWOhmZ1Q6PHl/B5jp2J4qKeED4xSl?=
 =?us-ascii?Q?wQ3232wsxSG/1Pj6Cuzu+Ghmbq8pPjZ6hEpMDsCv4Bv8Wn35OUsR9joIktgp?=
 =?us-ascii?Q?ir3iJrNWlyA/zXyFLyHrLE+BJ4WTGZD3wyDYkSLC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2d0bae-7480-41c4-4488-08dddeee5956
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:02:24.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O14Yb826dH3Y4SebA04U+I8gHLTB8rnm3GepvCPzhPydZjSp/Z5l2UZkfYVp1SYqzF4N4mWx13yMNtELMtMISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6094

The result of integer comparison already evaluates to bool. No need for
explicit conversion.

No functional impact.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..b869b244025f 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,7 +751,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		 * be scheduled. If the activate wins, the event is properly
 		 * ignored.
 		 */
-		ignore = (nextexp == KTIME_MAX) ? true : false;
+		ignore = (nextexp == KTIME_MAX);
 		WRITE_ONCE(evt->ignore, ignore);
 	} else {
 		nextexp = data->nextexp;
-- 
2.34.1


