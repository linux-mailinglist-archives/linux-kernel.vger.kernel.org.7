Return-Path: <linux-kernel+bounces-872247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F1CC0FB38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AED264E293B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734331690A;
	Mon, 27 Oct 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ii+GwD6R"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764972E1F08;
	Mon, 27 Oct 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586703; cv=none; b=bSVOSl5vU2I1FyIrBd9KaITBXE+PiIHc9+M2JEqysfhxfjkJBzdUiACMN99ivUi/YFjO4AnBq6Uax+JhklzurOK42qiRAfupyuk2tNCPMiF6QlUMF26kvErY/zmw1yMnDPTkTMVWqsOsLl9Mt39XMGdt9Ff+rLoiE5aHMlAMdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586703; c=relaxed/simple;
	bh=GvhDZlnk50CCjacgyYud/c9r8wNqk8fRi43gqbwVcFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwDCl7C6unrBW0mmG59ITMIgyAGvepBo+E1Eak86/gyAVo4iMMLKfIgARt69Ccfcjpfr12ZLAT4K46J5cifnpBTSvxm3Zwp/FTeHZaS5a4Bv0oqW6pemUmCHVuh/+6M4LWRRwaZnhYT4gW2TJTVYBcWqVkDvVHzy0UfKh33uA0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ii+GwD6R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A65B40AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761586700; bh=0qTu7Z36JdCJpGOQY+Of2paQEfbW5A6xh4FYCaBA0hU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ii+GwD6REbnFJXsMN+jacVjV7o6+uv0+36TAnnD5depQOlOIfn+Bs29mm34Gqvmqd
	 fNi+mCZCkiXvgmuMdoeBojIDciP+REeIB297m7OPO9iDSuU6fmdoYlvPR5FMJzuJ2r
	 uEKIm+JRvvD/om7k8m+PgYwZ6C0SWakJe0lPg+CRWvTLmWNeyz0OW/HMvteCP435sn
	 k2xXA9oVfkbR3g/RvRFAD2cFQbKGcKf+aC7cbA2IKw0rTFY+cZcbpSfZJIUuTTy6d1
	 rFCZvdJsmQkRehdFX+Oq9VYoRIpPt1MRgfd8DEhH1BCRFp8FGvVBwPKSEyAbcQmYJE
	 6UmrlShWeoeeA==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5A65B40AF3;
	Mon, 27 Oct 2025 17:38:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/30] docs: reporting-issues: add proper appendix
In-Reply-To: <c3d92d4e74557bfff3627d8ceb6a9911612af52a.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <c3d92d4e74557bfff3627d8ceb6a9911612af52a.1761481839.git.linux@leemhuis.info>
Date: Mon, 27 Oct 2025 11:38:19 -0600
Message-ID: <87ikg0nt2s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Turn the "Why some bugs remain unfixed and some report are ignored"
> section into a proper appendix while improving it slightly.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 102 +++++++++---------
>  1 file changed, 54 insertions(+), 48 deletions(-)

Some comments below, but I have to ask: do we really need this section
at all?  Getting people to read long documents is hard, and this adds a
fair amount of length to, essentially, say that the kernel is an
open-source program like any other and its developers are not required
to address your problems...?

> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentati=
on/admin-guide/reporting-issues.rst
> index 9676ba85e1b73c..745e698cb6be8b 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -1693,60 +1693,66 @@ for the subsystem where the issue seems to have i=
ts roots; CC the mailing list
>  for the subsystem as well as the stable mailing list (stable@vger.kernel=
.org).
>=20=20
>=20=20
> -Why some issues won't get any reaction or remain unfixed after being rep=
orted
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Appendix: additional background information
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> -When reporting a problem to the Linux developers, be aware only 'issues =
of high
> -priority' (regressions, security issues, severe problems) are definitely=
 going
> -to get resolved. The maintainers or if all else fails Linus Torvalds him=
self
> -will make sure of that. They and the other kernel developers will fix a =
lot of
> -other issues as well. But be aware that sometimes they can't or won't he=
lp; and
> -sometimes there isn't even anyone to send a report to.
> +.. _unfixedbugs_repiapdx:

This label is seemingly unused?

> -This is best explained with kernel developers that contribute to the Lin=
ux
> -kernel in their spare time. Quite a few of the drivers in the kernel were
> -written by such programmers, often because they simply wanted to make th=
eir
> -hardware usable on their favorite operating system.
> +Why some bugs remain unfixed and some report are ignored

report*s*

> +--------------------------------------------------------
> +
> +When reporting a problem to the Linux developers, be aware that they are=
 only
> +obliged to fix regressions, security issues, and severe problems. Develo=
pers,
> +maintainers, or, if all else fails, Linus Torvalds himself will make sur=
e of
> +that. They will fix a lot of other issues as well, but sometimes they ca=
n't or
> +won't help -- and sometimes there isn't even anyone to send a report to.
> +
> +This situation is best explained using kernel developers that contribute=
 to the

