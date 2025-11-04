Return-Path: <linux-kernel+bounces-884259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B03C2FC19
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C708218986F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120F21D3F2;
	Tue,  4 Nov 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="q8Qxzw3B"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60A1F5435
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243392; cv=fail; b=TUuuUh2BFhInk3vX/kDA7QzhF1YxuOrBCZlGgzQ1EtzVKeTgph6YnkI2aMAgsfNF20bM/RQuehfjg2jphdzs2Y9mG8aANF93J8KLaN5jn9ZQ1pz6ZR4B7zzjiVm6lJzZ78oqgm40WnK0yPHrWvpMQr3tggGMtcAIeeTiGQIvIow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243392; c=relaxed/simple;
	bh=7PfNiWaXPNpNHTkXZZW8s8M+BEhT2jn5Eb6o0YffJaU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kI9uEmjwdnaLZOO/zWUTvRJto7j8flBLF1Td1G9PCy3mXRELMGexXuZYTHdIQLcsJ0/mUVeRPfLrhrI+ZbssSvgCx9Hz0Y9ZEm0NSLM7XGl7nNkWDFvVm2AbeVny3xhS+O9gxY60EaV6941yQRH2DMD2fvnd4aY/XM9cGoldurQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=q8Qxzw3B; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o625LziINvh0U8s0+Tv5eKShyGp9AcV72fwVNFYpF7/H925jxsprj6TL2vJIQM5diXtcaMLRzyID3Q3/QEMthWYEO6XemyY2rJ9Zo6dRK1BNZdzZxrra5oMOrDKrDJhE0JbGPQn/9gvDy79GYzBQpZIyQNx2oER71qFGmc/OVYLN1TnteBWaT9fNmzNiilsKiCIsKkBjnIgMUaojujgHQH51V9PGrmEOUzoJmTkwrDbXvOgEneGbNnDTMG51RacJpecVbDBI8RbuVo4Rj4r8aZPLYCdt2c7m6vmfSQiIo1Q2I9i+qLDp/wl5Kp1UxVHSUHQfaJbIyD/v8IfSgNAQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gklftrNAQ5v7BIUGnp8SrBgayowrhJyU3RzL+zpx9Y=;
 b=h4YpwZf6ShjLLhWvrEzAL4mdDi4xCl/107PG6W1uTSqCdEhRR+9lyXMQ6raEX7jSvrhPvTClNzt7YudtzuxVSO6dEoqWXTAdtpyW+OejJlh/g0WOzvMovz0OMJK2yEAS3JHRZCNGHFz+MPef7Mg2ZHxYKoBpHanS/rE1ubggO3f8lgOgaVWB0kdDRC0yiStNFDJRdxWPIOkHwrTX8zLEAsRn1K8SL0fbzar3s/0eH7yyJ3vYO6FN364EdGbJyVUsAs2XYKyHXqgeCdRIjAPYvp+fwb0+5b6JiJW0Yl2hyeOdXr5AgdT8p/szF9IL7a1+DqUqcrXskhuZg0w9ZzWXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gklftrNAQ5v7BIUGnp8SrBgayowrhJyU3RzL+zpx9Y=;
 b=q8Qxzw3BfucsZuk+gprLRQ/Ic/+ui89DCWeNntMQojd9n0JYeXxpI1sGuHQVOjMEIkb3HbpPDXIgnsnxminPBPWvRII6FTFH7GM+5XyNp/ZoX0dr6zEH3MoGlBzzCS0KfNR7UPdQZv3Ow0lXvVx1wVTFGlYy3dUqwJlRkfaH6pODf/hfSUoiSdiqvQW1LZZyD8aY1bD+zeWClGfHWMkawVr1iMAMVjL1vWk0HEjdw7ghixdJvXNmyRsrnm0VYPF+//sR9hVVDcRJ80cSUQXtrKu+/ThhYF+q6XdPXVS5G1fmYb7j7tjQGb6Q/fB/qxwbhxB7TKJObxphHh7cobr/uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB5549.namprd03.prod.outlook.com (2603:10b6:a03:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 08:03:03 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9253.013; Tue, 4 Nov 2025
 08:03:03 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/1] firmware: stratix10-svc: Add support to query Arm Trusted Firmware (ATF) version
