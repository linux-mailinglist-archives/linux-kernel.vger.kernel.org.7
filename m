Return-Path: <linux-kernel+bounces-744215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F3B10993
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BA95882FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CAF2BDC3B;
	Thu, 24 Jul 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BIOrMMAC"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA426E6E4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357910; cv=none; b=SW0zMI/rwiUfWAwQs8oAOuehpKGIEAoJwjLO8w8CFCjXGlCWWQmcbXk4AcKckimzQtIXl4j+Q1xxgm0hdw+tjpUHEd344qWI/Av+gWO6g0gtw86lRr78v2nLovJ+8yLsv/BwLKBVPr85512f/Ju9GHJa/vgFJQTNUOUrE6pGB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357910; c=relaxed/simple;
	bh=Q1EA1omplyYKc+e9FLRaa4h5xixuu3ZkDHwZnirvJsc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=os4/0/0g5ud7Ta+hx//mOEss109NtT64xTKbcGHx91j7qSh33Zrat4s5lPhmZ5DXuLrPZpF+SFlbJr6wzBVfWi2rEbqanrY6u8yXRIPXY0udP+h5Akw0i6JaUfRItVi+hwYOsr8317PfH89cgMg2vJITHIsTDhPBeOzL+56tzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BIOrMMAC; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753357602; bh=jOwimRxam/xoFqlkij8N7C6ZTkua1wb/QEaaH/Xbn9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BIOrMMACq1sm7RGLf7RCuCusC4MBtC0InDlgShneCowiouGbR33QgVb0VPoA2J2eK
	 RCqvVtb3jGZIx2fhfGLohsnZ3YJYW2GrL/YtnPUmSy/8VvlQiLtjzhtqCIM37dkdKB
	 a0PQv7QlR70JzECEop1ntRUNxq62qiaJEZTelRxc=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id BA88A288; Thu, 24 Jul 2025 19:46:40 +0800
X-QQ-mid: xmsmtpt1753357600t0ir9ov9s
Message-ID: <tencent_D1B2A5C90DBB9238DDD65DF11919CFA60D07@qq.com>
X-QQ-XMAILINFO: M7W7QqjC7ykdeYlXs/kypn40T83v78SrT8clEo28e1Wq2AxJvKLC0hpJdc7e+h
	 658mi1MoaT+FFYttcVWruF0adeHAWm9OogZ3UyrLqx/ubVNSluNAGl7R9sffMoaRO6oftlkOQ8q3
	 EolPA3Jzhr/17aiIuIbNfvMaPKls7SROslRGqBC7RpGhv18+f8e+R0o0kkgf8tGI4qcSuAQp9zwH
	 eOLveHBfjy0a6Fco3NhCf4UxND0HQvyN+Zka+VUAUAxvj3lm6NHjyxRhjdAblVwLgPLuYK2eGMWs
	 KjTvP/ZFkjF3YBMhH3OZmP7zT+pgVxGWJ2LAOGNVpj09rO0OUJsp3WD+CgVlVe0yvZeaDmIj+7UH
	 P5LVsq4xvhzs4EfnZyReT/eL5ASosRUU1TKl2V8KOTch5B9R7exsy6ZwAdCN/Tt0z6MUmQGmOrdq
	 NuzOyqvRQGrOyW4aLO/ErGyzcqUk9AypJrZdd7BEDAGpYg9SnSVV9FNlHR5vVY+BOPha6qwBUv/c
	 WfmYXU3n4eNyiz4zLWlk6RdDAlBUVFO1MwsHHg6LPuhAIHehfPxu9W0alTG8M5I781fH1jyXNf3q
	 8C3+QPHgT//Qn12L4jsLPsrKy3qP5Ot3g9cV3c0xl8q+oOD9qtruwBkmCR+tqfIE1wagapNjzTeN
	 VnHafFlW1cgroHwuphS7bhNCUa+OqDvsb0cIJ/TQ88rzHWC62T7qd1qc9bh6pJyJljn0ReMsyIDc
	 IclxumnXJq9zSiY4/qVgy9J699h2/mNRQwIU2z74mvixmjJX7DV7+jw5HYkgdPlU85Rk5yP7wQHT
	 5N6JxcX1VA4C/cVr+or0EqD70Thkt0KYpmXuXavho3+y8wCLdX/ScFEG9cZnfa71cV2AXp2C4EOj
	 mKQLnM77mdZRuzCQ1EqkOzpT/kf6GZWn/eGrH/jnsckgFCyzDSC8j4oIr6mxYtjM7RHp7Em+pilI
	 e1YrqkdAuYQspHI1d0rZIhPTIcs+rjK/S2WmBELwU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
Date: Thu, 24 Jul 2025 19:46:41 +0800
X-OQ-MSGID: <20250724114640.574813-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
References: <68811963.050a0220.248954.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index ef9498a6e88a..1d6f2bbafa7a 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -133,6 +133,8 @@ int hfs_brec_find(struct hfs_find_data *fd)
 			goto invalid;
 		if (bnode->type != (--height ? HFS_NODE_INDEX : HFS_NODE_LEAF))
 			goto invalid;
+		if (!bnode->num_recs)
+			goto invalid;
 		bnode->parent = parent;
 
 		res = __hfs_brec_find(bnode, fd);


