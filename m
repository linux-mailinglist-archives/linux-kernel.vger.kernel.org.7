Return-Path: <linux-kernel+bounces-892119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E881BC445F3
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88623A7B59
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397322F74A;
	Sun,  9 Nov 2025 19:22:17 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA014C81
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716136; cv=none; b=KpAsujOpCfx4Ir4LUEGarJBQrzXxnjWLYaan04VKV7GlOch3PujJ+l6nhQTC9BFfAMjELhSJbWWgey4tuvSgIWI/k02tBRLO5xsALJJRWyawUuWPDBE0wz6CjDhrne1K48l9Ty5S9++lNmikFo/EVXZG6IOCFUV6K22mjleo8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716136; c=relaxed/simple;
	bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fbkhSm5g8xjuTjAQ6ANZfXYCtNt/SNzPft/EauuyFYgwD2XsCcItfIBDAmbZh5PQcUl+bELkeuUwnRz7M6ayWFffvVJMjPnugGyCiZtrfkgJUh1aL4OTm+/TcAHE1+69nc6igyqA90k57nazSF25MbEeOvsZ7WRLcK0XWdCJ7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330bc0373bso18102635ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 11:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716134; x=1763320934;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6ptIwyzAZi/q4JHq/o9JXyIBQFNvCVX29puu3IoiC8=;
        b=QXbxAeg65AY4uFisTKN3CQcrO3celtzKau6dn+CjD3qDSvW6xuM4A2lJ9O4bKHNgFS
         SvZvGF7WGTe93WSxW3P2IcjbKz9wdH+dPGuPYCIShdnW+LZYPV2yCUa8SbLKt7F0d/jP
         FqpkadB3ch/aREHsPF1CcAKzKmo9qR6jDIJbVK1vTJ70POI3wIqBu1Hm4V5gO4zr5f2X
         QoZRWl5NK6pOWI6+3QItNjX3Xv+zjtt3voO6SSFFtDEd0v8o2/dv4UH19Boulywso+ol
         l9vEGQdIIOjCRuJvFgwPDv3PfqM+4+qpslD3ni0aCb6Lpt36l7kUxsDxrktP4Ktts0gR
         HMag==
X-Gm-Message-State: AOJu0Yxb3Iu1Wfj0z/LncbDLgdAfbwOh2M8BfyOiwIY0yTXTTZ503GWJ
	imrk+UBnnsysMHyMK5l/AmmbZzMuC3quUc8H156bbTB/0nGXDU3U1SiW5yH7uKoD+4bPsKS/uje
	1Ieu/YyFIqBYuGQJ/IOlKV+nzjb2dnSEQ52aqK6lQvcyuIDh1ymVMZuFU+Rs=
X-Google-Smtp-Source: AGHT+IHs+Ri8my6qJQnPpmQGV+B6SA2bXwynWrOsTCVJ0Ddwo+Qhjk+BT4EC2cNDxZobvP4mk9iE48aelQnHKHZT/aVdRtI2e7Fc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330f:b0:433:79d8:1e14 with SMTP id
 e9e14a558f8ab-43379d81edfmr39236545ab.3.1762716134307; Sun, 09 Nov 2025
 11:22:14 -0800 (PST)
Date: Sun, 09 Nov 2025 11:22:14 -0800
In-Reply-To: <68f66418.050a0220.91a22.044d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910e9e6.a70a0220.22f260.00c0.GAE@google.com>
Subject: Forwarded: kernel BUG in ipgre_header (3)
From: syzbot <syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in ipgre_header (3)
Author: zlatistiv@gmail.com

#syz test

