Return-Path: <linux-kernel+bounces-879557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75523C236C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1D43AEE89
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE742FD1B0;
	Fri, 31 Oct 2025 06:45:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C42F7ABB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893105; cv=none; b=SRbvJi6KyD4JkXCIj9dcuw2I4qshUVVx4G99xXM3LmjOMYgeHMGY36h1FxxVWJ8MS+1XlIKl38htPeeFUY+xSZQnlQ8jrNqiUiLJwh6Nhi1F8b2ncR7yWVdBf0PUsI3XRFEKbwkTpL/FN5uJ8E1PQZFtBsrUgRF2GioAs6ngNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893105; c=relaxed/simple;
	bh=6OowjB9orD1CHywv3l0ULBS5+U4i1WAVTOislAtkrkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vDEFmhAHj1ZqmX7ooVsXl2xhCOWhbaggOpjksLgOneM3GiGSuSYIqzQ1tCn5fWoCMR3CnIUCQytuiiAEb38D1rLKwZbO1/fiqdw6GvtAzXP1POmFdIXj7nCtXMDq51ZZ+gI8wiyh8SQIECiyXR3rxB6JTV0Wjex3pgzC/6JB1nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-945c705df24so355049639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761893102; x=1762497902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eu3tgcD8OjLMYXfT/s/p2VJrdoIBjeArHlIv1rvNgoU=;
        b=BEFjaf8OMxs3fd+7h1xVxhgcWGRmNT5rva7RbfZjse/Z5AHWKgQaAYEfECBV3JUGOI
         ZOyNG1+2r4jim7J6YrunqAdXLVbat/FEdYT6fBfmFi0W0obZPgrSCEsbLaJl3DWrVQX9
         8qW+HnVNjbWzUCPOT0TrHQtGAVULPD4y3qhhcPlxEPmsAbE2jr/aa19/okHlJaCI3UC1
         4NROuLbOzGFmAnrwOkRjEo6MRAu6JczZ28xGeAQwZE7ruwEfq35XPSqCvLINoW8ph5lj
         oC6GRmq/zWUj6lrAJlL+jyE53/eMgN4PVYaGwqtp8SCdUJOxdBbBJn9Kvgf7LqyPRr4g
         TBTQ==
X-Gm-Message-State: AOJu0Yyg1hgm6yIEfPYHGIJSpSPJ3GawfWatbt7BEfAewsWw5nlYfECl
	kQARnLmd9ID8jXR1QZxrqJGz4d+6XMRiQVb67UtDPYPBrwyMLrYwOGjBiB8y5ZL2M0XSnsJkLyT
	S1+FJP1doSSCPzvcsivCBmTDMqCqjbyB7Lz/xR0rgy+IVdB7EZh4geypsY2M=
X-Google-Smtp-Source: AGHT+IH3EQN3RQNYxaPT4iIe+IFhGXjDXdXXM4z1rZcTGLWFTn0J7QP/H6rFgBR94R4CuXHZxbQ6osjFNIccr0ld3sZCUkZ0y5D5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1:b0:431:da98:3519 with SMTP id
 e9e14a558f8ab-4330bcf69e9mr48176355ab.0.1761893102447; Thu, 30 Oct 2025
 23:45:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:45:02 -0700
In-Reply-To: <69039850.a70a0220.5b2ed.005d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69045aee.050a0220.e9cb8.0000.GAE@google.com>
Subject: Forwarded: general protection fault in sigd_send
From: syzbot <syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in sigd_send
Author: hsukrut3@gmail.com

#syz test
---
 net/atm/signaling.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index e70ae2c113f9..0fda16975c70 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -63,6 +63,11 @@ static void modify_qos(struct atm_vcc *vcc, struct atmsvc_msg *msg)
 
 static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
+	if (vcc != sigd || !test_bit(ATM_VF_SESSION, &vcc->flags)) {
+		dev_kfree_skb(skb);
+		return -EPERM;
+	}
+
 	struct atmsvc_msg *msg;
 	struct atm_vcc *session_vcc;
 	struct sock *sk;
-- 
2.43.0


