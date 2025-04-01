Return-Path: <linux-kernel+bounces-582844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959AA77320
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 05:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714E7188EB05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 03:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6C1C860A;
	Tue,  1 Apr 2025 03:58:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851A196D90
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743479919; cv=none; b=T8Ii7fancOoXlUzXOzGGyuOGVcOgHVcClD5lotERmPOJC7w2GjCGCdJLgGry1NSRaTiBRwUVqX4zooo3F27oRDdfiGTxg3V5XjCUMg4QUC3fTsX0J/WC6Jy7eBF9IDpDTsuxgVgjl9iFHE7RoglStNEKYp8SvnD71clNafnNCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743479919; c=relaxed/simple;
	bh=FZvyO+CH+waPGu0bUdSrHBMNWzHkAiiI7Y/QcwEqSk4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XJJqjQx0/nuMom+YH7SNRaU2MN/ECy1WszQYLuBj2zm8/96cccoc9PL9fK9b9SNd0cM3ZvxUmW6ZcAgDkzr+yj7mFcuFFLllK/kWu15ufCQ5tOHtC7VI5eYJJR5rbgDn9yYV9+7vhIZfg/tIE1kPMrOyoiY9fBGfUG1EE2oTCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d5da4fb5e0so35953055ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 20:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743479917; x=1744084717;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzG2Y/TurTR7M2S+S/zPulC1BtJ09P274Dqqe0OY7h8=;
        b=kqYMCG4aXJw7Jh0kVPLmhPP46AX29LivXXXC1LVuH8TO+PnC5paRMejMOYEXDm1sRn
         YmpHtzdpfwAubbDnlAsi7sMqXZVeI1/a2KM70gvO1JnbJh3QR+29n/N/fmZ4sgOpx/ms
         EJan9fl/x+WDIEfCVSKPqoPT/kMa1XpMaND7V7cSN/NCTisoP2S7SFxUKVF0vHseM+MV
         NXNb1YrGvqYvxkVC+fHI7cFRSdnRGn+f6bEpKLCYJUdKAQKiMH/zCeBOMyPNzcEigZ6f
         YsIIgNWgw2mClgRK44SaQWPJR7eDt9wBfXBwi798jQM5ln70DRRPnn3U/AZVer1zSlg6
         hkrg==
X-Gm-Message-State: AOJu0YwVlaSQ+m5LwYWj5FjowMmW4WjcoJju5Yg43M+qFHo0Qb/q5P6/
	rAXYINzJ19InE4PKkWu1aKFecaRxFqr2vQg6GEXkuyg6AWWUjDsGXTUFwSPGuTLxQMAtsEp7SXq
	aReXpg+Dd5W0fB/sHfPMDk95lm+bcCZRtkaIsJ5+IPcxR7CGvZnzPHOo=
X-Google-Smtp-Source: AGHT+IGXAxFF3oktrNMNOsUBW6Xg1G43jA0kq3JyxA1LqgWuh7DVzHZzNldYC2puYjlQfpakQb/xbz9OL3EapyC9SMwc8RgnzcYw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c82:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d5e0a09a11mr117909835ab.21.1743479916996; Mon, 31 Mar 2025
 20:58:36 -0700 (PDT)
Date: Mon, 31 Mar 2025 20:58:36 -0700
In-Reply-To: <6775abb6.050a0220.3a8527.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eb646c.050a0220.14623d.0003.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+9b79c816ed3895539cf4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Disable asm memcpys when kmsan enabled

