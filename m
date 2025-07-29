Return-Path: <linux-kernel+bounces-749806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA84B15310
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DA018886CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1142459F6;
	Tue, 29 Jul 2025 18:47:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405E22759C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814828; cv=none; b=ZO8NoMuaLl/ggTQ3fegmbFi8OpmVmLirBF+reZDJCFpQswYBOSfevJ/WW3ntjyt6i5+AjNnFO/Sxjy+yW7N44GilY1H3Wnkuho1xlmQFsw9Xmh4vXsqjv0TmF0Oz9UCG/6li7p3sFMCqruC0ZJ3giXHAOQhgaOcu3nzdc16H0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814828; c=relaxed/simple;
	bh=dJquwTid9tF52hRjBWfKnIo1339t3mzBrAkjXAzfhbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h738fKLG4x0no/7TJjHuXUCM/g0VpNA/15PPIBQI/1iCC87GDiCgU1hALXGhErrzs712GRUZpbMfquSaRDv0m/D3lDZ1ydhjwWX6FU9PDnQl2O43x8kyln1fIY0kUZEiZQvOUKtoLVrcJ29fyO2PSP/pdC0ytb4b2D3AQSWPAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c2f667915so630345139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 11:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753814826; x=1754419626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKd3St0RrZp1EfD+ZBL0RqGv8txDOXUCQcCl+2+1qpU=;
        b=Fp1+PIFPDUPk/quwdjSUm9lavje88VbBHMkR5kEiAmExhBtCYcUaDzG0mN1X47tjDp
         BUGsMlz4CLIfJXsoH+R8hgrYcEp7xUyfk9nZMIx5s5vw/dlM1rNl6cB9epajM5TKnD4T
         RCCU9p5TX0WxKx8ZLm4D493SRqnT7j2zMZ8syZAyrHQMtiUfp71ps31hwzQrHPwfsJZc
         zIxO1GU2lJFvTSr6hA68Q6LbaAbum3+/SjCrIVHWiVJuZXOmKKQyi5KANdBnraPFxzqW
         q+TmdonWfDbXsT8k0SfyPeVXrn765MBjJNkCO/DlQCBoFmVASFSikb1uoZcHdcMabEyT
         P5/g==
X-Forwarded-Encrypted: i=1; AJvYcCXADO3tO1TWRo9lnLkDY/Tr/p9r0zaSai0JMOhmT5tuq+Q0JXMCyZli7++mj4wee1Xhd2iRsjtfufa5MC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSZ83Cxcvr+Xmt5cBgLb2xyez+MFDp8FjDzKgdB46h2ilV9fh
	nNd2LvmU7a0m7k8uQS+TzrPyORU/rha9NfPdn5lb3dDT95GXTDQ3WU2sDsNF8ZcgSuS1Y/SXdko
	d/8xNB9SLgBb4zilHYt8wdUj9xs2eQIsuRiAHRJbJxbRMq3jx349t8Lb5jUk=
X-Google-Smtp-Source: AGHT+IFEGANFC6sFs0qxttEtpboZ4OLIeGa6jj7ufGyldWSrrqMfY3EEdsLhOqh4ozMAOoH19V6rVvg6f8U2ez4U4YcsJ+stxzpm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e82:b0:3e2:9f1e:e291 with SMTP id
 e9e14a558f8ab-3e3f64ae682mr9549805ab.21.1753814826062; Tue, 29 Jul 2025
 11:47:06 -0700 (PDT)
Date: Tue, 29 Jul 2025 11:47:06 -0700
In-Reply-To: <aIisBdRAM2vZ_VCW@krikkit>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889172a.a00a0220.26d0e1.000d.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
Tested-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com

Tested on:

commit:         86aa7218 Merge tag 'chrome-platform-v6.17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb74a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6aef71a615d0cdf2
dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b29782580000

Note: testing is done by a robot and is best-effort only.

