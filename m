Return-Path: <linux-kernel+bounces-868157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7EC04803
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D42D3B9C99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A6248F51;
	Fri, 24 Oct 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ufAsWq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741882153D2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287654; cv=none; b=eWK4Wf9tiTQhl80Hf7gENkEXSAgQ/F/3FZS4sFOimh4h+ZzO1qvmoLWF+0dU8QZyRaksw/0LHOctRCSpcPjhmFlELuUtjDbL3YP0Nf3B+kWnogyyUIO/G64Sj0HZYT1XhEdeUNFFJ1pVNbhuSgM2O9BL/tK6pj8dE119Z/wcuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287654; c=relaxed/simple;
	bh=nq+oiVe5YqPb3/5QcFPeTVB30vsSr5MzXhr2M/4TcNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUj4wpAOwpgiYJvmreV2PunGx4DbgdnbcFV1U5stBEqJi4VyyteffAxMA0fdvB9juEdoMobjgH6n9xyrOz9qWx84VSce1HDK/khhlLWXS0B+ZyX14N0KXkLTO6ujLZ5mUTJoRwjaX/cRNt6cbChw1hSzbK+y8D3JiMtv+40aAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8ufAsWq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592f0102eceso198667e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761287650; x=1761892450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3ssCwx72PEwqyzGAYKC0Rgmja1yVikvEbQurdHkdhw=;
        b=S8ufAsWqRNVc8h+y7OMBKvlz+BumyKX2gapuG6UISps+S15rrPRLDbEZSFgZSiKogO
         08YPwgk+qdAaXoyi0FA2PcExYXQvStfYaBUEqpOBYAeOo7uFwNKjpQSDvctENBCKH+Dt
         6eE41R9ejStJ6wiob276adjx4wfWOjZhrM1TCyFLYU1kFRmQKaD0JVJv7NONIh5vTf3T
         1LPYdSkTLq9ve8R6F+XZXiVnZLPx7EW7m2sNu4ebCuClod7JJEAPJQpbUahEf62Xazav
         lSx4z6rQydBvIE1MtMvXq4+T+8fmExQ8MfXW8M4x2+rRzNLWYKPfjhSOxto2V0D83L2a
         Z9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761287650; x=1761892450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3ssCwx72PEwqyzGAYKC0Rgmja1yVikvEbQurdHkdhw=;
        b=EIwfacyEGO1URCtEPRhtlgQawkxqyWKshP1rMjd7wNSpkU70rcBA4R11idMofuL3C6
         aIwzu6Tedm4SogfXzunmeRw5jAcNzods4nUTi5u6OoSWZvjrT2fW+4c8VK+lckcdbqSh
         7iHceDMTOjoErPX3cNEBWYEfGL6piE+aodPRDSSBXNwRkvP4r93QDcQ9bPtwqvRgF778
         bAg2fj7wRNki4njrcEFlbDK8HEc1hFZg686CasNUUAp/vPxl2srYPmLOHNmHFRi9o/2s
         67Ucml02nGghAQLlutZFu0RW4Q35l2zq7itQWvz4GEQKVipZn59lGqeHSlHtyhPmfZqf
         nQyQ==
X-Gm-Message-State: AOJu0YyNgNQYUJPmz9BxOnlrojZPOy7+hg87iIhrf3dmeh2bN1ffU6oZ
	wAg/uo2UHPvcHZqroGoEtU/VrLdARmtA0LTwzkQLzeBfWo3iLBMq5fJP0r5X4l5evjpDoM672B9
	RWzve30KjP3T1Iz6MKN5aTD3S9sZxwAUxiZ3/
X-Gm-Gg: ASbGncuie3TjzwHtizbpBhQFfmoAZbv8QFhMQC+fVM19NSQTSEQ0ta4TYiC4DTKyjfB
	yo0nx1AY3hU2eo24ZrAcFLeaUXGqD3v8hunb5Q52GqiXyKk4wwMTCDhIqqnwkT1AtEZvC6jE1mT
	6yD0ezf4L58Ym/1Peddi4IW0eXDxq2IcmKwJQ1b1rZLdJgKVQNFxKSF1Bjbuz/K4wiyoUZMbIoY
	SkgxONnE/mBZQj5WiDJAHyvY2SjZAepMPPSSZJjlyR8PWvjK5DtoYBT4XKzeGsZGne7P2tupP1+
	h7CoJUoUbSRjvKCyXwU2YeplJuDz7OdUblZuP6kBwflgYZTo5c0NGFMyrEsYXA==
