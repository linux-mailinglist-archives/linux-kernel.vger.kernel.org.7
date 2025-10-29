Return-Path: <linux-kernel+bounces-876724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D24C1C3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9315A22AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B68346E6B;
	Wed, 29 Oct 2025 16:22:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E263358C8
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754942; cv=none; b=NHTmT01VGN/z+b+hQo8IiqI6IQQv2pKJAc4u2kvItr6UomUscxhaT2AC8QL7Shlgpzo4R0NvghrhqqAzM+LJrF29H9b55FqBkC2MjBN+YFifvAHDZc5Z0/PAcVIpHyqDzRFz5MglIC40IbBjnhYupTrpxNs0E+L3nj9XJyq3Hwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754942; c=relaxed/simple;
	bh=M/+PNDGbTJ6UlJZ1qvScMWL/4DVx4AED5y1LpqrNEHc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NELzTqFyWnAzSZ/Oo+J2ByurqOGp4mGLVCtXpU3QT4vDgj1sUsZ4guBA7ESpUVpP0qVnVdJRQ7RRv1RysgB3jhPLdXEEeBVEzcLvyS131HzsxvkLcDX+maeYIelDQ85qNKAgMlcY+c4FQ3jpjipMGc1iBt/fbw481E6RMHDi89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940d395fd10so17741439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754940; x=1762359740;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/+PNDGbTJ6UlJZ1qvScMWL/4DVx4AED5y1LpqrNEHc=;
        b=qo0BUL7j6FyqfsSYmrOwaT1ecqWkWNQIKd8QJhk6bgPvvd3SmHZDE8lbp3oGAVA8ql
         vPlH2aU2goW3RjwsxjxZWtQrlb+ieHz5IJU/3EeJdh9ct+foYraOWnOTmvw4bCfWNvQD
         Wy+Al2uVFDPx170GTZBuqRp+2UuE0bq56lH2abk/BxbKjHo/rrDwSXV8L3WKSFfVkJId
         MhjXdAB7GvIYtqHHOQnahnZ6WUUXA8wCcHBpV6m6tJz/8LUDhUObOjF9H6uDSslZgaOS
         1ZJ4uBTmhMe0YY0UdEqQXg0kk2O/WZ+UzBOFF7RteELyyE+t/1XryJKpT/7sDL2UYoeV
         H4XQ==
X-Gm-Message-State: AOJu0Yyi6HzXgFpa6H4ZgVtJ/iqE2q/y1WHehynVzUjd762LxQ6gpCHW
	VyYDO4V+T7w/HeIXLwn5o6tMtvGmsT7sDODLL/x9VLouNX9jgdiPsnSBeJeYbehobeY/qqFFLyb
	z/3InbyRmwNzrCPCeSMLue8S7TtZuj2zsKJcwPmaeeBPj0JQxL0W9nfrbFl8=
X-Google-Smtp-Source: AGHT+IHiJhB9cgP/0RnIa+2LV5sBWYRGoN+/lQTwfsNuMz6pfmtMpoTWkXir+WtDgzydaFUiZw0P3DfWx74yIB+EwGUOOib+oWtI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:432:f835:2576 with SMTP id
 e9e14a558f8ab-432f904dfd1mr42773115ab.27.1761754940084; Wed, 29 Oct 2025
 09:22:20 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:22:20 -0700
In-Reply-To: <000000000000a53ecf061f700fbf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69023f3c.050a0220.3344a1.0427.GAE@google.com>
Subject: Forwarded: Re: KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: KMSAN: uninit-value in bcmp (3)
Author: kubik.bartlomiej@gmail.com

#syz test

