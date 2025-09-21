Return-Path: <linux-kernel+bounces-826195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E7B8DCE0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805543BC2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109112D7804;
	Sun, 21 Sep 2025 14:24:14 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7986342
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758464653; cv=none; b=d31J5JYm1bK+GchL9YPRweI3KAycxeNnjFZYsCQWNkRdWLa8BHDgKJFFscsd9cMLk/cOwcVoMj0mhKu93Ph11nY4O45fpZ9BniiX+SeAGmUxcLcF0U/C9gdPEOY6zBxNIiCxFEAUJPIyT+WdBU49bC8c18anZkxPGuiCJKIlUzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758464653; c=relaxed/simple;
	bh=yjgqbH7VXii1Dtwz7RS6Sd5yzVAQ36FDrT3GoZcB3NM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BAKOsh8/HhBMFp+1dktbhuycLh00s1XvB4j21RaKLrN9bx0VDlZ5N91bSPBD0KaQjWeMCI9cKkNRq0nUd2cqtNrPzLhHq5QiRB0fc62u5KFw6lE/8jtEOJQX1f6xI9xxJgMgnJfbe6puX3FHwh5IAZbRD+sIvEQzL3UkGnJzPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4248616fcabso49048805ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758464651; x=1759069451;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjgqbH7VXii1Dtwz7RS6Sd5yzVAQ36FDrT3GoZcB3NM=;
        b=HE7C4D4bboF33mVOjeNs2rQeUL0DbnUx00/t1jx2x9QdxaXf6Tkboy9iGAPvSK6fqG
         zdbIs7J2HoOSLUxDnIcIBPytvPCFyO+vyGIyQY7No8MuMyGeaJV81GAtPTH95N0GjgOi
         meGWc/j0IjWCmZh7cde7dT7jTussRl+kP747IodgpZyjRxerSzl0CRCe6cNqnNhftM8w
         YLnOuGzgh84xhwBfWxU/d2Y2L4LiDQH443/jVAlawcLtH1HLA//dQsgiGNNmNQ1MiWRR
         O+fxSXnNXYd7HQcuUHFxSQjozJ5TbpEC0PzAKBCjwq18RlDCF9ebJ8jV9PQgvxPe1MmR
         gCHQ==
X-Gm-Message-State: AOJu0YzmJyt28KhZC6MZS3jn/478gdbKb3MF4RnjXQI+/ItouULk+W7/
	R0TQvlIurnsLJGmvz1Kt4JSiY1NeZru0lzDv1WDqEEgMFIGGhHoKLBKd9AmdcRoZAd2IR+fe7AP
	TewK5eJ6uC8aKI8sK5WvfU66fsFWgeeKEPDvVwF9ggZOMAA7Ko/63DffIt10=
X-Google-Smtp-Source: AGHT+IE9j9lgXYDoI3Z9q4WZiIvVfkqXg/37JaSXzFAhT/kN0MXnzjpk2/95nR/5Fhj3XuYXwbvpRyAxBOvteHCyeh+Xey/rmw5w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1809:b0:424:1984:273c with SMTP id
 e9e14a558f8ab-42481980114mr153651005ab.19.1758464651397; Sun, 21 Sep 2025
 07:24:11 -0700 (PDT)
Date: Sun, 21 Sep 2025 07:24:11 -0700
In-Reply-To: <68c9a4d2.050a0220.3c6139.0e63.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d00a8b.050a0220.13cd81.0038.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [net?] general protection fault in find_match (6)
From: syzbot <syzbot+6596516dd2b635ba2350@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] general protection fault in find_match (6)
Author: idosch@idosch.org

#syz test