X-Google-Smtp-Source: AGHT+IHKGs6MYC2tc4lSujS8ppeo9xjNb44fCM4GeZAMj+QZR/SUrzjNkN0/Qp3oeqrEF6B6WU0i/zjySwmVBwyTyPQ=
X-Received: by 2002:a05:6512:3c82:b0:592:fdbf:4488 with SMTP id
 2adb3069b0e04-592fdbf4516mr121679e87.6.1761287649459; Thu, 23 Oct 2025
 23:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMz+-CNTx59R=xw9UQVDUSoE16pqPx3y-EzJT8z0HiF-=qAC_A@mail.gmail.com>
 <68fa6d24.a70a0220.3bf6c6.007f.GAE@google.com>
In-Reply-To: <68fa6d24.a70a0220.3bf6c6.007f.GAE@google.com>
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Fri, 24 Oct 2025 12:03:55 +0530
X-Gm-Features: AWmQ_bnbR1NWHgnMCmHU3fGrpCH-LZrpqAByZMJYxPvTEVxOaGDeMeUabl9LgLw
Message-ID: <CAMz+-CPXOmOGTUXzSKO_fHKsDu_NT5SswMheeA_T3HuBNLf11w@mail.gmail.com>
Subject: Re: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
To: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000b1a5b70641e1bc24"

--000000000000b1a5b70641e1bc24
Content-Type: multipart/alternative; boundary="000000000000b1a5b60641e1bc22"

--000000000000b1a5b60641e1bc22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Thu, Oct 23, 2025 at 11:30=E2=80=AFPM syzbot <
syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/sctp/input.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         ab431bc3 Merge tag 'net-6.18-rc3' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dd101e12bccd4095460e7
> compiler:
> patch:
> https://syzkaller.appspot.com/x/patch.diff?x=3D12cec3e2580000
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/68fa6d24.a70a0220.3bf6c6=
.007f.GAE%40google.com
> .
>

--000000000000b1a5b60641e1bc22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test</div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 23, 2025 at 11:=
30=E2=80=AFPM syzbot &lt;<a href=3D"mailto:syzbot%2Bd101e12bccd4095460e7@sy=
zkaller.appspotmail.com">syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Hello,<br>
<br>
syzbot tried to test the proposed patch but the build/boot failed:<br>
<br>
failed to apply patch:<br>
checking file net/sctp/input.c<br>
patch: **** unexpected end of file in patch<br>
<br>
<br>
<br>
Tested on:<br>
<br>
commit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ab431bc3 Merge tag &#39;net-6.18-r=
c3&#39; of git://git.kernel...<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Dbbd3e7f3c2e28265" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Dbbd3e7f3c2e28265</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3Dd101e1=
2bccd4095460e7" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3Dd101e12bccd4095460e7</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
patch:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appsp=
ot.com/x/patch.diff?x=3D12cec3e2580000" rel=3D"noreferrer" target=3D"_blank=
">https://syzkaller.appspot.com/x/patch.diff?x=3D12cec3e2580000</a><br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;syzkaller-bugs&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">syzkaller-bugs+unsubscribe@googlegroups.com</a>.<br>
To view this discussion visit <a href=3D"https://groups.google.com/d/msgid/=
syzkaller-bugs/68fa6d24.a70a0220.3bf6c6.007f.GAE%40google.com" rel=3D"noref=
errer" target=3D"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/6=
8fa6d24.a70a0220.3bf6c6.007f.GAE%40google.com</a>.<br>
</blockquote></div>

--000000000000b1a5b60641e1bc22--
--000000000000b1a5b70641e1bc24
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-net-sctp-fix-KMSAN-uninit-value-in-sctp_inq_pop.patch"
Content-Disposition: attachment; 
	filename="0001-net-sctp-fix-KMSAN-uninit-value-in-sctp_inq_pop.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mh4h6j2v0>
X-Attachment-Id: f_mh4h6j2v0

