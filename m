Return-Path: <linux-kernel+bounces-820774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BFB7F2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A3B4A411C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EDB2FBE00;
	Wed, 17 Sep 2025 13:13:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36133C75C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114784; cv=none; b=LpOsDJ/5XwGQhUGi0g/sL1c2UbEpI3dguVbtnDjgwh09AKFg2K5WH51n0Hq+xZQNLpIXuy4hzSp6WxUCTgC5wqm1ujP6AK8kyMrcBIMdPKueZBEL1nlED6vXbmdpzXo3QGW+gUB9X96bFoXZD2HNLgH5sEz77C5UXguxJ2td3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114784; c=relaxed/simple;
	bh=+cd3R0hO1X/zfSwKcFihuXUAwpyIrC+G/5I5ovr7u8E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bRQuJZckRNOo7oLzPU7A5QTW7rDZQwtYjonFgCxKvtBhZyJRC02cm7DZA1fuCwKI8yFaurE1gZjm/eCaG51v1qk9SOhzvqdy8IMMcNDAUSvXS3HQbxb2GBLrZFvYOj55GnCtKS/MamPpSK0Jt6oH2UqgeB13qZocMlZEGmnOP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424074f3f83so91754575ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114782; x=1758719582;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cd3R0hO1X/zfSwKcFihuXUAwpyIrC+G/5I5ovr7u8E=;
        b=N8utaHPz3xOnPkU44FQCt0SCPe6Ezs9hX+T7B68/pDTy2UbUPtjqQnEE2eAVTR8/+o
         QgFJT25NYfY1L626Pao3LFbF7CyfUoN3AVpP30JuN3/79PATXjnhl6MJheKaZ50AzBYH
         foqA0qkKu6rf6XeNmP9ChxY4ToqRUVkfhBwBRDilQP5ff7B5fKQPv77rM1Awd3gWfu6O
         uqX7ANtUtVNec0wb0MwM23f/Hnn83NurIZOIoslty4JmlNdAgNn95DVHAGMtm1cQsmFy
         ZExnecWUZUlvS8j2yhBvxoVNgynOyDXlWgFd6DkBEo2Yl3fc6+CK+jT76EWDBd6v1fxe
         ugIg==
X-Gm-Message-State: AOJu0Yyhj4NVEsErbS31+6pkRPAUhtjIy8B9IycV3D0GK8oY/odwGKEg
	dfEciyoKpmo0hXUdf0z9NRGBzQkGbqza5mSXkEiMTF5FmIq0cqMPFoTfSJNAsGEdzDi5d8cMPEQ
	ca/HnZIfzdwolBj6vpdUR6chZkQ92XsD40kDnx6F7fRwDjh1q8Tpa+VpRTKc=
X-Google-Smtp-Source: AGHT+IF4QXeFpNxwNelpQP/LL4hbOOzsSh91yJIWxowTw+ROTV4+ZiLGN9386i9e8YUIlxDq32lmjUJzjvl4Be8s7QTdnd2KlpGn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:423:fc1a:126 with SMTP id
 e9e14a558f8ab-4241a55e27emr25285755ab.32.1758114781732; Wed, 17 Sep 2025
 06:13:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 06:13:01 -0700
In-Reply-To: <6894dce2.050a0220.7f033.0049.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cab3dd.050a0220.2ff435.0569.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in
 nci_dev_up (2)
From: syzbot <syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up (2)
Author: deepak.takumi.120@gmail.com

#syz test

On Wed, Sep 17, 2025 at 6:40=E2=80=AFPM Cortex Auth <deepak.takumi.120@gmai=
l.com> wrote:
>
>

