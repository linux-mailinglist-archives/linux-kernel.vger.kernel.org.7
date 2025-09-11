Return-Path: <linux-kernel+bounces-812530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43742B5394F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5957BB028
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28135A28E;
	Thu, 11 Sep 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2qV43CF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5E3570C5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608084; cv=none; b=B9qOB10y13nAASgR3PeemkKSdUCmfWyoiPTQx0KaTq+MZxzn8DpRJosslk47ppcXVQOJaf1eanboCWjYBCKjOzmG3OlRriRpBIvTvLg2Ct+ur/wQ23SIIuyA4XIoG1dyW26DXTiTShEgTSyPtn85C9xNFkHnR4NHpV0GqP28S5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608084; c=relaxed/simple;
	bh=PaNYqLES+8TcjAZ4DYYe8T3TYtq2QhmV/2MX5pgF3sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKAqjzlSTwozN2pJKFzDyO1OnSfpDZxuKbimbndOPGM1/D73kZJfQdGoMnawN/XPTWGl1oQixJis0fXi9f++QpSH3psx9WIBXJhJil/4wpWSV54p8LBVX9n3PvrO0QBhXM8y1XMK5ZVJWn8xb7LGnZBwl/1dcFdIR3tEFWtaefw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2qV43CF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042eb09948so200626166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608080; x=1758212880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PaNYqLES+8TcjAZ4DYYe8T3TYtq2QhmV/2MX5pgF3sI=;
        b=F2qV43CFvqaUgnTiP3XXUWcZwywPdztjEdCMSE3/Lo+MLontJjsQS86X6aYmAu0HU4
         ILkZr7u9MwQyshLYkUpr/SeikbRAMMO9MjEkR33jnE+rLXOLn0XeHt8N/zblincxivOd
         6JdoD9K/zaYY4NqcczjF+M0wjI7FnjrBdUH3DlYKO2+ucxLr3E5aQyzi2u+R2yRcBma6
         6h/fKK3kBl5+CdwYmqC2pUsx/pieVQx/BV5aO9BpwxZ+xr86ucf89WbgcewMjYbrntO9
         o9Ct6AYSCPZI3BTb75uQE755XvqNYWFvxK/epPfUfwJ1zWKuIy5nKKtZ9BNkyq8FVp2P
         JmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608080; x=1758212880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaNYqLES+8TcjAZ4DYYe8T3TYtq2QhmV/2MX5pgF3sI=;
        b=u72SF0p6qo6hlVAjywWrfg8JRD8E/L9hc3EUm6FN8GqDtRfjMKwNNJjF0yW9EkCmdl
         h8zxgCgZtqhtLObgvTS7B90A5f7tHJsekNq089WB7Xzl9/+w0p1Y9Cqq6dcDlM5QgLx5
         hw2q+Uxib9/783WmQDYn25JzcgHXBvhQAJcezho+H9Inwpes+cGS65D3oMOPUfl0Kpab
         sMG5m94IehyobvcebEH3L2qMEobeqMbSIfRXFKzdibBLEK0XlaKMEXhRONbabHdS4zDR
         lHdCd1ag7XpH0ypK2pALY2PYVzqQW7nS1W6thFzoxPQB2plfuVVKTsY/E5J6zVCYZxyx
         gcoQ==
X-Gm-Message-State: AOJu0YyIyAAKe9oB/2W16H84W1K3E+huTED+JXNZ6q/E5IXYrEHWECCK
	f3rxfXcwSInbjwvN8G/JVeggeMCCvFLDAjBIATMSkAjraK6f0YEcuExknB/GEcoGZvwjN3PEqIW
	H88TQTeArjssrCyQLqHbvqqHs5Pyh772INnqu7XU=
X-Gm-Gg: ASbGncswxAhyFH67kAoF0QaDdEjIHKCrncWaMaL9aCNq/r+JPu6Huf9Uuf0t5FZR5Bk
	b33jIInNBZPdb43Sz69Qgx+W9KC5g4gJBsplTikdXrowxTyKcg+yL6KrcD5eeqz0Of8PG/3Ja+A
	5tbfnI0/GiYEK5Fu5Pk9dNovHzk0QDV0uYjIGCk+CSuZcelkBWNalb1a4BZhBi+q+cT4JX0tiNE
	VISdisn/FZ7ZprEGvk=
X-Google-Smtp-Source: AGHT+IHIUfRCg4HgZEAPl1pLnDgGxTCcYg4y1vERTYIV1l7klIgYuKNjKv8paoLeF+9XlvK+mIDd2jNI3ZpigJDmwCs=
X-Received: by 2002:a17:907:804:b0:b04:8701:731b with SMTP id
 a640c23a62f3a-b04b14528eemr1973276566b.20.1757608079460; Thu, 11 Sep 2025
 09:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFYUeKswEh54fM5bFEvOfFLfc_GunKwEgr2uND=j-pxixQ@mail.gmail.com>
