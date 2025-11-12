Return-Path: <linux-kernel+bounces-897576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCBC535A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5DA04F9B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46026AA88;
	Wed, 12 Nov 2025 15:33:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4524C208994
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961584; cv=none; b=jPelpI35TkrZBACuATK5Ki6zx69u0Q/H8GQjdhkZ07sWBAtjL6iv/U8aOY49yopA1ZStwFHRWeQp3LElncsPcqFX6uHL1M9ybvCfEaJWKsUMva+1ryZaEs/CvmUE/IM5+KSfqjpzt14p+L9VyaEPvMPDIy80ZiGTusMux4my2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961584; c=relaxed/simple;
	bh=FQ9pTSaZDkg0vh/aIgVGLEY1Noaj1Pb94z7kFswbriw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EUmr+vAw9cRADc8DBv1KAjPpgTwR/92IUz4YDtCNsGQc4B9yWeOUnpHAJ/kyUoxp9/QhO21OaBH3CwghBXFI2/f8EZmW7jsVIQFm9HN2lfAVB4CQXCRj2/fqKCjP+P/8Abx//oGcvyvRLx1f3sp4mv3RfE1sg0xgRdOFQdYFZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9447edc234fso224248339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961582; x=1763566382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coXyFe9oyQZvaA60ERAOFuMemEcCql/iQHL4Xue9b1g=;
        b=C3F5qYRJAiT+6U2oaSQ6haws+SxbzvklX007mjPe2ied8J51ZpJShVDPdtR0MRBlzj
         UR3ts/XLD7A7HOZ2TRvl7VYle3pd2q11wI5D4vI1ORnfUHz5pk9Gva9/H8S4Ihx+w6HV
         psrQtXiSny63esLv+4PbHN+8/trGlDbDbCTRnephZqTjgO4bjhaJvKAl4xV4b9IAHTE2
         9E4Z6eFxwZztXtBr5sFFWiAmSNOlip8EcS+m9Rd6EJkzDlypINZWMWmB9ofZyr5vvPJ/
         Oxo5m6Eu5DMTkRQpIU9VBwAFwXoG5JFA1XKSvGb74ARjM9LrslgKaPN1oP2nLaCW780k
         T1dw==
X-Gm-Message-State: AOJu0Yw087z6Dy/MRFgMSX4TNLODDNTkna3yH1FHJX/NP2gtUVUqHwfo
	ZtpFAJrVuuDm3/FsuuvXek0mkbIghX9gIYUhaDAliICFTilg6uQEUTPNnmfvWSrmxoB4IWRA6L8
	+Q2m10LGTRFgF8tn4G7KdDrVonWXmA6ybq8QRtnIvmIedvs1F0tdxmTP1ov8=
X-Google-Smtp-Source: AGHT+IE0xg5EvfO3bWXLWZQd9K4UAaiAb/oT1RWue7HQ8kCj8SBqP4jHom8fdQjgevemmzp4NdLIk6WVvU1v+WgAeYLwsrg4mpqy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d81:b0:433:7a0e:ef29 with SMTP id
 e9e14a558f8ab-43473d1b9famr52708185ab.10.1762961582511; Wed, 12 Nov 2025
 07:33:02 -0800 (PST)
Date: Wed, 12 Nov 2025 07:33:02 -0800
In-Reply-To: <CAMz+-CNc9gSbvWXG5BT6-+j_QKQ1Ac2mKnNDqvjzvKVR_ieHFA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914a8ae.a70a0220.3124cb.0006.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/wireless/util.c
Hunk #1 FAILED at 963.
1 out of 1 hunk FAILED



Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12614658580000


