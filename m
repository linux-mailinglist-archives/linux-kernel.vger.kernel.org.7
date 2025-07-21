Return-Path: <linux-kernel+bounces-739917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E9B0CD03
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2794A6C4CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517442327A3;
	Mon, 21 Jul 2025 21:59:02 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113245948
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753135142; cv=none; b=jhyEAzzgwDznmXlMhjVd7FxYAk3VxJ0p5dZbkRofav/tzNPKP+4f6NqKEEK8Xw4BZ30LqRpKdZGg66EPo6XqO+3q9XUbyTGHU/ZcAT+9zSZ12Uz6up41MixuHuNJADuogMKkcyGaVdlbOX7Cos0mZr2rIOdx9uhC+yeHYjpe9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753135142; c=relaxed/simple;
	bh=rGnoRmw/Fgx9tAcfXV69tJ4xCiAa70cTtXn6fbs43Kk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VjUz9C2/UQPDbfnOcSB2WC6Yww+Mrnm7tDeMnY+EisbyUi3JUA9UCrbYhO4Nw78PaxUCV4be4thmXz3fOhEfUSUunp5+SmJ7XoDGGmTX4ttrm6emsFj0p+419v7HbPFc2GDhqQfv9Af/1V7W1szp4FfKHCRYI9UW3h6sXDGDmyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so52360885ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753135139; x=1753739939;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9twqwIZKgcnKMKrMO0gyBWU9xS7PLKoJCfIDeBdMaE=;
        b=UKJPX0bZQbIXo2ENxjJyXVmcwjdFD7/5ZUomJ2SlfZ7d5iFGcc8SPlWq0pAM6i3jS2
         /spg1B3dHGoI1TbA6r/fo+EnbPr547jizKuSVFGRZ3/uYPm2nHKhI6reSaBr6WGa9mM0
         vgGYO+1/NJUFfE9UrjPAe1deg6ey3LPbIdFGfLOUZ63BqKImfFfA1xaJuXQ54MDt00ZB
         sZkgi5yDze16eqdTeMSB1aZn02/oUfnyVQZb5DhCDRsqO++JaDQfAvcvBA3aMDMwDwM8
         XJ5WN2bHS4PNLCGQE1N3jXcKJL9Lkc9D1kcjfRfEhi65xZS+UfQxVvCcfRoYyC1afopc
         EgYg==
X-Gm-Message-State: AOJu0Yz91vSqBEYUAXFd79/eCcSyIVEVpQMLXqH9E8SS92gdvIFkDyi4
	vaA8YLdArZfSJaieBTm+RdDyNpYX6rj9kzpJ4aGqqL3yIZryfTIIOu8Lqc2UD/gb2wM6KuCI61H
	Y2zwW+3EVH74I6+fDbwXeTH+8s6mza270gIpKNOvak/jSA9B4wpol1s8zXMc=
X-Google-Smtp-Source: AGHT+IG6GOv9yIkjTvXU2o8o8frYLsv/tgmUWV3vFCVGHm6iiIWgQyJZlqGTkKDWwUBVhQjDplnT7piV413UAzYHMQIbHRA5poMZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3003:b0:3e2:9fa5:d4a5 with SMTP id
 e9e14a558f8ab-3e29fa5d8e0mr152486745ab.15.1753135139752; Mon, 21 Jul 2025
 14:58:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:58:59 -0700
In-Reply-To: <67eaea0c.050a0220.1547ec.016b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687eb823.a70a0220.21b99c.0003.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bluetooth?] possible deadlock in l2cap_conn_del
From: syzbot <syzbot+b71bb48c13bf3fed3692@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bluetooth?] possible deadlock in l2cap_conn_del
Author: ipravdin.official@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master

	Ivan Pravdin

