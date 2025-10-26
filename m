Return-Path: <linux-kernel+bounces-870326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56663C0A775
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC873ACC76
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E0F2D47F5;
	Sun, 26 Oct 2025 12:41:55 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993B42065
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482515; cv=none; b=GAbLwEyovivxgRlH54n9g0oVoumHES+gcMtFAoSMBOjpfzl5t2ySWWKIS5KNrdszPS50Vsb6kcTz9HULoh3zedrBiBKAirH2ziSj2jJh5l2+70kJBbTXAKd2Lq0kqzoFncxW8i18TrRfhM5llWU5YYoUeZ4HH5cK43Zy9QbqhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482515; c=relaxed/simple;
	bh=L0Wzmq6Q9SG0H6lUlVjI0Z0fbg/kHp4aGkv0H8inF9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gg6wm0RzqCcGfaGoJYWtuMahTQZX3bKB9yGVjNzoT5Gxh3vxBte98rC925DsIvowvbsAfDmC0hgPVQpksYe3iL+hl90xwDB2NygOiEHswudBdfYV+w//br6TmHm09vZH1nOF9QzvmvMQapPUj7LZaQUIMjx/vm7PzMngGyWHMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940f5d522efso1119087239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761482513; x=1762087313;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0Wzmq6Q9SG0H6lUlVjI0Z0fbg/kHp4aGkv0H8inF9s=;
        b=H28apYCrel06855do30GljYw+BLtdFqjrlLgXc/IvK+cTcZHgZD+p+NdhomyufzUR9
         UCSvPtJmtouxj9o55Z+seQbL27bOf9PRXGYpwCEC1FwBP/4BphSlCVMRXVChBgmHK5js
         mL+QnUf10/KOBatI9EHVBnMtImdj/2M2ND/9r26K++FYpsm1dUs52fv7OUomZHHWvJDn
         Ak/MfFak/6jT/J/b0/GhTbMlZO8ktO6Yy0D4LE7grOpYUFQ6hsRq5rA+RagPPQS+xDO8
         ifWA3HCLzIfXnM7atqOm/cLkrJcieAU1Tw8dYKvvgGASDSjkhYYDHvJaDIh8FNRkikYA
         EA2g==
X-Gm-Message-State: AOJu0YzYHyNlvo0JXeoZv3GlDfVOTjAvqi0MOflJQM12Dou6p8ii05Zx
	hOvDuG1TEm5UlIQts6hQqYhMXtEOiqsm8aiGTHCN9s9gdoi9IU2S5bj+xlyTQEJP0Xkf+JXDCrY
	5dQwkAw860ZWPvMAIZG0YPpYu03+AJbfbbZkhOxybAFOAgsLsaktAEAqvlZo=
X-Google-Smtp-Source: AGHT+IGht/Bkf+HLspf2+agei8eeF0IFI6IyeomoZcwdXcDyw/tOXNSNaG1RI7PsIqjX10byS7NH02Zz7OzIJzZsBO69lJpzkchE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c6:b0:430:c600:64b9 with SMTP id
 e9e14a558f8ab-431dc20f667mr165969145ab.24.1761482513132; Sun, 26 Oct 2025
 05:41:53 -0700 (PDT)
Date: Sun, 26 Oct 2025 05:41:53 -0700
In-Reply-To: <000000000000a53ecf061f700fbf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fe1711.050a0220.3344a1.0092.GAE@google.com>
Subject: Forwarded: Re: KMSAN: uninit-value in bcmp
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: KMSAN: uninit-value in bcmp
Author: kubik.bartlomiej@gmail.com

#syz test

