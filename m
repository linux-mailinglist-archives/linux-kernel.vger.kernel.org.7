Return-Path: <linux-kernel+bounces-771117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA828B28310
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CA35E7705
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870FC305E0B;
	Fri, 15 Aug 2025 15:38:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D0304997
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272305; cv=none; b=InWMSUfaiaz5bEJIKFlSuJxZvhJCQzm6M6EKtNFhz3ATaDvjshJAGOI6dr7DAVT6AzUDY9TO3N13uNfeE4WBB625K/nssYS5YadCemnllUXDRIpVQs4b8+NrS00rmL8c4f2X3U9NR5jjIqLW4it6T9584ZuU2JATB7ClX2Fg+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272305; c=relaxed/simple;
	bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=RxVKBkQo9k2BZFnv+HnU30i+TeGXm6JajvO+aF2/ozrFertzlyx67EGnaXe8eVgseuvYSH98kx3+retgiEIwtUltotLiZGiBBgPsYPZVfZ5ZFhRSAhwuH7efp0a8HF4V207wzKBo+j0yMqn5KhmPyoBOre9uAtjKeikOjeOmVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e56ffd20d9so58191995ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272303; x=1755877103;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjcBVY8mJqbGJnCRObWENCx0c6xRt7QNzm9li1dg71c=;
        b=S5ecCs1ujRywIx07HShk2YuyA0j5XeiJGh47wEb7YwMPyUYdGiqQrAkshYvS6ifX2f
         gRW93eBErDLnQqxwOVE1T6z1xLmX0byEgo3i8QWqp7sVwv/grDCZAykWoxqXVH/4O8Ns
         aiWs5wc/i1MRLTaSyO4qmwXqJd1QeWEQK/d1/1609UpGLVZQ4I4MMydmI+z8lY8jCKnf
         qyTBts86Ag9KhOkNiECvubSiVhjANJ7xAkLbX47VdoOy+6vCSNncgZ5gp06MsuMudswf
         wSLQvAVcN+biTJbOPDwPg/DGM0Om6kgK4Y2zwrgvVpws0yIzqH6KFfQwx0Rrn92f9zfK
         EX/A==
X-Forwarded-Encrypted: i=1; AJvYcCUIBeXQaVonim44L49m8L/SYndyw6gFnvDnDdJrkEjZ9uVG14zAQIBVoTIm0Rk11KhyWpmjV2xi4e/XZYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iVcsfpnyS7W94K+u+YcCadQXTNfNWy3/7NAnHYFMk9c+TFAU
	YBLbu0oWmFF/r+XI1jsiTuAuu90a1CfhtloDevrvZTWHcObsNOBmW3Uoqcd0j1/t7v+IF1YM09w
	JYHgxn44s+/0NOrCel6WBf/X/303Enm+tKEHJe/zi97avcU7FvXjyLKAnx7Y=
X-Google-Smtp-Source: AGHT+IEZCErYDJfK+PsAhXz8az/SOFKcABcXNXr0Q2bzIAiRaGBhp8DoowWmbEM2Eo7/QNOXWUZsT99JggtdxpHJX/wQX6tCGYLj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2707:b0:3e5:58ba:d9ca with SMTP id
 e9e14a558f8ab-3e57e8252f9mr48746805ab.3.1755272302920; Fri, 15 Aug 2025
 08:38:22 -0700 (PDT)
Date: Fri, 15 Aug 2025 08:38:22 -0700
In-Reply-To: <b2667c4ebbe5e0da59542d2d9026322bd70c6c6a.camel@infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689f546e.050a0220.e29e5.001c.GAE@google.com>
Subject: Re: Re: [syzbot ci] Re: Support "generic" CPUID timing leaf as KVM
 guest and host.
From: syzbot ci <syzbot@syzkaller.appspotmail.com>
To: dwmw2@infradead.org
Cc: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, graf@amazon.de, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	vkuznets@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"


Unknown command


