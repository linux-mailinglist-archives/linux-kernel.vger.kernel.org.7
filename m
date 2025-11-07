Return-Path: <linux-kernel+bounces-889709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FEC3E4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E36434C83A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42312EBB88;
	Fri,  7 Nov 2025 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="US2fHcAA"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EB1D5CC7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484189; cv=none; b=ZYjGp3LgWiuw5VTGtkVWGOH9UXgwMdYeFKGU9N+DfmZEoUUAyyw0i19CDuvYmz7Tqg/121bKGMcnO/5Q94GlbIZg3Nj9RzPe5O8xFpbfCtIGeD4gWYfL56kIbN2weplAJT+FonU9+ExokepPsxZDb/aAwpFwZNMAX9syByJsoQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484189; c=relaxed/simple;
	bh=KGyX5E3l/2rEAVe4fMzxCdPllwN1yg3tAT2+mr3+nM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxiqBzRjaIOkcmlJQdJP5/ub6s/TJl1IV9YNHUH18UwxcjvdAyu2lW9Jw5KlPTRNzjmsmOcIYi8fbP3TiZ2J7FtOwggAobe9SM3zz8vy40d9E0A32QfR9Ma9wg09zQ6Xn4Pvw4EXoaBP9nl3XbQjN1f589xSR2N2r1Dop7jjP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=US2fHcAA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed67a143c5so170711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762484186; x=1763088986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQmgj5QKChdvWBZl6l2K3P0Jmw4eVyyr9pwq1Eec+/A=;
        b=US2fHcAAxOFqj401dhmK2itmJnVSnZY4fpM42aS+n3JX1caMB4TO0AGocHk25PfPkG
         b/s5/Fbkc0czeiK+QgEMH9UvLjLxXbQFJ4Sufq8hhzwgxREa2HokH9vziTkk6VbJtUGq
         s8mon1sb2Gt+IcqYCbXHI1jbTlI7Lks5ZLyBdO96teE+YG44O0bLBSc1TTYv4yHwhLYz
         zkLUnqH/vQBTbVFxX+0wnX+Jg9OkALrT6zIxUX6A+AfYjwxs6YM8j9nTqP068LeCopSC
         EzkBWwva470U0IAOF5UaNHAbtHh427ykdqQREgMONl5nTCEITWpsWYiTcdCFYMdXg48D
         ZUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484186; x=1763088986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CQmgj5QKChdvWBZl6l2K3P0Jmw4eVyyr9pwq1Eec+/A=;
        b=HdmD8iQKGbJbIi3H4Dp4KxnaAqq6KWFAli3PD8lvzAq2ZKPl0W88dW+zUgI/7Je29F
         ntedr7CWbCC7ZzI4D85GFKss4cEFnXWQ1NhfTwuHs5mZM94EIcREEcOThprgsV04cSau
         gb5GFyj3sAKXvLGyqdlNfP+xwMaRr4QDkPO2ZA0ppEdg0fYiYHKnSRMcjKfOQcBj99tj
         kZsQXe573Iw9uPTnXvhDaBpWNxkmm3ff37iMfrvWk1q8pEx23G/LwkYf32d5uq9HAS5v
         jRypAvZ8bLMVQjjpiulilP9660djmh2015pP0N/CPR30k99zzUMyj0yuvahNzU71dpA5
         /zdA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBZLF8LEskMJs2WFbQSvulIRYLj3kQbgnR3/gGe2KkS5fYMyWG2aApQLJCu4Dms9L1R8nwvxCPoIlpls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbbRdUsCmW7sWJrbOhGERgAgk89/mXcsGwUUydw4znM3LvLuO
	TSv4RGm16XPEExqu2ndhNPvR3X+ketbJYhCKbsZDjE/QBZCGIa91ukxNfYij8xeCrST9u9SAGAL
	14lBhKh2t2EFLW09nNC6zf5Mg+ay7vL3+pTFKnuwS
X-Gm-Gg: ASbGncuG5/SB0b/OEcnuh1C/qMTa4yNWh4mOf5fy7FAFC9Tav6zYdl0niaz+f8J1MnT
	mYy74TECnFia636LFelQknUzpj5bDc8dPQBBa5gOlu8nCtUkNndlj30OcpzSYDgnPcLulH6lqDb
	MdGqWYjqyyj/4cs24v+0fU4D4K/mqt3aeQnL5gBsgcEx+BEeiUOWgA1oXQRkQGdG7WMgJtHaTqc
	SYWTIS0/VONikI2/Iv9uJiflfsDpFPwVe29gbNCPfZsKQMmkIuwceu6vwZG
X-Google-Smtp-Source: AGHT+IEGltPMlvWKHIQAUQbc07wVxz4D4r3t1360g0HtPzLaVR/78O7+74fTpgXmKuSxlgcBZCrr9IfOzixdBMHk7v0=
X-Received: by 2002:a05:622a:14d1:b0:4b7:9617:4b51 with SMTP id
 d75a77b69052e-4ed960aa0f2mr1753261cf.15.1762484186227; Thu, 06 Nov 2025
 18:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com> <20251104003536.3601931-5-rananta@google.com>
 <aQvzNZU9x9gmFzH3@google.com> <CAJHc60ycPfeba0hjiHLTgFO2JAjPsuWzHhJqVbqOTEaOPfNy_A@mail.gmail.com>
 <aQzcQ0fJd-aCRThS@google.com>
