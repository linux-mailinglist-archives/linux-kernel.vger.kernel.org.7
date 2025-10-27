Return-Path: <linux-kernel+bounces-872638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9582FC11A54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADED63BCDD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1665A329C41;
	Mon, 27 Oct 2025 22:13:45 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8C2D94A3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761603224; cv=none; b=qz60nokx+OEsoXaKqPCePI/30hEEIUx0uwD6oqm8Q5GtsaNkvcGR1bDdYLMLpMR6xw8RGrfLh0Q3fxI/Uflszq4m6RDGQn227ajEslo6P0bXqHdDeezpXOslUWKtluXxhreF/YrFMmq6IvSvy3ZCfXNZ+slmgB7wNAernrCUF3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761603224; c=relaxed/simple;
	bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VKs7FltMkHeChTwqEHV2BV70OqfgNb9+zAv74oQgbLbje6+EAE2szmhL+EC8TxIMBUAngBUSb7K+2JZKjXsODIsTcnGizLgFtOHfLLDIL9oPTKwFERfe2g20gh1O64uoIL5hW3m0F61Z6urtx9KQHMuZVzL1oUoEuQsUwONx9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430ced58cd2so189571775ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761603222; x=1762208022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
        b=GEo4tHMPNn5au0RbDbSdT0y962utcTMOKw0ob/M8yxEKRcZhCclKAYktHIxlGhDM9V
         oa7/Y3Fuz95FrgTeJj/Chrg3J02i9AQ1+mT6ygINhF4FJ9ONE19oq+kVb5+akaUnEoA0
         km6xXXNUGrKXMY771tgcCr3uETWSCtQ72L4XoW6ncz3HNXZmovHNVgDIFKiMTTmHyOcD
         xa5o5kpxP7QhMnWeApEHDwsVbU8bi8nxM7TddyGSvUo0Fi9VRyvxLVvHIhnUeFKSE+rN
         xMKHXhb7lRMrORTaJqSlQgLXvxD1UbTiqbBigNbZNPb2fw7lIYkVSMabMNtx7hJ63F25
         RTGg==
X-Gm-Message-State: AOJu0YwyTiT5oN8xwBqlFBWLBf20T1Iw+ARnAlWC2Z/R3xSgjbaWbVUx
	sZDr+/OCC710TQwtY70t0S6NpfClfLpCdtgFwzjsKFAlOeoZmG1zPxhmrEqV8BrVRhTrJkD0abf
	5jzH4pkhmcrjZWwQ6TvHFe2pLPmIPVou1VAcmm3AO1e6hOcgfrG7VweGB3hg=
X-Google-Smtp-Source: AGHT+IFTDsEpehPXr2n42WpJpBYd8DE3/MDlQClpWm9OWI+LgJq98WsDKyFNthJmhRswXIcq14VfhdUxUdOMtiEgdivegQ2dpuuL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3708:b0:430:a183:7b with SMTP id
 e9e14a558f8ab-4320f7a87b5mr28901835ab.3.1761603222453; Mon, 27 Oct 2025
 15:13:42 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:13:42 -0700
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ffee96.050a0220.17b81f.0002.GAE@google.com>
Subject: Forwarded: WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in f2fs_delete_entry (2)
Author: zlatistiv@gmail.com

#syz test

