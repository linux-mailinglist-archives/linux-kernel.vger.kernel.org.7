Return-Path: <linux-kernel+bounces-879858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC05C243F2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1995F34E935
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C048332ECA;
	Fri, 31 Oct 2025 09:49:17 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887B34D397
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904156; cv=none; b=Tm10w4sDHwm7Fj5HXEH7KcECm5kyL6DBTzyZnXCOI12aHw9A4p+R4TIzno/HEB8bL3b/8hht3+OTz8QD3QMIVpdG03OizktoFyPxDIszEPS597QN1vzswig6KywaUxFpDZrAX9s7u02wYXsqWSM8TVMYvqX12pxKw1g9eKGGEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904156; c=relaxed/simple;
	bh=F7R7XEZTGATaHd+RmnkfO+91ZpYsTUvFTeSRbikWGQ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qR552Sh3Vxg6iHLzqEJY8w+IM+hQT1mgSWlSGqaJbaX96K2WfaGcwR3xQKc2KjYTAFhGyRmwBeY7PJdpIBBw+NAJHtSxOmkDRvVqmU7O0IMPT+rJhN35C5TjpheVtJ1I26NFUC1S1F5lc/OYq5CXICHmMc4T1by+agGeITRF2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d003e87eso57608005ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904153; x=1762508953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7R7XEZTGATaHd+RmnkfO+91ZpYsTUvFTeSRbikWGQ0=;
        b=dvMOHV3ckioDTSTU3izw+q7i1kkn11npta0IFZx1362FsJ1eCKGnA74U36np/9Zi34
         3rF7vAzN61eHj22Y3WkT1Bx4YzZlVd0ZtNWDxgRk8+/EESBSMkSXdTpEkQ/vs81XBjzI
         TXIcAoNbx4lWGnoR0naGt0sXJRHGCFw+rIF9oeFFbLWlA0kCgiQoGkA9Qw3LMVqFuc3o
         wIavYqtTx06F3sGL56av7AaWlxn/w2OeJ0ka7OuvPgtfDfkBzRD6t3EbffyOq9AVScNn
         Fw6L4JoMY6nzffUsX1soqAXMY6LfoYK6EwUM4msjqbKow/Q7G0s+9sPzL9uU67P6Gbe5
         wGow==
X-Gm-Message-State: AOJu0Yy9tVaIGhY2blLxGNMktA1yY1MwSQ103DKM+8SKpN1kGaQRONh5
	YpiLtwLNlIaerPt5vUFg5OPMpn2fQglsS53oawSBpP4DUfkX2ZmMODczZ1uOsJD6DDg2eZFm01t
	94kq+Sa64k232Fzag3i3mOssZ+exGXlB2O5zAcaSAVxzudCuVkU7VhXzCazE=
X-Google-Smtp-Source: AGHT+IE7Fu9fzKDM05ZImMoX0RA+Z4+DIrG/+KzDfZi5H/8xeTy2NaDdwmwPwHGbx+ECFlkSdymRj/09pfFvtdmFM5/ijtkkpu9x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330a:b0:430:aec5:9be4 with SMTP id
 e9e14a558f8ab-4330d1199efmr45500195ab.7.1761904153510; Fri, 31 Oct 2025
 02:49:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:49:13 -0700
In-Reply-To: <00000000000035941f061932a077@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69048619.050a0220.e9cb8.0008.GAE@google.com>
Subject: Forwarded: test patch for KMSAN: kernel-infoleak in __skb_datagram_iter
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test patch for KMSAN: kernel-infoleak in __skb_datagram_iter
Author: vnranganath.20@gmail.com

#syz test

