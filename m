Return-Path: <linux-kernel+bounces-832617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B1B9FEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474F42E6DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8428C5AA;
	Thu, 25 Sep 2025 14:09:44 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C3286426
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809384; cv=none; b=V9mJwwIDC6JD+gLrRYJd/fGv0uAD1h7BhND18GCMKx7bXYGU/kCxJtfyt7j/3tmRlvNmWvufZM3KA37O8JcN6FXhG87jjE/TYlCFKYQFdB5S5CkPYt4FpK+iNQKdBxswnX3oIO6nzupD61e/Ex1LTW2g3kmENm+Rhcquu2KQPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809384; c=relaxed/simple;
	bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZPxK59+j83J+MPCRjde+RgklvbYCR0BUPbZJpy8xOuHURiT1ZmKvFZzPz4xoB2ytpDV/NBkY/uu79CNDll0RAptSqzPBXRz1r3bhJOnB+2GpeyEKGbA6e+eP8l3+oHUhicDaIjvQPabqxdn5Yr2YbVWDvi4wLxKi1KGdLnY3bZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42486b1d287so24619225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809381; x=1759414181;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUXPBb8UoePfMeduek6i4pY3kcJw5egFRNTRJmZTbyk=;
        b=M+vHpIpbBLhtRiOHhD851kfZa39PB/RzCUPBnnVLNb5cxewJiS7WYzlOBlBwpJA2EU
         qZYqrPvl8BlkhF3Dc0jz2rlQBXw1jCUPezJKGn6PM3ee9cyRnWO//ePeQqC8IsoaZgXe
         5v68dPlidsK48+SR4WMiA2tPJofUVP4dE3Qg/Pf3UrNCJEg8/c+okfhwZpM4OoyYZpOo
         69ZQl8JmBS0er5Jg8UzvujEn0kiAjACxmgTuYltbTnIDhvlAUe7xlzWHY0tMisBTRHqV
         8bdqtDnFGIpLR+MXi77Hnx28Bhegq2Xtx0i6wFUEEFcu99ylsqp60nOzqbI3FIZFIcp8
         w7zg==
X-Gm-Message-State: AOJu0YyoJp4Hz9Ld3duizLkv+y3+Mw2bsMbd55311RXlnLW9rDy+pDh4
	h5t5AL/4YOLZMJHnLP59WGawAQhBhmsXv3H2YSasbrVkv7w+dT8/r5cP1LSF2Q+2ElabM3XPc+Y
	CsNGl2Ka4fA+TRsRkj4w45k8zpj8oaD9YPExXtw0Ec8lmSQgbMce0qxSasrQ=
X-Google-Smtp-Source: AGHT+IEWAA1Tu8Fh5Je2zyvqH8l8nSJ4H3AORxs7gHj+aNe19LElcsoIncr+k5wDECI6cURHoNngZtypfDAGTcAj2jRctt0FikAV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a0d:b0:425:7ab4:d61 with SMTP id
 e9e14a558f8ab-4259563bb2bmr54990075ab.25.1758809381712; Thu, 25 Sep 2025
 07:09:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:09:41 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54d25.050a0220.25d7ab.0026.GAE@google.com>
Subject: Forwarded: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
Author: albinbabuvarghese20@gmail.com

#syz test

