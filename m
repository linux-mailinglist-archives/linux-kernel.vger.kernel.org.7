Return-Path: <linux-kernel+bounces-830371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBECB997EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E9C320326
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6782E22BD;
	Wed, 24 Sep 2025 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mAAmpIAO"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED222E1C65
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711146; cv=none; b=usn7snRauc/lpJo3PtGYCnWw9tv1y362CDBGqxlnqc1e52bGDxvSY6TJjJV8CHzZjsEVTnHzaK+xi7NonU7iGFIPFFECdh1ojIdsuzby6mR/Zaci0fceID5Knt1ZIjzNUjrT472wdC3HFKLPWlB8R31pdYh5kKOY6YcOo4P5jIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711146; c=relaxed/simple;
	bh=aeonMZLvH8gcK2UR2DvZYbmR5TOnS+QrA3lwrN7qU7c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=p3zARXUDT5cNSttFRx+qgbFt+vSOP1gt/NxjsBsPqvhNDXSwOUI5b3tywjd7f8D7S34z3MQMQz/ib9qoxpNXvnULqIy8MEn4medJkZ3P8j2BzUVteOzImQ5QK0t6W6IGxl0senNKOTiPyYiM+6POJgumk+gqyL13OY+zDudgPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mAAmpIAO; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758711132; bh=aeonMZLvH8gcK2UR2DvZYbmR5TOnS+QrA3lwrN7qU7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAAmpIAOAMnXXhsAfD8cMNNnPsC9vwlxkSpnQezToc7kCzyz5jiaN4AOaI7+ofupm
	 yHHgL56em0+JME0c5SGwuugliyfKhgW7paJn4dbYNPdz9w5VdVgPN6xAFhkkynUZPR
	 O06R0fAIgPpBPTuJaGNICR+BHJxzpaMk09+nGDLU=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id B868E293; Wed, 24 Sep 2025 18:46:06 +0800
X-QQ-mid: xmsmtpt1758710766t3vamrlzc
Message-ID: <tencent_493765F76026C1D371C370C96683B6C45405@qq.com>
X-QQ-XMAILINFO: NwIPvWX4YDagG8mvPQDRJzUPbZT7zWTHyy2ADc96LLv3xw/nnCRpshQtTJUAc9
	 Gtwp0nKJAo2NahTZOhp2UQ1oifPyKWqetaPBxWy/thxJlDFUpUEK+mBiSuM/tQZZItppFhhrkMBl
	 /yTdRJtahBaNEJ9sNDjY0m1nE/ljrfJQtgLUGcgiorCMmRMIU94Ku/zNf28pCyE0i/5VWxwkrBCo
	 +mDUNF+3x+ghndH973LpfOhXz/TqHSgFpnDLgeA4/7rNHnBp6Owv5FjPs0MY68tkCEoGBnAJOi5m
	 qW0JWINfuEojWVVUpjlZmIUxQf5Gh3GJ7GCBM0Q5+tdizFGmiI4qXvBq7KJG1TlITFeIF2X6FGt6
	 GwGQeGOsNVqOCSs4bYbBZo8E1zF79YtZpGGT8rCSG9lFnPfw5mx0qZST6leYGyEoTRJKMJY8Ptf5
	 wwRbD+xtaCngD+n5picAfMTBg4Y4pgR1jTEBmiHvgiI8vc3VaJMq2FcKOuJWiZt99u6g2f7X3nuM
	 YOGAqBETqlB3tR/xD/UakBhA/XVZ4zz35hMgRqQnqnCoUKhSwwKbnVC3YkCjoXZjeOJiwTk972jB
	 5cgZVdXE7xzLl5t3uS5OOPD9PQPp/9CxRNPFrj8mBxFk3XiUj7Q5wx6k+L9iWxirzGunMctejgP1
	 vYDChzegTa5jDtULdlhi9tQiEnCtl5ahfs7GygyiCvfAt5AddfaCqBgIgfBHfOJQF/j8+ArSz6iM
	 C0lRrwJYhw77SneZ+V88dptchOWr7G00Wlh2rVZju3eAFru2t5xjgDiIb9Mb+Bd3GZVLk42PRLcu
	 6vDvLhpwQPME7scXyb196kwuc3zgPY8gCNs00W/F56rqm0w5y5LuQP8AS0bwHyOCfmLPD0stTgwn
	 3F1E5p1YwAePcnx7NYVCZO8WhSIdRh84psVpxbyTVC2SCcVD5vy2D43z34PQ/wNPqrkvIwkqhzxu
	 FP1I6fFsYF56oD4jF8gIn4pmvJPEToClWzjsIt47JvJX6CC+FZ5dQC7qfmvQd9KBGfF7Ez0GBr1q
	 7TNCGXrQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
Date: Wed, 24 Sep 2025 18:46:05 +0800
X-OQ-MSGID: <20250924104604.1508726-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <tencent_7784EEC92ECA4CBAE7CAC6F592CEC6728906@qq.com>
References: <tencent_7784EEC92ECA4CBAE7CAC6F592CEC6728906@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: none


