Return-Path: <linux-kernel+bounces-879357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51312C22EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A4CA4EB924
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315D26ED22;
	Fri, 31 Oct 2025 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JYxTmmgS"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F4264FB5
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875600; cv=none; b=KopDsr8LUoPNcv2l0mH5I5j6PAyw0472LcmbaOZtWshLMc8DjtjmbsnT4fncqsl9LQn2Eq1nPY4hjgpJlVIEa9oYoCcCucFCvD1IvuVZO2QmLpWZRu9j6tzQZQePw4QH3bOdZ1p4wUGbkbf0aIbOYsaHDS8NIEtvkqQugo6FafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875600; c=relaxed/simple;
	bh=cm8UfhSD0gkl8XoG7pPsqonRB7l/HpWi/8mznxwuEtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewZT1MJdyMwFKVUTKwHi+uvXNkoWQ/gToqQ4lBN9HIG5DzA6trV1j0nUFs1jGCfTjB/PMAM8eI0l5Z1lMSKZGfUlO6a1pXQAaMPgc8xRbOsFcl7p5Q92kKwbRGNX7/udLGgXlbdG8pCqmFnm558EQwFy9QcY5p6Dxe3mgd7YMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JYxTmmgS; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1aJ6j2661906;
	Fri, 31 Oct 2025 01:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=P1gT4eIHfbzHADQLAfZ5HusnFNfIOFJ4/43GXPP31f0=; b=
	JYxTmmgSROvD4VEjlrZdyZRLuMwNpO2TOTd1CXkb1lRX+N8TBmN5liKxSe++nw+P
	jVkfyMYD7hKELTnxafpnoT30E6HXJEcULQ91s9tCfhWnxFH/CJnriosGPvYpKg1/
	Rb4ne1oECKblRYU68jaHEeJX40A6zJp8k/BKZpjFngcW9m9EoyYnCHYr4OZ96iDU
	3NnttLY61gl+0tcu96xisPwSg1Y+5FrB1g7Y0PoziweDu1IQ53cGRNTASoA8CY6A
	4JaJmketlrE6gSe1JTFSgeOI0ify0PNGoO/ktpWvtdpOmIDbwxg+TyXimJE3v+BE
	gi5u7nzF2VQtzwehEFmzgg==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a3w7hhaf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 31 Oct 2025 01:53:08 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 30 Oct 2025 18:53:07 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 30 Oct 2025 18:53:06 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+76916a45d2294b551fd9@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref (2)
Date: Fri, 31 Oct 2025 09:53:05 +0800
Message-ID: <20251031015305.1439863-1-lizhi.xu@windriver.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAxNCBTYWx0ZWRfX2pkVcDU+TjL+
 YO80ueNRNrwX3d8xYPzL4R6iLWHM/VgMG9IviP07ES2hjliQY9ffEJhUK8SUXh+CRvmXz68UZ6I
 E65p3nU1amX3YuDcQxUZNw+pIdvzaqYJWer4QOY4eWcowRQNKYfxafq8PrhBM2RfJ4RojGqBtNf
 VVu9+tO3/9x5gi4SbLYrFLR1X3v5JpZ5Qr8UCDT5AAw0r2tx4NnrK1uwBFV4nN+LpMvvFekpuTu
 ABsa+Ym7r4Wg/u/2KJqgIzxhG2mjhEOQ7/TAJ5jmtraARf1kPp/j8RnsXIFdCzPhfpUS9GsTvSL
 EB1mx72/VPlaLhRSz3ZgXHa4EajVepmajwjxSPeFVLdaCfR8weYnj0WKDfhc+gvbNW3TpDnGJMM
 ZN6FPezhj1dm9ppYLoN9JEaYspuBDg==
X-Proofpoint-ORIG-GUID: bF4R3Q-gZNfEfC-vAPWwBc1vNwvNeC1U
X-Authority-Analysis: v=2.4 cv=UatciaSN c=1 sm=1 tr=0 ts=69041685 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VW-RJeJTN37yK0ehcJsA:9
X-Proofpoint-GUID: bF4R3Q-gZNfEfC-vAPWwBc1vNwvNeC1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310014

#syz test

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ce7253b3f549..8babe8c344fe 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1192,6 +1192,14 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 		if (err)
 			continue;
 
+		size_t size = le32_to_cpu(entry->e_value_size);
+		if (i_size_read(ea_inode) != size) {
+			ext4_warning_inode(ea_inode,
+				   "ea_inode file size=%llu entry size=%zu",
+				   i_size_read(ea_inode), size);
+			iput(ea_inode);
+			continue;
+		}
 		err = ext4_expand_inode_array(ea_inode_array, ea_inode);
 		if (err) {
 			ext4_warning_inode(ea_inode,

