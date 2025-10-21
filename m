Return-Path: <linux-kernel+bounces-863544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BDDBF81D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCE19C0CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C9034D937;
	Tue, 21 Oct 2025 18:40:55 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A334D91F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072054; cv=none; b=bFOfJtzRj+B+phFS1oSR2Fv9Gbd/BAxE5y68cyErxnSQEhdm3s9C3DBpQ3YXbiTZyEpdO8yDGtKd0HIgk+Qi6a42ymFfLKv7ThZDjkokeYH+w2QssvNOwnHcKKjth/29Q9j1vhXhlaTypSBVF04brMVxQWl0z+urChTPrWHKfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072054; c=relaxed/simple;
	bh=yFXFc2eCU0RKb423ve3kq3l+JqHC+ndC5/YX4HS1iwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RLVoxRkAl3gOtqSnKjRrTRpu4d8sHyuUruZbJQOqefQPt5qzrY7sewm9IAvqKFhRTt32+2/htLOLBCaJzYKB6ue2YllVOure12XgciEN6VXOQmaiZqONPsvMp2nboE+tSZ5lYB+UQttc385lkcEjMX5lh7CSPkX8LmylOxs1DGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db6d358bso101397565ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072051; x=1761676851;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFXFc2eCU0RKb423ve3kq3l+JqHC+ndC5/YX4HS1iwQ=;
        b=ed3wGxxieRXHUR5d0p9zc7MWofipYV0kwvByQSyq4gynymc1/dJ/cMM6a8BhUnyYZi
         U/gykC36v20CUNP51ZVfwd8BeF0zMAeai1jY6KLE2t3MAzsU682irflzgmMCen+nyArQ
         NXZDA65eFzbzrCYiWiA7mBpqEECFXe9b/mTRlKyjgcDAP9wobbI7pxzUpdsU8ZVIN5Xl
         OciP8SHBje5JFmSQcGr7lzExMpQzsmda64CRU5r33W21r2TL9GphZgNOiGweBgMc4dvY
         0E4Rl2YKQ5oKQwBw/R7rUH7eH9c2p6MfBJ9uB0J/QsGtCUckI3zXMQTv7x+y5r/kRrbv
         5CWQ==
X-Gm-Message-State: AOJu0Yw1RDjEV+KXAe+OavBsqMlRGydw0vCwrAuNdhSfslUPCE6apJBk
	fuQ0P9pt5pMObmq+kjoExjSzNdIOm6GPhTOqV5oHnthsOzzwnsTFb4icRLP2+3Ng1MFrXeUshk+
	q2cmPdlie+oMwUZw3RVSbX9a19X8FhYOStpcm0mbc0YI5nAdNFbiV8IRYpzU=
X-Google-Smtp-Source: AGHT+IG1pBJHjsNUg+Jc0JzpIoZsJ9YR9bKpySFXtNZzpkxD2iDLcxMCLqdqwCBtkumi5ZhU2+pUzDxELVOrdGRTgN3Dv3CpY4G8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:430:b5b5:812e with SMTP id
 e9e14a558f8ab-430c5245f61mr272904735ab.9.1761072051439; Tue, 21 Oct 2025
 11:40:51 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:40:51 -0700
In-Reply-To: <00000000000097e14f0621951335@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7d3b3.050a0220.346f24.0024.GAE@google.com>
Subject: Forwarded: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
Author: kubik.bartlomiej@gmail.com

#syz test: https://github.com/google/kmsan.git master

