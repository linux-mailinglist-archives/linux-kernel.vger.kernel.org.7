Return-Path: <linux-kernel+bounces-863958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B037BF998D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D634E9C54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442B1E7C23;
	Wed, 22 Oct 2025 01:19:59 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04912B93
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095999; cv=none; b=iP86ln1wzRg1XYmkU72YgajhWGia9m4fmISu2qENXYdJBzf8TODEJU/myt5VDY+WL7KTlxFf2vIuwO6UOPZwDVqoZBQ6QUcuPjoFCAZnmo9vj0IOxuKGRBO1oiYSAl29KGOkFuumb2XEfrqyZqhqREIzEQLYN2F5JRPUj5GYQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095999; c=relaxed/simple;
	bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K4jKbq7fZ4SG8AZyr+lY2ip2r7DOrUY10aac0TeO83lq4IlNcztBEGPXbdQGH8tFFyXZbu6XNvLmxxYg7usP3og+SsQumkf4ADC3hQZneVhks4fTI9FvBZ2GuyMnag0d5mxDDtjPyNvWDA0Oxr6r3fznbDv9DWjsdqMxpXebd5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940dc0d7a38so59174239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095997; x=1761700797;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IteMu97IjHShSHgzImd5JSYnm5D+nLz+FdT9D8T55gA=;
        b=BOTaYeQY9DJ+wFa2FC4xxUwcDpiklMGcFmhKVemxJRaAe1HzhoiR7k2AQlRzuVHYFy
         EFuiTjCeadEajrnf1TYAi6JtKhCWAWQxNQb77tbqBN8GxXndYtdaUYb6/yXeoMtTm1GG
         xXG4RXGt9aTJEockfuXXHMtrn21bXR59qFL4FH9BeK0nZ2kL3tyZ1S33patGYRoQgLPB
         ktsp8qN1ik7WWA2ve4PcIqNxfjHW80HmpOziY1xtt/6d94X95lAOR/6S4s/BJJfL7uPy
         VLH/DKjhafsPAYompXN1VMpNBLKbnYFwYF7HzOVVcJIGaZUwEqPwupCyI1PnVVJrexdo
         lAWQ==
X-Gm-Message-State: AOJu0YzNYECUscq5TyXT5mKYBuhzUIXoF9Y+s2n3Xt7VTg7fGx3LHY+J
	Y/Zj01hOPD6UpVz7ZBkSUevDZzpykwl1c7cZxXoWI4W8KPbkCxYCJiMj3UTFPJIgF66HehtKVbC
	gAkIQTEggGkOGt1Fqyo8b+7HuRO8cHg2jQ7DDIU4ACjqeqAXJXTurz3Kmzu8=
X-Google-Smtp-Source: AGHT+IG7+wSOAKZfVh6X1CkK15j0dk8HBNIrSu4+CKegV21v/Ooe08kswr3VpDwJ6WPmHI2e/Ey/knnA5v10RyNx6pp/joslaeZW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a011:b0:940:d3df:39c2 with SMTP id
 ca18e2360f4ac-940f44516aamr273978039f.4.1761095996821; Tue, 21 Oct 2025
 18:19:56 -0700 (PDT)
Date: Tue, 21 Oct 2025 18:19:56 -0700
In-Reply-To: <67867bcd.050a0220.216c54.007e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8313c.a70a0220.3bf6c6.000d.GAE@google.com>
Subject: Forwarded: WARNING in ocfs2_unlink
From: syzbot <syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ocfs2_unlink
Author: eraykrdg1@gmail.com

#syz test