In-Reply-To: <CANypQFYUeKswEh54fM5bFEvOfFLfc_GunKwEgr2uND=j-pxixQ@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Fri, 12 Sep 2025 00:27:23 +0800
X-Gm-Features: AS18NWCzIBxXnQT60gDOjeymLzDxHWaoT1L-41kL_5u3YXETyoFpBvjaBNApUzc
Message-ID: <CANypQFYGt3c1eoeytCzw3RKLw+cbtDDPJy8UM=aj8HQMC8MWmA@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] WARNING in remove_vm_area
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	security@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000003bd727063e890506"

--0000000000003bd727063e890506
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Apologies for the oversight in my previous email. I neglected to
include the formatted report.

Please find the formatted report (formatted by syz-symbolize) attached
to this email. This should be easier to read and analyze.

Sorry for any inconvenience.

Jiaming Zhang <r772577952@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Linux kernel developers and maintainers:
>
> We are writing to report a kernel WARNING in remove_vm_area,
> discovered with our modified version of syzkaller.
>
> This issue was initially found in kernel v6.17-rc5 (commit
> 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c). Unfortunately, we do not
> have a stable C or Syz program to reproduce this warning. We are
> actively analyzing the root cause and working to create a reliable
> reproducer, which we will share as soon as it is available.
>
> Attached are the kernel console output and the .config file for your
> analysis. Please let us know if any further information would be
> helpful.
>
> Best regards,
> Jiaming Zhang

--0000000000003bd727063e890506
Content-Type: application/octet-stream; name="report.log"
Content-Disposition: attachment; filename="report.log"
Content-Transfer-Encoding: base64
Content-ID: <f_mffmfunj0>
X-Attachment-Id: f_mffmfunj0

