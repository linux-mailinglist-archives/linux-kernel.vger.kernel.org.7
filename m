Return-Path: <linux-kernel+bounces-873566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5DC142EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68455189C9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CC30BB90;
	Tue, 28 Oct 2025 10:43:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71A230B51B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648184; cv=none; b=G9BNX+h7KjO8XXRQeErQGQ9pjYTcY/766i1k/5BhmEeNo6JkiT+d4BPb7OUddmgyhO9kLiBySXUx9JyVsADTw1YeH58Z1mf+FPWoMRSHb03pdxXi3dos424xfxTJilOmmhw9lqgTuuGi+VLGTrn6GWaGcbh+uiTf1X7MBNFyq2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648184; c=relaxed/simple;
	bh=pGevGQ8mLqRF/4LvTp+2vq/l5koO9WApFvectUDYrtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rdzk5FJA7ydTbqmP64ZUKw6mUHApie4uK5RYmqsFqzKpVTnk0QhFHpupFZ2exHn8PwfrNwJjn5L+mi2Pk9XRjkNBOh0/hQzmCVcd49mCTAPi/T9SnRXA+WnqgIld8oVKBssDL7I6KL7wFnBwKhPapIQ/Afu0lJiqzapRWLC3FLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431db4650b7so79838105ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648182; x=1762252982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2GyMSVmM9wGW5PduObVsvA3vNZwJDOeRKVdKvwSzoY=;
        b=E0dgw9NvY1JSOXHNew39rgGhR5L2whOAOp4JpdXaetWR0MnCk/7k8bGzpIlgGSJcv0
         HWFv+roM5YZlL3ZVen3GuPMiiKJpv+o64gALffv6gWkoaJXdbKuiwRHHihgkOzqdZ0YG
         pPH2Bf5e48uxmiUVlBe2C/4uIv0lbx2OYsa5Uub7SGUfpRFhPymxWFvKNqovIsYWHy/2
         yQnuomhAr+IeGLN/AfVX2/8EKyq7TPf+YCJ3OteNAqdsh7vXEndvlt3bCxKEWwDatbLL
         28Wh2cA6q4FwlhBmXF4FT7vQWML9bKxQ6UaUAsWhTW902ikUxFo3pUWXiK9iEEHT0/23
         4aMA==
X-Forwarded-Encrypted: i=1; AJvYcCVAUNt+2/p9XQGfP/KNZsfbRlKU/2F6Kezc7aZaRH7QOMCG3MjX/wsFgHlxml45jWf/Tp8y3O2SQiWJv5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaobiZryS2trosnmwJlcuKNouOcsyAhbRYeq+8pX/O8EMwnCp
	tlKjMpQ5cG1io/6ZfYjJLKZDiW1O39I8rkSa2XM4S7OOSshvb0DWeVsHUJhWU1VOkB6aVJmS3ld
	csm/XIkcP2vb+wJtvUc9jF9RRTx4cdc+kJBQxYnSwAmDbtP0pEpjabZA9nWw=
X-Google-Smtp-Source: AGHT+IFBRa7HukYmmYc30skoiR4jitfFiM64aEauAH7bV//y7Fd/dCwTu0qGkhSLaqm/s6/vmSNintfRHHeGb3FeBsTkROzLfPgk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2603:b0:42d:8bc6:d163 with SMTP id
 e9e14a558f8ab-4320f7ba42dmr43278675ab.9.1761648182314; Tue, 28 Oct 2025
 03:43:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:43:02 -0700
In-Reply-To: <20251028104117.mg9_S%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e36.050a0220.32483.0181.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c067e2580000


