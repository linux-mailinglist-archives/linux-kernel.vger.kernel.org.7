Return-Path: <linux-kernel+bounces-822014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E41B82D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C5A7AA015
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92480241686;
	Thu, 18 Sep 2025 04:06:02 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBF23F405
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168362; cv=none; b=PWP0j38+cA6ZMXHhb/DB64j6QxZmIDNTI1AS4tqcqw1jnC9PZKRGr+E1UWHxE7VEz9gKNzl2zB1dFoM6IPJXaNzn1dHgt3jXYqO8GV5hg53k2xNpoNVbpgwBfhjfamqDAwifeSLkzHrRcdsjfFmaXgxZX8Sp8VdTZas843sSe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168362; c=relaxed/simple;
	bh=uoo9bzN76YjjWaHl+/q269lKlZCz9XHJVttTIWhwvoE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m8fzWnJ6TRRM/f+EnKIG968ScVSyoewiNpXFCKL5E5CZGibgrZwBy6EggzKc5JKMlv2A1OQeryAvYe4EdMO4FXdcgmp5AEXli/YGoL+QtzOSHeciUR+Luxk3w+aVH6RfEVFNWdj+6D31L1WNv5Ou/lKnINfWKDS+xONJuvP8Nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-892df556b68so140073939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758168359; x=1758773159;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoo9bzN76YjjWaHl+/q269lKlZCz9XHJVttTIWhwvoE=;
        b=g838AVRpzxKMaNxhF5rq5KMR25AO6NXYuSsrrgYPNx9EAxJfeSKDMozmDMMf0Ky02R
         w7/DsrQkcGhSIAyKvU1PrbW4UJj3SA34b3NtHZm6JLUIxB++cWtwIarjYFrYlmdmjc20
         92i0F+9fH1EmAIxGHjTXnOk6JHxUF9AhBHKAfJUm6TZ4+SMynZKY18oH7+SqMDRXhqL3
         PFxxppMTPPbTRcbTRFSA+8pUoH4nYogLFgZH67stF6dnilfUaFVs8XM38WJV+1+dT/+w
         Rtq9f4uikklStRkcBHYTp4AYBeJMYPU6IxVZOA0ssGcNneKVLRQFu+ugN0wOE2mH5KbU
         aRbg==
X-Gm-Message-State: AOJu0YyJPe1fUorHX64e6M96jCxxrFVpaz0qsZAQ6EbKFjUZZkvj3AT+
	XtgKySQ+ioGbYc9hSsdD9WEuYa+AtPtgKhZfQewsxc6oHyoNeuXh70Rpfh1B8RaKMg4/JBKysP1
	Hb/zkethBzsyGTPLJExe5ZiVa2BBDlJ1+1u/DtuGE622yo3gHYY3yyh6RWsc=
X-Google-Smtp-Source: AGHT+IGsBfvY6u5WxhP48pEM8/d62CLS306/jQmtity3e2sZJGGvp/N2fKwczYK50Uc9GLHp5bgaEeuBISSoQrNx/LOBJKayJt9Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1608:b0:418:aefa:bb83 with SMTP id
 e9e14a558f8ab-4241a4bde68mr57425695ab.5.1758168359679; Wed, 17 Sep 2025
 21:05:59 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:05:59 -0700
In-Reply-To: <68c21301.050a0220.3c6139.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cb8527.050a0220.3c6139.0fae.GAE@google.com>
Subject: Forwarded: WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in ext4_xattr_inode_update_ref
Author: albinbabuvarghese20@gmail.com

#syz test