VHJ5aW5nIHRvIHZmcmVlKCkgYmFkIGFkZHJlc3MgKGZmZmZlOGZmYWM2NzMzOWEpDQpXQVJOSU5H
OiBDUFU6IDAgUElEOiA0NjI4MCBhdCBtbS92bWFsbG9jLmM6MzI4MiByZW1vdmVfdm1fYXJlYSsw
eDJmMy8weDMwMCBtbS92bWFsbG9jLmM6MzI4MQ0KTW9kdWxlcyBsaW5rZWQgaW46DQpDUFU6IDAg
VUlEOiAwIFBJRDogNDYyODAgQ29tbTogc3l6LjUuMzgyMyBOb3QgdGFpbnRlZCA2LjE3LjAtcmM1
ICMxIFBSRUVNUFQoZnVsbCkgDQpIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQw
RlggKyBQSUlYLCAxOTk2KSwgQklPUyAxLjE1LjAtMSAwNC8wMS8yMDE0DQpSSVA6IDAwMTA6cmVt
b3ZlX3ZtX2FyZWErMHgyZjMvMHgzMDAgbW0vdm1hbGxvYy5jOjMyODENCkNvZGU6IDQ4IDgzIGM0
IDIwIDViIDQxIDVjIDQxIDVkIDQxIDVlIDQxIDVmIDVkIGU5IDA0IDA4IDcwIDA5IGNjIGU4IGFl
IGY4IGFjIGZmIDkwIDQ4IGM3IGM3IGEwIDc4IDk2IDhiIDQ4IDg5IGRlIGU4IDNlIDFiIDcwIGZm
IDkwIDwwZj4gMGIgOTAgOTAgZWIgY2EgMGYgMWYgODAgMDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAg
OTAgOTAgOTAgOTAgOTANClJTUDogMDAxODpmZmZmYzkwMDAzNjI3YWQ4IEVGTEFHUzogMDAwMTAy
NDYNClJBWDogNDBhZmJhMzZlNDJmNDgwMCBSQlg6IGZmZmZlOGZmYWM2NzMzOWEgUkNYOiAwMDAw
MDAwMDAwMDgwMDAwDQpSRFg6IGZmZmZjOTAwMWY4ODcwMDAgUlNJOiAwMDAwMDAwMDAwMDdmZmZm
IFJESTogMDAwMDAwMDAwMDA4MDAwMA0KUkJQOiBmZmZmZThmZmFjNjczMzlhIFIwODogZmZmZjg4
ODAyYjgyNDI1MyBSMDk6IDFmZmZmMTEwMDU3MDQ4NGENClIxMDogZGZmZmZjMDAwMDAwMDAwMCBS
MTE6IGZmZmZlZDEwMDU3MDQ4NGIgUjEyOiAxZmZmZmQxZmY1OGNlNjcwDQpSMTM6IDFmZmZmZDFm
ZjU4Y2U2NzIgUjE0OiBmZmZmZThmZmFjNjczMzlhIFIxNTogZmZmZmU4ZmZhYzY3MzMzMA0KRlM6
ICAwMDAwN2YyZWFmODAyNjQwKDAwMDApIEdTOmZmZmY4ODgwOThlMWYwMDAoMDAwMCkga25sR1M6
MDAwMDAwMDAwMDAwMDAwMA0KQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KQ1IyOiAwMDAwMDAxMTBjMzQ0OGZmIENSMzogMDAwMDAwMDA0YWRjODAwMCBD
UjQ6IDAwMDAwMDAwMDA3NTJlZjANClBLUlU6IDgwMDAwMDAwDQpDYWxsIFRyYWNlOg0KIDxUQVNL
Pg0KIHZmcmVlKzB4NjMvMHg0MDAgbW0vdm1hbGxvYy5jOjM0MTQNCiByY3VfcGVuZGluZ19leGl0
KzB4NmI4LzB4N2IwIGZzL2JjYWNoZWZzL3JjdV9wZW5kaW5nLmM6NjMwDQogYmNoMl9mc19idHJl
ZV9rZXlfY2FjaGVfZXhpdCsweDkwMC8weGEzMCBmcy9iY2FjaGVmcy9idHJlZV9rZXlfY2FjaGUu
Yzo4MDkNCiBfX2JjaDJfZnNfZnJlZSBmcy9iY2FjaGVmcy9zdXBlci5jOjYxNiBbaW5saW5lXQ0K
IGJjaDJfZnNfcmVsZWFzZSsweDJhMy8weDgzMCBmcy9iY2FjaGVmcy9zdXBlci5jOjY2Nw0KIGtv
YmplY3RfY2xlYW51cCBsaWIva29iamVjdC5jOjY4OSBbaW5saW5lXQ0KIGtvYmplY3RfcmVsZWFz
ZSBsaWIva29iamVjdC5jOjcyMCBbaW5saW5lXQ0KIGtyZWZfcHV0IGluY2x1ZGUvbGludXgva3Jl
Zi5oOjY1IFtpbmxpbmVdDQoga29iamVjdF9wdXQrMHgyMjgvMHg0ODAgbGliL2tvYmplY3QuYzo3
MzcNCiBkZWFjdGl2YXRlX2xvY2tlZF9zdXBlcisweGJjLzB4MTMwIGZzL3N1cGVyLmM6NDc0DQog
Y2xlYW51cF9tbnQrMHg0MjUvMHg0YzAgZnMvbmFtZXNwYWNlLmM6MTM3NQ0KIHRhc2tfd29ya19y
dW4rMHgxZDQvMHgyNjAga2VybmVsL3Rhc2tfd29yay5jOjIyNw0KIHJlc3VtZV91c2VyX21vZGVf
d29yayBpbmNsdWRlL2xpbnV4L3Jlc3VtZV91c2VyX21vZGUuaDo1MCBbaW5saW5lXQ0KIGV4aXRf
dG9fdXNlcl9tb2RlX2xvb3ArMHhlYy8weDExMCBrZXJuZWwvZW50cnkvY29tbW9uLmM6NDMNCiBl
eGl0X3RvX3VzZXJfbW9kZV9wcmVwYXJlIGluY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5o
OjIyNSBbaW5saW5lXQ0KIHN5c2NhbGxfZXhpdF90b191c2VyX21vZGVfd29yayBpbmNsdWRlL2xp
bnV4L2VudHJ5LWNvbW1vbi5oOjE3NSBbaW5saW5lXQ0KIHN5c2NhbGxfZXhpdF90b191c2VyX21v
ZGUgaW5jbHVkZS9saW51eC9lbnRyeS1jb21tb24uaDoyMTAgW2lubGluZV0NCiBkb19zeXNjYWxs
XzY0KzB4MmIzLzB4M2IwIGFyY2gveDg2L2VudHJ5L3N5c2NhbGxfNjQuYzoxMDANCiBlbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQpSSVA6IDAwMzM6MHg3ZjJlYWU5YmQ0
NGUNCkNvZGU6IDQ4IGM3IGMwIGZmIGZmIGZmIGZmIGViIGFhIGU4IDJlIDIzIDAwIDAwIDY2IDJl
IDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFmIDQwIDAwIGYzIDBmIDFlIGZhIDQ5IDg5IGNh
IGI4IGE1IDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcg
YzEgYTggZmYgZmYgZmYgZjcgZDggNjQgODkgMDEgNDgNClJTUDogMDAyYjowMDAwN2YyZWFmODAx
ZGE4IEVGTEFHUzogMDAwMDAyNDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwYTUNClJBWDogZmZm
ZmZmZmZmZmZmZmZlYyBSQlg6IDAwMDAwMDAwMDAwMGZlODggUkNYOiAwMDAwN2YyZWFlOWJkNDRl
DQpSRFg6IDAwMDAwMDAwMjAwMGZlYzAgUlNJOiAwMDAwMDAwMDIwMDBmZjAwIFJESTogMDAwMDdm
MmVhZjgwMWUwMA0KUkJQOiAwMDAwN2YyZWFmODAxZTQwIFIwODogMDAwMDdmMmVhZjgwMWU0MCBS
MDk6IDAwMDAwMDAwMDAwMDAwMDANClIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAw
MDAwMDAyNDYgUjEyOiAwMDAwMDAwMDIwMDBmZWMwDQpSMTM6IDAwMDAwMDAwMjAwMGZmMDAgUjE0
OiAwMDAwN2YyZWFmODAxZTAwIFIxNTogMDAwMDAwMDAyMDAwZmY0MA0KIDwvVEFTSz4=
--0000000000003bd727063e890506--