RnJvbSBiMTI5ODIxNWY4NzNjMWU5ODg1MGVlMTNhMzEyZjQyMmYxNWYxM2ZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW5nYW5hdGggViBOIDx2bnJhbmdhbmF0aC4yMEBnbWFpbC5j
b20+CkRhdGU6IFRodSwgMjMgT2N0IDIwMjUgMTU6MTQ6MjAgKzA1MzAKU3ViamVjdDogW1BBVENI
XSBuZXQ6IHNjdHA6IGZpeCBLTVNBTiB1bmluaXQtdmFsdWUgaW4gc2N0cF9pbnFfcG9wCgpGaXgg
YW4gaXNzdWUgZGV0ZWN0ZWQgYnkgc3l6Ym90OgoKS01TQU4gcmVwb3J0ZWQgYW4gdW5pbml0aWFs
aXplZC12YWx1ZSBhY2Nlc3MgaW4gc2N0cF9pbnFfcG9wCndoaWxlIHBhcnNpbmcgYW4gU0NUUCBj
aHVuayBoZWFkZXIgcmVjZWl2ZWQgZnJtYSBhIGxvY2FsbHkgdHJhbnNtaXR0ZWQgcGFja2V0LgoK
QlVHOiBLTVNBTjogdW5pbml0LXZhbHVlIGluIHNjdHBfaW5xX3BvcAoKc2tiIGFsbG9jYXRlZCBp
biBzY3RwX3BhY2tldF90cmFuc21pdCgpIGNvbnRhaW4gdW5pbml0aWFsaXplZCBieXRlcy4Kc2N0
cCB0cmFuc21pdCBwYXRoIHdyaXRlcyBvbmx5IHRoZSBuZWNlc3NhcnkgaGVhZGVyIGFuZCBjaHVu
ayBkYXRhLAp0aGUgcmVjZWl2ZSBwYXRoIHJlYWQgZnJvbSB1aW5pdGlhbGl6ZWQgcGFydHMgb2Yg
dGhlIHNrYiwgdHJpZ2dlcmluZyBLTVNBTi4KCkZpeCB0aGlzIGJ5IGV4cGxpY2l0bHkgemVyb2lu
ZyB0aGUgc2tiIHBheWxvYWQgYXJlYSBhZnRlciBhbGxvY2F0aW9uCmFuZCByZXNlcnZhdGlvbiwg
ZW5zdXJpbmcgYWxsIGZ1dHVyZSByZWFkcyBmcm9tIHRoaXMgcmVnaW9uIGFyZSBmdWxseQppbml0
aWFsaXplZC4KClJlcG9ydGVkLWJ5OiBzeXpib3QrZDEwMWUxMmJjY2Q0MDk1NDYwZTdAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQpUZXN0ZWQtYnk6IHN5emJvdCtkMTAxZTEyYmNjZDQwOTU0NjBl
N0BzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkZpeGVzOiBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9ZDEwMWUxMmJjY2Q0MDk1NDYwZTcKU2lnbmVkLW9mZi1ieTogUmFu
Z2FuYXRoIFYgTiA8dm5yYW5nYW5hdGguMjBAZ21haWwuY29tPgotLS0KIG5ldC9zY3RwL2lucHV0
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9uZXQvc2N0cC9pbnB1dC5jIGIvbmV0L3NjdHAvaW5wdXQuYwppbmRleCA3
ZTk5ODk0Nzc4ZDQuLmUxMTllNDYwY2NkZSAxMDA2NDQKLS0tIGEvbmV0L3NjdHAvaW5wdXQuYwor
KysgYi9uZXQvc2N0cC9pbnB1dC5jCkBAIC0xOTAsNyArMTkwLDcgQEAgaW50IHNjdHBfcmN2KHN0
cnVjdCBza19idWZmICpza2IpCiAJCWdvdG8gZGlzY2FyZF9yZWxlYXNlOwogCW5mX3Jlc2V0X2N0
KHNrYik7CiAKLQlpZiAoc2tfZmlsdGVyKHNrLCBza2IpKQorCWlmIChza19maWx0ZXIoc2ssIHNr
YikgfHwgc2tiLT5sZW4gPCBzaXplb2Yoc3RydWN0IHNjdHBfY2h1bmtoZHIpKQogCQlnb3RvIGRp
c2NhcmRfcmVsZWFzZTsKIAogCS8qIENyZWF0ZSBhbiBTQ1RQIHBhY2tldCBzdHJ1Y3R1cmUuICov
Ci0tIAoyLjQzLjAKCg==
--000000000000b1a5b70641e1bc24--

