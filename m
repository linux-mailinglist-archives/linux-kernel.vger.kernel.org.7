Return-Path: <linux-kernel+bounces-808506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD3B500A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E580F1C60E0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E552034F465;
	Tue,  9 Sep 2025 15:08:46 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298851A294
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430526; cv=none; b=OyQT9cV76aUhZq8MK58j3ruL9NE48E+MPQ8QSn+kYQ2WaWk6GyCza8LlGoBSLDR+Nukx5BqBDlVz5s55eXbQKMb8Quijmk6MmchH8WQtsQbRgZaNSULiz6Hwk+Ng8SUP9SL8V+zWLosLYMURWlMAm6s4czFoE6AdIJ3ZAGZJpI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430526; c=relaxed/simple;
	bh=gDa29SQjfzOTTMQ6m4Ttr0o1EEG+gBMTF7qOYNhvKDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=byJzKeosl0R3jtJoH/U7hNfetkpEJ/mOekpj/VoDcoUrDSbaFaqXcqawlaYAmPmX8b2LJ8zYgvOj1JKpkmP+hJPK9rT3YdEoNBpqwjLpKuIQ4F3n0pH4fzm6yo+vqXWryPdn+PmnWT6FWxSQcnXVsZgDWFpWCyZK7c3DB75nIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4155725a305so1463175ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430524; x=1758035324;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDa29SQjfzOTTMQ6m4Ttr0o1EEG+gBMTF7qOYNhvKDU=;
        b=exgzfhZEqjSG1uhOtzFupi+p2Nv/4iJNyX4/fE+tGVpCrAYXNAyYDFozBRTeHfqvgq
         XLXFPpXPnYGd0Hm1d5ihMXxqEnzzXvQYq650mtfZ0bvV5GVai6lJR0wTcoDZj/2ZHnXM
         mzYy9ZrNslaIYPwY+pjLb6BtMpybiTzP6Yh7JuSa7AZLFjSc7Kmixy1/jYt6OtbVruKL
         YBoyAdmRocdrTbZdN4jjxTUK9YHLDc4TVagSic/pEs9qf3+56nCoNtVDe3VenoyP5YEG
         fvJfB5282s2acAbsSFJ8ecPExO0EDwZxeydVVC1NvAwFEzONGMAyXHg5A/nXgx7CpEIi
         iH9w==
X-Forwarded-Encrypted: i=1; AJvYcCWoI0GFN8Wre28AYiUf8IdWmr+xqpgUvfzYTKeMns1ESZmo7OeFmb1HJObVbI1PfsyYzXqnz95zlFTRJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HfNyT4VvYF/T8CZirP7ZoIAoo+o91fAzijFv/D3h1JvPOmb8
	bbpUAXddhgHqnKqjvMkMfpmWMKZIWGTGIp+RkQSnMY1LMgxavxUaRlFLIYSPBN3vPjpwxA70z9i
	LDYZ1wCLLUtm9pboRG/Qnr8ue6qd1Y4lX1KHs3crCMSTs4+VnioCDDBwP5t4=
X-Google-Smtp-Source: AGHT+IHhJaQMOTIg68AbO604Z8qWTe8ZmkqU04JIBSkdUq610nQ4rpSowNkVjHMzf5xbp+onWscyqwAuhXQgkl5JKSf2i2C0qc61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:40f:9e28:b01a with SMTP id
 e9e14a558f8ab-40f9e28b0a8mr50849865ab.30.1757430524170; Tue, 09 Sep 2025
 08:08:44 -0700 (PDT)
Date: Tue, 09 Sep 2025 08:08:44 -0700
In-Reply-To: <e12c727a-403c-486b-9a34-db4028ae8451@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c042fc.050a0220.3c6139.0002.GAE@google.com>
Subject: Re: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 f777d1112ee597d7f7dd3ca232220873a34ad0c8
From: syzbot <syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru
Cc: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f777d1112ee597d7f7dd3ca232220873a34ad0c8

Command #1:
This bug is already marked as fixed. No point in testing.

Command #2:
This bug is already marked as fixed. No point in testing.