Date: Tue,  4 Nov 2025 16:02:59 +0800
Message-ID: <6e3c2d1c5afd44a8065d9b472affa3695bd0eab3.1762219162.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1762219162.git.khairul.anuar.romli@altera.com>
References: <cover.1762219162.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ0PR03MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: bb201f1a-b79b-467d-b51c-08de1b78946b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIPT1HC9eYoKbqDqzlY6OCW7aprk0a0gPAWmEZ78wbYjayKTH3oyOgVnE9Pj?=
 =?us-ascii?Q?wvwTQJ6C7rGj4gmicOjzkYtJGNoVpfG1zIOdw5BRbE2T3+AGuwL3xhkPCuOO?=
 =?us-ascii?Q?mYGEUSOt/M4Le5CpEcPiILakHpFFbqL7u1YZ6XxJCHGO5fRR9XcV+s8N1ell?=
 =?us-ascii?Q?Xp6I6l/mdPhU6l9MUghujMPjc9dMe7AuIrMffWVdpwFLaDoUZKLGos+m1Ezq?=
 =?us-ascii?Q?vO1+GcluvbPtJ8IWRWDaRH9Kdz0eFmV2FVmG/4lZ4J/wVaZbbYk002WqJsK0?=
 =?us-ascii?Q?OrNy9mdJYBGWW4VEjugSMPLBmb5uppxN32tEOlu2/ccRtAs6FWEC+ubHTQGx?=
 =?us-ascii?Q?AFfAgFlmmwprojGsX9z49iky+8onxK0to+XAVixMcNmsXPuRXvwgNi7oVqb8?=
 =?us-ascii?Q?YRI5zgafheUEeJLCRe8YX5scrhoWzS5oBWvEq7/rJtBJZhotf2R1QUfXWISn?=
 =?us-ascii?Q?9vQsd4izW/D9REY3zIclQn0mwbMjg/csKpm5GmLdCmKR11A3aTG57X9KenH0?=
 =?us-ascii?Q?ntzlAPWtBMQEa0PORiZbY1gMwELYvPPN70Wre6vQhIjP/XlXud1bVmg19SZZ?=
 =?us-ascii?Q?nz+5SbGOCCkC5M/yB5tmk1Oc0eRLNNlxzmyVm0kOCj1VnbTLe2xMWBmeV4X4?=
 =?us-ascii?Q?HAup+XHuVlvEApQbWb4X8PZUBJ1v3/HCl2hTZOBQTwvSCPeaqSLKU0r0YPR9?=
 =?us-ascii?Q?H6j3pma3asUBxmR+Z7rEpZD6aSvxYibm5cLQlbu1jy16mWQQmoaM3tkQu7Tp?=
 =?us-ascii?Q?SRESR/nXQ4ARNRtPexKWmU3TRWvg5eVDcnEg6eYlUoOmAr+ED9yUmRLR1wm8?=
 =?us-ascii?Q?0DRI6X/x48+Pb+6GlkZa8rd9kFcEPY7o2pSJvvPiDCd/De98zUN93aQuMb7V?=
 =?us-ascii?Q?NNrXBm+CDPNlQFe5NaPObkYf//BM5BlGS5zZFD1Shrqwxs1q6Yt3X7yPxoM/?=
 =?us-ascii?Q?JJM5JfZwvAHXmmn+f82lXGAWsdLXh7WBO6EX/ayjemSiYaGKn9CpDMZvA9h/?=
 =?us-ascii?Q?6zVMC7hh77BG//ChxZ1VW514t9uaQRPsW0IP1uS1dALLxdnOLb+qcUMUPodH?=
 =?us-ascii?Q?0aOpPW+nhSscJD26lX8p7Re81h8bva+APfbcKWdm9sv0X3bU22A+1N5z17o9?=
 =?us-ascii?Q?NQMIFqWvfM8VRGjklb/WWUVJeBEYNejajQvS/WEywx6gdpQUu86tiwsEulPw?=
 =?us-ascii?Q?DmGm71litC6I6SriNPgL+riKvmiQ8r7nBgiNOM+IgWSPHV7jiHQKMoYoUvfl?=
 =?us-ascii?Q?iNof0ER67kfQrs1vJ7XPj9s0wq1owgeeENYYSMa1Id9V0q2r3BeGtJZrpgRd?=
 =?us-ascii?Q?+U3RePTSETPig2LomMjaJe6mZJF627gXrJrkVlJ/Crj99pUDrhxSlNMLot7q?=
 =?us-ascii?Q?MPl/RneQYMVDNJ/vaBERHSsExPVU1gci8P5LvPeh8m6ERdK5D+7E9GGrqAbR?=
 =?us-ascii?Q?zLw2LmC8xK/X/S/WPm23CHWCyCTcTJJq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JVZTBDM/vEW4jnrHcmeFotvbs7ED2LM4loTg7x/gbFhJmbrVHbp+DxaZiERa?=
 =?us-ascii?Q?+qURRv0EnNqJks49ujLxM7A42FIHpBtxNSrG46XfgodzJwv/jU64D1qzbAUe?=
 =?us-ascii?Q?QBS/issYaMRP1frtiWjloEU8MwQf868Y3/3AJpotaxTsmd0+wH151c/H3tvg?=
 =?us-ascii?Q?vhzrgZsS+hePsPZ3lGHYfkKvX7JytilVBrUg0rMh3dQJFcYds8hrmvTt4hL8?=
 =?us-ascii?Q?IYkS4lOpKpxHQnoylfmkEzabpv/9H7TDBbWrElw8/eyMyPgNXzcfT4oIy8Zn?=
 =?us-ascii?Q?Vg5auFQqMsjwo5C1dHDTWNPFvNdieRWdBawr8m9UspGXWGth3757AYGOKbTl?=
 =?us-ascii?Q?CvHirCM9qmNz/wRlIlLdvM2IpAbfZA7Guvksinnv0mPka+QnAUSeSahs0fRr?=
 =?us-ascii?Q?mgfaCEWKnJZTflIKO/AydAc49pDDyv19D79uXIi+9l9qVqyTzP0tuOO1sSfy?=
 =?us-ascii?Q?5yE2OhXttDj/5oR2tpz1YTPRKvWoUfi6l02H0KOaxHALnNx01nF9nJzoHhPu?=
 =?us-ascii?Q?1g/koAJwMvEP8HslSIYwElw7BVKfuSFsT0EI6xGRWgaGPuj6QOWrpFb4qzoQ?=
 =?us-ascii?Q?2zvM/dFTDGT2OQUdnclKc85a0nTTUf4VaagNS8CyeiQYC+YDOoivICHrmhVg?=
 =?us-ascii?Q?cKBv4Mt3c0ntfXyhlixEEkXIIa9o1ExXVqJQf6zzxp7Avvy4GzjDqMkv+udP?=
 =?us-ascii?Q?9I06oGeKgQSNaXBF6RuxHTnIOAmr3nApjHs+xntCxKg5T6qTSfuliJnQk80o?=
 =?us-ascii?Q?P7O8w7ZbNDAxEJ4+lhMEo2JNtFGF98Q298GXorVEhtdbvG5E8TFEoRBJ9J4c?=
 =?us-ascii?Q?oqTgbzs3Eck1Np406NlnFwdEqTrweA5c4DgOEqTAoqs6OcUeW5yMm+bRcPur?=
 =?us-ascii?Q?MSC/BTs+ARUdkfmFJgTqKJ8tK6g1eYVUVwV6Jwe06+Nta7h+WAmqXVygcCnj?=
 =?us-ascii?Q?7PjfgidvvsM22tKaEfyRlZO68308Yrsgw+qyI9YTnyA4Ek29uRQFglAZgkzW?=
 =?us-ascii?Q?hIMaGlkLaPKHuH40tWhuk1U571z7DwZTukKoxOIRS7+qZCMyKQ/czRiwCfwA?=
 =?us-ascii?Q?s+SWWcuMUhgt/XnPMIwKzzISleIwM9UQcev2B4RwBHVgtMwBiVJy05H5MU8w?=
 =?us-ascii?Q?A7/xtduUnxts2M5BvViQMF79IzO0pIY/3NYu3lXLPSnAqvXkavBXebJwKjp7?=
 =?us-ascii?Q?PUuuGhAVBY1cU1+9kJQlpVlmfd0VcXtH4M7hOqiH1J6EuvdBpjLdU5CYbXmV?=
 =?us-ascii?Q?BHhmmAHSyBo0fFqkQ3IpJ9G84z1Ur46+K4XU8InYQ8HqQuAJYhAJ4uBdM5xe?=
 =?us-ascii?Q?yy29bKA02AEn/WNhbels9c3jyBqDUcYSgFoRRWqz/5o5XRp859tdFDvqZFIc?=
 =?us-ascii?Q?WJ8W0kVmpW96JRDOD9UL1mIajCfizLOUtm7KFewTvSAB9f/gbnaiIo+G9b1C?=
 =?us-ascii?Q?H7xsSKfDDbSnxTm8ix5gSfPhylGNxfOx9yNIbOvYlMRWgtnys99OXJQkiwc1?=
 =?us-ascii?Q?p1CCRYFdUkgayWHk25KBbF7H8mJZfbNHIwCTn/yECaqPkMhB5uWUWxkd8YDW?=
 =?us-ascii?Q?g7Df9jwDTQwP/7BRMNHzc87x6zcabzRfCEgqE5LQNkhrIr+70HwqFjf6ZbFY?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb201f1a-b79b-467d-b51c-08de1b78946b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:03:03.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1OnaCKTPdSM/bD/kijZQPUbMHxDXQDySinS3usHxXvb3yBblVwpdpOgW2aBKBYe9qOsn6XQySPwzSeJ6+i3X49Z2Ep0ffnCh9eX/D6mTlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5549

