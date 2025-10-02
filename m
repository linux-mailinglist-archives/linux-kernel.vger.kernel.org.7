Return-Path: <linux-kernel+bounces-840839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40CFBB589B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F0F485438
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9C2343B6;
	Thu,  2 Oct 2025 22:20:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F127610B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443604; cv=none; b=Zz8l+anVnbEVL8MMXdHqWHyK+xUGqwqKnO4s6V88CHSZSM6rOQeQWLFssWu+fTrWju2F5fVKI9mtA5SED8aCgQT29FKRaoUKKW2HB8FAYGZ9wOgSwAmo+G0vTGUjk/lF9yXCbiUQbwwGTpOmSKwrK1YsefrdaSEVWaLvQ66qCw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443604; c=relaxed/simple;
	bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o2jkRY/aPCOtj8bxxyZpiyAISbpvw4PgzcTRkbmxoifdcxR14X8dK8N5ARgZ/F0ePCM989wNXvvrla7VC7UDF7vmN2F+7MoydnoapZKtUQsUe6PJejrPRfUwo569GFu0g1Za34eKw+ROp0kWdHsTwgbwdgBwp9eR7CvR0P5AoSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-425788b03a0so41856395ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443602; x=1760048402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZIUTDUlLfJirMX9evaXHDyNYsjcHZ9WEC/P7k9Odow=;
        b=CSiiOempI3/7YGIF/qbMaz8OHXVxRwPdSC0NaX9peBrZXU2yg/q7qznMYko1rsLJBn
         RgeM8uihFWYdXDIhRzI7d0c8G9VbXRGDzvxXo/5m26N7p5IcCVHd2B0edOmnLVfXVGxj
         H5MPVKxD49CNmIeyoabaeotBhVA69Rm/4qAlUfpHOHFAQqelemjQW1SsGWFBFuJL16xH
         WZW40zFXYsBea0D54sKJr1r4LV4iev0GfrwXUrG8CXYXgkN3LZBnfBLs2XI8qFGJ/yl+
         pZeXTs8SGnw9E3lHxZnwDTECJ6Sj1NmXTR3cdZWGHUmj/jFSuVC4dyicxHdxnHAQqrAr
         2btg==
X-Gm-Message-State: AOJu0YzJhlDwylj9kBofmjVvHRT0qqRYreI9BU1jiF6r8XBWa+FFme4N
	/LjULkhQ99fukltDmzkNgUp0xC5V/XN1KbXXlTNkFjz7vw0QUdBs1ON7Jh+sv/jOIa0zpTALY2D
	PTZlJPMVVFjvO7DOT2oIb1dWxBv484KTQ3kKa7tZVqzYu4qeBHe7WbDcLR3Y=
X-Google-Smtp-Source: AGHT+IHO5/Hm4bXKawKmJnJ8E6KM1B1z8VPpvFNKvrEmu3dihZh47TbuG7nFIidsMwDRkewnk4VbG1ulpqhQDaQWeAJxVLqCZGMq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ef:b0:42d:867c:79dd with SMTP id
 e9e14a558f8ab-42e7aceac99mr10528505ab.8.1759443602475; Thu, 02 Oct 2025
 15:20:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 15:20:02 -0700
In-Reply-To: <68dadf0e.050a0220.1696c6.001d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68defa92.050a0220.2c17c1.0003.GAE@google.com>
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

