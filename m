Return-Path: <linux-kernel+bounces-794110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F57EB3DCFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D53BDB0A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C932FE589;
	Mon,  1 Sep 2025 08:49:41 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B32FE560
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716581; cv=none; b=nNXY5jJCF01kiNzOFJxy656dAU+g7ACHa9JZxMPmO6tuLcgd4wKfPTx4+ynVoARgmksgJ28oXzM6rPM7DcLZH0taKd66ENqWlbzWhlYrbUB0QSJhKeClCF7NOB0Aw4FFLCfgg/KVMJN3ZPJCKv63Syo7dy39YJ4mRr1HGRUOqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716581; c=relaxed/simple;
	bh=XU7XMlIiM/kCZGHqSk5lsCfsIiE/XxVN6rBeBUV0JbM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KwdPKS+8GFvLmX+0x1YStiQrARqeZAMriW2GTDLkKIzUpICPZWY25n+8fXd6MdFA1URrAHcrLXo6f8JC5vehpxg1Ztk020hilTo+tAnL3WPib45kORDGn+cZoMhYmOIf7eEF53PZxNumAMV4pdqUHdy6mt98h1pTeWUmlMdoVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8872e5be29fso206338639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716579; x=1757321379;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDSPdinqc2VRkAkuHG4g5LNl7lkWssYX20wytPJzBpA=;
        b=cM8cIYIcZhMkXgq5Tf6YS0mGvSFyu4we1yfsoAJigRnRuJ+Pdg3eYahInbkFR2iKRe
         dRgHav9cyPqj7tifTE89vHtv8Q+k75Qf9nFp+fl4gXjiG+H0EzG5ZgJjIp405PACsIj+
         nN5aHKj6z71QzuF515AqP9revB8rN/JSPzodgwMGHBIhSrEZH7cJhuOqia8EV0c5DZHA
         2M1bn2v9By94lFWbDrCT1h2QEOhWlnZRsJ4N3hxE2XXrQHNDbTUvzNm65JicSl5iBvIG
         yXOlO9uQteM3Vy6IKf6d19ayMhodgxKcIXcl3mc9S+qrvSJOugUSebiOjXRlpl3l3AVV
         QJwA==
X-Gm-Message-State: AOJu0YyA0cvKsnF827R4MndYAaZ9uDExBIkwPKctcojWj9ZkN7LxB+JW
	DBKxyap9qIA+74OYLl73+reUvA6FmSwhkz7gGAAcctuOyP4FHlZNdFK1InP1WrmFBHY1LdAJYLs
	0xLKO4UMltC4a5sN1CWmCg2ACa42uu2m6ibj2JNz7NYoNKujYiKRgu6HSq7M=
X-Google-Smtp-Source: AGHT+IFys0ZnWn5DAXN2FeX7ooeFStlYJrXjHnADMm/h56FhoqAb86IJYdW1pemHC30McNDPAW2GnZe6aUnqb4EQ9oKr35TCGnjj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60ce:b0:887:2d10:e374 with SMTP id
 ca18e2360f4ac-8872d10eaeemr605410839f.10.1756716579104; Mon, 01 Sep 2025
 01:49:39 -0700 (PDT)
Date: Mon, 01 Sep 2025 01:49:39 -0700
In-Reply-To: <6863d4e3.a70a0220.3b7e22.1b12.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b55e23.a70a0220.1c57d1.056a.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+37d54f0f58ba8519cdbe@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

no longer relevant

#syz invalid

