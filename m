Return-Path: <linux-kernel+bounces-805738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF70B48CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEFD161FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8C2F8BF7;
	Mon,  8 Sep 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j9tMMyx+"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2C1EE033
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333293; cv=none; b=gR0b1+SC9j0ohImmVt+HAEXDjgXeqEUnJBUQkQRl3A22myX2yRBVCBh2JSxV7xlj1nRXSXUL6SF+VGQ2B4I8SQwqCv4jEsCOBlA4p1tIBbf2l6NQJIED16WhZAlKRKowCyPSB8O6K6xtpkdzD4oFj3RFQv6NCSvJlrLcxWctTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333293; c=relaxed/simple;
	bh=ZVQJPTOouxLZ/v8x1+fqmZZfqpYvheKDxIpsjXeK0Xc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gkp9bK1yPQgH2u+Azd/noUAmb9LoQantmXTcy0RDYa1A6NXcbsh4FTBqp8FO0MQkTRM7HA6WpSwwQK5Kewh01+Rko3j5L732AKYvZ1wOl3kMTChHuIBxVjw/UxqOhrRyrNSl0r/PH2JrkNG3Dn/MzsjvCjuuoClaTYMikm5CcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j9tMMyx+; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757332981; bh=mBOgZthAeNIrrKWBuszWkTFx1OdgxTih3JeIU2LJqIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9tMMyx+p1pXyA+tb0RW3DQulQIXVzfx/hsINyhHGGVC7a5pRm11vXGnRHKLDO7Lm
	 We5ZvsgK2vzc5r6V2D8omPGY6cHNSdAUnNIkACsfUA+ZtpYDRc9bqFx/29JVF6FyZr
	 ocFUKQ6/iXhD+FMa4Xy1pONlEu5lzGRaUoxKlr+s=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id BB20456; Mon, 08 Sep 2025 20:02:59 +0800
X-QQ-mid: xmsmtpt1757332979t1ijyonm5
Message-ID: <tencent_A10DB8A5C88DC712765D8D5D85191DCFBD07@qq.com>
X-QQ-XMAILINFO: NRYSeI3Ux+UPXG0Qepx2Tp4CQ2mkPyx3h7BSg+tbmC9McMETTlBq12RtwEBQnq
	 5FoqTnJQCBJE2IkIhHXC5gLQlMK9RbYjOteam0j57IOkDH1dx33L4479gYXa1wVneUl6nUm0vVaU
	 /bhLjxj/b4Wl5gvB68CzXQyYpdoAWDqdQf3b4ZTR3GmgSLpt+vhxMctWtuhFsOTaCLszA+iVaZdy
	 IYe1zrwtoRA0GQidUbjXGCFE8zxK0JQM7k1ASFf1jby/5RmKjwlWXaR+pfX748869T5EiVrNJVgc
	 jPA4gKQf9Tx3OO2+hzcmic5FysBY5P+AYceVBEzMWEoLWFIvGeK7Qj+3zfmbNeJK332mEqLGngvN
	 kkfQN2NAtx8Ol4tM63FHzNeHwb9Yxq3bV1VMIbyUznegAsvWHJPBctvePNHx6gymbJMwrrfWXnuc
	 EwJSqyH24HOnqJ/Geyuz9CupX0MBU/YeCVNoVMnIuoIRb8lmf9h39zVlVaPmCLiDX7Lxe54EHILp
	 HvIPXpmXlWIEo76R+HSrLe+xF4QDCbfI1GxhtKEO93QIsJLVdZkl7z6W+5gfMHt0IqUJ5K+K6SYZ
	 I7nMkYYBDsgbg310Pm1Xqz4UgCEwaXnC5rvLWpmuJOHvyf58/3bx8H1a1JGewPcnRbDS0rWY0tUX
	 duLl/xo4fFWjaNkOEIJLy5JxIQ2YL6WD/cif103HtJBl4R+wGvAhwqPhXJVNGOhfb0TLrJAV4FcY
	 NB3I/FfVv6H9KCLpQfj5KSCKIi54gAT3zMPmmAFn8f3AuQe/+FGORWNAhOiYpyN/fwH5yfdAkfIh
	 zBoi2FezpcDmLxgOrAs+lM+xG0cVF7TXnuSNDHYZiCGp1KkYQ1AkeUaN4swf6rq9jpPxKhwqv/dN
	 iexH1Yw17sJYTrFVSQ77lKQGZ62kRniHgcDCaH2Ccix8GuBhPA0gFO+7bPltRvbD0Y0Jj/x+NGUv
	 IYbDQel8Cj2h91IIz/Cg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e37eedd918576774ec80@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: wild-memory-access Read in __sha512_update
Date: Mon,  8 Sep 2025 20:02:59 +0800
X-OQ-MSGID: <20250908120258.2568601-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68beb07f.050a0220.192772.086a.GAE@google.com>
References: <68beb07f.050a0220.192772.086a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/gup.c b/mm/gup.c
index 010fe56f6e13..22420f2069ee 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2981,6 +2981,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 		return 0;
 	}
 
+	pages += *nr;
 	*nr += refs;
 	for (; refs; refs--)
 		*(pages++) = page++;
@@ -3024,6 +3025,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 		return 0;
 	}
 
+	pages += *nr;
 	*nr += refs;
 	for (; refs; refs--)
 		*(pages++) = page++;


