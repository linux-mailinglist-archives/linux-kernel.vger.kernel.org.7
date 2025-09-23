Return-Path: <linux-kernel+bounces-829705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8DB97AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B358165F91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6030EF72;
	Tue, 23 Sep 2025 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUQqxsZL"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681725783F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664600; cv=none; b=q6ZV74gGJZLNO//q+W39HfD+nFINVv2qqIc3rGZDycpYdmwXwaLrkYUpmBA2y41YLIDdvNhRXTogSlZDEBTGHpg7n5OXfBHej6kRUQ5MYUvVxTZuitPotYjZboG35y78/8EkXH5eHklOQILjToXyky4od7WK+NDN6sROB68H1YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664600; c=relaxed/simple;
	bh=mXvFVuOjAEF3ZJcrTs/kyL/jzOQWNaY+j3LIfOTL/b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3PgvQMZx7dSr5sUN8F3Nivw5ZaVgGgCZJFu7QOGgnTblzWUd3bVQi3e9upHMl0jzgN8NWEYf7nFCihe2c19pZ2ufT/1QLBjSRFIqQylvawkYVdsdTqMtgiyj4Z5/HN3t3a14pB0CpCsGqfhRskphYDeVwVrUY0P2xn0vfLQl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUQqxsZL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-84b690f94bdso245392785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758664598; x=1759269398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsIqVul5TrzdGcdS0u0ousn4U4O74/bcb+sGPFZsNyk=;
        b=IUQqxsZLdnNVhWtymTksTK+1NCwEeNTUGv3aresyLmZJXXYDFOhh1dcV/Npy9POZbO
         TKQpkWGOHU02/iyEkN/9grqqhdQP7PcdqaKi+LsQdz/ql2+ACRtGKIAGkh3xYHe3VoYK
         1bdlQJbHaltQatT/Uz4z29MD3qNZAMp9cifSGGR02NccDS4rx6ld9Qr/YJQ7QcZEOLWn
         1/7NzH/9ZQwAUo3ZEzgiK880Gi1+WWygV0b2bu5mX1mec/+WQgm/kMA2LhdTfUbsJXM1
         8FNXUKvc6j+e0siEIQ8OP4kgCkg5/p2/S8P/1J1s5GSUm4gC2c9dQeFJnfppuP6ciXRB
         Mk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758664598; x=1759269398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsIqVul5TrzdGcdS0u0ousn4U4O74/bcb+sGPFZsNyk=;
        b=KlvAnnHe0VAyyUsWoAJbsL8Og/x5YKkCOKl77VjI71SDyulFIYINp2hXef/pRuEsDZ
         L7aYmrWh9KZd/DaLr0oZLncEAJoRTc2pzg4lv+xW+ISyDSs46BDoqZ7BHiXHnyTg9Kmv
         wPJtMH0UEJ6dqdwda31qEkCEyTx22JgchEOiIH1k+jw2rnP5Z7q2BaxBpFqptb2NU18y
         U1VdR3RxheYHjU184+N2PQa101k7gyIoezHdd1+DCPdGk/Ilebhd/ZcX41IFtbHW8yBx
         G7nAUPwCP2b+91GGWySEIFrw2I+fuRhkVkF9ybYCWbBx04KctavWOJ8eVZJqGixPeNNC
         eFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtVsKqQtLOL/oS2hA5rsn9jNp5zn0vZGVd5+PE+xhQDXYuuH4SBkPT7cGDyS1HKScbTgB0keK0yCX6Q70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TAVNZka6ZrEHO0Fgh0sOV+orAinWsBT1S9lC4dB0/f+cHx8l
	x2sWhTLIs2RetQ2MHxns2lHiDFHHLWB5J+6eT/LKAVz4766B5nWt/76jvq+WtUEAnYk3bICTgtd
	8s2z8UGgAyTVj1TAoy9pv00RyKeInJbM=
X-Gm-Gg: ASbGncsLowD7zIZyyKzinO6DHmxYXpg147slodvvsatIuNqt0vjU9a4+8wzEY6x/Emk
	ak2CzojM381ZcALPgZxr4HXKJnH7+Csl2h5XSLx6JY6QuFsbFikpW/MMkFRjeMkUbwIkjRpkqd+
	NxhOCwASOsyT7ZPYzBZPvBHJ7chjfH4bAiCUFgdCEH9l4prx1HgrKeAd/H4DptL94njOQqlR6yn
	95G9U91kzQ/00vpj3G0zkQKnCseweIIxvwCd5t01g==
X-Google-Smtp-Source: AGHT+IGZ2aYJhSmeR/Vq+qPj4UpUurfr8enMonGVPEnAiKZzoukE5Bl9aljg9I+ku/XMaK23RRJwT131b6anaju92hI=
X-Received: by 2002:a05:620a:1723:b0:84a:f8a2:a4e6 with SMTP id
 af79cd13be357-85173700fe4mr518628285a.44.1758664597680; Tue, 23 Sep 2025
 14:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEU-x4=Zs22b5LX_rsBVMu4BxvDfO+CZkkuWuVNaxv8mqvh9Gw@mail.gmail.com>
 <bjtev7sgmcafoysd53xrxih4nawn2dbq4odylwdglbub6td2a3@nhoxenprhjvy>
 <CAEU-x4kL45DAddmNahjR2C97+43jchpmXep++LbeP8cXLEWN-w@mail.gmail.com>
 <CAEU-x4nv3XnXchevtwN5mkVcxqnpgBobhavxZc7BjS7EgYG8Ng@mail.gmail.com>
 <c3plpgl2zsx4do2odwdeowodkkdnfqpexlwqg5a5mckyibxlge@qai35f5yeswy>
 <CAEU-x4mJiBM_zKg1DaeJkKB3W3Ay08bUTc-D3QjFjDxNiZGd0g@mail.gmail.com> <iav7hzeaarxifwxk7zlfnt6vipqkp4h4ldt634exlvcswz62gj@a7ongaeduylz>
