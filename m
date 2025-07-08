Return-Path: <linux-kernel+bounces-721028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D146AAFC392
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3476717D973
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB882561A8;
	Tue,  8 Jul 2025 07:05:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E025393B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958323; cv=none; b=THTNucUbKjMzsmrcLIszRxEswtZwbbTTALLwiTVvSSUAQ29ludaB2pmAlshP6+bcXKzp/hmZIXFavvMGOYWTgLCHMJKj3AacYt36j3ewq7Ba3wH8Nk+I9+qWTg4U54225J2pB3qq/hJyztGplOJdQiXJtlmDmIrDkyAR3DfM/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958323; c=relaxed/simple;
	bh=1ppBfT8yQskUY/656hHA15lh/UVhc7KTXuEwkG+2iIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rNj8W2pIEkMB23asEgmEFcEjHz+zNd9XXWhQgYHVyvnxlk1bZ1HJqd93mPo8Cr4GJswdFNhuM3FUOC+29fGcdvMWZfHmJGFpLkUPtnsSORgLzRNoecIj2CkEVlyzaX9gqSrrYETjx4PGgSnLnp7WZLZkAZpwQUtNQOwgXQ0K/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddc5137992so39139025ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958321; x=1752563121;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ppBfT8yQskUY/656hHA15lh/UVhc7KTXuEwkG+2iIA=;
        b=U6qr3AoAUGw+oOx6IBqvfhWjPlIPvGEvX0uBe3iZ0BMnuCZ6iNhsZGe9o4Z+WPiOIq
         PRldSc035i4cwRHptImq/O3Z1u2JtC3qlc79XqPrERFFRto2yhwC9+SLW7WZNX+aOkHX
         vT3z1U+7wQGsKUU1wBD7kd1aQguGiMnkxwtdjUejZK2Jzsfwj/IIe7b07b8JYaykBqH3
         cL9Ijr36vmmudHtcbhysIY00zc13JdMsHGZrtEa2P91Y20yJaPoJucCFtyPkvqOcOISr
         fROqk7O0GG5M5JHvgu1AuZAboRyIcgzXH6eqwBRcciU3wh5+eYUZXx7EJ+1AgX0Chl5f
         dXsQ==
X-Gm-Message-State: AOJu0YwmzQDs2sQDyaRh27N2WFAlC9IohkzvZlad3BiC6/9j92z/MLVR
	lXqg1i62f7QVcrv2/xBDJ/F/mO3dJS+6o2jIdfGLIDF+vIyduh7qh6zDH1F6XxIPP6XNc0QTWvG
	9ax9fUJ6NZa/acWGi8+j5pR8vmrNIcGkWXWthTjaOsfuJX65+3bt6L3kpLxw=
X-Google-Smtp-Source: AGHT+IFY0JWUvU9KFk12rn9nl1Rzt6O2uoMPfWUW5vNDUyv80NjtAJNckH/i91Ka9zk8mX5X7p8mMo3u0GXRo4WdAUfrT0TDWXkI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:3dd:f948:8539 with SMTP id
 e9e14a558f8ab-3e136ea4c01mr137639475ab.2.1751958321056; Tue, 08 Jul 2025
 00:05:21 -0700 (PDT)
Date: Tue, 08 Jul 2025 00:05:21 -0700
In-Reply-To: <68695144.a00a0220.c7b3.0045.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686cc331.050a0220.20334d.0005.GAE@google.com>
Subject: Re: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 d7b8f8e20813f0179d8ef519541a3527e7661d3a
From: syzbot <syzbot+27fe438b6370f95de4a5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d7b8f8e20813f0179d8ef519541a3527e7661d3a
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d7b8f8e20813f0179d8ef519541a3527e7661d3a

