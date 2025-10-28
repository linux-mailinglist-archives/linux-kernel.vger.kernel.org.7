Return-Path: <linux-kernel+bounces-874037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B83C15595
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 957CF354ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7933FE2F;
	Tue, 28 Oct 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FS4ddajx"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84116DC28
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664236; cv=none; b=Il9NDHYBjg2wL4/l/rGL/L1GJym/Bw6FzYZLMKNabGkIWE7C0q8TeaFV2Or2oKfDZcumf7gMrVZdGF8bNfpTdNBThIgswAyVa7AF4Yo3/ARhO3kQk7SEaDNutLrscQPi3j29YvuRcy8KVcBcFrZu/1G5CGpj9mYknctGcwGbDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664236; c=relaxed/simple;
	bh=APKFispg0CIRT6Ot8b5F0Noc0lF1SElFka5UOvthT9I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=E85tVmN4KRqPZMmpwaK8BRaalSP/Nwruv9deNnFIdq2qiqAl0GKhLjQDGsdLI9aMbxKkmz+1Ceke8+bwp+VNZtwpbBdZFpqj0cOSAYjD9nMdRYR3/FlMzyqKUOivuuv97lNvPUPKM0smlqbOtdRqHiKJEG2Wi/cUDFN67X/gppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FS4ddajx; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1761664230; bh=a1+UOt7Zw3T3+ggiANHOs0iMPIbLHt0Qm/DP4XacTHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FS4ddajx6IdvEiR89vD/4hQ3vXQs4JzseAEY8C7LRGg9dWdIUPG9+eokgUtnPNZsb
	 W7KYfPGMuTkdTvOfV6QdP8V3VZAdSu/0EDnWMJTr+EzFjBh3Tr4KgoSfN1DsRZnPqb
	 RgoIgYDz6MGQhY1AfCwb0KZRa6itX5dGzEv0G0rM=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 29D016E9; Tue, 28 Oct 2025 23:10:29 +0800
X-QQ-mid: xmsmtpt1761664229tsn5vo521
Message-ID: <tencent_BC66CF1362C363496C83ADE45C377E776D05@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLRKxdp1rCxNgWTMkBIhfG5VhZPA20IdEHx9+89XnQJ0Rz9ZVMpe
	 VTDzdxqaz8R4D6Mis5DCyjBw7GsgVcgcaYxl8xaMs7n2zXkpj1Ksf+aNXqmeflk63PDSNJzO/Ir7
	 V1apj1qtEDKgpdQR7An4uG+RbHVEcdY1E3svkAYluvYHjm/8KDahjheP5CftoHE3rzLBeQ7loxRF
	 WL7An02cR2dJFPGhh614QiiCtveDifD6h0LEARnmOwpH/tvv5U3nRiqzZSOPPahg2bgoNSCaMFJX
	 p0dEzTsfvKAQfeTwcPIm/qSIDw30kcDU80V6dp6L1i3ep/qj/+cmQK/fWcXWqxyYT/NUk63x0W9G
	 o/pYdYCsVCJHDRm7HsG2vmmba/jzf8GLsnVySKpCFl3+LD5W5LvKk7Odu3d8VGWPzFsGOYCqM8PW
	 PUmPbTdyN2qL3tJIQGgilw2RZrQCivwy/T6vr6SBVkbqC7TVgzTRDUEWLlCqU4Q2jSqUXewpKo1O
	 OhGne/MtdQJlN8Nnr+hNfFLlxEIWCQBoj01bZotsc/2NDv8/1Y0lIsm6tNQUojb6rMHi7RfIhlaX
	 m0PClKoEDNKxmiVosSAOcURwZ+XN4c2w4Vx1PGjWTlpxlJZJT+RVxK5DvnH88vkxm61ULHOa6D6x
	 HK/ju+3Av3coG3hTh0hjAT0NqukjZXwSWUQ1a8YHgA2ub2ohLEOMb9YGqq81SS2eGZKgwwcgHI1E
	 9cjVE8VpH6COaKDhAYjFaqmRGcQ4BCfEteUuuGpJ6QBh+Dykod4+TmjSKjA6utaruYv6RGSB68eo
	 aJ1dcpO4tOdKhk5ul1La1rW2Dkn4mmbhuxM38ShQsQQn5wYgONV34ifqT4s1St+w2QvgynEHAcrW
	 DDywNeMaCiMKB3ym8V1VqZcRdJzsQYPTaSP5FdWv82Hh4b2yB8+qLcAjFOvGaSWxUxe99bjDDE5e
	 J3SCeFewb8Uy7OXXmUHrihAoYL1Uw3hM1qkSc4GN8xlYldJWdnAg==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7d1563afac6cb196a444@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_count_dnodes
Date: Tue, 28 Oct 2025 23:10:29 +0800
X-OQ-MSGID: <20251028151028.2939961-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ffe16b.050a0220.3344a1.039f.GAE@google.com>
References: <68ffe16b.050a0220.3344a1.039f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index be73233502f8..9036f1ee581d 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -257,7 +257,7 @@ struct dnode *hpfs_map_dnode(struct super_block *s, unsigned secno,
 			     struct quad_buffer_head *qbh)
 {
 	struct dnode *dnode;
-	if (hpfs_sb(s)->sb_chk) {
+	/*if (hpfs_sb(s)->sb_chk)*/ {
 		if (hpfs_chk_sectors(s, secno, 4, "dnode")) return NULL;
 		if (secno & 3) {
 			hpfs_error(s, "dnode %08x not byte-aligned", secno);


