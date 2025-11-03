Return-Path: <linux-kernel+bounces-882413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E841C2A665
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC163A4255
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255492BE64C;
	Mon,  3 Nov 2025 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="lCfC1SbL"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A523D7CD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156021; cv=none; b=EIjx2eogmgcH216INToEuExHkc2Ui72hqYl8jVEnW7aU39eqqnDfkMVlQ5+DDi+yw3MFH+BrakK3DFJ0JnAgDSvI60CeMAgN+a6fZVTWyIKbfwIOpZhd7Jy2sN17xSWueqj58y8YB7In33dG944dlytQjoyZoZB2xYA8c+Je3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156021; c=relaxed/simple;
	bh=x1ezsPlySJP56xSvS/nQ5ODvxnM/ECEvZ9X0izOQWqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIzBvHZS4J8VIMOyiC2l+z1Rqu8sNlMSUbb4wPhBTE99QxWsueCBrx45AgMRqQlYauMbtjXIzkqOwC3l5EZw0PEoezrxBNhCTEt3VCfrVA/W1nYJaID+OoiAb7T0hGvzkXDNxKBvHwezfQ+AiJLJm8kL4tOlhcwOz/AskqBGEQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=lCfC1SbL; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36UTu82757392;
	Mon, 3 Nov 2025 07:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=mr57+HT4IIk3YxkxZzbJ1Zl9+kj8x3scbZ1xtR6gQ/8=; b=
	lCfC1SbLR39XVcyhSFI9z2Odwjl3ZaZXJydakTgLr8VNfsaNz5XlBZcetAaNp8lp
	RyP/yXK14yHGtfgodMsHTXI6tj1S3NEHhBOYp/XVk3W/b4EC2n/1Rry5554toJJS
	yFXGtL4q7i9iHH3XnWRqpq3qRwK1hUFTJkHgbmP0UgJiy9j7j7MpW4FKE2DXIIWp
	XDKTqOXJ0C8h19bqRX6CwaiGSUKiW7hOG8ofZ6d0zav7bzlGsZhiwnZ/p8lAZyWA
	YkCQhzuXYqpLUdF+/iDxDde19FFFXBeWSC8vT14N7tKThxQ8n/qPHTAm2rbpBHNG
	qKoor7OEpWUt7HJcWeZ9Cw==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a57dx1h82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Nov 2025 07:46:46 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sun, 2 Nov 2025 23:46:43 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sun, 2 Nov 2025 23:46:42 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
Date: Mon, 3 Nov 2025 15:46:41 +0800
Message-ID: <20251103074641.4160652-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6903e7f7.050a0220.3344a1.044c.GAE@google.com>
References: <6903e7f7.050a0220.3344a1.044c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B4mr6SoSTxaYNw-YEg6nhlu_6S-7xbFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3MSBTYWx0ZWRfX/stuxzT6oZOP
 vmdmnfgkfBfg8RBlaX20QKshCxPlPa31uZ7bVQfQ8/vozH7heFxl6OgPMwzprmwHgWEPl6AmoXQ
 SR9siWpF+BfnsuRw46EzxXuQ1jAkQxQ8RSCOUnCb3izCApi3roRLyLRUkA1w73p/5mLwnQPzz/C
 yBJ7m8o9WO9DpLURqRlX+CksQelNGQSYfUECWapYx5Rep/AtotNFrJS1o+9xexQfvrSeWh3w9Mo
 gE/MdAjdYYX7L7/1IK28eY/8Z5F20aGsxRuz/+eVm+2ry1Kv4dVXyGwxHUmRBXZcVsKyA9G8/Nm
 YDX106Ne63KEbN2zF1uH75hw3/j5n84wnu+woXBHi7du1O9WTlRfb+DFc7IbJ2n0RP+ET5oHPeM
 apxXvLOxpbNQTZLI3ezCyWE8wAudhw==
X-Proofpoint-GUID: B4mr6SoSTxaYNw-YEg6nhlu_6S-7xbFx
X-Authority-Analysis: v=2.4 cv=BeTVE7t2 c=1 sm=1 tr=0 ts=69085de6 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=G8MWmXNMHRbPEfq27kcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030071

#syz test

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ce7253b3f549..b7860b96e8bb 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1041,6 +1041,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 		goto out;
 	}
 	ref_count += ref_change;
+	if (overflows_type(ref_count, u64)) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+			"EA inode %lu ref overflows: ref_count=%lld ref_change=%d",
+			ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 
 	if (ref_change > 0) {

