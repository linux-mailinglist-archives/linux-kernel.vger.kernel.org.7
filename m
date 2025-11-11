Return-Path: <linux-kernel+bounces-896104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2790C4FA70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F77B3AFFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007913A5E8F;
	Tue, 11 Nov 2025 19:55:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370633730E6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890903; cv=none; b=XW6Q9MatzAVR6S1ZJ0nWoKKJh03eGX7KNT9qB8XnJXJpTxTi1CuYPK9k+PGTzM6/olzUJKt9KOP1auDBSqJMMKip7dOb+cT0tJD+LzF/eSN05mZ7TB88rQoKenuPlKwA3xYlprqoPkainK1Jm6wJnGGmC/CKMacjRq2Od0c5GGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890903; c=relaxed/simple;
	bh=/b3A+J3p4vNsOpsr/qyiCSxEZvkZ6yKbQfF++K0/h94=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BL1ax0k/tGg9HSZCrBhPmt3UsLNit2UytkOG9N55JusqGIJKpQ5qyH72UpktK7n6wmC3IUmFCp7RBQRyCjOSeDfA6d/CHNAZraJUNssODCy4KtcMwoemePSqYQ5iGEfd5HazQjyim7PCV0czgXbf0HGFU3lL2yF14u8QnyqmLm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433783ff82aso1752935ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890901; x=1763495701;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkcJir/AGs/NDD7lwcNEuWgp+bPwIs7AWKnvsltB9lI=;
        b=GfUDkn7TjXf2rG2AGsSups/lW/9RmHp9OmLCo2TLBKeLwe7hEyLhsUOuUE0VmVvLnW
         dk2sEmH5hpLeh12iKE1wvptjmc8kH90NR9UDZod1eOekTV+hH+/4N/yLVVS/nk2lEWH2
         o4kDBJ/uIVp2SNgATbbPrvbcS6kcix7Fvj9Pqhqp/HqJ2jIpAN6Av9RlXenG9llnPIHS
         Kpm0+qEyemdVHFkb3J2ockwl+1GkiZfH7AHlqwvzephrkOfvuwhHKtpUoNNUvFnvTnNl
         DyCR9EPTzmh3WWUMySmFd+RDo/SdfM2kXBIb20Pf2fPGRxhNWzSB5plBrBh0D1bkraBZ
         rPuA==
X-Gm-Message-State: AOJu0YxhZYRnkgh5V806ZV1hF+INDbckZu4FsCXdbeWTyCkkr6PuOsLj
	bPM3iNaf/+T560pu5rC4mw7OIuWV9Bs9Kw7XQfNwDXVAByOwnos8wvC23d0ATnC6zRPwJUVkkAs
	H5QuFmI+7MUUkpR2BTPROJTH0TeZFSspIFVLc9geN1pGWy6Ls2zTg9WT7A+w=
X-Google-Smtp-Source: AGHT+IEiDS+nSC788SRPxYkhBUrK0RgqCDXPFnnz1IWQMv3KwKCujvl3VInGuexOcZQx2UucNf4Q9TBoYS8+8IiHd0/COckt386k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a81:b0:433:68e3:7677 with SMTP id
 e9e14a558f8ab-43473d2127amr6523935ab.11.1762890901416; Tue, 11 Nov 2025
 11:55:01 -0800 (PST)
Date: Tue, 11 Nov 2025 11:55:01 -0800
In-Reply-To: <CAMz+-CMX9fRx=L+r2AwvfMK6NhiFJ50fQQtp=Wm+jR1hPn+GWw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69139495.a70a0220.22f260.014a.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/wireless/util.c
Hunk #1 FAILED at 963.
1 out of 1 hunk FAILED



Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c3b0b4580000


