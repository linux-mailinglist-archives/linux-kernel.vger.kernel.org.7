Return-Path: <linux-kernel+bounces-864801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D33BFB938
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E59C40629E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCA32B9BC;
	Wed, 22 Oct 2025 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsvJ8Hg9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8C326D55
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131617; cv=none; b=ZaMbpvlNA7a/P1PR2b1CIa3ffQVjo6hTdyu0J/WT9EeH7hbqiAtsfIh8Z9zD4vOV4/YSvm7UiCBCdsF/E3gyHxIseI5Ctbz0mBxVGfj9LDvX7N1JBbjrvrsLKgksnjgmUOg3O5vdcRohW4GTFHIm0FZ2zy/A176BM7D5kuY9V/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131617; c=relaxed/simple;
	bh=nuYCmpYw6+y3bWyZjcIxVPObe9H9zvkT5K56ifIh0x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST0dFoCDUQPLmC2mtW6/8ou/UtUO4i1ed40xcBJI4TkCJP/+z3FTzY+V9e8QBRribpDzYvu+36o7ySd7J7TtrMtsLyWUDMXOfAi+YynAhMhpre5ib3pMPyMhVzM+wSjrosmPb3x/UiP4qaHHdmY1+xlnOnEr+b7EA8RrgLqnFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsvJ8Hg9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57b35d221e2so1741619e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761131613; x=1761736413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UdVEJx55lgLnd2ShRc4xcisIL+LORUSU5X0KzXDE3lQ=;
        b=HsvJ8Hg9V+TQRiI3s54HzMU+FSUUwqBmbP4PMZb2H7LBA6go6bJEZwz2mRnICbAbRS
         +JRq9AHuMtqXpGgu6HMa2TkdMJVSvAIrIUAARprYjXiYckr6i7gZo50Why7r1l3ocbQV
         iDTjdleYP6J80F7qW+j1JX31M2CWHpHIpju0NF8vVbl8tULJ5fPnFEL6uOK7fZfQQCsu
         ybadf7UhEBcnsXhxeb5XeEAJJyDYmOs5tbimYHz6vL8Jtvz5xd9WbLdjIwweAkbKgkl6
         lXiKoS1CSdv+KzKrGu9+u/Mk/WWR6vFMnhX2HEArQ0/PkC42LAvN4b+Y2mvS3OLuCWYY
         WBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131613; x=1761736413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdVEJx55lgLnd2ShRc4xcisIL+LORUSU5X0KzXDE3lQ=;
        b=S74hjtBgeQNY2XK+55GfxeJN12v+JbBd9RslvbKXmUuYPb4fmdGs0qEAafn4Mybr9l
         sMYESEfmgqRuPmBZBVQKgik24uBp4d/PeBwsN42+asOjanbuk06FmTb2fE6ZW5AorKt6
         kJbQ1UMgJ+TlwhHu/qXYwGQ3mT+JKuIhr7Y8WPHHvb1u2dLy4qXuIwZjIjgPGqAaS2dU
         oU8NUqTRxWnlctfyqu8hs9KXVlAGAudDEsdDxMG9iTt7Wrc1MSiUj1L/ZU4mXb4SWvCb
         MQr16dgeytm/NE+hZQK74E0m0RI1ZaZ6yUWT9AjjVmekjd6AMiSlpxKKjpmmwdflcChg
         lIbw==
X-Gm-Message-State: AOJu0YwT3qr1W1DsLFs4EWtpKMGDgA8E+I0qRlR3zfIOoOZ+krdGEIgz
	3zryr6O1PGkzgo4cDPdEIxdwGG/sYoMJAcpdzu5MtzTcAC1MjgsAHKbmQe+PVNMdNRKdBb5Cxxg
	hiCjXhZeMoBYLmyvWZDjIGbENe5krNX0=
X-Gm-Gg: ASbGnctUbY2WEk8hCXY2wBeU4IJQRC36Q49TuLkEMJImLxeXWDHCNadU5ORiGZTwlZ0
	w5ONU5ePOXn5IMySizOgZbgDiMJB0Eftu/c+S+Qg56Kyt/+t0ZURB/69FwAfxZXujeEN82pyEqa
	re1ul2hp/jJf02TygmRooXfs30vvPReAwYnvGwLTMq+Tx+IdOI0eYeqHsff7fYFvRim9kBlMWaT
	pTNudI46XZ977AFd81QKxjSEWEP0ChgLLgohrQ/D9LEzfWTVcLTpqj+PA8bjG4ndalbvOCbVMab
	rTcoPF0bDHIwZvsxNoHLCkR11UuXC/CPdwcpgDznI+cn/QBo5lY=
X-Google-Smtp-Source: AGHT+IG+UD97rzhSy0meM6nQQWQVGMtAN6Y85OZWiEeuaKZHRufkWQwiH+lhx5G7+F2Ue+V+m1hqlTZyKp73DtO6iDQ=
X-Received: by 2002:a05:6512:1304:b0:581:e52a:3dee with SMTP id
 2adb3069b0e04-591ea2cc502mr1104520e87.2.1761131612930; Wed, 22 Oct 2025
 04:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMz+-CNpOeZG5hbHmarKRtfWD8kcR2s_ma=k9F3dJRFw_XFq5g@mail.gmail.com>
 <68f8b7ca.a70a0220.3bf6c6.0014.GAE@google.com>
