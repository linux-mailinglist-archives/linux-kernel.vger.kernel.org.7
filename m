Return-Path: <linux-kernel+bounces-890822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82476C410B6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2781A407AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD653358A1;
	Fri,  7 Nov 2025 17:29:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383633507F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536572; cv=none; b=rV/HVR11SYpt1PaWfGNBYmxFgLVvRI+ZdQ/0pb1GfdV+rQatQ6aG84ugkV2hPTShMJvbsF239hYpfcT8Z9+0hbjeUJuEr8dQG/I+pgaDQisUNghl4U7zlcj0ZO9unDTVUOHrmbwdxgqNkUaVzNCWb2qB3tzEmuTyTTO2uMk8FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536572; c=relaxed/simple;
	bh=CCX05Ii6vgWlUYqU5SFTFYscVwlROXPAzZKWhPCiGrs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cJdjIgRGNP7t2ELustdED35t4SHO3zW6migP1FjQeh7vP91glbRsW+Rwr0HWBtoFUUFI2S4cU3SJpQiRkETyyh4OGYeGSbF2mYLCSGrRoCTBj6NNMq6NMt3KBzWrBhWL8IbTdVclLZuKZWaVo2JVibxGUB4SgQ0dWdLKse3ikiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940f9efd090so191976239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762536570; x=1763141370;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCX05Ii6vgWlUYqU5SFTFYscVwlROXPAzZKWhPCiGrs=;
        b=PeyQGPau5Hx7Qa+qAEgImexuW7/lsNpQOIGJMzOXPsMJm5FublgF8312P/t4l0Pp/7
         cyIRjaleiF4alq31jMe58V1DepQsxDXq2Yr/hkrMCciHHsCXPEf7BFJdZkhkFPuecGPQ
         ezwP2X94Yj+Fp+EmqBVQ/1WF/j7Lfx88BZ0Ze1zYQdbDd1j7+8yx/wPU8yw0/vmm+JNi
         4WB9Vgk3kDzRE77Z4B+ly5csXNNfvCZVrzpWv1BX/h0nZavcHDJV9TI8TTME1b0sP3rI
         MJTANP2VOknCEQAJ7kJn5JYwWQ4k3FApyCcEBGZ0bNzuaIfEWxeOOV4wNY8HKacKdj6D
         VF2g==
X-Gm-Message-State: AOJu0YwsM22z2lUBf0ZN/TscRwB3/IwVbwJX9zkMqDM8vNRp4ubLYdQZ
	GIgi07GOLE51tFhYz5opgvUFEdqoBwcprE3PYsTiThDfa2M+pFeerzpGHNDu+WEwNXiQGdXl/8q
	v6dovVfrujyBWJ8xLBlnY5itGTuwnxYCGh+o702lXCa3eM49toV2MTUL9dvk=
X-Google-Smtp-Source: AGHT+IGEruED8Ae0FaDOSkqgoworBMG9Rr2t28NzBGBNA+fuHH/SWOT5XRp9GD+7QAytOX/+mMCTUq8LJO5HbvZuEIQten0WtoEk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3186:b0:433:308c:19a6 with SMTP id
 e9e14a558f8ab-43367dd84edmr4827855ab.12.1762536570348; Fri, 07 Nov 2025
 09:29:30 -0800 (PST)
Date: Fri, 07 Nov 2025 09:29:30 -0800
In-Reply-To: <67afa060.050a0220.21dd3.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e2c7a.a70a0220.22f260.0058.GAE@google.com>
Subject: Forwarded: Add module validation parameters in scatter_elem_sz
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Add module validation parameters in scatter_elem_sz
Author: kshitijvparanjape@gmail.com

#syz test

