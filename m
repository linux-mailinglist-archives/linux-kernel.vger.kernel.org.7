Return-Path: <linux-kernel+bounces-873573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EAC14310
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2305E75B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4430C609;
	Tue, 28 Oct 2025 10:44:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D5304BDE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648247; cv=none; b=EFwb0E5CzyrtpMVGqedqRnuvECt9+USuEg3mFiTlb2ZBZnbR4d3OYlhJeAN5ksA1pHBssqXPh9+6bh83OqFSx5PIXmBnL++ksEgBkWQLrpKuk7EokLHsxtj6BEXY4gMIMfQ+7+JpL3MhjU6NI+1KQI827nHOkaa6dVKJYtY9JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648247; c=relaxed/simple;
	bh=kZLywD5bZgoIej5xgwiSGx1trO+E+kKwbyyL6jA4ezY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dlRo27Gy9GptlwjXRGKhjZpQEnZnEh2Verlkhbm6RmvyfgpBS9RRX5XFrmGaf9mbdj5ZLuVk/Qn6G1iqgMTQ93TIs1GKIsfwgd2gtp/TDkXu0ZS2yJBPWwB1q+6K5eBf77mzKmkqUenI5hDGMstsRdYyi6Xv0w1hUrq6iv3woV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430b3c32f75so60494725ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648244; x=1762253044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGIj7Q6RVH7kIa+R+WM7Dg98gZ79TgnKpVSMrxC+Tx0=;
        b=kc67p4c3SUyK7UW63fwbEOK3jf4ZjQraiu6H4Dl0do0bNi6piA6wJfcOOQrx6wQm26
         x8jQ+yyUd9azHFT/HCOEFXFdijmMhHwSHwIIyxz1ZvGonlOzFexJVKHnPc2b6z0ahfmN
         7f9lRxCcQUiJA9SrypcWfIa6mtss1btSHK+H4DNNVhRSIDnd3YyL4AOGZcy3tpzdfljJ
         FL5kOXZQzUGIMfdYYduqB0eqPoDeNZ+fO3RmAPUKIvt1idIPC4mQtlClPdMtpJQ/MCE9
         /8IlZ8CNS7wVRhwByLDd1flWG07vmTmL6P8ElrXNkvK4c5aI9GXyX9vd4+NulZRU0jm9
         NrOA==
X-Forwarded-Encrypted: i=1; AJvYcCUQpAr3z7FDX1Neeww/DeC1B24hojQCwPlLqVgzJXNKlO1fDBfKo7uFkXzHLUyYKa/ZQi1MNbXgeWFdAxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtD7lxzotsqzizhdjJ8+C8DRBXPtce0J0Q6U8VoII+AUlSAVe
	an5Ipu1ajP6DE9/bkKqOi7GH5loO+DAdPWlKS+AgbFVKF5/9/1V8UuN9dZYhesNZg97Wb8jPiTj
	tbtdapG+eJw4WTOWlXqXWFcmlE2W/EbrnQzDAk0WTZS2pMSg8O18EEieUb/0=
X-Google-Smtp-Source: AGHT+IHhmESMf9naLYLX/P48sVnkyRjMMzjPR3R44rP/l8W3JxeQlOJW2iCNjhb3Ew7GZZjFZX3ad30soJnfMCW0X1vR7S79mphd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:33a1:b0:430:aedb:3719 with SMTP id
 e9e14a558f8ab-4320f6a7730mr46489545ab.4.1761648244808; Tue, 28 Oct 2025
 03:44:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:44:04 -0700
In-Reply-To: <20251028104121.GYOIU%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009e74.050a0220.17b81f.0013.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.1.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.1.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146b832f980000