In-Reply-To: <68f8b7ca.a70a0220.3bf6c6.0014.GAE@google.com>
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Wed, 22 Oct 2025 16:43:18 +0530
X-Gm-Features: AS18NWDsWpX7FSXkLpAB0t1c95-ndPz42_thT_WRtLKuWsL3z1KHeukivuZEdyI
Message-ID: <CAMz+-CMyk977BbuBbKSu1tQOB+4=g0srcqb-EoEfKXE7exAH3w@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
To: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000311bab0641bd6886"

--000000000000311bab0641bd6886
Content-Type: multipart/alternative; boundary="000000000000311ba90641bd6884"

--000000000000311ba90641bd6884
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test


On Wed, Oct 22, 2025 at 4:24=E2=80=AFPM syzbot <
syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> net/sctp/inqueue.c:123:34: error: use of undeclared identifier 'gfp'
>
>
> Tested on:
>
> commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dd101e12bccd4095460e7
> compiler:       Debian clang version 20.1.8
> (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.=
1.8
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=3D1044ce7c580000
>
>
>

--000000000000311ba90641bd6884
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<div><br></div></div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct =
22, 2025 at 4:24=E2=80=AFPM syzbot &lt;<a href=3D"mailto:syzbot%2Bd101e12bc=
cd4095460e7@syzkaller.appspotmail.com">syzbot+d101e12bccd4095460e7@syzkalle=
r.appspotmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hello,<br>
<br>
syzbot tried to test the proposed patch but the build/boot failed:<br>
<br>
net/sctp/inqueue.c:123:34: error: use of undeclared identifier &#39;gfp&#39=
;<br>
<br>
<br>
Tested on:<br>
<br>
commit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0552c5071 Merge tag &#39;vfio-v6.18=
-rc3&#39; of <a href=3D"https://github." rel=3D"noreferrer" target=3D"_blan=
k">https://github.</a>..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Dbbd3e7f3c2e28265" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Dbbd3e7f3c2e28265</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3Dd101e1=
2bccd4095460e7" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3Dd101e12bccd4095460e7</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 20.1.8 (++20250708=
063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8<br>
patch:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appsp=
ot.com/x/patch.diff?x=3D1044ce7c580000" rel=3D"noreferrer" target=3D"_blank=
">https://syzkaller.appspot.com/x/patch.diff?x=3D1044ce7c580000</a><br>
<br>
<br>
</blockquote></div>

--000000000000311ba90641bd6884--
--000000000000311bab0641bd6886
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-sctp-initalize-the-chunk-variable.patch"
Content-Disposition: attachment; 
	filename="0001-sctp-initalize-the-chunk-variable.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mh1wa2pl0>
X-Attachment-Id: f_mh1wa2pl0

RnJvbSBkZGMyZDkwZGFiYTE0ZmJhNzIzNWI0ZDhkYWE5NDUwMDUwNDg4ODliIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW5nYW5hdGggViBOIDx2bnJhbmdhbmF0aC4yMEBnbWFpbC5j
b20+CkRhdGU6IFdlZCwgMjIgT2N0IDIwMjUgMTQ6MzE6MTYgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBzY3RwOiBpbml0YWxpemUgdGhlIGNodW5rIHZhcmlhYmxlCgpTaWduZWQtb2ZmLWJ5OiBSYW5n
YW5hdGggViBOIDx2bnJhbmdhbmF0aC4yMEBnbWFpbC5jb20+Ci0tLQogbmV0L3NjdHAvaW5xdWV1
ZS5jIHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvbmV0L3NjdHAvaW5xdWV1ZS5jIGIvbmV0L3NjdHAvaW5xdWV1ZS5j
CmluZGV4IDVjMTY1MjE4MTgwNS4uN2YxM2QxM2YxNzk2IDEwMDY0NAotLS0gYS9uZXQvc2N0cC9p
bnF1ZXVlLmMKKysrIGIvbmV0L3NjdHAvaW5xdWV1ZS5jCkBAIC0xMjAsNyArMTIwLDkgQEAgc3Ry
dWN0IHNjdHBfY2h1bmsgKnNjdHBfaW5xX3BvcChzdHJ1Y3Qgc2N0cF9pbnEgKnF1ZXVlKQogCS8q
IFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgd2UgYXJlIHNhZmUgdG8gcHJvY2VzcyB0aGUgY2h1bmtz
CiAJICogYXQgdGhpcyB0aW1lLgogCSAqLwotCisJY2h1bmsgPSBremFsbG9jKHNpemVvZigqY2h1
bmspLCBHRlBfQVRPTUlDKTsKKwlpZiAoIWNodW5rKQorCQlyZXR1cm4gTlVMTDsKIAljaHVuayA9
IHF1ZXVlLT5pbl9wcm9ncmVzczsKIAlpZiAoY2h1bmspIHsKIAkJLyogVGhlcmUgaXMgYSBwYWNr
ZXQgdGhhdCB3ZSBoYXZlIGJlZW4gd29ya2luZyBvbi4KLS0gCjIuNDMuMAoK
--000000000000311bab0641bd6886--

