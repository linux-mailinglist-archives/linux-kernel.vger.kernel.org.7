Return-Path: <linux-kernel+bounces-847808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE64BCBC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C513BD9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D72376FD;
	Fri, 10 Oct 2025 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="oJYXMx0Q"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D684A06
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760077640; cv=fail; b=u6+tV/AQ+hIXeofSj/ktpG/vYB9zkxxX/Li3ZF4zNYubnp6PfBE8k4DYOZiZSGPx7qj+od6qiy9P/jdCheEw8E0vo9yJtrzcjSytRoFEuVzHthD4zamT7hSc4zp3mETS+zhq3jNVIxa91vrDmJhgNtEv7ijm1FEDuabE0yaFVHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760077640; c=relaxed/simple;
	bh=a83p9dET9/VwfpCMh+pWs/MThOOYCA7jIsGFsfjTBnw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVv7rf7+DVzCAKwVhgc/Jy/8KZTFJwrhtU7i1RtIZHQgEZVjBiIwa+0R2iHR3M6P3tHF5qxkm07GMi3+LaTzCnxO/Tom44F4UfgJjg6OrPafXoEZk8HFSG1u3tjbqJvz00jeGudqS+DES4iUe2VihIqt4mPXFqeH349o8Q3VF3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=oJYXMx0Q; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMcCiO/JqInyIJLB8DXpZW9f9frWc9U2FUlFJ0Dpt7FM6Zr3T7Rw4KC8QiDp4lvD50Kzn7t5xqQXFavZrxFXR8ECNXhKaFQhWafYjXcREzF7I+9EKrRLnsVW2Ok4bDVFiO/Hz0UUskfSPayn6lvvL+eaj6HPCtiEp/dJD9CP3HVcSW7ykka2kI0K8V0JVYhU0azGhBfTBF8C87agnOLk/MxCrUF7ehcTOC7x8wGqOOkAgsubzmvHes/sPwmMzKm/0S7jv2ZilqYEiEY5gfdAOvd/ymj1bRsohnxjyeQmJfSNALC/2aoEmyAbh9sHFRMlWP9Qjxl6OOtOi+0dEEWMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=gyL18qykD1YITy8q+/VTuCGpvtIhAJRtBpbPGEuC4AGonpFs9NirDImeAMuD4+NUGc3Yfwgz2PZlx3Lx0oGLEhuewQmeH19YN89aPbhCOtzn/ZYgQq4ULwJTyVGSSbgAfYmI6U+zbq1RNnXKYoVrmWZQEHCdkvbMfZgRolEAFmqPqw6EAGIeWh7yRZjBYzicjKAFzgMI3l8CTEmI5PjyAA0yKQ39gaGAfGNwVrD13CUlH4Xi68mTCZA3hqaBmF9FT/lsCcUfMmBF1a3OXRHmYVvLL2cU7Sw060hEkBbIFVlQpXVQ21omvggaENJ3AnIOL8U7pdwMfghXAbTylN19jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osVjU6/3HvPxoKbGOzab4V9/CWq3EJ0SikkkdAGPHyo=;
 b=oJYXMx0Q/OaQ/vjSLrApgucyBlRh7Zlqo9uf3KjU4xLOgIp05YZ+Ql2i9V85TqyPYrH3K2eLzXhlzVqpHhaHfWQhVw8igFONrHSSz5BZowj9ZZ9oo3GEFcMMXPXytAxamUNPFyCf8n4vUwnJarFK5r47EM8iYJ9TRe6yZ9RtFZnV6ZnePmb5+qSyP+PvwVWI1bNJ6b+WuCnaRWntGoe+nKPXNkoCp38veWBgT/TfOuSNUkXRec9xxqOG20aozpH1xpJGYKCKs5Unz3lHTeYMb90CpwzWTFy/A1fWgpuk+sWnIBmTcy7LSyQfXfG4d+tLxpYNbzLjGgzlrQG3wVX90g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6656.namprd03.prod.outlook.com (2603:10b6:510:b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 06:27:15 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 06:27:13 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	linux-kernel@vger.kernel.org (open list:INTEL STRATIX10 FIRMWARE DRIVERS),
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v4 1/1] firmware: stratix10-svc: Add definition for voltage and temperature sensor
Date: Fri, 10 Oct 2025 14:27:09 +0800
Message-Id: <5797fa3875f39c30ab5c942310abc913344335a6.1759914326.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1759914326.git.khairul.anuar.romli@altera.com>
References: <cover.1759914326.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::12) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8a978f-43cf-4550-916b-08de07c60cf4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5h24PeYU8TY59F0WE4LP2l4j1Si/uvBPGmv3+WS72Gc8Cj4InIIWqsN1AOc?=
 =?us-ascii?Q?gdkrpY0cPQUUjNtTv3UKrn2kKcM7zQHHWWEnsub60jXeoDjMmaEjQhCMlssv?=
 =?us-ascii?Q?acjmf0J4KPzbbpc+URgcDFJSNjwhdES7I8R3TVULDqA67zSzx6j3QUaPiLUp?=
 =?us-ascii?Q?ky/55uyYABZc+oiw3QfT45o7tPGIuFoxcWSWizEZ6CeXp4ab+THWxT4REPlr?=
 =?us-ascii?Q?HOtzruOOtGmuNXD1Y6DPl+wCTju2h7W9ajDxhLu+NQWP+ie4ywKf5On+aF2E?=
 =?us-ascii?Q?vGMB7R7m28Uv6o3xLQ1VM1iUr3uF7yP28+q2losHNkQBTYUkDUMI/YQ10it8?=
 =?us-ascii?Q?oycpZ3+WzsSYgmP7oJsNBw1cU2RJ/IIrlCgGHRd+5dhqXWXuEfWDPEMwxwYm?=
 =?us-ascii?Q?1VPTv6ROc8D0+LIhYrcz9HxvBumMSE1C9J6QfPyW1kmyGN48flUepRkWJjAE?=
 =?us-ascii?Q?sL4VsX9Trr5wTjVYKziBjzklHbp1aydoUXVfPicUD3s2Wbnrps2hhCd/GI3B?=
 =?us-ascii?Q?f388idowU9xqKZAUpiaTmjIWD99ghoOAMo9sp7UN0Xf5/RafyqpPvg08OJwh?=
 =?us-ascii?Q?oA6cxS/OZ2+4ajc0Lt7bjQJV0dJ1i9wYS0w8kXoXqwHSlW2HfDyE+Nd1p7Dd?=
 =?us-ascii?Q?iwJCMejNlXj/m2c9lPAr8oKTZWqF63pF19xovZ+n4u2hfp0MQIAG+YjjD5zk?=
 =?us-ascii?Q?cMruMrlARDctoMAIO+i4CC3iknTqrRTPewThacs4GqbuzvZq44rrfaSvDlpT?=
 =?us-ascii?Q?2oCUc/nukOuZdQcHWGOf4xOFI3OkhTOg/c1pg/hXKylGm3GKJljQhmJ7ywYq?=
 =?us-ascii?Q?PAf4ouLrNFT6ma+Xg9LotTp4Hpbc4X9XfGBWAMbOuQX/RnFWpMLdbLnzoFdQ?=
 =?us-ascii?Q?1LHuqR8o5ue7mv3A/RbYZXKFidWuL993ADkcdNyxREY7ZxbtrsRon5yCTquH?=
 =?us-ascii?Q?H81+i7XWOW3cagVWwZU+UNZtncmeJMoEePe+9hMbiWr7afU+rGjoKRDVHOvP?=
 =?us-ascii?Q?ytyYypVpT7Xg2QJ40//gLSRjNbUAK1pcT/8dPep+NpZ8MzabvMvAjGrmv934?=
 =?us-ascii?Q?RTkNPFAtQAazrvz2zpBEgM4fcafW6SRIcdqa7q7+ZdX97alLtog07oDckUcR?=
 =?us-ascii?Q?6Ckscxl/eSB1tUhfAsvGQz4Y5Jc7TqjKGDWsHN1SWNn5LDv6dyHBjbTw3Bbr?=
 =?us-ascii?Q?XNgVMrZXqAQ5Tg/4xmHTY+zRCMEGya/WrCXxFmoBFIPsKBf2gnmiMFzdBb6P?=
 =?us-ascii?Q?RuqgORpkQ7cRdQc+5VEHAStV8xbsxxbTjLVyAcMJwtOE1C+qjSa1u2s6zpW7?=
 =?us-ascii?Q?pkRxvRW5UA1YXV2OUoxTBT0zavsGUsDeWvfTD+bzV9CYZf5k4IXlf+hxrKlv?=
 =?us-ascii?Q?c+AzstYPHo7uXJB+FvmwzUSlgtxzM9c3UuIsJZBJrqsTuCYsEWNK47ZJne60?=
 =?us-ascii?Q?C1z44ZKU+/ohASTzrP412EK4DR0LNwQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sY7Q8SM+fxPX3pFqhUI9MtR/U969Emct3RH7Cv2hN25dL2Ly+9JZeFcWWIVk?=
 =?us-ascii?Q?pWcaDjzHI6HKJl49fIDGbLj655xpBteOICchgq/Qn2U+BQXiJdYeH0XJEY4R?=
 =?us-ascii?Q?cv1B/Xx49PeWS5gXCCThXObVK2X80D7nXIskpZ0DOSRxUsCmSysWXFlO+gSC?=
 =?us-ascii?Q?2tMBUSh70cQfOtzRnFc5arVH/XkVRI5OMnJrhr5JVE15Io+JoiYfhpN0eCg6?=
 =?us-ascii?Q?O+SqZw4sOR7GYl0Zc3sYP9Vrdo+QJXOiV28aNvGJyBuK2etjsyqeufDZ2j4e?=
 =?us-ascii?Q?w4LjBw97xBfMnnpN2PH64+npyNs34CIk9TbLIIlgSJq3jhQiIkX+1kXh2cVU?=
 =?us-ascii?Q?AyPRAfiXUHzeptS+9G/Rq0s55H4Uw+ZOPHe1tZfExe9FAjmfYdcqSk8RUSuU?=
 =?us-ascii?Q?P9b5DQdpI1VyvRsOyDpiIWBX4/Ro3rt40Nfsw5cWbH2Pjx+nzppl4CLE967G?=
 =?us-ascii?Q?pjbN09LW12gCoFgWg6ZqkZPYW+H5Z9lBgc3e5r1YLiINOF4ylx5Sgr58qU30?=
 =?us-ascii?Q?fSzsPC3dyXQ8JjYWYpyT/aAyyYe2Dav7+be3uLOI3IvCy496cieQrYkXh7ZV?=
 =?us-ascii?Q?jrfjAiVrCn4owY3V9oqCuOmf3bQldinGWCfewptbx5pkpu3xLJJLPzoJwLKX?=
 =?us-ascii?Q?HyZPyHwONSFs18o7rfVqyK87DFnTB2kjYgG2M1J1+f3ZEK6Y1W4fA3VjBP0F?=
 =?us-ascii?Q?OQGVXWnKUY5r5TraHY3yXAUeASW+MvZiBFl4kv9aRlaOHKP3yPi6XtOoJT7u?=
 =?us-ascii?Q?otNslTrJQhWyPrc0i+QMkW5IctX3zTNOrcevo+/a0AvS8NjoKsLyiN/nxCeQ?=
 =?us-ascii?Q?SPMH+7aSbBnczqo3VmwFK3hqYZIamoUQ9fiG0GdDRFrgbfRkZUWT07xN97M3?=
 =?us-ascii?Q?UaUwyloHJZzmwwCub+CSlE2Jywl0sfWDG4XWQeKyop791kyIqXtsTchr7Ez5?=
 =?us-ascii?Q?EJgXH1H77+5YPzfeZ22A6xppAmEQcz+F6kJBG3jgkv0ijON9d4wxmZHUccfV?=
 =?us-ascii?Q?0hVpqTAHf6fP2/M9/K5bd5e7ukF+ly6bcYf6sRen9IQHpOxD4szj/BxYOn0R?=
 =?us-ascii?Q?qZIuJW1dJ+7yLmfnA2bNyBiMQgvp5FC6+l0pe5yizBJGmEoKgMYHvh2fLL93?=
 =?us-ascii?Q?s48EYPS9Fu5Nahfje1ffcJHAwrj3HLKHM78V5RPAVHWSv6mKUow2QHNCL8H2?=
 =?us-ascii?Q?CByXRipO4oMIbBkic12eXQshCzrsXY2uAoRmkOjkioGAzKqEXtAB7nkNoIb5?=
 =?us-ascii?Q?d6EjQMSDzsl9dOLyf0IHMBxX1jtc0z53zJW94f1ZAdTAWY4NglAznwYqtFIa?=
 =?us-ascii?Q?svCHlm6Xs/f88mr3yKd6Yz669zO4xeubPl/izsFlaE+Z2wejUglKVjrTLqTs?=
 =?us-ascii?Q?d5ywxKSmTPOmXinGIh4mt/ykZgJ2XqYgLFU65fDmZpO9xM5nPwTnwogNXrx6?=
 =?us-ascii?Q?T+v7nzjZ7GCpN/Qul6HCVzoKkIzVwHrtjKR1gaFc1BLcspHicvBkDTi0Riz6?=
 =?us-ascii?Q?DlbwUtubunlZkeBhp8m6m/BCRnroCTzy879hp7Mxxts9cdx2dub+bYL2wKu9?=
 =?us-ascii?Q?fSoh/kzTsUEo+sDJRwyXzLS0InBrQQ8KmaWcXe6GaG/wLZJYehH1Njc1FdXD?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8a978f-43cf-4550-916b-08de07c60cf4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 06:27:13.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSkBwAqKkZk6zTSfeH+wEP41eTAfEi0SfTsuuB25TQ/Z4c/+2kxXJoJvsxKI/QQ2XajNdy46upIc3qZyU77r4F6dzxA96odLf9eXG/r+c/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6656

