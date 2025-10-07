Return-Path: <linux-kernel+bounces-843833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13792BC05CF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F6A4F0274
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B3225760;
	Tue,  7 Oct 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="l+3F2tAj"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0321FF45;
	Tue,  7 Oct 2025 06:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819583; cv=none; b=P+gL7fW4St+W/ccJFn0x5qxzmnhXgsT4q0pamv/R7fYc0fZ78ILI3Zu3qwZpABsRbSWlXw71f0NXewlUkjeT5U5bey9rrYPQODZOpVclQB4uhwGCok2okG6hTLIek8mMdg6wthA5IbWAYZj5O7ag5KcHgpif1k4WZk33V4QErT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819583; c=relaxed/simple;
	bh=8MXcsHwutcf+qsZ/rNq6dfPMRguOGwRckvbM3PtJDW4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=J6ydvIAesgSy0dwFAA0Vbq9NGrQp9diOtbDap4dk02OHogZL3I2XzDPwyOXtIAJOkfcKEYrqly/VTjj4rCGAZSxXLqd8PDax0VP0KoNGkvFoWS/7HTNr3HLhx0fBXWZB/f7ybCprz/VmZ2mkJwMt9md2Vz8/N2MLkZYLXjqevns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=l+3F2tAj; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id EECCF409F9;
	Tue,  7 Oct 2025 08:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1759819170; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DNAXiQNHZKvLPmuSvHGH4xfiW4QLvC5MPDpiztpmQtc=;
	b=l+3F2tAjUyIOhktb/XyLvEnDUXX2dOrNO/bgw39WI2UIIax0uB4BvAQRK8p0JNEekq55gj
	A8tyodsL5OdWkTXLCMkne4mq1+V0HhnwVQJlXbL52CfEfLq3xFmziVM7Qjvpkz2BXqtz2v
	4UcbUmqyk7gdRdRfFYdsYbDqCeq1Q4WaJ5d6YVKyTcPGnPYdXPI2sNVg2dDQ/S9HRXCmGr
	JdHqffjocrzlvo1F2j0iLaoWltxVKgON9Mmd0nYUVd0XQ2e4zFPBbhosWOLi0Cl6jXOmRd
	9wELyLkk0duy1rwEenQ2a1BC8ITrgiwXbpb87Z/ODqSHfTsbPrjO1slgS2YYuA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <37f2603e-8c51-4f92-a7af-0e60cd577004@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
 <53eabe34a310ea9c74315fa09a604e4a@manjaro.org>
 <b01ed528-8b29-4a6a-bdff-88f2e3b5dd2e@gmail.com>
 <115da845d9161e6ecfa67cf189b84aa8@manjaro.org> <37f2603e-8c51-4f92-a7af-0e60cd577004@gmail.com>
Date: Tue, 07 Oct 2025 08:39:29 +0200
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Ondrej Jirman" <megi@xff.cz>, =?utf-8?q?Leonardo_G=2E_Trombetta?= <lgtrombetta@gmx.com>
To: "Rudraksha Gupta" <guptarud@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <eae79f9b-7127-6808-6a46-57ebc079ca50@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 0/5] Upstreaming Pinephone Pro Patches
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Rudraksha,

On Sunday, October 05, 2025 06:55 CEST, Rudraksha Gupta <guptarud@gmail=
.com> wrote:
> > Thanks for improving the patch descriptions in the v4 of this serie=
s.
> > I just went quickly through the v4 and it looks much better.
> >
> > It could be said that the new patch descriptions are now a bit too
> > verbose, in the sense that the test procedures and their results co=
uld
> > be summed up a bit better in prose, instead of providing the "raw"
> > inputs and outputs.=C2=A0 However, it's still better to have those,=
 than
