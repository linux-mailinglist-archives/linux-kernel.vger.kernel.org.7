Return-Path: <linux-kernel+bounces-873580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD2C14333
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE0619C6239
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CE3101C0;
	Tue, 28 Oct 2025 10:45:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0630FC2C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648305; cv=none; b=Rqd4oL6VvaGXcHxzlAybxh44JlFCSQ15xKqC7kTO5kHW65Z9VWsttzosDypJBbMTSv/ytvtjVrlKw7zAl4fhL2G0q2WTmQk7bvzMx4akTC0c2UMTZSTJ+YQthBSfZywJraRjR08pTmHiDFOlur/lbCPVdcakvyj/TColu9vlsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648305; c=relaxed/simple;
	bh=6HwPBkpjT2nV7cVtZY3ZVfFdluzjavGnh3Hd7v7ozjE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kA6LXt9+Y+ueCtVQXsHJiF5hWiW0/1j4nT7DJXbkTtWEN73+mIuBtBa1aRhI5b3KRvxpp3P5qA1Dy9tjSSdcW5o0jE6sIfPDaJIelb5do3at9z0sl8MSLGZrlJyn5I+C12UYKLduWM3glI+0Cm+WPrDIQ04fw8S/6TjnAuw1aMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so1816266139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648303; x=1762253103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwftitBlecf9YnHglCqyzkO3aLYoB4tHROftIrnFO9k=;
        b=RP5u3SshTUvK+xClfxLL8e2gzdlmYlLH7zoMGJVJNdJDdccvHMXXkLBgCO0xEhsPi/
         gugV3pjMNOw/FGWtWe2AUr0xfhrrZCMU8nlIO6A2jSiqLxDd2FubOGtlHqNIUpHu8jZg
         VdAOfT1pYp510nw6HYLGxzyGpl0lU/UhjsEQE5YTgss6nkTn/6ZXNLIKLo65kRv9cLf8
         5OOB87EAIlGCZ4+w7L+WqoBah25QodvwWFVCr4yUlB3YBUSddICpa2ajUF+rh+mQD6KM
         KTEZpa29Q9ZV612oZ11HOZceeQ1lL8MD/sQTG8Ku290agPz0jVwVIiiy65zHznye2/2N
         a7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVySsRgObtbmDNaWqE5pxoM+VdI/gPYFuL/Y+eQz0bqCusfwbJhj0NCuujqVFnzaHv79XSqMMs5YU+5S1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSlcojSNlWU55XdcS7QtklJhUohSbhdpM8BuzyhNSzNQlv2D8
	ycANFi3EJEH7Ya6ZMe/hQHJmIxX6vp+I6NGmxFmrkniTjKCIWb5gd3TNseeVKXFmXeAzt4p/8uE
	qMtd+u4bp5lGTB9ZwXJGwivu6yXKZjuDskDEds5AiyDW6w2K1BBxCUQUlZzM=
X-Google-Smtp-Source: AGHT+IG+qQeCotsmkgADTHjvsY+euGl1PKUjHuH2CRKtxqNcy/AUZ0c54FbPIxhhTHjOqo58NjaVIQf0eR1/gROzDuKNJ6aPht9Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:426:2f95:31a5 with SMTP id
 e9e14a558f8ab-4320f86b90dmr44538095ab.29.1761648303475; Tue, 28 Oct 2025
 03:45:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:45:03 -0700
In-Reply-To: <20251028104009.2mUGn%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eaf.050a0220.17b81f.0016.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1222dd42580000


