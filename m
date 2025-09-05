Return-Path: <linux-kernel+bounces-802124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EEDB44DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9373A07850
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFE286415;
	Fri,  5 Sep 2025 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YL2gDXuZ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277128488F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757052763; cv=none; b=SuBnQKCY6tJtDmD/KgxSs77mgeiyYpjxtQoWQm4otQiAZdAPzI2uMamdNJJyNnU4V2+7lpLqK2mVtAOOAKpIorhm6eduOYBBZWEsyatQ1xspTkVG+EUglbliXHZsQNHnAchxMgqGvmNXpLFxvPtPrck/NuaIWTgSKa8f2RKFT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757052763; c=relaxed/simple;
	bh=BWbJljR/mtL6PMqRXPis87NQ9xRN7C6KE01z/L1AYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAKhsGe5tq09BgBgvAfGPFCWH11o/chKfV+Xhdkca8mTlADSyQBM7dLjXJp5/o/4bx7GKN33ZkUUnEnLpAIkaX4k/gSHbhCp4N/hRfyUE0KQsExsuhcWMb07JXgcRiePAhzZd+WWL8enKmMBdKakrQsDhs0aJCAH6rQS4UG3JU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YL2gDXuZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585205vJ011765;
	Fri, 5 Sep 2025 06:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EOiwDLypudExa6X+mQqAgTZSMoOzpDTpaATdLNnit
	Wc=; b=YL2gDXuZ62mTlRHdvxP1cFJuZ236PJd++xCALhzhjqZRZPsglDjx9aCCL
	frtdvRWRXOPXEtquLugPpaajBU+jVqJ4nQ7FtgE+XtMGC/CpnRObiTOdPu/XfmxS
	k21Fe1oFuaAcv/nLV0kQEopGPlwipHZpj36mGuzO+QERZFSXwRf6FEsE93QM2Ira
	Vt6E4u4UdbuHgqNRAH9uAbwuZwhwom9naNRrfTuYw1GaHXPL861Rx5SsgIdbB3iT
	oFnMvP/NSJ7/cFa66Edn1wngMNfaTTJ29O/QEjP6RqMC9hlWhPUJrsTaC/L0vg5r
	26adjH3V2M+vi1bhD50gMPcswaX+g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurej28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:12:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5856C6W0004690;
	Fri, 5 Sep 2025 06:12:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurej25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:12:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5855GHA4009000;
	Fri, 5 Sep 2025 06:12:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumqx1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 06:12:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5856C4aZ48955772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 06:12:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5CA65805F;
	Fri,  5 Sep 2025 06:12:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C6D55805C;
	Fri,  5 Sep 2025 06:12:00 +0000 (GMT)
Received: from jarvis.j0t-au.ibm.com (unknown [9.90.171.232])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 06:12:00 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com
Cc: npiggin@gmail.com, rostedt@goodmis.org, ardb@kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH RFC] powerpc: Panic on jump label code patching failure
Date: Fri,  5 Sep 2025 16:11:35 +1000
Message-ID: <20250905061135.1451362-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX96Lf5pinkkAe
 SWHwo837foscTeRwpLEUJWJrZ1Y5CaiQ/IQBsSentBEfagYO1u1JfkNmKqhkPBNPDqNul4RAsRZ
 YYa9JQKoS3L+jSJaJpejdnTnMKJrr2wHU5HtfUIMr8V+783ubsoiiSdmVo+mjadj8mujxAKA+wD
 wok/czKCjg4m2IvXMfIl+smeC8bnVp2UusT9pTrqvCTb8Z2Mq7sMejRewdrvoIdO7E0pxnz8NUs
 FCyfWBisZl46yM0m3OEax5erumCwdQiOLJN+k+Zyw8XGjnLf6UA+dnWd5McCeEgoNhxA1kdYZ7e
 6lU3X6ACbffK77H0kI5em53z0R2LvBfH8zJQDxBbzEUPpaC1Tiql6iqj0qthuymYTYAvf+DSf32
 8A3kGA85
X-Proofpoint-GUID: -XeHBqheUgEkTi5oLlF3x3FKZ_pPzdpT
X-Proofpoint-ORIG-GUID: H3f_zlIX5ElpJY2djrWAYIy97iLbrzaf
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68ba7f36 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=voM4FWlXAAAA:8 a=1UX6Do5GAAAA:8 a=b3CbU_ItAAAA:8
 a=VnNF1IyMAAAA:8 a=OjDvQk8CL8vKLhAk-QAA:9 a=IC2XNlieTeVoXbcui8wp:22
 a=Et2XPkok5AAZYJIKzHr1:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

If patch_branch() or patch_instruction() fails while updating a jump
label, we presently fail silently, leading to unpredictable behaviour
later on.

Change arch_jump_label_transform() to panic on a code patching failure,
matching the existing behaviour of arch_static_call_transform().

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

---

Ran into this while debugging an issue that Erhard reported to me about my
PAGE_TABLE_CHECK series on a G4, where updating a static key failed
silently, but only for one call site, leading to an incorrect reference
count later on. This looks to be due to the issue fixed in [0]. A loud
failure would have saved us all considerable debugging time.

Should I change the return type of arch_jump_label_transform() and handle
this in an arch-independent way? Are there other users of code patching
in powerpc that ought to be hardened?

Or is this excessive?

[0] https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu/
---
 arch/powerpc/kernel/jump_label.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
index 2659e1ac8604..80d41ed7ac50 100644
--- a/arch/powerpc/kernel/jump_label.c
+++ b/arch/powerpc/kernel/jump_label.c
@@ -12,9 +12,14 @@ void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
 	u32 *addr = (u32 *)jump_entry_code(entry);
+	int err;
 
 	if (type == JUMP_LABEL_JMP)
-		patch_branch(addr, jump_entry_target(entry), 0);
+		err = patch_branch(addr, jump_entry_target(entry), 0);
 	else
-		patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
+		err = patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
+
+	if (err)
+		panic("%s: patching failed, err %d, type %d, addr %pS, target %pS\n",
+		      __func__, err, type, addr, (void *)jump_entry_target(entry));
 }
-- 
2.51.0


