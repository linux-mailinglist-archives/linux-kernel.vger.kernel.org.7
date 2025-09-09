Return-Path: <linux-kernel+bounces-808648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26474B502C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51364E7F27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB22E92B4;
	Tue,  9 Sep 2025 16:34:03 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F22DF157
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435643; cv=none; b=TV9Idr0aw0iAmwcA5WPC/EKUF6QBi3HzSa0b6SjsgzAZW+I/deqPOrMOy8pLEbw7couHecICETpnkSb5g0CSAfL2mfm8+pLtt/Z48XJUr4GwH1L2jGjclVrT3inGoMQKeH1+JeaCmFDPVYD3VudhhKqi8CK4FiVa+2/ybv6fnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435643; c=relaxed/simple;
	bh=us4Iv5TMaZ4BSlFzYZw1UpbylZI7n8Hx9YEx/oj+sB4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Xlyc2hP8598tPB7MqXL23ihlJjqT/EB6vcRy+1uTIT/UEASIEV/21ZXdLAOEH3m4eGmY/ZKnQsfJmNcKINjiAIs3BhiMTC497jPFLqkpOgNDe9C7zhU8Wbnf/VcsILv+aorQ6Qt6wt/cZ0vgMPJMaxRJc/PIX1VrOyc1eDIxmcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f736aa339aso144071085ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757435641; x=1758040441;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=us4Iv5TMaZ4BSlFzYZw1UpbylZI7n8Hx9YEx/oj+sB4=;
        b=qcxbGsRq6rkISjDV9itMmjbrtKQSSMVYYJdo1ztzd4dbAiEM/dKXfcWKHd0JPMpV3j
         jNszSppc/1IHa8wzME+nzQi4GCX+0egbBwHEhPgEsPbvhMPH7ohlCKrdvUB+Guw3UuBD
         s+c35BRQ6BIwYnibwK8jaX52jjFrr/JBOeG8z+nS3NFiPs7XhsW40uxsWynqkJhRQKEA
         1/AsTavfw9Acs9yY1VO2Op/2IppoSj6YmazJM66Lja2RrSeHGRyPXd6T+1a0GOhkrgY9
         kAUMO9yUUhv9RkdlZ8nU5OaVfwXQhHPjwCFDyWlLyro1TiVNe37YuqoHpikNkvuXx9vb
         aAtA==
X-Forwarded-Encrypted: i=1; AJvYcCUzW5mfOE6MnZ9L76hN1DJAQCvLXdYhzrAmggcClc6JLdYaIJQivnDZAHSkGQZaNMqMKC7WVKcHhTO+quE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jD4TH/xvKnsEaz24u90d951ZBL4X2NQQ7pfqPg8meq+fpr6K
	JiSIiojQk1GCEJVJx5xqGMIciS/BD9IUgyYPdVyTn5EWVJARHg0bMub4TqcHn4L+tQzi+NOp4Gx
	ubD0FRk7KdhubL2LzMfOECBtcFp3pnWVhFqTfmoRBdP4wo0qAUvyK1DvJ/b0=
X-Google-Smtp-Source: AGHT+IFTHLFaJg3HFWh3D2PC/oeD5qFNWH1wkUCSpK5g2FUrbqextG1Fxf/iXXAdHZHoJzdVHgmEN1BssUpsmYuAHNLutarIVmgZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:3f8:a30:cbd3 with SMTP id
 e9e14a558f8ab-3fd965c4ca5mr174420325ab.22.1757435640870; Tue, 09 Sep 2025
 09:34:00 -0700 (PDT)
Date: Tue, 09 Sep 2025 09:34:00 -0700
In-Reply-To: <4d720fff-8d2b-45cc-b162-ccc52175d494@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c056f8.050a0220.3c6139.0004.GAE@google.com>
Subject: Re: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 f777d1112ee597d7f7dd3ca232220873a34ad0c8
From: syzbot <syzbot+26dc38a00dc05118a4e6@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru
Cc: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f777d1112ee597d7f7dd3ca232220873a34ad0c8

Command #1:
This bug is already marked as invalid. No point in testing.

Command #2:
This bug is already marked as invalid. No point in testing.


