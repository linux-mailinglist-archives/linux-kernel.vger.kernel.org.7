Return-Path: <linux-kernel+bounces-797250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF7CB40DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262EC5E17C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C22E62B5;
	Tue,  2 Sep 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2At1RCp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80529BDBC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841863; cv=none; b=p8WFX/G+G9xHpcpKw9SH8Zfc8BoQYtfPDDDKY70JqqekfpbwciaKQacrQmAMrqpXIaBzZyYEGVuTrBB6IYJsQLtB+3/ytBxBTDWEgYnxrLo0KBdC4mPAbp8CdK6ise6vPNrNiJX8Cic0aQWW0ozpnbkyqcueLrvphmSYAr6J164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841863; c=relaxed/simple;
	bh=LT6iwYPn+yitERzqtYFHHmP4Vm+0O+/xC7OaAftkoRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov2lQC/wDHdKQ77+FQEgwnezMyLONsm+c34UZ/UEnGyMGInUEi+gD983yplg0wnI8espjjwLbukFGax2QheIxfztXtSkhZKo0U4Et86saQm+cWsl+zYG//5xq52ZMU5PRrOWjWtSp5QZwryTt5cbqbaNdcN2tkW06DYl+EukWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2At1RCp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3dcce361897so50398f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756841860; x=1757446660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN+LWKqwK4sMN1iNqWht7ls9UeWeamLxqzlz9dPBRJ4=;
        b=O2At1RCpV86tyZO3K0ljCK0bfdIBjYEI/u177Rh1rqPl71EqzQU9RhITBe5fZozt2b
         s3u6pcaaKtjslWQBMIBQ8+wyitCFbhSx2u+mM9uQJFwOeP7dfKHtON7CJ5Rfk3posI1/
         ItFIQx9DrwjwEQi63Hx8O7zsuBqJSquOtvcebJJqwZ45LXnZAKXXiJKaNJ3pziVmszhs
         Loplm6bKGZr1fTafZEYZ4tug+cF7ovjyk3QWoSEoWBoCbbauEIpd46fJF/ZP62AKTPW5
         j3XPTWp3IZCGJVeZGvU7udsKJ6aXncMoluHpLnPjBctxaBRjx57K2LV93ZcmFdBrzLLI
         PrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841860; x=1757446660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN+LWKqwK4sMN1iNqWht7ls9UeWeamLxqzlz9dPBRJ4=;
        b=cNujqm79iYI1fbBhjx+K48xebv5gmkn0Vwl9iL2omtd/qw9LIZXz7i1LhLV8yzCDzv
         YngmY3vjglaOGqfJeocvgcqiYGpugESymk11cAeJ5mh3U3GkyurriR6ntHaCgAVcnmsr
         XoOeP9+VPMFs8jBsvg8r9WJphCCSihp/XoR7x7ysQ6SA7zIeKlY80mZGOfbmC/5Zq+CR
         xCKC6z8kJL/qQZIVNmPeD7MZ9WUN00bazFpwfjHOuSEcPL9pxvgZdgl7sPRYEpPCoPSf
         DSVA6eQjIvLXOLrdNKZ/cTptyNfSIQoLWaGBjHHD2kUAGq/yBh25OJanJKf99trWMqk6
         VUFg==
X-Forwarded-Encrypted: i=1; AJvYcCWaCEigr6sBNB49JEF03bPpW69yJcaFjGN32w3YTZTH8Pq46raOJ9nDL7bvVzY5geaF4wVEPzHHd8wC8vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhXbWXReV98jDjSf7LH6Z2ffZwF470wxnfaJWomCG7Xo67ASc
	gFaAUspzjwgktdk9oiiaGL3wg7N21WJEK+R56FkvPAvYhns/paBwf7OYWgC5BRDd6DmV4MP2Rvb
	v17oesRpu7uVyFdojG9FQVR4dqG9bm1Q=
