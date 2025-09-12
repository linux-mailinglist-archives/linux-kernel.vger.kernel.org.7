Return-Path: <linux-kernel+bounces-813392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9919EB5447A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16497B9ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27892D46DC;
	Fri, 12 Sep 2025 08:08:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E72D3A88
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757664518; cv=none; b=g71lF4KjZmLKuumJ/bcfnaInY2rLLhMCxqgOIylldLqf0rBfrrCsCGSh2gbIRLeU4BMRY/khOFB9ru80tfJA3QPbaVKABfZGxe4Io6RtJTNjuyA/c5gEvO+/QVLLhjuHbhIHFPfVxFMprGGV83ajdE9TeDV1yMHGtGD5IEhwYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757664518; c=relaxed/simple;
	bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hxWyTWSEJHduRpXdJVpH0Xj0fjCakpxIGW10+/f3s6Jvba2nVTNcLF9zT67F3cHcutYmmCNE1EYrMgu0X/g6sd+A7IExhWAUPZiWfA5QEJt7GmPMzzikYKAZ6oHX55o3ogoK9OBtfN91lx37fh7SYNyoE/MOignocweP7yVfx1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f65be4978cso17215235ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757664516; x=1758269316;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
        b=QX+5hRYz4CVQdd5BEa1IgJYY8s3BThPSOREq6xaWgC+shlTT9P+tm2JWhgn4OB790R
         LXZXt0YFGkYupd/bhTHFAeV2Y9DprOVvCc2ZI795mpK4jDJjCLlZH5bzaArZXq2QXO6M
         1JfSl8Ir+XAQdbUIxkt4fpl03VBtC0dXneAA6le7EvVIjH5eCtjSwGw2nne7QRE0YEUd
         IiA7syX56cH8PwwhI8iLezP3ffnSRLpz9bqLEzLvUYILn0GkGnQpTcsDrBnSII6oLg7x
         ER5ECr1kK9qYn4cbSxdzs9XAsoOgcn6O+FBMVoOqpLUwbU6ALC6Rd/WEl/M5IHz/3r2K
         sExg==
X-Gm-Message-State: AOJu0YwtgneongmLug7Wxd1CUoTp7JO5gZFiSYxcALuUxQ00CftF3/GW
	W83aCgJrEOxs+CtNAKRvbjTcVVgwOYpFruAvzpXb5sNcavITAnpcVU0wLIXA25+9lueMY8xN+E6
	hc4cQyhWnqXEmu1GOBvYseoQsQoVEVBXpvUaTLKVHqxI9vDUfDtmYLeV9cbQ=
X-Google-Smtp-Source: AGHT+IHPE4sM1xMYjTfhF1My69fNEFVRZgwp+d4OH/euKHvsvjz8iVTBIRjrl7Nu5McM6qZT1qbkSBwKhUrhndpd1LSNhTwRTetO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b03:b0:419:b24f:30e with SMTP id
 e9e14a558f8ab-4209ecfcd62mr35467825ab.10.1757664516073; Fri, 12 Sep 2025
 01:08:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 01:08:36 -0700
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c3d504.050a0220.2ff435.0355.GAE@google.com>
Subject: Forwarded: WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in rtl8150_start_xmit/usb_submit_urb
Author: viswanathiyyappan@gmail.com

#syz test