In-Reply-To: <iav7hzeaarxifwxk7zlfnt6vipqkp4h4ldt634exlvcswz62gj@a7ongaeduylz>
From: Yinon Burgansky <yinonburgansky@gmail.com>
Date: Wed, 24 Sep 2025 00:56:25 +0300
X-Gm-Features: AS18NWBTRZRGoj3iMPuhGYLJ38hdiNJcbzwCCEFcO6dJB0f9EZaiwaFEfRuXlpw
Message-ID: <CAEU-x4k_56w17y0DOKG2TRtegGvzVKS9USAERMa1MtO+3wZivA@mail.gmail.com>
Subject: Re: Touchpad multitouch leaves ghost fingers
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:30=E2=80=AFPM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
> Got something out with https://gitlab.freedesktop.org/libevdev/udev-hid-b=
pf/-/merge_requests/204
> that seems to solve your case on the hid-recorder you provided.

Thank you so much!
The install command didn't work properly for me:
```
$ ./install.sh "*DLL0945*"
$ tree /usr/local/lib/firmware
/usr/local/lib/firmware
=E2=94=94=E2=94=80=E2=94=80 hid
    =E2=94=94=E2=94=80=E2=94=80 bpf
        =E2=94=94=E2=94=80=E2=94=80 0011-Synaptics__DLL0945.bpf.o
$ reboot
$ sudo tree /sys/fs/bpf
/sys/fs/bpf
0 directories, 0 files
```
I tried to add it manually and it seems to work now :)
```
$ sudo udev-hid-bpf add /sys/bus/hid/devices/0018:06CB:CE26.0005
/usr/local/lib/firmware/hid/bpf/0011-Synaptics__DLL0945.bpf.o
$ sudo tree /sys/fs/bpf
/sys/fs/bpf
=E2=94=94=E2=94=80=E2=94=80 hid
    =E2=94=94=E2=94=80=E2=94=80 0018_06CB_CE26_0005
        =E2=94=94=E2=94=80=E2=94=80 0011-Synaptics__DLL0945_bpf
            =E2=94=94=E2=94=80=E2=94=80 synaptics_dll0945

4 directories, 1 file
```
But I have to do it manually every time.
Not sure what's wrong, maybe the added udev rule:
```
$ cat /etc/udev/rules.d/81-hid-bpf.rules
ACTION!=3D"add|remove|bind", GOTO=3D"hid_bpf_end"
SUBSYSTEM!=3D"hid", GOTO=3D"hid_bpf_end"

# We lookup the hwdb during bind to set the property, but we don't do
anything else
IMPORT{builtin}=3D"hwdb --subsystem=3Dhid --lookup-prefix=3Dhid-bpf:"
#ACTION=3D=3D"add", ENV{.HID_BPF}=3D=3D"1",
RUN{program}+=3D"@@BINDIR@@/udev-hid-bpf add $sys$devpath"
#MARKER
ACTION=3D=3D"add", ENV{.HID_BPF}=3D=3D"1",
RUN{program}+=3D"/usr/local/bin/udev-hid-bpf add $sys$devpath"
#ACTION=3D=3D"remove", ENV{.HID_BPF}=3D=3D"1",
RUN{program}+=3D"@@BINDIR@@/udev-hid-bpf remove $sys$devpath"
#MARKER
ACTION=3D=3D"remove", ENV{.HID_BPF}=3D=3D"1",
RUN{program}+=3D"/usr/local/bin/udev-hid-bpf remove $sys$devpath"

LABEL=3D"hid_bpf_end"
```
this is the udevadm info (after reboot, it is sometimes hidraw3
sometimes hidraw4):
```
$  udevadm info --query=3Dall --name=3D/dev/hidraw4
P: /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-DLL0945:00/0=
018:06CB:CE26.0005/hidraw/hidraw4
M: hidraw4
R: 4
J: c242:4
U: hidraw
D: c 242:4
N: hidraw4
L: 0
E: DEVPATH=3D/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-DL=
L0945:00/0018:06CB:CE26.0005/hidraw/hidraw4
E: DEVNAME=3D/dev/hidraw4
E: MAJOR=3D242
E: MINOR=3D4
E: SUBSYSTEM=3Dhidraw
E: USEC_INITIALIZED=3D3980846
E: ID_VENDOR_FROM_DATABASE=3DDell Inc
E: ID_PATH=3Dpci-0000:00:15.1-platform-i2c_designware.1
E: ID_PATH_TAG=3Dpci-0000_00_15_1-platform-i2c_designware_1
E: ID_FOR_SEAT=3Dhidraw-pci-0000_00_15_1-platform-i2c_designware_1
E: TAGS=3D:seat:
E: CURRENT_TAGS=3D:seat:
```

Thank you for the quick fix, it seems to work great so far!
Yinon

