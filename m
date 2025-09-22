Return-Path: <linux-kernel+bounces-827107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9D5B9053D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B33189991A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061030499D;
	Mon, 22 Sep 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpMc8bjP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD1192B66
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539828; cv=none; b=JoHSMU3lMWpFgt48dC5h3joQ8Il3Qmt1ZWUjC6LU8AimOJun/jclLlQUdCwEuypb2ifBGf/TvmEhaiFwD+X1BlUwzIQ+eSdO/qQxBv9ER/LLoyWMuqZ34nrAsLyW+5EkGvM0U1DktNrXTzxEhFCQG+EzhG12rQPaD3qQy1/uhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539828; c=relaxed/simple;
	bh=w6YwY5vmKus00bBj/e3FJTj7WCtO3igJ6hLmCin2MiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW4lHCNINBcGzSmXM4Ra76IzOnaahxoP+FD03rbuk8jhn8YVymdWyUd02vmHOoZFJlOTN1GITgwAyk/HkO3LADi9VFPeYecn/fpuHmueBP2TSCRoIMCGqkdVjPJPOSDxaodXZ4dbAlAbVfz30rcwEX75QMG331MplbUAOV/IYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpMc8bjP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso14614655e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758539825; x=1759144625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTlxhWqrZh7egDtJ3L2cCvngzXZ86KR/jKo3mxorcAk=;
        b=YpMc8bjPqLRh/orwj+xuxcilFOvxMXJnOMgsTtIsl+yucbF59FMpH4w8daCkDoebLw
         VJOyow8aY51cjAEwu+0NIdycyRD+OgyMmbdyH6/zrzzwu9WHNmK+X2exF/3fNTf99sgW
         EjL5cuKgzGWjs7+vjVfJAMqAYIQTdcxlP5m5SG0yvtx/8woy17nP0068VrzpvsBNyBFM
         qvorlLt8nuoWdDAqEwoXfGQk5a+PTQsYibDafZMn+oj4lsbDEcZJKT73PkV0b5kzfdJz
         hT6HgGTo1XKmtmXghhxZA8Y+/5Bx0VufiI9QiM9V1vLnfSfONJnoWlm3AcDspe1iDy6I
         Tjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758539825; x=1759144625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTlxhWqrZh7egDtJ3L2cCvngzXZ86KR/jKo3mxorcAk=;
        b=ETi6Lz1Zkwk/NfhvD9wo7Q72UhBshyvMW9UJCg+XTS5+0sEkTYmq2Ud/ZKc3kBEthU
         4j4W3YO5rVRrdvBAnnPHz0ZJbytVGKGKt+nJEo0Wd47QIJ8xJpwMrGt9rgFzbYR53zfE
         CsBO9Hf/h5hILjDRAwyCgr3mRYPNbJXdOB3sig89kvEYQszNTUY+goI46/CrjMUZObUY
         /D2z3s1iLhPc9t5sd8gX9zfxkl0Bv3qhZkdXhzB7suS54nylikckjM9Jw+lfi/3fhkdi
         e8lwbPMTB605c4SSb4Y0Ld8mOdvkwDs2OSR9bvGYn4Ij9IfwbhaDOchZUh+/1EJsJUmg
         4Eaw==
X-Forwarded-Encrypted: i=1; AJvYcCU37Q43tuoFAVy28jz2gxKC8Qry6barQBS8sSk54oKXvLqeR5FsxIyBrMw55U7sZaMYA3fW0jv/r63/cn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYtFljGafiwlodfn5DuPVIjCmNxz6jFebfs6NYprE7VQ5P605
	iqoIe2Qh53DjRfQYA8Xb9sX9BA1p3wvGczxZjgLZIGQQ7lY6jvGmgU6E
X-Gm-Gg: ASbGncssbtpTsPrj8k52wGumsONuIyIXsjdukWdBhmjgS40mmEs+JBqh7d7szowLVmV
	JxR8p+A1pB9x8ChdCgdyT65U/bI3g9fhkWjPii/0EGkiGsHMQEB9Ioc/b5a2QeXFYlCAstEqiVE
	E+diubV+svgIXCVx1txUSrxfmWKp5aH9QGIxbybLAnfqHKErFAx3u3zcQgPEZql63VUR5NBUgv4
	meEhLyspm8TWZik9aGeGIs3zOdwjWar6ZrvPitanW5wznaZXvIXckzebsJtmcxkI2R0dxtcpmoW
	GPsE3Gg9dy1+AfTxYokA1ALS6RiL69K/ddJboigpRCy9GZYnAw68RWRR+7a4VhQ9iMNqV5d4Pqr
	hMkGVy8ub2hvx7Zz7zLPC5axFCW5BLMu1VBs41rGR7OMxf5anp4zJJ9a6n0HqdXjsNyBbm+yPpS
	uHn3MR6DtchXbp0c6joxfO9aDHzE/ld/A=
X-Google-Smtp-Source: AGHT+IF3Msd8ZoPMJEs7K/zv+zF43VhoJYGAT779uFAi/spPfWjaRb9gxGyuHHyUSSki7SqM8rn4Gw==
X-Received: by 2002:a05:600c:1c03:b0:46d:fe0b:d55a with SMTP id 5b1f17b1804b1-46dfe0bd756mr14051695e9.33.1758539825257;
        Mon, 22 Sep 2025 04:17:05 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006cf0c3fccad951b0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6cf0:c3fc:cad9:51b0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm205116075e9.2.2025.09.22.04.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:17:04 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:17:02 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
Message-ID: <aNEwLpylAfkgj3L-@mail.gmail.com>
References: <aM1moP0fr7GrlbWZ@mail.gmail.com>
 <68cd7300.050a0220.13cd81.0000.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cd7300.050a0220.13cd81.0000.GAE@google.com>

#syz dup: [syzbot] [bpf?] WARNING in maybe_exit_scc

On Fri, Sep 19, 2025 at 08:13:04AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
> Tested-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         a3c73d62 bpf: dont report verifier bug for missing bpf..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=13928d04580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

