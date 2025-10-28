Return-Path: <linux-kernel+bounces-874695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F8C16E07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3191A3A8850
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625132D97B7;
	Tue, 28 Oct 2025 21:08:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0A6FBF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685685; cv=none; b=ph0KjORJYcsR4vdP73K3FakLfpQpGSWzYlI2c0B3UARaDGzfehk2IAxgOsvLxXUCSTuL6zkxdlI3cvkdE79xWXqz1nQLZIcujQv2uwGlhSvSPMh/VfqFTDwblIQnWj8DsVTELlySM6qmqSVI8slE+UM/oxVuF9EQidvTHeuuF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685685; c=relaxed/simple;
	bh=aKdM3ui5YJpPFCa+m5L7voBSPqTR2by/r58YYzKkeCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AztJ9wVlteUI69XkoEC9DBU6SxXYaEFCTlj5DljlxnmBMzD85kWrtHbkMtSG5wjfjciNSD49lQ4vjhfYD2o5wulvcPRF9v5s71aewRlekjkgtIwR0+JcUnQRh8oTdsu0TR/HDux5m8O5al6MS6/qg9X7FjaQce5vAX+PpwCgogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430db6d358bso260649865ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685682; x=1762290482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HvpCybIKzIQ73/tNttfU7EJlTD4destOryDp7eKWh0=;
        b=HOE37GzWU0Yc+nzO9+XzaUpX2DIJ69xsfrcEfkRvkZnznjFX4ZJJwbIBrhTtb7OfTv
         et9t4cVrYa+FKjdluBSAw8K15iPPJCEbl07TO0OYzEFuyq+hDXxuln33h1D2b8QRr5On
         NufkVcgjnstlbsZeGvvfzoj386ZmEGfkYcTDItO+PpeR0hKUpmeFsJuw5Gxix+ssuFfc
         rw72hegkSZVy6Qf3GxhN/EnRfNjh9uwqUsgfBIH1ZLli9UBe/5fkDOUBrE2vYway9fqc
         lwBnfaki1lJrvXS3vlw+0M/UurSVY1zsMAYqssWQ57PqjYmEXRbtTww3DgBspiQTkZQt
         K1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWy0Abu1lOZhfFSkWZP5QKtnlKCnouEz4tBB527lLJauY0pc21BON6NGQCThOV3neOF3JLfGgrhGI5tpXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcy6y6l68zwyqJzDr+EjuJG86UkxIBRGAFM4jszM0p4xhkFq/
	RssTwGjfakK+ZEQ0CdD3ypZ4bGKenaALrJCOm3qgkOWN0RjlKsVEd8rO5R9woBjTsnqL7X/7NfG
	uipVhBoFu+1FqSzfHQ0IUriWZSKW7cvzARjVyMY9GJwrK+iUUJEZzL+EVG9A=
X-Google-Smtp-Source: AGHT+IGlSK1tM4/J9b7p9sXZGK6RkIlGFHa2nP9Y+S1Shr7h0I+LvZi6GLK7ki0wh7DtNeRQ0DUcXHuU8pWpu08emUoriCwkedjL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398d:b0:430:a65c:a833 with SMTP id
 e9e14a558f8ab-432f906b7a5mr9384485ab.31.1761685682685; Tue, 28 Oct 2025
 14:08:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:08:02 -0700
In-Reply-To: <20251028182206.ozFQ4%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690130b2.050a0220.32483.01db.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ac432f980000


