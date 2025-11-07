Return-Path: <linux-kernel+bounces-890226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90013C3F8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD8C3B1674
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25A30CD86;
	Fri,  7 Nov 2025 10:42:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AF29E115
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512146; cv=none; b=IojMt/vzdvHL8LKufIcSpB25UEyQzB7hsZPEKSKDMao37SzlzjpS1kee6PIbKAh1/Ths2gLnQrKzKd9L7l6V/8OueEhnZrM4FKKXX2kgXI+WhSDfnBlyDZQiaJV87+4FjWUA+h93Cxy+OTjwXH22NOXAdXQXWONCczVIgaDF81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512146; c=relaxed/simple;
	bh=8nx4zn0Dw8yK3JFLS2n5BbMBZbNLMaORustX6JMLfpM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CiF29N4lVtN3XbSpPVTVT1so+5hF1Vg6hmlk6qujpmDdPRpOpFAC//nFDAaZrqdBSHmhTGp2w2nqvhvWo6pLhpXJycwQAdJx608XC6NJud8DxC/wWYD123MAHpNunaX3jpgPwjXdpiSGlWRuY3AjxmXCjrre+OPMmCdJfMryfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9487727ded6so39007239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512144; x=1763116944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nx4zn0Dw8yK3JFLS2n5BbMBZbNLMaORustX6JMLfpM=;
        b=d1XaBM21G+d+ujvzwFU+PTbKps7FHIlOstogxyXOCPMBzpTHD6/RZa6nrRaY7vjNqo
         ptDMmNEQTrd+sEXj4dpSISsgaFwj1m90gs1qc/Z5Dfi5K4xS6/iOxEdF6h/N0yYmqMhH
         C4lbl+Z74OHfDocucKbAJ/jJcsk/H1/K9ZlwSVzLB90ThQPX9DKrjHxa8K1/8vs3tuoZ
         NzT0vaBcOFlF4/7uL0bVn6Si/oJx7uMe0cM97llDOaUxEFlDlfLafI402ILA4S3j08JR
         9dWaxz6KvT7ahf8PXzR0DLzOUxwCOvz6XfXLrwvLywos+rQ7vj5cHSq/3X3hXKQmLB8K
         fu8Q==
X-Gm-Message-State: AOJu0Yw3FOCQ4tQBA78Bb8RVgaXTAmx2TYWZ4npEQqZgRD8agfSeZ2uH
	Jq50dhx5Yt6p9LwTzMsrEE+jUuSzUyPF8Xp3XPyUXkph8rUMoW5kmLrB8VVrs33iO66e22BaDvo
	7zoAqI5Ubks6NuvfUxqb5uY9HZyCEoOY6bOXSarAlRmW8Xdnv9Y0hadSmBwo=
X-Google-Smtp-Source: AGHT+IGE56l9pyiyD0vMRHyVUD6tbTRNEC4Q5whBC1XyrmjW50snMVIOuXb6y7HP68NNzTi8xLSSqPDgVtcdgoqmIOVXEYHZR5yx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c1:b0:433:5736:96a2 with SMTP id
 e9e14a558f8ab-4335f3b4479mr38515345ab.12.1762512143887; Fri, 07 Nov 2025
 02:42:23 -0800 (PST)
Date: Fri, 07 Nov 2025 02:42:23 -0800
In-Reply-To: <690d9fd4.a70a0220.22f260.0022.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dcd0f.a70a0220.22f260.0039.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging
 request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
Author: yun.zhou@windriver.com

#syz dup: stack segment fault in diUpdatePMap

