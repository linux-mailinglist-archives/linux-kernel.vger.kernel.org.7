Return-Path: <linux-kernel+bounces-893139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483EC469E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 007D534496C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1E308F0B;
	Mon, 10 Nov 2025 12:33:12 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AD2FD66A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777991; cv=none; b=sQzHa2eUpdQ17Ag2QkM6Kp9YiL0ri8vdD0Y0iKE9sLUxohC15qoL5XpCuc8DB8Nii0oft8OI/LLJBGnSFNmLrYNeH6a/8Gi9YwUAWQqnqod1RdJZniPWMVdeawWPZopok8bD3QpPr2myJYf7qAJv+p5jvlNEFz0/b7KLwgWPze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777991; c=relaxed/simple;
	bh=hvgxU9WYOhjPOQBT6MnJZluumT/J40sc4Orhlp6AI6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ncNtiHnfRLyJ2+kvBuTxOhSQylbsOxo+BSDvzyrKQSdYlGJHfNuLldzIEsEE5YbBTNcA6C+f7Pf91Y+dWbeKqk0/V+TuMpgovbcUOlRSXSUlEFSW6tpGyAANFFxXdO4SwgTzQzYD5Lk9/On55sUIFkvJWufG0tWfMldBAkDQ4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4337b5c3388so47574235ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777986; x=1763382786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvgxU9WYOhjPOQBT6MnJZluumT/J40sc4Orhlp6AI6g=;
        b=Is/NUdxEt+TqfPfFisVvE5o7F9AWltH1OYfcnNNHQU4ga3zLBOv1x9YzqK3liQPFc1
         WGbydqN8KJ3Rswp6twOTVqULEa/FSiIwLNy6hBTf/puEKqLU+2l8p2jDQ2JXwVvCfaE+
         rUifqc+QpUcgn+h+3VoRafFEAfVZYZ9Q5DyP1J92oi92DCTuvKaxS9jnqrlSDGT0PQIt
         83+f8AbqgC4uqn0+6WdZBJuuvKi2x90D0r/+AAucNFE6FeJ+LOmP76M9AXeq/cIEGOqZ
         7pILI09JlXdCi+SMdl0XijyRdmt5C22T4HWVyk7W2Aoy/wDrbFETyKMcRKIvDXzokIam
         M6uA==
X-Gm-Message-State: AOJu0Yysle1aIRf8ZrK6JbsIHXHN8aX8/tshmZTYU/74vz2F9W2FXAXq
	YmIAfGQZclDvKNIaq+k4e2X9en4Zi6erXBBggJxquTG5TdhZqVr2k0xPGjhHJN3Lh/Oqziz3hNI
	da4PBeLBrl4amXjlojFHK3LcysnWGTeH01RLQlhPHJxZ6LTL7ZlEd5ZqwphU=
X-Google-Smtp-Source: AGHT+IHmK4ZMKAqddYbNOOOiE+ZC1Vk8hU9Rj+rB+n19ESeRSc8J7l/A97w5onCz7DomWKloaR+35WZueF9PLaUnKHkwuv0mGgWe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:433:7964:d82e with SMTP id
 e9e14a558f8ab-4337964dae0mr85197475ab.13.1762777986553; Mon, 10 Nov 2025
 04:33:06 -0800 (PST)
Date: Mon, 10 Nov 2025 04:33:06 -0800
In-Reply-To: <690d9fd3.a70a0220.22f260.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911db82.a70a0220.22f260.00eb.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
From: syzbot <syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] general protection fault in txCommit (2)
Author: yun.zhou@windriver.com

#syz test

