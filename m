Return-Path: <linux-kernel+bounces-731017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7947B04D91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B14A4E08
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BC2C033B;
	Tue, 15 Jul 2025 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="OJlOlQoE"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC72C08D7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752544125; cv=pass; b=mvErNqI4VtKXkZzjWQA+ehOA0CdPet+VSMawbjwI9L/buu7XMn5SUBD4NE82i/BSrC2DR52ZluVuAeZhEux1LvB18zj6A1OQfVVAEMA1CxQSm1omzyeNtMrKK6oF+/RTTXrmwXPTLFO4S/3CIash2hZZB0v1czeixc1ZIKwG95k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752544125; c=relaxed/simple;
	bh=nEtDPSrsyQq93JP5epljxxVApbjjoFfiVQwFDqr6vSc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=u23DxNMEq4SQs32n/v6gvikFFRyJgiKahPB7k0ihzNaVLBGu+MlDm6srbZMgDKM1Wbi7AnmX8tGOO0nHInuOGRqaX29mLN7SKwGHL23rx2LfeAFVeYYCjEJZLJtRK09zIPxpPjGw0+sibOyriFzOxtpP6hE6onZSs4e6YdfcxxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=OJlOlQoE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1752544107; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fmV2TR2hLU9+T/ydCUiwp7DAfOhnwmLQNtCuWHrkvPgocR0xT/swkePBhd94tp78ImhIGImIAhNVXZnb/agGFKemav3QB5THAK8J6R2WIdEWJzVWFcGumv0dtqME3HnXe/0Yk2vXWm6/TewR1otnG/bvuLTx0NupMA2lrZjsm0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752544107; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=eQtiDlvvtjIlkDpHh37ZmAo9vSWNVQYirOhvBwpXrQA=; 
	b=mdxUSitZOmCF8AnB+WEL8n6XBYbRh7smG9EbZyGneLUd6GxKUrzUJgqz/LdM+RKoXcsG/H+Edw4+0ISawMVPFRi/Sp3TteJ23ou7lx6ClqY1QeqVYhHpNuYhPT4vDOacWodCdqzsvYbh26s6OYyW6dK7K7YRQacnKlGb43Kj/lI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752544107;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=eQtiDlvvtjIlkDpHh37ZmAo9vSWNVQYirOhvBwpXrQA=;
	b=OJlOlQoERk+gnNa0B8yb70k9Rn3TJFoLwXdDLgjqNPE3dRXoDuPBtcRURgsaWDrG
	MuoVBjphIXR3Sn9+Kd5G0O5/N28qs3z6Pwpb/XuWV2dMZnTjbnuQZFZa5vCynVcX9J0
	FPQ5jsAXMWWzrHGIN2jzQ7MSwBqn8EFDv423VA/Y=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1752544104282441.34739855050873; Mon, 14 Jul 2025 18:48:24 -0700 (PDT)
Date: Tue, 15 Jul 2025 09:48:24 +0800
From: Li Chen <me@linux.beauty>
To: "Ingo Molnar" <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Juri Lelli" <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
	"Valentin Schneider" <vschneid@redhat.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1980bc4cecf.4f3ffa421612787.2278126391533052891@linux.beauty>
In-Reply-To: <20250630060826.34217-1-me@linux.beauty>
References: <20250630060826.34217-1-me@linux.beauty>
Subject: Re: [PATCH] sched/debug: Add cond_resched() to sched_debug_show()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

gentle ping

 ---- On Mon, 30 Jun 2025 14:08:26 +0800  Li Chen <me@linux.beauty> wrote -=
--=20
 > From: Li Chen <chenl311@chinatelecom.cn>
 >=20
 > Running stress-ng on large CPUs (e.g., =E2=89=A5256 cores) can
 > spawn numerous process/threads (e.g., over 70w told from
 > vmcore) and trigger softlockup watchdogs when read
 > /sys/kernel/debug/sched/debug:
 > https://github.com/ColinIanKing/stress-ng/blob/V0.18.10/stress-cpu-sched=
.c#L860
 >=20
 > To improve responsiveness during extensive debug dumps,
 > insert cond_resched() into sched_debug_show(). This allows the
 > kernel to periodically yield and remain responsive, similar to how
 > cond_resched() is used in other iteration-heavy code paths.
 >=20
 > Below is soft lockup call trace:
 >=20
 > [ 1996.543070] RIP: 0010:print_cpu+0x2a4/0x770
 > [ 1996.543084] Code: f6 ff ff 49 81 ff 58 fc c0 b6 74 69 49 8b 8f 58 03 =
00 00 48 8b 41 10 48 8d 51 10 48 8d 98 20 f5 ff ff 48 39 c2 74 37 8b 43 14 =
<39> c5 75 19 49 8b b5 10 0a 00 00 48 89 da 4c 89 e7 e8 d6 f1 ff ff
 > [ 1996.543087] RSP: 0018:ffffc900704a7d40 EFLAGS: 00000202
 > [ 1996.543090] RAX: 0000000000000038 RBX: ffff88b1b9073900 RCX: ffff88b3=
26b86880
 > [ 1996.543093] RDX: ffff88b326b86890 RSI: ffffffffb6527fde RDI: ffff88d5=
79bd7256
 > [ 1996.543096] RBP: 0000000000000000 R08: 0000000000000028 R09: ffff88d6=
79bd722d
 > [ 1996.543098] R10: ffffffffffffffff R11: 0000000000000000 R12: ffff88d4=
662cf880
 > [ 1996.543099] R13: ffff889045e34d40 R14: ffff88b1b9073900 R15: ffff88b1=
b9074258
 > [ 1996.543101] FS:  00007f0d2a254000(0000) GS:ffff88e04f080000(0000) knl=
GS:0000000000000000
 > [ 1996.543104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > [ 1996.543106] CR2: 0000000000b6d7c0 CR3: 00000033f894a000 CR4: 00000000=
00350ee0
 > [ 1996.543108] Call Trace:
 > [ 1996.543115]  <TASK>
 > [ 1996.543122]  sched_debug_show+0x13/0x30
 > [ 1996.543127]  seq_read_iter+0x122/0x470
 > [ 1996.543133]  ? restore_fpregs_from_user+0xa9/0x150
 > [ 1996.543139]  seq_read+0xaa/0xe0
 > [ 1996.543148]  full_proxy_read+0x59/0x80
 > [ 1996.543155]  vfs_read+0xa1/0x1c0
 > [ 1996.543164]  ksys_read+0x63/0xe0
 > [ 1996.543168]  do_syscall_64+0x55/0x100
 > [ 1996.543175]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
 >=20
 > The full soft lockup message is here:
 > https://gist.github.com/FirstLoveLife/73f2185bed83a5faf7f94af8032a527b
 >=20
 > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > ---
 >  kernel/sched/debug.c | 1 +
 >  1 file changed, 1 insertion(+)
 >=20
 > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
 > index 9d71baf080751..9dd444c604a8b 100644
 > --- a/kernel/sched/debug.c
 > +++ b/kernel/sched/debug.c
 > @@ -1065,6 +1065,7 @@ static int sched_debug_show(struct seq_file *m, vo=
id *v)
 >      else
 >          sched_debug_header(m);
 > =20
 > +    cond_resched();
 >      return 0;
 >  }
 > =20
 > --=20
 > 2.49.0
 >=20
 >=20
Regards,

Li=E2=80=8B


