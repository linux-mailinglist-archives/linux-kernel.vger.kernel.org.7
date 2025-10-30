Return-Path: <linux-kernel+bounces-877737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5963C1EE52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521BB1886E13
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427C82E8E06;
	Thu, 30 Oct 2025 08:01:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587C285CB6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811305; cv=none; b=YNoJWXmls6PCCTztbzMcD+I85gNfJSQng9Jeman/W0DWVhH9E1jx7qMgdd9Nh2IL4mmXOQmqKexiRLSC4Il8SD1DfMVOKbeQDrGm4cfRnJgcFjYW/I3+z+/7nZQ2zTusrPLHePQanbOSDG8SQwB2cpSaJRyHAzVlhPw4ksUvUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811305; c=relaxed/simple;
	bh=CHSzWa6Pgo9DFqoH8kX4q+/Rql4q+Xu7xj9xIRz96vY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eF8NYwpY7nEKhsVXzXwMZaUYyK5noF4/tUmM4XCTpdpYnG/7iLoC0IQ9wYmxJc2DJyGPXFTgoa4X6Sz8SMMKtNo1Cf6YfWSB0uQKFzT8rHQn10OmcfuU6yegLfwCaW4/V5v3xsQEzKZFWlAb9F8kXh41pb5l+XjeU66xpYXCpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940e33d65b8so216467039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761811303; x=1762416103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHSzWa6Pgo9DFqoH8kX4q+/Rql4q+Xu7xj9xIRz96vY=;
        b=prHn3ZQ/jtqOjHdBDsayJUOXrmt2B8n238U/SpTJhHDJLUV1TOI3EjpSwg6RrNDDG5
         jOpiTnet1+8L1LaO/Zs+x9kLJs6dZQg2klz+N6a1a7J6ZKFP6bbv/TBjAGZRagBw0MlM
         D0Bqzi1eDH0VvpQEgdGKZ0dRltrGZWm3mzhaFnRjkOjwM1ami41ORoYUBEwyBbt6ISh7
         2qcyaZ9V3cohlA5eoyTyY0m/YrM3cYFXG4ReMNMo59pD12RApWp3vjjjz1FJK+/28OxG
         UaicfqJE0kiX8h4d7WPeoW088ohYv5UfpMUC8XdBtTX5URHCHjarO8j2gko211ORWTnv
         iGbA==
X-Gm-Message-State: AOJu0YyDHUSE+atdY8iIdoIqaPx2GNzEbaBSCHskqR63hYDq0Vpbs9cX
	AkPAKVKQ/7YCz1llMPcrN84+zqk1FY24Jpsck9CMUSKWTvwdoIxYOzp12p/OzzT6CvvSOon7/ZS
	D8cgaykcFdI8I3m9D4BvIzJvTzNEgLjxygyZ/Tl45KmzdDEdPZt0wQwtXQYM=
X-Google-Smtp-Source: AGHT+IHy5fcY4hFFGpUaRzgkenCVD7seitQbCa/LmuIwV4I0yXeRRSfaEwqwjr+494Va9M1FMP4y/8ZIGeprePBWspiPCPLsESgF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:74a:b0:42f:983e:e54d with SMTP id
 e9e14a558f8ab-432f8f81cc3mr82294705ab.4.1761811303817; Thu, 30 Oct 2025
 01:01:43 -0700 (PDT)
Date: Thu, 30 Oct 2025 01:01:43 -0700
In-Reply-To: <68b6d7b3.050a0220.3db4df.01cf.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69031b67.050a0220.3344a1.043c.GAE@google.com>
Subject: Forwarded: Re: [syzbot] Monthly xfs report (Oct 2025)
From: syzbot <syzbot+0391d34e801643e2809b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] Monthly xfs report (Oct 2025)
Author: hch@infradead.org

#syz test git://git.infradead.org/users/hch/misc.git xfs-buf-hash

