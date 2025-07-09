Return-Path: <linux-kernel+bounces-724219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DB1AFF02D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51A57B5D74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D206237708;
	Wed,  9 Jul 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="GeIHh7Uo"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E32356D2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083584; cv=none; b=lr/3wCoXzHBOC5zeyGhY9VO/LZ7sk7WutTYBLhIfRP9JAiPa+fmMhfoWuwu2q3JwSoYkHk3nQckpI+GB+Tk7k3lJswS3Br293S7pdnuHLQgukSCggvk9TzlFoNuKWtHHocwtyTF6tWu9DsoI5szNnavV9/cBI5eG/HRxigmQMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083584; c=relaxed/simple;
	bh=5Ia0HRV7zH2WBWN+qpcO4e/eQosXMi2uWlBScRIgOoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne8fzBK9bmkOXq2RHtzdwUSjhahIWoqQKv31x2mnFv6Dcw4wHDCgUVd2UIFJjxXR/AnNl+cY85uqzpjGT7IqINC0wy0dKM38QS+qoBmiWBEJYwsodopAD0sydjaoeIJ/J4+Vc0mFHah09lNU7LupTXJ1Nse458kcxtbI7nwvjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=GeIHh7Uo; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso2653206d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752083582; x=1752688382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kcOerGxtDRl0IqsXa2Fyv0O/gmOLQbQigHP1EIwUd0=;
        b=GeIHh7UodvyMCRJ8oB0ar8ilUn/fFCiaTul5j9IwXGry1mmBfZFTuRV9qafsayDVpn
         YSF2TLFYLj4yDDN/VvtbF9E+dffRjovmPzWmQZn0CtuINVtzkriImFEKt2mbP7XNFW0b
         3vwq+2FW9y6pc2Lel0widrJ7t2rIyuR9ZOx1VG3DtkwHpVyc0hL7BuIdAZlslvF+awB5
         9JjQNLbDQmTX9iv5XgBUZOJ3igobGqbe3Nivs37hq3UpjOPzoNu4ifB707Zo/2X2TO6l
         D4x5K1osPBRCfjca6JxOu5O5somCV208lCmsgTakQBs8Jj4b9+16h3h/m6cQTn4LEwCT
         Yo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083582; x=1752688382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kcOerGxtDRl0IqsXa2Fyv0O/gmOLQbQigHP1EIwUd0=;
        b=pj4E/i4WY1cWPElU9E6IM8dI+NnsoBCgG/9ocvxfvjMFnuJJUZgz1hI2D+Gz+oXz+J
         sB+RGDKbpMUArvH6t80FMoq2nSr+VIY36xTSHDZcL24a3WoJZbPaREYhXBhNs6Ub+KUz
         xhxyEZieI02BzOpap+M48x7OHAa81XXYpsvUcboJrp3LDOisq34flEw/9iFVy2KItln9
         jYtjOPl2oFCgPnvMT1jGnb9WVpXeKijd8wJD0+19TUv/9/0sVbfk8K9mJriC/qctcdJo
         mToXsbVGK+xgCjXfkTqGvSV49MBiyEnd2fkxB0A+7QtyOnM+hwoIRIic90MsEFWM3k+w
         4SLg==
X-Forwarded-Encrypted: i=1; AJvYcCVMqq5l0Pb3GE6r6xLE1G0xUfz9JdWjTK1enWCeIdvXUGEaHX9G4Z2LbJKuz+U/oGJYhVhau3Sc9v8RW5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZLN81qBaAOHd3qU+QFV/a+xTpSB405b6+gJJ5UOZmRJqezJ9
	wXmZAgllUOspPGe9krg/sPv2iud+ChockU0Z++TxdtuaJOaOczJfRGFG5Sv5hcrkew==
X-Gm-Gg: ASbGncuwwNM0FJOUQ8wYK6tgLKD982X2NlVE9qUROdt9ubZgB9Ciory0I/r8lVil1Fb
	OmYrplqnjOXgRgVfuycWuA4pIBnT2sGZBiipwO5NCLUJ3sJMPPA2kqcTqQmwYACubreXmVkwGcq
	f3UoEiwuSnlYi23PM+p6Vcfq6u5v2s60C9sj4KSzfC5QKYiOp6us5/k5xh9Qdg2RW3GMDXcUUPS
	ftqfbbY5JHtXe5mWtux9dSLEyBGZEOxrdlX9krgH98nq2jxdW/ckv2GnaWazYw90ztLdytDw/b9
	3pAsbZi+QEVYN5o2/3E08D3ih6/bxZr5cUGRgizwT1nzpFAKNEOiPAPlFrfAzhxI3MKUKys2mlW
	BaPJ7mxN8tZ1FQTgqKyLGFjbnpCaodVDsrmbu08Se3KSclP1XD81bO94=
X-Google-Smtp-Source: AGHT+IHR6B3aBT6nP0giOBXXSp3GYX42d9A0RoMZKZC2VFmh9qTAyRprUaeevr7Q5whyisQ/mru2/w==
X-Received: by 2002:a05:6214:5882:b0:702:bc5d:475b with SMTP id 6a1803df08f44-70495a2ac6amr5938216d6.1.1752083581895;
        Wed, 09 Jul 2025 10:53:01 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-52.harvard-secure.wrls.harvard.edu. [65.112.8.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d64feasm95362966d6.121.2025.07.09.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:53:01 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:52:58 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8258d5439c49d4c35f43@syzkaller.appspotmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 mon_copy_to_buff
Message-ID: <681c4eac-e812-4022-96e8-cd6cada73910@rowland.harvard.edu>
References: <5de04492-01d3-4b2c-b3f4-8c2237dfed6a@rowland.harvard.edu>
 <686c14c0.a00a0220.6237c.0000.GAE@google.com>
 <72fea4f2-40d7-4f9f-a08d-b1ada781256e@rowland.harvard.edu>
 <5644bdbc-8449-407c-8e0c-e725e10a40f1@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5644bdbc-8449-407c-8e0c-e725e10a40f1@rowland.harvard.edu>

Test patch to see the contents of the report descriptor.

Alan Stern

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ d7b8f8e20813

Index: usb-devel/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/usbhid/hid-core.c
+++ usb-devel/drivers/hid/usbhid/hid-core.c
@@ -1043,6 +1043,10 @@ static int usbhid_parse(struct hid_devic
 		goto err;
 	}
 
+	dev_info(&intf->dev, "Report descriptor:\n");
+	print_hex_dump(KERN_INFO, "  * ", DUMP_PREFIX_NONE, 16, 1,
+			rdesc, rsize, false);
+
 	ret = hid_parse_report(hid, rdesc, rsize);
 	kfree(rdesc);
 	if (ret) {