> > not to have anything.=C2=A0 Writing good prose is a skill that usua=
lly
> > requires learning and practice.
>=20
> Awesome! I was hoping that others would comment on the testing I've d=
one=20
> (especially for the accelerometer and magnetometer patches) as I can'=
t=20
> tell if userspace is wrong or if my testing/conclusion is wrong. Mobi=
le=20
> Linux is very early stages at the moment, and I suspect the Pinephone=20
> and Pinephone Pro were used as reference devices with Megi's downstre=
am=20
> kernel. Wrong mount matrices in the downstream kernel might be affect=
ing=20
> userspace. This means that with the corrected mount matrices in this=20
> patch series, userspace is slightly broken (eg. since I fixed the=20
> accelerometer, the screen in Phosh and KDE Plasma are upside down. I=20
> suspect KDE's Kompass and Leonardo's compass app might be the same if=20
> I'm changing the mount matrix for the magnetometer). This is why I=20
> decided to showcase the raw values in my testing. If my testing is=20
> incorrect, please feel free to let me know.
>=20
> I think I will leave my testing in the commits itself this time. If t=
he=20
> mount matrices are correct based on my testing, it will probably be=20
> helpful in the future in identifying why downstream is slightly broke=
n.

I'll prepare and send to the mailing list a couple of patches that
will also adjust the mount-matrix values, so you might want to have
a look at those patch descriptions I'll prepare, as an inspiration
how could such information be presented in prose.

I'll also review your patches, to make sure that the mount-matrix
values are correct, hopefully around the end of this week, or next
week.  I'm having some issues with email, which I must resolve first.
(I'm actually hoping that this message won't come through as HTML,
as a result of those issues).

> > You haven't done anything technically wrong, but the way you submit=
ted
> > the v2 and v3 made them feel a bit like you picked those patches fr=
om
> > some random place and submitted them to the mailing list without re=
ally
> > understanding the subject matter.=C2=A0 In other words, it's the co=
ntributor's
> > job to convince everyone else that the submitted patches are fine t=
o
> > become accepted, and the v2 and v3 simply lacked that.
>=20
> That's fair. I was under the assumption I had to keep the patches mos=
tly=20
> in its original form.
>=20
> > I wonder how would some forge prevent "spamming"?=C2=A0 It isn't ab=
out the
> > possible "spamming", but about the act of submitting different vers=
ions,
> > which would be present regardless of the way they'd be submitted, a=
nd
> > the reviewers would need to be aware (i.e. "spammed") of them anywa=
y.
>=20
> At least with Gitlab & Codeberg, a lot of the notifications can be mu=
ted=20
> (I believe updates to pull requests is one of them) and pipelines can=
 be=20
> created to ensure that formatting is correct and that the proper sub=20
> maintainers are notified automagically. In my opinion, b4 just brings=20
> some of the forge's functionalities into an email based workflow, but=20
> will have to fight it's own problems such as:=20
> https://social.kernel.org/notice/AypvdTWyAs5km0Gc3k. I don't mean to=20
> detract from it; it is very commendable what Konstantin Ryabitsev is =
doing.

When it comes to submitting patches and their different versions,
reviewers have to be notified about each and every version, which
means that muting the notifications or ignoring some patch versions
simply isn't an option.  Even fully ignoring the patches that one
isn't interested in isn't a great option, despite sounding good,
because leaving out such parts makes one less insightful about
the subsystem they're contributing to.

Of course, the associated level of interest depends on one being
a "drive-by" contributor or being in for the long term, but for
the former different options exist to help with their periodic
contributions, such as the b4 or GitGitGadget.

You're right that the automagic features of forges may help with
setting up the lists of recipients and whatnot, but that's just
offloading of the complexity elsewhere, in hope that the automagic
part will work flawlessly, which is hardly the case with highly
complex projects, such as the Linux kernel. In other words, the
mailing-list based workflow does have its deficiencies, but it
leaves the contributors in full control, without relying on some
automagic things to do everything perfectly instead.

When it comes to formatting and whatnot, I'm sure you know that
there's already scripts/checkpatch.pl.