Add entry in Stratix10 service layer that allow client to retrieve the ATF
version at runtime, which is useful for system diagnostics, compatibility
checks, and ensuring the correct secure firmware is in use.

The change introduces:
- A new service command definition in the Stratix10 service layer to
initiate the ATF version query.
- A corresponding macro definition in the header file to expose the command
ID for use by other components.

The service layer uses a Secure Monitor Call (SMC) to communicate with the
ATF and retrieve the version string, which can then be logged or validated
by client application.

Signed-off-by: Sagar Khadgi <sagar.khadgi@intel.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 12 ++++++++++++
 include/linux/firmware/intel/stratix10-smc.h  | 19 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  7 ++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3acfa067c5dd..6ef55c75e573 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -483,6 +483,12 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->kaddr1 = &res.a1;
 		cb_data->kaddr2 = &res.a2;
 		break;
+	case COMMAND_SMC_ATF_BUILD_VER:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->kaddr2 = &res.a2;
+		cb_data->kaddr3 = &res.a3;
+		break;
 	case COMMAND_RSU_DCMF_VERSION:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
@@ -686,6 +692,12 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_SMC_ATF_BUILD_VER:
+			a0 = INTEL_SIP_SMC_ATF_BUILD_VER;
+			a1 = 0;
+			a2 = 0;
+			a3 = 0;
+			break;
 		case COMMAND_MBOX_SEND_CMD:
 			a0 = INTEL_SIP_SMC_MBOX_SEND_CMD;
 			a1 = pdata->arg[0];
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 935dba3633b5..4fd56759462c 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -514,6 +514,25 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_SVC_VERSION \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_SVC_FUNCID_VERSION)
 
