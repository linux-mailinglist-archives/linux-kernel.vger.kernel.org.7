Return-Path: <linux-kernel+bounces-879323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DF9C22D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BED04E4D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C8C21D3EE;
	Fri, 31 Oct 2025 01:04:42 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AE20298D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872682; cv=none; b=Pg7jn7ke1BWe26s2Gs0mtMOY/sDUX8CZGsjNRgtwVERpb3GuNuynmRo1/vIjkfrBIiYPXJSVgrAMpiML2lFQuZdfpOMhI+pnxjAAWo/ZbtqtzutF+W0zur9nD1bxrxeTcQqriPgEf0q7V6veEwdAlUwVuCVtTahO93b2rh1rTYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872682; c=relaxed/simple;
	bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tX9lyWEWySPkRGRAE61qkyY57MHG65JBw/ZIPWsIeqKy9qjSkUK2ZIscvQ39ZXlay4C+4STEZL3MHUUlJ7ZIaFiqs+QCYRW0cP4eg15Dcbmg/qjHRWHHnRgGuSvoMKKmo1RBDNC0n3hKAHRAb267QulJBrRZYi1TB4Xg2S34Vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d3a4db56so57758085ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761872679; x=1762477479;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M71T/ZJ+3xq/7S9fMBH541aTzoNX8hQXml3aB8Tq6G8=;
        b=utpIZr6iclUxz/GW3Fe0a1OUTvKo4rnqllpKO4QCOWQmcjIuH9qbNEH7ppGnFlYCHv
         aefHw3fbVgK6xxOy9crNrYbl92mBjfhwDpKFZNUVANVuzipGxS6vUYaSmlrpNVQZf3yn
         np0E0DbsQK6PIBeE5tH2+p/GWPiWiXmVIqcaazHmVdZZk710k5zeBkq94dKqb6W4cgqD
         4OCFtRJAegAFhpQ5NqWPk/wz5xl9hYuiHcUODlvvJYHz0z2u2HCeoX5X/krgrdibSc4Y
         MMG+54L64OBoGbfxKv1QhH/IG3RfvanAmcL8ycAon801mXTPovJLNX7i8ZRfS/nCVAD3
         IeQw==
X-Gm-Message-State: AOJu0YxBnOgz9P0pxDL64TI4TGQtcvWCUg29HMNw3UqyN6MZIvNw2Mkb
	sYe8w0NmxQ265UohkK++xI6aO9nhla0j8X/8y3W+twFDRdUVMY6wK+KT5MWXZLVKiru/7rzrslG
	HhmOpUnNKIAjMSAtGpzK/TkUJjqN2IXWNcfuJfaFdENs0VPL+dOXIiS9t5is=
X-Google-Smtp-Source: AGHT+IFJsHISLrNktGAKLZiMWowDS1hkypeDQn1BV6tW+TCnwUZCxg8wKxPaePqJ5SEkq2S74Si9hSzospHVwDaQA5Cm6aZQQzuB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:430:a14f:314c with SMTP id
 e9e14a558f8ab-4330d121e2cmr26381185ab.7.1761872679339; Thu, 30 Oct 2025
 18:04:39 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:04:39 -0700
In-Reply-To: <6889adf3.050a0220.5d226.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69040b27.050a0220.32483.0232.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook
 (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
Author: phil@nwl.cc

#syz test

