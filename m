Return-Path: <linux-kernel+bounces-749459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BBB14EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BC74E64E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C18B1A0BF3;
	Tue, 29 Jul 2025 13:44:57 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366429D0D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796697; cv=none; b=GX0tN3N1h5xWWNg6pG8dlgk5B2gjPCoohiYIa7JpA5rYE7vLTWjxrYeT7cwnkbDWuJm5il5XAnA0Hc46QK2Glw1PMOhgUTr/GCO7Pv7xMedwWdcZeRFgxGZGlhT/SyO8XUYsa6xzRRAb2IUDl0U5VzPiyqmTvsGQadMEZB7S8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796697; c=relaxed/simple;
	bh=4hBBxUmTkrjxsBMjSk8pQJTgAvfA4TWiqUFF7D9Iyu8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsZub/VVhc5mln3F4K1UVK5b4Hcm/5FpnDjvnAcWX93YcmuI/8e+r+vlUBrKP9N4edYAi+7JtDzkBWJqzVr668O/HAkj7fIFyesvLBlYbYPqavaAqAPYIdZMqLAE0A72qHigorFomAvJrmFvdk35JKNPPuayTR/2sKFQFHPdTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 90F801A05BA;
	Tue, 29 Jul 2025 13:44:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 185EB2F;
	Tue, 29 Jul 2025 13:44:45 +0000 (UTC)
Message-ID: <2a2bb7879e22208205fbb8f9bc56fb3c882bc307.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace
 tools
From: Joe Perches <joe@perches.com>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 29 Jul 2025 06:44:45 -0700
In-Reply-To: <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com>
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
		 <61958a3cca40fc9a42b951c68c75f138cab9212e.camel@perches.com>
	 <CAO9wTFhCb7gDEo+q2SAZcn2KdUyVe-fG1E4bR_+US9k2J9DOnw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 185EB2F
X-Stat-Signature: qoor5ww7qf1s4s1o4bcamg87er3qayxt
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+LGL7A/INkG8rCM5a99SUSzVMd+9SkE54=
X-HE-Tag: 1753796685-125964
X-HE-Meta: U2FsdGVkX1+dRgzzUsrNIE4SBXvRz8LbcqBfJi9aHsY2pxsabmWEeIJFHdFRy+2V4zz35RalfLZS0FIrSaPx9jWmPWSepiFF7HZoQhKe9UZY3hs9BN/Ynt7uaIjyGx0d/S2NuXjfZnp160NaQFB5QZ7SIjsaTfce8G3Wm/emqFHTNvYsf7TqllcCeIinwGfFcFit+++GzFEMmnnx8wE+V+u4P92IZcvQimqdjulGTJtrDgA/xLytN9kikSbryfMjNbIQNJ0WC3c3Nym82iIFBu541yEvLnsS+JIyRC1RPT1kSwZB623ZTebtM3fYXFPWdoxG3Yxb9VqQTny7e1uwhrs+K+/RZC1RP6wOl6wkegM188h16fXO0vXm7XGwZsSZyFxGSkLZ0bnQ+1FNq299rQ==

On Tue, 2025-07-29 at 17:15 +0530, Suchit Karunakaran wrote:
> On Tue, 29 Jul 2025 at 15:54, Joe Perches <joe@perches.com> wrote:
> >=20
> > On Sun, 2025-07-27 at 18:20 +0530, Suchit Karunakaran wrote:
> > > The checkpatch.pl script currently warns against the use of strcpy,
> > > strlcpy, and strncpy, recommending strscpy as a safer alternative.
> > > However, these warnings are also triggered for code under tools/ and
> > > scripts/, which are userspace utilities where strscpy is not availabl=
e.
> > > This patch suppresses these warnings for files in tools/ and scripts/=
.
> > >=20
> > > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > >=20
> > > Changes since v1:
> > > - Create is_userspace function to check if the file is in userspace
> > >   directories
> >=20
> > the changelog bit should go below the --- line
> >=20
> > > ---
> >=20
> > This
>=20
> Sorry I will change it in the next version.
>=20
> > >  scripts/checkpatch.pl | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -7019,20 +7019,24 @@ sub process {
> > >  #                    }
> > >  #            }
> > >=20
> > > +        sub is_userspace {
> > > +            my ($file) =3D @_;
> > > +            return ($file =3D~ m@\btools/@ || $file =3D~ m@\bscripts=
/@);
> >=20
> > All other sub uses start in without indentation.
> > Please move this next to other sub blocks.
> >=20
>=20
> Yup will do it.
>=20
> > Please do a git ls-files -- '*tools/' and see if too many other
> > files are matched, especially the Documentation/ ones.
> >=20
>=20
> I didn't quite understand this. Could you please elaborate?

The search pattern m@\btools/@ matches files other than the
first level tools/ directory.

It also matches Documentation/tools/

Perhaps using m@^tools/@ to match only the first level tools
and change $file to $realfile to make it clear it's not
a/tools or b/tools like the diff filenames.


