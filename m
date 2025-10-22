Return-Path: <linux-kernel+bounces-865762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05BBFDF02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D1C3A7729
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C9325480;
	Wed, 22 Oct 2025 18:52:41 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830734B669
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159161; cv=none; b=ayQ4wR5DGm/4OyWOQtKL9NRq4HzKApNXyD6zzcHzcoM1ydG/6mKRsTYoSeK5zUi3CJU5B0lS9nrKAw9obZ9KwF8LnYVhX2f2w+71CD1V0hV/Mjkt3ShNeuXt/7ysg1GZk7YgGH8dKQStBSGoXVhuYfb9a0qIEFaUuR0YP/XxrS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159161; c=relaxed/simple;
	bh=ErPm9thxqfgXSjfDaND7e9YnwwD9pyLOoFbZqNywZkY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWRVADKWPMXIBWHMXi4fWB8EiaXskSv/zXmRVZOpDhoOjv9roQgEKUkwSqha9qBVnDNBZ1OnX5eZ4flpMw4gdkgVlChbj89TLRb2BE3hrY898X4o3MU3fDGKkLVIxqmWnZE9hwKPIsG/fOTdyhuPfUy3GfZNguu5hJImCfUd9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-92c122eb2bdso120263639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159158; x=1761763958;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErPm9thxqfgXSjfDaND7e9YnwwD9pyLOoFbZqNywZkY=;
        b=jHLi+87Dw0LIrBIP0thO5XKKtXtEQkD0xTSQI6YNI3xNzH9A0mJeyj1QcqMb6t1gAB
         mFI9rINvDzamGU91Y4fij7s4ttolRIBIppN5/LnVj2vdc0fifbAMQGX514yhyibew3Je
         NWjKEPROMA6TZ+Uv4mhO5m5IwXopWPFLHkWZ1aPsKrmj8LVluvPDSd7iCU2fLn1e8LzC
         ZqV84YgBzzqT0lGtng0tF585G7HRSKBMWPOk56xpGwkKz6hj5IORuOJZX+As3yb7mm45
         7Kbk2tRdXvp4p7rygbR6visk9kydOr7a5F3tN7Ff4l4GpMiROlDY8oWcftcjTsmC4Fdn
         by/w==
X-Gm-Message-State: AOJu0Yy/iUY1OpDiqcFfXVkiJirmBhkxuOH87yq5jQ9HKiEMCz84AN15
	Ogk3HsYgTGjYuXTlSKmyBwlhCosLHXP3b2tdEohh0S6zQoDi0HYywD2vxfH2Wtx7M90mxu6yX0M
	ju7pcSidZuy+6LDePSHFfoB4qEZkpSugVlWvZPV6KaxU5OBbOMsMW9cxKwIk=
X-Google-Smtp-Source: AGHT+IEMUeurk7KnyETEHKSXrRWxzzzaocgwTg3BxkFtNh9H5Iba9Z11af6oIjZeqCMUpxDPZiLf3BrH0rbZVMZ4abN6aI4Aw13D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a011:b0:940:d3df:39c2 with SMTP id
 ca18e2360f4ac-940f44516aamr645081939f.4.1761159158654; Wed, 22 Oct 2025
 11:52:38 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:52:38 -0700
In-Reply-To: <00000000000097e14f0621951335@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f927f6.a70a0220.3bf6c6.0022.GAE@google.com>
Subject: Forwarded: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: NTFS3 : KMSAN: uninit-value in sw842_compress
Author: kubik.bartlomiej@gmail.com

#syz test

