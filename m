Return-Path: <linux-kernel+bounces-740085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A699B0CF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBD542479
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1451DE4D2;
	Tue, 22 Jul 2025 02:07:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E251ADC7E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753150041; cv=none; b=dPxrOkWfu2DkuQ4bIKL5/sA+FVldxUqoJlk+rt68WUg0oI/SFpemnCOeZgnmavRExJbJ6YWUmRyQUsX+RBO5GqJDCchsCrBZtgAPeSfLUfBTbpe52oWkzW18k1KHOcSoK+z1HnYH0dBVLk28EhruiJr0mgKxNE+gGI2/lwxtStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753150041; c=relaxed/simple;
	bh=12f3OuhA1Ip/gG/MudWFQyUynxMKYuZcZuTH/k9seAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K8GISBGLlRncglokryKLUBnpdpBd/K6JODt42C7l3AOvxikgKNJesAsKUmWRqwNsel1zm+3Fky/Ym6WIECm3Er6mJkh34XhE7CNOHzM6rJ5LDEM8hnLi2BzHgxmbeeYAbnSY4/DEh1QehFGD9sdaCR0So/uAFeX/EYURhwIK9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso369945439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753150039; x=1753754839;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9LBU0HGFm0I1jXN8jw4T3iKGTEzE3hF0wnvULypQ3c=;
        b=WsgBLvnhK8sRywv1D8gO3OF+gBKgQXI6boJ8SvTckNjlAUm07zDvgc3zk6FTgvj8f8
         hIYNqArcrEtAxetc03dfucL6sMr/UzM3rRMHgxeUwoWiB+Bwao2Cd5Xdf0Rk/IoO5C9h
         OP8vRTj3bsV8oNpKpGu/OFbeOgF1ddHL/PRQ9lfQ+BRiAns8V2Q4MsV/1SYbMw1NNAzQ
         f/nspP3Wg0OxSKv22IrjA1mghnRIYXmzRKTEpRtZFuKwyj6HvhfJYmdjP7ZQy3beCI4n
         6aj2Si8dx0tYGSDg6xO1/sJwWef2dyM7Vd2icvijBcFmHu0BOoe4czKKunhfhvGplU/a
         VZkQ==
X-Gm-Message-State: AOJu0YyUMkPY38odi46TawC6XgSfFjAItH6IYoK99cBEinMyUl7r3SV6
	JmDanneQXjz1bfVOK04E9vLSNxg0HS7hNa7nwtk60QcG9PtqAEEIBOc3ZZyPlz8dBiUcerQivAZ
	99mAgnBJiwJMqgO07+4ARZtAoPFriuIhWYAyHcc/wJCa5rAcZNGMK2lwyBcs=
X-Google-Smtp-Source: AGHT+IGLGruojzhFJ/cN9GlrqjtWk2oh0/MIp24MaQwMJVwHTQ/EK+4GY8/roEodBmTwEiTv5O+ZhakMuTqeTeyrxI/ILMDht6km
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a10a:b0:85b:476e:ede2 with SMTP id
 ca18e2360f4ac-879c2b7a452mr2107421039f.13.1753150039287; Mon, 21 Jul 2025
 19:07:19 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:07:19 -0700
In-Reply-To: <687539cb.a70a0220.18f9d4.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687ef257.a70a0220.21b99c.0006.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN:
 slab-use-after-free Read in hci_uart_write_work
From: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
Author: ipravdin.official@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

	Ivan Pravdin