"using" is weird; "highlighting" or some such?

> +Linux kernel in their spare time. Quite a few of the drivers in the kern=
el were
> +written by such programmers; often they simply wanted to make the
> +hardware they owned usable on their favorite operating system.

This really kind of reinforces the old "developed in their parents'
basement" stuff we used to hear; again, do we really need this?

>  These programmers most of the time will happily fix problems other people
> -report. But nobody can force them to do, as they are contributing volunt=
arily.
> -
> -Then there are situations where such developers really want to fix an is=
sue,
> -but can't: sometimes they lack hardware programming documentation to do =
so.
> -This often happens when the publicly available docs are superficial or t=
he
> -driver was written with the help of reverse engineering.
> -
> -Sooner or later spare time developers will also stop caring for the driv=
er.
> -Maybe their test hardware broke, got replaced by something more fancy, o=
r is so
> -old that it's something you don't find much outside of computer museums
> -anymore. Sometimes developer stops caring for their code and Linux at al=
l, as
> -something different in their life became way more important. In some cas=
es
> -nobody is willing to take over the job as maintainer =E2=80=93 and nobod=
y can be forced
> -to, as contributing to the Linux kernel is done on a voluntary basis. Ab=
andoned
> -drivers nevertheless remain in the kernel: they are still useful for peo=
ple and
> -removing would be a regression.
> +report. But nobody can force them to do so, as they are contributing
> +voluntarily.
> +
> +There are also situations where such developers would like to fix issues,
> +but can't: They might lack programming documentation to do so or hardwar=
e to
> +test. The former can happen when the publicly available docs are superfi=
cial or
> +when a driver was written with the help of reverse engineering.
> +
> +Sooner or later, spare-time developers usually stop caring for the drive=
r.
> +Maybe their test hardware broke, was replaced by something more fancy, or
> +became so old that it is something you don't find much outside of comput=
er
> +museums anymore. Other times developers also stop caring when
> +something different in life becomes more important to them. Then sometim=
es
> +nobody is willing to take over the job as maintainer -- and nobody else =
can be
> +forced to, as contributing is voluntary. The code nevertheless often sta=
ys
> +around, as it is useful for people; removing it would also cause a regre=
ssion,
> +which is not allowed in Linux.
>=20=20
>  The situation is not that different with developers that are paid for th=
eir
> -work on the Linux kernel. Those contribute most changes these days. But =
their
> -employers sooner or later also stop caring for their code or make its
> -programmer focus on other things. Hardware vendors for example earn thei=
r money
> -mainly by selling new hardware; quite a few of them hence are not invest=
ing
> -much time and energy in maintaining a Linux kernel driver for something =
they
> -stopped selling years ago. Enterprise Linux distributors often care for a
> -longer time period, but in new versions often leave support for old and =
rare
> -hardware aside to limit the scope. Often spare time contributors take ov=
er once
> -a company orphans some code, but as mentioned above: sooner or later the=
y will
> -leave the code behind, too.
> -
> -Priorities are another reason why some issues are not fixed, as maintain=
ers
> -quite often are forced to set those, as time to work on Linux is limited.
> -That's true for spare time or the time employers grant their developers =
to
> -spend on maintenance work on the upstream kernel. Sometimes maintainers =
also
> -get overwhelmed with reports, even if a driver is working nearly perfect=
ly. To
> -not get completely stuck, the programmer thus might have no other choice=
 than
> -to prioritize issue reports and reject some of them.
> -
> -But don't worry too much about all of this, a lot of drivers have active
> +work on the upstream Linux kernel. Those contribute the most changes the=
se days.
> +But their employers set the priorities. And those sooner or later stop c=
aring
> +for some code or make their
> +employees focus on other things. Hardware vendors, for example, earn the=
ir money
> +mainly by selling new hardware -- they thus often are not much intereste=
d in
> +investing much time and energy in maintaining a Linux kernel driver for =
a chip
> +they stopped selling years ago. Enterprise Linux distributors often care=
 for a
> +longer time period, but in new versions might set support for old and ra=
re
> +hardware aside to limit the scope, too. Often spare-time contributors ta=
ke over
> +once employed developers orphan some code, but as mentioned earlier: Soo=
ner or
> +later they will usually leave the code behind, too.
> +
> +Priorities are another reason why some issues are not fixed, as develope=
rs
> +quite often are forced to set those: The spare-time of volunteers or the=
 time
> +employers allot for upstream Linux kernel work is often limited. Sometim=
es
> +developers are also flooded with good and bad reports, even if a driver =
is
> +working well. To
> +not get completely stuck, the programmers might have no other choice than
> +to prioritize bug reports and ignore some.
> +
> +But do not worry too much about all of this, a lot of drivers have active
>  maintainers who are quite interested in fixing as many issues as possibl=
e.

Otherwise OK, I guess, but my overall question stands: do we really need
this text?

Thanks,

jon

