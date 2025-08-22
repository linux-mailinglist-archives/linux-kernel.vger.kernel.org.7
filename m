Return-Path: <linux-kernel+bounces-781127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE88AB30DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C41CE377A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BE528C2CE;
	Fri, 22 Aug 2025 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S2n/yloj"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50A288C22
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838672; cv=fail; b=UKrCHK24Z1rSFqCrqXr65JfattX1gn66IG/ZY1SY/yktW0aSBOJ5Umz+vYq9jkVNNkAvl1/dHHa8H/X1l1l5KxvnvtOgk2B7U7g1qFjpd84xe6yuxsLviHeBLjuwMq0EU/OJ7sLaKSvLANXgERz7ox+GnJK0oHr8WIedygGf/yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838672; c=relaxed/simple;
	bh=6wAhpmZxJZd7KjOZp6h5z+FXd8rKiJCyYIBA4Vqk4Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqVO4pQp+ifxTIWkQSSuAdtPApx+u2Oz1hlcS86vaqkrGgBZzT3oUJE++wpq1CR7TwBAgrK7LdS5BhY8/0iOTn/xYY8fBWE3LkoN9PnxcCq/xqMKd6nQx82awurKcgdh27FE1Zu9okKim6DgM+s8o0iNwNMotdHRk6ubmziRfgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S2n/yloj; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p29UBcYRpOehwdK1nXLy4qZGXsd4yH6t+2EvouS1jZ4VTx42EE+64ygDpR6aLfjkZnKxss1Dc32cw8koXHG+KdgUzo5QUut55C0KKJVxifTmgFhFQZt8QxNGsSasVeSTWybJbidrxRJTpQnaMICwJZt9c5BmkEI/rnU6hEte5XR5u2pVot2Uq6lpI/C+NI+WhpgrbGMb691Tv7btcEker9+hKpntP2fBeC2Fpy78KIxYvJvZwbyUhzCWtiqLOhEAIHxRo7xvVLtFXVxptnCrG0621suyGyuW4AqYpqQH6C1C4hWkTXd5+0rfC1CWs/vhzUw/k9fXyeMua25NzAsigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxvNl4o9iPjTrIbuxab8nu9TULq2c4h8SRbyqOreRhM=;
 b=PkO716FYhjQ6HGGjfWdnpCY6BKmBi6fuAyIDOBuE+fZTJm62tgShTdGEES/oWfpWrWP/K+Do5jYH7H4NTKA8OG29mnWfgyV2K6hUMjEmGj+9GZ+nrO9nFuGT90CU94eLmRE8UrjVRpmDAX/tFouj+quHbj/UCRfySJUeLkst8s2QXgFw/i4UaNvdJaY+2zvQqTD8oPv3pGNItmtx0ZBOzB62dCOEk1eXemg2evY+BElyZWVOhrWdORamkIN9QrZaKuUWy+GmJwE/PzsHkfMZHN9+aidkSvNrhWoA1QwMARnFOBpuOuFlTHP8oIqoSFzvESnuYGA8EozjaeybJ1Jc+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxvNl4o9iPjTrIbuxab8nu9TULq2c4h8SRbyqOreRhM=;
 b=S2n/ylojduI+hLZ/9LNB/3ha20RMnWFs6LtPU0D0F1C2Dc0CQbCvc+wT/QWglTonZN8lsU+61Jfg8RxL0EKd6/5km0eEYY8Xhk0gl0sv/Ph2Z03D/YSk7GDR4BuaDTZdMZ7M4eRh0JnIUAMQhB/P4y3of+3HfeeUzaze0Q6tyfo=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 04:57:44 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::aa) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 04:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 04:57:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 23:57:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 21:57:42 -0700
