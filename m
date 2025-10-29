Return-Path: <linux-kernel+bounces-876804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A1C1C7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5703D5826E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC74E34AB06;
	Wed, 29 Oct 2025 17:12:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1700234AB12
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757924; cv=none; b=Hro1RYS+8MfLb/5eE5lMaC1sEJzZSOhmjc0xCWDyBcbkaKchcX08FgW2nv8cunpA+CnSCkYCeOHjPSc7WwXUmamaY5oYhy/41gDI2k21eUPw9nBspYbuZ3AdoHuHMuXrf6fjBhT3xjMXBdTU+u0hqOGWuIaWORL3coRx8N5J0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757924; c=relaxed/simple;
	bh=LLI9Yc/5PylDKmnFXxl/RUIyH+Qewg4oeZGyh+FD4hQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mmVv2WkuuO8fsZgZ/X9a0kauijwTHX9LdvoKpcXmeQ76fALRWySvdNzpQZq/cBv0SBNDU1jWPxc2JlvgRJ1W2xVXVCXNHXIfulTnZMyBq/tW7QteaYQkwnrP/9t3j7r5w7UqhT0HMHRWXMYPi2lGWiDxf8AxSeIAxVe8ptSLI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94389ae547cso11648539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757922; x=1762362722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiqjft2r6zNLuSdN7NRRYGNuHbmCMPA+2iq1zWhMGcU=;
        b=oTHRDA/0pqfc/qiFUi0XnZvf2RXlxqxwpbykEENWWkiDOX6iU5K98hc4woCF0Y8gNt
         S/n7RBQh5Kt028cFxIgE0mD8oR6banE7OeA1XaTZiSxow1rOz9+Bsf4TV+SibBmusAUJ
         M432uUASFNoyPSY3oBlCsjfLxBkcDiiFnNvSeZXcmWuKgCKjATDhlNcdtAF2a8yoklW4
         i4boI+xkPa0+MGq3BJTub/6Vsn/mmX8pNp1PksOIwcS+TMxf/7hFBl9EyOjA2+Ee4kzE
         yB8nZUvahN5zcuUEBXJCB6igVFP31P0nzKAs03/1TJXX+GtM/uGFCi6ouITtsZXCbUU/
         RGvw==
X-Forwarded-Encrypted: i=1; AJvYcCVzPaPuke2dHXD5IB/iL1FnaVgMui4X65kHwYni5UxtNgkWxwdFgNw+++gCozXHGZ+BWhg0K5JjFHP1FjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSk1oIBdBM1rKkAdCsfY2CsgB3Sh1S64VF/oA4d8xxutMUnl6
	oPnwvAfcXnPaFxUGw54gAZcl4IgfgwXETdExyAhYcDFI+zE+g6MfauXSnI1Olem1T1rW+DHkTHi
	UuiuAz4Od4EVy0TsHBGv6U2pR5gUxxLGLlEVrvLXHBrGJlIejOUhJk0GHEuE=
X-Google-Smtp-Source: AGHT+IFVGWhk4uNuq/3XSr2HmsTKn5LODCeLBH6XGXHRcYkXEMP7JELHoB/KmwKV/iNtHfluoy9qCfkKgvdGa6NILIQg7YNEKktQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2409:b0:432:109d:cb12 with SMTP id
 e9e14a558f8ab-432f9073efemr47555025ab.28.1761757922110; Wed, 29 Oct 2025
 10:12:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:12:02 -0700
In-Reply-To: <CAPqLRf0faZTieiVe_6XuJdhR7A02Uv6xjO2adVRUqwRLaWK29Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69024ae2.050a0220.3344a1.042c.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com
Tested-by: syzbot+0399100e525dd9696764@syzkaller.appspotmail.com

Tested on:

commit:         e53642b8 Merge tag 'v6.18-rc3-smb-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10264fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c95b0be0c2d0972f
dashboard link: https://syzkaller.appspot.com/bug?extid=0399100e525dd9696764
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16913e7c580000

Note: testing is done by a robot and is best-effort only.

