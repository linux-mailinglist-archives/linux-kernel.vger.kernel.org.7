Return-Path: <linux-kernel+bounces-859925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77877BEEFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2680C347FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7119B5B1;
	Mon, 20 Oct 2025 01:04:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2AE29A1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922245; cv=none; b=PaCLHPlufbO7fQYa2QOcpxOv0Wz1fNqSFG12IUs2RK78D0qhTyf2LYfznKnf/hRE00FNQyaVLIqExBDlqIUnyznRKIg0nUNUQQa0Ws0zUfu2HJ8PJzm8fJy6Xo6XCIcXcy1s+I9WvcS5muJjdCHu1Yl9cU9NmPrUMMhGii8MlOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922245; c=relaxed/simple;
	bh=i2MqYNZvrySdVCtAa8ikFcDtHjYDN70I+XhamqnlKiE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RMss3veS8fHFe/WgWmTa1qEiKvmzIr9wExGRl8Wq3sSyQqklOEblo2+WNeIFAPCVsPgtgHE/PjjecxGDwIg8Bceof50H3+ScCpK605h44+T/7tb3Ug3gpYyMgQd8cB8llCZhQr5nPKxYOJmhhJhJyF7D6OX2oArCJH+JBFvmzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso1118097139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 18:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760922243; x=1761527043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mzU0wKQum/2LuRGf5VdXq+RiIPs0NooYzZsxD9Bfmg=;
        b=l3MzP0RUwntTDTpQ46XObaJti3EtDgnMZxvWzU9mOdDUwUBgM28v9EpAEA7AIab4AK
         zAQc/lHUIqu1dg0ZZd25orFsSiVkvbPH78mZjQFk/hcWX5cMiR3jjTFLYuXlUta/8A2H
         csh/Trbt8CzXjP3AMC/Za35g6U6LtAG6rRPgLsT6FwonZMxqk2o3ZxzQzIBMmF1Z4yPE
         bQw9/0pZQiLqVaVvuld31wW0h/vegl4tcFYvRKcUS6cj1893oSuG/sjp8S9p3Z9kqRcc
         BR4WWrHDOT5WZQi+orM55ucVDiGWs1JE9RQYK/OHiV9qxXHl7N8Gy4Cjfvy5W0VMp+r4
         K+tw==
X-Forwarded-Encrypted: i=1; AJvYcCW9XcH65k9uM7TQXJi6OFEoWoRDcf7pi877iKLtj+f66t+YPZ+XBbOb4Pm5/q0PHkYsE6MSTlCCHDxBFTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNY+HX5dhQzGTpNe/Src87xPvu6yy1uClZW6lH9Cu9gQs+TTRp
	TEPjpzPl6e52ZwVM42Q4xMfB1rWA5D0cik73XvbIlM/AU9nt7vHHO1zWMVC+p4Iiv8qqkDFt5+z
	tSX7kZUB1UJLzaPPO4k5uC08ZvA99in+8d9x/NY/ykGWOmmBBfOSBvNDtCoQ=
X-Google-Smtp-Source: AGHT+IEpxfZ8HgO84tlGHy5kvRqAgr/Q9nap4TFMDV56voWSOdFhTyNn+AuW5+eI+/mJha+JX+2f1g7e7KqeefCzVxUORvleuVnW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:887:638a:29b5 with SMTP id
 ca18e2360f4ac-93e763ccee7mr1733569939f.9.1760922243025; Sun, 19 Oct 2025
 18:04:03 -0700 (PDT)
Date: Sun, 19 Oct 2025 18:04:03 -0700
In-Reply-To: <68ec1f21.050a0220.ac43.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f58a83.a70a0220.205af.001f.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (4)
From: syzbot <syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b441cf3f8c4b8576639d20c8eb4aa32917602ecd
Author: Sabrina Dubroca <sd@queasysnail.net>
Date:   Fri Jul 4 14:54:33 2025 +0000

    xfrm: delete x->tunnel as we delete x

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b49734580000
start commit:   0b4b77eff5f8 doc: fix seg6_flowlabel path
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b49734580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b49734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ab7fa743df0ec1
dashboard link: https://syzkaller.appspot.com/bug?extid=999eb23467f83f9bf9bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cc05e2580000

Reported-by: syzbot+999eb23467f83f9bf9bf@syzkaller.appspotmail.com
Fixes: b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

