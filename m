Return-Path: <linux-kernel+bounces-808989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B81B5072F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DCC7A33A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E233EB15;
	Tue,  9 Sep 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjjrjcNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16224199931;
	Tue,  9 Sep 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450268; cv=none; b=M2SemMC65wywHqQZQ9uJmVtgWGfFXT/64TJj+Bsk4f4Dx6EGb+OxheDgnrv30wd1Au3L7T2pxH7PcdYVtz+oCIpHXtvxnkmsdTidSBi3kxvccCJcqqkLaEs2NuMiiAQiALm+bOfW3/vcWx6k2n/E4aLyEMVtrhCE13KkFYrOkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450268; c=relaxed/simple;
	bh=4bWV7M2yDQ7exb2uYwmh6mGflWJWZxtSE98QDqcCzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Abd3/JL+1IA9+t3tCUiBrLEtPQ/fyEVdGrEXzDGlTLAJKUxXno13ZG/XMupHmWCCgatq5abTFf0jIzKF5KHmWVWuSfI1YWRcSWUfKY9Rm4Cj6657TwxZR7dCDLeXDfoAdPD0fdNX6cFon6zmk4xQPAq8V0MTHHYxL+3Rt542jsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjjrjcNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6735AC4CEF4;
	Tue,  9 Sep 2025 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757450267;
	bh=4bWV7M2yDQ7exb2uYwmh6mGflWJWZxtSE98QDqcCzDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjjrjcNe+b0DffQ5/rz3V/kSDN8ON8xDBFNzv9UxiatK4Or8Myqxbex5o3drB3lr5
	 5HRh5rpXWfVoIpodCon9dv38q1dj4s3Gk9Xz2AEGdFXbe5BD9xzxT9kQHduyo7SIkc
	 p+x3aSbacYgkMJYhKhpyKvcUmC0C8pztxpDucgJaTLmXE2ruLnibysKODZ3vz2GKNg
	 Ks+IKprPSUY8ohkNub7aLOSB1a927tPfXOdtsIjXBMwtgoPGVeE3ob3xRQrGfDuzd8
	 0fXZiGXMBlYd6jTAGduj9XmIlEpeUhYyohm7rdZFzH9TJkohNpOkKntbGcVJh0jPTk
	 CM9K4gzX8+UCQ==
Date: Tue, 9 Sep 2025 22:37:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250909223743.0dd33b1d@foz.lan>
In-Reply-To: <d73e68e9-321e-4685-b4fe-633cd282f526@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
	<c26160b1-f1fb-41d3-a8fe-acf589ad9f7f@infradead.org>
	<aelqggrynl7acn54tqm5ntqsynghprqtzmbkhvgf7khlbmmq6v@tf4gdfh2fvla>
	<d73e68e9-321e-4685-b4fe-633cd282f526@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 9 Sep 2025 11:20:31 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/9/25 9:18 AM, Mauro Carvalho Chehab wrote:
> > On Tue, Sep 09, 2025 at 08:57:07AM -0700, Randy Dunlap wrote: =20
> >> Hi Mauro,
> >>
> >> On 9/9/25 12:27 AM, Randy Dunlap wrote: =20
> >>> Hi Mauro,
> >>>
> >>> I have a few patch nits below, then some testing info.
> >>>
> >>>
> >>> On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote: =20
> >>>> Specially on kAPI, sometimes it is desirable to be able to
> >>>> describe global variables that are part of kAPI.
> >>>>
> >>>> Documenting vars with Sphinx is simple, as we don't need
> >>>> to parse a data struct. All we need is the variable
> >>>> declaration and use natice C domain ::c:var: to format it
> >>>> for us.
> >>>>
> >>>> Add support for it.
> >>>>
> >>>> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4=
a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> >>>> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> >>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>>> ---
> >>>>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
> >>>>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
> >>>>  2 files changed, 55 insertions(+), 1 deletion(-)
> >>>> =20
> >>
> >> =20
> >>> So, I grabbed some global data from 6-8 places in the kernel and put =
them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/k=
ernel-api.rst
> >>> like this at the end of that file:
> >>>
> >>> +
> >>> +Kernel Globals
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >>> +
> >>> +.. kernel-doc:: init/kdoc-globals-test.c
> >>> +   :identifiers:
> >>>
> >>> The html output says
> >>> "Kernel Globals"
> >>> but nothing else.
> >>>
> >>> My test files are attached. I dumbed down (simplified) a few
> >>> of the globals from fancy types to just unsigned long, but that
> >>> didn't help the output results any.
> >>>
> >>> What's happening?
> >>> Thanks.
> >>> =20
> >>
> >> My problems here could be from a patch mis-merge.
> >> Maybe your patch was against a tree or previous patches that I don't h=
ave.
> >>
> >> You could supply an updated patch or I can just wait until all
> >> the patches are synchronized for further testing.
> >> Or you could just take my sample and keep testing it. =20
> >=20
> > I applied it after my sphinx-build-wrapper patch series,
> > but it doesn't touch kernel-doc. I did a rebase just to make
> > sure, on the top of docs-next branch from Jon's tree, e.g.=20
> > on the top of:
> >=20
> >     git://git.lwn.net/linux.git docs-next
> >=20
> > e.g. applying it after:
> >=20
> >     7e5a0fe4e8ae ("doc: filesystems: proc: remove stale information fro=
m intro")
> >=20
> > Patch applied cleanly.
> >=20
> > Notice that it probably depends on some changes that Jon
> > applied for kernel-doc after -rc1.
> >=20
> > If you prefer, the patch is here at global_vars branch:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git/=
log/?h=3Dglobal_vars =20
>=20
> Yes, this is much better.
>=20
> For the simplified global data, it's very good. It produces
> 2 complaints but the html output is still good:
>=20
> linux-next-20250909/Documentation/core-api/kernel-api:435: ../init/kdoc-g=
lobals-test.c:10: WARNING: Invalid C declaration: Expected end of definitio=
n. [error at 32]
>   enum system_states system_state __read_mostly;
>   --------------------------------^
> linux-next-20250909/Documentation/core-api/kernel-api:435: ../init/kdoc-g=
lobals-test.c:20: WARNING: Invalid C declaration: Expected end of definitio=
n. [error at 25]
>   char *saved_command_line __ro_after_init;
>   -------------------------^
>=20
> I suspect that this is not a surprise to you.

Not a surprise. The C domain parser is very strict with regards to=20
C syntax.

On the above examples, __read_mostly and __ro_after_init are
macros. Sphinx has no clue about what to do with them.=20

We'll need something similar to what we do on structs and functions
to strip things like this:

	sub_prefixes =3D [
...
            (r"__deprecated +", "", 0),
            (r"__flatten +", "", 0),
            (r"__meminit +", "", 0),
...
        ]

        for search, sub, flags in sub_prefixes:
            prototype =3D KernRe(search, flags).sub(sub, prototype)

to strip them for the prototype that will be used for .. :c::var.

I guess we have three alternatives here:

1. use the simplified version only, after being converted into a pure
   C code without macros;

2. use simplified version for :c::var: and print the complete one
   ourselves (this is how structs are printed);

3. use another c domain type that would just get a name. Then
   output ourselves the var prototype, captured as-is.

IMHO, from the above, (3) is better, but looking at:

	https://www.sphinx-doc.org/en/master/usage/domains/c.html

It would likely mean we'll need to use :c:macro:

> For the non-simplified global data, a few of the global items are
> completely omitted from the html output. This is the html production:
>=20
> Kernel Globals
> dev_t ROOT_DEV;
> system root device
>=20
> enum system_states system_state __read_mostly;
> system state used during boot or suspend/hibernate/resume
>=20
> char *saved_command_line __ro_after_init;
> kernel=E2=80=99s command line, saved from use at any later time in the ke=
rnel.
>=20
> unsigned long preset_lpj;
> lpj (loops per jiffy) value set from kernel command line using =E2=80=9Cl=
pj=3DVALUE=E2=80=9D
>=20
> static atomic64_t diskseq;
> unique sequence number for block device instances
>=20
>=20
> so these are completely missing/dropped: (they have
> initializers or use DEFINE_MUTEX())

Yeah, the regex is not capturing initializers nor handling macros.
We'll need to improve it.

things like DEFINE_MUTEX() would require either a sub pattern or
some regexes to detect them.

>=20
> /**
>  * global loop_per_jiffy - calculated loop count needed to consume one ji=
ffy
>  * of time
>  */
> unsigned long loops_per_jiffy =3D (1<<12);
>=20
> // from init/version.c:
> /**
>  * global linux_proc_banner - text used from /proc/version file
>  *
>  * * first %s is sysname (e.g., "Linux")
>  * * second %s is release
>  * * third %s is version
>  */
> const char linux_proc_banner[] =3D
> 	"%s version %s"
> 	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
> 	" (" LINUX_COMPILER ") %s\n";
> //char linux_proc_banner[];
>=20
> // from init/version-timestamp.c:
> /**
>  * global linux_banner - Linux boot banner, usually printed at boot time
>  */
> const char linux_banner[] =3D
> 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
> 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
> //const char linux_banner[];
>=20
> // from net/core/rtnetlink.c:
> /**
>  * global rtnl_mutex - historical global lock for networking control oper=
ations.
>  *
>  * @rtnl_mutex is used to serialize rtnetlink requests
>  * and protect all kernel internal data structures related to networking.
>  *
>  * See Documentation/networking/netdevices.rst for details.
>  * Often known as the rtnl_lock, although rtnl_lock is a kernel function.
>  */
> static DEFINE_MUTEX(rtnl_mutex);
>=20
>=20
> It's looking good. Thanks.

Agreed.

Thanks,
Mauro

