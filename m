Return-Path: <linux-kernel+bounces-738355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82BB0B76C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E497A7AA09A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3342264AE;
	Sun, 20 Jul 2025 17:34:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA9221F1C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753032858; cv=none; b=VNKYsDbqyyGw4lz5A/QlxlpkWut9dTTrYGiyFR92biQCLuwOqZCCyoH0Jta842ismRyNzAvocpwN/nP29farWKU/XVUANkx1E4jBu02WFsqN6BYcmNYnBbUzFdHBfCQ+KvjJVkLHCvwVycqOfV+UQnDCyl2NE+nhXzUkI2oHl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753032858; c=relaxed/simple;
	bh=VfMTkMp445cc0mFNu6vaqGbAJNRylVP3iILh0yQ0TKQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iuYk908bohC4Di0W+0Wk13yNcC/z+IbZIyrC8s8SFSFkwXIHtCqkiMFazCUjN6La2JO4/g2OvRQP1E+qMPJIw5ED1bP8OiLX8bVn3fnWF2Q5TFMeIZBv3azUCmC76EmMjiB4MRg2MYcuMDAVVPd075CgFNYe9A1JTbmty6afKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso74542585ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753032855; x=1753637655;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y0RIfhADzE2XCeIq0hq51ujUQWbtAJV3C/CoZrIBPc=;
        b=BAjiL4PF7gZr/xVSW7btf9Dh+QZ7P763G/j/mOLlnDrvYEJS5Hvrv8kTmJn6Iw5x/k
         SfHcAg7FbTyXooIvZfs/qaAA4fHvxz5CXWAuySmYXd+EW/98J4teEMMouQE01gwuxkgl
         OTQKPxo0ibg/IWFkfoUNvXf0nzkIcDkVU5NEBpy92PpiTC4TQtTF+YGkamTvjhxs57yu
         ua9WcHTUgT07eld8ItmR94OdKMJJA4IuVFv8BYRN6CCOIf2ST5iS+1WQqwuySFR6WbWw
         0IBzlHjS+6KqgUBH/vtskgNJqJg1Ozh077JG1m0NU9JPMITeVz1CYSl+JIN5HF2nl00T
         kxRQ==
X-Gm-Message-State: AOJu0Yy/tckThH8w/2clvw9/2nb+P58GxRSKVotCR/ftQyCD7uYdmfi2
	14zxUO/c4NMjGfXiTmSm6nMVuFKohsVOeclPCR01LdASeFNaobnQj5qB3naMaz7LIw2x9xsQtE4
	wz4lHm/q76kuFWUaPrMcQRreOTyKAD3yms5FENWCyEf0YNOdOhpKueAq2M9E=
X-Google-Smtp-Source: AGHT+IH4661d/RWPsTtOpxR1OfqvtxPTkE7McEcCJropxXkX7JiKtSiVScX91HR52+GVIH8VtZNhLwWCSFqgby2NHd+QRJxgab83
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2587:b0:3e2:9f78:3783 with SMTP id
 e9e14a558f8ab-3e29f783956mr71229365ab.21.1753032855021; Sun, 20 Jul 2025
 10:34:15 -0700 (PDT)
Date: Sun, 20 Jul 2025 10:34:15 -0700
In-Reply-To: <687539cb.a70a0220.18f9d4.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687d2897.a70a0220.693ce.00d0.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz set subsystems: bluetooth

