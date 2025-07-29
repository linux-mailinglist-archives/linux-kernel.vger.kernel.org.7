Return-Path: <linux-kernel+bounces-749947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EEBB15550
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C8173857
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38B27CCEE;
	Tue, 29 Jul 2025 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="umU64zn2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137C27A130
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828417; cv=none; b=i0Awe6wsbXMcac1E1QBob9WdU5M5H0tHG1EyKe67ndi6pk3RDZqTXv4AseVfknS5rFiUf3zo0HPyRbk26toAnmdGKCZQPU1vLtLG4Yg6EsySRo8N/sKlNmEa0uRE9VyfeVmj0KEIII+DB/06WKQiZYsg18r00tHAwGgLdDp7zio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828417; c=relaxed/simple;
	bh=1qzJ4sfF9BBwF71oQR4+YFfDas1tVA2Sdpx5ngS9DDc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lTzY+eOCpBojtTbdIUrIBGH7+KtAgS4JrMVMZvI1GbK+fxswVjODx+y6KTTVK0iaOzHC4zOUTrKw4rlNTWRfi8ZyatJ0dSaRBD0gmQxaX+rIYZBi+shA84T+IYFTn0bhcJxBaOenEUxhybWRzlJVVn+R0VJ63vXT/nNq5h41Nio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=umU64zn2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56TMWV8C1101226
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 29 Jul 2025 15:32:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56TMWV8C1101226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753828353;
	bh=/tggXm0FyFEm+Ygc2qgRDy7yHSvAWF/GCU7KgVFJtxA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=umU64zn255xJ8MqmtwiOePWyJeP9FnD7fzXOyNyD/MmEhVnVeWu21jouO31yvVHNl
	 aHpOMKZ1O/4+NJpU+/NSid/0meG26sbDoyoDqRBm/t6jWH7OhWax6JuIe/GjvgsIj1
	 ip/Dw9rUm8+iMV+1FnTfkY7ie9KX0UKI/VDfbwZfdXLL3ZnS6GFSivf14yR2ZCk1xz
	 JssQvvv6zPucmCiOHi9yuIjDzqdCrVdM+q1lI5N8J9c+Qzq2pwr8S7GNx0kUGArHSZ
	 3p9rGRZx3wwDUOnuAxXHiXQI0Kn6kulZmr1KBORyIswBjyjASJL8DXkP6XEEVfhx8G
	 VXC2lacbPKdYw==
Date: Tue, 29 Jul 2025 15:32:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, darwi@linutronix.de,
        sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com,
        skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/intel=3A_Fix_always_fal?=
 =?US-ASCII?Q?se_range_check_in_x86=5Fvfm_model_matching?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAO9wTFjkBz=NbHeAdOaJ8jFpgOmO=pM5O+Q43hTT8qqvvXTSog@mail.gmail.com>
