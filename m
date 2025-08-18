Return-Path: <linux-kernel+bounces-772886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C58B298E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E53517951D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8426E6F4;
	Mon, 18 Aug 2025 05:27:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8F26561D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755494825; cv=none; b=CzWhfSWR2WxdapdfC9MeVqkACgUBJazPwv/VCqTUIIUjV10JEF2hsSp96oHX9HZjlys9z9t8injj6kRNOU3b9yH0QyD/NlVpjy6A+pciqFH/3WpBy3+nXsY9+xy7ETZn60gAkgvOpRNW22qvqbL9vD8TIvqGuLS+T2o9VxZUXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755494825; c=relaxed/simple;
	bh=of82w4pkESyPkT6wu2Lw2k/sZmINaIdogs7JIy7GlAM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X7jSeA3atakK/1ZafesQ83H38MBn8qRl674w+HV/uZLbITmiDZaisovzEpq07ylRNL94mu9cae8NP3w4VA1N6GHKFG/MLLuKXaCABAc3C/lBrQcHaREVnWzZeBcap67eWBqukx+6N7ivUuu2WIQ50JRBSl4lEPVBRNV08MSj0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e62b4aso1156303839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 22:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755494823; x=1756099623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMu/5TOZvlmKVXJ0nTbYPovuO59wShy9VmNeh7anMFU=;
        b=LL6qG1DtP1pS4e9Ks3Y/jiABVSNrMS23339gSCW4yni7YMBYqy5yHHKBjEw5eqGaYk
         bcsxDRAQtzv8kgF8Xjs6cG2xKVnB8lXmxfCIZJKn3eaB7VA8BDNEGfFOUZ7MEVQYoxd6
         y/8OjruEySxQmoVdrAcN4Jo98e+Ad+qDRSMl8qSkrRVl1T6XS5Gx1s7uHfigHFVh+4X5
         rEhaD7aRAzDoRt4gLeHTXAxE/GGl1f5TyvF8cb+klnxobvcl3SLqTMN7qzkd/4j/fCGV
         zUDPI5SdbZIoWQWQieRP7CW8lm88KrMWIl0xc5Z/4hnWE8E/1+40VF1kjfu49Ovue/po
         m1Kg==
X-Gm-Message-State: AOJu0YwAozz2FlUInmArM13VWTL76AyF4mjmXcZX6rOrIdkTdr6wMYT8
	Ggf+jGnBrwAt7Ct6IxEsGPPJok1RHPs/hDbMszj//ShxplPJ2PxVVYslHnHUTn9iYjilgKbywWe
	EcHJ+AvvH9qMA8w3db3seQ+1FpggvwHf/H/7qDETbwe6gbGLBS3G2lDwjZpU=
X-Google-Smtp-Source: AGHT+IEOc76PpIxXnH1Ime2czzKN9QIkLNlp0aorViuvW0w7cUMU0ELb4qvpe/PbKedQwmX3yWS//ojqmcs0Q3XaY5NdBGAxAnlO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6426:b0:881:8d1f:1a7c with SMTP id
 ca18e2360f4ac-8843e4963b4mr2151967539f.12.1755494823548; Sun, 17 Aug 2025
 22:27:03 -0700 (PDT)
Date: Sun, 17 Aug 2025 22:27:03 -0700
In-Reply-To: <20250818051210.850-1-yuichtsu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2b9a7.050a0220.e29e5.0090.GAE@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yuichtsu@amazon.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/net/usb/asix_devices.c
patch: **** malformed patch at line 12:  




Tested on:

commit:         c17b750b Linux 6.17-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce98061fb8ee27bc
dashboard link: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117aa442580000


