Return-Path: <linux-kernel+bounces-737936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7EB0B228
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEBA1AA020E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786A2253E4;
	Sat, 19 Jul 2025 22:03:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8171E51D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 22:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962586; cv=none; b=PkWOfXskBZkffZnTMm5V9pj9qXUtHXVqiXnRM8QNTNVyCoc+rpHv3w81szPOoHhcRaEeFSpp5/kF+AYGZ9c2FC5+5JLDLGS/kQhlOIq7gOdqlQlsoCEqHUKfnVMoCUZEICy4cFlDbpq/9Y+c95ZvpKQmhnI1vKCxWsacaTVulTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962586; c=relaxed/simple;
	bh=7G+7hctW78ANNXX/5axNLRYYMsb2+tVzJlyLfNTxl1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OY8oCI9tQu3HrCfvYvM2/tTnXrw1Ji7uyD5BvvdK+I0EN2EvHqthN1JBmdkKTwEtRS5TSegGDWCdgv0NWGpAwcq7DNZvvyT6OE2VcX9xt5p7FD9Q2ZStXasY+q5M3sV6hNh+ag02Md/LE+Y3Ivxz+iXn9K/lEWybVXlm52gGX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86463467dddso322196439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962583; x=1753567383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILgy7KYbCsw8EcpdJqwpfvHDmjvUd9HaHnpn0nkU3BE=;
        b=PuJecJI/xLW2rO+XYNVTxI4/vI1pZuLL/qcvyPxLYZxJbbjRJY5tpYo2YAeHW1ZXqy
         sbY2P4NLXh+2Q8hP+dvUlGzPI/OCLI3gTwTVlGhXPqSWSUoZRZI3afUXOzC1Buo2Qfs/
         LFUVAtWNeVZv33Q4biLZOvs1WrV0Bd0TzVR6t1OmuFE3a5WaaJN+CcCFnzpX0yKHru0D
         bJI45P/0JxOTnw8HMmmdFLgOORfyj+5k2Oi+kUclaIHxLfO6i7B1J7E/nvxlnPwisJAQ
         oggi02vIkedmDp9P79EKr7HhoqbuqFMrDNrI+/zn82zcb8yt0nxoIwtVyHBdyBwXn2vf
         MPHA==
X-Gm-Message-State: AOJu0YxbHmbPPWvxv72+Lhaa3kauOVNLVYtjkEjobG7ZLjnJrhTxJSrs
	/Jt4B+v72tNQXFTZI424MZZakLWMK3SJxoJNUHD7qqnX/0HpUZKKRWE1gGaOiB6f90B1hrFakmU
	MkMTrVcgYBOAPVSs+/Zhjvf3uNWKzzLWsrJ0uAw9xglQElzGbeaFxBADpk5I=
X-Google-Smtp-Source: AGHT+IGZioOunwjEeTlsERGjwZAA6gJamTgYr4JjLVJMDUDiuuxKzzbuo6JxNNmO5u/3UirkQlYgo4hVo1MkfvS3KR55vaIY4ItO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6513:0:b0:873:35c8:16f9 with SMTP id
 ca18e2360f4ac-879c28d0ee3mr1445624039f.8.1752962583216; Sat, 19 Jul 2025
 15:03:03 -0700 (PDT)
Date: Sat, 19 Jul 2025 15:03:03 -0700
In-Reply-To: <6749afb0.050a0220.253251.00b2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c1617.a70a0220.693ce.009b.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+3ebaf90b49bd97e920ee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: fix assert in bch2_btree_path_traverse_cached()

