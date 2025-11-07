Return-Path: <linux-kernel+bounces-890418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119DC4002B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3B24E3993
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75122538F;
	Fri,  7 Nov 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h95Veo2Q"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8011E3DE5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520495; cv=none; b=nwNIf3grq3e9FKRXbXow2T8EqcfIhVxS2SyU+GU89LBs0cQ1IeTwvjG9rBJgQYMNv3pXEtwfEYvveMKBIzSRcReqH0JSFA/erozWmvn3i/brLuvKGJjSNLfMRRDURBXz/qc/D6DyvJUmsgexXoKvmV/iGH+tt5/JrdxADo6b8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520495; c=relaxed/simple;
	bh=/9zEo37xXtXmMm7pfbmvKBJmh0YoopjN/ESZ+hB+f2I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Hq/FeKxo3axEEgSL7+jec7S4DMBm0blsHFmSCEvEFGSoLBHq3Dx764qUf/O5IzgfM44xNTUm7fpbOK+F7hzJtlgA5okxq7Vig03M8ZUcabbWs1vhhaDfLY+iFVa59RcAl+aBXKCrEwet1cMMP21CQUnyMUIucimIGwk08B+58yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h95Veo2Q; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762520481; bh=1ZAnV/SuPIay8Pw4JRN71gMOCxNbyZpcURzE/SP/HDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h95Veo2QfmY9s/6tue3aBAYMLXIzwdmpayD0dSiGAzrTdJac6mREqFwjFTAOYBmkk
	 5R1mZRE4f+0PUGOmkfDMmZ0nGcjWS1/XS8cOvSIu8Dlughw61eYWwZF4XlbcXv8KrF
	 0P8wwpDVYpJGRQbqlJiXRdB8N3J2h1EXnKIdAhdU=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.201.7.117])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id C33A061A; Fri, 07 Nov 2025 20:48:51 +0800
X-QQ-mid: xmsmtpt1762519731t764rkiz5
Message-ID: <tencent_884C1769576F66DEB36003674976C3A32405@qq.com>
X-QQ-XMAILINFO: MEx+xBdGVwfVvMRmOUtQqgS3YGAlBp0SedT+I1ZVF5sCCpLh2RkJo1BKlwXUFR
	 MCx37C5Z/5iNZUKwB3imbx/IlGNCY7QbHAtudxMrjteEweBdZFVo3f+fVmKqPfDSAqdtqiXrA8Pu
	 hbRy2gf4QmB03J8E9wdQfvATRh6wEwl+Q5yIiuf6eq2ItTWN4FvH2ynjRIGkbmRWfYjUDDIlzMNJ
	 TKVFJQ3S0EXYpPWDds6S/I9ge6ykoGWKpYJAzMFf73Tk9pHGb9I2qCmdywSk/MqHbupPhruPw7zE
	 h44oPBw8k7jJMWOJky6nWSzsabLRF17uQ9ZApJrGOIPNilMlFy7ZjQZZmYlj8e5jo98I14145pFi
	 RYjxFl1kzSD1uOsW8M5isg0vfJhpTC2MGgc3SmksI2uKXDYfgKwCq93HOiUxFQ4pTqvblz0VVbZp
	 RXS7oYPZ7iHJGazX0EoXcIxtuIPD0UdV0WCmbHXrbb4Rydd1a2gEmygjtnuxa+CTFh4q8+6v7tn+
	 QDxqeGX0l+lDMigmn5ioVsf8oBd9WQ+Jwuu1uIEwtE11heRxrTdTkvogfwTFURXFvICebGlBL2Bg
	 PxfYFS+gMSRneDTzI8E5k+GTXylLydi2W8ifCN7KDv77d0dnLL8hW6V6A8fdfV96Zbk7Otxa1HZh
	 +v052JIuF5a90lUBAxvIB2MZKSALOToD05fPsB2tJYtByYqTUNPvExRQDc/3AJjC2kziwQUWWJpI
	 AQlGCT8QlJGHZtnXuBEcgDVWWEHBdqD5qzBhrLDH91Xn01FNPi4PPUP2FR9wQ3HVrye9vHFEknYN
	 ndLoGpG1hwgCevSgUfmeI8+uw0yBZs9RjtGFVfqdB5YJMK4obQ/2S7AxyyX3tXXxH4/iuWM9fCcr
	 4g8uhHZuvDSKcWD+zkBVgyTZeQ5bCcinAn28oql9QlnN71E1qnUAcUi82/dDsPetFxFe/6wkdYmH
	 KXSee3lztMrYg4QNM6FWi1PiOqYCaV
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+72afd4c236e6bc3f4bac@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [cifs?] memory leak in smb3_fs_context_parse_param
Date: Fri,  7 Nov 2025 20:48:52 +0800
X-OQ-MSGID: <20251107124851.3827801-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <690da014.a70a0220.22f260.0026.GAE@google.com>
References: <690da014.a70a0220.22f260.0026.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index e60927b2a7c8..0e1949bcd6ea 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1435,12 +1435,16 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			cifs_errorf(fc, "Unknown error parsing devname\n");
 			goto cifs_parse_mount_err;
 		}
+		kfree_sensitive(ctx->source);
+		ctx->source = NULL;
 		ctx->source = smb3_fs_context_fullpath(ctx, '/');
 		if (IS_ERR(ctx->source)) {
 			ctx->source = NULL;
 			cifs_errorf(fc, "OOM when copying UNC string\n");
 			goto cifs_parse_mount_err;
 		}
+		kfree_sensitive(fc->source);
+		fc->source = NULL;
 		fc->source = kstrdup(ctx->source, GFP_KERNEL);
 		if (fc->source == NULL) {
 			cifs_errorf(fc, "OOM when copying UNC string\n");
-- 
2.43.0



