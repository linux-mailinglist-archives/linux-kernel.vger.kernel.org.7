Return-Path: <linux-kernel+bounces-739696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B89B0C9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407AC540D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1552E2661;
	Mon, 21 Jul 2025 17:37:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50D2E1722
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119432; cv=none; b=eJ6fH56wXebwGRbOYUzq7giy6cZ+IhqjLvIXPLL7eSZ5W7sjc3kZMLiMhWkg+CWqQC89P84MkOemZ9U8VbVpRndaHM1MTuK2tC+AsdEnBFw1WhE4Gz1Wc+NUHkS7Q1dLWPG/Nh6K8G1b+XbEL4DrjfFZBpdNB2lOagXoovF9zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119432; c=relaxed/simple;
	bh=IGo3jNnp+qq1dK6jcapurdcgbK30RoZ+PQYFH4jp0O4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rr4XnJaN0ONZ2FJ358nsmpccI+SnZ+E3NUMcZlRvYCh8nwLpQZjl1kn6XDEcWx3TPG49XI/MP4upY6t9FfxrceWUSzWNPBCtBogFXJdJ3sOkx8xWXm9nWCVrS/mZmKQkl4ksgnturH0icsnjK2fL0647g2FsstOI6UpvBwOhGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e28a67755fso21222505ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119430; x=1753724230;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F34G60DK/peNzw3CyailDDjkUCV0rN7HJtDZj2VtYzQ=;
        b=td3wq7691iih6muBV1/vxjDNtCsBgB6MnJ/Q3PL0KY6ps/oR8OwKhaVf+byNFQzEf0
         H6gtvpEqIuhsuHn3RPJUGl+voQg2xzFHxKgf6O0LbdpJpaffclRuSdhuirikznhd+3aw
         oE63Wmg1GRz0p37gaaSf/T5YTB/DrX3Qg8Q4jv4aJnqtUXHNPiti7PnGoWF8TO9yKROX
         LBlznJ/wC7ZSoqWvVYUpFdnRHr0KMXrruid7MjHQ1/S22FzlsrfWc0kmAeExFLpaOKi/
         6sSpk+e+kpVC84sDDNq12OA/E/fUfUmcsWq+ImsvMxO1hNmiGzC5puoJFSnrkbrX8A/W
         K/2g==
X-Gm-Message-State: AOJu0Yz14H+38V16VCCL4czPrq575micENQu0KCL6JHY0oBqAdD6e+mC
	gunI3b1V3Jb6yAQtUCFMX5WeBO4fdBLgYKMS9bzedqVdXi8D27Vj1eNFeHz2H55dwyFAfoGWFz7
	pEE4P+PZh75rXJtp3T5pK/fnr75GDQKehLZ7vTcaHBk8DDzBVheAGuSOLGI0=
X-Google-Smtp-Source: AGHT+IHEoPC6WLikCy/msLlxxTZ/qaofKxGTk1eBk9pUs9rM0LjqpgvsCdSgzdzb9hW5ie4EHUKMVYs17ueeDuHW+vgxLu9SZ3ZW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:97:b0:3de:287b:c445 with SMTP id
 e9e14a558f8ab-3e282c4f886mr241484015ab.0.1753119430114; Mon, 21 Jul 2025
 10:37:10 -0700 (PDT)
Date: Mon, 21 Jul 2025 10:37:10 -0700
In-Reply-To: <67ac8b76.050a0220.3d72c.0167.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687e7ac6.a70a0220.693ce.00f3.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+9b22c314d51cfbcd1ddc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix:  bcachefs: btree_iter: fix updates, journal overlay

