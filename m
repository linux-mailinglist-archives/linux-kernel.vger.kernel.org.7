Return-Path: <linux-kernel+bounces-771725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D296AB28AB8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030E9AC764B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747501E8836;
	Sat, 16 Aug 2025 05:43:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA21E572F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322986; cv=none; b=OLSBE9S3mWvl6JC+hXBN+3tyUAml+h3phXJPvWHn1ctjK63Avv/Z4TjK8FSZtoYIYgIUZEnvDqmS7/Phz8YF1n7HUuwss9BNwVKBvdll/eY2l3EWeZ0jEllojdy4JE6mmBnovPlSt0LHTJZyDGDb58DxKl4aGqlcpeLs2iMO19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322986; c=relaxed/simple;
	bh=SuC0OtKQetmRG775ojctOPc0XRPbaPBbipXfi9sPpF8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qFzBwPAaLREBN0JTMyfxs2p9MrEe4czIDZU9+KcTvf3+KY+sQD9ZJGROrOUzViaILBZ3BYJ8Plg/6r+EipI7EV2tgR7jVE/h1J6rJH719NGSqTur04lY5FWgtcTEmgJA2V0lNuRins0mpyMszfCcqEEs4X/1ED4ZXhUkGJaX/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e5700b4c7cso30635175ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755322983; x=1755927783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKan3ujft8ShrI9YdEBmBmFd92nGGMRKlG1SJQiuGWI=;
        b=gWSITk3B0dN+WMDUnhyLSKwh4PYizqvAX6IcsMVzJpruIz1afn9jXpBL7dSG3RMEPW
         dVQfC/T0cODvK3NVOQkb+QUrNm0Qq9j4X6CrU2ATACtGHPPIsNu8Q4C+pjI7C6m92O6x
         O8nMcM5GS9iz773KMAbt+cRqEONHyAioe6kOSF5nJtyRBBCTQXdlj49gE5uMt0HLsgd4
         RPgtyCZ8T6amfZAknnPLopS2Z19BpwMsBbLjo8MdUbKj/N/dAX3km6d/OkMrCFvFRypP
         Za23/5DfvHfwxxhzGgpDsQZ1U6j0La+2sUd8D7Kz+7fpGuMOqysIexdlGRq/lEWBRONN
         pIKw==
X-Forwarded-Encrypted: i=1; AJvYcCWGPfPF2KswL85ze76IXiGw/08io6Uv25+uDJgUUj9KE68C+4WfJJOKwwO4xXqhsni/G9mYDKkAXyLKAgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJ8TdcV8GOwJ9U90OofFPpmGba/1C2+mXIEGgey0bvtWG/YCg
	RW49yVYT5Selrk66LGyS0nPRkEP2iMnHF40t1F+VHWCz8dtZHqjNapAQDvfAoo+5nCFMQdAxBRo
	W8IItnzm19k42kt4nS6pcomCWi2rqm/zmK8AptAJW/SE5ibBXau3cBEi7e4U=
X-Google-Smtp-Source: AGHT+IGdeejm1Kd+t/c56Xzr3Dvg2aSSQ4piH3B3A4gypssyJs60lcOQo/6PGcuLL8qWLpl2aCQDvUTrTgl8ZQqacN7kARwQXRa5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:3e5:4b2e:3b08 with SMTP id
 e9e14a558f8ab-3e5837f0554mr34884695ab.5.1755322983687; Fri, 15 Aug 2025
 22:43:03 -0700 (PDT)
Date: Fri, 15 Aug 2025 22:43:03 -0700
In-Reply-To: <20250816051826.4739-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a01a67.050a0220.e29e5.003d.GAE@google.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
From: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/smb/server/transport_rdma.h:64:61: error: expected expression


Tested on:

commit:         1357b264 Add linux-next specific files for 20250815
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1249bdbc580000


