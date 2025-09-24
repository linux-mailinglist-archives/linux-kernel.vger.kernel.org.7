Return-Path: <linux-kernel+bounces-831151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E7B9BB44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6BE168E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568D3308F27;
	Wed, 24 Sep 2025 19:28:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B6225401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742090; cv=none; b=fl8eG68LwiXHxpzaddBWifPdcPgQJGFhbd3LbksrZu+bHGNz/OmylkcZ24flKAKGmjrFu8fPF2dc0lC5G+1ysNihLH60hemm5/SEqaTECO1ZuhRTEZINytODuuzIQlJXBO1CYHHFrKkFBA5nROmlPc8PW3GL42hn6an0HozvJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742090; c=relaxed/simple;
	bh=8ZbO4l0Om7nIYKqFa8DvwfrUzxWmBtPAuI9S8wXkuRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ungN85n1zxKemC+/K5kOBtKJacyOH+njenUfikM5uLSfA93veT4jnJYn8nt2sEawbAzNpTUZ3Ywjta7K8kw8QLC+1PQijMEyEkvrOGDdPJ3KSXhtYga08t1gG5fWJbcl6wYYAx+wrR4rhBDcIISFic4NOjNoQ74T2VZ0MRkxZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4247661a0c9so2757415ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742087; x=1759346887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZbO4l0Om7nIYKqFa8DvwfrUzxWmBtPAuI9S8wXkuRA=;
        b=WX5bb5I/FNrQfMFwlrbR/Lly20uRtljKQortGF9uBdSPhSfBIZTze5tGRkb7fybPhW
         JyOR21lSXH7Xv3hxJ6SYq2IHV2pcgxBxlp+UZ+n9qvwwaDtes5bXc5TGN75Ye4KTDqih
         Y6wr8OZ0PkHIoyAwRl7ECVnCmb2aQgwCWSgLXNDEF+6VEaSQlsMSk0yjxDcdViqgMa4L
         B++am7BvC4SlTxHGZ3UM3OxyH0cDkM8wySierXcboeZ/8dbfMBIyTsDfqpVyIzSisgr0
         eDGG5wdlDU0BZ+p/bRJ0m53WVyyI+p6yXkz/Wi6gjuJ+oQdXZsyADpy/9rkWG3XrM1cP
         Hk0A==
X-Gm-Message-State: AOJu0YxNx+XG3IksQHtmIhbQ7FXfFw/zNzvUyh0G/8cMi9mzY4TIlAVJ
	18VBDvWg7rSUHxro3HpKRla0eWp1WwqfA+AblBl5cuAf1ybU0FMrY9seIGYCHQnaxhWq73FIV/L
	iJE66ADJCBMRaX4wOJWK5FeCDF0yj9px4P+W0ii5phjW9memH00rb9eXYcvo=
X-Google-Smtp-Source: AGHT+IEhLXKfDdFIIvC3CSLRXau19Ay842KnQ6vb5NJKc60OD0OMPmYr9DrR881tYK2Pv7ShJ+UtXCZIXlO94yGRH0HpYGdNv2vk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:425:85b0:49f4 with SMTP id
 e9e14a558f8ab-42595623754mr12277835ab.17.1758742087671; Wed, 24 Sep 2025
 12:28:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:28:07 -0700
In-Reply-To: <68c21301.050a0220.3c6139.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d44647.050a0220.57ae1.0000.GAE@google.com>
Subject: Forwarded: WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in ext4_xattr_inode_update_ref
Author: eraykrdg1@gmail.com

#syz test