In-Reply-To: <aQzcQ0fJd-aCRThS@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Fri, 7 Nov 2025 08:26:15 +0530
X-Gm-Features: AWmQ_bn_M54rF3JLR8P7eKkDr2OreZ7Iqye392uow-ms0jUYNX8AdkTca3yQK5I
Message-ID: <CAJHc60y-0ea=7_WExNzcVNYWkAP43507puJfOEir1r4ezv3CUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] vfio: selftests: Add tests to validate SR-IOV UAPI
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:05=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-11-06 10:35 PM, Raghavendra Rao Ananta wrote:
> > On Thu, Nov 6, 2025 at 6:30=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
> > >
> > > On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> > >
> > > > +static const char *pf_dev_bdf;
> > > > +static char vf_dev_bdf[16];
> > >
> > > vf_dev_bdf can be part of the test fixture instead of a global variab=
le.
> > > pf_dev_bdf should be the only global variable since we have to get it
> > > from main() into the text fixture.
> > >
> > My understading is placing vars in FIXTURE() is helpful to get an
> > access across various other FIXTURE_*() and TEST*() functions. Out of
> > curiosity, is there an advantage here vs having them global?
>
> Global variables are just generally a bad design pattern. IMO, only
> variables that truly need to be global should be global.
>
> The only variable that needs to be global is pf_dev_bdf.
>
> Since vf_dev_bdf needs to be accessed within FIXTURE_SETUP(),
> FIXTURE_TEARDOWN(), and TEST_F(), then FIXTURE() is the right home for
> it. The whole point of FIXTURE() is to hold state for each TEST_F().
>
Sounds good. I'll move them into FIXTURE().

> >
> > > > +
> > > > +struct vfio_pci_device *pf_device;
> > > > +struct vfio_pci_device *vf_device;
> > >
> > > These can be local variables in the places they are used.
> > >
> > I was a bit greedy to save a few lines, as they are reassigned in
> > every TEST_F() anyway. Is there any advantage by making them local?
>
> It's easy to mess up global variables. And also when reading the code it
> is confusing to see a global variable that does not need to be global.
> It makes me think I must be missing something.
>
> As a general practice I think it's good to limit the scope of variables
> to the minimum scope they are needed.
>
Agreed. I prefer min scope too, but I guess my habit of using global
variables in other tests and avoiding passing pointers around led me
to use it here. I'll move it to a local scope.

> > > > +     snprintf(path, PATH_MAX, "%s/%s/sriov_numvfs", PCI_SYSFS_PATH=
, pf_dev_bdf);
> > > > +     ASSERT_GT(fd =3D open(path, O_RDWR), 0);
> > > > +     ASSERT_GT(read(fd, buf, ARRAY_SIZE(buf)), 0);
> > > > +     nr_vfs =3D strtoul(buf, NULL, 0);
> > > > +     if (nr_vfs =3D=3D 0)
> > >
> > > If VFs are already enabled, shouldn't the test fail or skip?
> > >
> > My idea was to simply "steal" the device that was already created and
> > use it. Do we want to skip it, as you suggested?
>
> If a VF already exists it might be bound to a different driver, and may
> be in use by something else. I think the only safe thing to do is to
> bail if a VF already exists. If the test creates the VF, then it knows
> that it owns it.
>
Makes sense. Let's skip in that case.

> > > > +FIXTURE_TEARDOWN(vfio_pci_sriov_uapi_test)
> > > > +{
> > > > +}
> > >
> > > FIXTURE_TEARDOWN() should undo what FIXTURE_SETUP() did, i.e. write 0=
 to
> > > sriov_numvfs. Otherwise running this test will leave behind SR-IOV
> > > enabled on the PF.
> > >
> > I had this originally, but then realized that run.sh aready resets the
> > sriov_numvfs to its original value. We can do it here too, if you'd
> > like to keep the symmetry and make the test self-sufficient. With some
> > of your other suggestions, I may have to do some more cleanup here
> > now.
>
> I think the test should return the PF back to the state it was in at the
> start of the test. That way the test doesn't "leak" changes it made. The
> best way to do that is to clean up in FIXTURE_TEARDOWN(). There might be
> some other test that wants to run using the PF before run.sh does its
> cleanup work.
>
Sure, I'll clean up everything that the test does in FIXTURE_SETUP().

> > > You could also make this the users problem (the user has to provide a=
 PF
> > > with 1 VF where both PF and VF are bound to vfio-pci). But I think it
> > > would be nice to make the test work automatically given a PF if we ca=
n.
> > Let's go with the latter, assuming it doesn't get too complicated
> > (currently, the setup part seems bigger than the actual test :) )
>
> Let's create helpers for all the sysfs operations under lib.
>
> e.g. tools/testing/selftests/vfio/lib/sysfs.c:
>
>   int sysfs_get_sriov_totalvfs(const char *bdf);
>   void sysfs_set_sriov_numvfs(const char *bdfs, int numvfs);
>   ...
>
> That will greatly simplify the amount of code in this test, and I think
> it's highly likely we re-use those functions in other tests. And even if
> we don't, it's nice to encapsulate all the sysfs code in one place for
> readability and maintainability.
>
> If you do this I think there's also some sysfs stuff in
> vfio_pci_device.c that you can also pull out into this helper file.
Good idea. I'll create this lib.

Thank you.
Raghavendra

