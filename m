Return-Path: <linux-kernel+bounces-754208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA178B18FBE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43D83A2BE8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2061D2561C2;
	Sat,  2 Aug 2025 19:11:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012A23D291
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754161868; cv=none; b=pHYq6eIskSs3c+iaqgfU2R1pfaQSr4nd5Y7JYmugDirhWmSeaQozDeiDlHDdxSIQjXpLbGU1SVS7n39oo0+pg8/3w4CZgEqQWQrDFS/cFGb1xlhsUGq0ZOCADAIm/9TD5nEQbYxH5Oua3T/LlECbcfl4bS7SlZv/GKFib0GnUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754161868; c=relaxed/simple;
	bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hi45D692N3SCUS3n3IyZta59BtWRv8eYK8Jc00XJAOP0e9W0vF+bveUYkUyE8gUgScBXqbv02wRc+BQ+nOIKkIHmQRs65Yje6v5saSyGgi8QMjH66WLlOxVrqO2Lw2Bh2p6v6+A89kIFdxnaeQVKbARxO0WU9sOTQuyXpqnK9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3d7e44ac5so68472715ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754161866; x=1754766666;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seZIdjhEqK761PCns8qafAjkaYmK058tk1d0tISUzi4=;
        b=Fh4Kl2agLUC22qL3jmzSWJ4MZGSZuhnLb7Jxigz7UmJLxbGx2swUIiIO/SwCR5Y94V
         8RUJXc8WCp0LLaRGLaDhZssDdIwPnNCy6+ANz4kdJTBFcCx6eXTcVpji1L41427yMT67
         eAQakWcTB2eBFYo0gZTlq6Kv55GiJD+bWe0s6emg/9IOGUa02TFV4cp8CX39ULaFQjVZ
         yhm0Rw8+QvE5EyZYHo1iCLBD4nDxbGTpBg5TYDhdQmHjQ/h9Xv2HTGUKoHvnZkOnhAlg
         txEfXfybGVmVXqFhM9eSUeGc1cn3g/KUFOQDFX2PBY8aLvtvA5JaKYrV2gdCxGZP/ctC
         3gAw==
X-Gm-Message-State: AOJu0YzCtE8sVzKJ7xefsV0bNkifMPcVTZGovFVAdREpirsrAFuF2UWN
	s44eKEgtvmmI50mtCpu06gdjMsr5WL0XFV9ZNEWItRXTYdmjcflgUshH/nhrcGu85kxEGXxR+W8
	vDJxfYvOitcSpyiXy9KKOPEObiuu/aM+DBd4HnACoEpg4vXQNggSXE6g/QkU=
X-Google-Smtp-Source: AGHT+IGWwW82ZfTEDUX7ZjcGOm9hj6JdbSs4Cyq9P5eOsFug2uOINUt17YNrhZGGUwUKNpa3PuNW1TMuvHOgqNVS0GfD23tmpFJa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:3dc:87c7:a5a6 with SMTP id
 e9e14a558f8ab-3e41611a22dmr78366805ab.4.1754161866623; Sat, 02 Aug 2025
 12:11:06 -0700 (PDT)
Date: Sat, 02 Aug 2025 12:11:06 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e62ca.050a0220.f0410.013f.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
Author: ujwal.kundur@gmail.com

#syz test

