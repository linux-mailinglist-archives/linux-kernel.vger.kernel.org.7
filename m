Return-Path: <linux-kernel+bounces-825067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E59B8AD99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F717B9E75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA42253F1D;
	Fri, 19 Sep 2025 18:04:02 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EF1A2392
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305042; cv=none; b=f1lqHw6o6t6kzLFPpKyjfa9M1L4DlDVt2jebl3R4KrwBT44uCNNroIwzNIb0PI+IV/6xW9aEpYXZ17kJ2M1dda/eY531ks4LaOmAV3pbaOcfQ/Yj/pyseXjxMv2ED3ipKb9pn638g7ou2hil2sa19AhOwxDO88JzW/jZcbiFQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305042; c=relaxed/simple;
	bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qkbIQLfbDXMXSM/QnzPIM4HcZoMheFakSqmKQoVq0i5+PU+byDOUrMgHhuwyhzbVQ7Apffkj50C5OkfrjKDY2R6OvfGI6nL+9UGxgYN2xBn/cvJzEXTjHgXydxOvIj5mr/VDQJ+iNZl4UDRxBhQSLA8OpZhiIPWo1wZaEanvB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42404e7bc94so60619665ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305040; x=1758909840;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHqiXY9F30VvMHnjpTF1syx8dF7v4pfl9pdm2FAfsNM=;
        b=XRhuPKVj1ubChr3dT7ZgBK2zT2fzOHPXqFevIV8GXR8chbue2Kt9M9jH21hJy/d1OV
         zAfEG8CdKLcTqJfquonkGZAraNBCgnR1gbuhJItqVEpxI7OzhJVlzF5ESm+IfilmgCXM
         l45ZRZ7AdyhJuBeNq/0wQrrzpAFURszl8PTati3yl+DUZE8pfDAjllUiHfmH+c3w9ApN
         dBQypVHg4MiuGNjvcxeO/1XKUiONXBP8iVMhySZ6ozI+BUsQrwEsNbjglwHyuB8vdzGo
         OkEUtbDr6jsmz15N+tB/KHkGwwSTrCQ0FIBhv0WtvTTC8cBN1b0jqt2DoJUokVTgVf7R
         1F6g==
X-Gm-Message-State: AOJu0YwI11+93INHZTJ+ObZLzmz9RP+hNyEFjyJJKydXTxnCEFcXCuCz
	0pn++rvcOzyozsBVFBK8YBpydLWzDMQSJwucocjhYwuCRGht5qtbvaWTF/zYhXWYji/HwnHEw93
	CenCpi4ysXUThGd48uHcXhjNWaxKDZptpQsznAMbIR0wn+sNHsFvI1DCp1Sk=
X-Google-Smtp-Source: AGHT+IERrPt2t1091VbR8Cr7BZ5eFpnLjTwrBo38WWs/nlQ9IgKz2XPm62DxgjZ8hyxvO3y8OO88D9BMQwUvcnh4D40IAOW1cPfj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:424:7de2:61ca with SMTP id
 e9e14a558f8ab-4248199c624mr61748155ab.20.1758305039887; Fri, 19 Sep 2025
 11:03:59 -0700 (PDT)
Date: Fri, 19 Sep 2025 11:03:59 -0700
In-Reply-To: <68b1f3ab.a70a0220.f8cc2.00ef.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd9b0f.a00a0220.37dadf.001d.GAE@google.com>
Subject: Forwarded: WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in rtl8150_start_xmit/usb_submit_urb
Author: viswanathiyyappan@gmail.com

#syz test