Received: from xhdharinit40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 23:57:40 -0500
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 2/3] mailbox: zynqmp-ipi: Fix out-of-bounds access in mailbox cleanup loop
Date: Fri, 22 Aug 2025 10:27:31 +0530
Message-ID: <20250822045732.1068103-3-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822045732.1068103-1-harini.t@amd.com>
References: <20250822045732.1068103-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 151183e5-5c87-4940-a919-08dde1386e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wbP8PywmCYKzHt6tSHeUB0BswYKnHpZZIG7ZI6U/n5iBK+xWClBB07mha8zG?=
 =?us-ascii?Q?udVnr+9N7XP4FVnZc+lMawfF5yLEAULQQAq0xTi1r0q+gGFqv4dvXNEAMBN2?=
 =?us-ascii?Q?k1FXNNjqif+LgXNQddZw60B4G0i+SmR1GIMk1idultY33H8WW5kqKLIbbyoG?=
 =?us-ascii?Q?qAKQrgtVyhjiLNVWEO80J1HVfr1G+nZ8VCdXur4wUvyZcarwEuYcDCkCGofm?=
 =?us-ascii?Q?d2eR5kM8v07GSh+pvJuhe3qGa0fSoLEqzSzqOM7DqjOKBGqcvN0CsvtqgoVe?=
 =?us-ascii?Q?OFJ4ifNGa+GVrXxuOU8VgrIx9qI5kiiC2vI4fzE1T7X0fxEiyGAZqneA/bEd?=
 =?us-ascii?Q?tOc4S0B0NFSf4VAQzhfAcuSqvH4N6w3sbmkwWcO7zqv/SkK9q5NnRo1Ig8Xv?=
 =?us-ascii?Q?d+i0A36H1+I1YEhdYH/DAaGpu0p7bORKVUAnSZHCBkk1CCe+mVhhl25fTzd0?=
 =?us-ascii?Q?dnGV42zuz3901514ZUEiuTU2Ziu/hEh+jBvaullDBrvwozWJOFyM3p8+MKBN?=
 =?us-ascii?Q?M0pIRa7PwdVYlm5busuxoJ8XRB4H/7NV20pxE4Z30zR0+Q6d2DVpqz6g51D6?=
 =?us-ascii?Q?lGnyEAHSd+xC8bdgUkjHmBEfmPVqhBONNkbxOmMZ9sO8++phUKsdq1l38by+?=
 =?us-ascii?Q?SodACghwg+VzpSkMbAwNYaokTlqlq/WenuQygN0qaeRiBnPMax6W8vUpW2+C?=
 =?us-ascii?Q?Y1fQNnEQ1fyA3CGwi3idCjF0UwZvFLeZEq1k8cygxCUHI4rS2n6RaE3K3E5M?=
 =?us-ascii?Q?QW0+l4Jpa67UOGiP//b18q34kCK73/gKEsw1NBGAGF7qVqaHCwByHlMcNGKI?=
 =?us-ascii?Q?3VFWTpGy98w4YkGin3HcBi2TIV6Mw+0sXAQCHLQlTQyptgiRv+w0tolrMA8y?=
 =?us-ascii?Q?8yW8en0tLl6ts+WzYHxdbEWMI62v7X3jq0Fyo7H8ivWgd+c0+CiEFVcFKETR?=
 =?us-ascii?Q?F445M4fHUZMu7DkVIpFUYEgIc6shV5rmQ2LaS5k45+8xy/UPEMoIGH5xLD/h?=
 =?us-ascii?Q?7balGR3vavySP1+qns9isU+KTzkM/PExyCHX258nTpbX/eydjRxxEj52+ww7?=
 =?us-ascii?Q?+0lM/b9EwvoOwglr396W98WQXFuVBv61WGZDtdO0oujeMfqpDGaHt1CSM/rm?=
 =?us-ascii?Q?0NcK6H4mHMh2qjpGHuPDyjr9MewE6y1D7ToPjw4SMXPsCe+Ypb9BkiWxeqzC?=
 =?us-ascii?Q?monTPC6K+Qv7ZF8vytxtXjuvHDqeSaEoDKUc5mhMlw5Whxvg35DiAjUxP21s?=
 =?us-ascii?Q?T8h1cFFUTnpfuWmT8jixpsWvwoADTwJXIPQleI2jizB7VhwhJ6BfK2ZPg5YR?=
 =?us-ascii?Q?//Il2tsIeyerX110TdMVN2HrYk+7TUedkuYLtlJBhlnPbrQjvhPAgf0HqMNa?=
 =?us-ascii?Q?VwO2bEic/bHZpdRp1Uepz9ejrmRmMpIMvyGscdcVT5yXSHIXd2zWrI05jQLb?=
 =?us-ascii?Q?APTDGmX+EdJtxbUvIWN8Gs68Yf7RswTZ/b1n2pOCPnN3LkW7lAmQHaAHNDva?=
 =?us-ascii?Q?YQqtL4+AuPyHEoqEu4Bh5fH8YhSYy4iV2sUH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:57:44.3835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151183e5-5c87-4940-a919-08dde1386e9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073

Fix mailbox cleanup loop that accesses array out-of-bounds by starting
at num_boxes instead of numb_boxes-1 for 0-indexed arrays.

Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index bdcc6937ee30..3b806d1f89bb 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -891,7 +891,7 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 		xlnx_mbox_cleanup_sgi(pdata);
 
 	i = pdata->num_mboxes;
-	for (; i >= 0; i--) {
+	for (i--; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
 		if (device_is_registered(&ipi_mbox->dev))
 			device_unregister(&ipi_mbox->dev);
-- 
2.43.0


