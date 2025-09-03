Return-Path: <linux-kernel+bounces-799212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72799B4287E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7F48100C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BB35CEDB;
	Wed,  3 Sep 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="dTzQeR75"
Received: from mail-lf1-f55.google.com (mail-lf1-f55.google.com [209.85.167.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAD291C11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922589; cv=none; b=oc+/8m39ZBRE0mvhvwWVPc80RWG3w2hX/49WlXTY95wLUCcjzw+XFxJnM7cVKNcECIcUKLSDk4YjfbJW8oR/oYoFzXZ6g3iYKg0zim7qfhTc3D+kP2NO9Hzo0Ld2bOZeam+ME0TRYyYkwxcraxftA+/ohxGRL3inMmRZHR9/7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922589; c=relaxed/simple;
	bh=6JHaF+zL8cO+/f/6KWeUToX5cdcN+czy74lXavCTdWU=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=nRXyO//yR/7s2+MMFrWotBfBMREjs0maxGw8NSe6IdDXhvNXD6Z4qLUcB6q5WSIqDWp68P/7VOlufpXf0mNT+Rdy9fWvysigVsy9nBZLHLtgz9HXiQV+zGT/5YKj79MBUn7slujO6gdy6CalOc4MlT5BO9UUjlcxRlehHjVnGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=dTzQeR75; arc=none smtp.client-ip=209.85.167.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-lf1-f55.google.com with SMTP id 2adb3069b0e04-55f70a5c9d1so37021e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1756922585; x=1757527385; darn=vger.kernel.org;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/WHUUJJjG4ZmzT43hqN0qqTKip8IRzXpvqRPUvDwAI=;
        b=dTzQeR75p9xRzm1Xj/yFH759MLvpnFX+rwmwVk2hGqiD3k2ff818zkpeHDCGqcw6zx
         yWr2c1TVI7nkgLo/OqMswgsAMKtSpCnD+3j/+cAkloAyCaz113DrSr3aREswZ+XmgEH0
         xwNU4BxCrmg8DkxxO/GnBkdmsWo9vuO4Lsa5Y1F+FxQRxswCXE1ENYFR37VkZgNB2L5U
         XkHaxXDsq2+Z5Nw1rqunWBzW2pzW9B7nF/A9AQx2VaCqW/5XrLFg0WLvVjpwrxfysI1G
         8Qt2OgB5ndpmaKAz25RyVAkTf6Q/5aOJZbb5wsfsIpSuTpCjNT5oZU/NUK1seogzcbvU
         yYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922585; x=1757527385;
        h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/WHUUJJjG4ZmzT43hqN0qqTKip8IRzXpvqRPUvDwAI=;
        b=V4YD+hLbUPSJz88HuaB3M9UoQsbXgD+eml/V9vfEkLs5m/zq+E8MxDoO2tzZdLSI1+
         nTY48FweDkEHul7sPUTya4iWcwN05tTNbt2JtdgF5FjmHZF6iIyp1olzkCC8HEUvWHdb
         AFRuosc/Kt10docDZsBDH48vck0fXIHOo2YuDDTZFDdZFO6bqZ/k2D0RuYAQ+ltu+4Az
         Dy8gBogciu8v0Bp6fKDcBkaGro6fjbqcFCpAfqCaDMoKaQzh1xyHkGklG+jYsSy5D/ie
         cbS3WDjh3p3xhoj7XEWlsnjJQBc4ajQFiEITQVCQ3LCOVCqOHh9lYcFJbPxH+za8Q5Y/
         xmtA==
X-Forwarded-Encrypted: i=1; AJvYcCVB6P/F/72YOxLjNPjocY0VcoRuEr5AYCiEqqPZo/MHR3im3yK0Ojt9bVO2qkuKMrrhUZmdYrQO4SdFOEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAiYmuRKinJ0ahKshbiTgV64YnjXEqnnjTMkDz43mMZmg7EZNX
	o2yjiYh0oGaotJIRVgUZAC55XXY+1Sjb/vU/uJCqH0NJxYOBx4irQZfKorxzdiTvsuR02ZbL/vb
	ZVSKQEakCWnnBvw==
X-Google-Smtp-Source: AGHT+IE3mzmtDRTXIfB1t8CegbyNiBK8jHk6Wlevzs6ODKfpo96m0TmB11MaDvEqjAjppmQoEjn7JDxDBw==
X-Received: by 2002:a05:6512:eaa:b0:55f:6f76:418 with SMTP id 2adb3069b0e04-55f70948ae4mr5260142e87.44.1756922585020;
        Wed, 03 Sep 2025 11:03:05 -0700 (PDT)
X-Google-Already-Archived: Yes
X-Google-Already-Archived-Group-Id: 38d67f2e3d
X-Google-Doc-Id: 16dcd8551d61
X-Google-Thread-Id: d2ff43d5e72296fd
X-Google-Message-Url: http://groups.google.com/a/aisle.com/group/disclosure/msg/16dcd8551d61
X-Google-Thread-Url: http://groups.google.com/a/aisle.com/group/disclosure/t/d2ff43d5e72296fd
X-Google-Web-Client: true
Date: Wed, 3 Sep 2025 11:03:02 -0700 (PDT)
From: Disclosure <disclosure@aisle.com>
To: Disclosure <disclosure@aisle.com>
Cc: Paul Moore <paul@paul-moore.com>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>,
	"eparis@redhat.com" <eparis@redhat.com>,
	"security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stanislav Fort <stanislav.fort@aisle.com>
Message-Id: <8e395d8a-2875-4f78-9118-facd5de09a30n@aisle.com>
In-Reply-To: <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com>
References: <20250902110049.4437-1-disclosure@aisle.com>
 <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
 <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
 <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in
 audit_compare_dname_path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9588_62209620.1756922582396"

------=_Part_9588_62209620.1756922582396
Content-Type: multipart/alternative; 
	boundary="----=_Part_9589_1803177371.1756922582396"

------=_Part_9589_1803177371.1756922582396
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Yes, please go ahead and change the Signed-off-by to:
Signed-off-by: Stanislav Fort <stanislav.fort@aisle.com>

Sorry for the slight delay and thanks for the quick review, testing, and=20
for adding the Fixes tag.

Best wishes,
Stanislav Fort
Aisle Research

On Wednesday, September 3, 2025 at 6:16:59=E2=80=AFPM UTC+3 Paul Moore wrot=
e:

> On Tue, Sep 2, 2025 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <
> stanislav.fort@aisle.com> wrote:
> > > >
> > > > When a watch on dir=3D/ is combined with an fsnotify event for a
> > > > single-character name directly under / (e.g., creating /a), an
> > > > out-of-bounds read can occur in audit_compare_dname_path().
> > > >
> > > > The helper parent_len() returns 1 for "/". In=20
> audit_compare_dname_path(),
> > > > when parentlen equals the full path length (1), the code sets p =3D=
=20
> path + 1
> > > > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > > > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> > > >
> > > > Fix this by adding a pathlen > 0 check to the while loop condition
> > > > to prevent the out-of-bounds access.
> > > >
> > > > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > > > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > > > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> >
> > I also just noticed a disconnect on the email address. I can leave
> > the Reported-by email as disclosure@, but do you mind if I convert
> > your Signed-off-by email to stanislav.fort@?
>
> Stanislav, are you okay with changing your sign-off email to
> stanislav.fort@aisle.com?
>
> --
> paul-moore.com
>

------=_Part_9589_1803177371.1756922582396
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,<br /><br />Yes, please go ahead and change the Signed-off-by to:<b=
r />Signed-off-by: Stanislav Fort &lt;stanislav.fort@aisle.com&gt;<div><br =
/></div><div>Sorry for the slight delay and thanks for the quick review, te=
sting, and for adding the Fixes tag.<br /><br />Best wishes,<br />Stanislav=
 Fort</div><div>Aisle Research<br /><br /></div><div class=3D"gmail_quote">=
<div dir=3D"auto" class=3D"gmail_attr">On Wednesday, September 3, 2025 at 6=
:16:59=E2=80=AFPM UTC+3 Paul Moore wrote:<br/></div><blockquote class=3D"gm=
ail_quote" style=3D"margin: 0 0 0 0.8ex; border-left: 1px solid rgb(204, 20=
4, 204); padding-left: 1ex;">On Tue, Sep 2, 2025 at 2:52=E2=80=AFPM Paul Mo=
ore &lt;<a href=3D"mailto:paul@paul-moore.com" target=3D"_blank" rel=3D"nof=
ollow">paul@paul-moore.com</a>&gt; wrote:
<br>&gt; On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore &lt;<a href=3D"m=
ailto:paul@paul-moore.com" target=3D"_blank" rel=3D"nofollow">paul@paul-moo=
re.com</a>&gt; wrote:
<br>&gt; &gt; On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort &lt;<a =
href=3D"mailto:stanislav.fort@aisle.com" target=3D"_blank" rel=3D"nofollow"=
>stanislav.fort@aisle.com</a>&gt; wrote:
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; When a watch on dir=3D/ is combined with an fsnotify eve=
nt for a
<br>&gt; &gt; &gt; single-character name directly under / (e.g., creating /=
a), an
<br>&gt; &gt; &gt; out-of-bounds read can occur in audit_compare_dname_path=
().
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; The helper parent_len() returns 1 for &quot;/&quot;. In =
audit_compare_dname_path(),
<br>&gt; &gt; &gt; when parentlen equals the full path length (1), the code=
 sets p =3D path + 1
<br>&gt; &gt; &gt; and pathlen =3D 1 - 1 =3D 0. The subsequent loop then de=
references
<br>&gt; &gt; &gt; p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds r=
ead.
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; Fix this by adding a pathlen &gt; 0 check to the while l=
oop condition
<br>&gt; &gt; &gt; to prevent the out-of-bounds access.
<br>&gt; &gt; &gt;
<br>&gt; &gt; &gt; Reported-by: Stanislav Fort &lt;<a href=3D"mailto:disclo=
sure@aisle.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</a>=
&gt;
<br>&gt; &gt; &gt; Suggested-by: Linus Torvalds &lt;<a href=3D"mailto:torva=
lds@linuxfoundation.org" target=3D"_blank" rel=3D"nofollow">torvalds@linuxf=
oundation.org</a>&gt;
<br>&gt; &gt; &gt; Signed-off-by: Stanislav Fort &lt;<a href=3D"mailto:disc=
losure@aisle.com" target=3D"_blank" rel=3D"nofollow">disclosure@aisle.com</=
a>&gt;
<br>&gt;
<br>&gt; I also just noticed a disconnect on the email address.  I can leav=
e
<br>&gt; the Reported-by email as disclosure@, but do you mind if I convert
<br>&gt; your Signed-off-by email to stanislav.fort@?
<br>
<br>Stanislav, are you okay with changing your sign-off email to
<br><a href=3D"mailto:stanislav.fort@aisle.com" target=3D"_blank" rel=3D"no=
follow">stanislav.fort@aisle.com</a>?
<br>
<br>--
<br><a href=3D"http://paul-moore.com" target=3D"_blank" rel=3D"nofollow" da=
ta-saferedirecturl=3D"https://www.google.com/url?hl=3Den&amp;q=3Dhttp://pau=
l-moore.com&amp;source=3Dgmail&amp;ust=3D1757008935730000&amp;usg=3DAOvVaw2=
gD0EldePvK_pOB1-q7UBc">paul-moore.com</a>
<br></blockquote></div>
------=_Part_9589_1803177371.1756922582396--

------=_Part_9588_62209620.1756922582396--