+/**
+ * Request INTEL_SIP_SMC_ATF_BUILD_VER
+ *
+ * Sync call used to query the ATF Build Version
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_ATF_BUILD_VER
+ * a1-a7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Major
+ * a2 Minor
+ * a3 Patch
+ */
+#define INTEL_SIP_SMC_ATF_BUILD_VERSION 155
+#define INTEL_SIP_SMC_ATF_BUILD_VER \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_ATF_BUILD_VERSION)
+
 /**
  * SMC call protocol for FPGA Crypto Service (FCS)
  * FUNCID starts from 90
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 1bcc56d14080..0bc686874c95 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -148,6 +148,10 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
  * is SVC_STATUS_OK, SVC_STATUS_ERROR
+ *
+ * @COMMAND_SMC_ATF_BUILD_VER: Non-mailbox SMC ATF Build Version,
+ * return status is SVC_STATUS_OK
+ *
  */
 enum stratix10_svc_command_code {
 	/* for FPGA */
@@ -181,7 +185,8 @@ enum stratix10_svc_command_code {
 	COMMAND_SMC_SVC_VERSION = 200,
 	/* for HWMON */
 	COMMAND_HWMON_READTEMP,
-	COMMAND_HWMON_READVOLT
+	COMMAND_HWMON_READVOLT,
+	COMMAND_SMC_ATF_BUILD_VER
 };
 
 /**
-- 
2.43.7