X-Gm-Gg: ASbGncu4emgvJa7LnX6ds5BhEot7Gl76j/Z1UIrmmZcg4cQrq5cZj5VeqX92uS40VjR
	N4zpySKpe3ZMdiMAQIiroYVtbZQGwOxmnXk9Nlh7ZyijPns+wfWPVxnRiNQVXkMgWNgzp3APori
	AM0iUOWKeCFvDxVcqTz/Tot7iAg0ir07e6AqkF9aPjM7+QMWq/E1Po28N0EJCvvzbV+a0TKydHD
	pzNu0HaksrVh7tfFAp6BdM7TWRJVtjxMQ==
X-Google-Smtp-Source: AGHT+IE6JA1rXpJi8UiA+K6Yea5vIZxcrVcThUxtiOrKC1Gba2vVHUc3Ak3hsKF9d6zhxVs5C57aCATtYKOozOMVisg=
X-Received: by 2002:a05:6000:4013:b0:3cb:2049:c743 with SMTP id
 ffacd0b85a97d-3d1df34f336mr8933126f8f.52.1756841859887; Tue, 02 Sep 2025
 12:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net>
 <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com> <20250902192609.GL3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250902192609.GL3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 12:37:26 -0700
X-Gm-Features: Ac12FXwDXN9QMNiUTJknMrbdlulmyCL31eMwICGIcz-49koiMu5xKhxNEMe7f40
Message-ID: <CAADnVQKns0xLA+oEdgF-gZ9W=pqjkL2h2OcUQxH+CvJ=vVL-0A@mail.gmail.com>
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Sep 02, 2025 at 09:04:51AM -0700, Alexei Starovoitov wrote:
> > On Tue, Sep 2, 2025 at 1:19=E2=80=AFAM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > >
> > > Because this is all somewhat magical code, and this change is a littl=
e
> > > on the large side, it as been suggested I 'upgrade' the Changelog som=
e.
> > >
> > > On Mon, Sep 01, 2025 at 09:13:07PM +0200, Peter Zijlstra wrote:
> > > >
> > > > A while ago [0] FineIBT started using the 0xEA instruction to raise=
 #UD.
> > > > All existing parts will generate #UD in 64bit mode on that instruct=
ion.
> > > >
> > > > However; Intel/AMD have not blessed using this instruction, it is o=
n
> > > > their 'reserved' opcode list for future use.
> > > >
> > > > Peter Anvin worked the committees and got use of 0xD6 blessed, it
> > > > shall be called UDB (per the next SDM or so), and it being a single
> > > > byte instruction is easy to slip into a single byte immediate -- as
> > > > is done by this very patch.
> > > >
> > > > Reworking the FineIBT code to use UDB wasn't entirely trivial. Nota=
bly
> > > > the FineIBT-BHI1 case ran out of bytes. In order to condense the
> > > > encoding some it was required to move the hash register from R10D t=
o
> > > > EAX (thanks hpa!).
> > > >
> > > > Per the x86_64 ABI, RAX is used to pass the number of vector regist=
ers
> > > > for vararg function calls -- something that should not happen in th=
e
> > > > kernel. More so, the kernel is built with -mskip-rax-setup, which
> > > > should leave RAX completely unused, allowing its re-use.
> > >
> > >  [ For BPF; while the bpf2bpf tail-call uses RAX in its calling
> > >    convention, that does not use CFI and is unaffected. Only the
> > >    'regular' C->BPF transition is covered by CFI. ]
> >
> > I cannot comprehend the new scheme, but thanks for heads up.
>
> Anywhere in particular you're getting stuck? That is, where should I
> improve the comments / changelog?

Well, I mean all these tricky changes are allegedly because
"Intel/AMD have not blessed using this instruction, it is on
their 'reserved' opcode list for future use"

I suspect that 'reserved' opcode will not be used any time soon.
If 10 years from now the opcode is used in some future CPU that CPU
is better to be not vulnerable and CFI, FineIBT things will be
gone from the kernel by then.
So I would do absolutely nothing and just ignore the lack of blessing.

