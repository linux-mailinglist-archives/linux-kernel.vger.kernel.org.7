Return-Path: <linux-kernel+bounces-773324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D86B29E50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1FD3A75AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF9C30E85B;
	Mon, 18 Aug 2025 09:47:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37165226CE5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510425; cv=none; b=sL9Ee02G7Kve9/1pyvEAulOooRKM8+AL/uiIvHEXxyuNrwlgKIqnBUC3OvV4myaIY/BFXVa+uZKO87H9in5rywAti0DcH9/neNtO3AnPrXRpMiJx1wUSNmFNax7fE/b9jXYu7Bd0NBfW0Oz2w1itrvuLXya6j86yE00k4UXT19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510425; c=relaxed/simple;
	bh=j+FmuxJLqFJHowEK3/yJtg3duqQ4gE9lojwmJG6bfOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jdBswwMLgHiZXBjsQ8TPtreYUiZmBKg9KJfVeW8naWCuuR/zL8icg7WBki6nZMsCxL5h312Toq3VIUxhCbxUXHwFeJKAHXMy2TyahXptvHzRwY5imtmJUYrAieSpGPfuGTR7EzQQYOA1GCpy8PeVOZt/jwdF/Rzu+PJQIP3eF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432cebd70so1079973039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510423; x=1756115223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkMjJGrkjVySoMn5WUIsXfAuu46L+OAHGE+8UPnrlbw=;
        b=FtmcSIV/U6kHofz1B37nvvAZfav4+2fpkKSoaKMAQnWgMQyvdVAjcv+J4riZVl1GLv
         4vKTzG0VZLmnzbgqz+gTIlTjTjdfaSbKMerJkJJZbH+JQTJWba45nxeHZ4Y1FZf5qaYR
         42jc6sp9sa3ImEgdQmmFLFCUy+18ligjGy0HXASlHtCNiUZf3ItrXUI/9d3EJ4iKV3Nj
         EjksbcaEXINRHmjJTykWdO/+JeNtDmxfmZfx9JrAnzkVaGWM6kGXVNjePu/wglSoeow7
         ncM4NqlHHVeLwbWSLrr/6hKCm5wKU2hmrQ609JY69RUh5mK62qxxQeDraEryWSTSjFfP
         6rrA==
X-Forwarded-Encrypted: i=1; AJvYcCVLvi4VChV90SzNrR5BM3lpFE2DNjOu/PzyqBS6NanLveVbEve9hGQi+dhVgyLeD/TDpYn/XBAnJEO5/iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGu3HzhdZWebY6cpvwipXAn1dc8ogrUN9fiCb+d5gzHFAeDmI0
	IASEpyGtzWH7j/ZxnnQnp+UtEYIhCTrQmDGGybUFvktytpAaN1YYlK3dEjLBoFwNF6OkMrdin0O
	b+c4NnzUbskfEelWEePvfnEmCvAT/UYmI/kciap3JyUB07mXtsLvU3holJmo=
X-Google-Smtp-Source: AGHT+IGWUcZwKlpR1WfhXpRXr2xT4iYjelxQ83g46H3PivCQEmEjdRaEaKvXLvfVzNk24rULoCFJxycHskTkQu7aCYcK8E5ZRKJM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c8:b0:876:adf1:b263 with SMTP id
 ca18e2360f4ac-8843e3bd847mr2426139339f.6.1755510423112; Mon, 18 Aug 2025
 02:47:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 02:47:03 -0700
In-Reply-To: <20250818091720.4948-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2f697.050a0220.e29e5.009e.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: amir73il@gmail.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, neil@brown.name, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com
Tested-by: syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com

Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e1eba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9f694461848a008
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9fab8b7f0386b98a17
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1413a442580000

Note: testing is done by a robot and is best-effort only.