References: <20250729042621.6403-1-suchitkarunakaran@gmail.com> <2025072925-lint-agreement-77e8@gregkh> <CAO9wTFg_jCUZ+DxXVDM11_715r6ALJ=HyRXkcBxhGrBUo4iVUg@mail.gmail.com> <2025072931-recount-stifling-73e8@gregkh> <CAO9wTFj1qCkhNG24hAWDfZqoJy4mhPFf6mKp=jg7GnaLmHix-w@mail.gmail.com> <2025072947-laziness-unlikable-e0f3@gregkh> <CAO9wTFjkBz=NbHeAdOaJ8jFpgOmO=pM5O+Q43hTT8qqvvXTSog@mail.gmail.com>
Message-ID: <ACB37631-097C-4260-AE4C-F2FD7FB9B767@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 29, 2025 2:08:47 AM PDT, Suchit Karunakaran <suchitkarunakaran@gmai=
l=2Ecom> wrote:
>On Tue, 29 Jul 2025 at 14:31, Greg KH <gregkh@linuxfoundation=2Eorg> wrot=
e:
>>
>> On Tue, Jul 29, 2025 at 02:24:43PM +0530, Suchit Karunakaran wrote:
>> > On Tue, 29 Jul 2025 at 13:26, Greg KH <gregkh@linuxfoundation=2Eorg>
>wrote:
>> > >
>> > > On Tue, Jul 29, 2025 at 12:23:27PM +0530, Suchit Karunakaran wrote:
>> > > > On Tue, 29 Jul 2025 at 10:58, Greg KH <gregkh@linuxfoundation=2Eo=
rg>
>wrote:
>> > > > >
>> > > > > On Tue, Jul 29, 2025 at 09:56:21AM +0530, Suchit Karunakaran
>wrote:
>> > > > > > Fix a logic bug in early_init_intel() where a conditional ran=
ge
>check:
>> > > > > > (c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86_vfm <=3D
>INTEL_P4_WILLAMETTE)
>> > > > > > was always false due to (PRESCOTT) being numerically greater
>than the
>> > > > > > upper bound (WILLAMETTE)=2E This triggers:-Werror=3Dlogical-o=
p:
>> > > > > > logical =E2=80=98and=E2=80=99 of mutually exclusive tests is =
always false
>> > > > > > The fix corrects the constant ordering to ensure the range is
>valid:
>> > > > > > (c->x86_vfm >=3D  INTEL_P4_PRESCOTT && c->x86_vfm <=3D
>INTEL_P4_CEDARMILL)
>> > > > > >
>> > > > > > Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectu=
ral
>> > > > > > constant_tsc model checks")
>> > > > > >
>> > > > > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail=2E=
com>
>> > > > > >
>> > > > > > Changes since v1:
>> > > > > > - Fix incorrect logic
>> > > > > > ---
>> > > > > >  arch/x86/kernel/cpu/intel=2Ec | 2 +-
>> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > > >
>> > > > > > diff --git a/arch/x86/kernel/cpu/intel=2Ec
>b/arch/x86/kernel/cpu/intel=2Ec
>> > > > > > index 076eaa41b8c8=2E=2E6f5bd5dbc249 100644
>> > > > > > --- a/arch/x86/kernel/cpu/intel=2Ec
>> > > > > > +++ b/arch/x86/kernel/cpu/intel=2Ec
>> > > > > > @@ -262,7 +262,7 @@ static void early_init_intel(struct
>cpuinfo_x86 *c)
>> > > > > >       if (c->x86_power & (1 << 8)) {
>> > > > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>> > > > > >               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
>> > > > > > -     } else if ((c->x86_vfm >=3D INTEL_P4_PRESCOTT && c->x86=
_vfm
><=3D INTEL_P4_WILLAMETTE) ||
>> > > > > > +     } else if ((c->x86_vfm >=3D  INTEL_P4_PRESCOTT &&
>c->x86_vfm <=3D INTEL_P4_CEDARMILL) ||
>> > > > > >                  (c->x86_vfm >=3D INTEL_CORE_YONAH  && c->x86=
_vfm
><=3D INTEL_IVYBRIDGE)) {
>> > > > > >               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>> > > > > >       }
>> > > > > > --
>> > > > > > 2=2E50=2E1
>> > > > > >
>> > > > > >
>> > > > >
>> > > > > Hi,
>> > > > >
>> > > > > This is the friendly patch-bot of Greg Kroah-Hartman=2E  You ha=
ve
>sent him
>> > > > > a patch that has triggered this response=2E  He used to manuall=
y
>respond
>> > > > > to these common problems, but in order to save his sanity (he k=
ept
>> > > > > writing the same thing over and over, yet to different people),=
 I
>was
>> > > > > created=2E  Hopefully you will not take offence and will fix th=
e
>problem
>> > > > > in your patch and resubmit it so that it can be accepted into t=
he
>Linux
>> > > > > kernel tree=2E
>> > > > >
>> > > > > You are receiving this message because of the following common
>error(s)
>> > > > > as indicated below:
>> > > > >
>> > > > > - You have marked a patch with a "Fixes:" tag for a commit that
>is in an
>> > > > >   older released kernel, yet you do not have a cc: stable line =
in
>the
>> > > > >   signed-off-by area at all, which means that the patch will no=
t
>be
>> > > > >   applied to any older kernel releases=2E  To properly fix this=
,
>please
>> > > > >   follow the documented rules in the
>> > > > >   Documentation/process/stable-kernel-rules=2Erst file for how =
to
>resolve
>> > > > >   this=2E
>> > > > >
>> > > > > If you wish to discuss this problem further, or you have
>questions about
>> > > > > how to resolve this issue, please feel free to respond to this
>email and
>> > > > > Greg will reply once he has dug out from the pending patches
>received
>> > > > > from other developers=2E
>> > > > >
>> > > > > thanks,
>> > > > >
>> > > > > greg k-h's patch email bot
>> > > >
>> > > > Hi Greg,
>> > > > I've a question regarding backporting this fix=2E Can this fix be
>> > > > backported to stable kernel version 6=2E15=2E8? Also, should I se=
nd the
>> > > > backport patch only after the initial patch has been merged in
>> > > > mainline or linux-next?
>> > >
>> > > Did you read the document that my bot linked to above?  It should
>answer
>> > > those questions :)
>> > >
>> > > thanks,
>> > >
>> > > greg k-h
>> >
>> > Hi Greg,
>> > I did go through the document you linked=2E I just wanted to clarify
>> > about the backporting process, especially since the merge window has
>> > already started and it might take some time for this to be merged int=
o
>> > mainline=2E Regardless, I'll send the backport patch after the initia=
l
>> > one has been merged=2E
>>
>> As the document states, a commit must be in Linus's tree first, before
>> we can consider it for any stable release=2E
>>
>
>Hi Greg,
>Thanks for clarifying=2E I understand now that a commit must be in Linus'=
s
>tree before it can be considered for any stable release=2E
>I apologize for the repeated questions and any inconvenience=2E
>
>Thanks,
>Suchit

It does, *unless* there is a detailed explanation why it is not applicable=
 to mainline (for example, "the code in mainline was completely rewritten a=
nd does not have the bug because=2E=2E=2E")

