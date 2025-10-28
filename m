Return-Path: <linux-kernel+bounces-873582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8C6C14342
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920F419C8800
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37E31619C;
	Tue, 28 Oct 2025 10:45:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF03112C9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648308; cv=none; b=OkXt2mkoe1AIGnDprh1jSx4AY7tpLeP7YmI0aFbAJuF+OFr+R74kN/2SLNVPu387/7P/P6yUFmohxAiiiMt2nLjWgUGawUHQV6ZNvyy4okfDcecnrYdQ6aDtGVSv8a0JHQTauCSh8Gczwaa+60xVnEaqgseosAY7F8EMeayUmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648308; c=relaxed/simple;
	bh=1E2eId1I8G1E+trRuY2A/MgKXkQh7LOZLCAHL/N/KQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pLSuo9nmoKD96O9GPKx04raJ5P+de/3i2a0xUWL5eOSLeTK15RZcGDDi/1Jh5vnIY63p38vekRpRyhK5cQ4jRSYO0xZF8UqMwaDTbDf8JUugqx5SiP0c9nALHam9cvGUQ/dT8LR7ZFOg9IZhPAksAsnsr+utUzqQQFMew6nDNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431f20be851so41227985ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648303; x=1762253103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocCvAz241FT/Jjz1sinfaWGqGfA2//VmmiIOeyXXntI=;
        b=VdzmEqsNj+0BKQ/qu06mlSLUTM6NL9FFJzm5GJRXPLSxx9MPL6P43iX1FT/SRpIDAB
         qUjZOjoZ/R/+/bVcmxuJunNtZTgLYZg+kInygT5ncRb5RJNhTZo9EqBKM6qrC99atPwK
         QYRK/FnvIYDCk65s8dwxQQZTxbCiIl3j+2z+0b/dVYsq+QHeYQxXO47w8JMZIxCCMOcX
         QfP45c89FNloRG66GDyTM/u9QPjm06EW0LH3na6RzHKWSOC2/VkyygU5pjFrSgaWv2ZR
         T7ph8zIMup4PHZCppKclzGUsYEy5Gc+whjidPHMDjGat+Wvg1d5OmVOV5hPmk/RaKi7D
         RHOA==
X-Forwarded-Encrypted: i=1; AJvYcCW8vdqqCIoudB283JDduakvnq9VGafC9lUSE7IcVk4xeCwqMowzxAL+wLvwSlalEQ7qJVK6i81RFfCPUXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpNooOSwLvStokvPzYfo7ZF5nK4xPyLQGHXsSqhj+N2KKkrp9D
	ET4ZGQ/O4IOhiBHbOADL1YRFnslv9YIwKrCY/Gk6ViMJxpCIskpDkkzqFJ7mN2dHJB2a118Nhz+
	6DmN4ZP9xmcO1XwiJDqLCjVeoZBqW3abuqkS284oxeE2y2UutaGg38yoSD9Y=
X-Google-Smtp-Source: AGHT+IGGNzsXIBxtZLAamInM7KtlNO+/Mulr6m0WjTaxGK4CVZRIK6DMEHoOak88GRmQ+3KMrMF/Q7S87hqH4TGwLQKYyqTOqphc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f11:b0:430:c38f:fb82 with SMTP id
 e9e14a558f8ab-4320f7b75dfmr36419965ab.8.1761648303615; Tue, 28 Oct 2025
 03:45:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:45:03 -0700
In-Reply-To: <20251028104158.MIVL6%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eaf.050a0220.17b81f.0017.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-6.12.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-6.12.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-6.12.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10276258580000