Add entry in Stratix 10 Service Layer to support temperature and voltage
sensor.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 drivers/firmware/stratix10-svc.c              | 21 ++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 34 +++++++++++++++++++
 .../firmware/intel/stratix10-svc-client.h     |  8 ++++-
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e3f990d888d7..5a32c1054bee 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,7 +34,7 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				3
+#define SVC_NUM_CHANNEL				4
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 #define BYTE_TO_WORD_SIZE              4
@@ -341,6 +341,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RSU_MAX_RETRY:
 	case COMMAND_RSU_DCMF_STATUS:
 	case COMMAND_FIRMWARE_VERSION:
+	case COMMAND_HWMON_READTEMP:
+	case COMMAND_HWMON_READVOLT:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
@@ -525,7 +527,17 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = (unsigned long)pdata->paddr;
 			a2 = 0;
 			break;
-
+		/* for HWMON */
+		case COMMAND_HWMON_READTEMP:
+			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_HWMON_READVOLT:
+			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		/* for polling */
 		case COMMAND_POLL_SERVICE_STATUS:
 			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
@@ -1197,6 +1209,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[2].name = SVC_CLIENT_FCS;
 	spin_lock_init(&chans[2].lock);
 
+	chans[3].scl = NULL;
+	chans[3].ctrl = controller;
+	chans[3].name = SVC_CLIENT_HWMON;
+	spin_lock_init(&chans[3].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index ee80ca4bb0d0..7306dd243b2a 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,4 +620,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_HWMON_READTEMP
+ * Sync call to request temperature
+ *
+ * Call register usage:
+ * a0 Temperature Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Temperature Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
+#define INTEL_SIP_SMC_HWMON_READTEMP \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
+
+/**
+ * Request INTEL_SIP_SMC_HWMON_READVOLT
+ * Sync call to request voltage
+ *
+ * Call register usage:
+ * a0 Voltage Channel
+ * a1-a7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 Voltage Value
+ * a2-a3 not used
+ */
+#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
+#define INTEL_SIP_SMC_HWMON_READVOLT \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
+
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 60ed82112680..520004a5f15d 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -11,12 +11,14 @@
  *
  * fpga: for FPGA configuration
  * rsu: for remote status update
+ * hwmon: for hardware monitoring (voltage and temperature)
  */
 #define SVC_CLIENT_FPGA			"fpga"
 #define SVC_CLIENT_RSU			"rsu"
 #define SVC_CLIENT_FCS			"fcs"
+#define SVC_CLIENT_HWMON		"hwmon"
 
-/*
+/**
  * Status of the sent command, in bit number
  *
  * SVC_STATUS_OK:
@@ -70,6 +72,7 @@
 #define SVC_RSU_REQUEST_TIMEOUT_MS              300
 #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
 #define SVC_COMPLETED_TIMEOUT_MS		30000
+#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
 
 struct stratix10_svc_chan;
 
@@ -171,6 +174,9 @@ enum stratix10_svc_command_code {
 	COMMAND_MBOX_SEND_CMD = 100,
 	/* Non-mailbox SMC Call */
 	COMMAND_SMC_SVC_VERSION = 200,
+	/* for HWMON */
+	COMMAND_HWMON_READTEMP,
+	COMMAND_HWMON_READVOLT
 };
 
 /**
-- 
2.35.3


