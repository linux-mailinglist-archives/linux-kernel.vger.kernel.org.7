Return-Path: <linux-kernel+bounces-890215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA8C3F7F4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6AC04F6DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082032B995;
	Fri,  7 Nov 2025 10:33:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7432AADA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511592; cv=none; b=BZq1DtSU0pyP9UcoYnWm3bOyXy9+sXF1npseqf0Qp87A26VYaEhNuk7Ung6a/3d/+8lOAVkKFZfeyXZI+34GX4H6OKlyHGNuKf7IpIy888sZu1QuLA2DWwgauFXHTo2oX8U2t3db43bZEmyumxmtVZz8XGG8CZzqyh3nSWKwz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511592; c=relaxed/simple;
	bh=KxthZOasbrpZ+pVPBecdef/UXldai16qXEgHfi0TUpE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ePy+q5D+Cxb5niX0Bz85z4JHh3kXPB4jpRYzFRI2mrcBGGCJkfFOc8ArlYad/Lowqd0NEvauxijXC+ugWn9psA84JMaRxTC6vv8gjlBAG3jrHfE3EqYhuJ5RDO39KZDZJS911zsE+fJ3GWU78LMb6iRkLko4msxUepEHrgRdlls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43330d77c3aso19431495ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511588; x=1763116388;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxthZOasbrpZ+pVPBecdef/UXldai16qXEgHfi0TUpE=;
        b=ZXAMgI0gLNtzcG4GTTkOpaknmuyaKKvjHpX/iNaAW3CYIw1kIgZFkDWmO8BowjOr0y
         bchNFHAuiPrjKb7BQYbAvcfOh0AnJR6cDZoyQcyGPk5jbGzeWBDf2ETxGl6iPXvChE+X
         YbOPPMg+bDqgF3PcONIetHTSCrLHJI+XnLdke1o3Pphwag7Kc9g47Pm2b4jb/yPxfCh3
         LbsCCwX46qqarW5KQRPTRWGWeQNoz+UtSVebBdG9BZT8ScJWd9mTmoTLqruNp8wEkIvN
         4kQ7FvixbS1ekoBX79dGuJ0GoXoIgADXNyU3oFCadqrpNFVgevhcUovRS1jVqeM7oV79
         WHyA==
X-Gm-Message-State: AOJu0YxIwvIS1ouWobQXLuGBOvdQBx1IVipN19iy5rA0vqsd0WN4XAhJ
	fJ+gh02mtOl9YhNYvIsvsIfSsCs/p7d/nguuXVam13wdXpkuoxCkgTSsX6UFjHX5vL8nFK9HsKl
	fNdb1c/7evieYZpREGoZKJxB9ztdUoO6UnnBcdqX2W9z5yX9IpwLVDMPHD2k=
X-Google-Smtp-Source: AGHT+IEbAPrV1fPXXWD+y0XhG7iXk5nbWb8TaVuJPlX3RcMgwDDRg1Ujb2hG9g8ndtmXjsXOwWo9yOR+8YgR8UKA6VUWctmIIb/S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:433:3034:e88 with SMTP id
 e9e14a558f8ab-4335f45dd01mr36226655ab.21.1762511588493; Fri, 07 Nov 2025
 02:33:08 -0800 (PST)
Date: Fri, 07 Nov 2025 02:33:08 -0800
In-Reply-To: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dcae4.a70a0220.22f260.0036.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging
 request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
Author: yun.zhou@windriver.com

#syz dup: BUG: corrupted list in dbUpdatePMap


