Return-Path: <linux-kernel+bounces-817683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E10B58550
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9037B4C1A61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED32B230BEC;
	Mon, 15 Sep 2025 19:34:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819A320F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964882; cv=none; b=iiKWEbW+eBxhmCcF43kUodyT4HMlGqzfFrmrY6vbyLpTwK2tHqy1GZWwy6JfNTVTtOeWVX8KeBntNhDBS1bLxV8cbl56VX9NUWPJN6qjUwV80BH2fwfD9hyh+GjH9oZrQa7h9ocwBObUA8zFrfnpVzl5nP9QkTp2KxdDw5zS618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964882; c=relaxed/simple;
	bh=p7Cu3QIufw6JRpY1xr2GryNIIm5OB5Is1DwaxNYpTlw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F77CWy04nr4AeN+Ew6iSPawb2k6C1Jlx6gQD/W2LRFN0fdZ15ATYkl/t0ixhhVEyrRuT1FVBZp46SYV80CwqCpLxVKNtk3M9nmGgGmakz+T0+zd9zry64RfTyUKJSn2clwuFbM3jcb2HmRe36IhuhAvv1A7HwBhgzRsJAKw9vCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4190d8f16c3so56225795ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964880; x=1758569680;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWt6ZEQU9vuHd4U0RnYGBY9qPiXsMawrus4jchxtOH8=;
        b=a8UcvpRJ+D3B+OE9xvtbyMS4gkgqfS4REwO/dEdIiXMFO/C9NLVL7W3qVOKuPQ6vPp
         csTanFvwE4GhWn2VAFToLDgKminHGUH9wZq0lZQ+QiqvyEVUxS10SaLRHyYcQasq6hKL
         nDnHDXSzuDNBD6matA0CMStY1i1zv5u3ouRp9zVMsufQq7J3CFB1qjgW2xEQ85bx89KX
         TNnAW0DaslbysPpF1jm/IRQHlPGI6XGJjq3CwyOEHPODzvc57ia5nERVbY4HU4aRiESQ
         TtiJR9mkbuRCoqU24QQmXyVoI4XgXhdhSLYqQ3BQRXd1Vxfzn8bCh65tXNcCs7Jk9WX7
         sgFw==
X-Gm-Message-State: AOJu0YxXKHUkF2nXU2cTKcxUZYD8hWtPb/jr5tUh58JXckx2mYaajFR1
	mlbz7TYhQ6XQKPXXn+UnzY807/QLYtAGRD2FZB0hYU95lQDM8y9jWiRNf0+I1lrCVqtyXfR7SdN
	PvFozvurhW+Q3ZbrGqDb4MUvQbWllnCcY+6oTwYkXOw+SoI5dAMx3c1HpZkM=
X-Google-Smtp-Source: AGHT+IFHprOaYS4AtyzWB6zfEf2ETnqOtuSRLj72DHL0EHZN8p0AmsC2BMvR7BUKVeJrazs3YO5ZnZ6GFUYtSuOK0dhbUfzd7aIH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:424:9a5:8590 with SMTP id
 e9e14a558f8ab-42409a586bamr27618055ab.29.1757964880251; Mon, 15 Sep 2025
 12:34:40 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:34:40 -0700
In-Reply-To: <68c85874.050a0220.50883.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86a50.050a0220.2ff435.03a8.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
Author: deepak.takumi.120@gmail.com

#syz test
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 482f62a78c41..8e17500256f1 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -689,7 +689,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                        count = cp2112_write_read_req(buf, addr, read_length,
                                                      command, NULL, 0);
                } else {
-                       count = cp2112_write_req(buf, addr, command,
+                       if (data->block[0] > 32)
+                               count = -EINVAL;
+                       else count = cp2112_write_req(buf, addr, command,
                                                 data->block + 1,
                                                 data->block[0]);
                }
@@ -700,7 +702,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                                                      I2C_SMBUS_BLOCK_MAX,
                                                      command, NULL, 0);
                } else {
-                       count = cp2112_write_req(buf, addr, command,
+                       if (data->block[0] > 32)
+                               count = -EINVAL;
+                       else count = cp2112_write_req(buf, addr, command,
                                                 data->block,
                                                 data->block[0] + 1);
                }
@@ -709,7 +713,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                size = I2C_SMBUS_BLOCK_DATA;
                read_write = I2C_SMBUS_READ;

-               count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
+               if (data->block[0] > 32)
+                       count = -EINVAL;
+               else count = cp2112_write_read_req(buf, addr,
I2C_SMBUS_BLOCK_MAX,
                                              command, data->block,
                                              data->block[0] + 1);
                break;
--

