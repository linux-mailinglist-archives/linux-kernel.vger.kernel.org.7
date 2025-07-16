Return-Path: <linux-kernel+bounces-734256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B235B07F10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214A77AA62C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63D2C17AD;
	Wed, 16 Jul 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HLqtcBbz"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD0E274FF1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698512; cv=fail; b=eyG1DfEof5A4zbKAN+hk6ixYeMKSqdRxaiY8nnqGTJHF6NXSdQBpWVUva25VNDhXxnO9Pu8+IlaaUrmhlkeSPhgjWAZiJ3SJDE13OkvENzbPr+s6FfRw8z4sTexkNOMle3zMqCK6oNKlru6HvRy9XxjOSxcqBoAPFhls2CDhRwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698512; c=relaxed/simple;
	bh=0bj8h0FoKOcM1rDmxrzhWKRT9D6wQPF6veqdh0fSvpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+tZb1FUZfxh851bkGnsoIcwj7PpbkX/vWNLtKB1mm48JvNSL49NKv9NfQESNDN9LmeF6nSxlDmowOPowlNnnih37xQTj25zLXl+gPx86OBaW7PY9x492ppkTjZcJtHdNKjSgropXYtQV2HRmMcRkwyWjbIgrjspcE41EL2nn8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HLqtcBbz; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXJCyD5IdhwOftChneiXibUYd8QBfgcNXUDC+5QTmRIrz5YXk560+H3R/WeygF+CMFo8FQl+dT7hg8z9DvSJiTlvuTQXJL7LvMvc/avg1IEEDpquN9iimWq8WSX0r9rBOz/XDoM06jcw1Ea0ocszRrKY5hFix5wVScqyuCmHN++azXbu89VblXMblkWtVZFAxCgksM7jmmelaecHxaEXTxEJ2FgRd+MkeJLliyQqJkAwTxeKS32PU4No2Vo78kBtY1SxlrBf3mYuaPWTn0kEKZdoH534zH2HygQSzClKxJrI+1ZRBpmdCoso1hATh+FRRZ0LhKXNHZk1W8EiL0SKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9BHkNQyRQYw46VcW8568RECySbVNNanOGtvPOEjv+Q=;
 b=XIiRxzG8X4jT3z7z5PK1esTy5GiNt21P3RDyUJpxAdlEoUrxdfHrV/jPiV2UEyZPzyl5CZkGonrxSarltEdx2jP/XghzeZq/Ih2PmrTmugPo4nB8j/bfZhlDnP9xBKLzlB/3VkWgCak36VKxZvBVYmJVdpyCEpoho5qy8DTaTUcV7f8GXaKNh8IzXUN1Fw/CLhRMuSlWcD+GSkpBGGyhahcOXbdPy57GWLVQL3Y6HO/2MyT96wOuRXAfwn81YUdZ8gVY0IetlJlDucWFQ9iEpSkJpx+onVhzgYpd0sJV10Ql7lpOPngJ3GCH+Kz7YLyx8pZHUUtA4XEu14N1f1vZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9BHkNQyRQYw46VcW8568RECySbVNNanOGtvPOEjv+Q=;
 b=HLqtcBbztTw0ESe7gGKZStSFcFV+REPRMDtN07LslztayabtSb9iE3F9PoRyDkjW/yzb9kJSvApxlGfaHljuRBJjZ8Q9UKYkB/vzh89l7SrpzI0ttrjfZ9t+nyuIDC5mKIY036qltam1aVWLJfKyQdNkMpagCff/xWuB6Y1Bs0M=
