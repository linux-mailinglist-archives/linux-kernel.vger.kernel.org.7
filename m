Return-Path: <linux-kernel+bounces-886084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08BC34ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B7B1921375
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161D2F12DF;
	Wed,  5 Nov 2025 09:03:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F92D7D3A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333408; cv=none; b=T4vHbSz2JSphL1fwcrC00Zc32Y6uFWd6nfYoUrEEKZWBqo6P1UCkWCGroLcF0siXJAYX2Z4BDhaSpWznFzYZ+JkEv0FnWJ5UqPwtMW3szR9Q77DqXGyQR9Gatf76p8NGWbhf7dr3ltvuiarJaoxj13eqqUp0KPH1nTxrD38J+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333408; c=relaxed/simple;
	bh=Mtp/IZeTOzN5uEFQtUJaeirpKxn3xAWa5J48TubBbcE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y4AbzrBhzEWZpKv0FIEo15oGJhsA4zuDoqQTclFzsbCRbUkaB3hy2Un3rTjKPLLvf+0jExyqatyGsaCXS4lYedJLDCK4zNHeqmLYYgQdKwLkpXANbg+wha3pG58kT8pUun/ttFhFSI4tleehvPE5MtQ1e48RKWeN51/4OM72Tz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43323ffc26bso26327845ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333406; x=1762938206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtp/IZeTOzN5uEFQtUJaeirpKxn3xAWa5J48TubBbcE=;
        b=qW0R2p3bsw7SSnWBeHHS/olNcK7PsRO2TQqySLtOi0fuoCOOU9/r7ZEDmO96EL/hkK
         NCFF5EAAkKYLwX7UiXo0arEUKPO9Lf+8S5p33DPrGRhKZFSbU0QbBKfTdvhjCa11naaJ
         gyaTPXz5HR9/xqe1A1R+KLn6cvcmv94uwP0k3Bw/HCIHoAo4m65GE8qoRNWrIz1wIycS
         DhBTjKAVqokSkh9vEZIKjRzZAsVIGxYPjzwz0MKlQWbJlp33qd3cKuJQfZQWZJIo0AEG
         bZBpruSc2Xa1LssL2O5JOTpeZRd/yAeZNdNTI4dZfMigCKN3D4tYxz5A/hfW5schKuuo
         mxew==
X-Gm-Message-State: AOJu0YzU5NruRCfhb5TFVrLnNit+fTWulGjwqGhZ/EfqXhzTfyabOdcL
	6te8xd4nWYKkeZmPlR1jKVJNXv18cK3z4qfuGr6QQLAh4sgeCZZTV5XJ66NOuk2cIKSyPHihmXs
	ZKkKonNBDlC/6zPQQKT2okhXTD2yi2nffd/NPkcPO9v0V/XjLkLKbkUg/t+E=
X-Google-Smtp-Source: AGHT+IGDlnaXJ3nij1qZek8fR5/jgSh6kzCkR9nECOSloDi2n206DlBMuF2uzfLnX48QDZa/oK2lQ0yWB+GfRWv8Z2GMv5GGH2E9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:42e:7273:a370 with SMTP id
 e9e14a558f8ab-433407a3104mr32864925ab.5.1762333405926; Wed, 05 Nov 2025
 01:03:25 -0800 (PST)
Date: Wed, 05 Nov 2025 01:03:25 -0800
In-Reply-To: <00000000000035941f061932a077@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690b12dd.050a0220.baf87.000e.GAE@google.com>
Subject: Forwarded: KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: kernel-infoleak in __skb_datagram_iter (4)
Author: vnranganath.20@gmail.com

#syz test

