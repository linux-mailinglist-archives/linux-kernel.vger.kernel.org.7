Return-Path: <linux-kernel+bounces-839897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7AABB2AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C867B2A37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AFD2C029B;
	Thu,  2 Oct 2025 07:22:36 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1F433F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389756; cv=none; b=NlXJIIRwttI/QNr2uNt3LIc1T9XGIST/3WKsgyp/MbIpntUDaEYkiIaw8o+CmEMfjg5C4P4xXmLB8hTwJlKgZIUWkpMx4ueNZsCMpd3PpUiX9E3TYOGgKZ7iavjG/b7oseLEixOqzlL2nWJOEMmj40EwMPcrENRM+OcP+Em4vMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389756; c=relaxed/simple;
	bh=7QKvrEDFQ4uange3//hcr6eQ++HI0Iu0CmAJTLo1hHM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jzpZ1i3RuZyc7/AGCL+H89SdxZwoJ3nOwyjPf7g+91aBCE3rlYx7KqT/NcKios0HIsH6bYinWcCie2x9Hr5Q1O/AK5ESwQK/qAFGrC8fTLzVlnAUD5CLnZJo7SQABOinqt8MXvFiPQaoSBl7sjraFL5x7e38JvuBpnbzVUpngac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-429278a11f7so9637505ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759389754; x=1759994554;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QKvrEDFQ4uange3//hcr6eQ++HI0Iu0CmAJTLo1hHM=;
        b=u7GQR8DDeJSGxbaxmrG/Rf3kfmUxOjkOLP6aRC0MMo0TlRqTeXl/Uut1bAU9x7+1uR
         72KrLcYyMdxOvVOtmYJdpZiNhgpcFqnoFvfFTx0ZENzem3D06YECyj96Wo0Y9zWGLrGS
         0sV/HDE6nek2NSFbA+FaIcE4OupPQ1zbjWvDdek0kRBzkpadUonGBDvUkSNwx28SWamK
         pgYttxYmzj3lm1mE+VcTUzppOA3S82qftcz0hjB7eVMkgBXQbHm5HEU60ieUSfsdw0zI
         2PTckQw2Nu7zbDsvTbVlkMsJvxHoSS4DIvSl88QRhXuikp6Q7NiokwMRFupsVtT83iBm
         WJDg==
X-Gm-Message-State: AOJu0Yw25HZcu+B6w2MyBQMH/Bum6slT128k/gARwlZWTMuWuC4lBm6R
	6Njox1pBTkYyEsEbv5H4LrPLpxpid3dACkUkAlVN0jdahbiUzH2ezcZsfLWlpbRwDhjx54g/63M
	h0ef9JNNSGJiOzn/K6W1TdpsCbrqQA0Q7DP02y6QQ/yMd7/YSeLv7AwdHXAQ=
X-Google-Smtp-Source: AGHT+IEz0hN9tkp5Drl1Z2GhC/oLgyfZjOGkZTcDsGgscRSBIPCMJdaNeTkxkfsHKtayAAwqDV0vp99HYQiunnIWs4GryLucCj3B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:426:39a:90f1 with SMTP id
 e9e14a558f8ab-42d81666f75mr85476955ab.18.1759389753910; Thu, 02 Oct 2025
 00:22:33 -0700 (PDT)
Date: Thu, 02 Oct 2025 00:22:33 -0700
In-Reply-To: <68bf2c3f.050a0220.192772.0884.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de2839.050a0220.1696c6.002f.GAE@google.com>
Subject: Forwarded: Re: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
From: syzbot <syzbot+48b0652a95834717f190@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: KASAN: vmalloc-out-of-bounds Write in imageblit (5)
Author: albinbabuvarghese20@gmail.com

#syz test

