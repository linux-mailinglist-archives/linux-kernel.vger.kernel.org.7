Return-Path: <linux-kernel+bounces-873572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172CC1430F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8725E0FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECED306B3D;
	Tue, 28 Oct 2025 10:44:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60222304975
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648246; cv=none; b=Ho6muJkgxSUNIqWA37Fhy48w6smHbq3DH6KNI/9OoPepVxb+SSvdEFYzULKpza+5fN4fzxQaBUMOL5mCcTWB3Vk87IZL9s3fJXM4eF88uMVsN4pQaYXbwWa6TRtY6xfH88T8xmeDZyh3gvtDBo+TntiIWejMYz0quFgopJa0b6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648246; c=relaxed/simple;
	bh=SswZ4KWXWvs45SPMdRbz6YzHfNaP8hO9Kk8j+ww36N8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eBqU6tXCpIKetR5VrL7TAy1z8tA4Us7SwWxQlrDWb99yFdLMh4UaCiIY6cu0ujsJkva9g9lmAElxu8F0UsXZyXw7Rwb2FCFMSWl5xoKJzvbNRsFeHjtT/6yojai1D3C92ory0qITTra9Vf7gXrB8GeLc5pA7nDFb0nZpApKntno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d082fc3dso188331735ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5Zz88tRpI/nkbBEcGQ2XrE8HXZdWDS7f/LTFRWcbxY=;
        b=cSU/JIEL4KcAYd0PQZL1VzrVRvZlmfclZE4IhU9GaCslVbcTSSxJk8ctVZWuELL59n
         LZhSkWEJdUXQkMrLovuQfnAizmZJZred4mRaKmiGPK0wY82/fYScRUFDz7FvYYOQVBGM
         6X/VPbkT4AmSStYsq5ngAD9EHeQ5YO9aFsm1QfmWkjIBCCy0IjNSMilWOlVMqayxajWn
         XO8k2LKKn6QV1tzVBXOh7Ul2nrbRAXQZ02LkN+EtmMKmke4kXvO86nu2nGc6B1RgB4fJ
         /SDekldMA9ldnRSZPxW1ySYI+WvL18n8Trk/H86a2Woi36jTVcN3Kyi0BYPIop43XER+
         UXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUajLdt7F2WpNKGXKWEAdZ1E5RJvQ25ibK4ppAAhZKSRL3uIlHkN8xhrvsF7UDqNvionk4H8kTV+/vOGko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YIDaX7TveY9HrZhlHNuS3+3IqnxaF4oaPC0bF3ZPxBNrcRms
	QpHLPQr6KRcEoxm05io8rciqTahyXgjTbcBj0kfjnnb7XKe7Ngp9qN5S4tNR8PIjJK2QmLYNtzC
	MtUUM/8kKu0ScWh0TkJYZQrO4R2RhVaPouWlj6HmaQVh02LANdODPV0rzuEc=
X-Google-Smtp-Source: AGHT+IF+CfA6fVNvUgdAs/6l5a5Jr/MrciVcqOys1K7JGRh7ljVpBsVwVjIlqP4ywkfJy54rOSkFO/3kEQKu0Cubj2/PxOz2B3My
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:431:b1fe:147f with SMTP id
 e9e14a558f8ab-4320f771042mr50514415ab.18.1761648244491; Tue, 28 Oct 2025
 03:44:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:04 -0700
In-Reply-To: <20251028104006.trzAA%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e74.050a0220.17b81f.0011.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11fa5e7c580000


