Return-Path: <linux-kernel+bounces-834816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4EBA5956
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 07:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AAB7AAD40
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3D239085;
	Sat, 27 Sep 2025 05:45:00 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B9238C10
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758951900; cv=none; b=brmeJjTEkDU1rh8CCDgHhpiMik7TwHxjl2leP07AjjSbP/gMUuTFWvyXaJq9HW0rc/6QlzFGgXpSETcaJIe1VcAfCDTU5bT0adzWDk3FTDPh/bjtm3wG4pt6m8giG2XPXmCcGyETl2GA4Ma/ZG/R2hdZ7o8I2uxb/B6GPvZUeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758951900; c=relaxed/simple;
	bh=tTblJ0VfgozkgSj8ema0U4tBYQTwy9PvqmPfVmVz5FY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qv/8xYEtRJni32lh99w6lld7Bi/Ktka6bMnDuinF1YNiFAy2bdXkfUPqjQWzjGk7g7DFAqloXDsBvey12HuPQcD9Go9TazRLBot8K428cGI3rew4N02JRICS7NKAmRysYLNKdTGUV25uPxQ9lQoPDfyI7ZB24vCCEuxLdlxLWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-425745467d1so39429025ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758951898; x=1759556698;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTblJ0VfgozkgSj8ema0U4tBYQTwy9PvqmPfVmVz5FY=;
        b=WQ+E4JrfDMMqyHSSQthEmPnrGgc29FvkhrivuPmHsN5H2gwe9N0fEDhsNUQKzb42Zd
         mWQZ4W9SDyAtKy4DjnRYd2aoG7tj8Vz5XNVFUE5z0l+Va2HYGu3fT3+XEM1+5pOm38rW
         b2WHBE+w7PqCJGKhnEMqjr51kyfGSHFtyE9LOSxHE/St6761L7bWDa0NOrMA7gk87tj8
         GZcZCL0ti+lLECs++HfOyGYgRfxVnGmlHziE/xnM5DfmcIS33EW2mZfapgAetYD6UmXR
         vTJAzI3AShUrsXxcu+uZjbDI/t8PW/TzbIZ7yyz9d9IpUYd9MRwzAM3MJ3QpZOnnUW3q
         Dh6Q==
X-Gm-Message-State: AOJu0Yz1u394VbCcVmZQOvp+ClBcutcAEOIPkGv7BgmoIZcJpLyPCCuM
	D2Y1+PUucqQGWdqOAk1kcT0fjGTnlheRKgjJScH7v9OGR6zJopB6HXF/BEHTuJtyKBqtRW5rQfX
	hqB2yvLQHTqB/yeiA10NgCeahs++9McS435AWhs4BbGYhdTBzEEPnR2tseEo=
X-Google-Smtp-Source: AGHT+IERHGzWyesYpFAlzIKuDVPLb2ZwYKrwrFGacuu0NM2L0x5MkNP6hnPxKKFf7CJSwCx85jtZwwcdPLEgv+aOCgYWw3ZLofN8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c2:b0:427:2aee:4935 with SMTP id
 e9e14a558f8ab-4272aee4a76mr86049045ab.12.1758951898258; Fri, 26 Sep 2025
 22:44:58 -0700 (PDT)
Date: Fri, 26 Sep 2025 22:44:58 -0700
In-Reply-To: <0000000000001c59010612fd7c60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d779da.a00a0220.102ee.000d.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfsplus_strcasecmp
Author: rampxxxx@gmail.com

#syz test

