Return-Path: <linux-kernel+bounces-860290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED81ABEFC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9209B3E0A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860E2E1F13;
	Mon, 20 Oct 2025 07:56:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275512D780C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946968; cv=none; b=f9EPaPnLn8XbcXvtif2k+OvTR0Jkb5mgKm+MtZpbQ+5iGDeFmjtotBrb2mH+BcYBnsRGW6Xc2u2muaP0FPxLpnDylwXni+0+FS4NvFjnbrSF3YC+LXkw5BmlioF1pH6jLUIdIregRMo27lNxLuM7cl5OSGBt83SoflNjhSQLJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946968; c=relaxed/simple;
	bh=1lDfQb2ZN+1hjXTcSgeZ0ocdoHAa8DNhandvPz41hUw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CKha8Gaqpo4rmyMYvZzxp69VWi0g1QLqurKQ2zNL/RaXVhna/6pAOVBVP17gzWUN18ME+wNX52mT8ERmhmDrhTPOrOhjch7DzGGkRFoagaqKEh84m9001kn6bEEd7JhUR2si88v+rGU+GI/ioYR7tPwXD8XyD0IW1C1xkcNlIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so820519439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946964; x=1761551764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAk9706Bpvq16Ozh4cxKwlxQ5UilnVt6J5wQh/3xGio=;
        b=SCBKgIAt0vqRGSlsWH6z0ZTHO2nf2HyYSy6GDx9YiFim5rEF6OmRZqi12LYc45ctah
         onw+yq/yuFDjhsa9ycW7+IcQi8Cw7FGg70uMq/YwmQuK+MByNyfr2L+x8fOLW+paJfvn
         I7EiZiP78djVcBOtg2RJbdspyDosapjl3vGviZkRcODO6kFgr8FKJkQlcrBv4AFGeKp/
         5wjSP7WfjWpJWij1rft9ekt9hVddsULxIDn+jI8WS8FVV+U9WGMdfe15BQjR9u4Wx+sK
         iCBhtzuQvcVVQ9q047IsKBuqkdxgCwa6u7c4aj3KtWCMh2+v0B9JjStRN5TapFN3eJjd
         rhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOKh2FWCVO4ZsnZxxAXpiOQ7/Pvc/qV0mXsloiXY5et93zDKEI30qXB3I6ujc8M9lXmpPqSFFLa6w9MgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyle+oEmiymn29hXLWw8xkyRCY/G+bqTCjwkgCzmaNFQnnMRP8d
	nJ5UKiulSLhP5hPoyqZC9X4XMbc1d2k8mD7iLE1ZtSQtM9nM2uJOcd4r+Vue4UPYKzXvE1Q/bBk
	3VEiR0CRhQ1MxL+S1k7yQ4NFLxKGzdzbN4d+RErSIPe5CSTj3ZEnbLUQBP9o=
X-Google-Smtp-Source: AGHT+IFdGpwKWvgijI0KSJaUHtz/FSBbjpKTj5FjxnP3UMOTCUi1mxDM2m60kPZn5Z460X7J6WvRshwM1GU8C9SlTKTGsKNW6U7d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:360a:b0:940:d9b2:f959 with SMTP id
 ca18e2360f4ac-940d9b3138dmr388263539f.14.1760946964238; Mon, 20 Oct 2025
 00:56:04 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:56:04 -0700
In-Reply-To: <CADPKJ-7HnHKJ6RxzUcLh8NSXRq+99aim5tTvhz8j1s-TMx9saA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5eb14.050a0220.91a22.0441.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: clf700383@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/key/af_key.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7361c864 selftests/bpf: Fix list_del() in arena list
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122d3c58580000


