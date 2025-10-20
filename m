Return-Path: <linux-kernel+bounces-860254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609BBEFAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1BA4E9DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0C2D9ED9;
	Mon, 20 Oct 2025 07:36:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755541AF0AF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945766; cv=none; b=I4bmuqruqfCFUJmPmKcOr6gjdrXHEGEAuGEx7oITxBBa9XjIey9aa2PRURAtNHdZy/qMBskOzBOJfK1z5dYVDIe5fop5+zmkcg0uEQg6srBltj5hgSWmFWYW2G8ZiR73U6n7WS/NUuGTp0c4cjNy3T+eNUsk8UkcORqZogJmmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945766; c=relaxed/simple;
	bh=Hc30SOTSllPIle9i/ltlD57vNOaIc0pQLuWlXd+63n8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=igM4TQ2jHHp45XJW9U/qdVv0KSnstr4icYkfbC8CdQGAdOe9iNN29X++FH3YLQo68dNS5vOvhxdvwiAnJQOpsZL3gr3WlilZjLYPG7JiAJEx53MZxvhMFHHt5+kgDHa9fxLk0kqZCukpQ/3hUDQWOakbclDS7Y0xhmGRDhjcFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940d88b8c15so64034539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945762; x=1761550562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmh5/xa5tC+fVqIBDLwlNFntl3gVPxIREFA9e8Tg/eI=;
        b=eu1kYlkTnhG+DpzlanYAh9aDTo6wDzekkhABEG2DC/dUurnwRMt25N+MJk6meOMimz
         JwosmcLbDRVjm80tf7ZTqjCphfNyAg6S/UhoxYcv+yr0KCcOGrfJlj/aE4mgiNN3zqe9
         vORDH4oRjptKTpnCxZ+cwdJMIZ4NbxJT2aasegJxrDlOIPLNxx1UAF7STsqV9/8N4Zis
         smfZPJG9fGZDCpGfMnIAp4qh2G4TAn5uRDI+4GbkrgGF/ksvTpqPs+poWkeCLr/GpIZp
         UOoA+mqJ7bjR+6D5tAqK/ZI3B+ggdXou0V1XtsLqXi6DmO29CA5+c6K46YUv28YWsX2l
         NISw==
X-Forwarded-Encrypted: i=1; AJvYcCUXmBMA3JurdCB24EPogZ6WxKi0ucQAePpCr5Mx8GY21Xo6T5Q2xpb1bBqcL80FU6VXJ+Umanzvq8B0CR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1FVr46hwxchUM3P8/EJ6W4pnCpYBlV+vVNkagEp7r+WHaalf7
	15gVqCNUL3yi//f1/B0zsAY7jrG+cnPFRuwl2ThI1gAI+SW+zEu8HtXAzHKMkEEM3YB98EttIB5
	jw+WKsfThwMY6ZeISiMzEd+bNR3Lti2CXY3eesIW7ZB+r3l0T5ajuGehp53Y=
X-Google-Smtp-Source: AGHT+IHUFQjoHonYduiujFctyPWsDOxpnnroRdmN6ZZJotRvXqG0LXANOyRw6lon+e+lvN7dM5B+ynogR5qk07eB7FGh+PM7x6Am
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f86:b0:940:d4cc:1a03 with SMTP id
 ca18e2360f4ac-940d4cc214fmr504315839f.10.1760945762548; Mon, 20 Oct 2025
 00:36:02 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:36:02 -0700
In-Reply-To: <PH0PR04MB7349DA5D7A7A7FBEA8601353FCF5A@PH0PR04MB7349.namprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5e662.050a0220.91a22.0440.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: clf700383@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104b5de2580000


