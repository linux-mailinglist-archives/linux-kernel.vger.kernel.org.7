Return-Path: <linux-kernel+bounces-875483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06FC190B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B863F355C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230D531D749;
	Wed, 29 Oct 2025 08:23:59 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4931D377
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726238; cv=none; b=OSnUHrTu97vlpmULhlKdWNV9xFssrm5bSK4diIvLk6Hk+lrHJ3m4r3OtguQsyLkJlBsDubZzN5F0bNKWpD1Ia0CosEmxy2SbnrtCtGKUMT3/TLYjQPubPsiydKWHoo6RpAv3GfMnmll9ng/YB0Iw+YXBsjPOfqGiqlH91y6zkX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726238; c=relaxed/simple;
	bh=Lcmjw7aWmD63/Qxpz91f93TIJ3fdroLgvYyqOafdTN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cJRf/iduG66mZkSg8bCZbDDxUlkM3pjru4Wc8ZxOWdOZciTwqQ1JmVmcQNDy1jH37/76lTxYzjQX0q7icF1jYNh3MuabDhW93nCZU/t7wN+cdUGaK6qg2vncI1ISLxRIaef/XHn1+kbHjAX78nzKOQB05RMrSqmQR7b5robGcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db6d36c6so265262265ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726236; x=1762331036;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lcmjw7aWmD63/Qxpz91f93TIJ3fdroLgvYyqOafdTN4=;
        b=m4yMgMSMZW4vdFwNKGug/z/2lV3nPF6H7hDtA4GC9YN8N7NLK/UJKAsx+1Rv1kpyXh
         GPBEtfCqVWyYvNV1+/P/MqTQijjDD2hm4PtGS4iHEeOBiGIX3ep/D9QRansL82xiLIci
         70Q2Uq3ms1xa2o84u7nN59VZ3MpcnvidN8R9sUODm8EVhda4xv5Ro3kphU8BAS1PAvfR
         fJah85HsmjG1FklTPAYkMTJPvMTyA/pRvHAeqAwoacDIZD0XWX2pYsHctvuB/HvGklJN
         0hl6JGm5/96RtM6kahQYmBzyJ4Yuk/G9aCm1cMaYdy6Wx1fkbo/ByMMVfSCAnXwpyGPz
         Enug==
X-Gm-Message-State: AOJu0YyovRl5m/fXb6n6Z9rt8kHWD7g9wb9oTXuxhGflp/gDXNIX1cdY
	IX5DV2UbVysVcUsDgNKi96li93HpaCXXfpQwhrYV/1khOiq/f89aO/EGLjA6HebbuzuPyeyiH17
	xs1lUcPr4qZa2sIe0wKBoP528Azo0GtPMSqDVjDDSeHg8MGKkzsmOv0EUv/I=
X-Google-Smtp-Source: AGHT+IHd7Mh2SiRUjPbkWKyEj1fVLfXhdRmP1KfqSwzgq1l1jxwBgZPy5heuu1/niKIU38jkKE7lPkyP1OvP7IhZ74kE9DKCtWAF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4607:b0:430:c323:2bca with SMTP id
 e9e14a558f8ab-432f8fad5cemr27659315ab.10.1761726236558; Wed, 29 Oct 2025
 01:23:56 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:23:56 -0700
In-Reply-To: <68eb4077.050a0220.ac43.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901cf1c.050a0220.3344a1.0417.GAE@google.com>
Subject: Forwarded: Test patch for [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test patch for [syzbot] [gfs2?] WARNING in chown_common
Author: vnranganath.20@gmail.com

#syz test