Received: from MW4PR03CA0249.namprd03.prod.outlook.com (2603:10b6:303:b4::14)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 16 Jul
 2025 20:41:48 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::1b) by MW4PR03CA0249.outlook.office365.com
 (2603:10b6:303:b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 20:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 20:41:47 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 15:41:47 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
	"Alexey Kardashevskiy" <aik@amd.com>
Subject: [PATCH] virt: sev-guest: Satisfy linear mapping requirement in get_derived_key()
Date: Wed, 16 Jul 2025 15:41:35 -0500
Message-ID: <9b764ca9fc79199a091aac684c4926e2080ca7a8.1752698495.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e93ca0-0bde-42f1-af6c-08ddc4a92f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6K5SXtSe66cxC05oTmPRxyGYf5DM8L+ueyti9vfAQ43qbt96qEWzmoLCqAPH?=
 =?us-ascii?Q?VE43QKu6Mso6wtFzjwMBCsKW5CHibM94Um+B1CPDqtF+mjPBM8coU8JE1NMf?=
 =?us-ascii?Q?5LiAUZMgW9AUUxmwfKrEHM/k6XvAybEWbx/x6/LODvT6GJOBrz9wVNxutv7h?=
 =?us-ascii?Q?RKwddffrUvcpp8IiVeLk82fO4WfqRfLcHQLpJX0c+wN5SjO9gip4JCIbF8A5?=
 =?us-ascii?Q?aZ7i7Dectsuc2QWFy2g3e6bBFA4NiVx8+MUDuy31eioCDbYAufIzhRYMd8vZ?=
 =?us-ascii?Q?EE7tdFnL9PVoYorwT/Gv9KwroUyKCVQSDR7QZSAQ3yTWMd7HrJwcXW1c92Lf?=
 =?us-ascii?Q?2yXRIhdfy6Ym3CU9Mh3zXhXg9qtBgSmBB/kQmTcoScjNpeQ5/R+UIzyEiu7q?=
 =?us-ascii?Q?rnf69WK/7xIj8EwtLfN7Ai/vTdgLW8p05yrYPPM21118UsDTlJpdAdZdeymH?=
 =?us-ascii?Q?s98Jk1nH1j1iwIxWCNJYDwUQqSNXawFDMYdkl/7WgW3TjrsdTwxLHGwWxDr3?=
 =?us-ascii?Q?BrnyB2RgNHO8tf//Fm721sFBVYmQmX/6STCd5zS2IJI2W4P5sfO+ezAwarJH?=
 =?us-ascii?Q?aKOy0h/8OAMnYcpHJ/aWidPSIBslhsGZCNn0EWQdorlTEn/x4AEASZPis7ZW?=
 =?us-ascii?Q?XVAYafVNTK1w1K57gGHAKMs54BuxHVK/Wqwwy67keTMa6zkyBN250YnkQYz+?=
 =?us-ascii?Q?KF5y/uQkwBoZ2cphuj4Ck+oGyC4A6gItK7mYlw8RLqSuafI5ZUWOjIQlKs48?=
 =?us-ascii?Q?2QIL5wc1DJzei1KFbDjO00EmUbqBPNK2FGLd2WNgGCmM5uhlDyntSfZtRwHG?=
 =?us-ascii?Q?PV3F4pT6erDj9mxHKJdRFaRGRgfCgW/UHpbhOzmeENYODP8gsWw12TqThd5O?=
 =?us-ascii?Q?J/MiILZ7JO16bnuCsPS5YsDwM569aQMr5YWosj9Yz8jfb2ykI262fLm5kip4?=
 =?us-ascii?Q?llJQY49nKRM/e/WdqLHPEdwXf9GJyCm0ZndCXVFViYvOEky0YSqDPDwYZ/3q?=
 =?us-ascii?Q?BFnpzDCCZfkL6a0GvmN3PG9B9uyaRMBgb8EwtIHspq7cTkTRRhmk/pN6XGdN?=
 =?us-ascii?Q?DFOcgW1ijamYOoG99oMHtrmq2r3g8j7VjAKzrTTOzWvyAecxH264URvKKTAp?=
 =?us-ascii?Q?wf32MOa3vaQG/7GMe75AhCQl3fcI7strwFiCeI0+jrhXrtbhsZ0UnTebihAE?=
 =?us-ascii?Q?k8e4eD3MbEfVDtRx4fHXkqG+1WPyfe4hhGP2pjp2Uq6KacMr+Jr+qqNDym1u?=
 =?us-ascii?Q?2Hj4liDbcrXmgEdQdlBwMq9f2jFOgd1f1TvXQCe8A8g8KrV/Rek+hLIL27jI?=
 =?us-ascii?Q?ZckR6zXIniOlsuyKcI59/bGJBv3Z/oWVh4aSLcsytt+3p7ZKQhjfiEyIyLqR?=
 =?us-ascii?Q?Nt26mexz/cKq/Eoiz4UMKI8ZjdhtMqtLVyFtwwsIu9dB4yvM6kwEr7VXraIF?=
 =?us-ascii?Q?OVOmlMnM7qpxBICf3y6+VXDwp9TsTSU1LvdZR+8kr4hVCw3sUkJEJVyb+4Pd?=
 =?us-ascii?Q?203sknfdVwYSkPrvg3h+A5vc5fzq33qNIDyY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 20:41:47.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e93ca0-0bde-42f1-af6c-08ddc4a92f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0

Commit 7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of
guest request buffers") added a check that requires the guest request
buffers to be in the linear mapping. The get_derived_key() function was
passing a buffer that was allocated on the stack, resulting in the call
to snp_send_guest_request() returning an error.

Update the get_derived_key() function to use an allocated buffer instead
of a stack buffer.

Fixes: 7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of guest request buffers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 27 +++++++++++--------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index d2b3ae7113ab..b01ec99106cd 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -116,13 +116,11 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
+	struct snp_derived_key_resp *derived_key_resp __free(kfree) = NULL;
 	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
-	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
 	int rc, resp_len;
-	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
-	u8 buf[64 + 16];
 
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -132,8 +130,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len = sizeof(derived_key_resp.data) + mdesc->ctx->authsize;
-	if (sizeof(buf) < resp_len)
+	resp_len = sizeof(derived_key_resp->data) + mdesc->ctx->authsize;
+	derived_key_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!derived_key_resp)
 		return -ENOMEM;
 
 	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
@@ -149,23 +148,21 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	req.vmpck_id = mdesc->vmpck_id;
 	req.req_buf = derived_key_req;
 	req.req_sz = sizeof(*derived_key_req);
-	req.resp_buf = buf;
+	req.resp_buf = derived_key_resp;
 	req.resp_sz = resp_len;
 	req.exit_code = SVM_VMGEXIT_GUEST_REQUEST;
 
 	rc = snp_send_guest_request(mdesc, &req);
 	arg->exitinfo2 = req.exitinfo2;
-	if (rc)
-		return rc;
-
-	memcpy(derived_key_resp.data, buf, sizeof(derived_key_resp.data));
-	if (copy_to_user((void __user *)arg->resp_data, &derived_key_resp,
-			 sizeof(derived_key_resp)))
-		rc = -EFAULT;
+	if (!rc) {
+		if (copy_to_user((void __user *)arg->resp_data, derived_key_resp,
+				 sizeof(derived_key_resp->data)))
+			rc = -EFAULT;
+	}
 
 	/* The response buffer contains the sensitive data, explicitly clear it. */
-	memzero_explicit(buf, sizeof(buf));
-	memzero_explicit(&derived_key_resp, sizeof(derived_key_resp));
+	memzero_explicit(derived_key_resp, sizeof(*derived_key_resp));
+
 	return rc;
 }
 

base-commit: e180b3a224cb519388c2f61ca7bc1eaf94cec1fb
-- 
2.46.2


